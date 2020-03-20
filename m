Return-Path: <SRS0=tLNU=5F=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B8C2C4332B
	for <iommu@archiver.kernel.org>; Fri, 20 Mar 2020 06:55:31 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDAA820724
	for <iommu@archiver.kernel.org>; Fri, 20 Mar 2020 06:55:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tcd-ie.20150623.gappssmtp.com header.i=@tcd-ie.20150623.gappssmtp.com header.b="ALp9alTQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDAA820724
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tcd.ie
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 963B1868F9;
	Fri, 20 Mar 2020 06:55:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0cgkzZt7A1N0; Fri, 20 Mar 2020 06:55:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id D09638682C;
	Fri, 20 Mar 2020 06:55:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B89C2C089E;
	Fri, 20 Mar 2020 06:55:29 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 85F7BC07FF
 for <iommu@lists.linux-foundation.org>; Fri, 20 Mar 2020 06:55:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 73A9488970
 for <iommu@lists.linux-foundation.org>; Fri, 20 Mar 2020 06:55:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CsU0j+p3rFbq for <iommu@lists.linux-foundation.org>;
 Fri, 20 Mar 2020 06:55:26 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-il1-f195.google.com (mail-il1-f195.google.com
 [209.85.166.195])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 852EE8892E
 for <iommu@lists.linux-foundation.org>; Fri, 20 Mar 2020 06:55:26 +0000 (UTC)
Received: by mail-il1-f195.google.com with SMTP id h3so4653531ils.3
 for <iommu@lists.linux-foundation.org>; Thu, 19 Mar 2020 23:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tcd-ie.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=1/VIn1wtF4hsQJkFxlnmnWv82JMKOrPFn/SqXh1kTXo=;
 b=ALp9alTQuLJLrtYNnyRjvA8PMiz1K4ZRf5nzLyAi+v2/I3lM5M5naHCyPFAdUU7NU9
 wx8SODJR6FU9l1lCyIMN3qqLsbRNFpv0ypNDVGw6BO/60a5FCcILJuKIcbnqlN/29fnY
 A4sy1/pR6UT8YJDvQK2RN9cauHsQ63ohAuCF3DyO7KtZ0AxycSd7Un2OryglDuoIIt3J
 YLdR7e5RgpvbG4fcchtVZYh60gsXK5GYIrsKc232S+xWkPGrmZZ90ZhY2oUjJX7P8a3U
 Qu4cOmU0u7PmBgUf3ublP3r8gsr/zoNScg4QxMSmvJ/EEGXtQ3shCFRNsg4sf6wGEuEt
 3H4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=1/VIn1wtF4hsQJkFxlnmnWv82JMKOrPFn/SqXh1kTXo=;
 b=Py/+6zD2tNC7CAseId/z4rxwERJca08g/Y2QDyiWWLsPhfIIXkDeIppAt/vbBk118X
 AL1fYICB83vz1LLk/j7uZ+TjKKXTHv0WfFG2IrIXPXp7ZXDRrwMv2VR4ipdz8kpuZqI1
 WUW8cW1MZEk9xgtH7cGlsvhUmTln9J2WTotf3ngmXId0wyrCSAtuCFNyS5OR0nHKU/aC
 jqUAIhn7I/t7lxoA7sVHBVQ22njuVQloQqr6d7gz8pfuA/RYqhihrMdQwvzeOtYJw1NF
 R7+MxPVN5bYuDLwxrMmuhbVvON1zevpd9BSbAJdgA0L4s1sPJBdRr1cJpLMQ9UG0Iikm
 bUMw==
X-Gm-Message-State: ANhLgQ1/8NYo1fZ3aWmZmbBujRWwB45ILzMQkW9bOktXFdtYUwCbpsgm
 lPV2nVsE5QREd6p4DY2JT5ewuhBAGvLh6PnixHf4TsZsnZ4=
X-Google-Smtp-Source: ADFU+vv0RVPDe7OSqYC09UstbxEpj6UJl/ooVVvm+TTFONFef168+lVao+hBMRX+yBG3YxegODoM+L1qUGjcesJyDlI=
X-Received: by 2002:a5d:8405:: with SMTP id i5mr5964251ion.197.1584685862390; 
 Thu, 19 Mar 2020 23:31:02 -0700 (PDT)
MIME-Version: 1.0
References: <20191221150402.13868-1-murphyt7@tcd.ie>
 <20191221150402.13868-4-murphyt7@tcd.ie>
In-Reply-To: <20191221150402.13868-4-murphyt7@tcd.ie>
From: Tom Murphy <murphyt7@tcd.ie>
Date: Thu, 19 Mar 2020 23:30:51 -0700
Message-ID: <CALQxJuuue2MCF+xAAAcWCW=301HHZ9yWBmYV-K-ubCxO4s5eqQ@mail.gmail.com>
Subject: Re: [PATCH 3/8] iommu/vt-d: Remove IOVA handling code from
 non-dma_ops path
