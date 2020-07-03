Return-Path: <SRS0=r5As=AO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEA73C433E0
	for <iommu@archiver.kernel.org>; Fri,  3 Jul 2020 08:24:32 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E25820724
	for <iommu@archiver.kernel.org>; Fri,  3 Jul 2020 08:24:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E25820724
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 44DC887C4A;
	Fri,  3 Jul 2020 08:24:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ea-CMq0ywkDt; Fri,  3 Jul 2020 08:24:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 2E59587B58;
	Fri,  3 Jul 2020 08:24:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 178BBC0888;
	Fri,  3 Jul 2020 08:24:31 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5A98BC0733
 for <iommu@lists.linux-foundation.org>; Fri,  3 Jul 2020 08:24:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 54EBC89499
 for <iommu@lists.linux-foundation.org>; Fri,  3 Jul 2020 08:24:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UTTNAzmrrSmL for <iommu@lists.linux-foundation.org>;
 Fri,  3 Jul 2020 08:24:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by hemlock.osuosl.org (Postfix) with ESMTP id 2C9F789490
 for <iommu@lists.linux-foundation.org>; Fri,  3 Jul 2020 08:24:28 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6DB4A2F;
 Fri,  3 Jul 2020 01:24:27 -0700 (PDT)
Received: from [10.57.21.32] (unknown [10.57.21.32])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 91FAE3F73C;
 Fri,  3 Jul 2020 01:24:25 -0700 (PDT)
Subject: Re: [PATCH v3 1/4] iommu/arm-smmu: Add SMMU ID2 register fixup hook
To: Tomasz Nowicki <tn@semihalf.com>, will@kernel.org, joro@8bytes.org,
 gregory.clement@bootlin.com, robh+dt@kernel.org, hannah@marvell.com
References: <20200702201633.22693-1-tn@semihalf.com>
 <20200702201633.22693-2-tn@semihalf.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <d3540512-09c7-0fa5-2b35-6f1112a575a9@arm.com>
Date: Fri, 3 Jul 2020 09:24:24 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200702201633.22693-2-tn@semihalf.com>
Content-Language: en-GB
Cc: devicetree@vger.kernel.org, catalin.marinas@arm.com,
 linux-kernel@vger.kernel.org, nadavh@marvell.com,
 iommu@lists.linux-foundation.org, mw@semihalf.com,
 linux-arm-kernel@lists.infradead.org
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 2020-07-02 21:16, Tomasz Nowicki wrote:
> We already have 'cfg_probe' hook which meant to override and apply
> workarounds while probing ID registers. However, 'cfg_probe' is called
> at the very end and therefore for some cases fixing up things becomes complex
> or requires exporting of SMMU driver structures. Hence, seems it is better and
> cleaner to do ID fixup right away. In preparation for adding Marvell
> errata add an extra ID2 fixup hook.

Hmm, the intent of ->cfg_probe was very much to give impl a chance to 
adjust the detected features before we start consuming them, with this 
exact case in mind. Since the Cavium quirk isn't actually doing that - 
it just needs to run *anywhere* in the whole probe process - I'm under 
no illusion that I put the hook in exactly the right place first time 
around ;)

The diff below should be more on the mark...

Robin.

----->8-----
diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 243bc4cb2705..884ffca5b1eb 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -1891,6 +1891,9 @@ static int arm_smmu_device_cfg_probe(struct 
arm_smmu_device *smmu)
  			smmu->features |= ARM_SMMU_FEAT_FMT_AARCH64_64K;
  	}

+	if (smmu->impl && smmu->impl->cfg_probe)
+		return smmu->impl->cfg_probe(smmu);
+
  	/* Now we've corralled the various formats, what'll it do? */
  	if (smmu->features & ARM_SMMU_FEAT_FMT_AARCH32_S)
  		smmu->pgsize_bitmap |= SZ_4K | SZ_64K | SZ_1M | SZ_16M;
@@ -1909,7 +1912,6 @@ static int arm_smmu_device_cfg_probe(struct 
arm_smmu_device *smmu)
  	dev_notice(smmu->dev, "\tSupported page sizes: 0x%08lx\n",
  		   smmu->pgsize_bitmap);

-
  	if (smmu->features & ARM_SMMU_FEAT_TRANS_S1)
  		dev_notice(smmu->dev, "\tStage-1: %lu-bit VA -> %lu-bit IPA\n",
  			   smmu->va_size, smmu->ipa_size);
@@ -1918,9 +1920,6 @@ static int arm_smmu_device_cfg_probe(struct 
arm_smmu_device *smmu)
  		dev_notice(smmu->dev, "\tStage-2: %lu-bit IPA -> %lu-bit PA\n",
  			   smmu->ipa_size, smmu->pa_size);

-	if (smmu->impl && smmu->impl->cfg_probe)
-		return smmu->impl->cfg_probe(smmu);
-
  	return 0;
  }

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
