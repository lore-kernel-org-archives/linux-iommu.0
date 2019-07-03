Return-Path: <SRS0=mxFs=VA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FEC4C06511
	for <iommu@archiver.kernel.org>; Wed,  3 Jul 2019 08:54:27 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21953218A3
	for <iommu@archiver.kernel.org>; Wed,  3 Jul 2019 08:54:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21953218A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 174021054;
	Wed,  3 Jul 2019 08:54:26 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 071D6104E
	for <iommu@lists.linux-foundation.org>;
	Wed,  3 Jul 2019 08:54:25 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-qt1-f196.google.com (mail-qt1-f196.google.com
	[209.85.160.196])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 979A6854
	for <iommu@lists.linux-foundation.org>;
	Wed,  3 Jul 2019 08:54:23 +0000 (UTC)
Received: by mail-qt1-f196.google.com with SMTP id w17so1650344qto.10
	for <iommu@lists.linux-foundation.org>;
	Wed, 03 Jul 2019 01:54:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=MSjZcZaarsSFJ2hu2ClYcmZVIX7oo4qCsiK4ex6LbOI=;
	b=MhMAU58UmdkQzxIGbLsma3DK8Q/L7LRiv0/B6+6P7YiptuFvUJNnBAEnHF7P9oVHiX
	Ua6aP4+HeavjaFJ/GJcTnn+QcFasrht6QGTErczOUSOie8Jz+BZ/sZHLx2BG7DK+5L16
	Dkp9r9APmabqRP8XGnr1mJv/loAKgYSBenCVjOQt0BFHbJLIIRjThDMJhWx1zqtSu8A6
	utKGIJz5nSqhJo8bpLsszbZD6vCScSi7QVi5tiZSUREClVbeUYUxWayddLF46NJg22Nz
	+bcjPtl8aXMD8RTDYVXors4feAQvO/4d/vzPJiTpjQsUpImzqBSaTHmNM0gIHKNB/dZa
	YgPw==
X-Gm-Message-State: APjAAAULGlHnciiS1+gAs0qE7BOAF3HgIrzw6pVCRY79sYNVL7GqEwNF
	+rmzqoLZ14kBNE0/u2RbyV096helLGTmrayrNEI=
X-Google-Smtp-Source: APXvYqwUYSO3x//KZTXG6yv2dZ3NcZk20NbjruJN9Xn8+zo86d+e94GBeKk5SizQIKzkTw9NBTZSnlR8ipikN2uBVs8=
X-Received: by 2002:a0c:b88e:: with SMTP id y14mr29883517qvf.93.1562144062650; 
	Wed, 03 Jul 2019 01:54:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190430110032.25301-1-hch@lst.de>
	<20190430110032.25301-6-hch@lst.de>
	<20190430201041.536amvinrcvd2wua@pburton-laptop>
	<20190430202947.GA30262@lst.de>
	<20190430211105.ielntedm46uqamca@pburton-laptop>
	<20190501131339.GA890@lst.de>
	<20190501171355.7wnrutfnax5djkpx@pburton-laptop>
	<20190603064855.GA22023@lst.de>
In-Reply-To: <20190603064855.GA22023@lst.de>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 3 Jul 2019 10:54:05 +0200
Message-ID: <CAK8P3a0+mmc_DsHZZeM85xGUUB8zc50ROUu3=i3UN1XwD8UGeQ@mail.gmail.com>
Subject: Re: [PATCH 5/7 v2] MIPS: use the generic uncached segment support in
	dma-direct
To: Christoph Hellwig <hch@lst.de>
Cc: Michal Simek <monstr@monstr.eu>,
	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
	James Hogan <jhogan@kernel.org>,
	"linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
	Ralf Baechle <ralf@linux-mips.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Paul Burton <paul.burton@mips.com>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	"linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
	Ley Foon Tan <lftan@altera.com>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

