Return-Path: <SRS0=Qw1r=KC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23D76C433ED
	for <iommu@archiver.kernel.org>; Fri,  7 May 2021 10:01:44 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABFAE61414
	for <iommu@archiver.kernel.org>; Fri,  7 May 2021 10:01:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABFAE61414
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 741884038D;
	Fri,  7 May 2021 10:01:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uSaWMOX6SeSu; Fri,  7 May 2021 10:01:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id 5655140165;
	Fri,  7 May 2021 10:01:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 38BADC000E;
	Fri,  7 May 2021 10:01:42 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2F44BC0001
 for <iommu@lists.linux-foundation.org>; Fri,  7 May 2021 10:01:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0755E4039E
 for <iommu@lists.linux-foundation.org>; Fri,  7 May 2021 10:01:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sHkPy2EF3NeC for <iommu@lists.linux-foundation.org>;
 Fri,  7 May 2021 10:01:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7309E40165
 for <iommu@lists.linux-foundation.org>; Fri,  7 May 2021 10:01:40 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A4E0D113E;
 Fri,  7 May 2021 03:01:39 -0700 (PDT)
Received: from [10.57.59.124] (unknown [10.57.59.124])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5B0163F718;
 Fri,  7 May 2021 03:01:37 -0700 (PDT)
Subject: Re: [PATCH v3 08/10] iommu/arm-smmu-v3: Reserve any RMR regions
 associated with a dev
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
 iommu@lists.linux-foundation.org
References: <20210420082751.1829-1-shameerali.kolothum.thodi@huawei.com>
 <20210420082751.1829-9-shameerali.kolothum.thodi@huawei.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <7ec85477-9c02-17de-9620-f0b153adcc82@arm.com>
Date: Fri, 7 May 2021 11:01:36 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210420082751.1829-9-shameerali.kolothum.thodi@huawei.com>
Content-Language: en-GB
Cc: jon@solid-run.com, linuxarm@huawei.com, steven.price@arm.com,
 guohanjun@huawei.com, Sami.Mujawar@arm.com, wanghuiqiang@huawei.com
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

