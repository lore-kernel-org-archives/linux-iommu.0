Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE893B298
	for <iommu@lists.linux.dev>; Fri, 14 Jun 2024 14:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718374951; cv=none; b=juhwxGP7ztpqUn6aa1SNhkeXQnFECpJP6bGVWMtPQDw0ZWaK7WHFvgXexoLfUseutjbBpu8w5OaPZJhXpaY+SzCPg7qArvehzEwf9OyFpcZ3iOcgVfD9nLchdpfZPj58kniozb0G1nMoj3VIJ1paUDL9D40uhBu9/gFK0ZJFZ/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718374951; c=relaxed/simple;
	bh=0WtTHd7iSMjiPjoMS8n7GM1ddQK8hL6JoJsay6C2jRs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=gvH8qmwSKD8JiXD/amrZbBUKSmjVqz26PXCcooF38bGIrl2XHDdIRZHrYpJ3AkayYKyenuVag4pVGxyo+jAa4x8MBdPISJgCpM+xO/b2rXDlw//LG+q8DN7wS48BYIoNXsxYbFW0opZlWDAzHnTLrgnsH2b/WFhTVochjThtdb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=F+InKtUb; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="F+InKtUb"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1f6f1677b26so16573555ad.0
        for <iommu@lists.linux.dev>; Fri, 14 Jun 2024 07:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1718374948; x=1718979748; darn=lists.linux.dev;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=icfonVjdOGiS4jBGMCDTwtNC3iVuGDFaRUw0zwHlFBc=;
        b=F+InKtUb64PINufve4o5rkHWEmIFMOUAhkw3TiAUskFrvw6wcyTmk+D+ri1IGcqGk2
         WoA7Fed6Gnrgn2zstyuhUWmO2eu7DGTZy6DGNnb4dQrUPN4IM/190IfUOta5QEB9fjsn
         7WUrKCCwquY/tztdeN82VNkRas2HRqEryhMszjjAW9O+8i8oUbW0+QqK0vdwQgY4bCOT
         MpHINGMX3haX/4vMtVAMLNeTXEa8AGUDKhxOu6/RcVCx+twcV2HpRUnelgN9PPE33uKe
         lfsIA4yoDIMddOOAbbaSRnk/MEhq7pSKzNVG0hnqApwUVRlVSftQfHqwWQplr2FHeRbV
         2dag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718374948; x=1718979748;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=icfonVjdOGiS4jBGMCDTwtNC3iVuGDFaRUw0zwHlFBc=;
        b=WbAjMrPomQvb8mSxgV1qYk5xTlnAkKLk+30kFpwi8L4myeTX9U3BrGVUfdRffqe9ln
         RPGeKioNMIB4VGa++NdgK0M47JyVB9PCnwIjZrVWGb560w7SJwxb/+N+Xv++xeLfcsHe
         OOKZLpqZTnzK0EZ17Kx5m3m8p2+FjDv1SXcKSNSZ6EDw4ARMl+QlqGS8IutZqohMTPe5
         FoFIxcgaR5Z/HjlZodZLNoIrcb1JjK0QJhZZXjyNW/mqv9yuq+6HPZMpYcdoyo1b2py1
         ooV9Gf/WDVTnS8BFXThUe7G0iwH2lJl+5c6qZCDH7pxDKtNi/guNg7WdcYkzoj96hK8L
         odZg==
X-Forwarded-Encrypted: i=1; AJvYcCVbyVirYAD6IaMYVmCm5oS8TbbBDqOG/nVTscx7gz94lQSX07FMgi8QFA8PEeIwuKujAJnUfL79AgrLJmxgv2hCxZONtS8=
X-Gm-Message-State: AOJu0YyXNkrqP18MSocJECM9lMX702CY831fZRkqMvZ8hdlMWz8uqW2l
	JR00PjwWUClg9rs8JwTvvMte3o1m8YW1uoFE0demcskmx5ujoyQf148gEbceDsM=
