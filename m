Return-Path: <SRS0=Ta7z=LP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_RED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22165C4743C
	for <iommu@archiver.kernel.org>; Mon, 21 Jun 2021 12:15:26 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B25F961042
	for <iommu@archiver.kernel.org>; Mon, 21 Jun 2021 12:15:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B25F961042
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 78079402E2;
	Mon, 21 Jun 2021 12:15:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1fCBfYNvLs0y; Mon, 21 Jun 2021 12:15:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 04AEB401FA;
	Mon, 21 Jun 2021 12:15:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CC1EAC000E;
	Mon, 21 Jun 2021 12:15:23 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5F404C000C
 for <iommu@lists.linux-foundation.org>; Mon, 21 Jun 2021 12:15:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4CD18402E2
 for <iommu@lists.linux-foundation.org>; Mon, 21 Jun 2021 12:15:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EFLB3o4k2AVq for <iommu@lists.linux-foundation.org>;
 Mon, 21 Jun 2021 12:15:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5A844401FA
 for <iommu@lists.linux-foundation.org>; Mon, 21 Jun 2021 12:15:20 +0000 (UTC)
Received: from fraeml741-chm.china.huawei.com (unknown [172.18.147.200])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4G7pFW27Qbz6FBVY;
 Mon, 21 Jun 2021 20:07:59 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml741-chm.china.huawei.com (10.206.15.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 21 Jun 2021 14:15:17 +0200
Received: from [10.47.93.67] (10.47.93.67) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Mon, 21 Jun
 2021 13:15:16 +0100
Subject: Re: [PATCH v14 6/6] iommu: Remove mode argument from
 iommu_set_dma_strict()
To: Robin Murphy <robin.murphy@arm.com>, Lu Baolu <baolu.lu@linux.intel.com>, 
 "joro@8bytes.org" <joro@8bytes.org>, "will@kernel.org" <will@kernel.org>, 
 "dwmw2@infradead.org" <dwmw2@infradead.org>, "corbet@lwn.net"
 <corbet@lwn.net>
References: <1624016058-189713-1-git-send-email-john.garry@huawei.com>
 <1624016058-189713-7-git-send-email-john.garry@huawei.com>
 <c062ef9e-c106-4218-ba2a-c94fdcb6d955@linux.intel.com>
 <60bdd7c3-d73e-c005-ddf7-069bc5065bce@huawei.com>
 <855dd109-1449-7bc6-3d25-7ffeeeffa82a@linux.intel.com>
 <fc52069d-46c5-5ca5-1b44-2fa7cf287d5a@huawei.com>
 <2330bb52-1768-5122-9378-7923034c82bd@arm.com>
From: John Garry <john.garry@huawei.com>
Message-ID: <aaec67ab-0bb9-3c15-de81-97b92918c5c5@huawei.com>
Date: Mon, 21 Jun 2021 13:08:51 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <2330bb52-1768-5122-9378-7923034c82bd@arm.com>
Content-Language: en-US
X-Originating-IP: [10.47.93.67]
X-ClientProxiedBy: lhreml747-chm.china.huawei.com (10.201.108.197) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Cc: "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Linuxarm <linuxarm@huawei.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
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

T24gMjEvMDYvMjAyMSAxMjo1OSwgUm9iaW4gTXVycGh5IHdyb3RlOgoKKyBOYWRhdgoKPj4gT24g
YSBwZXJzb25hbCBsZXZlbCBJIHdvdWxkIGJlIGhhcHB5IHdpdGggdGhhdCBhcHByb2FjaCwgYnV0
IEkgdGhpbmsKPj4gaXQncyBiZXR0ZXIgdG8gbm90IHN0YXJ0IGNoYW5naW5nIHRoaW5ncyByaWdo
dCBhd2F5IGluIGEgZm9sbG93LXVwIHNlcmllcy4KPj4KPj4gU28gaG93IGFib3V0IHdlIGFkZCB0
aGlzIHBhdGNoICh3aGljaCByZXBsYWNlcyA2LzYgImlvbW11OiBSZW1vdmUgbW9kZQo+PiBhcmd1
bWVudCBmcm9tIGlvbW11X3NldF9kbWFfc3RyaWN0KCkiKT8KPj4KPj4gUm9iaW4sIGFueSBvcGlu
aW9uPwo+IEZvciBtZSBpdCBib2lscyBkb3duIHRvIHdoZXRoZXIgdGhlcmUgYXJlIGFueSByZWFs
aXN0aWMgd29ya2xvYWRzIHdoZXJlCj4gbm9uLXN0cmljdCBtb2RlKndvdWxkKiAgc3RpbGwgcGVy
Zm9ybSBiZXR0ZXIgdW5kZXIgdmlydHVhbGlzYXRpb24uIFRoZQo+IG9ubHkgcmVhc29uIGZvciB0
aGUgdXNlciB0byBleHBsaWNpdGx5IHBhc3MgImlvbW11LnN0cmljdD0wIiBpcyBiZWNhdXNlCj4g
dGhleSBleHBlY3QgaXQgdG8gaW5jcmVhc2UgdW5tYXAgcGVyZm9ybWFuY2U7IGlmIGl0J3Mgb25s
eSBldmVyIGdvaW5nIHRvCj4gbGVhZCB0byBhbiB1bmV4cGVjdGVkIHBlcmZvcm1hbmNlIGxvc3Ms
IEkgZG9uJ3Qgc2VlIGFueSB2YWx1ZSBpbgo+IG92ZXJyaWRpbmcgdGhlIGtlcm5lbCdzIGRlY2lz
aW9uIHB1cmVseSBmb3IgdGhlIHNha2Ugb2Ygc3Vic2VydmllbmNlLgo+IAo+IElmIHRoZXJlKmFy
ZSogIGNlcnRhaW4gdmFsaWQgY2FzZXMgZm9yIGFsbG93aW5nIGl0IGZvciBwZW9wbGUgd2hvIHJl
YWxseQo+IGtub3cgd2hhdCB0aGV5J3JlIGRvaW5nLCB0aGVuIHdlIHNob3VsZCBhcmd1YWJseSBh
bHNvIGxvZyBhIGNvdW50ZXJwYXJ0Cj4gbWVzc2FnZSB0byBzYXkgIndlJ3JlIGhvbm91cmluZyB5
b3VyIG92ZXJyaWRlIGJ1dCBiZXdhcmUgaXQgbWF5IGhhdmUgdGhlCj4gb3Bwb3NpdGUgZWZmZWN0
IHRvIHdoYXQgeW91IGV4cGVjdCIgZm9yIHRoZSBiZW5lZml0IG9mIG90aGVyIHVzZXJzIHdobwo+
IGFzc3VtZSBpdCdzIGEgZ2VuZXJpYyBnby1mYXN0ZXIga25vYi4gQXQgdGhhdCBwb2ludCBpdCBz
dGFydHMgZ2V0dGluZwo+IG5vbi10cml2aWFsIGVub3VnaCB0aGF0IEknZCB3YW50IHRvIGtub3cg
Zm9yIHN1cmUgaXQncyB3b3J0aHdoaWxlLgo+IAo+IFRoZSBvdGhlciByZWFzb24gdGhpcyBtaWdo
dCBiZSBiZXR0ZXIgdG8gcmV2aXNpdCBsYXRlciBpcyB0aGF0IGFuIEFNRAo+IGVxdWl2YWxlbnQg
aXMgc3RpbGwgaW4gZmxpZ2h0WzFdLCBhbmQgdGhlcmUgbWlnaHQgYmUgbW9yZSB0aGF0IGNhbgo+
IGV2ZW50dWFsbHkgYmUgZmFjdG9yZWQgb3V0LiBJIHRoaW5rIGJvdGggc2VyaWVzIGFyZSBwcmV0
dHkgbXVjaCBnb29kIHRvCj4gbWVyZ2UgZm9yIDUuMTQsIGJ1dCB0aW1lJ3MgYWxyZWFkeSB0aWdo
dCB0byBzb3J0IG91dCB0aGUgY29uZmxpY3RzIHdoaWNoCj4gZXhpc3QgYXMtaXMsIHdpdGhvdXQg
bWFraW5nIHRoZW0gYW55IHdvcnNlLgoKb2ssIGZpbmUuIENhbiByZXZpc2l0LgoKQXMgZm9yIGdl
dHRpbmcgdGhlc2UgbWVyZ2VkLCBJJ2xsIGRyeS1ydW4gbWVyZ2luZyBib3RoIG9mIHRob3NlIHNl
cmllcyAKdG8gc2VlIHRoZSBjb25mbGljdHMuIEl0IGRvZXNuJ3QgbG9vayB0b28gcHJvYmxlbWF0
aWMgZnJvbSBhIGdsYW5jZS4KCkNoZWVycywKSm9obgoKPiAKPiBSb2Jpbi4KPiAKPiBbMV0KPiBo
dHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1pb21tdS8yMDIxMDYxNjEwMDUwMC4xNzQ1MDct
My1uYW1pdEB2bXdhcmUuY29tLwo+IAo+PiAtLS0tLS0tPjgtLS0tLS0tLS0KPj4KPj4gW1BBVENI
XSBpb21tdS92dC1kOiBNYWtlICJpb21tdS5zdHJpY3QiIG92ZXJyaWRlIGJhdGNoaW5nIGR1ZSB0
bwo+PiAgIMKgdmlydHVhbGl6YXRpb24KPj4KPj4gQXMgYSBjaGFuZ2UgaW4gcG9saWN5LCBtYWtl
IGlvbW11LnN0cmljdCBjbWRsaW5lIGFyZ3VtZW50IG92ZXJyaWRlCj4+IHdoZXRoZXIgd2UgZGlz
YWJsZSBiYXRjaGluZyBkdWUgdG8gdmlydHVhbGl6YXRpb24uCj4+Cj4+IFRoZSBBUEkgb2YgaW9t
bXVfc2V0X2RtYV9zdHJpY3QoKSBpcyBjaGFuZ2VkIHRvIGFjY2VwdCBhICJmb3JjZSIKPj4gYXJn
dW1lbnQsIHdoaWNoIG1lYW5zIHRoYXQgd2UgYWx3YXlzIHNldCBpb21tdV9kbWFfc3RyaWN0IHRy
dWUsCj4+IHJlZ2FyZGxlc3Mgb2Ygd2hldGhlciB3ZSBhbHJlYWR5IHNldCB2aWEgY21kbGluZS4g
QWxzbyByZXR1cm4gYSBib29sZWFuLAo+PiB0byB0ZWxsIHdoZXRoZXIgaW9tbXVfZG1hX3N0cmlj
dCB3YXMgc2V0IG9yIG5vdC4KPj4KPj4gTm90ZSB0aGF0IGluIGFsbCBwcmUtZXhpc3RpbmcgY2Fs
bHNpdGVzIG9mIGlvbW11X3NldF9kbWFfc3RyaWN0KCksCj4+IGFyZ3VtZW50IHN0cmljdCB3YXMg
dHJ1ZSwgc28gdGhpcyBhcmd1bWVudCBpcyBkcm9wcGVkLgo+Pgo+PiBTaWduZWQtb2ZmLWJ5OiBK
b2huIEdhcnJ5PGpvaG4uZ2FycnlAaHVhd2VpLmNvbT4KPj4KPj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvaW9tbXUvaW50ZWwvaW9tbXUuYyBiL2RyaXZlcnMvaW9tbXUvaW50ZWwvaW9tbXUuYwo+PiBp
bmRleCAwNjY2NmY5ZDgxMTYuLmU4ZDY1MjM5YjM1OSAxMDA2NDQKPj4gLS0tIGEvZHJpdmVycy9p
b21tdS9pbnRlbC9pb21tdS5jCj4+ICsrKyBiL2RyaXZlcnMvaW9tbXUvaW50ZWwvaW9tbXUuYwo+
PiBAQCAtNDM4MCwxMCArNDM4MCw4IEBAIGludCBfX2luaXQgaW50ZWxfaW9tbXVfaW5pdCh2b2lk
KQo+PiAgIMKgwqDCoMKgwqDCoMKgwqDCoCAqIGlzIGxpa2VseSB0byBiZSBtdWNoIGxvd2VyIHRo
YW4gdGhlIG92ZXJoZWFkIG9mIHN5bmNocm9uaXppbmcKPj4gICDCoMKgwqDCoMKgwqDCoMKgwqAg
KiB0aGUgdmlydHVhbCBhbmQgcGh5c2ljYWwgSU9NTVUgcGFnZS10YWJsZXMuCj4+ICAgwqDCoMKg
wqDCoMKgwqDCoMKgICovCj4+IC3CoMKgwqDCoMKgwqDCoCBpZiAoY2FwX2NhY2hpbmdfbW9kZShp
b21tdS0+Y2FwKSkgewo+PiArwqDCoMKgwqDCoMKgwqAgaWYgKGNhcF9jYWNoaW5nX21vZGUoaW9t
bXUtPmNhcCkgJiYgaW9tbXVfc2V0X2RtYV9zdHJpY3QoZmFsc2UpKQo+PiAgIMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBwcl9pbmZvX29uY2UoIklPTU1VIGJhdGNoaW5nIGRpc2FsbG93ZWQgZHVl
IHRvCj4+IHZpcnR1YWxpemF0aW9uXG4iKTsKPj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaW9t
bXVfc2V0X2RtYV9zdHJpY3QodHJ1ZSk7Cj4+IC3CoMKgwqDCoMKgwqDCoCB9Cj4+ICAgwqDCoMKg
wqDCoMKgwqDCoCBpb21tdV9kZXZpY2Vfc3lzZnNfYWRkKCZpb21tdS0+aW9tbXUsIE5VTEwsCj4+
ICAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpbnRlbF9p
b21tdV9ncm91cHMsCj4+ICAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCAiJXMiLCBpb21tdS0+bmFtZSk7Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11
L2lvbW11LmMgYi9kcml2ZXJzL2lvbW11L2lvbW11LmMKPj4gaW5kZXggNjBiMWVjNDJlNzNiLi4x
NDM0YmVlNjRhZjMgMTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMvaW9tbXUvaW9tbXUuYwo+PiArKysg
Yi9kcml2ZXJzL2lvbW11L2lvbW11LmMKPj4gQEAgLTM0OSwxMCArMzQ5LDE0IEBAIHN0YXRpYyBp
bnQgX19pbml0IGlvbW11X2RtYV9zZXR1cChjaGFyICpzdHIpCj4+ICAgwqB9Cj4+ICAgwqBlYXJs
eV9wYXJhbSgiaW9tbXUuc3RyaWN0IiwgaW9tbXVfZG1hX3NldHVwKTsKPj4KPj4gLXZvaWQgaW9t
bXVfc2V0X2RtYV9zdHJpY3QoYm9vbCBzdHJpY3QpCj4+ICsvKiBSZXR1cm4gdHJ1ZSBpZiB3ZSBz
ZXQgaW9tbXVfZG1hX3N0cmljdCAqLwo+PiArYm9vbCBpb21tdV9zZXRfZG1hX3N0cmljdChib29s
IGZvcmNlKQo+PiAgIMKgewo+PiAtwqDCoMKgIGlmIChzdHJpY3QgfHwgIShpb21tdV9jbWRfbGlu
ZSAmIElPTU1VX0NNRF9MSU5FX1NUUklDVCkpCj4+IC3CoMKgwqDCoMKgwqDCoCBpb21tdV9kbWFf
c3RyaWN0ID0gc3RyaWN0Owo+PiArwqDCoMKgIGlmIChmb3JjZSB8fCAhKGlvbW11X2NtZF9saW5l
ICYgSU9NTVVfQ01EX0xJTkVfU1RSSUNUKSkgewo+PiArwqDCoMKgwqDCoMKgwqAgaW9tbXVfZG1h
X3N0cmljdCA9IHRydWU7Cj4+ICvCoMKgwqDCoMKgwqDCoCByZXR1cm4gdHJ1ZTsKPj4gK8KgwqDC
oCB9Cj4+ICvCoMKgwqAgcmV0dXJuIGZhbHNlOwo+PiAgIMKgfQo+Pgo+PiAgIMKgYm9vbCBpb21t
dV9nZXRfZG1hX3N0cmljdChzdHJ1Y3QgaW9tbXVfZG9tYWluICpkb21haW4pCj4+IGRpZmYgLS1n
aXQgYS9pbmNsdWRlL2xpbnV4L2lvbW11LmggYi9pbmNsdWRlL2xpbnV4L2lvbW11LmgKPj4gaW5k
ZXggMzJkNDQ4MDUwYmY3Li5mMTdiMjAyMzQyOTYgMTAwNjQ0Cj4+IC0tLSBhL2luY2x1ZGUvbGlu
dXgvaW9tbXUuaAo+PiArKysgYi9pbmNsdWRlL2xpbnV4L2lvbW11LmgKPj4gQEAgLTQ3Niw3ICs0
NzYsNyBAQCBpbnQgaW9tbXVfZW5hYmxlX25lc3Rpbmcoc3RydWN0IGlvbW11X2RvbWFpbiAqZG9t
YWluKTsKPj4gICDCoGludCBpb21tdV9zZXRfcGd0YWJsZV9xdWlya3Moc3RydWN0IGlvbW11X2Rv
bWFpbiAqZG9tYWluLAo+PiAgIMKgwqDCoMKgwqDCoMKgwqAgdW5zaWduZWQgbG9uZyBxdWlya3Mp
Owo+Pgo+PiAtdm9pZCBpb21tdV9zZXRfZG1hX3N0cmljdChib29sIHZhbCk7Cj4+ICtib29sIGlv
bW11X3NldF9kbWFfc3RyaWN0KGJvb2wgZm9yY2UpOwo+PiAgIMKgYm9vbCBpb21tdV9nZXRfZG1h
X3N0cmljdChzdHJ1Y3QgaW9tbXVfZG9tYWluICpkb21haW4pOwo+Pgo+PiAgIMKgZXh0ZXJuIGlu
dCByZXBvcnRfaW9tbXVfZmF1bHQoc3RydWN0IGlvbW11X2RvbWFpbiAqZG9tYWluLCBzdHJ1Y3QK
Pj4gZGV2aWNlICpkZXYsCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5v
cmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9t
bXU=
