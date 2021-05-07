Return-Path: <SRS0=Qw1r=KC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA25EC43460
	for <iommu@archiver.kernel.org>; Fri,  7 May 2021 10:22:49 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4862F613F0
	for <iommu@archiver.kernel.org>; Fri,  7 May 2021 10:22:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4862F613F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D02DB843E4;
	Fri,  7 May 2021 10:22:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id O9LfrRtstgzf; Fri,  7 May 2021 10:22:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8AB93843A0;
	Fri,  7 May 2021 10:22:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 64778C0011;
	Fri,  7 May 2021 10:22:47 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B55BDC0001
 for <iommu@lists.linux-foundation.org>; Fri,  7 May 2021 10:22:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9547240002
 for <iommu@lists.linux-foundation.org>; Fri,  7 May 2021 10:22:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hdGgq0X0WB72 for <iommu@lists.linux-foundation.org>;
 Fri,  7 May 2021 10:22:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E3D0840143
 for <iommu@lists.linux-foundation.org>; Fri,  7 May 2021 10:22:42 +0000 (UTC)
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
 by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Fc5zk2XKnzCqmK;
 Fri,  7 May 2021 18:20:02 +0800 (CST)
Received: from DESKTOP-5IS4806.china.huawei.com (10.174.187.224) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.498.0; Fri, 7 May 2021 18:22:30 +0800
From: Keqian Zhu <zhukeqian1@huawei.com>
To: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <iommu@lists.linux-foundation.org>, Robin Murphy <robin.murphy@arm.com>,
 "Will Deacon" <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
 "Jean-Philippe Brucker" <jean-philippe@linaro.org>, Lu Baolu
 <baolu.lu@linux.intel.com>, "Yi Sun" <yi.y.sun@linux.intel.com>, Tian Kevin
 <kevin.tian@intel.com>
Subject: [RFC PATCH v4 00/13] iommu/smmuv3: Implement hardware dirty log
 tracking
Date: Fri, 7 May 2021 18:21:58 +0800
Message-ID: <20210507102211.8836-1-zhukeqian1@huawei.com>
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

