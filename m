Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA27FC433EF
	for <iommu@archiver.kernel.org>; Wed,  1 Jun 2022 09:44:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6FCE981B14;
	Wed,  1 Jun 2022 09:44:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PyD93ppYohVu; Wed,  1 Jun 2022 09:44:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 5E30981BF5;
	Wed,  1 Jun 2022 09:44:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 324F8C0039;
	Wed,  1 Jun 2022 09:44:40 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 477E6C002D
 for <iommu@lists.linux-foundation.org>; Wed,  1 Jun 2022 09:44:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 31EB881BF5
 for <iommu@lists.linux-foundation.org>; Wed,  1 Jun 2022 09:44:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pLNePUqJbXUR for <iommu@lists.linux-foundation.org>;
 Wed,  1 Jun 2022 09:44:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3459C81B14
 for <iommu@lists.linux-foundation.org>; Wed,  1 Jun 2022 09:44:36 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4F56FED1;
 Wed,  1 Jun 2022 02:44:36 -0700 (PDT)
Received: from [10.57.81.38] (unknown [10.57.81.38])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DBB503F66F;
 Wed,  1 Jun 2022 02:44:34 -0700 (PDT)
Message-ID: <408315d1-9820-65d0-c0a7-cc038bfa9eb1@arm.com>
Date: Wed, 1 Jun 2022 10:44:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 10/10] dmapool: improve scalability of dma_pool_free
Content-Language: en-GB
To: Tony Battersby <tonyb@cybernetics.com>, Keith Busch <kbusch@kernel.org>
References: <9b08ab7c-b80b-527d-9adf-7716b0868fbc@cybernetics.com>
 <801335ba-00f3-12ae-59e0-119d7d8fd8cd@cybernetics.com>
 <YpaOj/C1SA8y1VCg@kbusch-mbp.dhcp.thefacebook.com>
 <803feeab-b27b-983d-45da-02a0daf0179a@cybernetics.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <803feeab-b27b-983d-45da-02a0daf0179a@cybernetics.com>
Cc: Tony Lindgren <tony@atomide.com>, iommu@lists.linux-foundation.org,
 Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, Andy Shevchenko <andy.shevchenko@gmail.com>,
 kernel-team@fb.com
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

T24gMjAyMi0wNS0zMSAyMzoxMCwgVG9ueSBCYXR0ZXJzYnkgd3JvdGU6Cj4gT24gNS8zMS8yMiAx
Nzo1NCwgS2VpdGggQnVzY2ggd3JvdGU6Cj4+IE9uIFR1ZSwgTWF5IDMxLCAyMDIyIGF0IDAyOjIz
OjQ0UE0gLTA0MDAsIFRvbnkgQmF0dGVyc2J5IHdyb3RlOgo+Pj4gZG1hX3Bvb2xfZnJlZSgpIHNj
YWxlcyBwb29ybHkgd2hlbiB0aGUgcG9vbCBjb250YWlucyBtYW55IHBhZ2VzIGJlY2F1c2UKPj4+
IHBvb2xfZmluZF9wYWdlKCkgZG9lcyBhIGxpbmVhciBzY2FuIG9mIGFsbCBhbGxvY2F0ZWQgcGFn
ZXMuICBJbXByb3ZlIGl0cwo+Pj4gc2NhbGFiaWxpdHkgYnkgcmVwbGFjaW5nIHRoZSBsaW5lYXIg
c2NhbiB3aXRoIGEgcmVkLWJsYWNrIHRyZWUgbG9va3VwLgo+Pj4gSW4gYmlnIE8gbm90YXRpb24s
IHRoaXMgaW1wcm92ZXMgdGhlIGFsZ29yaXRobSBmcm9tIE8obl4yKSB0byBPKG4gKiBsb2cgbiku
Cj4+IFRoZSBpbXByb3ZlbWVudCBzaG91bGQgc2F5IE8obikgdG8gTyhsb2cgbiksIHJpZ2h0Pwo+
IAo+IFRoYXQgd291bGQgYmUgdGhlIGltcHJvdmVtZW50IGZvciBhIHNpbmdsZSBjYWxsIHRvIGRt
YV9wb29sX2FsbG9jIG9yCj4gZG1hX3Bvb2xfZnJlZSwgYnV0IEkgd2FzIGdvaW5nIHdpdGggdGhl
IGltcHJvdmVtZW50IGZvciAibiIgY2FsbHMKPiBpbnN0ZWFkLCB3aGljaCBpcyBjb25zaXN0ZW50
IHdpdGggdGhlIGltcHJvdmVtZW50IGZvciB0aGUgZXhhbXBsZSBpbiB0aGUKPiBjb3ZlciBsZXR0
ZXIgZm9yIG1wdDNzYXMuwqAgSSB3b3VsZCBoYXZlIHRvIGxvb2sgdXAgdGhlIGNvbnZlbnRpb24g
dG8gYmUKPiBzdXJlIG9mIHRoZSBwcm9wZXIgbm90YXRpb24gaW4gYSBzaXR1YXRpb24gbGlrZSB0
aGlzLCBidXQgSSB1c3VhbGx5Cj4gdGhpbmsgImluc2VydGluZyBOIGl0ZW1zIHRha2VzIE5eMiB0
aW1lIjsgdG8gbWUgaXQgbWFrZXMgbGVzcyBzZW5zZSB0bwo+IHNheSAiaW5zZXJ0aW5nIDEgaXRl
bSB0YWtlcyBOIHRpbWUiLCBiZWNhdXNlIHRoZSBOIHNlZW1zIHRvIGNvbWUgb3V0IG9mCj4gbm93
aGVyZS4KCk5vLCBuIHJlcHJlc2VudHMgdGhlIHNpemUgb2YgdGhlIHNldCB0aGF0IHRoZSBhbGdv
cml0aG0gaXMgaW5zZXJ0aW5nIAppbnRvIChvciByZW1vdmluZyBmcm9tLCBzZWFyY2hpbmcgd2l0
aGluLCBldGMuKS4gSGVuY2Ugd2h5IGNvbnN0YW50IHRpbWUgCmlzIHJlcHJlc2VudGVkIGJ5IE8o
MSksIGkuZS4gbm90IGludm9sdmluZyB0aGUgdmFyaWFibGUgYXQgYWxsLgoKUm9iaW4uCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcg
bGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4
Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
