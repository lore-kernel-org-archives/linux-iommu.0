Return-Path: <SRS0=4TkS=7K=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23C7FC433E0
	for <iommu@archiver.kernel.org>; Thu, 28 May 2020 21:38:40 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAF192072D
	for <iommu@archiver.kernel.org>; Thu, 28 May 2020 21:38:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aI+6TyRE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAF192072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 9207187D22;
	Thu, 28 May 2020 21:38:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9jlroahvLisI; Thu, 28 May 2020 21:38:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 6841588329;
	Thu, 28 May 2020 21:38:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5245BC07FF;
	Thu, 28 May 2020 21:38:37 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EA4BDC016F
 for <iommu@lists.linux-foundation.org>; Thu, 28 May 2020 21:38:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id CF80D88F7E
 for <iommu@lists.linux-foundation.org>; Thu, 28 May 2020 21:38:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TegC3jiPnC2s for <iommu@lists.linux-foundation.org>;
 Thu, 28 May 2020 21:38:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-2.mimecast.com
 [207.211.31.81])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 907B588C67
 for <iommu@lists.linux-foundation.org>; Thu, 28 May 2020 21:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590701913;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MbsA++b9/YQf0c8XVRARDqrsuyImeixJij3EPZWrlZg=;
 b=aI+6TyRENm4YC+J5C8vQWsDVN3edMg8JiF2DFPBS6CtWwI3MOg9CE/3JrkdTSX1s4icLiT
 cKvU3qYi46nPm4xGhPyLq1c0CCkYZW45V2rlwN3v4Y0wL5CV0YW5xW5r0T4+2X9nu+2eNu
 PTgXCj+3mlgZrzXaXTu9D2utE85Ecjc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-307-ChD0PkExNeeUshi1V09zKw-1; Thu, 28 May 2020 17:38:29 -0400
X-MC-Unique: ChD0PkExNeeUshi1V09zKw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D2BDB107ACCA;
 Thu, 28 May 2020 21:38:27 +0000 (UTC)
Received: from x1.home (ovpn-112-195.phx2.redhat.com [10.3.112.195])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A20A760C80;
 Thu, 28 May 2020 21:38:26 +0000 (UTC)
Date: Thu, 28 May 2020 15:38:26 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Ashok Raj <ashok.raj@intel.com>
Subject: Re: [PATCH] PCI: Relax ACS requirement for Intel RCiEP devices.
Message-ID: <20200528153826.257a0145@x1.home>
In-Reply-To: <1590699462-7131-1-git-send-email-ashok.raj@intel.com>
References: <1590699462-7131-1-git-send-email-ashok.raj@intel.com>
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

