Return-Path: <SRS0=3/Zu=FA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84F16C56202
	for <iommu@archiver.kernel.org>; Thu, 26 Nov 2020 08:50:31 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF281208CA
	for <iommu@archiver.kernel.org>; Thu, 26 Nov 2020 08:50:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF281208CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 704A087769;
	Thu, 26 Nov 2020 08:50:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NLbKyifjBdIZ; Thu, 26 Nov 2020 08:50:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 2022D87732;
	Thu, 26 Nov 2020 08:50:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EF1EFC163C;
	Thu, 26 Nov 2020 08:50:27 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BFB41C0052
 for <iommu@lists.linux-foundation.org>; Thu, 26 Nov 2020 08:50:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id B041387534
 for <iommu@lists.linux-foundation.org>; Thu, 26 Nov 2020 08:50:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id y812cPO3nRJu for <iommu@lists.linux-foundation.org>;
 Thu, 26 Nov 2020 08:50:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 514D786FE8
 for <iommu@lists.linux-foundation.org>; Thu, 26 Nov 2020 08:50:19 +0000 (UTC)
IronPort-SDR: /gUWmS107c68jw4RjGeyJaT7/6mI43d+BlhYJdK0kQjz/xnaGYRzZn7pP/jwP9iRf95RsYnqBZ
 xAqzR4h3N+SQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9816"; a="236388152"
X-IronPort-AV: E=Sophos;i="5.78,371,1599548400"; d="scan'208";a="236388152"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Nov 2020 00:50:18 -0800
IronPort-SDR: 0ckRKnhBtLlrKe8kX3O58++wCeYNqa8uzQDWFbhBPT0Es9yZXN3LFAFJos4EYK1zxawGWUpSYN
 dybkCpwIi6Fg==
X-IronPort-AV: E=Sophos;i="5.78,371,1599548400"; d="scan'208";a="547637576"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.208.39])
 ([10.254.208.39])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Nov 2020 00:50:15 -0800
Subject: Re: [PATCH v2 1/1] vfio/type1: Add vfio_group_domain()
To: "Liu, Yi L" <yi.l.liu@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>
References: <20201126012726.1185171-1-baolu.lu@linux.intel.com>
 <DM5PR11MB143560E51C84BAF83AE54AC0C3F90@DM5PR11MB1435.namprd11.prod.outlook.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <e90e57bf-1ca1-0cbe-02ab-cce647c50b40@linux.intel.com>
Date: Thu, 26 Nov 2020 16:50:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <DM5PR11MB143560E51C84BAF83AE54AC0C3F90@DM5PR11MB1435.namprd11.prod.outlook.com>
Content-Language: en-US
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Jiang, Dave" <dave.jiang@intel.com>, "Raj,
 Ashok" <ashok.raj@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Will Deacon <will@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Robin Murphy <robin.murphy@arm.com>
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

