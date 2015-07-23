From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: Lockdep warning in VFIO using v4.2-rc3
Date: Thu, 23 Jul 2015 11:07:37 -0600
Message-ID: <1437671257.5211.45.camel@redhat.com>
References: <20150723091558.GJ10969@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20150723091558.GJ10969-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Thu, 2015-07-23 at 11:15 +0200, Joerg Roedel wrote:
> Hi Alex,
> 
> I stumbled over this lockdep warning yesterday while testing my VT-d
> changes. It looks like one code path is taking the locks:
> 
> 	group->device_lock
> 	driver_lock
> 	pci_bus_sem
> 
> while another path is taking
> 
> 	pci_bus_sem
> 	group->device_lock
> 
> which could lead to a deadlock. I attach the full warning, can you
> please have a look?

Hi Joerg,

Thanks for the report.  I think I found it.  I'll do further testing
myself, but would appreciate if you're able to see if this clears the
problem.  Thanks,

Alex

commit 8a8efa7943533495abfbfd18d316db64477136eb
Author: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Date:   Thu Jul 23 10:15:28 2015 -0600

    vfio: Fix lockdep issue
    
    When we open a device file descriptor, we currently have the
    following:
    
    vfio_group_get_device_fd()
      mutex_lock(&group->device_lock);
        open()
        ...
        if (ret)
          release()
    
    If we hit that error case, we call the backend driver release path,
    which for vfio-pci looks like this:
    
    vfio_pci_release()
      vfio_pci_disable()
        vfio_pci_try_bus_reset()
          vfio_pci_get_devs()
            vfio_device_get_from_dev()
              vfio_group_get_device()
                mutex_lock(&group->device_lock);
    
    Whoops, we've stumbled back onto group.device_lock and created a
    deadlock.  There's a low likelihood of ever seeing this play out, but
    obviously it needs to be fixed.  To do that we can use a reference to
    the vfio_device for vfio_group_get_device_fd() rather than holding the
    lock.  There was a loop in this function, theoretically allowing
    multiple devices with the same name, but in practice we don't expect
    such a thing to happen and the code is already aborting from the loop
    with break on any sort of error rather than coninuing and only parsing
    the first match anyway, so the loop was effectively unused anyway.
    
    Signed-off-by: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
    Reported-by: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>

diff --git a/drivers/vfio/vfio.c b/drivers/vfio/vfio.c
index 2fb29df..563c510 100644
--- a/drivers/vfio/vfio.c
+++ b/drivers/vfio/vfio.c
@@ -689,6 +689,23 @@ struct vfio_device *vfio_device_get_from_dev(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(vfio_device_get_from_dev);
 
+static struct vfio_device *vfio_device_get_from_name(struct vfio_group *group,
+						     char *buf)
+{
+	struct vfio_device *device;
+
+	mutex_lock(&group->device_lock);
+	list_for_each_entry(device, &group->device_list, group_next) {
+		if (!strcmp(dev_name(device->dev), buf)) {
+			vfio_device_get(device);
+			break;
+		}
+	}
+	mutex_unlock(&group->device_lock);
+
+	return device;
+}
+
 /*
  * Caller must hold a reference to the vfio_device
  */
@@ -1198,53 +1215,53 @@ static int vfio_group_get_device_fd(struct vfio_group *group, char *buf)
 {
 	struct vfio_device *device;
 	struct file *filep;
-	int ret = -ENODEV;
+	int ret;
 
 	if (0 == atomic_read(&group->container_users) ||
 	    !group->container->iommu_driver || !vfio_group_viable(group))
 		return -EINVAL;
 
-	mutex_lock(&group->device_lock);
-	list_for_each_entry(device, &group->device_list, group_next) {
-		if (strcmp(dev_name(device->dev), buf))
-			continue;
+	device = vfio_device_get_from_name(group, buf);
+	if (!device)
+		return -ENODEV;
 
-		ret = device->ops->open(device->device_data);
-		if (ret)
-			break;
-		/*
-		 * We can't use anon_inode_getfd() because we need to modify
-		 * the f_mode flags directly to allow more than just ioctls
-		 */
-		ret = get_unused_fd_flags(O_CLOEXEC);
-		if (ret < 0) {
-			device->ops->release(device->device_data);
-			break;
-		}
+	ret = device->ops->open(device->device_data);
+	if (ret) {
+		vfio_device_put(device);
+		return ret;
+	}
 
-		filep = anon_inode_getfile("[vfio-device]", &vfio_device_fops,
-					   device, O_RDWR);
-		if (IS_ERR(filep)) {
-			put_unused_fd(ret);
-			ret = PTR_ERR(filep);
-			device->ops->release(device->device_data);
-			break;
-		}
+	/*
+	 * We can't use anon_inode_getfd() because we need to modify
+	 * the f_mode flags directly to allow more than just ioctls
+	 */
+	ret = get_unused_fd_flags(O_CLOEXEC);
+	if (ret < 0) {
+		device->ops->release(device->device_data);
+		vfio_device_put(device);
+		return ret;
+	}
 
-		/*
-		 * TODO: add an anon_inode interface to do this.
-		 * Appears to be missing by lack of need rather than
-		 * explicitly prevented.  Now there's need.
-		 */
-		filep->f_mode |= (FMODE_LSEEK | FMODE_PREAD | FMODE_PWRITE);
+	filep = anon_inode_getfile("[vfio-device]", &vfio_device_fops,
+				   device, O_RDWR);
+	if (IS_ERR(filep)) {
+		put_unused_fd(ret);
+		ret = PTR_ERR(filep);
+		device->ops->release(device->device_data);
+		vfio_device_put(device);
+		return ret;
+	}
+
+	/*
+	 * TODO: add an anon_inode interface to do this.
+	 * Appears to be missing by lack of need rather than
+	 * explicitly prevented.  Now there's need.
+	 */
+	filep->f_mode |= (FMODE_LSEEK | FMODE_PREAD | FMODE_PWRITE);
 
-		vfio_device_get(device);
-		atomic_inc(&group->container_users);
+	atomic_inc(&group->container_users);
 
-		fd_install(ret, filep);
-		break;
-	}
-	mutex_unlock(&group->device_lock);
+	fd_install(ret, filep);
 
 	return ret;
 }
