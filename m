Return-Path: <SRS0=TgA1=WD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C521C433FF
	for <iommu@archiver.kernel.org>; Wed,  7 Aug 2019 15:24:24 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F42392199C
	for <iommu@archiver.kernel.org>; Wed,  7 Aug 2019 15:24:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F42392199C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 98ABEE8A;
	Wed,  7 Aug 2019 15:24:23 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id C9D71E77
	for <iommu@lists.linux-foundation.org>;
	Wed,  7 Aug 2019 15:24:22 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[85.220.165.71])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 3E20D823
	for <iommu@lists.linux-foundation.org>;
	Wed,  7 Aug 2019 15:24:22 +0000 (UTC)
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
	by metis.ext.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <l.stach@pengutronix.de>)
	id 1hvNnX-00089B-00; Wed, 07 Aug 2019 17:24:19 +0200
Message-ID: <1565191457.2323.41.camel@pengutronix.de>
Subject: Re: Regression due to d98849aff879 (dma-direct: handle
	DMA_ATTR_NO_KERNEL_MAPPING in common code)
From: Lucas Stach <l.stach@pengutronix.de>
To: Christoph Hellwig <hch@lst.de>
Date: Wed, 07 Aug 2019 17:24:17 +0200
In-Reply-To: <20190806154403.GA25050@lst.de>
References: <1565082809.2323.24.camel@pengutronix.de>
	<20190806113318.GA20215@lst.de>
	<41cc93b1-62b5-7fb6-060d-01982e68503b@amd.com>
	<20190806140408.GA22902@lst.de>
	<1565100418.2323.32.camel@pengutronix.de>
	<20190806154403.GA25050@lst.de>
X-Mailer: Evolution 3.22.6-1+deb9u2 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
	SAEximRunCond expanded to false
X-PTX-Original-Recipient: iommu@lists.linux-foundation.org
Cc: Halil Pasic <pasic@linux.ibm.com>, "Lendacky,
	Thomas" <Thomas.Lendacky@amd.com>,
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

