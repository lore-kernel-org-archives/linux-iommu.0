Return-Path: <SRS0=UGJ5=K3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_NONE,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91103C47092
	for <iommu@archiver.kernel.org>; Tue,  1 Jun 2021 15:51:39 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE47B613AD
	for <iommu@archiver.kernel.org>; Tue,  1 Jun 2021 15:51:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE47B613AD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8F90C40288;
	Tue,  1 Jun 2021 15:51:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id p9KBBcAbyySV; Tue,  1 Jun 2021 15:51:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8395C400F4;
	Tue,  1 Jun 2021 15:51:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 67F2EC000E;
	Tue,  1 Jun 2021 15:51:37 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 75054C0001
 for <iommu@lists.linux-foundation.org>; Tue,  1 Jun 2021 15:51:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 50C2640410
 for <iommu@lists.linux-foundation.org>; Tue,  1 Jun 2021 15:51:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id l0YKXGeSjRPp for <iommu@lists.linux-foundation.org>;
 Tue,  1 Jun 2021 15:51:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6D43840407
 for <iommu@lists.linux-foundation.org>; Tue,  1 Jun 2021 15:51:34 +0000 (UTC)
Received: from fraeml735-chm.china.huawei.com (unknown [172.18.147.226])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Fvc195RKCz6Q3Df;
 Tue,  1 Jun 2021 23:45:01 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml735-chm.china.huawei.com (10.206.15.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 1 Jun 2021 17:51:31 +0200
Received: from [10.47.91.52] (10.47.91.52) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Tue, 1 Jun 2021
 16:51:30 +0100
Subject: Re: [PATCH] iommu: Print default strict or lazy mode at init time
To: Robin Murphy <robin.murphy@arm.com>, <joro@8bytes.org>, <will@kernel.org>
References: <1622209074-37899-1-git-send-email-john.garry@huawei.com>
 <3ee986a0-29c1-100c-c72f-360f919caf7d@arm.com>
From: John Garry <john.garry@huawei.com>
Message-ID: <e478aea8-54d3-bfc6-1bc8-b0c7709e353a@huawei.com>
Date: Tue, 1 Jun 2021 16:50:39 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <3ee986a0-29c1-100c-c72f-360f919caf7d@arm.com>
Content-Language: en-US
X-Originating-IP: [10.47.91.52]
X-ClientProxiedBy: lhreml729-chm.china.huawei.com (10.201.108.80) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, hch@lst.de
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

T24gMDEvMDYvMjAyMSAxMDowOSwgUm9iaW4gTXVycGh5IHdyb3RlOgo+PiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9pb21tdS9pb21tdS5jIGIvZHJpdmVycy9pb21tdS9pb21tdS5jCj4+IGluZGV4IDgw
OGFiNzBkNWRmNS4uZjI1ZmFlNjJmMDc3IDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJzL2lvbW11L2lv
bW11LmMKPj4gKysrIGIvZHJpdmVycy9pb21tdS9pb21tdS5jCj4+IEBAIC0xMzgsNiArMTM4LDEx
IEBAIHN0YXRpYyBpbnQgX19pbml0IGlvbW11X3N1YnN5c19pbml0KHZvaWQpCj4+IMKgwqDCoMKg
wqDCoMKgwqDCoCAoaW9tbXVfY21kX2xpbmUgJiBJT01NVV9DTURfTElORV9ETUFfQVBJKSA/Cj4+
IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICIoc2V0IHZpYSBrZXJuZWwgY29tbWFuZCBsaW5l
KSIgOiAiIik7Cj4+ICvCoMKgwqAgcHJfaW5mbygiRGVmYXVsdCBETUEgZG9tYWluIG1vZGU6ICVz
ICVzXG4iLAo+IAo+IE5pdDogSSB0aGluayB0aGlzIG1pZ2h0IGJlIGEgbGl0dGxlIHVuY2xlYXIg
Zm9yIGVuZC11c2VycyAtICpJJ20qIG5vdCAKPiBldmVuIHN1cmUgd2hldGhlciAiRGVmYXVsdCIg
aGVyZSBpcyBtZWFudCB0byByZWZlciB0byB0aGUgbW9kZSBzZXR0aW5nIAo+IGl0c2VsZiBvciB0
byBkZWZhdWx0IGRvbWFpbnMgKG9mIERNQSB0eXBlKS4gTWF5YmUgc29tZXRoaW5nIGxpa2UgIkRN
QSAKPiBkb21haW4gVExCIGludmFsaWRhdGlvbiBwb2xpY3kiPyBDZXJ0YWlubHkgaXQgc2VlbXMg
bGlrZSBhIGdvb2QgaWRlYSB0byAKPiBleHBsaWNpdGx5IG1lbnRpb24gaW52YWxpZGF0aW9uIHRv
IGNvcnJlbGF0ZSB3aXRoIHRoZSBkb2N1bWVudGF0aW9uIG9mIAo+IHRoZSAiaW9tbXUuc3RyaWN0
IiBwYXJhbWV0ZXIuCj4gCj4gQWNrIHRvIHRoZSBnZW5lcmFsIGlkZWEgdGhvdWdoLgoKb2ssIHNv
IEknbGwgZ28gd2l0aCB0aGlzOgoKcHJfaW5mbygiRE1BIGRvbWFpbiBkZWZhdWx0IFRMQiBpbnZh
bGlkYXRpb24gcG9saWN5OiAlcyBtb2RlICVzXG4iLAogICAgICAgICAgICAgICBpb21tdV9kbWFf
c3RyaWN0ID8gInN0cmljdCIgOiAibGF6eSIsCiAgICAgICAgICAgICAgICAoaW9tbXVfY21kX2xp
bmUgJiBJT01NVV9DTURfTElORV9TVFJJQ1QpID8KICAgICAgICAgICAgICAgICAgICAgICAgIihz
ZXQgdmlhIGtlcm5lbCBjb21tYW5kIGxpbmUpIiA6ICIiKTsKCkkgdGhpbmsgaXQncyB3b3J0aCBt
ZW50aW9uaW5nICJkZWZhdWx0IiBzb21ld2hlcmUsIGFzIG5vdCBhbGwgSU9NTVVzIG9yIApkZXZp
Y2VzIHdpbGwgdXNlIGxhenkgbW9kZSBldmVuIGlmIGl0J3MgZGVmYXVsdC4KClRoYW5rcywKSm9o
bgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBt
YWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0
cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
