Return-Path: <SRS0=/wjm=Y6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84203C5DF64
	for <iommu@archiver.kernel.org>; Wed,  6 Nov 2019 08:18:33 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 405C3217F4
	for <iommu@archiver.kernel.org>; Wed,  6 Nov 2019 08:18:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IT+wDsKz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 405C3217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id D0629C6A;
	Wed,  6 Nov 2019 08:18:32 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 03CECBDC
	for <iommu@lists.linux-foundation.org>;
	Wed,  6 Nov 2019 08:18:32 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com
	[209.85.210.193])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 5C851710
	for <iommu@lists.linux-foundation.org>;
	Wed,  6 Nov 2019 08:18:31 +0000 (UTC)
Received: by mail-pf1-f193.google.com with SMTP id x28so15062953pfo.6
	for <iommu@lists.linux-foundation.org>;
	Wed, 06 Nov 2019 00:18:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-transfer-encoding:content-language;
	bh=Pb3J1TnMyrHbEtYv4MyAUzMHiBthQ4b5tWMwPD00Zec=;
	b=IT+wDsKz7eH1XfZbUEBfSiJkvJJy7o9j2aUjeVGwdRRdQgIrbw9jPP/qrGlnq+NvHr
	plrKmujPiZ2FSwPZdTHxNzZTEqv+AsqAyBsq/fn8luoE8b31WL3D/gBKldnz/KduMuDV
	kMwlAul+PWMpsypharNu1EbIz115+4jcLs4iOHFDd6taKUReevyVLAduuSu/ROg98q3R
	maATSw8Lf3REgICYZa8J4rKBb86B1mgNMdLGIBPRc+8P7mkix2sHN/nnouuVqfsMf03Q
	uWkHCakL6d7lMkHn/+uFerKz2vmVjDKld1x9hCJBwnKVa7hN4wTfeRTE7mCef4XU5u/Y
	5qbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:message-id:date
	:user-agent:mime-version:in-reply-to:content-transfer-encoding
	:content-language;
	bh=Pb3J1TnMyrHbEtYv4MyAUzMHiBthQ4b5tWMwPD00Zec=;
	b=Qsve8m/NyX8ITjUcPQYeX4FdqflB9Yst7wgRCyAFIeJXTi2uSCTTjJuDMdH4NR9uWx
	HdbuPD/fUnRX8R/3FPDQDPl1QYY4ISfCdazqNx3JwJcUiBWitytnuqlfiVLGCWp1mpKF
	13PzPXZwErYxh4LxXyA73y5Vl2NewGM/zM7ztK4NYSuoFcmvYHIPgE5/mfMyFqt4rJG5
	x1kM0eDLf7dosM1N6d5XwSF7ktmOpAPVwmaQN0vWDflLuYWWFF4l849zBBXHD31VyP7G
	JIhJfSZDUQCqSg3MVoeLX1RnHgVaMm4Le6XZ34FOKrUXnN+uLDarxoNSu26nt7Z1KZ9v
	vjQg==
X-Gm-Message-State: APjAAAVEMZ6LsXLEKPdb3ETp0EbSoBq1PoQayhLu1kG/VrpxrZwhOrjh
	8sp/Vce5zy0oXxFnfglt3hasVw==
X-Google-Smtp-Source: APXvYqz/QQDPA6+bnNKK03js7EGHCc3O8indybIknbR/TjXpwF00GzVlt5rXNQ1j1gbsdolo9KrbhQ==
X-Received: by 2002:a65:64da:: with SMTP id t26mr1443346pgv.180.1573028310541; 
	Wed, 06 Nov 2019 00:18:30 -0800 (PST)
Received: from ?IPv6:240e:362:4fb:4700:8c77:245e:61d8:3896?
	([240e:362:4fb:4700:8c77:245e:61d8:3896])
	by smtp.gmail.com with ESMTPSA id
	m2sm22041206pff.154.2019.11.06.00.18.00
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 06 Nov 2019 00:18:29 -0800 (PST)
Subject: Re: [PATCH v7 2/3] uacce: add uacce driver
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
References: <1572331216-9503-1-git-send-email-zhangfei.gao@linaro.org>
	<1572331216-9503-3-git-send-email-zhangfei.gao@linaro.org>
	<20191105114844.GA3648434@lophozonia>
