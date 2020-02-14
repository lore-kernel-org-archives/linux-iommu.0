Return-Path: <SRS0=UfLp=4C=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F950C3B1BE
	for <iommu@archiver.kernel.org>; Fri, 14 Feb 2020 18:35:14 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 045102086A
	for <iommu@archiver.kernel.org>; Fri, 14 Feb 2020 18:35:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 045102086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id D232686978;
	Fri, 14 Feb 2020 18:35:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 83LnPInxP0st; Fri, 14 Feb 2020 18:35:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 2A34986972;
	Fri, 14 Feb 2020 18:35:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0A79BC08A4;
	Fri, 14 Feb 2020 18:35:12 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9AF2CC0177
 for <iommu@lists.linux-foundation.org>; Fri, 14 Feb 2020 18:35:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 9193A86292
 for <iommu@lists.linux-foundation.org>; Fri, 14 Feb 2020 18:35:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BZ3PA0g8bOpw for <iommu@lists.linux-foundation.org>;
 Fri, 14 Feb 2020 18:35:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by whitealder.osuosl.org (Postfix) with ESMTP id 6C88A87653
 for <iommu@lists.linux-foundation.org>; Fri, 14 Feb 2020 18:35:09 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D1DE8106F;
 Fri, 14 Feb 2020 10:35:08 -0800 (PST)
Received: from [10.1.196.37] (e121345-lin.cambridge.arm.com [10.1.196.37])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1E3E03F68E;
 Fri, 14 Feb 2020 10:35:06 -0800 (PST)
Subject: Re: arm64 iommu groups issue
To: John Garry <john.garry@huawei.com>, Marc Zyngier <maz@kernel.org>,
 Will Deacon <will@kernel.org>, Lorenzo Pieralisi
 <lorenzo.pieralisi@arm.com>, Sudeep Holla <sudeep.holla@arm.com>,
 "Guohanjun (Hanjun Guo)" <guohanjun@huawei.com>
References: <9625faf4-48ef-2dd3-d82f-931d9cf26976@huawei.com>
 <4768c541-ebf4-61d5-0c5e-77dee83f8f94@arm.com>
 <a18b7f26-9713-a5c7-507e-ed70e40bc007@huawei.com>
 <ddc7eaff-c3f9-4304-9b4e-75eff2c66cd5@huawei.com>
 <be464e2a-03d5-0b2e-24ee-96d0d14fd739@arm.com>
 <35fc8d13-b1c1-6a9e-4242-284da7f00764@huawei.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <68643b18-c920-f997-a6d4-a5d9177c0f4e@arm.com>
Date: Fri, 14 Feb 2020 18:35:05 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <35fc8d13-b1c1-6a9e-4242-284da7f00764@huawei.com>
Content-Language: en-GB
Cc: Saravana Kannan <saravanak@google.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Alex Williamson <alex.williamson@redhat.com>, Linuxarm <linuxarm@huawei.com>,
 iommu <iommu@lists.linux-foundation.org>, Bjorn Helgaas <bhelgaas@google.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
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

