Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE8EBC433F5
	for <iommu@archiver.kernel.org>; Mon,  4 Apr 2022 12:43:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9AEA660FBA;
	Mon,  4 Apr 2022 12:43:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2Cxwd9an5FdN; Mon,  4 Apr 2022 12:43:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 41B2460B73;
	Mon,  4 Apr 2022 12:43:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 14D5EC001D;
	Mon,  4 Apr 2022 12:43:00 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DC67DC0012
 for <iommu@lists.linux-foundation.org>; Mon,  4 Apr 2022 12:42:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B1B30401F2
 for <iommu@lists.linux-foundation.org>; Mon,  4 Apr 2022 12:42:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ocZYaqVwaSHa for <iommu@lists.linux-foundation.org>;
 Mon,  4 Apr 2022 12:42:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E6EA74032E
 for <iommu@lists.linux-foundation.org>; Mon,  4 Apr 2022 12:42:55 +0000 (UTC)
Received: from fraeml742-chm.china.huawei.com (unknown [172.18.147.200])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KX9P03PYNz67jHC;
 Mon,  4 Apr 2022 20:40:52 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml742-chm.china.huawei.com (10.206.15.223) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 4 Apr 2022 14:42:52 +0200
Received: from A2006125610.china.huawei.com (10.47.93.34) by
 lhreml710-chm.china.huawei.com (10.201.108.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 4 Apr 2022 13:42:43 +0100
To: <linux-arm-kernel@lists.infradead.org>, <linux-acpi@vger.kernel.org>,
 <iommu@lists.linux-foundation.org>
Subject: [PATCH v9 00/11] ACPI/IORT: Support for IORT RMR node
Date: Mon, 4 Apr 2022 13:41:58 +0100
Message-ID: <20220404124209.1086-1-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
MIME-Version: 1.0
X-Originating-IP: [10.47.93.34]
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
From: Shameer Kolothum via iommu <iommu@lists.linux-foundation.org>
Reply-To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

SGkKCnY4IC0tPiB2OQrCoC0gQWRyZXNzZWQgY29tbWVudHMgZnJvbSBSb2JpbiBvbiBpbnRlcmZh
Y2VzIGFzIGRpc2N1c3NlZCBoZXJlWzBdLgrCoC0gQWRkcmVzc2VkIGNvbW1lbnRzIGZyb20gTG9y
ZW56by4KwqAKVGhvdWdoIGZ1bmN0aW9uYWxseSB0aGVyZSBhcmVuJ3QgYW55IG1ham9yIGNoYW5n
ZXMsIHRoZSBpbnRlcmZhY2VzIGhhdmUKY2hhbmdlZCBmcm9tIHY4IGFuZCBmb3IgdGhhdCByZWFz
b24gbm90IGluY2x1ZGVkIHRoZSBULWJ5IHRhZ3MgZnJvbQpTdGV2ZSBhbmQgRXJpYyB5ZXQoTWFu
eSB0aGFua3MgZm9yIHRoYXQpLiBBcHByZWNpYXRlIGl0IGlmIHlvdSBjb3VsZApnaXZlIHRoaXMg
YSBzcGluIGFuZCBsZXTCoG1lIGtub3cuCgooVGhlIHJldmlzZWQgQUNQSUNBIHB1bGwgcmVxdWVz
dCBmb3IgSU9SVCBFLmQgcmVsYXRlZCBjaGFuZ2VzIGlzCmhlcmVbMV0gYW5kIHRoaXMgaXMgbm93
IG1lcmdlZCB0byBhY3BpY2E6bWFzdGVyLikKClBsZWFzZSB0YWtlIGEgbG9vayBhbmQgbGV0IG1l
IGtub3cgeW91ciB0aG91Z2h0cy4KClRoYW5rcywKU2hhbWVlcgpbMF0gaHR0cHM6Ly9sb3JlLmtl
cm5lbC5vcmcvbGludXgtYXJtLWtlcm5lbC9jOTgyZjFkNy1jNTY1LTc2OWEtYWJhZS03OWM5NjI5
NjlkODhAYXJtLmNvbS8KWzFdIGh0dHBzOi8vZ2l0aHViLmNvbS9hY3BpY2EvYWNwaWNhL3B1bGwv
NzY1CgpGcm9tIG9sZDoKV2UgaGF2ZSBmYWNlZCBpc3N1ZXMgd2l0aCAzNDA4aU1SIFJBSUQgY29u
dHJvbGxlciBjYXJkcyB3aGljaApmYWlsIHRvIGJvb3Qgd2hlbiBTTU1VIGlzIGVuYWJsZWQuIFRo
aXMgaXMgYmVjYXVzZSB0aGVzZQpjb250cm9sbGVycyBtYWtlIHVzZSBvZiBob3N0IG1lbW9yeSBm
b3IgdmFyaW91cyBjYWNoaW5nIHJlbGF0ZWQKcHVycG9zZXMgYW5kIHdoZW4gU01NVSBpcyBlbmFi
bGVkIHRoZSBpTVIgZmlybXdhcmUgZmFpbHMgdG8KYWNjZXNzIHRoZXNlIG1lbW9yeSByZWdpb25z
IGFzIHRoZXJlIGlzIG5vIG1hcHBpbmcgZm9yIHRoZW0uCklPUlQgUk1SIHByb3ZpZGVzIGEgd2F5
IGZvciBVRUZJIHRvIGRlc2NyaWJlIGFuZCByZXBvcnQgdGhlc2UKbWVtb3J5IHJlZ2lvbnMgc28g
dGhhdCB0aGUga2VybmVsIGNhbiBtYWtlIGEgdW5pdHkgbWFwcGluZyBmb3IKdGhlc2UgaW4gU01N
VS4KCkNoYW5nZSBIaXN0b3J5OgoKdjcgLS0+IHY4CiAgLSBQYXRjaCAjMSBoYXMgdGVtcCBkZWZp
bml0aW9ucyBmb3IgUk1SIHJlbGF0ZWQgY2hhbmdlcyB0aWxsCiAgICB0aGUgQUNQSUNBIGhlYWRl
ciBjaGFuZ2VzIGFyZSBwYXJ0IG9mIGtlcm5lbC4KICAtIE5vIGVhcmx5IHBhcnNpbmcgb2YgUk1S
IG5vZGUgaW5mbyBhbmQgaXMgb25seSBwYXJzZWQgYXQgdGhlCiAgICB0aW1lIG9mIHVzZS4KICAt
IENoYW5nZXMgdG8gdGhlIFJNUiBnZXQvcHV0IEFQSSBmb3JtYXQgY29tcGFyZWQgdG8gdGhlCiAg
ICBwcmV2aW91cyB2ZXJzaW9uLgogIC0gU3VwcG9ydCBmb3IgUk1SIGRlc2NyaXB0b3Igc2hhcmVk
IGJ5IG11bHRpcGxlIHN0cmVhbSBJRHMuCgp2NiAtLT4gdjcKIC1maXggcG9pbnRlZCBvdXQgYnkg
U3RldmUgdG8gdGhlIFNNTVV2MiBTTVIgYnlwYXNzIGluc3RhbGwgaW4gcGF0Y2ggIzguCgp2NSAt
LT4gdjYKLSBBZGRyZXNzZWQgY29tbWVudHMgZnJvbSBSb2JpbiAmIExvcmVuem8uCiAgOiBNb3Zl
ZCBpb3J0X3BhcnNlX3JtcigpIHRvIGFjcGlfaW9ydF9pbml0KCkgZnJvbQogICAgaW9ydF9pbml0
X3BsYXRmb3JtX2RldmljZXMoKS4KICA6IFJlbW92ZWQgdXNlIG9mIHN0cnVjdCBpb3J0X3Jtcl9l
bnRyeSBkdXJpbmcgdGhlIGluaXRpYWwKICAgIHBhcnNlLiBVc2luZyBzdHJ1Y3QgaW9tbXVfcmVz
dl9yZWdpb24gaW5zdGVhZC4KICA6IFJlcG9ydCBSTVIgYWRkcmVzcyBhbGlnbm1lbnQgYW5kIG92
ZXJsYXAgZXJyb3JzLCBidXQgY29udGludWUuCiAgOiBSZXdvcmtlZCBhcm1fc21tdV9pbml0X2J5
cGFzc19zdGVzKCkgKHBhdGNoICMgNikuCi0gVXBkYXRlZCBTTU1VdjIgYnlwYXNzIFNNUiBjb2Rl
LiBUaGFua3MgdG8gSm9uIE4gKHBhdGNoICM4KS4KLSBTZXQgSU9NTVUgcHJvdGVjdGlvbiBmbGFn
cyhJT01NVV9DQUNIRSwgSU9NTVVfTU1JTykgYmFzZWQKICBvbiBUeXBlIG9mIFJNUiByZWdpb24u
IFN1Z2dlc3RlZCBieSBKb24gTi4KCnY0IC0tPiB2NQogLUFkZGVkIGEgZndfZGF0YSB1bmlvbiB0
byBzdHJ1Y3QgaW9tbXVfcmVzdl9yZWdpb24gYW5kIHJlbW92ZWQKICBzdHJ1Y3QgaW9tbXVfcm1y
IChCYXNlZCBvbiBjb21tZW50cyBmcm9tIEpvZXJnL1JvYmluKS4KIC1BZGRlZCBpb21tdV9wdXRf
cm1ycygpIHRvIHJlbGVhc2UgbWVtLgogLVRoYW5rcyB0byBTdGV2ZSBmb3IgdmVyaWZ5aW5nIG9u
IFNNTVV2MiwgYnV0IG5vdCBhZGRlZCB0aGUgVGVzdGVkLWJ5CiAgeWV0IGJlY2F1c2Ugb2YgdGhl
IGFib3ZlIGNoYW5nZXMuCgp2MyAtLT52NAotSW5jbHVkZWQgdGhlIFNNTVV2MiBTTVIgYnlwYXNz
IGluc3RhbGwgY2hhbmdlcyBzdWdnZXN0ZWQgYnkKIFN0ZXZlKHBhdGNoICM3KQotQXMgcGVyIFJv
YmluJ3MgY29tbWVudHMsIFJNUiByZXNlcnZlIGltcGxlbWVudGF0aW9uIGlzIG5vdwogbW9yZSBn
ZW5lcmljICAocGF0Y2ggIzgpIGFuZCBkcm9wcGVkIHYzIHBhdGNoZXMgOCBhbmQgMTAuCi1SZWJh
c2UgdG8gNS4xMy1yYzEKClJGQyB2MiAtLT4gdjMKIC1Ecm9wcGVkIFJGQyB0YWcgYXMgdGhlIEFD
UElDQSBoZWFkZXIgY2hhbmdlcyBhcmUgbm93IHJlYWR5IHRvIGJlCiAgcGFydCBvZiA1LjEzWzBd
LiBCdXQgdGhpcyBzZXJpZXMgc3RpbGwgaGFzIGEgZGVwZW5kZW5jeSBvbiB0aGF0IHBhdGNoLgog
LUFkZGVkIElPUlQgRS5iIHJlbGF0ZWQgY2hhbmdlcyhub2RlIGZsYWdzLCBfRFNNIGZ1bmN0aW9u
IDUgY2hlY2tzIGZvcgogIFBDSWUpLgogLUNoYW5nZWQgUk1SIHRvIHN0cmVhbSBpZCBtYXBwaW5n
IGZyb20gTTpOIHRvIE06MSBhcyBwZXIgdGhlIHNwZWMgYW5kCiAgZGlzY3Vzc2lvbiBoZXJlWzFd
LgogLUxhc3QgdHdvIHBhdGNoZXMgYWRkIHN1cHBvcnQgZm9yIFNNTVV2MihUaGFua3MgdG8gSm9u
IE5ldHRsZXRvbiEpCgpKb24gTmV0dGxldG9uICgxKToKICBpb21tdS9hcm0tc21tdTogR2V0IGFz
c29jaWF0ZWQgUk1SIGluZm8gYW5kIGluc3RhbGwgYnlwYXNzIFNNUgoKU2hhbWVlciBLb2xvdGh1
bSAoMTApOgogIEFDUEkvSU9SVDogQWRkIHRlbXBvcmFyeSBSTVIgbm9kZSBmbGFnIGRlZmluaXRp
b25zCiAgaW9tbXU6IEludHJvZHVjZSBhIHVuaW9uIHRvIHN0cnVjdCBpb21tdV9yZXN2X3JlZ2lv
bgogIEFDUEkvSU9SVDogTWFrZSBpb3J0X2lvbW11X21zaV9nZXRfcmVzdl9yZWdpb25zKCkgcmV0
dXJuIHZvaWQKICBBQ1BJL0lPUlQ6IFByb3ZpZGUgYSBnZW5lcmljIGhlbHBlciB0byByZXRyaWV2
ZSByZXNlcnZlIHJlZ2lvbnMKICBpb21tdS9kbWE6IEludHJvZHVjZSBhIGhlbHBlciB0byByZW1v
dmUgcmVzZXJ2ZWQgcmVnaW9ucwogIEFDUEkvSU9SVDogQWRkIHN1cHBvcnQgdG8gcmV0cmlldmUg
SU9SVCBSTVIgcmVzZXJ2ZWQgcmVnaW9ucwogIEFDUEkvSU9SVDogQWRkIGEgaGVscGVyIHRvIHJl
dHJpZXZlIFJNUiBpbmZvIGRpcmVjdGx5CiAgaW9tbXUvYXJtLXNtbXUtdjM6IEludHJvZHVjZSBz
dHJ0YWIgaW5pdCBoZWxwZXIKICBpb21tdS9hcm0tc21tdS12MzogUmVmYWN0b3IgYXJtX3NtbXVf
aW5pdF9ieXBhc3Nfc3RlcygpIHRvIGZvcmNlCiAgICBieXBhc3MKICBpb21tdS9hcm0tc21tdS12
MzogR2V0IGFzc29jaWF0ZWQgUk1SIGluZm8gYW5kIGluc3RhbGwgYnlwYXNzIFNURQoKIGRyaXZl
cnMvYWNwaS9hcm02NC9pb3J0LmMgICAgICAgICAgICAgICAgICAgfCAzNjkgKysrKysrKysrKysr
KysrKysrLS0KIGRyaXZlcnMvaW9tbXUvYXBwbGUtZGFydC5jICAgICAgICAgICAgICAgICAgfCAg
IDIgKy0KIGRyaXZlcnMvaW9tbXUvYXJtL2FybS1zbW11LXYzL2FybS1zbW11LXYzLmMgfCAgODAg
KysrKy0KIGRyaXZlcnMvaW9tbXUvYXJtL2FybS1zbW11L2FybS1zbW11LmMgICAgICAgfCAgNTQg
KystCiBkcml2ZXJzL2lvbW11L2RtYS1pb21tdS5jICAgICAgICAgICAgICAgICAgIHwgIDExICst
CiBkcml2ZXJzL2lvbW11L3ZpcnRpby1pb21tdS5jICAgICAgICAgICAgICAgIHwgICAyICstCiBp
bmNsdWRlL2xpbnV4L2FjcGlfaW9ydC5oICAgICAgICAgICAgICAgICAgIHwgIDE4ICstCiBpbmNs
dWRlL2xpbnV4L2RtYS1pb21tdS5oICAgICAgICAgICAgICAgICAgIHwgICA1ICsKIGluY2x1ZGUv
bGludXgvaW9tbXUuaCAgICAgICAgICAgICAgICAgICAgICAgfCAgIDkgKwogOSBmaWxlcyBjaGFu
Z2VkLCA1MDUgaW5zZXJ0aW9ucygrKSwgNDUgZGVsZXRpb25zKC0pCgotLSAKMi4yNS4xCgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5n
IGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51
eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
