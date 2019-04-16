Return-Path: <SRS0=xVSy=SS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1354C10F13
	for <iommu@archiver.kernel.org>; Tue, 16 Apr 2019 09:14:16 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78B4720675
	for <iommu@archiver.kernel.org>; Tue, 16 Apr 2019 09:14:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78B4720675
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 44DEEC6C;
	Tue, 16 Apr 2019 09:14:16 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 36777BDC
	for <iommu@lists.linux-foundation.org>;
	Tue, 16 Apr 2019 09:14:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.101.70])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id CF9AF1C0
	for <iommu@lists.linux-foundation.org>;
	Tue, 16 Apr 2019 09:14:14 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9858AEBD;
	Tue, 16 Apr 2019 02:14:14 -0700 (PDT)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
	[10.72.51.249])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4166B3F68F;
	Tue, 16 Apr 2019 02:14:13 -0700 (PDT)
Date: Tue, 16 Apr 2019 10:14:10 +0100
From: Will Deacon <will.deacon@arm.com>
To: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Subject: Re: [PATCH v2 0/2] iommu/arm-smmu-v3: make sure the kdump kernel can
	work well when smmu is enabled
Message-ID: <20190416091410.GC31579@fuggles.cambridge.arm.com>
References: <20190318131243.20716-1-thunder.leizhen@huawei.com>
	<20190404153031.GE27558@fuggles.cambridge.arm.com>
	<5CAAB293.3080600@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5CAAB293.3080600@huawei.com>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
Cc: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	iommu <iommu@lists.linux-foundation.org>,
	Robin Murphy <robin.murphy@arm.com>,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190416091410.sZa6PTafQtzYJcqMsJntOM5Jbe3xQuNoxP_IFSL2asM@z>

On Mon, Apr 08, 2019 at 10:31:47AM +0800, Leizhen (ThunderTown) wrote:
> On 2019/4/4 23:30, Will Deacon wrote:
> > On Mon, Mar 18, 2019 at 09:12:41PM +0800, Zhen Lei wrote:
> >> v1 --> v2:
> >> 1. Drop part2. Now, we only use the SMMUv3 hardware feature STE.config=0b000
> >> (Report abort to device, no event recorded) to suppress the event messages
> >> caused by the unexpected devices.
> >> 2. rewrite the patch description.
> > 
> > This issue came up a while back:
> > 
> > https://lore.kernel.org/linux-pci/20180302103032.GB19323@arm.com/
> > 
> > and I'd still prefer to solve it using the disable_bypass logic which we
> > already have. Something along the lines of the diff below?
> 
> Yes, my patches also use disable_bypass=1(set ste.config=0b000). If
> SMMU_IDR0.ST_LEVEL=0(Linear Stream table supported), then all STE entries
> are allocated and initialized(set ste.config=0b000). But if SMMU_IDR0.ST_LEVEL=1
> (2-level Stream Table), we only allocated and initialized the first level tables,
> but leave level 2 tables dynamic allocated. That means, C_BAD_STREAMID(eventid=0x2)
> will be reported, if an unexpeted device access memory without reinitialized in
> kdump kernel.

So is your problem just that the C_BAD_STREAMID events are noisy? If so,
perhaps we should be disabling fault reporting entirely in the kdump kernel.

How about the update diff below? I'm keen to have this as simple as
possible, so we don't end up introducing rarely tested, complex code on
the crash path.

Will

--->8

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index d3880010c6cf..d8b73da6447d 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -2454,13 +2454,9 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu, bool bypass)
 	/* Clear CR0 and sync (disables SMMU and queue processing) */
 	reg = readl_relaxed(smmu->base + ARM_SMMU_CR0);
 	if (reg & CR0_SMMUEN) {
-		if (is_kdump_kernel()) {
-			arm_smmu_update_gbpa(smmu, GBPA_ABORT, 0);
-			arm_smmu_device_disable(smmu);
-			return -EBUSY;
-		}
-
 		dev_warn(smmu->dev, "SMMU currently enabled! Resetting...\n");
+		WARN_ON(is_kdump_kernel() && !disable_bypass);
+		arm_smmu_update_gbpa(smmu, GBPA_ABORT, 0);
 	}
 
 	ret = arm_smmu_device_disable(smmu);
@@ -2553,6 +2549,8 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu, bool bypass)
 		return ret;
 	}
 
+	if (is_kdump_kernel())
+		enables &= ~(CR0_EVTQEN | CR0_PRIQEN);
 
 	/* Enable the SMMU interface, or ensure bypass */
 	if (!bypass || disable_bypass) {
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
