Return-Path: <SRS0=6vqp=5Q=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74C60C43331
	for <iommu@archiver.kernel.org>; Tue, 31 Mar 2020 06:39:27 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AECF2072A
	for <iommu@archiver.kernel.org>; Tue, 31 Mar 2020 06:39:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AECF2072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 20C84883F1;
	Tue, 31 Mar 2020 06:39:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7N9hqq1sCDnU; Tue, 31 Mar 2020 06:39:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 7E60088400;
	Tue, 31 Mar 2020 06:39:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 61E40C1AE2;
	Tue, 31 Mar 2020 06:39:25 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C4481C07FF
 for <iommu@lists.linux-foundation.org>; Tue, 31 Mar 2020 06:39:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id B3B3C871C0
 for <iommu@lists.linux-foundation.org>; Tue, 31 Mar 2020 06:39:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PKdIZymmSi55 for <iommu@lists.linux-foundation.org>;
 Tue, 31 Mar 2020 06:39:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 18BCD86224
 for <iommu@lists.linux-foundation.org>; Tue, 31 Mar 2020 06:39:23 +0000 (UTC)
IronPort-SDR: LtR9Y4eFPQDxJjetFVf2FqyVdA+zAGAdhKKmsHb8DBqAU+Xb074AcMftdjpklmlBHJWYg4/bER
 DxGTpMS8lIAQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Mar 2020 23:39:22 -0700
IronPort-SDR: VDQZGdHuZ+1PFwSUA+ILgQLpAd7KdC3fkCIpiH96TcGXcuw5XKWseA8BOj3zLUNfeHiIgHSdZq
 tej94aLxQAUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,327,1580803200"; d="scan'208";a="448556829"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
 by fmsmga005.fm.intel.com with ESMTP; 30 Mar 2020 23:39:22 -0700
Received: from fmsmsx111.amr.corp.intel.com (10.18.116.5) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 30 Mar 2020 23:39:22 -0700
Received: from shsmsx102.ccr.corp.intel.com (10.239.4.154) by
 fmsmsx111.amr.corp.intel.com (10.18.116.5) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 30 Mar 2020 23:39:22 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.225]) by
 shsmsx102.ccr.corp.intel.com ([169.254.2.138]) with mapi id 14.03.0439.000;
 Tue, 31 Mar 2020 14:39:18 +0800
From: "Tian, Kevin" <kevin.tian@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>, "alex.williamson@redhat.com"
 <alex.williamson@redhat.com>, "eric.auger@redhat.com" <eric.auger@redhat.com>
Subject: RE: [PATCH v1 1/2] vfio/pci: Expose PCIe PASID capability to guest
Thread-Topic: [PATCH v1 1/2] vfio/pci: Expose PCIe PASID capability to guest
Thread-Index: AQHWAEVGBRqYALAjtUSFrIBsXSoVTKhiTLlg
Date: Tue, 31 Mar 2020 06:39:17 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D19D801277@SHSMSX104.ccr.corp.intel.com>
References: <1584880394-11184-1-git-send-email-yi.l.liu@intel.com>
 <1584880394-11184-2-git-send-email-yi.l.liu@intel.com>
In-Reply-To: <1584880394-11184-2-git-send-email-yi.l.liu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
MIME-Version: 1.0
Cc: "jean-philippe@linaro.org" <jean-philippe@linaro.org>, "Raj,
 Ashok" <ashok.raj@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "Tian, Jun J" <jun.j.tian@intel.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Sun,
 Yi Y" <yi.y.sun@intel.com>, "Wu, Hao" <hao.wu@intel.com>
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

