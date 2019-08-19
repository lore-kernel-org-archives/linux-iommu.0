Return-Path: <SRS0=RhgY=WP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74D7CC3A5A0
	for <iommu@archiver.kernel.org>; Mon, 19 Aug 2019 19:02:35 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46732214DA
	for <iommu@archiver.kernel.org>; Mon, 19 Aug 2019 19:02:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46732214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id E7C38E1E;
	Mon, 19 Aug 2019 19:02:34 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 35DC2DAF
	for <iommu@lists.linux-foundation.org>;
	Mon, 19 Aug 2019 19:02:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id CBD178A0
	for <iommu@lists.linux-foundation.org>;
	Mon, 19 Aug 2019 19:02:32 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4FBAE360;
	Mon, 19 Aug 2019 12:02:32 -0700 (PDT)
Received: from [10.1.197.57] (e110467-lin.cambridge.arm.com [10.1.197.57])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9B3DB3F246;
	Mon, 19 Aug 2019 12:02:31 -0700 (PDT)
Subject: Re: Build regression in Linux 5.3-rc5 with CONFIG_XEN=y
To: Stefan Wahren <wahrenst@gmx.net>, Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>
References: <ebd95b7c-d265-cbf1-be50-945db1dd06ad@gmx.net>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <825549ed-8aa4-b418-8812-15a9d3cc153e@arm.com>
Date: Mon, 19 Aug 2019 20:02:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <ebd95b7c-d265-cbf1-be50-945db1dd06ad@gmx.net>
Content-Language: en-GB
Cc: iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

