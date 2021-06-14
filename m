Return-Path: <SRS0=DplC=LI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F09B0C2B9F4
	for <iommu@archiver.kernel.org>; Mon, 14 Jun 2021 10:15:25 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99BAC611AB
	for <iommu@archiver.kernel.org>; Mon, 14 Jun 2021 10:15:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99BAC611AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 559CE40350;
	Mon, 14 Jun 2021 10:15:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5r2bQGwjefuj; Mon, 14 Jun 2021 10:15:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 3419C40351;
	Mon, 14 Jun 2021 10:15:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E1B95C000E;
	Mon, 14 Jun 2021 10:15:23 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 14B33C000B
 for <iommu@lists.linux-foundation.org>; Mon, 14 Jun 2021 10:15:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E8F6040169
 for <iommu@lists.linux-foundation.org>; Mon, 14 Jun 2021 10:15:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tQOGHfrUr_GZ for <iommu@lists.linux-foundation.org>;
 Mon, 14 Jun 2021 10:15:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3492C40168
 for <iommu@lists.linux-foundation.org>; Mon, 14 Jun 2021 10:15:21 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8C8EF1FB;
 Mon, 14 Jun 2021 03:15:20 -0700 (PDT)
Received: from [10.57.9.136] (unknown [10.57.9.136])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A89943F694;
 Mon, 14 Jun 2021 03:15:18 -0700 (PDT)
Subject: Re: [PATCH v5 6/8] iommu/arm-smmu-v3: Get associated RMR info and
 install
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
 iommu@lists.linux-foundation.org
References: <20210524110222.2212-1-shameerali.kolothum.thodi@huawei.com>
 <20210524110222.2212-7-shameerali.kolothum.thodi@huawei.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <02fba77a-6180-e8dc-8d62-d95987d536f9@arm.com>
Date: Mon, 14 Jun 2021 11:15:13 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210524110222.2212-7-shameerali.kolothum.thodi@huawei.com>
Content-Language: en-GB
Cc: jon@solid-run.com, linuxarm@huawei.com, steven.price@arm.com,
 guohanjun@huawei.com, yangyicong@huawei.com, Sami.Mujawar@arm.com,
 wanghuiqiang@huawei.com
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

