Return-Path: <SRS0=dgoC=IK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD804C43381
	for <iommu@archiver.kernel.org>; Fri, 12 Mar 2021 20:06:53 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29B1164F84
	for <iommu@archiver.kernel.org>; Fri, 12 Mar 2021 20:06:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29B1164F84
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C4D3B49FE3;
	Fri, 12 Mar 2021 20:06:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QUgTbD-uFKB2; Fri, 12 Mar 2021 20:06:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 576924CF79;
	Fri, 12 Mar 2021 20:06:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2BD28C000A;
	Fri, 12 Mar 2021 20:06:51 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5DAF4C0001
 for <iommu@lists.linux-foundation.org>; Fri, 12 Mar 2021 20:06:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3733B43083
 for <iommu@lists.linux-foundation.org>; Fri, 12 Mar 2021 20:06:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=deltatee.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UnKm01TH_wIN for <iommu@lists.linux-foundation.org>;
 Fri, 12 Mar 2021 20:06:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 912F241509
 for <iommu@lists.linux-foundation.org>; Fri, 12 Mar 2021 20:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:Cc:To:content-disposition;
 bh=/dKXn2MTgnalq4INDTL+cUYvr798DsS+qKv7RTLo0q8=; b=da62C93BS1h63ogYf0+1s+anR6
 jE7LGT3lzTTjYIIqb+PgW/fdS/Tx6fEntgD51NJlTprHY0a60/LT/QP4Fc5Ai6ePuzSg+5NF+L6py
 nRbrs8LRxsjgEQ3bbreB2q1tcLRZSbwiR6N63c8IPAj25MKLjTff5d3tDmA5GNH69iLyo75HdTRQL
 icsGfRW5L4uGM435GQLPMFZysIjMtxvto4KAjvE2O5c0vlurrQcxvNGeRxzpZnms87a0en6OmRz0y
 4VE4+Oyatorjzq2kdC3StQcBh4Yfq+TM0mZnbCUm+7sKjhSlsjY53WT5kVLKDNyivZA8UJ6mwJmxv
 bJOEOTPw==;
Received: from s01060023bee90a7d.cg.shawcable.net ([24.64.145.4]
 helo=[192.168.0.10])
 by ale.deltatee.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <logang@deltatee.com>)
 id 1lKo3U-00023x-1V; Fri, 12 Mar 2021 13:06:41 -0700
To: Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org
References: <20210311233142.7900-1-logang@deltatee.com>
 <20210311233142.7900-9-logang@deltatee.com>
 <accd4187-7a9d-a8fc-f216-98ec24e3411a@arm.com>
 <45701356-ee41-1ad2-0e06-ca74af87b05a@deltatee.com>
 <76cc1c82-3cf4-92d3-992f-5c876ed30523@arm.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <6dd679b3-e38b-2c18-1990-bfc96bb4d971@deltatee.com>
Date: Fri, 12 Mar 2021 13:06:34 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <76cc1c82-3cf4-92d3-992f-5c876ed30523@arm.com>
Content-Language: en-US
X-SA-Exim-Connect-IP: 24.64.145.4
X-SA-Exim-Rcpt-To: jianxin.xiong@intel.com, hch@lst.de,
 andrzej.jakowski@intel.com, sbates@raithlin.com, dan.j.williams@intel.com,
 daniel.vetter@ffwll.ch, jason@jlekstrand.net, jgg@ziepe.ca,
 christian.koenig@amd.com, willy@infradead.org, iweiny@intel.com,
 dave.hansen@linux.intel.com, jhubbard@nvidia.com, dave.b.minturn@intel.com,
 iommu@lists.linux-foundation.org, linux-mm@kvack.org,
 linux-pci@vger.kernel.org, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 robin.murphy@arm.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [RFC PATCH v2 08/11] iommu/dma: Support PCI P2PDMA pages in
 dma-iommu map_sg
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Cc: Minturn Dave B <dave.b.minturn@intel.com>,
 John Hubbard <jhubbard@nvidia.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 Ira Weiny <iweiny@intel.com>, Christoph Hellwig <hch@lst.de>,
 Matthew Wilcox <willy@infradead.org>, Stephen Bates <sbates@raithlin.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Jason Ekstrand <jason@jlekstrand.net>,
 Daniel Vetter <daniel.vetter@ffwll.ch>,
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

