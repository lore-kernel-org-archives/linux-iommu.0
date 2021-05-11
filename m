Return-Path: <SRS0=AxcK=KG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E984C43611
	for <iommu@archiver.kernel.org>; Tue, 11 May 2021 16:06:43 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 223C46134F
	for <iommu@archiver.kernel.org>; Tue, 11 May 2021 16:06:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 223C46134F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B5BEA607DE;
	Tue, 11 May 2021 16:06:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pT-UsO3meJEm; Tue, 11 May 2021 16:06:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6B8B0607E3;
	Tue, 11 May 2021 16:06:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 44FD4C000E;
	Tue, 11 May 2021 16:06:41 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A19BFC0001
 for <iommu@lists.linux-foundation.org>; Tue, 11 May 2021 16:06:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9E871402BD
 for <iommu@lists.linux-foundation.org>; Tue, 11 May 2021 16:06:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dJCac3hr1Wyq for <iommu@lists.linux-foundation.org>;
 Tue, 11 May 2021 16:06:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A3DAD4028B
 for <iommu@lists.linux-foundation.org>; Tue, 11 May 2021 16:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1620749197;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XlWkZqQiA2f5P4YJIi6pLOwt0E2ferRdHsdF7okprNw=;
 b=TQ3yA/GBinwqYmKISS29ySeO+37+jjJAjW+Bf7DQXYRUNjdsaJww+R2fn+US9fgOD7jpBn
 ocTN/a0aYFkGlWztQ7Y1zt5wTSgqRqO1iTKfaWTLcvPrItmi/iFZ91Z5h+SlNdiDaIjYqt
 qLsK6/tv8TO+fhBDhV52SKRhnXerwT8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-592-cvtx_Gq3PWCfd3WMcpPXKw-1; Tue, 11 May 2021 12:06:33 -0400
X-MC-Unique: cvtx_Gq3PWCfd3WMcpPXKw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 48C60800D62;
 Tue, 11 May 2021 16:06:31 +0000 (UTC)
Received: from [10.3.115.19] (ovpn-115-19.phx2.redhat.com [10.3.115.19])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C5CFA614EB;
 Tue, 11 May 2021 16:06:28 +0000 (UTC)
Subject: Re: [PATCH 11/16] iommu/dma: Support PCI P2PDMA pages in dma-iommu
 map_sg
To: Logan Gunthorpe <logang@deltatee.com>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org
References: <20210408170123.8788-1-logang@deltatee.com>
 <20210408170123.8788-12-logang@deltatee.com>
From: Don Dutile <ddutile@redhat.com>
Message-ID: <6003ed3d-5969-4201-3cbb-3bcf84385541@redhat.com>
Date: Tue, 11 May 2021 12:06:28 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20210408170123.8788-12-logang@deltatee.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Cc: Minturn Dave B <dave.b.minturn@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 John Hubbard <jhubbard@nvidia.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 Robin Murphy <robin.murphy@arm.com>, Matthew Wilcox <willy@infradead.org>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Bjorn Helgaas <helgaas@kernel.org>,
 Jason Ekstrand <jason@jlekstrand.net>, Daniel Vetter <daniel.vetter@ffwll.ch>,
 Dan Williams <dan.j.williams@intel.com>, Stephen Bates <sbates@raithlin.com>,
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