T24gMTkvMDgvMjAxOSAxOTozNywgU3RlZmFuIFdhaHJlbiB3cm90ZToKPiBIaSwKPiAKPiBpIHRy
aWVkIHRvIGNyb3NzIGNvbXBpbGUgYXJtL211bHRpX3Y3X2RlZmNvbmZpZyB3aXRoIENPTkZJR19Y
RU49eSB3aXRoCj4gTGludXggNS4zLXJjNSBhbmQgaSdtIGdldHRpbmcgdGhpczoKPiAKPiBhcmNo
L2FybS9tbS9kbWEtbWFwcGluZy5jOiBJbiBmdW5jdGlvbiDigJhhcmNoX3NldHVwX2RtYV9vcHPi
gJk6Cj4gYXJjaC9hcm0vbW0vZG1hLW1hcHBpbmcuYzoyMzQ3OjU6IGVycm9yOiDigJhzdHJ1Y3Qg
ZGV2aWNl4oCZIGhhcyBubyBtZW1iZXIKPiBuYW1lZCDigJhkbWFfY29oZXJlbnTigJkKPiAgwqAg
ZGV2LT5kbWFfY29oZXJlbnQgPSBjb2hlcmVudDsKPiAgwqDCoMKgwqAgXn4KPiBhcmNoL2FybS9t
bS9kbWEtbWFwcGluZy5jOiBBdCB0b3AgbGV2ZWw6Cj4gYXJjaC9hcm0vbW0vZG1hLW1hcHBpbmcu
YzoyMzg1OjY6IGVycm9yOiByZWRlZmluaXRpb24gb2YKPiDigJhhcmNoX3N5bmNfZG1hX2Zvcl9k
ZXZpY2XigJkKPiAgwqB2b2lkIGFyY2hfc3luY19kbWFfZm9yX2RldmljZShzdHJ1Y3QgZGV2aWNl
ICpkZXYsIHBoeXNfYWRkcl90IHBhZGRyLAo+ICDCoMKgwqDCoMKgIF5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fgo+IEluIGZpbGUgaW5jbHVkZWQgZnJvbSBhcmNoL2FybS9tbS9kbWEtbWFwcGluZy5j
OjE4OjA6Cj4gLi9pbmNsdWRlL2xpbnV4L2RtYS1ub25jb2hlcmVudC5oOjY3OjIwOiBub3RlOiBw
cmV2aW91cyBkZWZpbml0aW9uIG9mCj4g4oCYYXJjaF9zeW5jX2RtYV9mb3JfZGV2aWNl4oCZIHdh
cyBoZXJlCj4gIMKgc3RhdGljIGlubGluZSB2b2lkIGFyY2hfc3luY19kbWFfZm9yX2RldmljZShz
dHJ1Y3QgZGV2aWNlICpkZXYsCj4gIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIF5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fgo+IGFyY2gvYXJtL21tL2RtYS1tYXBwaW5nLmM6
MjM5Mjo2OiBlcnJvcjogcmVkZWZpbml0aW9uIG9mCj4g4oCYYXJjaF9zeW5jX2RtYV9mb3JfY3B1
4oCZCj4gIMKgdm9pZCBhcmNoX3N5bmNfZG1hX2Zvcl9jcHUoc3RydWN0IGRldmljZSAqZGV2LCBw
aHlzX2FkZHJfdCBwYWRkciwKPiAgwqDCoMKgwqDCoCBefn5+fn5+fn5+fn5+fn5+fn5+fn4KPiBJ
biBmaWxlIGluY2x1ZGVkIGZyb20gYXJjaC9hcm0vbW0vZG1hLW1hcHBpbmcuYzoxODowOgo+IC4v
aW5jbHVkZS9saW51eC9kbWEtbm9uY29oZXJlbnQuaDo3NzoyMDogbm90ZTogcHJldmlvdXMgZGVm
aW5pdGlvbiBvZgo+IOKAmGFyY2hfc3luY19kbWFfZm9yX2NwdeKAmSB3YXMgaGVyZQo+ICDCoHN0
YXRpYyBpbmxpbmUgdm9pZCBhcmNoX3N5bmNfZG1hX2Zvcl9jcHUoc3RydWN0IGRldmljZSAqZGV2
LAo+ICDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBefn5+fn5+fn5+fn5+
fn5+fn5+fn4KPiBJbiBmaWxlIGluY2x1ZGVkIGZyb20gLi9hcmNoL2FybS9pbmNsdWRlL2FzbS9w
YWdlLmg6MTQ5OjAsCj4gIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGZyb20gLi9h
cmNoL2FybS9pbmNsdWRlL2FzbS90aHJlYWRfaW5mby5oOjE0LAo+ICDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBmcm9tIC4vaW5jbHVkZS9saW51eC90aHJlYWRfaW5mby5oOjM4LAo+
ICDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBmcm9tIC4vaW5jbHVkZS9hc20tZ2Vu
ZXJpYy9wcmVlbXB0Lmg6NSwKPiAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZnJv
bSAuL2FyY2gvYXJtL2luY2x1ZGUvZ2VuZXJhdGVkL2FzbS9wcmVlbXB0Lmg6MSwKPiAgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZnJvbSAuL2luY2x1ZGUvbGludXgvcHJlZW1wdC5o
Ojc4LAo+ICDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBmcm9tIC4vaW5jbHVkZS9s
aW51eC9zcGlubG9jay5oOjUxLAo+ICDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBm
cm9tIC4vaW5jbHVkZS9saW51eC9zZXFsb2NrLmg6MzYsCj4gIMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIGZyb20gLi9pbmNsdWRlL2xpbnV4L3RpbWUuaDo2LAo+ICDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBmcm9tIC4vaW5jbHVkZS9saW51eC9zdGF0Lmg6MTksCj4g
IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGZyb20gLi9pbmNsdWRlL2xpbnV4L21v
ZHVsZS5oOjEwLAo+ICDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBmcm9tIGFyY2gv
YXJtL21tL2RtYS1tYXBwaW5nLmM6OToKPiAKPiBUaGVyZSBpcyBubyBidWlsZCBpc3N1ZSB3aXRo
IExpbnV4IDUuMiwgc28gdGhpcyBtdXN0IGJlIGludHJvZHVjZWQgd2l0aAo+IDUuMy1yYy4gSSBo
b3BlIHlvdSBoYXZlIGEgY2x1ZSB3aXRob3V0IGJpc2VjdGluZyB0aGlzLgoKT2gsIHRoYXQgbXVz
dCBiZSBhZDNjN2IxOGM1Yiwgc2luY2UgdGhlIGRtYS1ub25jb2hlcmVudCBzdHVmZiBpcyBvbmx5
IApzZWxlY3RlZCBieSBDT05GSUdfQVJNX0xQQUUsIGJ1dCB0aGUgcmVmZXJlbmNlcyB0byBpdCBh
cmUgZ3VhcmRlZCBieSAKQ09ORklHX1NXSU9UTEIsIGFuZCBDT05GSUdfWEVOIGJyaW5ncyBpbiB0
aGUgbGF0dGVyIHdpdGhvdXQgdGhlIGZvcm1lci4KClJvYmluLgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlz
dHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3Jn
L21haWxtYW4vbGlzdGluZm8vaW9tbXU=
