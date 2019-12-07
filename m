Return-Path: <SRS0=31RM=Z5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EFA1C43603
	for <iommu@archiver.kernel.org>; Sat,  7 Dec 2019 01:54:28 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 352A52245C
	for <iommu@archiver.kernel.org>; Sat,  7 Dec 2019 01:54:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 352A52245C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id F033725B0B;
	Sat,  7 Dec 2019 01:54:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id t57yKc4CQ7Gv; Sat,  7 Dec 2019 01:54:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id E4921204E7;
	Sat,  7 Dec 2019 01:54:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D18CCC18DD;
	Sat,  7 Dec 2019 01:54:26 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C67C0C077D
 for <iommu@lists.linux-foundation.org>; Sat,  7 Dec 2019 01:54:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id B51878776D
 for <iommu@lists.linux-foundation.org>; Sat,  7 Dec 2019 01:54:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gjpcRAFYpwuj for <iommu@lists.linux-foundation.org>;
 Sat,  7 Dec 2019 01:54:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 2BFF687683
 for <iommu@lists.linux-foundation.org>; Sat,  7 Dec 2019 01:54:24 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 06 Dec 2019 17:54:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,286,1571727600"; d="scan'208";a="386676867"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136])
 ([10.239.159.136])
 by orsmga005.jf.intel.com with ESMTP; 06 Dec 2019 17:54:22 -0800
Subject: Re: dmar pte read access not set error messages on hp dl388 gen8
 systems
To: Jerry Snitselaar <jsnitsel@redhat.com>
References: <20191202161332.ctc3y5cvdgqwnz7l@cantor>
 <14bbe41c-61e9-d2b6-31cb-67c0b1ad11da@linux.intel.com>
 <20191203095636.epmuinnrpykecfda@cantor>
 <5ce8d57e-25f0-5d28-7408-92c650ba54aa@linux.intel.com>
 <20191204205300.4jiexjqfpnqlcagu@cantor>
 <2d4e0c05-f0ee-d4b1-d2ed-24197811b097@linux.intel.com>
 <20191205022551.janpwjvr4kei5r7c@cantor>
 <d5981dee-d37b-a725-ed94-8864f3dd7602@linux.intel.com>
 <20191205025320.oiulo3msfcggdlv5@cantor>
 <d5fbedce-7a06-79b4-75fa-0aa3cc3ef73b@linux.intel.com>
 <20191206072453.5jjwrjedqbjimx45@cantor>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <0f82007e-9887-d6b2-08e5-9c430c920b36@linux.intel.com>
Date: Sat, 7 Dec 2019 09:53:42 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191206072453.5jjwrjedqbjimx45@cantor>
Content-Language: en-US
Cc: iommu@lists.linux-foundation.org
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

