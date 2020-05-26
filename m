Return-Path: <SRS0=1lY2=7I=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0F12C433DF
	for <iommu@archiver.kernel.org>; Tue, 26 May 2020 23:07:27 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C41F2078C
	for <iommu@archiver.kernel.org>; Tue, 26 May 2020 23:07:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DGE/PK5P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C41F2078C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 3083788508;
	Tue, 26 May 2020 23:07:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xln-k742D5E9; Tue, 26 May 2020 23:07:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 4E42B884F0;
	Tue, 26 May 2020 23:07:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 35E2DC088D;
	Tue, 26 May 2020 23:07:26 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 807A3C016F
 for <iommu@lists.linux-foundation.org>; Tue, 26 May 2020 23:07:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 6EF8F85F6E
 for <iommu@lists.linux-foundation.org>; Tue, 26 May 2020 23:07:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1xByXNcxxZAw for <iommu@lists.linux-foundation.org>;
 Tue, 26 May 2020 23:07:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [207.211.31.120])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 7FDC585F66
 for <iommu@lists.linux-foundation.org>; Tue, 26 May 2020 23:07:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590534442;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z/cPDNnfZwS0saAPWel+OCX7+QFUn/80dLbmwhQAzY0=;
 b=DGE/PK5PCGhpMETXVTAdZF73maXyN+vC/QqWWm3aMvssmQTIYbQux2AhSvxqrG/LABLK57
 IHUVm0RPdiZ+2Qbr/Y7M/3Z0URGRntMn8vyfnO374Rif3dL7FMBDcURdtdz1RGoLqVQN2D
 rVYNZ5iS5i66d69hEaDSS95v88rBcEk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-265-_XID7VbqOomQugx1txeZ1A-1; Tue, 26 May 2020 19:07:18 -0400
X-MC-Unique: _XID7VbqOomQugx1txeZ1A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BFA28107ACCD;
 Tue, 26 May 2020 23:07:16 +0000 (UTC)
Received: from x1.home (ovpn-112-195.phx2.redhat.com [10.3.112.195])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CA6A460C47;
 Tue, 26 May 2020 23:07:15 +0000 (UTC)
Date: Tue, 26 May 2020 17:07:15 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Ashok Raj <ashok.raj@intel.com>
Subject: Re: [PATCH] iommu: Relax ACS requirement for Intel RCiEP devices.
Message-ID: <20200526170715.18c0ee98@x1.home>
In-Reply-To: <1590531455-19757-1-git-send-email-ashok.raj@intel.com>
References: <1590531455-19757-1-git-send-email-ashok.raj@intel.com>
Organization: Red Hat
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
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

