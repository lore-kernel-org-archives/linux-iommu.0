Return-Path: <SRS0=mWFx=7O=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22DDEC433E0
	for <iommu@archiver.kernel.org>; Mon,  1 Jun 2020 21:40:31 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C61EF206E2
	for <iommu@archiver.kernel.org>; Mon,  1 Jun 2020 21:40:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C61EF206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id B9839859D9;
	Mon,  1 Jun 2020 21:40:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BycnRw85foFf; Mon,  1 Jun 2020 21:40:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 7B32B859D5;
	Mon,  1 Jun 2020 21:40:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 51068C088C;
	Mon,  1 Jun 2020 21:40:28 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 10F3CC0176
 for <iommu@lists.linux-foundation.org>; Mon,  1 Jun 2020 21:40:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id F10FF203BB
 for <iommu@lists.linux-foundation.org>; Mon,  1 Jun 2020 21:40:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oODtMvi8Sq6U for <iommu@lists.linux-foundation.org>;
 Mon,  1 Jun 2020 21:40:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by silver.osuosl.org (Postfix) with ESMTPS id A6F1E20134
 for <iommu@lists.linux-foundation.org>; Mon,  1 Jun 2020 21:40:24 +0000 (UTC)
IronPort-SDR: oNJY0JEG6NUm+OUw8L7xijgJtkL+M3U2ZzPIbAgukqrsPDs+kX77CXLKCgQ/8qDo5tXsDQ4xth
 fe7nGm1JT9og==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jun 2020 14:40:24 -0700
IronPort-SDR: VgXfb6U2XTqaiIxQec+3VLJOmXxCfX10MydJvZqZJ9Uc2tFJYHQfaOqxLazuZEf+hWo2qcN/jG
 TvV6jUr8NK/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,462,1583222400"; d="scan'208";a="257389245"
Received: from otc-nc-03.jf.intel.com (HELO otc-nc-03) ([10.54.39.25])
 by orsmga007.jf.intel.com with ESMTP; 01 Jun 2020 14:40:23 -0700
Date: Mon, 1 Jun 2020 14:40:23 -0700
From: "Raj, Ashok" <ashok.raj@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH] PCI: Relax ACS requirement for Intel RCiEP devices.
Message-ID: <20200601214023.GA15310@otc-nc-03>
References: <1590699462-7131-1-git-send-email-ashok.raj@intel.com>
 <20200601212519.GA758937@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200601212519.GA758937@bjorn-Precision-5520>
User-Agent: Mutt/1.5.24 (2015-08-30)
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Ashok Raj <ashok.raj@intel.com>, Darrel Goeddel <DGoeddel@forcepoint.com>,
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

