Return-Path: <SRS0=4OKN=ML=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20942C07E9D
	for <iommu@archiver.kernel.org>; Mon, 19 Jul 2021 10:45:38 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D31D61026
	for <iommu@archiver.kernel.org>; Mon, 19 Jul 2021 10:45:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D31D61026
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 56023607B5;
	Mon, 19 Jul 2021 10:45:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cLw4N3ZTm4AK; Mon, 19 Jul 2021 10:45:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 41761607B9;
	Mon, 19 Jul 2021 10:45:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 071CEC0010;
	Mon, 19 Jul 2021 10:45:35 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id ED615C000E
 for <iommu@lists.linux-foundation.org>; Mon, 19 Jul 2021 10:45:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DBF67401F8
 for <iommu@lists.linux-foundation.org>; Mon, 19 Jul 2021 10:45:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PAkn3VuhCnTc for <iommu@lists.linux-foundation.org>;
 Mon, 19 Jul 2021 10:45:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 03B3B400C7
 for <iommu@lists.linux-foundation.org>; Mon, 19 Jul 2021 10:45:30 +0000 (UTC)
Received: from fraeml744-chm.china.huawei.com (unknown [172.18.147.207])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GSyvD3Y5bz6DHSQ;
 Mon, 19 Jul 2021 18:36:40 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml744-chm.china.huawei.com (10.206.15.225) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 19 Jul 2021 12:45:25 +0200
Received: from [10.47.85.214] (10.47.85.214) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Mon, 19 Jul
 2021 11:45:25 +0100
Subject: Re: [PATCH v4 6/6] dma-iommu: Pass iova len for IOVA domain init
To: Robin Murphy <robin.murphy@arm.com>, Dan Carpenter
 <dan.carpenter@oracle.com>, "kbuild@lists.01.org" <kbuild@lists.01.org>,
 "joro@8bytes.org" <joro@8bytes.org>, "will@kernel.org" <will@kernel.org>,
 "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>
References: <202107150933.iNUojyx8-lkp@intel.com>
 <70faf101-63c9-ef08-78df-9697f6257778@huawei.com>
 <157833d9-e074-125d-1a7c-f9ef4c05b763@arm.com>
From: John Garry <john.garry@huawei.com>
Message-ID: <e6ebd533-e5a1-bb17-4e6b-71ad9df0a10a@huawei.com>
Date: Mon, 19 Jul 2021 11:45:28 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <157833d9-e074-125d-1a7c-f9ef4c05b763@arm.com>
Content-Language: en-US
X-Originating-IP: [10.47.85.214]
X-ClientProxiedBy: lhreml712-chm.china.huawei.com (10.201.108.63) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Cc: "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
 "lkp@intel.com" <lkp@intel.com>, "airlied@linux.ie" <airlied@linux.ie>,
 Linuxarm <linuxarm@huawei.com>, "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
 "daniel@ffwll.ch" <daniel@ffwll.ch>
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

T24gMTkvMDcvMjAyMSAxMDozMiwgUm9iaW4gTXVycGh5IHdyb3RlOgo+Pj4gN2MxYjA1OGM4YjVh
MzEgUm9iaW4gTXVycGh5wqDCoMKgwqDCoMKgwqDCoMKgIDIwMTctMDMtMTbCoCAzOTPCoMKgwqDC
oMKgIGlmICghZGV2KQo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIF5eXl4KPj4+IE9sZCBjb2RlIGhhcyBjaGVja3MgZm9y
IE5VTEwKPj4+Cj4+Cj4+IEkgZG91YnQgdGhhdCBpbiBwcmFjdGljZSB3ZSBuZWVkIHRoaXMgY2hl
Y2suCj4+Cj4+IEZ1bmN0aW9uIGlvbW11X2RtYV9pbml0X2RvbWFpbigpIGlzIG9ubHkgY2FsbGVk
IGJ5IAo+PiBpb21tdV9zZXR1cF9kbWFfb3BzKCkuIEZ1cnRoZXJtb3JlLCBpb21tdV9zZXR1cF9k
bWFfb3BzKCkgY2FsbHMgCj4+IGlvbW11X2dldF9kb21haW5fZm9yX2RldihkZXYpLCB3aGljaCBj
YW5ub3Qgc2FmZWx5IGhhbmRsZSBkZXYgPT0gTlVMTCAKPj4gZm9yIHdoZW4gd2UgY2FsbCBpb21t
dV9kbWFfaW5pdF9kb21haW4oKSB0aGVyZS4gQXMgc3VjaCwgdGhlIGRldiA9PSAKPj4gTlVMTCBj
aGVja3MgaW4gaW9tbXVfZG1hX2luaXRfZG9tYWluKCkgYXJlIGVmZmVjdGl2ZWx5IHJlZHVuZGFu
dC4KPiAKPiBJbmRlZWQsIEkgaGF2ZSBhIHBhdGNoIGZvciB0aGF0IGluIHRoZSBzdGFjayBJJ20g
cHJlcGFyaW5nOgo+IAo+IGh0dHBzOi8vZ2l0bGFiLmFybS5jb20vbGludXgtYXJtL2xpbnV4LXJt
Ly0vY29tbWl0LzliNmNmMmEyMTQxMDdjMTUzZWUyNzhiMTY2NGY2ODg4ODhkNzMyOGYKCkNvb2ws
IHNvIGhvdyBhYm91dCBwbGVhc2UgY2hlY2tpbmcgdGhpcyBzZXJpZXMgd2hlbiB5b3UgZ2V0IGEg
Y2hhbmNlPyAKWW91IGRpZCBzdWdnZXN0IHRoaXMgYXBwcm9hY2ggYWZ0ZXIgYWxsLi4KClRoYW5r
cywKSm9obgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpp
b21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6
Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
