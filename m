Return-Path: <SRS0=3PM5=Y7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6E97FC6195
	for <iommu@archiver.kernel.org>; Thu,  7 Nov 2019 13:24:24 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F00D2178F
	for <iommu@archiver.kernel.org>; Thu,  7 Nov 2019 13:24:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wS3cFYC3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F00D2178F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 13A8E151C;
	Thu,  7 Nov 2019 13:24:24 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 383FA1519
	for <iommu@lists.linux-foundation.org>;
	Thu,  7 Nov 2019 13:24:23 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com
	[209.85.210.196])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 194CD67F
	for <iommu@lists.linux-foundation.org>;
	Thu,  7 Nov 2019 13:24:22 +0000 (UTC)
Received: by mail-pf1-f196.google.com with SMTP id v19so2709980pfm.3
	for <iommu@lists.linux-foundation.org>;
	Thu, 07 Nov 2019 05:24:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-transfer-encoding:content-language;
	bh=abkWy+Oddv6Ij4UP5bVkGHy+5VTitE0a6BW1tGfeL4w=;
	b=wS3cFYC3VchQ+daBnwvoHKQ3kpjJ87fI/Gj4wRIdhbzdS6GLR9iEP6fh4owwt7U78L
	qvcajNr4YSCwoX4s8u7i3ezp98B7wzTv8Grig8cGiFgEqZfYauOc9Pqe7q8UPHG+B635
	CrwMVg5mqLS6cUVGYkLReMtq9oj+RnKHd0abmjGNqAnL3WPL+U94nlzNWfnCKYVhixx9
	VwYWi7TK7rmakwy/FHi7rOK1KL9mlCUU4lQ4qHnw/wu9UkEfUauEjt+GbbcDK7vSfyRe
	dWaOuyleLLY26hEZwM6eRsgySxgE0fcQ6FXL05R7OiGJP9xzawohFQqKELiPobwCwYC6
	OOfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:message-id:date
	:user-agent:mime-version:in-reply-to:content-transfer-encoding
	:content-language;
	bh=abkWy+Oddv6Ij4UP5bVkGHy+5VTitE0a6BW1tGfeL4w=;
	b=i6xyaCRBV7cR7gmra8IyRzy09Bc2kdCGbNb2v+5ECNq9Q8/i+jwjN6B8WIAoHWszTD
	gYMhNfF2bqpkCgUEu88NwUyoZv75j8EQ44yD42u0/1Cr5e6wEp3SsyROTHS6uisd2GRP
	9JTasG1yVHzusQze8kopIislDJPGb3x7LJn7N6ATFK8jlaWQrNiaOnf89u1CXrXOyu0A
	cvEEiLqETj5IdtrebBUkK2ljJMnB3yE/erDwkOsqlsiBmP5AHy3oIWBfWY8EEH83BzCd
	4wy/6liU2sNxYZTva6TO3Iigbh1u5DwPI/H/JcS6vPIDpatEYgUqSn/MMlESjPiqIMN8
	Jn8A==
X-Gm-Message-State: APjAAAVSO9CKGNvgwpgDv/K7I2pBGC+VsuvI7ehuYLnKL6g1SdbiJnnw
	P8KEftSDXaQmjHPFDh4QywQ3oA==
X-Google-Smtp-Source: APXvYqzNjvdYp9aTK9x1ERPxbkkcc4Ya8Rz4vq6p7QYJVZIQF1q3aoXDQDqXMkT48TNlbCxy4Jjp5Q==
X-Received: by 2002:a63:6744:: with SMTP id b65mr4447027pgc.13.1573133061336; 
	Thu, 07 Nov 2019 05:24:21 -0800 (PST)
Received: from [192.168.11.202] (li1566-229.members.linode.com.
	[139.162.86.229]) by smtp.gmail.com with ESMTPSA id
	z63sm2405155pgb.75.2019.11.07.05.24.01
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 07 Nov 2019 05:24:20 -0800 (PST)
Subject: Re: [PATCH v7 2/3] uacce: add uacce driver
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
References: <1572331216-9503-1-git-send-email-zhangfei.gao@linaro.org>
	<1572331216-9503-3-git-send-email-zhangfei.gao@linaro.org>
	<20191105114844.GA3648434@lophozonia>
	<24cbcd55-56d0-83b9-6284-04c29da11306@linaro.org>
	<20191106153246.GA3695715@lophozonia>
From: zhangfei <zhangfei.gao@linaro.org>
Message-ID: <0cad8084-8ba8-03bd-7d29-cc7ba22c29ab@linaro.org>
Date: Thu, 7 Nov 2019 21:23:50 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191106153246.GA3695715@lophozonia>
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

