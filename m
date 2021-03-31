Return-Path: <SRS0=WBHG=I5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E84BC433C1
	for <iommu@archiver.kernel.org>; Wed, 31 Mar 2021 05:49:24 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5FED619AB
	for <iommu@archiver.kernel.org>; Wed, 31 Mar 2021 05:49:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5FED619AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9F4C2608D0;
	Wed, 31 Mar 2021 05:49:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Q1R8HZ9EaqKF; Wed, 31 Mar 2021 05:49:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id 732736088A;
	Wed, 31 Mar 2021 05:49:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 56C7BC000C;
	Wed, 31 Mar 2021 05:49:22 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8E75CC000A
 for <iommu@lists.linux-foundation.org>; Wed, 31 Mar 2021 05:49:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 76A0140222
 for <iommu@lists.linux-foundation.org>; Wed, 31 Mar 2021 05:49:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id td5Fmra4la8X for <iommu@lists.linux-foundation.org>;
 Wed, 31 Mar 2021 05:49:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 13F01401E3
 for <iommu@lists.linux-foundation.org>; Wed, 31 Mar 2021 05:49:18 +0000 (UTC)
IronPort-SDR: 6R9tSIg4MZkIHcbFHlyzNK7tJ0yLy+fo0KoVddebqoaluYrX9Fju7siYsV1a0F1g/V6Sn0zYtB
 JeRobgYw48tg==
X-IronPort-AV: E=McAfee;i="6000,8403,9939"; a="191401118"
X-IronPort-AV: E=Sophos;i="5.81,291,1610438400"; d="scan'208";a="191401118"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Mar 2021 22:49:17 -0700
IronPort-SDR: ba+XWeIwmYW/opvq7Op8QU/aZRWkCXU2FL5Tr/qgArZ3UfIk8/4Ty91jAVH6BsylI6DKJ7XRtO
 0nRvSCJ5yBdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,291,1610438400"; d="scan'208";a="438628990"
Received: from allen-box.sh.intel.com (HELO [10.239.159.128])
 ([10.239.159.128])
 by fmsmga004.fm.intel.com with ESMTP; 30 Mar 2021 22:49:14 -0700
Subject: Re: [RFC PATCH 2/5] iommu: Add an unmap_pages() op for IOMMU drivers
To: isaacm@codeaurora.org
References: <20210331030042.13348-1-isaacm@codeaurora.org>
 <20210331030042.13348-3-isaacm@codeaurora.org>
 <e1cadb9e-2ffa-8506-6790-2dab4733af25@linux.intel.com>
 <4c396e68a076f321ed3f406c2c875006@codeaurora.org>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <3a931043-71bc-88a2-ee57-be9c139e7c9f@linux.intel.com>
Date: Wed, 31 Mar 2021 13:39:54 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <4c396e68a076f321ed3f406c2c875006@codeaurora.org>
Content-Language: en-US
Cc: will@kernel.org, iommu@lists.linux-foundation.org, robin.murphy@arm.com,
 linux-arm-kernel@lists.infradead.org, pratikp@codeaurora.org
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

