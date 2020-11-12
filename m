Return-Path: <SRS0=2i4G=ES=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E41DC388F9
	for <iommu@archiver.kernel.org>; Thu, 12 Nov 2020 02:39:09 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FD07207BB
	for <iommu@archiver.kernel.org>; Thu, 12 Nov 2020 02:39:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FD07207BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 17EA783970;
	Thu, 12 Nov 2020 02:39:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wy8gi+X-1vXe; Thu, 12 Nov 2020 02:39:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 5C30D8303A;
	Thu, 12 Nov 2020 02:39:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 51406C0889;
	Thu, 12 Nov 2020 02:39:07 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D2A31C016F
 for <iommu@lists.linux-foundation.org>; Thu, 12 Nov 2020 02:39:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id C112786CBF
 for <iommu@lists.linux-foundation.org>; Thu, 12 Nov 2020 02:39:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id R1w0iI_Mf818 for <iommu@lists.linux-foundation.org>;
 Thu, 12 Nov 2020 02:39:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 2504A86C99
 for <iommu@lists.linux-foundation.org>; Thu, 12 Nov 2020 02:39:05 +0000 (UTC)
IronPort-SDR: 9UwEVqK+x7YO1c7n0DIkEpoVOnBlsDKbo4YPCSLxf8JzM1BULm434DfQLbH6eZV4kQzJx3erXh
 z28+nPIf1eeg==
X-IronPort-AV: E=McAfee;i="6000,8403,9802"; a="231869745"
X-IronPort-AV: E=Sophos;i="5.77,471,1596524400"; d="scan'208";a="231869745"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Nov 2020 18:39:01 -0800
IronPort-SDR: IbJu6Mxa28D/xM8Gx7YHlTSRoO1y+91oYe/IZz2ssd97oZiyQdAE1UilANnI/ausM3Llsqao6d
 xIWRTvK+ivQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,471,1596524400"; d="scan'208";a="366170532"
Received: from allen-box.sh.intel.com (HELO [10.239.159.28]) ([10.239.159.28])
 by FMSMGA003.fm.intel.com with ESMTP; 11 Nov 2020 18:38:56 -0800
Subject: Re: [PATCH v6 5/5] vfio/type1: Use mdev bus iommu_ops for IOMMU
 callbacks
To: Alex Williamson <alex.williamson@redhat.com>,
 "Tian, Kevin" <kevin.tian@intel.com>
References: <20201030045809.957927-1-baolu.lu@linux.intel.com>
 <20201030045809.957927-6-baolu.lu@linux.intel.com>
 <MWHPR11MB1645DEBE7C0E7A61D22081DD8C150@MWHPR11MB1645.namprd11.prod.outlook.com>
 <20201030150625.2dc5fb9b@w520.home>
 <5802fc4a-7dc0-eda7-4e7c-809bcec6bd90@linux.intel.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <d171ae28-a99a-a47b-aeb1-3231391e8c82@linux.intel.com>
Date: Thu, 12 Nov 2020 10:31:55 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <5802fc4a-7dc0-eda7-4e7c-809bcec6bd90@linux.intel.com>
Content-Language: en-US
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, "Jiang,
 Dave" <dave.jiang@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Robin Murphy <robin.murphy@arm.com>
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

