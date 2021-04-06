Return-Path: <SRS0=NW7i=JD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_RED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7525C433B4
	for <iommu@archiver.kernel.org>; Tue,  6 Apr 2021 06:57:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E9266117A
	for <iommu@archiver.kernel.org>; Tue,  6 Apr 2021 06:57:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E9266117A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0514C60A6B;
	Tue,  6 Apr 2021 06:57:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 65hhHz7JKSpw; Tue,  6 Apr 2021 06:57:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id 137ED606F7;
	Tue,  6 Apr 2021 06:57:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EB86DC000C;
	Tue,  6 Apr 2021 06:57:08 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D0165C000A
 for <iommu@lists.linux-foundation.org>; Tue,  6 Apr 2021 06:57:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BD5FF40E56
 for <iommu@lists.linux-foundation.org>; Tue,  6 Apr 2021 06:57:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qrwyEUu_ZzyP for <iommu@lists.linux-foundation.org>;
 Tue,  6 Apr 2021 06:57:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3642D40E50
 for <iommu@lists.linux-foundation.org>; Tue,  6 Apr 2021 06:57:05 +0000 (UTC)
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
 by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4FDyvl3gPFzjYJd;
 Tue,  6 Apr 2021 14:55:15 +0800 (CST)
Received: from [127.0.0.1] (10.40.193.166) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.498.0; Tue, 6 Apr 2021
 14:56:54 +0800
Subject: Re: [PATCH] iommu: Add device name to iommu map/unmap trace events
To: Joerg Roedel <joro@8bytes.org>, Sai Prakash Ranjan
 <saiprakash.ranjan@codeaurora.org>
References: <20210209123620.19993-1-saiprakash.ranjan@codeaurora.org>
 <20210212105039.GG7302@8bytes.org>
From: "chenxiang (M)" <chenxiang66@hisilicon.com>
Message-ID: <626fbcb8-b84f-1522-4ec3-9c7c1f5f7a93@hisilicon.com>
Date: Tue, 6 Apr 2021 14:56:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20210212105039.GG7302@8bytes.org>
X-Originating-IP: [10.40.193.166]
X-CFilter-Loop: Reflected
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxarm@huawei.com, iommu@lists.linux-foundation.org,
 Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org, Robin
 Murphy <robin.murphy@arm.com>
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

SGksCgoK5ZyoIDIwMjEvMi8xMiAxODo1MCwgSm9lcmcgUm9lZGVsIOWGmemBkzoKPiBPbiBUdWUs
IEZlYiAwOSwgMjAyMSBhdCAwNjowNjoyMFBNICswNTMwLCBTYWkgUHJha2FzaCBSYW5qYW4gd3Jv
dGU6Cj4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L2lvbW11LmggYi9pbmNsdWRlL2xpbnV4
L2lvbW11LmgKPj4gaW5kZXggNWU3ZmU1MTk0MzBhLi42MDY0MTg3ZDliYjYgMTAwNjQ0Cj4+IC0t
LSBhL2luY2x1ZGUvbGludXgvaW9tbXUuaAo+PiArKysgYi9pbmNsdWRlL2xpbnV4L2lvbW11LmgK
Pj4gQEAgLTg3LDYgKzg3LDcgQEAgc3RydWN0IGlvbW11X2RvbWFpbiB7Cj4+ICAgCXZvaWQgKmhh
bmRsZXJfdG9rZW47Cj4+ICAgCXN0cnVjdCBpb21tdV9kb21haW5fZ2VvbWV0cnkgZ2VvbWV0cnk7
Cj4+ICAgCXZvaWQgKmlvdmFfY29va2llOwo+PiArCWNoYXIgZGV2X25hbWVbMzJdOwo+PiAgIH07
Cj4gTm8sIGRlZmluaXRseSBub3QuIEEgZG9tYWluIGlzIGEgZGV2aWNlIERNQSBhZGRyZXNzIHNw
YWNlIHdoaWNoIGNhbiBiZQo+IHVzZWQgYnkgbW9yZSB0aGFuIG9uZSBkZXZpY2UuIEp1c3QgbG9v
ayBhdCBJT01NVSBncm91cHMgd2l0aCBtb3JlIHRoYW4KPiBvbmUgbWVtYmVyIGRldmljZSwgaW4g
dGhpcyBjYXNlIGp1c3Qgb25lIGRldmljZSBuYW1lIHdvdWxkIGJlIHZlcnkKPiBtaXNsZWFkaW5n
LgoKSXMgaXQgcG9zc2libGUgdG8gdXNlIGdyb3VwIGlkIHRvIGlkZW50aWZ5IGRpZmZlcmVudCBk
b21haW5zPwoKCj4KPiBSZWdhcmRzLAo+Cj4gCUpvZXJnCj4gX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KPiBpb21tdSBtYWlsaW5nIGxpc3QKPiBpb21tdUBs
aXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwo+IGh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9u
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11Cj4KPiAuCj4KCgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlz
dHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3Jn
L21haWxtYW4vbGlzdGluZm8vaW9tbXU=
