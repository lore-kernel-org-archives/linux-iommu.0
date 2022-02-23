Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0324C433EF
	for <iommu@archiver.kernel.org>; Wed, 23 Feb 2022 13:04:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 516F5813B2;
	Wed, 23 Feb 2022 13:04:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MP6f4VkM6EAW; Wed, 23 Feb 2022 13:04:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 67F35812B5;
	Wed, 23 Feb 2022 13:04:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 37282C0021;
	Wed, 23 Feb 2022 13:04:12 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EE87BC0011
 for <iommu@lists.linux-foundation.org>; Wed, 23 Feb 2022 13:04:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C85DA40309
 for <iommu@lists.linux-foundation.org>; Wed, 23 Feb 2022 13:04:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id T8P7EAkBAhIy for <iommu@lists.linux-foundation.org>;
 Wed, 23 Feb 2022 13:04:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp4.osuosl.org (Postfix) with ESMTP id BAD7C402DC
 for <iommu@lists.linux-foundation.org>; Wed, 23 Feb 2022 13:04:09 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D5EEAED1;
 Wed, 23 Feb 2022 05:04:08 -0800 (PST)
Received: from [10.57.40.147] (unknown [10.57.40.147])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ACA053F70D;
 Wed, 23 Feb 2022 05:04:04 -0800 (PST)
Message-ID: <880a269d-d39d-bab3-8d19-b493e874ec99@arm.com>
Date: Wed, 23 Feb 2022 13:04:00 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v6 02/11] driver core: Add dma_cleanup callback in bus_type
Content-Language: en-GB
To: Lu Baolu <baolu.lu@linux.intel.com>, Jason Gunthorpe <jgg@nvidia.com>
References: <20220218005521.172832-1-baolu.lu@linux.intel.com>
 <20220218005521.172832-3-baolu.lu@linux.intel.com>
 <YhCdEmC2lYStmUSL@infradead.org>
 <1d8004d3-1887-4fc7-08d2-0e2ee6b5fdcb@arm.com>
 <20220221234837.GA10061@nvidia.com>
 <1acb8748-8d44-688d-2380-f39ec820776f@arm.com>
 <20220222151632.GB10061@nvidia.com>
 <3d4c3bf1-fed6-f640-dc20-36d667de7461@arm.com>
 <20220222235353.GF10061@nvidia.com>
 <171bec90-5ea6-b35b-f027-1b5e961f5ddf@linux.intel.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <171bec90-5ea6-b35b-f027-1b5e961f5ddf@linux.intel.com>
Cc: kvm@vger.kernel.org, rafael@kernel.org, David Airlie <airlied@linux.ie>,
 linux-pci@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>,
 Diana Craciun <diana.craciun@oss.nxp.com>, Dmitry Osipenko <digetx@gmail.com>,
 Will Deacon <will@kernel.org>, Ashok Raj <ashok.raj@intel.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, Christoph Hellwig <hch@infradead.org>,
 Stuart Yoder <stuyoder@gmail.com>, Kevin Tian <kevin.tian@intel.com>,
 Chaitanya Kulkarni <kch@nvidia.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Dan Williams <dan.j.williams@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Cornelia Huck <cohuck@redhat.com>, linux-kernel@vger.kernel.org,
 Li Yang <leoyang.li@nxp.com>, iommu@lists.linux-foundation.org,
 Jacob jun Pan <jacob.jun.pan@intel.com>, Daniel Vetter <daniel@ffwll.ch>
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