T24gMjAyMS0wNS0yNCAxMjowMiwgU2hhbWVlciBLb2xvdGh1bSB3cm90ZToKPiBDaGVjayBpZiB0
aGVyZSBpcyBhbnkgUk1SIGluZm8gYXNzb2NpYXRlZMKgd2l0aCB0aGUgZGV2aWNlcyBiZWhpbmQK
PiB0aGUgU01NVXYzIGFuZCBpZiBhbnksIGluc3RhbGwgYnlwYXNzIFNURXMgZm9yIHRoZW0uIFRo
aXMgaXMgdG8KPiBrZWVwIGFueSBvbmdvaW5nIHRyYWZmaWMgYXNzb2NpYXRlZCB3aXRoIHRoZXNl
IGRldmljZXMgYWxpdmUKPiB3aGVuIHdlIGVuYWJsZS9yZXNldCBTTU1VdjMgZHVyaW5nIHByb2Jl
KCkuCj4gCj4gU2lnbmVkLW9mZi1ieTogU2hhbWVlciBLb2xvdGh1bSA8c2hhbWVlcmFsaS5rb2xv
dGh1bS50aG9kaUBodWF3ZWkuY29tPgo+IC0tLQo+ICAgZHJpdmVycy9pb21tdS9hcm0vYXJtLXNt
bXUtdjMvYXJtLXNtbXUtdjMuYyB8IDM2ICsrKysrKysrKysrKysrKysrKysrKwo+ICAgMSBmaWxl
IGNoYW5nZWQsIDM2IGluc2VydGlvbnMoKykKPiAKPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pb21t
dS9hcm0vYXJtLXNtbXUtdjMvYXJtLXNtbXUtdjMuYyBiL2RyaXZlcnMvaW9tbXUvYXJtL2FybS1z
bW11LXYzL2FybS1zbW11LXYzLmMKPiBpbmRleCBmOTE5NWI3NDBmNDguLmJlMTU2M2UwNjczMiAx
MDA2NDQKPiAtLS0gYS9kcml2ZXJzL2lvbW11L2FybS9hcm0tc21tdS12My9hcm0tc21tdS12My5j
Cj4gKysrIGIvZHJpdmVycy9pb21tdS9hcm0vYXJtLXNtbXUtdjMvYXJtLXNtbXUtdjMuYwo+IEBA
IC0zNTc0LDYgKzM1NzQsMzkgQEAgc3RhdGljIHZvaWQgX19pb21lbSAqYXJtX3NtbXVfaW9yZW1h
cChzdHJ1Y3QgZGV2aWNlICpkZXYsIHJlc291cmNlX3NpemVfdCBzdGFydCwKPiAgIAlyZXR1cm4g
ZGV2bV9pb3JlbWFwX3Jlc291cmNlKGRldiwgJnJlcyk7Cj4gICB9Cj4gICAKPiArc3RhdGljIHZv
aWQgYXJtX3NtbXVfcm1yX2luc3RhbGxfYnlwYXNzX3N0ZShzdHJ1Y3QgYXJtX3NtbXVfZGV2aWNl
ICpzbW11KQo+ICt7Cj4gKwlzdHJ1Y3QgbGlzdF9oZWFkIHJtcl9saXN0Owo+ICsJc3RydWN0IGlv
bW11X3Jlc3ZfcmVnaW9uICplOwo+ICsJaW50IHJldDsKPiArCj4gKwlJTklUX0xJU1RfSEVBRCgm
cm1yX2xpc3QpOwo+ICsJaWYgKGlvbW11X2RtYV9nZXRfcm1ycyhkZXZfZndub2RlKHNtbXUtPmRl
diksICZybXJfbGlzdCkpCj4gKwkJcmV0dXJuOwo+ICsKPiArCS8qCj4gKwkgKiBTaW5jZSwgd2Ug
ZG9uJ3QgaGF2ZSBhIG1lY2hhbmlzbSB0byBkaWZmZXJlbnRpYXRlIHRoZSBSTVIKPiArCSAqIFNJ
RHMgdGhhdCBoYXMgYW4gb25nb2luZyBsaXZlIHN0cmVhbSwgaW5zdGFsbCBieXBhc3MgU1RFcwo+
ICsJICogZm9yIGFsbCB0aGUgcmVwb3J0ZWQgb25lcy4KPiArCSAqLwoKSSBkb24ndCByZWFsbHkg
Zm9sbG93IHRoYXQgY29tbWVudC4gVGhlIHBvaW50IG9mIGJlaW5nIHJlc2VydmVkIGlzIHRoYXQg
CndlIGRvbid0IGtub3cgaG93IGFuZCB3aHkgdGhlIGRldmljZSBpcyB1c2luZyB0aGVtLCBhbmQg
d2UgaGF2ZSBsaXR0bGUgCm5lZWQgdG8gY2FyZSAtIHdlIGFyZSBzaW1wbHkgcmVxdWlyZWQgdG8g
cHJlc2VydmUgYW4gZWZmZWN0aXZlIHVuaXR5IAptYXBwaW5nIGF0IGFsbCB0aW1lcy4gSSBkb24n
dCBzZWUgYW55IHZhbHVlIGluIHRyeWluZyB0byBzZWNvbmQtZ3Vlc3MgCnRoaW5ncyBiZXlvbmQg
dGhhdCwgYXMgdGhpcyBhcHBlYXJzIHRvIHN1Z2dlc3QuCgpSb2Jpbi4KCj4gKwlsaXN0X2Zvcl9l
YWNoX2VudHJ5KGUsICZybXJfbGlzdCwgbGlzdCkgewo+ICsJCV9fbGU2NCAqc3RlcDsKPiArCQl1
MzIgc2lkID0gZS0+ZndfZGF0YS5ybXIuc2lkOwo+ICsKPiArCQlyZXQgPSBhcm1fc21tdV9pbml0
X3NpZF9zdHJ0YWIoc21tdSwgc2lkKTsKPiArCQlpZiAocmV0KSB7Cj4gKwkJCWRldl9lcnIoc21t
dS0+ZGV2LCAiUk1SIGJ5cGFzcygweCV4KSBmYWlsZWRcbiIsCj4gKwkJCQlzaWQpOwo+ICsJCQlj
b250aW51ZTsKPiArCQl9Cj4gKwo+ICsJCXN0ZXAgPSBhcm1fc21tdV9nZXRfc3RlcF9mb3Jfc2lk
KHNtbXUsIHNpZCk7Cj4gKwkJYXJtX3NtbXVfd3JpdGVfc3RydGFiX2VudChOVUxMLCBzaWQsIHN0
ZXAsIHRydWUpOwo+ICsJfQo+ICsKPiArCWlvbW11X2RtYV9wdXRfcm1ycyhkZXZfZndub2RlKHNt
bXUtPmRldiksICZybXJfbGlzdCk7Cj4gK30KPiArCj4gICBzdGF0aWMgaW50IGFybV9zbW11X2Rl
dmljZV9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQo+ICAgewo+ICAgCWludCBp
cnEsIHJldDsKPiBAQCAtMzY1Nyw2ICszNjkwLDkgQEAgc3RhdGljIGludCBhcm1fc21tdV9kZXZp
Y2VfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikKPiAgIAkvKiBSZWNvcmQgb3Vy
IHByaXZhdGUgZGV2aWNlIHN0cnVjdHVyZSAqLwo+ICAgCXBsYXRmb3JtX3NldF9kcnZkYXRhKHBk
ZXYsIHNtbXUpOwo+ICAgCj4gKwkvKiBDaGVjayBmb3IgUk1ScyBhbmQgaW5zdGFsbCBieXBhc3Mg
U1RFcyBpZiBhbnkgKi8KPiArCWFybV9zbW11X3Jtcl9pbnN0YWxsX2J5cGFzc19zdGUoc21tdSk7
Cj4gKwo+ICAgCS8qIFJlc2V0IHRoZSBkZXZpY2UgKi8KPiAgIAlyZXQgPSBhcm1fc21tdV9kZXZp
Y2VfcmVzZXQoc21tdSwgYnlwYXNzKTsKPiAgIAlpZiAocmV0KQo+IApfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVA
bGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24u
b3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
