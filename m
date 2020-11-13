Return-Path: <SRS0=vtxH=ET=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA84CC4742C
	for <iommu@archiver.kernel.org>; Fri, 13 Nov 2020 10:43:30 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A3EB20678
	for <iommu@archiver.kernel.org>; Fri, 13 Nov 2020 10:43:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A3EB20678
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id ADD00877B6;
	Fri, 13 Nov 2020 10:43:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IwG8PkYKbj1f; Fri, 13 Nov 2020 10:43:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 6AA448779E;
	Fri, 13 Nov 2020 10:43:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 58471C088E;
	Fri, 13 Nov 2020 10:43:27 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B4402C0800
 for <iommu@lists.linux-foundation.org>; Fri, 13 Nov 2020 10:43:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 9A9ED871E9
 for <iommu@lists.linux-foundation.org>; Fri, 13 Nov 2020 10:43:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QTgeI3NtFnBS for <iommu@lists.linux-foundation.org>;
 Fri, 13 Nov 2020 10:43:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by whitealder.osuosl.org (Postfix) with ESMTPS id E4BDA86BE2
 for <iommu@lists.linux-foundation.org>; Fri, 13 Nov 2020 10:43:23 +0000 (UTC)
Received: from fraeml708-chm.china.huawei.com (unknown [172.18.147.200])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4CXZl22YsHz67KSS;
 Fri, 13 Nov 2020 18:41:18 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml708-chm.china.huawei.com (10.206.15.36) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Fri, 13 Nov 2020 11:43:16 +0100
Received: from [10.47.88.104] (10.47.88.104) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Fri, 13 Nov
 2020 10:43:16 +0000
Subject: Re: [PATCH v2 0/2] iommu/arm-smmu-v3: Improve cmdq lock efficiency
From: John Garry <john.garry@huawei.com>
To: Will Deacon <will@kernel.org>
References: <1598018062-175608-1-git-send-email-john.garry@huawei.com>
 <20200921134324.GK2139@willie-the-truck>
 <b13d0858-e164-4670-a5c6-ab84e81724b7@huawei.com>
Message-ID: <ca5a0f5f-91fb-4c11-f158-44e16343cdb2@huawei.com>
Date: Fri, 13 Nov 2020 10:43:06 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <b13d0858-e164-4670-a5c6-ab84e81724b7@huawei.com>
Content-Language: en-US
X-Originating-IP: [10.47.88.104]
X-ClientProxiedBy: lhreml752-chm.china.huawei.com (10.201.108.202) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Cc: maz@kernel.org, linuxarm@huawei.com, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, robin.murphy@arm.com,
 linux-arm-kernel@lists.infradead.org
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

