Return-Path: <SRS0=R7pc=2N=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65A32C2D0D0
	for <iommu@archiver.kernel.org>; Mon, 23 Dec 2019 11:29:38 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30E4120715
	for <iommu@archiver.kernel.org>; Mon, 23 Dec 2019 11:29:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30E4120715
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 0382920500;
	Mon, 23 Dec 2019 11:29:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IzPaqC8qeIlL; Mon, 23 Dec 2019 11:29:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id AC453204F3;
	Mon, 23 Dec 2019 11:29:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 96E03C1D81;
	Mon, 23 Dec 2019 11:29:35 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D1E6EC0881;
 Mon, 23 Dec 2019 11:29:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id C9EEF86447;
 Mon, 23 Dec 2019 11:29:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ci+IkLoh+UDd; Mon, 23 Dec 2019 11:29:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by whitealder.osuosl.org (Postfix) with ESMTP id 9304E863CC;
 Mon, 23 Dec 2019 11:29:32 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9F7EC328;
 Mon, 23 Dec 2019 03:29:31 -0800 (PST)
Received: from [192.168.1.123] (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EE2493F68F;
 Mon, 23 Dec 2019 03:29:25 -0800 (PST)
Subject: Re: [PATCH 0/8] Convert the intel iommu driver to the dma-iommu api
To: Jani Nikula <jani.nikula@linux.intel.com>, Tom Murphy <murphyt7@tcd.ie>,
 iommu@lists.linux-foundation.org
References: <20191221150402.13868-1-murphyt7@tcd.ie> <87blrzwcn8.fsf@intel.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <432d306c-fe9f-75b2-f0f7-27698f1467ad@arm.com>
Date: Mon, 23 Dec 2019 11:29:17 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <87blrzwcn8.fsf@intel.com>
Content-Language: en-GB
Cc: Heiko Stuebner <heiko@sntech.de>, kvm@vger.kernel.org,
 David Airlie <airlied@linux.ie>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 dri-devel@lists.freedesktop.org, Bjorn Andersson <bjorn.andersson@linaro.org>,
 linux-tegra@vger.kernel.org, Julien Grall <julien.grall@arm.com>,
 Thierry Reding <thierry.reding@gmail.com>, Will Deacon <will@kernel.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 linux-samsung-soc@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
 Krzysztof Kozlowski <krzk@kernel.org>, Jonathan Hunter <jonathanh@nvidia.com>,
 linux-rockchip@lists.infradead.org, Andy Gross <agross@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, intel-gfx@lists.freedesktop.org,
 Alex Williamson <alex.williamson@redhat.com>,
 linux-mediatek@lists.infradead.org, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 virtualization@lists.linux-foundation.org,
 Gerald Schaefer <gerald.schaefer@de.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, linux-kernel@vger.kernel.org,
 Kukjin Kim <kgene@kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
 David Woodhouse <dwmw2@infradead.org>
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

T24gMjAxOS0xMi0yMyAxMDozNyBhbSwgSmFuaSBOaWt1bGEgd3JvdGU6Cj4gT24gU2F0LCAyMSBE
ZWMgMjAxOSwgVG9tIE11cnBoeSA8bXVycGh5dDdAdGNkLmllPiB3cm90ZToKPj4gVGhpcyBwYXRj
aHNldCBjb252ZXJ0cyB0aGUgaW50ZWwgaW9tbXUgZHJpdmVyIHRvIHRoZSBkbWEtaW9tbXUgYXBp
Lgo+Pgo+PiBXaGlsZSBjb252ZXJ0aW5nIHRoZSBkcml2ZXIgSSBleHBvc2VkIGEgYnVnIGluIHRo
ZSBpbnRlbCBpOTE1IGRyaXZlcgo+PiB3aGljaCBjYXVzZXMgYSBodWdlIGFtb3VudCBvZiBhcnRp
ZmFjdHMgb24gdGhlIHNjcmVlbiBvZiBteQo+PiBsYXB0b3AuIFlvdSBjYW4gc2VlIGEgcGljdHVy
ZSBvZiBpdCBoZXJlOgo+PiBodHRwczovL2dpdGh1Yi5jb20vcGlwcHkzNjAva2VybmVsUGF0Y2hl
cy9ibG9iL21hc3Rlci9JTUdfMjAxOTEyMTlfMjI1OTIyLmpwZwo+Pgo+PiBUaGlzIGlzc3VlIGlz
IG1vc3QgbGlrZWx5IGluIHRoZSBpOTE1IGRyaXZlciBhbmQgaXMgbW9zdCBsaWtlbHkgY2F1c2Vk
Cj4+IGJ5IHRoZSBkcml2ZXIgbm90IHJlc3BlY3RpbmcgdGhlIHJldHVybiB2YWx1ZSBvZiB0aGUK
Pj4gZG1hX21hcF9vcHM6Om1hcF9zZyBmdW5jdGlvbi4gWW91IGNhbiBzZWUgdGhlIGRyaXZlciBp
Z25vcmluZyB0aGUKPj4gcmV0dXJuIHZhbHVlIGhlcmU6Cj4+IGh0dHBzOi8vZ2l0aHViLmNvbS90
b3J2YWxkcy9saW51eC9ibG9iLzdlMDE2NWIyZjFhOTEyYTA2ZTM4MWU5MWYwZjRlNDk1ZjRhYzM3
MzYvZHJpdmVycy9ncHUvZHJtL2k5MTUvZ2VtL2k5MTVfZ2VtX2RtYWJ1Zi5jI0w1MQo+Pgo+PiBQ
cmV2aW91c2x5IHRoaXMgZGlkbuKAmXQgY2F1c2UgaXNzdWVzIGJlY2F1c2UgdGhlIGludGVsIG1h
cF9zZyBhbHdheXMKPj4gcmV0dXJuZWQgdGhlIHNhbWUgbnVtYmVyIG9mIGVsZW1lbnRzIGFzIHRo
ZSBpbnB1dCBzY2F0dGVyIGdhdGhlciBsaXN0Cj4+IGJ1dCB3aXRoIHRoZSBjaGFuZ2UgdG8gdGhp
cyBkbWEtaW9tbXUgYXBpIHRoaXMgaXMgbm8gbG9uZ2VyIHRoZQo+PiBjYXNlLiBJIHdhc27igJl0
IGFibGUgdG8gdHJhY2sgdGhlIGJ1ZyBkb3duIHRvIGEgc3BlY2lmaWMgbGluZSBvZiBjb2RlCj4+
IHVuZm9ydHVuYXRlbHkuCj4+Cj4+IENvdWxkIHNvbWVvbmUgZnJvbSB0aGUgaW50ZWwgdGVhbSBs
b29rIGF0IHRoaXM/Cj4gCj4gTGV0IG1lIGdldCB0aGlzIHN0cmFpZ2h0LiBUaGVyZSBpcyBjdXJy
ZW50IEFQSSB0aGF0IG9uIHN1Y2Nlc3MgYWx3YXlzCj4gcmV0dXJucyB0aGUgc2FtZSBudW1iZXIg
b2YgZWxlbWVudHMgYXMgdGhlIGlucHV0IHNjYXR0ZXIgZ2F0aGVyCj4gbGlzdC4gWW91IHByb3Bv
c2UgdG8gY2hhbmdlIHRoZSBBUEkgc28gdGhhdCB0aGlzIGlzIG5vIGxvbmdlciB0aGUgY2FzZT8K
Ck5vLCB0aGUgQVBJIGZvciBkbWFfbWFwX3NnKCkgaGFzIGFsd2F5cyBiZWVuIHRoYXQgaXQgbWF5
IHJldHVybiBmZXdlciAKRE1BIHNlZ21lbnRzIHRoYW4gbmVudHMgLSBzZWUgRG9jdW1lbnRhdGlv
bi9ETUEtQVBJLnR4dCAoYW5kIG90aGVyd2lzZSwgCnRoZSByZXR1cm4gdmFsdWUgd291bGQgc3Vy
ZWx5IGJlIGEgc2ltcGxlIHN1Y2Nlc3MvZmFpbCBjb25kaXRpb24pLiAKUmVseWluZyBvbiBhIHBh
cnRpY3VsYXIgaW1wbGVtZW50YXRpb24gYmVoYXZpb3VyIGhhcyBuZXZlciBiZWVuIHN0cmljdGx5
IApjb3JyZWN0LCBldmVuIGlmIGl0IGRvZXMgaGFwcGVuIHRvIGJlIGEgdmVyeSBjb21tb24gYmVo
YXZpb3VyLgoKPiBBIHF1aWNrIGNoZWNrIG9mIHZhcmlvdXMgZG1hX21hcF9zZygpIGNhbGxzIGlu
IHRoZSBrZXJuZWwgc2VlbXMgdG8KPiBpbmRpY2F0ZSBjaGVja2luZyBmb3IgMCBmb3IgZXJyb3Jz
IGFuZCB0aGVuIGlnbm9yaW5nIHRoZSBub24temVybyByZXR1cm4KPiBpcyBhIGNvbW1vbiBwYXR0
ZXJuLiBBcmUgeW91IHN1cmUgaXQncyBva2F5IHRvIG1ha2UgdGhlIGNoYW5nZSB5b3UncmUKPiBw
cm9wb3Npbmc/CgpWYXJpb3VzIGNvZGUgdXNlcyB0cmlja3MgbGlrZSBqdXN0IGl0ZXJhdGluZyB0
aGUgbWFwcGVkIGxpc3QgdW50aWwgdGhlIApmaXJzdCBzZWdtZW50IHdpdGggemVybyBzZ19kbWFf
bGVuKCkuIE90aGVycyBtYXkgd2VsbCBzaW1wbHkgaGF2ZSBidWdzLgoKUm9iaW4uCgo+IEFueXdh
eSwgZHVlIHRvIHRoZSB0aW1lIG9mIHllYXIgYW5kIGFsbCwgSSdkIGxpa2UgdG8gYXNrIHlvdSB0
byBmaWxlIGEKPiBidWcgYWdhaW5zdCBpOTE1IGF0IFsxXSBzbyB0aGlzIGlzIG5vdCBmb3Jnb3R0
ZW4sIGFuZCBwbGVhc2UgbGV0J3Mgbm90Cj4gbWVyZ2UgdGhlIGNoYW5nZXMgYmVmb3JlIHRoaXMg
aXMgcmVzb2x2ZWQuCj4gCj4gCj4gVGhhbmtzLAo+IEphbmkuCj4gCj4gCj4gWzFdIGh0dHBzOi8v
Z2l0bGFiLmZyZWVkZXNrdG9wLm9yZy9kcm0vaW50ZWwvaXNzdWVzL25ldwo+IAo+IApfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxp
c3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZv
dW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