T24gMy8zMS8yMSAxOjM2IFBNLCBpc2FhY21AY29kZWF1cm9yYS5vcmcgd3JvdGU6Cj4gT24gMjAy
MS0wMy0zMCAyMTo0NywgTHUgQmFvbHUgd3JvdGU6Cj4+IE9uIDMvMzEvMjEgMTE6MDAgQU0sIElz
YWFjIEouIE1hbmphcnJlcyB3cm90ZToKPj4+IEFkZCBhIGNhbGxiYWNrIGZvciBJT01NVSBkcml2
ZXJzIHRvIHByb3ZpZGUgYSBwYXRoIGZvciB0aGUKPj4+IElPTU1VIGZyYW1ld29yayB0byBjYWxs
IGludG8gYW4gSU9NTVUgZHJpdmVyLCB3aGljaCBjYW4gY2FsbAo+Pj4gaW50byB0aGUgaW8tcGd0
YWJsZSBjb2RlLCB0byB1bm1hcCBhIHZpcnR1YWxseSBjb250aWd1b3VzCj4+PiByYW5nZSBvZiBw
YWdlcyBvZiB0aGUgc2FtZSBzaXplLgo+Pj4KPj4+IEZvciBJT01NVSBkcml2ZXJzIHRoYXQgZG8g
bm90IHNwZWNpZnkgYW4gdW5tYXBfcGFnZXMoKSBjYWxsYmFjaywKPj4+IHRoZSBleGlzdGluZyBs
b2dpYyBvZiB1bm1hcHBpbmcgbWVtb3J5IG9uZSBwYWdlIGJsb2NrIGF0IGEgdGltZQo+Pj4gd2ls
bCBiZSB1c2VkLgo+Pj4KPj4+IFNpZ25lZC1vZmYtYnk6IElzYWFjIEouIE1hbmphcnJlcyA8aXNh
YWNtQGNvZGVhdXJvcmEub3JnPgo+Pj4gU3VnZ2VzdGVkLWJ5OiBXaWxsIERlYWNvbiA8d2lsbEBr
ZXJuZWwub3JnPgo+Pj4gLS0tCj4+PiDCoCBpbmNsdWRlL2xpbnV4L2lvbW11LmggfCA0ICsrKysK
Pj4+IMKgIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKykKPj4+Cj4+PiBkaWZmIC0tZ2l0
IGEvaW5jbHVkZS9saW51eC9pb21tdS5oIGIvaW5jbHVkZS9saW51eC9pb21tdS5oCj4+PiBpbmRl
eCA1ZTdmZTUxOTQzMGEuLjljZjgxMjQyNTgxYSAxMDA2NDQKPj4+IC0tLSBhL2luY2x1ZGUvbGlu
dXgvaW9tbXUuaAo+Pj4gKysrIGIvaW5jbHVkZS9saW51eC9pb21tdS5oCj4+PiBAQCAtMTkzLDYg
KzE5Myw3IEBAIHN0cnVjdCBpb21tdV9pb3RsYl9nYXRoZXIgewo+Pj4gwqDCoCAqIEBkZXRhY2hf
ZGV2OiBkZXRhY2ggZGV2aWNlIGZyb20gYW4gaW9tbXUgZG9tYWluCj4+PiDCoMKgICogQG1hcDog
bWFwIGEgcGh5c2ljYWxseSBjb250aWd1b3VzIG1lbW9yeSByZWdpb24gdG8gYW4gaW9tbXUgZG9t
YWluCj4+PiDCoMKgICogQHVubWFwOiB1bm1hcCBhIHBoeXNpY2FsbHkgY29udGlndW91cyBtZW1v
cnkgcmVnaW9uIGZyb20gYW4gCj4+PiBpb21tdSBkb21haW4KPj4+ICsgKiBAdW5tYXBfcGFnZXM6
IHVubWFwIGEgbnVtYmVyIG9mIHBhZ2VzIG9mIHRoZSBzYW1lIHNpemUgZnJvbSBhbiAKPj4+IGlv
bW11IGRvbWFpbgo+Pj4gwqDCoCAqIEBmbHVzaF9pb3RsYl9hbGw6IFN5bmNocm9ub3VzbHkgZmx1
c2ggYWxsIGhhcmR3YXJlIFRMQnMgZm9yIHRoaXMgCj4+PiBkb21haW4KPj4+IMKgwqAgKiBAaW90
bGJfc3luY19tYXA6IFN5bmMgbWFwcGluZ3MgY3JlYXRlZCByZWNlbnRseSB1c2luZyBAbWFwIHRv
IAo+Pj4gdGhlIGhhcmR3YXJlCj4+PiDCoMKgICogQGlvdGxiX3N5bmM6IEZsdXNoIGFsbCBxdWV1
ZWQgcmFuZ2VzIGZyb20gdGhlIGhhcmR3YXJlIFRMQnMgYW5kIAo+Pj4gZW1wdHkgZmx1c2gKPj4+
IEBAIC0yNDUsNiArMjQ2LDkgQEAgc3RydWN0IGlvbW11X29wcyB7Cj4+PiDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgcGh5c19hZGRyX3QgcGFkZHIsIHNpemVfdCBzaXplLCBpbnQgcHJvdCwgZ2Zw
X3QgZ2ZwKTsKPj4+IMKgwqDCoMKgwqAgc2l6ZV90ICgqdW5tYXApKHN0cnVjdCBpb21tdV9kb21h
aW4gKmRvbWFpbiwgdW5zaWduZWQgbG9uZyBpb3ZhLAo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBzaXplX3Qgc2l6ZSwgc3RydWN0IGlvbW11X2lvdGxiX2dhdGhlciAqaW90bGJfZ2F0
aGVyKTsKPj4+ICvCoMKgwqAgc2l6ZV90ICgqdW5tYXBfcGFnZXMpKHN0cnVjdCBpb21tdV9kb21h
aW4gKmRvbWFpbiwgdW5zaWduZWQgbG9uZyAKPj4+IGlvdmEsCj4+PiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBzaXplX3QgcGdzaXplLCBzaXplX3QgcGdjb3VudCwKPj4+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHN0cnVjdCBpb21tdV9pb3RsYl9nYXRo
ZXIgKmlvdGxiX2dhdGhlcik7Cj4+Cj4+IElzIGl0IHBvc3NpYmxlIHRvIGFkZCBhbiBlcXVpdmFs
ZW50IG1hcF9wYWdlcygpIGNhbGxiYWNrPwo+IFllcywgbWFwX3BhZ2VzKCkgY2FuIGJlIGltcGxl
bWVudGVkIGFuZCBjYW4gbGV2ZXJhZ2UgYSBsb3Qgb2YgdGhlIAo+IGltcGxlbWVudGF0aW9uCj4g
b2YgdW5tYXBfcGFnZXMoKS4gVGhlIHByb2JsZW0gaXMgdGhhdCBpZiB5b3UgbWFwIHNldmVyYWwg
cGFnZXMgaW4gb25lIAo+IGNhbGwsIGFuZCB0aGVuCj4gZW5jb3VudGVyIGFuIGVycm9yIGFuZCBo
YXZlIHRvIHJvbGxiYWNrLCB5b3Ugc2hvdWxkIGRvIFRMQiBtYWludGVuYW5jZSwgCj4gYXMgaW9t
bXVfbWFwCj4gZG9lcyB3aGVuIGl0IGVuY291bnRlcnMgYW4gZXJyb3IuIEhvd2V2ZXIsIHdlIGNh
bid0IGNhbGwgaW9tbXVfdW5tYXAgCj4gZnJvbSBpby1wZ3RhYmxlLWFybQo+IGZvciBleGFtcGxl
LiBXZSBjYW4gY2FsbCBhcm1fbHBhZV91bm1hcF9wYWdlcygpIGZyb20gdGhlIGxhdGVyIHBhdGNo
ZXMsIAo+IGJ1dCB0aGF0IGRvZXNuJ3QKPiBzb2x2ZSB0aGUgVExCIG1haW50ZW5hbmNlIGlzc3Vl
LiBEbyB5b3UgaGF2ZSBhbnkgdGhvdWdodHMgb24gaG93IHRvIAo+IGFkZHJlc3MgdGhpcz8KCkNh
bGwgdW5tYXBfcGFnZXMoKSB3aXRoIHRoZSBzYW1lIHBhZ2VzIGFuZCBzaXplIHRvIHJvbGwgYmFj
ay4gRG9lcyBpdAp3b3JrPwoKQmVzdCByZWdhcmRzLApiYW9sdQoKPj4KPj4+IMKgwqDCoMKgwqAg
dm9pZCAoKmZsdXNoX2lvdGxiX2FsbCkoc3RydWN0IGlvbW11X2RvbWFpbiAqZG9tYWluKTsKPj4+
IMKgwqDCoMKgwqAgdm9pZCAoKmlvdGxiX3N5bmNfbWFwKShzdHJ1Y3QgaW9tbXVfZG9tYWluICpk
b21haW4sIHVuc2lnbmVkIAo+Pj4gbG9uZyBpb3ZhLAo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBzaXplX3Qgc2l6ZSk7Cj4+Pgo+Pgo+PiBCZXN0IHJlZ2FyZHMs
Cj4+IGJhb2x1Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRw
czovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