X-Google-Smtp-Source: AGHT+IHErCU6r7FcqlhN+6YKmphLPYai+yLyt0MfvZY472OSF5t8ZLzOGhTYEkvrbQPRWasAsRJaag==
X-Received: by 2002:a17:902:d2ca:b0:1f7:207f:7081 with SMTP id d9443c01a7336-1f84e1d39e7mr99383395ad.14.1718374947672;
        Fri, 14 Jun 2024 07:22:27 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855e559d9sm32522005ad.35.2024.06.14.07.22.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 07:22:27 -0700 (PDT)
From: Zong Li <zong.li@sifive.com>
To: joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	tjeznach@rivosinc.com,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	jgg@ziepe.ca,
	kevin.tian@intel.com,
	linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-riscv@lists.infradead.org
Cc: Zong Li <zong.li@sifive.com>
Subject: [RFC PATCH v2 07/10] iommu/riscv: support nested iommu for creating domains owned by userspace
Date: Fri, 14 Jun 2024 22:21:53 +0800
Message-Id: <20240614142156.29420-8-zong.li@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240614142156.29420-1-zong.li@sifive.com>
References: <20240614142156.29420-1-zong.li@sifive.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

This patch implements .domain_alloc_user operation for creating domains
owend by userspace, e.g. through IOMMUFD. Add s2 domain for parent
domain for second stage, s1 domain will be the first stage.

Don't remove IOMMU private data of dev in blocked domain, because it
holds the user data of device, which is used when attaching device into
s1 domain.

Signed-off-by: Zong Li <zong.li@sifive.com>
---
 drivers/iommu/riscv/iommu.c  | 236 ++++++++++++++++++++++++++++++++++-
 include/uapi/linux/iommufd.h |  17 +++
 2 files changed, 252 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