T24gVHVlLCAyNiBNYXkgMjAyMCAxNToxNzozNSAtMDcwMApBc2hvayBSYWogPGFzaG9rLnJhakBp
bnRlbC5jb20+IHdyb3RlOgoKPiBBbGwgSW50ZWwgcGxhdGZvcm1zIGd1YXJhbnRlZSB0aGF0IGFs
bCByb290IGNvbXBsZXggaW1wbGVtZW50YXRpb25zCj4gbXVzdCBzZW5kIHRyYW5zYWN0aW9ucyB1
cCB0byBJT01NVSBmb3IgYWRkcmVzcyB0cmFuc2xhdGlvbnMuIEhlbmNlIGZvcgo+IFJDaUVQIGRl
dmljZXMgdGhhdCBhcmUgVmVuZG9yIElEIEludGVsLCBjYW4gY2xhaW0gZXhjZXB0aW9uIGZvciBs
YWNrIG9mCj4gQUNTIHN1cHBvcnQuCj4gCj4gCj4gMy4xNiBSb290LUNvbXBsZXggUGVlciB0byBQ
ZWVyIENvbnNpZGVyYXRpb25zCj4gV2hlbiBETUEgcmVtYXBwaW5nIGlzIGVuYWJsZWQsIHBlZXIt
dG8tcGVlciByZXF1ZXN0cyB0aHJvdWdoIHRoZQo+IFJvb3QtQ29tcGxleCBtdXN0IGJlIGhhbmRs
ZWQKPiBhcyBmb2xsb3dzOgo+IOKAoiBUaGUgaW5wdXQgYWRkcmVzcyBpbiB0aGUgcmVxdWVzdCBp
cyB0cmFuc2xhdGVkICh0aHJvdWdoIGZpcnN0LWxldmVsLAo+ICAgc2Vjb25kLWxldmVsIG9yIG5l
c3RlZCB0cmFuc2xhdGlvbikgdG8gYSBob3N0IHBoeXNpY2FsIGFkZHJlc3MgKEhQQSkuCj4gICBU
aGUgYWRkcmVzcyBkZWNvZGluZyBmb3IgcGVlciBhZGRyZXNzZXMgbXVzdCBiZSBkb25lIG9ubHkg
b24gdGhlCj4gICB0cmFuc2xhdGVkIEhQQS4gSGFyZHdhcmUgaW1wbGVtZW50YXRpb25zIGFyZSBm
cmVlIHRvIGZ1cnRoZXIgbGltaXQKPiAgIHBlZXItdG8tcGVlciBhY2Nlc3NlcyB0byBzcGVjaWZp
YyBob3N0IHBoeXNpY2FsIGFkZHJlc3MgcmVnaW9ucwo+ICAgKG9yIHRvIGNvbXBsZXRlbHkgZGlz
YWxsb3cgcGVlci1mb3J3YXJkaW5nIG9mIHRyYW5zbGF0ZWQgcmVxdWVzdHMpLgo+IOKAoiBTaW5j
ZSBhZGRyZXNzIHRyYW5zbGF0aW9uIGNoYW5nZXMgdGhlIGNvbnRlbnRzIChhZGRyZXNzIGZpZWxk
KSBvZgo+ICAgdGhlIFBDSSBFeHByZXNzIFRyYW5zYWN0aW9uIExheWVyIFBhY2tldCAoVExQKSwg
Zm9yIFBDSSBFeHByZXNzCj4gICBwZWVyLXRvLXBlZXIgcmVxdWVzdHMgd2l0aCBFQ1JDLCB0aGUg
Um9vdC1Db21wbGV4IGhhcmR3YXJlIG11c3QgdXNlCj4gICB0aGUgbmV3IEVDUkMgKHJlLWNvbXB1
dGVkIHdpdGggdGhlIHRyYW5zbGF0ZWQgYWRkcmVzcykgaWYgaXQKPiAgIGRlY2lkZXMgdG8gZm9y
d2FyZCB0aGUgVExQIGFzIGEgcGVlciByZXF1ZXN0Lgo+IOKAoiBSb290LXBvcnRzLCBhbmQgbXVs
dGktZnVuY3Rpb24gcm9vdC1jb21wbGV4IGludGVncmF0ZWQgZW5kcG9pbnRzLCBtYXkKPiAgIHN1
cHBvcnQgYWRkaXRpb25hbCBwZWVydG8tcGVlciBjb250cm9sIGZlYXR1cmVzIGJ5IHN1cHBvcnRp
bmcgUENJIEV4cHJlc3MKPiAgIEFjY2VzcyBDb250cm9sIFNlcnZpY2VzIChBQ1MpIGNhcGFiaWxp
dHkuIFJlZmVyIHRvIEFDUyBjYXBhYmlsaXR5IGluCj4gICBQQ0kgRXhwcmVzcyBzcGVjaWZpY2F0
aW9ucyBmb3IgZGV0YWlscy4KPiAKPiBTaW5jZSBMaW51eCBkaWRuJ3QgZ2l2ZSBzcGVjaWFsIHRy
ZWF0bWVudCB0byBhbGxvdyB0aGlzIGV4Y2VwdGlvbiwgY2VydGFpbgo+IFJDaUVQIE1GRCBkZXZp
Y2VzIGFyZSBnZXR0aW5nIGdyb3VwZWQgaW4gYSBzaW5nbGUgaW9tbXUgZ3JvdXAuIFRoaXMKPiBk
b2Vzbid0IHBlcm1pdCBhIHNpbmdsZSBkZXZpY2UgdG8gYmUgYXNzaWduZWQgdG8gYSBndWVzdCBm
b3IgaW5zdGFuY2UuCj4gCj4gSW4gb25lIHZlbmRvciBzeXN0ZW06IERldmljZSAxNC54IHdlcmUg
Z3JvdXBlZCBpbiBhIHNpbmdsZSBJT01NVSBncm91cC4KPiAKPiAvc3lzL2tlcm5lbC9pb21tdV9n
cm91cHMvNS9kZXZpY2VzLzAwMDA6MDA6MTQuMAo+IC9zeXMva2VybmVsL2lvbW11X2dyb3Vwcy81
L2RldmljZXMvMDAwMDowMDoxNC4yCj4gL3N5cy9rZXJuZWwvaW9tbXVfZ3JvdXBzLzUvZGV2aWNl
cy8wMDAwOjAwOjE0LjMKPiAKPiBBZnRlciB0aGUgcGF0Y2g6Cj4gL3N5cy9rZXJuZWwvaW9tbXVf
Z3JvdXBzLzUvZGV2aWNlcy8wMDAwOjAwOjE0LjAKPiAvc3lzL2tlcm5lbC9pb21tdV9ncm91cHMv
NS9kZXZpY2VzLzAwMDA6MDA6MTQuMgo+IC9zeXMva2VybmVsL2lvbW11X2dyb3Vwcy82L2Rldmlj
ZXMvMDAwMDowMDoxNC4zIDw8PCBuZXcgZ3JvdXAKPiAKPiAxNC4wIGFuZCAxNC4yIGFyZSBpbnRl
Z3JhdGVkIGRldmljZXMsIGJ1dCBsZWdhY3kgZW5kIHBvaW50cy4KPiBXaGVyZWFzIDE0LjMgd2Fz
IGEgUENJZSBjb21wbGlhbnQgUkNpRVAuCj4gCj4gMDA6MTQuMyBOZXR3b3JrIGNvbnRyb2xsZXI6
IEludGVsIENvcnBvcmF0aW9uIERldmljZSA5ZGYwIChyZXYgMzApCj4gQ2FwYWJpbGl0aWVzOiBb
NDBdIEV4cHJlc3MgKHYyKSBSb290IENvbXBsZXggSW50ZWdyYXRlZCBFbmRwb2ludCwgTVNJIDAw
Cj4gCj4gVGhpcyBwZXJtaXRzIGFzc2lnbmluZyB0aGlzIGRldmljZSB0byBhIGd1ZXN0IFZNLgo+
IAo+IEZpeGVzOiBmMDk2YzA2MWY1NTIgKCJpb21tdTogUmV3b3JrIGlvbW11X2dyb3VwX2dldF9m
b3JfcGNpX2RldigpIikKPiBTaWduZWQtb2ZmLWJ5OiBBc2hvayBSYWogPGFzaG9rLnJhakBpbnRl
bC5jb20+Cj4gVG86IEpvZXJnIFJvZWRlbCA8am9yb0A4Ynl0ZXMub3JnPgo+IFRvOiBCam9ybiBI
ZWxnYWFzIDxiaGVsZ2Fhc0Bnb29nbGUuY29tPgo+IENjOiBsaW51eC1rZXJuZWxAdmdlci5rZXJu
ZWwub3JnCj4gQ2M6IGlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCj4gQ2M6IEx1IEJh
b2x1IDxiYW9sdS5sdUBsaW51eC5pbnRlbC5jb20+Cj4gQ2M6IEFsZXggV2lsbGlhbXNvbiA8YWxl
eC53aWxsaWFtc29uQHJlZGhhdC5jb20+Cj4gQ2M6IERhcnJlbCBHb2VkZGVsIDxER29lZGRlbEBm
b3JjZXBvaW50LmNvbT4KPiBDYzogTWFyayBTY290dCA8bXNjb3R0QGZvcmNlcG9pbnQuY29tPiwK
PiBDYzogUm9taWwgU2hhcm1hIDxyc2hhcm1hQGZvcmNlcG9pbnQuY29tPgo+IENjOiBBc2hvayBS
YWogPGFzaG9rLnJhakBpbnRlbC5jb20+Cj4gLS0tCj4gIGRyaXZlcnMvaW9tbXUvaW9tbXUuYyB8
IDEzICsrKysrKysrKysrKy0KPiAgMSBmaWxlIGNoYW5nZWQsIDEyIGluc2VydGlvbnMoKyksIDEg
ZGVsZXRpb24oLSkKPiAKPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pb21tdS9pb21tdS5jIGIvZHJp
dmVycy9pb21tdS9pb21tdS5jCj4gaW5kZXggMmI0NzE0MTllMjZjLi4zMWI1OTVkZmVkZGUgMTAw
NjQ0Cj4gLS0tIGEvZHJpdmVycy9pb21tdS9pb21tdS5jCj4gKysrIGIvZHJpdmVycy9pb21tdS9p
b21tdS5jCj4gQEAgLTExODcsNyArMTE4NywxOCBAQCBzdGF0aWMgc3RydWN0IGlvbW11X2dyb3Vw
ICpnZXRfcGNpX2Z1bmN0aW9uX2FsaWFzX2dyb3VwKHN0cnVjdCBwY2lfZGV2ICpwZGV2LAo+ICAJ
c3RydWN0IHBjaV9kZXYgKnRtcCA9IE5VTEw7Cj4gIAlzdHJ1Y3QgaW9tbXVfZ3JvdXAgKmdyb3Vw
Owo+ICAKPiAtCWlmICghcGRldi0+bXVsdGlmdW5jdGlvbiB8fCBwY2lfYWNzX2VuYWJsZWQocGRl
diwgUkVRX0FDU19GTEFHUykpCj4gKwkvKgo+ICsJICogSW50ZWwgVlQtZCBTcGVjaWZpY2F0aW9u
IFNlY3Rpb24gMy4xNiwgUm9vdC1Db21wbGV4IFBlZXIgdG8gUGVlcgo+ICsJICogQ29uc2lkZXJh
dGlvbnMgbWFuYWRhdGUgdGhhdCBhbGwgdHJhbnNhY3Rpb25zIGluIFJDaUVQJ3MgYW5kCj4gKwkg
KiBldmVuIEludGVncmF0ZWQgTUZEJ3MgKm11c3QqIGJlIHNlbnQgdXAgdG8gdGhlIElPTU1VLiBQ
MlAgaXMKPiArCSAqIG9ubHkgcG9zc2libGUgb24gdHJhbnNsYXRlZCBhZGRyZXNzZXMuIFRoaXMg
Z2l2ZXMgZW5vdWdoCj4gKwkgKiBndWFyYW50ZWUgdGhhdCBzdWNoIGRldmljZXMgY2FuIGJlIGZv
cmdpdmVuIGZvciBsYWNrIG9mIEFDUwo+ICsJICogc3VwcG9ydC4KPiArCSAqLwo+ICsJaWYgKCFw
ZGV2LT5tdWx0aWZ1bmN0aW9uIHx8Cj4gKwkgICAgKHBkZXYtPnZlbmRvciA9PSBQQ0lfVkVORE9S
X0lEX0lOVEVMICYmCj4gKwkgICAgIHBjaV9wY2llX3R5cGUocGRldikgPT0gUENJX0VYUF9UWVBF
X1JDX0VORCkgfHwKPiArCSAgICAgcGNpX2Fjc19lbmFibGVkKHBkZXYsIFJFUV9BQ1NfRkxBR1Mp
KQo+ICAJCXJldHVybiBOVUxMOwo+ICAKPiAgCWZvcl9lYWNoX3BjaV9kZXYodG1wKSB7CgpIaSBB
c2hvaywKCkFzIHRoaXMgaXMgYW4gSW50ZWwvVlQtZCBzdGFuZGFyZCwgbm90IGEgUENJZSBzdGFu
ZGFyZCwgd2h5IG5vdAppbXBsZW1lbnQgdGhpcyBpbiBwY2lfZGV2X3NwZWNpZmljX2Fjc19lbmFi
bGVkKCkgd2l0aCBhbGwgdGhlIG90aGVyCnF1aXJrcz8gIFRoYW5rcywKCkFsZXgKCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlz
dAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91
bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
