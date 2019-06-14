Return-Path: <SRS0=ZdmF=UN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BB2CC31E4D
	for <iommu@archiver.kernel.org>; Fri, 14 Jun 2019 15:16:49 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DE0A217D6
	for <iommu@archiver.kernel.org>; Fri, 14 Jun 2019 15:16:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DE0A217D6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 4DF0C13BE;
	Fri, 14 Jun 2019 15:16:49 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 4A50013A6
	for <iommu@lists.linux-foundation.org>;
	Fri, 14 Jun 2019 15:16:48 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from eu-smtp-delivery-151.mimecast.com
	(eu-smtp-delivery-151.mimecast.com [207.82.80.151])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id 7EA3C775
	for <iommu@lists.linux-foundation.org>;
	Fri, 14 Jun 2019 15:16:47 +0000 (UTC)
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
	TLS) by relay.mimecast.com with ESMTP id
	uk-mta-68-X-FdWeQ3PqmiCOAg4_EgNg-1; Fri, 14 Jun 2019 16:16:44 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
	AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft
	SMTP Server (TLS) id 15.0.1347.2; Fri, 14 Jun 2019 16:16:43 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
	AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id
	15.00.1347.000; Fri, 14 Jun 2019 16:16:43 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: 'Robin Murphy' <robin.murphy@arm.com>, 'Christoph Hellwig' <hch@lst.de>
Subject: RE: [PATCH 16/16] dma-mapping: use exact allocation in
	dma_alloc_contiguous
Thread-Topic: [PATCH 16/16] dma-mapping: use exact allocation in
	dma_alloc_contiguous
Thread-Index: AQHVIrfpTFjppS25RkWUhwqPPyqZ4qabLzdwgAAQm/2AAAIJEA==
Date: Fri, 14 Jun 2019 15:16:43 +0000
Message-ID: <d8009432a10549bbbda802021562a28b@AcuMS.aculab.com>
References: <20190614134726.3827-1-hch@lst.de>
	<20190614134726.3827-17-hch@lst.de>
	<a90cf7ec5f1c4166b53c40e06d4d832a@AcuMS.aculab.com>
	<20190614145001.GB9088@lst.de>
	<4113cd5f-5c13-e9c7-bc5e-dcf0b60e7054@arm.com>
In-Reply-To: <4113cd5f-5c13-e9c7-bc5e-dcf0b60e7054@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: X-FdWeQ3PqmiCOAg4_EgNg-1
X-Mimecast-Spam-Score: 0
Cc: Maxime Ripard <maxime.ripard@bootlin.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
	"linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	David Airlie <airlied@linux.ie>,
	"linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
	Intel Linux Wireless <linuxwifi@intel.com>,
	"intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Jani Nikula <jani.nikula@linux.intel.com>, Ian Abbott <abbotti@mev.co.uk>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Sean Paul <sean@poorly.run>, "moderated list:ARM
	PORT" <linux-arm-kernel@lists.infradead.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	H Hartley Sweeten <hsweeten@visionengravers.com>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	Daniel Vetter <daniel@ffwll.ch>
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

From: Robin Murphy
> Sent: 14 June 2019 16:06
...
> Well, apart from the bit in DMA-API-HOWTO which has said this since
> forever (well, before Git history, at least):
> 
> "The CPU virtual address and the DMA address are both
> guaranteed to be aligned to the smallest PAGE_SIZE order which
> is greater than or equal to the requested size.  This invariant
> exists (for example) to guarantee that if you allocate a chunk
> which is smaller than or equal to 64 kilobytes, the extent of the
> buffer you receive will not cross a 64K boundary."

I knew it was somewhere :-)
Interestingly that also implies that the address returned for a size
of (say) 128 will also be page aligned.
In that case 128 byte alignment should probably be ok - but it is still
an API change that could have horrid consequences.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
