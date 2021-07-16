Return-Path: <SRS0=XGcg=MI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DBABC07E95
	for <iommu@archiver.kernel.org>; Fri, 16 Jul 2021 08:34:54 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18075613E3
	for <iommu@archiver.kernel.org>; Fri, 16 Jul 2021 08:34:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18075613E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id CCC254022F;
	Fri, 16 Jul 2021 08:34:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xwPrNhn8gUbI; Fri, 16 Jul 2021 08:34:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id AE79940EDF;
	Fri, 16 Jul 2021 08:34:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7D67BC0010;
	Fri, 16 Jul 2021 08:34:52 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 88EC3C000E
 for <iommu@lists.linux-foundation.org>; Fri, 16 Jul 2021 08:34:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 600B54156D
 for <iommu@lists.linux-foundation.org>; Fri, 16 Jul 2021 08:34:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iOcsup7rqoRA for <iommu@lists.linux-foundation.org>;
 Fri, 16 Jul 2021 08:34:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4AD6840635
 for <iommu@lists.linux-foundation.org>; Fri, 16 Jul 2021 08:34:48 +0000 (UTC)
Received: from fraeml713-chm.china.huawei.com (unknown [172.18.147.206])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GR44z0lzMz6H7Pb;
 Fri, 16 Jul 2021 16:23:31 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml713-chm.china.huawei.com (10.206.15.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 16 Jul 2021 10:34:45 +0200
Received: from A2006125610.china.huawei.com (10.47.80.222) by
 lhreml710-chm.china.huawei.com (10.201.108.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 16 Jul 2021 09:34:38 +0100
From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
To: <linux-arm-kernel@lists.infradead.org>, <linux-acpi@vger.kernel.org>,
 <iommu@lists.linux-foundation.org>
Subject: [PATCH v6 0/9] ACPI/IORT: Support for IORT RMR node
Date: Fri, 16 Jul 2021 09:34:33 +0100
Message-ID: <20210716083442.1708-1-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
MIME-Version: 1.0
X-Originating-IP: [10.47.80.222]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
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

SGksCgpNYWpvciBDaGFuZ2VzIGZyb20gdjU6Ci0gQWRkcmVzc2VkIGNvbW1lbnRzIGZyb20gUm9i
aW4gJiBMb3JlbnpvLgogIDogTW92ZWQgaW9ydF9wYXJzZV9ybXIoKSB0byBhY3BpX2lvcnRfaW5p
dCgpIGZyb20KICAgIGlvcnRfaW5pdF9wbGF0Zm9ybV9kZXZpY2VzKCkuCiAgOiBSZW1vdmVkIHVz
ZSBvZiBzdHJ1Y3QgaW9ydF9ybXJfZW50cnkgZHVyaW5nIHRoZSBpbml0aWFsCiAgICBwYXJzZS4g
VXNpbmcgc3RydWN0IGlvbW11X3Jlc3ZfcmVnaW9uIGluc3RlYWQuCiAgOiBSZXBvcnQgUk1SIGFk
ZHJlc3MgYWxpZ25tZW50IGFuZCBvdmVybGFwIGVycm9ycywgYnV0IGNvbnRpbnVlLgogIDogUmV3
b3JrZWQgYXJtX3NtbXVfaW5pdF9ieXBhc3Nfc3RlcygpIChwYXRjaCAjIDYpLgotIFVwZGF0ZWQg
U01NVXYyIGJ5cGFzcyBTTVIgY29kZS4gVGhhbmtzIHRvIEpvbiBOIChwYXRjaCAjOCkuCi0gU2V0
IElPTU1VIHByb3RlY3Rpb24gZmxhZ3MoSU9NTVVfQ0FDSEUsIElPTU1VX01NSU8pIGJhc2VkCiAg
b24gVHlwZSBvZiBSTVIgcmVnaW9uLiBTdWdnZXN0ZWQgYnkgSm9uIE4uCgpTYW5pdHkgdGVzdGVk
IG9uIGEgSGlTaWxpY29uIEQwNihTTU1VdjMpLiBGdXJ0aGVyIHRlc3RpbmcgYW5kCmZlZWRiYWNr
IGlzIGdyZWF0bHkgYXBwcmVjaWF0ZWQuCgpUaGFua3MsClNoYW1lZXIKCi0tLS0tLQp2NCAtLT4g
djUKIC1BZGRlZCBhIGZ3X2RhdGEgdW5pb24gdG8gc3RydWN0IGlvbW11X3Jlc3ZfcmVnaW9uIGFu
ZCByZW1vdmVkCiAgc3RydWN0IGlvbW11X3JtciAoQmFzZWQgb24gY29tbWVudHMgZnJvbSBKb2Vy
Zy9Sb2JpbikuCiAtQWRkZWQgaW9tbXVfcHV0X3JtcnMoKSB0byByZWxlYXNlIG1lbS4KIC1UaGFu
a3MgdG8gU3RldmUgZm9yIHZlcmlmeWluZyBvbiBTTU1VdjIsIGJ1dCBub3QgYWRkZWQgdGhlIFRl
c3RlZC1ieQogIHlldCBiZWNhdXNlIG9mIHRoZSBhYm92ZSBjaGFuZ2VzLgoKdjMgLS0+djQKLUlu
Y2x1ZGVkIHRoZSBTTU1VdjIgU01SIGJ5cGFzcyBpbnN0YWxsIGNoYW5nZXMgc3VnZ2VzdGVkIGJ5
CiBTdGV2ZShwYXRjaCAjNykKLUFzIHBlciBSb2JpbidzIGNvbW1lbnRzLCBSTVIgcmVzZXJ2ZSBp
bXBsZW1lbnRhdGlvbiBpcyBub3cKIG1vcmUgZ2VuZXJpYyAgKHBhdGNoICM4KSBhbmQgZHJvcHBl
ZCB2MyBwYXRjaGVzIDggYW5kIDEwLgotUmViYXNlIHRvIDUuMTMtcmMxCgpSRkMgdjIgLS0+IHYz
CiAtRHJvcHBlZCBSRkMgdGFnIGFzIHRoZSBBQ1BJQ0EgaGVhZGVyIGNoYW5nZXMgYXJlIG5vdyBy
ZWFkeSB0byBiZQogIHBhcnQgb2YgNS4xM1swXS4gQnV0IHRoaXMgc2VyaWVzIHN0aWxsIGhhcyBh
IGRlcGVuZGVuY3kgb24gdGhhdCBwYXRjaC4KIC1BZGRlZCBJT1JUIEUuYiByZWxhdGVkIGNoYW5n
ZXMobm9kZSBmbGFncywgX0RTTSBmdW5jdGlvbiA1IGNoZWNrcyBmb3IKICBQQ0llKS4KIC1DaGFu
Z2VkIFJNUiB0byBzdHJlYW0gaWQgbWFwcGluZyBmcm9tIE06TiB0byBNOjEgYXMgcGVyIHRoZSBz
cGVjIGFuZAogIGRpc2N1c3Npb24gaGVyZVsxXS4KIC1MYXN0IHR3byBwYXRjaGVzIGFkZCBzdXBw
b3J0IGZvciBTTU1VdjIoVGhhbmtzIHRvIEpvbiBOZXR0bGV0b24hKQotLS0tLS0KCkpvbiBOZXR0
bGV0b24gKDEpOgogIGlvbW11L2FybS1zbW11OiBHZXQgYXNzb2NpYXRlZCBSTVIgaW5mbyBhbmQg
aW5zdGFsbCBieXBhc3MgU01SCgpTaGFtZWVyIEtvbG90aHVtICg4KToKICBpb21tdTogSW50cm9k
dWNlIGEgdW5pb24gdG8gc3RydWN0IGlvbW11X3Jlc3ZfcmVnaW9uCiAgQUNQSS9JT1JUOiBBZGQg
c3VwcG9ydCBmb3IgUk1SIG5vZGUgcGFyc2luZwogIGlvbW11L2RtYTogSW50cm9kdWNlIGdlbmVy
aWMgaGVscGVyIHRvIHJldHJpZXZlIFJNUiBpbmZvCiAgQUNQSS9JT1JUOiBBZGQgYSBoZWxwZXIg
dG8gcmV0cmlldmUgUk1SIG1lbW9yeSByZWdpb25zCiAgaW9tbXUvYXJtLXNtbXUtdjM6IEludHJv
ZHVjZSBzdHJ0YWIgaW5pdCBoZWxwZXIKICBpb21tdS9hcm0tc21tdS12MzogUmVmYWN0b3LCoGFy
bV9zbW11X2luaXRfYnlwYXNzX3N0ZXMoKSB0byBmb3JjZQogICAgYnlwYXNzCiAgaW9tbXUvYXJt
LXNtbXUtdjM6IEdldCBhc3NvY2lhdGVkIFJNUiBpbmZvIGFuZCBpbnN0YWxsIGJ5cGFzcyBTVEUK
ICBpb21tdS9kbWE6IFJlc2VydmUgYW55IFJNUiByZWdpb25zIGFzc29jaWF0ZWQgd2l0aCBhIGRl
dgoKIGRyaXZlcnMvYWNwaS9hcm02NC9pb3J0LmMgICAgICAgICAgICAgICAgICAgfCAxNzIgKysr
KysrKysrKysrKysrKysrKy0KIGRyaXZlcnMvaW9tbXUvYXJtL2FybS1zbW11LXYzL2FybS1zbW11
LXYzLmMgfCAgNzYgKysrKysrKy0tCiBkcml2ZXJzL2lvbW11L2FybS9hcm0tc21tdS9hcm0tc21t
dS5jICAgICAgIHwgIDQ4ICsrKysrKwogZHJpdmVycy9pb21tdS9kbWEtaW9tbXUuYyAgICAgICAg
ICAgICAgICAgICB8ICA4OSArKysrKysrKystCiBpbmNsdWRlL2xpbnV4L2FjcGlfaW9ydC5oICAg
ICAgICAgICAgICAgICAgIHwgICA3ICsKIGluY2x1ZGUvbGludXgvZG1hLWlvbW11LmggICAgICAg
ICAgICAgICAgICAgfCAgMTMgKysKIGluY2x1ZGUvbGludXgvaW9tbXUuaCAgICAgICAgICAgICAg
ICAgICAgICAgfCAgMTEgKysKIDcgZmlsZXMgY2hhbmdlZCwgMzkzIGluc2VydGlvbnMoKyksIDIz
IGRlbGV0aW9ucygtKQoKLS0gCjIuMTcuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZv
dW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2lvbW11
