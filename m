Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3380AC433F5
	for <iommu@archiver.kernel.org>; Tue, 14 Dec 2021 19:05:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CD6E240151;
	Tue, 14 Dec 2021 19:05:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XCM-M4Ng3u7c; Tue, 14 Dec 2021 19:05:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id BA25240251;
	Tue, 14 Dec 2021 19:05:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 71EAFC001E;
	Tue, 14 Dec 2021 19:05:43 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 176DBC0012
 for <iommu@lists.linux-foundation.org>; Tue, 14 Dec 2021 19:05:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 01EC540251
 for <iommu@lists.linux-foundation.org>; Tue, 14 Dec 2021 19:05:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eC-BdoEGFr-q for <iommu@lists.linux-foundation.org>;
 Tue, 14 Dec 2021 19:05:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 431E940151
 for <iommu@lists.linux-foundation.org>; Tue, 14 Dec 2021 19:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1639508741; x=1671044741;
 h=subject:to:cc:references:from:message-id:date:
 mime-version:in-reply-to:content-transfer-encoding;
 bh=moCcawZ7TdWbgzj24jFWevKSGpg/rJ0aDgg6BUfDmHk=;
 b=QYO9zy/YSo17999ywJjIHLw/Vm/Ik6shmgg8wXgfRwpCKn+dTNxQQrRe
 7G/lvxv9vXZ8JbjaO2VKVjMLkLrdGzNNlIOzbhKUN5Zf/pnpiHwOdl1lH
 oNCV2wCXc9zMdBh7yvE8dAseZxvETOaN/RFxCsSVTivoifazxzVh2vu9Y
 voPiHjyMbtOHXalwIBGh9TsAKDDijb7cngdJ3SZtExDJIecJpAb6muUYC
 mBlkuh2nCqy+kQHYu/BAs8rU69aJ/zztG+mL73qcGAy+K/nEOAbEYCYEO
 B7r9NMGhZAoLv59ymFUg3LHv0EvuKJ6beucThivMFd8TX+NxAyjNGwKc8 g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10197"; a="263202643"
X-IronPort-AV: E=Sophos;i="5.88,205,1635231600"; d="scan'208";a="263202643"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Dec 2021 10:40:52 -0800
X-IronPort-AV: E=Sophos;i="5.88,205,1635231600"; d="scan'208";a="505470613"
Received: from soniasah-mobl2.amr.corp.intel.com (HELO [10.212.242.116])
 ([10.212.242.116])
 by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Dec 2021 10:40:51 -0800
Subject: Re: [PATCH V7 1/5] swiotlb: Add swiotlb bounce buffer remap function
 for HV IVM
To: Tianyu Lan <ltykernel@gmail.com>, kys@microsoft.com,
 haiyangz@microsoft.com, sthemmin@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 davem@davemloft.net, kuba@kernel.org, jejb@linux.ibm.com,
 martin.petersen@oracle.com, arnd@arndb.de, hch@infradead.org,
 m.szyprowski@samsung.com, robin.murphy@arm.com, thomas.lendacky@amd.com,
 Tianyu.Lan@microsoft.com, michael.h.kelley@microsoft.com
References: <20211213071407.314309-1-ltykernel@gmail.com>
 <20211213071407.314309-2-ltykernel@gmail.com>
 <198e9243-abca-b23e-0e8e-8581a7329ede@intel.com>
 <3243ff22-f6c8-b7cd-26b7-6e917e274a7c@gmail.com>
From: Dave Hansen <dave.hansen@intel.com>
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
 z5cecg==
Message-ID: <c25ff1e8-4d1e-cf1c-a9f6-c189307f92fd@intel.com>
Date: Tue, 14 Dec 2021 10:40:49 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <3243ff22-f6c8-b7cd-26b7-6e917e274a7c@gmail.com>
Content-Language: en-US
Cc: linux-arch@vger.kernel.org, parri.andrea@gmail.com,
 linux-hyperv@vger.kernel.org, brijesh.singh@amd.com,
 linux-scsi@vger.kernel.org, konrad.wilk@oracle.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 vkuznets@redhat.com, hch@lst.de
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

