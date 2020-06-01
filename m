Return-Path: <SRS0=mWFx=7O=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F5CFC433E0
	for <iommu@archiver.kernel.org>; Mon,  1 Jun 2020 23:20:25 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D51B520663
	for <iommu@archiver.kernel.org>; Mon,  1 Jun 2020 23:20:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D51B520663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 86C7C20502;
	Mon,  1 Jun 2020 23:20:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id k1UNZZ6eBboQ; Mon,  1 Jun 2020 23:20:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 65A3D204D3;
	Mon,  1 Jun 2020 23:20:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 411F4C088C;
	Mon,  1 Jun 2020 23:20:23 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4C0AAC0176;
 Mon,  1 Jun 2020 23:20:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 3E78986B55;
 Mon,  1 Jun 2020 23:20:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RJmqCSjekRE3; Mon,  1 Jun 2020 23:20:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 9504786B38;
 Mon,  1 Jun 2020 23:20:21 +0000 (UTC)
IronPort-SDR: i+QRj41k98rBhFe7BQPCNaASNKE336iFPjy9p17rvicGf1G5BEl0GEq4/2P9ez5B7zPPMEgv/h
 lLTsg/1oWKHg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jun 2020 16:20:15 -0700
IronPort-SDR: hQbV32JOyjOGeuv1Q2ujjMc5qE5l9DREIL4uxk9IfntVO/uJuHc/R3pmYZg2c3JGkkmIfxg4ig
 Vk416qdU8nMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,462,1583222400"; d="scan'208";a="293360328"
Received: from allen-box.sh.intel.com (HELO [10.239.159.139])
 ([10.239.159.139])
 by fmsmga004.fm.intel.com with ESMTP; 01 Jun 2020 16:20:10 -0700
Subject: Re: [PATCH v2 00/33] iommu: Move iommu_group setup to IOMMU core code
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>, Kukjin Kim <kgene@kernel.org>,
 Krzysztof Kozlowski <krzk@kernel.org>, David Woodhouse
 <dwmw2@infradead.org>, Andy Gross <agross@kernel.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, Rob Clark <robdclark@gmail.com>,
 Heiko Stuebner <heiko@sntech.de>,
 Gerald Schaefer <gerald.schaefer@de.ibm.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 linux-s390@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 linux-rockchip@lists.infradead.org, iommu@lists.linux-foundation.org,
 linux-mediatek@lists.infradead.org, linux-tegra@vger.kernel.org
References: <20200414131542.25608-1-joro@8bytes.org>
 <20200529221623.qc6twmpzryh7nkvb@cantor>
 <20200601104240.7f5xhz7gooqhaq4n@cantor>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <47711845-98ee-95b8-aa95-423a36ed9741@linux.intel.com>
Date: Tue, 2 Jun 2020 07:16:22 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200601104240.7f5xhz7gooqhaq4n@cantor>
Content-Language: en-US
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

