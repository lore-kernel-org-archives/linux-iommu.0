Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73E39C43334
	for <iommu@archiver.kernel.org>; Wed, 22 Jun 2022 03:22:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0902661182;
	Wed, 22 Jun 2022 03:22:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0902661182
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=aPWQDnx3
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fnVfl7Usyz1y; Wed, 22 Jun 2022 03:22:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 33C2560DFF;
	Wed, 22 Jun 2022 03:22:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 33C2560DFF
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E826DC0039;
	Wed, 22 Jun 2022 03:22:38 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 286FDC002D
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jun 2022 03:22:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E862260E19
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jun 2022 03:22:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E862260E19
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gjD9pgWVcFQu for <iommu@lists.linux-foundation.org>;
 Wed, 22 Jun 2022 03:22:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 30E2D60DFF
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 30E2D60DFF
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jun 2022 03:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1655868156; x=1687404156;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=Wvz1BbOPL5rCLg5gmfrFRw44k7kfAr8LSKwM5LsaZGE=;
 b=aPWQDnx3IgEQaUVj6hk7MOfGD2c/+X6gFalHjXLlJLZ8CbI0fFgrBPX5
 PxB+wo2LKAUrJlC/CUupo6A5uFAH4KZh5BpDTcCQalKZX/A2pp9+rGNu5
 9Zq+vr2lOvNc+jU8L6mrUDzwaw35Vzow58maq5ppomEti49aLowkgyRtl
 S0I3XCsiDBzzczM6xLsibZ1hg1xAxlmvSwRxextz71q2oFVCOeNmN0G54
 Wjdd71yKdrkt2ybuo+n0J0fDo0qz2UArPqk4a7n+7kGuTMF/s4PwZ5n18
 pPqhLf/QvcatkRutIK2NxoT+eveYnBuK/SiLGiftfJ/CDNc3+KggY58HV Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10385"; a="344291815"
X-IronPort-AV: E=Sophos;i="5.92,211,1650956400"; d="scan'208";a="344291815"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jun 2022 20:22:35 -0700
X-IronPort-AV: E=Sophos;i="5.92,211,1650956400"; d="scan'208";a="833881083"
Received: from xzhan99-mobl1.ccr.corp.intel.com (HELO [10.249.172.26])
 ([10.249.172.26])
 by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jun 2022 20:22:33 -0700
Message-ID: <809824df-bb33-a878-0652-02f7eb135fa4@linux.intel.com>
Date: Wed, 22 Jun 2022 11:22:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 1/1] iommu/vt-d: Fix RID2PASID setup failure
Content-Language: en-US
To: Ethan Zhao <haifeng.zhao@linux.intel.com>, Joerg Roedel
 <joro@8bytes.org>, Kevin Tian <kevin.tian@intel.com>,
 Ashok Raj <ashok.raj@intel.com>
References: <20220620081729.4610-1-baolu.lu@linux.intel.com>
 <30d27b02-0fec-d595-75a0-155eee1c84d6@linux.intel.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <30d27b02-0fec-d595-75a0-155eee1c84d6@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Chenyi Qiang <chenyi.qiang@intel.com>, iommu@lists.linux-foundation.org,
 Jacob jun Pan <jacob.jun.pan@intel.com>
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

