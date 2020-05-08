Return-Path: <SRS0=CQae=6W=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25BA0C47247
	for <iommu@archiver.kernel.org>; Fri,  8 May 2020 08:25:04 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06999208CA
	for <iommu@archiver.kernel.org>; Fri,  8 May 2020 08:25:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06999208CA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id C8FFF89699;
	Fri,  8 May 2020 08:25:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LcaE9qZxEqVB; Fri,  8 May 2020 08:25:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 40B48896A3;
	Fri,  8 May 2020 08:25:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 26292C07FF;
	Fri,  8 May 2020 08:25:01 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E7283C07FF
 for <iommu@lists.linux-foundation.org>; Fri,  8 May 2020 01:58:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id CFD04876F6
 for <iommu@lists.linux-foundation.org>; Fri,  8 May 2020 01:58:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BBG4r0B5uHnG for <iommu@lists.linux-foundation.org>;
 Fri,  8 May 2020 01:58:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from huawei.com (szxga06-in.huawei.com [45.249.212.32])
 by whitealder.osuosl.org (Postfix) with ESMTPS id B55B686A0B
 for <iommu@lists.linux-foundation.org>; Fri,  8 May 2020 01:58:49 +0000 (UTC)
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 060F5FEA8977781F3749;
 Fri,  8 May 2020 09:58:47 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.487.0; Fri, 8 May 2020 09:58:38 +0800
From: Chen Zhou <chenzhou10@huawei.com>
To: <joro@8bytes.org>, <matthias.bgg@gmail.com>
Subject: [PATCH -next] iommu: remove set but not used variable 'data'
Date: Fri, 8 May 2020 10:02:31 +0800
Message-ID: <20200508020231.143664-1-chenzhou10@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
X-Mailman-Approved-At: Fri, 08 May 2020 08:24:59 +0000
Cc: chenzhou10@huawei.com, iommu@lists.linux-foundation.org,
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
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

Rml4ZXMgZ2NjICctV3VudXNlZC1idXQtc2V0LXZhcmlhYmxlJyB3YXJuaW5nOgoKZHJpdmVycy9p
b21tdS9tdGtfaW9tbXVfdjEuYzo0Njc6MjU6Cndhcm5pbmc6IHZhcmlhYmxlIOKAmGRhdGHigJkg
c2V0IGJ1dCBub3QgdXNlZCBbLVd1bnVzZWQtYnV0LXNldC12YXJpYWJsZV0KICBzdHJ1Y3QgbXRr
X2lvbW11X2RhdGEgKmRhdGE7CgpSZXBvcnRlZC1ieTogSHVsayBSb2JvdCA8aHVsa2NpQGh1YXdl
aS5jb20+ClNpZ25lZC1vZmYtYnk6IENoZW4gWmhvdSA8Y2hlbnpob3UxMEBodWF3ZWkuY29tPgot
LS0KIGRyaXZlcnMvaW9tbXUvbXRrX2lvbW11X3YxLmMgfCAzICstLQogMSBmaWxlIGNoYW5nZWQs
IDEgaW5zZXJ0aW9uKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW9t
bXUvbXRrX2lvbW11X3YxLmMgYi9kcml2ZXJzL2lvbW11L210a19pb21tdV92MS5jCmluZGV4IDdi
ZGQ3NGM3Y2I5Zi4uMzZjYzFkOTY2N2EyIDEwMDY0NAotLS0gYS9kcml2ZXJzL2lvbW11L210a19p
b21tdV92MS5jCisrKyBiL2RyaXZlcnMvaW9tbXUvbXRrX2lvbW11X3YxLmMKQEAgLTQ2NCwxMiAr
NDY0LDExIEBAIHN0YXRpYyB2b2lkIG10a19pb21tdV9wcm9iZV9maW5hbGl6ZShzdHJ1Y3QgZGV2
aWNlICpkZXYpCiBzdGF0aWMgdm9pZCBtdGtfaW9tbXVfcmVsZWFzZV9kZXZpY2Uoc3RydWN0IGRl
dmljZSAqZGV2KQogewogCXN0cnVjdCBpb21tdV9md3NwZWMgKmZ3c3BlYyA9IGRldl9pb21tdV9m
d3NwZWNfZ2V0KGRldik7Ci0Jc3RydWN0IG10a19pb21tdV9kYXRhICpkYXRhOwogCiAJaWYgKCFm
d3NwZWMgfHwgZndzcGVjLT5vcHMgIT0gJm10a19pb21tdV9vcHMpCiAJCXJldHVybjsKIAotCWRh
dGEgPSBkZXZfaW9tbXVfcHJpdl9nZXQoZGV2KTsKKwlkZXZfaW9tbXVfcHJpdl9nZXQoZGV2KTsK
IAlpb21tdV9md3NwZWNfZnJlZShkZXYpOwogfQogCi0tIAoyLjIwLjEKCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21t
dUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlv
bi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
