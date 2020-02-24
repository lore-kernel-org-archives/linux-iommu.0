Return-Path: <SRS0=ms/0=4M=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 067E5C35679
	for <iommu@archiver.kernel.org>; Mon, 24 Feb 2020 07:49:19 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC7B820675
	for <iommu@archiver.kernel.org>; Mon, 24 Feb 2020 07:49:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aV0ARX3s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC7B820675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 6377D2002F;
	Mon, 24 Feb 2020 07:49:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id otn6Ed4R1ndJ; Mon, 24 Feb 2020 07:49:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id C7A6A2002B;
	Mon, 24 Feb 2020 07:49:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A5EBBC07FF;
	Mon, 24 Feb 2020 07:49:16 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9CD60C0177
 for <iommu@lists.linux-foundation.org>; Mon, 24 Feb 2020 07:49:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 6E4C885A6E
 for <iommu@lists.linux-foundation.org>; Mon, 24 Feb 2020 07:49:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IoVQI-XY1IC5 for <iommu@lists.linux-foundation.org>;
 Mon, 24 Feb 2020 07:49:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [207.211.31.120])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 52D42859E3
 for <iommu@lists.linux-foundation.org>; Mon, 24 Feb 2020 07:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582530552;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UJzRHJfOvqED/QVB11a8FY9iUPPI3dbD0rzXCYDhwc0=;
 b=aV0ARX3sb+B/aP+pqXcf0B70adC659X3Bo2vgOvhnjoVbN+3rqzgWi01VE2xn/eHUvAEWb
 Rst1kci2S93ffwDGJfi2AaN8QPIIn4gDqMfbdaiYefmOgyQTvVybMk+BgkwqXCo2tP/uE4
 T0EsR8ApWRtIKqxYB9iHLjVSp5C0i2Q=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-327-_M1WZ-39MWW09bRKclxJjQ-1; Mon, 24 Feb 2020 02:49:08 -0500
X-MC-Unique: _M1WZ-39MWW09bRKclxJjQ-1
Received: by mail-qk1-f200.google.com with SMTP id i11so9690400qki.12
 for <iommu@lists.linux-foundation.org>; Sun, 23 Feb 2020 23:49:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=UJzRHJfOvqED/QVB11a8FY9iUPPI3dbD0rzXCYDhwc0=;
 b=dY9GCWpCBNUsP96bMeBwIgHYYhmaCUGaDar8bXxIZBkzhhrRbpNr0ZtS733rOFajax
 PjdM/XbmE/+VTk4GQ6O9FEfOI952qR/ac4w+5zw1ub4JoAwnTYkck7YCsK2kuTc1GzUQ
 Egthf/w8DBGZ5uluwQm+6pBDFIdRh1pA3A5YZX/WGqUIyhd7LRRF80Zzt2mEudobmnla
 y1UEex/1rTjgNUKhAqBrHPC3+ZwSCvemc0EfywfTBw9XFbr96T7rzNYqVDY3F2RD9abF
 SpmqqucHyCqmSySej/9I9Pkpq9XNvh8y1EC5qu/qpEzWBmxgOqTMeNey6VFVjLKDbTng
 6fDQ==
X-Gm-Message-State: APjAAAUH2LeImcHIf5tn84cFeyYelr6MFzWBSz6vqJzO2wnsSiw6VKhd
 9mjuE0YqNVu+Was7d5oLaleHqZori4tl8uWYvhPdRXdLZhrJIMqovfia4P/nJMFcw9pJhAHjugL
 M+ACIws2sxQjGbIghQNwrII53WdlQ+A==
X-Received: by 2002:a05:620a:95c:: with SMTP id
 w28mr44288179qkw.428.1582530547829; 
 Sun, 23 Feb 2020 23:49:07 -0800 (PST)
X-Google-Smtp-Source: APXvYqzzBrfPKkWekVzDtkE3twmNvbfgy+awAYxrqVqXXAqxHi9BwToMW+Zbt9HgNgV5bAhK+LRpaQ==
X-Received: by 2002:a05:620a:95c:: with SMTP id
 w28mr44288158qkw.428.1582530547478; 
 Sun, 23 Feb 2020 23:49:07 -0800 (PST)
