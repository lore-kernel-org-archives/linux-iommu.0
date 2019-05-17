Return-Path: <SRS0=WrXO=TR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF232C04AB4
	for <iommu@archiver.kernel.org>; Fri, 17 May 2019 07:08:17 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C895020833
	for <iommu@archiver.kernel.org>; Fri, 17 May 2019 07:08:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C895020833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 9D219415;
	Fri, 17 May 2019 07:08:17 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 99E233EE
	for <iommu@lists.linux-foundation.org>;
	Fri, 17 May 2019 07:08:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 4B76E710
	for <iommu@lists.linux-foundation.org>;
	Fri, 17 May 2019 07:08:16 +0000 (UTC)
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EE18081DE6;
	Fri, 17 May 2019 07:07:42 +0000 (UTC)
Received: from [10.36.116.17] (ovpn-116-17.ams2.redhat.com [10.36.116.17])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 274AC5D9C4;
	Fri, 17 May 2019 07:07:31 +0000 (UTC)
Subject: Re: [PATCH v3 7/7] iommu/vt-d: Differentiate relaxable and non
	relaxable RMRRs
To: Lu Baolu <baolu.lu@linux.intel.com>, eric.auger.pro@gmail.com,
	joro@8bytes.org, iommu@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org, dwmw2@infradead.org,
	lorenzo.pieralisi@arm.com, robin.murphy@arm.com, will.deacon@arm.com,
	hanjun.guo@linaro.org, sudeep.holla@arm.com
References: <20190516100817.12076-1-eric.auger@redhat.com>
	<20190516100817.12076-8-eric.auger@redhat.com>
	<2ebc33ed-ded6-0eee-96ef-84e6f61f692e@linux.intel.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <65852894-2525-e67e-5fd3-55ba4a323c2f@redhat.com>
Date: Fri, 17 May 2019 09:07:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <2ebc33ed-ded6-0eee-96ef-84e6f61f692e@linux.intel.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.25]);
	Fri, 17 May 2019 07:08:05 +0000 (UTC)
Cc: alex.williamson@redhat.com
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

SGkgTHUsCgpPbiA1LzE3LzE5IDY6NDYgQU0sIEx1IEJhb2x1IHdyb3RlOgo+IEhpIEVyaWMsCj4g
Cj4gT24gNS8xNi8xOSA2OjA4IFBNLCBFcmljIEF1Z2VyIHdyb3RlOgo+PiBOb3cgd2UgaGF2ZSBh
IG5ldyBJT01NVV9SRVNWX0RJUkVDVF9SRUxBWEFCTEUgcmVzZXJ2ZWQgbWVtb3J5Cj4+IHJlZ2lv
biB0eXBlLCBsZXQncyByZXBvcnQgVVNCIGFuZCBHRlggUk1SUnMgYXMgcmVsYXhhYmxlIG9uZXMu
Cj4+Cj4+IFRoaXMgYWxsb3dzIHRvIGhhdmUgYSBmaW5lciByZXBvcnRpbmcgYXQgSU9NTVUgQVBJ
IGxldmVsIG9mCj4+IHJlc2VydmVkIG1lbW9yeSByZWdpb25zLiBUaGlzIHdpbGwgYmUgZXhwbG9p
dGFibGUgYnkgVkZJTyB0bwo+PiBkZWZpbmUgdGhlIHVzYWJsZSBJT1ZBIHJhbmdlIGFuZCBkZXRl
Y3QgcG90ZW50aWFsIGNvbmZsaWN0cwo+PiBiZXR3ZWVuIHRoZSBndWVzdCBwaHlzaWNhbCBhZGRy
ZXNzIHNwYWNlIGFuZCBob3N0IHJlc2VydmVkCj4+IHJlZ2lvbnMuCj4+Cj4+IFNpZ25lZC1vZmYt
Ynk6IEVyaWMgQXVnZXIgPGVyaWMuYXVnZXJAcmVkaGF0LmNvbT4KPj4gLS0tCj4+IMKgIGRyaXZl
cnMvaW9tbXUvaW50ZWwtaW9tbXUuYyB8IDEwICsrKysrKysrLS0KPj4gwqAgMSBmaWxlIGNoYW5n
ZWQsIDggaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKPj4KPj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvaW9tbXUvaW50ZWwtaW9tbXUuYyBiL2RyaXZlcnMvaW9tbXUvaW50ZWwtaW9tbXUuYwo+
PiBpbmRleCBhMzY2MDRmNDkwMGYuLmFmMWQ2NWZkZWRmYyAxMDA2NDQKPj4gLS0tIGEvZHJpdmVy
cy9pb21tdS9pbnRlbC1pb21tdS5jCj4+ICsrKyBiL2RyaXZlcnMvaW9tbXUvaW50ZWwtaW9tbXUu
Ywo+PiBAQCAtNTQ5Myw3ICs1NDkzLDkgQEAgc3RhdGljIHZvaWQgaW50ZWxfaW9tbXVfZ2V0X3Jl
c3ZfcmVnaW9ucyhzdHJ1Y3QKPj4gZGV2aWNlICpkZXZpY2UsCj4+IMKgwqDCoMKgwqAgZm9yX2Vh
Y2hfcm1ycl91bml0cyhybXJyKSB7Cj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBmb3JfZWFjaF9hY3Rp
dmVfZGV2X3Njb3BlKHJtcnItPmRldmljZXMsIHJtcnItPmRldmljZXNfY250LAo+PiDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGksIGlfZGV2KSB7Cj4+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIHN0cnVjdCBwY2lfZGV2ICpwZGV2ID0gdG9fcGNpX2Rldihk
ZXZpY2UpOwo+IAo+IFByb2JhYmx5IHNob3VsZCBiZToKPiAKPiBzdHJ1Y3QgcGNpX2RldiAqcGRl
diA9IGRldl9pc19wY2koZGV2aWNlKSA/IHRvX3BjaV9kZXYoZGV2aWNlKSA6IE5VTEw7CgpUaGF0
J3MgY29ycmVjdC4gSSB3aWxsIGZpeCB0aGF0IGFzYXAuCgpUaGFua3MhCgpFcmljCj4gCj4gQmVz
dCByZWdhcmRzLAo+IEx1IEJhb2x1Cj4gCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3Vu
ZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0
aW5mby9pb21tdQ==
