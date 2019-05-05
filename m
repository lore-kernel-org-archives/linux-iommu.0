Return-Path: <SRS0=W6tT=TF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E403C04AAA
	for <iommu@archiver.kernel.org>; Sun,  5 May 2019 01:29:53 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18D06206DF
	for <iommu@archiver.kernel.org>; Sun,  5 May 2019 01:29:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18D06206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id C532C42AF;
	Sun,  5 May 2019 01:29:52 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 6975F42A8
	for <iommu@lists.linux-foundation.org>;
	Sun,  5 May 2019 01:29:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 05DB1FD
	for <iommu@lists.linux-foundation.org>;
	Sun,  5 May 2019 01:29:15 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
	by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	04 May 2019 18:29:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,431,1549958400"; d="scan'208";a="146324031"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136])
	([10.239.159.136])
	by fmsmga008.fm.intel.com with ESMTP; 04 May 2019 18:29:11 -0700
Subject: Re: [RFC 2/7] iommu/vt-d: Remove iova handling code from non-dma ops
	path
To: Tom Murphy <tmurphy@arista.com>, iommu@lists.linux-foundation.org
References: <20190504132327.27041-1-tmurphy@arista.com>
	<20190504132327.27041-3-tmurphy@arista.com>
	<bf35694d-3ff4-0df7-0802-b0e87a9a0d47@linux.intel.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <9405cd93-fc16-822e-0b34-4ba2229f176d@linux.intel.com>
Date: Sun, 5 May 2019 09:22:47 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <bf35694d-3ff4-0df7-0802-b0e87a9a0d47@linux.intel.com>
Content-Language: en-US
Cc: Heiko Stuebner <heiko@sntech.de>, kvm@vger.kernel.org,
	Will Deacon <will.deacon@arm.com>, linux-tegra@vger.kernel.org,
	Thierry Reding <thierry.reding@gmail.com>,
	linux-s390@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>, linux-rockchip@lists.infradead.org,
	Kukjin Kim <kgene@kernel.org>,
	Gerald Schaefer <gerald.schaefer@de.ibm.com>,
	Andy Gross <andy.gross@linaro.org>, Marc Zyngier <marc.zyngier@arm.com>,
	linux-arm-msm@vger.kernel.org,
	Alex Williamson <alex.williamson@redhat.com>,
	linux-mediatek@lists.infradead.org,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org,
	David Brown <david.brown@linaro.org>,
	David Woodhouse <dwmw2@infradead.org>,
	linux-kernel@vger.kernel.org, murphyt7@tcd.ie,
	Robin Murphy <robin.murphy@arm.com>
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

SGksCgpPbiA1LzUvMTkgOToxOSBBTSwgTHUgQmFvbHUgd3JvdGU6Cj4gSGksCj4gCj4gT24gNS80
LzE5IDk6MjMgUE0sIFRvbSBNdXJwaHkgdmlhIGlvbW11IHdyb3RlOgo+PiBAQCAtNDE4MSw1OCAr
NDE2OCwzNyBAQCBzdGF0aWMgaW50IGludGVsX2lvbW11X21lbW9yeV9ub3RpZmllcihzdHJ1Y3Qg
Cj4+IG5vdGlmaWVyX2Jsb2NrICpuYiwKPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIHVuc2lnbmVkIGxvbmcgdmFsLCB2b2lkICp2KQo+PiDCoCB7Cj4+
IMKgwqDCoMKgwqAgc3RydWN0IG1lbW9yeV9ub3RpZnkgKm1ocCA9IHY7Cj4+IC3CoMKgwqAgdW5z
aWduZWQgbG9uZyBsb25nIHN0YXJ0LCBlbmQ7Cj4+IC3CoMKgwqAgdW5zaWduZWQgbG9uZyBzdGFy
dF92cGZuLCBsYXN0X3ZwZm47Cj4+ICvCoMKgwqAgdW5zaWduZWQgbG9uZyBzdGFydF92cGZuID0g
bW1fdG9fZG1hX3BmbihtaHAtPnN0YXJ0X3Bmbik7Cj4+ICvCoMKgwqAgdW5zaWduZWQgbG9uZyBs
YXN0X3ZwZm4gPSBtbV90b19kbWFfcGZuKG1ocC0+c3RhcnRfcGZuICsKPj4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgbWhwLT5ucl9wYWdlcyAtIDEpOwo+PiDCoMKgwqDCoMKgIHN3aXRjaCAodmFs
KSB7Cj4+IMKgwqDCoMKgwqAgY2FzZSBNRU1fR09JTkdfT05MSU5FOgo+PiAtwqDCoMKgwqDCoMKg
wqAgc3RhcnQgPSBtaHAtPnN0YXJ0X3BmbiA8PCBQQUdFX1NISUZUOwo+PiAtwqDCoMKgwqDCoMKg
wqAgZW5kID0gKChtaHAtPnN0YXJ0X3BmbiArIG1ocC0+bnJfcGFnZXMpIDw8IFBBR0VfU0hJRlQp
IC0gMTsKPj4gLcKgwqDCoMKgwqDCoMKgIGlmIChpb21tdV9kb21haW5faWRlbnRpdHlfbWFwKHNp
X2RvbWFpbiwgc3RhcnQsIGVuZCkpIHsKPj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcHJfd2Fy
bigiRmFpbGVkIHRvIGJ1aWxkIGlkZW50aXR5IG1hcCBmb3IgWyVsbHgtJWxseF1cbiIsCj4+IC3C
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc3RhcnQsIGVuZCk7Cj4+ICvCoMKgwqDCoMKg
wqDCoCBpZiAoaW9tbXVfZG9tYWluX2lkZW50aXR5X21hcChzaV9kb21haW4sIHN0YXJ0X3ZwZm4s
Cj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBsYXN0X3ZwZm4pKSB7
Cj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHByX3dhcm4oIkZhaWxlZCB0byBidWlsZCBpZGVu
dGl0eSBtYXAgZm9yIFslbHgtJWx4XVxuIiwKPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBzdGFydF92cGZuLCBsYXN0X3ZwZm4pOwo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCByZXR1cm4gTk9USUZZX0JBRDsKPj4gwqDCoMKgwqDCoMKgwqDCoMKgIH0KPj4gwqDCoMKgwqDC
oMKgwqDCoMKgIGJyZWFrOwo+IAo+IEFjdHVhbGx5IHdlIGRvbid0IG5lZWQgdG8gdXBkYXRlIHRo
ZSBzaV9kb21haW4gaWYgaW9tbXUgaGFyZHdhcmUKPiBzdXBwb3J0cyBwYXNzLXRocm91Z2ggbW9k
ZS4gVGhpcyBzaG91bGQgYmUgbWFkZSBpbiBhIHNlcGFyYXRlZCBwYXRjaAo+IGFueXdheS4KCk9o
ISBwbGVhc2UgaWdub3JlIGl0LgoKVGhpcyBjYWxsYmFjayBpcyBvbmx5IHJlZ2lzdGVyZWQgd2hl
biBoYXJkd2FyZSBkb2Vzbid0IHN1cHBvcnQgcGFzcwp0aHJvdWdoIG1vZGUuCgogICAgICAgICBp
ZiAoc2lfZG9tYWluICYmICFod19wYXNzX3Rocm91Z2gpCiAgICAgICAgICAgICAgICAgcmVnaXN0
ZXJfbWVtb3J5X25vdGlmaWVyKCZpbnRlbF9pb21tdV9tZW1vcnlfbmIpOwoKQmVzdCByZWdhcmRz
LApMdSBCYW9sdQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0
dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
