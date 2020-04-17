Return-Path: <SRS0=1rof=6B=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C7D8C2BB1D
	for <iommu@archiver.kernel.org>; Fri, 17 Apr 2020 03:25:26 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 209B222244
	for <iommu@archiver.kernel.org>; Fri, 17 Apr 2020 03:25:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 209B222244
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id D7C2520353;
	Fri, 17 Apr 2020 03:25:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sr9IT6bNVezP; Fri, 17 Apr 2020 03:25:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 432B92014B;
	Fri, 17 Apr 2020 03:25:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2D9CBC1AE8;
	Fri, 17 Apr 2020 03:25:24 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 14328C0172
 for <iommu@lists.linux-foundation.org>; Fri, 17 Apr 2020 03:25:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id F31E184F5A
 for <iommu@lists.linux-foundation.org>; Fri, 17 Apr 2020 03:25:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jBwfYiuucg8z for <iommu@lists.linux-foundation.org>;
 Fri, 17 Apr 2020 03:25:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 38E0584DDC
 for <iommu@lists.linux-foundation.org>; Fri, 17 Apr 2020 03:25:22 +0000 (UTC)
IronPort-SDR: B8cX6L8hVFeBG/Z4lVI3+u4WuXLsaEeg9qmWECr/gtVJD8AxJwbq7PrnUccMh9yg71B6agQh/6
 MIzCLpBG+v9w==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Apr 2020 20:25:21 -0700
IronPort-SDR: Y6NxNoqwaocfo1ldFFdrC25qBWTuSkIdagvjBrnhQfQIWAVfWzvOgqnb12F5Lnv/SZ95ck/O34
 JjcEmikH2k1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,393,1580803200"; d="scan'208";a="428084176"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.212.63])
 ([10.254.212.63])
 by orsmga005.jf.intel.com with ESMTP; 16 Apr 2020 20:25:19 -0700
Subject: Re: [PATCH v2 5/7] iommu/vt-d: Save prq descriptors in an internal
 list
To: "Tian, Kevin" <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>
References: <20200415052542.30421-1-baolu.lu@linux.intel.com>
 <20200415052542.30421-6-baolu.lu@linux.intel.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D8207B2@SHSMSX104.ccr.corp.intel.com>
 <399dd037-b32e-30a7-013c-b68e9a3bbc7a@linux.intel.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <7e95de33-95e9-0647-9611-aa4ec72171c9@linux.intel.com>
Date: Fri, 17 Apr 2020 11:25:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <399dd037-b32e-30a7-013c-b68e9a3bbc7a@linux.intel.com>
Content-Language: en-US
Cc: "Raj, Ashok" <ashok.raj@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
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

