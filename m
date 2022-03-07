Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A0AEC433F5
	for <iommu@archiver.kernel.org>; Mon,  7 Mar 2022 14:22:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0952481D70;
	Mon,  7 Mar 2022 14:22:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sIjW6HaDfNHi; Mon,  7 Mar 2022 14:22:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id D621B81D0C;
	Mon,  7 Mar 2022 14:21:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4AEEEC0082;
	Mon,  7 Mar 2022 14:21:59 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B5692C000B
 for <iommu@lists.linux-foundation.org>; Mon,  7 Mar 2022 12:18:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9C45E60E4B
 for <iommu@lists.linux-foundation.org>; Mon,  7 Mar 2022 12:18:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=benyossef-com.20210112.gappssmtp.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bNhwSW6L3fx7 for <iommu@lists.linux-foundation.org>;
 Mon,  7 Mar 2022 12:18:11 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com
 [IPv6:2607:f8b0:4864:20::1132])
 by smtp3.osuosl.org (Postfix) with ESMTPS id EEA6360E3D
 for <iommu@lists.linux-foundation.org>; Mon,  7 Mar 2022 12:18:10 +0000 (UTC)
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-2dbc48104beso161413177b3.5
 for <iommu@lists.linux-foundation.org>; Mon, 07 Mar 2022 04:18:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=benyossef-com.20210112.gappssmtp.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=kNo3uSHysShLR0FJhmk5oSOi1tMyXHYvJloBJLNHZCg=;
 b=F9pKvRvYdMxTrF6jqw8vUsqcHxvyFAKgh5ws7S3CM2QebpqvTAkwKJO4XRUJMn1a4m
 S02+miqQ7jyunEQuEeulaQyWcId+gR5KG7TutDPcjKuCtEcHBjTG1i4YT/gVLEsoxOOc
 RgbbrBzgB1K4PTYrzpLz6nzuHzEVTWkriR3PiQVn2MAuG3toHMwVrmUOxFC/kojcgKDu
 bgBoWYtsX6xfM/Zfv24MczYLcwpIalwMwZLiNQHIRJuqvHEcmqx9VAtux5Np3YLZEgUW
 WJVbRfRg/Xqrbi0JQoGI8D+wNbjL4FMS/5OVwpAYRkwscIEOmnIwQLw+TVsqay1b09Op
 iaag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=kNo3uSHysShLR0FJhmk5oSOi1tMyXHYvJloBJLNHZCg=;
 b=kJIZc4qnul34Gamh+iH349ddmzotJhUPL3IQPhWfwFpTuVCmBSs9V1GWtbXgbZ19UA
 4atlTRFZ2cy+2j+onYCstrsldJpskDcJURB4/JmJw4ii8eX7QZ0UHH10vowzHbJ4Q+1a
 OGvqfHgQgn0X00Zb+tlYQQIE0g8Ao3uIg7KywdivyEginWpiEwwZ50QoTC5YJlwl2f+y
 vZNDhsPf3Hqb5kdVzuPnixdS3dbP9vUWNwWhHw/XaYroxaMlIVG3hpRRnpHtGKhEst2w
 XGi1NfLojiT3KDS3+GTaHueG/XJDGOBoNa5xCLAF24dDYUplr2f6X+bPR6W3dHFE/wlu
 lY/A==
X-Gm-Message-State: AOAM531qx9WjJD03ocLWHdxruXIf8aNQZmj6LJSe03OuhSBoe/HGNG9Z
 61coVSq67rnOMvJl60bLfefhPrYn54+d30VjJPZQWQ==
X-Google-Smtp-Source: ABdhPJxAwnlLxiebvOvVJXEOc3iSvoRJ/FztSSfnXBmJMWTvypvCDGrt5qtTbdf4SAXSCTruNN8YCoUGrS6E6lw0PWg=
X-Received: by 2002:a81:6c6:0:b0:2dc:616b:468b with SMTP id
 189-20020a8106c6000000b002dc616b468bmr7855366ywg.472.1646655489767; Mon, 07
 Mar 2022 04:18:09 -0800 (PST)
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
In-Reply-To: <aca4117c-b7a5-f7eb-eb03-4e1f1a93a730@arm.com>
From: Gilad Ben-Yossef <gilad@benyossef.com>
Date: Mon, 7 Mar 2022 14:17:59 +0200
Message-ID: <CAOtvUMePFR4e2jgHZKOvs3J3Xt4NzRbzD_=vr_49Qgs5HTrvHw@mail.gmail.com>
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