T24gTW9uLCBKdW4gMDEsIDIwMjAgYXQgMDQ6MjU6MTlQTSAtMDUwMCwgQmpvcm4gSGVsZ2FhcyB3
cm90ZToKPiBPbiBUaHUsIE1heSAyOCwgMjAyMCBhdCAwMTo1Nzo0MlBNIC0wNzAwLCBBc2hvayBS
YWogd3JvdGU6Cj4gPiBBbGwgSW50ZWwgcGxhdGZvcm1zIGd1YXJhbnRlZSB0aGF0IGFsbCByb290
IGNvbXBsZXggaW1wbGVtZW50YXRpb25zCj4gPiBtdXN0IHNlbmQgdHJhbnNhY3Rpb25zIHVwIHRv
IElPTU1VIGZvciBhZGRyZXNzIHRyYW5zbGF0aW9ucy4gSGVuY2UgZm9yCj4gPiBSQ2lFUCBkZXZp
Y2VzIHRoYXQgYXJlIFZlbmRvciBJRCBJbnRlbCwgY2FuIGNsYWltIGV4Y2VwdGlvbiBmb3IgbGFj
ayBvZgo+ID4gQUNTIHN1cHBvcnQuCj4gPiAKPiA+IAo+ID4gMy4xNiBSb290LUNvbXBsZXggUGVl
ciB0byBQZWVyIENvbnNpZGVyYXRpb25zCj4gPiBXaGVuIERNQSByZW1hcHBpbmcgaXMgZW5hYmxl
ZCwgcGVlci10by1wZWVyIHJlcXVlc3RzIHRocm91Z2ggdGhlCj4gPiBSb290LUNvbXBsZXggbXVz
dCBiZSBoYW5kbGVkCj4gPiBhcyBmb2xsb3dzOgo+ID4g4oCiIFRoZSBpbnB1dCBhZGRyZXNzIGlu
IHRoZSByZXF1ZXN0IGlzIHRyYW5zbGF0ZWQgKHRocm91Z2ggZmlyc3QtbGV2ZWwsCj4gPiAgIHNl
Y29uZC1sZXZlbCBvciBuZXN0ZWQgdHJhbnNsYXRpb24pIHRvIGEgaG9zdCBwaHlzaWNhbCBhZGRy
ZXNzIChIUEEpLgo+ID4gICBUaGUgYWRkcmVzcyBkZWNvZGluZyBmb3IgcGVlciBhZGRyZXNzZXMg
bXVzdCBiZSBkb25lIG9ubHkgb24gdGhlCj4gPiAgIHRyYW5zbGF0ZWQgSFBBLiBIYXJkd2FyZSBp
bXBsZW1lbnRhdGlvbnMgYXJlIGZyZWUgdG8gZnVydGhlciBsaW1pdAo+ID4gICBwZWVyLXRvLXBl
ZXIgYWNjZXNzZXMgdG8gc3BlY2lmaWMgaG9zdCBwaHlzaWNhbCBhZGRyZXNzIHJlZ2lvbnMKPiA+
ICAgKG9yIHRvIGNvbXBsZXRlbHkgZGlzYWxsb3cgcGVlci1mb3J3YXJkaW5nIG9mIHRyYW5zbGF0
ZWQgcmVxdWVzdHMpLgo+ID4g4oCiIFNpbmNlIGFkZHJlc3MgdHJhbnNsYXRpb24gY2hhbmdlcyB0
aGUgY29udGVudHMgKGFkZHJlc3MgZmllbGQpIG9mCj4gPiAgIHRoZSBQQ0kgRXhwcmVzcyBUcmFu
c2FjdGlvbiBMYXllciBQYWNrZXQgKFRMUCksIGZvciBQQ0kgRXhwcmVzcwo+ID4gICBwZWVyLXRv
LXBlZXIgcmVxdWVzdHMgd2l0aCBFQ1JDLCB0aGUgUm9vdC1Db21wbGV4IGhhcmR3YXJlIG11c3Qg
dXNlCj4gPiAgIHRoZSBuZXcgRUNSQyAocmUtY29tcHV0ZWQgd2l0aCB0aGUgdHJhbnNsYXRlZCBh
ZGRyZXNzKSBpZiBpdAo+ID4gICBkZWNpZGVzIHRvIGZvcndhcmQgdGhlIFRMUCBhcyBhIHBlZXIg
cmVxdWVzdC4KPiA+IOKAoiBSb290LXBvcnRzLCBhbmQgbXVsdGktZnVuY3Rpb24gcm9vdC1jb21w
bGV4IGludGVncmF0ZWQgZW5kcG9pbnRzLCBtYXkKPiA+ICAgc3VwcG9ydCBhZGRpdGlvbmFsIHBl
ZXJ0by1wZWVyIGNvbnRyb2wgZmVhdHVyZXMgYnkgc3VwcG9ydGluZyBQQ0kgRXhwcmVzcwo+ID4g
ICBBY2Nlc3MgQ29udHJvbCBTZXJ2aWNlcyAoQUNTKSBjYXBhYmlsaXR5LiBSZWZlciB0byBBQ1Mg
Y2FwYWJpbGl0eSBpbgo+ID4gICBQQ0kgRXhwcmVzcyBzcGVjaWZpY2F0aW9ucyBmb3IgZGV0YWls
cy4KPiA+IAo+ID4gU2luY2UgTGludXggZGlkbid0IGdpdmUgc3BlY2lhbCB0cmVhdG1lbnQgdG8g
YWxsb3cgdGhpcyBleGNlcHRpb24sIGNlcnRhaW4KPiA+IFJDaUVQIE1GRCBkZXZpY2VzIGFyZSBn
ZXR0aW5nIGdyb3VwZWQgaW4gYSBzaW5nbGUgaW9tbXUgZ3JvdXAuIFRoaXMKPiA+IGRvZXNuJ3Qg
cGVybWl0IGEgc2luZ2xlIGRldmljZSB0byBiZSBhc3NpZ25lZCB0byBhIGd1ZXN0IGZvciBpbnN0
YW5jZS4KPiA+IAo+ID4gSW4gb25lIHZlbmRvciBzeXN0ZW06IERldmljZSAxNC54IHdlcmUgZ3Jv
dXBlZCBpbiBhIHNpbmdsZSBJT01NVSBncm91cC4KPiA+IAo+ID4gL3N5cy9rZXJuZWwvaW9tbXVf
Z3JvdXBzLzUvZGV2aWNlcy8wMDAwOjAwOjE0LjAKPiA+IC9zeXMva2VybmVsL2lvbW11X2dyb3Vw
cy81L2RldmljZXMvMDAwMDowMDoxNC4yCj4gPiAvc3lzL2tlcm5lbC9pb21tdV9ncm91cHMvNS9k
ZXZpY2VzLzAwMDA6MDA6MTQuMwo+ID4gCj4gPiBBZnRlciB0aGUgcGF0Y2g6Cj4gPiAvc3lzL2tl
cm5lbC9pb21tdV9ncm91cHMvNS9kZXZpY2VzLzAwMDA6MDA6MTQuMAo+ID4gL3N5cy9rZXJuZWwv
aW9tbXVfZ3JvdXBzLzUvZGV2aWNlcy8wMDAwOjAwOjE0LjIKPiA+IC9zeXMva2VybmVsL2lvbW11
X2dyb3Vwcy82L2RldmljZXMvMDAwMDowMDoxNC4zIDw8PCBuZXcgZ3JvdXAKPiA+IAo+ID4gMTQu
MCBhbmQgMTQuMiBhcmUgaW50ZWdyYXRlZCBkZXZpY2VzLCBidXQgbGVnYWN5IGVuZCBwb2ludHMu
Cj4gPiBXaGVyZWFzIDE0LjMgd2FzIGEgUENJZSBjb21wbGlhbnQgUkNpRVAuCj4gPiAKPiA+IDAw
OjE0LjMgTmV0d29yayBjb250cm9sbGVyOiBJbnRlbCBDb3Jwb3JhdGlvbiBEZXZpY2UgOWRmMCAo
cmV2IDMwKQo+ID4gQ2FwYWJpbGl0aWVzOiBbNDBdIEV4cHJlc3MgKHYyKSBSb290IENvbXBsZXgg
SW50ZWdyYXRlZCBFbmRwb2ludCwgTVNJIDAwCj4gPiAKPiA+IFRoaXMgcGVybWl0cyBhc3NpZ25p
bmcgdGhpcyBkZXZpY2UgdG8gYSBndWVzdCBWTS4KPiA+IAo+ID4gRml4ZXM6IGYwOTZjMDYxZjU1
MiAoImlvbW11OiBSZXdvcmsgaW9tbXVfZ3JvdXBfZ2V0X2Zvcl9wY2lfZGV2KCkiKQo+ID4gU2ln
bmVkLW9mZi1ieTogQXNob2sgUmFqIDxhc2hvay5yYWpAaW50ZWwuY29tPgo+ID4gVG86IEpvZXJn
IFJvZWRlbCA8am9yb0A4Ynl0ZXMub3JnPgo+ID4gVG86IEJqb3JuIEhlbGdhYXMgPGJoZWxnYWFz
QGdvb2dsZS5jb20+Cj4gPiBDYzogbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZwo+ID4gQ2M6
IGlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCj4gPiBDYzogTHUgQmFvbHUgPGJhb2x1
Lmx1QGxpbnV4LmludGVsLmNvbT4KPiA+IENjOiBBbGV4IFdpbGxpYW1zb24gPGFsZXgud2lsbGlh
bXNvbkByZWRoYXQuY29tPgo+ID4gQ2M6IERhcnJlbCBHb2VkZGVsIDxER29lZGRlbEBmb3JjZXBv
aW50LmNvbT4KPiA+IENjOiBNYXJrIFNjb3R0IDxtc2NvdHRAZm9yY2Vwb2ludC5jb20+LAo+ID4g
Q2M6IFJvbWlsIFNoYXJtYSA8cnNoYXJtYUBmb3JjZXBvaW50LmNvbT4KPiA+IENjOiBBc2hvayBS
YWogPGFzaG9rLnJhakBpbnRlbC5jb20+Cj4gCj4gVGVudGF0aXZlbHkgYXBwbGllZCB0byBwY2kv
dmlydHVhbGl6YXRpb24gZm9yIHY1LjgsIHRoYW5rcyEKPiAKPiBUaGUgc3BlYyBzYXlzIHRoaXMg
aGFuZGxpbmcgbXVzdCBhcHBseSAid2hlbiBETUEgcmVtYXBwaW5nIGlzCj4gZW5hYmxlZCIuICBU
aGUgcGF0Y2ggZG9lcyBub3QgY2hlY2sgd2hldGhlciBETUEgcmVtYXBwaW5nIGlzIGVuYWJsZWQu
Cj4gCj4gSXMgdGhlcmUgYW55IGNhc2Ugd2hlcmUgRE1BIHJlbWFwcGluZyBpcyAqbm90KiBlbmFi
bGVkLCBhbmQgd2UgcmVseSBvbgo+IHRoaXMgcGF0Y2ggdG8gdGVsbCB1cyB3aGV0aGVyIHRoZSBk
ZXZpY2UgaXMgaXNvbGF0ZWQ/ICBJdCBzb3VuZHMgbGlrZQo+IGl0IG1heSBnaXZlIHRoZSB3cm9u
ZyBhbnN3ZXIgaW4gc3VjaCBhIGNhc2U/Cj4gCj4gQ2FuIHlvdSBjb25maXJtIHRoYXQgSSBkb24n
dCBuZWVkIHRvIHdvcnJ5IGFib3V0IHRoaXM/ICAKCkkgdGhpbmsgYWxsIG9mIHRoaXMgbWFrZXMg
c2Vuc2Ugb25seSB3aGVuIERNQSByZW1hcHBpbmcgaXMgZW5hYmxlZC4KT3RoZXJ3aXNlIHRoZXJl
IGlzIG5vIGVuZm9yY2VtZW50IGZvciBpc29sYXRpb24uIAoKQ2hlZXJzLApBc2hvawpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxp
c3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZv
dW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
