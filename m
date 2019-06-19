Return-Path: <SRS0=+KpI=US=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB59DC48BDF
	for <iommu@archiver.kernel.org>; Wed, 19 Jun 2019 20:23:26 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 830B221721
	for <iommu@archiver.kernel.org>; Wed, 19 Jun 2019 20:23:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="2QUpyZNp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 830B221721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 51F8FD9C;
	Wed, 19 Jun 2019 20:23:26 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 28BE5D83
	for <iommu@lists.linux-foundation.org>;
	Wed, 19 Jun 2019 20:23:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id C337BE6
	for <iommu@lists.linux-foundation.org>;
	Wed, 19 Jun 2019 20:23:24 +0000 (UTC)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net
	[24.9.64.241])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id ECD302082C;
	Wed, 19 Jun 2019 20:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560975804;
	bh=qgcuW/vpzcqzKWbZjJN8NyIykkFdIDlqS/LyBwbAD84=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
	b=2QUpyZNpIs0fr4yIAAGZpJfOerU3kctEhFAVhrxVIpL2sZNFbbjH9MNecIR3iaS7/
	1+IVwdlC8UAm6yHU1q1s1CjEktjpPeu7Vqc+H+c8VDh0NHdSwh6YbJaBHnuoam38/T
	N2Fzf8pKY9U1vht0lC7lKRD3uGiONsQs/7P7/ehA=
Subject: Re: How to resolve an issue in swiotlb environment?
To: Alan Stern <stern@rowland.harvard.edu>
References: <Pine.LNX.4.44L0.1906141043530.24571-100000@netrider.rowland.org>
	<20684ef6-7da7-90ed-4cd6-3bc46202de6d@kernel.org>
From: shuah <shuah@kernel.org>
Message-ID: <7a6450cd-7b68-778d-0124-3c21d4616069@kernel.org>
Date: Wed, 19 Jun 2019 14:23:11 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20684ef6-7da7-90ed-4cd6-3bc46202de6d@kernel.org>
Content-Language: en-US
Cc: Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	Oliver Neukum <oneukum@suse.com>,
	Valentina Manea <valentina.manea.m@gmail.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	shuah <shuah@kernel.org>, Christoph Hellwig <hch@lst.de>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

