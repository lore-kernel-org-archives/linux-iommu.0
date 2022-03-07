Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92F84C4321E
	for <iommu@archiver.kernel.org>; Mon,  7 Mar 2022 14:22:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id ADCBB40004;
	Mon,  7 Mar 2022 14:22:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8_JXrvnDJUEU; Mon,  7 Mar 2022 14:22:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id D63C540614;
	Mon,  7 Mar 2022 14:22:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B51CEC0012;
	Mon,  7 Mar 2022 14:21:59 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DAF0CC000B
 for <iommu@lists.linux-foundation.org>; Mon,  7 Mar 2022 12:47:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B76CE410C8
 for <iommu@lists.linux-foundation.org>; Mon,  7 Mar 2022 12:47:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=benyossef-com.20210112.gappssmtp.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id u-PnE4ZNxmo1 for <iommu@lists.linux-foundation.org>;
 Mon,  7 Mar 2022 12:47:35 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com
 [IPv6:2607:f8b0:4864:20::b29])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 44A55408F2
 for <iommu@lists.linux-foundation.org>; Mon,  7 Mar 2022 12:47:35 +0000 (UTC)
Received: by mail-yb1-xb29.google.com with SMTP id u3so30660113ybh.5
 for <iommu@lists.linux-foundation.org>; Mon, 07 Mar 2022 04:47:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=benyossef-com.20210112.gappssmtp.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=eFuv1CZ1FCJvRh23WLfkSzv/heaOZIC7c/13FaNc3Wo=;
 b=2TAsd6PKCXUlgIYEC6sOsRFGGOkyw4qtPi3sHqqzwqVeNt8xoIqr4ya+hu98UH+oZp
 9nStNtbMrEplhF7ylmE7V8+iGZ0D/g8UktjAXaXEK5Ef7u7l0BW6wUluEX6bcH44IB5a
 QSA8dd5KHnfphZ2xnrUU3qmNHWJDYfdUagRgyUc7WT+Y9+Dl7r6hG+jh5cWBlKcg6VOi
 3zv9gy5eEFkjVnHXKBudMe8eA6JKj7hcc86GrBfVsOIT3NBM94YOoYPRTeLflTLhOIA/
 XAerpQxZdma6VuD/ALzQzgvqOzgEDApXsGzBsxOOXG345TY7QqTC4kNJMdYK69quy70W
 kYCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=eFuv1CZ1FCJvRh23WLfkSzv/heaOZIC7c/13FaNc3Wo=;
 b=NOT3+0gcWzJlQRNNsjDTutxklSQiLWTIgYYp4ykSru+Yiue04wz1X3ub95sCk9Jadz
 UCeN+vCCKSTCGQBjT3PuQ3OoipDkkgPFOxUQ55DuqWaAA9LjYj/kVpNJrN3xhpwR/QIw
 LwkWyc2iGDqbElx3tyDl6fptvEmnhhpxnO/tp8TcrNiKmH6PfMUaAjcZ6LH1kK1+wd4S
 Byfnzs4XhPuilJ0jmn/wHiYv5B3QoQdjUUos5YA+5rym01/G4/KYHE80U4t5qbnlp3yO
 4bQY8BhN+sBn38xYpOq939F8VDGvstSnsbwFEL7cy1T5dAl6rYtdO3390C8Boq0EFahk
 JnPg==
X-Gm-Message-State: AOAM532OLoYwktwfIW11bK4ZXL+wafqZ7ahKIn5IJ+oDrdWUsrakfKeT
 JkvZGN0TBThg68Jur7CuPjYBoZCmJtgYPDOgNIQ60g==
X-Google-Smtp-Source: ABdhPJy7A9l6pgeT9iD8kwzothv8rOOmhOR5TCpERcX/K56cv0Decwr3OQIeVGeijmRGnFQO/VzxBFXZqGXRiun68q0=
X-Received: by 2002:a25:5509:0:b0:622:1c12:4230 with SMTP id
 j9-20020a255509000000b006221c124230mr7750645ybb.416.1646657253810; Mon, 07
 Mar 2022 04:47:33 -0800 (PST)
