Return-Path: <SRS0=Rmex=HD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 823FFC433E0
	for <iommu@archiver.kernel.org>; Mon,  1 Feb 2021 12:54:28 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E45E964EB8
	for <iommu@archiver.kernel.org>; Mon,  1 Feb 2021 12:54:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E45E964EB8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 24EF720441;
	Mon,  1 Feb 2021 12:54:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QGbXZJuwya49; Mon,  1 Feb 2021 12:54:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id F2E2C2042E;
	Mon,  1 Feb 2021 12:54:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D9413C0174;
	Mon,  1 Feb 2021 12:54:25 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D6608C013A
 for <iommu@lists.linux-foundation.org>; Mon,  1 Feb 2021 12:54:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 757412043D
 for <iommu@lists.linux-foundation.org>; Mon,  1 Feb 2021 12:54:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ze4+Xlnihf4T for <iommu@lists.linux-foundation.org>;
 Mon,  1 Feb 2021 12:54:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by silver.osuosl.org (Postfix) with ESMTPS id 180BD2042E
 for <iommu@lists.linux-foundation.org>; Mon,  1 Feb 2021 12:54:21 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id E064264EA5;
 Mon,  1 Feb 2021 12:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1612184060;
 bh=zWF+wd/PULo/VNVJQJXebEqy2S1k4Ep9nQ1G7TCUPGo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=p8uQwfyhxCKnCpl7YK40xhXOBD2Y6FXdga9DxkiUjzgICQ0zWinEap4SZs/wV0G90
 1fm+qS+22XjKt68W1uuH0RYjXouOEHtNH3Fq3du1OGc7tsuUdi676ysPDiLImnzUg5
 l1JKGMFvIyZpxl9LnBSx9A79LAtaKHC5JQfwNgc/8WPtrxOVCscHp1gXW4kIjqgP8E
 So86FU5DCiLrcK4rsNy0ufqeghDr5/2HFDHex5QaZlirsO3mCDRD8ug5G2AgLJ3ECE
 H02kHxC/J9rtlq9VyhUE7DPfqcpKroRyWUIeDOb2vZDf2ivNWHcy+EFQC6ZaL63OZh
 721NsBB9E96RQ==
Date: Mon, 1 Feb 2021 12:54:12 +0000
From: Will Deacon <will@kernel.org>
To: Zhen Lei <thunder.leizhen@huawei.com>
Subject: Re: [PATCH v4 1/2] perf/smmuv3: Don't reserve the PMCG register spaces
Message-ID: <20210201125412.GA14772@willie-the-truck>
References: <20210130071414.1575-1-thunder.leizhen@huawei.com>
 <20210130071414.1575-2-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210130071414.1575-2-thunder.leizhen@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
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