T24gVGh1LCAyOCBNYXkgMjAyMCAxMzo1Nzo0MiAtMDcwMApBc2hvayBSYWogPGFzaG9rLnJhakBp
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
b3JfcGNpX2RldigpIikKCkkgZG9uJ3QgcmVhbGx5IHVuZGVyc3RhbmQgdGhpcyBGaXhlcyB0YWcu
ICBUaGlzIHNlZW1zIGxpa2UgYSBmZWF0dXJlLApub3QgYSBmaXguICBJZiB5b3Ugd2FudCBpdCBp
biBzdGFibGUgcmVsZWFzZXMgYXMgYSBmZWF0dXJlLCByZXF1ZXN0IGl0CnZpYSBDYzogc3RhYmxl
QHZnZXIua2VybmVsLm9yZy4gIEknZCBkcm9wIHRoYXQgdGFnLCB0aGF0J3MgbXkgbml0LgpPdGhl
cndpc2U6CgpSZXZpZXdlZC1ieTogQWxleCBXaWxsaWFtc29uIDxhbGV4LndpbGxpYW1zb25AcmVk
aGF0LmNvbT4KCj4gU2lnbmVkLW9mZi1ieTogQXNob2sgUmFqIDxhc2hvay5yYWpAaW50ZWwuY29t
Pgo+IFRvOiBKb2VyZyBSb2VkZWwgPGpvcm9AOGJ5dGVzLm9yZz4KPiBUbzogQmpvcm4gSGVsZ2Fh
cyA8YmhlbGdhYXNAZ29vZ2xlLmNvbT4KPiBDYzogbGludXgta2VybmVsQHZnZXIua2VybmVsLm9y
Zwo+IENjOiBpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwo+IENjOiBMdSBCYW9sdSA8
YmFvbHUubHVAbGludXguaW50ZWwuY29tPgo+IENjOiBBbGV4IFdpbGxpYW1zb24gPGFsZXgud2ls
bGlhbXNvbkByZWRoYXQuY29tPgo+IENjOiBEYXJyZWwgR29lZGRlbCA8REdvZWRkZWxAZm9yY2Vw
b2ludC5jb20+Cj4gQ2M6IE1hcmsgU2NvdHQgPG1zY290dEBmb3JjZXBvaW50LmNvbT4sCj4gQ2M6
IFJvbWlsIFNoYXJtYSA8cnNoYXJtYUBmb3JjZXBvaW50LmNvbT4KPiBDYzogQXNob2sgUmFqIDxh
c2hvay5yYWpAaW50ZWwuY29tPgo+IC0tLQo+IHYyOiBNb3ZlZCBmdW5jdGlvbmFsaXR5IGZyb20g
aW9tbXUgdG8gcGNpIHF1aXJrcyAtIEFsZXggV2lsbGlhbXNvbgo+IAo+ICBkcml2ZXJzL3BjaS9x
dWlya3MuYyB8IDE1ICsrKysrKysrKysrKysrKwo+ICAxIGZpbGUgY2hhbmdlZCwgMTUgaW5zZXJ0
aW9ucygrKQo+IAo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9xdWlya3MuYyBiL2RyaXZlcnMv
cGNpL3F1aXJrcy5jCj4gaW5kZXggMjhjOWEyNDA5YzUwLi42MzM3M2NhMGEzZmUgMTAwNjQ0Cj4g
LS0tIGEvZHJpdmVycy9wY2kvcXVpcmtzLmMKPiArKysgYi9kcml2ZXJzL3BjaS9xdWlya3MuYwo+
IEBAIC00NjgyLDYgKzQ2ODIsMjAgQEAgc3RhdGljIGludCBwY2lfcXVpcmtfbWZfZW5kcG9pbnRf
YWNzKHN0cnVjdCBwY2lfZGV2ICpkZXYsIHUxNiBhY3NfZmxhZ3MpCj4gIAkJUENJX0FDU19DUiB8
IFBDSV9BQ1NfVUYgfCBQQ0lfQUNTX0RUKTsKPiAgfQo+ICAKPiArc3RhdGljIGludCBwY2lfcXVp
cmtfcmNpZXBfYWNzKHN0cnVjdCBwY2lfZGV2ICpkZXYsIHUxNiBhY3NfZmxhZ3MpCj4gK3sKPiAr
CS8qCj4gKwkgKiBSQ2lFUCdzIGFyZSByZXF1aXJlZCB0byBhbGxvdyBwMnAgb25seSBvbiB0cmFu
c2xhdGVkIGFkZHJlc3Nlcy4KPiArCSAqIFJlZmVyIHRvIEludGVsIFZULWQgc3BlY2lmaWNhdGlv
biBTZWN0aW9uIDMuMTYgUm9vdC1Db21wbGV4IFBlZXIKPiArCSAqIHRvIFBlZXIgQ29uc2lkZXJh
dGlvbnMKPiArCSAqLwo+ICsJaWYgKHBjaV9wY2llX3R5cGUoZGV2KSAhPSBQQ0lfRVhQX1RZUEVf
UkNfRU5EKQo+ICsJCXJldHVybiAtRU5PVFRZOwo+ICsKPiArCXJldHVybiBwY2lfYWNzX2N0cmxf
ZW5hYmxlZChhY3NfZmxhZ3MsCj4gKwkJUENJX0FDU19TViB8IFBDSV9BQ1NfUlIgfCBQQ0lfQUNT
X0NSIHwgUENJX0FDU19VRik7Cj4gK30KPiArCj4gIHN0YXRpYyBpbnQgcGNpX3F1aXJrX2JyY21f
YWNzKHN0cnVjdCBwY2lfZGV2ICpkZXYsIHUxNiBhY3NfZmxhZ3MpCj4gIHsKPiAgCS8qCj4gQEAg
LTQ3NjQsNiArNDc3OCw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgcGNpX2Rldl9hY3NfZW5hYmxl
ZCB7Cj4gIAkvKiBJMjE5ICovCj4gIAl7IFBDSV9WRU5ET1JfSURfSU5URUwsIDB4MTViNywgcGNp
X3F1aXJrX21mX2VuZHBvaW50X2FjcyB9LAo+ICAJeyBQQ0lfVkVORE9SX0lEX0lOVEVMLCAweDE1
YjgsIHBjaV9xdWlya19tZl9lbmRwb2ludF9hY3MgfSwKPiArCXsgUENJX1ZFTkRPUl9JRF9JTlRF
TCwgUENJX0FOWV9JRCwgcGNpX3F1aXJrX3JjaWVwX2FjcyB9LAo+ICAJLyogUUNPTSBRREYyeHh4
IHJvb3QgcG9ydHMgKi8KPiAgCXsgUENJX1ZFTkRPUl9JRF9RQ09NLCAweDA0MDAsIHBjaV9xdWly
a19xY29tX3JwX2FjcyB9LAo+ICAJeyBQQ0lfVkVORE9SX0lEX1FDT00sIDB4MDQwMSwgcGNpX3F1
aXJrX3Fjb21fcnBfYWNzIH0sCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlv
bi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8v
aW9tbXU=