T24gMjEvMDkvMjAyMCAxNDo1OCwgSm9obiBHYXJyeSB3cm90ZToKPiBPbiAyMS8wOS8yMDIwIDE0
OjQzLCBXaWxsIERlYWNvbiB3cm90ZToKPj4gT24gRnJpLCBBdWcgMjEsIDIwMjAgYXQgMDk6NTQ6
MjBQTSArMDgwMCwgSm9obiBHYXJyeSB3cm90ZToKPj4+IEFzIG1lbnRpb25lZCBpbiBbMF0sIHRo
ZSBDUFUgbWF5IGNvbnN1bWUgbWFueSBjeWNsZXMgcHJvY2Vzc2luZwo+Pj4gYXJtX3NtbXVfY21k
cV9pc3N1ZV9jbWRsaXN0KCkuIE9uZSBpc3N1ZSB3ZSBmaW5kIGlzIHRoZSBjbXB4Y2hnKCkgCj4+
PiBsb29wIHRvCj4+PiBnZXQgc3BhY2Ugb24gdGhlIHF1ZXVlIHRha2VzIGEgbG90IG9mIHRpbWUg
b25jZSB3ZSBzdGFydCBnZXR0aW5nIG1hbnkKPj4+IENQVXMgY29udGVuZGluZyAtIGZyb20gZXhw
ZXJpbWVudCwgZm9yIDY0IENQVXMgY29udGVuZGluZyB0aGUgY21kcSwKPj4+IHN1Y2Nlc3MgcmF0
ZSBpcyB+IDEgaW4gMTIsIHdoaWNoIGlzIHBvb3IsIGJ1dCBub3QgdG90YWxseSBhd2Z1bC4KPj4+
Cj4+PiBUaGlzIHNlcmllcyByZW1vdmVzIHRoYXQgY21weGNoZygpIGFuZCByZXBsYWNlcyB3aXRo
IGFuIGF0b21pY19hZGQsCj4+PiBzYW1lIGFzIGhvdyB0aGUgYWN0dWFsIGNtZHEgZGVhbHMgd2l0
aCBtYWludGFpbmluZyB0aGUgcHJvZCBwb2ludGVyLgo+PiDCoD4gSSdtIHN0aWxsIG5vdCBhIGZh
biBvZiB0aGlzLgo+IAo+IDooCj4gCj4+IENvdWxkIHlvdSB0cnkgdG8gYWRhcHQgdGhlIGhhY2tz
IEkgc2VudCBiZWZvcmUsCj4+IHBsZWFzZT8gSSBrbm93IHRoZXkgd2VyZW4ndCBxdWl0ZSByaWdo
dCAoSSBoYXZlIG5vIGhhcmR3YXJlIHRvIHRlc3QgCj4+IG9uKSwgYnV0Cj4+IHRoZSBiYXNpYyBp
ZGVhIGlzIHRvIGZhbGwgYmFjayB0byBhIHNwaW5sb2NrIGlmIHRoZSBjbXB4Y2hnKCkgZmFpbHMu
IFRoZQo+PiBxdWV1ZWluZyBpbiB0aGUgc3BpbmxvY2sgaW1wbGVtZW50YXRpb24gc2hvdWxkIGF2
b2lkIHRoZSBjb250ZW50aW9uLgo+IAo+IE9LLCBzbyBpZiB5b3UncmUgYXNraW5nIG1lIHRvIHRy
eSB0aGlzIGFnYWluLCB0aGVuIEkgY2FuIGRvIHRoYXQsIGFuZCAKPiBzZWUgd2hhdCBpdCBnaXZl
cyB1cy4KPiAKCkpGWUksIHRvIHByb3ZlIHRoYXQgdGhpcyBpcyBub3QgYSBwcm9ibGVtIHdoaWNo
IGFmZmVjdHMgb25seSBvdXIgSFcsIEkgCm1hbmFnZWQgdG8gdGVzdCBhbiBhcm02NCBwbGF0Zm9y
bSBmcm9tIGFub3RoZXIgdmVuZG9yLiBHZW5lcmFsbHkgSSBzZWUgCnRoZSBzYW1lIGlzc3VlLCBh
bmQgdGhpcyBwYXRjaHNldCBhY3R1YWxseSBoZWxwcyB0aGF0IHBsYXRmb3JtIGV2ZW4gbW9yZS4K
CgkJQ1BVcwlCZWZvcmUJQWZ0ZXIJJSBJbmNyZWFzZQpIdWF3ZWkgRDA2CTgJMjgySwkzMDJLCTcl
Ck90aGVyCQkJMzc5Swk0MjBLCTExJQoKSHVhd2VpIEQwNgkxNgkxMTVLCTE5M0sJNjhLCk90aGVy
CQkJMTAySwkyOTFLCTE4NUsKCkh1YXdlaSBEMDYJMzIJMzZLCTgwSwkxMjIlCk90aGVyCQkJNDFL
CTE1NksJMjgwJQoKSHVhd2VpIEQwNgk2NAkxMUsJMzBLCTE3MiUKT3RoZXIJCQk2Swk0N0sJNjgz
JQoKSSB0ZXN0ZWQgd2l0aCBzb21ldGhpbmcgbGlrZSBbMV0sIHNvIHVuaXQgaXMgbWFwK3VubWFw
cyBwZXIgY3B1IHBlciAKc2Vjb25kIC0gaGlnaGVyIGlzIGJldHRlci4KCk15IEQwNiBpcyBtZW1v
cnkgcG9vciwgc28gd291bGQgZXhwZWN0IGhpZ2hlciByZXN1bHRzIG90aGVyd2lzZSAod2l0aCAK
bW9yZSBtZW1vcnkpLiBJbmRlZWQsIG15IEQwNSBoYXMgbWVtb3J5IG9uIGFsbCBub2RlcyBhbmQg
cGVyZm9ybXMgYmV0dGVyLgoKQW55d2F5LCBJIHNlZSB0aGF0IHRoZSBpbXBsZW1lbnRhdGlvbiBo
ZXJlIGlzIG5vdCBwZXJmZWN0LCBhbmQgSSBjb3VsZCAKbm90IGdldCBzdWdnZXN0ZWQgYXBwcm9h
Y2ggdG8gaW1wcm92ZSBwZXJmb3JtYW5jZSBzaWduaWZpY2FudGx5LiBTbyBiYWNrIAp0byB0aGUg
ZHJhd2luZyBib2FyZC4uLgoKVGhhbmtzLApKb2huCgpbMV0gCmh0dHBzOi8vbG9yZS5rZXJuZWwu
b3JnL2xpbnV4LWlvbW11LzIwMjAxMTAyMDgwNjQ2LjIxODAtMS1zb25nLmJhby5odWFAaGlzaWxp
Y29uLmNvbS8KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRw
czovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
