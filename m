Return-Path: <SRS0=8Bah=3X=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD183C35247
	for <iommu@archiver.kernel.org>; Mon,  3 Feb 2020 17:08:19 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5C8C2080D
	for <iommu@archiver.kernel.org>; Mon,  3 Feb 2020 17:08:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5C8C2080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 39893204EA;
	Mon,  3 Feb 2020 17:08:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gU8KWIGtORdP; Mon,  3 Feb 2020 17:08:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id EE57A203DD;
	Mon,  3 Feb 2020 17:08:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CBE56C1D81;
	Mon,  3 Feb 2020 17:08:17 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id ACEC1C0174
 for <iommu@lists.linux-foundation.org>; Mon,  3 Feb 2020 17:08:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 9DEDB8632E
 for <iommu@lists.linux-foundation.org>; Mon,  3 Feb 2020 17:08:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nHfbFeXsjR9Q for <iommu@lists.linux-foundation.org>;
 Mon,  3 Feb 2020 17:08:14 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by hemlock.osuosl.org (Postfix) with ESMTPS id E7BC486303
 for <iommu@lists.linux-foundation.org>; Mon,  3 Feb 2020 17:08:13 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id 3F48368BFE; Mon,  3 Feb 2020 18:08:09 +0100 (CET)
Date: Mon, 3 Feb 2020 18:08:09 +0100
From: Christoph Hellwig <hch@lst.de>
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PoC] arm: dma-mapping: direct: Apply dma_pfn_offset only when
 it is valid
Message-ID: <20200203170809.GA19293@lst.de>
References: <8eb68140-97b2-62ce-3e06-3761984aa5b1@ti.com>
 <20200114164332.3164-1-peter.ujfalusi@ti.com>
 <f8121747-8840-e279-8c7c-75a9d4becce8@arm.com>
 <28ee3395-baed-8d59-8546-ab7765829cc8@ti.com>
 <4f0e307f-29a9-44cd-eeaa-3b999e03871c@arm.com>
 <75843c71-1718-8d61-5e3d-edba6e1b10bd@ti.com> <20200130075332.GA30735@lst.de>
 <b2b1cb21-3aae-2181-fd79-f63701f283c0@ti.com> <20200130164010.GA6472@lst.de>
 <c37b12e4-0e0c-afa2-a8e4-782ccd57542d@ti.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <c37b12e4-0e0c-afa2-a8e4-782ccd57542d@ti.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: robh@kernel.org, vigneshr@ti.com, konrad.wilk@oracle.com,
 linux@armlinux.org.uk, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>,
 Christoph Hellwig <hch@lst.de>, linux-arm-kernel@lists.infradead.org,
 rogerq@ti.com
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