SGkgUm9iaW4sIFdpbGwgYW5kIGV2ZXJ5b25lLAoKSSB0aGluayB0aGlzIHNlcmllcyBpcyByZWxh
dGl2ZSBtYXR1cmUgbm93LCBwbGVhc2UgZ2l2ZSB5b3VyIHZhbHVhYmxlIHN1Z2dlc3Rpb25zLAp0
aGFua3MhCgoKVGhpcyBwYXRjaCBzZXJpZXMgaXMgc3BsaXQgZnJvbSB0aGUgc2VyaWVzWzFdIHRo
YXQgY29udGFpbmVzIGJvdGggSU9NTVUgcGFydCBhbmQKVkZJTyBwYXJ0LiBUaGUgVkZJTyBwYXJ0
IHdpbGwgYmUgc2VudCBvdXQgaW4gYW5vdGhlciBzZXJpZXMuCgpbMV0gaHR0cHM6Ly9sb3JlLmtl
cm5lbC5vcmcvbGludXgtaW9tbXUvMjAyMTAzMTAwOTA2MTQuMjY2NjgtMS16aHVrZXFpYW4xQGh1
YXdlaS5jb20vCgpjaGFuZ2Vsb2c6Cgp2NDoKIC0gTW9kaWZ5IHRoZSBmcmFtZXdvcmsgYXMgc3Vn
Z2VzdGVkIGJ5IEJhb2x1LCB0aGFua3MhCiAtIEFkZCB0cmFjZSBmb3IgaW9tbXUgb3BzLgogLSBF
eHRyYWN0IGlvLXBndGFibGUgcGFydC4KCnYzOgogLSBNZXJnZSBzdGFydF9kaXJ0eV9sb2cgYW5k
IHN0b3BfZGlydHlfbG9nIGludG8gc3dpdGNoX2RpcnR5X2xvZy4gKFlpIFN1bikKIC0gTWFpbnRh
aW4gdGhlIGRpcnR5IGxvZyBzdGF0dXMgaW4gaW9tbXVfZG9tYWluLgogLSBVcGRhdGUgY29tbWl0
IG1lc3NhZ2UgdG8gbWFrZSBwYXRjaCBlYXNpZXIgdG8gcmV2aWV3LgoKdjI6CiAtIEFkZHJlc3Mg
YWxsIGNvbW1lbnRzIG9mIFJGQyB2ZXJzaW9uLCB0aGFua3MgZm9yIGFsbCBvZiB5b3UgOy0pCiAt
IEFkZCBhIGJ1Z2ZpeCB0aGF0IHN0YXJ0IGRpcnR5IGxvZyBmb3IgbmV3bHkgYWRkZWQgZG1hIHJh
bmdlcyBhbmQgZG9tYWluLgoKCgpIaSBldmVyeW9uZSwKClRoaXMgcGF0Y2ggc2VyaWVzIGludHJv
ZHVjZXMgYSBmcmFtZXdvcmsgb2YgaW9tbXUgZGlydHkgbG9nIHRyYWNraW5nLCBhbmQgc21tdXYz
CnJlYWxpemVzIHRoaXMgZnJhbWV3b3JrLiBUaGlzIG5ldyBmZWF0dXJlIGNhbiBiZSB1c2VkIGJ5
IFZGSU8gZG1hIGRpcnR5IHRyYWNraW5nLgoKSW50ZW50aW9u77yaCgpTb21lIHR5cGVzIG9mIElP
TU1VIGFyZSBjYXBhYmxlIG9mIHRyYWNraW5nIERNQSBkaXJ0eSBsb2csIHN1Y2ggYXMKQVJNIFNN
TVUgd2l0aCBIVFRVIG9yIEludGVsIElPTU1VIHdpdGggU0xBREUuIFRoaXMgaW50cm9kdWNlcyB0
aGUKZGlydHkgbG9nIHRyYWNraW5nIGZyYW1ld29yayBpbiB0aGUgSU9NTVUgYmFzZSBsYXllci4K
ClRocmVlIG5ldyBlc3NlbnRpYWwgaW50ZXJmYWNlcyBhcmUgYWRkZWQsIGFuZCB3ZSBtYWludGFp
bmNlIHRoZSBzdGF0dXMKb2YgZGlydHkgbG9nIHRyYWNraW5nIGluIGlvbW11X2RvbWFpbi4KMS4g
aW9tbXVfc3dpdGNoX2RpcnR5X2xvZzogUGVyZm9ybSBhY3Rpb25zIHRvIHN0YXJ0fHN0b3AgZGly
dHkgbG9nIHRyYWNraW5nCjIuIGlvbW11X3N5bmNfZGlydHlfbG9nOiBTeW5jIGRpcnR5IGxvZyBm
cm9tIElPTU1VIGludG8gYSBkaXJ0eSBiaXRtYXAKMy4gaW9tbXVfY2xlYXJfZGlydHlfbG9nOiBD
bGVhciBkaXJ0eSBsb2cgb2YgSU9NTVUgYnkgYSBtYXNrIGJpdG1hcAoKQWJvdXQgU01NVSBIVFRV
OgoKSFRUVSAoSGFyZHdhcmUgVHJhbnNsYXRpb24gVGFibGUgVXBkYXRlKSBpcyBhIGZlYXR1cmUg
b2YgQVJNIFNNTVV2MywgaXQgY2FuIHVwZGF0ZQphY2Nlc3MgZmxhZyBvci9hbmQgZGlydHkgc3Rh
dGUgb2YgdGhlIFRURCAoVHJhbnNsYXRpb24gVGFibGUgRGVzY3JpcHRvcikgYnkgaGFyZHdhcmUu
CldpdGggSFRUVSwgc3RhZ2UxIFRURCBpcyBjbGFzc2lmaWVkIGludG8gMyB0eXBlczoKICAgICAg
ICAgICAgICAgICAgICAgICAgREJNIGJpdCAgICAgICAgICAgICBBUFsyXShyZWFkb25seSBiaXQp
CjEuIHdyaXRhYmxlX2NsZWFuICAgICAgICAgMSAgICAgICAgICAgICAgICAgICAgICAgMQoyLiB3
cml0YWJsZV9kaXJ0eSAgICAgICAgIDEgICAgICAgICAgICAgICAgICAgICAgIDAKMy4gcmVhZG9u
bHkgICAgICAgICAgICAgICAwICAgICAgICAgICAgICAgICAgICAgICAxCgpJZiBIVFRVX0hEICht
YW5hZ2UgZGlydHkgc3RhdGUpIGlzIGVuYWJsZWQsIHNtbXUgY2FuIGNoYW5nZSBUVEQgZnJvbSB3
cml0YWJsZV9jbGVhbiB0bwp3cml0YWJsZV9kaXJ0eS4gVGhlbiBzb2Z0d2FyZSBjYW4gc2NhbiBU
VEQgdG8gc3luYyBkaXJ0eSBzdGF0ZSBpbnRvIGRpcnR5IGJpdG1hcC4gV2l0aAp0aGlzIGZlYXR1
cmUsIHdlIGNhbiB0cmFjayB0aGUgZGlydHkgbG9nIG9mIERNQSBjb250aW51b3VzbHkgYW5kIHBy
ZWNpc2VseS4KCkFib3V0IHRoaXMgc2VyaWVzOgoKUGF0Y2ggMS0z77yaSW50cm9kdWNlIGRpcnR5
IGxvZyB0cmFja2luZyBmcmFtZXdvcmsgaW4gdGhlIElPTU1VIGJhc2UgbGF5ZXIsIGFuZCB0d28g
Y29tbW9uCiAgICAgICAgICAgaW50ZXJmYWNlcyB0aGF0IGNhbiBiZSB1c2VkIGJ5IG1hbnkgdHlw
ZXMgb2YgaW9tbXUuCgpQYXRjaCA0LTY6IEFkZCBmZWF0dXJlIGRldGVjdGlvbiBmb3Igc21tdSBI
VFRVIGFuZCBlbmFibGUgSFRUVSBmb3Igc21tdSBzdGFnZTEgbWFwcGluZy4KICAgICAgICAgICBB
bmQgYWRkIGZlYXR1cmUgZGV0ZWN0aW9uIGZvciBzbW11IEJCTUwuIFdlIG5lZWQgdG8gc3BsaXQg
YmxvY2sgbWFwcGluZyB3aGVuCiAgICAgICAgICAgc3RhcnQgZGlydHkgbG9nIHRyYWNraW5nIGFu
ZCBtZXJnZSBwYWdlIG1hcHBpbmcgd2hlbiBzdG9wIGRpcnR5IGxvZyB0cmFja2luZywKCQkgICB3
aGljaCByZXF1aXJlcyBicmVhay1iZWZvcmUtbWFrZSBwcm9jZWR1cmUuIEJ1dCBpdCBtaWdodCBj
YXVzZSBwcm9ibGVtcyB3aGVuIHRoZQoJCSAgIFRURCBpcyBhbGl2ZS4gVGhlIEkvTyBzdHJlYW1z
IG1pZ2h0IG5vdCB0b2xlcmF0ZSB0cmFuc2xhdGlvbiBmYXVsdHMuIFNvIEJCTUwKCQkgICBzaG91
bGQgYmUgdXNlZC4KClBhdGNoIDctMTI6IFdlIGltcGxlbWVudCB0aGVzZSBpbnRlcmZhY2VzIGZv
ciBhcm0gc21tdXYzLgoKVGhhbmtzLApLZXFpYW4KCkplYW4tUGhpbGlwcGUgQnJ1Y2tlciAoMSk6
CiAgaW9tbXUvYXJtLXNtbXUtdjM6IEFkZCBzdXBwb3J0IGZvciBIYXJkd2FyZSBUcmFuc2xhdGlv
biBUYWJsZSBVcGRhdGUKCktlcWlhbiBaaHUgKDEpOgogIGlvbW11OiBJbnRyb2R1Y2UgZGlydHkg
bG9nIHRyYWNraW5nIGZyYW1ld29yawoKS3Vua3VuIEppYW5nICgxMSk6CiAgaW9tbXUvaW8tcGd0
YWJsZS1hcm06IEFkZCBxdWlyayBBUk1fSEQgYW5kIEFSTV9CQk1MeAogIGlvbW11L2lvLXBndGFi
bGUtYXJtOiBBZGQgYW5kIHJlYWxpemUgc3BsaXRfYmxvY2sgb3BzCiAgaW9tbXUvaW8tcGd0YWJs
ZS1hcm06IEFkZCBhbmQgcmVhbGl6ZSBtZXJnZV9wYWdlIG9wcwogIGlvbW11L2lvLXBndGFibGUt
YXJtOiBBZGQgYW5kIHJlYWxpemUgc3luY19kaXJ0eV9sb2cgb3BzCiAgaW9tbXUvaW8tcGd0YWJs
ZS1hcm06IEFkZCBhbmQgcmVhbGl6ZSBjbGVhcl9kaXJ0eV9sb2cgb3BzCiAgaW9tbXUvYXJtLXNt
bXUtdjM6IEVuYWJsZSBIVFRVIGZvciBzdGFnZTEgd2l0aCBpby1wZ3RhYmxlIG1hcHBpbmcKICBp
b21tdS9hcm0tc21tdS12MzogQWRkIGZlYXR1cmUgZGV0ZWN0aW9uIGZvciBCQk1MCiAgaW9tbXUv
YXJtLXNtbXUtdjM6IFJlYWxpemUgc3dpdGNoX2RpcnR5X2xvZyBpb21tdSBvcHMKICBpb21tdS9h
cm0tc21tdS12MzogUmVhbGl6ZSBzeW5jX2RpcnR5X2xvZyBpb21tdSBvcHMKICBpb21tdS9hcm0t
c21tdS12MzogUmVhbGl6ZSBjbGVhcl9kaXJ0eV9sb2cgaW9tbXUgb3BzCiAgaW9tbXUvYXJtLXNt
bXUtdjM6IFJlYWxpemUgc3VwcG9ydF9kaXJ0eV9sb2cgaW9tbXUgb3BzCgogLi4uL2lvbW11L2Fy
bS9hcm0tc21tdS12My9hcm0tc21tdS12My1zdmEuYyAgIHwgICAyICsKIGRyaXZlcnMvaW9tbXUv
YXJtL2FybS1zbW11LXYzL2FybS1zbW11LXYzLmMgICB8IDI2OCArKysrKysrKysrKy0KIGRyaXZl
cnMvaW9tbXUvYXJtL2FybS1zbW11LXYzL2FybS1zbW11LXYzLmggICB8ICAxNCArCiBkcml2ZXJz
L2lvbW11L2lvLXBndGFibGUtYXJtLmMgICAgICAgICAgICAgICAgfCAzODkgKysrKysrKysrKysr
KysrKystCiBkcml2ZXJzL2lvbW11L2lvbW11LmMgICAgICAgICAgICAgICAgICAgICAgICAgfCAy
MDYgKysrKysrKysrLQogaW5jbHVkZS9saW51eC9pby1wZ3RhYmxlLmggICAgICAgICAgICAgICAg
ICAgIHwgIDIzICsrCiBpbmNsdWRlL2xpbnV4L2lvbW11LmggICAgICAgICAgICAgICAgICAgICAg
ICAgfCAgNjUgKysrCiBpbmNsdWRlL3RyYWNlL2V2ZW50cy9pb21tdS5oICAgICAgICAgICAgICAg
ICAgfCAgNjMgKysrCiA4IGZpbGVzIGNoYW5nZWQsIDEwMjYgaW5zZXJ0aW9ucygrKSwgNCBkZWxl
dGlvbnMoLSkKCi0tIAoyLjE5LjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0
aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5m
by9pb21tdQ==
