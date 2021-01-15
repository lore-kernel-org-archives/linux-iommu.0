Return-Path: <SRS0=aa3U=GS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75681C433DB
	for <iommu@archiver.kernel.org>; Fri, 15 Jan 2021 04:47:02 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F5E823107
	for <iommu@archiver.kernel.org>; Fri, 15 Jan 2021 04:47:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F5E823107
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 83C5B86ADB;
	Fri, 15 Jan 2021 04:47:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Mx37iy1BGhwZ; Fri, 15 Jan 2021 04:47:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id A56CD86AC8;
	Fri, 15 Jan 2021 04:47:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 84C86C0893;
	Fri, 15 Jan 2021 04:47:00 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C5DEDC013A
 for <iommu@lists.linux-foundation.org>; Fri, 15 Jan 2021 04:46:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 9B916203A9
 for <iommu@lists.linux-foundation.org>; Fri, 15 Jan 2021 04:46:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id K5krPeRxDD9n for <iommu@lists.linux-foundation.org>;
 Fri, 15 Jan 2021 04:46:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by silver.osuosl.org (Postfix) with ESMTPS id 5B15A203A8
 for <iommu@lists.linux-foundation.org>; Fri, 15 Jan 2021 04:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1610686017;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5qlVp+V62hJFOmojeKBtO6bnSDZxjgJebYHvIlsbcQM=;
 b=WH9GI7mWt6WZ5oRoFYgPE0II2yhxE8tcjUkgtXUAkMD7l8f5fG3YUzYMvxi0ejAjLfE8/b
 6X+D4Kujxbo3ZADSJ7LjOVH1vln4lr0UAZBkWt1iQGygqZYq7bE9jBB5AGUbmqwXdgXH/x
 WXCdrksZDVZrHIWkek7vm0lkNQIUvRw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-438-WfDJ3MOTPVeX0K0c1Yjy4Q-1; Thu, 14 Jan 2021 23:46:55 -0500
X-MC-Unique: WfDJ3MOTPVeX0K0c1Yjy4Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A6E30802B45;
 Fri, 15 Jan 2021 04:46:51 +0000 (UTC)
Received: from [10.72.13.19] (ovpn-13-19.pek2.redhat.com [10.72.13.19])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A958771D52;
 Fri, 15 Jan 2021 04:46:29 +0000 (UTC)
Subject: Re: [RFC PATCH v3 1/2] iommu: Add capability IOMMU_CAP_VIOMMU
To: Lu Baolu <baolu.lu@linux.intel.com>, tglx@linutronix.de,
 ashok.raj@intel.com, kevin.tian@intel.com, dave.jiang@intel.com,
 megha.dey@intel.com, dwmw2@infradead.org
References: <20210114013003.297050-1-baolu.lu@linux.intel.com>
 <20210114013003.297050-2-baolu.lu@linux.intel.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <f2a50326-58de-919a-5992-130224c5725a@redhat.com>
Date: Fri, 15 Jan 2021 12:46:28 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210114013003.297050-2-baolu.lu@linux.intel.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Cc: kvm@vger.kernel.org, rafael@kernel.org, linux-pci@vger.kernel.org,
 sanjay.k.kumar@intel.com, linux-kernel@vger.kernel.org, bhelgaas@google.com,
 kwankhede@nvidia.com, will@kernel.org, leon@kernel.org, netanelg@mellanox.com,
 maz@kernel.org, vkoul@kernel.org, jgg@mellanox.com, yan.y.zhao@linux.intel.com,
 shahafs@mellanox.com, parav@mellanox.com, alex.williamson@redhat.com,
 samuel.ortiz@intel.com, dan.j.williams@intel.com, tony.luck@intel.com,
 mona.hossain@intel.com, iommu@lists.linux-foundation.org,
 jacob.jun.pan@intel.com, dmaengine@vger.kernel.org, pbonzini@redhat.com
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

