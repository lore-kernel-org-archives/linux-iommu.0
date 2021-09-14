Return-Path: <SRS0=mcPB=OE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5FFDC433FE
	for <iommu@archiver.kernel.org>; Tue, 14 Sep 2021 22:15:42 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA9A461163
	for <iommu@archiver.kernel.org>; Tue, 14 Sep 2021 22:15:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BA9A461163
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 79109607D3;
	Tue, 14 Sep 2021 22:15:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UHCWI8CfTK49; Tue, 14 Sep 2021 22:15:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 704806003C;
	Tue, 14 Sep 2021 22:15:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 49892C000F;
	Tue, 14 Sep 2021 22:15:40 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BF4E1C000D
 for <iommu@lists.linux-foundation.org>; Tue, 14 Sep 2021 22:15:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id AEAF340375
 for <iommu@lists.linux-foundation.org>; Tue, 14 Sep 2021 22:15:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jc5JYYf_Qizn for <iommu@lists.linux-foundation.org>;
 Tue, 14 Sep 2021 22:15:37 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4ABCA400B9
 for <iommu@lists.linux-foundation.org>; Tue, 14 Sep 2021 22:15:37 +0000 (UTC)
Received: from [192.168.0.4] (ip5f5ae900.dynamic.kabel-deutschland.de
 [95.90.233.0])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id E0CD661E64760;
 Wed, 15 Sep 2021 00:15:33 +0200 (CEST)
Subject: Re: AMD-Vi: [Firmware Warn]: EFR mismatch. Use IVHD EFR
 (0xf77ef22294ada : 0x400f77ef22294ada).
To: =?UTF-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
References: <16533743-de8d-6355-211d-1b4f8949fcfb@molgen.mpg.de>
 <2f5b07e4-5492-330b-b057-55230639cd5e@molgen.mpg.de>
 <YUCRC0CI7rWXt4VA@8bytes.org>
From: Paul Menzel <pmenzel@molgen.mpg.de>
Message-ID: <38c22e95-aa19-4166-be8a-28749bfacd3e@molgen.mpg.de>
Date: Wed, 15 Sep 2021 00:15:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YUCRC0CI7rWXt4VA@8bytes.org>
Content-Language: en-US
Cc: David Coe <david.coe@live.co.uk>, Robert Richter <rrichter@amd.com>,
 Mario Limonciello <mario.limonciello@dell.com>,
 Alexander Monakov <amonakov@ispras.ru>, iommu@lists.linux-foundation.org,
 Dell.Client.Kernel@dell.com
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

W0NjOiArTWFyaW8gZnJvbSBBTURdCgpEZWFyIErDtnJnLAoKCkFtIDE0LjA5LjIxIHVtIDE0OjA5
IHNjaHJpZWIgSsO2cmcgUsO2ZGVsOgo+IE9uIFR1ZSwgU2VwIDE0LCAyMDIxIGF0IDExOjEwOjU3
QU0gKzAyMDAsIFBhdWwgTWVuemVsIHdyb3RlOgo+PiBMaW51eCA1LjE1LXJjMSBzdGlsbCB3YXJu
cyBhYm91dCB0aGF0IChhbHNvIHdpdGggbGF0ZXN0IHN5c3RlbSBmaXJtd2FyZQo+PiAxLjEuNTAp
Lgo+IAo+IFRoZSByZWFzb24gaXMgbW9zdCBsaWtlbHkgdGhhdCB0aGUgbGF0ZXN0IGZpcm13YXJl
IHN0aWxsIHJlcG9ydHMgYQo+IGRpZmZlcmVudCBFRlIgZmVhdHVyZSBzZXQgaW4gdGhlIElWUlMg
dGFibGUgdGhhbiB0aGUgSU9NTVUgcmVwb3J0cyBpbgo+IGl0cyBFRlIgTU1JTyByZWdpc3Rlci4K
CldoYXQgZG8geW91IG1lYW4gZXhhY3RseT8gT25seSAweDQwMCBpcyBwcmVwZW5kZWQuIFRoZSBy
ZXN0IG9mIHRoZSAKc3RyaW5nIGlzIGlkZW50aWNhbC4gV2hhdCBmZWF0dXJlIHNldCB3b3VsZCB0
aGUgMHg0MDAgaW4gdGhlIGJlZ2lubmluZyBiZT8KCkFueXdheSwgaXTigJlkIGJlIGdyZWF0IGlm
IEFNRCBhbmQgRGVsbCBjb3VsZCB0YWtlIGEgbG9vay4KCgpLaW5kIHJlZ2FyZHMsCgpQYXVsCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxp
bmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxp
bnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
