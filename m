Return-Path: <SRS0=dgoC=IK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 477C9C433E6
	for <iommu@archiver.kernel.org>; Fri, 12 Mar 2021 18:11:34 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7AC864F48
	for <iommu@archiver.kernel.org>; Fri, 12 Mar 2021 18:11:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7AC864F48
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A6EB742FD7;
	Fri, 12 Mar 2021 18:11:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id W9xKvpcPqb_c; Fri, 12 Mar 2021 18:11:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 704EB42FD6;
	Fri, 12 Mar 2021 18:11:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 46AF0C000A;
	Fri, 12 Mar 2021 18:11:32 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B433AC0001
 for <iommu@lists.linux-foundation.org>; Fri, 12 Mar 2021 18:11:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9979A42FD7
 for <iommu@lists.linux-foundation.org>; Fri, 12 Mar 2021 18:11:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7eKmkfX4ixgD for <iommu@lists.linux-foundation.org>;
 Fri, 12 Mar 2021 18:11:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp2.osuosl.org (Postfix) with ESMTP id B7B7142FD6
 for <iommu@lists.linux-foundation.org>; Fri, 12 Mar 2021 18:11:29 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D802DED1;
 Fri, 12 Mar 2021 10:11:28 -0800 (PST)
Received: from [10.57.52.136] (unknown [10.57.52.136])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EB8E33F7D7;
 Fri, 12 Mar 2021 10:11:23 -0800 (PST)
Subject: Re: [RFC PATCH v2 06/11] dma-direct: Support PCI P2PDMA pages in
 dma-direct map_sg
To: Logan Gunthorpe <logang@deltatee.com>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org
References: <20210311233142.7900-1-logang@deltatee.com>
 <20210311233142.7900-7-logang@deltatee.com>
 <215e1472-5294-d20a-a43a-ff6dfe8cd66e@arm.com>
 <d7ead722-7356-8e0f-22de-cb9dea12b556@deltatee.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <a8205c02-a43f-d4e8-a9fe-5963df3a7b40@arm.com>
Date: Fri, 12 Mar 2021 18:11:17 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <d7ead722-7356-8e0f-22de-cb9dea12b556@deltatee.com>
Content-Language: en-GB
Cc: Minturn Dave B <dave.b.minturn@intel.com>,
 John Hubbard <jhubbard@nvidia.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 Christoph Hellwig <hch@lst.de>, Matthew Wilcox <willy@infradead.org>,
 Stephen Bates <sbates@raithlin.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Jason Ekstrand <jason@jlekstrand.net>, Daniel Vetter <daniel.vetter@ffwll.ch>,
 Dan Williams <dan.j.williams@intel.com>,
 Jakowski Andrzej <andrzej.jakowski@intel.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Xiong Jianxin <jianxin.xiong@intel.com>
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

