Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F8816133E
	for <iommu@lists.linux.dev>; Tue,  7 May 2024 14:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715091984; cv=none; b=hIsgEwSbXtq47Gz+kTCNBCHGe0Iy+MCHSfqqBjmFdYuqG0hhtfd9EmnRAll+xzuxcBjNlT0/IkebhbFQX2935+KOHDXE7BgUx/GYfZ+R4l+PHRCOY5c2BW4M3X8rqCaegvplS4fwdfQ7CISxORy9XVZekCHjQXtg+LfV4W0rTU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715091984; c=relaxed/simple;
	bh=p9LzzUVq84gigk4g1jMkvkAiSTYV+AnJqJecyq5AEds=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=aDbFYStaw1++dFcwrrJk1Fwpf3PmWjR0IYC9vVnsjFP3ZrqlCdqAopAy2/3SFnUpaUXsar/pLScAyR6sDZl917osaE64DZ0HS4DC8qKLwe/rZPPGTQo4ZlNGrgd3oXvhl4A4GQ0VqMPi+oyvYyxNmUqC99k0bCiUm4Qqt8LlbnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=mRVQCoPS; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="mRVQCoPS"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6f450f43971so2442140b3a.3
        for <iommu@lists.linux.dev>; Tue, 07 May 2024 07:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1715091982; x=1715696782; darn=lists.linux.dev;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QsG7aE0HnxZsvtjvosuXtYKV2huEonpRW6TKXMCUJnU=;
        b=mRVQCoPSboUe+OzXzcql0XsWofWRP+wSIOhBua3/2ALIGpEBsUOLVgQqZI44OEuwTV
         pqunCnWG3agFSGEY8N6hdKDylwXkkQ1zsSHp34WCf2gYgaEul9WN404xurSlNvefqNmI
         lczpGH569JdgsIMTdiAttWj6GqtsaVGgMmyDcXgsdse1Sxln3mG+iqJBYE4eFRfpmPtB
         BvfW0cryBXNAaJpJeA4Sh6VcdaZOx1p5DhXuvflmtWL3rE+63I2oIBW8QCuOQKJBmOIh
         PSfTjhlsum5sHZzWg5HNErCSGdDHrqWaKqwzefQ82AAVKZB3uRbxiCtQ45JnBocqGjz4
         LVLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715091982; x=1715696782;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QsG7aE0HnxZsvtjvosuXtYKV2huEonpRW6TKXMCUJnU=;
        b=gQISjbraGk8TeJCi+T23mNs+fPL26jlbzhidatrR/HlYZr1D5np32R7GLI5tTh7iAm
         uH1PTSb+o5JaQp/7vxMKHEE6IY7CxPBqGVNIz5+WA1FhTdXPSHY0QoqPssogXyLSrfRq
         q7Y4DwxTGJMUj0s9BoW295T47otSCDL1mVDQItuztjYUP574rjIR56xjipvg+AB0BQE5
         vD9/T8D8RyHc5qsEFIQ+N6kn4Zsr+DwH/Mfz6hhT2sw1VR73ACuFBXzgrCHiNfk9Lcdw
         DOHg2VEk2AK/EYqgnCIdBKN1nYZQqLXOBMwR2mkqZnvUuxj76UKjouEgASWAp78REhz8
         W+MQ==
X-Forwarded-Encrypted: i=1; AJvYcCXj7+t6XKvd5QX7rmjCZxRTUTujARQ4NaYYHSu8V6cdKASJeCjYg6WjgGWICOGL/7kj41u8r2g+/UX+smUYryJR7LwXdsQ=
X-Gm-Message-State: AOJu0YwzPf7/yJZObDWc0EnNA3bWJu5BPmoc05JqdsX2510nhxOz5L/i
	g1rDlug6ZfWqCQZX9x8e1Xsespkpxd2QNN7q8pccJ2aH7a+iDwIh75IkVWPG3so=
X-Google-Smtp-Source: AGHT+IESwO+1TpOehpzE3oOZnwENdjrLViV8PyyzyYTAIHr0YOeHnmv3rn25FWxqq/8kskMF3gIH5A==
X-Received: by 2002:a05:6a00:17a7:b0:6ec:e726:b6f5 with SMTP id s39-20020a056a0017a700b006ece726b6f5mr16072960pfg.26.1715091982078;
        Tue, 07 May 2024 07:26:22 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id i22-20020aa79096000000b006f44bcbe7e3sm7687554pfa.201.2024.05.07.07.26.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 07:26:21 -0700 (PDT)
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
Subject: [PATCH RFC RESEND 6/6] iommu/riscv: support nested iommu for flushing cache
Date: Tue,  7 May 2024 22:26:00 +0800
Message-Id: <20240507142600.23844-7-zong.li@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240507142600.23844-1-zong.li@sifive.com>
References: <20240507142600.23844-1-zong.li@sifive.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

This patch implements cache_invalidate_user operation for the userspace
to flush the hardware caches for a nested domain through iommufd.

Signed-off-by: Zong Li <zong.li@sifive.com>
---
 drivers/iommu/riscv/iommu.c  | 91 ++++++++++++++++++++++++++++++++++++
 include/uapi/linux/iommufd.h |  9 ++++
 2 files changed, 100 insertions(+)

diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
index 7eda850df475..4dd58fe2242d 100644
--- a/drivers/iommu/riscv/iommu.c
+++ b/drivers/iommu/riscv/iommu.c
@@ -1522,9 +1522,100 @@ static void riscv_iommu_domain_free_nested(struct iommu_domain *domain)
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
+		pr_warn("The user command: 0x%x is not supported\n", opcode);
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
+	struct riscv_iommu_device *iommu;
+	struct riscv_iommu_bond *bond;
+	struct riscv_iommu_command cmd;
+	struct iommu_hwpt_riscv_iommu_invalidate inv_info;
+	int ret, index;
+
+	if (!riscv_domain)
+		return -EINVAL;
+
+	/* Assume attached devices in the domain go through the same IOMMU device */
+	spin_lock(&riscv_domain->lock);
+	list_for_each_entry_rcu(bond, &riscv_domain->bonds, list) {
+		if (bond->dev) {
+			iommu = dev_to_iommu(bond->dev);
+			break;
+		}
+	}
+	spin_unlock(&riscv_domain->lock);
+
+	if (!iommu)
+		return -EINVAL;
+
+	for (index = 0; index < array->entry_num; index++) {
+		ret = iommu_copy_struct_from_user_array(&inv_info, array,
+							IOMMU_HWPT_DATA_RISCV_IOMMU,
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
+		riscv_iommu_cmd_send(iommu, (struct riscv_iommu_command *)inv_info.cmd, 0);
+		riscv_iommu_cmd_iofence(&cmd);
+		riscv_iommu_cmd_send(iommu, &cmd, RISCV_IOMMU_QUEUE_TIMEOUT);
+	}
+
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
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index e10b6e236647..d93a8f11813d 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -689,6 +689,15 @@ struct iommu_hwpt_vtd_s1_invalidate {
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

