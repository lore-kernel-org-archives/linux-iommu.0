Return-Path: <SRS0=fiLh=4U=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69750C3F2C6
	for <iommu@archiver.kernel.org>; Tue,  3 Mar 2020 11:33:21 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 181B720863
	for <iommu@archiver.kernel.org>; Tue,  3 Mar 2020 11:33:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 181B720863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id C88AF86CB6;
	Tue,  3 Mar 2020 11:33:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ohJ7gP7tnYtS; Tue,  3 Mar 2020 11:33:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 6C84C86A98;
	Tue,  3 Mar 2020 11:33:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 47D1AC07FF;
	Tue,  3 Mar 2020 11:33:19 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4FD48C013E
 for <iommu@lists.linux-foundation.org>; Tue,  3 Mar 2020 11:33:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 4B15020443
 for <iommu@lists.linux-foundation.org>; Tue,  3 Mar 2020 11:33:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lPqpR0qH5Pso for <iommu@lists.linux-foundation.org>;
 Tue,  3 Mar 2020 11:33:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from huawei.com (lhrrgout.huawei.com [185.176.76.210])
 by silver.osuosl.org (Postfix) with ESMTPS id 090A8203C9
 for <iommu@lists.linux-foundation.org>; Tue,  3 Mar 2020 11:33:14 +0000 (UTC)
Received: from LHREML714-CAH.china.huawei.com (unknown [172.18.7.106])
 by Forcepoint Email with ESMTP id 57CFC58127DD808F5752;
 Tue,  3 Mar 2020 11:33:12 +0000 (GMT)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 LHREML714-CAH.china.huawei.com (10.201.108.37) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 3 Mar 2020 11:33:11 +0000
Received: from [127.0.0.1] (10.202.226.45) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 3 Mar 2020
 11:33:11 +0000
Subject: Re: [Patch v3 3/3] iommu: avoid taking iova_rbtree_lock twice
To: <joro@8bytes.org>
References: <20191218043951.10534-1-xiyou.wangcong@gmail.com>
 <20191218043951.10534-4-xiyou.wangcong@gmail.com>
 <2ff1002c-28b3-a863-49d2-3eab5b5ea778@arm.com>
From: John Garry <john.garry@huawei.com>
Message-ID: <4b74d40a-22d1-af53-fcb6-5d70183705a8@huawei.com>
Date: Tue, 3 Mar 2020 11:33:10 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <2ff1002c-28b3-a863-49d2-3eab5b5ea778@arm.com>
Content-Language: en-US
X-Originating-IP: [10.202.226.45]
X-ClientProxiedBy: lhreml725-chm.china.huawei.com (10.201.108.76) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Cc: Cong Wang <xiyou.wangcong@gmail.com>, iommu@lists.linux-foundation.org,
 Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org
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