Ck9uIDIwMjEvMS8xNCDkuIrljYg5OjMwLCBMdSBCYW9sdSB3cm90ZToKPiBTb21lIHZlbmRvciBJ
T01NVSBkcml2ZXJzIGFyZSBhYmxlIHRvIGRlY2xhcmUgdGhhdCBpdCBpcyBydW5uaW5nIGluIGEg
Vk0KPiBjb250ZXh0LiBUaGlzIGlzIHZlcnkgdmFsdWFibGUgZm9yIHRoZSBmZWF0dXJlcyB0aGF0
IG9ubHkgd2FudCB0byBiZQo+IHN1cHBvcnRlZCBvbiBiYXJlIG1ldGFsLiBBZGQgYSBjYXBhYmls
aXR5IGJpdCBzbyB0aGF0IGl0IGNvdWxkIGJlIHVzZWQuCj4KPiBTaWduZWQtb2ZmLWJ5OiBMdSBC
YW9sdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPgo+IC0tLQo+ICAgZHJpdmVycy9pb21tdS9p
bnRlbC9pb21tdS5jICB8IDIwICsrKysrKysrKysrKysrKysrKysrCj4gICBkcml2ZXJzL2lvbW11
L3ZpcnRpby1pb21tdS5jIHwgIDkgKysrKysrKysrCj4gICBpbmNsdWRlL2xpbnV4L2lvbW11Lmgg
ICAgICAgIHwgIDEgKwo+ICAgMyBmaWxlcyBjaGFuZ2VkLCAzMCBpbnNlcnRpb25zKCspCj4KPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9pb21tdS9pbnRlbC9pb21tdS5jIGIvZHJpdmVycy9pb21tdS9p
bnRlbC9pb21tdS5jCj4gaW5kZXggY2IyMDVhMDRmZTRjLi44ZWIwMjJkMGU4YWEgMTAwNjQ0Cj4g
LS0tIGEvZHJpdmVycy9pb21tdS9pbnRlbC9pb21tdS5jCj4gKysrIGIvZHJpdmVycy9pb21tdS9p
bnRlbC9pb21tdS5jCj4gQEAgLTU3MzgsMTIgKzU3MzgsMzIgQEAgc3RhdGljIGlubGluZSBib29s
IG5lc3RlZF9tb2RlX3N1cHBvcnQodm9pZCkKPiAgIAlyZXR1cm4gcmV0Owo+ICAgfQo+ICAgCj4g
K3N0YXRpYyBpbmxpbmUgYm9vbCBjYWNoaW5nX21vZGVfZW5hYmxlZCh2b2lkKQo+ICt7Cj4gKwlz
dHJ1Y3QgZG1hcl9kcmhkX3VuaXQgKmRyaGQ7Cj4gKwlzdHJ1Y3QgaW50ZWxfaW9tbXUgKmlvbW11
Owo+ICsJYm9vbCByZXQgPSBmYWxzZTsKPiArCj4gKwlyY3VfcmVhZF9sb2NrKCk7Cj4gKwlmb3Jf
ZWFjaF9hY3RpdmVfaW9tbXUoaW9tbXUsIGRyaGQpIHsKPiArCQlpZiAoY2FwX2NhY2hpbmdfbW9k
ZShpb21tdS0+Y2FwKSkgewo+ICsJCQlyZXQgPSB0cnVlOwo+ICsJCQlicmVhazsKPiArCQl9Cj4g
Kwl9Cj4gKwlyY3VfcmVhZF91bmxvY2soKTsKPiArCj4gKwlyZXR1cm4gcmV0Owo+ICt9Cj4gKwo+
ICAgc3RhdGljIGJvb2wgaW50ZWxfaW9tbXVfY2FwYWJsZShlbnVtIGlvbW11X2NhcCBjYXApCj4g
ICB7Cj4gICAJaWYgKGNhcCA9PSBJT01NVV9DQVBfQ0FDSEVfQ09IRVJFTkNZKQo+ICAgCQlyZXR1
cm4gZG9tYWluX3VwZGF0ZV9pb21tdV9zbm9vcGluZyhOVUxMKSA9PSAxOwo+ICAgCWlmIChjYXAg
PT0gSU9NTVVfQ0FQX0lOVFJfUkVNQVApCj4gICAJCXJldHVybiBpcnFfcmVtYXBwaW5nX2VuYWJs
ZWQgPT0gMTsKPiArCWlmIChjYXAgPT0gSU9NTVVfQ0FQX1ZJT01NVSkKPiArCQlyZXR1cm4gY2Fj
aGluZ19tb2RlX2VuYWJsZWQoKTsKCgpUaGlzIHBhcnQgSSBkb24ndCB1bmRlcnN0YW5kLiBEb2Vz
IGl0IG1lYW4gSW50ZWwgSU9NTVUgY2FuJ3QgYmUgdXNlZCBpbiAKVk0gd2l0aG91dCBjYWNoaW5n
IG1vZGU/CgpUaGFua3MKCgo+ICAgCj4gICAJcmV0dXJuIGZhbHNlOwo+ICAgfQo+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL2lvbW11L3ZpcnRpby1pb21tdS5jIGIvZHJpdmVycy9pb21tdS92aXJ0aW8t
aW9tbXUuYwo+IGluZGV4IDJiZmRkNTczNDg0NC4uNzE5NzkzZTEwM2RiIDEwMDY0NAo+IC0tLSBh
L2RyaXZlcnMvaW9tbXUvdmlydGlvLWlvbW11LmMKPiArKysgYi9kcml2ZXJzL2lvbW11L3ZpcnRp
by1pb21tdS5jCj4gQEAgLTkzMSw3ICs5MzEsMTYgQEAgc3RhdGljIGludCB2aW9tbXVfb2ZfeGxh
dGUoc3RydWN0IGRldmljZSAqZGV2LCBzdHJ1Y3Qgb2ZfcGhhbmRsZV9hcmdzICphcmdzKQo+ICAg
CXJldHVybiBpb21tdV9md3NwZWNfYWRkX2lkcyhkZXYsIGFyZ3MtPmFyZ3MsIDEpOwo+ICAgfQo+
ICAgCj4gK3N0YXRpYyBib29sIHZpb21tdV9jYXBhYmxlKGVudW0gaW9tbXVfY2FwIGNhcCkKPiAr
ewo+ICsJaWYgKGNhcCA9PSBJT01NVV9DQVBfVklPTU1VKQo+ICsJCXJldHVybiB0cnVlOwo+ICsK
PiArCXJldHVybiBmYWxzZTsKPiArfQo+ICsKPiAgIHN0YXRpYyBzdHJ1Y3QgaW9tbXVfb3BzIHZp
b21tdV9vcHMgPSB7Cj4gKwkuY2FwYWJsZQkJPSB2aW9tbXVfY2FwYWJsZSwKPiAgIAkuZG9tYWlu
X2FsbG9jCQk9IHZpb21tdV9kb21haW5fYWxsb2MsCj4gICAJLmRvbWFpbl9mcmVlCQk9IHZpb21t
dV9kb21haW5fZnJlZSwKPiAgIAkuYXR0YWNoX2RldgkJPSB2aW9tbXVfYXR0YWNoX2RldiwKPiBk
aWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9pb21tdS5oIGIvaW5jbHVkZS9saW51eC9pb21tdS5o
Cj4gaW5kZXggYjk1YTZmOGRiNmZmLi4xZDI0YmU2NjdhMDMgMTAwNjQ0Cj4gLS0tIGEvaW5jbHVk
ZS9saW51eC9pb21tdS5oCj4gKysrIGIvaW5jbHVkZS9saW51eC9pb21tdS5oCj4gQEAgLTk0LDYg
Kzk0LDcgQEAgZW51bSBpb21tdV9jYXAgewo+ICAgCQkJCQkgICB0cmFuc2FjdGlvbnMgKi8KPiAg
IAlJT01NVV9DQVBfSU5UUl9SRU1BUCwJCS8qIElPTU1VIHN1cHBvcnRzIGludGVycnVwdCBpc29s
YXRpb24gKi8KPiAgIAlJT01NVV9DQVBfTk9FWEVDLAkJLyogSU9NTVVfTk9FWEVDIGZsYWcgKi8K
PiArCUlPTU1VX0NBUF9WSU9NTVUsCQkvKiBJT01NVSBjYW4gZGVjbGFyIHJ1bm5pbmcgaW4gYSBW
TSAqLwo+ICAgfTsKPiAgIAo+ICAgLyoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3Vu
ZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0
aW5mby9pb21tdQ==
