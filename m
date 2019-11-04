Return-Path: <SRS0=uwQI=Y4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B6DDCA9EB5
	for <iommu@archiver.kernel.org>; Mon,  4 Nov 2019 18:37:00 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E0802089C
	for <iommu@archiver.kernel.org>; Mon,  4 Nov 2019 18:37:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E0802089C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id E4BAFEC3;
	Mon,  4 Nov 2019 18:36:59 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id AA71EEC1
	for <iommu@lists.linux-foundation.org>;
	Mon,  4 Nov 2019 18:36:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id 27160A9
	for <iommu@lists.linux-foundation.org>;
	Mon,  4 Nov 2019 18:36:58 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5B3091F1;
	Mon,  4 Nov 2019 10:36:57 -0800 (PST)
Received: from [10.1.196.37] (e121345-lin.cambridge.arm.com [10.1.196.37])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BB33F3F71A;
	Mon,  4 Nov 2019 10:36:56 -0800 (PST)
Subject: Re: [PATCH v2 06/10] iommu/io-pgtable-arm: Simplify level indexing
To: Will Deacon <will@kernel.org>
References: <cover.1572024119.git.robin.murphy@arm.com>
	<698173b487383735e470a28e5cca4f9db22703de.1572024120.git.robin.murphy@arm.com>
	<20191104181722.GF24909@willie-the-truck>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <f39248b0-b70e-4138-3eb9-81ce2cfbee4b@arm.com>
Date: Mon, 4 Nov 2019 18:36:51 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
	Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191104181722.GF24909@willie-the-truck>
Content-Language: en-GB
Cc: iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org
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

On 04/11/2019 18:17, Will Deacon wrote:
> On Fri, Oct 25, 2019 at 07:08:35PM +0100, Robin Murphy wrote:
>> The nature of the LPAE format means that data->pg_shift is always
>> redundant with data->bits_per_level, since they represent the size of a
>> page and the number of PTEs per page respectively, and the size of a PTE
>> is constant. Thus it works out more efficient to only store the latter,
>> and derive the former via a trivial addition where necessary.
>>
>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>> ---
>>   drivers/iommu/io-pgtable-arm.c | 29 +++++++++++++----------------
>>   1 file changed, 13 insertions(+), 16 deletions(-)
>>
>> diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
>> index 4b1483eb0ccf..15b4927ce36b 100644
>> --- a/drivers/iommu/io-pgtable-arm.c
>> +++ b/drivers/iommu/io-pgtable-arm.c
>> @@ -36,10 +36,11 @@
>>    * in a virtual address mapped by the pagetable in d.
>>    */
>>   #define ARM_LPAE_LVL_SHIFT(l,d)						\
>> -	(((ARM_LPAE_MAX_LEVELS - 1 - (l)) * (d)->bits_per_level) +	\
>> -	(d)->pg_shift)
>> +	(((ARM_LPAE_MAX_LEVELS - (l)) * (d)->bits_per_level) +		\
>> +	ilog2(sizeof(arm_lpae_iopte)))
>>   
>> -#define ARM_LPAE_GRANULE(d)		(1UL << (d)->pg_shift)
>> +#define ARM_LPAE_GRANULE(d)						\
>> +	(sizeof(arm_lpae_iopte) << (d)->bits_per_level)
>>   #define ARM_LPAE_PGD_SIZE(d)						\
>>   	(sizeof(arm_lpae_iopte) << (d)->pgd_bits)
>>   
>> @@ -55,9 +56,7 @@
>>   	 ((1 << ((d)->bits_per_level + ARM_LPAE_PGD_IDX(l,d))) - 1))
>>   
>>   /* Calculate the block/page mapping size at level l for pagetable in d. */
>> -#define ARM_LPAE_BLOCK_SIZE(l,d)					\
>> -	(1ULL << (ilog2(sizeof(arm_lpae_iopte)) +			\
>> -		((ARM_LPAE_MAX_LEVELS - (l)) * (d)->bits_per_level)))
>> +#define ARM_LPAE_BLOCK_SIZE(l,d)	(1ULL << ARM_LPAE_LVL_SHIFT(l,d))
>>   
>>   /* Page table bits */
>>   #define ARM_LPAE_PTE_TYPE_SHIFT		0
>> @@ -175,8 +174,7 @@ struct arm_lpae_io_pgtable {
>>   
>>   	int			pgd_bits;
>>   	int			start_level;
>> -	unsigned long		pg_shift;
>> -	unsigned long		bits_per_level;
>> +	int			bits_per_level;
>>   
>>   	void			*pgd;
>>   };
>> @@ -206,7 +204,7 @@ static phys_addr_t iopte_to_paddr(arm_lpae_iopte pte,
>>   {
>>   	u64 paddr = pte & ARM_LPAE_PTE_ADDR_MASK;
>>   
>> -	if (data->pg_shift < 16)
>> +	if (data->bits_per_level < 13) /* i.e. 64K granule */
> 
> nit, but:
> 
> 	if (ARM_LPAE_GRANULE(data) < SZ_64K)
> 
> might be clearer and avoid the need for a comment?

Unfortunately GCC doesn't treat the two as directly equivalent 
(presumably due to boundary conditions) so will emit the additional faff 
to actually compute and compare the intermediate value every time, 
rather than just trivially testing the shift. I figured the minor 
I$/register pressure win was worth the small price of a comment.

Robin.

> (I can make the change locally if you agree)
> 
> Will
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
