Return-Path: <SRS0=PSAu=2C=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE2AFC43603
	for <iommu@archiver.kernel.org>; Thu, 12 Dec 2019 02:13:45 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64438208C3
	for <iommu@archiver.kernel.org>; Thu, 12 Dec 2019 02:13:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64438208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 1596188021;
	Thu, 12 Dec 2019 02:13:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iUy208NqiX0l; Thu, 12 Dec 2019 02:13:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 3D86787FF2;
	Thu, 12 Dec 2019 02:13:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 30A7DC18DC;
	Thu, 12 Dec 2019 02:13:44 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 336B7C0881
 for <iommu@lists.linux-foundation.org>; Thu, 12 Dec 2019 02:13:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 28C1886EAC
 for <iommu@lists.linux-foundation.org>; Thu, 12 Dec 2019 02:13:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id elAc88e_SQbC for <iommu@lists.linux-foundation.org>;
 Thu, 12 Dec 2019 02:13:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id BCBAD86EA2
 for <iommu@lists.linux-foundation.org>; Thu, 12 Dec 2019 02:13:41 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 11 Dec 2019 18:13:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,303,1571727600"; d="scan'208";a="225748499"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136])
 ([10.239.159.136])
 by orsmga002.jf.intel.com with ESMTP; 11 Dec 2019 18:13:38 -0800
Subject: Re: [PATCH 1/1] iommu/vt-d: Fix dmar pte read access not set error
To: Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>,
 ashok.raj@intel.com, jacob.jun.pan@intel.com, kevin.tian@intel.com,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20191211014015.7898-1-baolu.lu@linux.intel.com>
 <20191212014952.vlrmxrk2cebwxjnp@cantor>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <6f3bcad9-b9b3-b349-fdad-ce53a79a665b@linux.intel.com>
Date: Thu, 12 Dec 2019 10:12:53 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191212014952.vlrmxrk2cebwxjnp@cantor>
Content-Language: en-US
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

