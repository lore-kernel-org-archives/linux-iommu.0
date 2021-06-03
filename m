Return-Path: <SRS0=MHXQ=K5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6579EC47083
	for <iommu@archiver.kernel.org>; Thu,  3 Jun 2021 02:14:54 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 289C8613F1
	for <iommu@archiver.kernel.org>; Thu,  3 Jun 2021 02:14:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 289C8613F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 854BF404D7;
	Thu,  3 Jun 2021 02:14:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hUVh4ZkRkfHk; Thu,  3 Jun 2021 02:14:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2F1B0404E3;
	Thu,  3 Jun 2021 02:14:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 90A86C0025;
	Thu,  3 Jun 2021 02:14:51 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 764A6C0001
 for <iommu@lists.linux-foundation.org>; Thu,  3 Jun 2021 02:14:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 581BF404E0
 for <iommu@lists.linux-foundation.org>; Thu,  3 Jun 2021 02:14:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mbG2L0cpvF8d for <iommu@lists.linux-foundation.org>;
 Thu,  3 Jun 2021 02:14:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 44553404D7
 for <iommu@lists.linux-foundation.org>; Thu,  3 Jun 2021 02:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1622686488;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zx/2l7D1S2LOGyjev2ybB3t/XTR+uhZMQmrvp1dzXq8=;
 b=QDPEaI/zl8IoNb/diBRNMxM2duUFVL6MLushPoPCjn2QsZwZbZhuse4ay0zAH80vQMioEq
 3vWAG4lMBj7AbZqtz0t1M/r38ZqeN5Qf/lW1MSRwxPJPhnxwWNvMZEjqY1OctSJCH8LhGY
 UfhgqIoGr5gMYCPHbhWTzAxHVfXONTU=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-271-fXgtqEFlNEqEnbuIVcUwhQ-1; Wed, 02 Jun 2021 22:14:45 -0400
X-MC-Unique: fXgtqEFlNEqEnbuIVcUwhQ-1
Received: by mail-pl1-f199.google.com with SMTP id
 x15-20020a170902e04fb02900f5295925dbso1939857plx.9
 for <iommu@lists.linux-foundation.org>; Wed, 02 Jun 2021 19:14:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=zx/2l7D1S2LOGyjev2ybB3t/XTR+uhZMQmrvp1dzXq8=;
 b=fhOhOvb1nEP9jWHM4Cw6Wrev127L9RliiW9e4JrQtUkOc5dyr3ThJcaqkDHA/L7+J5
 5h7YBP9QwUZjupaRJNxhLhqk53EqAh6zvZuQ1FVT/Z4D4s0Cx2Q3TWEdtKapMo21159S
 hJLsBig7Qy2pYkC6jWmzajyQE99ITpXyLQWZXTWHuaKKQlGTpBQDpxApSBlllzEuNnse
 kd1pdVTCzux95XAjqWx0v0jjzXlWvN7PD89KvmcWWVgDOVuQ9PQlXYoSTA8/Lj2pmPC5
 TNgBl+05Q41mtOaYC0svXq5ovn6XNRZ94cUuBD+LkM404tiZpJHwQUIJkqGdPvMWEe86
 JIyQ==
X-Gm-Message-State: AOAM5333eA0JhOGQyZj9ut4EFrfAe05AWmuNIgmC65sm0d7uyd33yzEY
 oxDjYGxFqzACnkaACioNML5VU3CehUj2mG05O3yEMgMtz34oUXWrQDbMRCCSMNS8NCI5Az31eE3
 Vmaa3YZa4IGZGD+bN6WhBotKd44F5gA==
X-Received: by 2002:a17:90a:dc04:: with SMTP id
 i4mr20603813pjv.75.1622686484792; 
 Wed, 02 Jun 2021 19:14:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw/nlLxc3rqkhZj4W7q+feSCqswQeiFEPfiB1UscaCkUiI3wRjQAIuNjtz/R8oNsSC9/V/iqw==
