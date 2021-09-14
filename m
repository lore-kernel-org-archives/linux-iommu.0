Return-Path: <SRS0=mcPB=OE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D45BC433EF
	for <iommu@archiver.kernel.org>; Tue, 14 Sep 2021 22:17:17 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA72961166
	for <iommu@archiver.kernel.org>; Tue, 14 Sep 2021 22:17:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org AA72961166
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 74F086076D;
	Tue, 14 Sep 2021 22:17:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FwJLD1SZaVSP; Tue, 14 Sep 2021 22:17:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id AC7B56003C;
	Tue, 14 Sep 2021 22:17:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 93360C000F;
	Tue, 14 Sep 2021 22:17:13 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E8388C000D
 for <iommu@lists.linux-foundation.org>; Tue, 14 Sep 2021 22:17:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D6A5D6076D
 for <iommu@lists.linux-foundation.org>; Tue, 14 Sep 2021 22:17:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bvA0yvMcMgR7 for <iommu@lists.linux-foundation.org>;
 Tue, 14 Sep 2021 22:17:10 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D89726003C
 for <iommu@lists.linux-foundation.org>; Tue, 14 Sep 2021 22:17:09 +0000 (UTC)
Received: from [192.168.0.4] (ip5f5ae900.dynamic.kabel-deutschland.de
 [95.90.233.0])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id BF43461E64760;
 Wed, 15 Sep 2021 00:17:07 +0200 (CEST)
Subject: Re: AMD-Vi: [Firmware Warn]: EFR mismatch. Use IVHD EFR
 (0xf77ef22294ada : 0x400f77ef22294ada).
From: Paul Menzel <pmenzel@molgen.mpg.de>
To: =?UTF-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
References: <16533743-de8d-6355-211d-1b4f8949fcfb@molgen.mpg.de>
 <2f5b07e4-5492-330b-b057-55230639cd5e@molgen.mpg.de>
 <YUCRC0CI7rWXt4VA@8bytes.org>
 <38c22e95-aa19-4166-be8a-28749bfacd3e@molgen.mpg.de>
Message-ID: <3c61d4d9-f6e0-d847-3b60-bde8b3733f09@molgen.mpg.de>
Date: Wed, 15 Sep 2021 00:17:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <38c22e95-aa19-4166-be8a-28749bfacd3e@molgen.mpg.de>
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

W1VzZSBNYXJpb+KAmXMgY3VycmVudCBhZGRyZXNzXQoKQW0gMTUuMDkuMjEgdW0gMDA6MTUgc2No
cmllYiBQYXVsIE1lbnplbDoKPiBbQ2M6ICtNYXJpbyBmcm9tIEFNRF0KPiAKPiBEZWFyIErDtnJn
LAo+IAo+IAo+IEFtIDE0LjA5LjIxIHVtIDE0OjA5IHNjaHJpZWIgSsO2cmcgUsO2ZGVsOgo+PiBP
biBUdWUsIFNlcCAxNCwgMjAyMSBhdCAxMToxMDo1N0FNICswMjAwLCBQYXVsIE1lbnplbCB3cm90
ZToKPj4+IExpbnV4IDUuMTUtcmMxIHN0aWxsIHdhcm5zIGFib3V0IHRoYXQgKGFsc28gd2l0aCBs
YXRlc3Qgc3lzdGVtIGZpcm13YXJlCj4+PiAxLjEuNTApLgo+Pgo+PiBUaGUgcmVhc29uIGlzIG1v
c3QgbGlrZWx5IHRoYXQgdGhlIGxhdGVzdCBmaXJtd2FyZSBzdGlsbCByZXBvcnRzIGEKPj4gZGlm
ZmVyZW50IEVGUiBmZWF0dXJlIHNldCBpbiB0aGUgSVZSUyB0YWJsZSB0aGFuIHRoZSBJT01NVSBy
ZXBvcnRzIGluCj4+IGl0cyBFRlIgTU1JTyByZWdpc3Rlci4KPiAKPiBXaGF0IGRvIHlvdSBtZWFu
IGV4YWN0bHk/IE9ubHkgMHg0MDAgaXMgcHJlcGVuZGVkLiBUaGUgcmVzdCBvZiB0aGUgCj4gc3Ry
aW5nIGlzIGlkZW50aWNhbC4gV2hhdCBmZWF0dXJlIHNldCB3b3VsZCB0aGUgMHg0MDAgaW4gdGhl
IGJlZ2lubmluZyBiZT8KPiAKPiBBbnl3YXksIGl04oCZZCBiZSBncmVhdCBpZiBBTUQgYW5kIERl
bGwgY291bGQgdGFrZSBhIGxvb2suCj4gCj4gCj4gS2luZCByZWdhcmRzLAo+IAo+IFBhdWwKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGlu
ZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGlu
dXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
