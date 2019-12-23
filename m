Return-Path: <SRS0=R7pc=2N=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD64EC2D0D0
	for <iommu@archiver.kernel.org>; Mon, 23 Dec 2019 11:41:49 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B12920709
	for <iommu@archiver.kernel.org>; Mon, 23 Dec 2019 11:41:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B12920709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 65EDE85E40;
	Mon, 23 Dec 2019 11:41:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sawVsJKlRf5T; Mon, 23 Dec 2019 11:41:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 8EC9585E07;
	Mon, 23 Dec 2019 11:41:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6EF93C1D81;
	Mon, 23 Dec 2019 11:41:48 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5BCB5C0881;
 Mon, 23 Dec 2019 11:41:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 25B83820E4;
 Mon, 23 Dec 2019 11:41:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hlw0FazGmmGa; Mon, 23 Dec 2019 11:41:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 366988791E;
 Mon, 23 Dec 2019 11:41:46 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 23 Dec 2019 03:41:45 -0800
X-IronPort-AV: E=Sophos;i="5.69,347,1571727600"; d="scan'208";a="211530914"
Received: from jnikula-mobl3.fi.intel.com (HELO localhost) ([10.237.66.161])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 23 Dec 2019 03:41:35 -0800
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Robin Murphy <robin.murphy@arm.com>, Tom Murphy <murphyt7@tcd.ie>,
 iommu@lists.linux-foundation.org
Subject: Re: [PATCH 0/8] Convert the intel iommu driver to the dma-iommu api
In-Reply-To: <432d306c-fe9f-75b2-f0f7-27698f1467ad@arm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20191221150402.13868-1-murphyt7@tcd.ie>
 <87blrzwcn8.fsf@intel.com> <432d306c-fe9f-75b2-f0f7-27698f1467ad@arm.com>
Date: Mon, 23 Dec 2019 13:41:33 +0200
Message-ID: <87o8vzuv4i.fsf@intel.com>
MIME-Version: 1.0
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

