Return-Path: <SRS0=bP0W=WC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0DF3C31E40
	for <iommu@archiver.kernel.org>; Tue,  6 Aug 2019 14:07:04 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B62620C01
	for <iommu@archiver.kernel.org>; Tue,  6 Aug 2019 14:07:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B62620C01
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 628F7CC8;
	Tue,  6 Aug 2019 14:07:04 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 94B25CC6
	for <iommu@lists.linux-foundation.org>;
	Tue,  6 Aug 2019 14:07:03 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[85.220.165.71])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 2699A82F
	for <iommu@lists.linux-foundation.org>;
	Tue,  6 Aug 2019 14:07:03 +0000 (UTC)
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
	by metis.ext.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <l.stach@pengutronix.de>)
	id 1hv07A-00031G-2a; Tue, 06 Aug 2019 16:07:00 +0200
Message-ID: <1565100418.2323.32.camel@pengutronix.de>
Subject: Re: Regression due to d98849aff879 (dma-direct: handle
	DMA_ATTR_NO_KERNEL_MAPPING in common code)
From: Lucas Stach <l.stach@pengutronix.de>
To: Christoph Hellwig <hch@lst.de>, "Lendacky, Thomas"
	<Thomas.Lendacky@amd.com>
Date: Tue, 06 Aug 2019 16:06:58 +0200
In-Reply-To: <20190806140408.GA22902@lst.de>
References: <1565082809.2323.24.camel@pengutronix.de>
	<20190806113318.GA20215@lst.de>
	<41cc93b1-62b5-7fb6-060d-01982e68503b@amd.com>
	<20190806140408.GA22902@lst.de>
X-Mailer: Evolution 3.22.6-1+deb9u2 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
	SAEximRunCond expanded to false
X-PTX-Original-Recipient: iommu@lists.linux-foundation.org
Cc: Halil Pasic <pasic@linux.ibm.com>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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

QW0gRGllbnN0YWcsIGRlbiAwNi4wOC4yMDE5LCAxNjowNCArMDIwMCBzY2hyaWViIENocmlzdG9w
aCBIZWxsd2lnOgo+IE9rLCBkb2VzIHRoaXMgd29yaz8KPiAKPiAtLQo+IEZyb20gMzRkMzVmMzM1
YTk4ZjUxNWYyNTE2YjUxNTA1MWUxMmVhZTc0NGM4ZCBNb24gU2VwIDE3IDAwOjAwOjAwIDIwMDEK
PiA+IEZyb206IENocmlzdG9waCBIZWxsd2lnIDxoY2hAbHN0LmRlPgo+IERhdGU6IFR1ZSwgNiBB
dWcgMjAxOSAxNDozMzoyMyArMDMwMAo+IFN1YmplY3Q6IGRtYS1kaXJlY3Q6IGZpeCBETUFfQVRU
Ul9OT19LRVJORUxfTUFQUElORwo+IAo+IFRoZSBuZXcgRE1BX0FUVFJfTk9fS0VSTkVMX01BUFBJ
TkcgbmVlZHMgdG8gYWN0dWFsbHkgYXNzaWduCj4gYSBkbWFfYWRkciB0byB3b3JrLsKgwqBBbHNv
IHNraXAgaXQgaWYgdGhlIGFyY2hpdGVjdHVyZSBuZWVkcwo+IGZvcmNlZCBkZWNyeXB0aW9uIGhh
bmRsaW5nLCBhcyB0aGF0IG5lZWRzIGEga2VybmVsIHZpcnR1YWwKPiBhZGRyZXNzLgo+IAo+IEZp
eGVzOiBkOTg4NDlhZmY4NzkgKGRtYS1kaXJlY3Q6IGhhbmRsZSBETUFfQVRUUl9OT19LRVJORUxf
TUFQUElORyBpbiBjb21tb24gY29kZSkKPiA+IFNpZ25lZC1vZmYtYnk6IENocmlzdG9waCBIZWxs
d2lnIDxoY2hAbHN0LmRlPgo+IC0tLQo+IMKga2VybmVsL2RtYS9kaXJlY3QuYyB8IDQgKysrLQo+
IMKgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQo+IAo+IGRp
ZmYgLS1naXQgYS9rZXJuZWwvZG1hL2RpcmVjdC5jIGIva2VybmVsL2RtYS9kaXJlY3QuYwo+IGlu
ZGV4IDU5YmRjZWVhMzczNy4uYjAxMDY0ZDg4NGYyIDEwMDY0NAo+IC0tLSBhL2tlcm5lbC9kbWEv
ZGlyZWN0LmMKPiArKysgYi9rZXJuZWwvZG1hL2RpcmVjdC5jCj4gQEAgLTEzMCwxMSArMTMwLDEz
IEBAIHZvaWQgKmRtYV9kaXJlY3RfYWxsb2NfcGFnZXMoc3RydWN0IGRldmljZSAqZGV2LCBzaXpl
X3Qgc2l6ZSwKPiA+IMKgCWlmICghcGFnZSkKPiA+IMKgCQlyZXR1cm4gTlVMTDsKPiDCoAo+ID4g
LQlpZiAoYXR0cnMgJiBETUFfQVRUUl9OT19LRVJORUxfTUFQUElORykgewo+ID4gKwlpZiAoKGF0
dHJzICYgRE1BX0FUVFJfTk9fS0VSTkVMX01BUFBJTkcpICYmCj4gKwnCoMKgwqDCoCFmb3JjZV9k
bWFfdW5lbmNyeXB0ZWQoZGV2KSkgewoKZG1hX2RpcmVjdF9mcmVlX3BhZ2VzKCkgdGhlbiBuZWVk
cyB0aGUgc2FtZSBjaGVjaywgYXMgb3RoZXJ3aXNlIHRoZSBjcHUKYWRkcmVzcyBpcyB0cmVhdGVk
IGFzIGEgY29va2llIGluc3RlYWQgb2YgYSByZWFsIGFkZHJlc3MgYW5kIHRoZQplbmNyeXB0aW9u
IG5lZWRzIHRvIGJlIHJlLWVuYWJsZWQuCgpSZWdhcmRzLApMdWNhcwoKPiDCoAkJLyogcmVtb3Zl
IGFueSBkaXJ0eSBjYWNoZSBsaW5lcyBvbiB0aGUga2VybmVsIGFsaWFzICovCj4gPiDCoAkJaWYg
KCFQYWdlSGlnaE1lbShwYWdlKSkKPiA+IMKgCQkJYXJjaF9kbWFfcHJlcF9jb2hlcmVudChwYWdl
LCBzaXplKTsKPiA+IMKgCQkvKiByZXR1cm4gdGhlIHBhZ2UgcG9pbnRlciBhcyB0aGUgb3BhcXVl
IGNvb2tpZSAqLwo+ID4gKwkJKmRtYV9oYW5kbGUgPSBwaHlzX3RvX2RtYShkZXYsIHBhZ2VfdG9f
cGh5cyhwYWdlKSk7Cj4gPiDCoAkJcmV0dXJuIHBhZ2U7Cj4gPiDCoAl9Cj4gwqAKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0
CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3Vu
ZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
