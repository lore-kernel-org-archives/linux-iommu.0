Return-Path: <SRS0=wTTv=AV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA69CC433E3
	for <iommu@archiver.kernel.org>; Fri, 10 Jul 2020 23:33:23 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0DB82065F
	for <iommu@archiver.kernel.org>; Fri, 10 Jul 2020 23:33:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="0gruNDRG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0DB82065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 6D3F1221B2;
	Fri, 10 Jul 2020 23:33:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OtJVNUZjNL-O; Fri, 10 Jul 2020 23:33:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 91003221FB;
	Fri, 10 Jul 2020 23:33:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 66624C0890;
	Fri, 10 Jul 2020 23:33:20 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CD2D9C016F
 for <iommu@lists.linux-foundation.org>; Fri, 10 Jul 2020 23:33:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id BDFD486200
 for <iommu@lists.linux-foundation.org>; Fri, 10 Jul 2020 23:32:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lkBt5DY4WOaM for <iommu@lists.linux-foundation.org>;
 Fri, 10 Jul 2020 23:32:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 0FC048610E
 for <iommu@lists.linux-foundation.org>; Fri, 10 Jul 2020 23:32:31 +0000 (UTC)
Received: from localhost (mobile-166-175-191-139.mycingular.net
 [166.175.191.139])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 5BC232077D;
 Fri, 10 Jul 2020 23:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1594423950;
 bh=qZFv1CX9d18PwooaFPG3Jn4rphAd/kDDIDOqrn0KUvE=;
 h=Date:From:To:Cc:Subject:In-Reply-To:From;
 b=0gruNDRG210kwjnDK21/f2TTB84PP+1SoJzPn2oHQjCi5tKSmk9riPN1Myy0i3I5S
 YWdS/bxoFGEx24/CerkDpFJtz6mgMM5kk328PHgXMiZWCtcCUR3yjvCF34MA8YJhpj
 C8GLha9a3p03gOkAEoDi5hHNz3yANGR8dPMazz7Q=
Date: Fri, 10 Jul 2020 18:32:29 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Rajat Jain <rajatja@google.com>
Subject: Re: [PATCH v4 4/4] PCI/ACS: Enable PCI_ACS_TB for
 untrusted/external-facing devices
Message-ID: <20200710233229.GA92058@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CACK8Z6F-8OZNJU8wqWuZq=moCaOi+3W=CzBeppfO31VZnkqBrg@mail.gmail.com>
Cc: Todd Broch <tbroch@google.com>, linux-pci <linux-pci@vger.kernel.org>,
 "Krishnakumar, Lalithambika" <lalithambika.krishnakumar@intel.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Diego Rivas <diegorivas@google.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Furquan Shaikh <furquan@google.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 Saravana Kannan <saravanak@google.com>,
 ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
 Christian Kellner <christian@kellner.me>,
 Mattias Nissler <mnissler@google.com>, Jesse Barnes <jsbarnes@google.com>,
 Len Brown <lenb@kernel.org>, Rajat Jain <rajatxjain@gmail.com>,
 Prashant Malani <pmalani@google.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Aaron Durbin <adurbin@google.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Bernie Keany <bernie.keany@intel.com>, Duncan Laurie <dlaurie@google.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "open list:AMD IOMMU \(AMD-VI\)" <iommu@lists.linux-foundation.org>,
 Arnd Bergmann <arnd@arndb.de>, Oliver O'Halloran <oohall@gmail.com>,
 Benson Leung <bleung@google.com>, David Woodhouse <dwmw2@infradead.org>,
 Alex Levin <levinale@google.com>
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

