Received: from outbound.baidu.com (jpmx.baidu.com [119.63.196.201])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 25D83328B62
	for <iommu@lists.linux.dev>; Thu, 26 Mar 2026 09:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=119.63.196.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774517906; cv=none; b=rclbZXfe6wGqQGd5yB0nAepXZJFE41zENGhEkD6I8cnlfbc0jnyqvHyWWWvCZ3RmZAb7UapKzqvnmb/C/C/5tVcP1b6ENM6/rt+kJEkXdvpvLBAhw/LiVA4dSpXGzAxG/WsnnxdgjLQA5EAIXyoTT+fYpc5SsnM5tMCkMERQJhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774517906; c=relaxed/simple;
	bh=ioiU3gOaBcPfvl5jFvkiKhx3goMxrfnQtCjfPnNt9UY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GzxIGs2YgivM3mdmnC4ZmuvcYxREoLAwKNGPfcqUL7Ax9XsfYJTR9xTcVv5fUmR/bLBGwj2svemnp0Nla/+LIAhKjn0HDiQHjTXz7OUHIyrB4q1Kj2T+b6zuwNKSvAzQ/1aC3Nd0aXn/iFypcrUtJhJcLB6DqhwwyYjrtsxgHHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; dkim=pass (2048-bit key) header.d=baidu.com header.i=@baidu.com header.b=a7Cxw5hP; arc=none smtp.client-ip=119.63.196.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baidu.com header.i=@baidu.com header.b="a7Cxw5hP"
X-MD-Sfrom: lirongqing@baidu.com
X-MD-SrcIP: 172.31.50.47
From: lirongqing <lirongqing@baidu.com>
To: Joerg Roedel <joro@8bytes.org>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>, Will Deacon <will@kernel.org>, Robin Murphy
	<robin.murphy@arm.com>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
CC: Li RongQing <lirongqing@baidu.com>
Subject: [PATCH] iommu/amd: Default to passthrough mode for improved performance
Date: Thu, 26 Mar 2026 05:38:01 -0400
Message-ID: <20260326093801.2213-1-lirongqing@baidu.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: bjkjy-exc11.internal.baidu.com (172.31.51.11) To
 bjkjy-exc3.internal.baidu.com (172.31.50.47)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=baidu.com;
	s=selector1; t=1774517898;
	bh=8fGkhPCA9mlhNmbdPn/04ARmhqDqXHG/Uemd0fNdiJo=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type;
	b=a7Cxw5hP7MrruFb/IBGgfq7D7cliyoXIc/hiUYtTok8+6dn7wg8ZYVI/PblY6+AJ4
	 DfxTwwhkojIgCn7U15fiJWgVxSWYWnWNEtJ6nlYG2AmDc9i6+2qU4Z/zePAo86TU2o
	 s5wnLv72OXEzHpar0+g9C/CLo7H+wNoWoR5jTunoISQbYMun44zerrivkOa8T2q7T4
	 a7A0IfSz+KhZlzWAz4sH0tS282/eaBAan5s5+zInCp0IrvTZdwso2jN5wRWKJc69wn
	 DYDRdBbFnrMKuS4NmVBjlfuWJ3HQKxeJtdShisN+9w9PfBHmgFXIcAK9Hrl8OrvwgF
	 x4YASInrm4Whw==

From: Li RongQing <lirongqing@baidu.com>

On x86 platforms, AMD IOMMU is typically enabled by default. When the
kernel is compiled with CONFIG_IOMMU_DEFAULT_DMA_LAZY, the IOMMU
operates in translated mode with deferred TLB flushing. While this
provides a security layer, it introduces measurable performance
overhead compared to Intel systems where the IOMMU often defaults
to a disabled state.

To optimize out-of-the-box performance for AMD users, shift the
default to passthrough mode when the following conditions are met:
1. No explicit IOMMU mode was requested via the command line.
2. The kernel was configured to use 'lazy' DMA remapping by default.
3. Memory encryption (SME/SEV) is not active, as these features
   require translation for security.

This change allows standard DMA operations to bypass remapping
overhead while maintaining the ability for users to explicitly
enable translation if required.

To support this, export iommu_dma_is_user_configured() from the
IOMMU core to allow vendor drivers to check if the DMA API
configuration was overridden by the user.

Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 drivers/iommu/amd/init.c | 9 +++++++++
 drivers/iommu/iommu.c    | 6 ++++++
 include/linux/iommu.h    | 1 +
 3 files changed, 16 insertions(+)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index f3fd7f3..e89a5ce 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -3619,6 +3619,15 @@ void __init amd_iommu_detect(void)
 	amd_iommu_detected = true;
 	iommu_detected = 1;
 	x86_init.iommu.iommu_init = amd_iommu_init;
+
+	if (!iommu_dma_is_user_configured()) {
+		if (!cc_platform_has(CC_ATTR_MEM_ENCRYPT) &&
+				IS_ENABLED(CONFIG_IOMMU_DEFAULT_DMA_LAZY)) {
+			pr_info("Defaulting to Passthrough mode for performance\n");
+			iommu_set_default_passthrough(false);
+		}
+	}
+
 	return;
 
 disable_snp:
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 50718ab..a950dbb 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -4091,3 +4091,9 @@ int iommu_dma_prepare_msi(struct msi_desc *desc, phys_addr_t msi_addr)
 	return ret;
 }
 #endif /* CONFIG_IRQ_MSI_IOMMU */
+
+bool iommu_dma_is_user_configured(void)
+{
+	return !!(iommu_cmd_line & IOMMU_CMD_LINE_DMA_API);
+}
+EXPORT_SYMBOL_GPL(iommu_dma_is_user_configured);
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 54b8b48..c3ff8a9 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -967,6 +967,7 @@ int iommu_set_pgtable_quirks(struct iommu_domain *domain,
 		unsigned long quirks);
 
 void iommu_set_dma_strict(void);
+bool iommu_dma_is_user_configured(void);
 
 extern int report_iommu_fault(struct iommu_domain *domain, struct device *dev,
 			      unsigned long iova, int flags);
-- 
2.9.4

