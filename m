Return-Path: <SRS0=7Zqx=JL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FBC6C433B4
	for <iommu@archiver.kernel.org>; Wed, 14 Apr 2021 07:09:24 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE428613A9
	for <iommu@archiver.kernel.org>; Wed, 14 Apr 2021 07:09:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE428613A9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 60DC660D73;
	Wed, 14 Apr 2021 07:09:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YeTGsc17z2jN; Wed, 14 Apr 2021 07:09:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id A297C606F1;
	Wed, 14 Apr 2021 07:09:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 72388C000C;
	Wed, 14 Apr 2021 07:09:20 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1D7A7C000A
 for <iommu@lists.linux-foundation.org>; Wed, 14 Apr 2021 07:09:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0A37D83C99
 for <iommu@lists.linux-foundation.org>; Wed, 14 Apr 2021 07:09:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RKaIEZUoBgNV for <iommu@lists.linux-foundation.org>;
 Wed, 14 Apr 2021 07:09:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4959983C95
 for <iommu@lists.linux-foundation.org>; Wed, 14 Apr 2021 07:09:17 +0000 (UTC)
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
 by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4FKtnX0Pphz9yT7;
 Wed, 14 Apr 2021 15:06:56 +0800 (CST)
Received: from [10.174.185.226] (10.174.185.226) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.498.0; Wed, 14 Apr 2021 15:09:05 +0800
Subject: Re: [PATCH v15 00/12] SMMUv3 Nested Stage Setup (IOMMU part)
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>, "Eric
 Auger" <eric.auger@redhat.com>, "eric.auger.pro@gmail.com"
 <eric.auger.pro@gmail.com>, "jean-philippe@linaro.org"
 <jean-philippe@linaro.org>, "iommu@lists.linux-foundation.org"
 <iommu@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>,
 "will@kernel.org" <will@kernel.org>, "maz@kernel.org" <maz@kernel.org>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>, "joro@8bytes.org"
 <joro@8bytes.org>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>, 
 "tn@semihalf.com" <tn@semihalf.com>, zhukeqian <zhukeqian1@huawei.com>
References: <20210411111228.14386-1-eric.auger@redhat.com>
 <55930e46-0a45-0d43-b34e-432cf332b42c@huawei.com>
 <f6b0bcd156e04d0f958cf79a50ac69e2@huawei.com>
From: Xingang Wang <wangxingang5@huawei.com>
Message-ID: <2b8aa93c-1c66-fb0c-f98a-0b59980919d3@huawei.com>
Date: Wed, 14 Apr 2021 15:08:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <f6b0bcd156e04d0f958cf79a50ac69e2@huawei.com>
Content-Language: en-US
X-Originating-IP: [10.174.185.226]
X-CFilter-Loop: Reflected
Cc: xieyingtai@huawei.com, "vsethi@nvidia.com" <vsethi@nvidia.com>,
 cenjiahui@huawei.com, jiangkunkun <jiangkunkun@huawei.com>,
 lushenming <lushenming@huawei.com>,
 "vivek.gautam@arm.com" <vivek.gautam@arm.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>
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

Hi Shameer,

