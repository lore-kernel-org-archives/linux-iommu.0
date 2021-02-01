Return-Path: <SRS0=Rmex=HD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1816FC433E0
	for <iommu@archiver.kernel.org>; Mon,  1 Feb 2021 13:10:45 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9693564EA5
	for <iommu@archiver.kernel.org>; Mon,  1 Feb 2021 13:10:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9693564EA5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 6A2F385D41;
	Mon,  1 Feb 2021 13:10:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OZYKVaOop_KQ; Mon,  1 Feb 2021 13:10:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id DD3A384AE2;
	Mon,  1 Feb 2021 13:10:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BF82CC0174;
	Mon,  1 Feb 2021 13:10:41 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 83929C013A
 for <iommu@lists.linux-foundation.org>; Mon,  1 Feb 2021 13:10:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 6D7BB858F7
 for <iommu@lists.linux-foundation.org>; Mon,  1 Feb 2021 13:10:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nG8NWF7DKWMe for <iommu@lists.linux-foundation.org>;
 Mon,  1 Feb 2021 13:10:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 2E21884AE2
 for <iommu@lists.linux-foundation.org>; Mon,  1 Feb 2021 13:10:38 +0000 (UTC)
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
 by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DTpDN2p5dzlF09;
 Mon,  1 Feb 2021 21:08:52 +0800 (CST)
Received: from [127.0.0.1] (10.174.176.220) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.498.0;
 Mon, 1 Feb 2021 21:10:21 +0800
Subject: Re: [PATCH v4 1/2] perf/smmuv3: Don't reserve the PMCG register spaces
To: Will Deacon <will@kernel.org>
References: <20210130071414.1575-1-thunder.leizhen@huawei.com>
 <20210130071414.1575-2-thunder.leizhen@huawei.com>
 <20210201125412.GA14772@willie-the-truck>
From: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <c69665cc-2804-7984-ef2d-b8602965a605@huawei.com>
Date: Mon, 1 Feb 2021 21:10:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20210201125412.GA14772@willie-the-truck>
Content-Language: en-US
X-Originating-IP: [10.174.176.220]
X-CFilter-Loop: Reflected
Cc: Mark Rutland <mark.rutland@arm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 iommu <iommu@lists.linux-foundation.org>, Robin Murphy <robin.murphy@arm.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
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

