Return-Path: <SRS0=mWFx=7O=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5C23C433E0
	for <iommu@archiver.kernel.org>; Mon,  1 Jun 2020 23:24:41 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A52CF2076B
	for <iommu@archiver.kernel.org>; Mon,  1 Jun 2020 23:24:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A52CF2076B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 65B1686CDB;
	Mon,  1 Jun 2020 23:24:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bmzRwduitGLp; Mon,  1 Jun 2020 23:24:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 01E208689B;
	Mon,  1 Jun 2020 23:24:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E90B0C088C;
	Mon,  1 Jun 2020 23:24:38 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 19D0BC0176;
 Mon,  1 Jun 2020 23:24:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id F217720502;
 Mon,  1 Jun 2020 23:24:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8R3s7RaBBB5y; Mon,  1 Jun 2020 23:24:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by silver.osuosl.org (Postfix) with ESMTPS id 8315F204D3;
 Mon,  1 Jun 2020 23:24:35 +0000 (UTC)
IronPort-SDR: +hIVVcB+GgI6EvqVlI92OhNuEvPodcO+ENhUIeKdi6tI8M7XD0nwyR4bRrEEzYKiK6apfyT7/y
 GSRVUrRIfIlQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jun 2020 16:24:34 -0700
IronPort-SDR: JUrubKqZ3F7uGT4bgd8rDXSYuTz0v1ViuP4XLx4HCS0DJFWRtTu6O81cWlFvWumpfvKQwJQ2yp
 fW6OmojLAXPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,462,1583222400"; d="scan'208";a="293361052"
Received: from allen-box.sh.intel.com (HELO [10.239.159.139])
 ([10.239.159.139])
 by fmsmga004.fm.intel.com with ESMTP; 01 Jun 2020 16:24:27 -0700
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
 <20200601131702.4ksimsjvnsmo3mvn@cantor>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <bc4c04fb-ec9a-e9c6-96ec-c8edb8955815@linux.intel.com>
Date: Tue, 2 Jun 2020 07:20:41 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200601131702.4ksimsjvnsmo3mvn@cantor>
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

