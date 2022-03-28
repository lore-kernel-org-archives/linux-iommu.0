Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2087C43219
	for <iommu@archiver.kernel.org>; Mon, 28 Mar 2022 08:15:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 78E6641752;
	Mon, 28 Mar 2022 08:15:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id m8grCly1J0S7; Mon, 28 Mar 2022 08:15:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 512B04174F;
	Mon, 28 Mar 2022 08:15:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2FAFEC001D;
	Mon, 28 Mar 2022 08:15:40 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1B5F0C0012
 for <iommu@lists.linux-foundation.org>; Mon, 28 Mar 2022 08:15:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id ECBFE40189
 for <iommu@lists.linux-foundation.org>; Mon, 28 Mar 2022 08:15:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EfKBXB2SRV-X for <iommu@lists.linux-foundation.org>;
 Mon, 28 Mar 2022 08:15:38 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from eu-smtp-delivery-151.mimecast.com
 (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9431B40186
 for <iommu@lists.linux-foundation.org>; Mon, 28 Mar 2022 08:15:37 +0000 (UTC)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-82-73TuQx5vMi6TZZlGtDoZUA-1; Mon, 28 Mar 2022 09:15:33 +0100
X-MC-Unique: 73TuQx5vMi6TZZlGtDoZUA-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.32; Mon, 28 Mar 2022 09:15:29 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.033; Mon, 28 Mar 2022 09:15:29 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: 'Christoph Hellwig' <hch@lst.de>, Linus Torvalds
 <torvalds@linux-foundation.org>
Subject: RE: [REGRESSION] Recent swiotlb DMA_FROM_DEVICE fixes break
 ath9k-based AP
Thread-Topic: [REGRESSION] Recent swiotlb DMA_FROM_DEVICE fixes break
 ath9k-based AP
Thread-Index: AQHYQm5IK/9JYQDqEEKfLChLw6SC36zUb2Ng
Date: Mon, 28 Mar 2022 08:15:29 +0000
Message-ID: <eb33d98e65104d98abf9bd752787a9ea@AcuMS.aculab.com>
References: <1812355.tdWV9SEqCh@natalenko.name>
 <CAHk-=wiwz+Z2MaP44h086jeniG-OpK3c=FywLsCwXV7Crvadrg@mail.gmail.com>
 <27b5a287-7a33-9a8b-ad6d-04746735fb0c@arm.com>
 <CAHk-=wip7TCD_+2STTepuEZvGMg6wcz+o=kyFUvHjuKziTMixw@mail.gmail.com>
 <f88ca616-96d1-82dc-1bc8-b17480e937dd@arm.com>
 <20220324190216.0efa067f.pasic@linux.ibm.com> <20220325163204.GB16426@lst.de>
 <87y20x7vaz.fsf@toke.dk> <e077b229-c92b-c9a6-3581-61329c4b4a4b@arm.com>
 <CAHk-=wgKF5GfLXyVGDQDifh0MpMccDdmBvJBG3dt2+idCa5DzQ@mail.gmail.com>
 <20220328063723.GA29405@lst.de>
In-Reply-To: <20220328063723.GA29405@lst.de>
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
Cc: =?iso-8859-1?Q?Toke_H=F8iland-J=F8rgensen?= <toke@toke.dk>,
 Netdev <netdev@vger.kernel.org>, Kalle Valo <kvalo@kernel.org>,
 linux-wireless <linux-wireless@vger.kernel.org>,
 Oleksandr Natalenko <oleksandr@natalenko.name>,
 stable <stable@vger.kernel.org>, Linux
 Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Halil Pasic <pasic@linux.ibm.com>, iommu <iommu@lists.linux-foundation.org>,
 Olha Cherevyk <olha.cherevyk@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Robin Murphy <robin.murphy@arm.com>, "David
 S. Miller" <davem@davemloft.net>
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
> Sent: 28 March 2022 07:37
> 
> On Fri, Mar 25, 2022 at 11:46:09AM -0700, Linus Torvalds wrote:
> > I think my list of three different sync cases (not just two! It's not
> > just about whether to sync for the CPU or the device, it's also about
> > what direction the data itself is taking) is correct.
> >
> > But maybe I'm wrong.
> 
> At the high level you are correct.  It is all about which direction
> the data is taking.  That is the direction argument that all the
> map/unmap/sync call take.  The sync calls then just toggle the ownership.
> You seem to hate that ownership concept, but I don't see how things
> could work without that ownership concept as we're going to be in
> trouble without having that.  And yes, a peek operation could work in
> some cases, but it would have to be at the cache line granularity.

I don't think it is really 'ownership' but more about who has
write access.
Only one side can have write access (to a cache line [1]) at any
one time.

Read access is different.
You need a 'synchronise' action to pick up newly written data.
This might be a data copy, cache flush or cache invalidate.
It only need affect the area that needs to be read - not
full buffer.
Partial cache flush/invalidate will almost certainly speed
up receipt of short network packets that are copied into a
new skb - leaving the old one mapped for another receive.

[1] The cache line size might be a property of the device
and dma subsystem, not just the cpu.
I have used hardware when the effective size was 1kB.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
