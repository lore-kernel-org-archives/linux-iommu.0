Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4F75C433EF
	for <iommu@archiver.kernel.org>; Mon, 20 Jun 2022 08:57:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 77F4F4182C;
	Mon, 20 Jun 2022 08:57:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 77F4F4182C
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=PWDF40cF
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id stknC_1bFYSP; Mon, 20 Jun 2022 08:57:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id DDFFF409FA;
	Mon, 20 Jun 2022 08:57:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DDFFF409FA
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B076DC0032;
	Mon, 20 Jun 2022 08:57:57 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 26FCCC002D
 for <iommu@lists.linux-foundation.org>; Mon, 20 Jun 2022 08:57:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 003D960F2A
 for <iommu@lists.linux-foundation.org>; Mon, 20 Jun 2022 08:57:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 003D960F2A
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=PWDF40cF
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qQq4L4R_oRdI for <iommu@lists.linux-foundation.org>;
 Mon, 20 Jun 2022 08:57:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8F21360D88
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8F21360D88
 for <iommu@lists.linux-foundation.org>; Mon, 20 Jun 2022 08:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1655715475; x=1687251475;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=27Tz/dNkwLMoj/0Mc6AnPbKP/6tdnuKXsgwtLD/28Fk=;
 b=PWDF40cFVfW8eH8ywitl8lI0j3iRzW7cWjWJGxqzyspSKRyRXBhNg3TU
 DTc8W+EGNcs6cuMRrY8H6ConFVTnesKLwUwnnTZ0OaV5UcGx7k90L9Udm
 HMvOsSYhqGzSX8pn7nJG4b+3xs33AadcYxgnufAYKTRRRclWPDTeBn8rp
 arR2EdduyJGErpku+vQ4mEKB0UBHkBKlp4tsrjipOn/3JJbxAsqYVxyYX
 p88Qrqiuc/aqYPve6ruNuZ69gVMly6q/kXhSAt4ilyjire3qw1lIVfxML
 vJsgyKMoRwwrEAxJdPaOutAxzGxw0yc6yxd3Uasy0W/7Ja0G5bG5aavxU w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="259665394"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; d="scan'208";a="259665394"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jun 2022 01:57:55 -0700
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; d="scan'208";a="643019952"
Received: from lgao7-mobl2.ccr.corp.intel.com (HELO [10.255.31.74])
 ([10.255.31.74])
 by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jun 2022 01:57:52 -0700
Message-ID: <868f515e-a4ea-8c34-7317-5aba18f8d5f0@linux.intel.com>
Date: Mon, 20 Jun 2022 16:57:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 1/1] iommu/vt-d: Fix RID2PASID setup failure
Content-Language: en-US
To: Yi Liu <yi.l.liu@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Kevin Tian <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>
References: <20220620081729.4610-1-baolu.lu@linux.intel.com>
 <03e70268-aadc-7ad2-276b-bf029487a5de@intel.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <03e70268-aadc-7ad2-276b-bf029487a5de@intel.com>
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

