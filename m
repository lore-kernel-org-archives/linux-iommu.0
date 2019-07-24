Return-Path: <SRS0=WqUy=VV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06A00C76191
	for <iommu@archiver.kernel.org>; Wed, 24 Jul 2019 14:28:57 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2F9622ADB
	for <iommu@archiver.kernel.org>; Wed, 24 Jul 2019 14:28:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="klbseCMC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2F9622ADB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id A8A58E62;
	Wed, 24 Jul 2019 14:28:56 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 5253CB8F
	for <iommu@lists.linux-foundation.org>;
	Wed, 24 Jul 2019 14:28:55 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-lj1-f195.google.com (mail-lj1-f195.google.com
	[209.85.208.195])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 2B4EC701
	for <iommu@lists.linux-foundation.org>;
	Wed, 24 Jul 2019 14:28:53 +0000 (UTC)
Received: by mail-lj1-f195.google.com with SMTP id z28so44794992ljn.4
	for <iommu@lists.linux-foundation.org>;
	Wed, 24 Jul 2019 07:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=subject:to:cc:references:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=a8adFHytHBTsJftWOAZexTFr5WjQ4+eUKt3ZlK8cE/Y=;
	b=klbseCMCkn55eIImdEW1DX/nC888w41MonWoWNZdmbsu+Xc8JOxrl5yE2W71Tv65o+
	2BPSm/oN9PHr0w+MjelFN+TBWC8jjH+1yFn18bfVnCZMnQsHvHMzuJfaCtigjYVCmd13
	X0i5zWVC9xhSjEmEFsW0aWcR5b4hs0pAvHsnWf6ElJoZMkTjS1xUDRpmjb5BkrCOCPYu
	6MwTSQultvbfWthAa7fZmSP7YOYx3EufLper+mcE0aGJponeyVlGJQH64jCniOqbe3hb
	ML5m6yVvC16Xs9VOXIWZwxkyJEVMSM7f+FGrS9O60h0pyYJ71fFWc24l3ZDa4+VIFbs7
	sUWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:message-id:date
	:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=a8adFHytHBTsJftWOAZexTFr5WjQ4+eUKt3ZlK8cE/Y=;
	b=DYl6FHJBqEZW47YgXx0qiFf9buKWLaFBHf5mo056rLe8HtJXjugttvDPn8iOA8idW9
	naZRmEAQK1qO7NsGFxxUPr1IWbdsOUtWZABMb/5vCvuFojT+upjU4L4cN3/HkYep3NMA
	qkENl3o9b3sF+JerDCMb9jiIAZscH2OCPdbi1rR9JcThh1a0xi8KFP8xnBtzMBhkdUj3
	QQ4NhTLHBJBR45WJ/AgC/r1Ojzts3zb3tik97gxwUgDoRcI42Q2oFCa+SC9vJ7vV3R6g
	6MGULIVF/amaJ2oMhIu4/9RZBi/BIPADyN+qRrb+yHSWvbeztFHBCLM3hvlo//8VP7td
	eWRg==
X-Gm-Message-State: APjAAAXFeqP1D3CONC089sjlvJKx+9+Mcf90+pBKXu/zkuJJXWHFHhtg
	cZ7tXhJYDq0eU/SShY/9OUo=
X-Google-Smtp-Source: APXvYqzYVIyHbPQXFWnL98erzAUeU8oyIbBaN4a7OiAXSepJRjVkXKAD4PtiNbFuP/Z4sy6b4cdsjA==
X-Received: by 2002:a2e:b003:: with SMTP id y3mr43747276ljk.72.1563978531475; 
	Wed, 24 Jul 2019 07:28:51 -0700 (PDT)
Received: from [192.168.2.145] (ppp91-78-220-99.pppoe.mtu-net.ru.
	[91.78.220.99]) by smtp.googlemail.com with ESMTPSA id
	j11sm7098446lfm.29.2019.07.24.07.28.50
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 24 Jul 2019 07:28:50 -0700 (PDT)
Subject: Re: [PATCH] media: staging: ipu3: Enable IOVA API only when IOMMU
	support is enabled
