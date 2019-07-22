Return-Path: <SRS0=E6XH=VT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74D91C76188
	for <iommu@archiver.kernel.org>; Mon, 22 Jul 2019 15:46:13 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 548692171F
	for <iommu@archiver.kernel.org>; Mon, 22 Jul 2019 15:46:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 548692171F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id A9884D93;
	Mon, 22 Jul 2019 15:46:08 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id C11ABD1A;
	Mon, 22 Jul 2019 15:46:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 8516D224;
	Mon, 22 Jul 2019 15:46:06 +0000 (UTC)
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1BC5F3082AF2;
	Mon, 22 Jul 2019 15:46:06 +0000 (UTC)
Received: from [10.36.116.45] (ovpn-116-45.ams2.redhat.com [10.36.116.45])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id A6C3E5C21F;
	Mon, 22 Jul 2019 15:46:01 +0000 (UTC)
Subject: Re: [PATCH 1/2] dma-mapping: Protect dma_addressing_limited against
	NULL dma_mask
To: Christoph Hellwig <hch@lst.de>
References: <20190722145509.1284-1-eric.auger@redhat.com>
	<20190722145509.1284-2-eric.auger@redhat.com>
	<20190722152637.GA3780@lst.de>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <e1e02286-ccf9-3335-28c8-0c6b122b05a1@redhat.com>
Date: Mon, 22 Jul 2019 17:46:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190722152637.GA3780@lst.de>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.45]);
	Mon, 22 Jul 2019 15:46:06 +0000 (UTC)
Cc: mst@redhat.com, jasowang@redhat.com, linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	iommu@lists.linux-foundation.org, eric.auger.pro@gmail.com,
	robin.murphy@arm.com
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

Hi Christoph,

On 7/22/19 5:26 PM, Christoph Hellwig wrote:
>>  static inline bool dma_addressing_limited(struct device *dev)
>>  {
>> -	return min_not_zero(*dev->dma_mask, dev->bus_dma_mask) <
>> -		dma_get_required_mask(dev);
>> +	return WARN_ON_ONCE(!dev->dma_mask) ? false :
>> +		min_not_zero(*dev->dma_mask, dev->bus_dma_mask) <
>> +			dma_get_required_mask(dev);
> 
> This should really use a separate if statement, but I can fix that
> up when applying it.
> 
Just wondering why we don't use the dma_get_mask() accessor which
returns DMA_BIT_MASK(32) in case the dma_mask is not set.

Do you foresee any issue and would it still mandate to add dma_mask
checks on each call sites?

Thanks

Eric
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
