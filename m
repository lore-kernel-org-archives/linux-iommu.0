Return-Path: <SRS0=1kRO=GO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B37A8C433E0
	for <iommu@archiver.kernel.org>; Mon, 11 Jan 2021 20:01:55 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 529772054F
	for <iommu@archiver.kernel.org>; Mon, 11 Jan 2021 20:01:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 529772054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 20B6483883;
	Mon, 11 Jan 2021 20:01:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WsDPjdw3pqcj; Mon, 11 Jan 2021 20:01:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 232AE8364D;
	Mon, 11 Jan 2021 20:01:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0D2CCC0893;
	Mon, 11 Jan 2021 20:01:54 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1829FC013A
 for <iommu@lists.linux-foundation.org>; Mon, 11 Jan 2021 20:01:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 06BAF85045
 for <iommu@lists.linux-foundation.org>; Mon, 11 Jan 2021 20:01:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0JTTfe3meeSO for <iommu@lists.linux-foundation.org>;
 Mon, 11 Jan 2021 20:01:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 7D71B85039
 for <iommu@lists.linux-foundation.org>; Mon, 11 Jan 2021 20:01:51 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 75BFB101E;
 Mon, 11 Jan 2021 12:01:50 -0800 (PST)
Received: from [10.57.56.43] (unknown [10.57.56.43])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9EEB83F66E;
 Mon, 11 Jan 2021 12:01:49 -0800 (PST)
Subject: Re: Consult on ARM SMMU debugfs
To: "chenxiang (M)" <chenxiang66@hisilicon.com>, will@kernel.org
References: <cd9296f1-a3ea-d8d6-0e14-2cd6f19a17da@hisilicon.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <9a23610f-e0b4-92e6-6da6-3182d481db92@arm.com>
Date: Mon, 11 Jan 2021 20:01:48 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <cd9296f1-a3ea-d8d6-0e14-2cd6f19a17da@hisilicon.com>
Content-Language: en-GB
Cc: iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org
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

T24gMjAyMS0wMS0wNyAwMjo0NSwgY2hlbnhpYW5nIChNKSB3cm90ZToKPiBIaSBXaWxsLMKgIFJv
YmluIG9yIG90aGVyIGd1eXMsCj4gCj4gV2hlbiBkZWJ1Z2dpbmcgU01NVS9TVkEgaXNzdWUgb24g
aHVhd2VpIEFSTTY0IGJvYXJkLCB3ZSBmaW5kIHRoYXQgaXQgCj4gbGFja3Mgb2YgZW5vdWdoIGRl
YnVnZnMgZm9yIEFSTSBTTU1VIGRyaXZlciAoc3VjaCBhcwo+IAo+IHRoZSB2YWx1ZSBvZiBTVEUv
Q0Qgd2hpY2ggd2UgbmVlZCB0byBjaGVjayBzb21ldGltZXMpLiBDdXJyZW50bHkgaXQgCj4gY3Jl
YXRlcyB0b3AtbGV2ZWwgaW9tbXUgZGlyZWN0b3J5IGluIGRlYnVnZnMsIGJ1dCB0aGVyZSBpcyBu
byBkZWJ1Z2ZzCj4gCj4gZm9yIEFSTSBTTU1VIGRyaXZlciBzcGVjaWFsbHkuIERvIHlvdSBrbm93
IHdoZXRoZXIgQVJNIGhhdmUgdGhlIHBsYW4gdG8gCj4gZG8gdGhhdCByZWNlbnRseT8KCkZXSVcg
SSBkb24ndCB0aGluayBJJ3ZlIGV2ZXIgZmVsdCB0aGUgbmVlZCB0byBuZWVkIHRvIGluc3BlY3Qg
dGhlIFN0cmVhbSAKVGFibGUgb24gYSBsaXZlIHN5c3RlbS4gU28gZmFyIHRoZSBuYXR1cmUgb2Yg
dGhlIFNURSBjb2RlIGhhcyBiZWVuIApzaW1wbGUgZW5vdWdoIHRoYXQgaXQncyB2ZXJ5IGhhcmQg
Zm9yIGFueSBnaXZlbiBTVEUgdG8gYmUgKndyb25nKiAtIAplaXRoZXIgaXQncyBzZXQgdXAgYXMg
ZXhwZWN0ZWQgYW5kIHRodXMgd29ya3MgZmluZSwgb3IgaXQncyBub3QgCmluaXRpYWxpc2VkIGF0
IGFsbCBhbmQgeW91IGdldCBDX0JBRF9TVEUsIHdoZXJlIDk5JSBvZiB0aGUgdGltZSB5b3UgdGhl
biAKanVzdCBjcm9zcy1yZWZlcmVuY2UgdGhlIFN0cmVhbSBJRCBhZ2FpbnN0IHRoZSBmaXJtd2Fy
ZSBhbmQgZmluZCB0aGF0IAp0aGUgRFQvSU9SVCBpcyB3cm9uZy4KClNpbWlsYXJseSBJIGRvbid0
IHRoaW5rIEkndmUgZXZlbiBldmVuICpzZWVuKiBhbiBpc3N1ZSB0aGF0IGNvdWxkIGJlIAphdHRy
aWJ1dGVkIHRvIGEgY29udGV4dCBkZXNjcmlwdG9yLCBhbHRob3VnaCBJIGFwcHJlY2lhdGUgdGhh
dCBhcyB3ZSAKc3RhcnQgbGFuZGluZyBtb3JlIFBBU0lEIGFuZCBTVkEgc3VwcG9ydCB0aGUgc2Nv
cGUgZm9yIHRoYXQgc3RhcnRzIHRvIAp3aWRlbiBjb25zaWRlcmFibHkuCgpGZWVsIGZyZWUgdG8g
cHJvcG9zZSBhIHBhdGNoIGlmIHlvdSBiZWxpZXZlIGl0IHdvdWxkIGJlIGdlbnVpbmVseSB1c2Vm
dWwgCmFuZCB3b24ndCBqdXN0IGJpdC1yb3QgaW50byBhIG1haW50ZW5hbmNlIGJ1cmRlbiwgYnV0
IGl0J3Mgbm90IHNvbWV0aGluZyAKdGhhdCdzIG9uIG91ciByb2FkbWFwIGhlcmUuCgpUaGFua3Ms
ClJvYmluLgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpp
b21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6
Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