To: Robin Murphy <robin.murphy@arm.com>, Yuehaibing <yuehaibing@huawei.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>
References: <20190722134749.21580-1-yuehaibing@huawei.com>
	<20190724103027.GD21370@paasikivi.fi.intel.com>
	<e48fc180-06cc-eac7-d8ca-9be1699c8677@arm.com>
	<0c08bdae-facc-0f28-0e58-17a65172587a@huawei.com>
	<491dbca1-8a58-b26e-cf56-a1a419da288f@gmail.com>
	<eaf521ff-7dc6-70ae-0473-9c994def602b@arm.com>
From: Dmitry Osipenko <digetx@gmail.com>
Message-ID: <dc354ede-5963-cd7f-ee53-f3df3061d39a@gmail.com>
Date: Wed, 24 Jul 2019 17:28:49 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <eaf521ff-7dc6-70ae-0473-9c994def602b@arm.com>
Content-Language: en-US
Cc: devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
	yong.zhi@intel.com, hverkuil-cisco@xs4all.nl, mchehab@kernel.org,
	linux-media@vger.kernel.org
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

MjQuMDcuMjAxOSAxNzoyMywgUm9iaW4gTXVycGh5INC/0LjRiNC10YI6Cj4gT24gMjQvMDcvMjAx
OSAxNTowOSwgRG1pdHJ5IE9zaXBlbmtvIHdyb3RlOgo+PiAyNC4wNy4yMDE5IDE3OjAzLCBZdWVo
YWliaW5nINC/0LjRiNC10YI6Cj4+PiBPbiAyMDE5LzcvMjQgMjE6NDksIFJvYmluIE11cnBoeSB3
cm90ZToKPj4+PiBPbiAyNC8wNy8yMDE5IDExOjMwLCBTYWthcmkgQWlsdXMgd3JvdGU6Cj4+Pj4+
IEhpIFl1ZSwKPj4+Pj4KPj4+Pj4gT24gTW9uLCBKdWwgMjIsIDIwMTkgYXQgMDk6NDc6NDlQTSAr
MDgwMCwgWXVlSGFpYmluZyB3cm90ZToKPj4+Pj4+IElmIElPTU1VX1NVUFBPUlQgaXMgbm90IHNl
dCwgaXB1MyBkcml2ZXIgbWF5IHNlbGVjdCBJT01NVV9JT1ZBIHRvIG0uCj4+Pj4+PiBCdXQgZm9y
IG1hbnkgZHJpdmVycywgdGhleSB1c2UgInNlbGVjdCBJT01NVV9JT1ZBIGlmIElPTU1VX1NVUFBP
UlQiCj4+Pj4+PiBpbiB0aGUgS2NvbmZpZywgZm9yIGV4YW1wbGUsIENPTkZJR19URUdSQV9WREUg
aXMgc2V0IHRvIHkgYnV0Cj4+Pj4+PiBJT01NVV9JT1ZBCj4+Pj4+PiBpcyBtLCB0aGVuIHRoZSBi
dWlsZGluZyBmYWlscyBsaWtlIHRoaXM6Cj4+Pj4+Pgo+Pj4+Pj4gZHJpdmVycy9zdGFnaW5nL21l
ZGlhL3RlZ3JhLXZkZS9pb21tdS5vOiBJbiBmdW5jdGlvbgo+Pj4+Pj4gYHRlZ3JhX3ZkZV9pb21t
dV9tYXAnOgo+Pj4+Pj4gaW9tbXUuYzooLnRleHQrMHg0MSk6IHVuZGVmaW5lZCByZWZlcmVuY2Ug
dG8gYGFsbG9jX2lvdmEnCj4+Pj4+PiBpb21tdS5jOigudGV4dCsweDU2KTogdW5kZWZpbmVkIHJl
ZmVyZW5jZSB0byBgX19mcmVlX2lvdmEnCj4+Pj4+Pgo+Pj4+Pj4gUmVwb3J0ZWQtYnk6IEh1bGsg
Um9ib3QgPGh1bGtjaUBodWF3ZWkuY29tPgo+Pj4+Pj4gRml4ZXM6IDdmYzdhZjY0OWNhNyAoIm1l
ZGlhOiBzdGFnaW5nL2ludGVsLWlwdTM6IEFkZCBpbWd1IHRvcAo+Pj4+Pj4gbGV2ZWwgcGNpIGRl
dmljZSBkcml2ZXIiKQo+Pj4+Pj4gU2lnbmVkLW9mZi1ieTogWXVlSGFpYmluZyA8eXVlaGFpYmlu
Z0BodWF3ZWkuY29tPgo+Pj4+Pj4gLS0tCj4+Pj4+PiDCoMKgIGRyaXZlcnMvc3RhZ2luZy9tZWRp
YS9pcHUzL0tjb25maWcgfCAyICstCj4+Pj4+PiDCoMKgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2Vy
dGlvbigrKSwgMSBkZWxldGlvbigtKQo+Pj4+Pj4KPj4+Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L3N0YWdpbmcvbWVkaWEvaXB1My9LY29uZmlnCj4+Pj4+PiBiL2RyaXZlcnMvc3RhZ2luZy9tZWRp
YS9pcHUzL0tjb25maWcKPj4+Pj4+IGluZGV4IDRiNTFjNjcuLmI3ZGYxOGYgMTAwNjQ0Cj4+Pj4+
PiAtLS0gYS9kcml2ZXJzL3N0YWdpbmcvbWVkaWEvaXB1My9LY29uZmlnCj4+Pj4+PiArKysgYi9k
cml2ZXJzL3N0YWdpbmcvbWVkaWEvaXB1My9LY29uZmlnCj4+Pj4+PiBAQCAtNCw3ICs0LDcgQEAg
Y29uZmlnIFZJREVPX0lQVTNfSU1HVQo+Pj4+Pj4gwqDCoMKgwqDCoMKgIGRlcGVuZHMgb24gUENJ
ICYmIFZJREVPX1Y0TDIKPj4+Pj4+IMKgwqDCoMKgwqDCoCBkZXBlbmRzIG9uIE1FRElBX0NPTlRS
T0xMRVIgJiYgVklERU9fVjRMMl9TVUJERVZfQVBJCj4+Pj4+PiDCoMKgwqDCoMKgwqAgZGVwZW5k
cyBvbiBYODYKPj4+Pj4+IC3CoMKgwqAgc2VsZWN0IElPTU1VX0lPVkEKPj4+Pj4+ICvCoMKgwqAg
c2VsZWN0IElPTU1VX0lPVkEgaWYgSU9NTVVfU1VQUE9SVAo+Pj4+Pgo+Pj4+PiBUaGlzIGRvZXNu
J3Qgc2VlbSByaWdodDogdGhlIGlwdTMtY2lvMiBkcml2ZXIgbmVlZHMgSU9NTVVfSU9WQQo+Pj4+
PiBpbmRlcGVuZGVudGx5IG9mIElPTU1VX1NVUFBPUlQuCj4+Pj4+Cj4+Pj4+IExvb2tpbmcgYXQg
dGVncmEtdmRlLCBpdCBzZWVtcyB0byBkZXBlbmQgb24gSU9NTVVfU1VQUE9SVCBidXQKPj4+Pj4g
dGhhdCdzIG5vdAo+Pj4+PiBkZWNsYXJlZCBpbiBpdHMgS2NvbmZpZyBlbnRyeS4gSSB3b25kZXIg
aWYgYWRkaW5nIHRoYXQgd291bGQgYmUgdGhlCj4+Pj4+IHJpZ2h0Cj4+Pj4+IHdheSB0byBmaXgg
dGhpcy4KPj4+Pj4KPj4+Pj4gQ2MnaW5nIHRoZSBJT01NVSBsaXN0Lgo+PiBJT01NVV9TVVBQT1JU
IGlzIG9wdGlvbmFsIGZvciB0aGUgVGVncmEtVkRFIGRyaXZlci4KPj4KPj4+PiBSaWdodCwgSSBh
bHNvIGhhZCB0aGUgaW1wcmVzc2lvbiB0aGF0IHdlJ2QgbWFkZSB0aGUgSU9WQSBsaWJyYXJ5Cj4+
Pj4gY29tcGxldGVseSBzdGFuZGFsb25lLiBBbmQgd2hhdCBkb2VzIHRoZSBJUFUzIGRyaXZlcidz
IEtjb25maWcgaGF2ZQo+Pj4+IHRvIGRvIHdpdGggc29tZSAqb3RoZXIqIGRyaXZlciBmYWlsaW5n
IHRvIGxpbmsgYW55d2F5Pwo+Pgo+PiBJIGNhbiBzZWUgaXQgZmFpbGluZyBpZiBJUFUzIGlzIGNv
bXBpbGVkIGFzIGEgbG9hZGFibGUgbW9kdWxlLCB3aGlsZQo+PiBUZWdyYS1WREUgaXMgYSBidWls
dC1pbiBkcml2ZXIuIEhlbmNlIElPVkEgbGliIHNob3VsZCBiZSBhbHNvIGEga2VybmVsCj4+IG1v
ZHVsZSBhbmQgdGh1cyB0aGUgSU9WQSBzeW1ib2xzIHdpbGwgYmUgbWlzc2luZyBkdXJpbmcgb2Yg
bGlua2FnZSBvZgo+PiB0aGUgVkRFIGRyaXZlci4KPj4KPj4+IE9oLCBJIG1pc3VuZGVyc3RhbmQg
dGhhdCBJT01NVV9JT1ZBIGlzIGRlcGVuZCBvbiBJT01NVV9TVVBQT1JULCB0aGFuawo+Pj4geW91
IGZvciBjbGFyaWZpY2F0aW9uLgo+Pj4KPj4+IEkgd2lsbCB0cnkgdG8gZml4IHRoaXMgaW4gdGVn
cmEtdmRlLgo+Pgo+PiBQcm9iYWJseSBJT1ZBIGNvdWxkIGJlIHNlbGVjdGVkIGluZGVwZW5kZW50
bHkgb2YgSU9NTVVfU1VQUE9SVCwgYnV0IElPVkEKPj4gbGlicmFyeSBpc24ndCBuZWVkZWQgZm9y
IHRoZSBWREUgZHJpdmVyIGlmIElPTU1VX1NVUFBPUlQgaXMgZGlzYWJsZWQuCj4gCj4gT2gsIEkg
dGhpbmsgSSBnZXQgdGhlIHByb2JsZW0gbm93IC0gdGVncmEtdmRlL2lvbW11LmMgaXMgYnVpbHQK
PiB1bmNvbmRpdGlvbmFsbHkgYW5kIHJlbGllcyBvbiB0aGUgc3RhdGljIGlubGluZSBzdHVicyBm
b3IgSU9NTVUgYW5kIElPVkEKPiBjYWxscyBpZiAhSU9NTVVfU1VQUE9SVCwgYnV0IGluIGEgY29t
cGlsZS10ZXN0IGNvbmZpZyB3aGVyZSBJT1ZBPW0gZm9yCj4gb3RoZXIgcmVhc29ucywgaXQgdGhl
biBwaWNrcyB1cCB0aGUgcmVhbCBkZWNsYXJhdGlvbnMgZnJvbSBsaW51eC9pb3ZhLmgKPiBpbnN0
ZWFkIG9mIHRoZSBzdHVicywgYW5kIHRoaW5ncyBnbyBkb3duaGlsbCBmcm9tIHRoZXJlLiBTbyB0
aGVyZSBpcyBhCj4gcmVhbCBpc3N1ZSwgYnV0IGluZGVlZCBpdCdzIFRlZ3JhLVZERSB3aGljaCBu
ZWVkcyB0byBiZSByZXN0cnVjdHVyZWQgdG8KPiBjb3BlIHdpdGggc3VjaCBjb25maWd1cmF0aW9u
cywgYW5kIG5vdCBJUFUzJ3MgKG9yIGFueW9uZSBlbHNlIHdobyBtYXkKPiBzZWxlY3QgSU9WQT1t
IGluIGZ1dHVyZSkgam9iIHRvIHdvcmsgYXJvdW5kIGl0LgoKSSBndWVzcyBpdCBjb3VsZCBiZToK
CglzZWxlY3QgSU9NTVVfSU9WQSBpZiAoSU9NTVVfU1VQUE9SVCB8fCBDT01QSUxFX1RFU1QpCgph
cyBhIHdvcmthcm91bmQuCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9y
ZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21t
dQ==
