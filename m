Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DA78C433FE
	for <iommu@archiver.kernel.org>; Wed, 20 Apr 2022 16:49:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 36A7141A0D;
	Wed, 20 Apr 2022 16:49:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SUB-2zPJODBu; Wed, 20 Apr 2022 16:49:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 935C8419CC;
	Wed, 20 Apr 2022 16:49:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 58580C0033;
	Wed, 20 Apr 2022 16:49:25 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A5EEEC002C
 for <iommu@lists.linux-foundation.org>; Wed, 20 Apr 2022 16:49:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 84FFC60C25
 for <iommu@lists.linux-foundation.org>; Wed, 20 Apr 2022 16:49:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5w7bHK5upHVB for <iommu@lists.linux-foundation.org>;
 Wed, 20 Apr 2022 16:49:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 675F660C0F
 for <iommu@lists.linux-foundation.org>; Wed, 20 Apr 2022 16:49:21 +0000 (UTC)
Received: from fraeml710-chm.china.huawei.com (unknown [172.18.147.206])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Kk65W0y9nz67MkT;
 Thu, 21 Apr 2022 00:46:55 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml710-chm.china.huawei.com (10.206.15.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 20 Apr 2022 18:49:17 +0200
Received: from A2006125610.china.huawei.com (10.47.81.194) by
 lhreml710-chm.china.huawei.com (10.201.108.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 20 Apr 2022 17:49:08 +0100
To: <linux-arm-kernel@lists.infradead.org>, <linux-acpi@vger.kernel.org>,
 <iommu@lists.linux-foundation.org>
Subject: [PATCH v10 0/9] ACPI/IORT: Support for IORT RMR node 
Date: Wed, 20 Apr 2022 17:48:27 +0100
Message-ID: <20220420164836.1181-1-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
MIME-Version: 1.0
X-Originating-IP: [10.47.81.194]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Cc: robin.murphy@arm.com, jon@solid-run.com, linuxarm@huawei.com,
 steven.price@arm.com, hch@infradead.org, guohanjun@huawei.com,
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
From: Shameer Kolothum via iommu <iommu@lists.linux-foundation.org>
Reply-To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

SGkKCnY5IC0tPiB2MTAKIC0gRHJvcHBlZCBwYXRjaCAjMSAoIkFkZCB0ZW1wb3JhcnkgUk1SIG5v
ZGUgZmxhZyBkZWZpbml0aW9ucyIpIHNpbmNlCiAgIHRoZSBBQ1BJQ0EgaGVhZGVyIHVwZGF0ZXMg
cGF0Y2ggaXMgbm93IGluIHRoZSBtYWlsaW5nIGxpc3RbMV0KIC0gQmFzZWQgb24gdGhlIHN1Z2dl
c3Rpb24gZnJvbSBDaHJpc3RvcGgsIGludHJvZHVjZWQgYSAKICAgcmVzdl9yZWdpb25fZnJlZV9m
d19kYXRhKCkgY2FsbGJhY2sgaW4gc3RydWN0IGlvbW11X3Jlc3ZfcmVnaW9uIGFuZAogICB1c2Vk
IHRoYXQgdG8gZnJlZSBSTVIgc3BlY2lmaWMgbWVtb3J5IGFsbG9jYXRpb25zLgoKVGhvdWdoIHRo
ZXJlIGlzIGEgc21hbGwgY2hhbmdlIGZyb20gdjkgd2l0aCByZXNwZWN0IHRvIGhvdyB3ZSBmcmVl
IHVwCnRoZSBGVyBzcGVjaWZpYyBkYXRhLCBJIGhhdmUgdGFrZW4gdGhlIGxpYmVydHkgdG8gcGlj
ayB1cCB0aGUgUi1ieSBhbmQKVC1ieSB0YWdzIGZyb20gTG9yZW56bywgU3RldmUgYW5kIExhdXJl
bnRpdS4gQnV0IHBsZWFzZSBkbyB0YWtlIGEgbG9vawphZ2FpbiBhbmQgbGV0IG1lIGtub3cuCgpU
aGFua3MsClNoYW1lZXIKWzFdIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC80NDYxMDM2MS5m
TURRaWRjQzZHQGtyZWFjaGVyLwoKRnJvbSBvbGQ6CldlIGhhdmUgZmFjZWQgaXNzdWVzIHdpdGgg
MzQwOGlNUiBSQUlEIGNvbnRyb2xsZXIgY2FyZHMgd2hpY2gKZmFpbCB0byBib290IHdoZW4gU01N
VSBpcyBlbmFibGVkLiBUaGlzIGlzIGJlY2F1c2UgdGhlc2UKY29udHJvbGxlcnMgbWFrZSB1c2Ug
b2YgaG9zdCBtZW1vcnkgZm9yIHZhcmlvdXMgY2FjaGluZyByZWxhdGVkCnB1cnBvc2VzIGFuZCB3
aGVuIFNNTVUgaXMgZW5hYmxlZCB0aGUgaU1SIGZpcm13YXJlIGZhaWxzIHRvCmFjY2VzcyB0aGVz
ZSBtZW1vcnkgcmVnaW9ucyBhcyB0aGVyZSBpcyBubyBtYXBwaW5nIGZvciB0aGVtLgpJT1JUIFJN
UiBwcm92aWRlcyBhIHdheSBmb3IgVUVGSSB0byBkZXNjcmliZSBhbmQgcmVwb3J0IHRoZXNlCm1l
bW9yeSByZWdpb25zIHNvIHRoYXQgdGhlIGtlcm5lbCBjYW4gbWFrZSBhIHVuaXR5IG1hcHBpbmcg
Zm9yCnRoZXNlIGluIFNNTVUuCgpDaGFuZ2UgSGlzdG9yeToKCnY4IC0tPiB2OQrCoC0gQWRyZXNz
ZWQgY29tbWVudHMgZnJvbSBSb2JpbiBvbiBpbnRlcmZhY2VzLgrCoC0gQWRkcmVzc2VkIGNvbW1l
bnRzIGZyb20gTG9yZW56by4KCnY3IC0tPiB2OArCoCAtIFBhdGNoICMxIGhhcyB0ZW1wIGRlZmlu
aXRpb25zIGZvciBSTVIgcmVsYXRlZCBjaGFuZ2VzIHRpbGwKwqAgwqAgdGhlIEFDUElDQSBoZWFk
ZXIgY2hhbmdlcyBhcmUgcGFydCBvZiBrZXJuZWwuCsKgIC0gTm8gZWFybHkgcGFyc2luZyBvZiBS
TVIgbm9kZSBpbmZvIGFuZCBpcyBvbmx5IHBhcnNlZCBhdCB0aGUKwqAgwqAgdGltZSBvZiB1c2Uu
CsKgIC0gQ2hhbmdlcyB0byB0aGUgUk1SIGdldC9wdXQgQVBJIGZvcm1hdCBjb21wYXJlZCB0byB0
aGUKwqAgwqAgcHJldmlvdXMgdmVyc2lvbi4KwqAgLSBTdXBwb3J0IGZvciBSTVIgZGVzY3JpcHRv
ciBzaGFyZWQgYnkgbXVsdGlwbGUgc3RyZWFtIElEcy4KCnY2IC0tPiB2NwrCoC1maXggcG9pbnRl
ZCBvdXQgYnkgU3RldmUgdG8gdGhlIFNNTVV2MiBTTVIgYnlwYXNzIGluc3RhbGwgaW4gcGF0Y2gg
IzguCgp2NSAtLT4gdjYKLSBBZGRyZXNzZWQgY29tbWVudHMgZnJvbSBSb2JpbiAmIExvcmVuem8u
CsKgIDogTW92ZWQgaW9ydF9wYXJzZV9ybXIoKSB0byBhY3BpX2lvcnRfaW5pdCgpIGZyb20KwqAg
wqAgaW9ydF9pbml0X3BsYXRmb3JtX2RldmljZXMoKS4KwqAgOiBSZW1vdmVkIHVzZSBvZiBzdHJ1
Y3QgaW9ydF9ybXJfZW50cnkgZHVyaW5nIHRoZSBpbml0aWFsCsKgIMKgIHBhcnNlLiBVc2luZyBz
dHJ1Y3QgaW9tbXVfcmVzdl9yZWdpb24gaW5zdGVhZC4KwqAgOiBSZXBvcnQgUk1SIGFkZHJlc3Mg
YWxpZ25tZW50IGFuZCBvdmVybGFwIGVycm9ycywgYnV0IGNvbnRpbnVlLgrCoCA6IFJld29ya2Vk
IGFybV9zbW11X2luaXRfYnlwYXNzX3N0ZXMoKSAocGF0Y2ggIyA2KS4KLSBVcGRhdGVkIFNNTVV2
MiBieXBhc3MgU01SIGNvZGUuIFRoYW5rcyB0byBKb24gTiAocGF0Y2ggIzgpLgotIFNldCBJT01N
VSBwcm90ZWN0aW9uIGZsYWdzKElPTU1VX0NBQ0hFLCBJT01NVV9NTUlPKSBiYXNlZArCoCBvbiBU
eXBlIG9mIFJNUiByZWdpb24uIFN1Z2dlc3RlZCBieSBKb24gTi4KCnY0IC0tPiB2NQrCoC1BZGRl
ZCBhIGZ3X2RhdGEgdW5pb24gdG8gc3RydWN0IGlvbW11X3Jlc3ZfcmVnaW9uIGFuZCByZW1vdmVk
CsKgIHN0cnVjdCBpb21tdV9ybXIgKEJhc2VkIG9uIGNvbW1lbnRzIGZyb20gSm9lcmcvUm9iaW4p
LgrCoC1BZGRlZCBpb21tdV9wdXRfcm1ycygpIHRvIHJlbGVhc2UgbWVtLgrCoC1UaGFua3MgdG8g
U3RldmUgZm9yIHZlcmlmeWluZyBvbiBTTU1VdjIsIGJ1dCBub3QgYWRkZWQgdGhlIFRlc3RlZC1i
eQrCoCB5ZXQgYmVjYXVzZSBvZiB0aGUgYWJvdmUgY2hhbmdlcy4KCnYzIC0tPnY0Ci1JbmNsdWRl
ZCB0aGUgU01NVXYyIFNNUiBieXBhc3MgaW5zdGFsbCBjaGFuZ2VzIHN1Z2dlc3RlZCBieQrCoFN0
ZXZlKHBhdGNoICM3KQotQXMgcGVyIFJvYmluJ3MgY29tbWVudHMsIFJNUiByZXNlcnZlIGltcGxl
bWVudGF0aW9uIGlzIG5vdwrCoG1vcmUgZ2VuZXJpYyDCoChwYXRjaCAjOCkgYW5kIGRyb3BwZWQg
djMgcGF0Y2hlcyA4IGFuZCAxMC4KLVJlYmFzZSB0byA1LjEzLXJjMQoKUkZDIHYyIC0tPiB2MwrC
oC1Ecm9wcGVkIFJGQyB0YWcgYXMgdGhlIEFDUElDQSBoZWFkZXIgY2hhbmdlcyBhcmUgbm93IHJl
YWR5IHRvIGJlCsKgIHBhcnQgb2YgNS4xM1swXS4gQnV0IHRoaXMgc2VyaWVzIHN0aWxsIGhhcyBh
IGRlcGVuZGVuY3kgb24gdGhhdCBwYXRjaC4KwqAtQWRkZWQgSU9SVCBFLmIgcmVsYXRlZCBjaGFu
Z2VzKG5vZGUgZmxhZ3MsIF9EU00gZnVuY3Rpb24gNSBjaGVja3MgZm9yCsKgIFBDSWUpLgrCoC1D
aGFuZ2VkIFJNUiB0byBzdHJlYW0gaWQgbWFwcGluZyBmcm9tIE06TiB0byBNOjEgYXMgcGVyIHRo
ZSBzcGVjIGFuZArCoCBkaXNjdXNzaW9uIGhlcmVbMV0uCsKgLUxhc3QgdHdvIHBhdGNoZXMgYWRk
IHN1cHBvcnQgZm9yIFNNTVV2MihUaGFua3MgdG8gSm9uIE5ldHRsZXRvbiEpCgpKb24gTmV0dGxl
dG9uICgxKToKICBpb21tdS9hcm0tc21tdTogR2V0IGFzc29jaWF0ZWQgUk1SIGluZm8gYW5kIGlu
c3RhbGwgYnlwYXNzIFNNUgoKU2hhbWVlciBLb2xvdGh1bSAoOCk6CiAgaW9tbXU6IEludHJvZHVj
ZSBhIHVuaW9uIHRvIHN0cnVjdCBpb21tdV9yZXN2X3JlZ2lvbgogIEFDUEkvSU9SVDogTWFrZSBp
b3J0X2lvbW11X21zaV9nZXRfcmVzdl9yZWdpb25zKCkgcmV0dXJuIHZvaWQKICBBQ1BJL0lPUlQ6
IFByb3ZpZGUgYSBnZW5lcmljIGhlbHBlciB0byByZXRyaWV2ZSByZXNlcnZlIHJlZ2lvbnMKICBB
Q1BJL0lPUlQ6IEFkZCBzdXBwb3J0IHRvIHJldHJpZXZlIElPUlQgUk1SIHJlc2VydmVkIHJlZ2lv
bnMKICBBQ1BJL0lPUlQ6IEFkZCBhIGhlbHBlciB0byByZXRyaWV2ZSBSTVIgaW5mbyBkaXJlY3Rs
eQogIGlvbW11L2FybS1zbW11LXYzOiBJbnRyb2R1Y2Ugc3RydGFiIGluaXQgaGVscGVyCiAgaW9t
bXUvYXJtLXNtbXUtdjM6IFJlZmFjdG9yIGFybV9zbW11X2luaXRfYnlwYXNzX3N0ZXMoKSB0byBm
b3JjZQogICAgYnlwYXNzCiAgaW9tbXUvYXJtLXNtbXUtdjM6IEdldCBhc3NvY2lhdGVkIFJNUiBp
bmZvIGFuZCBpbnN0YWxsIGJ5cGFzcyBTVEUKCiBkcml2ZXJzL2FjcGkvYXJtNjQvaW9ydC5jICAg
ICAgICAgICAgICAgICAgIHwgMzM1ICsrKysrKysrKysrKysrKysrKy0tCiBkcml2ZXJzL2lvbW11
L2FybS9hcm0tc21tdS12My9hcm0tc21tdS12My5jIHwgIDc4ICsrKystCiBkcml2ZXJzL2lvbW11
L2FybS9hcm0tc21tdS9hcm0tc21tdS5jICAgICAgIHwgIDUyICsrKwogZHJpdmVycy9pb21tdS9k
bWEtaW9tbXUuYyAgICAgICAgICAgICAgICAgICB8ICAgMiArLQogZHJpdmVycy9pb21tdS9pb21t
dS5jICAgICAgICAgICAgICAgICAgICAgICB8ICAxMiArLQogaW5jbHVkZS9saW51eC9hY3BpX2lv
cnQuaCAgICAgICAgICAgICAgICAgICB8ICAxNCArLQogaW5jbHVkZS9saW51eC9pb21tdS5oICAg
ICAgICAgICAgICAgICAgICAgICB8ICAxMyArCiA3IGZpbGVzIGNoYW5nZWQsIDQ2MSBpbnNlcnRp
b25zKCspLCA0NSBkZWxldGlvbnMoLSkKCi0tIAoyLjE3LjEKCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0
cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcv
bWFpbG1hbi9saXN0aW5mby9pb21tdQ==