MIME-Version: 1.0
References: <CAOtvUMeoYcVm7OQdqXd1V5iPSXW_BkVxx6TA6nF7zTLVeHe0Ww@mail.gmail.com>
 <CAOtvUMfy1fF35B2sfbOMui8n9Q4iCke9rgn5TiYMUMjd8gqHsA@mail.gmail.com>
 <YhKV55t90HWm6bhv@Red>
 <CAOtvUMdRU4wnRCXsC+U5XBDp+b+u8w7W7JCUKW2+ohuJz3PVhQ@mail.gmail.com>
 <YhOcEQEjIKBrbMIZ@Red>
 <CAOtvUMfN8U4+eG-TEVW4bSE6kOzuOSsJE4dOYGXYuWQKNzv7wQ@mail.gmail.com>
 <CAOtvUMeRb=j=NDrc88x8aB-3=D1mxZ_-aA1d4FfvJmj7Jrbi4w@mail.gmail.com>
 <YiIUXtxd44ut5uzV@Red> <YiUsWosH+MKMF7DQ@gondor.apana.org.au>
 <CAOtvUMcudG3ySU+VeE7hfneDVWGLKFTnws-xjhq4hgFYSj0qOg@mail.gmail.com>
 <YiXjCcXXk0f18FDL@Red> <aca4117c-b7a5-f7eb-eb03-4e1f1a93a730@arm.com>
 <CAOtvUMePFR4e2jgHZKOvs3J3Xt4NzRbzD_=vr_49Qgs5HTrvHw@mail.gmail.com>
 <6cf91f43-df23-3ac9-e9b5-958d99d37422@arm.com>
In-Reply-To: <6cf91f43-df23-3ac9-e9b5-958d99d37422@arm.com>
From: Gilad Ben-Yossef <gilad@benyossef.com>
Date: Mon, 7 Mar 2022 14:47:23 +0200
Message-ID: <CAOtvUMedqSNKx9Aah0R_aAyjKO0pn4K75MrCnbh_zX+Zw9vRQA@mail.gmail.com>
Subject: Re: [BUG] crypto: ccree: driver does not handle case where cryptlen =
 authsize =0
To: Robin Murphy <robin.murphy@arm.com>
X-Mailman-Approved-At: Mon, 07 Mar 2022 14:21:57 +0000
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
 Linux kernel mailing list <linux-kernel@vger.kernel.org>,
 iommu@lists.linux-foundation.org, Corentin Labbe <clabbe.montjoie@gmail.com>,
 Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
 Christoph Hellwig <hch@lst.de>
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

