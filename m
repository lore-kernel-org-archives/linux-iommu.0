Return-Path: <SRS0=6QSB=IH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57142C433DB
	for <iommu@archiver.kernel.org>; Tue,  9 Mar 2021 12:50:42 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF56265274
	for <iommu@archiver.kernel.org>; Tue,  9 Mar 2021 12:50:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF56265274
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 933734018A;
	Tue,  9 Mar 2021 12:50:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vQqlYNC9CtU9; Tue,  9 Mar 2021 12:50:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7181740177;
	Tue,  9 Mar 2021 12:50:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 48808C000A;
	Tue,  9 Mar 2021 12:50:40 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6D2A8C0001
 for <iommu@lists.linux-foundation.org>; Tue,  9 Mar 2021 12:50:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 584A6834BA
 for <iommu@lists.linux-foundation.org>; Tue,  9 Mar 2021 12:50:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wFOAs8Im1paE for <iommu@lists.linux-foundation.org>;
 Tue,  9 Mar 2021 12:50:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1CA3883449
 for <iommu@lists.linux-foundation.org>; Tue,  9 Mar 2021 12:50:36 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 092291042;
 Tue,  9 Mar 2021 04:50:36 -0800 (PST)
Received: from [10.57.55.135] (unknown [10.57.55.135])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C1F493F70D;
 Tue,  9 Mar 2021 04:50:34 -0800 (PST)
Subject: Re: [PATCH v3] iommu: Check dev->iommu in iommu_dev_xxx functions
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
References: <20210303173611.520-1-shameerali.kolothum.thodi@huawei.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <ed0f8327-a23d-c9fd-672d-a431b3327593@arm.com>
Date: Tue, 9 Mar 2021 12:50:29 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210303173611.520-1-shameerali.kolothum.thodi@huawei.com>
Content-Language: en-GB
Cc: jean-philippe@linaro.org, will@kernel.org, linuxarm@openeuler.org,
 prime.zeng@hisilicon.com
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

