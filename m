Return-Path: <SRS0=d8dU=JF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88872C433B4
	for <iommu@archiver.kernel.org>; Thu,  8 Apr 2021 04:41:43 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8B3E611C0
	for <iommu@archiver.kernel.org>; Thu,  8 Apr 2021 04:41:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8B3E611C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9829140E45;
	Thu,  8 Apr 2021 04:41:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id P49Nx77sQi4W; Thu,  8 Apr 2021 04:41:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id 00D9840642;
	Thu,  8 Apr 2021 04:41:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B9AEFC000B;
	Thu,  8 Apr 2021 04:41:40 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4596EC000A
 for <iommu@lists.linux-foundation.org>; Thu,  8 Apr 2021 04:41:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 20A56400D4
 for <iommu@lists.linux-foundation.org>; Thu,  8 Apr 2021 04:41:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PRuvEM8d3qsB for <iommu@lists.linux-foundation.org>;
 Thu,  8 Apr 2021 04:41:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 23DDF400CD
 for <iommu@lists.linux-foundation.org>; Thu,  8 Apr 2021 04:41:38 +0000 (UTC)
IronPort-SDR: R7dXAWxdzwmLlWkJXUUBvip3fbTqD8vySC0EoDir15bAE/rE0NGSDXsFtEKNdksBLinmBbY1wp
 lVQtlpEQpe3Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9947"; a="190251243"
X-IronPort-AV: E=Sophos;i="5.82,205,1613462400"; d="scan'208";a="190251243"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Apr 2021 21:41:37 -0700
IronPort-SDR: QgPTai8qsRYIxJB9cbtKU0LEEXQs+NQgzGRSdiEGaXLNexM8ZyQelHMsG8jBf96vTyWuqDDSEN
 wLeSpg7g+6LA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,205,1613462400"; d="scan'208";a="441590560"
Received: from allen-box.sh.intel.com (HELO [10.239.159.128])
 ([10.239.159.128])
 by fmsmga004.fm.intel.com with ESMTP; 07 Apr 2021 21:41:34 -0700
Subject: Re: [PATCH] iommu/vt-d: Force to flush iotlb before creating superpage
To: "Longpeng (Mike, Cloud Infrastructure Service Product Dept.)"
 <longpeng2@huawei.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20210401071834.1639-1-longpeng2@huawei.com>
 <9c368419-6e45-6b27-0f34-26b581589fa7@linux.intel.com>
 <611cb5849c9a497b8289004dddb71150@huawei.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <808394ea-9ff0-7a6d-72e7-f037e5cd3110@linux.intel.com>
Date: Thu, 8 Apr 2021 12:32:05 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <611cb5849c9a497b8289004dddb71150@huawei.com>
Content-Language: en-US
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Hi Longpeng,

