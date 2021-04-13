Return-Path: <SRS0=gU7u=JK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF876C43470
	for <iommu@archiver.kernel.org>; Tue, 13 Apr 2021 08:55:21 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E378613BA
	for <iommu@archiver.kernel.org>; Tue, 13 Apr 2021 08:55:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E378613BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5C9EA84337;
	Tue, 13 Apr 2021 08:55:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QPLt2ApB8MI6; Tue, 13 Apr 2021 08:55:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id 390C283F92;
	Tue, 13 Apr 2021 08:55:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D03E7C0014;
	Tue, 13 Apr 2021 08:55:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4E7A7C000A
 for <iommu@lists.linux-foundation.org>; Tue, 13 Apr 2021 08:55:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2EC1C40604
 for <iommu@lists.linux-foundation.org>; Tue, 13 Apr 2021 08:55:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Zk8kVaKbUeNU for <iommu@lists.linux-foundation.org>;
 Tue, 13 Apr 2021 08:55:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
 by smtp4.osuosl.org (Postfix) with ESMTPS id EA2BC40556
 for <iommu@lists.linux-foundation.org>; Tue, 13 Apr 2021 08:55:15 +0000 (UTC)
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
 by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FKKBK2bPNz1BGZD;
 Tue, 13 Apr 2021 16:52:57 +0800 (CST)
Received: from DESKTOP-5IS4806.china.huawei.com (10.174.187.224) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.498.0; Tue, 13 Apr 2021 16:55:05 +0800
From: Keqian Zhu <zhukeqian1@huawei.com>
To: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <iommu@lists.linux-foundation.org>, Robin Murphy <robin.murphy@arm.com>,
 "Will Deacon" <will@kernel.org>, Joerg Roedel <joro@8bytes.org>, Yi Sun
 <yi.y.sun@linux.intel.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, Tian Kevin
 <kevin.tian@intel.com>, Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v3 00/12] iommu/smmuv3: Implement hardware dirty log tracking
Date: Tue, 13 Apr 2021 16:54:45 +0800
Message-ID: <20210413085457.25400-1-zhukeqian1@huawei.com>
X-Mailer: git-send-email 2.8.4.windows.1
MIME-Version: 1.0
X-Originating-IP: [10.174.187.224]
X-CFilter-Loop: Reflected
Cc: jiangkunkun@huawei.com, Cornelia Huck <cohuck@redhat.com>,
 Kirti Wankhede <kwankhede@nvidia.com>, lushenming@huawei.com,
 Alex Williamson <alex.williamson@redhat.com>, wanghaibin.wang@huawei.com
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

