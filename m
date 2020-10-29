Return-Path: <SRS0=7pZu=EE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD302C4741F
	for <iommu@archiver.kernel.org>; Thu, 29 Oct 2020 22:13:10 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29FEE206CA
	for <iommu@archiver.kernel.org>; Thu, 29 Oct 2020 22:13:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29FEE206CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id C0BBD87524;
	Thu, 29 Oct 2020 22:13:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LBSu0lsomTOq; Thu, 29 Oct 2020 22:13:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 03DAE871BE;
	Thu, 29 Oct 2020 22:13:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D62A5C0859;
	Thu, 29 Oct 2020 22:13:07 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B6ADAC0051
 for <iommu@lists.linux-foundation.org>; Thu, 29 Oct 2020 22:13:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 77D5522636
 for <iommu@lists.linux-foundation.org>; Thu, 29 Oct 2020 22:13:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ydagRLszxXTV for <iommu@lists.linux-foundation.org>;
 Thu, 29 Oct 2020 22:13:05 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from eu-smtp-delivery-151.mimecast.com
 (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
 by silver.osuosl.org (Postfix) with ESMTPS id 9983C20532
 for <iommu@lists.linux-foundation.org>; Thu, 29 Oct 2020 22:13:04 +0000 (UTC)
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-27-qEwyl-1dPLWnmCDyyUncBw-1; Thu, 29 Oct 2020 22:13:00 +0000
X-MC-Unique: qEwyl-1dPLWnmCDyyUncBw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Thu, 29 Oct 2020 22:12:59 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000; 
 Thu, 29 Oct 2020 22:12:59 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Arvind Sankar' <nivedita@alum.mit.edu>, Thomas Gleixner
 <tglx@linutronix.de>
Subject: RE: [PATCH] [v2] x86: apic: avoid -Wshadow warning in header
Thread-Topic: [PATCH] [v2] x86: apic: avoid -Wshadow warning in header
Thread-Index: AQHWrZenJpzBwTRfbE+Uihb7XQWTqKmurjkggABtZPaAAAkikA==
Date: Thu, 29 Oct 2020 22:12:59 +0000
Message-ID: <ad73f56e79d249b1b3614bccc85e2ca5@AcuMS.aculab.com>
References: <20201028212417.3715575-1-arnd@kernel.org>
 <38b11ed3fec64ebd82d6a92834a4bebe@AcuMS.aculab.com>
 <20201029165611.GA2557691@rani.riverdale.lan>
 <93180c2d-268c-3c33-7c54-4221dfe0d7ad@redhat.com>
 <87v9esojdi.fsf@nanos.tec.linutronix.de>
 <20201029213512.GA34524@rani.riverdale.lan>
In-Reply-To: <20201029213512.GA34524@rani.riverdale.lan>
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
Cc: 'Arnd Bergmann' <arnd@kernel.org>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 Stephen Hemminger <sthemmin@microsoft.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Haiyang Zhang <haiyangz@microsoft.com>, "x86@kernel.org" <x86@kernel.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>,
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
 Wanpeng Li <wanpengli@tencent.com>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>,
 "K. Y. Srinivasan" <kys@microsoft.com>, Jim Mattson <jmattson@google.com>
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

From: Arvind Sankar
> Sent: 29 October 2020 21:35
> 
> On Thu, Oct 29, 2020 at 09:41:13PM +0100, Thomas Gleixner wrote:
> > On Thu, Oct 29 2020 at 17:59, Paolo Bonzini wrote:
> > > On 29/10/20 17:56, Arvind Sankar wrote:
> > >>> For those two just add:
> > >>> 	struct apic *apic = x86_system_apic;
> > >>> before all the assignments.
> > >>> Less churn and much better code.
> > >>>
> > >> Why would it be better code?
> > >>
> > >
> > > I think he means the compiler produces better code, because it won't
> > > read the global variable repeatedly.  Not sure if that's true,(*) but I
> > > think I do prefer that version if Arnd wants to do that tweak.
> >
> > It's not true.
> >
> >      foo *p = bar;
> >
> >      p->a = 1;
> >      p->b = 2;
> >
> > The compiler is free to reload bar after accessing p->a and with
> >
> >     bar->a = 1;
> >     bar->b = 1;
> >
> > it can either cache bar in a register or reread it after bar->a
> >
> > The generated code is the same as long as there is no reason to reload,
> > e.g. register pressure.
> >
> > Thanks,
> >
> >         tglx
> 
> It's not quite the same.
> 
> https://godbolt.org/z/4dzPbM
> 
> With -fno-strict-aliasing, the compiler reloads the pointer if you write
> to the start of what it points to, but not if you write to later
> elements.

I guess it assumes that global data doesn't overlap.

But in general they are sort of opposites:

With the local variable it can reload if it knows the write
cannot have affected the global - but is unlikely to do so.

Using the global it must reload if it is possible the write
might have affected the global.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
