Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 503A5C433EF
	for <iommu@archiver.kernel.org>; Fri, 25 Mar 2022 21:40:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E827460BB0;
	Fri, 25 Mar 2022 21:40:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id l9KYwBnkJQ3e; Fri, 25 Mar 2022 21:40:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id A45F960B14;
	Fri, 25 Mar 2022 21:40:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 77E0BC001D;
	Fri, 25 Mar 2022 21:40:27 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EAABAC0012
 for <iommu@lists.linux-foundation.org>; Fri, 25 Mar 2022 21:40:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C5FF240926
 for <iommu@lists.linux-foundation.org>; Fri, 25 Mar 2022 21:40:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TCXoPVwJQqfI for <iommu@lists.linux-foundation.org>;
 Fri, 25 Mar 2022 21:40:26 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from eu-smtp-delivery-151.mimecast.com
 (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A052840906
 for <iommu@lists.linux-foundation.org>; Fri, 25 Mar 2022 21:40:25 +0000 (UTC)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-198-v6S2T8p_MaetwOyqgJM0fQ-1; Fri, 25 Mar 2022 21:40:22 +0000
X-MC-Unique: v6S2T8p_MaetwOyqgJM0fQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.32; Fri, 25 Mar 2022 21:40:20 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.033; Fri, 25 Mar 2022 21:40:20 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Johannes Berg' <johannes@sipsolutions.net>, Linus Torvalds
 <torvalds@linux-foundation.org>
Subject: RE: [REGRESSION] Recent swiotlb DMA_FROM_DEVICE fixes break
 ath9k-based AP
Thread-Topic: [REGRESSION] Recent swiotlb DMA_FROM_DEVICE fixes break
 ath9k-based AP
Thread-Index: AQHYQI1aK/9JYQDqEEKfLChLw6SC36zQnHkQ
Date: Fri, 25 Mar 2022 21:40:20 +0000
Message-ID: <19b4ad5f9909446ea0eca93f9b5b4c40@AcuMS.aculab.com>
References: <1812355.tdWV9SEqCh@natalenko.name>
 <f88ca616-96d1-82dc-1bc8-b17480e937dd@arm.com>
 <20220324055732.GB12078@lst.de> <4386660.LvFx2qVVIh@natalenko.name>
 <81ffc753-72aa-6327-b87b-3f11915f2549@arm.com>
 <878rsza0ih.fsf@toke.dk>
 <4be26f5d8725cdb016c6fdd9d05cfeb69cdd9e09.camel@freebox.fr>
 <20220324163132.GB26098@lst.de>
 <d8a1cbf4-a521-78ec-1560-28d855e0913e@arm.com>
 <871qyr9t4e.fsf@toke.dk>
 <CAHk-=whUQCCaQXJt3KUeQ8mtnLeVXEScNXCp+_DYh2SNY7EcEA@mail.gmail.com>
 <31434708dcad126a8334c99ee056dcce93e507f1.camel@freebox.fr>
 <CAHk-=wippum+MksdY7ixMfa3i1sZ+nxYPWLLpVMNyXCgmiHbBQ@mail.gmail.com>
 <298f4f9ccad7c3308d3a1fd8b4b4740571305204.camel@sipsolutions.net>
 <CAHk-=whXAan2ExANMryPSFaBWeyzikPi+fPUseMoVhQAxR7cEA@mail.gmail.com>
 <e42e4c8bf35b62c671ec20ec6c21a43216e7daa6.camel@sipsolutions.net>
In-Reply-To: <e42e4c8bf35b62c671ec20ec6c21a43216e7daa6.camel@sipsolutions.net>
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
Cc: =?utf-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@toke.dk>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Netdev <netdev@vger.kernel.org>, Kalle Valo <kvalo@kernel.org>,
 linux-wireless <linux-wireless@vger.kernel.org>,
 Oleksandr Natalenko <oleksandr@natalenko.name>,
 stable <stable@vger.kernel.org>, "David
 S. Miller" <davem@davemloft.net>, Halil Pasic <pasic@linux.ibm.com>,
 iommu <iommu@lists.linux-foundation.org>,
 Olha Cherevyk <olha.cherevyk@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 Maxime Bizon <mbizon@freebox.fr>, Paolo
 Abeni <pabeni@redhat.com>, Robin Murphy <robin.murphy@arm.com>,
 Christoph Hellwig <hch@lst.de>, Linux
 Kernel Mailing List <linux-kernel@vger.kernel.org>
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

I've been thinking of the case where a descriptor ring has
to be in non-coherent memory (eg because that is all there is).

The receive ring processing isn't actually that difficult.

The driver has to fill a cache line full of new buffer
descriptors in memory but without assigning the first
buffer to the hardware.
Then it has to do a cache line write of just that line.
Then it can assign ownership of the first buffer and
finally do a second cache line write.
(The first explicit write can be skipped if the cache
writes are known to be atomic.)
It then must not dirty that cache line.

To check for new frames it must invalidate the cache
line that contains the 'next to be filled' descriptor
and then read that cache line.
This will contain info about one or more receive frames.
But the hardware is still doing updates.

But both these operations can be happening at the same
time on different parts of the buffer.

So you need to know a 'cache line size' for the mapping
and be able to do writebacks and invalidates for parts
of the buffer, not just all of it.

The transmit side is harder.
It either requires waiting for all pending transmits to
finish or splitting a single transmit into enough fragments
that its descriptors end on a cache line boundary.
But again, and if the interface is busy, you want the cpu
to be able to update one cache line of transmit descriptors
while the device is writing transmit completion status
to the previous cache line.

I don't think that is materially different for non-coherent
memory or bounce buffers.
But partial flush/invalidate is needed.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
