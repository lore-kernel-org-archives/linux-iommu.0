Return-Path: <SRS0=K0Me=LL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACD3BC2B9F4
	for <iommu@archiver.kernel.org>; Thu, 17 Jun 2021 08:07:02 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CAA8610A1
	for <iommu@archiver.kernel.org>; Thu, 17 Jun 2021 08:07:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CAA8610A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 16ACD415E1;
	Thu, 17 Jun 2021 08:07:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3BtPuTrofwVf; Thu, 17 Jun 2021 08:06:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 6AA0A415D6;
	Thu, 17 Jun 2021 08:06:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 22C3EC000E;
	Thu, 17 Jun 2021 08:06:57 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C4A23C000B
 for <iommu@lists.linux-foundation.org>; Thu, 17 Jun 2021 08:06:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id ABC2A606E6
 for <iommu@lists.linux-foundation.org>; Thu, 17 Jun 2021 08:06:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CJNg6D06hr8W for <iommu@lists.linux-foundation.org>;
 Thu, 17 Jun 2021 08:06:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 18278606A0
 for <iommu@lists.linux-foundation.org>; Thu, 17 Jun 2021 08:06:52 +0000 (UTC)
Received: from fraeml709-chm.china.huawei.com (unknown [172.18.147.200])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4G5Dnw3xwBz6K6Hr;
 Thu, 17 Jun 2021 15:53:40 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml709-chm.china.huawei.com (10.206.15.37) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 17 Jun 2021 10:06:50 +0200
Received: from [10.47.95.81] (10.47.95.81) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Thu, 17 Jun
 2021 09:06:49 +0100
Subject: Re: [PATCH v13 4/6] iommu/vt-d: Add support for IOMMU default DMA
 mode build options
To: Lu Baolu <baolu.lu@linux.intel.com>, <joro@8bytes.org>, <will@kernel.org>, 
 <dwmw2@infradead.org>, <robin.murphy@arm.com>, <corbet@lwn.net>
References: <1623841437-211832-1-git-send-email-john.garry@huawei.com>
 <1623841437-211832-5-git-send-email-john.garry@huawei.com>
 <46dbce5c-1c2b-60d4-df56-d2b95a959425@linux.intel.com>
From: John Garry <john.garry@huawei.com>
Message-ID: <f3fe6c4b-f360-ab7b-7ad2-ced63269499d@huawei.com>
Date: Thu, 17 Jun 2021 09:00:37 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <46dbce5c-1c2b-60d4-df56-d2b95a959425@linux.intel.com>
Content-Language: en-US
X-Originating-IP: [10.47.95.81]
X-ClientProxiedBy: lhreml743-chm.china.huawei.com (10.201.108.193) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxarm@huawei.com, iommu@lists.linux-foundation.org
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

