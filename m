Return-Path: <SRS0=DplC=LI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00EAFC2B9F4
	for <iommu@archiver.kernel.org>; Mon, 14 Jun 2021 10:23:20 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9588611BE
	for <iommu@archiver.kernel.org>; Mon, 14 Jun 2021 10:23:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9588611BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 74A7783B2B;
	Mon, 14 Jun 2021 10:23:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id td28u1Tm93rg; Mon, 14 Jun 2021 10:23:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 7A03583A6F;
	Mon, 14 Jun 2021 10:23:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 35FECC000E;
	Mon, 14 Jun 2021 10:23:17 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 391BFC000B
 for <iommu@lists.linux-foundation.org>; Mon, 14 Jun 2021 10:23:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 27C4283A6F
 for <iommu@lists.linux-foundation.org>; Mon, 14 Jun 2021 10:23:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qb_HRSLXK7uR for <iommu@lists.linux-foundation.org>;
 Mon, 14 Jun 2021 10:23:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7976582F31
 for <iommu@lists.linux-foundation.org>; Mon, 14 Jun 2021 10:23:15 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D144A1FB;
 Mon, 14 Jun 2021 03:23:14 -0700 (PDT)
Received: from [10.57.9.136] (unknown [10.57.9.136])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C1A973F694;
 Mon, 14 Jun 2021 03:23:12 -0700 (PDT)
Subject: =?UTF-8?Q?Re=3a_=5bPATCH_v5_5/8=5d_iommu/arm-smmu-v3=3a_Add_bypass_?=
 =?UTF-8?B?ZmxhZyB0b8KgYXJtX3NtbXVfd3JpdGVfc3RydGFiX2VudCgp?=
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
 iommu@lists.linux-foundation.org
References: <20210524110222.2212-1-shameerali.kolothum.thodi@huawei.com>
 <20210524110222.2212-6-shameerali.kolothum.thodi@huawei.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <ab9a8ca2-8611-2dcc-8b03-e13715521905@arm.com>
Date: Mon, 14 Jun 2021 11:23:07 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210524110222.2212-6-shameerali.kolothum.thodi@huawei.com>
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

