Return-Path: <SRS0=UGJ5=K3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C41E9C4708F
	for <iommu@archiver.kernel.org>; Tue,  1 Jun 2021 04:28:14 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E07B6136E
	for <iommu@archiver.kernel.org>; Tue,  1 Jun 2021 04:28:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E07B6136E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D927F4044B;
	Tue,  1 Jun 2021 04:28:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TnKNzxr6s5Xb; Tue,  1 Jun 2021 04:28:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6905B40440;
	Tue,  1 Jun 2021 04:28:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3128EC000E;
	Tue,  1 Jun 2021 04:28:12 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 96696C0001
 for <iommu@lists.linux-foundation.org>; Tue,  1 Jun 2021 04:28:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6E87640153
 for <iommu@lists.linux-foundation.org>; Tue,  1 Jun 2021 04:28:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gbEsXDX4kOcy for <iommu@lists.linux-foundation.org>;
 Tue,  1 Jun 2021 04:28:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D6B9D400E8
 for <iommu@lists.linux-foundation.org>; Tue,  1 Jun 2021 04:28:08 +0000 (UTC)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.53])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4FvJww3HQczYnKJ;
 Tue,  1 Jun 2021 12:25:20 +0800 (CST)
Received: from dggpemm500022.china.huawei.com (7.185.36.162) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 1 Jun 2021 12:28:03 +0800
Received: from [10.174.185.220] (10.174.185.220) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 1 Jun 2021 12:28:02 +0800
Subject: Re: [RFC] /dev/ioasid uAPI proposal
To: Jason Wang <jasowang@redhat.com>, Liu Yi L <yi.l.liu@linux.intel.com>
References: <MWHPR11MB1886422D4839B372C6AB245F8C239@MWHPR11MB1886.namprd11.prod.outlook.com>
 <f510f916-e91c-236d-e938-513a5992d3b5@redhat.com>
 <20210531164118.265789ee@yiliu-dev>
 <78ee2638-1a03-fcc8-50a5-81040f677e69@redhat.com>
From: Shenming Lu <lushenming@huawei.com>
Message-ID: <1fedcd93-1a8a-884f-d0c8-3e2c21ed7654@huawei.com>
Date: Tue, 1 Jun 2021 12:27:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <78ee2638-1a03-fcc8-50a5-81040f677e69@redhat.com>
Content-Language: en-US
X-Originating-IP: [10.174.185.220]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500022.china.huawei.com (7.185.36.162)
X-CFilter-Loop: Reflected
Cc: "Tian, Kevin" <kevin.tian@intel.com>,
 "Alex Williamson \(alex.williamson@redhat.com\)\""
 <alex.williamson@redhat.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, LKML <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, Jason
 Gunthorpe <jgg@nvidia.com>,
 "wanghaibin.wang@huawei.com" <wanghaibin.wang@huawei.com>, David
 Woodhouse <dwmw2@infradead.org>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

T24gMjAyMS82LzEgMTA6MzYsIEphc29uIFdhbmcgd3JvdGU6Cj4gCj4g5ZyoIDIwMjEvNS8zMSDk
uIvljYg0OjQxLCBMaXUgWWkgTCDlhpnpgZM6Cj4+PiBJIGd1ZXNzIFZGSU9fQVRUQUNIX0lPQVNJ
RCB3aWxsIGZhaWwgaWYgdGhlIHVuZGVybGF5ZXIgZG9lc24ndCBzdXBwb3J0Cj4+PiBoYXJkd2Fy
ZSBuZXN0aW5nLiBPciBpcyB0aGVyZSB3YXkgdG8gZGV0ZWN0IHRoZSBjYXBhYmlsaXR5IGJlZm9y
ZT8KPj4gSSB0aGluayBpdCBjb3VsZCBmYWlsIGluIHRoZSBJT0FTSURfQ1JFQVRFX05FU1RJTkcu
IElmIHRoZSBncGFfaW9hc2lkCj4+IGlzIG5vdCBhYmxlIHRvIHN1cHBvcnQgbmVzdGluZywgdGhl
biBzaG91bGQgZmFpbCBpdC4KPj4KPj4+IEkgdGhpbmsgR0VUX0lORk8gb25seSB3b3JrcyBhZnRl
ciB0aGUgQVRUQUNILgo+PiB5ZXMuIEFmdGVyIGF0dGFjaGluZyB0byBncGFfaW9hc2lkLCB1c2Vy
c3BhY2UgY291bGQgR0VUX0lORk8gb24gdGhlCj4+IGdwYV9pb2FzaWQgYW5kIGNoZWNrIGlmIG5l
c3RpbmcgaXMgc3VwcG9ydGVkIG9yIG5vdC4gcmlnaHQ/Cj4gCj4gCj4gU29tZSBtb3JlIHF1ZXN0
aW9uczoKPiAKPiAxKSBJcyB0aGUgaGFuZGxlIHJldHVybmVkIGJ5IElPQVNJRF9BTExPQyBhbiBm
ZD8KPiAyKSBJZiB5ZXMsIHdoYXQncyB0aGUgcmVhc29uIGZvciBub3Qgc2ltcGx5IHVzZSB0aGUg
ZmQgb3BlbmVkIGZyb20gL2Rldi9pb2FzLiAoVGhpcyBpcyB0aGUgcXVlc3Rpb24gdGhhdCBpcyBu
b3QgYW5zd2VyZWQpIGFuZCB3aGF0IGhhcHBlbnMgaWYgd2UgY2FsbCBHRVRfSU5GTyBmb3IgdGhl
IGlvYXNpZF9mZD8KPiAzKSBJZiBub3QsIGhvdyBHRVRfSU5GTyB3b3JrPwoKSXQgc2VlbXMgdGhh
dCB0aGUgcmV0dXJuIHZhbHVlIGZyb20gSU9BU0lEX0FMTE9DIGlzIGFuIElPQVNJRCBudW1iZXIg
aW4gdGhlCmlvYXNpZF9kYXRhIHN0cnVjdCwgdGhlbiB3aGVuIGNhbGxpbmcgR0VUX0lORk8sIHdl
IHNob3VsZCBjb252ZXkgdGhpcyBJT0FTSUQKbnVtYmVyIHRvIGdldCB0aGUgYXNzb2NpYXRlZCBJ
L08gYWRkcmVzcyBzcGFjZSBhdHRyaWJ1dGVzIChkZXBlbmQgb24gdGhlCnBoeXNpY2FsIElPTU1V
LCB3aGljaCBjb3VsZCBiZSBkaXNjb3ZlcmVkIHdoZW4gYXR0YWNoaW5nIGEgZGV2aWNlIHRvIHRo
ZQpJT0FTSUQgZmQgb3IgbnVtYmVyKSwgcmlnaHQ/CgpUaGFua3MsClNoZW5taW5nCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlz
dAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91
bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
