Return-Path: <SRS0=+ohw=SU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03F5AC10F0E
	for <iommu@archiver.kernel.org>; Thu, 18 Apr 2019 12:45:21 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4F5B2183E
	for <iommu@archiver.kernel.org>; Thu, 18 Apr 2019 12:45:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="GeETOI+n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4F5B2183E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 39AF216E8;
	Thu, 18 Apr 2019 12:45:16 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id DB6E61203
	for <iommu@lists.linux-foundation.org>;
	Thu, 18 Apr 2019 10:44:21 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-ua1-f68.google.com (mail-ua1-f68.google.com
	[209.85.222.68])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 58AEF108
	for <iommu@lists.linux-foundation.org>;
	Thu, 18 Apr 2019 10:44:21 +0000 (UTC)
Received: by mail-ua1-f68.google.com with SMTP id h4so603686uaj.9
	for <iommu@lists.linux-foundation.org>;
	Thu, 18 Apr 2019 03:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=j/effP+5iohMRocuBbn+wU3ZjTEdFsXMtMXgMIyP5mQ=;
	b=GeETOI+nF6LsuhqqtpSuoChbWH/UskTP93w2FqBAJ8suHcg5eru1GG26pM34rRqRIv
	B8WSV1vIoO/1nGhFp6RzC7tRx+dg46QqHS/n6VfCLXfkss6Wl+7f6WCCoYzQtCpy+Av9
	pK71SoS6mO5cCMQXP104i5sSYKE6Geh5ETamcgF6x60B8GK8filcjyPyvI1JHUkVFbsp
	MRDJlfZlESNOiFomQ0iE/paycPL/z00zxILDRgJ6z1hxx7TvFI07lkZ5PWG4KQ2p+24S
	lvWoZBjFQXQxvOE/FjegXCDh94aPaBSMmWJHMZZRUS76gPsOv6u8DX3QMmM3Wley22js
	9giQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=j/effP+5iohMRocuBbn+wU3ZjTEdFsXMtMXgMIyP5mQ=;
	b=NJimdMxsCGbyc+SCYHdounHkUMFusHJlTrYTdruzbQPGGDn7SR8kRgKYrNCMehtzps
	T+JTIhULOWBsCUlvMGy1JLNcUC+nTL03vBJIrrsBvTgm+y+I1XX3lcUVlmFb9lNQAL+N
	3wPS0XFX1wr+ht6b54pr28+ulvIx+9va9jM2BfBLKZa/yvsZvmctDfaqOpmtv0+z8lvg
	o4tYswBSe6oxGzG4wDR8vGRCR1/nokyBFML6U9vH2ZaFM6RqgADlAKwd0LFVMF/XIpzO
	w/dq/UP5eRdDaDzM62mp3sTeRPofdqNZ6hQPP2jXNR3djP0RRJoVqM8/eYB8WMIg3504
	Rurg==
X-Gm-Message-State: APjAAAWcZmrX1hFyw1JOoAam5lb5eNxGKPGOZgE3yNyrniCqQLQW3Ynq
	HLZqF4+VbR6RPCgRX28OB8WT37frU1i5SWzBb+AlTg==
X-Google-Smtp-Source: APXvYqwaHpp8DFAXY794irwZcMMDgalNDbI2Y+3MtD4mgFCui2zslWAkxHIQQmiBGvEI1Mqv5l7PN3Bzezpz5W4/g08=
X-Received: by 2002:ab0:44e:: with SMTP id 72mr49531989uav.110.1555584260078; 
	Thu, 18 Apr 2019 03:44:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190418084119.056416939@linutronix.de>
	<20190418084254.361284697@linutronix.de>
In-Reply-To: <20190418084254.361284697@linutronix.de>
Date: Thu, 18 Apr 2019 12:44:08 +0200
Message-ID:
 <CAG_fn=WP9+bVv9hedoaTzWK+xBzedxaGJGVOPnF0o115s-oWvg@mail.gmail.com>
