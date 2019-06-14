Return-Path: <SRS0=ZdmF=UN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0584C31E4B
	for <iommu@archiver.kernel.org>; Fri, 14 Jun 2019 14:17:03 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCA5621537
	for <iommu@archiver.kernel.org>; Fri, 14 Jun 2019 14:17:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCA5621537
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 94C80117E;
	Fri, 14 Jun 2019 14:17:03 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 16FE31153
	for <iommu@lists.linux-foundation.org>;
	Fri, 14 Jun 2019 14:17:03 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from eu-smtp-delivery-151.mimecast.com
	(eu-smtp-delivery-151.mimecast.com [207.82.80.151])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id 473EBE5
	for <iommu@lists.linux-foundation.org>;
	Fri, 14 Jun 2019 14:17:02 +0000 (UTC)
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
	TLS) by relay.mimecast.com with ESMTP id
	uk-mta-171-6ZL5OlDfPHWG6RvRpXiEQg-1; Fri, 14 Jun 2019 15:15:45 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
	AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft
	SMTP Server (TLS) id 15.0.1347.2; Fri, 14 Jun 2019 15:15:44 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
	AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id
	15.00.1347.000; Fri, 14 Jun 2019 15:15:44 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: 'Christoph Hellwig' <hch@lst.de>, Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>, Maxime Ripard
	<maxime.ripard@bootlin.com>, Sean Paul <sean@poorly.run>, David Airlie
	<airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Jani Nikula
	<jani.nikula@linux.intel.com>, Joonas Lahtinen
	<joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
	"Ian Abbott" <abbotti@mev.co.uk>, H Hartley Sweeten
	<hsweeten@visionengravers.com>
Subject: RE: [PATCH 16/16] dma-mapping: use exact allocation in
	dma_alloc_contiguous
Thread-Topic: [PATCH 16/16] dma-mapping: use exact allocation in
	dma_alloc_contiguous
Thread-Index: AQHVIrfpTFjppS25RkWUhwqPPyqZ4qabLzdw
Date: Fri, 14 Jun 2019 14:15:44 +0000
Message-ID: <a90cf7ec5f1c4166b53c40e06d4d832a@AcuMS.aculab.com>
References: <20190614134726.3827-1-hch@lst.de>
	<20190614134726.3827-17-hch@lst.de>
In-Reply-To: <20190614134726.3827-17-hch@lst.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: 6ZL5OlDfPHWG6RvRpXiEQg-1
X-Mimecast-Spam-Score: 0
Cc: "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
	"linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
	Intel Linux Wireless <linuxwifi@intel.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	"moderated list:ARM PORT" <linux-arm-kernel@lists.infradead.org>,
	"linux-media@vger.kernel.org" <linux-media@vger.kernel.org>
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

From: Christoph Hellwig
> Sent: 14 June 2019 14:47
> 
> Many architectures (e.g. arm, m68 and sh) have always used exact
> allocation in their dma coherent allocator, which avoids a lot of
> memory waste especially for larger allocations.  Lift this behavior
> into the generic allocator so that dma-direct and the generic IOMMU
> code benefit from this behavior as well.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  include/linux/dma-contiguous.h |  8 +++++---
>  kernel/dma/contiguous.c        | 17 +++++++++++------
>  2 files changed, 16 insertions(+), 9 deletions(-)
> 
> diff --git a/include/linux/dma-contiguous.h b/include/linux/dma-contiguous.h
> index c05d4e661489..2e542e314acf 100644
> --- a/include/linux/dma-contiguous.h
> +++ b/include/linux/dma-contiguous.h
> @@ -161,15 +161,17 @@ static inline struct page *dma_alloc_contiguous(struct device *dev, size_t size,
>  		gfp_t gfp)
>  {
>  	int node = dev ? dev_to_node(dev) : NUMA_NO_NODE;
> -	size_t align = get_order(PAGE_ALIGN(size));
> +	void *cpu_addr = alloc_pages_exact_node(node, size, gfp);
> 
> -	return alloc_pages_node(node, gfp, align);
> +	if (!cpu_addr)
> +		return NULL;
> +	return virt_to_page(p);
>  }

Does this still guarantee that requests for 16k will not cross a 16k boundary?
It looks like you are losing the alignment parameter.

There may be drivers and hardware that also require 12k allocates
to not cross 16k boundaries (etc).

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
