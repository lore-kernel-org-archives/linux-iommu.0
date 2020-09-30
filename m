Return-Path: <SRS0=Vh7E=DH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2112C4727E
	for <iommu@archiver.kernel.org>; Wed, 30 Sep 2020 16:26:06 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 538CD2076B
	for <iommu@archiver.kernel.org>; Wed, 30 Sep 2020 16:26:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ho4YvFna"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 538CD2076B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 0455987224;
	Wed, 30 Sep 2020 16:26:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WYdf00WvZfKZ; Wed, 30 Sep 2020 16:26:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 7DC5487215;
	Wed, 30 Sep 2020 16:26:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6B2A6C0889;
	Wed, 30 Sep 2020 16:26:05 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 58018C0051
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 16:26:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 53C418721A
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 16:26:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jHNpGPhs1Cak for <iommu@lists.linux-foundation.org>;
 Wed, 30 Sep 2020 16:26:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-lf1-f68.google.com (mail-lf1-f68.google.com
 [209.85.167.68])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 628FC87214
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 16:26:03 +0000 (UTC)
Received: by mail-lf1-f68.google.com with SMTP id y2so2873484lfy.10
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 09:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=SuXQIv4rAYyKxF7mNw/hB2x+1vIgmAIMqQQxl7zvhHc=;
 b=ho4YvFnap5VEc/95+eLZBD59p6xrw0ujaSjV8tg/BgqlbbXNyIJNKQgpij17cPF/sL
 d2tFi6aHNWl7oAq6ZvsN5jNKcgpCab8rAR9V9iiZxH0BcyNDM9y9oxfHK24QGA6/6UsU
 onB0cS4BGdTODgOTZ43eGRPTjenzqnrLk9BiIYZHxYW0C9h9rlrtbzY/bFbEW516D+bL
 fWS1qrLTvobEysmaGcWiW/157FX+f9ov9tCZJavPhj4ULZOAebzLI9kGQWQtPKlK/GMs
 Da7O9szadEypjAKX/9FgWiS/edUjMv0ndCyNmkMOa9zZVa8uJbpiObrqREXesrKz4gK8
 rVQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=SuXQIv4rAYyKxF7mNw/hB2x+1vIgmAIMqQQxl7zvhHc=;
 b=bOh+bmwpwGw+o2okiq/UG7eQJfvBeggwgZBvOdHWJiobiTKjpFV6UaXC4TgNVYHNjl
 Y82/etkgGg4oKGs1EvhS4Wv8rBzyiMy6u+seransIEHjKibAKpOlueGLdr4PVQdTaspZ
 CakS6dNMK5u/f+NFy391T45j0IPPBvoTAqDL1JaeVEblHgHDAb8XYGWD9jTxKC867myV
 qyfyV0rx87ZyRoxSxsJqe/paBhYBmcymPzLoRNyZtncROBQzSr4m3PFUyBdaOC7SivfZ
 x4B9YsmccmdGOLvGxLMjTwGL+UgF9Q7cDq/DU4yjPxs+L1wp79poUJxcRuOIsnH6MpKt
 4bTQ==
X-Gm-Message-State: AOAM533ejR+kMl0QUNp8D8yX7GxEHJlUwx5Ncn++sV/a/X5To+vrEIyg
 C5+Gp7kREuzLZYr08Ra6mUU=
X-Google-Smtp-Source: ABdhPJzlO0UvoTuAN0AyWrnYLP8ntndzxgjv2bnb5g4LJVicV2FFyv8u9bqwl1yhPYET31YGkSDDBA==
X-Received: by 2002:a19:8703:: with SMTP id j3mr1054717lfd.560.1601483161229; 
 Wed, 30 Sep 2020 09:26:01 -0700 (PDT)
Received: from [192.168.2.145] (109-252-170-211.dynamic.spd-mgts.ru.
 [109.252.170.211])
 by smtp.googlemail.com with ESMTPSA id m13sm244795lfb.172.2020.09.30.09.26.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Sep 2020 09:26:00 -0700 (PDT)
Subject: Re: [PATCH v3 1/3] memory: tegra: Add
 devm_tegra_get_memory_controller()
To: Thierry Reding <thierry.reding@gmail.com>
References: <20200930084258.25493-1-nicoleotsuka@gmail.com>
 <20200930084258.25493-2-nicoleotsuka@gmail.com>
 <20200930152320.GA3833404@ulmo>
 <ed7b4375-d06e-2750-e6fa-603ef2b60d36@gmail.com>
 <20200930160355.GC3833404@ulmo>
 <839df5d6-513f-3d77-ba5f-a1afe5d0883a@gmail.com>
 <20200930161503.GF3833404@ulmo>
From: Dmitry Osipenko <digetx@gmail.com>
Message-ID: <29a989b3-a8cc-5c1f-ba12-47ed0d667e8e@gmail.com>
Date: Wed, 30 Sep 2020 19:26:00 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200930161503.GF3833404@ulmo>
Content-Language: en-US
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 krzk@kernel.org, jonathanh@nvidia.com, linux-tegra@vger.kernel.org
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

