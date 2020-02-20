Return-Path: <SRS0=unsG=4I=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 097BFC5ACC4
	for <iommu@archiver.kernel.org>; Thu, 20 Feb 2020 00:12:56 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDD99207FD
	for <iommu@archiver.kernel.org>; Thu, 20 Feb 2020 00:12:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="rVwNqGwX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDD99207FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 8948A84EE4;
	Thu, 20 Feb 2020 00:12:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CJxVEPg7hoEd; Thu, 20 Feb 2020 00:12:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id B3DD784519;
	Thu, 20 Feb 2020 00:12:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9A1ABC1D80;
	Thu, 20 Feb 2020 00:12:54 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5CF81C013E
 for <iommu@lists.linux-foundation.org>; Thu, 20 Feb 2020 00:12:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 5072B82462
 for <iommu@lists.linux-foundation.org>; Thu, 20 Feb 2020 00:12:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BS1Jcf0I2ilf for <iommu@lists.linux-foundation.org>;
 Thu, 20 Feb 2020 00:12:52 +0000 (UTC)
X-Greylist: delayed 05:20:57 by SQLgrey-1.7.6
Received: from mail-ed1-f65.google.com (mail-ed1-f65.google.com
 [209.85.208.65])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 2B26181DC7
 for <iommu@lists.linux-foundation.org>; Thu, 20 Feb 2020 00:12:52 +0000 (UTC)
Received: by mail-ed1-f65.google.com with SMTP id e10so31445996edv.9
 for <iommu@lists.linux-foundation.org>; Wed, 19 Feb 2020 16:12:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=RQW21hx/77dUyN2w+JaneU9gWhJntW79iSMNQMEVt1E=;
 b=rVwNqGwX2eGxa/O+L5BpLcDDipYE3A5eqvPsPNLy81IlashmHgGAyheTVPfen8NkCl
 a9lBEug6MZ+1mWSPJrcVrFjZD/Z3SyFkunRZSq0rQpCQN1pNb9zONAhaL12xMhsTQrXd
 TvJpxXxa+0x7XhhTHVchMYmyT9uD+uGF1pH+M/wNLWTVri//A8odsD5Y+r89rQyYzYV+
 z7XTC1gPIdYYA3c4Q+lRHg8/346bzDeNDOIn0LyalNBDNfCa8VAHifqztYhGHp9X6uLr
 LaL6HukRIOX+0bYPGzEgFRsX0kpo8RS2Yw2bt6rW3cW7yL7TIcErOxODhcHG8UpPoO52
 FRXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=RQW21hx/77dUyN2w+JaneU9gWhJntW79iSMNQMEVt1E=;
 b=soBfeBGJN+s+Fgp9hadFLcVzO0fenY73YQZqTA2vSiK4y5nXJUNBvvBgFwbvgTdc0Q
 xmXo4MH9OKCFwng8uEFpYkJW/x0zKkZajxYHSViufsivAy12lPEcoRC10rTJoUplYS1k
 BS+LJnZnENpar+fKeefxjr61hvfk+P/peC/RDI4/oA3p1ACT239omCsoBgb1YjrrVIEn
 vJHpVN51N8VcjIoxjdJXLyfrX/2IUt5Pks/Amds+Lqw0qb/PZO1YKSWZh5z23DfOX3cb
 aMCTpi7GXJL71SL7hBGic8lZ0TW4HGtW54/ynPSrN0H1W5LdN1a0TXLMThKwfCw4JxY3
 k9GA==
X-Gm-Message-State: APjAAAUG2iGikIJTULtALt7WLFcJzSs2aKtt8pckQPcWm+0GB1bmvl/X
 7ZYX35Yk3/i0tD8jHwgUHHsOkwlQnKgzKhQsU7BJWw==
X-Google-Smtp-Source: APXvYqypjK7R8itabab2sD36ZHrqbHmUA8pt4wiWnKS3bR/75OdinZULUgCSlpC1lpvy5YosZVNxy0Z1DSM9Rniv8cI=
X-Received: by 2002:a17:906:4d89:: with SMTP id
 s9mr27575589eju.268.1582157569978; 
 Wed, 19 Feb 2020 16:12:49 -0800 (PST)
