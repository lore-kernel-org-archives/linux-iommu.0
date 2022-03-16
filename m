Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A85D7C433F5
	for <iommu@archiver.kernel.org>; Wed, 16 Mar 2022 20:58:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6355960AD0;
	Wed, 16 Mar 2022 20:58:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id USq5kHzMcMOD; Wed, 16 Mar 2022 20:58:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 418A660670;
	Wed, 16 Mar 2022 20:58:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0611BC001A;
	Wed, 16 Mar 2022 20:58:28 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 12872C000B
 for <iommu@lists.linux-foundation.org>; Wed, 16 Mar 2022 20:58:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 02611417EF
 for <iommu@lists.linux-foundation.org>; Wed, 16 Mar 2022 20:58:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PdewrA-b1SqN for <iommu@lists.linux-foundation.org>;
 Wed, 16 Mar 2022 20:58:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5ABF240325
 for <iommu@lists.linux-foundation.org>; Wed, 16 Mar 2022 20:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1647464306; x=1679000306;
 h=date:from:to:cc:subject:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=KYoTv7ruHgzjw0zYcgRtx7NngXpRKYqbmIlSecMOMPg=;
 b=grlZZiKAyZ5XaiK6KT2nmNWlvvLJlK9XXsa3gMkQI4D0H0e8Sm8sVWhv
 WgCRPzateeTRn4sJ35+vEeLldCkd4m5ISdHCWMPRSRTonAY8Jhgp4NJsc
 v+gWBryYvmMhwC5vR4LxrKUH/5FbbvqiiG/vqzIBE2Uc1evCSxqU0Tkg8
 CmPqrVW3YNNloDVhwg1kqK5upBdU3edfJPGCKWeghSZiL9Unqsa8VTTLA
 lR51v61wH2iLR5XNoj+/c50S2BNSph/VrxX/9vnR/VTR3IZwtWBHgmX4f
 ncQkekocKVgEu+nAhGFC7+Kz1EfHeLDAty2oy7RZ2I3309nMuk1h1xp/u A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10288"; a="237317369"
X-IronPort-AV: E=Sophos;i="5.90,187,1643702400"; d="scan'208";a="237317369"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Mar 2022 13:58:25 -0700
X-IronPort-AV: E=Sophos;i="5.90,187,1643702400"; d="scan'208";a="690722576"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.198.157])
 by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Mar 2022 13:58:24 -0700
Date: Wed, 16 Mar 2022 14:01:40 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Subject: Re: [PATCH v2 3/8] iommu/vt-d: Implement device_pasid domain attach
 ops
Message-ID: <20220316140140.76bb24c6@jacob-builder>
In-Reply-To: <BN9PR11MB5276E98AE37EA912B01EB0B68C119@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220315050713.2000518-1-jacob.jun.pan@linux.intel.com>
 <20220315050713.2000518-4-jacob.jun.pan@linux.intel.com>
 <20220315143322.GW11336@nvidia.com>
 <BN9PR11MB5276E98AE37EA912B01EB0B68C119@BN9PR11MB5276.namprd11.prod.outlook.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: "Luck,
 Tony" <tony.luck@intel.com>, "Jiang, Dave" <dave.jiang@intel.com>, "Raj,
 Ashok" <ashok.raj@intel.com>, "Zanussi, Tom" <tom.zanussi@intel.com>, "Kumar,
 Sanjay K" <sanjay.k.kumar@intel.com>, LKML <linux-kernel@vger.kernel.org>,
 Christoph Hellwig <hch@infradead.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Pan,
 Jacob jun" <jacob.jun.pan@intel.com>, Jason Gunthorpe <jgg@nvidia.com>,
 "Williams, Dan J" <dan.j.williams@intel.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>
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

