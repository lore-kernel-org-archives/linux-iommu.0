Return-Path: <SRS0=UfkB=G5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D14DC433DB
	for <iommu@archiver.kernel.org>; Tue, 26 Jan 2021 17:24:59 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D85B120829
	for <iommu@archiver.kernel.org>; Tue, 26 Jan 2021 17:24:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D85B120829
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 3FDB82047F;
	Tue, 26 Jan 2021 17:24:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qEYkXm-gxYud; Tue, 26 Jan 2021 17:24:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 75D5E2034F;
	Tue, 26 Jan 2021 17:24:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 68273C08A1;
	Tue, 26 Jan 2021 17:24:56 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F344EC013A
 for <iommu@lists.linux-foundation.org>; Tue, 26 Jan 2021 17:24:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id E2B6384D62
 for <iommu@lists.linux-foundation.org>; Tue, 26 Jan 2021 17:24:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RPwoynfr3VDw for <iommu@lists.linux-foundation.org>;
 Tue, 26 Jan 2021 17:24:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 4DC7C84CEB
 for <iommu@lists.linux-foundation.org>; Tue, 26 Jan 2021 17:24:53 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 53A0331B;
 Tue, 26 Jan 2021 09:24:52 -0800 (PST)
Received: from [10.57.43.46] (unknown [10.57.43.46])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 207543F66E;
 Tue, 26 Jan 2021 09:24:51 -0800 (PST)
Subject: Re: [PATCH] iommu: Check dev->iommu in iommu_dev_xxx functions
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
References: <20210126130629.8928-1-shameerali.kolothum.thodi@huawei.com>
 <20210126135039.000039a0@arm.com>
 <8654e506fa26443f8f4413ec8fd96bf7@huawei.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <5828b2f9-e1d3-fd96-ebf3-2a38c903c9c3@arm.com>
Date: Tue, 26 Jan 2021 17:24:45 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <8654e506fa26443f8f4413ec8fd96bf7@huawei.com>
Content-Language: en-GB
Cc: "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linuxarm@openeuler.org" <linuxarm@openeuler.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "Zengtao \(B\)" <prime.zeng@hisilicon.com>,
 "will@kernel.org" <will@kernel.org>
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

