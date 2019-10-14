Return-Path: <SRS0=ZipC=YH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6D18C4CECE
	for <iommu@archiver.kernel.org>; Mon, 14 Oct 2019 15:02:00 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7485C2133F
	for <iommu@archiver.kernel.org>; Mon, 14 Oct 2019 15:02:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7485C2133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 225A326CC;
	Mon, 14 Oct 2019 15:02:00 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id EA44A26C7
	for <iommu@lists.linux-foundation.org>;
	Mon, 14 Oct 2019 15:01:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id CA827831
	for <iommu@lists.linux-foundation.org>;
	Mon, 14 Oct 2019 15:01:56 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EDF51337;
	Mon, 14 Oct 2019 08:01:55 -0700 (PDT)
Received: from [10.1.32.128] (e121487-lin.cambridge.arm.com [10.1.32.128])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 91D953F68E;
	Mon, 14 Oct 2019 08:01:54 -0700 (PDT)
Subject: Re: [BUG] dma-ranges, reserved memory regions, dma_alloc_coherent:
	possible bug?
To: Robin Murphy <robin.murphy@arm.com>,
	Daniele Alessandrelli <daniele.alessandrelli@gmail.com>,
	Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>
References: <CAA2QUqLv+eLXuA_TdJ7zM4oBnGoFVOjRjAimuct2y=0MDuaZVQ@mail.gmail.com>
	<d983cf57-f13d-a680-21c4-09b5ca93bc64@arm.com>
From: Vladimir Murzin <vladimir.murzin@arm.com>
Message-ID: <acf0dd2c-7e12-fba6-b7f8-dfd78c892fe5@arm.com>
Date: Mon, 14 Oct 2019 16:01:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <d983cf57-f13d-a680-21c4-09b5ca93bc64@arm.com>
Content-Language: en-US
Cc: iommu@lists.linux-foundation.org, alexandre.torgue@st.com,
	Arnd Bergmann <arnd@arndb.de>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

