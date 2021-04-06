Return-Path: <SRS0=NW7i=JD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F51CC43460
	for <iommu@archiver.kernel.org>; Tue,  6 Apr 2021 21:02:57 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8331A61279
	for <iommu@archiver.kernel.org>; Tue,  6 Apr 2021 21:02:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8331A61279
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 445C5414D9;
	Tue,  6 Apr 2021 21:02:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cvaeG0TeTPyL; Tue,  6 Apr 2021 21:02:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id CEF6940FAA;
	Tue,  6 Apr 2021 21:02:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AFBA3C000C;
	Tue,  6 Apr 2021 21:02:53 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 700CDC000A
 for <iommu@lists.linux-foundation.org>; Tue,  6 Apr 2021 21:02:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with UTF8SMTP id 559CB60BD8
 for <iommu@lists.linux-foundation.org>; Tue,  6 Apr 2021 21:02:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=mg.codeaurora.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with UTF8SMTP id ZxrJqoRO1SpH for <iommu@lists.linux-foundation.org>;
 Tue,  6 Apr 2021 21:02:50 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from so254-9.mailgun.net (so254-9.mailgun.net [198.61.254.9])
 by smtp3.osuosl.org (Postfix) with UTF8SMTPS id 924C760BD4
 for <iommu@lists.linux-foundation.org>; Tue,  6 Apr 2021 21:02:47 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1617742970; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=HqAx0tPprMXiVgx2/kurRyvrvq9RbvXj59rddSGDARA=;
 b=JV2LOcT9bQVwdZKhquwJ1kkBC3aFyL2rdjpEHuA66S1znLhyhle4FU+WCdQSHtOSjRbW5MgV
 E6JUgCxdphlJ1CP22yYZMMNhUZn5zf7uXzThqBeRttGBC/eM0dAbuT1aROwaV3u8NJ2sjqkc
 dNtHF8oiKJJyoDEoJNnCcOPjbJM=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3NDkwMCIsICJpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 606ccc632cc44d3aea5d5874 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 06 Apr 2021 21:02:27
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id BBDB0C43465; Tue,  6 Apr 2021 21:02:27 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested) (Authenticated sender: isaacm)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 8B7A7C43461;
 Tue,  6 Apr 2021 21:02:26 +0000 (UTC)
MIME-Version: 1.0
Date: Tue, 06 Apr 2021 14:02:26 -0700
From: isaacm@codeaurora.org
To: Will Deacon <will@kernel.org>
Subject: Re: [RFC PATCH v3 09/12] iommu/io-pgtable-arm: Implement
 arm_lpae_unmap_pages()
In-Reply-To: <20210406121552.GF13747@willie-the-truck>
References: <20210405191112.28192-1-isaacm@codeaurora.org>
 <20210405191112.28192-10-isaacm@codeaurora.org>
 <20210406121552.GF13747@willie-the-truck>
Message-ID: <8f78f5d051c9d40981fc6868c9245cd3@codeaurora.org>
X-Sender: isaacm@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Cc: pratikp@codeaurora.org, iommu@lists.linux-foundation.org,
 robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org
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

On 2021-04-06 05:15, Will Deacon wrote:
> On Mon, Apr 05, 2021 at 12:11:09PM -0700, Isaac J. Manjarres wrote:
>> Implement the unmap_pages() callback for the ARM LPAE io-pgtable
>> format.
>> 
>> Signed-off-by: Isaac J. Manjarres <isaacm@codeaurora.org>
>> Suggested-by: Will Deacon <will@kernel.org>
>> ---
>>  drivers/iommu/io-pgtable-arm.c | 124 
>> +++++++++++++++++++++++++++------
>>  1 file changed, 104 insertions(+), 20 deletions(-)
> 
> [...]
> 
>> +static size_t arm_lpae_unmap_pages(struct io_pgtable_ops *ops, 
>> unsigned long iova,
>> +				   size_t pgsize, size_t pgcount,
>> +				   struct iommu_iotlb_gather *gather)
>> +{
>> +	struct arm_lpae_io_pgtable *data = io_pgtable_ops_to_data(ops);
>> +	struct io_pgtable_cfg *cfg = &data->iop.cfg;
>> +	arm_lpae_iopte *ptep = data->pgd;
>> +	long iaext = (s64)iova >> cfg->ias;
>> +	size_t unmapped = 0, unmapped_page;
>> +	int last_lvl;
>> +	size_t table_size, pages, tbl_offset, max_entries;
>> +
>> +	if (WARN_ON(!pgsize || (pgsize & cfg->pgsize_bitmap) != pgsize || 
>> !pgcount))
>> +		return 0;
>> +
>> +	if (cfg->quirks & IO_PGTABLE_QUIRK_ARM_TTBR1)
>> +		iaext = ~iaext;
>> +	if (WARN_ON(iaext))
>> +		return 0;
>> +
>> +	/*
>> +	 * Calculating the page table size here helps avoid situations where
>> +	 * a page range that is being unmapped may be mapped at the same 
>> level
>> +	 * but not mapped by the same tables. Allowing such a scenario to
>> +	 * occur can complicate the logic in arm_lpae_split_blk_unmap().
>> +	 */
>> +	last_lvl = ARM_LPAE_BLOCK_SIZE_LVL(pgsize, data);
>> +
>> +	if (last_lvl == data->start_level)
>> +		table_size = ARM_LPAE_PGD_SIZE(data);
>> +	else
>> +		table_size = ARM_LPAE_GRANULE(data);
>> +
>> +	max_entries = table_size / sizeof(*ptep);
>> +
>> +	while (pgcount) {
>> +		tbl_offset = ARM_LPAE_LVL_IDX(iova, last_lvl, data);
>> +		pages = min_t(size_t, pgcount, max_entries - tbl_offset);
>> +		unmapped_page = __arm_lpae_unmap(data, gather, iova, pgsize,
>> +						 pages, data->start_level,
>> +						 ptep);
>> +		if (!unmapped_page)
>> +			break;
>> +
>> +		unmapped += unmapped_page;
>> +		iova += unmapped_page;
>> +		pgcount -= pages;
>> +	}
> 
> Robin has some comments on the first version of this patch, and I
> don't think you
> addressed them:
> 
> https://lore.kernel.org/r/b93fa0b1-e2a4-1aad-8b88-4d0dfecdfef7@arm.com
> 
> I'm inclined to agree that iterating here doesn't make a lot of sense 
> --
> we've already come back out of the page-table walk, so I think we 
> should
> just return to the caller (who is well prepared to handle a partial 
> unmap).
> Same for the map side of things.
> 
> If we get numbers showing that this is causing a performance issue, 
> then
> we should rework the page-table code to handle this at the lower level
> (because I doubt the loop that you have is really worse than returning 
> to
> the caller anyway).
> 
Sorry, I seem to have overlooked those comments.

I will go ahead and address them. I think it might be ideal to try to do
as much work as possible in the io-pgtable level, so as to minimize the 
number
of indirect calls incurred by jumping back and forth between iommu fwk, 
iommu
driver, and io-pgtable code.

Perhaps we can try something like how the linear mappings are created on 
arm64 i.e.
on the previous level, we can determine how many pages can be unmapped 
in one page table
in one iteration, and on the subsequent iterations, we can tackle 
another page table at
the lower level. Looking at the code, it doesn't seem too difficult to 
add this in. Thoughts?

Thanks,
Isaac

> Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
