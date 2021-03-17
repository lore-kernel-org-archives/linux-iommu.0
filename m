Return-Path: <SRS0=kdPY=IP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_RED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 785C2C433E0
	for <iommu@archiver.kernel.org>; Wed, 17 Mar 2021 05:26:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9E7F64EF9
	for <iommu@archiver.kernel.org>; Wed, 17 Mar 2021 05:26:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9E7F64EF9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 61BCA6F69D;
	Wed, 17 Mar 2021 05:26:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UCMF6-YLEgGd; Wed, 17 Mar 2021 05:26:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3F795605B7;
	Wed, 17 Mar 2021 05:26:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 05EBFC000B;
	Wed, 17 Mar 2021 05:26:16 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DB8B2C000A
 for <iommu@lists.linux-foundation.org>; Wed, 17 Mar 2021 05:26:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CF4906F69D
 for <iommu@lists.linux-foundation.org>; Wed, 17 Mar 2021 05:26:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QOmRwWnP884b for <iommu@lists.linux-foundation.org>;
 Wed, 17 Mar 2021 05:26:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1AB84605B7
 for <iommu@lists.linux-foundation.org>; Wed, 17 Mar 2021 05:26:13 +0000 (UTC)
IronPort-SDR: ueMq9MZbbe8FkSsXoqcf1EbwarCZieyZPw0Q+u+I8j1VhyY5KAGMSC7eStXa/W/M5pp9Piv3Rs
 EW9+KTeISAYA==
X-IronPort-AV: E=McAfee;i="6000,8403,9925"; a="189485689"
X-IronPort-AV: E=Sophos;i="5.81,254,1610438400"; d="scan'208";a="189485689"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Mar 2021 22:26:13 -0700
IronPort-SDR: pP2Ftc14oJmJzDdv3e0Lpze7LE3K7W50dR1K6vJZG7oxorwpgDDiAAHo0l7q8/mz3X8X4gkqQv
 P5by0FTZB6eg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,254,1610438400"; d="scan'208";a="433266629"
Received: from allen-box.sh.intel.com (HELO [10.239.159.128])
 ([10.239.159.128])
 by fmsmga004.fm.intel.com with ESMTP; 16 Mar 2021 22:26:10 -0700
Subject: =?UTF-8?Q?Re=3a_A_problem_of_Intel_IOMMU_hardware_=ef=bc=9f?=
To: "Longpeng (Mike, Cloud Infrastructure Service Product Dept.)"
 <longpeng2@huawei.com>, dwmw2@infradead.org, joro@8bytes.org,
 will@kernel.org, alex.williamson@redhat.com
References: <670baaf8-4ff8-4e84-4be3-030b95ab5a5e@huawei.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <692186fd-42b8-4054-ead2-f6c6b1bf5b2d@linux.intel.com>
Date: Wed, 17 Mar 2021 13:16:58 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <670baaf8-4ff8-4e84-4be3-030b95ab5a5e@huawei.com>
Content-Language: en-US
Cc: chenjiashang@huawei.com, iommu@lists.linux-foundation.org,
 "Gonglei \(Arei\)" <arei.gonglei@huawei.com>,
 LKML <linux-kernel@vger.kernel.org>
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

On 3/17/21 11:16 AM, Longpeng (Mike, Cloud Infrastructure Service 
Product Dept.) wrote:
> Hi guys,
> 
> We find the Intel iommu cache (i.e. iotlb) maybe works wrong in a special
> situation, it would cause DMA fails or get wrong data.
> 
> The reproducer (based on Alex's vfio testsuite[1]) is in attachment, it can
> reproduce the problem with high probability (~50%).
> 
> The machine we used is:
> processor	: 47
> vendor_id	: GenuineIntel
> cpu family	: 6
> model		: 85
> model name	: Intel(R) Xeon(R) Gold 6146 CPU @ 3.20GHz
> stepping	: 4
> microcode	: 0x2000069
> 
> And the iommu capability reported is:
> ver 1:0 cap 8d2078c106f0466 ecap f020df
> (caching mode = 0 , page-selective invalidation = 1)
> 
> (The problem is also on 'Intel(R) Xeon(R) Silver 4114 CPU @ 2.20GHz' and
> 'Intel(R) Xeon(R) Platinum 8378A CPU @ 3.00GHz')
> 
> We run the reproducer on Linux 4.18 and it works as follow:
> 
> Step 1. alloc 4G *2M-hugetlb* memory (N.B. no problem with 4K-page mapping)

I don't understand 2M-hugetlb here means exactly. The IOMMU hardware
supports both 2M and 1G super page. The mapping physical memory is 4G.
Why couldn't it use 1G super page?

> Step 2. DMA Map 4G memory
> Step 3.
>      while (1) {
>          {UNMAP, 0x0, 0xa0000}, ------------------------------------ (a)
>          {UNMAP, 0xc0000, 0xbff40000},

Have these two ranges been mapped before? Does the IOMMU driver
complains when you trying to unmap a range which has never been
mapped? The IOMMU driver implicitly assumes that mapping and
unmapping are paired.

>          {MAP,   0x0, 0xc0000000}, --------------------------------- (b)
>                  use GDB to pause at here, and then DMA read IOVA=0,

IOVA 0 seems to be a special one. Have you verified with other addresses
than IOVA 0?

>                  sometimes DMA success (as expected),
>                  but sometimes DMA error (report not-present).
>          {UNMAP, 0x0, 0xc0000000}, --------------------------------- (c)
>          {MAP,   0x0, 0xa0000},
>          {MAP,   0xc0000, 0xbff40000},
>      }
> 
> The DMA read operations sholud success between (b) and (c), it should NOT report
> not-present at least!
> 
> After analysis the problem, we think maybe it's caused by the Intel iommu iotlb.
> It seems the DMA Remapping hardware still uses the IOTLB or other caches of (a).
> 
> When do DMA unmap at (a), the iotlb will be flush:
>      intel_iommu_unmap
>          domain_unmap
>              iommu_flush_iotlb_psi
> 
> When do DMA map at (b), no need to flush the iotlb according to the capability
> of this iommu:
>      intel_iommu_map
>          domain_pfn_mapping
>              domain_mapping
>                  __mapping_notify_one
>                      if (cap_caching_mode(iommu->cap)) // FALSE
>                          iommu_flush_iotlb_psi

That's true. The iotlb flushing is not needed in case of PTE been
changed from non-present to present unless caching mode.

> But the problem will disappear if we FORCE flush here. So we suspect the iommu
> hardware.
> 
> Do you have any suggestion ?

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
