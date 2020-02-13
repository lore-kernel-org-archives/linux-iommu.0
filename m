Return-Path: <SRS0=ZJ+1=4B=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FE47C3B189
	for <iommu@archiver.kernel.org>; Thu, 13 Feb 2020 19:40:50 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0228020659
	for <iommu@archiver.kernel.org>; Thu, 13 Feb 2020 19:40:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0228020659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id C0373880C1;
	Thu, 13 Feb 2020 19:40:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GBfu8MlzdnH4; Thu, 13 Feb 2020 19:40:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id DEC128808D;
	Thu, 13 Feb 2020 19:40:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D4B85C08A4;
	Thu, 13 Feb 2020 19:40:48 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 803C2C0177
 for <iommu@lists.linux-foundation.org>; Thu, 13 Feb 2020 19:40:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 7BEE2880A1
 for <iommu@lists.linux-foundation.org>; Thu, 13 Feb 2020 19:40:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7lThpfxQdHBg for <iommu@lists.linux-foundation.org>;
 Thu, 13 Feb 2020 19:40:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by hemlock.osuosl.org (Postfix) with ESMTP id 491568808D
 for <iommu@lists.linux-foundation.org>; Thu, 13 Feb 2020 19:40:46 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 91F37328;
 Thu, 13 Feb 2020 11:40:45 -0800 (PST)
Received: from [10.1.196.37] (e121345-lin.cambridge.arm.com [10.1.196.37])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A8E163F68E;
 Thu, 13 Feb 2020 11:40:43 -0800 (PST)
Subject: Re: arm64 iommu groups issue
To: John Garry <john.garry@huawei.com>, Marc Zyngier <maz@kernel.org>,
 Will Deacon <will@kernel.org>, Lorenzo Pieralisi
 <lorenzo.pieralisi@arm.com>, Sudeep Holla <sudeep.holla@arm.com>,
 "Guohanjun (Hanjun Guo)" <guohanjun@huawei.com>
References: <9625faf4-48ef-2dd3-d82f-931d9cf26976@huawei.com>
 <4768c541-ebf4-61d5-0c5e-77dee83f8f94@arm.com>
 <a18b7f26-9713-a5c7-507e-ed70e40bc007@huawei.com>
 <ddc7eaff-c3f9-4304-9b4e-75eff2c66cd5@huawei.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <be464e2a-03d5-0b2e-24ee-96d0d14fd739@arm.com>
Date: Thu, 13 Feb 2020 19:40:42 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <ddc7eaff-c3f9-4304-9b4e-75eff2c66cd5@huawei.com>
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

