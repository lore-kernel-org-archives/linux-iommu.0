Return-Path: <SRS0=JfOd=4H=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8550C34031
	for <iommu@archiver.kernel.org>; Wed, 19 Feb 2020 00:00:36 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7373208E4
	for <iommu@archiver.kernel.org>; Wed, 19 Feb 2020 00:00:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7373208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 81821204EB;
	Wed, 19 Feb 2020 00:00:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Liqw9wUILFMw; Wed, 19 Feb 2020 00:00:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id A7EAA204C9;
	Wed, 19 Feb 2020 00:00:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 91E77C08A0;
	Wed, 19 Feb 2020 00:00:32 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2559BC013E
 for <iommu@lists.linux-foundation.org>; Wed, 19 Feb 2020 00:00:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 11B3A866AB
 for <iommu@lists.linux-foundation.org>; Wed, 19 Feb 2020 00:00:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NcBhNy+ObPXs for <iommu@lists.linux-foundation.org>;
 Wed, 19 Feb 2020 00:00:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by whitealder.osuosl.org (Postfix) with ESMTPS id BAA098649A
 for <iommu@lists.linux-foundation.org>; Wed, 19 Feb 2020 00:00:29 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 18 Feb 2020 16:00:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,458,1574150400"; d="scan'208";a="253905703"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.213.179])
 ([10.254.213.179])
 by orsmga002.jf.intel.com with ESMTP; 18 Feb 2020 16:00:27 -0800
Subject: Re: dmar fault right around domain switch in iommu_need_mapping
To: Jerry Snitselaar <jsnitsel@redhat.com>, iommu@lists.linux-foundation.org, 
 Joerg Roedel <joro@8bytes.org>
References: <20200218154549.rcav24rkm7rc4hvp@cantor>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <1215cfc2-cfa0-c0d7-01fb-8c5b12dd5a2e@linux.intel.com>
Date: Wed, 19 Feb 2020 08:00:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200218154549.rcav24rkm7rc4hvp@cantor>
Content-Language: en-US
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