To: iommu@lists.linux-foundation.org
Cc: Heiko Stuebner <heiko@sntech.de>, kvm@vger.kernel.org,
 David Airlie <airlied@linux.ie>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 dri-devel@lists.freedesktop.org, Bjorn Andersson <bjorn.andersson@linaro.org>,
 linux-tegra@vger.kernel.org, Julien Grall <julien.grall@arm.com>,
 Thierry Reding <thierry.reding@gmail.com>, Will Deacon <will@kernel.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 linux-samsung-soc@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
 Krzysztof Kozlowski <krzk@kernel.org>, Jonathan Hunter <jonathanh@nvidia.com>,
 linux-rockchip@lists.infradead.org, Andy Gross <agross@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, intel-gfx@lists.freedesktop.org,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 linux-mediatek@lists.infradead.org, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 virtualization@lists.linux-foundation.org,
 Gerald Schaefer <gerald.schaefer@de.ibm.com>,
 David Woodhouse <dwmw2@infradead.org>, Cornelia Huck <cohuck@redhat.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Kukjin Kim <kgene@kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Could we merge patch 1-3 from this series? it just cleans up weird
code and merging these patches will cover some of the work needed to
move the intel iommu driver to the dma-iommu api in the future.

On Sat, 21 Dec 2019 at 07:04, Tom Murphy <murphyt7@tcd.ie> wrote:
>
> Remove all IOVA handling code from the non-dma_ops path in the intel
> iommu driver.
>
> There's no need for the non-dma_ops path to keep track of IOVAs. The
> whole point of the non-dma_ops path is that it allows the IOVAs to be
> handled separately. The IOVA handling code removed in this patch is
> pointless.
>
> Signed-off-by: Tom Murphy <murphyt7@tcd.ie>
> ---
>  drivers/iommu/intel-iommu.c | 89 ++++++++++++++-----------------------
>  1 file changed, 33 insertions(+), 56 deletions(-)
>
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index 64b1a9793daa..8d72ea0fb843 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -1908,7 +1908,8 @@ static void domain_exit(struct dmar_domain *domain)
>         domain_remove_dev_info(domain);
>
>         /* destroy iovas */
> -       put_iova_domain(&domain->iovad);
> +       if (domain->domain.type == IOMMU_DOMAIN_DMA)
> +               put_iova_domain(&domain->iovad);
>
>         if (domain->pgd) {
>                 struct page *freelist;
> @@ -2671,19 +2672,9 @@ static struct dmar_domain *set_domain_for_dev(struct device *dev,
>  }
>
>  static int iommu_domain_identity_map(struct dmar_domain *domain,
> -                                    unsigned long long start,
> -                                    unsigned long long end)
> +                                    unsigned long first_vpfn,
> +                                    unsigned long last_vpfn)
>  {
> -       unsigned long first_vpfn = start >> VTD_PAGE_SHIFT;
> -       unsigned long last_vpfn = end >> VTD_PAGE_SHIFT;
> -
> -       if (!reserve_iova(&domain->iovad, dma_to_mm_pfn(first_vpfn),
> -                         dma_to_mm_pfn(last_vpfn))) {
> -               pr_err("Reserving iova failed\n");
> -               return -ENOMEM;
> -       }
> -
> -       pr_debug("Mapping reserved region %llx-%llx\n", start, end);
>         /*
>          * RMRR range might have overlap with physical memory range,
>          * clear it first
> @@ -2760,7 +2751,8 @@ static int __init si_domain_init(int hw)
>
>                 for_each_mem_pfn_range(i, nid, &start_pfn, &end_pfn, NULL) {
>                         ret = iommu_domain_identity_map(si_domain,
> -                                       PFN_PHYS(start_pfn), PFN_PHYS(end_pfn));
> +                                       mm_to_dma_pfn(start_pfn),
> +                                       mm_to_dma_pfn(end_pfn));
>                         if (ret)
>                                 return ret;
>                 }
> @@ -4593,58 +4585,37 @@ static int intel_iommu_memory_notifier(struct notifier_block *nb,
>                                        unsigned long val, void *v)
>  {
>         struct memory_notify *mhp = v;
> -       unsigned long long start, end;
> -       unsigned long start_vpfn, last_vpfn;
> +       unsigned long start_vpfn = mm_to_dma_pfn(mhp->start_pfn);
> +       unsigned long last_vpfn = mm_to_dma_pfn(mhp->start_pfn +
> +                       mhp->nr_pages - 1);
>
>         switch (val) {
>         case MEM_GOING_ONLINE:
> -               start = mhp->start_pfn << PAGE_SHIFT;
> -               end = ((mhp->start_pfn + mhp->nr_pages) << PAGE_SHIFT) - 1;
> -               if (iommu_domain_identity_map(si_domain, start, end)) {
> -                       pr_warn("Failed to build identity map for [%llx-%llx]\n",
> -                               start, end);
> +               if (iommu_domain_identity_map(si_domain, start_vpfn,
> +                                       last_vpfn)) {
> +                       pr_warn("Failed to build identity map for [%lx-%lx]\n",
> +                               start_vpfn, last_vpfn);
>                         return NOTIFY_BAD;
>                 }
>                 break;
>
>         case MEM_OFFLINE:
>         case MEM_CANCEL_ONLINE:
> -               start_vpfn = mm_to_dma_pfn(mhp->start_pfn);
> -               last_vpfn = mm_to_dma_pfn(mhp->start_pfn + mhp->nr_pages - 1);
> -               while (start_vpfn <= last_vpfn) {
> -                       struct iova *iova;
> +               {
>                         struct dmar_drhd_unit *drhd;
>                         struct intel_iommu *iommu;
>                         struct page *freelist;
>
> -                       iova = find_iova(&si_domain->iovad, start_vpfn);
> -                       if (iova == NULL) {
> -                               pr_debug("Failed get IOVA for PFN %lx\n",
> -                                        start_vpfn);
> -                               break;
> -                       }
> -
> -                       iova = split_and_remove_iova(&si_domain->iovad, iova,
> -                                                    start_vpfn, last_vpfn);
> -                       if (iova == NULL) {
> -                               pr_warn("Failed to split IOVA PFN [%lx-%lx]\n",
> -                                       start_vpfn, last_vpfn);
> -                               return NOTIFY_BAD;
> -                       }
> -
> -                       freelist = domain_unmap(si_domain, iova->pfn_lo,
> -                                              iova->pfn_hi);
> +                       freelist = domain_unmap(si_domain, start_vpfn,
> +                                       last_vpfn);
>
>                         rcu_read_lock();
>                         for_each_active_iommu(iommu, drhd)
>                                 iommu_flush_iotlb_psi(iommu, si_domain,
> -                                       iova->pfn_lo, iova_size(iova),
> +                                       start_vpfn, mhp->nr_pages,
>                                         !freelist, 0);
>                         rcu_read_unlock();
>                         dma_free_pagelist(freelist);
> -
> -                       start_vpfn = iova->pfn_hi + 1;
> -                       free_iova_mem(iova);
>                 }
>                 break;
>         }
> @@ -4672,8 +4643,9 @@ static void free_all_cpu_cached_iovas(unsigned int cpu)
>                 for (did = 0; did < cap_ndoms(iommu->cap); did++) {
>                         domain = get_iommu_domain(iommu, (u16)did);
>
> -                       if (!domain)
> +                       if (!domain || domain->domain.type != IOMMU_DOMAIN_DMA)
>                                 continue;
> +
>                         free_cpu_cached_iovas(cpu, &domain->iovad);
>                 }
>         }
> @@ -5095,9 +5067,6 @@ static int md_domain_init(struct dmar_domain *domain, int guest_width)
>  {
>         int adjust_width;
>
> -       init_iova_domain(&domain->iovad, VTD_PAGE_SIZE, IOVA_START_PFN);
> -       domain_reserve_special_ranges(domain);
> -
>         /* calculate AGAW */
>         domain->gaw = guest_width;
>         adjust_width = guestwidth_to_adjustwidth(guest_width);
> @@ -5116,6 +5085,18 @@ static int md_domain_init(struct dmar_domain *domain, int guest_width)
>         return 0;
>  }
>
> +static void intel_init_iova_domain(struct dmar_domain *dmar_domain)
> +{
> +       init_iova_domain(&dmar_domain->iovad, VTD_PAGE_SIZE, IOVA_START_PFN);
> +       copy_reserved_iova(&reserved_iova_list, &dmar_domain->iovad);
> +
> +       if (init_iova_flush_queue(&dmar_domain->iovad, iommu_flush_iova,
> +                               iova_entry_free)) {
> +               pr_warn("iova flush queue initialization failed\n");
> +               intel_iommu_strict = 1;
> +       }
> +}
> +
>  static struct iommu_domain *intel_iommu_domain_alloc(unsigned type)
>  {
>         struct dmar_domain *dmar_domain;
> @@ -5136,12 +5117,8 @@ static struct iommu_domain *intel_iommu_domain_alloc(unsigned type)
>                         return NULL;
>                 }
>
> -               if (type == IOMMU_DOMAIN_DMA &&
> -                   init_iova_flush_queue(&dmar_domain->iovad,
> -                                         iommu_flush_iova, iova_entry_free)) {
> -                       pr_warn("iova flush queue initialization failed\n");
> -                       intel_iommu_strict = 1;
> -               }
> +               if (type == IOMMU_DOMAIN_DMA)
> +                       intel_init_iova_domain(dmar_domain);
>
>                 domain_update_iommu_cap(dmar_domain);
>
> --
> 2.20.1
>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
