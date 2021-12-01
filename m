Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B996C4167B
	for <iommu@archiver.kernel.org>; Wed,  1 Dec 2021 17:34:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C1EB861BE9;
	Wed,  1 Dec 2021 17:34:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4nVdGlB1Kcs2; Wed,  1 Dec 2021 17:34:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id AD37161BEC;
	Wed,  1 Dec 2021 17:34:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8333BC000A;
	Wed,  1 Dec 2021 17:34:43 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B5177C003F
 for <iommu@lists.linux-foundation.org>; Wed,  1 Dec 2021 17:34:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9538281CE7
 for <iommu@lists.linux-foundation.org>; Wed,  1 Dec 2021 17:34:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3ca8pqfqIfHG for <iommu@lists.linux-foundation.org>;
 Wed,  1 Dec 2021 17:34:40 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C3A8F81BC2
 for <iommu@lists.linux-foundation.org>; Wed,  1 Dec 2021 17:34:39 +0000 (UTC)
Received: by mail-wm1-x333.google.com with SMTP id p18so21034904wmq.5
 for <iommu@lists.linux-foundation.org>; Wed, 01 Dec 2021 09:34:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=4wUTd96eZB11jR8FhOdA8c/6TyDHIYU4luFJMM8Zorc=;
 b=k5I/sAiM7hayNpy0ivvbeZBOIoWPQJJ+Ue5btogoCttQ7Sla6pblXrzkiXmhMRBIP2
 JZSjVxOjzeA/zbdsJ4Mld00sYUoKq53/neBZMvhXeMfpdgkYwPcGEwrwEar0YyaILCBf
 Ltw/HLn8SKbuU2UTK2Uv8tk8FO/vuactFzdubW7ito3CWaCV9OJeyhL7O5KcQBqu0LCw
 LHBrlbFzkAguOkgSThig2ppqRbfPlmwTXhkNQs9YpL9UjZ5jPtY9ObABZKFakCbAYUcX
 r5ckH0WI9lxIS9DokJrA/4lI2oDdrmRNKwXdoQWkNn7ltwWZinyjzeiEH6JoNsjkGDTA
 i/fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=4wUTd96eZB11jR8FhOdA8c/6TyDHIYU4luFJMM8Zorc=;
 b=ASD/CETwPDNlqlpNSY3YllUBOTatrPaKeDKS1WhoCYP0KSXT+jt4UdnDPaljgLBqHP
 O291TI0j2szoN657mlA1NReDT2wSSL2dXXKqdkRPsKr8tgxNQvcKjY77N+6Qqw4R5uMz
 jNrliGKjHgwoicB2Y5wv3Ktjz5daYVI3iF+IuLnvgx3Hl7dTrLpzJIuFme2DNzpDuiGR
 MwEhXV2DhYJrQR43Ou7PvKfUW/dyw+6AIYBGsT3TJ0xNm1p0KFjEXMFW/EMjpO5f+fQL
 8q3eFiYeqEiWUO5sIxdxI9k9wYf+VVNzpMC6mzXr6i0q+GuK1ZZVCAnsxdV+mEeevMOA
 wIWg==
X-Gm-Message-State: AOAM533xnJx8GSKbMVakiarbpiiev3f3aRvdq7HG7jNXgLn0XfJL6Ojt
 Ngwcq2jmFmu7KF0eWW4lcB6CfQ==
X-Google-Smtp-Source: ABdhPJxUPAiNHfZ32Dke/Q9eAsDiXSQWBejQMoi62H4eAO5Rf0AgfmVqvVuVxsb1CMVx7s6ZIW+yHA==
X-Received: by 2002:a7b:c194:: with SMTP id y20mr9033654wmi.61.1638380077860; 
 Wed, 01 Dec 2021 09:34:37 -0800 (PST)
Received: from localhost.localdomain
 (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net. [82.27.106.168])
 by smtp.gmail.com with ESMTPSA id q8sm360023wrx.71.2021.12.01.09.34.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Dec 2021 09:34:37 -0800 (PST)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: joro@8bytes.org,
	will@kernel.org,
	mst@redhat.com,
	jasowang@redhat.com
Subject: [PATCH v3 3/5] iommu/virtio: Sort reserved regions
Date: Wed,  1 Dec 2021 17:33:23 +0000
Message-Id: <20211201173323.1045819-4-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211201173323.1045819-1-jean-philippe@linaro.org>
References: <20211201173323.1045819-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, kevin.tian@intel.com,
 virtualization@lists.linux-foundation.org, pasic@linux.ibm.com,
 iommu@lists.linux-foundation.org, sebastien.boeuf@intel.com
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

To ease identity mapping support, keep the list of reserved regions
sorted.

Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/iommu/virtio-iommu.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index 14dfee76fd19..1b3c1f2741c6 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -423,7 +423,7 @@ static int viommu_add_resv_mem(struct viommu_endpoint *vdev,
 	size_t size;
 	u64 start64, end64;
 	phys_addr_t start, end;
-	struct iommu_resv_region *region = NULL;
+	struct iommu_resv_region *region = NULL, *next;
 	unsigned long prot = IOMMU_WRITE | IOMMU_NOEXEC | IOMMU_MMIO;
 
 	start = start64 = le64_to_cpu(mem->start);
@@ -454,7 +454,12 @@ static int viommu_add_resv_mem(struct viommu_endpoint *vdev,
 	if (!region)
 		return -ENOMEM;
 
-	list_add(&region->list, &vdev->resv_regions);
+	/* Keep the list sorted */
+	list_for_each_entry(next, &vdev->resv_regions, list) {
+		if (next->start > region->start)
+			break;
+	}
+	list_add_tail(&region->list, &next->list);
 	return 0;
 }
 
-- 
2.34.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
