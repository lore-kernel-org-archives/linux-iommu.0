Return-Path: <SRS0=7pZu=EE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DA6DC4363A
	for <iommu@archiver.kernel.org>; Thu, 29 Oct 2020 15:53:41 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD781206B2
	for <iommu@archiver.kernel.org>; Thu, 29 Oct 2020 15:53:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD781206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 52F1E843DB;
	Thu, 29 Oct 2020 15:53:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yX2173HK19Gk; Thu, 29 Oct 2020 15:53:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 26AFF8060B;
	Thu, 29 Oct 2020 15:53:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 128D0C088B;
	Thu, 29 Oct 2020 15:53:38 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 93931C0051
 for <iommu@lists.linux-foundation.org>; Thu, 29 Oct 2020 15:53:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 8EA5786BFF
 for <iommu@lists.linux-foundation.org>; Thu, 29 Oct 2020 15:53:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lhFqkUKQ8CMx for <iommu@lists.linux-foundation.org>;
 Thu, 29 Oct 2020 15:53:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 7502B86208
 for <iommu@lists.linux-foundation.org>; Thu, 29 Oct 2020 15:53:35 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CDE091063;
 Thu, 29 Oct 2020 08:53:34 -0700 (PDT)
Received: from [10.57.54.223] (unknown [10.57.54.223])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2AEB73F66E;
 Thu, 29 Oct 2020 08:53:33 -0700 (PDT)
Subject: Re: [PATCH] iommu/arm-smmu-v3: Add def_domain_type callback
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org
References: <20201029154114.20364-1-shameerali.kolothum.thodi@huawei.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <a3c73596-70d9-4204-d598-5e6684868544@arm.com>
Date: Thu, 29 Oct 2020 15:53:31 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201029154114.20364-1-shameerali.kolothum.thodi@huawei.com>
Content-Language: en-GB
Cc: jean-philippe@linaro.org, ashok.raj@intel.com, linuxarm@huawei.com,
 will@kernel.org
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

