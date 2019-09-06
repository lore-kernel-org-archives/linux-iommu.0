Return-Path: <SRS0=rqG6=XB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67A41C43331
	for <iommu@archiver.kernel.org>; Fri,  6 Sep 2019 13:38:39 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3AEF720650
	for <iommu@archiver.kernel.org>; Fri,  6 Sep 2019 13:38:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XTgbUDPn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AEF720650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 228F12327;
	Fri,  6 Sep 2019 13:38:39 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 058422324
	for <iommu@lists.linux-foundation.org>;
	Fri,  6 Sep 2019 13:38:38 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-lj1-f194.google.com (mail-lj1-f194.google.com
	[209.85.208.194])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id E5B75756
	for <iommu@lists.linux-foundation.org>;
	Fri,  6 Sep 2019 13:38:36 +0000 (UTC)
Received: by mail-lj1-f194.google.com with SMTP id y23so5705139ljn.5
	for <iommu@lists.linux-foundation.org>;
	Fri, 06 Sep 2019 06:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=subject:to:cc:references:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=qvGBDr79mgdpu98SIY4ZRDe69WVCw7anA4ywGgxGxNc=;
	b=XTgbUDPnpkktFUYLZrNeBOZF8yeu/7KkLGkmTy3Ax3LuBiDZpaEVxOAMKc29VJhyz3
	PHsF7FUsBleItoHedA9S7/QIrIa2zG5n4X5le+RQtbOje8mBcWfj0AWElX9SFpeInu5I
	bcqe5decbtTPXhvIxpeC2AUDZCRlf4YET+3YYGbBq14PgG1q+uOWnZKrGkkXnUQtz/6a
	i0Y00Gg51B+iiPkQo7TpQGlIOWjhyHjfp7F5lL9ktkGlYsIXAYjGqFuimtaGeDHIPyoB
	J+D9QYlVGuO9craTnFk61EYAb8KlhbZ6RVuF01lAizTzFmPAYPr+OVSXBFh7gBf5M2Bb
	WqzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:message-id:date
	:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=qvGBDr79mgdpu98SIY4ZRDe69WVCw7anA4ywGgxGxNc=;
	b=DIHi7aIb79P8Uh2d9lIR2JsGjFR1lx9Sri9H86J3w/HoKiDZLeEhUdkLMD80HEHYdH
	G+VfeDgy8AbmkZwZb5lLMeLyvQK12y5lei5hiHWTpp/JamXLoMMwQw1wbNKRynt9igYl
	TmKzT0sEt/WaW5Yxh9n4deVvflEKsN7G1HhJ3XQvVWGtO8f18EVT3uz/x22wxGcTHHL0
	iw7yNus4rTyiVrjqQrpuViDVR1F7yLA2OXOqBDb1t3Vu53M2tEK6DDiWHPjbV4NV/zhH
	ttiiiHei5fr8qJyQqx0+RJLpJRp4aW7rgSCGiwG4f+EAz4fNcj0T6W8Lo8GLyZkN0Wz7
	83ew==
X-Gm-Message-State: APjAAAVXoAzxFYZ/rgt8b3eT9pjUpxjEcLOQGM9N6H32AZV4WKL+tTKm
	wS7R5RQBtH12+z6WCW/o4YeM1tyB
X-Google-Smtp-Source: APXvYqx1cXjuxoE/j7ZDk4fdPT/zgtXus0TzRg2oupqeb/ZUe7h3+EQ8H6YWNCXrqmguRlk7kTaB2w==
X-Received: by 2002:a2e:6596:: with SMTP id e22mr5564848ljf.87.1567777115141; 
	Fri, 06 Sep 2019 06:38:35 -0700 (PDT)
Received: from [192.168.2.145] ([94.29.34.218])
	by smtp.googlemail.com with ESMTPSA id
	q13sm1136466lfk.51.2019.09.06.06.38.33
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 06 Sep 2019 06:38:34 -0700 (PDT)
Subject: Re: [PATCH] media: staging: tegra-vde: Disable building with
	COMPILE_TEST
To: Thierry Reding <thierry.reding@gmail.com>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>, YueHaibing <yuehaibing@huawei.com>
References: <20190826133140.13456-1-yuehaibing@huawei.com>
	<7f73bcac-f52d-f1b3-324c-e9b551c5378b@xs4all.nl>
	<20190829124034.GA19842@ulmo>
	<b048b460-9d58-8e38-e335-f9a3fface559@gmail.com>
	<20190829154902.GC19842@ulmo>
