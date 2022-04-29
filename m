Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24DC8C433F5
	for <iommu@archiver.kernel.org>; Fri, 29 Apr 2022 18:06:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A32FC83FB0;
	Fri, 29 Apr 2022 18:06:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wqkX3OqOVJAA; Fri, 29 Apr 2022 18:06:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 488CD83FAD;
	Fri, 29 Apr 2022 18:06:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 02D4BC0039;
	Fri, 29 Apr 2022 18:06:56 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E6C20C002D
 for <iommu@lists.linux-foundation.org>; Fri, 29 Apr 2022 18:06:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C4DB340ABC
 for <iommu@lists.linux-foundation.org>; Fri, 29 Apr 2022 18:06:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YgIKMw_WCEBJ for <iommu@lists.linux-foundation.org>;
 Fri, 29 Apr 2022 18:06:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp2.osuosl.org (Postfix) with ESMTP id C89C4400BB
 for <iommu@lists.linux-foundation.org>; Fri, 29 Apr 2022 18:06:52 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E18121063;
 Fri, 29 Apr 2022 11:06:50 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 872E03F73B;
 Fri, 29 Apr 2022 11:06:49 -0700 (PDT)
Message-ID: <1322706e-5905-433b-5bc5-ed44f881b510@arm.com>
Date: Fri, 29 Apr 2022 19:06:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 03/14] iommu: Move bus setup to IOMMU device
 registration
Content-Language: en-GB
From: Robin Murphy <robin.murphy@arm.com>
To: Baolu Lu <baolu.lu@linux.intel.com>, joro@8bytes.org, will@kernel.org
References: <cover.1650890638.git.robin.murphy@arm.com>
 <1faba5b5c094379df3d99b8fec924ab50ad75482.1650890638.git.robin.murphy@arm.com>
 <0e459e6e-f236-7a58-970a-a47677a23b44@linux.intel.com>
 <fa0d0663-5393-c533-105a-85bd2e9e0649@arm.com>
In-Reply-To: <fa0d0663-5393-c533-105a-85bd2e9e0649@arm.com>
Cc: jean-philippe@linaro.org, zhang.lyra@gmail.com,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 thierry.reding@gmail.com, gerald.schaefer@linux.ibm.com,
 linux-arm-kernel@lists.infradead.org
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

On 29/04/2022 9:50 am, Robin Murphy wrote:
> On 2022-04-29 07:57, Baolu Lu wrote:
>> Hi Robin,
>>
>> On 2022/4/28 21:18, Robin Murphy wrote:
>>> Move the bus setup to iommu_device_register(). This should allow
>>> bus_iommu_probe() to be correctly replayed for multiple IOMMU instances,
>>> and leaves bus_set_iommu() as a glorified no-op to be cleaned up next.
>>
>> I re-fetched the latest patches on
>>
>> https://gitlab.arm.com/linux-arm/linux-rm/-/commits/iommu/bus
>>
>> and rolled back the head to "iommu: Cleanup bus_set_iommu".
>>
>> The test machine still hangs during boot.
>>
>> I went through the code. It seems that the .probe_device for Intel IOMMU
>> driver can't handle the probe replay well. It always assumes that the
>> device has never been probed.
> 
> Hmm, but probe_iommu_group() is supposed to prevent the 
> __iommu_probe_device() call even happening if the device *has* already 
> been probed before :/
> 
> I've still got an old Intel box spare in the office so I'll rig that up 
> and see if I can see what might be going on here...

OK, on a Xeon with two DMAR units, this seems to boot OK with or without 
patch #1, so it doesn't seem to be a general problem with replaying in 
iommu_device_register(), or with platform devices. Not sure where to go 
from here... :/

Cheers,
Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
