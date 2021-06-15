Return-Path: <SRS0=7V87=LJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51A67C48BE5
	for <iommu@archiver.kernel.org>; Tue, 15 Jun 2021 07:28:02 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEC9561407
	for <iommu@archiver.kernel.org>; Tue, 15 Jun 2021 07:28:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEC9561407
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7A40140275;
	Tue, 15 Jun 2021 07:28:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id m_6S9CU9amom; Tue, 15 Jun 2021 07:28:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 6AABD40106;
	Tue, 15 Jun 2021 07:28:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3A0F0C000E;
	Tue, 15 Jun 2021 07:28:00 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4623FC000B
 for <iommu@lists.linux-foundation.org>; Tue, 15 Jun 2021 07:27:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1EDC36073B
 for <iommu@lists.linux-foundation.org>; Tue, 15 Jun 2021 07:27:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cZxP8WJtiFhE for <iommu@lists.linux-foundation.org>;
 Tue, 15 Jun 2021 07:27:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 14E6360708
 for <iommu@lists.linux-foundation.org>; Tue, 15 Jun 2021 07:27:56 +0000 (UTC)
IronPort-SDR: 25jx4P/ezo07dFDwjddLki7NekzTf0NEJnttzA5E9Z53c+09JdLvPfIxOkqmvaX6eGW+wS70QD
 0MXE8npDomqg==
X-IronPort-AV: E=McAfee;i="6200,9189,10015"; a="204109731"
X-IronPort-AV: E=Sophos;i="5.83,275,1616482800"; d="scan'208";a="204109731"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jun 2021 00:27:53 -0700
IronPort-SDR: NhPtFRnH3Fzy5OVQxBazWhogkyHcuZquz8oQL1Qi6xEiNOXLelQQ3/bGTsFOjDJYnIzoy2wska
 cSHMVG53fLEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,275,1616482800"; d="scan'208";a="554359035"
Received: from unknown (HELO [10.239.159.118]) ([10.239.159.118])
 by fmsmga001.fm.intel.com with ESMTP; 15 Jun 2021 00:27:51 -0700
Subject: Re: [PATCH v12 3/5] iommu/vt-d: Add support for IOMMU default DMA
 mode build options
To: John Garry <john.garry@huawei.com>, joro@8bytes.org, will@kernel.org,
 dwmw2@infradead.org, robin.murphy@arm.com
References: <1623414043-40745-1-git-send-email-john.garry@huawei.com>
 <1623414043-40745-4-git-send-email-john.garry@huawei.com>
 <f3940a3f-d1c1-148d-e4b5-51cecf924ff5@linux.intel.com>
 <03675e2f-c3a6-ce33-ef96-f9ae544b2d13@huawei.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <824db374-dc82-a9ea-b162-2f51e70ef999@linux.intel.com>
Date: Tue, 15 Jun 2021 15:26:26 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <03675e2f-c3a6-ce33-ef96-f9ae544b2d13@huawei.com>
Content-Language: en-US
Cc: linuxarm@huawei.com, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org
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

SGkgSm9obiwKCk9uIDYvMTQvMjEgNDowMyBQTSwgSm9obiBHYXJyeSB3cm90ZToKPiBPbiAxMi8w
Ni8yMDIxIDAzOjE0LCBMdSBCYW9sdSB3cm90ZToKPj4gT24gMjAyMS82LzExIDIwOjIwLCBKb2hu
IEdhcnJ5IHdyb3RlOgo+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW9tbXUvS2NvbmZpZyBiL2Ry
aXZlcnMvaW9tbXUvS2NvbmZpZwo+Pj4gaW5kZXggMmE3MTM0NzYxMWQ0Li40NDY3MzUzZjk4MWIg
MTAwNjQ0Cj4+PiAtLS0gYS9kcml2ZXJzL2lvbW11L0tjb25maWcKPj4+ICsrKyBiL2RyaXZlcnMv
aW9tbXUvS2NvbmZpZwo+Pj4gQEAgLTk0LDYgKzk0LDcgQEAgY2hvaWNlCj4+PiDCoMKgwqDCoMKg
IHByb21wdCAiSU9NTVUgZGVmYXVsdCBETUEgbW9kZSIKPj4+IMKgwqDCoMKgwqAgZGVwZW5kcyBv
biBJT01NVV9ETUEKPj4+ICvCoMKgwqAgZGVmYXVsdCBJT01NVV9ERUZBVUxUX0xBWlkgaWYgSU5U
RUxfSU9NTVUKPj4+IMKgwqDCoMKgwqAgZGVmYXVsdCBJT01NVV9ERUZBVUxUX1NUUklDVAo+Pgo+
PiBJZiB0d28gZGVmYXVsdCB2YWx1ZXMgYXJlIGRpZmZlcmVudC4gV2hpY2ggb25lIHdpbGwgYmUg
b3ZlcnJpZGRlbj8KPiAKPiBJZiBJIHVuZGVyc3RhbmQgeW91ciBxdWVzdGlvbiBjb3JyZWN0bHks
IEkgdGhpbmsgeW91IGFyZSBhc2tpbmcgaWYgYm90aCAKPiBhcmUgc2V0Ogo+IENPTkZJR19JT01N
VV9ERUZBVUxUX0xBWlk9eQo+IENPTkZJR19JT01NVV9ERUZBVUxUX1NUUklDVD15Cj4gCj4gSWYg
dGhpcyBoYXBwZW5zLCB0aGVuIG1ha2UgZGVmY29uZmlnIGNvbXBsYWlucyBhYm91dCBib3RoIGJl
aW5nIHNldCwgYW5kIAo+IHNlbGVjdHMgdGhlIDJuZCwgd2hhdGV2ZXIgdGhhdCBpcy4KCk9uIHg4
NiwgSW50ZWwgb3IgQU1ELCB0aGlzIHdpbGwgYmUKCglwcm9tcHQgIklPTU1VIGRlZmF1bHQgRE1B
IG1vZGUiCgkgIGRlcGVuZHMgb24gSU9NTVVfRE1BCgkgIGRlZmF1bHQgSU9NTVVfREVGQVVMVF9M
QVpZCgkgIGRlZmF1bHQgSU9NTVVfREVGQVVMVF9TVFJJQ1QKCndoaWNoIHdpbGwgYmUgZGVmYXVs
dCwgTEFaWSBvciBTVFJJQ1Q/IFdpbGwgaXQgY2F1c2UgY29tcGxhaW5zPwoKPiAKPiBJZiBuZWl0
aGVyIGFyZSBzZXQsIHRoZW4gSU9NTVVfREVGQVVMVF9MQVpZIGlzIHNldCBpZiBJTlRFTF9JT01N
VSBpcyAKPiBzZXQsIG90aGVyd2lzZSBJT01NVV9ERUZBVUxUX1NUUklDVC4KPiAKPiBUaGFua3Ms
Cj4gSm9obgoKQmVzdCByZWdhcmRzLApiYW9sdQpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgt
Zm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4v
bGlzdGluZm8vaW9tbXU=
