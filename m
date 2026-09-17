Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14594566C40;
	Thu, 17 Sep 2026 14:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789653826; cv=none; b=iE3MWmTuz/yfKmzGvGSElBMGcHYGUrey3Ku1Bap/4IR2U4pGboQdPzoOGhkOyeWC26TLB6n8FHO0WGQAmUiQCxXnzwU18yxKMGFU0k5i3QeP6owEhFixjj6ZArvCNcG0pW/j9KilZGfgqZwMrGj4l23fPV1N29qFRVpfi9FwvW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789653826; c=relaxed/simple;
	bh=AiXUXEYeI3dv0Ek2R70toPCfHxO8CZdfF/oaLg7m5Yk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hhifI/Crx32tsUOPv6nvetw9yxq2FL6SSUkwSkcI2x+nP2W17Nnfq1Fti2ZxS5JMFeUR8FDJt/zXIgbW6XZdDxCx8RWDkRLFsUuMU8KJF338KadoIWM6rT8s3BzHXZ2zXV9yUZ7FvheN5AZ2aTFR2bnY1wTlgv7xeUMyZxnQV+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ayY7wVnl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ayY7wVnl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B46AB1F000FF;
	Thu, 17 Sep 2026 14:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789653824;
	bh=13baf1rjLpIrQ0sHp8XANd8ER0YUCiRI5yzi0IA1IIk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ayY7wVnlF++tHoBBimXiUGw+58KfCgx/uwfSzf4Yp1/gpVVSaeqan0P5HGHG+oNst
	 SI+TMfdfx1q9ve+G1BF9nNnc8VTAfuU9t4+Fx5LW/jjQkxCHW6h5MOjbYJdnoKNiOG
	 i822/GoHEApcjwBEp22UhnK7P0YkctTuCv0YwrNYSCgf+Iuy4kRrn9V1MGvZ0qMZJ0
	 0NhG92NUqAwsGtbsBTM0aobWEckIKsXNYNaLB7G3oLEnCj5a0woH9fmpuPSuhRZ7ut
	 L+uy7Uu53BR8BT3GH9UsjmqzejsFjBM4cmGKakZu/VmW2fNd1IXXdoxMixB4Td0HJM
	 zLhFIVP2D5T6Q==
From: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
To: linux-coco@lists.linux.dev,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Alexey Kardashevskiy <aik@amd.com>,
	Bjorn Helgaas <helgaas@kernel.org>,
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
	Paolo Bonzini <pbonzini@redhat.com>
Subject: [RFC PATCH v6 08/11] iommufd: Add vIOMMU provider support
Date: Thu, 17 Sep 2026 19:31:56 +0530
Message-ID: <20260917140159.1163281-9-aneesh.kumar@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260917140159.1163281-1-aneesh.kumar@kernel.org>
References: <20260917140159.1163281-1-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vIOMMU creation currently dispatches directly through the physical IOMMU
driver. Some vIOMMU types need an implementation supplied by another
subsystem, together with private data whose lifetime extends across all
vIOMMUs using that implementation.

Introduce a vIOMMU provider that associates implementation operations,
their module owner and private data. Allow one external provider to
register for each non-default vIOMMU type.

Look up an external provider first when allocating a vIOMMU. If none
matches the requested type, represent the physical IOMMU driver as a
fallback provider and dispatch through its get_viommu_size() and
viommu_init() operations.

A registered provider starts with one registration reference.
Registration does not pin the provider module. Each successful lookup
takes both a provider reference and a module reference. Unregistration
removes the provider from lookup before dropping the registration
reference and does not wait for existing vIOMMUs.

A fallback provider instance is created for each vIOMMU allocation. Its
initial users count of one represents the reference returned to that
allocation. It has no registration reference and is not shared with
other allocations, but otherwise follows the same lifetime rules as a
registered provider.

Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 drivers/iommu/iommufd/Makefile          |   3 +-
 drivers/iommu/iommufd/iommufd_private.h |  22 ++++
 drivers/iommu/iommufd/viommu.c          |  29 +++--
 drivers/iommu/iommufd/viommu_provider.c | 160 ++++++++++++++++++++++++
 include/linux/iommufd.h                 |  32 +++++
 5 files changed, 234 insertions(+), 12 deletions(-)
 create mode 100644 drivers/iommu/iommufd/viommu_provider.c

diff --git a/drivers/iommu/iommufd/Makefile b/drivers/iommu/iommufd/Makefile
index 71d692c9a8f4..7ed46c286c42 100644
--- a/drivers/iommu/iommufd/Makefile
+++ b/drivers/iommu/iommufd/Makefile
@@ -8,7 +8,8 @@ iommufd-y := \
 	main.o \
 	pages.o \
 	vfio_compat.o \
