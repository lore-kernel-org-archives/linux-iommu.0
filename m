Return-Path: <SRS0=sMz+=LM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 176E8C2B9F4
	for <iommu@archiver.kernel.org>; Fri, 18 Jun 2021 01:53:26 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0F14610A7
	for <iommu@archiver.kernel.org>; Fri, 18 Jun 2021 01:53:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0F14610A7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 785DF40236;
	Fri, 18 Jun 2021 01:53:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AyKVme968iCj; Fri, 18 Jun 2021 01:53:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id B43CC40003;
	Fri, 18 Jun 2021 01:53:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6EF2EC000D;
	Fri, 18 Jun 2021 01:53:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 70A82C000B
 for <iommu@lists.linux-foundation.org>; Fri, 18 Jun 2021 01:53:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 49257605AC
 for <iommu@lists.linux-foundation.org>; Fri, 18 Jun 2021 01:53:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2yWfUEH2auCs for <iommu@lists.linux-foundation.org>;
 Fri, 18 Jun 2021 01:53:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9EFB2600C5
 for <iommu@lists.linux-foundation.org>; Fri, 18 Jun 2021 01:53:19 +0000 (UTC)
IronPort-SDR: HYlEdTHKs1X+oS6Tw0rgqs6lSlDzCT5nBUvmfQkU55cYEaJtHDsZ+ABSYiG5qvZ78Cg2kD36S9
 UZeNGMQtoamg==
X-IronPort-AV: E=McAfee;i="6200,9189,10018"; a="204651252"
X-IronPort-AV: E=Sophos;i="5.83,281,1616482800"; d="scan'208";a="204651252"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jun 2021 18:53:18 -0700
IronPort-SDR: Q5vu6PcEGBkldERazoleVuGDdZijSRvTVciKwDk0WAnv8lUAoPMVEHc8AnTcAQzhMepbLoAcKJ
 DIMIojw+Gw+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,281,1616482800"; d="scan'208";a="472612920"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118])
 ([10.239.159.118])
 by fmsmga004.fm.intel.com with ESMTP; 17 Jun 2021 18:53:16 -0700
Subject: Re: [PATCH v13 6/6] iommu: Remove mode argument from
 iommu_set_dma_strict()
To: Robin Murphy <robin.murphy@arm.com>, John Garry <john.garry@huawei.com>,
 joro@8bytes.org, will@kernel.org, dwmw2@infradead.org, corbet@lwn.net
References: <1623841437-211832-1-git-send-email-john.garry@huawei.com>
 <1623841437-211832-7-git-send-email-john.garry@huawei.com>
 <de6a2874-3d6d-ed2a-78f5-fb1fb0195228@linux.intel.com>
 <7d0fb0e2-4671-16db-6963-b0493d7a549b@arm.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <b6484679-0950-8c8e-98c5-da0e4c1d97e2@linux.intel.com>
Date: Fri, 18 Jun 2021 09:51:48 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <7d0fb0e2-4671-16db-6963-b0493d7a549b@arm.com>
Content-Language: en-US
Cc: linux-doc@vger.kernel.org, linuxarm@huawei.com,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
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

SGkgUm9iaW4sCgpPbiA2LzE4LzIxIDI6NTYgQU0sIFJvYmluIE11cnBoeSB3cm90ZToKPj4+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L2lvbW11LmMgYi9kcml2ZXJzL2lvbW11L2lvbW11LmMK
Pj4+IGluZGV4IDYwYjFlYzQyZTczYi4uZmYyMjFkM2RkY2JjIDEwMDY0NAo+Pj4gLS0tIGEvZHJp
dmVycy9pb21tdS9pb21tdS5jCj4+PiArKysgYi9kcml2ZXJzL2lvbW11L2lvbW11LmMKPj4+IEBA
IC0zNDksMTAgKzM0OSw5IEBAIHN0YXRpYyBpbnQgX19pbml0IGlvbW11X2RtYV9zZXR1cChjaGFy
ICpzdHIpCj4+PiDCoCB9Cj4+PiDCoCBlYXJseV9wYXJhbSgiaW9tbXUuc3RyaWN0IiwgaW9tbXVf
ZG1hX3NldHVwKTsKPj4+IC12b2lkIGlvbW11X3NldF9kbWFfc3RyaWN0KGJvb2wgc3RyaWN0KQo+
Pj4gK3ZvaWQgaW9tbXVfc2V0X2RtYV9zdHJpY3Qodm9pZCkKPj4+IMKgIHsKPj4+IC3CoMKgwqAg
aWYgKHN0cmljdCB8fCAhKGlvbW11X2NtZF9saW5lICYgSU9NTVVfQ01EX0xJTkVfU1RSSUNUKSkK
Pj4+IC3CoMKgwqDCoMKgwqDCoCBpb21tdV9kbWFfc3RyaWN0ID0gc3RyaWN0Owo+Pj4gK8KgwqDC
oCBpb21tdV9kbWFfc3RyaWN0ID0gdHJ1ZTsKPj4KPj4gU29ycnksIEkgc3RpbGwgY2FuJ3QgZ2V0
IGhvdyBpb21tdS5zdHJpY3Qga2VybmVsIG9wdGlvbiB3b3Jrcy4KPj4KPj4gc3RhdGljIGludCBf
X2luaXQgaW9tbXVfZG1hX3NldHVwKGNoYXIgKnN0cikKPj4gewo+PiDCoMKgwqDCoMKgwqDCoMKg
IGludCByZXQgPSBrc3RydG9ib29sKHN0ciwgJmlvbW11X2RtYV9zdHJpY3QpOwo+IAo+IE5vdGUg
dGhhdCB0aGlzIGlzIHRoZSBiaXQgdGhhdCBkb2VzIHRoZSByZWFsIHdvcmsgLSBpZiB0aGUgYXJn
dW1lbnQgCj4gcGFyc2VzIE9LIHRoZW4gaW9tbXVfZG1hX3N0cmljdCBpcyByZWFzc2lnbmVkIHdp
dGggdGhlIGFwcHJvcHJpYXRlIAo+IHZhbHVlLiBUaGUgaW9tbXVfY21kX2xpbmUgc3R1ZmYgaXMg
YSBiaXQgb2YgYWRkaXRpb25hbCBib29ra2VlcGluZywgCj4gYmFzaWNhbGx5IGp1c3Qgc28gd2Ug
Y2FuIHNlZSB3aGV0aGVyIGRlZmF1bHQgdmFsdWVzIGhhdmUgYmVlbiBvdmVycmlkZGVuLgoKQWgs
IGdldCBpdC4gVGhhbmtzIGEgbG90LiBJIG1pc3NlZCB0aGlzIHBhcnQgYW5kIG5haXZlbHkgdGhv
dWdodCBpdCBqdXN0CmNvbnZlcnRzIGEgc3RyaW5nIHRvIGludGVnZXIuCgpCZXN0IHJlZ2FyZHMs
CmJhb2x1Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlv
bW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczov
L2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
