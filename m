Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C66F9C433EF
	for <iommu@archiver.kernel.org>; Thu, 14 Apr 2022 12:59:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7A2F741513;
	Thu, 14 Apr 2022 12:59:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ifzmM-ZBicyk; Thu, 14 Apr 2022 12:59:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 33B4040946;
	Thu, 14 Apr 2022 12:59:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 05CFDC0033;
	Thu, 14 Apr 2022 12:59:14 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1FC27C002C
 for <iommu@lists.linux-foundation.org>; Thu, 14 Apr 2022 12:59:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id EDF6D60E13
 for <iommu@lists.linux-foundation.org>; Thu, 14 Apr 2022 12:59:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yRqfZm-CZB1d for <iommu@lists.linux-foundation.org>;
 Thu, 14 Apr 2022 12:59:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0D7B960AC0
 for <iommu@lists.linux-foundation.org>; Thu, 14 Apr 2022 12:59:10 +0000 (UTC)
Received: from fraeml704-chm.china.huawei.com (unknown [172.18.147.206])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KfKGs19YDz688j4;
 Thu, 14 Apr 2022 20:56:53 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml704-chm.china.huawei.com (10.206.15.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.24; Thu, 14 Apr 2022 14:59:06 +0200
Received: from [10.47.27.241] (10.47.27.241) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 14 Apr
 2022 13:59:05 +0100
Message-ID: <40f03ea6-1690-8a6f-2969-24c47f39c215@huawei.com>
Date: Thu, 14 Apr 2022 14:00:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v7 5/7] perf tool: Add support for HiSilicon PCIe Tune and
 Trace device driver
To: Yicong Yang <yangyicong@huawei.com>, Yicong Yang
 <yangyicong@hisilicon.com>, <gregkh@linuxfoundation.org>,
 <helgaas@kernel.org>, <alexander.shishkin@linux.intel.com>,
 <lorenzo.pieralisi@arm.com>, <will@kernel.org>, <mark.rutland@arm.com>,
 <mathieu.poirier@linaro.org>, <suzuki.poulose@arm.com>,
 <mike.leach@linaro.org>, <leo.yan@linaro.org>, <jonathan.cameron@huawei.com>, 
 <daniel.thompson@linaro.org>, <joro@8bytes.org>,
 <shameerali.kolothum.thodi@huawei.com>, <robin.murphy@arm.com>,
 <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <coresight@lists.linaro.org>, <linux-pci@vger.kernel.org>,
 <linux-perf-users@vger.kernel.org>, <iommu@lists.linux-foundation.org>
References: <20220407125841.3678-1-yangyicong@hisilicon.com>
 <20220407125841.3678-6-yangyicong@hisilicon.com>
 <276c24d2-daf5-5eba-26b9-55edd4a45537@huawei.com>
 <e2b7484b-eb15-029c-b1e1-4831368f61c9@huawei.com>
In-Reply-To: <e2b7484b-eb15-029c-b1e1-4831368f61c9@huawei.com>
X-Originating-IP: [10.47.27.241]
X-ClientProxiedBy: lhreml714-chm.china.huawei.com (10.201.108.65) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Cc: zhangshaokun@hisilicon.com, liuqi115@huawei.com, linuxarm@huawei.com,
 prime.zeng@huawei.com
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
From: John Garry via iommu <iommu@lists.linux-foundation.org>
Reply-To: John Garry <john.garry@huawei.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

T24gMTIvMDQvMjAyMiAwODo0MSwgWWljb25nIFlhbmcgd3JvdGU6Cj4+PiArwqDCoMKgIGhpc2lf
cHR0X3BtdXMgPSB6YWxsb2Moc2l6ZW9mKHN0cnVjdCBwZXJmX3BtdSAqKSAqICgqbnJfcHR0cykp
Owo+Pj4gK8KgwqDCoCBpZiAoIWhpc2lfcHR0X3BtdXMpIHsKPj4+ICvCoMKgwqDCoMKgwqDCoCBw
cl9lcnIoImhpc2lfcHR0IGFsbG9jIGZhaWxlZFxuIik7Cj4+PiArwqDCoMKgwqDCoMKgwqAgKmVy
ciA9IC1FTk9NRU07Cj4+IHVzaW5nIFBUUl9FUlIgc2VlbXMgYmV0dGVyLCBpZiBwb3NzaWJsZQo+
Pgo+IG9rIHdpbGwgY2hhbmdlIHRvIHRoYXQuICplcnIgPSAtRU5PTUVNIGlzIHVzZWQgaGVyZSB0
byBrZWVwIGNvbnNpc3RlbmNlIHdpdGgKPiB3aGF0IHNwZSBkb2VzLgo+IAoKQWgsIEkgc2VlIHRo
YXQgd2UgYXJlIGNvbnRyYWluZWQgYnkgdGhlIGludGVyZmFjZSBvZiAKYXV4dHJhY2VfcmVjb3Jk
X2luaXQoKSB0byBwYXNzIGVyciBhcyBhIHBvaW50ZXIsIHNvIEkgc3VwcG9zZSB0aGUgY29kZSAK
aW4gdGhpcyBwYXRjaCBpcyBvayB0byBmaXQgaW50byB0aGF0LgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlz
dHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3Jn
L21haWxtYW4vbGlzdGluZm8vaW9tbXU=