Received: from redhat.com (bzq-79-178-2-214.red.bezeqint.net. [79.178.2.214])
 by smtp.gmail.com with ESMTPSA id
 r37sm5593220qtj.44.2020.02.23.23.49.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Feb 2020 23:49:06 -0800 (PST)
Date: Mon, 24 Feb 2020 02:48:59 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 0/2] virtio: decouple protected guest RAM form
 VIRTIO_F_IOMMU_PLATFORM
Message-ID: <20200224024641-mutt-send-email-mst@kernel.org>
References: <20200220160606.53156-1-pasic@linux.ibm.com>
 <426e6972-0565-c931-e171-da0f58fbf856@redhat.com>
 <20200221155602.4de41fa7.pasic@linux.ibm.com>
 <0181712c-e533-fcfd-2638-8a0649d713dd@redhat.com>
 <20200224010607-mutt-send-email-mst@kernel.org>
 <b3c52c67-c740-a50e-2595-fe04d179c881@redhat.com>
MIME-Version: 1.0
In-Reply-To: <b3c52c67-c740-a50e-2595-fe04d179c881@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: linux-s390@vger.kernel.org, Janosch Frank <frankja@linux.ibm.com>,
 "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
 Cornelia Huck <cohuck@redhat.com>, Ram Pai <linuxram@us.ibm.com>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 iommu@lists.linux-foundation.org, David Gibson <david@gibson.dropbear.id.au>,
 Michael Mueller <mimu@linux.ibm.com>,
 Viktor Mihajlovski <mihajlov@linux.ibm.com>,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

