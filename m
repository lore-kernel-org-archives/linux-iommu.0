Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01A75C433F5
	for <iommu@archiver.kernel.org>; Tue, 17 May 2022 09:15:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8B679416F1;
	Tue, 17 May 2022 09:15:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hn7SmVIB4Xur; Tue, 17 May 2022 09:15:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 2D8CC416D9;
	Tue, 17 May 2022 09:15:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F028FC0032;
	Tue, 17 May 2022 09:15:13 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 036F6C002D
 for <iommu@lists.linux-foundation.org>; Tue, 17 May 2022 09:15:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E51FB40521
 for <iommu@lists.linux-foundation.org>; Tue, 17 May 2022 09:15:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6dsMhAUQ0aNZ for <iommu@lists.linux-foundation.org>;
 Tue, 17 May 2022 09:15:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DC1EC400B8
 for <iommu@lists.linux-foundation.org>; Tue, 17 May 2022 09:15:11 +0000 (UTC)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.55])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4L2VmC3KYRzbbmM;
 Tue, 17 May 2022 17:13:47 +0800 (CST)
Received: from [10.67.102.169] (10.67.102.169) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 17 May 2022 17:15:07 +0800
Subject: Re: [PATCH v8 2/8] hwtracing: hisi_ptt: Add trace function support
 for HiSilicon PCIe Tune and Trace device
To: John Garry <john.garry@huawei.com>, Yicong Yang
 <yangyicong@hisilicon.com>, <gregkh@linuxfoundation.org>,
 <alexander.shishkin@linux.intel.com>, <leo.yan@linaro.org>,
 <james.clark@arm.com>, <will@kernel.org>, <robin.murphy@arm.com>,
 <acme@kernel.org>, <jonathan.cameron@huawei.com>
References: <20220516125223.32012-1-yangyicong@hisilicon.com>
 <20220516125223.32012-3-yangyicong@hisilicon.com>
 <90aafbc1-b7f6-1cc9-8f94-c72f05150f70@huawei.com>
 <31113797-29c5-1400-f7ac-bff79853b3fe@huawei.com>
 <f1e5309d-d330-faf1-32c5-78962b125f66@huawei.com>
Message-ID: <53d7db9f-dbd6-c21a-01dd-7316dd541957@huawei.com>
Date: Tue, 17 May 2022 17:15:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <f1e5309d-d330-faf1-32c5-78962b125f66@huawei.com>
X-Originating-IP: [10.67.102.169]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500009.china.huawei.com (7.192.105.203)
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
From: Yicong Yang via iommu <iommu@lists.linux-foundation.org>
Reply-To: Yicong Yang <yangyicong@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

T24gMjAyMi81LzE3IDE2OjIxLCBKb2huIEdhcnJ5IHdyb3RlOgo+IE9uIDE3LzA1LzIwMjIgMDk6
MDksIFlpY29uZyBZYW5nIHdyb3RlOgo+Pj4+ICvCoMKgwqAgdGFyZ2V0ID0gY3B1bWFza19hbnko
Y3B1bWFza19vZl9ub2RlKGRldl90b19ub2RlKCZoaXNpX3B0dC0+cGRldi0+ZGV2KSkpOwo+Pj4+
ICvCoMKgwqAgaWYgKHRhcmdldCA8IG5yX2NwdW1hc2tfYml0cykgewo+Pj4gdGhlIGNvbW1lbnQg
Zm9yIGNwdW1hc2tfYW55KCkgaGludHMgdG8gY2hlY2sgYWdhaW5zdCBucl9jcHVfaWRzIC0gYW55
IHNwZWNpZmljIHJlYXNvbiB0byBjaGVjayBhZ2FpbnN0IG5yX2NwdW1hc2tfYml0cz8KPj4+Cj4+
IGhlcmUgc2hvdWxkIGJlOgo+PiDCoMKgwqDCoGlmICh0YXJnZXQgPj0gbnJfY3B1bWFza19iaXRz
KSB7Cj4+Cj4+IHdpbGwgZml4IHRoaXMgdXAuCj4+Cj4gCj4gSSBhbSBzdGlsbCBub3Qgc3VyZSB0
aGF0IHVzaW5nIG5yX2NwdW1hc2tfYml0cyBpcyBjb3JyZWN0LgoKTGV0J3MgdXNlIG5yX2NwdV9p
ZHMgdG8gbWF0Y2ggdGhlIGNvbW1lbnQgb2YgY3B1bWFza19hbnkoKS4gQWN0dWFsbHkgd2Ugc2hv
dWxkIGhhdmUKbnJfY3B1X2lkcyhwb3NzaWJsZSBjcHVzLCBpbml0IHRvIE5SX0NQVVMpIDw9IG5y
X2NwdW1hc2tfYml0cyAoTlJfQ1BVUykgc28gaXQncyBvayBoZXJlLgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVA
bGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24u
b3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
