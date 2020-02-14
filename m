Return-Path: <SRS0=UfLp=4C=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2E9CC2BA83
	for <iommu@archiver.kernel.org>; Fri, 14 Feb 2020 14:10:21 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A45BA2082F
	for <iommu@archiver.kernel.org>; Fri, 14 Feb 2020 14:10:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A45BA2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 476E0855EA;
	Fri, 14 Feb 2020 14:10:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GPRqdhGdgleX; Fri, 14 Feb 2020 14:10:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 0F4D681F51;
	Fri, 14 Feb 2020 14:10:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EA238C08A4;
	Fri, 14 Feb 2020 14:10:18 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8ACF6C0177
 for <iommu@lists.linux-foundation.org>; Fri, 14 Feb 2020 14:10:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 6BB9120116
 for <iommu@lists.linux-foundation.org>; Fri, 14 Feb 2020 14:10:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qSY6X0cF1aao for <iommu@lists.linux-foundation.org>;
 Fri, 14 Feb 2020 14:10:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from huawei.com (lhrrgout.huawei.com [185.176.76.210])
 by silver.osuosl.org (Postfix) with ESMTPS id E37E922179
 for <iommu@lists.linux-foundation.org>; Fri, 14 Feb 2020 14:09:06 +0000 (UTC)
Received: from lhreml704-cah.china.huawei.com (unknown [172.18.7.107])
 by Forcepoint Email with ESMTP id 32D03A8611647239498F;
 Fri, 14 Feb 2020 14:09:04 +0000 (GMT)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 lhreml704-cah.china.huawei.com (10.201.108.45) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 14 Feb 2020 14:09:03 +0000
Received: from [127.0.0.1] (10.202.226.45) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 14 Feb
 2020 14:09:03 +0000
Subject: Re: arm64 iommu groups issue
To: Robin Murphy <robin.murphy@arm.com>, Marc Zyngier <maz@kernel.org>, "Will
 Deacon" <will@kernel.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, 
 Sudeep Holla <sudeep.holla@arm.com>, "Guohanjun (Hanjun Guo)"
 <guohanjun@huawei.com>
References: <9625faf4-48ef-2dd3-d82f-931d9cf26976@huawei.com>
 <4768c541-ebf4-61d5-0c5e-77dee83f8f94@arm.com>
 <a18b7f26-9713-a5c7-507e-ed70e40bc007@huawei.com>
 <ddc7eaff-c3f9-4304-9b4e-75eff2c66cd5@huawei.com>
 <be464e2a-03d5-0b2e-24ee-96d0d14fd739@arm.com>
From: John Garry <john.garry@huawei.com>
Message-ID: <35fc8d13-b1c1-6a9e-4242-284da7f00764@huawei.com>
Date: Fri, 14 Feb 2020 14:09:02 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <be464e2a-03d5-0b2e-24ee-96d0d14fd739@arm.com>
Content-Language: en-US
X-Originating-IP: [10.202.226.45]
X-ClientProxiedBy: lhreml721-chm.china.huawei.com (10.201.108.72) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Cc: Saravana Kannan <saravanak@google.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Alex
 Williamson <alex.williamson@redhat.com>, Linuxarm <linuxarm@huawei.com>,
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

