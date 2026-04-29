Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594D92FD1B3;
	Wed, 29 Apr 2026 13:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777470778; cv=none; b=D75y0coTegiLriJe5ACwr4nRYnRtScfbd3S4XJGjrWrX368AF2m9AIKzdy15xdZxAqo2mU10xkmMxT2Wr8Q3TqikXb/s2vOWFfqO4Wwoxdmvc7DStSD9kABw+gzRiBBBJ+sX7E1sumF2raoRHf9RoGMlzb4wFkIofMi8FSIKcZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777470778; c=relaxed/simple;
	bh=ebAIgK15l9juU3crLAaHpm06slwMZubVzm9QtkjRbjk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YkyPxdJM0TyPTDMleGGUfSdOmEVtOjjn6CVb4tKHJOiOqOUErNbrlxeeuLrOUN/QutuJ9WfLAaq+k6HAlJROrGgCTHQ+M1/FXU3w7sdhxGBkrVQChJnX5m+D9I9Xw1/uv2sQ4hxMAWIr2PVyWUPkllPrAkEKSYWOl58hlNFGRq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fzrNzx3n; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fzrNzx3n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77DB2C19425;
	Wed, 29 Apr 2026 13:52:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777470777;
	bh=ebAIgK15l9juU3crLAaHpm06slwMZubVzm9QtkjRbjk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=fzrNzx3nMMdsTotcFtFepBbP9w9rAUD0PRsbZ7dG33D2ioI7XaMUHpdHS+TvAqU6Z
	 OHTyGPkIzofP70ySCXMnq1vdGcbxT+CVMTTxq8zUGOkdSL10+62kMtKKyv+KMIV2Iy
	 5evE9LPkOn4zLVQALMhGDpHUOe2XhgNI4ktuqc1IS+2bql8PJ5HHtmoNLMZAP1aZ+E
	 Qv66ZjX5kYZp/AswAoeUYr+sKO5TxGVhFsR6ovIg4z9jParOQu691LNEG8PjbbHSXK
	 4oMtUCrBbZfFPvNLcId3G/jTbot4I5rFkxrvYGGIukkyoDmj+8B/XwwhjljoPqBN+h
	 jk/6FvvnuQKZg==
X-Mailer: emacs 30.2 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, Alexey Kardashevskiy <aik@amd.com>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Kevin Tian <kevin.tian@intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Samuel Ortiz <sameo@rivosinc.com>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Will Deacon <will@kernel.org>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v4 1/4] iommufd/device: Associate a kvm pointer to
 iommufd_device
In-Reply-To: <20260428125015.GB849557@ziepe.ca>
References: <20260427061005.901854-1-aneesh.kumar@kernel.org>
 <20260427061005.901854-2-aneesh.kumar@kernel.org>
 <20260427135906.GB740385@ziepe.ca> <yq5afr4f1egv.fsf@kernel.org>
 <20260428125015.GB849557@ziepe.ca>
Date: Wed, 29 Apr 2026 19:22:46 +0530
Message-ID: <yq5atsstzxe9.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


Jason Gunthorpe <jgg@ziepe.ca> writes:

> On Tue, Apr 28, 2026 at 05:31:04PM +0530, Aneesh Kumar K.V wrote:
>> > I thought we were trying to get away from struct kvm?
>> >
>> > https://lore.kernel.org/all/adf29Rn7q9Db0hxc@google.com/
>> >
>> > Ie this should be a 'struct file *kvm_fd'
>> >
>> > ?
>> >
>> > Though I am wondering how practical it is to do this at this moment :\
>> >
>>=20
>> Should we also switch=20
>>=20
>> modified   drivers/vfio/vfio.h
>> @@ -22,8 +22,8 @@ struct vfio_device_file {
>>=20=20
>>  	u8 access_granted;
>>  	u32 devid; /* only valid when iommufd is valid */
>> -	spinlock_t kvm_ref_lock; /* protect kvm field */
>> -	struct kvm *kvm;
>> +	spinlock_t kvm_ref_lock; /* protect kvm_file */
>> +	struct file *kvm_file;
>>  	struct iommufd_ctx *iommufd; /* protected by struct vfio_device_set::l=
ock */
>>  };
>>=20=20
>> @@ -88,7 +88,7 @@ struct vfio_group {
>>  #endif
>>  	enum vfio_group_type		type;
>>  	struct mutex			group_lock;
>> -	struct kvm			*kvm;
>> +	struct file			*kvm_file;
>>  	struct file			*opened_file;
>>  	struct blocking_notifier_head	notifier;
>>  	struct iommufd_ctx		*iommufd;
>
> Ideally, yes everything outside kvm should just use the struct file
> and there should be quite narrow places where you do some kvm
> operation on it.
>=20=20
>> ie,
>> KVM_CREATE_DEVICE with KVM_DEV_TYPE_VFIO still use kvm->users_count,
>> KVM_DEV_VFIO_FILE_ADD -> will switch to get_file(kvm->_file);
>> and VFIO_DEVICE_BIND_IOMMUFD -> will switch to get_file(df->kvm_file)
>>=20
>> > Maybe ask Paolo how his series is going?
>
> I thought the above is what Paolo's series was going after?
>

Hi Paolo,

Could you please take a look at this? I=E2=80=99ve tried to document the
reference count details and hope I=E2=80=99ve captured everything correctly=
, but
I=E2=80=99d appreciate your review to make sure I haven=E2=80=99t missed an=
ything.

From 141fb9430d6c4227144221410121780c6681d1ce Mon Sep 17 00:00:00 2001
From: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Date: Wed, 29 Apr 2026 12:14:36 +0530
Subject: [PATCH] vfio: cache KVM VM file references instead of raw struct k=
vm
 pointers

VFIO currently records struct kvm pointers on vfio_group, vfio_device_file
and the opened vfio_device. Switch VFIO to track the VM's struct file
instead of a raw struct kvm pointer so that VFIO holds a reference to the
VM fd's struct file, rather than caching a struct kvm pointer and using
KVM-managed object lifetime (kvm->users_count) to make that pointer usable.

This also lets VFIO stop taking KVM object references through
kvm_get_kvm_safe()/kvm_put_kvm() via symbol_get(), and instead pin the VM
through references to kvm->_file.

KVM publishes the association through KVM_DEV_VFIO_FILE_ADD:
  - kvm_vfio_file_add() gets the userspace VFIO file with fget(fd)
  - it then takes its own persistent reference with kvf->file =3D
    get_file(filp)
  - that kvf->file reference is owned by the KVM VFIO device and lives on
    kv->file_list until KVM_DEV_VFIO_FILE_DEL or kvm_vfio_release()
  - kvm_vfio_file_set_kvm(kvf->file, dev->kvm) then updates the VFIO side
    association to the VM

On the VFIO side, vfio_kvm_file_replace() converts struct kvm to a VM file
reference with get_file_active(&kvm->_file). get_file_active() is required
because dev->kvm may still be alive due to the KVM device fd's
kvm_get_kvm() reference from KVM_CREATE_DEVICE, while the VM fd itself may
already be in final __fput(). In that case kvm->_file must not be
re-acquired with plain get_file().

The stored group/device-file kvm_file references are long-lived association
references managed by KVM:
  - they are installed from KVM_DEV_VFIO_FILE_ADD
  - they are replaced/cleared by kvm_vfio_file_set_kvm()
  - they are dropped from kvm_vfio_file_del() and kvm_vfio_release(), which
    call vfio_file_set_kvm(file, NULL) before dropping kvf->file

The opened vfio_device still takes its own kvm_file reference for driver
use:
  - group path: vfio_device_group_get_kvm_safe()
  - cdev/iommufd path: vfio_df_get_kvm_safe() from VFIO_DEVICE_BIND_IOMMUFD
  - both paths call vfio_device_get_kvm_safe(), which get_file()s the
    already-associated kvm_file and stores it in device->kvm_file
  - that open-time reference is dropped by vfio_device_put_kvm() when the
    device is closed or unbound

This gives each layer a clear ownership model:
  - KVM device fd: pins struct kvm through kvm->users_count via
    kvm_get_kvm()/kvm_put_kvm()
  - VM fd and VFIO kvm_file references: pin the VM file through kvm->_file
  - kvf->file: pins the VFIO file until KVM removes the association
  - device->kvm_file: pins the VM file for the duration of an active VFIO
    device open


Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 drivers/vfio/device_cdev.c | 10 ++---
 drivers/vfio/group.c       | 14 +++----
 drivers/vfio/vfio.h        | 16 +++++---
 drivers/vfio/vfio_main.c   | 76 ++++++++++++++++++--------------------
 include/linux/kvm_host.h   |  3 ++
 include/linux/vfio.h       |  3 +-
 virt/kvm/kvm_main.c        |  1 +
 7 files changed, 62 insertions(+), 61 deletions(-)

diff --git a/drivers/vfio/device_cdev.c b/drivers/vfio/device_cdev.c
index 8ceca24ac136..b3e7e1b725c1 100644
--- a/drivers/vfio/device_cdev.c
+++ b/drivers/vfio/device_cdev.c
@@ -56,7 +56,7 @@ int vfio_device_fops_cdev_open(struct inode *inode, struc=
t file *filep)
 static void vfio_df_get_kvm_safe(struct vfio_device_file *df)
 {
 	spin_lock(&df->kvm_ref_lock);
-	vfio_device_get_kvm_safe(df->device, df->kvm);
+	vfio_device_get_kvm_safe(df->device, df->kvm_file);
 	spin_unlock(&df->kvm_ref_lock);
 }
=20
@@ -133,10 +133,10 @@ long vfio_df_ioctl_bind_iommufd(struct vfio_device_fi=
le *df,
 	}
=20
 	/*
-	 * Before the device open, get the KVM pointer currently
-	 * associated with the device file (if there is) and obtain
-	 * a reference.  This reference is held until device closed.
-	 * Save the pointer in the device for use by drivers.
+	 * Before the device open, get the VM struct file currently
+	 * associated with the device file (if there is one) and obtain a
+	 * reference. This reference is held until the device is closed.
+	 * Save the file in the device for use by drivers.
 	 */
 	vfio_df_get_kvm_safe(df);
=20
diff --git a/drivers/vfio/group.c b/drivers/vfio/group.c
index 4f15016d2a5f..8ed6a676f1c9 100644
--- a/drivers/vfio/group.c
+++ b/drivers/vfio/group.c
@@ -158,7 +158,7 @@ static int vfio_group_ioctl_set_container(struct vfio_g=
roup *group,
 static void vfio_device_group_get_kvm_safe(struct vfio_device *device)
 {
 	spin_lock(&device->group->kvm_ref_lock);
-	vfio_device_get_kvm_safe(device, device->group->kvm);
+	vfio_device_get_kvm_safe(device, device->group->kvm_file);
 	spin_unlock(&device->group->kvm_ref_lock);
 }
=20
@@ -176,10 +176,10 @@ static int vfio_df_group_open(struct vfio_device_file=
 *df)
 	mutex_lock(&device->dev_set->lock);
=20
 	/*
-	 * Before the first device open, get the KVM pointer currently
-	 * associated with the group (if there is one) and obtain a reference
-	 * now that will be held until the open_count reaches 0 again.  Save
-	 * the pointer in the device for use by drivers.
+	 * Before the first device open, get the VM struct file currently
+	 * associated with the group (if there is one) and obtain a
+	 * reference now that will be held until the open_count reaches 0
+	 * again. Save the file in the device for use by drivers.
 	 */
 	if (device->open_count =3D=3D 0)
 		vfio_device_group_get_kvm_safe(device);
@@ -860,9 +860,7 @@ bool vfio_group_enforced_coherent(struct vfio_group *gr=
oup)
=20
 void vfio_group_set_kvm(struct vfio_group *group, struct kvm *kvm)
 {
-	spin_lock(&group->kvm_ref_lock);
-	group->kvm =3D kvm;
-	spin_unlock(&group->kvm_ref_lock);
+	vfio_kvm_file_replace(&group->kvm_file, &group->kvm_ref_lock, kvm);
 }
=20
 /**
diff --git a/drivers/vfio/vfio.h b/drivers/vfio/vfio.h
index 50128da18bca..5b4bda2aeb47 100644
--- a/drivers/vfio/vfio.h
+++ b/drivers/vfio/vfio.h
@@ -22,8 +22,8 @@ struct vfio_device_file {
=20
 	u8 access_granted;
 	u32 devid; /* only valid when iommufd is valid */
-	spinlock_t kvm_ref_lock; /* protect kvm field */
-	struct kvm *kvm;
+	spinlock_t kvm_ref_lock; /* protect kvm_file */
+	struct file *kvm_file;
 	struct iommufd_ctx *iommufd; /* protected by struct vfio_device_set::lock=
 */
 };
=20
@@ -88,7 +88,7 @@ struct vfio_group {
 #endif
 	enum vfio_group_type		type;
 	struct mutex			group_lock;
-	struct kvm			*kvm;
+	struct file			*kvm_file;
 	struct file			*opened_file;
 	struct blocking_notifier_head	notifier;
 	struct iommufd_ctx		*iommufd;
@@ -435,11 +435,17 @@ static inline void vfio_virqfd_exit(void)
 #endif
=20
 #if IS_ENABLED(CONFIG_KVM)
-void vfio_device_get_kvm_safe(struct vfio_device *device, struct kvm *kvm);
+void vfio_kvm_file_replace(struct file **dst, spinlock_t *lock, struct kvm=
 *kvm);
+void vfio_device_get_kvm_safe(struct vfio_device *device, struct file *kvm=
_file);
 void vfio_device_put_kvm(struct vfio_device *device);
 #else
+static inline void vfio_kvm_file_replace(struct file **dst,
+		spinlock_t *lock, struct kvm *kvm)
+{
+}
+
 static inline void vfio_device_get_kvm_safe(struct vfio_device *device,
-					    struct kvm *kvm)
+					    struct file *kvm_file)
 {
 }
=20
diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
index 742477546b15..05ddd7344c18 100644
--- a/drivers/vfio/vfio_main.c
+++ b/drivers/vfio/vfio_main.c
@@ -433,54 +433,51 @@ void vfio_unregister_group_dev(struct vfio_device *de=
vice)
 EXPORT_SYMBOL_GPL(vfio_unregister_group_dev);
=20
 #if IS_ENABLED(CONFIG_KVM)
-void vfio_device_get_kvm_safe(struct vfio_device *device, struct kvm *kvm)
+void vfio_kvm_file_replace(struct file **dst, spinlock_t *lock, struct kvm=
 *kvm)
 {
-	void (*pfn)(struct kvm *kvm);
-	bool (*fn)(struct kvm *kvm);
-	bool ret;
+	struct file *old_kvm_file, *new_kvm_file =3D NULL;
=20
-	lockdep_assert_held(&device->dev_set->lock);
+	/*
+	 * @kvm can outlive the VM fd and its final __fput(). Only take a
+	 * new reference if the VM file is still active.
+	 */
+	if (kvm)
+		new_kvm_file =3D get_file_active(&kvm->_file);
=20
-	if (!kvm)
-		return;
+	spin_lock(lock);
+	old_kvm_file =3D *dst;
+	*dst =3D new_kvm_file;
+	spin_unlock(lock);
=20
-	pfn =3D symbol_get(kvm_put_kvm);
-	if (WARN_ON(!pfn))
-		return;
+	if (old_kvm_file)
+		fput(old_kvm_file);
+}
=20
-	fn =3D symbol_get(kvm_get_kvm_safe);
-	if (WARN_ON(!fn)) {
-		symbol_put(kvm_put_kvm);
-		return;
-	}
+void vfio_device_get_kvm_safe(struct vfio_device *device, struct file *kvm=
_file)
+{
+	lockdep_assert_held(&device->dev_set->lock);
=20
-	ret =3D fn(kvm);
-	symbol_put(kvm_get_kvm_safe);
-	if (!ret) {
-		symbol_put(kvm_put_kvm);
-		return;
-	}
+	/*
+	 * Take a VM file reference if the KVM fd is still active.
+	 */
+	if (kvm_file)
+		kvm_file =3D get_file(kvm_file);
=20
-	device->put_kvm =3D pfn;
-	device->kvm =3D kvm;
+	device->kvm_file =3D kvm_file;
 }
=20
 void vfio_device_put_kvm(struct vfio_device *device)
 {
+	struct file *kvm_file;
+
 	lockdep_assert_held(&device->dev_set->lock);
=20
-	if (!device->kvm)
+	kvm_file =3D device->kvm_file;
+	if (!kvm_file)
 		return;
=20
-	if (WARN_ON(!device->put_kvm))
-		goto clear;
-
-	device->put_kvm(device->kvm);
-	device->put_kvm =3D NULL;
-	symbol_put(kvm_put_kvm);
-
-clear:
-	device->kvm =3D NULL;
+	device->kvm_file =3D NULL;
+	fput(kvm_file);
 }
 #endif
=20
@@ -1488,13 +1485,10 @@ static void vfio_device_file_set_kvm(struct file *f=
ile, struct kvm *kvm)
 	struct vfio_device_file *df =3D file->private_data;
=20
 	/*
-	 * The kvm is first recorded in the vfio_device_file, and will
-	 * be propagated to vfio_device::kvm when the file is bound to
-	 * iommufd successfully in the vfio device cdev path.
+	 * Cache the VM file reference associated with this VFIO file so it
+	 * can be pinned into vfio_device while the device is open.
 	 */
-	spin_lock(&df->kvm_ref_lock);
-	df->kvm =3D kvm;
-	spin_unlock(&df->kvm_ref_lock);
+	vfio_kvm_file_replace(&df->kvm_file, &df->kvm_ref_lock, kvm);
 }