T24gMjAyMS0wMS0yNiAxNjo0MCwgU2hhbWVlcmFsaSBLb2xvdGh1bSBUaG9kaSB3cm90ZToKPiBI
aSBSb2JpbiwKPiAKPj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0KPj4gRnJvbTogUm9iaW4g
TXVycGh5IFttYWlsdG86cm9iaW4ubXVycGh5QGFybS5jb21dCj4+IFNlbnQ6IDI2IEphbnVhcnkg
MjAyMSAxMzo1MQo+PiBUbzogU2hhbWVlcmFsaSBLb2xvdGh1bSBUaG9kaSA8c2hhbWVlcmFsaS5r
b2xvdGh1bS50aG9kaUBodWF3ZWkuY29tPgo+PiBDYzogbGludXgta2VybmVsQHZnZXIua2VybmVs
Lm9yZzsgaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmc7Cj4+IGplYW4tcGhpbGlwcGVA
bGluYXJvLm9yZzsgd2lsbEBrZXJuZWwub3JnOyBsaW51eGFybUBvcGVuZXVsZXIub3JnOyBaZW5n
dGFvCj4+IChCKSA8cHJpbWUuemVuZ0BoaXNpbGljb24uY29tPgo+PiBTdWJqZWN0OiBSZTogW1BB
VENIXSBpb21tdTogQ2hlY2sgZGV2LT5pb21tdSBpbiBpb21tdV9kZXZfeHh4IGZ1bmN0aW9ucwo+
Pgo+PiBPbiBUdWUsIDI2IEphbiAyMDIxIDEzOjA2OjI5ICswMDAwCj4+IFNoYW1lZXIgS29sb3Ro
dW0gPHNoYW1lZXJhbGkua29sb3RodW0udGhvZGlAaHVhd2VpLmNvbT4gd3JvdGU6Cj4+Cj4+PiBU
aGUgZGV2aWNlIGlvbW11IHByb2JlL2F0dGFjaCBtaWdodCBoYXZlIGZhaWxlZCBsZWF2aW5nIGRl
di0+aW9tbXUgdG8KPj4+IE5VTEwgYW5kIGRldmljZSBkcml2ZXJzIG1heSBzdGlsbCBpbnZva2Ug
dGhlc2UgZnVuY3Rpb25zwqByZXN1bHRpbmcgYQo+Pj4gY3Jhc2ggaW4gaW9tbXUgdmVuZG9yIGRy
aXZlciBjb2RlLiBIZW5jZSBtYWtlwqBzdXJlIHdlIGNoZWNrIHRoYXQuCj4+Pgo+Pj4gU2lnbmVk
LW9mZi1ieTogU2hhbWVlciBLb2xvdGh1bSA8c2hhbWVlcmFsaS5rb2xvdGh1bS50aG9kaUBodWF3
ZWkuY29tPgo+Pj4gLS0tCj4+PiAgIGRyaXZlcnMvaW9tbXUvaW9tbXUuYyB8IDggKysrKy0tLS0K
Pj4+ICAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkKPj4+
Cj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pb21tdS9pb21tdS5jIGIvZHJpdmVycy9pb21tdS9p
b21tdS5jIGluZGV4Cj4+PiBmZmVlYmRhOGQ2ZGUuLmNiNjgxNTNjNWNjMCAxMDA2NDQKPj4+IC0t
LSBhL2RyaXZlcnMvaW9tbXUvaW9tbXUuYwo+Pj4gKysrIGIvZHJpdmVycy9pb21tdS9pb21tdS5j
Cj4+PiBAQCAtMjg2Nyw3ICsyODY3LDcgQEAgYm9vbCBpb21tdV9kZXZfaGFzX2ZlYXR1cmUoc3Ry
dWN0IGRldmljZSAqZGV2LAo+Pj4gZW51bSBpb21tdV9kZXZfZmVhdHVyZXMgZmVhdCkgewo+Pj4g
ICAJY29uc3Qgc3RydWN0IGlvbW11X29wcyAqb3BzID0gZGV2LT5idXMtPmlvbW11X29wczsKPj4+
Cj4+PiAtCWlmIChvcHMgJiYgb3BzLT5kZXZfaGFzX2ZlYXQpCj4+PiArCWlmIChkZXYtPmlvbW11
ICYmIG9wcyAmJiBvcHMtPmRldl9oYXNfZmVhdCkKPj4+ICAgCQlyZXR1cm4gb3BzLT5kZXZfaGFz
X2ZlYXQoZGV2LCBmZWF0KTsKPj4KPj4gTWlnaHQgbWFrZSBzZW5zZSB0byBtYWtlIHRoZXNlIG1v
cmUgc2VsZi1jb250YWluZWQsIGUuZy46Cj4+Cj4+IAlpZiAoZGV2LT5pb21tdSAmJiBkZXYtPmlv
bW11LT5vcHMtPmZvbykKPj4gCQlkZXYtPmlvbW11LT5vcHMtPmZvbygpCj4gCj4gUmlnaHQuIERv
ZXMgdGhhdCBtZWFuIGFkZGluZyBvcHMgdG8gInN0cnVjdCBkZXZfaW9tbXUiIG9yIHJldHJpZXZl
IG9wcyBsaWtlCj4gYmVsb3csCj4gCj4gaWYgKGRldi0+aW9tbXUgJiYgZGV2LT5pb21tdS0+aW9t
bXVfZGV2LT5vcHMtPmZvbykKPiAgIAkJZGV2LT5pb21tdS0+aW9tbXVfZGV2LT5vcHMtPmZvbygp
Cj4gICAKPiBTb3JyeSwgbm90IGNsZWFyIHRvIG1lLgoKQmxlaCwgSSB3YXMgdGhpbmtpbmcgdGhh
dCBkZXYtPmlvbW11IHBvaW50ZWQgZGlyZWN0bHkgdG8gYSBzdHJ1Y3QgCmlvbW11X2RldmljZSB0
aGVyZSwgc29ycnkuIFRoZXJlIGFyZSB0b28gbWFueSB0aGluZ3MgYW5kIG5vdCBlbm91Z2ggCmRp
c3RpbmN0IG5hbWVzIGZvciB0aGUgdGhpbmdzLgoKQnV0IHllYWgsIGJhc2ljYWxseSB0aGF0IGlm
IHRoZSBkZXZpY2UncyAiSSBhbSBhc3NvY2lhdGVkIHdpdGggYW4gSU9NTVUiIApkYXRhIGlzIHNl
dCwgdGhlbiBieSBjb25zdHJ1Y3Rpb24gaXQgbXVzdCBsZWFkIHRvIGEgc2V0IG9mIG9wcyB3aGlj
aCBhcmUgCmRlZmluaXRlbHkgdmFsaWQuIENvbmNlcHR1YWxseSBpdCdzIGNsZWFuZXIgdGhhbiBj
b21iaW5pbmcgdHdvIGRpZmZlcmVudCAKZGF0YSBzb3VyY2VzICh0aGUgcGVyLWRldmljZSBpbmZv
IHBsdXMgdGhlIGJ1cyBvcHMgd2hpY2ggbWF5IG9yIG1heSBub3QgCmJlIHJlbGV2YW50IHRvIGEg
Z2l2ZW4gZGV2aWNlKSwgZXZlbiBpZiBjb3NtZXRpY2FsbHkgd2UgaGF2ZSB0byBqdWdnbGUgCnRo
cm91Z2ggcHJhY3RpY2FsbHkgZXZlcnkgcG9zc2libGUgcGVybXV0YXRpb24gb2YgdGhlIG5hbWVz
ICJpb21tdSIgYW5kIAoiZGV2aWNlIiB0byBnZXQgdGhlcmUgOi8KClJvYmluLgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QK
aW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5k
YXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
