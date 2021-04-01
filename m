Return-Path: <SRS0=bVsO=I6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 646CFC433B4
	for <iommu@archiver.kernel.org>; Thu,  1 Apr 2021 03:29:07 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A517360FE8
	for <iommu@archiver.kernel.org>; Thu,  1 Apr 2021 03:29:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A517360FE8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5A4F160784;
	Thu,  1 Apr 2021 03:29:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Fv2ykkFGzUEL; Thu,  1 Apr 2021 03:29:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1CDC3606E5;
	Thu,  1 Apr 2021 03:29:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 051A3C000C;
	Thu,  1 Apr 2021 03:29:05 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5C64DC000A
 for <iommu@lists.linux-foundation.org>; Thu,  1 Apr 2021 03:29:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4364A405A0
 for <iommu@lists.linux-foundation.org>; Thu,  1 Apr 2021 03:29:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KXm3RklMdGGZ for <iommu@lists.linux-foundation.org>;
 Thu,  1 Apr 2021 03:29:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 59C7940569
 for <iommu@lists.linux-foundation.org>; Thu,  1 Apr 2021 03:29:00 +0000 (UTC)
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
 by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4F9pWb2Jnwz9vHf;
 Thu,  1 Apr 2021 11:26:51 +0800 (CST)
Received: from [127.0.0.1] (10.40.193.166) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.498.0; Thu, 1 Apr 2021
 11:28:51 +0800
Subject: Re: [RFC PATCH 0/5] Optimization for unmapping iommu mapped buffers
To: "Isaac J. Manjarres" <isaacm@codeaurora.org>,
 <iommu@lists.linux-foundation.org>, <linux-arm-kernel@lists.infradead.org>
References: <20210331030042.13348-1-isaacm@codeaurora.org>
From: "chenxiang (M)" <chenxiang66@hisilicon.com>
Message-ID: <8d8e0c37-95f7-4d24-a4eb-a4b10f771c6a@hisilicon.com>
Date: Thu, 1 Apr 2021 11:28:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20210331030042.13348-1-isaacm@codeaurora.org>
X-Originating-IP: [10.40.193.166]
X-CFilter-Loop: Reflected
Cc: robin.murphy@arm.com, will@kernel.org, linuxarm@huawei.com,
 pratikp@codeaurora.org
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

