Return-Path: <SRS0=zmEc=24=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB025C32771
	for <iommu@archiver.kernel.org>; Tue,  7 Jan 2020 01:48:42 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B06532072E
	for <iommu@archiver.kernel.org>; Tue,  7 Jan 2020 01:48:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B06532072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 7F3612047A;
	Tue,  7 Jan 2020 01:48:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lr2lmRpgs9om; Tue,  7 Jan 2020 01:48:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 88EB420021;
	Tue,  7 Jan 2020 01:48:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6D09CC1D82;
	Tue,  7 Jan 2020 01:48:40 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B58B4C0881
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jan 2020 01:48:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id AB259882F7
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jan 2020 01:48:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lSfLjZzdXAZs for <iommu@lists.linux-foundation.org>;
 Tue,  7 Jan 2020 01:48:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 01A82882E7
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jan 2020 01:48:37 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 06 Jan 2020 17:48:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,404,1571727600"; d="scan'208";a="245771564"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136])
 ([10.239.159.136])
 by fmsmga004.fm.intel.com with ESMTP; 06 Jan 2020 17:48:19 -0800
Subject: Re: [PATCH 22/22] iommu/vt-d: Add a quirk flag for scope mismatched
 devices
To: Jerry Snitselaar <jsnitsel@redhat.com>
References: <20200102001823.21976-1-baolu.lu@linux.intel.com>
 <20200102001823.21976-23-baolu.lu@linux.intel.com>
 <CAL1RGDWU=s6nVArvkci1cXyZVw-fvdtcOjuY+9E+rgBi65q=Aw@mail.gmail.com>
 <567f1506-4a13-535b-ce41-aac079941510@linux.intel.com>
 <CAL1RGDVF1icaeEWMe0r0VA8AaxtHGJZ8NHCpvJfT8+1duOUYAQ@mail.gmail.com>
 <20200106170551.ykphn6couhxozrid@cantor>
 <799d7ab1-c496-e3f8-719e-e52fbabb8d1c@linux.intel.com>
 <20200107013056.pec2cz5zhazam4ra@cantor>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <10ae1926-2160-71df-1829-f855b2611cf8@linux.intel.com>
Date: Tue, 7 Jan 2020 09:47:06 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200107013056.pec2cz5zhazam4ra@cantor>
Content-Language: en-US
Cc: Roland Dreier <roland@purestorage.com>, Jim Yan <jimyan@baidu.com>,
 iommu@lists.linux-foundation.org
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

