Return-Path: <SRS0=wYjh=EZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DDB9C388F9
	for <iommu@archiver.kernel.org>; Thu, 19 Nov 2020 12:12:44 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B515246B0
	for <iommu@archiver.kernel.org>; Thu, 19 Nov 2020 12:12:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B515246B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 78E422733D;
	Thu, 19 Nov 2020 12:12:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QMZqOkKj6rne; Thu, 19 Nov 2020 12:12:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 19C9E258A5;
	Thu, 19 Nov 2020 12:12:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 05047C1825;
	Thu, 19 Nov 2020 12:12:41 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0EAC8C1825
 for <iommu@lists.linux-foundation.org>; Thu, 19 Nov 2020 12:12:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id E8DBC873CE
 for <iommu@lists.linux-foundation.org>; Thu, 19 Nov 2020 12:12:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Y8hmDetzSNe5 for <iommu@lists.linux-foundation.org>;
 Thu, 19 Nov 2020 12:12:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 78977873C8
 for <iommu@lists.linux-foundation.org>; Thu, 19 Nov 2020 12:12:38 +0000 (UTC)
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
 by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CcJTJ31GlzhXkw;
 Thu, 19 Nov 2020 20:12:20 +0800 (CST)
Received: from S00345302A-PC.china.huawei.com (10.210.168.73) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.487.0; Thu, 19 Nov 2020 20:12:26 +0800
From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
To: <linux-arm-kernel@lists.infradead.org>, <linux-acpi@vger.kernel.org>,
 <iommu@lists.linux-foundation.org>, <devel@acpica.org>
