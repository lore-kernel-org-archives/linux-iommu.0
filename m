Return-Path: <SRS0=gpU2=JR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6FC6C433B4
	for <iommu@archiver.kernel.org>; Tue, 20 Apr 2021 09:28:52 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54B9E61090
	for <iommu@archiver.kernel.org>; Tue, 20 Apr 2021 09:28:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54B9E61090
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id F3A1540252;
	Tue, 20 Apr 2021 09:28:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qVy-lUrgaeBZ; Tue, 20 Apr 2021 09:28:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id B0C8A401DB;
	Tue, 20 Apr 2021 09:28:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9BBD9C001E;
	Tue, 20 Apr 2021 09:28:50 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6FF20C000B
 for <iommu@lists.linux-foundation.org>; Tue, 20 Apr 2021 09:28:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5EA884012F
 for <iommu@lists.linux-foundation.org>; Tue, 20 Apr 2021 09:28:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Rgui7511T7KW for <iommu@lists.linux-foundation.org>;
 Tue, 20 Apr 2021 09:28:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 833EB400F0
 for <iommu@lists.linux-foundation.org>; Tue, 20 Apr 2021 09:28:48 +0000 (UTC)
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
 by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FPdbj2CmDzrf4J;
 Tue, 20 Apr 2021 17:26:25 +0800 (CST)
Received: from A2006125610.china.huawei.com (10.47.83.26) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.498.0; Tue, 20 Apr 2021 17:28:38 +0800
From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
To: <linux-arm-kernel@lists.infradead.org>, <linux-acpi@vger.kernel.org>,
 <iommu@lists.linux-foundation.org>
Subject: [PATCH v3 06/10] =?UTF-8?q?iommu/arm-smmu-v3:=20Add=20bypass=20fl?=
 =?UTF-8?q?ag=20to=C2=A0arm=5Fsmmu=5Fwrite=5Fstrtab=5Fent()?=
