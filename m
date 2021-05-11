Return-Path: <SRS0=AxcK=KG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AF0FC43461
	for <iommu@archiver.kernel.org>; Tue, 11 May 2021 16:05:56 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0D266193D
	for <iommu@archiver.kernel.org>; Tue, 11 May 2021 16:05:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0D266193D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BA34940565;
	Tue, 11 May 2021 16:05:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SwdjXbO9BenN; Tue, 11 May 2021 16:05:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2713640529;
	Tue, 11 May 2021 16:05:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 038F2C000E;
	Tue, 11 May 2021 16:05:54 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4EB45C0001
 for <iommu@lists.linux-foundation.org>; Tue, 11 May 2021 16:05:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2D688404F9
 for <iommu@lists.linux-foundation.org>; Tue, 11 May 2021 16:05:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qEu2mUlIf3sC for <iommu@lists.linux-foundation.org>;
 Tue, 11 May 2021 16:05:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E104340506
 for <iommu@lists.linux-foundation.org>; Tue, 11 May 2021 16:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1620749149;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hrrdEBLqCOmDZJ+zOkXaPF7O/7nbLIRMtWhGOzsY1Zc=;
 b=VWa2s+HwWpIWWJZ/Mxn6LNjjw07GiLIJOYVupnNLLEZQ3UmkJvF6f8N3ZyqQib/44gGkUG
 59OEIonBN6Ch9KGHK0T9kDhtEri7CuFUY4xxZqWiLQ1g8cJsPXiIgje77i273RiR4hQc4M
 IJn9MECMDwER/zy6vbOwi5mbJMjYmFI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-411-IY58VNbdOuCPlC-_betBlg-1; Tue, 11 May 2021 12:05:47 -0400
X-MC-Unique: IY58VNbdOuCPlC-_betBlg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4CE848186E1;
 Tue, 11 May 2021 16:05:44 +0000 (UTC)
Received: from [10.3.115.19] (ovpn-115-19.phx2.redhat.com [10.3.115.19])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0AD745D9F2;
 Tue, 11 May 2021 16:05:40 +0000 (UTC)
Subject: Re: [PATCH 02/16] PCI/P2PDMA: Avoid pci_get_slot() which sleeps
To: John Hubbard <jhubbard@nvidia.com>, Logan Gunthorpe
 <logang@deltatee.com>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org
References: <20210408170123.8788-1-logang@deltatee.com>
 <20210408170123.8788-3-logang@deltatee.com>
 <d6220bff-83fc-6c03-76f7-32e9e00e40fd@nvidia.com>
From: Don Dutile <ddutile@redhat.com>
Message-ID: <a6830332-c866-451f-3c6a-585cbf295ff8@redhat.com>
Date: Tue, 11 May 2021 12:05:40 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <d6220bff-83fc-6c03-76f7-32e9e00e40fd@nvidia.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Cc: Minturn Dave B <dave.b.minturn@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Daniel Vetter <daniel.vetter@ffwll.ch>,
 Dave Hansen <dave.hansen@linux.intel.com>, Robin Murphy <robin.murphy@arm.com>,
 Matthew Wilcox <willy@infradead.org>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Bjorn Helgaas <helgaas@kernel.org>,
 Jason Ekstrand <jason@jlekstrand.net>, Dan Williams <dan.j.williams@intel.com>,
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

