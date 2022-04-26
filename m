Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B76C5C433F5
	for <iommu@archiver.kernel.org>; Tue, 26 Apr 2022 05:19:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 57705813AC;
	Tue, 26 Apr 2022 05:19:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id e6h9KPeSBNHz; Tue, 26 Apr 2022 05:19:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 2000A81328;
	Tue, 26 Apr 2022 05:19:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E5FA3C0032;
	Tue, 26 Apr 2022 05:19:27 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A25BFC002D
 for <iommu@lists.linux-foundation.org>; Tue, 26 Apr 2022 05:19:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 81D8C8134E
 for <iommu@lists.linux-foundation.org>; Tue, 26 Apr 2022 05:19:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sKynllQ66LCv for <iommu@lists.linux-foundation.org>;
 Tue, 26 Apr 2022 05:19:23 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com
 [IPv6:2607:f8b0:4864:20::1035])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B684081328
 for <iommu@lists.linux-foundation.org>; Tue, 26 Apr 2022 05:19:23 +0000 (UTC)
Received: by mail-pj1-x1035.google.com with SMTP id
 n33-20020a17090a5aa400b001d28f5ee3f9so1501664pji.4
 for <iommu@lists.linux-foundation.org>; Mon, 25 Apr 2022 22:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=ECxlRdPBkrkKMb5BBakDNfPI3kNTo9GDiWWWzCDwUgs=;
 b=XvVcXIeuHS3H4nVboFfXVUOb4S1b5fWr5kvOUCcwc9H9BkEERtMw9ICUnzj7H4a7Qo
 mJu/rn3UYjQJVVget/AYA2ujXxSCxyXZW29HLToMLQFzm0/au0kwbAmZg2pgcBjvfTpp
 9yNGnWzLKII2jaL0A9lo6eJuu87Il2qs9NKQlUNJYkVGXOK099nZmj1GpmFaB8MeLXHM
 7iiyhkYpJirWkAM6r/RblIwjClb3a3MxfjLfJgWexd0t7NYDY6EO1p2dRThrYavYvKcr
 7vSVrxVC79iGpOrEdBGpOgfKG9aTFynX7W6SqdDB7wIoZbOJIN0le2hE5vXWD9YvEB2n
 ODOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=ECxlRdPBkrkKMb5BBakDNfPI3kNTo9GDiWWWzCDwUgs=;
 b=HEWYt8qhVmbn7bEwuOPPm1SnEhoxNV0jHVbUmDo0nLnC9Ahlkjn3/vxDIAQRfsPAYE
 SO6YZXlCWs250ZhzuybPKV/tjOAKmjivkvfppdD6EjEvebOkR3yjofbJ1CimNpuvlUa2
 AGbY5cMh5/ZVHq2WUj/+73a8iXcXaFlWeha0tyck3x326/rs2lCqNWqSQTErTmCyq9yf
 aicnjqCIWUVZWrGogYT2fXUG03aTBk31qP0crBo2LiNKMZXQgU8Jz7mY9/D9Ou+frfyz
 f1AlsHv1Kw/lSrVO9MtAaWmtX0NI6f1ow4Ds8c1mFJfAneHp4TcG8BOTocUQqmYmPSag
 jZyQ==
X-Gm-Message-State: AOAM5325D7WSVvlrF8D2xBeTdKnGkr5OLTNW/hAb4iycOvUnK+20nj02
 Wdea8jrdc/gyw5auryjVbjvKWA==
X-Google-Smtp-Source: ABdhPJyhEAYlOo+kBdVUQuo6fad1zeTwCcRGFOZ8UwxJdulGi+QpoSwVb3c41jqVnG0Wwzf9rlEpZg==
X-Received: by 2002:a17:903:14a:b0:15c:f657:62d0 with SMTP id
 r10-20020a170903014a00b0015cf65762d0mr13053218plc.81.1650950363137; 
 Mon, 25 Apr 2022 22:19:23 -0700 (PDT)
