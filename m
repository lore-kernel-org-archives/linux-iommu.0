Return-Path: <SRS0=pgZ9=EA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1564C56202
	for <iommu@archiver.kernel.org>; Sun, 25 Oct 2020 13:20:27 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E73E22259
	for <iommu@archiver.kernel.org>; Sun, 25 Oct 2020 13:20:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E73E22259
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id C3CE587271;
	Sun, 25 Oct 2020 13:20:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1k53Hz8vav-f; Sun, 25 Oct 2020 13:20:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 9BB0487254;
	Sun, 25 Oct 2020 13:20:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8B3EFC088B;
	Sun, 25 Oct 2020 13:20:24 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A0474C0051
 for <iommu@lists.linux-foundation.org>; Sun, 25 Oct 2020 13:20:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 8600886A0E
 for <iommu@lists.linux-foundation.org>; Sun, 25 Oct 2020 13:20:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4ugeHOxOaZs7 for <iommu@lists.linux-foundation.org>;
 Sun, 25 Oct 2020 13:20:21 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from eu-smtp-delivery-151.mimecast.com
 (eu-smtp-delivery-151.mimecast.com [207.82.80.151])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 4328885F51
 for <iommu@lists.linux-foundation.org>; Sun, 25 Oct 2020 13:20:21 +0000 (UTC)
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-80-BcNCCdBLNpq04JWj022ymg-1; Sun, 25 Oct 2020 13:20:17 +0000
X-MC-Unique: BcNCCdBLNpq04JWj022ymg-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Sun, 25 Oct 2020 13:20:16 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000; 
 Sun, 25 Oct 2020 13:20:16 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'David Woodhouse' <dwmw2@infradead.org>, "x86@kernel.org" <x86@kernel.org>
Subject: RE: [PATCH v3 17/35] x86/pci/xen: Use msi_msg shadow structs
Thread-Topic: [PATCH v3 17/35] x86/pci/xen: Use msi_msg shadow structs
Thread-Index: AQHWqk3aux8nicxw2kqi6TJIJCakiamoEtJwgAALGgCAAC2AAA==
Date: Sun, 25 Oct 2020 13:20:16 +0000
Message-ID: <340eeca1a7e547bebef694eab505550d@AcuMS.aculab.com>
References: <e6601ff691afb3266e365a91e8b221179daf22c2.camel@infradead.org>
 <20201024213535.443185-1-dwmw2@infradead.org>
 <20201024213535.443185-18-dwmw2@infradead.org>
 <3e69326016524d97bcdea35d0765cc68@AcuMS.aculab.com>
 <a7ed5e550628083199e2747b8267c550689a368c.camel@infradead.org>
In-Reply-To: <a7ed5e550628083199e2747b8267c550689a368c.camel@infradead.org>
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
Cc: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 kvm <kvm@vger.kernel.org>, Dexuan Cui <decui@microsoft.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "maz@misterjones.org" <maz@misterjones.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@linutronix.de>
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

From: David Woodhouse
> Sent: 25 October 2020 10:26
> To: David Laight <David.Laight@ACULAB.COM>; x86@kernel.org
> 
> On Sun, 2020-10-25 at 09:49 +0000, David Laight wrote:
> > Just looking at a random one of these patches...
> >
> > Does the compiler manage to optimise that reasonably?
> > Or does it generate a lot of shifts and masks as each
> > bitfield is set?
> >
> > The code generation for bitfields is often a lot worse
> > that that for |= setting bits in a word.
> 
> Indeed, it appears to be utterly appalling. That was one of my
> motivations for doing it with masks and shifts in the first place.

I thought it would be.

I'm not even sure using bitfields to map hardware registers
makes the code any more readable (or fool proof).

I suspect using #define constants and explicit |= and &= ~
is actually best - provided the names are descriptive enough.

If you set all the fields the compiler will merge the values
and do a single write - provided nothing you read might
alias the target.

The only way to get strongly typed integers is to cast them
to a structure pointer type.
Together with a static inline function to remove the casts
and | the values together it might make things fool proof.
But I've never tried it.

ISTR once doing something like that with error codes, but
it didn't ever make source control.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
