Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 537A4C433EF
	for <iommu@archiver.kernel.org>; Thu, 30 Jun 2022 08:04:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C1F8A8415A;
	Thu, 30 Jun 2022 08:04:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C1F8A8415A
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YgXJK0rChMTn; Thu, 30 Jun 2022 08:04:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 639BE83FB0;
	Thu, 30 Jun 2022 08:04:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 639BE83FB0
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3F1E3C002D;
	Thu, 30 Jun 2022 08:04:52 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1EF05C0011
 for <iommu@lists.linux-foundation.org>; Thu, 30 Jun 2022 08:04:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CF933607F5
 for <iommu@lists.linux-foundation.org>; Thu, 30 Jun 2022 08:04:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CF933607F5
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id inCChUW6C_g8 for <iommu@lists.linux-foundation.org>;
 Thu, 30 Jun 2022 08:04:50 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 93B7060672
Received: from eu-smtp-delivery-151.mimecast.com
 (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 93B7060672
 for <iommu@lists.linux-foundation.org>; Thu, 30 Jun 2022 08:04:49 +0000 (UTC)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-214-9jXG4kaVPcae5B0FitiCbQ-1; Thu, 30 Jun 2022 09:04:45 +0100
X-MC-Unique: 9jXG4kaVPcae5B0FitiCbQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.36; Thu, 30 Jun 2022 09:04:43 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.036; Thu, 30 Jun 2022 09:04:43 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: 'Michael Schmitz' <schmitzmic@gmail.com>, Arnd Bergmann <arnd@kernel.org>
Subject: RE: [PATCH v2 3/3] arch/*/: remove CONFIG_VIRT_TO_BUS
Thread-Topic: [PATCH v2 3/3] arch/*/: remove CONFIG_VIRT_TO_BUS
Thread-Index: AQHYi0Qnhtr21GMXN0qgKN5inTL9yK1nmAnQ
Date: Thu, 30 Jun 2022 08:04:43 +0000
Message-ID: <26852797d822462abc1c9f96def7fa42@AcuMS.aculab.com>
References: <20220617125750.728590-1-arnd@kernel.org>
 <20220617125750.728590-4-arnd@kernel.org>
 <6ba86afe-bf9f-1aca-7af1-d0d348d75ffc@gmail.com>
 <CAMuHMdVewn0OYA9oJfStk0-+vCKAUou+4Mvd5H2kmrSks1p5jg@mail.gmail.com>
 <b4e5a1c9-e375-63fb-ec7c-abb7384a6d59@gmail.com>
 <9289fd82-285c-035f-5355-4d70ce4f87b0@gmail.com>
 <CAMuHMdXUihTPD9A9hs__Xr2ErfOqkZ5KgCHqm+9HvRf39uS5kA@mail.gmail.com>
 <c30bc9b6-6ccd-8856-dc6b-4e16450dad6f@gmail.com>
 <CAK8P3a1rxEVwVF5U-PO6pQkfURU5Tro1Qp8SPUfHEV9jjWOmCQ@mail.gmail.com>
 <9f812d3d-0fcd-46e6-6d7e-6d4bf66f24ab@gmail.com>
In-Reply-To: <9f812d3d-0fcd-46e6-6d7e-6d4bf66f24ab@gmail.com>
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
Cc: Linux-Arch <linux-arch@vger.kernel.org>, scsi <linux-scsi@vger.kernel.org>,
 Michael
 Ellerman <mpe@ellerman.id.au>, Christoph Hellwig <hch@infradead.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Jakub Kicinski <kuba@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, Denis Efremov <efremov@linux.com>,
 linux-m68k <linux-m68k@lists.linux-m68k.org>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Khalid Aziz <khalid@gonehiking.org>,
 Miquel van Smoorenburg <mikevs@xs4all.net>,
 Parisc List <linux-parisc@vger.kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Matt Wang <wwentao@vmware.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Mark Salyzyn <salyzyn@android.com>,
 Linux IOMMU <iommu@lists.linux-foundation.org>,
 alpha <linux-alpha@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "Maciej W . Rozycki" <macro@orcam.me.uk>
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

From: Michael Schmitz
> Sent: 29 June 2022 00:09
> 
> Hi Arnd,
> 
> On 29/06/22 09:50, Arnd Bergmann wrote:
> > On Tue, Jun 28, 2022 at 11:03 PM Michael Schmitz <schmitzmic@gmail.com> wrote:
> >> On 28/06/22 19:03, Geert Uytterhoeven wrote:
> >>>> The driver allocates bounce buffers using kmalloc if it hits an
> >>>> unaligned data buffer - can such buffers still even happen these days?
> >>> No idea.
> >> Hmmm - I think I'll stick a WARN_ONCE() in there so we know whether this
> >> code path is still being used.
> > kmalloc() guarantees alignment to the next power-of-two size or
> > KMALLOC_MIN_ALIGN, whichever is bigger. On m68k this means it
> > is cacheline aligned.
> 
> And all SCSI buffers are allocated using kmalloc? No way at all for user
> space to pass unaligned data?

I didn't think kmalloc() gave any such guarantee about alignment.
There are cache-line alignment requirements on systems with non-coherent
dma, but otherwise the alignment can be much smaller.

One of the allocators adds a header to each item, IIRC that can
lead to 'unexpected' alignments - especially on m68k.

dma_alloc_coherent() does align to next 'power of 2'.
And sometimes you need (eg) 16k allocates that are 16k aligned.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
