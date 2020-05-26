Return-Path: <SRS0=1lY2=7I=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86F5EC433E0
	for <iommu@archiver.kernel.org>; Tue, 26 May 2020 18:27:05 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32CF120674
	for <iommu@archiver.kernel.org>; Tue, 26 May 2020 18:27:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aLTQi0a7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32CF120674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id E472A878DD;
	Tue, 26 May 2020 18:27:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bbCb7iyBQ-Bt; Tue, 26 May 2020 18:27:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 9459F81AEF;
	Tue, 26 May 2020 18:27:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 737ABC0888;
	Tue, 26 May 2020 18:27:03 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6F67AC016F
 for <iommu@lists.linux-foundation.org>; Tue, 26 May 2020 18:27:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 5D0D488551
 for <iommu@lists.linux-foundation.org>; Tue, 26 May 2020 18:27:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uUKnOrVBcEaT for <iommu@lists.linux-foundation.org>;
 Tue, 26 May 2020 18:27:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [205.139.110.120])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 4A45588545
 for <iommu@lists.linux-foundation.org>; Tue, 26 May 2020 18:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590517620;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ax77LQGS6LyswNoHPKq4ajIwd1zVpERIFMSwmKnqS4Y=;
 b=aLTQi0a7aioLTLa1VGv1wlLWHHrH/g+192OAep0JvSyOcdrQmaMwM4izbH1/Bpq7CbGemA
 4SEiIvO3yJ9dpacEkj3/8QZXofN+W8sZCGWNUTXVRE2LXpZVshWlHz8Ip0+xM32vaD95aA
 MrlfOhOVh1y237kCIm4XX6iWCZMC0jE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-64-f_e1aYZSMkGGMdw6_HUzVA-1; Tue, 26 May 2020 14:26:57 -0400
X-MC-Unique: f_e1aYZSMkGGMdw6_HUzVA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 13CF4107ACF5;
 Tue, 26 May 2020 18:26:56 +0000 (UTC)
Received: from x1.home (ovpn-114-203.phx2.redhat.com [10.3.114.203])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2C3326FB6E;
 Tue, 26 May 2020 18:26:55 +0000 (UTC)
Date: Tue, 26 May 2020 12:26:54 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: "Raj, Ashok" <ashok.raj@intel.com>
Subject: Re: [PATCH] iommu: Relax ACS requirement for RCiEP devices.
Message-ID: <20200526122654.7ac087b3@x1.home>
In-Reply-To: <20200526180648.GC35892@otc-nc-03>
References: <1588653736-10835-1-git-send-email-ashok.raj@intel.com>
 <20200504231936.2bc07fe3@x1.home>
 <20200505061107.GA22974@araj-mobl1.jf.intel.com>
 <20200505080514.01153835@x1.home>
 <20200505145605.GA13690@otc-nc-03>
 <20200505093414.6bae52e0@x1.home>
 <20200526180648.GC35892@otc-nc-03>
Organization: Red Hat
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Cc: Darrel Goeddel <DGoeddel@forcepoint.com>, linux-pci@vger.kernel.org,
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