SGkgSXNhYWMsCgoK5ZyoIDIwMjEvMy8zMSAxMTowMCwgSXNhYWMgSi4gTWFuamFycmVzIOWGmemB
kzoKPiBXaGVuIHVubWFwcGluZyBhIGJ1ZmZlciBmcm9tIGFuIElPTU1VIGRvbWFpbiwgdGhlIElP
TU1VIGZyYW1ld29yayB1bm1hcHMKPiB0aGUgYnVmZmVyIGF0IGEgZ3JhbnVsZSBvZiB0aGUgbGFy
Z2VzdCBwYWdlIHNpemUgdGhhdCBpcyBzdXBwb3J0ZWQgYnkKPiB0aGUgSU9NTVUgaGFyZHdhcmUg
YW5kIGZpdHMgd2l0aGluIHRoZSBidWZmZXIuIEZvciBldmVyeSBibG9jayB0aGF0Cj4gaXMgdW5t
YXBwZWQsIHRoZSBJT01NVSBmcmFtZXdvcmsgd2lsbCBjYWxsIGludG8gdGhlIElPTU1VIGRyaXZl
ciwgYW5kCj4gdGhlbiB0aGUgaW8tcGd0YWJsZSBmcmFtZXdvcmsgdG8gd2FsayB0aGUgcGFnZSB0
YWJsZXMgdG8gZmluZCB0aGUgZW50cnkKPiB0aGF0IGNvcnJlc3BvbmRzIHRvIHRoZSBJT1ZBLCBh
bmQgdGhlbiB1bm1hcHMgdGhlIGVudHJ5Lgo+Cj4gVGhpcyBjYW4gYmUgc3Vib3B0aW1hbCBpbiBz
Y2VuYXJpb3Mgd2hlcmUgYSBidWZmZXIgb3IgYSBwaWVjZSBvZiBhCj4gYnVmZmVyIGNhbiBiZSBz
cGxpdCBpbnRvIHNldmVyYWwgY29udGlndW91cyBwYWdlIGJsb2NrcyBvZiB0aGUgc2FtZSBzaXpl
Lgo+IEZvciBleGFtcGxlLCBjb25zaWRlciBhbiBJT01NVSB0aGF0IHN1cHBvcnRzIDQgS0IgcGFn
ZSBibG9ja3MsIDIgTUIgcGFnZQo+IGJsb2NrcywgYW5kIDEgR0IgcGFnZSBibG9ja3MsIGFuZCBh
IGJ1ZmZlciB0aGF0IGlzIDQgTUIgaW4gc2l6ZSBpcyBiZWluZwo+IHVubWFwcGVkIGF0IElPVkEg
MC4gVGhlIGN1cnJlbnQgY2FsbC1mbG93IHdpbGwgcmVzdWx0IGluIDQgaW5kaXJlY3QgY2FsbHMs
Cj4gYW5kIDIgcGFnZSB0YWJsZSB3YWxrcywgdG8gdW5tYXAgMiBlbnRyaWVzIHRoYXQgYXJlIG5l
eHQgdG8gZWFjaCBvdGhlciBpbgo+IHRoZSBwYWdlLXRhYmxlcywgd2hlbiBib3RoIGVudHJpZXMg
Y291bGQgaGF2ZSBiZWVuIHVubWFwcGVkIGluIG9uZSBzaG90Cj4gYnkgY2xlYXJpbmcgYm90aCBw
YWdlIHRhYmxlIGVudHJpZXMgaW4gdGhlIHNhbWUgY2FsbC4KPgo+IFRoZXNlIHBhdGNoZXMgaW1w
bGVtZW50IGEgY2FsbGJhY2sgY2FsbGVkIHVubWFwX3BhZ2VzIHRvIHRoZSBpby1wZ3RhYmxlCj4g
Y29kZSBhbmQgSU9NTVUgZHJpdmVycyB3aGljaCB1bm1hcHMgYW4gSU9WQSByYW5nZSB0aGF0IGNv
bnNpc3RzIG9mIGEKPiBudW1iZXIgb2YgcGFnZXMgb2YgdGhlIHNhbWUgcGFnZSBzaXplIHRoYXQg
aXMgc3VwcG9ydGVkIGJ5IHRoZSBJT01NVQo+IGhhcmR3YXJlLCBhbmQgYWxsb3dzIGZvciBjbGVh
cmluZyBtdWx0aXBsZSBlbnRyaWVzIGluIHRoZSBzYW1lIHNldCBvZgo+IGluZGlyZWN0IGNhbGxz
LiBUaGUgcmVhc29uIGZvciBpbnRyb2R1Y2luZyB1bm1hcF9wYWdlcyBpcyB0byBnaXZlCj4gb3Ro
ZXIgSU9NTVUgZHJpdmVycy9pby1wZ3RhYmxlIGZvcm1hdHMgdGltZSB0byBjaGFuZ2UgdG8gdXNp
bmcgdGhlIG5ldwo+IHVubWFwX3BhZ2VzIGNhbGxiYWNrLCBzbyB0aGF0IHRoZSB0cmFuc2l0aW9u
IHRvIHVzaW5nIHRoaXMgYXBwcm9hY2ggY2FuIGJlCj4gZG9uZSBwaWVjZW1lYWwuCj4KPiBUaGUg
c2FtZSBvcHRpbWl6YXRpb24gaXMgYXBwbGljYWJsZSBmb3IgbWFwcGluZyBidWZmZXJzLCBob3dl
dmVyLCB0aGUKPiBlcnJvciBoYW5kbGluZyBpbiB0aGUgaW8tcGd0YWJsZSBsYXllciBjb3VsZG4n
dCBiZSBoYW5kbGVkIGNsZWFubHksIGFzIHdlCj4gd291bGQgbmVlZCB0byBpbnZva2UgaW9tbXVf
dW5tYXAgdG8gdW5tYXAgdGhlIHBhcnRzIG9mIHRoZSBidWZmZXIgdGhhdAo+IHdlcmUgbWFwcGVk
LCBhbmQgdGhlbiBkbyBhbnkgVExCIG1haW50ZW5hbmNlLiBIb3dldmVyLCB0aGF0IHNlZW1lZCBs
aWtlIGEKPiBsYXllcmluZyB2aW9sYXRpb24uCj4KPiBBbnkgZmVlZGJhY2sgaXMgdmVyeSBtdWNo
IGFwcHJlY2lhdGVkLgoKSSBhcHBseSB0aG9zZSBwYXRjaHNldCBhbmQgaW1wbGVtZW50IGl0IGZv
ciBzbW11djMgb24gbXkga3VucGVuZyBBUk02NCAKcGxhdGZvcm0sIGFuZCB0ZXN0IHRoZSBsYXRl
bmN5IG9mIG1hcC91bm1hcAp3aXRoIHRvb2wgZG1hX21hcF9iZW5jaG1hcmsgKC4vZG1hX21hcF9i
ZW5jaG1hcmsgLWcgeHh4KSwgIGl0IHByb21vdGVzIAptdWNoIG9uIHRoZSBsYXRlbmN5IG9mIHVu
bWFwKHVzKS4KTWF5YmUgeW91IGNhbiBhZGQgdGhlIGltcGxlbWVudCBmb3Igc21tdXYzIGFsc28u
IFRoZSB0ZXN0IHJlc3VsdCBpcyBhcyAKZm9sbG93czoKCiAgICAgICAgICAgICAgICAgICAgICAg
ICBsYXRlbmN5IG9mIG1hcC91bm1hcChiZWZvcmUgb3B0KSAgICBsYXRlbmN5IG9mIAptYXAvdW5t
YXAoYWZ0ZXIgb3B0KQpnPTEoNEsgc2l6ZSkgICAgICAgICAgICAgICAgICAgIDAuMS8wLjcgICAg
IDAuMS8wLjcKZz0yKDhLIHNpemUpICAgICAgICAgICAgICAgICAgICAwLjIvMS40ICAgICAwLjIv
MC44Cmc9NCgxNksgc2l6ZSkgICAgICAgICAgICAgICAgICAwLjMvMi43ICAgICAwLjMvMC45Cmc9
OCgzMksgc2l6ZSkgICAgICAgICAgICAgICAgICAwLjUvNS40ICAgICAwLjUvMS4yCmc9MTYoNjRL
IHNpemUpICAgICAgICAgICAgICAgIDEvMTAuNyAxLzEuOApnPTMyKDEyOEsgc2l6ZSkgICAgICAg
ICAgICAgIDEuOC8yMS40IDEuOC8yLjgKZz02NCgyNTZLIHNpemUpICAgICAgICAgICAgICAzLjYv
NDIuOSAzLjYvNS4xCmc9MTI4KDUxMksgc2l6ZSkgICAgICAgICAgICA3Lzg1LjYgNy84LjYKZz0y
NTYoMU0gc2l6ZSkgICAgICAgICAgICAgIDEzLjkvMTcxLjEgMTMuOS8xNS41Cmc9NTEyKDJNIHNp
emUpICAgICAgICAgICAgICAwLjIvMC43IDAuMi8wLjkKZz0xMDI0KDRNIHNpemUpICAgICAgICAg
ICAgMC4zLzEuNSAwLjMvMS4xCgoKVGhlIGNoYW5nZSBmb3Igc21tdXYzIGZvciB0ZXN0IGFyZSBh
cyBmb2xsb3dzOgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9pb21tdS9hcm0vYXJtLXNtbXUtdjMvYXJt
LXNtbXUtdjMuYyAKYi9kcml2ZXJzL2lvbW11L2FybS9hcm0tc21tdS12My9hcm0tc21tdS12My5j
CmluZGV4IDg1OTRiNGEuLmUwMjY4YjEgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvaW9tbXUvYXJtL2Fy
bS1zbW11LXYzL2FybS1zbW11LXYzLmMKKysrIGIvZHJpdmVycy9pb21tdS9hcm0vYXJtLXNtbXUt
djMvYXJtLXNtbXUtdjMuYwpAQCAtMjI5Miw2ICsyMjkyLDIwIEBAIHN0YXRpYyBzaXplX3QgYXJt
X3NtbXVfdW5tYXAoc3RydWN0IGlvbW11X2RvbWFpbiAKKmRvbWFpbiwgdW5zaWduZWQgbG9uZyBp
b3ZhLAogICAgICAgICByZXR1cm4gb3BzLT51bm1hcChvcHMsIGlvdmEsIHNpemUsIGdhdGhlcik7
CiAgfQoKK3N0YXRpYyBzaXplX3QgYXJtX3NtbXVfdW5tYXBfcGFnZXMoc3RydWN0IGlvbW11X2Rv
bWFpbiAqZG9tYWluLCAKdW5zaWduZWQgbG9uZyBpb3ZhLAorICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHNpemVfdCBwZ3NpemUsIHNpemVfdCBwZ2NvdW50LAorICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIHN0cnVjdCBpb21tdV9pb3RsYl9nYXRoZXIgKmdhdGhlcikKK3sKKyAgICAgICBz
dHJ1Y3QgYXJtX3NtbXVfZG9tYWluICpzbW11X2RvbWFpbiA9IHRvX3NtbXVfZG9tYWluKGRvbWFp
bik7CisgICAgICAgc3RydWN0IGlvX3BndGFibGVfb3BzICpvcHMgPSBzbW11X2RvbWFpbi0+cGd0
Ymxfb3BzOworCisgICAgICAgaWYgKCFvcHMpCisgICAgICAgICAgICAgICByZXR1cm4gMDsKKwor
ICAgICAgIHJldHVybiBvcHMtPnVubWFwX3BhZ2VzKG9wcywgaW92YSwgcGdzaXplLCBwZ2NvdW50
LCBnYXRoZXIpOworfQorCisKICBzdGF0aWMgdm9pZCBhcm1fc21tdV9mbHVzaF9pb3RsYl9hbGwo
c3RydWN0IGlvbW11X2RvbWFpbiAqZG9tYWluKQogIHsKICAgICAgICAgc3RydWN0IGFybV9zbW11
X2RvbWFpbiAqc21tdV9kb21haW4gPSB0b19zbW11X2RvbWFpbihkb21haW4pOwpAQCAtMjYxMyw2
ICsyNjI3LDcgQEAgc3RhdGljIHN0cnVjdCBpb21tdV9vcHMgYXJtX3NtbXVfb3BzID0gewogICAg
ICAgICAuYXR0YWNoX2RldiAgICAgICAgICAgICA9IGFybV9zbW11X2F0dGFjaF9kZXYsCiAgICAg
ICAgIC5tYXAgICAgICAgICAgICAgICAgICAgID0gYXJtX3NtbXVfbWFwLAogICAgICAgICAudW5t
YXAgICAgICAgICAgICAgICAgICA9IGFybV9zbW11X3VubWFwLAorICAgICAgIC51bm1hcF9wYWdl
cyAgICAgICAgICAgID0gYXJtX3NtbXVfdW5tYXBfcGFnZXMsCiAgICAgICAgIC5mbHVzaF9pb3Rs
Yl9hbGwgICAgICAgID0gYXJtX3NtbXVfZmx1c2hfaW90bGJfYWxsLAogICAgICAgICAuaW90bGJf
c3luYyAgICAgICAgICAgICA9IGFybV9zbW11X2lvdGxiX3N5bmMsCiAgICAgICAgIC5pb3ZhX3Rv
X3BoeXMgICAgICAgICAgID0gYXJtX3NtbXVfaW92YV90b19waHlzLAoKPgo+IFRoYW5rcywKPiBJ
c2FhYwo+Cj4gSXNhYWMgSi4gTWFuamFycmVzICg1KToKPiAgICBpb21tdS9pby1wZ3RhYmxlOiBJ
bnRyb2R1Y2UgdW5tYXBfcGFnZXMoKSBhcyBhIHBhZ2UgdGFibGUgb3AKPiAgICBpb21tdTogQWRk
IGFuIHVubWFwX3BhZ2VzKCkgb3AgZm9yIElPTU1VIGRyaXZlcnMKPiAgICBpb21tdTogQWRkIHN1
cHBvcnQgZm9yIHRoZSB1bm1hcF9wYWdlcyBJT01NVSBjYWxsYmFjawo+ICAgIGlvbW11L2lvLXBn
dGFibGUtYXJtOiBJbXBsZW1lbnQgYXJtX2xwYWVfdW5tYXBfcGFnZXMoKQo+ICAgIGlvbW11L2Fy
bS1zbW11OiBJbXBsZW1lbnQgdGhlIHVubWFwX3BhZ2VzIElPTU1VIGRyaXZlciBjYWxsYmFjawo+
Cj4gICBkcml2ZXJzL2lvbW11L2FybS9hcm0tc21tdS9hcm0tc21tdS5jIHwgIDE5ICsrKysrCj4g
ICBkcml2ZXJzL2lvbW11L2lvLXBndGFibGUtYXJtLmMgICAgICAgIHwgMTE0ICsrKysrKysrKysr
KysrKysrKysrKy0tLS0tCj4gICBkcml2ZXJzL2lvbW11L2lvbW11LmMgICAgICAgICAgICAgICAg
IHwgIDQ0ICsrKysrKysrLS0KPiAgIGluY2x1ZGUvbGludXgvaW8tcGd0YWJsZS5oICAgICAgICAg
ICAgfCAgIDQgKwo+ICAgaW5jbHVkZS9saW51eC9pb21tdS5oICAgICAgICAgICAgICAgICB8ICAg
NCArCj4gICA1IGZpbGVzIGNoYW5nZWQsIDE1OSBpbnNlcnRpb25zKCspLCAyNiBkZWxldGlvbnMo
LSkKPgoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlv
bW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczov
L2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
