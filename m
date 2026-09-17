Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D90D4CDA22;
	Thu, 17 Sep 2026 14:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789654653; cv=none; b=sCf5Vlzmj+mqIDvNdqiWnMuU9GxjfxGyN8AGRHUHiwQNXHKEFBQExFTCASxLAZIOgVTCle577LMNCZengR/JNd4N/diozRvfyJDLKXauopbtdlHIusxPCQBnwjRqzZ29fjbnH/XH1ywducAy/vZuIB/EeMEJVLG3kXkAcgAAgYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789654653; c=relaxed/simple;
	bh=KUsWfUmR/YkNz1cVII4rJx/gCm1LD/pb+4mqpUO+M4c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Qh6DbD2l8h5QFlPpHzPteR3BHpMLp7TFaTpD6uyLlK5yY74gV4+GD2RxPFqNi9SVrxV/8T83/ToHzSjmk7cWoIxXNVlQBM1weD4PJ68mtrnGkUawShTd3AY2ySmefF4HDx1LJ0ddILElvm2SukKU6mufeipYTPMQkH8Vd9vj6VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YB6En9N7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YB6En9N7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2C9D1F000FF;
	Thu, 17 Sep 2026 14:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789654651;
	bh=rnjriWvdE1yvZq6NzpfFMgF3p9YCgsclH/C0ba5bhBY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=YB6En9N7IUjIl3x29LX93QGBwHx6qcTGsAQ1SzImnoREdd40/BS+NOIqYCP/4dXjK
	 N3RFRx9kcsWNpDbXESFuvQrqnNDZmFCdf0OI/I1SC1QnFTjvLDhAdVEhUYOxf6YPQV
	 HcGNvX3eBNnWZW5pdKM4j9SLckYzxo7eiiTFJmJUtUEASL9mjWTUrpEObcSSiBh3Ke
	 16hRI/Qqjsx3cCY+zQkntTUaEENlzcfHJ0F1uQsBHd99kByWq3V6Cb3H6IZmPTRY1b
	 ejz5qlBgY/0G19vMsa+mqywCzTX0LINfNGLNokauo1N5MuGJZ1ATfxVP8QbkDw7zde
	 VZawm0aUR1SDw==
X-Mailer: emacs 31.1 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: linux-coco@lists.linux.dev, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
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
Subject: Re: [RFC PATCH v6 00/11] iommufd: Infrastructure for vIOMMU
 creation for confidential guests and guest TSM requests
In-Reply-To: <20260917140159.1163281-1-aneesh.kumar@kernel.org>
References: <20260917140159.1163281-1-aneesh.kumar@kernel.org>
Date: Thu, 17 Sep 2026 19:47:21 +0530
Message-ID: <yq5afqz80xou.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

"Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org> writes:

> This series adds the IOMMUFD and PCI/TSM infrastructure required for device
> assignment. It introduces an IOMMUFD-owned vIOMMU provider registry and the
> IOMMU_VDEVICE_TSM_REQ ioctl.
>
> The series adds a vIOMMU provider abstraction that allows a subsystem
> other than the physical IOMMU driver to implement a vIOMMU type. It groups
> the vIOMMU operations with their module owner and private data, and makes
> that implementation discoverable during vIOMMU allocation.
>
> External providers are selected by exact vIOMMU type. When no provider
> matches, vIOMMU creation falls back to the physical IOMMU driver. Once a
> provider matches, its result is authoritative and failures do not trigger
> fallback.
>
> Guest TSM requests are dispatched through the vdevice. PCI/TSM uses
> reference-counted contexts to retain the resources needed by providers,
> without introducing separate IOMMUFD TSM bind or unbind ioctls.
>
> Note: Codex was used to assist with commit message formatting and code
> rearrangement.
>

 [ ... 99 lines skipped ... ] 

Related Arm CCA host changes is below

