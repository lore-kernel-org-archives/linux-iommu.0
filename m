Return-Path: <SRS0=11OQ=YX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AC61C47E49
	for <iommu@archiver.kernel.org>; Wed, 30 Oct 2019 15:33:31 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B0ED20856
	for <iommu@archiver.kernel.org>; Wed, 30 Oct 2019 15:33:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B0ED20856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id E80E3E71;
	Wed, 30 Oct 2019 15:33:30 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id AC389C8E
	for <iommu@lists.linux-foundation.org>;
	Wed, 30 Oct 2019 15:33:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id 3017863D
	for <iommu@lists.linux-foundation.org>;
	Wed, 30 Oct 2019 15:33:29 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B6D251FB;
	Wed, 30 Oct 2019 08:33:28 -0700 (PDT)
Received: from [10.1.197.57] (e110467-lin.cambridge.arm.com [10.1.197.57])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CD6F23F6C4;
	Wed, 30 Oct 2019 08:33:27 -0700 (PDT)
Subject: Re: [PATCH 7/7] iommu/arm-smmu: Allow building as a module
To: Rob Herring <robh@kernel.org>, Will Deacon <will@kernel.org>
References: <20191030145112.19738-1-will@kernel.org>
	<20191030145112.19738-8-will@kernel.org>
	<20191030152212.ifzhl2w3knapc367@bogus>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <9ffbf469-83a7-4ebb-504c-ac17c2f526cc@arm.com>
Date: Wed, 30 Oct 2019 15:33:26 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20191030152212.ifzhl2w3knapc367@bogus>
Content-Language: en-GB
Cc: Bjorn Helgaas <bhelgaas@google.com>, iommu@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On 30/10/2019 15:22, Rob Herring wrote:
> On Wed, Oct 30, 2019 at 02:51:12PM +0000, Will Deacon wrote:
>> By conditionally dropping support for the legacy binding and exporting
>> the newly introduced 'arm_smmu_impl_init()' function we can allow the
>> ARM SMMU driver to be built as a module.
>>
>> Signed-off-by: Will Deacon <will@kernel.org>
>> ---
>>   drivers/iommu/Kconfig         | 14 ++++++++-
>>   drivers/iommu/arm-smmu-impl.c |  6 ++++
>>   drivers/iommu/arm-smmu.c      | 54 +++++++++++++++++++++--------------
>>   3 files changed, 51 insertions(+), 23 deletions(-)
>>
>> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
>> index 7583d47fc4d5..02703f51e533 100644
>> --- a/drivers/iommu/Kconfig
>> +++ b/drivers/iommu/Kconfig
>> @@ -350,7 +350,7 @@ config SPAPR_TCE_IOMMU
>>   
>>   # ARM IOMMU support
>>   config ARM_SMMU
>> -	bool "ARM Ltd. System MMU (SMMU) Support"
>> +	tristate "ARM Ltd. System MMU (SMMU) Support"
>>   	depends on (ARM64 || ARM) && MMU
>>   	select IOMMU_API
>>   	select IOMMU_IO_PGTABLE_LPAE
>> @@ -362,6 +362,18 @@ config ARM_SMMU
>>   	  Say Y here if your SoC includes an IOMMU device implementing
>>   	  the ARM SMMU architecture.
>>   
>> +config ARM_SMMU_LEGACY_DT_BINDINGS
>> +	bool "Support the legacy \"mmu-masters\" devicetree bindings"
> 
> Can't we just remove this now? The only user is Seattle. Is anyone still
> using Seattle AND DT? There's been no real dts change since Feb '16.
> There's a bit of clean-up needed in the Seattle dts files, so I'd like
> to remove them if there's not users.
> 
> If there are users, can't we just make them move to the new binding?
> Yes compatibility, but that really depends on the users caring.

Apparently it's also in the wild on Cavium ThunderX/OcteonTX machines as 
well :(

> I though Calxeda was using this too, but I guess we didn't get that
> finished. We should probably remove that secure mode flag as well.

FWIW the secure quirk still comes in useful every now and then when 
people prototype stuff on 32-bit VExpress, where it turns out an SMMU is 
about the only thing which cares whether you're running Linux in Secure 
mode or not.

Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
