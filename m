Return-Path: <SRS0=CZ1O=C7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C1A4C2D0E2
	for <iommu@archiver.kernel.org>; Tue, 22 Sep 2020 11:06:03 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BA78207C3
	for <iommu@archiver.kernel.org>; Tue, 22 Sep 2020 11:06:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BA78207C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 00E7120406;
	Tue, 22 Sep 2020 11:06:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id u6-ZyE6FslWh; Tue, 22 Sep 2020 11:06:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 1ACC32038D;
	Tue, 22 Sep 2020 11:06:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 07359C0889;
	Tue, 22 Sep 2020 11:06:00 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A9160C0051
 for <iommu@lists.linux-foundation.org>; Tue, 22 Sep 2020 11:05:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 910F2870D5
 for <iommu@lists.linux-foundation.org>; Tue, 22 Sep 2020 11:05:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lYLuuqJBT6Ya for <iommu@lists.linux-foundation.org>;
 Tue, 22 Sep 2020 11:05:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by hemlock.osuosl.org (Postfix) with ESMTP id 4E6F3870C7
 for <iommu@lists.linux-foundation.org>; Tue, 22 Sep 2020 11:05:57 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9F7D6113E;
 Tue, 22 Sep 2020 04:05:56 -0700 (PDT)
Received: from [10.57.48.76] (unknown [10.57.48.76])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 162F83F70D;
 Tue, 22 Sep 2020 04:05:54 -0700 (PDT)
Subject: Re: [PATCH v3 0/6] Convert the intel iommu driver to the dma-iommu api
To: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
 Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
 Tom Murphy <murphyt7@tcd.ie>, David Woodhouse <dwmw2@infradead.org>,
 Christoph Hellwig <hch@infradead.org>
References: <20200912032200.11489-1-baolu.lu@linux.intel.com>
 <51a1baec-48d1-c0ac-181b-1fba92aa428d@linux.intel.com>
 <001f4446-7c43-9832-42d8-55dc4a13c2ae@linux.intel.com>
 <9173fed9-e60f-5189-e17d-b23bfabdaa38@linux.intel.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <d4633137-136e-d96c-877a-b523018c51e7@arm.com>
Date: Tue, 22 Sep 2020 12:05:53 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <9173fed9-e60f-5189-e17d-b23bfabdaa38@linux.intel.com>
Content-Language: en-GB
Cc: Intel-gfx@lists.freedesktop.org, Ashok Raj <ashok.raj@intel.com>,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
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

