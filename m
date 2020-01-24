Return-Path: <SRS0=t+bH=3N=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A812C35242
	for <iommu@archiver.kernel.org>; Fri, 24 Jan 2020 17:59:19 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBFE42072C
	for <iommu@archiver.kernel.org>; Fri, 24 Jan 2020 17:59:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HGuapn5T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBFE42072C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id A7ECD8821F;
	Fri, 24 Jan 2020 17:59:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YD3pdvb27q02; Fri, 24 Jan 2020 17:59:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id D465088180;
	Fri, 24 Jan 2020 17:59:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C552DC1D80;
	Fri, 24 Jan 2020 17:59:17 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 391DEC0174
 for <iommu@lists.linux-foundation.org>; Fri, 24 Jan 2020 17:59:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 2070C86460
 for <iommu@lists.linux-foundation.org>; Fri, 24 Jan 2020 17:59:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4VU98JD60OTf for <iommu@lists.linux-foundation.org>;
 Fri, 24 Jan 2020 17:59:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-io1-f65.google.com (mail-io1-f65.google.com
 [209.85.166.65])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 339B585735
 for <iommu@lists.linux-foundation.org>; Fri, 24 Jan 2020 17:59:15 +0000 (UTC)
Received: by mail-io1-f65.google.com with SMTP id n21so2840673ioo.10
 for <iommu@lists.linux-foundation.org>; Fri, 24 Jan 2020 09:59:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linuxfoundation.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Ex0Isa11/flUHUOcxw59BzxTs8GRZOlZkq93u4RA4cc=;
 b=HGuapn5TKXdsGZVP/fd3t4XZ3KECr31sSy71HHNkBR1yREz/nnbselm1Io6SqGJDC3
 7AqBXqewKQctdURvHPlNLYCxvPWb4dXm28iYOVKQuPav8B4ggEIJHQ00jfGsjTJqXJSo
 kTuoVPu3MSMoaAeyexzQ73reTt3mIIChM1v5k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Ex0Isa11/flUHUOcxw59BzxTs8GRZOlZkq93u4RA4cc=;
 b=Ezu8tyGaFbp3K3PZzVToFx7xdGmq8KkBrz//j0/6nBwW6dUaJ+6rfxKczvq5/2cTab
 pGtfqY3AfhPDamd3U/nfnA4A4GqMsfmiiULEZ/w7MFV3Gkjp0H/lAELuoKy7T9nF4zEI
 iQ2GGmLAlaOzJOqyttB0LKtSezyk/K4DVuzfv4qCElp00c5Z9nX4ekqy8DO5RGI0iump
 lR2h05ICf8CZTddN/ud2RYaY7ixhhM3gmOhtNW6XIZdfBHVyLHy4X4Dorh4dZP453LH3
 k/szJ2hPbN3tKVZm8ptgIXxYEvVGBiGiEvwtHU7GmcdC6ZgAmqHgPtgC/BWHLEJsbP7I
 jXXw==
X-Gm-Message-State: APjAAAWbu9nbt/zGCK2MtBDHs/KWkJEc98IUWO8JV9sEw/SOzyPFS9vd
 AeGUe0AXCkd3pbgG9Lz/hiGKcPJ1
X-Google-Smtp-Source: APXvYqzbojxj7MjKCh5WcRlf+iKihR3vmOwHSm53h/ObLAA0Fw3I7khmHWixbodbBkGe+QaiCAqfLg==
X-Received: by 2002:a5d:9d11:: with SMTP id j17mr3255546ioj.83.1579888754401; 
 Fri, 24 Jan 2020 09:59:14 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net.
 [24.9.64.241])
 by smtp.gmail.com with ESMTPSA id i11sm1338641ion.1.2020.01.24.09.59.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Jan 2020 09:59:13 -0800 (PST)
Subject: Re: [PATCH v2] iommu: amd: Fix IOMMU perf counter clobbering during
 init
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, joro@8bytes.org
References: <20200123223214.2566-1-skhan@linuxfoundation.org>
 <096ee758-a372-4caa-c082-e1e8cff3f033@amd.com>