MIME-Version: 1.0
References: <20200218222324.231915-1-yonghyun@google.com>
 <8efc6ea2-d51e-624c-5cc2-4049bb224122@linux.intel.com>
 <20200219044235.GA1397@epycbox.lan>
 <CAEauFbw_FGWuQJMpr7PgyyCAefKChXoszKAz-ykBKgxFc-aa4g@mail.gmail.com>
 <9e3f1bb8-bbfd-174c-b7a7-617dea7c2c9a@linux.intel.com>
In-Reply-To: <9e3f1bb8-bbfd-174c-b7a7-617dea7c2c9a@linux.intel.com>
Date: Wed, 19 Feb 2020 16:12:39 -0800
Message-ID: <CAEauFbyqYeMoxTQfQZ8MLXg1i8TDohyuKeEWrC4Ui8SMdbjAKQ@mail.gmail.com>
Subject: Re: [PATCH] iommu/vt-d: Fix a bug in intel_iommu_iova_to_phys() for
 huge page
To: Lu Baolu <baolu.lu@linux.intel.com>
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
From: Yonghyun Hwang via iommu <iommu@lists.linux-foundation.org>
Reply-To: Yonghyun Hwang <yonghyun@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Hello Baolu,

Yes, pfn_to_dma_pte() doesn't put 0 for level. However, it's hard for
me to get that without comment, which is the reason why I put a dummy
"if" there. Anyway, what about the following code?

static inline unsigned long offset_mask(int level)
{
    return BIT_MASK(level_to_offset_bits(level) + VTD_PAGE_SHIFT) - 1;
}

static phys_addr_t intel_iommu_iova_to_phys(struct iommu_domain *domain,
                      dma_addr_t iova)
{
    struct dmar_domain *dmar_domain = to_dmar_domain(domain);
    struct dma_pte *pte;
    int level = 0;
    u64 phys = 0;

    if (dmar_domain->flags & DOMAIN_FLAG_LOSE_CHILDREN)
        return 0;

    pte = pfn_to_dma_pte(dmar_domain, iova >> VTD_PAGE_SHIFT, &level);
    if (pte)
        phys = dma_pte_addr(pte) + (iova & offset_mask(level));

    return phys;
}

