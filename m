Return-Path: <SRS0=PSAu=2C=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 673A4C43603
	for <iommu@archiver.kernel.org>; Thu, 12 Dec 2019 01:01:13 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38AFD2173E
	for <iommu@archiver.kernel.org>; Thu, 12 Dec 2019 01:01:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38AFD2173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 2DCC288719;
	Thu, 12 Dec 2019 01:01:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id k-oBxPwCJyj8; Thu, 12 Dec 2019 01:01:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 7B524886D0;
	Thu, 12 Dec 2019 01:01:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6F1ABC18DC;
	Thu, 12 Dec 2019 01:01:11 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 16E81C0881
 for <iommu@lists.linux-foundation.org>; Thu, 12 Dec 2019 01:01:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 054CC88718
 for <iommu@lists.linux-foundation.org>; Thu, 12 Dec 2019 01:01:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SvGlHMLMo21V for <iommu@lists.linux-foundation.org>;
 Thu, 12 Dec 2019 01:01:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 9B166886D0
 for <iommu@lists.linux-foundation.org>; Thu, 12 Dec 2019 01:01:08 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 11 Dec 2019 17:01:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,303,1571727600"; d="scan'208";a="225733894"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136])
 ([10.239.159.136])
 by orsmga002.jf.intel.com with ESMTP; 11 Dec 2019 17:01:04 -0800
Subject: Re: [PATCH 1/1] iommu/vt-d: Fix dmar pte read access not set error
To: Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>,
 ashok.raj@intel.com, jacob.jun.pan@intel.com, kevin.tian@intel.com,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20191211014015.7898-1-baolu.lu@linux.intel.com>
 <20191211163511.gjju2s3yy4sus44w@cantor>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <86270320-efae-1c37-4c5a-6e5415e36a95@linux.intel.com>
Date: Thu, 12 Dec 2019 09:00:18 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191211163511.gjju2s3yy4sus44w@cantor>
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

