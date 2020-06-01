Return-Path: <SRS0=mWFx=7O=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8BC3C433E0
	for <iommu@archiver.kernel.org>; Mon,  1 Jun 2020 22:42:00 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8B742076B
	for <iommu@archiver.kernel.org>; Mon,  1 Jun 2020 22:41:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="PIcYkU+h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8B742076B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 9564285A5A;
	Mon,  1 Jun 2020 22:41:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nSwqLMqhuzr1; Mon,  1 Jun 2020 22:41:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 68A748574A;
	Mon,  1 Jun 2020 22:41:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 49493C0178;
	Mon,  1 Jun 2020 22:41:58 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D1C23C0176
 for <iommu@lists.linux-foundation.org>; Mon,  1 Jun 2020 22:41:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id C0D9B87860
 for <iommu@lists.linux-foundation.org>; Mon,  1 Jun 2020 22:41:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YY9NGPn0eyMd for <iommu@lists.linux-foundation.org>;
 Mon,  1 Jun 2020 22:41:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 14BD78783F
 for <iommu@lists.linux-foundation.org>; Mon,  1 Jun 2020 22:41:56 +0000 (UTC)
Received: from localhost (mobile-166-175-190-200.mycingular.net
 [166.175.190.200])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 5E6EB2054F;
 Mon,  1 Jun 2020 22:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1591051315;
 bh=4F8oMtoJEn7cRi6K3anCXx2Ba1M2zTlRhq8VCfHkgS8=;
 h=Date:From:To:Cc:Subject:In-Reply-To:From;
 b=PIcYkU+hKADLakAdTD5EGrqWronIlkWSQYseQF8lkznESRa/sMQp2J7tSWyPHQDtF
 5ITmAKC7jI8iHZbv4hQwD45BAYuto93jMqe3IHV7vdGdI9aL/AVhNlmR1UhB+DxjOX
 99LfJlJAAKgfsrp5J5gyM2us3+OVHENxJOvmOiII=
Date: Mon, 1 Jun 2020 17:41:54 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH] PCI: Relax ACS requirement for Intel RCiEP devices.
Message-ID: <20200601224154.GA769388@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200601155655.1519bc86@x1.home>
Cc: "Raj, Ashok" <ashok.raj@intel.com>,
 Darrel Goeddel <DGoeddel@forcepoint.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Mark Scott <mscott@forcepoint.com>, Romil Sharma <rsharma@forcepoint.com>,
 Bjorn Helgaas <bhelgaas@google.com>
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