T24gMjAyMS0wMy0wMyAxNzozNiwgU2hhbWVlciBLb2xvdGh1bSB3cm90ZToKPiBUaGUgZGV2aWNl
IGlvbW11IHByb2JlL2F0dGFjaCBtaWdodCBoYXZlIGZhaWxlZCBsZWF2aW5nIGRldi0+aW9tbXUK
PiB0byBOVUxMIGFuZCBkZXZpY2UgZHJpdmVycyBtYXkgc3RpbGwgaW52b2tlIHRoZXNlIGZ1bmN0
aW9ucyByZXN1bHRpbmcKPiBpbiBhIGNyYXNoIGluIGlvbW11IHZlbmRvciBkcml2ZXIgY29kZS4K
PiAKPiBIZW5jZSBtYWtlIHN1cmUgd2UgY2hlY2sgdGhhdC4KClJldmlld2VkLWJ5OiBSb2JpbiBN
dXJwaHkgPHJvYmluLm11cnBoeUBhcm0uY29tPgoKPiBGaXhlczrCoGEzYTE5NTkyOWQ0MCAoImlv
bW11OiBBZGQgQVBJcyBmb3IgbXVsdGlwbGUgZG9tYWlucyBwZXIgZGV2aWNlIikKPiBTaWduZWQt
b2ZmLWJ5OiBTaGFtZWVyIEtvbG90aHVtIDxzaGFtZWVyYWxpLmtvbG90aHVtLnRob2RpQGh1YXdl
aS5jb20+Cj4gLS0tCj4gdjIgLS0+IHYzCj4gICAtUmVtb3ZlZCBpb21tdV9vcHMgZnJvbSBzdHJ1
Y3QgZGV2X2lvbW11Lgo+IHYxIC0tPiB2MjoKPiAgIC1BZGRlZCBpb21tdV9vcHMgdG8gc3RydWN0
IGRldl9pb21tdSBiYXNlZCBvbiB0aGUgZGlzY3Vzc2lvbiB3aXRoIFJvYmluLgo+ICAgLVJlYmFz
ZWQgYWdhaW5zdCBpb21tdS10cmVlIGNvcmUgYnJhbmNoLgo+IC0tLQo+ICAgZHJpdmVycy9pb21t
dS9pb21tdS5jIHwgMjQgKysrKysrKysrKysrKysrLS0tLS0tLS0tCj4gICAxIGZpbGUgY2hhbmdl
ZCwgMTUgaW5zZXJ0aW9ucygrKSwgOSBkZWxldGlvbnMoLSkKPiAKPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9pb21tdS9pb21tdS5jIGIvZHJpdmVycy9pb21tdS9pb21tdS5jCj4gaW5kZXggZDBiMGEx
NWRiYTg0Li5lMTBjZmE5OTA1N2MgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9pb21tdS9pb21tdS5j
Cj4gKysrIGIvZHJpdmVycy9pb21tdS9pb21tdS5jCj4gQEAgLTI4NzgsMTAgKzI4NzgsMTIgQEAg
RVhQT1JUX1NZTUJPTF9HUEwoaW9tbXVfZndzcGVjX2FkZF9pZHMpOwo+ICAgICovCj4gICBpbnQg
aW9tbXVfZGV2X2VuYWJsZV9mZWF0dXJlKHN0cnVjdCBkZXZpY2UgKmRldiwgZW51bSBpb21tdV9k
ZXZfZmVhdHVyZXMgZmVhdCkKPiAgIHsKPiAtCWNvbnN0IHN0cnVjdCBpb21tdV9vcHMgKm9wcyA9
IGRldi0+YnVzLT5pb21tdV9vcHM7Cj4gKwlpZiAoZGV2LT5pb21tdSAmJiBkZXYtPmlvbW11LT5p
b21tdV9kZXYpIHsKPiArCQljb25zdCBzdHJ1Y3QgaW9tbXVfb3BzICpvcHMgPSBkZXYtPmlvbW11
LT5pb21tdV9kZXYtPm9wczsKPiAgIAo+IC0JaWYgKG9wcyAmJiBvcHMtPmRldl9lbmFibGVfZmVh
dCkKPiAtCQlyZXR1cm4gb3BzLT5kZXZfZW5hYmxlX2ZlYXQoZGV2LCBmZWF0KTsKPiArCQlpZiAo
b3BzLT5kZXZfZW5hYmxlX2ZlYXQpCj4gKwkJCXJldHVybiBvcHMtPmRldl9lbmFibGVfZmVhdChk
ZXYsIGZlYXQpOwo+ICsJfQo+ICAgCj4gICAJcmV0dXJuIC1FTk9ERVY7Cj4gICB9Cj4gQEAgLTI4
OTQsMTAgKzI4OTYsMTIgQEAgRVhQT1JUX1NZTUJPTF9HUEwoaW9tbXVfZGV2X2VuYWJsZV9mZWF0
dXJlKTsKPiAgICAqLwo+ICAgaW50IGlvbW11X2Rldl9kaXNhYmxlX2ZlYXR1cmUoc3RydWN0IGRl
dmljZSAqZGV2LCBlbnVtIGlvbW11X2Rldl9mZWF0dXJlcyBmZWF0KQo+ICAgewo+IC0JY29uc3Qg
c3RydWN0IGlvbW11X29wcyAqb3BzID0gZGV2LT5idXMtPmlvbW11X29wczsKPiArCWlmIChkZXYt
PmlvbW11ICYmIGRldi0+aW9tbXUtPmlvbW11X2Rldikgewo+ICsJCWNvbnN0IHN0cnVjdCBpb21t
dV9vcHMgKm9wcyA9IGRldi0+aW9tbXUtPmlvbW11X2Rldi0+b3BzOwo+ICAgCj4gLQlpZiAob3Bz
ICYmIG9wcy0+ZGV2X2Rpc2FibGVfZmVhdCkKPiAtCQlyZXR1cm4gb3BzLT5kZXZfZGlzYWJsZV9m
ZWF0KGRldiwgZmVhdCk7Cj4gKwkJaWYgKG9wcy0+ZGV2X2Rpc2FibGVfZmVhdCkKPiArCQkJcmV0
dXJuIG9wcy0+ZGV2X2Rpc2FibGVfZmVhdChkZXYsIGZlYXQpOwo+ICsJfQo+ICAgCj4gICAJcmV0
dXJuIC1FQlVTWTsKPiAgIH0KPiBAQCAtMjkwNSwxMCArMjkwOSwxMiBAQCBFWFBPUlRfU1lNQk9M
X0dQTChpb21tdV9kZXZfZGlzYWJsZV9mZWF0dXJlKTsKPiAgIAo+ICAgYm9vbCBpb21tdV9kZXZf
ZmVhdHVyZV9lbmFibGVkKHN0cnVjdCBkZXZpY2UgKmRldiwgZW51bSBpb21tdV9kZXZfZmVhdHVy
ZXMgZmVhdCkKPiAgIHsKPiAtCWNvbnN0IHN0cnVjdCBpb21tdV9vcHMgKm9wcyA9IGRldi0+YnVz
LT5pb21tdV9vcHM7Cj4gKwlpZiAoZGV2LT5pb21tdSAmJiBkZXYtPmlvbW11LT5pb21tdV9kZXYp
IHsKPiArCQljb25zdCBzdHJ1Y3QgaW9tbXVfb3BzICpvcHMgPSBkZXYtPmlvbW11LT5pb21tdV9k
ZXYtPm9wczsKPiAgIAo+IC0JaWYgKG9wcyAmJiBvcHMtPmRldl9mZWF0X2VuYWJsZWQpCj4gLQkJ
cmV0dXJuIG9wcy0+ZGV2X2ZlYXRfZW5hYmxlZChkZXYsIGZlYXQpOwo+ICsJCWlmIChvcHMtPmRl
dl9mZWF0X2VuYWJsZWQpCj4gKwkJCXJldHVybiBvcHMtPmRldl9mZWF0X2VuYWJsZWQoZGV2LCBm
ZWF0KTsKPiArCX0KPiAgIAo+ICAgCXJldHVybiBmYWxzZTsKPiAgIH0KPiAKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0Cmlv
bW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0
aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
