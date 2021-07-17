Return-Path: <SRS0=ss7l=MJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1D40C636C9
	for <iommu@archiver.kernel.org>; Sat, 17 Jul 2021 08:39:39 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 562F5613C3
	for <iommu@archiver.kernel.org>; Sat, 17 Jul 2021 08:39:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 562F5613C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1B6D983CC2;
	Sat, 17 Jul 2021 08:39:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id b4qVjOKfHCBO; Sat, 17 Jul 2021 08:39:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id E358083B04;
	Sat, 17 Jul 2021 08:39:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8C736C0010;
	Sat, 17 Jul 2021 08:39:37 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A21C3C000E
 for <iommu@lists.linux-foundation.org>; Sat, 17 Jul 2021 08:39:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 90A7A83B24
 for <iommu@lists.linux-foundation.org>; Sat, 17 Jul 2021 08:39:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lNl-hg2QJJiZ for <iommu@lists.linux-foundation.org>;
 Sat, 17 Jul 2021 08:39:34 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com
 [IPv6:2a00:1450:4864:20::22a])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9E0DF83B04
 for <iommu@lists.linux-foundation.org>; Sat, 17 Jul 2021 08:39:34 +0000 (UTC)
Received: by mail-lj1-x22a.google.com with SMTP id s18so17427237ljg.7
 for <iommu@lists.linux-foundation.org>; Sat, 17 Jul 2021 01:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=L/Ph4KXH21cp1cKWqCha4JghboKhxeBssRdrgGEsZ/g=;
 b=NFuCS2VLQWPpHzhymx9nA39Hfr7bWiXg/IN9dUX+ZiJ4zU2AcVuWqCxkeX430TJ57H
 F1HczOYd4Fqt5nMNvkujGGhZ7a6Yt3BzgJ1mEsDSK4dbswVO6I6ycwiRkB8dzw3WSNJ8
 i1Lde1EJD5oy0SXRCDwtPzqmdw4wC5iqWY4e7hE0pfb0jE8P23WSfRDoh2xfVw+UBYfX
 Q8n8aqRkqMrt3KEqKQ7EqoWuf8IbB/rBR7xbRSZYEZ0sclhldvqqcSUFMybD15jsW8j/
 N5oJ4eBNBJV278RQOPlJ8/CGf/Slr+xDsFLGv1Dg9aP4tg4SZ3aWwWKnci15i8i7VM+u
 rb+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=L/Ph4KXH21cp1cKWqCha4JghboKhxeBssRdrgGEsZ/g=;
 b=EzsLNvQjspnwsbskO2IuB5OoGmmaL+/jVmjjLTRzQiJm0pmt09ttpl+vGFgb2kCSs1
 FQzwnNcc6j3YRgIcj3I14Tu8J6IHcAvzKNoBkBe5510K+XI3UKubHA5eA8D15lHkHPSj
 wyUrPonuoHhY8QFhxPvs6L6NxkJaXQgp41PmJmImcyykFRDnXg/C51hacHA23bEC4rsw
 oE2+oBFTxQvBFkQD1iBrYwbgGZDmvkGducwwLtr4velV2W5qzF3+QyWqQl9BM2eUFaCi
 4eYt95jr6XmFsPMMXTnWOcypVlqGopvtu++qMRSuhbRfyvW5OKg/zMZ/AG8OyKDBUrAD
 bCiA==
X-Gm-Message-State: AOAM532dOtiLo/xpAdT/z0hNVSQrIzuFPU/zTTBRthgNMIW7TLP88fC8
 J7OzJnmk+WuR5Yi4ctjw+uDsb/gO8L30oK26P1E=
