Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7D21C433EF
	for <iommu@archiver.kernel.org>; Tue, 17 May 2022 12:43:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8DF6260B12;
	Tue, 17 May 2022 12:43:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qSPImdmPZUCl; Tue, 17 May 2022 12:43:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 5F44E60D62;
	Tue, 17 May 2022 12:43:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 327E4C0039;
	Tue, 17 May 2022 12:43:15 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7B4ADC002D
 for <iommu@lists.linux-foundation.org>; Tue, 17 May 2022 12:43:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 63901419A2
 for <iommu@lists.linux-foundation.org>; Tue, 17 May 2022 12:43:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wdmZpTpSIPmw for <iommu@lists.linux-foundation.org>;
 Tue, 17 May 2022 12:43:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp4.osuosl.org (Postfix) with ESMTP id 223B24199F
 for <iommu@lists.linux-foundation.org>; Tue, 17 May 2022 12:43:11 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0726B1042;
 Tue, 17 May 2022 05:43:11 -0700 (PDT)
Received: from [10.57.82.55] (unknown [10.57.82.55])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 05AA13F66F;
 Tue, 17 May 2022 05:43:08 -0700 (PDT)
Message-ID: <f971aea9-8ae1-95f8-b10a-cd77e9704dc0@arm.com>
Date: Tue, 17 May 2022 13:43:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 2/5] iommu: Add blocking_domain_ops field in iommu_ops
Content-Language: en-GB
To: Baolu Lu <baolu.lu@linux.intel.com>, Jason Gunthorpe <jgg@nvidia.com>
References: <20220516015759.2952771-1-baolu.lu@linux.intel.com>
 <20220516015759.2952771-3-baolu.lu@linux.intel.com>
 <8a0fc6cf-f46e-f17e-2b76-099ada1683c3@arm.com>
 <20220516135741.GV1343366@nvidia.com>
 <c8492b29-bc27-ae12-d5c4-9fbbc797e310@linux.intel.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <c8492b29-bc27-ae12-d5c4-9fbbc797e310@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
 Christoph Hellwig <hch@infradead.org>, iommu@lists.linux-foundation.org,
 Jacob jun Pan <jacob.jun.pan@intel.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>
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