On 4/7/21 2:35 PM, Longpeng (Mike, Cloud Infrastructure Service Product 
Dept.) wrote:
> Hi Baolu,
> 
>> -----Original Message-----
>> From: Lu Baolu [mailto:baolu.lu@linux.intel.com]
>> Sent: Friday, April 2, 2021 12:44 PM
>> To: Longpeng (Mike, Cloud Infrastructure Service Product Dept.)
>> <longpeng2@huawei.com>; iommu@lists.linux-foundation.org;
>> linux-kernel@vger.kernel.org
>> Cc: baolu.lu@linux.intel.com; David Woodhouse <dwmw2@infradead.org>; Nadav
>> Amit <nadav.amit@gmail.com>; Alex Williamson <alex.williamson@redhat.com>;
>> Kevin Tian <kevin.tian@intel.com>; Gonglei (Arei) <arei.gonglei@huawei.com>;
>> stable@vger.kernel.org
>> Subject: Re: [PATCH] iommu/vt-d: Force to flush iotlb before creating superpage
>>
>> Hi Longpeng,
>>
>> On 4/1/21 3:18 PM, Longpeng(Mike) wrote:
>>> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
>>> index ee09323..cbcb434 100644
>>> --- a/drivers/iommu/intel/iommu.c
>>> +++ b/drivers/iommu/intel/iommu.c
>>> @@ -2342,9 +2342,20 @@ static inline int hardware_largepage_caps(struct
>> dmar_domain *domain,
>>>    				 * removed to make room for superpage(s).
>>>    				 * We're adding new large pages, so make sure
>>>    				 * we don't remove their parent tables.
>>> +				 *
>>> +				 * We also need to flush the iotlb before creating
>>> +				 * superpage to ensure it does not perserves any
>>> +				 * obsolete info.
>>>    				 */
>>> -				dma_pte_free_pagetable(domain, iov_pfn, end_pfn,
>>> -						       largepage_lvl + 1);
>>> +				if (dma_pte_present(pte)) {
>>
>> The dma_pte_free_pagetable() clears a batch of PTEs. So checking current PTE is
>> insufficient. How about removing this check and always performing cache
>> invalidation?
>>
> 
> Um...the PTE here may be present( e.g. 4K mapping --> superpage mapping ) orNOT-present ( e.g. create a totally new superpage mapping ), but we only need to call free_pagetable and flush_iotlb in the former case, right ?

But this code covers multiple PTEs and perhaps crosses the page
boundary.

How about moving this code into a separated function and check PTE
presence there. A sample code could look like below: [compiled but not
tested!]

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index d334f5b4e382..0e04d450c38a 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -2300,6 +2300,41 @@ static inline int hardware_largepage_caps(struct 
dmar_domain *domain,
         return level;
  }

+/*
+ * Ensure that old small page tables are removed to make room for 
superpage(s).
+ * We're going to add new large pages, so make sure we don't remove 
their parent
+ * tables. The IOTLB/devTLBs should be flushed if any PDE/PTEs are cleared.
+ */
+static void switch_to_super_page(struct dmar_domain *domain,
+                                unsigned long start_pfn,
+                                unsigned long end_pfn, int level)
+{
+       unsigned long lvl_pages = lvl_to_nr_pages(level);
+       struct dma_pte *pte = NULL;
+       int i;
+
+       while (start_pfn <= end_pfn) {
+               if (!pte)
+                       pte = pfn_to_dma_pte(domain, start_pfn, &level);
+
+               if (dma_pte_present(pte)) {
+                       dma_pte_free_pagetable(domain, start_pfn,
+                                              start_pfn + lvl_pages - 1,
+                                              level + 1);
+
+                       for_each_domain_iommu(i, domain)
+                               iommu_flush_iotlb_psi(g_iommus[i], domain,
+                                                     start_pfn, lvl_pages,
+                                                     0, 0);
+               }
+
+               pte++;
+               start_pfn += lvl_pages;
+               if (first_pte_in_page(pte))
+                       pte = NULL;
+       }
+}
+
  static int
  __domain_mapping(struct dmar_domain *domain, unsigned long iov_pfn,
                  unsigned long phys_pfn, unsigned long nr_pages, int prot)
@@ -2341,22 +2376,11 @@ __domain_mapping(struct dmar_domain *domain, 
unsigned long iov_pfn,
                                 return -ENOMEM;
                         /* It is large page*/
                         if (largepage_lvl > 1) {
-                               unsigned long nr_superpages, end_pfn;
+                               unsigned long end_pfn;

                                 pteval |= DMA_PTE_LARGE_PAGE;
-                               lvl_pages = lvl_to_nr_pages(largepage_lvl);
-
-                               nr_superpages = nr_pages / lvl_pages;
-                               end_pfn = iov_pfn + nr_superpages * 
lvl_pages - 1;
-
-                               /*
-                                * Ensure that old small page tables are
-                                * removed to make room for superpage(s).
-                                * We're adding new large pages, so make 
sure
-                                * we don't remove their parent tables.
-                                */
-                               dma_pte_free_pagetable(domain, iov_pfn, 
end_pfn,
-                                                      largepage_lvl + 1);
+                               end_pfn = ((iov_pfn + nr_pages) & 
level_mask(largepage_lvl)) - 1;
+                               switch_to_super_page(domain, iov_pfn, 
end_pfn, largepage_lvl);
                         } else {
                                 pteval &= ~(uint64_t)DMA_PTE_LARGE_PAGE;
                         }

I will send you the diff patch off list. Any thoughts?

Best regards,
baolu

> 
>>> +					int i;
>>> +
>>> +					dma_pte_free_pagetable(domain, iov_pfn, end_pfn,
>>> +							       largepage_lvl + 1);
>>> +					for_each_domain_iommu(i, domain)
>>> +						iommu_flush_iotlb_psi(g_iommus[i], domain,
>>> +								      iov_pfn, nr_pages, 0, 0);
>>> +
>>
>> Best regards,
>> baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