-	viommu.o
+	viommu.o \
+	viommu_provider.o
 
 iommufd-$(CONFIG_IOMMUFD_TEST) += selftest.o
 
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 6cf76f7ca379..eae607eb5d76 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -21,6 +21,28 @@ struct iommu_option;
 struct iommufd_device;
 struct dma_buf_attachment;
 
+/**
+ * struct iommufd_viommu_provider - vIOMMU implementation provider
+ * @node: entry in the provider registry
+ * @users: references retaining @ops, @owner, and @data; registered providers
+ *	have one registry reference plus one per live vIOMMU, while a fallback
+ *	provider is private to one vIOMMU
+ * @ops: provider operations
+ * @owner: module implementing @ops
+ * @data: provider-private data retained until the final reference is released
+ */
+struct iommufd_viommu_provider {
+	struct list_head node;
+	const struct iommufd_viommu_provider_ops *ops;
+	refcount_t users;
+	struct module *owner;
+	void *data;
+};
+
+void iommufd_put_viommu_provider(struct iommufd_viommu_provider *provider);
+struct iommufd_viommu_provider *
+iommufd_get_viommu_provider(struct device *dev, enum iommu_viommu_type type);
+
 struct iommufd_sw_msi_map {
 	struct list_head sw_msi_item;
 	phys_addr_t sw_msi_start;
diff --git a/drivers/iommu/iommufd/viommu.c b/drivers/iommu/iommufd/viommu.c
index bf5d58d55939..66bbd6e4571d 100644
--- a/drivers/iommu/iommufd/viommu.c
+++ b/drivers/iommu/iommufd/viommu.c
@@ -11,6 +11,7 @@ void iommufd_viommu_destroy(struct iommufd_object *obj)
 
 	if (viommu->ops && viommu->ops->destroy)
 		viommu->ops->destroy(viommu);
+	iommufd_put_viommu_provider(viommu->provider);
 	refcount_dec(&viommu->hwpt->common.obj.users);
 	if (viommu->kvm_file)
 		fput(viommu->kvm_file);
@@ -28,7 +29,7 @@ int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd)
 	struct iommufd_hwpt_paging *hwpt_paging;
 	struct iommufd_viommu *viommu;
 	struct iommufd_device *idev;
-	const struct iommu_ops *ops;
+	struct iommufd_viommu_provider *provider = NULL;
 	size_t viommu_size;
 	int rc;
 
@@ -39,16 +40,16 @@ int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd)
 	if (IS_ERR(idev))
 		return PTR_ERR(idev);
 
-	ops = dev_iommu_ops(idev->dev);
-	if (!ops->get_viommu_size || !ops->viommu_init) {
-		rc = -EOPNOTSUPP;
+	provider = iommufd_get_viommu_provider(idev->dev, cmd->type);
+	if (IS_ERR(provider)) {
+		rc = PTR_ERR(provider);
+		provider = NULL;
 		goto out_put_idev;
 	}
-
-	viommu_size = ops->get_viommu_size(idev->dev, cmd->type);
+	viommu_size = provider->ops->get_size(idev->dev, cmd->type);
 	if (!viommu_size) {
 		rc = -EOPNOTSUPP;
-		goto out_put_idev;
+		goto out_put_provider;
 	}
 
 	/*
@@ -57,13 +58,13 @@ int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd)
 	 */
 	if (WARN_ON_ONCE(viommu_size < sizeof(*viommu))) {
 		rc = -EOPNOTSUPP;
-		goto out_put_idev;
+		goto out_put_provider;
 	}
 
 	hwpt_paging = iommufd_get_hwpt_paging(ucmd, cmd->hwpt_id);
 	if (IS_ERR(hwpt_paging)) {
 		rc = PTR_ERR(hwpt_paging);
-		goto out_put_idev;
+		goto out_put_provider;
 	}
 
 	if (!hwpt_paging->nest_parent) {
@@ -84,6 +85,9 @@ int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd)
 	viommu->type = cmd->type;
 	viommu->ictx = ucmd->ictx;
 	viommu->hwpt = hwpt_paging;
+	viommu->provider = provider;
+	viommu->provider_data = provider->data;
+	provider = NULL;
 	refcount_inc(&viommu->hwpt->common.obj.users);
 	INIT_LIST_HEAD(&viommu->veventqs);
 	init_rwsem(&viommu->veventqs_rwsem);
@@ -94,8 +98,9 @@ int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd)
 	 */
 	viommu->iommu_dev = __iommu_get_iommu_dev(idev->dev);
 
