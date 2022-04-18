Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12825C433EF
	for <iommu@archiver.kernel.org>; Mon, 18 Apr 2022 23:38:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 987E660AF2;
	Mon, 18 Apr 2022 23:38:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1XHIMbmPr5nO; Mon, 18 Apr 2022 23:38:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 884B76110F;
	Mon, 18 Apr 2022 23:38:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 49D1FC002F;
	Mon, 18 Apr 2022 23:38:08 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 33414C002C
 for <iommu@lists.linux-foundation.org>; Mon, 18 Apr 2022 23:38:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1616E83E87
 for <iommu@lists.linux-foundation.org>; Mon, 18 Apr 2022 23:38:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ejexxXSKS8E1 for <iommu@lists.linux-foundation.org>;
 Mon, 18 Apr 2022 23:38:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4EC0083E12
 for <iommu@lists.linux-foundation.org>; Mon, 18 Apr 2022 23:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1650325085; x=1681861085;
 h=message-id:date:mime-version:cc:to:references:from:
 subject:in-reply-to:content-transfer-encoding;
 bh=460hG8CIIcm3gtmEox+OkQvY/ODX0b4z0I02OexvBno=;
 b=KYEfJhc0Rs5ZkE7ubb2Gz1Cw3zGSMQp1ezHiNqAMmE29R3UoqPFc/HfV
 W/gak8I5K/gK0rJfmemIV2EyoLwfLByoNfEDoyaRd47FnL2Xq9mxAHG2O
 0kg0Be1aBg+J1ECM9z2PFHOeZWC28UmWaJNnGDC4gP2K/TCDXoIkcUd/u
 v+7DCyrEnIr6aEi+U/8p/i/v5smtyzm4mWB7LZ+df7bKS4Ox44zcVDdfG
 3vHyUaXhQoJdsTgzMcX2Fou1kH47+Y9em6DpmKK4Dwi6sn/NtOwA29szb
 BeeDqmbJhWakhX56aKDCVmhhbHXuMYwFmGtiVZ+3oVbKXh4cA2uHJszEm Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10321"; a="326533964"
X-IronPort-AV: E=Sophos;i="5.90,271,1643702400"; d="scan'208";a="326533964"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Apr 2022 16:38:04 -0700
X-IronPort-AV: E=Sophos;i="5.90,271,1643702400"; d="scan'208";a="575804958"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.214.32])
 ([10.254.214.32])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Apr 2022 16:38:00 -0700
Message-ID: <d928d256-b1bc-2d45-a9c3-382edfe67b80@linux.intel.com>
Date: Tue, 19 Apr 2022 07:37:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Content-Language: en-US
To: Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org, will@kernel.org
References: <cover.1649935679.git.robin.murphy@arm.com>
 <e607a32be8e84c56d65160902f4bd3fb434ee9d3.1649935679.git.robin.murphy@arm.com>
 <d838c7f8-2d31-2327-9b4d-c05b06a516bb@linux.intel.com>
 <1d9a2146-9e48-ba97-d049-5d2332ebbd3a@arm.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH 02/13] iommu: Move bus setup to IOMMU device registration
In-Reply-To: <1d9a2146-9e48-ba97-d049-5d2332ebbd3a@arm.com>
Cc: jean-philippe@linaro.org, zhang.lyra@gmail.com,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 thierry.reding@gmail.com, linux-arm-kernel@lists.infradead.org,
 gerald.schaefer@linux.ibm.com
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