T24gVHVlLCAyNiBNYXkgMjAyMCAxMTowNjo0OCAtMDcwMAoiUmFqLCBBc2hvayIgPGFzaG9rLnJh
akBpbnRlbC5jb20+IHdyb3RlOgoKPiBIaSBBbGV4LAo+IAo+IEkgd2FzIGFibGUgdG8gZmluZCBi
ZXR0ZXIgbGFuZ3VhZ2UgaW4gdGhlIElPTU1VIHNwZWMgdGhhdCBnYXVyYW50ZWVzIAo+IHRoZSBi
ZWhhdmlvciB3ZSBuZWVkLiBTZWUgYmVsb3cuCj4gCj4gCj4gT24gVHVlLCBNYXkgMDUsIDIwMjAg
YXQgMDk6MzQ6MTRBTSAtMDYwMCwgQWxleCBXaWxsaWFtc29uIHdyb3RlOgo+ID4gT24gVHVlLCA1
IE1heSAyMDIwIDA3OjU2OjA2IC0wNzAwCj4gPiAiUmFqLCBBc2hvayIgPGFzaG9rLnJhakBpbnRl
bC5jb20+IHdyb3RlOgo+ID4gICAKPiA+ID4gT24gVHVlLCBNYXkgMDUsIDIwMjAgYXQgMDg6MDU6
MTRBTSAtMDYwMCwgQWxleCBXaWxsaWFtc29uIHdyb3RlOiAgCj4gPiA+ID4gT24gTW9uLCA0IE1h
eSAyMDIwIDIzOjExOjA3IC0wNzAwCj4gPiA+ID4gIlJhaiwgQXNob2siIDxhc2hvay5yYWpAaW50
ZWwuY29tPiB3cm90ZToKPiA+ID4gPiAgICAgCj4gPiA+ID4gPiBIaSBBbGV4Cj4gPiA+ID4gPiAK
PiA+ID4gPiA+ICsgSm9lcmcsIGFjY2lkZW50bHkgbWlzc2VkIGluIHRoZSBDYy4KPiA+ID4gPiA+
IAo+ID4gPiA+ID4gT24gTW9uLCBNYXkgMDQsIDIwMjAgYXQgMTE6MTk6MzZQTSAtMDYwMCwgQWxl
eCBXaWxsaWFtc29uIHdyb3RlOiAgICAKPiA+ID4gPiA+ID4gT24gTW9uLCAgNCBNYXkgMjAyMCAy
MTo0MjoxNiAtMDcwMAo+ID4gPiA+ID4gPiBBc2hvayBSYWogPGFzaG9rLnJhakBpbnRlbC5jb20+
IHdyb3RlOgo+ID4gPiA+ID4gPiAgICAgICAKPiA+ID4gPiA+ID4gPiBQQ0llIFNwZWMgcmVjb21t
ZW5kcyB3ZSBjYW4gcmVsYXggQUNTIHJlcXVpcmVtZW50IGZvciBSQ0lFUCBkZXZpY2VzLgo+ID4g
PiA+ID4gPiA+IAo+ID4gPiA+ID4gPiA+IFBDSWUgNS4wIFNwZWNpZmljYXRpb24uCj4gPiA+ID4g
PiA+ID4gNi4xMiBBY2Nlc3MgQ29udHJvbCBTZXJ2aWNlcyAoQUNTKQo+ID4gPiA+ID4gPiA+IElt
cGxlbWVudGF0aW9uIG9mIEFDUyBpbiBSQ2lFUHMgaXMgcGVybWl0dGVkIGJ1dCBub3QgcmVxdWly
ZWQuIEl0IGlzCj4gPiA+ID4gPiA+ID4gZXhwbGljaXRseSBwZXJtaXR0ZWQgdGhhdCwgd2l0aGlu
IGEgc2luZ2xlIFJvb3QgQ29tcGxleCwgc29tZSBSQ2lFUHMKPiA+ID4gPiA+ID4gPiBpbXBsZW1l
bnQgQUNTIGFuZCBzb21lIGRvIG5vdC4gSXQgaXMgc3Ryb25nbHkgcmVjb21tZW5kZWQgdGhhdCBS
b290IENvbXBsZXgKPiA+ID4gPiA+ID4gPiBpbXBsZW1lbnRhdGlvbnMgZW5zdXJlIHRoYXQgYWxs
IGFjY2Vzc2VzIG9yaWdpbmF0aW5nIGZyb20gUkNpRVBzCj4gPiA+ID4gPiA+ID4gKFBGcyBhbmQg
VkZzKSB3aXRob3V0IEFDUyBjYXBhYmlsaXR5IGFyZSBmaXJzdCBzdWJqZWN0ZWQgdG8gcHJvY2Vz
c2luZyBieQo+ID4gPiA+ID4gPiA+IHRoZSBUcmFuc2xhdGlvbiBBZ2VudCAoVEEpIGluIHRoZSBS
b290IENvbXBsZXggYmVmb3JlIGZ1cnRoZXIgZGVjb2RpbmcgYW5kCj4gPiA+ID4gPiA+ID4gcHJv
Y2Vzc2luZy4gVGhlIGRldGFpbHMgb2Ygc3VjaCBSb290IENvbXBsZXggaGFuZGxpbmcgYXJlIG91
dHNpZGUgdGhlIHNjb3BlCj4gPiA+ID4gPiA+ID4gb2YgdGhpcyBzcGVjaWZpY2F0aW9uLgo+ID4g
PiA+ID4gPiA+ICAgICAKPiA+ID4gPiA+ID4gCj4gPiA+ID4gPiA+IElzIHRoZSBsYW5ndWFnZSBo
ZXJlIHJlYWxseSBzdHJvbmcgZW5vdWdoIHRvIG1ha2UgdGhpcyBjaGFuZ2U/ICBBQ1MgaXMKPiA+
ID4gPiA+ID4gYW4gb3B0aW9uYWwgZmVhdHVyZSwgc28gYmVpbmcgcGVybWl0dGVkIGJ1dCBub3Qg
cmVxdWlyZWQgaXMgcmF0aGVyCj4gPiA+ID4gPiA+IG1lYW5pbmdsZXNzLiAgVGhlIHNwZWMgaXMg
YWxzbyBzcGVjaWZpY2FsbHkgYXZvaWRpbmcgdGhlIHdvcmRzICJtdXN0Igo+ID4gPiA+ID4gPiBv
ciAic2hhbGwiIGFuZCBldmVuIHdoZW4gZW1waGFzaXplZCB3aXRoICJzdHJvbmdseSIsIHdlIHN0
aWxsIG9ubHkgaGF2ZQo+ID4gPiA+ID4gPiBhIHJlY29tbWVuZGF0aW9uIHRoYXQgbWF5IG9yIG1h
eSBub3QgYmUgaG9ub3JlZC4gIFRoaXMgc2VlbXMgbGlrZSBhCj4gPiA+ID4gPiA+IHdlYWsgYmFz
aXMgZm9yIGFzc3VtaW5nIHRoYXQgUkNpRVBzIHVuaXZlcnNhbGx5IGhvbm9yIHRoaXMKPiA+ID4g
PiA+ID4gcmVjb21tZW5kYXRpb24uICBUaGFua3MsCj4gPiA+ID4gPiA+ICAgICAgIAo+ID4gPiA+
ID4gCj4gPiA+ID4gPiBXZSBhcmUgc3BlYWtpbmcgYWJvdXQgUENJZSBzcGVjLCB3aGVyZSBwZW9w
bGUgd3JpdGUgaXQgYWJvdXQgNSB5ZWFycyBhaGVhZAo+ID4gPiA+ID4gYW5kIGV2ZXJ5IHZlbmRv
ciB0cmllcyB0byBtYXNzYWdlIHRoZWlyIHByb2R1Y3QgYmVoYXZpb3Igd2l0aCB2YWd1ZQo+ID4g
PiA+ID4gd29yZHMgbGlrZSB0aGlzLi4gIDopCj4gPiA+ID4gPiAKPiA+ID4gPiA+IEJ1dCBob25l
c3RseSBmb3IgYW55IGFueSBSQ2lFUCwgb3IgZXZlbiBpbnRlZ3JhdGVkIGVuZHBvaW50cywgdGhl
cmUgCj4gPiA+ID4gPiBpcyBubyB3YXkgdG8gc2VuZCB0aGVtIGV4Y2VwdCB1cCBub3J0aC4gVGhl
c2UgYXJlbid0IGJlaGluZCBhIFJQLiAgICAKPiA+ID4gPiAKPiA+ID4gPiBCdXQgdGhleSBhcmUg
bXVsdGktZnVuY3Rpb24gZGV2aWNlcyBhbmQgdGhlIHNwZWMgZG9lc24ndCBkZWZpbmUgcm91dGlu
Zwo+ID4gPiA+IHdpdGhpbiBtdWx0aWZ1bmN0aW9uIHBhY2thZ2VzLiAgQSBzaW5nbGUgZnVuY3Rp
b24gUkNpRVAgd2lsbCBhbHJlYWR5IGJlCj4gPiA+ID4gYXNzdW1lZCBpc29sYXRlZCB3aXRoaW4g
aXRzIG93biBncm91cC4gICAgCj4gPiA+IAo+ID4gPiBUaGF0J3MgcmlnaHQuIFRoZSBvdGhlciB0
d28gZGV2aWNlcyBvbmx5IGhhdmUgbGVnYWN5IFBDSSBoZWFkZXJzLiBTbyAKPiA+ID4gdGhleSBj
YW4ndCBjbGFpbSB0byBiZSBSQ2lFUCdzIGJ1dCBqdXN0IGludGVncmF0ZWQgZW5kcG9pbnRzLiBU
aGUgbGVnYWN5Cj4gPiA+IGRldmljZXMgZG9uJ3QgZXZlbiBoYXZlIGEgUENJZSBoZWFkZXIuCj4g
PiA+IAo+ID4gPiBJIGhvbmVzdGx5IGRvbid0IGtub3cgd2h5IHRoZXNlIGFyZSBncm9wZWQgYXMg
TUZEJ3MgaW4gdGhlIGZpcnN0IHBsYWNlLgo+ID4gPiAgIAo+ID4gPiA+ICAgICAgCj4gPiA+ID4g
PiBJIGRpZCBjaGVjayB3aXRoIGNvdXBsZSBmb2xrcyB3aG8gYXJlIHBhcnQgb2YgdGhlIFNJRywg
YW5kIHNlZW0gdG8gYWdyZWUKPiA+ID4gPiA+IHRoYXQgQUNTIHRyZWF0bWVudCBmb3IgUkNpRVAn
cyBkb2Vzbid0IG1lYW4gbXVjaC4gCj4gPiA+ID4gPiAKPiA+ID4gPiA+IEkgdW5kZXJzdGFuZCB0
aGUgbGFuZ3VhZ2UgaXNuJ3Qgc3Ryb25nLCBidXQgaXQgZG9lc24ndCBzZWVtIGxpa2UgQUNTIHNo
b3VsZAo+ID4gPiA+ID4gYmUgYSBzdHJvbmcgcmVxdWlyZW1lbnQgZm9yIFJDaUVQJ3MgYW5kIHJl
YXNvbmFibGUgdG8gcmVsYXguCj4gPiA+ID4gPiAKPiA+ID4gPiA+IFdoYXQgYXJlIHlvdXIgdGhv
dWdodHM/ICAgICAKPiA+ID4gPiAKPiA+ID4gPiBJIHRoaW5rIGhhcmR3YXJlIHZlbmRvcnMgaGF2
ZSBBQ1MgYXQgdGhlaXIgZGlzcG9zYWwgdG8gY2xhcmlmeSB3aGVuCj4gPiA+ID4gaXNvbGF0aW9u
IGlzIHByb3ZpZGVkLCBvdGhlcndpc2UgdmVuZG9ycyBjYW4gc3VibWl0IHF1aXJrcywgYnV0IEkg
ZG9uJ3QKPiA+ID4gPiBzZWUgdGhhdCB0aGUgInN0cm9uZ2x5IHJlY29tbWVuZGVkIiBwaHJhc2lu
ZyBpcyBzdWZmaWNpZW50IHRvIGFzc3VtZQo+ID4gPiA+IGlzb2xhdGlvbiBiZXR3ZWVuIG11bHRp
ZnVuY3Rpb24gUkNpRVBzLiAgVGhhbmtzLCAgICAKPiA+ID4gCj4gPiA+IFlvdSBwb2ludCBpcyB0
aGF0IGludGVncmF0ZWQgTUZEIGVuZHBvaW50cywgd2l0aG91dCBBQ1MsIHRoZXJlIGlzIG5vIAo+
ID4gPiBnYXVyYW50ZWUgdG8gU1cgdGhhdCB0aGV5IGFyZSBpc29sYXRlZC4KPiA+ID4gCj4gPiA+
IEFzIGZhciBhcyBhIHF1aXJrLCBkbyB5b3UgdGhpbms6Cj4gPiA+IAktIGEgY21kbGluZSBvcHRw
dXQgZm9yIGludGVncmF0ZWQgZW5kcG9pbnRzLCBhbmQgUkNpRVAncyBzdWZmaWNlPwo+ID4gPiAJ
ICBhbG9uZyB3aXRoIGEgY29tcGlsZSB0aW1lIGRlZmF1bHQgdGhhdCBpcyBzdHJpY3QgZW5mb3Jj
ZW1lbnQKPiA+ID4gCS0gdHlwaWNhbCB2aWQvZGlkIHR5cGUgZXhjZXB0aW9uIGxpc3Q/Cj4gPiA+
IAo+ID4gPiBBIG1vcmUgZ2VuZXJpYyB3YXkgdG8gYXNrIGZvciBleGNlcHRpb24gd291bGQgYmUg
c2NhbGFibGUgdW50aWwgd2UgY2FuIHN0b3AKPiA+ID4gdGhvc2UgdHlwZSBvZiBpbnRlZ3JhdGVk
IGRldmljZXMuIE9yIHdlIG5lZWQgdG8gbWFpbnRhaW4gdGhlc2UgZGV2aWNlIGxpc3RzCj4gPiA+
IGZvciBldGVybml0eS4gICAKPiA+IAo+ID4gSSBkb24ndCB0aGluayB0aGUgbGFuZ3VhZ2UgaW4g
dGhlIHNwZWMgaXMgYW55dGhpbmcgc3VmZmljaWVudCB0byBoYW5kbGUKPiA+IFJDaUVQIHVuaXF1
ZWx5LiAgV2UndmUgcHJldmlvdXNseSByZWplY3RlZCBrZXJuZWwgY29tbWFuZCBsaW5lIG9wdC1v
dXRzCj4gPiBmb3IgQUNTLCBhbmQgdGhlIGV4dGVudCB0byB3aGljaCB0aG9zZSBwYXRjaGVzIHN0
aWxsIGZsb2F0IGFyb3VuZCB0aGUKPiA+IHVzZXIgY29tbXVuaXR5IGFuZCBhcmUgYmxpbmRseSB1
c2VkIHRvIHNlcGFyYXRlIElPTU1VIGdyb3VwcyBhcmUgYQo+ID4gdGVzdGFtZW50IHRvIHRoZSBm
YWlsdXJlIG9mIHRoaXMgYXBwcm9hY2guICBVc2VycyBkbyBub3QgaGF2ZSBhIGJhc2lzCj4gPiBm
b3IgZW5hYmxpbmcgdGhpcyBzb3J0IG9mIG9wdC1vdXQuICBUaGUgYmVuZWZpdCBpcyBvYnZpb3Vz
IGluIHRoZSBJT01NVQo+ID4gZ3JvdXBpbmcsIGJ1dCB0aGUgcmlzayBpcyBlbnRpcmVseSB1bmtu
b3duLiAgQSBrY29uZmlnIG9wdGlvbiBpcyBldmVuCj4gPiB3b3JzZSBhcyB0aGF0IG1lYW5zIGlm
IHlvdSBjb25zdW1lIGEgZG93bnN0cmVhbSBrZXJuZWwsIHRoZSBkb3duc3RyZWFtCj4gPiBtYWlu
dGFpbmVycyBtaWdodCBoYXZlIGRlY2lkZWQgdW5pdmVyc2FsbHkgdGhhdCBpc29sYXRpb24gaXMg
bGVzcwo+ID4gaW1wb3J0YW50IHRoYW4gZnVuY3Rpb25hbGl0eS4gIAo+IAo+IFdlIGRpc2N1c3Nl
ZCB0aGlzIGludGVybmFsbHksIGFuZCBJbnRlbCB2dC1kIHNwZWMgZG9lcyBzcGVsbCBvdXQgY2xl
YXJseSAKPiBpbiBTZWN0aW9uIDMuMTYgUm9vdC1Db21wbGV4IFBlZXIgdG8gUGVlciBDb25zaWRl
cmF0aW9ucy4gVGhlIHNwZWMgY2xlYXJseQo+IGNhbGxzIG91dCB0aGF0IGFsbCBwMnAgbXVzdCBi
ZSBkb25lIG9uIHRyYW5zbGF0ZWQgYWRkcmVzc2VzIGFuZCB0aGVyZWZvcmUKPiBtdXN0IGdvIHRo
cm91Z2ggdGhlIElPTU1VLgo+IAo+IEkgc3VwcG9zZSB0aGV5IHNob3VsZCBhbHNvIGhhdmUgc29t
ZSBzaW1pbGFyIHBsYXRmb3JtIGdhdXJhbnRlZWQgYmVoYXZpb3IKPiBmb3IgUkNpRVAncyBvciBN
RkQncyAqTXVzdCogYmVoYXZlIGFzIGZvbGxvd3MuIFRoZSBsYW5ndWFnZSBpcyBzdHJpY3QgYW5k
Cj4gd2hlbiBJT01NVSBpcyBlbmFibGVkIGluIHRoZSBwbGF0Zm9ybSwgZXZlcnl0aGluZyBpcyBz
ZW50IHVwIG5vcnRoIHRvIHRoZQo+IElPTU1VIGFnZW50Lgo+IAo+IDMuMTYgUm9vdC1Db21wbGV4
IFBlZXIgdG8gUGVlciBDb25zaWRlcmF0aW9ucwo+IFdoZW4gRE1BIHJlbWFwcGluZyBpcyBlbmFi
bGVkLCBwZWVyLXRvLXBlZXIgcmVxdWVzdHMgdGhyb3VnaCB0aGUKPiBSb290LUNvbXBsZXggbXVz
dCBiZSBoYW5kbGVkCj4gYXMgZm9sbG93czoKPiDigKIgVGhlIGlucHV0IGFkZHJlc3MgaW4gdGhl
IHJlcXVlc3QgaXMgdHJhbnNsYXRlZCAodGhyb3VnaCBmaXJzdC1sZXZlbCwKPiAgIHNlY29uZC1s
ZXZlbCBvciBuZXN0ZWQgdHJhbnNsYXRpb24pIHRvIGEgaG9zdCBwaHlzaWNhbCBhZGRyZXNzIChI
UEEpLgo+ICAgVGhlIGFkZHJlc3MgZGVjb2RpbmcgZm9yIHBlZXIgYWRkcmVzc2VzIG11c3QgYmUg
ZG9uZSBvbmx5IG9uIHRoZSAKPiAgIHRyYW5zbGF0ZWQgSFBBLiBIYXJkd2FyZSBpbXBsZW1lbnRh
dGlvbnMgYXJlIGZyZWUgdG8gZnVydGhlciBsaW1pdCAKPiAgIHBlZXItdG8tcGVlciBhY2Nlc3Nl
cyB0byBzcGVjaWZpYyBob3N0IHBoeXNpY2FsIGFkZHJlc3MgcmVnaW9ucyAKPiAgIChvciB0byBj
b21wbGV0ZWx5IGRpc2FsbG93IHBlZXItZm9yd2FyZGluZyBvZiB0cmFuc2xhdGVkIHJlcXVlc3Rz
KS4KPiDigKIgU2luY2UgYWRkcmVzcyB0cmFuc2xhdGlvbiBjaGFuZ2VzIHRoZSBjb250ZW50cyAo
YWRkcmVzcyBmaWVsZCkgb2YgdGhlIFBDSQo+ICAgRXhwcmVzcyBUcmFuc2FjdGlvbiBMYXllciBQ
YWNrZXQgKFRMUCksIGZvciBQQ0kgRXhwcmVzcyBwZWVyLXRvLXBlZXIgCj4gICByZXF1ZXN0cyB3
aXRoIEVDUkMsIHRoZSBSb290LUNvbXBsZXggaGFyZHdhcmUgbXVzdCB1c2UgdGhlIG5ldyBFQ1JD
IAo+ICAgKHJlLWNvbXB1dGVkIHdpdGggdGhlIHRyYW5zbGF0ZWQgYWRkcmVzcykgaWYgaXQgZGVj
aWRlcyB0byBmb3J3YXJkIAo+ICAgdGhlIFRMUCBhcyBhIHBlZXIgcmVxdWVzdC4KPiDigKIgUm9v
dC1wb3J0cywgYW5kIG11bHRpLWZ1bmN0aW9uIHJvb3QtY29tcGxleCBpbnRlZ3JhdGVkIGVuZHBv
aW50cywgbWF5Cj4gICBzdXBwb3J0IGFkZGl0aW9uYWwgcGVlcnRvLXBlZXIgY29udHJvbCBmZWF0
dXJlcyBieSBzdXBwb3J0aW5nIFBDSSBFeHByZXNzCj4gICBBY2Nlc3MgQ29udHJvbCBTZXJ2aWNl
cyAoQUNTKSBjYXBhYmlsaXR5LiBSZWZlciB0byBBQ1MgY2FwYWJpbGl0eSBpbiAKPiAgIFBDSSBF
eHByZXNzIHNwZWNpZmljYXRpb25zIGZvciBkZXRhaWxzLgoKVGhhdCBzb3VuZHMgbGlrZSBpdCBt
aWdodCBiZSBhIHJlYXNvbmFibGUgYmFzaXMgZm9yIHF1aXJraW5nIGFsbCBSQ2lFUHMKb24gVlQt
ZCBwbGF0Zm9ybXMgaWYgSW50ZWwgaXMgd2lsbGluZyB0byBzdGFuZCBiZWhpbmQgaXQuICBUaGFu
a3MsCgpBbGV4CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
Xwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0
cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
