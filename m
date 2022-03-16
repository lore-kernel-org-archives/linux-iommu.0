Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5D0AC433EF
	for <iommu@archiver.kernel.org>; Wed, 16 Mar 2022 14:49:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9015D60BF9;
	Wed, 16 Mar 2022 14:49:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EXjZKeHwX992; Wed, 16 Mar 2022 14:49:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 259FD60ABA;
	Wed, 16 Mar 2022 14:49:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 06A10C0012;
	Wed, 16 Mar 2022 14:49:20 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A459CC000B
 for <iommu@lists.linux-foundation.org>; Wed, 16 Mar 2022 14:49:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 93832841AC
 for <iommu@lists.linux-foundation.org>; Wed, 16 Mar 2022 14:49:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mkrgKBnsrNAr for <iommu@lists.linux-foundation.org>;
 Wed, 16 Mar 2022 14:49:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp1.osuosl.org (Postfix) with ESMTP id C078F82681
 for <iommu@lists.linux-foundation.org>; Wed, 16 Mar 2022 14:49:15 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CE0221476;
 Wed, 16 Mar 2022 07:49:14 -0700 (PDT)
Received: from [10.57.42.204] (unknown [10.57.42.204])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 37FB73F766;
 Wed, 16 Mar 2022 07:49:13 -0700 (PDT)
Message-ID: <16852eb2-98bb-6337-741f-8c2f06418b08@arm.com>
Date: Wed, 16 Mar 2022 14:49:09 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH] thunderbolt: Stop using iommu_present()
Content-Language: en-GB
To: Mika Westerberg <mika.westerberg@linux.intel.com>
References: <b4356b228db9cb88d12db6559e28714ce26e022e.1647429348.git.robin.murphy@arm.com>
 <YjHb1xCx4UAmUjrR@lahna>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <YjHb1xCx4UAmUjrR@lahna>
Cc: michael.jamet@intel.com, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, YehezkelShB@gmail.com,
 iommu@lists.linux-foundation.org, mario.limonciello@amd.com,
 andreas.noever@gmail.com, hch@lst.de
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

On 2022-03-16 12:45, Mika Westerberg wrote:
> Hi Robin,
> 
> On Wed, Mar 16, 2022 at 11:25:51AM +0000, Robin Murphy wrote:
>> Even if an IOMMU might be present for some PCI segment in the system,
>> that doesn't necessarily mean it provides translation for the device
>> we care about. Furthermore, the presence or not of one firmware flag
>> doesn't imply anything about the IOMMU driver's behaviour, which may
>> still depend on other firmware properties and kernel options too. What
>> actually matters is whether an IOMMU is enforcing protection for our
>> device - regardless of whether that stemmed from firmware policy, kernel
>> config, or user control - at the point we need to decide whether to
>> authorise it. We can ascertain that generically by simply looking at
>> whether we're currently attached to a translation domain or not.
>>
>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>> ---
>>
>> I don't have the means to test this, but I'm at least 80% confident
>> in my unpicking of the structures to retrieve the correct device...
>>
>>   drivers/thunderbolt/domain.c | 7 ++++---
>>   1 file changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/thunderbolt/domain.c b/drivers/thunderbolt/domain.c
>> index 7018d959f775..5f5fc5f6a09b 100644
>> --- a/drivers/thunderbolt/domain.c
>> +++ b/drivers/thunderbolt/domain.c
>> @@ -257,13 +257,14 @@ static ssize_t iommu_dma_protection_show(struct device *dev,
>>   					 struct device_attribute *attr,
>>   					 char *buf)
>>   {
>> +	struct tb *tb = container_of(dev, struct tb, dev);
>> +	struct iommu_domain *iod = iommu_get_domain_for_dev(&tb->nhi->pdev->dev);
> 
> I wonder if this is the correct "domain"? I mean it's typically no the
> Thunderbolt controller (here tb->nhi->pdev->dev) that needs the
> protection (although in discrete controllers it does get it too) but
> it's the tunneled PCIe topology that we need to check here.
> 
> For instance in Intel with intergrated Thunderbolt we have topology like
> this:
> 
>    Host bridge
>        |
>        +--- Tunneled PCIe root port #1
>        +--- Tunneled PCIe root port #2
>        +--- Thunderbolt host controller (the NHI above)
>        +--- xHCI
> 
> and In case of discrete controllers it looks like this:
> 
>    Host bridge
>        |
>        +--- PCIe root port #x
>                  |
>                  |
>             PCIe switch upstream port
>                  |
> 	        +--- Tunneled PCIe switch downstream port #1
> 	        +--- Tunneled PCIe switch downstream port #2
>          	+--- Thunderbolt host controller (the NHI above)
>          	+--- xHCI
> 
> What we want is to make sure the Tunneled PCIe ports get the full IOMMU
> protection. In case of the discrete above it is also fine if all the
> devices behind the PCIe root port get the full IOMMU protection. Note in
> the integrated all the devices are "siblings".

Ah, OK, I wasn't aware that the NHI isn't even the right thing in the 
first place :(

Is there an easy way to get from the struct tb to a PCI device 
representing the end of its relevant tunnel, or do we have a circular 
dependency problem where the latter won't appear until we've authorised 
it (and thus the IOMMU layer won't know about it yet either)?

Thanks,
Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
