Return-Path: <SRS0=R2i3=CO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71DE7C43461
	for <iommu@archiver.kernel.org>; Sat,  5 Sep 2020 06:17:10 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0085D2137B
	for <iommu@archiver.kernel.org>; Sat,  5 Sep 2020 06:17:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0085D2137B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id AEEF787546;
	Sat,  5 Sep 2020 06:17:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OA9A2voO-VmI; Sat,  5 Sep 2020 06:17:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id EC63687542;
	Sat,  5 Sep 2020 06:17:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CF51FC07FF;
	Sat,  5 Sep 2020 06:17:08 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C306AC0051
 for <iommu@lists.linux-foundation.org>; Sat,  5 Sep 2020 06:17:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id B8DF686AC6
 for <iommu@lists.linux-foundation.org>; Sat,  5 Sep 2020 06:17:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dLStcA85hA3z for <iommu@lists.linux-foundation.org>;
 Sat,  5 Sep 2020 06:17:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id EF23186AB6
 for <iommu@lists.linux-foundation.org>; Sat,  5 Sep 2020 06:17:06 +0000 (UTC)
IronPort-SDR: qv6o4Ik12PjMvod9pWJ/I1J9ol5ZC6UuhTtYVbG/2vak1mIaam0izp7acyKHk2M675CucQRGBH
 8AvH87IH3e7g==
X-IronPort-AV: E=McAfee;i="6000,8403,9734"; a="155347538"
X-IronPort-AV: E=Sophos;i="5.76,392,1592895600"; d="scan'208";a="155347538"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Sep 2020 23:17:06 -0700
IronPort-SDR: C+30L34LDE/tpdUeNME+sKs0Rt2vgE8LTTa1nwisSIxVvLcdCsRL53Fg0M4O9ja6CFRWcESKpB
 pr3RJ5mcf1Bw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,392,1592895600"; d="scan'208";a="342457490"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
 by orsmga007.jf.intel.com with ESMTP; 04 Sep 2020 23:17:06 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 4 Sep 2020 23:17:05 -0700
Received: from ORSMSX611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with ShadowRedundancy id
 15.1.1713.5; Sat, 5 Sep 2020 06:17:04 +0000
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 4 Sep 2020 15:25:41 -0700
Received: from fmsmsx610.amr.corp.intel.com ([10.18.126.90]) by
 fmsmsx610.amr.corp.intel.com ([10.18.126.90]) with mapi id 15.01.1713.004;
 Fri, 4 Sep 2020 15:25:41 -0700
From: "Prakhya, Sai Praneeth" <sai.praneeth.prakhya@intel.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: RE: [PATCH V6 1/3] iommu: Add support to change default domain of an
 iommu group
Thread-Topic: [PATCH V6 1/3] iommu: Add support to change default domain of an
 iommu group
Thread-Index: AQHWgpeI539owO3I/k+wFmjHF9kByKlY18mAgACg6oD//5Z/cA==
Date: Fri, 4 Sep 2020 22:25:40 +0000
Message-ID: <b2f4b32e281f44b997b7a26a6b9942b9@intel.com>
References: <cover.1595619936.git.sai.praneeth.prakhya@intel.com>
 <458786ba5883eaab3aea51ae2fdc7f5dbe71284a.1595619936.git.sai.praneeth.prakhya@intel.com>
 <20200904083036.GB28508@8bytes.org>
 <d92598a2e54b48eba0c8e30a2c40b937@intel.com>
 <20200904214221.GG16609@8bytes.org>
In-Reply-To: <20200904214221.GG16609@8bytes.org>
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
MjAgMjo0MiBQTQ0KPiBUbzogUHJha2h5YSwgU2FpIFByYW5lZXRoIDxzYWkucHJhbmVldGgucHJh
a2h5YUBpbnRlbC5jb20+DQo+IENjOiBpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZzsg
Q2hyaXN0b3BoIEhlbGx3aWcgPGhjaEBsc3QuZGU+OyBSYWosDQo+IEFzaG9rIDxhc2hvay5yYWpA
aW50ZWwuY29tPjsgV2lsbCBEZWFjb24gPHdpbGwuZGVhY29uQGFybS5jb20+OyBMdSBCYW9sdQ0K
PiA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPjsgTWVodGEsIFNvaGlsIDxzb2hpbC5tZWh0YUBp
bnRlbC5jb20+OyBSb2Jpbg0KPiBNdXJwaHkgPHJvYmluLm11cnBoeUBhcm0uY29tPjsgSmFjb2Ig
UGFuIDxqYWNvYi5qdW4ucGFuQGxpbnV4LmludGVsLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRD
SCBWNiAxLzNdIGlvbW11OiBBZGQgc3VwcG9ydCB0byBjaGFuZ2UgZGVmYXVsdCBkb21haW4gb2YN
Cj4gYW4gaW9tbXUgZ3JvdXANCj4gDQo+IE9uIEZyaSwgU2VwIDA0LCAyMDIwIGF0IDA3OjExOjA3
UE0gKzAwMDAsIFByYWtoeWEsIFNhaSBQcmFuZWV0aCB3cm90ZToNCj4gPiBCdXQgY291cGxlIG9m
IHF1ZXN0aW9ucy4uDQo+ID4gMS4gRG8geW91IHdhbnQgbWUgdG8gcG9zdCB0aGUgZW50aXJlIHBh
dGNoIHNlcmllcz8gKGkuZS4gMyBwYXRjaGVzKSBvcg0KPiA+IGRvIHlvdSB3YW50IG1lIHRvIHBv
c3QganVzdCB0aGlzIHBhdGNoIGkuZS4gMXN0IHBhdGNoIG9ubHkgMi4gRG8geW91IHdhbnQgbWUg
dG8NCj4gYnVtcCB0aGUgdmVyc2lvbiBudW1iZXI/IGkuZS4gcG9zdCBpdCBhcyBWNyA/DQo+ID4g
My4gRGlkbid0IGdldCB3aGF0IHlvdSBtZWFudCBoZXJlLi4gIndvdGggYjQiIOKYuQ0KPiANCj4g
UGxlYXNlIHJlc2VuZCBhbGwgMyBwYXRjaGVzIGEgdjcsIGI0IGlzIGp1c3QgYSB0b29sIEkgYW0g
dXNpbmcgdG8gZG93bmxvYWQgdGhlDQo+IHBhdGNoZXMgZnJvbSB0aGUgbWFpbGluZyBsaXN0IGFu
ZCBhZGQgYWxsIHRhZ3NbMV0uDQoNClRoYW5rcyBmb3IgYW5zd2VyaW5nIHRoZSBxdWVzdGlvbnMu
IEl0J3MgY2xlYXIgdG8gbWUgbm93Li4gSSB3aWxsIHBvc3QgYSBWNyDwn5iKDQoNClJlZ2FyZHMs
DQpTYWkNCg0KPiBSZWdhcmRzLA0KPiANCj4gCUpvZXJnDQo+IA0KPiBbMV0gaHR0cHM6Ly9wZW9w
bGUua2VybmVsLm9yZy9tb25zaWV1cmljb24vaW50cm9kdWNpbmctYjQtYW5kLXBhdGNoLQ0KPiBh
dHRlc3RhdGlvbg0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0
dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
