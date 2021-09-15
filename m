Return-Path: <SRS0=KP5g=OF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70A4DC433EF
	for <iommu@archiver.kernel.org>; Wed, 15 Sep 2021 08:42:27 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D009611AF
	for <iommu@archiver.kernel.org>; Wed, 15 Sep 2021 08:42:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0D009611AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CFD8F824C1;
	Wed, 15 Sep 2021 08:42:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GpgWgwa-YvIP; Wed, 15 Sep 2021 08:42:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id B7B7C81CFE;
	Wed, 15 Sep 2021 08:42:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8E8DFC0011;
	Wed, 15 Sep 2021 08:42:24 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AA71CC000D
 for <iommu@lists.linux-foundation.org>; Wed, 15 Sep 2021 08:42:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8C12D824C1
 for <iommu@lists.linux-foundation.org>; Wed, 15 Sep 2021 08:42:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2b2cMEve6jTG for <iommu@lists.linux-foundation.org>;
 Wed, 15 Sep 2021 08:42:21 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3BB8681DCA
 for <iommu@lists.linux-foundation.org>; Wed, 15 Sep 2021 08:42:20 +0000 (UTC)
Received: from [192.168.0.4] (ip5f5ae8da.dynamic.kabel-deutschland.de
 [95.90.232.218])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id 1E29261E5FE02;
 Wed, 15 Sep 2021 10:42:18 +0200 (CEST)
Subject: Re: AMD-Vi: [Firmware Warn]: EFR mismatch. Use IVHD EFR
 (0xf77ef22294ada : 0x400f77ef22294ada).
To: =?UTF-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
References: <16533743-de8d-6355-211d-1b4f8949fcfb@molgen.mpg.de>
 <2f5b07e4-5492-330b-b057-55230639cd5e@molgen.mpg.de>
 <YUCRC0CI7rWXt4VA@8bytes.org>
 <38c22e95-aa19-4166-be8a-28749bfacd3e@molgen.mpg.de>
 <3c61d4d9-f6e0-d847-3b60-bde8b3733f09@molgen.mpg.de>
 <D1BCBF26-0F73-434B-8C95-B2CB4934D0A4@8bytes.org>
From: Paul Menzel <pmenzel@molgen.mpg.de>
Message-ID: <bb53516e-6d48-cff8-d14e-32bc76754a26@molgen.mpg.de>
Date: Wed, 15 Sep 2021 10:42:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <D1BCBF26-0F73-434B-8C95-B2CB4934D0A4@8bytes.org>
Content-Language: en-US
Cc: David Coe <david.coe@live.co.uk>, Robert Richter <rrichter@amd.com>,
 Alexander Monakov <amonakov@ispras.ru>, iommu@lists.linux-foundation.org,
 Mario Limonciello <mario.limonciello@amd.com>, Dell.Client.Kernel@dell.com
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

RGVhciBKw7ZyZywKCgpBbSAxNS4wOS4yMSB1bSAxMDozMCBzY2hyaWViIErDtnJnIFLDtmRlbDoK
PiBNYWlubHkgREVMTCBzaG91bGQgbG9vayBhdCB0aGlzLCBiZWNhdXNlIGl0IGlzIHRoZWlyIEJJ
T1Mgd2hpY2ggaXMKPiByZXNwb25zaWJsZSBmb3IgdGhpcyBpbmNvbnNpc3RlbmN5LgoKSSBhbSBu
b3Qgc28gc3VyZSBhYm91dCB0aGF0LCBhcyB0b2RheeKAmXMgKHg4NikgZmlybXdhcmUgb2Z0ZW4g
Y29uc2lzdHMgb2YgCnBsYXRmb3JtIGluaXRpYWxpemF0aW9uIChQSSkgY29kZSAob3IgZmlybXdh
cmUgc3VwcG9ydCBwYWNrYWdlIChGU1ApLCAKcHJvdmlkZWQgYnkgdGhlIGNoaXBzZXQvU29DIHZl
bmRvcnMsIGxpa2UgQUdFU0EgZm9yIEFNRCwgd2hpY2ggdGhlIE9ETSAKanVzdCBpbnRlZ3JhdGUu
CgpJZiBvbmx5IERlbGwgc3lzdGVtcyBhcmUgYWZmZWN0ZWQsIHRoYXQgd291bGQgb2YgY291cnNl
IHBvaW50IHRvIGEgYnVnIAppbiB0aGUgRGVsbCBmaXJtd2FyZS4KCgpLaW5kIHJlZ2FyZHMsCgpQ
YXVsCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11
IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xp
c3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