index 2130106e421f..410b236e9b24 100644
--- a/drivers/iommu/riscv/iommu.c
+++ b/drivers/iommu/riscv/iommu.c
@@ -846,6 +846,8 @@ static int riscv_iommu_iodir_set_mode(struct riscv_iommu_device *iommu,
 
 /* This struct contains protection domain specific IOMMU driver data. */
 struct riscv_iommu_domain {
+	struct riscv_iommu_domain *s2;
+	struct riscv_iommu_device *iommu;
 	struct iommu_domain domain;
 	struct list_head bonds;
 	spinlock_t lock;		/* protect bonds list updates. */
@@ -863,6 +865,7 @@ struct riscv_iommu_domain {
 /* Private IOMMU data for managed devices, dev_iommu_priv_* */
 struct riscv_iommu_info {
 	struct riscv_iommu_domain *domain;
+	struct riscv_iommu_dc dc_user;
 };
 
 /*
@@ -1532,7 +1535,6 @@ static int riscv_iommu_attach_blocking_domain(struct iommu_domain *iommu_domain,
 	/* Make device context invalid, translation requests will fault w/ #258 */
 	riscv_iommu_iodir_update(iommu, dev, &dc);
 	riscv_iommu_bond_unlink(info->domain, dev);
-	info->domain = NULL;
 
 	return 0;
 }
@@ -1568,6 +1570,237 @@ static struct iommu_domain riscv_iommu_identity_domain = {
 	}
 };
 
+/**
+ * Nested IOMMU operations
+ */
+
+static int riscv_iommu_attach_dev_nested(struct iommu_domain *domain, struct device *dev)
+{
+	struct riscv_iommu_domain *riscv_domain = iommu_domain_to_riscv(domain);
+	struct riscv_iommu_device *iommu = dev_to_iommu(dev);
+	struct riscv_iommu_info *info = dev_iommu_priv_get(dev);
+
+	/*
+	 * Add bond to the new domain's list, but don't unlink in current domain.
+	 * We need to flush entries in stage-2 page table by iterating the list.
+	 */
+	if (riscv_iommu_bond_link(riscv_domain, dev))
+		return -ENOMEM;
+
+	riscv_iommu_iotlb_inval(riscv_domain, 0, ULONG_MAX);
+	info->dc_user.ta |= RISCV_IOMMU_PC_TA_V;
+	riscv_iommu_iodir_update(iommu, dev, &info->dc_user);
+
+	info->domain = riscv_domain;
+
+	return 0;
+}
+
+static void riscv_iommu_domain_free_nested(struct iommu_domain *domain)
+{
+	struct riscv_iommu_domain *riscv_domain = iommu_domain_to_riscv(domain);
+	struct riscv_iommu_bond *bond;
+
+	/* Unlink bond in s2 domain, because we link bond both on s1 and s2 domain */
+	list_for_each_entry_rcu(bond, &riscv_domain->s2->bonds, list)
+		riscv_iommu_bond_unlink(riscv_domain->s2, bond->dev);
+
+	if ((int)riscv_domain->pscid > 0)
+		ida_free(&riscv_iommu_pscids, riscv_domain->pscid);
+
+	kfree(riscv_domain);
+}
+
+static const struct iommu_domain_ops riscv_iommu_nested_domain_ops = {
+	.attach_dev	= riscv_iommu_attach_dev_nested,
+	.free		= riscv_iommu_domain_free_nested,
+};
+
+static int
+riscv_iommu_get_dc_user(struct device *dev, struct iommu_hwpt_riscv_iommu *user_arg)
+{
+	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
+	struct riscv_iommu_device *iommu = dev_to_iommu(dev);
+	struct riscv_iommu_info *info = dev_iommu_priv_get(dev);
+	struct riscv_iommu_dc dc;
+	struct riscv_iommu_fq_record event;
+	u64 dc_len = sizeof(struct riscv_iommu_dc) >>
+		     (!(iommu->caps & RISCV_IOMMU_CAPABILITIES_MSI_FLAT));
+	u64 event_len = sizeof(struct riscv_iommu_fq_record);
+	void __user *event_user = NULL;
+
+	for (int i = 0; i < fwspec->num_ids; i++) {
+		event.hdr =
+			FIELD_PREP(RISCV_IOMMU_FQ_HDR_CAUSE, RISCV_IOMMU_FQ_CAUSE_DDT_INVALID) |
+			FIELD_PREP(RISCV_IOMMU_FQ_HDR_DID, fwspec->ids[i]);
+
+		/* Sanity check DC of stage-1 from user data */
+		if (!user_arg->out_event_uptr || user_arg->event_len != event_len)
+			return -EINVAL;
+
+		event_user = u64_to_user_ptr(user_arg->out_event_uptr);
+
+		if (!user_arg->dc_uptr || user_arg->dc_len != dc_len)
+			return -EINVAL;
+
+		if (copy_from_user(&dc, u64_to_user_ptr(user_arg->dc_uptr), dc_len))
+			return -EFAULT;
+
+		if (!(dc.tc & RISCV_IOMMU_DDTE_V)) {
+			dev_dbg(dev, "Invalid DDT from user data\n");
+			if (copy_to_user(event_user, &event, event_len))
+				return -EFAULT;
+		}
+
+		if (!dc.fsc || dc.iohgatp) {
+			dev_dbg(dev, "Wrong page table from user data\n");
+			if (copy_to_user(event_user, &event, event_len))
+				return -EFAULT;
+		}
+
+		/* Save DC of stage-1 from user data */
+		memcpy(&info->dc_user,
+		       riscv_iommu_get_dc(iommu, fwspec->ids[i]),
+		       sizeof(struct riscv_iommu_dc));
+		info->dc_user.fsc = dc.fsc;
+	}
+
+	return 0;
+}
+
+static struct iommu_domain *
+riscv_iommu_domain_alloc_nested(struct device *dev,
+				struct iommu_domain *parent,
+				const struct iommu_user_data *user_data)
+{
+	struct riscv_iommu_domain *s2_domain = iommu_domain_to_riscv(parent);
+	struct riscv_iommu_domain *s1_domain;
+	struct riscv_iommu_device *iommu = dev_to_iommu(dev);
+	struct iommu_hwpt_riscv_iommu arg;
+	int ret, va_bits;
+
+	if (user_data->type != IOMMU_HWPT_DATA_RISCV_IOMMU)
+		return ERR_PTR(-EOPNOTSUPP);
+
+	if (parent->type != IOMMU_DOMAIN_UNMANAGED)
+		return ERR_PTR(-EINVAL);
+
+	ret = iommu_copy_struct_from_user(&arg,
+					  user_data,
+					  IOMMU_HWPT_DATA_RISCV_IOMMU,
+					  out_event_uptr);
+	if (ret)
+		return ERR_PTR(ret);
+
+	s1_domain = kzalloc(sizeof(*s1_domain), GFP_KERNEL);
+	if (!s1_domain)
+		return ERR_PTR(-ENOMEM);
+
+	spin_lock_init(&s1_domain->lock);
+	INIT_LIST_HEAD_RCU(&s1_domain->bonds);
+
+	s1_domain->pscid = ida_alloc_range(&riscv_iommu_pscids, 1,
+					   RISCV_IOMMU_MAX_PSCID, GFP_KERNEL);
+	if (s1_domain->pscid < 0) {
+		iommu_free_page(s1_domain->pgd_root);
+		kfree(s1_domain);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	/* Get device context of stage-1 from user*/
+	ret = riscv_iommu_get_dc_user(dev, &arg);
+	if (ret) {
+		kfree(s1_domain);
+		return ERR_PTR(-EINVAL);
+	}
+
+	if (!iommu) {
+		va_bits = VA_BITS;
+	} else if (iommu->caps & RISCV_IOMMU_CAPABILITIES_SV57) {
+		va_bits = 57;
+	} else if (iommu->caps & RISCV_IOMMU_CAPABILITIES_SV48) {
+		va_bits = 48;
+	} else if (iommu->caps & RISCV_IOMMU_CAPABILITIES_SV39) {
+		va_bits = 39;
+	} else {
+		dev_err(dev, "cannot find supported page table mode\n");
+		return ERR_PTR(-ENODEV);
+	}
+
+	/*
+	 * The ops->domain_alloc_user could be directly called by the iommufd core,
+	 * instead of iommu core. So, this function need to set the default value of
+	 * following data member:
+	 *  - domain->pgsize_bitmap
+	 *  - domain->geometry
+	 *  - domain->type
+	 *  - domain->ops
+	 */
+	s1_domain->s2 = s2_domain;
+	s1_domain->iommu = iommu;
+	s1_domain->domain.type = IOMMU_DOMAIN_NESTED;
+	s1_domain->domain.ops = &riscv_iommu_nested_domain_ops;
+	s1_domain->domain.pgsize_bitmap = SZ_4K;
+	s1_domain->domain.geometry.aperture_start = 0;
+	s1_domain->domain.geometry.aperture_end = DMA_BIT_MASK(va_bits - 1);
+	s1_domain->domain.geometry.force_aperture = true;
+
+	return &s1_domain->domain;
+}
+
+static struct iommu_domain *
+riscv_iommu_domain_alloc_user(struct device *dev, u32 flags,
+			      struct iommu_domain *parent,
+			      const struct iommu_user_data *user_data)
+{
+	struct iommu_domain *domain;
+	struct riscv_iommu_domain *riscv_domain;
+
+	/* Allocate stage-1 domain if it has stage-2 parent domain */
+	if (parent)
+		return riscv_iommu_domain_alloc_nested(dev, parent, user_data);
+
+	if (flags & ~((IOMMU_HWPT_ALLOC_NEST_PARENT | IOMMU_HWPT_ALLOC_DIRTY_TRACKING)))
+		return ERR_PTR(-EOPNOTSUPP);
+
+	if (user_data)
+		return ERR_PTR(-EINVAL);
+
+	/* domain_alloc_user op needs to be fully initialized */
+	domain = iommu_domain_alloc(dev->bus);
+	if (!domain)
+		return ERR_PTR(-ENOMEM);
+
+	/*
+	 * We assume that nest-parent or g-stage only will come here
+	 * TODO: Shadow page table doesn't be supported now.
+	 *       We currently can't distinguish g-stage and shadow
+	 *       page table here. Shadow page table shouldn't be
+	 *       put at stage-2.
+	 */
+	riscv_domain = iommu_domain_to_riscv(domain);
+
+	/* pgd_root may be allocated in .domain_alloc_paging */
+	if (riscv_domain->pgd_root)
+		iommu_free_page(riscv_domain->pgd_root);
+
+	riscv_domain->pgd_root = iommu_alloc_pages_node(riscv_domain->numa_node,
+							GFP_KERNEL_ACCOUNT,
+							2);
+	if (!riscv_domain->pgd_root)
+		return ERR_PTR(-ENOMEM);
+
+	riscv_domain->gscid = ida_alloc_range(&riscv_iommu_gscids, 1,
+					      RISCV_IOMMU_MAX_GSCID, GFP_KERNEL);
+	if (riscv_domain->gscid < 0) {
+		iommu_free_pages(riscv_domain->pgd_root, 2);
+		kfree(riscv_domain);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	return domain;
+}
+
 static void *riscv_iommu_hw_info(struct device *dev, u32 *length, u32 *type)
 {
 	struct riscv_iommu_device *iommu = dev_to_iommu(dev);
@@ -1668,6 +1901,7 @@ static const struct iommu_ops riscv_iommu_ops = {
 	.blocked_domain = &riscv_iommu_blocking_domain,
 	.release_domain = &riscv_iommu_blocking_domain,
 	.domain_alloc_paging = riscv_iommu_alloc_paging_domain,
+	.domain_alloc_user = riscv_iommu_domain_alloc_user,
 	.def_domain_type = riscv_iommu_device_domain_type,
 	.device_group = riscv_iommu_device_group,
 	.probe_device = riscv_iommu_probe_device,
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index 736f4408b5e0..514463fe85d3 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -390,14 +390,31 @@ struct iommu_hwpt_vtd_s1 {
 	__u32 __reserved;
 };
 
+/**
+ * struct iommu_hwpt_riscv_iommu - RISCV IOMMU stage-1 device context table
+ *                                 info (IOMMU_HWPT_TYPE_RISCV_IOMMU)
+ * @dc_len: Length of device context
+ * @dc_uptr: User pointer to the address of device context
+ * @event_len: Length of an event record
+ * @out_event_uptr: User pointer to the address of event record
+ */
+struct iommu_hwpt_riscv_iommu {
+	__aligned_u64 dc_len;
+	__aligned_u64 dc_uptr;
+	__aligned_u64 event_len;
+	__aligned_u64 out_event_uptr;
+};
+
 /**
  * enum iommu_hwpt_data_type - IOMMU HWPT Data Type
  * @IOMMU_HWPT_DATA_NONE: no data
  * @IOMMU_HWPT_DATA_VTD_S1: Intel VT-d stage-1 page table
+ * @IOMMU_HWPT_DATA_RISCV_IOMMU: RISC-V IOMMU device context table
  */
 enum iommu_hwpt_data_type {
 	IOMMU_HWPT_DATA_NONE,
 	IOMMU_HWPT_DATA_VTD_S1,
+	IOMMU_HWPT_DATA_RISCV_IOMMU,
 };
 
 /**
-- 
2.17.1

