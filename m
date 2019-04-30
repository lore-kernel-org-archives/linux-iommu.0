Return-Path: <SRS0=Kg+4=TA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B608C43219
	for <iommu@archiver.kernel.org>; Tue, 30 Apr 2019 11:38:50 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C5F621670
	for <iommu@archiver.kernel.org>; Tue, 30 Apr 2019 11:38:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C5F621670
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 2E47C1084;
	Tue, 30 Apr 2019 11:38:50 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 03830F39
	for <iommu@lists.linux-foundation.org>;
	Tue, 30 Apr 2019 11:38:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.101.70])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id B0E9E876
	for <iommu@lists.linux-foundation.org>;
	Tue, 30 Apr 2019 11:38:22 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7C47080D;
	Tue, 30 Apr 2019 04:38:22 -0700 (PDT)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 164F23F5C1;
	Tue, 30 Apr 2019 04:38:20 -0700 (PDT)
Subject: Re: [PATCH 02/26] arm64/iommu: improve mmap bounds checking
To: Christoph Hellwig <hch@lst.de>
References: <20190422175942.18788-1-hch@lst.de>
	<20190422175942.18788-3-hch@lst.de>
	<306b7a19-4eb5-d1d8-5250-40f3ba9bca16@arm.com>
	<20190429190120.GA5637@lst.de>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <a96caa67-ac59-9ce8-aabc-2601c9a10203@arm.com>
Date: Tue, 30 Apr 2019 12:38:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190429190120.GA5637@lst.de>
Content-Language: en-GB
Cc: Tom Lendacky <thomas.lendacky@amd.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org
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
Content-Type: text/plain; charset="UTF-8"; format="flowed"
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190430113819.4MVQtIZ7P_T2xmhQTXxUskZpAmul711YaLd2t7U-4nM@z>

T24gMjkvMDQvMjAxOSAyMDowMSwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6Cj4gT24gTW9uLCBB
cHIgMjksIDIwMTkgYXQgMDE6MzU6NDZQTSArMDEwMCwgUm9iaW4gTXVycGh5IHdyb3RlOgo+PiBP
biAyMi8wNC8yMDE5IDE4OjU5LCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToKPj4+IFRoZSBucl9w
YWdlcyBjaGVja3Mgc2hvdWxkIGJlIGRvbmUgZm9yIGFsbCBtbWFwIHJlcXVlc3RzLCBub3QganVz
dCB0aG9zZQo+Pj4gdXNpbmcgcmVtYXBfcGZuX3JhbmdlLgo+Pgo+PiBJIHRoaW5rIGl0IHByb2Jh
Ymx5IG1ha2VzIHNlbnNlIG5vdyB0byBqdXN0IHNxdWFzaCB0aGlzIHdpdGggIzIyIG9uZSB3YXkg
b3IKPj4gdGhlIG90aGVyLCBidXQgaWYgeW91IHJlYWxseSByZWFsbHkgc3RpbGwgd2FudCB0byBr
ZWVwIGl0IGFzIGEgc2VwYXJhdGUKPj4gcGF0Y2ggd2l0aCBhIG1pc2xlYWRpbmcgY29tbWl0IG1l
c3NhZ2UgdGhlbiBJJ20gd2lsbGluZyB0byBrZWVwIG15Cj4+IGNvbXBsYWludHMgdG8gbXlzZWxm
IDopCj4gCj4gV2VsbCwgSSBzcGxpdCB0aGlzIG91dCBpbiByZXNwb25zZSB0byB5b3VyIGVhcmxp
ZXIgY29tbWVudHMsIHNvIGlmIHlvdQo+IHByZWZlciBpdCBzcXVhc2hl0ZUgYmFjayBpbiBJIGNh
biBkbyB0aGF0Li4KCkFGQUlDUyBJIG9ubHkgZXZlciBzdWdnZXN0ZWQgc3BsaXR0aW5nIHRoZSBv
cmlnaW5hbCAiZml4IGFuZCByZWZhY3RvciIgCmNvbW1pdCBpbnRvIHRoZSBmaXggKHBhdGNoICMx
KSBhbmQgdGhlIHJlZmFjdG9yIC0gSSB0aGluayB3ZSd2ZSBqdXN0IAplbmRlZCB1cCBhZGRpbmcg
bW9yZSAicmVmYWN0b3IiIG9uIHRvcCBpbiB0aGUgZXZvbHV0aW9uIG9mIHRoZSBzZXJpZXMgOikK
ClJvYmluLgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpp
b21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6
Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
