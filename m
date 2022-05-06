Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4838C433F5
	for <iommu@archiver.kernel.org>; Fri,  6 May 2022 01:50:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 48D10415DD;
	Fri,  6 May 2022 01:50:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id neG3zSKYWDhR; Fri,  6 May 2022 01:50:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id B1F87410E6;
	Fri,  6 May 2022 01:50:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 924E2C0032;
	Fri,  6 May 2022 01:50:02 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 794E2C002D
 for <iommu@lists.linux-foundation.org>; Fri,  6 May 2022 01:50:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6F03D83FAE
 for <iommu@lists.linux-foundation.org>; Fri,  6 May 2022 01:50:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id F15u_IuSSJTX for <iommu@lists.linux-foundation.org>;
 Fri,  6 May 2022 01:50:00 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com
 [IPv6:2607:f8b0:4864:20::630])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7354483FA7
 for <iommu@lists.linux-foundation.org>; Fri,  6 May 2022 01:50:00 +0000 (UTC)
Received: by mail-pl1-x630.google.com with SMTP id s14so6037994plk.8
 for <iommu@lists.linux-foundation.org>; Thu, 05 May 2022 18:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-transfer-encoding:content-language;
 bh=qiHKrawCSEYS4sdc87s3HzBAfn4f+VmuSVImw7uTP4A=;
 b=F98Lin7aPfGaSoPtPZEE8s+NM6NRh+0LKMImQjIgs0Zkhyv4XBwnzeLr8M9xrKogiu
 MwPofz7GmCqWLwIYjwHHM2U9nChNxdi8IKbXrgyry5F8/nwQUIoIBTiLwepu5hFc9h9S
 Buk/6mnCToI+v5w5kHbUsgiq2ieqxGS0uF2/RfcC0fN0dRrJN39t9jiWC/r1OBOKg8X6
 TCEfurvSr2eUBAf49iIySJ3ketcUOPXYYAa+F/0aKBAugNQt+5rCgD/LnXRlsS01F3Wf
 76QjYjIAzAZ5Ha2+ba3B+G6D3MdQ0RXu7hi6jiAKGLfCOZJGhWUe50K3DqxQP9z33Je+
 LLlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=qiHKrawCSEYS4sdc87s3HzBAfn4f+VmuSVImw7uTP4A=;
 b=eYQ30rAtsGgfTAURmErj+TS8E0X++TMD77kfoKO4cs2CxERwb1a38JINLeL2Nts7Ka
 x/rWNo+80bsWANngZMC58uyfQSVKtLrEpwbeYUiWEmVr6eQU/IUgf9fnB561SE4C/uVE
 dcthO2rvKEvK/s5hUrnQAOcsFLcU2CgqVf++rl7fB9HPC0ds8VCWWaKGBRlpsDdLINFJ
 8L6QMTcCAbhlealoNVVLIBCpuouETxT7oxPtg1lesoRNTlzMRSkDPoqpyA+kTt3Sfm/x
 SvWKmm+dsDVPUSIYXTqyekh0MZAMSuHyKwPrdqHAbnscTT/R6u86RmRF1yMA5Ol3PiNI
 Odpw==
X-Gm-Message-State: AOAM531Tc37UmdavjbF9xOjbMsuXWs52W9LSGTiEBbgHxhE47qqEiZbU
 TAcI83u+506MdypxNW6syrY/e/5SNDsN8Q==
X-Google-Smtp-Source: ABdhPJyputnUi3a7shAhiw4xAnFex5EGDJvGRHdrQg+0QCuQstO9afbIuS5G8cxY4+jApO0x5q6rZw==
X-Received: by 2002:a17:90b:1651:b0:1dc:aec3:c17 with SMTP id
 il17-20020a17090b165100b001dcaec30c17mr1405190pjb.43.1651801799549; 
 Thu, 05 May 2022 18:49:59 -0700 (PDT)
Received: from [10.44.0.6] ([94.177.118.48]) by smtp.gmail.com with ESMTPSA id
 e5-20020a636905000000b003aaf27b5ceasm2042378pgc.1.2022.05.05.18.49.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 May 2022 18:49:58 -0700 (PDT)
Subject: Re: [PATCH v2] iommu/sva: Fix PASID use-after-free issue
To: Fenghua Yu <fenghua.yu@intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Tony Luck <tony.luck@intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>,
 Ravi V Shankar <ravi.v.shankar@intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@kernel.org>,
 x86 <x86@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>,
 iommu@lists.linux-foundation.org
References: <20220428180041.806809-1-fenghua.yu@intel.com>
 <8f50c673-fe92-3c42-993d-43e65fc7235c@linaro.org>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Message-ID: <da5eafcc-1cb0-07fc-aa0d-0dccb8b8875a@linaro.org>
Date: Fri, 6 May 2022 09:49:50 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <8f50c673-fe92-3c42-993d-43e65fc7235c@linaro.org>
Content-Language: en-US
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

CgpPbiAyMDIyLzQvMjkg5LiK5Y2IOTozOSwgWmhhbmdmZWkgR2FvIHdyb3RlOgo+Cj4KPiBPbiAy
MDIyLzQvMjkg5LiK5Y2IMjowMCwgRmVuZ2h1YSBZdSB3cm90ZToKPj4gVGhlIFBBU0lEIGlzIGJl
aW5nIGZyZWVkIHRvbyBlYXJseS7CoCBJdCBuZWVkcyB0byBzdGF5IGFyb3VuZCB1bnRpbCBhZnRl
cgo+PiBkZXZpY2UgZHJpdmVycyB0aGF0IG1pZ2h0IGJlIHVzaW5nIGl0IGhhdmUgaGFkIGEgY2hh
bmNlIHRvIGNsZWFyIGl0IG91dAo+PiBvZiB0aGUgaGFyZHdhcmUuCj4+Cj4+IEFzIGEgcmVtaW5k
ZXI6Cj4+Cj4+IG1tZ2V0KCkgL21tcHV0KCnCoCByZWZjb3VudCB0aGUgbW0ncyBhZGRyZXNzIHNw
YWNlCj4+IG1tZ3JhYigpL21tZHJvcCgpIHJlZmNvdW50IHRoZSBtbSBpdHNlbGYKPj4KPj4gVGhl
IFBBU0lEIGlzIGN1cnJlbnRseSB0aWVkIHRvIHRoZSBsaWZlIG9mIHRoZSBtbSdzIGFkZHJlc3Mg
c3BhY2UgYW5kCj4+IGZyZWVkIGluIF9fbW1wdXQoKS7CoCBUaGlzIG1ha2VzIGxvZ2ljYWwgc2Vu
c2UgYmVjYXVzZSB0aGUgUEFTSUQgY2FuJ3QgYmUKPj4gdXNlZCBvbmNlIHRoZSBhZGRyZXNzIHNw
YWNlIGlzIGdvbmUuCj4+Cj4+IEJ1dCwgdGhpcyBtaXNzZXMgYW4gaW1wb3J0YW50IHBvaW50OiBl
dmVuIGFmdGVyIHRoZSBhZGRyZXNzIHNwYWNlIGlzCj4+IGdvbmUsIHRoZSBQQVNJRCB3aWxsIHN0
aWxsIGJlIHByb2dyYW1tZWQgaW50byBhIGRldmljZS7CoCBEZXZpY2UgZHJpdmVycwo+PiBtaWdo
dCwgZm9yIGluc3RhbmNlLCBzdGlsbCBuZWVkIHRvIGZsdXNoIG9wZXJhdGlvbnMgdGhhdCBhcmUg
b3V0c3RhbmRpbmcKPj4gYW5kIG5lZWQgdG8gdXNlIHRoYXQgUEFTSUQuwqAgVGhleSBkbyB0aGlz
IGF0IGZpbGUtPnJlbGVhc2UoKSB0aW1lLgo+Pgo+PiBEZXZpY2UgZHJpdmVycyBjYWxsIHRoZSBJ
T01NVSBkcml2ZXIgdG8gaG9sZCBhIHJlZmVyZW5jZSBvbiB0aGUgbW0gCj4+IGl0c2VsZgo+PiBh
bmQgZHJvcCBpdCBhdCBmaWxlLT5yZWxlYXNlKCkgdGltZS7CoCBCdXQsIHRoZSBJT01NVSBkcml2
ZXIgaG9sZHMgYQo+PiByZWZlcmVuY2Ugb24gdGhlIG1tIGl0c2VsZiwgbm90IHRoZSBhZGRyZXNz
IHNwYWNlLsKgIFRoZSBhZGRyZXNzIHNwYWNlCj4+IChhbmQgdGhlIFBBU0lEKSBpcyBsb25nIGdv
bmUgYnkgdGhlIHRpbWUgdGhlIGRyaXZlciB0cmllcyB0byBjbGVhbiB1cC4KPj4gVGhpcyBpcyBl
ZmZlY3RpdmVseSBhIHVzZS1hZnRlci1mcmVlIGJ1ZyBvbiB0aGUgUEFTSUQuCj4+Cj4+IFRvIGZp
eCB0aGlzLCBtb3ZlIHRoZSBQQVNJRCBmcmVlIG9wZXJhdGlvbiBmcm9tIF9fbW1wdXQoKSB0byBf
X21tZHJvcCgpLgo+PiBUaGlzIGVuc3VyZXMgdGhhdCB0aGUgSU9NTVUgZHJpdmVyJ3MgZXhpc3Rp
bmcgbW1ncmFiKCkga2VlcHMgdGhlIFBBU0lECj4+IGFsbG9jYXRlZCB1bnRpbCBpdCBkcm9wcyBp
dHMgbW0gcmVmZXJlbmNlLgo+Pgo+PiBGaXhlczogNzAxZmFjNDAzODRmICgiaW9tbXUvc3ZhOiBB
c3NpZ24gYSBQQVNJRCB0byBtbSBvbiBQQVNJRCAKPj4gYWxsb2NhdGlvbiBhbmQgZnJlZSBpdCBv
biBtbSBleGl0IikKPj4KPj4gUmVwb3J0ZWQtYnk6IFpoYW5nZmVpIEdhbyA8emhhbmdmZWkuZ2Fv
QGZveG1haWwuY29tPgo+PiBUZXN0ZWQtYnk6IFpoYW5nZmVpIEdhbyA8emhhbmdmZWkuZ2FvQGZv
eG1haWwuY29tPgo+Cj4gVGVzdGVkLWJ5OiBaaGFuZ2ZlaSBHYW8gPHpoYW5nZmVpLmdhb0BsaW5h
cm8ub3JnPgo+Cj4gVXNlIHRoZSBmb3JtYWwgZW1haWwsIHRoYW5rcwo+Cj4+IFN1Z2dlc3RlZC1i
eTogSmVhbi1QaGlsaXBwZSBCcnVja2VyIDxqZWFuLXBoaWxpcHBlQGxpbmFyby5vcmc+Cj4+IFN1
Z2dlc3RlZC1ieTogSmFjb2IgUGFuIDxqYWNvYi5qdW4ucGFuQGxpbnV4LmludGVsLmNvbT4KPj4g
UmV2aWV3ZWQtYnk6IEplYW4tUGhpbGlwcGUgQnJ1Y2tlciA8amVhbi1waGlsaXBwZUBsaW5hcm8u
b3JnPgo+PiBTaWduZWQtb2ZmLWJ5OiBGZW5naHVhIFl1IDxmZW5naHVhLnl1QGludGVsLmNvbT4K
CkhpLAoKV2lsbCB0aGlzIGJlIHRha2VuIGZvciA1LjE4PwoKVGhhbmtzCgo+PiAtLS0KPj4KPj4g
djI6Cj4+IC0gRGF2ZSBIYW5zZW4gcmV3cml0ZXMgdGhlIGNoYW5nZSBsb2cuCj4+IC0gQWRkIFRl
c3RlZC1ieTogWmhhbmdmZWkgR2FvIDx6aGFuZ2ZlaS5nYW9AZm94bWFpbC5jb20+Cj4+IC0gQWRk
IFJldmlld2VkLWJ5OiBKZWFuLVBoaWxpcHBlIEJydWNrZXIgPGplYW4tcGhpbGlwcGVAbGluYXJv
Lm9yZz4KPj4KPj4gVGhlIG9yaWdpbmFsIHBhdGNoIHdhcyBwb3N0ZWQgYW5kIGRpc2N1c3NlZCBp
bjoKPj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC9ZbWR6RkZ4N2ZONTg2amNmQGZ5dTEu
c2MuaW50ZWwuY29tLwo+Pgo+PiDCoCBrZXJuZWwvZm9yay5jIHwgMiArLQo+PiDCoCAxIGZpbGUg
Y2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKPj4KPj4gZGlmZiAtLWdpdCBh
L2tlcm5lbC9mb3JrLmMgYi9rZXJuZWwvZm9yay5jCj4+IGluZGV4IDk3OTY4OTc1NjBhYi4uMzVh
M2JlZmYxNDBiIDEwMDY0NAo+PiAtLS0gYS9rZXJuZWwvZm9yay5jCj4+ICsrKyBiL2tlcm5lbC9m
b3JrLmMKPj4gQEAgLTc5Miw2ICs3OTIsNyBAQCB2b2lkIF9fbW1kcm9wKHN0cnVjdCBtbV9zdHJ1
Y3QgKm1tKQo+PiDCoMKgwqDCoMKgIG1tdV9ub3RpZmllcl9zdWJzY3JpcHRpb25zX2Rlc3Ryb3ko
bW0pOwo+PiDCoMKgwqDCoMKgIGNoZWNrX21tKG1tKTsKPj4gwqDCoMKgwqDCoCBwdXRfdXNlcl9u
cyhtbS0+dXNlcl9ucyk7Cj4+ICvCoMKgwqAgbW1fcGFzaWRfZHJvcChtbSk7Cj4+IMKgwqDCoMKg
wqAgZnJlZV9tbShtbSk7Cj4+IMKgIH0KPj4gwqAgRVhQT1JUX1NZTUJPTF9HUEwoX19tbWRyb3Ap
Owo+PiBAQCAtMTE5MCw3ICsxMTkxLDYgQEAgc3RhdGljIGlubGluZSB2b2lkIF9fbW1wdXQoc3Ry
dWN0IG1tX3N0cnVjdCAqbW0pCj4+IMKgwqDCoMKgwqAgfQo+PiDCoMKgwqDCoMKgIGlmIChtbS0+
YmluZm10KQo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgbW9kdWxlX3B1dChtbS0+YmluZm10LT5tb2R1
bGUpOwo+PiAtwqDCoMKgIG1tX3Bhc2lkX2Ryb3AobW0pOwo+PiDCoMKgwqDCoMKgIG1tZHJvcCht
bSk7Cj4+IMKgIH0KPgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3Jn
Cmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
