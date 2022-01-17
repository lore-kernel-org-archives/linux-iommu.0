Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 478E1C433EF
	for <iommu@archiver.kernel.org>; Mon, 17 Jan 2022 07:55:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E319540239;
	Mon, 17 Jan 2022 07:55:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mV1ayT7za0Wn; Mon, 17 Jan 2022 07:55:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id D49864021F;
	Mon, 17 Jan 2022 07:55:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A4D43C0039;
	Mon, 17 Jan 2022 07:55:35 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 04C7DC002F
 for <iommu@lists.linux-foundation.org>; Mon, 17 Jan 2022 07:55:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E1C988144D
 for <iommu@lists.linux-foundation.org>; Mon, 17 Jan 2022 07:55:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=linux.dev
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qsv9OgafwVpk for <iommu@lists.linux-foundation.org>;
 Mon, 17 Jan 2022 07:55:32 +0000 (UTC)
X-Greylist: delayed 00:05:15 by SQLgrey-1.8.0
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8826C8143C
 for <iommu@lists.linux-foundation.org>; Mon, 17 Jan 2022 07:55:32 +0000 (UTC)
Subject: Re: [PATCH] iommu/intel: Fix potential memory leak in
 intel_setup_irq_remapping
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1642405813;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RyyTVkPfBbCHhwg2EvhuuJX9UG2XZqVITrBoHIZ9J84=;
 b=KmsTpPNpAau9VIXQqaeo0nOKKXmttWNTjZQUIKF803OzZcuAKUN0AnfLQbGRxGeZzSpI0A
 DxtbfKao1HxCCnNjTa5e89irG3VubCK616VY2TOKSvn8LBl+HR6J47EOjtDyVYT1KTbACF
 lbzGBi2UeLG7ZKX5bN8qMCWY1v5U0/I=
To: Lu Baolu <baolu.lu@linux.intel.com>, dwmw2@infradead.org,
 joro@8bytes.org, will@kernel.org
References: <20211229085608.18307-1-guoqing.jiang@linux.dev>
 <b44cec90-2d0b-0f49-b1aa-796f847eae70@linux.intel.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Guoqing Jiang <guoqing.jiang@linux.dev>
Message-ID: <047e4d13-f714-b742-7caf-5901d4b593fb@linux.dev>
Date: Mon, 17 Jan 2022 15:50:07 +0800
MIME-Version: 1.0
In-Reply-To: <b44cec90-2d0b-0f49-b1aa-796f847eae70@linux.intel.com>
Content-Language: en-US
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Cc: iommu@lists.linux-foundation.org
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

