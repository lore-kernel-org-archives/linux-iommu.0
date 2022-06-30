Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62640C43334
	for <iommu@archiver.kernel.org>; Thu, 30 Jun 2022 14:00:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C589D423F3;
	Thu, 30 Jun 2022 14:00:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C589D423F3
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pNKmY5dZRAbC; Thu, 30 Jun 2022 14:00:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 0B336423C2;
	Thu, 30 Jun 2022 14:00:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0B336423C2
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D27D9C0080;
	Thu, 30 Jun 2022 14:00:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0F8BFC0011
 for <iommu@lists.linux-foundation.org>; Thu, 30 Jun 2022 12:37:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DDF9761368
 for <iommu@lists.linux-foundation.org>; Thu, 30 Jun 2022 12:37:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DDF9761368
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id O7ydqvNBXqf5 for <iommu@lists.linux-foundation.org>;
 Thu, 30 Jun 2022 12:37:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 76A3E61340
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 76A3E61340
 for <iommu@lists.linux-foundation.org>; Thu, 30 Jun 2022 12:37:20 +0000 (UTC)
Received: from dggpeml500024.china.huawei.com (unknown [172.30.72.57])
 by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4LYd9v112wz9smf;
 Thu, 30 Jun 2022 20:36:35 +0800 (CST)
