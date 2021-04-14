Return-Path: <SRS0=7Zqx=JL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97DBDC433B4
	for <iommu@archiver.kernel.org>; Wed, 14 Apr 2021 02:36:40 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A81860FF0
	for <iommu@archiver.kernel.org>; Wed, 14 Apr 2021 02:36:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A81860FF0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1604E4014C;
	Wed, 14 Apr 2021 02:36:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 150lZPSEucIL; Wed, 14 Apr 2021 02:36:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id F402E400F3;
	Wed, 14 Apr 2021 02:36:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A8E40C000C;
	Wed, 14 Apr 2021 02:36:38 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 17B0EC000A
 for <iommu@lists.linux-foundation.org>; Wed, 14 Apr 2021 02:36:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0B41340140
 for <iommu@lists.linux-foundation.org>; Wed, 14 Apr 2021 02:36:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZkNQNMnp2Izz for <iommu@lists.linux-foundation.org>;
 Wed, 14 Apr 2021 02:36:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
 by smtp2.osuosl.org (Postfix) with ESMTPS id CBCE0400F3
 for <iommu@lists.linux-foundation.org>; Wed, 14 Apr 2021 02:36:35 +0000 (UTC)
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
 by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4FKmlM6j0LzjYxw;
 Wed, 14 Apr 2021 10:34:39 +0800 (CST)
Received: from [10.174.185.226] (10.174.185.226) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.498.0; Wed, 14 Apr 2021 10:36:23 +0800
To: Eric Auger <eric.auger@redhat.com>, <eric.auger.pro@gmail.com>,
 <jean-philippe@linaro.org>, <iommu@lists.linux-foundation.org>,
 <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
 <kvmarm@lists.cs.columbia.edu>, <will@kernel.org>, <maz@kernel.org>,
 <robin.murphy@arm.com>, <joro@8bytes.org>, <alex.williamson@redhat.com>,
 <tn@semihalf.com>, <zhukeqian1@huawei.com>
References: <20210411111228.14386-1-eric.auger@redhat.com>
From: Xingang Wang <wangxingang5@huawei.com>
Subject: Re: [PATCH v15 00/12] SMMUv3 Nested Stage Setup (IOMMU part)
Message-ID: <55930e46-0a45-0d43-b34e-432cf332b42c@huawei.com>
Date: Wed, 14 Apr 2021 10:36:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20210411111228.14386-1-eric.auger@redhat.com>
Content-Language: en-US
X-Originating-IP: [10.174.185.226]
X-CFilter-Loop: Reflected
Cc: vsethi@nvidia.com, jiangkunkun@huawei.com, lushenming@huawei.com,
 vivek.gautam@arm.com, zhangfei.gao@linaro.org
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

Hi Eric, Jean-Philippe

On 2021/4/11 19:12, Eric Auger wrote:
> SMMUv3 Nested Stage Setup (IOMMU part)
> 
> This series brings the IOMMU part of HW nested paging support
> in the SMMUv3. The VFIO part is submitted separately.
> 
> This is based on Jean-Philippe's
> [PATCH v14 00/10] iommu: I/O page faults for SMMUv3
> https://www.spinics.net/lists/arm-kernel/msg886518.html
> (including the patches that were not pulled for 5.13)
> 
> The IOMMU API is extended to support 2 new API functionalities:
> 1) pass the guest stage 1 configuration
> 2) pass stage 1 MSI bindings
> 
> Then those capabilities gets implemented in the SMMUv3 driver.
> 
> The virtualizer passes information through the VFIO user API
> which cascades them to the iommu subsystem. This allows the guest
> to own stage 1 tables and context descriptors (so-called PASID
> table) while the host owns stage 2 tables and main configuration
> structures (STE).
> 
> Best Regards
> 
> Eric
> 
> This series can be found at:
> v5.12-rc6-jean-iopf-14-2stage-v15
> (including the VFIO part in its last version: v13)
> 

I am testing the performance of an accelerator with/without SVA/vSVA,
and found there might be some potential performance loss risk for SVA/vSVA.

I use a Network and computing encryption device (SEC), and send 1MB 
request for 10000 times.

I trigger mm fault before I send the request, so there should be no iopf.

Here's what I got:

physical scenario:
performance:		SVA:9MB/s  	NOSVA:9MB/s
tlb_miss: 		SVA:302,651	NOSVA:1,223
trans_table_walk_access:SVA:302,276	NOSVA:1,237

VM scenario:
performance:		vSVA:9MB/s  	NOvSVA:6MB/s  about 30~40% loss
tlb_miss: 		vSVA:4,423,897	NOvSVA:1,907
trans_table_walk_access:vSVA:61,928,430	NOvSVA:21,948

In physical scenario, there's almost no performance loss, but the 
tlb_miss and trans_table_walk_access of stage 1 for SVA is quite high, 
comparing to NOSVA.

In VM scenario, there's about 30~40% performance loss, this is because 
the two stage tlb_miss and trans_table_walk_access is even higher, and 
impact the performance.

I compare the procedure of building page table of SVA and NOSVA, and 
found that NOSVA uses 2MB mapping as far as possible, while SVA uses 
only 4KB.

I retest with huge page, and huge page could solve this problem, the 
performance of SVA/vSVA is almost the same as NOSVA.

I am wondering do you have any other solution for the performance loss 
of vSVA, or any other method to reduce the tlb_miss/trans_table_walk.

Thanks

Xingang

.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