-	rc = ops->viommu_init(viommu, hwpt_paging->common.domain,
-			      user_data.len ? &user_data : NULL);
+	rc = viommu->provider->ops->init(viommu, idev->dev,
+					 hwpt_paging->common.domain,
+					 user_data.len ? &user_data : NULL);
 	if (rc)
 		goto out_put_hwpt;
 
@@ -110,6 +115,8 @@ int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd)
 
 out_put_hwpt:
 	iommufd_put_object(ucmd->ictx, &hwpt_paging->common.obj);
+out_put_provider:
+	iommufd_put_viommu_provider(provider);
 out_put_idev:
 	iommufd_put_object(ucmd->ictx, &idev->obj);
 	return rc;
diff --git a/drivers/iommu/iommufd/viommu_provider.c b/drivers/iommu/iommufd/viommu_provider.c
new file mode 100644
index 000000000000..5dda907d2abb
--- /dev/null
+++ b/drivers/iommu/iommufd/viommu_provider.c
@@ -0,0 +1,160 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2026 ARM Ltd.
+ */
+#include <linux/module.h>
+#include <linux/slab.h>
+
+#include "iommufd_private.h"
+
+static LIST_HEAD(viommu_providers);
+static DEFINE_MUTEX(viommu_providers_lock);
+
+static struct iommufd_viommu_provider *
+viommu_find_provider(enum iommu_viommu_type type)
+{
+	struct iommufd_viommu_provider *provider;
+
+	lockdep_assert_held(&viommu_providers_lock);
+	list_for_each_entry(provider, &viommu_providers, node)
+		if (provider->ops->type == type)
+			return provider;
+	return NULL;
+}
+
+static void viommu_provider_put(struct iommufd_viommu_provider *provider)
+{
+	if (!refcount_dec_and_test(&provider->users))
+		return;
+	if (provider->ops->release)
+		provider->ops->release(provider->data);
+	kfree(provider);
+}
+
+void iommufd_put_viommu_provider(struct iommufd_viommu_provider *provider)
+{
+	struct module *owner;
+
+	if (!provider)
+		return;
+
+	owner = provider->owner;
+	viommu_provider_put(provider);
+	module_put(owner);
+}
+
+/**
+ * iommufd_register_viommu_provider() - Register an external vIOMMU provider
+ * @ops: Provider operations, including its module owner and exact type
+ * @data: Private data to retain until the final provider release
+ *
+ * Only one provider may be registered per type. ops->release() is called
+ * after unregister and the last vIOMMU release. Registration itself does
+ * not pin the module; each allocation does.
+ *
+ * Return: Registration handle or ERR_PTR() on failure.
+ */
+struct iommufd_viommu_provider *
+iommufd_register_viommu_provider(const struct iommufd_viommu_provider_ops *ops,
+	    void *data)
+{
+	struct iommufd_viommu_provider *provider;
+
+	if (ops->type == IOMMU_VIOMMU_TYPE_DEFAULT ||
+	    !ops->get_size || !ops->init)
+		return ERR_PTR(-EINVAL);
+
+	provider = kzalloc_obj(*provider);
+	if (!provider)
+		return ERR_PTR(-ENOMEM);
+	provider->ops = ops;
+	provider->owner = ops->owner;
+	provider->data = data;
+	refcount_set(&provider->users, 1);
+
+	mutex_lock(&viommu_providers_lock);
+	if (viommu_find_provider(ops->type)) {
+		mutex_unlock(&viommu_providers_lock);
+		kfree(provider);
+		return ERR_PTR(-EBUSY);
+	}
+	list_add_tail(&provider->node, &viommu_providers);
+	mutex_unlock(&viommu_providers_lock);
+	return provider;
+}
+EXPORT_SYMBOL_NS_GPL(iommufd_register_viommu_provider, "IOMMUFD");
+
+/**
+ * iommufd_unregister_viommu_provider() - Stop new lookups of a provider
+ * @provider: Handle returned by iommufd_register_viommu_provider()
+ *
+ * Call once per registration. Existing vIOMMUs retain the operations,
+ * private data and module until destruction. This does not wait for them
+ * to be released.
+ */
+void iommufd_unregister_viommu_provider(struct iommufd_viommu_provider *provider)
+{
+	mutex_lock(&viommu_providers_lock);
+	list_del(&provider->node);
+	mutex_unlock(&viommu_providers_lock);
+	viommu_provider_put(provider);
+}
+EXPORT_SYMBOL_NS_GPL(iommufd_unregister_viommu_provider, "IOMMUFD");
+
+static size_t fallback_viommu_get_size(struct device *dev,
+		enum iommu_viommu_type type)
+{
+	return dev_iommu_ops(dev)->get_viommu_size(dev, type);
+}
+
+static int fallback_viommu_init(struct iommufd_viommu *viommu,
+		struct device *dev, struct iommu_domain *parent,
+		const struct iommu_user_data *user_data)
+{
+	const struct iommu_ops *ops = viommu->provider_data;
+
+	return ops->viommu_init(viommu, parent, user_data);
+}
+
+static const struct iommufd_viommu_provider_ops fallback_viommu_provider_ops = {
+	.get_size = fallback_viommu_get_size,
+	.init = fallback_viommu_init,
+};
+
+struct iommufd_viommu_provider *
+iommufd_get_viommu_provider(struct device *dev, enum iommu_viommu_type type)
+{
+	const struct iommu_ops *iommu_ops;
+	struct iommufd_viommu_provider *provider;
+
+	mutex_lock(&viommu_providers_lock);
+	provider = viommu_find_provider(type);
+	if (provider) {
+		if (!try_module_get(provider->owner)) {
+			mutex_unlock(&viommu_providers_lock);
+			return ERR_PTR(-ENODEV);
+		}
+		refcount_inc(&provider->users);
+		mutex_unlock(&viommu_providers_lock);
+		return provider;
+	}
+	mutex_unlock(&viommu_providers_lock);
+
+	iommu_ops = dev_iommu_ops(dev);
+	if (!iommu_ops->get_viommu_size || !iommu_ops->viommu_init)
+		return ERR_PTR(-EOPNOTSUPP);
+	if (!try_module_get(iommu_ops->owner))
+		return ERR_PTR(-ENODEV);
+
+	provider = kzalloc_obj(*provider);
+	if (!provider) {
+		module_put(iommu_ops->owner);
+		return ERR_PTR(-ENOMEM);
+	}
+	provider->ops = &fallback_viommu_provider_ops;
+	provider->owner = iommu_ops->owner;
+	provider->data = (void *)iommu_ops;
+	refcount_set(&provider->users, 1);
+	return provider;
+}
+
diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
index 3267717f676d..7b906e0d6400 100644
--- a/include/linux/iommufd.h
+++ b/include/linux/iommufd.h
@@ -22,9 +22,39 @@ struct iommu_user_data_array;
 struct iommufd_access;
 struct iommufd_ctx;
 struct iommufd_device;
