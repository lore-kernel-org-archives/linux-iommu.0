Return-Path: <SRS0=7V87=LJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7DC3C48BE8
	for <iommu@archiver.kernel.org>; Tue, 15 Jun 2021 08:25:23 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D0D26100B
	for <iommu@archiver.kernel.org>; Tue, 15 Jun 2021 08:25:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D0D26100B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 269424026E;
	Tue, 15 Jun 2021 08:25:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 16qExGwSF3zj; Tue, 15 Jun 2021 08:25:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 17D5940025;
	Tue, 15 Jun 2021 08:25:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C7480C000D;
	Tue, 15 Jun 2021 08:25:21 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 138A2C000B
 for <iommu@lists.linux-foundation.org>; Tue, 15 Jun 2021 08:25:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E73F340106
 for <iommu@lists.linux-foundation.org>; Tue, 15 Jun 2021 08:25:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EWcstfTtxsct for <iommu@lists.linux-foundation.org>;
 Tue, 15 Jun 2021 08:25:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp2.osuosl.org (Postfix) with ESMTP id E3B7B40025
 for <iommu@lists.linux-foundation.org>; Tue, 15 Jun 2021 08:25:18 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7C362D6E;
 Tue, 15 Jun 2021 01:25:17 -0700 (PDT)
Received: from [10.57.9.136] (unknown [10.57.9.136])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EF4AC3F694;
 Tue, 15 Jun 2021 01:25:15 -0700 (PDT)
Subject: Re: [PATCH v12 3/5] iommu/vt-d: Add support for IOMMU default DMA
 mode build options
To: Lu Baolu <baolu.lu@linux.intel.com>, John Garry <john.garry@huawei.com>,
 joro@8bytes.org, will@kernel.org, dwmw2@infradead.org
References: <1623414043-40745-1-git-send-email-john.garry@huawei.com>
 <1623414043-40745-4-git-send-email-john.garry@huawei.com>
 <f3940a3f-d1c1-148d-e4b5-51cecf924ff5@linux.intel.com>
 <03675e2f-c3a6-ce33-ef96-f9ae544b2d13@huawei.com>
 <824db374-dc82-a9ea-b162-2f51e70ef999@linux.intel.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <c3e1bb30-e1a9-08d7-0787-06a0bb119461@arm.com>
Date: Tue, 15 Jun 2021 09:25:10 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <824db374-dc82-a9ea-b162-2f51e70ef999@linux.intel.com>
Content-Language: en-GB
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 linuxarm@huawei.com
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

T24gMjAyMS0wNi0xNSAwODoyNiwgTHUgQmFvbHUgd3JvdGU6Cj4gSGkgSm9obiwKPiAKPiBPbiA2
LzE0LzIxIDQ6MDMgUE0sIEpvaG4gR2Fycnkgd3JvdGU6Cj4+IE9uIDEyLzA2LzIwMjEgMDM6MTQs
IEx1IEJhb2x1IHdyb3RlOgo+Pj4gT24gMjAyMS82LzExIDIwOjIwLCBKb2huIEdhcnJ5IHdyb3Rl
Ogo+Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L0tjb25maWcgYi9kcml2ZXJzL2lvbW11
L0tjb25maWcKPj4+PiBpbmRleCAyYTcxMzQ3NjExZDQuLjQ0NjczNTNmOTgxYiAxMDA2NDQKPj4+
PiAtLS0gYS9kcml2ZXJzL2lvbW11L0tjb25maWcKPj4+PiArKysgYi9kcml2ZXJzL2lvbW11L0tj
b25maWcKPj4+PiBAQCAtOTQsNiArOTQsNyBAQCBjaG9pY2UKPj4+PiDCoMKgwqDCoMKgIHByb21w
dCAiSU9NTVUgZGVmYXVsdCBETUEgbW9kZSIKPj4+PiDCoMKgwqDCoMKgIGRlcGVuZHMgb24gSU9N
TVVfRE1BCj4+Pj4gK8KgwqDCoCBkZWZhdWx0IElPTU1VX0RFRkFVTFRfTEFaWSBpZiBJTlRFTF9J
T01NVQo+Pj4+IMKgwqDCoMKgwqAgZGVmYXVsdCBJT01NVV9ERUZBVUxUX1NUUklDVAo+Pj4KPj4+
IElmIHR3byBkZWZhdWx0IHZhbHVlcyBhcmUgZGlmZmVyZW50LiBXaGljaCBvbmUgd2lsbCBiZSBv
dmVycmlkZGVuPwo+Pgo+PiBJZiBJIHVuZGVyc3RhbmQgeW91ciBxdWVzdGlvbiBjb3JyZWN0bHks
IEkgdGhpbmsgeW91IGFyZSBhc2tpbmcgaWYgCj4+IGJvdGggYXJlIHNldDoKPj4gQ09ORklHX0lP
TU1VX0RFRkFVTFRfTEFaWT15Cj4+IENPTkZJR19JT01NVV9ERUZBVUxUX1NUUklDVD15Cj4+Cj4+
IElmIHRoaXMgaGFwcGVucywgdGhlbiBtYWtlIGRlZmNvbmZpZyBjb21wbGFpbnMgYWJvdXQgYm90
aCBiZWluZyBzZXQsIAo+PiBhbmQgc2VsZWN0cyB0aGUgMm5kLCB3aGF0ZXZlciB0aGF0IGlzLgo+
IAo+IE9uIHg4NiwgSW50ZWwgb3IgQU1ELCB0aGlzIHdpbGwgYmUKPiAKPiAgwqDCoMKgwqBwcm9t
cHQgIklPTU1VIGRlZmF1bHQgRE1BIG1vZGUiCj4gIMKgwqDCoMKgwqAgZGVwZW5kcyBvbiBJT01N
VV9ETUEKPiAgwqDCoMKgwqDCoCBkZWZhdWx0IElPTU1VX0RFRkFVTFRfTEFaWQo+ICDCoMKgwqDC
oMKgIGRlZmF1bHQgSU9NTVVfREVGQVVMVF9TVFJJQ1QKPiAKPiB3aGljaCB3aWxsIGJlIGRlZmF1
bHQsIExBWlkgb3IgU1RSSUNUPyBXaWxsIGl0IGNhdXNlIGNvbXBsYWlucz8KClNlZSBEb2N1bWVu
dGF0aW9uL2tidWlsZC9rY29uZmlnLWxhbmd1YWdlLnJzdDoKCiAgIEEgY29uZmlnIG9wdGlvbiBj
YW4gaGF2ZSBhbnkgbnVtYmVyIG9mIGRlZmF1bHQgdmFsdWVzLiBJZiBtdWx0aXBsZQogICBkZWZh
dWx0IHZhbHVlcyBhcmUgdmlzaWJsZSwgb25seSB0aGUgZmlyc3QgZGVmaW5lZCBvbmUgaXMgYWN0
aXZlLgoKClJvYmluLgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcK
aHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