SGksCgpPbiAxMi8xMi8xOSAxMjozNSBBTSwgSmVycnkgU25pdHNlbGFhciB3cm90ZToKPiBPbiBX
ZWQgRGVjIDExIDE5LCBMdSBCYW9sdSB3cm90ZToKPj4gSWYgdGhlIGRlZmF1bHQgRE1BIGRvbWFp
biBvZiBhIGdyb3VwIGRvZXNuJ3QgZml0IGEgZGV2aWNlLCBpdAo+PiB3aWxsIHN0aWxsIHNpdCBp
biB0aGUgZ3JvdXAgYnV0IHVzZSBhIHByaXZhdGUgaWRlbnRpdHkgZG9tYWluLgo+PiBXaGVuIG1h
cC91bm1hcC9pb3ZhX3RvX3BoeXMgY29tZSB0aHJvdWdoIGlvbW11IEFQSSwgdGhlIGRyaXZlcgo+
PiBzaG91bGQgc3RpbGwgc2VydmUgdGhlbSwgb3RoZXJ3aXNlLCBvdGhlciBkZXZpY2VzIGluIHRo
ZSBzYW1lCj4+IGdyb3VwIHdpbGwgYmUgaW1wYWN0ZWQuIFNpbmNlIGlkZW50aXR5IGRvbWFpbiBo
YXMgYmVlbiBtYXBwZWQKPj4gd2l0aCB0aGUgd2hvbGUgYXZhaWxhYmxlIG1lbW9yeSBzcGFjZSBh
bmQgUk1SUnMsIHdlIGRvbid0IG5lZWQKPj4gdG8gd29ycnkgYWJvdXQgdGhlIGltcGFjdCBvbiBp
dC4KPj4KPiAKPiBEb2VzIHRoaXMgcG9zZSBhbnkgcG90ZW50aWFsIGlzc3VlcyB3aXRoIHRoZSBy
ZXZlcnNlIGNhc2Ugd2hlcmUgdGhlCj4gZ3JvdXAgaGFzIGEgZGVmYXVsdCBpZGVudGl0eSBkb21h
aW4sIGFuZCB0aGUgZmlyc3QgZGV2aWNlIGZpdHMgdGhhdCwKPiBidXQgYSBsYXRlciBkZXZpY2Ug
aW4gdGhlIGdyb3VwIG5lZWRzIGRtYSBhbmQgZ2V0cyBhIHByaXZhdGUgZG1hCj4gZG9tYWluPwoK
Tm8uIGlvbW11X21hcC91bm1hcCgpIHNob3VsZCBub3QgYmUgY2FsbGVkIGZvciBkZWZhdWx0IGlk
ZW50aXR5IGRvbWFpbi4KCiAgICAgICAgIGlmICh1bmxpa2VseSghKGRvbWFpbi0+dHlwZSAmIF9f
SU9NTVVfRE9NQUlOX1BBR0lORykpKQogICAgICAgICAgICAgICAgIHJldHVybiAtRUlOVkFMOwoK
QmVzdCByZWdhcmRzLApiYW9sdQoKPiAKPj4gTGluazogaHR0cHM6Ly93d3cuc3Bpbmljcy5uZXQv
bGlzdHMvaW9tbXUvbXNnNDA0MTYuaHRtbAo+PiBDYzogSmVycnkgU25pdHNlbGFhciA8anNuaXRz
ZWxAcmVkaGF0LmNvbT4KPj4gUmVwb3J0ZWQtYnk6IEplcnJ5IFNuaXRzZWxhYXIgPGpzbml0c2Vs
QHJlZGhhdC5jb20+Cj4+IEZpeGVzOiA5NDIwNjdmMWI2Yjk3ICgiaW9tbXUvdnQtZDogSWRlbnRp
ZnkgZGVmYXVsdCBkb21haW5zIHJlcGxhY2VkIAo+PiB3aXRoIHByaXZhdGUiKQo+PiBDYzogc3Rh
YmxlQHZnZXIua2VybmVsLm9yZyAjIHY1LjMrCj4+IFNpZ25lZC1vZmYtYnk6IEx1IEJhb2x1IDxi
YW9sdS5sdUBsaW51eC5pbnRlbC5jb20+Cj4+IC0tLQo+PiBkcml2ZXJzL2lvbW11L2ludGVsLWlv
bW11LmMgfCA4IC0tLS0tLS0tCj4+IDEgZmlsZSBjaGFuZ2VkLCA4IGRlbGV0aW9ucygtKQo+Pgo+
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pb21tdS9pbnRlbC1pb21tdS5jIGIvZHJpdmVycy9pb21t
dS9pbnRlbC1pb21tdS5jCj4+IGluZGV4IDBjOGQ4MWY1NmEzMC4uYjczYmViZWE5MTQ4IDEwMDY0
NAo+PiAtLS0gYS9kcml2ZXJzL2lvbW11L2ludGVsLWlvbW11LmMKPj4gKysrIGIvZHJpdmVycy9p
b21tdS9pbnRlbC1pb21tdS5jCj4+IEBAIC01NDc4LDkgKzU0NzgsNiBAQCBzdGF0aWMgaW50IGlu
dGVsX2lvbW11X21hcChzdHJ1Y3QgaW9tbXVfZG9tYWluIAo+PiAqZG9tYWluLAo+PiDCoMKgwqDC
oGludCBwcm90ID0gMDsKPj4gwqDCoMKgwqBpbnQgcmV0Owo+Pgo+PiAtwqDCoMKgIGlmIChkbWFy
X2RvbWFpbi0+ZmxhZ3MgJiBET01BSU5fRkxBR19MT1NFX0NISUxEUkVOKQo+PiAtwqDCoMKgwqDC
oMKgwqAgcmV0dXJuIC1FSU5WQUw7Cj4+IC0KPj4gwqDCoMKgwqBpZiAoaW9tbXVfcHJvdCAmIElP
TU1VX1JFQUQpCj4+IMKgwqDCoMKgwqDCoMKgIHByb3QgfD0gRE1BX1BURV9SRUFEOwo+PiDCoMKg
wqDCoGlmIChpb21tdV9wcm90ICYgSU9NTVVfV1JJVEUpCj4+IEBAIC01NTIzLDggKzU1MjAsNiBA
QCBzdGF0aWMgc2l6ZV90IGludGVsX2lvbW11X3VubWFwKHN0cnVjdCAKPj4gaW9tbXVfZG9tYWlu
ICpkb21haW4sCj4+IMKgwqDCoMKgLyogQ29wZSB3aXRoIGhvcnJpZCBBUEkgd2hpY2ggcmVxdWly
ZXMgdXMgdG8gdW5tYXAgbW9yZSB0aGFuIHRoZQo+PiDCoMKgwqDCoMKgwqAgc2l6ZSBhcmd1bWVu
dCBpZiBpdCBoYXBwZW5zIHRvIGJlIGEgbGFyZ2UtcGFnZSBtYXBwaW5nLiAqLwo+PiDCoMKgwqDC
oEJVR19PTighcGZuX3RvX2RtYV9wdGUoZG1hcl9kb21haW4sIGlvdmEgPj4gVlREX1BBR0VfU0hJ
RlQsICZsZXZlbCkpOwo+PiAtwqDCoMKgIGlmIChkbWFyX2RvbWFpbi0+ZmxhZ3MgJiBET01BSU5f
RkxBR19MT1NFX0NISUxEUkVOKQo+PiAtwqDCoMKgwqDCoMKgwqAgcmV0dXJuIDA7Cj4+Cj4+IMKg
wqDCoMKgaWYgKHNpemUgPCBWVERfUEFHRV9TSVpFIDw8IGxldmVsX3RvX29mZnNldF9iaXRzKGxl
dmVsKSkKPj4gwqDCoMKgwqDCoMKgwqAgc2l6ZSA9IFZURF9QQUdFX1NJWkUgPDwgbGV2ZWxfdG9f
b2Zmc2V0X2JpdHMobGV2ZWwpOwo+PiBAQCAtNTU1Niw5ICs1NTUxLDYgQEAgc3RhdGljIHBoeXNf
YWRkcl90IAo+PiBpbnRlbF9pb21tdV9pb3ZhX3RvX3BoeXMoc3RydWN0IGlvbW11X2RvbWFpbiAq
ZG9tYWluLAo+PiDCoMKgwqDCoGludCBsZXZlbCA9IDA7Cj4+IMKgwqDCoMKgdTY0IHBoeXMgPSAw
Owo+Pgo+PiAtwqDCoMKgIGlmIChkbWFyX2RvbWFpbi0+ZmxhZ3MgJiBET01BSU5fRkxBR19MT1NF
X0NISUxEUkVOKQo+PiAtwqDCoMKgwqDCoMKgwqAgcmV0dXJuIDA7Cj4+IC0KPj4gwqDCoMKgwqBw
dGUgPSBwZm5fdG9fZG1hX3B0ZShkbWFyX2RvbWFpbiwgaW92YSA+PiBWVERfUEFHRV9TSElGVCwg
JmxldmVsKTsKPj4gwqDCoMKgwqBpZiAocHRlKQo+PiDCoMKgwqDCoMKgwqDCoCBwaHlzID0gZG1h
X3B0ZV9hZGRyKHB0ZSk7Cj4+IC0tIAo+PiAyLjE3LjEKPj4KPiAKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxp
c3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
