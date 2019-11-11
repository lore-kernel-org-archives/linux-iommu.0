Return-Path: <SRS0=z06/=ZD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ACC8C43331
	for <iommu@archiver.kernel.org>; Mon, 11 Nov 2019 02:20:25 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E62D2067B
	for <iommu@archiver.kernel.org>; Mon, 11 Nov 2019 02:20:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E62D2067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id C23B4C52;
	Mon, 11 Nov 2019 02:20:24 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 21423C4E
	for <iommu@lists.linux-foundation.org>;
	Mon, 11 Nov 2019 02:20:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 6F6EE102
	for <iommu@lists.linux-foundation.org>;
	Mon, 11 Nov 2019 02:20:22 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
	by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	10 Nov 2019 18:20:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,291,1569308400"; d="scan'208";a="228794367"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136])
	([10.239.159.136])
	by fmsmga004.fm.intel.com with ESMTP; 10 Nov 2019 18:20:19 -0800
Subject: Re: [PATCH v2 1/1] iommu/vt-d: Add Kconfig option to enable/disable
	scalable mode
To: Qian Cai <cai@lca.pw>
References: <519c1126-ab91-1308-bdd0-c8d1be7a1c63@linux.intel.com>
	<2BBFF955-5533-43CD-849A-2BA6B2CC1AF2@lca.pw>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <8663cb77-6ec3-fc2a-87bb-3d6629ec1a7f@linux.intel.com>
Date: Mon, 11 Nov 2019 10:17:25 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <2BBFF955-5533-43CD-849A-2BA6B2CC1AF2@lca.pw>
Content-Language: en-US
Cc: kevin.tian@intel.com, ashok.raj@intel.com, linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org, jacob.jun.pan@intel.com,
	David Woodhouse <dwmw2@infradead.org>
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
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

SGksCgpPbiAxMS8xMS8xOSAxMDowMCBBTSwgUWlhbiBDYWkgd3JvdGU6Cj4gCj4gCj4+IE9uIE5v
diAxMCwgMjAxOSwgYXQgODozMCBQTSwgTHUgQmFvbHUgPGJhb2x1Lmx1QGxpbnV4LmludGVsLmNv
bT4gd3JvdGU6Cj4+Cj4+IEhvdyBhYm91dCAicGFzaWQgYmFzZWQgbXVsdGlwbGUgc3RhZ2VzIERN
QSB0cmFuc2xhdGlvbiI/Cj4gCj4gSXQgaXMgYmV0dGVyIGJ1dCBJIGFtIHN0aWxsIG5vdCBzdXJl
IGhvdyBkZXZlbG9wZXJzIHNob3VsZCBzZWxlY3QgaXQgb3Igbm90IHdoZW4gYXNraW5nLiBJZGVh
bGx5LCBzaG91bGQgaXQgbWVudGlvbiBwcm9zIGFuZCBjb25zIG9mIHRoaXM/IEF0IG1pbmltYWws
IHRoZXJlIHNob3VsZCBiZSBhIGxpbmUgc2FpZCDigJxpZiBub3Qgc3VyZSB3aGF0IHRoaXMgaXMs
IHNlbGVjdCBO4oCdPwo+IAoKQWN0dWFsbHksIEknZCByZWNvbW1lbmQgImlmIG5vdCBzdXJlLCB1
c2UgdGhlIGRlZmF1bHQgdmFsdWUiLiA6LSkKCkJlc3QgcmVnYXJkcywKYmFvbHUKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0
CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3Vu
ZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
