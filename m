Return-Path: <SRS0=AxcK=KG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58F01C433B4
	for <iommu@archiver.kernel.org>; Tue, 11 May 2021 11:30:28 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2A6B6191E
	for <iommu@archiver.kernel.org>; Tue, 11 May 2021 11:30:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2A6B6191E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7A34D4052D;
	Tue, 11 May 2021 11:30:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9BDZChMAgtV7; Tue, 11 May 2021 11:30:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1F354402F4;
	Tue, 11 May 2021 11:30:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EBACAC000D;
	Tue, 11 May 2021 11:30:25 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7930EC0001
 for <iommu@lists.linux-foundation.org>; Tue, 11 May 2021 11:30:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B902E4044E
 for <iommu@lists.linux-foundation.org>; Tue, 11 May 2021 11:30:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7HNJj7oRzm50 for <iommu@lists.linux-foundation.org>;
 Tue, 11 May 2021 11:30:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 15F8B403F3
 for <iommu@lists.linux-foundation.org>; Tue, 11 May 2021 11:30:14 +0000 (UTC)
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
 by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FfbGx73YHzmgJV;
 Tue, 11 May 2021 19:26:49 +0800 (CST)
Received: from [10.174.184.135] (10.174.184.135) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.498.0; Tue, 11 May 2021 19:30:02 +0800
Subject: Re: [RFC PATCH v3 0/8] Add IOPF support for VFIO passthrough
From: Shenming Lu <lushenming@huawei.com>
To: Alex Williamson <alex.williamson@redhat.com>
References: <20210409034420.1799-1-lushenming@huawei.com>
 <cb9584fd-c7f5-8cac-8c63-219ded2ef9db@huawei.com>
Message-ID: <b7fbb6a3-8777-d46a-af6c-5b3243e8b00c@huawei.com>
Date: Tue, 11 May 2021 19:30:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <cb9584fd-c7f5-8cac-8c63-219ded2ef9db@huawei.com>
Content-Language: en-US
X-Originating-IP: [10.174.184.135]
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

Hope for some suggestions or comments from you since there seems to be many unsure
points in this series. :-)

Thanks,
Shenming


On 2021/4/26 9:41, Shenming Lu wrote:
> On 2021/4/9 11:44, Shenming Lu wrote:
>> Hi,
>>
>> Requesting for your comments and suggestions. :-)
> 
> Kind ping...
> 
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
>>
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
>>
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
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