T24gTW9uLCBKdW4gMywgMjAxOSBhdCA4OjUwIEFNIENocmlzdG9waCBIZWxsd2lnIDxoY2hAbHN0
LmRlPiB3cm90ZToKPgo+IE9uIFdlZCwgTWF5IDAxLCAyMDE5IGF0IDA1OjEzOjU3UE0gKzAwMDAs
IFBhdWwgQnVydG9uIHdyb3RlOgo+ID4gSGkgQ2hyaXN0b3BoLAo+ID4KPiA+IE9uIFdlZCwgTWF5
IDAxLCAyMDE5IGF0IDAzOjEzOjM5UE0gKzAyMDAsIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOgo+
ID4gPiBTdG9wIHByb3ZpZGluZyBvdXIgYXJjaCBhbGxvYy9mcmVlIGhvb2tzIGFuZCBqdXN0IGV4
cG9zZSB0aGUgc2VnbWVudAo+ID4gPiBvZmZzZXQgaW5zdGVhZC4KPiA+ID4KPiA+ID4gU2lnbmVk
LW9mZi1ieTogQ2hyaXN0b3BoIEhlbGx3aWcgPGhjaEBsc3QuZGU+Cj4gPiA+IC0tLQo+ID4gPiAg
YXJjaC9taXBzL0tjb25maWcgICAgICAgICAgICAgIHwgIDEgKwo+ID4gPiAgYXJjaC9taXBzL2lu
Y2x1ZGUvYXNtL3BhZ2UuaCAgIHwgIDMgLS0tCj4gPiA+ICBhcmNoL21pcHMvamF6ei9qYXp6ZG1h
LmMgICAgICAgfCAgNiAtLS0tLS0KPiA+ID4gIGFyY2gvbWlwcy9tbS9kbWEtbm9uY29oZXJlbnQu
YyB8IDI2ICsrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tCj4gPiA+ICA0IGZpbGVzIGNoYW5nZWQs
IDEwIGluc2VydGlvbnMoKyksIDI2IGRlbGV0aW9ucygtKQo+ID4KPiA+IFRoaXMgb25lIGxvb2tz
IGdvb2QgdG8gbWUgbm93LCBmb3IgcGF0Y2hlcyAxICYgNToKPiA+Cj4gPiAgIEFja2VkLWJ5OiBQ
YXVsIEJ1cnRvbiA8cGF1bC5idXJ0b25AbWlwcy5jb20+Cj4KPiBUaGFua3MsIEkndmUgbWVyZ2Vk
IHRob3MgaW50byB0aGUgZG1hLW1hcHBpbmcgdHJlZS4KCkkgdGhpbmsgdGhpcyBpcyB0aGUgY2F1
c2Ugb2Ygc29tZSBrZXJuZWxjaSBmYWlsdXJlcyBpbiBjdXJyZW50CmxpbnV4LW5leHQgYnVpbGRz
OgoKaHR0cHM6Ly9rZXJuZWxjaS5vcmcvYnVpbGQvbmV4dC9icmFuY2gvbWFzdGVyL2tlcm5lbC9u
ZXh0LTIwMTkwNzAyLwoKYmlnc3VyX2RlZmNvbmZpZyDigJAgbWlwczMgd2FybmluZ3Mg4oCUIDEg
ZXJyb3IKY2F2aXVtX29jdGVvbl9kZWZjb25maWcg4oCQIG1pcHMzIHdhcm5pbmdzIOKAlCAxIGVy
cm9yCmlwMjdfZGVmY29uZmlnIOKAkCBtaXBzMyB3YXJuaW5ncyDigJQgMSBlcnJvcgpsb29uZ3Nv
bjNfZGVmY29uZmlnIOKAkCBtaXBzMyB3YXJuaW5ncyDigJQgMSBlcnJvcgptaXBzX3BhcmF2aXJ0
X2RlZmNvbmZpZyDigJAgbWlwczMgd2FybmluZ3Mg4oCUIDEgZXJyb3IKbmxtX3hscF9kZWZjb25m
aWcg4oCQIG1pcHMzIHdhcm5pbmdzIOKAlCAxIGVycm9yCm5sbV94bHJfZGVmY29uZmlnIOKAkCBt
aXBzMSB3YXJuaW5nIOKAlCAxIGVycm9yCgovaG9tZS9idWlsZHNsYXZlL3dvcmtzcGFjZS93b3Jr
c3BhY2Uva2VybmVsLWJ1aWxkQDgvbGludXgvYnVpbGQvLi4va2VybmVsL2RtYS9kaXJlY3QuYzox
NDQ6CnVuZGVmaW5lZCByZWZlcmVuY2UgdG8gYGFyY2hfZG1hX3ByZXBfY29oZXJlbnQnCjIvaG9t
ZS9idWlsZHNsYXZlL3dvcmtzcGFjZS9rZXJuZWwtYnVpbGQvbGludXgvYnVpbGQvLi4va2VybmVs
L2RtYS9kaXJlY3QuYzoxNDQ6CnVuZGVmaW5lZCByZWZlcmVuY2UgdG8gYGFyY2hfZG1hX3ByZXBf
Y29oZXJlbnQnCjIoLnRleHQrMHhhZmMpOiB1bmRlZmluZWQgcmVmZXJlbmNlIHRvIGBhcmNoX2Rt
YV9wcmVwX2NvaGVyZW50JwoxZGlyZWN0LmM6KC50ZXh0KzB4OTM0KTogdW5kZWZpbmVkIHJlZmVy
ZW5jZSB0byBgYXJjaF9kbWFfcHJlcF9jb2hlcmVudCcKMSgudGV4dCsweGI4NCk6IHVuZGVmaW5l
ZCByZWZlcmVuY2UgdG8gYGFyY2hfZG1hX3ByZXBfY29oZXJlbnQnCgpJIGhhdmVuJ3QgbG9va2Vk
IGludG8gdGhlIGRldGFpbHMsIGJ1dCBJIHN1c3BlY3QgYWxsIG1hY2hpbmVzCndpdGggY2FjaGUt
Y29oZXJlbnQgRE1BIGFyZSBicm9rZW4uCgogICAgICAgQXJuZApfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlz
dHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3Jn
L21haWxtYW4vbGlzdGluZm8vaW9tbXU=
