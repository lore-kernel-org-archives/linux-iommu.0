Return-Path: <SRS0=4TkS=7K=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15E59C433E0
	for <iommu@archiver.kernel.org>; Thu, 28 May 2020 21:54:24 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACA78206F1
	for <iommu@archiver.kernel.org>; Thu, 28 May 2020 21:54:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACA78206F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 82BE18721A;
	Thu, 28 May 2020 21:54:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NMHGIa7vs_eP; Thu, 28 May 2020 21:54:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id BA2EA8714E;
	Thu, 28 May 2020 21:54:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AB83DC07FF;
	Thu, 28 May 2020 21:54:22 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 43BC2C016F
 for <iommu@lists.linux-foundation.org>; Thu, 28 May 2020 21:54:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 2A8A6871E1
 for <iommu@lists.linux-foundation.org>; Thu, 28 May 2020 21:54:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GUDaOQDvZzRn for <iommu@lists.linux-foundation.org>;
 Thu, 28 May 2020 21:54:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 078598714E
 for <iommu@lists.linux-foundation.org>; Thu, 28 May 2020 21:54:19 +0000 (UTC)
IronPort-SDR: g5ZLcFqsPajsndWRq0XNxZtMr1M5obSWHGUT8aoeMN63vNEnr/FbuRsGC+tJjHfVmDvjxEfUQe
 cMr8Ihwr9oAQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 May 2020 14:54:19 -0700
IronPort-SDR: eO+Kl9oDStjHmcS70yoy4o+yy64ToFP18+zRaQYBdY1tP9NOd2yExlkgOb/XN5teEyzh5kvODQ
 imGIuX5A4rvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,446,1583222400"; d="scan'208";a="469288930"
Received: from ssp-nc-cdi361.jf.intel.com (HELO otc-nc-03) ([10.54.39.25])
 by fmsmga006.fm.intel.com with ESMTP; 28 May 2020 14:54:18 -0700
Date: Thu, 28 May 2020 14:54:18 -0700
From: "Raj, Ashok" <ashok.raj@intel.com>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH] PCI: Relax ACS requirement for Intel RCiEP devices.
Message-ID: <20200528215418.GA7173@otc-nc-03>
References: <1590699462-7131-1-git-send-email-ashok.raj@intel.com>
 <20200528153826.257a0145@x1.home>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200528153826.257a0145@x1.home>
User-Agent: Mutt/1.5.24 (2015-08-30)
Cc: Ashok Raj <ashok.raj@intel.com>, Darrel Goeddel <DGoeddel@forcepoint.com>,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Mark Scott <mscott@forcepoint.com>,
 Romil Sharma <rsharma@forcepoint.com>, Bjorn Helgaas <bhelgaas@google.com>
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

