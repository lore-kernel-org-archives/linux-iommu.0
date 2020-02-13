Return-Path: <SRS0=ZJ+1=4B=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13270C3B19D
	for <iommu@archiver.kernel.org>; Thu, 13 Feb 2020 16:52:17 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D54C22465D
	for <iommu@archiver.kernel.org>; Thu, 13 Feb 2020 16:52:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ym2NkCwb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D54C22465D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 9EC4B851E5;
	Thu, 13 Feb 2020 16:52:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id a4moL+gREeLr; Thu, 13 Feb 2020 16:52:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 0DC40857E6;
	Thu, 13 Feb 2020 16:52:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 05FB0C1D8E;
	Thu, 13 Feb 2020 16:52:15 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 27F11C0177
 for <iommu@lists.linux-foundation.org>; Thu, 13 Feb 2020 16:52:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 2459F850CF
 for <iommu@lists.linux-foundation.org>; Thu, 13 Feb 2020 16:52:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PK31+5ENGKv6 for <iommu@lists.linux-foundation.org>;
 Thu, 13 Feb 2020 16:52:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com
 [209.85.221.65])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 59FBA84FB3
 for <iommu@lists.linux-foundation.org>; Thu, 13 Feb 2020 16:52:12 +0000 (UTC)
Received: by mail-wr1-f65.google.com with SMTP id w12so7565546wrt.2
 for <iommu@lists.linux-foundation.org>; Thu, 13 Feb 2020 08:52:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Ok2VflFFpn82omTuxL3VzAJ/IWmjkZJAtl6hkoQPLn0=;
 b=ym2NkCwbZ8ok/8h7pLkDQzEx2pDfzAtJPMb4rPMByTvSy/oalugI/V5JdlFt4HfW0j
 dy3n/NgRB22hO7k5AqHtguWMskUiv6FfYdBSQyDs10POhlzx5r3Vyc1FaOYaTQLHwy3D
 d/8qFXw1yuseQLQstm8SGLXypdyYjPtns0heVSXOt17xr7Gjayy5ml6DMHoZdGpLN4uR
 PLVvrsya1vzI+JVp2LsgFgtKyDGVGeg9zlaQ0JehE8kpbLtrOJIiKPukUtWFMOIbg3h5
 n4b2lOMzwyI0KIeO33JNGTjnIbr+aYSAgVteGDFxKWsP2wx2WH1MYBWCTwhGa9YgQj03
 s+Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Ok2VflFFpn82omTuxL3VzAJ/IWmjkZJAtl6hkoQPLn0=;
 b=U4BDttnQd/uU2cUzJaYNQabLT5SgqlGnmKtvbzXn67CyPgNLn+6pKiOwK/6WqrToWj
 /GOp18gbg/Vm7AQEym+WS0lU38Su2pBr1AHhnc07FnUNYiGeZTCymW+qpH7Gogyeajlt
 XlepeHnGmTCMogUGsinzzi1NkHW15WjQlYGDw2fuBJgc4/Z2FIeqszyZzzEhLLF++FJF
 GX3qxJUZYDPLd1wDgiz27MJ3cnM7HubJsyfLt1P4UxfaH6BKvksqjQ3fEqtYvYxevm4O
 3vZ6zVOaiVH6MZTpHCMcm6ALLi2ijyCO+uURQkZ0Vc3UUOqa2R6SQO+gWztbxjNoRI+6
 pX3g==
X-Gm-Message-State: APjAAAXkHqwTJkEG517Ug1/0Bq/U+mQKtamoG3eiTfn39qt8Uez/6cmK
 LA6nh2QeBGEYzVeVrD7viVegTg==
X-Google-Smtp-Source: APXvYqxMXp/ilBRu+no890FzgqKyNs9xsIMVwvkwTf8WIMQwsdZIOnE4gjEVHQ+8qUzRVZx0noCWuw==
X-Received: by 2002:adf:f382:: with SMTP id m2mr22276136wro.163.1581612730849; 
 Thu, 13 Feb 2020 08:52:10 -0800 (PST)
Received: from localhost.localdomain ([2001:171b:2276:930:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id y6sm3484807wrl.17.2020.02.13.08.52.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2020 08:52:10 -0800 (PST)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: bhelgaas@google.com, will@kernel.org, robh+dt@kernel.org,
 lorenzo.pieralisi@arm.com, joro@8bytes.org, baolu.lu@linux.intel.com,
 linux-doc@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-acpi@vger.kernel.org, iommu@lists.linux-foundation.org
Subject: [PATCH 06/11] iommu/amd: Use pci_ats_supported()
Date: Thu, 13 Feb 2020 17:50:44 +0100
Message-Id: <20200213165049.508908-7-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200213165049.508908-1-jean-philippe@linaro.org>
References: <20200213165049.508908-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Cc: mark.rutland@arm.com, frowand.list@gmail.com, corbet@lwn.net,
 liviu.dudau@arm.com, sudeep.holla@arm.com, rjw@rjwysocki.net,
 guohanjun@huawei.com, amurray@thegoodpenguin.co.uk, robin.murphy@arm.com,
 dwmw2@infradead.org, lenb@kernel.org
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

The pci_ats_supported() function checks if a device supports ATS and is
allowed to use it.  In addition to checking that the device has an ATS
capability and that the global pci=noats is not set
(pci_ats_disabled()), it also checks if a device is untrusted (plugged
into an external-facing port such as thunderbolt).

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/iommu/amd_iommu.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index aac132bd1ef0..084f0b2e132e 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -291,16 +291,15 @@ static struct iommu_group *acpihid_device_group(struct device *dev)
 static bool pci_iommuv2_capable(struct pci_dev *pdev)
 {
 	static const int caps[] = {
-		PCI_EXT_CAP_ID_ATS,
 		PCI_EXT_CAP_ID_PRI,
 		PCI_EXT_CAP_ID_PASID,
 	};
 	int i, pos;
 
-	if (pci_ats_disabled())
+	if (!pci_ats_supported(pdev))
 		return false;
 
-	for (i = 0; i < 3; ++i) {
+	for (i = 0; i < 2; ++i) {
 		pos = pci_find_ext_capability(pdev, caps[i]);
 		if (pos == 0)
 			return false;
@@ -3040,11 +3039,8 @@ int amd_iommu_device_info(struct pci_dev *pdev,
 
 	memset(info, 0, sizeof(*info));
 
-	if (!pci_ats_disabled()) {
-		pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_ATS);
-		if (pos)
-			info->flags |= AMD_IOMMU_DEVICE_FLAG_ATS_SUP;
-	}
+	if (pci_ats_supported(pdev))
+		info->flags |= AMD_IOMMU_DEVICE_FLAG_ATS_SUP;
 
 	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_PRI);
 	if (pos)
-- 
2.25.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
