Return-Path: <SRS0=GV0T=MW=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D753C4338F
	for <iommu@archiver.kernel.org>; Fri, 30 Jul 2021 06:12:21 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D86360F9B
	for <iommu@archiver.kernel.org>; Fri, 30 Jul 2021 06:12:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2D86360F9B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id EEBCF40354;
	Fri, 30 Jul 2021 06:12:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Rxijs_6mc2LO; Fri, 30 Jul 2021 06:12:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 98088400F8;
	Fri, 30 Jul 2021 06:12:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 70B99C001A;
	Fri, 30 Jul 2021 06:12:19 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6126FC000E
 for <iommu@lists.linux-foundation.org>; Fri, 30 Jul 2021 06:12:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 40CE2401B3
 for <iommu@lists.linux-foundation.org>; Fri, 30 Jul 2021 06:12:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MhPLZoxI9UIR for <iommu@lists.linux-foundation.org>;
 Fri, 30 Jul 2021 06:12:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by smtp2.osuosl.org (Postfix) with ESMTPS id EE120400F8
 for <iommu@lists.linux-foundation.org>; Fri, 30 Jul 2021 06:12:15 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10060"; a="192633882"
X-IronPort-AV: E=Sophos;i="5.84,281,1620716400"; d="scan'208";a="192633882"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jul 2021 23:12:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,281,1620716400"; d="scan'208";a="465345103"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118])
 ([10.239.159.118])
 by orsmga008.jf.intel.com with ESMTP; 29 Jul 2021 23:12:12 -0700
Subject: Re: [PATCH v2 18/24] iommu: Express DMA strictness via the domain type
To: Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org, will@kernel.org
References: <cover.1627468308.git.robin.murphy@arm.com>
 <50bee17e9248ccfccb33a10238210d4ff4f4cf4d.1627468309.git.robin.murphy@arm.com>
 <b479f1f9-ecf2-2798-2df8-ae3d4c06bc63@linux.intel.com>
 <f2858a7f-e665-ff6a-38d6-b9d591287fac@arm.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <f53f2cda-c219-ec61-7698-7efbcaf48ac9@linux.intel.com>
Date: Fri, 30 Jul 2021 14:09:54 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <f2858a7f-e665-ff6a-38d6-b9d591287fac@arm.com>
Content-Language: en-US
Cc: linux-kernel@vger.kernel.org, dianders@chromium.org,
 iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org
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

