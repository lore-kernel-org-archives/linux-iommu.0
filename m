Return-Path: <SRS0=FRM4=CU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FDF7C43461
	for <iommu@archiver.kernel.org>; Fri, 11 Sep 2020 21:56:26 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40BC222208
	for <iommu@archiver.kernel.org>; Fri, 11 Sep 2020 21:56:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S0j3//qz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40BC222208
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id BCB5A2E2C1;
	Fri, 11 Sep 2020 21:56:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id V14LZnsdfHD5; Fri, 11 Sep 2020 21:56:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 9B9BB2E2DE;
	Fri, 11 Sep 2020 21:56:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 882E1C0859;
	Fri, 11 Sep 2020 21:56:17 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B0CE6C0051
 for <iommu@lists.linux-foundation.org>; Fri, 11 Sep 2020 21:56:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 6629B87465
 for <iommu@lists.linux-foundation.org>; Fri, 11 Sep 2020 21:56:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nhJQT37SJMra for <iommu@lists.linux-foundation.org>;
 Fri, 11 Sep 2020 21:56:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pg1-f196.google.com (mail-pg1-f196.google.com
 [209.85.215.196])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 9ECD887638
 for <iommu@lists.linux-foundation.org>; Fri, 11 Sep 2020 21:56:14 +0000 (UTC)
Received: by mail-pg1-f196.google.com with SMTP id j34so7506636pgi.7
 for <iommu@lists.linux-foundation.org>; Fri, 11 Sep 2020 14:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=42ZLvMqGkMbjL9RB04eoud8+y4TLkWBqmGYPRgmoi0k=;
 b=S0j3//qzbszrhlicAKSiN7JlXavnd95YEsHBaeN0sflCS4V+d+7ORd6i5yA/pIHNHi
 QJlfYGBR6+4GW4HDURMYIr3j7hy27CeSP8nk9ypH+MCVPxitiOcLpaipVnIIDc5teT61
 jdMdKeSkvQBgCSpls4x2aNefhB1UIiWoLxPVtNPPFEfKFI5WdPyuMBvwTQNdRJaUIiQM
 Zwbf5bhq/SVQ7205wxvBuAB2e3ocBLOkvlrywkjZBKwpchm4Xv8UHWQMSt5HbMO+H7bt
 CICICT0/K7h87r/N9z4YRFPJ0pc8NfuONvf0LJkjn9QCPUgPjNJq0DB/0K5U54tjRMlU
 5S/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=42ZLvMqGkMbjL9RB04eoud8+y4TLkWBqmGYPRgmoi0k=;
 b=XfFgXs9JO3XEO6hN9gCN9HmHY+0yTM39uLVNGm6Kwsh6CDNvr8cjv1IOnkzJOTQ3gD
 hIhh5G1DsrLoJ4Ls68jMJgedjibMqq4PV43bZfa7mKfRZ3crGcMOSx2BmcGGM7dX9Aur
 EamP5j7dk6RPf5nNO77VyBw5MvAOmZHq0HrpDuTu0Q45pnJjGKhBRGmm5dDPOt1VCBMT
 dQSbveUsEJ6GoNgf7NlZz5DwjKOVdXhDO+s08tF5jefZIuJFJs2rc6ppQ8UVSZDsX8Li
 5F8tqHd+nTIpLly/ZOswMRWRsrlCocSUpmBGjJOJl3K7YA4l1yypuQYiiFQ9x+XHMHiB
 XhFQ==
X-Gm-Message-State: AOAM530V6b3cZE/ZtG3c1pcbvu8J3g0/RXDmmmUMXuRsOjBnLSrA8fg4
 qED0g6vo04UFh3hPKRvZR8E9RcHjCM0=
X-Google-Smtp-Source: ABdhPJxVPFcoGKnKBp8FLF66MGHxrTlphFhYr+Ydi3uDDKlsw0X3YtfkdfCu3a5aLQclkCiUa/YaMQ==
X-Received: by 2002:a63:5ec5:: with SMTP id s188mr3126366pgb.218.1599861374069; 
 Fri, 11 Sep 2020 14:56:14 -0700 (PDT)
