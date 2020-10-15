Return-Path: <SRS0=+Hy+=DW=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C862C433DF
	for <iommu@archiver.kernel.org>; Thu, 15 Oct 2020 09:56:03 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B10F206D4
	for <iommu@archiver.kernel.org>; Thu, 15 Oct 2020 09:56:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B10F206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id AB17D2E610;
	Thu, 15 Oct 2020 09:56:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PJhBRQBrrzyj; Thu, 15 Oct 2020 09:55:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 7349C20432;
	Thu, 15 Oct 2020 09:55:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4F1F7C0052;
	Thu, 15 Oct 2020 09:55:57 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 261C5C0051
 for <iommu@lists.linux-foundation.org>; Thu, 15 Oct 2020 09:55:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 1A38188508
 for <iommu@lists.linux-foundation.org>; Thu, 15 Oct 2020 09:55:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EGeGcatLBx4U for <iommu@lists.linux-foundation.org>;
 Thu, 15 Oct 2020 09:55:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by whitealder.osuosl.org (Postfix) with ESMTP id 17BC18850C
 for <iommu@lists.linux-foundation.org>; Thu, 15 Oct 2020 09:55:55 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5ED2FD6E;
 Thu, 15 Oct 2020 02:55:54 -0700 (PDT)
Received: from [10.57.48.76] (unknown [10.57.48.76])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 01A7C3F66B;
 Thu, 15 Oct 2020 02:55:52 -0700 (PDT)
Subject: Re: [PATCH v7 3/3] iommu/tegra-smmu: Add PCI support
To: Nicolin Chen <nicoleotsuka@gmail.com>
References: <20201009161936.23122-1-nicoleotsuka@gmail.com>
 <20201009161936.23122-4-nicoleotsuka@gmail.com>
 <cbc6e3bf-eedc-195c-c4d6-52d3cd24c257@arm.com>
 <20201015041346.GA13936@Asurada-Nvidia>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <340afbc0-5513-0742-d2d2-1ab908248af3@arm.com>
Date: Thu, 15 Oct 2020 10:55:52 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <20201015041346.GA13936@Asurada-Nvidia>
Content-Language: en-GB
Cc: linux-kernel@vger.kernel.org, jonathanh@nvidia.com,
 iommu@lists.linux-foundation.org, thierry.reding@gmail.com,
 linux-tegra@vger.kernel.org, digetx@gmail.com
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

On 2020-10-15 05:13, Nicolin Chen wrote:
> On Wed, Oct 14, 2020 at 06:42:36PM +0100, Robin Murphy wrote:
>> On 2020-10-09 17:19, Nicolin Chen wrote:
>>> This patch simply adds support for PCI devices.
>>>
>>> Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
>>> Tested-by: Dmitry Osipenko <digetx@gmail.com>
>>> Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
>>> ---
>>>
>>> Changelog
>>> v6->v7
>>>    * Renamed goto labels, suggested by Thierry.
>>> v5->v6
>>>    * Added Dmitry's Reviewed-by and Tested-by.
>>> v4->v5
>>>    * Added Dmitry's Reviewed-by
>>> v3->v4
>>>    * Dropped !iommu_present() check
>>>    * Added CONFIG_PCI check in the exit path
>>> v2->v3
>>>    * Replaced ternary conditional operator with if-else in .device_group()
>>>    * Dropped change in tegra_smmu_remove()
>>> v1->v2
>>>    * Added error-out labels in tegra_smmu_probe()
>>>    * Dropped pci_request_acs() since IOMMU core would call it.
>>>
>>>    drivers/iommu/tegra-smmu.c | 35 +++++++++++++++++++++++++----------
>>>    1 file changed, 25 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
>>> index be29f5977145..2941d6459076 100644
>>> --- a/drivers/iommu/tegra-smmu.c
>>> +++ b/drivers/iommu/tegra-smmu.c
>>> @@ -10,6 +10,7 @@
>>>    #include <linux/kernel.h>
>>>    #include <linux/of.h>
>>>    #include <linux/of_device.h>
>>> +#include <linux/pci.h>
>>>    #include <linux/platform_device.h>
>>>    #include <linux/slab.h>
>>>    #include <linux/spinlock.h>
>>> @@ -865,7 +866,11 @@ static struct iommu_group *tegra_smmu_device_group(struct device *dev)
>>>    	group->smmu = smmu;
>>>    	group->soc = soc;
>>> -	group->group = iommu_group_alloc();
>>> +	if (dev_is_pci(dev))
>>> +		group->group = pci_device_group(dev);
>>
>> Just to check, is it OK to have two or more swgroups "owning" the same
>> iommu_group if an existing one gets returned here? It looks like that might
>> not play nice with the use of iommu_group_set_iommudata().
> 
> Do you mean by "gets returned here" the "IS_ERR" check below?

I mean that unlike iommu_group_alloc()/generic_device_group(), 
pci_device_group() may give you back a group that already contains 
another device and has already been set up from that device's 
perspective. This can happen for topological reasons like requester ID 
aliasing through a PCI-PCIe bridge or lack of isolation between functions.

Robin.

>>> +	else
>>> +		group->group = generic_device_group(dev);
>>> +
>>>    	if (IS_ERR(group->group)) {
>>>    		devm_kfree(smmu->dev, group);
>>>    		mutex_unlock(&smmu->lock);
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
