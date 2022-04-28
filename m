Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3589C433EF
	for <iommu@archiver.kernel.org>; Thu, 28 Apr 2022 16:59:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 612BB419EB;
	Thu, 28 Apr 2022 16:59:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8fGJdg6HjhM3; Thu, 28 Apr 2022 16:59:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id E3E1F419D2;
	Thu, 28 Apr 2022 16:59:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B1D8CC0032;
	Thu, 28 Apr 2022 16:59:25 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3FA7DC002D
 for <iommu@lists.linux-foundation.org>; Thu, 28 Apr 2022 16:59:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2E1606101C
 for <iommu@lists.linux-foundation.org>; Thu, 28 Apr 2022 16:59:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ynm6i5RMQmhs for <iommu@lists.linux-foundation.org>;
 Thu, 28 Apr 2022 16:59:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp3.osuosl.org (Postfix) with ESMTP id 32C9C6100B
 for <iommu@lists.linux-foundation.org>; Thu, 28 Apr 2022 16:59:23 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7CE991474;
 Thu, 28 Apr 2022 09:59:21 -0700 (PDT)
Received: from [10.57.80.98] (unknown [10.57.80.98])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2BA103F774;
 Thu, 28 Apr 2022 09:59:18 -0700 (PDT)
Message-ID: <3686314d-4226-b360-a72d-267af52c8918@arm.com>
Date: Thu, 28 Apr 2022 17:59:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [RFC PATCH 1/2] swiotlb: Split up single swiotlb lock
Content-Language: en-GB
To: Andi Kleen <ak@linux.intel.com>, Christoph Hellwig <hch@infradead.org>
References: <20220428141429.1637028-1-ltykernel@gmail.com>
 <20220428141429.1637028-2-ltykernel@gmail.com>
 <e7b644f0-6c90-fe99-792d-75c38505dc54@arm.com>
 <YmqonHKBT8ftYHgY@infradead.org>
 <1517d2f0-08d6-a532-7810-2161b2dff421@linux.intel.com>
 <aa8e2fab-5b7e-cac3-0fbd-7c6edbbf942a@arm.com>
 <b3059196-a28b-a509-fc0e-75d2dbebdbae@linux.intel.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <b3059196-a28b-a509-fc0e-75d2dbebdbae@linux.intel.com>
Cc: parri.andrea@gmail.com, thomas.lendacky@amd.com, wei.liu@kernel.org,
 Tianyu Lan <Tianyu.Lan@microsoft.com>, konrad.wilk@oracle.com,
 linux-hyperv@vger.kernel.org, Tianyu Lan <ltykernel@gmail.com>,
 linux-kernel@vger.kernel.org, michael.h.kelley@microsoft.com,
 iommu@lists.linux-foundation.org, andi.kleen@intel.com, brijesh.singh@amd.com,
 vkuznets@redhat.com, kys@microsoft.com, kirill.shutemov@intel.com, hch@lst.de
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

