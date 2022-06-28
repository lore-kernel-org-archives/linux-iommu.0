Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75EA3C43334
	for <iommu@archiver.kernel.org>; Tue, 28 Jun 2022 06:13:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 21FB5405BA;
	Tue, 28 Jun 2022 06:13:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 21FB5405BA
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=GGv0a+MK
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PageoytYEdaH; Tue, 28 Jun 2022 06:13:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id EDD504049E;
	Tue, 28 Jun 2022 06:13:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org EDD504049E
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CA6ECC0039;
	Tue, 28 Jun 2022 06:13:29 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 56F04C002D
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jun 2022 06:13:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 320A3817A9
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jun 2022 06:13:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 320A3817A9
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=GGv0a+MK
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Z3B2aMLzTC7x for <iommu@lists.linux-foundation.org>;
 Tue, 28 Jun 2022 06:13:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8AD34817A6
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8AD34817A6
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jun 2022 06:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1656396808; x=1687932808;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=p0bnmQCen9WNeg7tpcCymPDSOB5Bd4ApV3pk2UCSGa0=;
 b=GGv0a+MK408fvxkH/FhW7yYKzt8a9T/kFYSOpTqN9Y6wJlACOX9d9VCq
 BJL40sylziUAa2DG3Hm0Wy1b6zTf+V3xNv5zzlyDg5dpXLgG5Y1M2/XGU
 wSGD5Q93CjNQXH4v0OAY79IUDP8xKJhx66YVfRkaWMmhxIxLxNjoAhOFo
 KFsp03y9H/KkdPrCSEpR+qlpBjovPLXaf9BpTys3M4CHjl1GfXzn3BO5D
 lRxIg7/TmD8nDnwBJ7kl10iUQoUwpA/pCMMD6NdZzONPC5Z211U0GjNvE
 2pCx3s0gbLMT+mfQ5DDZYNBEJ+ovgUNHTHKcdpQphwGYWeicfhy64b6sl w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10391"; a="281684252"
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; d="scan'208";a="281684252"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Jun 2022 23:13:26 -0700
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; d="scan'208";a="646769755"
Received: from ltang11-mobl1.ccr.corp.intel.com (HELO [10.249.169.64])
 ([10.249.169.64])
 by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Jun 2022 23:13:22 -0700
Message-ID: <5f5f7518-415a-ba21-07b0-15f526bbf045@linux.intel.com>
Date: Tue, 28 Jun 2022 14:13:20 +0800
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
 Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>,
 tony.zhu@intel.com
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

T24gMjAyMi82LzI3IDE5OjUwLCBaaGFuZ2ZlaSBHYW8gd3JvdGU6Cj4gCj4gCj4gT24gMjAyMi82
LzIxIOS4i+WNiDEwOjQzLCBMdSBCYW9sdSB3cm90ZToKPj4gQWRkIHN1cHBvcnQgZm9yIFNWQSBk
b21haW4gYWxsb2NhdGlvbiBhbmQgcHJvdmlkZSBhbiBTVkEtc3BlY2lmaWMKPj4gaW9tbXVfZG9t
YWluX29wcy4KPj4KPj4gU2lnbmVkLW9mZi1ieTogTHUgQmFvbHUgPGJhb2x1Lmx1QGxpbnV4Lmlu
dGVsLmNvbT4KPj4gUmV2aWV3ZWQtYnk6IEplYW4tUGhpbGlwcGUgQnJ1Y2tlciA8amVhbi1waGls
aXBwZUBsaW5hcm8ub3JnPgo+IAo+IFRlc3RlZC1ieTogWmhhbmdmZWkgR2FvIDx6aGFuZ2ZlaS5n
YW9AbGluYXJvLm9yZz4KPiBIYXZlIHRlc3RlZCB0aGUgc2VyaWVzIG9uIGFhcmNoNjQuCgpUb255
IGhhcyBiZWVuIGhlbHBpbmcgdG8gdmFsaWRhdGUgdGhpcyBzZXJpZXMgb24gSW50ZWwncyBwbGF0
Zm9ybS4KClRvbnksIGNhbiBJIGFkZCB5b3VyIFRlc3QtYnkgYXMgd2VsbCBpbiB0aGlzIHNlcmll
cz8KCkJlc3QgcmVnYXJkcywKYmFvbHUKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5k
YXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2lvbW11
