Return-Path: <SRS0=dgoC=IK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AA0AC433E0
	for <iommu@archiver.kernel.org>; Fri, 12 Mar 2021 18:25:11 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11C3964F5B
	for <iommu@archiver.kernel.org>; Fri, 12 Mar 2021 18:25:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11C3964F5B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B584C4E50D;
	Fri, 12 Mar 2021 18:25:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id R8l5z3rvI-k9; Fri, 12 Mar 2021 18:25:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2D60D4EB9E;
	Fri, 12 Mar 2021 18:25:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ED251C000A;
	Fri, 12 Mar 2021 18:25:08 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B31CEC0001
 for <iommu@lists.linux-foundation.org>; Fri, 12 Mar 2021 18:25:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9C9E683E68
 for <iommu@lists.linux-foundation.org>; Fri, 12 Mar 2021 18:25:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=deltatee.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GilolxawVb5V for <iommu@lists.linux-foundation.org>;
 Fri, 12 Mar 2021 18:25:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9F26C82C7E
 for <iommu@lists.linux-foundation.org>; Fri, 12 Mar 2021 18:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:Cc:To:content-disposition;
 bh=0Bko3Ie4Uvc54xcT0jJ3kOx/RyID/leZ9OA8KNpjYtM=; b=CvA51+dv8WoK6+gl9j6losyRNn
 z37elIJkHQw426VAvjyMmd5/0Bd+jcoHqQyCw3hNZXYLCffs7knNFKg37WykjcodyfX3G0aUY9C/N
 87MYNvRj2Eqb6cgu0n88BCBDou0hrsXHvB4Nmj2WQOYVly/WtQI9tInfq2+WIY2k0r5NA4XjiQnC8
 jSbqLYAUD3AAr9GYj35jdwDqzulDyyaRmX0uMROhg7AzCCnxVMOvjv7zXs8EERUsmx2i5k9gx9zxT
 EjrLzWUJo5R3pYhi7CTAcr61789tRhIu7upZlkGmerp5l9Bp0T4JHFW5BD5in+k90UHt3tBzvYj37
 TaJqDq4A==;
Received: from s01060023bee90a7d.cg.shawcable.net ([24.64.145.4]
 helo=[192.168.0.10])
 by ale.deltatee.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <logang@deltatee.com>)
 id 1lKmT0-0000WH-0K; Fri, 12 Mar 2021 11:24:55 -0700
To: Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org
References: <20210311233142.7900-1-logang@deltatee.com>
 <6b9be188-1ec7-527c-ae47-3f5b4e153758@arm.com>
 <c66d247e-5da9-4866-8e6b-ee2ec4bc03d5@deltatee.com>
 <90a2825c-da2f-c031-a70f-08c5efb3db56@arm.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <b7e007cc-d657-239e-5e2f-5de6ebec38c8@deltatee.com>
Date: Fri, 12 Mar 2021 11:24:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <90a2825c-da2f-c031-a70f-08c5efb3db56@arm.com>
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
Subject: Re: [RFC PATCH v2 00/11] Add support to dma_map_sg for P2PDMA
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