X-Received: by 2002:a17:90a:dc04:: with SMTP id
 i4mr20603782pjv.75.1622686484427; 
 Wed, 02 Jun 2021 19:14:44 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id k1sm701474pfa.30.2021.06.02.19.14.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Jun 2021 19:14:44 -0700 (PDT)
Subject: Re: [PATCH v1 2/8] virtio: Add boundary checks to virtio ring
To: Andi Kleen <ak@linux.intel.com>, mst@redhat.com
References: <20210603004133.4079390-1-ak@linux.intel.com>
 <20210603004133.4079390-3-ak@linux.intel.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <4be00b3a-a15f-7fee-317b-ddabed3c1347@redhat.com>
Date: Thu, 3 Jun 2021 10:14:38 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210603004133.4079390-3-ak@linux.intel.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, iommu@lists.linux-foundation.org,
 jpoimboe@redhat.com, robin.murphy@arm.com, hch@lst.de
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
Content-Type: text/plain; charset="gbk"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

CtTaIDIwMjEvNi8zIMnPzuc4OjQxLCBBbmRpIEtsZWVuINC0tcA6Cj4gSW4gcHJvdGVjdGVkIGd1
ZXN0IG1vZGUgd2UgZG9uJ3QgdHJ1c3QgdGhlIGhvc3QuCj4KPiBUaGlzIG1lYW5zIHdlIG5lZWQg
dG8gbWFrZSBzdXJlIHRoZSBob3N0IGNhbm5vdCBzdWJ2ZXJ0IHVzIHRocm91Z2gKPiB2aXJ0aW8g
Y29tbXVuaWNhdGlvbi4gSW4gZ2VuZXJhbCBpdCBjYW4gY29ycnVwdCBvdXIgdmlydGlvIGRhdGEK
PiBhbmQgY2F1c2UgYSBET1MsIGJ1dCBpdCBzaG91bGQgbm90IGJlIGFibGUgdG8gYWNjZXNzIGFu
eSBkYXRhCj4gdGhhdCBpcyBub3QgZXhwbGljaXRlbHkgdW5kZXIgSU8uCj4KPiBBbHNvIGJvdW5k
YXJ5IGNoZWNraW5nIHNvIHRoYXQgdGhlIGZyZWUgbGlzdCAod2hpY2ggaXMgYWNjZXNzaWJsZQo+
IHRvIHRoZSBob3N0KSBjYW5ub3QgcG9pbnQgb3V0c2lkZSB0aGUgdmlydGlvIHJpbmcuIE5vdGUg
aXQgY291bGQKPiBzdGlsbCBjb250YWluIGxvb3BzIG9yIHNpbWlsYXIsIGJ1dCB0aGVzZSBzaG91
bGQgb25seSBjYXVzZSBhbiBET1MsCj4gbm90IGEgbWVtb3J5IGNvcnJ1cHRpb24gb3IgbGVhay4K
Pgo+IFdoZW4gd2UgZGV0ZWN0IGFueSBvdXQgb2YgYm91bmRzIGRlc2NyaXB0b3IgdHJpZ2dlciBh
biBJTyBlcnJvci4KPiBXZSBhbHNvIHVzZSBhIFdBUk4oKSAoaW4gY2FzZSBpdCB3YXMgYSBzb2Z0
d2FyZSBidWcgaW5zdGVhZCBvZgo+IGFuIGF0dGFjaykuIFRoaXMgaW1wbGllcyB0aGF0IGEgbWFs
aWNpb3VzIGhvc3QgY2FuIGZsb29kCj4gdGhlIGd1ZXN0IGtlcm5lbCBsb2csIGJ1dCB0aGF0J3Mg
b25seSBhIERPUyBhbmQgYWNjZXB0YWJsZQo+IGluIHRoZSB0aHJlYXQgbW9kZWwuCj4KPiBUaGlz
IHBhdGNoIG9ubHkgaGFyZGVucyB0aGUgaW5pdGlhbCBjb25zdW1wdGlvbiBvZiB0aGUgZnJlZSBs
aXN0LAo+IHRoZSBmcmVlaW5nIGNvbWVzIGxhdGVyLgo+Cj4gQW55IG9mIHRoZXNlIGVycm9ycyBj
YW4gY2F1c2UgRE1BIG1lbW9yeSBsZWFrcywgYnV0IHRoZXJlIGlzIG5vdGhpbmcKPiB3ZSBjYW4g
ZG8gYWJvdXQgdGhhdCBhbmQgdGhhdCB3b3VsZCBiZSBqdXN0IGEgRE9TLgo+Cj4gU2lnbmVkLW9m
Zi1ieTogQW5kaSBLbGVlbiA8YWtAbGludXguaW50ZWwuY29tPgo+IC0tLQo+ICAgZHJpdmVycy92
aXJ0aW8vdmlydGlvX3JpbmcuYyB8IDQ2ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
LS0tLQo+ICAgMSBmaWxlIGNoYW5nZWQsIDQyIGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0p
Cj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYyBiL2RyaXZlcnMv
dmlydGlvL3ZpcnRpb19yaW5nLmMKPiBpbmRleCBmMzU2MjlmYTQ3YjEuLmQzN2ZmNWEwZmY1OCAx
MDA2NDQKPiAtLS0gYS9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jCj4gKysrIGIvZHJpdmVy
cy92aXJ0aW8vdmlydGlvX3JpbmcuYwo+IEBAIC00MTMsNiArNDEzLDE1IEBAIHN0YXRpYyBzdHJ1
Y3QgdnJpbmdfZGVzYyAqYWxsb2NfaW5kaXJlY3Rfc3BsaXQoc3RydWN0IHZpcnRxdWV1ZSAqX3Zx
LAo+ICAgCXJldHVybiBkZXNjOwo+ICAgfQo+ICAgCj4gKy8qIGFzc3VtZXMgbm8gaW5kaXJlY3Qg
bW9kZSAqLwo+ICtzdGF0aWMgaW5saW5lIGJvb2wgaW5zaWRlX3NwbGl0X3Jpbmcoc3RydWN0IHZy
aW5nX3ZpcnRxdWV1ZSAqdnEsCj4gKwkJCQkgICAgIHVuc2lnbmVkIGluZGV4KQo+ICt7Cj4gKwly
ZXR1cm4gIVdBUk4oaW5kZXggPj0gdnEtPnNwbGl0LnZyaW5nLm51bSwKPiArCQkgICAgImRlc2Mg
aW5kZXggJXUgb3V0IG9mIGJvdW5kcyAoJXUpXG4iLAo+ICsJCSAgICBpbmRleCwgdnEtPnNwbGl0
LnZyaW5nLm51bSk7CgoKSXQncyBiZXR0ZXIgdG8gdXNlIEJBRF9SSU5HIHRvIHN0b3AgdmlydHF1
ZXVlIGluIHRoaXMgY2FzZS4KCgo+ICt9Cj4gKwo+ICAgc3RhdGljIGlubGluZSBpbnQgdmlydHF1
ZXVlX2FkZF9zcGxpdChzdHJ1Y3QgdmlydHF1ZXVlICpfdnEsCj4gICAJCQkJICAgICAgc3RydWN0
IHNjYXR0ZXJsaXN0ICpzZ3NbXSwKPiAgIAkJCQkgICAgICB1bnNpZ25lZCBpbnQgdG90YWxfc2cs
Cj4gQEAgLTQyOCw2ICs0MzcsNyBAQCBzdGF0aWMgaW5saW5lIGludCB2aXJ0cXVldWVfYWRkX3Nw
bGl0KHN0cnVjdCB2aXJ0cXVldWUgKl92cSwKPiAgIAl1bnNpZ25lZCBpbnQgaSwgbiwgYXZhaWws
IGRlc2NzX3VzZWQsIHByZXYsIGVycl9pZHg7Cj4gICAJaW50IGhlYWQ7Cj4gICAJYm9vbCBpbmRp
cmVjdDsKPiArCWludCBpb19lcnI7Cj4gICAKPiAgIAlTVEFSVF9VU0UodnEpOwo+ICAgCj4gQEAg
LTQ4MSw3ICs0OTEsMTMgQEAgc3RhdGljIGlubGluZSBpbnQgdmlydHF1ZXVlX2FkZF9zcGxpdChz
dHJ1Y3QgdmlydHF1ZXVlICpfdnEsCj4gICAKPiAgIAlmb3IgKG4gPSAwOyBuIDwgb3V0X3Nnczsg
bisrKSB7Cj4gICAJCWZvciAoc2cgPSBzZ3Nbbl07IHNnOyBzZyA9IHNnX25leHQoc2cpKSB7Cj4g
LQkJCWRtYV9hZGRyX3QgYWRkciA9IHZyaW5nX21hcF9vbmVfc2codnEsIHNnLCBETUFfVE9fREVW
SUNFKTsKPiArCQkJZG1hX2FkZHJfdCBhZGRyOwo+ICsKPiArCQkJaW9fZXJyID0gLUVJTzsKPiAr
CQkJaWYgKCFpbnNpZGVfc3BsaXRfcmluZyh2cSwgaSkpCj4gKwkJCQlnb3RvIHVubWFwX3JlbGVh
c2U7Cj4gKwkJCWlvX2VyciA9IC1FTk9NRU07Cj4gKwkJCWFkZHIgPSB2cmluZ19tYXBfb25lX3Nn
KHZxLCBzZywgRE1BX1RPX0RFVklDRSk7Cj4gICAJCQlpZiAodnJpbmdfbWFwcGluZ19lcnJvcih2
cSwgYWRkcikpCj4gICAJCQkJZ290byB1bm1hcF9yZWxlYXNlOwo+ICAgCj4gQEAgLTQ5NCw3ICs1
MTAsMTMgQEAgc3RhdGljIGlubGluZSBpbnQgdmlydHF1ZXVlX2FkZF9zcGxpdChzdHJ1Y3Qgdmly
dHF1ZXVlICpfdnEsCj4gICAJfQo+ICAgCWZvciAoOyBuIDwgKG91dF9zZ3MgKyBpbl9zZ3MpOyBu
KyspIHsKPiAgIAkJZm9yIChzZyA9IHNnc1tuXTsgc2c7IHNnID0gc2dfbmV4dChzZykpIHsKPiAt
CQkJZG1hX2FkZHJfdCBhZGRyID0gdnJpbmdfbWFwX29uZV9zZyh2cSwgc2csIERNQV9GUk9NX0RF
VklDRSk7Cj4gKwkJCWRtYV9hZGRyX3QgYWRkcjsKPiArCj4gKwkJCWlvX2VyciA9IC1FSU87Cj4g
KwkJCWlmICghaW5zaWRlX3NwbGl0X3JpbmcodnEsIGkpKQo+ICsJCQkJZ290byB1bm1hcF9yZWxl
YXNlOwo+ICsJCQlpb19lcnIgPSAtRU5PTUVNOwo+ICsJCQlhZGRyID0gdnJpbmdfbWFwX29uZV9z
Zyh2cSwgc2csIERNQV9GUk9NX0RFVklDRSk7Cj4gICAJCQlpZiAodnJpbmdfbWFwcGluZ19lcnJv
cih2cSwgYWRkcikpCj4gICAJCQkJZ290byB1bm1hcF9yZWxlYXNlOwoKCkl0IGxvb2tzIHRvIG1l
IGFsbCB0aGUgZXZpbHMgY2FtZSBmcm9tIHRoZSBmYWN0IHRoYXQgd2UgZGVwZW5kcyBvbiB0aGUg
CmRlc2NyaXB0b3IgcmluZy4KClNvIHRoZSBjaGVja3MgaW4gdGhpcyBwYXRjaCBjb3VsZCBpcyB1
bm5lY2Vzc2FyeSBpZiB3ZSBkb24ndCBldmVuIHJlYWQgCmZyb20gdGhlIGRlc2NyaXB0b3Igcmlu
ZyB3aGljaCBjb3VsZCBiZSBtYW5pcHVsYXRlZCBieSB0aGUgZGV2aWNlLgoKVGhpcyBpcyB3aGF0
IG15IHNlcmllcyB0cmllcyB0byBhY2hpZXZlOgoKaHR0cHM6Ly93d3cuc3Bpbmljcy5uZXQvbGlz
dHMva3ZtL21zZzI0MTgyNS5odG1sCgpUaGFua3MKCgoKPiAgIAo+IEBAIC01MTMsNiArNTM1LDcg
QEAgc3RhdGljIGlubGluZSBpbnQgdmlydHF1ZXVlX2FkZF9zcGxpdChzdHJ1Y3QgdmlydHF1ZXVl
ICpfdnEsCj4gICAJCWRtYV9hZGRyX3QgYWRkciA9IHZyaW5nX21hcF9zaW5nbGUoCj4gICAJCQl2
cSwgZGVzYywgdG90YWxfc2cgKiBzaXplb2Yoc3RydWN0IHZyaW5nX2Rlc2MpLAo+ICAgCQkJRE1B
X1RPX0RFVklDRSk7Cj4gKwkJaW9fZXJyID0gLUVOT01FTTsKPiAgIAkJaWYgKHZyaW5nX21hcHBp
bmdfZXJyb3IodnEsIGFkZHIpKQo+ICAgCQkJZ290byB1bm1hcF9yZWxlYXNlOwo+ICAgCj4gQEAg
LTUyOCw2ICs1NTEsMTAgQEAgc3RhdGljIGlubGluZSBpbnQgdmlydHF1ZXVlX2FkZF9zcGxpdChz
dHJ1Y3QgdmlydHF1ZXVlICpfdnEsCj4gICAJLyogV2UncmUgdXNpbmcgc29tZSBidWZmZXJzIGZy
b20gdGhlIGZyZWUgbGlzdC4gKi8KPiAgIAl2cS0+dnEubnVtX2ZyZWUgLT0gZGVzY3NfdXNlZDsK
PiAgIAo+ICsJaW9fZXJyID0gLUVJTzsKPiArCWlmICghaW5zaWRlX3NwbGl0X3JpbmcodnEsIGhl
YWQpKQo+ICsJCWdvdG8gdW5tYXBfcmVsZWFzZTsKPiArCj4gICAJLyogVXBkYXRlIGZyZWUgcG9p
bnRlciAqLwo+ICAgCWlmIChpbmRpcmVjdCkKPiAgIAkJdnEtPmZyZWVfaGVhZCA9IHZpcnRpbzE2
X3RvX2NwdShfdnEtPnZkZXYsCj4gQEAgLTU0NSw2ICs1NzIsMTAgQEAgc3RhdGljIGlubGluZSBp
bnQgdmlydHF1ZXVlX2FkZF9zcGxpdChzdHJ1Y3QgdmlydHF1ZXVlICpfdnEsCj4gICAJLyogUHV0
IGVudHJ5IGluIGF2YWlsYWJsZSBhcnJheSAoYnV0IGRvbid0IHVwZGF0ZSBhdmFpbC0+aWR4IHVu
dGlsIHRoZXkKPiAgIAkgKiBkbyBzeW5jKS4gKi8KPiAgIAlhdmFpbCA9IHZxLT5zcGxpdC5hdmFp
bF9pZHhfc2hhZG93ICYgKHZxLT5zcGxpdC52cmluZy5udW0gLSAxKTsKPiArCj4gKwlpZiAoYXZh
aWwgPj0gdnEtPnNwbGl0LnZyaW5nLm51bSkKPiArCQlnb3RvIHVubWFwX3JlbGVhc2U7Cj4gKwo+
ICAgCXZxLT5zcGxpdC52cmluZy5hdmFpbC0+cmluZ1thdmFpbF0gPSBjcHVfdG9fdmlydGlvMTYo
X3ZxLT52ZGV2LCBoZWFkKTsKPiAgIAo+ICAgCS8qIERlc2NyaXB0b3JzIGFuZCBhdmFpbGFibGUg
YXJyYXkgbmVlZCB0byBiZSBzZXQgYmVmb3JlIHdlIGV4cG9zZSB0aGUKPiBAQCAtNTc2LDYgKzYw
Nyw4IEBAIHN0YXRpYyBpbmxpbmUgaW50IHZpcnRxdWV1ZV9hZGRfc3BsaXQoc3RydWN0IHZpcnRx
dWV1ZSAqX3ZxLAo+ICAgCWZvciAobiA9IDA7IG4gPCB0b3RhbF9zZzsgbisrKSB7Cj4gICAJCWlm
IChpID09IGVycl9pZHgpCj4gICAJCQlicmVhazsKPiArCQlpZiAoIWluc2lkZV9zcGxpdF9yaW5n
KHZxLCBpKSkKPiArCQkJYnJlYWs7Cj4gICAJCXZyaW5nX3VubWFwX29uZV9zcGxpdCh2cSwgJmRl
c2NbaV0pOwo+ICAgCQlpID0gdmlydGlvMTZfdG9fY3B1KF92cS0+dmRldiwgZGVzY1tpXS5uZXh0
KTsKPiAgIAl9Cj4gQEAgLTU4NCw3ICs2MTcsNyBAQCBzdGF0aWMgaW5saW5lIGludCB2aXJ0cXVl
dWVfYWRkX3NwbGl0KHN0cnVjdCB2aXJ0cXVldWUgKl92cSwKPiAgIAkJa2ZyZWUoZGVzYyk7Cj4g
ICAKPiAgIAlFTkRfVVNFKHZxKTsKPiAtCXJldHVybiAtRU5PTUVNOwo+ICsJcmV0dXJuIGlvX2Vy
cjsKPiAgIH0KPiAgIAo+ICAgc3RhdGljIGJvb2wgdmlydHF1ZXVlX2tpY2tfcHJlcGFyZV9zcGxp
dChzdHJ1Y3QgdmlydHF1ZXVlICpfdnEpCj4gQEAgLTExNDYsNyArMTE3OSwxMiBAQCBzdGF0aWMg
aW5saW5lIGludCB2aXJ0cXVldWVfYWRkX3BhY2tlZChzdHJ1Y3QgdmlydHF1ZXVlICpfdnEsCj4g
ICAJYyA9IDA7Cj4gICAJZm9yIChuID0gMDsgbiA8IG91dF9zZ3MgKyBpbl9zZ3M7IG4rKykgewo+
ICAgCQlmb3IgKHNnID0gc2dzW25dOyBzZzsgc2cgPSBzZ19uZXh0KHNnKSkgewo+IC0JCQlkbWFf
YWRkcl90IGFkZHIgPSB2cmluZ19tYXBfb25lX3NnKHZxLCBzZywgbiA8IG91dF9zZ3MgPwo+ICsJ
CQlkbWFfYWRkcl90IGFkZHI7Cj4gKwo+ICsJCQlpZiAoY3VyciA+PSB2cS0+cGFja2VkLnZyaW5n
Lm51bSkKPiArCQkJCWdvdG8gdW5tYXBfcmVsZWFzZTsKPiArCj4gKwkJCWFkZHIgPSB2cmluZ19t
YXBfb25lX3NnKHZxLCBzZywgbiA8IG91dF9zZ3MgPwo+ICAgCQkJCQlETUFfVE9fREVWSUNFIDog
RE1BX0ZST01fREVWSUNFKTsKPiAgIAkJCWlmICh2cmluZ19tYXBwaW5nX2Vycm9yKHZxLCBhZGRy
KSkKPiAgIAkJCQlnb3RvIHVubWFwX3JlbGVhc2U7CgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGlu
dXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxt
YW4vbGlzdGluZm8vaW9tbXU=
