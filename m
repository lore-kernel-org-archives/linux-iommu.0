Return-Path: <SRS0=qkVD=5I=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63C24C4332B
	for <iommu@archiver.kernel.org>; Mon, 23 Mar 2020 09:03:30 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31F8220769
	for <iommu@archiver.kernel.org>; Mon, 23 Mar 2020 09:03:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31F8220769
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 093FF880E9;
	Mon, 23 Mar 2020 09:03:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5GOpmr586qK6; Mon, 23 Mar 2020 09:03:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 563FE880C4;
	Mon, 23 Mar 2020 09:03:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ED58CC089F;
	Mon, 23 Mar 2020 09:03:28 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C1883C0177
 for <iommu@lists.linux-foundation.org>; Mon, 23 Mar 2020 09:03:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id AD394880DC
 for <iommu@lists.linux-foundation.org>; Mon, 23 Mar 2020 09:03:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id W3T9MN8XQn1t for <iommu@lists.linux-foundation.org>;
 Mon, 23 Mar 2020 09:03:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from huawei.com (lhrrgout.huawei.com [185.176.76.210])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 64137880C4
 for <iommu@lists.linux-foundation.org>; Mon, 23 Mar 2020 09:03:26 +0000 (UTC)
Received: from lhreml703-cah.china.huawei.com (unknown [172.18.7.106])
 by Forcepoint Email with ESMTP id 4BBD44824978A8F6FB5C;
 Mon, 23 Mar 2020 09:03:23 +0000 (GMT)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 lhreml703-cah.china.huawei.com (10.201.108.44) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 23 Mar 2020 09:03:15 +0000
Received: from [127.0.0.1] (10.47.6.16) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 23 Mar
 2020 09:03:15 +0000
Subject: Re: arm-smmu-v3 high cpu usage for NVMe
To: Marc Zyngier <maz@kernel.org>
References: <20190821151749.23743-1-will@kernel.org>
 <b2a6e26d-6d0d-7f0d-f222-589812f701d2@huawei.com>
 <20200318205313.GB8094@willie-the-truck>
 <c6ab8020-dc06-0c7d-7a41-e792d90f97ba@huawei.com>
 <20200319184349.GA1697676@myrica>
 <c9ebe17d-66b8-1b8c-cc2c-5be0bd1501a7@huawei.com>
 <20200320111842.GD1702630@myrica>
 <b412fc9c-6266-e320-0769-f214d7752675@huawei.com>
 <5198fcffc8ad6233e0274ebff9e9aa5f@kernel.org>
From: John Garry <john.garry@huawei.com>
Message-ID: <cca67355-672d-81c5-3d37-72004eb8f14f@huawei.com>
Date: Mon, 23 Mar 2020 09:03:04 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <5198fcffc8ad6233e0274ebff9e9aa5f@kernel.org>
Content-Language: en-US
X-Originating-IP: [10.47.6.16]
X-ClientProxiedBy: lhreml716-chm.china.huawei.com (10.201.108.67) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Robin Murphy <robin.murphy@arm.com>, Ming Lei <ming.lei@redhat.com>,
 iommu@lists.linux-foundation.org, Will Deacon <will@kernel.org>
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