T24gTW9uLCBNYXIgNywgMjAyMiBhdCAxOjE0IFBNIFJvYmluIE11cnBoeSA8cm9iaW4ubXVycGh5
QGFybS5jb20+IHdyb3RlOgoKPiBUaGUgIm92ZXJsYXAiIGlzIGluIHRoZSBzZW5zZSBvZiBoYXZp
bmcgbW9yZSB0aGFuIG9uZSBtYXBwaW5nIHdpdGhpbiB0aGUKPiBzYW1lIGNhY2hlbGluZToKPgo+
IFsgIDE0Mi40NTgxMjBdIERNQS1BUEk6IGFkZF9kbWFfZW50cnkgc3RhcnQgUD1iYTc5ZjIwMCBO
PWJhNzlmCj4gRD1iYTc5ZjIwMCBMPTEwIERNQV9GUk9NX0RFVklDRSBhdHRycz0wCj4gWyAgMTQy
LjQ1ODE1Nl0gRE1BLUFQSTogYWRkX2RtYV9lbnRyeSBzdGFydCBQPTQ0NWRjMDEwIE49NDQ1ZGMK
PiBEPTQ0NWRjMDEwIEw9MTAgRE1BX1RPX0RFVklDRSBhdHRycz0wCj4gWyAgMTQyLjQ1ODE3OF0g
c3VuOGktc3MgMWMxNTAwMC5jcnlwdG86IFNSQyAwLzEvMSA0NDVkYzAwMCBsZW49MTYgYmk9MAo+
IFsgIDE0Mi40NTgyMTVdIHN1bjhpLXNzIDFjMTUwMDAuY3J5cHRvOiBEU1QgMC8xLzEgYmE3OWYy
MDAgbGVuPTE2IGJpPTAKPiBbICAxNDIuNDU4MjM0XSBETUEtQVBJOiBhZGRfZG1hX2VudHJ5IHN0
YXJ0IFA9YmE3OWYyMTAgTj1iYTc5Zgo+IEQ9YmE3OWYyMTAgTD0xMCBETUFfRlJPTV9ERVZJQ0Ug
YXR0cnM9MAo+Cj4gVGhpcyBhY3R1YWxseSBpbGx1c3RyYXRlcyBleGFjdGx5IHRoZSByZWFzb24g
d2h5IHRoaXMgaXMgdW5zdXBwb3J0YWJsZS4KPiBiYTc5ZjIwMCBpcyBtYXBwZWQgZm9yIERNQV9G
Uk9NX0RFVklDRSwgdGhlcmVmb3JlIHN1YnNlcXVlbnRseSBtYXBwaW5nCj4gYmE3OWYyMTAgZm9y
IERNQV9UT19ERVZJQ0UgbWF5IGNhdXNlIHRoZSBjYWNoZWxpbmUgY292ZXJpbmcgdGhlIHJhbmdl
Cj4gYmE3OWYyMDAtYmE3OWYyM2YgdG8gYmUgd3JpdHRlbiBiYWNrIG92ZXIgdGhlIHRvcCBvZiBk
YXRhIHRoYXQgdGhlCj4gZGV2aWNlIGhhcyBhbHJlYWR5IHN0YXJ0ZWQgdG8gd3JpdGUgdG8gbWVt
b3J5LiBIZWxsbyBkYXRhIGNvcnJ1cHRpb24uCj4KPiBTZXBhcmF0ZSBETUEgbWFwcGluZ3Mgc2hv
dWxkIGJlIGZyb20gc2VwYXJhdGUgbWVtb3J5IGFsbG9jYXRpb25zLAo+IHJlc3BlY3RpbmcgQVJD
SF9ETUFfTUlOQUxJR04uCgpobW0uLi4gSSBrbm93IEknbSBtaXNzaW5nIHNvbWV0aGluZyBoZXJl
LCBidXQgaG93IGRvZXMgdGhpcyBhbGlnbiB3aXRoCnRoZSBmb2xsb3dpbmcgZnJvbSBhY3RpdmVf
Y2FjaGVsaW5lX2luc2VydCgpIGluIGtlcm5lbC9kbWEvZGVidWcuYyA/CgogICAgICAgIC8qIElm
IHRoZSBkZXZpY2UgaXMgbm90IHdyaXRpbmcgbWVtb3J5IHRoZW4gd2UgZG9uJ3QgaGF2ZSBhbnkK
ICAgICAgICAgKiBjb25jZXJucyBhYm91dCB0aGUgY3B1IGNvbnN1bWluZyBzdGFsZSBkYXRhLiAg
VGhpcyBtaXRpZ2F0ZXMKICAgICAgICAgKiBsZWdpdGltYXRlIHVzYWdlcyBvZiBvdmVybGFwcGlu
ZyBtYXBwaW5ncy4KICAgICAgICAgKi8KICAgICAgICBpZiAoZW50cnktPmRpcmVjdGlvbiA9PSBE
TUFfVE9fREVWSUNFKQogICAgICAgICAgICAgICAgcmV0dXJuIDA7CgpUaGFua3MsCkdpbGFkCgot
LSAKR2lsYWQgQmVuLVlvc3NlZgpDaGllZiBDb2ZmZWUgRHJpbmtlcgoKdmFsdWVzIG9mIM6yIHdp
bGwgZ2l2ZSByaXNlIHRvIGRvbSEKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRp
b24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2lvbW11