T24gMTIvMTMvMjEgODozNiBQTSwgVGlhbnl1IExhbiB3cm90ZToKPiBPbiAxMi8xNC8yMDIxIDEy
OjQ1IEFNLCBEYXZlIEhhbnNlbiB3cm90ZToKPj4gT24gMTIvMTIvMjEgMTE6MTQgUE0sIFRpYW55
dSBMYW4gd3JvdGU6Cj4+PiBJbiBJc29sYXRpb24gVk0gd2l0aCBBTUQgU0VWLCBib3VuY2UgYnVm
ZmVyIG5lZWRzIHRvIGJlIGFjY2Vzc2VkIHZpYQo+Pj4gZXh0cmEgYWRkcmVzcyBzcGFjZSB3aGlj
aCBpcyBhYm92ZSBzaGFyZWRfZ3BhX2JvdW5kYXJ5IChFLkcgMzkgYml0Cj4+PiBhZGRyZXNzIGxp
bmUpIHJlcG9ydGVkIGJ5IEh5cGVyLVYgQ1BVSUQgSVNPTEFUSU9OX0NPTkZJRy4gVGhlIGFjY2Vz
cwo+Pj4gcGh5c2ljYWwgYWRkcmVzcyB3aWxsIGJlIG9yaWdpbmFsIHBoeXNpY2FsIGFkZHJlc3Mg
Kwo+Pj4gc2hhcmVkX2dwYV9ib3VuZGFyeS4KPj4+IFRoZSBzaGFyZWRfZ3BhX2JvdW5kYXJ5IGlu
IHRoZSBBTUQgU0VWIFNOUCBzcGVjIGlzIGNhbGxlZCB2aXJ0dWFsIHRvcCBvZgo+Pj4gbWVtb3J5
KHZUT00pLiBNZW1vcnkgYWRkcmVzc2VzIGJlbG93IHZUT00gYXJlIGF1dG9tYXRpY2FsbHkgdHJl
YXRlZCBhcwo+Pj4gcHJpdmF0ZSB3aGlsZSBtZW1vcnkgYWJvdmUgdlRPTSBpcyB0cmVhdGVkIGFz
IHNoYXJlZC4KPj4KPj4gVGhpcyBzZWVtcyB0byBiZSBpbmRlcGVuZGVudGx5IHJlaW50cm9kdWNp
bmcgc29tZSBvZiB0aGUgU0VWCj4+IGluZnJhc3RydWN0dXJlLsKgIElzIGl0IHJlYWxseSBPSyB0
aGF0IHRoaXMgZG9lc24ndCBpbnRlcmFjdCBhdCBhbGwgd2l0aAo+PiBhbnkgZXhpc3RpbmcgU0VW
IGNvZGU/Cj4+Cj4+IEZvciBpbnN0YW5jZSwgZG8gd2UgbmVlZCBhIG5ldyAnc3dpb3RsYl91bmVu
Y3J5cHRlZF9iYXNlJywgb3Igc2hvdWxkCj4+IHRoaXMganVzdCBiZSB1c2luZyBzbWVfbWVfbWFz
ayBzb21laG93Pwo+IAo+IMKgwqDCoMKgwqDCoCBUaGFua3MgZm9yIHlvdXIgcmV2aWV3LiBIeXBl
ci1WIHByb3ZpZGVzIGEgcGFyYS12aXJ0dWFsaXplZAo+IGNvbmZpZGVudGlhbCBjb21wdXRpbmcg
c29sdXRpb24gYmFzZWQgb24gdGhlIEFNRCBTRVYgZnVuY3Rpb24gYW5kIG5vdAo+IGV4cG9zZSBz
ZXYmc21lIGNhcGFiaWxpdGllcyB0byBndWVzdC4gU28gc21lX21lX21hc2sgaXMgdW5zZXQgaW4g
dGhlCj4gSHlwZXItViBJc29sYXRpb24gVk0uIHN3aW90bGJfdW5lbmNyeXB0ZWRfYmFzZSBpcyBt
b3JlIGdlbmVyYWwgc29sdXRpb24KPiB0byBoYW5kbGUgc3VjaCBjYXNlIG9mIGRpZmZlcmVudCBh
ZGRyZXNzIHNwYWNlIGZvciBlbmNyeXB0ZWQgYW5kCj4gZGVjcnlwdGVkIG1lbW9yeSBhbmQgb3Ro
ZXIgcGxhdGZvcm0gYWxzbyBtYXkgcmV1c2UgaXQuCgpJIGRvbid0IHJlYWxseSB1bmRlcnN0YW5k
IGhvdyB0aGlzIGNhbiBiZSBtb3JlIGdlbmVyYWwgYW55ICpub3QqIGdldAp1dGlsaXplZCBieSB0
aGUgZXhpc3RpbmcgU0VWIHN1cHBvcnQuCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3Vu
ZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0
aW5mby9pb21tdQ==
