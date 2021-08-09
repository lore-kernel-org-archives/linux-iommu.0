Return-Path: <SRS0=YfIy=NA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E484CC4338F
	for <iommu@archiver.kernel.org>; Mon,  9 Aug 2021 20:16:30 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78EE06101E
	for <iommu@archiver.kernel.org>; Mon,  9 Aug 2021 20:16:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 78EE06101E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 42996401F6;
	Mon,  9 Aug 2021 20:16:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uEQu7oFmLoOe; Mon,  9 Aug 2021 20:16:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 1879140273;
	Mon,  9 Aug 2021 20:16:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CE132C0010;
	Mon,  9 Aug 2021 20:16:25 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 99614C000E
 for <iommu@lists.linux-foundation.org>; Mon,  9 Aug 2021 20:16:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7379E4020E
 for <iommu@lists.linux-foundation.org>; Mon,  9 Aug 2021 20:16:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=google.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0WwUeYM2cB7s for <iommu@lists.linux-foundation.org>;
 Mon,  9 Aug 2021 20:16:23 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 43811400E5
 for <iommu@lists.linux-foundation.org>; Mon,  9 Aug 2021 20:16:23 +0000 (UTC)
Received: by mail-pl1-x62d.google.com with SMTP id k2so17778084plk.13
 for <iommu@lists.linux-foundation.org>; Mon, 09 Aug 2021 13:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=44GhGqOetVs4KhXXElqDGKK3CH2oBjGziCm5x/a7ZJs=;
 b=ppVc9A9KMhJFgV6NVDkUHp9yBZ4jvRiPZUcI20A2cQjGlIn028xMoBHpww2tDAiKFl
 9iPhbobR9SHL2adYikPHqF5G4SlWpowSr2j8S6b8do8TbaUnU36v1GfI26941juwBtq0
 lg5uO8fP8v07UWSN2Md7iUeWq8bIHopmUzjvgBBzTK3O6/A+996ZEREB2/UhRgsIQp4H
 MeNfIz09c15Sltk3GsM1Mi4vP42DP3K751s00uC2X0eFx85qHl4u6HDdfFK1q/oVXcJv
 /ei/Pth5mKrn9l+/cEg8baudOVk+TGkbagMYGHp38fVDHIDAu3ZCTHC9yyVDLEU8ttwq
 mKdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=44GhGqOetVs4KhXXElqDGKK3CH2oBjGziCm5x/a7ZJs=;
 b=qKjnJAHRosU3/ZJRPBFRt4MyrHxuA20s/9cPy2KBuHLgYM+HpE+RymMGtyZ6qVZeUV
 Z5/iyr0iduZb4yh3Tt0rjkmvpYDp/Su8byMCAUIdrsaXhHpmR3CFmfHSVKtSFnVAK1H8
 HNgRRjzI5QwvxkOuxe1BtCfUZ5I1qQ3bzKvpkw7b2Ime17YDQf1zkdy9SMg1nK0cnBu8
 1fIvLQVlUbVG9z9TMNHymBx0ezTA7DLKFVdwTf7N8N1wt9ee1nyrtfHkaZzxCp39/EXw
 W2+bLXxpknmWC2r1MgCeFVmHk3LTaJMiUT0oZNnmUNUZsesjCgkGM4hHyFoJ/1qubxAo
 7YqQ==
X-Gm-Message-State: AOAM5324zG8HSZsywIo2Z5KxruxUx2SidBE6yb5KjG1U10B6FxmlAyo+
 9xL7EFZ8X8Lm1YgAA0S4bDyBE6x7R7PvBqw0F2KvfQ==
X-Google-Smtp-Source: ABdhPJxHyBboh3cabRdq1cEgdkUUmLFgelCu6EWKllya4Av27+xhycvWAEKPW0Mj0+bvONvbUJBoXz9ti/IsYYB08zs=
X-Received: by 2002:a65:50cb:: with SMTP id s11mr424292pgp.236.1628540182405; 
 Mon, 09 Aug 2021 13:16:22 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1628094600.git.robin.murphy@arm.com>
 <3b5284ee394f267ba966839173f874fc9a996bb2.1628094601.git.robin.murphy@arm.com>
 <CACK8Z6HSM678q=BZ3FY7spN2S3ZkhdJ3ecnMCbKWrqB5dNWaMA@mail.gmail.com>
 <00baf83a-5eb3-4d72-309c-5adfd3242c07@arm.com>