commit 66225895e48fa38b13aea493e1e6e3babab8f6aa
Author: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
Date:   Wed Sep 16 14:06:15 2026 +0530

    virt: arm-cca-host: Register the Realm vIOMMU provider with IOMMUFD
    
    Register the Realm SMMUv3 provider directly with IOMMUFD. Retain active TSM
    resources until the final provider release and remove the registration
    before TSM teardown.
    
    Create CCA-owned vdevices using PCI/TSM contexts, balance pSMMU stream-
    table lifetime, and mark a function bound only after successful
    initialization. Keep the KVM file and active pSMMU alive through the vIOMMU
    lifetime.

diff --git a/drivers/virt/coco/arm-cca-host/Kconfig b/drivers/virt/coco/arm-cca-host/Kconfig
index 4a2bc64c2568..d0c636f92d9e 100644
--- a/drivers/virt/coco/arm-cca-host/Kconfig
+++ b/drivers/virt/coco/arm-cca-host/Kconfig
@@ -7,6 +7,7 @@ config ARM_CCA_HOST
 	depends on ARM64
 	depends on PCI
 	depends on ARM_RMM
+	depends on IOMMUFD
 	depends on HAVE_ARM_SMCCC_DISCOVERY
 	select PCI_TSM
 	select KEYS
diff --git a/drivers/virt/coco/arm-cca-host/Makefile b/drivers/virt/coco/arm-cca-host/Makefile
index d48e8940af46..2732352a7ae2 100644
--- a/drivers/virt/coco/arm-cca-host/Makefile
+++ b/drivers/virt/coco/arm-cca-host/Makefile
@@ -2,4 +2,4 @@
 #
 obj-$(CONFIG_ARM_CCA_HOST) += arm-cca-host.o
 
-arm-cca-host-y	+=  arm-cca.o rmi-da.o
+arm-cca-host-y	+=  arm-cca.o rmi-da.o viommu.o
diff --git a/drivers/virt/coco/arm-cca-host/arm-cca.c b/drivers/virt/coco/arm-cca-host/arm-cca.c
index 182733e00dfc..b5d50685eaeb 100644
--- a/drivers/virt/coco/arm-cca-host/arm-cca.c
+++ b/drivers/virt/coco/arm-cca-host/arm-cca.c
@@ -5,6 +5,7 @@
 
 #include <linux/arm-smccc.h>
 #include <linux/arm-smccc-bus.h>
+#include <linux/iommufd.h>
 #include <linux/pci-tsm.h>
 #include <linux/pci-ide.h>
 #include <linux/module.h>
@@ -427,6 +428,24 @@ static struct pci_tsm_ops cca_link_pci_ops = {
 	.disconnect = cca_tsm_disconnect,
 };
 
