Return-Path: <SRS0=mWFx=7O=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 448F9C433E1
	for <iommu@archiver.kernel.org>; Mon,  1 Jun 2020 21:25:28 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1D87206E2
	for <iommu@archiver.kernel.org>; Mon,  1 Jun 2020 21:25:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tfnv5ezJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1D87206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id BC13E87D05;
	Mon,  1 Jun 2020 21:25:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ofDmapH3ipyl; Mon,  1 Jun 2020 21:25:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id F13DD87CD4;
	Mon,  1 Jun 2020 21:25:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E2E92C088C;
	Mon,  1 Jun 2020 21:25:26 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 51D62C0176
 for <iommu@lists.linux-foundation.org>; Mon,  1 Jun 2020 21:25:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 38EF084559
 for <iommu@lists.linux-foundation.org>; Mon,  1 Jun 2020 21:25:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GfS-8K1SxeYZ for <iommu@lists.linux-foundation.org>;
 Mon,  1 Jun 2020 21:25:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 0186D84547
 for <iommu@lists.linux-foundation.org>; Mon,  1 Jun 2020 21:25:22 +0000 (UTC)
Received: from localhost (mobile-166-175-190-200.mycingular.net
 [166.175.190.200])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 80095206E2;
 Mon,  1 Jun 2020 21:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1591046721;
 bh=8Qt9e+XiD+FUR7h1k2mvt1mhtQNAprWB2mByevBZk2U=;
 h=Date:From:To:Cc:Subject:In-Reply-To:From;
 b=Tfnv5ezJEYhLG3oubFQtNlNFDM77YpLtWpiK17A5c0idmWA0mdy6adF/ky3z8yezb
 8VvAj0fYHRPVM1uO6EGqVvCNwlE4uemfr8zUQf+2srN1kYRkSwQUWbVu/rvP/xJHQy
 MOgFpUic5ewR3UBpiwKZLLng4DXpV+RPrUWYTQLM=
Date: Mon, 1 Jun 2020 16:25:19 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ashok Raj <ashok.raj@intel.com>
Subject: Re: [PATCH] PCI: Relax ACS requirement for Intel RCiEP devices.
Message-ID: <20200601212519.GA758937@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1590699462-7131-1-git-send-email-ashok.raj@intel.com>
Cc: Alex Williamson <alex.williamson@redhat.com>,
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