In-Reply-To: <00baf83a-5eb3-4d72-309c-5adfd3242c07@arm.com>
Date: Mon, 9 Aug 2021 13:15:46 -0700
Message-ID: <CACK8Z6Gb1O8Ok1GEy80nQJ4ZQeFJ3TOgFHRYfH3Yb=8CNT=ysw@mail.gmail.com>
Subject: Re: [PATCH v3 24/25] iommu/dma: Factor out flush queue init
To: Robin Murphy <robin.murphy@arm.com>
Cc: linux-kernel@vger.kernel.org, dianders@chromium.org,
 iommu@lists.linux-foundation.org, will@kernel.org,
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
From: Rajat Jain via iommu <iommu@lists.linux-foundation.org>
Reply-To: Rajat Jain <rajatja@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Mon, Aug 9, 2021 at 12:59 PM Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 2021-08-09 20:05, Rajat Jain wrote:
> > On Wed, Aug 4, 2021 at 10:16 AM Robin Murphy <robin.murphy@arm.com> wrote:
> >>
> >> Factor out flush queue setup from the initial domain init so that we
> >> can potentially trigger it from sysfs later on in a domain's lifetime.
> >>
> >> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> >> Reviewed-by: John Garry <john.garry@huawei.com>
> >> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> >> ---
> >>   drivers/iommu/dma-iommu.c | 30 ++++++++++++++++++++----------
> >>   include/linux/dma-iommu.h |  9 ++++++---
> >>   2 files changed, 26 insertions(+), 13 deletions(-)
> >>
> >> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> >> index 2e19505dddf9..f51b8dc99ac6 100644
> >> --- a/drivers/iommu/dma-iommu.c
> >> +++ b/drivers/iommu/dma-iommu.c
> >> @@ -310,6 +310,25 @@ static bool dev_is_untrusted(struct device *dev)
> >>          return dev_is_pci(dev) && to_pci_dev(dev)->untrusted;
> >>   }
> >>
> >> +int iommu_dma_init_fq(struct iommu_domain *domain)
> >> +{
> >> +       struct iommu_dma_cookie *cookie = domain->iova_cookie;
> >> +
> >> +       if (domain->type != IOMMU_DOMAIN_DMA_FQ)
> >> +               return -EINVAL;
> >> +       if (cookie->fq_domain)
> >> +               return 0;
> >> +
> >> +       if (init_iova_flush_queue(&cookie->iovad, iommu_dma_flush_iotlb_all,
> >> +                                 iommu_dma_entry_dtor)) {
> >> +               pr_warn("iova flush queue initialization failed\n");
> >> +               domain->type = IOMMU_DOMAIN_DMA;
> >> +               return -ENODEV;
> >> +       }
> >> +       cookie->fq_domain = domain;
> >> +       return 0;
> >> +}
> >> +
> >>   /**
> >>    * iommu_dma_init_domain - Initialise a DMA mapping domain
> >>    * @domain: IOMMU domain previously prepared by iommu_get_dma_cookie()
> >> @@ -362,16 +381,7 @@ static int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base,
> >>          }
> >>
> >>          init_iova_domain(iovad, 1UL << order, base_pfn);
> >> -
> >> -       if (domain->type == IOMMU_DOMAIN_DMA_FQ && !cookie->fq_domain) {
> >> -               if (init_iova_flush_queue(iovad, iommu_dma_flush_iotlb_all,
> >> -                                         iommu_dma_entry_dtor)) {
> >> -                       pr_warn("iova flush queue initialization failed\n");
> >> -                       domain->type = IOMMU_DOMAIN_DMA;
> >> -               } else {
> >> -                       cookie->fq_domain = domain;
> >> -               }
> >> -       }
> >> +       iommu_dma_init_fq(domain);
> >>
> >>          return iova_reserve_iommu_regions(dev, domain);
> >>   }
> >> diff --git a/include/linux/dma-iommu.h b/include/linux/dma-iommu.h
> >> index 758ca4694257..81ab647f1618 100644
> >> --- a/include/linux/dma-iommu.h
> >> +++ b/include/linux/dma-iommu.h
> >> @@ -20,6 +20,7 @@ void iommu_put_dma_cookie(struct iommu_domain *domain);
> >>
> >>   /* Setup call for arch DMA mapping code */
> >>   void iommu_setup_dma_ops(struct device *dev, u64 dma_base, u64 dma_limit);
> >> +int iommu_dma_init_fq(struct iommu_domain *domain);
> >>
> >>   /* The DMA API isn't _quite_ the whole story, though... */
> >>   /*
> >> @@ -37,9 +38,6 @@ void iommu_dma_compose_msi_msg(struct msi_desc *desc,
> >>
> >>   void iommu_dma_get_resv_regions(struct device *dev, struct list_head *list);
> >>
> >> -void iommu_dma_free_cpu_cached_iovas(unsigned int cpu,
> >> -               struct iommu_domain *domain);
> >> -
> >
> > This looks like an unrelated code cleanup. Should this be a separate patch?
>
> Ha, busted! Much of this was done in the "stream of consciousness" style
> where I made a big sprawling mess then split it up into patches and
> branches afterwards. TBH it was already feeling pretty tenuous having a
> separate patch just to move this one function, and it only gets more so
> with the simplification Will pointed out earlier. I think I'll squash
> iommu_dma_init_fq() into the next patch then do a thorough header sweep,
> since I've now spotted some things in iova.h which could probably go as
> well.

Thank you. I chanced upon this only because I've backported your
patchset (and some other changes that it depends on) to 5.10 which is
the kernel we currently use for our Intel platforms, and this cleanup
hunk was creating a problem (since 5.10 still uses the symbol you
removed). I'll be giving your v3 patchset a spin in my setup and
update you in case I see any issue.

Thanks,

Rajat


>
> Thanks for the poke!
>
> Robin.
>
> >
> > Thanks,
> >
> > Rajat
> >
> >
> >>   extern bool iommu_dma_forcedac;
> >>
> >>   #else /* CONFIG_IOMMU_DMA */
> >> @@ -54,6 +52,11 @@ static inline void iommu_setup_dma_ops(struct device *dev, u64 dma_base,
> >>   {
> >>   }
> >>
> >> +static inline int iommu_dma_init_fq(struct iommu_domain *domain)
> >> +{
> >> +       return -EINVAL;
> >> +}
> >> +
> >>   static inline int iommu_get_dma_cookie(struct iommu_domain *domain)
> >>   {
> >>          return -ENODEV;
> >> --
> >> 2.25.1
> >>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
