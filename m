Return-Path: <SRS0=4AON=WJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81C1FC32750
	for <iommu@archiver.kernel.org>; Tue, 13 Aug 2019 07:45:00 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E92020679
	for <iommu@archiver.kernel.org>; Tue, 13 Aug 2019 07:45:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E92020679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 01BF6BB3;
	Tue, 13 Aug 2019 07:45:00 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 04AD8B5F
	for <iommu@lists.linux-foundation.org>;
	Tue, 13 Aug 2019 07:44:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id F095067F
	for <iommu@lists.linux-foundation.org>;
	Tue, 13 Aug 2019 07:44:57 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
	by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	13 Aug 2019 00:39:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,380,1559545200"; d="scan'208";a="170318857"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136])
	([10.239.159.136])
	by orsmga008.jf.intel.com with ESMTP; 13 Aug 2019 00:39:46 -0700
Subject: Re: [PATCH 2/3] iommu/vt-d: Apply per-device dma_ops
To: Christoph Hellwig <hch@lst.de>
References: <20190801060156.8564-1-baolu.lu@linux.intel.com>
	<20190801060156.8564-3-baolu.lu@linux.intel.com>
	<20190806064347.GA14906@lst.de>
	<f532a2c3-f73a-85d2-d2ad-37cde02547ce@linux.intel.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <f0163adb-f9f9-5c7b-2bf8-2e0f182ffe49@linux.intel.com>
Date: Tue, 13 Aug 2019 15:38:48 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <f532a2c3-f73a-85d2-d2ad-37cde02547ce@linux.intel.com>
Content-Language: en-US
Cc: kevin.tian@intel.com, ashok.raj@intel.com,
	Robin Murphy <robin.murphy@arm.com>,
	linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
	jacob.jun.pan@intel.com, David Woodhouse <dwmw2@infradead.org>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

