Return-Path: <SRS0=+9ml=PN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 118BBC433F5
	for <iommu@archiver.kernel.org>; Mon, 25 Oct 2021 11:38:51 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C4B760F22
	for <iommu@archiver.kernel.org>; Mon, 25 Oct 2021 11:38:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0C4B760F22
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id BDB944037A;
	Mon, 25 Oct 2021 11:38:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8UQMMD-BV7dE; Mon, 25 Oct 2021 11:38:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 7D41840373;
	Mon, 25 Oct 2021 11:38:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 59F42C0012;
	Mon, 25 Oct 2021 11:38:48 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E3035C000E
 for <iommu@lists.linux-foundation.org>; Mon, 25 Oct 2021 11:38:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D00B34037A
 for <iommu@lists.linux-foundation.org>; Mon, 25 Oct 2021 11:38:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VVyMVD9fKsHd for <iommu@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 11:38:44 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 132F840373
 for <iommu@lists.linux-foundation.org>; Mon, 25 Oct 2021 11:38:43 +0000 (UTC)
Received: from [141.14.220.45] (g45.guest.molgen.mpg.de [141.14.220.45])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id A558B61EA191D;
 Mon, 25 Oct 2021 13:38:40 +0200 (CEST)
Message-ID: <5bba36e1-6dd7-8c29-1ec5-97815c8d7dc8@molgen.mpg.de>
Date: Mon, 25 Oct 2021 13:38:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: I got an IOMMU IO page fault. What to do now?
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 =?UTF-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
References: <7a5123b0-6370-59dc-f0c2-8be5b370d9ba@molgen.mpg.de>
 <0cfccc44-6cc6-98f5-ecd6-2f376839ec18@gmail.com>
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <0cfccc44-6cc6-98f5-ecd6-2f376839ec18@gmail.com>
Cc: x86@kernel.org, Xinhui Pan <Xinhui.Pan@amd.com>,
 LKML <linux-kernel@vger.kernel.org>, amd-gfx@lists.freedesktop.org,
 iommu@lists.linux-foundation.org, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Alex Deucher <alexander.deucher@amd.com>,
 it+linux-iommu@molgen.mpg.de, Thomas Gleixner <tglx@linutronix.de>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
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

RGVhciBDaHJpc3RpYW4sCgoKVGhhbmsgeW91IGZvciB5b3VyIHJlcGx5LgoKCk9uIDI1LjEwLjIx
IDEzOjIzLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgoKPiBub3Qgc3VyZSBob3cgdGhlIElPTU1V
IGdpdmVzIG91dCBhZGRyZXNzZXMsIGJ1dCB0aGUgcHJpbnRlZCBvbmVzIGxvb2sgCj4gc3VzcGlj
aW91cyB0byBtZS4gU29tZXRoaW5nIGxpa2Ugd2UgYXJlIHVzaW5nIGFuIGludmFsaWQgYWRkcmVz
cyBsaWtlIC0xIAo+IG9yIHNpbWlsYXIuCj4gCj4gQ2FuIHlvdSB0cnkgdGhhdCBvbiBhbiB1cCB0
byBkYXRlIGtlcm5lbCBhcyB3ZWxsPyBFLmcuIGlkZWFsbHkgYmxlZWRpbmcgCj4gZWRnZSBhbWQt
c3RhZ2luZy1kcm0tbmV4dCBmcm9tIEFsZXggcmVwb3NpdG9yeS4KClRoZXNlIGFyZSBwcm9kdWN0
aW9uIGRlc2t0b3BzLCBzbyBJ4oCZZCBuZWVkIHRvIHRhbGsgdG8gdGhlIHVzZXIuIApDdXJyZW50
bHksIExpbnV4IDUuMTAuNzAgaXMgcnVubmluZy4KCgpLaW5kIHJlZ2FyZHMsCgpQYXVsCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcg
bGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4
Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
