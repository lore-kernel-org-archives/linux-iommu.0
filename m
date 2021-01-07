Return-Path: <SRS0=iLvA=GK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4947BC433DB
	for <iommu@archiver.kernel.org>; Thu,  7 Jan 2021 09:15:08 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C438D2312E
	for <iommu@archiver.kernel.org>; Thu,  7 Jan 2021 09:15:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C438D2312E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 721738670C;
	Thu,  7 Jan 2021 09:15:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TVkOH-60qEUI; Thu,  7 Jan 2021 09:15:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 6BABF86A16;
	Thu,  7 Jan 2021 09:15:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3F8F9C0891;
	Thu,  7 Jan 2021 09:15:06 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5CE40C013A
 for <iommu@lists.linux-foundation.org>; Thu,  7 Jan 2021 09:15:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 3EC8687409
 for <iommu@lists.linux-foundation.org>; Thu,  7 Jan 2021 09:15:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KleQ2gWb8sK9 for <iommu@lists.linux-foundation.org>;
 Thu,  7 Jan 2021 09:15:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by hemlock.osuosl.org (Postfix) with ESMTPS id E5F4C8740B
 for <iommu@lists.linux-foundation.org>; Thu,  7 Jan 2021 09:15:01 +0000 (UTC)
Received: from fraeml712-chm.china.huawei.com (unknown [172.18.147.206])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DBL6S2gcbz67Y31;
 Thu,  7 Jan 2021 17:10:08 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml712-chm.china.huawei.com (10.206.15.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 7 Jan 2021 10:14:57 +0100
Received: from [10.47.3.231] (10.47.3.231) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2106.2; Thu, 7 Jan 2021
 09:14:51 +0000
Subject: Re: [PATCH v2 6/6] iommu: Delete iommu_dev_has_feature()
To: Lu Baolu <baolu.lu@linux.intel.com>, <joro@8bytes.org>, <will@kernel.org>
References: <1609940111-28563-1-git-send-email-john.garry@huawei.com>
 <1609940111-28563-7-git-send-email-john.garry@huawei.com>
 <f05ee600-705a-0c94-2a12-78eb8538234b@linux.intel.com>
From: John Garry <john.garry@huawei.com>
Message-ID: <b31e8a41-3918-6b69-05af-45084e08bb7f@huawei.com>
Date: Thu, 7 Jan 2021 09:13:50 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <f05ee600-705a-0c94-2a12-78eb8538234b@linux.intel.com>
Content-Language: en-US
X-Originating-IP: [10.47.3.231]
X-ClientProxiedBy: lhreml704-chm.china.huawei.com (10.201.108.53) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Cc: iommu@lists.linux-foundation.org, robin.murphy@arm.com,
 linux-kernel@vger.kernel.org
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

T24gMDcvMDEvMjAyMSAwMToxOCwgTHUgQmFvbHUgd3JvdGU6Cj4gT24gMS82LzIxIDk6MzUgUE0s
IEpvaG4gR2Fycnkgd3JvdGU6Cj4+IEZ1bmN0aW9uIGlvbW11X2Rldl9oYXNfZmVhdHVyZSgpIGhh
cyBuZXZlciBiZWVuIHJlZmVyZW5jZWQgaW4gdGhlIHRyZWUsCj4+IGFuZCB0aGVyZSBkb2VzIG5v
dCBhcHBlYXIgdG8gYmUgYW55dGhpbmcgY29taW5nIHNvb24gdG8gdXNlIGl0LCBzbyBkZWxldGUK
Pj4gaXQuCj4gCgpIaSBiYW9sdSwKCj4gSXQgd2lsbCBiZSB1c2VkIGJ5IHRoZSBkZXZpY2UgZHJp
dmVyIHdoaWNoIHdhbnQgdG8gc3VwcG9ydCB0aGUgYXV4LQo+IGRvbWFpbiBjYXBhYmlsaXR5LCBm
b3IgZXhhbXBsZSwgYmVsb3cgc2VyaWVzIGlzIHVuZGVyIGRpc2N1c3Npb24uCj4gCj4gaHR0cHM6
Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtcGNpLzE2MDQwODM1NzkxMi45MTIwNTAuMTcwMDU1ODQ1
MjYyNjYxOTE0MjAuc3RnaXRAZGppYW5nNS1kZXNrMy5jaC5pbnRlbC5jb20vIAo+IAoKU28gSSBk
aWQgY2hlY2sgbGludXgtaW9tbXUgbG9yZSBmb3IgcmVjZW50IHJlZmVyZW5jZXMsIGFib3ZlLCBi
dXQgZGlkIApub3Qgc2VlIHRoaXMgb25lIC0gdGhhdCByZWFsbHkgc2hvdWxkIGhhdmUgY2MnZWQg
bGludXgtaW9tbXUgbGlzdCAod2hpY2ggCml0IGRpZG4ndCkuCgo+IAo+IFRoZSB0eXBpY2FsIHVz
ZSBjYXNlIGlzCj4gCj4gIMKgwqDCoMKgwqDCoMKgIGlmIChpb21tdV9kZXZfaGFzX2ZlYXR1cmUo
ZGV2LCBJT01NVV9ERVZfRkVBVF9BVVgpKSB7Cj4gIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCByYyA9IGlvbW11X2Rldl9lbmFibGVfZmVhdHVyZShkZXYsIElPTU1VX0RFVl9GRUFUX0FV
WCk7Cj4gIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAocmMgPCAwKSB7Cj4gIMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZGV2X3dhcm4oZGV2
LCAiRmFpbGVkIHRvIGVuYWJsZSBhdXgtZG9tYWluOiAKPiAlZFxuIiwgcmMpOwo+ICDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiByYzsKPiAgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIH0KPiAgwqDCoMKgwqDCoMKgwqAgfQo+IAo+IFNv
IHBsZWFzZSBkb24ndCByZW1vdmUgaXQuCj4gCgpvaywgZmluZS4gSXQgYWxzbyBzZWVtcyB0aGF0
IHRoaXMgQVBJIGhhcyBub3QgaGFkIGEgdXNlciBzaW5jZSBpdCB3YXMgCmludHJvZHVjZWQgaW4g
djUuMi4KClRoYW5rcywKSm9obgoKUHMuIEkgc3VwcG9zZSBhIHYzIHNlcmllcyBpcyBub3QgbmVl
ZGVkIEFUTSAtIHRoaXMgcGF0Y2ggY2FuIGp1c3QgYmUgCmRyb3BwZWQuCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21t
dUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlv
bi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
