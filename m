Return-Path: <SRS0=qe9F=AK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF04DC433E0
	for <iommu@archiver.kernel.org>; Mon, 29 Jun 2020 13:53:17 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 652042333F
	for <iommu@archiver.kernel.org>; Mon, 29 Jun 2020 13:53:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 652042333F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=iogearbox.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 3C53188751;
	Mon, 29 Jun 2020 13:53:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sb1+nogOuMSK; Mon, 29 Jun 2020 13:53:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id BDDA98874C;
	Mon, 29 Jun 2020 13:53:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9F0D2C07FF;
	Mon, 29 Jun 2020 13:53:16 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7D3F2C016E
 for <iommu@lists.linux-foundation.org>; Mon, 29 Jun 2020 13:53:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 6A52288751
 for <iommu@lists.linux-foundation.org>; Mon, 29 Jun 2020 13:53:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZdqjfTvK4FBc for <iommu@lists.linux-foundation.org>;
 Mon, 29 Jun 2020 13:53:13 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
 by whitealder.osuosl.org (Postfix) with ESMTPS id D0AD48874C
 for <iommu@lists.linux-foundation.org>; Mon, 29 Jun 2020 13:53:12 +0000 (UTC)
Received: from sslproxy03.your-server.de ([88.198.220.132])
 by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
 (Exim 4.89_1) (envelope-from <daniel@iogearbox.net>)
 id 1jpuDM-0001DH-6o; Mon, 29 Jun 2020 15:52:52 +0200
Received: from [178.196.57.75] (helo=pc-9.home)
 by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <daniel@iogearbox.net>)
 id 1jpuDL-0002Xa-QH; Mon, 29 Jun 2020 15:52:51 +0200
Subject: Re: [PATCH net] xsk: remove cheap_dma optimization
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>,
 Christoph Hellwig <hch@lst.de>
References: <20200626134358.90122-1-bjorn.topel@gmail.com>
 <c60dfb5a-2bf3-20bd-74b3-6b5e215f73f8@iogearbox.net>
 <20200627070406.GB11854@lst.de>
 <88d27e1b-dbda-301c-64ba-2391092e3236@intel.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <e879bcc8-5f7d-b1b3-9b66-1032dec6245d@iogearbox.net>
Date: Mon, 29 Jun 2020 15:52:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <88d27e1b-dbda-301c-64ba-2391092e3236@intel.com>
Content-Language: en-US
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.3/25857/Sun Jun 28 15:28:36 2020)
Cc: maximmi@mellanox.com, konrad.wilk@oracle.com, jonathan.lemon@gmail.com,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 netdev@vger.kernel.org, bpf@vger.kernel.org, davem@davemloft.net,
 magnus.karlsson@intel.com
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

T24gNi8yOC8yMCA3OjE2IFBNLCBCasO2cm4gVMO2cGVsIHdyb3RlOgo+IE9uIDIwMjAtMDYtMjcg
MDk6MDQsIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOgo+PiBPbiBTYXQsIEp1biAyNywgMjAyMCBh
dCAwMTowMDoxOUFNICswMjAwLCBEYW5pZWwgQm9ya21hbm4gd3JvdGU6Cj4+PiBHaXZlbiB0aGVy
ZSBpcyByb3VnaGx5IGEgfjUgd2Vla3Mgd2luZG93IGF0IG1heCB3aGVyZSB0aGlzIHJlbW92YWwg
Y291bGQKPj4+IHN0aWxsIGJlIGFwcGxpZWQgaW4gdGhlIHdvcnN0IGNhc2UsIGNvdWxkIHdlIGNv
bWUgdXAgd2l0aCBhIGZpeCAvIHByb3Bvc2FsCj4+PiBmaXJzdCB0aGF0IG1vdmVzIHRoaXMgaW50
byB0aGUgRE1BIG1hcHBpbmcgY29yZT8gSWYgdGhlcmUgaXMgc29tZXRoaW5nIHRoYXQKPj4+IGNh
biBiZSBhZ3JlZWQgdXBvbiBieSBhbGwgcGFydGllcywgdGhlbiB3ZSBjb3VsZCBhdm9pZCByZS1h
ZGRpbmcgdGhlIDklCj4+PiBzbG93ZG93bi4gOi8KPj4KPj4gSSdkIHJhdGhlciB0dXJuIGl0IHVw
c2lkZSBkb3duIC0gdGhpcyBhYnVzZSBvZiB0aGUgaW50ZXJuYWxzIGJsb2NrcyB3b3JrCj4+IHRo
YXQgaGFzIGJhc2ljYWxseSBqdXN0IG1pc3NlZCB0aGUgcHJldmlvdXMgd2luZG93IGFuZCBJJ20g
bm90IGdvaW5nCj4+IHRvIHdhaXQgd2Vla3MgdG8gc29ydCBvdXQgdGhlIEFQSSBtaXN1c2UuwqAg
QnV0IHdlIGNhbiBhZGQgb3B0aW1pemF0aW9ucwo+PiBiYWNrIGxhdGVyIGlmIHdlIGZpbmQgYSBz
YW5lIHdheS4KPiAKPiBJJ20gbm90IHN1cGVyIGV4Y2l0ZWQgYWJvdXQgdGhlIHBlcmZvcm1hbmNl
IGxvc3MsIGJ1dCBJIGRvIGdldAo+IENocmlzdG9waCdzIGZydXN0cmF0aW9uIGFib3V0IGd1dHRp
bmcgdGhlIERNQSBBUEkgbWFraW5nIGl0IGhhcmRlciBmb3IKPiBETUEgcGVvcGxlIHRvIGdldCB3
b3JrIGRvbmUuIExldHMgdHJ5IHRvIHNvbHZlIHRoaXMgcHJvcGVybHkgdXNpbmcKPiBwcm9wZXIg
RE1BIEFQSXMuCgpPaywgZmFpciBlbm91Z2gsIHBsZWFzZSB3b3JrIHdpdGggRE1BIGZvbGtzIHRv
IGdldCB0aGlzIHByb3Blcmx5IGludGVncmF0ZWQgYW5kCnJlc3RvcmVkIHRoZW4uIEFwcGxpZWQs
IHRoYW5rcyEKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
aW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBz
Oi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