T24gMjAyMS0wNS0yNCAxMjowMiwgU2hhbWVlciBLb2xvdGh1bSB3cm90ZToKPiBCeSBkZWZhdWx0
LMKgZGlzYWJsZV9ieXBhc3MgaXMgc2V0IGFuZCBhbnkgZGV2IHdpdGhvdXQgYW4gaW9tbXUgZG9t
YWluCj4gaW5zdGFsbHMgU1RFIHdpdGggQ0ZHX0FCT1JUIGR1cmluZ8KgYXJtX3NtbXVfaW5pdF9i
eXBhc3Nfc3RlcygpLiBJbnRyb2R1Y2UKPiBhICJieXBhc3MiIGZsYWcgdG/CoGFybV9zbW11X3dy
aXRlX3N0cnRhYl9lbnQoKSBzbyB0aGF0IHdlIGNhbiBmb3JjZSBpdCB0bwo+IGluc3RhbGzCoENG
R19CWVBBU1MgU1RFIGZvciBzcGVjaWZpYyBTSURzLiBUaGlzIHdpbGwgYmXCoHVzZWZ1bMKgaW4g
Zm9sbG93Cj4gdXAgcGF0Y2ggdG8gaW5zdGFsbCBieXBhc3MgZm9yIElPUlQgUk1SIFNJRHMuCj4g
Cj4gU2lnbmVkLW9mZi1ieTogU2hhbWVlciBLb2xvdGh1bSA8c2hhbWVlcmFsaS5rb2xvdGh1bS50
aG9kaUBodWF3ZWkuY29tPgo+IC0tLQo+ICAgZHJpdmVycy9pb21tdS9hcm0vYXJtLXNtbXUtdjMv
YXJtLXNtbXUtdjMuYyB8IDggKysrKy0tLS0KPiAgIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlv
bnMoKyksIDQgZGVsZXRpb25zKC0pCj4gCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW9tbXUvYXJt
L2FybS1zbW11LXYzL2FybS1zbW11LXYzLmMgYi9kcml2ZXJzL2lvbW11L2FybS9hcm0tc21tdS12
My9hcm0tc21tdS12My5jCj4gaW5kZXggNzU0YmFkNjA5MmMxLi5mOTE5NWI3NDBmNDggMTAwNjQ0
Cj4gLS0tIGEvZHJpdmVycy9pb21tdS9hcm0vYXJtLXNtbXUtdjMvYXJtLXNtbXUtdjMuYwo+ICsr
KyBiL2RyaXZlcnMvaW9tbXUvYXJtL2FybS1zbW11LXYzL2FybS1zbW11LXYzLmMKPiBAQCAtMTE3
NCw3ICsxMTc0LDcgQEAgc3RhdGljIHZvaWQgYXJtX3NtbXVfc3luY19zdGVfZm9yX3NpZChzdHJ1
Y3QgYXJtX3NtbXVfZGV2aWNlICpzbW11LCB1MzIgc2lkKQo+ICAgfQo+ICAgCj4gICBzdGF0aWMg
dm9pZCBhcm1fc21tdV93cml0ZV9zdHJ0YWJfZW50KHN0cnVjdCBhcm1fc21tdV9tYXN0ZXIgKm1h
c3RlciwgdTMyIHNpZCwKPiAtCQkJCSAgICAgIF9fbGU2NCAqZHN0KQo+ICsJCQkJICAgICAgX19s
ZTY0ICpkc3QsIGJvb2wgYnlwYXNzKQo+ICAgewo+ICAgCS8qCj4gICAJICogVGhpcyBpcyBoaWRl
b3VzbHkgY29tcGxpY2F0ZWQsIGJ1dCB3ZSBvbmx5IHJlYWxseSBjYXJlIGFib3V0Cj4gQEAgLTEy
NDUsNyArMTI0NSw3IEBAIHN0YXRpYyB2b2lkIGFybV9zbW11X3dyaXRlX3N0cnRhYl9lbnQoc3Ry
dWN0IGFybV9zbW11X21hc3RlciAqbWFzdGVyLCB1MzIgc2lkLAo+ICAgCj4gICAJLyogQnlwYXNz
L2ZhdWx0ICovCj4gICAJaWYgKCFzbW11X2RvbWFpbiB8fCAhKHMxX2NmZyB8fCBzMl9jZmcpKSB7
Cj4gLQkJaWYgKCFzbW11X2RvbWFpbiAmJiBkaXNhYmxlX2J5cGFzcykKPiArCQlpZiAoIXNtbXVf
ZG9tYWluICYmIGRpc2FibGVfYnlwYXNzICYmICFieXBhc3MpCgpVbW0uLi4KCj4gICAJCQl2YWwg
fD0gRklFTERfUFJFUChTVFJUQUJfU1RFXzBfQ0ZHLCBTVFJUQUJfU1RFXzBfQ0ZHX0FCT1JUKTsK
PiAgIAkJZWxzZQo+ICAgCQkJdmFsIHw9IEZJRUxEX1BSRVAoU1RSVEFCX1NURV8wX0NGRywgU1RS
VEFCX1NURV8wX0NGR19CWVBBU1MpOwo+IEBAIC0xMzIwLDcgKzEzMjAsNyBAQCBzdGF0aWMgdm9p
ZCBhcm1fc21tdV9pbml0X2J5cGFzc19zdGVzKF9fbGU2NCAqc3RydGFiLCB1bnNpZ25lZCBpbnQg
bmVudCkKPiAgIAl1bnNpZ25lZCBpbnQgaTsKPiAgIAo+ICAgCWZvciAoaSA9IDA7IGkgPCBuZW50
OyArK2kpIHsKPiAtCQlhcm1fc21tdV93cml0ZV9zdHJ0YWJfZW50KE5VTEwsIC0xLCBzdHJ0YWIp
Owo+ICsJCWFybV9zbW11X3dyaXRlX3N0cnRhYl9lbnQoTlVMTCwgLTEsIHN0cnRhYiwgZmFsc2Up
OwoKLi4uYW5kIGluIHBhcnRpY3VsYXIsIGFuIG9wZXJhdGlvbiBuYW1lZCAiaW5pdF9ieXBhc3Nf
c3RlcyIgcGFzc2luZyAKYnlwYXNzPWZhbHNlIGlzIGp1c3QgYnJlYWtpbmcgbXkgYnJhaW4uIENh
biB3ZSBwdWxsIHRoZSBsb2dpYyBmb3IgCmRlZmF1bHQgYnlwYXNzL2ZhdWx0IG91dCB0byBoZXJl
IGFzIHBhcnQgb2YgdGhlIHJlZmFjdG9yaW5nIHNvIHRoYXQgaXQgCmFjdHVhbGx5IG1ha2VzIHNl
bnNlPwoKUm9iaW4uCgo+ICAgCQlzdHJ0YWIgKz0gU1RSVEFCX1NURV9EV09SRFM7Cj4gICAJfQo+
ICAgfQo+IEBAIC0yMDk3LDcgKzIwOTcsNyBAQCBzdGF0aWMgdm9pZCBhcm1fc21tdV9pbnN0YWxs
X3N0ZV9mb3JfZGV2KHN0cnVjdCBhcm1fc21tdV9tYXN0ZXIgKm1hc3RlcikKPiAgIAkJaWYgKGog
PCBpKQo+ICAgCQkJY29udGludWU7Cj4gICAKPiAtCQlhcm1fc21tdV93cml0ZV9zdHJ0YWJfZW50
KG1hc3Rlciwgc2lkLCBzdGVwKTsKPiArCQlhcm1fc21tdV93cml0ZV9zdHJ0YWJfZW50KG1hc3Rl
ciwgc2lkLCBzdGVwLCBmYWxzZSk7Cj4gICAJfQo+ICAgfQo+ICAgCj4gCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21t
dUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlv
bi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