T24gTW9uLCBKdW4gMDEsIDIwMjAgYXQgMDM6NTY6NTVQTSAtMDYwMCwgQWxleCBXaWxsaWFtc29u
IHdyb3RlOgo+IE9uIE1vbiwgMSBKdW4gMjAyMCAxNDo0MDoyMyAtMDcwMAo+ICJSYWosIEFzaG9r
IiA8YXNob2sucmFqQGludGVsLmNvbT4gd3JvdGU6Cj4gCj4gPiBPbiBNb24sIEp1biAwMSwgMjAy
MCBhdCAwNDoyNToxOVBNIC0wNTAwLCBCam9ybiBIZWxnYWFzIHdyb3RlOgo+ID4gPiBPbiBUaHUs
IE1heSAyOCwgMjAyMCBhdCAwMTo1Nzo0MlBNIC0wNzAwLCBBc2hvayBSYWogd3JvdGU6ICAKPiA+
ID4gPiBBbGwgSW50ZWwgcGxhdGZvcm1zIGd1YXJhbnRlZSB0aGF0IGFsbCByb290IGNvbXBsZXgg
aW1wbGVtZW50YXRpb25zCj4gPiA+ID4gbXVzdCBzZW5kIHRyYW5zYWN0aW9ucyB1cCB0byBJT01N
VSBmb3IgYWRkcmVzcyB0cmFuc2xhdGlvbnMuIEhlbmNlIGZvcgo+ID4gPiA+IFJDaUVQIGRldmlj
ZXMgdGhhdCBhcmUgVmVuZG9yIElEIEludGVsLCBjYW4gY2xhaW0gZXhjZXB0aW9uIGZvciBsYWNr
IG9mCj4gPiA+ID4gQUNTIHN1cHBvcnQuCj4gPiA+ID4gCj4gPiA+ID4gCj4gPiA+ID4gMy4xNiBS
b290LUNvbXBsZXggUGVlciB0byBQZWVyIENvbnNpZGVyYXRpb25zCj4gPiA+ID4gV2hlbiBETUEg
cmVtYXBwaW5nIGlzIGVuYWJsZWQsIHBlZXItdG8tcGVlciByZXF1ZXN0cyB0aHJvdWdoIHRoZQo+
ID4gPiA+IFJvb3QtQ29tcGxleCBtdXN0IGJlIGhhbmRsZWQKPiA+ID4gPiBhcyBmb2xsb3dzOgo+
ID4gPiA+IOKAoiBUaGUgaW5wdXQgYWRkcmVzcyBpbiB0aGUgcmVxdWVzdCBpcyB0cmFuc2xhdGVk
ICh0aHJvdWdoIGZpcnN0LWxldmVsLAo+ID4gPiA+ICAgc2Vjb25kLWxldmVsIG9yIG5lc3RlZCB0
cmFuc2xhdGlvbikgdG8gYSBob3N0IHBoeXNpY2FsIGFkZHJlc3MgKEhQQSkuCj4gPiA+ID4gICBU
aGUgYWRkcmVzcyBkZWNvZGluZyBmb3IgcGVlciBhZGRyZXNzZXMgbXVzdCBiZSBkb25lIG9ubHkg
b24gdGhlCj4gPiA+ID4gICB0cmFuc2xhdGVkIEhQQS4gSGFyZHdhcmUgaW1wbGVtZW50YXRpb25z
IGFyZSBmcmVlIHRvIGZ1cnRoZXIgbGltaXQKPiA+ID4gPiAgIHBlZXItdG8tcGVlciBhY2Nlc3Nl
cyB0byBzcGVjaWZpYyBob3N0IHBoeXNpY2FsIGFkZHJlc3MgcmVnaW9ucwo+ID4gPiA+ICAgKG9y
IHRvIGNvbXBsZXRlbHkgZGlzYWxsb3cgcGVlci1mb3J3YXJkaW5nIG9mIHRyYW5zbGF0ZWQgcmVx
dWVzdHMpLgo+ID4gPiA+IOKAoiBTaW5jZSBhZGRyZXNzIHRyYW5zbGF0aW9uIGNoYW5nZXMgdGhl
IGNvbnRlbnRzIChhZGRyZXNzIGZpZWxkKSBvZgo+ID4gPiA+ICAgdGhlIFBDSSBFeHByZXNzIFRy
YW5zYWN0aW9uIExheWVyIFBhY2tldCAoVExQKSwgZm9yIFBDSSBFeHByZXNzCj4gPiA+ID4gICBw
ZWVyLXRvLXBlZXIgcmVxdWVzdHMgd2l0aCBFQ1JDLCB0aGUgUm9vdC1Db21wbGV4IGhhcmR3YXJl
IG11c3QgdXNlCj4gPiA+ID4gICB0aGUgbmV3IEVDUkMgKHJlLWNvbXB1dGVkIHdpdGggdGhlIHRy
YW5zbGF0ZWQgYWRkcmVzcykgaWYgaXQKPiA+ID4gPiAgIGRlY2lkZXMgdG8gZm9yd2FyZCB0aGUg
VExQIGFzIGEgcGVlciByZXF1ZXN0Lgo+ID4gPiA+IOKAoiBSb290LXBvcnRzLCBhbmQgbXVsdGkt
ZnVuY3Rpb24gcm9vdC1jb21wbGV4IGludGVncmF0ZWQgZW5kcG9pbnRzLCBtYXkKPiA+ID4gPiAg
IHN1cHBvcnQgYWRkaXRpb25hbCBwZWVydG8tcGVlciBjb250cm9sIGZlYXR1cmVzIGJ5IHN1cHBv
cnRpbmcgUENJIEV4cHJlc3MKPiA+ID4gPiAgIEFjY2VzcyBDb250cm9sIFNlcnZpY2VzIChBQ1Mp
IGNhcGFiaWxpdHkuIFJlZmVyIHRvIEFDUyBjYXBhYmlsaXR5IGluCj4gPiA+ID4gICBQQ0kgRXhw
cmVzcyBzcGVjaWZpY2F0aW9ucyBmb3IgZGV0YWlscy4KPiA+ID4gPiAKPiA+ID4gPiBTaW5jZSBM
aW51eCBkaWRuJ3QgZ2l2ZSBzcGVjaWFsIHRyZWF0bWVudCB0byBhbGxvdyB0aGlzIGV4Y2VwdGlv
biwgY2VydGFpbgo+ID4gPiA+IFJDaUVQIE1GRCBkZXZpY2VzIGFyZSBnZXR0aW5nIGdyb3VwZWQg
aW4gYSBzaW5nbGUgaW9tbXUgZ3JvdXAuIFRoaXMKPiA+ID4gPiBkb2Vzbid0IHBlcm1pdCBhIHNp
bmdsZSBkZXZpY2UgdG8gYmUgYXNzaWduZWQgdG8gYSBndWVzdCBmb3IgaW5zdGFuY2UuCj4gPiA+
ID4gCj4gPiA+ID4gSW4gb25lIHZlbmRvciBzeXN0ZW06IERldmljZSAxNC54IHdlcmUgZ3JvdXBl
ZCBpbiBhIHNpbmdsZSBJT01NVSBncm91cC4KPiA+ID4gPiAKPiA+ID4gPiAvc3lzL2tlcm5lbC9p
b21tdV9ncm91cHMvNS9kZXZpY2VzLzAwMDA6MDA6MTQuMAo+ID4gPiA+IC9zeXMva2VybmVsL2lv
bW11X2dyb3Vwcy81L2RldmljZXMvMDAwMDowMDoxNC4yCj4gPiA+ID4gL3N5cy9rZXJuZWwvaW9t
bXVfZ3JvdXBzLzUvZGV2aWNlcy8wMDAwOjAwOjE0LjMKPiA+ID4gPiAKPiA+ID4gPiBBZnRlciB0
aGUgcGF0Y2g6Cj4gPiA+ID4gL3N5cy9rZXJuZWwvaW9tbXVfZ3JvdXBzLzUvZGV2aWNlcy8wMDAw
OjAwOjE0LjAKPiA+ID4gPiAvc3lzL2tlcm5lbC9pb21tdV9ncm91cHMvNS9kZXZpY2VzLzAwMDA6
MDA6MTQuMgo+ID4gPiA+IC9zeXMva2VybmVsL2lvbW11X2dyb3Vwcy82L2RldmljZXMvMDAwMDow
MDoxNC4zIDw8PCBuZXcgZ3JvdXAKPiA+ID4gPiAKPiA+ID4gPiAxNC4wIGFuZCAxNC4yIGFyZSBp
bnRlZ3JhdGVkIGRldmljZXMsIGJ1dCBsZWdhY3kgZW5kIHBvaW50cy4KPiA+ID4gPiBXaGVyZWFz
IDE0LjMgd2FzIGEgUENJZSBjb21wbGlhbnQgUkNpRVAuCj4gPiA+ID4gCj4gPiA+ID4gMDA6MTQu
MyBOZXR3b3JrIGNvbnRyb2xsZXI6IEludGVsIENvcnBvcmF0aW9uIERldmljZSA5ZGYwIChyZXYg
MzApCj4gPiA+ID4gQ2FwYWJpbGl0aWVzOiBbNDBdIEV4cHJlc3MgKHYyKSBSb290IENvbXBsZXgg
SW50ZWdyYXRlZCBFbmRwb2ludCwgTVNJIDAwCj4gPiA+ID4gCj4gPiA+ID4gVGhpcyBwZXJtaXRz
IGFzc2lnbmluZyB0aGlzIGRldmljZSB0byBhIGd1ZXN0IFZNLgo+ID4gPiA+IAo+ID4gPiA+IEZp
eGVzOiBmMDk2YzA2MWY1NTIgKCJpb21tdTogUmV3b3JrIGlvbW11X2dyb3VwX2dldF9mb3JfcGNp
X2RldigpIikKPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBBc2hvayBSYWogPGFzaG9rLnJhakBpbnRl
bC5jb20+Cj4gPiA+ID4gVG86IEpvZXJnIFJvZWRlbCA8am9yb0A4Ynl0ZXMub3JnPgo+ID4gPiA+
IFRvOiBCam9ybiBIZWxnYWFzIDxiaGVsZ2Fhc0Bnb29nbGUuY29tPgo+ID4gPiA+IENjOiBsaW51
eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnCj4gPiA+ID4gQ2M6IGlvbW11QGxpc3RzLmxpbnV4LWZv
dW5kYXRpb24ub3JnCj4gPiA+ID4gQ2M6IEx1IEJhb2x1IDxiYW9sdS5sdUBsaW51eC5pbnRlbC5j
b20+Cj4gPiA+ID4gQ2M6IEFsZXggV2lsbGlhbXNvbiA8YWxleC53aWxsaWFtc29uQHJlZGhhdC5j
b20+Cj4gPiA+ID4gQ2M6IERhcnJlbCBHb2VkZGVsIDxER29lZGRlbEBmb3JjZXBvaW50LmNvbT4K
PiA+ID4gPiBDYzogTWFyayBTY290dCA8bXNjb3R0QGZvcmNlcG9pbnQuY29tPiwKPiA+ID4gPiBD
YzogUm9taWwgU2hhcm1hIDxyc2hhcm1hQGZvcmNlcG9pbnQuY29tPgo+ID4gPiA+IENjOiBBc2hv
ayBSYWogPGFzaG9rLnJhakBpbnRlbC5jb20+ICAKPiA+ID4gCj4gPiA+IFRlbnRhdGl2ZWx5IGFw
cGxpZWQgdG8gcGNpL3ZpcnR1YWxpemF0aW9uIGZvciB2NS44LCB0aGFua3MhCj4gPiA+IAo+ID4g
PiBUaGUgc3BlYyBzYXlzIHRoaXMgaGFuZGxpbmcgbXVzdCBhcHBseSAid2hlbiBETUEgcmVtYXBw
aW5nIGlzCj4gPiA+IGVuYWJsZWQiLiAgVGhlIHBhdGNoIGRvZXMgbm90IGNoZWNrIHdoZXRoZXIg
RE1BIHJlbWFwcGluZyBpcyBlbmFibGVkLgo+ID4gPiAKPiA+ID4gSXMgdGhlcmUgYW55IGNhc2Ug
d2hlcmUgRE1BIHJlbWFwcGluZyBpcyAqbm90KiBlbmFibGVkLCBhbmQgd2UgcmVseSBvbgo+ID4g
PiB0aGlzIHBhdGNoIHRvIHRlbGwgdXMgd2hldGhlciB0aGUgZGV2aWNlIGlzIGlzb2xhdGVkPyAg
SXQgc291bmRzIGxpa2UKPiA+ID4gaXQgbWF5IGdpdmUgdGhlIHdyb25nIGFuc3dlciBpbiBzdWNo
IGEgY2FzZT8KPiA+ID4gCj4gPiA+IENhbiB5b3UgY29uZmlybSB0aGF0IEkgZG9uJ3QgbmVlZCB0
byB3b3JyeSBhYm91dCB0aGlzPyAgICAKPiA+IAo+ID4gSSB0aGluayBhbGwgb2YgdGhpcyBtYWtl
cyBzZW5zZSBvbmx5IHdoZW4gRE1BIHJlbWFwcGluZyBpcyBlbmFibGVkLgo+ID4gT3RoZXJ3aXNl
IHRoZXJlIGlzIG5vIGVuZm9yY2VtZW50IGZvciBpc29sYXRpb24uIAo+IAo+IFllcCwgd2l0aG91
dCBhbiBJT01NVSBhbGwgZGV2aWNlcyBvcGVyYXRlIGluIHRoZSBzYW1lIElPVkEgc3BhY2UgYW5k
IHdlCj4gaGF2ZSBubyBpc29sYXRpb24uICBXZSBvbmx5IGVuYWJsZSBBQ1Mgd2hlbiBhbiBJT01N
VSBkcml2ZXIgcmVxdWVzdHMgaXQKPiBhbmQgaXQncyBvbmx5IHVzZWQgYnkgSU9NTVUgY29kZSB0
byBkZXRlcm1pbmUgSU9NTVUgZ3JvdXBpbmcgb2YKPiBkZXZpY2VzLiAgVGhhbmtzLAoKVGhhbmtz
LCBBc2hvayBhbmQgQWxleC4gIEkgd2lzaCBpdCB3ZXJlIG1vcmUgb2J2aW91cyBmcm9tIHRoZSBj
b2RlLApidXQgSSBhbSByZWFzc3VyZWQuCgpJIGFsc28gYWRkZWQgYSBzdGFibGUgdGFnIHRvIGhl
bHAgZ2V0IHRoaXMgYmFja3BvcnRlZC4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5k
YXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2lvbW11