Subject: Re: [patch V2 14/29] dm bufio: Simplify stack trace retrieval
To: Thomas Gleixner <tglx@linutronix.de>
X-Mailman-Approved-At: Thu, 18 Apr 2019 12:45:00 +0000
Cc: Mike Snitzer <snitzer@redhat.com>, David Airlie <airlied@linux.ie>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	dri-devel@lists.freedesktop.org,
	Linux Memory Management List <linux-mm@kvack.org>,
	dm-devel@redhat.com, Christoph Lameter <cl@linux.com>,
	Christoph Hellwig <hch@lst.de>, Alasdair Kergon <agk@redhat.com>,
	linux-arch@vger.kernel.org, x86@kernel.org,
	kasan-dev <kasan-dev@googlegroups.com>,
	David Rientjes <rientjes@google.com>,
	Andrey Ryabinin <aryabinin@virtuozzo.com>,
	Alexey Dobriyan <adobriyan@gmail.com>, intel-gfx@lists.freedesktop.org,
	Johannes Thumshirn <jthumshirn@suse.de>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Akinobu Mita <akinobu.mita@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>, Josef Bacik <josef@toxicpanda.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Mike Rapoport <rppt@linux.vnet.ibm.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
	David Sterba <dsterba@suse.com>,
	Dmitry Vyukov <dvyukov@google.com>, Chris Mason <clm@fb.com>,
	LKML <linux-kernel@vger.kernel.org>, Pekka Enberg <penberg@kernel.org>,
	iommu@lists.linux-foundation.org, Daniel Vetter <daniel@ffwll.ch>,
	Andrew Morton <akpm@linux-foundation.org>,
	Robin Murphy <robin.murphy@arm.com>, linux-btrfs@vger.kernel.org
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
From: Alexander Potapenko via iommu <iommu@lists.linux-foundation.org>
Reply-To: Alexander Potapenko <glider@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190418104408.MeBxyj-0rZkSRGrrtq7a5zHm8wSxmPF_LdYPGgx8jKc@z>

