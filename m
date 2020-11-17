Return-Path: <SRS0=JfyE=EX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A2D2C5519F
	for <iommu@archiver.kernel.org>; Tue, 17 Nov 2020 11:12:21 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEA4320870
	for <iommu@archiver.kernel.org>; Tue, 17 Nov 2020 11:12:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEA4320870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 527F28557B;
	Tue, 17 Nov 2020 11:12:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id U2CKrwmm9eCq; Tue, 17 Nov 2020 11:12:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 27B828545E;
	Tue, 17 Nov 2020 11:12:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0CABCC0800;
	Tue, 17 Nov 2020 11:12:17 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 16369C07FF
 for <iommu@lists.linux-foundation.org>; Tue, 17 Nov 2020 11:12:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 050D384D7A
 for <iommu@lists.linux-foundation.org>; Tue, 17 Nov 2020 11:12:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XVFASb5-Z8sx for <iommu@lists.linux-foundation.org>;
 Tue, 17 Nov 2020 11:12:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 78CE58488E
 for <iommu@lists.linux-foundation.org>; Tue, 17 Nov 2020 11:12:13 +0000 (UTC)
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
 by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Cb3DT4FWBz15LjT;
 Tue, 17 Nov 2020 19:11:53 +0800 (CST)
Received: from [10.174.178.174] (10.174.178.174) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.487.0; Tue, 17 Nov 2020 19:11:29 +0800
Subject: Re: [PATCH] iommu: fix return error code in iommu_probe_device()
To: Lu Baolu <baolu.lu@linux.intel.com>, <iommu@lists.linux-foundation.org>,
 <linux-kernel@vger.kernel.org>
References: <20201117025238.3425422-1-yangyingliang@huawei.com>
 <835ab066-b6b8-a211-4941-c01781031de8@linux.intel.com>
From: Yang Yingliang <yangyingliang@huawei.com>
Message-ID: <454f5e3e-c380-e8a5-9283-3f7578eb601e@huawei.com>
Date: Tue, 17 Nov 2020 19:11:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <835ab066-b6b8-a211-4941-c01781031de8@linux.intel.com>
Content-Language: en-US
X-Originating-IP: [10.174.178.174]
X-CFilter-Loop: Reflected
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

Ck9uIDIwMjAvMTEvMTcgMTc6NDAsIEx1IEJhb2x1IHdyb3RlOgo+IEhpIFlpbmdsaWFuZywKPgo+
IE9uIDIwMjAvMTEvMTcgMTA6NTIsIFlhbmcgWWluZ2xpYW5nIHdyb3RlOgo+PiBJZiBpb21tdV9n
cm91cF9nZXQoKSBmYWlsZWQsIGl0IG5lZWQgcmV0dXJuIGVycm9yIGNvZGUKPj4gaW4gaW9tbXVf
cHJvYmVfZGV2aWNlKCkuCj4+Cj4+IEZpeGVzOiBjZjE5Mzg4OGJmYmQgKCJpb21tdTogTW92ZSBu
ZXcgcHJvYmVfZGV2aWNlIHBhdGguLi4iKQo+PiBSZXBvcnRlZC1ieTogSHVsayBSb2JvdCA8aHVs
a2NpQGh1YXdlaS5jb20+Cj4+IFNpZ25lZC1vZmYtYnk6IFlhbmcgWWluZ2xpYW5nIDx5YW5neWlu
Z2xpYW5nQGh1YXdlaS5jb20+Cj4+IC0tLQo+PiDCoCBkcml2ZXJzL2lvbW11L2lvbW11LmMgfCA0
ICsrKy0KPj4gwqAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigt
KQo+Pgo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pb21tdS9pb21tdS5jIGIvZHJpdmVycy9pb21t
dS9pb21tdS5jCj4+IGluZGV4IGI1MzQ0NmJiOGM2Yi4uNmY0YTMyZGY5MGY2IDEwMDY0NAo+PiAt
LS0gYS9kcml2ZXJzL2lvbW11L2lvbW11LmMKPj4gKysrIGIvZHJpdmVycy9pb21tdS9pb21tdS5j
Cj4+IEBAIC0yNTMsOCArMjUzLDEwIEBAIGludCBpb21tdV9wcm9iZV9kZXZpY2Uoc3RydWN0IGRl
dmljZSAqZGV2KQo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgZ290byBlcnJfb3V0Owo+PiDCoCDCoMKg
wqDCoMKgIGdyb3VwID0gaW9tbXVfZ3JvdXBfZ2V0KGRldik7Cj4+IC3CoMKgwqAgaWYgKCFncm91
cCkKPj4gK8KgwqDCoCBpZiAoIWdyb3VwKSB7Cj4+ICvCoMKgwqDCoMKgwqDCoCByZXQgPSAtRU5P
REVWOwo+Cj4gQ2FuIHlvdSBwbGVhc2UgZXhwbGFpbiB3aHkgeW91IHVzZSAtRU5PREVWIGhlcmU/
CgpCZWZvcmUgNzk2NTkxOTBlZTk3ICgiaW9tbXU6IERvbid0IHRha2UgZ3JvdXAgcmVmZXJlbmNl
IGluIAppb21tdV9hbGxvY19kZWZhdWx0X2RvbWFpbigpIiksIGluCgppb21tdV9hbGxvY19kZWZh
dWx0X2RvbWFpbigpLCBpZiBncm91cCBpcyBOVUxMLCBpdCB3aWxsIHJldHVybiAtRU5PREVWLgoK
aHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvdG9ydmFsZHMv
bGludXguZ2l0L3RyZWUvZHJpdmVycy9pb21tdS9pb21tdS5jP2g9djUuMTAtcmM0JmlkPTcwYjgx
NzBlNTVkM2NhOTUwM2E1MzIxMTk2N2ZhZWU2YjVmMThiMTkKCj4KPiBCZXN0IHJlZ2FyZHMsCj4g
YmFvbHUKPgo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgZ290byBlcnJfcmVsZWFzZTsKPj4gK8KgwqDC
oCB9Cj4+IMKgIMKgwqDCoMKgwqAgLyoKPj4gwqDCoMKgwqDCoMKgICogVHJ5IHRvIGFsbG9jYXRl
IGEgZGVmYXVsdCBkb21haW4gLSBuZWVkcyBzdXBwb3J0IGZyb20gdGhlCj4+Cj4gLgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxp
c3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZv
dW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
