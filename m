Return-Path: <SRS0=Ta7z=LP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_RED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EAD0C4743C
	for <iommu@archiver.kernel.org>; Mon, 21 Jun 2021 10:41:01 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C015A61153
	for <iommu@archiver.kernel.org>; Mon, 21 Jun 2021 10:41:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C015A61153
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7EFD582ED1;
	Mon, 21 Jun 2021 10:41:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id F2IX7s__GZ26; Mon, 21 Jun 2021 10:40:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 5C79482E19;
	Mon, 21 Jun 2021 10:40:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3335CC000E;
	Mon, 21 Jun 2021 10:40:59 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9E893C000C
 for <iommu@lists.linux-foundation.org>; Mon, 21 Jun 2021 10:40:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9961240197
 for <iommu@lists.linux-foundation.org>; Mon, 21 Jun 2021 10:40:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 06wtGB5neepo for <iommu@lists.linux-foundation.org>;
 Mon, 21 Jun 2021 10:40:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A00ED4015D
 for <iommu@lists.linux-foundation.org>; Mon, 21 Jun 2021 10:40:54 +0000 (UTC)
Received: from fraeml708-chm.china.huawei.com (unknown [172.18.147.201])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4G7m1Y3Tzgz6H7vX;
 Mon, 21 Jun 2021 18:27:29 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml708-chm.china.huawei.com (10.206.15.36) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 21 Jun 2021 12:40:50 +0200
Received: from [10.47.93.67] (10.47.93.67) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Mon, 21 Jun
 2021 11:40:49 +0100
Subject: Re: [PATCH v14 6/6] iommu: Remove mode argument from
 iommu_set_dma_strict()
To: Lu Baolu <baolu.lu@linux.intel.com>, <joro@8bytes.org>, <will@kernel.org>, 
 <dwmw2@infradead.org>, <robin.murphy@arm.com>, <corbet@lwn.net>
References: <1624016058-189713-1-git-send-email-john.garry@huawei.com>
 <1624016058-189713-7-git-send-email-john.garry@huawei.com>
 <c062ef9e-c106-4218-ba2a-c94fdcb6d955@linux.intel.com>
 <60bdd7c3-d73e-c005-ddf7-069bc5065bce@huawei.com>
 <855dd109-1449-7bc6-3d25-7ffeeeffa82a@linux.intel.com>
From: John Garry <john.garry@huawei.com>
Message-ID: <fc52069d-46c5-5ca5-1b44-2fa7cf287d5a@huawei.com>
Date: Mon, 21 Jun 2021 11:34:25 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <855dd109-1449-7bc6-3d25-7ffeeeffa82a@linux.intel.com>
Content-Language: en-US
X-Originating-IP: [10.47.93.67]
X-ClientProxiedBy: lhreml747-chm.china.huawei.com (10.201.108.197) To
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

