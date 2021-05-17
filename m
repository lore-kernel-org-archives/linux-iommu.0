Return-Path: <SRS0=Mf8z=KM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE25DC433ED
	for <iommu@archiver.kernel.org>; Mon, 17 May 2021 08:47:05 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 638D361166
	for <iommu@archiver.kernel.org>; Mon, 17 May 2021 08:47:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 638D361166
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 293B260663;
	Mon, 17 May 2021 08:47:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0TGTTS6BEGt8; Mon, 17 May 2021 08:47:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id EA53C60724;
	Mon, 17 May 2021 08:47:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C408AC000D;
	Mon, 17 May 2021 08:47:03 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2DBC5C0001
 for <iommu@lists.linux-foundation.org>; Mon, 17 May 2021 08:47:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1B957400C4
 for <iommu@lists.linux-foundation.org>; Mon, 17 May 2021 08:47:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id F5Kk1ipc-KE5 for <iommu@lists.linux-foundation.org>;
 Mon, 17 May 2021 08:47:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5293C400F6
 for <iommu@lists.linux-foundation.org>; Mon, 17 May 2021 08:47:01 +0000 (UTC)
Received: from dggems701-chm.china.huawei.com (unknown [172.30.72.59])
 by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4FkCP65NDKzmWsc;
 Mon, 17 May 2021 16:44:42 +0800 (CST)
Received: from dggpemm000003.china.huawei.com (7.185.36.128) by
 dggems701-chm.china.huawei.com (10.3.19.178) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 17 May 2021 16:46:57 +0800
Received: from [10.174.187.224] (10.174.187.224) by
 dggpemm000003.china.huawei.com (7.185.36.128) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 17 May 2021 16:46:56 +0800
Subject: Re: [RFC PATCH v4 00/13] iommu/smmuv3: Implement hardware dirty log
 tracking
To: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <iommu@lists.linux-foundation.org>, Robin Murphy <robin.murphy@arm.com>,
 "Will Deacon" <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
 "Jean-Philippe Brucker" <jean-philippe@linaro.org>, Lu Baolu
 <baolu.lu@linux.intel.com>, "Yi Sun" <yi.y.sun@linux.intel.com>, Tian Kevin
 <kevin.tian@intel.com>
References: <20210507102211.8836-1-zhukeqian1@huawei.com>
From: Keqian Zhu <zhukeqian1@huawei.com>
Message-ID: <18952c29-4400-55a6-de0a-c17f5bd4f13a@huawei.com>
Date: Mon, 17 May 2021 16:46:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20210507102211.8836-1-zhukeqian1@huawei.com>
X-Originating-IP: [10.174.187.224]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm000003.china.huawei.com (7.185.36.128)
X-CFilter-Loop: Reflected
Cc: Cornelia Huck <cohuck@redhat.com>, jiangkunkun@huawei.com,
 Alex Williamson <alex.williamson@redhat.com>, lushenming@huawei.com, Kirti
 Wankhede <kwankhede@nvidia.com>, wanghaibin.wang@huawei.com
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

