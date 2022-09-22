Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2071D2560
	for <iommu@lists.linux.dev>; Thu, 22 Sep 2022 21:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1663881826;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=amknlAeFT++u+0DSl5EiHTWh0/aJKw0FNLibGeEEGgM=;
	b=BA8lF2eZrJOEc6To19eT+q0rzsyg8NJTj7KLNFrkEpeI/pjz3LsElf2hQ3jXg1+lXB8chB
	Vl8XYxrwgRbgJBSOhRIawHK2W9qhoIa2zkcn6LlopqtMv5aPszGkf/JsoS1cQldf0bIB+1
	m3tShSCSsmci1jIlv7y/+vf4h1iNv18=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-160-OUHQI6mLNh-HzwCZ5ALECw-1; Thu, 22 Sep 2022 17:23:43 -0400
X-MC-Unique: OUHQI6mLNh-HzwCZ5ALECw-1
Received: by mail-il1-f197.google.com with SMTP id c7-20020a056e020bc700b002e59be6ce85so6494519ilu.12
        for <iommu@lists.linux.dev>; Thu, 22 Sep 2022 14:23:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date;
        bh=amknlAeFT++u+0DSl5EiHTWh0/aJKw0FNLibGeEEGgM=;
        b=ETR/XOQm3EYwIx9c7RFQD/QXWzjhEqkLNvjjEavN8uhFGE9nG54rJ33LnrZH3wSQnm
         Mf2CS8AI1j/wIE0VAxZKH+wyiNej2PKFBxhEhCBQHso3QmZrEIgBLTMJoVkZruLYPOXa
         hu/swikVpRM36ERukbpwmiXEqU1A/ldsGfbWTNRmOuH6yNAmO0Ohi2tJXl1wEFrPssST
         XAa7NWWHU6K91PeSxZUca/ohYetEzUO0XIYl4Zio7DGe+g4G27jgQVADt8jlj2+6Z1c4
         YctYPbah622rwYfX+vH5PSmb5maa0Ai0Sw18UENynkOyDUz/t1weEds9Yj3LEnl/Onzf
         887g==
X-Gm-Message-State: ACrzQf3dDLF7evfHOKIna12JlvZC+CkYQQ/p4LL9QGjX4YJtsJ8Fv552
	F8oAYgYFABdRUp14rK09QAiBV7gVwlsKU4DjtbRA71IVe+lla+JTOMGmq8krNh8JdYg7XlgN0yb
	fNA2UM9Hq9l1W4eE=
X-Received: by 2002:a05:6638:3f1a:b0:35a:3ae2:5906 with SMTP id ck26-20020a0566383f1a00b0035a3ae25906mr3232933jab.181.1663881821202;
        Thu, 22 Sep 2022 14:23:41 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7Ajvu8oniAX/tK7v6dA2ApIjf6hzkvaM9uTse0uc961Ofsg6QBLJVb7YnNfG4ZwCrlZl9b7w==
X-Received: by 2002:a05:6638:3f1a:b0:35a:3ae2:5906 with SMTP id ck26-20020a0566383f1a00b0035a3ae25906mr3232912jab.181.1663881820849;
        Thu, 22 Sep 2022 14:23:40 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id c11-20020a92cf0b000000b002f56be9d9a7sm2429170ilo.10.2022.09.22.14.23.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 14:23:40 -0700 (PDT)
Date: Thu, 22 Sep 2022 15:23:38 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Cornelia Huck <cohuck@redhat.com>, iommu@lists.linux.dev, Joerg Roedel
 <joro@8bytes.org>, kvm@vger.kernel.org, Will Deacon <will@kernel.org>, Qian
 Cai <cai@lca.pw>, Joerg Roedel <jroedel@suse.de>, Marek Szyprowski
 <m.szyprowski@samsung.com>, Matthew Rosato <mjrosato@linux.ibm.com>, Robin
 Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 2/4] vfio: Move the sanity check of the group to
 vfio_create_group()
Message-ID: <20220922152338.2a2238fe.alex.williamson@redhat.com>
In-Reply-To: <Yyy5Lr30A3GuK4Ab@nvidia.com>
References: <0-v1-ef00ffecea52+2cb-iommu_group_lifetime_jgg@nvidia.com>
	<2-v1-ef00ffecea52+2cb-iommu_group_lifetime_jgg@nvidia.com>
	<20220922131050.7136481f.alex.williamson@redhat.com>
	<Yyy5Lr30A3GuK4Ab@nvidia.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 22 Sep 2022 16:36:14 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Thu, Sep 22, 2022 at 01:10:50PM -0600, Alex Williamson wrote:
> > The semantics of vfio_get_group() are also rather strange, 'return a
> > vfio_group for this iommu_group, but make sure it doesn't include this
> > device' :-\  Thanks,  
> 
> I think of it as "return a group and also do sanity checks that the
> returned group has not been corrupted"
> 
> I don't like the name of this function but couldn't figure a better
> one. It is something like "find or create a group for a device which
> we know doesn't already have a group"

Well, we don't really need to have this behavior, we could choose to
implement the first two patches with the caller holding the
group_lock.  Only one of the callers needs the duplicate test, no-iommu
creates its own iommu_group and therefore cannot have an existing
device.  I think patches 1 & 2 would look like below*, with patch 3
simply moving the change from vfio_group_get() to refcount_inc() into
the equivalent place in vfio_group_find_of_alloc().  Thanks,

Alex

*only compile tested

---
 drivers/vfio/vfio_main.c |   33 ++++++++++-----------------------
 1 file changed, 10 insertions(+), 23 deletions(-)

diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
index f9d10dbcf3e6..aa33944cb759 100644
--- a/drivers/vfio/vfio_main.c
+++ b/drivers/vfio/vfio_main.c
@@ -310,10 +310,12 @@ static void vfio_container_put(struct vfio_container *container)
  * Group objects - create, release, get, put, search
  */
 static struct vfio_group *