CgpPbiAyMDIxLTAzLTEyIDEwOjQ2IGEubS4sIFJvYmluIE11cnBoeSB3cm90ZToKPiBPbiAyMDIx
LTAzLTEyIDE2OjE4LCBMb2dhbiBHdW50aG9ycGUgd3JvdGU6Cj4+Cj4+Cj4+IE9uIDIwMjEtMDMt
MTIgODo1MSBhLm0uLCBSb2JpbiBNdXJwaHkgd3JvdGU6Cj4+PiBPbiAyMDIxLTAzLTExIDIzOjMx
LCBMb2dhbiBHdW50aG9ycGUgd3JvdGU6Cj4+Pj4gSGksCj4+Pj4KPj4+PiBUaGlzIGlzIGEgcmV3
b3JrIG9mIHRoZSBmaXJzdCBoYWxmIG9mIG15IFJGQyBmb3IgZG9pbmcgUDJQRE1BIGluCj4+Pj4g
dXNlcnNwYWNlCj4+Pj4gd2l0aCBPX0RJUkVDVFsxXS4KPj4+Pgo+Pj4+IFRoZSBsYXJnZXN0IGlz
c3VlIHdpdGggdGhhdCBzZXJpZXMgd2FzIHRoZSBncm9zcyB3YXkgb2YgZmxhZ2dpbmcgUDJQRE1B
Cj4+Pj4gU0dMIHNlZ21lbnRzLiBUaGlzIFJGQyBwcm9wb3NlcyBhIGRpZmZlcmVudCBhcHByb2Fj
aCwgKHN1Z2dlc3RlZCBieQo+Pj4+IERhbiBXaWxsaWFtc1syXSkgd2hpY2ggdXNlcyB0aGUgdGhp
cmQgYml0IGluIHRoZSBwYWdlX2xpbmsgZmllbGQgb2YgdGhlCj4+Pj4gU0dMLgo+Pj4+Cj4+Pj4g
VGhpcyBhcHByb2FjaCBpcyBhIGxvdCBsZXNzIGhhY2t5IGJ1dCBjb21lcyBhdCB0aGUgY29zdCBv
ZiBhZGRpbmcgYQo+Pj4+IENPTkZJR182NEJJVCBkZXBlbmRlbmN5IHRvIENPTkZJR19QQ0lfUDJQ
RE1BIGFuZCB1c2luZyB1cCB0aGUgbGFzdAo+Pj4+IHNjYXJjZSBiaXQgaW4gdGhlIHBhZ2VfbGlu
ay4gRm9yIG91ciBwdXJwb3NlcywgYSA2NEJJVCByZXN0cmljdGlvbiBpcwo+Pj4+IGFjY2VwdGFi
bGUgYnV0IGl0J3Mgbm90IGNsZWFyIGlmIHRoaXMgaXMgb2sgZm9yIGFsbCB1c2VjYXNlcyBob3Bp
bmcKPj4+PiB0byBtYWtlIHVzZSBvZiBQMlBETUEuCj4+Pj4KPj4+PiBNYXR0aGV3IFdpbGNveCBo
YXMgYWxyZWFkeSBzdWdnZXN0ZWQgKG9mZi1saXN0KSB0aGF0IHRoaXMgaXMgdGhlIHdyb25nCj4+
Pj4gYXBwcm9hY2gsIHByZWZlcnJpbmcgYSBuZXcgZG1hIG1hcHBpbmcgb3BlcmF0aW9uIGFuZCBh
biBTR0wKPj4+PiByZXBsYWNlbWVudC4gSQo+Pj4+IGRvbid0IGRpc2FncmVlIHRoYXQgc29tZXRo
aW5nIGFsb25nIHRob3NlIGxpbmVzIHdvdWxkIGJlIGEgYmV0dGVyIGxvbmcKPj4+PiB0ZXJtIHNv
bHV0aW9uLCBidXQgaXQgaW52b2x2ZXMgb3ZlcmNvbWluZyBhIGxvdCBvZiBjaGFsbGVuZ2VzIHRv
IGdldAo+Pj4+IHRoZXJlLiBDcmVhdGluZyBhIG5ldyBtYXBwaW5nIG9wZXJhdGlvbiBzdGlsbCBt
ZWFucyBhZGRpbmcgc3VwcG9ydCB0bwo+Pj4+IG1vcmUKPj4+PiB0aGFuIDI1IGRtYV9tYXBfb3Bz
IGltcGxlbWVudGF0aW9ucyAobWFueSBvZiB3aGljaCBhcmUgb24gb2JzY3VyZQo+Pj4+IGFyY2hp
dGVjdHVyZXMpIG9yIGNyZWF0aW5nIGEgcmVkdW5kYW50IHBhdGggdG8gZmFsbGJhY2sgd2l0aAo+
Pj4+IGRtYV9tYXBfc2coKQo+Pj4+IGZvciBldmVyeSBkcml2ZXIgdGhhdCB1c2VzIHRoZSBuZXcg
b3BlcmF0aW9uLiBUaGlzIFJGQyBpcyBhbiBhcHByb2FjaAo+Pj4+IHRoYXQgZG9lc24ndCByZXF1
aXJlIG92ZXJjb21pbmcgdGhlc2UgYmxvY2tzLgo+Pj4KPj4+IEkgZG9uJ3QgcmVhbGx5IGZvbGxv
dyB0aGF0IGFyZ3VtZW50IC0geW91J3JlIG9ubHkgYWRkaW5nIHN1cHBvcnQgdG8gdHdvCj4+PiBp
bXBsZW1lbnRhdGlvbnMgd2l0aCB0aGUgYXdrd2FyZCBmbGFnLCBzbyB3aHkgd291bGQgdXNpbmcg
YSBkZWRpY2F0ZWQKPj4+IG9wZXJhdGlvbiBpbnN0ZWFkIGJlIGFueSBkaWZmZXJlbnQ/IFdoYXRl
dmVyIGNhbGxlcnMgbmVlZCB0byBkbyBpZgo+Pj4gZG1hX3BjaV9wMnBkbWFfc3VwcG9ydGVkKCkg
c2F5cyBubywgdGhleSBjb3VsZCBlcXVhbGx5IGRvIGlmCj4+PiBkbWFfbWFwX3AycF9zZygpIChv
ciB3aGF0ZXZlcikgcmV0dXJucyAtRU5YSU8sIG5vPwo+Pgo+PiBUaGUgdGhpbmcgaXMgaWYgdGhl
IGRtYV9tYXBfc2cgZG9lc24ndCBzdXBwb3J0IFAyUERNQSB0aGVuIFAyUERNQQo+PiB0cmFuc2Fj
dGlvbnMgY2Fubm90IGJlIGRvbmUsIGJ1dCByZWd1bGFyIHRyYW5zYWN0aW9ucyBjYW4gc3RpbGwg
Z28KPj4gdGhyb3VnaCBhcyB0aGV5IGFsd2F5cyBkaWQuCj4+Cj4+IEJ1dCByZXBsYWNpbmcgZG1h
X21hcF9zZygpIHdpdGggZG1hX21hcF9uZXcoKSBhZmZlY3RzIGFsbCBvcGVyYXRpb25zLAo+PiBQ
MlBETUEgb3Igb3RoZXJ3aXNlLiBJZiBkbWFfbWFwX25ldygpIGlzbid0IHN1cHBvcnRlZCBpdCBj
YW4ndCBzaW1wbHkKPj4gbm90IHN1cHBvcnQgUDJQRE1BOyBpdCBoYXMgdG8gbWFpbnRhaW4gYSBm
YWxsYmFjayBwYXRoIHRvIGRtYV9tYXBfc2coKS4KPiAKPiBCdXQgQUZBSUNTIHRoZSBlcXVpdmFs
ZW50IGZhbGxiYWNrIHBhdGggc3RpbGwgaGFzIHRvIGV4aXN0IGVpdGhlciB3YXkuCj4gTXkgaW1w
cmVzc2lvbiBzbyBmYXIgaXMgdGhhdCBjYWxsZXJzIHdvdWxkIGVuZCB1cCBsb29raW5nIHNvbWV0
aGluZyBsaWtlCj4gdGhpczoKPiAKPiDCoMKgwqDCoGlmIChkbWFfcGNpX3AycGRtYV9zdXBwb3J0
ZWQoKSkgewo+IMKgwqDCoMKgwqDCoMKgIGlmIChkbWFfbWFwX3NnKC4uLikgPCAwKQo+IMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgLy9kbyBub24tcDJwIGZhbGxiYWNrIGR1ZSB0byBwMnAgZmFpbHVy
ZQo+IMKgwqDCoMKgfSBlbHNlIHsKPiDCoMKgwqDCoMKgwqDCoCAvL2RvIG5vbi1wMnAgZmFsbGJh
Y2sgZHVlIHRvIGxhY2sgb2Ygc3VwcG9ydAo+IMKgwqDCoMKgfQo+IAo+IGF0IHdoaWNoIHBvaW50
LCBzaW1wbHk6Cj4gCj4gwqDCoMKgwqBpZiAoZG1hX21hcF9zZ19wMnAoLi4uKSA8IDApCj4gwqDC
oMKgwqDCoMKgwqAgLy9kbyBub24tcDJwIGZhbGxiYWNrIGVpdGhlciB3YXkKPiAKPiBzZWVtcyBl
bnRpcmVseSByZWFzb25hYmxlLiBXaGF0IGFtIEkgbWlzc2luZz8KCk5vLCB0aGF0J3Mgbm90IGhv
dyBpdCB3b3Jrcy4gVGhlIGRtYV9wY2lfcDJwZG1hX3N1cHBvcnRlZCgpIGZsYWcgZ2F0ZXMKd2hl
dGhlciBQMlBETUEgcGFnZXMgd2lsbCBiZSB1c2VkIGF0IGEgbXVjaCBoaWdoZXIgbGV2ZWwuIEN1
cnJlbnRseSB3aXRoCk5WTWUsIGlmIFAyUERNQSBpcyBzdXBwb3J0ZWQsIGl0IHNldHMgdGhlIFFV
RVVFX0ZMQUdfUENJX1AyUERNQSBvbiB0aGUKYmxvY2sgcXVldWUuIFRoaXMgaXMgdGhlbiB0ZXN0
ZWQgd2l0aCBibGtfcXVldWVfcGNpX3AycGRtYSgpIGJlZm9yZSBhbnkKUDJQRE1BIHRyYW5zYWN0
aW9uIHdpdGggdGhlIGJsb2NrIGRldmljZSBpcyBzdGFydGVkLgoKSW4gdGhlIGZvbGxvd2luZyBw
YXRjaGVzIHRoYXQgY291bGQgYWRkIHVzZXJzcGFjZSBzdXBwb3J0LApibGtfcXVldWVfcGNpX3Ay
cGRtYSgpIGlzIHVzZWQgdG8gYWRkIGEgZmxhZyB0byBHVVAgd2hpY2ggYWxsb3dzIFAyUERNQQpw
YWdlcyBpbnRvIHRoZSBkcml2ZXIgdmlhIE9fRElSRUNULgoKVGhlcmUgaXMgbm8gZmFsbGJhY2sg
cGF0aCBvbiB0aGUgZG1hX21hcF9zZygpIG9wZXJhdGlvbiBpZiBwMnBkbWEgaXMgbm90CnN1cHBv
cnRlZC4gZG1hX21hcF9zZygpIGlzIGFsd2F5cyB1c2VkLiBUaGUgY29kZSBzaW1wbHkgcHJldmVu
dHMgcGFnZXMKZnJvbSBnZXR0aW5nIHRoZXJlIGluIHRoZSBmaXJzdCBwbGFjZS4KCkEgbmV3IERN
QSBvcGVyYXRpb24gd291bGQgaGF2ZSB0byBiZToKCmlmIChkbWFfaGFzX25ld19vcGVyYXRpb24o
KSkgewogICAgIC8vIGNyZWF0ZSBpbnB1dCBmb3IgZG1hX21hcF9uZXdfb3AoKQogICAgIC8vIG1h
cCB3aXRoIGRtYV9tYXBfbmV3X29wKCkKICAgICAvLyBwYXJzZSBvdXRwdXQgb2YgZG1hX21hcF9u
ZXdfb3AoKQp9IGVsc2UgewogICAgIC8vIGNyZWF0ZSBTR0wKICAgICBkbWFfbWFwX3NnKCkKICAg
ICAvLyBjb252ZXJ0IFNHTCB0byBoYXJkd2FyZSBtYXAKfQoKQW5kIHRoaXMgaWYgc3RhdGVtZW50
IGhhcyBub3RoaW5nIHRvIGRvIHdpdGggcDJwZG1hIHN1cHBvcnQgb3Igbm90LgoKPiAKPiBMZXQn
cyBub3QgcHJldGVuZCB0aGF0IG92ZXJsb2FkaW5nIGFuIGV4aXN0aW5nIEFQSSBtZWFucyB3ZSBj
YW4gc3RhcnQKPiBmZWVkaW5nIFAyUCBwYWdlcyBpbnRvIGFueSBvbGQgc3Vic3lzdGVtL2RyaXZl
ciB3aXRob3V0IGZ1cnRoZXIgY2hhbmdlcwo+IC0gdGhlcmUgYWxyZWFkeSAqYXJlKiBhdCBsZWFz
dCBzb21lIHRoYXQgcmV0cnkgYWQgaW5maW5pdHVtIGlmIERNQQo+IG1hcHBpbmcgZmFpbHMgKHRo
ZSBVU0IgbGF5ZXIgc3ByaW5ncyB0byBtaW5kLi4uKSBhbmQgdGh1cyB3b3VsZG4ndAo+IGhhbmRs
ZSB0aGUgUENJX1AyUERNQV9NQVBfTk9UX1NVUFBPUlRFRCBjYXNlIGFjY2VwdGFibHkuCgpZZXMs
IG5vYm9keSBpcyBwcmV0ZW5kaW5nIHRoYXQgYXQgYWxsLiBXZSBhcmUgYmVpbmcgdmVyeSBjYXJl
ZnVsIHdpdGgKUDJQRE1BIHBhZ2VzIGFuZCB3ZSBkb24ndCB3YW50IHRoZW0gdG8gZ2V0IGludG8g
YW55IGRyaXZlciB0aGF0IGlzbid0CmV4cGxpY2l0bHkgd3JpdHRlbiB0byBleHBlY3QgdGhlbS4g
V2l0aCB0aGUgY29kZSBpbiB0aGUgY3VycmVudCBrZXJuZWwKdGhpcyBpcyBhbGwgdmVyeSBleHBs
aWNpdCBhbmQgZG9uZSBhaGVhZCBvZiB0aW1lICh3aXRoClFVRVVFX0ZMQUdfUENJX1AyUERNQSBh
bmQgc2ltaWxhcikuIE9uY2UgdGhlIHBhZ2VzIGdldCBpbnRvIHVzZXJzcGFjZSwKR1VQIHdpbGwg
cmVqZWN0IHRoZW0gdW5sZXNzIHRoZSBkcml2ZXIgZ2V0dGluZyB0aGUgcGFnZXMgc3BlY2lmaWNh
bGx5CnNldHMgYSBmbGFnIGluZGljYXRpbmcgc3VwcG9ydCBmb3IgdGhlbS4KCj4+IEdpdmVuIHRo
YXQgdGhlIGlucHV0cyBhbmQgb3V0cHV0cyBmb3IgZG1hX21hcF9uZXcoKSB3aWxsIGJlIGNvbXBs
ZXRlbHkKPj4gZGlmZmVyZW50IGRhdGEgc3RydWN0dXJlcyB0aGlzIHdpbGwgYmUgcXVpdGUgYSBs
b3Qgb2Ygc2ltaWxhciBwYXRocwo+PiByZXF1aXJlZCBpbiB0aGUgZHJpdmVyLiAoaWUgbWFwcGlu
ZyBhIGJ2ZWMgdG8gdGhlIGlucHV0IHN0cnVjdCBhbmQgdGhlCj4+IG91dHB1dCBzdHJ1Y3QgdG8g
aGFyZHdhcmUgcmVxdWlyZW1lbnRzKSBJZiBhIGJ1ZyBjcm9wcyB1cCBpbiB0aGUgb2xkCj4+IGRt
YV9tYXBfc2coKSwgZGV2ZWxvcGVycyBtaWdodCBub3Qgbm90aWNlIGl0IGZvciBzb21lIHRpbWUg
c2VlaW5nIGl0Cj4+IHdvbid0IGJlIHVzZWQgb24gdGhlIG1vc3QgcG9wdWxhciBhcmNoaXRlY3R1
cmVzLgo+IAo+IEh1aD8gSSdtIHNwZWNpZmljYWxseSBzdWdnZXN0aW5nIGEgbmV3IGludGVyZmFj
ZSB0aGF0IHRha2VzIHRoZSAqc2FtZSoKPiBkYXRhIHN0cnVjdHVyZSAoYXQgbGVhc3QgdG8gYmVn
aW4gd2l0aCksIGJ1dCBqdXN0IGdpdmVzIHVzIG1vcmUKPiBmbGV4aWJpbGl0eSBpbiB0ZXJtcyBv
ZiBpbnRyb2R1Y2luZyBwMnAtYXdhcmUgYmVoYXZpb3VyIHNvbWV3aGF0IG1vcmUKPiBzYWZlbHku
IFllcywgd2UgYWxyZWFkeSBrbm93IHRoYXQgd2UgdWx0aW1hdGVseSB3YW50IHNvbWV0aGluZyBi
ZXR0ZXIKPiB0aGFuIHNjYXR0ZXJsaXN0cyBmb3IgcmVwcmVzZW50aW5nIHRoaW5ncyBsaWtlIHRo
aXMgYW5kIGRtYS1idWYgaW1wb3J0cywKPiBidXQgdGhhdCBoYXJkbHkgaGFzIHRvIGhhcHBlbiBv
dmVybmlnaHQuCgpPaywgd2VsbCB0aGF0J3Mgbm90IHdoYXQgTWF0dGhldyBoYWQgc3VnZ2VzdGVk
IG9mZiBsaXN0LiBIZSBzcGVjaWZpY2FsbHkKd2FzIHN1Z2dlc3RpbmcgbmV3IGRhdGEgc3RydWN0
dXJlcy4gQW5kIHllcywgdGhhdCBpc24ndCBnb2luZyB0byBoYXBwZW4Kb3Zlcm5pZ2h0LgoKSWYg
d2UgaGF2ZSBhIGRtYV9tYXBfc2coKSBhbmQgYSBkbWFfbWFwX3NnX3AycCgpIHRoYXQgYXJlIGlk
ZW50aWNhbApleGNlcHQgZG1hX21hcF9zZ19wMnAoKSBzdXBwb3J0cyBwMnBkbWEgbWVtb3J5IGFu
ZCBjYW4gcmV0dXJuIC0xIHRoZW4KdGhhdCBkb2Vzbid0IHNvdW5kIHNvIGJhZCB0byBtZS4gU28g
ZG1hX21hcF9zZygpIHdvdWxkIHNpbXBseSBiZSBjYWxsCmRtYV9tYXBfc2dfcDJwKCkgYW5kIGFk
ZCB0aGUgQlVHKCkgb24gdGhlIHJldHVybiBjb2RlLiBUaG91Z2ggSSByZWFsbHkKZG9uJ3Qgc2Vl
IHRoZSBiZW5lZml0IG9mIHRoZSBleHRyYSBhbm5vdGF0aW9ucy4gSSBkb24ndCB0aGluayBpdCBy
ZWFsbHkKYWRkcyBhbnkgdmFsdWUuIFRoZSB0cmlja3kgdGhpbmcgaW4gdGhlIEFQSSBpcyB0aGUg
U0dMIHdoaWNoIG5lZWRzIHRvCmZsYWcgc2VnbWVudHMgZm9yIFAyUERNQSBhbmQgdGhlIG5ldyBm
dW5jdGlvbiBkb2Vzbid0IHNvbHZlIHRoYXQuCgpMb2dhbgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMu
bGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21h
aWxtYW4vbGlzdGluZm8vaW9tbXU=
