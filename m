Return-Path: <SRS0=PKzM=EC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06595C55179
	for <iommu@archiver.kernel.org>; Tue, 27 Oct 2020 11:28:13 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57C2A2072D
	for <iommu@archiver.kernel.org>; Tue, 27 Oct 2020 11:28:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57C2A2072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id D34E684FD5;
	Tue, 27 Oct 2020 11:28:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4M6RK8uzLMu0; Tue, 27 Oct 2020 11:28:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 3E90E84FF9;
	Tue, 27 Oct 2020 11:28:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1F288C0859;
	Tue, 27 Oct 2020 11:28:11 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1A2FBC0051
 for <iommu@lists.linux-foundation.org>; Tue, 27 Oct 2020 11:28:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 0DCAF871DB
 for <iommu@lists.linux-foundation.org>; Tue, 27 Oct 2020 11:28:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Dnza7yVWtyWQ for <iommu@lists.linux-foundation.org>;
 Tue, 27 Oct 2020 11:28:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 73828871C2
 for <iommu@lists.linux-foundation.org>; Tue, 27 Oct 2020 11:28:07 +0000 (UTC)
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
 by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4CL8Zt1Yshz6wN3;
 Tue, 27 Oct 2020 19:28:06 +0800 (CST)
Received: from S00345302A-PC.china.huawei.com (10.47.24.15) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.487.0; Tue, 27 Oct 2020 19:27:54 +0800
From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
To: <linux-arm-kernel@lists.infradead.org>, <linux-acpi@vger.kernel.org>,
 <iommu@lists.linux-foundation.org>, <devel@acpica.org>
Subject: [RFC PATCH 1/4] ACPICA: IORT: Update for revision E
Date: Tue, 27 Oct 2020 11:26:43 +0000
Message-ID: <20201027112646.44680-2-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
In-Reply-To: <20201027112646.44680-1-shameerali.kolothum.thodi@huawei.com>
References: <20201027112646.44680-1-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.47.24.15]
X-CFilter-Loop: Reflected
Cc: linuxarm@huawei.com, guohanjun@huawei.com, robin.murphy@arm.com,
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

