Return-Path: <SRS0=YfIy=NA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD03DC4338F
	for <iommu@archiver.kernel.org>; Mon,  9 Aug 2021 17:48:04 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AB446023F
	for <iommu@archiver.kernel.org>; Mon,  9 Aug 2021 17:48:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5AB446023F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1EC9340232;
	Mon,  9 Aug 2021 17:48:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Bx84m-ns4lci; Mon,  9 Aug 2021 17:48:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id DDBB640221;
	Mon,  9 Aug 2021 17:47:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 967AEC001A;
	Mon,  9 Aug 2021 17:47:59 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CEE1EC000E
 for <iommu@lists.linux-foundation.org>; Mon,  9 Aug 2021 17:47:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with UTF8SMTP id AAF3640400
 for <iommu@lists.linux-foundation.org>; Mon,  9 Aug 2021 17:47:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=mg.codeaurora.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with UTF8SMTP id beLewg-ref_q for <iommu@lists.linux-foundation.org>;
 Mon,  9 Aug 2021 17:47:53 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from m43-7.mailgun.net (m43-7.mailgun.net [69.72.43.7])
 by smtp4.osuosl.org (Postfix) with UTF8SMTPS id A86EA40261
 for <iommu@lists.linux-foundation.org>; Mon,  9 Aug 2021 17:47:51 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1628531273; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=8guuvupjL6NqII3stb55gN3OwOOwh2DbzAjTfValqJY=;
 b=AeWQs4j8TlPCklaTH3V8Z+ALtPJ5LwjHDg/GWx28p51/BkhXtSwK5nlgSMsWejwlIgJLbAmg
 eOrg9xHnhUB6h6qrvWV64SUN4TgRCtnfGavqDONEkHBl7lbYM/o9uRnCk5YLQQOwJzd3B6Ri
 eAwWostoNKRbyO0/STg3UTXt9ds=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3NDkwMCIsICJpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 61116a3e91487ad520648713 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 09 Aug 2021 17:47:42
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id 032D5C43144; Mon,  9 Aug 2021 17:47:41 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: saiprakash.ranjan)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 33FD9C433F1;
 Mon,  9 Aug 2021 17:47:40 +0000 (UTC)
MIME-Version: 1.0
Date: Mon, 09 Aug 2021 23:17:40 +0530
From: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To: Will Deacon <will@kernel.org>, Rob Clark <robdclark@gmail.com>
Subject: Re: [Freedreno] [PATCH 0/3] iommu/drm/msm: Allow non-coherent masters
 to use system cache
In-Reply-To: <20210809174022.GA1840@willie-the-truck>
References: <20210728140052.GB22887@mms-0441>
 <8b2742c8891abe4fec3664730717a089@codeaurora.org>
 <20210802105544.GA27657@willie-the-truck>
 <CAF6AEGvtpFu8st=ZFNoKjP9YsAenciLxL1zMFi_iqMCvdby73w@mail.gmail.com>
 <20210802151409.GE28735@willie-the-truck>
 <CAF6AEGtzvyEUm0Fc8QT5t9KNK7i0FbFyi7zDM2_PMCzZBp7qbw@mail.gmail.com>
 <20210809145651.GC1458@willie-the-truck>
 <CAF6AEGsSUojA=V0n2iRWTCn++buqN=Eoxo0r3=+=PBu1O=H-AQ@mail.gmail.com>
 <20210809170508.GB1589@willie-the-truck>
 <CAF6AEGtmZ3LzAJdtnKDQDbEN-a6_JgdN-fZ96pkU3dZqkiW91g@mail.gmail.com>
 <20210809174022.GA1840@willie-the-truck>
Message-ID: <76bfd0b4248148dfbf9d174ddcb4c2a2@codeaurora.org>
X-Sender: saiprakash.ranjan@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Cc: "Isaac J. Manjarres" <isaacm@codeaurora.org>,
 freedreno <freedreno@lists.freedesktop.org>,
 Jordan Crouse <jcrouse@codeaurora.org>, David Airlie <airlied@linux.ie>,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 Akhil P Oommen <akhilpo@codeaurora.org>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "list@263.net:IOMMU DRIVERS , Joerg Roedel
 <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
 Kristian H Kristensen <hoegsberg@google.com>, Daniel Vetter <daniel@ffwll.ch>,
 Sean Paul <sean@poorly.run>, "moderated list:ARM/FREESCALE IMX / MXC ARM
 ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
 Robin Murphy <robin.murphy@arm.com>
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