T24gMjAyMi0wMi0yMyAwNTowMSwgTHUgQmFvbHUgd3JvdGU6Cj4gT24gMi8yMy8yMiA3OjUzIEFN
LCBKYXNvbiBHdW50aG9ycGUgd3JvdGU6Cj4+PiBUbyBzcGVsbCBpdCBvdXQsIHRoZSBzY2hlbWUg
SSdtIHByb3Bvc2luZyBsb29rcyBsaWtlIHRoaXM6Cj4+IFdlbGwsIEkgYWxyZWFkeSBnb3QgdGhp
cywgaXQgaXMgd2hhdCBpcyBpbiBkcml2ZXJfb3JfRE1BX0FQSV90b2tlbigpCj4+IHRoYXQgbWF0
dGVycwo+Pgo+PiBJIHRoaW5rIHlvdSBhcmUgc3VnZ2VzdGluZyB0byBkbyBzb21ldGhpbmcgbGlr
ZToKPj4KPj4gwqDCoMKgIGlmICghUkVBRF9PTkNFKGRldi0+ZHJpdmVyKSB8fMKgID8/PykKPj4g
wqDCoMKgwqDCoMKgwqAgcmV0dXJuIE5VTEw7Cj4+IMKgwqDCoCByZXR1cm4gZ3JvdXA7wqAgLy8g
QSBETUFfQVBJICd0b2tlbicKPj4KPj4gV2hpY2ggaXMgbG9ja2xlc3NseSByZWFkaW5nIGRldi0+
ZHJpdmVyLCBhbmQgd2h5IHlvdSBhcmUgdGFsa2luZyBhYm91dAo+PiByYWNlcywgSSBndWVzcy4K
Pj4KPiAKPiBJIGFtIGFmcmFpZCB0aGF0IHdlIGFyZSBub3QgYWJsZSB0byBpbXBsZW1lbnQgYSBy
YWNlLWZyZWUKPiBkcml2ZXJfb3JfRE1BX0FQSV90b2tlbigpIGhlbHBlci4gVGhlIGxvY2sgcHJv
YmxlbSBiZXR3ZWVuIHRoZSBJT01NVQo+IGNvcmUgYW5kIGRyaXZlciBjb3JlIGFsd2F5cyBleGlz
dHMuCgpJdCdzIG5vdCByYWNlLWZyZWUuIE15IHBvaW50IGlzIHRoYXQgdGhlIHJhY2VzIGFyZW4n
dCBoYXJtZnVsIGJlY2F1c2UgCndoYXQgd2UgbWlnaHQgaW5mZXIgZnJvbSB0aGUgIndyb25nIiBp
bmZvcm1hdGlvbiBzdGlsbCBsZWFkcyB0byB0aGUgCnJpZ2h0IGFjdGlvbi4gZGV2LT5kcml2ZXIg
aXMgb2J2aW91c2x5IGFsd2F5cyB2YWxpZCBhbmQgY29uc3RhbnQgZm9yIAoqY2xhaW1pbmcqIG93
bmVyc2hpcCwgc2luY2UgdGhhdCBlaXRoZXIgaGFwcGVucyBmb3IgdGhlIERNQSBBUEkgaW4gdGhl
IAptaWRkbGUgb2YgcmVhbGx5X3Byb2JlKCkgYmluZGluZyBkcml2ZXIgdG8gZGV2LCBvciB3aGls
ZSBkcml2ZXIgaXMgCmFjdGl2ZWx5IHVzaW5nIGRldiBhbmQgY2FsbGluZyBpb21tdV9ncm91cF9j
bGFpbV9kbWFfb3duZXIoKS4gVGhlIHJhY2VzIApleGlzdCBkdXJpbmcgcmVtb3ZlLCBidXQgYm90
aCBwcm9iZSBhbmQgcmVtb3ZlIGFyZSBzZXJpYWxpc2VkIG9uIHRoZSAKZ3JvdXAgbXV0ZXggYWZ0
ZXIgcmVzcGVjdGl2ZWx5IHNldHRpbmcvY2xlYXJpbmcgZGV2LT5kcml2ZXIsIHRoZXJlIGFyZSAK
b25seSA0IHBvc3NpYmlsaXRpZXMgZm9yIHRoZSBzdGF0ZSBvZiBhbnkgb3RoZXIgZ3JvdXAgc2li
bGluZyAidG1wIiAKZHVyaW5nIHRoZSB0aW1lIHRoYXQgZGV2IGhvbGRzIHRoYXQgbXV0ZXggaW4g
aXRzIHJlbW92ZSBwYXRoOgoKMSAtIHRtcC0+ZHJpdmVyIGlzIG5vbi1OVUxMIGJlY2F1c2UgdG1w
IGlzIGFscmVhZHkgYm91bmQuCiAgIDEuYSAtIElmIHRtcC0+ZHJpdmVyLT5kcml2ZXJfbWFuYWdl
ZF9kbWEgPT0gMCwgdGhlIGdyb3VwIG11c3QgCmN1cnJlbnRseSBiZSBETUEtQVBJLW93bmVkIGFz
IGEgd2hvbGUuIFJlZ2FyZGxlc3Mgb2Ygd2hhdCBkcml2ZXIgZGV2IGhhcyAKdW5ib3VuZCBmcm9t
LCBpdHMgcmVtb3ZhbCBkb2VzIG5vdCByZWxlYXNlIHNvbWVvbmUgZWxzZSdzIERNQSBBUEkgCihj
by0pb3duZXJzaGlwLgogICAxLmIgLSBJZiB0bXAtPmRyaXZlci0+ZHJpdmVyX21hbmFnZWRfZG1h
ID09IDEgYW5kIHRtcC0+ZHJpdmVyID09IApncm91cC0+b3duZXIsIHRoZW4gZGV2IG11c3QgaGF2
ZSB1bmJvdW5kIGZyb20gdGhlIHNhbWUgZHJpdmVyLCBidXQgCmVpdGhlciB3YXkgdGhhdCBkcml2
ZXIgaGFzIG5vdCB5ZXQgcmVsZWFzZWQgb3duZXJzaGlwIHNvIGRldidzIHJlbW92YWwgCmRvZXMg
bm90IGNoYW5nZSBhbnl0aGluZy4KICAgMS5jIC0gSWYgdG1wLT5kcml2ZXItPmRyaXZlcl9tYW5h
Z2VkX2RtYSA9PSAxIGFuZCB0bXAtPmRyaXZlciAhPSAKZ3JvdXAtPm93bmVyLCBpdCBkb2Vzbid0
IG1hdHRlci4gRXZlbiBpZiB0bXAtPmRyaXZlciBpcyBjdXJyZW50bHkgCndhaXRpbmcgdG8gYXR0
ZW1wdCB0byBjbGFpbSBvd25lcnNoaXAgaXQgY2FuJ3QgZG8gc28gdW50aWwgd2UgcmVsZWFzZSAK
dGhlIG11dGV4LgoKMiAtIHRtcC0+ZHJpdmVyIGlzIG5vbi1OVUxMIGJlY2F1c2UgdG1wIGlzIGlu
IHRoZSBwcm9jZXNzIG9mIGJpbmRpbmcuCiAgIDIuYSAtIElmIHRtcC0+ZHJpdmVyLT5kcml2ZXJf
bWFuYWdlZF9kbWEgPT0gMCwgdG1wIGNhbiBiZSBhc3N1bWVkIHRvIApiZSB3YWl0aW5nIG9uIHRo
ZSBncm91cCBtdXRleCB0byBjbGFpbSBETUEgQVBJIG93bmVyc2hpcC4KICAgICAyLmEuaSAtIElm
IHRoZSBncm91cCBpcyBETUEgQVBJIG93bmVkLCB0aGlzIHJhY2UgaXMgc2ltcGx5IGEgCnNob3J0
LWN1dCB0byBjYXNlIDEuYSAtIGRldidzIG93bmVyc2hpcCBpcyBlZmZlY3RpdmVseSBoYW5kZWQg
b2ZmIApkaXJlY3RseSB0byB0bXAsIHJhdGhlciB0aGFuIHBvdGVudGlhbGx5IGJlaW5nIHJlbGVh
c2VkIGFuZCBpbW1lZGlhdGVseSAKcmVjbGFpbWVkLiBPbmNlIHRtcCBnZXRzIGl0cyB0dXJuLCBp
dCBmaW5kcyB0aGUgZ3JvdXAgYWxyZWFkeSAKRE1BLUFQSS1vd25lZCBhcyBpdCB3YW50ZWQgYW5k
IGFsbCBpcyB3ZWxsLiBUaGlzIG1heSBiZSAidW5mYWlyIiBpZiBhbiAKZXhwbGljaXQgY2xhaW0g
d2FzIGFsc28gd2FpdGluZywgYnV0IG5vdCBpbmNvcnJlY3QuCiAgICAgMi5hLmlpIC0gSWYgdGhl
IGdyb3VwIGlzIGRyaXZlci1vd25lZCwgaXQgZG9lc24ndCBtYXR0ZXIuIFJlbW92aW5nIApkZXYg
ZG9lcyBub3QgY2hhbmdlIHRoZSBjdXJyZW50IG93bmVyc2hpcCwgYW5kIHRtcCdzIHByb2JlIHdp
bGwgCmV2ZW50dWFsbHkgZ2V0IGl0cyB0dXJuIGFuZCBmaW5kIHdoYXRldmVyIGl0IGZpbmRzIGF0
IHRoYXQgcG9pbnQgaW4gZnV0dXJlLgogICAyLmIgLSBJZiB0bXAtPmRyaXZlci0+ZHJpdmVyX21h
bmFnZWRfZG1hID09IDEsIGl0IGRvZXNuJ3QgbWF0dGVyLiAKRWl0aGVyIHRoYXQgZHJpdmVyIGFs
cmVhZHkgb3ducyB0aGUgZ3JvdXAsIG9yIGl0IG1pZ2h0IHRyeSB0byBjbGFpbSBpdCAKYWZ0ZXIg
d2UndmUgcmVzb2x2ZWQgZGV2J3MgcmVtb3ZhbCBhbmQgcmVsZWFzZWQgdGhlIG11dGV4LCBpbiB3
aGljaCBjYXNlIAppdCB3aWxsIGZpbmQgd2hhdGV2ZXIgaXQgZmluZHMuCgozIC0gdG1wLT5kcml2
ZXIgaXMgTlVMTCBiZWNhdXNlIHRtcCBpcyB1bmJvdW5kLiBPYnZpb3VzbHkgbm8gaW1wYWN0LgoK
NCAtIHRtcC0+ZHJpdmVyIGlzIE5VTEwgYmVjYXVzZSB0bXAgaXMgaW4gdGhlIHByb2Nlc3Mgb2Yg
dW5iaW5kaW5nLgogICA0LmEgLSBJZiB0aGUgZ3JvdXAgaXMgRE1BLUFQSS1vd25lZCwgZWl0aGVy
IHdheSB0bXAgaGFzIG5vIGZ1cnRoZXIgCmluZmx1ZW5jZS4KICAgICA0LmEuaSAtIElmIHRtcCBo
YXMgdW5ib3VuZCBmcm9tIGEgZHJpdmVyX21hbmFnZWRfZG1hPTAgZHJpdmVyLCBpdCAKbXVzdCBi
ZSB3YWl0aW5nIHRvIHJlbGVhc2UgaXRzIERNQSBBUEkgb3duZXJzaGlwLCB0aHVzIGlmIHRtcCB3
b3VsZCAKb3RoZXJ3aXNlIGJlIHRoZSBvbmx5IHJlbWFpbmluZyBETUEgQVBJIG93bmVyLCB0aGUg
cmFjZSBpcyB0aGF0IGRldidzIApyZW1vdmFsIHJlbGVhc2VzIG93bmVyc2hpcCBvbiBiZWhhbGYg
b2YgYm90aCBkZXZpY2VzLiBXaGVuIHRtcCdzIG93biAKcmVtb3ZhbCBzdWJzZXF1ZW50bHkgZ2V0
cyB0aGUgbXV0ZXgsIGl0IHdpbGwgZWl0aGVyIHNlZSB0aGF0IHRoZSBncm91cCAKaXMgYWxyZWFk
eSB1bm93bmVkLCBvciBtYXliZSB0aGF0IHNvbWVvbmUgZWxzZSBoYXMgcmUtY2xhaW1lZCBpdCBp
biB0aGUgCmludGVyaW0sIGFuZCBlaXRoZXIgd2F5IGRvIG5vdGhpbmcsIHdoaWNoIGlzIGZpbmUu
CiAgICAgNC5hLmlpIC0gSWYgdG1wIGhhcyB1bmJvdW5kIGZyb20gYSBkcml2ZXJfbWFuYWdlZF9k
bWE9MSBkcml2ZXIsIGl0IApkb2Vzbid0IG1hdHRlciwgYXMgaW4gY2FzZSAxLmMuCiAgIDQuYiAt
IElmIHRoZSBncm91cCBpcyBkcml2ZXItb3duZWQsIGl0IGRvZXNuJ3QgbWF0dGVyLiBUaGF0IG93
bmVyc2hpcCAKY2FuIG9ubHkgY2hhbmdlIGlmIHRoYXQgZHJpdmVyIHJlbGVhc2VzIGl0LCB3aGlj
aCBpc24ndCBoYXBwZW5pbmcgd2hpbGUgCndlIGhvbGQgdGhlIG11dGV4LgoKQXMgSSBzYWlkIHll
c3RlcmRheSwgSSdtIHJlYWxseSBqdXN0IGFpcmluZyBvdXQgYW4gaWRlYSBoZXJlOyBJIG1pZ2h0
IAp3cml0ZSB1cCBzb21lIHByb3BlciBwYXRjaGVzIGFzIHBhcnQgb2YgdGhlIGJ1cyBvcHMgd29y
aywgYW5kIHdlIGNhbiAKZ2l2ZSBpdCBwcm9wZXIgc2NydXRpbnkgdGhlbi4KCj4gRm9yIGV4YW1w
bGUsIHdoZW4gd2UgaW1wbGVtZW50ZWQgaW9tbXVfZ3JvdXBfc3RvcmVfdHlwZSgpIHRvIGNoYW5n
ZSB0aGUKPiBkZWZhdWx0IGRvbWFpbiB0eXBlIG9mIGEgZGV2aWNlIHRocm91Z2ggc3lzZnMsIHdl
IGNvdWxkIG9ubHkgY29tcHJpc2VkCj4gYW5kIGxpbWl0ZWQgdGhpcyBmdW5jdGlvbmFsaXR5IHRv
IHNpbmdsZXRvbiBncm91cHMgdG8gYXZvaWQgdGhlIGxvY2sKPiBpc3N1ZS4KCkluZGVlZCwgYnV0
IG9uY2UgdGhlIHByb2JlIGFuZCByZW1vdmUgcGF0aHMgZm9yIGdyb3VwZWQgZGV2aWNlcyBoYXZl
IHRvIApzZXJpYWxpc2Ugb24gdGhlIGdyb3VwIG11dGV4LCBhcyB3ZSdyZSBpbnRyb2R1Y2luZyBo
ZXJlLCB0aGUgc3RvcnkgCmNoYW5nZXMgYW5kIHdlIGdhaW4gYSBsb3QgbW9yZSBwb3dlci4gSW4g
ZmFjdCB0aGF0J3MgYSBnb29kIHBvaW50IEkgCmhhZG4ndCBjb25zaWRlcmVkIHlldCAtIHRoYXQg
c3lzZnMgY29uc3RyYWludCBpcyBmdW5jdGlvbmFsbHkgZXF1aXZhbGVudCAKdG8gdGhlIG9uZSBp
biBpb21tdV9hdHRhY2hfZGV2aWNlKCksIHNvIG9uY2Ugd2UgbGFuZCB0aGlzIG93bmVyc2hpcCAK
Y29uY2VwdCB3ZSBzaG91bGQgYmUgZnJlZSB0byByZWxheCBpdCBmcm9tICJzaW5nbGV0b24iIHRv
ICJ1bm93bmVkIiBpbiAKbXVjaCB0aGUgc2FtZSB3YXkgYXMgeW91ciBvdGhlciBzZXJpZXMgaXMg
ZG9pbmcgZm9yIGF0dGFjaC4KCj4gVW5mb3J0dW5hdGVseSwgdGhhdCBjb21wcm9taXNlIGNhbm5v
dCBzaW1wbHkgYXBwbGllZCB0byB0aGUgcHJvYmxlbSB0bwo+IGJlIHNvbHZlZCBieSB0aGlzIHNl
cmllcywgYmVjYXVzZSB0aGUgaW9tbXUgY29yZSBjYW5ub3QgYWJvcnQgdGhlIGRyaXZlcgo+IGJp
bmRpbmcgd2hlbiB0aGUgY29uZmxpY3QgaXMgZGV0ZWN0ZWQgaW4gdGhlIGJ1cyBub3RpZmllci4K
Ck5vLCBJJ3ZlIG5ldmVyIHByb3Bvc2VkIHRoYXQgcHJvYmUtdGltZSBETUEgb3duZXJzaGlwIGNh
biBiZSBjbGFpbWVkIApmcm9tIGEgbm90aWZpZXIsIHdlIGFsbCBrbm93IHdoeSB0aGF0IGRvZXNu
J3Qgd29yay4gSXQncyBvbmx5IHRoZSAKZG1hX2NsZWFudXAoKSBzdGVwIHRoYXQgKmNvdWxkKiBi
ZSBwdW50ZWQgYmFjayB0byBpb21tdV9idXNfbm90aWZpZXIgdnMuIAp0aGUgZHJpdmVyIGNvcmUg
aGF2aW5nIHRvIGtub3cgYWJvdXQgaXQuIEVpdGhlciB3YXkgd2UncmUgc3RpbGwgCnNlcmlhbGlz
aW5nIHJlbW92ZS9mYWlsdXJlIGFnYWluc3QgcHJvYmUvcmVtb3ZlIG9mIG90aGVyIGRldmljZXMg
aW4gYSAKZ3JvdXAsIGFuZCB0aGF0J3MgdGhlIGNyaXRpY2FsIGFzcGVjdC4KClRoYW5rcywKUm9i
aW4uCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11
IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xp
c3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