MzAuMDkuMjAyMCAxOToxNSwgVGhpZXJyeSBSZWRpbmcg0L/QuNGI0LXRgjoKPiBPbiBXZWQsIFNl
cCAzMCwgMjAyMCBhdCAwNzowNjoyN1BNICswMzAwLCBEbWl0cnkgT3NpcGVua28gd3JvdGU6Cj4+
IDMwLjA5LjIwMjAgMTk6MDMsIFRoaWVycnkgUmVkaW5nINC/0LjRiNC10YI6Cj4+PiBPbiBXZWQs
IFNlcCAzMCwgMjAyMCBhdCAwNjo1MzowNlBNICswMzAwLCBEbWl0cnkgT3NpcGVua28gd3JvdGU6
Cj4+Pj4gMzAuMDkuMjAyMCAxODoyMywgVGhpZXJyeSBSZWRpbmcg0L/QuNGI0LXRgjoKPj4+Pj4g
T24gV2VkLCBTZXAgMzAsIDIwMjAgYXQgMDE6NDI6NTZBTSAtMDcwMCwgTmljb2xpbiBDaGVuIHdy
b3RlOgo+Pj4+Pj4gRnJvbTogRG1pdHJ5IE9zaXBlbmtvIDxkaWdldHhAZ21haWwuY29tPgo+Pj4+
Pj4KPj4+Pj4+IE11bHRpcGxlIFRlZ3JhIGRyaXZlcnMgbmVlZCB0byByZXRyaWV2ZSBNZW1vcnkg
Q29udHJvbGxlciBhbmQgaGVuY2UgdGhlcmUKPj4+Pj4+IGlzIHF1aXRlIHNvbWUgZHVwbGljYXRp
b24gb2YgdGhlIHJldHJpZXZhbCBjb2RlIGFtb25nIHRoZSBkcml2ZXJzLiBMZXQncwo+Pj4+Pj4g
YWRkIGEgbmV3IGNvbW1vbiBoZWxwZXIgZm9yIHRoZSByZXRyaWV2YWwgb2YgdGhlIE1DLgo+Pj4+
Pj4KPj4+Pj4+IFNpZ25lZC1vZmYtYnk6IERtaXRyeSBPc2lwZW5rbyA8ZGlnZXR4QGdtYWlsLmNv
bT4KPj4+Pj4+IFNpZ25lZC1vZmYtYnk6IE5pY29saW4gQ2hlbiA8bmljb2xlb3RzdWthQGdtYWls
LmNvbT4KPj4+Pj4+IC0tLQo+Pj4+Pj4KPj4+Pj4+IENoYW5nZWxvZwo+Pj4+Pj4gdjItPnYzOgo+
Pj4+Pj4gICogUmVwbGFjZWQgd2l0aCBEaW10cnkncyBkZXZtX3RlZ3JhX2dldF9tZW1vcnlfY29u
dHJvbGxlcigpCj4+Pj4+PiB2MS0+djI6Cj4+Pj4+PiAgKiBOL0EKPj4+Pj4+Cj4+Pj4+PiAgZHJp
dmVycy9tZW1vcnkvdGVncmEvbWMuYyB8IDM5ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKwo+Pj4+Pj4gIGluY2x1ZGUvc29jL3RlZ3JhL21jLmggICAgfCAxNyArKysrKysr
KysrKysrKysrKwo+Pj4+Pj4gIDIgZmlsZXMgY2hhbmdlZCwgNTYgaW5zZXJ0aW9ucygrKQo+Pj4+
Pgo+Pj4+PiBMZXQncyBub3QgYWRkIHRoaXMgaGVscGVyLCBwbGVhc2UuIElmIGEgZGV2aWNlIG5l
ZWRzIGEgcmVmZXJlbmNlIHRvIHRoZQo+Pj4+PiBtZW1vcnkgY29udHJvbGxlciwgaXQgc2hvdWxk
IGhhdmUgYSBwaGFuZGxlIHRvIHRoZSBtZW1vcnkgY29udHJvbGxlciBpbgo+Pj4+PiBkZXZpY2Ug
dHJlZSBzbyB0aGF0IGl0IGNhbiBiZSBsb29rZWQgdXAgZXhwbGljaXRseS4KPj4+Pj4KPj4+Pj4g
QWRkaW5nIHRoaXMgaGVscGVyIGlzIG9mZmljaWFsbHkgc2FuY3Rpb25pbmcgdGhhdCBpdCdzIG9r
YXkgbm90IHRvIGhhdmUKPj4+Pj4gdGhhdCByZWZlcmVuY2UgYW5kIHRoYXQncyBhIGJhZCBpZGVh
Lgo+Pj4+Cj4+Pj4gQW5kIHBsZWFzZSBleHBsYWluIHdoeSBpdCdzIGEgYmFkIGlkZWEsIEkgZG9u
J3Qgc2VlIGFueXRoaW5nIGJhZCBoZXJlIGF0Cj4+Pj4gYWxsLgo+Pj4KPj4+IFdlbGwsIHlvdSBz
YWlkIHlvdXJzZWxmIGluIGEgcmVjZW50IGNvbW1lbnQgdGhhdCB3ZSBzaG91bGQgYXZvaWQgZ2xv
YmFsCj4+PiB2YXJpYWJsZXMuIGRldm1fdGVncmFfZ2V0X21lbW9yeV9jb250cm9sbGVyKCkgaXMg
bm90aGluZyBidXQgYSBnbG9yaWZpZWQKPj4+IGdsb2JhbCB2YXJpYWJsZS4KPj4KPj4gVGhpcyBp
cyBub3QgYSB2YXJpYWJsZSwgYnV0IGEgY29tbW9uIGhlbHBlciBmdW5jdGlvbiB3aGljaCB3aWxs
IHJlbW92ZQo+PiB0aGUgZHVwbGljYXRlZCBjb2RlIGFuZCB3aWxsIGhlbHAgdG8gYXZvaWQgY29t
bW9uIG1pc3Rha2VzIGxpa2UgYSBtaXNzZWQKPj4gcHV0X2RldmljZSgpLgo+IAo+IFllYWgsIHlv
dSdyZSByaWdodDogdGhpcyBpcyBhY3R1YWxseSBtdWNoIHdvcnNlIHRoYW4gYSBnbG9iYWwgdmFy
aWFibGUuCj4gSXQncyBhIGhlbHBlciBmdW5jdGlvbiB0aGF0IG5lZWRzIDUwKyBsaW5lcyBpbiBv
cmRlciB0byBlZmZlY3RpdmVseQo+IGFjY2VzcyBhIGdsb2JhbCB2YXJpYWJsZS4KPiAKPiBZb3Ug
Y291bGQgd3JpdGUgdGhpcyBtdWNoIHNpbXBsZXIgYnkgZG9pbmcgc29tZXRoaW5nIGxpa2UgdGhp
czoKPiAKPiAJc3RhdGljIHN0cnVjdCB0ZWdyYV9tYyAqZ2xvYmFsX21jOwo+IAo+IAlpbnQgdGVn
cmFfbWNfcHJvYmUoLi4uKQo+IAl7Cj4gCQkuLi4KPiAKPiAJCWdsb2JhbF9tYyA9IG1jOwo+IAo+
IAkJLi4uCj4gCX0KPiAKPiAJc3RydWN0IHRlZ3JhX21jICp0ZWdyYV9nZXRfbWVtb3J5X2NvbnRy
b2xsZXIodm9pZCkKPiAJewo+IAkJcmV0dXJuIGdsb2JhbF9tYzsKPiAJfQo+IAo+IFRoZSByZXN1
bHQgaXMgKmV4YWN0bHkqIHRoZSBzYW1lLCBleGNlcHQgdGhhdCB0aGlzIGlzIGFjdHVhbGx5IG1v
cmUKPiBob25lc3QuIE5pY29saW4ncyBwYXRjaCAqcHJldGVuZHMqIHRoYXQgaXQgaXNuJ3QgdXNp
bmcgYSBnbG9iYWwgdmFyaWFibGUKPiBieSB3cmFwcGluZyBhIGxvdCBvZiBjb21wbGljYXRlZCBj
b2RlIGFyb3VuZCBpdC4KPiAKPiBCdXQgdGhhdCBkb2Vzbid0IGNoYW5nZSB0aGUgZmFjdCB0aGF0
IHRoaXMgYWNjZXNzZXMgYSBzaW5nbGV0b24gb2JqZWN0Cj4gd2l0aG91dCBhY3R1YWxseSBiZWlu
ZyBhYmxlIHRvIHRpZSBpdCB0byB0aGUgZGV2aWNlIGluIHRoZSBmaXJzdCBwbGFjZS4KCkkgZG9u
J3QgdGhpbmsgdGhhdCB0aGUgTUMgZHJpdmVyIHdpbGwgc3RheSBidWlsdC1pbiBmb3JldmVyLCBh
bHRob3VnaAppdHMgbW9kdWxhcml6YXRpb24gaXMgY29tcGxpY2F0ZWQgcmlnaHQgbm93LiBIZW5j
ZSBzb21ldGhpbmcgc2hhbGwga2VlcAp0aGUgcmVmZXJlbmNlIHRvIHRoZSBNQyBkZXZpY2UgcmVz
b3VyY2VzIHdoaWxlIHRoZXkgYXJlIGluIHVzZSBhbmQgdGhpcwpwYXRjaCB0YWtlcyBjYXJlIG9m
IGRvaW5nIHRoYXQuCgpTZWNvbmRseSwgdGhlIE5pY29saW4ncyBwYXRjaCBkb2Vzbid0IHByZXRl
bmQgb24gYW55dGhpbmcsIGJ1dCByYXRoZXIKYnJpbmdzIHRoZSBhbHJlYWR5IGV4aXN0aW5nIGR1
cGxpY2F0ZWQgY29kZSB0byBhIHNpbmdsZSBjb21tb24gcGxhY2UuCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBs
aXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5v
cmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
