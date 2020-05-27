Return-Path: <SRS0=MQAj=7J=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28739C433E0
	for <iommu@archiver.kernel.org>; Wed, 27 May 2020 02:51:59 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC4422075F
	for <iommu@archiver.kernel.org>; Wed, 27 May 2020 02:51:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC4422075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 61DB387CCB;
	Wed, 27 May 2020 02:51:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kLSqcYUOLLYM; Wed, 27 May 2020 02:51:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 3F88987C72;
	Wed, 27 May 2020 02:51:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1A729C0888;
	Wed, 27 May 2020 02:51:56 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1DA49C016F
 for <iommu@lists.linux-foundation.org>; Wed, 27 May 2020 02:51:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id D2A89204CD
 for <iommu@lists.linux-foundation.org>; Wed, 27 May 2020 02:51:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sv1KvkuYrcHY for <iommu@lists.linux-foundation.org>;
 Wed, 27 May 2020 02:51:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by silver.osuosl.org (Postfix) with ESMTPS id AE132204C3
 for <iommu@lists.linux-foundation.org>; Wed, 27 May 2020 02:51:52 +0000 (UTC)
IronPort-SDR: T8zY7b2aDa0QITDMPKv6LOVSHlb0ImgQiM+GmfGO64gl//Ry3hafo90WqVwqli6Iyy2VXj2Xd9
 rcJCycrd9ZfA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 May 2020 19:51:52 -0700
IronPort-SDR: IZHzwPU39n6YAGz34ybNx/oUi7IFJXZJV3yMToik2/+nyg9lDC5WwFobtEfKzEIgqFOe58oAvs
 rXns1gJJcfAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,439,1583222400"; d="scan'208";a="270302681"
Received: from zalvear-mobl.amr.corp.intel.com (HELO [10.254.67.58])
 ([10.254.67.58])
 by orsmga006.jf.intel.com with ESMTP; 26 May 2020 19:51:51 -0700
Subject: Re: [PATCH] iommu: Relax ACS requirement for Intel RCiEP devices.
To: Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, Joerg Roedel <joro@8bytes.org>
References: <1590531455-19757-1-git-send-email-ashok.raj@intel.com>
From: "Kuppuswamy, Sathyanarayanan"
 <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <6735b6d5-a04f-57ae-8e3f-f818f07a57a4@linux.intel.com>
Date: Tue, 26 May 2020 19:51:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1590531455-19757-1-git-send-email-ashok.raj@intel.com>
Content-Language: en-US
Cc: Darrel Goeddel <DGoeddel@forcepoint.com>,
 Alex Williamson <alex.williamson@redhat.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Mark Scott <mscott@forcepoint.com>,
 Romil Sharma <rsharma@forcepoint.com>
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

