Return-Path: <SRS0=eHMU=2G=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5077AC2D0BF
	for <iommu@archiver.kernel.org>; Mon, 16 Dec 2019 19:35:33 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1618F21582
	for <iommu@archiver.kernel.org>; Mon, 16 Dec 2019 19:35:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="V6QZCNSy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1618F21582
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id C682B87749;
	Mon, 16 Dec 2019 19:35:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hy-8VUY8bV4o; Mon, 16 Dec 2019 19:35:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 1016287740;
	Mon, 16 Dec 2019 19:35:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 02F41C1AE8;
	Mon, 16 Dec 2019 19:35:32 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7F21EC077D
 for <iommu@lists.linux-foundation.org>; Mon, 16 Dec 2019 19:35:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 6858C22219
 for <iommu@lists.linux-foundation.org>; Mon, 16 Dec 2019 19:35:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AGn8arJjzwpv for <iommu@lists.linux-foundation.org>;
 Mon, 16 Dec 2019 19:35:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com
 [209.85.210.195])
 by silver.osuosl.org (Postfix) with ESMTPS id 5F3B7221F8
 for <iommu@lists.linux-foundation.org>; Mon, 16 Dec 2019 19:35:29 +0000 (UTC)
Received: by mail-pf1-f195.google.com with SMTP id q8so6155089pfh.7
 for <iommu@lists.linux-foundation.org>; Mon, 16 Dec 2019 11:35:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=CkQ65CjNVt4hNQc5fIVwGwBcjZEAsNi6X9HREDxycBo=;
 b=V6QZCNSyM+juWCR4X2eqZmLVQ6jevW5eE/xWhjKgwrHxE+dfA9pKL4I8NMlNgy8p1U
 dLJkUfasvP8rJALOAqxvawWRnHUgtdAR4kWzSYBfS2xCqZna65xnOZY35ujuEJ+sQXWw
 bg3lw9JNoQUblP3TnXxrvCQDeRLKLjOvlCTufd0EXdjEFEwlTSuGZkDjmM6HazAhx6B/
 zDw6Di5WncWNx39QBbmL8QOO/n928cQoDEFb/w2/7uXTKh71V/bfcDNxHy5rFr/1VLvC
 2g4aPB0NuqJYTU/iM9pca0JsIPN/4Bs3FX+0QchEGJTiFZs7VsERnPjU/zJzw/80InW5
 uBiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=CkQ65CjNVt4hNQc5fIVwGwBcjZEAsNi6X9HREDxycBo=;
 b=CqD6aVLTTo8pkPsCyV+I0TNGcXJ/lMMFtlEsU1XmJHsLCEmLqZJPAqHc0pQGoVE1wI
 Zyly7/+xD4Z1yNquJfj9CZYNwTsNw4cYbNDjiGnzeFqi5S6aWoyCogiyxN5SSgZgybzM
 g0qPoSYb5+dbCTok4qqWQ7CzXRhuM3uL6ia061comRQgK5pwxU79WdcO3/gOo05jX2rX
 LT2ZGuXmOpYHEsEMGGz9cTBb3paCC4SY1ZiBXEzSgtS0UHzeZ10/okHgtiKDFn1LHiZg
 CXLLoPW0yNgjmrWSC41h3QKE/2L0ot1efOobxocLPyam0d1THGOj5M9IV+rQcHstA5LK
 ccXQ==
X-Gm-Message-State: APjAAAU97cn9RiioOoUcLEp2qovOW4cPbfCIq8jKsanmjaaEnXZrChsB
 /CoCAUhwanzvLFT4AY5DTECAZA==
X-Google-Smtp-Source: APXvYqzgOZ1uRhn9JxOPVQ4nRzUnloZT6mVaYm126ILaYf0ERKQKahlEFl5v5phKXCzBWat2/J5yrA==
X-Received: by 2002:aa7:9988:: with SMTP id k8mr17217363pfh.200.1576524928619; 
 Mon, 16 Dec 2019 11:35:28 -0800 (PST)
