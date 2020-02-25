Return-Path: <SRS0=zhz4=4N=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87F4CC35DF5
	for <iommu@archiver.kernel.org>; Tue, 25 Feb 2020 09:13:42 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0445C218AC
	for <iommu@archiver.kernel.org>; Tue, 25 Feb 2020 09:13:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0445C218AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id A9E9F86935;
	Tue, 25 Feb 2020 09:13:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id W7J0urVCy_w9; Tue, 25 Feb 2020 09:13:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 21D228692B;
	Tue, 25 Feb 2020 09:13:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1980EC089F;
	Tue, 25 Feb 2020 09:13:41 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B0C6EC0177
 for <iommu@lists.linux-foundation.org>; Tue, 25 Feb 2020 09:13:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 9CF0286918
 for <iommu@lists.linux-foundation.org>; Tue, 25 Feb 2020 09:13:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id a-9pUQcM-gOh for <iommu@lists.linux-foundation.org>;
 Tue, 25 Feb 2020 09:13:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from huawei.com (szxga05-in.huawei.com [45.249.212.191])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 2CD108691E
 for <iommu@lists.linux-foundation.org>; Tue, 25 Feb 2020 09:13:38 +0000 (UTC)
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 9490EC4477B67687CCAC;
 Tue, 25 Feb 2020 17:13:30 +0800 (CST)
Received: from [127.0.0.1] (10.67.101.242) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.439.0; Tue, 25 Feb 2020
 17:13:19 +0800
Subject: Re: [PATCH] uacce: unmap remaining mmapping from user space
To: zhangfei <zhangfei.gao@linaro.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, Herbert Xu
 <herbert@gondor.apana.org.au>, <jonathan.cameron@huawei.com>,
 <dave.jiang@intel.com>, <grant.likely@arm.com>, jean-philippe
 <jean-philippe@linaro.org>, Jerome Glisse <jglisse@redhat.com>,
 <ilias.apalodimas@linaro.org>, <francois.ozog@linaro.org>,
 <kenneth-lee-2012@foxmail.com>, Wangzhou <wangzhou1@hisilicon.com>, "haojian
 . zhuang" <haojian.zhuang@linaro.org>, <guodong.xu@linaro.org>
References: <1582528016-2873-1-git-send-email-zhangfei.gao@linaro.org>
 <a4716453-0607-d613-e632-173d1ebc424e@huawei.com>
 <cf1f7ec2-7181-63fd-598d-b74d5a3efa15@linaro.org>
From: Xu Zaibo <xuzaibo@huawei.com>
Message-ID: <844f8fc1-1c6c-0102-5412-df799cd327c5@huawei.com>
Date: Tue, 25 Feb 2020 17:13:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <cf1f7ec2-7181-63fd-598d-b74d5a3efa15@linaro.org>
X-Originating-IP: [10.67.101.242]
X-CFilter-Loop: Reflected
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 linux-accelerators@lists.ozlabs.org, linux-crypto@vger.kernel.org
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

SGksCk9uIDIwMjAvMi8yNSAxNjozMywgemhhbmdmZWkgd3JvdGU6Cj4gSGksIFphaWJvCj4KPiBP
biAyMDIwLzIvMjQg5LiL5Y2IMzoxNywgWHUgWmFpYm8gd3JvdGU6Cj4+PiAgIEBAIC01ODUsNiAr
NTk1LDEzIEBAIHZvaWQgdWFjY2VfcmVtb3ZlKHN0cnVjdCB1YWNjZV9kZXZpY2UgKnVhY2NlKQo+
Pj4gICAgICAgICAgIGNkZXZfZGV2aWNlX2RlbCh1YWNjZS0+Y2RldiwgJnVhY2NlLT5kZXYpOwo+
Pj4gICAgICAgeGFfZXJhc2UoJnVhY2NlX3hhLCB1YWNjZS0+ZGV2X2lkKTsKPj4+ICAgICAgIHB1
dF9kZXZpY2UoJnVhY2NlLT5kZXYpOwo+Pj4gKwo+Pj4gKyAgICAvKgo+Pj4gKyAgICAgKiB1bm1h
cCByZW1haW5uaW5nIG1hcHBpbmcgZnJvbSB1c2VyIHNwYWNlLCBwcmV2ZW50aW5nIHVzZXIgc3Rp
bGwKPj4+ICsgICAgICogYWNjZXNzIHRoZSBtbWFwZWQgYXJlYSB3aGlsZSBwYXJlbnQgZGV2aWNl
IGlzIGFscmVhZHkgcmVtb3ZlZAo+Pj4gKyAgICAgKi8KPj4+ICsgICAgaWYgKHVhY2NlLT5pbm9k
ZSkKPj4+ICsgICAgICAgIHVubWFwX21hcHBpbmdfcmFuZ2UodWFjY2UtPmlub2RlLT5pX21hcHBp
bmcsIDAsIDAsIDEpOwo+PiBTaG91bGQgd2UgdW5tYXAgdGhlbSBhdCB0aGUgZmlyc3Qgb2YgJ3Vh
Y2NlX3JlbW92ZScsICBhbmQgYmVmb3JlIAo+PiAndWFjY2VfcHV0X3F1ZXVlJz8KPj4KPiBXZSBj
YW4gZG8gdGhpcywKPiBUaG91Z2ggaXQgZG9lcyBub3QgbWF0dGVyLCBzaW5jZSB1c2VyIHNwYWNl
IGNhbiBub3QgaW50ZXJydXB0IGtlcm5lbCAKPiBmdW5jdGlvbiB1YWNjZV9yZW1vdmUuCj4KSSB0
aGluayBpdCBtYXR0ZXJzIDopCgpJbWFnZSB0aGF0IHRoZSBwcm9jZXNzIGhvbGRzIHRoZSB1YWNj
ZSBxdWV1ZSBpcyBydW5uaW5nKHJlYWQgYW5kIHdyaXRlIAp0aGUgcXVldWUpLCB0aGVuIHlvdSBk
byAndWFjY2VfcmVtb3ZlJy4KVGhlIHByb2Nlc3MgaXMgcnVubmluZyhyZWFkIGFuZCB3cml0ZSB0
aGUgcXVldWUpIHdlbGwgaW4gdGhlIHRpbWUgCmJldHdlZW4gJ3VhY2NlX3B1dF9xdWV1ZScgYW5k
Cid1bm1hcF9tYXBwaW5nX3JhbmdlJywgaG93ZXZlciwgdGhlIHF1ZXVlIHdpdGggaXRzIERNQSBt
ZW1vcnkgbWF5IGJlIApnb3R0ZW4gYW5kIHVzZWQgYnkKb3RoZXIgZ3V5cyBpbiB0aGlzIHRpbWUs
IHNpbmNlIHlvdSBoYXZlIHJlbGVhc2VkIHRoZW0gaW4ga2VybmVsLiBBcyBhIApyZXN1bHQsIHRo
ZSBydW5uaW5nIHByb2Nlc3Mgd2lsbCBiZSBhIGRpc2FzdGVyLgoKY2hlZXJzLApaYWlibwoKLgoK
Cj4gVGhhbmtzCj4gLgo+CgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24u
b3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lv
bW11