SGksCgpPbiAxMi8xMi8xOSA5OjQ5IEFNLCBKZXJyeSBTbml0c2VsYWFyIHdyb3RlOgo+IE9uIFdl
ZCBEZWMgMTEgMTksIEx1IEJhb2x1IHdyb3RlOgo+PiBJZiB0aGUgZGVmYXVsdCBETUEgZG9tYWlu
IG9mIGEgZ3JvdXAgZG9lc24ndCBmaXQgYSBkZXZpY2UsIGl0Cj4+IHdpbGwgc3RpbGwgc2l0IGlu
IHRoZSBncm91cCBidXQgdXNlIGEgcHJpdmF0ZSBpZGVudGl0eSBkb21haW4uCj4+IFdoZW4gbWFw
L3VubWFwL2lvdmFfdG9fcGh5cyBjb21lIHRocm91Z2ggaW9tbXUgQVBJLCB0aGUgZHJpdmVyCj4+
IHNob3VsZCBzdGlsbCBzZXJ2ZSB0aGVtLCBvdGhlcndpc2UsIG90aGVyIGRldmljZXMgaW4gdGhl
IHNhbWUKPj4gZ3JvdXAgd2lsbCBiZSBpbXBhY3RlZC4gU2luY2UgaWRlbnRpdHkgZG9tYWluIGhh
cyBiZWVuIG1hcHBlZAo+PiB3aXRoIHRoZSB3aG9sZSBhdmFpbGFibGUgbWVtb3J5IHNwYWNlIGFu
ZCBSTVJScywgd2UgZG9uJ3QgbmVlZAo+PiB0byB3b3JyeSBhYm91dCB0aGUgaW1wYWN0IG9uIGl0
Lgo+Pgo+PiBMaW5rOiBodHRwczovL3d3dy5zcGluaWNzLm5ldC9saXN0cy9pb21tdS9tc2c0MDQx
Ni5odG1sCj4+IENjOiBKZXJyeSBTbml0c2VsYWFyIDxqc25pdHNlbEByZWRoYXQuY29tPgo+PiBS
ZXBvcnRlZC1ieTogSmVycnkgU25pdHNlbGFhciA8anNuaXRzZWxAcmVkaGF0LmNvbT4KPj4gRml4
ZXM6IDk0MjA2N2YxYjZiOTcgKCJpb21tdS92dC1kOiBJZGVudGlmeSBkZWZhdWx0IGRvbWFpbnMg
cmVwbGFjZWQgCj4+IHdpdGggcHJpdmF0ZSIpCj4+IENjOiBzdGFibGVAdmdlci5rZXJuZWwub3Jn
ICMgdjUuMysKPj4gU2lnbmVkLW9mZi1ieTogTHUgQmFvbHUgPGJhb2x1Lmx1QGxpbnV4LmludGVs
LmNvbT4KPiAKPiBSZXZpZXdlZC1ieTogSmVycnkgU25pdHNlbGFhciA8anNuaXRzZWxAcmVkaGF0
LmNvbT4KCkNhbiB5b3UgcGxlYXNlIHRyeSB0aGlzIGZpeCBhbmQgY2hlY2sgd2hldGhlciBpdCBj
YW4gZml4IHlvdXIgcHJvYmxlbT8KSWYgaXQgaGVscHMsIGRvIHlvdSBtaW5kIGFkZGluZyBhIFRl
c3RlZC1ieT8KCkJlc3QgcmVnYXJkcywKYmFvbHUKCj4gCj4+IC0tLQo+PiBkcml2ZXJzL2lvbW11
L2ludGVsLWlvbW11LmMgfCA4IC0tLS0tLS0tCj4+IDEgZmlsZSBjaGFuZ2VkLCA4IGRlbGV0aW9u
cygtKQo+Pgo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pb21tdS9pbnRlbC1pb21tdS5jIGIvZHJp
dmVycy9pb21tdS9pbnRlbC1pb21tdS5jCj4+IGluZGV4IDBjOGQ4MWY1NmEzMC4uYjczYmViZWE5
MTQ4IDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJzL2lvbW11L2ludGVsLWlvbW11LmMKPj4gKysrIGIv
ZHJpdmVycy9pb21tdS9pbnRlbC1pb21tdS5jCj4+IEBAIC01NDc4LDkgKzU0NzgsNiBAQCBzdGF0
aWMgaW50IGludGVsX2lvbW11X21hcChzdHJ1Y3QgaW9tbXVfZG9tYWluIAo+PiAqZG9tYWluLAo+
PiDCoMKgwqDCoGludCBwcm90ID0gMDsKPj4gwqDCoMKgwqBpbnQgcmV0Owo+Pgo+PiAtwqDCoMKg
IGlmIChkbWFyX2RvbWFpbi0+ZmxhZ3MgJiBET01BSU5fRkxBR19MT1NFX0NISUxEUkVOKQo+PiAt
wqDCoMKgwqDCoMKgwqAgcmV0dXJuIC1FSU5WQUw7Cj4+IC0KPj4gwqDCoMKgwqBpZiAoaW9tbXVf
cHJvdCAmIElPTU1VX1JFQUQpCj4+IMKgwqDCoMKgwqDCoMKgIHByb3QgfD0gRE1BX1BURV9SRUFE
Owo+PiDCoMKgwqDCoGlmIChpb21tdV9wcm90ICYgSU9NTVVfV1JJVEUpCj4+IEBAIC01NTIzLDgg
KzU1MjAsNiBAQCBzdGF0aWMgc2l6ZV90IGludGVsX2lvbW11X3VubWFwKHN0cnVjdCAKPj4gaW9t
bXVfZG9tYWluICpkb21haW4sCj4+IMKgwqDCoMKgLyogQ29wZSB3aXRoIGhvcnJpZCBBUEkgd2hp
Y2ggcmVxdWlyZXMgdXMgdG8gdW5tYXAgbW9yZSB0aGFuIHRoZQo+PiDCoMKgwqDCoMKgwqAgc2l6
ZSBhcmd1bWVudCBpZiBpdCBoYXBwZW5zIHRvIGJlIGEgbGFyZ2UtcGFnZSBtYXBwaW5nLiAqLwo+
PiDCoMKgwqDCoEJVR19PTighcGZuX3RvX2RtYV9wdGUoZG1hcl9kb21haW4sIGlvdmEgPj4gVlRE
X1BBR0VfU0hJRlQsICZsZXZlbCkpOwo+PiAtwqDCoMKgIGlmIChkbWFyX2RvbWFpbi0+ZmxhZ3Mg
JiBET01BSU5fRkxBR19MT1NFX0NISUxEUkVOKQo+PiAtwqDCoMKgwqDCoMKgwqAgcmV0dXJuIDA7
Cj4+Cj4+IMKgwqDCoMKgaWYgKHNpemUgPCBWVERfUEFHRV9TSVpFIDw8IGxldmVsX3RvX29mZnNl
dF9iaXRzKGxldmVsKSkKPj4gwqDCoMKgwqDCoMKgwqAgc2l6ZSA9IFZURF9QQUdFX1NJWkUgPDwg
bGV2ZWxfdG9fb2Zmc2V0X2JpdHMobGV2ZWwpOwo+PiBAQCAtNTU1Niw5ICs1NTUxLDYgQEAgc3Rh
dGljIHBoeXNfYWRkcl90IAo+PiBpbnRlbF9pb21tdV9pb3ZhX3RvX3BoeXMoc3RydWN0IGlvbW11
X2RvbWFpbiAqZG9tYWluLAo+PiDCoMKgwqDCoGludCBsZXZlbCA9IDA7Cj4+IMKgwqDCoMKgdTY0
IHBoeXMgPSAwOwo+Pgo+PiAtwqDCoMKgIGlmIChkbWFyX2RvbWFpbi0+ZmxhZ3MgJiBET01BSU5f
RkxBR19MT1NFX0NISUxEUkVOKQo+PiAtwqDCoMKgwqDCoMKgwqAgcmV0dXJuIDA7Cj4+IC0KPj4g
wqDCoMKgwqBwdGUgPSBwZm5fdG9fZG1hX3B0ZShkbWFyX2RvbWFpbiwgaW92YSA+PiBWVERfUEFH
RV9TSElGVCwgJmxldmVsKTsKPj4gwqDCoMKgwqBpZiAocHRlKQo+PiDCoMKgwqDCoMKgwqDCoCBw
aHlzID0gZG1hX3B0ZV9hZGRyKHB0ZSk7Cj4+IC0tIAo+PiAyLjE3LjEKPj4KPiAKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0
CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3Vu
ZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