Received: from gnomeregan.cam.corp.google.com
 ([2620:15c:6:14:ad22:1cbb:d8fa:7d55])
 by smtp.googlemail.com with ESMTPSA id q9sm23976818pgc.5.2019.12.16.11.35.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Dec 2019 11:35:28 -0800 (PST)
Subject: Re: [PATCH 1/3] iommu/vt-d: skip RMRR entries that fail the sanity
 check
To: "Chen, Yian" <yian.chen@intel.com>, Thomas Gleixner <tglx@linutronix.de>, 
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 "H. Peter Anvin" <hpa@zytor.com>, David Woodhouse <dwmw2@infradead.org>,
 Joerg Roedel <joro@8bytes.org>, Sohil Mehta <sohil.mehta@intel.com>
References: <20191211194606.87940-1-brho@google.com>
 <20191211194606.87940-2-brho@google.com>
 <99a294a0-444e-81f9-19a2-216aef03f356@intel.com>
Message-ID: <93820c21-8a37-d8f0-dacb-29cee694a91d@google.com>
Date: Mon, 16 Dec 2019 14:35:26 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <99a294a0-444e-81f9-19a2-216aef03f356@intel.com>
Content-Language: en-US
Cc: iommu@lists.linux-foundation.org, x86@kernel.org,
 linux-kernel@vger.kernel.org
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
From: Barret Rhoden via iommu <iommu@lists.linux-foundation.org>
Reply-To: Barret Rhoden <brho@google.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

