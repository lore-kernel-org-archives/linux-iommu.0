Return-Path: <SRS0=mWFx=7O=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9161C433DF
	for <iommu@archiver.kernel.org>; Mon,  1 Jun 2020 21:57:08 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BE06207DF
	for <iommu@archiver.kernel.org>; Mon,  1 Jun 2020 21:57:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lt4r4pU8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BE06207DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 359C886BE1;
	Mon,  1 Jun 2020 21:57:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tzJUKYLFuQbu; Mon,  1 Jun 2020 21:57:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 52CEB86BCF;
	Mon,  1 Jun 2020 21:57:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 36086C088C;
	Mon,  1 Jun 2020 21:57:07 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F2808C0176
 for <iommu@lists.linux-foundation.org>; Mon,  1 Jun 2020 21:57:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id DA42087A39
 for <iommu@lists.linux-foundation.org>; Mon,  1 Jun 2020 21:57:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 25DdgHZFL+iu for <iommu@lists.linux-foundation.org>;
 Mon,  1 Jun 2020 21:57:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [205.139.110.120])
 by hemlock.osuosl.org (Postfix) with ESMTPS id ABADD8796D
 for <iommu@lists.linux-foundation.org>; Mon,  1 Jun 2020 21:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591048623;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+8x7s6vw7v2g1Fw/ZCFRr/iC2dQUap8Sq6pXb0oimto=;
 b=Lt4r4pU86tyonivHuZ0bWk3PIu4H3cFvqnEu1TvKYt1h7RCJNZKTiDrbGcmKu8oD5UmgQ4
 nefaOWpIcghovkUjrS8Ak+sKJklRrFwLEJLipuRsqL83tONde70awE8KjubyjjCIcp8Yma
 Pq1LRn8omjnF/TqiYe2M9Q60+/ntVLc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-38-128NCfkrMMyJcvUPflPFvg-1; Mon, 01 Jun 2020 17:56:59 -0400
X-MC-Unique: 128NCfkrMMyJcvUPflPFvg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 32C69100A8E7;
 Mon,  1 Jun 2020 21:56:57 +0000 (UTC)
Received: from x1.home (ovpn-112-195.phx2.redhat.com [10.3.112.195])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E137A19C4F;
 Mon,  1 Jun 2020 21:56:55 +0000 (UTC)
Date: Mon, 1 Jun 2020 15:56:55 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: "Raj, Ashok" <ashok.raj@intel.com>
Subject: Re: [PATCH] PCI: Relax ACS requirement for Intel RCiEP devices.
Message-ID: <20200601155655.1519bc86@x1.home>
In-Reply-To: <20200601214023.GA15310@otc-nc-03>
References: <1590699462-7131-1-git-send-email-ashok.raj@intel.com>
 <20200601212519.GA758937@bjorn-Precision-5520>
 <20200601214023.GA15310@otc-nc-03>
Organization: Red Hat
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Cc: Darrel Goeddel <DGoeddel@forcepoint.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Mark Scott <mscott@forcepoint.com>, Bjorn Helgaas <helgaas@kernel.org>,
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

