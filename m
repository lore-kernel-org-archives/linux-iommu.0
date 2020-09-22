Return-Path: <SRS0=CZ1O=C7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83226C4727D
	for <iommu@archiver.kernel.org>; Tue, 22 Sep 2020 20:15:47 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0315C22206
	for <iommu@archiver.kernel.org>; Tue, 22 Sep 2020 20:15:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FS6u343L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0315C22206
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 7AB8C870D2;
	Tue, 22 Sep 2020 20:15:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VvBdVEhKvbi9; Tue, 22 Sep 2020 20:15:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id E39EA870CE;
	Tue, 22 Sep 2020 20:15:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C3FC3C0051;
	Tue, 22 Sep 2020 20:15:45 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4813EC0051
 for <iommu@lists.linux-foundation.org>; Tue, 22 Sep 2020 20:15:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 42933870B2
 for <iommu@lists.linux-foundation.org>; Tue, 22 Sep 2020 20:15:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id d9pWyCE4uKT7 for <iommu@lists.linux-foundation.org>;
 Tue, 22 Sep 2020 20:15:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com
 [209.85.215.193])
 by hemlock.osuosl.org (Postfix) with ESMTPS id C38FA87087
 for <iommu@lists.linux-foundation.org>; Tue, 22 Sep 2020 20:15:43 +0000 (UTC)
Received: by mail-pg1-f193.google.com with SMTP id f2so12888109pgd.3
 for <iommu@lists.linux-foundation.org>; Tue, 22 Sep 2020 13:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=42ZLvMqGkMbjL9RB04eoud8+y4TLkWBqmGYPRgmoi0k=;
 b=FS6u343LsEWEOkrgfMVcCfSbXxMfZH/x4Ng1F7cEQAW5KsmlRaixazwzmfS8faxfta
 unxJAIafhzjG0Hw7yhZ41elKp+tK/WOu/UR9Hp9vjuayFsvP/of7tXMoqujdDo129Tr4
 H6pJM43VE1H6V/+0cdci8xYJ5LJONABhsfK0IZ5vLwC72N3bA2KiIrAupXIZq2ReTuno
 lgPqEW2zJZLPPp3mr8tIDJhv64REZEizd4u4EGVnZQy8ToT7rli7+XfNLH2y+UQNk8ll
 tzILqJx+8lHqu57QRUWFJ4GAyiRWKvrsiBjrC75SfQttpOFMJtSOqysO9GtotJOmG9Gq
 Or+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=42ZLvMqGkMbjL9RB04eoud8+y4TLkWBqmGYPRgmoi0k=;
 b=Hw30MOpkVjuv72l6f3tZ4bVuMzfsuLBcXT4vkkOVAiNL07BWhqGw89fwUgiaMTC6i5
 wVtXWzd0PYdSdNv+JQ86sn+flp13ckGxyw4MM7MvYf8zDgCmMYH2qbknHx751GYCxkhd
 uDQKlQEU732Hb4mGS+Sg9bKw3VT3HkUuNfXyn4Ej6Tq0JcSvMIWX/K+7Je4wfgcZm+1e
 bkje5oc3eIdonZ8JUnONji1W7D/dCLLQ2aDH2wS2oSoDXcfTNQZyRGY/NB9zhAtpKFy4
 sj6vJU21ddNRfZxavSCdSoacanTWf4nSEmzIoDmI6c7J8+7lDyFNPP7B0h2kta1C4qN3
 zWxw==
X-Gm-Message-State: AOAM5329hvWRP2iHDDo0nwmMGZHswztDD/mz+ufWFkvnBuhwBLUGl/Lj
 bqHZqZCIjRcEDFPVXwDAvn1hTWgDnmM=
X-Google-Smtp-Source: ABdhPJwNyOVM/0mf+mRUSD//8h8yGlquQcQtyLkw+vjpJI6zq2KMrDQdWDwKTKE4NyiQxipGFq2YHg==
X-Received: by 2002:a17:902:8682:b029:d1:e5e7:be5b with SMTP id
 g2-20020a1709028682b02900d1e5e7be5bmr6156438plo.53.1600805743190; 
 Tue, 22 Sep 2020 13:15:43 -0700 (PDT)
Received: from jacob-builder.jf.intel.com (jfdmzpr04-ext.jf.intel.com.
 [134.134.137.73])
 by smtp.gmail.com with ESMTPSA id e10sm15793028pgb.45.2020.09.22.13.15.42
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 22 Sep 2020 13:15:42 -0700 (PDT)
From: Jacob Pan <jacob.pan.linux@gmail.com>
X-Google-Original-From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>,
 Joerg Roedel <joro@8bytes.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 "Lu Baolu" <baolu.lu@linux.intel.com>,
 David Woodhouse <dwmw2@infradead.org>, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v10 7/7] iommu/vt-d: Check UAPI data processed by IOMMU core
Date: Tue, 22 Sep 2020 13:17:02 -0700
Message-Id: <1600805822-1177-8-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1600805822-1177-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1600805822-1177-1-git-send-email-jacob.jun.pan@linux.intel.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>,
 linux-api@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
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
