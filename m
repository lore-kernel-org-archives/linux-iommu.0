Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07FA3C433EF
	for <iommu@archiver.kernel.org>; Tue, 31 May 2022 22:10:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 86BC84025D;
	Tue, 31 May 2022 22:10:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id j3bow3T0g91K; Tue, 31 May 2022 22:10:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 41B3F40002;
	Tue, 31 May 2022 22:10:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E3892C0032;
	Tue, 31 May 2022 22:10:45 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E516CC002D
 for <iommu@lists.linux-foundation.org>; Tue, 31 May 2022 22:10:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CBEA44172F
 for <iommu@lists.linux-foundation.org>; Tue, 31 May 2022 22:10:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=cybernetics.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XheSMfDQ_S0h for <iommu@lists.linux-foundation.org>;
 Tue, 31 May 2022 22:10:41 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mail.cybernetics.com (mail.cybernetics.com [173.71.130.66])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 81CB14161E
 for <iommu@lists.linux-foundation.org>; Tue, 31 May 2022 22:10:40 +0000 (UTC)
X-ASG-Debug-ID: 1654035038-1cf43917f334d340001-DtgJuY
Received: from cybernetics.com ([10.10.4.126]) by mail.cybernetics.com with
 ESMTP id pi5n3chlKhW5dG70; Tue, 31 May 2022 18:10:38 -0400 (EDT)
X-Barracuda-Envelope-From: tonyb@cybernetics.com
X-ASG-Whitelist: Client
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=cybernetics.com; s=mail; 
 bh=Pscrfy4zfmI9B2/f3RlaAfD71lZsuhWSoCA2Yk9IIwI=;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Content-Language:Subject:MIME-Version:Date:Message-ID; b=q5PB8adp564e7QMu+Y67
 rqxW9A2//yQphTVtYoOJzENI1mQv1RQmgvsm7Lip7aY8a7rF+htFUguM3OldCVKcojJicdxPHrfCe
 RfT8TUxLI1Q2o5QHc1BeFYM3K6ctZm0dHzpcsepgcE3x6eZwrBlQGNCsc3NwiuaJ4K8luj2hLA=
Received: from [10.157.2.224] (HELO [192.168.200.1])
 by cybernetics.com (CommuniGate Pro SMTP 7.1.1)
 with ESMTPS id 11830524; Tue, 31 May 2022 18:10:38 -0400
Message-ID: <803feeab-b27b-983d-45da-02a0daf0179a@cybernetics.com>
Date: Tue, 31 May 2022 18:10:38 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 10/10] dmapool: improve scalability of dma_pool_free
Content-Language: en-US
X-ASG-Orig-Subj: Re: [PATCH 10/10] dmapool: improve scalability of
 dma_pool_free
To: Keith Busch <kbusch@kernel.org>
References: <9b08ab7c-b80b-527d-9adf-7716b0868fbc@cybernetics.com>
 <801335ba-00f3-12ae-59e0-119d7d8fd8cd@cybernetics.com>
 <YpaOj/C1SA8y1VCg@kbusch-mbp.dhcp.thefacebook.com>
From: Tony Battersby <tonyb@cybernetics.com>
In-Reply-To: <YpaOj/C1SA8y1VCg@kbusch-mbp.dhcp.thefacebook.com>
X-Barracuda-Connect: UNKNOWN[10.10.4.126]
X-Barracuda-Start-Time: 1654035038
X-Barracuda-URL: https://10.10.4.122:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at cybernetics.com
X-Barracuda-Scan-Msg-Size: 989
X-Barracuda-BRTS-Status: 1
Cc: Tony Lindgren <tony@atomide.com>, iommu@lists.linux-foundation.org,
 Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, Andy Shevchenko <andy.shevchenko@gmail.com>,
 kernel-team@fb.com, Robin Murphy <robin.murphy@arm.com>
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

T24gNS8zMS8yMiAxNzo1NCwgS2VpdGggQnVzY2ggd3JvdGU6Cj4gT24gVHVlLCBNYXkgMzEsIDIw
MjIgYXQgMDI6MjM6NDRQTSAtMDQwMCwgVG9ueSBCYXR0ZXJzYnkgd3JvdGU6Cj4+IGRtYV9wb29s
X2ZyZWUoKSBzY2FsZXMgcG9vcmx5IHdoZW4gdGhlIHBvb2wgY29udGFpbnMgbWFueSBwYWdlcyBi
ZWNhdXNlCj4+IHBvb2xfZmluZF9wYWdlKCkgZG9lcyBhIGxpbmVhciBzY2FuIG9mIGFsbCBhbGxv
Y2F0ZWQgcGFnZXMuICBJbXByb3ZlIGl0cwo+PiBzY2FsYWJpbGl0eSBieSByZXBsYWNpbmcgdGhl
IGxpbmVhciBzY2FuIHdpdGggYSByZWQtYmxhY2sgdHJlZSBsb29rdXAuCj4+IEluIGJpZyBPIG5v
dGF0aW9uLCB0aGlzIGltcHJvdmVzIHRoZSBhbGdvcml0aG0gZnJvbSBPKG5eMikgdG8gTyhuICog
bG9nIG4pLgo+IFRoZSBpbXByb3ZlbWVudCBzaG91bGQgc2F5IE8obikgdG8gTyhsb2cgbiksIHJp
Z2h0PwoKVGhhdCB3b3VsZCBiZSB0aGUgaW1wcm92ZW1lbnQgZm9yIGEgc2luZ2xlIGNhbGwgdG8g
ZG1hX3Bvb2xfYWxsb2Mgb3IKZG1hX3Bvb2xfZnJlZSwgYnV0IEkgd2FzIGdvaW5nIHdpdGggdGhl
IGltcHJvdmVtZW50IGZvciAibiIgY2FsbHMKaW5zdGVhZCwgd2hpY2ggaXMgY29uc2lzdGVudCB3
aXRoIHRoZSBpbXByb3ZlbWVudCBmb3IgdGhlIGV4YW1wbGUgaW4gdGhlCmNvdmVyIGxldHRlciBm
b3IgbXB0M3Nhcy7CoCBJIHdvdWxkIGhhdmUgdG8gbG9vayB1cCB0aGUgY29udmVudGlvbiB0byBi
ZQpzdXJlIG9mIHRoZSBwcm9wZXIgbm90YXRpb24gaW4gYSBzaXR1YXRpb24gbGlrZSB0aGlzLCBi
dXQgSSB1c3VhbGx5CnRoaW5rICJpbnNlcnRpbmcgTiBpdGVtcyB0YWtlcyBOXjIgdGltZSI7IHRv
IG1lIGl0IG1ha2VzIGxlc3Mgc2Vuc2UgdG8Kc2F5ICJpbnNlcnRpbmcgMSBpdGVtIHRha2VzIE4g
dGltZSIsIGJlY2F1c2UgdGhlIE4gc2VlbXMgdG8gY29tZSBvdXQgb2YKbm93aGVyZS4KClRvbnkK
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1h
aWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3Rz
LmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
