Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5C8CC433F5
	for <iommu@archiver.kernel.org>; Tue, 17 May 2022 08:21:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 653A660C0B;
	Tue, 17 May 2022 08:21:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id moJlXzFPUxcw; Tue, 17 May 2022 08:21:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 53B3E60ADE;
	Tue, 17 May 2022 08:21:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 29578C0039;
	Tue, 17 May 2022 08:21:30 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CC023C002D
 for <iommu@lists.linux-foundation.org>; Tue, 17 May 2022 08:21:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C09FD400F1
 for <iommu@lists.linux-foundation.org>; Tue, 17 May 2022 08:21:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WBm7eD8vFAEv for <iommu@lists.linux-foundation.org>;
 Tue, 17 May 2022 08:21:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7EBFE400B8
 for <iommu@lists.linux-foundation.org>; Tue, 17 May 2022 08:21:26 +0000 (UTC)
Received: from fraeml736-chm.china.huawei.com (unknown [172.18.147.226])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4L2TXG147Gz67x9g;
 Tue, 17 May 2022 16:18:22 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml736-chm.china.huawei.com (10.206.15.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 17 May 2022 10:21:22 +0200
Received: from [10.47.88.19] (10.47.88.19) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 17 May
 2022 09:21:21 +0100
Message-ID: <f1e5309d-d330-faf1-32c5-78962b125f66@huawei.com>
Date: Tue, 17 May 2022 09:21:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v8 2/8] hwtracing: hisi_ptt: Add trace function support
 for HiSilicon PCIe Tune and Trace device
To: Yicong Yang <yangyicong@huawei.com>, Yicong Yang
 <yangyicong@hisilicon.com>, <gregkh@linuxfoundation.org>,
 <alexander.shishkin@linux.intel.com>, <leo.yan@linaro.org>,
 <james.clark@arm.com>, <will@kernel.org>, <robin.murphy@arm.com>,
 <acme@kernel.org>, <jonathan.cameron@huawei.com>
References: <20220516125223.32012-1-yangyicong@hisilicon.com>
 <20220516125223.32012-3-yangyicong@hisilicon.com>
 <90aafbc1-b7f6-1cc9-8f94-c72f05150f70@huawei.com>
 <31113797-29c5-1400-f7ac-bff79853b3fe@huawei.com>
In-Reply-To: <31113797-29c5-1400-f7ac-bff79853b3fe@huawei.com>
X-Originating-IP: [10.47.88.19]
X-ClientProxiedBy: lhreml743-chm.china.huawei.com (10.201.108.193) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Cc: mark.rutland@arm.com, zhangshaokun@hisilicon.com, prime.zeng@huawei.com,
 mathieu.poirier@linaro.org, suzuki.poulose@arm.com, peterz@infradead.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linuxarm@huawei.com,
 linux-perf-users@vger.kernel.org, iommu@lists.linux-foundation.org,
 mingo@redhat.com, helgaas@kernel.org, liuqi115@huawei.com,
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
From: John Garry via iommu <iommu@lists.linux-foundation.org>
Reply-To: John Garry <john.garry@huawei.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

T24gMTcvMDUvMjAyMiAwOTowOSwgWWljb25nIFlhbmcgd3JvdGU6Cj4+PiArwqDCoMKgIHRhcmdl
dCA9IGNwdW1hc2tfYW55KGNwdW1hc2tfb2Zfbm9kZShkZXZfdG9fbm9kZSgmaGlzaV9wdHQtPnBk
ZXYtPmRldikpKTsKPj4+ICvCoMKgwqAgaWYgKHRhcmdldCA8IG5yX2NwdW1hc2tfYml0cykgewo+
PiB0aGUgY29tbWVudCBmb3IgY3B1bWFza19hbnkoKSBoaW50cyB0byBjaGVjayBhZ2FpbnN0IG5y
X2NwdV9pZHMgLSBhbnkgc3BlY2lmaWMgcmVhc29uIHRvIGNoZWNrIGFnYWluc3QgbnJfY3B1bWFz
a19iaXRzPwo+Pgo+IGhlcmUgc2hvdWxkIGJlOgo+IAlpZiAodGFyZ2V0ID49IG5yX2NwdW1hc2tf
Yml0cykgewo+IAo+IHdpbGwgZml4IHRoaXMgdXAuCj4gCgpJIGFtIHN0aWxsIG5vdCBzdXJlIHRo
YXQgdXNpbmcgbnJfY3B1bWFza19iaXRzIGlzIGNvcnJlY3QuCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0
cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcv
bWFpbG1hbi9saXN0aW5mby9pb21tdQ==
