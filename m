Return-Path: <SRS0=maFY=IS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F024EC433DB
	for <iommu@archiver.kernel.org>; Sat, 20 Mar 2021 00:22:35 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DBB561984
	for <iommu@archiver.kernel.org>; Sat, 20 Mar 2021 00:22:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DBB561984
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id ED5C0402A1;
	Sat, 20 Mar 2021 00:22:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id l_vR1C0NteN1; Sat, 20 Mar 2021 00:22:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 77D81402A0;
	Sat, 20 Mar 2021 00:22:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 46F7AC000B;
	Sat, 20 Mar 2021 00:22:33 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B2807C0001
 for <iommu@lists.linux-foundation.org>; Sat, 20 Mar 2021 00:22:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9954060726
 for <iommu@lists.linux-foundation.org>; Sat, 20 Mar 2021 00:22:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2KUDznPxn0sh for <iommu@lists.linux-foundation.org>;
 Sat, 20 Mar 2021 00:22:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 22C8360725
 for <iommu@lists.linux-foundation.org>; Sat, 20 Mar 2021 00:22:31 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id AFCFE61982;
 Sat, 20 Mar 2021 00:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1616199750;
 bh=yfhC9N4yx6xT3rJ9D4E/XRJxPV8sGJTgzQeYH+mdemI=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=TI+APkqWcQfgwonCim+iFmS8c7zEVsrTV2NeAO10POk0eFNuHfwTZ3PS6oUiPfrDE
 dR2bOmbF0/WMJw33/HII0nnoGcMewvvTYXsp+8aiSY4T3UuM62Jdwyj2hN+X5TFTJ7
 0FQv0joGMfB56GV8oao8C42zcWOH8+vO3O3dTf9UpM3/bCHi0kiIe6POaRi2Q66nHp
 hq8n0luM/DiBzMDpdUNsctNmuZHsS97tTwI0jL/an8H/fe4rQmhhn2pBxog4NCQnxt
 Izik/bGIY4VCG20TbjzJ5z9y34gH3OzZ7UjcoXn6lDksBIGlRWAyXj//jBbnwRb52t
 8bDOtP4ZxWtEQ==
Date: Fri, 19 Mar 2021 17:22:28 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@sstabellini-ThinkPad-T480s
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [PATCH] ARM: Qualify enabling of swiotlb_init()
In-Reply-To: <20210319195929.GA1346384@konrad-char-us-oracle-com.allregionaliads.osdevelopmeniad.oraclevcn.com>
Message-ID: <alpine.DEB.2.21.2103191718210.439@sstabellini-ThinkPad-T480s>
References: <20210319040333.183827-1-f.fainelli@gmail.com>
 <20210319130731.GB2624@lst.de>
 <20210319195929.GA1346384@konrad-char-us-oracle-com.allregionaliads.osdevelopmeniad.oraclevcn.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Cc: Florian Fainelli <f.fainelli@gmail.com>, Ard Biesheuvel <ardb@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 open list <linux-kernel@vger.kernel.org>, Russell King <linux@armlinux.org.uk>,
 Max Filippov <jcmvbkbc@gmail.com>,
 "open list:SWIOTLB SUBSYSTEM" <iommu@lists.linux-foundation.org>,
 xen-devel@lists.xensource.com, sstabellini@kernel.org,
 Mike Rapoport <rppt@kernel.org>, opendmb@gmail.com,
 Andrew Morton <akpm@linux-foundation.org>, Robin Murphy <robin.murphy@arm.com>,
 Christoph Hellwig <hch@lst.de>, linux-arm-kernel@lists.infradead.org
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

On Fri, 19 Mar 2021, Konrad Rzeszutek Wilk wrote:
> On Fri, Mar 19, 2021 at 02:07:31PM +0100, Christoph Hellwig wrote:
> > On Thu, Mar 18, 2021 at 09:03:33PM -0700, Florian Fainelli wrote:
> > >  #ifdef CONFIG_ARM_LPAE
> > > +	if (swiotlb_force == SWIOTLB_FORCE ||
> > > +	    max_pfn > arm_dma_pfn_limit)
> > 
> > Does arm_dma_pfn_limit do the right thing even with the weirdest
> > remapping ranges?  Maybe a commen here would be useful.
> > 
> > > +		swiotlb_init(1);
> > > +	else
> > > +		swiotlb_force = SWIOTLB_NO_FORCE;
> > 
> > Konrad: what do you think of setting swiotlb_force to SWIOTLB_NO_FORCE
> > and only switching it to SWIOTLB_NORMAL when swiotlb_init* is called?
> > That kind makes more sense than forcing the callers to do it.
> > 
> > While we're at it, I think swiotlb_force should probably be renamed to
> > swiotlb_mode or somethng like that.
> 
> swiotlb_mode sounds good.
> 
> Also it got me thinking - ARM on Xen at some point was a bit strange, so not sure how
> the logic works here, Stefano?

There is nothing strange in regards to swiotlb_force. swiotlb_force is only used
in swiotlb-xen map_page to figure out whether:

- we actually have to use the swiotlb bounce buffer (this is the
  swiotlb_xen == SWIOTLB_FORCE case)
- or we can use the provided page directly for dma if other conditions
  are met (dma_capable, !range_straddles_page_boundary, ...)


I don't think that switching to "swiotlb_mode" would cause any issues.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