T24gMTAvMTQvMTkgMjo1NCBQTSwgUm9iaW4gTXVycGh5IHdyb3RlOgo+IE9uIDEzLzEwLzIwMTkg
MTU6MjgsIERhbmllbGUgQWxlc3NhbmRyZWxsaSB3cm90ZToKPj4gSGksCj4+Cj4+IEl0IGxvb2tz
IGxpa2UgZG1hX2FsbG9jX2NvaGVyZW50KCkgaXMgc2V0dGluZyB0aGUgZG1hX2hhbmRsZSBvdXRw
dXQKPj4gcGFyYW1ldGVyIHRvIHRoZSBtZW1vcnkgcGh5c2ljYWwgYWRkcmVzcyBhbmQgbm90IHRo
ZSBkZXZpY2UgYnVzCj4+IGFkZHJlc3Mgd2hlbiB0aGUgZGV2aWNlIGlzIHVzaW5nIHJlc2VydmVk
IG1lbW9yeSByZWdpb25zIGZvciBETUEKPj4gYWxsb2NhdGlvbi4gVGhpcyBpcyBkZXNwaXRlIHVz
aW5nICdkbWFfcmFuZ2VzJyBpbiB0aGUgZGV2aWNlIHRyZWUgdG8KPj4gZGVzY3JpYmUgdGhlIERN
QSBtZW1vcnkgbWFwcGluZy4gSXMgdGhpcyBleHBlY3RlZCBiZWhhdmlvciBvciBhIGJ1Zz8KPiAK
PiBUaGF0IGRvZXMgc291bmQgbGlrZSBhIGJ1ZyA6KAo+IAo+PiBIZXJlIGlzIGEgcmVkdWNlZCB2
ZXJzaW9uIG9mIHRoZSBkZXZpY2UgdHJlZSBJJ20gdXNpbmc6Cj4+IFwgewo+PiDCoMKgwqDCoMKg
wqDCoMKgIHJlc2VydmVkLW1lbW9yeSB7Cj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgICNhZGRyZXNzLWNlbGxzID0gPDI+Owo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCAjc2l6ZS1jZWxscyA9IDwyPjsKPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgcmFuZ2VzOwo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBteWRldl9yc3Zk
OiByc3ZkX21lbUA0OTQ4MDAwMDAgewo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgY29tcGF0aWJsZSA9ICJzaGFyZWQtZG1hLXBvb2wiOwo+PiDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmVnID0gPDB4NCAw
eDk0ODAwMDAwIDB4MCAweDIwMDAwMD47Cj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBuby1tYXA7Cj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIH07Cj4+IMKgwqDCoMKgwqDCoMKgwqAgfTsKPj4gwqDCoMKgwqDCoMKgwqDCoCBzb2Mg
ewo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjb21wYXRpYmxlID0gInNpbXBs
ZS1idXMiOwo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAjYWRkcmVzcy1jZWxs
cyA9IDwyPjsKPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgI3NpemUtY2VsbHMg
PSA8Mj47Cj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJhbmdlczsKPj4gwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZG1hX3JhbmdlczsKPj4KPj4gwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbXlidXMgewo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmFuZ2VzID0gPD47Cj4+IMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBkbWEtcmFuZ2VzID0gPD47Cj4+IMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjb21wYXRpYmxl
ID0gInNpbXBsZS1idXMiOwo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgI2FkZHJlc3MtY2VsbHMgPSA8Mj47Cj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAjc2l6ZS1jZWxscyA9IDwyPjsKPj4gwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJhbmdlcyA9wqDCoMKg
wqAgPDB4MCAweDDCoCAweDAgMHgwwqAgMHgwIDB4ODAwMDAwMDA+Owo+PiDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZG1hLXJhbmdlcyA9IDwweDAgMHg4
MDAwMDAwMMKgIDB4NCAweDgwMDAwMDAwCj4+IDB4MCAweDgwMDAwMDAwPjsKPj4KPj4gwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIG15ZGV2aWNlIHsKPj4g
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBjb21wYXRpYmxlID0gIm15LWNvbXBhdGlibGUtc3RyaW5nIjsKPj4gwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBt
ZW1vcnktcmVnaW9uID0gPCZteWRldl9yc3ZkPjsKPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIH0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgfQo+PiDCoMKgwqDCoMKgwqDCoMKgIH0KPj4gfTsKPj4KPj4gSXQgbG9va3MgbGlrZSB0
aGlzIGlzc3VlIHdhcyBwcmV2aW91c2x5IGZpeGVkIGJ5IGNvbW1pdCBjNDFmOWVhOTk4ZjMKPj4g
KCJkcml2ZXJzOiBkbWEtY29oZXJlbnQ6IEFjY291bnQgZG1hX3Bmbl9vZmZzZXQgd2hlbiB1c2Vk
IHdpdGggZGV2aWNlCj4+IHRyZWUiKSB3aGljaCBpbnRyb2R1Y2VkIGEgbmV3IGZ1bmN0aW9uICgn
ZG1hX2dldF9kZXZpY2VfYmFzZSgpJykgdG8KPj4gcmV0dXJuIHRoZSByZXNlcnZlZCBtZW1vcnkg
YWRkcmVzcyBhcyBzZWVuIGJ5IHRoZSBkZXZpY2UuIEhvd2V2ZXIsCj4+IHN1Y2ggYSBmdW5jdGlv
biwgZXZlbiBpZiBzdGlsbCB0aGVyZSwgaXMgbm90IHVzZWQgYW55bW9yZSBpbiBsYXRlc3QKPj4g
Y29kZSAoYXMgb2YgdjUuNC1yYzIpLiBXYXMgdGhhdCBkb25lIGZvciBhIHNwZWNpZmljIHJlYXNv
bj8gT3IgaXMgaXQKPj4ganVzdCBhIG1pc3Rha2U/Cj4gCj4gSG1tLCBpdCBsb29rcyBsaWtlIDQz
ZmM1MDljM2VmYiAoImRtYS1jb2hlcmVudDogaW50cm9kdWNlIGludGVyZmFjZSBmb3IgZGVmYXVs
dCBETUEgcG9vbCIpIHJlbW92ZWQgdGhlIGNhbGxlciBvZiBkbWFfZ2V0X2RldmljZV9iYXNlKCkg
aW4gdGhlIGFsbG9jIHBhdGggc2hvcnRseSBhZnRlciBpdCB3YXMgaW50cm9kdWNlZCwgd2hpY2gg
Y2VydGFpbmx5IGFwcGVhcnMgYXMgaWYgaXQgbWF5IGhhdmUgYmVlbiB1bmludGVudGlvbmFsIC0g
VmxhZGltaXI/CgpJIGRvIG5vdCByZW1lbWJlciBpdCB3YXMgaW50ZW50aW9uYWwuIExvb2tpbmcg
YXQgaGlzdG9yeSwgZGVmYXVsdCBETUEgcG9vbCB3YXMgYSByZXNwb25zZQp0byBhbm90aGVyIHJl
cG9ydC4gSG93ZXZlciwgbm93IEknbSB3b25kZXJpbmcgd2h5IGl0IHdhcyBub3QgY2F1Z2h0IGJ5
IFNUTTMyIC0gbW9zdCBvZiB0aGF0Cndvcmsgd2FzIHJlcXVpcmVkIHRvIHN1cHBvcnQgImRtYS1y
YW5nZXMiIHdpdGggTk9NTVUrY2FjaGVzIChDb3J0ZXgtTTcpLgoKQWxleCAob3IgYW55Ym9keSBl
bHNlIGZyb20gU1QpLCBtYXliZSB5b3UgaGF2ZSBzb21lIGlucHV0PwoKQ2hlZXJzClZsYWRpbWly
Cgo+IAo+IFJvYmluLgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3Jn
Cmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
