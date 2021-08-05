Return-Path: <SRS0=+AsR=M4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	URIBL_RED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8447BC4338F
	for <iommu@archiver.kernel.org>; Thu,  5 Aug 2021 13:40:46 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 099E161156
	for <iommu@archiver.kernel.org>; Thu,  5 Aug 2021 13:40:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 099E161156
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C8B9D403C8;
	Thu,  5 Aug 2021 13:40:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0fUrkhF_De-8; Thu,  5 Aug 2021 13:40:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 85BC74035C;
	Thu,  5 Aug 2021 13:40:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5ED94C001A;
	Thu,  5 Aug 2021 13:40:44 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6A428C000E
 for <iommu@lists.linux-foundation.org>; Thu,  5 Aug 2021 13:40:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5A472606B4
 for <iommu@lists.linux-foundation.org>; Thu,  5 Aug 2021 13:40:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WKys3nCun5AP for <iommu@lists.linux-foundation.org>;
 Thu,  5 Aug 2021 13:40:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E351560609
 for <iommu@lists.linux-foundation.org>; Thu,  5 Aug 2021 13:40:40 +0000 (UTC)
Received: from fraeml710-chm.china.huawei.com (unknown [172.18.147.200])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GgV9H5QV2z6F8WF;
 Thu,  5 Aug 2021 21:40:19 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml710-chm.china.huawei.com (10.206.15.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 5 Aug 2021 15:40:37 +0200
Received: from [10.47.24.8] (10.47.24.8) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2176.2; Thu, 5 Aug 2021
 14:40:36 +0100
Subject: Re: [PATCH] iommu/arm-smmu-v3: Remove some unneeded init in
 arm_smmu_cmdq_issue_cmdlist()
To: Robin Murphy <robin.murphy@arm.com>, <will@kernel.org>
References: <1624293394-202509-1-git-send-email-john.garry@huawei.com>
 <ee1f3ab5-3acc-f442-f2d2-898cf88bc447@arm.com>
From: John Garry <john.garry@huawei.com>
Message-ID: <45a8af4f-4202-ecd8-0882-507acf9b2eb2@huawei.com>
Date: Thu, 5 Aug 2021 14:40:05 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <ee1f3ab5-3acc-f442-f2d2-898cf88bc447@arm.com>
Content-Language: en-US
X-Originating-IP: [10.47.24.8]
X-ClientProxiedBy: lhreml706-chm.china.huawei.com (10.201.108.55) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Cc: linuxarm@huawei.com, iommu@lists.linux-foundation.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
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

T24gMDUvMDgvMjAyMSAxMjoyNCwgUm9iaW4gTXVycGh5IHdyb3RlOgo+IE9uIDIwMjEtMDYtMjEg
MTc6MzYsIEpvaG4gR2Fycnkgd3JvdGU6Cj4+IE1lbWJlcnMgb2Ygc3RydWN0ICJsbHEiIHdpbGwg
YmUgemVyby1pbml0ZWQsIGFwYXJ0IGZyb20gbWVtYmVyIAo+PiBtYXhfbl9zaGlmdC4KPj4gQnV0
IHdlIHdyaXRlIGxscS52YWwgc3RyYWlnaHQgYWZ0ZXIgdGhlIGluaXQsIHNvIGl0IHdhcyBwb2lu
dGxlc3MgdG8gemVybwo+PiBpbml0IHRob3NlIG90aGVyIG1lbWJlcnMuIEFzIHN1Y2gsIHNlcGFy
YXRlbHkgaW5pdCBtZW1iZXIgbWF4X25fc2hpZnQKPj4gb25seS4KPj4KPj4gSW4gYWRkaXRpb24s
IHN0cnVjdCAiaGVhZCIgaXMgaW5pdGlhbGlzZWQgdG8gImxscSIgb25seSBzbyB0aGF0IG1lbWJl
cgo+PiBtYXhfbl9zaGlmdCBpcyBzZXQuIEJ1dCB0aGF0IG1lbWJlciBpcyBuZXZlciByZWZlcmVu
Y2VkIGZvciAiaGVhZCIsIHNvCj4+IHJlbW92ZSBhbnkgaW5pdCB0aGVyZS4KPj4KPj4gUmVtb3Zp
bmcgdGhlc2UgaW5pdGlhbGl6YXRpb25zIGlzIHNlZW4gYXMgYSBzbWFsbCBwZXJmb3JtYW5jZSAK
Pj4gb3B0aW1pc2F0aW9uLAo+PiBhcyB0aGlzIGNvZGUgaXMgKHZlcnkpIGhvdCBwYXRoLgo+IAo+
IEkgbG9va2VkIGF0IHRoaXMgYW5kIGltbWVkaWF0ZWx5IHRob3VnaHQgInN1cmVseSB0aGUgY29t
cGlsZXIgY2FuIHNlZSAKPiB0aGF0IGFsbCB0aGUgcHJvZC9jb25zL3ZhbCBmaWVsZHMgYXJlIHdy
aXR0ZW4gYW55d2F5IGFuZCBlbGlkZSB0aGUgCj4gaW5pdGlhbGlzYXRpb24/Iiwgc28gSSBkdW1w
ZWQgdGhlIGJlZm9yZSBhbmQgYWZ0ZXIgZGlzYXNzZW1ibHksIGFuZC4uLiBvaC4KPiAKPiBZb3Ug
c2hvdWxkIHByb2JhYmx5IGNsYXJpZnkgdGhhdCBpdCdzIHplcm8taW5pdGlhbGlzaW5nIGFsbCB0
aGUgCj4gY2FjaGVsaW5lIHBhZGRpbmcgd2hpY2ggaXMgYm90aCBwb2ludGxlc3MgYW5kIHBhaW5m
dWwuIFdpdGggdGhhdCwKPiAKPiBSZXZpZXdlZC1ieTogUm9iaW4gTXVycGh5IDxyb2Jpbi5tdXJw
aHlAYXJtLmNvbT4KPiAKPiBIb3dldmVyLCBoYXZpbmcgbG9va2VkIHRoaXMgY2xvc2VseSBJJ20g
bm93IHRhbmdlbnRpYWxseSB3b25kZXJpbmcgd2h5IAo+IG1heF9uX3NoaWZ0IGlzbid0IGluc2lk
ZSB0aGUgcGFkZGVkIHVuaW9uPyBJdCdzIHJlYWQgYXQgdGhlIHNhbWUgdGltZSBhcyAKPiBib3Ro
IHByb2QgYW5kIGNvbnMgYnkgcXVldWVfaGFzX3NwYWNlKCksIGFuZCBuZXZlciB1cGRhdGVkLCBz
byB0aGVyZSAKPiBkb2Vzbid0IGFwcGVhciB0byBiZSBhbnkgYmVuZWZpdCB0byBpdCBiZWluZyBp
biBhIHNlcGFyYXRlIGNhY2hlbGluZSBhbGwgCj4gYnkgaXRzZWxmLCBhbmQgbGxxIGlzIGFscmVh
ZHkgdHdpY2UgYXMgYmlnIGFzIGl0IG5lZWRzIHRvIGJlLgoKSSB0aGluayB0aGF0IHRoZSBwcm9i
bGVtIGlzIGlmIHRoZSBwcm9kK2NvbnMgNjRiIHZhbHVlIGFuZCB0aGUgc2hpZnQgYXJlIApvbiB0
aGUgc2FtZSBjYWNoZWxpbmUsIHRoZW4gd2UgaGF2ZSBhIGNoYW5jZSBvZiBhY2Nlc3NpbmcgYSBz
dGFsZSAKY2FjaGVsaW5lIHR3aWNlOgoKc3RhdGljIGludCBhcm1fc21tdV9jbWRxX2lzc3VlX2Nt
ZGxpc3Qoc3RydWN0IGFybV9zbW11X2RldmljZSAqc21tdSwKCQkJCSAgICAgICB1NjQgKmNtZHMs
IGludCBuLCBib29sIHN5bmMpCnsKCXU2NCBjbWRfc3luY1tDTURRX0VOVF9EV09SRFNdOwoJdTMy
IHByb2Q7Cgl1bnNpZ25lZCBsb25nIGZsYWdzOwoJYm9vbCBvd25lcjsKCXN0cnVjdCBhcm1fc21t
dV9jbWRxICpjbWRxID0gJnNtbXUtPmNtZHE7CglzdHJ1Y3QgYXJtX3NtbXVfbGxfcXVldWUgbGxx
ID0gewoJCS5tYXhfbl9zaGlmdCA9IGNtZHEtPnEubGxxLm1heF9uX3NoaWZ0LAkvLyBoZXJlCgl9
LCBoZWFkID0gbGxxOwoJaW50IHJldCA9IDA7CgoJLyogMS4gQWxsb2NhdGUgc29tZSBzcGFjZSBp
biB0aGUgcXVldWUgKi8KCWxvY2FsX2lycV9zYXZlKGZsYWdzKTsKCWxscS52YWwgPSBSRUFEX09O
Q0UoY21kcS0+cS5sbHEudmFsKTsJLy8gYW5kIGFnYWluIGhlcmUKCgpzaW5jZSBjbWRxLT5xLmxs
cSBpcyBwZXItU01NVS4gSWYgbWF4X25fc2hpZnQgaXMgb24gYSBzZXBhcmF0ZSAKY2FjaGVsaW5l
LCB0aGVuIGl0IHNob3VsZCBuZXZlciBiZSBzdGFsZS4KCkkgc3VwcG9zZSB0aGV5IGNvdWxkIGJl
IGNvbWJpbmVkIGludG8gYSBzbWFsbGVyIHN1Yi1zdHJ1Y3QgYW5kIGxvYWRlZCBpbiAKYSBzaW5n
bGUgb3BlcmF0aW9uLCBidXQgaXQgbG9va3MgbWVzc3ksIGFuZCBwcm9iIHdpdGhvdXQgbXVjaCBn
YWluLgoKVGhhbmtzLApKb2huCgo+IFNvcnRpbmcgCj4gdGhhdCB3b3VsZCBhbHNvIGJlIGEgZ29v
ZCBvcHBvcnR1bml0eSB0byBzdG9yZSB0aGUgdmFsdWUgb2YgaW50ZXJlc3QgaW4gCj4gaXRzIGFw
cHJvcHJpYXRlIGZvcm0gc28gd2UncmUgbm90IG5lZWRsZXNzbHkgcmVjYWxjdWxhdGluZyAxIDw8
IHNoaWZ0IAo+IGV2ZXJ5IGZsaXBwaW4nIHRpbWUuLi4KPiAKPiBSb2Jpbi4KPiAKPj4gU2lnbmVk
LW9mZi1ieTogSm9obiBHYXJyeSA8am9obi5nYXJyeUBodWF3ZWkuY29tPgo+Pgo+PiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9pb21tdS9hcm0vYXJtLXNtbXUtdjMvYXJtLXNtbXUtdjMuYyAKPj4gYi9k
cml2ZXJzL2lvbW11L2FybS9hcm0tc21tdS12My9hcm0tc21tdS12My5jCj4+IGluZGV4IDU0YjJm
MjdiODFkNC4uOGE4YWQ0OWJiN2ZkIDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJzL2lvbW11L2FybS9h
cm0tc21tdS12My9hcm0tc21tdS12My5jCj4+ICsrKyBiL2RyaXZlcnMvaW9tbXUvYXJtL2FybS1z
bW11LXYzL2FybS1zbW11LXYzLmMKPj4gQEAgLTcyNywxMSArNzI3LDExIEBAIHN0YXRpYyBpbnQg
YXJtX3NtbXVfY21kcV9pc3N1ZV9jbWRsaXN0KHN0cnVjdCAKPj4gYXJtX3NtbXVfZGV2aWNlICpz
bW11LAo+PiDCoMKgwqDCoMKgIHVuc2lnbmVkIGxvbmcgZmxhZ3M7Cj4+IMKgwqDCoMKgwqAgYm9v
bCBvd25lcjsKPj4gwqDCoMKgwqDCoCBzdHJ1Y3QgYXJtX3NtbXVfY21kcSAqY21kcSA9ICZzbW11
LT5jbWRxOwo+PiAtwqDCoMKgIHN0cnVjdCBhcm1fc21tdV9sbF9xdWV1ZSBsbHEgPSB7Cj4+IC3C
oMKgwqDCoMKgwqDCoCAubWF4X25fc2hpZnQgPSBjbWRxLT5xLmxscS5tYXhfbl9zaGlmdCwKPj4g
LcKgwqDCoCB9LCBoZWFkID0gbGxxOwo+PiArwqDCoMKgIHN0cnVjdCBhcm1fc21tdV9sbF9xdWV1
ZSBsbHEsIGhlYWQ7Cj4+IMKgwqDCoMKgwqAgaW50IHJldCA9IDA7Cj4+ICvCoMKgwqAgbGxxLm1h
eF9uX3NoaWZ0ID0gY21kcS0+cS5sbHEubWF4X25fc2hpZnQ7Cj4+ICsKPj4gwqDCoMKgwqDCoCAv
KiAxLiBBbGxvY2F0ZSBzb21lIHNwYWNlIGluIHRoZSBxdWV1ZSAqLwo+PiDCoMKgwqDCoMKgIGxv
Y2FsX2lycV9zYXZlKGZsYWdzKTsKPj4gwqDCoMKgwqDCoCBsbHEudmFsID0gUkVBRF9PTkNFKGNt
ZHEtPnEubGxxLnZhbCk7Cj4+Cj4gLgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5k
YXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2lvbW11
