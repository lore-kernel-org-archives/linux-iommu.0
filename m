Return-Path: <SRS0=d8dU=JF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE45EC433ED
	for <iommu@archiver.kernel.org>; Thu,  8 Apr 2021 07:37:58 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 741BC6112F
	for <iommu@archiver.kernel.org>; Thu,  8 Apr 2021 07:37:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 741BC6112F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 41B0660ECF;
	Thu,  8 Apr 2021 07:37:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id n9EMcIzLDLyX; Thu,  8 Apr 2021 07:37:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id EAF0160E82;
	Thu,  8 Apr 2021 07:37:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C6C91C000B;
	Thu,  8 Apr 2021 07:37:56 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E49E4C000A
 for <iommu@lists.linux-foundation.org>; Thu,  8 Apr 2021 07:37:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D2AB260EBC
 for <iommu@lists.linux-foundation.org>; Thu,  8 Apr 2021 07:37:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BlFHwfIy1GIO for <iommu@lists.linux-foundation.org>;
 Thu,  8 Apr 2021 07:37:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 160EA60E82
 for <iommu@lists.linux-foundation.org>; Thu,  8 Apr 2021 07:37:53 +0000 (UTC)
Received: from dggeml405-hub.china.huawei.com (unknown [172.30.72.55])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4FGCgt3YRXzWQCj;
 Thu,  8 Apr 2021 15:34:18 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggeml405-hub.china.huawei.com (10.3.17.49) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Thu, 8 Apr 2021 15:37:48 +0800
Received: from dggpeml500016.china.huawei.com (7.185.36.70) by
 dggpemm500007.china.huawei.com (7.185.36.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 8 Apr 2021 15:37:48 +0800
Received: from dggpeml500016.china.huawei.com ([7.185.36.70]) by
 dggpeml500016.china.huawei.com ([7.185.36.70]) with mapi id 15.01.2106.013;
 Thu, 8 Apr 2021 15:37:48 +0800
From: "Longpeng (Mike, Cloud Infrastructure Service Product Dept.)"
 <longpeng2@huawei.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, "iommu@lists.linux-foundation.org"
 <iommu@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] iommu/vt-d: Force to flush iotlb before creating superpage
Thread-Topic: [PATCH] iommu/vt-d: Force to flush iotlb before creating
 superpage
Thread-Index: AQHXJsdJgAXY3vlVHUqi4t5f0DX/hKqgIfAAgAh+GPCAAOyOgIAAkUvA
Date: Thu, 8 Apr 2021 07:37:48 +0000
Message-ID: <54ec81edcf074533867c18f0d86b837b@huawei.com>
References: <20210401071834.1639-1-longpeng2@huawei.com>
 <9c368419-6e45-6b27-0f34-26b581589fa7@linux.intel.com>
 <611cb5849c9a497b8289004dddb71150@huawei.com>
 <808394ea-9ff0-7a6d-72e7-f037e5cd3110@linux.intel.com>
In-Reply-To: <808394ea-9ff0-7a6d-72e7-f037e5cd3110@linux.intel.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.151.207]
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Cc: Kevin Tian <kevin.tian@intel.com>, David Woodhouse <dwmw2@infradead.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 "Gonglei \(Arei\)" <arei.gonglei@huawei.com>
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

Hi Baolu,