CgpPbiAyMDIxLzIvMSAyMDo1NCwgV2lsbCBEZWFjb24gd3JvdGU6Cj4gT24gU2F0LCBKYW4gMzAs
IDIwMjEgYXQgMDM6MTQ6MTNQTSArMDgwMCwgWmhlbiBMZWkgd3JvdGU6Cj4+IEFjY29yZGluZyB0
byB0aGUgU01NVXYzIHNwZWNpZmljYXRpb246Cj4+IEVhY2ggUE1DRyBjb3VudGVyIGdyb3VwIGlz
IHJlcHJlc2VudGVkIGJ5IG9uZSA0S0IgcGFnZSAoUGFnZSAwKSB3aXRoIG9uZQo+PiBvcHRpb25h
bCBhZGRpdGlvbmFsIDRLQiBwYWdlIChQYWdlIDEpLCBib3RoIG9mIHdoaWNoIGFyZSBhdCBJTVBM
RU1FTlRBVElPTgo+PiBERUZJTkVEIGJhc2UgYWRkcmVzc2VzLgo+Pgo+PiBUaGlzIG1lYW5zIHRo
YXQgdGhlIFBNQ0cgcmVnaXN0ZXIgc3BhY2VzIG1heSBiZSB3aXRoaW4gdGhlIDY0S0IgcGFnZXMg
b2YKPj4gdGhlIFNNTVV2MyByZWdpc3RlciBzcGFjZS4gV2hlbiBib3RoIHRoZSBTTU1VIGFuZCBQ
TUNHIGRyaXZlcnMgcmVzZXJ2ZQo+PiB0aGVpciBvd24gcmVzb3VyY2VzLCBhIHJlc291cmNlIGNv
bmZsaWN0IG9jY3Vycy4KPj4KPj4gVG8gYXZvaWQgdGhpcyBjb25mbGljdCwgZG9uJ3QgcmVzZXJ2
ZSB0aGUgUE1DRyByZWdpb25zLgo+Pgo+PiBTdWdnZXN0ZWQtYnk6IFJvYmluIE11cnBoeSA8cm9i
aW4ubXVycGh5QGFybS5jb20+Cj4+IFNpZ25lZC1vZmYtYnk6IFpoZW4gTGVpIDx0aHVuZGVyLmxl
aXpoZW5AaHVhd2VpLmNvbT4KPj4gLS0tCj4+ICBkcml2ZXJzL3BlcmYvYXJtX3NtbXV2M19wbXUu
YyB8IDI1ICsrKysrKysrKysrKysrKysrKystLS0tLS0KPj4gIDEgZmlsZSBjaGFuZ2VkLCAxOSBp
bnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQo+Pgo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9w
ZXJmL2FybV9zbW11djNfcG11LmMgYi9kcml2ZXJzL3BlcmYvYXJtX3NtbXV2M19wbXUuYwo+PiBp
bmRleCA3NDQ3NGJiMzIyYzNmMjYuLjVlODk0Zjk1N2M3YjkzNSAxMDA2NDQKPj4gLS0tIGEvZHJp
dmVycy9wZXJmL2FybV9zbW11djNfcG11LmMKPj4gKysrIGIvZHJpdmVycy9wZXJmL2FybV9zbW11
djNfcG11LmMKPj4gQEAgLTc5MywxNyArNzkzLDMwIEBAIHN0YXRpYyBpbnQgc21tdV9wbXVfcHJv
YmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikKPj4gIAkJLmNhcGFiaWxpdGllcwk9IFBF
UkZfUE1VX0NBUF9OT19FWENMVURFLAo+PiAgCX07Cj4+ICAKPj4gLQlzbW11X3BtdS0+cmVnX2Jh
c2UgPSBkZXZtX3BsYXRmb3JtX2dldF9hbmRfaW9yZW1hcF9yZXNvdXJjZShwZGV2LCAwLCAmcmVz
XzApOwo+PiAtCWlmIChJU19FUlIoc21tdV9wbXUtPnJlZ19iYXNlKSkKPj4gLQkJcmV0dXJuIFBU
Ul9FUlIoc21tdV9wbXUtPnJlZ19iYXNlKTsKPj4gKwkvKgo+PiArCSAqIFRoZSByZWdpc3RlciBz
cGFjZXMgb2YgdGhlIFBNQ0cgbWF5IGJlIGluIHRoZSByZWdpc3RlciBzcGFjZSBvZgo+PiArCSAq
IG90aGVyIGRldmljZXMuIEZvciBleGFtcGxlLCBTTU1VLiBUaGVyZWZvcmUsIHRoZSBQTUNHIHJl
c291cmNlcyBhcmUKPj4gKwkgKiBub3QgcmVzZXJ2ZWQgdG8gYXZvaWQgcmVzb3VyY2UgY29uZmxp
Y3RzIHdpdGggb3RoZXIgZHJpdmVycy4KPj4gKwkgKi8KPj4gKwlyZXNfMCA9IHBsYXRmb3JtX2dl
dF9yZXNvdXJjZShwZGV2LCBJT1JFU09VUkNFX01FTSwgMCk7Cj4+ICsJaWYgKCFyZXNfMCkKPj4g
KwkJcmV0dXJuIEVSUl9QVFIoLUVJTlZBTCk7Cj4gCj4gSSB0cmllZCB0byBhcHBseSB0aGlzLCBi
dXQgeW91J3ZlIGdvdCB5b3VyIHJldHVybiB0eXBlIGluIGEgbXVkZGxlOgoKSSdtIGRpenp5LiBJ
IGRvbid0IGtub3cgaG93IHRoaXMgYnVnIHBhdGNoIGNhbWUgb3V0LiBJIGp1c3QgcGluY2hlZCBt
eSBsZWcsIGxpa2UgSSdtIHN0aWxsIGluIHRoZSByZWFsIHdvcmxkLgoKVGhlICJFUlJfUFRSKCki
IG9mIHRoZSBmb3VyIEVSUl9QVFIoeHh4KSBzaG91bGQgYmUgcmVtb3ZlZC4gQ2FuIHlvdSBoZWxw
IG1lPyBPciBJIHNlbmQgYSBuZXcgb25lLgoKPiAKPiBAQCBAQAo+ICtkcml2ZXJzL3BlcmYvYXJt
X3NtbXV2M19wbXUuYzogSW4gZnVuY3Rpb24g4oCYc21tdV9wbXVfcHJvYmXigJk6Cj4gK2RyaXZl
cnMvcGVyZi9hcm1fc21tdXYzX3BtdS5jOjgwMzoxMDogd2FybmluZzogcmV0dXJuaW5nIOKAmHZv
aWQgKuKAmSBmcm9tIGEgZnVuY3Rpb24gd2l0aCByZXR1cm4gdHlwZSDigJhpbnTigJkgbWFrZXMg
aW50ZWdlciBmcm9tIHBvaW50ZXIgd2l0aG91dCBhIGNhc3QgWy1XaW50LWNvbnZlcnNpb25dCj4g
KyAgODAzIHwgICByZXR1cm4gRVJSX1BUUigtRUlOVkFMKTsKPiArICAgICAgfCAgICAgICAgICBe
fn5+fn5+fn5+fn5+fn5+Cj4gK2RyaXZlcnMvcGVyZi9hcm1fc21tdXYzX3BtdS5jOjgwMzozMTog
d2FybmluZzogaW5jb3JyZWN0IHR5cGUgaW4gcmV0dXJuIGV4cHJlc3Npb24gKGRpZmZlcmVudCBi
YXNlIHR5cGVzKSBbc3BhcnNlXQo+ICtkcml2ZXJzL3BlcmYvYXJtX3NtbXV2M19wbXUuYzo4MDM6
MzE6ICAgIGV4cGVjdGVkIGludCBbc3BhcnNlXQo+ICtkcml2ZXJzL3BlcmYvYXJtX3NtbXV2M19w
bXUuYzo4MDM6MzE6ICAgIGdvdCB2b2lkICogW3NwYXJzZV0KPiArZHJpdmVycy9wZXJmL2FybV9z
bW11djNfcG11LmM6ODA2OjEwOiB3YXJuaW5nOiByZXR1cm5pbmcg4oCYdm9pZCAq4oCZIGZyb20g
YSBmdW5jdGlvbiB3aXRoIHJldHVybiB0eXBlIOKAmGludOKAmSBtYWtlcyBpbnRlZ2VyIGZyb20g
cG9pbnRlciB3aXRob3V0IGEgY2FzdCBbLVdpbnQtY29udmVyc2lvbl0KPiArICA4MDYgfCAgIHJl
dHVybiBFUlJfUFRSKC1FTk9NRU0pOwo+ICsgICAgICB8ICAgICAgICAgIF5+fn5+fn5+fn5+fn5+
fn4KPiArZHJpdmVycy9wZXJmL2FybV9zbW11djNfcG11LmM6ODA2OjMxOiB3YXJuaW5nOiBpbmNv
cnJlY3QgdHlwZSBpbiByZXR1cm4gZXhwcmVzc2lvbiAoZGlmZmVyZW50IGJhc2UgdHlwZXMpIFtz
cGFyc2VdCj4gK2RyaXZlcnMvcGVyZi9hcm1fc21tdXYzX3BtdS5jOjgwNjozMTogICAgZXhwZWN0
ZWQgaW50IFtzcGFyc2VdCj4gK2RyaXZlcnMvcGVyZi9hcm1fc21tdXYzX3BtdS5jOjgwNjozMTog
ICAgZ290IHZvaWQgKiBbc3BhcnNlXQo+ICtkcml2ZXJzL3BlcmYvYXJtX3NtbXV2M19wbXUuYzo4
MTY6MTE6IHdhcm5pbmc6IHJldHVybmluZyDigJh2b2lkICrigJkgZnJvbSBhIGZ1bmN0aW9uIHdp
dGggcmV0dXJuIHR5cGUg4oCYaW504oCZIG1ha2VzIGludGVnZXIgZnJvbSBwb2ludGVyIHdpdGhv
dXQgYSBjYXN0IFstV2ludC1jb252ZXJzaW9uXQo+ICsgIDgxNiB8ICAgIHJldHVybiBFUlJfUFRS
KC1FSU5WQUwpOwo+ICsgICAgICB8ICAgICAgICAgICBefn5+fn5+fn5+fn5+fn5+Cj4gK2RyaXZl
cnMvcGVyZi9hcm1fc21tdXYzX3BtdS5jOjgxNjozOTogd2FybmluZzogaW5jb3JyZWN0IHR5cGUg
aW4gcmV0dXJuIGV4cHJlc3Npb24gKGRpZmZlcmVudCBiYXNlIHR5cGVzKSBbc3BhcnNlXQo+ICtk
cml2ZXJzL3BlcmYvYXJtX3NtbXV2M19wbXUuYzo4MTY6Mzk6ICAgIGV4cGVjdGVkIGludCBbc3Bh
cnNlXQo+ICtkcml2ZXJzL3BlcmYvYXJtX3NtbXV2M19wbXUuYzo4MTY6Mzk6ICAgIGdvdCB2b2lk
ICogW3NwYXJzZV0KPiArZHJpdmVycy9wZXJmL2FybV9zbW11djNfcG11LmM6ODE5OjExOiB3YXJu
aW5nOiByZXR1cm5pbmcg4oCYdm9pZCAq4oCZIGZyb20gYSBmdW5jdGlvbiB3aXRoIHJldHVybiB0
eXBlIOKAmGludOKAmSBtYWtlcyBpbnRlZ2VyIGZyb20gcG9pbnRlciB3aXRob3V0IGEgY2FzdCBb
LVdpbnQtY29udmVyc2lvbl0KPiArICA4MTkgfCAgICByZXR1cm4gRVJSX1BUUigtRU5PTUVNKTsK
PiArICAgICAgfCAgICAgICAgICAgXn5+fn5+fn5+fn5+fn5+fgo+ICtkcml2ZXJzL3BlcmYvYXJt
X3NtbXV2M19wbXUuYzo4MTk6Mzk6IHdhcm5pbmc6IGluY29ycmVjdCB0eXBlIGluIHJldHVybiBl
eHByZXNzaW9uIChkaWZmZXJlbnQgYmFzZSB0eXBlcykgW3NwYXJzZV0KPiArZHJpdmVycy9wZXJm
L2FybV9zbW11djNfcG11LmM6ODE5OjM5OiAgICBleHBlY3RlZCBpbnQgW3NwYXJzZV0KPiArZHJp
dmVycy9wZXJmL2FybV9zbW11djNfcG11LmM6ODE5OjM5OiAgICBnb3Qgdm9pZCAqIFtzcGFyc2Vd
Cj4gCj4gV2lsbAo+IAo+IC4KPiAKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0
aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5m
by9pb21tdQ==