T24gMjAyMi82LzIyIDEwOjU2LCBFdGhhbiBaaGFvIHdyb3RlOgo+IOWcqCAyMDIyLzYvMjAgMTY6
MTcsIEx1IEJhb2x1IOWGmemBkzoKPj4gVGhlIElPTU1VIGRyaXZlciBzaGFyZXMgdGhlIHBhc2lk
IHRhYmxlIGZvciBQQ0kgYWxpYXMgZGV2aWNlcy4gV2hlbiB0aGUKPj4gUklEMlBBU0lEIGVudHJ5
IG9mIHRoZSBzaGFyZWQgcGFzaWQgdGFibGUgaGFzIGJlZW4gZmlsbGVkIGJ5IHRoZSBmaXJzdAo+
PiBkZXZpY2UsIHRoZSBzdWJzZXF1ZW50IGRldmljZXMgd2lsbCBlbmNvdW50ZXIgdGhlICJETUFS
OiBTZXR1cCBSSUQyUEFTSUQKPj4gZmFpbGVkIiBmYWlsdXJlIGFzIHRoZSBwYXNpZCBlbnRyeSBo
YXMgYWxyZWFkeSBiZWVuIG1hcmtlIGFzIHByZXNlbnQuIEFzCj4+IHRoZSByZXN1bHQsIHRoZSBJ
T01NVSBwcm9iaW5nIHByb2Nlc3Mgd2lsbCBiZSBhYm9ydGVkLgo+Pgo+PiBUaGlzIGZpeGVzIGl0
IGJ5IHNraXBwaW5nIFJJRDJQQVNJRCBzZXR0aW5nIGlmIHRoZSBwYXNpZCBlbnRyeSBoYXMgYmVl
bgo+PiBwb3B1bGF0ZWQuIFRoaXMgd29ya3MgYmVjYXVzZSB0aGUgSU9NTVUgY29yZSBlbnN1cmVz
IHRoYXQgb25seSB0aGUgc2FtZQo+PiBJT01NVSBkb21haW4gY2FuIGJlIGF0dGFjaGVkIHRvIGFs
bCBQQ0kgYWxpYXMgZGV2aWNlcyBhdCB0aGUgc2FtZSB0aW1lLgo+PiBUaGVyZWZvcmUgdGhlIHN1
YnNlcXVlbnQgZGV2aWNlcyBqdXN0IHRyeSB0byBzZXR1cCB0aGUgUklEMlBBU0lEIGVudHJ5Cj4+
IHdpdGggdGhlIHNhbWUgZG9tYWluLCB3aGljaCBpcyBuZWdsaWdpYmxlLgo+ICDCoMKgwqAgV2Ug
aGF2ZSB0d28gY3VzdG9tZXJzIHJlcG9ydGVkIHRoZSBpc3N1ZSAiRE1BUjogU2V0dXAgUklEMlBB
U0lEIAo+IGZhaWxlZCIsCj4gCj4gVHdvIEFTUEVFRCBkZXZpY2VzIGxvY2F0ZSBiZWhpbmQgb25l
IFBDSWUtUENJIGJyaWRnZSBhbmQgaW9tbXUgU00sIFBUIAo+IG1vZGUgaXMgZW5hYmxlZC7CoCBN
b3N0Cj4gCj4gSW50ZXJlc3RpbmcgdGhpbmcgaXMgdGhlIHNlY29uZCBkZXZpY2UgaXMgb25seSB1
c2VkIGJ5IEJJT1MsIGFuZCBCSU9TIAo+IGxlZnQgaXQgdG8gT1Mgd2l0aG91dCBzaHV0dGluZyBk
b3duLAo+IAo+IGFuZCBpdCBpcyB1c2VsZXNzIGZvciBPUy4KClRoaXMgc291bmRzIG9kZC4gSXNu
J3QgdGhpcyBhIGJ1Zz8KCgo+IElzIHRoZXJlIHByYWN0aWNhbCBjYXNlIG11bHRpIGRldmljZXMg
YmVoaW5kIAo+IFBDSWUtUENJIGJyaWRnZSBzaGFyZSB0aGUgc2FtZQo+IAo+IFBBU0lEIGVudHJ5
IHdpdGhvdXQgYW55IHNlY3VyaXR5IGNvbmNlcm4gPyB0aGVzZSB0d28gY3VzdG9tZXIncyBjYXNl
IGlzIAo+IG5vdC4KClRoZSBkZXZpY2VzIHVuZGVybmVhdGggdGhlIFBDSWUtUENJIGJyaWRnZSBh
cmUgYWxpYXMgZGV2aWNlcyBvZiB0aGUKYnJpZGdlLiBQQ0kgYWxpYXMgZGV2aWNlcyBhbHdheXMg
c2l0IGluIHRoZSBzYW1lIGdyb3VwICh0aGUgbWluaW1hbCB1bml0CnRoYXQgSU9NTVUgZ3VhcmFu
dGVlcyBpc29sYXRpb24pIGFuZCBjYW4gb25seSBiZSBhdHRhY2hlZCB3aXRoIGEgc2FtZQpkb21h
aW4gKG1hbmFnZWQgSS9PIGFkZHJlc3Mgc3BhY2UpLiBIZW5jZSwgdGhlcmUncyBubyBzZWN1cml0
eSBjb25jZXJuCmlmIHRoZXkgZnVydGhlciBzaGFyZSB0aGUgcGFzaWQgdGFibGUuCgpCZXN0IHJl
Z2FyZHMsCmJhb2x1Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpo
dHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
