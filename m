Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE018C433F5
	for <iommu@archiver.kernel.org>; Sat, 11 Dec 2021 14:57:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5156685794;
	Sat, 11 Dec 2021 14:57:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5mzjwUS7B-Uk; Sat, 11 Dec 2021 14:57:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 0E79685791;
	Sat, 11 Dec 2021 14:57:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E3300C0076;
	Sat, 11 Dec 2021 14:57:44 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C47CBC0012;
 Fri, 10 Dec 2021 07:53:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C069B42095;
 Fri, 10 Dec 2021 07:53:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id u28yioexqY0j; Fri, 10 Dec 2021 07:53:54 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com
 [IPv6:2607:f8b0:4864:20::42d])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 33D444204A;
 Fri, 10 Dec 2021 07:53:54 +0000 (UTC)
Received: by mail-pf1-x42d.google.com with SMTP id u80so7745438pfc.9;
 Thu, 09 Dec 2021 23:53:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:to:cc:references
 :from:in-reply-to:content-transfer-encoding;
 bh=ijVBfG1KG/aW/R5+/Gi9cb70eNCVtOkQHVClSlu2XwQ=;
 b=f9zXHqflj7w8rm18C9SRhCSZ0h8uljnpXHk4Vjg37Ib9U6eihTWF8OGGbBbjwovGIt
 WdIAiNb9SNj9vX3/WkE92YG6UOQugvY0wWCTFxfzKL15NKrL4ZQ0uOJvhbWqYEwCfDb+
 G8NUmHY1ychu8qM/0vvRjYBeLSJ92mS9HJ+K6eFJUgLaoCZeHFNNzpVRLU20oxHAz7oL
 6XRb0fJAxHVDdAaUw2xEE3YbeilVIptXXXfmGnzvQKXqOs4PEgYz5Y26V3rag1Fz5q70
 NwCHGKIS6EwduXaYhhahvciWp9RERZCsFd5bJ93Wmf7yqZ3CPDLzKlK7t5ozokyrtfAg
 Jh6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :to:cc:references:from:in-reply-to:content-transfer-encoding;
 bh=ijVBfG1KG/aW/R5+/Gi9cb70eNCVtOkQHVClSlu2XwQ=;
 b=cVMfBmD0Gbm+EEq+kJrgb9wc4uZ1BkRN35hLXFBMmWE5br58hzGhWHowgdlO8biwGl
 Dd+ja6xVXfihBMEIe1/fOseD3VrKqlQqQMP51lGNQoS8dD71vTkNp6MpxGvuaIuUSdOB
 MDfjRwu5C38v7PIrVAtgmM34ehYqq/dfIkHpgkhbbUuPhQOVWoqGrt+AzlQbpKk22kpo
 CAQEOsQLkHq71E6EFqgDiecHtWxxGmSkWUFy2mDRhGtgD5WmXdaseuPBnzL5TKt/ezo2
 9BnlooAgIS27pO9gBm6HzY8rlfmG4oDorsi5ULgUYhf10nLSSnwnmgQD5Z7Dnt4RvFtF
 Y5OQ==
X-Gm-Message-State: AOAM532j53UHoxD5s67Q8GnMIM6aQWOqYlICsctCyBOwCz8y2KbD7F0D
 jhhpHIdWav5UECzVrS7I008=
X-Google-Smtp-Source: ABdhPJwiYQdsfZBv/0L8jEVNhWHsAYR27PUBucnpzzQOeWrnW8MMFcsmzH8CePs6w6mAE1aeqGTsGw==
X-Received: by 2002:a65:5c82:: with SMTP id a2mr39036759pgt.370.1639122833431; 
 Thu, 09 Dec 2021 23:53:53 -0800 (PST)
Received: from [30.240.98.4] ([205.204.117.108])
 by smtp.gmail.com with ESMTPSA id bt2sm1733596pjb.57.2021.12.09.23.53.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Dec 2021 23:53:52 -0800 (PST)
Message-ID: <84807a03-f7d1-83cb-16df-bacc58de4529@gmail.com>
Date: Fri, 10 Dec 2021 15:53:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.2.1
Subject: Re: [RFC PATCH v2 3/7] mm: migrate: allocate the right size of non
 hugetlb or THP compound pages.
To: Zi Yan <ziy@nvidia.com>, David Hildenbrand <david@redhat.com>,
 linux-mm@kvack.org
References: <20211209230414.2766515-1-zi.yan@sent.com>
 <20211209230414.2766515-4-zi.yan@sent.com>
From: Eric Ren <renzhengeek@gmail.com>
In-Reply-To: <20211209230414.2766515-4-zi.yan@sent.com>
X-Mailman-Approved-At: Sat, 11 Dec 2021 14:57:43 +0000
Cc: Mel Gorman <mgorman@techsingularity.net>,
 Michael Ellerman <mpe@ellerman.id.au>, Robin Murphy <robin.murphy@arm.com>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 virtualization@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
 Christoph Hellwig <hch@lst.de>, Vlastimil Babka <vbabka@suse.cz>
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