CgpPbiA1LzI2LzIwIDM6MTcgUE0sIEFzaG9rIFJhaiB3cm90ZToKPiBBbGwgSW50ZWwgcGxhdGZv
cm1zIGd1YXJhbnRlZSB0aGF0IGFsbCByb290IGNvbXBsZXggaW1wbGVtZW50YXRpb25zCj4gbXVz
dCBzZW5kIHRyYW5zYWN0aW9ucyB1cCB0byBJT01NVSBmb3IgYWRkcmVzcyB0cmFuc2xhdGlvbnMu
IEhlbmNlIGZvcgo+IFJDaUVQIGRldmljZXMgdGhhdCBhcmUgVmVuZG9yIElEIEludGVsLCBjYW4g
Y2xhaW0gZXhjZXB0aW9uIGZvciBsYWNrIG9mCj4gQUNTIHN1cHBvcnQuCj4gCj4gCj4gMy4xNiBS
b290LUNvbXBsZXggUGVlciB0byBQZWVyIENvbnNpZGVyYXRpb25zCj4gV2hlbiBETUEgcmVtYXBw
aW5nIGlzIGVuYWJsZWQsIHBlZXItdG8tcGVlciByZXF1ZXN0cyB0aHJvdWdoIHRoZQo+IFJvb3Qt
Q29tcGxleCBtdXN0IGJlIGhhbmRsZWQKPiBhcyBmb2xsb3dzOgo+IOKAoiBUaGUgaW5wdXQgYWRk
cmVzcyBpbiB0aGUgcmVxdWVzdCBpcyB0cmFuc2xhdGVkICh0aHJvdWdoIGZpcnN0LWxldmVsLAo+
ICAgIHNlY29uZC1sZXZlbCBvciBuZXN0ZWQgdHJhbnNsYXRpb24pIHRvIGEgaG9zdCBwaHlzaWNh
bCBhZGRyZXNzIChIUEEpLgo+ICAgIFRoZSBhZGRyZXNzIGRlY29kaW5nIGZvciBwZWVyIGFkZHJl
c3NlcyBtdXN0IGJlIGRvbmUgb25seSBvbiB0aGUKPiAgICB0cmFuc2xhdGVkIEhQQS4gSGFyZHdh
cmUgaW1wbGVtZW50YXRpb25zIGFyZSBmcmVlIHRvIGZ1cnRoZXIgbGltaXQKPiAgICBwZWVyLXRv
LXBlZXIgYWNjZXNzZXMgdG8gc3BlY2lmaWMgaG9zdCBwaHlzaWNhbCBhZGRyZXNzIHJlZ2lvbnMK
PiAgICAob3IgdG8gY29tcGxldGVseSBkaXNhbGxvdyBwZWVyLWZvcndhcmRpbmcgb2YgdHJhbnNs
YXRlZCByZXF1ZXN0cykuCj4g4oCiIFNpbmNlIGFkZHJlc3MgdHJhbnNsYXRpb24gY2hhbmdlcyB0
aGUgY29udGVudHMgKGFkZHJlc3MgZmllbGQpIG9mCj4gICAgdGhlIFBDSSBFeHByZXNzIFRyYW5z
YWN0aW9uIExheWVyIFBhY2tldCAoVExQKSwgZm9yIFBDSSBFeHByZXNzCj4gICAgcGVlci10by1w
ZWVyIHJlcXVlc3RzIHdpdGggRUNSQywgdGhlIFJvb3QtQ29tcGxleCBoYXJkd2FyZSBtdXN0IHVz
ZQo+ICAgIHRoZSBuZXcgRUNSQyAocmUtY29tcHV0ZWQgd2l0aCB0aGUgdHJhbnNsYXRlZCBhZGRy
ZXNzKSBpZiBpdAo+ICAgIGRlY2lkZXMgdG8gZm9yd2FyZCB0aGUgVExQIGFzIGEgcGVlciByZXF1
ZXN0Lgo+IOKAoiBSb290LXBvcnRzLCBhbmQgbXVsdGktZnVuY3Rpb24gcm9vdC1jb21wbGV4IGlu
dGVncmF0ZWQgZW5kcG9pbnRzLCBtYXkKPiAgICBzdXBwb3J0IGFkZGl0aW9uYWwgcGVlcnRvLXBl
ZXIgY29udHJvbCBmZWF0dXJlcyBieSBzdXBwb3J0aW5nIFBDSSBFeHByZXNzCj4gICAgQWNjZXNz
IENvbnRyb2wgU2VydmljZXMgKEFDUykgY2FwYWJpbGl0eS4gUmVmZXIgdG8gQUNTIGNhcGFiaWxp
dHkgaW4KPiAgICBQQ0kgRXhwcmVzcyBzcGVjaWZpY2F0aW9ucyBmb3IgZGV0YWlscy4KPiAKPiBT
aW5jZSBMaW51eCBkaWRuJ3QgZ2l2ZSBzcGVjaWFsIHRyZWF0bWVudCB0byBhbGxvdyB0aGlzIGV4
Y2VwdGlvbiwgY2VydGFpbgo+IFJDaUVQIE1GRCBkZXZpY2VzIGFyZSBnZXR0aW5nIGdyb3VwZWQg
aW4gYSBzaW5nbGUgaW9tbXUgZ3JvdXAuIFRoaXMKPiBkb2Vzbid0IHBlcm1pdCBhIHNpbmdsZSBk
ZXZpY2UgdG8gYmUgYXNzaWduZWQgdG8gYSBndWVzdCBmb3IgaW5zdGFuY2UuCj4gCj4gSW4gb25l
IHZlbmRvciBzeXN0ZW06IERldmljZSAxNC54IHdlcmUgZ3JvdXBlZCBpbiBhIHNpbmdsZSBJT01N
VSBncm91cC4KPiAKPiAvc3lzL2tlcm5lbC9pb21tdV9ncm91cHMvNS9kZXZpY2VzLzAwMDA6MDA6
MTQuMAo+IC9zeXMva2VybmVsL2lvbW11X2dyb3Vwcy81L2RldmljZXMvMDAwMDowMDoxNC4yCj4g
L3N5cy9rZXJuZWwvaW9tbXVfZ3JvdXBzLzUvZGV2aWNlcy8wMDAwOjAwOjE0LjMKPiAKPiBBZnRl
ciB0aGUgcGF0Y2g6Cj4gL3N5cy9rZXJuZWwvaW9tbXVfZ3JvdXBzLzUvZGV2aWNlcy8wMDAwOjAw
OjE0LjAKPiAvc3lzL2tlcm5lbC9pb21tdV9ncm91cHMvNS9kZXZpY2VzLzAwMDA6MDA6MTQuMgo+
IC9zeXMva2VybmVsL2lvbW11X2dyb3Vwcy82L2RldmljZXMvMDAwMDowMDoxNC4zIDw8PCBuZXcg
Z3JvdXAKPiAKPiAxNC4wIGFuZCAxNC4yIGFyZSBpbnRlZ3JhdGVkIGRldmljZXMsIGJ1dCBsZWdh
Y3kgZW5kIHBvaW50cy4KPiBXaGVyZWFzIDE0LjMgd2FzIGEgUENJZSBjb21wbGlhbnQgUkNpRVAu
Cj4gCj4gMDA6MTQuMyBOZXR3b3JrIGNvbnRyb2xsZXI6IEludGVsIENvcnBvcmF0aW9uIERldmlj
ZSA5ZGYwIChyZXYgMzApCj4gQ2FwYWJpbGl0aWVzOiBbNDBdIEV4cHJlc3MgKHYyKSBSb290IENv
bXBsZXggSW50ZWdyYXRlZCBFbmRwb2ludCwgTVNJIDAwCj4gCj4gVGhpcyBwZXJtaXRzIGFzc2ln
bmluZyB0aGlzIGRldmljZSB0byBhIGd1ZXN0IFZNLgo+IAo+IEZpeGVzOiBmMDk2YzA2MWY1NTIg
KCJpb21tdTogUmV3b3JrIGlvbW11X2dyb3VwX2dldF9mb3JfcGNpX2RldigpIikKPiBTaWduZWQt
b2ZmLWJ5OiBBc2hvayBSYWogPGFzaG9rLnJhakBpbnRlbC5jb20+Cj4gVG86IEpvZXJnIFJvZWRl
bCA8am9yb0A4Ynl0ZXMub3JnPgo+IFRvOiBCam9ybiBIZWxnYWFzIDxiaGVsZ2Fhc0Bnb29nbGUu
Y29tPgo+IENjOiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnCj4gQ2M6IGlvbW11QGxpc3Rz
LmxpbnV4LWZvdW5kYXRpb24ub3JnCj4gQ2M6IEx1IEJhb2x1IDxiYW9sdS5sdUBsaW51eC5pbnRl
bC5jb20+Cj4gQ2M6IEFsZXggV2lsbGlhbXNvbiA8YWxleC53aWxsaWFtc29uQHJlZGhhdC5jb20+
Cj4gQ2M6IERhcnJlbCBHb2VkZGVsIDxER29lZGRlbEBmb3JjZXBvaW50LmNvbT4KPiBDYzogTWFy
ayBTY290dCA8bXNjb3R0QGZvcmNlcG9pbnQuY29tPiwKPiBDYzogUm9taWwgU2hhcm1hIDxyc2hh
cm1hQGZvcmNlcG9pbnQuY29tPgo+IENjOiBBc2hvayBSYWogPGFzaG9rLnJhakBpbnRlbC5jb20+
Cj4gLS0tCj4gICBkcml2ZXJzL2lvbW11L2lvbW11LmMgfCAxMyArKysrKysrKysrKystCj4gICAx
IGZpbGUgY2hhbmdlZCwgMTIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQo+IAo+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL2lvbW11L2lvbW11LmMgYi9kcml2ZXJzL2lvbW11L2lvbW11LmMKPiBp
bmRleCAyYjQ3MTQxOWUyNmMuLjMxYjU5NWRmZWRkZSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2lv
bW11L2lvbW11LmMKPiArKysgYi9kcml2ZXJzL2lvbW11L2lvbW11LmMKPiBAQCAtMTE4Nyw3ICsx
MTg3LDE4IEBAIHN0YXRpYyBzdHJ1Y3QgaW9tbXVfZ3JvdXAgKmdldF9wY2lfZnVuY3Rpb25fYWxp
YXNfZ3JvdXAoc3RydWN0IHBjaV9kZXYgKnBkZXYsCj4gICAJc3RydWN0IHBjaV9kZXYgKnRtcCA9
IE5VTEw7Cj4gICAJc3RydWN0IGlvbW11X2dyb3VwICpncm91cDsKPiAgIAo+IC0JaWYgKCFwZGV2
LT5tdWx0aWZ1bmN0aW9uIHx8IHBjaV9hY3NfZW5hYmxlZChwZGV2LCBSRVFfQUNTX0ZMQUdTKSkK
PiArCS8qCj4gKwkgKiBJbnRlbCBWVC1kIFNwZWNpZmljYXRpb24gU2VjdGlvbiAzLjE2LCBSb290
LUNvbXBsZXggUGVlciB0byBQZWVyCj4gKwkgKiBDb25zaWRlcmF0aW9ucyBtYW5hZGF0ZSB0aGF0
IGFsbCB0cmFuc2FjdGlvbnMgaW4gUkNpRVAncyBhbmQKPiArCSAqIGV2ZW4gSW50ZWdyYXRlZCBN
RkQncyAqbXVzdCogYmUgc2VudCB1cCB0byB0aGUgSU9NTVUuIFAyUCBpcwo+ICsJICogb25seSBw
b3NzaWJsZSBvbiB0cmFuc2xhdGVkIGFkZHJlc3Nlcy4gVGhpcyBnaXZlcyBlbm91Z2gKPiArCSAq
IGd1YXJhbnRlZSB0aGF0IHN1Y2ggZGV2aWNlcyBjYW4gYmUgZm9yZ2l2ZW4gZm9yIGxhY2sgb2Yg
QUNTCj4gKwkgKiBzdXBwb3J0Lgo+ICsJICovCj4gKwlpZiAoIXBkZXYtPm11bHRpZnVuY3Rpb24g
fHwKPiArCSAgICAocGRldi0+dmVuZG9yID09IFBDSV9WRU5ET1JfSURfSU5URUwgJiYKPiArCSAg
ICAgcGNpX3BjaWVfdHlwZShwZGV2KSA9PSBQQ0lfRVhQX1RZUEVfUkNfRU5EKSB8fAo+ICsJICAg
ICBwY2lfYWNzX2VuYWJsZWQocGRldiwgUkVRX0FDU19GTEFHUykpCkxvb2tzIGdvb2QgdG8gbWUu
ClJldmlld2VkLWJ5OiBLdXBwdXN3YW15IFNhdGh5YW5hcmF5YW5hbiAKPHNhdGh5YW5hcmF5YW5h
bi5rdXBwdXN3YW15QGxpbnV4LmludGVsLmNvbT4KPiAgIAkJcmV0dXJuIE5VTEw7Cj4gICAKPiAg
IAlmb3JfZWFjaF9wY2lfZGV2KHRtcCkgewo+IApfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgt
Zm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4v
bGlzdGluZm8vaW9tbXU=
