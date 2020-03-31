Return-Path: <SRS0=6vqp=5Q=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF245C2D0E8
	for <iommu@archiver.kernel.org>; Tue, 31 Mar 2020 06:42:27 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E57B2072A
	for <iommu@archiver.kernel.org>; Tue, 31 Mar 2020 06:42:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E57B2072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 755BC86FF9;
	Tue, 31 Mar 2020 06:42:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id J3NCi9AwlDhO; Tue, 31 Mar 2020 06:42:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id D0E5B86B58;
	Tue, 31 Mar 2020 06:42:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BFAE2C1AE2;
	Tue, 31 Mar 2020 06:42:26 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 836DBC07FF
 for <iommu@lists.linux-foundation.org>; Tue, 31 Mar 2020 06:42:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 7EDCB20502
 for <iommu@lists.linux-foundation.org>; Tue, 31 Mar 2020 06:42:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cQx9rCg1-MXe for <iommu@lists.linux-foundation.org>;
 Tue, 31 Mar 2020 06:42:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by silver.osuosl.org (Postfix) with ESMTPS id 946CB2012F
 for <iommu@lists.linux-foundation.org>; Tue, 31 Mar 2020 06:42:24 +0000 (UTC)
IronPort-SDR: eUtLjV9aSTmRk8MTBKoDh8zRT8ePKHEbHw07rxOXS9ZL1mJ/mjnJRPNoRSBEFC8xn+OdY3D8ve
 cgLb91Am9gtw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Mar 2020 23:42:23 -0700
IronPort-SDR: xoUG/BhU2jnZANEA8VZ2vxIgwIIacw3H+Zl+q0axYIZTylRMpn12afeVr1+JanZKvVh2UMDPKG
 3Xheiq5zLXSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,327,1580803200"; d="scan'208";a="359407571"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
 by fmsmga001.fm.intel.com with ESMTP; 30 Mar 2020 23:42:23 -0700
Received: from fmsmsx113.amr.corp.intel.com (10.18.116.7) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 30 Mar 2020 23:42:23 -0700
Received: from shsmsx107.ccr.corp.intel.com (10.239.4.96) by
 FMSMSX113.amr.corp.intel.com (10.18.116.7) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 30 Mar 2020 23:42:23 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.225]) by
 SHSMSX107.ccr.corp.intel.com ([169.254.9.191]) with mapi id 14.03.0439.000;
 Tue, 31 Mar 2020 14:42:19 +0800
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: "Tian, Kevin" <kevin.tian@intel.com>, "alex.williamson@redhat.com"
 <alex.williamson@redhat.com>, "eric.auger@redhat.com" <eric.auger@redhat.com>
Subject: RE: [PATCH v1 1/2] vfio/pci: Expose PCIe PASID capability to guest
Thread-Topic: [PATCH v1 1/2] vfio/pci: Expose PCIe PASID capability to guest
Thread-Index: AQHWAEVGhyrNdpmwzkqkYesGE5wb06hhx4yAgACGaqA=
Date: Tue, 31 Mar 2020 06:42:18 +0000
Message-ID: <A2975661238FB949B60364EF0F2C25743A21A6F8@SHSMSX104.ccr.corp.intel.com>
References: <1584880394-11184-1-git-send-email-yi.l.liu@intel.com>
 <1584880394-11184-2-git-send-email-yi.l.liu@intel.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D801277@SHSMSX104.ccr.corp.intel.com>
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D19D801277@SHSMSX104.ccr.corp.intel.com>
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

PiBGcm9tOiBUaWFuLCBLZXZpbiA8a2V2aW4udGlhbkBpbnRlbC5jb20+DQo+IFNlbnQ6IFR1ZXNk
YXksIE1hcmNoIDMxLCAyMDIwIDI6MzkgUE0NCj4gVG86IExpdSwgWWkgTCA8eWkubC5saXVAaW50
ZWwuY29tPjsgYWxleC53aWxsaWFtc29uQHJlZGhhdC5jb207DQo+IFN1YmplY3Q6IFJFOiBbUEFU
Q0ggdjEgMS8yXSB2ZmlvL3BjaTogRXhwb3NlIFBDSWUgUEFTSUQgY2FwYWJpbGl0eSB0byBndWVz
dA0KPiANCj4gPiBGcm9tOiBMaXUsIFlpIEwgPHlpLmwubGl1QGludGVsLmNvbT4NCj4gPiBTZW50
OiBTdW5kYXksIE1hcmNoIDIyLCAyMDIwIDg6MzMgUE0NCj4gPg0KPiA+IEZyb206IExpdSBZaSBM
IDx5aS5sLmxpdUBpbnRlbC5jb20+DQo+ID4NCj4gPiBUaGlzIHBhdGNoIGV4cG9zZXMgUENJZSBQ
QVNJRCBjYXBhYmlsaXR5IHRvIGd1ZXN0LiBFeGlzdGluZyB2ZmlvX3BjaQ0KPiA+IGRyaXZlciBo
aWRlcyBpdCBmcm9tIGd1ZXN0IGJ5IHNldHRpbmcgdGhlIGNhcGFiaWxpdHkgbGVuZ3RoIGFzIDAg
aW4NCj4gPiBwY2lfZXh0X2NhcF9sZW5ndGhbXS4NCj4gPg0KPiA+IFRoaXMgY2FwYWJpbGl0eSBp
cyByZXF1aXJlZCBmb3IgdlNWQSBlbmFibGluZyBvbiBwYXNzLXRocm91Z2ggUENJZQ0KPiA+IGRl
dmljZXMuDQo+IA0KPiBzaG91bGQgdGhpcyBiZSBbUEFUQ0ggMi8yXSwgYWZ0ZXIgeW91IGhhdmUg
dGhlIGVtdWxhdGlvbiBpbiBwbGFjZT8NCg0Kb2gsIHllcywgSSBjYW4gcmUtc2VxdWVuY2UgaXQu
DQoNCj4gYW5kIGl0IG1pZ2h0IGJlIHdvcnRoeSBvZiBub3RpbmcgdGhhdCBQUkkgaXMgYWxyZWFk
eSBleHBvc2VkLCB0bw0KPiBhdm9pZCBjb25mdXNpb24gZnJvbSBvbmUgbGlrZSBtZSB0aGF0IHdo
eSB0d28gY2FwYWJpbGl0aWVzIGFyZQ0KPiBlbXVsYXRlZCBpbiB0aGlzIHNlcmllcyB3aGlsZSBv
bmx5IG9uZSBpcyBiZWluZyBleHBvc2VkLiDwn5iKDQoNCmdvdCBpdC4gaXQgd291bGQgYmUgaGVs
cGZ1bC4gdGhhbmtzLg0KDQpSZWdhcmRzLA0KWWkgTGl1DQpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMu
bGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21h
aWxtYW4vbGlzdGluZm8vaW9tbXU=