T24gMjAyMC0wOS0xNSAwOTozMSwgVHZydGtvIFVyc3VsaW4gd3JvdGU6Cj4gCj4gT24gMTUvMDkv
MjAyMCAwMjo0NywgTHUgQmFvbHUgd3JvdGU6Cj4+IEhpIFR2cnRrbywKPj4KPj4gT24gOS8xNC8y
MCA0OjA0IFBNLCBUdnJ0a28gVXJzdWxpbiB3cm90ZToKPj4+Cj4+PiBIaSwKPj4+Cj4+PiBPbiAx
Mi8wOS8yMDIwIDA0OjIxLCBMdSBCYW9sdSB3cm90ZToKPj4+PiBUb20gTXVycGh5IGhhcyBhbG1v
c3QgZG9uZSBhbGwgdGhlIHdvcmsuIEhpcyBsYXRlc3QgcGF0Y2ggc2VyaWVzIHdhcwo+Pj4+IHBv
c3RlZCBoZXJlLgo+Pj4+Cj4+Pj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtaW9tbXUv
MjAyMDA5MDMyMDE4MzkuNzMyNy0xLW11cnBoeXQ3QHRjZC5pZS8gCj4+Pj4KPj4+Pgo+Pj4+IFRo
YW5rcyBhIGxvdCEKPj4+Pgo+Pj4+IFRoaXMgc2VyaWVzIGlzIGEgZm9sbG93LXVwIHdpdGggYmVs
b3cgY2hhbmdlczoKPj4+Pgo+Pj4+IDEuIEFkZCBhIHF1aXJrIGZvciB0aGUgaTkxNSBkcml2ZXIg
aXNzdWUgZGVzY3JpYmVkIGluIFRvbSdzIGNvdmVyCj4+Pj4gbGV0dGVyLgo+Pj4KPj4+IExhc3Qg
d2VlayBJIGhhdmUgY29waWVkIHlvdSBvbiBhbiBpOTE1IHNlcmllcyB3aGljaCBhcHBlYXJzIHRv
IHJlbW92ZSAKPj4+IHRoZSBuZWVkIGZvciB0aGlzIHF1aXJrLiBzbyBpZiB3ZSBnZXQgdGhvc2Ug
aTkxNSBwYXRjaGVzIHJldmlld2VkIGFuZCAKPj4+IG1lcmdlZCwgZG8geW91IHN0aWxsIHdhbnQg
dG8gcHVyc3VlIHRoaXMgcXVpcms/Cj4+Cj4+IEl0J3MgdXAgdG8gdGhlIGdyYXBoaWMgZ3V5cy4g
SSBkb24ndCBrbm93IHRoZSBkZXRhaWxzIGluIGk5MTUgZHJpdmVyLgo+PiBJIGRvbid0IHRoaW5r
IG15IHRlc3RzIGNvdWxkIGNvdmVyIGFsbCBjYXNlcy4KPiAKPiBJIGFtIHRoZSBncmFwaGljIGd1
eS4gOikgSSBqdXN0IG5lZWQgc29tZSByZXZpZXdzIChpbnRlcm5hbGx5KSBmb3IgbXkgCj4gc2Vy
aWVzIGFuZCB0aGVuIHdlIGNhbiBtZXJnZSBpdCwgYXQgd2hpY2ggcG9pbnQgeW91IGRvbid0IG5l
ZWQgdGhlIHF1aXJrIAo+IHBhdGNoIGFueSBtb3JlLiBJJ2xsIHRyeSB0byBhY2NlbGVyYXRlIHRo
aXMuCj4gCj4gV2l0aCByZWdhcmRzIHRvIHRlc3RpbmcsIHlvdSBjb3VsZCBzZW5kIHlvdXIgc2Vy
aWVzIHdpdGggbXkgcGF0Y2hlcyBvbiAKPiB0b3AgdG8gb3VyIHRyeWJvdCBtYWlsaW5nIGxpc3Qg
KGludGVsLWdmeC10cnlib3RAbGlzdHMuZnJlZWRlc2t0b3Aub3JnIC8gCj4gaHR0cHM6Ly9wYXRj
aHdvcmsuZnJlZWRlc2t0b3Aub3JnL3Byb2plY3QvaW50ZWwtZ2Z4LXRyeWJvdC9zZXJpZXMvP29y
ZGVyaW5nPS1sYXN0X3VwZGF0ZWQpIAo+IHdoaWNoIHdvdWxkIHNob3cgeW91IGlmIGl0IGlzIHN0
aWxsIGhpdHRpbmcgdGhlIERNQVIgaXNzdWVzIGluIGk5MTUuCj4gCj4+Pgo+Pj4+IDIuIEZpeCBz
ZXZlcmFsIGJ1Z3MgaW4gcGF0Y2ggImlvbW11OiBBbGxvdyB0aGUgZG1hLWlvbW11IGFwaSB0byB1
c2UKPj4+PiBib3VuY2UgYnVmZmVycyIgdG8gbWFrZSB0aGUgYm91bmNlIGJ1ZmZlciB3b3JrIGZv
ciB1bnRydXN0ZWQgZGV2aWNlcy4KPj4+PiAzLiBTZXZlcmFsIGNsZWFudXBzIGluIGlvbW11L3Z0
LWQgZHJpdmVyIGFmdGVyIHRoZSBjb252ZXJzaW9uLgo+Pj4KPj4+IFdpdGggdGhlIHByZXZpb3Vz
IHZlcnNpb24gb2YgdGhlIHNlcmllcyBJIGhpdCBhIHByb2JsZW0gb24gSXZ5YnJpZGdlIAo+Pj4g
d2hlcmUgYXBwYXJlbnRseSB0aGUgZG1hIGVuZ2luZSB3aWR0aCBpcyBub3QgcmVzcGVjdGVkLiBB
dCBsZWFzdCB0aGF0IAo+Pj4gaXMgbXkgbGF5bWFuIGludGVycHJldGF0aW9uIG9mIHRoZSBlcnJv
cnMuIEZyb20gdGhlIG9sZGVyIHRocmVhZDoKPj4+Cj4+PiA8Mz4gWzIwOS41MjY2MDVdIERNQVI6
IGludGVsX2lvbW11X21hcDogaW9tbXUgd2lkdGggKDM5KSBpcyBub3QgCj4+PiBzdWZmaWNpZW50
IGZvciB0aGUgbWFwcGVkIGFkZHJlc3MgKGZmZmYwMDgwMDApCj4+Pgo+Pj4gUmVsZXZhbnQgaW9t
bXUgYm9vdCByZWxhdGVkIG1lc3NhZ2VzIGFyZToKPj4+Cj4+PiA8Nj5bwqDCoMKgIDAuMTg0MjM0
XSBETUFSOiBIb3N0IGFkZHJlc3Mgd2lkdGggMzYKPj4+IDw2PlvCoMKgwqAgMC4xODQyNDVdIERN
QVI6IERSSEQgYmFzZTogMHgwMDAwMDBmZWQ5MDAwMCBmbGFnczogMHgwCj4+PiA8Nj5bwqDCoMKg
IDAuMTg0Mjg4XSBETUFSOiBkbWFyMDogcmVnX2Jhc2VfYWRkciBmZWQ5MDAwMCB2ZXIgMTowIGNh
cCAKPj4+IGMwMDAwMDIwZTYwMjYyIGVjYXAgZjAxMDFhCj4+PiA8Nj5bwqDCoMKgIDAuMTg0MzA4
XSBETUFSOiBEUkhEIGJhc2U6IDB4MDAwMDAwZmVkOTEwMDAgZmxhZ3M6IDB4MQo+Pj4gPDY+W8Kg
wqDCoCAwLjE4NDMzN10gRE1BUjogZG1hcjE6IHJlZ19iYXNlX2FkZHIgZmVkOTEwMDAgdmVyIDE6
MCBjYXAgCj4+PiBjOTAwODAyMDY2MDI2MiBlY2FwIGYwMTA1YQo+Pj4gPDY+W8KgwqDCoCAwLjE4
NDM1N10gRE1BUjogUk1SUiBiYXNlOiAweDAwMDAwMGQ4ZDI4MDAwIGVuZDogCj4+PiAweDAwMDAw
MGQ4ZDQ2ZmZmCj4+PiA8Nj5bwqDCoMKgIDAuMTg0Mzc3XSBETUFSOiBSTVJSIGJhc2U6IDB4MDAw
MDAwZGIwMDAwMDAgZW5kOiAKPj4+IDB4MDAwMDAwZGYxZmZmZmYKPj4+IDw2PlvCoMKgwqAgMC4x
ODQzOThdIERNQVItSVI6IElPQVBJQyBpZCAyIHVuZGVyIERSSEQgYmFzZcKgIDB4ZmVkOTEwMDAg
Cj4+PiBJT01NVSAxCj4+PiA8Nj5bwqDCoMKgIDAuMTg0NDE0XSBETUFSLUlSOiBIUEVUIGlkIDAg
dW5kZXIgRFJIRCBiYXNlIDB4ZmVkOTEwMDAKPj4+IDw2PlvCoMKgwqAgMC4xODQ0MjhdIERNQVIt
SVI6IFF1ZXVlZCBpbnZhbGlkYXRpb24gd2lsbCBiZSBlbmFibGVkIHRvIAo+Pj4gc3VwcG9ydCB4
MmFwaWMgYW5kIEludHItcmVtYXBwaW5nLgo+Pj4gPDY+W8KgwqDCoCAwLjE4NTE3M10gRE1BUi1J
UjogRW5hYmxlZCBJUlEgcmVtYXBwaW5nIGluIHgyYXBpYyBtb2RlCj4+Pgo+Pj4gPDY+W8KgwqDC
oCAwLjg3ODkzNF0gRE1BUjogTm8gQVRTUiBmb3VuZAo+Pj4gPDY+W8KgwqDCoCAwLjg3ODk2Nl0g
RE1BUjogZG1hcjA6IFVzaW5nIFF1ZXVlZCBpbnZhbGlkYXRpb24KPj4+IDw2PlvCoMKgwqAgMC44
NzkwMDddIERNQVI6IGRtYXIxOiBVc2luZyBRdWV1ZWQgaW52YWxpZGF0aW9uCj4+Pgo+Pj4gPDY+
W8KgwqDCoCAwLjkxNTAzMl0gRE1BUjogSW50ZWwoUikgVmlydHVhbGl6YXRpb24gVGVjaG5vbG9n
eSBmb3IgCj4+PiBEaXJlY3RlZCBJL08KPj4+IDw2PlvCoMKgwqAgMC45MTUwNjBdIFBDSS1ETUE6
IFVzaW5nIHNvZnR3YXJlIGJvdW5jZSBidWZmZXJpbmcgZm9yIElPIAo+Pj4gKFNXSU9UTEIpCj4+
PiA8Nj5bwqDCoMKgIDAuOTE1MDg0XSBzb2Z0d2FyZSBJTyBUTEI6IG1hcHBlZCBbbWVtIDB4Yzgw
ZDQwMDAtMHhjYzBkNDAwMF0gCj4+PiAoNjRNQikKPj4+Cj4+PiAoRnVsbCBib290IGxvZyBhdCAK
Pj4+IGh0dHBzOi8vaW50ZWwtZ2Z4LWNpLjAxLm9yZy90cmVlL2RybS10aXAvVHJ5Ym90XzcwNTQv
ZmktaXZiLTM3NzAvYm9vdDAudHh0LCAKPj4+IGZhaWx1cmVzIGF0IAo+Pj4gaHR0cHM6Ly9pbnRl
bC1nZngtY2kuMDEub3JnL3RyZWUvZHJtLXRpcC9Ucnlib3RfNzA1NC9maS1pdmItMzc3MC9pZ3RA
aTkxNV9zZWxmdGVzdEBsaXZlQGJsdC5odG1sLikgCj4+Pgo+Pj4KPj4+IERvZXMgdGhpcyBsb29r
IGZhbWlsaWFyIG9yIGF0IGxlYXN0IHBsYXVzaWJsZSB0byB5b3U/IElzIHRoaXMgCj4+PiBzb21l
dGhpbmcgeW91ciBuZXcgc2VyaWVzIGhhcyBmaXhlZD8KPj4KPj4gVGhpcyBoYXBwZW5zIGR1cmlu
ZyBhdHRhY2hpbmcgYSBkb21haW4gdG8gZGV2aWNlLiBJdCBoYXMgbm90aGluZyB0byBkbwo+PiB3
aXRoIHRoaXMgcGF0Y2ggc2VyaWVzLiBJIHdpbGwgbG9vayBpbnRvIHRoaXMgaXNzdWUsIGJ1dCBu
b3QgaW4gdGhpcwo+PiBlbWFpbCB0aHJlYWQgY29udGV4dC4KPiAKPiBJIGFtIG5vdCBzdXJlIHdo
YXQgc3RlcCBpcyBhdHRhY2hpbmcgZG9tYWluIHRvIGRldmljZSwgYnV0IHRoZXNlIHR5cGUgCj4g
bWVzc2FnZXM6Cj4gCj4gPDM+IFsyMDkuNTI2NjA1XSBETUFSOiBpbnRlbF9pb21tdV9tYXA6IGlv
bW11IHdpZHRoICgzOSkgaXMgbm90Cj4gID4+IHN1ZmZpY2llbnQgZm9yIHRoZSBtYXBwZWQgYWRk
cmVzcyAoZmZmZjAwODAwMCkKPiAKPiBUaGV5IGRlZmluaXRlbHkgYXBwZWFyIHRvIGhhcHBlbiBh
dCBydW50aW1lLCBhcyBpOTE1IGlzIGdldHRpbmcgCj4gZXhlcmNpc2VkIGJ5IHVzZXJzcGFjZS4K
CkFGQUlDUyB0aGlzIGNlcnRhaW5seSBtaWdodCBiZSByZWxhdGVkIHRvIHRoaXMgc2VyaWVzIC0g
aW9tbXUtZG1hIHdpbGwgCmNvbnN0cmFpbiBJT1ZBIGFsbG9jYXRpb24gYmFzZWQgb24gdGhlIGRv
bWFpbiBnZW9tZXRyeSB0aGF0IHRoZSBkcml2ZXIgCnJlcG9ydHMsIHdoaWNoIGluIHRoaXMgY2Fz
ZSBpcyBzZXQgb25seSBvbmNlIHdoZW4gZmlyc3QgYWxsb2NhdGluZyB0aGUgCmRvbWFpbi4gVGh1
cyBpdCBsb29rcyBsaWtlIGJvdGggdGhlIGRtYXJfZG9tYWluLT5nYXcgYWRqdXN0bWVudCBpbiAK
cHJlcGFyZV9kb21haW5fYXR0YWNoX2RldmljZSgpIGFuZCB0aGUgZG9tYWluX3VzZV9maXJzdF9s
ZXZlbCgpIGJ1c2luZXNzIAppbiBpbnRlbF9hbGxvY19pb3ZhKCkgZWZmZWN0aXZlbHkgZ2V0IGxv
c3QgaW4gdGhpcyBjb252ZXJzaW9uLCBzaW5jZSB0aGUgCmRvbWFpbiBnZW9tZXRyeSBuZXZlciBn
ZXRzIHVwZGF0ZWQgdG8gcmVmbGVjdCB0aG9zZSBhZGRpdGlvbmFsIGNvbnN0cmFpbnRzLgoKUm9i
aW4uCgo+IAo+IFJlZ2FyZHMsCj4gCj4gVHZydGtvCj4gX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KPiBpb21tdSBtYWlsaW5nIGxpc3QKPiBpb21tdUBsaXN0
cy5saW51eC1mb3VuZGF0aW9uLm9yZwo+IGh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3Vu
ZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0
aW5mby9pb21tdQ==