T24gMjEvMDYvMjAyMSAxMTowMCwgTHUgQmFvbHUgd3JvdGU6Cj4+IHZvaWQgaW9tbXVfc2V0X2Rt
YV9zdHJpY3QoYm9vbCBmb3JjZSkKPj4gewo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKGZvcmNl
ID09IHRydWUpCj4+IMKgwqDCoMKgwqDCoMKgwqAgaW9tbXVfZG1hX3N0cmljdCA9IHRydWU7Cj4+
IMKgwqDCoMKgwqBlbHNlIGlmICghKGlvbW11X2NtZF9saW5lICYgSU9NTVVfQ01EX0xJTkVfU1RS
SUNUKSkKPj4gwqDCoMKgwqDCoMKgwqDCoCBpb21tdV9kbWFfc3RyaWN0ID0gdHJ1ZTsKPj4gfQo+
Pgo+PiBTbyB3ZSB3b3VsZCB1c2UgaW9tbXVfc2V0X2RtYV9zdHJpY3QodHJ1ZSkgZm9yIGEpIGFu
ZCBiKSwgYnV0IAo+PiBpb21tdV9zZXRfZG1hX3N0cmljdChmYWxzZSkgZm9yIGMpLgo+IAo+IFll
cy4gV2UgbmVlZCB0byBkaXN0aW5ndWlzaCB0aGUgIm11c3QiIGFuZCAibmljZS10by1oYXZlIiBj
YXNlcyBvZgo+IHNldHRpbmcgc3RyaWN0IG1vZGUuCj4gCj4+Cj4+IFRoZW4gSSBhbSBub3Qgc3Vy
ZSB3aGF0IHlvdSB3YW50IHRvIGRvIHdpdGggdGhlIGFjY29tcGFueWluZyBwcmludCBmb3IgCj4+
IGMpLiBJdCB3YXM6Cj4+ICJJT01NVSBiYXRjaGluZyBpcyBkaXNhYmxlZCBkdWUgdG8gdmlydHVh
bGl6YXRpb24iCj4+Cj4+IEFuZCBub3cgaXMgZnJvbSB0aGlzIHNlcmllczoKPj4gIklPTU1VIGJh
dGNoaW5nIGRpc2FsbG93ZWQgZHVlIHRvIHZpcnR1YWxpemF0aW9uIgo+Pgo+PiBVc2luZyBpb21t
dV9nZXRfZG1hX3N0cmljdChkb21haW4pIGlzIG5vdCBhcHByb3ByaWF0ZSBoZXJlIHRvIGtub3cg
dGhlIAo+PiBjdXJyZW50IG1vZGUgKHNvIHdlIGtub3cgd2hldGhlciB0byBwcmludCkuCj4+Cj4+
IE5vdGUgdGhhdCB0aGlzIGNoYW5nZSB3b3VsZCBtZWFuIHRoYXQgdGhlIGN1cnJlbnQgc2VyaWVz
IHdvdWxkIHJlcXVpcmUgCj4+IG5vbi10cml2aWFsIHJld29yaywgd2hpY2ggd291bGQgYmUgdW5m
b3J0dW5hdGUgc28gbGF0ZSBpbiB0aGUgY3ljbGUuCj4gCj4gVGhpcyBwYXRjaCBzZXJpZXMgbG9v
a3MgZ29vZCB0byBtZSBhbmQgSSBoYXZlIGFkZGVkIGJ5IHJldmlld2VkLWJ5Lgo+IFByb2JhYmx5
IHdlIGNvdWxkIG1ha2UgYW5vdGhlciBwYXRjaCBzZXJpZXMgdG8gaW1wcm92ZSBpdCBzbyB0aGF0
IHRoZQo+IGtlcm5lbCBvcHRpbWl6YXRpb24gc2hvdWxkIG5vdCBvdmVycmlkZSB0aGUgdXNlciBz
ZXR0aW5nLgoKT24gYSBwZXJzb25hbCBsZXZlbCBJIHdvdWxkIGJlIGhhcHB5IHdpdGggdGhhdCBh
cHByb2FjaCwgYnV0IEkgdGhpbmsgCml0J3MgYmV0dGVyIHRvIG5vdCBzdGFydCBjaGFuZ2luZyB0
aGluZ3MgcmlnaHQgYXdheSBpbiBhIGZvbGxvdy11cCBzZXJpZXMuCgpTbyBob3cgYWJvdXQgd2Ug
YWRkIHRoaXMgcGF0Y2ggKHdoaWNoIHJlcGxhY2VzIDYvNiAiaW9tbXU6IFJlbW92ZSBtb2RlIAph
cmd1bWVudCBmcm9tIGlvbW11X3NldF9kbWFfc3RyaWN0KCkiKT8KClJvYmluLCBhbnkgb3Bpbmlv
bj8KCi0tLS0tLS0+OC0tLS0tLS0tLQoKW1BBVENIXSBpb21tdS92dC1kOiBNYWtlICJpb21tdS5z
dHJpY3QiIG92ZXJyaWRlIGJhdGNoaW5nIGR1ZSB0bwogIHZpcnR1YWxpemF0aW9uCgpBcyBhIGNo
YW5nZSBpbiBwb2xpY3ksIG1ha2UgaW9tbXUuc3RyaWN0IGNtZGxpbmUgYXJndW1lbnQgb3ZlcnJp
ZGUgCndoZXRoZXIgd2UgZGlzYWJsZSBiYXRjaGluZyBkdWUgdG8gdmlydHVhbGl6YXRpb24uCgpU
aGUgQVBJIG9mIGlvbW11X3NldF9kbWFfc3RyaWN0KCkgaXMgY2hhbmdlZCB0byBhY2NlcHQgYSAi
Zm9yY2UiIAphcmd1bWVudCwgd2hpY2ggbWVhbnMgdGhhdCB3ZSBhbHdheXMgc2V0IGlvbW11X2Rt
YV9zdHJpY3QgdHJ1ZSwgCnJlZ2FyZGxlc3Mgb2Ygd2hldGhlciB3ZSBhbHJlYWR5IHNldCB2aWEg
Y21kbGluZS4gQWxzbyByZXR1cm4gYSBib29sZWFuLCAKdG8gdGVsbCB3aGV0aGVyIGlvbW11X2Rt
YV9zdHJpY3Qgd2FzIHNldCBvciBub3QuCgpOb3RlIHRoYXQgaW4gYWxsIHByZS1leGlzdGluZyBj
YWxsc2l0ZXMgb2YgaW9tbXVfc2V0X2RtYV9zdHJpY3QoKSwgCmFyZ3VtZW50IHN0cmljdCB3YXMg
dHJ1ZSwgc28gdGhpcyBhcmd1bWVudCBpcyBkcm9wcGVkLgoKU2lnbmVkLW9mZi1ieTogSm9obiBH
YXJyeSA8am9obi5nYXJyeUBodWF3ZWkuY29tPgoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW9tbXUv
aW50ZWwvaW9tbXUuYyBiL2RyaXZlcnMvaW9tbXUvaW50ZWwvaW9tbXUuYwppbmRleCAwNjY2NmY5
ZDgxMTYuLmU4ZDY1MjM5YjM1OSAxMDA2NDQKLS0tIGEvZHJpdmVycy9pb21tdS9pbnRlbC9pb21t
dS5jCisrKyBiL2RyaXZlcnMvaW9tbXUvaW50ZWwvaW9tbXUuYwpAQCAtNDM4MCwxMCArNDM4MCw4
IEBAIGludCBfX2luaXQgaW50ZWxfaW9tbXVfaW5pdCh2b2lkKQogIAkJICogaXMgbGlrZWx5IHRv
IGJlIG11Y2ggbG93ZXIgdGhhbiB0aGUgb3ZlcmhlYWQgb2Ygc3luY2hyb25pemluZwogIAkJICog
dGhlIHZpcnR1YWwgYW5kIHBoeXNpY2FsIElPTU1VIHBhZ2UtdGFibGVzLgogIAkJICovCi0JCWlm
IChjYXBfY2FjaGluZ19tb2RlKGlvbW11LT5jYXApKSB7CisJCWlmIChjYXBfY2FjaGluZ19tb2Rl
KGlvbW11LT5jYXApICYmIGlvbW11X3NldF9kbWFfc3RyaWN0KGZhbHNlKSkKICAJCQlwcl9pbmZv
X29uY2UoIklPTU1VIGJhdGNoaW5nIGRpc2FsbG93ZWQgZHVlIHRvIHZpcnR1YWxpemF0aW9uXG4i
KTsKLQkJCWlvbW11X3NldF9kbWFfc3RyaWN0KHRydWUpOwotCQl9CiAgCQlpb21tdV9kZXZpY2Vf
c3lzZnNfYWRkKCZpb21tdS0+aW9tbXUsIE5VTEwsCiAgCQkJCSAgICAgICBpbnRlbF9pb21tdV9n
cm91cHMsCiAgCQkJCSAgICAgICAiJXMiLCBpb21tdS0+bmFtZSk7CmRpZmYgLS1naXQgYS9kcml2
ZXJzL2lvbW11L2lvbW11LmMgYi9kcml2ZXJzL2lvbW11L2lvbW11LmMKaW5kZXggNjBiMWVjNDJl
NzNiLi4xNDM0YmVlNjRhZjMgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvaW9tbXUvaW9tbXUuYworKysg
Yi9kcml2ZXJzL2lvbW11L2lvbW11LmMKQEAgLTM0OSwxMCArMzQ5LDE0IEBAIHN0YXRpYyBpbnQg
X19pbml0IGlvbW11X2RtYV9zZXR1cChjaGFyICpzdHIpCiAgfQogIGVhcmx5X3BhcmFtKCJpb21t
dS5zdHJpY3QiLCBpb21tdV9kbWFfc2V0dXApOwoKLXZvaWQgaW9tbXVfc2V0X2RtYV9zdHJpY3Qo
Ym9vbCBzdHJpY3QpCisvKiBSZXR1cm4gdHJ1ZSBpZiB3ZSBzZXQgaW9tbXVfZG1hX3N0cmljdCAq
LworYm9vbCBpb21tdV9zZXRfZG1hX3N0cmljdChib29sIGZvcmNlKQogIHsKLQlpZiAoc3RyaWN0
IHx8ICEoaW9tbXVfY21kX2xpbmUgJiBJT01NVV9DTURfTElORV9TVFJJQ1QpKQotCQlpb21tdV9k
bWFfc3RyaWN0ID0gc3RyaWN0OworCWlmIChmb3JjZSB8fCAhKGlvbW11X2NtZF9saW5lICYgSU9N
TVVfQ01EX0xJTkVfU1RSSUNUKSkgeworCQlpb21tdV9kbWFfc3RyaWN0ID0gdHJ1ZTsKKwkJcmV0
dXJuIHRydWU7CisJfQorCXJldHVybiBmYWxzZTsKICB9CgogIGJvb2wgaW9tbXVfZ2V0X2RtYV9z
dHJpY3Qoc3RydWN0IGlvbW11X2RvbWFpbiAqZG9tYWluKQpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9s
aW51eC9pb21tdS5oIGIvaW5jbHVkZS9saW51eC9pb21tdS5oCmluZGV4IDMyZDQ0ODA1MGJmNy4u
ZjE3YjIwMjM0Mjk2IDEwMDY0NAotLS0gYS9pbmNsdWRlL2xpbnV4L2lvbW11LmgKKysrIGIvaW5j
bHVkZS9saW51eC9pb21tdS5oCkBAIC00NzYsNyArNDc2LDcgQEAgaW50IGlvbW11X2VuYWJsZV9u
ZXN0aW5nKHN0cnVjdCBpb21tdV9kb21haW4gKmRvbWFpbik7CiAgaW50IGlvbW11X3NldF9wZ3Rh
YmxlX3F1aXJrcyhzdHJ1Y3QgaW9tbXVfZG9tYWluICpkb21haW4sCiAgCQl1bnNpZ25lZCBsb25n
IHF1aXJrcyk7Cgotdm9pZCBpb21tdV9zZXRfZG1hX3N0cmljdChib29sIHZhbCk7Citib29sIGlv
bW11X3NldF9kbWFfc3RyaWN0KGJvb2wgZm9yY2UpOwogIGJvb2wgaW9tbXVfZ2V0X2RtYV9zdHJp
Y3Qoc3RydWN0IGlvbW11X2RvbWFpbiAqZG9tYWluKTsKCiAgZXh0ZXJuIGludCByZXBvcnRfaW9t
bXVfZmF1bHQoc3RydWN0IGlvbW11X2RvbWFpbiAqZG9tYWluLCBzdHJ1Y3QgCmRldmljZSAqZGV2
LAotLSAKMi4yNi4yCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpo
dHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
