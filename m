Return-Path: <SRS0=s4mY=HE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6CF7C433DB
	for <iommu@archiver.kernel.org>; Tue,  2 Feb 2021 06:31:40 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29C7464E91
	for <iommu@archiver.kernel.org>; Tue,  2 Feb 2021 06:31:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29C7464E91
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id C89A485B4F;
	Tue,  2 Feb 2021 06:31:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HO0ecDZgFDuX; Tue,  2 Feb 2021 06:31:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id A120485ACD;
	Tue,  2 Feb 2021 06:31:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 84B22C0FA7;
	Tue,  2 Feb 2021 06:31:39 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 58707C013A
 for <iommu@lists.linux-foundation.org>; Tue,  2 Feb 2021 06:31:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 311C22045F
 for <iommu@lists.linux-foundation.org>; Tue,  2 Feb 2021 06:31:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wiN-VZtNxX7O for <iommu@lists.linux-foundation.org>;
 Tue,  2 Feb 2021 06:31:36 +0000 (UTC)
X-Greylist: delayed 00:05:03 by SQLgrey-1.7.6
Received: from mail29.static.mailgun.info (mail29.static.mailgun.info
 [104.130.122.29])
 by silver.osuosl.org (Postfix) with ESMTPS id 54DC81FF98
 for <iommu@lists.linux-foundation.org>; Tue,  2 Feb 2021 06:31:36 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1612247496; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=z7Jt7mLpbCjEtcnUQ9bOehTzH3Sk9XSsW7oxWAsa7AE=;
 b=PGLV4heM2XIv03lKQaN5vmog3pyObQUqg7rmSwP1vkVp6JU0iJhmOvp9KIH7PTYGPvhc0yTL
 LtPaOBK02ur5r8SgqTuLHYRbc1UzXV45XFemZ3lWl0b2ldgEKJ5c+W4vlIg96hBm+ANzp15o
 9XGlZP0zGRuTgegPNYCyfX6Nntc=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3NDkwMCIsICJpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 6018f0957a21b36a9d327dcc (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 02 Feb 2021 06:26:29
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id 29122C43467; Tue,  2 Feb 2021 06:26:29 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: saiprakash.ranjan)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 9D118C433C6;
 Tue,  2 Feb 2021 06:26:27 +0000 (UTC)
MIME-Version: 1.0
Date: Tue, 02 Feb 2021 11:56:27 +0530
From: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To: Rob Clark <robdclark@gmail.com>
Subject: Re: [PATCH 2/3] iommu/io-pgtable-arm: Add IOMMU_LLC page protection
 flag
In-Reply-To: <20210201182016.GA21629@jcrouse1-lnx.qualcomm.com>
References: <cover.1610372717.git.saiprakash.ranjan@codeaurora.org>
 <3f589e7de3f9fa93e84c83420c5270c546a0c368.1610372717.git.saiprakash.ranjan@codeaurora.org>
 <20210129090516.GB3998@willie-the-truck>
 <5d23fce629323bcda71594010824aad0@codeaurora.org>
 <20210201111556.GA7172@willie-the-truck>
 <CAF6AEGsARmkAFsjaQLfa2miMgeijo183MWDKGtW_ti-UCpzBqA@mail.gmail.com>
 <20210201182016.GA21629@jcrouse1-lnx.qualcomm.com>
