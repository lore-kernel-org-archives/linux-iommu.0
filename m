Return-Path: <SRS0=UGJ5=K3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CE35C47080
	for <iommu@archiver.kernel.org>; Tue,  1 Jun 2021 17:45:00 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9D0D613D2
	for <iommu@archiver.kernel.org>; Tue,  1 Jun 2021 17:44:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9D0D613D2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 85A2840270;
	Tue,  1 Jun 2021 17:44:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BR7WJ5yZgEm9; Tue,  1 Jun 2021 17:44:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8AF13400F4;
	Tue,  1 Jun 2021 17:44:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6D8FDC000E;
	Tue,  1 Jun 2021 17:44:58 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 23437C0001
 for <iommu@lists.linux-foundation.org>; Tue,  1 Jun 2021 17:44:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id F01EC6060D
 for <iommu@lists.linux-foundation.org>; Tue,  1 Jun 2021 17:44:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JnlTh6tUWXtQ for <iommu@lists.linux-foundation.org>;
 Tue,  1 Jun 2021 17:44:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A74D3605E8
 for <iommu@lists.linux-foundation.org>; Tue,  1 Jun 2021 17:44:55 +0000 (UTC)
Received: from fraeml744-chm.china.huawei.com (unknown [172.18.147.200])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4FvfWz0HFmz6P3Ml;
 Wed,  2 Jun 2021 01:38:23 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml744-chm.china.huawei.com (10.206.15.225) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 1 Jun 2021 19:44:52 +0200
Received: from [10.47.91.52] (10.47.91.52) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Tue, 1 Jun 2021
 18:44:51 +0100
Subject: Re: [PATCH] iommu: Print default strict or lazy mode at init time
To: Robin Murphy <robin.murphy@arm.com>, <joro@8bytes.org>, <will@kernel.org>
References: <1622209074-37899-1-git-send-email-john.garry@huawei.com>
 <3ee986a0-29c1-100c-c72f-360f919caf7d@arm.com>
 <e478aea8-54d3-bfc6-1bc8-b0c7709e353a@huawei.com>
 <58ea001c-4c37-9c5a-77be-38ac3bea2476@arm.com>
From: John Garry <john.garry@huawei.com>
Message-ID: <72eb3de9-1d1c-ae46-c5a9-95f26525d435@huawei.com>
Date: Tue, 1 Jun 2021 18:44:00 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <58ea001c-4c37-9c5a-77be-38ac3bea2476@arm.com>
Content-Language: en-US
X-Originating-IP: [10.47.91.52]
X-ClientProxiedBy: lhreml729-chm.china.huawei.com (10.201.108.80) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, hch@lst.de
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

