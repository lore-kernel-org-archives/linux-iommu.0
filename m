Return-Path: <SRS0=qe9F=AK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADFA1C433E0
	for <iommu@archiver.kernel.org>; Mon, 29 Jun 2020 13:39:19 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CF8020786
	for <iommu@archiver.kernel.org>; Mon, 29 Jun 2020 13:39:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CF8020786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 41A0A20525;
	Mon, 29 Jun 2020 13:39:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id inXH9txUZ6MK; Mon, 29 Jun 2020 13:39:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id C70EA204FB;
	Mon, 29 Jun 2020 13:39:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AE722C07FF;
	Mon, 29 Jun 2020 13:39:17 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5C00DC016E
 for <iommu@lists.linux-foundation.org>; Mon, 29 Jun 2020 13:39:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 5140F86DAF
 for <iommu@lists.linux-foundation.org>; Mon, 29 Jun 2020 13:39:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HWzdsqSz7Din for <iommu@lists.linux-foundation.org>;
 Mon, 29 Jun 2020 13:39:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 8600886D95
 for <iommu@lists.linux-foundation.org>; Mon, 29 Jun 2020 13:39:15 +0000 (UTC)
IronPort-SDR: aPHVn4L3a/FOJ1k4B2YYW+jiFh7pHITSAdHVpXvz7KamRnnXgZPB2xlyEY49GVzGd2XwTmu6Wt
 PVAL2aGyFJOg==
X-IronPort-AV: E=McAfee;i="6000,8403,9666"; a="125593306"
X-IronPort-AV: E=Sophos;i="5.75,294,1589266800"; d="scan'208";a="125593306"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jun 2020 06:39:04 -0700
IronPort-SDR: GOBMqQlGojLcDdG+5mlKFZRG9gJ8QV2ZkbkGgaSD2pc2JsK2FTpzVwlf29Xfp9W1iEJ4QONxVB
 TPoq3jVsldWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,294,1589266800"; d="scan'208";a="313048269"
Received: from unknown (HELO btopel-mobl.ger.intel.com) ([10.252.54.90])
 by fmsmga002.fm.intel.com with ESMTP; 29 Jun 2020 06:39:02 -0700
Subject: Re: add an API to check if a streamming mapping needs sync calls
To: Christoph Hellwig <hch@lst.de>
References: <20200629130359.2690853-1-hch@lst.de>
From: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>
Message-ID: <b97104e1-433c-8e35-59c6-b4dad047464c@intel.com>
Date: Mon, 29 Jun 2020 15:39:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200629130359.2690853-1-hch@lst.de>
Content-Language: en-US
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Jonathan Lemon <jonathan.lemon@gmail.com>,
 bpf@vger.kernel.org, Magnus Karlsson <magnus.karlsson@intel.com>
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

T24gMjAyMC0wNi0yOSAxNTowMywgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6Cj4gSGkgYWxsLAo+
IAo+IHRoaXMgc2VyaWVzIGxpZnRzIHRoZSBzb21ld2hhdCBoYWNreSBjaGVja3MgaW4gdGhlIFhT
SyBjb2RlIGlmIGEgRE1BCj4gc3RyZWFtaW5nIG1hcHBpbmcgbmVlZHMgZG1hX3N5bmNfc2luZ2xl
X2Zvcl97ZGV2aWNlLGNwdX0gY2FsbHMgdG8gdGhlCj4gRE1BIEFQSS4KPgoKVGhhbmtzIGEgbG90
IGZvciB3b3JraW5nIG9uLCBhbmQgZml4aW5nIHRoaXMsIENocmlzdG9waCEKCkkgdG9vayB0aGUg
c2VyaWVzIGZvciBhIHNwaW4sIGFuZCB0aGVyZSBhcmUgKG9idmlvdXNseSkgbm8gcGVyZm9ybWFu
Y2UKcmVncmVzc2lvbnMuCgpXb3VsZCB0aGUgcGF0Y2hlcyBnbyB0aHJvdWdoIHRoZSBuZXQvYnBm
IHRyZWVzIG9yIHNvbWV3aGVyZSBlbHNlPwoKRm9yIHRoZSBzZXJpZXM6ClRlc3RlZC1ieTogQmrD
tnJuIFTDtnBlbCA8Ympvcm4udG9wZWxAaW50ZWwuY29tPgpBY2tlZC1ieTogQmrDtnJuIFTDtnBl
bCA8Ympvcm4udG9wZWxAaW50ZWwuY29tPgoKCkJqw7ZybgoKPiAKPiBEaWZmc3RhdDoKPiAgIERv
Y3VtZW50YXRpb24vY29yZS1hcGkvZG1hLWFwaS5yc3QgfCAgICA4ICsrKysrCj4gICBpbmNsdWRl
L2xpbnV4L2RtYS1kaXJlY3QuaCAgICAgICAgIHwgICAgMQo+ICAgaW5jbHVkZS9saW51eC9kbWEt
bWFwcGluZy5oICAgICAgICB8ICAgIDUgKysrCj4gICBpbmNsdWRlL25ldC94c2tfYnVmZl9wb29s
LmggICAgICAgIHwgICAgNiArKy0tCj4gICBrZXJuZWwvZG1hL2RpcmVjdC5jICAgICAgICAgICAg
ICAgIHwgICAgNiArKysrCj4gICBrZXJuZWwvZG1hL21hcHBpbmcuYyAgICAgICAgICAgICAgIHwg
ICAxMCArKysrKysKPiAgIG5ldC94ZHAveHNrX2J1ZmZfcG9vbC5jICAgICAgICAgICAgfCAgIDU0
ICsrLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KPiAgIDcgZmlsZXMgY2hhbmdl
ZCwgMzcgaW5zZXJ0aW9ucygrKSwgNTMgZGVsZXRpb25zKC0pCj4gCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBs
aXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5v
cmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
