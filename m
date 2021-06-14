Return-Path: <SRS0=DplC=LI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C55EDC2B9F4
	for <iommu@archiver.kernel.org>; Mon, 14 Jun 2021 14:26:10 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76CA9611C0
	for <iommu@archiver.kernel.org>; Mon, 14 Jun 2021 14:26:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76CA9611C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3F28E83AA8;
	Mon, 14 Jun 2021 14:26:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Oq0u48MR3RlL; Mon, 14 Jun 2021 14:26:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id A6A2483AA7;
	Mon, 14 Jun 2021 14:26:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7CFFAC000E;
	Mon, 14 Jun 2021 14:26:08 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 803CFC000B
 for <iommu@lists.linux-foundation.org>; Mon, 14 Jun 2021 14:26:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6137D402F3
 for <iommu@lists.linux-foundation.org>; Mon, 14 Jun 2021 14:26:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id enxsMxn8d_XB for <iommu@lists.linux-foundation.org>;
 Mon, 14 Jun 2021 14:26:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2AD5240131
 for <iommu@lists.linux-foundation.org>; Mon, 14 Jun 2021 14:26:04 +0000 (UTC)
Received: from fraeml703-chm.china.huawei.com (unknown [172.18.147.207])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4G3YV2003Vz6G7Mx;
 Mon, 14 Jun 2021 22:19:05 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml703-chm.china.huawei.com (10.206.15.52) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Mon, 14 Jun 2021 16:26:01 +0200
Received: from [10.47.95.26] (10.47.95.26) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Mon, 14 Jun
 2021 15:26:01 +0100
Subject: Re: [PATCH v12 3/5] iommu/vt-d: Add support for IOMMU default DMA
 mode build options
To: Robin Murphy <robin.murphy@arm.com>, Lu Baolu <baolu.lu@linux.intel.com>, 
 "joro@8bytes.org" <joro@8bytes.org>, "will@kernel.org" <will@kernel.org>, 
 "dwmw2@infradead.org" <dwmw2@infradead.org>
References: <1623414043-40745-1-git-send-email-john.garry@huawei.com>
 <1623414043-40745-4-git-send-email-john.garry@huawei.com>
 <4f2cec34-bad9-e1bf-85c1-04d1a0c1aecf@linux.intel.com>
 <6055cd0d-a1d3-a73a-6831-3837021f3c9c@huawei.com>
 <0a04f964-80f4-7b2a-9740-eae4596e4e09@arm.com>
From: John Garry <john.garry@huawei.com>
Message-ID: <453a4606-099c-3d06-13fd-dc29c24230f5@huawei.com>
Date: Mon, 14 Jun 2021 15:19:57 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <0a04f964-80f4-7b2a-9740-eae4596e4e09@arm.com>
Content-Language: en-US
X-Originating-IP: [10.47.95.26]
X-ClientProxiedBy: lhreml725-chm.china.huawei.com (10.201.108.76) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Linuxarm <linuxarm@huawei.com>
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

T24gMTQvMDYvMjAyMSAxNToxMSwgUm9iaW4gTXVycGh5IHdyb3RlOgo+IE9uIDIwMjEtMDYtMTQg
MDg6NTMsIEpvaG4gR2Fycnkgd3JvdGU6Cj4+IE9uIDEyLzA2LzIwMjEgMDM6MjIsIEx1IEJhb2x1
IHdyb3RlOgo+Pj4gT24gMjAyMS82LzExIDIwOjIwLCBKb2huIEdhcnJ5IHdyb3RlOgo+Pj4+IEBA
IC00NTMsOCArNDUyLDcgQEAgc3RhdGljIGludCBfX2luaXQgaW50ZWxfaW9tbXVfc2V0dXAoY2hh
ciAqc3RyKQo+Pj4+ICDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBwcl93YXJuKCJpbnRlbF9p
b21tdT1mb3JjZWRhYyBkZXByZWNhdGVkOyB1c2UKPj4+PiBpb21tdS5mb3JjZWRhYyBpbnN0ZWFk
XG4iKTsKPj4+PiAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaW9tbXVfZG1hX2ZvcmNlZGFj
ID0gdHJ1ZTsKPj4+PiAgwqDCoMKgwqDCoMKgwqDCoMKgIH0gZWxzZSBpZiAoIXN0cm5jbXAoc3Ry
LCAic3RyaWN0IiwgNikpIHsKPj4+PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBwcl9pbmZvKCJE
aXNhYmxlIGJhdGNoZWQgSU9UTEIgZmx1c2hcbiIpOwo+Pj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIGludGVsX2lvbW11X3N0cmljdCA9IDE7Cj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
aW9tbXVfc2V0X2RtYV9zdHJpY3QodHJ1ZSk7Cj4+PiBJIHdvdWxkIGxpa2UgdG8gZGVwcmVjYXRl
IHRoaXMgY29tbWFuZCBsaW5lIGFuZCBhc2sgdXNlcnMgdG8gdXNlCj4+PiBpb21tdS5zdHJpY3Qg
aW5zdGVhZC4KPj4gb2ssIGJ1dCB0aGVuIEkgc2hvdWxkIHByb2JhYmx5IG1ha2UgdGhlIEFNRCBk
cml2ZXIgYWxzbyBvZmZpY2lhbGx5Cj4+IHN1cHBvcnQgdGhpcy4KPiBPb3BzLCBJIHNob3VsZCBo
YXZlIGRvY3VtZW50ZWQgdGhhdCAiaW9tbXUuc3RyaWN0IiBhbHJlYWR5IGFwcGxpZXMgdG8KPiB4
ODYgYXMgd2VsbC4gVGhlIGludGVyYWN0aW9uIHdpdGggdGhlIGRyaXZlci1zcGVjaWZpYyBwYXJh
bWV0ZXJzIGlzIGEKPiBiaXQgd2VpcmQgYW5kIHVuaW50dWl0aXZlLCBidXQgaXQgd2FzIGRvbmUg
a25vd2luZ2x5LiBMZXQgbWUgcXVpY2tseQo+IHNwaW4gYSBrZXJuZWwtcGFyYW1ldGVycy50eHQg
Zml4IGZvciB0aGF0Li4uCgpTbyBJIGFscmVhZHkgaGFkIGEgcGVuZGluZyBwYXRjaCBoZXJlIGZv
ciB0aGUgc2FtZSB0byBiZSBpbmNsdWRlZCBpbiAKdGhpcyBzZXJpZXM6Cmh0dHBzOi8vZ2l0aHVi
LmNvbS9oaXNpbGljb24va2VybmVsLWRldi9jb21taXQvMjM3NWEyZDg4OGQ3OGRlOWViN2Q5MWQ2
ZjJjNTg5MTM5NTMwMGE5NgoKSWYgeW91IHdhbnQgdG8gZG8gaXQsIHRoZW4gb2suIEkgbWlnaHQg
aGF2ZSB0byByZW9yZGVyIHRoZSBzZXJpZXMgdGhvdWdoLi4uCgpUaGFua3MsCkpvaG4KCgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5n
IGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51
eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