SGksCgpPbiAxLzcvMjAgOTozMCBBTSwgSmVycnkgU25pdHNlbGFhciB3cm90ZToKPiBPbiBUdWUg
SmFuIDA3IDIwLCBMdSBCYW9sdSB3cm90ZToKPj4gSGkgSmVycnksCj4+Cj4+IE9uIDEvNy8yMCAx
OjA1IEFNLCBKZXJyeSBTbml0c2VsYWFyIHdyb3RlOgo+Pj4gT24gV2VkIEphbiAwMSAyMCwgUm9s
YW5kIERyZWllciB2aWEgaW9tbXUgd3JvdGU6Cj4+Pj4+IFdlIHNhdyBtb3JlIGRldmljZXMgd2l0
aCB0aGUgc2FtZSBtaXNtYXRjaCBxdWlyay4gU28gbWFpbnRhaW5pbmcgCj4+Pj4+IHRoZW0gaW4K
Pj4+Pj4gYSBxdWlyayB0YWJsZSB3aWxsIG1ha2UgaXQgbW9yZSByZWFkYWJsZSBhbmQgbWFpbnRh
aW5hYmxlLgo+Pj4+Cj4+Pj4gSSBndWVzcyBJIGRpc2FncmVlIGFib3V0IHRoZSBtYWludGFpbmFi
bGUgcGFydCwgZ2l2ZW4gdGhhdCB0aGlzIHBhdGNoCj4+Pj4gYWxyZWFkeSByZWdyZXNzZXMgQnJv
YWR3ZWxsIE5UQi4KPj4+Pgo+Pj4+IEknbSBub3QgZXZlbiBzdXJlIHdoYXQgdGhlIERNQVIgdGFi
bGUgc2F5cyBhYm91dCBOVEIgb24gbXkgU2t5bGFrZQo+Pj4+IHN5c3RlbXMsIGV4YWN0bHkgYmVj
YXVzZSB0aGUgZXhpc3RpbmcgY29kZSBtZWFucyBJIGRpZCBub3QgaGF2ZSBhbnkKPj4+PiBwcm9i
bGVtcy7CoCBCdXQgd2UgbWlnaHQgbmVlZCB0byBhZGQgZGV2aWNlIDIwMUNoIHRvby4KPj4+Pgo+
Pj4+IE1heWJlIHdlIGRvbid0IG5lZWQgdGhlIG1pc21hdGNoIGNoZWNrIGF0IGFsbD/CoCBZb3Vy
IHBhdGNoIHNldHMgdGhlCj4+Pj4gcXVpcmsgaWYgYW55IHBvc3NpYmx5IG1pc21hdGNoaW5nIGRl
dmljZSBpcyBwcmVzZW50IGluIHRoZSBzeXN0ZW0sIHNvCj4+Pj4gd2UnbGwgaWdub3JlIGFueSBz
Y29wZSBtaXNtYXRjaCBvbiBhIHN5c3RlbSB3aXRoLCBzYXksIHRoZSA4MDg2OjIwMjAKPj4+PiBO
Vk1lIGhvc3QgaW4gaXQuwqAgU28gY291bGQgd2UganVzdCBkcm9wIHRoZSBjaGVjayBjb21wbGV0
ZWx5IGFuZCBub3QKPj4+PiBoYXZlIGEgcXVpcmsgdG8gZGlzYWJsZSB0aGUgY2hlY2s/Cj4+Pj4K
Pj4+PiAtIFIuCj4+Pgo+Pj4gSWYgdGhlIGNoZWNrIGlzIHJlbW92ZWQgd2hhdCBoYXBwZW5zIGZv
ciBjYXNlcyB3aGVyZSB0aGVyZSBpcyBhbiBhY3R1YWwKPj4+IHByb2JsZW0gaW4gdGhlIGRtYXIg
dGFibGU/IEkganVzdCB3b3JrZWQgYW4gaXNzdWUgd2l0aCBzb21lIEludGVsCj4+PiBwZW9wbGUg
d2hlcmUgYSBwdXJsZXkgc3lzdGVtIGhhZCBhbiBybXJyIGVudHJ5IHBvaW50aW5nIHRvIGEgYnJp
ZGdlIGFzCj4+PiB0aGUgZW5kcG9pbnQgZGV2aWNlIGluc3RlYWQgb2YgdGhlIHJhaWQgbW9kdWxl
IHNpdHRpbmcgYmVoaW5kIGl0Lgo+Pgo+PiBUaGUgbGF0ZXN0IHNvbHV0aW9uIHdhcyBoZXJlLiBo
dHRwczovL2xrbWwub3JnL2xrbWwvMjAyMC8xLzUvMTAzLCBkb2VzCj4+IHRoaXMgd29yayBmb3Ig
eW91Pwo+Pgo+PiBCZXN0IHJlZ2FyZHMsCj4+IGJhb2x1Cj4+Cj4gCj4gSGkgQmFvbHUsCj4gCj4g
VGhleSByZXNvbHZlZCBpdCBieSB1cGRhdGluZyB0aGUgcm1yciBlbnRyeSBpbiB0aGUgZG1hciB0
YWJsZSB0byBhZGQKPiB0aGUgZXh0cmEgcGF0aCBuZWVkZWQgZm9yIGl0IHRvIHBvaW50IGF0IHRo
ZSByYWlkIG1vZHVsZS4gTG9va2luZwo+IGF0IHRoZSBjb2RlIHRob3VnaCBJIGltYWdpbmUgd2l0
aG91dCB0aGUgZmlybXdhcmUgdXBkYXRlIHRoZXkgd291bGQKPiBzdGlsbCBoYXZlIHRoZSBwcm9i
bGVtIGJlY2F1c2UgSUlSQyBpdCB3YXMgYSBjb21ibyBvZiBhbiBlbmRwb2ludAo+IHNjb3BlIHR5
cGUsIGFuZCBhIHBjaSBicmlkZ2UgaGVhZGVyIHNvIHRoYXQgZmlyc3QgY2hlY2sgd291bGQgZmFp
bAo+IGFzIGl0IGRpZCBiZWZvcmUuIE15IHdvcnJ5IHdhcyBpZiB0aGUgc3VnZ2VzdGlvbiBpcyB0
byByZW1vdmUgdGhlCj4gY2hlY2sgY29tcGxldGVseSwgYSBjYXNlIGxpa2UgdGhhdCB3b3VsZG4n
dCByZXBvcnQgYW55dGhpbmcgd3JvbmcuCgpZZXMsIGFncmVlZC4KCj4gCj4gSmltJ3MgbGF0ZXN0
IHBhdGNoIEkgdGhpbmsgc29sdmVzIHRoZSBpc3N1ZSBmb3Igd2hhdCBoZSB3YXMgc2VlaW5nCj4g
YW5kIHRoZSBOVEIgY2FzZS4KPiAKCkplcnJ5IGFuZCBSb2xhbmQsCgpBcmUgeW91IHdpbGxpbmcg
dG8gYWRkIHlvdXIgcmV2aWV3ZWQtYnkgZm9yIEppbSdzIHYyIHBhdGNoPyBJIHdpbGwKcXVldWUg
aXQgZm9yIHY1LjYgaWYgeW91IGJvdGggYWdyZWUuCgpCZXN0IHJlZ2FyZHMsCmJhb2x1Cl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcg
bGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4
Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