T24gMjAyMS0wMy0xMiAxNjoyNCwgTG9nYW4gR3VudGhvcnBlIHdyb3RlOgo+IAo+IAo+IE9uIDIw
MjEtMDMtMTIgODo1MiBhLm0uLCBSb2JpbiBNdXJwaHkgd3JvdGU6Cj4+PiArCj4+PiAgwqDCoMKg
wqDCoMKgwqDCoMKgIHNnLT5kbWFfYWRkcmVzcyA9IGRtYV9kaXJlY3RfbWFwX3BhZ2UoZGV2LCBz
Z19wYWdlKHNnKSwKPj4+ICDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHNnLT5v
ZmZzZXQsIHNnLT5sZW5ndGgsIGRpciwgYXR0cnMpOwo+Pj4gIMKgwqDCoMKgwqDCoMKgwqDCoCBp
ZiAoc2ctPmRtYV9hZGRyZXNzID09IERNQV9NQVBQSU5HX0VSUk9SKQo+Pj4gQEAgLTQxMSw3ICs0
NDAsNyBAQCBpbnQgZG1hX2RpcmVjdF9tYXBfc2coc3RydWN0IGRldmljZSAqZGV2LCBzdHJ1Y3QK
Pj4+IHNjYXR0ZXJsaXN0ICpzZ2wsIGludCBuZW50cywKPj4+ICDCoCDCoCBvdXRfdW5tYXA6Cj4+
PiAgwqDCoMKgwqDCoCBkbWFfZGlyZWN0X3VubWFwX3NnKGRldiwgc2dsLCBpLCBkaXIsIGF0dHJz
IHwKPj4+IERNQV9BVFRSX1NLSVBfQ1BVX1NZTkMpOwo+Pj4gLcKgwqDCoCByZXR1cm4gMDsKPj4+
ICvCoMKgwqAgcmV0dXJuIHJldDsKPj4+ICDCoCB9Cj4+PiAgwqAgwqAgZG1hX2FkZHJfdCBkbWFf
ZGlyZWN0X21hcF9yZXNvdXJjZShzdHJ1Y3QgZGV2aWNlICpkZXYsIHBoeXNfYWRkcl90Cj4+PiBw
YWRkciwKPj4+IGRpZmYgLS1naXQgYS9rZXJuZWwvZG1hL21hcHBpbmcuYyBiL2tlcm5lbC9kbWEv
bWFwcGluZy5jCj4+PiBpbmRleCBiNmE2MzM2Nzk5MzMuLmFkYzFhODM5NTBiZSAxMDA2NDQKPj4+
IC0tLSBhL2tlcm5lbC9kbWEvbWFwcGluZy5jCj4+PiArKysgYi9rZXJuZWwvZG1hL21hcHBpbmcu
Ywo+Pj4gQEAgLTE3OCw4ICsxNzgsMTUgQEAgdm9pZCBkbWFfdW5tYXBfcGFnZV9hdHRycyhzdHJ1
Y3QgZGV2aWNlICpkZXYsCj4+PiBkbWFfYWRkcl90IGFkZHIsIHNpemVfdCBzaXplLAo+Pj4gIMKg
IEVYUE9SVF9TWU1CT0woZG1hX3VubWFwX3BhZ2VfYXR0cnMpOwo+Pj4gIMKgIMKgIC8qCj4+PiAt
ICogZG1hX21hcHNfc2dfYXR0cnMgcmV0dXJucyAwIG9uIGVycm9yIGFuZCA+IDAgb24gc3VjY2Vz
cy4KPj4+IC0gKiBJdCBzaG91bGQgbmV2ZXIgcmV0dXJuIGEgdmFsdWUgPCAwLgo+Pj4gKyAqIGRt
YV9tYXBzX3NnX2F0dHJzIHJldHVybnMgMCBvbiBhbnkgcmVzb3VyY2UgZXJyb3IgYW5kID4gMCBv
biBzdWNjZXNzLgo+Pj4gKyAqCj4+PiArICogSWYgMCBpcyByZXR1cm5lZCwgdGhlIG1hcHBpbmcg
Y2FuIGJlIHJldHJpZWQgYW5kIHdpbGwgc3VjY2VlZCBvbmNlCj4+PiArICogc3VmZmljaWVudCBy
ZXNvdXJjZXMgYXJlIGF2YWlsYWJsZS4KPj4KPj4gVGhhdCdzIG5vdCBhIGd1YXJhbnRlZSB3ZSBj
YW4gdXBob2xkLiBSZXRyeWluZyBmb3JldmVyIGluIHRoZSB2YWluIGhvcGUKPj4gdGhhdCBhIGRl
dmljZSBtaWdodCBldm9sdmUgc29tZSBleHRyYSBhZGRyZXNzIGJpdHMsIG9yIGEgYm91bmNlIGJ1
ZmZlcgo+PiBtaWdodCBtYWdpY2FsbHkgZ3JvdyBiaWcgZW5vdWdoIGZvciBhIGdpZ2FudGljIG1h
cHBpbmcsIGlzbid0Cj4+IG5lY2Vzc2FyaWx5IHRoZSBiZXN0IGlkZWEuCj4gCj4gUGVyaGFwcyB0
aGlzIGlzIGp1c3QgcG9vcmx5IHdvcmRlZC4gUmV0dXJuaW5nIDAgaXMgdGhlIG5vcm1hbCBjYXNl
IGFuZAo+IG5vdGhpbmcgaGFzIGNoYW5nZWQgdGhlcmUuIFRoZSBibG9jayBsYXllciwgZm9yIGV4
YW1wbGUsIHdpbGwgcmV0cnkgaWYKPiB6ZXJvIGlzIHJldHVybmVkIGFzIHRoaXMgb25seSBoYXBw
ZW5zIGlmIGl0IGZhaWxlZCB0byBhbGxvY2F0ZSByZXNvdXJjZXMKPiBmb3IgdGhlIG1hcHBpbmcu
IFRoZSByZWFzb24gd2UgaGF2ZSB0byByZXR1cm4gLTEgaXMgdG8gdGVsbCB0aGUgYmxvY2sKPiBs
YXllciBub3QgdG8gcmV0cnkgdGhlc2UgcmVxdWVzdHMgYXMgdGhleSB3aWxsIG5ldmVyIHN1Y2Nl
ZWQgaW4gdGhlIGZ1dHVyZS4KPiAKPj4+ICsgKgo+Pj4gKyAqIElmIHRoZXJlIGFyZSBQMlBETUEg
cGFnZXMgaW4gdGhlIHNjYXR0ZXJsaXN0IHRoZW4gdGhpcyBmdW5jdGlvbiBtYXkKPj4+ICsgKiBy
ZXR1cm4gLUVSRU1PVEVJTyB0byBpbmRpY2F0ZSB0aGF0IHRoZSBwYWdlcyBhcmUgbm90IG1hcHBh
YmxlIGJ5IHRoZQo+Pj4gKyAqIGRldmljZS4gSW4gdGhpcyBjYXNlLCBhbiBlcnJvciBzaG91bGQg
YmUgcmV0dXJuZWQgZm9yIHRoZSBJTyBhcyBpdAo+Pj4gKyAqIHdpbGwgbmV2ZXIgYmUgc3VjY2Vz
c2Z1bGx5IHJldHJpZWQuCj4+PiAgwqDCoCAqLwo+Pj4gIMKgIGludCBkbWFfbWFwX3NnX2F0dHJz
KHN0cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0IHNjYXR0ZXJsaXN0ICpzZywgaW50Cj4+PiBuZW50
cywKPj4+ICDCoMKgwqDCoMKgwqDCoMKgwqAgZW51bSBkbWFfZGF0YV9kaXJlY3Rpb24gZGlyLCB1
bnNpZ25lZCBsb25nIGF0dHJzKQo+Pj4gQEAgLTE5Nyw3ICsyMDQsNyBAQCBpbnQgZG1hX21hcF9z
Z19hdHRycyhzdHJ1Y3QgZGV2aWNlICpkZXYsIHN0cnVjdAo+Pj4gc2NhdHRlcmxpc3QgKnNnLCBp
bnQgbmVudHMsCj4+PiAgwqDCoMKgwqDCoMKgwqDCoMKgIGVudHMgPSBkbWFfZGlyZWN0X21hcF9z
ZyhkZXYsIHNnLCBuZW50cywgZGlyLCBhdHRycyk7Cj4+PiAgwqDCoMKgwqDCoCBlbHNlCj4+PiAg
wqDCoMKgwqDCoMKgwqDCoMKgIGVudHMgPSBvcHMtPm1hcF9zZyhkZXYsIHNnLCBuZW50cywgZGly
LCBhdHRycyk7Cj4+PiAtwqDCoMKgIEJVR19PTihlbnRzIDwgMCk7Cj4+PiArCj4+Cj4+IFRoaXMg
c2NhcmVzIG1lIC0gSSBoZXNpdGF0ZSB0byBpbWFnaW5lIHRoZSBhbW91bnQgb2YgZHJpdmVyL3N1
YnN5c3RlbQo+PiBjb2RlIG91dCB0aGVyZSB0aGF0IHdpbGwgc2VlIG5vbnplcm8gYW5kIG1lcnJp
bHkgc2V0IG9mZiBpdGVyYXRpbmcgYQo+PiBuZWdhdGl2ZSBudW1iZXIgb2Ygc2VnbWVudHMsIGlm
IHdlIG9wZW4gdGhlIGZsb29kZ2F0ZXMgb2YgYWxsb3dpbmcKPj4gaW1wbGVtZW50YXRpb25zIHRv
IHJldHVybiBlcnJvciBjb2RlcyBoZXJlLgo+IAo+IFllcywgYnV0IGl0IHdpbGwgbmV2ZXIgaGFw
cGVuIG9uIGV4aXN0aW5nIGRyaXZlcnMvc3Vic3lzdGVtcy4gVGhlIG9ubHkKPiB3YXkgaXQgY2Fu
IHJldHVybiBhIG5lZ2F0aXZlIG51bWJlciBpcyBpZiB0aGUgZHJpdmVyIHBhc3NlcyBpbiBQMlBE
TUEKPiBwYWdlcyB3aGljaCBjYW4ndCBoYXBwZW4gd2l0aG91dCBjaGFuZ2VzIGluIHRoZSBkcml2
ZXIuIFdlIGFyZSBjYXJlZnVsCj4gYWJvdXQgd2hlcmUgUDJQRE1BIHBhZ2VzIGNhbiBnZXQgaW50
byBzbyB3ZSBkb24ndCBoYXZlIHRvIHdvcnJ5IGFib3V0Cj4gYWxsIHRoZSBleGlzdGluZyBkcml2
ZXIgY29kZSBvdXQgdGhlcmUuCgpTdXJlLCB0aGF0J3MgaG93IHRoaW5ncyBzdGFuZCBpbW1lZGlh
dGVseSBhZnRlciB0aGlzIHBhdGNoLiBCdXQgdGhlbiAKc29tZW9uZSBjb21lcyBhbG9uZyB3aXRo
IHRoZSBwZXJmZWN0bHkgcmVhc29uYWJsZSBhcmd1bWVudCBmb3IgcmV0dXJuaW5nIAptb3JlIGV4
cHJlc3NpdmUgZXJyb3IgaW5mb3JtYXRpb24gZm9yIHJlZ3VsYXIgbWFwcGluZyBmYWlsdXJlcyBh
cyB3ZWxsIAooYmVjYXVzZSBzb21ldGltZXMgdGhvc2UgY2FuIGJlIHRlcm1pbmFsIHRvbywgYXMg
YWJvdmUpLCB3ZSBzdGFydCB0byBnZXQgCmRpdmVyZ2VudCBiZWhhdmlvdXIgYWNyb3NzIGFyY2hp
dGVjdHVyZXMgYW5kIHJhbmRvbSBiaXRzIG9mIG9sZCBjb2RlIApzdWJ0bHkgYnJlYWtpbmcgZG93
biB0aGUgbGluZS4gKlRoYXQqIGlzIHdoYXQgbWFrZXMgbWUgd2FyeSBvZiBtYWtpbmcgYSAKZnVu
ZGFtZW50YWwgY2hhbmdlIHRvIGEgbG9uZy1zdGFuZGluZyAibm9uemVybyBtZWFucyBzdWNjZXNz
IiBpbnRlcmZhY2UuLi4KClJvYmluLgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRh
dGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGlu
Zm8vaW9tbXU=