T24gTW9uLCBNYXIgNywgMjAyMiBhdCAyOjM2IFBNIFJvYmluIE11cnBoeSA8cm9iaW4ubXVycGh5
QGFybS5jb20+IHdyb3RlOgo+Cj4gT24gMjAyMi0wMy0wNyAxMjoxNywgR2lsYWQgQmVuLVlvc3Nl
ZiB3cm90ZToKPiA+IE9uIE1vbiwgTWFyIDcsIDIwMjIgYXQgMToxNCBQTSBSb2JpbiBNdXJwaHkg
PHJvYmluLm11cnBoeUBhcm0uY29tPiB3cm90ZToKPiA+Cj4gPj4gVGhlICJvdmVybGFwIiBpcyBp
biB0aGUgc2Vuc2Ugb2YgaGF2aW5nIG1vcmUgdGhhbiBvbmUgbWFwcGluZyB3aXRoaW4gdGhlCj4g
Pj4gc2FtZSBjYWNoZWxpbmU6Cj4gPj4KPiA+PiBbICAxNDIuNDU4MTIwXSBETUEtQVBJOiBhZGRf
ZG1hX2VudHJ5IHN0YXJ0IFA9YmE3OWYyMDAgTj1iYTc5Zgo+ID4+IEQ9YmE3OWYyMDAgTD0xMCBE
TUFfRlJPTV9ERVZJQ0UgYXR0cnM9MAo+ID4+IFsgIDE0Mi40NTgxNTZdIERNQS1BUEk6IGFkZF9k
bWFfZW50cnkgc3RhcnQgUD00NDVkYzAxMCBOPTQ0NWRjCj4gPj4gRD00NDVkYzAxMCBMPTEwIERN
QV9UT19ERVZJQ0UgYXR0cnM9MAo+ID4+IFsgIDE0Mi40NTgxNzhdIHN1bjhpLXNzIDFjMTUwMDAu
Y3J5cHRvOiBTUkMgMC8xLzEgNDQ1ZGMwMDAgbGVuPTE2IGJpPTAKPiA+PiBbICAxNDIuNDU4MjE1
XSBzdW44aS1zcyAxYzE1MDAwLmNyeXB0bzogRFNUIDAvMS8xIGJhNzlmMjAwIGxlbj0xNiBiaT0w
Cj4gPj4gWyAgMTQyLjQ1ODIzNF0gRE1BLUFQSTogYWRkX2RtYV9lbnRyeSBzdGFydCBQPWJhNzlm
MjEwIE49YmE3OWYKPiA+PiBEPWJhNzlmMjEwIEw9MTAgRE1BX0ZST01fREVWSUNFIGF0dHJzPTAK
PiA+Pgo+ID4+IFRoaXMgYWN0dWFsbHkgaWxsdXN0cmF0ZXMgZXhhY3RseSB0aGUgcmVhc29uIHdo
eSB0aGlzIGlzIHVuc3VwcG9ydGFibGUuCj4gPj4gYmE3OWYyMDAgaXMgbWFwcGVkIGZvciBETUFf
RlJPTV9ERVZJQ0UsIHRoZXJlZm9yZSBzdWJzZXF1ZW50bHkgbWFwcGluZwo+ID4+IGJhNzlmMjEw
IGZvciBETUFfVE9fREVWSUNFIG1heSBjYXVzZSB0aGUgY2FjaGVsaW5lIGNvdmVyaW5nIHRoZSBy
YW5nZQo+ID4+IGJhNzlmMjAwLWJhNzlmMjNmIHRvIGJlIHdyaXR0ZW4gYmFjayBvdmVyIHRoZSB0
b3Agb2YgZGF0YSB0aGF0IHRoZQo+ID4+IGRldmljZSBoYXMgYWxyZWFkeSBzdGFydGVkIHRvIHdy
aXRlIHRvIG1lbW9yeS4gSGVsbG8gZGF0YSBjb3JydXB0aW9uLgo+ID4+Cj4gPj4gU2VwYXJhdGUg
RE1BIG1hcHBpbmdzIHNob3VsZCBiZSBmcm9tIHNlcGFyYXRlIG1lbW9yeSBhbGxvY2F0aW9ucywK
PiA+PiByZXNwZWN0aW5nIEFSQ0hfRE1BX01JTkFMSUdOLgo+ID4KPiA+IGhtbS4uLiBJIGtub3cg
SSdtIG1pc3Npbmcgc29tZXRoaW5nIGhlcmUsIGJ1dCBob3cgZG9lcyB0aGlzIGFsaWduIHdpdGgK
PiA+IHRoZSBmb2xsb3dpbmcgZnJvbSBhY3RpdmVfY2FjaGVsaW5lX2luc2VydCgpIGluIGtlcm5l
bC9kbWEvZGVidWcuYyA/Cj4gPgo+ID4gICAgICAgICAgLyogSWYgdGhlIGRldmljZSBpcyBub3Qg
d3JpdGluZyBtZW1vcnkgdGhlbiB3ZSBkb24ndCBoYXZlIGFueQo+ID4gICAgICAgICAgICogY29u
Y2VybnMgYWJvdXQgdGhlIGNwdSBjb25zdW1pbmcgc3RhbGUgZGF0YS4gIFRoaXMgbWl0aWdhdGVz
Cj4gPiAgICAgICAgICAgKiBsZWdpdGltYXRlIHVzYWdlcyBvZiBvdmVybGFwcGluZyBtYXBwaW5n
cy4KPiA+ICAgICAgICAgICAqLwo+ID4gICAgICAgICAgaWYgKGVudHJ5LT5kaXJlY3Rpb24gPT0g
RE1BX1RPX0RFVklDRSkKPiA+ICAgICAgICAgICAgICAgICAgcmV0dXJuIDA7Cj4KPiBJdCdzIE9L
IHRvIGhhdmUgbXVsdGlwbGUgbWFwcGluZ3MgdGhhdCBhcmUgKmFsbCogRE1BX1RPX0RFVklDRSwg
d2hpY2gKPiBsb29rcyB0byBiZSB0aGUgY2FzZSB0aGF0IHRoaXMgY2hlY2sgd2FzIGludGVuZGVk
IHRvIGFsbG93LiBIb3dldmVyIEkKPiB0aGluayB5b3UncmUgcmlnaHQgdGhhdCBpdCBzaG91bGQg
c3RpbGwgYWN0dWFsbHkgY2hlY2sgZm9yIGNvbmZsaWN0aW5nCj4gZGlyZWN0aW9ucyBiZXR3ZWVu
IHRoZSBuZXcgZW50cnkgYW5kIGFueSBleGlzdGluZyBvbmVzLCBvdGhlcndpc2UgaXQKPiBlbmRz
IHVwIGEgYml0IHRvbyBsZW5pZW50Lgo+Cj4gQ2hlZXJzLAo+IFJvYmluLgoKSSB1bmRlcnN0YW5k
IHdoYXQgeW91IGFyZSBzYXlpbmcgYWJvdXQgd2h5IGNoZWNraW5nIGZvciBjb25mbGljdGluZwpk
aXJlY3Rpb25zIG1heSBiZSBhIGdvb2QgdGhpbmcsIGJ1dCBnaXZlbiB0aGF0IHRoZSBjb2RlIGlz
IGFzIGl0IGlzCnJpZ2h0IG5vdywgaG93IGFyZSB3ZSBzZWVpbmcgdGhlIHdhcm5pbmcgZm9yIHR3
byBtYXBwaW5nIHRoYXQgb25lIG9mCnRoZW0gaXMgRE1BX1RPX0RFVklDRT8KCkdpbGFkCgoKLS0g
CkdpbGFkIEJlbi1Zb3NzZWYKQ2hpZWYgQ29mZmVlIERyaW5rZXIKCnZhbHVlcyBvZiDOsiB3aWxs
IGdpdmUgcmlzZSB0byBkb20hCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9u
Lm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9p
b21tdQ==