Pj4KPj4gcHJfaW5mbygiRE1BIGRvbWFpbiBkZWZhdWx0IFRMQiBpbnZhbGlkYXRpb24gcG9saWN5
OiAlcyBtb2RlICVzXG4iLAo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlvbW11X2Rt
YV9zdHJpY3QgPyAic3RyaWN0IiA6ICJsYXp5IiwKPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIChpb21tdV9jbWRfbGluZSAmIElPTU1VX0NNRF9MSU5FX1NUUklDVCkgPwo+PiDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICIoc2V0IHZpYSBrZXJu
ZWwgY29tbWFuZCBsaW5lKSIgOiAiIik7Cj4+Cj4+IEkgdGhpbmsgaXQncyB3b3J0aCBtZW50aW9u
aW5nICJkZWZhdWx0IiBzb21ld2hlcmUsIGFzIG5vdCBhbGwgSU9NTVVzIAo+PiBvciBkZXZpY2Vz
IHdpbGwgdXNlIGxhenkgbW9kZSBldmVuIGlmIGl0J3MgZGVmYXVsdC4KPiAKPiBCdXQgdGhhdCdz
IHBhcnQgb2Ygd2hhdCBJIHRoaW5rIGlzIG1pc2xlYWRpbmcgLSBJIGJvb3QgYW5kIHNlZSB0aGF0
IHRoZSAKPiBkZWZhdWx0IGlzIHNvbWV0aGluZywgc28gSSByZWJvb3Qgd2l0aCBpb21tdS5zdHJp
Y3QgdG8gZXhwbGljaXRseSBzZXQgaXQgCj4gdGhlIG90aGVyIHdheSwgYnV0IG5vdyB0aGF0J3Mg
dGhlIGRlZmF1bHQuLi4gaHVoPwo+IAo+IFRoZSB3YXkgSSBzZWUgaXQsIHdlJ3JlIHNheWluZyB3
aGF0IHRoZSBjdXJyZW50IElPTU1VIEFQSSBwb2xpY3kgaXMgLSAKPiB0aGUgdmFsdWUgb2YgaW9t
bXVfZG1hX3N0cmljdCBhdCBhbnkgZ2l2ZW4gdGltZSBpcyBmYWN0IC0gYnV0IHdlJ3JlIG5vdCAK
PiBuZWNlc3NhcmlseSBzYXlpbmcgaG93IHdpZGVseSB0aGF0IHBvbGljeSBpcyBlbmZvcmNlZC4g
V2Ugc2ltaWxhcmx5IAo+IHJlcG9ydCB0aGUgdHlwZSBmb3IgZGVmYXVsdCBkb21haW5zIGZyb20g
Z2xvYmFsIHBvbGljeSBldmVuIHRob3VnaCB0aGF0IAo+IG1heSBhbHNvIGJlIG92ZXJyaWRkZW4g
cGVyLWdyb3VwIGJ5IGRyaXZlcnMgYW5kL29yIHVzZXJzcGFjZSBsYXRlcjsgCgo+IHdlIAo+IGRv
bid0IHNheSBpdCdzIHRoZSAqZGVmYXVsdCogZGVmYXVsdCBkb21haW4gdHlwZS4KCkkgdGhpbmsg
dGhhdCBpcyB0aGlzIGlzIHRoZSBiZWhhdmlvciBhIHVzZXIgd291bGQgdW5kZXJzdGFuZCBmcm9t
IHRoYXQgCm1lc3NhZ2UuCgpIb3dldmVyIGZyb20gYSBnbGFuY2UgYXQgdGhlIGludGVsIElPTU1V
IGRyaXZlciwgaXQgc2VlbXMgcG9zc2libGUgdG8gCmNoYW5nZSBkZWZhdWx0IGRvbWFpbiB0eXBl
IGFmdGVyIGlvbW11X3N1YnN5c19pbml0KCkuCgo+IAo+IEhvd2V2ZXIsIGhhdmluZyBub3cgZGVi
dWdnZWQgdGhlIEFNRCBpc3N1ZSBmcm9tIGFub3RoZXIgdGhyZWFkLCBJIHRoaW5rIAo+IGRvaW5n
IHRoaXMgYXQgc3Vic3lzX2luaXRjYWxsIGlzIGluIGZhY3QgZ29pbmcgdG8gYmUgdG9vIGVhcmx5
IHRvIGJlIAo+IG1lYW5pbmdmdWwsIHNpbmNlIGl0IGlnbm9yZXMgZHJpdmVycycgYWJpbGl0eSB0
byBjaGFuZ2UgdGhlIGdsb2JhbCAKPiBwb2xpY3kgOigKCkEgdXNlciBtYXkgc3RpbGwgbGVhcm4g
dGhlIElPTU1VIGdyb3VwIGRvbWFpbiB0eXBlIGZyb20gc3lzZnMuIFRoZXJlIGlzIApubyBzdWNo
IHRoaW5nIGZvciBUTEIgaW52YWxpZGF0aW9uIG1vZGUgLSBob3cgYWJvdXQgYWRkIGEgZmlsZSBm
b3IgdGhpcz8gCkl0IHdvdWxkIGJlIHVzZWZ1bC4KClRoYW5rcywKSm9obgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9t
bXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRp
b24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
