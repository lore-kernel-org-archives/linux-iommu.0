Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357463D96A
	for <iommu@lists.linux.dev>; Fri, 14 Jun 2024 14:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718374953; cv=none; b=DL7fem1zyYCDSkcSmO1rKCJ9j0bDyDrQOj3upJy1O52WUXspK/DQUIu2IU6k/4MSjst5c9neQW4dHAX2AFkPp+IhO7x0uFvalQ4FOY/Vtn3/XrfsXI4FThiDdbdAOtX6udDp34ZT5I27z+GFkSQ9eOEULC09mp0OYDH0fmXdgyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718374953; c=relaxed/simple;
	bh=AMjRqApdC6JhSqc5cTc8FRbsioFIOI+eQK8ee2g7rO4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=iAX1cYlk1Grs0Iv+soGbWlC2xpKrbZDTE1QWIQpCqI6ApGhh7J2XxCKD80QKEAcEzwInA0vI7duoRObX6V1dt3/462Su8Hh09fo2uVUKw1FJcmOxPC1e5HuW+fhDNNKMbIppZWQyydHLp7a23iSKM9XpbKAAPKw1fVZsfgj7XEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=nAhyhJ/u; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="nAhyhJ/u"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1f6f031549bso20858115ad.3
        for <iommu@lists.linux.dev>; Fri, 14 Jun 2024 07:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1718374950; x=1718979750; darn=lists.linux.dev;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uqErywjP/CjLC2eaDMmEQxFN9AljnO4yCx1Hy/yfHnA=;
        b=nAhyhJ/uqLRr+GQV8/rfYEAMqskFRN6EzGB2eys0r43BnEnONc77dfehZuJzMOAxcC
         0Sxx5h9rQJjqKQUYCHnar5+3VYG9qT+OF3pvY8u792YfCgQoH+8i1ZF9lG1ZQQWnBd9r
         Z/JbV+iXA2M/Cc5eaCEWbsyfnQfPhNYpRAn+JHHkk89LeOk7lFfz92tl+0tM9C/nMZsF
         Sgew+8uorrJ5g6+NnIJs2w1xZO6xuXPn2NHzz8SFWkd3pSxDEIa1wuzt5c3V9FQfBU8t
         AmrXEAujbCjQ2pNOKRZPOIyLF7HR+Zzoc+3z2tN2ws0DMW4RXgCBZ/bkzsBhhLFTsxwi
         1UfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718374950; x=1718979750;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uqErywjP/CjLC2eaDMmEQxFN9AljnO4yCx1Hy/yfHnA=;
        b=DOw5xPyqLxwZZfVNlYhzNUNgQbYfANCbypdPnDXryTziiu6oXG8sJRlRqovAYNHg/G
         2x+O/1d1FgDeL4b74OzxUSEz3b8n7/UvlpBBZSbm4lVYAHfbuQ3rGa2eOUal1h874Oow
         7cldgAK4Xf9s03ml6glzfwI0xMWrynsVD10bS2ulC84kx11YJ1/ozPz0duKLesIBsyVp
         qAz5ZccCF/4x7PA1we/i0HkIA58/mcg/SpESSDj1b4v6fI85FIm2Pm4VAgte8i29NdKU
         AEnYGXVo1ONGllLYlS1VzVpNiEiRHdudaI/2CaLDBPgWOdXVTEow22KWhBYe5aKPD4bM
         PMdg==
X-Forwarded-Encrypted: i=1; AJvYcCV5amCU9vE3NWuEOUTDiKxS96CYW6DejRsgVk0kShQ8SJUkiSu6FAbJC3/RzpYRkp+Hy77pvfI8qPqGSneipIQPaTlIJDQ=
X-Gm-Message-State: AOJu0YzhIc+orWm/PNN+OzkAohO3apm1wGxk/NO4MgLTzV+/SsSGjeH4
	x0jmpeL/689WaZ+xnUL1s0kv6kygWMn94DOcior+WcEpsoNsp/tj/At2HIhvlX8=