SGksCgpPbiAyMDIxLzEyLzEwIDA3OjA0LCBaaSBZYW4gd3JvdGU6Cj4gRnJvbTogWmkgWWFuIDx6
aXlAbnZpZGlhLmNvbT4KPgo+IGFsbG9jX21pZ3JhdGlvbl90YXJnZXQoKSBpcyB1c2VkIGJ5IGFs
bG9jX2NvbnRpZ19yYW5nZSgpIGFuZCBub24tTFJVCj4gbW92YWJsZSBjb21wb3VuZCBwYWdlcyBj
YW4gYmUgbWlncmF0ZWQuIEN1cnJlbnQgY29kZSBkb2VzIG5vdCBhbGxvY2F0ZSB0aGUKPiByaWdo
dCBwYWdlIHNpemUgZm9yIHN1Y2ggcGFnZXMuIENoZWNrIFRIUCBwcmVjaXNlbHkgdXNpbmcKPiBp
c190cmFuc3BhcmVudF9odWdlKCkgYW5kIGFkZCBhbGxvY2F0aW9uIHN1cHBvcnQgZm9yIG5vbi1M
UlUgY29tcG91bmQKPiBwYWdlcy4KQ291bGQgeW91IGVsYWJvcmF0ZSBvbiB3aHkgdGhlIGN1cnJl
bnQgY29kZSBkb2Vzbid0IGdldCB0aGUgcmlnaHQgc2l6ZT/CoCAKaG93IHRoaXMgcGF0Y2ggZml4
ZXMgaXQuCgpUaGUgZGVzY3JpcHRpb24gc291bmRzIGxpa2UgaXQncyBhbiBleGlzdGluZyBidWcs
IGlmIHNvLCB0aGUgcGF0Y2ggCnN1YmplY3Qgc2hvdWxkIGJlIGNoYW5nZWQgdG8KIkZpeGVzIC4u
LiI/Cgo+Cj4gU2lnbmVkLW9mZi1ieTogWmkgWWFuIDx6aXlAbnZpZGlhLmNvbT4KPiAtLS0KPiAg
IG1tL21pZ3JhdGUuYyB8IDggKysrKysrLS0KPiAgIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlv
bnMoKyksIDIgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvbW0vbWlncmF0ZS5jIGIvbW0v
bWlncmF0ZS5jCj4gaW5kZXggZDQ4N2EzOTkyNTNiLi4yY2UzYzc3MWIxZGUgMTAwNjQ0Cj4gLS0t
IGEvbW0vbWlncmF0ZS5jCj4gKysrIGIvbW0vbWlncmF0ZS5jCj4gQEAgLTE1NjMsNyArMTU2Myw3
IEBAIHN0cnVjdCBwYWdlICphbGxvY19taWdyYXRpb25fdGFyZ2V0KHN0cnVjdCBwYWdlICpwYWdl
LCB1bnNpZ25lZCBsb25nIHByaXZhdGUpCj4gICAJCXJldHVybiBhbGxvY19odWdlX3BhZ2Vfbm9k
ZW1hc2soaCwgbmlkLCBtdGMtPm5tYXNrLCBnZnBfbWFzayk7Cj4gICAJfQo+ICAgCj4gLQlpZiAo
UGFnZVRyYW5zSHVnZShwYWdlKSkgewo+ICsJaWYgKGlzX3RyYW5zcGFyZW50X2h1Z2VwYWdlKHBh
Z2UpKSB7Cj4gICAJCS8qCj4gICAJCSAqIGNsZWFyIF9fR0ZQX1JFQ0xBSU0gdG8gbWFrZSB0aGUg
bWlncmF0aW9uIGNhbGxiYWNrCj4gICAJCSAqIGNvbnNpc3RlbnQgd2l0aCByZWd1bGFyIFRIUCBh
bGxvY2F0aW9ucy4KPiBAQCAtMTU3MiwxMyArMTU3MiwxNyBAQCBzdHJ1Y3QgcGFnZSAqYWxsb2Nf
bWlncmF0aW9uX3RhcmdldChzdHJ1Y3QgcGFnZSAqcGFnZSwgdW5zaWduZWQgbG9uZyBwcml2YXRl
KQppZiAoUGFnZVRyYW5zSHVnZShwYWdlKSkge8KgIC8vIGp1c3QgZ2l2ZSBtb3JlIGNvZGUgY29u
dGV4dAouLi4KPiAgIAkJZ2ZwX21hc2sgfD0gR0ZQX1RSQU5TSFVHRTsKPiAgIAkJb3JkZXIgPSBI
UEFHRV9QTURfT1JERVI7Cm9yZGVyIGFzc2lnbmVkIGhlcmUKPiAgIAl9Cj4gKwlpZiAoUGFnZUNv
bXBvdW5kKHBhZ2UpKSB7Cj4gKwkJZ2ZwX21hc2sgfD0gX19HRlBfQ09NUDsKPiArCQlvcmRlciA9
IGNvbXBvdW5kX29yZGVyKHBhZ2UpOwpyZS1hc3NpbmdlZCBhZ2FpbiBhcyBUSFAgaXMgYSBjb21w
b3VuZCBwYWdlPwoKVGhhbmtzLApFcmljCj4gKwl9Cj4gICAJemlkeCA9IHpvbmVfaWR4KHBhZ2Vf
em9uZShwYWdlKSk7Cj4gICAJaWYgKGlzX2hpZ2htZW1faWR4KHppZHgpIHx8IHppZHggPT0gWk9O
RV9NT1ZBQkxFKQo+ICAgCQlnZnBfbWFzayB8PSBfX0dGUF9ISUdITUVNOwo+ICAgCj4gICAJbmV3
X3BhZ2UgPSBfX2FsbG9jX3BhZ2VzKGdmcF9tYXNrLCBvcmRlciwgbmlkLCBtdGMtPm5tYXNrKTsK
PiAgIAo+IC0JaWYgKG5ld19wYWdlICYmIFBhZ2VUcmFuc0h1Z2UobmV3X3BhZ2UpKQo+ICsJaWYg
KG5ld19wYWdlICYmIGlzX3RyYW5zcGFyZW50X2h1Z2VwYWdlKHBhZ2UpKQo+ICAgCQlwcmVwX3Ry
YW5zaHVnZV9wYWdlKG5ld19wYWdlKTsKPiAgIAo+ICAgCXJldHVybiBuZXdfcGFnZTsKCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcg
bGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4
Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
