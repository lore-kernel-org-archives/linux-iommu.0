Return-Path: <SRS0=r5As=AO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FF64C433E0
	for <iommu@archiver.kernel.org>; Fri,  3 Jul 2020 09:33:27 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA41B206A1
	for <iommu@archiver.kernel.org>; Fri,  3 Jul 2020 09:33:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=semihalf-com.20150623.gappssmtp.com header.i=@semihalf-com.20150623.gappssmtp.com header.b="Pa5s69St"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA41B206A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=semihalf.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id A3C2787DC1;
	Fri,  3 Jul 2020 09:33:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YUqOUxHRGIdS; Fri,  3 Jul 2020 09:33:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 275568795A;
	Fri,  3 Jul 2020 09:33:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0D342C088E;
	Fri,  3 Jul 2020 09:33:26 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2E4C1C0733
 for <iommu@lists.linux-foundation.org>; Fri,  3 Jul 2020 09:33:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 2AB9887A57
 for <iommu@lists.linux-foundation.org>; Fri,  3 Jul 2020 09:33:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uJ-qMyp1sijw for <iommu@lists.linux-foundation.org>;
 Fri,  3 Jul 2020 09:33:24 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-lj1-f193.google.com (mail-lj1-f193.google.com
 [209.85.208.193])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 261E68795A
 for <iommu@lists.linux-foundation.org>; Fri,  3 Jul 2020 09:33:24 +0000 (UTC)
Received: by mail-lj1-f193.google.com with SMTP id n23so36222574ljh.7
 for <iommu@lists.linux-foundation.org>; Fri, 03 Jul 2020 02:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=semihalf-com.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=FxORWevFMuPysEWqwp7nhsVM+UgCIl2L6xusN6h/tRo=;
 b=Pa5s69StIWHqUszCnn7WyIkhL3j+RajqkShp8k3dvCEVibyOe0GMLFnbZpxTqORJbm
 DQrixJG2YkDXrhh1sLs/XgxA5tes5bCbL1xR6BOYa7f6P9j7t5W5rlnNav4M4qA0/Asm
 QXPh//FRRJNTzfHoQViYPLngKyafB6kAZB1SNlf8blPIcbpmEDr1WiIpFWf50KZA1AeA
 E/0FtRT62fkshSeBqe5ahRC3LI+WU97GHJVErWiqarDYYZP0ZPuOCEX6F3R4q5W7PAJg
 8h1ZRUYYKKCWxhgNbzQpXwjLneJmKBEFO5kPyCU3mowvLD6bQ24f5JSQooY2fj9cehSa
 qB7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=FxORWevFMuPysEWqwp7nhsVM+UgCIl2L6xusN6h/tRo=;
 b=h6N/JMProiqw16TyFDhsgqdIRKp5b8EDJeTokV17ASbxO03zmHTYuBhNWbnH04cIXy
 koJY8+IUHNU39JJIsgu1mDy9xAPOk53MPFMZ2ot8snXfjwB9i3RPlabKEXRuJo0Z5a/d
 n3yZx+RJJdzFkyKIoVXRn6u6ccOmpNUJjmr8y+TU6otxawF5H+8FeCocSUqhjJ2e/MFM
 fTGV46MhnvNgEOEPoT9B7QgdIByBIA+E2CYWN992NzaZ0bRcXEtOhA7dc/hXVCU4dWXk
 4rbkkEmvh+bxAQNdh8sTI/bTp36NmeazXsPeEDc+5Au8Lka1duoQ9xhOikxbnyO8qreF
 J2BA==
X-Gm-Message-State: AOAM533OKnMEjR0fcdT3u3rGjndPGNzaDYHQIx/dM/I11q1A7F41nugR
 k8qnXNg1ctWHMF6NywOJ7Xethg==
X-Google-Smtp-Source: ABdhPJzd/ZgbHMgl58AU/eQVn4qA4l5hP0brJ3GW/SvYfHe/nK8939nIQ/LSupb0XRiMYcgIBwPmfA==
X-Received: by 2002:a2e:b6d2:: with SMTP id m18mr699203ljo.341.1593768802134; 
 Fri, 03 Jul 2020 02:33:22 -0700 (PDT)
Received: from [192.168.1.9] ([83.68.95.66])
 by smtp.googlemail.com with ESMTPSA id c14sm3908884ljj.112.2020.07.03.02.33.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Jul 2020 02:33:21 -0700 (PDT)
Subject: Re: [PATCH v3 4/4] arm64: dts: marvell: add SMMU support
To: Robin Murphy <robin.murphy@arm.com>, will@kernel.org, joro@8bytes.org,
 gregory.clement@bootlin.com, robh+dt@kernel.org, hannah@marvell.com
References: <20200702201633.22693-1-tn@semihalf.com>
 <20200702201633.22693-5-tn@semihalf.com>
 <ba29e839-79e0-7189-f735-d457544135e4@arm.com>
