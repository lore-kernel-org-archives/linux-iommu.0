Return-Path: <SRS0=S+y3=AR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B24CC433E1
	for <iommu@archiver.kernel.org>; Mon,  6 Jul 2020 08:05:16 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E26E6206CD
	for <iommu@archiver.kernel.org>; Mon,  6 Jul 2020 08:05:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=semihalf-com.20150623.gappssmtp.com header.i=@semihalf-com.20150623.gappssmtp.com header.b="MEo9JCfG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E26E6206CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=semihalf.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 644D922234;
	Mon,  6 Jul 2020 08:05:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EtJ4tltpu-vg; Mon,  6 Jul 2020 08:05:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id A722E20021;
	Mon,  6 Jul 2020 08:05:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8D2DFC0888;
	Mon,  6 Jul 2020 08:05:13 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 03849C0733
 for <iommu@lists.linux-foundation.org>; Fri,  3 Jul 2020 11:00:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id D8C9D2047F
 for <iommu@lists.linux-foundation.org>; Fri,  3 Jul 2020 11:00:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Pbazq1czyPlm for <iommu@lists.linux-foundation.org>;
 Fri,  3 Jul 2020 11:00:30 +0000 (UTC)
X-Greylist: delayed 00:16:06 by SQLgrey-1.7.6
Received: from mail-qt1-f193.google.com (mail-qt1-f193.google.com
 [209.85.160.193])
 by silver.osuosl.org (Postfix) with ESMTPS id A16C12047A
 for <iommu@lists.linux-foundation.org>; Fri,  3 Jul 2020 11:00:30 +0000 (UTC)
Received: by mail-qt1-f193.google.com with SMTP id b25so2136190qto.2
 for <iommu@lists.linux-foundation.org>; Fri, 03 Jul 2020 04:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=semihalf-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=JPP5dk3DGn1Kue5mZhdu/Zsau/0xYquoK5XZJ9IOZ10=;
 b=MEo9JCfGTSN7NdOO4Q497XVqVsdX9GLLJJLeCd1XoMMGdLsgT6G/X1w5WquKdYvBDa
 crYMNO0dRvMjwFbbrNiYWEfuK0VAwRTJLhA6JCFQHPh/HcUC8odqtyzAClNxOmQY5Elw
 g7fCzxWUmBDKejqnConWPvvDM5ZoJwd9rrE6mHL5zHU5ck4kJxxcjiLB4/JtNkSiEGfm
 qeJWWi4IRHMLaMUI5jJsaFgE4q4DZj7+/SkB3L/zMfPm2b1wBqNpEUkm/2PjDuYBJz4u
 f+AM9rqmrVogcP2tjqrS+q73MexFJGK4v8iLg+K34WXseaKaXt77CSpVqruv02+z7+Ea
 DFjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=JPP5dk3DGn1Kue5mZhdu/Zsau/0xYquoK5XZJ9IOZ10=;
 b=qehaV9E1hy9H3Qt4ZMNqpIH/MoXQiH4TQ9g87tKRNYRAsSwxtshKovrYlOQ8ypmC3g
 AQqokTfYPVBSyVl0w5TLJwk3guOMyIt9NgoOWXBNvUM9MZzcLB3gRubZfBG6X+Vvxm3q
 L1JgOlF5SOffIJ6ptkPxgjMUPQ7mvizh3N+hHb2E6jlz3Ta3kTWf/I3Fv6NrQXw5SXj7
 YQJYdEwz3zNXoB3jkLwwDuPT2PvPuK0VxV/zudii1e1AYDr1ii4oUtCtMwkQFQtgrofH
 Z8cGf6zLkPQ9o3gTfkGZ6VhgeabtZLMOXk6niSKCZOjGMvqT0eemGmKvZWaIL+mlUz5W
 ktfg==
X-Gm-Message-State: AOAM5309QJqrXhEnEUNWiJAYqLNWDu/3Q3byCbXzakRroKPO3gB2oSx7
 /09D9h9zSItK4GcGRbSTvEzlBWDE1CLRqvORaky2myOj/SU=
