Return-Path: <SRS0=mVMG=CN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCEBAC433E2
	for <iommu@archiver.kernel.org>; Fri,  4 Sep 2020 19:40:14 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D375208CA
	for <iommu@archiver.kernel.org>; Fri,  4 Sep 2020 19:40:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D375208CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id EFF5E86FD2;
	Fri,  4 Sep 2020 19:40:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ajviwe3cAeDO; Fri,  4 Sep 2020 19:40:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 71DBF86E59;
	Fri,  4 Sep 2020 19:40:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 54EE7C0890;
	Fri,  4 Sep 2020 19:40:12 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 53E4DC0052
 for <iommu@lists.linux-foundation.org>; Fri,  4 Sep 2020 19:40:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 48EE487582
 for <iommu@lists.linux-foundation.org>; Fri,  4 Sep 2020 19:40:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ejDIKPrnu2DO for <iommu@lists.linux-foundation.org>;
 Fri,  4 Sep 2020 19:40:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 3C2748756B
 for <iommu@lists.linux-foundation.org>; Fri,  4 Sep 2020 19:40:10 +0000 (UTC)
IronPort-SDR: Ue208vvPmsXWyTb/tSr5wCmikM/5+NF0hJVlFzVaYFso0PvunkNCpgiLXTTMKmBoCZTJSFcdaT
 e4ZBc0NXclOQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9734"; a="222018786"
X-IronPort-AV: E=Sophos;i="5.76,391,1592895600"; d="scan'208";a="222018786"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Sep 2020 12:40:09 -0700
IronPort-SDR: +IPz8MTucQYSMt2jU5UGHgs5Kxg6R2h96QPn1YIpyFbMLg/UcXy3eaWRhTYH9gBOObDb9TfDfi
 FofMlcYnrL4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,391,1592895600"; d="scan'208";a="339856769"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
 by FMSMGA003.fm.intel.com with ESMTP; 04 Sep 2020 12:40:08 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 4 Sep 2020 12:40:08 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 4 Sep 2020 12:11:07 -0700
Received: from fmsmsx610.amr.corp.intel.com ([10.18.126.90]) by
 fmsmsx610.amr.corp.intel.com ([10.18.126.90]) with mapi id 15.01.1713.004;
 Fri, 4 Sep 2020 12:11:07 -0700
From: "Prakhya, Sai Praneeth" <sai.praneeth.prakhya@intel.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: RE: [PATCH V6 1/3] iommu: Add support to change default domain of an
 iommu group
Thread-Topic: [PATCH V6 1/3] iommu: Add support to change default domain of an
 iommu group
Thread-Index: AQHWgpeI539owO3I/k+wFmjHF9kByKlY18mA
Date: Fri, 4 Sep 2020 19:11:07 +0000
Message-ID: <d92598a2e54b48eba0c8e30a2c40b937@intel.com>
References: <cover.1595619936.git.sai.praneeth.prakhya@intel.com>
 <458786ba5883eaab3aea51ae2fdc7f5dbe71284a.1595619936.git.sai.praneeth.prakhya@intel.com>
 <20200904083036.GB28508@8bytes.org>
In-Reply-To: <20200904083036.GB28508@8bytes.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
x-originating-ip: [10.1.200.100]
MIME-Version: 1.0
Cc: "Raj, Ashok" <ashok.raj@intel.com>, Will Deacon <will.deacon@arm.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>
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

SGkgSm9lcmcsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSm9lcmcg
Um9lZGVsIDxqb3JvQDhieXRlcy5vcmc+DQo+IFNlbnQ6IEZyaWRheSwgU2VwdGVtYmVyIDQsIDIw
MjAgMTozMSBBTQ0KPiBUbzogUHJha2h5YSwgU2FpIFByYW5lZXRoIDxzYWkucHJhbmVldGgucHJh
a2h5YUBpbnRlbC5jb20+DQo+IENjOiBpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZzsg
Q2hyaXN0b3BoIEhlbGx3aWcgPGhjaEBsc3QuZGU+OyBSYWosDQo+IEFzaG9rIDxhc2hvay5yYWpA
aW50ZWwuY29tPjsgV2lsbCBEZWFjb24gPHdpbGwuZGVhY29uQGFybS5jb20+OyBMdSBCYW9sdQ0K
PiA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPjsgTWVodGEsIFNvaGlsIDxzb2hpbC5tZWh0YUBp
bnRlbC5jb20+OyBSb2Jpbg0KPiBNdXJwaHkgPHJvYmluLm11cnBoeUBhcm0uY29tPjsgSmFjb2Ig
UGFuIDxqYWNvYi5qdW4ucGFuQGxpbnV4LmludGVsLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRD
SCBWNiAxLzNdIGlvbW11OiBBZGQgc3VwcG9ydCB0byBjaGFuZ2UgZGVmYXVsdCBkb21haW4gb2YN
Cj4gYW4gaW9tbXUgZ3JvdXANCj4gDQo+IEhpIFNhaSwNCj4gDQo+IE9uIFN1biwgQXVnIDIzLCAy
MDIwIGF0IDEwOjE3OjI2UE0gLTA3MDAsIFNhaSBQcmFuZWV0aCBQcmFraHlhIHdyb3RlOg0KPiA+
ICBkcml2ZXJzL2lvbW11L2lvbW11LmMgfCAyMjUNCj4gPiArKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKy0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDIyNCBpbnNlcnRpb25z
KCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBDYW4geW91IHBsZWFzZSBwb3N0IHRoaXMgYXMgYSBu
ZXcgYW5kIHNlcGFyYXRlIHRocmVhZCBzbyBJIGNhbiBncmFiIGl0IHdvdGggYjQ/DQoNClN1cmUh
IEkgd2lsbCBwb3N0IGEgbmV3IHZlcnNpb24uDQoNCkJ1dCBjb3VwbGUgb2YgcXVlc3Rpb25zLi4N
CjEuIERvIHlvdSB3YW50IG1lIHRvIHBvc3QgdGhlIGVudGlyZSBwYXRjaCBzZXJpZXM/IChpLmUu
IDMgcGF0Y2hlcykgb3IgZG8geW91IHdhbnQgbWUgdG8gcG9zdCBqdXN0IHRoaXMgcGF0Y2ggaS5l
LiAxc3QgcGF0Y2ggb25seQ0KMi4gRG8geW91IHdhbnQgbWUgdG8gYnVtcCB0aGUgdmVyc2lvbiBu
dW1iZXI/IGkuZS4gcG9zdCBpdCBhcyBWNyA/DQozLiBEaWRuJ3QgZ2V0IHdoYXQgeW91IG1lYW50
IGhlcmUuLiAid290aCBiNCIg4pi5DQoNClJlZ2FyZHMsDQpTYWkNCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBs
aXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5v
cmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
