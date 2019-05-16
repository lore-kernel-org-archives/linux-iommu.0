Return-Path: <SRS0=5HPr=TQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D0DBC04E84
	for <iommu@archiver.kernel.org>; Thu, 16 May 2019 16:53:50 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6540F2168B
	for <iommu@archiver.kernel.org>; Thu, 16 May 2019 16:53:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6540F2168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 35058C79;
	Thu, 16 May 2019 16:53:50 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 31292C77
	for <iommu@lists.linux-foundation.org>;
	Thu, 16 May 2019 16:53:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id D178B837
	for <iommu@lists.linux-foundation.org>;
	Thu, 16 May 2019 16:53:48 +0000 (UTC)
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3CD1D309267B;
	Thu, 16 May 2019 16:53:48 +0000 (UTC)
Received: from x1.home (ovpn-117-92.phx2.redhat.com [10.3.117.92])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 45FE760E39;
	Thu, 16 May 2019 16:53:45 +0000 (UTC)
Date: Thu, 16 May 2019 10:53:44 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Auger Eric <eric.auger@redhat.com>
Subject: Re: [PATCH v3 6/7] iommu: Introduce IOMMU_RESV_DIRECT_RELAXABLE
	reserved memory regions
Message-ID: <20190516105344.5add5520@x1.home>
In-Reply-To: <57db1955-9d19-7c0b-eca3-37cc0d7d745b@redhat.com>
References: <20190516100817.12076-1-eric.auger@redhat.com>
	<20190516100817.12076-7-eric.auger@redhat.com>
	<ad8a99fa-b98a-14d3-12be-74df0e6eb8f8@arm.com>
	<57db1955-9d19-7c0b-eca3-37cc0d7d745b@redhat.com>
Organization: Red Hat
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.43]);
	Thu, 16 May 2019 16:53:48 +0000 (UTC)
Cc: Robin Murphy <robin.murphy@arm.com>, will.deacon@arm.com,
	linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
	sudeep.holla@arm.com, dwmw2@infradead.org, eric.auger.pro@gmail.com
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