From: zhangfei <zhangfei.gao@linaro.org>
Message-ID: <24cbcd55-56d0-83b9-6284-04c29da11306@linaro.org>
Date: Wed, 6 Nov 2019 16:17:40 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191105114844.GA3648434@lophozonia>
Content-Language: en-US
Cc: francois.ozog@linaro.org, Herbert Xu <herbert@gondor.apana.org.au>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	ilias.apalodimas@linaro.org, iommu@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org, Jerome Glisse <jglisse@redhat.com>,
	grant.likely@arm.com, "haojian . zhuang" <haojian.zhuang@linaro.org>,
	linux-accelerators@lists.ozlabs.org, linux-crypto@vger.kernel.org,
	Kenneth Lee <liguozhu@hisilicon.com>, guodong.xu@linaro.org,
	kenneth-lee-2012@foxmail.com
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

SGksIEplYW4KClRoYW5rcyBmb3IgdGhlIHJldmlldy4KCk9uIDIwMTkvMTEvNSDkuIvljYg3OjQ4
LCBKZWFuLVBoaWxpcHBlIEJydWNrZXIgd3JvdGU6Cj4gSGkgWmhhbmdmZWksCj4KPiBUaGFua3Mg
Zm9yIHNpbXBsaWZ5aW5nIHRoaXMsIGl0J3MgYSBsb3QgZWFzaWVyIHRvIHJldmlldy4gSSBoYXZl
IHNvbWUKPiBhZGRpdGlvbmFsIGNvbW1lbnRzLgo+Cj4gT24gVHVlLCBPY3QgMjksIDIwMTkgYXQg
MDI6NDA6MTVQTSArMDgwMCwgWmhhbmdmZWkgR2FvIHdyb3RlOgo+PiArc3RhdGljIGludCB1YWNj
ZV9zdmFfZXhpdChzdHJ1Y3QgZGV2aWNlICpkZXYsIHN0cnVjdCBpb21tdV9zdmEgKmhhbmRsZSwK
Pj4gKwkJCSAgdm9pZCAqZGF0YSkKPj4gK3sKPj4gKwlzdHJ1Y3QgdWFjY2VfZGV2aWNlICp1YWNj
ZSA9IGRhdGE7Cj4+ICsJc3RydWN0IHVhY2NlX3F1ZXVlICpxOwo+PiArCj4+ICsJbXV0ZXhfbG9j
aygmdWFjY2UtPnFfbG9jayk7Cj4+ICsJbGlzdF9mb3JfZWFjaF9lbnRyeShxLCAmdWFjY2UtPnFz
LCBsaXN0KSB7Cj4+ICsJCWlmIChxLT5waWQgPT0gdGFza19waWRfbnIoY3VycmVudCkpCj4+ICsJ
CQl1YWNjZV9wdXRfcXVldWUocSk7Cj4gVGhpcyB3b24ndCB3b3JrIGluIHNvbWUgY2FzZXMsIGJl
Y2F1c2UgYW55IHRocmVhZCBjYW4gY2FsbCBfX21tcHV0KCkgYW5kCj4gZW5kIHVwIGhlcmUuIEZv
ciBleGFtcGxlIGEgc2libGluZyB0aHJlYWQgdGhhdCBpbmhlcml0ZWQgdGhlIHF1ZXVlLCBvciBh
Cj4gd29ya3F1ZXVlIHRoYXQncyBleGVjdXRpbmcgbW1wdXRfYXN5bmNfZm4oKS4gSW4gYWRkaXRp
b24gSSB0aGluayBjb21wYXJpbmcKPiBQSUQgdmFsdWVzIGlzIHVuc2FmZSAoc2VlIGNvbW1lbnQg
aW4gcGlkLmgpLCB3ZSdkIG5lZWQgdG8gdXNlIHRoZSBzdHJ1Y3QKPiBwaWQgaWYgd2Ugd2FudGVk
IHRvIGRvIGl0IHRoaXMgd2F5LgpPSywgc3RpbGwgaW4gY2hlY2suCj4KPiBCdXQgSSBzdGlsbCBi
ZWxpZXZlIGl0IHdvdWxkIGJlIGJldHRlciB0byBjcmVhdGUgYW4gdWFjY2VfbW0gc3RydWN0dXJl
Cj4gdGhhdCB0cmFja3MgYWxsIHF1ZXVlcyBib3VuZCB0byB0aGlzIG1tLCBhbmQgcGFzcyB0aGF0
IHRvIHVhY2NlX3N2YV9leGl0Cj4gaW5zdGVhZCBvZiB0aGUgdWFjY2VfZGV2aWNlLgpJIGFtIGFm
cmFpZCB0aGlzIG1ldGhvZCBtYXkgbm90IHdvcmsuClNpbmNlIGN1cnJlbnRseSBpb21tdV9zdmFf
YmluZF9kZXZpY2Ugb25seSBhY2NlcHQgdGhlIHNhbWUgZHJ2ZGF0YSBmb3IgCnRoZSBzYW1lIGRl
diwKdGhhdCdzIHRoZSByZWFzb24gd2UgY2FuIG5vdCBkaXJlY3RseSB1c2UgInF1ZXVlIiBhcyBk
cnZkYXRhLgpFYWNoIHRpbWUgY3JlYXRlIGFuIHVhY2NlX21tIHN0cnVjdHVyZSBzaG91bGQgYmUg
c2FtZSBwcm9ibGVtIGFzIHF1ZXVlLCAKYW5kIGZhaWwgZm9yIHNhbWUgZGV2LgpTbyB3ZSB1c2Ug
dWFjY2UgYW5kIHBpY2sgdXAgdGhlIHJpZ2h0IHF1ZXVlIGluc2lkZS4KCj4KPiBUaGUgcXVldWUg
aXNuJ3QgYm91bmQgdG8gYSB0YXNrLCBidXQgaXRzIGFkZHJlc3Mgc3BhY2UuIFdpdGggY2xvbmUo
KSB0aGUKPiBhZGRyZXNzIHNwYWNlIGNhbiBiZSBzaGFyZWQgYmV0d2VlbiB0YXNrcy4gSW4gYWRk
aXRpb24sIHdob2V2ZXIgaGFzIGEKPiBxdWV1ZSBmZCBhbHNvIGdldHMgYWNjZXNzIHRvIHRoaXMg
YWRkcmVzcyBzcGFjZS4gU28gYWZ0ZXIgYSBmb3JrKCkgdGhlCj4gY2hpbGQgbWF5IGJlIGFibGUg
dG8gcHJvZ3JhbSB0aGUgcXVldWUgdG8gRE1BIGludG8gdGhlIHBhcmVudCdzIGFkZHJlc3MKPiBz
cGFjZSwgZXZlbiB3aXRob3V0IENMT05FX1ZNLiBVc2VycyBtdXN0IGJlIGF3YXJlIG9mIHRoaXMg
YW5kIEkgdGhpbmsgaXQncwo+IGltcG9ydGFudCB0byBleHBsYWluIGl0IHZlcnkgY2xlYXJseSBp
biB0aGUgVUFQSS4KPgo+IFsuLi5dCj4+ICtzdGF0aWMgc3RydWN0IHVhY2NlX3FmaWxlX3JlZ2lv
biAqCj4+ICt1YWNjZV9jcmVhdGVfcmVnaW9uKHN0cnVjdCB1YWNjZV9xdWV1ZSAqcSwgc3RydWN0
IHZtX2FyZWFfc3RydWN0ICp2bWEsCj4+ICsJCSAgICBlbnVtIHVhY2NlX3FmcnQgdHlwZSwgdW5z
aWduZWQgaW50IGZsYWdzKQo+PiArewo+PiArCXN0cnVjdCB1YWNjZV9kZXZpY2UgKnVhY2NlID0g
cS0+dWFjY2U7Cj4+ICsJc3RydWN0IHVhY2NlX3FmaWxlX3JlZ2lvbiAqcWZyOwo+PiArCWludCBy
ZXQgPSAtRU5PTUVNOwo+PiArCj4+ICsJcWZyID0ga3phbGxvYyhzaXplb2YoKnFmciksIEdGUF9L
RVJORUwpOwo+PiArCWlmICghcWZyKQo+PiArCQlyZXR1cm4gRVJSX1BUUigtRU5PTUVNKTsKPj4g
Kwo+PiArCXFmci0+dHlwZSA9IHR5cGU7Cj4+ICsJcWZyLT5mbGFncyA9IGZsYWdzOwo+PiArCj4+
ICsJaWYgKHZtYS0+dm1fZmxhZ3MgJiBWTV9SRUFEKQo+PiArCQlxZnItPnByb3QgfD0gSU9NTVVf
UkVBRDsKPiBxZnItPnByb3QgYW5kIHFmci0+ZmxhZ3MgYXJlbid0IHVzZWQgYXQgdGhlIG1vbWVu
dCwgeW91IGNvdWxkIHJlbW92ZSB0aGVtLgpZZXMsCj4KPj4gKwo+PiArCWlmICh2bWEtPnZtX2Zs
YWdzICYgVk1fV1JJVEUpCj4+ICsJCXFmci0+cHJvdCB8PSBJT01NVV9XUklURTsKPj4gKwo+PiAr
CWlmIChmbGFncyAmIFVBQ0NFX1FGUkZfU0VMRk1UKSB7Cj4+ICsJCWlmICghdWFjY2UtPm9wcy0+
bW1hcCkgewo+PiArCQkJcmV0ID0gLUVJTlZBTDsKPj4gKwkJCWdvdG8gZXJyX3dpdGhfcWZyOwo+
PiArCQl9Cj4+ICsKPj4gKwkJcmV0ID0gdWFjY2UtPm9wcy0+bW1hcChxLCB2bWEsIHFmcik7Cj4+
ICsJCWlmIChyZXQpCj4+ICsJCQlnb3RvIGVycl93aXRoX3FmcjsKPj4gKwkJcmV0dXJuIHFmcjsK
Pj4gKwl9Cj4+ICsKPj4gKwlyZXR1cm4gcWZyOwo+PiArCj4+ICtlcnJfd2l0aF9xZnI6Cj4+ICsJ
a2ZyZWUocWZyKTsKPj4gKwlyZXR1cm4gRVJSX1BUUihyZXQpOwo+PiArfQo+PiArCj4+ICtzdGF0
aWMgaW50IHVhY2NlX2ZvcHNfbW1hcChzdHJ1Y3QgZmlsZSAqZmlsZXAsIHN0cnVjdCB2bV9hcmVh
X3N0cnVjdCAqdm1hKQo+PiArewo+PiArCXN0cnVjdCB1YWNjZV9xdWV1ZSAqcSA9IGZpbGVwLT5w
cml2YXRlX2RhdGE7Cj4+ICsJc3RydWN0IHVhY2NlX2RldmljZSAqdWFjY2UgPSBxLT51YWNjZTsK
Pj4gKwlzdHJ1Y3QgdWFjY2VfcWZpbGVfcmVnaW9uICpxZnI7Cj4+ICsJZW51bSB1YWNjZV9xZnJ0
IHR5cGUgPSAwOwo+PiArCXVuc2lnbmVkIGludCBmbGFncyA9IDA7Cj4+ICsJaW50IHJldDsKPj4g
Kwo+PiArCWlmICh2bWEtPnZtX3Bnb2ZmIDwgVUFDQ0VfUUZSVF9NQVgpCj4+ICsJCXR5cGUgPSB2
bWEtPnZtX3Bnb2ZmOwo+IE90aGVyd2lzZSByZXR1cm4gLUVJTlZBTD8gIHR5cGUgcHJvYmFibHkg
c2hvdWxkbid0IGRlZmF1bHQgdG8gTU1JTyBpZiBpdAo+IHdhc24ndCBleHBsaWNpdGx5IHJlcXVl
c3RlZCBieSB0aGUgdXNlci4KT0sKPgo+PiArCj4+ICsJdm1hLT52bV9mbGFncyB8PSBWTV9ET05U
Q09QWSB8IFZNX0RPTlRFWFBBTkQgfCBWTV9XSVBFT05GT1JLOwo+PiArCXZtYS0+dm1fb3BzID0g
JnVhY2NlX3ZtX29wczsKPj4gKwl2bWEtPnZtX3ByaXZhdGVfZGF0YSA9IHE7Cj4+ICsKPj4gKwlt
dXRleF9sb2NrKCZ1YWNjZV9tdXRleCk7Cj4+ICsKPj4gKwlpZiAocS0+cWZyc1t0eXBlXSkgewo+
PiArCQlyZXQgPSAtRUVYSVNUOwo+PiArCQlnb3RvIG91dF93aXRoX2xvY2s7Cj4+ICsJfQo+PiAr
Cj4+ICsJc3dpdGNoICh0eXBlKSB7Cj4+ICsJY2FzZSBVQUNDRV9RRlJUX01NSU86Cj4+ICsJCWZs
YWdzID0gVUFDQ0VfUUZSRl9TRUxGTVQ7Cj4+ICsJCWJyZWFrOwo+PiArCj4+ICsJY2FzZSBVQUND
RV9RRlJUX0RVUzoKPj4gKwkJaWYgKHVhY2NlLT5mbGFncyAmIFVBQ0NFX0RFVl9TVkEpIHsKPj4g
KwkJCWZsYWdzID0gVUFDQ0VfUUZSRl9TRUxGTVQ7Cj4gSSdkIHNpbXBsaWZ5IHRoaXMgZXZlbiBm
dXJ0aGVyIGJ5IGdldHRpbmcgcmlkIG9mIHRoZSBTRUxGTVQgZmxhZy4gSXQncyB0aGUKPiBvbmx5
IHBvc3NpYmlsaXR5IGF0IHRoZSBtb21lbnQuCk9LLCB3ZSBjYW4gcmVtb3ZlIHRoaXMgZmxhZyBm
b3Igc2ltcGxpY2l0eSwgbWF5IGFkZCBpdCBiYWNrIGlmIHJlcXVpcmVkIAppbiBmdXR1cmUgcGF0
Y2guCj4KPj4gKwkJCWJyZWFrOwo+PiArCQl9Cj4+ICsJCWJyZWFrOwo+PiArCj4+ICsJZGVmYXVs
dDoKPj4gKwkJV0FSTl9PTigmdWFjY2UtPmRldik7Cj4gV0FSTl9PTih1YWNjZS0+ZGV2KS4gQnV0
IHNob3VsZG4ndCB3ZSBpbnN0ZWFkIHJldHVybiAtRUlOVkFMIGhlcmU/Cj4gVUFDQ0VfUUZSVF9N
QVggaXMgY3VycmVudGx5IDE2LCBzbyB1c2VycyBjYW4gZWFzaWx5IHRyaWdnZXIgdGhpcyBXQVJO
IGJ5Cj4gcGFzc2luZyBhbiBpbnZhbGlkIHZhbHVlLgpZZXMsIGdvb2QgaWRlYS4KPgo+IFsuLi5d
Cj4+ICt2b2lkIHVhY2NlX3VucmVnaXN0ZXIoc3RydWN0IHVhY2NlX2RldmljZSAqdWFjY2UpCj4+
ICt7Cj4+ICsJaWYgKCF1YWNjZSkKPj4gKwkJcmV0dXJuOwo+PiArCj4+ICsJbXV0ZXhfbG9jaygm
dWFjY2UtPnFfbG9jayk7Cj4+ICsJaWYgKCFsaXN0X2VtcHR5KCZ1YWNjZS0+cXMpKSB7Cj4+ICsJ
CXN0cnVjdCB1YWNjZV9xdWV1ZSAqcTsKPj4gKwo+PiArCQlsaXN0X2Zvcl9lYWNoX2VudHJ5KHEs
ICZ1YWNjZS0+cXMsIGxpc3QpIHsKPj4gKwkJCXVhY2NlX3B1dF9xdWV1ZShxKTsKPiBUaGUgb3Bl
biBmaWxlIGRlc2NyaXB0b3Igd2lsbCBzdGlsbCBleGlzdCBhZnRlciB0aGlzIGZ1bmN0aW9uIHJl
dHVybnMuCj4gQ2FuIGFsbCBmb3BzIGNhbiBiZSBjYWxsZWQgd2l0aCBhIHN0YWxlIHF1ZXVlPwpU
byBtb3JlIGNsZWFyOi4KRG8geW91IG1lYW4gcm1tb2Qgd2l0aG91dCBmb3BzX3JlbGVhc2UuCgpU
aGFua3MKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9t
bXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8v
bGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
