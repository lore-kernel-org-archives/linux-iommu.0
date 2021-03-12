Return-Path: <SRS0=dgoC=IK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6F6FC433DB
	for <iommu@archiver.kernel.org>; Fri, 12 Mar 2021 17:03:56 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6AAF765024
	for <iommu@archiver.kernel.org>; Fri, 12 Mar 2021 17:03:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AAF765024
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 19AC54305A;
	Fri, 12 Mar 2021 17:03:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id w1WNAchd-sXX; Fri, 12 Mar 2021 17:03:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id C626643030;
	Fri, 12 Mar 2021 17:03:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AEFDBC000A;
	Fri, 12 Mar 2021 17:03:54 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 59FF4C0001
 for <iommu@lists.linux-foundation.org>; Fri, 12 Mar 2021 17:03:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3CE5084455
 for <iommu@lists.linux-foundation.org>; Fri, 12 Mar 2021 17:03:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=deltatee.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HJJIUyFar7to for <iommu@lists.linux-foundation.org>;
 Fri, 12 Mar 2021 17:03:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6177283C2D
 for <iommu@lists.linux-foundation.org>; Fri, 12 Mar 2021 17:03:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:Cc:To:content-disposition;
 bh=V/VslKJywQsa+B9YAC8dghP1OO6CVmZUKXpLzW4pIhQ=; b=hvIdFq2DAqZRf+jqWidcKj23gK
 25AAfGpLmwIThDbmmZoRtxX0b8MWQN1I83BkIkCfG35j4ZNKIf8B6ZTZ/jgdT003ovN4T5xlZVcsy
 jMqI7v7ZgfNyjIK9Y3gz/UFDtQLfV2L/5OTBbVO+4EeCF29eUe/Xs8yA4hGkodsUWqZMHjl9ObvbT
 UlWR/0K94BQ0t2VXgd4rlsJO1VCweVLuaREQlx4mCqN1D2xxRvOOd5SQUMQBcFk3W6Kuukq0HeoG5
 sUeZeX9ISQJYUCc+e8SQ1CtaHLsHhzcptg5958i8F1nX8awDpGpn036mCjZazwTrRxyKMG3rEht3H
 HLX9E1fA==;
Received: from s01060023bee90a7d.cg.shawcable.net ([24.64.145.4]
 helo=[192.168.0.10])
 by ale.deltatee.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <logang@deltatee.com>)
 id 1lKlCO-0007pn-Nb; Fri, 12 Mar 2021 10:03:41 -0700
To: Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org
References: <20210311233142.7900-1-logang@deltatee.com>
 <20210311233142.7900-9-logang@deltatee.com>
 <accd4187-7a9d-a8fc-f216-98ec24e3411a@arm.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <45701356-ee41-1ad2-0e06-ca74af87b05a@deltatee.com>
Date: Fri, 12 Mar 2021 10:03:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <accd4187-7a9d-a8fc-f216-98ec24e3411a@arm.com>
Content-Language: en-CA
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

