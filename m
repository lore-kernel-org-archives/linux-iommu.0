Return-Path: <SRS0=v9UM=BK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72003C433E0
	for <iommu@archiver.kernel.org>; Fri, 31 Jul 2020 12:21:58 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B99C22B42
	for <iommu@archiver.kernel.org>; Fri, 31 Jul 2020 12:21:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q0ZzbSWp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B99C22B42
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id EEBE78878A;
	Fri, 31 Jul 2020 12:21:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IWiwgAIhJRhI; Fri, 31 Jul 2020 12:21:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 71C9F88788;
	Fri, 31 Jul 2020 12:21:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 56C20C004F;
	Fri, 31 Jul 2020 12:21:57 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8346CC0733
 for <iommu@lists.linux-foundation.org>; Fri, 31 Jul 2020 12:21:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 787188877D
 for <iommu@lists.linux-foundation.org>; Fri, 31 Jul 2020 12:21:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id t3qtGC2JVL9q for <iommu@lists.linux-foundation.org>;
 Fri, 31 Jul 2020 12:21:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by hemlock.osuosl.org (Postfix) with ESMTPS id DEB2988788
 for <iommu@lists.linux-foundation.org>; Fri, 31 Jul 2020 12:21:55 +0000 (UTC)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 3ED962087C;
 Fri, 31 Jul 2020 12:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1596198115;
 bh=vc1ImGY9ezu14UINAtGXOIexIbmqRuCAwzBXUxT5boc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Q0ZzbSWppvmJ/MYB/pGXagBhhSQ9bD7LpZWL9SUT/EWIUBPoOQr5eTL4uUSZ/pdJR
 9UHrnarPMOXE5IZHt/MrDEU3vCVTAhUxjfIp98aFDkGyi+1sT70yxUHjCKH8VO1K79
 NA1fpY7BIdD7et8Xpc9izT6LlrujDEsyimhPF2qA=
Date: Fri, 31 Jul 2020 13:21:50 +0100
From: Will Deacon <will@kernel.org>
To: "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
Subject: Re: [PATCH v2] iommu/arm-smmu-v3: disable MSI polling if SEV polling
 is faster
Message-ID: <20200731122149.GA26817@willie-the-truck>
References: <20200731083343.18152-1-song.bao.hua@hisilicon.com>
 <a425bd85-4872-bf1a-d273-c605c68fa9e1@huawei.com>
 <B926444035E5E2439431908E3842AFD25CFDC3@DGGEMI525-MBS.china.huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <B926444035E5E2439431908E3842AFD25CFDC3@DGGEMI525-MBS.china.huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Linuxarm <linuxarm@huawei.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "Zengtao \(B\)" <prime.zeng@hisilicon.com>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
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

On Fri, Jul 31, 2020 at 10:48:33AM +0000, Song Bao Hua (Barry Song) wrote:
> > -----Original Message-----
> > From: John Garry
> > Sent: Friday, July 31, 2020 10:21 PM
> > To: Song Bao Hua (Barry Song) <song.bao.hua@hisilicon.com>; will@kernel.org;
> > robin.murphy@arm.com; joro@8bytes.org; iommu@lists.linux-foundation.org
> > Cc: Zengtao (B) <prime.zeng@hisilicon.com>; Linuxarm
> > <linuxarm@huawei.com>; linux-arm-kernel@lists.infradead.org
> > Subject: Re: [PATCH v2] iommu/arm-smmu-v3: disable MSI polling if SEV
> > polling is faster
> > 
> > On 31/07/2020 09:33, Barry Song wrote:
> > > Different implementations may show different performance by using SEV
> > > polling or MSI polling.
> > > On the implementation of hi1620, tests show disabling MSI polling can
> > > bring performance improvement.
> > > Using 16 threads to run netperf on hns3 100G NIC with UDP packet size
> > > in 32768bytes and set iommu to strict, TX throughput can improve from
> > > 25Gbps to 27Gbps by this patch.
> > > This patch adds a generic function to support implementation options
> > > based on IIDR and disables MSI polling if IIDR matches the specific
> > > implementation tested.
> > Not sure if we should do checks like this on an implementation basis.
> > I'm sure maintainers will decide.
> 
> Yes, maintainers will decide. I guess Will won't object to IIDR-based solution according to
> previous discussion threads:
> https://lore.kernel.org/patchwork/patch/783718/
> 
> Am I right, Will?

Honestly, I object to the whole idea that we should turn off optional
hardware features just because they're slow. Did nobody take time to look at
the design and check that it offered some benefit, or where they in too much
of a hurry to tick the checkbox to say they had the new feature? I really
dislike the pick and mix nature that some of this IP is heading in, where
the marketing folks want a slice of everything for the branding, instead of
doing a few useful things well. Anyway, that's not your fault, so I'll stop
moaning. *sigh*

Given that you've baked this thing now, then if we have to support it I
would prefer the command-line option. At least that means that people can
compare the performance with it on and off (and hopefully make sure the
hardware doesn't suck). It also means it's not specific to ACPI.

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