X-Google-Smtp-Source: ABdhPJwJrCWe0dugE1e+/qIk6xmucbTMvNRWNha8Rf0K5YT0BKjMveNAgz283vyNTTBKSM1kRaSxyccIYVx0mGil3XQ=
X-Received: by 2002:a37:48c7:: with SMTP id
 v190mr33180586qka.153.1593772722122; 
 Fri, 03 Jul 2020 03:38:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200702201633.22693-1-tn@semihalf.com>
 <20200702201633.22693-5-tn@semihalf.com>
 <ba29e839-79e0-7189-f735-d457544135e4@arm.com>
 <3d9b3d16-00e4-d3b5-344b-8515c70fb83e@semihalf.com>
In-Reply-To: <3d9b3d16-00e4-d3b5-344b-8515c70fb83e@semihalf.com>
From: Marcin Wojtas <mw@semihalf.com>
Date: Fri, 3 Jul 2020 12:38:28 +0200
Message-ID: <CAPv3WKedrn0eXY_Eg9TMq=GFqmbRUqQXE4VfDvMNffv5x961LA@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] arm64: dts: marvell: add SMMU support
To: Tomasz Nowicki <tn@semihalf.com>
X-Mailman-Approved-At: Mon, 06 Jul 2020 08:05:12 +0000
Cc: devicetree@vger.kernel.org,
 =?UTF-8?Q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>,
 Robin Murphy <robin.murphy@arm.com>, Hanna Hawa <hannah@marvell.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, nadavh@marvell.com,
 iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, will@kernel.org,
 linux-arm-kernel@lists.infradead.org
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