T24gMTMvMDIvMjAyMCAzOjQ5IHBtLCBKb2huIEdhcnJ5IHdyb3RlOgo+Pj4KPj4+IFRoZSB1bmRl
cmx5aW5nIGlzc3VlIGlzIHRoYXQsIGZvciBoaXN0b3JpY2FsIHJlYXNvbnMsIE9GL0lPUlQtYmFz
ZWQKPj4+IElPTU1VIGRyaXZlcnMgaGF2ZSBlbmRlZCB1cCB3aXRoIGdyb3VwIGFsbG9jYXRpb24g
YmVpbmcgdGllZCB0byBlbmRwb2ludAo+Pj4gZHJpdmVyIHByb2JpbmcgdmlhIHRoZSBkbWFfY29u
ZmlndXJlKCkgbWVjaGFuaXNtIChsb25nIHN0b3J5IHNob3J0LAo+Pj4gZHJpdmVyIHByb2JlIGlz
IHRoZSBvbmx5IHRoaW5nIHdoaWNoIGNhbiBiZSBkZWxheWVkIGluIG9yZGVyIHRvIHdhaXQgZm9y
Cj4+PiBhIHNwZWNpZmljIElPTU1VIGluc3RhbmNlIHRvIGJlIHJlYWR5KS5Ib3dldmVyLCBpbiB0
aGUgbWVhbnRpbWUsIHRoZQo+Pj4gSU9NTVUgQVBJIGludGVybmFscyBoYXZlIGV2b2x2ZWQgc3Vm
ZmljaWVudGx5IHRoYXQgSSB0aGluayB0aGVyZSdzIGEgd2F5Cj4+PiB0byByZWFsbHkgcHV0IHRo
aW5ncyByaWdodCAtIEkgaGF2ZSB0aGUgc3Bhcmsgb2YgYW4gaWRlYSB3aGljaCBJJ2xsIHRyeQo+
Pj4gdG8gc2tldGNoIG91dCBBU0FQLi4uCj4+Pgo+Pgo+PiBPSywgZ3JlYXQuCj4gCj4gSGkgUm9i
aW4sCj4gCj4gSSB3YXMgd29uZGVyaW5nIGlmIHlvdSBoYXZlIGhhZCBhIGNoYW5jZSB0byBjb25z
aWRlciB0aGlzIHByb2JsZW0gYWdhaW4/CgpZZWFoLCBzb3JyeSwgbW9yZSB0aGluZ3MgY2FtZSB1
cCBzdWNoIHRoYXQgaXQgc3RpbGwgaGFzbid0IGJlZW4gUCB5ZXQgOykKCkxvcmVuem8gYW5kIEkg
ZGlkIGdldCBhcyBmYXIgYXMgZGlzY3Vzc2luZyBpdCBhIGJpdCBtb3JlIGFuZCB3cml0aW5nIHVw
IAphIHRpY2tldCwgc28gaXQncyBmb3JtYWxseSBvbiBvdXIgaW50ZXJuYWwgcmFkYXIgbm93LCBh
dCBsZWFzdC4KCj4gT25lIHNpbXBsZSBpZGVhIGNvdWxkIGJlIHRvIGludHJvZHVjZSBhIGRldmlj
ZSBsaW5rIGJldHdlZW4gdGhlIGVuZHBvaW50IAo+IGRldmljZSBhbmQgaXRzIHBhcmVudCBicmlk
Z2UgdG8gZW5zdXJlIHRoYXQgdGhleSBwcm9iZSBpbiBvcmRlciwgYXMgCj4gZXhwZWN0ZWQgaW4g
cGNpX2RldmljZV9ncm91cCgpOgo+IAo+IFN1YmplY3Q6IFtQQVRDSF0gUENJOiBBZGQgZGV2aWNl
IGxpbmsgdG8gZW5zdXJlIGVuZHBvaW50IGRldmljZSBkcml2ZXIgCj4gcHJvYmVzIGFmdGVyIGJy
aWRnZQo+IAo+IEl0IGlzIHJlcXVpcmVkIHRvIGVuc3VyZSB0aGF0IGEgZGV2aWNlIGRyaXZlciBm
b3IgYW4gZW5kcG9pbnQgd2lsbCBwcm9iZQo+IGFmdGVyIHRoZSBwYXJlbnQgcG9ydCBkcml2ZXIs
IHNvIGFkZCBhIGRldmljZSBsaW5rIGZvciB0aGlzLgo+IAo+IC0tLQo+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL3BjaS9wcm9iZS5jIGIvZHJpdmVycy9wY2kvcHJvYmUuYwo+IGluZGV4IDUxMmNiNDMx
MmRkZC4uNGI4MzJhZDI1YjIwIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvcGNpL3Byb2JlLmMKPiAr
KysgYi9kcml2ZXJzL3BjaS9wcm9iZS5jCj4gQEAgLTIzODMsNiArMjM4Myw3IEBAIHN0YXRpYyB2
b2lkIHBjaV9zZXRfbXNpX2RvbWFpbihzdHJ1Y3QgcGNpX2RldiAqZGV2KQo+ICDCoHZvaWQgcGNp
X2RldmljZV9hZGQoc3RydWN0IHBjaV9kZXYgKmRldiwgc3RydWN0IHBjaV9idXMgKmJ1cykKPiAg
wqB7Cj4gIMKgwqDCoMKgIGludCByZXQ7Cj4gK8KgwqDCoCBzdHJ1Y3QgZGV2aWNlICpwYXJlbnQ7
Cj4gCj4gIMKgwqDCoMKgIHBjaV9jb25maWd1cmVfZGV2aWNlKGRldik7Cj4gCj4gQEAgLTI0MjAs
NiArMjQyMSwxMCBAQCB2b2lkIHBjaV9kZXZpY2VfYWRkKHN0cnVjdCBwY2lfZGV2ICpkZXYsIHN0
cnVjdCAKPiBwY2lfYnVzICpidXMpCj4gIMKgwqDCoMKgIC8qIFNldCB1cCBNU0kgSVJRIGRvbWFp
biAqLwo+ICDCoMKgwqDCoCBwY2lfc2V0X21zaV9kb21haW4oZGV2KTsKPiAKPiArwqDCoMKgIHBh
cmVudCA9IGRldi0+ZGV2LnBhcmVudDsKPiArwqDCoMKgIGlmIChwYXJlbnQgJiYgcGFyZW50LT5i
dXMgPT0gJnBjaV9idXNfdHlwZSkKPiArwqDCoMKgwqDCoMKgwqAgZGV2aWNlX2xpbmtfYWRkKCZk
ZXYtPmRldiwgcGFyZW50LCBETF9GTEFHX0FVVE9QUk9CRV9DT05TVU1FUik7Cj4gKwo+ICDCoMKg
wqDCoCAvKiBOb3RpZmllciBjb3VsZCB1c2UgUENJIGNhcGFiaWxpdGllcyAqLwo+ICDCoMKgwqDC
oCBkZXYtPm1hdGNoX2RyaXZlciA9IGZhbHNlOwo+ICDCoMKgwqDCoCByZXQgPSBkZXZpY2VfYWRk
KCZkZXYtPmRldik7Cj4gLS0gCj4gCj4gVGhpcyB3b3VsZCB3b3JrLCBidXQgdGhlIHByb2JsZW0g
aXMgdGhhdCBpZiB0aGUgcG9ydCBkcml2ZXIgZmFpbHMgaW4gCj4gcHJvYmluZyAtIGFuZCBub3Qg
anVzdCBmb3IgLUVQUk9CRV9ERUZFUiAtIHRoZW4gdGhlIGNoaWxkIGRldmljZSB3aWxsIAo+IG5l
dmVyIHByb2JlLiBUaGlzIHZlcnkgdGhpbmcgaGFwcGVucyBvbiBteSBkZXYgYm9hcmQuIEhvd2V2
ZXIgd2UgY291bGQgCj4gZXhwYW5kIHRoZSBkZXZpY2UgbGlua3MgQVBJIHRvIGNvdmVyIHRoaXMg
c29ydCBvZiBzY2VuYXJpby4KClllcywgdGhhdCdzIGFuIHVuZGVzaXJhYmxlIGlzc3VlLCBidXQg
aW4gZmFjdCBJIHRoaW5rIGl0J3MgbW9zdGx5IAppbmRpY2F0aXZlIHRoYXQgaW52b2x2aW5nIGRy
aXZlcnMgaW4gc29tZXRoaW5nIHdoaWNoIGlzIGRlc2lnbmVkIHRvIApoYXBwZW4gYXQgYSBsZXZl
bCBiZWxvdyBkcml2ZXJzIGlzIHN0aWxsIGZ1bmRhbWVudGFsbHkgd3JvbmcgYW5kIGRvb21lZCAK
dG8gYmUgZnJhZ2lsZSBhdCBiZXN0LgoKQW5vdGhlciB0aG91Z2h0IHRoYXQgY3Jvc3NlcyBteSBt
aW5kIGlzIHRoYXQgd2hlbiBwY2lfZGV2aWNlX2dyb3VwKCkgCndhbGtzIHVwIHRvIHRoZSBwb2lu
dCBvZiBBQ1MgaXNvbGF0aW9uIGFuZCBkb2Vzbid0IGZpbmQgYW4gZXhpc3RpbmcgCmdyb3VwLCBp
dCBjYW4gc3RpbGwgaW5mZXIgdGhhdCBldmVyeXRoaW5nIGl0IHdhbGtlZCBwYXN0ICpzaG91bGQq
IGJlIHB1dCAKaW4gdGhlIHNhbWUgZ3JvdXAgaXQncyB0aGVuIGV2ZW50dWFsbHkgZ29pbmcgdG8g
cmV0dXJuLiBVbmZvcnR1bmF0ZWx5IEkgCmNhbid0IHNlZSBhbiBvYnZpb3VzIHdheSBmb3IgaXQg
dG8gYWN0IG9uIHRoYXQga25vd2xlZGdlLCB0aG91Z2gsIHNpbmNlIApyZWN1cnNpdmUgaW9tbXVf
cHJvYmVfZGV2aWNlKCkgaXMgdW5saWtlbHkgdG8gZW5kIHdlbGwuCgo+IEFzIGZvciBhbHRlcm5h
dGl2ZXMsIGl0IGxvb2tzIHByZXR0eSBkaWZmaWN1bHQgdG8gbWUgdG8gZGlzYXNzb2NpYXRlIHRo
ZSAKPiBncm91cCBhbGxvY2F0aW9uIGZyb20gdGhlIGRtYV9jb25maWd1cmUgcGF0aC4KCkluZGVl
ZCBpdCdzIG5vbi10cml2aWFsLCBidXQgaXQgcmVhbGx5IGRvZXMgbmVlZCBjbGVhbmluZyB1cCBh
dCBzb21lIHBvaW50LgoKSGF2aW5nIGp1c3QgaGFkIHlldCBhbm90aGVyIHNwYXJrLCBkb2VzIHNv
bWV0aGluZyBsaWtlIHRoZSB1bnRlc3RlZCAKc3VwZXItaGFjayBiZWxvdyB3b3JrIGF0IGFsbD8g
SSBkb3VidCBpdCdzIGEgdmlhYmxlIGRpcmVjdGlvbiB0byB0YWtlIGluIAppdHNlbGYsIGJ1dCBp
dCBjb3VsZCBiZSBmb29kIGZvciB0aG91Z2h0IGlmIGl0IGF0IGxlYXN0IHByb3ZlcyB0aGUgY29u
Y2VwdC4KClJvYmluLgoKLS0tLS0+OC0tLS0tCmRpZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L2Fy
bS1zbW11LXYzLmMgYi9kcml2ZXJzL2lvbW11L2FybS1zbW11LXYzLmMKaW5kZXggYWEzYWMyYTAz
ODA3Li41NTRjZGU3NmM3NjYgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvaW9tbXUvYXJtLXNtbXUtdjMu
YworKysgYi9kcml2ZXJzL2lvbW11L2FybS1zbW11LXYzLmMKQEAgLTM4NDEsMjAgKzM4NDEsMjAg
QEAgc3RhdGljIGludCBhcm1fc21tdV9zZXRfYnVzX29wcyhzdHJ1Y3QgaW9tbXVfb3BzIAoqb3Bz
KQogIAlpbnQgZXJyOwoKICAjaWZkZWYgQ09ORklHX1BDSQotCWlmIChwY2lfYnVzX3R5cGUuaW9t
bXVfb3BzICE9IG9wcykgeworCWlmICgxKSB7CiAgCQllcnIgPSBidXNfc2V0X2lvbW11KCZwY2lf
YnVzX3R5cGUsIG9wcyk7CiAgCQlpZiAoZXJyKQogIAkJCXJldHVybiBlcnI7CiAgCX0KICAjZW5k
aWYKICAjaWZkZWYgQ09ORklHX0FSTV9BTUJBCi0JaWYgKGFtYmFfYnVzdHlwZS5pb21tdV9vcHMg
IT0gb3BzKSB7CisJaWYgKDEpIHsKICAJCWVyciA9IGJ1c19zZXRfaW9tbXUoJmFtYmFfYnVzdHlw
ZSwgb3BzKTsKICAJCWlmIChlcnIpCiAgCQkJZ290byBlcnJfcmVzZXRfcGNpX29wczsKICAJfQog
ICNlbmRpZgotCWlmIChwbGF0Zm9ybV9idXNfdHlwZS5pb21tdV9vcHMgIT0gb3BzKSB7CisJaWYg
KDEpIHsKICAJCWVyciA9IGJ1c19zZXRfaW9tbXUoJnBsYXRmb3JtX2J1c190eXBlLCBvcHMpOwog
IAkJaWYgKGVycikKICAJCQlnb3RvIGVycl9yZXNldF9hbWJhX29wczsKZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvaW9tbXUvaW9tbXUuYyBiL2RyaXZlcnMvaW9tbXUvaW9tbXUuYwppbmRleCA2NjBlZWE4
ZDFkMmYuLmI4MWFlMmI0ZDRmYiAxMDA2NDQKLS0tIGEvZHJpdmVycy9pb21tdS9pb21tdS5jCisr
KyBiL2RyaXZlcnMvaW9tbXUvaW9tbXUuYwpAQCAtMTU0Miw2ICsxNTQyLDE0IEBAIHN0YXRpYyBp
bnQgaW9tbXVfYnVzX2luaXQoc3RydWN0IGJ1c190eXBlICpidXMsIApjb25zdCBzdHJ1Y3QgaW9t
bXVfb3BzICpvcHMpCiAgCXJldHVybiBlcnI7CiAgfQoKK3N0YXRpYyBpbnQgaW9tbXVfYnVzX3Jl
cGxheShzdHJ1Y3QgZGV2aWNlICpkZXYsIHZvaWQgKmRhdGEpCit7CisJaWYgKGRldi0+aW9tbXVf
Z3JvdXApCisJCXJldHVybiAwOworCisJcmV0dXJuIGFkZF9pb21tdV9ncm91cChkZXYsIGRhdGEp
OworfQorCiAgLyoqCiAgICogYnVzX3NldF9pb21tdSAtIHNldCBpb21tdS1jYWxsYmFja3MgZm9y
IHRoZSBidXMKICAgKiBAYnVzOiBidXMuCkBAIC0xNTY0LDYgKzE1NzIsOSBAQCBpbnQgYnVzX3Nl
dF9pb21tdShzdHJ1Y3QgYnVzX3R5cGUgKmJ1cywgY29uc3QgCnN0cnVjdCBpb21tdV9vcHMgKm9w
cykKICAJCXJldHVybiAwOwogIAl9CgorCWlmIChidXMtPmlvbW11X29wcyA9PSBvcHMpCisJCXJl
dHVybiBidXNfZm9yX2VhY2hfZGV2KGJ1cywgTlVMTCwgTlVMTCwgaW9tbXVfYnVzX3JlcGxheSk7
CisKICAJaWYgKGJ1cy0+aW9tbXVfb3BzICE9IE5VTEwpCiAgCQlyZXR1cm4gLUVCVVNZOwoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGlu
ZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGlu
dXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
