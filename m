Return-Path: <SRS0=unsG=4I=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F734C761A1
	for <iommu@archiver.kernel.org>; Thu, 20 Feb 2020 02:35:25 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FEB824656
	for <iommu@archiver.kernel.org>; Thu, 20 Feb 2020 02:35:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FEB824656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id DEFD4845D4;
	Thu, 20 Feb 2020 02:35:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id a3b9AjElk-AU; Thu, 20 Feb 2020 02:35:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id B5C5B8443E;
	Thu, 20 Feb 2020 02:35:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9633DC1D80;
	Thu, 20 Feb 2020 02:35:23 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5B609C013E
 for <iommu@lists.linux-foundation.org>; Thu, 20 Feb 2020 02:35:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 41F238444F
 for <iommu@lists.linux-foundation.org>; Thu, 20 Feb 2020 02:35:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Oh3BoXVazBJS for <iommu@lists.linux-foundation.org>;
 Thu, 20 Feb 2020 02:35:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 4D1138443E
 for <iommu@lists.linux-foundation.org>; Thu, 20 Feb 2020 02:35:21 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 19 Feb 2020 18:35:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,462,1574150400"; d="scan'208";a="228779902"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.249.162.231])
 ([10.249.162.231])
 by fmsmga007.fm.intel.com with ESMTP; 19 Feb 2020 18:35:17 -0800
Subject: Re: [PATCH] iommu/vt-d: Fix a bug in intel_iommu_iova_to_phys() for
 huge page
To: Yonghyun Hwang <yonghyun@google.com>
References: <20200218222324.231915-1-yonghyun@google.com>
 <8efc6ea2-d51e-624c-5cc2-4049bb224122@linux.intel.com>
 <20200219044235.GA1397@epycbox.lan>
 <CAEauFbw_FGWuQJMpr7PgyyCAefKChXoszKAz-ykBKgxFc-aa4g@mail.gmail.com>
 <9e3f1bb8-bbfd-174c-b7a7-617dea7c2c9a@linux.intel.com>
 <CAEauFbyqYeMoxTQfQZ8MLXg1i8TDohyuKeEWrC4Ui8SMdbjAKQ@mail.gmail.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <95a2974a-6ec4-1fbd-251b-e9f992d22a7a@linux.intel.com>
Date: Thu, 20 Feb 2020 10:35:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAEauFbyqYeMoxTQfQZ8MLXg1i8TDohyuKeEWrC4Ui8SMdbjAKQ@mail.gmail.com>
Content-Language: en-US
Cc: Havard Skinnemoen <hskinnemoen@google.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Moritz Fischer <mdf@kernel.org>,
 Moritz Fischer <moritzf@google.com>, Deepa Dinamani <deepadinamani@google.com>,
 David Woodhouse <dwmw2@infradead.org>
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

Hi Yonghyun,

On 2020/2/20 8:12, Yonghyun Hwang wrote:
> Hello Baolu,
> 
> Yes, pfn_to_dma_pte() doesn't put 0 for level. However, it's hard for
> me to get that without comment, which is the reason why I put a dummy
> "if" there. Anyway, what about the following code?
> 
> static inline unsigned long offset_mask(int level)
> {
>      return BIT_MASK(level_to_offset_bits(level) + VTD_PAGE_SHIFT) - 1;
> }

This helper is unnecessary since it's only for the iova_to_phys(). I'd
like to put it in the code directly. Other looks good to me.

By the way, can you please rebase your patch on the top of the mainline
kernel tree and add a patch version if you are willing to send a new
version of this patch?

Best regards,
baolu