SGkgSmVycnksCgpPbiA2LzEvMjAgOToxNyBQTSwgSmVycnkgU25pdHNlbGFhciB3cm90ZToKPiBP
biBNb24gSnVuIDAxIDIwLCBKZXJyeSBTbml0c2VsYWFyIHdyb3RlOgo+PiBPbiBGcmkgTWF5IDI5
IDIwLCBKZXJyeSBTbml0c2VsYWFyIHdyb3RlOgo+Pj4gT24gVHVlIEFwciAxNCAyMCwgSm9lcmcg
Um9lZGVsIHdyb3RlOgo+Pj4+IEhpLAo+Pj4+Cj4+Pj4gaGVyZSBpcyB0aGUgc2Vjb25kIHZlcnNp
b24gb2YgdGhpcyBwYXRjaC1zZXQuIFRoZSBmaXJzdCB2ZXJzaW9uIHdpdGgKPj4+PiBzb21lIG1v
cmUgaW50cm9kdWN0b3J5IHRleHQgY2FuIGJlIGZvdW5kIGhlcmU6Cj4+Pj4KPj4+PiDCoMKgwqDC
oGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvMjAyMDA0MDcxODM3NDIuNDM0NC0xLWpvcm9A
OGJ5dGVzLm9yZy8KPj4+Pgo+Pj4+IENoYW5nZXMgdjEtPnYyOgo+Pj4+Cj4+Pj4gwqDCoMKgwqAq
IFJlYmFzZWQgdG8gdjUuNy1yYzEKPj4+Pgo+Pj4+IMKgwqDCoMKgKiBSZS13cm90ZSB0aGUgYXJt
LXNtbXUgY2hhbmdlcyBhcyBzdWdnZXN0ZWQgYnkgUm9iaW4gTXVycGh5Cj4+Pj4KPj4+PiDCoMKg
wqDCoCogUmUtd29ya2VkIHRoZSBFeHlub3MgcGF0Y2hlcyB0byBob3BlZnVsbHkgbm90IGJyZWFr
IHRoZQo+Pj4+IMKgwqDCoMKgwqAgZHJpdmVyIGFueW1vcmUKPj4+Pgo+Pj4+IMKgwqDCoMKgKiBG
aXhlZCBhIG1pc3NpbmcgbXV0ZXhfdW5sb2NrKCkgcmVwb3J0ZWQgYnkgTWFyZWsgU3p5cHJvd3Nr
aSwKPj4+PiDCoMKgwqDCoMKgIHRoYW5rcyBmb3IgdGhhdC4KPj4+Pgo+Pj4+IFRoZXJlIGlzIGFs
c28gYSBnaXQtYnJhbmNoIGF2YWlsYWJsZSB3aXRoIHRoZXNlIHBhdGNoZXMgYXBwbGllZDoKPj4+
Pgo+Pj4+IMKgwqDCoMKgaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5l
bC9naXQvam9yby9saW51eC5naXQvbG9nLz9oPWlvbW11LXByb2JlLWRldmljZS12MiAKPj4+Pgo+
Pj4+Cj4+Pj4gUGxlYXNlIHJldmlldy4KPj4+Pgo+Pj4+IFRoYW5rcywKPj4+Pgo+Pj4+IMKgwqDC
oMKgSm9lcmcKPj4+Pgo+Pj4+IEpvZXJnIFJvZWRlbCAoMzIpOgo+Pj4+IGlvbW11OiBNb3ZlIGRl
ZmF1bHQgZG9tYWluIGFsbG9jYXRpb24gdG8gc2VwYXJhdGUgZnVuY3Rpb24KPj4+PiBpb21tdS9h
bWQ6IEltcGxlbWVudCBpb21tdV9vcHMtPmRlZl9kb21haW5fdHlwZSBjYWxsLWJhY2sKPj4+PiBp
b21tdS92dC1kOiBXaXJlIHVwIGlvbW11X29wcy0+ZGVmX2RvbWFpbl90eXBlCj4+Pj4gaW9tbXUv
YW1kOiBSZW1vdmUgZG1hX21hc2sgY2hlY2sgZnJvbSBjaGVja19kZXZpY2UoKQo+Pj4+IGlvbW11
L2FtZDogUmV0dXJuIC1FTk9ERVYgaW4gYWRkX2RldmljZSB3aGVuIGRldmljZSBpcyBub3QgaGFu
ZGxlZCBieQo+Pj4+IMKgSU9NTVUKPj4+PiBpb21tdTogQWRkIHByb2JlX2RldmljZSgpIGFuZCBy
ZW1vdmVfZGV2aWNlKCkgY2FsbC1iYWNrcwo+Pj4+IGlvbW11OiBNb3ZlIGRlZmF1bHQgZG9tYWlu
IGFsbG9jYXRpb24gdG8gaW9tbXVfcHJvYmVfZGV2aWNlKCkKPj4+PiBpb21tdTogS2VlcCBhIGxp
c3Qgb2YgYWxsb2NhdGVkIGdyb3VwcyBpbiBfX2lvbW11X3Byb2JlX2RldmljZSgpCj4+Pj4gaW9t
bXU6IE1vdmUgbmV3IHByb2JlX2RldmljZSBwYXRoIHRvIHNlcGFyYXRlIGZ1bmN0aW9uCj4+Pj4g
aW9tbXU6IFNwbGl0IG9mZiBkZWZhdWx0IGRvbWFpbiBhbGxvY2F0aW9uIGZyb20gZ3JvdXAgYXNz
aWdubWVudAo+Pj4+IGlvbW11OiBNb3ZlIGlvbW11X2dyb3VwX2NyZWF0ZV9kaXJlY3RfbWFwcGlu
Z3MoKSBvdXQgb2YKPj4+PiDCoGlvbW11X2dyb3VwX2FkZF9kZXZpY2UoKQo+Pj4+IGlvbW11OiBF
eHBvcnQgYnVzX2lvbW11X3Byb2JlKCkgYW5kIG1ha2UgaXMgc2FmZSBmb3IgcmUtcHJvYmluZwo+
Pj4+IGlvbW11L2FtZDogUmVtb3ZlIGRldl9kYXRhLT5wYXNzdGhyb3VnaAo+Pj4+IGlvbW11L2Ft
ZDogQ29udmVydCB0byBwcm9iZS9yZWxlYXNlX2RldmljZSgpIGNhbGwtYmFja3MKPj4+PiBpb21t
dS92dC1kOiBDb252ZXJ0IHRvIHByb2JlL3JlbGVhc2VfZGV2aWNlKCkgY2FsbC1iYWNrcwo+Pj4+
IGlvbW11L2FybS1zbW11OiBDb252ZXJ0IHRvIHByb2JlL3JlbGVhc2VfZGV2aWNlKCkgY2FsbC1i
YWNrcwo+Pj4+IGlvbW11L3BhbXU6IENvbnZlcnQgdG8gcHJvYmUvcmVsZWFzZV9kZXZpY2UoKSBj
YWxsLWJhY2tzCj4+Pj4gaW9tbXUvczM5MDogQ29udmVydCB0byBwcm9iZS9yZWxlYXNlX2Rldmlj
ZSgpIGNhbGwtYmFja3MKPj4+PiBpb21tdS92aXJ0aW86IENvbnZlcnQgdG8gcHJvYmUvcmVsZWFz
ZV9kZXZpY2UoKSBjYWxsLWJhY2tzCj4+Pj4gaW9tbXUvbXNtOiBDb252ZXJ0IHRvIHByb2JlL3Jl
bGVhc2VfZGV2aWNlKCkgY2FsbC1iYWNrcwo+Pj4+IGlvbW11L21lZGlhdGVrOiBDb252ZXJ0IHRv
IHByb2JlL3JlbGVhc2VfZGV2aWNlKCkgY2FsbC1iYWNrcwo+Pj4+IGlvbW11L21lZGlhdGVrLXYx
IENvbnZlcnQgdG8gcHJvYmUvcmVsZWFzZV9kZXZpY2UoKSBjYWxsLWJhY2tzCj4+Pj4gaW9tbXUv
cWNvbTogQ29udmVydCB0byBwcm9iZS9yZWxlYXNlX2RldmljZSgpIGNhbGwtYmFja3MKPj4+PiBp
b21tdS9yb2NrY2hpcDogQ29udmVydCB0byBwcm9iZS9yZWxlYXNlX2RldmljZSgpIGNhbGwtYmFj
a3MKPj4+PiBpb21tdS90ZWdyYTogQ29udmVydCB0byBwcm9iZS9yZWxlYXNlX2RldmljZSgpIGNh
bGwtYmFja3MKPj4+PiBpb21tdS9yZW5lc2FzOiBDb252ZXJ0IHRvIHByb2JlL3JlbGVhc2VfZGV2
aWNlKCkgY2FsbC1iYWNrcwo+Pj4+IGlvbW11L29tYXA6IFJlbW92ZSBvcnBoYW5fZGV2IHRyYWNr
aW5nCj4+Pj4gaW9tbXUvb21hcDogQ29udmVydCB0byBwcm9iZS9yZWxlYXNlX2RldmljZSgpIGNh
bGwtYmFja3MKPj4+PiBpb21tdS9leHlub3M6IFVzZSBmaXJzdCBTWVNNTVUgaW4gY29udHJvbGxl
cnMgbGlzdCBmb3IgSU9NTVUgY29yZQo+Pj4+IGlvbW11L2V4eW5vczogQ29udmVydCB0byBwcm9i
ZS9yZWxlYXNlX2RldmljZSgpIGNhbGwtYmFja3MKPj4+PiBpb21tdTogUmVtb3ZlIGFkZF9kZXZp
Y2UoKS9yZW1vdmVfZGV2aWNlKCkgY29kZS1wYXRocwo+Pj4+IGlvbW11OiBVbmV4cG9ydCBpb21t
dV9ncm91cF9nZXRfZm9yX2RldigpCj4+Pj4KPj4+PiBTYWkgUHJhbmVldGggUHJha2h5YSAoMSk6
Cj4+Pj4gaW9tbXU6IEFkZCBkZWZfZG9tYWluX3R5cGUoKSBjYWxsYmFjayBpbiBpb21tdV9vcHMK
Pj4+Pgo+Pj4+IGRyaXZlcnMvaW9tbXUvYW1kX2lvbW11LmPCoMKgwqDCoMKgwqAgfMKgIDk3ICsr
KystLS0tCj4+Pj4gZHJpdmVycy9pb21tdS9hbWRfaW9tbXVfdHlwZXMuaCB8wqDCoCAxIC0KPj4+
PiBkcml2ZXJzL2lvbW11L2FybS1zbW11LXYzLmPCoMKgwqDCoCB8wqAgMzggKy0tCj4+Pj4gZHJp
dmVycy9pb21tdS9hcm0tc21tdS5jwqDCoMKgwqDCoMKgwqAgfMKgIDM5ICsrLS0KPj4+PiBkcml2
ZXJzL2lvbW11L2V4eW5vcy1pb21tdS5jwqDCoMKgIHzCoCAyNCArLQo+Pj4+IGRyaXZlcnMvaW9t
bXUvZnNsX3BhbXVfZG9tYWluLmMgfMKgIDIyICstCj4+Pj4gZHJpdmVycy9pb21tdS9pbnRlbC1p
b21tdS5jwqDCoMKgwqAgfMKgIDY4ICstLS0tLQo+Pj4+IGRyaXZlcnMvaW9tbXUvaW9tbXUuY8Kg
wqDCoMKgwqDCoMKgwqDCoMKgIHwgMzkzICsrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0t
Cj4+Pj4gZHJpdmVycy9pb21tdS9pcG1tdS12bXNhLmPCoMKgwqDCoMKgIHzCoCA2MCArKy0tLQo+
Pj4+IGRyaXZlcnMvaW9tbXUvbXNtX2lvbW11LmPCoMKgwqDCoMKgwqAgfMKgIDM0ICstLQo+Pj4+
IGRyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmPCoMKgwqDCoMKgwqAgfMKgIDI0ICstCj4+Pj4gZHJp
dmVycy9pb21tdS9tdGtfaW9tbXVfdjEuY8KgwqDCoCB8wqAgNTAgKystLQo+Pj4+IGRyaXZlcnMv
aW9tbXUvb21hcC1pb21tdS5jwqDCoMKgwqDCoCB8wqAgOTkgKystLS0tLS0KPj4+PiBkcml2ZXJz
L2lvbW11L3Fjb21faW9tbXUuY8KgwqDCoMKgwqAgfMKgIDI0ICstCj4+Pj4gZHJpdmVycy9pb21t
dS9yb2NrY2hpcC1pb21tdS5jwqAgfMKgIDI2ICstLQo+Pj4+IGRyaXZlcnMvaW9tbXUvczM5MC1p
b21tdS5jwqDCoMKgwqDCoCB8wqAgMjIgKy0KPj4+PiBkcml2ZXJzL2lvbW11L3RlZ3JhLWdhcnQu
Y8KgwqDCoMKgwqAgfMKgIDI0ICstCj4+Pj4gZHJpdmVycy9pb21tdS90ZWdyYS1zbW11LmPCoMKg
wqDCoMKgIHzCoCAzMSArLS0KPj4+PiBkcml2ZXJzL2lvbW11L3ZpcnRpby1pb21tdS5jwqDCoMKg
IHzCoCA0MSArLS0tCj4+Pj4gaW5jbHVkZS9saW51eC9pb21tdS5owqDCoMKgwqDCoMKgwqDCoMKg
wqAgfMKgIDIxICstCj4+Pj4gMjAgZmlsZXMgY2hhbmdlZCwgNTMzIGluc2VydGlvbnMoKyksIDYw
NSBkZWxldGlvbnMoLSkKPj4+Pgo+Pj4+IC0tIAo+Pj4+IDIuMTcuMQo+Pj4+Cj4+Pj4gX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPj4+PiBpb21tdSBtYWls
aW5nIGxpc3QKPj4+PiBpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwo+Pj4+IGh0dHBz
Oi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11Cj4+Pj4K
Pj4+Cj4+PiBIaSBKb2VyZywKPj4+Cj4+PiBXaXRoIHRoaXMgcGF0Y2hzZXQsIEkgaGF2ZSBhbiBl
cHljIHN5c3RlbSB3aGVyZSBpZiBJIGJvb3Qgd2l0aAo+Pj4gaW9tbXU9bm9wdCBhbmQgZm9yY2Ug
YSBkdW1wIEkgd2lsbCBzZWUgc29tZSBpbyBwYWdlIGZhdWx0cyBmb3IgYSBuaWMKPj4+IG9uIHRo
ZSBzeXN0ZW0uIFRoZSB2bWNvcmUgaXMgaGFydmVzdGVkIGFuZCB0aGUgc3lzdGVtIHJlYm9vdHMu
IEkKPj4+IGhhdmVuJ3QgcmVwcm9kdWNlZCBpdCBvbiBvdGhlciBzeXN0ZW1zIHlldCwgYnV0IHdp
dGhvdXQgdGhlIHBhdGNoc2V0IEkKPj4+IGRvbid0IHNlZSB0aGUgaW8gcGFnZSBmYXVsdHMgZHVy
aW5nIHRoZSBrZHVtcC4KPj4+Cj4+PiBSZWdhcmRzLAo+Pj4gSmVycnkKPj4KPj4gSSBqdXN0IGhp
dCBhbiBpc3N1ZSBvbiBhIHNlcGFyYXRlIGludGVsIGJhc2VkIHN5c3RlbSAoa2R1bXAgaW9tbXU9
bm9wdCksCj4+IHdoZXJlIGl0IHBhbmljcyBpbiBkdXJpbmcgaW50ZWxfaW9tbXVfYXR0YWNoX2Rl
dmljZSwgaW4gaXNfYXV4X2RvbWFpbiwKPj4gZHVlIHRvIGRldmljZV9kb21haW5faW5mbyBiZWlu
ZyBERUZFUl9ERVZJQ0VfRE9NQUlOX0lORk8uIFRoYXQgZG9lc24ndAo+PiBnZXQgc2V0IHRvIGEg
dmFsaWQgYWRkcmVzcyB1bnRpbCB0aGUgZG9tYWluX2FkZF9kZXZfaW5mbyBjYWxsLgo+Pgo+PiBJ
cyBpdCBhcyBzaW1wbGUgYXMgdGhlIGZvbGxvd2luZz8KPj4KPj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvaW9tbXUvaW50ZWwtaW9tbXUuYyBiL2RyaXZlcnMvaW9tbXUvaW50ZWwtaW9tbXUuYwo+PiBp
bmRleCAyOWQzOTQwODQ3ZDMuLmYxYmJlZWQ0NmE0YyAxMDA2NDQKPj4gLS0tIGEvZHJpdmVycy9p
b21tdS9pbnRlbC1pb21tdS5jCj4+ICsrKyBiL2RyaXZlcnMvaW9tbXUvaW50ZWwtaW9tbXUuYwo+
PiBAQCAtNTA1Myw4ICs1MDUzLDggQEAgaXNfYXV4X2RvbWFpbihzdHJ1Y3QgZGV2aWNlICpkZXYs
IHN0cnVjdCAKPj4gaW9tbXVfZG9tYWluICpkb21haW4pCj4+IHsKPj4gwqDCoMKgwqDCoMKgIHN0
cnVjdCBkZXZpY2VfZG9tYWluX2luZm8gKmluZm8gPSBkZXYtPmFyY2hkYXRhLmlvbW11Owo+PiAt
wqDCoMKgwqDCoMKgIHJldHVybiBpbmZvICYmIGluZm8tPmF1eGRfZW5hYmxlZCAmJgo+PiAtwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZG9tYWluLT50eXBlID09
IElPTU1VX0RPTUFJTl9VTk1BTkFHRUQ7Cj4+ICvCoMKgwqDCoMKgwqAgcmV0dXJuIGluZm8gJiYg
aW5mbyAhPSBERUZFUl9ERVZJQ0VfRE9NQUlOX0lORk8gJiYKPj4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgaW5mby0+YXV4ZF9lbmFibGVkICYmIGRvbWFpbi0+dHlwZSA9PSAKPj4gSU9N
TVVfRE9NQUlOX1VOTUFOQUdFRDsKPj4gfQo+PiBzdGF0aWMgdm9pZCBhdXhpbGlhcnlfbGlua19k
ZXZpY2Uoc3RydWN0IGRtYXJfZG9tYWluICpkb21haW4sCj4+Cj4+Cj4+IFJlZ2FyZHMsCj4+IEpl
cnJ5Cj4+Cj4gCj4gV2l0aCB0aGUgcGF0Y2gsIEkgYXZvaWQgdGhlIHBhbmljLCBidXQgSSdtIHNl
ZWluZyBhbiBpc3N1ZSBzaW1pbGFyIHRvIAo+IHRoZSBlcHljIHN5c3RlbS4KPiBJJ20gZ2V0dGlu
ZyBkbWFyIGZhdWx0cyBmcm9tIGEgY291cGxlIG9mIG5pY3MgYW5kIHRoZSBocCBpbG8uIFRoZSAK
PiBhZGRyZXNzZXMgaW4gcXVlc3Rpb24KPiB3ZXJlIGluIGU4MjAgcmVzZXJ2ZWQgc2VjdGlvbnMs
IGJ1dCB0aGVyZSBhcmVuJ3Qgcm1yciBjb3ZlcmluZyB0aG9zZSAKPiBhZGRyZXNzZXMuIFRoZSBz
eXN0ZW0KPiBtYW5hZ2VzIHRvIGhhcnZlc3QgdGhlIHZtY29yZSBhbmQgcmVib290IGxpa2UgdGhl
IGVweWMuIFdpdGhvdXQgdGhlIAo+IHBhdGNoZXMgSSBkb24ndCBzZWUKPiB0aGUgZG1hciBmYXVs
dHMuIEkgbmVlZGVkIHRvIGdpdmUgdGhpcyBzeXN0ZW0gYmFjaywgYnV0IEknbGwgdHJ5IHRvIHBv
a2UgCj4gYXQgaXQgc29tZSBtb3JlCj4gaW4gdGhlIG5leHQgY291cGxlIG9mIGRheXMuCgpUaGFu
a3MgYW5kIGxvb2tpbmcgZm9yd2FyZCB0byBmdXJ0aGVyIGRlYnVnZ2luZyBpbmZvcm1hdGlvbi4K
CkJlc3QgcmVnYXJkcywKYmFvbHUKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRp
b24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2lvbW11