SGkgS2V2aW4sCgpPbiBXZWQsIDE2IE1hciAyMDIyIDA3OjQxOjM0ICswMDAwLCAiVGlhbiwgS2V2
aW4iIDxrZXZpbi50aWFuQGludGVsLmNvbT4Kd3JvdGU6Cgo+ID4gRnJvbTogSmFzb24gR3VudGhv
cnBlIDxqZ2dAbnZpZGlhLmNvbT4KPiA+IFNlbnQ6IFR1ZXNkYXksIE1hcmNoIDE1LCAyMDIyIDEw
OjMzIFBNCj4gPiAKPiA+IE9uIE1vbiwgTWFyIDE0LCAyMDIyIGF0IDEwOjA3OjA3UE0gLTA3MDAs
IEphY29iIFBhbiB3cm90ZTogIAo+ID4gPiArCS8qCj4gPiA+ICsJICogRWFjaCBkb21haW4gY291
bGQgaGF2ZSBtdWx0aXBsZSBkZXZpY2VzIGF0dGFjaGVkIHdpdGgKPiA+ID4gc2hhcmVkIG9yICAK
PiA+IHBlciAgCj4gPiA+ICsJICogZGV2aWNlIFBBU0lEcy4gQXQgdGhlIGRvbWFpbiBsZXZlbCwg
d2Uga2VlcCB0cmFjayBvZgo+ID4gPiB1bmlxdWUgUEFTSURzICAKPiA+IGFuZCAgCj4gPiA+ICsJ
ICogZGV2aWNlIHVzZXIgY291bnQuCj4gPiA+ICsJICogRS5nLiBJZiBhIGRvbWFpbiBoYXMgdHdv
IGRldmljZXMgYXR0YWNoZWQsIGRldmljZSBBIGhhcwo+ID4gPiBQQVNJRCAwLCAxOwo+ID4gPiAr
CSAqIGRldmljZSBCIGhhcyBQQVNJRCAwLCAyLiBUaGVuIHRoZSBkb21haW4gd291bGQgaGF2ZSBQ
QVNJRAo+ID4gPiAwLCAxLCAyLgo+ID4gPiArCSAqLyAgCj4gPiAKPiA+IEEgMmQgYXJyYXkgb2Yg
eGFycmF5J3Mgc2VlbXMgbGlrZSBhIHBvb3IgZGF0YSBzdHJ1Y3R1cmUgZm9yIHRoaXMgdGFzay4g
IAo+IApQZXJoYXBzIGkgbWlzLXByZXNlbnRlZCBoZXJlLCBJIGFtIG5vdCB1c2luZyAyRCBhcnJh
eS4gSXQgaXMgYW4gMUQgeGFycmF5CmZvciBkb21haW4gUEFTSURzIG9ubHkuIFRoZW4gSSB1c2Ug
dGhlIGV4aXN0aW5nIGRldmljZSBsaXN0IGluIGVhY2ggZG9tYWluLAphZGRpbmcgYW5vdGhlciB4
YSB0byB0cmFjayBwZXItZGV2aWNlLWRvbWFpbiBQQVNJRHMuCj4gYmVzaWRlcyB0aGF0IGl0IGFs
c28gZG9lc24ndCB3b3JrIHdoZW4gd2Ugc3VwcG9ydCBwZXItZGV2aWNlIFBBU0lECj4gYWxsb2Nh
dGlvbiBpbiB0aGUgZnV0dXJlLiBJbiB0aGF0IGNhc2UgbWVyZ2luZyBkZXZpY2UgUEFTSURzIHRv
Z2V0aGVyIGlzCj4gY29uY2VwdHVhbGx5IHdyb25nLgo+IApTb3JyeSwgY291bGQgeW91IGVsYWJv
cmF0ZT8gSWYgd2UgZG8gcGVyLWRldiBQQVNJRCBhbGxvY2F0aW9uLCB3ZSBjb3VsZCB1c2UKdGhl
IGlvYXNpZF9zZXQgZm9yIGVhY2ggcGRldiwgcmlnaHQ/Cgo+ID4gCj4gPiBBRkFDSVQgdGhpcyB3
YW50cyB0byBzdG9yZSBhIGxpc3Qgb2YgKGRldmljZSwgcGFzaWQpIHR1cGxlcywgc28gYQo+ID4g
c2ltcGxlIGxpbmtlZCBsaXN0LCAxZCB4YXJyYXkgdmVjdG9yIG9yIGEgcmVkIGJsYWNrIHRyZWUg
c2VlbXMgbW9yZQo+ID4gYXBwcm9wcmlhdGUuLgo+ID4gICAKPiAKPiB0aGlzIHR1cGxlIGNhbiB3
ZWxsIHNlcnZlIHBlci1kZXZpY2UgUEFTSUQuIPCfmIoKPiAKSSBjb21tZW50ZWQgb24gdGhlIG90
aGVyIGVtYWlsLCBidXQgYSBzaW1wbGUgbGlzdCBvZiB0dXBsZXMgY291bGQgaGF2ZQpkdXBsaWNh
dGVkIGRldmljZXMgc2luY2UgZWFjaCBkZXYgY291bGQgYXR0YWNoIG11bHRpcGxlIFBBU0lEcywg
cmlnaHQ/ClNob3VsZCB3ZSBzdGlsbCBkbyB0d28gbGV2ZWwgdGhlbj8KCj4gVGhhbmtzCj4gS2V2
aW4KCgpUaGFua3MsCgpKYWNvYgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlv
bi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8v
aW9tbXU=
