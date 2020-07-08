Return-Path: <SRS0=dlfR=AT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99399C433E0
	for <iommu@archiver.kernel.org>; Wed,  8 Jul 2020 09:02:36 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D6132222B
	for <iommu@archiver.kernel.org>; Wed,  8 Jul 2020 09:02:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D6132222B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=iogearbox.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 641D78739D;
	Wed,  8 Jul 2020 09:01:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Sza27qKMcF-t; Wed,  8 Jul 2020 09:01:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id D69698702A;
	Wed,  8 Jul 2020 09:01:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C8D3DC077B;
	Wed,  8 Jul 2020 09:01:43 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 425C5C016F
 for <iommu@lists.linux-foundation.org>; Wed,  8 Jul 2020 09:01:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 2DA1A88ADF
 for <iommu@lists.linux-foundation.org>; Wed,  8 Jul 2020 09:01:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UC4ZXpqKG2IU for <iommu@lists.linux-foundation.org>;
 Wed,  8 Jul 2020 09:01:40 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 0015A88A89
 for <iommu@lists.linux-foundation.org>; Wed,  8 Jul 2020 09:01:39 +0000 (UTC)
Received: from sslproxy05.your-server.de ([78.46.172.2])
 by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
 (Exim 4.89_1) (envelope-from <daniel@iogearbox.net>)
 id 1jt5xQ-0002sR-Fr; Wed, 08 Jul 2020 11:01:36 +0200
Received: from [178.196.57.75] (helo=pc-9.home)
 by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <daniel@iogearbox.net>)
 id 1jt5xQ-000Xy5-8p; Wed, 08 Jul 2020 11:01:36 +0200
Subject: Re: add an API to check if a streamming mapping needs sync calls
To: Christoph Hellwig <hch@lst.de>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn.topel@intel.com>
References: <20200629130359.2690853-1-hch@lst.de>
 <b97104e1-433c-8e35-59c6-b4dad047464c@intel.com>
 <20200708074418.GA6815@lst.de>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <ce7dc444-534e-636b-81d8-dbad249ad6aa@iogearbox.net>
Date: Wed, 8 Jul 2020 11:01:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200708074418.GA6815@lst.de>
Content-Language: en-US
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.3/25866/Tue Jul  7 15:47:52 2020)
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Jonathan Lemon <jonathan.lemon@gmail.com>,
 bpf@vger.kernel.org, Magnus Karlsson <magnus.karlsson@intel.com>
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

T24gNy84LzIwIDk6NDQgQU0sIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOgo+IE9uIE1vbiwgSnVu
IDI5LCAyMDIwIGF0IDAzOjM5OjAxUE0gKzAyMDAsIEJqw7ZybiBUw7ZwZWwgd3JvdGU6Cj4+IE9u
IDIwMjAtMDYtMjkgMTU6MDMsIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOgo+Pj4gSGkgYWxsLAo+
Pj4KPj4+IHRoaXMgc2VyaWVzIGxpZnRzIHRoZSBzb21ld2hhdCBoYWNreSBjaGVja3MgaW4gdGhl
IFhTSyBjb2RlIGlmIGEgRE1BCj4+PiBzdHJlYW1pbmcgbWFwcGluZyBuZWVkcyBkbWFfc3luY19z
aW5nbGVfZm9yX3tkZXZpY2UsY3B1fSBjYWxscyB0byB0aGUKPj4+IERNQSBBUEkuCj4+Pgo+Pgo+
PiBUaGFua3MgYSBsb3QgZm9yIHdvcmtpbmcgb24sIGFuZCBmaXhpbmcgdGhpcywgQ2hyaXN0b3Bo
IQo+Pgo+PiBJIHRvb2sgdGhlIHNlcmllcyBmb3IgYSBzcGluLCBhbmQgdGhlcmUgYXJlIChvYnZp
b3VzbHkpIG5vIHBlcmZvcm1hbmNlCj4+IHJlZ3Jlc3Npb25zLgo+Pgo+PiBXb3VsZCB0aGUgcGF0
Y2hlcyBnbyB0aHJvdWdoIHRoZSBuZXQvYnBmIHRyZWVzIG9yIHNvbWV3aGVyZSBlbHNlPwo+IAo+
IFdoZXJlIGRpZCB0aGlzIGVuZCB1cD8gIEkgc3RpbGwgZG9uJ3Qgc2VlIGl0IGluIExpbnVzJyB0
cmVlIGFuZCB0aGlzCj4gaXMgZ2V0dGluZyB1cmdlbnQgbm93LgoKSXQgd2FzIG1lcmdlZCBpbnRv
IGJwZiB0cmVlIGFuZCB3ZSBzZW50IHRoZSBQUiB0byBEYXZlTSB3aGljaCB3YXMgbWVyZ2VkIGlu
dG8KbmV0IHRyZWUgYXJvdW5kIGEgd2VlayBhZ28gWzBdOyBJIGFzc3VtZSB0aGUgUFIgZm9yIG5l
dCBtaWdodCBnbyB0byBMaW51cyBzb29uCnRoaXMgd2Vlay4KCiAgIFswXSBodHRwczovL2dpdC5r
ZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9uZXRkZXYvbmV0LmdpdC9jb21taXQv
P2lkPWU3MDhlMmJkNTVjOTIxZjViYjU1NGZhNTgzN2QxMzJhODc4OTUxY2YKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0Cmlv
bW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0
aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
