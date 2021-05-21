Return-Path: <SRS0=NT7l=KQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FB05C4360C
	for <iommu@archiver.kernel.org>; Fri, 21 May 2021 06:37:34 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F6AF613BB
	for <iommu@archiver.kernel.org>; Fri, 21 May 2021 06:37:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F6AF613BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BC8858457D;
	Fri, 21 May 2021 06:37:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wXhWqcZAnsxw; Fri, 21 May 2021 06:37:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7824C84524;
	Fri, 21 May 2021 06:37:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 58FA3C000D;
	Fri, 21 May 2021 06:37:32 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2CD62C0001
 for <iommu@lists.linux-foundation.org>; Fri, 21 May 2021 06:37:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0446241850
 for <iommu@lists.linux-foundation.org>; Fri, 21 May 2021 06:37:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ct1VqteN3R-n for <iommu@lists.linux-foundation.org>;
 Fri, 21 May 2021 06:37:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 42E7340318
 for <iommu@lists.linux-foundation.org>; Fri, 21 May 2021 06:37:27 +0000 (UTC)
Received: from dggems705-chm.china.huawei.com (unknown [172.30.72.58])
 by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FmcK7146qzqVF8;
 Fri, 21 May 2021 14:34:35 +0800 (CST)
Received: from dggpemm500022.china.huawei.com (7.185.36.162) by
 dggems705-chm.china.huawei.com (10.3.19.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 21 May 2021 14:37:22 +0800
Received: from [10.174.187.155] (10.174.187.155) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 21 May 2021 14:37:21 +0800
Subject: Re: [RFC PATCH v3 0/8] Add IOPF support for VFIO passthrough
To: Alex Williamson <alex.williamson@redhat.com>
References: <20210409034420.1799-1-lushenming@huawei.com>
 <20210518125756.4c075300.alex.williamson@redhat.com>
From: Shenming Lu <lushenming@huawei.com>
Message-ID: <accfb404-1d7b-8d73-6fb7-50011a3e546f@huawei.com>
Date: Fri, 21 May 2021 14:37:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <20210518125756.4c075300.alex.williamson@redhat.com>
Content-Language: en-US
X-Originating-IP: [10.174.187.155]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500022.china.huawei.com (7.185.36.162)
X-CFilter-Loop: Reflected
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Kevin Tian <kevin.tian@intel.com>, kvm@vger.kernel.org,
 Will Deacon <will@kernel.org>, Cornelia Huck <cohuck@redhat.com>,
 linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
 iommu@lists.linux-foundation.org, linux-api@vger.kernel.org,
 wanghaibin.wang@huawei.com, Robin
 Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org
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

Hi Alex,

On 2021/5/19 2:57, Alex Williamson wrote:
> On Fri, 9 Apr 2021 11:44:12 +0800
> Shenming Lu <lushenming@huawei.com> wrote:
> 
>> Hi,
>>
>> Requesting for your comments and suggestions. :-)
>>
>> The static pinning and mapping problem in VFIO and possible solutions
>> have been discussed a lot [1, 2]. One of the solutions is to add I/O
>> Page Fault support for VFIO devices. Different from those relatively
>> complicated software approaches such as presenting a vIOMMU that provides
>> the DMA buffer information (might include para-virtualized optimizations),
>> IOPF mainly depends on the hardware faulting capability, such as the PCIe
>> PRI extension or Arm SMMU stall model. What's more, the IOPF support in
>> the IOMMU driver has already been implemented in SVA [3]. So we add IOPF
>> support for VFIO passthrough based on the IOPF part of SVA in this series.
> 
> The SVA proposals are being reworked to make use of a new IOASID
> object, it's not clear to me that this shouldn't also make use of that
> work as it does a significant expansion of the type1 IOMMU with fault
> handlers that would duplicate new work using that new model.

It seems that the IOASID extension for guest SVA would not affect this series,
will we do any host-guest IOASID translation in the VFIO fault handler?