T24gTW9uLCBGZWIgMjQsIDIwMjAgYXQgMDI6NDU6MDNQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiAKPiBPbiAyMDIwLzIvMjQg5LiL5Y2IMjowNiwgTWljaGFlbCBTLiBUc2lya2luIHdyb3Rl
Ogo+ID4gT24gTW9uLCBGZWIgMjQsIDIwMjAgYXQgMTI6MDE6NTdQTSArMDgwMCwgSmFzb24gV2Fu
ZyB3cm90ZToKPiA+ID4gT24gMjAyMC8yLzIxIOS4i+WNiDEwOjU2LCBIYWxpbCBQYXNpYyB3cm90
ZToKPiA+ID4gPiBPbiBGcmksIDIxIEZlYiAyMDIwIDE0OjIyOjI2ICswODAwCj4gPiA+ID4gSmFz
b24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gPiA+ID4gCj4gPiA+ID4gPiBP
biAyMDIwLzIvMjEg5LiK5Y2IMTI6MDYsIEhhbGlsIFBhc2ljIHdyb3RlOgo+ID4gPiA+ID4gPiBD
dXJyZW50bHkgaWYgb25lIGludGVuZHMgdG8gcnVuIGEgbWVtb3J5IHByb3RlY3Rpb24gZW5hYmxl
ZCBWTSB3aXRoCj4gPiA+ID4gPiA+IHZpcnRpbyBkZXZpY2VzIGFuZCBsaW51eCBhcyB0aGUgZ3Vl
c3QgT1MsIG9uZSBuZWVkcyB0byBzcGVjaWZ5IHRoZQo+ID4gPiA+ID4gPiBWSVJUSU9fRl9JT01N
VV9QTEFURk9STSBmbGFnIGZvciBlYWNoIHZpcnRpbyBkZXZpY2UgdG8gbWFrZSB0aGUgZ3Vlc3QK
PiA+ID4gPiA+ID4gbGludXggdXNlIHRoZSBETUEgQVBJLCB3aGljaCBpbiB0dXJuIGhhbmRsZXMg
dGhlIG1lbW9yeQo+ID4gPiA+ID4gPiBlbmNyeXB0aW9uL3Byb3RlY3Rpb24gc3R1ZmYgaWYgdGhl
IGd1ZXN0IGRlY2lkZXMgdG8gdHVybiBpdHNlbGYgaW50bwo+ID4gPiA+ID4gPiBhIHByb3RlY3Rl
ZCBvbmUuIFRoaXMgaG93ZXZlciBtYWtlcyBubyBzZW5zZSBkdWUgdG8gbXVsdGlwbGUgcmVhc29u
czoKPiA+ID4gPiA+ID4gKiBUaGUgZGV2aWNlIGlzIG5vdCBjaGFuZ2VkIGJ5IHRoZSBmYWN0IHRo
YXQgdGhlIGd1ZXN0IFJBTSBpcwo+ID4gPiA+ID4gPiBwcm90ZWN0ZWQuIFRoZSBzbyBjYWxsZWQg
SU9NTVUgYnlwYXNzIHF1aXJrIGlzIG5vdCBhZmZlY3RlZC4KPiA+ID4gPiA+ID4gKiBUaGlzIHVz
YWdlIGlzIG5vdCBjb25ncnVlbnQgd2l0aCAgc3RhbmRhcmRpc2VkIHNlbWFudGljcyBvZgo+ID4g
PiA+ID4gPiBWSVJUSU9fRl9JT01NVV9QTEFURk9STS4gR3Vlc3QgbWVtb3J5IHByb3RlY3RlZCBp
cyBhbiBvcnRob2dvbmFsIHJlYXNvbgo+ID4gPiA+ID4gPiBmb3IgdXNpbmcgRE1BIEFQSSBpbiB2
aXJ0aW8gKG9ydGhvZ29uYWwgd2l0aCByZXNwZWN0IHRvIHdoYXQgaXMKPiA+ID4gPiA+ID4gZXhw
cmVzc2VkIGJ5IFZJUlRJT19GX0lPTU1VX1BMQVRGT1JNKS4KPiA+ID4gPiA+ID4gCj4gPiA+ID4g
PiA+IFRoaXMgc2VyaWVzIGFpbXMgdG8gZGVjb3VwbGUgJ2hhdmUgdG8gdXNlIERNQSBBUEkgYmVj
YXVzZSBteSAoZ3Vlc3QpIFJBTQo+ID4gPiA+ID4gPiBpcyBwcm90ZWN0ZWQnIGFuZCAnaGF2ZSB0
byB1c2UgRE1BIEFQSSBiZWNhdXNlIHRoZSBkZXZpY2UgdG9sZCBtZQo+ID4gPiA+ID4gPiBWSVJU
SU9fRl9JT01NVV9QTEFURk9STScuCj4gPiA+ID4gPiA+IAo+ID4gPiA+ID4gPiBQbGVhc2UgZmlu
ZCBtb3JlIGRldGFpbGVkIGV4cGxhbmF0aW9ucyBhYm91dCB0aGUgY29uY2VwdHVhbCBhc3BlY3Rz
IGluCj4gPiA+ID4gPiA+IHRoZSBpbmRpdmlkdWFsIHBhdGNoZXMuIFRoZXJlIGlzIGhvd2V2ZXIg
YWxzbyBhIHZlcnkgcHJhY3RpY2FsIHByb2JsZW0KPiA+ID4gPiA+ID4gdGhhdCBpcyBhZGRyZXNz
ZWQgYnkgdGhpcyBzZXJpZXMuCj4gPiA+ID4gPiA+IAo+ID4gPiA+ID4gPiBGb3Igdmhvc3QtbmV0
IHRoZSBmZWF0dXJlIFZJUlRJT19GX0lPTU1VX1BMQVRGT1JNIGhhcyB0aGUgZm9sbG93aW5nIHNp
ZGUKPiA+ID4gPiA+ID4gZWZmZWN0IFRoZSB2aG9zdCBjb2RlIGFzc3VtZXMgaXQgdGhlIGFkZHJl
c3NlcyBvbiB0aGUgdmlydGlvIGRlc2NyaXB0b3IKPiA+ID4gPiA+ID4gcmluZyBhcmUgbm90IGd1
ZXN0IHBoeXNpY2FsIGFkZHJlc3NlcyBidXQgaW92YSdzLCBhbmQgaW5zaXN0cyBvbiBkb2luZyBh
Cj4gPiA+ID4gPiA+IHRyYW5zbGF0aW9uIG9mIHRoZXNlIHJlZ2FyZGxlc3Mgb2Ygd2hhdCB0cmFu
c3BvcnQgaXMgdXNlZCAoZS5nLiB3aGV0aGVyCj4gPiA+ID4gPiA+IHdlIGVtdWxhdGUgYSBQQ0kg
b3IgYSBDQ1cgZGV2aWNlKS4gKEZvciBkZXRhaWxzIHNlZSBjb21taXQgNmIxZTZjYzc4NTViCj4g
PiA+ID4gPiA+ICJ2aG9zdDogbmV3IGRldmljZSBJT1RMQiBBUEkiLikgT24gczM5MCB0aGlzIHJl
c3VsdHMgaW4gc2V2ZXJlCj4gPiA+ID4gPiA+IHBlcmZvcm1hbmNlIGRlZ3JhZGF0aW9uIChjLmEu
IGZhY3RvciAxMCkuCj4gPiA+ID4gPiBEbyB5b3Ugc2VlIGEgY29uc2lzdGVudCBkZWdyYWRhdGlv
biBvbiB0aGUgcGVyZm9ybWFuY2UsIG9yIGl0IG9ubHkKPiA+ID4gPiA+IGhhcHBlbiB3aGVuIGZv
ciBkdXJpbmcgdGhlIGJlZ2lubmluZyBvZiB0aGUgdGVzdD8KPiA+ID4gPiA+IAo+ID4gPiA+IEFG
QUlLIHRoZSBkZWdyYWRhdGlvbiBpcyBjb25zaXN0ZW50Lgo+ID4gPiA+IAo+ID4gPiA+ID4gPiBC
VFcgd2l0aCBjY3cgSS9PIHRoZXJlIGlzCj4gPiA+ID4gPiA+IChhcmNoaXRlY3R1cmFsbHkpIG5v
IElPTU1VLCBzbyB0aGUgd2hvbGUgYWRkcmVzcyB0cmFuc2xhdGlvbiBtYWtlcyBubwo+ID4gPiA+
ID4gPiBzZW5zZSBpbiB0aGUgY29udGV4dCBvZiB2aXJ0aW8tY2N3Lgo+ID4gPiA+ID4gSSBzdXNw
ZWN0IHdlIGNhbiBkbyBvcHRpbWl6YXRpb24gaW4gcWVtdSBzaWRlLgo+ID4gPiA+ID4gCj4gPiA+
ID4gPiBFLmcgc2VuZCBtZW10YWJsZSBlbnRyeSB2aWEgSU9UTEIgQVBJIHdoZW4gdklPTU1VIGlz
IG5vdCBlbmFibGVkLgo+ID4gPiA+ID4gCj4gPiA+ID4gPiBJZiB0aGlzIG1ha2VzIHNlbnNlLCBJ
IGNhbiBkcmFmdCBwYXRjaCB0byBzZWUgaWYgdGhlcmUncyBhbnkgZGlmZmVyZW5jZS4KPiA+ID4g
PiBGcmFua2x5IEkgd291bGQgcHJlZmVyIHRvIGF2b2lkIElPVkFzIG9uIHRoZSBkZXNjcmlwdG9y
IHJpbmcgKGFuZCB0aGUKPiA+ID4gPiB0aGVuIG5lY2Vzc2FyeSB0cmFuc2xhdGlvbikgZm9yIHZp
cnRpby1jY3cgYWx0b2dldGhlci4gQnV0IE1pY2hhZWwKPiA+ID4gPiB2b2ljZWQgaGlzIG9waW5p
b24gdGhhdCB3ZSBzaG91bGQgbWFuZGF0ZSBGX0lPTU1VX1BMQVRGT1JNIGZvciBkZXZpY2VzCj4g
PiA+ID4gdGhhdCBjb3VsZCBiZSB1c2VkIHdpdGggZ3Vlc3RzIHJ1bm5pbmcgaW4gcHJvdGVjdGVk
IG1vZGUuIEkgZG9uJ3Qgc2hhcmUKPiA+ID4gPiBoaXMgb3BpbmlvbiwgYnV0IHRoYXQncyBhbiBv
bmdvaW5nIGRpc2N1c3Npb24uCj4gPiA+ID4gCj4gPiA+ID4gU2hvdWxkIHdlIGVuZCB1cCBoYXZp
bmcgdG8gZG8gdHJhbnNsYXRpb24gZnJvbSBJT1ZBIGluIHZob3N0LCB3ZSBhcmUKPiA+ID4gPiB2
ZXJ5IGludGVyZXN0ZWQgaW4gdGhhdCB0cmFuc2xhdGlvbiBiZWluZyBmYXN0IGFuZCBlZmZpY2ll
bnQuCj4gPiA+ID4gCj4gPiA+ID4gSW4gdGhhdCBzZW5zZSB3ZSB3b3VsZCBiZSB2ZXJ5IGhhcHB5
IHRvIHRlc3QgYW55IG9wdGltaXphdGlvbiB0aGF0IGFpbQo+ID4gPiA+IGludG8gdGhhdCBkaXJl
Y3Rpb24uCj4gPiA+ID4gCj4gPiA+ID4gVGhhbmsgeW91IHZlcnkgbXVjaCBmb3IgeW91ciBpbnB1
dCEKPiA+ID4gCj4gPiA+IFVzaW5nIElPVExCIEFQSSBvbiBwbGF0Zm9ybSB3aXRob3V0IElPTU1V
IHN1cHBvcnQgaXMgbm90IGludGVuZGVkLiBQbGVhc2UKPiA+ID4gdHJ5IHRoZSBhdHRhY2hlZCBw
YXRjaCB0byBzZWUgaWYgaXQgaGVscHMuCj4gPiA+IAo+ID4gPiBUaGFua3MKPiA+ID4gCj4gPiA+
IAo+ID4gPiA+IFJlZ2FyZHMsCj4gPiA+ID4gSGFsaWwKPiA+ID4gPiAKPiA+ID4gPiA+IFRoYW5r
cwo+ID4gPiA+ID4gCj4gPiA+ID4gPiAKPiA+ID4gPiA+ID4gSGFsaWwgUGFzaWMgKDIpOgo+ID4g
PiA+ID4gPiAgICAgIG1tOiBtb3ZlIGZvcmNlX2RtYV91bmVuY3J5cHRlZCgpIHRvIG1lbV9lbmNy
eXB0LmgKPiA+ID4gPiA+ID4gICAgICB2aXJ0aW86IGxldCB2aXJ0aW8gdXNlIERNQSBBUEkgd2hl
biBndWVzdCBSQU0gaXMgcHJvdGVjdGVkCj4gPiA+ID4gPiA+IAo+ID4gPiA+ID4gPiAgICAgZHJp
dmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYyB8ICAzICsrKwo+ID4gPiA+ID4gPiAgICAgaW5jbHVk
ZS9saW51eC9kbWEtZGlyZWN0LmggICB8ICA5IC0tLS0tLS0tLQo+ID4gPiA+ID4gPiAgICAgaW5j
bHVkZS9saW51eC9tZW1fZW5jcnlwdC5oICB8IDEwICsrKysrKysrKysKPiA+ID4gPiA+ID4gICAg
IDMgZmlsZXMgY2hhbmdlZCwgMTMgaW5zZXJ0aW9ucygrKSwgOSBkZWxldGlvbnMoLSkKPiA+ID4g
PiA+ID4gCj4gPiA+ID4gPiA+IAo+ID4gPiA+ID4gPiBiYXNlLWNvbW1pdDogY2E3ZTFmZDEwMjZj
NWFmNmE1MzNiNGI1NDQ3ZTFkMmYxNTNlMjhmMgo+ID4gPiA+RnJvbSA2NmZhNzMwNDYwODc1YWM5
OWU4MWQ3ZGIyMzM0Y2QxNmJiMWQyYjI3IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQo+ID4gPiBG
cm9tOiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPgo+ID4gPiBEYXRlOiBNb24sIDI0
IEZlYiAyMDIwIDEyOjAwOjEwICswODAwCj4gPiA+IFN1YmplY3Q6IFtQQVRDSF0gdmlydGlvOiB0
dXJuIG9uIElPTU1VX1BMQVRGT1JNIHByb3Blcmx5Cj4gPiA+IAo+ID4gPiBXaGVuIHRyYW5zcG9y
dCBkb2VzIG5vdCBzdXBwb3J0IElPTU1VLCB3ZSBzaG91bGQgY2xlYXIgSU9NTVVfUExBVEZPUk0K
PiA+ID4gZXZlbiBpZiB0aGUgZGV2aWNlIGFuZCB2aG9zdCBjbGFpbXMgdG8gc3VwcG9ydCB0aGF0
LiBUaGlzIGhlbHAgdG8KPiA+ID4gYXZvaWQgdGhlIHBlcmZvcm1hbmNlIG92ZXJoZWFkIGNhdXNl
ZCBieSB1bm5lY2Vzc2FyeSBJT1RMQiBtaXNzL3VwZGF0ZQo+ID4gPiB0cmFuc2FjdGlvbnMgb24g
c3VjaCBwbGF0Zm9ybS4KPiA+ID4gCj4gPiA+IFNpZ25lZC1vZmYtYnk6IEphc29uIFdhbmcgPGph
c293YW5nQHJlZGhhdC5jb20+Cj4gPiA+IC0tLQo+ID4gPiAgIGh3L3ZpcnRpby92aXJ0aW8tYnVz
LmMgfCA2ICsrKy0tLQo+ID4gPiAgIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDMg
ZGVsZXRpb25zKC0pCj4gPiA+IAo+ID4gPiBkaWZmIC0tZ2l0IGEvaHcvdmlydGlvL3ZpcnRpby1i
dXMuYyBiL2h3L3ZpcnRpby92aXJ0aW8tYnVzLmMKPiA+ID4gaW5kZXggZDYzMzJkNDVjMy4uMjc0
MWI5ZmRkMiAxMDA2NDQKPiA+ID4gLS0tIGEvaHcvdmlydGlvL3ZpcnRpby1idXMuYwo+ID4gPiAr
KysgYi9ody92aXJ0aW8vdmlydGlvLWJ1cy5jCj4gPiA+IEBAIC00Nyw3ICs0Nyw2IEBAIHZvaWQg
dmlydGlvX2J1c19kZXZpY2VfcGx1Z2dlZChWaXJ0SU9EZXZpY2UgKnZkZXYsIEVycm9yICoqZXJy
cCkKPiA+ID4gICAgICAgVmlydGlvQnVzU3RhdGUgKmJ1cyA9IFZJUlRJT19CVVMocWJ1cyk7Cj4g
PiA+ICAgICAgIFZpcnRpb0J1c0NsYXNzICprbGFzcyA9IFZJUlRJT19CVVNfR0VUX0NMQVNTKGJ1
cyk7Cj4gPiA+ICAgICAgIFZpcnRpb0RldmljZUNsYXNzICp2ZGMgPSBWSVJUSU9fREVWSUNFX0dF
VF9DTEFTUyh2ZGV2KTsKPiA+ID4gLSAgICBib29sIGhhc19pb21tdSA9IHZpcnRpb19ob3N0X2hh
c19mZWF0dXJlKHZkZXYsIFZJUlRJT19GX0lPTU1VX1BMQVRGT1JNKTsKPiA+ID4gICAgICAgRXJy
b3IgKmxvY2FsX2VyciA9IE5VTEw7Cj4gPiA+ICAgICAgIERQUklOVEYoIiVzOiBwbHVnIGRldmlj
ZS5cbiIsIHFidXMtPm5hbWUpOwo+ID4gPiBAQCAtNzcsMTAgKzc2LDExIEBAIHZvaWQgdmlydGlv
X2J1c19kZXZpY2VfcGx1Z2dlZChWaXJ0SU9EZXZpY2UgKnZkZXYsIEVycm9yICoqZXJycCkKPiA+
ID4gICAgICAgICAgIHJldHVybjsKPiA+ID4gICAgICAgfQo+ID4gPiAtICAgIGlmIChrbGFzcy0+
Z2V0X2RtYV9hcyAhPSBOVUxMICYmIGhhc19pb21tdSkgewo+ID4gPiAtICAgICAgICB2aXJ0aW9f
YWRkX2ZlYXR1cmUoJnZkZXYtPmhvc3RfZmVhdHVyZXMsIFZJUlRJT19GX0lPTU1VX1BMQVRGT1JN
KTsKPiA+ID4gKyAgICBpZiAoZmFsc2UgJiYga2xhc3MtPmdldF9kbWFfYXMgIT0gTlVMTCAmJgo+
ID4gPiArICAgICAgICB2aXJ0aW9faG9zdF9oYXNfZmVhdHVyZSh2ZGV2LCBWSVJUSU9fRl9JT01N
VV9QTEFURk9STSkpIHsKPiA+ID4gICAgICAgICAgIHZkZXYtPmRtYV9hcyA9IGtsYXNzLT5nZXRf
ZG1hX2FzKHFidXMtPnBhcmVudCk7Cj4gPiA+ICAgICAgIH0gZWxzZSB7Cj4gPiA+ICsgICAgICAg
IHZpcnRpb19jbGVhcl9mZWF0dXJlKCZ2ZGV2LT5ob3N0X2ZlYXR1cmVzLCBWSVJUSU9fRl9JT01N
VV9QTEFURk9STSk7Cj4gPiA+ICAgICAgICAgICB2ZGV2LT5kbWFfYXMgPSAmYWRkcmVzc19zcGFj
ZV9tZW1vcnk7Cj4gPiA+ICAgICAgIH0KPiA+ID4gICB9Cj4gPiAKPiA+IFRoaXMgc2VlbXMgdG8g
Y2xlYXIgaXQgdW5jb25kaXRpb25hbGx5LiBJIGd1ZXNzIGl0J3MganVzdCBhIGRlYnVnZ2luZwo+
ID4gcGF0Y2gsIHRoZSByZWFsIG9uZSB3aWxsIGNvbWUgbGF0ZXI/Cj4gCj4gCj4gTXkgYmFkLCBo
ZXJlJ3MgdGhlIGNvcnJlY3Qgb25lLgo+IAo+IFRoYW5rcwo+IAo+IAo+ID4gCj4gPiA+IC0tIAo+
ID4gPiAyLjE5LjEKPiA+ID4gCgo+ID5Gcm9tIGI4YThiNTgyZjQ2YmI4NmM3YTc0NWIyNzJkYjdi
NzQ0Nzc5ZTVjYzcgTW9uIFNlcCAxNyAwMDowMDowMCAyMDAxCj4gRnJvbTogSmFzb24gV2FuZyA8
amFzb3dhbmdAcmVkaGF0LmNvbT4KPiBEYXRlOiBNb24sIDI0IEZlYiAyMDIwIDEyOjAwOjEwICsw
ODAwCj4gU3ViamVjdDogW1BBVENIXSB2aXJ0aW86IHR1cm4gb24gSU9NTVVfUExBVEZPUk0gcHJv
cGVybHkKPiAKPiBXaGVuIHRyYW5zcG9ydCBkb2VzIG5vdCBzdXBwb3J0IElPTU1VLCB3ZSBzaG91
bGQgY2xlYXIgSU9NTVVfUExBVEZPUk0KPiBldmVuIGlmIHRoZSBkZXZpY2UgYW5kIHZob3N0IGNs
YWltcyB0byBzdXBwb3J0IHRoYXQuIFRoaXMgaGVscCB0bwo+IGF2b2lkIHRoZSBwZXJmb3JtYW5j
ZSBvdmVyaGVhZCBjYXVzZWQgYnkgdW5uZWNlc3NhcnkgSU9UTEIgbWlzcy91cGRhdGUKPiB0cmFu
c2FjdGlvbnMgb24gc3VjaCBwbGF0Zm9ybS4KPiAKPiBTaWduZWQtb2ZmLWJ5OiBKYXNvbiBXYW5n
IDxqYXNvd2FuZ0ByZWRoYXQuY29tPgo+IC0tLQo+ICBody92aXJ0aW8vdmlydGlvLWJ1cy5jIHwg
NiArKystLS0KPiAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMo
LSkKPiAKPiBkaWZmIC0tZ2l0IGEvaHcvdmlydGlvL3ZpcnRpby1idXMuYyBiL2h3L3ZpcnRpby92
aXJ0aW8tYnVzLmMKPiBpbmRleCBkNjMzMmQ0NWMzLi40YmU2NGUxOTNlIDEwMDY0NAo+IC0tLSBh
L2h3L3ZpcnRpby92aXJ0aW8tYnVzLmMKPiArKysgYi9ody92aXJ0aW8vdmlydGlvLWJ1cy5jCj4g
QEAgLTQ3LDcgKzQ3LDYgQEAgdm9pZCB2aXJ0aW9fYnVzX2RldmljZV9wbHVnZ2VkKFZpcnRJT0Rl
dmljZSAqdmRldiwgRXJyb3IgKiplcnJwKQo+ICAgICAgVmlydGlvQnVzU3RhdGUgKmJ1cyA9IFZJ
UlRJT19CVVMocWJ1cyk7Cj4gICAgICBWaXJ0aW9CdXNDbGFzcyAqa2xhc3MgPSBWSVJUSU9fQlVT
X0dFVF9DTEFTUyhidXMpOwo+ICAgICAgVmlydGlvRGV2aWNlQ2xhc3MgKnZkYyA9IFZJUlRJT19E
RVZJQ0VfR0VUX0NMQVNTKHZkZXYpOwo+IC0gICAgYm9vbCBoYXNfaW9tbXUgPSB2aXJ0aW9faG9z
dF9oYXNfZmVhdHVyZSh2ZGV2LCBWSVJUSU9fRl9JT01NVV9QTEFURk9STSk7Cj4gICAgICBFcnJv
ciAqbG9jYWxfZXJyID0gTlVMTDsKPiAgCj4gICAgICBEUFJJTlRGKCIlczogcGx1ZyBkZXZpY2Uu
XG4iLCBxYnVzLT5uYW1lKTsKPiBAQCAtNzcsMTAgKzc2LDExIEBAIHZvaWQgdmlydGlvX2J1c19k
ZXZpY2VfcGx1Z2dlZChWaXJ0SU9EZXZpY2UgKnZkZXYsIEVycm9yICoqZXJycCkKPiAgICAgICAg
ICByZXR1cm47Cj4gICAgICB9Cj4gIAo+IC0gICAgaWYgKGtsYXNzLT5nZXRfZG1hX2FzICE9IE5V
TEwgJiYgaGFzX2lvbW11KSB7Cj4gLSAgICAgICAgdmlydGlvX2FkZF9mZWF0dXJlKCZ2ZGV2LT5o
b3N0X2ZlYXR1cmVzLCBWSVJUSU9fRl9JT01NVV9QTEFURk9STSk7CgpTbyBpdCBsb29rcyBsaWtl
IHRoaXMgbGluZSBpcyB1bm5lY2Vzc2FyeSwgYnV0IGl0J3MgYW4gdW5yZWxhdGVkCmNsZWFudXAs
IHJpZ2h0PwoKPiArICAgIGlmIChrbGFzcy0+Z2V0X2RtYV9hcyAhPSBOVUxMICYmCj4gKyAgICAg
ICAgdmlydGlvX2hvc3RfaGFzX2ZlYXR1cmUodmRldiwgVklSVElPX0ZfSU9NTVVfUExBVEZPUk0p
KSB7Cj4gICAgICAgICAgdmRldi0+ZG1hX2FzID0ga2xhc3MtPmdldF9kbWFfYXMocWJ1cy0+cGFy
ZW50KTsKPiAgICAgIH0gZWxzZSB7Cj4gKyAgICAgICAgdmlydGlvX2NsZWFyX2ZlYXR1cmUoJnZk
ZXYtPmhvc3RfZmVhdHVyZXMsIFZJUlRJT19GX0lPTU1VX1BMQVRGT1JNKTsKCgpPZiBjb3Vyc2Ug
YW55IGNoYW5nZSBsaWtlIHRoYXQgd2lsbCBoYXZlIHRvIGFmZmVjdCBtaWdyYXRpb24gY29tcGF0
LCBldGMuCkNhbid0IHdlIGNsZWFyIHRoZSBiaXQgd2hlbiB3ZSBhcmUgc2VuZGluZyB0aGUgZmVh
dHVyZXMgdG8gdmhvc3QKaW5zdGVhZD8KCgo+ICAgICAgICAgIHZkZXYtPmRtYV9hcyA9ICZhZGRy
ZXNzX3NwYWNlX21lbW9yeTsKPiAgICAgIH0KPiAgfQo+IC0tIAo+IDIuMTkuMQo+IAoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBs
aXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhm
b3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