T24gMTQvMDIvMjAyMCAyOjA5IHBtLCBKb2huIEdhcnJ5IHdyb3RlOgo+Pj4KPj4+IEBAIC0yNDIw
LDYgKzI0MjEsMTAgQEAgdm9pZCBwY2lfZGV2aWNlX2FkZChzdHJ1Y3QgcGNpX2RldiAqZGV2LCBz
dHJ1Y3QKPj4+IHBjaV9idXMgKmJ1cykKPj4+IMKgIMKgwqDCoMKgIC8qIFNldCB1cCBNU0kgSVJR
IGRvbWFpbiAqLwo+Pj4gwqAgwqDCoMKgwqAgcGNpX3NldF9tc2lfZG9tYWluKGRldik7Cj4+Pgo+
Pj4gK8KgwqDCoCBwYXJlbnQgPSBkZXYtPmRldi5wYXJlbnQ7Cj4+PiArwqDCoMKgIGlmIChwYXJl
bnQgJiYgcGFyZW50LT5idXMgPT0gJnBjaV9idXNfdHlwZSkKPj4+ICvCoMKgwqDCoMKgwqDCoCBk
ZXZpY2VfbGlua19hZGQoJmRldi0+ZGV2LCBwYXJlbnQsIERMX0ZMQUdfQVVUT1BST0JFX0NPTlNV
TUVSKTsKPj4+ICsKPj4+IMKgIMKgwqDCoMKgIC8qIE5vdGlmaWVyIGNvdWxkIHVzZSBQQ0kgY2Fw
YWJpbGl0aWVzICovCj4+PiDCoCDCoMKgwqDCoCBkZXYtPm1hdGNoX2RyaXZlciA9IGZhbHNlOwo+
Pj4gwqAgwqDCoMKgwqAgcmV0ID0gZGV2aWNlX2FkZCgmZGV2LT5kZXYpOwo+Pj4gLS0gCj4+Pgo+
Pj4gVGhpcyB3b3VsZCB3b3JrLCBidXQgdGhlIHByb2JsZW0gaXMgdGhhdCBpZiB0aGUgcG9ydCBk
cml2ZXIgZmFpbHMgaW4KPj4+IHByb2JpbmcgLSBhbmQgbm90IGp1c3QgZm9yIC1FUFJPQkVfREVG
RVIgLSB0aGVuIHRoZSBjaGlsZCBkZXZpY2Ugd2lsbAo+Pj4gbmV2ZXIgcHJvYmUuIFRoaXMgdmVy
eSB0aGluZyBoYXBwZW5zIG9uIG15IGRldiBib2FyZC4gSG93ZXZlciB3ZSBjb3VsZAo+Pj4gZXhw
YW5kIHRoZSBkZXZpY2UgbGlua3MgQVBJIHRvIGNvdmVyIHRoaXMgc29ydCBvZiBzY2VuYXJpby4K
Pj4KPj4gWWVzLCB0aGF0J3MgYW4gdW5kZXNpcmFibGUgaXNzdWUsIGJ1dCBpbiBmYWN0IEkgdGhp
bmsgaXQncyBtb3N0bHkKPj4gaW5kaWNhdGl2ZSB0aGF0IGludm9sdmluZyBkcml2ZXJzIGluIHNv
bWV0aGluZyB3aGljaCBpcyBkZXNpZ25lZCB0bwo+PiBoYXBwZW4gYXQgYSBsZXZlbCBiZWxvdyBk
cml2ZXJzIGlzIHN0aWxsIGZ1bmRhbWVudGFsbHkgd3JvbmcgYW5kIGRvb21lZAo+PiB0byBiZSBm
cmFnaWxlIGF0IGJlc3QuCj4gCj4gUmlnaHQsIGFuZCBldmVuIHdvcnNlIGlzIHRoYXQgaXQgcmVs
aWVzIG9uIHRoZSBwb3J0IGRyaXZlciBldmVuIGV4aXN0aW5nIAo+IGF0IGFsbC4KPiAKPiBBbGwg
dGhpcyBpb21tdSBncm91cCBhc3NpZ25tZW50IHNob3VsZCBiZSB0YWtlbiBvdXRzaWRlIGRldmlj
ZSBkcml2ZXIgCj4gcHJvYmUgcGF0aHMuCj4gCj4gSG93ZXZlciB3ZSBjb3VsZCBzdGlsbCBjb25z
aWRlciBkZXZpY2UgbGlua3MgZm9yIHN5bmMnaW5nIHRoZSBTTU1VIGFuZCAKPiBlYWNoIGRldmlj
ZSBwcm9iaW5nLgoKWWVzLCB3ZSBzaG91bGQgZ2V0IHRoYXQgZm9yIERUIG5vdyB0aGFua3MgdG8g
dGhlIG9mX2Rldmxpbmsgc3R1ZmYsIGJ1dCAKY29va2luZyB1cCBzb21lIGVxdWl2YWxlbnQgZm9y
IElPUlQgbWlnaHQgYmUgd29ydGh3aGlsZS4KCj4+IEFub3RoZXIgdGhvdWdodCB0aGF0IGNyb3Nz
ZXMgbXkgbWluZCBpcyB0aGF0IHdoZW4gcGNpX2RldmljZV9ncm91cCgpCj4+IHdhbGtzIHVwIHRv
IHRoZSBwb2ludCBvZiBBQ1MgaXNvbGF0aW9uIGFuZCBkb2Vzbid0IGZpbmQgYW4gZXhpc3RpbmcK
Pj4gZ3JvdXAsIGl0IGNhbiBzdGlsbCBpbmZlciB0aGF0IGV2ZXJ5dGhpbmcgaXQgd2Fsa2VkIHBh
c3QgKnNob3VsZCogYmUgcHV0Cj4+IGluIHRoZSBzYW1lIGdyb3VwIGl0J3MgdGhlbiBldmVudHVh
bGx5IGdvaW5nIHRvIHJldHVybi4gVW5mb3J0dW5hdGVseSBJCj4+IGNhbid0IHNlZSBhbiBvYnZp
b3VzIHdheSBmb3IgaXQgdG8gYWN0IG9uIHRoYXQga25vd2xlZGdlLCB0aG91Z2gsIHNpbmNlCj4+
IHJlY3Vyc2l2ZSBpb21tdV9wcm9iZV9kZXZpY2UoKSBpcyB1bmxpa2VseSB0byBlbmQgd2VsbC4K
PiAKPiBJJ2QgYmUgaW5jbGluZWQgbm90IHRvIGNoYW5nZSB0aGF0IGNvZGUuCj4gCj4+Cj4+PiBB
cyBmb3IgYWx0ZXJuYXRpdmVzLCBpdCBsb29rcyBwcmV0dHkgZGlmZmljdWx0IHRvIG1lIHRvIGRp
c2Fzc29jaWF0ZSB0aGUKPj4+IGdyb3VwIGFsbG9jYXRpb24gZnJvbSB0aGUgZG1hX2NvbmZpZ3Vy
ZSBwYXRoLgo+Pgo+PiBJbmRlZWQgaXQncyBub24tdHJpdmlhbCwgYnV0IGl0IHJlYWxseSBkb2Vz
IG5lZWQgY2xlYW5pbmcgdXAgYXQgc29tZSAKPj4gcG9pbnQuCj4+Cj4+IEhhdmluZyBqdXN0IGhh
ZCB5ZXQgYW5vdGhlciBzcGFyaywgZG9lcyBzb21ldGhpbmcgbGlrZSB0aGUgdW50ZXN0ZWQKPj4g
c3VwZXItaGFjayBiZWxvdyB3b3JrIGF0IGFsbD8gCj4gCj4gSSB0cmllZCBpdCBhbmQgaXQgZG9l
c24ndCAoeWV0KSB3b3JrLgoKQmxlaCAtIGZ1cnRoZXIgcmVpbmZvcmNlbWVudCBvZiB0aGUgImlk
ZWFzIGFmdGVyIDZQTSBhcmUgYmFkIGlkZWFzIiBydWxlLi4uCgo+IFNvIHdoZW4gd2UgdHJ5IAo+
IGlvbW11X2J1c19yZXBsYXkoKS0+YWRkX2lvbW11X2dyb3VwKCktPmlvbW11X3Byb2JlX2Rldmlj
ZSgpLT5hcm1fc21tdV9hZGRfZGV2aWNlKCksIAo+IAo+IHRoZSBpb21tdV9md3NwZWMgaXMgc3Rp
bGwgTlVMTCBmb3IgdGhhdCBkZXZpY2UgLSB0aGlzIGlzIG5vdCBzZXQgdW50aWwgCj4gbGF0ZXIg
d2hlbiB0aGUgZGV2aWNlIGRyaXZlciBpcyBnb2luZyB0byBmaW5hbGx5IHByb2JlIGluIAo+IGlv
cnRfaW9tbXVfeGxhdGUoKS0+aW9tbXVfZndzcGVjX2luaXQoKSwgYW5kIGl0J3MgdG9vIGxhdGUu
Li4KPiAKPiBBbmQgdGhpcyBsb29rcyB0byBiZSB0aGUgcmVhc29uIGZvciB3aGljaCBjdXJyZW50
IAo+IGlvbW11X2J1c19pbml0KCktPmJ1c19mb3JfZWFjaF9kZXZpY2UoLi4uLCBhZGRfaW9tbXVf
Z3JvdXApIGZhaWxzIGFsc28uCgpPZiBjb3Vyc2UsIGp1c3QgYWRkaW5nIGEgJ2NvcnJlY3QnIGFk
ZF9kZXZpY2UgcmVwbGF5IHdpdGhvdXQgdGhlIApvZl94bGF0ZSBwcm9jZXNzIGRvZXNuJ3QgaGVs
cCBhdCBhbGwuIE5vIHdvbmRlciB0aGlzIGxvb2tlZCBzdXNwaWNpb3VzbHkgCnNpbXBsZXIgdGhh
biB3aGVyZSB0aGUgZmlyc3QgaWRlYSBsZWZ0IG9mZi4uLgoKKG9uIHJlZmxlY3Rpb24sIHRoZSBj
b3JlIG9mIHRoaXMgaWRlYSBzZWVtcyB0byBiZSByZWN5Y2xpbmcgdGhlIGV4aXN0aW5nIAppb21t
dV9idXNfaW5pdCB3YWxrIHJhdGhlciB0aGFuIGJ1aWxkaW5nIHVwIGEgc2VwYXJhdGUgIndhaXRp
bmcgbGlzdCIsIAp3aGlsZSBmb3JnZXR0aW5nIHRoYXQgdGhhdCB3YXNuJ3QgdGhlIGRpZmZpY3Vs
dCBwYXJ0IG9mIHRoZSBvcmlnaW5hbCAKaWRlYSBhbnl3YXkpCgo+IE9uIHRoaXMgY3VycmVudCBj
b2RlIG1lbnRpb25lZCwgdGhlIHByaW5jaXBsZSBvZiB0aGlzIHNlZW1zIHdyb25nIHRvIG1lIAo+
IC0gd2UgY2FsbCBidXNfZm9yX2VhY2hfZGV2aWNlKC4uLiwgYWRkX2lvbW11X2dyb3VwKSBmb3Ig
dGhlIGZpcnN0IFNNTVUgCj4gaW4gdGhlIHN5c3RlbSB3aGljaCBwcm9iZXMsIGJ1dCB3ZSBhdHRl
bXB0IHRvIGFkZF9pb21tdV9ncm91cCgpIGZvciBhbGwgCj4gZGV2aWNlcyBvbiB0aGUgYnVzLCBl
dmVuIHRob3VnaCB0aGUgU01NVSBmb3IgdGhhdCBkZXZpY2UgbWF5IHlldCB0byBoYXZlIAo+IHBy
b2JlZC4KClllcywgaW9tbXVfYnVzX2luaXQoKSBpcyBvbmUgb2YgdGhlIHBsYWNlcyBzdGlsbCBo
b2xkaW5nIGEgCmRlZXBseS1pbmdyYWluZWQgYXNzdW1wdGlvbiB0aGF0IHRoZSBvcHMgZ28gbGl2
ZSBmb3IgYWxsIElPTU1VIGluc3RhbmNlcyAKYXQgb25jZSwgd2hpY2ggaXMgd2hhdCB3YXJyYW50
ZWQgdGhlIGZ1cnRoZXIgcmVwbGF5IGluIApvZl9pb21tdV9jb25maWd1cmUoKSBvcmlnaW5hbGx5
LiBNb3ZpbmcgdGhhdCBvdXQgb2YgCm9mX3BsYXRmb3JtX2RldmljZV9jcmVhdGUoKSB0byBzdXBw
b3J0IHByb2JlIGRlZmVycmFsIGlzIHdoZXJlIHRoZSAKdHJvdWJsZSByZWFsbHkgc3RhcnRlZC4K
ClJvYmluLgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpp
b21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6
Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
