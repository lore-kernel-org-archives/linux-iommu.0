Return-Path: <SRS0=te8u=GL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD753C433DB
	for <iommu@archiver.kernel.org>; Fri,  8 Jan 2021 15:02:51 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FC2523A1D
	for <iommu@archiver.kernel.org>; Fri,  8 Jan 2021 15:02:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FC2523A1D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 59FEB87360;
	Fri,  8 Jan 2021 15:02:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ILilHNhCN0Dg; Fri,  8 Jan 2021 15:02:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 7FB158732C;
	Fri,  8 Jan 2021 15:02:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6B8C6C1E6F;
	Fri,  8 Jan 2021 15:02:50 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E2BCCC013A
 for <iommu@lists.linux-foundation.org>; Fri,  8 Jan 2021 15:02:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id CC09E87317
 for <iommu@lists.linux-foundation.org>; Fri,  8 Jan 2021 15:02:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NPnvEmmmZsGc for <iommu@lists.linux-foundation.org>;
 Fri,  8 Jan 2021 15:02:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com
 [209.85.221.41])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 0775E8732C
 for <iommu@lists.linux-foundation.org>; Fri,  8 Jan 2021 15:02:47 +0000 (UTC)
Received: by mail-wr1-f41.google.com with SMTP id t30so9342041wrb.0
 for <iommu@lists.linux-foundation.org>; Fri, 08 Jan 2021 07:02:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=8RN8kwidJOzPyA7Qpg3RtqPE4flzC/x9Wg3rMV7wees=;
 b=Fak3o+zy1duaz7jSvXKzMTPcG81rNMh00UGR6hiDG1yuhxLSQ0h3vd3WpSV7arh3RV
 qJe6332Hy8nYJaxBYNayIHQD5Xkd1eCzyPT4ZxRBMRVpXG3kj2rAb7VRFuzCuNVwD5bD
 cXoaGCab5mUM9vZfl6eJvNpd+XcMEU7m/GaWL7uRAx5jG2eTnBEVtYCjOnifCBfK8kY1
 77Tq+/+ndHgQ2WC8bjQk1SxdJe+kBe4xMcJHNbXFOaNsS2cWnI6xlGWAGtZXcYtKnW2D
 Wl0BJiddYbKSNl5cZ5IQpZuuSAZzPnrI0FEXytcHQScVZeC6b+prft5hhEZyOvBJ0e+t
 no7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=8RN8kwidJOzPyA7Qpg3RtqPE4flzC/x9Wg3rMV7wees=;
 b=n8Ta3skNbMfSp061bkOLRl3IP8bWfSdhYujlnmtTaTjMtMcYKeYrF2LSLwlL0hP0h/
 K9/mURdvCwqnwsWhQNEN4iEJCYGNH0Qhzxh1K1xtDU7BMboSBqW8lxyw8PZQsGS9Vwn7
 epTycoFQ83NeurtD2GfPW1muAqpF0avvBmkRdZ9jCbAAdMZIHI7SFm/99Az4AuV7vZ4C
 XVZPH5nRBYqf9Ah1l54hXtui+gt/pKlTBzsy6j62zHudUjWCcoWcQ4Ah83XdQoHLfDEp
 YEG/3Xa7gcy/hy7PqxlsLgiPqR7X0mGp++k91tZDbLQ9O8ZxiyXl7+Dz3rGThhMW9ATe
 WuPQ==
X-Gm-Message-State: AOAM532wYVPiSVh8DRf2FeuLx0KF56m/hgstauTIBzghbJtzB6ewJMIq
 qGIs/jAt0O1DBhF9MfQt5LitGA==
X-Google-Smtp-Source: ABdhPJzmCME7Gtvq9iiLZjWDDsj68d4w8hOf5Ni1fB49vFhOqLmIi+oPyKBJ5yMjjTfIAjCKE04XBA==
X-Received: by 2002:a5d:690d:: with SMTP id t13mr4077051wru.410.1610118153487; 
 Fri, 08 Jan 2021 07:02:33 -0800 (PST)
Received: from localhost.localdomain
 ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id s13sm14258464wra.53.2021.01.08.07.02.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Jan 2021 07:02:32 -0800 (PST)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: joro@8bytes.org,
	will@kernel.org
Subject: [PATCH v9 04/10] iommu/vt-d: Support IOMMU_DEV_FEAT_IOPF
Date: Fri,  8 Jan 2021 15:52:12 +0100
Message-Id: <20210108145217.2254447-5-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210108145217.2254447-1-jean-philippe@linaro.org>
References: <20210108145217.2254447-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Cc: devicetree@vger.kernel.org, linux-acpi@vger.kernel.org,
 Jean-Philippe Brucker <jean-philippe@linaro.org>, guohanjun@huawei.com,
 rjw@rjwysocki.net, iommu@lists.linux-foundation.org, robh+dt@kernel.org,
 linux-accelerators@lists.ozlabs.org, sudeep.holla@arm.com,
 vivek.gautam@arm.com, zhangfei.gao@linaro.org, robin.murphy@arm.com,
 David Woodhouse <dwmw2@infradead.org>, linux-arm-kernel@lists.infradead.org,
 lenb@kernel.org
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Allow drivers to query and enable IOMMU_DEV_FEAT_IOPF, which amounts to
checking whether PRI is enabled.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 788119c5b021..630639c753f9 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -5263,6 +5263,8 @@ static int siov_find_pci_dvsec(struct pci_dev *pdev)
 static bool
 intel_iommu_dev_has_feat(struct device *dev, enum iommu_dev_features feat)
 {
+	struct device_domain_info *info = get_domain_info(dev);
+
 	if (feat == IOMMU_DEV_FEAT_AUX) {
 		int ret;
 
@@ -5277,13 +5279,13 @@ intel_iommu_dev_has_feat(struct device *dev, enum iommu_dev_features feat)
 		return !!siov_find_pci_dvsec(to_pci_dev(dev));
 	}
 
-	if (feat == IOMMU_DEV_FEAT_SVA) {
-		struct device_domain_info *info = get_domain_info(dev);
+	if (feat == IOMMU_DEV_FEAT_IOPF)
+		return info && info->pri_supported;
 
+	if (feat == IOMMU_DEV_FEAT_SVA)
 		return info && (info->iommu->flags & VTD_FLAG_SVM_CAPABLE) &&
 			info->pasid_supported && info->pri_supported &&
 			info->ats_supported;
-	}
 
 	return false;
 }
@@ -5294,6 +5296,9 @@ intel_iommu_dev_enable_feat(struct device *dev, enum iommu_dev_features feat)
 	if (feat == IOMMU_DEV_FEAT_AUX)
 		return intel_iommu_enable_auxd(dev);
 
+	if (feat == IOMMU_DEV_FEAT_IOPF)
+		return intel_iommu_dev_has_feat(dev, feat) ? 0 : -ENODEV;
+
 	if (feat == IOMMU_DEV_FEAT_SVA) {
 		struct device_domain_info *info = get_domain_info(dev);
 
-- 
2.29.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
