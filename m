Return-Path: <SRS0=+AsR=M4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AFC0C4338F
	for <iommu@archiver.kernel.org>; Thu,  5 Aug 2021 08:08:44 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCD9F61040
	for <iommu@archiver.kernel.org>; Thu,  5 Aug 2021 08:08:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BCD9F61040
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 885F783777;
	Thu,  5 Aug 2021 08:08:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EKhpqdoKKEkR; Thu,  5 Aug 2021 08:08:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 4261A8336D;
	Thu,  5 Aug 2021 08:08:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0E830C001A;
	Thu,  5 Aug 2021 08:08:42 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CFCBDC000E
 for <iommu@lists.linux-foundation.org>; Thu,  5 Aug 2021 08:08:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B131040398
 for <iommu@lists.linux-foundation.org>; Thu,  5 Aug 2021 08:08:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jonNGFDwaXtV for <iommu@lists.linux-foundation.org>;
 Thu,  5 Aug 2021 08:08:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by smtp4.osuosl.org (Postfix) with ESMTPS id DF9D740390
 for <iommu@lists.linux-foundation.org>; Thu,  5 Aug 2021 08:08:36 +0000 (UTC)
Received: from fraeml744-chm.china.huawei.com (unknown [172.18.147.201])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GgLp935rYz6F8Gd;
 Thu,  5 Aug 2021 16:08:17 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml744-chm.china.huawei.com (10.206.15.225) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 5 Aug 2021 10:08:32 +0200
