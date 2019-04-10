Return-Path: <SRS0=ghiB=SM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8F31C10F11
	for <iommu@archiver.kernel.org>; Wed, 10 Apr 2019 05:28:48 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B53B20850
	for <iommu@archiver.kernel.org>; Wed, 10 Apr 2019 05:28:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B53B20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 367DD14BB;
	Wed, 10 Apr 2019 05:28:48 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 2D42114B7
	for <iommu@lists.linux-foundation.org>;
	Wed, 10 Apr 2019 05:28:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id C47C9735
	for <iommu@lists.linux-foundation.org>;
	Wed, 10 Apr 2019 05:28:27 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
	by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	09 Apr 2019 22:28:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,332,1549958400"; d="scan'208";a="130076506"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136])
	([10.239.159.136])
	by orsmga007.jf.intel.com with ESMTP; 09 Apr 2019 22:28:25 -0700
Subject: Re: [PATCH v2 3/7] iommu/vt-d: Expose ISA direct mapping region via
	iommu_get_resv_regions
To: James Sewart <jamessewart@arista.com>
References: <0F0C82BE-86E5-4BAC-938C-6F7629E18D27@arista.com>
	<83B82113-8AE5-4B0C-A079-F389520525BD@arista.com>
	<F531CABB-FFDA-4E0A-A3D5-095FF338DD5A@arista.com>
	<b6b3dda7-31e3-c1e8-16cb-07feb7d5431d@linux.intel.com>
	<A489539F-4DD4-438A-AD9A-1A2F50404DB9@arista.com>
	<fb1565dc-d991-acf9-e275-c0090f69f47e@linux.intel.com>
	<445F31EA-20F3-481C-B1DF-8B163791FF8C@arista.com>
	<cf43d26b-f1ee-8469-c17a-e5c412dcfeab@linux.intel.com>
	<6C211BF1-B5A0-4821-AB42-092B573DE667@arista.com>
	<8B1FC0C7-9BAC-498D-B1F0-0138EACF75C2@arista.com>
	<ddcaa472-7bff-ddd3-0518-f2ba694b3279@linux.intel.com>
	<9AECB54A-2DA7-4ABD-A9B5-0549E108D1AF@arista.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <abbfecda-8990-315c-ac7a-7f571e86aba2@linux.intel.com>
Date: Wed, 10 Apr 2019 13:22:30 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <9AECB54A-2DA7-4ABD-A9B5-0549E108D1AF@arista.com>
Content-Language: en-US
Cc: Dmitry Safonov <dima@arista.com>, Tom Murphy <tmurphy@arista.com>,
	linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Content-Type: text/plain; charset="UTF-8"; format="flowed"
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190410052230.uTLFmda6273BfEwUQS_ydxLxKR9oHscTRciNY5_aNHU@z>

