Return-Path: <SRS0=jIn/=7C=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A8ACC433DF
	for <iommu@archiver.kernel.org>; Wed, 20 May 2020 12:25:01 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36E6420756
	for <iommu@archiver.kernel.org>; Wed, 20 May 2020 12:25:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Py3Hwqks"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36E6420756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 0EFD923B2B;
	Wed, 20 May 2020 12:25:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Djq1evz5xG5I; Wed, 20 May 2020 12:25:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 83FBA2375C;
	Wed, 20 May 2020 12:25:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5015CC088A;
	Wed, 20 May 2020 12:25:00 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 16829C0176
 for <iommu@lists.linux-foundation.org>; Wed, 20 May 2020 12:24:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id E3AA323B2B
 for <iommu@lists.linux-foundation.org>; Wed, 20 May 2020 12:24:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PSK9e++bgSxs for <iommu@lists.linux-foundation.org>;
 Wed, 20 May 2020 12:24:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by silver.osuosl.org (Postfix) with ESMTPS id 1B5632375C
 for <iommu@lists.linux-foundation.org>; Wed, 20 May 2020 12:24:58 +0000 (UTC)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id BEAEE20756;
 Wed, 20 May 2020 12:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1589977497;
 bh=d/z8UA8FFrA6+I5LNQQLsUptQcBDDl+RwCUFWJSU6zw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Py3HwqksfPjk89NWRpPwnn8sfAtd0DzcrCytjVZ992kud/N7uojsiaPz/FQw8pqcg
 P7IcO5Q9CA3iDgpHjnjb9EqpJexvxJi3/5cF0SCESbE0/f9a4x/W7MUV4j3pLoxD1j
 YvmuYFDD5uJWdtsGKRoueuBp35Dh0IdzQ19NPaH8=
Date: Wed, 20 May 2020 13:24:53 +0100
From: Will Deacon <will@kernel.org>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH] perf/smmuv3: Allow sharing MMIO registers with the SMMU
 driver
Message-ID: <20200520122453.GB25815@willie-the-truck>
References: <20200421155745.19815-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200421155745.19815-1-jean-philippe@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: mark.rutland@arm.com, iommu@lists.linux-foundation.org,
 robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org
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

On Tue, Apr 21, 2020 at 05:57:46PM +0200, Jean-Philippe Brucker wrote:
> Some Arm SMMUv3 implementations, for example Arm CoreLink MMU-600, embed
> the PMCG registers into the SMMU MMIO regions. It currently causes probe
> failure because the PMU and SMMU drivers request overlapping resources.
> 
> Avoid the conflict by calling devm_ioremap() directly from the PMU
> driver. We loose some sanity-checking of the memory map provided by
> firmware, which doesn't seem catastrophic.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---
> 
> So this is the simplest solution, and I don't think we're missing much
> by skipping the resource reservation. I've also been exploring a more
> complex approach [1] which has the SMMU driver perform resource
> reservation on behalf of the PMU driver, but I'm not sure it's
> necessary.
> 
> Please test, I've only tried the RevC FastModel using devicetree so far.
> 
> [1] https://jpbrucker.net/git/linux/log/?h=smmu/pmu
> ---
>  drivers/perf/arm_smmuv3_pmu.c | 28 +++++++++++++++++++++-------
>  1 file changed, 21 insertions(+), 7 deletions(-)

Is this patch still needed? I can't quite follow from the discussion.

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
