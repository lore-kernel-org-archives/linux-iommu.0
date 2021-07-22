Return-Path: <SRS0=8SnF=MO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3D2AC63793
	for <iommu@archiver.kernel.org>; Thu, 22 Jul 2021 13:55:01 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EF9C6128D
	for <iommu@archiver.kernel.org>; Thu, 22 Jul 2021 13:55:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EF9C6128D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EB00883267;
	Thu, 22 Jul 2021 13:55:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YLMxzzkWq3IZ; Thu, 22 Jul 2021 13:55:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id CD843831C1;
	Thu, 22 Jul 2021 13:54:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9B9D1C0010;
	Thu, 22 Jul 2021 13:54:59 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6B232C000E
 for <iommu@lists.linux-foundation.org>; Thu, 22 Jul 2021 13:54:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4619160676
 for <iommu@lists.linux-foundation.org>; Thu, 22 Jul 2021 13:54:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DiLkv2ce3NkX for <iommu@lists.linux-foundation.org>;
 Thu, 22 Jul 2021 13:54:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7888E6067F
 for <iommu@lists.linux-foundation.org>; Thu, 22 Jul 2021 13:54:54 +0000 (UTC)
Received: from fraeml701-chm.china.huawei.com (unknown [172.18.147.207])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GVtyD4mF5z6DHHy;
 Thu, 22 Jul 2021 21:45:56 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml701-chm.china.huawei.com (10.206.15.50) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Thu, 22 Jul 2021 15:54:51 +0200
Received: from [10.47.26.161] (10.47.26.161) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2176.2; Thu, 22 Jul
 2021 14:54:51 +0100
Subject: Re: [bug report] iommu_dma_unmap_sg() is very slow then running IO
 from remote numa node
To: Marc Zyngier <maz@kernel.org>
References: <YOgK8fdv7dOQtkET@T590>
 <23e7956b-f3b5-b585-3c18-724165994051@arm.com> <YOhcOv1oOwm6fco+@T590>
 <ad5bc549-d83f-bee0-9a9f-03a5afd7f3d9@huawei.com> <YPd7IGFZrsTRfUxE@T590>
 <74537f9c-af5f-cd84-60ab-49ca6220310e@huawei.com> <YPfwAN1onpSKoeBj@T590>
 <a2650064-41cf-cb62-7ab4-d14ef1856966@huawei.com> <YPklDMng1hL3bQ+v@T590>
 <9c929985-4fcb-e65d-0265-34c820b770ea@huawei.com> <YPlGOOMSdm6Bcyy/@T590>
 <fc552129-e89d-74ad-9e57-30e3ffe4cf5d@huawei.com>
 <411dfc7cd330df1f681137d77e846b78@misterjones.org>
From: John Garry <john.garry@huawei.com>
Message-ID: <d975276a-5889-7bbd-5329-287ae661f04b@huawei.com>
Date: Thu, 22 Jul 2021 14:54:44 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <411dfc7cd330df1f681137d77e846b78@misterjones.org>
Content-Language: en-US
X-Originating-IP: [10.47.26.161]
X-ClientProxiedBy: lhreml706-chm.china.huawei.com (10.201.108.55) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Cc: Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, Ming Lei <ming.lei@redhat.com>,
 iommu@lists.linux-foundation.org, Will Deacon <will@kernel.org>,
 linux-arm-kernel@lists.infradead.org
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

T24gMjIvMDcvMjAyMSAxMzo1MywgTWFyYyBaeW5naWVyIHdyb3RlOgo+IEhpIEpvaG4sCj4gCj4g
Wy4uLl0KPiAKPj4gwqDCoMKgIFlvdXIga2VybmVsIGxvZyBzaG91bGQgc2hvdzoKPj4gwqDCoMKg
IFvCoMKgwqAgMC4wMDAwMDBdIEdJQ3YzOiBQc2V1ZG8tTk1JcyBlbmFibGVkIHVzaW5nIGZvcmNl
ZCBJQ0NfUE1SX0VMMQo+PiBzeW5jaHJvbmlzYXRpb24KPiAKPiBVbnJlbGF0ZWQsIGJ1dCB5b3Ug
c2VlbSB0byBiZSBydW5uaW5nIHdpdGggSUNDX0NUTFJfRUwzLlBNSEUgc2V0LAo+IHdoaWNoIG1h
a2VzIHRoZSBvdmVyaGVhZCBvZiBwc2V1ZG8tTk1JcyBtdWNoIGhpZ2hlciB0aGFuIGl0IHNob3Vs
ZCBiZQo+ICh5b3UgdGFrZSBhIERTQiBTWSBvbiBlYWNoIGludGVycnVwdCB1bm1hc2tpbmcpLgo+
IAo+IElmIHlvdSBhcmUgbm90IHVzaW5nIDE6TiBkaXN0cmlidXRpb24gb2YgU1BJcyBvbiB0aGUg
c2VjdXJlIHNpZGUsCj4gY29uc2lkZXIgdHVybmluZyB0aGF0IG9mZiBpbiB5b3VyIGZpcm13YXJl
LiBUaGlzIHNob3VsZCBtYWtlIE5NSXMKPiBzbGlnaHRseSBtb3JlIHBsZWFzYW50IHRvIHVzZS4K
ClRoYW5rcyBmb3IgdGhlIGhpbnQuIEkgc3BlYWsgdG8gdGhlIEJJT1MgZ3V5cy4KCkpvaG4KX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGlu
ZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGlu
dXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