CgpPbiAxLzE3LzIyIDEwOjUwIEFNLCBMdSBCYW9sdSB3cm90ZToKPiBPbiAxMi8yOS8yMSA0OjU2
IFBNLCBHdW9xaW5nIEppYW5nIHdyb3RlOgo+PiBDYWxsIGlycV9kb21haW5fZnJlZV9md25vZGUg
dG8gZnJlZSAnZm4nIGlmIGRtYXJfZW5hYmxlX3FpIHJldHVybnMKPj4gZmFpbHVyZSwgc2FtZSBh
cyB3aGVuIGlycV9kb21haW5fY3JlYXRlX2hpZXJhcmNoeSByZXR1cm5zIGZhaWx1cmUuCj4+Cj4+
IFNpZ25lZC1vZmYtYnk6IEd1b3FpbmcgSmlhbmcgPGd1b3FpbmcuamlhbmdAbGludXguZGV2Pgo+
Cj4gQWRkIGEgIkZpeGVzIiB0YWcgaWYgeW91IHRoaW5rIHRoaXMgY2hhbmdlIG5lZWRzIGJhY2tw
b3J0LgoKSSBndWVzcyB0aGUgdGFnIG1pZ2h0IGJlOgoKRml4ZXM6IGUzYmVjYTQ4YTQ1YiAoImly
cWRvbWFpbi90cmVld2lkZTogS2VlcCBmaXJtd2FyZSBub2RlIAp1bmNvbmRpdGlvbmFsbHkgYWxs
b2NhdGVkIikKClNpbmNlIGJlZm9yZSB0aGF0IGNvbW1pdCwgaXJxX2RvbWFpbl9mcmVlX2Z3bm9k
ZSBpcyBjYWxsZWQgCnVuY29uZGl0aW9uYWxseSBhZnRlciBjcmVhdGUgaXJfZG9tYWluLApwbGVh
c2UgY29ycmVjdCBtZSBpZiBteSB1bmRlcnN0YW5kaW5nIGlzIG5vdCBjb3JyZWN0LgoKPgo+PiAt
LS0KPj4gwqAgZHJpdmVycy9pb21tdS9pbnRlbC9pcnFfcmVtYXBwaW5nLmMgfCAxICsKPj4gwqAg
MSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspCj4+Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L2lvbW11L2ludGVsL2lycV9yZW1hcHBpbmcuYyAKPj4gYi9kcml2ZXJzL2lvbW11L2ludGVsL2ly
cV9yZW1hcHBpbmcuYwo+PiBpbmRleCBmOTEyZmU0NWJlYTIuLjZlODM2MmMyMWZjMyAxMDA2NDQK
Pj4gLS0tIGEvZHJpdmVycy9pb21tdS9pbnRlbC9pcnFfcmVtYXBwaW5nLmMKPj4gKysrIGIvZHJp
dmVycy9pb21tdS9pbnRlbC9pcnFfcmVtYXBwaW5nLmMKPj4gQEAgLTU5NCw2ICs1OTQsNyBAQCBz
dGF0aWMgaW50IGludGVsX3NldHVwX2lycV9yZW1hcHBpbmcoc3RydWN0IAo+PiBpbnRlbF9pb21t
dSAqaW9tbXUpCj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBkbWFyX2Rpc2FibGVfcWkoaW9tbXUpOwo+
PiDCoCDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKGRtYXJfZW5hYmxlX3FpKGlvbW11KSkgewo+PiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpcnFfZG9tYWluX2ZyZWVfZndub2RlKGZuKTsKPj4gwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcHJfZXJyKCJGYWlsZWQgdG8gZW5hYmxlIHF1ZXVlZCBp
bnZhbGlkYXRpb25cbiIpOwo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBnb3RvIG91dF9m
cmVlX2JpdG1hcDsKPj4gwqDCoMKgwqDCoMKgwqDCoMKgIH0KPj4KPgo+IFRoZSByZXdpbmRpbmcg
cGF0aHMgaW4gaW50ZWxfc2V0dXBfaXJxX3JlbWFwcGluZygpIG5lZWQgbW9yZQo+IGVuaGFuY2Vt
ZW50LiBIb3cgYWJvdXQgYmVsb3cgY2hhbmdlcz8KPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lv
bW11L2ludGVsL2lycV9yZW1hcHBpbmcuYyAKPiBiL2RyaXZlcnMvaW9tbXUvaW50ZWwvaXJxX3Jl
bWFwcGluZy5jCj4gaW5kZXggZjkxMmZlNDViZWEyLi44OWMzMmJmMTczZWYgMTAwNjQ0Cj4gLS0t
IGEvZHJpdmVycy9pb21tdS9pbnRlbC9pcnFfcmVtYXBwaW5nLmMKPiArKysgYi9kcml2ZXJzL2lv
bW11L2ludGVsL2lycV9yZW1hcHBpbmcuYwo+IEBAIC01NjksOSArNTY5LDggQEAgc3RhdGljIGlu
dCBpbnRlbF9zZXR1cF9pcnFfcmVtYXBwaW5nKHN0cnVjdCAKPiBpbnRlbF9pb21tdSAqaW9tbXUp
Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZm4sICZpbnRlbF9pcl9kb21haW5fb3Bz
LAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlvbW11KTsKPiDCoMKgwqDCoMKgwqDC
oCBpZiAoIWlvbW11LT5pcl9kb21haW4pIHsKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBpcnFfZG9tYWluX2ZyZWVfZndub2RlKGZuKTsKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgcHJfZXJyKCJJUiVkOiBmYWlsZWQgdG8gYWxsb2NhdGUgaXJxZG9tYWluXG4iLCAKPiBp
b21tdS0+c2VxX2lkKTsKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBnb3RvIG91dF9m
cmVlX2JpdG1hcDsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBnb3RvIG91dF9mcmVl
X2Z3bm9kZTsKPiDCoMKgwqDCoMKgwqDCoCB9Cj4gwqDCoMKgwqDCoMKgwqAgaW9tbXUtPmlyX21z
aV9kb21haW4gPQo+IGFyY2hfY3JlYXRlX3JlbWFwX21zaV9pcnFfZG9tYWluKGlvbW11LT5pcl9k
b21haW4sCj4gQEAgLTU5NSw3ICs1OTQsNyBAQCBzdGF0aWMgaW50IGludGVsX3NldHVwX2lycV9y
ZW1hcHBpbmcoc3RydWN0IAo+IGludGVsX2lvbW11ICppb21tdSkKPgo+IMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBpZiAoZG1hcl9lbmFibGVfcWkoaW9tbXUpKSB7Cj4gwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBwcl9lcnIoIkZhaWxlZCB0byBl
bmFibGUgcXVldWVkIGludmFsaWRhdGlvblxuIik7Cj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIGdvdG8gb3V0X2ZyZWVfYml0bWFwOwo+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBnb3RvIG91dF9mcmVlX2lyX2RvbWFp
bjsKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfQo+IMKgwqDCoMKgwqDCoMKgIH0K
Pgo+IEBAIC02MTksNiArNjE4LDE0IEBAIHN0YXRpYyBpbnQgaW50ZWxfc2V0dXBfaXJxX3JlbWFw
cGluZyhzdHJ1Y3QgCj4gaW50ZWxfaW9tbXUgKmlvbW11KQo+Cj4gwqDCoMKgwqDCoMKgwqAgcmV0
dXJuIDA7Cj4KPiArb3V0X2ZyZWVfaXJfZG9tYWluOgo+ICvCoMKgwqDCoMKgwqAgaWYgKGlvbW11
LT5pcl9tc2lfZG9tYWluKQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlycV9kb21h
aW5fcmVtb3ZlKGlvbW11LT5pcl9tc2lfZG9tYWluKTsKPiArwqDCoMKgwqDCoMKgIGlycV9kb21h
aW5fcmVtb3ZlKGlvbW11LT5pcl9kb21haW4pOwo+ICvCoMKgwqDCoMKgwqAgaW9tbXUtPmlyX21z
aV9kb21haW4gPSBOVUxMOwo+ICvCoMKgwqDCoMKgwqAgaW9tbXUtPmlyX2RvbWFpbiA9IE5VTEw7
Cj4gK291dF9mcmVlX2Z3bm9kZToKPiArwqDCoMKgwqDCoMKgIGlycV9kb21haW5fZnJlZV9md25v
ZGUoZm4pOwo+IMKgb3V0X2ZyZWVfYml0bWFwOgo+IMKgwqDCoMKgwqDCoMKgIGJpdG1hcF9mcmVl
KGJpdG1hcCk7Cj4gwqBvdXRfZnJlZV9wYWdlczoKClRoYW5rcyBmb3IgdGhlIHN1Z2dlc3Rpb24s
IHdpbGwgc2VuZCBuZXcgdmVyc2lvbiB3aXRoIHlvdXIgc3VnZ2VzdGVkLWJ5LgoKVGhhbmtzLApH
dW9xaW5nCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlv
bW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczov
L2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
