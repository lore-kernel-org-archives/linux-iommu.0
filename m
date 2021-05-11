Return-Path: <SRS0=AxcK=KG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B449FC43461
	for <iommu@archiver.kernel.org>; Tue, 11 May 2021 16:16:53 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 126BB61920
	for <iommu@archiver.kernel.org>; Tue, 11 May 2021 16:16:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 126BB61920
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A2E5B40574;
	Tue, 11 May 2021 16:16:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BrjKsVpnQlkU; Tue, 11 May 2021 16:16:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 58E0240577;
	Tue, 11 May 2021 16:16:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2D8EFC000E;
	Tue, 11 May 2021 16:16:51 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A701BC0001
 for <iommu@lists.linux-foundation.org>; Tue, 11 May 2021 16:16:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 91234605FE
 for <iommu@lists.linux-foundation.org>; Tue, 11 May 2021 16:16:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=deltatee.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ie4rQYf5LaQS for <iommu@lists.linux-foundation.org>;
 Tue, 11 May 2021 16:16:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
 by smtp3.osuosl.org (Postfix) with ESMTPS id F1941605A4
 for <iommu@lists.linux-foundation.org>; Tue, 11 May 2021 16:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:Cc:To:content-disposition;
 bh=qGEiJKxfeZlmzsrJW3D8SgKWMOzFWWlWIF4SmeuVBPk=; b=ntkDNl1ZjZzOkVld9EYsyBSR1g
 ccd5oF9LMU67fzPYv90Fwd4Y1irj0V7v+J2klm0JE5M1ASoPOI1v0sVaTjnacpcS7HVdLPMGZV53T
 Voce44zY08R7yplObv7E+p1wa3HXD+WtmqJblO81rvwsCCqqF7TCljrzQSVWdPadK8YUd1giXo/Id
 mQxd8+ma4bxpKkqwsmr5XLNJqp1HOZcmOKxXmN0mc0yd6UeCYgkSE8YEBTkEIOjJLydxxDyOyvbvR
 mMI1FijYE0fyHBeqo+wH0Wg6i0iNhQohX2tpxc/fQ6jXzWaqfrVm5nJt/xrQzecC6pVVLM788y8OF
 KTnNa/sw==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
 by ale.deltatee.com with esmtp (Exim 4.92)
 (envelope-from <logang@deltatee.com>)
 id 1lgV3p-0006e9-2V; Tue, 11 May 2021 10:16:42 -0600
To: Don Dutile <ddutile@redhat.com>, John Hubbard <jhubbard@nvidia.com>,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org
References: <20210408170123.8788-1-logang@deltatee.com>
 <20210408170123.8788-3-logang@deltatee.com>
 <d6220bff-83fc-6c03-76f7-32e9e00e40fd@nvidia.com>
 <a6830332-c866-451f-3c6a-585cbf295ff8@redhat.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <65ae4aa7-b646-c270-6c51-2e9c686c5f03@deltatee.com>
Date: Tue, 11 May 2021 10:16:40 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <a6830332-c866-451f-3c6a-585cbf295ff8@redhat.com>
Content-Language: en-CA
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: robin.murphy@arm.com, ira.weiny@intel.com,
 helgaas@kernel.org, jianxin.xiong@intel.com, dave.hansen@linux.intel.com,
 jason@jlekstrand.net, dave.b.minturn@intel.com, andrzej.jakowski@intel.com,
 daniel.vetter@ffwll.ch, willy@infradead.org, christian.koenig@amd.com,
 jgg@ziepe.ca, dan.j.williams@intel.com, hch@lst.de, sbates@raithlin.com,
 iommu@lists.linux-foundation.org, linux-mm@kvack.org,
 linux-pci@vger.kernel.org, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 jhubbard@nvidia.com, ddutile@redhat.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH 02/16] PCI/P2PDMA: Avoid pci_get_slot() which sleeps
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Cc: Minturn Dave B <dave.b.minturn@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Daniel Vetter <daniel.vetter@ffwll.ch>,
 Dave Hansen <dave.hansen@linux.intel.com>, Robin Murphy <robin.murphy@arm.com>,
 Matthew Wilcox <willy@infradead.org>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Bjorn Helgaas <helgaas@kernel.org>,
 Jason Ekstrand <jason@jlekstrand.net>, Dan Williams <dan.j.williams@intel.com>,
 Stephen Bates <sbates@raithlin.com>,
 Jakowski Andrzej <andrzej.jakowski@intel.com>, Christoph Hellwig <hch@lst.de>,
 Xiong Jianxin <jianxin.xiong@intel.com>
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

