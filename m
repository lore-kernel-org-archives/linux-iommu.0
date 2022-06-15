Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8147C43334
	for <iommu@archiver.kernel.org>; Wed, 15 Jun 2022 10:11:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 417456103D;
	Wed, 15 Jun 2022 10:11:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jQjl7H2MLW1I; Wed, 15 Jun 2022 10:11:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id E3E746102D;
	Wed, 15 Jun 2022 10:11:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 418B8C0083;
	Wed, 15 Jun 2022 10:11:39 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3306FC002D
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jun 2022 10:11:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 142B34193D
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jun 2022 10:11:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fx1zPWNJxOHD for <iommu@lists.linux-foundation.org>;
 Wed, 15 Jun 2022 10:11:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 79F0441921
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jun 2022 10:11:35 +0000 (UTC)
Received: from fraeml739-chm.china.huawei.com (unknown [172.18.147.226])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LNLb94KqMz6H8X3;
 Wed, 15 Jun 2022 18:07:49 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml739-chm.china.huawei.com (10.206.15.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 15 Jun 2022 12:11:31 +0200
Received: from A2006125610.china.huawei.com (10.202.227.178) by
 lhreml710-chm.china.huawei.com (10.201.108.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 15 Jun 2022 11:11:24 +0100
To: <linux-arm-kernel@lists.infradead.org>, <linux-acpi@vger.kernel.org>,
 <iommu@lists.linux-foundation.org>
Subject: [PATCH v13 0/9] ACPI/IORT: Support for IORT RMR node
Date: Wed, 15 Jun 2022 11:10:35 +0100
Message-ID: <20220615101044.1972-1-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
MIME-Version: 1.0
X-Originating-IP: [10.202.227.178]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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

SGkKCnYxMiAtLT4gdjEzCiAgLU5vIGNoYW5nZXMuIFJlYmFzZWQgdG8gNS4xOS1yYzEuCiAgLVBp
Y2tlZCB1cCB0YWdzIHJlY2VpdmVkIGZyb20gTGF1cmVudGl1LCBIYW5qdW4gYW5kIFdpbGwuIFRo
YW5rcyEuCgpUaGFua3MsClNoYW1lZXIKCkZyb20gb2xkOgpXZSBoYXZlIGZhY2VkIGlzc3VlcyB3
aXRoIDM0MDhpTVIgUkFJRCBjb250cm9sbGVyIGNhcmRzIHdoaWNoCmZhaWwgdG8gYm9vdCB3aGVu
IFNNTVUgaXMgZW5hYmxlZC4gVGhpcyBpcyBiZWNhdXNlIHRoZXNlCmNvbnRyb2xsZXJzIG1ha2Ug
dXNlIG9mIGhvc3QgbWVtb3J5IGZvciB2YXJpb3VzIGNhY2hpbmcgcmVsYXRlZApwdXJwb3NlcyBh
bmQgd2hlbiBTTU1VIGlzIGVuYWJsZWQgdGhlIGlNUiBmaXJtd2FyZSBmYWlscyB0bwphY2Nlc3Mg
dGhlc2UgbWVtb3J5IHJlZ2lvbnMgYXMgdGhlcmUgaXMgbm8gbWFwcGluZyBmb3IgdGhlbS4KSU9S
VCBSTVIgcHJvdmlkZXMgYSB3YXkgZm9yIFVFRkkgdG8gZGVzY3JpYmUgYW5kIHJlcG9ydCB0aGVz
ZQptZW1vcnkgcmVnaW9ucyBzbyB0aGF0IHRoZSBrZXJuZWwgY2FuIG1ha2UgYSB1bml0eSBtYXBw
aW5nIGZvcgp0aGVzZSBpbiBTTU1VLgoKQ2hhbmdlIEhpc3Rvcnk6Cgp2MTEgLS0+IHYxMgogIC1N
aW5vciBmaXggaW4gcGF0Y2ggIzQgdG8gYWRkcmVzcyB0aGUgaXNzdWUgcmVwb3J0ZWQgYnkgdGhl
IGtlcm5lbCB0ZXN0IHJvYm90LgogIC1BZGRlZCBSLWJ5IHRhZ3MgYnkgQ2hyaXN0b3BoKHBhdGNo
ICMxKSBhbmQgTG9yZW56byhwYXRjaCAjNCkuCiAgLUFkZGVkIFQtYnkgZnJvbSBTdGV2ZSB0byBh
bGwgcmVsZXZhbnQgcGF0Y2hlcy4gTWFueSB0aGFua3MhLgoKdjEwIC0tPiB2MTEKwqAtQWRkcmVz
c2VkIENocmlzdG9waCdzIGNvbW1lbnRzLiBXZSBub3cgaGF2ZSBhIMKgY2FsbGJhY2sgdG8gCiAg
c3RydWN0IGlvbW11X3Jlc3ZfcmVnaW9uIHRvIGZyZWUgYWxsIHJlbGF0ZWQgbWVtb3J5IGFuZCBh
bHNvwqBkcm9wcGVkCiAgdGhlIEZXIHNwZWNpZmljIHVuaW9uIGFuZCBub3cgaGFzIGEgY29udGFp
bmVyIHN0cnVjdCBpb21tdV9pb3J0X3Jtcl9kYXRhLgogIFNlZSBwYXRjaGVzICMxICYgIzQKIC1B
ZGRlZCBSLWJ5IGZyb20gQ2hyaXN0b3BoLgogLURyb3BwZWQgUi1ieSBmcm9tIExvcmVuem8gZm9y
IHBhdGNoZXMgIzQgJiAjNSBkdWUgdG8gdGhlIGFib3ZlIGNoYW5nZXMuCiAtQWxzbyBkcm9wcGVk
IFQtYnkgZnJvbSBTdGV2ZSBhbmQgTGF1cmVudGl1LiBNYW55IHRoYW5rc8KgZm9yIHlvdXIgdGVz
dAogIGVmZm9ydHMuIEkgaGF2ZcKgZG9uZSBiYXNpYyBzYW5pdHkgdGVzdGluZyBvbiBteSBwbGF0
Zm9ybSBidXQgcGxlYXNlCiAgZG8gaXQgYWdhaW4gYXQgeW91ciBlbmQuCgp2OSAtLT4gdjEwCiAt
IERyb3BwZWQgcGF0Y2ggIzEgKCJBZGQgdGVtcG9yYXJ5IFJNUiBub2RlIGZsYWcgZGVmaW5pdGlv
bnMiKSBzaW5jZQogICB0aGUgQUNQSUNBIGhlYWRlciB1cGRhdGVzIHBhdGNoIGlzIG5vdyBpbiB0
aGUgbWFpbGluZyBsaXN0CiAtIEJhc2VkIG9uIHRoZSBzdWdnZXN0aW9uIGZyb20gQ2hyaXN0b3Bo
LCBpbnRyb2R1Y2VkIGEgCiAgIHJlc3ZfcmVnaW9uX2ZyZWVfZndfZGF0YSgpIGNhbGxiYWNrIGlu
IHN0cnVjdCBpb21tdV9yZXN2X3JlZ2lvbiBhbmQKICAgdXNlZCB0aGF0IHRvIGZyZWUgUk1SIHNw
ZWNpZmljIG1lbW9yeSBhbGxvY2F0aW9ucy4KCnY4IC0tPiB2OQrCoC0gQWRyZXNzZWQgY29tbWVu
dHMgZnJvbSBSb2JpbiBvbiBpbnRlcmZhY2VzLgrCoC0gQWRkcmVzc2VkIGNvbW1lbnRzIGZyb20g
TG9yZW56by4KCnY3IC0tPiB2OArCoCAtIFBhdGNoICMxIGhhcyB0ZW1wIGRlZmluaXRpb25zIGZv
ciBSTVIgcmVsYXRlZCBjaGFuZ2VzIHRpbGwKwqAgwqAgdGhlIEFDUElDQSBoZWFkZXIgY2hhbmdl
cyBhcmUgcGFydCBvZiBrZXJuZWwuCsKgIC0gTm8gZWFybHkgcGFyc2luZyBvZiBSTVIgbm9kZSBp
bmZvIGFuZCBpcyBvbmx5IHBhcnNlZCBhdCB0aGUKwqAgwqAgdGltZSBvZiB1c2UuCsKgIC0gQ2hh
bmdlcyB0byB0aGUgUk1SIGdldC9wdXQgQVBJIGZvcm1hdCBjb21wYXJlZCB0byB0aGUKwqAgwqAg
cHJldmlvdXMgdmVyc2lvbi4KwqAgLSBTdXBwb3J0IGZvciBSTVIgZGVzY3JpcHRvciBzaGFyZWQg
YnkgbXVsdGlwbGUgc3RyZWFtIElEcy4KCnY2IC0tPiB2NwrCoC1maXggcG9pbnRlZCBvdXQgYnkg
U3RldmUgdG8gdGhlIFNNTVV2MiBTTVIgYnlwYXNzIGluc3RhbGwgaW4gcGF0Y2ggIzguCgp2NSAt
LT4gdjYKLSBBZGRyZXNzZWQgY29tbWVudHMgZnJvbSBSb2JpbiAmIExvcmVuem8uCsKgIDogTW92
ZWQgaW9ydF9wYXJzZV9ybXIoKSB0byBhY3BpX2lvcnRfaW5pdCgpIGZyb20KwqAgwqAgaW9ydF9p
bml0X3BsYXRmb3JtX2RldmljZXMoKS4KwqAgOiBSZW1vdmVkIHVzZSBvZiBzdHJ1Y3QgaW9ydF9y
bXJfZW50cnkgZHVyaW5nIHRoZSBpbml0aWFsCsKgIMKgIHBhcnNlLiBVc2luZyBzdHJ1Y3QgaW9t
bXVfcmVzdl9yZWdpb24gaW5zdGVhZC4KwqAgOiBSZXBvcnQgUk1SIGFkZHJlc3MgYWxpZ25tZW50
IGFuZCBvdmVybGFwIGVycm9ycywgYnV0IGNvbnRpbnVlLgrCoCA6IFJld29ya2VkIGFybV9zbW11
X2luaXRfYnlwYXNzX3N0ZXMoKSAocGF0Y2ggIyA2KS4KLSBVcGRhdGVkIFNNTVV2MiBieXBhc3Mg
U01SIGNvZGUuIFRoYW5rcyB0byBKb24gTiAocGF0Y2ggIzgpLgotIFNldCBJT01NVSBwcm90ZWN0
aW9uIGZsYWdzKElPTU1VX0NBQ0hFLCBJT01NVV9NTUlPKSBiYXNlZArCoCBvbiBUeXBlIG9mIFJN
UiByZWdpb24uIFN1Z2dlc3RlZCBieSBKb24gTi4KCnY0IC0tPiB2NQrCoC1BZGRlZCBhIGZ3X2Rh
dGEgdW5pb24gdG8gc3RydWN0IGlvbW11X3Jlc3ZfcmVnaW9uIGFuZCByZW1vdmVkCsKgIHN0cnVj
dCBpb21tdV9ybXIgKEJhc2VkIG9uIGNvbW1lbnRzIGZyb20gSm9lcmcvUm9iaW4pLgrCoC1BZGRl
ZCBpb21tdV9wdXRfcm1ycygpIHRvIHJlbGVhc2UgbWVtLgrCoC1UaGFua3MgdG8gU3RldmUgZm9y
IHZlcmlmeWluZyBvbiBTTU1VdjIsIGJ1dCBub3QgYWRkZWQgdGhlIFRlc3RlZC1ieQrCoCB5ZXQg
YmVjYXVzZSBvZiB0aGUgYWJvdmUgY2hhbmdlcy4KCnYzIC0tPnY0Ci1JbmNsdWRlZCB0aGUgU01N
VXYyIFNNUiBieXBhc3MgaW5zdGFsbCBjaGFuZ2VzIHN1Z2dlc3RlZCBieQrCoFN0ZXZlKHBhdGNo
ICM3KQotQXMgcGVyIFJvYmluJ3MgY29tbWVudHMsIFJNUiByZXNlcnZlIGltcGxlbWVudGF0aW9u
IGlzIG5vdwrCoG1vcmUgZ2VuZXJpYyDCoChwYXRjaCAjOCkgYW5kIGRyb3BwZWQgdjMgcGF0Y2hl
cyA4IGFuZCAxMC4KLVJlYmFzZSB0byA1LjEzLXJjMQoKUkZDIHYyIC0tPiB2MwrCoC1Ecm9wcGVk
IFJGQyB0YWcgYXMgdGhlIEFDUElDQSBoZWFkZXIgY2hhbmdlcyBhcmUgbm93IHJlYWR5IHRvIGJl
CsKgIHBhcnQgb2YgNS4xM1swXS4gQnV0IHRoaXMgc2VyaWVzIHN0aWxsIGhhcyBhIGRlcGVuZGVu
Y3kgb24gdGhhdCBwYXRjaC4KwqAtQWRkZWQgSU9SVCBFLmIgcmVsYXRlZCBjaGFuZ2VzKG5vZGUg
ZmxhZ3MsIF9EU00gZnVuY3Rpb24gNSBjaGVja3MgZm9yCsKgIFBDSWUpLgrCoC1DaGFuZ2VkIFJN
UiB0byBzdHJlYW0gaWQgbWFwcGluZyBmcm9tIE06TiB0byBNOjEgYXMgcGVyIHRoZSBzcGVjIGFu
ZArCoCBkaXNjdXNzaW9uIGhlcmVbMV0uCsKgLUxhc3QgdHdvIHBhdGNoZXMgYWRkIHN1cHBvcnQg
Zm9yIFNNTVV2MihUaGFua3MgdG8gSm9uIE5ldHRsZXRvbiEpCgpKb24gTmV0dGxldG9uICgxKToK
ICBpb21tdS9hcm0tc21tdTogR2V0IGFzc29jaWF0ZWQgUk1SIGluZm8gYW5kIGluc3RhbGwgYnlw
YXNzIFNNUgoKU2hhbWVlciBLb2xvdGh1bSAoOCk6CiAgaW9tbXU6IEludHJvZHVjZSBhIGNhbGxi
YWNrIHRvIHN0cnVjdCBpb21tdV9yZXN2X3JlZ2lvbgogIEFDUEkvSU9SVDogTWFrZSBpb3J0X2lv
bW11X21zaV9nZXRfcmVzdl9yZWdpb25zKCkgcmV0dXJuIHZvaWQKICBBQ1BJL0lPUlQ6IFByb3Zp
ZGUgYSBnZW5lcmljIGhlbHBlciB0byByZXRyaWV2ZSByZXNlcnZlIHJlZ2lvbnMKICBBQ1BJL0lP
UlQ6IEFkZCBzdXBwb3J0IHRvIHJldHJpZXZlIElPUlQgUk1SIHJlc2VydmVkIHJlZ2lvbnMKICBB
Q1BJL0lPUlQ6IEFkZCBhIGhlbHBlciB0byByZXRyaWV2ZSBSTVIgaW5mbyBkaXJlY3RseQogIGlv
bW11L2FybS1zbW11LXYzOiBJbnRyb2R1Y2Ugc3RydGFiIGluaXQgaGVscGVyCiAgaW9tbXUvYXJt
LXNtbXUtdjM6IFJlZmFjdG9yIGFybV9zbW11X2luaXRfYnlwYXNzX3N0ZXMoKSB0byBmb3JjZQog
ICAgYnlwYXNzCiAgaW9tbXUvYXJtLXNtbXUtdjM6IEdldCBhc3NvY2lhdGVkIFJNUiBpbmZvIGFu
ZCBpbnN0YWxsIGJ5cGFzcyBTVEUKCiBkcml2ZXJzL2FjcGkvYXJtNjQvaW9ydC5jICAgICAgICAg
ICAgICAgICAgIHwgMzYwICsrKysrKysrKysrKysrKysrKy0tCiBkcml2ZXJzL2lvbW11L2FybS9h
cm0tc21tdS12My9hcm0tc21tdS12My5jIHwgIDc4ICsrKystCiBkcml2ZXJzL2lvbW11L2FybS9h
cm0tc21tdS9hcm0tc21tdS5jICAgICAgIHwgIDUyICsrKwogZHJpdmVycy9pb21tdS9kbWEtaW9t
bXUuYyAgICAgICAgICAgICAgICAgICB8ICAgMiArLQogZHJpdmVycy9pb21tdS9pb21tdS5jICAg
ICAgICAgICAgICAgICAgICAgICB8ICAxNiArLQogaW5jbHVkZS9saW51eC9hY3BpX2lvcnQuaCAg
ICAgICAgICAgICAgICAgICB8ICAxNCArLQogaW5jbHVkZS9saW51eC9pb21tdS5oICAgICAgICAg
ICAgICAgICAgICAgICB8ICAxMCArCiA3IGZpbGVzIGNoYW5nZWQsIDQ4NiBpbnNlcnRpb25zKCsp
LCA0NiBkZWxldGlvbnMoLSkKCi0tIAoyLjI1LjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51
eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1h
bi9saXN0aW5mby9pb21tdQ==