T24gMjAyMi0wNS0xNyAwMzozNywgQmFvbHUgTHUgd3JvdGU6Cj4gSGkgSmFzb24sCj4gCj4gT24g
MjAyMi81LzE2IDIxOjU3LCBKYXNvbiBHdW50aG9ycGUgd3JvdGU6Cj4+IE9uIE1vbiwgTWF5IDE2
LCAyMDIyIGF0IDEyOjIyOjA4UE0gKzAxMDAsIFJvYmluIE11cnBoeSB3cm90ZToKPj4+IE9uIDIw
MjItMDUtMTYgMDI6NTcsIEx1IEJhb2x1IHdyb3RlOgo+Pj4+IEVhY2ggSU9NTVUgZHJpdmVyIG11
c3QgcHJvdmlkZSBhIGJsb2NraW5nIGRvbWFpbiBvcHMuIElmIHRoZSBoYXJkd2FyZQo+Pj4+IHN1
cHBvcnRzIGRldGFjaGluZyBkb21haW4gZnJvbSBkZXZpY2UsIHNldHRpbmcgYmxvY2tpbmcgZG9t
YWluIGVxdWFscwo+Pj4+IGRldGFjaGluZyB0aGUgZXhpc3RpbmcgZG9tYWluIGZyb20gdGhlIGRl
aXZjZS4gT3RoZXJ3aXNlLCBhbiBVTk1BTkFHRUQKPj4+PiBkb21haW4gd2l0aG91dCBhbnkgbWFw
cGluZyB3aWxsIGJlIHVzZWQgaW5zdGVhZC4KPj4+IFVuZm9ydHVuYXRlbHkgdGhhdCdzIGJhY2t3
YXJkcyAtIG1vc3Qgb2YgdGhlIGltcGxlbWVudGF0aW9ucyBvZiAKPj4+IC5kZXRhY2hfZGV2Cj4+
PiBhcmUgZGlzYWJsaW5nIHRyYW5zbGF0aW9uIGVudGlyZWx5LCBtZWFuaW5nIHRoZSBkZXZpY2Ug
ZW5kcyB1cCAKPj4+IGVmZmVjdGl2ZWx5Cj4+PiBpbiBwYXNzdGhyb3VnaCByYXRoZXIgdGhhbiBi
bG9ja2VkLgo+PiBJZGVhbGx5IHdlJ2QgY29udmVydCB0aGUgZGV0YWNoX2RldiBvZiBldmVyeSBk
cml2ZXIgaW50byBlaXRoZXIKPj4gYSBibG9ja2luZyBvciBpZGVudGl0eSBkb21haW4uIFRoZSB0
cmljayBpcyBrbm93aW5nIHdoaWNoIGlzIHdoaWNoLi4KPiAKPiBJIGFtIHN0aWxsIGEgYml0IHB1
enpsZWQgYWJvdXQgaG93IHRoZSBibG9ja2luZ19kb21haW4gc2hvdWxkIGJlIHVzZWQgCj4gd2hl
biBpdCBpcyBleHRlbmRlZCB0byBzdXBwb3J0IC0+c2V0X2Rldl9wYXNpZC4KPiAKPiBJZiBpdCdz
IGEgYmxvY2tpbmcgZG9tYWluLCB0aGUgSU9NTVUgZHJpdmVyIGtub3dzIHRoYXQgc2V0dGluZyB0
aGUKPiBibG9ja2luZyBkb21haW4gdG8gZGV2aWNlIHBhc2lkIG1lYW5zIGRldGFjaGluZyB0aGUg
ZXhpc3Rpbmcgb25lLgo+IAo+IEJ1dCBpZiBpdCdzIGFuIGlkZW50aXR5IGRvbWFpbiwgaG93IGNv
dWxkIHRoZSBJT01NVSBkcml2ZXIgY2hvb3NlCj4gYmV0d2VlbjoKPiAKPiAgwqAtIHNldHRpbmcg
dGhlIGlucHV0IGRvbWFpbiB0byB0aGUgcGFzaWQgb24gZGV2aWNlOyBvciwKPiAgwqAtIGRldGFj
aGluZyB0aGUgZXhpc3RpbmcgZG9tYWluLgo+IAo+IEkndmUgZXZlciB0aG91Z2h0IGFib3V0IGJl
bG93IHNvbHV0aW9uczoKPiAKPiAtIENoZWNraW5nIHRoZSBkb21haW4gdHlwZXMgYW5kIGRpc3Bh
dGNoaW5nIHRoZW0gdG8gZGlmZmVyZW50Cj4gIMKgIG9wZXJhdGlvbnMuCj4gLSBVc2luZyBkaWZm
ZXJlbnQgYmxvY2tpbmcgZG9tYWlucyBmb3IgZGlmZmVyZW50IHR5cGVzIG9mIGRvbWFpbnMuCj4g
Cj4gQnV0IGJvdGggbG9vayByb3VnaC4KPiAKPj4KPj4gR3Vlc3NpbmcgZ29pbmcgZG93biB0aGUg
bGlzdDoKPj4gwqAgYXBwbGUgZGFydCAtIGJsb2NraW5nLCBkZXRhY2hfZGV2IGNhbGxzIGFwcGxl
X2RhcnRfaHdfZGlzYWJsZV9kbWEoKSAKPj4gc2FtZSBhcwo+PiDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIElPTU1VX0RPTUFJTl9CTE9DS0VECj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBbSSB3
b25kZXIgaWYgdGhpcyBkcml2ZSByaXMgd3JvbmcgaW4gb3RoZXIgd2F5cyB0aG91Z2ggYmVjYXVz
ZQo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgSSBkb250IHNlZSBhIHJlbW92ZV9z
dHJlYW1zIGluIGF0dGFjaF9kZXZdCj4+IMKgIGV4eW5vcyAtIHRoaXMgc2VlbXMgdG8gZGlzYWJs
ZSB0aGUgJ3N5c21tdScgc28gSSdtIGd1ZXNzaW5nIHRoaXMgaXMKPj4gwqDCoMKgwqDCoMKgwqDC
oMKgwqAgaWRlbnRpdHkKPj4gwqAgaW9tbXUtdm1zYSAtIENvbW1lbnQgc2F5cyAnZGlzYWJsZSBt
bXUgdHJhbnNsYWN0aW9uJyBzbyBJJ20gZ3Vlc3NpbmcKPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCB0aGlzIGlzIGlkZW5pdHkKPj4gwqAgbWt0X3YxIC0gQ29kZSBsb29rcyBzaW1pbGFy
IHRvIG1rdCwgd2hpY2ggaXMgcHJvYmFibHkgaWRlbnRpdHkuCj4+IMKgIHJrdCAtIE5vIGlkZWEK
Pj4gwqAgc3ByZCAtIE5vIGlkZWEKPj4gwqAgc3VuNTBpIC0gVGhpcyBkcml2ZXIgY29uZnVzaW5n
bHkgdHJlYXRzIGlkZW50aXR5IHRoZSBzYW1lIGFzCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgIHVu
bWFuYWdlZCwgc2VlbXMgd3JvbmcsIG5vIGlkZWEuCj4+IMKgIGFtZCAtIE5vdCBzdXJlLCBjbGVh
cl9kdGVfZW50cnkoKSBzZWVtcyB0byBzZXQgdHJhbnNsYXRpb24gb24gYnV0IAo+PiBwb2ludHMK
Pj4gwqDCoMKgwqDCoMKgwqAgdGhlIFBURSB0byAwID8gQmFzZWQgb24gdGhlIHNwZWMgdGFibGUg
OCBJIHdvdWxkIGhhdmUgZXhwZWN0ZWQKPj4gwqDCoMKgwqDCoMKgwqAgVFYgdG8gYmUgY2xlYXIg
d2hpY2ggd291bGQgYmUgYmxvY2tpbmcuIE1heWJlIGEgYnVnPz8KPj4gwqAgYXJtIHNtbXUgcWNv
bW0gLSBub3Qgc3VyZQo+PiDCoCBpbnRlbCAtIGJsb2NraW5nCj4+Cj4+IFRoZXNlIGRvZXNuJ3Qg
c3VwcG9ydCBkZWZhdWx0IGRvbWFpbnMsIHNvIGRldGFjaF9kZXYgc2hvdWxkIHJldHVybgo+PiBi
YWNrIHRvIERNQSBBUEkgb3duZXJzaGlwLCB3aGljaCBpcyBlaXRoZXIgaWRlbnRpdHkgb3Igc29t
ZXRoaW5nIHdlaXJkOgo+PiDCoCBmc2xfcGFtdSAtIGlkZW50aXR5IGR1ZSB0byB0aGUgUFBDIHVz
ZSBvZiBkbWEgZGlyZWN0Cj4+IMKgIG1zbQo+PiDCoCBta3QKPj4gwqAgb21hcAo+PiDCoCBzMzkw
IC0gcGxhdGZvcm0gRE1BIG9wcwo+PiDCoCB0ZXJnYS1nYXJ0IC0gVXN1YWxseSBzb21ldGhpbmcg
Y2FsbGVkIGEgR0FSVCB3b3VsZCBiZSAwIGxlbmd0aCBvbmNlCj4+IMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgZGlzYWJsZWQsIGd1ZXNzaW5nIGJsb2NraW5nPwo+PiDCoCB0ZWdyYS1zbW11
Cj4+Cj4+IFNvLCB0aGUgYXBwcm9hY2ggaGVyZSBzaG91bGQgYmUgdG8gZ28gZHJpdmVyIGJ5IGRy
aXZlciBhbmQgY29udmVydAo+PiBkZXRhY2hfZGV2IHRvIGVpdGhlciBpZGVudGl0eSwgYmxvY2tp
bmcgb3IganVzdCBkZWxldGUgaXQgZW50aXJlbHksCj4+IGV4Y2x1ZGluZyB0aGUgYWJvdmUgNyB0
aGF0IGRvbid0IHN1cHBvcnQgZGVmYXVsdCBkb21haW5zLiBBbmQgZ2V0IGFja3MKPj4gZnJvbSB0
aGUgZHJpdmVyIG93bmVycy4KPj4KPiAKPiBBZ3JlZWQuIFRoZXJlIHNlZW1zIHRvIGJlIGEgbG9u
ZyB3YXkgdG8gZ28uIEkgYW0gd29uZGVyaW5nIGlmIHdlIGNvdWxkCj4gZGVjb3VwbGUgdGhpcyBy
ZWZhY3RvcmluZyBmcm9tIG15IG5ldyBTVkEgQVBJIHdvcms/IFdlIGNhbiBlYXNpbHkgc3dpdGNo
Cj4gLmRldGFjaF9kZXZfcGFzaWQgdG8gdXNpbmcgYmxvY2tpbmcgZG9tYWluIGxhdGVyLgoKRldJ
VyBmcm9tIG15IHBvaW50IG9mIHZpZXcgSSdtIGhhcHB5IHdpdGggaGF2aW5nIGEgLmRldGFjaF9k
ZXZfcGFzaWQgb3AgCm1lYW5pbmcgaW1wbGljaXRseS1ibG9ja2VkIGFjY2VzcyBmb3Igbm93LiBP
biBTTU1VdjMsIFBBU0lEcyBkb24ndCBtaXggCndpdGggb3VyIGN1cnJlbnQgbm90aW9uIG9mIElP
TU1VX0RPTUFJTl9JREVOVElUWSAobm9yIHRoZSBwb3RlbnRpYWwgb25lIApmb3IgSU9NTVVfRE9N
QUlOX0JMT0NLRUQpLCBzbyBnaXZpbmcgUEFTSURzIGZ1bmN0aW9uYWwgc3ltbWV0cnkgd2l0aCAK
ZGV2aWNlcyB3b3VsZCBuZWVkIHNpZ25pZmljYW50bHkgbW9yZSB3b3JrIGFueXdheS4KClRoYW5r
cywKUm9iaW4uCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRw
czovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