QW0gRGllbnN0YWcsIGRlbiAwNi4wOC4yMDE5LCAxNzo0NCArMDIwMCBzY2hyaWViIENocmlzdG9w
aCBIZWxsd2lnOgo+IE9uIFR1ZSwgQXVnIDA2LCAyMDE5IGF0IDA0OjA2OjU4UE0gKzAyMDAsIEx1
Y2FzIFN0YWNoIHdyb3RlOgo+ID4gCj4gPiBkbWFfZGlyZWN0X2ZyZWVfcGFnZXMoKSB0aGVuIG5l
ZWRzIHRoZSBzYW1lIGNoZWNrLCBhcyBvdGhlcndpc2UgdGhlIGNwdQo+ID4gYWRkcmVzcyBpcyB0
cmVhdGVkIGFzIGEgY29va2llIGluc3RlYWQgb2YgYSByZWFsIGFkZHJlc3MgYW5kIHRoZQo+ID4g
ZW5jcnlwdGlvbiBuZWVkcyB0byBiZSByZS1lbmFibGVkLgo+IAo+IE9rLCBsZXRzIHRyeSB0aGlz
IG9uZSBpbnN0ZWFkOgo+IAo+IC0tCj4gRnJvbSAzYTdhYTlmZTM4YTVlYWU1ZDg3OTgzMWI0Zjhj
MTAzMmU3MzVhMGI2IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQo+IEZyb206IENocmlzdG9waCBI
ZWxsd2lnIDxoY2hAbHN0LmRlPgo+IERhdGU6IFR1ZSwgNiBBdWcgMjAxOSAxNDozMzoyMyArMDMw
MAo+IFN1YmplY3Q6IGRtYS1kaXJlY3Q6IGZpeCBETUFfQVRUUl9OT19LRVJORUxfTUFQUElORwo+
IAo+IFRoZSBuZXcgRE1BX0FUVFJfTk9fS0VSTkVMX01BUFBJTkcgbmVlZHMgdG8gYWN0dWFsbHkg
YXNzaWduCj4gYSBkbWFfYWRkciB0byB3b3JrLsKgwqBBbHNvIHNraXAgaXQgaWYgdGhlIGFyY2hp
dGVjdHVyZSBuZWVkcwo+IGZvcmNlZCBkZWNyeXB0aW9uIGhhbmRsaW5nLCBhcyB0aGF0IG5lZWRz
IGEga2VybmVsIHZpcnR1YWwKPiBhZGRyZXNzLgo+IAo+IEZpeGVzOiBkOTg4NDlhZmY4NzkgKGRt
YS1kaXJlY3Q6IGhhbmRsZSBETUFfQVRUUl9OT19LRVJORUxfTUFQUElORyBpbiBjb21tb24gY29k
ZSkKPiBTaWduZWQtb2ZmLWJ5OiBDaHJpc3RvcGggSGVsbHdpZyA8aGNoQGxzdC5kZT4KPiAtLS0K
PiDCoGtlcm5lbC9kbWEvZGlyZWN0LmMgfCA3ICsrKysrLS0KPiDCoDEgZmlsZSBjaGFuZ2VkLCA1
IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCj4gCj4gZGlmZiAtLWdpdCBhL2tlcm5lbC9k
bWEvZGlyZWN0LmMgYi9rZXJuZWwvZG1hL2RpcmVjdC5jCj4gaW5kZXggNTliZGNlZWEzNzM3Li40
YzIxMWM4N2E3MTkgMTAwNjQ0Cj4gLS0tIGEva2VybmVsL2RtYS9kaXJlY3QuYwo+ICsrKyBiL2tl
cm5lbC9kbWEvZGlyZWN0LmMKPiBAQCAtMTMwLDExICsxMzAsMTMgQEAgdm9pZCAqZG1hX2RpcmVj
dF9hbGxvY19wYWdlcyhzdHJ1Y3QgZGV2aWNlICpkZXYsIHNpemVfdCBzaXplLAo+IMKgCWlmICgh
cGFnZSkKPiDCoAkJcmV0dXJuIE5VTEw7Cj4gwqAKPiAtCWlmIChhdHRycyAmIERNQV9BVFRSX05P
X0tFUk5FTF9NQVBQSU5HKSB7Cj4gKwlpZiAoKGF0dHJzICYgRE1BX0FUVFJfTk9fS0VSTkVMX01B
UFBJTkcpICYmCj4gKwnCoMKgwqDCoCFmb3JjZV9kbWFfdW5lbmNyeXB0ZWQoZGV2KSkgewo+IMKg
CQkvKiByZW1vdmUgYW55IGRpcnR5IGNhY2hlIGxpbmVzIG9uIHRoZSBrZXJuZWwgYWxpYXMgKi8K
PiDCoAkJaWYgKCFQYWdlSGlnaE1lbShwYWdlKSkKPiDCoAkJCWFyY2hfZG1hX3ByZXBfY29oZXJl
bnQocGFnZSwgc2l6ZSk7Cj4gwqAJCS8qIHJldHVybiB0aGUgcGFnZSBwb2ludGVyIGFzIHRoZSBv
cGFxdWUgY29va2llICovCj4gKwkJKmRtYV9oYW5kbGUgPSBwaHlzX3RvX2RtYShkZXYsIHBhZ2Vf
dG9fcGh5cyhwYWdlKSk7CgpJIHdvdWxkIHN1Z2dlc3QgdG8gcGxhY2UgdGhpcyBsaW5lIGFib3Zl
IHRoZSBjb21tZW50LCBhcyB0aGUgY29tbWVudApvbmx5IHJlYWxseSBhcHBsaWVzIHRvIHRoZSBy
ZXR1cm4gdmFsdWUuIE90aGVyIHRoYW4gdGhpcyBuaXRwaWNrLCB0aGlzCm1hdGNoZXMgbXkgdW5k
ZXJzdGFuZGluZyBvZiB0aGUgcmVxdWlyZWQgY2hhbmdlcywgc286CgpSZXZpZXdlZC1ieTogTHVj
YXMgU3RhY2ggPGwuc3RhY2hAcGVuZ3V0cm9uaXguZGU+CgoKPiDCoAkJcmV0dXJuIHBhZ2U7Cj4g
wqAJfQo+IMKgCj4gQEAgLTE3OCw3ICsxODAsOCBAQCB2b2lkIGRtYV9kaXJlY3RfZnJlZV9wYWdl
cyhzdHJ1Y3QgZGV2aWNlICpkZXYsIHNpemVfdCBzaXplLCB2b2lkICpjcHVfYWRkciwKPiDCoHsK
PiDCoAl1bnNpZ25lZCBpbnQgcGFnZV9vcmRlciA9IGdldF9vcmRlcihzaXplKTsKPiDCoAo+IC0J
aWYgKGF0dHJzICYgRE1BX0FUVFJfTk9fS0VSTkVMX01BUFBJTkcpIHsKPiArCWlmICgoYXR0cnMg
JiBETUFfQVRUUl9OT19LRVJORUxfTUFQUElORykgJiYKPiArCcKgwqDCoMKgIWZvcmNlX2RtYV91
bmVuY3J5cHRlZChkZXYpKSB7Cj4gwqAJCS8qIGNwdV9hZGRyIGlzIGEgc3RydWN0IHBhZ2UgY29v
a2llLCBub3QgYSBrZXJuZWwgYWRkcmVzcyAqLwo+IMKgCQlfX2RtYV9kaXJlY3RfZnJlZV9wYWdl
cyhkZXYsIHNpemUsIGNwdV9hZGRyKTsKPiDCoAkJcmV0dXJuOwpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlz
dHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3Jn
L21haWxtYW4vbGlzdGluZm8vaW9tbXU=