Received: from dggpeml500008.china.huawei.com (7.185.36.147) by
 dggpeml500024.china.huawei.com (7.185.36.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 30 Jun 2022 20:37:16 +0800
Received: from huawei.com (10.67.175.34) by dggpeml500008.china.huawei.com
 (7.185.36.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 30 Jun
 2022 20:37:16 +0800
To: <hch@lst.de>, <m.szyprowski@samsung.com>, <robin.murphy@arm.com>,
 <mathieu.poirier@linaro.org>, <mark-pk.tsai@mediatek.com>
Subject: [PATCH -next] dma-mapping: Fix build error unused-value
Date: Thu, 30 Jun 2022 20:35:28 +0800
Message-ID: <20220630123528.251181-1-renzhijie2@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-Originating-IP: [10.67.175.34]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500008.china.huawei.com (7.185.36.147)
X-CFilter-Loop: Reflected
X-Mailman-Approved-At: Thu, 30 Jun 2022 14:00:37 +0000
Cc: iommu@lists.linux-foundation.org, Ren Zhijie <renzhijie2@huawei.com>,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org
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
From: Ren Zhijie via iommu <iommu@lists.linux-foundation.org>
Reply-To: Ren Zhijie <renzhijie2@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

SWYgQ09ORklHX0RNQV9ERUNMQVJFX0NPSEVSRU5UIGlzIG5vdCBzZXQsCm1ha2UgQVJDSD14ODZf
NjQgQ1JPU1NfQ09NUElMRT14ODZfNjQtbGludXgtZ251LSB3aWxsIGJlIGZhaWxlZCwgbGlrZSB0
aGlzOgoKZHJpdmVycy9yZW1vdGVwcm9jL3JlbW90ZXByb2NfY29yZS5jOiBJbiBmdW5jdGlvbiDi
gJhycHJvY19ydmRldl9yZWxlYXNl4oCZOgouL2luY2x1ZGUvbGludXgvZG1hLW1hcC1vcHMuaDox
ODI6NDI6IGVycm9yOiBzdGF0ZW1lbnQgd2l0aCBubyBlZmZlY3QgWy1XZXJyb3I9dW51c2VkLXZh
bHVlXQogI2RlZmluZSBkbWFfcmVsZWFzZV9jb2hlcmVudF9tZW1vcnkoZGV2KSAoMCkKICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXgpkcml2ZXJzL3JlbW90ZXByb2Mv
cmVtb3RlcHJvY19jb3JlLmM6NDY0OjI6IG5vdGU6IGluIGV4cGFuc2lvbiBvZiBtYWNybyDigJhk
bWFfcmVsZWFzZV9jb2hlcmVudF9tZW1vcnnigJkKICBkbWFfcmVsZWFzZV9jb2hlcmVudF9tZW1v
cnkoZGV2KTsKICBefn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn4KY2MxOiBhbGwgd2FybmluZ3Mg
YmVpbmcgdHJlYXRlZCBhcyBlcnJvcnMKClRoZSByZXR1cm4gdHlwZSBvZiBmdW5jdGlvbiBkbWFf
cmVsZWFzZV9jb2hlcmVudF9tZW1vcnkgaW4gQ09ORklHX0RNQV9ERUNMQVJFX0NPSEVSRU5UIGFy
ZWEgaXMgdm9pZCwgc28gaW4gIUNPTkZJR19ETUFfREVDTEFSRV9DT0hFUkVOVCBhcmVhIGl0IHNo
b3VsZCBuZWl0aGVyIHJldHVybiBhbnkgdmFsdWUgbm9yIGJlIGRlZmluZWQgYXMgemVyby4KClJl
cG9ydGVkLWJ5OiBIdWxrIFJvYm90IDxodWxrY2lAaHVhd2VpLmNvbT4KRml4ZXM6IGU2MWM0NTE0
NzZlNigiZG1hLW1hcHBpbmc6IEFkZCBkbWFfcmVsZWFzZV9jb2hlcmVudF9tZW1vcnkgdG8gRE1B
IEFQSSIpClNpZ25lZC1vZmYtYnk6IFJlbiBaaGlqaWUgPHJlbnpoaWppZTJAaHVhd2VpLmNvbT4K
LS0tCiBpbmNsdWRlL2xpbnV4L2RtYS1tYXAtb3BzLmggfCAyICstCiAxIGZpbGUgY2hhbmdlZCwg
MSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4
L2RtYS1tYXAtb3BzLmggYi9pbmNsdWRlL2xpbnV4L2RtYS1tYXAtb3BzLmgKaW5kZXggNTNkYjk2
NTVlZmU5Li5iZmZmZTQ5NDM1NmEgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvbGludXgvZG1hLW1hcC1v
cHMuaAorKysgYi9pbmNsdWRlL2xpbnV4L2RtYS1tYXAtb3BzLmgKQEAgLTE3OSwxMCArMTc5LDEw
IEBAIHN0YXRpYyBpbmxpbmUgaW50IGRtYV9kZWNsYXJlX2NvaGVyZW50X21lbW9yeShzdHJ1Y3Qg
ZGV2aWNlICpkZXYsCiAJcmV0dXJuIC1FTk9TWVM7CiB9CiAKLSNkZWZpbmUgZG1hX3JlbGVhc2Vf
Y29oZXJlbnRfbWVtb3J5KGRldikgKDApCiAjZGVmaW5lIGRtYV9hbGxvY19mcm9tX2Rldl9jb2hl
cmVudChkZXYsIHNpemUsIGhhbmRsZSwgcmV0KSAoMCkKICNkZWZpbmUgZG1hX3JlbGVhc2VfZnJv
bV9kZXZfY29oZXJlbnQoZGV2LCBvcmRlciwgdmFkZHIpICgwKQogI2RlZmluZSBkbWFfbW1hcF9m
cm9tX2Rldl9jb2hlcmVudChkZXYsIHZtYSwgdmFkZHIsIG9yZGVyLCByZXQpICgwKQorc3RhdGlj
IGlubGluZSB2b2lkIGRtYV9yZWxlYXNlX2NvaGVyZW50X21lbW9yeShzdHJ1Y3QgZGV2aWNlICpk
ZXYpIHsgfQogI2VuZGlmIC8qIENPTkZJR19ETUFfREVDTEFSRV9DT0hFUkVOVCAqLwogCiAjaWZk
ZWYgQ09ORklHX0RNQV9HTE9CQUxfUE9PTAotLSAKMi4xNy4xCgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlz
dHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3Jn
L21haWxtYW4vbGlzdGluZm8vaW9tbXU=
