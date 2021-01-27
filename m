Return-Path: <SRS0=KfvE=G6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC4F1C433DB
	for <iommu@archiver.kernel.org>; Wed, 27 Jan 2021 00:38:00 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D91120679
	for <iommu@archiver.kernel.org>; Wed, 27 Jan 2021 00:38:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D91120679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id C3E5D20511;
	Wed, 27 Jan 2021 00:37:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id W87jSIMBbdDP; Wed, 27 Jan 2021 00:37:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id CF33D204A9;
	Wed, 27 Jan 2021 00:37:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B71B1C0FA7;
	Wed, 27 Jan 2021 00:37:58 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8ABC1C013A
 for <iommu@lists.linux-foundation.org>; Wed, 27 Jan 2021 00:37:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 7EB2D86F7A
 for <iommu@lists.linux-foundation.org>; Wed, 27 Jan 2021 00:37:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VLOLzYmj5Vid for <iommu@lists.linux-foundation.org>;
 Wed, 27 Jan 2021 00:37:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by hemlock.osuosl.org (Postfix) with ESMTPS id B9ABC86F6F
 for <iommu@lists.linux-foundation.org>; Wed, 27 Jan 2021 00:37:56 +0000 (UTC)
IronPort-SDR: sPrydjLGrYF9FZgp28SYfYjZsPypLut6U7lJDiONzaRQ+zWWBDW+LQUpOkvBwBJwPU5DcYAPRw
 +ErVsKxfliqw==
X-IronPort-AV: E=McAfee;i="6000,8403,9876"; a="167666946"
X-IronPort-AV: E=Sophos;i="5.79,378,1602572400"; d="scan'208";a="167666946"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jan 2021 16:37:55 -0800
IronPort-SDR: izRmj+LflD4/Gvd2EAT8bbLibLT/SFc47kq861oWBkgRC5tGr/L+pX9eK9mxfSYa2GZC00ZBBD
 CYNC5ut8RrcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,378,1602572400"; d="scan'208";a="402923270"
Received: from allen-box.sh.intel.com (HELO [10.239.159.128])
 ([10.239.159.128])
 by fmsmga004.fm.intel.com with ESMTP; 26 Jan 2021 16:37:53 -0800
Subject: Re: [PATCH] iommu/vt-d: do not use flush-queue when caching-mode is on
To: Nadav Amit <nadav.amit@gmail.com>, iommu@lists.linux-foundation.org
References: <20210126203856.1544088-1-namit@vmware.com>
 <cf693fca-4f5a-a6a6-cc58-3f4e3cd882b6@linux.intel.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <72cab17b-7b2f-1e4d-3bd5-3041b7edc724@linux.intel.com>
Date: Wed, 27 Jan 2021 08:29:37 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <cf693fca-4f5a-a6a6-cc58-3f4e3cd882b6@linux.intel.com>
Content-Language: en-US
Cc: Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Nadav Amit <namit@vmware.com>,
 David Woodhouse <dwmw2@infradead.org>
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