SGkgSmVycnksCgpPbiAyMDIwLzIvMTggMjM6NDUsIEplcnJ5IFNuaXRzZWxhYXIgd3JvdGU6Cj4g
SGkgSm9lcmcgYW5kIEJhb2x1LAo+IAo+IEknbSBjaGFzaW5nIGRvd24gb25lIGxhc3QgaXNzdWUu
IEknbSB3YWl0aW5nIHRvIGhlYXIgYmFjayBmcm9tIHRoZW0KPiB0ZXN0aW5nIHdpdGggSm9lcmcn
cyBwYXRjaHNldCwgYnV0IEknbSBndWVzc2luZyB0aGlzIHdpbGwgc3RpbGwgcG9wCj4gdXAuIEl0
IGxvb2tzIGxpa2UgcmlnaHQgYXJvdW5kIHdoZW4gdGhlIGRvbWFpbiBzd2l0Y2ggb2NjdXJzIGlu
Cj4gaW9tbXVfbmVlZF9tYXBwaW5nIHRoZXJlIGFyZSBzb21lIGRtYXIgZmF1bHRzIChiZWxvdyBp
cyBmcm9tIDUuNi1yYzEKPiBwbHVzIGVhcmxpZXIgZml4IGF0dGVtcHQgdGhhdCBtb3ZlZCBkZWZl
cnJlZCBhdHRhY2ggdG8gYmVnaW5uaW5nIG9mCj4gaW9tbXVfbmVlZF9tYXBwaW5nKToKPiAKPiBb
wqDCoCAxMi41NDY5MjBdIERNQVI6IERSSEQ6IGhhbmRsaW5nIGZhdWx0IHN0YXR1cyByZWcgMgo+
IFvCoMKgIDEyLjU0NjkyM10gRE1BUjogW0RNQSBSZWFkXSBSZXF1ZXN0IGRldmljZSBbMDI6MDAu
MF0gUEFTSUQgZmZmZmZmZmYgCj4gZmF1bHQgYWRkciA3OTFkZDAwMCBbZmF1bHQgcmVhc29uIDAy
XSBQcmVzZW50IGJpdCBpbiBjb250ZXh0IGVudHJ5IGlzIGNsZWFyCj4gW8KgwqAgMTIuNjM1MTkz
XSBocHNhIDAwMDA6MDI6MDAuMDogVXNpbmcgaW9tbXUgZG1hIG1hcHBpbmcKPiBbwqDCoCAxMi43
NzY3MTJdIGhwc2EgMDAwMDowMjowMC4wOiBETUFSOiAzMmJpdCBETUEgdXNlcyBub24taWRlbnRp
dHkgbWFwcGluZwo+IAo+IFvCoMKgIDE0LjA5MTIxOV0gRE1BUjogW0RNQSBSZWFkXSBSZXF1ZXN0
IGRldmljZSBbMDc6MDAuMF0gUEFTSUQgZmZmZmZmZmYgCj4gZmF1bHQgYWRkciA3OTFkZDAwMCBb
ZmF1bHQgcmVhc29uIDAyXSBQcmVzZW50IGJpdCBpbiBjb250ZXh0IGVudHJ5IGlzIGNsZWFyCj4g
W8KgwqAgMTQuMTgwODQyXSBETUFSOiBEUkhEOiBoYW5kbGluZyBmYXVsdCBzdGF0dXMgcmVnIDIw
Mgo+IFvCoMKgIDE0LjE4MDg0NV0gRE1BUjogW0RNQSBSZWFkXSBSZXF1ZXN0IGRldmljZSBbMDc6
MDAuMF0gUEFTSUQgZmZmZmZmZmYgCj4gZmF1bHQgYWRkciA3OTFkZDAwMCBbZmF1bHQgcmVhc29u
IDAyXSBQcmVzZW50IGJpdCBpbiBjb250ZXh0IGVudHJ5IGlzIGNsZWFyCj4gW8KgwqAgMTQuMjY4
NzU2XSBETUFSOiBEUkhEOiBoYW5kbGluZyBmYXVsdCBzdGF0dXMgcmVnIDMwMgo+IFvCoMKgIDE1
LjU0MjU1MV0gaHBzYSAwMDAwOjA3OjAwLjA6IFVzaW5nIGlvbW11IGRtYSBtYXBwaW5nCj4gW8Kg
wqAgMTUuNTY3MjU2XSBocHNhIDAwMDA6MDc6MDAuMDogRE1BUjogMzJiaXQgRE1BIHVzZXMgbm9u
LWlkZW50aXR5IG1hcHBpbmcKPiAKPiAKPiBJdCBzZWVtcyB0byBvbmx5IGhhcHBlbiByaWdodCB0
aGVuLCBhbmQgdGhlbiB0aGluZ3MgYXJlIGZpbmUuIEhhcHBlbnMKPiBkdXJpbmcgYm90aCByZWd1
bGFyIGFuZCBrZHVtcCBib290LsKgIFdpdGggdGhlIGtkdW1wIGJvb3QgdGhlIGZhdWx0cwo+IGFy
ZSBmcm9tIHRoZSBocGlsbyBpbiB0aGUgbG9ncyBJJ20gbG9va2luZyBhdCwgc28gaXQgZG9lc24n
dCBzZWVtIHRvCj4gYmUgdGllZCB0byBhIGRldmljZSwgb3IgY2VydGFpbiBybXJyLiBUaGUgZmF1
bHRpbmcgYWRkcmVzcyBhbHdheXMKPiBzZWVtcyB0byBiZSB0aGUgYmFzZSBhZGRyZXNzIG9mIHRo
ZSBybXJyLsKgIFRoZSBkbWFyIHRhYmxlcyBsb29rIHNhbmUuCgpQZXJoYXBzIGxpa2UgdGhpcz8K
ClRoZSBkZXZpY2Ugd2FzIGJvb3Qgd2l0aCBhbiBpZGVudGl0eSBkb21haW4gKGlvbW11PXB0KS4g
V2hlbiBsb2FkaW5nIHRoZQpkcml2ZXIgZm9yIHRoaXMgZGV2aWNlLCBpb21tdSBkcml2ZXIgZmlu
ZHMgdGhhdCBpdCdzIGEgMzItYml0IGRldmljZSBhbmQKdHJpZXMgdG8gY29udmVydCBpdCB0byBE
TUEgZG9tYWluLiBUaGUgcm1yciBpcyBzdGlsbCBhY3RpdmUgZHVyaW5nIHRoZQpzd2l0Y2gsIGhl
bmNlIHlvdSBzZWUgZG1hIGZhdWx0cyBkdXJpbmcgdGhhdCB0aW1lIHdpbmRvdy4KCkJlc3QgcmVn
YXJkcywKYmFvbHUKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpo
dHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
