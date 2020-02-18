Return-Path: <SRS0=Yw80=4G=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D89EC34026
	for <iommu@archiver.kernel.org>; Tue, 18 Feb 2020 09:00:43 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2294222527
	for <iommu@archiver.kernel.org>; Tue, 18 Feb 2020 09:00:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="kq4bNpYm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2294222527
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 035F220486;
	Tue, 18 Feb 2020 09:00:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 86VsR3yQxZ2e; Tue, 18 Feb 2020 09:00:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id B77BE20020;
	Tue, 18 Feb 2020 09:00:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9BDDAC1D84;
	Tue, 18 Feb 2020 09:00:41 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 37978C013E
 for <iommu@lists.linux-foundation.org>; Tue, 18 Feb 2020 09:00:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 1E031873BC
 for <iommu@lists.linux-foundation.org>; Tue, 18 Feb 2020 09:00:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Fia5EUj1eB0y for <iommu@lists.linux-foundation.org>;
 Tue, 18 Feb 2020 09:00:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 67521870A9
 for <iommu@lists.linux-foundation.org>; Tue, 18 Feb 2020 09:00:39 +0000 (UTC)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 0525021D7D;
 Tue, 18 Feb 2020 09:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1582016439;
 bh=nJTlTh1s/kepTsug2+IOCbMEXlfm3m8KEwDaYFJCiXM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=kq4bNpYmC9wHa8ldJdKK02M7YRboy2JYMKXp6BlQrueC6uv7i8rLA8L/32u1lkCDY
 8dYx6WlGLEpY/gObTgmwOQZ2cZCx9LM4Ex0xBvsPUGkN0DVYKDQK6X2E2nAJplBaSR
 XzDp4kWaVW1eK3mFWXNHxNKHSkwAosSvcu+z0PWE=
Date: Tue, 18 Feb 2020 09:00:35 +0000
From: Will Deacon <will@kernel.org>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH v2] iommu/arm-smmu-v3: Batch ATC invalidation commands
Message-ID: <20200218090034.GC16828@willie-the-truck>
References: <20200213205600.19690-1-robh@kernel.org>
 <20200217182918.GE1650092@myrica>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200217182918.GE1650092@myrica>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Rob Herring <robh@kernel.org>, iommu@lists.linux-foundation.org,
 Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org
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

On Mon, Feb 17, 2020 at 07:29:18PM +0100, Jean-Philippe Brucker wrote:
> On Thu, Feb 13, 2020 at 02:56:00PM -0600, Rob Herring wrote:
> > Similar to commit 2af2e72b18b4 ("iommu/arm-smmu-v3: Defer TLB
> > invalidation until ->iotlb_sync()"), build up a list of ATC invalidation
> > commands and submit them all at once to the command queue instead of
> > one-by-one.
> > 
> > As there is only one caller of arm_smmu_atc_inv_master() left, we can
> > simplify it and avoid passing in struct arm_smmu_cmdq_ent.
> > 
> > Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > Cc: Will Deacon <will@kernel.org>
> > Cc: Robin Murphy <robin.murphy@arm.com>
> > Cc: Joerg Roedel <joro@8bytes.org>
> > Signed-off-by: Rob Herring <robh@kernel.org>
> 
> Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> 
> 
> Since I'm adding a third user of cmdq batching [1], I had a go at
> factoring them. I can send the attached patch with my next version, if it
> looks OK.

Yes, the idea looks good to me. Feel free to pick this stuff into a series
so that I can review it for 5.7.

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
