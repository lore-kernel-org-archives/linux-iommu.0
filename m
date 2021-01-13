Return-Path: <SRS0=lzux=GQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E46B8C433DB
	for <iommu@archiver.kernel.org>; Wed, 13 Jan 2021 02:57:57 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64B1723131
	for <iommu@archiver.kernel.org>; Wed, 13 Jan 2021 02:57:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64B1723131
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id E8DA186D11;
	Wed, 13 Jan 2021 02:57:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Xn0OgTkTOAEf; Wed, 13 Jan 2021 02:57:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id C86B486CB6;
	Wed, 13 Jan 2021 02:57:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AC46DC0893;
	Wed, 13 Jan 2021 02:57:55 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9F47BC013A
 for <iommu@lists.linux-foundation.org>; Wed, 13 Jan 2021 02:57:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 85C0785F9C
 for <iommu@lists.linux-foundation.org>; Wed, 13 Jan 2021 02:57:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HMzcklAOrQgY for <iommu@lists.linux-foundation.org>;
 Wed, 13 Jan 2021 02:57:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 63A9B85E13
 for <iommu@lists.linux-foundation.org>; Wed, 13 Jan 2021 02:57:52 +0000 (UTC)
IronPort-SDR: 4rPRC+POXyX6zHhbB3DTskdau5T14+rzCKjBKdutX0y7oOJr48Wr2Co0S8//v+X3LpcDblowKY
 m+QlfeIXiOlg==
X-IronPort-AV: E=McAfee;i="6000,8403,9862"; a="174634129"
X-IronPort-AV: E=Sophos;i="5.79,343,1602572400"; d="scan'208";a="174634129"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jan 2021 18:57:50 -0800
IronPort-SDR: +X9T3MaFFO67nRlp0dxZ8TxMXkHxjJOAiOBc3En2s6MlrikQP6movdXK64uL82EtWckUi7GFJu
 VUrSsRsxGT6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,343,1602572400"; d="scan'208";a="464751072"
Received: from allen-box.sh.intel.com (HELO [10.239.159.28]) ([10.239.159.28])
 by fmsmga001.fm.intel.com with ESMTP; 12 Jan 2021 18:57:44 -0800
Subject: Re: [PATCH v9 03/10] iommu: Separate IOMMU_DEV_FEAT_IOPF from
 IOMMU_DEV_FEAT_SVA
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
References: <20210108145217.2254447-1-jean-philippe@linaro.org>
 <20210108145217.2254447-4-jean-philippe@linaro.org>
 <4de8ef03-a2ed-316e-d3e3-6b8474e20113@linux.intel.com>
 <X/1o72DTmzdCMhDz@myrica>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <c88e5d74-098d-7f1d-a7bb-a89e40fb8fa4@linux.intel.com>
Date: Wed, 13 Jan 2021 10:49:39 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <X/1o72DTmzdCMhDz@myrica>
Content-Language: en-US
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, vivek.gautam@arm.com,
 guohanjun@huawei.com, will@kernel.org, linux-acpi@vger.kernel.org,
 zhangfei.gao@linaro.org, lenb@kernel.org, devicetree@vger.kernel.org, "Tian,
 Kevin" <kevin.tian@intel.com>, Arnd Bergmann <arnd@arndb.de>,
 robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
 David Woodhouse <dwmw2@infradead.org>, rjw@rjwysocki.net,
 iommu@lists.linux-foundation.org, sudeep.holla@arm.com, robin.murphy@arm.com,
 linux-accelerators@lists.ozlabs.org
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

Hi Jean,