X-Google-Smtp-Source: ABdhPJyeRjTAQ3mrnLTYgab+MKBgvatMXBQP3Edmgnib1kkC6/oA7N1ZXSWANCX4akcXxJ45BHA43lcfioCMHsjfSIU=
X-Received: by 2002:a2e:700f:: with SMTP id l15mr12600105ljc.149.1626511172469; 
 Sat, 17 Jul 2021 01:39:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210715170011.GA17324@lst.de>
 <20210716083934.154992-1-rm.skakun@gmail.com>
 <20210716093551.GA17981@lst.de>
 <CADu_u-OYA+Z_y-DBLxyUYGhmLVMtLggmZ_SnRiEtw9EGrO4oGg@mail.gmail.com>
 <alpine.DEB.2.21.2107160828430.3916@sstabellini-ThinkPad-T480s>
In-Reply-To: <alpine.DEB.2.21.2107160828430.3916@sstabellini-ThinkPad-T480s>
From: Roman Skakun <rm.skakun@gmail.com>
Date: Sat, 17 Jul 2021 11:39:21 +0300
Message-ID: <CADu_u-Psn5QpOyZ18_NCPx14DYxmGmSqVod=_RBC3A_A93tGUw@mail.gmail.com>
Subject: Re: [PATCH v2] dma-mapping: use vmalloc_to_page for vmalloc addresses
To: Christoph Hellwig <hch@lst.de>, Stefano Stabellini <sstabellini@kernel.org>
Cc: Juergen Gross <jgross@suse.com>, Andrii Anisov <andrii_anisov@epam.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
 linux-kernel@vger.kernel.org, Roman Skakun <rm.skakun@gmail.com>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 iommu@lists.linux-foundation.org, Roman Skakun <Roman_Skakun@epam.com>,
 xen-devel@lists.xenproject.org, Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Volodymyr Babchuk <volodymyr_babchuk@epam.com>
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