=20
 /**
@@ -1502,8 +1496,8 @@ static void vfio_device_file_set_kvm(struct file *fil=
e, struct kvm *kvm)
  * @file: VFIO group file or VFIO device file
  * @kvm: KVM to link
  *
- * When a VFIO device is first opened the KVM will be available in
- * device->kvm if one was associated with the file.
+ * When a VFIO device is first opened, VFIO caches a VM file reference if
+ * one was associated with the file.
  */
 void vfio_file_set_kvm(struct file *file, struct kvm *kvm)
 {
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 6b76e7a6f4c2..94812fb8e4cf 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -45,6 +45,8 @@
 #include <asm/kvm_host.h>
 #include <linux/kvm_dirty_ring.h>
=20
+struct file;
+
 #ifndef KVM_MAX_VCPU_IDS
 #define KVM_MAX_VCPU_IDS KVM_MAX_VCPUS
 #endif
@@ -860,6 +862,7 @@ struct kvm {
 	struct srcu_struct srcu;
 	struct srcu_struct irq_srcu;
 	pid_t userspace_pid;
+	struct file *_file;
 	bool override_halt_poll_ns;
 	unsigned int max_halt_poll_ns;
 	u32 dirty_ring_size;
diff --git a/include/linux/vfio.h b/include/linux/vfio.h
index e90859956514..e5fa5fb7f3fe 100644
--- a/include/linux/vfio.h
+++ b/include/linux/vfio.h
@@ -52,7 +52,7 @@ struct vfio_device {
 	struct vfio_device_set *dev_set;
 	struct list_head dev_set_list;
 	unsigned int migration_flags;
-	struct kvm *kvm;
+	struct file *kvm_file;
=20
 	/* Members below here are private, not for driver use */
 	unsigned int index;
@@ -64,7 +64,6 @@ struct vfio_device {
 	unsigned int open_count;
 	struct completion comp;
 	struct iommufd_access *iommufd_access;
-	void (*put_kvm)(struct kvm *kvm);
 	struct inode *inode;
 #if IS_ENABLED(CONFIG_IOMMUFD)
 	struct iommufd_device *iommufd_device;
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 9093251beb39..45e70ae78215 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -5507,6 +5507,7 @@ static int kvm_dev_ioctl_create_vm(unsigned long type)
 		r =3D PTR_ERR(file);
 		goto put_kvm;
 	}
+	kvm->_file =3D file;
=20
 	/*
 	 * Don't call kvm_put_kvm anymore at this point; file->f_op is
--=20
2.43.0