T24gTW9uLCAyMyBEZWMgMjAxOSwgUm9iaW4gTXVycGh5IDxyb2Jpbi5tdXJwaHlAYXJtLmNvbT4g
d3JvdGU6Cj4gT24gMjAxOS0xMi0yMyAxMDozNyBhbSwgSmFuaSBOaWt1bGEgd3JvdGU6Cj4+IE9u
IFNhdCwgMjEgRGVjIDIwMTksIFRvbSBNdXJwaHkgPG11cnBoeXQ3QHRjZC5pZT4gd3JvdGU6Cj4+
PiBUaGlzIHBhdGNoc2V0IGNvbnZlcnRzIHRoZSBpbnRlbCBpb21tdSBkcml2ZXIgdG8gdGhlIGRt
YS1pb21tdSBhcGkuCj4+Pgo+Pj4gV2hpbGUgY29udmVydGluZyB0aGUgZHJpdmVyIEkgZXhwb3Nl
ZCBhIGJ1ZyBpbiB0aGUgaW50ZWwgaTkxNSBkcml2ZXIKPj4+IHdoaWNoIGNhdXNlcyBhIGh1Z2Ug
YW1vdW50IG9mIGFydGlmYWN0cyBvbiB0aGUgc2NyZWVuIG9mIG15Cj4+PiBsYXB0b3AuIFlvdSBj
YW4gc2VlIGEgcGljdHVyZSBvZiBpdCBoZXJlOgo+Pj4gaHR0cHM6Ly9naXRodWIuY29tL3BpcHB5
MzYwL2tlcm5lbFBhdGNoZXMvYmxvYi9tYXN0ZXIvSU1HXzIwMTkxMjE5XzIyNTkyMi5qcGcKPj4+
Cj4+PiBUaGlzIGlzc3VlIGlzIG1vc3QgbGlrZWx5IGluIHRoZSBpOTE1IGRyaXZlciBhbmQgaXMg
bW9zdCBsaWtlbHkgY2F1c2VkCj4+PiBieSB0aGUgZHJpdmVyIG5vdCByZXNwZWN0aW5nIHRoZSBy
ZXR1cm4gdmFsdWUgb2YgdGhlCj4+PiBkbWFfbWFwX29wczo6bWFwX3NnIGZ1bmN0aW9uLiBZb3Ug
Y2FuIHNlZSB0aGUgZHJpdmVyIGlnbm9yaW5nIHRoZQo+Pj4gcmV0dXJuIHZhbHVlIGhlcmU6Cj4+
PiBodHRwczovL2dpdGh1Yi5jb20vdG9ydmFsZHMvbGludXgvYmxvYi83ZTAxNjViMmYxYTkxMmEw
NmUzODFlOTFmMGY0ZTQ5NWY0YWMzNzM2L2RyaXZlcnMvZ3B1L2RybS9pOTE1L2dlbS9pOTE1X2dl
bV9kbWFidWYuYyNMNTEKPj4+Cj4+PiBQcmV2aW91c2x5IHRoaXMgZGlkbuKAmXQgY2F1c2UgaXNz
dWVzIGJlY2F1c2UgdGhlIGludGVsIG1hcF9zZyBhbHdheXMKPj4+IHJldHVybmVkIHRoZSBzYW1l
IG51bWJlciBvZiBlbGVtZW50cyBhcyB0aGUgaW5wdXQgc2NhdHRlciBnYXRoZXIgbGlzdAo+Pj4g
YnV0IHdpdGggdGhlIGNoYW5nZSB0byB0aGlzIGRtYS1pb21tdSBhcGkgdGhpcyBpcyBubyBsb25n
ZXIgdGhlCj4+PiBjYXNlLiBJIHdhc27igJl0IGFibGUgdG8gdHJhY2sgdGhlIGJ1ZyBkb3duIHRv
IGEgc3BlY2lmaWMgbGluZSBvZiBjb2RlCj4+PiB1bmZvcnR1bmF0ZWx5Lgo+Pj4KPj4+IENvdWxk
IHNvbWVvbmUgZnJvbSB0aGUgaW50ZWwgdGVhbSBsb29rIGF0IHRoaXM/Cj4+IAo+PiBMZXQgbWUg
Z2V0IHRoaXMgc3RyYWlnaHQuIFRoZXJlIGlzIGN1cnJlbnQgQVBJIHRoYXQgb24gc3VjY2VzcyBh
bHdheXMKPj4gcmV0dXJucyB0aGUgc2FtZSBudW1iZXIgb2YgZWxlbWVudHMgYXMgdGhlIGlucHV0
IHNjYXR0ZXIgZ2F0aGVyCj4+IGxpc3QuIFlvdSBwcm9wb3NlIHRvIGNoYW5nZSB0aGUgQVBJIHNv
IHRoYXQgdGhpcyBpcyBubyBsb25nZXIgdGhlIGNhc2U/Cj4KPiBObywgdGhlIEFQSSBmb3IgZG1h
X21hcF9zZygpIGhhcyBhbHdheXMgYmVlbiB0aGF0IGl0IG1heSByZXR1cm4gZmV3ZXIgCj4gRE1B
IHNlZ21lbnRzIHRoYW4gbmVudHMgLSBzZWUgRG9jdW1lbnRhdGlvbi9ETUEtQVBJLnR4dCAoYW5k
IG90aGVyd2lzZSwgCj4gdGhlIHJldHVybiB2YWx1ZSB3b3VsZCBzdXJlbHkgYmUgYSBzaW1wbGUg
c3VjY2Vzcy9mYWlsIGNvbmRpdGlvbikuIAo+IFJlbHlpbmcgb24gYSBwYXJ0aWN1bGFyIGltcGxl
bWVudGF0aW9uIGJlaGF2aW91ciBoYXMgbmV2ZXIgYmVlbiBzdHJpY3RseSAKPiBjb3JyZWN0LCBl
dmVuIGlmIGl0IGRvZXMgaGFwcGVuIHRvIGJlIGEgdmVyeSBjb21tb24gYmVoYXZpb3VyLgo+Cj4+
IEEgcXVpY2sgY2hlY2sgb2YgdmFyaW91cyBkbWFfbWFwX3NnKCkgY2FsbHMgaW4gdGhlIGtlcm5l
bCBzZWVtcyB0bwo+PiBpbmRpY2F0ZSBjaGVja2luZyBmb3IgMCBmb3IgZXJyb3JzIGFuZCB0aGVu
IGlnbm9yaW5nIHRoZSBub24temVybyByZXR1cm4KPj4gaXMgYSBjb21tb24gcGF0dGVybi4gQXJl
IHlvdSBzdXJlIGl0J3Mgb2theSB0byBtYWtlIHRoZSBjaGFuZ2UgeW91J3JlCj4+IHByb3Bvc2lu
Zz8KPgo+IFZhcmlvdXMgY29kZSB1c2VzIHRyaWNrcyBsaWtlIGp1c3QgaXRlcmF0aW5nIHRoZSBt
YXBwZWQgbGlzdCB1bnRpbCB0aGUgCj4gZmlyc3Qgc2VnbWVudCB3aXRoIHplcm8gc2dfZG1hX2xl
bigpLiBPdGhlcnMgbWF5IHdlbGwgc2ltcGx5IGhhdmUgYnVncy4KClRoYW5rcyBmb3IgdGhlIGNs
YXJpZmljYXRpb24uCgpCUiwKSmFuaS4KCj4KPiBSb2Jpbi4KPgo+PiBBbnl3YXksIGR1ZSB0byB0
aGUgdGltZSBvZiB5ZWFyIGFuZCBhbGwsIEknZCBsaWtlIHRvIGFzayB5b3UgdG8gZmlsZSBhCj4+
IGJ1ZyBhZ2FpbnN0IGk5MTUgYXQgWzFdIHNvIHRoaXMgaXMgbm90IGZvcmdvdHRlbiwgYW5kIHBs
ZWFzZSBsZXQncyBub3QKPj4gbWVyZ2UgdGhlIGNoYW5nZXMgYmVmb3JlIHRoaXMgaXMgcmVzb2x2
ZWQuCj4+IAo+PiAKPj4gVGhhbmtzLAo+PiBKYW5pLgo+PiAKPj4gCj4+IFsxXSBodHRwczovL2dp
dGxhYi5mcmVlZGVza3RvcC5vcmcvZHJtL2ludGVsL2lzc3Vlcy9uZXcKPj4gCj4+IAoKLS0gCkph
bmkgTmlrdWxhLCBJbnRlbCBPcGVuIFNvdXJjZSBHcmFwaGljcyBDZW50ZXIKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0Cmlv
bW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0
aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
