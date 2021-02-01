Return-Path: <SRS0=Rmex=HD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CEEEC433DB
	for <iommu@archiver.kernel.org>; Mon,  1 Feb 2021 11:16:08 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DAAF64E9B
	for <iommu@archiver.kernel.org>; Mon,  1 Feb 2021 11:16:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DAAF64E9B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 142B685A37;
	Mon,  1 Feb 2021 11:16:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XDV_TYTAVObE; Mon,  1 Feb 2021 11:16:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 35D5C85A58;
	Mon,  1 Feb 2021 11:16:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2EB14C0FA7;
	Mon,  1 Feb 2021 11:16:06 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BBD7AC013A
 for <iommu@lists.linux-foundation.org>; Mon,  1 Feb 2021 11:16:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id B6B6D869BB
 for <iommu@lists.linux-foundation.org>; Mon,  1 Feb 2021 11:16:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id m+6SHGPSu+0q for <iommu@lists.linux-foundation.org>;
 Mon,  1 Feb 2021 11:16:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 0E51886961
 for <iommu@lists.linux-foundation.org>; Mon,  1 Feb 2021 11:16:03 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4BF4260295;
 Mon,  1 Feb 2021 11:16:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1612178163;
 bh=hKAt1deWUX5/xDiTH9sYCeS4LQkY0BTslNtqnwjcIjM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=IWObnZZlXJUW4JhK2hwnWD3A/oSMtWejuWWNwC2LUGXgEArvEWxH8eZgdi/SlEfNQ
 Jfmv+EVI6ZlTDPRGfL6hKwRoknp9oWLFaa39J6F23jvjCM92XVKiSCmQ5eZQrcc/Nv
 8zAwg5+fQBe9sfcmhKidXx4MZjagJ1M+SHQmvf1A+3LFVpLD/ASZKznLCXllzZJGyz
 x+6z3iRowfF9eh/6NR7qaSdLdRV4o/tPMRo8db7Pu6YkgZIWRkDUST54gebn8JPZkA
 +ejW4kxmDInSYBPXEPHSfVLFkDhB8ST4L2K0yHFyG3nQJ0B+eBF3/m1KNDI489k2PL
 sc5by+e4iVAJw==
Date: Mon, 1 Feb 2021 11:15:56 +0000
From: Will Deacon <will@kernel.org>
To: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Subject: Re: [PATCH 2/3] iommu/io-pgtable-arm: Add IOMMU_LLC page protection
 flag
Message-ID: <20210201111556.GA7172@willie-the-truck>
References: <cover.1610372717.git.saiprakash.ranjan@codeaurora.org>
 <3f589e7de3f9fa93e84c83420c5270c546a0c368.1610372717.git.saiprakash.ranjan@codeaurora.org>
 <20210129090516.GB3998@willie-the-truck>
 <5d23fce629323bcda71594010824aad0@codeaurora.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5d23fce629323bcda71594010824aad0@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: isaacm@codeaurora.org, freedreno <freedreno@lists.freedesktop.org>,
 David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Akhil P Oommen <akhilpo@codeaurora.org>,
 Sean Paul <sean@poorly.run>, Kristian H Kristensen <hoegsberg@google.com>,
 dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
 linux-arm-msm@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
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

On Fri, Jan 29, 2021 at 03:12:59PM +0530, Sai Prakash Ranjan wrote:
> On 2021-01-29 14:35, Will Deacon wrote:
> > On Mon, Jan 11, 2021 at 07:45:04PM +0530, Sai Prakash Ranjan wrote:
> > > Add a new page protection flag IOMMU_LLC which can be used
> > > by non-coherent masters to set cacheable memory attributes
> > > for an outer level of cache called as last-level cache or
> > > system cache. Initial user of this page protection flag is
> > > the adreno gpu and then can later be used by other clients
> > > such as video where this can be used for per-buffer based
> > > mapping.
> > > 
> > > Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> > > ---
> > >  drivers/iommu/io-pgtable-arm.c | 3 +++
> > >  include/linux/iommu.h          | 6 ++++++
> > >  2 files changed, 9 insertions(+)
> > > 
> > > diff --git a/drivers/iommu/io-pgtable-arm.c
> > > b/drivers/iommu/io-pgtable-arm.c
> > > index 7439ee7fdcdb..ebe653ef601b 100644
> > > --- a/drivers/iommu/io-pgtable-arm.c
> > > +++ b/drivers/iommu/io-pgtable-arm.c
> > > @@ -415,6 +415,9 @@ static arm_lpae_iopte
> > > arm_lpae_prot_to_pte(struct arm_lpae_io_pgtable *data,
> > >  		else if (prot & IOMMU_CACHE)
> > >  			pte |= (ARM_LPAE_MAIR_ATTR_IDX_CACHE
> > >  				<< ARM_LPAE_PTE_ATTRINDX_SHIFT);
> > > +		else if (prot & IOMMU_LLC)
> > > +			pte |= (ARM_LPAE_MAIR_ATTR_IDX_INC_OCACHE
> > > +				<< ARM_LPAE_PTE_ATTRINDX_SHIFT);
> > >  	}
> > > 
> > >  	if (prot & IOMMU_CACHE)
> > > diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> > > index ffaa389ea128..1f82057df531 100644
> > > --- a/include/linux/iommu.h
> > > +++ b/include/linux/iommu.h
> > > @@ -31,6 +31,12 @@
> > >   * if the IOMMU page table format is equivalent.
> > >   */
> > >  #define IOMMU_PRIV	(1 << 5)
> > > +/*
> > > + * Non-coherent masters can use this page protection flag to set
> > > cacheable
> > > + * memory attributes for only a transparent outer level of cache,
> > > also known as
> > > + * the last-level or system cache.
> > > + */
> > > +#define IOMMU_LLC	(1 << 6)
> > 
> > On reflection, I'm a bit worried about exposing this because I think it
> > will
> > introduce a mismatched virtual alias with the CPU (we don't even have a
> > MAIR
> > set up for this memory type). Now, we also have that issue for the PTW,
> > but
> > since we always use cache maintenance (i.e. the streaming API) for
> > publishing the page-tables to a non-coheren walker, it works out.
> > However,
> > if somebody expects IOMMU_LLC to be coherent with a DMA API coherent
> > allocation, then they're potentially in for a nasty surprise due to the
> > mismatched outer-cacheability attributes.
> > 
> 
> Can't we add the syscached memory type similar to what is done on android?

Maybe. How does the GPU driver map these things on the CPU side?

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