X-Google-Smtp-Source: AGHT+IHSez2BcKKbBZwd377qNguyZGbzCpuJqffZQYRK1qpXa16+hD0f3KlRelSKzLQGJUtI0sNeSg==
X-Received: by 2002:a17:903:1c4:b0:1f7:1525:ddfc with SMTP id d9443c01a7336-1f8625d9e30mr34295185ad.20.1718374950324;
        Fri, 14 Jun 2024 07:22:30 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855e559d9sm32522005ad.35.2024.06.14.07.22.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 07:22:29 -0700 (PDT)
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
Subject: [RFC PATCH v2 08/10] iommu/riscv: support nested iommu for flushing cache
Date: Fri, 14 Jun 2024 22:21:54 +0800
Message-Id: <20240614142156.29420-9-zong.li@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240614142156.29420-1-zong.li@sifive.com>
References: <20240614142156.29420-1-zong.li@sifive.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

This patch implements cache_invalidate_user operation for the userspace
to flush the hardware caches for a nested domain through iommufd.

Signed-off-by: Zong Li <zong.li@sifive.com>
---
 drivers/iommu/riscv/iommu.c  | 90 ++++++++++++++++++++++++++++++++++--
 include/uapi/linux/iommufd.h | 11 +++++
 2 files changed, 97 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
index 410b236e9b24..d08eb0a2939e 100644
--- a/drivers/iommu/riscv/iommu.c
+++ b/drivers/iommu/riscv/iommu.c
@@ -1587,8 +1587,9 @@ static int riscv_iommu_attach_dev_nested(struct iommu_domain *domain, struct dev
 	if (riscv_iommu_bond_link(riscv_domain, dev))
 		return -ENOMEM;
 
-	riscv_iommu_iotlb_inval(riscv_domain, 0, ULONG_MAX);
-	info->dc_user.ta |= RISCV_IOMMU_PC_TA_V;
+	if (riscv_iommu_bond_link(info->domain, dev))
+		return -ENOMEM;
+
 	riscv_iommu_iodir_update(iommu, dev, &info->dc_user);
 
 	info->domain = riscv_domain;
@@ -1611,13 +1612,92 @@ static void riscv_iommu_domain_free_nested(struct iommu_domain *domain)
 	kfree(riscv_domain);
 }
 