SU9SVCByZXZpc2lvbiBFIGNvbnRhaW5zIGEgZmV3IGFkZGl0aW9ucyBsaWtlLArCoCDCoCAtQWRk
ZWQgYW4gaWRlbnRpZmllciBmaWVsZCBpbiB0aGUgbm9kZSBkZXNjcmlwdG9ycyB0byBhaWQgdGFi
bGUKwqAgwqAgwqBjcm9zcy1yZWZlcmVuY2luZy4KwqAgwqAgLUludHJvZHVjZWQgdGhlIFJlc2Vy
dmVkIE1lbW9yeSBSYW5nZShSTVIpIG5vZGUuIFRoaXMgaXMgdXNlZAogwqAgwqAgdG8gZGVzY3Jp
YmUgbWVtb3J5IHJhbmdlcyB0aGF0IGFyZSB1c2VkIGJ5IGVuZHBvaW50cyBhbmQgcmVxdWlyZXMK
IMKgIMKgIGEgdW5pdHkgbWFwcGluZyBpbiBTTU1VLgogICAgLUludHJvZHVjZWQgYSBmbGFnIGlu
IHRoZSBSQyBub2RlIHRvIGV4cHJlc3Mgc3VwcG9ydCBmb3IgUFJJLgoKU2lnbmVkLW9mZi1ieTog
U2hhbWVlciBLb2xvdGh1bSA8c2hhbWVlcmFsaS5rb2xvdGh1bS50aG9kaUBodWF3ZWkuY29tPgot
LS0KIC1UaGlzIHNob3VsZCBiZSB1cGRhdGVkIHRocm91Z2ggYWNwaWNhIGdpdC4gSSBoYXZlIHNl
bnQgb3V0IGEgcHVsbAogIHJlcXVlc3QgZm9yIHRoZSBzYW1lIGhlcmUsCiAgaHR0cHM6Ly9naXRo
dWIuY29tL2FjcGljYS9hY3BpY2EvcHVsbC82MzgKClBsZWFzZSBoZWxwIHRvIHJldmlldy4KLS0t
CiBpbmNsdWRlL2FjcGkvYWN0YmwyLmggfCAyNSArKysrKysrKysrKysrKysrKysrLS0tLS0tCiAx
IGZpbGUgY2hhbmdlZCwgMTkgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkKCmRpZmYgLS1n
aXQgYS9pbmNsdWRlL2FjcGkvYWN0YmwyLmggYi9pbmNsdWRlL2FjcGkvYWN0YmwyLmgKaW5kZXgg
ZWM2Njc3OWNiMTkzLi4yNzRmY2U3YjVjMDEgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvYWNwaS9hY3Ri
bDIuaAorKysgYi9pbmNsdWRlL2FjcGkvYWN0YmwyLmgKQEAgLTY4LDcgKzY4LDcgQEAKICAqIElP
UlQgLSBJTyBSZW1hcHBpbmcgVGFibGUKICAqCiAgKiBDb25mb3JtcyB0byAiSU8gUmVtYXBwaW5n
IFRhYmxlIFN5c3RlbSBTb2Z0d2FyZSBvbiBBUk0gUGxhdGZvcm1zIiwKLSAqIERvY3VtZW50IG51
bWJlcjogQVJNIERFTiAwMDQ5RCwgTWFyY2ggMjAxOAorICogRG9jdW1lbnQgbnVtYmVyOiBBUk0g
REVOIDAwNDlFLCBKdW5lIDIwMjAKICAqCiAgKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqLwogCkBAIC04
Niw3ICs4Niw4IEBAIHN0cnVjdCBhY3BpX2lvcnRfbm9kZSB7CiAJdTggdHlwZTsKIAl1MTYgbGVu
Z3RoOwogCXU4IHJldmlzaW9uOwotCXUzMiByZXNlcnZlZDsKKwl1MTYgcmVzZXJ2ZWQ7CisJdTE2
IGlkZW50aWZpZXI7CiAJdTMyIG1hcHBpbmdfY291bnQ7CiAJdTMyIG1hcHBpbmdfb2Zmc2V0Owog
CWNoYXIgbm9kZV9kYXRhWzFdOwpAQCAtMTAwLDcgKzEwMSw4IEBAIGVudW0gYWNwaV9pb3J0X25v
ZGVfdHlwZSB7CiAJQUNQSV9JT1JUX05PREVfUENJX1JPT1RfQ09NUExFWCA9IDB4MDIsCiAJQUNQ
SV9JT1JUX05PREVfU01NVSA9IDB4MDMsCiAJQUNQSV9JT1JUX05PREVfU01NVV9WMyA9IDB4MDQs
Ci0JQUNQSV9JT1JUX05PREVfUE1DRyA9IDB4MDUKKwlBQ1BJX0lPUlRfTk9ERV9QTUNHID0gMHgw
NSwKKwlBQ1BJX0lPUlRfTk9ERV9STVIgPSAweDA2LAogfTsKIAogc3RydWN0IGFjcGlfaW9ydF9p
ZF9tYXBwaW5nIHsKQEAgLTE2NywxMCArMTY5LDEwIEBAIHN0cnVjdCBhY3BpX2lvcnRfcm9vdF9j
b21wbGV4IHsKIAl1OCByZXNlcnZlZFszXTsJCS8qIFJlc2VydmVkLCBtdXN0IGJlIHplcm8gKi8K
IH07CiAKLS8qIFZhbHVlcyBmb3IgYXRzX2F0dHJpYnV0ZSBmaWVsZCBhYm92ZSAqLworLyogTWFz
a3MgZm9yIGF0c19hdHRyaWJ1dGUgZmllbGQgYWJvdmUgKi8KIAotI2RlZmluZSBBQ1BJX0lPUlRf
QVRTX1NVUFBPUlRFRCAgICAgICAgIDB4MDAwMDAwMDEJLyogVGhlIHJvb3QgY29tcGxleCBzdXBw
b3J0cyBBVFMgKi8KLSNkZWZpbmUgQUNQSV9JT1JUX0FUU19VTlNVUFBPUlRFRCAgICAgICAweDAw
MDAwMDAwCS8qIFRoZSByb290IGNvbXBsZXggZG9lc24ndCBzdXBwb3J0IEFUUyAqLworI2RlZmlu
ZSBBQ1BJX0lPUlRfQVRTX1NVUFBPUlRFRCAgICAgICAgICgxKQkvKiBUaGUgcm9vdCBjb21wbGV4
IHN1cHBvcnRzIEFUUyAqLworI2RlZmluZSBBQ1BJX0lPUlRfUFJJX1NVUFBPUlRFRCAgICAgICAg
ICgxPDwxKQkvKiBUaGUgcm9vdCBjb21wbGV4IHN1cHBvcnRzIFBSSSAqLwogCiBzdHJ1Y3QgYWNw
aV9pb3J0X3NtbXUgewogCXU2NCBiYXNlX2FkZHJlc3M7CS8qIFNNTVUgYmFzZSBhZGRyZXNzICov
CkBAIC0yNDEsNiArMjQzLDE3IEBAIHN0cnVjdCBhY3BpX2lvcnRfcG1jZyB7CiAJdTY0IHBhZ2Ux
X2Jhc2VfYWRkcmVzczsKIH07CiAKK3N0cnVjdCBhY3BpX2lvcnRfcm1yIHsKKwl1MzIgcm1yX2Nv
dW50OworCXUzMiBybXJfb2Zmc2V0OworfTsKKworc3RydWN0IGFjcGlfaW9ydF9ybXJfZGVzYyB7
CisJdTY0IGJhc2VfYWRkcmVzczsKKwl1NjQgbGVuZ3RoOworCXUzMiByZXNlcnZlZDsKK307CisK
IC8qKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqCiAgKgogICogSVZSUyAtIEkvTyBWaXJ0dWFsaXphdGlv
biBSZXBvcnRpbmcgU3RydWN0dXJlCi0tIAoyLjE3LjEKCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5s
aW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFp
bG1hbi9saXN0aW5mby9pb21tdQ==
