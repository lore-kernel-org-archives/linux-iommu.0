Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 091BFC4332F
	for <iommu@archiver.kernel.org>; Sat, 11 Dec 2021 14:57:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9CF9961C4B;
	Sat, 11 Dec 2021 14:57:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qvC-HMudJVmw; Sat, 11 Dec 2021 14:57:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 2CC3461C41;
	Sat, 11 Dec 2021 14:57:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AF960C0073;
	Sat, 11 Dec 2021 14:57:44 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 11AEBC0012;
 Fri, 10 Dec 2021 07:44:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E408361267;
 Fri, 10 Dec 2021 07:44:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2RqTrIo9LZRr; Fri, 10 Dec 2021 07:44:03 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com
 [IPv6:2607:f8b0:4864:20::536])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5992E61263;
 Fri, 10 Dec 2021 07:44:03 +0000 (UTC)
Received: by mail-pg1-x536.google.com with SMTP id l18so2662514pgj.9;
 Thu, 09 Dec 2021 23:44:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:to:cc:references
 :from:in-reply-to:content-transfer-encoding;
 bh=FYFBhmavOHQihQEBX9qGXsO80PWaXrVj26hswLpne0s=;
 b=eG+dAPNpmN++zkv+fyWyJm9db2yzcXdaxWLsIDeNrM9/yL83hTHf9VWSkbOQK7h6hM
 Wlj/u3dtTGGsr1WM3qnBX5p59ibJ2UWj0/j+XWpG/tEacNWRzkoWytB17nxhlXdNVC2y
 RnNAYGMHaxEvW5WS7jDhS/fK+O5Gq63015sDuBfT8AfK5aOhuV3Ic3GuiN4JvVgC/x7i
 eec5AQFzLkkQkv9h4mhe2Rh7QcMiJbAxca73e5nrylXCYayDnebl2aF/Brekj2CjFD0F
 t1I3tDGsE7w3AKpWWqUALBve87HRS41uV7DfVDpOdl2CYYpeNu0XyfLRmLT0MDs/BoQi
 Lflw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :to:cc:references:from:in-reply-to:content-transfer-encoding;
 bh=FYFBhmavOHQihQEBX9qGXsO80PWaXrVj26hswLpne0s=;
 b=QgrnerkJXdASBrOtT1E7TmgWG2cE/FfH97zsxgHBTjaQbKNt1BhwZTSKSLD11m1bBs
 P9O6wPkmfLS0MrgizFMfDxu7aiOyEbhKIsgml/q6IL6dvQemKwbu9ui8EZYT+0aE2C57
 KuwIXFYoYg68MCxd0xFKFr/EiKWo/3Og2LpyDwobLKrAUCWsRFn8BOtlcPUxqASHD8uP
 N2d3T4wfnXpj4w8BY50NkhkFjn3PKe2KoXecnKErVVYIdn9IQfiWcvTZpPGQ/KgaCe7O
 ckGCuhol35KkXpzTdsCJm4dwLgW9NpG4F6m8QlM7F1AD+C5JF8Wa+hl78mutD3v2HpUP
 jaGA==
X-Gm-Message-State: AOAM533Ag+/ZHxBcs0/sqvNqY9J2HQWwHWmnmsVRzHOcacPl//1aRFsp
 YwCzrC1vBBFEblCKQi+KH44=
X-Google-Smtp-Source: ABdhPJwBPXWYkvIGUGnrjWv+j12lBB8kMdBIkbohxceo7qPeZwVXgp1O9cfcTUiYk9mgFRMURfHLMw==
X-Received: by 2002:a62:790e:0:b0:4af:e9c0:3322 with SMTP id
 u14-20020a62790e000000b004afe9c03322mr8145425pfc.86.1639122242728; 
 Thu, 09 Dec 2021 23:44:02 -0800 (PST)
Received: from [30.240.98.4] ([205.204.117.108])
 by smtp.gmail.com with ESMTPSA id a26sm1908458pfh.161.2021.12.09.23.43.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Dec 2021 23:44:02 -0800 (PST)
Message-ID: <2926b360-5204-45f5-e1a0-e260214f8dbf@gmail.com>
Date: Fri, 10 Dec 2021 15:43:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.2.1
Subject: Re: [RFC PATCH v2 1/7] mm: page_alloc: avoid merging non-fallbackable
 pageblocks with others.
