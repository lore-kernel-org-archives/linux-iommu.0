Return-Path: <SRS0=4Gp4=44=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AE52C3F2D0
	for <iommu@archiver.kernel.org>; Wed, 11 Mar 2020 12:47:07 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C32922527
	for <iommu@archiver.kernel.org>; Wed, 11 Mar 2020 12:47:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bM45cSb5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C32922527
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 240E687EB5;
	Wed, 11 Mar 2020 12:47:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3KWdOSUcRKdQ; Wed, 11 Mar 2020 12:47:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 5DE0E87E9D;
	Wed, 11 Mar 2020 12:47:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3B7E2C1D8E;
	Wed, 11 Mar 2020 12:47:06 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E5775C0177
 for <iommu@lists.linux-foundation.org>; Wed, 11 Mar 2020 12:47:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id DFE0987E54
 for <iommu@lists.linux-foundation.org>; Wed, 11 Mar 2020 12:47:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id x2SO76KghKvY for <iommu@lists.linux-foundation.org>;
 Wed, 11 Mar 2020 12:47:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com
 [209.85.221.66])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 0EB7E87EA7
 for <iommu@lists.linux-foundation.org>; Wed, 11 Mar 2020 12:47:04 +0000 (UTC)
Received: by mail-wr1-f66.google.com with SMTP id m9so2407351wro.12
 for <iommu@lists.linux-foundation.org>; Wed, 11 Mar 2020 05:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=VY7nWjSoNMWvNd0g+xzvWepeHfbATP8qtCHjDYePPIE=;
 b=bM45cSb5Ozho2TEVIim6lgIlvJ17mCR4C+CsT0Pimx9uxnQtSRpiekb7vk+z4TyBsg
 i7bCTVuOPTtPUnD2gS9GnmKQttH1xBdYZqnq7yaTFWf44UtlBDgeGi2Es8eKBPIPPPDW
 LkYcp3rebBLLDqlaAmYWvqR8k6Z0HKttNv5g+FX0w3DwWT8V2qEp9TbR7xK1Xs2Xfv7w
 rCLokPC198gIy+yenj4tR9bAAp9qsRBLynUJuCnGQmJE3DnkPLxWi3/fYa7x3rTRXbVT
 dl0hIDgEYGiTAMo+9g7A7MoDCl4F6e3beKsqThLrOGkIuYk7YRvTsfD3H2hnQqzrnbmn
 0SjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=VY7nWjSoNMWvNd0g+xzvWepeHfbATP8qtCHjDYePPIE=;
 b=Xf2QYga/3VxOFKj1pHB3yU1s/BeYxdl4+pcYg7Lmt5qLC5G6b34qDvSSQHJHeO+szb
 2j5WMKqjebFp8IMxg6GrDysHOBomCOI6chssMKDmczNpnH+4AOJpHQSCOGjoHhBDTkl0
 SLeEMlHM6Vu3+eHt2raA7jTmmtpPNTqNFKKt5WJcu4VjZDjaGDnPV6t+J4NYA1XqiVv5
 X1EqqhVO1LCff7nf0t9PfFSSC2aVvMhv106P6xY6934wpqd8ycaZt7WEkpipxjwKH8++
 bcrDOWAILEaMlB1QyoA+ngyo/Pn4y5CJKjT4LXf34iFvAs8g5qwCVMJYhr+TDLPigRDM
 HAdQ==
X-Gm-Message-State: ANhLgQ3pRWtMalf/D7uyyj4qkL9QIqCbKIoDZt8CBfNP7i+Rufw5yuHc
 Bv0h0vCOoHYk1Z530LO/2uDRYLxIC1A=
X-Google-Smtp-Source: ADFU+vvwMGkHBLCwyNQwQal6X/GbzQAYuf8900S7rXGVFBA3Oqi6Q9GIzMLJrx/FlXi4IXLOUR1+0A==
X-Received: by 2002:a5d:6591:: with SMTP id q17mr4218053wru.22.1583930822453; 
 Wed, 11 Mar 2020 05:47:02 -0700 (PDT)
Received: from localhost.localdomain
 ([2001:171b:c9a8:fbc0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id c2sm8380020wma.39.2020.03.11.05.47.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Mar 2020 05:47:01 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: bhelgaas@google.com, will@kernel.org, robh+dt@kernel.org, joro@8bytes.org,
 baolu.lu@linux.intel.com, sudeep.holla@arm.com, linux-doc@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-acpi@vger.kernel.org,
 iommu@lists.linux-foundation.org
Subject: [PATCH v2 06/11] iommu/amd: Use pci_ats_supported()
Date: Wed, 11 Mar 2020 13:45:01 +0100
Message-Id: <20200311124506.208376-7-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200311124506.208376-1-jean-philippe@linaro.org>
References: <20200311124506.208376-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Cc: mark.rutland@arm.com, Jean-Philippe Brucker <jean-philippe@linaro.org>,
 frowand.list@gmail.com, corbet@lwn.net, liviu.dudau@arm.com, rjw@rjwysocki.net,
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
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
