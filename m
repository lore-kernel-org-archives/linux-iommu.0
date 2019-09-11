Return-Path: <SRS0=UwG5=XG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09D43C49ED6
	for <iommu@archiver.kernel.org>; Wed, 11 Sep 2019 16:20:34 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2D782075C
	for <iommu@archiver.kernel.org>; Wed, 11 Sep 2019 16:20:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="YL25Ni2z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2D782075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id B7AF7E40;
	Wed, 11 Sep 2019 16:20:33 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id CF8D8E3D
	for <iommu@lists.linux-foundation.org>;
	Wed, 11 Sep 2019 16:20:32 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id E81EB894
	for <iommu@lists.linux-foundation.org>;
	Wed, 11 Sep 2019 16:20:30 +0000 (UTC)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
	bits)) (No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 52C712075C;
	Wed, 11 Sep 2019 16:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568218830;
	bh=ML9CagDnoV24dH/liU+tAV3aws+Mfn1OHAlc/UJ+x0g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YL25Ni2zh9FTQ3GoCsbQsOR1W3iZd/tbahynfMIKv17ojfj8LQb99yqPIyiZhhJ0H
	4AERf6MS5IOX0xMaMu9mdyGGrJbZf9jbKyVbvjtQ2ALBDeN97EjAexI1toVw2tHMzW
	Au3jP/SJp7uqBKxhElR/0lFix5x/gvzJprHWiX/8=
Date: Wed, 11 Sep 2019 17:20:25 +0100
From: Will Deacon <will@kernel.org>
To: Neil Armstrong <narmstrong@baylibre.com>
Subject: Re: [PATCH 0/3] iommu/io-pgtable-arm: Mali LPAE improvements
Message-ID: <20190911162024.i2sda7uzy3pbrnyd@willie-the-truck>
References: <cover.1568211045.git.robin.murphy@arm.com>
	<d77047c2-1f16-eded-17ba-7463310d4bba@baylibre.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <d77047c2-1f16-eded-17ba-7463310d4bba@baylibre.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Cc: robh@kernel.org, tomeu.vizoso@collabora.com, steven.price@arm.com,
	iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>,
	linux-arm-kernel@lists.infradead.org
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

On Wed, Sep 11, 2019 at 06:19:04PM +0200, Neil Armstrong wrote:
> On 11/09/2019 16:42, Robin Murphy wrote:
> > Here's the eagerly-awaited fix to unblock T720/T820, plus a couple of
> > other bits that I've collected so far. I'm not considering this as
> > 5.3 fixes material, but it would be nice if there's any chance still
> > to sneak it into 5.4.
> > 
> > Robin.
> > 
> > 
> > Robin Murphy (3):
> >   iommu/io-pgtable-arm: Correct Mali attributes
> >   iommu/io-pgtable-arm: Support more Mali configurations
> >   iommu/io-pgtable-arm: Allow coherent walks for Mali
> > 
> >  drivers/iommu/io-pgtable-arm.c | 61 ++++++++++++++++++++++++++--------
> >  1 file changed, 48 insertions(+), 13 deletions(-)
> > 
> 
> Tested-by: Neil Armstrong <narmstrong@baylibre.com>
> 
> On Khadas VIM2 (Amlogic S912) with T820 Mali GPU
> 
> I hope this will be part of v5.4 so we can run panfrost on vanilla v5.4 !

Not a chance -- the merge window opens on Monday and -next isn't being
rolled out at the moment due to LPC. Let's shoot for 5.5 and get this
queued up in a few weeks.

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
