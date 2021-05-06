Return-Path: <SRS0=J567=KB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	URIBL_RED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D160C43470
	for <iommu@archiver.kernel.org>; Thu,  6 May 2021 23:59:46 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7768D61164
	for <iommu@archiver.kernel.org>; Thu,  6 May 2021 23:59:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7768D61164
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3A940404EB;
	Thu,  6 May 2021 23:59:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id V0ex5v8_hCoa; Thu,  6 May 2021 23:59:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 87066404EE;
	Thu,  6 May 2021 23:59:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5F5B6C000D;
	Thu,  6 May 2021 23:59:43 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 75C85C0001
 for <iommu@lists.linux-foundation.org>; Thu,  6 May 2021 23:59:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 64658608BB
 for <iommu@lists.linux-foundation.org>; Thu,  6 May 2021 23:59:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=deltatee.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id D268kuMVJMgR for <iommu@lists.linux-foundation.org>;
 Thu,  6 May 2021 23:59:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 79F1A60622
 for <iommu@lists.linux-foundation.org>; Thu,  6 May 2021 23:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:Cc:To:content-disposition;
 bh=lutt0mRx1qejbd/KzcxWOBkc0pyjO3VgQZn/+HsAIag=; b=tOkHvek+83IjhQiCfL3GVpPHEz
 LbEurXfHUNzzROcmLSSaXdORwYe+S8wQ6YjP5FgHzL9zkBxCjtspkcXueFktPt+htL2KCkKjDRsVz
 XNPqDPGyecK4bVgZjR7aY4L+2UdND3io9SpayZY9JC9Uy3qCZf1PBs5rh0jltsjsMA/11ad/lPH5t
 6D8zdFq+sLfJGKtZwY1Pnu6OienaGECcsL3fXAMUzp0UrL3pnzVq2Q+UHbYalfgJfJ62E3S4NkH7S
 pPOK7AfODC/AgmfHxvesokiRhS/Kv0C7N5MH0STByLV9tzPPH4hzVaNIbd0DDNo4be13qKrwmr3gV
 I6qRFqDw==;
Received: from s01060023bee90a7d.cg.shawcable.net ([24.64.145.4]
 helo=[192.168.0.10])
 by ale.deltatee.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <logang@deltatee.com>)
 id 1lentq-0003Fs-1C; Thu, 06 May 2021 17:59:23 -0600
To: John Hubbard <jhubbard@nvidia.com>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org
References: <20210408170123.8788-1-logang@deltatee.com>
 <20210408170123.8788-12-logang@deltatee.com>
 <560b2653-ad00-9cc3-0645-df7aff278321@nvidia.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <196d2d78-2c63-74cf-743d-1f3322431f88@deltatee.com>
Date: Thu, 6 May 2021 17:59:09 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <560b2653-ad00-9cc3-0645-df7aff278321@nvidia.com>
Content-Language: en-CA
X-SA-Exim-Connect-IP: 24.64.145.4
X-SA-Exim-Rcpt-To: robin.murphy@arm.com, ira.weiny@intel.com,
 helgaas@kernel.org, jianxin.xiong@intel.com, dave.hansen@linux.intel.com,
 jason@jlekstrand.net, dave.b.minturn@intel.com, andrzej.jakowski@intel.com,
 daniel.vetter@ffwll.ch, willy@infradead.org, ddutile@redhat.com,
 christian.koenig@amd.com, jgg@ziepe.ca, dan.j.williams@intel.com, hch@lst.de,
 sbates@raithlin.com, iommu@lists.linux-foundation.org, linux-mm@kvack.org,
 linux-pci@vger.kernel.org, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 jhubbard@nvidia.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH 11/16] iommu/dma: Support PCI P2PDMA pages in dma-iommu
 map_sg
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Cc: Minturn Dave B <dave.b.minturn@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Daniel Vetter <daniel.vetter@ffwll.ch>,
 Dave Hansen <dave.hansen@linux.intel.com>, Robin Murphy <robin.murphy@arm.com>,
 Matthew Wilcox <willy@infradead.org>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Jason Ekstrand <jason@jlekstrand.net>,
 Bjorn Helgaas <helgaas@kernel.org>, Dan Williams <dan.j.williams@intel.com>,
 Stephen Bates <sbates@raithlin.com>,
 Jakowski Andrzej <andrzej.jakowski@intel.com>, Christoph Hellwig <hch@lst.de>,
 Xiong Jianxin <jianxin.xiong@intel.com>
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

