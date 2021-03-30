Return-Path: <SRS0=H7Zn=I4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E79EC433DB
	for <iommu@archiver.kernel.org>; Tue, 30 Mar 2021 01:22:36 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED69F619A7
	for <iommu@archiver.kernel.org>; Tue, 30 Mar 2021 01:22:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED69F619A7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A6F7D60829;
	Tue, 30 Mar 2021 01:22:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VIsORB13n9IY; Tue, 30 Mar 2021 01:22:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 99EA760819;
	Tue, 30 Mar 2021 01:22:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6E171C000B;
	Tue, 30 Mar 2021 01:22:34 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3A4DFC000A
 for <iommu@lists.linux-foundation.org>; Tue, 30 Mar 2021 01:22:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 14AA683DB1
 for <iommu@lists.linux-foundation.org>; Tue, 30 Mar 2021 01:22:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xxKyxtzs8foW for <iommu@lists.linux-foundation.org>;
 Tue, 30 Mar 2021 01:22:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C4F4C83A3C
 for <iommu@lists.linux-foundation.org>; Tue, 30 Mar 2021 01:22:30 +0000 (UTC)
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
 by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4F8WpZ3n0Dz9t5K;
 Tue, 30 Mar 2021 09:20:22 +0800 (CST)
Received: from [127.0.0.1] (10.40.193.166) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.498.0; Tue, 30 Mar 2021
 09:22:21 +0800
Subject: Re: [PATCH] iommu: Add a check to avoid invalid iotlb sync
To: Will Deacon <will@kernel.org>
References: <1616826190-77035-1-git-send-email-chenxiang66@hisilicon.com>
 <20210329144554.GA4203@willie-the-truck>
From: "chenxiang (M)" <chenxiang66@hisilicon.com>
Message-ID: <2b0b7a7d-7162-bef9-9730-cbe3767d14f9@hisilicon.com>
Date: Tue, 30 Mar 2021 09:22:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20210329144554.GA4203@willie-the-truck>
X-Originating-IP: [10.40.193.166]
X-CFilter-Loop: Reflected
Cc: iommu@lists.linux-foundation.org, robin.murphy@arm.com,
 linuxarm@openeuler.org
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

SGkgV2lsbCwKCgrlnKggMjAyMS8zLzI5IDIyOjQ1LCBXaWxsIERlYWNvbiDlhpnpgZM6Cj4gT24g
U2F0LCBNYXIgMjcsIDIwMjEgYXQgMDI6MjM6MTBQTSArMDgwMCwgY2hlbnhpYW5nIHdyb3RlOgo+
PiBGcm9tOiBYaWFuZyBDaGVuIDxjaGVueGlhbmc2NkBoaXNpbGljb24uY29tPgo+Pgo+PiBDdXJy
ZW50bHkgaXQgd2lsbCBzZW5kIGEgaW90bGIgc3luYyBhdCBlbmQgb2YgaW9tbXUgdW5tYXAgZXZl
biBpZgo+PiBpb3RsYl9nYXRoZXIgaXMgbm90IHZhbGlkIChpb3RsYl9nYXRoZXItPnBnc2l6ZSA9
IDApLiBBY3R1YWxseSBpdCBpcyBub3QKPj4gbmVjZXNzYXJ5LCBzbyBhZGQgYSBjaGVjayB0byBh
dm9pZCBpbnZhbGlkIGlvdGxiIHN5bmMuCj4+Cj4+IFNpZ25lZC1vZmYtYnk6IFhpYW5nIENoZW4g
PGNoZW54aWFuZzY2QGhpc2lsaWNvbi5jb20+Cj4+IC0tLQo+PiAgIGluY2x1ZGUvbGludXgvaW9t
bXUuaCB8IDMgKysrCj4+ICAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKQo+Pgo+PiBk
aWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9pb21tdS5oIGIvaW5jbHVkZS9saW51eC9pb21tdS5o
Cj4+IGluZGV4IDljYTZlNmIuLjZhZmE2MWIgMTAwNjQ0Cj4+IC0tLSBhL2luY2x1ZGUvbGludXgv
aW9tbXUuaAo+PiArKysgYi9pbmNsdWRlL2xpbnV4L2lvbW11LmgKPj4gQEAgLTUyOSw2ICs1Mjks
OSBAQCBzdGF0aWMgaW5saW5lIHZvaWQgaW9tbXVfZmx1c2hfaW90bGJfYWxsKHN0cnVjdCBpb21t
dV9kb21haW4gKmRvbWFpbikKPj4gICBzdGF0aWMgaW5saW5lIHZvaWQgaW9tbXVfaW90bGJfc3lu
YyhzdHJ1Y3QgaW9tbXVfZG9tYWluICpkb21haW4sCj4+ICAgCQkJCSAgc3RydWN0IGlvbW11X2lv
dGxiX2dhdGhlciAqaW90bGJfZ2F0aGVyKQo+PiAgIHsKPj4gKwlpZiAoIWlvdGxiX2dhdGhlci0+
cGdzaXplKQo+PiArCQlyZXR1cm47Cj4gSW4gd2hpY2ggY2lyY3Vtc3RhbmNlcyBkb2VzIHRoaXMg
b2NjdXI/Cj4KPiBXaWxsCgpXaGVuIGlvbW11X3VubWFwLCBpdCBpbml0aWFsaXplcyBpb3RsYl9n
YXRoZXIgKHRoZW4gaW90bGJfZ2F0aGVyLT5wZ3NpemUgCj0gMCkuCklmIHRoZSB1bm1hcCBzaXpl
ID0gQVJNX0xQQUVfQkxPQ0tfU0laRShsdmwpICYmIGlvcHRlX2xlYWYoKSwgaXQgd2lsbCAKZmls
bCB0aGUgaW90bGJfZ2F0aGVyIChzZXQgaW90bGJfZ2F0aGVyLT5wZ3NpemUgPSBncmFudWxlKTsK
YnV0IGlmIHRoZSB1bm1hcCBzaXplID0gQVJNX0xQQUVfQkxPQ0tfU0laRShsdmwpICYmICFpb3B0
ZV9sZWFmKCkgKHRsYiAKZmx1c2ggd2FsayBzaXR1YXRpb24pLCBpb3RsYl9nYXRoZXIgaXMgbm90
IGZpbGxlZCAoaW90bGJfZ2F0aGVyLT5wZ3NpemUgCj0gMCksCml0IHdpbGwgc3RpbGwgc2VuZCBp
b21tdV9pb3RsYl9zeW5jKGRvbWFpbiwgJmlvdGxiX2dhdGhlcikgd2hpY2ggaXMgCmFjdHVhbGx5
IGludmFsaWQgaW90bGIgc3luYyBhdCBsYXN0LgoKCj4KPiAuCj4KCgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVA
bGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24u
b3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