Pj4KPj4gQEAgLTI0MjAsNiArMjQyMSwxMCBAQCB2b2lkIHBjaV9kZXZpY2VfYWRkKHN0cnVjdCBw
Y2lfZGV2ICpkZXYsIHN0cnVjdAo+PiBwY2lfYnVzICpidXMpCj4+ICAgwqDCoMKgwqAgLyogU2V0
IHVwIE1TSSBJUlEgZG9tYWluICovCj4+ICAgwqDCoMKgwqAgcGNpX3NldF9tc2lfZG9tYWluKGRl
dik7Cj4+Cj4+ICvCoMKgwqAgcGFyZW50ID0gZGV2LT5kZXYucGFyZW50Owo+PiArwqDCoMKgIGlm
IChwYXJlbnQgJiYgcGFyZW50LT5idXMgPT0gJnBjaV9idXNfdHlwZSkKPj4gK8KgwqDCoMKgwqDC
oMKgIGRldmljZV9saW5rX2FkZCgmZGV2LT5kZXYsIHBhcmVudCwgRExfRkxBR19BVVRPUFJPQkVf
Q09OU1VNRVIpOwo+PiArCj4+ICAgwqDCoMKgwqAgLyogTm90aWZpZXIgY291bGQgdXNlIFBDSSBj
YXBhYmlsaXRpZXMgKi8KPj4gICDCoMKgwqDCoCBkZXYtPm1hdGNoX2RyaXZlciA9IGZhbHNlOwo+
PiAgIMKgwqDCoMKgIHJldCA9IGRldmljZV9hZGQoJmRldi0+ZGV2KTsKPj4gLS0gCj4+Cj4+IFRo
aXMgd291bGQgd29yaywgYnV0IHRoZSBwcm9ibGVtIGlzIHRoYXQgaWYgdGhlIHBvcnQgZHJpdmVy
IGZhaWxzIGluCj4+IHByb2JpbmcgLSBhbmQgbm90IGp1c3QgZm9yIC1FUFJPQkVfREVGRVIgLSB0
aGVuIHRoZSBjaGlsZCBkZXZpY2Ugd2lsbAo+PiBuZXZlciBwcm9iZS4gVGhpcyB2ZXJ5IHRoaW5n
IGhhcHBlbnMgb24gbXkgZGV2IGJvYXJkLiBIb3dldmVyIHdlIGNvdWxkCj4+IGV4cGFuZCB0aGUg
ZGV2aWNlIGxpbmtzIEFQSSB0byBjb3ZlciB0aGlzIHNvcnQgb2Ygc2NlbmFyaW8uCj4gCj4gWWVz
LCB0aGF0J3MgYW4gdW5kZXNpcmFibGUgaXNzdWUsIGJ1dCBpbiBmYWN0IEkgdGhpbmsgaXQncyBt
b3N0bHkKPiBpbmRpY2F0aXZlIHRoYXQgaW52b2x2aW5nIGRyaXZlcnMgaW4gc29tZXRoaW5nIHdo
aWNoIGlzIGRlc2lnbmVkIHRvCj4gaGFwcGVuIGF0IGEgbGV2ZWwgYmVsb3cgZHJpdmVycyBpcyBz
dGlsbCBmdW5kYW1lbnRhbGx5IHdyb25nIGFuZCBkb29tZWQKPiB0byBiZSBmcmFnaWxlIGF0IGJl
c3QuCgpSaWdodCwgYW5kIGV2ZW4gd29yc2UgaXMgdGhhdCBpdCByZWxpZXMgb24gdGhlIHBvcnQg
ZHJpdmVyIGV2ZW4gZXhpc3RpbmcgCmF0IGFsbC4KCkFsbCB0aGlzIGlvbW11IGdyb3VwIGFzc2ln
bm1lbnQgc2hvdWxkIGJlIHRha2VuIG91dHNpZGUgZGV2aWNlIGRyaXZlciAKcHJvYmUgcGF0aHMu
CgpIb3dldmVyIHdlIGNvdWxkIHN0aWxsIGNvbnNpZGVyIGRldmljZSBsaW5rcyBmb3Igc3luYydp
bmcgdGhlIFNNTVUgYW5kIAplYWNoIGRldmljZSBwcm9iaW5nLgoKPiAKPiBBbm90aGVyIHRob3Vn
aHQgdGhhdCBjcm9zc2VzIG15IG1pbmQgaXMgdGhhdCB3aGVuIHBjaV9kZXZpY2VfZ3JvdXAoKQo+
IHdhbGtzIHVwIHRvIHRoZSBwb2ludCBvZiBBQ1MgaXNvbGF0aW9uIGFuZCBkb2Vzbid0IGZpbmQg
YW4gZXhpc3RpbmcKPiBncm91cCwgaXQgY2FuIHN0aWxsIGluZmVyIHRoYXQgZXZlcnl0aGluZyBp
dCB3YWxrZWQgcGFzdCAqc2hvdWxkKiBiZSBwdXQKPiBpbiB0aGUgc2FtZSBncm91cCBpdCdzIHRo
ZW4gZXZlbnR1YWxseSBnb2luZyB0byByZXR1cm4uIFVuZm9ydHVuYXRlbHkgSQo+IGNhbid0IHNl
ZSBhbiBvYnZpb3VzIHdheSBmb3IgaXQgdG8gYWN0IG9uIHRoYXQga25vd2xlZGdlLCB0aG91Z2gs
IHNpbmNlCj4gcmVjdXJzaXZlIGlvbW11X3Byb2JlX2RldmljZSgpIGlzIHVubGlrZWx5IHRvIGVu
ZCB3ZWxsLgoKSSdkIGJlIGluY2xpbmVkIG5vdCB0byBjaGFuZ2UgdGhhdCBjb2RlLgoKPiAKPj4g
QXMgZm9yIGFsdGVybmF0aXZlcywgaXQgbG9va3MgcHJldHR5IGRpZmZpY3VsdCB0byBtZSB0byBk
aXNhc3NvY2lhdGUgdGhlCj4+IGdyb3VwIGFsbG9jYXRpb24gZnJvbSB0aGUgZG1hX2NvbmZpZ3Vy
ZSBwYXRoLgo+IAo+IEluZGVlZCBpdCdzIG5vbi10cml2aWFsLCBidXQgaXQgcmVhbGx5IGRvZXMg
bmVlZCBjbGVhbmluZyB1cCBhdCBzb21lIHBvaW50Lgo+IAo+IEhhdmluZyBqdXN0IGhhZCB5ZXQg
YW5vdGhlciBzcGFyaywgZG9lcyBzb21ldGhpbmcgbGlrZSB0aGUgdW50ZXN0ZWQKPiBzdXBlci1o
YWNrIGJlbG93IHdvcmsgYXQgYWxsPyAKCkkgdHJpZWQgaXQgYW5kIGl0IGRvZXNuJ3QgKHlldCkg
d29yay4KClNvIHdoZW4gd2UgdHJ5IAppb21tdV9idXNfcmVwbGF5KCktPmFkZF9pb21tdV9ncm91
cCgpLT5pb21tdV9wcm9iZV9kZXZpY2UoKS0+YXJtX3NtbXVfYWRkX2RldmljZSgpLAp0aGUgaW9t
bXVfZndzcGVjIGlzIHN0aWxsIE5VTEwgZm9yIHRoYXQgZGV2aWNlIC0gdGhpcyBpcyBub3Qgc2V0
IHVudGlsIApsYXRlciB3aGVuIHRoZSBkZXZpY2UgZHJpdmVyIGlzIGdvaW5nIHRvIGZpbmFsbHkg
cHJvYmUgaW4gCmlvcnRfaW9tbXVfeGxhdGUoKS0+aW9tbXVfZndzcGVjX2luaXQoKSwgYW5kIGl0
J3MgdG9vIGxhdGUuLi4KCkFuZCB0aGlzIGxvb2tzIHRvIGJlIHRoZSByZWFzb24gZm9yIHdoaWNo
IGN1cnJlbnQgCmlvbW11X2J1c19pbml0KCktPmJ1c19mb3JfZWFjaF9kZXZpY2UoLi4uLCBhZGRf
aW9tbXVfZ3JvdXApIGZhaWxzIGFsc28uCgpPbiB0aGlzIGN1cnJlbnQgY29kZSBtZW50aW9uZWQs
IHRoZSBwcmluY2lwbGUgb2YgdGhpcyBzZWVtcyB3cm9uZyB0byBtZSAKLSB3ZSBjYWxsIGJ1c19m
b3JfZWFjaF9kZXZpY2UoLi4uLCBhZGRfaW9tbXVfZ3JvdXApIGZvciB0aGUgZmlyc3QgU01NVSAK
aW4gdGhlIHN5c3RlbSB3aGljaCBwcm9iZXMsIGJ1dCB3ZSBhdHRlbXB0IHRvIGFkZF9pb21tdV9n
cm91cCgpIGZvciBhbGwgCmRldmljZXMgb24gdGhlIGJ1cywgZXZlbiB0aG91Z2ggdGhlIFNNTVUg
Zm9yIHRoYXQgZGV2aWNlIG1heSB5ZXQgdG8gaGF2ZSAKcHJvYmVkLgoKVGhhbmtzLApKb2huCgpJ
IGRvdWJ0IGl0J3MgYSB2aWFibGUgZGlyZWN0aW9uIHRvIHRha2UgaW4KPiBpdHNlbGYsIGJ1dCBp
dCBjb3VsZCBiZSBmb29kIGZvciB0aG91Z2h0IGlmIGl0IGF0IGxlYXN0IHByb3ZlcyB0aGUgY29u
Y2VwdC4KPiAKPiBSb2Jpbi4KPiAKPiAtLS0tLT44LS0tLS0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9pb21tdS9hcm0tc21tdS12My5jIGIvZHJpdmVycy9pb21tdS9hcm0tc21tdS12My5jCj4gaW5k
ZXggYWEzYWMyYTAzODA3Li41NTRjZGU3NmM3NjYgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9pb21t
dS9hcm0tc21tdS12My5jCj4gKysrIGIvZHJpdmVycy9pb21tdS9hcm0tc21tdS12My5jCj4gQEAg
LTM4NDEsMjAgKzM4NDEsMjAgQEAgc3RhdGljIGludCBhcm1fc21tdV9zZXRfYnVzX29wcyhzdHJ1
Y3QgaW9tbXVfb3BzCj4gKm9wcykKPiAgICAJaW50IGVycjsKPiAKPiAgICAjaWZkZWYgQ09ORklH
X1BDSQo+IC0JaWYgKHBjaV9idXNfdHlwZS5pb21tdV9vcHMgIT0gb3BzKSB7Cj4gKwlpZiAoMSkg
ewo+ICAgIAkJZXJyID0gYnVzX3NldF9pb21tdSgmcGNpX2J1c190eXBlLCBvcHMpOwo+ICAgIAkJ
aWYgKGVycikKPiAgICAJCQlyZXR1cm4gZXJyOwo+ICAgIAl9Cj4gICAgI2VuZGlmCj4gICAgI2lm
ZGVmIENPTkZJR19BUk1fQU1CQQo+IC0JaWYgKGFtYmFfYnVzdHlwZS5pb21tdV9vcHMgIT0gb3Bz
KSB7Cj4gKwlpZiAoMSkgewo+ICAgIAkJZXJyID0gYnVzX3NldF9pb21tdSgmYW1iYV9idXN0eXBl
LCBvcHMpOwo+ICAgIAkJaWYgKGVycikKPiAgICAJCQlnb3RvIGVycl9yZXNldF9wY2lfb3BzOwo+
ICAgIAl9Cj4gICAgI2VuZGlmCj4gLQlpZiAocGxhdGZvcm1fYnVzX3R5cGUuaW9tbXVfb3BzICE9
IG9wcykgewo+ICsJaWYgKDEpIHsKPiAgICAJCWVyciA9IGJ1c19zZXRfaW9tbXUoJnBsYXRmb3Jt
X2J1c190eXBlLCBvcHMpOwo+ICAgIAkJaWYgKGVycikKPiAgICAJCQlnb3RvIGVycl9yZXNldF9h
bWJhX29wczsKPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pb21tdS9pb21tdS5jIGIvZHJpdmVycy9p
b21tdS9pb21tdS5jCj4gaW5kZXggNjYwZWVhOGQxZDJmLi5iODFhZTJiNGQ0ZmIgMTAwNjQ0Cj4g
LS0tIGEvZHJpdmVycy9pb21tdS9pb21tdS5jCj4gKysrIGIvZHJpdmVycy9pb21tdS9pb21tdS5j
Cj4gQEAgLTE1NDIsNiArMTU0MiwxNCBAQCBzdGF0aWMgaW50IGlvbW11X2J1c19pbml0KHN0cnVj
dCBidXNfdHlwZSAqYnVzLAo+IGNvbnN0IHN0cnVjdCBpb21tdV9vcHMgKm9wcykKPiAgICAJcmV0
dXJuIGVycjsKPiAgICB9Cj4gCj4gK3N0YXRpYyBpbnQgaW9tbXVfYnVzX3JlcGxheShzdHJ1Y3Qg
ZGV2aWNlICpkZXYsIHZvaWQgKmRhdGEpCj4gK3sKPiArCWlmIChkZXYtPmlvbW11X2dyb3VwKQo+
ICsJCXJldHVybiAwOwo+ICsKPiArCXJldHVybiBhZGRfaW9tbXVfZ3JvdXAoZGV2LCBkYXRhKTsK
PiArfQo+ICsKPiAgICAvKioKPiAgICAgKiBidXNfc2V0X2lvbW11IC0gc2V0IGlvbW11LWNhbGxi
YWNrcyBmb3IgdGhlIGJ1cwo+ICAgICAqIEBidXM6IGJ1cy4KPiBAQCAtMTU2NCw2ICsxNTcyLDkg
QEAgaW50IGJ1c19zZXRfaW9tbXUoc3RydWN0IGJ1c190eXBlICpidXMsIGNvbnN0Cj4gc3RydWN0
IGlvbW11X29wcyAqb3BzKQo+ICAgIAkJcmV0dXJuIDA7Cj4gICAgCX0KPiAKPiArCWlmIChidXMt
PmlvbW11X29wcyA9PSBvcHMpCj4gKwkJcmV0dXJuIGJ1c19mb3JfZWFjaF9kZXYoYnVzLCBOVUxM
LCBOVUxMLCBpb21tdV9idXNfcmVwbGF5KTsKPiArCj4gICAgCWlmIChidXMtPmlvbW11X29wcyAh
PSBOVUxMKQo+ICAgIAkJcmV0dXJuIC1FQlVTWTsKPiAKCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5s
aW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFp
bG1hbi9saXN0aW5mby9pb21tdQ==