On 1/12/21 5:16 PM, Jean-Philippe Brucker wrote:
> Hi Baolu,
> 
> On Tue, Jan 12, 2021 at 12:31:23PM +0800, Lu Baolu wrote:
>> Hi Jean,
>>
>> On 1/8/21 10:52 PM, Jean-Philippe Brucker wrote:
>>> Some devices manage I/O Page Faults (IOPF) themselves instead of relying
>>> on PCIe PRI or Arm SMMU stall. Allow their drivers to enable SVA without
>>> mandating IOMMU-managed IOPF. The other device drivers now need to first
>>> enable IOMMU_DEV_FEAT_IOPF before enabling IOMMU_DEV_FEAT_SVA.
>>>
>>> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
>>> ---
>>> Cc: Arnd Bergmann <arnd@arndb.de>
>>> Cc: David Woodhouse <dwmw2@infradead.org>
>>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>> Cc: Joerg Roedel <joro@8bytes.org>
>>> Cc: Lu Baolu <baolu.lu@linux.intel.com>
>>> Cc: Will Deacon <will@kernel.org>
>>> Cc: Zhangfei Gao <zhangfei.gao@linaro.org>
>>> Cc: Zhou Wang <wangzhou1@hisilicon.com>
>>> ---
>>>    include/linux/iommu.h | 20 +++++++++++++++++---
>>>    1 file changed, 17 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
>>> index 583c734b2e87..701b2eeb0dc5 100644
>>> --- a/include/linux/iommu.h
>>> +++ b/include/linux/iommu.h
>>> @@ -156,10 +156,24 @@ struct iommu_resv_region {
>>>    	enum iommu_resv_type	type;
>>>    };
>>> -/* Per device IOMMU features */
>>> +/**
>>> + * enum iommu_dev_features - Per device IOMMU features
>>> + * @IOMMU_DEV_FEAT_AUX: Auxiliary domain feature
>>> + * @IOMMU_DEV_FEAT_SVA: Shared Virtual Addresses
>>> + * @IOMMU_DEV_FEAT_IOPF: I/O Page Faults such as PRI or Stall. Generally using
>>> + *			 %IOMMU_DEV_FEAT_SVA requires %IOMMU_DEV_FEAT_IOPF, but
>>> + *			 some devices manage I/O Page Faults themselves instead
>>> + *			 of relying on the IOMMU. When supported, this feature
>>> + *			 must be enabled before and disabled after
>>> + *			 %IOMMU_DEV_FEAT_SVA.
>>
>> Is this only for SVA? We may see more scenarios of using IOPF. For
>> example, when passing through devices to user level, the user's pages
>> could be managed dynamically instead of being allocated and pinned
>> statically.
> 
> Hm, isn't that precisely what SVA does?  I don't understand the
> difference. That said FEAT_IOPF doesn't have to be only for SVA. It could
> later be used as a prerequisite some another feature. For special cases
> device drivers can always use the iommu_register_device_fault_handler()
> API and handle faults themselves.

 From the perspective of IOMMU, there is a little difference between
these two. For SVA, the page table is from CPU side, so IOMMU only needs
to call handle_mm_fault(); For above pass-through case, the page table
is from IOMMU side, so the device driver (probably VFIO) needs to
register a fault handler and call iommu_map/unmap() to serve the page
faults.

If we think about the nested mode (or dual-stage translation), it's more
complicated since the kernel (probably VFIO) handles the second level
page faults, while the first level page faults need to be delivered to
user-level guest. Obviously, this hasn't been fully implemented in any
IOMMU driver.

> 
>> If @IOMMU_DEV_FEAT_IOPF is defined as generic iopf support, the current
>> vendor IOMMU driver support may not enough.
> 
> IOMMU_DEV_FEAT_IOPF on its own doesn't do anything useful, it's mainly a
> way for device drivers to probe the IOMMU capability. Granted in patch
> 10 the SMMU driver registers the IOPF queue on enable() but that could be
> done by FEAT_SVA enable() instead, if we ever repurpose FEAT_IOPF.

I have no objection to split IOPF from SVA. Actually we must have this
eventually. My concern is that at this stage, the IOMMU drivers only
support SVA type of IOPF, a generic IOMMU_DEV_FEAT_IOPF feature might
confuse the device drivers which want to add other types of IOPF usage.

> 
> Thanks,
> Jean
> 

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
