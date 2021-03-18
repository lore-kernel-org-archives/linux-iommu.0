Return-Path: <SRS0=56b4=IQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCCCFC433E0
	for <iommu@archiver.kernel.org>; Thu, 18 Mar 2021 09:55:58 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E89E64F38
	for <iommu@archiver.kernel.org>; Thu, 18 Mar 2021 09:55:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E89E64F38
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B30A741566;
	Thu, 18 Mar 2021 09:55:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xWn5pEDBTQz4; Thu, 18 Mar 2021 09:55:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id B00AF4309E;
	Thu, 18 Mar 2021 09:55:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8ECA5C000A;
	Thu, 18 Mar 2021 09:55:56 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 344E5C0001
 for <iommu@lists.linux-foundation.org>; Thu, 18 Mar 2021 09:55:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 22DE060655
 for <iommu@lists.linux-foundation.org>; Thu, 18 Mar 2021 09:55:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jEe8oTT7HC_P for <iommu@lists.linux-foundation.org>;
 Thu, 18 Mar 2021 09:55:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 73BBD60650
 for <iommu@lists.linux-foundation.org>; Thu, 18 Mar 2021 09:55:53 +0000 (UTC)
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
 by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4F1Mmh10mJz8ylP;
 Thu, 18 Mar 2021 17:53:56 +0800 (CST)
Received: from [127.0.0.1] (10.40.193.166) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.498.0; Thu, 18 Mar 2021
 17:55:46 +0800
Subject: Re: [PATCH] iommu/dma: Fix a typo in a comment
To: Will Deacon <will@kernel.org>
References: <1616037684-59399-1-git-send-email-chenxiang66@hisilicon.com>
 <20210318093410.GA6574@willie-the-truck>
From: "chenxiang (M)" <chenxiang66@hisilicon.com>
Message-ID: <c378734f-33d5-1426-fa41-2bd8064ceec4@hisilicon.com>
Date: Thu, 18 Mar 2021 17:55:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20210318093410.GA6574@willie-the-truck>
X-Originating-IP: [10.40.193.166]
X-CFilter-Loop: Reflected
Cc: iommu@lists.linux-foundation.org, robin.murphy@arm.com
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

SGkgd2lsbCwKCgrlnKggMjAyMS8zLzE4IDE3OjM0LCBXaWxsIERlYWNvbiDlhpnpgZM6Cj4gT24g
VGh1LCBNYXIgMTgsIDIwMjEgYXQgMTE6MjE6MjRBTSArMDgwMCwgY2hlbnhpYW5nIHdyb3RlOgo+
PiBGcm9tOiBYaWFuZyBDaGVuIDxjaGVueGlhbmc2NkBoaXNpbGljb24uY29tPgo+Pgo+PiBGaXgg
YSB0eXBlICJTQUMiIHRvICJEQUMiIGluIHRoZSBjb21tZW50IG9mIGZ1bmN0aW9uCj4+IGlvbW11
X2RtYV9hbGxvY19pb3ZhKCkuCj4+Cj4+IFNpZ25lZC1vZmYtYnk6IFhpYW5nIENoZW4gPGNoZW54
aWFuZzY2QGhpc2lsaWNvbi5jb20+Cj4+IC0tLQo+PiAgIGRyaXZlcnMvaW9tbXUvZG1hLWlvbW11
LmMgfCAyICstCj4+ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9u
KC0pCj4+Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L2RtYS1pb21tdS5jIGIvZHJpdmVy
cy9pb21tdS9kbWEtaW9tbXUuYwo+PiBpbmRleCBhZjc2NWM4Li4zYmMxN2VlIDEwMDY0NAo+PiAt
LS0gYS9kcml2ZXJzL2lvbW11L2RtYS1pb21tdS5jCj4+ICsrKyBiL2RyaXZlcnMvaW9tbXUvZG1h
LWlvbW11LmMKPj4gQEAgLTQ0Myw3ICs0NDMsNyBAQCBzdGF0aWMgZG1hX2FkZHJfdCBpb21tdV9k
bWFfYWxsb2NfaW92YShzdHJ1Y3QgaW9tbXVfZG9tYWluICpkb21haW4sCj4+ICAgCWlmIChkb21h
aW4tPmdlb21ldHJ5LmZvcmNlX2FwZXJ0dXJlKQo+PiAgIAkJZG1hX2xpbWl0ID0gbWluKGRtYV9s
aW1pdCwgKHU2NClkb21haW4tPmdlb21ldHJ5LmFwZXJ0dXJlX2VuZCk7Cj4+ICAgCj4+IC0JLyog
VHJ5IHRvIGdldCBQQ0kgZGV2aWNlcyBhIFNBQyBhZGRyZXNzICovCj4+ICsJLyogVHJ5IHRvIGdl
dCBQQ0kgZGV2aWNlcyBhIERBQyBhZGRyZXNzICovCj4+ICAgCWlmIChkbWFfbGltaXQgPiBETUFf
QklUX01BU0soMzIpICYmIGRldl9pc19wY2koZGV2KSkKPj4gICAJCWlvdmEgPSBhbGxvY19pb3Zh
X2Zhc3QoaW92YWQsIGlvdmFfbGVuLAo+PiAgIAkJCQkgICAgICAgRE1BX0JJVF9NQVNLKDMyKSA+
PiBzaGlmdCwgZmFsc2UpOwo+IFRoaXMgZG9lc24ndCBsb29rIGxpa2UgYSB0eXBvIHRvIG1lLi4u
IFBsZWFzZSBleHBsYWluLgoKSSB0aGluayBpdCBtZWFucyBkb3VibGUtYWRkcmVzcyBjeWNsZShE
QUMpLCBhbmQgaW4gTExEMyA0NTIgcGFnZSwgdGhlcmUgCmlzIGEgZGVzY3JpcHRpb24gYWJvdXQg
aXQgIlBDSSBkb3VibGUtYWRkcmVzcyBjeWNsZSBtYXBwaW5ncyBOb3JtYWxseSwKdGhlIERNQSBz
dXBwb3J0IGxheWVyIHdvcmtzIHdpdGggMzItYml0IGJ1cyBhZGRyZXNzZXMsIHBvc3NpYmx5IApy
ZXN0cmljdGVkIGJ5IGEgc3BlY2lmaWMgZGV2aWNl4oCZcyBETUEgbWFzay4gVGhlIFBDSSBidXMs
IGhvd2V2ZXIsIGFsc28gCnN1cHBvcnRzIGEgNjQtYml0IGFkZHJlc3NpbmcgbW9kZSwgdGhlIGRv
dWJsZS1hZGRyZXNzIGN5Y2xlIChEQUMpLiIKUGxlYXNlIHBvaW50IGl0IG91dCBpZiBpIGFtIHdy
b25nIDopCgpCZXN0IFJlZ2FyZHMsCmNoZW54aWFuZwoKPgo+IFdpbGwKPgo+IC4KPgoKCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcg
bGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4
Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