From: Dmitry Osipenko <digetx@gmail.com>
Message-ID: <c4014675-8fc6-e947-7ac5-68795fd80bc0@gmail.com>
Date: Fri, 6 Sep 2019 16:38:32 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190829154902.GC19842@ulmo>
Content-Language: en-US
Cc: devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org, jonathanh@nvidia.com,
	iommu@lists.linux-foundation.org, linux-tegra@vger.kernel.org,
	mchehab@kernel.org, robin.murphy@arm.com, linux-media@vger.kernel.org
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

MjkuMDguMjAxOSAxODo0OSwgVGhpZXJyeSBSZWRpbmcg0L/QuNGI0LXRgjoKPiBPbiBUaHUsIEF1
ZyAyOSwgMjAxOSBhdCAwNDo1ODoyMlBNICswMzAwLCBEbWl0cnkgT3NpcGVua28gd3JvdGU6Cj4+
IDI5LjA4LjIwMTkgMTU6NDAsIFRoaWVycnkgUmVkaW5nINC/0LjRiNC10YI6Cj4+PiBPbiBUaHUs
IEF1ZyAyOSwgMjAxOSBhdCAwMTozOTozMlBNICswMjAwLCBIYW5zIFZlcmt1aWwgd3JvdGU6Cj4+
Pj4gT24gOC8yNi8xOSAzOjMxIFBNLCBZdWVIYWliaW5nIHdyb3RlOgo+Pj4+PiBJZiBDT01QSUxF
X1RFU1QgaXMgeSBhbmQgSU9NTVVfU1VQUE9SVCBpcyBuLCBzZWxlY3RpbmcgVEVHUkFfVkRFCj4+
Pj4+IHRvIG0gd2lsbCBzZXQgSU9NTVVfSU9WQSB0byBtLCB0aGlzIGZhaWxzIHRoZSBidWlsZGlu
ZyBvZgo+Pj4+PiBURUdSQV9IT1NUMVggYW5kIERSTV9URUdSQSB3aGljaCBpcyB5IGxpa2UgdGhp
czoKPj4+Pj4KPj4+Pj4gZHJpdmVycy9ncHUvaG9zdDF4L2NkbWEubzogSW4gZnVuY3Rpb24gYGhv
c3QxeF9jZG1hX2luaXQnOgo+Pj4+PiBjZG1hLmM6KC50ZXh0KzB4NjZjKTogdW5kZWZpbmVkIHJl
ZmVyZW5jZSB0byBgYWxsb2NfaW92YScKPj4+Pj4gY2RtYS5jOigudGV4dCsweDY5OCk6IHVuZGVm
aW5lZCByZWZlcmVuY2UgdG8gYF9fZnJlZV9pb3ZhJwo+Pj4+Pgo+Pj4+PiBkcml2ZXJzL2dwdS9k
cm0vdGVncmEvZHJtLm86IEluIGZ1bmN0aW9uIGB0ZWdyYV9kcm1fdW5sb2FkJzoKPj4+Pj4gZHJt
LmM6KC50ZXh0KzB4ZWIwKTogdW5kZWZpbmVkIHJlZmVyZW5jZSB0byBgcHV0X2lvdmFfZG9tYWlu
Jwo+Pj4+PiBkcm0uYzooLnRleHQrMHhlYjQpOiB1bmRlZmluZWQgcmVmZXJlbmNlIHRvIGBpb3Zh
X2NhY2hlX3B1dCcKPj4+Pj4KPj4+Pj4gUmVwb3J0ZWQtYnk6IEh1bGsgUm9ib3QgPGh1bGtjaUBo
dWF3ZWkuY29tPgo+Pj4+PiBGaXhlczogNmIyMjY1OTc1MjM5ICgibWVkaWE6IHN0YWdpbmc6IHRl
Z3JhLXZkZTogRml4IGJ1aWxkIGVycm9yIikKPj4+Pj4gRml4ZXM6IGIzMDFmOGRlMTkyNSAoIm1l
ZGlhOiBzdGFnaW5nOiBtZWRpYTogdGVncmEtdmRlOiBBZGQgSU9NTVUgc3VwcG9ydCIpCj4+Pj4+
IFNpZ25lZC1vZmYtYnk6IFl1ZUhhaWJpbmcgPHl1ZWhhaWJpbmdAaHVhd2VpLmNvbT4KPj4+Pj4g
LS0tCj4+Pj4+ICBkcml2ZXJzL3N0YWdpbmcvbWVkaWEvdGVncmEtdmRlL0tjb25maWcgfCA0ICsr
LS0KPj4+Pj4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0p
Cj4+Pj4+Cj4+Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3N0YWdpbmcvbWVkaWEvdGVncmEtdmRl
L0tjb25maWcgYi9kcml2ZXJzL3N0YWdpbmcvbWVkaWEvdGVncmEtdmRlL0tjb25maWcKPj4+Pj4g
aW5kZXggYmE0OWVhNS4uYTQxZDMwYyAxMDA2NDQKPj4+Pj4gLS0tIGEvZHJpdmVycy9zdGFnaW5n
L21lZGlhL3RlZ3JhLXZkZS9LY29uZmlnCj4+Pj4+ICsrKyBiL2RyaXZlcnMvc3RhZ2luZy9tZWRp
YS90ZWdyYS12ZGUvS2NvbmZpZwo+Pj4+PiBAQCAtMSw5ICsxLDkgQEAKPj4+Pj4gICMgU1BEWC1M
aWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAKPj4+Pj4gIGNvbmZpZyBURUdSQV9WREUKPj4+Pj4g
IAl0cmlzdGF0ZSAiTlZJRElBIFRlZ3JhIFZpZGVvIERlY29kZXIgRW5naW5lIGRyaXZlciIKPj4+
Pj4gLQlkZXBlbmRzIG9uIEFSQ0hfVEVHUkEgfHwgQ09NUElMRV9URVNUCj4+Pj4+ICsJZGVwZW5k
cyBvbiBBUkNIX1RFR1JBCj4+Pj4KPj4+PiBXaGF0IGhhcHBlbnMgaWYgeW91IGRyb3AgdGhpcyBj
aGFuZ2UsCj4+Pj4KPj4+Pj4gIAlzZWxlY3QgRE1BX1NIQVJFRF9CVUZGRVIKPj4+Pj4gLQlzZWxl
Y3QgSU9NTVVfSU9WQSBpZiAoSU9NTVVfU1VQUE9SVCB8fCBDT01QSUxFX1RFU1QpCj4+Pj4+ICsJ
c2VsZWN0IElPTU1VX0lPVkEgaWYgSU9NTVVfU1VQUE9SVAo+Pj4+Cj4+Pj4gYnV0IGtlZXAgdGhp
cyBjaGFuZ2U/Cj4+Pj4KPj4+PiBpb3ZhLmggaGFzIHN0dWJzIHRoYXQgYXJlIHVzZWQgaWYgSU9N
TVVfSU9WQSBpcyBub3Qgc2V0LCBzbyBpdCBzaG91bGQKPj4+PiB3b3JrIHdoZW4gY29tcGlsZSB0
ZXN0aW5nIHRoaXMgdGVncmEtdmRlIGRyaXZlci4KPj4+Pgo+Pj4+IEhhdmVuJ3QgdHJpZWQgaXQs
IGJ1dCBtYWtpbmcgc3VyZSB0aGF0IGNvbXBpbGUgdGVzdGluZyBrZWVwIHdvcmtpbmcgaXMKPj4+
PiByZWFsbHkgaW1wb3J0YW50Lgo+Pgo+PiBUaGUgZHJpdmVyJ3MgY29kZSBjb21waWxhdGlvbiB3
b3JrcyBva2F5LCBpdCdzIHRoZSBsaW5rYWdlIHN0YWdlIHdoaWNoCj4+IGZhaWxzIGR1cmluZyBj
b21waWxlLXRlc3RpbmcuCj4+Cj4+PiBZZWFoLCB0aGF0IHZhcmlhbnQgc2VlbXMgdG8gd29yayBm
b3IgbWUuIEkgdGhpbmsgaXQncyBhbHNvIG1vcmUgY29ycmVjdAo+Pj4gYmVjYXVzZSB0aGUgSU9N
TVVfSU9WQSBpZiBJT01NVV9TVVBQT1JUIGRlcGVuZGVuY3kgcmVhbGx5IHNheXMgdGhhdCB0aGUK
Pj4+IElPVkEgdXNhZ2UgaXMgYm91bmQgdG8gSU9NTVUgc3VwcG9ydC4gSWYgSU9NTVUgc3VwcG9y
dCBpcyBub3QgZW5hYmxlZCwKPj4+IHRoZW4gSU9WQSBpcyBub3QgbmVlZGVkIGVpdGhlciwgc28g
dGhlIGR1bW1pZXMgd2lsbCBkbyBqdXN0IGZpbmUuCj4+Cj4+IEFtIEkgdW5kZXJzdGFuZGluZyBj
b3JyZWN0bHkgdGhhdCB5b3UncmUgc3VnZ2VzdGluZyB0byByZXZlcnQgWzFdWzJdIGFuZAo+PiBn
ZXQgYmFjayB0byB0aGUgb3RoZXIgcHJvYmxlbT8KPj4KPj4gWzFdCj4+IGh0dHBzOi8vbG9yZS5r
ZXJuZWwub3JnL2xpbnV4LW1lZGlhL2RkNTQ3YjQ0LTdhYmItMzcxZi1hZWVlLWE4MmI5NmY4MjRl
MkBnbWFpbC5jb20vVC8KPj4gWzJdIGh0dHBzOi8vcGF0Y2h3b3JrLm96bGFicy5vcmcvcGF0Y2gv
MTEzNjYxOS8KPj4KPj4gSWYgd2Ugd2FudCB0byBrZWVwIGNvbXBpbGUgdGVzdGluZywgSSBndWVz
cyB0aGUgb25seSByZWFzb25hYmxlIHZhcmlhbnQKPj4gcmlnaHQgbm93IGlzIHRvIHNlbGVjdCBJ
T01NVV9JT1ZBIHVuY29uZGl0aW9uYWxseSBpbiBhbGwgb2YgdGhlIGRyaXZlcnMKPj4gKHZkZSwg
aG9zdDF4LCBkcm0gYW5kIGV0YykgYW5kIHRoZW4ganVzdCBpZ25vcmUgdGhhdCBJT1ZBIHdpbGwg
YmUKPj4gY29tcGlsZWQtYW5kLXVudXNlZCBpZiBJT01NVV9TVVBQT1JUPW4gKG5vdGUgdGhhdCBJ
T01NVV9TVVBQT1JUPXkgaW4gYWxsCj4+IG9mIGRlZmF1bHQga2VybmVsIGNvbmZpZ3VyYXRpb25z
KS4KPiAKPiBBZ3JlZWQuIEkgdGhpbmsgd2Ugc2hvdWxkIGp1c3Qgc2VsZWN0IElPTU1VX0lPVkEg
dW5jb25kaXRpb25hbGx5LiBXZQo+IHJlYWxseSBkbyB3YW50IElPTU1VX1NVUFBPUlQgYWx3YXlz
IGFzIHdlbGwsIGJ1dCBpdCBtaWdodCBiZSBuaWNlIHRvIGJlCj4gYWJsZSB0byBzd2l0Y2ggaXQg
b2ZmIGZvciB0ZXN0aW5nIG9yIHNvLiBJbiB0aGUgY2FzZXMgdGhhdCByZWFsbHkgbWF0dGVyCj4g
d2Ugd2lsbCBiZSBlbmFibGluZyBib3RoIElPTU1VX1NVUFBPUlQgYW5kIElPTU1VX0lPVkEgYW55
d2F5LCBzbyBtaWdodAo+IGFzIHdlbGwgc2VsZWN0IElPTU1VX0lPVkEgYWx3YXlzLiBJdCdzIG5v
dCB0ZXJyaWJseSBiaWcgYW5kIEkgY2FuJ3QKPiBpbWFnaW5lIGFueW9uZSB3YW50aW5nIHRvIHJ1
biBhIGtlcm5lbCB3aXRob3V0IElPTU1VX1NVUFBPUlQgZm9yCj4gYW55dGhpbmcgb3RoZXIgdGhh
biB0ZXN0aW5nLgoKSGVsbG8gWXVlLAoKQ291bGQgeW91IHBsZWFzZSBtYWtlIGFuIHVwZGF0ZWQg
dmVyc2lvbiBvZiB0aGUgZml4IGluIGFjY29yZGFuY2UgdG8gdGhlIGFib3ZlIGNvbW1lbnRzPwoK
QWx0ZXJuYXRpdmVseSwgd2UgY2FuIGdvIHdpdGggdGhlIGN1cnJlbnQgcGF0Y2ggYW5kIHRlbXBv
cmFyaWx5IHJlbW92ZSB0aGUgY29tcGlsZS10ZXN0aW5nLiBJJ2xsIG1ha2UKcGF0Y2hlcyB0byBw
cm9wZXJseSByZS1hZGQgY29tcGlsZS10ZXN0aW5nIHNvbWV0aW1lIGxhdGVyIHRoZW4uCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcg
bGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4
Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
