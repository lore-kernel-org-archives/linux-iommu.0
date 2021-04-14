Return-Path: <SRS0=7Zqx=JL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15B59C433B4
	for <iommu@archiver.kernel.org>; Wed, 14 Apr 2021 20:25:36 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A276961158
	for <iommu@archiver.kernel.org>; Wed, 14 Apr 2021 20:25:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A276961158
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6854940692;
	Wed, 14 Apr 2021 20:25:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Di41qP5j2W8R; Wed, 14 Apr 2021 20:25:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0B64F402CD;
	Wed, 14 Apr 2021 20:25:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DBAD4C000B;
	Wed, 14 Apr 2021 20:25:33 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6F71BC000A
 for <iommu@lists.linux-foundation.org>; Wed, 14 Apr 2021 20:25:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5D95784457
 for <iommu@lists.linux-foundation.org>; Wed, 14 Apr 2021 20:25:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=embeddedor.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5yEqA71p5tsm for <iommu@lists.linux-foundation.org>;
 Wed, 14 Apr 2021 20:25:32 +0000 (UTC)
X-Greylist: delayed 00:21:02 by SQLgrey-1.8.0
Received: from gateway33.websitewelcome.com (gateway33.websitewelcome.com
 [192.185.145.4])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4D6748444D
 for <iommu@lists.linux-foundation.org>; Wed, 14 Apr 2021 20:25:32 +0000 (UTC)
Received: from cm10.websitewelcome.com (cm10.websitewelcome.com [100.42.49.4])
 by gateway33.websitewelcome.com (Postfix) with ESMTP id 19D63D79945
 for <iommu@lists.linux-foundation.org>;
 Wed, 14 Apr 2021 15:04:20 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22]) by cmsmtp with SMTP
 id WlkJl9FAIL7DmWlkJlM7Bb; Wed, 14 Apr 2021 15:04:20 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=I55bdEFQX4moo7BAVIRls7hGJWpEXoU8cYRMSjJc/ns=; b=SpJOcVLYwguf8IF31YAypIuX5M
 zt7P8mqVXdcqQ7CdS4VxwIPQIdU1El+WOZH/z4clqIC0tra3ff7o1vX9915F8qeX4CphNwuzJOAxl
 CCYzMEEaQnxbZhYvimw8ZGh4O9MQ9xDRdM2DzkIRNSnAwX3dOV1akmqN9ITjTk56o2VlgwQt0A6KX
 f/6qimDjq+bQ5JmmJmW4ztGacvkxNy0vnsmc658IIncahYUXeV+XabjEJD0DaKUeeatjdJQ8dP2UW
 MeR+MIQDyHp0pb5fR4ucU1WVKhnuE2g5Eop6sp7cYV2ex6Q+hSVo9UCGcK3R7ywECgPqh+DcjtWZ1
 zF8JXocw==;
Received: from 187-162-31-110.static.axtel.net ([187.162.31.110]:60882
 helo=[192.168.15.8])
 by gator4166.hostgator.com with esmtpsa (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.94)
 (envelope-from <gustavo@embeddedor.com>)
 id 1lWlkG-000GGN-IV; Wed, 14 Apr 2021 15:04:16 -0500
Subject: Re: [PATCH][next] iommu/vt-d: Fix out-bounds-warning in
 intel_svm_page_response()
To: Lu Baolu <baolu.lu@linux.intel.com>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>
References: <20210413195409.GA322376@embeddedor>
 <61b37f83-eb9e-cf81-c5e6-ca322f76f490@linux.intel.com>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <4ffdd120-d46d-f44e-ba66-000e95fc9b1a@embeddedor.com>
Date: Wed, 14 Apr 2021 15:04:24 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <61b37f83-eb9e-cf81-c5e6-ca322f76f490@linux.intel.com>
Content-Language: en-US
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - lists.linux-foundation.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.162.31.110
X-Source-L: No
X-Exim-ID: 1lWlkG-000GGN-IV
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-31-110.static.axtel.net ([192.168.15.8])
 [187.162.31.110]:60882
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 6
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
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

