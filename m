Return-Path: <SRS0=3kXM=IU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61649C433DB
	for <iommu@archiver.kernel.org>; Mon, 22 Mar 2021 01:01:51 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8EBE61943
	for <iommu@archiver.kernel.org>; Mon, 22 Mar 2021 01:01:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8EBE61943
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6C7998308A;
	Mon, 22 Mar 2021 01:01:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZfaNo8MHYzJz; Mon, 22 Mar 2021 01:01:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id 58BB683083;
	Mon, 22 Mar 2021 01:01:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3DD85C000B;
	Mon, 22 Mar 2021 01:01:49 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4F524C0001
 for <iommu@lists.linux-foundation.org>; Mon, 22 Mar 2021 01:01:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 272D440290
 for <iommu@lists.linux-foundation.org>; Mon, 22 Mar 2021 01:01:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iYNv8U9gKINo for <iommu@lists.linux-foundation.org>;
 Mon, 22 Mar 2021 01:01:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A0E7B4028B
 for <iommu@lists.linux-foundation.org>; Mon, 22 Mar 2021 01:01:44 +0000 (UTC)
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
 by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4F3bks4cVzzkccm;
 Mon, 22 Mar 2021 09:00:05 +0800 (CST)
Received: from [127.0.0.1] (10.40.193.166) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.498.0; Mon, 22 Mar 2021
 09:01:38 +0800
Subject: Re: [PATCH] iommu/dma: Fix a typo in a comment
To: Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>
References: <1616037684-59399-1-git-send-email-chenxiang66@hisilicon.com>
 <20210318093410.GA6574@willie-the-truck>
 <c378734f-33d5-1426-fa41-2bd8064ceec4@hisilicon.com>
 <8eef75b4-8f69-3dff-d46a-170aa8b30a53@arm.com>
 <4d91b623-fc29-5886-6972-0325b00df164@hisilicon.com>
 <b3badca4-7262-3e11-c78e-e6709760840a@arm.com>
From: "chenxiang (M)" <chenxiang66@hisilicon.com>
Message-ID: <5e086042-cf6c-a56e-eeff-bf7df42b2e03@hisilicon.com>
Date: Mon, 22 Mar 2021 09:01:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <b3badca4-7262-3e11-c78e-e6709760840a@arm.com>
X-Originating-IP: [10.40.193.166]
X-CFilter-Loop: Reflected
Cc: iommu@lists.linux-foundation.org
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

