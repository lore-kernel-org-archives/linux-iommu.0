Return-Path: <SRS0=Veyj=Z6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F11CCC43603
	for <iommu@archiver.kernel.org>; Sun,  8 Dec 2019 06:04:56 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87471206D6
	for <iommu@archiver.kernel.org>; Sun,  8 Dec 2019 06:04:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87471206D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 413E486A70;
	Sun,  8 Dec 2019 06:04:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1CZZE5ug0R3B; Sun,  8 Dec 2019 06:04:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 3A01D86A4F;
	Sun,  8 Dec 2019 06:04:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1F499C1D7D;
	Sun,  8 Dec 2019 06:04:54 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 82AA1C077D
 for <iommu@lists.linux-foundation.org>; Sun,  8 Dec 2019 06:04:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 70C02861DE
 for <iommu@lists.linux-foundation.org>; Sun,  8 Dec 2019 06:04:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cOMSoLLOyjAV for <iommu@lists.linux-foundation.org>;
 Sun,  8 Dec 2019 06:04:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 4C9C5861D7
 for <iommu@lists.linux-foundation.org>; Sun,  8 Dec 2019 06:04:51 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 07 Dec 2019 22:04:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,290,1571727600"; d="scan'208";a="224451002"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136])
 ([10.239.159.136])
 by orsmga002.jf.intel.com with ESMTP; 07 Dec 2019 22:04:49 -0800
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
Message-ID: <31cd866f-00fa-7d23-4a8f-b1e471646eb6@linux.intel.com>
Date: Sun, 8 Dec 2019 14:04:08 +0800
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
dGNoLgoKSXQgc2VlbXMgdGhhdCBkZXZpY2UgMDEuMDAuMiBpcyBub3QgaW4gYmVsb3cgUk1SUgoK
CURNQVI6IFJNUlIgYmFzZTogMHgwMDAwMDBiZGY2ZjAwMCBlbmQ6IDB4MDAwMDAwYmRmN2VmZmYK
CmJ1dCBpdCBzdGlsbCB0cmllcyB0byBhY2Nlc3MgdGhlIG1lbW9yeSBhZGRyZXNzIHdpdGhpbiBp
dC4gSGVuY2UgSU9NTVUKZmF1bHRzIGdlbmVyYXRlZC4KCllvdSBjYW4gY2hlY2sgaXQgd2l0aCB0
aGUgQUNQSS9ETUFSIHRhYmxlLgoKQmVzdCByZWdhcmRzLApiYW9sdQpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVA
bGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24u
b3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
