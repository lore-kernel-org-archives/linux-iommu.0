Return-Path: <SRS0=PRYs=65=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF64EC433E3
	for <iommu@archiver.kernel.org>; Fri, 15 May 2020 10:48:44 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A178C20787
	for <iommu@archiver.kernel.org>; Fri, 15 May 2020 10:48:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P6/7hIE4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A178C20787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 90D778948A;
	Fri, 15 May 2020 10:48:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3pEuQCSko03B; Fri, 15 May 2020 10:48:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id C215889494;
	Fri, 15 May 2020 10:48:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AFABFC0178;
	Fri, 15 May 2020 10:48:39 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2A200C016F
 for <iommu@lists.linux-foundation.org>; Fri, 15 May 2020 10:48:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 2701587BDE
 for <iommu@lists.linux-foundation.org>; Fri, 15 May 2020 10:48:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DU-YVU1xrEzc for <iommu@lists.linux-foundation.org>;
 Fri, 15 May 2020 10:48:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com
 [209.85.128.65])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 9FFAD87BCE
 for <iommu@lists.linux-foundation.org>; Fri, 15 May 2020 10:48:32 +0000 (UTC)
Received: by mail-wm1-f65.google.com with SMTP id f134so1844939wmf.1
 for <iommu@lists.linux-foundation.org>; Fri, 15 May 2020 03:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=guIyIxw2Cj+e2cp6UNPEu5aERqphnHRHK0daLjNZEtg=;
 b=P6/7hIE4DwjSbFHn0gUenOd7tQIjElNY44np4Xp3owXyeiZ5/eDrsF2jXhN1HFtXI9
 mzI4y6p5DgU2UcrYdlCXB96VGS31EbpJJbdZ9F86VezeEZeC0/al4dI1yjpzsPObxXFq
 bH1rMvZMRi2LIS/5qWwon90KoCmlhOIT8yk6ptHFuyroaHqPfVbNWqX4o+QJrImdJg1K
 yVQAnTXoaK5haWRQFRYea+uFgN4n5RLlto9awJagAWmH0iE5BZWxjLgcRKzajZy0eLZ/
 94povR05970KSOg2HzI7zF8fn1cxzEnzDPqenijZflhH7uWaKOz7YHkN5wHpu/4kyjB0
 AxGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=guIyIxw2Cj+e2cp6UNPEu5aERqphnHRHK0daLjNZEtg=;
 b=J2BRGEFvy69DnrAlnOt0ZO8oN0y+jkjKlHLrJd2E1XUHsw9TnmOWztl+/hI+IQIgKL
 byt3XXKzDk05cGxvU3mi+j4eWq+7vhnyfRXqS69fTvjFXumJ6Ig6Jk6iSyMprL91Uutf
 w/Y6IkuVT7Hwnvk2789fdWbCI/dqRh6g/HTr/mwjCPAyDV4Q888uF5BzUK2ndlwa4iB+
 9twhDcMAcAu0QkdWc1eIyl10rqvKiYybNPgJvgpoy2+5Rh3LhpgT2BBNSu+LY4mZXlzv
 hL1XrbMK0R9NkBOLbd1KqDPbZZ08jR20CR9DzbaWH0rr3mjKteuWIcOmxub8utmxgZyB
 CJ9w==
X-Gm-Message-State: AOAM531NNMB0ziNP7MqSmprysvNhkVPYaKklzdytF5gFrTtRz0Oy7IUx
 crWrbJsEbqRcUF6UHmef8pCo8A==
X-Google-Smtp-Source: ABdhPJwOoccKW1cdQKZVyETbXOshCl3JLZVuvoDXSwsZotxA+Esgngps5B0KVjlnEG+HNrZiI1lhug==
X-Received: by 2002:a1c:1d12:: with SMTP id d18mr3248638wmd.109.1589539711093; 
 Fri, 15 May 2020 03:48:31 -0700 (PDT)
Received: from localhost.localdomain
 ([2001:171b:226e:c200:c43b:ef78:d083:b355])
 by smtp.gmail.com with ESMTPSA id h27sm3510392wrc.46.2020.05.15.03.48.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2020 03:48:30 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux-foundation.org, joro@8bytes.org, bhelgaas@google.com
Subject: [PATCH 2/4] iommu/amd: Use pci_ats_supported()
Date: Fri, 15 May 2020 12:44:00 +0200
Message-Id: <20200515104359.1178606-3-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200515104359.1178606-1-jean-philippe@linaro.org>
References: <20200515104359.1178606-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, ashok.raj@intel.com,
 will@kernel.org, alex.williamson@redhat.com, robin.murphy@arm.com,
 dwmw2@infradead.org
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
allowed to use it. In addition to checking that the device has an ATS
capability and that the global pci=noats is not set
(pci_ats_disabled()), it also checks if a device is untrusted.

A device is untrusted if it is plugged into an external-facing port such
as Thunderbolt and could be spoofing an existing device to exploit
weaknesses in the IOMMU configuration. By calling pci_ats_supported() we
keep DTE[I]=0 for untrusted devices and abort transactions with
Pretranslated Addresses.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/iommu/amd_iommu.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 1dc3718560d0e8..8b7a9e811d33a6 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -313,16 +313,15 @@ static struct iommu_group *acpihid_device_group(struct device *dev)
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
@@ -3150,11 +3149,8 @@ int amd_iommu_device_info(struct pci_dev *pdev,
 
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
2.26.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
