Return-Path: <SRS0=wClR=S7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C676CC43219
	for <iommu@archiver.kernel.org>; Mon, 29 Apr 2019 19:01:40 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A05942075E
	for <iommu@archiver.kernel.org>; Mon, 29 Apr 2019 19:01:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A05942075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 64FD12C09;
	Mon, 29 Apr 2019 19:01:40 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id A391C2C05
	for <iommu@lists.linux-foundation.org>;
	Mon, 29 Apr 2019 19:01:38 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 1C07D876
	for <iommu@lists.linux-foundation.org>;
	Mon, 29 Apr 2019 19:01:38 +0000 (UTC)
Received: by newverein.lst.de (Postfix, from userid 2407)
	id 978DE68AFE; Mon, 29 Apr 2019 21:01:20 +0200 (CEST)
Date: Mon, 29 Apr 2019 21:01:20 +0200
From: Christoph Hellwig <hch@lst.de>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 02/26] arm64/iommu: improve mmap bounds checking
Message-ID: <20190429190120.GA5637@lst.de>
References: <20190422175942.18788-1-hch@lst.de>
	<20190422175942.18788-3-hch@lst.de>
	<306b7a19-4eb5-d1d8-5250-40f3ba9bca16@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <306b7a19-4eb5-d1d8-5250-40f3ba9bca16@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: Tom Lendacky <thomas.lendacky@amd.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org, Christoph Hellwig <hch@lst.de>,
	linux-arm-kernel@lists.infradead.org
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190429190120.zR8PLgoTvQ_wzQCizDFewIp1utSbxNG8G2w5xhk4FgI@z>

T24gTW9uLCBBcHIgMjksIDIwMTkgYXQgMDE6MzU6NDZQTSArMDEwMCwgUm9iaW4gTXVycGh5IHdy
b3RlOgo+IE9uIDIyLzA0LzIwMTkgMTg6NTksIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOgo+PiBU
aGUgbnJfcGFnZXMgY2hlY2tzIHNob3VsZCBiZSBkb25lIGZvciBhbGwgbW1hcCByZXF1ZXN0cywg
bm90IGp1c3QgdGhvc2UKPj4gdXNpbmcgcmVtYXBfcGZuX3JhbmdlLgo+Cj4gSSB0aGluayBpdCBw
cm9iYWJseSBtYWtlcyBzZW5zZSBub3cgdG8ganVzdCBzcXVhc2ggdGhpcyB3aXRoICMyMiBvbmUg
d2F5IG9yIAo+IHRoZSBvdGhlciwgYnV0IGlmIHlvdSByZWFsbHkgcmVhbGx5IHN0aWxsIHdhbnQg
dG8ga2VlcCBpdCBhcyBhIHNlcGFyYXRlIAo+IHBhdGNoIHdpdGggYSBtaXNsZWFkaW5nIGNvbW1p
dCBtZXNzYWdlIHRoZW4gSSdtIHdpbGxpbmcgdG8ga2VlcCBteSAKPiBjb21wbGFpbnRzIHRvIG15
c2VsZiA6KQoKV2VsbCwgSSBzcGxpdCB0aGlzIG91dCBpbiByZXNwb25zZSB0byB5b3VyIGVhcmxp
ZXIgY29tbWVudHMsIHNvIGlmIHlvdQpwcmVmZXIgaXQgc3F1YXNoZdGVIGJhY2sgaW4gSSBjYW4g
ZG8gdGhhdC4uCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRw
czovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
