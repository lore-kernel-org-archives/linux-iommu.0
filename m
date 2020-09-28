Return-Path: <SRS0=rmn6=DF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36B87C2D0A8
	for <iommu@archiver.kernel.org>; Mon, 28 Sep 2020 20:57:09 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DC6A2083B
	for <iommu@archiver.kernel.org>; Mon, 28 Sep 2020 20:57:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="0PX/j912"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DC6A2083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 300E285EF5;
	Mon, 28 Sep 2020 20:57:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id swAnsEc3NU0a; Mon, 28 Sep 2020 20:57:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 99131864E6;
	Mon, 28 Sep 2020 20:57:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 777E5C0889;
	Mon, 28 Sep 2020 20:57:07 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1A1FFC0051
 for <iommu@lists.linux-foundation.org>; Mon, 28 Sep 2020 20:57:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id DFC96203F3
 for <iommu@lists.linux-foundation.org>; Mon, 28 Sep 2020 20:57:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QxT0epEklL1v for <iommu@lists.linux-foundation.org>;
 Mon, 28 Sep 2020 20:57:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by silver.osuosl.org (Postfix) with ESMTPS id 6805920005
 for <iommu@lists.linux-foundation.org>; Mon, 28 Sep 2020 20:57:04 +0000 (UTC)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 00FA92080A;
 Mon, 28 Sep 2020 20:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1601326624;
 bh=7QSESI5ibs3UZkTDPr/lNjD28U/TPwZzxzhvs4wH5tE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=0PX/j912vIkge8ZEw/pcfXuE91ceov+mqg1dW73/u1/AdUs0yOe2cuiMWtwF13zNR
 WQ8P7iEXfKVGvlrxRU3QAYOrVlzyrIquGswDyer6Z8S0BCFe5h++KzBl2aZjQVbiGH
 LvCla2wdxjcMv/GzTbR1tdTgv7b6alN3OB4jyFlk=
Date: Mon, 28 Sep 2020 21:56:58 +0100
From: Will Deacon <will@kernel.org>
To: Auger Eric <eric.auger@redhat.com>
Subject: Re: [PATCH v2] iommu/arm: Add module parameter to set msi iova address
Message-ID: <20200928205658.GB12218@willie-the-truck>
References: <20200914181307.117792-1-vemegava@linux.microsoft.com>
 <20200921204545.GA3811@willie-the-truck>
 <85f7d1ae-71a9-4e95-8a30-03cc699d4794@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <85f7d1ae-71a9-4e95-8a30-03cc699d4794@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: tyhicks@linux.microsoft.com, jean-philippe@linaro.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Vennila Megavannan <vemegava@linux.microsoft.com>, srinath.mannam@broadcom.com,
 bcm-kernel-feedback-list@broadcom.com, robin.murphy@arm.com,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Wed, Sep 23, 2020 at 08:32:43AM +0200, Auger Eric wrote:
> On 9/21/20 10:45 PM, Will Deacon wrote:
> > On Mon, Sep 14, 2020 at 11:13:07AM -0700, Vennila Megavannan wrote:
> >> From: Srinath Mannam <srinath.mannam@broadcom.com>
> >>
> >> Add provision to change default value of MSI IOVA base to platform's
> >> suitable IOVA using module parameter. The present hardcoded MSI IOVA base
> >> may not be the accessible IOVA ranges of platform.
> >>
> >> If any platform has the limitaion to access default MSI IOVA, then it can
> >> be changed using "arm-smmu.msi_iova_base=0xa0000000" command line argument.
> >>
> >> Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
> >> Co-developed-by: Vennila Megavannan <vemegava@linux.microsoft.com>
> >> Signed-off-by: Vennila Megavannan <vemegava@linux.microsoft.com>
> >> ---
> >>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 5 ++++-
> >>  drivers/iommu/arm/arm-smmu/arm-smmu.c       | 5 ++++-
> >>  2 files changed, 8 insertions(+), 2 deletions(-)
> > 
> > This feels pretty fragile. Wouldn't it be better to realise that there's
> > a region conflict with iommu_dma_get_resv_regions() and move the MSI window
> > accordingly at runtime?
> 
> Since cd2c9fcf5c66 ("iommu/dma: Move PCI window region reservation back
> into dma specific path"), the PCI host bridge windows are not exposed by
> iommu_dma_get_resv_regions() anymore. If I understood correctly, what is
> attempted here is to avoid the collision between such PCI host bridge
> window and the MSI IOVA range.

Either way, I think the kernel should figure this out at runtime and not
rely on a cmdline option to tell it where to place the region.

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
