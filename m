Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9253C433F5
	for <iommu@archiver.kernel.org>; Fri, 22 Apr 2022 16:29:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 79E5541B96;
	Fri, 22 Apr 2022 16:29:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HRRi6M-0a_OK; Fri, 22 Apr 2022 16:29:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 8C4DF41A5F;
	Fri, 22 Apr 2022 16:29:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 71251C0039;
	Fri, 22 Apr 2022 16:29:38 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 34FFFC002D
 for <iommu@lists.linux-foundation.org>; Fri, 22 Apr 2022 16:29:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 22AE860E46
 for <iommu@lists.linux-foundation.org>; Fri, 22 Apr 2022 16:29:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id k7doq3wMYHnu for <iommu@lists.linux-foundation.org>;
 Fri, 22 Apr 2022 16:29:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E1D80606B0
 for <iommu@lists.linux-foundation.org>; Fri, 22 Apr 2022 16:29:34 +0000 (UTC)
Received: from fraeml737-chm.china.huawei.com (unknown [172.18.147.206])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KlKX71ymKz67tJy;
 Sat, 23 Apr 2022 00:25:43 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml737-chm.china.huawei.com (10.206.15.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 22 Apr 2022 18:29:31 +0200
Received: from A2006125610.china.huawei.com (10.202.227.178) by
 lhreml710-chm.china.huawei.com (10.201.108.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 22 Apr 2022 17:29:23 +0100
To: <linux-arm-kernel@lists.infradead.org>, <linux-acpi@vger.kernel.org>,
 <iommu@lists.linux-foundation.org>
Subject: [PATCH v11 0/9] ACPI/IORT: Support for IORT RMR node
Date: Fri, 22 Apr 2022 17:28:58 +0100
Message-ID: <20220422162907.1276-1-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
MIME-Version: 1.0
X-Originating-IP: [10.202.227.178]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
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

SGkKCnY5IC0tPiB2MTAKwqAtQWRkcmVzc2VkIENocmlzdG9waCdzIGNvbW1lbnRzLiBXZSBub3cg
aGF2ZSBhIGNhbGxiYWNrIHRvIAogIHN0cnVjdCBpb21tdV9yZXN2X3JlZ2lvbiB0byBmcmVlIGFs
bCByZWxhdGVkIG1lbW9yeSBhbmQgYWxzbyBkcm9wcGVkCiAgdGhlIEZXIHNwZWNpZmljIHVuaW9u
IGFuZCBub3cgaGFzIGEgY29udGFpbmVyIHN0cnVjdCBpb21tdV9pb3J0X3Jtcl9kYXRhLgogIFNl
ZSBwYXRjaGVzICMxICYgIzQKIC1BZGRlZCBSLWJ5IGZyb20gQ2hyaXN0b3BoLgogLURyb3BwZWQg
Ui1ieSBmcm9tIExvcmVuem8gZm9yIHBhdGNoZXMgIzQgJiAjNSBkdWUgdG8gdGhlIGFib3ZlIGNo
YW5nZXMuCiAtQWxzbyBkcm9wcGVkIFQtYnkgZnJvbSBTdGV2ZSBhbmQgTGF1cmVudGl1LiBNYW55
IHRoYW5rc8KgZm9yIHlvdXIgdGVzdAogIGVmZm9ydHMuIEkgaGF2ZcKgZG9uZSBiYXNpYyBzYW5p
dHkgdGVzdGluZyBvbiBteSBwbGF0Zm9ybSBidXQgcGxlYXNlCiAgZ2l2ZSBpdCBhIHRyeSBhdCB5
b3VyIGVuZCBhcyB3ZWxsLgoKQXMgbWVudGlvbmVkIGluIHYxMCwgdGhpcyBub3cgaGFzIGEgZGVw
ZW5kZW5jeSBvbiB0aGUgQUNQSUNBIGhlYWRlciBwYXRjaApoZXJlWzFdLiAKClBsZWFzZSB0YWtl
IGEgbG9vayBhbmQgbGV0IG1lIGtub3cuCgpUaGFua3MsClNoYW1lZXIKWzFdIGh0dHBzOi8vbG9y
ZS5rZXJuZWwub3JnL2FsbC80NDYxMDM2MS5mTURRaWRjQzZHQGtyZWFjaGVyLwoKRnJvbSBvbGQ6
CldlIGhhdmUgZmFjZWQgaXNzdWVzIHdpdGggMzQwOGlNUiBSQUlEIGNvbnRyb2xsZXIgY2FyZHMg
d2hpY2gKZmFpbCB0byBib290IHdoZW4gU01NVSBpcyBlbmFibGVkLiBUaGlzIGlzIGJlY2F1c2Ug
dGhlc2UKY29udHJvbGxlcnMgbWFrZSB1c2Ugb2YgaG9zdCBtZW1vcnkgZm9yIHZhcmlvdXMgY2Fj
aGluZyByZWxhdGVkCnB1cnBvc2VzIGFuZCB3aGVuIFNNTVUgaXMgZW5hYmxlZCB0aGUgaU1SIGZp
cm13YXJlIGZhaWxzIHRvCmFjY2VzcyB0aGVzZSBtZW1vcnkgcmVnaW9ucyBhcyB0aGVyZSBpcyBu
byBtYXBwaW5nIGZvciB0aGVtLgpJT1JUIFJNUiBwcm92aWRlcyBhIHdheSBmb3IgVUVGSSB0byBk
ZXNjcmliZSBhbmQgcmVwb3J0IHRoZXNlCm1lbW9yeSByZWdpb25zIHNvIHRoYXQgdGhlIGtlcm5l
bCBjYW4gbWFrZSBhIHVuaXR5IG1hcHBpbmcgZm9yCnRoZXNlIGluIFNNTVUuCgpDaGFuZ2UgSGlz
dG9yeToKCnY5IC0tPiB2MTAKIC0gRHJvcHBlZCBwYXRjaCAjMSAoIkFkZCB0ZW1wb3JhcnkgUk1S
IG5vZGUgZmxhZyBkZWZpbml0aW9ucyIpIHNpbmNlCiAgIHRoZSBBQ1BJQ0EgaGVhZGVyIHVwZGF0
ZXMgcGF0Y2ggaXMgbm93IGluIHRoZSBtYWlsaW5nIGxpc3QKIC0gQmFzZWQgb24gdGhlIHN1Z2dl
c3Rpb24gZnJvbSBDaHJpc3RvcGgsIGludHJvZHVjZWQgYSAKICAgcmVzdl9yZWdpb25fZnJlZV9m
d19kYXRhKCkgY2FsbGJhY2sgaW4gc3RydWN0IGlvbW11X3Jlc3ZfcmVnaW9uIGFuZAogICB1c2Vk
IHRoYXQgdG8gZnJlZSBSTVIgc3BlY2lmaWMgbWVtb3J5IGFsbG9jYXRpb25zLgoKdjggLS0+IHY5
CsKgLSBBZHJlc3NlZCBjb21tZW50cyBmcm9tIFJvYmluIG9uIGludGVyZmFjZXMuCsKgLSBBZGRy
ZXNzZWQgY29tbWVudHMgZnJvbSBMb3JlbnpvLgoKdjcgLS0+IHY4CsKgIC0gUGF0Y2ggIzEgaGFz
IHRlbXAgZGVmaW5pdGlvbnMgZm9yIFJNUiByZWxhdGVkIGNoYW5nZXMgdGlsbArCoCDCoCB0aGUg
QUNQSUNBIGhlYWRlciBjaGFuZ2VzIGFyZSBwYXJ0IG9mIGtlcm5lbC4KwqAgLSBObyBlYXJseSBw
YXJzaW5nIG9mIFJNUiBub2RlIGluZm8gYW5kIGlzIG9ubHkgcGFyc2VkIGF0IHRoZQrCoCDCoCB0
aW1lIG9mIHVzZS4KwqAgLSBDaGFuZ2VzIHRvIHRoZSBSTVIgZ2V0L3B1dCBBUEkgZm9ybWF0IGNv
bXBhcmVkIHRvIHRoZQrCoCDCoCBwcmV2aW91cyB2ZXJzaW9uLgrCoCAtIFN1cHBvcnQgZm9yIFJN
UiBkZXNjcmlwdG9yIHNoYXJlZCBieSBtdWx0aXBsZSBzdHJlYW0gSURzLgoKdjYgLS0+IHY3CsKg
LWZpeCBwb2ludGVkIG91dCBieSBTdGV2ZSB0byB0aGUgU01NVXYyIFNNUiBieXBhc3MgaW5zdGFs
bCBpbiBwYXRjaCAjOC4KCnY1IC0tPiB2NgotIEFkZHJlc3NlZCBjb21tZW50cyBmcm9tIFJvYmlu
ICYgTG9yZW56by4KwqAgOiBNb3ZlZCBpb3J0X3BhcnNlX3JtcigpIHRvIGFjcGlfaW9ydF9pbml0
KCkgZnJvbQrCoCDCoCBpb3J0X2luaXRfcGxhdGZvcm1fZGV2aWNlcygpLgrCoCA6IFJlbW92ZWQg
dXNlIG9mIHN0cnVjdCBpb3J0X3Jtcl9lbnRyeSBkdXJpbmcgdGhlIGluaXRpYWwKwqAgwqAgcGFy
c2UuIFVzaW5nIHN0cnVjdCBpb21tdV9yZXN2X3JlZ2lvbiBpbnN0ZWFkLgrCoCA6IFJlcG9ydCBS
TVIgYWRkcmVzcyBhbGlnbm1lbnQgYW5kIG92ZXJsYXAgZXJyb3JzLCBidXQgY29udGludWUuCsKg
IDogUmV3b3JrZWQgYXJtX3NtbXVfaW5pdF9ieXBhc3Nfc3RlcygpIChwYXRjaCAjIDYpLgotIFVw
ZGF0ZWQgU01NVXYyIGJ5cGFzcyBTTVIgY29kZS4gVGhhbmtzIHRvIEpvbiBOIChwYXRjaCAjOCku
Ci0gU2V0IElPTU1VIHByb3RlY3Rpb24gZmxhZ3MoSU9NTVVfQ0FDSEUsIElPTU1VX01NSU8pIGJh
c2VkCsKgIG9uIFR5cGUgb2YgUk1SIHJlZ2lvbi4gU3VnZ2VzdGVkIGJ5IEpvbiBOLgoKdjQgLS0+
IHY1CsKgLUFkZGVkIGEgZndfZGF0YSB1bmlvbiB0byBzdHJ1Y3QgaW9tbXVfcmVzdl9yZWdpb24g
YW5kIHJlbW92ZWQKwqAgc3RydWN0IGlvbW11X3JtciAoQmFzZWQgb24gY29tbWVudHMgZnJvbSBK
b2VyZy9Sb2JpbikuCsKgLUFkZGVkIGlvbW11X3B1dF9ybXJzKCkgdG8gcmVsZWFzZSBtZW0uCsKg
LVRoYW5rcyB0byBTdGV2ZSBmb3IgdmVyaWZ5aW5nIG9uIFNNTVV2MiwgYnV0IG5vdCBhZGRlZCB0
aGUgVGVzdGVkLWJ5CsKgIHlldCBiZWNhdXNlIG9mIHRoZSBhYm92ZSBjaGFuZ2VzLgoKdjMgLS0+
djQKLUluY2x1ZGVkIHRoZSBTTU1VdjIgU01SIGJ5cGFzcyBpbnN0YWxsIGNoYW5nZXMgc3VnZ2Vz
dGVkIGJ5CsKgU3RldmUocGF0Y2ggIzcpCi1BcyBwZXIgUm9iaW4ncyBjb21tZW50cywgUk1SIHJl
c2VydmUgaW1wbGVtZW50YXRpb24gaXMgbm93CsKgbW9yZSBnZW5lcmljIMKgKHBhdGNoICM4KSBh
bmQgZHJvcHBlZCB2MyBwYXRjaGVzIDggYW5kIDEwLgotUmViYXNlIHRvIDUuMTMtcmMxCgpSRkMg
djIgLS0+IHYzCsKgLURyb3BwZWQgUkZDIHRhZyBhcyB0aGUgQUNQSUNBIGhlYWRlciBjaGFuZ2Vz
IGFyZSBub3cgcmVhZHkgdG8gYmUKwqAgcGFydCBvZiA1LjEzWzBdLiBCdXQgdGhpcyBzZXJpZXMg
c3RpbGwgaGFzIGEgZGVwZW5kZW5jeSBvbiB0aGF0IHBhdGNoLgrCoC1BZGRlZCBJT1JUIEUuYiBy
ZWxhdGVkIGNoYW5nZXMobm9kZSBmbGFncywgX0RTTSBmdW5jdGlvbiA1IGNoZWNrcyBmb3IKwqAg
UENJZSkuCsKgLUNoYW5nZWQgUk1SIHRvIHN0cmVhbSBpZCBtYXBwaW5nIGZyb20gTTpOIHRvIE06
MSBhcyBwZXIgdGhlIHNwZWMgYW5kCsKgIGRpc2N1c3Npb24gaGVyZVsxXS4KwqAtTGFzdCB0d28g
cGF0Y2hlcyBhZGQgc3VwcG9ydCBmb3IgU01NVXYyKFRoYW5rcyB0byBKb24gTmV0dGxldG9uISkK
CkpvbiBOZXR0bGV0b24gKDEpOgogIGlvbW11L2FybS1zbW11OiBHZXQgYXNzb2NpYXRlZCBSTVIg
aW5mbyBhbmQgaW5zdGFsbCBieXBhc3MgU01SCgpTaGFtZWVyIEtvbG90aHVtICg4KToKICBpb21t
dTogSW50cm9kdWNlIGEgY2FsbGJhY2sgdG8gc3RydWN0IGlvbW11X3Jlc3ZfcmVnaW9uCiAgQUNQ
SS9JT1JUOiBNYWtlIGlvcnRfaW9tbXVfbXNpX2dldF9yZXN2X3JlZ2lvbnMoKSByZXR1cm4gdm9p
ZAogIEFDUEkvSU9SVDogUHJvdmlkZSBhIGdlbmVyaWMgaGVscGVyIHRvIHJldHJpZXZlIHJlc2Vy
dmUgcmVnaW9ucwogIEFDUEkvSU9SVDogQWRkIHN1cHBvcnQgdG8gcmV0cmlldmUgSU9SVCBSTVIg
cmVzZXJ2ZWQgcmVnaW9ucwogIEFDUEkvSU9SVDogQWRkIGEgaGVscGVyIHRvIHJldHJpZXZlIFJN
UiBpbmZvIGRpcmVjdGx5CiAgaW9tbXUvYXJtLXNtbXUtdjM6IEludHJvZHVjZSBzdHJ0YWIgaW5p
dCBoZWxwZXIKICBpb21tdS9hcm0tc21tdS12MzogUmVmYWN0b3IgYXJtX3NtbXVfaW5pdF9ieXBh
c3Nfc3RlcygpIHRvIGZvcmNlCiAgICBieXBhc3MKICBpb21tdS9hcm0tc21tdS12MzogR2V0IGFz
c29jaWF0ZWQgUk1SIGluZm8gYW5kIGluc3RhbGwgYnlwYXNzIFNURQoKIGRyaXZlcnMvYWNwaS9h
cm02NC9pb3J0LmMgICAgICAgICAgICAgICAgICAgfCAzNTkgKysrKysrKysrKysrKysrKysrLS0K
IGRyaXZlcnMvaW9tbXUvYXJtL2FybS1zbW11LXYzL2FybS1zbW11LXYzLmMgfCAgNzggKysrKy0K
IGRyaXZlcnMvaW9tbXUvYXJtL2FybS1zbW11L2FybS1zbW11LmMgICAgICAgfCAgNTIgKysrCiBk
cml2ZXJzL2lvbW11L2RtYS1pb21tdS5jICAgICAgICAgICAgICAgICAgIHwgICAyICstCiBkcml2
ZXJzL2lvbW11L2lvbW11LmMgICAgICAgICAgICAgICAgICAgICAgIHwgIDE2ICstCiBpbmNsdWRl
L2xpbnV4L2FjcGlfaW9ydC5oICAgICAgICAgICAgICAgICAgIHwgIDE0ICstCiBpbmNsdWRlL2xp
bnV4L2lvbW11LmggICAgICAgICAgICAgICAgICAgICAgIHwgIDEwICsKIDcgZmlsZXMgY2hhbmdl
ZCwgNDg1IGluc2VydGlvbnMoKyksIDQ2IGRlbGV0aW9ucygtKQoKLS0gCjIuMTcuMQoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBs
aXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhm
b3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
