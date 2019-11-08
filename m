Return-Path: <SRS0=V12C=ZA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC515C5DF60
	for <iommu@archiver.kernel.org>; Fri,  8 Nov 2019 16:44:32 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FC03206A3
	for <iommu@archiver.kernel.org>; Fri,  8 Nov 2019 16:44:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FC03206A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 4FAF6E7E;
	Fri,  8 Nov 2019 16:44:32 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id E5C6BD3D
	for <iommu@lists.linux-foundation.org>;
	Fri,  8 Nov 2019 16:44:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from huawei.com (lhrrgout.huawei.com [185.176.76.210])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 4DFE1196
	for <iommu@lists.linux-foundation.org>;
	Fri,  8 Nov 2019 16:44:29 +0000 (UTC)
Received: from LHREML713-CAH.china.huawei.com (unknown [172.18.7.108])
	by Forcepoint Email with ESMTP id 41E724EA76087BF488D6;
	Fri,  8 Nov 2019 16:44:27 +0000 (GMT)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
	LHREML713-CAH.china.huawei.com (10.201.108.36) with Microsoft SMTP
	Server (TLS) id 14.3.408.0; Fri, 8 Nov 2019 16:44:26 +0000
Received: from [127.0.0.1] (10.202.226.46) by lhreml724-chm.china.huawei.com
	(10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5;
	Fri, 8 Nov 2019 16:44:26 +0000
Subject: Re: [PATCH v2 6/9] Revert "iommu/arm-smmu: Make arm-smmu-v3
	explicitly non-modular"
From: John Garry <john.garry@huawei.com>
To: Will Deacon <will@kernel.org>, <iommu@lists.linux-foundation.org>,
	<linux-kernel@vger.kernel.org>
References: <20191108151608.20932-1-will@kernel.org>
	<20191108151608.20932-7-will@kernel.org>
	<06dfd385-1af0-3106-4cc5-6a5b8e864759@huawei.com>
Message-ID: <7e906ed1-ab85-7e25-9b29-5497e98da8d8@huawei.com>
Date: Fri, 8 Nov 2019 16:44:25 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
	Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <06dfd385-1af0-3106-4cc5-6a5b8e864759@huawei.com>
Content-Language: en-US
X-Originating-IP: [10.202.226.46]
X-ClientProxiedBy: lhreml703-chm.china.huawei.com (10.201.108.52) To
	lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Cc: "Isaac J. Manjarres" <isaacm@codeaurora.org>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>, Bjorn
	Helgaas <bhelgaas@google.com>, Robin Murphy <robin.murphy@arm.com>,
	Saravana Kannan <saravanak@google.com>
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

T24gMDgvMTEvMjAxOSAxNjoxNywgSm9obiBHYXJyeSB3cm90ZToKPiBPbiAwOC8xMS8yMDE5IDE1
OjE2LCBXaWxsIERlYWNvbiB3cm90ZToKPj4gK01PRFVMRV9ERVZJQ0VfVEFCTEUob2YsIGFybV9z
bW11X29mX21hdGNoKTsKPiAKPiBIaSBXaWxsLAo+IAo+PiDCoCBzdGF0aWMgc3RydWN0IHBsYXRm
b3JtX2RyaXZlciBhcm1fc21tdV9kcml2ZXIgPSB7Cj4+IMKgwqDCoMKgwqAgLmRyaXZlcsKgwqDC
oCA9IHsKPj4gwqDCoMKgwqDCoMKgwqDCoMKgIC5uYW1lwqDCoMKgwqDCoMKgwqAgPSAiYXJtLXNt
bXUtdjMiLAo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgLm9mX21hdGNoX3RhYmxlwqDCoMKgID0gb2Zf
bWF0Y2hfcHRyKGFybV9zbW11X29mX21hdGNoKSwKPj4gLcKgwqDCoMKgwqDCoMKgIC5zdXBwcmVz
c19iaW5kX2F0dHJzID0gdHJ1ZSwKPiAKPiBEb2VzIHRoaXMgbWVhbiB0aGF0IHdlIGNhbiBub3cg
bWFudWFsbHkgdW5iaW5kIHRoaXMgZHJpdmVyIGZyb20gdGhlIFNNTVUgCj4gZGV2aWNlPwo+IAo+
IFNlZW1zIGRhbmdlcm91cy4gSGVyZSdzIHdoYXQgaGFwcGVucyBmb3IgbWU6Cj4gCj4gcm9vdEB1
YnVudHU6L3N5cyMgY2QgLi9idXMvcGxhdGZvcm0vZHJpdmVycy9hcm0tc21tdS12Mwo+IGluZCBA
dWJ1bnR1Oi9zeXMvYnVzL3BsYXRmb3JtL2RyaXZlcnMvYXJtLXNtbXUtdjMjIGVjaG8gCj4gYXJt
LXNtbXUtdjMuMC5hdXRvID4gdW5iaW5kCj4gW8KgwqAgNzcuNTgwMzUxXSBoaXNpX3Nhc192Ml9o
dyBISVNJMDE2MjowMTogQ1FFX0FYSV9XX0VSUiAoMHg4MDApIGZvdW5kIQo+IGhvIFvCoMKgIDc4
LjYzNTQ3M10gcGxhdGZvcm0gYXJtLXNtbXUtdjMuMC5hdXRvOiBDTURfU1lOQyB0aW1lb3V0IGF0
IAo+IDB4MDAwMDAxNDYgW2h3cHJvZCAweDAwMDAwMTQ2LCBod2NvbnMgMHgwMDAwMDAwMF0KPiAK
Pj4gwqDCoMKgwqDCoCB9LAo+PiDCoMKgwqDCoMKgIC5wcm9iZcKgwqDCoCA9IGFybV9zbW11X2Rl
dmljZV9wcm9iZSwKPj4gK8KgwqDCoCAucmVtb3ZlwqDCoMKgID0gYXJtX3NtbXVfZGV2aWNlX3Jl
bW92ZSwKPj4gwqDCoMKgwqDCoCAuc2h1dGRvd24gPSBhcm1fc21tdV9kZXZpY2Vfc2h1dGRvd24s
Cj4+IMKgIH07Cj4+IC1idWlsdGluX3BsYXRmb3JtX2RyaXZlcihhcm1fc21tdV9kcml2ZXIpOwo+
PiArbW9kdWxlX3BsYXRmb3JtX2RyaXZlcihhcm1fc21tdV9kcml2ZXIpOwo+PiArCgpCVFcsIGl0
IG5vdyBsb29rcyBsaWtlIGl0IHdhcyB5b3VyIHYxIHNlcmllcyBJIHdhcyB0ZXN0aW5nIHRoZXJl
LCBvbiAKeW91ciBicmFuY2ggaW9tbXUvbW9kdWxlLiBJdCB3b3VsZCBiZSBoZWxwZnVsIHRvIHVw
ZGF0ZSBmb3IgZWFzZSBvZiB0ZXN0aW5nLgoKVGhhbmtzLApKb2huCgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVA
bGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24u
b3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