T24gMjEvMDEvMjAyMCAwOTo1NiwgUm9iaW4gTXVycGh5IHdyb3RlOgo+IE9uIDE4LzEyLzIwMTkg
NDozOSBhbSwgQ29uZyBXYW5nIHdyb3RlOgo+PiBCb3RoIGZpbmRfaW92YSgpIGFuZCBfX2ZyZWVf
aW92YSgpIHRha2UgaW92YV9yYnRyZWVfbG9jaywKPj4gdGhlcmUgaXMgbm8gcmVhc29uIHRvIHRh
a2UgYW5kIHJlbGVhc2UgaXQgdHdpY2UgaW5zaWRlCj4+IGZyZWVfaW92YSgpLgo+Pgo+PiBGb2xk
IHRoZW0gaW50byBvbmUgY3JpdGljYWwgc2VjdGlvbiBieSBjYWxsaW5nIHRoZSB1bmxvY2sKPj4g
dmVyc2lvbnMgaW5zdGVhZC4KPiAKPiBNYWtlcyBzZW5zZSB0byBtZS4KPiAKPiBSZXZpZXdlZC1i
eTogUm9iaW4gTXVycGh5IDxyb2Jpbi5tdXJwaHlAYXJtLmNvbT4KClJldmlld2VkLWJ5OiBKb2hu
IEdhcnJ5IDxqb2huLmdhcnJ5QGh1YXdlaS5jb20+CgpDb3VsZCB3ZSBhdCBsZWFzdCBnZXQgdGhp
cyBwYXRjaCBwaWNrZWQgdXA/IEl0IHNob3VsZCBiZSBvayB0byB0YWtlIGluIAppc29sYXRpb24s
IHNpbmNlIHRoZXJlIGlzIHNvbWUgZGViYXRlIG9uIHRoZSBvdGhlciAyIHBhdGNoZXMgaW4gdGhp
cyAKc2VyaWVzLiBUaGFua3MKCj4gCj4+IENjOiBKb2VyZyBSb2VkZWwgPGpvcm9AOGJ5dGVzLm9y
Zz4KPj4gQ2M6IEpvaG4gR2FycnkgPGpvaG4uZ2FycnlAaHVhd2VpLmNvbT4KPj4gU2lnbmVkLW9m
Zi1ieTogQ29uZyBXYW5nIDx4aXlvdS53YW5nY29uZ0BnbWFpbC5jb20+Cj4+IC0tLQo+PiDCoCBk
cml2ZXJzL2lvbW11L2lvdmEuYyB8IDggKysrKysrLS0KPj4gwqAgMSBmaWxlIGNoYW5nZWQsIDYg
aW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKPj4KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
aW9tbXUvaW92YS5jIGIvZHJpdmVycy9pb21tdS9pb3ZhLmMKPj4gaW5kZXggMTg0ZDRjMGUyMGI1
Li5mNDZmOGY3OTQ2NzggMTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMvaW9tbXUvaW92YS5jCj4+ICsr
KyBiL2RyaXZlcnMvaW9tbXUvaW92YS5jCj4+IEBAIC0zOTAsMTAgKzM5MCwxNCBAQCBFWFBPUlRf
U1lNQk9MX0dQTChfX2ZyZWVfaW92YSk7Cj4+IMKgIHZvaWQKPj4gwqAgZnJlZV9pb3ZhKHN0cnVj
dCBpb3ZhX2RvbWFpbiAqaW92YWQsIHVuc2lnbmVkIGxvbmcgcGZuKQo+PiDCoCB7Cj4+IC3CoMKg
wqAgc3RydWN0IGlvdmEgKmlvdmEgPSBmaW5kX2lvdmEoaW92YWQsIHBmbik7Cj4+ICvCoMKgwqAg
dW5zaWduZWQgbG9uZyBmbGFnczsKPj4gK8KgwqDCoCBzdHJ1Y3QgaW92YSAqaW92YTsKPj4gK8Kg
wqDCoCBzcGluX2xvY2tfaXJxc2F2ZSgmaW92YWQtPmlvdmFfcmJ0cmVlX2xvY2ssIGZsYWdzKTsK
Pj4gK8KgwqDCoCBpb3ZhID0gcHJpdmF0ZV9maW5kX2lvdmEoaW92YWQsIHBmbik7Cj4+IMKgwqDC
oMKgwqAgaWYgKGlvdmEpCj4+IC3CoMKgwqDCoMKgwqDCoCBfX2ZyZWVfaW92YShpb3ZhZCwgaW92
YSk7Cj4+ICvCoMKgwqDCoMKgwqDCoCBwcml2YXRlX2ZyZWVfaW92YShpb3ZhZCwgaW92YSk7Cj4+
ICvCoMKgwqAgc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmaW92YWQtPmlvdmFfcmJ0cmVlX2xvY2ss
IGZsYWdzKTsKPj4gwqAgfQo+PiDCoCBFWFBPUlRfU1lNQk9MX0dQTChmcmVlX2lvdmEpOwo+Pgo+
IC4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11
IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xp
c3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