+static int riscv_iommu_fix_user_cmd(struct riscv_iommu_command *cmd,
+				    unsigned int pscid, unsigned int gscid)
+{
+	u32 opcode = FIELD_GET(RISCV_IOMMU_CMD_OPCODE, cmd->dword0);
+
+	switch (opcode) {
+	case RISCV_IOMMU_CMD_IOTINVAL_OPCODE:
+		u32 func = FIELD_GET(RISCV_IOMMU_CMD_FUNC, cmd->dword0);
+
+		if (func != RISCV_IOMMU_CMD_IOTINVAL_FUNC_GVMA &&
+		    func != RISCV_IOMMU_CMD_IOTINVAL_FUNC_VMA) {
+			pr_warn("The IOTINVAL function: 0x%x is not supported\n",
+				func);
+			return -EOPNOTSUPP;
+		}
+
+		if (func == RISCV_IOMMU_CMD_IOTINVAL_FUNC_GVMA) {
+			cmd->dword0 &= ~RISCV_IOMMU_CMD_FUNC;
+			cmd->dword0 |= FIELD_PREP(RISCV_IOMMU_CMD_FUNC,
+						  RISCV_IOMMU_CMD_IOTINVAL_FUNC_VMA);
+		}
+
+		cmd->dword0 &= ~(RISCV_IOMMU_CMD_IOTINVAL_PSCID |
+				 RISCV_IOMMU_CMD_IOTINVAL_GSCID);
+		riscv_iommu_cmd_inval_set_pscid(cmd, pscid);
+		riscv_iommu_cmd_inval_set_gscid(cmd, gscid);
+		break;
+	case RISCV_IOMMU_CMD_IODIR_OPCODE:
+		/*
+		 * Ensure the device ID is right. We expect that VMM has
+		 * transferred the device ID to host's from guest's.
+		 */
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
+static int riscv_iommu_cache_invalidate_user(struct iommu_domain *domain,
+					     struct iommu_user_data_array *array)
+{
+	struct riscv_iommu_domain *riscv_domain = iommu_domain_to_riscv(domain);
+	struct iommu_hwpt_riscv_iommu_invalidate inv_info;
+	int ret, index;
+
+	if (array->type != IOMMU_HWPT_INVALIDATE_DATA_RISCV_IOMMU) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	for (index = 0; index < array->entry_num; index++) {
+		ret = iommu_copy_struct_from_user_array(&inv_info, array,
+							IOMMU_HWPT_INVALIDATE_DATA_RISCV_IOMMU,
+							index, cmd);
+		if (ret)
+			break;
+
+		ret = riscv_iommu_fix_user_cmd((struct riscv_iommu_command *)inv_info.cmd,
+					       riscv_domain->pscid,
+					       riscv_domain->s2->gscid);
+		if (ret == -EOPNOTSUPP)
+			continue;
+
+		riscv_iommu_cmd_send(riscv_domain->iommu,
+				     (struct riscv_iommu_command *)inv_info.cmd);
+		riscv_iommu_cmd_sync(riscv_domain->iommu,
+				     RISCV_IOMMU_IOTINVAL_TIMEOUT);
+	}
+
+out:
+	array->entry_num = index;
+
+	return ret;
+}
+
 static const struct iommu_domain_ops riscv_iommu_nested_domain_ops = {
 	.attach_dev	= riscv_iommu_attach_dev_nested,
 	.free		= riscv_iommu_domain_free_nested,
+	.cache_invalidate_user = riscv_iommu_cache_invalidate_user,
 };
 
 static int
-riscv_iommu_get_dc_user(struct device *dev, struct iommu_hwpt_riscv_iommu *user_arg)
+riscv_iommu_get_dc_user(struct device *dev, struct iommu_hwpt_riscv_iommu *user_arg,
+			struct riscv_iommu_domain *s1_domain)
 {
 	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
 	struct riscv_iommu_device *iommu = dev_to_iommu(dev);
@@ -1663,6 +1743,8 @@ riscv_iommu_get_dc_user(struct device *dev, struct iommu_hwpt_riscv_iommu *user_
 		       riscv_iommu_get_dc(iommu, fwspec->ids[i]),
 		       sizeof(struct riscv_iommu_dc));
 		info->dc_user.fsc = dc.fsc;
+		info->dc_user.ta = FIELD_PREP(RISCV_IOMMU_PC_TA_PSCID, s1_domain->pscid) |
+					      RISCV_IOMMU_PC_TA_V;
 	}
 
 	return 0;
@@ -1708,7 +1790,7 @@ riscv_iommu_domain_alloc_nested(struct device *dev,
 	}
 
 	/* Get device context of stage-1 from user*/
-	ret = riscv_iommu_get_dc_user(dev, &arg);
+	ret = riscv_iommu_get_dc_user(dev, &arg, s1_domain);
 	if (ret) {
 		kfree(s1_domain);
 		return ERR_PTR(-EINVAL);
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index 514463fe85d3..876cbe980a42 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -653,9 +653,11 @@ struct iommu_hwpt_get_dirty_bitmap {
  * enum iommu_hwpt_invalidate_data_type - IOMMU HWPT Cache Invalidation
  *                                        Data Type
  * @IOMMU_HWPT_INVALIDATE_DATA_VTD_S1: Invalidation data for VTD_S1
+ * @IOMMU_HWPT_INVALIDATE_DATA_RISCV_IOMMU: Invalidation data for RISCV_IOMMU
  */
 enum iommu_hwpt_invalidate_data_type {
 	IOMMU_HWPT_INVALIDATE_DATA_VTD_S1,
+	IOMMU_HWPT_INVALIDATE_DATA_RISCV_IOMMU,
 };
 
 /**
@@ -694,6 +696,15 @@ struct iommu_hwpt_vtd_s1_invalidate {
 	__u32 __reserved;
 };
 
+/**
+ * struct iommu_hwpt_riscv_iommu_invalidate - RISCV IOMMU cache invalidation
+ *                                            (IOMMU_HWPT_TYPE_RISCV_IOMMU)
+ * @cmd: An array holds a command for cache invalidation
+ */
+struct iommu_hwpt_riscv_iommu_invalidate {
+	__aligned_u64 cmd[2];
+};
+
 /**
  * struct iommu_hwpt_invalidate - ioctl(IOMMU_HWPT_INVALIDATE)
  * @size: sizeof(struct iommu_hwpt_invalidate)
-- 
2.17.1