PiBGcm9tOiBMaXUsIFlpIEwgPHlpLmwubGl1QGludGVsLmNvbT4NCj4gU2VudDogU3VuZGF5LCBN
YXJjaCAyMiwgMjAyMCA4OjMzIFBNDQo+IA0KPiBGcm9tOiBMaXUgWWkgTCA8eWkubC5saXVAaW50
ZWwuY29tPg0KPiANCj4gVGhpcyBwYXRjaCBleHBvc2VzIFBDSWUgUEFTSUQgY2FwYWJpbGl0eSB0
byBndWVzdC4gRXhpc3RpbmcgdmZpb19wY2kNCj4gZHJpdmVyIGhpZGVzIGl0IGZyb20gZ3Vlc3Qg
Ynkgc2V0dGluZyB0aGUgY2FwYWJpbGl0eSBsZW5ndGggYXMgMCBpbg0KPiBwY2lfZXh0X2NhcF9s
ZW5ndGhbXS4NCj4gDQo+IFRoaXMgY2FwYWJpbGl0eSBpcyByZXF1aXJlZCBmb3IgdlNWQSBlbmFi
bGluZyBvbiBwYXNzLXRocm91Z2ggUENJZQ0KPiBkZXZpY2VzLg0KDQpzaG91bGQgdGhpcyBiZSBb
UEFUQ0ggMi8yXSwgYWZ0ZXIgeW91IGhhdmUgdGhlIGVtdWxhdGlvbiBpbiBwbGFjZT8NCg0KYW5k
IGl0IG1pZ2h0IGJlIHdvcnRoeSBvZiBub3RpbmcgdGhhdCBQUkkgaXMgYWxyZWFkeSBleHBvc2Vk
LCB0bw0KYXZvaWQgY29uZnVzaW9uIGZyb20gb25lIGxpa2UgbWUgdGhhdCB3aHkgdHdvIGNhcGFi
aWxpdGllcyBhcmUNCmVtdWxhdGVkIGluIHRoaXMgc2VyaWVzIHdoaWxlIG9ubHkgb25lIGlzIGJl
aW5nIGV4cG9zZWQuIPCfmIoNCg0KPiANCj4gQ2M6IEtldmluIFRpYW4gPGtldmluLnRpYW5AaW50
ZWwuY29tPg0KPiBDQzogSmFjb2IgUGFuIDxqYWNvYi5qdW4ucGFuQGxpbnV4LmludGVsLmNvbT4N
Cj4gQ2M6IEFsZXggV2lsbGlhbXNvbiA8YWxleC53aWxsaWFtc29uQHJlZGhhdC5jb20+DQo+IENj
OiBFcmljIEF1Z2VyIDxlcmljLmF1Z2VyQHJlZGhhdC5jb20+DQo+IENjOiBKZWFuLVBoaWxpcHBl
IEJydWNrZXIgPGplYW4tcGhpbGlwcGVAbGluYXJvLm9yZz4NCj4gU2lnbmVkLW9mZi1ieTogTGl1
IFlpIEwgPHlpLmwubGl1QGludGVsLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL3ZmaW8vcGNpL3Zm
aW9fcGNpX2NvbmZpZy5jIHwgMiArLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCsp
LCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92ZmlvL3BjaS92Zmlv
X3BjaV9jb25maWcuYw0KPiBiL2RyaXZlcnMvdmZpby9wY2kvdmZpb19wY2lfY29uZmlnLmMNCj4g
aW5kZXggOTBjMGI4MC4uNGI5YWY5OSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy92ZmlvL3BjaS92
ZmlvX3BjaV9jb25maWcuYw0KPiArKysgYi9kcml2ZXJzL3ZmaW8vcGNpL3ZmaW9fcGNpX2NvbmZp
Zy5jDQo+IEBAIC05NSw3ICs5NSw3IEBAIHN0YXRpYyBjb25zdCB1MTYNCj4gcGNpX2V4dF9jYXBf
bGVuZ3RoW1BDSV9FWFRfQ0FQX0lEX01BWCArIDFdID0gew0KPiAgCVtQQ0lfRVhUX0NBUF9JRF9M
VFJdCT0JUENJX0VYVF9DQVBfTFRSX1NJWkVPRiwNCj4gIAlbUENJX0VYVF9DQVBfSURfU0VDUENJ
XQk9CTAsCS8qIG5vdCB5ZXQgKi8NCj4gIAlbUENJX0VYVF9DQVBfSURfUE1VWF0JPQkwLAkvKiBu
b3QgeWV0ICovDQo+IC0JW1BDSV9FWFRfQ0FQX0lEX1BBU0lEXQk9CTAsCS8qIG5vdCB5ZXQgKi8N
Cj4gKwlbUENJX0VYVF9DQVBfSURfUEFTSURdCT0JUENJX0VYVF9DQVBfUEFTSURfU0laRU9GLA0K
PiAgfTsNCj4gDQo+ICAvKg0KPiAtLQ0KPiAyLjcuNA0KDQpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMu
bGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21h
aWxtYW4vbGlzdGluZm8vaW9tbXU=