> 
>> We have measured its performance with UADK [4] (passthrough an accelerator
>> to a VM(1U16G)) on Hisilicon Kunpeng920 board (and compared with host SVA):
>>
>> Run hisi_sec_test...
>>  - with varying sending times and message lengths
>>  - with/without IOPF enabled (speed slowdown)
>>
>> when msg_len = 1MB (and PREMAP_LEN (in Patch 4) = 1):
>>             slowdown (num of faults)
>>  times      VFIO IOPF      host SVA
>>  1          63.4% (518)    82.8% (512)
>>  100        22.9% (1058)   47.9% (1024)
>>  1000       2.6% (1071)    8.5% (1024)
>>
>> when msg_len = 10MB (and PREMAP_LEN = 512):
>>             slowdown (num of faults)
>>  times      VFIO IOPF
>>  1          32.6% (13)
>>  100        3.5% (26)
>>  1000       1.6% (26)
> 
> It seems like this is only an example that you can make a benchmark
> show anything you want.  The best results would be to pre-map
> everything, which is what we have without this series.  What is an
> acceptable overhead to incur to avoid page pinning?  What if userspace
> had more fine grained control over which mappings were available for
> faulting and which were statically mapped?  I don't really see what
> sense the pre-mapping range makes.  If I assume the user is QEMU in a
> non-vIOMMU configuration, pre-mapping the beginning of each RAM section
> doesn't make any logical sense relative to device DMA.

As you said in Patch 4, we can introduce full end-to-end functionality
before trying to improve performance, and I will drop the pre-mapping patch
in the current stage...

Is there a need that userspace wants more fine grained control over which
mappings are available for faulting? If so, we may evolve the MAP ioctl
to support for specifying the faulting range.

As for the overhead of IOPF, it is unavoidable if enabling on-demand paging
(and page faults occur almost only when first accessing), and it seems that
there is a large optimization space compared to CPU page faulting.

Thanks,
Shenming

> 
> Comments per patch to follow.  Thanks,
> 
> Alex
> 
> 
>> History:
>>
>> v2 -> v3
>>  - Nit fixes.
>>  - No reason to disable reporting the unrecoverable faults. (baolu)
>>  - Maintain a global IOPF enabled group list.
>>  - Split the pre-mapping optimization to be a separate patch.
>>  - Add selective faulting support (use vfio_pin_pages to indicate the
>>    non-faultable scope and add a new struct vfio_range to record it,
>>    untested). (Kevin)
>>
>> v1 -> v2
>>  - Numerous improvements following the suggestions. Thanks a lot to all
>>    of you.
>>
>> Note that PRI is not supported at the moment since there is no hardware.
>>
>> Links:
>> [1] Lesokhin I, et al. Page Fault Support for Network Controllers. In ASPLOS,
>>     2016.
>> [2] Tian K, et al. coIOMMU: A Virtual IOMMU with Cooperative DMA Buffer Tracking
>>     for Efficient Memory Management in Direct I/O. In USENIX ATC, 2020.
>> [3] https://patchwork.kernel.org/project/linux-arm-kernel/cover/20210401154718.307519-1-jean-philippe@linaro.org/
>> [4] https://github.com/Linaro/uadk
>>
>> Thanks,
>> Shenming
>>
>>
>> Shenming Lu (8):
>>   iommu: Evolve the device fault reporting framework
>>   vfio/type1: Add a page fault handler
>>   vfio/type1: Add an MMU notifier to avoid pinning
>>   vfio/type1: Pre-map more pages than requested in the IOPF handling
>>   vfio/type1: VFIO_IOMMU_ENABLE_IOPF
>>   vfio/type1: No need to statically pin and map if IOPF enabled
>>   vfio/type1: Add selective DMA faulting support
>>   vfio: Add nested IOPF support
>>
>>  .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   |    3 +-
>>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |   18 +-
>>  drivers/iommu/iommu.c                         |   56 +-
>>  drivers/vfio/vfio.c                           |   85 +-
>>  drivers/vfio/vfio_iommu_type1.c               | 1000 ++++++++++++++++-
>>  include/linux/iommu.h                         |   19 +-
>>  include/linux/vfio.h                          |   13 +
>>  include/uapi/linux/iommu.h                    |    4 +
>>  include/uapi/linux/vfio.h                     |    6 +
>>  9 files changed, 1181 insertions(+), 23 deletions(-)
>>
> 
> .
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