T24gMjAyMS0wNC0yMCAwOToyNywgU2hhbWVlciBLb2xvdGh1bSB3cm90ZToKPiBHZXQgUk1SIHJl
Z2lvbnMgYXNzb2NpYXRlZCB3aXRoIGEgZGV2wqByZXNlcnZlZCBzbyB0aGF0IHRoZXJlIGlzCj4g
YSB1bml0eSBtYXBwaW5nIGZvciB0aGVtIGluwqBTTU1VLgo+IAo+IFNpZ25lZC1vZmYtYnk6IFNo
YW1lZXIgS29sb3RodW0gPHNoYW1lZXJhbGkua29sb3RodW0udGhvZGlAaHVhd2VpLmNvbT4KPiAt
LS0KPiAgIGRyaXZlcnMvaW9tbXUvYXJtL2FybS1zbW11LXYzL2FybS1zbW11LXYzLmMgfCAyOSAr
KysrKysrKysrKysrKysrKysrKysKPiAgIDEgZmlsZSBjaGFuZ2VkLCAyOSBpbnNlcnRpb25zKCsp
Cj4gCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW9tbXUvYXJtL2FybS1zbW11LXYzL2FybS1zbW11
LXYzLmMgYi9kcml2ZXJzL2lvbW11L2FybS9hcm0tc21tdS12My9hcm0tc21tdS12My5jCj4gaW5k
ZXggMTRlOWM3MDM0YzA0Li44YmFjZWRmN2JiMzQgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9pb21t
dS9hcm0vYXJtLXNtbXUtdjMvYXJtLXNtbXUtdjMuYwo+ICsrKyBiL2RyaXZlcnMvaW9tbXUvYXJt
L2FybS1zbW11LXYzL2FybS1zbW11LXYzLmMKPiBAQCAtMjUzMSw2ICsyNTMxLDM0IEBAIHN0YXRp
YyBpbnQgYXJtX3NtbXVfb2ZfeGxhdGUoc3RydWN0IGRldmljZSAqZGV2LCBzdHJ1Y3Qgb2ZfcGhh
bmRsZV9hcmdzICphcmdzKQo+ICAgCXJldHVybiBpb21tdV9md3NwZWNfYWRkX2lkcyhkZXYsIGFy
Z3MtPmFyZ3MsIDEpOwo+ICAgfQo+ICAgCj4gK3N0YXRpYyBib29sIGFybV9zbW11X2Rldl9oYXNf
cm1yKHN0cnVjdCBhcm1fc21tdV9tYXN0ZXIgKm1hc3RlciwKPiArCQkJCSBzdHJ1Y3QgaW9tbXVf
cm1yICplKQo+ICt7Cj4gKwlpbnQgaTsKPiArCj4gKwlmb3IgKGkgPSAwOyBpIDwgbWFzdGVyLT5u
dW1fc2lkczsgaSsrKSB7Cj4gKwkJaWYgKGUtPnNpZCA9PSBtYXN0ZXItPnNpZHNbaV0pCj4gKwkJ
CXJldHVybiB0cnVlOwo+ICsJfQo+ICsKPiArCXJldHVybiBmYWxzZTsKPiArfQo+ICsKPiArc3Rh
dGljIHZvaWQgYXJtX3NtbXVfcm1yX2dldF9yZXN2X3JlZ2lvbnMoc3RydWN0IGRldmljZSAqZGV2
LAo+ICsJCQkJCSAgc3RydWN0IGxpc3RfaGVhZCAqaGVhZCkKPiArewo+ICsJc3RydWN0IGFybV9z
bW11X21hc3RlciAqbWFzdGVyID0gZGV2X2lvbW11X3ByaXZfZ2V0KGRldik7Cj4gKwlzdHJ1Y3Qg
YXJtX3NtbXVfZGV2aWNlICpzbW11ID0gbWFzdGVyLT5zbW11Owo+ICsJc3RydWN0IGlvbW11X3Jt
ciAqcm1yOwo+ICsKPiArCWxpc3RfZm9yX2VhY2hfZW50cnkocm1yLCAmc21tdS0+cm1yX2xpc3Qs
IGxpc3QpIHsKPiArCQlpZiAoIWFybV9zbW11X2Rldl9oYXNfcm1yKG1hc3Rlciwgcm1yKSkKPiAr
CQkJY29udGludWU7Cj4gKwo+ICsJCWlvbW11X2RtYV9nZXRfcm1yX3Jlc3ZfcmVnaW9ucyhkZXYs
IHJtciwgaGVhZCk7Cj4gKwl9Cj4gK30KPiArCgpUQkggSSB3b3VsZG4ndCBoYXZlIHRob3VnaHQg
d2UgbmVlZCBhIGRyaXZlci1zcGVjaWZpYyBob29rIGZvciB0aGlzLCBvciAKaXMgaXQgdG9vIHBh
aW5mdWwgdG8gY29ycmVsYXRlIGZ3c3BlYy0+aW9tbXVfZndub2RlIGJhY2sgdG8gdGhlIHJlbGV2
YW50IApJT1JUIG5vZGUgZ2VuZXJpY2FsbHk/CgpSb2Jpbi4KCj4gICBzdGF0aWMgdm9pZCBhcm1f
c21tdV9nZXRfcmVzdl9yZWdpb25zKHN0cnVjdCBkZXZpY2UgKmRldiwKPiAgIAkJCQkgICAgICBz
dHJ1Y3QgbGlzdF9oZWFkICpoZWFkKQo+ICAgewo+IEBAIC0yNTQ1LDYgKzI1NzMsNyBAQCBzdGF0
aWMgdm9pZCBhcm1fc21tdV9nZXRfcmVzdl9yZWdpb25zKHN0cnVjdCBkZXZpY2UgKmRldiwKPiAg
IAlsaXN0X2FkZF90YWlsKCZyZWdpb24tPmxpc3QsIGhlYWQpOwo+ICAgCj4gICAJaW9tbXVfZG1h
X2dldF9yZXN2X3JlZ2lvbnMoZGV2LCBoZWFkKTsKPiArCWFybV9zbW11X3Jtcl9nZXRfcmVzdl9y
ZWdpb25zKGRldiwgaGVhZCk7Cj4gICB9Cj4gICAKPiAgIHN0YXRpYyBib29sIGFybV9zbW11X2Rl
dl9oYXNfZmVhdHVyZShzdHJ1Y3QgZGV2aWNlICpkZXYsCj4gCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0
cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcv
bWFpbG1hbi9saXN0aW5mby9pb21tdQ==
