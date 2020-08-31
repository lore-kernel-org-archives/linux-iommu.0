Return-Path: <SRS0=U/E5=CJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C33CC433E7
	for <iommu@archiver.kernel.org>; Mon, 31 Aug 2020 18:18:24 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 467B220936
	for <iommu@archiver.kernel.org>; Mon, 31 Aug 2020 18:18:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vYnopaOd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 467B220936
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id D61CA20515;
	Mon, 31 Aug 2020 18:18:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2787lpZr-1Oa; Mon, 31 Aug 2020 18:18:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 2C24520416;
	Mon, 31 Aug 2020 18:18:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 172FCC07FF;
	Mon, 31 Aug 2020 18:18:22 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4E3BDC0051
 for <iommu@lists.linux-foundation.org>; Mon, 31 Aug 2020 18:18:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 3B01586FDA
 for <iommu@lists.linux-foundation.org>; Mon, 31 Aug 2020 18:18:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id z9O+N+lRBWo5 for <iommu@lists.linux-foundation.org>;
 Mon, 31 Aug 2020 18:18:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pj1-f67.google.com (mail-pj1-f67.google.com
 [209.85.216.67])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 73BA586F66
 for <iommu@lists.linux-foundation.org>; Mon, 31 Aug 2020 18:18:20 +0000 (UTC)
Received: by mail-pj1-f67.google.com with SMTP id o16so238521pjr.2
 for <iommu@lists.linux-foundation.org>; Mon, 31 Aug 2020 11:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=X8w/zoyDm7STrfSjeUJijWigenQyydijn+iIkzb3q24=;
 b=vYnopaOdNnS7+NIItBZSxff6fADrxen+MHc7SlnKp9vwSI5AjdhlpcbctmhdOGJaPZ
 gL9Kj2Qkwsn6CdzYmj5TGtlLE7vIkaNMXP98RebxtaaVefc5UxG+ZZlyVD484KTVVGOa
 goL7dBpatc5JhJO1thu1WdwDLgLDpvGGWTA+g6/cgwzrHzM2Gn6zzU7ZG/cTgJK592As
 +54jvyXt5HpRoOp3X107lmkT1JUYHviQsPiXGXH9tHMDkqnKL2VFBC/mwQgC6ALKRP3D
 O0Oki7HXCgfx9LBWYKh4b4Clqe2NYEJVOKTI43GY9e2FgD8CaK9OGj5OTU/VTJ8TREvh
 qozw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=X8w/zoyDm7STrfSjeUJijWigenQyydijn+iIkzb3q24=;
 b=NbdW9E3SFvmWPq9HEWqWLdp3TUemdh0YyW5H4iVEB4b7TPxlnjD9hZrBPsBw65QXLV
 Ik2DLT+UVeL2PbjV+0WZippuqNemSt3kb4ioDci9E1/LR1mgmaWI7ty6IaMLYOYSqOmE
 1NFMUTA/7SFH1zt/6NofemFqtoQaemuY/0V7ugK6wLfOvmcwEFkytXEt/ogB15GH4amN
 kZUqDc9eKw2oiA07r9kztQqnuXe9Lbm9rVyoLZCeAAvO+AOAcaPW8IJike6mHfh4F8Cf
 mAi+DItER87ku72LKanwi9sRMq1zEPh8cwDVAG+8gszFlLYbyVNbJ0pL3hKyITXNUQCP
 KwUQ==
X-Gm-Message-State: AOAM532G0MjMx5dAlK6hZtclZ60Fx5oRWVFnsMwa/Y6Wf3qkVf8uX27/
 l7oQ3o7bEjMcZHGt4+5ImQ40VoNdg1g=
X-Google-Smtp-Source: ABdhPJwNEWW2Ymdpqg4NAx41GhNDrKezooaq7QH3S0f2gK00emLw//18jMGD0eDQyynTp0J5FwjlHw==
X-Received: by 2002:a17:90b:fd0:: with SMTP id
 gd16mr546460pjb.122.1598897899845; 
 Mon, 31 Aug 2020 11:18:19 -0700 (PDT)
Received: from jacob-builder.jf.intel.com (jfdmzpr04-ext.jf.intel.com.
 [134.134.137.73])
 by smtp.gmail.com with ESMTPSA id y128sm8672547pfy.74.2020.08.31.11.18.18
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 31 Aug 2020 11:18:19 -0700 (PDT)
From: Jacob Pan <jacob.pan.linux@gmail.com>
X-Google-Original-From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>,
 Joerg Roedel <joro@8bytes.org>,
 Alex Williamson <alex.williamson@redhat.com>
Subject: [PATCH v8 7/7] iommu/vt-d: Check UAPI data processed by IOMMU core
Date: Mon, 31 Aug 2020 11:25:00 -0700
Message-Id: <1598898300-65475-8-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1598898300-65475-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1598898300-65475-1-git-send-email-jacob.jun.pan@linux.intel.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 Christoph Hellwig <hch@infradead.org>, David Woodhouse <dwmw2@infradead.org>
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
index 43f16f0cebde..a3a0b5c8921d 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -5399,8 +5399,7 @@ intel_iommu_sva_invalidate(struct iommu_domain *domain, struct device *dev,
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