Date: Tue, 20 Apr 2021 10:27:47 +0200
Message-ID: <20210420082751.1829-7-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
In-Reply-To: <20210420082751.1829-1-shameerali.kolothum.thodi@huawei.com>
References: <20210420082751.1829-1-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.47.83.26]
X-CFilter-Loop: Reflected
Cc: jon@solid-run.com, linuxarm@huawei.com, steven.price@arm.com,
 guohanjun@huawei.com, Sami.Mujawar@arm.com, robin.murphy@arm.com,
 wanghuiqiang@huawei.com
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
oGZvciBSTVIKcmVsYXRlZCBTSURzLgoKU2lnbmVkLW9mZi1ieTogU2hhbWVlciBLb2xvdGh1bSA8
c2hhbWVlcmFsaS5rb2xvdGh1bS50aG9kaUBodWF3ZWkuY29tPgotLS0KIGRyaXZlcnMvaW9tbXUv
YXJtL2FybS1zbW11LXYzL2FybS1zbW11LXYzLmMgfCA4ICsrKystLS0tCiAxIGZpbGUgY2hhbmdl
ZCwgNCBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMv
aW9tbXUvYXJtL2FybS1zbW11LXYzL2FybS1zbW11LXYzLmMgYi9kcml2ZXJzL2lvbW11L2FybS9h
cm0tc21tdS12My9hcm0tc21tdS12My5jCmluZGV4IDI5ZGEzYjY4MTYyMS4uMTkwMjg1ODEyMTgy
IDEwMDY0NAotLS0gYS9kcml2ZXJzL2lvbW11L2FybS9hcm0tc21tdS12My9hcm0tc21tdS12My5j
CisrKyBiL2RyaXZlcnMvaW9tbXUvYXJtL2FybS1zbW11LXYzL2FybS1zbW11LXYzLmMKQEAgLTEx
NzYsNyArMTE3Niw3IEBAIHN0YXRpYyB2b2lkIGFybV9zbW11X3N5bmNfc3RlX2Zvcl9zaWQoc3Ry
dWN0IGFybV9zbW11X2RldmljZSAqc21tdSwgdTMyIHNpZCkKIH0KIAogc3RhdGljIHZvaWQgYXJt
X3NtbXVfd3JpdGVfc3RydGFiX2VudChzdHJ1Y3QgYXJtX3NtbXVfbWFzdGVyICptYXN0ZXIsIHUz
MiBzaWQsCi0JCQkJICAgICAgX19sZTY0ICpkc3QpCisJCQkJICAgICAgX19sZTY0ICpkc3QsIGJv
b2wgYnlwYXNzKQogewogCS8qCiAJICogVGhpcyBpcyBoaWRlb3VzbHkgY29tcGxpY2F0ZWQsIGJ1
dCB3ZSBvbmx5IHJlYWxseSBjYXJlIGFib3V0CkBAIC0xMjQ3LDcgKzEyNDcsNyBAQCBzdGF0aWMg
dm9pZCBhcm1fc21tdV93cml0ZV9zdHJ0YWJfZW50KHN0cnVjdCBhcm1fc21tdV9tYXN0ZXIgKm1h
c3RlciwgdTMyIHNpZCwKIAogCS8qIEJ5cGFzcy9mYXVsdCAqLwogCWlmICghc21tdV9kb21haW4g
fHwgIShzMV9jZmcgfHwgczJfY2ZnKSkgewotCQlpZiAoIXNtbXVfZG9tYWluICYmIGRpc2FibGVf
YnlwYXNzKQorCQlpZiAoIXNtbXVfZG9tYWluICYmIGRpc2FibGVfYnlwYXNzICYmICFieXBhc3Mp
CiAJCQl2YWwgfD0gRklFTERfUFJFUChTVFJUQUJfU1RFXzBfQ0ZHLCBTVFJUQUJfU1RFXzBfQ0ZH
X0FCT1JUKTsKIAkJZWxzZQogCQkJdmFsIHw9IEZJRUxEX1BSRVAoU1RSVEFCX1NURV8wX0NGRywg
U1RSVEFCX1NURV8wX0NGR19CWVBBU1MpOwpAQCAtMTMyMiw3ICsxMzIyLDcgQEAgc3RhdGljIHZv
aWQgYXJtX3NtbXVfaW5pdF9ieXBhc3Nfc3RlcyhfX2xlNjQgKnN0cnRhYiwgdW5zaWduZWQgaW50
IG5lbnQpCiAJdW5zaWduZWQgaW50IGk7CiAKIAlmb3IgKGkgPSAwOyBpIDwgbmVudDsgKytpKSB7
Ci0JCWFybV9zbW11X3dyaXRlX3N0cnRhYl9lbnQoTlVMTCwgLTEsIHN0cnRhYik7CisJCWFybV9z
bW11X3dyaXRlX3N0cnRhYl9lbnQoTlVMTCwgLTEsIHN0cnRhYiwgZmFsc2UpOwogCQlzdHJ0YWIg
Kz0gU1RSVEFCX1NURV9EV09SRFM7CiAJfQogfQpAQCAtMjA3Niw3ICsyMDc2LDcgQEAgc3RhdGlj
IHZvaWQgYXJtX3NtbXVfaW5zdGFsbF9zdGVfZm9yX2RldihzdHJ1Y3QgYXJtX3NtbXVfbWFzdGVy
ICptYXN0ZXIpCiAJCWlmIChqIDwgaSkKIAkJCWNvbnRpbnVlOwogCi0JCWFybV9zbW11X3dyaXRl
X3N0cnRhYl9lbnQobWFzdGVyLCBzaWQsIHN0ZXApOworCQlhcm1fc21tdV93cml0ZV9zdHJ0YWJf
ZW50KG1hc3Rlciwgc2lkLCBzdGVwLCBmYWxzZSk7CiAJfQogfQogCi0tIAoyLjE3LjEKCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcg
bGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4
Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
