Return-Path: <SRS0=QcZA=YE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABC89ECE58C
	for <iommu@archiver.kernel.org>; Fri, 11 Oct 2019 03:58:24 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DF94206A1
	for <iommu@archiver.kernel.org>; Fri, 11 Oct 2019 03:58:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i5EHwYs/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DF94206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 1CEEE1029;
	Fri, 11 Oct 2019 03:57:38 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 61108F2F
	for <iommu@lists.linux-foundation.org>;
	Fri, 11 Oct 2019 03:47:17 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com
	[209.85.214.195])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 136D014D
	for <iommu@lists.linux-foundation.org>;
	Fri, 11 Oct 2019 03:47:17 +0000 (UTC)
Received: by mail-pl1-f195.google.com with SMTP id t10so3812028plr.8
	for <iommu@lists.linux-foundation.org>;
	Thu, 10 Oct 2019 20:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=JdptEyYfrrVWOU3k4HBsHHiS/OxBHfbh3xSJxXoFOXg=;
	b=i5EHwYs/CszsgLgBqVaJ2rCHwBUm8/t6StaUxrR+WK1K3elXfzXSp5NiLQkk3nUJp/
	4oMKE4l/wd4Nc3pLvXzaf6wJQoCyOobPN/HfU1guzjPZsW3VmHpBnGHdb3CM2jYB2Wu0
	XQDL7Lu9aLPIZqrBHm/u23rG9xXJtCQzGmhsg42twwkb0pkN9CXo+2LFSMMXSPGda6kS
	hhgFZ40mIpkqVTb5PBrsRxakHxQ1b9OA1qzxchzU8er9OrhxIRLNWBKcfO3qMhR/g2ZD
	F00814nx3FnVZLdEPKScSSOtHsocSROA6S/JeStl8/3KoPS2Jtyw4X9/np2wn6o1A/2u
	7cSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=JdptEyYfrrVWOU3k4HBsHHiS/OxBHfbh3xSJxXoFOXg=;
	b=q657Xie10KHKQbGYxx6W6qcHcHV8+vvtnRB1K9tIMKB/GoEFSEny8NEv7/jD4lBdxF
	KHmM/ZYVBsFBg0oZBTL3DD6jRCp2YPek0sbcP3Mn9tbkTIV54Z2CbrkeWwc12MuqgPMF
	BdoSbrClQEj9yp5ar3QtfyyWEXeYndJ10HnO/RyUNPLc16YGiceeCkkLRszjPrmc6vFM
	g6B35IFdLXaBZGH54S2NCkE+ZuBLYHSLJqnGE/HihGEMNPqzaZj2nc5ccQa9WgPxKmh9
	6MX38lzZl8A7yL9JzlW74K8gUxZBmWiJPoxFaDlhDeUzsJkIxC1Opom28wnCmnXqh/8D
	XiCA==
X-Gm-Message-State: APjAAAU691/VYLeEXxHHTiPR28FtWcn/WhOBxLje2mjC6mCBOL+YX3mS
	scjREu//cJoNXfgoCM0ZGC4=
X-Google-Smtp-Source: APXvYqwN0/l64V8pBpT3gRAc/OW6eNRZqdFuJPu6MfrrbbPyWTZph1XrL7MD9euTm+lbzWqRsdkvvA==
X-Received: by 2002:a17:902:fe86:: with SMTP id
	x6mr13108364plm.320.1570765636491; 
	Thu, 10 Oct 2019 20:47:16 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com.
	[216.228.112.22]) by smtp.gmail.com with ESMTPSA id
	u3sm7493267pfn.134.2019.10.10.20.47.15
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Thu, 10 Oct 2019 20:47:15 -0700 (PDT)
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: joro@8bytes.org, robh+dt@kernel.org, mark.rutland@arm.com, will@kernel.org,
	robin.murphy@arm.com
Subject: [PATCH 2/2] iommu/arm-smmu: Read optional "input-address-size"
	property
Date: Thu, 10 Oct 2019 20:46:09 -0700
Message-Id: <20191011034609.13319-3-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191011034609.13319-1-nicoleotsuka@gmail.com>
References: <20191011034609.13319-1-nicoleotsuka@gmail.com>
Cc: devicetree@vger.kernel.org, iommu@lists.linux-foundation.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

Some SMMU instances may not connect all input address lines physically
but drive some upper address bits to logical zero, depending on their
SoC designs. Some of them even connect only 39 bits that is not in the
list of IAS/OAS from SMMU internal IDR registers.

After the "input-address-size" property is added to DT bindings, this
patch reads and applies to va_size as an input virtual address width.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
 drivers/iommu/arm-smmu.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index b18aac4c105e..b80a869de45b 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -1805,12 +1805,14 @@ static int arm_smmu_device_cfg_probe(struct arm_smmu_device *smmu)
 			 "failed to set DMA mask for table walker\n");
 
 	if (smmu->version < ARM_SMMU_V2) {
-		smmu->va_size = smmu->ipa_size;
+		if (!smmu->va_size)
+			smmu->va_size = smmu->ipa_size;
 		if (smmu->version == ARM_SMMU_V1_64K)
 			smmu->features |= ARM_SMMU_FEAT_FMT_AARCH64_64K;
 	} else {
 		size = FIELD_GET(ID2_UBS, id);
-		smmu->va_size = arm_smmu_id_size_to_bits(size);
+		if (!smmu->va_size)
+			smmu->va_size = arm_smmu_id_size_to_bits(size);
 		if (id & ID2_PTFS_4K)
 			smmu->features |= ARM_SMMU_FEAT_FMT_AARCH64_4K;
 		if (id & ID2_PTFS_16K)
@@ -1950,6 +1952,7 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev,
 	const struct arm_smmu_match_data *data;
 	struct device *dev = &pdev->dev;
 	bool legacy_binding;
+	u32 va_size;
 
 	if (of_property_read_u32(dev->of_node, "#global-interrupts",
 				 &smmu->num_global_irqs)) {
@@ -1976,6 +1979,9 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev,
 	if (of_dma_is_coherent(dev->of_node))
 		smmu->features |= ARM_SMMU_FEAT_COHERENT_WALK;
 
+	if (!of_property_read_u32(dev->of_node, "input-address-size", &va_size))
+		smmu->va_size = va_size;
+
 	return 0;
 }
 
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
