Return-Path: <SRS0=nJTY=HL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 356F2C433E0
	for <iommu@archiver.kernel.org>; Tue,  9 Feb 2021 13:12:57 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AB0164EB8
	for <iommu@archiver.kernel.org>; Tue,  9 Feb 2021 13:12:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AB0164EB8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id E905086E95;
	Tue,  9 Feb 2021 13:12:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eVMe+zUzdbhk; Tue,  9 Feb 2021 13:12:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 9A90A8699C;
	Tue,  9 Feb 2021 13:12:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7F986C0891;
	Tue,  9 Feb 2021 13:12:54 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9B529C013A
 for <iommu@lists.linux-foundation.org>; Tue,  9 Feb 2021 13:12:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 828EA872BD
 for <iommu@lists.linux-foundation.org>; Tue,  9 Feb 2021 13:12:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gd6eOz7j4SwS for <iommu@lists.linux-foundation.org>;
 Tue,  9 Feb 2021 13:12:51 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
 by hemlock.osuosl.org (Postfix) with ESMTP id D349187292
 for <iommu@lists.linux-foundation.org>; Tue,  9 Feb 2021 13:12:50 +0000 (UTC)
Received: from uucp (helo=alpha)
 by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
 id 1l9Soz-0003io-00; Tue, 09 Feb 2021 14:12:49 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
 id 93C26C0DBF; Tue,  9 Feb 2021 14:06:36 +0100 (CET)
Date: Tue, 9 Feb 2021 14:06:36 +0100
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 5/6] driver core: lift dma_default_coherent into common
 code
Message-ID: <20210209130636.GA11915@alpha.franken.de>
References: <20210208145024.3320420-1-hch@lst.de>
 <20210208145024.3320420-6-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210208145024.3320420-6-hch@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 iommu@lists.linux-foundation.org, linux-mips@vger.kernel.org,
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

T24gTW9uLCBGZWIgMDgsIDIwMjEgYXQgMDM6NTA6MjNQTSArMDEwMCwgQ2hyaXN0b3BoIEhlbGx3
aWcgd3JvdGU6Cj4gTGlmdCB0aGUgZG1hX2RlZmF1bHRfY29oZXJlbnQgdmFyaWFibGUgZnJvbSB0
aGUgbWlwcyBhcmNoaXRlY3R1cmUgY29kZQo+IHRvIHRoZSBkcml2ZXIgY29yZS4gIFRoaXMgYWxs
b3dzIGFuIGFyY2hpdGVjdHVyZSB0byBzZGVmYXVsdCBhbGwgZGV2aWNlCj4gdG8gYmUgRE1BIGNv
aGVyZW50IGF0IHJ1biB0aW1lLCBldmVuIGlmIHRoZSBrZXJuZWwgaXMgYnVpbGQgd2l0aCBzdXBw
b3J0Cj4gZm9yIERNQSBub25jb2hlcmVudCBkZXZpY2UuICBCeSBhbGxvd2luZyBkZXZpY2VfaW5p
dGlhbGl6ZSB0byDRlWV0IHRoZQo+IC0+ZG1hX2NvaGVyZW50IGZpZWxkIHRvIHRoaXMgZGVmYXVs
dCB0aGUgYW1vdW50IG9mIGFyY2ggaG9va3MgcmVxdWlyZWQKPiBmb3IgdGhpcyBiZWhhdmlvciBj
YW4gYmUgZ3JlYXRseSByZWR1Y2VkLgo+IAo+IFNpZ25lZC1vZmYtYnk6IENocmlzdG9waCBIZWxs
d2lnIDxoY2hAbHN0LmRlPgo+IC0tLQo+IFsuLl0KPiBAQCAtMTQzLDcgKzE0Myw3IEBAIHN0YXRp
YyB2b2lkIF9faW5pdCBwbGF0X3NldHVwX2lvY29oZXJlbmN5KHZvaWQpCj4gIAkJCXByX2NyaXQo
IklPQ1UgT1BFUkFUSU9OIERJU0FCTEVEIEJZIFNXSVRDSCAtIERFRkFVTFRJTkcgVE8gU1cgSU8g
Q09IRVJFTkNZXG4iKTsKPiAgCX0KPiAgCj4gLQlpZiAoc3VwcG9ydGVkKQo+ICsJaWYgKHN1cHBv
cnRlZCkgewo+ICAJCWlmIChkbWFfZm9yY2Vfbm9uY29oZXJlbnQpIHsKPiAgCQkJcHJfaW5mbygi
SGFyZHdhcmUgRE1BIGNhY2hlIGNvaGVyZW5jeSBkaXNhYmxlZFxuIik7Cj4gIAkJCXJldHVybjsK
CnRoaXMgaHVuayBuZWVkcyB0byBiZSBpbiBwYXRjaCAxLCBvdGhlcndpc2UgaXQncyBub3QgY29t
cGlsYWJsZQoKVGhvbWFzLgoKLS0gCkNyYXAgY2FuIHdvcmsuIEdpdmVuIGVub3VnaCB0aHJ1c3Qg
cGlncyB3aWxsIGZseSwgYnV0IGl0J3Mgbm90IG5lY2Vzc2FyaWx5IGEKZ29vZCBpZGVhLiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFsgUkZDMTkyNSwgMi4z
IF0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUg
bWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlz
dHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
