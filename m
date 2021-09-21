Return-Path: <SRS0=55Rd=OL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 200ACC433EF
	for <iommu@archiver.kernel.org>; Tue, 21 Sep 2021 15:22:03 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEC9261165
	for <iommu@archiver.kernel.org>; Tue, 21 Sep 2021 15:22:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BEC9261165
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 782DD82897;
	Tue, 21 Sep 2021 15:22:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id synq_clP6aYy; Tue, 21 Sep 2021 15:22:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 3938782881;
	Tue, 21 Sep 2021 15:22:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 132D8C000F;
	Tue, 21 Sep 2021 15:22:01 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CACC0C000D
 for <iommu@lists.linux-foundation.org>; Tue, 21 Sep 2021 15:22:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C75DA60656
 for <iommu@lists.linux-foundation.org>; Tue, 21 Sep 2021 15:22:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zL60PpkhqZaw for <iommu@lists.linux-foundation.org>;
 Tue, 21 Sep 2021 15:21:59 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com
 [IPv6:2a00:1450:4864:20::12e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A92F0605E6
 for <iommu@lists.linux-foundation.org>; Tue, 21 Sep 2021 15:21:59 +0000 (UTC)
Received: by mail-lf1-x12e.google.com with SMTP id u18so7010947lfd.12
 for <iommu@lists.linux-foundation.org>; Tue, 21 Sep 2021 08:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=USVqWZAArbWUQLUtDtlQScPgCmgWeWDYUhPzzmzD9cE=;
 b=d+NekTAs6gdVeYOh1ETzFjnosk7b11Jkdp85cE2xaXNQHzds4fG/DaeBvLIWZok/bT
 8zlNB+vm+Lbp7HjZs0gwvcYkuGEzY4rYubjc8U1WV2ZAjOWge59m9LsdytVZhYAyMyh/
 kVUQqPb9S0H0ijHCFY4LkH7mywcT7P6bh7o5IlSwYZH7OErFPJB2l4n+nF1KREawE9Oh
 9pmHHaVkxCTRT5jOSCSHVffxNpywbXL6aTBdOBwwCr58FHR1JN9q9xV+0XT8s4DT/5fV
 iByIBKgKwoPVX0GWHFhW7mS1NofIUrEaPpVKSfuC2qDpTtF239YZNsypjKQ+zQwPcaL2
 R2pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=USVqWZAArbWUQLUtDtlQScPgCmgWeWDYUhPzzmzD9cE=;
 b=FJ7ND5OYsQTNSmDGFCnwMX4VAsHsa7EW4JX5FThXZ6J85TZ+nVAy6Ns964A3e7rI+6
 MvuY56kCXRtcb+xkO9MXcKjFEMlA/2LgLW6wHoAyeC7ne5at8Qq9yTm7EOUZkyOP0kIf
 t9jw/1CsDbMfQzxSuMC2J6ZBXSowdJxqNGcLwpUthfcwULi2yEnRCnHkOFV8AyadrBAG
 mnC2BBAhagC2gY0NdGkxQp522YSnIo2i6BmkZ4Hf+sdNZYaxjSzS5I3mQtBhr3Zp/+O5
 nYGySNExieBZgf+eBj2/47R0NWd0A7X64EAH/gd/OBdxGC+HiD48Hy/reB0VPWQ6mvld
 FPyQ==
X-Gm-Message-State: AOAM531XmotCf02U36xpMoIBMGWg5yz5+W6/+u79lN+IU31+vVXbohy9
 e1NXbXh802WPXUlOfzplmQJ2QEjfprGaLhh7jX4=
X-Google-Smtp-Source: ABdhPJzthr3WA2wFCeyKG586GKIXPx3EL+AR4pi1b9V0CS7EWWEg72SpC7PGxABChTKUmIl/7el5hhGdi65vVZvbKIY=
X-Received: by 2002:a19:ca03:: with SMTP id a3mr22741135lfg.176.1632237637561; 
 Tue, 21 Sep 2021 08:20:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210914151016.3174924-1-Roman_Skakun@epam.com>
 <7c04db79-7de1-93ff-0908-9bad60a287b9@suse.com>
 <CADu_u-Ou08tMFm5xU871ae8ct+2YOuvn4rQ=83CMTbg2bx87Pg@mail.gmail.com>
 <84ef7ff7-2c9c-113a-4a2c-cef54a6ded51@suse.com>
 <20210915135321.GA15216@lst.de>
 <CADu_u-OZzgVj+z=iD6kUQOZxUufF5QSMR6-MmpN_hLZ9PyQJhQ@mail.gmail.com>
 <eb98aeac-af61-0dd6-2052-5b55921746c1@arm.com>
In-Reply-To: <eb98aeac-af61-0dd6-2052-5b55921746c1@arm.com>
From: Roman Skakun <rm.skakun@gmail.com>
Date: Tue, 21 Sep 2021 18:20:29 +0300
Message-ID: <CADu_u-O-aDk-J4up-UMfjMGi0DJkD6rhePcKdyqzt5750oo-iA@mail.gmail.com>
Subject: Re: [PATCH] swiotlb: set IO TLB segment size via cmdline
To: Robin Murphy <robin.murphy@arm.com>
Cc: Roman Skakun <rm.skakun@gmail.com>, linux-doc@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>, Viresh Kumar <viresh.kumar@linaro.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Paul Mackerras <paulus@samba.org>, Jan Beulich <jbeulich@suse.com>,
 Will Deacon <will@kernel.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Stefano Stabellini <sstabellini@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Michael Ellerman <mpe@ellerman.id.au>, Christoph Hellwig <hch@lst.de>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 xen-devel@lists.xenproject.org, "Paul E. McKenney" <paulmck@kernel.org>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Muchun Song <songmuchun@bytedance.com>, Thomas Gleixner <tglx@linutronix.de>,
 Juergen Gross <jgross@suse.com>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Andrii Anisov <andrii_anisov@epam.com>, Randy Dunlap <rdunlap@infradead.org>,
 linux-mips@vger.kernel.org, iommu <iommu@lists.linux-foundation.org>,
 Roman Skakun <roman_skakun@epam.com>,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 Mike Rapoport <rppt@kernel.org>, "Maciej W. Rozycki" <macro@orcam.me.uk>
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

SGkgUm9iaW4sCgo+PiBJIHVzZSBYZW4gUFYgZGlzcGxheS4gSW4gbXkgY2FzZSwgUFYgZGlzcGxh
eSBiYWNrZW5kKERvbTApIGFsbG9jYXRlcwo+PiBjb250aWd1b3VzIGJ1ZmZlciB2aWEgRE1BLUFQ
SSB0bwo+PiB0byBpbXBsZW1lbnQgemVyby1jb3B5IGJldHdlZW4gRG9tMCBhbmQgRG9tVS4KPj4K
PiBXZWxsLCBzb21ldGhpbmcncyBnb25lIGJhZGx5IHdyb25nIHRoZXJlIC0gaWYgeW91IGhhdmUg
dG8gc2hhZG93IHRoZQo+IGVudGlyZSB0aGluZyBpbiBhIGJvdW5jZSBidWZmZXIgdG8gaW1wb3J0
IGl0IHRoZW4gaXQncyBoYXJkbHkgemVyby1jb3B5LAo+IGlzIGl0PyBJZiB5b3Ugd2FudCB0byBk
byBidWZmZXIgc2hhcmluZyB0aGUgYnVmZmVyIHJlYWxseSBuZWVkcyB0byBiZQo+IGFsbG9jYXRl
ZCBhcHByb3ByaWF0ZWx5IHRvIGJlZ2luIHdpdGgsIHN1Y2ggdGhhdCBhbGwgcmVsZXZhbnQgZGV2
aWNlcwo+IGNhbiBhY2Nlc3MgaXQgZGlyZWN0bHkuIFRoYXQgbWlnaHQgYmUgc29tZXRoaW5nIHdo
aWNoIG5lZWRzIGZpeGluZyBpbiBYZW4uCj4KClJpZ2h0LCBpbiBjYXNlIHdoZW4gd2Ugd2FudCB0
byB1c2UgYSB6ZXJvLWNvcHkgYXBwcm9hY2ggbmVlZCB0byBhdm9pZAp1c2luZyBzd2lvdGxiCmJv
dW5jZSBidWZmZXIgZm9yIGFsbCBkZXZpY2VzIHdoaWNoIGlzIHBvdGVudGlhbGx5IHVzaW5nIHRo
aXMgYnVmZmVyLgpUaGUgcm9vdCBvZiB0aGUgcHJvYmxlbSBpcyB0aGF0IHRoaXMgYnVmZmVyIG1h
cHBlZCB0byBmb3JlaWduIHBhZ2VzCmFuZCB3aGVuIEkgdHJpZWQgdG8KcmV0cmlldmUgZG1hX2Fk
ZHIgZm9yIHRoaXMgYnVmZmVyIEkgZ290IGEgZm9yZWlnbiBNRk4gdGhhdCBiaWdnZXIgdGhhbgoz
MiBiaXQgYW5kIHN3aW90bGIgdHJpZXMgdG8KdXNlIGJvdW5jZSBidWZmZXIuCkkgdW5kZXJzdG9v
ZCwgdGhhdCwgbmVlZCB0byBmaW5kIGEgd2F5IHRvIGF2b2lkIHVzaW5nIHN3aW90bGIgaW4gdGhp
cyBjYXNlLgpBdCB0aGUgbW9tZW50LCBpdCdzIHVuY2xlYXIgaG93IHRvIGRvIHRoaXMgcHJvcGVy
bHkuCkJ1dCwgdGhpcyBpcyBhbm90aGVyIHN0b3J5Li4uCgpJIGd1ZXNzLCB3ZSBjYW4gaGF2ZSB0
aGUgc2l0dWF0aW9uIHdoZW4gc29tZSBkZXZpY2UgbGlrZSByY2FyLWR1IG5lZWRzCnRvIHVzZSBh
IHN1ZmZpY2llbnRseSBsYXJnZQpidWZmZXIgd2hpY2ggaXMgZ3JlYXRlciB0aGFuIDI1NiBLQiAo
MTI4KENVUlJFTlRfSU9fVExCX1NFR01FTlQgKgoyMDQ4KSBhbmQgbmVlZCB0bwphZGp1c3QgdGhp
cyBwYXJhbWV0ZXIgZHVyaW5nIGJvb3QgdGltZSwgbm90IGNvbXBpbGF0aW9uIHRpbWUuCkluIG9y
ZGVyIHRvIHRoaXMgcG9pbnQsIHRoaXMgcGF0Y2ggd2FzIGNyZWF0ZWQuCgpUaGFua3MsClJvbWFu
CgrQv9GCLCAxNyDRgdC10L3Rgi4gMjAyMSDQsy4g0LIgMTI6NDQsIFJvYmluIE11cnBoeSA8cm9i
aW4ubXVycGh5QGFybS5jb20+Ogo+Cj4gT24gMjAyMS0wOS0xNyAxMDozNiwgUm9tYW4gU2tha3Vu
IHdyb3RlOgo+ID4gSGksIENocmlzdG9waAo+ID4KPiA+IEkgdXNlIFhlbiBQViBkaXNwbGF5LiBJ
biBteSBjYXNlLCBQViBkaXNwbGF5IGJhY2tlbmQoRG9tMCkgYWxsb2NhdGVzCj4gPiBjb250aWd1
b3VzIGJ1ZmZlciB2aWEgRE1BLUFQSSB0bwo+ID4gdG8gaW1wbGVtZW50IHplcm8tY29weSBiZXR3
ZWVuIERvbTAgYW5kIERvbVUuCj4KPiBXZWxsLCBzb21ldGhpbmcncyBnb25lIGJhZGx5IHdyb25n
IHRoZXJlIC0gaWYgeW91IGhhdmUgdG8gc2hhZG93IHRoZQo+IGVudGlyZSB0aGluZyBpbiBhIGJv
dW5jZSBidWZmZXIgdG8gaW1wb3J0IGl0IHRoZW4gaXQncyBoYXJkbHkgemVyby1jb3B5LAo+IGlz
IGl0PyBJZiB5b3Ugd2FudCB0byBkbyBidWZmZXIgc2hhcmluZyB0aGUgYnVmZmVyIHJlYWxseSBu
ZWVkcyB0byBiZQo+IGFsbG9jYXRlZCBhcHByb3ByaWF0ZWx5IHRvIGJlZ2luIHdpdGgsIHN1Y2gg
dGhhdCBhbGwgcmVsZXZhbnQgZGV2aWNlcwo+IGNhbiBhY2Nlc3MgaXQgZGlyZWN0bHkuIFRoYXQg
bWlnaHQgYmUgc29tZXRoaW5nIHdoaWNoIG5lZWRzIGZpeGluZyBpbiBYZW4uCj4KPiBSb2Jpbi4K
Pgo+ID4gV2hlbiBJIHN0YXJ0IFdlc3RvbiB1bmRlciBEb21VLCBJIGdvdCB0aGUgbmV4dCBsb2cg
aW4gRG9tMDoKPiA+IGBgYAo+ID4gWyAxMTIuNTU0NDcxXSBDUFU6IDAgUElEOiAzNjcgQ29tbTog
d2VzdG9uIFRhaW50ZWQ6IEcgTwo+ID4gNS4xMC4wLXlvY3RvLXN0YW5kYXJkKyAjMzEyCj4gPiBb
IDExMi41NzUxNDldIENhbGwgdHJhY2U6Cj4gPiBbIDExMi41Nzc2NjZdIGR1bXBfYmFja3RyYWNl
KzB4MC8weDFiMAo+ID4gWyAxMTIuNTgxMzczXSBzaG93X3N0YWNrKzB4MTgvMHg3MAo+ID4gWyAx
MTIuNTg0NzQ2XSBkdW1wX3N0YWNrKzB4ZDAvMHgxMmMKPiA+IFsgMTEyLjU4ODIwMF0gc3dpb3Rs
Yl90YmxfbWFwX3NpbmdsZSsweDIzNC8weDM2MAo+ID4gWyAxMTIuNTkyNzgxXSB4ZW5fc3dpb3Rs
Yl9tYXBfcGFnZSsweGU0LzB4NGMwCj4gPiBbIDExMi41OTcwOTVdIHhlbl9zd2lvdGxiX21hcF9z
ZysweDg0LzB4MTJjCj4gPiBbIDExMi42MDEyNDldIGRtYV9tYXBfc2dfYXR0cnMrMHg1NC8weDYw
Cj4gPiBbIDExMi42MDUxMzhdIHZzcDFfZHVfbWFwX3NnKzB4MzAvMHg2MAo+ID4gWyAxMTIuNjA4
ODUxXSByY2FyX2R1X3ZzcF9tYXBfZmIrMHgxMzQvMHgxNzAKPiA+IFsgMTEyLjYxMzA4Ml0gcmNh
cl9kdV92c3BfcGxhbmVfcHJlcGFyZV9mYisweDQ0LzB4NjQKPiA+IFsgMTEyLjYxODAwN10gZHJt
X2F0b21pY19oZWxwZXJfcHJlcGFyZV9wbGFuZXMrMHhhYy8weDE2MAo+ID4gWyAxMTIuNjIzMzYy
XSBkcm1fYXRvbWljX2hlbHBlcl9jb21taXQrMHg4OC8weDM5MAo+ID4gWyAxMTIuNjI4MDI5XSBk
cm1fYXRvbWljX25vbmJsb2NraW5nX2NvbW1pdCsweDRjLzB4NjAKPiA+IFsgMTEyLjYzMzA0M10g
ZHJtX21vZGVfYXRvbWljX2lvY3RsKzB4OWE4LzB4YjBjCj4gPiBbIDExMi42Mzc1MzJdIGRybV9p
b2N0bF9rZXJuZWwrMHhjNC8weDExYwo+ID4gWyAxMTIuNjQxNTA2XSBkcm1faW9jdGwrMHgyMWMv
MHg0NjAKPiA+IFsgMTEyLjY0NDk2N10gX19hcm02NF9zeXNfaW9jdGwrMHhhOC8weGYwCj4gPiBb
IDExMi42NDg5MzldIGVsMF9zdmNfY29tbW9uLmNvbnN0cHJvcC4wKzB4NzgvMHgxYTAKPiA+IFsg
MTEyLjY1Mzc3NV0gZG9fZWwwX3N2YysweDI0LzB4OTAKPiA+IFsgMTEyLjY1NzE0OF0gZWwwX3N2
YysweDE0LzB4MjAKPiA+IFsgMTEyLjY2MDI1NF0gZWwwX3N5bmNfaGFuZGxlcisweDFhNC8weDFi
MAo+ID4gWyAxMTIuNjY0MzE1XSBlbDBfc3luYysweDE3NC8weDE4MAo+ID4gWyAxMTIuNjY4MTQ1
XSByY2FyLWZjcCBmZWEyZjAwMC5mY3A6IHN3aW90bGIgYnVmZmVyIGlzIGZ1bGwgKHN6Ogo+ID4g
MzY4NjQwMCBieXRlcyksIHRvdGFsIDY1NTM2IChzbG90cyksIHVzZWQgMTEyIChzbG90cykKPiA+
IGBgYAo+ID4gVGhlIHByb2JsZW0gaXMgaGFwcGVuZWQgaGVyZToKPiA+IGh0dHBzOi8vZWxpeGly
LmJvb3RsaW4uY29tL2xpbnV4L3Y1LjE0LjQvc291cmNlL2RyaXZlcnMvZ3B1L2RybS9yY2FyLWR1
L3JjYXJfZHVfdnNwLmMjTDIwMgo+ID4KPiA+IFNndCB3YXMgY3JlYXRlZCBpbiBkbWFfZ2V0X3Nn
dGFibGUoKSBieSBkbWFfY29tbW9uX2dldF9zZ3RhYmxlKCkgYW5kCj4gPiBpbmNsdWRlcyBhIHNp
bmdsZSBwYWdlIGNodW5rCj4gPiBhcyBzaG93biBoZXJlOgo+ID4gaHR0cHM6Ly9lbGl4aXIuYm9v
dGxpbi5jb20vbGludXgvdjUuMTQuNS9zb3VyY2Uva2VybmVsL2RtYS9vcHNfaGVscGVycy5jI0wx
OAo+ID4KPiA+IEFmdGVyIGNyZWF0aW5nIGEgbmV3IHNndCwgd2UgdHJpZWQgdG8gbWFwIHRoaXMg
c2d0IHRocm91Z2ggdnNwMV9kdV9tYXBfc2coKS4KPiA+IEludGVybmFsbHksIHZzcDFfZHVfbWFw
X3NnKCkgdXNpbmcgb3BzLT5tYXBfc2cgKGUuZwo+ID4geGVuX3N3aW90bGJfbWFwX3NnKSB0byBw
ZXJmb3JtCj4gPiBtYXBwaW5nLgo+ID4KPiA+IEkgcmVhbGl6ZWQgdGhhdCByZXF1aXJlZCBzZWdt
ZW50IGlzIHRvbyBiaWcgdG8gYmUgZml0dGVkIHRvIGRlZmF1bHQKPiA+IHN3aW90bGIgc2VnbWVu
dCBhbmQgY29uZGl0aW9uCj4gPiBodHRwczovL2VsaXhpci5ib290bGluLmNvbS9saW51eC9sYXRl
c3Qvc291cmNlL2tlcm5lbC9kbWEvc3dpb3RsYi5jI0w0NzQKPiA+IGlzIGFsd2F5cyBmYWxzZS4K
PiA+Cj4gPiBJIGtub3cgdGhhdCBJIHVzZSBhIGxhcmdlIGJ1ZmZlciwgYnV0IHdoeSBjYW4ndCBJ
IG1hcCB0aGlzIGJ1ZmZlciBpbiBvbmUgY2h1bms/Cj4gPgo+ID4gVGhhbmtzIQo+ID4KPiA+INGB
0YAsIDE1INGB0LXQvdGCLiAyMDIxINCzLiDQsiAxNjo1MywgQ2hyaXN0b3BoIEhlbGx3aWcgPGhj
aEBsc3QuZGU+Ogo+ID4+Cj4gPj4gT24gV2VkLCBTZXAgMTUsIDIwMjEgYXQgMDM6NDk6NTJQTSAr
MDIwMCwgSmFuIEJldWxpY2ggd3JvdGU6Cj4gPj4+IEJ1dCB0aGUgcXVlc3Rpb24gcmVtYWluczog
V2h5IGRvZXMgdGhlIGZyYW1lYnVmZmVyIG5lZWQgdG8gYmUgbWFwcGVkCj4gPj4+IGluIGEgc2lu
Z2xlIGdpYW50IGNodW5rPwo+ID4+Cj4gPj4gTW9yZSBpbXBvcnRhbnRseTogaWYgeW91IHVzZSBk
eW5hbWljIGRtYSBtYXBwaW5ncyBmb3IgeW91ciBmcmFtZWJ1ZmZlcgo+ID4+IHlvdSdyZSBkb2lu
ZyBzb21ldGhpbmcgd3JvbmcuCj4gPgo+ID4KPiA+CgoKCi0tIApCZXN0IFJlZ2FyZHMsIFJvbWFu
LgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBt
YWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0
cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