T24gMjAyMC0xMC0yOSAxNTo0MSwgU2hhbWVlciBLb2xvdGh1bSB3cm90ZToKPiBXaXRoIHRoZSBp
bnRyb2R1Y3Rpb24gb2YgZGVmX2RvbWFpbl90eXBlIGluIGlvbW11X29wcywgdmVuZG9yCj4gZHJp
dmVycyBjYW4gbm93IGluZm9ybSB0aGUgaW9tbXUgZ2VuZXJpYyBsYXllciBhYm91dCBhbnkgc3Bl
Y2lmaWMKPiBkZWZhdWx0IGRvbWFpbiByZXF1aXJlbWVudCBmb3IgYSBkZXZpY2UuIEFueSBwY2kg
ZGV2IG1hcmtlZCBhcwo+IHVudHJ1c3RlZCBpcyBub3cgcHJldmVudGVkIGZyb20gaGF2aW5nIGFu
IElERU5USVRZIG1hcHBpbmcKPiBkb21haW4uCj4gCj4gVGhlIGNhbGxiYWNrIGlzIGFsc28gcmVx
dWlyZWQgd2hlbiB0aGUgc3VwcG9ydCBmb3IgZHluYW1pY2FsbHkKPiBjaGFuZ2luZyB0aGUgZGVm
YXVsdCBkb21haW4gb2YgYSBncm91cCBpcyBhdmFpbGFibGUuCgpZZXMsIHdlIHdhbnQgdG8gYWxs
b3cgdGhlIGdyb3VwIHR5cGUgY29udHJvbCB0byB3b3JrIGZvciBhbGwgZHJpdmVycywgCmlkZWFs
bHkuLi4KCj4gU2lnbmVkLW9mZi1ieTogU2hhbWVlciBLb2xvdGh1bSA8c2hhbWVlcmFsaS5rb2xv
dGh1bS50aG9kaUBodWF3ZWkuY29tPgo+IC0tLQo+ICAgLU9ubHkgZGV2aWNlcyBkb3duc3RyZWFt
IGZyb23CoGV4dGVybmFsbHkgZXhwb3NlZCBQQ0llIGhpZXJhcmNoaWVzCj4gIMKgIChzdWNoIGFz
IFRodW5kZXJib2x0IG91dHNpZGUgdGhlIHBsYXRmb3JtKSBhcmUgY3VycmVudGx5IG1hcmtlZAo+
ICAgIGFzICJ1bnRydXN0ZWQiLiBOb3QgYXdhcmUgb2YgYW55IEFSTTY0IHBsYXRmb3JtcyB0aGF0
IG1heSB1c2UKPiAgICB0aGlzIHR5cGUgb2YgZGV2aWNlLgo+IAo+ICDCoCBOZXZlcnRoZWxlc3Ms
IHRoZSBtYWluIG1vdGl2YXRpb24gZm9yIHRoaXMgcGF0Y2ggaXMgdG8gaGF2ZSB0aGUKPiAgICBm
bGV4aWJpbGl0eSBvZiBjaGFuZ2luZ8KgdGhlIGlvbW11IGRlZmF1bHQgZG9tYWluIGZvciBhIGdy
b3VwIGJhc2VkCj4gICAgb24gdGhlIHNlcmllc1sxXSAiaW9tbXU6IEFkZCBzdXBwb3J0IHRvIGNo
YW5nZSBkZWZhdWx0IGRvbWFpbiBvZiBhbgo+ICAgIGlvbW11IGdyb3VwIiBhbmQgdGhhdCBtYW5k
YXRlcyB2ZW5kb3IgaW9tbXUgZHJpdmVyIHRvIHByb3ZpZGUgdGhpcwo+ICAgIGNhbGxiYWNrLgo+
IAo+ICDCoC1UaGlzIGlzIHRlc3RlZCBhbG9uZyB3aXRoIFsxXSBhbmQgd2FzIGFibGUgdG8gY2hh
bmdlwqB0aGUgZGVmYXVsdAo+ICDCoCBkb21haW4gb2YgYW4gaW9tbXUgZ3JvdXAgb24gYW4gSGlT
aWxpY29uIEQwNiBoYXJkd2FyZS4KPiAgIAo+IDEuIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xp
bnV4LWlvbW11LzIwMjAwOTI1MTkwNjIwLjE4NzMyLTEtYXNob2sucmFqQGludGVsLmNvbS8KPiAt
LS0KPiAgIGRyaXZlcnMvaW9tbXUvYXJtL2FybS1zbW11LXYzL2FybS1zbW11LXYzLmMgfCAyNiAr
KysrKysrKysrKysrKysrKysrKysKPiAgIDEgZmlsZSBjaGFuZ2VkLCAyNiBpbnNlcnRpb25zKCsp
Cj4gCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW9tbXUvYXJtL2FybS1zbW11LXYzL2FybS1zbW11
LXYzLmMgYi9kcml2ZXJzL2lvbW11L2FybS9hcm0tc21tdS12My9hcm0tc21tdS12My5jCj4gaW5k
ZXggZTYzNGJiZTYwNTczLi5kNWRiY2VlOTk1ZGIgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9pb21t
dS9hcm0vYXJtLXNtbXUtdjMvYXJtLXNtbXUtdjMuYwo+ICsrKyBiL2RyaXZlcnMvaW9tbXUvYXJt
L2FybS1zbW11LXYzL2FybS1zbW11LXYzLmMKPiBAQCAtMjU2Nyw2ICsyNTY3LDMxIEBAIHN0YXRp
YyBpbnQgYXJtX3NtbXVfZGV2X2Rpc2FibGVfZmVhdHVyZShzdHJ1Y3QgZGV2aWNlICpkZXYsCj4g
ICAJfQo+ICAgfQo+ICAgCj4gKy8qCj4gKyAqIFJldHVybiB0aGUgcmVxdWlyZWQgZGVmYXVsdCBk
b21haW4gdHlwZSBmb3IgYSBzcGVjaWZpYyBkZXZpY2UuCj4gKyAqCj4gKyAqIEBkZXY6IHRoZSBk
ZXZpY2UgaW4gcXVlcnkKPiArICoKPiArICogUmV0dXJuczoKPiArICogIC0gSU9NTVVfRE9NQUlO
X0RNQTogZGV2aWNlIHJlcXVpcmVzIGEgZHluYW1pYyBtYXBwaW5nIGRvbWFpbgo+ICsgKiAgLSAw
OiBib3RoIGlkZW50aXR5IGFuZCBkeW5hbWljIGRvbWFpbnMgd29yayBmb3IgdGhpcyBkZXZpY2UK
PiArICovCj4gK3N0YXRpYyBpbnQgYXJtX3NtbXVfZGVmX2RvbWFpbl90eXBlKHN0cnVjdCBkZXZp
Y2UgKmRldikKPiArewo+ICsJaWYgKGRldl9pc19wY2koZGV2KSkgewo+ICsJCXN0cnVjdCBwY2lf
ZGV2ICpwZGV2ID0gdG9fcGNpX2RldihkZXYpOwo+ICsKPiArCQkvKgo+ICsJCSAqIFByZXZlbnQg
YW55IGRldmljZSBtYXJrZWQgYXMgdW50cnVzdGVkIGZyb20gZ2V0dGluZwo+ICsJCSAqIHBsYWNl
ZCBpbnRvIHRoZSBJZGVudGl0eSBtYXBwaW5nIGRvbWFpbi4KPiArCQkgKi8KPiArCQlpZiAocGRl
di0+dW50cnVzdGVkKQo+ICsJCQlyZXR1cm4gSU9NTVVfRE9NQUlOX0RNQTsKPiArCX0KClRoaXMg
c2hvdWxkIGJlIHNvbWV3aGVyZSBpbiBjb3JlIGNvZGUgLSBpdCBoYXMgbm90aGluZyB0byBkbyB3
aXRoIFNNTVV2My4KCj4gKwo+ICsJcmV0dXJuIDA7CgpJIGRvbid0IHN0cmljdGx5IG9iamVjdCB0
byBhZGRpbmcgYSBzdHViIGNhbGxiYWNrIGZvciB0aGF0IGJpdCwgYnV0IHdoeSAKY2FuJ3QgaW9t
bXVfY2hhbmdlX2Rldl9kZWZfZG9tYWluKCkgc2ltcGx5IGFzc3VtZSBpdCBmcm9tIGEgTlVMTCAK
Y2FsbGJhY2s/IFRoYXQgd29ya3MgZm9yIGV2ZXJ5b25lLCBmb3Igbm8gZXh0cmEgY29zdCA7KQoK
Um9iaW4uCgo+ICt9Cj4gKwo+ICAgc3RhdGljIHN0cnVjdCBpb21tdV9vcHMgYXJtX3NtbXVfb3Bz
ID0gewo+ICAgCS5jYXBhYmxlCQk9IGFybV9zbW11X2NhcGFibGUsCj4gICAJLmRvbWFpbl9hbGxv
YwkJPSBhcm1fc21tdV9kb21haW5fYWxsb2MsCj4gQEAgLTI1ODksNiArMjYxNCw3IEBAIHN0YXRp
YyBzdHJ1Y3QgaW9tbXVfb3BzIGFybV9zbW11X29wcyA9IHsKPiAgIAkuZGV2X2ZlYXRfZW5hYmxl
ZAk9IGFybV9zbW11X2Rldl9mZWF0dXJlX2VuYWJsZWQsCj4gICAJLmRldl9lbmFibGVfZmVhdAk9
IGFybV9zbW11X2Rldl9lbmFibGVfZmVhdHVyZSwKPiAgIAkuZGV2X2Rpc2FibGVfZmVhdAk9IGFy
bV9zbW11X2Rldl9kaXNhYmxlX2ZlYXR1cmUsCj4gKwkuZGVmX2RvbWFpbl90eXBlCT0gYXJtX3Nt
bXVfZGVmX2RvbWFpbl90eXBlLAo+ICAgCS5wZ3NpemVfYml0bWFwCQk9IC0xVUwsIC8qIFJlc3Ry
aWN0ZWQgZHVyaW5nIGRldmljZSBhdHRhY2ggKi8KPiAgIH07Cj4gICAKPiAKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0Cmlv
bW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0
aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
