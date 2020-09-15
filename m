Return-Path: <SRS0=AdPL=CY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 258D6C43461
	for <iommu@archiver.kernel.org>; Tue, 15 Sep 2020 15:09:41 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 523EF20770
	for <iommu@archiver.kernel.org>; Tue, 15 Sep 2020 15:09:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 523EF20770
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id C82F0863E3;
	Tue, 15 Sep 2020 15:09:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7G0HlyGljuHL; Tue, 15 Sep 2020 15:09:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 0EC4F863FF;
	Tue, 15 Sep 2020 15:09:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EDD66C0864;
	Tue, 15 Sep 2020 15:09:37 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E3189C0051
 for <iommu@lists.linux-foundation.org>; Tue, 15 Sep 2020 15:09:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id C5E702052E
 for <iommu@lists.linux-foundation.org>; Tue, 15 Sep 2020 15:09:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MhSiHfsHwHUX for <iommu@lists.linux-foundation.org>;
 Tue, 15 Sep 2020 15:09:34 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by silver.osuosl.org (Postfix) with ESMTPS id 327B0204B0
 for <iommu@lists.linux-foundation.org>; Tue, 15 Sep 2020 15:09:34 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id 8D42568AFE; Tue, 15 Sep 2020 17:09:30 +0200 (CEST)
Date: Tue, 15 Sep 2020 17:09:29 +0200
From: Christoph Hellwig <hch@lst.de>
To: Thomas Tai <thomas.tai@oracle.com>
Subject: Re: [PATCH] dma-direct: Fix potential NULL pointer dereference
Message-ID: <20200915150929.GA19770@lst.de>
References: <1600178594-22801-1-git-send-email-thomas.tai@oracle.com>
 <20200915140719.GA14831@lst.de>
 <f5cba632-421a-f375-3697-51a182a53a32@oracle.com>
 <20200915142624.GA16005@lst.de>
 <da9ec51d-aab5-695d-e388-5ae7c0bb30ea@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <da9ec51d-aab5-695d-e388-5ae7c0bb30ea@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: konrad.wilk@oracle.com, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, robin.murphy@arm.com,
 Christoph Hellwig <hch@lst.de>
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

On Tue, Sep 15, 2020 at 10:40:39AM -0400, Thomas Tai wrote:
>> +++ b/include/linux/dma-direct.h
>> @@ -62,9 +62,6 @@ static inline bool dma_capable(struct device *dev, dma_addr_t addr, size_t size,
>>   {
>>   	dma_addr_t end = addr + size - 1;
>>   -	if (!dev->dma_mask)
>> -		return false;
>> -
>
> I am concerned that some drivers may rely on this NULL checking. Would you 
> think we can keep this checking and use the following WARN_ON_ONCE()?

dma_capable is not a helper for drivers, but just for dma-direct
and related code.  And this patch adds the checks for the three
places how we call into the ->map* methods.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
