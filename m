Return-Path: <SRS0=V12C=ZA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06752C5DF60
	for <iommu@archiver.kernel.org>; Fri,  8 Nov 2019 17:28:37 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1EE3207FA
	for <iommu@archiver.kernel.org>; Fri,  8 Nov 2019 17:28:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1EE3207FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 17916F01;
	Fri,  8 Nov 2019 17:25:15 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id BDD04EE3
	for <iommu@lists.linux-foundation.org>;
	Fri,  8 Nov 2019 17:25:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from huawei.com (lhrrgout.huawei.com [185.176.76.210])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 1D8F88A7
	for <iommu@lists.linux-foundation.org>;
	Fri,  8 Nov 2019 17:25:13 +0000 (UTC)
Received: from lhreml709-cah.china.huawei.com (unknown [172.18.7.108])
	by Forcepoint Email with ESMTP id 1CCADF52432EBF2D3D08;
	Fri,  8 Nov 2019 17:25:11 +0000 (GMT)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
	lhreml709-cah.china.huawei.com (10.201.108.32) with Microsoft SMTP
	Server (TLS) id 14.3.408.0; Fri, 8 Nov 2019 17:25:10 +0000
Received: from [127.0.0.1] (10.202.226.46) by lhreml724-chm.china.huawei.com
	(10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5;
	Fri, 8 Nov 2019 17:25:10 +0000
Subject: Re: [PATCH v2 6/9] Revert "iommu/arm-smmu: Make arm-smmu-v3
	explicitly non-modular"
To: Will Deacon <will@kernel.org>
References: <20191108151608.20932-1-will@kernel.org>
	<20191108151608.20932-7-will@kernel.org>
	<06dfd385-1af0-3106-4cc5-6a5b8e864759@huawei.com>
	<7e906ed1-ab85-7e25-9b29-5497e98da8d8@huawei.com>
	<20191108164728.GB20866@willie-the-truck>
From: John Garry <john.garry@huawei.com>
Message-ID: <c4cb13d3-3786-2e45-ba57-9965cead9a49@huawei.com>
Date: Fri, 8 Nov 2019 17:25:09 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
	Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20191108164728.GB20866@willie-the-truck>
Content-Language: en-US
X-Originating-IP: [10.202.226.46]
X-ClientProxiedBy: lhreml703-chm.china.huawei.com (10.201.108.52) To
	lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Cc: "Isaac J. Manjarres" <isaacm@codeaurora.org>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Saravana Kannan <saravanak@google.com>,
	linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, Bjorn
	Helgaas <bhelgaas@google.com>, Robin Murphy <robin.murphy@arm.com>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

T24gMDgvMTEvMjAxOSAxNjo0NywgV2lsbCBEZWFjb24gd3JvdGU6Cj4gT24gRnJpLCBOb3YgMDgs
IDIwMTkgYXQgMDQ6NDQ6MjVQTSArMDAwMCwgSm9obiBHYXJyeSB3cm90ZToKPj4gT24gMDgvMTEv
MjAxOSAxNjoxNywgSm9obiBHYXJyeSB3cm90ZToKPj4+IE9uIDA4LzExLzIwMTkgMTU6MTYsIFdp
bGwgRGVhY29uIHdyb3RlOgo+Pj4+ICtNT0RVTEVfREVWSUNFX1RBQkxFKG9mLCBhcm1fc21tdV9v
Zl9tYXRjaCk7Cj4+Pgo+Pj4gSGkgV2lsbCwKPj4+Cj4+Pj4gIMKgIHN0YXRpYyBzdHJ1Y3QgcGxh
dGZvcm1fZHJpdmVyIGFybV9zbW11X2RyaXZlciA9IHsKPj4+PiAgwqDCoMKgwqDCoCAuZHJpdmVy
wqDCoMKgID0gewo+Pj4+ICDCoMKgwqDCoMKgwqDCoMKgwqAgLm5hbWXCoMKgwqDCoMKgwqDCoCA9
ICJhcm0tc21tdS12MyIsCj4+Pj4gIMKgwqDCoMKgwqDCoMKgwqDCoCAub2ZfbWF0Y2hfdGFibGXC
oMKgwqAgPSBvZl9tYXRjaF9wdHIoYXJtX3NtbXVfb2ZfbWF0Y2gpLAo+Pj4+IC3CoMKgwqDCoMKg
wqDCoCAuc3VwcHJlc3NfYmluZF9hdHRycyA9IHRydWUsCj4+Pgo+Pj4gRG9lcyB0aGlzIG1lYW4g
dGhhdCB3ZSBjYW4gbm93IG1hbnVhbGx5IHVuYmluZCB0aGlzIGRyaXZlciBmcm9tIHRoZSBTTU1V
Cj4+PiBkZXZpY2U/Cj4+Pgo+Pj4gU2VlbXMgZGFuZ2Vyb3VzLiBIZXJlJ3Mgd2hhdCBoYXBwZW5z
IGZvciBtZToKPj4+Cj4+PiByb290QHVidW50dTovc3lzIyBjZCAuL2J1cy9wbGF0Zm9ybS9kcml2
ZXJzL2FybS1zbW11LXYzCj4+PiBpbmQgQHVidW50dTovc3lzL2J1cy9wbGF0Zm9ybS9kcml2ZXJz
L2FybS1zbW11LXYzIyBlY2hvCj4+PiBhcm0tc21tdS12My4wLmF1dG8gPiB1bmJpbmQKPj4+IFvC
oMKgIDc3LjU4MDM1MV0gaGlzaV9zYXNfdjJfaHcgSElTSTAxNjI6MDE6IENRRV9BWElfV19FUlIg
KDB4ODAwKSBmb3VuZCEKPj4+IGhvIFvCoMKgIDc4LjYzNTQ3M10gcGxhdGZvcm0gYXJtLXNtbXUt
djMuMC5hdXRvOiBDTURfU1lOQyB0aW1lb3V0IGF0Cj4+PiAweDAwMDAwMTQ2IFtod3Byb2QgMHgw
MDAwMDE0NiwgaHdjb25zIDB4MDAwMDAwMDBdCj4+Pgo+Pj4+ICDCoMKgwqDCoMKgIH0sCj4+Pj4g
IMKgwqDCoMKgwqAgLnByb2JlwqDCoMKgID0gYXJtX3NtbXVfZGV2aWNlX3Byb2JlLAo+Pj4+ICvC
oMKgwqAgLnJlbW92ZcKgwqDCoCA9IGFybV9zbW11X2RldmljZV9yZW1vdmUsCj4+Pj4gIMKgwqDC
oMKgwqAgLnNodXRkb3duID0gYXJtX3NtbXVfZGV2aWNlX3NodXRkb3duLAo+Pj4+ICDCoCB9Owo+
Pj4+IC1idWlsdGluX3BsYXRmb3JtX2RyaXZlcihhcm1fc21tdV9kcml2ZXIpOwo+Pj4+ICttb2R1
bGVfcGxhdGZvcm1fZHJpdmVyKGFybV9zbW11X2RyaXZlcik7Cj4+Pj4gKwo+Pgo+PiBCVFcsIGl0
IG5vdyBsb29rcyBsaWtlIGl0IHdhcyB5b3VyIHYxIHNlcmllcyBJIHdhcyB0ZXN0aW5nIHRoZXJl
LCBvbiB5b3VyCj4+IGJyYW5jaCBpb21tdS9tb2R1bGUuIEl0IHdvdWxkIGJlIGhlbHBmdWwgdG8g
dXBkYXRlIGZvciBlYXNlIG9mIHRlc3RpbmcuCj4gCgpIaSBXaWxsLAoKPiBZZXMsIHNvcnJ5IGFi
b3V0IHRoYXQuIEknbGwgdXBkYXRlIGl0IG5vdyAoYWx0aG91Z2ggSSdtIG5vdCBzdXJlIGl0IHdp
bGwKPiBoZWxwIHdpdGggdGhpcyAtLSBJIHdhcyBnb2luZyB0byBzZWUgd2hhdCBoYXBwZW5zIHdp
dGggb3RoZXIgZGV2aWNlcyBzdWNoCj4gYXMgdGhlIGludGVsLWlvbW11IG9yIHN0b3JhZ2UgY29u
dHJvbGxlcnMpCgpTbyBJIHRyaWVkIHlvdXIgdjIgc2VyaWVzIGZvciB0aGlzIC0gaXQgaGFzIHRo
ZSBzYW1lIGlzc3VlLCBhcyBJIAphbnRpY2lwYXRlZC4KCkl0IHNlZW1zIHRoYXQgc29tZSBpb21t
dSBkcml2ZXJzIGRvIGNhbGwgaW9tbXVfZGV2aWNlX3JlZ2lzdGVyKCksIHNvIAptYXliZSBhIGRl
Y2VudCByZWZlcmVuY2UuIE9yIHNpbXBseSBzdG9wIHRoZSBkcml2ZXIgYmVpbmcgdW5ib3VuZC4K
CkNoZWVycywKSm9obgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3Jn
Cmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
