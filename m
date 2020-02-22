Return-Path: <SRS0=f0z+=4K=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92932C35672
	for <iommu@archiver.kernel.org>; Sat, 22 Feb 2020 13:08:12 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CB3E20684
	for <iommu@archiver.kernel.org>; Sat, 22 Feb 2020 13:08:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CB3E20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 30D9086456;
	Sat, 22 Feb 2020 13:08:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jyh5NDVLv1cT; Sat, 22 Feb 2020 13:08:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id EAAB083885;
	Sat, 22 Feb 2020 13:08:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DBB02C1D81;
	Sat, 22 Feb 2020 13:08:10 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BC14BC013E
 for <iommu@lists.linux-foundation.org>; Sat, 22 Feb 2020 13:08:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id B1A142039B
 for <iommu@lists.linux-foundation.org>; Sat, 22 Feb 2020 13:08:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5LeyL60kntb5 for <iommu@lists.linux-foundation.org>;
 Sat, 22 Feb 2020 13:08:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by silver.osuosl.org (Postfix) with ESMTPS id EB24320363
 for <iommu@lists.linux-foundation.org>; Sat, 22 Feb 2020 13:08:08 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 22 Feb 2020 05:08:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,471,1574150400"; d="scan'208";a="316322136"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.212.230])
 ([10.254.212.230])
 by orsmga001.jf.intel.com with ESMTP; 22 Feb 2020 05:08:05 -0800
Subject: Re: [PATCH v2] iommu/vt-d: Fix a bug in intel_iommu_iova_to_phys()
 for huge page
To: Yonghyun Hwang <yonghyun@google.com>,
 David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>
References: <20200220194431.169629-1-yonghyun@google.com>
 <795521c0-af5b-36a1-e05c-324377d04d8a@linux.intel.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <d3923eac-08e4-2938-6e94-2d3806579df5@linux.intel.com>
Date: Sat, 22 Feb 2020 21:08:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <795521c0-af5b-36a1-e05c-324377d04d8a@linux.intel.com>
Content-Language: en-US
Cc: Havard Skinnemoen <hskinnemoen@google.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Moritz Fischer <mdf@kernel.org>,
 Deepa Dinamani <deepadinamani@google.com>
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

SGksCgpPbiAyMDIwLzIvMjIgMjE6MDUsIEx1IEJhb2x1IHdyb3RlOgo+IEhpLAo+IAo+IE9uIDIw
MjAvMi8yMSAzOjQ0LCBZb25naHl1biBId2FuZyB3cm90ZToKPj4gaW50ZWxfaW9tbXVfaW92YV90
b19waHlzKCkgaGFzIGEgYnVnIHdoZW4gaXQgdHJhbnNsYXRlcyBhbiBJT1ZBIGZvciBhIAo+PiBo
dWdlCj4+IHBhZ2Ugb250byBpdHMgY29ycmVzcG9uZGluZyBwaHlzaWNhbCBhZGRyZXNzLiBUaGlz
IGNvbW1pdCBmaXhlcyB0aGUgCj4+IGJ1ZyBieQo+PiBhY2NvbW9kYXRpbmcgdGhlIGxldmVsIG9m
IHBhZ2UgZW50cnkgZm9yIHRoZSBJT1ZBIGFuZCBhZGRzIElPVkEncyBsb3dlcgo+PiBhZGRyZXNz
IHRvIHRoZSBwaHlzaWNhbCBhZGRyZXNzLgo+Pgo+PiBTaWduZWQtb2ZmLWJ5OiBZb25naHl1biBI
d2FuZyA8eW9uZ2h5dW5AZ29vZ2xlLmNvbT4KPiAKPiBUaGlzIGZpeCBsb29rcyBnb29kIHRvIG1l
Lgo+IAo+IENjOiA8c3RhYmxlQGtlcm5lbC5vcmc+ICMgQXMgZmFyIGJhY2sgYXMgcG9zc2libGUK
ClRoZSBlbWFpbCBhZGRyZXNzIHNob3VsZCBiZTogc3RhYmxlQHZnZXIua2VybmVsLm9yZy4KClNv
cnJ5IGFib3V0IHRoZSB0eXBvLgoKQmVzdCByZWdhcmRzLApiYW9sdQoKPiBBY2tlZC1ieTogTHUg
QmFvbHUgPGJhb2x1Lmx1QGxpbnV4LmludGVsLmNvbT4KPiAKPiBCZXN0IHJlZ2FyZHMsCj4gYmFv
bHUKPiAKPj4gLS0tCj4+Cj4+IENoYW5nZXMgZnJvbSB2MToKPj4gLSBsZXZlbCBjYW5ub3QgYmUg
MC4gU28sIHRoZSBjb25kaXRpb24sICJpZiAobGV2ZWwgPiAxKSIsIGlzIHJlbW92ZWQsIAo+PiB3
aGljaCByZXN1bHRzIGluIGEgc2ltcGxlIGNvZGUuCj4+IC0gYSBtYWNybywgQklUX01BU0ssIGlz
IHVzZWQgdG8gaGF2ZSBhIGJpdCBtYXNrCj4+Cj4+IC0tLQo+PiDCoCBkcml2ZXJzL2lvbW11L2lu
dGVsLWlvbW11LmMgfCA0ICsrKy0KPj4gwqAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygr
KSwgMSBkZWxldGlvbigtKQo+Pgo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pb21tdS9pbnRlbC1p
b21tdS5jIGIvZHJpdmVycy9pb21tdS9pbnRlbC1pb21tdS5jCj4+IGluZGV4IDkzMjI2N2Y0OWY5
YS4uNGZkNWM2Mjg3YjZkIDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJzL2lvbW11L2ludGVsLWlvbW11
LmMKPj4gKysrIGIvZHJpdmVycy9pb21tdS9pbnRlbC1pb21tdS5jCj4+IEBAIC01NTU0LDcgKzU1
NTQsOSBAQCBzdGF0aWMgcGh5c19hZGRyX3QgCj4+IGludGVsX2lvbW11X2lvdmFfdG9fcGh5cyhz
dHJ1Y3QgaW9tbXVfZG9tYWluICpkb21haW4sCj4+IMKgwqDCoMKgwqAgcHRlID0gcGZuX3RvX2Rt
YV9wdGUoZG1hcl9kb21haW4sIGlvdmEgPj4gVlREX1BBR0VfU0hJRlQsICZsZXZlbCk7Cj4+IMKg
wqDCoMKgwqAgaWYgKHB0ZSkKPj4gLcKgwqDCoMKgwqDCoMKgIHBoeXMgPSBkbWFfcHRlX2FkZHIo
cHRlKTsKPj4gK8KgwqDCoMKgwqDCoMKgIHBoeXMgPSBkbWFfcHRlX2FkZHIocHRlKSArCj4+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIChpb3ZhICYgKEJJVF9NQVNLKGxldmVsX3RvX29mZnNldF9i
aXRzKGxldmVsKSArCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIFZURF9QQUdFX1NISUZUKSAtIDEpKTsKPj4gwqDCoMKgwqDCoCByZXR1cm4gcGh5czsK
Pj4gwqAgfQo+PgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
Xwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0
cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
