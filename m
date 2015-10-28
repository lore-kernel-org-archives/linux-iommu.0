From: "Michael S. Tsirkin" <mst-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] vfio: Include No-IOMMU mode
Date: Wed, 28 Oct 2015 23:46:52 +0200
Message-ID: <20151028234124-mutt-send-email-mst@redhat.com>
References: <20151028211309.14155.23867.stgit@gimli.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20151028211309.14155.23867.stgit-GCcqpEzw8uZBDLzU/O5InQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: avi-VrcmuVmyx1hWk0Htik3J/w@public.gmane.org, avi-RmZWMc9puTNJc61us3aD9laTQe2KTcn/@public.gmane.org, gleb-VrcmuVmyx1hWk0Htik3J/w@public.gmane.org, corbet-T1hC0tSOHrs@public.gmane.org, bruce.richardson-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alexander.duyck-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, gleb-RmZWMc9puTNJc61us3aD9laTQe2KTcn/@public.gmane.org, stephen-OTpzqLSitTUnbdJkjeBofR2eb7JE58TQ@public.gmane.org, vladz-RmZWMc9puTNJc61us3aD9laTQe2KTcn/@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, hjk-vqZO0P4V72/QD6PfKP4TzA@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Wed, Oct 28, 2015 at 03:21:45PM -0600, Alex Williamson wrote:
> There is really no way to safely give a user full access to a DMA
> capable device without an IOMMU to protect the host system.  There is
> also no way to provide DMA translation, for use cases such as device
> assignment to virtual machines.  However, there are still those users
> that want userspace drivers even under those conditions.  The UIO
> driver exists for this use case, but does not provide the degree of
> device access and programming that VFIO has.  In an effort to avoid
> code duplication, this introduces a No-IOMMU mode for VFIO.
> 
> This mode requires building VFIO with CONFIG_VFIO_NOIOMMU and enabling
> the "enable_unsafe_noiommu_mode" option on the vfio driver.  This
> should make it very clear that this mode is not safe.  Additionally,
> CAP_SYS_RAWIO privileges are necessary to work with groups and
> containers using this mode.  Groups making use of this support are
> named /dev/vfio/noiommu-$GROUP and can only make use of the special
> VFIO_NOIOMMU_IOMMU for the container.  Use of this mode, specifically
> binding a device without a native IOMMU group to a VFIO bus driver
> will taint the kernel and should therefore not be considered
> supported.  This patch includes no-iommu support for the vfio-pci bus
> driver only.
> 
> Signed-off-by: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> ---
> 
> This is pretty well the same as RFCv2, I've changed the pr_warn to a
> dev_warn and added another, printing the pid and comm of the task when
> it actually opens the device.  If Stephen can port the driver code
> over and prove that this actually works sometime next week, and there
> aren't any objections to this code, I'll include it in a pull request
> for the next merge window.  MST, I dropped your ack due to the
> changes, but I'll be happy to add it back if you like.  Thanks,
> 
> Alex

Yea. This actually can be used safely with devices that don't do DMA.

And given that people seem determined to poke at devices from userspace
even when there's no IOMMU, we are probably better off with supporting
the use-case in vfio - at least this way code will be easier to port
over once hypervisors do support IOMMUs.

Acked-by: Michael S. Tsirkin <mst-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>


