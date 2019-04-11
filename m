Return-Path: <SRS0=Ap1T=SN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52415C10F13
	for <iommu@archiver.kernel.org>; Thu, 11 Apr 2019 13:58:57 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2398B2077C
	for <iommu@archiver.kernel.org>; Thu, 11 Apr 2019 13:58:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2398B2077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id A3DBC27CE;
	Thu, 11 Apr 2019 13:58:56 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id E44B0254F
	for <iommu@lists.linux-foundation.org>;
	Thu, 11 Apr 2019 13:57:52 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 801D163D
	for <iommu@lists.linux-foundation.org>;
	Thu, 11 Apr 2019 13:57:52 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
	id C0AD442D; Thu, 11 Apr 2019 15:57:50 +0200 (CEST)
Date: Thu, 11 Apr 2019 15:57:49 +0200
From: Joerg Roedel <joro@8bytes.org>
To: David Woodhouse <dwmw2@infradead.org>
Subject: Re: per-device dma_map_ops for intel-iommu?
Message-ID: <20190411135749.GE4518@8bytes.org>
References: <20190409135924.GA11431@lst.de>
	<b491bb987c8cc3f95328d33586ec25c497cc8b8b.camel@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <b491bb987c8cc3f95328d33586ec25c497cc8b8b.camel@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: iommu@lists.linux-foundation.org, Christoph Hellwig <hch@lst.de>,
	linux-kernel@vger.kernel.org
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
Message-ID: <20190411135749.aDzRA1NFU8IEnkFu_qQrLYDDrVa2MQ2SRCgAo5DWiKQ@z>

T24gVHVlLCBBcHIgMDksIDIwMTkgYXQgMDU6MDM6NTJQTSArMDMwMCwgRGF2aWQgV29vZGhvdXNl
IHdyb3RlOgo+IE9uIFR1ZSwgMjAxOS0wNC0wOSBhdCAxNTo1OSArMDIwMCwgQ2hyaXN0b3BoIEhl
bGx3aWcgd3JvdGU6Cj4gPiBIaSBEYXZpZCBhbmQgSm9lcmcsCj4gPiAKPiA+IGRvIHlvdSByZW1l
bWJlciBhIGdvb2QgcmVhc29uIHdoeSBpbnRlbC1pb21tdSBpcyBub3QgdXNpbmcgcGVyLWRldmlj
ZQo+ID4gZG1hX21hcF9vcHMgbGlrZSB0aGUgQU1EIGlvbW11IG9yIHRoZSB2YXJpb3VzIEFSTSBp
b21tdXM/Cj4gPiAKPiA+IFJpZ2h0IG5vdyBpbnRlbC1pb21tdS5jIGNvbnRhaW5zIGEgaGFsZi1h
c3NlcyByZWltcGxlbWVudGF0aW9uIG9mIHRoZQo+ID4gZG1hIGRpcmVjdCBjb2RlIGZvciB0aGUg
aW9tbXVfbm9fbWFwcGluZygpIGNhc2UsIGFuZCBpdCB3b3VsZCBzZWVtCj4gPiBtdWNoIG5pY2Vy
IHRvIGp1c3QgZmFsbCBiYWNrIHRvIHRoYXQgY2FzZSBhbmQgbm90IGV2ZW4gY2FsbCBpbnRvCj4g
PiBpbnRlbC1pb21tdSBpbiB0aGF0IGNhc2UuCj4gCj4gT3RoZXIgdGhhbiB0aGUgY29tcGxleGl0
aWVzIGFib3V0IHBhc3N0aHJvdWdoIG1vZGUgYW5kIHZhcmlvdXMgIm9oIHNoaXQKPiB3ZSBmb3Jn
b3QgdG8gYWN0dWFsbHkgdGVzdCB0aGF0IGlvbW11K2dmeCBhY3R1YWxseSB3b3JrcyBiZWZvcmUK
PiBzaGlwcGluZyBoYXJkd2FyZSIgdHlwZSBvZiBxdWlya3MgdGhhdCBieXBhc3MgdGhlIElPTU1V
IGZvciBjZXJ0YWluCj4gZGV2aWNlcyDigJQgYW5kIHJldHBvbGluZXMsIHdoaWNoIEkgdGhpbmsg
eW91IGFscmVhZHkgZGVhbHQgd2l0aCDigJQgbm8sIG5vCj4gZ29vZCByZWFzb24gdGhhdCBJIHJl
Y2FsbC4KClNhbWUgaGVyZSwgSSBsb29rZWQgaW50byB0aGlzIGluIHRoZSBwYXN0IGFzIHdlbGws
IGJ1dCBJIGNhbid0IHJlY2FsbAphbnkgcmVhc29uIHRoaXMgd2FzIGxlZnQgaW4gcGxhY2UuCgoK
CUpvZXJnCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlv
bW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczov
L2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
