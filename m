Return-Path: <SRS0=whWg=N5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C62F5C433F5
	for <iommu@archiver.kernel.org>; Tue,  7 Sep 2021 07:42:13 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53D91610A3
	for <iommu@archiver.kernel.org>; Tue,  7 Sep 2021 07:42:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 53D91610A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 141AA60BCF;
	Tue,  7 Sep 2021 07:42:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8RzzPiJOURFV; Tue,  7 Sep 2021 07:42:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id DA91D60BBE;
	Tue,  7 Sep 2021 07:42:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AEC28C001D;
	Tue,  7 Sep 2021 07:42:11 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2B9A9C000D
 for <iommu@lists.linux-foundation.org>; Tue,  7 Sep 2021 07:42:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1BA9940611
 for <iommu@lists.linux-foundation.org>; Tue,  7 Sep 2021 07:42:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Xe5glofLgQlj for <iommu@lists.linux-foundation.org>;
 Tue,  7 Sep 2021 07:42:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E7D2B405DC
 for <iommu@lists.linux-foundation.org>; Tue,  7 Sep 2021 07:42:08 +0000 (UTC)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.53])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4H3cdk19QvzVqZY;
 Tue,  7 Sep 2021 15:41:14 +0800 (CST)
Received: from dggema765-chm.china.huawei.com (10.1.198.207) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.8; Tue, 7 Sep 2021 15:42:04 +0800
Received: from [10.174.185.210] (10.174.185.210) by
 dggema765-chm.china.huawei.com (10.1.198.207) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.8; Tue, 7 Sep 2021 15:42:03 +0800
From: Kunkun Jiang <jiangkunkun@huawei.com>
Subject: [question] Assign multiple devices from different SMMUs to a
 arm_smmu_domain
To: Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>, "Linux
 IOMMU" <iommu@lists.linux-foundation.org>, open list
 <linux-kernel@vger.kernel.org>
Message-ID: <bbfcb875-0da1-c303-ed48-fdaa890c89b3@huawei.com>
Date: Tue, 7 Sep 2021 15:41:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
Content-Language: en-US
X-Originating-IP: [10.174.185.210]
X-ClientProxiedBy: dggeme701-chm.china.huawei.com (10.1.199.97) To
 dggema765-chm.china.huawei.com (10.1.198.207)
X-CFilter-Loop: Reflected
Cc: wanghaibin.wang@huawei.com
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

SGkgYWxsLAoKSSBhbSB3b3JraW5nIG9uIFZGSU8gRE1BIGRpcnR5IHBhZ2VzIHRyYWNraW5nIGJh
c2VkIG9uIEFSTSBTTU1VIEhUVFUsCmFuZCBoYXZlIGRvbmUgYSBsb3Qgb2YgdGVzdGluZy5JbiB0
aGUgdGVzdCwgSSBmb3VuZCBhIHByb2JsZW0gdGhhdCAKZ3JlYXRseSBhZmZlY3RzCnBlcmZvcm1h
bmNlIG9mIFZGSU8gRE1BIGRpcnR5IHBhZ2VzIHRyYWNraW5nLgoKQWNjb3JkaW5nIHRvIHRoZSBj
dXJyZW50IGFybS1zbW11LXYzIGRyaXZlciwgbXVsdGlwbGUgVkZJTyBwYXNzLXRocm91Z2gKZGV2
aWNlIGNvbWVzIGZyb20gZGlmZmVyZW50IFNNTVVzIHdpbGwgYmUgYXNzaWduZWQgdG8gZGlmZmVy
ZW50CmFybV9zbW11X2RvbWFpbi4gSXQgd2lsbCBjcmVhdGUgcGFnZSB0YWJsZSBmb3IgZWFjaCBh
cm1fc21tdV9kb21haW4sCmV2ZW4gdGhvdWdoIHRoZXNlIHBhZ2UgdGFibGVzIGFyZSBleGFjdGx5
IHRoZSBzYW1lLiBCYWNhdXNlIGRpcnR5IHBhZ2VzCnRyYWNraW5nIG5lZWRzIHRvIHRyYXZlcnNl
IHRoZSBwYWdlIHRhYmxlLCBtdWx0aXBsZSBwYWdlIHRhYmxlcyB3aWxsIG1ha2UKcGVyZm9ybWFu
Y2Ugd29yc2UuCgpJIGxlYXJuZWQgdGhlIEFSTSBTTU1VdjMgc3BlYyBhbmQgaGFkIHNvbWUgZXhj
aGFuZ2VzIHdpdGggbXkgY29sbGVhZ3Vlcwp3aG8gd29yayBvbiBTTU1VIGhhcmR3YXJlLiBJIGRp
ZCBub3QgZmluZCB0aGUgcmVzdHJpY3Rpb24gdGhhdCBtdWx0aXBsZQpTTU1VcyBjYW5ub3Qgc2hh
cmUgdGhlIHNhbWUgcGFnZSB0YWJsZS4gV2UgbWlndGggYmUgYWJsZSB0byBkbyB0aGlzIGxpa2UK
eDg2IElPTU1VLiBJZiBJIGhhdmUgbWlzc2VkIHNvbWV0aGluZywgcGxlYXNlIHBvaW50IGl0IG91
dC4KCkxvb2tpbmcgZm9yd2FyZCB0byB5b3VyIHN1Z2dlc3Rpb25zLvCfmIEKClRoYW5rcywKS3Vu
a3VuIEppYW5nCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
Xwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0
cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
