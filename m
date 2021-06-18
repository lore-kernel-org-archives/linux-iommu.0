Return-Path: <SRS0=sMz+=LM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40CECC48BDF
	for <iommu@archiver.kernel.org>; Fri, 18 Jun 2021 07:49:57 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A64DA61209
	for <iommu@archiver.kernel.org>; Fri, 18 Jun 2021 07:49:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A64DA61209
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 66F0340309;
	Fri, 18 Jun 2021 07:49:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bhBS4xhJrvz8; Fri, 18 Jun 2021 07:49:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 25BB140326;
	Fri, 18 Jun 2021 07:49:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CD584C000D;
	Fri, 18 Jun 2021 07:49:54 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DD3FAC000B
 for <iommu@lists.linux-foundation.org>; Fri, 18 Jun 2021 07:49:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C2FC4605F6
 for <iommu@lists.linux-foundation.org>; Fri, 18 Jun 2021 07:49:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Xam1UVa37pWb for <iommu@lists.linux-foundation.org>;
 Fri, 18 Jun 2021 07:49:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6901860011
 for <iommu@lists.linux-foundation.org>; Fri, 18 Jun 2021 07:49:51 +0000 (UTC)
Received: from fraeml742-chm.china.huawei.com (unknown [172.18.147.207])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4G5rMm1F1mz6G9tV;
 Fri, 18 Jun 2021 15:36:36 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml742-chm.china.huawei.com (10.206.15.223) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 18 Jun 2021 09:49:48 +0200
Received: from [10.47.95.81] (10.47.95.81) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Fri, 18 Jun
 2021 08:49:47 +0100
Subject: Re: [PATCH v13 1/6] iommu: Deprecate Intel and AMD cmdline methods to
 enable strict mode
To: Robin Murphy <robin.murphy@arm.com>, <joro@8bytes.org>, <will@kernel.org>, 
 <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>, <corbet@lwn.net>
References: <1623841437-211832-1-git-send-email-john.garry@huawei.com>
 <1623841437-211832-2-git-send-email-john.garry@huawei.com>
 <f95252ce-f834-103b-f96d-7e35fa59d5ec@arm.com>
From: John Garry <john.garry@huawei.com>
Message-ID: <c8ca952e-4070-0a48-0a77-1cdf6985bb19@huawei.com>
Date: Fri, 18 Jun 2021 08:43:32 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <f95252ce-f834-103b-f96d-7e35fa59d5ec@arm.com>
Content-Language: en-US
X-Originating-IP: [10.47.95.81]
X-ClientProxiedBy: lhreml743-chm.china.huawei.com (10.201.108.193) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxarm@huawei.com, iommu@lists.linux-foundation.org
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

T24gMTcvMDYvMjAyMSAyMDowMSwgUm9iaW4gTXVycGh5IHdyb3RlOgo+PiDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBETUEuCj4+IC3CoMKgwqDCoMKgwqDCoCBzdHJpY3QgW0RlZmF1bHQgT2Zm
XQo+PiArwqDCoMKgwqDCoMKgwqAgc3RyaWN0IFtEZWZhdWx0IE9mZl0gW0RlcHJlY2F0ZWQsIHVz
ZSBpb21tdS5zdHJpY3QgaW5zdGVhZF0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgV2l0
aCB0aGlzIG9wdGlvbiBvbiBldmVyeSB1bm1hcF9zaW5nbGUgb3BlcmF0aW9uIHdpbGwKPj4gwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmVzdWx0IGluIGEgaGFyZHdhcmUgSU9UTEIgZmx1c2gg
b3BlcmF0aW9uIGFzIG9wcG9zZWQKPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdG8gYmF0
Y2hpbmcgdGhlbSBmb3IgcGVyZm9ybWFuY2UuCj4gCj4gRldJVyBJJ2QgYmUgaW5jbGluZWQgdG8g
cmVwbGFjZSBib3RoIHdob2xlIGRlc2NyaXB0aW9ucyB3aXRoIGp1c3QgCj4gc29tZXRoaW5nIGxp
a2UgIkRlcHJlY2F0ZWQsIGVxdWl2YWxlbnQgdG8gaW9tbXUuc3RyaWN0PTEiLgo+IAo+PiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9pb21tdS9hbWQvaW5pdC5jIGIvZHJpdmVycy9pb21tdS9hbWQvaW5p
dC5jCj4+IGluZGV4IDQ2MjgwZTZlMTUzNS4uOWYzMDk2ZDY1MGFhIDEwMDY0NAo+PiAtLS0gYS9k
cml2ZXJzL2lvbW11L2FtZC9pbml0LmMKPj4gKysrIGIvZHJpdmVycy9pb21tdS9hbWQvaW5pdC5j
Cj4+IEBAIC0zMDk4LDggKzMwOTgsMTAgQEAgc3RhdGljIGludCBfX2luaXQgcGFyc2VfYW1kX2lv
bW11X2ludHIoY2hhciAqc3RyKQo+PiDCoCBzdGF0aWMgaW50IF9faW5pdCBwYXJzZV9hbWRfaW9t
bXVfb3B0aW9ucyhjaGFyICpzdHIpCj4+IMKgIHsKPj4gwqDCoMKgwqDCoCBmb3IgKDsgKnN0cjsg
KytzdHIpIHsKPj4gLcKgwqDCoMKgwqDCoMKgIGlmIChzdHJuY21wKHN0ciwgImZ1bGxmbHVzaCIs
IDkpID09IDApCj4+ICvCoMKgwqDCoMKgwqDCoCBpZiAoc3RybmNtcChzdHIsICJmdWxsZmx1c2gi
LCA5KSA9PSAwKSB7Cj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHByX3dhcm4oImFtZF9pb21t
dT1mdWxsZmx1c2ggZGVwcmVjYXRlZDsgdXNlIGlvbW11LnN0cmljdCAKPj4gaW5zdGVhZFxuIik7
Cj4gCj4gTml0OiBtYXliZSB3ZSBzaG91bGQgc3BlbGwgb3V0ICIuLi51c2UgPG9wdGlvbj49MSBp
bnN0ZWFkIiBpbiBhbGwgb2YgCj4gdGhlc2UgbWVzc2FnZXMganVzdCBpbiBjYXNlIGFueW9uZSB0
YWtlcyB0aGVtIGxpdGVyYWxseT8KCgo+IChJJ20gbm90IHN1cmUgCj4gdGhlIG9wdGlvbnMgcGFy
c2UgY29ycmVjdGx5IHdpdGggbm8gYXJndW1lbnQpCgpJIGRvbid0IHRoaW5rIHRoZXkgZG8uCgpC
dXQgSSdsbCB0YWtlIGJvdGggc3VnZ2VzdGlvbnMgb24gYm9hcmQuCgo+IAo+IEVpdGhlciB3YXks
Cj4gCj4gQWNrZWQtYnk6IFJvYmluIE11cnBoeSA8cm9iaW4ubXVycGh5QGFybS5jb20+CgpDaGVl
cnMhCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21t
dSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9s
aXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
