Return-Path: <SRS0=ms/0=4M=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4C4CC35671
	for <iommu@archiver.kernel.org>; Mon, 24 Feb 2020 14:05:23 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 748CB205C9
	for <iommu@archiver.kernel.org>; Mon, 24 Feb 2020 14:05:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 748CB205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 4D4DF86CD7;
	Mon, 24 Feb 2020 14:05:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7drRdOCY7Y1A; Mon, 24 Feb 2020 14:05:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id CF60C86E6E;
	Mon, 24 Feb 2020 14:05:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BFFBAC07FF;
	Mon, 24 Feb 2020 14:05:18 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 40493C0177
 for <iommu@lists.linux-foundation.org>; Mon, 24 Feb 2020 14:05:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 2980A86E6E
 for <iommu@lists.linux-foundation.org>; Mon, 24 Feb 2020 14:05:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Aw+QV0iN5oVa for <iommu@lists.linux-foundation.org>;
 Mon, 24 Feb 2020 14:05:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by hemlock.osuosl.org (Postfix) with ESMTPS id B0D8E86CD7
 for <iommu@lists.linux-foundation.org>; Mon, 24 Feb 2020 14:05:11 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 24 Feb 2020 06:05:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,480,1574150400"; d="scan'208";a="435914695"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.212.230])
 ([10.254.212.230])
 by fmsmga005.fm.intel.com with ESMTP; 24 Feb 2020 06:05:08 -0800
Subject: Re: [PATCH v2] iommu/vt-d: Fix a bug in intel_iommu_iova_to_phys()
 for huge page
To: Yonghyun Hwang <yonghyun@google.com>,
 David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>
References: <20200220194431.169629-1-yonghyun@google.com>
 <795521c0-af5b-36a1-e05c-324377d04d8a@linux.intel.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <ab64969a-5a52-5a22-061b-de57a5ac5627@linux.intel.com>
Date: Mon, 24 Feb 2020 22:05:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <795521c0-af5b-36a1-e05c-324377d04d8a@linux.intel.com>
Content-Language: en-US
Cc: Havard Skinnemoen <hskinnemoen@google.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Moritz Fischer <mdf@kernel.org>,
 Deepa Dinamani <deepadinamani@google.com>
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

SGkgSm9lcmcgYW5kIFlvbmdoeXVuLAoKSSBmb3VuZCBhIHByb2JsZW0gaW4gdGhlIHRlc3QuIEkg
YW0gc3RpbGwgd29ya2luZyBvbiB0aGlzLiBQbGVhc2UgaG9sZApvbiBmb3IgYSB3aGlsZS4KCkJl
c3QgcmVnYXJkcywKYmFvbHUKCk9uIDIwMjAvMi8yMiAyMTowNSwgTHUgQmFvbHUgd3JvdGU6Cj4g
SGksCj4gCj4gT24gMjAyMC8yLzIxIDM6NDQsIFlvbmdoeXVuIEh3YW5nIHdyb3RlOgo+PiBpbnRl
bF9pb21tdV9pb3ZhX3RvX3BoeXMoKSBoYXMgYSBidWcgd2hlbiBpdCB0cmFuc2xhdGVzIGFuIElP
VkEgZm9yIGEgCj4+IGh1Z2UKPj4gcGFnZSBvbnRvIGl0cyBjb3JyZXNwb25kaW5nIHBoeXNpY2Fs
IGFkZHJlc3MuIFRoaXMgY29tbWl0IGZpeGVzIHRoZSAKPj4gYnVnIGJ5Cj4+IGFjY29tb2RhdGlu
ZyB0aGUgbGV2ZWwgb2YgcGFnZSBlbnRyeSBmb3IgdGhlIElPVkEgYW5kIGFkZHMgSU9WQSdzIGxv
d2VyCj4+IGFkZHJlc3MgdG8gdGhlIHBoeXNpY2FsIGFkZHJlc3MuCj4+Cj4+IFNpZ25lZC1vZmYt
Ynk6IFlvbmdoeXVuIEh3YW5nIDx5b25naHl1bkBnb29nbGUuY29tPgo+IAo+IFRoaXMgZml4IGxv
b2tzIGdvb2QgdG8gbWUuCj4gCj4gQ2M6IDxzdGFibGVAa2VybmVsLm9yZz4gIyBBcyBmYXIgYmFj
ayBhcyBwb3NzaWJsZQo+IEFja2VkLWJ5OiBMdSBCYW9sdSA8YmFvbHUubHVAbGludXguaW50ZWwu
Y29tPgo+IAo+IEJlc3QgcmVnYXJkcywKPiBiYW9sdQo+IAo+PiAtLS0KPj4KPj4gQ2hhbmdlcyBm
cm9tIHYxOgo+PiAtIGxldmVsIGNhbm5vdCBiZSAwLiBTbywgdGhlIGNvbmRpdGlvbiwgImlmIChs
ZXZlbCA+IDEpIiwgaXMgcmVtb3ZlZCwgCj4+IHdoaWNoIHJlc3VsdHMgaW4gYSBzaW1wbGUgY29k
ZS4KPj4gLSBhIG1hY3JvLCBCSVRfTUFTSywgaXMgdXNlZCB0byBoYXZlIGEgYml0IG1hc2sKPj4K
Pj4gLS0tCj4+IMKgIGRyaXZlcnMvaW9tbXUvaW50ZWwtaW9tbXUuYyB8IDQgKysrLQo+PiDCoCAx
IGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCj4+Cj4+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL2lvbW11L2ludGVsLWlvbW11LmMgYi9kcml2ZXJzL2lvbW11L2ludGVs
LWlvbW11LmMKPj4gaW5kZXggOTMyMjY3ZjQ5ZjlhLi40ZmQ1YzYyODdiNmQgMTAwNjQ0Cj4+IC0t
LSBhL2RyaXZlcnMvaW9tbXUvaW50ZWwtaW9tbXUuYwo+PiArKysgYi9kcml2ZXJzL2lvbW11L2lu
dGVsLWlvbW11LmMKPj4gQEAgLTU1NTQsNyArNTU1NCw5IEBAIHN0YXRpYyBwaHlzX2FkZHJfdCAK
Pj4gaW50ZWxfaW9tbXVfaW92YV90b19waHlzKHN0cnVjdCBpb21tdV9kb21haW4gKmRvbWFpbiwK
Pj4gwqDCoMKgwqDCoCBwdGUgPSBwZm5fdG9fZG1hX3B0ZShkbWFyX2RvbWFpbiwgaW92YSA+PiBW
VERfUEFHRV9TSElGVCwgJmxldmVsKTsKPj4gwqDCoMKgwqDCoCBpZiAocHRlKQo+PiAtwqDCoMKg
wqDCoMKgwqAgcGh5cyA9IGRtYV9wdGVfYWRkcihwdGUpOwo+PiArwqDCoMKgwqDCoMKgwqAgcGh5
cyA9IGRtYV9wdGVfYWRkcihwdGUpICsKPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKGlvdmEg
JiAoQklUX01BU0sobGV2ZWxfdG9fb2Zmc2V0X2JpdHMobGV2ZWwpICsKPj4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgVlREX1BBR0VfU0hJRlQpIC0gMSkp
Owo+PiDCoMKgwqDCoMKgIHJldHVybiBwaHlzOwo+PiDCoCB9Cj4+Cl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBs
aXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5v
cmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
