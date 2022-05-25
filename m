Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D5A0C433EF
	for <iommu@archiver.kernel.org>; Wed, 25 May 2022 06:20:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 010B741BA4;
	Wed, 25 May 2022 06:20:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id G_VE5DKqM1z2; Wed, 25 May 2022 06:20:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 5B3A841B95;
	Wed, 25 May 2022 06:20:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2C281C0032;
	Wed, 25 May 2022 06:20:40 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7811DC002D
 for <iommu@lists.linux-foundation.org>; Wed, 25 May 2022 06:20:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5F70A41BA2
 for <iommu@lists.linux-foundation.org>; Wed, 25 May 2022 06:20:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gFkQKx_n7UHM for <iommu@lists.linux-foundation.org>;
 Wed, 25 May 2022 06:20:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 306B141B99
 for <iommu@lists.linux-foundation.org>; Wed, 25 May 2022 06:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1653459638; x=1684995638;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=vJJ4lj6JSngeRrcXNnkqhrxyjqnmsKVzIMYvdkGbUx8=;
 b=ENkskoJmfwlX58zavNQTEI2j/jdLKWAOnJHTij/zCI/BQAlr11Yz+FP1
 sxCMUzeV26S7vTGjVeFCEtV1MsHSHJDOuI+xSXOJjcdMGBMNZbwH0WmL3
 v55foxSfZxDxXcp7rm08Bp+CT0Zw4wOXmXonDliz6T5v3Vwsy/qs85S2x
 xKdCWBTrSGXWHmm0wWSl7oycOLPr5mdc81X3aqJgkioCZ0acAPBh4n477
 Tdn1ybAKQX8UIzekq7eQ+Y5ain08AIw8EV44Fo7OghQH0A1qzyXafiO8H
 huYRa3NGkiRs65gvemjDHKGyMh6sH37fMfWfNAYhsnn7Gv8NHyah7mIQ4 g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10357"; a="299060032"
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; d="scan'208";a="299060032"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 May 2022 23:20:36 -0700
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; d="scan'208";a="601681830"
Received: from jwang96-mobl.ccr.corp.intel.com (HELO [10.255.29.139])
 ([10.255.29.139])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 May 2022 23:20:31 -0700
Message-ID: <ff8f23c0-8763-1fac-6526-9095101ca0e5@linux.intel.com>
Date: Wed, 25 May 2022 14:20:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v7 03/10] iommu/sva: Add iommu_sva_domain support
Content-Language: en-US
To: Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Jason Gunthorpe <jgg@nvidia.com>, Christoph Hellwig <hch@infradead.org>,
 Kevin Tian <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 Will Deacon <will@kernel.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>
References: <20220519072047.2996983-1-baolu.lu@linux.intel.com>
 <20220519072047.2996983-4-baolu.lu@linux.intel.com>
 <f3170016-4d7f-e78e-db48-68305f683349@arm.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <f3170016-4d7f-e78e-db48-68305f683349@arm.com>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 Jacob jun Pan <jacob.jun.pan@intel.com>
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

