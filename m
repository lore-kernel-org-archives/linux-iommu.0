Return-Path: <SRS0=kCyf=II=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0EDEC433E6
	for <iommu@archiver.kernel.org>; Wed, 10 Mar 2021 09:07:01 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52AC765005
	for <iommu@archiver.kernel.org>; Wed, 10 Mar 2021 09:07:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52AC765005
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2CE35431AA;
	Wed, 10 Mar 2021 09:07:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YuI0K1F2PRnZ; Wed, 10 Mar 2021 09:06:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id CD976431A0;
	Wed, 10 Mar 2021 09:06:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3402BC0017;
	Wed, 10 Mar 2021 09:06:58 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3025FC000A
 for <iommu@lists.linux-foundation.org>; Wed, 10 Mar 2021 09:06:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0DAAA4EBBF
 for <iommu@lists.linux-foundation.org>; Wed, 10 Mar 2021 09:06:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cGgjNWe8n8GG for <iommu@lists.linux-foundation.org>;
 Wed, 10 Mar 2021 09:06:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0F4814C65F
 for <iommu@lists.linux-foundation.org>; Wed, 10 Mar 2021 09:06:53 +0000 (UTC)
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
 by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DwR3z0FyyzrTKc;
 Wed, 10 Mar 2021 17:05:03 +0800 (CST)
Received: from DESKTOP-5IS4806.china.huawei.com (10.174.184.42) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.498.0; Wed, 10 Mar 2021 17:06:17 +0800
From: Keqian Zhu <zhukeqian1@huawei.com>
To: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <iommu@lists.linux-foundation.org>, Alex Williamson
 <alex.williamson@redhat.com>, Robin Murphy <robin.murphy@arm.com>, Yi Sun
 <yi.y.sun@linux.intel.com>, Will Deacon <will@kernel.org>
Subject: [PATCH v2 00/11] vfio/iommu_type1: Implement dirty log tracking based
 on smmuv3 HTTU
Date: Wed, 10 Mar 2021 17:06:03 +0800
Message-ID: <20210310090614.26668-1-zhukeqian1@huawei.com>
X-Mailer: git-send-email 2.8.4.windows.1
MIME-Version: 1.0
X-Originating-IP: [10.174.184.42]
X-CFilter-Loop: Reflected
Cc: Mark Rutland <mark.rutland@arm.com>, jiangkunkun@huawei.com,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Marc Zyngier <maz@kernel.org>,
 Cornelia Huck <cohuck@redhat.com>, lushenming@huawei.com,
 Kirti Wankhede <kwankhede@nvidia.com>, James Morse <james.morse@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, wanghaibin.wang@huawei.com
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

