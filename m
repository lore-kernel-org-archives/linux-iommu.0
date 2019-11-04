Return-Path: <SRS0=uwQI=Y4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 213BCCA9EB5
	for <iommu@archiver.kernel.org>; Mon,  4 Nov 2019 20:20:21 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB8522089C
	for <iommu@archiver.kernel.org>; Mon,  4 Nov 2019 20:20:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="pL8zkee5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB8522089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 9FF9FEEE;
	Mon,  4 Nov 2019 20:20:20 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 70B72E37
	for <iommu@lists.linux-foundation.org>;
	Mon,  4 Nov 2019 20:20:19 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 1FEDFA9
	for <iommu@lists.linux-foundation.org>;
	Mon,  4 Nov 2019 20:20:19 +0000 (UTC)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
	bits)) (No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 1193F20848;
	Mon,  4 Nov 2019 20:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572898818;
	bh=JipY3XJzUsF1P6m4Hv+xqqCgPVMO3Uh57oGm0DYfx+w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pL8zkee5aroldx0B1bhCATWEsKhB65+m3rowYZG3X+z+5XN0BDxLbrPaiHggB9pXa
	uyU5UxlomMIPaIizZonDK0rjIHfL8HzfwYH8XA6OW1OCGkr8jWsb+Tw0IJRp3/bRkC
	kuzelt8qf01s7CJS7Hm7Zv9EQi7SyAHAy+1HpJ3k=
Date: Mon, 4 Nov 2019 20:20:12 +0000
From: Will Deacon <will@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v2 00/10] iommu/io-pgtable: Cleanup and prep for split
	tables
Message-ID: <20191104202012.GN24909@willie-the-truck>
References: <cover.1572024119.git.robin.murphy@arm.com>
	<20191104192228.GL24909@willie-the-truck>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191104192228.GL24909@willie-the-truck>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On Mon, Nov 04, 2019 at 07:22:28PM +0000, Will Deacon wrote:
> On Fri, Oct 25, 2019 at 07:08:29PM +0100, Robin Murphy wrote:
> > Since the flawed first attempt, I've reworked things with an abstracted
> > TCR and an explicit TTBR1 quirk. I originally envisaged the need to pass
> > the quirk all the way down to the TLBI calls, hence getting diverted
> > into trying to make the parameter passing less cluttered in general, but
> > in the end it turned out fairly neat to just fix the indexing such that
> > we can always just pass around the original unmodified IOVA. Most of the
> > new patches come from staring at that indexing code for long enough to
> > see the subtle inefficiencies that were worth ironing out, plus a bit of
> > random cleanup which doesn't feel worth posting separately.
> > 
> > Note that these patches depend on the fixes already queued in -rc4,
> > otherwise there will be conflicts in arm_mali_lpae_alloc_pgtable().
> > 
> > Robin.
> > 
> > 
> > Robin Murphy (10):
> >   iommu/io-pgtable: Make selftest gubbins consistently __init
> >   iommu/io-pgtable-arm: Rationalise size check
> >   iommu/io-pgtable-arm: Simplify bounds checks
> >   iommu/io-pgtable-arm: Simplify start level lookup
> >   iommu/io-pgtable-arm: Simplify PGD size handling
> >   iommu/io-pgtable-arm: Simplify level indexing
> >   iommu/io-pgtable-arm: Rationalise MAIR handling
> >   iommu/io-pgtable-arm: Rationalise TTBRn handling
> >   iommu/io-pgtable-arm: Rationalise TCR handling
> >   iommu/io-pgtable-arm: Prepare for TTBR1 usage
> 
> Overall, this looks really good to me. There's a bit more work to do
> (see my comments) and I'd like Jordan to have a look as well, but on the
> whole it's a big improvement. Thanks.

Also, I've merged the first 7 patches to save you having to repost those:

https://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git/log/?h=for-joerg/arm-smmu/updates

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
