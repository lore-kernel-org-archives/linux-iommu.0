Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3450293B5C;
	Tue, 17 Jun 2025 08:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750147632; cv=none; b=ntrxmS7XxrLlHLGNb4blFq1EaNnclbG6kBLPKQtsfcatURVxzpbrEPw93BJWpuGxrIkgPuwBRTMLHkFmQ0XQoGEgexwf6hsgaiJzvXzEFdUWl8LcRGBHorOPxsRBn4Secij55uOeQXyZ+2xgLnEgMgw3LxD42RqX1R2RLsgYxKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750147632; c=relaxed/simple;
	bh=KYLiaVSweH1OEcMlxROlRhvYiENPdZ9jdUsrp6aJ5ZM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NVzHQmNiqX1Dj8IcnHRsuuNFRq82oUxr3RxuaqRsr0ELi7v9xHv2vjYuGNGWSPWsVUfDm2rZxKHfAzymrt+5mpMUW/o1qdM9+4M4ZmNfzqsNmflhyzbxJNYiVTCsWIFTkvA5clmLzJP4VOyExO72okT6166kBHT1ewSFAVSkEwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iQxcYs/y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iQxcYs/y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8B9AC4CEE3;
	Tue, 17 Jun 2025 08:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750147631;
	bh=KYLiaVSweH1OEcMlxROlRhvYiENPdZ9jdUsrp6aJ5ZM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=iQxcYs/ycwoPSCMYhNUtVOozwBZ4/rLkC6haME/bsSeEF7GG2fHvqQB8Spl0B6Urd
	 8sg8MhNRAph2GhlSXng43BuUQtxYNmBrqVliI7i6LCa+iO5vSu6nGeqT5vdY0BNuNa
	 0qlLaoQoZj5emLRVka0MvW9S5/wy2eiaOqqaYudJStPdF13rlVY06RzUQaw7PNUhD7
	 TLdUZ6+chHnuz1kToubEKrA/rhNIPIwAQMdhz81rOA4jHTbbwTg5wLJJjj3EoVsDrO
	 U0s2jqKdwVtIziOxKcdbVY/Igb1y/pDjPFtM03dkdLQywpVQeHL+o/GEa01AOQJuiH
	 G6Gvh5mXJhZyQ==
X-Mailer: emacs 30.1 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>, "Tian, Kevin" <kevin.tian@intel.com>
Cc: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>
Subject: Re: [RFC PATCH] iommufd: Destroy vdevice on device unbind
In-Reply-To: <20250616164941.GA1373692@ziepe.ca>
References: <20250610065146.1321816-1-aneesh.kumar@kernel.org>
 <BN9PR11MB527606182417BB7A35349F598C74A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20250612172645.GA1011960@ziepe.ca>
 <BN9PR11MB5276B467ADCC57BC6571CA458C77A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20250613124202.GD1130869@ziepe.ca> <yq5abjqotim7.fsf@kernel.org>
 <BN9PR11MB527633CA2F698E83E12BFBD68C70A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20250616164941.GA1373692@ziepe.ca>
Date: Tue, 17 Jun 2025 13:37:04 +0530
Message-ID: <yq5azfe6ssev.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

Jason Gunthorpe <jgg@ziepe.ca> writes:

> On Mon, Jun 16, 2025 at 05:37:58AM +0000, Tian, Kevin wrote:
>
>> the expected destruction flow from userspace is to IOMMU_DESTROY
>> the vdevice object before closing the vfio cdev fd which unbinds the
>> idevice.
>> 
>> now we are discussing how to handle a malfunction userspace which
>> violates that flow: let it be or add a tomestone state, after extending
>> unbind to destroy the vdevice...
>
> Right, to be clear the concern is
>
> close(vfio_cdev)
> ioctl(DESTROY, vdevice_id);
> close(iommufd)
>
> Which is a possibile sequence for userspace/syzkaller to trigger.
>
> My position has historically been that DESTROY should not destroy some
> random unrelated object eg because a parallel thread did an allocation
> and re-used the kernel deleted ID. ID's that belong to userspace have
> to be retained right up until DESTROY.
>
> Thus we've historically avoided creating scenarios where IDs owned by
> userspace are destroyed by the kernel.
>
> Given we can say the above is illegal use of the API we could leave
> behind a tombstone in the xarray. The goal would be to prevent lookup
> of the object (since it is destroyed) and prevent reallocation of the
> ID.
>
> For instance a simple thing would be to drop in XA_ZERO_ENTRY, this
> will reserve the ID and fail all future operations. The userspace will
> get a failure on DESTROY so they know they did something wrong. The fd
> close will clean up the reserved ID.
>

How do we reclaim that object id for further reuse? 

is it that if there is a request for a iommufd_object_remove() with object
refcount > 1, we insert a XA_ZERO_ENTRY and convert that to NULL entry
on IOMMU_DESTROY?

Something like below

The below sequence will work with the changes as
 close(vfio_cdev) -> vdev destroy
 ioctl(DESTROY, vdevice_id); -> vdev object id reclaim
 close(iommufd)

 ioctl(DESTROY, vdevice_id); -> EBUSY
 close(vfio_cdev) -> vdev destroy
 close(iommufd)


diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 7b3f82afd295..1f8e4fd0e240 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -289,7 +289,7 @@ void iommufd_device_unbind(struct iommufd_device *idev)
 
 	if (idev->vdev)
 		/* extra refcount taken during vdevice alloc */
-		iommufd_object_destroy_user(idev->ictx, &idev->vdev->obj);
+		__iommufd_object_destroy_user(idev->ictx, &idev->vdev->obj, REMOVE_OBJ_FORCE);
 	iommufd_object_destroy_user(idev->ictx, &idev->obj);
 }
 EXPORT_SYMBOL_NS_GPL(iommufd_device_unbind, "IOMMUFD");
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 9c4472df80c6..8c5fc0fe92ce 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -186,9 +186,9 @@ void iommufd_object_abort_and_destroy(struct iommufd_ctx *ictx,
 void iommufd_object_finalize(struct iommufd_ctx *ictx,
 			     struct iommufd_object *obj);
 
-enum {
-	REMOVE_WAIT_SHORTTERM = 1,
-};
+#define	REMOVE_WAIT_SHORTTERM	BIT(0)
+#define	REMOVE_OBJ_FORCE	BIT(1)
+
 int iommufd_object_remove(struct iommufd_ctx *ictx,
 			  struct iommufd_object *to_destroy, u32 id,
 			  unsigned int flags);
@@ -198,12 +198,13 @@ int iommufd_object_remove(struct iommufd_ctx *ictx,
  * point the caller has no shortterm_users reference and at least the xarray
  * will be holding one.
  */
-static inline void iommufd_object_destroy_user(struct iommufd_ctx *ictx,
-					       struct iommufd_object *obj)
+static inline void __iommufd_object_destroy_user(struct iommufd_ctx *ictx,
+						 struct iommufd_object *obj,
+						 unsigned int flags)
 {
 	int ret;
 
-	ret = iommufd_object_remove(ictx, obj, obj->id, REMOVE_WAIT_SHORTTERM);
+	ret = iommufd_object_remove(ictx, obj, obj->id, flags | REMOVE_WAIT_SHORTTERM);
 
 	/*
 	 * If there is a bug and we couldn't destroy the object then we did put
@@ -213,6 +214,12 @@ static inline void iommufd_object_destroy_user(struct iommufd_ctx *ictx,
 	WARN_ON(ret);
 }
 
+static inline void iommufd_object_destroy_user(struct iommufd_ctx *ictx,
+						 struct iommufd_object *obj)
+{
+	return __iommufd_object_destroy_user(ictx, obj, 0);
+}
+
 /*
  * The HWPT allocated by autodomains is used in possibly many devices and
  * is automatically destroyed when its refcount reaches zero.
diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index b7aa725e6b37..d27b61787a53 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -88,7 +88,8 @@ struct iommufd_object *iommufd_get_object(struct iommufd_ctx *ictx, u32 id,
 
 	xa_lock(&ictx->objects);
 	obj = xa_load(&ictx->objects, id);
-	if (!obj || (type != IOMMUFD_OBJ_ANY && obj->type != type) ||
+	if (!obj || xa_is_zero(obj) ||
+	    (type != IOMMUFD_OBJ_ANY && obj->type != type) ||
 	    !iommufd_lock_obj(obj))
 		obj = ERR_PTR(-ENOENT);
 	xa_unlock(&ictx->objects);
@@ -157,17 +158,27 @@ int iommufd_object_remove(struct iommufd_ctx *ictx,
 			ret = -ENOENT;
 			goto err_xa;
 		}
-	} else if (xa_is_zero(obj) || !obj) {
+	} else if (xa_is_zero(obj)) {
+		/* We can reclaim the id now. */
+		xas_store(&xas, NULL);
+		ret = 0;
+		goto err_xa;
+	} else if (!obj) {
 		ret = -ENOENT;
 		goto err_xa;
 	}
 
 	if (!refcount_dec_if_one(&obj->users)) {
-		ret = -EBUSY;
-		goto err_xa;
+		if (flags & REMOVE_OBJ_FORCE) {
+			xas_store(&xas, XA_ZERO_ENTRY);
+		} else {
+			ret = -EBUSY;
+			goto err_xa;
+		}
+	} else {
+		xas_store(&xas, NULL);
 	}
 
-	xas_store(&xas, NULL);
 	if (ictx->vfio_ioas == container_of(obj, struct iommufd_ioas, obj))
 		ictx->vfio_ioas = NULL;
 	xa_unlock(&ictx->objects);
diff --git a/drivers/iommu/iommufd/viommu.c b/drivers/iommu/iommufd/viommu.c
index d9749d9d2ffb..4fc74ada0e62 100644
--- a/drivers/iommu/iommufd/viommu.c
+++ b/drivers/iommu/iommufd/viommu.c
@@ -213,6 +213,8 @@ int iommufd_vdevice_alloc_ioctl(struct iommufd_ucmd *ucmd)
 	/* vdev lifecycle now managed by idev */
 	idev->vdev = vdev;
 	refcount_inc(&vdev->obj.users);
+	/* Increment refcount since userspace can hold the obj id */
+	refcount_inc(&vdev->obj.users);
 	goto out_put_idev_unlock;
 
 out_abort:
