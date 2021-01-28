Return-Path: <SRS0=9w/B=G7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9A1AC433E0
	for <iommu@archiver.kernel.org>; Thu, 28 Jan 2021 15:48:40 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A73364DF9
	for <iommu@archiver.kernel.org>; Thu, 28 Jan 2021 15:48:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A73364DF9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 6701A86B0C;
	Thu, 28 Jan 2021 15:41:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nKiTLE5VxUZI; Thu, 28 Jan 2021 15:41:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id BEE4C86AB2;
	Thu, 28 Jan 2021 15:41:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A7074C0FA7;
	Thu, 28 Jan 2021 15:41:38 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0BBEFC013A
 for <iommu@lists.linux-foundation.org>; Thu, 28 Jan 2021 15:41:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 022AD21503
 for <iommu@lists.linux-foundation.org>; Thu, 28 Jan 2021 15:41:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iPsL6pwiuZzi for <iommu@lists.linux-foundation.org>;
 Thu, 28 Jan 2021 15:41:37 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from eu-smtp-delivery-151.mimecast.com
 (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
 by silver.osuosl.org (Postfix) with ESMTPS id B40E720422
 for <iommu@lists.linux-foundation.org>; Thu, 28 Jan 2021 15:41:36 +0000 (UTC)
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-12-etlw7F1KPkS310PW0vAHjQ-1; Thu, 28 Jan 2021 15:41:31 +0000
X-MC-Unique: etlw7F1KPkS310PW0vAHjQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Thu, 28 Jan 2021 15:41:31 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000; 
 Thu, 28 Jan 2021 15:41:31 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Christoph Hellwig' <hch@lst.de>, Mauro Carvalho Chehab
 <mchehab@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>, "Tomasz
 Figa" <tfiga@chromium.org>, Ricardo Ribalda <ribalda@chromium.org>, "Sergey
 Senozhatsky" <senozhatsky@google.com>, "iommu@lists.linux-foundation.org"
 <iommu@lists.linux-foundation.org>
Subject: RE: [PATCH 2/6] dma-mapping: add a dma_mmap_pages helper
Thread-Topic: [PATCH 2/6] dma-mapping: add a dma_mmap_pages helper
Thread-Index: AQHW9YdDx2Jomxp/n0KiElYHhtkl1qo9KjnA
Date: Thu, 28 Jan 2021 15:41:31 +0000
Message-ID: <792682fa4a97411a8248abeec29b78ee@AcuMS.aculab.com>
References: <20210128145837.2250561-1-hch@lst.de>
 <20210128145837.2250561-3-hch@lst.de>
In-Reply-To: <20210128145837.2250561-3-hch@lst.de>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=C51A453 smtp.mailfrom=david.laight@aculab.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Cc: "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
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

From: Christoph Hellwig
> Sent: 28 January 2021 14:59
> 
> Add a helper to map memory allocated using dma_alloc_pages into
> a user address space, similar to the dma_alloc_attrs function for
> coherent allocations.
> 
...
> +::
> +
> +	int
> +	dma_mmap_pages(struct device *dev, struct vm_area_struct *vma,
> +		       size_t size, struct page *page)
> +
> +Map an allocation returned from dma_alloc_pages() into a user address space.
> +dev and size must be the same as those passed into dma_alloc_pages().
> +page must be the pointer returned by dma_alloc_pages().

To be useful this needs to specify the offset into the user address area.
(ie the offset in the mmap() buffer.)

For example we have an fpga based PCIe card that converts internal
addresses that refer to one of 512 16k 'pages' to 64bit PCIe bus
master addresses.
So it (sort of) contains its own iommu.

So we can allocate (aligned) 16k kernel memory buffers with
dma_alloc_coherent() and make them appear contiguous to the
on-board PCIe bus master users.
We then mmap() them into contiguous user addresses.
So both 'ends' see contiguous addresses without requiring
contiguous physical memory or requiring all the memory be 
allocated at the same time.

Clearly in-kernel users have to allow for the 16k boundaries.
But the large structures are accesses from user space.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
