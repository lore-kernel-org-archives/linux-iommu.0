Return-Path: <SRS0=YXze=KI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B11A7C433B4
	for <iommu@archiver.kernel.org>; Thu, 13 May 2021 13:47:00 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EB0B613BF
	for <iommu@archiver.kernel.org>; Thu, 13 May 2021 13:47:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EB0B613BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DE8B240FAB;
	Thu, 13 May 2021 13:46:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HGCjFmWpgSfR; Thu, 13 May 2021 13:46:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id B60C64044E;
	Thu, 13 May 2021 13:46:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A0AD4C000E;
	Thu, 13 May 2021 13:46:58 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BD26FC0001
 for <iommu@lists.linux-foundation.org>; Thu, 13 May 2021 13:46:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B9BB5403C4
 for <iommu@lists.linux-foundation.org>; Thu, 13 May 2021 13:46:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bsZ8kiUYbpId for <iommu@lists.linux-foundation.org>;
 Thu, 13 May 2021 13:46:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1A974403BA
 for <iommu@lists.linux-foundation.org>; Thu, 13 May 2021 13:46:57 +0000 (UTC)
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
 by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FgtDY1Rg6z16LjG;
 Thu, 13 May 2021 21:44:13 +0800 (CST)
Received: from A2006125610.china.huawei.com (10.47.81.63) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.498.0; Thu, 13 May 2021 21:46:47 +0800
From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
To: <linux-arm-kernel@lists.infradead.org>, <linux-acpi@vger.kernel.org>,
 <iommu@lists.linux-foundation.org>
Subject: [PATCH v4 5/8] =?UTF-8?q?iommu/arm-smmu-v3:=20Add=20bypass=20flag?=
 =?UTF-8?q?=20to=C2=A0arm=5Fsmmu=5Fwrite=5Fstrtab=5Fent()?=
Date: Thu, 13 May 2021 14:45:47 +0100
Message-ID: <20210513134550.2117-6-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
In-Reply-To: <20210513134550.2117-1-shameerali.kolothum.thodi@huawei.com>
References: <20210513134550.2117-1-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.47.81.63]
X-CFilter-Loop: Reflected
Cc: jon@solid-run.com, linuxarm@huawei.com, steven.price@arm.com,
 guohanjun@huawei.com, yangyicong@huawei.com, Sami.Mujawar@arm.com,
 robin.murphy@arm.com, wanghuiqiang@huawei.com
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