T24gMjAyMi82LzIwIDE2OjMxLCBZaSBMaXUgd3JvdGU6Cj4gSGkgQmFvbHUsCj4gCj4gT24gMjAy
Mi82LzIwIDE2OjE3LCBMdSBCYW9sdSB3cm90ZToKPj4gVGhlIElPTU1VIGRyaXZlciBzaGFyZXMg
dGhlIHBhc2lkIHRhYmxlIGZvciBQQ0kgYWxpYXMgZGV2aWNlcy4gV2hlbiB0aGUKPj4gUklEMlBB
U0lEIGVudHJ5IG9mIHRoZSBzaGFyZWQgcGFzaWQgdGFibGUgaGFzIGJlZW4gZmlsbGVkIGJ5IHRo
ZSBmaXJzdAo+PiBkZXZpY2UsIHRoZSBzdWJzZXF1ZW50IGRldmljZXMgd2lsbCBlbmNvdW50ZXIg
dGhlICJETUFSOiBTZXR1cCBSSUQyUEFTSUQKPj4gZmFpbGVkIiBmYWlsdXJlIGFzIHRoZSBwYXNp
ZCBlbnRyeSBoYXMgYWxyZWFkeSBiZWVuIG1hcmtlIGFzIHByZXNlbnQuIEFzCj4gCj4gcy9tYXJr
ZS9tYXJrZWQvCgpVcGRhdGVkLiBUaGFua3MhCgo+PiB0aGUgcmVzdWx0LCB0aGUgSU9NTVUgcHJv
YmluZyBwcm9jZXNzIHdpbGwgYmUgYWJvcnRlZC4KPj4KPj4gVGhpcyBmaXhlcyBpdCBieSBza2lw
cGluZyBSSUQyUEFTSUQgc2V0dGluZyBpZiB0aGUgcGFzaWQgZW50cnkgaGFzIGJlZW4KPj4gcG9w
dWxhdGVkLiBUaGlzIHdvcmtzIGJlY2F1c2UgdGhlIElPTU1VIGNvcmUgZW5zdXJlcyB0aGF0IG9u
bHkgdGhlIHNhbWUKPj4gSU9NTVUgZG9tYWluIGNhbiBiZSBhdHRhY2hlZCB0byBhbGwgUENJIGFs
aWFzIGRldmljZXMgYXQgdGhlIHNhbWUgdGltZS4KPiAKPiBuaXQuIHRoaXMgc2VudGVuY2UgaXMg
YSBsaXR0bGUgYml0IHRvIGludGVycHJldC4gOi0pIEkgZ3Vlc3Mgd2hhdCB5b3Ugd2FudAo+IHRv
IGRlc2NyaWJlIGlzIHRoZSBQQ0kgYWxpYXMgZGV2aWNlcyBzaG91bGQgYmUgYXR0YWNoZWQgdG8g
dGhlIHNhbWUgZG9tYWluCj4gaW5zdGVhZCBvZiBkaWZmZXJlbnQgZG9tYWluLiByaWdodD8KClll
cy4KCj4gCj4gYWxzbywgZG9lcyBpdCBhcHBseSB0byBhbGwgZG9tYWluIHR5cGVzPyBlLmcuIHRo
ZSBTVkEgZG9tYWlucyBpbnRyb2R1Y2VkIAo+IGluICJpb21tdTogU1ZBIGFuZCBJT1BGIHJlZmFj
dG9yaW5nIgoKTm8uIE9ubHkgYWJvdXQgdGhlIFJJRDJQQVNJRC4KCj4gCj4+IFRoZXJlZm9yZSB0
aGUgc3Vic2VxdWVudCBkZXZpY2VzIGp1c3QgdHJ5IHRvIHNldHVwIHRoZSBSSUQyUEFTSUQgZW50
cnkKPj4gd2l0aCB0aGUgc2FtZSBkb21haW4sIHdoaWNoIGlzIG5lZ2xpZ2libGUuCj4+Cj4+IEZp
eGVzOiBlZjg0OGI3ZTVhNmEwICgiaW9tbXUvdnQtZDogU2V0dXAgcGFzaWQgZW50cnkgZm9yIFJJ
RDJQQVNJRCAKPj4gc3VwcG9ydCIpCj4+IFJlcG9ydGVkLWJ5OiBDaGVueWkgUWlhbmcgPGNoZW55
aS5xaWFuZ0BpbnRlbC5jb20+Cj4+IENjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnCj4+IFNpZ25l
ZC1vZmYtYnk6IEx1IEJhb2x1IDxiYW9sdS5sdUBsaW51eC5pbnRlbC5jb20+Cj4+IC0tLQo+PiDC
oCBkcml2ZXJzL2lvbW11L2ludGVsL2lvbW11LmMgfCAyICstCj4+IMKgIDEgZmlsZSBjaGFuZ2Vk
LCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQo+Pgo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9pb21tdS9pbnRlbC9pb21tdS5jIGIvZHJpdmVycy9pb21tdS9pbnRlbC9pb21tdS5jCj4+IGlu
ZGV4IDQ0MDE2NTk0ODMxZC4uYjk5NjZjMDFhMmEyIDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJzL2lv
bW11L2ludGVsL2lvbW11LmMKPj4gKysrIGIvZHJpdmVycy9pb21tdS9pbnRlbC9pb21tdS5jCj4+
IEBAIC0yNTY0LDcgKzI1NjQsNyBAQCBzdGF0aWMgaW50IGRvbWFpbl9hZGRfZGV2X2luZm8oc3Ry
dWN0IAo+PiBkbWFyX2RvbWFpbiAqZG9tYWluLCBzdHJ1Y3QgZGV2aWNlICpkZXYpCj4+IMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldCA9IGludGVsX3Bhc2lkX3NldHVwX3NlY29uZF9sZXZl
bChpb21tdSwgZG9tYWluLAo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgZGV2LCBQQVNJRF9SSUQyUEFTSUQpOwo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgc3Bpbl91
bmxvY2tfaXJxcmVzdG9yZSgmaW9tbXUtPmxvY2ssIGZsYWdzKTsKPj4gLcKgwqDCoMKgwqDCoMKg
IGlmIChyZXQpIHsKPj4gK8KgwqDCoMKgwqDCoMKgIGlmIChyZXQgJiYgcmV0ICE9IC1FQlVTWSkg
ewo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBkZXZfZXJyKGRldiwgIlNldHVwIFJJRDJQ
QVNJRCBmYWlsZWRcbiIpOwo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBkbWFyX3JlbW92
ZV9vbmVfZGV2X2luZm8oZGV2KTsKPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJu
IHJldDsKPiAKCi0tCkJlc3QgcmVnYXJkcywKYmFvbHUKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxp
bnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2lvbW11
