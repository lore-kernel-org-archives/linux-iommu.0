Return-Path: <SRS0=aFDh=SL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23FA6C10F0E
	for <iommu@archiver.kernel.org>; Tue,  9 Apr 2019 17:23:25 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E56972084F
	for <iommu@archiver.kernel.org>; Tue,  9 Apr 2019 17:23:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E56972084F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 9E8E6DDC;
	Tue,  9 Apr 2019 17:23:23 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id B14A1DD2
	for <iommu@lists.linux-foundation.org>;
	Tue,  9 Apr 2019 17:23:22 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 52FD27A6
	for <iommu@lists.linux-foundation.org>;
	Tue,  9 Apr 2019 17:23:22 +0000 (UTC)
Received: by newverein.lst.de (Postfix, from userid 2407)
	id A9F2B68B02; Tue,  9 Apr 2019 19:23:09 +0200 (CEST)
Date: Tue, 9 Apr 2019 19:23:09 +0200
From: Christoph Hellwig <hch@lst.de>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 07/21] dma-iommu: move the arm64 wrappers to common code
Message-ID: <20190409172309.GD14679@lst.de>
References: <20190327080448.5500-1-hch@lst.de>
	<20190327080448.5500-8-hch@lst.de>
	<67573dd3-72c7-692d-bc1a-7edb49ff9551@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <67573dd3-72c7-692d-bc1a-7edb49ff9551@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: Tom Lendacky <thomas.lendacky@amd.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org, Christoph Hellwig <hch@lst.de>,
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190409172309.SXxwe-a9C8OLiO1F10YvjSWYI5szgO3zCFJIIf20hjE@z>

On Tue, Apr 09, 2019 at 04:07:02PM +0100, Robin Murphy wrote:
>> -static inline int iommu_dma_init(void)
>> +static inline void iommu_setup_dma_ops(struct device *dev, u64 dma_base,
>> +		u64 size, const struct iommu_ops *ops)
>>   {
>> -	return 0;
>>   }
>
> I don't think it makes sense to have a stub for that - AFAICS it should 
> only ever be called form arch code with an inherent "select IOMMU_DMA" 
> (much like the stuff which isn't stubbed currently).
>
> Otherwise, I'm about 97% sure the rest of the move looks OK - thanks for 
> splitting things up.

arm64 only selects IOMMU_DMA if IOMMU_SUPPORT is selected, which can
be disabled.  So to keep some (unusual) arm64 configs compiling we'll need
the stub..
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
