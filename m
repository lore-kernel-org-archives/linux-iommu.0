Return-Path: <SRS0=C8jr=MS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8C23C4338F
	for <iommu@archiver.kernel.org>; Mon, 26 Jul 2021 11:31:42 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FA3460F38
	for <iommu@archiver.kernel.org>; Mon, 26 Jul 2021 11:31:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4FA3460F38
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 156A3605E5;
	Mon, 26 Jul 2021 11:31:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5rVXotIMqxIz; Mon, 26 Jul 2021 11:31:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 07724605E0;
	Mon, 26 Jul 2021 11:31:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D0CE7C001A;
	Mon, 26 Jul 2021 11:31:40 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D8580C000E
 for <iommu@lists.linux-foundation.org>; Mon, 26 Jul 2021 11:31:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B9FD3605E5
 for <iommu@lists.linux-foundation.org>; Mon, 26 Jul 2021 11:31:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZKujQ2OhWlk8 for <iommu@lists.linux-foundation.org>;
 Mon, 26 Jul 2021 11:31:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8BADB605E0
 for <iommu@lists.linux-foundation.org>; Mon, 26 Jul 2021 11:31:38 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10056"; a="273300901"
X-IronPort-AV: E=Sophos;i="5.84,270,1620716400"; d="scan'208";a="273300901"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jul 2021 04:31:35 -0700
X-IronPort-AV: E=Sophos;i="5.84,270,1620716400"; d="scan'208";a="504862219"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.214.209])
 ([10.254.214.209])
 by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jul 2021 04:31:33 -0700
Subject: Re: [PATCH 18/23] iommu: Express DMA strictness via the domain type
To: Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org, will@kernel.org
References: <cover.1626888444.git.robin.murphy@arm.com>
 <37708e21b55e17eb074ef145afc2157cd0192abe.1626888445.git.robin.murphy@arm.com>
 <f5e902ce-54a2-af7b-b42e-f61f7f96c68e@linux.intel.com>
 <77057c4b-479b-c5b8-4666-f16e294552d1@arm.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <832b7db0-4eb2-9151-c2b3-db709aee3230@linux.intel.com>
Date: Mon, 26 Jul 2021 19:31:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <77057c4b-479b-c5b8-4666-f16e294552d1@arm.com>
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

T24gMjAyMS83LzI2IDE2OjI3LCBSb2JpbiBNdXJwaHkgd3JvdGU6Cj4gT24gMjAyMS0wNy0yNCAw
NjoyOSwgTHUgQmFvbHUgd3JvdGU6Cj4+IEhpIFJvYmluLAo+Pgo+PiBPbiAyMDIxLzcvMjIgMjoy
MCwgUm9iaW4gTXVycGh5IHdyb3RlOgo+Pj4gRWxpbWluYXRlIHRoZSBpb21tdV9nZXRfZG1hX3N0
cmljdCgpIGluZGlyZWN0aW9uIGFuZCBwaXBlIHRoZQo+Pj4gaW5mb3JtYXRpb24gdGhyb3VnaCB0
aGUgZG9tYWluIHR5cGUgZnJvbSB0aGUgYmVnaW5uaW5nLiBCZXNpZGVzCj4+PiB0aGUgZmxvdyBz
aW1wbGlmaWNhdGlvbiB0aGlzIGFsc28gaGFzIHNldmVyYWwgbmljZSBzaWRlLWVmZmVjdHM6Cj4+
Pgo+Pj4gwqAgLSBBdXRvbWF0aWNhbGx5IGltcGxpZXMgc3RyaWN0IG1vZGUgZm9yIHVudHJ1c3Rl
ZCBkZXZpY2VzIGJ5Cj4+PiDCoMKgwqAgdmlydHVlIG9mIHRoZWlyIElPTU1VX0RPTUFJTl9ETUEg
b3ZlcnJpZGUuCj4+PiDCoCAtIEVuc3VyZXMgdGhhdCB3ZSBvbmx5IGVuZHMgdXAgdXNpbmcgZmx1
c2ggcXVldWVzIGZvciBkcml2ZXJzCj4+PiDCoMKgwqAgd2hpY2ggYXJlIGF3YXJlIG9mIHRoZW0g
YW5kIGNhbiBhY3R1YWxseSBiZW5lZml0Lgo+Pgo+PiBJcyB0aGlzIGV4cHJlc3NlZCBieSB2ZW5k
b3IgaW9tbXUgZHJpdmVyIGhhcyBvcHMtPmZsdXNoX2lvdGxiX2FsbD8KPiAKPiBObywgaXQncyBs
aXRlcmFsbHkgd2hldGhlciAtPmRvbWFpbl9hbGxvYyBhY2NlcHRzIHRoZSBETUFfRE9NQUlOX0ZR
IHR5cGUgCj4gb3Igbm90LgoKR2V0IGl0LiBUaGFuayB5b3UhCgpCZXN0IHJlZ2FyZHMsCmJhb2x1
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1h
aWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3Rz
LmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