CgpPbiAyMDIxLTAzLTEyIDEyOjQ3IHAubS4sIFJvYmluIE11cnBoeSB3cm90ZToKPj4+PiDCoMKg
IHsKPj4+PiDCoMKgwqDCoMKgwqAgc3RydWN0IHNjYXR0ZXJsaXN0ICpzLCAqY3VyID0gc2c7Cj4+
Pj4gwqDCoMKgwqDCoMKgIHVuc2lnbmVkIGxvbmcgc2VnX21hc2sgPSBkbWFfZ2V0X3NlZ19ib3Vu
ZGFyeShkZXYpOwo+Pj4+IEBAIC04NjQsNiArODY1LDIwIEBAIHN0YXRpYyBpbnQgX19maW5hbGlz
ZV9zZyhzdHJ1Y3QgZGV2aWNlICpkZXYsCj4+Pj4gc3RydWN0IHNjYXR0ZXJsaXN0ICpzZywgaW50
IG5lbnRzLAo+Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgIHNnX2RtYV9hZGRyZXNzKHMpID0gRE1B
X01BUFBJTkdfRVJST1I7Cj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqAgc2dfZG1hX2xlbihzKSA9
IDA7Cj4+Pj4gwqDCoCArwqDCoMKgwqDCoMKgwqAgaWYgKGlzX3BjaV9wMnBkbWFfcGFnZShzZ19w
YWdlKHMpKSAmJiAhc19pb3ZhX2xlbikgewo+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlm
IChpID4gMCkKPj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGN1ciA9IHNnX25l
eHQoY3VyKTsKPj4+PiArCj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc2dfZG1hX2FkZHJl
c3MoY3VyKSA9IHNnX3BoeXMocykgKyBzLT5vZmZzZXQgLQo+Pj4KPj4+IEFyZSB5b3Ugc3VyZSBh
Ym91dCB0aGF0PyA7KQo+Pgo+PiBEbyB5b3Ugc2VlIGEgYnVnPyBJIGRvbid0IGZvbGxvdyB5b3Uu
Li4KPiAKPiBzZ19waHlzKCkgYWxyZWFkeSBhY2NvdW50cyBmb3IgdGhlIG9mZnNldCwgc28geW91
J3JlIGFkZGluZyBpdCB0d2ljZS4KCkFoLCBvb3BzLiBOaWNlIGNhdGNoLiBJIG1pc3NlZCB0aGF0
LgoKPiAKPj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHBjaV9wMnBkbWFfYnVz
X29mZnNldChzZ19wYWdlKHMpKTsKPj4+Cj4+PiBDYW4gdGhlIGJ1cyBvZmZzZXQgbWFrZSBQMlAg
YWRkcmVzc2VzIG92ZXJsYXAgd2l0aCByZWdpb25zIG9mIG1lbSBzcGFjZQo+Pj4gdGhhdCB3ZSBt
aWdodCB1c2UgZm9yIHJlZ3VsYXIgSU9WQSBhbGxvY2F0aW9uPyBUaGF0IHdvdWxkIGJlIHZlcnkg
YmFkLi4uCj4+Cj4+IE5vLiBJT01NVSBkcml2ZXJzIGFscmVhZHkgZGlzYWxsb3cgYWxsIFBDSSBh
ZGRyZXNzZXMgZnJvbSBiZWluZyB1c2VkIGFzCj4+IElPVkEgYWRkcmVzc2VzLiBTZWUsIGZvciBl
eGFtcGxlLMKgIGRtYXJfaW5pdF9yZXNlcnZlZF9yYW5nZXMoKS4gSXQgd291bGQKPj4gYmUgYSBo
dWdlIHByb2JsZW0gZm9yIGEgd2hvbGUgbG90IG9mIG90aGVyIHJlYXNvbnMgaWYgaXQgZGlkbid0
Lgo+IAo+IEkga25vdyB3ZSByZXNlcnZlIHRoZSBvdXRib3VuZCB3aW5kb3dzIChsYXJnZWx5ICpi
ZWNhdXNlKiBzb21lIGhvc3QgCj4gYnJpZGdlcyB3aWxsIGNvbnNpZGVyIHRob3NlIGFkZHJlc3Nl
cyBhcyBhdHRlbXB0cyBhdCB1bnN1cHBvcnRlZCBQMlAgYW5kIAo+IHByZXZlbnQgdGhlbSB3b3Jr
aW5nKSwgSSBqdXN0IHdhbnRlZCB0byBjb25maXJtIHRoYXQgdGhpcyBidXMgb2Zmc2V0IGlzIAo+
IGFsd2F5cyBzb21ldGhpbmcgc21hbGwgdGhhdCBzdGF5cyB3aXRoaW4gdGhlIHJlbGV2YW50IHdp
bmRvdywgcmF0aGVyIAo+IHRoYW4gc29tZXRoaW5nIHRoYXQgbWlnaHQgbWFrZSBhIEJBUiBhcHBl
YXIgaW4gYSBjb21wbGV0ZWx5IGRpZmZlcmVudCAKPiBwbGFjZSBmb3IgUDJQIHB1cnBvc2VzLiBJ
ZiBzbywgdGhhdCdzIGdvb2QuCgpZZXMsIHdlbGwgaWYgYW4gSU9WQSBvdmVybGFwcyB3aXRoIGFu
eSBQQ0kgYnVzIGFkZHJlc3MgdGhlcmUncyBnb2luZyB0byAKYmUgc29tZSBkaWZmaWN1bHQgYnJv
a2VubmVzcyBiZWNhdXNlIHdoZW4gdGhlIElPVkEgaXMgdXNlZCBpdCBtaWdodCBiZSAKZGlyZWN0
ZWQgdG8gdGhlIGEgUENJIGRldmljZSBhbmQgbm90IHRoZSBJT01NVS4gSSBmaXhlZCBhIGJ1ZyBs
aWtlIHRoYXQgCm9uY2UuCj4+PiBJJ20gbm90IHJlYWxseSB0aHJpbGxlZCBhYm91dCB0aGUgaWRl
YSBvZiBwYXNzaW5nIHplcm8tbGVuZ3RoIHNlZ21lbnRzCj4+PiB0byBpb21tdV9tYXBfc2coKS4g
WWVzLCBpdCBoYXBwZW5zIHRvIHRyaWNrIHRoZSBjb25jYXRlbmF0aW9uIGxvZ2ljIGluCj4+PiB0
aGUgY3VycmVudCBpbXBsZW1lbnRhdGlvbiBpbnRvIGRvaW5nIHdoYXQgeW91IHdhbnQsIGJ1dCBp
dCBmZWVscyAKPj4+IGZyYWdpbGUuCj4+Cj4+IFdlJ3JlIG5vdCBwYXNzaW5nIHplcm8gbGVuZ3Ro
IHNlZ21lbnRzIHRvIGlvbW11X21hcF9zZygpIChvciBhbnkKPj4gZnVuY3Rpb24pLiBUaGlzIGxv
b3AgaXMganVzdCBzY2FubmluZyB0byBjYWxjdWxhdGUgdGhlIGxlbmd0aCBvZiB0aGUKPj4gcmVx
dWlyZWQgSU9WQS4gX19maW5hbGlzZV9zZygpICh3aGljaCBpcyBpbnRpbWF0ZWx5IHRpZWQgdG8g
dGhpcyBsb29wKQo+PiB0aGVuIG5lZWRzIGEgd2F5IHRvIGRldGVybWluZSB3aGljaCBzZWdtZW50
cyB3ZXJlIFAyUCBzZWdtZW50cy4gVGhlCj4+IGV4aXN0aW5nIGNvZGUgYWxyZWFkeSBvdmVyd3Jp
dGVzIHMtPmxlbmd0aCB3aXRoIGFuIGFsaWduZWQgbGVuZ3RoIGFuZAo+PiBzdG9yZXMgdGhlIG9y
aWdpbmFsIGxlbmd0aCBpbiBzZ19kbWFfbGVuLiBTbyB3ZSdyZSBub3QgcmVseWluZyBvbgo+PiB0
cmlja2luZyBhbnkgbG9naWMgaGVyZS4KPiAKPiBZZXMsIHdlIHRlbXBvcmFyaWx5IHNodWZmbGUg
aW4gcGFnZS1hbGlnbmVkIHF1YW50aXRpZXMgdG8gc2F0aXNmeSB0aGUgCj4gbmVlZHMgb2YgdGhl
IGlvbW11X21hcF9zZygpIGNhbGwsIGJlZm9yZSB1bnBhY2tpbmcgdGhpbmdzIGFnYWluIGluIAo+
IF9fZmluYWxpc2Vfc2coKS4gSXQncyBzb21lIGRpc2d1c3RpbmcgdHJpY2tlcnkgdGhhdCBJJ20g
cGFydGljdWxhcmx5IAo+IHByb3VkIG9mLiBNeSBwb2ludCBpcyB0aGF0IGlmIHlvdSBoYXZlIGEg
bWl4IG9mIGJvdGggcDJwIGFuZCBub3JtYWwgCj4gc2VnbWVudHMgLSB3aGljaCBzZWVtcyB0byBi
ZSBhIGNhc2UgeW91IHdhbnQgdG8gc3VwcG9ydCAtIHRoZW4gdGhlIAo+IGxlbmd0aCBvZiAwIHRo
YXQgeW91IHNldCB0byBmbGFnIHAycCBzZWdtZW50cyBoZXJlIHdpbGwgYmUgc2VlbiBieSAKPiBp
b21tdV9tYXBfc2coKSAoYXMgaXQgd2Fsa3MgdGhlIGxpc3QgdG8gbWFwIHRoZSBvdGhlciBzZWdt
ZW50cykgYmVmb3JlIAo+IHlvdSB0aGVuIHVzZSBpdCBhcyBhIGtleSB0byBvdmVycmlkZSB0aGUg
RE1BIGFkZHJlc3MgaW4gdGhlIGZpbmFsIHN0ZXAuIAo+IEl0J3Mgbm90IGEgY29uY2VybiBpZiB5
b3UgaGF2ZSBhIHAycC1vbmx5IGxpc3QgYW5kIHNob3J0LWNpcmN1aXQgCj4gc3RyYWlnaHQgdG8g
dGhhdCBzdGVwIChpbiB3aGljaCBjYXNlIGFsbCB0aGUgc2h1ZmZsaW5nIHdhcyB3YXN0ZWQgZWZm
b3J0IAo+IGFueXdheSksIGJ1dCBzaW5jZSBpdCdzIG5vdCBlbnRpcmVseSBjbGVhciB3aGF0IGEg
c2VnbWVudCB3aXRoIHplcm8gCj4gbGVuZ3RoIHdvdWxkIG1lYW4gaW4gZ2VuZXJhbCwgaXQgc2Vl
bXMgbGlrZSBhIGdvb2QgaWRlYSB0byBhdm9pZCBwYXNzaW5nIAo+IHRoZSBsaXN0IGFjcm9zcyBh
IHB1YmxpYyBib3VuZGFyeSBpbiB0aGF0IHN0YXRlLCBpZiBwb3NzaWJsZS4KCk9rLCB3ZWxsLCBJ
IG1lYW4gdGhlIGlvbW11X21hcF9zZygpIGRvZXMgdGhlIHJpZ2h0IHRoaW5nIGFzIGlzIHdpdGhv
dXQgCmNoYW5naW5nIGl0IGFuZCBJTU8gc2ctPmxlbmd0aCBzZXQgdG8gemVybyBkb2VzIG1ha2Ug
c2Vuc2UuIFN1cHBvcnRpbmcgCm1peGVkIFAyUCBhbmQgbm9ybWFsIHNlZ21lbnRzIGlzIHJlYWxs
eSB0aGUgd2hvbGUgcG9pbnQgb2YgdGhpcyBzZXJpZXMgCih0aGUgY3VycmVudCBrZXJuZWwgc3Vw
cG9ydHMgaG9tb2dlbmVvdXMgU0dMcyB3aXRoIGEgc3BlY2lhbGl6ZWQgcGF0aCAtLSAKc2VlIHBj
aV9wMnBkbWFfdW5tYXBfc2dfYXR0cnMoKSkuIEJ1dCBkbyB5b3UgaGF2ZSBhbiBhbHRlcm5hdGUg
c29sdXRpb24gCmZvciBzZy0+bGVuZ3RoPwoKTG9nYW4KX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxp
bnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2lvbW11