T24gRnJpLCBKYW4gMzEsIDIwMjAgYXQgMDQ6MDA6MjBQTSArMDIwMCwgUGV0ZXIgVWpmYWx1c2kg
d3JvdGU6Cj4gSSBzZWUuIE15IFBvQyBwYXRjaCB3YXMgbm90IHRvbyBvZmYgdGhlbiA7KQo+IFNv
IHRoZSBwbGFuIGlzIHRvIGhhdmUgYSBnZW5lcmljIGltcGxlbWVudGF0aW9uIGZvciBhbGwgb2Yg
dGhlCj4gYXJjaGl0ZWN0dXJlLCByaWdodD8KCtCGIGRvbid0IGtub3cgb2YgYSBjb25jcmV0ZSBw
bGFuLCBidXQgdGhhdCdzIGRlZmludGl2ZWx5IHdoYXQgSSdkIGxpa2UKdG8gc2VlLgoKPiA+PiBU
aGUgZG1hX3Bmbl9vZmZzZXQgaXMgX3N0aWxsXyBhcHBsaWVkIHRvIHRoZSBtYXNrIHdlIGFyZSB0
cnlpbmcgdG8gc2V0Cj4gPj4gKGFuZCB2YWxpZGF0ZSkgdmlhIGRtYS1kaXJlY3QuCj4gPiAKPiA+
IEFuZCBmb3IgdGhlIGdlbmVyYWwgY2FzZSB0aGF0IGlzIGV4YWN0bHkgdGhlIHJpZ2h0IHRoaW5n
IHRvIGRvLCB3ZQo+ID4ganVzdCBuZWVkIHRvIGRlYWwgd2l0aCByZWFsbHkgb2RkIFpPTkVfRE1B
IHBsYWNlbWVudHMgbGlrZSB5b3Vycy4KPiAKPiBJJ20gc3RpbGwgbm90IGNvbnZpbmNlZCwgdGhl
IHBvaW50IG9mIHRoZSBETUEgbWFzaywgYXQgbGVhc3QgaG93IEkgc2VlCj4gaXQsIHRvIGNoZWNr
IHRoYXQgdGhlIGRtYSBhZGRyZXNzIGNhbiBiZSBoYW5kbGVkIGJ5IHRoZSBkZXZpY2UgKERNQSwK
PiBwZXJpcGhlcmFsIHdpdGggYnVpbHQgaW4gRE1BLCBldGMpLCBpdCBpcyBub3QgYWdhaW5zdCBw
aHlzaWNhbCBhZGRyZXNzLgo+IERvaW5nIHBoeXNfdG9fZG1hKCkgb24gdGhlIG1hc2sgZnJvbSB0
aGUgZG1hX3NldF9tYXNrKCkgaXMganVzdCB3cm9uZy4KCldlIGhhdmUgYSB0cmFuc2xhdGlvbiBi
ZXR3ZWVuIHRoZSBhZGRyZXNzZXMgdGhhdCB0aGUgZGV2aWNlIHNlZXMsIGFuZAp0aG9zZSB0aGF0
IHRoZSBDUFUgc2Vlcy4gIFRoZSBkZXZpY2UgY2FuIGFkZHJlc3MgTiBiaXRzIG9mIGFkZHJlc3Mg
c3BhY2UKYXMgc2VlbiBmcm9tIHRoZSBkZXZpY2UuICBUaGUgYWRkcmVzc2VzIGVuY29kZWQgaW4g
bWF4X3BmbiwKem9uZV9kbWFfYml0cyBvciB0aGUgaGFyY29kZWQgMzIgaW4gdGhlIHpvbmUgZG1h
IDMyIGNhc2UgYXJlIENQVSBhZGRyZXNzLgpTbyBubywgd2UgY2FuJ3QgYmxpbmRseSBjb21wYXJl
IHRob3NlLgoKCj4gPiBCdXQgdGhhdCB3aWxsIGNhdXNlIHlldCBhbm90aGVyIHJlZ3Jlc3Npb24g
aW4gd2hhdCB3ZSBoYXZlIGp1c3QgZml4ZWQKPiA+IHdpdGggdXNpbmcgdGhlIGdlbmVyaWMgZGly
ZWN0IG9wcywgYXQgd2hpY2ggcG9pbnRzIGl0IHR1cm5zIGludG8gd2hvCj4gPiBzY3JlYW1zIGxv
dWRlci4KPiAKPiBIZWhlLCBJIHNlZS4KPiBJIGdlbnVpbmVseSBjdXJpb3VzIHdoeSBrMiBwbGF0
Zm9ybSB3b3JrZWQganVzdCBmaW5lIHdpdGggTFBBRSAoaXQgbmVlZHMKPiBpdCksIGJ1dCBndXlz
IGhhZCBpc3N1ZXMgd2l0aCBMUEFFIG9uIGRyYTcvYW01Lgo+IFRoZSBmaXggZm9yIGRyYTcvYW01
IGJyb2tlIGsyLgo+IEFzIGZhciBhcyBJIGNhbiBzZWUgdGhlIG1haW4gKG9ubHkpIGRpZmZlcmVu
Y2UgaXMgdGhhdCBrMiBoYXZlCj4gZG1hX3Bmbl9vZmZzZXQgPSAweDc4MDAwMCwgd2hpbGUgZHJh
Ny9hbTUgaGF2ZSBpdCAwIChyZWFsbHkgZGlyZWN0IG1hcHBpbmcpLgoKSG93IG11Y2ggbWVtb3J5
IGRvZXMgdGhlIHBsYXRmb3JtIGhhdmU/ICBPbmNlIHlvdSBhcmUgYWJvdmUgMzItYml0cyB3b3J0
aApvZiBhZGRyZXNzIHNwYWNlIGRldmljZXMgd2l0aCBhIDMyLWJpdCBETUEgbWFzayBjYW4ndCBh
ZGRyZXNzIGFsbCB0aGUKbWVtb3J5LiAgTm93IGlmIGsyIGZvciBleGFtcGxlIG9ubHkgaGFkIGxl
c3MgdGhhbiA0RyBvZiBtZW1vcnksIGJ1dCBhdAphZGRyZXNzZXMgb3ZlciA0RywgYW5kIHRoZSBv
ZmZzZXQgY29tcGVuc2F0ZXMgZm9yIHRoZSBvZmZzZXQgb2YgdGhlIERSQU0KaXQgd29ya3Mgd2l0
aG91dCBib3VuY2UgYnVmZmVyaW5nIGFuZCB0aHVzIGRpZG4ndCBuZWVkIHN3aW90bGIuICBCdXQg
YW55CnBsYXRmb3JtIHRoYXQgaGFzIERSQU0gdGhhdCBpcyBub3QgYWRkcmVzc2FibGUgd2lsbCBu
ZWVkIHN3aW90bGIuCgo+ID4gIAl1NjQgbWluX21hc2s7Cj4gPiAgCj4gPiArCWlmIChtYXNrID49
IERNQV9CSVRfTUFTSygzMikpCj4gPiArCQlyZXR1cm4gMTsKPiA+ICsKPiAKPiBSaWdodCwgc28g
c2tpcHBpbmcgcGh5c190b19kbWEoKSBmb3IgdGhlIG1hc2sgYW5kIGJlbGlldmluZyB0aGF0IGl0
IHdpbGwKPiB3b3JrLi4KPiAKPiBJdCBkb2VzOiBhdWRpbyBhbmQgZG1hdGVzdCBtZW1jcHkgdGVz
dHMgYXJlIGp1c3QgZmluZSB3aXRoIHRoaXMsIE1NQwo+IGFsc28gcHJvYmVkIHdpdGggQURNQSBl
bmFibGVkLgo+IAo+IEFzIGZhciBhcyBJIGNhbiB0ZWxsIGl0IHdvcmtzIGFzIHdlbGwgYXMgZmFs
bGluZyBiYWNrIHRvIHRoZSBvbGQgYXJtIG9wcwo+IGluIGNhc2Ugb2YgTFBBRSAmJiBkbWFfcGZu
X29mZnNldCAhPSAwCj4gCj4gRndpdzoKPiBUZXN0ZWQtYnk6IFBldGVyIFVqZmFsdXNpIDxwZXRl
ci51amZhbHVzaUB0aS5jb20+Cj4gCj4gV291bGQgeW91IGJlIGNvbWZvcnRhYmxlIHRvIHNlbmQg
dGhpcyBwYXRjaCBmb3IgbWFpbmxpbmUgd2l0aAo+IEZpeGVzOiBhZDNjN2IxOGM1YjMgKCJhcm06
IHVzZSBzd2lvdGxiIGZvciBib3VuY2UgYnVmZmVyaW5nIG9uIExQQUUKPiBjb25maWdzIikKClRo
YXQgaXMgdGhlIGJpZyBxdWVzdGlvbi4gIEkgZG9uJ3QgZmVlbCBvdmVybHkgY29tZm9ydGFibGUg
YXMgSSd2ZSBiZWVuCnRyeWluZyB0byBnZXQgdGhpcyByaWdodCwgYnV0IHNvIGZhciBpdCBzZWVt
cyBsaWtlIHRoZSBsZWFzdCBiYWQgb3B0aW9uLgpJJ2xsIHNlbmQgb3V0IGEgcHJvcGVyIHBhdGNo
IHdpdGggdXBkYXRlZCBjb21tZW50cyBhbmQgd2lsbCBzZWUgd2hhdApwZW9wbGUgdGhpbmsuCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxp
bmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxp
bnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