ClRoaXMgcGF0Y2ggc2VyaWVzIGlzIHNwbGl0IGZyb20gdGhlIHNlcmllc1sxXSB0aGF0IGNvbnRh
aW5lcyBib3RoIElPTU1VIHBhcnQgYW5kClZGSU8gcGFydC4gVGhlIG5ldyBWRklPIHBhcnQgd2ls
bCBiZSBzZW50IG91dCBpbiBhbm90aGVyIHNlcmllcy4KClsxXSBodHRwczovL2xvcmUua2VybmVs
Lm9yZy9saW51eC1pb21tdS8yMDIxMDMxMDA5MDYxNC4yNjY2OC0xLXpodWtlcWlhbjFAaHVhd2Vp
LmNvbS8KCmNoYW5nZWxvZzoKCnYzOgogLSBNZXJnZSBzdGFydF9kaXJ0eV9sb2cgYW5kIHN0b3Bf
ZGlydHlfbG9nIGludG8gc3dpdGNoX2RpcnR5X2xvZy4gKFlpIFN1bikKIC0gTWFpbnRhaW4gdGhl
IGRpcnR5IGxvZyBzdGF0dXMgaW4gaW9tbXVfZG9tYWluLgogLSBVcGRhdGUgY29tbWl0IG1lc3Nh
Z2UgdG8gbWFrZSBwYXRjaCBlYXNpZXIgdG8gcmV2aWV3LgoKdjI6CiAtIEFkZHJlc3MgYWxsIGNv
bW1lbnRzIG9mIFJGQyB2ZXJzaW9uLCB0aGFua3MgZm9yIGFsbCBvZiB5b3UgOy0pCiAtIEFkZCBh
IGJ1Z2ZpeCB0aGF0IHN0YXJ0IGRpcnR5IGxvZyBmb3IgbmV3bHkgYWRkZWQgZG1hIHJhbmdlcyBh
bmQgZG9tYWluLgoKCgpIaSBldmVyeW9uZSwKClRoaXMgcGF0Y2ggc2VyaWVzIGludHJvZHVjZXMg
YSBmcmFtZXdvcmsgb2YgaW9tbXUgZGlydHkgbG9nIHRyYWNraW5nLCBhbmQgc21tdXYzCnJlYWxp
emVzIHRoaXMgZnJhbWV3b3JrLiBUaGlzIG5ldyBmZWF0dXJlIGNhbiBiZSB1c2VkIGJ5IFZGSU8g
ZG1hIGRpcnR5IHRyYWNraW5nLgoKSW50ZW50aW9u77yaCgpTb21lIHR5cGVzIG9mIElPTU1VIGFy
ZSBjYXBhYmxlIG9mIHRyYWNraW5nIERNQSBkaXJ0eSBsb2csIHN1Y2ggYXMKQVJNIFNNTVUgd2l0
aCBIVFRVIG9yIEludGVsIElPTU1VIHdpdGggU0xBREUuIFRoaXMgaW50cm9kdWNlcyB0aGUKZGly
dHkgbG9nIHRyYWNraW5nIGZyYW1ld29yayBpbiB0aGUgSU9NTVUgYmFzZSBsYXllci4KClRocmVl
IG5ldyBlc3NlbnRpYWwgaW50ZXJmYWNlcyBhcmUgYWRkZWQsIGFuZCB3ZSBtYWludGFpbmNlIHRo
ZSBzdGF0dXMKb2YgZGlydHkgbG9nIHRyYWNraW5nIGluIGlvbW11X2RvbWFpbi4KMS4gaW9tbXVf
c3dpdGNoX2RpcnR5X2xvZzogUGVyZm9ybSBhY3Rpb25zIHRvIHN0YXJ0fHN0b3AgZGlydHkgbG9n
IHRyYWNraW5nCjIuIGlvbW11X3N5bmNfZGlydHlfbG9nOiBTeW5jIGRpcnR5IGxvZyBmcm9tIElP
TU1VIGludG8gYSBkaXJ0eSBiaXRtYXAKMy4gaW9tbXVfY2xlYXJfZGlydHlfbG9nOiBDbGVhciBk
aXJ0eSBsb2cgb2YgSU9NTVUgYnkgYSBtYXNrIGJpdG1hcAoKQWJvdXQgU01NVSBIVFRVOgoKSFRU
VSAoSGFyZHdhcmUgVHJhbnNsYXRpb24gVGFibGUgVXBkYXRlKSBpcyBhIGZlYXR1cmUgb2YgQVJN
IFNNTVV2MywgaXQgY2FuIHVwZGF0ZQphY2Nlc3MgZmxhZyBvci9hbmQgZGlydHkgc3RhdGUgb2Yg
dGhlIFRURCAoVHJhbnNsYXRpb24gVGFibGUgRGVzY3JpcHRvcikgYnkgaGFyZHdhcmUuCldpdGgg
SFRUVSwgc3RhZ2UxIFRURCBpcyBjbGFzc2lmaWVkIGludG8gMyB0eXBlczoKICAgICAgICAgICAg
ICAgICAgICAgICAgREJNIGJpdCAgICAgICAgICAgICBBUFsyXShyZWFkb25seSBiaXQpCjEuIHdy
aXRhYmxlX2NsZWFuICAgICAgICAgMSAgICAgICAgICAgICAgICAgICAgICAgMQoyLiB3cml0YWJs
ZV9kaXJ0eSAgICAgICAgIDEgICAgICAgICAgICAgICAgICAgICAgIDAKMy4gcmVhZG9ubHkgICAg
ICAgICAgICAgICAwICAgICAgICAgICAgICAgICAgICAgICAxCgpJZiBIVFRVX0hEIChtYW5hZ2Ug
ZGlydHkgc3RhdGUpIGlzIGVuYWJsZWQsIHNtbXUgY2FuIGNoYW5nZSBUVEQgZnJvbSB3cml0YWJs
ZV9jbGVhbiB0bwp3cml0YWJsZV9kaXJ0eS4gVGhlbiBzb2Z0d2FyZSBjYW4gc2NhbiBUVEQgdG8g
c3luYyBkaXJ0eSBzdGF0ZSBpbnRvIGRpcnR5IGJpdG1hcC4gV2l0aAp0aGlzIGZlYXR1cmUsIHdl
IGNhbiB0cmFjayB0aGUgZGlydHkgbG9nIG9mIERNQSBjb250aW51b3VzbHkgYW5kIHByZWNpc2Vs
eS4KCkFib3V0IHRoaXMgc2VyaWVzOgoKUGF0Y2ggMS0z77yaSW50cm9kdWNlIGRpcnR5IGxvZyB0
cmFja2luZyBmcmFtZXdvcmsgaW4gdGhlIElPTU1VIGJhc2UgbGF5ZXIsIGFuZCB0d28gY29tbW9u
CiAgICAgICAgICAgaW50ZXJmYWNlcyB0aGF0IGNhbiBiZSB1c2VkIGJ5IG1hbnkgdHlwZXMgb2Yg
aW9tbXUuCgpQYXRjaCA0LTY6IEFkZCBmZWF0dXJlIGRldGVjdGlvbiBmb3Igc21tdSBIVFRVIGFu
ZCBlbmFibGUgSFRUVSBmb3Igc21tdSBzdGFnZTEgbWFwcGluZy4KICAgICAgICAgICBBbmQgYWRk
IGZlYXR1cmUgZGV0ZWN0aW9uIGZvciBzbW11IEJCTUwuIFdlIG5lZWQgdG8gc3BsaXQgYmxvY2sg
bWFwcGluZyB3aGVuCiAgICAgICAgICAgc3RhcnQgZGlydHkgbG9nIHRyYWNraW5nIGFuZCBtZXJn
ZSBwYWdlIG1hcHBpbmcgd2hlbiBzdG9wIGRpcnR5IGxvZyB0cmFja2luZywKCQkgICB3aGljaCBy
ZXF1aXJlcyBicmVhay1iZWZvcmUtbWFrZSBwcm9jZWR1cmUuIEJ1dCBpdCBtaWdodCBjYXVzZSBw
cm9ibGVtcyB3aGVuIHRoZQoJCSAgIFRURCBpcyBhbGl2ZS4gVGhlIEkvTyBzdHJlYW1zIG1pZ2h0
IG5vdCB0b2xlcmF0ZSB0cmFuc2xhdGlvbiBmYXVsdHMuIFNvIEJCTUwKCQkgICBzaG91bGQgYmUg
dXNlZC4KClBhdGNoIDctMTI6IFdlIGltcGxlbWVudCB0aGVzZSBpbnRlcmZhY2VzIGZvciBhcm0g
c21tdXYzLgoKVGhhbmtzLApLZXFpYW4KCkplYW4tUGhpbGlwcGUgQnJ1Y2tlciAoMSk6CiAgaW9t
bXUvYXJtLXNtbXUtdjM6IEFkZCBzdXBwb3J0IGZvciBIYXJkd2FyZSBUcmFuc2xhdGlvbiBUYWJs
ZSBVcGRhdGUKCktlcWlhbiBaaHUgKDMpOgogIGlvbW11OiBJbnRyb2R1Y2UgZGlydHkgbG9nIHRy
YWNraW5nIGZyYW1ld29yawogIGlvbW11OiBBZGQgaW9tbXVfc3BsaXRfYmxvY2sgaW50ZXJmYWNl
CiAgaW9tbXU6IEFkZCBpb21tdV9tZXJnZV9wYWdlIGludGVyZmFjZQoKS3Vua3VuIEppYW5nICg4
KToKICBpb21tdS9hcm0tc21tdS12MzogRW5hYmxlIEhUVFUgZm9yIHN0YWdlMSB3aXRoIGlvLXBn
dGFibGUgbWFwcGluZwogIGlvbW11L2FybS1zbW11LXYzOiBBZGQgZmVhdHVyZSBkZXRlY3Rpb24g
Zm9yIEJCTUwKICBpb21tdS9hcm0tc21tdS12MzogUmVhbGl6ZSBzcGxpdF9ibG9jayBpb21tdSBv
cHMKICBpb21tdS9hcm0tc21tdS12MzogUmVhbGl6ZSBtZXJnZV9wYWdlIGlvbW11IG9wcwogIGlv
bW11L2FybS1zbW11LXYzOiBSZWFsaXplIHN3aXRjaF9kaXJ0eV9sb2cgaW9tbXUgb3BzCiAgaW9t
bXUvYXJtLXNtbXUtdjM6IFJlYWxpemUgc3luY19kaXJ0eV9sb2cgaW9tbXUgb3BzCiAgaW9tbXUv
YXJtLXNtbXUtdjM6IFJlYWxpemUgY2xlYXJfZGlydHlfbG9nIGlvbW11IG9wcwogIGlvbW11L2Fy
bS1zbW11LXYzOiBBZGQgSFdEQk0gZGV2aWNlIGZlYXR1cmUgcmVwb3J0aW5nCgogLi4uL2lvbW11
L2FybS9hcm0tc21tdS12My9hcm0tc21tdS12My1zdmEuYyAgIHwgICAyICsKIGRyaXZlcnMvaW9t
bXUvYXJtL2FybS1zbW11LXYzL2FybS1zbW11LXYzLmMgICB8IDIxNyArKysrKysrKystCiBkcml2
ZXJzL2lvbW11L2FybS9hcm0tc21tdS12My9hcm0tc21tdS12My5oICAgfCAgMTQgKwogZHJpdmVy
cy9pb21tdS9pby1wZ3RhYmxlLWFybS5jICAgICAgICAgICAgICAgIHwgMzkyICsrKysrKysrKysr
KysrKysrLQogZHJpdmVycy9pb21tdS9pb21tdS5jICAgICAgICAgICAgICAgICAgICAgICAgIHwg
MjY2ICsrKysrKysrKysrKwogaW5jbHVkZS9saW51eC9pby1wZ3RhYmxlLmggICAgICAgICAgICAg
ICAgICAgIHwgIDIzICsKIGluY2x1ZGUvbGludXgvaW9tbXUuaCAgICAgICAgICAgICAgICAgICAg
ICAgICB8ICA3NiArKysrCiA3IGZpbGVzIGNoYW5nZWQsIDk4OCBpbnNlcnRpb25zKCspLCAyIGRl
bGV0aW9ucygtKQoKLS0gCjIuMTkuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5k
YXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2lvbW11