SGkgYWdhaW4sCgpPbiA4LzcvMTkgMTE6MDYgQU0sIEx1IEJhb2x1IHdyb3RlOgo+IEhpIENocmlz
dG9waCwKPiAKPiBPbiA4LzYvMTkgMjo0MyBQTSwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6Cj4+
IEhpIEx1LAo+Pgo+PiBJIHJlYWxseSBkbyBsaWtlIHRoZSBzd2l0Y2ggdG8gdGhlIHBlci1kZXZp
Y2UgZG1hX21hcF9vcHMsIGJ1dDoKPj4KPj4gT24gVGh1LCBBdWcgMDEsIDIwMTkgYXQgMDI6MDE6
NTVQTSArMDgwMCwgTHUgQmFvbHUgd3JvdGU6Cj4+PiBDdXJyZW50IEludGVsIElPTU1VIGRyaXZl
ciBzZXRzIHRoZSBzeXN0ZW0gbGV2ZWwgZG1hX29wcy4gVGhpcwo+Pj4gaW1wbGVtZW50YXRpb24g
aGFzIGF0IGxlYXN0IHRoZSBmb2xsb3dpbmcgZHJhd2JhY2tzOiAxKSBlYWNoCj4+PiBkbWEgQVBJ
IHdpbGwgZ28gdGhyb3VnaCB0aGUgSU9NTVUgZHJpdmVyIGV2ZW4gdGhlIGRldmljZXMgYXJlCj4+
PiB1c2luZyBpZGVudGl0eSBtYXBwZWQgZG9tYWluczsgMikgaWYgdXNlciByZXF1ZXN0cyB0byB1
c2UgYW4KPj4+IGlkZW50aXR5IG1hcHBlZCBkb21haW4gKGEuay5hLiBieXBhc3MgaW9tbXUgdHJh
bnNsYXRpb24pLCB0aGUKPj4+IGRyaXZlciBtaWdodCBmYWxsIGJhY2sgdG8gZG1hIGRvbWFpbiBi
bGluZGx5IGlmIHRoZSBkZXZpY2UgaXMKPj4+IG5vdCBhYmxlIHRvIGFkZHJlc3MgYWxsIHN5c3Rl
bSBtZW1vcnkuCj4+Cj4+IFRoaXMgaXMgdmVyeSBjbGVhcmx5IGEgYmVoYXZpb3JhbCByZWdyZXNz
aW9uLsKgIFRoZSBpbnRlbC1pb21tdSBkcml2ZXIKPj4gaGFzIGFsd2F5cyB1c2VkIHRoZSBpb21t
dSBtYXBwaW5nIHRvIHByb3ZpZGUgZGVjZW50IHN1cHBvcnQgZm9yCj4+IGRldmljZXMgdGhhdCBk
byBub3QgaGF2ZSB0aGUgZnVsbCA2NC1iaXQgYWRkcmVzc2luZyBjYXBhYmlsaXR5LCBhbmQKPj4g
Y2hhbmdpbmcgdGhpcyB3aWxsIG1ha2UgYSBsb3Qgb2YgZXhpc3Rpbmcgc2V0dXBzIGdvIHNsb3dl
ci4KPj4KPiAKPiBJIGFncmVlIHdpdGggeW91IHRoYXQgd2Ugc2hvdWxkIGtlZXAgdGhlIGNhcGFi
aWxpdHkgYW5kIGF2b2lkIHBvc3NpYmxlCj4gcGVyZm9ybWFuY2UgcmVncmVzc2lvbiBvbiBzb21l
IHNldHVwcy4gQnV0LCBpbnN0ZWFkIG9mIGhhcmQtY29kaW5nIHRoaXMKPiBpbiB0aGUgaW9tbXUg
ZHJpdmVyLCBJIHByZWZlciBhIG1vcmUgc2NhbGFibGUgd2F5Lgo+IAo+IEZvciBleGFtcGxlLCB0
aGUgY29uY2VwdCBvZiBwZXIgZ3JvdXAgZGVmYXVsdCBkb21haW4gdHlwZSBbMV0gc2VlbXMgdG8K
PiBiZSBhIGdvb2QgY2hvaWNlLiBUaGUga2VybmVsIGNvdWxkIGJlIHN0YXRpY2FsbHkgY29tcGls
ZWQgYXMgYnktZGVmYXVsdAo+ICJwYXNzIHRocm91Z2giIG9yICJ0cmFuc2xhdGUgZXZlcnl0aGlu
ZyIuIFRoZSBwZXIgZ3JvdXAgZGVmYXVsdCBkb21haW4KPiB0eXBlIEFQSSBjb3VsZCB0aGVuIGJl
IHVzZWQgYnkgdGhlIHByaXZpbGVnZWQgdXNlciB0byB0d2VhayBzb21lIG9mIHRoZQo+IGdyb3Vw
cyBmb3IgYmV0dGVyIHBlcmZvcm1hbmNlLCBlaXRoZXIgYnkgMSkgYnlwYXNzaW5nIGlvbW11IHRy
YW5zbGF0aW9uCj4gZm9yIHRoZSB0cnVzdGVkIHN1cGVyLXNwZWVkIGRldmljZXMsIG9yIDIpIGFw
cGx5aW5nIGlvbW11IHRyYW5zbGF0aW9uIHRvCj4gYWNjZXNzIHRoZSBzeXN0ZW0gbWVtb3J5IHdo
aWNoIGlzIGJleW9uZCB0aGUgZGV2aWNlJ3MgYWRkcmVzcyBjYXBhYmlsaXR5Cj4gKHdpdGhvdXQg
dGhlIG5lY2Vzc2FyeSBvZiB1c2luZyBib3VuY2UgYnVmZmVyKS4KPiAKPiBbMV0gaHR0cHM6Ly93
d3cuc3Bpbmljcy5uZXQvbGlzdHMvaW9tbXUvbXNnMzcxMTMuaHRtbAo+IAoKVGhlIGNvZGUgdGhh
dCB0aGlzIHBhdGNoIGlzIHRyeWluZyB0byByZW1vdmUgYWxzbyBsb29rcyBidWdneS4gVGhlIGNo
ZWNrCmFuZCByZXBsYWNlIG9mIGRvbWFpbiBoYXBwZW5zIGluIGVhY2ggRE1BIEFQSSwgYnV0IHRo
ZXJlIGlzbid0IGFueSBsb2NrCnRvIHNlcmlhbGl6ZSB0aGVtLgoKQmVzdCByZWdhcmRzLApMdSBC
YW9sdQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9t
bXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8v
bGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
