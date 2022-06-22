Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABAABC433EF
	for <iommu@archiver.kernel.org>; Wed, 22 Jun 2022 11:57:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0E777418EB;
	Wed, 22 Jun 2022 11:57:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0E777418EB
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=HLlrrVVh
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5XdasGF3j1Xn; Wed, 22 Jun 2022 11:57:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 9EDFA418E9;
	Wed, 22 Jun 2022 11:57:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9EDFA418E9
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4BC81C0032;
	Wed, 22 Jun 2022 11:57:20 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 01ED5C002D
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jun 2022 11:57:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C0E764189E
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jun 2022 11:57:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C0E764189E
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3EAK_t-GsKAU for <iommu@lists.linux-foundation.org>;
 Wed, 22 Jun 2022 11:57:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8C4304188E
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8C4304188E
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jun 2022 11:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1655899037; x=1687435037;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=q2XnILATBKEg2okUGd1tyEzLN3TTBjUfdFRatA/QoRs=;
 b=HLlrrVVh3z1dmXlX0OApLzlm2Ed5cVo0RuZrxVm+zWQ6Rb7edCrxekrl
 SRr5MR9juy2juHdkFhr90DANGyoFMjXwbIoJ4t9hfAMSSbLdJuUVUsT7i
 9OX+GvcaJcGoL23/QC5/jsGTjzTqeov38h2zLuItWBy3yMk+7MmHcOJCp
 S68DYY/jJlDST6nQIibmyndex9gJBMlZPnhJbwgmgrDzbbm4LCXWHmCk1
 kB8WqO43OXeodHMu2XumVf5TZQyHAyQxfYkJK92JLPbnhqw4WAvJE4/oj
 AVWCgYK+PR2knfsDEUI+O8gejINLQ7Z4hYkhX07DjSrxj70Ne+IMuwpDo A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10385"; a="280442793"
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; d="scan'208";a="280442793"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jun 2022 04:57:15 -0700
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; d="scan'208";a="834076732"
Received: from xzhan99-mobl1.ccr.corp.intel.com (HELO [10.249.172.26])
 ([10.249.172.26])
 by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jun 2022 04:57:14 -0700
Message-ID: <3ce651de-f375-176e-3435-735365dd3d8f@linux.intel.com>
Date: Wed, 22 Jun 2022 19:57:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 3/3] iommu: Clean up release_device checks
Content-Language: en-US
To: Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org, will@kernel.org
References: <cover.1655822151.git.robin.murphy@arm.com>
 <02671dbfad7a3343fc25a44222350efcb455fe3c.1655822151.git.robin.murphy@arm.com>
 <59002dbd-d72a-4f9c-7ad8-808ee8d2ff05@linux.intel.com>
 <bc4add1b-8b89-7989-5afb-df6b5338eb3d@arm.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <bc4add1b-8b89-7989-5afb-df6b5338eb3d@arm.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org
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

T24gMjAyMi82LzIyIDE1OjE3LCBSb2JpbiBNdXJwaHkgd3JvdGU6Cj4gT24gMjAyMi0wNi0yMiAw
MjozNiwgQmFvbHUgTHUgd3JvdGU6Cj4+IE9uIDIwMjIvNi8yMSAyMzoxNCwgUm9iaW4gTXVycGh5
IHdyb3RlOgo+Pj4gU2luY2UgLnJlbGVhc2VfZGV2aWNlIGlzIG5vdyBjYWxsZWQgdGhyb3VnaCBw
ZXItZGV2aWNlIG9wcywgYW55IGNhbGwKPj4+IHdoaWNoIGdldHMgYXMgZmFyIGFzIGEgZHJpdmVy
IGRlZmluaXRlbHkqaXMqwqAgZm9yIHRoYXQgZHJpdmVyLCBmb3IgYQo+Pj4gZGV2aWNlIHdoaWNo
IGhhcyBzdWNjZXNzZnVsbHkgcGFzc2VkIC5wcm9iZV9kZXZpY2UsIHNvIGFsbCB0aGUgY2hlY2tz
IHRvCj4+PiB0aGF0IGVmZmVjdCBhcmUgbm93IHJlZHVuZGFudCBhbmQgY2FuIGJlIHJlbW92ZWQu
IEluIHRoZSBzYW1lIHZlaW4gd2UKPj4+IGNhbiBhbHNvIHNraXAgZnJlZWluZyBmd3NwZWNzIHdo
aWNoIGFyZSBub3cgbWFuYWdlZCBieSBjb3JlIGNvZGUuCj4+Cj4+IERvZXMgdGhpcyBkZXBlbmQg
b24gYW55IG90aGVyIHNlcmllcz8gSSBkaWRuJ3Qgc2VlIGlvbW11X2Z3c3BlY19mcmVlKCkKPj4g
Y2FsbGVkIGluIHRoZSBjb3JlIGNvZGUuIE9yIEkgbWlzc2VkIGFueXRoaW5nPwo+IAo+IGRldl9p
b21tdV9mcmVlKCkgY2xlYW5zIHVwIHBhcmFtLT5md3NwZWMgZGlyZWN0bHkgKHNlZSBiNTQyNDBh
ZDQ5NDMpLiAKPiBGV0lXIHRoZSBwbGFuIGlzIHRoYXQgaW9tbXVfZndzcGVjX2ZyZWUoKSBzaG91
bGQgZXZlbnR1YWxseSBnbyBhd2F5IC0gb2YgCj4gdGhlIHJlbWFpbmluZyB1c2VzIGFmdGVyIHRo
aXMsIHR3byBhcmUgaW4gZmFjdCBzaW1pbGFybHkgcmVkdW5kYW50IAo+IGFscmVhZHksIHNpbmNl
IHRoZXJlJ3MgYWxzbyBhIGRldl9pb21tdV9mcmVlKCkgaW4gdGhlIHByb2JlIGZhaWx1cmUgCj4g
cGF0aCwgYW5kIHRoZSBvdGhlciB0d28gc2hvdWxkIGRpc2FwcGVhciBpbiBwYXJ0IDIgb2YgZml4
aW5nIHRoZSBidXMgCj4gcHJvYmluZyBtZXNzICh3aGVyZWluIHRoZSBvZl94bGF0ZSBzdGVwIGdl
dHMgcHVsbGVkIGludG8gCj4gaW9tbXVfcHJvYmVfZGV2aWNlIGFzIHdlbGwsIGFuZCBmaW5hbGx5
IHdvcmtzIGNvcnJlY3RseSBhZ2FpbikuCgpZZXMsIGl0IGlzLiBUaGFua3MgZm9yIHRoZSBleHBs
YW5hdGlvbi4KClJldmlld2VkLWJ5OiBMdSBCYW9sdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29t
PgoKQmVzdCByZWdhcmRzLApiYW9sdQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRh
dGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGlu
Zm8vaW9tbXU=