U29ycnksIEkgdGhpbmsgSSBtaXNzZWQgcmVzcG9uZGluZyB0byB0aGlzIG9uZSBzbyBoZXJlIGFy
ZSB0aGUgYW5zd2VyczoKCk9uIDIwMjEtMDUtMDIgNzoxNCBwLm0uLCBKb2huIEh1YmJhcmQgd3Jv
dGU6Cj4gT24gNC84LzIxIDEwOjAxIEFNLCBMb2dhbiBHdW50aG9ycGUgd3JvdGU6Cj4+IFdoZW4g
YSBQQ0kgUDJQRE1BIHBhZ2UgaXMgc2Vlbiwgc2V0IHRoZSBJT1ZBIGxlbmd0aCBvZiB0aGUgc2Vn
bWVudAo+PiB0byB6ZXJvIHNvIHRoYXQgaXQgaXMgbm90IG1hcHBlZCBpbnRvIHRoZSBJT1ZBLiBU
aGVuLCBpbiBmaW5hbGlzZV9zZygpLAo+PiBhcHBseSB0aGUgYXBwcm9wcmlhdGUgYnVzIGFkZHJl
c3MgdG8gdGhlIHNlZ21lbnQuIFRoZSBJT1ZBIGlzIG5vdAo+PiBjcmVhdGVkIGlmIHRoZSBzY2F0
dGVybGlzdCBvbmx5IGNvbnNpc3RzIG9mIFAyUERNQSBwYWdlcy4KPj4KPj4gU2ltaWxhciB0byBk
bWEtZGlyZWN0LCB0aGUgc2dfbWFya19wY2lfcDJwZG1hKCkgZmxhZyBpcyB1c2VkIHRvCj4+IGlu
ZGljYXRlIGJ1cyBhZGRyZXNzIHNlZ21lbnRzLiBPbiB1bm1hcCwgUDJQRE1BIHNlZ21lbnRzIGFy
ZSBza2lwcGVkCj4+IG92ZXIgd2hlbiBkZXRlcm1pbmluZyB0aGUgc3RhcnQgYW5kIGVuZCBJT1ZB
IGFkZHJlc3Nlcy4KPj4KPj4gV2l0aCB0aGlzIGNoYW5nZSwgdGhlIGZsYWdzIHZhcmlhYmxlIGlu
IHRoZSBkbWFfbWFwX29wcyBpcwo+PiBzZXQgdG8gRE1BX0ZfUENJX1AyUERNQV9TVVBQT1JURUQg
dG8gaW5kaWNhdGUgc3VwcG9ydCBmb3IKPj4gUDJQRE1BIHBhZ2VzLgo+Pgo+PiBTaWduZWQtb2Zm
LWJ5OiBMb2dhbiBHdW50aG9ycGUgPGxvZ2FuZ0BkZWx0YXRlZS5jb20+Cj4+IC0tLQo+PiDCoCBk
cml2ZXJzL2lvbW11L2RtYS1pb21tdS5jIHwgNjYgKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKy0tLS0tCj4+IMKgIDEgZmlsZSBjaGFuZ2VkLCA1OCBpbnNlcnRpb25zKCspLCA4IGRl
bGV0aW9ucygtKQo+Pgo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pb21tdS9kbWEtaW9tbXUuYyBi
L2RyaXZlcnMvaW9tbXUvZG1hLWlvbW11LmMKPj4gaW5kZXggYWY3NjVjODEzY2M4Li5lZjQ5NjM1
Zjk4MTkgMTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMvaW9tbXUvZG1hLWlvbW11LmMKPj4gKysrIGIv
ZHJpdmVycy9pb21tdS9kbWEtaW9tbXUuYwo+PiBAQCAtMjAsNiArMjAsNyBAQAo+PiDCoCAjaW5j
bHVkZSA8bGludXgvbW0uaD4KPj4gwqAgI2luY2x1ZGUgPGxpbnV4L211dGV4Lmg+Cj4+IMKgICNp
bmNsdWRlIDxsaW51eC9wY2kuaD4KPj4gKyNpbmNsdWRlIDxsaW51eC9wY2ktcDJwZG1hLmg+Cj4+
IMKgICNpbmNsdWRlIDxsaW51eC9zd2lvdGxiLmg+Cj4+IMKgICNpbmNsdWRlIDxsaW51eC9zY2F0
dGVybGlzdC5oPgo+PiDCoCAjaW5jbHVkZSA8bGludXgvdm1hbGxvYy5oPgo+PiBAQCAtODY0LDYg
Kzg2NSwxNiBAQCBzdGF0aWMgaW50IF9fZmluYWxpc2Vfc2coc3RydWN0IGRldmljZSAqZGV2LAo+
PiBzdHJ1Y3Qgc2NhdHRlcmxpc3QgKnNnLCBpbnQgbmVudHMsCj4+IMKgwqDCoMKgwqDCoMKgwqDC
oCBzZ19kbWFfYWRkcmVzcyhzKSA9IERNQV9NQVBQSU5HX0VSUk9SOwo+PiDCoMKgwqDCoMKgwqDC
oMKgwqAgc2dfZG1hX2xlbihzKSA9IDA7Cj4+IMKgICvCoMKgwqDCoMKgwqDCoCBpZiAoaXNfcGNp
X3AycGRtYV9wYWdlKHNnX3BhZ2UocykpICYmICFzX2lvdmFfbGVuKSB7Cj4gCj4gTmV3YmllIHF1
ZXN0aW9uOiBJJ20gaW4gdGhlIGRhcmsgYXMgdG8gd2h5IHRoZSAhc19pb3ZhX2xlbiBjaGVjayBp
cyB0aGVyZSwKPiBjYW4geW91IHBsZWFzZSBlbmxpZ2h0ZW4gbWU/CgpUaGUgbG9vcCBpbiBpb21t
dV9kbWFfbWFwX3NnKCkgd2lsbCBkZWNpZGUgd2hhdCB0byBkbyB3aXRoIFAyUERNQSBwYWdlcy4K
SWYgaXQgaXMgdG8gbWFwIGl0IHdpdGggdGhlIGJ1cyBhZGRyZXNzIGl0IHdpbGwgc2V0IHNfaW92
YV9sZW4gdG8gemVybwpzbyB0aGF0IG5vIHNwYWNlIGlzIGFsbG9jYXRlZCBpbiB0aGUgSU9WQS4g
SWYgaXQgaXMgdG8gbWFwIGl0IHRocm91Z2gKdGhlIGhvc3QgYnJpZGdlLCB0aGVuIGl0IGl0IHdp
bGwgbGVhdmUgc19pb3ZhX2xlbiBhbG9uZSBhbmQgY3JlYXRlIHRoZQphcHByb3ByaWF0ZSBtYXBw
aW5nIHdpdGggdGhlIENQVSBwaHlzaWNhbCBhZGRyZXNzLgoKVGhpcyBjb25kaXRpb24gbm90aWNl
cyB0aGF0IHNfaW92YV9sZW4gd2FzIHNldCB0byB6ZXJvIGFuZCBmaWxscyBpbiBhIFNHCnNlZ21l
bnQgd2l0aCB0aGUgUENJIGJ1cyBhZGRyZXNzIGZvciB0aGF0IHJlZ2lvbi4KCgo+IAo+PiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAoaSA+IDApCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgY3VyID0gc2dfbmV4dChjdXIpOwo+PiArCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIHBjaV9wMnBkbWFfbWFwX2J1c19zZWdtZW50KHMsIGN1cik7Cj4+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIGNvdW50Kys7Cj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGN1cl9sZW4gPSAw
Owo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjb250aW51ZTsKPj4gK8KgwqDCoMKgwqDCoMKg
IH0KPj4gKwo+IAo+IFRoaXMgaXMgcmVhbGx5IGFuIGlmL2Vsc2UgY29uZGl0aW9uLiBBbmQgYXJn
dWFibHksIGl0IHdvdWxkIGJlIGJldHRlcgo+IHRvIHNwbGl0IG91dCB0d28gc3Vicm91dGluZXMs
IGFuZCBjYWxsIG9uZSBvciB0aGUgb3RoZXIgZGVwZW5kaW5nIG9uCj4gdGhlIHJlc3VsdCBvZiBp
ZiBpc19wY2lfcDJwZG1hX3BhZ2UoKSwgaW5zdGVhZCBvZiB0aGlzICJjb250aW51ZSIgYXBwcm9h
Y2guCgpJIHJlYWxseSBkaXNhZ3JlZSBoZXJlLiBQdXR0aW5nIHRoZSBleGNlcHRpb25hbCBjb25k
aXRpb24gaW4gaXQncyBvd24gaWYKc3RhdGVtZW50IGFuZCBsZWF2aW5nIHRoZSBub3JtYWwgY2Fz
ZSB1bi1pbmRlbnRlZCBpcyBlYXNpZXIgdG8gcmVhZCBhbmQKdW5kZXJzdGFuZC4gSXQgYWxzbyBz
YXZlcyBhbiBleHRyYSBsZXZlbCBvZiBpbmRlbnRhdGlvbiBpbiBjb2RlIHRoYXQgaXMKYWxyZWFk
eSBzdGFydGluZyB0byBsb29rIGEgbGl0dGxlIHNxdWlzaGVkLgoKCj4+IMKgwqDCoMKgwqDCoMKg
wqDCoCAvKgo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqIE5vdyBmaWxsIGluIHRoZSByZWFsIERN
QSBkYXRhLiBJZi4uLgo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqIC0gdGhlcmUgaXMgYSB2YWxp
ZCBvdXRwdXQgc2VnbWVudCB0byBhcHBlbmQgdG8KPj4gQEAgLTk2MSwxMCArOTcyLDEyIEBAIHN0
YXRpYyBpbnQgaW9tbXVfZG1hX21hcF9zZyhzdHJ1Y3QgZGV2aWNlICpkZXYsCj4+IHN0cnVjdCBz
Y2F0dGVybGlzdCAqc2csCj4+IMKgwqDCoMKgwqAgc3RydWN0IGlvdmFfZG9tYWluICppb3ZhZCA9
ICZjb29raWUtPmlvdmFkOwo+PiDCoMKgwqDCoMKgIHN0cnVjdCBzY2F0dGVybGlzdCAqcywgKnBy
ZXYgPSBOVUxMOwo+PiDCoMKgwqDCoMKgIGludCBwcm90ID0gZG1hX2luZm9fdG9fcHJvdChkaXIs
IGRldl9pc19kbWFfY29oZXJlbnQoZGV2KSwgYXR0cnMpOwo+PiArwqDCoMKgIHN0cnVjdCBkZXZf
cGFnZW1hcCAqcGdtYXAgPSBOVUxMOwo+PiArwqDCoMKgIGVudW0gcGNpX3AycGRtYV9tYXBfdHlw
ZSBtYXBfdHlwZTsKPj4gwqDCoMKgwqDCoCBkbWFfYWRkcl90IGlvdmE7Cj4+IMKgwqDCoMKgwqAg
c2l6ZV90IGlvdmFfbGVuID0gMDsKPj4gwqDCoMKgwqDCoCB1bnNpZ25lZCBsb25nIG1hc2sgPSBk
bWFfZ2V0X3NlZ19ib3VuZGFyeShkZXYpOwo+PiAtwqDCoMKgIGludCBpOwo+PiArwqDCoMKgIGlu
dCBpLCByZXQgPSAwOwo+PiDCoCDCoMKgwqDCoMKgIGlmIChzdGF0aWNfYnJhbmNoX3VubGlrZWx5
KCZpb21tdV9kZWZlcnJlZF9hdHRhY2hfZW5hYmxlZCkgJiYKPj4gwqDCoMKgwqDCoMKgwqDCoMKg
IGlvbW11X2RlZmVycmVkX2F0dGFjaChkZXYsIGRvbWFpbikpCj4+IEBAIC05OTMsNiArMTAwNiwz
MSBAQCBzdGF0aWMgaW50IGlvbW11X2RtYV9tYXBfc2coc3RydWN0IGRldmljZSAqZGV2LAo+PiBz
dHJ1Y3Qgc2NhdHRlcmxpc3QgKnNnLAo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgc19sZW5ndGggPSBp
b3ZhX2FsaWduKGlvdmFkLCBzX2xlbmd0aCArIHNfaW92YV9vZmYpOwo+PiDCoMKgwqDCoMKgwqDC
oMKgwqAgcy0+bGVuZ3RoID0gc19sZW5ndGg7Cj4+IMKgICvCoMKgwqDCoMKgwqDCoCBpZiAoaXNf
cGNpX3AycGRtYV9wYWdlKHNnX3BhZ2UocykpKSB7Cj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IGlmIChzZ19wYWdlKHMpLT5wZ21hcCAhPSBwZ21hcCkgewo+PiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIHBnbWFwID0gc2dfcGFnZShzKS0+cGdtYXA7Cj4+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgbWFwX3R5cGUgPSBwY2lfcDJwZG1hX21hcF90eXBlKHBnbWFwLCBk
ZXYsCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBhdHRycyk7Cj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIH0K
Pj4gKwo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzd2l0Y2ggKG1hcF90eXBlKSB7Cj4+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNhc2UgUENJX1AyUERNQV9NQVBfQlVTX0FERFI6Cj4+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLyoKPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgICogQSB6ZXJvIGxlbmd0aCB3aWxsIGJlIGlnbm9yZWQgYnkKPj4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICogaW9tbXVfbWFwX3NnKCkgYW5kIHRoZW4gY2Fu
IGJlIGRldGVjdGVkCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqIGluIF9f
ZmluYWxpc2Vfc2coKSB0byBhY3R1YWxseSBtYXAgdGhlCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCAqIGJ1cyBhZGRyZXNzLgo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgKi8KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzLT5sZW5ndGgg
PSAwOwo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNvbnRpbnVlOwo+PiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBjYXNlIFBDSV9QMlBETUFfTUFQX1RIUlVfSE9TVF9CUklER0U6
Cj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYnJlYWs7Cj4+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIGRlZmF1bHQ6Cj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
cmV0ID0gLUVSRU1PVEVJTzsKPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBnb3Rv
IG91dF9yZXN0b3JlX3NnOwo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB9Cj4+ICvCoMKgwqDC
oMKgwqDCoCB9Cj4+ICsKPj4gwqDCoMKgwqDCoMKgwqDCoMKgIC8qCj4+IMKgwqDCoMKgwqDCoMKg
wqDCoMKgICogRHVlIHRvIHRoZSBhbGlnbm1lbnQgb2Ygb3VyIHNpbmdsZSBJT1ZBIGFsbG9jYXRp
b24sIHdlIGNhbgo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqIGRlcGVuZCBvbiB0aGVzZSBhc3N1
bXB0aW9ucyBhYm91dCB0aGUgc2VnbWVudCBib3VuZGFyeSBtYXNrOgo+PiBAQCAtMTAxNSw2ICsx
MDUzLDkgQEAgc3RhdGljIGludCBpb21tdV9kbWFfbWFwX3NnKHN0cnVjdCBkZXZpY2UgKmRldiwK
Pj4gc3RydWN0IHNjYXR0ZXJsaXN0ICpzZywKPj4gwqDCoMKgwqDCoMKgwqDCoMKgIHByZXYgPSBz
Owo+PiDCoMKgwqDCoMKgIH0KPj4gwqAgK8KgwqDCoCBpZiAoIWlvdmFfbGVuKQo+PiArwqDCoMKg
wqDCoMKgwqAgcmV0dXJuIF9fZmluYWxpc2Vfc2coZGV2LCBzZywgbmVudHMsIDApOwo+PiArCj4g
Cj4gb2hoaCwgd2UncmUgcmVhbGx5IHNsaWNpbmcgdXAgdGhpcyBmdW5jdGlvbiBwcmV0dHkgc2V2
ZXJlbHksIHdoYXQgd2l0aCB0aGUKPiBjb250aW51ZSBhbmQgdGhlIGVhcmx5IG91dCBhbmQgc2V2
ZXJhbCBvdGhlciBjb250cm9sIGZsb3cgY2hhbmdlcy4gSSB0aGluawo+IGl0IHdvdWxkIGJlIGJl
dHRlciB0byBzcGVuZCBzb21lIHRpbWUgZmFjdG9yaW5nIHRoaXMgZnVuY3Rpb24gaW50byB0d28K
PiBjYXNlcywgbm93IHRoYXQgeW91J3JlIGFkZGluZyBhIHNlY29uZCBjYXNlIGZvciBQQ0kgUDJQ
RE1BLiBSb3VnaGx5LAo+IHR3byBzdWJyb3V0aW5lcyB3b3VsZCBkbyBpdC4KCkkgZG9uJ3Qgc2Vl
IGhvdyB3ZSBjYW4gZmFjdG9yIHRoaXMgaW50byB0d28gY2FzZXMuIFRoZSBTR0wgbWF5IGNvbnRh
aW4Kbm9ybWFsIHBhZ2VzIG9yIFAyUERNQSBwYWdlcyBvciBhIG1peCBvZiBib3RoIGFuZCB3ZSBo
YXZlIHRvIGNyZWF0ZSBhbgpJT1ZBIGFyZWEgZm9yIGFsbCB0aGUgcmVnaW9ucyB0aGF0IG1hcCB0
aGUgQ1BVIHBoeXNpY2FsIGFkZHJlc3MgKGllCm5vcm1hbCBwYWdlcyBhbmQgc29tZSBQMlBETUEg
cGFnZXMpIHRoZW4gYWxzbyBpbnNlcnQgc2VnbWVudHMgZm9yIGFueQpQQ0kgYnVzIGFkZHJlc3Mu
Cgo+IEFzIGl0IGlzLCB0aGlzIGxlYXZlcyBiZWhpbmQgYSByb3V0aW5lIHRoYXQgaXMgZXh0cmVt
ZWx5IGhhcmQgdG8gbWVudGFsbHkKPiB2ZXJpZnkgYXMgY29ycmVjdC4KClllcywgdGhpcyBpcyB0
cmlja3kgY29kZSwgYnV0IG5vdCB0aGF0IGluY29tcHJlaGVuc2libGUuIE1vc3Qgb2YgdGhlCmRp
ZmZpY3VsdHkgaXMgaW4gdW5kZXJzdGFuZGluZyBob3cgaXQgd29ya3MgYmVmb3JlIGFkZGluZyB0
aGUgUDJQRE1BIGJpdHMuCgpUaGVyZSBhcmUgdHdvIGxvb3BzOiBvbmUgdG8gcHJlcGFyZSB0aGUg
SU9WQSByZWdpb24gYW5kIGFub3RoZXIgdG8gZmlsbAppbiB0aGUgU0dMLiBXZSBoYXZlIHRvIGFk
ZCBjYXNlcyBpbiBib3RoIGxvb3BzIHRvIHNraXAgdGhlIHNlZ21lbnRzIHRoYXQKbmVlZCB0byBi
ZSBtYXBwZWQgd2l0aCB0aGUgYnVzIGFkZHJlc3MgaW4gdGhlIGZpcnN0IGxvb3AsIGFuZCBpbnNl
cnQgdGhlCmRtYSBTR0wgc2VnbWVudHMgaW4gdGhlIHNlY29uZCBsb29wLgoKTG9nYW4KX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBs
aXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhm
b3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
