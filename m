Return-Path: <SRS0=1cKf=HA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD67EC433DB
	for <iommu@archiver.kernel.org>; Fri, 29 Jan 2021 12:44:54 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33E9A64E0F
	for <iommu@archiver.kernel.org>; Fri, 29 Jan 2021 12:44:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33E9A64E0F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id C8A1E8698B;
	Fri, 29 Jan 2021 12:44:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zUAYlwOWZyOk; Fri, 29 Jan 2021 12:44:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 534748698F;
	Fri, 29 Jan 2021 12:44:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3C174C0FA7;
	Fri, 29 Jan 2021 12:44:52 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CC815C013A
 for <iommu@lists.linux-foundation.org>; Fri, 29 Jan 2021 12:44:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id AC44A204E6
 for <iommu@lists.linux-foundation.org>; Fri, 29 Jan 2021 12:44:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TUpytxs03jBl for <iommu@lists.linux-foundation.org>;
 Fri, 29 Jan 2021 12:44:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
 by silver.osuosl.org (Postfix) with ESMTPS id A8DE4204E0
 for <iommu@lists.linux-foundation.org>; Fri, 29 Jan 2021 12:43:47 +0000 (UTC)
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
 by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DRxmv1t5wzMRn6;
 Fri, 29 Jan 2021 20:42:07 +0800 (CST)
Received: from [127.0.0.1] (10.40.193.166) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.498.0; Fri, 29 Jan 2021
 20:43:35 +0800
Subject: Re: [PATCH 1/1] Revert "iommu/iova: Retry from last rb tree node if
 iova search fails"
To: Robin Murphy <robin.murphy@arm.com>, "Leizhen (ThunderTown)"
 <thunder.leizhen@huawei.com>, Will Deacon <will@kernel.org>, Joerg Roedel
 <joro@8bytes.org>, iommu <iommu@lists.linux-foundation.org>, linux-kernel
 <linux-kernel@vger.kernel.org>
References: <20210129092120.1482-1-thunder.leizhen@huawei.com>
 <5505b1e5-2450-d5c4-6d77-5bb21fd0b6a1@huawei.com>
 <e8ff095f-7b7c-da38-3675-cd3c1ee84b1a@arm.com>
From: "chenxiang (M)" <chenxiang66@hisilicon.com>
Message-ID: <afda715d-dd7b-c6eb-be64-e4a09999b003@hisilicon.com>
Date: Fri, 29 Jan 2021 20:43:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <e8ff095f-7b7c-da38-3675-cd3c1ee84b1a@arm.com>
X-Originating-IP: [10.40.193.166]
X-CFilter-Loop: Reflected
Cc: Vijayanand Jitta <vjitta@codeaurora.org>
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