Received: from [10.69.0.6] ([94.177.118.37]) by smtp.gmail.com with ESMTPSA id
 nm6-20020a17090b19c600b001cd4989fedbsm1113346pjb.39.2022.04.25.22.19.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 Apr 2022 22:19:22 -0700 (PDT)
Subject: Re: [PATCH v4 05/11] iommu/sva: Assign a PASID to mm on PASID
 allocation and free it on mm exit
To: Fenghua Yu <fenghua.yu@intel.com>
References: <YmJ/WA6KAQU/xJjA@myrica>
 <tencent_A4E83BA6071B2204B6F5D4E69A50D21C1A09@qq.com>
 <YmLOznyBF0f7COYT@myrica>
 <tencent_2922DAB6F3D5789A1CD3A21A843B4007ED09@qq.com>
 <Yman5hLomw9/c+bi@myrica> <76ec6342-0d7c-7c7b-c132-2892e4048fa1@intel.com>
 <YmavoKkVu+hd+x0M@myrica> <20220425083444.00af5674@jacob-builder>
 <YmbIjnHtibY7n4Wb@myrica> <cf27bf82-ca68-86f1-ac8f-a138713edd5f@linaro.org>
 <Ymd2w30dkiKX1VfL@fyu1.sc.intel.com>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Message-ID: <b420d92e-e6ea-9506-764d-e430be5c8bb0@linaro.org>
Date: Tue, 26 Apr 2022 13:19:06 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <Ymd2w30dkiKX1VfL@fyu1.sc.intel.com>
Content-Language: en-US
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Ashok Raj <ashok.raj@intel.com>, Ravi V Shankar <ravi.v.shankar@intel.com>,
 Peter Zijlstra <peterz@infradead.org>, will@kernel.org,
 Dave Hansen <dave.hansen@linux.intel.com>, x86 <x86@kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Dave Hansen <dave.hansen@intel.com>, iommu <iommu@lists.linux-foundation.org>,
 Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
 Andy Lutomirski <luto@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
 Thomas Gleixner <tglx@linutronix.de>, robin.murphy@arm.com,
 Ingo Molnar <mingo@redhat.com>
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