CgpPbiAyMDE5LzExLzYg5LiL5Y2IMTE6MzIsIEplYW4tUGhpbGlwcGUgQnJ1Y2tlciB3cm90ZToK
PiBPbiBXZWQsIE5vdiAwNiwgMjAxOSBhdCAwNDoxNzo0MFBNICswODAwLCB6aGFuZ2ZlaSB3cm90
ZToKPj4+IEJ1dCBJIHN0aWxsIGJlbGlldmUgaXQgd291bGQgYmUgYmV0dGVyIHRvIGNyZWF0ZSBh
biB1YWNjZV9tbSBzdHJ1Y3R1cmUKPj4+IHRoYXQgdHJhY2tzIGFsbCBxdWV1ZXMgYm91bmQgdG8g
dGhpcyBtbSwgYW5kIHBhc3MgdGhhdCB0byB1YWNjZV9zdmFfZXhpdAo+Pj4gaW5zdGVhZCBvZiB0
aGUgdWFjY2VfZGV2aWNlLgo+PiBJIGFtIGFmcmFpZCB0aGlzIG1ldGhvZCBtYXkgbm90IHdvcmsu
Cj4+IFNpbmNlIGN1cnJlbnRseSBpb21tdV9zdmFfYmluZF9kZXZpY2Ugb25seSBhY2NlcHQgdGhl
IHNhbWUgZHJ2ZGF0YSBmb3IgdGhlCj4+IHNhbWUgZGV2LAo+PiB0aGF0J3MgdGhlIHJlYXNvbiB3
ZSBjYW4gbm90IGRpcmVjdGx5IHVzZSAicXVldWUiIGFzIGRydmRhdGEuCj4+IEVhY2ggdGltZSBj
cmVhdGUgYW4gdWFjY2VfbW0gc3RydWN0dXJlIHNob3VsZCBiZSBzYW1lIHByb2JsZW0gYXMgcXVl
dWUsIGFuZAo+PiBmYWlsIGZvciBzYW1lIGRldi4KPj4gU28gd2UgdXNlIHVhY2NlIGFuZCBwaWNr
IHVwIHRoZSByaWdodCBxdWV1ZSBpbnNpZGUuCj4gV2hhdCBJIGhhZCBpbiBtaW5kIGlzIGtlZXAg
b25lIHVhY2NlX21tIHBlciBtbSBhbmQgcGVyIGRldmljZSwgYW5kIHdlIGNhbgo+IHBhc3MgdGhh
dCB0byBpb21tdV9zdmFfYmluZF9kZXZpY2UoKS4gSXQgcmVxdWlyZXMgc29tZSBzdHJ1Y3R1cmUg
Y2hhbmdlcywKPiBzZWUgdGhlIGF0dGFjaGVkIHBhdGNoLgpDb29sLCB0aGFua3MgSmVhbgpIb3cg
YWJvdXQgbWVyZ2UgdGhlbSB0b2dldGhlci4KPgo+Pj4gVGhlIHF1ZXVlIGlzbid0IGJvdW5kIHRv
IGEgdGFzaywgYnV0IGl0cyBhZGRyZXNzIHNwYWNlLiBXaXRoIGNsb25lKCkgdGhlCj4+PiBhZGRy
ZXNzIHNwYWNlIGNhbiBiZSBzaGFyZWQgYmV0d2VlbiB0YXNrcy4gSW4gYWRkaXRpb24sIHdob2V2
ZXIgaGFzIGEKPj4+IHF1ZXVlIGZkIGFsc28gZ2V0cyBhY2Nlc3MgdG8gdGhpcyBhZGRyZXNzIHNw
YWNlLiBTbyBhZnRlciBhIGZvcmsoKSB0aGUKPj4+IGNoaWxkIG1heSBiZSBhYmxlIHRvIHByb2dy
YW0gdGhlIHF1ZXVlIHRvIERNQSBpbnRvIHRoZSBwYXJlbnQncyBhZGRyZXNzCj4+PiBzcGFjZSwg
ZXZlbiB3aXRob3V0IENMT05FX1ZNLiBVc2VycyBtdXN0IGJlIGF3YXJlIG9mIHRoaXMgYW5kIEkg
dGhpbmsgaXQncwo+Pj4gaW1wb3J0YW50IHRvIGV4cGxhaW4gaXQgdmVyeSBjbGVhcmx5IGluIHRo
ZSBVQVBJLgo+Pj4gWy4uLl0KPj4+PiArdm9pZCB1YWNjZV91bnJlZ2lzdGVyKHN0cnVjdCB1YWNj
ZV9kZXZpY2UgKnVhY2NlKQo+Pj4+ICt7Cj4+Pj4gKwlpZiAoIXVhY2NlKQo+Pj4+ICsJCXJldHVy
bjsKPj4+PiArCj4+Pj4gKwltdXRleF9sb2NrKCZ1YWNjZS0+cV9sb2NrKTsKPj4+PiArCWlmICgh
bGlzdF9lbXB0eSgmdWFjY2UtPnFzKSkgewo+Pj4+ICsJCXN0cnVjdCB1YWNjZV9xdWV1ZSAqcTsK
Pj4+PiArCj4+Pj4gKwkJbGlzdF9mb3JfZWFjaF9lbnRyeShxLCAmdWFjY2UtPnFzLCBsaXN0KSB7
Cj4+Pj4gKwkJCXVhY2NlX3B1dF9xdWV1ZShxKTsKPj4+IFRoZSBvcGVuIGZpbGUgZGVzY3JpcHRv
ciB3aWxsIHN0aWxsIGV4aXN0IGFmdGVyIHRoaXMgZnVuY3Rpb24gcmV0dXJucy4KPj4+IENhbiBh
bGwgZm9wcyBjYW4gYmUgY2FsbGVkIHdpdGggYSBzdGFsZSBxdWV1ZT8KPj4gVG8gbW9yZSBjbGVh
cjouCj4+IERvIHlvdSBtZWFuIHJtbW9kIHdpdGhvdXQgZm9wc19yZWxlYXNlLgo+IFllcyBJIHRo
aW5rIHNvLiBXaGF0IGhhcHBlbnMgd2hlbiB1c2Vyc3BhY2Ugc3RhcnRzIHNvbWUgcXVldWVzLCBh
bmQKPiB0aGUgZGV2aWNlIGRyaXZlciBzdWRkZW5seSBjYWxscyB1YWNjZV91bnJlZ2lzdGVyKCku
IFdlIGNhbGwKPiBjZGV2X2RldmljZV9kZWwoKSBsYXRlciBpbiB0aGlzIGZ1bmN0aW9uLCBidXQg
cXVvdGluZyB0aGUgZG9jdW1lbnRhdGlvbjoKPiAiYW55IGNkZXZzIGFscmVhZHkgb3BlbiB3aWxs
IHJlbWFpbiBhbmQgdGhlaXIgZm9wcyB3aWxsIHN0aWxsIGJlIGNhbGxhYmxlCj4gZXZlbiBhZnRl
ciB0aGlzIGZ1bmN0aW9uIHJldHVybnMuIiBTbyB3ZSBuZWVkIHRvIG1ha2Ugc3VyZSB0aGF0IGFu
eSBvZiB0aGUKPiBmb3BzIGlzIHNhZmUgdG8gcnVuIGFmdGVyIHRoZSB1YWNjZSBkZXZpY2UgZGlz
YXBwZWFycy4KV2UgY2FuIHByb3RlY3Qgc3RhbGUgcXVldWUgdmlhIHEtPnN0YXRlLCBzaW5jZSBx
IGlzIHJlbGVhc2VkIGxhdGVyIGluIApmb3BzX3JlbGVhc2UuCkFuZCB1YWNjZV91bnJlZ2lzdGVy
OiBwdXRfcXVldWUgd2lsbCBzZXQgcS0+c3RhdGUgPSBVQUNDRV9RX1pPTUJJRS4KV2lsbCBhZGQg
c3RhdGUgY2hlY2sgaW4gbW1hcCB0b28uCj4KPiBJIG5vdGljZWQgYSBsb2NrIGRlcGVuZGVuY3kg
aW52ZXJzaW9uIG9uIHVhY2NlLT5xX2xvY2s6IHVhY2NlX3VucmVnaXN0ZXIoKQo+IGNhbGxzIGlv
bW11X3N2YV91bmJpbmRfZGV2aWNlKCkgd2hpbGUgaG9sZGluZyB0aGUgdWFjY2UtPnFfbG9jaywg
YnV0Cj4gdWFjY2Vfc3ZhX2V4aXQoKSB0YWtlcyB0aGUgdWFjY2UtPnFfbG9jayB3aXRoIHRoZSBT
VkEgbG9jayBoZWxkLiBJbiB0aGVvcnkKPiB3ZSBjb3VsZCBzaW1wbHkgYXZvaWQgY2FsbGluZyBp
b21tdV9zdmFfdW5iaW5kX2RldmljZSgpIGhlcmUgc2luY2UgaXQgd2lsbAo+IGJlIGRvbmUgYnkg
Zm9wc19yZWxlYXNlKCksIGJ1dCB0aGVuIGRpc2FibGluZyB0aGUgU1ZBIGZlYXR1cmUgaW4KPiB1
YWNjZV91bnJlZ2lzdGVyKCkgd29uJ3Qgd29yayAoYmVjYXVzZSB0aGVyZSBzdGlsbCBhcmUgYm9u
ZHMpLiBUaGUKPiBhdHRhY2hlZCBwYXRjaCBzaG91bGQgZml4IGl0LCBidXQgSSBoYXZlbid0IHRy
aWVkIHJ1bm5pbmcgdWFjY2VfcmVnaXN0ZXIoKQo+IHlldC4KSGF2ZSB0ZXN0ZWQsIGl0IGlzIE9L
LgoKVGhhbmtzCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
Xwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0
cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