SGkgSmVycnksCgpPbiAxMi82LzE5IDM6MjQgUE0sIEplcnJ5IFNuaXRzZWxhYXIgd3JvdGU6Cj4g
T24gRnJpIERlYyAwNiAxOSwgTHUgQmFvbHUgd3JvdGU6Cj4gW3NuaXBdCj4+Cj4+IENhbiB5b3Ug
cGxlYXNlIHRyeSBiZWxvdyBjaGFuZ2U/IExldCdzIGNoZWNrIHdoZXRoZXIgdGhlIGFmZW5kaW5n
Cj4+IGFkZHJlc3MgaGFzIGJlZW4gbWFwcGVkIGZvciBkZXZpY2UgMDEuMDAuMi4KPj4KPj4gJCBn
aXQgZGlmZgo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pb21tdS9pb21tdS5jIGIvZHJpdmVycy9p
b21tdS9pb21tdS5jCj4+IGluZGV4IGRiN2JmZDRmMmQyMC4uZDlkYWY2NmJlODQ5IDEwMDY0NAo+
PiAtLS0gYS9kcml2ZXJzL2lvbW11L2lvbW11LmMKPj4gKysrIGIvZHJpdmVycy9pb21tdS9pb21t
dS5jCj4+IEBAIC02NjMsNiArNjYzLDggQEAgc3RhdGljIGludCAKPj4gaW9tbXVfZ3JvdXBfY3Jl
YXRlX2RpcmVjdF9tYXBwaW5ncyhzdHJ1Y3QgaW9tbXVfZ3JvdXAgKmdyb3VwLAo+PiDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXQgPSBpb21tdV9tYXAoZG9t
YWluLCBhZGRyLCBhZGRyLCBwZ19zaXplLCAKPj4gZW50cnktPnByb3QpOwo+PiDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAocmV0KQo+PiDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZ290byBv
dXQ7Cj4+ICsKPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IGRldl9pbmZvKGRldiwgIlNldHRpbmcgaWRlbnRpdHkgbWFwIFsweCVMeCAtIAo+PiAweCVMeF0g
Zm9yIGdyb3VwICVkXG4iLCBhZGRyLCBhZGRyICsgcGdfc2l6ZSwgZ3JvdXAtPmlkKTsKPj4gwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB9Cj4+Cj4+IMKgwqDCoMKgwqDCoCB9Cj4+Cj4+IEkg
YW0gZG91YnRpbmcgdGhhdCBkZXZpY2UgMDEuMDAuMiBpcyBub3QgaW4gdGhlIGRldmljZSBzY29w
ZSBvZgo+Pgo+PiBbwqDCoMKgIDQuNDg1MTA4XSBETUFSOiBSTVJSIGJhc2U6IDB4MDAwMDAwYmRm
NmYwMDAgZW5kOiAweDAwMDAwMGJkZjdlZmZmCj4+Cj4+IEJ5IHRoZSB3YXksIGRvZXMgZGV2aWNl
IDAxLjAwLjIgd29ya3Mgd2VsbCBhZnRlciBiaW5kaW5nIHRoZSBkcml2ZXI/Cj4+Cj4gCj4gV2hl
biBJIGJvb3QgaXQgd2l0aCBwYXNzdGhyb3VnaCBpdCBkb2Vzbid0IGdldCB0byBhIHBvaW50IHdo
ZXJlIEkgY2FuCj4gbG9naW4uIEkgdGhpbmsgdGhlIHNlcmlhbCBjb25zb2xlIG9uIHRoZXNlIHN5
c3RlbXMgaXMgdGllZCB0byB0aGUgaWxvLAo+IHNvIHRoZSBjb25zZXJ2ZXIgY29ubmVjdGlvbiBj
b3VsZCBiZSBtYWtpbmcgdGhpbmdzCj4gd29yc2UuIFVuZm9ydHVuYXRlbHkgdGhlIHN5c3RlbSBp
cyByZW1vdGUuIEkgc2hvdWxkIGhhdmUgbW9yZSB0aW1lIG5vdwo+IHRvIGZvY3VzIG9uIGRlYnVn
Z2luZyB0aGlzLgo+IAo+IEF0dGFjaGluZyBjb25zb2xlIG91dHB1dCBmb3IgdGhlIGFib3ZlIHBh
dGNoLgoKSXQgc2VlbXMgdGhhdCBkZXZpY2UgMDEuMDAuMiBpc24ndCBpbiB0aGUgc2NvcGUgb2Yg
Uk1SUiBbYmFzZToKMHgwMDAwMDBiZGY2ZjAwMCBlbmQ6IDB4MDAwMDAwYmRmN2VmZmZdLiBCdXQg
aXQgc3RpbGwgdHJpZXMgdG8gYWNjZXNzCnRoZSBhZGRyZXNzIHdpdGhpbiBpdCwgaGVuY2UgZmF1
bHRzIGdlbmVyYXRlZC4KCllvdSBjYW4gY2hlY2sgaXQgd2l0aCBBQ1BJL0RNQVIgdGFibGUuCgpC
ZXN0IHJlZ2FyZHMsCmJhb2x1Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9u
Lm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9p
b21tdQ==
