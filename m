Return-Path: <SRS0=6gDp=FO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A222C433FE
	for <iommu@archiver.kernel.org>; Thu, 10 Dec 2020 10:26:25 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B03323A7C
	for <iommu@archiver.kernel.org>; Thu, 10 Dec 2020 10:26:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B03323A7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 802172044A;
	Thu, 10 Dec 2020 10:26:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3rCfpf4lzULY; Thu, 10 Dec 2020 10:26:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id E520420468;
	Thu, 10 Dec 2020 10:26:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B8823C0893;
	Thu, 10 Dec 2020 10:26:18 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1E65EC013B
 for <iommu@lists.linux-foundation.org>; Thu, 10 Dec 2020 10:26:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id F04A9204B3
 for <iommu@lists.linux-foundation.org>; Thu, 10 Dec 2020 10:26:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ce9Nqsr9Ldkm for <iommu@lists.linux-foundation.org>;
 Thu, 10 Dec 2020 10:26:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by silver.osuosl.org (Postfix) with ESMTP id 6850720515
 for <iommu@lists.linux-foundation.org>; Thu, 10 Dec 2020 10:26:08 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4D0BB31B;
 Thu, 10 Dec 2020 02:26:07 -0800 (PST)
Received: from [192.168.1.179] (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9DB713F718;
 Thu, 10 Dec 2020 02:26:05 -0800 (PST)
Subject: Re: [RFC PATCH v2 0/8] ACPI/IORT: Support for IORT RMR node
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
 iommu@lists.linux-foundation.org, devel@acpica.org
References: <20201119121150.3316-1-shameerali.kolothum.thodi@huawei.com>
From: Steven Price <steven.price@arm.com>
Message-ID: <e9837ba5-deeb-c64c-2261-d0ab82eebfac@arm.com>
Date: Thu, 10 Dec 2020 10:25:37 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201119121150.3316-1-shameerali.kolothum.thodi@huawei.com>
Content-Language: en-GB
Cc: linuxarm@huawei.com, guohanjun@huawei.com, Sami.Mujawar@arm.com,
 robin.murphy@arm.com, wanghuiqiang@huawei.com
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

T24gMTkvMTEvMjAyMCAxMjoxMSwgU2hhbWVlciBLb2xvdGh1bSB3cm90ZToKPiBSRkMgdjEgLS0+
IHYyOgo+ICDCoC0gQWRkZWQgYSBnZW5lcmljIGludGVyZmFjZSBmb3IgSU9NTVUgZHJpdmVycyB0
byByZXRyaWV2ZSBhbGwgdGhlCj4gIMKgIMKgUk1SIGluZm8gYXNzb2NpYXRlZCB3aXRoIGEgZ2l2
ZW4gSU9NTVUuCj4gIMKgLSBTTU1VdjMgZHJpdmVyIGdldHMgdGhlIFJNUiBsaXN0IGR1cmluZyBw
cm9iZSgpIGFuZCBpbnN0YWxscwo+ICDCoMKgIGJ5cGFzcyBTVEVzIGZvciBhbGwgdGhlIFNJRHMg
aW4gdGhlIFJNUiBsaXN0LiBUaGlzIGlzIHRvIGtlZXAKPiAgIMKgIHRoZSBvbmdvaW5nIHRyYWZm
aWMgYWxpdmUoaWYgYW55KSBkdXJpbmcgU01NVXYzIHJlc2V0LiBUaGlzIGlzCj4gICAgIGJhc2Vk
IG9uIHRoZSBzdWdnZXN0aW9ucyByZWNlaXZlZCBmb3IgdjEgdG8gdGFrZSBjYXJlIG9mIHRoZQo+
ICAgICBFRkkgZnJhbWVidWZmZXIgdXNlIGNhc2UuIE9ubHkgc2FuaXR5IHRlc3RlZCBmb3Igbm93
LgoKSGkgU2hhbWVlciwKClNvcnJ5IGZvciBub3QgbG9va2luZyBhdCB0aGlzIGJlZm9yZS4KCkRv
IHlvdSBoYXZlIGFueSBwbGFucyB0byBpbXBsZW1lbnQgc3VwcG9ydCBpbiB0aGUgU01NVXYyIGRy
aXZlcj8gVGhlIApwbGF0Zm9ybSBJJ3ZlIGJlZW4gdGVzdGluZyB0aGUgRUZJIGZyYW1lYnVmZmVy
IHN1cHBvcnQgb24gaGFzIHRoZSAKZGlzcGxheSBjb250cm9sbGVyIGJlaGluZCBTTU1VdjIsIHNv
IGFzIGl0IHN0YW5kcyB0aGlzIHNlcmllcyBkb2Vzbid0IAp3b3JrLiBJIGRpZCBoYWNrIHNvbWV0
aGluZyB1cCBmb3IgU01NVXYyIHNvIEkgd2FzIGFibGUgdG8gdGVzdCB0aGUgZmlyc3QgCjQgcGF0
Y2hlcy4KCj4gIMKgLSBEdXJpbmcgdGhlIHByb2JlL2F0dGFjaCBkZXZpY2UsIFNNTVV2MyBkcml2
ZXIgcmVzZXJ2ZXMgYW55Cj4gIMKgIMKgUk1SIHJlZ2lvbiBhc3NvY2lhdGVkIHdpdGggdGhlIGRl
dmljZSBzdWNoIHRoYXQgdGhlcmUgaXMgYSB1bml0eQo+ICDCoCDCoG1hcHBpbmcgZm9yIHRoZW0g
aW4gU01NVS4KCkZvciB0aGUgRUZJIGZyYW1lYnVmZmVyIHVzZSBjYXNlIHRoZXJlIGlzIG5vIGRl
dmljZSB0byBhdHRhY2ggc28gSSAKYmVsaWV2ZSB3ZSBhcmUgbGVmdCB3aXRoIGp1c3QgdGhlIHN0
cmVhbSBJRCBpbiBieXBhc3MgbW9kZSAtIHdoaWNoIGlzIApkZWZpbml0ZWx5IGFuIGltcHJvdmVt
ZW50ICh0aGUgZGlzcGxheSB3b3JrcyEpIGJ1dCBub3QgYWN0dWFsbHkgYSB1bml0eSAKbWFwcGlu
ZyBvZiB0aGUgUk1SIHJhbmdlLiBJJ20gbm90IHN1cmUgd2hldGhlciBpdCdzIHdvcnRoIGZpeGlu
ZyB0aGlzIG9yIApub3QsIGJ1dCBJIGp1c3Qgd2FudGVkIHRvIHBvaW50IG91dCB0aGVyZSdzIHN0
aWxsIGEgbmVlZCBmb3IgYSBkcml2ZXIgCmZvciB0aGUgZGV2aWNlIGJlZm9yZSB0aGUgYnlwYXNz
IG1vZGUgaXMgcmVwbGFjZWQgd2l0aCB0aGUgdW5pdHkgbWFwcGluZy4KClRoYW5rcywKClN0ZXZl
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1h
aWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3Rz
LmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
