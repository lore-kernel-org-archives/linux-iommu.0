Return-Path: <SRS0=unsG=4I=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE15AC11D04
	for <iommu@archiver.kernel.org>; Thu, 20 Feb 2020 11:58:28 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A417A20722
	for <iommu@archiver.kernel.org>; Thu, 20 Feb 2020 11:58:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A417A20722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 6272487BA6;
	Thu, 20 Feb 2020 11:58:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NSOrnTr2czsE; Thu, 20 Feb 2020 11:58:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 7018587A4F;
	Thu, 20 Feb 2020 11:58:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 540DFC1D84;
	Thu, 20 Feb 2020 11:58:27 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4B747C013E
 for <iommu@lists.linux-foundation.org>; Thu, 20 Feb 2020 11:58:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 3147B86DBD
 for <iommu@lists.linux-foundation.org>; Thu, 20 Feb 2020 11:58:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id P3eYir9-D8Ve for <iommu@lists.linux-foundation.org>;
 Thu, 20 Feb 2020 11:58:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 4308386D96
 for <iommu@lists.linux-foundation.org>; Thu, 20 Feb 2020 11:58:25 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 20 Feb 2020 03:58:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,464,1574150400"; d="scan'208";a="349158933"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.210.40])
 ([10.254.210.40])
 by fmsmga001.fm.intel.com with ESMTP; 20 Feb 2020 03:58:22 -0800
Subject: Re: [PATCH v4] iommu/vt-d: consider real PCI device when checking if
 mapping is needed
To: Daniel Drake <drake@endlessm.com>
References: <CAD8Lp47Bhv_58-Z+a+JFS9rTZW58_rWvE8N+XVtX7mmB-Tj55A@mail.gmail.com>
 <20200220100607.9044-1-drake@endlessm.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <f8f494fa-3fc5-637a-ddab-0d25cc56262e@linux.intel.com>
Date: Thu, 20 Feb 2020 19:58:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200220100607.9044-1-drake@endlessm.com>
Content-Language: en-US
Cc: bhelgaas@google.com, linux@endlessm.com, iommu@lists.linux-foundation.org,
 dwmw2@infradead.org, jonathan.derrick@intel.com
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