SGkgQWxhbiwKCk9uIDYvMTgvMTkgOToyOCBBTSwgc2h1YWggd3JvdGU6Cj4gT24gNi8xNC8xOSA4
OjQ0IEFNLCBBbGFuIFN0ZXJuIHdyb3RlOgo+PiBPbiBUaHUsIDEzIEp1biAyMDE5LCBzaHVhaCB3
cm90ZToKPj4KPj4+PiBHcmVhdCHCoCBTbyBhbGwgd2UgaGF2ZSB0byBkbyBpcyBmaXggdmhjaS1o
Y2QuwqAgVGhlbiB3ZSBjYW4gcmVtb3ZlIGFsbAo+Pj4+IHRoZSB2aXJ0X2JvdW5kYXJ5X21hc2sg
c3R1ZmYgZnJvbSB1c2Itc3RvcmFnZSBhbmQgdWFzIGVudGlyZWx5Lgo+Pj4+Cj4+Pj4gKEknbSBh
c3N1bWluZyB3aXJlbGVzcyBVU0IgaXNuJ3QgYSBnZW51aW5lIGlzc3VlLsKgIEFzIGZhciBhcyBJ
IGtub3csIGl0Cj4+Pj4gaXMgcHJldHR5IG11Y2ggYWJhbmRvbmVkIGF0IHRoaXMgcG9pbnQuKQo+
Pj4+Cj4+Pj4gVmFsZW50aW5hIGFuZCBTaHVhOiBBZGRpbmcgU0cgc3VwcG9ydCB0byB2aGNpLWhj
ZCBzaG91bGRuJ3QgYmUgdG9vCj4+Pj4gaGFyZC7CoCBJdCBvdWdodCB0byBiZSBwb3NzaWJsZSBl
dmVuIHdpdGhvdXQgY2hhbmdpbmcgdGhlIG5ldHdvcmsKPj4+PiBwcm90b2NvbC4KPj4+Pgo+Pj4K
Pj4+IEkgd2lsbCBzdGFydCB0YWtpbmcgYSBsb29rIGF0IHRoaXMuIElzIHRoZXJlIGEgdGFyZ2V0
IHJlbGVhc2UgaW4gcGxhbgo+Pj4gdG8gZHJvcCB2aXJ0X2JvdW5kYXJ5X21hc2sgc3R1ZmY/Cj4+
Cj4+IE5vdCB5ZXQuwqAgQnV0IHNpbmNlIGl0IGRvZXNuJ3QgZG8gd2hhdCB3ZSB3YW50IGFueXdh
eSwgdGhpcyBzaG91bGQgYmUKPj4gZml4ZWQgcXVpY2tseS4KPj4KPiAKCkkgbWlzc2VkIGEgbG90
IG9mIHRoZSB0aHJlYWQgaW5mby4gYW5kIHdlbnQgbG9va2luZyBmb3IgaXQgYW5kIGZvdW5kIHRo
ZQpmb2xsb3dpbmcgc3VtbWFyeSBvZiB0aGUgcHJvYmxlbToKCj09PT09PT09PT09PT09PT09PQpU
aGUgaXNzdWUgd2hpY2ggcHJvbXB0ZWQgdGhlIGNvbW1pdCB0aGlzIHRocmVhZCBpcyBhYm91dCBh
cm9zZSBpbiBhCnNpdHVhdGlvbiB3aGVyZSB0aGUgYmxvY2sgbGF5ZXIgc2V0IHVwIGEgc2NhdHRl
cmxpc3QgY29udGFpbmluZyBidWZmZXIKc2l6ZXMgc29tZXRoaW5nIGxpa2U6CgoJNDA5NiA0MDk2
IDE1MzYgMTAyNAoKYW5kIHRoZSBtYXhpbXVtIHBhY2tldCBzaXplIHdhcyAxMDI0LiAgVGhlIHNp
dHVhdGlvbiB3YXMgYSBsaXR0bGUKdW51c3VhbCwgYmVjYXVzZSBpdCBpbnZvbHZlZCB2aGNpLWhj
ZCAoYSB2aXJ0dWFsIEhDRCkuICBUaGlzIGRvZXNuJ3QKbWF0dGVyIG11Y2ggaW4gbm9ybWFsIHBy
YWN0aWNlIGJlY2F1c2U6CgoJQmxvY2sgZGV2aWNlcyBub3JtYWxseSBoYXZlIGEgYmxvY2sgc2l6
ZSBvZiA1MTIgYnl0ZXMgb3IgbW9yZS4KCVNtYWxsZXIgdmFsdWVzIGFyZSB2ZXJ5IHVuY29tbW9u
LiAgU28gc2NhdHRlcmxpc3QgZWxlbWVudCBzaXplcwoJYXJlIGFsd2F5cyBkaXZpc2libGUgYnkg
NTEyLgoKCXhIQ0kgaXMgdGhlIG9ubHkgVVNCIGhvc3QgY29udHJvbGxlciB0eXBlIHdpdGggYSBt
YXhpbXVtIHBhY2tldAoJc2l6ZSBsYXJnZXIgdGhhbiA1MTIsIGFuZCB4SENJIGhhcmR3YXJlIGNh
biBkbyBmdWxsCglzY2F0dGVyLWdhdGhlciBzbyBpdCBkb2Vzbid0IGNhcmUgd2hhdCB0aGUgYnVm
ZmVyIHNpemVzIGFyZS4KClNvIGFub3RoZXIgYXBwcm9hY2ggd291bGQgYmUgdG8gZml4IHZoY2kt
aGNkIGFuZCB0aGVuIHRydXN0IHRoYXQgdGhlCnByb2JsZW0gd29uJ3QgYXJpc2UgYWdhaW4sIGZv
ciB0aGUgcmVhc29ucyBhYm92ZS4gIFdlIHdvdWxkIGJlIG9rYXkgc28KbG9uZyBhcyBub2JvZHkg
dHJpZWQgdG8gdXNlIGEgVVNCLVNDU0kgZGV2aWNlIHdpdGggYSBibG9jayBzaXplIG9mIDI1Ngpi
eXRlcyBvciBsZXNzLgo9PT09PT09PT09PT09PT09PT09CgpPdXQgb2YgdGhlIHN1bW1hcnksIHRo
ZSBmb2xsb3dpbmcgZ2l2ZXMgbWUgcGF1c2U6CgoieEhDSSBoYXJkd2FyZSBjYW4gZG8gZnVsbCBz
Y2F0dGVyLWdhdGhlciBzbyBpdCBkb2Vzbid0IGNhcmUgd2hhdCB0aGUKYnVmZmVyIHNpemVzIGFy
ZS4iCgp2aGNpLWhjZCB3b24ndCBiZSBhYmxlIHRvIGNvdW50IG9uIGhhcmR3YXJlIGJlaW5nIGFi
bGUgdG8gZG8gZnVsbApzY2F0dGVyLWdhdGhlci4gSXQgaGFzIHRvIGRlYWwgd2l0aCBhIHZhcmll
dHkgb2YgaGFyZHdhcmUgd2l0aAp2YXJ5aW5nIHNwZWVkcy4KCiJXZSB3b3VsZCBiZSBva2F5IHNv
IGxvbmcgYXMgbm9ib2R5IHRyaWVkIHRvIHVzZSBhIFVTQi1TQ1NJIGRldmljZSB3aXRoCmEgYmxv
Y2sgc2l6ZSBvZiAyNTYgYnl0ZXMgb3IgbGVzcy4iCgpBdCBsZWFzdCBhIFVTQiBTdG9yYWdlIGRl
dmljZSwgSSB0ZXN0IHdpdGggc2F5cyA1MTIgYmxvY2sgc2l6ZS4gQ2FuIHdlCmNvdW50IG9uIG5v
dCBzZWVpbmcgYSBkZXZpY2Ugd2l0aCBibG9jayBzaXplIDw9IDI1NiBieXRlcz8KCkluIGFueSBj
YXNlLCBJIGFtIGxvb2tpbmcgaW50byBhZGRpbmcgU0cgc3VwcG9ydCB2aGNpLWhjaSBhdCB0aGUg
bW9tZW50LgoKTG9va3MgbGlrZSB0aGUgZm9sbG93aW5nIGlzIHRoZSByZXBvLCBJIHNob3VsZCBi
ZSB3b3JraW5nIHdpdGg/CgpnaXQ6Ly9naXQuaW5mcmFkZWFkLm9yZy91c2Vycy9oY2gvbWlzYy5n
aXQKCnRoYW5rcywKLS0gU2h1YWgKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRp
b24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2lvbW11