Received: from A2006125610.china.huawei.com (10.47.91.4) by
 lhreml710-chm.china.huawei.com (10.201.108.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 5 Aug 2021 09:08:25 +0100
From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
To: <linux-arm-kernel@lists.infradead.org>, <linux-acpi@vger.kernel.org>,
 <iommu@lists.linux-foundation.org>
Subject: [PATCH v7 0/9] ACPI/IORT: Support for IORT RMR node
Date: Thu, 5 Aug 2021 09:07:15 +0100
Message-ID: <20210805080724.480-1-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
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

SGksCgpUaGUgc2VyaWVzIGFkZHMgc3VwcG9ydCB0byBJT1JUIFJNUiBub2RlcyBzcGVjaWZpZWQg
aW4gSU9SVApSZXZpc2lvbiBFLmIgLUFSTSBERU4gMDA0OUVbMF0uIFJNUiBub2RlcyBhcmUgdXNl
ZCB0byBkZXNjcmliZQptZW1vcnkgcmFuZ2VzIHRoYXQgYXJlIHVzZWQgYnkgZW5kcG9pbnRzIGFu
ZCByZXF1aXJlIGEgdW5pdHkKbWFwcGluZyBpbiBTTU1VLgoKV2UgaGF2ZSBmYWNlZCBpc3N1ZXMg
d2l0aCAzNDA4aU1SIFJBSUQgY29udHJvbGxlciBjYXJkcyB3aGljaApmYWlsIHRvIGJvb3Qgd2hl
biBTTU1VIGlzIGVuYWJsZWQuIFRoaXMgaXMgYmVjYXVzZSB0aGVzZQpjb250cm9sbGVycyBtYWtl
IHVzZSBvZiBob3N0IG1lbW9yeSBmb3IgdmFyaW91cyBjYWNoaW5nIHJlbGF0ZWQKcHVycG9zZXMg
YW5kIHdoZW4gU01NVSBpcyBlbmFibGVkIHRoZSBpTVIgZmlybXdhcmUgZmFpbHMgdG8gCmFjY2Vz
cyB0aGVzZSBtZW1vcnkgcmVnaW9ucyBhcyB0aGVyZSBpcyBubyBtYXBwaW5nIGZvciB0aGVtLgpJ
T1JUIFJNUiBwcm92aWRlcyBhIHdheSBmb3IgVUVGSSB0byBkZXNjcmliZSBhbmQgcmVwb3J0IHRo
ZXNlCm1lbW9yeSByZWdpb25zIHNvIHRoYXQgdGhlIGtlcm5lbCBjYW4gbWFrZSBhIHVuaXR5IG1h
cHBpbmcgZm9yCnRoZXNlIGluIFNNTVUuCgpDaGFuZ2UgSGlzdG9yeTogCgp2NiAtLT4gdjcKClRo
ZSBvbmx5IGNoYW5nZSBmcm9tIHY2IGlzIHRoZSBmaXggcG9pbnRlZCBvdXQgYnkgU3RldmUgdG8K
dGhlIFNNTVV2MiBTTVIgYnlwYXNzIGluc3RhbGwgaW4gcGF0Y2ggIzguCgpUaGFua3MgdG8gdGhl
IFRlc3RlZC1ieSB0YWdzIGJ5IExhdXJlbnRpdSB3aXRoIFNNTVV2MiBhbmQKSGFuanVuL0h1aXFp
YW5nIHdpdGggU01NVXYzIGZvciB2Ni4gSSBoYXZlbid0IGFkZGVkIHRoZSB0YWdzCnlldCBhcyB0
aGUgc2VyaWVzIHN0aWxsIG5lZWRzIG1vcmUgcmV2aWV3WzFdLgoKRmVlZGJhY2sgYW5kIHRlc3Rz
IG9uIHRoaXMgc2VyaWVzIGlzIHZlcnkgbXVjaCBhcHByZWNpYXRlZC4KCnY1IC0tPiB2NgotIEFk
ZHJlc3NlZCBjb21tZW50cyBmcm9tIFJvYmluICYgTG9yZW56by4KICA6IE1vdmVkIGlvcnRfcGFy
c2Vfcm1yKCkgdG8gYWNwaV9pb3J0X2luaXQoKSBmcm9tCiAgICBpb3J0X2luaXRfcGxhdGZvcm1f
ZGV2aWNlcygpLgogIDogUmVtb3ZlZCB1c2Ugb2Ygc3RydWN0IGlvcnRfcm1yX2VudHJ5IGR1cmlu
ZyB0aGUgaW5pdGlhbAogICAgcGFyc2UuIFVzaW5nIHN0cnVjdCBpb21tdV9yZXN2X3JlZ2lvbiBp
bnN0ZWFkLgogIDogUmVwb3J0IFJNUiBhZGRyZXNzIGFsaWdubWVudCBhbmQgb3ZlcmxhcCBlcnJv
cnMsIGJ1dCBjb250aW51ZS4KICA6IFJld29ya2VkIGFybV9zbW11X2luaXRfYnlwYXNzX3N0ZXMo
KSAocGF0Y2ggIyA2KS4KLSBVcGRhdGVkIFNNTVV2MiBieXBhc3MgU01SIGNvZGUuIFRoYW5rcyB0
byBKb24gTiAocGF0Y2ggIzgpLgotIFNldCBJT01NVSBwcm90ZWN0aW9uIGZsYWdzKElPTU1VX0NB
Q0hFLCBJT01NVV9NTUlPKSBiYXNlZAogIG9uIFR5cGUgb2YgUk1SIHJlZ2lvbi4gU3VnZ2VzdGVk
IGJ5IEpvbiBOLgoKVGhhbmtzLApTaGFtZWVyClswXSBodHRwczovL2RldmVsb3Blci5hcm0uY29t
L2RvY3VtZW50YXRpb24vZGVuMDA0OS9sYXRlc3QvClsxXSBodHRwczovL2xvcmUua2VybmVsLm9y
Zy9saW51eC1hY3BpLzIwMjEwNzE2MDgzNDQyLjE3MDgtMS1zaGFtZWVyYWxpLmtvbG90aHVtLnRo
b2RpQGh1YXdlaS5jb20vVC8jbTA0M2M5NWI4Njk5NzNhODM0YjJmZDU3ZjNlMWVkMDMyNWM4NGYz
YjcKLS0tLS0tCnY0IC0tPiB2NQogLUFkZGVkIGEgZndfZGF0YSB1bmlvbiB0byBzdHJ1Y3QgaW9t
bXVfcmVzdl9yZWdpb24gYW5kIHJlbW92ZWQKICBzdHJ1Y3QgaW9tbXVfcm1yIChCYXNlZCBvbiBj
b21tZW50cyBmcm9tIEpvZXJnL1JvYmluKS4KIC1BZGRlZCBpb21tdV9wdXRfcm1ycygpIHRvIHJl
bGVhc2UgbWVtLgogLVRoYW5rcyB0byBTdGV2ZSBmb3IgdmVyaWZ5aW5nIG9uIFNNTVV2MiwgYnV0
IG5vdCBhZGRlZCB0aGUgVGVzdGVkLWJ5CiAgeWV0IGJlY2F1c2Ugb2YgdGhlIGFib3ZlIGNoYW5n
ZXMuCgp2MyAtLT52NAotSW5jbHVkZWQgdGhlIFNNTVV2MiBTTVIgYnlwYXNzIGluc3RhbGwgY2hh
bmdlcyBzdWdnZXN0ZWQgYnkKIFN0ZXZlKHBhdGNoICM3KQotQXMgcGVyIFJvYmluJ3MgY29tbWVu
dHMsIFJNUiByZXNlcnZlIGltcGxlbWVudGF0aW9uIGlzIG5vdwogbW9yZSBnZW5lcmljICAocGF0
Y2ggIzgpIGFuZCBkcm9wcGVkIHYzIHBhdGNoZXMgOCBhbmQgMTAuCi1SZWJhc2UgdG8gNS4xMy1y
YzEKClJGQyB2MiAtLT4gdjMKIC1Ecm9wcGVkIFJGQyB0YWcgYXMgdGhlIEFDUElDQSBoZWFkZXIg
Y2hhbmdlcyBhcmUgbm93IHJlYWR5IHRvIGJlCiAgcGFydCBvZiA1LjEzWzBdLiBCdXQgdGhpcyBz
ZXJpZXMgc3RpbGwgaGFzIGEgZGVwZW5kZW5jeSBvbiB0aGF0IHBhdGNoLgogLUFkZGVkIElPUlQg
RS5iIHJlbGF0ZWQgY2hhbmdlcyhub2RlIGZsYWdzLCBfRFNNIGZ1bmN0aW9uIDUgY2hlY2tzIGZv
cgogIFBDSWUpLgogLUNoYW5nZWQgUk1SIHRvIHN0cmVhbSBpZCBtYXBwaW5nIGZyb20gTTpOIHRv
IE06MSBhcyBwZXIgdGhlIHNwZWMgYW5kCiAgZGlzY3Vzc2lvbiBoZXJlWzFdLgogLUxhc3QgdHdv
IHBhdGNoZXMgYWRkIHN1cHBvcnQgZm9yIFNNTVV2MihUaGFua3MgdG8gSm9uIE5ldHRsZXRvbiEp
Ci0tLS0tLQoKSm9uIE5ldHRsZXRvbiAoMSk6CiAgaW9tbXUvYXJtLXNtbXU6IEdldCBhc3NvY2lh
dGVkIFJNUiBpbmZvIGFuZCBpbnN0YWxsIGJ5cGFzcyBTTVIKClNoYW1lZXIgS29sb3RodW0gKDgp
OgogIGlvbW11OiBJbnRyb2R1Y2UgYSB1bmlvbiB0byBzdHJ1Y3QgaW9tbXVfcmVzdl9yZWdpb24K
ICBBQ1BJL0lPUlQ6IEFkZCBzdXBwb3J0IGZvciBSTVIgbm9kZSBwYXJzaW5nCiAgaW9tbXUvZG1h
OiBJbnRyb2R1Y2UgZ2VuZXJpYyBoZWxwZXIgdG8gcmV0cmlldmUgUk1SIGluZm8KICBBQ1BJL0lP
UlQ6IEFkZCBhIGhlbHBlciB0byByZXRyaWV2ZSBSTVIgbWVtb3J5IHJlZ2lvbnMKICBpb21tdS9h
cm0tc21tdS12MzogSW50cm9kdWNlIHN0cnRhYiBpbml0IGhlbHBlcgogIGlvbW11L2FybS1zbW11
LXYzOiBSZWZhY3RvcsKgYXJtX3NtbXVfaW5pdF9ieXBhc3Nfc3RlcygpIHRvIGZvcmNlCiAgICBi
eXBhc3MKICBpb21tdS9hcm0tc21tdS12MzogR2V0IGFzc29jaWF0ZWQgUk1SIGluZm8gYW5kIGlu
c3RhbGwgYnlwYXNzIFNURQogIGlvbW11L2RtYTogUmVzZXJ2ZSBhbnkgUk1SIHJlZ2lvbnMgYXNz
b2NpYXRlZCB3aXRoIGEgZGV2CgogZHJpdmVycy9hY3BpL2FybTY0L2lvcnQuYyAgICAgICAgICAg
ICAgICAgICB8IDE3MiArKysrKysrKysrKysrKysrKysrLQogZHJpdmVycy9pb21tdS9hcm0vYXJt
LXNtbXUtdjMvYXJtLXNtbXUtdjMuYyB8ICA3NiArKysrKysrLS0KIGRyaXZlcnMvaW9tbXUvYXJt
L2FybS1zbW11L2FybS1zbW11LmMgICAgICAgfCAgNDggKysrKysrCiBkcml2ZXJzL2lvbW11L2Rt
YS1pb21tdS5jICAgICAgICAgICAgICAgICAgIHwgIDg5ICsrKysrKysrKy0KIGluY2x1ZGUvbGlu
dXgvYWNwaV9pb3J0LmggICAgICAgICAgICAgICAgICAgfCAgIDcgKwogaW5jbHVkZS9saW51eC9k
bWEtaW9tbXUuaCAgICAgICAgICAgICAgICAgICB8ICAxMyArKwogaW5jbHVkZS9saW51eC9pb21t
dS5oICAgICAgICAgICAgICAgICAgICAgICB8ICAxMSArKwogNyBmaWxlcyBjaGFuZ2VkLCAzOTMg
aW5zZXJ0aW9ucygrKSwgMjMgZGVsZXRpb25zKC0pCgotLSAKMi4xNy4xCgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9t
bXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRp
b24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