+struct iommufd_viommu;
 struct iommufd_viommu_ops;
+struct iommufd_viommu_provider;
+struct module;
 struct page;
 
+/**
+ * struct iommufd_viommu_provider_ops - External vIOMMU implementation
+ * @owner: Module implementing the callbacks
+ * @type: Exact vIOMMU type implemented by this provider
+ * @get_size: Allocation size for a device, or zero if unsupported
+ * @init: Initialize the vIOMMU; private data is in viommu->provider_data
+ * @release: Optional final release of the registration's private data
+ *
+ * Callbacks run without the registry lock held. The operations must remain
+ * valid until @release completes. An allocation failure is authoritative:
+ * it must not cause allocation through the physical IOMMU driver instead.
+ */
+struct iommufd_viommu_provider_ops {
+	struct module *owner;
+	enum iommu_viommu_type type;
+	size_t (*get_size)(struct device *dev, enum iommu_viommu_type type);
+	int (*init)(struct iommufd_viommu *viommu, struct device *dev,
+		    struct iommu_domain *parent,
+		    const struct iommu_user_data *user_data);
+	void (*release)(void *data);
+};
+
+struct iommufd_viommu_provider *
+iommufd_register_viommu_provider(const struct iommufd_viommu_provider_ops *ops,
+	     void *data);
+void iommufd_unregister_viommu_provider(struct iommufd_viommu_provider *provider);
+
 enum iommufd_object_type {
 	IOMMUFD_OBJ_NONE,
 	IOMMUFD_OBJ_ANY = IOMMUFD_OBJ_NONE,
@@ -104,6 +134,8 @@ struct iommufd_viommu {
 	struct iommu_device *iommu_dev;
 	struct iommufd_hwpt_paging *hwpt;
 	struct file *kvm_file;
+	struct iommufd_viommu_provider *provider;
+	void *provider_data;
 
 	const struct iommufd_viommu_ops *ops;
 
-- 
2.43.0

