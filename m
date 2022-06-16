Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BBF0C433EF
	for <iommu@archiver.kernel.org>; Thu, 16 Jun 2022 04:10:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B615683FE5;
	Thu, 16 Jun 2022 04:10:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IU694kP1WZox; Thu, 16 Jun 2022 04:10:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 1F9B683F7E;
	Thu, 16 Jun 2022 04:10:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E98A7C0032;
	Thu, 16 Jun 2022 04:10:26 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AAFCDC002D
 for <iommu@lists.linux-foundation.org>; Thu, 16 Jun 2022 04:10:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8579140ADD
 for <iommu@lists.linux-foundation.org>; Thu, 16 Jun 2022 04:10:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EelWa4DMCw5T for <iommu@lists.linux-foundation.org>;
 Thu, 16 Jun 2022 04:10:24 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com
 [IPv6:2607:f8b0:4864:20::52e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C3147403A7
 for <iommu@lists.linux-foundation.org>; Thu, 16 Jun 2022 04:10:24 +0000 (UTC)
Received: by mail-pg1-x52e.google.com with SMTP id g186so176755pgc.1
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jun 2022 21:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=WzJNadh1hSnmmL0dW8LI/MHOGJubcN11puGnqaQm174=;
 b=YgP+guyirvc2wR0eokmvk7hxnf7zaDI1NQnUMfVym3nkeqVioUdT0MkHkHtCM5Nmmv
 K7rzxJjZNn5BcBT5Tw7y29hcawM66158z5lOYoXPgw0SD8qDEIHodoP6/0lgOwQ97/bk
 BjZbwFE29Ljfquda8NqLiQrKRG5h6Lxre5G6MEgEleq2gE7gojxULZ4vbbgTmcaFE1AK
 gHgskvBnpglx5aL22vxohlAsbkYwBJc70n3ch08ugpKpNO0ka/56L6fndfl9z//45aS8
 NAdI9LQDmWXh61yKB4P3eCj4x0gqnIQ5JVG3gk+2zN2Vao457kr90g0Bp4C54dLTpTCG
 Etbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=WzJNadh1hSnmmL0dW8LI/MHOGJubcN11puGnqaQm174=;
 b=tlzNulKN8M6MuupjhR8muBi+rN6en2ECB2WDW/F+WwVUYUS43nWmQt6XRG52BDgmIY
 Wjm/bwESt8rJB4QqX8sNUoC7HPVKV9YQOJATQzGaV5PGLHrtM17W7HwBOHpnmx47JWBH
 KYlgTYuyg+cF3xbPsM/utNMR6otfH+V8yTww28z6gcRcZln14JwonYWL6rEB9HTGAHXc
 /MJEbToSJEcwD/uS/4AkM6WA6i8D4GmXhxR7r5UjI544Qk/ORBiqLZroA1H3/IgFxHE+
 FBUNFIg4fqSxAMZQC77mT5XBUOCJt1dyq91+qix/nQSn25IG90wMzS4NDjREHSQe3aY4
 bnpA==
X-Gm-Message-State: AJIora8Z8Mnb2jGigvNQ/QHAbDnUO0MDM8qNTyVhxn1RDbkEDFqPrrBv
 YEkNBClcy3xWkltmiAVxcYt1Mg==
X-Google-Smtp-Source: AGRyM1uef04u0KeO4Z0AwsOzUgxYO8oZy0vFCco9id7APLvqMzKEpKvUQfrb3Y3XHRK4iAcfsoThZw==
X-Received: by 2002:aa7:9e9c:0:b0:51b:e1b8:271c with SMTP id
 p28-20020aa79e9c000000b0051be1b8271cmr2885255pfq.73.1655352623853; 
 Wed, 15 Jun 2022 21:10:23 -0700 (PDT)
Received: from [10.31.0.6] ([199.101.192.15]) by smtp.gmail.com with ESMTPSA id
 n2-20020a63b442000000b003c265b7d4f6sm449755pgu.44.2022.06.15.21.10.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Jun 2022 21:10:23 -0700 (PDT)
Subject: Re: [PATCH] uacce: fix concurrency of fops_open and uacce_remove
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
References: <20220610123423.27496-1-zhangfei.gao@linaro.org>
 <Yqn3spLZHpAkQ9Us@myrica>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Message-ID: <fdc8d8b0-4e04-78f5-1e8a-4cf44c89a37f@linaro.org>
Date: Thu, 16 Jun 2022 12:10:18 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <Yqn3spLZHpAkQ9Us@myrica>
Content-Language: en-US
Cc: Yang Shen <shenyang39@huawei.com>, Herbert Xu <herbert@gondor.apana.org.au>,
 Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 linux-crypto@vger.kernel.org, linux-accelerators@lists.ozlabs.org
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

SGksIEplYW4KCk9uIDIwMjIvNi8xNSDkuIvljYgxMToxNiwgSmVhbi1QaGlsaXBwZSBCcnVja2Vy
IHdyb3RlOgo+IEhpLAo+Cj4gT24gRnJpLCBKdW4gMTAsIDIwMjIgYXQgMDg6MzQ6MjNQTSArMDgw
MCwgWmhhbmdmZWkgR2FvIHdyb3RlOgo+PiBUaGUgdWFjY2UgcGFyZW50J3MgbW9kdWxlIGNhbiBi
ZSByZW1vdmVkIHdoZW4gdWFjY2UgaXMgd29ya2luZywKPj4gd2hpY2ggbWF5IGNhdXNlIHRyb3Vi
bGVzLgo+Pgo+PiBJZiBybW1vZC91YWNjZV9yZW1vdmUgaGFwcGVucyBqdXN0IGFmdGVyIGZvcHNf
b3BlbjogYmluZF9xdWV1ZSwKPj4gdGhlIHVhY2NlX3JlbW92ZSBjYW4gbm90IHJlbW92ZSB0aGUg
Ym91bmQgcXVldWUgc2luY2UgaXQgaXMgbm90Cj4+IGFkZGVkIHRvIHRoZSBxdWV1ZSBsaXN0IHll
dCwgd2hpY2ggYmxvY2tzIHRoZSB1YWNjZV9kaXNhYmxlX3N2YS4KPj4KPj4gQ2hhbmdlIHF1ZXVl
c19sb2NrIGFyZWEgdG8gbWFrZSBzdXJlIHRoZSBib3VuZCBxdWV1ZSBpcyBhZGRlZCB0bwo+PiB0
aGUgbGlzdCB0aGVyZWJ5IGNhbiBiZSBzZWFyY2hlZCBpbiB1YWNjZV9yZW1vdmUuCj4+Cj4+IEFu
ZCB1YWNjZS0+cGFyZW50LT5kcml2ZXIgaXMgY2hlY2tlZCBpbW1lZGlhdGVseSBpbiBjYXNlIHJt
bW9kIGlzCj4+IGp1c3QgaGFwcGVuaW5nLgo+Pgo+PiBBbHNvIHRoZSBwYXJlbnQgZHJpdmVyIG11
c3QgYWx3YXlzIHN0b3AgRE1BIGJlZm9yZSBjYWxsaW5nCj4+IHVhY2NlX3JlbW92ZS4KPj4KPj4g
U2lnbmVkLW9mZi1ieTogWWFuZyBTaGVuIDxzaGVueWFuZzM5QGh1YXdlaS5jb20+Cj4+IFNpZ25l
ZC1vZmYtYnk6IFpoYW5nZmVpIEdhbyA8emhhbmdmZWkuZ2FvQGxpbmFyby5vcmc+Cj4+IC0tLQo+
PiAgIGRyaXZlcnMvbWlzYy91YWNjZS91YWNjZS5jIHwgMTkgKysrKysrKysrKysrKy0tLS0tLQo+
PiAgIDEgZmlsZSBjaGFuZ2VkLCAxMyBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQo+Pgo+
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9taXNjL3VhY2NlL3VhY2NlLmMgYi9kcml2ZXJzL21pc2Mv
dWFjY2UvdWFjY2UuYwo+PiBpbmRleCAyODFjNTQwMDNlZGMuLmI2MjE5YzZiZmI0OCAxMDA2NDQK
Pj4gLS0tIGEvZHJpdmVycy9taXNjL3VhY2NlL3VhY2NlLmMKPj4gKysrIGIvZHJpdmVycy9taXNj
L3VhY2NlL3VhY2NlLmMKPj4gQEAgLTEzNiw5ICsxMzYsMTYgQEAgc3RhdGljIGludCB1YWNjZV9m
b3BzX29wZW4oc3RydWN0IGlub2RlICppbm9kZSwgc3RydWN0IGZpbGUgKmZpbGVwKQo+PiAgIAlp
ZiAoIXEpCj4+ICAgCQlyZXR1cm4gLUVOT01FTTsKPj4gICAKPj4gKwltdXRleF9sb2NrKCZ1YWNj
ZS0+cXVldWVzX2xvY2spOwo+PiArCj4+ICsJaWYgKCF1YWNjZS0+cGFyZW50LT5kcml2ZXIpIHsK
PiBJIGRvbid0IHRoaW5rIHRoaXMgaXMgdXNlZnVsLCBiZWNhdXNlIHRoZSBjb3JlIGNsZWFycyBw
YXJlbnQtPmRyaXZlciBhZnRlcgo+IGhhdmluZyBydW4gdWFjY2VfcmVtb3ZlKCk6Cj4KPiAgICBy
bW1vZCBoaXNpX3ppcAkJb3BlbigpCj4gICAgIC4uLgkJCQkgdWFjY2VfZm9wc19vcGVuKCkKPiAg
ICAgX19kZXZpY2VfcmVsZWFzZV9kcml2ZXIoKQkgIC4uLgo+ICAgICAgcGNpX2RldmljZV9yZW1v
dmUoKQo+ICAgICAgIGhpc2lfemlwX3JlbW92ZSgpCj4gICAgICAgIGhpc2lfcW1fdW5pbml0KCkK
PiAgICAgICAgIHVhY2NlX3JlbW92ZSgpCj4gICAgICAgICAgLi4uCQkJICAuLi4KPiAgICAgCQkJ
CSAgbXV0ZXhfbG9jayh1YWNjZS0+cXVldWVzX2xvY2spCj4gICAgICAuLi4JCQkJICBpZiAoIXVh
Y2NlLT5wYXJlbnQtPmRyaXZlcikKPiAgICAgIGRldmljZV91bmJpbmRfY2xlYW51cCgpCSAgLyog
ZHJpdmVyIHN0aWxsIHZhbGlkLCBwcm9jZWVkICovCj4gICAgICAgZGV2LT5kcml2ZXIgPSBOVUxM
CgpUaGUgY2hlY2vCoCBpZiAoIXVhY2NlLT5wYXJlbnQtPmRyaXZlcikgaXMgcmVxdWlyZWQsIG90
aGVyd2lzZSBOVUxMIApwb2ludGVyIG1heSBoYXBwZW4uCmlvbW11X3N2YV9iaW5kX2RldmljZQpj
b25zdCBzdHJ1Y3QgaW9tbXVfb3BzICpvcHMgPSBkZXZfaW9tbXVfb3BzKGRldik7wqAgLT4gCmRl
di0+aW9tbXUtPmlvbW11X2Rldi0+b3BzCgpybW1vZCBoYXMgbm8gaXNzdWUsIGJ1dCByZW1vdmUg
cGFyZW50IHBjaSBkZXZpY2UgaGFzIHRoZSBpc3N1ZS4KClRlc3Q6CnNsZWVwIGluIGZvcHNfb3Bl
biBiZWZvcmUgbXV0ZXguCgplc3R1YXJ5Oi9tbnQkIC4vd29yay9hLm91dCAmCi8vc2xlZXAgaW4g
Zm9wc19vcGVuCgplY2hvIDEgPiAvc3lzL2J1cy9wY2kvZGV2aWNlcy8wMDAwOjAwOjAyLjAvcmVt
b3ZlICYKZXN0dWFyeTovbW50JCBbwqDCoCAyMi41OTQzNDhdIHVhY2NlX3JlbW92ZSEKW8KgwqAg
MjIuNTk0NjYzXSBwY2kgMDAwMDowMDowMi4wOiBSZW1vdmluZyBmcm9tIGlvbW11IGdyb3VwIDIK
W8KgwqAgMjIuNTk1MDczXSBpb21tdV9yZWxlYXNlX2RldmljZSBkZXYtPmlvbW11PTAKW8KgwqAg
MjIuNTk1MDc2XSBDUFU6IDIgUElEOiAyMjkgQ29tbTogYXNoIE5vdCB0YWludGVkIAo1LjE5LjAt
cmMxLTE1MDcxLWdjYmNmMDk4YzUyNTctZGlydHkgIzYzMwpbwqDCoCAyMi41OTUwNzldIEhhcmR3
YXJlIG5hbWU6IFFFTVUgS1ZNIFZpcnR1YWwgTWFjaGluZSwgQklPUyAwLjAuMCAKMDIvMDYvMjAx
NQpbwqDCoCAyMi41OTUwODBdIENhbGwgdHJhY2U6ClvCoMKgIDIyLjU5NTA4MF3CoCBkdW1wX2Jh
Y2t0cmFjZSsweGU0LzB4ZjAKW8KgwqAgMjIuNTk1MDg1XcKgIHNob3dfc3RhY2srMHgyMC8weDcw
ClvCoMKgIDIyLjU5NTA4Nl3CoCBkdW1wX3N0YWNrX2x2bCsweDhjLzB4YjgKW8KgwqAgMjIuNTk1
MDg5XcKgIGR1bXBfc3RhY2srMHgxOC8weDM0ClvCoMKgIDIyLjU5NTA5MV3CoCBpb21tdV9yZWxl
YXNlX2RldmljZSsweDkwLzB4OTgKW8KgwqAgMjIuNTk1MDk1XcKgIGlvbW11X2J1c19ub3RpZmll
cisweDU4LzB4NjgKW8KgwqAgMjIuNTk1MDk3XcKgIGJsb2NraW5nX25vdGlmaWVyX2NhbGxfY2hh
aW4rMHg3NC8weGE4ClvCoMKgIDIyLjU5NTEwMF3CoCBkZXZpY2VfZGVsKzB4MjY4LzB4M2IwClvC
oMKgIDIyLjU5NTEwMl3CoCBwY2lfcmVtb3ZlX2J1c19kZXZpY2UrMHg4NC8weDExMApbwqDCoCAy
Mi41OTUxMDZdwqAgcGNpX3N0b3BfYW5kX3JlbW92ZV9idXNfZGV2aWNlX2xvY2tlZCsweDMwLzB4
NjAKLi4uCgplc3R1YXJ5Oi9tbnQkIFvCoMKgIDMxLjQ2NjM2MF0gdWFjY2U6IHNsZWVwIGVuZCEK
W8KgwqAgMzEuNDY2MzYyXSB1YWNjZS0+cGFyZW50LT5kcml2ZXI9MApbwqDCoCAzMS40NjYzNjRd
IHVhY2NlLT5wYXJlbnQtPmlvbW11PTAKW8KgwqAgMzEuNDY2MzY1XSB1YWNjZV9iaW5kX3F1ZXVl
IQpbwqDCoCAzMS40NjYzNjZdIHVhY2NlX2JpbmRfcXVldWUgY2FsbCBpb21tdV9zdmFfYmluZF9k
ZXZpY2UhClvCoMKgIDMxLjQ2NjM2N10gdWFjY2UtPnBhcmVudD1kMTIwZDAKW8KgwqAgMzEuNDY2
MzcxXSBVbmFibGUgdG8gaGFuZGxlIGtlcm5lbCBOVUxMIHBvaW50ZXIgZGVyZWZlcmVuY2UgYXQg
CnZpcnR1YWwgYWRkcmVzcyAwMDAwMDAwMDAwMDAwMDM4ClvCoMKgIDMxLjQ3Mjg3MF0gTWVtIGFi
b3J0IGluZm86ClvCoMKgIDMxLjQ3MzQ1MF3CoMKgIEVTUiA9IDB4MDAwMDAwMDA5NjAwMDAwNApb
wqDCoCAzMS40NzQyMjNdwqDCoCBFQyA9IDB4MjU6IERBQlQgKGN1cnJlbnQgRUwpLCBJTCA9IDMy
IGJpdHMKW8KgwqAgMzEuNDc1MzkwXcKgwqAgU0VUID0gMCwgRm5WID0gMApbwqDCoCAzMS40NzYw
MzFdwqDCoCBFQSA9IDAsIFMxUFRXID0gMApbwqDCoCAzMS40NzY2ODBdwqDCoCBGU0MgPSAweDA0
OiBsZXZlbCAwIHRyYW5zbGF0aW9uIGZhdWx0ClvCoMKgIDMxLjQ3NzY4N10gRGF0YSBhYm9ydCBp
bmZvOgpbwqDCoCAzMS40NzgyOTRdwqDCoCBJU1YgPSAwLCBJU1MgPSAweDAwMDAwMDA0ClvCoMKg
IDMxLjQ3OTE1Ml3CoMKgIENNID0gMCwgV25SID0gMApbwqDCoCAzMS40Nzk3ODVdIHVzZXIgcGd0
YWJsZTogNGsgcGFnZXMsIDQ4LWJpdCBWQXMsIHBnZHA9MDAwMDAwMDA3MTRkODAwMApbwqDCoCAz
MS40ODExNDRdIFswMDAwMDAwMDAwMDAwMDM4XSBwZ2Q9MDAwMDAwMDAwMDAwMDAwMCwgcDRkPTAw
MDAwMDAwMDAwMDAwMDAKW8KgwqAgMzEuNDgyNjIyXSBJbnRlcm5hbCBlcnJvcjogT29wczogOTYw
MDAwMDQgWyMxXSBQUkVFTVBUIFNNUApbwqDCoCAzMS40ODM3ODRdIE1vZHVsZXMgbGlua2VkIGlu
OiBoaXNpX3ppcApbwqDCoCAzMS40ODQ1OTBdIENQVTogMiBQSUQ6IDIyOCBDb21tOiBhLm91dCBO
b3QgdGFpbnRlZCAKNS4xOS4wLXJjMS0xNTA3MS1nY2JjZjA5OGM1MjU3LWRpcnR5ICM2MzMKW8Kg
wqAgMzEuNDg2Mzc0XSBIYXJkd2FyZSBuYW1lOiBRRU1VIEtWTSBWaXJ0dWFsIE1hY2hpbmUsIEJJ
T1MgMC4wLjAgCjAyLzA2LzIwMTUKW8KgwqAgMzEuNDg3ODYyXSBwc3RhdGU6IDYwNDAwMDA1IChu
WkN2IGRhaWYgK1BBTiAtVUFPIC1UQ08gLURJVCAtU1NCUyAKQlRZUEU9LS0pClvCoMKgIDMxLjQ4
OTM5MF0gcGMgOiBpb21tdV9zdmFfYmluZF9kZXZpY2UrMHg0NC8weGY0ClvCoMKgIDMxLjQ5MDQw
NF0gbHIgOiB1YWNjZV9mb3BzX29wZW4rMHgxMjgvMHgyMzQKCj4KPiBTaW5jZSB1YWNjZV9yZW1v
dmUoKSBkaXNhYmxlZCBTVkEsIHRoZSBmb2xsb3dpbmcgdWFjY2VfYmluZF9xdWV1ZSgpIHdpbGwK
PiBmYWlsIGFueXdheS4gSG93ZXZlciwgaWYgdWFjY2UtPmZsYWdzIGRvZXMgbm90IGhhdmUgVUFD
Q0VfREVWX1NWQSBzZXQsCj4gd2UnbGwgcHJvY2VlZCBmdXJ0aGVyIGFuZCBjYWxsIHVhY2NlLT5v
cHMtPmdldF9xdWV1ZSgpLCB3aGljaCBkb2VzIG5vdAo+IGV4aXN0IGFueW1vcmUgc2luY2UgdGhl
IHBhcmVudCBtb2R1bGUgaXMgZ29uZS4KPgo+IEkgdGhpbmsgd2UgbmVlZCB0aGUgZ2xvYmFsIHVh
Y2NlX211dGV4IHRvIHNlcmlhbGl6ZSB1YWNjZV9yZW1vdmUoKSBhbmQKPiB1YWNjZV9mb3BzX29w
ZW4oKS4gdWFjY2VfcmVtb3ZlKCkgd291bGQgZG8gZXZlcnl0aGluZywgaW5jbHVkaW5nCj4geGFf
ZXJhc2UoKSwgd2hpbGUgaG9sZGluZyB0aGF0IG11dGV4LiBBbmQgdWFjY2VfZm9wc19vcGVuKCkg
d291bGQgdHJ5IHRvCj4gb2J0YWluIHRoZSB1YWNjZSBvYmplY3QgZnJvbSB0aGUgeGFycmF5IHdo
aWxlIGhvbGRpbmcgdGhlIG11dGV4LCB3aGljaAo+IGZhaWxzIGlmIHRoZSB1YWNjZSBvYmplY3Qg
aXMgYmVpbmcgcmVtb3ZlZC4KClNpbmNlIGZvcHNfb3BlbiBnZXQgY2hhciBkZXZpY2UgcmVmY291
bnQsIHVhY2NlX3JlbGVhc2Ugd2lsbCBub3QgaGFwcGVuIAp1bnRpbCBvcGVuIHJldHVybnMuClNv
IGVpdGhlciB1YWNjZSA9IHhhX2xvYWQoJnVhY2NlX3hhLCBpbWlub3IoaW5vZGUpKSBpcyBnb3Qs
IAp1YWNjZV9yZWxlYXNlIHJlbGVhc2UgdWFjY2UgYWZ0ZXIgZm9wc19yZWxlYXNlLgpPciB1YWNj
ZSBpcyBub3QgZ290IGFuZCByZXR1cm4gLUVOT0RFVu+8jgoKb3BlbjoKIMKgwqDCoMKgwqDCoMKg
IHVhY2NlID0geGFfbG9hZCgmdWFjY2VfeGEsIGltaW5vcihpbm9kZSkpOwogwqDCoMKgwqDCoMKg
wqAgaWYgKCF1YWNjZSkKIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gLUVO
T0RFVjsKCnVhY2NlLT5kZXYucmVsZWFzZSA9IHVhY2NlX3JlbGVhc2U7CnVhY2NlX3JlbGVhc2U6
IGtmcmVlKHVhY2NlKTsKClRoYW5rcwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRh
dGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGlu
Zm8vaW9tbXU=