SGkgS2V2aW4sCgpPbiAyMDIwLzQvMTYgOTo0NiwgTHUgQmFvbHUgd3JvdGU6Cj4gT24gMjAyMC80
LzE1IDE3OjMwLCBUaWFuLCBLZXZpbiB3cm90ZToKPj4+IEZyb206IEx1IEJhb2x1PGJhb2x1Lmx1
QGxpbnV4LmludGVsLmNvbT4KPj4+IFNlbnQ6IFdlZG5lc2RheSwgQXByaWwgMTUsIDIwMjAgMToy
NiBQTQo+Pj4KPj4+IEN1cnJlbnRseSwgdGhlIHBhZ2UgcmVxdWVzdCBpbnRlcnJ1cHQgdGhyZWFk
IGhhbmRsZXMgdGhlIHBhZ2UKPj4+IHJlcXVlc3RzIGluIHRoZSBxdWV1ZSBpbiB0aGlzIHdheToK
Pj4+Cj4+PiAtIENsZWFyIFBQUiBiaXQgdG8gZW5zdXJlIG5ldyBpbnRlcnJ1cHQgY291bGQgY29t
ZSBpbjsKPj4+IC0gUmVhZCBhbmQgcmVjb3JkIHRoZSBoZWFkIGFuZCB0YWlsIHJlZ2lzdGVyczsK
Pj4+IC0gSGFuZGxlIGFsbCBkZXNjcmlwdG9ycyBiZXR3ZWVuIGhlYWQgYW5kIHRhaWw7Cj4+PiAt
IFdyaXRlIHRhaWwgdG8gaGVhZCByZWdpc3Rlci4KPj4+Cj4+PiBUaGlzIG1pZ2h0IGNhdXNlIHNv
bWUgZGVzY3JpcHRvcnMgdG8gYmUgaGFuZGxlcyBtdWx0aXBsZSB0aW1lcy4KPj4+IEFuIGV4YW1w
bGUgc2VxdWVuY2U6Cj4+Pgo+Pj4gLSBUaHJlYWQgQSBnb3Qgc2NoZWR1bGVkIHdpdGggUFJRXzEg
YW5kIFBSUV8yIGluIHRoZSBxdWV1ZTsKPj4+IC0gVGhyZWFkIEEgY2xlYXIgdGhlIFBQUiBiaXQg
YW5kIHJlY29yZCB0aGUgaGVhZCBhbmQgdGFpbDsKPj4+IC0gQSBuZXcgUFJRXzMgY29tZXMgYW5k
IFRocmVhZCBCIGdldHMgc2NoZWR1bGVkOwo+Pj4gLSBUaHJlYWQgQiByZWNvcmQgdGhlIGhlYWQg
YW5kIHRhaWwgd2hpY2ggaW5jbHVkZXMgUFJRXzEKPj4+IMKgwqAgYW5kIFBSUV8yLgo+PiBJIG1h
eSBvdmVybG9vayBzb21ldGhpbmcgYnV0IGlzbid0IHRoZSBwcnEgaW50ZXJydXB0IHRocmVhZAo+
PiBwZXIgaW9tbXUgdGhlbiB3aHkgd291bGQgdHdvIHBycSB0aHJlYWRzIGNvbnRlbmQgaGVyZT8K
PiAKPiBUaGUgcHJxIGludGVycnVwdCBjb3VsZCBiZSBtYXNrZWQgYnkgdGhlIFBQUiAoUGVuZGlu
ZyBQYWdlIFJlcXVlc3QpIGJpdAo+IGluIFBhZ2UgUmVxdWVzdCBTdGF0dXMgUmVnaXN0ZXIuIElu
IHRoZSBpbnRlcnJ1cHQgaGFuZGxpbmcgdGhyZWFkIG9uY2UKPiB0aGlzIGJpdCBpcyBjbGVhciwg
bmV3IHBycSBpbnRlcnJ1cHRzIGFyZSBhbGxvd2VkIHRvIGJlIGdlbmVyYXRlZC4KPiAKPiBTbywg
aWYgYSBwYWdlIHJlcXVlc3QgaXMgaW4gcHJvY2VzcyBhbmQgdGhlIFBQUiBiaXQgaXMgY2xlYXJl
ZCwgYW5vdGhlcgo+IHBhZ2UgcmVxdWVzdCBmcm9tIGFueSBkZXZpY2VzIHVuZGVyIHRoZSBzYW1l
IGlvbW11IGNvdWxkIHRyaWdnZXIgYW5vdGhlcgo+IGludGVycnVwdCB0aHJlYWQuCgpSZWNoZWNr
ZWQgdGhlIGNvZGUuIFlvdSBhcmUgcmlnaHQuIEFzIGxvbmcgYXMgdGhlIGludGVycnVwdCB0aHJl
YWQgaXMKcGVyIGlvbW11LCB0aGVyZSB3aWxsIG9ubHkgc2luZ2xlIHBycSB0aHJlYWQgc2NoZWR1
bGVkLiBJIHdpbGwgY2hhbmdlCnRoaXMgYWNjb3JkaW5nbHkgaW4gdGhlIG5ldyB2ZXJzaW9uLiBU
aGFuayB5b3UgZm9yIHBvaW50aW5nIHRoaXMgb3V0LgoKQmVzdCByZWdhcmRzLApiYW9sdQpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5n
IGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51
eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