T24gNS8yLzIxIDE6MzUgQU0sIEpvaG4gSHViYmFyZCB3cm90ZToKPiBPbiA0LzgvMjEgMTA6MDEg
QU0sIExvZ2FuIEd1bnRob3JwZSB3cm90ZToKPj4gSW4gb3JkZXIgdG8gdXNlIHVwc3RyZWFtX2Jy
aWRnZV9kaXN0YW5jZV93YXJuKCkgZnJvbSBhIGRtYV9tYXAgZnVuY3Rpb24sCj4+IGl0IG11c3Qg
bm90IHNsZWVwLiBIb3dldmVyLCBwY2lfZ2V0X3Nsb3QoKSB0YWtlcyB0aGUgcGNpX2J1c19zZW0g
c28gaXQKPj4gbWlnaHQgc2xlZXAuCj4+Cj4+IEluIG9yZGVyIHRvIGF2b2lkIHRoaXMsIHRyeSB0
byBnZXQgdGhlIGhvc3QgYnJpZGdlJ3MgZGV2aWNlIGZyb20KPj4gYnVzLT5zZWxmLCBhbmQgaWYg
dGhhdCBpcyBub3Qgc2V0LCBqdXN0IGdldCB0aGUgZmlyc3QgZWxlbWVudCBpbiB0aGUKPj4gZGV2
aWNlIGxpc3QuIEl0IHNob3VsZCBiZSBpbXBvc3NpYmxlIGZvciB0aGUgaG9zdCBicmlkZ2UncyBk
ZXZpY2UgdG8KPj4gZ28gYXdheSB3aGlsZSByZWZlcmVuY2VzIGFyZSBoZWxkIG9uIGNoaWxkIGRl
dmljZXMsIHNvIHRoZSBmaXJzdCBlbGVtZW50Cj4+IHNob3VsZCBub3QgYmUgYWJsZSB0byBjaGFu
Z2UgYW5kLCB0aHVzLCB0aGlzIHNob3VsZCBiZSBzYWZlLgo+Pgo+PiBTaWduZWQtb2ZmLWJ5OiBM
b2dhbiBHdW50aG9ycGUgPGxvZ2FuZ0BkZWx0YXRlZS5jb20+Cj4+IC0tLQo+PiDCoCBkcml2ZXJz
L3BjaS9wMnBkbWEuYyB8IDE0ICsrKysrKysrKysrKy0tCj4+IMKgIDEgZmlsZSBjaGFuZ2VkLCAx
MiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQo+Pgo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9wY2kvcDJwZG1hLmMgYi9kcml2ZXJzL3BjaS9wMnBkbWEuYwo+PiBpbmRleCBiZDg5NDM3ZmFm
MDYuLjQ3M2EwODk0MGZiYyAxMDA2NDQKPj4gLS0tIGEvZHJpdmVycy9wY2kvcDJwZG1hLmMKPj4g
KysrIGIvZHJpdmVycy9wY2kvcDJwZG1hLmMKPj4gQEAgLTMxMSwxNiArMzExLDI2IEBAIHN0YXRp
YyBjb25zdCBzdHJ1Y3QgcGNpX3AycGRtYV93aGl0ZWxpc3RfZW50cnkgewo+PiDCoCBzdGF0aWMg
Ym9vbCBfX2hvc3RfYnJpZGdlX3doaXRlbGlzdChzdHJ1Y3QgcGNpX2hvc3RfYnJpZGdlICpob3N0
LAo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYm9vbCBzYW1l
X2hvc3RfYnJpZGdlKQo+PiDCoCB7Cj4+IC3CoMKgwqAgc3RydWN0IHBjaV9kZXYgKnJvb3QgPSBw
Y2lfZ2V0X3Nsb3QoaG9zdC0+YnVzLCBQQ0lfREVWRk4oMCwgMCkpOwo+PiDCoMKgwqDCoMKgIGNv
bnN0IHN0cnVjdCBwY2lfcDJwZG1hX3doaXRlbGlzdF9lbnRyeSAqZW50cnk7Cj4+ICvCoMKgwqAg
c3RydWN0IHBjaV9kZXYgKnJvb3QgPSBob3N0LT5idXMtPnNlbGY7Cj4+IMKgwqDCoMKgwqAgdW5z
aWduZWQgc2hvcnQgdmVuZG9yLCBkZXZpY2U7Cj4+IMKgICvCoMKgwqAgLyoKPj4gK8KgwqDCoMKg
ICogVGhpcyBtYWtlcyB0aGUgYXNzdW1wdGlvbiB0aGF0IHRoZSBmaXJzdCBkZXZpY2Ugb24gdGhl
IGJ1cyBpcyB0aGUKPj4gK8KgwqDCoMKgICogYnJpZGdlIGl0c2VsZiBhbmQgaXQgaGFzIHRoZSBk
ZXZmbiBvZiAwMC4wLiBUaGlzIGFzc3VtcHRpb24gc2hvdWxkCj4+ICvCoMKgwqDCoCAqIGhvbGQg
Zm9yIHRoZSBkZXZpY2VzIGluIHRoZSB3aGl0ZSBsaXN0IGFib3ZlLCBhbmQgaWYgdGhlcmUgYXJl
IGNhc2VzCj4+ICvCoMKgwqDCoCAqIHdoZXJlIHRoaXMgaXNuJ3QgdHJ1ZSB0aGV5IHdpbGwgaGF2
ZSB0byBiZSBkZWFsdCB3aXRoIHdoZW4gc3VjaCBhCj4+ICvCoMKgwqDCoCAqIGNhc2UgaXMgYWRk
ZWQgdG8gdGhlIHdoaXRlbGlzdC4KPgo+IEFjdHVhbGx5LCBpdCBtYWtlcyB0aGUgYXNzdW1wdGlv
biB0aGF0IHRoZSBmaXJzdCBkZXZpY2UgKmluIHRoZSBsaXN0Kgo+ICh0aGUgaG9zdC0+YnVzLWRl
dmljZXMgbGlzdCkgaXMgMDAuMC7CoCBUaGUgcHJldmlvdXMgY29kZSBtYWRlIHRoZQo+IGFzc3Vt
cHRpb24gdGhhdCB5b3Ugd3JvdGUuCj4KPiBCeSB0aGUgd2F5LCBwcmUtZXhpc3RpbmcgY29kZSBj
b21tZW50OiBwY2lfcDJwZG1hX3doaXRlbGlzdFtdIHNlZW1zCj4gcmVhbGx5IHNob3J0LiBGcm9t
IGEgbmFpdmUgcG9pbnQgb2YgdmlldywgSSdkIGV4cGVjdCB0aGF0IHRoZXJlIG11c3QgYmUKPiBh
IGxvdCBtb3JlIENQVXMvY2hpcHNldHMgdGhhdCBjYW4gZG8gcGNpIHAycCwgd2hhdCBkbyB5b3Ug
dGhpbms/IEkKPiB3b25kZXIgaWYgd2UgaGF2ZSB0byBiZSBzbyBzdXBlciBzdHJpY3QsIGFueXdh
eS4gSXQganVzdCBzZWVtcyBleHRyZW1lbHkKPiBsaW1pdGVkLCBhbmQgSSBzdXNwZWN0IHRoZXJl
IHdpbGwgYmUgc29tZSBhZGRpdGlvbnMgdG8gdGhlIGxpc3QgYXMgc29vbgo+IGFzIHdlIHN0YXJ0
IHRvIHVzZSB0aGlzLgo+Cj4KPj4gK8KgwqDCoMKgICovCj4+IMKgwqDCoMKgwqAgaWYgKCFyb290
KQo+PiArwqDCoMKgwqDCoMKgwqAgcm9vdCA9IGxpc3RfZmlyc3RfZW50cnlfb3JfbnVsbCgmaG9z
dC0+YnVzLT5kZXZpY2VzLAo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBzdHJ1Y3QgcGNpX2RldiwgYnVzX2xpc3QpOwo+Cj4gT0ssIHllcyB0aGlzIGF2
b2lkcyB0YWtpbmcgdGhlIHBjaV9idXNfc2VtLCBidXQgaXQncyBraW5kIG9mIGNoZWF0aW5nLgo+
IFdoeSBpcyBpdCBPSyB0byBhdm9pZCB0YWtpbmcgYW55IGxvY2tzIGluIG9yZGVyIHRvIHJldHJp
ZXZlIHRoZQo+IGZpcnN0IGVudHJ5IGZyb20gdGhlIGxpc3QsIGJ1dCBpbiBvcmRlciB0byByZXRy
aWV2ZSBhbnkgb3RoZXIgZW50cnksIHlvdQo+IGhhdmUgdG8gYXF1aXJlIHRoZSBwY2lfYnVzX3Nl
bSwgYW5kIGdldCBhIHJlZmVyZW5jZSBhcyB3ZWxsPyBTb21ldGhpbmcKPiBpcyBpbmNvbnNpc3Rl
bnQgdGhlcmUuCj4KPiBUaGUgbmV3IHZlcnNpb24gaGVyZSBhbHNvIG5vIGxvbmdlciB0YWtlcyBh
IHJlZmVyZW5jZSBvbiB0aGUgZGV2aWNlLAo+IHdoaWNoIGlzIGFsc28gY2hlYXRpbmcuIEJ1dCBJ
J20gZ3Vlc3NpbmcgdGhhdCB0aGUgdW5zdGF0ZWQgYXNzdW1wdGlvbgo+IGhlcmUgaXMgdGhhdCB0
aGVyZSBpcyBhbHdheXMgYXQgbGVhc3Qgb25lIGVudHJ5IGluIHRoZSBsaXN0LiBCdXQgaWYKPiB0
aGF0J3MgdHJ1ZSwgdGhlbiBpdCdzIGJldHRlciB0byBzaG93IGNsZWFybHkgdGhhdCBhc3N1bXB0
aW9uLCBpbnN0ZWFkCj4gb2YgaGlkaW5nIGl0IGluIGFuIGltcGxpY2l0IGNhbGwgdGhhdCBza2lw
cyBib3RoIGxvY2tpbmcgYW5kIHJlZmVyZW5jZQo+IGNvdW50aW5nLgo+Cj4gWW91IGNvdWxkIGFk
ZCBhIG5ldyBmdW5jdGlvbiwgd2hpY2ggaXMgYSBjdXQtZG93biB2ZXJzaW9uIG9mIHBjaV9nZXRf
c2xvdCgpLAo+IGxpa2UgdGhpcywgYW5kIGNhbGwgdGhpcyBmcm9tIF9faG9zdF9icmlkZ2Vfd2hp
dGVsaXN0KCk6Cj4KPiAvKgo+IMKgKiBBIHNwZWNpYWwgcHVycG9zZSB2YXJpYW50IG9mIHBjaV9n
ZXRfc2xvdCgpIHRoYXQgZG9lc24ndCB0YWtlIHRoZSBwY2lfYnVzX3NlbQo+IMKgKiBsb2NrLCBh
bmQgb25seSBsb29rcyBmb3IgdGhlIDAwLjAgYnVzLWRldmljZS1mdW5jdGlvbi4gT25jZSB0aGUg
UENJIGJ1cyBpcwo+IMKgKiB1cCwgaXQgaXMgc2FmZSB0byBjYWxsIHRoaXMsIGJlY2F1c2UgdGhl
cmUgd2lsbCBhbHdheXMgYmUgYSB0b3AtbGV2ZWwgUENJCj4gwqAqIHJvb3QgZGV2aWNlLgo+IMKg
Kgo+IMKgKiBPdGhlciBhc3N1bXB0aW9uczogdGhlIHJvb3QgZGV2aWNlIGlzIHRoZSBmaXJzdCBk
ZXZpY2UgaW4gdGhlIGxpc3QsIGFuZCB0aGUKPiDCoCogcm9vdCBkZXZpY2UgaXMgbnVtYmVyZWQg
MDAuMC4KPiDCoCovCj4gc3RydWN0IHBjaV9kZXYgKnBjaV9nZXRfcm9vdF9zbG90KHN0cnVjdCBw
Y2lfYnVzICpidXMpCj4gewo+IMKgwqDCoMKgc3RydWN0IHBjaV9kZXYgKnJvb3Q7Cj4gwqDCoMKg
wqB1bnNpZ25lZCBkZXZmbiA9IFBDSV9ERVZGTigwLCAwKTsKPgo+IMKgwqDCoMKgcm9vdCA9IGxp
c3RfZmlyc3RfZW50cnlfb3JfbnVsbCgmYnVzLT5kZXZpY2VzLCBzdHJ1Y3QgcGNpX2RldiwKPiDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBidXNfbGlzdCk7Cj4gwqDCoMKg
wqBpZiAocm9vdC0+ZGV2Zm4gPT0gZGV2Zm4pCj4gwqDCoMKgwqDCoMKgwqAgZ290byBvdXQ7Cj4K
Li4uIGFkZCBhIGZsYWcgKHNldCBmb3IgcDJwZG1hIHVzZSnCoCB0byB0aGUgZnVuY3Rpb24gdG8g
cHJpbnQgb3V0IHdoYXQgdGhlIHJvb3QtPmRldmZuIGlzLCBhbmQgd2hhdAp0aGUgZGV2aWNlIGlz
IHNvIHRoZSBuZWVkZWQgcXVpcmsgJi9vciBtb2RpZmljYXRpb24gY2FuIGFkZGVkIHRvIGhhbmRs
ZSB3aGVuIHRoaXMgYXNzdW1wdGlvbiBmYWlsczsKb3IgbWFrZSBpdCBhIHByZGVidWcgdGhhdCBj
YW4gYmUgZmxpcHBlZCBvbiBmb3IgdGhpcyBmYWlsaW5nIHNpdHVhdGlvbiwgYWdhaW4sIHRvIGFk
ZCBuZWVkZWQgY2hhbmdlIHRvIGFjY29tb2RhdGUuCgo+IMKgwqDCoMKgcm9vdCA9IE5VTEw7Cj4g
wqBvdXQ6Cj4gwqDCoMKgwqBwY2lfZGV2X2dldChyb290KTsKPiDCoMKgwqDCoHJldHVybiByb290
Owo+IH0KPiBFWFBPUlRfU1lNQk9MKHBjaV9nZXRfcm9vdF9zbG90KTsKPgo+IC4uLkkgdGhpbmsg
dGhhdCdzIGEgbG90IGNsZWFyZXIgdG8gdGhlIHJlYWRlciwgYWJvdXQgd2hhdCdzIGdvaW5nIG9u
IGhlcmUuCj4KPiBOb3RlIHRoYXQgSSdtIG5vdCByZWFsbHkgc3VyZSBpZiBpdCAqaXMqIHNhZmUs
IEkgd291bGQgbmVlZCB0byBhc2sgb3RoZXIKPiBQQ0llIHN1YnN5c3RlbSBkZXZlbG9wZXJzIHdp
dGggbW9yZSBleHBlcmllbmNlLiBCdXQgSSBkb24ndCB0aGluayBhbnlvbmUKPiBpcyB0cnlpbmcg
dG8gbWFrZSBwMnBkbWEgY2FsbHMgc28gZWFybHkgdGhhdCBQQ0llIGJ1c2VzIGFyZSB1bmluaXRp
YWxpemVkLgo+Cj4KPj4gKwo+PiArwqDCoMKgIGlmICghcm9vdCB8fCByb290LT5kZXZmbikKPj4g
wqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiBmYWxzZTsKPj4gwqAgwqDCoMKgwqDCoCB2ZW5kb3Ig
PSByb290LT52ZW5kb3I7Cj4+IMKgwqDCoMKgwqAgZGV2aWNlID0gcm9vdC0+ZGV2aWNlOwo+PiAt
wqDCoMKgIHBjaV9kZXZfcHV0KHJvb3QpOwphbmQgdGhlIHJlYXNvbiB0byByZW1vdmUgdGhlIGRl
dl9wdXQgaXMgYi9jIGl0IGNhbiBzbGVlcCBhcyB3ZWxsPwppcyB0aGF0IG9rLCBnaXZlbiB0aGUg
ZGV2X2dldCB0aGF0IEpvaG4gcHV0IGludG8gdGhlIG5ldyBwY2lfZ2V0X3Jvb3Rfc2xvdCgpPwou
Li4gc2VlbXMgbGlrZSBhIGxvY2tpbmcgdmVyc2lvbiB3aXRoIG5vIGdldC9wdXQncyBpcyBuZWVk
ZWQsIG9yLCBmaXggdGhlIGhvc3QtYnJpZGdlIHNldHVwcyBzbyBubyAhTlVMTCBzZWxmIHBvaW50
ZXJzLgoKCj4+IMKgIMKgwqDCoMKgwqAgZm9yIChlbnRyeSA9IHBjaV9wMnBkbWFfd2hpdGVsaXN0
OyBlbnRyeS0+dmVuZG9yOyBlbnRyeSsrKSB7Cj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAodmVu
ZG9yICE9IGVudHJ5LT52ZW5kb3IgfHwgZGV2aWNlICE9IGVudHJ5LT5kZXZpY2UpCj4+Cj4KPiB0
aGFua3MsCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpp
b21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6
Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
