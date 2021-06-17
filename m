Return-Path: <SRS0=K0Me=LL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85032C2B9F4
	for <iommu@archiver.kernel.org>; Thu, 17 Jun 2021 07:47:48 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37510613BF
	for <iommu@archiver.kernel.org>; Thu, 17 Jun 2021 07:47:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37510613BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0807882A2D;
	Thu, 17 Jun 2021 07:47:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WLC03kzox1pR; Thu, 17 Jun 2021 07:47:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id CAF7A82A17;
	Thu, 17 Jun 2021 07:47:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8693FC000E;
	Thu, 17 Jun 2021 07:47:43 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4E4FEC000B
 for <iommu@lists.linux-foundation.org>; Thu, 17 Jun 2021 07:47:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 269D241610
 for <iommu@lists.linux-foundation.org>; Thu, 17 Jun 2021 07:47:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HaY6xsnTkKSd for <iommu@lists.linux-foundation.org>;
 Thu, 17 Jun 2021 07:47:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C8B1B41607
 for <iommu@lists.linux-foundation.org>; Thu, 17 Jun 2021 07:47:40 +0000 (UTC)
Received: from fraeml704-chm.china.huawei.com (unknown [172.18.147.207])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4G5DRj6q8Rz6L7kw;
 Thu, 17 Jun 2021 15:37:53 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml704-chm.china.huawei.com (10.206.15.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Thu, 17 Jun 2021 09:47:36 +0200
Received: from [10.47.95.81] (10.47.95.81) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Thu, 17 Jun
 2021 08:47:36 +0100
Subject: Re: [PATCH v13 6/6] iommu: Remove mode argument from
 iommu_set_dma_strict()
To: Lu Baolu <baolu.lu@linux.intel.com>, <joro@8bytes.org>, <will@kernel.org>, 
 <dwmw2@infradead.org>, <robin.murphy@arm.com>, <corbet@lwn.net>
References: <1623841437-211832-1-git-send-email-john.garry@huawei.com>
 <1623841437-211832-7-git-send-email-john.garry@huawei.com>
 <de6a2874-3d6d-ed2a-78f5-fb1fb0195228@linux.intel.com>
From: John Garry <john.garry@huawei.com>
Message-ID: <c61376c8-5285-1121-046f-3ab12eee9902@huawei.com>
Date: Thu, 17 Jun 2021 08:41:24 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <de6a2874-3d6d-ed2a-78f5-fb1fb0195228@linux.intel.com>
Content-Language: en-US
X-Originating-IP: [10.47.95.81]
X-ClientProxiedBy: lhreml743-chm.china.huawei.com (10.201.108.193) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxarm@huawei.com, iommu@lists.linux-foundation.org
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

Cj4+IEBAIC0zNDksMTAgKzM0OSw5IEBAIHN0YXRpYyBpbnQgX19pbml0IGlvbW11X2RtYV9zZXR1
cChjaGFyICpzdHIpCj4+IMKgIH0KPj4gwqAgZWFybHlfcGFyYW0oImlvbW11LnN0cmljdCIsIGlv
bW11X2RtYV9zZXR1cCk7Cj4+IC12b2lkIGlvbW11X3NldF9kbWFfc3RyaWN0KGJvb2wgc3RyaWN0
KQo+PiArdm9pZCBpb21tdV9zZXRfZG1hX3N0cmljdCh2b2lkKQo+PiDCoCB7Cj4+IC3CoMKgwqAg
aWYgKHN0cmljdCB8fCAhKGlvbW11X2NtZF9saW5lICYgSU9NTVVfQ01EX0xJTkVfU1RSSUNUKSkK
Pj4gLcKgwqDCoMKgwqDCoMKgIGlvbW11X2RtYV9zdHJpY3QgPSBzdHJpY3Q7Cj4+ICvCoMKgwqAg
aW9tbXVfZG1hX3N0cmljdCA9IHRydWU7Cj4gCj4gU29ycnksIEkgc3RpbGwgY2FuJ3QgZ2V0IGhv
dyBpb21tdS5zdHJpY3Qga2VybmVsIG9wdGlvbiB3b3Jrcy4KPiAKPiBzdGF0aWMgaW50IF9faW5p
dCBpb21tdV9kbWFfc2V0dXAoY2hhciAqc3RyKQo+IHsKPiAgwqDCoMKgwqDCoMKgwqAgaW50IHJl
dCA9IGtzdHJ0b2Jvb2woc3RyLCAmaW9tbXVfZG1hX3N0cmljdCk7Cj4gCj4gIMKgwqDCoMKgwqDC
oMKgIGlmICghcmV0KQo+ICDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaW9tbXVfY21k
X2xpbmUgfD0gSU9NTVVfQ01EX0xJTkVfU1RSSUNUOwo+ICDCoMKgwqDCoMKgwqDCoCByZXR1cm4g
cmV0Owo+IH0KPiBlYXJseV9wYXJhbSgiaW9tbXUuc3RyaWN0IiwgaW9tbXVfZG1hX3NldHVwKTsK
PiAKPiBUaGUgYml0IElPTU1VX0NNRF9MSU5FX1NUUklDVCBpcyBvbmx5IHNldCwgYnV0IG5vdCB1
c2VkIGFueXdoZXJlLgoKSXQgaXMgdXNlZCBpbiBwYXRjaCAyLzY6CgorCXByX2luZm8oIkRNQSBk
b21haW4gVExCIGludmFsaWRhdGlvbiBwb2xpY3k6ICVzIG1vZGUgJXNcbiIsCisJCWlvbW11X2Rt
YV9zdHJpY3QgPyAic3RyaWN0IiA6ICJsYXp5IiwKKwkJKGlvbW11X2NtZF9saW5lICYgSU9NTVVf
Q01EX0xJTkVfU1RSSUNUKSA/CisJCQkiKHNldCB2aWEga2VybmVsIGNvbW1hbmQgbGluZSkiIDog
IiIpOwoKPiBIZW5jZSwKPiBJIGFtIHdvbmRlcmluZyBob3cgY291bGQgaXQgd29yaz8gQSBidWcg
b3IgSSBtaXNzZWQgYW55dGhpbmc/CgpJdCBpcyByZWFsbHkganVzdCB1c2VkIGZvciBpbmZvcm1h
dGl2ZSBwdXJwb3NlIG5vdy4KClRoYW5rcywKam9obgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGlu
dXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxt
YW4vbGlzdGluZm8vaW9tbXU=