T24gVGh1LCBNYXkgMjgsIDIwMjAgYXQgMDE6NTc6NDJQTSAtMDcwMCwgQXNob2sgUmFqIHdyb3Rl
Ogo+IEFsbCBJbnRlbCBwbGF0Zm9ybXMgZ3VhcmFudGVlIHRoYXQgYWxsIHJvb3QgY29tcGxleCBp
bXBsZW1lbnRhdGlvbnMKPiBtdXN0IHNlbmQgdHJhbnNhY3Rpb25zIHVwIHRvIElPTU1VIGZvciBh
ZGRyZXNzIHRyYW5zbGF0aW9ucy4gSGVuY2UgZm9yCj4gUkNpRVAgZGV2aWNlcyB0aGF0IGFyZSBW
ZW5kb3IgSUQgSW50ZWwsIGNhbiBjbGFpbSBleGNlcHRpb24gZm9yIGxhY2sgb2YKPiBBQ1Mgc3Vw
cG9ydC4KPiAKPiAKPiAzLjE2IFJvb3QtQ29tcGxleCBQZWVyIHRvIFBlZXIgQ29uc2lkZXJhdGlv
bnMKPiBXaGVuIERNQSByZW1hcHBpbmcgaXMgZW5hYmxlZCwgcGVlci10by1wZWVyIHJlcXVlc3Rz
IHRocm91Z2ggdGhlCj4gUm9vdC1Db21wbGV4IG11c3QgYmUgaGFuZGxlZAo+IGFzIGZvbGxvd3M6
Cj4g4oCiIFRoZSBpbnB1dCBhZGRyZXNzIGluIHRoZSByZXF1ZXN0IGlzIHRyYW5zbGF0ZWQgKHRo
cm91Z2ggZmlyc3QtbGV2ZWwsCj4gICBzZWNvbmQtbGV2ZWwgb3IgbmVzdGVkIHRyYW5zbGF0aW9u
KSB0byBhIGhvc3QgcGh5c2ljYWwgYWRkcmVzcyAoSFBBKS4KPiAgIFRoZSBhZGRyZXNzIGRlY29k
aW5nIGZvciBwZWVyIGFkZHJlc3NlcyBtdXN0IGJlIGRvbmUgb25seSBvbiB0aGUKPiAgIHRyYW5z
bGF0ZWQgSFBBLiBIYXJkd2FyZSBpbXBsZW1lbnRhdGlvbnMgYXJlIGZyZWUgdG8gZnVydGhlciBs
aW1pdAo+ICAgcGVlci10by1wZWVyIGFjY2Vzc2VzIHRvIHNwZWNpZmljIGhvc3QgcGh5c2ljYWwg
YWRkcmVzcyByZWdpb25zCj4gICAob3IgdG8gY29tcGxldGVseSBkaXNhbGxvdyBwZWVyLWZvcndh
cmRpbmcgb2YgdHJhbnNsYXRlZCByZXF1ZXN0cykuCj4g4oCiIFNpbmNlIGFkZHJlc3MgdHJhbnNs
YXRpb24gY2hhbmdlcyB0aGUgY29udGVudHMgKGFkZHJlc3MgZmllbGQpIG9mCj4gICB0aGUgUENJ
IEV4cHJlc3MgVHJhbnNhY3Rpb24gTGF5ZXIgUGFja2V0IChUTFApLCBmb3IgUENJIEV4cHJlc3MK
PiAgIHBlZXItdG8tcGVlciByZXF1ZXN0cyB3aXRoIEVDUkMsIHRoZSBSb290LUNvbXBsZXggaGFy
ZHdhcmUgbXVzdCB1c2UKPiAgIHRoZSBuZXcgRUNSQyAocmUtY29tcHV0ZWQgd2l0aCB0aGUgdHJh
bnNsYXRlZCBhZGRyZXNzKSBpZiBpdAo+ICAgZGVjaWRlcyB0byBmb3J3YXJkIHRoZSBUTFAgYXMg
YSBwZWVyIHJlcXVlc3QuCj4g4oCiIFJvb3QtcG9ydHMsIGFuZCBtdWx0aS1mdW5jdGlvbiByb290
LWNvbXBsZXggaW50ZWdyYXRlZCBlbmRwb2ludHMsIG1heQo+ICAgc3VwcG9ydCBhZGRpdGlvbmFs
IHBlZXJ0by1wZWVyIGNvbnRyb2wgZmVhdHVyZXMgYnkgc3VwcG9ydGluZyBQQ0kgRXhwcmVzcwo+
ICAgQWNjZXNzIENvbnRyb2wgU2VydmljZXMgKEFDUykgY2FwYWJpbGl0eS4gUmVmZXIgdG8gQUNT
IGNhcGFiaWxpdHkgaW4KPiAgIFBDSSBFeHByZXNzIHNwZWNpZmljYXRpb25zIGZvciBkZXRhaWxz
Lgo+IAo+IFNpbmNlIExpbnV4IGRpZG4ndCBnaXZlIHNwZWNpYWwgdHJlYXRtZW50IHRvIGFsbG93
IHRoaXMgZXhjZXB0aW9uLCBjZXJ0YWluCj4gUkNpRVAgTUZEIGRldmljZXMgYXJlIGdldHRpbmcg
Z3JvdXBlZCBpbiBhIHNpbmdsZSBpb21tdSBncm91cC4gVGhpcwo+IGRvZXNuJ3QgcGVybWl0IGEg
c2luZ2xlIGRldmljZSB0byBiZSBhc3NpZ25lZCB0byBhIGd1ZXN0IGZvciBpbnN0YW5jZS4KPiAK
PiBJbiBvbmUgdmVuZG9yIHN5c3RlbTogRGV2aWNlIDE0Lnggd2VyZSBncm91cGVkIGluIGEgc2lu
Z2xlIElPTU1VIGdyb3VwLgo+IAo+IC9zeXMva2VybmVsL2lvbW11X2dyb3Vwcy81L2RldmljZXMv
MDAwMDowMDoxNC4wCj4gL3N5cy9rZXJuZWwvaW9tbXVfZ3JvdXBzLzUvZGV2aWNlcy8wMDAwOjAw
OjE0LjIKPiAvc3lzL2tlcm5lbC9pb21tdV9ncm91cHMvNS9kZXZpY2VzLzAwMDA6MDA6MTQuMwo+
IAo+IEFmdGVyIHRoZSBwYXRjaDoKPiAvc3lzL2tlcm5lbC9pb21tdV9ncm91cHMvNS9kZXZpY2Vz
LzAwMDA6MDA6MTQuMAo+IC9zeXMva2VybmVsL2lvbW11X2dyb3Vwcy81L2RldmljZXMvMDAwMDow
MDoxNC4yCj4gL3N5cy9rZXJuZWwvaW9tbXVfZ3JvdXBzLzYvZGV2aWNlcy8wMDAwOjAwOjE0LjMg
PDw8IG5ldyBncm91cAo+IAo+IDE0LjAgYW5kIDE0LjIgYXJlIGludGVncmF0ZWQgZGV2aWNlcywg
YnV0IGxlZ2FjeSBlbmQgcG9pbnRzLgo+IFdoZXJlYXMgMTQuMyB3YXMgYSBQQ0llIGNvbXBsaWFu
dCBSQ2lFUC4KPiAKPiAwMDoxNC4zIE5ldHdvcmsgY29udHJvbGxlcjogSW50ZWwgQ29ycG9yYXRp
b24gRGV2aWNlIDlkZjAgKHJldiAzMCkKPiBDYXBhYmlsaXRpZXM6IFs0MF0gRXhwcmVzcyAodjIp
IFJvb3QgQ29tcGxleCBJbnRlZ3JhdGVkIEVuZHBvaW50LCBNU0kgMDAKPiAKPiBUaGlzIHBlcm1p
dHMgYXNzaWduaW5nIHRoaXMgZGV2aWNlIHRvIGEgZ3Vlc3QgVk0uCj4gCj4gRml4ZXM6IGYwOTZj
MDYxZjU1MiAoImlvbW11OiBSZXdvcmsgaW9tbXVfZ3JvdXBfZ2V0X2Zvcl9wY2lfZGV2KCkiKQo+
IFNpZ25lZC1vZmYtYnk6IEFzaG9rIFJhaiA8YXNob2sucmFqQGludGVsLmNvbT4KPiBUbzogSm9l
cmcgUm9lZGVsIDxqb3JvQDhieXRlcy5vcmc+Cj4gVG86IEJqb3JuIEhlbGdhYXMgPGJoZWxnYWFz
QGdvb2dsZS5jb20+Cj4gQ2M6IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcKPiBDYzogaW9t
bXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKPiBDYzogTHUgQmFvbHUgPGJhb2x1Lmx1QGxp
bnV4LmludGVsLmNvbT4KPiBDYzogQWxleCBXaWxsaWFtc29uIDxhbGV4LndpbGxpYW1zb25AcmVk
aGF0LmNvbT4KPiBDYzogRGFycmVsIEdvZWRkZWwgPERHb2VkZGVsQGZvcmNlcG9pbnQuY29tPgo+
IENjOiBNYXJrIFNjb3R0IDxtc2NvdHRAZm9yY2Vwb2ludC5jb20+LAo+IENjOiBSb21pbCBTaGFy
bWEgPHJzaGFybWFAZm9yY2Vwb2ludC5jb20+Cj4gQ2M6IEFzaG9rIFJhaiA8YXNob2sucmFqQGlu
dGVsLmNvbT4KClRlbnRhdGl2ZWx5IGFwcGxpZWQgdG8gcGNpL3ZpcnR1YWxpemF0aW9uIGZvciB2
NS44LCB0aGFua3MhCgpUaGUgc3BlYyBzYXlzIHRoaXMgaGFuZGxpbmcgbXVzdCBhcHBseSAid2hl
biBETUEgcmVtYXBwaW5nIGlzCmVuYWJsZWQiLiAgVGhlIHBhdGNoIGRvZXMgbm90IGNoZWNrIHdo
ZXRoZXIgRE1BIHJlbWFwcGluZyBpcyBlbmFibGVkLgoKSXMgdGhlcmUgYW55IGNhc2Ugd2hlcmUg
RE1BIHJlbWFwcGluZyBpcyAqbm90KiBlbmFibGVkLCBhbmQgd2UgcmVseSBvbgp0aGlzIHBhdGNo
IHRvIHRlbGwgdXMgd2hldGhlciB0aGUgZGV2aWNlIGlzIGlzb2xhdGVkPyAgSXQgc291bmRzIGxp
a2UKaXQgbWF5IGdpdmUgdGhlIHdyb25nIGFuc3dlciBpbiBzdWNoIGEgY2FzZT8KCkNhbiB5b3Ug
Y29uZmlybSB0aGF0IEkgZG9uJ3QgbmVlZCB0byB3b3JyeSBhYm91dCB0aGlzPyAgCgo+IC0tLQo+
IHYyOiBNb3ZlZCBmdW5jdGlvbmFsaXR5IGZyb20gaW9tbXUgdG8gcGNpIHF1aXJrcyAtIEFsZXgg
V2lsbGlhbXNvbgo+IAo+ICBkcml2ZXJzL3BjaS9xdWlya3MuYyB8IDE1ICsrKysrKysrKysrKysr
Kwo+ICAxIGZpbGUgY2hhbmdlZCwgMTUgaW5zZXJ0aW9ucygrKQo+IAo+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL3BjaS9xdWlya3MuYyBiL2RyaXZlcnMvcGNpL3F1aXJrcy5jCj4gaW5kZXggMjhjOWEy
NDA5YzUwLi42MzM3M2NhMGEzZmUgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9wY2kvcXVpcmtzLmMK
PiArKysgYi9kcml2ZXJzL3BjaS9xdWlya3MuYwo+IEBAIC00NjgyLDYgKzQ2ODIsMjAgQEAgc3Rh
dGljIGludCBwY2lfcXVpcmtfbWZfZW5kcG9pbnRfYWNzKHN0cnVjdCBwY2lfZGV2ICpkZXYsIHUx
NiBhY3NfZmxhZ3MpCj4gIAkJUENJX0FDU19DUiB8IFBDSV9BQ1NfVUYgfCBQQ0lfQUNTX0RUKTsK
PiAgfQo+ICAKPiArc3RhdGljIGludCBwY2lfcXVpcmtfcmNpZXBfYWNzKHN0cnVjdCBwY2lfZGV2
ICpkZXYsIHUxNiBhY3NfZmxhZ3MpCj4gK3sKPiArCS8qCj4gKwkgKiBSQ2lFUCdzIGFyZSByZXF1
aXJlZCB0byBhbGxvdyBwMnAgb25seSBvbiB0cmFuc2xhdGVkIGFkZHJlc3Nlcy4KPiArCSAqIFJl
ZmVyIHRvIEludGVsIFZULWQgc3BlY2lmaWNhdGlvbiBTZWN0aW9uIDMuMTYgUm9vdC1Db21wbGV4
IFBlZXIKPiArCSAqIHRvIFBlZXIgQ29uc2lkZXJhdGlvbnMKPiArCSAqLwo+ICsJaWYgKHBjaV9w
Y2llX3R5cGUoZGV2KSAhPSBQQ0lfRVhQX1RZUEVfUkNfRU5EKQo+ICsJCXJldHVybiAtRU5PVFRZ
Owo+ICsKPiArCXJldHVybiBwY2lfYWNzX2N0cmxfZW5hYmxlZChhY3NfZmxhZ3MsCj4gKwkJUENJ
X0FDU19TViB8IFBDSV9BQ1NfUlIgfCBQQ0lfQUNTX0NSIHwgUENJX0FDU19VRik7Cj4gK30KPiAr
Cj4gIHN0YXRpYyBpbnQgcGNpX3F1aXJrX2JyY21fYWNzKHN0cnVjdCBwY2lfZGV2ICpkZXYsIHUx
NiBhY3NfZmxhZ3MpCj4gIHsKPiAgCS8qCj4gQEAgLTQ3NjQsNiArNDc3OCw3IEBAIHN0YXRpYyBj
b25zdCBzdHJ1Y3QgcGNpX2Rldl9hY3NfZW5hYmxlZCB7Cj4gIAkvKiBJMjE5ICovCj4gIAl7IFBD
SV9WRU5ET1JfSURfSU5URUwsIDB4MTViNywgcGNpX3F1aXJrX21mX2VuZHBvaW50X2FjcyB9LAo+
ICAJeyBQQ0lfVkVORE9SX0lEX0lOVEVMLCAweDE1YjgsIHBjaV9xdWlya19tZl9lbmRwb2ludF9h
Y3MgfSwKPiArCXsgUENJX1ZFTkRPUl9JRF9JTlRFTCwgUENJX0FOWV9JRCwgcGNpX3F1aXJrX3Jj
aWVwX2FjcyB9LAo+ICAJLyogUUNPTSBRREYyeHh4IHJvb3QgcG9ydHMgKi8KPiAgCXsgUENJX1ZF
TkRPUl9JRF9RQ09NLCAweDA0MDAsIHBjaV9xdWlya19xY29tX3JwX2FjcyB9LAo+ICAJeyBQQ0lf
VkVORE9SX0lEX1FDT00sIDB4MDQwMSwgcGNpX3F1aXJrX3Fjb21fcnBfYWNzIH0sCj4gLS0gCj4g
Mi43LjQKPiAKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
aW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBz
Oi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