SGkgQWxleCwKCk9uIDExLzMvMjAgMToyMiBQTSwgTHUgQmFvbHUgd3JvdGU6Cj4gSGkgQWxleCwK
PiAKPiBPbiAxMC8zMS8yMCA1OjA2IEFNLCBBbGV4IFdpbGxpYW1zb24gd3JvdGU6Cj4+IE9uIEZy
aSwgMzAgT2N0IDIwMjAgMDY6MTY6MjggKzAwMDAKPj4gIlRpYW4sIEtldmluIiA8a2V2aW4udGlh
bkBpbnRlbC5jb20+IHdyb3RlOgo+Pgo+Pj4+IEZyb206IEx1IEJhb2x1IDxiYW9sdS5sdUBsaW51
eC5pbnRlbC5jb20+Cj4+Pj4gU2VudDogRnJpZGF5LCBPY3RvYmVyIDMwLCAyMDIwIDEyOjU4IFBN
Cj4+Pj4KPj4+PiBXaXRoIHRoZSBJT01NVSBkcml2ZXIgcmVnaXN0ZXJpbmcgaW9tbXVfb3BzIGZv
ciB0aGUgbWRldl9idXMsIHRoZQo+Pj4+IElPTU1VCj4+Pj4gb3BlcmF0aW9ucyBvbiBhbiBtZGV2
IGNvdWxkIGJlIGRvbmUgaW4gdGhlIHNhbWUgd2F5IGFzIGFueSBub3JtYWwgCj4+Pj4gZGV2aWNl
Cj4+Pj4gKGZvciBleGFtcGxlLCBQQ0kvUENJZSkuIFRoZXJlJ3Mgbm8gbmVlZCB0byBkaXN0aW5n
dWlzaCBhbiBtZGV2IGZyb20KPj4+PiBvdGhlcnMgZm9yIGlvbW11IG9wZXJhdGlvbnMuIFJlbW92
ZSB0aGUgdW5uZWNlc3NhcnkgY29kZS4KPj4+Cj4+PiBUaGlzIGlzIHJlYWxseSBhIG5pY2UgY2xl
YW51cCBhcyB0aGUgb3V0cHV0IG9mIHRoaXMgY2hhbmdlISA6KQo+Pgo+PiBJdCdzIGVhc3kgdG8g
cmVtb3ZlIGEgYnVuY2ggb2YgY29kZSB3aGVuIHRoZSByZXN1bHQgaXMgYnJlYWtpbmcKPj4gZXZl
cnlvbmUgZWxzZS7CoCBQbGVhc2Ugc2hhcmUgd2l0aCBtZSBob3cgU1ItSU9WIGJhY2tlZCBtZGV2
cyBjb250aW51ZQo+PiB0byB3b3JrIG9uIEFNRCBwbGF0Zm9ybXMsIG9yIGhvdyB0aGV5IG1pZ2h0
IHdvcmsgb24gQVJNIHBsYXRmb3Jtcywgd2hlbgo+PiBzaW92X2lvbW11X29wcyAoVlQtZCBvbmx5
KSBiZWNvbWVzIHRoZSBvbmUgYW5kIG9ubHkgcHJvdmlkZXIgb2YKPj4gaW9tbXVfb3BzIG9uIHRo
ZSBtZGV2IGJ1cy7CoCBIYXJkIE5BSyBvbiB0aGlzIHNlcmllcy7CoCBUaGFua3MsCj4gCj4gSSBm
b2N1c2VkIHRvbyBtdWNoIG9uIGEgZmVhdHVyZSBhbmQgZm9yZ290IGFib3V0IHVuaXZlcnNpdHku
IEkgc2hvdWxkCj4gYXBvbG9naXplIGZvciB0aGlzLiBTb3JyeSBhYm91dCBpdCEKPiAKPiBCYWNr
IHRvIHRoZSBvcmlnaW5hbCBpbnRlbnRpb24gb2YgdGhpcyBzZXJpZXMuIFRoZSBhdXggZG9tYWlu
IHdhcwo+IGFsbG9jYXRlZCBpbiB2ZmlvL21kZXYsIGJ1dCBpdCdzIGFsc28gbmVlZGVkIGJ5IHRo
ZSB2RENNIGNvbXBvbmVudCBvZiBhCj4gZGV2aWNlIGRyaXZlciBmb3IgbWVkaWF0ZWQgY2FsbGJh
Y2tzLiBDdXJyZW50bHkgdmZpby9tZGV2IG9yIGlvbW11IGNvcmUKPiBoYXMgbm8gc3VwcG9ydCBm
b3IgdGhpcy4KPiAKPiBXZSBoYWQgYSBwcm9wb3NhbCB3aGVuIHdlIGZpcnN0IGRpZCBhdXgtZG9t
YWluIHN1cHBvcnQuIEJ1dCB3YXMgbm90Cj4gZGlzY3Vzc2VkIHNpbmNlIHRoZXJlIHdhcyBubyBj
b25zdW1lciBhdCB0aGF0IHRpbWUuCj4gCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgt
aW9tbXUvMjAxODExMDUwNzM0MDguMjE4MTUtNy1iYW9sdS5sdUBsaW51eC5pbnRlbC5jb20vIAoK
RXhwb3NpbmcgaW9tbXVfZG9tYWluIG91dHNpZGUgb2YgdGhlIHZmaW8vaW9tbXUgYWJzdHJhY3Qg
c2VlbXMgbm90IGEKc2VjdXJlIGlkZWEuIEkgaGF2ZSBwb3N0ZWQgYSBuZXcgcHJvcG9zYWwuIENh
biB5b3UgcGxlYXNlIGhlbHAgdG8KcmV2aWV3PwoKaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGlu
dXgtaW9tbXUvMjAyMDExMTIwMjI0MDcuMjA2Mzg5Ni0xLWJhb2x1Lmx1QGxpbnV4LmludGVsLmNv
bS8KCkJlc3QgcmVnYXJkcy4KYmFvbHUKCj4gCj4gCj4gRG9lcyBpdCBsb29rIGdvb2QgdG8geW91
PyBJIGNhbiBzZW5kIHBhdGNoZXMgb2Ygc3VjaCBzb2x1dGlvbiBmb3IKPiBkaXNjdXNzaW9uIGlm
IHlvdSB0aGluayBpdCdzIGEgcmlnaHQgd2F5Lgo+IAo+IEV4dGVuZGluZyB0aGUgaW9tbXUgY29y
ZSBmb3Igc3ViZGV2aWNlIHBhc3N0aHJvdWdoIHN1cHBvcnQgc291bmRzIGFuCj4gaW50ZXJlc3Rp
bmcgdG9waWMsIGJ1dCBpdCB3aWxsIHRha2UgbXVjaCB0aW1lIGJlZm9yZSB3ZSByZWFjaCBhCj4g
Y29uc2Vuc3VzLiBJdCBzb3VuZHMgYSBnb29kIHRvcGljIGZvciB0aGUgbmV4dCB5ZWFyJ3MgTFBD
L01DIDotKS4KPiAKPiBCZXN0IHJlZ2FyZHMsCj4gYmFvbHUKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3Rz
LmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2lvbW11
