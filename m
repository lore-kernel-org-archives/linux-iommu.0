Return-Path: <SRS0=nwur=C6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF0E1C4363C
	for <iommu@archiver.kernel.org>; Mon, 21 Sep 2020 21:08:26 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C0B923119
	for <iommu@archiver.kernel.org>; Mon, 21 Sep 2020 21:08:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="vtoe5ZIh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C0B923119
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 380A485B36;
	Mon, 21 Sep 2020 21:08:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EV3a+dd-lOU5; Mon, 21 Sep 2020 21:08:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 52A6B84D22;
	Mon, 21 Sep 2020 21:08:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 35907C0889;
	Mon, 21 Sep 2020 21:08:25 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 807BAC0051
 for <iommu@lists.linux-foundation.org>; Mon, 21 Sep 2020 21:08:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 2B33520780
 for <iommu@lists.linux-foundation.org>; Mon, 21 Sep 2020 21:08:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ObZNCwMNkfVY for <iommu@lists.linux-foundation.org>;
 Mon, 21 Sep 2020 21:08:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by silver.osuosl.org (Postfix) with ESMTPS id 44B0120778
 for <iommu@lists.linux-foundation.org>; Mon, 21 Sep 2020 21:08:21 +0000 (UTC)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id ECEDB20874;
 Mon, 21 Sep 2020 21:08:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1600722500;
 bh=qXfvVdC3ovH7v/K0ck6SbGCxk1JarB8felKvT1Qvaq4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=vtoe5ZIhPzxEaBW5SgIlqLCJtITDRRgJYx5ZnF1jq4Ies+7GtzOCtNpBnNRls2+EH
 SBiRA/tE8lYdH7wTjgI2Z1mvrX6OboXWDUFOSda3xExr2QReDNASNLaNO64jGeekhq
 x3/FRaD4gPWrBiHuQMHx8U0dJIarNFr5n04h9MG8=
Date: Mon, 21 Sep 2020 22:08:15 +0100
From: Will Deacon <will@kernel.org>
To: Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [PATCH v3 6/8] iommu/arm-smmu: Add impl hook for inherit boot
 mappings
Message-ID: <20200921210814.GE3811@willie-the-truck>
References: <20200904155513.282067-1-bjorn.andersson@linaro.org>
 <20200904155513.282067-7-bjorn.andersson@linaro.org>
 <0bfcc8f7-d054-616b-834b-319461b1ecb9@arm.com>
 <20200913032559.GT3715@yoga>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200913032559.GT3715@yoga>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Rob Clark <robdclark@chromium.org>, linux-arm-msm@vger.kernel.org,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 Sibi Sankar <sibis@codeaurora.org>, Robin Murphy <robin.murphy@arm.com>,
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

On Sat, Sep 12, 2020 at 10:25:59PM -0500, Bjorn Andersson wrote:
> On Fri 11 Sep 12:13 CDT 2020, Robin Murphy wrote:
> > On 2020-09-04 16:55, Bjorn Andersson wrote:
> > > Add a new operation to allow platform implementations to inherit any
> > > stream mappings from the boot loader.
> > 
> > Is there a reason we need an explicit step for this? The aim of the
> > cfg_probe hook is that the SMMU software state should all be set up by then,
> > and you can mess about with it however you like before arm_smmu_reset()
> > actually commits anything to hardware. I would have thought you could
> > permanently steal a context bank, configure it as your bypass hole, read out
> > the previous SME configuration and tweak smmu->smrs and smmu->s2crs
> > appropriately all together "invisibly" at that point.
> 
> I did this because as of 6a79a5a3842b ("iommu/arm-smmu: Call
> configuration impl hook before consuming features") we no longer have
> setup pgsize_bitmap as we hit cfg_probe, which means that I need to
> replicate this logic to set up the iommu_domain.
> 
> If I avoid setting up an iommu_domain for the identity context, as you
> request in patch 8, this shouldn't be needed anymore.
> 
> > If that can't work, I'm very curious as to what I've overlooked.
> > 
> 
> I believe that will work, I will rework the patches and try it out.

Did you get a chance to rework this?

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