T24gNy8yOS8yMSA1OjM2IFBNLCBSb2JpbiBNdXJwaHkgd3JvdGU6Cj4gT24gMjAyMS0wNy0yOSAw
ODoxMywgTHUgQmFvbHUgd3JvdGU6Cj4+IEhpIFJvYmluLAo+Pgo+PiBPbiA3LzI4LzIxIDExOjU4
IFBNLCBSb2JpbiBNdXJwaHkgd3JvdGU6Cj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pb21tdS9p
b21tdS5jIGIvZHJpdmVycy9pb21tdS9pb21tdS5jCj4+PiBpbmRleCA5ODI1NDUyMzRjZjMuLmVl
Y2I1NjU3ZGU2OSAxMDA2NDQKPj4+IC0tLSBhL2RyaXZlcnMvaW9tbXUvaW9tbXUuYwo+Pj4gKysr
IGIvZHJpdmVycy9pb21tdS9pb21tdS5jCj4+PiBAQCAtMTM2LDYgKzEzNiw5IEBAIHN0YXRpYyBp
bnQgX19pbml0IGlvbW11X3N1YnN5c19pbml0KHZvaWQpCj4+PiDCoMKgwqDCoMKgwqDCoMKgwqAg
fQo+Pj4gwqDCoMKgwqDCoCB9Cj4+PiArwqDCoMKgIGlmICghaW9tbXVfZGVmYXVsdF9wYXNzdGhy
b3VnaCgpICYmICFpb21tdV9kbWFfc3RyaWN0KQo+Pj4gK8KgwqDCoMKgwqDCoMKgIGlvbW11X2Rl
Zl9kb21haW5fdHlwZSA9IElPTU1VX0RPTUFJTl9ETUFfRlE7Cj4+Cj4+IGlvbW11X2RtYV9zdHJp
Y3QgY291bGQgYmUgY2hhbmdlZCBsYXRlciBieSB0aGUgdmVuZG9yIGlvbW11IGRyaXZlciB2aWEK
Pj4gaW9tbXVfc2V0X2RtYV9zdHJpY3QoKS4gVGhpcyBzZWVtcyBub3QgdG8gYmUgdGhlIHJpZ2h0
IHBsYWNlIHRvIHNldAo+PiBpb21tdV9kZWZfZG9tYWluX3R5cGUuCj4gCj4gQWggeWVzLCBnb29k
IGNhdGNoIG9uY2UgYWdhaW4sIHRoYW5rcyEKPiAKPiBJIHRoaW5rIHRoaXMgKmlzKiB0aGUgcmln
aHQgcGxhY2UgdG8gaW5pdGlhbGx5IHNldCBpdCB0byBob25vdXIgdGhlIAo+IGNvbW1hbmQtbGlu
ZSBvcHRpb24sIHNpbmNlIHRoYXQgbWF0Y2hlcyB3aGF0IHdlIGRvIGZvciBwYXNzdGhyb3VnaC4g
Cj4gSG93ZXZlciBhbHNvIGxpa2UgcGFzc3Rocm91Z2ggd2UnbGwgbmVlZCB0byBrZWVwIHRoaW5n
cyBpbiBzeW5jIGlmIGl0J3MgCj4gdXBkYXRlZCBsYXRlciwgbGlrZSB0aGlzOgo+IAo+IAo+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L2lvbW11LmMgYi9kcml2ZXJzL2lvbW11L2lvbW11LmMK
PiBpbmRleCA4N2Q3YjI5OTQzNmUuLjU5M2Q0NTU1YmM1NyAxMDA2NDQKPiAtLS0gYS9kcml2ZXJz
L2lvbW11L2lvbW11LmMKPiArKysgYi9kcml2ZXJzL2lvbW11L2lvbW11LmMKPiBAQCAtMzU5LDYg
KzM1OSw4IEBAIGVhcmx5X3BhcmFtKCJpb21tdS5zdHJpY3QiLCBpb21tdV9kbWFfc2V0dXApOwo+
ICDCoHZvaWQgaW9tbXVfc2V0X2RtYV9zdHJpY3Qodm9pZCkKPiAgwqB7Cj4gIMKgwqDCoMKgwqDC
oMKgIGlvbW11X2RtYV9zdHJpY3QgPSB0cnVlOwo+ICvCoMKgwqDCoMKgwqAgaWYgKGlvbW11X2Rl
Zl9kb21haW5fdHlwZSA9PSBJT01NVV9ET01BSU5fRE1BX0ZRKQo+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIGlvbW11X2RlZl9kb21haW5fdHlwZSA9IElPTU1VX0RPTUFJTl9ETUE7Cj4g
IMKgfQo+IAo+ICDCoHN0YXRpYyBzc2l6ZV90IGlvbW11X2dyb3VwX2F0dHJfc2hvdyhzdHJ1Y3Qg
a29iamVjdCAqa29iaiwKPiAKPiAKPiBEb2VzIHRoYXQgc2VlbSByZWFzb25hYmxlPyBJJ20gbm90
IHN1cmUgdGhlcmUncyBhbnkgY2xlYW5lciB3YXkgdG8gZG8gaXQgCj4gc2luY2Ugd2UgZG9uJ3Qg
d2FudCB0byBpbmFkdmVydGVudGx5IGNsb2JiZXIgdGhlIGRlZmF1bHQgdHlwZSBpZiB0aGUgCj4g
dXNlciBoYXMgZ2l2ZW4gdXMgc29tZXRoaW5nIGZ1bmt5IGxpa2UgImludGVsX2lvbW11PXN0cmlj
dCAKPiBpb21tdS5wYXNzdGhyb3VnaD0xIi4KPiAKPiBDaGVlcnMsCj4gUm9iaW4uCj4gCj4+Cj4+
PiArCj4+PiDCoMKgwqDCoMKgIHByX2luZm8oIkRlZmF1bHQgZG9tYWluIHR5cGU6ICVzICVzXG4i
LAo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgIGlvbW11X2RvbWFpbl90eXBlX3N0cihpb21tdV9kZWZf
ZG9tYWluX3R5cGUpLAo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgIChpb21tdV9jbWRfbGluZSAmIElP
TU1VX0NNRF9MSU5FX0RNQV9BUEkpID8KPj4KPj4gQmVzdCByZWdhcmRzLAo+PiBiYW9sdQoKV2l0
aCBhYm92ZSBmaXhlZCwKClJldmlld2VkLWJ5OiBMdSBCYW9sdSA8YmFvbHUubHVAbGludXguaW50
ZWwuY29tPgoKQmVzdCByZWdhcmRzLApiYW9sdQpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgt
Zm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4v
bGlzdGluZm8vaW9tbXU=