> -----Original Message-----
> From: Lu Baolu [mailto:baolu.lu@linux.intel.com]
> Sent: Thursday, April 8, 2021 12:32 PM
> To: Longpeng (Mike, Cloud Infrastructure Service Product Dept.)
> <longpeng2@huawei.com>; iommu@lists.linux-foundation.org;
> linux-kernel@vger.kernel.org
> Cc: baolu.lu@linux.intel.com; David Woodhouse <dwmw2@infradead.org>; Nadav
> Amit <nadav.amit@gmail.com>; Alex Williamson <alex.williamson@redhat.com>;
> Kevin Tian <kevin.tian@intel.com>; Gonglei (Arei) <arei.gonglei@huawei.com>;
> stable@vger.kernel.org
> Subject: Re: [PATCH] iommu/vt-d: Force to flush iotlb before creating superpage
> 
> Hi Longpeng,
> 
> On 4/7/21 2:35 PM, Longpeng (Mike, Cloud Infrastructure Service Product
> Dept.) wrote:
> > Hi Baolu,
> >
> >> -----Original Message-----
> >> From: Lu Baolu [mailto:baolu.lu@linux.intel.com]
> >> Sent: Friday, April 2, 2021 12:44 PM
> >> To: Longpeng (Mike, Cloud Infrastructure Service Product Dept.)
> >> <longpeng2@huawei.com>; iommu@lists.linux-foundation.org;
> >> linux-kernel@vger.kernel.org
> >> Cc: baolu.lu@linux.intel.com; David Woodhouse <dwmw2@infradead.org>;
> >> Nadav Amit <nadav.amit@gmail.com>; Alex Williamson
> >> <alex.williamson@redhat.com>; Kevin Tian <kevin.tian@intel.com>;
> >> Gonglei (Arei) <arei.gonglei@huawei.com>; stable@vger.kernel.org
> >> Subject: Re: [PATCH] iommu/vt-d: Force to flush iotlb before creating
> >> superpage
> >>
> >> Hi Longpeng,
> >>
> >> On 4/1/21 3:18 PM, Longpeng(Mike) wrote:
> >>> diff --git a/drivers/iommu/intel/iommu.c
> >>> b/drivers/iommu/intel/iommu.c index ee09323..cbcb434 100644
> >>> --- a/drivers/iommu/intel/iommu.c
> >>> +++ b/drivers/iommu/intel/iommu.c
> >>> @@ -2342,9 +2342,20 @@ static inline int
> >>> hardware_largepage_caps(struct
> >> dmar_domain *domain,
> >>>    				 * removed to make room for superpage(s).
> >>>    				 * We're adding new large pages, so make sure
> >>>    				 * we don't remove their parent tables.
> >>> +				 *
> >>> +				 * We also need to flush the iotlb before creating
> >>> +				 * superpage to ensure it does not perserves any
> >>> +				 * obsolete info.
> >>>    				 */
> >>> -				dma_pte_free_pagetable(domain, iov_pfn, end_pfn,
> >>> -						       largepage_lvl + 1);
> >>> +				if (dma_pte_present(pte)) {
> >>
> >> The dma_pte_free_pagetable() clears a batch of PTEs. So checking
> >> current PTE is insufficient. How about removing this check and always
> >> performing cache invalidation?
> >>
> >
> > Um...the PTE here may be present( e.g. 4K mapping --> superpage mapping )
> orNOT-present ( e.g. create a totally new superpage mapping ), but we only need to
> call free_pagetable and flush_iotlb in the former case, right ?
> 
> But this code covers multiple PTEs and perhaps crosses the page boundary.
> 
> How about moving this code into a separated function and check PTE presence
> there. A sample code could look like below: [compiled but not tested!]
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c index
> d334f5b4e382..0e04d450c38a 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -2300,6 +2300,41 @@ static inline int hardware_largepage_caps(struct
> dmar_domain *domain,
>          return level;
>   }
> 
> +/*
> + * Ensure that old small page tables are removed to make room for
> superpage(s).
> + * We're going to add new large pages, so make sure we don't remove
> their parent
> + * tables. The IOTLB/devTLBs should be flushed if any PDE/PTEs are cleared.
> + */
> +static void switch_to_super_page(struct dmar_domain *domain,
> +                                unsigned long start_pfn,
> +                                unsigned long end_pfn, int level) {

Maybe "swith_to" will lead people to think "remove old and then setup new", so how about something like "remove_room_for_super_page" or "prepare_for_super_page" ?

> +       unsigned long lvl_pages = lvl_to_nr_pages(level);
> +       struct dma_pte *pte = NULL;
> +       int i;
> +
> +       while (start_pfn <= end_pfn) {

start_pfn < end_pfn ?

> +               if (!pte)
> +                       pte = pfn_to_dma_pte(domain, start_pfn, &level);
> +
> +               if (dma_pte_present(pte)) {
> +                       dma_pte_free_pagetable(domain, start_pfn,
> +                                              start_pfn + lvl_pages - 1,
> +                                              level + 1);
> +
> +                       for_each_domain_iommu(i, domain)
> +                               iommu_flush_iotlb_psi(g_iommus[i],
> domain,
> +                                                     start_pfn,
> lvl_pages,
> +                                                     0, 0);
> +               }
> +
> +               pte++;
> +               start_pfn += lvl_pages;
> +               if (first_pte_in_page(pte))
> +                       pte = NULL;
> +       }
> +}
> +
>   static int
>   __domain_mapping(struct dmar_domain *domain, unsigned long iov_pfn,
>                   unsigned long phys_pfn, unsigned long nr_pages, int prot)
> @@ -2341,22 +2376,11 @@ __domain_mapping(struct dmar_domain *domain,
> unsigned long iov_pfn,
>                                  return -ENOMEM;
>                          /* It is large page*/
>                          if (largepage_lvl > 1) {
> -                               unsigned long nr_superpages, end_pfn;
> +                               unsigned long end_pfn;
> 
>                                  pteval |= DMA_PTE_LARGE_PAGE;
> -                               lvl_pages = lvl_to_nr_pages(largepage_lvl);
> -
> -                               nr_superpages = nr_pages / lvl_pages;
> -                               end_pfn = iov_pfn + nr_superpages *
> lvl_pages - 1;
> -
> -                               /*
> -                                * Ensure that old small page tables are
> -                                * removed to make room for superpage(s).
> -                                * We're adding new large pages, so make
> sure
> -                                * we don't remove their parent tables.
> -                                */
> -                               dma_pte_free_pagetable(domain, iov_pfn,
> end_pfn,
> -                                                      largepage_lvl +
> 1);
> +                               end_pfn = ((iov_pfn + nr_pages) &
> level_mask(largepage_lvl)) - 1;
> +                               switch_to_super_page(domain, iov_pfn,
> end_pfn, largepage_lvl);
>                          } else {
>                                  pteval &=
> ~(uint64_t)DMA_PTE_LARGE_PAGE;
>                          }
> 
> I will send you the diff patch off list. Any thoughts?
> 

The solution looks good to me. 

It's free for you to send this patch if you want, I'll send V2 if you have no plan to send it :)

> Best regards,
> baolu
> 
> >
> >>> +					int i;
> >>> +
> >>> +					dma_pte_free_pagetable(domain, iov_pfn, end_pfn,
> >>> +							       largepage_lvl + 1);
> >>> +					for_each_domain_iommu(i, domain)
> >>> +						iommu_flush_iotlb_psi(g_iommus[i], domain,
> >>> +								      iov_pfn, nr_pages, 0, 0);
> >>> +
> >>
> >> Best regards,
> >> baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