T24gVGh1LCBBcHIgMTgsIDIwMTkgYXQgMTE6MDYgQU0gVGhvbWFzIEdsZWl4bmVyIDx0Z2x4QGxp
bnV0cm9uaXguZGU+IHdyb3RlOgo+Cj4gUmVwbGFjZSB0aGUgaW5kaXJlY3Rpb24gdGhyb3VnaCBz
dHJ1Y3Qgc3RhY2tfdHJhY2Ugd2l0aCBhbiBpbnZvY2F0aW9uIG9mCj4gdGhlIHN0b3JhZ2UgYXJy
YXkgYmFzZWQgaW50ZXJmYWNlLgo+Cj4gU2lnbmVkLW9mZi1ieTogVGhvbWFzIEdsZWl4bmVyIDx0
Z2x4QGxpbnV0cm9uaXguZGU+Cj4gQ2M6IGRtLWRldmVsQHJlZGhhdC5jb20KPiBDYzogTWlrZSBT
bml0emVyIDxzbml0emVyQHJlZGhhdC5jb20+Cj4gQ2M6IEFsYXNkYWlyIEtlcmdvbiA8YWdrQHJl
ZGhhdC5jb20+Cj4gLS0tCj4gIGRyaXZlcnMvbWQvZG0tYnVmaW8uYyB8ICAgMTUgKysrKysrLS0t
LS0tLS0tCj4gIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDkgZGVsZXRpb25zKC0p
Cj4KPiAtLS0gYS9kcml2ZXJzL21kL2RtLWJ1ZmlvLmMKPiArKysgYi9kcml2ZXJzL21kL2RtLWJ1
ZmlvLmMKPiBAQCAtMTUwLDcgKzE1MCw3IEBAIHN0cnVjdCBkbV9idWZmZXIgewo+ICAgICAgICAg
dm9pZCAoKmVuZF9pbykoc3RydWN0IGRtX2J1ZmZlciAqLCBibGtfc3RhdHVzX3QpOwo+ICAjaWZk
ZWYgQ09ORklHX0RNX0RFQlVHX0JMT0NLX1NUQUNLX1RSQUNJTkcKPiAgI2RlZmluZSBNQVhfU1RB
Q0sgMTAKPiAtICAgICAgIHN0cnVjdCBzdGFja190cmFjZSBzdGFja190cmFjZTsKPiArICAgICAg
IHVuc2lnbmVkIGludCBzdGFja19sZW47Cj4gICAgICAgICB1bnNpZ25lZCBsb25nIHN0YWNrX2Vu
dHJpZXNbTUFYX1NUQUNLXTsKPiAgI2VuZGlmCj4gIH07Cj4gQEAgLTIzMiwxMSArMjMyLDcgQEAg
c3RhdGljIERFRklORV9NVVRFWChkbV9idWZpb19jbGllbnRzX2xvYwo+ICAjaWZkZWYgQ09ORklH
X0RNX0RFQlVHX0JMT0NLX1NUQUNLX1RSQUNJTkcKPiAgc3RhdGljIHZvaWQgYnVmZmVyX3JlY29y
ZF9zdGFjayhzdHJ1Y3QgZG1fYnVmZmVyICpiKQo+ICB7Cj4gLSAgICAgICBiLT5zdGFja190cmFj
ZS5ucl9lbnRyaWVzID0gMDsKPiAtICAgICAgIGItPnN0YWNrX3RyYWNlLm1heF9lbnRyaWVzID0g
TUFYX1NUQUNLOwo+IC0gICAgICAgYi0+c3RhY2tfdHJhY2UuZW50cmllcyA9IGItPnN0YWNrX2Vu
dHJpZXM7Cj4gLSAgICAgICBiLT5zdGFja190cmFjZS5za2lwID0gMjsKPiAtICAgICAgIHNhdmVf
c3RhY2tfdHJhY2UoJmItPnN0YWNrX3RyYWNlKTsKPiArICAgICAgIGItPnN0YWNrX2xlbiA9IHN0
YWNrX3RyYWNlX3NhdmUoYi0+c3RhY2tfZW50cmllcywgTUFYX1NUQUNLLCAyKTsKQXMgbm90ZWQg
aW4gb25lIG9mIHNpbWlsYXIgcGF0Y2hlcyBiZWZvcmUsIGNhbiB3ZSBoYXZlIGFuIGlubGluZQpj
b21tZW50IHRvIGluZGljYXRlIHdoYXQgZG9lcyB0aGlzICIyIiBzdGFuZCBmb3I/Cj4gIH0KPiAg
I2VuZGlmCj4KPiBAQCAtNDM4LDcgKzQzNCw3IEBAIHN0YXRpYyBzdHJ1Y3QgZG1fYnVmZmVyICph
bGxvY19idWZmZXIoc3QKPiAgICAgICAgIGFkanVzdF90b3RhbF9hbGxvY2F0ZWQoYi0+ZGF0YV9t
b2RlLCAobG9uZyljLT5ibG9ja19zaXplKTsKPgo+ICAjaWZkZWYgQ09ORklHX0RNX0RFQlVHX0JM
T0NLX1NUQUNLX1RSQUNJTkcKPiAtICAgICAgIG1lbXNldCgmYi0+c3RhY2tfdHJhY2UsIDAsIHNp
emVvZihiLT5zdGFja190cmFjZSkpOwo+ICsgICAgICAgYi0+c3RhY2tfbGVuID0gMDsKPiAgI2Vu
ZGlmCj4gICAgICAgICByZXR1cm4gYjsKPiAgfQo+IEBAIC0xNTIwLDggKzE1MTYsOSBAQCBzdGF0
aWMgdm9pZCBkcm9wX2J1ZmZlcnMoc3RydWN0IGRtX2J1ZmlvCj4gICAgICAgICAgICAgICAgICAg
ICAgICAgRE1FUlIoImxlYWtlZCBidWZmZXIgJWxseCwgaG9sZCBjb3VudCAldSwgbGlzdCAlZCIs
Cj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKHVuc2lnbmVkIGxvbmcgbG9uZyliLT5i
bG9jaywgYi0+aG9sZF9jb3VudCwgaSk7Cj4gICNpZmRlZiBDT05GSUdfRE1fREVCVUdfQkxPQ0tf
U1RBQ0tfVFJBQ0lORwo+IC0gICAgICAgICAgICAgICAgICAgICAgIHByaW50X3N0YWNrX3RyYWNl
KCZiLT5zdGFja190cmFjZSwgMSk7Cj4gLSAgICAgICAgICAgICAgICAgICAgICAgYi0+aG9sZF9j
b3VudCA9IDA7IC8qIG1hcmsgdW5jbGFpbWVkIHRvIGF2b2lkIEJVR19PTiBiZWxvdyAqLwo+ICsg
ICAgICAgICAgICAgICAgICAgICAgIHN0YWNrX3RyYWNlX3ByaW50KGItPnN0YWNrX2VudHJpZXMs
IGItPnN0YWNrX2xlbiwgMSk7Cj4gKyAgICAgICAgICAgICAgICAgICAgICAgLyogbWFyayB1bmNs
YWltZWQgdG8gYXZvaWQgQlVHX09OIGJlbG93ICovCj4gKyAgICAgICAgICAgICAgICAgICAgICAg
Yi0+aG9sZF9jb3VudCA9IDA7Cj4gICNlbmRpZgo+ICAgICAgICAgICAgICAgICB9Cj4KPgo+CgoK
LS0gCkFsZXhhbmRlciBQb3RhcGVua28KU29mdHdhcmUgRW5naW5lZXIKCkdvb2dsZSBHZXJtYW55
IEdtYkgKRXJpa2EtTWFubi1TdHJhw59lLCAzMwo4MDYzNiBNw7xuY2hlbgoKR2VzY2jDpGZ0c2bD
vGhyZXI6IFBhdWwgTWFuaWNsZSwgSGFsaW1haCBEZUxhaW5lIFByYWRvClJlZ2lzdGVyZ2VyaWNo
dCB1bmQgLW51bW1lcjogSGFtYnVyZywgSFJCIDg2ODkxClNpdHogZGVyIEdlc2VsbHNjaGFmdDog
SGFtYnVyZwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpp
b21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6
Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