From: Tomasz Nowicki <tn@semihalf.com>
Message-ID: <3d9b3d16-00e4-d3b5-344b-8515c70fb83e@semihalf.com>
Date: Fri, 3 Jul 2020 11:33:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <ba29e839-79e0-7189-f735-d457544135e4@arm.com>
Content-Language: en-US
Cc: devicetree@vger.kernel.org, catalin.marinas@arm.com,
 linux-kernel@vger.kernel.org, nadavh@marvell.com,
 iommu@lists.linux-foundation.org, mw@semihalf.com,
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

T24gMDMuMDcuMjAyMCAxMToxNiwgUm9iaW4gTXVycGh5IHdyb3RlOgo+IE9uIDIwMjAtMDctMDIg
MjE6MTYsIFRvbWFzeiBOb3dpY2tpIHdyb3RlOgo+PiBGcm9tOiBNYXJjaW4gV29qdGFzIDxtd0Bz
ZW1paGFsZi5jb20+Cj4+Cj4+IEFkZCBJT01NVSBub2RlIGZvciBNYXJ2ZWxsIEFQODA2IGJhc2Vk
IFNvQ3MgdG9nZXRoZXIgd2l0aCBwbGF0Zm9ybQo+PiBhbmQgUENJIGRldmljZSBTdHJlYW0gSUQg
bWFwcGluZy4KPj4KPj4gU2lnbmVkLW9mZi1ieTogTWFyY2luIFdvanRhcyA8bXdAc2VtaWhhbGYu
Y29tPgo+PiBTaWduZWQtb2ZmLWJ5OiBUb21hc3ogTm93aWNraSA8dG5Ac2VtaWhhbGYuY29tPgo+
PiAtLS0KPj4gwqAgYXJjaC9hcm02NC9ib290L2R0cy9tYXJ2ZWxsL2FybWFkYS04MDQwLmR0c2nC
oCB8IDM2ICsrKysrKysrKysrKysrKysrKysKPj4gwqAgYXJjaC9hcm02NC9ib290L2R0cy9tYXJ2
ZWxsL2FybWFkYS1hcDgweC5kdHNpIHwgMTcgKysrKysrKysrCj4+IMKgIDIgZmlsZXMgY2hhbmdl
ZCwgNTMgaW5zZXJ0aW9ucygrKQo+Pgo+PiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9ib290L2R0
cy9tYXJ2ZWxsL2FybWFkYS04MDQwLmR0c2kgCj4+IGIvYXJjaC9hcm02NC9ib290L2R0cy9tYXJ2
ZWxsL2FybWFkYS04MDQwLmR0c2kKPj4gaW5kZXggNzY5OWIxOTIyNGMyLi4yNWMxZGY3MDlmNzIg
MTAwNjQ0Cj4+IC0tLSBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvbWFydmVsbC9hcm1hZGEtODA0MC5k
dHNpCj4+ICsrKyBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvbWFydmVsbC9hcm1hZGEtODA0MC5kdHNp
Cj4+IEBAIC0yMywzICsyMywzOSBAQAo+PiDCoCAmY3AwX3J0YyB7Cj4+IMKgwqDCoMKgwqAgc3Rh
dHVzID0gImRpc2FibGVkIjsKPj4gwqAgfTsKPj4gKwo+PiArJmNwMF91c2IzXzAgewo+PiArwqDC
oMKgIGlvbW11cyA9IDwmc21tdSAweDQ0MD47Cj4+ICt9Owo+PiArCj4+ICsmY3AwX3VzYjNfMSB7
Cj4+ICvCoMKgwqAgaW9tbXVzID0gPCZzbW11IDB4NDQxPjsKPj4gK307Cj4+ICsKPj4gKyZjcDBf
c2F0YTAgewo+PiArwqDCoMKgIGlvbW11cyA9IDwmc21tdSAweDQ0ND47Cj4+ICt9Owo+PiArCj4+
ICsmY3AwX3NkaGNpMCB7Cj4+ICvCoMKgwqAgaW9tbXVzID0gPCZzbW11IDB4NDQ1PjsKPj4gK307
Cj4+ICsKPj4gKyZjcDFfc2F0YTAgewo+PiArwqDCoMKgIGlvbW11cyA9IDwmc21tdSAweDQ1ND47
Cj4+ICt9Owo+PiArCj4+ICsmY3AxX3VzYjNfMCB7Cj4+ICvCoMKgwqAgaW9tbXVzID0gPCZzbW11
IDB4NDUwPjsKPj4gK307Cj4+ICsKPj4gKyZjcDFfdXNiM18xIHsKPj4gK8KgwqDCoCBpb21tdXMg
PSA8JnNtbXUgMHg0NTE+Owo+PiArfTsKPj4gKwo+PiArJmNwMF9wY2llMCB7Cj4+ICvCoMKgwqAg
aW9tbXUtbWFwID0KPj4gK8KgwqDCoMKgwqDCoMKgIDwweDDCoMKgICZzbW11IDB4NDgwIDB4MjA+
LAo+PiArwqDCoMKgwqDCoMKgwqAgPDB4MTAwICZzbW11IDB4NGEwIDB4MjA+LAo+PiArwqDCoMKg
wqDCoMKgwqAgPDB4MjAwICZzbW11IDB4NGMwIDB4MjA+Owo+PiArwqDCoMKgIGlvbW11LW1hcC1t
YXNrID0gPDB4MDMxZj47Cj4gCj4gTmljZSEgSSBkbyBsaWtlIGEgZ29vZCBjb21wcmVzc2VkIG1h
cHBpbmcgOkQKPiAKPj4gK307Cj4+IGRpZmYgLS1naXQgYS9hcmNoL2FybTY0L2Jvb3QvZHRzL21h
cnZlbGwvYXJtYWRhLWFwODB4LmR0c2kgCj4+IGIvYXJjaC9hcm02NC9ib290L2R0cy9tYXJ2ZWxs
L2FybWFkYS1hcDgweC5kdHNpCj4+IGluZGV4IDdmOWI5YTY0NzcxNy4uZGVkOGI4MDgyZDc5IDEw
MDY0NAo+PiAtLS0gYS9hcmNoL2FybTY0L2Jvb3QvZHRzL21hcnZlbGwvYXJtYWRhLWFwODB4LmR0
c2kKPj4gKysrIGIvYXJjaC9hcm02NC9ib290L2R0cy9tYXJ2ZWxsL2FybWFkYS1hcDgweC5kdHNp
Cj4+IEBAIC01Niw2ICs1NiwyMyBAQAo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjb21w
YXRpYmxlID0gInNpbXBsZS1idXMiOwo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByYW5n
ZXMgPSA8MHgwIDB4MCAweGYwMDAwMDAwIDB4MTAwMDAwMD47Cj4+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIHNtbXU6IGlvbW11QDUwMDAwMDAgewo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIGNvbXBhdGlibGUgPSAibWFydmVsbCxhcDgwNi1zbW11LTUwMCIsICJhcm0sbW11LTUw
MCI7Cj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmVnID0gPDB4MTAwMDAwIDB4
MTAwMDAwPjsKPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBkbWEtY29oZXJlbnQ7
Cj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgI2lvbW11LWNlbGxzID0gPDE+Owo+
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICNnbG9iYWwtaW50ZXJydXB0cyA9IDwx
PjsKPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpbnRlcnJ1cHRzID0gPEdJQ19T
UEkgNiBJUlFfVFlQRV9MRVZFTF9ISUdIPiwKPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCA8R0lDX1NQSSA2IElSUV9UWVBFX0xFVkVMX0hJR0g+LAo+
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIDxHSUNf
U1BJIDYgSVJRX1RZUEVfTEVWRUxfSElHSD4sCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgPEdJQ19TUEkgNiBJUlFfVFlQRV9MRVZFTF9ISUdIPiwK
Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCA8R0lD
X1NQSSA2IElSUV9UWVBFX0xFVkVMX0hJR0g+LAo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIDxHSUNfU1BJIDYgSVJRX1RZUEVfTEVWRUxfSElHSD4s
Cj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgPEdJ
Q19TUEkgNiBJUlFfVFlQRV9MRVZFTF9ISUdIPiwKPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCA8R0lDX1NQSSA2IElSUV9UWVBFX0xFVkVMX0hJR0g+
LAo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIDxH
SUNfU1BJIDYgSVJRX1RZUEVfTEVWRUxfSElHSD47Cj4gCj4gSSdkIHJlY29tbWVuZCB5b3UgaGF2
ZSB0aGUgbm9kZSBkaXNhYmxlZCBieSBkZWZhdWx0IGhlcmUsIHRoZW4gCj4gZXhwbGljaXRseSBl
bmFibGUgaXQgaW4gYXJtYWRhLTgwNDAuZHRzaSB3aGVyZSB5b3UgYWRkIHRoZSBTdHJlYW0gSURz
LiAKPiBPdGhlcndpc2UgaXQgd2lsbCBhbHNvIGVuZCB1cCBlbmFibGVkIGZvciA4MDIwLCA3MHgw
LCBldGMuIHdoZXJlIAo+IGRpc2FibGVfYnlwYXNzIHdpbGwgdGhlbiBjYXRhc3Ryb3BoaWNhbGx5
IGJyZWFrIGV2ZXJ5dGhpbmcuCj4gCgpHb29kIHBvaW50ISBJIHdpbGwgZml4IHRoaXMuCgpUaGFu
a3MsClRvbWFzegpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
Xwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0
cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