SGkgWWksCgpPbiAyMDIwLzExLzI2IDE1OjIxLCBMaXUsIFlpIEwgd3JvdGU6Cj4gT24gVGh1cnMs
IE5vdiAyNiwgMjAyMCwgYXQgOToyNyBBTSwgTHUgQmFvbHUgd3JvdGU6Cj4+IEFkZCB0aGUgQVBJ
IGZvciBnZXR0aW5nIHRoZSBkb21haW4gZnJvbSBhIHZmaW8gZ3JvdXAuIFRoaXMgY291bGQgYmUg
dXNlZAo+PiBieSB0aGUgcGh5c2ljYWwgZGV2aWNlIGRyaXZlcnMgd2hpY2ggcmVseSBvbiB0aGUg
dmZpby9tZGV2IGZyYW1ld29yayBmb3IKPj4gbWVkaWF0ZWQgZGV2aWNlIHVzZXIgbGV2ZWwgYWNj
ZXNzLiBUaGUgdHlwaWNhbCB1c2UgY2FzZSBsaWtlIGJlbG93Ogo+Pgo+PiAJdW5zaWduZWQgaW50
IHBhc2lkOwo+PiAJc3RydWN0IHZmaW9fZ3JvdXAgKnZmaW9fZ3JvdXA7Cj4+IAlzdHJ1Y3QgaW9t
bXVfZG9tYWluICppb21tdV9kb21haW47Cj4+IAlzdHJ1Y3QgZGV2aWNlICpkZXYgPSBtZGV2X2Rl
dihtZGV2KTsKPj4gCXN0cnVjdCBkZXZpY2UgKmlvbW11X2RldmljZSA9IG1kZXZfZ2V0X2lvbW11
X2RldmljZShkZXYpOwo+Pgo+PiAJaWYgKCFpb21tdV9kZXZpY2UgfHwKPj4gCSAgICAhaW9tbXVf
ZGV2X2ZlYXR1cmVfZW5hYmxlZChpb21tdV9kZXZpY2UsIElPTU1VX0RFVl9GRUFUX0FVWCkpCj4+
IAkJcmV0dXJuIC1FSU5WQUw7Cj4+Cj4+IAl2ZmlvX2dyb3VwID0gdmZpb19ncm91cF9nZXRfZXh0
ZXJuYWxfdXNlcl9mcm9tX2RldihkZXYpOyhkZXYpOwo+IAo+IGR1cGxpY2F0ZSAoZGV2KTsg8J+Y
im90aGVyIHBhcnRzIGxvb2tzIGdvb2QgdG8gbWUuIHBlcmhhcHMsIHlvdSBjYW4gYWxzbwoKV2ls
bCBmaXggdGhpcyB0eXBvLiBUaGFua3MhCgo+IGRlc2NyaWJlIHRoYXQgdGhlIHJlbGVhc2UgZnVu
Y3Rpb24gb2YgYSBzdWItZGV2aWNlIGZkIHNob3VsZCBhbHNvIGNhbGwKPiB2ZmlvX2dyb3VwX3B1
dF9leHRlcm5hbF91c2VyKCkgdG8gcmVsZWFzZSBpdHMgcmVmZXJlbmNlIG9uIHRoZSB2ZmlvX2dy
b3VwLgoKVGhpcyBpcyBqdXN0IGEgc2FtcGxlIGNvZGUuIFRoZSBjYWxsZXJzIGFyZSBmcmVlIHRv
IGRlY2lkZSB3aGVuIHRvIGdldAphbmQgcmVsZWFzZSB0aGUgdmZpb19ncm91cC4KCj4gCj4gUmVn
YXJkcywKPiBZaSBMaXUKCkJlc3QgcmVnYXJkcywKYmFvbHUKCj4gCj4+IAlpZiAoSVNfRVJSX09S
X05VTEwodmZpb19ncm91cCkpCj4+IAkJcmV0dXJuIC1FRkFVTFQ7Cj4+Cj4+IAlpb21tdV9kb21h
aW4gPSB2ZmlvX2dyb3VwX2RvbWFpbih2ZmlvX2dyb3VwKTsKPj4gCWlmIChJU19FUlJfT1JfTlVM
TChpb21tdV9kb21haW4pKSB7Cj4+IAkJdmZpb19ncm91cF9wdXRfZXh0ZXJuYWxfdXNlcih2Zmlv
X2dyb3VwKTsKPj4gCQlyZXR1cm4gLUVGQVVMVDsKPj4gCX0KPj4KPj4gCXBhc2lkID0gaW9tbXVf
YXV4X2dldF9wYXNpZChpb21tdV9kb21haW4sIGlvbW11X2RldmljZSk7Cj4+IAlpZiAocGFzaWQg
PCAwKSB7Cj4+IAkJdmZpb19ncm91cF9wdXRfZXh0ZXJuYWxfdXNlcih2ZmlvX2dyb3VwKTsKPj4g
CQlyZXR1cm4gLUVGQVVMVDsKPj4gCX0KPj4KPj4gCS8qIFByb2dyYW0gZGV2aWNlIGNvbnRleHQg
d2l0aCBwYXNpZCB2YWx1ZS4gKi8KPj4gCS4uLgo+Pgo+PiBTaWduZWQtb2ZmLWJ5OiBMdSBCYW9s
dSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPgo+PiAtLS0KPj4gICBkcml2ZXJzL3ZmaW8vdmZp
by5jICAgICAgICAgICAgIHwgMTggKysrKysrKysrKysrKysrKysrCj4+ICAgZHJpdmVycy92Zmlv
L3ZmaW9faW9tbXVfdHlwZTEuYyB8IDIzICsrKysrKysrKysrKysrKysrKysrKysrCj4+ICAgaW5j
bHVkZS9saW51eC92ZmlvLmggICAgICAgICAgICB8ICAzICsrKwo+PiAgIDMgZmlsZXMgY2hhbmdl
ZCwgNDQgaW5zZXJ0aW9ucygrKQo+Pgo+PiBDaGFuZ2UgbG9nOgo+PiAgIC0gdjE6IGh0dHBzOi8v
bG9yZS5rZXJuZWwub3JnL2xpbnV4LWlvbW11LzIwMjAxMTEyMDIyNDA3LjIwNjM4OTYtMS1iYW9s
dS5sdUBsaW51eC5pbnRlbC5jb20vCj4+ICAgLSBDaGFuZ2VkIGFjY29yZGluZyB0byBjb21tZW50
cyBAIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LWlvbW11LzIwMjAxMTE2MTI1NjMxLjJk
MDQzZmNkQHc1MjAuaG9tZS8KPj4KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmZpby92ZmlvLmMg
Yi9kcml2ZXJzL3ZmaW8vdmZpby5jCj4+IGluZGV4IDIxNTFiYzdmODdhYi4uNjJjNjUyMTExYzg4
IDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJzL3ZmaW8vdmZpby5jCj4+ICsrKyBiL2RyaXZlcnMvdmZp
by92ZmlvLmMKPj4gQEAgLTIzMzEsNiArMjMzMSwyNCBAQCBpbnQgdmZpb191bnJlZ2lzdGVyX25v
dGlmaWVyKHN0cnVjdCBkZXZpY2UgKmRldiwKPj4gZW51bSB2ZmlvX25vdGlmeV90eXBlIHR5cGUs
Cj4+ICAgfQo+PiAgIEVYUE9SVF9TWU1CT0wodmZpb191bnJlZ2lzdGVyX25vdGlmaWVyKTsKPj4K
Pj4gK3N0cnVjdCBpb21tdV9kb21haW4gKnZmaW9fZ3JvdXBfZG9tYWluKHN0cnVjdCB2ZmlvX2dy
b3VwICpncm91cCkKPj4gK3sKPj4gKwlzdHJ1Y3QgdmZpb19jb250YWluZXIgKmNvbnRhaW5lcjsK
Pj4gKwlzdHJ1Y3QgdmZpb19pb21tdV9kcml2ZXIgKmRyaXZlcjsKPj4gKwo+PiArCWlmICghZ3Jv
dXApCj4+ICsJCXJldHVybiBFUlJfUFRSKC1FSU5WQUwpOwo+PiArCj4+ICsJY29udGFpbmVyID0g
Z3JvdXAtPmNvbnRhaW5lcjsKPj4gKwlkcml2ZXIgPSBjb250YWluZXItPmlvbW11X2RyaXZlcjsK
Pj4gKwlpZiAobGlrZWx5KGRyaXZlciAmJiBkcml2ZXItPm9wcy0+Z3JvdXBfZG9tYWluKSkKPj4g
KwkJcmV0dXJuIGRyaXZlci0+b3BzLT5ncm91cF9kb21haW4oY29udGFpbmVyLT5pb21tdV9kYXRh
LAo+PiArCQkJCQkJIGdyb3VwLT5pb21tdV9ncm91cCk7Cj4+ICsJZWxzZQo+PiArCQlyZXR1cm4g
RVJSX1BUUigtRU5PVFRZKTsKPj4gK30KPj4gK0VYUE9SVF9TWU1CT0wodmZpb19ncm91cF9kb21h
aW4pOwo+PiArCj4+ICAgLyoqCj4+ICAgICogTW9kdWxlL2NsYXNzIHN1cHBvcnQKPj4gICAgKi8K
Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmZpby92ZmlvX2lvbW11X3R5cGUxLmMgYi9kcml2ZXJz
L3ZmaW8vdmZpb19pb21tdV90eXBlMS5jCj4+IGluZGV4IDY3ZTgyNzYzODk5NS4uNzgzZjE4ZjIx
Yjk1IDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJzL3ZmaW8vdmZpb19pb21tdV90eXBlMS5jCj4+ICsr
KyBiL2RyaXZlcnMvdmZpby92ZmlvX2lvbW11X3R5cGUxLmMKPj4gQEAgLTI5ODAsNiArMjk4MCwy
OCBAQCBzdGF0aWMgaW50IHZmaW9faW9tbXVfdHlwZTFfZG1hX3J3KHZvaWQgKmlvbW11X2RhdGEs
Cj4+IGRtYV9hZGRyX3QgdXNlcl9pb3ZhLAo+PiAgIAlyZXR1cm4gcmV0Owo+PiAgIH0KPj4KPj4g
K3N0YXRpYyB2b2lkICp2ZmlvX2lvbW11X3R5cGUxX2dyb3VwX2RvbWFpbih2b2lkICppb21tdV9k
YXRhLAo+PiArCQkJCQkgICBzdHJ1Y3QgaW9tbXVfZ3JvdXAgKmlvbW11X2dyb3VwKQo+PiArewo+
PiArCXN0cnVjdCB2ZmlvX2lvbW11ICppb21tdSA9IGlvbW11X2RhdGE7Cj4+ICsJc3RydWN0IGlv
bW11X2RvbWFpbiAqZG9tYWluID0gTlVMTDsKPj4gKwlzdHJ1Y3QgdmZpb19kb21haW4gKmQ7Cj4+
ICsKPj4gKwlpZiAoIWlvbW11IHx8ICFpb21tdV9ncm91cCkKPj4gKwkJcmV0dXJuIEVSUl9QVFIo
LUVJTlZBTCk7Cj4+ICsKPj4gKwltdXRleF9sb2NrKCZpb21tdS0+bG9jayk7Cj4+ICsJbGlzdF9m
b3JfZWFjaF9lbnRyeShkLCAmaW9tbXUtPmRvbWFpbl9saXN0LCBuZXh0KSB7Cj4+ICsJCWlmIChm
aW5kX2lvbW11X2dyb3VwKGQsIGlvbW11X2dyb3VwKSkgewo+PiArCQkJZG9tYWluID0gZC0+ZG9t
YWluOwo+PiArCQkJYnJlYWs7Cj4+ICsJCX0KPj4gKwl9Cj4+ICsJbXV0ZXhfdW5sb2NrKCZpb21t
dS0+bG9jayk7Cj4+ICsKPj4gKwlyZXR1cm4gZG9tYWluOwo+PiArfQo+PiArCj4+ICAgc3RhdGlj
IGNvbnN0IHN0cnVjdCB2ZmlvX2lvbW11X2RyaXZlcl9vcHMgdmZpb19pb21tdV9kcml2ZXJfb3Bz
X3R5cGUxID0gewo+PiAgIAkubmFtZQkJCT0gInZmaW8taW9tbXUtdHlwZTEiLAo+PiAgIAkub3du
ZXIJCQk9IFRISVNfTU9EVUxFLAo+PiBAQCAtMjk5Myw2ICszMDE1LDcgQEAgc3RhdGljIGNvbnN0
IHN0cnVjdCB2ZmlvX2lvbW11X2RyaXZlcl9vcHMgdmZpb19pb21tdV9kcml2ZXJfb3BzX3R5cGUx
ID0gewo+PiAgIAkucmVnaXN0ZXJfbm90aWZpZXIJPSB2ZmlvX2lvbW11X3R5cGUxX3JlZ2lzdGVy
X25vdGlmaWVyLAo+PiAgIAkudW5yZWdpc3Rlcl9ub3RpZmllcgk9IHZmaW9faW9tbXVfdHlwZTFf
dW5yZWdpc3Rlcl9ub3RpZmllciwKPj4gICAJLmRtYV9ydwkJCT0gdmZpb19pb21tdV90eXBlMV9k
bWFfcncsCj4+ICsJLmdyb3VwX2RvbWFpbgkJPSB2ZmlvX2lvbW11X3R5cGUxX2dyb3VwX2RvbWFp
biwKPj4gICB9Owo+Pgo+PiAgIHN0YXRpYyBpbnQgX19pbml0IHZmaW9faW9tbXVfdHlwZTFfaW5p
dCh2b2lkKQo+PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC92ZmlvLmggYi9pbmNsdWRlL2xp
bnV4L3ZmaW8uaAo+PiBpbmRleCAzOGQzYzZhOGRjN2UuLmEwNjEzYTZmMjFjYyAxMDA2NDQKPj4g
LS0tIGEvaW5jbHVkZS9saW51eC92ZmlvLmgKPj4gKysrIGIvaW5jbHVkZS9saW51eC92ZmlvLmgK
Pj4gQEAgLTkwLDYgKzkwLDcgQEAgc3RydWN0IHZmaW9faW9tbXVfZHJpdmVyX29wcyB7Cj4+ICAg
CQkJCQkgICAgICAgc3RydWN0IG5vdGlmaWVyX2Jsb2NrICpuYik7Cj4+ICAgCWludAkJKCpkbWFf
cncpKHZvaWQgKmlvbW11X2RhdGEsIGRtYV9hZGRyX3QgdXNlcl9pb3ZhLAo+PiAgIAkJCQkgIHZv
aWQgKmRhdGEsIHNpemVfdCBjb3VudCwgYm9vbCB3cml0ZSk7Cj4+ICsJdm9pZAkJKigqZ3JvdXBf
ZG9tYWluKSh2b2lkICppb21tdV9kYXRhLCBzdHJ1Y3QgaW9tbXVfZ3JvdXAgKmdyb3VwKTsKPj4g
ICB9Owo+Pgo+PiAgIGV4dGVybiBpbnQgdmZpb19yZWdpc3Rlcl9pb21tdV9kcml2ZXIoY29uc3Qg
c3RydWN0IHZmaW9faW9tbXVfZHJpdmVyX29wcyAqb3BzKTsKPj4gQEAgLTEyNiw2ICsxMjcsOCBA
QCBleHRlcm4gaW50IHZmaW9fZ3JvdXBfdW5waW5fcGFnZXMoc3RydWN0IHZmaW9fZ3JvdXAgKmdy
b3VwLAo+PiAgIGV4dGVybiBpbnQgdmZpb19kbWFfcncoc3RydWN0IHZmaW9fZ3JvdXAgKmdyb3Vw
LCBkbWFfYWRkcl90IHVzZXJfaW92YSwKPj4gICAJCSAgICAgICB2b2lkICpkYXRhLCBzaXplX3Qg
bGVuLCBib29sIHdyaXRlKTsKPj4KPj4gK2V4dGVybiBzdHJ1Y3QgaW9tbXVfZG9tYWluICp2Zmlv
X2dyb3VwX2RvbWFpbihzdHJ1Y3QgdmZpb19ncm91cCAqZ3JvdXApOwo+PiArCj4+ICAgLyogZWFj
aCB0eXBlIGhhcyBpbmRlcGVuZGVudCBldmVudHMgKi8KPj4gICBlbnVtIHZmaW9fbm90aWZ5X3R5
cGUgewo+PiAgIAlWRklPX0lPTU1VX05PVElGWSA9IDAsCj4+IC0tCj4+IDIuMjUuMQo+IApfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5n
IGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51
eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