T24gMjAyMi80LzE5IDY6MDksIFJvYmluIE11cnBoeSB3cm90ZToKPiBPbiAyMDIyLTA0LTE2IDAx
OjA0LCBMdSBCYW9sdSB3cm90ZToKPj4gT24gMjAyMi80LzE0IDIwOjQyLCBSb2JpbiBNdXJwaHkg
d3JvdGU6Cj4+PiBAQCAtMTg4MywyNyArMTkwMCwxMiBAQCBzdGF0aWMgaW50IGlvbW11X2J1c19p
bml0KHN0cnVjdCBidXNfdHlwZSAqYnVzKQo+Pj4gwqDCoCAqLwo+Pj4gwqAgaW50IGJ1c19zZXRf
aW9tbXUoc3RydWN0IGJ1c190eXBlICpidXMsIGNvbnN0IHN0cnVjdCBpb21tdV9vcHMgKm9wcykK
Pj4+IMKgIHsKPj4+IC3CoMKgwqAgaW50IGVycjsKPj4+IC0KPj4+IC3CoMKgwqAgaWYgKG9wcyA9
PSBOVUxMKSB7Cj4+PiAtwqDCoMKgwqDCoMKgwqAgYnVzLT5pb21tdV9vcHMgPSBOVUxMOwo+Pj4g
LcKgwqDCoMKgwqDCoMKgIHJldHVybiAwOwo+Pj4gLcKgwqDCoCB9Cj4+PiAtCj4+PiAtwqDCoMKg
IGlmIChidXMtPmlvbW11X29wcyAhPSBOVUxMKQo+Pj4gK8KgwqDCoCBpZiAoYnVzLT5pb21tdV9v
cHMgJiYgb3BzICYmIGJ1cy0+aW9tbXVfb3BzICE9IG9wcykKPj4+IMKgwqDCoMKgwqDCoMKgwqDC
oCByZXR1cm4gLUVCVVNZOwo+Pj4gwqDCoMKgwqDCoCBidXMtPmlvbW11X29wcyA9IG9wczsKPj4K
Pj4gRG8gd2Ugc3RpbGwgbmVlZCB0byBrZWVwIGFib3ZlIGxpbmVzIGluIGJ1c19zZXRfaW9tbXUo
KT8KPiAKPiBJdCBwcmVzZXJ2ZXMgdGhlIGV4aXN0aW5nIGJlaGF2aW91ciB1bnRpbCBlYWNoIGNh
bGxzaXRlIGFuZCBpdHMgCj4gYXNzb2NpYXRlZCBlcnJvciBoYW5kbGluZyBhcmUgcmVtb3ZlZCBs
YXRlciBvbiwgd2hpY2ggc2VlbXMgbGlrZSBhcyBnb29kIAo+IGEgdGhpbmcgdG8gZG8gYXMgYW55
LiBTaW5jZSBJJ20gYWxyZWFkeSByZWxheGluZyBpb21tdV9kZXZpY2VfcmVnaXN0ZXIoKSAKPiB0
byBhIHdhcm4tYnV0LWNvbnRpbnVlIGJlaGF2aW91ciB3aGlsZSBpdCBrZWVwcyB0aGUgYnVzIG9w
cyBvbiAKPiBsaWZlLXN1cHBvcnQgaW50ZXJuYWxseSwgSSBmaWd1cmVkIG5vdCBjaGFuZ2luZyB0
b28gbXVjaCBhdCBvbmNlIHdvdWxkIAo+IG1ha2UgaXQgZWFzaWVyIHRvIGJpc2VjdCBhbnkgcG90
ZW50aWFsIGlzc3VlcyBhcmlzaW5nIGZyb20gdGhpcyBmaXJzdCBzdGVwLgoKRmFpciBlbm91Z2gu
IFRoYW5rIHlvdSBmb3IgdGhlIGV4cGxhbmF0aW9uLgoKRG8geW91IGhhdmUgYSBwdWJsaWMgdHJl
ZSB0aGF0IEkgY291bGQgcHVsbCB0aGVzZSBwYXRjaGVzIGFuZCB0cnkgdGhlbQpvbiBhbiBJbnRl
bCBoYXJkd2FyZT8gT3IgcGVyaGFwcyB5b3UgaGF2ZSBkb25lIHRoaXM/IEkgbGlrZSB0aGUgd2hv
bGUKaWRlYSBvZiB0aGlzIHNlcmllcywgYnV0IGl0J3MgYmV0dGVyIHRvIHRyeSBpdCB3aXRoIGEg
cmVhbCBoYXJkd2FyZS4KCkJlc3QgcmVnYXJkcywKYmFvbHUKCgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlz
dHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3Jn
L21haWxtYW4vbGlzdGluZm8vaW9tbXU=