QnkgZGVmYXVsdCzCoGRpc2FibGVfYnlwYXNzIGlzIHNldCBhbmQgYW55IGRldiB3aXRob3V0IGFu
IGlvbW11IGRvbWFpbgppbnN0YWxscyBTVEUgd2l0aCBDRkdfQUJPUlQgZHVyaW5nwqBhcm1fc21t
dV9pbml0X2J5cGFzc19zdGVzKCkuIEludHJvZHVjZQphICJieXBhc3MiIGZsYWcgdG/CoGFybV9z
bW11X3dyaXRlX3N0cnRhYl9lbnQoKSBzbyB0aGF0IHdlIGNhbiBmb3JjZSBpdCB0bwppbnN0YWxs
wqBDRkdfQllQQVNTIFNURSBmb3Igc3BlY2lmaWMgU0lEcy4gVGhpcyB3aWxsIGJlwqB1c2VmdWzC
oGluIGZvbGxvdwp1cCBwYXRjaCB0byBpbnN0YWxsIGJ5cGFzcyBmb3IgSU9SVCBSTVIgU0lEcy4K
ClNpZ25lZC1vZmYtYnk6IFNoYW1lZXIgS29sb3RodW0gPHNoYW1lZXJhbGkua29sb3RodW0udGhv
ZGlAaHVhd2VpLmNvbT4KLS0tCiBkcml2ZXJzL2lvbW11L2FybS9hcm0tc21tdS12My9hcm0tc21t
dS12My5jIHwgOCArKysrLS0tLQogMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgNCBk
ZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L2FybS9hcm0tc21tdS12My9h
cm0tc21tdS12My5jIGIvZHJpdmVycy9pb21tdS9hcm0vYXJtLXNtbXUtdjMvYXJtLXNtbXUtdjMu
YwppbmRleCA3NTRiYWQ2MDkyYzEuLmY5MTk1Yjc0MGY0OCAxMDA2NDQKLS0tIGEvZHJpdmVycy9p
b21tdS9hcm0vYXJtLXNtbXUtdjMvYXJtLXNtbXUtdjMuYworKysgYi9kcml2ZXJzL2lvbW11L2Fy
bS9hcm0tc21tdS12My9hcm0tc21tdS12My5jCkBAIC0xMTc0LDcgKzExNzQsNyBAQCBzdGF0aWMg
dm9pZCBhcm1fc21tdV9zeW5jX3N0ZV9mb3Jfc2lkKHN0cnVjdCBhcm1fc21tdV9kZXZpY2UgKnNt
bXUsIHUzMiBzaWQpCiB9CiAKIHN0YXRpYyB2b2lkIGFybV9zbW11X3dyaXRlX3N0cnRhYl9lbnQo
c3RydWN0IGFybV9zbW11X21hc3RlciAqbWFzdGVyLCB1MzIgc2lkLAotCQkJCSAgICAgIF9fbGU2
NCAqZHN0KQorCQkJCSAgICAgIF9fbGU2NCAqZHN0LCBib29sIGJ5cGFzcykKIHsKIAkvKgogCSAq
IFRoaXMgaXMgaGlkZW91c2x5IGNvbXBsaWNhdGVkLCBidXQgd2Ugb25seSByZWFsbHkgY2FyZSBh
Ym91dApAQCAtMTI0NSw3ICsxMjQ1LDcgQEAgc3RhdGljIHZvaWQgYXJtX3NtbXVfd3JpdGVfc3Ry
dGFiX2VudChzdHJ1Y3QgYXJtX3NtbXVfbWFzdGVyICptYXN0ZXIsIHUzMiBzaWQsCiAKIAkvKiBC
eXBhc3MvZmF1bHQgKi8KIAlpZiAoIXNtbXVfZG9tYWluIHx8ICEoczFfY2ZnIHx8IHMyX2NmZykp
IHsKLQkJaWYgKCFzbW11X2RvbWFpbiAmJiBkaXNhYmxlX2J5cGFzcykKKwkJaWYgKCFzbW11X2Rv
bWFpbiAmJiBkaXNhYmxlX2J5cGFzcyAmJiAhYnlwYXNzKQogCQkJdmFsIHw9IEZJRUxEX1BSRVAo
U1RSVEFCX1NURV8wX0NGRywgU1RSVEFCX1NURV8wX0NGR19BQk9SVCk7CiAJCWVsc2UKIAkJCXZh
bCB8PSBGSUVMRF9QUkVQKFNUUlRBQl9TVEVfMF9DRkcsIFNUUlRBQl9TVEVfMF9DRkdfQllQQVNT
KTsKQEAgLTEzMjAsNyArMTMyMCw3IEBAIHN0YXRpYyB2b2lkIGFybV9zbW11X2luaXRfYnlwYXNz
X3N0ZXMoX19sZTY0ICpzdHJ0YWIsIHVuc2lnbmVkIGludCBuZW50KQogCXVuc2lnbmVkIGludCBp
OwogCiAJZm9yIChpID0gMDsgaSA8IG5lbnQ7ICsraSkgewotCQlhcm1fc21tdV93cml0ZV9zdHJ0
YWJfZW50KE5VTEwsIC0xLCBzdHJ0YWIpOworCQlhcm1fc21tdV93cml0ZV9zdHJ0YWJfZW50KE5V
TEwsIC0xLCBzdHJ0YWIsIGZhbHNlKTsKIAkJc3RydGFiICs9IFNUUlRBQl9TVEVfRFdPUkRTOwog
CX0KIH0KQEAgLTIwOTcsNyArMjA5Nyw3IEBAIHN0YXRpYyB2b2lkIGFybV9zbW11X2luc3RhbGxf
c3RlX2Zvcl9kZXYoc3RydWN0IGFybV9zbW11X21hc3RlciAqbWFzdGVyKQogCQlpZiAoaiA8IGkp
CiAJCQljb250aW51ZTsKIAotCQlhcm1fc21tdV93cml0ZV9zdHJ0YWJfZW50KG1hc3Rlciwgc2lk
LCBzdGVwKTsKKwkJYXJtX3NtbXVfd3JpdGVfc3RydGFiX2VudChtYXN0ZXIsIHNpZCwgc3RlcCwg
ZmFsc2UpOwogCX0KIH0KIAotLSAKMi4xNy4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgt
Zm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4v
bGlzdGluZm8vaW9tbXU=