SGkgYWxsLAoKVGhpcyBwYXRjaCBzZXJpZXMgaW1wbGVtZW50IHZmaW8gZG1hIGRpcnR5IGxvZyB0
cmFja2luZyBiYXNlZCBvbiBzbW11djMgSFRUVS4KCmNoYW5nZWxvZzoKCnYyOgogLSBBZGRyZXNz
IGFsbCBjb21tZW50cyBvZiBSRkMgdmVyc2lvbiwgdGhhbmtzIGZvciBhbGwgb2YgeW91IDstKQog
LSBBZGQgYSBidWdmaXggdGhhdCBzdGFydCBkaXJ0eSBsb2cgZm9yIG5ld2x5IGFkZGVkIGRtYSBy
YW5nZXMgYW5kIGRvbWFpbi4KCkludGVudGlvbu+8mgoKQXMgd2Uga25vdywgdmZpbyBsaXZlIG1p
Z3JhdGlvbiBpcyBhbiBpbXBvcnRhbnQgYW5kIHZhbHVhYmxlIGZlYXR1cmUsIGJ1dCB0aGVyZQph
cmUgc3RpbGwgbWFueSBodXJkbGVzIHRvIHNvbHZlLCBpbmNsdWRpbmcgbWlncmF0aW9uIG9mIGlu
dGVycnVwdCwgZGV2aWNlIHN0YXRlLApETUEgZGlydHkgbG9nIHRyYWNraW5nLCBhbmQgZXRjLgoK
Rm9yIG5vdywgdGhlIG9ubHkgZGlydHkgbG9nIHRyYWNraW5nIGludGVyZmFjZSBpcyBwaW5uaW5n
LiBJdCBoYXMgc29tZSBkcmF3YmFja3M6CjEuIE9ubHkgc21hcnQgdmVuZG9yIGRyaXZlcnMgYXJl
IGF3YXJlIG9mIHRoaXMuCjIuIEl0J3MgY29hcnNlLWdyYWluZWQsIHRoZSBwaW5uZWQtc2NvcGUg
aXMgZ2VuZXJhbGx5IGJpZ2dlciB0aGFuIHdoYXQgdGhlIGRldmljZSBhY3R1YWxseSBhY2Nlc3Mu
CjMuIEl0IGNhbid0IHRyYWNrIGRpcnR5IGNvbnRpbnVvdXNseSBhbmQgcHJlY2lzZWx5LCB2Zmlv
IHBvcHVsYXRlcyBhbGwgcGlubmVkLXNjb3BlIGFzIGRpcnR5LgogICBTbyBpdCBkb2Vzbid0IHdv
cmsgd2VsbCB3aXRoIGl0ZXJhdGl2ZWx5IGRpcnR5IGxvZyBoYW5kbGluZy4KCkFib3V0IFNNTVUg
SFRUVToKCkhUVFUgKEhhcmR3YXJlIFRyYW5zbGF0aW9uIFRhYmxlIFVwZGF0ZSkgaXMgYSBmZWF0
dXJlIG9mIEFSTSBTTU1VdjMsIGl0IGNhbiB1cGRhdGUKYWNjZXNzIGZsYWcgb3IvYW5kIGRpcnR5
IHN0YXRlIG9mIHRoZSBUVEQgKFRyYW5zbGF0aW9uIFRhYmxlIERlc2NyaXB0b3IpIGJ5IGhhcmR3
YXJlLgpXaXRoIEhUVFUsIHN0YWdlMSBUVEQgaXMgY2xhc3NpZmllZCBpbnRvIDMgdHlwZXM6CiAg
ICAgICAgICAgICAgICAgICAgICAgIERCTSBiaXQgICAgICAgICAgICAgQVBbMl0ocmVhZG9ubHkg
Yml0KQoxLiB3cml0YWJsZV9jbGVhbiAgICAgICAgIDEgICAgICAgICAgICAgICAgICAgICAgIDEK
Mi4gd3JpdGFibGVfZGlydHkgICAgICAgICAxICAgICAgICAgICAgICAgICAgICAgICAwCjMuIHJl
YWRvbmx5ICAgICAgICAgICAgICAgMCAgICAgICAgICAgICAgICAgICAgICAgMQoKSWYgSFRUVV9I
RCAobWFuYWdlIGRpcnR5IHN0YXRlKSBpcyBlbmFibGVkLCBzbW11IGNhbiBjaGFuZ2UgVFREIGZy
b20gd3JpdGFibGVfY2xlYW4gdG8Kd3JpdGFibGVfZGlydHkuIFRoZW4gc29mdHdhcmUgY2FuIHNj
YW4gVFREIHRvIHN5bmMgZGlydHkgc3RhdGUgaW50byBkaXJ0eSBiaXRtYXAuIFdpdGgKdGhpcyBm
ZWF0dXJlLCB3ZSBjYW4gdHJhY2sgdGhlIGRpcnR5IGxvZyBvZiBETUEgY29udGludW91c2x5IGFu
ZCBwcmVjaXNlbHkuCgpBYm91dCB0aGlzIHNlcmllczoKClBhdGNoIDEtMzogQWRkIGZlYXR1cmUg
ZGV0ZWN0aW9uIGZvciBzbW11IEhUVFUgYW5kIGVuYWJsZSBIVFRVIGZvciBzbW11IHN0YWdlMSBt
YXBwaW5nLgogICAgICAgICAgIEFuZCBhZGQgZmVhdHVyZSBkZXRlY3Rpb24gZm9yIHNtbXUgQkJN
TC4gV2UgbmVlZCB0byBzcGxpdCBibG9jayBtYXBwaW5nIHdoZW4KICAgICAgICAgICBzdGFydCBk
aXJ0eSBsb2cgdHJhY2tpbmcgYW5kIG1lcmdlIHBhZ2UgbWFwcGluZyB3aGVuIHN0b3AgZGlydHkg
bG9nIHRyYWNraW5nLAoJCSAgIHdoaWNoIHJlcXVpcmVzIGJyZWFrLWJlZm9yZS1tYWtlIHByb2Nl
ZHVyZS4gQnV0IGl0IG1pZ2h0IGNhdXNlIHByb2JsZW1zIHdoZW4gdGhlCgkJICAgVFREIGlzIGFs
aXZlLiBUaGUgSS9PIHN0cmVhbXMgbWlnaHQgbm90IHRvbGVyYXRlIHRyYW5zbGF0aW9uIGZhdWx0
cy4gU28gQkJNTAoJCSAgIHNob3VsZCBiZSB1c2VkLgoKUGF0Y2ggNC03OiBBZGQgZm91ciBpbnRl
cmZhY2VzIChzdGFydF9kaXJ0eV9sb2csIHN0b3BfZGlydHlfbG9nLCBzeW5jX2RpcnR5X2xvZyBh
bmQgY2xlYXJfZGlydHlfbG9nKQogICAgICAgICAgIGluIElPTU1VIGxheWVyLCB0aGV5IGFyZSBl
c3NlbnRpYWwgdG8gaW1wbGVtZW50IGRtYSBkaXJ0eSBsb2cgdHJhY2tpbmcgZm9yIHZmaW8uCgkJ
ICAgV2UgaW1wbGVtZW50IHRoZXNlIGludGVyZmFjZXMgZm9yIGFybSBzbW11djMuCgpQYXRjaCAg
IDg6IEFkZCBIV0RCTSAoSGFyZHdhcmUgRGlydHkgQml0IE1hbmFnZW1lbnQpIGRldmljZSBmZWF0
dXJlIHJlcG9ydGluZyBpbiBJT01NVSBsYXllci4KClBhdGNoOS0xMTogSW1wbGVtZW50IGEgbmV3
IGRpcnR5IGxvZyB0cmFja2luZyBtZXRob2QgZm9yIHZmaW8gYmFzZWQgb24gaW9tbXUgaHdkYm0u
IEEgbmV3CiAgICAgICAgICAgaW9jdGwgb3BlcmF0aW9uIG5hbWVkIFZGSU9fRElSVFlfTE9HX01B
TlVBTF9DTEVBUiBpcyBhZGRlZCwgd2hpY2ggY2FuIGVsaW1pbmF0ZQoJCSAgIHNvbWUgcmVkdW5k
YW50IGRpcnR5IGhhbmRsaW5nIG9mIHVzZXJzcGFjZS4KCk9wdGltaXphdGlvbnMgVE8gRG86Cgox
LiBXZSByZWNvZ25pemVkIHRoYXQgZWFjaCBzbW11X2RvbWFpbiAoYSB2ZmlvX2NvbnRhaW5lciBt
YXkgaGFzIHNldmVyYWwgc21tdV9kb21haW4pIGhhcyBpdHMKICAgb3duIHN0YWdlMSBtYXBwaW5n
LCBhbmQgd2UgbXVzdCBzY2FuIGFsbCB0aGVzZSBtYXBwaW5nIHRvIHN5bmMgZGlydHkgc3RhdGUu
IFdlIHBsYW4gdG8gcmVmYWN0b3IKICAgc21tdV9kb21haW4gdG8gc3VwcG9ydCBtb3JlIHRoYW4g
b25lIHNtbXUgaW4gb25lIHNtbXVfZG9tYWluLCB0aGVuIHRoZXNlIHNtbXVzIGNhbiBzaGFyZSBh
IHNhbWUKICAgc3RhZ2UxIG1hcHBpbmcuCjIuIFdlIGFsc28gcmVjb2duaXplZCB0aGF0IHNjYW4g
VFREIGlzIGEgaG90c3BvdCBvZiBwZXJmb3JtYW5jZS4gUmVjZW50bHksIEkgaGF2ZSBpbXBsZW1l
bnQgYQogICBTVy9IVyBjb25iaW5lZCBkaXJ0eSBsb2cgdHJhY2tpbmcgYXQgTU1VIHNpZGUgWzFd
LCB3aGljaCBjYW4gZWZmZWN0aXZlbHkgc29sdmUgdGhpcyBwcm9ibGVtLgogICBUaGlzIGlkZWEg
Y2FuIGJlIGFwcGxpZWQgdG8gc21tdSBzaWRlIHRvby4KClRoYW5rcywKS2VxaWFuCgoKWzFdIGh0
dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LWFybS1rZXJuZWwvMjAyMTAxMjYxMjQ0NDQuMjcx
MzYtMS16aHVrZXFpYW4xQGh1YXdlaS5jb20vCgpKZWFuLVBoaWxpcHBlIEJydWNrZXIgKDEpOgog
IGlvbW11L2FybS1zbW11LXYzOiBBZGQgc3VwcG9ydCBmb3IgSGFyZHdhcmUgVHJhbnNsYXRpb24g
VGFibGUgVXBkYXRlCgpqaWFuZ2t1bmt1biAoMTApOgogIGlvbW11L2FybS1zbW11LXYzOiBFbmFi
bGUgSFRUVSBmb3Igc3RhZ2UxIHdpdGggaW8tcGd0YWJsZSBtYXBwaW5nCiAgaW9tbXUvYXJtLXNt
bXUtdjM6IEFkZCBmZWF0dXJlIGRldGVjdGlvbiBmb3IgQkJNTAogIGlvbW11L2FybS1zbW11LXYz
OiBTcGxpdCBibG9jayBkZXNjcmlwdG9yIHdoZW4gc3RhcnQgZGlydHkgbG9nCiAgaW9tbXUvYXJt
LXNtbXUtdjM6IE1lcmdlIGEgc3BhbiBvZiBwYWdlIHdoZW4gc3RvcCBkaXJ0eSBsb2cKICBpb21t
dS9hcm0tc21tdS12MzogU2NhbiBsZWFmIFRURCB0byBzeW5jIGhhcmR3YXJlIGRpcnR5IGxvZwog
IGlvbW11L2FybS1zbW11LXYzOiBDbGVhciBkaXJ0eSBsb2cgYWNjb3JkaW5nIHRvIGJpdG1hcAog
IGlvbW11L2FybS1zbW11LXYzOiBBZGQgSFdEQk0gZGV2aWNlIGZlYXR1cmUgcmVwb3J0aW5nCiAg
dmZpby9pb21tdV90eXBlMTogQWRkIEhXREJNIHN0YXR1cyBtYWludGFuYW5jZQogIHZmaW8vaW9t
bXVfdHlwZTE6IE9wdGltaXplIGRpcnR5IGJpdG1hcCBwb3B1bGF0aW9uIGJhc2VkIG9uIGlvbW11
CiAgICBIV0RCTQogIHZmaW8vaW9tbXVfdHlwZTE6IEFkZCBzdXBwb3J0IGZvciBtYW51YWwgZGly
dHkgbG9nIGNsZWFyCgogLi4uL2lvbW11L2FybS9hcm0tc21tdS12My9hcm0tc21tdS12My1zdmEu
YyAgIHwgICAyICsKIGRyaXZlcnMvaW9tbXUvYXJtL2FybS1zbW11LXYzL2FybS1zbW11LXYzLmMg
ICB8IDIyNiArKysrKysrKystCiBkcml2ZXJzL2lvbW11L2FybS9hcm0tc21tdS12My9hcm0tc21t
dS12My5oICAgfCAgMTQgKwogZHJpdmVycy9pb21tdS9pby1wZ3RhYmxlLWFybS5jICAgICAgICAg
ICAgICAgIHwgMzkyICsrKysrKysrKysrKysrKysrLQogZHJpdmVycy9pb21tdS9pb21tdS5jICAg
ICAgICAgICAgICAgICAgICAgICAgIHwgMjM2ICsrKysrKysrKysrCiBkcml2ZXJzL3ZmaW8vdmZp
b19pb21tdV90eXBlMS5jICAgICAgICAgICAgICAgfCAyNzAgKysrKysrKysrKystCiBpbmNsdWRl
L2xpbnV4L2lvLXBndGFibGUuaCAgICAgICAgICAgICAgICAgICAgfCAgMjMgKwogaW5jbHVkZS9s
aW51eC9pb21tdS5oICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDg0ICsrKysKIGluY2x1ZGUv
dWFwaS9saW51eC92ZmlvLmggICAgICAgICAgICAgICAgICAgICB8ICAyOCArLQogOSBmaWxlcyBj
aGFuZ2VkLCAxMjY0IGluc2VydGlvbnMoKyksIDExIGRlbGV0aW9ucygtKQoKLS0gCjIuMTkuMQoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFp
bGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMu
bGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
