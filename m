Return-Path: <SRS0=+AsR=M4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URIBL_RED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2D17C4338F
	for <iommu@archiver.kernel.org>; Thu,  5 Aug 2021 08:09:37 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70BA961040
	for <iommu@archiver.kernel.org>; Thu,  5 Aug 2021 08:09:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 70BA961040
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 49A1840259;
	Thu,  5 Aug 2021 08:09:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KneUM8s0Zuqk; Thu,  5 Aug 2021 08:09:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id C583B4026A;
	Thu,  5 Aug 2021 08:09:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9D825C001A;
	Thu,  5 Aug 2021 08:09:35 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5169BC000E
 for <iommu@lists.linux-foundation.org>; Thu,  5 Aug 2021 08:09:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3F0A540259
 for <iommu@lists.linux-foundation.org>; Thu,  5 Aug 2021 08:09:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pL-HO6OyZDy7 for <iommu@lists.linux-foundation.org>;
 Thu,  5 Aug 2021 08:09:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 35AF3402AE
 for <iommu@lists.linux-foundation.org>; Thu,  5 Aug 2021 08:09:33 +0000 (UTC)
Received: from fraeml736-chm.china.huawei.com (unknown [172.18.147.201])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GgLqG2lZkz6F8Fl;
 Thu,  5 Aug 2021 16:09:14 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml736-chm.china.huawei.com (10.206.15.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 5 Aug 2021 10:09:31 +0200
Received: from A2006125610.china.huawei.com (10.47.91.4) by
 lhreml710-chm.china.huawei.com (10.201.108.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 5 Aug 2021 09:09:24 +0100
From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
To: <linux-arm-kernel@lists.infradead.org>, <linux-acpi@vger.kernel.org>,
 <iommu@lists.linux-foundation.org>
Subject: [PATCH v7 6/9] =?UTF-8?q?iommu/arm-smmu-v3:=20Refactor=C2=A0arm?=
 =?UTF-8?q?=5Fsmmu=5Finit=5Fbypass=5Fstes()=20to=20force=20bypass?=
Date: Thu, 5 Aug 2021 09:07:21 +0100
Message-ID: <20210805080724.480-7-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
In-Reply-To: <20210805080724.480-1-shameerali.kolothum.thodi@huawei.com>
References: <20210805080724.480-1-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.47.91.4]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Cc: robin.murphy@arm.com, jon@solid-run.com, linuxarm@huawei.com,
 steven.price@arm.com, guohanjun@huawei.com, yangyicong@huawei.com,
 Sami.Mujawar@arm.com, will@kernel.org, wanghuiqiang@huawei.com
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

QnkgZGVmYXVsdCzCoGRpc2FibGVfYnlwYXNzIGZsYWcgaXMgc2V0IGFuZCBhbnkgZGV2IHdpdGhv
dXQKYW4gaW9tbXUgZG9tYWluIGluc3RhbGxzwqBTVEUgd2l0aCBDRkdfQUJPUlQgZHVyaW5nCmFy
bV9zbW11X2luaXRfYnlwYXNzX3N0ZXMoKS4gSW50cm9kdWNlIGEgImZvcmNlIiBmbGFnIGFuZApt
b3ZlIHRoZSBTVEUgdXBkYXRlIGxvZ2ljIHRvwqBhcm1fc21tdV9pbml0X2J5cGFzc19zdGVzKCkK
c28gdGhhdCB3ZSBjYW4gZm9yY2UgaXQgdG8gaW5zdGFsbMKgQ0ZHX0JZUEFTUyBTVEUgZm9yIHNw
ZWNpZmljClNJRHMuCgpUaGlzIHdpbGwgYmXCoHVzZWZ1bMKgaW4gZm9sbG93LXVwwqBwYXRjaCB0
byBpbnN0YWxsIGJ5cGFzcwpmb3IgSU9SVCBSTVIgU0lEcy4KClNpZ25lZC1vZmYtYnk6IFNoYW1l
ZXIgS29sb3RodW0gPHNoYW1lZXJhbGkua29sb3RodW0udGhvZGlAaHVhd2VpLmNvbT4KLS0tCiBk
cml2ZXJzL2lvbW11L2FybS9hcm0tc21tdS12My9hcm0tc21tdS12My5jIHwgMTcgKysrKysrKysr
KysrKy0tLS0KIDEgZmlsZSBjaGFuZ2VkLCAxMyBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygt
KQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW9tbXUvYXJtL2FybS1zbW11LXYzL2FybS1zbW11LXYz
LmMgYi9kcml2ZXJzL2lvbW11L2FybS9hcm0tc21tdS12My9hcm0tc21tdS12My5jCmluZGV4IDMx
OTQwZTUzYzY3NS4uODVmNmYxOTI1YTM2IDEwMDY0NAotLS0gYS9kcml2ZXJzL2lvbW11L2FybS9h
cm0tc21tdS12My9hcm0tc21tdS12My5jCisrKyBiL2RyaXZlcnMvaW9tbXUvYXJtL2FybS1zbW11
LXYzL2FybS1zbW11LXYzLmMKQEAgLTEzNTcsMTIgKzEzNTcsMjEgQEAgc3RhdGljIHZvaWQgYXJt
X3NtbXVfd3JpdGVfc3RydGFiX2VudChzdHJ1Y3QgYXJtX3NtbXVfbWFzdGVyICptYXN0ZXIsIHUz
MiBzaWQsCiAJCWFybV9zbW11X2NtZHFfaXNzdWVfY21kKHNtbXUsICZwcmVmZXRjaF9jbWQpOwog
fQogCi1zdGF0aWMgdm9pZCBhcm1fc21tdV9pbml0X2J5cGFzc19zdGVzKF9fbGU2NCAqc3RydGFi
LCB1bnNpZ25lZCBpbnQgbmVudCkKK3N0YXRpYyB2b2lkIGFybV9zbW11X2luaXRfYnlwYXNzX3N0
ZXMoX19sZTY0ICpzdHJ0YWIsIHVuc2lnbmVkIGludCBuZW50LCBib29sIGZvcmNlKQogewogCXVu
c2lnbmVkIGludCBpOworCXU2NCB2YWwgPSBTVFJUQUJfU1RFXzBfVjsKKworCWlmIChkaXNhYmxl
X2J5cGFzcyAmJiAhZm9yY2UpCisJCXZhbCB8PSBGSUVMRF9QUkVQKFNUUlRBQl9TVEVfMF9DRkcs
IFNUUlRBQl9TVEVfMF9DRkdfQUJPUlQpOworCWVsc2UKKwkJdmFsIHw9IEZJRUxEX1BSRVAoU1RS
VEFCX1NURV8wX0NGRywgU1RSVEFCX1NURV8wX0NGR19CWVBBU1MpOwogCiAJZm9yIChpID0gMDsg
aSA8IG5lbnQ7ICsraSkgewotCQlhcm1fc21tdV93cml0ZV9zdHJ0YWJfZW50KE5VTEwsIC0xLCBz
dHJ0YWIpOworCQlzdHJ0YWJbMF0gPSBjcHVfdG9fbGU2NCh2YWwpOworCQlzdHJ0YWJbMV0gPSBj
cHVfdG9fbGU2NChGSUVMRF9QUkVQKFNUUlRBQl9TVEVfMV9TSENGRywKKwkJCQkJCSAgIFNUUlRB
Ql9TVEVfMV9TSENGR19JTkNPTUlORykpOworCQlzdHJ0YWJbMl0gPSAwOwogCQlzdHJ0YWIgKz0g
U1RSVEFCX1NURV9EV09SRFM7CiAJfQogfQpAQCAtMTM5MCw3ICsxMzk5LDcgQEAgc3RhdGljIGlu
dCBhcm1fc21tdV9pbml0X2wyX3N0cnRhYihzdHJ1Y3QgYXJtX3NtbXVfZGV2aWNlICpzbW11LCB1
MzIgc2lkKQogCQlyZXR1cm4gLUVOT01FTTsKIAl9CiAKLQlhcm1fc21tdV9pbml0X2J5cGFzc19z
dGVzKGRlc2MtPmwycHRyLCAxIDw8IFNUUlRBQl9TUExJVCk7CisJYXJtX3NtbXVfaW5pdF9ieXBh
c3Nfc3RlcyhkZXNjLT5sMnB0ciwgMSA8PCBTVFJUQUJfU1BMSVQsIGZhbHNlKTsKIAlhcm1fc21t
dV93cml0ZV9zdHJ0YWJfbDFfZGVzYyhzdHJ0YWIsIGRlc2MpOwogCXJldHVybiAwOwogfQpAQCAt
MzA0Miw3ICszMDUxLDcgQEAgc3RhdGljIGludCBhcm1fc21tdV9pbml0X3N0cnRhYl9saW5lYXIo
c3RydWN0IGFybV9zbW11X2RldmljZSAqc21tdSkKIAlyZWcgfD0gRklFTERfUFJFUChTVFJUQUJf
QkFTRV9DRkdfTE9HMlNJWkUsIHNtbXUtPnNpZF9iaXRzKTsKIAljZmctPnN0cnRhYl9iYXNlX2Nm
ZyA9IHJlZzsKIAotCWFybV9zbW11X2luaXRfYnlwYXNzX3N0ZXMoc3RydGFiLCBjZmctPm51bV9s
MV9lbnRzKTsKKwlhcm1fc21tdV9pbml0X2J5cGFzc19zdGVzKHN0cnRhYiwgY2ZnLT5udW1fbDFf
ZW50cywgZmFsc2UpOwogCXJldHVybiAwOwogfQogCi0tIAoyLjE3LjEKCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21t
dUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlv
bi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
