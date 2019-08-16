Return-Path: <SRS0=MJs7=WM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C32CAC3A59E
	for <iommu@archiver.kernel.org>; Fri, 16 Aug 2019 16:43:33 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A491B2171F
	for <iommu@archiver.kernel.org>; Fri, 16 Aug 2019 16:43:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A491B2171F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 7CEE1C77;
	Fri, 16 Aug 2019 16:43:33 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 373D5C21
	for <iommu@lists.linux-foundation.org>;
	Fri, 16 Aug 2019 16:43:32 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id B214BE5
	for <iommu@lists.linux-foundation.org>;
	Fri, 16 Aug 2019 16:43:31 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
	id B7255227A81; Fri, 16 Aug 2019 18:43:28 +0200 (CEST)
Date: Fri, 16 Aug 2019 18:43:28 +0200
From: Christoph Hellwig <hch@lst.de>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 03/11] xen/arm: pass one less argument to dma_cache_maint
Message-ID: <20190816164328.GB3629@lst.de>
References: <20190816130013.31154-1-hch@lst.de>
	<20190816130013.31154-4-hch@lst.de>
	<8585fb27-14e0-888c-6749-6862b4e16418@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <8585fb27-14e0-888c-6749-6862b4e16418@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: Stefano Stabellini <sstabellini@kernel.org>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
	xen-devel@lists.xenproject.org, Christoph Hellwig <hch@lst.de>,
	linux-arm-kernel@lists.infradead.org
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On Fri, Aug 16, 2019 at 02:37:58PM +0100, Robin Murphy wrote:
> On 16/08/2019 14:00, Christoph Hellwig wrote:
>> Instead of taking apart the dma address in both callers do it inside
>> dma_cache_maint itself.
>>
>> Signed-off-by: Christoph Hellwig <hch@lst.de>
>> ---
>>   arch/arm/xen/mm.c | 10 ++++++----
>>   1 file changed, 6 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/arm/xen/mm.c b/arch/arm/xen/mm.c
>> index 90574d89d0d4..d9da24fda2f7 100644
>> --- a/arch/arm/xen/mm.c
>> +++ b/arch/arm/xen/mm.c
>> @@ -43,13 +43,15 @@ static bool hypercall_cflush = false;
>>     /* functions called by SWIOTLB */
>>   -static void dma_cache_maint(dma_addr_t handle, unsigned long offset,
>> -	size_t size, enum dma_data_direction dir, enum dma_cache_op op)
>> +static void dma_cache_maint(dma_addr_t handle, size_t size,
>> +		enum dma_data_direction dir, enum dma_cache_op op)
>>   {
>>   	struct gnttab_cache_flush cflush;
>>   	unsigned long xen_pfn;
>> +	unsigned long offset = handle & ~PAGE_MASK;
>>   	size_t left = size;
>>   +	offset &= PAGE_MASK;
>
> Ahem... presumably that should be handle, not offset.

Ooops, yes.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
