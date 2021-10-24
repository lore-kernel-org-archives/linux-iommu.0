Return-Path: <SRS0=5tw2=PM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1AE8C433F5
	for <iommu@archiver.kernel.org>; Sun, 24 Oct 2021 18:19:02 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64B7861002
	for <iommu@archiver.kernel.org>; Sun, 24 Oct 2021 18:19:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 64B7861002
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wanadoo.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C25DD40275;
	Sun, 24 Oct 2021 18:19:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id smtjWRHY_KEV; Sun, 24 Oct 2021 18:19:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 83A6F400DD;
	Sun, 24 Oct 2021 18:19:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 44576C0012;
	Sun, 24 Oct 2021 18:19:00 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 47C38C000E
 for <iommu@lists.linux-foundation.org>; Sun, 24 Oct 2021 18:18:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2E67B401E1
 for <iommu@lists.linux-foundation.org>; Sun, 24 Oct 2021 18:18:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AMtqRwgcSxU9 for <iommu@lists.linux-foundation.org>;
 Sun, 24 Oct 2021 18:18:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from smtp.smtpout.orange.fr (smtp01.smtpout.orange.fr
 [80.12.242.123])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B79E8400DD
 for <iommu@lists.linux-foundation.org>; Sun, 24 Oct 2021 18:18:56 +0000 (UTC)
Received: from [192.168.1.18] ([92.140.161.106]) by smtp.orange.fr with ESMTPA
 id ei57mb2SudmYbei57mLejJ; Sun, 24 Oct 2021 20:18:54 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sun, 24 Oct 2021 20:18:54 +0200
X-ME-IP: 92.140.161.106
Subject: Re: [PATCH] dma-mapping: Use 'bitmap_zalloc()' when applicable
To: Joe Perches <joe@perches.com>, hch@lst.de, m.szyprowski@samsung.com,
 robin.murphy@arm.com
References: <20976d6fd4af266dec589b40929b53dfddd64b75.1635097161.git.christophe.jaillet@wanadoo.fr>
 <c8cd95bc81173fdbdff4f2b504db3ce89119fa0d.camel@perches.com>
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Message-ID: <994b268f-ea33-bf82-96ab-c20057ba4930@wanadoo.fr>
Date: Sun, 24 Oct 2021 20:18:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <c8cd95bc81173fdbdff4f2b504db3ce89119fa0d.camel@perches.com>
Content-Language: en-US
Cc: iommu@lists.linux-foundation.org, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org
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

TGUgMjQvMTAvMjAyMSDDoCAxOTo1NCwgSm9lIFBlcmNoZXMgYSDDqWNyaXTCoDoKPiBPbiBTdW4s
IDIwMjEtMTAtMjQgYXQgMTk6NDAgKzAyMDAsIENocmlzdG9waGUgSkFJTExFVCB3cm90ZToKPj4g
J2RtYV9tZW0tPmJpdG1hcCcgaXMgYSBiaXRtYXAuIFNvIHVzZSAnYml0bWFwX3phbGxvYygpJyB0
byBzaW1wbGlmeSBjb2RlLAo+PiBpbXByb3ZlIHRoZSBzZW1hbnRpYyBhbmQgYXZvaWQgc29tZSBv
cGVuLWNvZGVkIGFyaXRobWV0aWMgaW4gYWxsb2NhdG9yCj4+IGFyZ3VtZW50cy4KPiAKPiBUaGVy
ZSBpcyBhIGNvY2NpIHNjcmlwdCBmb3Igc29tZSBvZiB0aGVzZS4KPiAKPiBodHRwczovL2xvcmUu
a2VybmVsLm9yZy9hbGwvMDhiODk2MDhjZmIxMjgwNjI0ZDFhODllYWQ2NTQ3MDY5ZjlhNGMzMS5j
YW1lbEBwZXJjaGVzLmNvbS8KPiAKCkhpIEpvZSwKCnllcyBJIGtub3cuCkFzIGl0IGlzIHB1Ymxp
YywgSSBndWVzcyB0aGF0IG5ldyBjb21lcnMgbWF5IGhhdmUgc2VlbiBpdCBhbmQgd2FudCB0byAK
cHJvcG9zZSBwYXRjaGVzIGJhc2VkIG9uIHlvdXIgY29jY2kgc2NyaXB0LgoKU28sIGZvciBub3cs
IEknbSBtb3JlIGZvY3VzZWQgb24gdGhpbmdzIHRoYXQgYXJlIG5vdCBzcG90dGVkIGJ5IHlvdXIg
CnNjcmlwdC4gSSBsb29rIGZvciBwbGFjZXMgd2hlcmUgdGhlIHNpemUgY29tcHV0YXRpb24gaXMg
bm90IGRvbmUgd2l0aGluIAp0aGUga21hbGxvYygpIG9yIGVxLiBmdW5jdGlvbi4KCkNKCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcg
bGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4
Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