SGkgSmFtZXMsCgpPbiA0LzYvMTkgMjowMiBBTSwgSmFtZXMgU2V3YXJ0IHdyb3RlOgo+IEhleSBM
dSwKPiAKPiBNeSBiYWQsIGRpZCBzb21lIGRlYnVnZ2luZyBvbiBteSBlbmQuIFRoZSBpc3N1ZSB3
YXMgc3dhcHBpbmcgb3V0Cj4gZmluZF9kb21haW4gZm9yIGlvbW11X2dldF9kb21haW5fZm9yX2Rl
di4gSXQgc2VlbXMgaW4gc29tZSBzaXR1YXRpb25zIHRoZQo+IGRvbWFpbiBpcyBub3QgYXR0YWNo
ZWQgdG8gdGhlIGdyb3VwIGJ1dCB0aGUgZGV2aWNlIGlzIGV4cGVjdGVkIHRvIGhhdmUgdGhlCj4g
ZG9tYWluIHN0aWxsIHN0b3JlZCBpbiBpdHMgYXJjaGRhdGEuCj4gCj4gSeKAmXZlIGF0dGFjaGVk
IHRoZSBmaW5hbCBwYXRjaCB3aXRoIGZpbmRfZG9tYWluIHVucmVtb3ZlZCB3aGljaCBzZWVtcyB0
bwo+IHdvcmsgaW4gbXkgdGVzdGluZy4KPiAKCkp1c3QgbG9va2VkIGludG8geW91ciB2MyBwYXRj
aCBzZXQgYW5kIHNvbWUgdGhvdWdodHMgZnJvbSBteSBlbmQgcG9zdGVkCmhlcmUganVzdCBmb3Ig
eW91ciBpbmZvcm1hdGlvbi4KCkxldCBtZSBwb3N0IHRoZSBwcm9ibGVtcyB3ZSB3YW50IHRvIGFk
ZHJlc3MuCgoxLiBXaGVuIGFsbG9jYXRpbmcgYSBuZXcgZ3JvdXAgZm9yIGEgZGV2aWNlLCBob3cg
c2hvdWxkIHdlIGRldGVybWluZSB0aGUKdHlwZSBvZiB0aGUgZGVmYXVsdCBkb21haW4/CgoyLiBJ
ZiB3ZSBuZWVkIHRvIHB1dCBhIGRldmljZSBpbnRvIGFuIGV4aXN0aW5nIGdyb3VwIHdoaWNoIHVz
ZXMgYQpkaWZmZXJlbnQgdHlwZSBvZiBkb21haW4gZnJvbSB3aGF0IHRoZSBkZXZpY2UgZGVzaXJl
cyB0byB1c2UsIHdlIG1pZ2h0CmJyZWFrIHRoZSBmdW5jdGlvbmFsaXR5IG9mIHRoZSBkZXZpY2Uu
CgpNeSBuZXcgdGhvdWdodCBpcyBsZXR0aW5nIHRoZSBpb21tdSBnZW5lcmljIGNvZGUgdG8gZGV0
ZXJtaW5lIHRoZQpkZWZhdWx0IGRvbWFpbiB0eXBlIChoZW5jZSBteSBwcm9wb3NlZCB2ZW5kb3Ig
c3BlY2lmaWMgZGVmYXVsdCBkb21haW4KdHlwZSBwYXRjaGVzIGNvdWxkIGJlIGRyb3BwZWQpLgoK
SWYgdGhlIGRlZmF1bHQgZG9tYWluIHR5cGUgaXMgZHluYW1pY2FsIG1hcHBpbmcsIGFuZCBsYXRl
ciBpbiAKaW9tbXVfbm9fbWFwcGluZygpLCB3ZSBkZXRlcm1pbmVzIHRoYXQgd2UgbXVzdCB1c2Ug
YW4gaWRlbnRpdHkgZG9tYWluLAp3ZSB0aGVuIGNhbGwgaW9tbXVfcmVxdWVzdF9kbV9mb3JfZGV2
KGRldikuCgpJZiB0aGUgZGVmYXVsdCBkb21haW4gdHlwZSBpcyBpZGVudGl0eSBtYXBwaW5nLCBh
bmQgbGF0ZXIgaW4KaW9tbXVfbm9fbWFwcGluZygpLCB3ZSBkZXRlcm1pbmVkIHRoYXQgd2UgbXVz
dCB1c2UgYSBkeW5hbWljYWwgZG9tYWluLAp3ZSB0aGVuIGNhbGwgaW9tbXVfcmVxdWVzdF9kbWFf
ZG9tYWluX2Zvcl9kZXYoZGV2KS4KCldlIGFscmVhZHkgaGF2ZSBpb21tdV9yZXF1ZXN0X2RtX2Zv
cl9kZXYoKSBpbiBpb21tdS5jLiBXZSBvbmx5IG5lZWQgdG8KaW1wbGVtZW50IGlvbW11X3JlcXVl
c3RfZG1hX2RvbWFpbl9mb3JfZGV2KCkuCgpXaXRoIHRoaXMgZG9uZSwgeW91ciBwYXRjaCB0aXRs
ZWQgIkNyZWF0ZSBhbiBJT01NVSBncm91cCBmb3IgZGV2aWNlcwp0aGF0IHJlcXVpcmUgYW4gaWRl
bnRpdHkgbWFwIiBjb3VsZCBhbHNvIGJlIGRyb3BwZWQuCgpBbnkgdGhvdWdodHM/Cgo+IENoZWVy
cywKPiBKYW1lcy4KCkJlc3QgcmVnYXJkcywKTHUgQmFvbHUKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3Rz
LmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2lvbW11
