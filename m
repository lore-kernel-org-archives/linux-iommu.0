Return-Path: <SRS0=0Jez=AL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DBB3C433E0
	for <iommu@archiver.kernel.org>; Tue, 30 Jun 2020 13:47:49 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2482520675
	for <iommu@archiver.kernel.org>; Tue, 30 Jun 2020 13:47:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2482520675
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=iogearbox.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id E1FA588020;
	Tue, 30 Jun 2020 13:47:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ClnKD6weWwEA; Tue, 30 Jun 2020 13:47:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id B5F1287ED5;
	Tue, 30 Jun 2020 13:47:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8D9F7C0865;
	Tue, 30 Jun 2020 13:47:46 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E71FDC016E
 for <iommu@lists.linux-foundation.org>; Tue, 30 Jun 2020 13:47:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id D4660886A4
 for <iommu@lists.linux-foundation.org>; Tue, 30 Jun 2020 13:47:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vhXam8t1k16w for <iommu@lists.linux-foundation.org>;
 Tue, 30 Jun 2020 13:47:43 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 8F5EC886A3
 for <iommu@lists.linux-foundation.org>; Tue, 30 Jun 2020 13:47:43 +0000 (UTC)
Received: from sslproxy05.your-server.de ([78.46.172.2])
 by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
 (Exim 4.89_1) (envelope-from <daniel@iogearbox.net>)
 id 1jqGbZ-00070l-Fh; Tue, 30 Jun 2020 15:47:21 +0200
Received: from [178.196.57.75] (helo=pc-9.home)
 by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <daniel@iogearbox.net>)
 id 1jqGbZ-0003zd-6p; Tue, 30 Jun 2020 15:47:21 +0200
Subject: Re: [PATCH net] xsk: remove cheap_dma optimization
To: Christoph Hellwig <hch@lst.de>
References: <20200626134358.90122-1-bjorn.topel@gmail.com>
 <c60dfb5a-2bf3-20bd-74b3-6b5e215f73f8@iogearbox.net>
 <20200627070406.GB11854@lst.de>
 <88d27e1b-dbda-301c-64ba-2391092e3236@intel.com>
 <e879bcc8-5f7d-b1b3-9b66-1032dec6245d@iogearbox.net>
 <81aec200-c1a0-6d57-e3b6-26dad30790b8@intel.com>
 <903c646c-dc74-a15c-eb33-e1b67bc7da0d@iogearbox.net>
 <20200630050712.GA26840@lst.de>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <7bd1f3ad-f1c7-6f8c-ef14-ec450050edf2@iogearbox.net>
Date: Tue, 30 Jun 2020 15:47:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200630050712.GA26840@lst.de>
Content-Language: en-US
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.3/25858/Mon Jun 29 15:30:49 2020)
Cc: maximmi@mellanox.com, konrad.wilk@oracle.com, jonathan.lemon@gmail.com,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 netdev@vger.kernel.org, bpf@vger.kernel.org,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>, davem@davemloft.net,
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

T24gNi8zMC8yMCA3OjA3IEFNLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToKPiBPbiBNb24sIEp1
biAyOSwgMjAyMCBhdCAwNToxODozOFBNICswMjAwLCBEYW5pZWwgQm9ya21hbm4gd3JvdGU6Cj4+
IE9uIDYvMjkvMjAgNToxMCBQTSwgQmrDtnJuIFTDtnBlbCB3cm90ZToKPj4+IE9uIDIwMjAtMDYt
MjkgMTU6NTIsIERhbmllbCBCb3JrbWFubiB3cm90ZToKPj4+Pgo+Pj4+IE9rLCBmYWlyIGVub3Vn
aCwgcGxlYXNlIHdvcmsgd2l0aCBETUEgZm9sa3MgdG8gZ2V0IHRoaXMgcHJvcGVybHkgaW50ZWdy
YXRlZCBhbmQKPj4+PiByZXN0b3JlZCB0aGVuLiBBcHBsaWVkLCB0aGFua3MhCj4+Pgo+Pj4gRGFu
aWVsLCB5b3Ugd2VyZSB0b28gcXVpY2shIFBsZWFzZSByZXZlcnQgdGhpcyBvbmU7IENocmlzdG9w
aCBqdXN0IHN1Ym1pdHRlZCBhIDQtcGF0Y2gtc2VyaWVzIHRoYXQgYWRkcmVzc2VzIGJvdGggdGhl
IERNQSBBUEksIGFuZCB0aGUgcGVyZiByZWdyZXNzaW9uIQo+Pgo+PiBOaWNlLCB0b3NzZWQgZnJv
bSBicGYgdHJlZSB0aGVuISAoTG9va3MgbGlrZSBpdCBkaWRuJ3QgbGFuZCBvbiB0aGUgYnBmIGxp
c3QgeWV0LAo+PiBidXQgc2VlbXMgb3RoZXIgbWFpbHMgYXJlIGN1cnJlbnRseSBzdHVjayBhcyB3
ZWxsIG9uIHZnZXIuIEkgcHJlc3VtZSBpdCB3aWxsIGJlCj4+IHJvdXRlZCB0byBMaW51cyB2aWEg
Q2hyaXN0b3BoPykKPiAKPiBJIHNlbmQgdGhlIHBhdGNoZXMgdG8gdGhlIGJwZiBsaXN0LCBkaWQg
eW91IGdldCB0aGVtIG5vdyB0aGF0IHZnZXIKPiBpcyB1bmNsb2dnZWQ/ICBUaGlua2luZyBhYm91
dCBpdCB0aGUgYmVzdCByb3V0ZSBtaWdodCBiZSB0aHJvdWdoCj4gYnBmL25ldCwgc28gaWYgdGhh
dCB3b3JrcyBmb3IgeW91IHBsZWFzZSBwaWNrIGl0IHVwLgoKWWVhaCwgdGhhdCdzIGZpbmUsIEkg
anVzdCBhcHBsaWVkIHlvdXIgc2VyaWVzIHRvIHRoZSBicGYgdHJlZS4gVGhhbmtzIQpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxp
c3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZv
dW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