On Wed, Feb 19, 2020 at 3:33 PM Lu Baolu <baolu.lu@linux.intel.com> wrote:
>
> Hi,
>
> On 2020/2/20 2:51, Yonghyun Hwang wrote:
> > Hello Lu and Moritz,
> >
> > I think it's better to keep "if (level > 1)" because
> > level_to_offset_bits() returns (unsigned int) -1 * LEVEL_STRIDE if level
> > becomes 0.
>
> @level will never be 0 in this case.
>
> Best regards,
> baolu
>
> >
> > static inline unsigned int level_to_offset_bits(int level)
> > {
> >    return (level - 1) * LEVEL_STRIDE;
> > }
> >
> > On Tue, Feb 18, 2020 at 8:42 PM Moritz Fischer <mdf@kernel.org
> > <mailto:mdf@kernel.org>> wrote:
> >
> >     Hi Baolu, Yonghyun
> >
> >     On Wed, Feb 19, 2020 at 11:15:36AM +0800, Lu Baolu wrote:
> >      > Hi Yonghyun,
> >      >
> >      > Thanks for the patch.
> >      >
> >      > On 2020/2/19 6:23, Yonghyun Hwang wrote:
> >      > > intel_iommu_iova_to_phys() has a bug when it translates an IOVA
> >     for a huge
> >      > > page onto its corresponding physical address. This commit fixes
> >     the bug by
> >      > > accomodating the level of page entry for the IOVA and adds
> >     IOVA's lower
> >      > > address to the physical address. >
> >      > > Signed-off-by: Yonghyun Hwang <yonghyun@google.com
> >     <mailto:yonghyun@google.com>>
> >      > > ---
> >      > >   drivers/iommu/intel-iommu.c | 11 +++++++++--
> >      > >   1 file changed, 9 insertions(+), 2 deletions(-)
> >      > >
> >      > > diff --git a/drivers/iommu/intel-iommu.c
> >     b/drivers/iommu/intel-iommu.c
> >      > > index 0c8d81f56a30..ed6e69adb578 100644
> >      > > --- a/drivers/iommu/intel-iommu.c
> >      > > +++ b/drivers/iommu/intel-iommu.c
> >      > > @@ -5555,13 +5555,20 @@ static phys_addr_t
> >     intel_iommu_iova_to_phys(struct iommu_domain *domain,
> >      > >     struct dma_pte *pte;
> >      > >     int level = 0;
> >      > >     u64 phys = 0;
> >      > > +   const unsigned long pfn = iova >> VTD_PAGE_SHIFT;
> >      >
> >      > Why do you need a "const unsigned long" here?
> >
> >
> >
> > It's because pfn_to_dma_pte() takes pfn for its second parameter as
> > "unsigned int" type and pfn is not changed in intel_iommu_iova_to_phys().
> >
> >      >
> >      > >     if (dmar_domain->flags & DOMAIN_FLAG_LOSE_CHILDREN)
> >      > >             return 0;
> >      > > -   pte = pfn_to_dma_pte(dmar_domain, iova >> VTD_PAGE_SHIFT,
> >     &level);
> >      > > -   if (pte)
> >      > > +   pte = pfn_to_dma_pte(dmar_domain, pfn, &level);
> >      > > +   if (pte) {
> >      > >             phys = dma_pte_addr(pte);
> >      > > +           if (level > 1)
> >      > > +                   phys += (pfn &
> >      > > +                           ((1UL <<
> >     level_to_offset_bits(level)) - 1))
> >      > > +                           << VTD_PAGE_SHIFT;
> >      > > +           phys += iova & (VTD_PAGE_SIZE - 1);
> >      >
> >      > How about
> >
> >      >
> >      > diff --git a/drivers/iommu/intel-iommu.c
> >     b/drivers/iommu/intel-iommu.c
> >      > index 9dc37672bf89..bd17c2510bb2 100644
> >      > --- a/drivers/iommu/intel-iommu.c
> >      > +++ b/drivers/iommu/intel-iommu.c
> >      > @@ -5693,8 +5693,14 @@ static phys_addr_t
> >     intel_iommu_iova_to_phys(struct
> >      > iommu_domain *domain,
> >      >         u64 phys = 0;
> >      >
> >      >         pte = pfn_to_dma_pte(dmar_domain, iova >> VTD_PAGE_SHIFT,
> >     &level);
> >      > -       if (pte)
> >      > +       if (pte) {
> >      > +               unsigned long offset_mask;
> >      > +
> >      > +               offset_mask = BIT_MASK(level_to_offset_bits(level) +
> >      > +                                      VTD_PAGE_SHIFT) - 1;
> >      >                 phys = dma_pte_addr(pte);
> >      > +               phys += iova & (bitmask - 1);
> >     Did you mean:
> >
> >     phys += iova & (offset_mask - 1);
> >
> >      > +       }
> >
> >     At that point why not define a helper:
> >
> >     static inline unsigned long offset_mask(int level)
> >     {
> >              return BIT_MASK(level_to_offset_bits(level) +
> >     VTD_PAGE_SHIFT) - 1;
> >     }
> >
> >     At which point the above would reduce to:
> >
> >     if (pte)
> >              phys = dma_pte_addr(pte) + iova & offset_mask(level) - 1;
> >
> >
> >
> > Let me introduce the helper function and upstream the patch again. Thank
> > you Lu and Moritz.
> >
> >
> >     I might've fatfingered something here, but you get the idea :)
> >
> >     Cheers,
> >     Moritz
> >
> >
> > On Tue, Feb 18, 2020 at 8:42 PM Moritz Fischer <mdf@kernel.org
> > <mailto:mdf@kernel.org>> wrote:
> >
> >     Hi Baolu, Yonghyun
> >
> >     On Wed, Feb 19, 2020 at 11:15:36AM +0800, Lu Baolu wrote:
> >      > Hi Yonghyun,
> >      >
> >      > Thanks for the patch.
> >      >
> >      > On 2020/2/19 6:23, Yonghyun Hwang wrote:
> >      > > intel_iommu_iova_to_phys() has a bug when it translates an IOVA
> >     for a huge
> >      > > page onto its corresponding physical address. This commit fixes
> >     the bug by
> >      > > accomodating the level of page entry for the IOVA and adds
> >     IOVA's lower
> >      > > address to the physical address. >
> >      > > Signed-off-by: Yonghyun Hwang <yonghyun@google.com
> >     <mailto:yonghyun@google.com>>
> >      > > ---
> >      > >   drivers/iommu/intel-iommu.c | 11 +++++++++--
> >      > >   1 file changed, 9 insertions(+), 2 deletions(-)
> >      > >
> >      > > diff --git a/drivers/iommu/intel-iommu.c
> >     b/drivers/iommu/intel-iommu.c
> >      > > index 0c8d81f56a30..ed6e69adb578 100644
> >      > > --- a/drivers/iommu/intel-iommu.c
> >      > > +++ b/drivers/iommu/intel-iommu.c
> >      > > @@ -5555,13 +5555,20 @@ static phys_addr_t
> >     intel_iommu_iova_to_phys(struct iommu_domain *domain,
> >      > >     struct dma_pte *pte;
> >      > >     int level = 0;
> >      > >     u64 phys = 0;
> >      > > +   const unsigned long pfn = iova >> VTD_PAGE_SHIFT;
> >      >
> >      > Why do you need a "const unsigned long" here?
> >      >
> >      > >     if (dmar_domain->flags & DOMAIN_FLAG_LOSE_CHILDREN)
> >      > >             return 0;
> >      > > -   pte = pfn_to_dma_pte(dmar_domain, iova >> VTD_PAGE_SHIFT,
> >     &level);
> >      > > -   if (pte)
> >      > > +   pte = pfn_to_dma_pte(dmar_domain, pfn, &level);
> >      > > +   if (pte) {
> >      > >             phys = dma_pte_addr(pte);
> >      > > +           if (level > 1)
> >      > > +                   phys += (pfn &
> >      > > +                           ((1UL <<
> >     level_to_offset_bits(level)) - 1))
> >      > > +                           << VTD_PAGE_SHIFT;
> >      > > +           phys += iova & (VTD_PAGE_SIZE - 1);
> >      >
> >      > How about
> >
> >      >
> >      > diff --git a/drivers/iommu/intel-iommu.c
> >     b/drivers/iommu/intel-iommu.c
> >      > index 9dc37672bf89..bd17c2510bb2 100644
> >      > --- a/drivers/iommu/intel-iommu.c
> >      > +++ b/drivers/iommu/intel-iommu.c
> >      > @@ -5693,8 +5693,14 @@ static phys_addr_t
> >     intel_iommu_iova_to_phys(struct
> >      > iommu_domain *domain,
> >      >         u64 phys = 0;
> >      >
> >      >         pte = pfn_to_dma_pte(dmar_domain, iova >> VTD_PAGE_SHIFT,
> >     &level);
> >      > -       if (pte)
> >      > +       if (pte) {
> >      > +               unsigned long offset_mask;
> >      > +
> >      > +               offset_mask = BIT_MASK(level_to_offset_bits(level) +
> >      > +                                      VTD_PAGE_SHIFT) - 1;
> >      >                 phys = dma_pte_addr(pte);
> >      > +               phys += iova & (bitmask - 1);
> >     Did you mean:
> >
> >     phys += iova & (offset_mask - 1);
> >
> >      > +       }
> >
> >     At that point why not define a helper:
> >
> >     static inline unsigned long offset_mask(int level)
> >     {
> >              return BIT_MASK(level_to_offset_bits(level) +
> >     VTD_PAGE_SHIFT) - 1;
> >     }
> >
> >     At which point the above would reduce to:
> >
> >     if (pte)
> >              phys = dma_pte_addr(pte) + iova & offset_mask(level) - 1;
> >
> >     I might've fatfingered something here, but you get the idea :)
> >
> >     Cheers,
> >     Moritz
> >
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