T24gMTcvMDYvMjAyMSAwODozMiwgTHUgQmFvbHUgd3JvdGU6Cj4gT24gNi8xNi8yMSA3OjAzIFBN
LCBKb2huIEdhcnJ5IHdyb3RlOgo+PiBAQCAtNDM4Miw5ICs0MzgwLDkgQEAgaW50IF9faW5pdCBp
bnRlbF9pb21tdV9pbml0KHZvaWQpCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgICogaXMgbGlrZWx5
IHRvIGJlIG11Y2ggbG93ZXIgdGhhbiB0aGUgb3ZlcmhlYWQgb2YgCj4+IHN5bmNocm9uaXppbmcK
Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqAgKiB0aGUgdmlydHVhbCBhbmQgcGh5c2ljYWwgSU9NTVUg
cGFnZS10YWJsZXMuCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgICovCj4+IC3CoMKgwqDCoMKgwqDC
oCBpZiAoIWludGVsX2lvbW11X3N0cmljdCAmJiBjYXBfY2FjaGluZ19tb2RlKGlvbW11LT5jYXAp
KSB7Cj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHByX3dhcm4oIklPTU1VIGJhdGNoaW5nIGlz
IGRpc2FibGVkIGR1ZSB0byB2aXJ0dWFsaXphdGlvbiIpOwo+PiAtwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBpbnRlbF9pb21tdV9zdHJpY3QgPSAxOwo+PiArwqDCoMKgwqDCoMKgwqAgaWYgKGNhcF9j
YWNoaW5nX21vZGUoaW9tbXUtPmNhcCkpIHsKPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcHJf
d2FybigiSU9NTVUgYmF0Y2hpbmcgZGlzYWxsb3dlZCBkdWUgdG8gCj4+IHZpcnR1YWxpemF0aW9u
XG4iKTsKPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaW9tbXVfc2V0X2RtYV9zdHJpY3QodHJ1
ZSk7Cj4gCj4gV2l0aCB0aGlzIGNoYW5nZSwgVk0gZ3Vlc3Qgd2lsbCBhbHdheXMgc2hvdyB0aGlz
IHdhcm5pbmcuCgpXb3VsZCB0aGV5IGhhdmUgZ290IGl0IGJlZm9yZSBhbHNvIG5vcm1hbGx5PwoK
SSBtZWFuLCBkZWZhdWx0IGlzIGludGVsX2lvbW11X3N0cmljdD0wLCBzbyBpZiAKY2FwX2NhY2hp
bmdfbW9kZShpb21tdS0+Y2FwKSBpcyB0cnVlIGFuZCBpbnRlbF9pb21tdV9zdHJpY3Qgbm90IHNl
dCB0byAxIAplbHNld2hlcmUgcHJldmlvdXNseSwgdGhlbiB3ZSB3b3VsZCBnZXQgdGhpcyBwcmlu
dC4KCj4gSG93IGFib3V0Cj4gcmVtb3ZpbmcgdGhpcyBtZXNzYWdlPyBVc2VycyBjb3VsZCBnZXQg
dGhlIHNhbWUgaW5mb3JtYXRpb24gdGhyb3VnaCB0aGUKPiBrZXJuZWwgbWVzc2FnZSBhZGRlZCBi
eSAiW1BBVENIIHYxMyAyLzZdIGlvbW11OiBQcmludCBzdHJpY3Qgb3IgbGF6eQo+IG1vZGUgYXQg
aW5pdCB0aW1lIi4KCkkgdGhpbmsgdGhhdCB0aGUgcHJpbnQgZnJvbSAyLzYgc2hvdWxkIG9jY3Vy
IGJlZm9yZSB0aGlzIHByaW50LgoKUmVnYXJkbGVzcyBJIHdvdWxkIHRoaW5rIHRoYXQgeW91IHdv
dWxkIHN0aWxsIGxpa2UgdG8gYmUgbm90aWZpZWQgb2YgCnRoaXMgY2hhbmdlIGluIHBvbGljeSwg
cmlnaHQ/CgpIb3dldmVyIEkgbm93IHJlYWxpemUgdGhhdCB0aGUgcHJpbnQgaXMgaW4gYSBsb29w
IHBlciBpb21tdSwgc28gd2Ugd291bGQgCmdldCBpdCBwZXIgaW9tbXU6Cgpmb3JfZWFjaF9hY3Rp
dmVfaW9tbXUoaW9tbXUsIGRyaGQpIHsKCS8qCgkgKiBUaGUgZmx1c2ggcXVldWUgaW1wbGVtZW50
YXRpb24gZG9lcyBub3QgcGVyZm9ybQoJICogcGFnZS1zZWxlY3RpdmUgaW52YWxpZGF0aW9ucyB0
aGF0IGFyZSByZXF1aXJlZCBmb3IgZWZmaWNpZW50CgkgKiBUTEIgZmx1c2hlcyBpbiB2aXJ0dWFs
IGVudmlyb25tZW50cy4gIFRoZSBiZW5lZml0IG9mIGJhdGNoaW5nCgkgKiBpcyBsaWtlbHkgdG8g
YmUgbXVjaCBsb3dlciB0aGFuIHRoZSBvdmVyaGVhZCBvZiBzeW5jaHJvbml6aW5nCgkgKiB0aGUg
dmlydHVhbCBhbmQgcGh5c2ljYWwgSU9NTVUgcGFnZS10YWJsZXMuCgkgKi8KCWlmICghaW50ZWxf
aW9tbXVfc3RyaWN0ICYmIGNhcF9jYWNoaW5nX21vZGUoaW9tbXUtPmNhcCkpIHsKCQlwcl93YXJu
KCJJT01NVSBiYXRjaGluZyBpcyBkaXNhYmxlZCBkdWUgdG8gdmlydHVhbGl6YXRpb24iKTsKCQlp
bnRlbF9pb21tdV9zdHJpY3QgPSAxOwoJfQoJLi4uCn0KCkkgbmVlZCB0byBjaGFuZ2UgdGhhdC4g
SG93IGFib3V0IHRoaXM6Cgpib29sIHByaW50X3dhcm5pbmcgPSBmYWxzZTsKCmZvcl9lYWNoX2Fj
dGl2ZV9pb21tdShpb21tdSwgZHJoZCkgewoJLyoKCSAqIFRoZSBmbHVzaCBxdWV1ZSBpbXBsZW1l
bnRhdGlvbiBkb2VzIG5vdCBwZXJmb3JtCgkgKiBwYWdlLXNlbGVjdGl2ZSBpbnZhbGlkYXRpb25z
IHRoYXQgYXJlIHJlcXVpcmVkIGZvciBlZmZpY2llbnQKCSAqIFRMQiBmbHVzaGVzIGluIHZpcnR1
YWwgZW52aXJvbm1lbnRzLiAgVGhlIGJlbmVmaXQgb2YgYmF0Y2hpbmcKCSAqIGlzIGxpa2VseSB0
byBiZSBtdWNoIGxvd2VyIHRoYW4gdGhlIG92ZXJoZWFkIG9mIHN5bmNocm9uaXppbmcKCSAqIHRo
ZSB2aXJ0dWFsIGFuZCBwaHlzaWNhbCBJT01NVSBwYWdlLXRhYmxlcy4KCSAqLwoJaWYgKCFwcmlu
dF93YXJuaW5nICYmIGNhcF9jYWNoaW5nX21vZGUoaW9tbXUtPmNhcCkpIHsKCQlwcl93YXJuKCJJ
T01NVSBiYXRjaGluZyBkaXNhbGxvd2VkIGR1ZSB0byB2aXJ0dWFsaXphdGlvblxuIik7CgkJaW9t
bXVfc2V0X2RtYV9zdHJpY3QodHJ1ZSk7CgkJcHJpbnRfd2FybmluZyA9IHRydWU7Cgl9CgkuLi4K
fQoKb3IgdXNlIHByX3dhcm5fb25jZSgpLgoKVGhhbmtzLApKb2huCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBs
aXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5v
cmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
