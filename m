Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5B79C433EF
	for <iommu@archiver.kernel.org>; Thu, 28 Apr 2022 16:02:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6672F408B2;
	Thu, 28 Apr 2022 16:02:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iEA7OBVRmAei; Thu, 28 Apr 2022 16:02:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id DE7DC40890;
	Thu, 28 Apr 2022 16:02:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B322DC0039;
	Thu, 28 Apr 2022 16:02:30 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 50191C002D
 for <iommu@lists.linux-foundation.org>; Thu, 28 Apr 2022 16:02:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3E21A60AFF
 for <iommu@lists.linux-foundation.org>; Thu, 28 Apr 2022 16:02:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bqMam02LCita for <iommu@lists.linux-foundation.org>;
 Thu, 28 Apr 2022 16:02:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8DB376059B
 for <iommu@lists.linux-foundation.org>; Thu, 28 Apr 2022 16:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1651161747; x=1682697747;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=dtS2kF8FdLLSnqYyxKV7E3Bfk2VxTI+riuYpWaXfRcs=;
 b=a3E+hgDcibmP4UPg1XzdeNlXwGK3/+tFZYJaPSz+8TduEg+DOC3k/E+Z
 Xfj+2Rc4RLlWonOfJgGbhN6HTl90Oiml3VkZnELgsWzYfxAG3FMBjqobA
 iLd+5vKPQs8ezxySdtaOFxHElKU9geFnpJfsDfqHbQN4WOictwLroXHGi
 Tr+c5BU20QqtegLPNVnJ7/sC/CgCHb3aZimSrGgpYFGtz2wMsv0GdleQ0
 tKorFA3M5bz36lcuEsiko4JHOs6zLD6wJIU2O9iU1PzId3GvhbVW+PoHg
 TrYco9SZbtmwvqwN31qivARG2soeF2uzy0g/r2hVi/VEqnc6ZCY6eaWUK g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10331"; a="265862736"
X-IronPort-AV: E=Sophos;i="5.91,295,1647327600"; d="scan'208";a="265862736"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Apr 2022 09:02:26 -0700
X-IronPort-AV: E=Sophos;i="5.91,295,1647327600"; d="scan'208";a="651277756"
Received: from akleen-mobl1.amr.corp.intel.com (HELO [10.209.19.92])
 ([10.209.19.92])
 by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Apr 2022 09:02:25 -0700
Message-ID: <b3059196-a28b-a509-fc0e-75d2dbebdbae@linux.intel.com>
Date: Thu, 28 Apr 2022 09:02:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [RFC PATCH 1/2] swiotlb: Split up single swiotlb lock
Content-Language: en-US
To: Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@infradead.org>
References: <20220428141429.1637028-1-ltykernel@gmail.com>
 <20220428141429.1637028-2-ltykernel@gmail.com>
 <e7b644f0-6c90-fe99-792d-75c38505dc54@arm.com>
 <YmqonHKBT8ftYHgY@infradead.org>
 <1517d2f0-08d6-a532-7810-2161b2dff421@linux.intel.com>
 <aa8e2fab-5b7e-cac3-0fbd-7c6edbbf942a@arm.com>
From: Andi Kleen <ak@linux.intel.com>
In-Reply-To: <aa8e2fab-5b7e-cac3-0fbd-7c6edbbf942a@arm.com>
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