CgpPbiAyMDIxLTA1LTExIDEwOjA1IGEubS4sIERvbiBEdXRpbGUgd3JvdGU6Cj4gLi4uIGFkZCBh
IGZsYWcgKHNldCBmb3IgcDJwZG1hIHVzZSnCoCB0byB0aGUgZnVuY3Rpb24gdG8gcHJpbnQgb3V0
IHdoYXQgdGhlIHJvb3QtPmRldmZuIGlzLCBhbmQgd2hhdAo+IHRoZSBkZXZpY2UgaXMgc28gdGhl
IG5lZWRlZCBxdWlyayAmL29yIG1vZGlmaWNhdGlvbiBjYW4gYWRkZWQgdG8gaGFuZGxlIHdoZW4g
dGhpcyBhc3N1bXB0aW9uIGZhaWxzOwo+IG9yIG1ha2UgaXQgYSBwcmRlYnVnIHRoYXQgY2FuIGJl
IGZsaXBwZWQgb24gZm9yIHRoaXMgZmFpbGluZyBzaXR1YXRpb24sIGFnYWluLCB0byBhZGQgbmVl
ZGVkIGNoYW5nZSB0byBhY2NvbW9kYXRlLgoKR29vZCBpZGVhISBXaWxsIGFkZC4KCj4+IMKgwqDC
oMKgcm9vdCA9IE5VTEw7Cj4+IMKgb3V0Ogo+PiDCoMKgwqDCoHBjaV9kZXZfZ2V0KHJvb3QpOwo+
PiDCoMKgwqDCoHJldHVybiByb290Owo+PiB9Cj4+IEVYUE9SVF9TWU1CT0wocGNpX2dldF9yb290
X3Nsb3QpOwo+Pgo+PiAuLi5JIHRoaW5rIHRoYXQncyBhIGxvdCBjbGVhcmVyIHRvIHRoZSByZWFk
ZXIsIGFib3V0IHdoYXQncyBnb2luZyBvbiBoZXJlLgo+Pgo+PiBOb3RlIHRoYXQgSSdtIG5vdCBy
ZWFsbHkgc3VyZSBpZiBpdCAqaXMqIHNhZmUsIEkgd291bGQgbmVlZCB0byBhc2sgb3RoZXIKPj4g
UENJZSBzdWJzeXN0ZW0gZGV2ZWxvcGVycyB3aXRoIG1vcmUgZXhwZXJpZW5jZS4gQnV0IEkgZG9u
J3QgdGhpbmsgYW55b25lCj4+IGlzIHRyeWluZyB0byBtYWtlIHAycGRtYSBjYWxscyBzbyBlYXJs
eSB0aGF0IFBDSWUgYnVzZXMgYXJlIHVuaW5pdGlhbGl6ZWQuCj4+Cj4+Cj4+PiArCj4+PiArwqDC
oMKgIGlmICghcm9vdCB8fCByb290LT5kZXZmbikKPj4+IMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1
cm4gZmFsc2U7Cj4+PiDCoCDCoMKgwqDCoMKgIHZlbmRvciA9IHJvb3QtPnZlbmRvcjsKPj4+IMKg
wqDCoMKgwqAgZGV2aWNlID0gcm9vdC0+ZGV2aWNlOwo+Pj4gLcKgwqDCoCBwY2lfZGV2X3B1dChy
b290KTsKPiBhbmQgdGhlIHJlYXNvbiB0byByZW1vdmUgdGhlIGRldl9wdXQgaXMgYi9jIGl0IGNh
biBzbGVlcCBhcyB3ZWxsPwo+IGlzIHRoYXQgb2ssIGdpdmVuIHRoZSBkZXZfZ2V0IHRoYXQgSm9o
biBwdXQgaW50byB0aGUgbmV3IHBjaV9nZXRfcm9vdF9zbG90KCk/Cj4gLi4uIHNlZW1zIGxpa2Ug
YSBsb2NraW5nIHZlcnNpb24gd2l0aCBubyBnZXQvcHV0J3MgaXMgbmVlZGVkLCBvciwgZml4IHRo
ZSBob3N0LWJyaWRnZSBzZXR1cHMgc28gbm8gIU5VTEwgc2VsZiBwb2ludGVycy4KClRoZSBkZXZf
Z2V0IGlzIHJlZHVuZGFudCBoZXJlIHNlZWluZyB3ZSBob2xkIHJlZmVyZW5jZXMgdG8gY2hpbGQK
ZGV2aWNlcy4gSXQgd2FzIG9ubHkgaW4gdGhlIHByZXZpb3VzIGNvZGUgYmVjYXVzZSB3ZSB3ZXJl
IHVzaW5nCnBjaV9nZXRfc2xvdCgpIHRvIGdldCB0aGUgZGV2aWNlIHdoaWNoIGRpZCB0aGUgZ2V0
IGZvciB1cy4KCkxvZ2FuCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9y
ZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21t
dQ==