SGkgYWxsLAoKVGhlIFZGSU8gcGFydCBpcyBhdCBoZXJlOiBodHRwczovL2xvcmUua2VybmVsLm9y
Zy9rdm0vMjAyMTA1MDcxMDM2MDguMzk0NDAtMS16aHVrZXFpYW4xQGh1YXdlaS5jb20vCgpUaGFu
a3MsCktlcWlhbgoKT24gMjAyMS81LzcgMTg6MjEsIEtlcWlhbiBaaHUgd3JvdGU6Cj4gSGkgUm9i
aW4sIFdpbGwgYW5kIGV2ZXJ5b25lLAo+IAo+IEkgdGhpbmsgdGhpcyBzZXJpZXMgaXMgcmVsYXRp
dmUgbWF0dXJlIG5vdywgcGxlYXNlIGdpdmUgeW91ciB2YWx1YWJsZSBzdWdnZXN0aW9ucywKPiB0
aGFua3MhCj4gCj4gCj4gVGhpcyBwYXRjaCBzZXJpZXMgaXMgc3BsaXQgZnJvbSB0aGUgc2VyaWVz
WzFdIHRoYXQgY29udGFpbmVzIGJvdGggSU9NTVUgcGFydCBhbmQKPiBWRklPIHBhcnQuIFRoZSBW
RklPIHBhcnQgd2lsbCBiZSBzZW50IG91dCBpbiBhbm90aGVyIHNlcmllcy4KPiAKPiBbMV0gaHR0
cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtaW9tbXUvMjAyMTAzMTAwOTA2MTQuMjY2NjgtMS16
aHVrZXFpYW4xQGh1YXdlaS5jb20vCj4gCj4gY2hhbmdlbG9nOgo+IAo+IHY0Ogo+ICAtIE1vZGlm
eSB0aGUgZnJhbWV3b3JrIGFzIHN1Z2dlc3RlZCBieSBCYW9sdSwgdGhhbmtzIQo+ICAtIEFkZCB0
cmFjZSBmb3IgaW9tbXUgb3BzLgo+ICAtIEV4dHJhY3QgaW8tcGd0YWJsZSBwYXJ0Lgo+IAo+IHYz
Ogo+ICAtIE1lcmdlIHN0YXJ0X2RpcnR5X2xvZyBhbmQgc3RvcF9kaXJ0eV9sb2cgaW50byBzd2l0
Y2hfZGlydHlfbG9nLiAoWWkgU3VuKQo+ICAtIE1haW50YWluIHRoZSBkaXJ0eSBsb2cgc3RhdHVz
IGluIGlvbW11X2RvbWFpbi4KPiAgLSBVcGRhdGUgY29tbWl0IG1lc3NhZ2UgdG8gbWFrZSBwYXRj
aCBlYXNpZXIgdG8gcmV2aWV3Lgo+IAo+IHYyOgo+ICAtIEFkZHJlc3MgYWxsIGNvbW1lbnRzIG9m
IFJGQyB2ZXJzaW9uLCB0aGFua3MgZm9yIGFsbCBvZiB5b3UgOy0pCj4gIC0gQWRkIGEgYnVnZml4
IHRoYXQgc3RhcnQgZGlydHkgbG9nIGZvciBuZXdseSBhZGRlZCBkbWEgcmFuZ2VzIGFuZCBkb21h
aW4uCj4gCj4gCj4gCj4gSGkgZXZlcnlvbmUsCj4gCj4gVGhpcyBwYXRjaCBzZXJpZXMgaW50cm9k
dWNlcyBhIGZyYW1ld29yayBvZiBpb21tdSBkaXJ0eSBsb2cgdHJhY2tpbmcsIGFuZCBzbW11djMK
PiByZWFsaXplcyB0aGlzIGZyYW1ld29yay4gVGhpcyBuZXcgZmVhdHVyZSBjYW4gYmUgdXNlZCBi
eSBWRklPIGRtYSBkaXJ0eSB0cmFja2luZy4KPiAKPiBJbnRlbnRpb27vvJoKPiAKPiBTb21lIHR5
cGVzIG9mIElPTU1VIGFyZSBjYXBhYmxlIG9mIHRyYWNraW5nIERNQSBkaXJ0eSBsb2csIHN1Y2gg
YXMKPiBBUk0gU01NVSB3aXRoIEhUVFUgb3IgSW50ZWwgSU9NTVUgd2l0aCBTTEFERS4gVGhpcyBp
bnRyb2R1Y2VzIHRoZQo+IGRpcnR5IGxvZyB0cmFja2luZyBmcmFtZXdvcmsgaW4gdGhlIElPTU1V
IGJhc2UgbGF5ZXIuCj4gCj4gVGhyZWUgbmV3IGVzc2VudGlhbCBpbnRlcmZhY2VzIGFyZSBhZGRl
ZCwgYW5kIHdlIG1haW50YWluY2UgdGhlIHN0YXR1cwo+IG9mIGRpcnR5IGxvZyB0cmFja2luZyBp
biBpb21tdV9kb21haW4uCj4gMS4gaW9tbXVfc3dpdGNoX2RpcnR5X2xvZzogUGVyZm9ybSBhY3Rp
b25zIHRvIHN0YXJ0fHN0b3AgZGlydHkgbG9nIHRyYWNraW5nCj4gMi4gaW9tbXVfc3luY19kaXJ0
eV9sb2c6IFN5bmMgZGlydHkgbG9nIGZyb20gSU9NTVUgaW50byBhIGRpcnR5IGJpdG1hcAo+IDMu
IGlvbW11X2NsZWFyX2RpcnR5X2xvZzogQ2xlYXIgZGlydHkgbG9nIG9mIElPTU1VIGJ5IGEgbWFz
ayBiaXRtYXAKPiAKPiBBYm91dCBTTU1VIEhUVFU6Cj4gCj4gSFRUVSAoSGFyZHdhcmUgVHJhbnNs
YXRpb24gVGFibGUgVXBkYXRlKSBpcyBhIGZlYXR1cmUgb2YgQVJNIFNNTVV2MywgaXQgY2FuIHVw
ZGF0ZQo+IGFjY2VzcyBmbGFnIG9yL2FuZCBkaXJ0eSBzdGF0ZSBvZiB0aGUgVFREIChUcmFuc2xh
dGlvbiBUYWJsZSBEZXNjcmlwdG9yKSBieSBoYXJkd2FyZS4KPiBXaXRoIEhUVFUsIHN0YWdlMSBU
VEQgaXMgY2xhc3NpZmllZCBpbnRvIDMgdHlwZXM6Cj4gICAgICAgICAgICAgICAgICAgICAgICAg
REJNIGJpdCAgICAgICAgICAgICBBUFsyXShyZWFkb25seSBiaXQpCj4gMS4gd3JpdGFibGVfY2xl
YW4gICAgICAgICAxICAgICAgICAgICAgICAgICAgICAgICAxCj4gMi4gd3JpdGFibGVfZGlydHkg
ICAgICAgICAxICAgICAgICAgICAgICAgICAgICAgICAwCj4gMy4gcmVhZG9ubHkgICAgICAgICAg
ICAgICAwICAgICAgICAgICAgICAgICAgICAgICAxCj4gCj4gSWYgSFRUVV9IRCAobWFuYWdlIGRp
cnR5IHN0YXRlKSBpcyBlbmFibGVkLCBzbW11IGNhbiBjaGFuZ2UgVFREIGZyb20gd3JpdGFibGVf
Y2xlYW4gdG8KPiB3cml0YWJsZV9kaXJ0eS4gVGhlbiBzb2Z0d2FyZSBjYW4gc2NhbiBUVEQgdG8g
c3luYyBkaXJ0eSBzdGF0ZSBpbnRvIGRpcnR5IGJpdG1hcC4gV2l0aAo+IHRoaXMgZmVhdHVyZSwg
d2UgY2FuIHRyYWNrIHRoZSBkaXJ0eSBsb2cgb2YgRE1BIGNvbnRpbnVvdXNseSBhbmQgcHJlY2lz
ZWx5Lgo+IAo+IEFib3V0IHRoaXMgc2VyaWVzOgo+IAo+IFBhdGNoIDEtM++8mkludHJvZHVjZSBk
aXJ0eSBsb2cgdHJhY2tpbmcgZnJhbWV3b3JrIGluIHRoZSBJT01NVSBiYXNlIGxheWVyLCBhbmQg
dHdvIGNvbW1vbgo+ICAgICAgICAgICAgaW50ZXJmYWNlcyB0aGF0IGNhbiBiZSB1c2VkIGJ5IG1h
bnkgdHlwZXMgb2YgaW9tbXUuCj4gCj4gUGF0Y2ggNC02OiBBZGQgZmVhdHVyZSBkZXRlY3Rpb24g
Zm9yIHNtbXUgSFRUVSBhbmQgZW5hYmxlIEhUVFUgZm9yIHNtbXUgc3RhZ2UxIG1hcHBpbmcuCj4g
ICAgICAgICAgICBBbmQgYWRkIGZlYXR1cmUgZGV0ZWN0aW9uIGZvciBzbW11IEJCTUwuIFdlIG5l
ZWQgdG8gc3BsaXQgYmxvY2sgbWFwcGluZyB3aGVuCj4gICAgICAgICAgICBzdGFydCBkaXJ0eSBs
b2cgdHJhY2tpbmcgYW5kIG1lcmdlIHBhZ2UgbWFwcGluZyB3aGVuIHN0b3AgZGlydHkgbG9nIHRy
YWNraW5nLAo+IAkJICAgd2hpY2ggcmVxdWlyZXMgYnJlYWstYmVmb3JlLW1ha2UgcHJvY2VkdXJl
LiBCdXQgaXQgbWlnaHQgY2F1c2UgcHJvYmxlbXMgd2hlbiB0aGUKPiAJCSAgIFRURCBpcyBhbGl2
ZS4gVGhlIEkvTyBzdHJlYW1zIG1pZ2h0IG5vdCB0b2xlcmF0ZSB0cmFuc2xhdGlvbiBmYXVsdHMu
IFNvIEJCTUwKPiAJCSAgIHNob3VsZCBiZSB1c2VkLgo+IAo+IFBhdGNoIDctMTI6IFdlIGltcGxl
bWVudCB0aGVzZSBpbnRlcmZhY2VzIGZvciBhcm0gc21tdXYzLgo+IAo+IFRoYW5rcywKPiBLZXFp
YW4KPiAKPiBKZWFuLVBoaWxpcHBlIEJydWNrZXIgKDEpOgo+ICAgaW9tbXUvYXJtLXNtbXUtdjM6
IEFkZCBzdXBwb3J0IGZvciBIYXJkd2FyZSBUcmFuc2xhdGlvbiBUYWJsZSBVcGRhdGUKPiAKPiBL
ZXFpYW4gWmh1ICgxKToKPiAgIGlvbW11OiBJbnRyb2R1Y2UgZGlydHkgbG9nIHRyYWNraW5nIGZy
YW1ld29yawo+IAo+IEt1bmt1biBKaWFuZyAoMTEpOgo+ICAgaW9tbXUvaW8tcGd0YWJsZS1hcm06
IEFkZCBxdWlyayBBUk1fSEQgYW5kIEFSTV9CQk1MeAo+ICAgaW9tbXUvaW8tcGd0YWJsZS1hcm06
IEFkZCBhbmQgcmVhbGl6ZSBzcGxpdF9ibG9jayBvcHMKPiAgIGlvbW11L2lvLXBndGFibGUtYXJt
OiBBZGQgYW5kIHJlYWxpemUgbWVyZ2VfcGFnZSBvcHMKPiAgIGlvbW11L2lvLXBndGFibGUtYXJt
OiBBZGQgYW5kIHJlYWxpemUgc3luY19kaXJ0eV9sb2cgb3BzCj4gICBpb21tdS9pby1wZ3RhYmxl
LWFybTogQWRkIGFuZCByZWFsaXplIGNsZWFyX2RpcnR5X2xvZyBvcHMKPiAgIGlvbW11L2FybS1z
bW11LXYzOiBFbmFibGUgSFRUVSBmb3Igc3RhZ2UxIHdpdGggaW8tcGd0YWJsZSBtYXBwaW5nCj4g
ICBpb21tdS9hcm0tc21tdS12MzogQWRkIGZlYXR1cmUgZGV0ZWN0aW9uIGZvciBCQk1MCj4gICBp
b21tdS9hcm0tc21tdS12MzogUmVhbGl6ZSBzd2l0Y2hfZGlydHlfbG9nIGlvbW11IG9wcwo+ICAg
aW9tbXUvYXJtLXNtbXUtdjM6IFJlYWxpemUgc3luY19kaXJ0eV9sb2cgaW9tbXUgb3BzCj4gICBp
b21tdS9hcm0tc21tdS12MzogUmVhbGl6ZSBjbGVhcl9kaXJ0eV9sb2cgaW9tbXUgb3BzCj4gICBp
b21tdS9hcm0tc21tdS12MzogUmVhbGl6ZSBzdXBwb3J0X2RpcnR5X2xvZyBpb21tdSBvcHMKPiAK
PiAgLi4uL2lvbW11L2FybS9hcm0tc21tdS12My9hcm0tc21tdS12My1zdmEuYyAgIHwgICAyICsK
PiAgZHJpdmVycy9pb21tdS9hcm0vYXJtLXNtbXUtdjMvYXJtLXNtbXUtdjMuYyAgIHwgMjY4ICsr
KysrKysrKysrLQo+ICBkcml2ZXJzL2lvbW11L2FybS9hcm0tc21tdS12My9hcm0tc21tdS12My5o
ICAgfCAgMTQgKwo+ICBkcml2ZXJzL2lvbW11L2lvLXBndGFibGUtYXJtLmMgICAgICAgICAgICAg
ICAgfCAzODkgKysrKysrKysrKysrKysrKystCj4gIGRyaXZlcnMvaW9tbXUvaW9tbXUuYyAgICAg
ICAgICAgICAgICAgICAgICAgICB8IDIwNiArKysrKysrKystCj4gIGluY2x1ZGUvbGludXgvaW8t
cGd0YWJsZS5oICAgICAgICAgICAgICAgICAgICB8ICAyMyArKwo+ICBpbmNsdWRlL2xpbnV4L2lv
bW11LmggICAgICAgICAgICAgICAgICAgICAgICAgfCAgNjUgKysrCj4gIGluY2x1ZGUvdHJhY2Uv
ZXZlbnRzL2lvbW11LmggICAgICAgICAgICAgICAgICB8ICA2MyArKysKPiAgOCBmaWxlcyBjaGFu
Z2VkLCAxMDI2IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pCj4gCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21t
dUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlv
bi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