SGkgUm9iaW4sCgpPbiAyMDIyLzUvMjQgMjI6MzYsIFJvYmluIE11cnBoeSB3cm90ZToKPiBPbiAy
MDIyLTA1LTE5IDA4OjIwLCBMdSBCYW9sdSB3cm90ZToKPiBbLi4uXQo+PiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9pb21tdS9pb21tdS1zdmEtbGliLmMgCj4+IGIvZHJpdmVycy9pb21tdS9pb21tdS1z
dmEtbGliLmMKPj4gaW5kZXggMTA2NTA2MTQzODk2Li4yMTBjMzc2ZjYwNDMgMTAwNjQ0Cj4+IC0t
LSBhL2RyaXZlcnMvaW9tbXUvaW9tbXUtc3ZhLWxpYi5jCj4+ICsrKyBiL2RyaXZlcnMvaW9tbXUv
aW9tbXUtc3ZhLWxpYi5jCj4+IEBAIC02OSwzICs2OSw1MSBAQCBzdHJ1Y3QgbW1fc3RydWN0ICpp
b21tdV9zdmFfZmluZChpb2FzaWRfdCBwYXNpZCkKPj4gwqDCoMKgwqDCoCByZXR1cm4gaW9hc2lk
X2ZpbmQoJmlvbW11X3N2YV9wYXNpZCwgcGFzaWQsIF9fbW1nZXRfbm90X3plcm8pOwo+PiDCoCB9
Cj4+IMKgIEVYUE9SVF9TWU1CT0xfR1BMKGlvbW11X3N2YV9maW5kKTsKPj4gKwo+PiArLyoKPj4g
KyAqIElPTU1VIFNWQSBkcml2ZXItb3JpZW50ZWQgaW50ZXJmYWNlcwo+PiArICovCj4+ICtzdHJ1
Y3QgaW9tbXVfZG9tYWluICoKPj4gK2lvbW11X3N2YV9hbGxvY19kb21haW4oc3RydWN0IGJ1c190
eXBlICpidXMsIHN0cnVjdCBtbV9zdHJ1Y3QgKm1tKQo+IAo+IEFyZ2gsIHBsZWFzZSBubyBuZXcg
YnVzLWJhc2VkIGV4dGVybmFsIGludGVyZmFjZXMhIERvbWFpbiBhbGxvY2F0aW9uIAo+IG5lZWRz
IHRvIHJlc29sdmUgdG8gdGhlIHJpZ2h0IElPTU1VIGluc3RhbmNlIHRvIHNvbHZlIGEgbnVtYmVy
IG9mIAo+IGlzc3VlcywgYW5kIGNsZWFuaW5nIHVwIGV4aXN0aW5nIHVzZXJzIG9mIGlvbW11X2Rv
bWFpbl9hbGxvYygpIHRvIAo+IHByZXBhcmUgZm9yIHRoYXQgaXMgYWxyZWFkeSBoYXJkIGVub3Vn
aC4gVGhpcyBpcyBhcmd1YWJseSBldmVuIG1vcmUgCj4gcmVsZXZhbnQgaGVyZSB0aGFuIGZvciBv
dGhlciBkb21haW4gdHlwZXMsIHNpbmNlIFNWQSBzdXBwb3J0IGlzIG1vcmUgCj4gbGlrZWx5IHRv
IGRlcGVuZCBvbiBzcGVjaWZpYyBmZWF0dXJlcyB0aGF0IGNhbiB2YXJ5IGJldHdlZW4gSU9NTVUg
Cj4gaW5zdGFuY2VzIGV2ZW4gd2l0aCB0aGUgc2FtZSBkcml2ZXIuIFBsZWFzZSBtYWtlIHRoZSBl
eHRlcm5hbCBpbnRlcmZhY2UgCj4gdGFrZSBhIHN0cnVjdCBkZXZpY2UsIHRoZW4gcmVzb2x2ZSB0
aGUgb3BzIHRocm91Z2ggZGV2LT5pb21tdS4KPiAKPiBGdXJ0aGVyIG5pdDogdGhlIG5hbWluZyBp
bmNvbnNpc3RlbmN5IGJ1Z3MgbWUgYSBiaXQgLSAKPiBpb21tdV9zdmFfZG9tYWluX2FsbG9jKCkg
c2VlbXMgbW9yZSBuYXR1cmFsLiBBbHNvIEknZCBxdWVzdGlvbiB0aGUgCj4gc3ltbWV0cnkgdnMu
IHVzYWJpbGl0eSBkaWNob3RvbXkgb2Ygd2hldGhlciB3ZSAqcmVhbGx5KiB3YW50IHR3byAKPiBk
aWZmZXJlbnQgZnJlZSBmdW5jdGlvbnMgZm9yIGEgc3RydWN0IGlvbW11X2RvbWFpbiBwb2ludGVy
LCB3aGVyZSBhbnkgCj4gY2FsbGVyIHdoaWNoIG1pZ2h0IG1peCBTVkEgYW5kIG5vbi1TVkEgdXNh
Z2UgdGhlbiBoYXMgdG8gcmVtZW1iZXIgaG93IAo+IHRoZXkgYWxsb2NhdGVkIGFueSBwYXJ0aWN1
bGFyIGRvbWFpbiA6Lwo+IAo+PiArewo+PiArwqDCoMKgIHN0cnVjdCBpb21tdV9zdmFfZG9tYWlu
ICpzdmFfZG9tYWluOwo+PiArwqDCoMKgIHN0cnVjdCBpb21tdV9kb21haW4gKmRvbWFpbjsKPj4g
Kwo+PiArwqDCoMKgIGlmICghYnVzLT5pb21tdV9vcHMgfHwgIWJ1cy0+aW9tbXVfb3BzLT5zdmFf
ZG9tYWluX29wcykKPj4gK8KgwqDCoMKgwqDCoMKgIHJldHVybiBFUlJfUFRSKC1FTk9ERVYpOwo+
PiArCj4+ICvCoMKgwqAgc3ZhX2RvbWFpbiA9IGt6YWxsb2Moc2l6ZW9mKCpzdmFfZG9tYWluKSwg
R0ZQX0tFUk5FTCk7Cj4+ICvCoMKgwqAgaWYgKCFzdmFfZG9tYWluKQo+PiArwqDCoMKgwqDCoMKg
wqAgcmV0dXJuIEVSUl9QVFIoLUVOT01FTSk7Cj4+ICsKPj4gK8KgwqDCoCBtbWdyYWIobW0pOwo+
PiArwqDCoMKgIHN2YV9kb21haW4tPm1tID0gbW07Cj4+ICsKPj4gK8KgwqDCoCBkb21haW4gPSAm
c3ZhX2RvbWFpbi0+ZG9tYWluOwo+PiArwqDCoMKgIGRvbWFpbi0+dHlwZSA9IElPTU1VX0RPTUFJ
Tl9TVkE7Cj4+ICvCoMKgwqAgZG9tYWluLT5vcHMgPSBidXMtPmlvbW11X29wcy0+c3ZhX2RvbWFp
bl9vcHM7Cj4gCj4gSSdkIGhhdmUgdGhvdWdodCBpdCB3b3VsZCBiZSBsb2dpY2FsIHRvIHBhc3Mg
SU9NTVVfRE9NQUlOX1NWQSB0byB0aGUgCj4gbm9ybWFsIGRvbWFpbl9hbGxvYyBjYWxsLCBzbyB0
aGF0IGRyaXZlci1pbnRlcm5hbCBzdHVmZiBsaWtlIGNvbnRleHQgCj4gZGVzY3JpcHRvcnMgY2Fu
IGJlIHN0aWxsIGJlIGh1bmcgb2ZmIHRoZSBkb21haW4gYXMgdXN1YWwgKHJhdGhlciB0aGFuIAo+
IGFsbCBkcml2ZXJzIGhhdmluZyB0byBpbXBsZW1lbnQgc29tZSBleHRyYSBpbnRlcm5hbCBsb29r
dXAgbWVjaGFuaXNtIHRvIAo+IGhhbmRsZSBhbGwgdGhlIFNWQSBkb21haW4gb3BzKSwgYnV0IHRo
YXQncyBzb21ldGhpbmcgd2UncmUgZnJlZSB0byBjb21lIAoKQWdyZWVkIHdpdGggYWJvdmUgY29t
bWVudHMuIFRoYW5rcyEgSSB3aWxsIHBvc3QgYW4gYWRkaXRpb25hbCBwYXRjaApmb3IgcmV2aWV3
IGxhdGVyLgoKPiBiYWNrIGFuZCBjaGFuZ2UgbGF0ZXIuIEZXSVcgSSdkIGp1c3Qgc3RpY2sgdGhl
IG1tIHBvaW50ZXIgaW4gc3RydWN0IAo+IGlvbW11X2RvbWFpbiwgaW4gYSB1bmlvbiB3aXRoIHRo
ZSBmYXVsdCBoYW5kbGVyIHN0dWZmIGFuZC9vciBpb3ZhX2Nvb2tpZSAKPiAtIHRob3NlIGFyZSBt
dXR1YWxseSBleGNsdXNpdmUgd2l0aCBTVkEsIHJpZ2h0PwoKImlvdmFfY29va2llIiBpcyBtdXR1
YWxseSBleGNsdXNpdmUgd2l0aCBTVkEsIGJ1dCBJIGFtIG5vdCBzdXJlIGFib3V0CnRoZSBmYXVs
dCBoYW5kbGVyIHN0dWZmLgoKRGlkIHlvdSBtZWFuIEBoYW5kbGVyIGFuZCBAaGFuZGxlcl90b2tl
biBzdGFmZnMgYmVsb3c/CgpzdHJ1Y3QgaW9tbXVfZG9tYWluIHsKICAgICAgICAgdW5zaWduZWQg
dHlwZTsKICAgICAgICAgY29uc3Qgc3RydWN0IGlvbW11X2RvbWFpbl9vcHMgKm9wczsKICAgICAg
ICAgdW5zaWduZWQgbG9uZyBwZ3NpemVfYml0bWFwOyAgICAvKiBCaXRtYXAgb2YgcGFnZSBzaXpl
cyBpbiB1c2UgKi8KICAgICAgICAgaW9tbXVfZmF1bHRfaGFuZGxlcl90IGhhbmRsZXI7CiAgICAg
ICAgIHZvaWQgKmhhbmRsZXJfdG9rZW47CiAgICAgICAgIHN0cnVjdCBpb21tdV9kb21haW5fZ2Vv
bWV0cnkgZ2VvbWV0cnk7CiAgICAgICAgIHN0cnVjdCBpb21tdV9kbWFfY29va2llICppb3ZhX2Nv
b2tpZTsKfTsKCklzIGl0IG9ubHkgZm9yIERNQSBkb21haW5zPyBGcm9tIHRoZSBwb2ludCB2aWV3
IG9mIElPTU1VIGZhdWx0cywgaXQKc2VlbXMgdG8gYmUgZ2VuZXJpYy4KCkJlc3QgcmVnYXJkcywK
YmFvbHUKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9t
bXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8v
bGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