T24gMjAvMDMvMjAyMCAxNjozMywgTWFyYyBaeW5naWVyIHdyb3RlOgo+PiBKRllJLCBJJ3ZlIGJl
ZW4gcGxheWluZyBmb3IgInBlcmYgYW5ub3RhdGUiIHRvZGF5IGFuZCBpdCdzIGdpdmluZwo+PiBz
dHJhbmdlIHJlc3VsdHMgZm9yIG15IE5WTWUgdGVzdGluZy4gU28gInJlcG9ydCIgbG9va3Mgc29t
ZXdoYXQgc2FuZSwKPj4gaWYgbm90IGEgd29ycnlpbmdseSBoaWdoICUgZm9yIGFybV9zbW11X2Nt
ZHFfaXNzdWVfY21kbGlzdCgpOgo+Pgo+Pgo+PiDCoMKgwqAgNTUuMzklwqAgaXJxLzM0Mi1udm1l
MHExwqAgW2tlcm5lbC5rYWxsc3ltc13CoCBba10gCj4+IGFybV9zbW11X2NtZHFfaXNzdWVfY21k
bGlzdAo+PiDCoMKgwqDCoCA5Ljc0JcKgIGlycS8zNDItbnZtZTBxMcKgIFtrZXJuZWwua2FsbHN5
bXNdwqAgW2tdIAo+PiBfcmF3X3NwaW5fdW5sb2NrX2lycXJlc3RvcmUKPj4gwqDCoMKgwqAgMi4w
MiXCoCBpcnEvMzQyLW52bWUwcTHCoCBba2VybmVsLmthbGxzeW1zXcKgIFtrXSBudm1lX2lycQo+
PiDCoMKgwqDCoCAxLjg2JcKgIGlycS8zNDItbnZtZTBxMcKgIFtrZXJuZWwua2FsbHN5bXNdwqAg
W2tdIGZwdXRfbWFueQo+PiDCoMKgwqDCoCAxLjczJcKgIGlycS8zNDItbnZtZTBxMcKgIFtrZXJu
ZWwua2FsbHN5bXNdwqAgW2tdCj4+IGFybV9zbW11X2F0Y19pbnZfZG9tYWluLmNvbnN0cHJvcC40
Mgo+PiDCoMKgwqDCoCAxLjY3JcKgIGlycS8zNDItbnZtZTBxMcKgIFtrZXJuZWwua2FsbHN5bXNd
wqAgW2tdIF9fYXJtX2xwYWVfdW5tYXAKPj4gwqDCoMKgwqAgMS40OSXCoCBpcnEvMzQyLW52bWUw
cTHCoCBba2VybmVsLmthbGxzeW1zXcKgIFtrXSBhaW9fY29tcGxldGVfcncKPj4KPj4gQnV0ICJh
bm5vdGF0ZSIgY29uc2lzdGVudGx5IHRlbGxzIG1lIHRoYXQgYSBzcGVjaWZpYyBpbnN0cnVjdGlv
bgo+PiBjb25zdW1lcyB+OTklIG9mIHRoZSBsb2FkIGZvciB0aGUgZW5xdWV1ZSBmdW5jdGlvbjoK
Pj4KPj4gwqDCoMKgwqDCoMKgwqDCoCA6wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIC8qIDUuIElmIHdlIGFyZSBpbnNlcnRpbmcgYSBDTURfU1lOQywKPj4gd2UgbXVz
dCB3YWl0IGZvciBpdCB0byBjb21wbGV0ZSAqLwo+PiDCoMKgwqDCoMKgwqDCoMKgIDrCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKHN5bmMpIHsKPj4gwqDCoMKg
IDAuMDAgOsKgwqAgZmZmZjgwMDAxMDcxYzk0ODrCoMKgwqDCoMKgwqAgbGRywqDCoMKgwqAgdzAs
IFt4MjksICMxMDhdCj4+IMKgwqDCoMKgwqDCoMKgwqAgOsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBpbnQgcmV0ID0gMDsKPj4gwqDCoMKgIDAuMDAgOsKgwqAgZmZm
ZjgwMDAxMDcxYzk0YzrCoMKgwqDCoMKgwqAgbW92wqDCoMKgwqAgdzI0LCAjMHgwwqDCoMKgwqDC
oCAvLyAjMAo+PiDCoMKgwqDCoMKgwqDCoMKgIDrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgaWYgKHN5bmMpIHsKPj4gwqDCoMKgIDAuMDAgOsKgwqAgZmZmZjgwMDAx
MDcxYzk1MDrCoMKgwqDCoMKgwqAgY2JuesKgwqDCoCB3MCwgZmZmZjgwMDAxMDcxYzk5MAo+PiA8
YXJtX3NtbXVfY21kcV9pc3N1ZV9jbWRsaXN0KzB4NDIwPgo+PiDCoMKgwqDCoMKgwqDCoMKgIDrC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYXJjaF9sb2NhbF9pcnFf
cmVzdG9yZSgpOgo+PiDCoMKgwqAgMC4wMCA6wqDCoCBmZmZmODAwMDEwNzFjOTU0OsKgwqDCoMKg
wqDCoCBtc3LCoMKgwqDCoCBkYWlmLCB4MjEKPj4gwqDCoMKgwqDCoMKgwqDCoCA6wqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGFybV9zbW11X2NtZHFfaXNzdWVfY21k
bGlzdCgpOgo+PiDCoMKgwqDCoMKgwqDCoMKgIDrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgfQo+PiDCoMKgwqDCoMKgwqDCoMKgIDrCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfQo+PiDCoMKgwqDCoMKgwqDCoMKgIDoKPj4gwqDCoMKg
wqDCoMKgwqDCoCA6wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGxv
Y2FsX2lycV9yZXN0b3JlKGZsYWdzKTsKPj4gwqDCoMKgwqDCoMKgwqDCoCA6wqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiByZXQ7Cj4+IMKgwqDCoMKgwqDC
oMKgwqAgOsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB9Cj4+IMKg
wqAgOTkuNTEgOsKgwqAgZmZmZjgwMDAxMDcxYzk1ODrCoMKgwqDCoMKgwqAgYWRycMKgwqDCoCB4
MCwgZmZmZjgwMDAxMTkwOTAwMAo+PiA8cGFnZV93YWl0X3RhYmxlKzB4MTRjMD4KPiAKCkhpIE1h
cmMsCgo+IFRoaXMgaXMgbGlrZWx5IHRoZSBzaWRlIGVmZmVjdCBvZiB0aGUgcmUtZW5hYmxpbmcg
b2YgaW50ZXJydXB0cyAobXNyIAo+IGRhaWYsIHgyMSkKPiBvbiB0aGUgcHJldmlvdXMgaW5zdHJ1
Y3Rpb24gd2hpY2ggY2F1c2VzIHRoZSBwZXJmIGludGVycnVwdCB0byBmaXJlIAo+IHJpZ2h0IGFm
dGVyLgoKb2ssIG1ha2VzIHNlbnNlLgoKPiAKPiBUaW1lIHRvIGVuYWJsZSBwc2V1ZG8tTk1JcyBp
biB0aGUgUE1VdjMgZHJpdmVyLi4uCj4gCgpEbyB5b3Uga25vdyBpZiB0aGVyZSBpcyBhbnkgcGxh
biBmb3IgdGhpcz8KCkluIHRoZSBtZWFudGltZSwgbWF5YmUgSSBjYW4gZG8gc29tZSB0cmlja2Vy
eSBieSBwdXR0aW5nIHRoZSAKbG9jYWxfaXJxX3Jlc3RvcmUoKSBpbiBhIHNlcGFyYXRlIGZ1bmN0
aW9uLCBvdXRzaWRlIAphcm1fc21tdV9jbWRxX2lzc3VlX2NtZGxpc3QoKSwgdG8gZ2V0IGEgZmFp
ciBwcm9maWxlIGZvciB0aGF0IHNhbWUgZnVuY3Rpb24uCgpDaGVlcnMsCkpvaG4KX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0
CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3Vu
ZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