CgpPbiAyMDIyLzQvMjYg5LiL5Y2IMTI6MzYsIEZlbmdodWEgWXUgd3JvdGU6Cj4gT24gVHVlLCBB
cHIgMjYsIDIwMjIgYXQgMTI6Mjg6MDBQTSArMDgwMCwgWmhhbmdmZWkgR2FvIHdyb3RlOgo+PiBI
aSwgSmVhbgo+Pgo+PiBPbiAyMDIyLzQvMjYg5LiK5Y2IMTI6MTMsIEplYW4tUGhpbGlwcGUgQnJ1
Y2tlciB3cm90ZToKPj4+IEhpIEphY29iLAo+Pj4KPj4+IE9uIE1vbiwgQXByIDI1LCAyMDIyIGF0
IDA4OjM0OjQ0QU0gLTA3MDAsIEphY29iIFBhbiB3cm90ZToKPj4+PiBIaSBKZWFuLVBoaWxpcHBl
LAo+Pj4+Cj4+Pj4gT24gTW9uLCAyNSBBcHIgMjAyMiAxNToyNjo0MCArMDEwMCwgSmVhbi1QaGls
aXBwZSBCcnVja2VyCj4+Pj4gPGplYW4tcGhpbGlwcGVAbGluYXJvLm9yZz4gd3JvdGU6Cj4+Pj4K
Pj4+Pj4gT24gTW9uLCBBcHIgMjUsIDIwMjIgYXQgMDc6MTg6MzZBTSAtMDcwMCwgRGF2ZSBIYW5z
ZW4gd3JvdGU6Cj4+Pj4+PiBPbiA0LzI1LzIyIDA2OjUzLCBKZWFuLVBoaWxpcHBlIEJydWNrZXIg
d3JvdGU6Cj4+Pj4+Pj4gT24gU2F0LCBBcHIgMjMsIDIwMjIgYXQgMDc6MTM6MzlQTSArMDgwMCwg
emhhbmdmZWkuZ2FvQGZveG1haWwuY29tCj4+Pj4+Pj4gd3JvdGU6Cj4+Pj4+Pj4+Pj4gT24gNS4x
Nwo+Pj4+Pj4+Pj4+IGZvcHNfcmVsZWFzZSBpcyBjYWxsZWQgYXV0b21hdGljYWxseSwgYXMgd2Vs
bCBhcwo+Pj4+Pj4+Pj4+IGlvbW11X3N2YV91bmJpbmRfZGV2aWNlLiBPbiA1LjE4LXJjMS4KPj4+
Pj4+Pj4+PiBmb3BzX3JlbGVhc2UgaXMgbm90IGNhbGxlZCwgaGF2ZSB0byBtYW51YWxseSBjYWxs
IGNsb3NlKGZkKQo+Pj4+Pj4+Pj4gUmlnaHQgdGhhdCdzIHdlaXJkCj4+Pj4+Pj4+IExvb2tzIGl0
IGlzIGNhdXNlZCBieSB0aGUgZml4IHBhdGNoLCB2aWEgbW1nZXQsIHdoaWNoIG1heSBhZGQKPj4+
Pj4+Pj4gcmVmY291bnQgb2YgZmQuCj4+Pj4+Pj4gWWVzIGluZGlyZWN0bHkgSSB0aGluazogd2hl
biB0aGUgcHJvY2VzcyBtbWFwcyB0aGUgcXVldWUsCj4+Pj4+Pj4gbW1hcF9yZWdpb24oKSB0YWtl
cyBhIHJlZmVyZW5jZSB0byB0aGUgdWFjY2UgZmQuIFRoYXQgcmVmZXJlbmNlIGlzCj4+Pj4+Pj4g
cmVsZWFzZWQgZWl0aGVyIGJ5IGV4cGxpY2l0IGNsb3NlKCkgb3IgbXVubWFwKCksIG9yIGJ5IGV4
aXRfbW1hcCgpCj4+Pj4+Pj4gKHdoaWNoIGlzIHRyaWdnZXJlZCBieSBtbXB1dCgpKS4gU2luY2Ug
dGhlcmUgaXMgYW4gbW0tPmZkIGRlcGVuZGVuY3ksCj4+Pj4+Pj4gd2UgY2Fubm90IGFkZCBhIGZk
LT5tbSBkZXBlbmRlbmN5LCBzbyBubyBtbWdldCgpL21tcHV0KCkgaW4KPj4+Pj4+PiBiaW5kKCkv
dW5iaW5kKCkuCj4+Pj4+Pj4KPj4+Pj4+PiBJIGd1ZXNzIHdlIHNob3VsZCBnbyBiYWNrIHRvIHJl
ZmNvdW50ZWQgUEFTSURzIGluc3RlYWQsIHRvIGF2b2lkCj4+Pj4+Pj4gZnJlZWluZyB0aGVtIHVu
dGlsIHVuYmluZCgpLgo+Pj4+Pj4gWWVhaCwgdGhpcyBpcyBhIGJpdCBnbmFybHkgZm9yIC1yYzQu
ICBMZXQncyBqdXN0IG1ha2Ugc3VyZSB0aGVyZSdzCj4+Pj4+PiBub3RoaW5nIGVsc2Ugc2ltcGxl
IHdlIGNhbiBkby4KPj4+Pj4+Cj4+Pj4+PiBIb3cgZG9lcyB0aGUgSU9NTVUgaGFyZHdhcmUga25v
dyB0aGF0IGFsbCBhY3Rpdml0eSB0byBhIGdpdmVuIFBBU0lEIGlzCj4+Pj4+PiBmaW5pc2hlZD8g
IFRoYXQgYWN0aXZpdHkgc2hvdWxkLCB0b2RheSwgYmUgaW5kZXBlbmRlbnQgb2YgYW4gbW0gb3Ig
YQo+Pj4+Pj4gZmQncyBsaWZldGltZS4KPj4+Pj4gSW4gdGhlIGNhc2Ugb2YgdWFjY2UsIGl0J3Mg
dGllZCB0byB0aGUgZmQgbGlmZXRpbWU6IG9wZW5pbmcgYW4gYWNjZWxlcmF0b3IKPj4+Pj4gcXVl
dWUgY2FsbHMgaW9tbXVfc3ZhX2JpbmRfZGV2aWNlKCksIHdoaWNoIHNldHMgdXAgdGhlIFBBU0lE
IGNvbnRleHQgaW4KPj4+Pj4gdGhlIElPTU1VLiBDbG9zaW5nIHRoZSBxdWV1ZSBjYWxscyBpb21t
dV9zdmFfdW5iaW5kX2RldmljZSgpIHdoaWNoCj4+Pj4+IGRlc3Ryb3lzIHRoZSBQQVNJRCBjb250
ZXh0IChhZnRlciB0aGUgZGV2aWNlIGRyaXZlciBzdG9wcGVkIGFsbCBETUEgZm9yCj4+Pj4+IHRo
aXMgUEFTSUQpLgo+Pj4+Pgo+Pj4+IEZvciBWVC1kLCBpdCBpcyBlc3NlbnRpYWxseSB0aGUgc2Ft
ZSBmbG93IGV4Y2VwdCBtYW5hZ2VkIGJ5IHRoZSBpbmRpdmlkdWFsCj4+Pj4gZHJpdmVycyBzdWNo
IGFzIERTQS4KPj4+PiBJZiBmcmVlKCkgaGFwcGVucyBiZWZvcmUgdW5iaW5kKCksIHdlIGRlYWN0
aXZhdGUgdGhlIFBBU0lEcyBhbmQgc3VwcHJlc3MKPj4+PiBmYXVsdHMgZnJvbSB0aGUgZGV2aWNl
LiBXaGVuIHRoZSB1bmJpbmQgZmluYWxseSBjb21lcywgd2UgZmluYWxpemUgdGhlCj4+Pj4gUEFT
SUQgdGVhcmRvd24uIEl0IHNlZW1zIHdlIGhhdmUgYSBuZWVkIGZvciBhbiBpbnRlcm1lZGlhdGUg
c3RhdGUgd2hlcmUKPj4+PiBQQVNJRCBpcyAicGVuZGluZyBmcmVlIj8KPj4+IFllcyB3ZSBkbyBo
YXZlIHRoYXQgc3RhdGUsIHRob3VnaCBJJ20gbm90IHN1cmUgd2UgbmVlZCB0byBtYWtlIGl0IGV4
cGxpY2l0Cj4+PiBpbiB0aGUgaW9hc2lkIGFsbG9jYXRvci4KPj4+Cj4+PiBDb3VsZCB3ZSBtb3Zl
IG1tX3Bhc2lkX2Ryb3AoKSB0byBfX21tZHJvcCgpIGluc3RlYWQgb2YgX19tbXB1dCgpPyAgRm9y
IEFybQo+Pj4gd2UgZG8gbmVlZCB0byBob2xkIHRoZSBtbV9jb3VudCB1bnRpbCB1bmJpbmQoKSwg
YW5kIG1tZ3JhYigpL21tZHJvcCgpIGlzCj4+PiBhbHNvIHBhcnQgb2YgTHUncyByZXdvcmsgWzFd
Lgo+PiBNb3ZlIG1tX3Bhc2lkX2Ryb3AgdG8gX19tbWRyb3AgbG9va3Mgd29ya2FibGUuCj4+Cj4+
IFRoZSBuZ2lueCB3b3JrcyBzaW5jZSBpb2FzaWQgaXMgbm90IGZyZWVkIHdoZW4gbWFzdGVyIGV4
aXQgdW50aWwgbmdpbnggc3RvcC4KPj4KPj4gVGhlIGlvYXNpZCBkb2VzIG5vdCBmcmVlIGltbWVk
aWF0ZWx5IHdoZW4gZm9wc19yZWxlYXNlLT51bmJpbmQgZmluaXNoZWQuCj4+IEluc3RlYWQsIF9f
bW1kcm9wIGhhcHBlbnMgYSBiaXQgbGF6eSzCoCB3aGljaCBoYXMgbm8gaXNzdWUgdGhvdWdoCj4+
IEkgcGFzc2VkIDEwMDAwIHRpbWVzIGV4aXQgd2l0aG91dCB1bmJpbmQgdGVzdCwgdGhlIHBhc2lk
IGFsbG9jYXRpb24gaXMgb2suCj4+Cj4+IFRoYW5rcwo+Pgo+Pgo+PiBkaWZmIC0tZ2l0IGEva2Vy
bmVsL2ZvcmsuYyBiL2tlcm5lbC9mb3JrLmMKPj4gaW5kZXggOTc5Njg5NzU2MGFiLi42MGY0MTdm
NjkzNjcgMTAwNjQ0Cj4+IC0tLSBhL2tlcm5lbC9mb3JrLmMKPj4gKysrIGIva2VybmVsL2Zvcmsu
Ywo+PiBAQCAtNzkyLDYgKzc5Miw4IEBAIHZvaWQgX19tbWRyb3Aoc3RydWN0IG1tX3N0cnVjdCAq
bW0pCj4+ICDCoMKgwqDCoMKgwqDCoCBtbXVfbm90aWZpZXJfc3Vic2NyaXB0aW9uc19kZXN0cm95
KG1tKTsKPj4gIMKgwqDCoMKgwqDCoMKgIGNoZWNrX21tKG1tKTsKPj4gIMKgwqDCoMKgwqDCoMKg
IHB1dF91c2VyX25zKG1tLT51c2VyX25zKTsKPj4gK8KgwqDCoMKgwqDCoCBtbV9wYXNpZF9kcm9w
KG1tKTsKPj4gIMKgwqDCoMKgwqDCoMKgIGZyZWVfbW0obW0pOwo+PiAgwqB9Cj4+ICDCoEVYUE9S
VF9TWU1CT0xfR1BMKF9fbW1kcm9wKTsKPj4gQEAgLTExOTAsNyArMTE5Miw2IEBAIHN0YXRpYyBp
bmxpbmUgdm9pZCBfX21tcHV0KHN0cnVjdCBtbV9zdHJ1Y3QgKm1tKQo+PiAgwqDCoMKgwqDCoMKg
wqAgfQo+PiAgwqDCoMKgwqDCoMKgwqAgaWYgKG1tLT5iaW5mbXQpCj4+ICDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgbW9kdWxlX3B1dChtbS0+YmluZm10LT5tb2R1bGUpOwo+PiAtwqDC
oMKgwqDCoMKgIG1tX3Bhc2lkX2Ryb3AobW0pOwo+PiAgwqDCoMKgwqDCoMKgwqAgbW1kcm9wKG1t
KTsKPj4gIMKgfQo+IFRoYW5rIHlvdSB2ZXJ5IG11Y2gsIFpoYW5nZmVpIQo+Cj4gSSBqdXN0IG5v
dyBzZW50IG91dCBhbiBpZGVudGljYWwgcGF0Y2guIEl0IHdvcmtzIG9uIFg4NiBhcyB3ZWxsLgo+
Cj4gU28gc2VlbXMgdGhlIHBhdGNoIGlzIHRoZSByaWdodCBmaXguCj4KPiBFaXRoZXIgeW91IGNh
biBzZW5kIG91dCB0aGUgcGF0Y2ggb3IgSSBhZGQgeW91ciBTaWduZWQtb2ZmLWJ5PyBFaXRoZXIg
d2F5Cj4gaXMgT0sgZm9yIG1lLgpUaGFua3MgRmVuZ2h1YSwKSXQgZG9lcyBub3QgbWF0dGVyLiBI
YXZlIGFkZGVkIHRlc3RlZC1ieS4KSSB3YXMgaW4gc3RyZXNzIHRlc3QgZm9yIGNoZWNraW5nIHRo
ZSBwYXNpZCBmcmVlLCBzaW5jZSBpdCB3YXMgZnJlZWQgbGF6aWx5LgoKVGhhbmsgYWxsIGZvciB0
aGUgaGVscCwgYSBiaXQgbmVydm91cywgc2luY2UgaXQgaXMgcmM0IG5vdy4KCgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QK
aW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5k
YXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