T24gMjAyMi0wNC0yOCAxNzowMiwgQW5kaSBLbGVlbiB3cm90ZToKPiAKPiBPbiA0LzI4LzIwMjIg
ODowNyBBTSwgUm9iaW4gTXVycGh5IHdyb3RlOgo+PiBPbiAyMDIyLTA0LTI4IDE1OjU1LCBBbmRp
IEtsZWVuIHdyb3RlOgo+Pj4KPj4+IE9uIDQvMjgvMjAyMiA3OjQ1IEFNLCBDaHJpc3RvcGggSGVs
bHdpZyB3cm90ZToKPj4+PiBPbiBUaHUsIEFwciAyOCwgMjAyMiBhdCAwMzo0NDozNlBNICswMTAw
LCBSb2JpbiBNdXJwaHkgd3JvdGU6Cj4+Pj4+IFJhdGhlciB0aGFuIGludHJvZHVjZSB0aGlzIGV4
dHJhIGxldmVsIG9mIGFsbG9jYXRvciBjb21wbGV4aXR5LCBob3cgCj4+Pj4+IGFib3V0Cj4+Pj4+
IGp1c3QgZGl2aWRpbmcgdXAgdGhlIGluaXRpYWwgU1dJT1RMQiBhbGxvY2F0aW9uIGludG8gbXVs
dGlwbGUgCj4+Pj4+IGlvX3RsYl9tZW0KPj4+Pj4gaW5zdGFuY2VzPwo+Pj4+IFllYWguwqAgV2Un
cmUgYWxtb3N0IGRvbmUgcmVtb3ZpbmcgYWxsIGtub3dsZWRnZSBvZiBzd2lvdGxiIGZyb20gCj4+
Pj4gZHJpdmVycywKPj4+PiBzbyB0aGUgdmVyeSBsYXN0IHRoaW5nIEkgd2FudCBpcyBhbiBpbnRl
cmZhY2UgdGhhdCBhbGxvd3MgYSBkcml2ZXIgdG8KPj4+PiBhbGxvY2F0ZSBhIHBlci1kZXZpY2Ug
YnVmZmVyLgo+Pj4KPj4+IEF0IGxlYXN0IGZvciBURFggbmVlZCBwYXJhbGxlbGlzbSB3aXRoIGEg
c2luZ2xlIGRldmljZSBmb3IgcGVyZm9ybWFuY2UuCj4+Pgo+Pj4gU28gaWYgeW91IHNwbGl0IHVw
IHRoZSBpbyB0bGIgbWVtcyBmb3IgYSBkZXZpY2UgdGhlbiB5b3Ugd291bGQgbmVlZCBhIAo+Pj4g
bmV3IG1lY2hhbmlzbSB0byBsb2FkIGJhbGFuY2UgdGhlIHJlcXVlc3RzIGZvciBzaW5nbGUgZGV2
aWNlIG92ZXIgCj4+PiB0aG9zZS4gSSBkb3VidCBpdCB3b3VsZCBiZSBhbnkgc2ltcGxlci4KPj4K
Pj4gRWgsIEkgdGhpbmsgaXQgd291bGQgYmUsIHNpbmNlIHRoZSByb3VuZC1yb2JpbiByZXRyeSBs
b29wIGNhbiB0aGVuIAo+PiBqdXN0IHNpdCBhcm91bmQgdGhlIGV4aXN0aW5nIGlvX3RsYl9tZW0t
YmFzZWQgYWxsb2NhdG9yLCB2cy4gdGhlIGNodXJuIAo+PiBvZiBpbnNlcnRpbmcgaXQgaW4gdGhl
IG1pZGRsZSwgcGx1cyBpdCdzIHRoZW4gcmVhbGx5IGVhc3kgdG8gCj4+IHN0YXRpY2FsbHkgZGlz
dHJpYnV0ZSBkaWZmZXJlbnQgc3RhcnRpbmcgcG9pbnRzIGFjcm9zcyBkaWZmZXJlbnQgCj4+IGRl
dmljZXMgdmlhIGRldi0+ZG1hX2lvX3RsYl9tZW0gaWYgd2Ugd2FudGVkIHRvLgo+Pgo+PiBBZG1p
dHRlZGx5IHRoZSBvdmVyYWxsIHBhdGNoIHByb2JhYmx5IGVuZHMgdXAgYWJvdXQgdGhlIHNhbWUg
c2l6ZSwgCj4+IHNpbmNlIGl0IGxpa2VseSBwdXNoZXMgYSBiaXQgbW9yZSBjb21wbGV4aXR5IGlu
dG8gc3dpb3RsYl9pbml0IHRvIAo+PiBjb21wZW5zYXRlLCBidXQgdGhhdCdzIHN0aWxsIGEgdHJh
ZGUtb2ZmIEkgbGlrZS4KPiAKPiBVbmxlc3MgeW91IGNvbXBsZXRlbHkgYnJlYWsgdGhlIGV4dGVy
bmFsIEFQSSB0aGlzIHdpbGwgcmVxdWlyZSBhIG5ldyAKPiBtZWNoYW5pc20gdG8gc2VhcmNoIGEg
bGlzdCBvZiBpb190bGJfbWVtcyBmb3IgdGhlIHJpZ2h0IGFyZWEgdG8gZnJlZSBpbnRvLgo+IAo+
IElmIHRoZSBtZW1vcnkgYXJlYSBub3QgY29udGlndW91cyAobGlrZSBpbiB0aGUgb3JpZ2luYWwg
cGF0Y2gpIHRoaXMgd2lsbCAKPiBiZSBhIE8obikgb3BlcmF0aW9uIG9uIHRoZSBudW1iZXIgb2Yg
aW9fdGxiX21lbXMsIHNvIGl0IHdvdWxkIGdldCBtb3JlIAo+IGFuZCBtb3JlIGV4cGVuc2l2ZSBv
biBsYXJnZXIgc3lzdGVtcy4gT3IgeW91IG1lcmdlIHRoZW0gYWxsIHRvZ2V0aGVyIChzbyAKPiB0
aGF0IHRoZSBzaW1wbGUgYWRkcmVzcyBhcml0aG1ldGljIHRvIGxvb2sgdXAgdGhlIGFyZWEgd29y
a3MgYWdhaW4pLCAKPiB3aGljaCB3aWxsIHJlcXVpcmUgZXZlbiBtb3JlIGNoYW5nZXMgaW4gdGhl
IHNldHVwLiBPciB5b3UgYWRkIGhhc2hpbmcgb3IgCj4gc2ltaWxhciB3aGljaCB3aWxsIGJlIGV2
ZW4gbW9yZSBjb21wbGljYXRlZC4KPiAKPiBJbiB0aGUgZW5kIGRvaW5nIGl0IHdpdGggYSBzaW5n
bGUgaW9fdGxiX21lbSBpcyBzaWduaWZpY2FudGx5IHNpbXBsZXIgCj4gYW5kIGFsc28gbW9yZSBu
YXR1cmFsLgoKU29ycnkgaWYgImRpdmlkaW5nIHVwIHRoZSBpbml0aWFsIFNXSU9UTEIgYWxsb2Nh
dGlvbiIgc29tZWhvdyBzb3VuZGVkIApsaWtlICJtYWtpbmcgbXVsdGlwbGUgc2VwYXJhdGUgU1dJ
T1RMQiBhbGxvY2F0aW9ucyBhbGwgb3ZlciB0aGUgcGxhY2UiPwoKSSBkb24ndCBzZWUgdGhlcmUg
YmVpbmcgYW55ICpmdW5jdGlvbmFsKiBkaWZmZXJlbmNlIGluIHdoZXRoZXIgYSBzbGljZSAKb2Yg
dGhlIG92ZXJhbGwgU1dJT1RMQiBtZW1vcnkgaXMgcmVwcmVzZW50ZWQgYnkgCiJpb190bGJfZGVm
YXVsdF9tZW0tPmFyZWFzW2ldLT5ibGFoIiBvciAiaW9fdGxiX2RlZmF1bHRfbWVtW2ldLT5ibGFo
IiwgCkknbSBzaW1wbHkgYWR2b2NhdGluZyBmb3Igbm90IGNodXJuaW5nIHRoZSBhbHJlYWR5LWNv
bXBsZXggYWxsb2NhdG9yIAppbnRlcm5hbHMgYnkgcHVzaGluZyB0aGUgbmV3IGNvbXBsZXhpdHkg
b3V0IHRvIHRoZSBtYXJnaW5zIGluc3RlYWQuCgpUaGFua3MsClJvYmluLgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9t
bXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRp
b24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