CgpPbiAyMDIxLTAzLTEyIDg6NTIgYS5tLiwgUm9iaW4gTXVycGh5IHdyb3RlOgo+IE9uIDIwMjEt
MDMtMTEgMjM6MzEsIExvZ2FuIEd1bnRob3JwZSB3cm90ZToKPj4gV2hlbiBhIFBDSSBQMlBETUEg
cGFnZSBpcyBzZWVuLCBzZXQgdGhlIElPVkEgbGVuZ3RoIG9mIHRoZSBzZWdtZW50Cj4+IHRvIHpl
cm8gc28gdGhhdCBpdCBpcyBub3QgbWFwcGVkIGludG8gdGhlIElPVkEuIFRoZW4sIGluIGZpbmFs
aXNlX3NnKCksCj4+IGFwcGx5IHRoZSBhcHByb3ByaWF0ZSBidXMgYWRkcmVzcyB0byB0aGUgc2Vn
bWVudC4gVGhlIElPVkEgaXMgbm90Cj4+IGNyZWF0ZWQgaWYgdGhlIHNjYXR0ZXJsaXN0IG9ubHkg
Y29uc2lzdHMgb2YgUDJQRE1BIHBhZ2VzLgo+IAo+IFRoaXMgbWlzbGVkIG1lIGF0IGZpcnN0LCBi
dXQgSSBzZWUgdGhlIGltcGxlbWVudGF0aW9uIGRvZXMgYWN0dWFsbHkKPiBhcHBlYXIgdG8gYWNj
b21vZGF0ZSB0aGUgY2FzZSBvZiB3b3JraW5nIEFDUyB3aGVyZSBQMlAgKndvdWxkKiBzdGlsbAo+
IG5lZWQgdG8gYmUgbWFwcGVkIGF0IHRoZSBJT01NVS4KClllcywgdGhhdCdzIGNvcnJlY3QuCj4+
IMKgIHN0YXRpYyBpbnQgX19maW5hbGlzZV9zZyhzdHJ1Y3QgZGV2aWNlICpkZXYsIHN0cnVjdCBz
Y2F0dGVybGlzdCAqc2csCj4+IGludCBuZW50cywKPj4gLcKgwqDCoMKgwqDCoMKgIGRtYV9hZGRy
X3QgZG1hX2FkZHIpCj4+ICvCoMKgwqDCoMKgwqDCoCBkbWFfYWRkcl90IGRtYV9hZGRyLCB1bnNp
Z25lZCBsb25nIGF0dHJzKQo+PiDCoCB7Cj4+IMKgwqDCoMKgwqAgc3RydWN0IHNjYXR0ZXJsaXN0
ICpzLCAqY3VyID0gc2c7Cj4+IMKgwqDCoMKgwqAgdW5zaWduZWQgbG9uZyBzZWdfbWFzayA9IGRt
YV9nZXRfc2VnX2JvdW5kYXJ5KGRldik7Cj4+IEBAIC04NjQsNiArODY1LDIwIEBAIHN0YXRpYyBp
bnQgX19maW5hbGlzZV9zZyhzdHJ1Y3QgZGV2aWNlICpkZXYsCj4+IHN0cnVjdCBzY2F0dGVybGlz
dCAqc2csIGludCBuZW50cywKPj4gwqDCoMKgwqDCoMKgwqDCoMKgIHNnX2RtYV9hZGRyZXNzKHMp
ID0gRE1BX01BUFBJTkdfRVJST1I7Cj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBzZ19kbWFfbGVuKHMp
ID0gMDsKPj4gwqAgK8KgwqDCoMKgwqDCoMKgIGlmIChpc19wY2lfcDJwZG1hX3BhZ2Uoc2dfcGFn
ZShzKSkgJiYgIXNfaW92YV9sZW4pIHsKPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKGkg
PiAwKQo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGN1ciA9IHNnX25leHQoY3Vy
KTsKPj4gKwo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzZ19kbWFfYWRkcmVzcyhjdXIpID0g
c2dfcGh5cyhzKSArIHMtPm9mZnNldCAtCj4gCj4gQXJlIHlvdSBzdXJlIGFib3V0IHRoYXQ/IDsp
CgpEbyB5b3Ugc2VlIGEgYnVnPyBJIGRvbid0IGZvbGxvdyB5b3UuLi4KCj4+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgcGNpX3AycGRtYV9idXNfb2Zmc2V0KHNnX3BhZ2UocykpOwo+
IAo+IENhbiB0aGUgYnVzIG9mZnNldCBtYWtlIFAyUCBhZGRyZXNzZXMgb3ZlcmxhcCB3aXRoIHJl
Z2lvbnMgb2YgbWVtIHNwYWNlCj4gdGhhdCB3ZSBtaWdodCB1c2UgZm9yIHJlZ3VsYXIgSU9WQSBh
bGxvY2F0aW9uPyBUaGF0IHdvdWxkIGJlIHZlcnkgYmFkLi4uCgpOby4gSU9NTVUgZHJpdmVycyBh
bHJlYWR5IGRpc2FsbG93IGFsbCBQQ0kgYWRkcmVzc2VzIGZyb20gYmVpbmcgdXNlZCBhcwpJT1ZB
IGFkZHJlc3Nlcy4gU2VlLCBmb3IgZXhhbXBsZSwgIGRtYXJfaW5pdF9yZXNlcnZlZF9yYW5nZXMo
KS4gSXQgd291bGQKYmUgYSBodWdlIHByb2JsZW0gZm9yIGEgd2hvbGUgbG90IG9mIG90aGVyIHJl
YXNvbnMgaWYgaXQgZGlkbid0LgoKCj4+IEBAIC05NjAsMTEgKzk3NSwxMiBAQCBzdGF0aWMgaW50
IGlvbW11X2RtYV9tYXBfc2coc3RydWN0IGRldmljZSAqZGV2LAo+PiBzdHJ1Y3Qgc2NhdHRlcmxp
c3QgKnNnLAo+PiDCoMKgwqDCoMKgIHN0cnVjdCBpb21tdV9kbWFfY29va2llICpjb29raWUgPSBk
b21haW4tPmlvdmFfY29va2llOwo+PiDCoMKgwqDCoMKgIHN0cnVjdCBpb3ZhX2RvbWFpbiAqaW92
YWQgPSAmY29va2llLT5pb3ZhZDsKPj4gwqDCoMKgwqDCoCBzdHJ1Y3Qgc2NhdHRlcmxpc3QgKnMs
ICpwcmV2ID0gTlVMTDsKPj4gK8KgwqDCoCBzdHJ1Y3QgZGV2X3BhZ2VtYXAgKnBnbWFwID0gTlVM
TDsKPj4gwqDCoMKgwqDCoCBpbnQgcHJvdCA9IGRtYV9pbmZvX3RvX3Byb3QoZGlyLCBkZXZfaXNf
ZG1hX2NvaGVyZW50KGRldiksIGF0dHJzKTsKPj4gwqDCoMKgwqDCoCBkbWFfYWRkcl90IGlvdmE7
Cj4+IMKgwqDCoMKgwqAgc2l6ZV90IGlvdmFfbGVuID0gMDsKPj4gwqDCoMKgwqDCoCB1bnNpZ25l
ZCBsb25nIG1hc2sgPSBkbWFfZ2V0X3NlZ19ib3VuZGFyeShkZXYpOwo+PiAtwqDCoMKgIGludCBp
Owo+PiArwqDCoMKgIGludCBpLCBtYXAgPSAtMSwgcmV0ID0gMDsKPj4gwqAgwqDCoMKgwqDCoCBp
ZiAoc3RhdGljX2JyYW5jaF91bmxpa2VseSgmaW9tbXVfZGVmZXJyZWRfYXR0YWNoX2VuYWJsZWQp
ICYmCj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBpb21tdV9kZWZlcnJlZF9hdHRhY2goZGV2LCBkb21h
aW4pKQo+PiBAQCAtOTkzLDYgKzEwMDksMjMgQEAgc3RhdGljIGludCBpb21tdV9kbWFfbWFwX3Nn
KHN0cnVjdCBkZXZpY2UgKmRldiwKPj4gc3RydWN0IHNjYXR0ZXJsaXN0ICpzZywKPj4gwqDCoMKg
wqDCoMKgwqDCoMKgIHNfbGVuZ3RoID0gaW92YV9hbGlnbihpb3ZhZCwgc19sZW5ndGggKyBzX2lv
dmFfb2ZmKTsKPj4gwqDCoMKgwqDCoMKgwqDCoMKgIHMtPmxlbmd0aCA9IHNfbGVuZ3RoOwo+PiDC
oCArwqDCoMKgwqDCoMKgwqAgaWYgKGlzX3BjaV9wMnBkbWFfcGFnZShzZ19wYWdlKHMpKSkgewo+
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAoc2dfcGFnZShzKS0+cGdtYXAgIT0gcGdtYXAp
IHsKPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBwZ21hcCA9IHNnX3BhZ2Uocykt
PnBnbWFwOwo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIG1hcCA9IHBjaV9wMnBk
bWFfZG1hX21hcF90eXBlKGRldiwgcGdtYXApOwo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB9
Cj4+ICsKPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKG1hcCA8IDApIHsKPiAKPiBJdCBy
YXRoZXIgZmVlbHMgbGlrZSBpdCBzaG91bGQgYmUgdGhlIGpvYiBvZiB3aG9ldmVyIGNyZWF0ZXMg
dGhlIGxpc3QgaW4KPiB0aGUgZmlyc3QgcGxhY2Ugbm90IHRvIHB1dCB1bnVzYWJsZSBwYWdlcyBp
biBpdCwgZXNwZWNpYWxseSBzaW5jZSB0aGUKPiBwMnBkbWFfbWFwX3R5cGUgbG9va3MgdG8gYmUg
YSBmYWlybHkgY29hcnNlLWdyYWluZWQgYW5kIHN0YXRpYyB0aGluZy4KPiBUaGUgRE1BIEFQSSBp
c24ndCByZXNwb25zaWJsZSBmb3IgdmFsaWRhdGluZyBub3JtYWwgbWVtb3J5IHBhZ2VzLCBzbwo+
IHdoYXQgbWFrZXMgUDJQIHNwZWNpYWw/CgpZZXMsIHRoYXQgd291bGQgYmUgaWRlYWwsIGJ1dCB0
aGVyZSdzIHNvbWUgZGlmZmljdWx0aWVzIHRoZXJlLiBGb3IgdGhlCmRyaXZlciB0byBjaGVjayB0
aGUgcGFnZXMsIGl0IHdvdWxkIG5lZWQgdG8gbG9vcCB0aHJvdWdoIHRoZSBlbnRpcmUgU0cKb25l
IG1vcmUgdGltZSBvbiBldmVyeSB0cmFuc2FjdGlvbiwgcmVnYXJkbGVzcyBvZiB3aGV0aGVyIHRo
ZXJlIGFyZQpQMlBETUEgcGFnZXMsIG9yIG5vdC4gU28gdGhhdCB3aWxsIGhhdmUgYSBwZXJmb3Jt
YW5jZSBpbXBhY3QgZXZlbiB3aGVuCnRoZSBmZWF0dXJlIGlzbid0IGJlaW5nIHVzZWQuIEkgZG9u
J3QgdGhpbmsgdGhhdCdsbCBiZSBhY2NlcHRhYmxlIGZvcgptYW55IGRyaXZlcnMuCgpUaGUgb3Ro
ZXIgcG9zc2liaWxpdHkgaXMgZm9yIEdVUCB0byBkbyBpdCB3aGVuIGl0IGdldHMgdGhlIHBhZ2Vz
IGZyb20KdXNlcnNwYWNlLiBCdXQgR1VQIGRvZXNuJ3QgaGF2ZSBhbGwgdGhlIGluZm9ybWF0aW9u
IHRvIGRvIHRoaXMgYXQgdGhlCm1vbWVudC4gV2UnZCBoYXZlIHRvIHBhc3MgdGhlIHN0cnVjdCBk
ZXZpY2UgdGhhdCB3aWxsIGV2ZW50dWFsbHkgbWFwIHRoZQpwYWdlcyB0aHJvdWdoIGFsbCB0aGUg
bmVzdGVkIGZ1bmN0aW9ucyBpbiB0aGUgR1VQIHRvIGRvIHRoYXQgdGVzdCBhdAp0aGF0IHRpbWUu
IFRoaXMgbWlnaHQgbm90IGJlIGEgYmFkIG9wdGlvbiAodGhhdCBJIGhhbGYgbG9va2VkIGludG8p
LCBidXQKSSdtIG5vdCBzdXJlIGhvdyBhY2NlcHRhYmxlIGl0IHdvdWxkIGJlIHRvIHRoZSBHVVAg
ZGV2ZWxvcGVycy4KCkJ1dCBldmVuIGlmIHdlIGRvIHZlcmlmeSB0aGUgcGFnZXMgYWhlYWQgb2Yg
dGltZSwgd2Ugc3RpbGwgbmVlZCB0aGUgc2FtZQppbmZyYXN0cnVjdHVyZSBpbiBkbWFfbWFwX3Nn
KCk7IGl0IGNvdWxkIG9ubHkgbm93IGJlIGEgQlVHIGlmIHRoZSBkcml2ZXIKc2VudCBpbnZhbGlk
IHBhZ2VzIGluc3RlYWQgb2YgYW4gZXJyb3IgcmV0dXJuLgoKPj4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCByZXQgPSAtRVJFTU9URUlPOwo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIGdvdG8gb3V0X3Jlc3RvcmVfc2c7Cj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IH0KPj4gKwo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAobWFwKSB7Cj4+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcy0+bGVuZ3RoID0gMDsKPiAKPiBJJ20gbm90IHJlYWxs
eSB0aHJpbGxlZCBhYm91dCB0aGUgaWRlYSBvZiBwYXNzaW5nIHplcm8tbGVuZ3RoIHNlZ21lbnRz
Cj4gdG8gaW9tbXVfbWFwX3NnKCkuIFllcywgaXQgaGFwcGVucyB0byB0cmljayB0aGUgY29uY2F0
ZW5hdGlvbiBsb2dpYyBpbgo+IHRoZSBjdXJyZW50IGltcGxlbWVudGF0aW9uIGludG8gZG9pbmcg
d2hhdCB5b3Ugd2FudCwgYnV0IGl0IGZlZWxzIGZyYWdpbGUuCgpXZSdyZSBub3QgcGFzc2luZyB6
ZXJvIGxlbmd0aCBzZWdtZW50cyB0byBpb21tdV9tYXBfc2coKSAob3IgYW55CmZ1bmN0aW9uKS4g
VGhpcyBsb29wIGlzIGp1c3Qgc2Nhbm5pbmcgdG8gY2FsY3VsYXRlIHRoZSBsZW5ndGggb2YgdGhl
CnJlcXVpcmVkIElPVkEuIF9fZmluYWxpc2Vfc2coKSAod2hpY2ggaXMgaW50aW1hdGVseSB0aWVk
IHRvIHRoaXMgbG9vcCkKdGhlbiBuZWVkcyBhIHdheSB0byBkZXRlcm1pbmUgd2hpY2ggc2VnbWVu
dHMgd2VyZSBQMlAgc2VnbWVudHMuIFRoZQpleGlzdGluZyBjb2RlIGFscmVhZHkgb3ZlcndyaXRl
cyBzLT5sZW5ndGggd2l0aCBhbiBhbGlnbmVkIGxlbmd0aCBhbmQKc3RvcmVzIHRoZSBvcmlnaW5h
bCBsZW5ndGggaW4gc2dfZG1hX2xlbi4gU28gd2UncmUgbm90IHJlbHlpbmcgb24KdHJpY2tpbmcg
YW55IGxvZ2ljIGhlcmUuCgoKPj4gwqAgfQo+PiDCoCDCoCBzdGF0aWMgdm9pZCBpb21tdV9kbWFf
dW5tYXBfc2coc3RydWN0IGRldmljZSAqZGV2LCBzdHJ1Y3QKPj4gc2NhdHRlcmxpc3QgKnNnLAo+
PiDCoMKgwqDCoMKgwqDCoMKgwqAgaW50IG5lbnRzLCBlbnVtIGRtYV9kYXRhX2RpcmVjdGlvbiBk
aXIsIHVuc2lnbmVkIGxvbmcgYXR0cnMpCj4+IMKgIHsKPj4gLcKgwqDCoCBkbWFfYWRkcl90IHN0
YXJ0LCBlbmQ7Cj4+ICvCoMKgwqAgZG1hX2FkZHJfdCBlbmQsIHN0YXJ0ID0gRE1BX01BUFBJTkdf
RVJST1I7Cj4+IMKgwqDCoMKgwqAgc3RydWN0IHNjYXR0ZXJsaXN0ICp0bXA7Cj4+IMKgwqDCoMKg
wqAgaW50IGk7Cj4+IMKgIEBAIC0xMDU0LDE0ICsxMDkwLDIwIEBAIHN0YXRpYyB2b2lkIGlvbW11
X2RtYV91bm1hcF9zZyhzdHJ1Y3QgZGV2aWNlCj4+ICpkZXYsIHN0cnVjdCBzY2F0dGVybGlzdCAq
c2csCj4+IMKgwqDCoMKgwqDCoCAqIFRoZSBzY2F0dGVybGlzdCBzZWdtZW50cyBhcmUgbWFwcGVk
IGludG8gYSBzaW5nbGUKPj4gwqDCoMKgwqDCoMKgICogY29udGlndW91cyBJT1ZBIGFsbG9jYXRp
b24sIHNvIHRoaXMgaXMgaW5jcmVkaWJseSBlYXN5Lgo+PiDCoMKgwqDCoMKgwqAgKi8KPj4gLcKg
wqDCoCBzdGFydCA9IHNnX2RtYV9hZGRyZXNzKHNnKTsKPj4gLcKgwqDCoCBmb3JfZWFjaF9zZyhz
Z19uZXh0KHNnKSwgdG1wLCBuZW50cyAtIDEsIGkpIHsKPj4gK8KgwqDCoCBmb3JfZWFjaF9zZyhz
ZywgdG1wLCBuZW50cywgaSkgewo+PiArwqDCoMKgwqDCoMKgwqAgaWYgKHNnX2lzX3BjaV9wMnBk
bWEodG1wKSkKPiAKPiBTaW5jZSB0aGUgZmxhZyBpcyBhc3NvY2lhdGVkIHdpdGggdGhlIERNQSBh
ZGRyZXNzIHdoaWNoIHdpbGwgbm8gbG9uZ2VyCj4gYmUgdmFsaWQsIHNob3VsZG4ndCBpdCBiZSBj
bGVhcmVkPyBUaGUgY2lyY3Vtc3RhbmNlcyBpbiB3aGljaCBsZWF2aW5nIGl0Cj4gYXJvdW5kIGNv
dWxkIGNhdXNlIGEgcHJvYmxlbSBhcmUgdGVudW91cywgYnV0IGRlZmluaXRlbHkgcG9zc2libGUu
CgpZZXMsIHRoYXQncyBhIGdvb2QgaWRlYS4KClRoYW5rcyBmb3IgdGhlIHJldmlldyEKCkxvZ2Fu
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1h
aWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3Rz
LmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
