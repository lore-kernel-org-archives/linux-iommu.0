Return-Path: <SRS0=H7Zn=I4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0382EC433C1
	for <iommu@archiver.kernel.org>; Tue, 30 Mar 2021 09:05:10 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 802DE6198A
	for <iommu@archiver.kernel.org>; Tue, 30 Mar 2021 09:05:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 802DE6198A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1FB9583DC1;
	Tue, 30 Mar 2021 09:05:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id v2lBN0YNPhMb; Tue, 30 Mar 2021 09:05:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 204EB83E35;
	Tue, 30 Mar 2021 09:05:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D4D09C000B;
	Tue, 30 Mar 2021 09:05:07 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 333DAC000A
 for <iommu@lists.linux-foundation.org>; Tue, 30 Mar 2021 09:05:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1241183E38
 for <iommu@lists.linux-foundation.org>; Tue, 30 Mar 2021 09:05:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yJoir1cE8cuG for <iommu@lists.linux-foundation.org>;
 Tue, 30 Mar 2021 09:05:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp1.osuosl.org (Postfix) with ESMTP id DF59382DBB
 for <iommu@lists.linux-foundation.org>; Tue, 30 Mar 2021 09:05:04 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C6CD3101E;
 Tue, 30 Mar 2021 02:05:03 -0700 (PDT)
Received: from [10.57.27.121] (unknown [10.57.27.121])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 090613F719;
 Tue, 30 Mar 2021 02:05:02 -0700 (PDT)
Subject: Re: [PATCH] iommu: Add a check to avoid invalid iotlb sync
To: "chenxiang (M)" <chenxiang66@hisilicon.com>, Will Deacon <will@kernel.org>
References: <1616826190-77035-1-git-send-email-chenxiang66@hisilicon.com>
 <20210329144554.GA4203@willie-the-truck>
 <2b0b7a7d-7162-bef9-9730-cbe3767d14f9@hisilicon.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <f4c1cc18-6b5a-575b-92ee-fc4357d72d17@arm.com>
Date: Tue, 30 Mar 2021 10:04:53 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <2b0b7a7d-7162-bef9-9730-cbe3767d14f9@hisilicon.com>
Content-Language: en-GB
Cc: iommu@lists.linux-foundation.org, linuxarm@openeuler.org
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