T24gVGh1LCBNYXkgMjgsIDIwMjAgYXQgMDM6Mzg6MjZQTSAtMDYwMCwgQWxleCBXaWxsaWFtc29u
IHdyb3RlOgo+IE9uIFRodSwgMjggTWF5IDIwMjAgMTM6NTc6NDIgLTA3MDAKPiBBc2hvayBSYWog
PGFzaG9rLnJhakBpbnRlbC5jb20+IHdyb3RlOgo+IAo+ID4gQWxsIEludGVsIHBsYXRmb3JtcyBn
dWFyYW50ZWUgdGhhdCBhbGwgcm9vdCBjb21wbGV4IGltcGxlbWVudGF0aW9ucwo+ID4gbXVzdCBz
ZW5kIHRyYW5zYWN0aW9ucyB1cCB0byBJT01NVSBmb3IgYWRkcmVzcyB0cmFuc2xhdGlvbnMuIEhl
bmNlIGZvcgo+ID4gUkNpRVAgZGV2aWNlcyB0aGF0IGFyZSBWZW5kb3IgSUQgSW50ZWwsIGNhbiBj
bGFpbSBleGNlcHRpb24gZm9yIGxhY2sgb2YKPiA+IEFDUyBzdXBwb3J0Lgo+ID4gCj4gPiAKPiA+
IDMuMTYgUm9vdC1Db21wbGV4IFBlZXIgdG8gUGVlciBDb25zaWRlcmF0aW9ucwo+ID4gV2hlbiBE
TUEgcmVtYXBwaW5nIGlzIGVuYWJsZWQsIHBlZXItdG8tcGVlciByZXF1ZXN0cyB0aHJvdWdoIHRo
ZQo+ID4gUm9vdC1Db21wbGV4IG11c3QgYmUgaGFuZGxlZAo+ID4gYXMgZm9sbG93czoKPiA+IOKA
oiBUaGUgaW5wdXQgYWRkcmVzcyBpbiB0aGUgcmVxdWVzdCBpcyB0cmFuc2xhdGVkICh0aHJvdWdo
IGZpcnN0LWxldmVsLAo+ID4gICBzZWNvbmQtbGV2ZWwgb3IgbmVzdGVkIHRyYW5zbGF0aW9uKSB0
byBhIGhvc3QgcGh5c2ljYWwgYWRkcmVzcyAoSFBBKS4KPiA+ICAgVGhlIGFkZHJlc3MgZGVjb2Rp
bmcgZm9yIHBlZXIgYWRkcmVzc2VzIG11c3QgYmUgZG9uZSBvbmx5IG9uIHRoZQo+ID4gICB0cmFu
c2xhdGVkIEhQQS4gSGFyZHdhcmUgaW1wbGVtZW50YXRpb25zIGFyZSBmcmVlIHRvIGZ1cnRoZXIg
bGltaXQKPiA+ICAgcGVlci10by1wZWVyIGFjY2Vzc2VzIHRvIHNwZWNpZmljIGhvc3QgcGh5c2lj
YWwgYWRkcmVzcyByZWdpb25zCj4gPiAgIChvciB0byBjb21wbGV0ZWx5IGRpc2FsbG93IHBlZXIt
Zm9yd2FyZGluZyBvZiB0cmFuc2xhdGVkIHJlcXVlc3RzKS4KPiA+IOKAoiBTaW5jZSBhZGRyZXNz
IHRyYW5zbGF0aW9uIGNoYW5nZXMgdGhlIGNvbnRlbnRzIChhZGRyZXNzIGZpZWxkKSBvZgo+ID4g
ICB0aGUgUENJIEV4cHJlc3MgVHJhbnNhY3Rpb24gTGF5ZXIgUGFja2V0IChUTFApLCBmb3IgUENJ
IEV4cHJlc3MKPiA+ICAgcGVlci10by1wZWVyIHJlcXVlc3RzIHdpdGggRUNSQywgdGhlIFJvb3Qt
Q29tcGxleCBoYXJkd2FyZSBtdXN0IHVzZQo+ID4gICB0aGUgbmV3IEVDUkMgKHJlLWNvbXB1dGVk
IHdpdGggdGhlIHRyYW5zbGF0ZWQgYWRkcmVzcykgaWYgaXQKPiA+ICAgZGVjaWRlcyB0byBmb3J3
YXJkIHRoZSBUTFAgYXMgYSBwZWVyIHJlcXVlc3QuCj4gPiDigKIgUm9vdC1wb3J0cywgYW5kIG11
bHRpLWZ1bmN0aW9uIHJvb3QtY29tcGxleCBpbnRlZ3JhdGVkIGVuZHBvaW50cywgbWF5Cj4gPiAg
IHN1cHBvcnQgYWRkaXRpb25hbCBwZWVydG8tcGVlciBjb250cm9sIGZlYXR1cmVzIGJ5IHN1cHBv
cnRpbmcgUENJIEV4cHJlc3MKPiA+ICAgQWNjZXNzIENvbnRyb2wgU2VydmljZXMgKEFDUykgY2Fw
YWJpbGl0eS4gUmVmZXIgdG8gQUNTIGNhcGFiaWxpdHkgaW4KPiA+ICAgUENJIEV4cHJlc3Mgc3Bl
Y2lmaWNhdGlvbnMgZm9yIGRldGFpbHMuCj4gPiAKPiA+IFNpbmNlIExpbnV4IGRpZG4ndCBnaXZl
IHNwZWNpYWwgdHJlYXRtZW50IHRvIGFsbG93IHRoaXMgZXhjZXB0aW9uLCBjZXJ0YWluCj4gPiBS
Q2lFUCBNRkQgZGV2aWNlcyBhcmUgZ2V0dGluZyBncm91cGVkIGluIGEgc2luZ2xlIGlvbW11IGdy
b3VwLiBUaGlzCj4gPiBkb2Vzbid0IHBlcm1pdCBhIHNpbmdsZSBkZXZpY2UgdG8gYmUgYXNzaWdu
ZWQgdG8gYSBndWVzdCBmb3IgaW5zdGFuY2UuCj4gPiAKPiA+IEluIG9uZSB2ZW5kb3Igc3lzdGVt
OiBEZXZpY2UgMTQueCB3ZXJlIGdyb3VwZWQgaW4gYSBzaW5nbGUgSU9NTVUgZ3JvdXAuCj4gPiAK
PiA+IC9zeXMva2VybmVsL2lvbW11X2dyb3Vwcy81L2RldmljZXMvMDAwMDowMDoxNC4wCj4gPiAv
c3lzL2tlcm5lbC9pb21tdV9ncm91cHMvNS9kZXZpY2VzLzAwMDA6MDA6MTQuMgo+ID4gL3N5cy9r
ZXJuZWwvaW9tbXVfZ3JvdXBzLzUvZGV2aWNlcy8wMDAwOjAwOjE0LjMKPiA+IAo+ID4gQWZ0ZXIg
dGhlIHBhdGNoOgo+ID4gL3N5cy9rZXJuZWwvaW9tbXVfZ3JvdXBzLzUvZGV2aWNlcy8wMDAwOjAw
OjE0LjAKPiA+IC9zeXMva2VybmVsL2lvbW11X2dyb3Vwcy81L2RldmljZXMvMDAwMDowMDoxNC4y
Cj4gPiAvc3lzL2tlcm5lbC9pb21tdV9ncm91cHMvNi9kZXZpY2VzLzAwMDA6MDA6MTQuMyA8PDwg
bmV3IGdyb3VwCj4gPiAKPiA+IDE0LjAgYW5kIDE0LjIgYXJlIGludGVncmF0ZWQgZGV2aWNlcywg
YnV0IGxlZ2FjeSBlbmQgcG9pbnRzLgo+ID4gV2hlcmVhcyAxNC4zIHdhcyBhIFBDSWUgY29tcGxp
YW50IFJDaUVQLgo+ID4gCj4gPiAwMDoxNC4zIE5ldHdvcmsgY29udHJvbGxlcjogSW50ZWwgQ29y
cG9yYXRpb24gRGV2aWNlIDlkZjAgKHJldiAzMCkKPiA+IENhcGFiaWxpdGllczogWzQwXSBFeHBy
ZXNzICh2MikgUm9vdCBDb21wbGV4IEludGVncmF0ZWQgRW5kcG9pbnQsIE1TSSAwMAo+ID4gCj4g
PiBUaGlzIHBlcm1pdHMgYXNzaWduaW5nIHRoaXMgZGV2aWNlIHRvIGEgZ3Vlc3QgVk0uCj4gPiAK
PiA+IEZpeGVzOiBmMDk2YzA2MWY1NTIgKCJpb21tdTogUmV3b3JrIGlvbW11X2dyb3VwX2dldF9m
b3JfcGNpX2RldigpIikKPiAKPiBJIGRvbid0IHJlYWxseSB1bmRlcnN0YW5kIHRoaXMgRml4ZXMg
dGFnLiAgVGhpcyBzZWVtcyBsaWtlIGEgZmVhdHVyZSwKPiBub3QgYSBmaXguICBJZiB5b3Ugd2Fu
dCBpdCBpbiBzdGFibGUgcmVsZWFzZXMgYXMgYSBmZWF0dXJlLCByZXF1ZXN0IGl0Cj4gdmlhIENj
OiBzdGFibGVAdmdlci5rZXJuZWwub3JnLiAgSSdkIGRyb3AgdGhhdCB0YWcsIHRoYXQncyBteSBu
aXQuCj4gT3RoZXJ3aXNlOgoKWWVzLCBpIHNob3VsZCBoYXZlIENjZWQgU3RhYmxlIGluc3RlYWQu
IAoKQmpvcm46IENhbiB5b3UgbWFzc2FnZSB0aGlzIGluPyBvciBpIGNhbiByZXNlbmQgd2l0aCBB
bGV4J3MgUmV2aWV3ZWQtYnkgKwphZGRpbmcgc3RhYmxlIGluIGNjIGxpc3QuCgo+IAo+IFJldmll
d2VkLWJ5OiBBbGV4IFdpbGxpYW1zb24gPGFsZXgud2lsbGlhbXNvbkByZWRoYXQuY29tPgo+IAo+
ID4gU2lnbmVkLW9mZi1ieTogQXNob2sgUmFqIDxhc2hvay5yYWpAaW50ZWwuY29tPgo+ID4gVG86
IEpvZXJnIFJvZWRlbCA8am9yb0A4Ynl0ZXMub3JnPgo+ID4gVG86IEJqb3JuIEhlbGdhYXMgPGJo
ZWxnYWFzQGdvb2dsZS5jb20+Cj4gPiBDYzogbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZwo+
ID4gQ2M6IGlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCj4gPiBDYzogTHUgQmFvbHUg
PGJhb2x1Lmx1QGxpbnV4LmludGVsLmNvbT4KPiA+IENjOiBBbGV4IFdpbGxpYW1zb24gPGFsZXgu
d2lsbGlhbXNvbkByZWRoYXQuY29tPgo+ID4gQ2M6IERhcnJlbCBHb2VkZGVsIDxER29lZGRlbEBm
b3JjZXBvaW50LmNvbT4KPiA+IENjOiBNYXJrIFNjb3R0IDxtc2NvdHRAZm9yY2Vwb2ludC5jb20+
LAo+ID4gQ2M6IFJvbWlsIFNoYXJtYSA8cnNoYXJtYUBmb3JjZXBvaW50LmNvbT4KPiA+IENjOiBB
c2hvayBSYWogPGFzaG9rLnJhakBpbnRlbC5jb20+Cj4gPiAtLS0KPiA+IHYyOiBNb3ZlZCBmdW5j
dGlvbmFsaXR5IGZyb20gaW9tbXUgdG8gcGNpIHF1aXJrcyAtIEFsZXggV2lsbGlhbXNvbgo+ID4g
Cj4gPiAgZHJpdmVycy9wY2kvcXVpcmtzLmMgfCAxNSArKysrKysrKysrKysrKysKPiA+ICAxIGZp
bGUgY2hhbmdlZCwgMTUgaW5zZXJ0aW9ucygrKQo+ID4gCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9wY2kvcXVpcmtzLmMgYi9kcml2ZXJzL3BjaS9xdWlya3MuYwo+ID4gaW5kZXggMjhjOWEyNDA5
YzUwLi42MzM3M2NhMGEzZmUgMTAwNjQ0Cj4gPiAtLS0gYS9kcml2ZXJzL3BjaS9xdWlya3MuYwo+
ID4gKysrIGIvZHJpdmVycy9wY2kvcXVpcmtzLmMKPiA+IEBAIC00NjgyLDYgKzQ2ODIsMjAgQEAg
c3RhdGljIGludCBwY2lfcXVpcmtfbWZfZW5kcG9pbnRfYWNzKHN0cnVjdCBwY2lfZGV2ICpkZXYs
IHUxNiBhY3NfZmxhZ3MpCj4gPiAgCQlQQ0lfQUNTX0NSIHwgUENJX0FDU19VRiB8IFBDSV9BQ1Nf
RFQpOwo+ID4gIH0KPiA+ICAKPiA+ICtzdGF0aWMgaW50IHBjaV9xdWlya19yY2llcF9hY3Moc3Ry
dWN0IHBjaV9kZXYgKmRldiwgdTE2IGFjc19mbGFncykKPiA+ICt7Cj4gPiArCS8qCj4gPiArCSAq
IFJDaUVQJ3MgYXJlIHJlcXVpcmVkIHRvIGFsbG93IHAycCBvbmx5IG9uIHRyYW5zbGF0ZWQgYWRk
cmVzc2VzLgo+ID4gKwkgKiBSZWZlciB0byBJbnRlbCBWVC1kIHNwZWNpZmljYXRpb24gU2VjdGlv
biAzLjE2IFJvb3QtQ29tcGxleCBQZWVyCj4gPiArCSAqIHRvIFBlZXIgQ29uc2lkZXJhdGlvbnMK
PiA+ICsJICovCj4gPiArCWlmIChwY2lfcGNpZV90eXBlKGRldikgIT0gUENJX0VYUF9UWVBFX1JD
X0VORCkKPiA+ICsJCXJldHVybiAtRU5PVFRZOwo+ID4gKwo+ID4gKwlyZXR1cm4gcGNpX2Fjc19j
dHJsX2VuYWJsZWQoYWNzX2ZsYWdzLAo+ID4gKwkJUENJX0FDU19TViB8IFBDSV9BQ1NfUlIgfCBQ
Q0lfQUNTX0NSIHwgUENJX0FDU19VRik7Cj4gPiArfQo+ID4gKwo+ID4gIHN0YXRpYyBpbnQgcGNp
X3F1aXJrX2JyY21fYWNzKHN0cnVjdCBwY2lfZGV2ICpkZXYsIHUxNiBhY3NfZmxhZ3MpCj4gPiAg
ewo+ID4gIAkvKgo+ID4gQEAgLTQ3NjQsNiArNDc3OCw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3Qg
cGNpX2Rldl9hY3NfZW5hYmxlZCB7Cj4gPiAgCS8qIEkyMTkgKi8KPiA+ICAJeyBQQ0lfVkVORE9S
X0lEX0lOVEVMLCAweDE1YjcsIHBjaV9xdWlya19tZl9lbmRwb2ludF9hY3MgfSwKPiA+ICAJeyBQ
Q0lfVkVORE9SX0lEX0lOVEVMLCAweDE1YjgsIHBjaV9xdWlya19tZl9lbmRwb2ludF9hY3MgfSwK
PiA+ICsJeyBQQ0lfVkVORE9SX0lEX0lOVEVMLCBQQ0lfQU5ZX0lELCBwY2lfcXVpcmtfcmNpZXBf
YWNzIH0sCj4gPiAgCS8qIFFDT00gUURGMnh4eCByb290IHBvcnRzICovCj4gPiAgCXsgUENJX1ZF
TkRPUl9JRF9RQ09NLCAweDA0MDAsIHBjaV9xdWlya19xY29tX3JwX2FjcyB9LAo+ID4gIAl7IFBD
SV9WRU5ET1JfSURfUUNPTSwgMHgwNDAxLCBwY2lfcXVpcmtfcWNvbV9ycF9hY3MgfSwKPiAKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGlu
ZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGlu
dXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