SGkgQmFsb3UsCgpPbiA0LzE0LzIxIDAwOjI0LCBMdSBCYW9sdSB3cm90ZToKPiBIaSBHdXN0YXZv
LAo+IAo+IE9uIDQvMTQvMjEgMzo1NCBBTSwgR3VzdGF2byBBLiBSLiBTaWx2YSB3cm90ZToKPj4g
UmVwbGFjZSBjYWxsIHRvIG1lbWNweSgpIHdpdGgganVzdCBhIGNvdXBsZSBvZiBzaW1wbGUgYXNz
aWdubWVudHMgaW4KPj4gb3JkZXIgdG8gZml4IHRoZSBmb2xsb3dpbmcgb3V0LW9mLWJvdW5kcyB3
YXJuaW5nOgo+Pgo+PiBkcml2ZXJzL2lvbW11L2ludGVsL3N2bS5jOjExOTg6NDogd2FybmluZzog
J21lbWNweScgb2Zmc2V0IFsyNSwgMzJdIGZyb20gdGhlIG9iamVjdCBhdCAnZGVzYycgaXMgb3V0
IG9mIHRoZSBib3VuZHMgb2YgcmVmZXJlbmNlZCBzdWJvYmplY3QgJ3F3Micgd2l0aCB0eXBlCj4+
ICdsb25nIGxvbmcgdW5zaWduZWQgaW50JyBhdCBvZmZzZXQgMTYgWy1XYXJyYXktYm91bmRzXQo+
Pgo+PiBUaGUgcHJvYmxlbSBpcyB0aGF0IHRoZSBvcmlnaW5hbCBjb2RlIGlzIHRyeWluZyB0byBj
b3B5IGRhdGEgaW50byBhCj4+IGNvdXBsZSBvZiBzdHJ1Y3QgbWVtYmVycyBhZGphY2VudCB0byBl
YWNoIG90aGVyIGluIGEgc2luZ2xlIGNhbGwgdG8KPj4gbWVtY3B5KCkuIFRoaXMgY2F1c2VzIGEg
bGVnaXRpbWF0ZSBjb21waWxlciB3YXJuaW5nIGJlY2F1c2UgbWVtY3B5KCkKPj4gb3ZlcnJ1bnMg
dGhlIGxlbmd0aCBvZiAmZGVzYy5xdzIuCj4+Cj4+IFRoaXMgaGVscHMgd2l0aCB0aGUgb25nb2lu
ZyBlZmZvcnRzIHRvIGdsb2JhbGx5IGVuYWJsZSAtV2FycmF5LWJvdW5kcwo+PiBhbmQgZ2V0IHVz
IGNsb3NlciB0byBiZWluZyBhYmxlIHRvIHRpZ2h0ZW4gdGhlIEZPUlRJRllfU09VUkNFIHJvdXRp
bmVzCj4+IG9uIG1lbWNweSgpLgo+Pgo+PiBMaW5rOiBodHRwczovL2dpdGh1Yi5jb20vS1NQUC9s
aW51eC9pc3N1ZXMvMTA5Cj4+IFNpZ25lZC1vZmYtYnk6IEd1c3Rhdm8gQS4gUi4gU2lsdmEgPGd1
c3Rhdm9hcnNAa2VybmVsLm9yZz4KPj4gLS0tCj4+IMKgIGRyaXZlcnMvaW9tbXUvaW50ZWwvc3Zt
LmMgfCA3ICsrKystLS0KPj4gwqAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgMyBk
ZWxldGlvbnMoLSkKPj4KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW9tbXUvaW50ZWwvc3ZtLmMg
Yi9kcml2ZXJzL2lvbW11L2ludGVsL3N2bS5jCj4+IGluZGV4IDUxNjVjZWE5MDQyMS4uNjU5MDlm
NTA0YzUwIDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJzL2lvbW11L2ludGVsL3N2bS5jCj4+ICsrKyBi
L2RyaXZlcnMvaW9tbXUvaW50ZWwvc3ZtLmMKPj4gQEAgLTExOTQsOSArMTE5NCwxMCBAQCBpbnQg
aW50ZWxfc3ZtX3BhZ2VfcmVzcG9uc2Uoc3RydWN0IGRldmljZSAqZGV2LAo+PiDCoMKgwqDCoMKg
wqDCoMKgwqAgZGVzYy5xdzEgPSBRSV9QR1JQX0lEWChwcm0tPmdycGlkKSB8IFFJX1BHUlBfTFBJ
RyhsYXN0X3BhZ2UpOwo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgZGVzYy5xdzIgPSAwOwo+PiDCoMKg
wqDCoMKgwqDCoMKgwqAgZGVzYy5xdzMgPSAwOwo+PiAtwqDCoMKgwqDCoMKgwqAgaWYgKHByaXZh
dGVfcHJlc2VudCkKPj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbWVtY3B5KCZkZXNjLnF3Miwg
cHJtLT5wcml2YXRlX2RhdGEsCj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgc2l6ZW9mKHBybS0+cHJpdmF0ZV9kYXRhKSk7Cj4gCj4gVGhlIHNhbWUgbWVtY3B5KCkgaXMg
dXNlZCBpbiBtdWx0aXBsZSBwbGFjZXMgaW4gdGhpcyBmaWxlLiBEaWQgdGhleQo+IGNvbXBpbGUg
dGhlIHNhbWUgd2FybmluZ3M/IE9yIHRoZXJlIGFyZSBtdWx0aXBsZSBwYXRjaGVzIHRvIGZpeCB0
aGVtCj4gb25lIGJ5IG9uZT8KCkkganVzdCBzZWUgb25lIG1vcmUgaW5zdGFuY2Ugb2YgdGhpcyBz
YW1lIGNhc2U6CgoxMDIzICAgICAgICAgICAgICAgICAgICAgICAgIGlmIChyZXEtPnByaXZfZGF0
YV9wcmVzZW50KQoxMDI0ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgbWVtY3B5KCZy
ZXNwLnF3MiwgcmVxLT5wcml2X2RhdGEsCjEwMjUgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgc2l6ZW9mKHJlcS0+cHJpdl9kYXRhKSk7CgpJIG1pc3NlZCBpdCBhbmQgSSds
bCBhZGRyZXNzIGl0IGluIHYyLiBEbyB5b3Ugc2VlIGFub3RoZXIgb25lPwoKVGhhbmtzIGZvciB0
aGUgZmVlZGJhY2shCi0tCkd1c3Rhdm8KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3Vu
ZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0
aW5mby9pb21tdQ==