SGksCgpPbiAyMDIwLzIvMjAgMTg6MDYsIERhbmllbCBEcmFrZSB3cm90ZToKPj4gT24gV2VkLCBG
ZWIgMTksIDIwMjAgYXQgMTE6NDAgQU0gTHUgQmFvbHU8YmFvbHUubHVAbGludXguaW50ZWwuY29t
PiAgd3JvdGU6Cj4+PiBXaXRoIHJlc3BlY3QsIHRoaXMgaXMgcHJvYmxlbWF0aWNhbC4gVGhlIHBh
cmVudCBhbmQgYWxsIHN1YmRldmljZXMgc2hhcmUKPj4+IGEgc2luZ2xlIHRyYW5zbGF0aW9uIGVu
dHJ5LiBUaGUgRE1BIG1hc2sgc2hvdWxkIGJlIGNvbnNpc3RlbnQuCj4+Pgo+Pj4gT3RoZXJ3aXNl
LCBmb3IgZXhhbXBsZSwgc3ViZGV2aWNlIEEgaGFzIDY0LWJpdCBETUEgY2FwYWJpbGl0eSBhbmQg
dXNlcwo+Pj4gYW4gaWRlbnRpdHkgZG9tYWluIGZvciBETUEgdHJhbnNsYXRpb24uIFdoaWxlIHN1
YmRldmljZSBCIGhhcyAzMi1iaXQgRE1BCj4+PiBjYXBhYmlsaXR5IGFuZCBpcyBmb3JjZWQgdG8g
c3dpdGNoIHRvIERNQSBkb21haW4uIFN1YmRldmljZSBBIHdpbGwgYmUKPj4+IGltcGFjdGVkIHdp
dGhvdXQgYW55IG5vdGlmaWNhdGlvbi4KPiBMb29raW5nIGNsb3NlciwgdGhpcyBwcm9ibGVtYXRp
YyBjb2RlcGF0aCBtYXkgYWxyZWFkeSBiZSBoYXBwZW5pbmcgZm9yIFZNRCwKPiB1bmRlciBpbnRl
bF9pb21tdV9hZGRfZGV2aWNlKCkuIENvbnNpZGVyIHRoaXMgZnVuY3Rpb24gcnVubmluZyBmb3Ig
YSBWTUQKPiBzdWJkZXZpY2UsIHdlIGhpdDoKPiAKPiAgwqAgwqAgZG9tYWluID0gaW9tbXVfZ2V0
X2RvbWFpbl9mb3JfZGV2KGRldik7Cj4gCj4gSSBjYW4ndCBxdWl0ZSBncmFzcCB0aGUgY29kZSBm
bG93IGhlcmUsIGJ1dCBkb21haW4tPnR5cGUgbm93IGFsd2F5cyBzZWVtcwo+IHRvIHJldHVybiB0
aGUgZG9tYWluIHR5cGUgb2YgdGhlIHJlYWwgRE1BIGRldmljZSwgd2hpY2ggc2VlbXMgbGlrZSBw
cmV0dHkKPiByZWFzb25hYmxlIGJlaGF2aW91ci4KPiAKPiAgwqAgwqAgaWYgKGRvbWFpbi0+dHlw
ZSA9PSBJT01NVV9ET01BSU5fRE1BKSB7Cj4gCj4gYW5kIGFzIGRldGFpbGVkIGluIHByZXZpb3Vz
IG1haWxzLCB0aGUgcmVhbCBWTUQgZGV2aWNlIHNlZW1zIHRvIGJlIGluIGEgRE1BCj4gZG9tYWlu
IGJ5IGRlZmF1bHQsIHNvIHdlIGNvbnRpbnVlLgo+IAo+ICDCoCDCoCDCoCDCoCBpZiAoZGV2aWNl
X2RlZl9kb21haW5fdHlwZShkZXYpID09IElPTU1VX0RPTUFJTl9JREVOVElUWSkgewo+IAo+IE5v
dyB3ZSBjaGVja2VkIHRoZSBkZWZhdWx0IGRvbWFpbiB0eXBlIG9mIHRoZSBzdWJkZXZpY2UuIFRo
aXMgc2VlbXMgcmF0aGVyCj4gbGlrZWx5IHRvIHJldHVybiBJREVOVElUWSBiZWNhdXNlIHRoYXQn
cyBlZmZlY3RpdmVseSB0aGUgZGVmYXVsdCB0eXBlLi4uCj4gCj4gIMKgIMKgIMKgIMKgIMKgIMKg
IHJldCA9IGlvbW11X3JlcXVlc3RfZG1fZm9yX2RldihkZXYpOwo+ICDCoCDCoCDCoCDCoCDCoCDC
oCBpZiAocmV0KSB7Cj4gIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGRtYXJfcmVtb3ZlX29uZV9k
ZXZfaW5mbyhkZXYpOwo+ICDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBkbWFyX2RvbWFpbi0+Zmxh
Z3MgfD0gRE9NQUlOX0ZMQUdfTE9TRV9DSElMRFJFTjsKPiAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgZG9tYWluX2FkZF9kZXZfaW5mbyhzaV9kb21haW4sIGRldik7Cj4gIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIGRldl9pbmZvKGRldiwKPiAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAiRGV2aWNlIHVzZXMgYSBwcml2YXRlIGlkZW50aXR5IGRvbWFpbi5cbiIpOwo+ICDCoCDCoCDC
oCDCoCDCoCDCoCB9Cj4gIMKgIMKgIMKgIMKgIH0KPiAKPiBhbmQgbm93IHdlJ3JlIGRvaW5nIHRo
ZSBiYWQgc3R1ZmYgdGhhdCBMdSBwb2ludGVkIG91dDogd2Ugb25seSBoYXZlIG9uZQo+IG1hcHBp
bmcgc2hhcmVkIGZvciBhbGwgdGhlIHN1YmRldmljZXMsIHNvIGlmIHdlIGVuZCB1cCBjaGFuZ2lu
ZyBpdCBmb3Igb25lCj4gc3ViZGV2aWNlLCB3ZSdyZSBsaWtlbHkgdG8gYmUgYnJlYWtpbmcgYW5v
dGhlci4KClllcy4gQWdyZWVkLgoKQnkgdGhlIHdheSwgZG8gYWxsIHN1YmRldmljZXMgc3RheSBp
biBhIHNhbWUgaW9tbXUgZ3JvdXA/CgpCZXN0IHJlZ2FyZHMsCmJhb2x1Cl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21t
dUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlv
bi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
