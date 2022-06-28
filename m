Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EBBDC43334
	for <iommu@archiver.kernel.org>; Tue, 28 Jun 2022 05:46:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id F09FC410D6;
	Tue, 28 Jun 2022 05:46:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org F09FC410D6
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hCS1Z/YK
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WxbngU_TzOrN; Tue, 28 Jun 2022 05:46:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 81C6E410CB;
	Tue, 28 Jun 2022 05:46:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 81C6E410CB
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 635CDC0039;
	Tue, 28 Jun 2022 05:46:41 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BB287C002D
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jun 2022 05:46:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 953C4410D6
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jun 2022 05:46:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 953C4410D6
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dFlBpBh3Lz-C for <iommu@lists.linux-foundation.org>;
 Tue, 28 Jun 2022 05:46:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B498B410CB
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B498B410CB
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jun 2022 05:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1656395198; x=1687931198;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=TGG80vJaDllAevuk4S1BcXyz1JoWpznRrkuX2d/Mvkc=;
 b=hCS1Z/YKPh15yNpB+x1XkLl5LxSWkeGzJyiuOjmoBmzSuIxEohOS81Ej
 21bULGUK1qqni7lUfFw2s6xmGLZ6bua9IQct5rcHE5+vN54gydMLvnu28
 Hhq0vSik6Wmg3pDIPApj037Cdv1DM6X00TYCC9TReiS8tuX0ZhIz66mpF
 ADsBJgrJ62lSh4KK3yFRMMSZTz7mVajgVVvMySMClmQYYDrCSOozznr75
 X+PHPOkBDdMkmEcBx7mR3wm2ZvCA7dr14z+rMpyFLYsKFdncpgfyak4yr
 8Efshi4I06X7ojDIap9o/rvBhF6EBvc2dTvCmww/t8yFFfx6HeeSGHxa8 g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10391"; a="345638484"
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; d="scan'208";a="345638484"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Jun 2022 22:46:37 -0700
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; d="scan'208";a="646759897"
Received: from ltang11-mobl1.ccr.corp.intel.com (HELO [10.249.169.64])
 ([10.249.169.64])
 by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Jun 2022 22:46:34 -0700
Message-ID: <14fa06b8-e361-db68-8fe4-490aeb0242da@linux.intel.com>
Date: Tue, 28 Jun 2022 13:46:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v9 06/11] arm-smmu-v3/sva: Add SVA domain support
Content-Language: en-US
To: Zhangfei Gao <zhangfei.gao@linaro.org>, Joerg Roedel <joro@8bytes.org>,
 Jason Gunthorpe <jgg@nvidia.com>, Christoph Hellwig <hch@infradead.org>,
 Kevin Tian <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>
References: <20220621144353.17547-1-baolu.lu@linux.intel.com>
 <20220621144353.17547-7-baolu.lu@linux.intel.com>
 <9266198d-33fd-4cc5-fdaa-3ba5571543b1@linaro.org>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <9266198d-33fd-4cc5-fdaa-3ba5571543b1@linaro.org>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 iommu@lists.linux.dev, Jacob jun Pan <jacob.jun.pan@intel.com>
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

T24gMjAyMi82LzI3IDE5OjUwLCBaaGFuZ2ZlaSBHYW8gd3JvdGU6Cj4gCj4gT24gMjAyMi82LzIx
IOS4i+WNiDEwOjQzLCBMdSBCYW9sdSB3cm90ZToKPj4gQWRkIHN1cHBvcnQgZm9yIFNWQSBkb21h
aW4gYWxsb2NhdGlvbiBhbmQgcHJvdmlkZSBhbiBTVkEtc3BlY2lmaWMKPj4gaW9tbXVfZG9tYWlu
X29wcy4KPj4KPj4gU2lnbmVkLW9mZi1ieTogTHUgQmFvbHUgPGJhb2x1Lmx1QGxpbnV4LmludGVs
LmNvbT4KPj4gUmV2aWV3ZWQtYnk6IEplYW4tUGhpbGlwcGUgQnJ1Y2tlciA8amVhbi1waGlsaXBw
ZUBsaW5hcm8ub3JnPgo+IAo+IFRlc3RlZC1ieTogWmhhbmdmZWkgR2FvIDx6aGFuZ2ZlaS5nYW9A
bGluYXJvLm9yZz4KPiBIYXZlIHRlc3RlZCB0aGUgc2VyaWVzIG9uIGFhcmNoNjQuCgpUaGFuayB5
b3UgdmVyeSBtdWNoISBWZXJ5IGFwcHJlY2lhdGVkIGZvciB5b3VyIGhlbHAhCgpCZXN0IHJlZ2Fy
ZHMsCmJhb2x1Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRw
czovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
