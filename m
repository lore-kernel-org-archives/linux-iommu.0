Return-Path: <SRS0=5edT=4J=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84452C35657
	for <iommu@archiver.kernel.org>; Fri, 21 Feb 2020 14:17:10 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55132222C4
	for <iommu@archiver.kernel.org>; Fri, 21 Feb 2020 14:17:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55132222C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 206852206E;
	Fri, 21 Feb 2020 14:17:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1UHYjav09G-c; Fri, 21 Feb 2020 14:17:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 93B7F220C2;
	Fri, 21 Feb 2020 14:17:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 79DCCC07FE;
	Fri, 21 Feb 2020 14:17:05 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 91FA2C013E
 for <iommu@lists.linux-foundation.org>; Fri, 21 Feb 2020 14:17:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 7ABBF86FEF
 for <iommu@lists.linux-foundation.org>; Fri, 21 Feb 2020 14:17:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4h2hTH2P2+Lx for <iommu@lists.linux-foundation.org>;
 Fri, 21 Feb 2020 14:17:02 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 0C3CF868E7
 for <iommu@lists.linux-foundation.org>; Fri, 21 Feb 2020 14:17:02 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id 36BC968BFE; Fri, 21 Feb 2020 15:16:57 +0100 (CET)
Date: Fri, 21 Feb 2020 15:16:56 +0100
From: Christoph Hellwig <hch@lst.de>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 1/2] dma-mapping: support setting memory uncached in place
Message-ID: <20200221141656.GF6968@lst.de>
References: <20200220170139.387354-1-hch@lst.de>
 <20200220170139.387354-2-hch@lst.de>
 <502fa745-ddad-f91b-52bc-52edecf8fdbc@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <502fa745-ddad-f91b-52bc-52edecf8fdbc@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: Jonas Bonn <jonas@southpole.se>, Mark Rutland <mark.rutland@arm.com>,
 linux-kernel@vger.kernel.org,
 Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
 iommu@lists.linux-foundation.org, openrisc@lists.librecores.org,
 linux-arch@vger.kernel.org, Stafford Horne <shorne@gmail.com>,
 Will Deacon <will@kernel.org>, Christoph Hellwig <hch@lst.de>,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Thu, Feb 20, 2020 at 05:21:35PM +0000, Robin Murphy wrote:
>> @@ -196,10 +192,15 @@ void *dma_direct_alloc_pages(struct device *dev, size_t size,
>>     	memset(ret, 0, size);
>>   -	if (IS_ENABLED(CONFIG_ARCH_HAS_UNCACHED_SEGMENT) &&
>> -	    dma_alloc_need_uncached(dev, attrs)) {
>> +	if (dma_alloc_need_uncached(dev, attrs)) {
>>   		arch_dma_prep_coherent(page, size);
>> -		ret = uncached_kernel_address(ret);
>> +
>> +		if (IS_ENABLED(CONFIG_ARCH_HAS_DMA_SET_UNCACHED)) {
>> +			if (!arch_dma_set_uncached(ret, size))
>> +				goto out_free_pages;
>> +		} else if (IS_ENABLED(CONFIG_ARCH_HAS_UNCACHED_SEGMENT)) {
>> +			ret = uncached_kernel_address(ret);
>
> Hmm, would we actually need to keep ARCH_HAS_UNCACHED_SEGMENT? If 
> arch_dma_set_uncached() returned void*/ERR_PTR instead, then it could work 
> for both cases (with arch_dma_clear_uncached() being a no-op for segments).

Yes, I think so.  I was a little worried about what to do with
cached_kernel_address() in that scheme, but it turns out with the recent
round of dma-direct cleanup that is actually entirely unused now.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
