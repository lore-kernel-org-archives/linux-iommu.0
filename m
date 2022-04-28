Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38D8CC4332F
	for <iommu@archiver.kernel.org>; Thu, 28 Apr 2022 15:08:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C223040494;
	Thu, 28 Apr 2022 15:08:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GWP-o7T_dgjk; Thu, 28 Apr 2022 15:08:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 87853401C9;
	Thu, 28 Apr 2022 15:08:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 57D6EC0039;
	Thu, 28 Apr 2022 15:08:01 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 994B4C002D
 for <iommu@lists.linux-foundation.org>; Thu, 28 Apr 2022 15:08:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 864AE4174E
 for <iommu@lists.linux-foundation.org>; Thu, 28 Apr 2022 15:08:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zDf_Vst5jTyl for <iommu@lists.linux-foundation.org>;
 Thu, 28 Apr 2022 15:07:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp4.osuosl.org (Postfix) with ESMTP id A09CE41725
 for <iommu@lists.linux-foundation.org>; Thu, 28 Apr 2022 15:07:59 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3375A1474;
 Thu, 28 Apr 2022 08:07:58 -0700 (PDT)
Received: from [10.57.80.98] (unknown [10.57.80.98])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9725C3F774;
 Thu, 28 Apr 2022 08:07:54 -0700 (PDT)
Message-ID: <aa8e2fab-5b7e-cac3-0fbd-7c6edbbf942a@arm.com>
Date: Thu, 28 Apr 2022 16:07:49 +0100
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
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <1517d2f0-08d6-a532-7810-2161b2dff421@linux.intel.com>
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

T24gMjAyMi0wNC0yOCAxNTo1NSwgQW5kaSBLbGVlbiB3cm90ZToKPiAKPiBPbiA0LzI4LzIwMjIg
Nzo0NSBBTSwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6Cj4+IE9uIFRodSwgQXByIDI4LCAyMDIy
IGF0IDAzOjQ0OjM2UE0gKzAxMDAsIFJvYmluIE11cnBoeSB3cm90ZToKPj4+IFJhdGhlciB0aGFu
IGludHJvZHVjZSB0aGlzIGV4dHJhIGxldmVsIG9mIGFsbG9jYXRvciBjb21wbGV4aXR5LCBob3cg
Cj4+PiBhYm91dAo+Pj4ganVzdCBkaXZpZGluZyB1cCB0aGUgaW5pdGlhbCBTV0lPVExCIGFsbG9j
YXRpb24gaW50byBtdWx0aXBsZSBpb190bGJfbWVtCj4+PiBpbnN0YW5jZXM/Cj4+IFllYWguwqAg
V2UncmUgYWxtb3N0IGRvbmUgcmVtb3ZpbmcgYWxsIGtub3dsZWRnZSBvZiBzd2lvdGxiIGZyb20g
ZHJpdmVycywKPj4gc28gdGhlIHZlcnkgbGFzdCB0aGluZyBJIHdhbnQgaXMgYW4gaW50ZXJmYWNl
IHRoYXQgYWxsb3dzIGEgZHJpdmVyIHRvCj4+IGFsbG9jYXRlIGEgcGVyLWRldmljZSBidWZmZXIu
Cj4gCj4gQXQgbGVhc3QgZm9yIFREWCBuZWVkIHBhcmFsbGVsaXNtIHdpdGggYSBzaW5nbGUgZGV2
aWNlIGZvciBwZXJmb3JtYW5jZS4KPiAKPiBTbyBpZiB5b3Ugc3BsaXQgdXAgdGhlIGlvIHRsYiBt
ZW1zIGZvciBhIGRldmljZSB0aGVuIHlvdSB3b3VsZCBuZWVkIGEgCj4gbmV3IG1lY2hhbmlzbSB0
byBsb2FkIGJhbGFuY2UgdGhlIHJlcXVlc3RzIGZvciBzaW5nbGUgZGV2aWNlIG92ZXIgdGhvc2Uu
IAo+IEkgZG91YnQgaXQgd291bGQgYmUgYW55IHNpbXBsZXIuCgpFaCwgSSB0aGluayBpdCB3b3Vs
ZCBiZSwgc2luY2UgdGhlIHJvdW5kLXJvYmluIHJldHJ5IGxvb3AgY2FuIHRoZW4ganVzdCAKc2l0
IGFyb3VuZCB0aGUgZXhpc3RpbmcgaW9fdGxiX21lbS1iYXNlZCBhbGxvY2F0b3IsIHZzLiB0aGUg
Y2h1cm4gb2YgCmluc2VydGluZyBpdCBpbiB0aGUgbWlkZGxlLCBwbHVzIGl0J3MgdGhlbiByZWFs
bHkgZWFzeSB0byBzdGF0aWNhbGx5IApkaXN0cmlidXRlIGRpZmZlcmVudCBzdGFydGluZyBwb2lu
dHMgYWNyb3NzIGRpZmZlcmVudCBkZXZpY2VzIHZpYSAKZGV2LT5kbWFfaW9fdGxiX21lbSBpZiB3
ZSB3YW50ZWQgdG8uCgpBZG1pdHRlZGx5IHRoZSBvdmVyYWxsIHBhdGNoIHByb2JhYmx5IGVuZHMg
dXAgYWJvdXQgdGhlIHNhbWUgc2l6ZSwgc2luY2UgCml0IGxpa2VseSBwdXNoZXMgYSBiaXQgbW9y
ZSBjb21wbGV4aXR5IGludG8gc3dpb3RsYl9pbml0IHRvIGNvbXBlbnNhdGUsIApidXQgdGhhdCdz
IHN0aWxsIGEgdHJhZGUtb2ZmIEkgbGlrZS4KClRoYW5rcywKUm9iaW4uCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21t
dUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlv
bi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