T24gNC84LzIxIDE6MDEgUE0sIExvZ2FuIEd1bnRob3JwZSB3cm90ZToKPiBXaGVuIGEgUENJIFAy
UERNQSBwYWdlIGlzIHNlZW4sIHNldCB0aGUgSU9WQSBsZW5ndGggb2YgdGhlIHNlZ21lbnQKPiB0
byB6ZXJvIHNvIHRoYXQgaXQgaXMgbm90IG1hcHBlZCBpbnRvIHRoZSBJT1ZBLiBUaGVuLCBpbiBm
aW5hbGlzZV9zZygpLAo+IGFwcGx5IHRoZSBhcHByb3ByaWF0ZSBidXMgYWRkcmVzcyB0byB0aGUg
c2VnbWVudC4gVGhlIElPVkEgaXMgbm90Cj4gY3JlYXRlZCBpZiB0aGUgc2NhdHRlcmxpc3Qgb25s
eSBjb25zaXN0cyBvZiBQMlBETUEgcGFnZXMuCj4KPiBTaW1pbGFyIHRvIGRtYS1kaXJlY3QsIHRo
ZSBzZ19tYXJrX3BjaV9wMnBkbWEoKSBmbGFnIGlzIHVzZWQgdG8KPiBpbmRpY2F0ZSBidXMgYWRk
cmVzcyBzZWdtZW50cy4gT24gdW5tYXAsIFAyUERNQSBzZWdtZW50cyBhcmUgc2tpcHBlZAo+IG92
ZXIgd2hlbiBkZXRlcm1pbmluZyB0aGUgc3RhcnQgYW5kIGVuZCBJT1ZBIGFkZHJlc3Nlcy4KPgo+
IFdpdGggdGhpcyBjaGFuZ2UsIHRoZSBmbGFncyB2YXJpYWJsZSBpbiB0aGUgZG1hX21hcF9vcHMg
aXMKPiBzZXQgdG8gRE1BX0ZfUENJX1AyUERNQV9TVVBQT1JURUQgdG8gaW5kaWNhdGUgc3VwcG9y
dCBmb3IKPiBQMlBETUEgcGFnZXMuCj4KPiBTaWduZWQtb2ZmLWJ5OiBMb2dhbiBHdW50aG9ycGUg
PGxvZ2FuZ0BkZWx0YXRlZS5jb20+ClNvLCB0aGlzIGNvZGUgcHJldmVudHMgdXNlIG9mIHAycGRt
YSB1c2luZyBhbiBJT01NVSwgd2hpY2ggd2Fzbid0IGNoZWNrZWQgYW5kCnNob3J0LWNpcmN1aXRl
ZCBieSBvdGhlciBjaGVja3MgdG8gdXNlIGRtYS1kaXJlY3Q/CgpTbyBteSBvdmVyYWxsIGNvbW1l
bnQgdG8gdGhpcyBjb2RlICYgcmVsYXRlZCBjb21tZW50cyBpcyB0aGF0IGl0IHNob3VsZCBiZSBz
cHJpbmtsZWQKd2l0aCBub3RlcyBsaWtlICJkb2Vzbid0IHN1cHBvcnQgSU9NTVUiIGFuZCAvIG9y
ICJUT0RPIiB3aGVuL2lmIElPTU1VIGlzIHRvIGJlIHN1cHBvcnRlZC4KT3IsIGlmIElPTU1VLWJh
c2VkIHAycGRtYSBpc24ndCBzdXBwb3J0ZWQgaW4gdGhlc2Ugcm91dGluZXMgZGlyZWN0bHksIHdo
ZXJlL2hvdyB0aGV5IHdpbGwgYmUgc3VwcG9ydGVkPwoKPiAtLS0KPiAgIGRyaXZlcnMvaW9tbXUv
ZG1hLWlvbW11LmMgfCA2NiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0K
PiAgIDEgZmlsZSBjaGFuZ2VkLCA1OCBpbnNlcnRpb25zKCspLCA4IGRlbGV0aW9ucygtKQo+Cj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW9tbXUvZG1hLWlvbW11LmMgYi9kcml2ZXJzL2lvbW11L2Rt
YS1pb21tdS5jCj4gaW5kZXggYWY3NjVjODEzY2M4Li5lZjQ5NjM1Zjk4MTkgMTAwNjQ0Cj4gLS0t
IGEvZHJpdmVycy9pb21tdS9kbWEtaW9tbXUuYwo+ICsrKyBiL2RyaXZlcnMvaW9tbXUvZG1hLWlv
bW11LmMKPiBAQCAtMjAsNiArMjAsNyBAQAo+ICAgI2luY2x1ZGUgPGxpbnV4L21tLmg+Cj4gICAj
aW5jbHVkZSA8bGludXgvbXV0ZXguaD4KPiAgICNpbmNsdWRlIDxsaW51eC9wY2kuaD4KPiArI2lu
Y2x1ZGUgPGxpbnV4L3BjaS1wMnBkbWEuaD4KPiAgICNpbmNsdWRlIDxsaW51eC9zd2lvdGxiLmg+
Cj4gICAjaW5jbHVkZSA8bGludXgvc2NhdHRlcmxpc3QuaD4KPiAgICNpbmNsdWRlIDxsaW51eC92
bWFsbG9jLmg+Cj4gQEAgLTg2NCw2ICs4NjUsMTYgQEAgc3RhdGljIGludCBfX2ZpbmFsaXNlX3Nn
KHN0cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0IHNjYXR0ZXJsaXN0ICpzZywgaW50IG5lbnRzLAo+
ICAgCQlzZ19kbWFfYWRkcmVzcyhzKSA9IERNQV9NQVBQSU5HX0VSUk9SOwo+ICAgCQlzZ19kbWFf
bGVuKHMpID0gMDsKPiAgIAo+ICsJCWlmIChpc19wY2lfcDJwZG1hX3BhZ2Uoc2dfcGFnZShzKSkg
JiYgIXNfaW92YV9sZW4pIHsKPiArCQkJaWYgKGkgPiAwKQo+ICsJCQkJY3VyID0gc2dfbmV4dChj
dXIpOwo+ICsKPiArCQkJcGNpX3AycGRtYV9tYXBfYnVzX3NlZ21lbnQocywgY3VyKTsKPiArCQkJ
Y291bnQrKzsKPiArCQkJY3VyX2xlbiA9IDA7Cj4gKwkJCWNvbnRpbnVlOwo+ICsJCX0KPiArCj4g
ICAJCS8qCj4gICAJCSAqIE5vdyBmaWxsIGluIHRoZSByZWFsIERNQSBkYXRhLiBJZi4uLgo+ICAg
CQkgKiAtIHRoZXJlIGlzIGEgdmFsaWQgb3V0cHV0IHNlZ21lbnQgdG8gYXBwZW5kIHRvCj4gQEAg
LTk2MSwxMCArOTcyLDEyIEBAIHN0YXRpYyBpbnQgaW9tbXVfZG1hX21hcF9zZyhzdHJ1Y3QgZGV2
aWNlICpkZXYsIHN0cnVjdCBzY2F0dGVybGlzdCAqc2csCj4gICAJc3RydWN0IGlvdmFfZG9tYWlu
ICppb3ZhZCA9ICZjb29raWUtPmlvdmFkOwo+ICAgCXN0cnVjdCBzY2F0dGVybGlzdCAqcywgKnBy
ZXYgPSBOVUxMOwo+ICAgCWludCBwcm90ID0gZG1hX2luZm9fdG9fcHJvdChkaXIsIGRldl9pc19k
bWFfY29oZXJlbnQoZGV2KSwgYXR0cnMpOwo+ICsJc3RydWN0IGRldl9wYWdlbWFwICpwZ21hcCA9
IE5VTEw7Cj4gKwllbnVtIHBjaV9wMnBkbWFfbWFwX3R5cGUgbWFwX3R5cGU7Cj4gICAJZG1hX2Fk
ZHJfdCBpb3ZhOwo+ICAgCXNpemVfdCBpb3ZhX2xlbiA9IDA7Cj4gICAJdW5zaWduZWQgbG9uZyBt
YXNrID0gZG1hX2dldF9zZWdfYm91bmRhcnkoZGV2KTsKPiAtCWludCBpOwo+ICsJaW50IGksIHJl
dCA9IDA7Cj4gICAKPiAgIAlpZiAoc3RhdGljX2JyYW5jaF91bmxpa2VseSgmaW9tbXVfZGVmZXJy
ZWRfYXR0YWNoX2VuYWJsZWQpICYmCj4gICAJICAgIGlvbW11X2RlZmVycmVkX2F0dGFjaChkZXYs
IGRvbWFpbikpCj4gQEAgLTk5Myw2ICsxMDA2LDMxIEBAIHN0YXRpYyBpbnQgaW9tbXVfZG1hX21h
cF9zZyhzdHJ1Y3QgZGV2aWNlICpkZXYsIHN0cnVjdCBzY2F0dGVybGlzdCAqc2csCj4gICAJCXNf
bGVuZ3RoID0gaW92YV9hbGlnbihpb3ZhZCwgc19sZW5ndGggKyBzX2lvdmFfb2ZmKTsKPiAgIAkJ
cy0+bGVuZ3RoID0gc19sZW5ndGg7Cj4gICAKPiArCQlpZiAoaXNfcGNpX3AycGRtYV9wYWdlKHNn
X3BhZ2UocykpKSB7Cj4gKwkJCWlmIChzZ19wYWdlKHMpLT5wZ21hcCAhPSBwZ21hcCkgewo+ICsJ
CQkJcGdtYXAgPSBzZ19wYWdlKHMpLT5wZ21hcDsKPiArCQkJCW1hcF90eXBlID0gcGNpX3AycGRt
YV9tYXBfdHlwZShwZ21hcCwgZGV2LAo+ICsJCQkJCQkJICAgICAgIGF0dHJzKTsKPiArCQkJfQo+
ICsKPiArCQkJc3dpdGNoIChtYXBfdHlwZSkgewo+ICsJCQljYXNlIFBDSV9QMlBETUFfTUFQX0JV
U19BRERSOgo+ICsJCQkJLyoKPiArCQkJCSAqIEEgemVybyBsZW5ndGggd2lsbCBiZSBpZ25vcmVk
IGJ5Cj4gKwkJCQkgKiBpb21tdV9tYXBfc2coKSBhbmQgdGhlbiBjYW4gYmUgZGV0ZWN0ZWQKPiAr
CQkJCSAqIGluIF9fZmluYWxpc2Vfc2coKSB0byBhY3R1YWxseSBtYXAgdGhlCj4gKwkJCQkgKiBi
dXMgYWRkcmVzcy4KPiArCQkJCSAqLwo+ICsJCQkJcy0+bGVuZ3RoID0gMDsKPiArCQkJCWNvbnRp
bnVlOwoKPiArCQkJY2FzZSBQQ0lfUDJQRE1BX01BUF9USFJVX0hPU1RfQlJJREdFOgo+ICsJCQkJ
YnJlYWs7ClNvLCB0aGlzICdzaG9ydC1jaXJjdWl0cycgdGhlIHVzZSBvZiB0aGUgSU9NTVUsIHNp
bGVudGx5PwpUaGlzIHNlZW1zIHJpcGUgZm9yIHVzZXJzIHRvIGVuYWJsZSBJT01NVSBmb3Igc2Vj
dXJlIGNvbXB1dGluZyByZWFzb25zLCBhbmQgdXNpbmcvZW5hYmxpbmcgcDJwZG1hLAphbmQgbm90
IHJlYWxpemluZyB0aGF0IGl0IGlzbid0IGFzIHNlY3VyZSBhcyAxKzE9MsKgIGFwcGVhcnMgdG8g
YmUuCklmIG15IHVuZGVyc3RhbmRpbmcgaXMgd3JvbmcsIHBsZWFzZSBwb2ludCBtZSB0byB0aGUg
RG9jdW1lbnRhdGlvbiBvciBjb2RlIHRoYXQgY29ycmVjdHMgdGhpcyBtaXMtdW5kZXJzdGFuZGlu
Zy7CoCBJIGNvdWxkIGhhdmUgbWlzc2VkIGEgd2FybmluZyB3aGVuIGJvdGggYXJlIGVuYWJsZWQg
aW4gYSBwYXN0IHBhdGNoIHNldC4KVGhhbmtzLgotLWRkCj4gKwkJCWRlZmF1bHQ6Cj4gKwkJCQly
ZXQgPSAtRVJFTU9URUlPOwo+ICsJCQkJZ290byBvdXRfcmVzdG9yZV9zZzsKPiArCQkJfQo+ICsJ
CX0KPiArCj4gICAJCS8qCj4gICAJCSAqIER1ZSB0byB0aGUgYWxpZ25tZW50IG9mIG91ciBzaW5n
bGUgSU9WQSBhbGxvY2F0aW9uLCB3ZSBjYW4KPiAgIAkJICogZGVwZW5kIG9uIHRoZXNlIGFzc3Vt
cHRpb25zIGFib3V0IHRoZSBzZWdtZW50IGJvdW5kYXJ5IG1hc2s6Cj4gQEAgLTEwMTUsNiArMTA1
Myw5IEBAIHN0YXRpYyBpbnQgaW9tbXVfZG1hX21hcF9zZyhzdHJ1Y3QgZGV2aWNlICpkZXYsIHN0
cnVjdCBzY2F0dGVybGlzdCAqc2csCj4gICAJCXByZXYgPSBzOwo+ICAgCX0KPiAgIAo+ICsJaWYg
KCFpb3ZhX2xlbikKPiArCQlyZXR1cm4gX19maW5hbGlzZV9zZyhkZXYsIHNnLCBuZW50cywgMCk7
Cj4gKwo+ICAgCWlvdmEgPSBpb21tdV9kbWFfYWxsb2NfaW92YShkb21haW4sIGlvdmFfbGVuLCBk
bWFfZ2V0X21hc2soZGV2KSwgZGV2KTsKPiAgIAlpZiAoIWlvdmEpCj4gICAJCWdvdG8gb3V0X3Jl
c3RvcmVfc2c7Cj4gQEAgLTEwMzIsMTMgKzEwNzMsMTMgQEAgc3RhdGljIGludCBpb21tdV9kbWFf
bWFwX3NnKHN0cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0IHNjYXR0ZXJsaXN0ICpzZywKPiAgIAlp
b21tdV9kbWFfZnJlZV9pb3ZhKGNvb2tpZSwgaW92YSwgaW92YV9sZW4sIE5VTEwpOwo+ICAgb3V0
X3Jlc3RvcmVfc2c6Cj4gICAJX19pbnZhbGlkYXRlX3NnKHNnLCBuZW50cyk7Cj4gLQlyZXR1cm4g
MDsKPiArCXJldHVybiByZXQ7Cj4gICB9Cj4gICAKPiAgIHN0YXRpYyB2b2lkIGlvbW11X2RtYV91
bm1hcF9zZyhzdHJ1Y3QgZGV2aWNlICpkZXYsIHN0cnVjdCBzY2F0dGVybGlzdCAqc2csCj4gICAJ
CWludCBuZW50cywgZW51bSBkbWFfZGF0YV9kaXJlY3Rpb24gZGlyLCB1bnNpZ25lZCBsb25nIGF0
dHJzKQo+ICAgewo+IC0JZG1hX2FkZHJfdCBzdGFydCwgZW5kOwo+ICsJZG1hX2FkZHJfdCBlbmQs
IHN0YXJ0ID0gRE1BX01BUFBJTkdfRVJST1I7Cj4gICAJc3RydWN0IHNjYXR0ZXJsaXN0ICp0bXA7
Cj4gICAJaW50IGk7Cj4gICAKPiBAQCAtMTA1NCwxNCArMTA5NSwyMiBAQCBzdGF0aWMgdm9pZCBp
b21tdV9kbWFfdW5tYXBfc2coc3RydWN0IGRldmljZSAqZGV2LCBzdHJ1Y3Qgc2NhdHRlcmxpc3Qg
KnNnLAo+ICAgCSAqIFRoZSBzY2F0dGVybGlzdCBzZWdtZW50cyBhcmUgbWFwcGVkIGludG8gYSBz
aW5nbGUKPiAgIAkgKiBjb250aWd1b3VzIElPVkEgYWxsb2NhdGlvbiwgc28gdGhpcyBpcyBpbmNy
ZWRpYmx5IGVhc3kuCj4gICAJICovCj4gLQlzdGFydCA9IHNnX2RtYV9hZGRyZXNzKHNnKTsKPiAt
CWZvcl9lYWNoX3NnKHNnX25leHQoc2cpLCB0bXAsIG5lbnRzIC0gMSwgaSkgewo+ICsJZm9yX2Vh
Y2hfc2coc2csIHRtcCwgbmVudHMsIGkpIHsKPiArCQlpZiAoc2dfaXNfcGNpX3AycGRtYSh0bXAp
KSB7Cj4gKwkJCXNnX3VubWFya19wY2lfcDJwZG1hKHRtcCk7Cj4gKwkJCWNvbnRpbnVlOwo+ICsJ
CX0KPiAgIAkJaWYgKHNnX2RtYV9sZW4odG1wKSA9PSAwKQo+ICAgCQkJYnJlYWs7Cj4gLQkJc2cg
PSB0bXA7Cj4gKwo+ICsJCWlmIChzdGFydCA9PSBETUFfTUFQUElOR19FUlJPUikKPiArCQkJc3Rh
cnQgPSBzZ19kbWFfYWRkcmVzcyh0bXApOwo+ICsKPiArCQllbmQgPSBzZ19kbWFfYWRkcmVzcyh0
bXApICsgc2dfZG1hX2xlbih0bXApOwo+ICAgCX0KPiAtCWVuZCA9IHNnX2RtYV9hZGRyZXNzKHNn
KSArIHNnX2RtYV9sZW4oc2cpOwo+IC0JX19pb21tdV9kbWFfdW5tYXAoZGV2LCBzdGFydCwgZW5k
IC0gc3RhcnQpOwo+ICsKPiArCWlmIChzdGFydCAhPSBETUFfTUFQUElOR19FUlJPUikKPiArCQlf
X2lvbW11X2RtYV91bm1hcChkZXYsIHN0YXJ0LCBlbmQgLSBzdGFydCk7Cj4gICB9Cj4gICAKb3Zl
cmFsbCwgZmlkZGxpbmcgd2l0aCB0aGUgZ2VuZXJpYyBkbWEtaW9tbXUgY29kZSBpbnN0ZWFkIG9m
IHVzaW5nIGEgZG1hLW9wcy1iYXNlZCwgcDJwZG1hIGZ1bmN0aW9uIHRoYXQgaGFzIGl0IGNhcnZl
ZCBvdXQgYW5kIHNlcGFyYXRlZC9yZWZhY3RvcmVkIG91dCB0byBiZSBjbGVhbmVyIHNlZW1zIGxl
c3MgY29tcGxpY2F0ZWQsIGJ1dCBJJ20gZ3Vlc3NpbmcgeW91IHRyaWVkIHRoYXQgYW5kIGl0IHdh
cyB0b28gY29tcGxpY2F0ZWQgdG8gZG8/Ci0tZGQKCj4gICBzdGF0aWMgZG1hX2FkZHJfdCBpb21t
dV9kbWFfbWFwX3Jlc291cmNlKHN0cnVjdCBkZXZpY2UgKmRldiwgcGh5c19hZGRyX3QgcGh5cywK
PiBAQCAtMTI1NCw2ICsxMzAzLDcgQEAgc3RhdGljIHVuc2lnbmVkIGxvbmcgaW9tbXVfZG1hX2dl
dF9tZXJnZV9ib3VuZGFyeShzdHJ1Y3QgZGV2aWNlICpkZXYpCj4gICB9Cj4gICAKPiAgIHN0YXRp
YyBjb25zdCBzdHJ1Y3QgZG1hX21hcF9vcHMgaW9tbXVfZG1hX29wcyA9IHsKPiArCS5mbGFncwkJ
CT0gRE1BX0ZfUENJX1AyUERNQV9TVVBQT1JURUQsCndhaXQsIGl0J3MgYSBjb25zdCB0aGF0J3Mg
YWx3YXlzIHR1cm5lZCBvbj8Kc2hvdWxkbid0IHRoZSBkZWZpbmUgZm9yIHRoaXMgZmxhZyBiZSAw
IGZvciBub24tcDJwZG1hIGNvbmZpZ3M/Cgo+ICAgCS5hbGxvYwkJCT0gaW9tbXVfZG1hX2FsbG9j
LAo+ICAgCS5mcmVlCQkJPSBpb21tdV9kbWFfZnJlZSwKPiAgIAkuYWxsb2NfcGFnZXMJCT0gZG1h
X2NvbW1vbl9hbGxvY19wYWdlcywKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0
aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5m
by9pb21tdQ==