-__vfio_group_get_from_iommu(struct iommu_group *iommu_group)
+vfio_group_get_from_iommu(struct iommu_group *iommu_group)
 {
 	struct vfio_group *group;
 
+	lockdep_assert_held(&vfio.group_lock);
+
 	list_for_each_entry(group, &vfio.group_list, vfio_next) {
 		if (group->iommu_group == iommu_group) {
 			vfio_group_get(group);
@@ -323,17 +325,6 @@ __vfio_group_get_from_iommu(struct iommu_group *iommu_group)
 	return NULL;
 }
 
-static struct vfio_group *
-vfio_group_get_from_iommu(struct iommu_group *iommu_group)
-{
-	struct vfio_group *group;
-
-	mutex_lock(&vfio.group_lock);
-	group = __vfio_group_get_from_iommu(iommu_group);
-	mutex_unlock(&vfio.group_lock);
-	return group;
-}
-
 static void vfio_group_release(struct device *dev)
 {
 	struct vfio_group *group = container_of(dev, struct vfio_group, dev);
@@ -387,6 +378,8 @@ static struct vfio_group *vfio_create_group(struct iommu_group *iommu_group,
 	struct vfio_group *ret;
 	int err;
 
+	lockdep_assert_held(&vfio.group_lock);
+
 	group = vfio_group_alloc(iommu_group, type);
 	if (IS_ERR(group))
 		return group;
@@ -399,26 +392,16 @@ static struct vfio_group *vfio_create_group(struct iommu_group *iommu_group,
 		goto err_put;
 	}
 
-	mutex_lock(&vfio.group_lock);
-
-	/* Did we race creating this group? */
-	ret = __vfio_group_get_from_iommu(iommu_group);
-	if (ret)
-		goto err_unlock;
-
 	err = cdev_device_add(&group->cdev, &group->dev);
 	if (err) {
 		ret = ERR_PTR(err);
-		goto err_unlock;
+		goto err_put;
 	}
 
 	list_add(&group->vfio_next, &vfio.group_list);
 
-	mutex_unlock(&vfio.group_lock);
 	return group;
 
-err_unlock:
-	mutex_unlock(&vfio.group_lock);
 err_put:
 	put_device(&group->dev);
 	return ret;
@@ -609,7 +592,9 @@ static struct vfio_group *vfio_noiommu_group_alloc(struct device *dev,
 	if (ret)
 		goto out_put_group;
 
+	mutex_lock(&vfio.group_lock);
 	group = vfio_create_group(iommu_group, type);
+	mutex_unlock(&vfio.group_lock);
 	if (IS_ERR(group)) {
 		ret = PTR_ERR(group);
 		goto out_remove_device;
@@ -659,9 +644,11 @@ static struct vfio_group *vfio_group_find_or_alloc(struct device *dev)
 		return ERR_PTR(-EINVAL);
 	}
 
+	mutex_lock(&vfio.group_lock);
 	group = vfio_group_get_from_iommu(iommu_group);
 	if (!group)
 		group = vfio_create_group(iommu_group, VFIO_IOMMU);
+	mutex_unlock(&vfio.group_lock);
 
 	/* The vfio_group holds a reference to the iommu_group */
 	iommu_group_put(iommu_group);


---
 drivers/vfio/vfio_main.c |   58 ++++++++++++++++++++--------------------------
 1 file changed, 25 insertions(+), 33 deletions(-)

diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
index aa33944cb759..4692493d386a 100644
--- a/drivers/vfio/vfio_main.c
+++ b/drivers/vfio/vfio_main.c
@@ -310,17 +310,15 @@ static void vfio_container_put(struct vfio_container *container)
  * Group objects - create, release, get, put, search
  */
 static struct vfio_group *
-vfio_group_get_from_iommu(struct iommu_group *iommu_group)
+vfio_group_find_from_iommu(struct iommu_group *iommu_group)
 {
 	struct vfio_group *group;
 
 	lockdep_assert_held(&vfio.group_lock);
 
 	list_for_each_entry(group, &vfio.group_list, vfio_next) {
-		if (group->iommu_group == iommu_group) {
-			vfio_group_get(group);
+		if (group->iommu_group == iommu_group)
 			return group;
-		}
 	}
 	return NULL;
 }
@@ -449,23 +447,6 @@ static bool vfio_device_try_get_registration(struct vfio_device *device)
 	return refcount_inc_not_zero(&device->refcount);
 }
 
-static struct vfio_device *vfio_group_get_device(struct vfio_group *group,
-						 struct device *dev)
-{
-	struct vfio_device *device;
-
-	mutex_lock(&group->device_lock);
-	list_for_each_entry(device, &group->device_list, group_next) {
-		if (device->dev == dev &&
-		    vfio_device_try_get_registration(device)) {
-			mutex_unlock(&group->device_lock);
-			return device;
-		}
-	}
-	mutex_unlock(&group->device_lock);
-	return NULL;
-}
-
 /*
  * VFIO driver API
  */
@@ -609,6 +590,21 @@ static struct vfio_group *vfio_noiommu_group_alloc(struct device *dev,
 	return ERR_PTR(ret);
 }
 
+static bool vfio_group_has_device(struct vfio_group *group, struct device *dev)
+{
+	struct vfio_device *device;
+
+	mutex_lock(&group->device_lock);
+	list_for_each_entry(device, &group->device_list, group_next) {
+		if (device->dev == dev) {
+			mutex_unlock(&group->device_lock);
+			return true;
+		}
+	}
+	mutex_unlock(&group->device_lock);
+	return false;
+}
+
 static struct vfio_group *vfio_group_find_or_alloc(struct device *dev)
 {
 	struct iommu_group *iommu_group;
@@ -645,9 +641,15 @@ static struct vfio_group *vfio_group_find_or_alloc(struct device *dev)
 	}
 
 	mutex_lock(&vfio.group_lock);
-	group = vfio_group_get_from_iommu(iommu_group);
-	if (!group)
+	group = vfio_group_find_from_iommu(iommu_group);
+	if (group) {
+		if (WARN_ON(vfio_group_has_device(group, dev)))
+			group = ERR_PTR(-EINVAL);
+		else
+			vfio_group_get(group);
+	} else {
 		group = vfio_create_group(iommu_group, VFIO_IOMMU);
+	}
 	mutex_unlock(&vfio.group_lock);
 
 	/* The vfio_group holds a reference to the iommu_group */
@@ -658,7 +660,6 @@ static struct vfio_group *vfio_group_find_or_alloc(struct device *dev)
 static int __vfio_register_dev(struct vfio_device *device,
 		struct vfio_group *group)
 {
-	struct vfio_device *existing_device;
 	int ret;
 
 	if (IS_ERR(group))
@@ -671,15 +672,6 @@ static int __vfio_register_dev(struct vfio_device *device,
 	if (!device->dev_set)
 		vfio_assign_device_set(device, device);
 
-	existing_device = vfio_group_get_device(group, device->dev);
-	if (existing_device) {
-		dev_WARN(device->dev, "Device already exists on group %d\n",
-			 iommu_group_id(group->iommu_group));
-		vfio_device_put_registration(existing_device);
-		ret = -EBUSY;
-		goto err_out;
-	}
-
 	/* Our reference on group is moved to the device */
 	device->group = group;
 

