Return-Path: <SRS0=Xx/3=YV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80C61CA9EC0
	for <iommu@archiver.kernel.org>; Mon, 28 Oct 2019 15:34:51 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42ED7208C0
	for <iommu@archiver.kernel.org>; Mon, 28 Oct 2019 15:34:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="deh2nyp9";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="hQQ03xOr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42ED7208C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id EE3531174;
	Mon, 28 Oct 2019 15:34:50 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id CAD681164
	for <iommu@lists.linux-foundation.org>;
	Mon, 28 Oct 2019 15:34:49 +0000 (UTC)
Received: from smtp.codeaurora.org (smtp.codeaurora.org [198.145.29.96])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 69F1087B
	for <iommu@lists.linux-foundation.org>;
	Mon, 28 Oct 2019 15:34:49 +0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 3FDD160A19; Mon, 28 Oct 2019 15:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
	s=default; t=1572276889;
	bh=bCbdiTSckyICpvwuvpK6d6BcawKxrhdEuu25eW7caFs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=deh2nyp9QKwEe2IUBDz71a85Z8BLFSTPeuOPtic8Dwm/mGlWRrIePWVXV4pyWJukU
	w9U01YmEHLIVHppiPIysSFkaB42VTLbuHeF4JtA3L2DWc7ne17OG3zIHBPp3KRixD6
	l4UHWp5EfAkwsAU+gJ8QV0XFb9bfmSTTWFot0COA=
Received: from jcrouse1-lnx.qualcomm.com (i-global254.qualcomm.com
	[199.106.103.254])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: jcrouse@smtp.codeaurora.org)
	by smtp.codeaurora.org (Postfix) with ESMTPSA id E38EF60850;
	Mon, 28 Oct 2019 15:34:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
	s=default; t=1572276888;
	bh=bCbdiTSckyICpvwuvpK6d6BcawKxrhdEuu25eW7caFs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hQQ03xOrt536qEv7tq/7vDv8eKBYgdppf6EnJZ0Gu2clNU7Y46/cT8vJo6vfb4aKv
	rLmFgQEbpbccRx2ByIFJKdNSha+n0ewaTA+MPu5J1tZHWn6L9n0CU4NDdPmkCWOgdo
	E7hMd5pe9cMzWqXYkAVbGV4/qTtp0JOMlkrwo41M=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E38EF60850
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
	dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
	spf=none smtp.mailfrom=jcrouse@codeaurora.org
Date: Mon, 28 Oct 2019 09:34:46 -0600
From: Jordan Crouse <jcrouse@codeaurora.org>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH] iommu/dma: Add support for DMA_ATTR_SYS_CACHE
Message-ID: <20191028153445.GD7966@jcrouse1-lnx.qualcomm.com>
Mail-Followup-To: Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>, Christoph Hellwig <hch@lst.de>,
	isaacm@codeaurora.org, linux-kernel@vger.kernel.org,
	lmark@codeaurora.org, iommu@lists.linux-foundation.org,
	pratikp@codeaurora.org, smasetty@codeaurora.org
References: <1572050616-6143-1-git-send-email-isaacm@codeaurora.org>
	<20191026053026.GA14545@lst.de>
	<e5fe861d7d506eb41c23f3fc047efdfa@codeaurora.org>
	<20191028074156.GB20443@lst.de>
	<20191028112457.GB4122@willie-the-truck>
	<c1b37c8d-7bdc-eb81-19c2-29f50568150a@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <c1b37c8d-7bdc-eb81-19c2-29f50568150a@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Cc: isaacm@codeaurora.org, pratikp@codeaurora.org, smasetty@codeaurora.org,
	linux-kernel@vger.kernel.org, lmark@codeaurora.org,
	iommu@lists.linux-foundation.org, Will Deacon <will@kernel.org>,
	Christoph Hellwig <hch@lst.de>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