CgrlnKggMjAyMS8zLzE5IDE5OjAyLCBSb2JpbiBNdXJwaHkg5YaZ6YGTOgo+IE9uIDIwMjEtMDMt
MTkgMDE6MDIsIGNoZW54aWFuZyAoTSkgd3JvdGU6Cj4+IEhpLAo+Pgo+Pgo+PiDlnKggMjAyMS8z
LzE4IDE5OjAxLCBSb2JpbiBNdXJwaHkg5YaZ6YGTOgo+Pj4gT24gMjAyMS0wMy0xOCAwOTo1NSwg
Y2hlbnhpYW5nIChNKSB3cm90ZToKPj4+PiBIaSB3aWxsLAo+Pj4+Cj4+Pj4KPj4+PiDlnKggMjAy
MS8zLzE4IDE3OjM0LCBXaWxsIERlYWNvbiDlhpnpgZM6Cj4+Pj4+IE9uIFRodSwgTWFyIDE4LCAy
MDIxIGF0IDExOjIxOjI0QU0gKzA4MDAsIGNoZW54aWFuZyB3cm90ZToKPj4+Pj4+IEZyb206IFhp
YW5nIENoZW4gPGNoZW54aWFuZzY2QGhpc2lsaWNvbi5jb20+Cj4+Pj4+Pgo+Pj4+Pj4gRml4IGEg
dHlwZSAiU0FDIiB0byAiREFDIiBpbiB0aGUgY29tbWVudCBvZiBmdW5jdGlvbgo+Pj4+Pj4gaW9t
bXVfZG1hX2FsbG9jX2lvdmEoKS4KPj4+Pj4+Cj4+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBYaWFuZyBD
aGVuIDxjaGVueGlhbmc2NkBoaXNpbGljb24uY29tPgo+Pj4+Pj4gLS0tCj4+Pj4+PiAgIGRyaXZl
cnMvaW9tbXUvZG1hLWlvbW11LmMgfCAyICstCj4+Pj4+PiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGlu
c2VydGlvbigrKSwgMSBkZWxldGlvbigtKQo+Pj4+Pj4KPj4+Pj4+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL2lvbW11L2RtYS1pb21tdS5jIGIvZHJpdmVycy9pb21tdS9kbWEtaW9tbXUuYwo+Pj4+Pj4g
aW5kZXggYWY3NjVjOC4uM2JjMTdlZSAxMDA2NDQKPj4+Pj4+IC0tLSBhL2RyaXZlcnMvaW9tbXUv
ZG1hLWlvbW11LmMKPj4+Pj4+ICsrKyBiL2RyaXZlcnMvaW9tbXUvZG1hLWlvbW11LmMKPj4+Pj4+
IEBAIC00NDMsNyArNDQzLDcgQEAgc3RhdGljIGRtYV9hZGRyX3QgaW9tbXVfZG1hX2FsbG9jX2lv
dmEoc3RydWN0IAo+Pj4+Pj4gaW9tbXVfZG9tYWluICpkb21haW4sCj4+Pj4+PiAgICAgICBpZiAo
ZG9tYWluLT5nZW9tZXRyeS5mb3JjZV9hcGVydHVyZSkKPj4+Pj4+ICAgICAgICAgICBkbWFfbGlt
aXQgPSBtaW4oZG1hX2xpbWl0LCAKPj4+Pj4+ICh1NjQpZG9tYWluLT5nZW9tZXRyeS5hcGVydHVy
ZV9lbmQpOwo+Pj4+Pj4gLSAgICAvKiBUcnkgdG8gZ2V0IFBDSSBkZXZpY2VzIGEgU0FDIGFkZHJl
c3MgKi8KPj4+Pj4+ICsgICAgLyogVHJ5IHRvIGdldCBQQ0kgZGV2aWNlcyBhIERBQyBhZGRyZXNz
ICovCj4+Pj4+PiAgICAgICBpZiAoZG1hX2xpbWl0ID4gRE1BX0JJVF9NQVNLKDMyKSAmJiBkZXZf
aXNfcGNpKGRldikpCj4+Pj4+PiAgICAgICAgICAgaW92YSA9IGFsbG9jX2lvdmFfZmFzdChpb3Zh
ZCwgaW92YV9sZW4sCj4+Pj4+PiAgICAgICAgICAgICAgICAgICAgICAgICAgRE1BX0JJVF9NQVNL
KDMyKSA+PiBzaGlmdCwgZmFsc2UpOwo+Pj4+PiBUaGlzIGRvZXNuJ3QgbG9vayBsaWtlIGEgdHlw
byB0byBtZS4uLiBQbGVhc2UgZXhwbGFpbi4KPj4+Cj4+PiBBcyB0aGUgYXV0aG9yIG9mIHNhaWQg
Y29tbWVudCwgaXQgaXMgZGVmaW5pdGVseSBub3QgYSB0eXBvLgo+Pgo+PiBXaGF0J3MgdGhlIHNo
b3J0IGZvciBTQUM/Cj4KPiBTaW5nbGUgQWRkcmVzcyBDeWNsZSAtIHRoaXMgaXMgc3RhbmRhcmQg
dGVybWlub2xvZ3kgZnJvbSB0aGUgUENJIHNwZWMuCgpHb3QgaXQsIHRoYW5rcy4KCj4KPiBSb2Jp
bi4KPgo+IC4KPgoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpo
dHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