> 
> static phys_addr_t intel_iommu_iova_to_phys(struct iommu_domain *domain,
>                        dma_addr_t iova)
> {
>      struct dmar_domain *dmar_domain = to_dmar_domain(domain);
>      struct dma_pte *pte;
>      int level = 0;
>      u64 phys = 0;
> 
>      if (dmar_domain->flags & DOMAIN_FLAG_LOSE_CHILDREN)
>          return 0;
> 
>      pte = pfn_to_dma_pte(dmar_domain, iova >> VTD_PAGE_SHIFT, &level);
>      if (pte)
>          phys = dma_pte_addr(pte) + (iova & offset_mask(level));
> 
>      return phys;
> }
> 
> On Wed, Feb 19, 2020 at 3:33 PM Lu Baolu <baolu.lu@linux.intel.com> wrote:
>>
>> Hi,
>>
>> On 2020/2/20 2:51, Yonghyun Hwang wrote:
>>> Hello Lu and Moritz,
>>>
>>> I think it's better to keep "if (level > 1)" because
>>> level_to_offset_bits() returns (unsigned int) -1 * LEVEL_STRIDE if level
>>> becomes 0.
>>
>> @level will never be 0 in this case.
>>
>> Best regards,
>> baolu
>>
>>>
>>> static inline unsigned int level_to_offset_bits(int level)
>>> {
>>>     return (level - 1) * LEVEL_STRIDE;
>>> }
>>>
>>> On Tue, Feb 18, 2020 at 8:42 PM Moritz Fischer <mdf@kernel.org
>>> <mailto:mdf@kernel.org>> wrote:
>>>
>>>      Hi Baolu, Yonghyun
>>>
>>>      On Wed, Feb 19, 2020 at 11:15:36AM +0800, Lu Baolu wrote:
>>>       > Hi Yonghyun,
>>>       >
>>>       > Thanks for the patch.
>>>       >
>>>       > On 2020/2/19 6:23, Yonghyun Hwang wrote:
>>>       > > intel_iommu_iova_to_phys() has a bug when it translates an IOVA
>>>      for a huge
>>>       > > page onto its corresponding physical address. This commit fixes
>>>      the bug by
>>>       > > accomodating the level of page entry for the IOVA and adds
>>>      IOVA's lower
>>>       > > address to the physical address. >
>>>       > > Signed-off-by: Yonghyun Hwang <yonghyun@google.com
>>>      <mailto:yonghyun@google.com>>
>>>       > > ---
>>>       > >   drivers/iommu/intel-iommu.c | 11 +++++++++--
>>>       > >   1 file changed, 9 insertions(+), 2 deletions(-)
>>>       > >
>>>       > > diff --git a/drivers/iommu/intel-iommu.c
>>>      b/drivers/iommu/intel-iommu.c
>>>       > > index 0c8d81f56a30..ed6e69adb578 100644
>>>       > > --- a/drivers/iommu/intel-iommu.c
>>>       > > +++ b/drivers/iommu/intel-iommu.c
>>>       > > @@ -5555,13 +5555,20 @@ static phys_addr_t
>>>      intel_iommu_iova_to_phys(struct iommu_domain *domain,
>>>       > >     struct dma_pte *pte;
>>>       > >     int level = 0;
>>>       > >     u64 phys = 0;
>>>       > > +   const unsigned long pfn = iova >> VTD_PAGE_SHIFT;
>>>       >
>>>       > Why do you need a "const unsigned long" here?
>>>
>>>
>>>
>>> It's because pfn_to_dma_pte() takes pfn for its second parameter as
>>> "unsigned int" type and pfn is not changed in intel_iommu_iova_to_phys().
>>>
>>>       >
>>>       > >     if (dmar_domain->flags & DOMAIN_FLAG_LOSE_CHILDREN)
>>>       > >             return 0;
>>>       > > -   pte = pfn_to_dma_pte(dmar_domain, iova >> VTD_PAGE_SHIFT,
>>>      &level);
>>>       > > -   if (pte)
>>>       > > +   pte = pfn_to_dma_pte(dmar_domain, pfn, &level);
>>>       > > +   if (pte) {
>>>       > >             phys = dma_pte_addr(pte);
>>>       > > +           if (level > 1)
>>>       > > +                   phys += (pfn &
>>>       > > +                           ((1UL <<
>>>      level_to_offset_bits(level)) - 1))
>>>       > > +                           << VTD_PAGE_SHIFT;
>>>       > > +           phys += iova & (VTD_PAGE_SIZE - 1);
>>>       >
>>>       > How about
>>>
>>>       >
>>>       > diff --git a/drivers/iommu/intel-iommu.c
>>>      b/drivers/iommu/intel-iommu.c
>>>       > index 9dc37672bf89..bd17c2510bb2 100644
>>>       > --- a/drivers/iommu/intel-iommu.c
>>>       > +++ b/drivers/iommu/intel-iommu.c
>>>       > @@ -5693,8 +5693,14 @@ static phys_addr_t
>>>      intel_iommu_iova_to_phys(struct
>>>       > iommu_domain *domain,
>>>       >         u64 phys = 0;
>>>       >
>>>       >         pte = pfn_to_dma_pte(dmar_domain, iova >> VTD_PAGE_SHIFT,
>>>      &level);
>>>       > -       if (pte)
>>>       > +       if (pte) {
>>>       > +               unsigned long offset_mask;
>>>       > +
>>>       > +               offset_mask = BIT_MASK(level_to_offset_bits(level) +
>>>       > +                                      VTD_PAGE_SHIFT) - 1;
>>>       >                 phys = dma_pte_addr(pte);
>>>       > +               phys += iova & (bitmask - 1);
>>>      Did you mean:
>>>
>>>      phys += iova & (offset_mask - 1);
>>>
>>>       > +       }
>>>
>>>      At that point why not define a helper:
>>>
>>>      static inline unsigned long offset_mask(int level)
>>>      {
>>>               return BIT_MASK(level_to_offset_bits(level) +
>>>      VTD_PAGE_SHIFT) - 1;
>>>      }
>>>
>>>      At which point the above would reduce to:
>>>
>>>      if (pte)
>>>               phys = dma_pte_addr(pte) + iova & offset_mask(level) - 1;
>>>
>>>
>>>
>>> Let me introduce the helper function and upstream the patch again. Thank
>>> you Lu and Moritz.
>>>
>>>
>>>      I might've fatfingered something here, but you get the idea :)
>>>
>>>      Cheers,
>>>      Moritz
>>>
>>>
>>> On Tue, Feb 18, 2020 at 8:42 PM Moritz Fischer <mdf@kernel.org
>>> <mailto:mdf@kernel.org>> wrote:
>>>
>>>      Hi Baolu, Yonghyun
>>>
>>>      On Wed, Feb 19, 2020 at 11:15:36AM +0800, Lu Baolu wrote:
>>>       > Hi Yonghyun,
>>>       >
>>>       > Thanks for the patch.
>>>       >
>>>       > On 2020/2/19 6:23, Yonghyun Hwang wrote:
>>>       > > intel_iommu_iova_to_phys() has a bug when it translates an IOVA
>>>      for a huge
>>>       > > page onto its corresponding physical address. This commit fixes
>>>      the bug by
>>>       > > accomodating the level of page entry for the IOVA and adds
>>>      IOVA's lower
>>>       > > address to the physical address. >
>>>       > > Signed-off-by: Yonghyun Hwang <yonghyun@google.com
>>>      <mailto:yonghyun@google.com>>
>>>       > > ---
>>>       > >   drivers/iommu/intel-iommu.c | 11 +++++++++--
>>>       > >   1 file changed, 9 insertions(+), 2 deletions(-)
>>>       > >
>>>       > > diff --git a/drivers/iommu/intel-iommu.c
>>>      b/drivers/iommu/intel-iommu.c
>>>       > > index 0c8d81f56a30..ed6e69adb578 100644
>>>       > > --- a/drivers/iommu/intel-iommu.c
>>>       > > +++ b/drivers/iommu/intel-iommu.c
>>>       > > @@ -5555,13 +5555,20 @@ static phys_addr_t
>>>      intel_iommu_iova_to_phys(struct iommu_domain *domain,
>>>       > >     struct dma_pte *pte;
>>>       > >     int level = 0;
>>>       > >     u64 phys = 0;
>>>       > > +   const unsigned long pfn = iova >> VTD_PAGE_SHIFT;
>>>       >
>>>       > Why do you need a "const unsigned long" here?
>>>       >
>>>       > >     if (dmar_domain->flags & DOMAIN_FLAG_LOSE_CHILDREN)
>>>       > >             return 0;
>>>       > > -   pte = pfn_to_dma_pte(dmar_domain, iova >> VTD_PAGE_SHIFT,
>>>      &level);
>>>       > > -   if (pte)
>>>       > > +   pte = pfn_to_dma_pte(dmar_domain, pfn, &level);
>>>       > > +   if (pte) {
>>>       > >             phys = dma_pte_addr(pte);
>>>       > > +           if (level > 1)
>>>       > > +                   phys += (pfn &
>>>       > > +                           ((1UL <<
>>>      level_to_offset_bits(level)) - 1))
>>>       > > +                           << VTD_PAGE_SHIFT;
>>>       > > +           phys += iova & (VTD_PAGE_SIZE - 1);
>>>       >
>>>       > How about
>>>
>>>       >
>>>       > diff --git a/drivers/iommu/intel-iommu.c
>>>      b/drivers/iommu/intel-iommu.c
>>>       > index 9dc37672bf89..bd17c2510bb2 100644
>>>       > --- a/drivers/iommu/intel-iommu.c
>>>       > +++ b/drivers/iommu/intel-iommu.c
>>>       > @@ -5693,8 +5693,14 @@ static phys_addr_t
>>>      intel_iommu_iova_to_phys(struct
>>>       > iommu_domain *domain,
>>>       >         u64 phys = 0;
>>>       >
>>>       >         pte = pfn_to_dma_pte(dmar_domain, iova >> VTD_PAGE_SHIFT,
>>>      &level);
>>>       > -       if (pte)
>>>       > +       if (pte) {
>>>       > +               unsigned long offset_mask;
>>>       > +
>>>       > +               offset_mask = BIT_MASK(level_to_offset_bits(level) +
>>>       > +                                      VTD_PAGE_SHIFT) - 1;
>>>       >                 phys = dma_pte_addr(pte);
>>>       > +               phys += iova & (bitmask - 1);
>>>      Did you mean:
>>>
>>>      phys += iova & (offset_mask - 1);
>>>
>>>       > +       }
>>>
>>>      At that point why not define a helper:
>>>
>>>      static inline unsigned long offset_mask(int level)
>>>      {
>>>               return BIT_MASK(level_to_offset_bits(level) +
>>>      VTD_PAGE_SHIFT) - 1;
>>>      }
>>>
>>>      At which point the above would reduce to:
>>>
>>>      if (pte)
>>>               phys = dma_pte_addr(pte) + iova & offset_mask(level) - 1;
>>>
>>>      I might've fatfingered something here, but you get the idea :)
>>>
>>>      Cheers,
>>>      Moritz
>>>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