T24gTW9uLCBPY3QgMjgsIDIwMTkgYXQgMTE6NTk6MDRBTSArMDAwMCwgUm9iaW4gTXVycGh5IHdy
b3RlOgo+IE9uIDI4LzEwLzIwMTkgMTE6MjQsIFdpbGwgRGVhY29uIHdyb3RlOgo+ID5IaSBDaHJp
c3RvcGgsCj4gPgo+ID5PbiBNb24sIE9jdCAyOCwgMjAxOSBhdCAwODo0MTo1NkFNICswMTAwLCBD
aHJpc3RvcGggSGVsbHdpZyB3cm90ZToKPiA+Pk9uIFNhdCwgT2N0IDI2LCAyMDE5IGF0IDAzOjEy
OjU3QU0gLTA3MDAsIGlzYWFjbUBjb2RlYXVyb3JhLm9yZyB3cm90ZToKPiA+Pj5PbiAyMDE5LTEw
LTI1IDIyOjMwLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToKPiA+Pj4+VGhlIGRlZmluaXRpb24g
bWFrZXMgdmVyeSBsaXR0bGUgc2Vuc2UuCj4gPj4+Q2FuIHlvdSBwbGVhc2UgY2xhcmlmeSB3aGF0
IHBhcnQgZG9lc27igJl0IG1ha2Ugc2Vuc2UsIGFuZCB3aHk/Cj4gPj4KPiA+Pkl0IGxvb2tzIGxp
a2UgY29tcGxldGUgZ2FyYmFnZSB0byBtZS4gIFRoYXQgbWlnaHQganVzdCBiZSBiZWNhdXNlIGl0
Cj4gPj51c2VzIHRvbnMgb2YgdGVybXMgSSd2ZSBuZXZlciBoZWFyZCBvZiBvZiBhbmQgd2hpY2gg
YXJlbid0IHVzZWQgYW55d2hlcmUKPiA+PmluIHRoZSBETUEgQVBJLiAgSXQgYWxzbyBtaWdodCBi
ZSBiZWNhdXNlIGl0IGRvZXNuJ3QgZXhwbGFpbiBob3cgdGhlCj4gPj5mbGFnIG1pZ2h0IGFjdHVh
bGx5IGJlIHByYWN0aWNhbGx5IHVzZWZ1bC4KPiA+Cj4gPkFncmVlZC4gVGhlIHdheSBJIC90aGlu
ay8gaXQgd29ya3MgaXMgdGhhdCBvbiBtYW55IFNvQ3MgdGhlcmUgaXMgYQo+ID5zeXN0ZW0vbGFz
dC1sZXZlbCBjYWNoZSAoTExDKSB3aGljaCBlZmZlY3RpdmVseSBzaXRzIGluIGZyb250IG9mIG1l
bW9yeSBmb3IKPiA+YWxsIG1hc3RlcnMuIEV2ZW4gaWYgYSBkZXZpY2UgaXNuJ3QgY29oZXJlbnQg
d2l0aCB0aGUgQ1BVIGNhY2hlcywgd2Ugc3RpbGwKPiA+d2FudCB0byBiZSBhYmxlIHRvIGFsbG9j
YXRlIGludG8gdGhlIExMQy4gV2h5IHRoaXMgZG9lc24ndCBoYXBwZW4KPiA+YXV0b21hdGljYWxs
eSBpcyBiZXlvbmQgbWUsIGJ1dCBpdCBhcHBlYXJzIHRoYXQgb24gdGhlc2UgUXVhbGNvbW0gZGVz
aWducwo+ID55b3UgYWN0dWFsbHkgaGF2ZSB0byBzZXQgdGhlIG1lbW9yeSBhdHRyaWJ1dGVzIHVw
IGluIHRoZSBwYWdlLXRhYmxlIHRvCj4gPmVuc3VyZSB0aGF0IHRoZSByZXN1bHRpbmcgbWVtb3J5
IHRyYW5zYWN0aW9ucyBhcmUgbm9uLWNhY2hlYWJsZSBmb3IgdGhlIENQVQo+ID5idXQgY2FjaGVh
YmxlIGZvciB0aGUgTExDLiBXaXRob3V0IGFueSBjaGFuZ2VzLCB0aGUgdHJhbnNhY3Rpb25zIGFy
ZQo+ID5ub24tY2FjaGVhYmxlIGluIGJvdGggb2YgdGhlbSB3aGljaCBhc3N1bWVkbHkgaGFzIGEg
cGVyZm9ybWFuY2UgY29zdC4KPiA+Cj4gPkJ1dCB5b3UgY2FuIHNlZSB0aGF0IEknbSBwaWVjaW5n
IHRoaW5ncyB0b2dldGhlciBteXNlbGYgaGVyZS4gSXNhYWM/Cj4gCj4gRldJVywgdGhhdCdzIHBy
ZXR0eSBtdWNoIGhvdyBQcmF0aWsgYW5kIEpvcmRhbiBleHBsYWluZWQgaXQgdG8gbWUgLSB0aGUg
TExDCj4gc2l0cyBkaXJlY3RseSBpbiBmcm9udCBvZiBtZW1vcnkgYW5kIGlzIG1vcmUgb3IgbGVz
cyB0cmFuc3BhcmVudCwgYWx0aG91Z2gKPiBpdCBtaWdodCB0cmVhdCBDUFUgYW5kIGRldmljZSBh
Y2Nlc3NlcyBzbGlnaHRseSBkaWZmZXJlbnRseSAoSSBkb24ndAo+IHJlbWVtYmVyIGV4YWN0bHkg
aG93IHRoZSBpbm5lciBjYWNoZWFibGlsaXR5IGF0dHJpYnV0ZSBpbnRlcmFjdHMpLiBDZXJ0YWlu
Cj4gZGV2aWNlcyBkb24ndCBnZXQgbXVjaCBiZW5lZml0IGZyb20gdGhlIExMQywgaGVuY2UgdGhl
IGRlc2lyZSBmb3IKPiBmaW5lci1ncmFpbmVkIGNvbnRyb2wgb2YgdGhlaXIgb3V0ZXIgYWxsb2Nh
dGlvbiBwb2xpY3kgdG8gYXZvaWQgbW9yZQo+IHRocmFzaGluZyB0aGFuIG5lY2Vzc2FyeS4gRnVy
dGhlcm1vcmUsIGZvciBzdHVmZiBpbiB0aGUgdmlkZW8vR1BVL2Rpc3BsYXkKPiBhcmVhIGNlcnRh
aW4gam9icyBiZW5lZml0IG1vcmUgdGhhbiBvdGhlcnMsIGhlbmNlIHRoZSBkZXNpcmUgdG8gZ28g
ZXZlbgo+IGZpbmVyLWdyYWluZWQgdGhhbiBhIHBlci1kZXZpY2UgY29udHJvbCBpbiBvcmRlciB0
byBtYXhpbWlzZSBMTEMKPiBlZmZlY3RpdmVuZXNzLgoKUm9iaW4ncyBkZXNjcmlwdGlvbiBpcyBj
b3JyZWN0LiBBbmQgd2UgZGlkIGhhdmUgYSBwYXRjaCBmb3IgYW4gaW4ta2VybmVsIHVzZXIKYnV0
IGl0IGdvdCBsb3N0IGluIHRoZSB3YXNoLiBJJ20gaG9waW5nIFNoYXJhdCBjYW4gZ2V0IGEgcmVz
cGluIGluIHRpbWUgZm9yIDUuNS4KCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LWFybS1t
c20vMTUzODc0NDkxNS0yNTQ5MC04LWdpdC1zZW5kLWVtYWlsLXNtYXNldHR5QGNvZGVhdXJvcmEu
b3JnLwoKSm9yZGFuCgotLSAKVGhlIFF1YWxjb21tIElubm92YXRpb24gQ2VudGVyLCBJbmMuIGlz
IGEgbWVtYmVyIG9mIENvZGUgQXVyb3JhIEZvcnVtLAphIExpbnV4IEZvdW5kYXRpb24gQ29sbGFi
b3JhdGl2ZSBQcm9qZWN0Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9y
ZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21t
dQ==