To: Zi Yan <ziy@nvidia.com>, David Hildenbrand <david@redhat.com>,
 linux-mm@kvack.org
References: <20211209230414.2766515-1-zi.yan@sent.com>
 <20211209230414.2766515-2-zi.yan@sent.com>
From: Eric Ren <renzhengeek@gmail.com>
In-Reply-To: <20211209230414.2766515-2-zi.yan@sent.com>
X-Mailman-Approved-At: Sat, 11 Dec 2021 14:57:43 +0000
Cc: Mel Gorman <mgorman@techsingularity.net>,
 Michael Ellerman <mpe@ellerman.id.au>, Robin Murphy <robin.murphy@arm.com>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 virtualization@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
 Christoph Hellwig <hch@lst.de>, Vlastimil Babka <vbabka@suse.cz>
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

SGksCgpPbiAyMDIxLzEyLzEwIDA3OjA0LCBaaSBZYW4gd3JvdGU6Cj4gRnJvbTogWmkgWWFuIDx6
aXlAbnZpZGlhLmNvbT4KPgo+IFRoaXMgaXMgZG9uZSBpbiBhZGRpdGlvbiB0byBNSUdSQVRFX0lT
T0xBVEUgcGFnZWJsb2NrIG1lcmdlIGF2b2lkYW5jZS4KPiBJdCBwcmVwYXJlcyBmb3IgdGhlIHVw
Y29taW5nIHJlbW92YWwgb2YgdGhlIE1BWF9PUkRFUi0xIGFsaWdubWVudAo+IHJlcXVpcmVtZW50
IGZvciBDTUEgYW5kIGFsbG9jX2NvbnRpZ19yYW5nZSgpLgo+Cj4gTUlHUkFSVEVfSElHSEFUT01J
QyBzaG91bGQgbm90IG1lcmdlIHdpdGggb3RoZXIgbWlncmF0ZXR5cGVzIGxpa2UKPiBNSUdSQVRF
X0lTT0xBVEUgYW5kIE1JR1JBUlRFX0NNQVsxXSwgc28gdGhpcyBjb21taXQgcHJldmVudHMgdGhh
dCB0b28uCj4gQWxzbyBhZGQgTUlHUkFSVEVfSElHSEFUT01JQyB0byBmYWxsYmFja3MgYXJyYXkg
Zm9yIGNvbXBsZXRlbmVzcy4KPgo+IFsxXSBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1t
bS8yMDIxMTEzMDEwMDg1My5HUDMzNjZAdGVjaHNpbmd1bGFyaXR5Lm5ldC8KPgo+IFNpZ25lZC1v
ZmYtYnk6IFppIFlhbiA8eml5QG52aWRpYS5jb20+Cj4gLS0tCj4gICBpbmNsdWRlL2xpbnV4L21t
em9uZS5oIHwgIDYgKysrKysrCj4gICBtbS9wYWdlX2FsbG9jLmMgICAgICAgIHwgMjggKysrKysr
KysrKysrKysrKysrLS0tLS0tLS0tLQo+ICAgMiBmaWxlcyBjaGFuZ2VkLCAyNCBpbnNlcnRpb25z
KCspLCAxMCBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L21tem9u
ZS5oIGIvaW5jbHVkZS9saW51eC9tbXpvbmUuaAo+IGluZGV4IDU4ZTc0NGI3OGMyYy4uYjkyNTQz
MWIwMTIzIDEwMDY0NAo+IC0tLSBhL2luY2x1ZGUvbGludXgvbW16b25lLmgKPiArKysgYi9pbmNs
dWRlL2xpbnV4L21tem9uZS5oCj4gQEAgLTgzLDYgKzgzLDEyIEBAIHN0YXRpYyBpbmxpbmUgYm9v
bCBpc19taWdyYXRlX21vdmFibGUoaW50IG10KQo+ICAgCXJldHVybiBpc19taWdyYXRlX2NtYSht
dCkgfHwgbXQgPT0gTUlHUkFURV9NT1ZBQkxFOwo+ICAgfQo+ICAgCj4gKy8qIFNlZSBmYWxsYmFj
a3NbTUlHUkFURV9UWVBFU11bM10gaW4gcGFnZV9hbGxvYy5jICovCj4gK3N0YXRpYyBpbmxpbmUg
Ym9vbCBtaWdyYXRldHlwZV9oYXNfZmFsbGJhY2soaW50IG10KQo+ICt7Cj4gKwlyZXR1cm4gbXQg
PCBNSUdSQVRFX1BDUFRZUEVTOwo+ICt9Cj4gKwoKSSB3b3VsZCBzdWdnZXN0IHNwbGl0aW5nIHRo
ZSBwYXRjaCBpbnRvIDIgcGFydHMuwqAgVGhlIGZpcnN0IHBhcnQ6IG5vIApmdW5jdGlvbmluZyBj
aGFuZ2UsIGp1c3QgaW50cm9kdWNlIG1pZ3JhdGV0eXBlX2hhc19mYWxsYmFjaygpCmFuZCByZXBs
YWNlIHdoZXJlIGl0IGFwcGx5cyB0by4KCj4gICAjZGVmaW5lIGZvcl9lYWNoX21pZ3JhdGV0eXBl
X29yZGVyKG9yZGVyLCB0eXBlKSBcCj4gICAJZm9yIChvcmRlciA9IDA7IG9yZGVyIDwgTUFYX09S
REVSOyBvcmRlcisrKSBcCj4gICAJCWZvciAodHlwZSA9IDA7IHR5cGUgPCBNSUdSQVRFX1RZUEVT
OyB0eXBlKyspCj4gZGlmZiAtLWdpdCBhL21tL3BhZ2VfYWxsb2MuYyBiL21tL3BhZ2VfYWxsb2Mu
Ywo+IGluZGV4IGVkZmQ2YzgxYWY4Mi4uMTA3YTVmMTg2ZDNiIDEwMDY0NAo+IC0tLSBhL21tL3Bh
Z2VfYWxsb2MuYwo+ICsrKyBiL21tL3BhZ2VfYWxsb2MuYwo+IEBAIC0xMDQxLDYgKzEwNDEsMTIg
QEAgYnVkZHlfbWVyZ2VfbGlrZWx5KHVuc2lnbmVkIGxvbmcgcGZuLCB1bnNpZ25lZCBsb25nIGJ1
ZGR5X3BmbiwKPiAgIAlyZXR1cm4gcGFnZV9pc19idWRkeShoaWdoZXJfcGFnZSwgaGlnaGVyX2J1
ZGR5LCBvcmRlciArIDEpOwo+ICAgfQo+ICAgCj4gK3N0YXRpYyBpbmxpbmUgYm9vbCBoYXNfbm9u
X2ZhbGxiYWNrX3BhZ2VibG9jayhzdHJ1Y3Qgem9uZSAqem9uZSkKPiArewo+ICsJcmV0dXJuIGhh
c19pc29sYXRlX3BhZ2VibG9jayh6b25lKSB8fCB6b25lX2NtYV9wYWdlcyh6b25lKSAhPSAwIHx8
Cj4gKwkJem9uZS0+bnJfcmVzZXJ2ZWRfaGlnaGF0b21pYyAhPSAwOwoKTWFrZSB6b25lLT5ucl9y
ZXNlcnZlZF9oaWdoYXRvbWljICE9IDAgYSBoZWxwZXIgYXMgem9uZV9jbWFfcGFnZXMoKT8KPiAr
fQo+ICsKPiAgIC8qCj4gICAgKiBGcmVlaW5nIGZ1bmN0aW9uIGZvciBhIGJ1ZGR5IHN5c3RlbSBh
bGxvY2F0b3IuCj4gICAgKgo+IEBAIC0xMTE2LDE0ICsxMTIyLDE1IEBAIHN0YXRpYyBpbmxpbmUg
dm9pZCBfX2ZyZWVfb25lX3BhZ2Uoc3RydWN0IHBhZ2UgKnBhZ2UsCj4gICAJfQo+ICAgCWlmIChv
cmRlciA8IE1BWF9PUkRFUiAtIDEpIHsKPiAgIAkJLyogSWYgd2UgYXJlIGhlcmUsIGl0IG1lYW5z
IG9yZGVyIGlzID49IHBhZ2VibG9ja19vcmRlci4KPiAtCQkgKiBXZSB3YW50IHRvIHByZXZlbnQg
bWVyZ2UgYmV0d2VlbiBmcmVlcGFnZXMgb24gaXNvbGF0ZQo+IC0JCSAqIHBhZ2VibG9jayBhbmQg
bm9ybWFsIHBhZ2VibG9jay4gV2l0aG91dCB0aGlzLCBwYWdlYmxvY2sKPiAtCQkgKiBpc29sYXRp
b24gY291bGQgY2F1c2UgaW5jb3JyZWN0IGZyZWVwYWdlIG9yIENNQSBhY2NvdW50aW5nLgo+ICsJ
CSAqIFdlIHdhbnQgdG8gcHJldmVudCBtZXJnZSBiZXR3ZWVuIGZyZWVwYWdlcyBvbiBwYWdlYmxv
Y2sKPiArCQkgKiB3aXRob3V0IGZhbGxiYWNrcyBhbmQgbm9ybWFsIHBhZ2VibG9jay4gV2l0aG91
dCB0aGlzLAo+ICsJCSAqIHBhZ2VibG9jayBpc29sYXRpb24gY291bGQgY2F1c2UgaW5jb3JyZWN0
IGZyZWVwYWdlIG9yIENNQQo+ICsJCSAqIGFjY291bnRpbmcgb3IgSElHSEFUT01JQyBhY2NvdW50
aW5nLgo+ICAgCQkgKgo+ICAgCQkgKiBXZSBkb24ndCB3YW50IHRvIGhpdCB0aGlzIGNvZGUgZm9y
IHRoZSBtb3JlIGZyZXF1ZW50Cj4gICAJCSAqIGxvdy1vcmRlciBtZXJnaW5nLgo+ICAgCQkgKi8K
PiAtCQlpZiAodW5saWtlbHkoaGFzX2lzb2xhdGVfcGFnZWJsb2NrKHpvbmUpKSkgewo+ICsJCWlm
ICh1bmxpa2VseShoYXNfbm9uX2ZhbGxiYWNrX3BhZ2VibG9jayh6b25lKSkpIHsKSSdtIG5vdCBm
YW1pbGlhciB3aXRoIHRoZSBjb2RlIGRldGFpbHMsIGp1c3Qgd29uZGVyaW5nIGlmIHRoaXMgY2hh
bmdlIAp3b3VsZCBoYXMgc2lkZSBlZmZlY3RzIG9uIGNtYQpwYWdlYmxvY2sgbWVyZ2luZyBhcyBp
dCB0aGUgY29uZGl0aW9uIHN0cm9uZ2VyPwoKVGhhbmtzLApFcmljCj4gICAJCQlpbnQgYnVkZHlf
bXQ7Cj4gICAKPiAgIAkJCWJ1ZGR5X3BmbiA9IF9fZmluZF9idWRkeV9wZm4ocGZuLCBvcmRlcik7
Cj4gQEAgLTExMzEsOCArMTEzOCw4IEBAIHN0YXRpYyBpbmxpbmUgdm9pZCBfX2ZyZWVfb25lX3Bh
Z2Uoc3RydWN0IHBhZ2UgKnBhZ2UsCj4gICAJCQlidWRkeV9tdCA9IGdldF9wYWdlYmxvY2tfbWln
cmF0ZXR5cGUoYnVkZHkpOwo+ICAgCj4gICAJCQlpZiAobWlncmF0ZXR5cGUgIT0gYnVkZHlfbXQK
PiAtCQkJCQkmJiAoaXNfbWlncmF0ZV9pc29sYXRlKG1pZ3JhdGV0eXBlKSB8fAo+IC0JCQkJCQlp
c19taWdyYXRlX2lzb2xhdGUoYnVkZHlfbXQpKSkKPiArCQkJCQkmJiAoIW1pZ3JhdGV0eXBlX2hh
c19mYWxsYmFjayhtaWdyYXRldHlwZSkgfHwKPiArCQkJCQkJIW1pZ3JhdGV0eXBlX2hhc19mYWxs
YmFjayhidWRkeV9tdCkpKQo+ICAgCQkJCWdvdG8gZG9uZV9tZXJnaW5nOwo+ICAgCQl9Cj4gICAJ
CW1heF9vcmRlciA9IG9yZGVyICsgMTsKPiBAQCAtMjQ4Myw2ICsyNDkwLDcgQEAgc3RhdGljIGlu
dCBmYWxsYmFja3NbTUlHUkFURV9UWVBFU11bM10gPSB7Cj4gICAJW01JR1JBVEVfVU5NT1ZBQkxF
XSAgID0geyBNSUdSQVRFX1JFQ0xBSU1BQkxFLCBNSUdSQVRFX01PVkFCTEUsICAgTUlHUkFURV9U
WVBFUyB9LAo+ICAgCVtNSUdSQVRFX01PVkFCTEVdICAgICA9IHsgTUlHUkFURV9SRUNMQUlNQUJM
RSwgTUlHUkFURV9VTk1PVkFCTEUsIE1JR1JBVEVfVFlQRVMgfSwKPiAgIAlbTUlHUkFURV9SRUNM
QUlNQUJMRV0gPSB7IE1JR1JBVEVfVU5NT1ZBQkxFLCAgIE1JR1JBVEVfTU9WQUJMRSwgICBNSUdS
QVRFX1RZUEVTIH0sCj4gKwlbTUlHUkFURV9ISUdIQVRPTUlDXSA9IHsgTUlHUkFURV9UWVBFUyB9
LCAvKiBOZXZlciB1c2VkICovCj4gICAjaWZkZWYgQ09ORklHX0NNQQo+ICAgCVtNSUdSQVRFX0NN
QV0gICAgICAgICA9IHsgTUlHUkFURV9UWVBFUyB9LCAvKiBOZXZlciB1c2VkICovCj4gICAjZW5k
aWYKPiBAQCAtMjc5NCw4ICsyODAyLDggQEAgc3RhdGljIHZvaWQgcmVzZXJ2ZV9oaWdoYXRvbWlj
X3BhZ2VibG9jayhzdHJ1Y3QgcGFnZSAqcGFnZSwgc3RydWN0IHpvbmUgKnpvbmUsCj4gICAKPiAg
IAkvKiBZb2luayEgKi8KPiAgIAltdCA9IGdldF9wYWdlYmxvY2tfbWlncmF0ZXR5cGUocGFnZSk7
Cj4gLQlpZiAoIWlzX21pZ3JhdGVfaGlnaGF0b21pYyhtdCkgJiYgIWlzX21pZ3JhdGVfaXNvbGF0
ZShtdCkKPiAtCSAgICAmJiAhaXNfbWlncmF0ZV9jbWEobXQpKSB7Cj4gKwkvKiBPbmx5IHJlc2Vy
dmUgbm9ybWFsIHBhZ2VibG9jayAqLwo+ICsJaWYgKG1pZ3JhdGV0eXBlX2hhc19mYWxsYmFjayht
dCkpIHsKPiAgIAkJem9uZS0+bnJfcmVzZXJ2ZWRfaGlnaGF0b21pYyArPSBwYWdlYmxvY2tfbnJf
cGFnZXM7Cj4gICAJCXNldF9wYWdlYmxvY2tfbWlncmF0ZXR5cGUocGFnZSwgTUlHUkFURV9ISUdI
QVRPTUlDKTsKPiAgIAkJbW92ZV9mcmVlcGFnZXNfYmxvY2soem9uZSwgcGFnZSwgTUlHUkFURV9I
SUdIQVRPTUlDLCBOVUxMKTsKPiBAQCAtMzU0NCw4ICszNTUyLDggQEAgaW50IF9faXNvbGF0ZV9m
cmVlX3BhZ2Uoc3RydWN0IHBhZ2UgKnBhZ2UsIHVuc2lnbmVkIGludCBvcmRlcikKPiAgIAkJc3Ry
dWN0IHBhZ2UgKmVuZHBhZ2UgPSBwYWdlICsgKDEgPDwgb3JkZXIpIC0gMTsKPiAgIAkJZm9yICg7
IHBhZ2UgPCBlbmRwYWdlOyBwYWdlICs9IHBhZ2VibG9ja19ucl9wYWdlcykgewo+ICAgCQkJaW50
IG10ID0gZ2V0X3BhZ2VibG9ja19taWdyYXRldHlwZShwYWdlKTsKPiAtCQkJaWYgKCFpc19taWdy
YXRlX2lzb2xhdGUobXQpICYmICFpc19taWdyYXRlX2NtYShtdCkKPiAtCQkJICAgICYmICFpc19t
aWdyYXRlX2hpZ2hhdG9taWMobXQpKQo+ICsJCQkvKiBPbmx5IGNoYW5nZSBub3JtYWwgcGFnZWJs
b2NrICovCj4gKwkJCWlmIChtaWdyYXRldHlwZV9oYXNfZmFsbGJhY2sobXQpKQo+ICAgCQkJCXNl
dF9wYWdlYmxvY2tfbWlncmF0ZXR5cGUocGFnZSwKPiAgIAkJCQkJCQkgIE1JR1JBVEVfTU9WQUJM
RSk7Cj4gICAJCX0KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpo
dHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