SGkgSmVycnksCgpPbiA2LzEvMjAgNjo0MiBQTSwgSmVycnkgU25pdHNlbGFhciB3cm90ZToKPj4K
Pj4gSGkgSm9lcmcsCj4+Cj4+IFdpdGggdGhpcyBwYXRjaHNldCwgSSBoYXZlIGFuIGVweWMgc3lz
dGVtIHdoZXJlIGlmIEkgYm9vdCB3aXRoCj4+IGlvbW11PW5vcHQgYW5kIGZvcmNlIGEgZHVtcCBJ
IHdpbGwgc2VlIHNvbWUgaW8gcGFnZSBmYXVsdHMgZm9yIGEgbmljCj4+IG9uIHRoZSBzeXN0ZW0u
IFRoZSB2bWNvcmUgaXMgaGFydmVzdGVkIGFuZCB0aGUgc3lzdGVtIHJlYm9vdHMuIEkKPj4gaGF2
ZW4ndCByZXByb2R1Y2VkIGl0IG9uIG90aGVyIHN5c3RlbXMgeWV0LCBidXQgd2l0aG91dCB0aGUg
cGF0Y2hzZXQgSQo+PiBkb24ndCBzZWUgdGhlIGlvIHBhZ2UgZmF1bHRzIGR1cmluZyB0aGUga2R1
bXAuCj4+Cj4+IFJlZ2FyZHMsCj4+IEplcnJ5Cj4gCj4gSSBqdXN0IGhpdCBhbiBpc3N1ZSBvbiBh
IHNlcGFyYXRlIGludGVsIGJhc2VkIHN5c3RlbSAoa2R1bXAgaW9tbXU9bm9wdCksCj4gd2hlcmUg
aXQgcGFuaWNzIGluIGR1cmluZyBpbnRlbF9pb21tdV9hdHRhY2hfZGV2aWNlLCBpbiBpc19hdXhf
ZG9tYWluLAo+IGR1ZSB0byBkZXZpY2VfZG9tYWluX2luZm8gYmVpbmcgREVGRVJfREVWSUNFX0RP
TUFJTl9JTkZPLiBUaGF0IGRvZXNuJ3QKPiBnZXQgc2V0IHRvIGEgdmFsaWQgYWRkcmVzcyB1bnRp
bCB0aGUgZG9tYWluX2FkZF9kZXZfaW5mbyBjYWxsLgo+IAo+IElzIGl0IGFzIHNpbXBsZSBhcyB0
aGUgZm9sbG93aW5nPwoKSSBndWVzcyB5b3Ugd29uJ3QgaGl0IHRoaXMgaXNzdWUgaWYgeW91IHVz
ZSBpb21tdS9uZXh0IGJyYW5jaCBvZiBKb2VyZydzCnRyZWUuIFdlJ3ZlIGNoYW5nZWQgdG8gdXNl
IGEgZ2VuZXJpYyBoZWxwZXIgdG8gcmV0cmlldmUgdGhlIHZhbGlkIHBlcgpkZXZpY2UgaW9tbXUg
ZGF0YSBvciBOVUxMIChpZiB0aGVyZSdzIG5vKS4KCkJlc3QgcmVnYXJkcywKYmFvbHUKCj4gCj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW9tbXUvaW50ZWwtaW9tbXUuYyBiL2RyaXZlcnMvaW9tbXUv
aW50ZWwtaW9tbXUuYwo+IGluZGV4IDI5ZDM5NDA4NDdkMy4uZjFiYmVlZDQ2YTRjIDEwMDY0NAo+
IC0tLSBhL2RyaXZlcnMvaW9tbXUvaW50ZWwtaW9tbXUuYwo+ICsrKyBiL2RyaXZlcnMvaW9tbXUv
aW50ZWwtaW9tbXUuYwo+IEBAIC01MDUzLDggKzUwNTMsOCBAQCBpc19hdXhfZG9tYWluKHN0cnVj
dCBkZXZpY2UgKmRldiwgc3RydWN0IAo+IGlvbW11X2RvbWFpbiAqZG9tYWluKQo+ICDCoHsKPiAg
wqDCoMKgwqDCoMKgwqAgc3RydWN0IGRldmljZV9kb21haW5faW5mbyAqaW5mbyA9IGRldi0+YXJj
aGRhdGEuaW9tbXU7Cj4gCj4gLcKgwqDCoMKgwqDCoCByZXR1cm4gaW5mbyAmJiBpbmZvLT5hdXhk
X2VuYWJsZWQgJiYKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgZG9tYWluLT50eXBlID09IElPTU1VX0RPTUFJTl9VTk1BTkFHRUQ7Cj4gK8KgwqDCoMKgwqDC
oCByZXR1cm4gaW5mbyAmJiBpbmZvICE9IERFRkVSX0RFVklDRV9ET01BSU5fSU5GTyAmJgo+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGluZm8tPmF1eGRfZW5hYmxlZCAmJiBkb21haW4t
PnR5cGUgPT0gCj4gSU9NTVVfRE9NQUlOX1VOTUFOQUdFRDsKPiAgwqB9Cj4gCj4gIMKgc3RhdGlj
IHZvaWQgYXV4aWxpYXJ5X2xpbmtfZGV2aWNlKHN0cnVjdCBkbWFyX2RvbWFpbiAqZG9tYWluLAo+
IAo+IAo+IFJlZ2FyZHMsCj4gSmVycnkKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5k
YXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2lvbW11