T24gU2F0LCBKYW4gMzAsIDIwMjEgYXQgMDM6MTQ6MTNQTSArMDgwMCwgWmhlbiBMZWkgd3JvdGU6
Cj4gQWNjb3JkaW5nIHRvIHRoZSBTTU1VdjMgc3BlY2lmaWNhdGlvbjoKPiBFYWNoIFBNQ0cgY291
bnRlciBncm91cCBpcyByZXByZXNlbnRlZCBieSBvbmUgNEtCIHBhZ2UgKFBhZ2UgMCkgd2l0aCBv
bmUKPiBvcHRpb25hbCBhZGRpdGlvbmFsIDRLQiBwYWdlIChQYWdlIDEpLCBib3RoIG9mIHdoaWNo
IGFyZSBhdCBJTVBMRU1FTlRBVElPTgo+IERFRklORUQgYmFzZSBhZGRyZXNzZXMuCj4gCj4gVGhp
cyBtZWFucyB0aGF0IHRoZSBQTUNHIHJlZ2lzdGVyIHNwYWNlcyBtYXkgYmUgd2l0aGluIHRoZSA2
NEtCIHBhZ2VzIG9mCj4gdGhlIFNNTVV2MyByZWdpc3RlciBzcGFjZS4gV2hlbiBib3RoIHRoZSBT
TU1VIGFuZCBQTUNHIGRyaXZlcnMgcmVzZXJ2ZQo+IHRoZWlyIG93biByZXNvdXJjZXMsIGEgcmVz
b3VyY2UgY29uZmxpY3Qgb2NjdXJzLgo+IAo+IFRvIGF2b2lkIHRoaXMgY29uZmxpY3QsIGRvbid0
IHJlc2VydmUgdGhlIFBNQ0cgcmVnaW9ucy4KPiAKPiBTdWdnZXN0ZWQtYnk6IFJvYmluIE11cnBo
eSA8cm9iaW4ubXVycGh5QGFybS5jb20+Cj4gU2lnbmVkLW9mZi1ieTogWmhlbiBMZWkgPHRodW5k
ZXIubGVpemhlbkBodWF3ZWkuY29tPgo+IC0tLQo+ICBkcml2ZXJzL3BlcmYvYXJtX3NtbXV2M19w
bXUuYyB8IDI1ICsrKysrKysrKysrKysrKysrKystLS0tLS0KPiAgMSBmaWxlIGNoYW5nZWQsIDE5
IGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0pCj4gCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
cGVyZi9hcm1fc21tdXYzX3BtdS5jIGIvZHJpdmVycy9wZXJmL2FybV9zbW11djNfcG11LmMKPiBp
bmRleCA3NDQ3NGJiMzIyYzNmMjYuLjVlODk0Zjk1N2M3YjkzNSAxMDA2NDQKPiAtLS0gYS9kcml2
ZXJzL3BlcmYvYXJtX3NtbXV2M19wbXUuYwo+ICsrKyBiL2RyaXZlcnMvcGVyZi9hcm1fc21tdXYz
X3BtdS5jCj4gQEAgLTc5MywxNyArNzkzLDMwIEBAIHN0YXRpYyBpbnQgc21tdV9wbXVfcHJvYmUo
c3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikKPiAgCQkuY2FwYWJpbGl0aWVzCT0gUEVSRl9Q
TVVfQ0FQX05PX0VYQ0xVREUsCj4gIAl9Owo+ICAKPiAtCXNtbXVfcG11LT5yZWdfYmFzZSA9IGRl
dm1fcGxhdGZvcm1fZ2V0X2FuZF9pb3JlbWFwX3Jlc291cmNlKHBkZXYsIDAsICZyZXNfMCk7Cj4g
LQlpZiAoSVNfRVJSKHNtbXVfcG11LT5yZWdfYmFzZSkpCj4gLQkJcmV0dXJuIFBUUl9FUlIoc21t
dV9wbXUtPnJlZ19iYXNlKTsKPiArCS8qCj4gKwkgKiBUaGUgcmVnaXN0ZXIgc3BhY2VzIG9mIHRo
ZSBQTUNHIG1heSBiZSBpbiB0aGUgcmVnaXN0ZXIgc3BhY2Ugb2YKPiArCSAqIG90aGVyIGRldmlj
ZXMuIEZvciBleGFtcGxlLCBTTU1VLiBUaGVyZWZvcmUsIHRoZSBQTUNHIHJlc291cmNlcyBhcmUK
PiArCSAqIG5vdCByZXNlcnZlZCB0byBhdm9pZCByZXNvdXJjZSBjb25mbGljdHMgd2l0aCBvdGhl
ciBkcml2ZXJzLgo+ICsJICovCj4gKwlyZXNfMCA9IHBsYXRmb3JtX2dldF9yZXNvdXJjZShwZGV2
LCBJT1JFU09VUkNFX01FTSwgMCk7Cj4gKwlpZiAoIXJlc18wKQo+ICsJCXJldHVybiBFUlJfUFRS
KC1FSU5WQUwpOwoKSSB0cmllZCB0byBhcHBseSB0aGlzLCBidXQgeW91J3ZlIGdvdCB5b3VyIHJl
dHVybiB0eXBlIGluIGEgbXVkZGxlOgoKQEAgQEAKK2RyaXZlcnMvcGVyZi9hcm1fc21tdXYzX3Bt
dS5jOiBJbiBmdW5jdGlvbiDigJhzbW11X3BtdV9wcm9iZeKAmToKK2RyaXZlcnMvcGVyZi9hcm1f
c21tdXYzX3BtdS5jOjgwMzoxMDogd2FybmluZzogcmV0dXJuaW5nIOKAmHZvaWQgKuKAmSBmcm9t
IGEgZnVuY3Rpb24gd2l0aCByZXR1cm4gdHlwZSDigJhpbnTigJkgbWFrZXMgaW50ZWdlciBmcm9t
IHBvaW50ZXIgd2l0aG91dCBhIGNhc3QgWy1XaW50LWNvbnZlcnNpb25dCisgIDgwMyB8ICAgcmV0
dXJuIEVSUl9QVFIoLUVJTlZBTCk7CisgICAgICB8ICAgICAgICAgIF5+fn5+fn5+fn5+fn5+fn4K
K2RyaXZlcnMvcGVyZi9hcm1fc21tdXYzX3BtdS5jOjgwMzozMTogd2FybmluZzogaW5jb3JyZWN0
IHR5cGUgaW4gcmV0dXJuIGV4cHJlc3Npb24gKGRpZmZlcmVudCBiYXNlIHR5cGVzKSBbc3BhcnNl
XQorZHJpdmVycy9wZXJmL2FybV9zbW11djNfcG11LmM6ODAzOjMxOiAgICBleHBlY3RlZCBpbnQg
W3NwYXJzZV0KK2RyaXZlcnMvcGVyZi9hcm1fc21tdXYzX3BtdS5jOjgwMzozMTogICAgZ290IHZv
aWQgKiBbc3BhcnNlXQorZHJpdmVycy9wZXJmL2FybV9zbW11djNfcG11LmM6ODA2OjEwOiB3YXJu
aW5nOiByZXR1cm5pbmcg4oCYdm9pZCAq4oCZIGZyb20gYSBmdW5jdGlvbiB3aXRoIHJldHVybiB0
eXBlIOKAmGludOKAmSBtYWtlcyBpbnRlZ2VyIGZyb20gcG9pbnRlciB3aXRob3V0IGEgY2FzdCBb
LVdpbnQtY29udmVyc2lvbl0KKyAgODA2IHwgICByZXR1cm4gRVJSX1BUUigtRU5PTUVNKTsKKyAg
ICAgIHwgICAgICAgICAgXn5+fn5+fn5+fn5+fn5+fgorZHJpdmVycy9wZXJmL2FybV9zbW11djNf
cG11LmM6ODA2OjMxOiB3YXJuaW5nOiBpbmNvcnJlY3QgdHlwZSBpbiByZXR1cm4gZXhwcmVzc2lv
biAoZGlmZmVyZW50IGJhc2UgdHlwZXMpIFtzcGFyc2VdCitkcml2ZXJzL3BlcmYvYXJtX3NtbXV2
M19wbXUuYzo4MDY6MzE6ICAgIGV4cGVjdGVkIGludCBbc3BhcnNlXQorZHJpdmVycy9wZXJmL2Fy
bV9zbW11djNfcG11LmM6ODA2OjMxOiAgICBnb3Qgdm9pZCAqIFtzcGFyc2VdCitkcml2ZXJzL3Bl
cmYvYXJtX3NtbXV2M19wbXUuYzo4MTY6MTE6IHdhcm5pbmc6IHJldHVybmluZyDigJh2b2lkICri
gJkgZnJvbSBhIGZ1bmN0aW9uIHdpdGggcmV0dXJuIHR5cGUg4oCYaW504oCZIG1ha2VzIGludGVn
ZXIgZnJvbSBwb2ludGVyIHdpdGhvdXQgYSBjYXN0IFstV2ludC1jb252ZXJzaW9uXQorICA4MTYg
fCAgICByZXR1cm4gRVJSX1BUUigtRUlOVkFMKTsKKyAgICAgIHwgICAgICAgICAgIF5+fn5+fn5+
fn5+fn5+fn4KK2RyaXZlcnMvcGVyZi9hcm1fc21tdXYzX3BtdS5jOjgxNjozOTogd2FybmluZzog
aW5jb3JyZWN0IHR5cGUgaW4gcmV0dXJuIGV4cHJlc3Npb24gKGRpZmZlcmVudCBiYXNlIHR5cGVz
KSBbc3BhcnNlXQorZHJpdmVycy9wZXJmL2FybV9zbW11djNfcG11LmM6ODE2OjM5OiAgICBleHBl
Y3RlZCBpbnQgW3NwYXJzZV0KK2RyaXZlcnMvcGVyZi9hcm1fc21tdXYzX3BtdS5jOjgxNjozOTog
ICAgZ290IHZvaWQgKiBbc3BhcnNlXQorZHJpdmVycy9wZXJmL2FybV9zbW11djNfcG11LmM6ODE5
OjExOiB3YXJuaW5nOiByZXR1cm5pbmcg4oCYdm9pZCAq4oCZIGZyb20gYSBmdW5jdGlvbiB3aXRo
IHJldHVybiB0eXBlIOKAmGludOKAmSBtYWtlcyBpbnRlZ2VyIGZyb20gcG9pbnRlciB3aXRob3V0
IGEgY2FzdCBbLVdpbnQtY29udmVyc2lvbl0KKyAgODE5IHwgICAgcmV0dXJuIEVSUl9QVFIoLUVO
T01FTSk7CisgICAgICB8ICAgICAgICAgICBefn5+fn5+fn5+fn5+fn5+Citkcml2ZXJzL3BlcmYv
YXJtX3NtbXV2M19wbXUuYzo4MTk6Mzk6IHdhcm5pbmc6IGluY29ycmVjdCB0eXBlIGluIHJldHVy
biBleHByZXNzaW9uIChkaWZmZXJlbnQgYmFzZSB0eXBlcykgW3NwYXJzZV0KK2RyaXZlcnMvcGVy
Zi9hcm1fc21tdXYzX3BtdS5jOjgxOTozOTogICAgZXhwZWN0ZWQgaW50IFtzcGFyc2VdCitkcml2
ZXJzL3BlcmYvYXJtX3NtbXV2M19wbXUuYzo4MTk6Mzk6ICAgIGdvdCB2b2lkICogW3NwYXJzZV0K
CldpbGwKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9t
bXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8v
bGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