Ck9uIDQvMjgvMjAyMiA4OjA3IEFNLCBSb2JpbiBNdXJwaHkgd3JvdGU6Cj4gT24gMjAyMi0wNC0y
OCAxNTo1NSwgQW5kaSBLbGVlbiB3cm90ZToKPj4KPj4gT24gNC8yOC8yMDIyIDc6NDUgQU0sIENo
cmlzdG9waCBIZWxsd2lnIHdyb3RlOgo+Pj4gT24gVGh1LCBBcHIgMjgsIDIwMjIgYXQgMDM6NDQ6
MzZQTSArMDEwMCwgUm9iaW4gTXVycGh5IHdyb3RlOgo+Pj4+IFJhdGhlciB0aGFuIGludHJvZHVj
ZSB0aGlzIGV4dHJhIGxldmVsIG9mIGFsbG9jYXRvciBjb21wbGV4aXR5LCBob3cgCj4+Pj4gYWJv
dXQKPj4+PiBqdXN0IGRpdmlkaW5nIHVwIHRoZSBpbml0aWFsIFNXSU9UTEIgYWxsb2NhdGlvbiBp
bnRvIG11bHRpcGxlIAo+Pj4+IGlvX3RsYl9tZW0KPj4+PiBpbnN0YW5jZXM/Cj4+PiBZZWFoLsKg
IFdlJ3JlIGFsbW9zdCBkb25lIHJlbW92aW5nIGFsbCBrbm93bGVkZ2Ugb2Ygc3dpb3RsYiBmcm9t
IAo+Pj4gZHJpdmVycywKPj4+IHNvIHRoZSB2ZXJ5IGxhc3QgdGhpbmcgSSB3YW50IGlzIGFuIGlu
dGVyZmFjZSB0aGF0IGFsbG93cyBhIGRyaXZlciB0bwo+Pj4gYWxsb2NhdGUgYSBwZXItZGV2aWNl
IGJ1ZmZlci4KPj4KPj4gQXQgbGVhc3QgZm9yIFREWCBuZWVkIHBhcmFsbGVsaXNtIHdpdGggYSBz
aW5nbGUgZGV2aWNlIGZvciBwZXJmb3JtYW5jZS4KPj4KPj4gU28gaWYgeW91IHNwbGl0IHVwIHRo
ZSBpbyB0bGIgbWVtcyBmb3IgYSBkZXZpY2UgdGhlbiB5b3Ugd291bGQgbmVlZCBhIAo+PiBuZXcg
bWVjaGFuaXNtIHRvIGxvYWQgYmFsYW5jZSB0aGUgcmVxdWVzdHMgZm9yIHNpbmdsZSBkZXZpY2Ug
b3ZlciAKPj4gdGhvc2UuIEkgZG91YnQgaXQgd291bGQgYmUgYW55IHNpbXBsZXIuCj4KPiBFaCwg
SSB0aGluayBpdCB3b3VsZCBiZSwgc2luY2UgdGhlIHJvdW5kLXJvYmluIHJldHJ5IGxvb3AgY2Fu
IHRoZW4gCj4ganVzdCBzaXQgYXJvdW5kIHRoZSBleGlzdGluZyBpb190bGJfbWVtLWJhc2VkIGFs
bG9jYXRvciwgdnMuIHRoZSBjaHVybiAKPiBvZiBpbnNlcnRpbmcgaXQgaW4gdGhlIG1pZGRsZSwg
cGx1cyBpdCdzIHRoZW4gcmVhbGx5IGVhc3kgdG8gCj4gc3RhdGljYWxseSBkaXN0cmlidXRlIGRp
ZmZlcmVudCBzdGFydGluZyBwb2ludHMgYWNyb3NzIGRpZmZlcmVudCAKPiBkZXZpY2VzIHZpYSBk
ZXYtPmRtYV9pb190bGJfbWVtIGlmIHdlIHdhbnRlZCB0by4KPgo+IEFkbWl0dGVkbHkgdGhlIG92
ZXJhbGwgcGF0Y2ggcHJvYmFibHkgZW5kcyB1cCBhYm91dCB0aGUgc2FtZSBzaXplLCAKPiBzaW5j
ZSBpdCBsaWtlbHkgcHVzaGVzIGEgYml0IG1vcmUgY29tcGxleGl0eSBpbnRvIHN3aW90bGJfaW5p
dCB0byAKPiBjb21wZW5zYXRlLCBidXQgdGhhdCdzIHN0aWxsIGEgdHJhZGUtb2ZmIEkgbGlrZS4K
ClVubGVzcyB5b3UgY29tcGxldGVseSBicmVhayB0aGUgZXh0ZXJuYWwgQVBJIHRoaXMgd2lsbCBy
ZXF1aXJlIGEgbmV3IAptZWNoYW5pc20gdG8gc2VhcmNoIGEgbGlzdCBvZiBpb190bGJfbWVtcyBm
b3IgdGhlIHJpZ2h0IGFyZWEgdG8gZnJlZSBpbnRvLgoKSWYgdGhlIG1lbW9yeSBhcmVhIG5vdCBj
b250aWd1b3VzIChsaWtlIGluIHRoZSBvcmlnaW5hbCBwYXRjaCkgdGhpcyB3aWxsIApiZSBhIE8o
bikgb3BlcmF0aW9uIG9uIHRoZSBudW1iZXIgb2YgaW9fdGxiX21lbXMsIHNvIGl0IHdvdWxkIGdl
dCBtb3JlIAphbmQgbW9yZSBleHBlbnNpdmUgb24gbGFyZ2VyIHN5c3RlbXMuIE9yIHlvdSBtZXJn
ZSB0aGVtIGFsbCB0b2dldGhlciAoc28gCnRoYXQgdGhlIHNpbXBsZSBhZGRyZXNzIGFyaXRobWV0
aWMgdG8gbG9vayB1cCB0aGUgYXJlYSB3b3JrcyBhZ2FpbiksIAp3aGljaCB3aWxsIHJlcXVpcmUg
ZXZlbiBtb3JlIGNoYW5nZXMgaW4gdGhlIHNldHVwLiBPciB5b3UgYWRkIGhhc2hpbmcgb3IgCnNp
bWlsYXIgd2hpY2ggd2lsbCBiZSBldmVuIG1vcmUgY29tcGxpY2F0ZWQuCgpJbiB0aGUgZW5kIGRv
aW5nIGl0IHdpdGggYSBzaW5nbGUgaW9fdGxiX21lbSBpcyBzaWduaWZpY2FudGx5IHNpbXBsZXIg
CmFuZCBhbHNvIG1vcmUgbmF0dXJhbC4KCi1BbmRpCgoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxp
bnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2lvbW11