T24gMjAyMS0wMy0zMCAwMjoyMiwgY2hlbnhpYW5nIChNKSB3cm90ZToKPiBIaSBXaWxsLAo+IAo+
IAo+IOWcqCAyMDIxLzMvMjkgMjI6NDUsIFdpbGwgRGVhY29uIOWGmemBkzoKPj4gT24gU2F0LCBN
YXIgMjcsIDIwMjEgYXQgMDI6MjM6MTBQTSArMDgwMCwgY2hlbnhpYW5nIHdyb3RlOgo+Pj4gRnJv
bTogWGlhbmcgQ2hlbiA8Y2hlbnhpYW5nNjZAaGlzaWxpY29uLmNvbT4KPj4+Cj4+PiBDdXJyZW50
bHkgaXQgd2lsbCBzZW5kIGEgaW90bGIgc3luYyBhdCBlbmQgb2YgaW9tbXUgdW5tYXAgZXZlbiBp
Zgo+Pj4gaW90bGJfZ2F0aGVyIGlzIG5vdCB2YWxpZCAoaW90bGJfZ2F0aGVyLT5wZ3NpemUgPSAw
KS4gQWN0dWFsbHkgaXQgaXMgbm90Cj4+PiBuZWNlc3NhcnksIHNvIGFkZCBhIGNoZWNrIHRvIGF2
b2lkIGludmFsaWQgaW90bGIgc3luYy4KPj4+Cj4+PiBTaWduZWQtb2ZmLWJ5OiBYaWFuZyBDaGVu
IDxjaGVueGlhbmc2NkBoaXNpbGljb24uY29tPgo+Pj4gLS0tCj4+PiDCoCBpbmNsdWRlL2xpbnV4
L2lvbW11LmggfCAzICsrKwo+Pj4gwqAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKQo+
Pj4KPj4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L2lvbW11LmggYi9pbmNsdWRlL2xpbnV4
L2lvbW11LmgKPj4+IGluZGV4IDljYTZlNmIuLjZhZmE2MWIgMTAwNjQ0Cj4+PiAtLS0gYS9pbmNs
dWRlL2xpbnV4L2lvbW11LmgKPj4+ICsrKyBiL2luY2x1ZGUvbGludXgvaW9tbXUuaAo+Pj4gQEAg
LTUyOSw2ICs1MjksOSBAQCBzdGF0aWMgaW5saW5lIHZvaWQgaW9tbXVfZmx1c2hfaW90bGJfYWxs
KHN0cnVjdCAKPj4+IGlvbW11X2RvbWFpbiAqZG9tYWluKQo+Pj4gwqAgc3RhdGljIGlubGluZSB2
b2lkIGlvbW11X2lvdGxiX3N5bmMoc3RydWN0IGlvbW11X2RvbWFpbiAqZG9tYWluLAo+Pj4gwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc3RydWN0IGlvbW11X2lvdGxiX2dh
dGhlciAqaW90bGJfZ2F0aGVyKQo+Pj4gwqAgewo+Pj4gK8KgwqDCoCBpZiAoIWlvdGxiX2dhdGhl
ci0+cGdzaXplKQo+Pj4gK8KgwqDCoMKgwqDCoMKgIHJldHVybjsKPj4gSW4gd2hpY2ggY2lyY3Vt
c3RhbmNlcyBkb2VzIHRoaXMgb2NjdXI/Cj4+Cj4+IFdpbGwKPiAKPiBXaGVuIGlvbW11X3VubWFw
LCBpdCBpbml0aWFsaXplcyBpb3RsYl9nYXRoZXIgKHRoZW4gaW90bGJfZ2F0aGVyLT5wZ3NpemUg
Cj4gPSAwKS4KPiBJZiB0aGUgdW5tYXAgc2l6ZSA9IEFSTV9MUEFFX0JMT0NLX1NJWkUobHZsKSAm
JiBpb3B0ZV9sZWFmKCksIGl0IHdpbGwgCj4gZmlsbCB0aGUgaW90bGJfZ2F0aGVyIChzZXQgaW90
bGJfZ2F0aGVyLT5wZ3NpemUgPSBncmFudWxlKTsKPiBidXQgaWYgdGhlIHVubWFwIHNpemUgPSBB
Uk1fTFBBRV9CTE9DS19TSVpFKGx2bCkgJiYgIWlvcHRlX2xlYWYoKSAodGxiIAo+IGZsdXNoIHdh
bGsgc2l0dWF0aW9uKSwgaW90bGJfZ2F0aGVyIGlzIG5vdCBmaWxsZWQgKGlvdGxiX2dhdGhlci0+
cGdzaXplIAo+ID0gMCksCj4gaXQgd2lsbCBzdGlsbCBzZW5kIGlvbW11X2lvdGxiX3N5bmMoZG9t
YWluLCAmaW90bGJfZ2F0aGVyKSB3aGljaCBpcyAKPiBhY3R1YWxseSBpbnZhbGlkIGlvdGxiIHN5
bmMgYXQgbGFzdC4KCkkgZ3Vlc3MgdGhpcyBjYW4gaGFwcGVuIGluIERNQSBBUEkgdXNhZ2UgaWYg
d2UndmUgcHJldmlvdXNseSBtYXBwZWQgYSAKYmxvY2sncyB3b3J0aCBvZiBzY2F0dGVybGlzdCBw
YWdlcyBpbnRvIGEgYmxvY2stPXNpemVkIElPVkEgcmVnaW9uLCBidXQgCnRoaXMgaXMgbm90IHRo
ZSBwbGFjZSB0byBkbyBhbnl0aGluZyBhYm91dCBpdC4gVGhlIG1haW4gdGhpbmcgdGhpcyBwYXRj
aCAKd2lsbCBkbyBpcyBicmVhayBhbGwgdGhlIG90aGVyIGRyaXZlcnMgdGhhdCBpbXBsZW1lbnQg
LmlvdGxiX3N5bmMgYnV0IGRvIApub3QgdXNlIGlvdGxiX2dhdGhlci4KCkJ5IGFsbCBtZWFucyBv
cHRpbWlzZSBTTU1VdjMncyBzeW5jIGJlaGF2aW91ciwgYnV0IHRoZSBvbmx5IHZhbGlkIHBsYWNl
IAp0byBkbyB0aGF0IGlzIGluIFNNTVV2MydzIG93biBzeW5jIGNhbGxiYWNrLiBUaGVzZSBwYXJ0
aWN1bGFyIGRldGFpbHMgCmFyZSBiZXlvbmQgd2hhdCB0aGUgSU9NTVUgY29yZSBrbm93cyBhYm91
dC4KClJvYmluLgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
Xwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0
cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
