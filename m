Return-Path: <SRS0=MQAj=7J=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FEC2C433E2
	for <iommu@archiver.kernel.org>; Wed, 27 May 2020 06:45:47 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01F1520787
	for <iommu@archiver.kernel.org>; Wed, 27 May 2020 06:45:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01F1520787
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id B81A720028;
	Wed, 27 May 2020 06:45:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IHpm4BVJHErO; Wed, 27 May 2020 06:45:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id A358C2043C;
	Wed, 27 May 2020 06:45:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 89A1BC088D;
	Wed, 27 May 2020 06:45:45 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B3806C016F
 for <iommu@lists.linux-foundation.org>; Wed, 27 May 2020 06:45:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 76BFC20028
 for <iommu@lists.linux-foundation.org>; Wed, 27 May 2020 06:45:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7rplK7F25Zmv for <iommu@lists.linux-foundation.org>;
 Wed, 27 May 2020 06:45:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from huawei.com (szxga06-in.huawei.com [45.249.212.32])
 by silver.osuosl.org (Postfix) with ESMTPS id 1A0AB20452
 for <iommu@lists.linux-foundation.org>; Wed, 27 May 2020 06:45:40 +0000 (UTC)
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id EB9C06C080604E208CCE;
 Wed, 27 May 2020 14:45:33 +0800 (CST)
Received: from [127.0.0.1] (10.173.221.213) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.487.0;
 Wed, 27 May 2020 14:45:26 +0800
Subject: Re: [RFC] Use SMMU HTTU for DMA dirty page tracking
To: "Tian, Kevin" <kevin.tian@intel.com>, Jean-Philippe Brucker
 <jean-philippe@linaro.org>
References: <b926ec0b-fe87-0792-c41d-acad56c656a4@huawei.com>
 <20200522171452.GC3453945@myrica>
 <e68c1158-8573-a477-42ce-48cee510c3ce@huawei.com>
 <MWHPR11MB16454475DA1FF417CEF5A32B8CB10@MWHPR11MB1645.namprd11.prod.outlook.com>
From: Xiang Zheng <zhengxiang9@huawei.com>
Message-ID: <897a84ac-0a71-ace7-e05b-3cc9f0b05c28@huawei.com>
Date: Wed, 27 May 2020 14:45:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <MWHPR11MB16454475DA1FF417CEF5A32B8CB10@MWHPR11MB1645.namprd11.prod.outlook.com>
Content-Language: en-US
X-Originating-IP: [10.173.221.213]
X-CFilter-Loop: Reflected
Cc: "Zhao, Yan Y" <yan.y.zhao@intel.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, "maz@kernel.org" <maz@kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Kirti Wankhede <kwankhede@nvidia.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 James Morse <james.morse@arm.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "prime.zeng@hisilicon.com" <prime.zeng@hisilicon.com>,
 Wang Haibin <wanghaibin.wang@huawei.com>, Will Deacon <will@kernel.org>,
 "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>,
 "julien.thierry.kdev@gmail.com" <julien.thierry.kdev@gmail.com>
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


On 2020/5/27 11:27, Tian, Kevin wrote:
>> From: Xiang Zheng
>> Sent: Monday, May 25, 2020 7:34 PM
>>
>> [+cc Kirti, Yan, Alex]
>>
>> On 2020/5/23 1:14, Jean-Philippe Brucker wrote:
>>> Hi,
>>>
>>> On Tue, May 19, 2020 at 05:42:55PM +0800, Xiang Zheng wrote:
>>>> Hi all,
>>>>
>>>> Is there any plan for enabling SMMU HTTU?
>>>
>>> Not outside of SVA, as far as I know.
>>>
>>
>>>> I have seen the patch locates in the SVA series patch, which adds
>>>> support for HTTU:
>>>>     https://www.spinics.net/lists/arm-kernel/msg798694.html
>>>>
>>>> HTTU reduces the number of access faults on SMMU fault queue
>>>> (permission faults also benifit from it).
>>>>
>>>> Besides reducing the faults, HTTU also helps to track dirty pages for
>>>> device DMA. Is it feasible to utilize HTTU to get dirty pages on device
>>>> DMA during VFIO live migration?
>>>
>>> As you know there is a VFIO interface for this under discussion:
>>> https://lore.kernel.org/kvm/1589781397-28368-1-git-send-email-
>> kwankhede@nvidia.com/
>>> It doesn't implement an internal API to communicate with the IOMMU
>> driver
>>> about dirty pages.
> 
> We plan to add such API later, e.g. to utilize A/D bit in VT-d 2nd-level 
> page tables (Rev 3.0). 
> 

Thank you, Kevin.

When will you send this series patches? Maybe(Hope) we can also support
hardware-based dirty pages tracking via common APIs based on your patches. :)

>>
>>>
>>>> If SMMU can track dirty pages, devices are not required to implement
>>>> additional dirty pages tracking to support VFIO live migration.
>>>
>>> It seems feasible, though tracking it in the device might be more
>>> efficient. I might have misunderstood but I think for live migration of
>>> the Intel NIC they trap guest accesses to the device and introspect its
>>> state to figure out which pages it is accessing.
> 
> Does HTTU implement A/D-like mechanism in SMMU page tables, or just
> report dirty pages in a log buffer? Either way tracking dirty pages in IOMMU
> side is generic thus doesn't require device-specific tweak like in Intel NIC.
> 

Currently HTTU just implement A/D-like mechanism in SMMU page tables. We certainly
expect SMMU can also implement PML-like feature so that we can avoid walking the
whole page table to get the dirty pages.

By the way, I'm not sure whether HTTU or SLAD can help for mediated deivce.

-- 
Thanks,
Xiang

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