T24gMTIvMTYvMTkgMjowNyBQTSwgQ2hlbiwgWWlhbiB3cm90ZToKPiAKPiAKPiBPbiAxMi8xMS8y
MDE5IDExOjQ2IEFNLCBCYXJyZXQgUmhvZGVuIHdyb3RlOgo+PiBSTVJSIGVudHJpZXMgZGVzY3Jp
YmUgbWVtb3J5IHJlZ2lvbnMgdGhhdCBhcmUgRE1BIHRhcmdldHMgZm9yIGRldmljZXMKPj4gb3V0
c2lkZSB0aGUga2VybmVsJ3MgY29udHJvbC4KPj4KPj4gUk1SUiBlbnRyaWVzIHRoYXQgZmFpbCB0
aGUgc2FuaXR5IGNoZWNrIGFyZSBwb2ludGluZyB0byByZWdpb25zIG9mCj4+IG1lbW9yeSB0aGF0
IHRoZSBmaXJtd2FyZSBkaWQgbm90IHRlbGwgdGhlIGtlcm5lbCBhcmUgcmVzZXJ2ZWQgb3IKPj4g
b3RoZXJ3aXNlIHNob3VsZCBub3QgYmUgdXNlZC4KPj4KPj4gSW5zdGVhZCBvZiBhYm9ydGluZyBE
TUFSIHByb2Nlc3NpbmcsIHRoaXMgY29tbWl0IHNraXBzIHRoZXNlIFJNUlIKPj4gZW50cmllcy7C
oCBUaGV5IHdpbGwgbm90IGJlIG1hcHBlZCBpbnRvIHRoZSBJT01NVSwgYnV0IHRoZSBJT01NVSBj
YW4KPj4gc3RpbGwgYmUgdXRpbGl6ZWQuwqAgSWYgYW55dGhpbmcsIHdoZW4gdGhlIElPTU1VIGlz
IG9uLCB0aG9zZSBkZXZpY2VzCj4+IHdpbGwgbm90IGJlIGFibGUgdG8gY2xvYmJlciBSQU0gdGhh
dCB0aGUga2VybmVsIGhhcyBhbGxvY2F0ZWQgZnJvbSB0aG9zZQo+PiByZWdpb25zLgo+Pgo+PiBT
aWduZWQtb2ZmLWJ5OiBCYXJyZXQgUmhvZGVuIDxicmhvQGdvb2dsZS5jb20+Cj4+IC0tLQo+PiDC
oCBkcml2ZXJzL2lvbW11L2ludGVsLWlvbW11LmMgfCAyICstCj4+IMKgIDEgZmlsZSBjaGFuZ2Vk
LCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQo+Pgo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9pb21tdS9pbnRlbC1pb21tdS5jIGIvZHJpdmVycy9pb21tdS9pbnRlbC1pb21tdS5jCj4+IGlu
ZGV4IGYxNjhjZDhlZTU3MC4uZjdlMDkyNDRjOWU0IDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJzL2lv
bW11L2ludGVsLWlvbW11LmMKPj4gKysrIGIvZHJpdmVycy9pb21tdS9pbnRlbC1pb21tdS5jCj4+
IEBAIC00MzE2LDcgKzQzMTYsNyBAQCBpbnQgX19pbml0IGRtYXJfcGFyc2Vfb25lX3JtcnIoc3Ry
dWN0IAo+PiBhY3BpX2RtYXJfaGVhZGVyICpoZWFkZXIsIHZvaWQgKmFyZykKPj4gwqDCoMKgwqDC
oCBybXJyID0gKHN0cnVjdCBhY3BpX2RtYXJfcmVzZXJ2ZWRfbWVtb3J5ICopaGVhZGVyOwo+PiDC
oMKgwqDCoMKgIHJldCA9IGFyY2hfcm1ycl9zYW5pdHlfY2hlY2socm1ycik7Cj4+IMKgwqDCoMKg
wqAgaWYgKHJldCkKPj4gLcKgwqDCoMKgwqDCoMKgIHJldHVybiByZXQ7Cj4+ICvCoMKgwqDCoMKg
wqDCoCByZXR1cm4gMDsKPj4gwqDCoMKgwqDCoCBybXJydSA9IGt6YWxsb2Moc2l6ZW9mKCpybXJy
dSksIEdGUF9LRVJORUwpOwo+PiDCoMKgwqDCoMKgIGlmICghcm1ycnUpCj4gUGFyc2luZyBybXJy
IGZ1bmN0aW9uIHNob3VsZCByZXBvcnQgdGhlIGVycm9yIHRvIGNhbGxlci4gVGhlIGJlaGF2aW9y
IHRvIAo+IHJlc3BvbnNlIHRoZSBlcnJvciBjYW4gYmUKPiBjaG9zZcKgIGJ5IHRoZSBjYWxsZXIg
aW4gdGhlIGNhbGxpbmcgc3RhY2ssIGZvciBleGFtcGxlLCAKPiBkbWFyX3dhbGtfcmVtYXBwaW5n
X2VudHJpZXMoKS4KPiBBIGNvbmNlcm4gaXMgdGhhdCBpZ25vcmluZyBhIGRldGVjdGVkIGZpcm13
YXJlIGJ1ZyBtaWdodCBoYXZlIGEgCj4gcG90ZW50aWFsIHNpZGUgaW1wYWN0IHRob3VnaAo+IGl0
IHNlZW1lZCBzYWZlIGZvciB5b3VyIGNhc2UuCgpUaGF0J3MgYSBsaXR0bGUgZGlmZmljdWx0IGdp
dmVuIHRoZSBjdXJyZW50IGNvZGUuICBPbmNlIHdlIGFyZSBpbgpkbWFyX3dhbGtfcmVtYXBwaW5n
X2VudHJpZXMoKSwgdGhlIHNwZWNpZmljIGZ1bmN0aW9uIChwYXJzZV9vbmVfcm1ycikgaXMgCmNh
bGxlZCB2aWEgY2FsbGJhY2s6CgoJcmV0ID0gY2ItPmNiW2l0ZXItPnR5cGVdKGl0ZXIsIGNiLT5h
cmdbaXRlci0+dHlwZV0pOwoJaWYgKHJldCkKCQlyZXR1cm4gcmV0OwoKSWYgdGhlcmUncyBhbiBl
cnJvciBvZiBhbnkgc29ydCwgaXQgYWJvcnRzIHRoZSB3YWxrLiAgSGFuZGxpbmcgdGhlIApzcGVj
aWZpYyBlcnJvcnMgaGVyZSBpcyBkaWZmaWN1bHQsIHNpbmNlIHdlIGRvbid0IGtub3cgd2hhdCB0
aGUgZXJyb3JzIAptZWFuIHRvIHRoZSBzcGVjaWZpYyBjYWxsYmFjay4gIElzIHRoZXJlIHNvbWUg
ZXJybm8gd2UgY2FuIHVzZSB0aGF0IAptZWFucyAidGhlcmUgd2FzIGEgcHJvYmxlbSwgYnV0IGl0
J3Mgbm90IHNvIGJhZCB0aGF0IHlvdSBoYXZlIHRvIGFib3J0LCAKYnV0IEkgZmlndXJlZCB5b3Ug
b3VnaHQgdG8ga25vdyI/ICBOb3QgdGhhdCBJIHRoaW5rIHRoYXQncyBhIGdvb2QgaWRlYS4KClRo
ZSBrbm93bGVkZ2Ugb2Ygd2hldGhlciBvciBub3QgYSBzcGVjaWZpYyBlcnJvciBpcyB3b3J0aCBh
Ym9ydGluZyBhbGwgCkRNQVIgZnVuY3Rpb25hbGl0eSBpcyBiZXN0IGtub3duIGluc2lkZSB0aGUg
c3BlY2lmaWMgY2FsbGJhY2suICBUaGUgb25seSAKaGFuZGxpbmcgdG8gZG8gaXMgcHJpbnQgYSB3
YXJuaW5nIGFuZCBlaXRoZXIgc2tpcCBpdCBvciBhYm9ydC4KCkkgdGhpbmsgc2tpcHBpbmcgdGhl
IGVudHJ5IGZvciBhIGJhZCBSTVJSIGlzIGJldHRlciB0aGFuIGFib3J0aW5nIApjb21wbGV0ZWx5
LCB0aG91Z2ggSSB1bmRlcnN0YW5kIGlmIHBlb3BsZSBkb24ndCBsaWtlIHRoYXQuICBJdCdzIApk
ZWJhdGFibGUuICBCeSBhYm9ydGluZywgd2UgbG9zZSB0aGUgYWJpbGl0eSB0byB1c2UgdGhlIElP
TU1VIGF0IGFsbCwgCmJ1dCB3ZSBhcmUgc3RpbGwgaW4gYSBzaXR1YXRpb24gd2hlcmUgdGhlIGRl
dmljZXMgdXNpbmcgdGhlIFJNUlIgcmVnaW9ucyAKbWlnaHQgYmUgY2xvYmJlcmluZyBrZXJuZWwg
bWVtb3J5LCByaWdodD8gIFVzaW5nIHRoZSBJT01NVSAod2l0aCBubyAKbWFwcGluZ3MgZm9yIHRo
ZSBiYWQgUk1SUnMpIHdvdWxkIHN0b3AgdGhvc2UgZGV2aWNlcyBmcm9tIGNsb2JiZXJpbmcgbWVt
b3J5LgoKUmVnYXJkbGVzcywgSSBoYXZlIHR3byBvdGhlciBwYXRjaGVzIGluIHRoaXMgc2VyaWVz
IHRoYXQgY291bGQgcmVzb2x2ZSAKdGhlIHByb2JsZW0gZm9yIG1lIGFuZCBwcm9iYWJseSBvdGhl
ciBwZW9wbGUuICBJJ2QganVzdCBsaWtlIGF0IGxlYXN0IApvbmUgb2YgdGhlIHRocmVlIHBhdGNo
ZXMgdG8gZ2V0IG1lcmdlZCBzbyB0aGF0IG15IG1hY2hpbmUgYm9vdHMgd2hlbiB0aGUgCm9yaWdp
bmFsIGNvbW1pdCBmMDM2YzdmYTBhYjYgKCJpb21tdS92dC1kOiBDaGVjayBWVC1kIFJNUlIgcmVn
aW9uIGluIApCSU9TIGlzIHJlcG9ydGVkIGFzIHJlc2VydmVkIikgZ2V0cyByZWxlYXNlZC4KClRo
YW5rcywKCkJhcnJldAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3Jn
Cmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