On 2021-08-09 23:10, Will Deacon wrote:
> On Mon, Aug 09, 2021 at 10:18:21AM -0700, Rob Clark wrote:
>> On Mon, Aug 9, 2021 at 10:05 AM Will Deacon <will@kernel.org> wrote:
>> >
>> > On Mon, Aug 09, 2021 at 09:57:08AM -0700, Rob Clark wrote:
>> > > On Mon, Aug 9, 2021 at 7:56 AM Will Deacon <will@kernel.org> wrote:
>> > > > On Mon, Aug 02, 2021 at 06:36:04PM -0700, Rob Clark wrote:
>> > > > > On Mon, Aug 2, 2021 at 8:14 AM Will Deacon <will@kernel.org> wrote:
>> > > > > > On Mon, Aug 02, 2021 at 08:08:07AM -0700, Rob Clark wrote:
>> > > > > > > On Mon, Aug 2, 2021 at 3:55 AM Will Deacon <will@kernel.org> wrote:
>> > > > > > > > On Thu, Jul 29, 2021 at 10:08:22AM +0530, Sai Prakash Ranjan wrote:
>> > > > > > > > > On 2021-07-28 19:30, Georgi Djakov wrote:
>> > > > > > > > > > On Mon, Jan 11, 2021 at 07:45:02PM +0530, Sai Prakash Ranjan wrote:
>> > > > > > > > > > > commit ecd7274fb4cd ("iommu: Remove unused IOMMU_SYS_CACHE_ONLY flag")
>> > > > > > > > > > > removed unused IOMMU_SYS_CACHE_ONLY prot flag and along with it went
>> > > > > > > > > > > the memory type setting required for the non-coherent masters to use
>> > > > > > > > > > > system cache. Now that system cache support for GPU is added, we will
>> > > > > > > > > > > need to set the right PTE attribute for GPU buffers to be sys cached.
>> > > > > > > > > > > Without this, the system cache lines are not allocated for GPU.
>> > > > > > > > > > >
>> > > > > > > > > > > So the patches in this series introduces a new prot flag IOMMU_LLC,
>> > > > > > > > > > > renames IO_PGTABLE_QUIRK_ARM_OUTER_WBWA to IO_PGTABLE_QUIRK_PTW_LLC
>> > > > > > > > > > > and makes GPU the user of this protection flag.
>> > > > > > > > > >
>> > > > > > > > > > Thank you for the patchset! Are you planning to refresh it, as it does
>> > > > > > > > > > not apply anymore?
>> > > > > > > > > >
>> > > > > > > > >
>> > > > > > > > > I was waiting on Will's reply [1]. If there are no changes needed, then
>> > > > > > > > > I can repost the patch.
>> > > > > > > >
>> > > > > > > > I still think you need to handle the mismatched alias, no? You're adding
>> > > > > > > > a new memory type to the SMMU which doesn't exist on the CPU side. That
>> > > > > > > > can't be right.
>> > > > > > > >
>> > > > > > >
>> > > > > > > Just curious, and maybe this is a dumb question, but what is your
>> > > > > > > concern about mismatched aliases?  I mean the cache hierarchy on the
>> > > > > > > GPU device side (anything beyond the LLC) is pretty different and
>> > > > > > > doesn't really care about the smmu pgtable attributes..
>> > > > > >
>> > > > > > If the CPU accesses a shared buffer with different attributes to those which
>> > > > > > the device is using then you fall into the "mismatched memory attributes"
>> > > > > > part of the Arm architecture. It's reasonably unforgiving (you should go and
>> > > > > > read it) and in some cases can apply to speculative accesses as well, but
>> > > > > > the end result is typically loss of coherency.
>> > > > >
>> > > > > Ok, I might have a few other sections to read first to decipher the
>> > > > > terminology..
>> > > > >
>> > > > > But my understanding of LLC is that it looks just like system memory
>> > > > > to the CPU and GPU (I think that would make it "the point of
>> > > > > coherence" between the GPU and CPU?)  If that is true, shouldn't it be
>> > > > > invisible from the point of view of different CPU mapping options?
>> > > >
>> > > > You could certainly build a system where mismatched attributes don't cause
>> > > > loss of coherence, but as it's not guaranteed by the architecture and the
>> > > > changes proposed here affect APIs which are exposed across SoCs, then I
>> > > > don't think it helps much.
>> > > >
>> > >
>> > > Hmm, the description of the new mapping flag is that it applies only
>> > > to transparent outer level cache:
>> > >
>> > > +/*
>> > > + * Non-coherent masters can use this page protection flag to set cacheable
>> > > + * memory attributes for only a transparent outer level of cache, also known as
>> > > + * the last-level or system cache.
>> > > + */
>> > > +#define IOMMU_LLC      (1 << 6)
>> > >
>> > > But I suppose we could call it instead IOMMU_QCOM_LLC or something
>> > > like that to make it more clear that it is not necessarily something
>> > > that would work with a different outer level cache implementation?
>> >
>> > ... or we could just deal with the problem so that other people can reuse
>> > the code. I haven't really understood the reluctance to solve this properly.
>> >
>> > Am I missing some reason this isn't solvable?
>> 
>> Oh, was there another way to solve it (other than foregoing setting
>> INC_OCACHE in the pgtables)?  Maybe I misunderstood, is there a
>> corresponding setting on the MMU pgtables side of things?
> 
> Right -- we just need to program the CPU's MMU with the matching memory
> attributes! It's a bit more fiddly if you're just using ioremap_wc()
> though, as it's usually the DMA API which handles the attributes under 
> the
> hood.
> 
> Anyway, sorry, I should've said that explicitly earlier on. We've done 
> this
> sort of thing in the Android tree so I assumed Sai knew what needed to 
> be
> done and then I didn't think to explain to you :(
> 

Right I was aware of that but even in the android tree there is no user 
:)
I think we can't have a new memory type without any user right in 
upstream
like android tree?

@Rob, I think you  already tried adding a new MT and used 
pgprot_syscached()
in GPU driver but it was crashing?

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