PiBXZSBjYW4gbWVyZ2UgdGhpcyBwYXRjaCBhbmQgY3JlYXRlIGEgbmV3IG9uZSBmb3IKPiB4ZW5f
c3dpb3RsYl9mcmVlX2NvaGVyZW50KCkgbGF0ZXIuCj4gWWVhaCwgbm8gd29ycmllcywgSSBkaWRu
J3Qga25vdyB0aGF0IGV4cG9zaW5nIGRtYV9jb21tb25fdmFkZHJfdG9fcGFnZQo+IHdhcyBwcm9i
bGVtYXRpYy4KPgo+IFRoaXMgcGF0Y2ggaXMgZmluZSBieSBtZS4KCkdvb2QuIEknbSBhZ3JlZWQg
dG9vLiBXYWl0aW5nIGZvciBDaHJpc3RvcGguCgrQv9GCLCAxNiDQuNGO0LsuIDIwMjEg0LMuINCy
IDE4OjI5LCBTdGVmYW5vIFN0YWJlbGxpbmkgPHNzdGFiZWxsaW5pQGtlcm5lbC5vcmc+Ogo+Cj4g
T24gRnJpLCAxNiBKdWwgMjAyMSwgUm9tYW4gU2tha3VuIHdyb3RlOgo+ID4gPiBUZWNobmljYWxs
eSB0aGlzIGxvb2tzIGdvb2QuICBCdXQgZ2l2ZW4gdGhhdCBleHBvc2luZyBhIGhlbHBlcgo+ID4g
PiB0aGF0IGRvZXMgZWl0aGVyIHZtYWxsb2NfdG9fcGFnZSBvciB2aXJ0X3RvX3BhZ2UgaXMgb25l
IG9mIHRoZQo+ID4gPiBuZXZlciBlbmRpbmcgTU0gZGlzY3Vzc2lvbnMgSSBkb24ndCB3YW50IHRv
IGdldCBpbnRvIHRoYXQgZGlzY3Vzc2lvbgo+ID4gPiBhbmQganVzdCBrZWVwIGl0IGxvY2FsIGlu
IHRoZSBETUEgY29kZS4KPiA+ID4KPiA+ID4gQXJlIHlvdSBmaW5lIHdpdGggbWUgYXBwbHlpbmcg
dGhpcyB2ZXJzaW9uPwo+ID4KPiA+IExvb2tzIGdvb2QgdG8gbWUsIHRoYW5rcyEKPiA+IEJ1dCwg
U3RlZmFubyBhc2tlZCBtZSBhYm91dCB1c2luZyBjcmVhdGVkIGhlbHBlciBpbiB0aGUKPiA+IHhl
bl9zd2lvdGxiX2ZyZWVfY29oZXJlbnQoKQo+ID4gYW5kIEkgY3JlYXRlZCBhIHBhdGNoIGFjY29y
ZGluZyB0byB0aGlzIG1lbnRpb24uCj4gPgo+ID4gV2UgY2FuIG1lcmdlIHRoaXMgcGF0Y2ggYW5k
IGNyZWF0ZSBhIG5ldyBvbmUgZm9yCj4gPiB4ZW5fc3dpb3RsYl9mcmVlX2NvaGVyZW50KCkgbGF0
ZXIuCj4KPiBZZWFoLCBubyB3b3JyaWVzLCBJIGRpZG4ndCBrbm93IHRoYXQgZXhwb3NpbmcgZG1h
X2NvbW1vbl92YWRkcl90b19wYWdlCj4gd2FzIHByb2JsZW1hdGljLgo+Cj4gVGhpcyBwYXRjaCBp
cyBmaW5lIGJ5IG1lLgo+Cj4KPiA+INC/0YIsIDE2INC40Y7Quy4gMjAyMSDQsy4g0LIgMTI6MzUs
IENocmlzdG9waCBIZWxsd2lnIDxoY2hAbHN0LmRlPjoKPiA+ID4KPiA+ID4gVGVjaG5pY2FsbHkg
dGhpcyBsb29rcyBnb29kLiAgQnV0IGdpdmVuIHRoYXQgZXhwb3NpbmcgYSBoZWxwZXIKPiA+ID4g
dGhhdCBkb2VzIGVpdGhlciB2bWFsbG9jX3RvX3BhZ2Ugb3IgdmlydF90b19wYWdlIGlzIG9uZSBv
ZiB0aGUKPiA+ID4gbmV2ZXIgZW5kaW5nIE1NIGRpc2N1c3Npb25zIEkgZG9uJ3Qgd2FudCB0byBn
ZXQgaW50byB0aGF0IGRpc2N1c3Npb24KPiA+ID4gYW5kIGp1c3Qga2VlcCBpdCBsb2NhbCBpbiB0
aGUgRE1BIGNvZGUuCj4gPiA+Cj4gPiA+IEFyZSB5b3UgZmluZSB3aXRoIG1lIGFwcGx5aW5nIHRo
aXMgdmVyc2lvbj8KPiA+ID4KPiA+ID4gLS0tCj4gPiA+IEZyb20gNDBhYzk3MWVhYjg5MzMwZDYx
NTNlNzcyMWU4OGFjZDJkOTg4MzNmOSBNb24gU2VwIDE3IDAwOjAwOjAwIDIwMDEKPiA+ID4gRnJv
bTogUm9tYW4gU2tha3VuIDxSb21hbl9Ta2FrdW5AZXBhbS5jb20+Cj4gPiA+IERhdGU6IEZyaSwg
MTYgSnVsIDIwMjEgMTE6Mzk6MzQgKzAzMDAKPiA+ID4gU3ViamVjdDogZG1hLW1hcHBpbmc6IGhh
bmRsZSB2bWFsbG9jIGFkZHJlc3NlcyBpbgo+ID4gPiAgZG1hX2NvbW1vbl97bW1hcCxnZXRfc2d0
YWJsZX0KPiA+ID4KPiA+ID4geGVuLXN3aW90bGIgY2FuIHVzZSB2bWFsbG9jIGJhY2tlZCBhZGRy
ZXNzZXMgZm9yIGRtYSBjb2hlcmVudCBhbGxvY2F0aW9ucwo+ID4gPiBhbmQgdXNlcyB0aGUgY29t
bW9uIGhlbHBlcnMuICBQcm9wZXJseSBoYW5kbGUgdGhlbSB0byB1bmJyZWFrIFhlbiBvbgo+ID4g
PiBBUk0gcGxhdGZvcm1zLgo+ID4gPgo+ID4gPiBGaXhlczogMWI2NWM0ZTVhOWFmICgic3dpb3Rs
Yi14ZW46IHVzZSB4ZW5fYWxsb2MvZnJlZV9jb2hlcmVudF9wYWdlcyIpCj4gPiA+IFNpZ25lZC1v
ZmYtYnk6IFJvbWFuIFNrYWt1biA8cm9tYW5fc2tha3VuQGVwYW0uY29tPgo+ID4gPiBSZXZpZXdl
ZC1ieTogQW5kcmlpIEFuaXNvdiA8YW5kcmlpX2FuaXNvdkBlcGFtLmNvbT4KPiA+ID4gW2hjaDog
c3BsaXQgdGhlIHBhdGNoLCByZW5hbWVkIHRoZSBoZWxwZXJzXQo+ID4gPiBTaWduZWQtb2ZmLWJ5
OiBDaHJpc3RvcGggSGVsbHdpZyA8aGNoQGxzdC5kZT4KPiA+ID4gLS0tCj4gPiA+ICBrZXJuZWwv
ZG1hL29wc19oZWxwZXJzLmMgfCAxMiArKysrKysrKysrLS0KPiA+ID4gIDEgZmlsZSBjaGFuZ2Vk
LCAxMCBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQo+ID4gPgo+ID4gPiBkaWZmIC0tZ2l0
IGEva2VybmVsL2RtYS9vcHNfaGVscGVycy5jIGIva2VybmVsL2RtYS9vcHNfaGVscGVycy5jCj4g
PiA+IGluZGV4IDkxMGFlNjljYWU3Ny4uYWY0YTZlZjQ4Y2UwIDEwMDY0NAo+ID4gPiAtLS0gYS9r
ZXJuZWwvZG1hL29wc19oZWxwZXJzLmMKPiA+ID4gKysrIGIva2VybmVsL2RtYS9vcHNfaGVscGVy
cy5jCj4gPiA+IEBAIC01LDYgKzUsMTMgQEAKPiA+ID4gICAqLwo+ID4gPiAgI2luY2x1ZGUgPGxp
bnV4L2RtYS1tYXAtb3BzLmg+Cj4gPiA+Cj4gPiA+ICtzdGF0aWMgc3RydWN0IHBhZ2UgKmRtYV9j
b21tb25fdmFkZHJfdG9fcGFnZSh2b2lkICpjcHVfYWRkcikKPiA+ID4gK3sKPiA+ID4gKyAgICAg
ICBpZiAoaXNfdm1hbGxvY19hZGRyKGNwdV9hZGRyKSkKPiA+ID4gKyAgICAgICAgICAgICAgIHJl
dHVybiB2bWFsbG9jX3RvX3BhZ2UoY3B1X2FkZHIpOwo+ID4gPiArICAgICAgIHJldHVybiB2aXJ0
X3RvX3BhZ2UoY3B1X2FkZHIpOwo+ID4gPiArfQo+ID4gPiArCj4gPiA+ICAvKgo+ID4gPiAgICog
Q3JlYXRlIHNjYXR0ZXItbGlzdCBmb3IgdGhlIGFscmVhZHkgYWxsb2NhdGVkIERNQSBidWZmZXIu
Cj4gPiA+ICAgKi8KPiA+ID4gQEAgLTEyLDcgKzE5LDcgQEAgaW50IGRtYV9jb21tb25fZ2V0X3Nn
dGFibGUoc3RydWN0IGRldmljZSAqZGV2LCBzdHJ1Y3Qgc2dfdGFibGUgKnNndCwKPiA+ID4gICAg
ICAgICAgICAgICAgICB2b2lkICpjcHVfYWRkciwgZG1hX2FkZHJfdCBkbWFfYWRkciwgc2l6ZV90
IHNpemUsCj4gPiA+ICAgICAgICAgICAgICAgICAgdW5zaWduZWQgbG9uZyBhdHRycykKPiA+ID4g
IHsKPiA+ID4gLSAgICAgICBzdHJ1Y3QgcGFnZSAqcGFnZSA9IHZpcnRfdG9fcGFnZShjcHVfYWRk
cik7Cj4gPiA+ICsgICAgICAgc3RydWN0IHBhZ2UgKnBhZ2UgPSBkbWFfY29tbW9uX3ZhZGRyX3Rv
X3BhZ2UoY3B1X2FkZHIpOwo+ID4gPiAgICAgICAgIGludCByZXQ7Cj4gPiA+Cj4gPiA+ICAgICAg
ICAgcmV0ID0gc2dfYWxsb2NfdGFibGUoc2d0LCAxLCBHRlBfS0VSTkVMKTsKPiA+ID4gQEAgLTMy
LDYgKzM5LDcgQEAgaW50IGRtYV9jb21tb25fbW1hcChzdHJ1Y3QgZGV2aWNlICpkZXYsIHN0cnVj
dCB2bV9hcmVhX3N0cnVjdCAqdm1hLAo+ID4gPiAgICAgICAgIHVuc2lnbmVkIGxvbmcgdXNlcl9j
b3VudCA9IHZtYV9wYWdlcyh2bWEpOwo+ID4gPiAgICAgICAgIHVuc2lnbmVkIGxvbmcgY291bnQg
PSBQQUdFX0FMSUdOKHNpemUpID4+IFBBR0VfU0hJRlQ7Cj4gPiA+ICAgICAgICAgdW5zaWduZWQg
bG9uZyBvZmYgPSB2bWEtPnZtX3Bnb2ZmOwo+ID4gPiArICAgICAgIHN0cnVjdCBwYWdlICpwYWdl
ID0gZG1hX2NvbW1vbl92YWRkcl90b19wYWdlKGNwdV9hZGRyKTsKPiA+ID4gICAgICAgICBpbnQg
cmV0ID0gLUVOWElPOwo+ID4gPgo+ID4gPiAgICAgICAgIHZtYS0+dm1fcGFnZV9wcm90ID0gZG1h
X3BncHJvdChkZXYsIHZtYS0+dm1fcGFnZV9wcm90LCBhdHRycyk7Cj4gPiA+IEBAIC00Myw3ICs1
MSw3IEBAIGludCBkbWFfY29tbW9uX21tYXAoc3RydWN0IGRldmljZSAqZGV2LCBzdHJ1Y3Qgdm1f
YXJlYV9zdHJ1Y3QgKnZtYSwKPiA+ID4gICAgICAgICAgICAgICAgIHJldHVybiAtRU5YSU87Cj4g
PiA+Cj4gPiA+ICAgICAgICAgcmV0dXJuIHJlbWFwX3Bmbl9yYW5nZSh2bWEsIHZtYS0+dm1fc3Rh
cnQsCj4gPiA+IC0gICAgICAgICAgICAgICAgICAgICAgIHBhZ2VfdG9fcGZuKHZpcnRfdG9fcGFn
ZShjcHVfYWRkcikpICsgdm1hLT52bV9wZ29mZiwKPiA+ID4gKyAgICAgICAgICAgICAgICAgICAg
ICAgcGFnZV90b19wZm4ocGFnZSkgKyB2bWEtPnZtX3Bnb2ZmLAo+ID4gPiAgICAgICAgICAgICAg
ICAgICAgICAgICB1c2VyX2NvdW50IDw8IFBBR0VfU0hJRlQsIHZtYS0+dm1fcGFnZV9wcm90KTsK
PiA+ID4gICNlbHNlCj4gPiA+ICAgICAgICAgcmV0dXJuIC1FTlhJTzsKPiA+ID4gLS0KPiA+ID4g
Mi4zMC4yCj4gPiA+Cj4gPgo+ID4KPiA+IC0tCj4gPiBCZXN0IFJlZ2FyZHMsIFJvbWFuLgo+ID4K
CgoKLS0gCkJlc3QgUmVnYXJkcywgUm9tYW4uCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1m
b3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9s
aXN0aW5mby9pb21tdQ==