Subject: [RFC PATCH v2 1/8] ACPICA: IORT: Update for revision E
Date: Thu, 19 Nov 2020 12:11:43 +0000
Message-ID: <20201119121150.3316-2-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
In-Reply-To: <20201119121150.3316-1-shameerali.kolothum.thodi@huawei.com>
References: <20201119121150.3316-1-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.210.168.73]
X-CFilter-Loop: Reflected
Cc: linuxarm@huawei.com, steven.price@arm.com, guohanjun@huawei.com,
 Sami.Mujawar@arm.com, robin.murphy@arm.com, wanghuiqiang@huawei.com
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
LS0KIGluY2x1ZGUvYWNwaS9hY3RibDIuaCB8IDI1ICsrKysrKysrKysrKysrKysrKystLS0tLS0K
IDEgZmlsZSBjaGFuZ2VkLCAxOSBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQoKZGlmZiAt
LWdpdCBhL2luY2x1ZGUvYWNwaS9hY3RibDIuaCBiL2luY2x1ZGUvYWNwaS9hY3RibDIuaAppbmRl
eCBlYzY2Nzc5Y2IxOTMuLjI3NGZjZTdiNWMwMSAxMDA2NDQKLS0tIGEvaW5jbHVkZS9hY3BpL2Fj
dGJsMi5oCisrKyBiL2luY2x1ZGUvYWNwaS9hY3RibDIuaApAQCAtNjgsNyArNjgsNyBAQAogICog
SU9SVCAtIElPIFJlbWFwcGluZyBUYWJsZQogICoKICAqIENvbmZvcm1zIHRvICJJTyBSZW1hcHBp
bmcgVGFibGUgU3lzdGVtIFNvZnR3YXJlIG9uIEFSTSBQbGF0Zm9ybXMiLAotICogRG9jdW1lbnQg
bnVtYmVyOiBBUk0gREVOIDAwNDlELCBNYXJjaCAyMDE4CisgKiBEb2N1bWVudCBudW1iZXI6IEFS
TSBERU4gMDA0OUUsIEp1bmUgMjAyMAogICoKICAqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKiovCiAKQEAg
LTg2LDcgKzg2LDggQEAgc3RydWN0IGFjcGlfaW9ydF9ub2RlIHsKIAl1OCB0eXBlOwogCXUxNiBs
ZW5ndGg7CiAJdTggcmV2aXNpb247Ci0JdTMyIHJlc2VydmVkOworCXUxNiByZXNlcnZlZDsKKwl1
MTYgaWRlbnRpZmllcjsKIAl1MzIgbWFwcGluZ19jb3VudDsKIAl1MzIgbWFwcGluZ19vZmZzZXQ7
CiAJY2hhciBub2RlX2RhdGFbMV07CkBAIC0xMDAsNyArMTAxLDggQEAgZW51bSBhY3BpX2lvcnRf
bm9kZV90eXBlIHsKIAlBQ1BJX0lPUlRfTk9ERV9QQ0lfUk9PVF9DT01QTEVYID0gMHgwMiwKIAlB
Q1BJX0lPUlRfTk9ERV9TTU1VID0gMHgwMywKIAlBQ1BJX0lPUlRfTk9ERV9TTU1VX1YzID0gMHgw
NCwKLQlBQ1BJX0lPUlRfTk9ERV9QTUNHID0gMHgwNQorCUFDUElfSU9SVF9OT0RFX1BNQ0cgPSAw
eDA1LAorCUFDUElfSU9SVF9OT0RFX1JNUiA9IDB4MDYsCiB9OwogCiBzdHJ1Y3QgYWNwaV9pb3J0
X2lkX21hcHBpbmcgewpAQCAtMTY3LDEwICsxNjksMTAgQEAgc3RydWN0IGFjcGlfaW9ydF9yb290
X2NvbXBsZXggewogCXU4IHJlc2VydmVkWzNdOwkJLyogUmVzZXJ2ZWQsIG11c3QgYmUgemVybyAq
LwogfTsKIAotLyogVmFsdWVzIGZvciBhdHNfYXR0cmlidXRlIGZpZWxkIGFib3ZlICovCisvKiBN
YXNrcyBmb3IgYXRzX2F0dHJpYnV0ZSBmaWVsZCBhYm92ZSAqLwogCi0jZGVmaW5lIEFDUElfSU9S
VF9BVFNfU1VQUE9SVEVEICAgICAgICAgMHgwMDAwMDAwMQkvKiBUaGUgcm9vdCBjb21wbGV4IHN1
cHBvcnRzIEFUUyAqLwotI2RlZmluZSBBQ1BJX0lPUlRfQVRTX1VOU1VQUE9SVEVEICAgICAgIDB4
MDAwMDAwMDAJLyogVGhlIHJvb3QgY29tcGxleCBkb2Vzbid0IHN1cHBvcnQgQVRTICovCisjZGVm
aW5lIEFDUElfSU9SVF9BVFNfU1VQUE9SVEVEICAgICAgICAgKDEpCS8qIFRoZSByb290IGNvbXBs
ZXggc3VwcG9ydHMgQVRTICovCisjZGVmaW5lIEFDUElfSU9SVF9QUklfU1VQUE9SVEVEICAgICAg
ICAgKDE8PDEpCS8qIFRoZSByb290IGNvbXBsZXggc3VwcG9ydHMgUFJJICovCiAKIHN0cnVjdCBh
Y3BpX2lvcnRfc21tdSB7CiAJdTY0IGJhc2VfYWRkcmVzczsJLyogU01NVSBiYXNlIGFkZHJlc3Mg
Ki8KQEAgLTI0MSw2ICsyNDMsMTcgQEAgc3RydWN0IGFjcGlfaW9ydF9wbWNnIHsKIAl1NjQgcGFn
ZTFfYmFzZV9hZGRyZXNzOwogfTsKIAorc3RydWN0IGFjcGlfaW9ydF9ybXIgeworCXUzMiBybXJf
Y291bnQ7CisJdTMyIHJtcl9vZmZzZXQ7Cit9OworCitzdHJ1Y3QgYWNwaV9pb3J0X3Jtcl9kZXNj
IHsKKwl1NjQgYmFzZV9hZGRyZXNzOworCXU2NCBsZW5ndGg7CisJdTMyIHJlc2VydmVkOworfTsK
KwogLyoqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioKICAqCiAgKiBJVlJTIC0gSS9PIFZpcnR1YWxpemF0
aW9uIFJlcG9ydGluZyBTdHJ1Y3R1cmUKLS0gCjIuMTcuMQoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3Rz
LmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2lvbW11