Received: from jacob-builder.jf.intel.com (jfdmzpr04-ext.jf.intel.com.
 [134.134.137.73])
 by smtp.gmail.com with ESMTPSA id e62sm3171586pfh.76.2020.09.11.14.56.13
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 11 Sep 2020 14:56:13 -0700 (PDT)
From: Jacob Pan <jacob.pan.linux@gmail.com>
X-Google-Original-From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>,
 Joerg Roedel <joro@8bytes.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 "Lu Baolu" <baolu.lu@linux.intel.com>,
 David Woodhouse <dwmw2@infradead.org>, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v9 7/7] iommu/vt-d: Check UAPI data processed by IOMMU core
Date: Fri, 11 Sep 2020 14:57:56 -0700
Message-Id: <1599861476-53416-8-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1599861476-53416-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1599861476-53416-1-git-send-email-jacob.jun.pan@linux.intel.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>,
 Yi Sun <yi.y.sun@intel.com>, Jean-Philippe Brucker <jean-philippe@linaro.com>,
 Wu Hao <hao.wu@intel.com>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

IOMMU generic layer already does sanity checks on UAPI data for version
match and argsz range based on generic information.

This patch adjusts the following data checking responsibilities:
- removes the redundant version check from VT-d driver
- removes the check for vendor specific data size
- adds check for the use of reserved/undefined flags

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/intel/iommu.c |  3 +--
 drivers/iommu/intel/svm.c   | 11 +++++++++--
 include/uapi/linux/iommu.h  |  1 +
 3 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 461f3a6864d4..18ed3b3c70d7 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -5408,8 +5408,7 @@ intel_iommu_sva_invalidate(struct iommu_domain *domain, struct device *dev,
 	int ret = 0;
 	u64 size = 0;
 
-	if (!inv_info || !dmar_domain ||
-	    inv_info->version != IOMMU_CACHE_INVALIDATE_INFO_VERSION_1)
+	if (!inv_info || !dmar_domain)
 		return -EINVAL;
 
 	if (!dev || !dev_is_pci(dev))
diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 99353d6468fa..0cb9a15f1112 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -284,8 +284,15 @@ int intel_svm_bind_gpasid(struct iommu_domain *domain, struct device *dev,
 	if (WARN_ON(!iommu) || !data)
 		return -EINVAL;
 
-	if (data->version != IOMMU_GPASID_BIND_VERSION_1 ||
-	    data->format != IOMMU_PASID_FORMAT_INTEL_VTD)
+	if (data->format != IOMMU_PASID_FORMAT_INTEL_VTD)
+		return -EINVAL;
+
+	/* IOMMU core ensures argsz is more than the start of the union */
+	if (data->argsz < offsetofend(struct iommu_gpasid_bind_data, vendor.vtd))
+		return -EINVAL;
+
+	/* Make sure no undefined flags are used in vendor data */
+	if (data->vendor.vtd.flags & ~(IOMMU_SVA_VTD_GPASID_LAST - 1))
 		return -EINVAL;
 
 	if (!dev_is_pci(dev))
diff --git a/include/uapi/linux/iommu.h b/include/uapi/linux/iommu.h
index c64bca5af419..1ebc23df4fbc 100644
--- a/include/uapi/linux/iommu.h
+++ b/include/uapi/linux/iommu.h
@@ -288,6 +288,7 @@ struct iommu_gpasid_bind_data_vtd {
 #define IOMMU_SVA_VTD_GPASID_PWT	(1 << 3) /* page-level write through */
 #define IOMMU_SVA_VTD_GPASID_EMTE	(1 << 4) /* extended mem type enable */
 #define IOMMU_SVA_VTD_GPASID_CD		(1 << 5) /* PASID-level cache disable */
+#define IOMMU_SVA_VTD_GPASID_LAST	(1 << 6)
 	__u64 flags;
 	__u32 pat;
 	__u32 emt;
-- 
2.7.4

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