SGkgUm9iaW4sCgoK5ZyoIDIwMjEvMS8yOSAyMDowMywgUm9iaW4gTXVycGh5IOWGmemBkzoKPiBP
biAyMDIxLTAxLTI5IDA5OjQ4LCBMZWl6aGVuIChUaHVuZGVyVG93bikgd3JvdGU6Cj4+Cj4+IEN1
cnJlbnRseSwgd2UgYXJlIHRoaW5raW5nIGFib3V0IHRoZSBzb2x1dGlvbiB0byB0aGUgcHJvYmxl
bS4gCj4+IEhvd2V2ZXIsIGJlY2F1c2UgdGhlIGVuZCB0aW1lIG9mIHY1LjExIGlzIGFwcHJvYWNo
aW5nLCB0aGlzIHBhdGNoIGlzIAo+PiBzZW50IGZpcnN0Lgo+Cj4gSG93ZXZlciwgdGhhdCBjb21t
aXQgd2FzIG1hZGUgZm9yIGEgcmVhc29uIC0gaG93IGRvIHdlIGp1c3RpZnkgdGhhdCAKPiBvbmUg
dGhpbmcgYmVpbmcgc2xvdyBpcyBtb3JlIGltcG9ydGFudCB0aGFuIGFub3RoZXIgdGhpbmcgYmVp
bmcgCj4gY29tcGxldGVseSBicm9rZW4/IEl0J3Mgbm90IHByYWN0aWNhbCB0byBqdXN0IGtlZXAg
ZG9pbmcgdGhlIHBhdGNoIAo+IGhva2V5LWNva2V5IGJhc2VkIG9uIHdob2V2ZXIgc2hvdXRzIGxv
dWRlc3QgOigKPgo+PiBPbiAyMDIxLzEvMjkgMTc6MjEsIFpoZW4gTGVpIHdyb3RlOgo+Pj4gVGhp
cyByZXZlcnRzIGNvbW1pdCA0ZTg5ZGNlNzI1MjEzZDNkMGIwNDc1MjExYjUwMGVkYTRlZjRiZjJm
Lgo+Pj4KPj4+IFdlIGZpbmQgdGhhdCB0aGlzIHBhdGNoIGhhcyBhIGdyZWF0IGltcGFjdCBvbiBw
ZXJmb3JtYW5jZS4gQWNjb3JkaW5nIHRvCj4+PiBvdXIgdGVzdDogdGhlIGlvcHMgZGVjcmVhc2Vz
IGZyb20gMTY1NS42SyB0byA4OTMuNUssIGFib3V0IGhhbGYuCj4+Pgo+Pj4gSGFyZHdhcmU6IDEg
U0FTIGV4cGFuZGVyIHdpdGggMTIgU0FTIFNTRAo+Pj4gQ29tbWFuZDogIE9ubHkgdGhlIG1haW4g
cGFyYW1ldGVycyBhcmUgbGlzdGVkLgo+Pj4gICAgICAgICAgICBmaW8gYnM9NGsgcnc9cmVhZCBp
b2RlcHRoPTEyOCBjcHVzX2FsbG93ZWQ9MC0xMjcKPgo+IEZXSVcsIEknbSA5OSUgc3VyZSB0aGF0
IHdoYXQgeW91IHJlYWxseSB3YW50IGlzIFsxXSwgYnV0IHRoZW4geW91IGdldCAKPiB0byBiYXR0
bGUgYWdhaW5zdCBhbiB1bmtub3duIHF1YW50aXR5IG9mIGRvZGd5IGZpcm13YXJlIGluc3RlYWQu
Cj4KPiBSb2Jpbi4KPgo+IFsxXSAKPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1pb21t
dS9kNDEyYzI5MmQyMjJlYjM2NDY5ZWZmZDMzOGU5ODVmOWQ5ZTI0Y2Q2LjE1OTQyMDc2NzkuZ2l0
LnJvYmluLm11cnBoeUBhcm0uY29tLwoKVGhhbmsgeW91IGZvciBwb2ludGluZyB0aGF0IG91dC4g
SSBoYXZlIHRlc3RlZCBpdCwgYW5kIGl0IHNvbHZlcyB0aGUgCnBlcmZvcm1hbmNlIGRyb3AgaXNz
dWUgbWVudGlvbmVkIGFib3ZlLgpJIG5vdGljZWQgdGhhdCB5b3Ugc2VudCBpdCBKdWx5IDIwMjAs
IGFuZCBkbyB5b3UgaGF2ZSBhIHBsYW4gdG8gbWVyZ2UgaXQgCnJlY2VudGx5PwoKCj4KPj4+IEZp
eGVzOiA0ZTg5ZGNlNzI1MjEgKCJpb21tdS9pb3ZhOiBSZXRyeSBmcm9tIGxhc3QgcmIgdHJlZSBu
b2RlIGlmIAo+Pj4gaW92YSBzZWFyY2ggZmFpbHMiKQo+Pj4gVGVzdGVkLWJ5OiBYaWFuZyBDaGVu
IDxjaGVueGlhbmc2NkBoaXNpbGljb24uY29tPgo+Pj4gU2lnbmVkLW9mZi1ieTogWmhlbiBMZWkg
PHRodW5kZXIubGVpemhlbkBodWF3ZWkuY29tPgo+Pj4gLS0tCj4+PiAgIGRyaXZlcnMvaW9tbXUv
aW92YS5jIHwgMjMgKysrKysrLS0tLS0tLS0tLS0tLS0tLS0KPj4+ICAgMSBmaWxlIGNoYW5nZWQs
IDYgaW5zZXJ0aW9ucygrKSwgMTcgZGVsZXRpb25zKC0pCj4+Pgo+Pj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvaW9tbXUvaW92YS5jIGIvZHJpdmVycy9pb21tdS9pb3ZhLmMKPj4+IGluZGV4IGQyMGI4
YjMzM2QzMGQxNy4uZjg0MGM3MjA3ZWZiY2VkIDEwMDY0NAo+Pj4gLS0tIGEvZHJpdmVycy9pb21t
dS9pb3ZhLmMKPj4+ICsrKyBiL2RyaXZlcnMvaW9tbXUvaW92YS5jCj4+PiBAQCAtMTg1LDkgKzE4
NSw4IEBAIHN0YXRpYyBpbnQgX19hbGxvY19hbmRfaW5zZXJ0X2lvdmFfcmFuZ2Uoc3RydWN0IAo+
Pj4gaW92YV9kb21haW4gKmlvdmFkLAo+Pj4gICAgICAgc3RydWN0IHJiX25vZGUgKmN1cnIsICpw
cmV2Owo+Pj4gICAgICAgc3RydWN0IGlvdmEgKmN1cnJfaW92YTsKPj4+ICAgICAgIHVuc2lnbmVk
IGxvbmcgZmxhZ3M7Cj4+PiAtICAgIHVuc2lnbmVkIGxvbmcgbmV3X3BmbiwgcmV0cnlfcGZuOwo+
Pj4gKyAgICB1bnNpZ25lZCBsb25nIG5ld19wZm47Cj4+PiAgICAgICB1bnNpZ25lZCBsb25nIGFs
aWduX21hc2sgPSB+MFVMOwo+Pj4gLSAgICB1bnNpZ25lZCBsb25nIGhpZ2hfcGZuID0gbGltaXRf
cGZuLCBsb3dfcGZuID0gaW92YWQtPnN0YXJ0X3BmbjsKPj4+ICAgICAgICAgaWYgKHNpemVfYWxp
Z25lZCkKPj4+ICAgICAgICAgICBhbGlnbl9tYXNrIDw8PSBmbHNfbG9uZyhzaXplIC0gMSk7Cj4+
PiBAQCAtMjAwLDI1ICsxOTksMTUgQEAgc3RhdGljIGludCAKPj4+IF9fYWxsb2NfYW5kX2luc2Vy
dF9pb3ZhX3JhbmdlKHN0cnVjdCBpb3ZhX2RvbWFpbiAqaW92YWQsCj4+PiAgICAgICAgIGN1cnIg
PSBfX2dldF9jYWNoZWRfcmJub2RlKGlvdmFkLCBsaW1pdF9wZm4pOwo+Pj4gICAgICAgY3Vycl9p
b3ZhID0gcmJfZW50cnkoY3Vyciwgc3RydWN0IGlvdmEsIG5vZGUpOwo+Pj4gLSAgICByZXRyeV9w
Zm4gPSBjdXJyX2lvdmEtPnBmbl9oaSArIDE7Cj4+PiAtCj4+PiAtcmV0cnk6Cj4+PiAgICAgICBk
byB7Cj4+PiAtICAgICAgICBoaWdoX3BmbiA9IG1pbihoaWdoX3BmbiwgY3Vycl9pb3ZhLT5wZm5f
bG8pOwo+Pj4gLSAgICAgICAgbmV3X3BmbiA9IChoaWdoX3BmbiAtIHNpemUpICYgYWxpZ25fbWFz
azsKPj4+ICsgICAgICAgIGxpbWl0X3BmbiA9IG1pbihsaW1pdF9wZm4sIGN1cnJfaW92YS0+cGZu
X2xvKTsKPj4+ICsgICAgICAgIG5ld19wZm4gPSAobGltaXRfcGZuIC0gc2l6ZSkgJiBhbGlnbl9t
YXNrOwo+Pj4gICAgICAgICAgIHByZXYgPSBjdXJyOwo+Pj4gICAgICAgICAgIGN1cnIgPSByYl9w
cmV2KGN1cnIpOwo+Pj4gICAgICAgICAgIGN1cnJfaW92YSA9IHJiX2VudHJ5KGN1cnIsIHN0cnVj
dCBpb3ZhLCBub2RlKTsKPj4+IC0gICAgfSB3aGlsZSAoY3VyciAmJiBuZXdfcGZuIDw9IGN1cnJf
aW92YS0+cGZuX2hpICYmIG5ld19wZm4gPj0gCj4+PiBsb3dfcGZuKTsKPj4+IC0KPj4+IC0gICAg
aWYgKGhpZ2hfcGZuIDwgc2l6ZSB8fCBuZXdfcGZuIDwgbG93X3Bmbikgewo+Pj4gLSAgICAgICAg
aWYgKGxvd19wZm4gPT0gaW92YWQtPnN0YXJ0X3BmbiAmJiByZXRyeV9wZm4gPCBsaW1pdF9wZm4p
IHsKPj4+IC0gICAgICAgICAgICBoaWdoX3BmbiA9IGxpbWl0X3BmbjsKPj4+IC0gICAgICAgICAg
ICBsb3dfcGZuID0gcmV0cnlfcGZuOwo+Pj4gLSAgICAgICAgICAgIGN1cnIgPSAmaW92YWQtPmFu
Y2hvci5ub2RlOwo+Pj4gLSAgICAgICAgICAgIGN1cnJfaW92YSA9IHJiX2VudHJ5KGN1cnIsIHN0
cnVjdCBpb3ZhLCBub2RlKTsKPj4+IC0gICAgICAgICAgICBnb3RvIHJldHJ5Owo+Pj4gLSAgICAg
ICAgfQo+Pj4gKyAgICB9IHdoaWxlIChjdXJyICYmIG5ld19wZm4gPD0gY3Vycl9pb3ZhLT5wZm5f
aGkpOwo+Pj4gKwo+Pj4gKyAgICBpZiAobGltaXRfcGZuIDwgc2l6ZSB8fCBuZXdfcGZuIDwgaW92
YWQtPnN0YXJ0X3Bmbikgewo+Pj4gICAgICAgICAgIGlvdmFkLT5tYXgzMl9hbGxvY19zaXplID0g
c2l6ZTsKPj4+ICAgICAgICAgICBnb3RvIGlvdmEzMl9mdWxsOwo+Pj4gICAgICAgfQo+Pj4KPj4K
Pgo+IC4KPgoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRw
czovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
