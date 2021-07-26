Return-Path: <SRS0=C8jr=MS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FA6CC4338F
	for <iommu@archiver.kernel.org>; Mon, 26 Jul 2021 12:43:40 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4CC2604DB
	for <iommu@archiver.kernel.org>; Mon, 26 Jul 2021 12:43:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B4CC2604DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 79981837B6;
	Mon, 26 Jul 2021 12:43:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zx2ThHseGT-i; Mon, 26 Jul 2021 12:43:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 665B0837AD;
	Mon, 26 Jul 2021 12:43:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4044EC0010;
	Mon, 26 Jul 2021 12:43:33 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6AC15C000E
 for <iommu@lists.linux-foundation.org>; Mon, 26 Jul 2021 12:43:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4B1DD40363
 for <iommu@lists.linux-foundation.org>; Mon, 26 Jul 2021 12:43:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id l_b9gwjCkxKM for <iommu@lists.linux-foundation.org>;
 Mon, 26 Jul 2021 12:43:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp4.osuosl.org (Postfix) with ESMTP id 83BF540332
 for <iommu@lists.linux-foundation.org>; Mon, 26 Jul 2021 12:43:31 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 844AB31B;
 Mon, 26 Jul 2021 05:43:30 -0700 (PDT)
Received: from [10.57.36.146] (unknown [10.57.36.146])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 689D93F70D;
 Mon, 26 Jul 2021 05:43:29 -0700 (PDT)
Subject: Re: [PATCH 18/23] iommu: Express DMA strictness via the domain type
To: Lu Baolu <baolu.lu@linux.intel.com>, joro@8bytes.org, will@kernel.org
References: <cover.1626888444.git.robin.murphy@arm.com>
 <37708e21b55e17eb074ef145afc2157cd0192abe.1626888445.git.robin.murphy@arm.com>
 <f5e902ce-54a2-af7b-b42e-f61f7f96c68e@linux.intel.com>
 <77057c4b-479b-c5b8-4666-f16e294552d1@arm.com>
 <29443387-c088-480c-3d91-17b6d1cc8188@linux.intel.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <9b5abd19-8bfe-7215-8b13-108aea2aee5e@arm.com>
Date: Mon, 26 Jul 2021 13:43:24 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <29443387-c088-480c-3d91-17b6d1cc8188@linux.intel.com>
Content-Language: en-GB
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, dianders@chromium.org
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

T24gMjAyMS0wNy0yNiAxMzoyOSwgTHUgQmFvbHUgd3JvdGU6ClsuLi5dCj4+Pj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvaW9tbXUvZG1hLWlvbW11LmMgYi9kcml2ZXJzL2lvbW11L2RtYS1pb21tdS5j
Cj4+Pj4gaW5kZXggYjFhZjFmZjMyNGM1Li5hMTE0YTdhZDg4ZWMgMTAwNjQ0Cj4+Pj4gLS0tIGEv
ZHJpdmVycy9pb21tdS9kbWEtaW9tbXUuYwo+Pj4+ICsrKyBiL2RyaXZlcnMvaW9tbXUvZG1hLWlv
bW11LmMKPj4+PiBAQCAtMzYzLDEzICszNjMsMTUgQEAgc3RhdGljIGludCBpb21tdV9kbWFfaW5p
dF9kb21haW4oc3RydWN0IAo+Pj4+IGlvbW11X2RvbWFpbiAqZG9tYWluLCBkbWFfYWRkcl90IGJh
c2UsCj4+Pj4gwqDCoMKgwqDCoCBpbml0X2lvdmFfZG9tYWluKGlvdmFkLCAxVUwgPDwgb3JkZXIs
IGJhc2VfcGZuKTsKPj4+PiAtwqDCoMKgIGlmICghY29va2llLT5mcV9kb21haW4gJiYgIWRldl9p
c191bnRydXN0ZWQoZGV2KSAmJgo+Pj4+IC3CoMKgwqDCoMKgwqDCoCBkb21haW4tPm9wcy0+Zmx1
c2hfaW90bGJfYWxsICYmIAo+Pj4+ICFpb21tdV9nZXRfZG1hX3N0cmljdChkb21haW4pKSB7Cj4+
Pj4gK8KgwqDCoCBpZiAoZG9tYWluLT50eXBlID09IElPTU1VX0RPTUFJTl9ETUFfRlEgJiYgIWNv
b2tpZS0+ZnFfZG9tYWluICYmCj4+Pj4gK8KgwqDCoMKgwqDCoMKgIGRvbWFpbi0+b3BzLT5mbHVz
aF9pb3RsYl9hbGwpIHsKPiAKPiBQZXJoYXBzIHdlIGNhbiByZW1vdmUgdGhlIG9wcy0+Zmx1c2hf
aW90bGJfYWxsIGNoZWNrIHdpdGggdGhlCj4gYXNzdW1wdGlvbiB0aGF0IGFueSB2ZW5kb3IgaW9t
bXUgZHJpdmVyIHdpdGggRE1BX0ZRIGRvbWFpbiBzdXBwb3J0Cj4gc2hvdWxkIGFsd2F5cyBwcm92
aWRlcyB0aGlzIGNhbGxiYWNrPwoKT2ggeWVzLCBpbmRlZWQgaXQgd291bGRuJ3QgbWFrZSBzZW5z
ZSBmb3IgYSBkcml2ZXIgdG8gY2xhaW0gCklPTU1VX0RPTUFJTl9ETUFfRlEgc3VwcG9ydCBidXQg
bm90IGltcGxlbWVudCB0aGUgb25lIHRoaW5nIHRoYXQgdGhhdCAKbmVlZHMgdGhlIGRyaXZlciB0
byBwcm92aWRlLiBUaGF0J3MgeWV0IGFub3RoZXIgbmVhdCBsaXR0bGUgY2xlYW51cCwgdGhhbmtz
IQoKUm9iaW4uCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRw
czovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
