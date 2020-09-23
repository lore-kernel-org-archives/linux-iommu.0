Return-Path: <SRS0=5N08=DA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18068C4363D
	for <iommu@archiver.kernel.org>; Wed, 23 Sep 2020 05:44:19 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B3FE21D91
	for <iommu@archiver.kernel.org>; Wed, 23 Sep 2020 05:44:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B3FE21D91
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 203DE85E7D;
	Wed, 23 Sep 2020 05:44:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aabPl56RQg7z; Wed, 23 Sep 2020 05:44:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 527D0855FE;
	Wed, 23 Sep 2020 05:44:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 37029C0889;
	Wed, 23 Sep 2020 05:44:17 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1FA3AC0051
 for <iommu@lists.linux-foundation.org>; Wed, 23 Sep 2020 05:44:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 0E154872E1
 for <iommu@lists.linux-foundation.org>; Wed, 23 Sep 2020 05:44:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id A+QsOlHedI49 for <iommu@lists.linux-foundation.org>;
 Wed, 23 Sep 2020 05:44:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 5923E87010
 for <iommu@lists.linux-foundation.org>; Wed, 23 Sep 2020 05:44:15 +0000 (UTC)
IronPort-SDR: BGXe/DwGjZ0QjSJ2LRNWjBYppLQpGFbpztinE7JfqNVI3oENnnjBLk/PkVFZkQj5tfiVW5CQJ/
 pOYUq1OajBmg==
X-IronPort-AV: E=McAfee;i="6000,8403,9752"; a="245628801"
X-IronPort-AV: E=Sophos;i="5.77,293,1596524400"; d="scan'208";a="245628801"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Sep 2020 22:44:11 -0700
IronPort-SDR: CkmKka6DBA6ajh/NWMmcSZBHr2cMIuifPtzoqLnwIXRahp8uvEDRyeUcEMggOqArX2oVhguqna
 hqdNfVFu4joQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,293,1596524400"; d="scan'208";a="412892054"
Received: from allen-box.sh.intel.com (HELO [10.239.159.139])
 ([10.239.159.139])
 by fmsmga001.fm.intel.com with ESMTP; 22 Sep 2020 22:44:08 -0700
Subject: Re: [PATCH v3 0/6] Convert the intel iommu driver to the dma-iommu api
To: Robin Murphy <robin.murphy@arm.com>,
 Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
 Joerg Roedel <joro@8bytes.org>, Tom Murphy <murphyt7@tcd.ie>,
 David Woodhouse <dwmw2@infradead.org>, Christoph Hellwig <hch@infradead.org>
References: <20200912032200.11489-1-baolu.lu@linux.intel.com>
 <51a1baec-48d1-c0ac-181b-1fba92aa428d@linux.intel.com>
 <001f4446-7c43-9832-42d8-55dc4a13c2ae@linux.intel.com>
 <9173fed9-e60f-5189-e17d-b23bfabdaa38@linux.intel.com>
 <d4633137-136e-d96c-877a-b523018c51e7@arm.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <8d2a5124-92ce-2cdd-42a4-d7a22aa4e02a@linux.intel.com>
Date: Wed, 23 Sep 2020 13:38:05 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <d4633137-136e-d96c-877a-b523018c51e7@arm.com>
Content-Language: en-US
Cc: linux-kernel@vger.kernel.org, Intel-gfx@lists.freedesktop.org,
 Ashok Raj <ashok.raj@intel.com>, iommu@lists.linux-foundation.org
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

