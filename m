Return-Path: <SRS0=SJ72=H2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BB6BC433E0
	for <iommu@archiver.kernel.org>; Wed, 24 Feb 2021 20:36:09 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F07ED64E7A
	for <iommu@archiver.kernel.org>; Wed, 24 Feb 2021 20:36:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F07ED64E7A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9E13F4BEFB;
	Wed, 24 Feb 2021 20:36:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rbbSlsgUXvPz; Wed, 24 Feb 2021 20:36:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6FA414B978;
	Wed, 24 Feb 2021 20:36:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 431BBC000A;
	Wed, 24 Feb 2021 20:36:06 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C17EEC0001
 for <iommu@lists.linux-foundation.org>; Wed, 24 Feb 2021 20:36:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9B7D68316F
 for <iommu@lists.linux-foundation.org>; Wed, 24 Feb 2021 20:36:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id B5606nG7Ls4B for <iommu@lists.linux-foundation.org>;
 Wed, 24 Feb 2021 20:36:02 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B658183A50
 for <iommu@lists.linux-foundation.org>; Wed, 24 Feb 2021 20:36:02 +0000 (UTC)
Received: from [192.168.0.5] (ip5f5aed0a.dynamic.kabel-deutschland.de
 [95.90.237.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id 6F2AB206446A2;
 Wed, 24 Feb 2021 21:35:59 +0100 (CET)
Subject: Re: [PATCH] iommu/amd: Fix event counter availability check
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
References: <20200529200738.1923-1-amonakov@ispras.ru>
 <56761139-f794-39b1-4dfa-dfc05fbe5f60@amd.com>
 <alpine.LNX.2.20.13.2006011132530.16067@monopod.intra.ispras.ru>
 <dba1e37a-1ed7-ef7f-7252-2ebd1d6bde8c@amd.com>
 <alpine.LNX.2.20.13.2006152346320.21123@monopod.intra.ispras.ru>
 <b01994db-da9b-d8e6-e0c1-1af35dd62191@amd.com>
 <alpine.LNX.2.20.13.2009172052480.29869@monopod.intra.ispras.ru>
 <23d42e73-91ac-8f47-af64-40edff8bc027@molgen.mpg.de>
 <290635dc-723e-a55e-8447-95cef703b090@amd.com>
From: Paul Menzel <pmenzel@molgen.mpg.de>
Message-ID: <28294d78-3987-e47d-3609-d36dd2e993d1@molgen.mpg.de>
Date: Wed, 24 Feb 2021 21:35:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <290635dc-723e-a55e-8447-95cef703b090@amd.com>
Content-Language: en-US
Cc: iommu@lists.linux-foundation.org, Alexander Monakov <amonakov@ispras.ru>,
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

RGVhciBTdXJhdmVlLAoKClRoYW5rIHlvdSBmb3IgeW91ciByZXBseS4KCgpBbSAyMi4wMi4yMSB1
bSAxODo1OSBzY2hyaWViIFN1cmF2ZWUgU3V0aGlrdWxwYW5pdDoKPiBUaGlzIGZpeCBoYXMgYmVl
biBhY2NlcHRlZCBpbiB0aGUgdXBzdHJlYW0gcmVjZW50bHkuCj4gCj4gaHR0cHM6Ly9naXQua2Vy
bmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvam9yby9pb21tdS5naXQvY29tbWl0Lz9o
PXg4Ni9hbWQgCgpJbmRlZWQuIExpbnV4IHB1bGxlZCBhbHNvIHB1bGxlZCB0aGlzIFsxXS4KCj4g
Q291bGQgeW91IHBsZWFzZSBnaXZlIHRoaXMgYSB0cnk/CgpZZXMsIEkgZGlkIGdpdmUgaXQgYSB0
cnksIGJ1dCwgdW5mb3J0dW5hdGVseSwgdGhlIHByb2JsZW0gaXMgdW5maXhlZC4gSSAKY29tbWVu
dGVkIG9uIHRoZSBMaW51eCBCdWd6aWxsYSBidWcgcmVwb3J0ICMyMDE3NTMgWzFdLgoKCktpbmQg
cmVnYXJkcywKClBhdWwKCgpQUzogSXTigJlkIGJlIGdyZWF0IGlmIHlvdSBkaWRu4oCZdCB0b3Ag
cG9zdCwgYW5kIHVzZWQgaW50ZXJsZWF2ZWQgc3R5bGUgZm9yIApyZXNwb25zZXMuCgpbMV06IGh0
dHBzOi8vYnVnemlsbGEua2VybmVsLm9yZy9zaG93X2J1Zy5jZ2k/aWQ9MjAxNzUzCiAgICAgICJB
TUQtVmk6IFVuYWJsZSB0byB3cml0ZSB0byBJT01NVSBwZXJmIGNvdW50ZXIiCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdApp
b21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRh
dGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