From: Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <11e832e3-67ca-cc8a-7e5c-c60b9fc54da1@linuxfoundation.org>
Date: Fri, 24 Jan 2020 10:59:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <096ee758-a372-4caa-c082-e1e8cff3f033@amd.com>
Content-Language: en-US
Cc: iommu@lists.linux-foundation.org, "Grimm, Jon" <jon.grimm@amd.com>,
 linux-kernel@vger.kernel.org, "skh >> Shuah Khan" <skhan@linuxfoundation.org>
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

T24gMS8yMy8yMCAxMTo0MyBQTSwgU3VyYXZlZSBTdXRoaWt1bHBhbml0IHdyb3RlOgo+IAo+IAo+
IE9uIDEvMjQvMjAgNTozMiBBTSwgU2h1YWggS2hhbiB3cm90ZToKPj4gaW5pdF9pb21tdV9wZXJm
X2N0cigpIGNsb2JiZXJzIHRoZSByZWdpc3RlciB3aGVuIGl0IGNoZWNrcyB3cml0ZSBhY2Nlc3MK
Pj4gdG8gSU9NTVUgcGVyZiBjb3VudGVycyBhbmQgZmFpbHMgdG8gcmVzdG9yZSB3aGVuIHRoZXkg
YXJlIHdyaXRhYmxlLgo+Pgo+PiBBZGQgc2F2ZSBhbmQgcmVzdG9yZSB0byBmaXggaXQuCj4+Cj4+
IFNpZ25lZC1vZmYtYnk6IFNodWFoIEtoYW4gPHNraGFuQGxpbnV4Zm91bmRhdGlvbi5vcmc+Cj4+
IC0tLQo+PiBDaGFuZ2VzIHNpbmNlIHYxOgo+PiAtLSBGaXggYnVnIGluIHN1Y2Vzc2Z1bCByZXR1
cm4gcGF0aC4gQWRkIGEgcmV0dXJuIGluc3RlYWQgb2YKPj4gwqDCoMKgIGZhbGwgdGhyb3VnaCB0
byBwY19mYWxzZSBlcnJvciBjYXNlCj4+Cj4+IMKgIGRyaXZlcnMvaW9tbXUvYW1kX2lvbW11X2lu
aXQuYyB8IDI0ICsrKysrKysrKysrKysrKysrKy0tLS0tLQo+PiDCoCAxIGZpbGUgY2hhbmdlZCwg
MTggaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkKPj4KPj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvaW9tbXUvYW1kX2lvbW11X2luaXQuYyAKPj4gYi9kcml2ZXJzL2lvbW11L2FtZF9pb21tdV9p
bml0LmMKPj4gaW5kZXggNTY4YzUyMzE3NzU3Li40ODNmN2JjMzc5ZmEgMTAwNjQ0Cj4+IC0tLSBh
L2RyaXZlcnMvaW9tbXUvYW1kX2lvbW11X2luaXQuYwo+PiArKysgYi9kcml2ZXJzL2lvbW11L2Ft
ZF9pb21tdV9pbml0LmMKPj4gQEAgLTE2NTUsMjcgKzE2NTUsMzkgQEAgc3RhdGljIGludCBpb21t
dV9wY19nZXRfc2V0X3JlZyhzdHJ1Y3QgCj4+IGFtZF9pb21tdSAqaW9tbXUsIHU4IGJhbmssIHU4
IGNudHIsCj4+IMKgIHN0YXRpYyB2b2lkIGluaXRfaW9tbXVfcGVyZl9jdHIoc3RydWN0IGFtZF9p
b21tdSAqaW9tbXUpCj4+IMKgIHsKPj4gwqDCoMKgwqDCoCBzdHJ1Y3QgcGNpX2RldiAqcGRldiA9
IGlvbW11LT5kZXY7Cj4+IC3CoMKgwqAgdTY0IHZhbCA9IDB4YWJjZCwgdmFsMiA9IDA7Cj4+ICvC
oMKgwqAgdTY0IHZhbCA9IDB4YWJjZCwgdmFsMiA9IDAsIHNhdmVfcmVnID0gMDsKPj4gwqDCoMKg
wqDCoCBpZiAoIWlvbW11X2ZlYXR1cmUoaW9tbXUsIEZFQVRVUkVfUEMpKQo+PiDCoMKgwqDCoMKg
wqDCoMKgwqAgcmV0dXJuOwo+PiDCoMKgwqDCoMKgIGFtZF9pb21tdV9wY19wcmVzZW50ID0gdHJ1
ZTsKPj4gK8KgwqDCoCAvKiBzYXZlIHRoZSB2YWx1ZSB0byByZXN0b3JlLCBpZiB3cml0YWJsZSAq
Lwo+PiArwqDCoMKgIGlmIChpb21tdV9wY19nZXRfc2V0X3JlZyhpb21tdSwgMCwgMCwgMCwgJnNh
dmVfcmVnLCBmYWxzZSkpCj4+ICvCoMKgwqDCoMKgwqDCoCBnb3RvIHBjX2ZhbHNlOwo+PiArCj4+
IMKgwqDCoMKgwqAgLyogQ2hlY2sgaWYgdGhlIHBlcmZvcm1hbmNlIGNvdW50ZXJzIGNhbiBiZSB3
cml0dGVuIHRvICovCj4+IMKgwqDCoMKgwqAgaWYgKChpb21tdV9wY19nZXRfc2V0X3JlZyhpb21t
dSwgMCwgMCwgMCwgJnZhbCwgdHJ1ZSkpIHx8Cj4+IMKgwqDCoMKgwqDCoMKgwqDCoCAoaW9tbXVf
cGNfZ2V0X3NldF9yZWcoaW9tbXUsIDAsIDAsIDAsICZ2YWwyLCBmYWxzZSkpIHx8Cj4+IC3CoMKg
wqDCoMKgwqDCoCAodmFsICE9IHZhbDIpKSB7Cj4+IC3CoMKgwqDCoMKgwqDCoCBwY2lfZXJyKHBk
ZXYsICJVbmFibGUgdG8gd3JpdGUgdG8gSU9NTVUgcGVyZiBjb3VudGVyLlxuIik7Cj4+IC3CoMKg
wqDCoMKgwqDCoCBhbWRfaW9tbXVfcGNfcHJlc2VudCA9IGZhbHNlOwo+PiAtwqDCoMKgwqDCoMKg
wqAgcmV0dXJuOwo+PiAtwqDCoMKgIH0KPj4gK8KgwqDCoMKgwqDCoMKgICh2YWwgIT0gdmFsMikp
Cj4+ICvCoMKgwqDCoMKgwqDCoCBnb3RvIHBjX2ZhbHNlOwo+PiArCj4+ICvCoMKgwqAgLyogcmVz
dG9yZSAqLwo+PiArwqDCoMKgIGlmIChpb21tdV9wY19nZXRfc2V0X3JlZyhpb21tdSwgMCwgMCwg
MCwgJnNhdmVfcmVnLCB0cnVlKSkKPj4gK8KgwqDCoMKgwqDCoMKgIGdvdG8gcGNfZmFsc2U7Cj4+
IMKgwqDCoMKgwqAgcGNpX2luZm8ocGRldiwgIklPTU1VIHBlcmZvcm1hbmNlIGNvdW50ZXJzIHN1
cHBvcnRlZFxuIik7Cj4+IMKgwqDCoMKgwqAgdmFsID0gcmVhZGwoaW9tbXUtPm1taW9fYmFzZSAr
IE1NSU9fQ05UUl9DT05GX09GRlNFVCk7Cj4+IMKgwqDCoMKgwqAgaW9tbXUtPm1heF9iYW5rcyA9
ICh1OCkgKCh2YWwgPj4gMTIpICYgMHgzZik7Cj4+IMKgwqDCoMKgwqAgaW9tbXUtPm1heF9jb3Vu
dGVycyA9ICh1OCkgKCh2YWwgPj4gNykgJiAweGYpOwo+PiArCj4+ICvCoMKgwqAgcmV0dXJuOwo+
PiArCj4gCj4gR29vZCBjYXRjaC4gU29ycnksIEkgbWlzc2VkIHRoaXMgcGFydCBhcyB3ZWxsIDoo
Cj4gCj4+ICtwY19mYWxzZToKPj4gK8KgwqDCoCBwY2lfZXJyKHBkZXYsICJVbmFibGUgdG8gcmVh
ZC93cml0ZSB0byBJT01NVSBwZXJmIGNvdW50ZXIuXG4iKTsKPj4gK8KgwqDCoCBhbWRfaW9tbXVf
cGNfcHJlc2VudCA9IGZhbHNlOwo+PiArwqDCoMKgIHJldHVybjsKPj4gwqAgfQo+PiDCoCBzdGF0
aWMgc3NpemVfdCBhbWRfaW9tbXVfc2hvd19jYXAoc3RydWN0IGRldmljZSAqZGV2LAo+Pgo+IAo+
IEFzIGZvciB5b3VyIHF1ZXN0aW9uIGluIHYxOgo+IAo+ICA+IEkgc2VlIDIgYmFua3MgYW5kIDQg
Y291bnRlcnMgb24gbXkgc3lzdGVtLiBJcyBpdCBzdWZmaWNpZW50IHRvIGNoZWNrCj4gID4gdGhl
IGZpcnN0IGJhbmsgYW5kIGZpcnN0IGNvdW50ZXI/IEluIG90aGVyIHdvcmRzLCBpZiB0aGUgZmly
c3Qgb25lCj4gID4gaXNuJ3Qgd3JpdGFibGUsIGFyZSBhbGwgY291bnRlcnMgbm9uLXdyaXRhYmxl
Pwo+IAo+IFdlIGN1cnJlbnRseSBhc3N1bWUgYWxsIGNvdW50ZXJzIGhhdmUgdGhlIHNhbWUgd3Jp
dGUtYWJpbGl0eS4gU28sIGl0IAo+IHNob3VsZCBiZSBzdWZmaWNpZW50Cj4gdG8ganVzdCBjaGVj
ayB0aGUgZmlyc3Qgb25lLgo+IAo+ICA+IFNob3VsZCB3ZSByZWFkIHRoZSBjb25maWcgZmlyc3Qg
YW5kIHRoZW4sIHRyeSB0byBzZWUgaWYgYW55IG9mIHRoZQo+ICA+IGNvdW50ZXJzIGFyZSB3cml0
YWJsZT8gSSBoYXZlIGEgcGF0Y2ggdGhhdCBkb2VzIHRoYXQsIEkgY2FuIHNlbmQgaXQKPiAgPiBv
dXQgZm9yIHJldmlldy4KPiAKPiBXaGljaCBjb25maWcgYXJlIHlvdSByZWZlcnJpbmcgdG8/IE5v
dCBzdXJlIHdoYXQgeW91IG1lYW4uCgpJIG1lYW4gcmVhZGluZyBNTUlPX0NOVFJfQ09ORl9PRkZT
RVQgdG8gZ2V0IG1heCBiYW5rcyBhbmQgY291bnRlcnMuCkFsc28gd2hhdCBpcyB0aGUgcmVhc29u
IHRvIGNoZWNrIHdyaXRhYmxlPwoKSSB0cmllZCBhIGNvdXBsZiBvZyB0aGluZ3Mgb24gbXkKCkFN
RCBSeXplbiA1IFBSTyAyNDAwR0Ugdy8gUmFkZW9uIFZlZ2EgR3JhcGhpY3MKCkkgY2hhbmdlZCB0
aGUgbG9naWMgdG8gcmVhZCBjb25maWcgdG8gZ2V0IG1heCBiYW5rcyBhbmQgY291bnRlcnMKYmVm
b3JlIGNoZWNraW5nIGlmIGNvdW50ZXJzIGFyZSB3cml0YWJsZSBhbmQgdHJpZWQgd3JpdGluZyB0
byBhbGwuClRoZSByZXN1bHQgaXMgdGhlIHNhbWUgYW5kIGFsbCBvZiB0aGVtIGFyZW4ndCB3cml0
YWJsZS4gSG93ZXZlciwKd2hlbiBkaXNhYmxlIHRoZSB3cml0YWJsZSBjaGVjayBhbmQgYXNzdW1l
IHRoZXkgYXJlLCBJIGNhbiBydW4KCnBlcmYgc3RhdCAtZSAnYW1kX2lvbW11XzAgb24gYWxsIGV2
ZW50cyBhbmQgZ2V0IGRhdGEuCgpwZXJmIHN0YXQgLWUgJ2FtZF9pb21tdV8wL2NtZF9wcm9jZXNz
ZWQvJyBzbGVlcCAxMAoKICBQZXJmb3JtYW5jZSBjb3VudGVyIHN0YXRzIGZvciAnc3lzdGVtIHdp
ZGUnOgoKICAgICAgICAgICAgICAgICA1NiAgICAgIGFtZF9pb21tdV8wL2NtZF9wcm9jZXNzZWQv
IAoKCiAgICAgICAxMC4wMDE1MjUxNzEgc2Vjb25kcyB0aW1lIGVsYXBzZWQKCgpwZXJmIHN0YXQg
LWEgLWUgYW1kX2lvbW11L21lbV90cmFuc190b3RhbC8gc2xlZXAgMTAKCiAgUGVyZm9ybWFuY2Ug
Y291bnRlciBzdGF0cyBmb3IgJ3N5c3RlbSB3aWRlJzoKCiAgICAgICAgICAgICAgMiw2OTYgICAg
ICBhbWRfaW9tbXUvbWVtX3RyYW5zX3RvdGFsLyAKCgogICAgICAgMTAuMDAxNDY1MTE1IHNlY29u
ZHMgdGltZSBlbGFwc2VkCgpJIHRyaWVkIGFsbCBwb3NzaWJsZSBldmVudHMgbGlzdGVkIHVuZGVy
IGFtZF9pb21tdV8wIGFuZCBJIGNhbiBnZXQKZGF0YSBvbiBhbGwgb2YgdGhlbS4gTm8gcHJvYmxl
bXMgaW4gZG1lc2cuCgpJcyB0aGlzIGlubGluZSB3aXRoIHdoYXQgeW91IGV4cGVjdD8gSSBhbSBj
dXJpb3VzIHdoYXQgdGhpcyB3cml0ZQp0ZWxsIHVzIGFuZCBjYW4gd2UgZW5hYmxlIHJlYWQgb25s
eSBtb2RlIG9uIHRoZXNlIGNvdW50ZXJzPwoKPiAKPiBCeSB0aGUgd2F5LCBoZXJlIGlzIHRoZSBv
dXRwdXQgZnJvbSBib290aW5nIHRoZSBzeXN0ZW0gd2l0aCB0aGlzIHBhdGNoIAo+ICgrIGRlYnVn
IG1lc3NhZ2VzKS4KPiAKPiBbwqDCoCAxNC40MDg4MzRdIHBjaSAwMDAwOjYwOjAwLjI6IEFNRC1W
aTogSU9NTVUgcGVyZm9ybWFuY2UgY291bnRlcnMgCj4gc3VwcG9ydGVkCj4gW8KgwqAgMTQuNDE2
NTI2XSBERUJVRzogaW5pdF9pb21tdV9wZXJmX2N0cjogYW1kX2lvbW11X3BjX3ByZXNlbnQ9MHgx
Cj4gW8KgwqAgMTQuNDI5NjAyXSBwY2kgMDAwMDo0MDowMC4yOiBBTUQtVmk6IElPTU1VIHBlcmZv
cm1hbmNlIGNvdW50ZXJzIAo+IHN1cHBvcnRlZAo+IFvCoMKgIDE0LjQzNzI3NV0gREVCVUc6IGlu
aXRfaW9tbXVfcGVyZl9jdHI6IGFtZF9pb21tdV9wY19wcmVzZW50PTB4MQo+IFvCoMKgIDE0LjQ1
MDMyMF0gcGNpIDAwMDA6MjA6MDAuMjogQU1ELVZpOiBJT01NVSBwZXJmb3JtYW5jZSBjb3VudGVy
cyAKPiBzdXBwb3J0ZWQKPiBbwqDCoCAxNC40NTc5OTFdIERFQlVHOiBpbml0X2lvbW11X3BlcmZf
Y3RyOiBhbWRfaW9tbXVfcGNfcHJlc2VudD0weDEKPiBbwqDCoCAxNC40NzEwNDldIHBjaSAwMDAw
OjAwOjAwLjI6IEFNRC1WaTogSU9NTVUgcGVyZm9ybWFuY2UgY291bnRlcnMgCj4gc3VwcG9ydGVk
Cj4gW8KgwqAgMTQuNDc4NzIyXSBERUJVRzogaW5pdF9pb21tdV9wZXJmX2N0cjogYW1kX2lvbW11
X3BjX3ByZXNlbnQ9MHgxCj4gCj4gQWxzbywgaGVyZSBpcyB0aGUgcGVyZiBhbWRfaW9tbXUgdGVz
dGluZy4KPiAKPiAjIHBlcmYgc3RhdCAtZSAnYW1kX2lvbW11XzAvY21kX3Byb2Nlc3NlZC8sXAo+
ICDCoMKgwqDCoMKgwqDCoCBhbWRfaW9tbXVfMS9jbWRfcHJvY2Vzc2VkLyxcCj4gIMKgwqDCoMKg
wqDCoMKgIGFtZF9pb21tdV8yL2NtZF9wcm9jZXNzZWQvLFwKPiAgwqDCoMKgwqDCoMKgwqAgYW1k
X2lvbW11XzMvY21kX3Byb2Nlc3NlZC8nCj4gCj4gIMKgUGVyZm9ybWFuY2UgY291bnRlciBzdGF0
cyBmb3IgJ3N5c3RlbSB3aWRlJzoKPiAKPiAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAy
MDTCoMKgwqDCoMKgIGFtZF9pb21tdV8wL2NtZF9wcm9jZXNzZWQvCj4gIMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIDDCoMKgwqDCoMKgIGFtZF9pb21tdV8xL2NtZF9wcm9jZXNzZWQv
Cj4gIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgNDcywqDCoMKgwqDCoCBhbWRfaW9tbXVf
Mi9jbWRfcHJvY2Vzc2VkLwo+ICDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAywqDC
oMKgwqDCoCBhbWRfaW9tbXVfMy9jbWRfcHJvY2Vzc2VkLwo+IAo+ICDCoMKgwqDCoMKgIDEwLjE5
ODI1NzcyOCBzZWNvbmRzIHRpbWUgZWxhcHNlZAo+IAo+IFJldmlld2VkLWJ5OiBTdXJhdmVlIFN1
dGhpa3VscGFuaXQgPHN1cmF2ZWUuc3V0aGlrdWxwYW5pdEBhbWQuY29tPgo+IFRlc3RlZC1ieTog
U3VyYXZlZSBTdXRoaWt1bHBhbml0IDxzdXJhdmVlLnN1dGhpa3VscGFuaXRAYW1kLmNvbT4KPiAK
ClRoYW5rcyBmb3IgdGVzdGluZyBpdC4KCi0tIFNodWFoCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5s
aW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFp
bG1hbi9saXN0aW5mby9pb21tdQ==