T24gTW9uLCAxIEp1biAyMDIwIDE0OjQwOjIzIC0wNzAwCiJSYWosIEFzaG9rIiA8YXNob2sucmFq
QGludGVsLmNvbT4gd3JvdGU6Cgo+IE9uIE1vbiwgSnVuIDAxLCAyMDIwIGF0IDA0OjI1OjE5UE0g
LTA1MDAsIEJqb3JuIEhlbGdhYXMgd3JvdGU6Cj4gPiBPbiBUaHUsIE1heSAyOCwgMjAyMCBhdCAw
MTo1Nzo0MlBNIC0wNzAwLCBBc2hvayBSYWogd3JvdGU6ICAKPiA+ID4gQWxsIEludGVsIHBsYXRm
b3JtcyBndWFyYW50ZWUgdGhhdCBhbGwgcm9vdCBjb21wbGV4IGltcGxlbWVudGF0aW9ucwo+ID4g
PiBtdXN0IHNlbmQgdHJhbnNhY3Rpb25zIHVwIHRvIElPTU1VIGZvciBhZGRyZXNzIHRyYW5zbGF0
aW9ucy4gSGVuY2UgZm9yCj4gPiA+IFJDaUVQIGRldmljZXMgdGhhdCBhcmUgVmVuZG9yIElEIElu
dGVsLCBjYW4gY2xhaW0gZXhjZXB0aW9uIGZvciBsYWNrIG9mCj4gPiA+IEFDUyBzdXBwb3J0Lgo+
ID4gPiAKPiA+ID4gCj4gPiA+IDMuMTYgUm9vdC1Db21wbGV4IFBlZXIgdG8gUGVlciBDb25zaWRl
cmF0aW9ucwo+ID4gPiBXaGVuIERNQSByZW1hcHBpbmcgaXMgZW5hYmxlZCwgcGVlci10by1wZWVy
IHJlcXVlc3RzIHRocm91Z2ggdGhlCj4gPiA+IFJvb3QtQ29tcGxleCBtdXN0IGJlIGhhbmRsZWQK
PiA+ID4gYXMgZm9sbG93czoKPiA+ID4g4oCiIFRoZSBpbnB1dCBhZGRyZXNzIGluIHRoZSByZXF1
ZXN0IGlzIHRyYW5zbGF0ZWQgKHRocm91Z2ggZmlyc3QtbGV2ZWwsCj4gPiA+ICAgc2Vjb25kLWxl
dmVsIG9yIG5lc3RlZCB0cmFuc2xhdGlvbikgdG8gYSBob3N0IHBoeXNpY2FsIGFkZHJlc3MgKEhQ
QSkuCj4gPiA+ICAgVGhlIGFkZHJlc3MgZGVjb2RpbmcgZm9yIHBlZXIgYWRkcmVzc2VzIG11c3Qg
YmUgZG9uZSBvbmx5IG9uIHRoZQo+ID4gPiAgIHRyYW5zbGF0ZWQgSFBBLiBIYXJkd2FyZSBpbXBs
ZW1lbnRhdGlvbnMgYXJlIGZyZWUgdG8gZnVydGhlciBsaW1pdAo+ID4gPiAgIHBlZXItdG8tcGVl
ciBhY2Nlc3NlcyB0byBzcGVjaWZpYyBob3N0IHBoeXNpY2FsIGFkZHJlc3MgcmVnaW9ucwo+ID4g
PiAgIChvciB0byBjb21wbGV0ZWx5IGRpc2FsbG93IHBlZXItZm9yd2FyZGluZyBvZiB0cmFuc2xh
dGVkIHJlcXVlc3RzKS4KPiA+ID4g4oCiIFNpbmNlIGFkZHJlc3MgdHJhbnNsYXRpb24gY2hhbmdl
cyB0aGUgY29udGVudHMgKGFkZHJlc3MgZmllbGQpIG9mCj4gPiA+ICAgdGhlIFBDSSBFeHByZXNz
IFRyYW5zYWN0aW9uIExheWVyIFBhY2tldCAoVExQKSwgZm9yIFBDSSBFeHByZXNzCj4gPiA+ICAg
cGVlci10by1wZWVyIHJlcXVlc3RzIHdpdGggRUNSQywgdGhlIFJvb3QtQ29tcGxleCBoYXJkd2Fy
ZSBtdXN0IHVzZQo+ID4gPiAgIHRoZSBuZXcgRUNSQyAocmUtY29tcHV0ZWQgd2l0aCB0aGUgdHJh
bnNsYXRlZCBhZGRyZXNzKSBpZiBpdAo+ID4gPiAgIGRlY2lkZXMgdG8gZm9yd2FyZCB0aGUgVExQ
IGFzIGEgcGVlciByZXF1ZXN0Lgo+ID4gPiDigKIgUm9vdC1wb3J0cywgYW5kIG11bHRpLWZ1bmN0
aW9uIHJvb3QtY29tcGxleCBpbnRlZ3JhdGVkIGVuZHBvaW50cywgbWF5Cj4gPiA+ICAgc3VwcG9y
dCBhZGRpdGlvbmFsIHBlZXJ0by1wZWVyIGNvbnRyb2wgZmVhdHVyZXMgYnkgc3VwcG9ydGluZyBQ
Q0kgRXhwcmVzcwo+ID4gPiAgIEFjY2VzcyBDb250cm9sIFNlcnZpY2VzIChBQ1MpIGNhcGFiaWxp
dHkuIFJlZmVyIHRvIEFDUyBjYXBhYmlsaXR5IGluCj4gPiA+ICAgUENJIEV4cHJlc3Mgc3BlY2lm
aWNhdGlvbnMgZm9yIGRldGFpbHMuCj4gPiA+IAo+ID4gPiBTaW5jZSBMaW51eCBkaWRuJ3QgZ2l2
ZSBzcGVjaWFsIHRyZWF0bWVudCB0byBhbGxvdyB0aGlzIGV4Y2VwdGlvbiwgY2VydGFpbgo+ID4g
PiBSQ2lFUCBNRkQgZGV2aWNlcyBhcmUgZ2V0dGluZyBncm91cGVkIGluIGEgc2luZ2xlIGlvbW11
IGdyb3VwLiBUaGlzCj4gPiA+IGRvZXNuJ3QgcGVybWl0IGEgc2luZ2xlIGRldmljZSB0byBiZSBh
c3NpZ25lZCB0byBhIGd1ZXN0IGZvciBpbnN0YW5jZS4KPiA+ID4gCj4gPiA+IEluIG9uZSB2ZW5k
b3Igc3lzdGVtOiBEZXZpY2UgMTQueCB3ZXJlIGdyb3VwZWQgaW4gYSBzaW5nbGUgSU9NTVUgZ3Jv
dXAuCj4gPiA+IAo+ID4gPiAvc3lzL2tlcm5lbC9pb21tdV9ncm91cHMvNS9kZXZpY2VzLzAwMDA6
MDA6MTQuMAo+ID4gPiAvc3lzL2tlcm5lbC9pb21tdV9ncm91cHMvNS9kZXZpY2VzLzAwMDA6MDA6
MTQuMgo+ID4gPiAvc3lzL2tlcm5lbC9pb21tdV9ncm91cHMvNS9kZXZpY2VzLzAwMDA6MDA6MTQu
Mwo+ID4gPiAKPiA+ID4gQWZ0ZXIgdGhlIHBhdGNoOgo+ID4gPiAvc3lzL2tlcm5lbC9pb21tdV9n
cm91cHMvNS9kZXZpY2VzLzAwMDA6MDA6MTQuMAo+ID4gPiAvc3lzL2tlcm5lbC9pb21tdV9ncm91
cHMvNS9kZXZpY2VzLzAwMDA6MDA6MTQuMgo+ID4gPiAvc3lzL2tlcm5lbC9pb21tdV9ncm91cHMv
Ni9kZXZpY2VzLzAwMDA6MDA6MTQuMyA8PDwgbmV3IGdyb3VwCj4gPiA+IAo+ID4gPiAxNC4wIGFu
ZCAxNC4yIGFyZSBpbnRlZ3JhdGVkIGRldmljZXMsIGJ1dCBsZWdhY3kgZW5kIHBvaW50cy4KPiA+
ID4gV2hlcmVhcyAxNC4zIHdhcyBhIFBDSWUgY29tcGxpYW50IFJDaUVQLgo+ID4gPiAKPiA+ID4g
MDA6MTQuMyBOZXR3b3JrIGNvbnRyb2xsZXI6IEludGVsIENvcnBvcmF0aW9uIERldmljZSA5ZGYw
IChyZXYgMzApCj4gPiA+IENhcGFiaWxpdGllczogWzQwXSBFeHByZXNzICh2MikgUm9vdCBDb21w
bGV4IEludGVncmF0ZWQgRW5kcG9pbnQsIE1TSSAwMAo+ID4gPiAKPiA+ID4gVGhpcyBwZXJtaXRz
IGFzc2lnbmluZyB0aGlzIGRldmljZSB0byBhIGd1ZXN0IFZNLgo+ID4gPiAKPiA+ID4gRml4ZXM6
IGYwOTZjMDYxZjU1MiAoImlvbW11OiBSZXdvcmsgaW9tbXVfZ3JvdXBfZ2V0X2Zvcl9wY2lfZGV2
KCkiKQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBBc2hvayBSYWogPGFzaG9rLnJhakBpbnRlbC5jb20+
Cj4gPiA+IFRvOiBKb2VyZyBSb2VkZWwgPGpvcm9AOGJ5dGVzLm9yZz4KPiA+ID4gVG86IEJqb3Ju
IEhlbGdhYXMgPGJoZWxnYWFzQGdvb2dsZS5jb20+Cj4gPiA+IENjOiBsaW51eC1rZXJuZWxAdmdl
ci5rZXJuZWwub3JnCj4gPiA+IENjOiBpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwo+
ID4gPiBDYzogTHUgQmFvbHUgPGJhb2x1Lmx1QGxpbnV4LmludGVsLmNvbT4KPiA+ID4gQ2M6IEFs
ZXggV2lsbGlhbXNvbiA8YWxleC53aWxsaWFtc29uQHJlZGhhdC5jb20+Cj4gPiA+IENjOiBEYXJy
ZWwgR29lZGRlbCA8REdvZWRkZWxAZm9yY2Vwb2ludC5jb20+Cj4gPiA+IENjOiBNYXJrIFNjb3R0
IDxtc2NvdHRAZm9yY2Vwb2ludC5jb20+LAo+ID4gPiBDYzogUm9taWwgU2hhcm1hIDxyc2hhcm1h
QGZvcmNlcG9pbnQuY29tPgo+ID4gPiBDYzogQXNob2sgUmFqIDxhc2hvay5yYWpAaW50ZWwuY29t
PiAgCj4gPiAKPiA+IFRlbnRhdGl2ZWx5IGFwcGxpZWQgdG8gcGNpL3ZpcnR1YWxpemF0aW9uIGZv
ciB2NS44LCB0aGFua3MhCj4gPiAKPiA+IFRoZSBzcGVjIHNheXMgdGhpcyBoYW5kbGluZyBtdXN0
IGFwcGx5ICJ3aGVuIERNQSByZW1hcHBpbmcgaXMKPiA+IGVuYWJsZWQiLiAgVGhlIHBhdGNoIGRv
ZXMgbm90IGNoZWNrIHdoZXRoZXIgRE1BIHJlbWFwcGluZyBpcyBlbmFibGVkLgo+ID4gCj4gPiBJ
cyB0aGVyZSBhbnkgY2FzZSB3aGVyZSBETUEgcmVtYXBwaW5nIGlzICpub3QqIGVuYWJsZWQsIGFu
ZCB3ZSByZWx5IG9uCj4gPiB0aGlzIHBhdGNoIHRvIHRlbGwgdXMgd2hldGhlciB0aGUgZGV2aWNl
IGlzIGlzb2xhdGVkPyAgSXQgc291bmRzIGxpa2UKPiA+IGl0IG1heSBnaXZlIHRoZSB3cm9uZyBh
bnN3ZXIgaW4gc3VjaCBhIGNhc2U/Cj4gPiAKPiA+IENhbiB5b3UgY29uZmlybSB0aGF0IEkgZG9u
J3QgbmVlZCB0byB3b3JyeSBhYm91dCB0aGlzPyAgICAKPiAKPiBJIHRoaW5rIGFsbCBvZiB0aGlz
IG1ha2VzIHNlbnNlIG9ubHkgd2hlbiBETUEgcmVtYXBwaW5nIGlzIGVuYWJsZWQuCj4gT3RoZXJ3
aXNlIHRoZXJlIGlzIG5vIGVuZm9yY2VtZW50IGZvciBpc29sYXRpb24uIAoKWWVwLCB3aXRob3V0
IGFuIElPTU1VIGFsbCBkZXZpY2VzIG9wZXJhdGUgaW4gdGhlIHNhbWUgSU9WQSBzcGFjZSBhbmQg
d2UKaGF2ZSBubyBpc29sYXRpb24uICBXZSBvbmx5IGVuYWJsZSBBQ1Mgd2hlbiBhbiBJT01NVSBk
cml2ZXIgcmVxdWVzdHMgaXQKYW5kIGl0J3Mgb25seSB1c2VkIGJ5IElPTU1VIGNvZGUgdG8gZGV0
ZXJtaW5lIElPTU1VIGdyb3VwaW5nIG9mCmRldmljZXMuICBUaGFua3MsCgpBbGV4CgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxp
c3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZv
dW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