+static void cca_viommu_provider_release(void *data)
+{
+	tsm_put(data);
+}
+
+static const struct iommufd_viommu_provider_ops cca_viommu_provider_ops = {
+	.owner = THIS_MODULE,
+	.type = IOMMU_VIOMMU_TYPE_ARM_REALM_SMMUV3,
+	.get_size = cca_viommu_get_size,
+	.init = cca_viommu_init,
+	.release = cca_viommu_provider_release,
+};
+
+static void cca_viommu_provider_remove(void *provider)
+{
+	iommufd_unregister_viommu_provider(provider);
+}
+
 static void cca_link_tsm_remove(void *tsm_dev)
 {
 	tsm_unregister(tsm_dev);
@@ -439,7 +458,9 @@ static bool rmi_has_reg2_feature(unsigned long feature)
 
 static int cca_link_tsm_probe(struct arm_smccc_device *sdev)
 {
+	struct iommufd_viommu_provider *provider;
 	struct tsm_dev *tsm_dev;
+	int ret;
 
 	if (!rmi_has_reg2_feature(RMI_FEATURE_REGISTER_2_DA))
 		return -ENODEV;
@@ -448,8 +469,22 @@ static int cca_link_tsm_probe(struct arm_smccc_device *sdev)
 	if (IS_ERR(tsm_dev))
 		return PTR_ERR(tsm_dev);
 
-	return devm_add_action_or_reset(&sdev->dev, cca_link_tsm_remove,
-					tsm_dev);
+	ret = devm_add_action_or_reset(&sdev->dev, cca_link_tsm_remove, tsm_dev);
+	if (ret)
+		return ret;
+
+	/* Retain PCI/TSM resources until the last provider user is released. */
+	tsm_get(tsm_dev);
+	provider = iommufd_register_viommu_provider(&cca_viommu_provider_ops,
+						  tsm_dev);
+	if (IS_ERR(provider)) {
+		tsm_put(tsm_dev);
+		return PTR_ERR(provider);
+	}
+
+	/* Remove from lookup before the earlier TSM unregister action runs. */
+	return devm_add_action_or_reset(&sdev->dev, cca_viommu_provider_remove,
+					provider);
 }
 
 static const struct arm_smccc_device_id cca_link_tsm_id_table[] = {
diff --git a/drivers/virt/coco/arm-cca-host/rmi-da.h b/drivers/virt/coco/arm-cca-host/rmi-da.h
index 306f64749f26..07642eeb3245 100644
--- a/drivers/virt/coco/arm-cca-host/rmi-da.h
+++ b/drivers/virt/coco/arm-cca-host/rmi-da.h
@@ -16,6 +16,11 @@
 #include <linux/atomic.h>
 #include <linux/kref.h>
 #include <linux/wait.h>
+#include <uapi/linux/iommufd.h>
+
+struct iommufd_viommu;
+struct iommu_domain;
+struct iommu_user_data;
 
 #define MAX_CACHE_OBJ_SIZE	SZ_16M
 #define CACHE_CHUNK_SIZE	SZ_4K
@@ -119,6 +124,11 @@ struct cca_host_fn_dsc {
 	struct pci_tsm pci;
 };
 
+size_t cca_viommu_get_size(struct device *dev, enum iommu_viommu_type type);
+int cca_viommu_init(struct iommufd_viommu *viommu, struct device *dev,
+		    struct iommu_domain *parent,
+		    const struct iommu_user_data *user_data);
+
 enum dev_comm_type {
 	PDEV_COMMUNICATE = 0x1,
 	VDEV_COMMUNICATE = 0x2,
diff --git a/drivers/virt/coco/arm-cca-host/viommu.c b/drivers/virt/coco/arm-cca-host/viommu.c
index 5cd261551b17..9daa3ff3ca1c 100644
--- a/drivers/virt/coco/arm-cca-host/viommu.c
+++ b/drivers/virt/coco/arm-cca-host/viommu.c
@@ -32,6 +32,13 @@ struct cca_viommu {
 	struct cca_psmmu *psmmu;
 };
 
+struct cca_vdevice {
+	struct iommufd_vdevice core;
+	struct pci_tsm_context *tsm_context;
+	struct cca_host_tdi host_tdi;
+	u32 l2_sid;
+};
+
 static LIST_HEAD(cca_psmmus);
 static DEFINE_MUTEX(cca_psmmus_lock);
 
@@ -40,6 +47,11 @@ static struct cca_viommu *to_cca_viommu(struct iommufd_viommu *viommu)
 	return container_of(viommu, struct cca_viommu, core);
 }
 
+static struct tsm_dev *cca_viommu_tsm_dev(struct iommufd_viommu *viommu)
+{
+	return viommu->provider_data;
+}
+
 static struct cca_psmmu *
 cca_psmmu_get(const struct arm_smmu_realm_params *params)
 {
@@ -99,3 +111,192 @@ static void cca_psmmu_put(struct cca_psmmu *psmmu)
 	list_del(&psmmu->node);
 	kfree(psmmu);
 }
+
+static void cca_viommu_destroy(struct iommufd_viommu *viommu)
+{
+	struct cca_viommu *cca = to_cca_viommu(viommu);
+
+	if (cca->psmmu)
+		cca_psmmu_put(cca->psmmu);
+}
+
+static int cca_psmmu_create_l2(struct cca_psmmu *psmmu, u32 l2_sid)
+{
+	unsigned long rmi_ret = 0;
+	int ret;
+
+	guard(mutex)(&cca_psmmus_lock);
+	ret = rmi_psmmu_st_l2_create(psmmu->phys, l2_sid, &rmi_ret);
+	if (!ret && !rmi_ret)
+		return 0;
+	if (RMI_RETURN_STATUS(rmi_ret) == RMI_ERROR_PSMMU_ST &&
+	    RMI_RETURN_INDEX(rmi_ret) == 2)
+		return 0;
+	return -EIO;
+}
+
+static void cca_psmmu_destroy_l2(struct cca_psmmu *psmmu, u32 l2_sid,
+				 struct device *dev)
+{
+	unsigned long rmi_ret = 0;
+	int ret;
+
+	guard(mutex)(&cca_psmmus_lock);
+	ret = rmi_psmmu_st_l2_destroy(psmmu->phys, l2_sid, &rmi_ret);
+	if (!ret && !rmi_ret)
+		return;
+	if (RMI_RETURN_STATUS(rmi_ret) == RMI_ERROR_PSMMU_ST &&
+	    RMI_RETURN_INDEX(rmi_ret) == 2)
+		return;
+	dev_warn(dev, "failed to destroy Realm stream mapping\n");
+}
+
+static void cca_vdevice_destroy(struct iommufd_vdevice *vdev)
+{
+	struct cca_vdevice *cca_vdev =
+		container_of(vdev, struct cca_vdevice, core);
+	struct cca_viommu *cca = to_cca_viommu(vdev->viommu);
+	struct device *dev = iommufd_vdevice_to_device(vdev);
+	struct pci_tsm_context *context = cca_vdev->tsm_context;
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct pci_tsm_pf0 *pf0 = pci_tsm_context_pf0(context);
+	struct pci_dev *dsm_dev = pci_tsm_context_dsm_dev(context);
+	struct cca_host_tdi *host_tdi = &cca_vdev->host_tdi;
+	struct realm *realm = &host_tdi->kvm->arch.realm;
+
+	scoped_guard(mutex, &pf0->lock) {
+		cca_vdev_destroy(host_tdi, realm, pdev, dsm_dev);
+		kvfree(host_tdi->interface_report);
+		kvfree(host_tdi->measurements);
+		cca_psmmu_destroy_l2(cca->psmmu, cca_vdev->l2_sid, dev);
+	}
+	pci_tsm_context_put(context);
+}
+
+static int cca_vdevice_init(struct iommufd_vdevice *vdev)
+{
+	struct cca_vdevice *cca_vdev =
+		container_of(vdev, struct cca_vdevice, core);
+	struct arm_smmu_realm_params params;
+	struct cca_viommu *cca = to_cca_viommu(vdev->viommu);
+	struct cca_psmmu *psmmu = cca->psmmu;
+	struct device *dev = iommufd_vdevice_to_device(vdev);
+	struct tsm_dev *tsm_dev = cca_viommu_tsm_dev(vdev->viommu);
+	struct pci_tsm_context *context;
+	struct pci_dev *pdev;
+	struct pci_tsm_pf0 *pf0;
+	struct pci_dev *dsm_dev;
+	struct cca_host_tdi *host_tdi = &cca_vdev->host_tdi;
+	struct kvm *kvm = vdev->viommu->kvm_file->private_data;
+	void *rmm_vdev;
+	int ret;
+
+	if (!dev_is_pci(dev))
+		return 0;
+	/* Devices without a Link TSM remain ordinary vdevices. */
+	pdev = to_pci_dev(dev);
+	context = pci_tsm_context_get(pdev);
+	if (IS_ERR(context)) {
+		if (PTR_ERR(context) == -EOPNOTSUPP)
+			return 0;
+		return PTR_ERR(context);
+	}
+	if (pci_tsm_context_tsm_dev(context) != tsm_dev) {
+		ret = -EXDEV;
+		goto out_put_context;
+	}
+
+	ret = iommu_viommu_get_params(dev,
+		IOMMU_VIOMMU_TYPE_ARM_REALM_SMMUV3, &params,
+		sizeof(params));
+	if (ret)
+		goto out_put_context;
+	if (params.psmmu_phys != psmmu->phys) {
+		ret = -EINVAL;
+		goto out_put_context;
+	}
+
+	host_tdi->kvm = kvm;
+	cca_vdev->l2_sid = params.l2_sid;
+	pf0 = pci_tsm_context_pf0(context);
+	dsm_dev = pci_tsm_context_dsm_dev(context);
+
+	scoped_guard(mutex, &pf0->lock) {
+		ret = cca_psmmu_create_l2(psmmu, params.l2_sid);
+		if (!ret) {
+			rmm_vdev = cca_vdev_create(host_tdi, &kvm->arch.realm,
+						   pdev, dsm_dev, vdev->virt_id);
+			if (IS_ERR_OR_NULL(rmm_vdev)) {
+				ret = rmm_vdev ? PTR_ERR(rmm_vdev) : -ENOMEM;
+				cca_psmmu_destroy_l2(psmmu, params.l2_sid, dev);
+			}
+		}
+		if (!ret)
+			pci_tsm_context_mark_bound(context);
+	}
+	if (ret)
+		goto out_put_context;
+	cca_vdev->tsm_context = context;
+	vdev->destroy = cca_vdevice_destroy;
+	return 0;
+
+out_put_context:
+	pci_tsm_context_put(context);
+	return ret;
+}
+
+static const struct iommufd_viommu_ops cca_viommu_ops = {
+	.destroy = cca_viommu_destroy,
+	.vdevice_size = VDEVICE_STRUCT_SIZE(struct cca_vdevice, core),
+	.vdevice_init = cca_vdevice_init,
+};
+
+size_t cca_viommu_get_size(struct device *dev, enum iommu_viommu_type type)
+{
+	struct arm_smmu_realm_params params;
+
+	if (type != IOMMU_VIOMMU_TYPE_ARM_REALM_SMMUV3)
+		return 0;
+	if (iommu_viommu_get_params(dev, type, &params, sizeof(params)))
+		return 0;
+	return VIOMMU_STRUCT_SIZE(struct cca_viommu, core);
+}
+
+int cca_viommu_init(struct iommufd_viommu *viommu, struct device *dev,
+		    struct iommu_domain *parent,
+		    const struct iommu_user_data *user_data)
+{
+	struct arm_smmu_realm_params params;
+	struct cca_viommu *cca = to_cca_viommu(viommu);
+	struct cca_psmmu *psmmu;
+	struct kvm *kvm;
+	int ret;
+
+	(void)user_data;
+
+	if (viommu->type != IOMMU_VIOMMU_TYPE_ARM_REALM_SMMUV3)
+		return -EOPNOTSUPP;
+	if (!viommu->kvm_file)
+		return -EINVAL;
+	kvm = viommu->kvm_file->private_data;
+	ret = kvm_realm_ensure_created(kvm);
+	if (ret)
+		return ret;
+
+	ret = iommu_viommu_validate_parent(dev, viommu->type, parent);
+	if (ret)
+		return ret;
+	ret = iommu_viommu_get_params(dev, viommu->type, &params,
+				      sizeof(params));
+	if (ret)
+		return ret;
+
+	psmmu = cca_psmmu_get(&params);
+	if (IS_ERR(psmmu))
+		return PTR_ERR(psmmu);
+	cca->psmmu = psmmu;
+	viommu->ops = &cca_viommu_ops;
+	return 0;
+}
+
+MODULE_IMPORT_NS("IOMMUFD");