On 2021/4/14 14:56, Shameerali Kolothum Thodi wrote:
> 
> 
>> -----Original Message-----
>> From: wangxingang
>> Sent: 14 April 2021 03:36
>> To: Eric Auger <eric.auger@redhat.com>; eric.auger.pro@gmail.com;
>> jean-philippe@linaro.org; iommu@lists.linux-foundation.org;
>> linux-kernel@vger.kernel.org; kvm@vger.kernel.org;
>> kvmarm@lists.cs.columbia.edu; will@kernel.org; maz@kernel.org;
>> robin.murphy@arm.com; joro@8bytes.org; alex.williamson@redhat.com;
>> tn@semihalf.com; zhukeqian <zhukeqian1@huawei.com>
>> Cc: jacob.jun.pan@linux.intel.com; yi.l.liu@intel.com; zhangfei.gao@linaro.org;
>> zhangfei.gao@gmail.com; vivek.gautam@arm.com; Shameerali Kolothum
>> Thodi <shameerali.kolothum.thodi@huawei.com>; yuzenghui
>> <yuzenghui@huawei.com>; nicoleotsuka@gmail.com; lushenming
>> <lushenming@huawei.com>; vsethi@nvidia.com; chenxiang (M)
>> <chenxiang66@hisilicon.com>; vdumpa@nvidia.com; jiangkunkun
>> <jiangkunkun@huawei.com>
>> Subject: Re: [PATCH v15 00/12] SMMUv3 Nested Stage Setup (IOMMU part)
>>
>> Hi Eric, Jean-Philippe
>>
>> On 2021/4/11 19:12, Eric Auger wrote:
>>> SMMUv3 Nested Stage Setup (IOMMU part)
>>>
>>> This series brings the IOMMU part of HW nested paging support
>>> in the SMMUv3. The VFIO part is submitted separately.
>>>
>>> This is based on Jean-Philippe's
>>> [PATCH v14 00/10] iommu: I/O page faults for SMMUv3
>>> https://www.spinics.net/lists/arm-kernel/msg886518.html
>>> (including the patches that were not pulled for 5.13)
>>>
>>> The IOMMU API is extended to support 2 new API functionalities:
>>> 1) pass the guest stage 1 configuration
>>> 2) pass stage 1 MSI bindings
>>>
>>> Then those capabilities gets implemented in the SMMUv3 driver.
>>>
>>> The virtualizer passes information through the VFIO user API
>>> which cascades them to the iommu subsystem. This allows the guest
>>> to own stage 1 tables and context descriptors (so-called PASID
>>> table) while the host owns stage 2 tables and main configuration
>>> structures (STE).
>>>
>>> Best Regards
>>>
>>> Eric
>>>
>>> This series can be found at:
>>> v5.12-rc6-jean-iopf-14-2stage-v15
>>> (including the VFIO part in its last version: v13)
>>>
>>
>> I am testing the performance of an accelerator with/without SVA/vSVA,
>> and found there might be some potential performance loss risk for SVA/vSVA.
>>
>> I use a Network and computing encryption device (SEC), and send 1MB
>> request for 10000 times.
>>
>> I trigger mm fault before I send the request, so there should be no iopf.
>>
>> Here's what I got:
>>
>> physical scenario:
>> performance:		SVA:9MB/s  	NOSVA:9MB/s
>> tlb_miss: 		SVA:302,651	NOSVA:1,223
>> trans_table_walk_access:SVA:302,276	NOSVA:1,237
>>
>> VM scenario:
>> performance:		vSVA:9MB/s  	NOvSVA:6MB/s  about 30~40% loss
>> tlb_miss: 		vSVA:4,423,897	NOvSVA:1,907
>> trans_table_walk_access:vSVA:61,928,430	NOvSVA:21,948
>>
>> In physical scenario, there's almost no performance loss, but the
>> tlb_miss and trans_table_walk_access of stage 1 for SVA is quite high,
>> comparing to NOSVA.
>>
>> In VM scenario, there's about 30~40% performance loss, this is because
>> the two stage tlb_miss and trans_table_walk_access is even higher, and
>> impact the performance.
>>
>> I compare the procedure of building page table of SVA and NOSVA, and
>> found that NOSVA uses 2MB mapping as far as possible, while SVA uses
>> only 4KB.
>>
>> I retest with huge page, and huge page could solve this problem, the
>> performance of SVA/vSVA is almost the same as NOSVA.
>>
>> I am wondering do you have any other solution for the performance loss
>> of vSVA, or any other method to reduce the tlb_miss/trans_table_walk.
> 
> Hi Xingang,
> 
> Just curious, do you have DVM enabled on this board or does it use explicit
> SMMU TLB invalidations?
> 
> Thanks,
> Shameer
> 

For now, DVM is enabled and TLBI is not explicit used.

And by the way the performance data above is
performance:	vSVA:9GB/s(not 9MB/s)  NOvSVA:6GB/s(not 6GB/s)

Thanks

Xingang

.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