SGkgVG9tYXN6LAoKCnB0LiwgMyBsaXAgMjAyMCBvIDExOjMzIFRvbWFzeiBOb3dpY2tpIDx0bkBz
ZW1paGFsZi5jb20+IG5hcGlzYcWCKGEpOgo+Cj4gT24gMDMuMDcuMjAyMCAxMToxNiwgUm9iaW4g
TXVycGh5IHdyb3RlOgo+ID4gT24gMjAyMC0wNy0wMiAyMToxNiwgVG9tYXN6IE5vd2lja2kgd3Jv
dGU6Cj4gPj4gRnJvbTogTWFyY2luIFdvanRhcyA8bXdAc2VtaWhhbGYuY29tPgo+ID4+Cj4gPj4g
QWRkIElPTU1VIG5vZGUgZm9yIE1hcnZlbGwgQVA4MDYgYmFzZWQgU29DcyB0b2dldGhlciB3aXRo
IHBsYXRmb3JtCj4gPj4gYW5kIFBDSSBkZXZpY2UgU3RyZWFtIElEIG1hcHBpbmcuCj4gPj4KPiA+
PiBTaWduZWQtb2ZmLWJ5OiBNYXJjaW4gV29qdGFzIDxtd0BzZW1paGFsZi5jb20+Cj4gPj4gU2ln
bmVkLW9mZi1ieTogVG9tYXN6IE5vd2lja2kgPHRuQHNlbWloYWxmLmNvbT4KPiA+PiAtLS0KPiA+
PiAgIGFyY2gvYXJtNjQvYm9vdC9kdHMvbWFydmVsbC9hcm1hZGEtODA0MC5kdHNpICB8IDM2ICsr
KysrKysrKysrKysrKysrKysKPiA+PiAgIGFyY2gvYXJtNjQvYm9vdC9kdHMvbWFydmVsbC9hcm1h
ZGEtYXA4MHguZHRzaSB8IDE3ICsrKysrKysrKwo+ID4+ICAgMiBmaWxlcyBjaGFuZ2VkLCA1MyBp
bnNlcnRpb25zKCspCj4gPj4KPiA+PiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9ib290L2R0cy9t
YXJ2ZWxsL2FybWFkYS04MDQwLmR0c2kKPiA+PiBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvbWFydmVs
bC9hcm1hZGEtODA0MC5kdHNpCj4gPj4gaW5kZXggNzY5OWIxOTIyNGMyLi4yNWMxZGY3MDlmNzIg
MTAwNjQ0Cj4gPj4gLS0tIGEvYXJjaC9hcm02NC9ib290L2R0cy9tYXJ2ZWxsL2FybWFkYS04MDQw
LmR0c2kKPiA+PiArKysgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL21hcnZlbGwvYXJtYWRhLTgwNDAu
ZHRzaQo+ID4+IEBAIC0yMywzICsyMywzOSBAQAo+ID4+ICAgJmNwMF9ydGMgewo+ID4+ICAgICAg
IHN0YXR1cyA9ICJkaXNhYmxlZCI7Cj4gPj4gICB9Owo+ID4+ICsKPiA+PiArJmNwMF91c2IzXzAg
ewo+ID4+ICsgICAgaW9tbXVzID0gPCZzbW11IDB4NDQwPjsKPiA+PiArfTsKPiA+PiArCj4gPj4g
KyZjcDBfdXNiM18xIHsKPiA+PiArICAgIGlvbW11cyA9IDwmc21tdSAweDQ0MT47Cj4gPj4gK307
Cj4gPj4gKwo+ID4+ICsmY3AwX3NhdGEwIHsKPiA+PiArICAgIGlvbW11cyA9IDwmc21tdSAweDQ0
ND47Cj4gPj4gK307Cj4gPj4gKwo+ID4+ICsmY3AwX3NkaGNpMCB7Cj4gPj4gKyAgICBpb21tdXMg
PSA8JnNtbXUgMHg0NDU+Owo+ID4+ICt9Owo+ID4+ICsKPiA+PiArJmNwMV9zYXRhMCB7Cj4gPj4g
KyAgICBpb21tdXMgPSA8JnNtbXUgMHg0NTQ+Owo+ID4+ICt9Owo+ID4+ICsKPiA+PiArJmNwMV91
c2IzXzAgewo+ID4+ICsgICAgaW9tbXVzID0gPCZzbW11IDB4NDUwPjsKPiA+PiArfTsKPiA+PiAr
Cj4gPj4gKyZjcDFfdXNiM18xIHsKPiA+PiArICAgIGlvbW11cyA9IDwmc21tdSAweDQ1MT47Cj4g
Pj4gK307Cj4gPj4gKwo+ID4+ICsmY3AwX3BjaWUwIHsKPiA+PiArICAgIGlvbW11LW1hcCA9Cj4g
Pj4gKyAgICAgICAgPDB4MCAgICZzbW11IDB4NDgwIDB4MjA+LAo+ID4+ICsgICAgICAgIDwweDEw
MCAmc21tdSAweDRhMCAweDIwPiwKPiA+PiArICAgICAgICA8MHgyMDAgJnNtbXUgMHg0YzAgMHgy
MD47Cj4gPj4gKyAgICBpb21tdS1tYXAtbWFzayA9IDwweDAzMWY+Owo+ID4KPiA+IE5pY2UhIEkg
ZG8gbGlrZSBhIGdvb2QgY29tcHJlc3NlZCBtYXBwaW5nIDpECj4gPgo+ID4+ICt9Owo+ID4+IGRp
ZmYgLS1naXQgYS9hcmNoL2FybTY0L2Jvb3QvZHRzL21hcnZlbGwvYXJtYWRhLWFwODB4LmR0c2kK
PiA+PiBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvbWFydmVsbC9hcm1hZGEtYXA4MHguZHRzaQo+ID4+
IGluZGV4IDdmOWI5YTY0NzcxNy4uZGVkOGI4MDgyZDc5IDEwMDY0NAo+ID4+IC0tLSBhL2FyY2gv
YXJtNjQvYm9vdC9kdHMvbWFydmVsbC9hcm1hZGEtYXA4MHguZHRzaQo+ID4+ICsrKyBiL2FyY2gv
YXJtNjQvYm9vdC9kdHMvbWFydmVsbC9hcm1hZGEtYXA4MHguZHRzaQo+ID4+IEBAIC01Niw2ICs1
NiwyMyBAQAo+ID4+ICAgICAgICAgICAgICAgY29tcGF0aWJsZSA9ICJzaW1wbGUtYnVzIjsKPiA+
PiAgICAgICAgICAgICAgIHJhbmdlcyA9IDwweDAgMHgwIDB4ZjAwMDAwMDAgMHgxMDAwMDAwPjsK
PiA+PiArICAgICAgICAgICAgc21tdTogaW9tbXVANTAwMDAwMCB7Cj4gPj4gKyAgICAgICAgICAg
ICAgICBjb21wYXRpYmxlID0gIm1hcnZlbGwsYXA4MDYtc21tdS01MDAiLCAiYXJtLG1tdS01MDAi
Owo+ID4+ICsgICAgICAgICAgICAgICAgcmVnID0gPDB4MTAwMDAwIDB4MTAwMDAwPjsKPiA+PiAr
ICAgICAgICAgICAgICAgIGRtYS1jb2hlcmVudDsKPiA+PiArICAgICAgICAgICAgICAgICNpb21t
dS1jZWxscyA9IDwxPjsKPiA+PiArICAgICAgICAgICAgICAgICNnbG9iYWwtaW50ZXJydXB0cyA9
IDwxPjsKPiA+PiArICAgICAgICAgICAgICAgIGludGVycnVwdHMgPSA8R0lDX1NQSSA2IElSUV9U
WVBFX0xFVkVMX0hJR0g+LAo+ID4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgPEdJQ19TUEkg
NiBJUlFfVFlQRV9MRVZFTF9ISUdIPiwKPiA+PiArICAgICAgICAgICAgICAgICAgICAgICAgIDxH
SUNfU1BJIDYgSVJRX1RZUEVfTEVWRUxfSElHSD4sCj4gPj4gKyAgICAgICAgICAgICAgICAgICAg
ICAgICA8R0lDX1NQSSA2IElSUV9UWVBFX0xFVkVMX0hJR0g+LAo+ID4+ICsgICAgICAgICAgICAg
ICAgICAgICAgICAgPEdJQ19TUEkgNiBJUlFfVFlQRV9MRVZFTF9ISUdIPiwKPiA+PiArICAgICAg
ICAgICAgICAgICAgICAgICAgIDxHSUNfU1BJIDYgSVJRX1RZUEVfTEVWRUxfSElHSD4sCj4gPj4g
KyAgICAgICAgICAgICAgICAgICAgICAgICA8R0lDX1NQSSA2IElSUV9UWVBFX0xFVkVMX0hJR0g+
LAo+ID4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgPEdJQ19TUEkgNiBJUlFfVFlQRV9MRVZF
TF9ISUdIPiwKPiA+PiArICAgICAgICAgICAgICAgICAgICAgICAgIDxHSUNfU1BJIDYgSVJRX1RZ
UEVfTEVWRUxfSElHSD47Cj4gPgo+ID4gSSdkIHJlY29tbWVuZCB5b3UgaGF2ZSB0aGUgbm9kZSBk
aXNhYmxlZCBieSBkZWZhdWx0IGhlcmUsIHRoZW4KPiA+IGV4cGxpY2l0bHkgZW5hYmxlIGl0IGlu
IGFybWFkYS04MDQwLmR0c2kgd2hlcmUgeW91IGFkZCB0aGUgU3RyZWFtIElEcy4KPiA+IE90aGVy
d2lzZSBpdCB3aWxsIGFsc28gZW5kIHVwIGVuYWJsZWQgZm9yIDgwMjAsIDcweDAsIGV0Yy4gd2hl
cmUKPiA+IGRpc2FibGVfYnlwYXNzIHdpbGwgdGhlbiBjYXRhc3Ryb3BoaWNhbGx5IGJyZWFrIGV2
ZXJ5dGhpbmcuCj4gPgo+Cj4gR29vZCBwb2ludCEgSSB3aWxsIGZpeCB0aGlzLgo+CgpJbiBhZGRp
dGlvbiB0byBhYm92ZSwgSSB0aGluayBpdCBpcyB3b3J0aCBkZWZpbmluZyB0aGUgc3RyZWFtIElE
J3MgZm9yCkFybWFkYSA3MDQwIGFuZCBDTjkxM3ggU29Dcy4KCkJlc3QgcmVnYXJkcywKTWFyY2lu
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1h
aWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3Rz
LmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