T24gVGh1LCAxNiBNYXkgMjAxOSAxNToyMzoxNyArMDIwMApBdWdlciBFcmljIDxlcmljLmF1Z2Vy
QHJlZGhhdC5jb20+IHdyb3RlOgoKPiBIaSBSb2JpbiwKPiBPbiA1LzE2LzE5IDI6NDYgUE0sIFJv
YmluIE11cnBoeSB3cm90ZToKPiA+PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9pb21tdS5o
IGIvaW5jbHVkZS9saW51eC9pb21tdS5oCj4gPj4gaW5kZXggYmE5MTY2Njk5OGZiLi4xNGE1MjFm
ODVmMTQgMTAwNjQ0Cj4gPj4gLS0tIGEvaW5jbHVkZS9saW51eC9pb21tdS5oCj4gPj4gKysrIGIv
aW5jbHVkZS9saW51eC9pb21tdS5oCj4gPj4gQEAgLTEzNSw2ICsxMzUsMTIgQEAgZW51bSBpb21t
dV9hdHRyIHsKPiA+PiDCoCBlbnVtIGlvbW11X3Jlc3ZfdHlwZSB7Cj4gPj4gwqDCoMKgwqDCoCAv
KiBNZW1vcnkgcmVnaW9ucyB3aGljaCBtdXN0IGJlIG1hcHBlZCAxOjEgYXQgYWxsIHRpbWVzICov
Cj4gPj4gwqDCoMKgwqDCoCBJT01NVV9SRVNWX0RJUkVDVCwKPiA+PiArwqDCoMKgIC8qCj4gPj4g
K8KgwqDCoMKgICogTWVtb3J5IHJlZ2lvbnMgd2hpY2ggYXJlIGFkdmVydGlzZWQgdG8gYmUgMTox
IGJ1dCBhcmUKPiA+PiArwqDCoMKgwqAgKiBjb21tb25seSBjb25zaWRlcmVkIHJlbGF4YWJsZSBp
biBzb21lIGNvbmRpdGlvbnMsCj4gPj4gK8KgwqDCoMKgICogZm9yIGluc3RhbmNlIGluIGRldmlj
ZSBhc3NpZ25tZW50IHVzZSBjYXNlIChVU0IsIEdyYXBoaWNzKQo+ID4+ICvCoMKgwqDCoCAqLwo+
ID4+ICvCoMKgwqAgSU9NTVVfUkVTVl9ESVJFQ1RfUkVMQVhBQkxFLCAgCj4gPiAKPiA+IFdoYXQg
ZG8geW91IHRoaW5rIG9mIHMvUkVMQVhBQkxFL0JPT1QvID8gTXkgdW5kZXJzdGFuZGluZyBpcyB0
aGF0IHRoZXNlCj4gPiByZWdpb25zIGFyZSBvbmx5IGNvbnNpZGVyZWQgcmVsZXZhbnQgdW50aWwg
TGludXggaGFzIHRha2VuIGZ1bGwgY29udHJvbAo+ID4gb2YgdGhlIGVuZHBvaW50LCBhbmQgaGF2
aW5nIGEgc2xpZ2h0bHkgbW9yZSB3ZWxsLWRlZmluZWQgc2NvcGUgdGhhbgo+ID4gInNvbWUgY29u
ZGl0aW9ucyIgbWlnaHQgYmUgbmljZS4gIAo+IFRoYXQncyBub3QgbXkgY3VycmVudCB1bmRlcnN0
YW5kaW5nLiBJIHRoaW5rIHRob3NlIFJNUlJzIG1heSBiZSB1c2VkCj4gcG9zdC1ib290IChlc3Bl
Y2lhbGx5IHRoZSBJR0Qgc3RvbGVuIG1lbW9yeSBjb3ZlcmVkIGJ5IFJNUlIpLiBJCj4gdW5kZXJz
dGFuZCB0aGlzIGRlcGVuZHMgb24gdGhlIHZpZGVvIG1vZGUgb3IgRlcgaW4gdXNlIGJ5IHRoZSBJ
R0QuIEJ1dCBJCj4gYW0gZGVmaW5pdGl2ZWx5IG5vdCBhbiBleHBlcnQgaGVyZS4KCk5vciBhbSBJ
LCBidXQgZ2VuZXJhbGx5IHRoZSBkaXN0aW5jdGlvbiBJJ20gdHJ5aW5nIHRvIGFjaGlldmUgaXMK
d2hldGhlciB0aGUgcmVzZXJ2ZWQgcmVnaW9uIGlzIG5lY2Vzc2FyeSBmb3IgdGhlIGRldmljZSBv
cGVyYXRpb24gb3IKZm9yIHRoZSBzeXN0ZW0gb3BlcmF0aW9uLiAgSWYgd2UgZGVueSB0aGUgSUdE
IGRldmljZSBpdHMgbWFwcGluZyB0bwpzdG9sZW4gbWVtb3J5LCB0aGVuIG1heWJlIHRoZSBJR0Qg
ZGV2aWNlIGRvZXNuJ3Qgd29yaywgbm8gYmlnIGRlYWwuICBJZgp3ZSBkZW55IFVTQiBpdHMgUk1S
UiwgdGhlbiB3ZSBhc3N1bWUgd2UncmUgb25seSBjdXR0aW5nIG9mZiBQUy8yCmVtdWxhdGlvbiB0
aGF0IHdlIGV4cGVjdCBpc24ndCB1c2VkIGF0IHRoaXMgcG9pbnQgYW55d2F5LiAgQm90aCBvZiB0
aGVzZQphcmUgY2hvaWNlcyBpbiBob3cgdGhlIGRyaXZlciB3YW50cyB0byB1c2UgdGhlIGRldmlj
ZS4gIE9uIHRoZSBvdGhlcgpoYW5kIGlmIHdlIGhhdmUgYSBzeXN0ZW0gd2hlcmUgbWFuYWdlbWVu
dCBmaXJtd2FyZSBoYXMgYmFja2Rvb3JzIHRvCmRldmljZXMgZm9yIHN5c3RlbSBoZWFsdGggbW9u
aXRvcmluZywgdGhlbiBkZWNsaW5pbmcgdG8gaG9ub3IgdGhlIFJNUlIKaGFzIGxhcmdlciBpbXBs
aWNhdGlvbnMuICBUaGFua3MsCgpBbGV4Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3Vu
ZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0
aW5mby9pb21tdQ==