T24gOS8yMi8yMCA3OjA1IFBNLCBSb2JpbiBNdXJwaHkgd3JvdGU6Cj4+Pj4gV2l0aCB0aGUgcHJl
dmlvdXMgdmVyc2lvbiBvZiB0aGUgc2VyaWVzIEkgaGl0IGEgcHJvYmxlbSBvbiBJdnlicmlkZ2Ug
Cj4+Pj4gd2hlcmUgYXBwYXJlbnRseSB0aGUgZG1hIGVuZ2luZSB3aWR0aCBpcyBub3QgcmVzcGVj
dGVkLiBBdCBsZWFzdCAKPj4+PiB0aGF0IGlzIG15IGxheW1hbiBpbnRlcnByZXRhdGlvbiBvZiB0
aGUgZXJyb3JzLiBGcm9tIHRoZSBvbGRlciB0aHJlYWQ6Cj4+Pj4KPj4+PiA8Mz4gWzIwOS41MjY2
MDVdIERNQVI6IGludGVsX2lvbW11X21hcDogaW9tbXUgd2lkdGggKDM5KSBpcyBub3QgCj4+Pj4g
c3VmZmljaWVudCBmb3IgdGhlIG1hcHBlZCBhZGRyZXNzIChmZmZmMDA4MDAwKQo+Pj4+Cj4+Pj4g
UmVsZXZhbnQgaW9tbXUgYm9vdCByZWxhdGVkIG1lc3NhZ2VzIGFyZToKPj4+Pgo+Pj4+IDw2PlvC
oMKgwqAgMC4xODQyMzRdIERNQVI6IEhvc3QgYWRkcmVzcyB3aWR0aCAzNgo+Pj4+IDw2PlvCoMKg
wqAgMC4xODQyNDVdIERNQVI6IERSSEQgYmFzZTogMHgwMDAwMDBmZWQ5MDAwMCBmbGFnczogMHgw
Cj4+Pj4gPDY+W8KgwqDCoCAwLjE4NDI4OF0gRE1BUjogZG1hcjA6IHJlZ19iYXNlX2FkZHIgZmVk
OTAwMDAgdmVyIDE6MCBjYXAgCj4+Pj4gYzAwMDAwMjBlNjAyNjIgZWNhcCBmMDEwMWEKPj4+PiA8
Nj5bwqDCoMKgIDAuMTg0MzA4XSBETUFSOiBEUkhEIGJhc2U6IDB4MDAwMDAwZmVkOTEwMDAgZmxh
Z3M6IDB4MQo+Pj4+IDw2PlvCoMKgwqAgMC4xODQzMzddIERNQVI6IGRtYXIxOiByZWdfYmFzZV9h
ZGRyIGZlZDkxMDAwIHZlciAxOjAgY2FwIAo+Pj4+IGM5MDA4MDIwNjYwMjYyIGVjYXAgZjAxMDVh
Cj4+Pj4gPDY+W8KgwqDCoCAwLjE4NDM1N10gRE1BUjogUk1SUiBiYXNlOiAweDAwMDAwMGQ4ZDI4
MDAwIGVuZDogCj4+Pj4gMHgwMDAwMDBkOGQ0NmZmZgo+Pj4+IDw2PlvCoMKgwqAgMC4xODQzNzdd
IERNQVI6IFJNUlIgYmFzZTogMHgwMDAwMDBkYjAwMDAwMCBlbmQ6IAo+Pj4+IDB4MDAwMDAwZGYx
ZmZmZmYKPj4+PiA8Nj5bwqDCoMKgIDAuMTg0Mzk4XSBETUFSLUlSOiBJT0FQSUMgaWQgMiB1bmRl
ciBEUkhEIGJhc2XCoCAweGZlZDkxMDAwIAo+Pj4+IElPTU1VIDEKPj4+PiA8Nj5bwqDCoMKgIDAu
MTg0NDE0XSBETUFSLUlSOiBIUEVUIGlkIDAgdW5kZXIgRFJIRCBiYXNlIDB4ZmVkOTEwMDAKPj4+
PiA8Nj5bwqDCoMKgIDAuMTg0NDI4XSBETUFSLUlSOiBRdWV1ZWQgaW52YWxpZGF0aW9uIHdpbGwg
YmUgZW5hYmxlZCB0byAKPj4+PiBzdXBwb3J0IHgyYXBpYyBhbmQgSW50ci1yZW1hcHBpbmcuCj4+
Pj4gPDY+W8KgwqDCoCAwLjE4NTE3M10gRE1BUi1JUjogRW5hYmxlZCBJUlEgcmVtYXBwaW5nIGlu
IHgyYXBpYyBtb2RlCj4+Pj4KPj4+PiA8Nj5bwqDCoMKgIDAuODc4OTM0XSBETUFSOiBObyBBVFNS
IGZvdW5kCj4+Pj4gPDY+W8KgwqDCoCAwLjg3ODk2Nl0gRE1BUjogZG1hcjA6IFVzaW5nIFF1ZXVl
ZCBpbnZhbGlkYXRpb24KPj4+PiA8Nj5bwqDCoMKgIDAuODc5MDA3XSBETUFSOiBkbWFyMTogVXNp
bmcgUXVldWVkIGludmFsaWRhdGlvbgo+Pj4+Cj4+Pj4gPDY+W8KgwqDCoCAwLjkxNTAzMl0gRE1B
UjogSW50ZWwoUikgVmlydHVhbGl6YXRpb24gVGVjaG5vbG9neSBmb3IgCj4+Pj4gRGlyZWN0ZWQg
SS9PCj4+Pj4gPDY+W8KgwqDCoCAwLjkxNTA2MF0gUENJLURNQTogVXNpbmcgc29mdHdhcmUgYm91
bmNlIGJ1ZmZlcmluZyBmb3IgSU8gCj4+Pj4gKFNXSU9UTEIpCj4+Pj4gPDY+W8KgwqDCoCAwLjkx
NTA4NF0gc29mdHdhcmUgSU8gVExCOiBtYXBwZWQgW21lbSAKPj4+PiAweGM4MGQ0MDAwLTB4Y2Mw
ZDQwMDBdICg2NE1CKQo+Pj4+Cj4+Pj4gKEZ1bGwgYm9vdCBsb2cgYXQgCj4+Pj4gaHR0cHM6Ly9p
bnRlbC1nZngtY2kuMDEub3JnL3RyZWUvZHJtLXRpcC9Ucnlib3RfNzA1NC9maS1pdmItMzc3MC9i
b290MC50eHQsIAo+Pj4+IGZhaWx1cmVzIGF0IAo+Pj4+IGh0dHBzOi8vaW50ZWwtZ2Z4LWNpLjAx
Lm9yZy90cmVlL2RybS10aXAvVHJ5Ym90XzcwNTQvZmktaXZiLTM3NzAvaWd0QGk5MTVfc2VsZnRl
c3RAbGl2ZUBibHQuaHRtbC4pIAo+Pj4+Cj4+Pj4KPj4+PiBEb2VzIHRoaXMgbG9vayBmYW1pbGlh
ciBvciBhdCBsZWFzdCBwbGF1c2libGUgdG8geW91PyBJcyB0aGlzIAo+Pj4+IHNvbWV0aGluZyB5
b3VyIG5ldyBzZXJpZXMgaGFzIGZpeGVkPwo+Pj4KPj4+IFRoaXMgaGFwcGVucyBkdXJpbmcgYXR0
YWNoaW5nIGEgZG9tYWluIHRvIGRldmljZS4gSXQgaGFzIG5vdGhpbmcgdG8gZG8KPj4+IHdpdGgg
dGhpcyBwYXRjaCBzZXJpZXMuIEkgd2lsbCBsb29rIGludG8gdGhpcyBpc3N1ZSwgYnV0IG5vdCBp
biB0aGlzCj4+PiBlbWFpbCB0aHJlYWQgY29udGV4dC4KPj4KPj4gSSBhbSBub3Qgc3VyZSB3aGF0
IHN0ZXAgaXMgYXR0YWNoaW5nIGRvbWFpbiB0byBkZXZpY2UsIGJ1dCB0aGVzZSB0eXBlIAo+PiBt
ZXNzYWdlczoKPj4KPj4gPDM+IFsyMDkuNTI2NjA1XSBETUFSOiBpbnRlbF9pb21tdV9tYXA6IGlv
bW11IHdpZHRoICgzOSkgaXMgbm90Cj4+IMKgPj4gc3VmZmljaWVudCBmb3IgdGhlIG1hcHBlZCBh
ZGRyZXNzIChmZmZmMDA4MDAwKQo+Pgo+PiBUaGV5IGRlZmluaXRlbHkgYXBwZWFyIHRvIGhhcHBl
biBhdCBydW50aW1lLCBhcyBpOTE1IGlzIGdldHRpbmcgCj4+IGV4ZXJjaXNlZCBieSB1c2Vyc3Bh
Y2UuCj4gCj4gQUZBSUNTIHRoaXMgY2VydGFpbmx5IG1pZ2h0IGJlIHJlbGF0ZWQgdG8gdGhpcyBz
ZXJpZXMgLSBpb21tdS1kbWEgd2lsbCAKCk9oISBJIGxvb2tlZCBhdCB0aGUgd3JvbmcgZnVuY3Rp
b24uIHByZXBhcmVfZG9tYWluX2F0dGFjaF9kZXZpY2UoKQpwcmludHMgYSBzaW1pbGFyIG1lc3Nh
Z2Ugd2hpY2ggbWFkZSBtZSBiZWxpZXZlIHRoYXQgaXQgd2FzIG5vdCBjYXVzZWQKYnkgdGhlIHRo
aXMgcGF0Y2hlcyBzZXJpZXMuCgo+IGNvbnN0cmFpbiBJT1ZBIGFsbG9jYXRpb24gYmFzZWQgb24g
dGhlIGRvbWFpbiBnZW9tZXRyeSB0aGF0IHRoZSBkcml2ZXIgCj4gcmVwb3J0cywgd2hpY2ggaW4g
dGhpcyBjYXNlIGlzIHNldCBvbmx5IG9uY2Ugd2hlbiBmaXJzdCBhbGxvY2F0aW5nIHRoZSAKPiBk
b21haW4uIFRodXMgaXQgbG9va3MgbGlrZSBib3RoIHRoZSBkbWFyX2RvbWFpbi0+Z2F3IGFkanVz
dG1lbnQgaW4gCj4gcHJlcGFyZV9kb21haW5fYXR0YWNoX2RldmljZSgpIGFuZCB0aGUgZG9tYWlu
X3VzZV9maXJzdF9sZXZlbCgpIGJ1c2luZXNzIAo+IGluIGludGVsX2FsbG9jX2lvdmEoKSBlZmZl
Y3RpdmVseSBnZXQgbG9zdCBpbiB0aGlzIGNvbnZlcnNpb24sIHNpbmNlIHRoZSAKPiBkb21haW4g
Z2VvbWV0cnkgbmV2ZXIgZ2V0cyB1cGRhdGVkIHRvIHJlZmxlY3QgdGhvc2UgYWRkaXRpb25hbCBj
b25zdHJhaW50cy4KClNvdW5kcyByZWFzb25hYmxlLiBJIHdpbGwgbG9vayBpbnRvIHRoZSBjb2Rl
IGFuZCB3b3JrIG91dCBhIGZpeC4KCj4gPiBSb2Jpbi4KPiAKCkJlc3QgcmVnYXJkcywKYmFvbHUK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFp
bGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMu
bGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
