Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FC2DC433EF
	for <iommu@archiver.kernel.org>; Wed,  1 Jun 2022 05:47:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0F01C81418;
	Wed,  1 Jun 2022 05:47:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jCEFAVTmJnuy; Wed,  1 Jun 2022 05:47:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id D0D3B813FE;
	Wed,  1 Jun 2022 05:47:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 970D6C0032;
	Wed,  1 Jun 2022 05:47:39 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EAD89C002D
 for <iommu@lists.linux-foundation.org>; Wed,  1 Jun 2022 05:47:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E6F32408FB
 for <iommu@lists.linux-foundation.org>; Wed,  1 Jun 2022 05:47:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id toq51WkJydQ5 for <iommu@lists.linux-foundation.org>;
 Wed,  1 Jun 2022 05:47:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 28BC0408F8
 for <iommu@lists.linux-foundation.org>; Wed,  1 Jun 2022 05:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1654062457; x=1685598457;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=pz8nnaQVnwSBHflv/+Mi+yb60f/0IVaCCTD8aF3LOog=;
 b=IXcvMfIk4b/CzCi//HCGNxIN+Z3wCHqyPzXBcoP8rXdyS4kYYFueCoPo
 C2NJvu1a6OyQmsYL5rztWReq021mnolECCsv6RLtnEBmyxWQ/Rrf3Jivl
 1A2Tb2aV6Lkgesd2UMS4qQUANPeFjzmyBT8WoboNWam10+ihrpx+mKxhq
 zc4IhdXPW6jla5PXmQPYBFX8UPucwZTIMxALekV0VzpjGj3sumYfcuf7A
 lpwjPN8hYdog7ZWz4ar0deRZo6rcd8PTIvjOlkvXmZFxLlzZjqvWtaxmk
 larA3nDXz9d8UBCEOYigY7IeWbRFTDZCG5t8J81lMzpqzISAYO3gwE87r Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10364"; a="275204429"
X-IronPort-AV: E=Sophos;i="5.91,266,1647327600"; d="scan'208";a="275204429"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 May 2022 22:47:36 -0700
X-IronPort-AV: E=Sophos;i="5.91,266,1647327600"; d="scan'208";a="706909235"
Received: from hej1-mobl.ccr.corp.intel.com (HELO [10.255.28.123])
 ([10.255.28.123])
 by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 May 2022 22:47:33 -0700
Message-ID: <5da96e23-113d-c0e3-fb17-2ae52a66ec8e@linux.intel.com>
Date: Wed, 1 Jun 2022 13:47:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 01/12] iommu/vt-d: Use iommu_get_domain_for_dev() in
 debugfs
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>, Robin Murphy <robin.murphy@arm.com>
References: <20220527063019.3112905-1-baolu.lu@linux.intel.com>
 <20220527063019.3112905-2-baolu.lu@linux.intel.com>
 <20220527145910.GQ1343366@nvidia.com>
 <eda4d688-257b-d12a-56c0-0f9d3a10ef8c@linux.intel.com>
 <20220530121412.GX1343366@nvidia.com>
 <42623a73-c288-1c0d-7021-93caff4ffb6f@linux.intel.com>
 <0b7bd793-a3c7-e7e7-8ef0-214dd5b98f05@arm.com>
 <20220531155904.GA3726345@nvidia.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20220531155904.GA3726345@nvidia.com>
Cc: Kevin Tian <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
 iommu@lists.linux-foundation.org, Jacob jun Pan <jacob.jun.pan@intel.com>,
 Will Deacon <will@kernel.org>
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

T24gMjAyMi81LzMxIDIzOjU5LCBKYXNvbiBHdW50aG9ycGUgd3JvdGU6Cj4gT24gVHVlLCBNYXkg
MzEsIDIwMjIgYXQgMDI6NTI6MjhQTSArMDEwMCwgUm9iaW4gTXVycGh5IHdyb3RlOgo+IAo+Pj4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBicmVhazsKPj4+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIHBndGFibGVfd2Fsa19sZXZlbChtLCBwaHlzX3RvX3ZpcnQocGh5c19hZGRyKSwK
Pj4KPj4gQWxzbywgb2JsaWdhdG9yeSByZW1pbmRlciB0aGF0IHBmbl92YWxpZCgpIG9ubHkgbWVh
bnMgdGhhdCBwZm5fdG9fcGFnZSgpCj4+IGdldHMgeW91IGEgdmFsaWQgc3RydWN0IHBhZ2UuIFdo
ZXRoZXIgdGhhdCBwYWdlIGlzIGRpcmVjdC1tYXBwZWQga2VybmVsCj4+IG1lbW9yeSBvciBub3Qg
aXMgYSBkaWZmZXJlbnQgbWF0dGVyLgo+IAo+IEV2ZW4gdGhvdWdoIHRoaXMgaXMgZGVidWdmcywg
aWYgdGhlIG9wZXJhdGlvbiBpcyBza2V0Y2h5IGxpa2UgdGhhdCBhbmQKPiBjYW4gdGhlb3J0aWNh
bGx5IGNyYXNoIHRoZSBrZXJuZWwgdGhlIGRyaXZlciBzaG91bGQgdGVzdCBjYXBhYmlsaXRpZXMs
Cj4gQ0FQX1NZU19SQVdJTyBvciBzb21ldGhpbmcgbWF5IGJlIGFwcHJvcHJpYXRlLiBJIGRvbid0
IHRoaW5rIHdlIGhhdmUgYQo+IGJldHRlciBjYXAgZm9yICd1c2Vyc3BhY2UgbWF5IGNyYXNoIHRo
ZSBrZXJuZWwnCgpZZXMuIFdlIHNob3VsZCB0ZXN0IGJvdGggQ0FQX1NZU19BRE1JTiBhbmQgQ0FQ
X1NZU19SQVdJTy4KCkJlc3QgcmVnYXJkcywKYmFvbHUKCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5s
aW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFp
bG1hbi9saXN0aW5mby9pb21tdQ==