T24gRnJpLCBKdWwgMTAsIDIwMjAgYXQgMDM6NTM6NTlQTSAtMDcwMCwgUmFqYXQgSmFpbiB3cm90
ZToKPiBPbiBGcmksIEp1bCAxMCwgMjAyMCBhdCAyOjI5IFBNIFJhaiwgQXNob2sgPGFzaG9rLnJh
akBpbnRlbC5jb20+IHdyb3RlOgo+ID4gT24gRnJpLCBKdWwgMTAsIDIwMjAgYXQgMDM6Mjk6MjJQ
TSAtMDUwMCwgQmpvcm4gSGVsZ2FhcyB3cm90ZToKPiA+ID4gT24gVHVlLCBKdWwgMDcsIDIwMjAg
YXQgMDM6NDY6MDRQTSAtMDcwMCwgUmFqYXQgSmFpbiB3cm90ZToKPiA+ID4gPiBXaGVuIGVuYWJs
aW5nIEFDUywgZW5hYmxlIHRyYW5zbGF0aW9uIGJsb2NraW5nIGZvciBleHRlcm5hbCBmYWNpbmcg
cG9ydHMKPiA+ID4gPiBhbmQgdW50cnVzdGVkIGRldmljZXMuCj4gPiA+ID4KPiA+ID4gPiBTaWdu
ZWQtb2ZmLWJ5OiBSYWphdCBKYWluIDxyYWphdGphQGdvb2dsZS5jb20+Cj4gPiA+ID4gLS0tCj4g
PiA+ID4gdjQ6IEFkZCBicmFjZXMgdG8gYXZvaWQgd2FybmluZyBmcm9tIGtlcm5lbCByb2JvdAo+
ID4gPiA+ICAgICBwcmludCB3YXJuaW5nIGZvciBvbmx5IGV4dGVybmFsLWZhY2luZyBkZXZpY2Vz
Lgo+ID4gPiA+IHYzOiBwcmludCB3YXJuaW5nIGlmIEFDU19UQiBub3Qgc3VwcG9ydGVkIG9uIGV4
dGVybmFsLWZhY2luZy91bnRydXN0ZWQgcG9ydHMuCj4gPiA+ID4gICAgIE1pbm9yIGNvZGUgY29t
bWVudHMgZml4ZXMuCj4gPiA+ID4gdjI6IENvbW1pdCBsb2cgY2hhbmdlCj4gPiA+ID4KPiA+ID4g
PiAgZHJpdmVycy9wY2kvcGNpLmMgICAgfCAgOCArKysrKysrKwo+ID4gPiA+ICBkcml2ZXJzL3Bj
aS9xdWlya3MuYyB8IDE1ICsrKysrKysrKysrKysrKwo+ID4gPiA+ICAyIGZpbGVzIGNoYW5nZWQs
IDIzIGluc2VydGlvbnMoKykKPiA+ID4gPgo+ID4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3Bj
aS9wY2kuYyBiL2RyaXZlcnMvcGNpL3BjaS5jCj4gPiA+ID4gaW5kZXggNzNhODYyNzgyMjE0MC4u
YTVhNmJlYTdhZjdjZSAxMDA2NDQKPiA+ID4gPiAtLS0gYS9kcml2ZXJzL3BjaS9wY2kuYwo+ID4g
PiA+ICsrKyBiL2RyaXZlcnMvcGNpL3BjaS5jCj4gPiA+ID4gQEAgLTg3Niw2ICs4NzYsMTQgQEAg
c3RhdGljIHZvaWQgcGNpX3N0ZF9lbmFibGVfYWNzKHN0cnVjdCBwY2lfZGV2ICpkZXYpCj4gPiA+
ID4gICAgIC8qIFVwc3RyZWFtIEZvcndhcmRpbmcgKi8KPiA+ID4gPiAgICAgY3RybCB8PSAoY2Fw
ICYgUENJX0FDU19VRik7Cj4gPiA+ID4KPiA+ID4gPiArICAgLyogRW5hYmxlIFRyYW5zbGF0aW9u
IEJsb2NraW5nIGZvciBleHRlcm5hbCBkZXZpY2VzICovCj4gPiA+ID4gKyAgIGlmIChkZXYtPmV4
dGVybmFsX2ZhY2luZyB8fCBkZXYtPnVudHJ1c3RlZCkgewo+ID4gPiA+ICsgICAgICAgICAgIGlm
IChjYXAgJiBQQ0lfQUNTX1RCKQo+ID4gPiA+ICsgICAgICAgICAgICAgICAgICAgY3RybCB8PSBQ
Q0lfQUNTX1RCOwo+ID4gPiA+ICsgICAgICAgICAgIGVsc2UgaWYgKGRldi0+ZXh0ZXJuYWxfZmFj
aW5nKQo+ID4gPiA+ICsgICAgICAgICAgICAgICAgICAgcGNpX3dhcm4oZGV2LCAiQUNTOiBObyBU
cmFuc2xhdGlvbiBCbG9ja2luZyBvbiBleHRlcm5hbC1mYWNpbmcgZGV2XG4iKTsKPiA+ID4gPiAr
ICAgfQo+ID4gPgo+ID4gPiBJSVVDLCB0aGlzIG1lYW5zIHRoYXQgZXh0ZXJuYWwgZGV2aWNlcyBj
YW4gKm5ldmVyKiB1c2UgQVRTCj4gPiBhbmQgY2FuCj4gPiA+IG5ldmVyIGNhY2hlIHRyYW5zbGF0
aW9ucy4KPiAKPiBZZXMsIGJ1dCBpdCBhbHJlYWR5IGV4aXN0cyB0b2RheSAoYW5kIHRoaXMgcGF0
Y2ggZG9lc24ndCBjaGFuZ2UgdGhhdCk6Cj4gNTIxMzc2NzQxYjJjMiAiUENJL0FUUzogT25seSBl
bmFibGUgQVRTIGZvciB0cnVzdGVkIGRldmljZXMiCgpJZiB5b3UgZ2V0IGluIHRoZSBoYWJpdCBv
ZiB1c2luZyB0aGUgY29tbWl0IHJlZmVyZW5jZSBzdHlsZSBmcm9tCkRvY3VtZW50YXRpb24vcHJv
Y2Vzcy9zdWJtaXR0aW5nLXBhdGNoZXMucnN0IGl0IHNhdmVzIG1lIHRoZSB0cm91YmxlCm9mIGZp
eGluZyB0aGVtLiAgSSB1c2UgdGhpczoKCiAgZ3NyIGlzIGFsaWFzZWQgdG8gYGdpdCAtLW5vLXBh
Z2VyIHNob3cgLXMgLS1hYmJyZXYtY29tbWl0IC0tYWJicmV2PTEyIC0tcHJldHR5PWZvcm1hdDoi
JWggKFwiJXNcIiklbiInCgo+IElNSE8gYW55IGV4dGVybmFsIGRldmljZSB0cnlpbmcgdG8gc2Vu
ZCBBVFMgdHJhZmZpYyBkZXNwaXRlIGhhdmluZwo+IEFUUyBkaXNhYmxlZCBzaG91bGQgY291bnQg
YXMgYSBiYWQgaW50ZW50LiBBbmQgdGhpcyBwYXRjaCBpcyB0cnlpbmcKPiB0byBwbHVnIHRoYXQg
bG9vcGhvbGUsIGJ5IGJsb2NraW5nIHRoZSBBVCB0cmFmZmljIGZyb20gZGV2aWNlcyB0aGF0Cj4g
d2UgZG8gbm90IGV4cGVjdCB0byBzZWUgQVQgZnJvbSBhbnl3YXkuCgpUaGF0J3MgZXhhY3RseSB0
aGUgc29ydCBvZiBhc3NlcnRpb24gSSB3YXMgbG9va2luZyBmb3IuICBJZiB3ZSBjYW4gZ2V0CnNv
bWV0aGluZyBsaWtlIHRoaXMgZXhwbGFuYXRpb24gaW50byB0aGUgY29tbWl0IGxvZywgYW5kIGlm
IEFzaG9rIGFuZApBbGV4IGFyZSBPSyB3aXRoIHRoaXMsIHdlJ2xsIGJlIG11Y2ggY2xvc2VyLgoK
SXQgc291bmRzIGxpa2UgdGhpcyBpcyBqdXN0IGVuZm9yY2luZyBhIHJlc3RyaWN0aW9uIHdlIGFs
cmVhZHkgaGF2ZSwKaS5lLiwgZW5hYmxpbmcgUENJX0FDU19UQiBibG9ja3MgdHJhbnNsYXRlZCBy
ZXF1ZXN0cyBmcm9tIGRldmljZXMgdGhhdAphcmVuJ3Qgc3VwcG9zZWQgdG8gYmUgZ2VuZXJhdGlu
ZyB0aGVtLgoKPiBEbyB5b3Ugc2VlIGFueSBjYXNlIHdoZXJlIHRoaXMgaXMgbm90IHRydWU/Cj4g
Cj4gPiAgQW5kIChJIGd1ZXNzLCBJJ20gbm90IGFuIGV4cGVydCkgaXQgY2FuCj4gPiA+IGFsc28g
bmV2ZXIgdXNlIHRoZSBQYWdlIFJlcXVlc3QgU2VydmljZXM/Cj4gPgo+ID4gWWVwLCBzb3VuZHMg
bGlrZSBpdC4KPiAKPiBZZXMsIGZyb20gc3BlYyAiQWRkcmVzcyBUcmFuc2xhdGlvbiBTZXJ2aWNl
cyIgUmV2IDEuMToKPiAiLi4uYSBkZXZpY2UgdGhhdCBzdXBwb3J0cyBBVFMgbmVlZCBub3Qgc3Vw
cG9ydCBQUkksIGJ1dCBQUkkgaXMKPiBkZXBlbmRlbnQgb24gQVRT4oCZcyBjYXBhYmlsaXRpZXMu
Igo+IChTbyBubyBBVFMgPSBObyBQUkkpLgo+IAo+ID4gPiBJcyB0aGlzIHdoYXQgd2Ugd2FudD8g
IERvIHdlIGhhdmUgYW55IGlkZWEgaG93IG1hbnkgZXh0ZXJuYWwKPiA+ID4gZGV2aWNlcyB0aGlz
IHdpbGwgYWZmZWN0IG9yIGhvdyBtdWNoIG9mIGEgcGVyZm9ybWFuY2UgaW1wYWN0Cj4gPiA+IHRo
ZXkgd2lsbCBzZWU/Cj4gPiA+Cj4gPiA+IERvIHdlIG5lZWQgc29tZSBraW5kIG9mIG92ZXJyaWRl
IG9yIG1lY2hhbmlzbSB0byBhdXRoZW50aWNhdGUKPiA+ID4gY2VydGFpbiBkZXZpY2VzIHNvIHRo
ZXkgY2FuIHVzZSBBVFMgYW5kIFBSST8KPiA+Cj4gPiBTb3VuZHMgbGlrZSB3ZSB3b3VsZCBuZWVk
IHNvbWUgZm9ybSBvZiBhbiBhbGxvdy1saXN0IHRvIHN0YXJ0IHdpdGgKPiA+IHNvIHdlIGNhbiBo
YXZlIHNvbWV0aGluZyBpbiB0aGUgaW50ZXJpbS4KPiAKPiBJIGFzc3VtZSB3aGF0IGlzIGJlaW5n
IHJlZmVycmVkIHRvLCBpcyBhbiBlc2NhcGUgaGF0Y2ggdG8gZW5hYmxlIEFUUwo+IG9uIGNlcnRh
aW4gZ2l2ZW4gImV4dGVybmFsLWZhY2luZyIgcG9ydHMgKGFuZCBkZXZpY2VzIGRvd25zdHJlYW0g
b24KPiB0aGF0IHBvcnQpLiBEbyB3ZSByZWFsbHkgdGhpbmsgYSAqcGVyLXBvcnQqIGNvbnRyb2wg
Zm9yIEFUUyBtYXkgYmUKPiBuZWVkZWQ/IEkgY2FuIGFkZCBpZiB0aGVyZSBpcyBjb25zZW5zdXMg
YWJvdXQgdGhpcy4KPiAKPiA+IEkgc3VwcG9zZSBhIGZ1dHVyZSBwbGF0Zm9ybSBtaWdodCBoYXZl
IGEgZmFjaWx0eSB0byBlbnN1cmUgQVRTIGlzCj4gPiBzZWN1cmUgYW5kIGF1dGhlbnRpY2F0ZWQg
d2UgY291bGQgZW5hYmxlIGZvciBhbGwgb2YgZGV2aWNlcyBpbiB0aGUKPiA+IHN5c3RlbSwgaW4g
YWRkaXRpb24gdG8gUENJIENNQS9JREUuCj4gPgo+ID4gSSB0aGluayBoYXZpbmcgYSBnbG9iYWwg
b3ZlcnJpZGUgdG8gZW5hYmxlIGFsbCBkZXZpY2VzIHNvIHBsYXRmb3JtCj4gPiBjYW4gc3dpdGNo
IHRvIGN1cnJlbnQgYmVoYXZpb3IsIG9yIG1heWJlIHZpYSBhIGNtZGxpbmUgc3dpdGNoLi4gYXMK
PiA+IG11Y2ggYXMgd2UgaGF2ZSBhIGJpbGxpb24gb2YgdGhvc2UsIGl0IHN0aWxsIGdpdmVzIGFu
IG9wdGlvbiBpbgo+ID4gY2FzZSBzb21lb25lIG5lZWRzIGl0Lgo+IAo+IEN1cnJlbnRseToKPiAK
PiBwY2kubm9hdHMgPT4gTm8gQVRTIG9uIGFsbCBQQ0kgZGV2aWNlcy4KPiAoQWJzZW5zZSBvZiBw
Y2kubm9hdHMpOiBBVFMgb24gYWxsIFBDSSBkZXZpY2VzLCBFWENFUFQgZXh0ZXJuYWwgZGV2aWNl
cy4KCllvdSBtZWFuIHRoZSAicGNpPW5vYXRzIiBrZXJuZWwgY29tbWFuZCBsaW5lIHBhcmFtZXRl
ciwgcmlnaHQ/Cgo+IEkgY2FuIGxvb2sgdG8gYWRkIGFub3RoZXIgcGFyYW1ldGVyIHRoYXQgaXMg
c3lub255bW91cyB0bwo+ICJ0cnVzdC1leHRlcm5hbC1wY2ktZGV2aWNlcyIgdGhhdCBjYW4ga2Vl
cCBBVFMgZW5hYmxlZCBvbiBleHRlcm5hbAo+IHBvcnRzIGFzIHdlbGwuIEkgdGhpbmsgdGhpcyBp
cyBiZXR0ZXIgdGhhbiBhbiBhbGxvdy1saXN0IG9mIG9ubHkKPiBjZXJ0YWluIHBvcnRzLCBiZWNh
dXNlIG1vc3QgbGlrZWx5IGFuIGFkbWluIHdpbGwgdHJ1c3QgYWxsIGl0cwo+IGV4dGVybmFsIHBv
cnRzLCBvciBub3QuIEFsc28sIHdlIGNhbiBhZGQgdGhpcyBnbG9iYWwgb3ZlcnJpZGUgYW5kCj4g
bWF5IGJlIGFkZCBhIG1vcmUgZ3JhbnVsYXIgY29udHJvbCBsYXRlciwgaWYgYW5kIHdoZW4gcmVh
bGx5IG5lZWRlZC4KCkkgdGhpbmsgdGhpcyB3b3VsZCBiZSBuZXcgZnVuY3Rpb25hbGl0eSB0aGF0
IHdlIGRvbid0IGhhdmUgdG9kYXksIGFuZAp3ZSBkb24ndCBoYXZlIGFueXRoaW5nIHRoYXQgYWN0
dWFsbHkgKm5lZWRzKiBpdCBBRkFJSywgc28gSSB3b3VsZG4ndApib3RoZXIuCgpCam9ybgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5n
IGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51
eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
