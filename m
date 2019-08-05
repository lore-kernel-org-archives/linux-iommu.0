Return-Path: <SRS0=bWDR=WB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FF69C433FF
	for <iommu@archiver.kernel.org>; Mon,  5 Aug 2019 15:56:17 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48215208C3
	for <iommu@archiver.kernel.org>; Mon,  5 Aug 2019 15:56:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48215208C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 2F12CFD8;
	Mon,  5 Aug 2019 15:56:17 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 330D7F4A
	for <iommu@lists.linux-foundation.org>;
	Mon,  5 Aug 2019 15:56:16 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[85.220.165.71])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id B97F082D
	for <iommu@lists.linux-foundation.org>;
	Mon,  5 Aug 2019 15:56:15 +0000 (UTC)
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
	by metis.ext.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <l.stach@pengutronix.de>)
	id 1hufLJ-0000cf-EY; Mon, 05 Aug 2019 17:56:13 +0200
Message-ID: <1565020572.2323.15.camel@pengutronix.de>
Subject: Re: large DMA segments vs SWIOTLB
From: Lucas Stach <l.stach@pengutronix.de>
To: Christoph Hellwig <hch@lst.de>
Date: Mon, 05 Aug 2019 17:56:12 +0200
In-Reply-To: <20190801140045.GA23435@lst.de>
References: <1564584029.7267.15.camel@pengutronix.de>
	<20190801072958.GA16178@lst.de>
	<1564648502.7267.27.camel@pengutronix.de>
	<20190801140045.GA23435@lst.de>
X-Mailer: Evolution 3.22.6-1+deb9u2 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
	SAEximRunCond expanded to false
X-PTX-Original-Recipient: iommu@lists.linux-foundation.org
Cc: iommu@lists.linux-foundation.org,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
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

SGkgQ2hyaXN0b3BoLAoKQW0gRG9ubmVyc3RhZywgZGVuIDAxLjA4LjIwMTksIDE2OjAwICswMjAw
IHNjaHJpZWIgQ2hyaXN0b3BoIEhlbGx3aWc6Cj4gT24gVGh1LCBBdWcgMDEsIDIwMTkgYXQgMTA6
MzU6MDJBTSArMDIwMCwgTHVjYXMgU3RhY2ggd3JvdGU6Cj4gPiBIaSBDaHJpc3RvcGgsCj4gPiAK
PiA+IEFtIERvbm5lcnN0YWcsIGRlbiAwMS4wOC4yMDE5LCAwOToyOSArMDIwMCBzY2hyaWViIENo
cmlzdG9waCBIZWxsd2lnOgo+ID4gPiBIaSBMdWthcywKPiA+ID4gCj4gPiA+IGhhdmUgeW91IHRy
aWVkIHRoZSBsYXRlc3QgNS4zLXJjIGtlcm5lbCwgd2hlcmUgd2UgbGltaXRlZCB0aGUgTlZNZQo+
ID4gPiBJL08gc2l6ZSBiYXNlZCBvbiB0aGUgc3dpb3RsYiBidWZmZXIgc2l6ZT8KPiA+IAo+ID4g
WWVzLCB0aGUgaXNzdWUgd2FzIHJlcHJvZHVjZWQgb24gNS4zLXJjMi4gSSBub3cgc2VlIHlvdXIg
Y29tbWl0Cj4gPiBsaW1pdGluZyB0aGUgcmVxdWVzdCBzaXplLCBzbyBJIGd1ZXNzIEkgbmVlZCB0
byBkaWcgaW4gdG8gc2VlIHdoeSBJJ20KPiA+IHN0aWxsIGdldHRpbmcgcmVxdWVzdHMgbGFyZ2Vy
IHRoYW4gdGhlIFNXSU9UTEIgbWF4IHNlZ21lbnQgc2l6ZS4gVGhhbmtzCj4gPiBmb3IgdGhlIHBv
aW50ZXIhCj4gCj4gYSBzaW1pbGFyIHNldHVwIHRvIHlvdXJzIHRoZQo+IGRtYV9hZGRyZXNzaW5n
X2xpbWl0ZWQgZG9lc24ndCB3b3JrLCBidXQgaWYgd2UgY2hhbmdlZCBpdCB0byBhIDw9Cj4gaXQg
ZG9lcy7CoMKgVGhlIHJlc3VsdCBpcyBjb3VudGVyIHRvIHdoYXQgSSdkIGV4cGVjdCwgYnV0IGJl
Y2F1c2UgSSdtIG9uCj4gdmFjYXRpb24gSSBkaWRuJ3QgaGF2ZSB0aW1lIHRvIGxvb2sgaW50byB3
aHkgaXQgd29ya3MuwqDCoFRoaXMgaXMgaGlzCj4gcGF0Y2gsIGxldCBtZSBrbm93IGlmIHRoaXMg
d29ya3MgZm9yIHlvdToKPiAKPiAKPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9kbWEtbWFw
cGluZy5oIGIvaW5jbHVkZS9saW51eC9kbWEtbWFwcGluZy5oCj4gaW5kZXggZjdkMWVlYTMyYzc4
Li44OWFjMWNmNzU0Y2MgMTAwNjQ0Cj4gLS0tIGEvaW5jbHVkZS9saW51eC9kbWEtbWFwcGluZy5o
Cj4gKysrIGIvaW5jbHVkZS9saW51eC9kbWEtbWFwcGluZy5oCj4gQEAgLTY4OSw3ICs2ODksNyBA
QCBzdGF0aWMgaW5saW5lIGludCBkbWFfY29lcmNlX21hc2tfYW5kX2NvaGVyZW50KHN0cnVjdCBk
ZXZpY2UgKmRldiwgdTY0IG1hc2spCj4gwqAgKi8KPiDCoHN0YXRpYyBpbmxpbmUgYm9vbCBkbWFf
YWRkcmVzc2luZ19saW1pdGVkKHN0cnVjdCBkZXZpY2UgKmRldikKPiDCoHsKPiA+IC0JcmV0dXJu
IG1pbl9ub3RfemVybyhkbWFfZ2V0X21hc2soZGV2KSwgZGV2LT5idXNfZG1hX21hc2spIDwKPiA+
ICsJcmV0dXJuIG1pbl9ub3RfemVybyhkbWFfZ2V0X21hc2soZGV2KSwgZGV2LT5idXNfZG1hX21h
c2spIDw9Cj4gPiDCoAkJCcKgwqDCoMKgZG1hX2dldF9yZXF1aXJlZF9tYXNrKGRldik7Cj4gwqB9
CgpGcm9tIHRoZSBwYXRjaCBJIGp1c3Qgc2VudCBpdCBzaG91bGQgYmUgY2xlYXIgd2h5IHRoZSBh
Ym92ZSB3b3Jrcy4gV2l0aApteSBwYXRjaCBhcHBsaWVkIEkgY2FuJ3QgcmVwcm9kdWNlIGFueSBp
c3N1ZXMgd2l0aCB0aGlzIE5WTWUgZGV2aWNlCmFueW1vcmUuCgpUaGFua3MgZm9yIHBvaW50aW5n
IG1lIGludG8gdGhlIHJpZ2h0IGRpcmVjdGlvbiEKClJlZ2FyZHMsCkx1Y2FzCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdApp
b21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRh
dGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