Message-ID: <7e9aade14d0b7f69285852ade4a5a9f4@codeaurora.org>
X-Sender: saiprakash.ranjan@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Cc: "Isaac J. Manjarres" <isaacm@codeaurora.org>,
 freedreno <freedreno@lists.freedesktop.org>, David Airlie <airlied@linux.ie>,
 Will Deacon <will@kernel.org>, Akhil P Oommen <akhilpo@codeaurora.org>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Sean Paul <sean@poorly.run>, "list@263.net:IOMMU DRIVERS , 
 Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
 Kristian H Kristensen <hoegsberg@google.com>, Daniel Vetter <daniel@ffwll.ch>,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>,
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 2021-02-01 23:50, Jordan Crouse wrote:
> On Mon, Feb 01, 2021 at 08:20:44AM -0800, Rob Clark wrote:
>> On Mon, Feb 1, 2021 at 3:16 AM Will Deacon <will@kernel.org> wrote:
>> >
>> > On Fri, Jan 29, 2021 at 03:12:59PM +0530, Sai Prakash Ranjan wrote:
>> > > On 2021-01-29 14:35, Will Deacon wrote:
>> > > > On Mon, Jan 11, 2021 at 07:45:04PM +0530, Sai Prakash Ranjan wrote:
>> > > > > Add a new page protection flag IOMMU_LLC which can be used
>> > > > > by non-coherent masters to set cacheable memory attributes
>> > > > > for an outer level of cache called as last-level cache or
>> > > > > system cache. Initial user of this page protection flag is
>> > > > > the adreno gpu and then can later be used by other clients
>> > > > > such as video where this can be used for per-buffer based
>> > > > > mapping.
>> > > > >
>> > > > > Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
>> > > > > ---
>> > > > >  drivers/iommu/io-pgtable-arm.c | 3 +++
>> > > > >  include/linux/iommu.h          | 6 ++++++
>> > > > >  2 files changed, 9 insertions(+)
>> > > > >
>> > > > > diff --git a/drivers/iommu/io-pgtable-arm.c
>> > > > > b/drivers/iommu/io-pgtable-arm.c
>> > > > > index 7439ee7fdcdb..ebe653ef601b 100644
>> > > > > --- a/drivers/iommu/io-pgtable-arm.c
>> > > > > +++ b/drivers/iommu/io-pgtable-arm.c
>> > > > > @@ -415,6 +415,9 @@ static arm_lpae_iopte
>> > > > > arm_lpae_prot_to_pte(struct arm_lpae_io_pgtable *data,
>> > > > >           else if (prot & IOMMU_CACHE)
>> > > > >                   pte |= (ARM_LPAE_MAIR_ATTR_IDX_CACHE
>> > > > >                           << ARM_LPAE_PTE_ATTRINDX_SHIFT);
>> > > > > +         else if (prot & IOMMU_LLC)
>> > > > > +                 pte |= (ARM_LPAE_MAIR_ATTR_IDX_INC_OCACHE
>> > > > > +                         << ARM_LPAE_PTE_ATTRINDX_SHIFT);
>> > > > >   }
>> > > > >
>> > > > >   if (prot & IOMMU_CACHE)
>> > > > > diff --git a/include/linux/iommu.h b/include/linux/iommu.h
>> > > > > index ffaa389ea128..1f82057df531 100644
>> > > > > --- a/include/linux/iommu.h
>> > > > > +++ b/include/linux/iommu.h
>> > > > > @@ -31,6 +31,12 @@
>> > > > >   * if the IOMMU page table format is equivalent.
>> > > > >   */
>> > > > >  #define IOMMU_PRIV       (1 << 5)
>> > > > > +/*
>> > > > > + * Non-coherent masters can use this page protection flag to set
>> > > > > cacheable
>> > > > > + * memory attributes for only a transparent outer level of cache,
>> > > > > also known as
>> > > > > + * the last-level or system cache.
>> > > > > + */
>> > > > > +#define IOMMU_LLC        (1 << 6)
>> > > >
>> > > > On reflection, I'm a bit worried about exposing this because I think it
>> > > > will
>> > > > introduce a mismatched virtual alias with the CPU (we don't even have a
>> > > > MAIR
>> > > > set up for this memory type). Now, we also have that issue for the PTW,
>> > > > but
>> > > > since we always use cache maintenance (i.e. the streaming API) for
>> > > > publishing the page-tables to a non-coheren walker, it works out.
>> > > > However,
>> > > > if somebody expects IOMMU_LLC to be coherent with a DMA API coherent
>> > > > allocation, then they're potentially in for a nasty surprise due to the
>> > > > mismatched outer-cacheability attributes.
>> > > >
>> > >
>> > > Can't we add the syscached memory type similar to what is done on android?
>> >
>> > Maybe. How does the GPU driver map these things on the CPU side?
>> 
>> Currently we use writecombine mappings for everything, although there
>> are some cases that we'd like to use cached (but have not merged
>> patches that would give userspace a way to flush/invalidate)
>> 
>> BR,
>> -R
> 
> LLC/system cache doesn't have a relationship with the CPU cache.  Its 
> just a
> little accelerator that sits on the connection from the GPU to DDR and 
> caches
> accesses. The hint that Sai is suggesting is used to mark the buffers 
> as
> 'no-write-allocate' to prevent GPU write operations from being cached 
> in the LLC
> which a) isn't interesting and b) takes up cache space for read 
> operations.
> 
> Its easiest to think of the LLC as a bonus accelerator that has no cost 
> for
> us to use outside of the unfortunate per buffer hint.
> 
> We do have to worry about the CPU cache w.r.t I/O coherency (which is a
> different hint) and in that case we have all of concerns that Will 
> identified.
> 

For mismatched outer cacheability attributes which Will mentioned, I was
referring to [1] in android kernel.

[1] https://android-review.googlesource.com/c/kernel/common/+/1549097/3

Thanks,
Sai

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a 
member
of Code Aurora Forum, hosted by The Linux Foundation
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