>  drivers/vfio/Kconfig        |   15 +++
>  drivers/vfio/pci/vfio_pci.c |    8 +-
>  drivers/vfio/vfio.c         |  186 ++++++++++++++++++++++++++++++++++++++++++-
>  include/linux/vfio.h        |    3 +
>  include/uapi/linux/vfio.h   |    7 ++
>  5 files changed, 209 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/vfio/Kconfig b/drivers/vfio/Kconfig
> index 4540179..b6d3cdc 100644
> --- a/drivers/vfio/Kconfig
> +++ b/drivers/vfio/Kconfig
> @@ -31,5 +31,20 @@ menuconfig VFIO
>  
>  	  If you don't know what to do here, say N.
>  
> +menuconfig VFIO_NOIOMMU
> +	bool "VFIO No-IOMMU support"
> +	depends on VFIO
> +	help
> +	  VFIO is built on the ability to isolate devices using the IOMMU.
> +	  Only with an IOMMU can userspace access to DMA capable devices be
> +	  considered secure.  VFIO No-IOMMU mode enables IOMMU groups for
> +	  devices without IOMMU backing for the purpose of re-using the VFIO
> +	  infrastructure in a non-secure mode.  Use of this mode will result
> +	  in an unsupportable kernel and will therefore taint the kernel.
> +	  Device assignment to virtual machines is also not possible with
> +	  this mode since there is no IOMMU to provide DMA translation.
> +
> +	  If you don't know what to do here, say N.
> +
>  source "drivers/vfio/pci/Kconfig"
>  source "drivers/vfio/platform/Kconfig"
> diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
> index 964ad57..32b88bd 100644
> --- a/drivers/vfio/pci/vfio_pci.c
> +++ b/drivers/vfio/pci/vfio_pci.c
> @@ -940,13 +940,13 @@ static int vfio_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	if (pdev->hdr_type != PCI_HEADER_TYPE_NORMAL)
>  		return -EINVAL;
>  
> -	group = iommu_group_get(&pdev->dev);
> +	group = vfio_iommu_group_get(&pdev->dev);
>  	if (!group)
>  		return -EINVAL;
>  
>  	vdev = kzalloc(sizeof(*vdev), GFP_KERNEL);
>  	if (!vdev) {
> -		iommu_group_put(group);
> +		vfio_iommu_group_put(group, &pdev->dev);
>  		return -ENOMEM;
>  	}
>  
> @@ -957,7 +957,7 @@ static int vfio_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  
>  	ret = vfio_add_group_dev(&pdev->dev, &vfio_pci_ops, vdev);
>  	if (ret) {
> -		iommu_group_put(group);
> +		vfio_iommu_group_put(group, &pdev->dev);
>  		kfree(vdev);
>  		return ret;
>  	}
> @@ -993,7 +993,7 @@ static void vfio_pci_remove(struct pci_dev *pdev)
>  	if (!vdev)
>  		return;
>  
> -	iommu_group_put(pdev->dev.iommu_group);
> +	vfio_iommu_group_put(pdev->dev.iommu_group, &pdev->dev);
>  	kfree(vdev);
>  
>  	if (vfio_pci_is_vga(pdev)) {
> diff --git a/drivers/vfio/vfio.c b/drivers/vfio/vfio.c
> index 1c0f98c..b0408be 100644
> --- a/drivers/vfio/vfio.c
> +++ b/drivers/vfio/vfio.c
> @@ -62,6 +62,7 @@ struct vfio_container {
>  	struct rw_semaphore		group_lock;
>  	struct vfio_iommu_driver	*iommu_driver;
>  	void				*iommu_data;
> +	bool				noiommu;
>  };
>  
>  struct vfio_unbound_dev {
> @@ -84,6 +85,7 @@ struct vfio_group {
>  	struct list_head		unbound_list;
>  	struct mutex			unbound_lock;
>  	atomic_t			opened;
> +	bool				noiommu;
>  };
>  
>  struct vfio_device {
> @@ -95,6 +97,147 @@ struct vfio_device {
>  	void				*device_data;
>  };
>  
> +#ifdef CONFIG_VFIO_NOIOMMU
> +static bool noiommu __read_mostly;
> +module_param_named(enable_unsafe_noiommu_support,
> +		   noiommu, bool, S_IRUGO | S_IWUSR);
> +MODULE_PARM_DESC(enable_unsafe_noiommu_mode, "Enable UNSAFE, no-IOMMU mode.  This mode provides no device isolation, no DMA translation, no host kernel protection, cannot be used for device assignment to virtual machines, requires RAWIO permissions, and will taint the kernel.  If you do not know what this is for, step away. (default: false)");
> +#endif
> +
> +/*
> + * vfio_iommu_group_{get,put} are only intended for VFIO bus driver probe
> + * and remove functions, any use cases other than acquiring the first
> + * reference for the purpose of calling vfio_add_group_dev() or removing
> + * that symmetric reference after vfio_del_group_dev() should use the raw
> + * iommu_group_{get,put} functions.  In particular, vfio_iommu_group_put()
> + * removes the device from the dummy group and cannot be nested.
> + */
> +struct iommu_group *vfio_iommu_group_get(struct device *dev)
> +{
> +	struct iommu_group *group;
> +	int __maybe_unused ret;
> +
> +	group = iommu_group_get(dev);
> +
> +#ifdef CONFIG_VFIO_NOIOMMU
> +	/*
> +	 * With noiommu enabled, an IOMMU group will be created for a device
> +	 * that doesn't already have one and doesn't have an iommu_ops on their
> +	 * bus.  We use iommu_present() again in the main code to detect these
> +	 * fake groups.
> +	 */
> +	if (group || !noiommu || iommu_present(dev->bus))
> +		return group;
> +
> +	group = iommu_group_alloc();
> +	if (IS_ERR(group))
> +		return NULL;
> +
> +	iommu_group_set_name(group, "vfio-noiommu");
> +	ret = iommu_group_add_device(group, dev);
> +	iommu_group_put(group);
> +	if (ret)
> +		return NULL;
> +
> +	/*
> +	 * Where to taint?  At this point we've added an IOMMU group for a
> +	 * device that is not backed by iommu_ops, therefore any iommu_
> +	 * callback using iommu_ops can legitimately Oops.  So, while we may
> +	 * be about to give a DMA capable device to a user without IOMMU
> +	 * protection, which is clearly taint-worthy, let's go ahead and do
> +	 * it here.
> +	 */
> +	add_taint(TAINT_USER, LOCKDEP_STILL_OK);
> +	dev_warn(dev, "Adding kernel taint for vfio-noiommu group on device\n");
> +#endif
> +
> +	return group;
> +}
> +EXPORT_SYMBOL_GPL(vfio_iommu_group_get);
> +
> +void vfio_iommu_group_put(struct iommu_group *group, struct device *dev)
> +{
> +#ifdef CONFIG_VFIO_NOIOMMU
> +	if (!iommu_present(dev->bus))
> +		iommu_group_remove_device(dev);
> +#endif
> +
> +	iommu_group_put(group);
> +}
> +EXPORT_SYMBOL_GPL(vfio_iommu_group_put);
> +
> +#ifdef CONFIG_VFIO_NOIOMMU
> +static void *vfio_noiommu_open(unsigned long arg)
> +{
> +	if (arg != VFIO_NOIOMMU_IOMMU)
> +		return ERR_PTR(-EINVAL);
> +	if (!capable(CAP_SYS_RAWIO))
> +		return ERR_PTR(-EPERM);
> +
> +	return NULL;
> +}
> +
> +static void vfio_noiommu_release(void *iommu_data)
> +{
> +}
> +
> +static long vfio_noiommu_ioctl(void *iommu_data,
> +			       unsigned int cmd, unsigned long arg)
> +{
> +	if (cmd == VFIO_CHECK_EXTENSION)
> +		return arg == VFIO_NOIOMMU_IOMMU ? 1 : 0;
> +
> +	return -ENOTTY;
> +}
> +
> +static int vfio_iommu_present(struct device *dev, void *unused)
> +{
> +	return iommu_present(dev->bus) ? 1 : 0;
> +}
> +
> +static int vfio_noiommu_attach_group(void *iommu_data,
> +				     struct iommu_group *iommu_group)
> +{
> +	return iommu_group_for_each_dev(iommu_group, NULL,
> +					vfio_iommu_present) ? -EINVAL : 0;
> +}
> +
> +static void vfio_noiommu_detach_group(void *iommu_data,
> +				      struct iommu_group *iommu_group)
> +{
> +}
> +
> +static struct vfio_iommu_driver_ops vfio_noiommu_ops = {
> +	.name = "vfio-noiommu",
> +	.owner = THIS_MODULE,
> +	.open = vfio_noiommu_open,
> +	.release = vfio_noiommu_release,
> +	.ioctl = vfio_noiommu_ioctl,
> +	.attach_group = vfio_noiommu_attach_group,
> +	.detach_group = vfio_noiommu_detach_group,
> +};
> +
> +static struct vfio_iommu_driver vfio_noiommu_driver = {
> +	.ops = &vfio_noiommu_ops,
> +};
> +
> +/*
> + * Wrap IOMMU drivers, the noiommu driver is the one and only driver for
> + * noiommu groups (and thus containers) and not available for normal groups.
> + */
> +#define vfio_for_each_iommu_driver(con, pos)				\
> +	for (pos = con->noiommu ? &vfio_noiommu_driver :		\
> +	     list_first_entry(&vfio.iommu_drivers_list,			\
> +			      struct vfio_iommu_driver, vfio_next);	\
> +	     (con->noiommu && pos) || (!con->noiommu &&			\
> +			&pos->vfio_next != &vfio.iommu_drivers_list);	\
> +	      pos = con->noiommu ? NULL : list_next_entry(pos, vfio_next))
> +#else
> +#define vfio_for_each_iommu_driver(con, pos)				\
> +	list_for_each_entry(pos, &vfio.iommu_drivers_list, vfio_next)
> +#endif
> +
> +
>  /**
>   * IOMMU driver registration
>   */
> @@ -199,7 +342,8 @@ static void vfio_group_unlock_and_free(struct vfio_group *group)
>  /**
>   * Group objects - create, release, get, put, search
>   */
> -static struct vfio_group *vfio_create_group(struct iommu_group *iommu_group)
> +static struct vfio_group *vfio_create_group(struct iommu_group *iommu_group,
> +					    bool noiommu)
>  {
>  	struct vfio_group *group, *tmp;
>  	struct device *dev;
> @@ -217,6 +361,7 @@ static struct vfio_group *vfio_create_group(struct iommu_group *iommu_group)
>  	atomic_set(&group->container_users, 0);
>  	atomic_set(&group->opened, 0);
>  	group->iommu_group = iommu_group;
> +	group->noiommu = noiommu;
>  
>  	group->nb.notifier_call = vfio_iommu_group_notifier;
>  
> @@ -252,7 +397,8 @@ static struct vfio_group *vfio_create_group(struct iommu_group *iommu_group)
>  
>  	dev = device_create(vfio.class, NULL,
>  			    MKDEV(MAJOR(vfio.group_devt), minor),
> -			    group, "%d", iommu_group_id(iommu_group));
> +			    group, "%s%d", noiommu ? "noiommu-" : "",
> +			    iommu_group_id(iommu_group));
>  	if (IS_ERR(dev)) {
>  		vfio_free_group_minor(minor);
>  		vfio_group_unlock_and_free(group);
> @@ -640,7 +786,8 @@ int vfio_add_group_dev(struct device *dev,
>  
>  	group = vfio_group_get_from_iommu(iommu_group);
>  	if (!group) {
> -		group = vfio_create_group(iommu_group);
> +		group = vfio_create_group(iommu_group,
> +					  !iommu_present(dev->bus));
>  		if (IS_ERR(group)) {
>  			iommu_group_put(iommu_group);
>  			return PTR_ERR(group);
> @@ -851,8 +998,7 @@ static long vfio_ioctl_check_extension(struct vfio_container *container,
>  		 */
>  		if (!driver) {
>  			mutex_lock(&vfio.iommu_drivers_lock);
> -			list_for_each_entry(driver, &vfio.iommu_drivers_list,
> -					    vfio_next) {
> +			vfio_for_each_iommu_driver(container, driver) {
>  				if (!try_module_get(driver->ops->owner))
>  					continue;
>  
> @@ -921,7 +1067,7 @@ static long vfio_ioctl_set_iommu(struct vfio_container *container,
>  	}
>  
>  	mutex_lock(&vfio.iommu_drivers_lock);
> -	list_for_each_entry(driver, &vfio.iommu_drivers_list, vfio_next) {
> +	vfio_for_each_iommu_driver(container, driver) {
>  		void *data;
>  
>  		if (!try_module_get(driver->ops->owner))
> @@ -1186,6 +1332,9 @@ static int vfio_group_set_container(struct vfio_group *group, int container_fd)
>  	if (atomic_read(&group->container_users))
>  		return -EINVAL;
>  
> +	if (group->noiommu && !capable(CAP_SYS_RAWIO))
> +		return -EPERM;
> +
>  	f = fdget(container_fd);
>  	if (!f.file)
>  		return -EBADF;
> @@ -1201,6 +1350,13 @@ static int vfio_group_set_container(struct vfio_group *group, int container_fd)
>  
>  	down_write(&container->group_lock);
>  
> +	/* Real groups and fake groups cannot mix */
> +	if (!list_empty(&container->group_list) &&
> +	    container->noiommu != group->noiommu) {
> +		ret = -EPERM;
> +		goto unlock_out;
> +	}
> +
>  	driver = container->iommu_driver;
>  	if (driver) {
>  		ret = driver->ops->attach_group(container->iommu_data,
> @@ -1210,6 +1366,7 @@ static int vfio_group_set_container(struct vfio_group *group, int container_fd)
>  	}
>  
>  	group->container = container;
> +	container->noiommu = group->noiommu;
>  	list_add(&group->container_next, &container->group_list);
>  
>  	/* Get a reference on the container and mark a user within the group */
> @@ -1240,6 +1397,9 @@ static int vfio_group_get_device_fd(struct vfio_group *group, char *buf)
>  	    !group->container->iommu_driver || !vfio_group_viable(group))
>  		return -EINVAL;
>  
> +	if (group->noiommu && !capable(CAP_SYS_RAWIO))
> +		return -EPERM;
> +
>  	device = vfio_device_get_from_name(group, buf);
>  	if (!device)
>  		return -ENODEV;
> @@ -1282,6 +1442,10 @@ static int vfio_group_get_device_fd(struct vfio_group *group, char *buf)
>  
>  	fd_install(ret, filep);
>  
> +	if (group->noiommu)
> +		dev_warn(device->dev, "vfio-noiommu device opened by user "
> +			 "(%s:%d)\n", current->comm, task_pid_nr(current));
> +
>  	return ret;
>  }
>  
> @@ -1370,6 +1534,11 @@ static int vfio_group_fops_open(struct inode *inode, struct file *filep)
>  	if (!group)
>  		return -ENODEV;
>  
> +	if (group->noiommu && !capable(CAP_SYS_RAWIO)) {
> +		vfio_group_put(group);
> +		return -EPERM;
> +	}
> +
>  	/* Do we need multiple instances of the group open?  Seems not. */
>  	opened = atomic_cmpxchg(&group->opened, 0, 1);
>  	if (opened) {
> @@ -1532,6 +1701,11 @@ struct vfio_group *vfio_group_get_external_user(struct file *filep)
>  	if (!atomic_inc_not_zero(&group->container_users))
>  		return ERR_PTR(-EINVAL);
>  
> +	if (group->noiommu) {
> +		atomic_dec(&group->container_users);
> +		return ERR_PTR(-EPERM);
> +	}
> +
>  	if (!group->container->iommu_driver ||
>  			!vfio_group_viable(group)) {
>  		atomic_dec(&group->container_users);
> diff --git a/include/linux/vfio.h b/include/linux/vfio.h
> index ddb4409..610a86a 100644
> --- a/include/linux/vfio.h
> +++ b/include/linux/vfio.h
> @@ -44,6 +44,9 @@ struct vfio_device_ops {
>  	void	(*request)(void *device_data, unsigned int count);
>  };
>  
> +extern struct iommu_group *vfio_iommu_group_get(struct device *dev);
> +extern void vfio_iommu_group_put(struct iommu_group *group, struct device *dev);
> +
>  extern int vfio_add_group_dev(struct device *dev,
>  			      const struct vfio_device_ops *ops,
>  			      void *device_data);
> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> index 9fd7b5d..751b69f 100644
> --- a/include/uapi/linux/vfio.h
> +++ b/include/uapi/linux/vfio.h
> @@ -39,6 +39,13 @@
>  #define VFIO_SPAPR_TCE_v2_IOMMU		7
>  
>  /*
> + * The No-IOMMU IOMMU offers no translation or isolation for devices and
> + * supports no ioctls outside of VFIO_CHECK_EXTENSION.  Use of VFIO's No-IOMMU
> + * code will taint the host kernel and should be used with extreme caution.
> + */
> +#define VFIO_NOIOMMU_IOMMU		8
> +
> +/*
>   * The IOCTL interface is designed for extensibility by embedding the
>   * structure length (argsz) and flags into structures passed between
>   * kernel and userspace.  We therefore use the _IO() macro for these