T24gMS8yNy8yMSA4OjI2IEFNLCBMdSBCYW9sdSB3cm90ZToKPj4gK3sKPj4gK8KgwqDCoCBzdHJ1
Y3QgZG1hcl9kb21haW4gKmRtYXJfZG9tYWluID0gdG9fZG1hcl9kb21haW4oZG9tYWluKTsKPj4g
K8KgwqDCoCBzdHJ1Y3QgaW50ZWxfaW9tbXUgKmlvbW11ID0gZG9tYWluX2dldF9pb21tdShkbWFy
X2RvbWFpbik7Cj4+ICsKPj4gK8KgwqDCoCBpZiAoaW50ZWxfaW9tbXVfc3RyaWN0KQo+PiArwqDC
oMKgwqDCoMKgwqAgcmV0dXJuIDA7Cj4+ICsKPj4gK8KgwqDCoCAvKgo+PiArwqDCoMKgwqAgKiBU
aGUgZmx1c2ggcXVldWUgaW1wbGVtZW50YXRpb24gZG9lcyBub3QgcGVyZm9ybSBwYWdlLXNlbGVj
dGl2ZQo+PiArwqDCoMKgwqAgKiBpbnZhbGlkYXRpb25zIHRoYXQgYXJlIHJlcXVpcmVkIGZvciBl
ZmZpY2llbnQgVExCIGZsdXNoZXMgaW4gCj4+IHZpcnR1YWwKPj4gK8KgwqDCoMKgICogZW52aXJv
bm1lbnRzLiBUaGUgYmVuZWZpdCBvZiBiYXRjaGluZyBpcyBsaWtlbHkgdG8gYmUgbXVjaCAKPj4g
bG93ZXIgdGhhbgo+PiArwqDCoMKgwqAgKiB0aGUgb3ZlcmhlYWQgb2Ygc3luY2hyb25pemluZyB0
aGUgdmlydHVhbCBhbmQgcGh5c2ljYWwgSU9NTVUKPj4gK8KgwqDCoMKgICogcGFnZS10YWJsZXMu
Cj4+ICvCoMKgwqDCoCAqLwo+PiArwqDCoMKgIGlmIChpb21tdSAmJiBjYXBfY2FjaGluZ19tb2Rl
KGlvbW11LT5jYXApKSB7Cj4+ICvCoMKgwqDCoMKgwqDCoCBwcl93YXJuX29uY2UoIklPTU1VIGJh
dGNoaW5nIGlzIHBhcnRpYWxseSBkaXNhYmxlZCBkdWUgdG8gCj4+IHZpcnR1YWxpemF0aW9uIik7
Cj4+ICvCoMKgwqDCoMKgwqDCoCByZXR1cm4gMDsKPj4gK8KgwqDCoCB9Cj4gCj4gZG9tYWluX2dl
dF9pb21tdSgpIG9ubHkgcmV0dXJucyB0aGUgZmlyc3QgaW9tbXUsIGFuZCBjb3VsZCByZXR1cm4g
TlVMTAo+IHdoZW4gdGhpcyBpcyBjYWxsZWQgYmVmb3JlIGRvbWFpbiBhdHRhY2hpbmcgdG8gYW55
IGRldmljZS4gQSBiZXR0ZXIKPiBjaG9pY2UgY291bGQgYmUgY2hlY2sgY2FjaGluZyBtb2RlIGds
b2JhbGx5IGFuZCByZXR1cm4gZmFsc2UgaWYgY2FjaGluZwo+IG1vZGUgaXMgc3VwcG9ydGVkIG9u
IGFueSBpb21tdS4KPiAKPiAgwqDCoMKgwqDCoMKgIHN0cnVjdCBkbWFyX2RyaGRfdW5pdCAqZHJo
ZDsKPiAgwqDCoMKgwqDCoMKgIHN0cnVjdCBpbnRlbF9pb21tdSAqaW9tbXU7Cj4gCj4gIMKgwqDC
oMKgwqDCoCByY3VfcmVhZF9sb2NrKCk7Cj4gIMKgwqDCoMKgwqDCoCBmb3JfZWFjaF9hY3RpdmVf
aW9tbXUoaW9tbXUsIGRyaGQpIHsKPiAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlm
IChjYXBfY2FjaGluZ19tb2RlKGlvbW11LT5jYXApKQo+ICDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiBmYWxzZTsKCldlIHNob3VsZCB1bmxvY2sg
cmN1IGJlZm9yZSByZXR1cm4gaGVyZS4gU29ycnkhCgo+ICDCoMKgwqDCoMKgwqDCoCB9Cj4gIMKg
wqDCoMKgwqDCoMKgIHJjdV9yZWFkX3VubG9jaygpOwoKQmVzdCByZWdhcmRzLApiYW9sdQpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5n
IGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51
eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
