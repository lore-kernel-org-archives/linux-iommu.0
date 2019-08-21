Return-Path: <SRS0=Juc9=WR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF742C3A59E
	for <iommu@archiver.kernel.org>; Wed, 21 Aug 2019 12:33:27 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B23372341D
	for <iommu@archiver.kernel.org>; Wed, 21 Aug 2019 12:33:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B23372341D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 7F0F2FC2;
	Wed, 21 Aug 2019 12:33:27 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id C7434FC1
	for <iommu@lists.linux-foundation.org>;
	Wed, 21 Aug 2019 12:33:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id 2FE6289E
	for <iommu@lists.linux-foundation.org>;
	Wed, 21 Aug 2019 12:33:26 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C9A61344;
	Wed, 21 Aug 2019 05:33:25 -0700 (PDT)
Received: from [10.1.197.57] (e110467-lin.cambridge.arm.com [10.1.197.57])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 01B073F718;
	Wed, 21 Aug 2019 05:33:23 -0700 (PDT)
Subject: Re: [PATCH 10/13] iommu/io-pgtable: Replace ->tlb_add_flush() with
	->tlb_add_page()
To: Will Deacon <will@kernel.org>
References: <20190814175634.21081-1-will@kernel.org>
	<20190814175634.21081-11-will@kernel.org>
	<6e54ef6f-75e6-dd80-e524-b726483c88cd@arm.com>
	<20190821120512.4ihfyh4eqsnst6xh@willie-the-truck>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <279efc69-6ddb-14ce-01c1-3cc8b4bbf206@arm.com>
Date: Wed, 21 Aug 2019 13:33:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190821120512.4ihfyh4eqsnst6xh@willie-the-truck>
Content-Language: en-GB
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Vijay Kilary <vkilari@codeaurora.org>,
	Jon Masters <jcm@redhat.com>, Jan Glauber <jglauber@marvell.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	iommu@lists.linux-foundation.org,
	Jayachandran Chandrasekharan Nair <jnair@marvell.com>,
	David Woodhouse <dwmw2@infradead.org>
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

On 21/08/2019 13:05, Will Deacon wrote:
> Hi Robin,
> 
> Thanks for looking at this.
> 
> On Wed, Aug 21, 2019 at 12:42:11PM +0100, Robin Murphy wrote:
>> On 14/08/2019 18:56, Will Deacon wrote:
>>> The ->tlb_add_flush() callback in the io-pgtable API now looks a bit
>>> silly:
>>>
>>>     - It takes a size and a granule, which are always the same
>>>     - It takes a 'bool leaf', which is always true
>>>     - It only ever flushes a single page
>>>
>>> With that in mind, replace it with an optional ->tlb_add_page() callback
>>> that drops the useless parameters.
>>>
>>> Signed-off-by: Will Deacon <will@kernel.org>
> 
> [...]
> 
>>> -static const struct iommu_flush_ops arm_smmu_s2_tlb_ops_v2 = {
>>> -	.tlb_flush_all	= arm_smmu_tlb_inv_context_s2,
>>> -	.tlb_flush_walk	= arm_smmu_tlb_inv_walk,
>>> -	.tlb_flush_leaf	= arm_smmu_tlb_inv_leaf,
>>> -	.tlb_add_flush	= arm_smmu_tlb_inv_range_nosync,
>>> -	.tlb_sync	= arm_smmu_tlb_sync_context,
>>> +static const struct arm_smmu_flush_ops arm_smmu_s2_tlb_ops_v2 = {
>>> +	.tlb = {
>>> +		.tlb_flush_all	= arm_smmu_tlb_inv_context_s2,
>>> +		.tlb_flush_walk	= arm_smmu_tlb_inv_walk,
>>> +		.tlb_flush_leaf	= arm_smmu_tlb_inv_leaf,
>>> +		.tlb_add_page	= arm_smmu_tlb_add_page,
>>> +		.tlb_sync	= arm_smmu_tlb_sync_context,
>>> +	},
>>> +	.tlb_inv_range		= arm_smmu_tlb_inv_range_nosync,
>>>    };
>>> -static const struct iommu_flush_ops arm_smmu_s2_tlb_ops_v1 = {
>>> -	.tlb_flush_all	= arm_smmu_tlb_inv_context_s2,
>>> -	.tlb_flush_walk	= arm_smmu_tlb_inv_walk,
>>> -	.tlb_flush_leaf	= arm_smmu_tlb_inv_leaf,
>>> -	.tlb_add_flush	= arm_smmu_tlb_inv_vmid_nosync,
>>> -	.tlb_sync	= arm_smmu_tlb_sync_vmid,
>>> +static const struct arm_smmu_flush_ops arm_smmu_s2_tlb_ops_v1 = {
>>> +	.tlb = {
>>> +		.tlb_flush_all	= arm_smmu_tlb_inv_context_s2,
>>> +		.tlb_flush_walk	= arm_smmu_tlb_inv_walk,
>>> +		.tlb_flush_leaf	= arm_smmu_tlb_inv_leaf,
>>
>> Urgh, that ain't right... :(
>>
>> Sorry I've only spotted it now while trying to rebase onto Joerg's queue,
>> but we can't use either of those callbacks for v1 stage 2 since the
>> registers they access don't exist. I'll spin a fixup patch first, then come
>> back to the question of whether it's more practical to attempt merging my v2
>> or concede to rebasing a v3.
> 
> Although the code is quite difficult to follow, I think it's alright because
> the tlb_flush_{walk,leaf} functions just indirect back through the
> tlb_inv_range callback. This patch is supposed to be a big NOP moving
> drivers over to the new API, but not actually exploiting its benefits.

Ah, sorry, I did indeed fail the reading comprehension test - too many 
levels of indirection...

On second reading I agree that this probably should work out OK (other 
than perhaps a performance hit from chaining more indirect branches). 
I've noted on my to-do list to come back and clean up arm_smmu_flush_ops 
for next cycle, but for now I'll get back to the more pressing matters.

Thanks,
Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
