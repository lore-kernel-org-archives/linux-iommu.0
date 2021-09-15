Return-Path: <SRS0=KP5g=OF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE818C433EF
	for <iommu@archiver.kernel.org>; Wed, 15 Sep 2021 08:31:58 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5486F61130
	for <iommu@archiver.kernel.org>; Wed, 15 Sep 2021 08:31:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5486F61130
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 171C340181;
	Wed, 15 Sep 2021 08:31:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id P3v74UC3PqEX; Wed, 15 Sep 2021 08:31:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 08EFA40260;
	Wed, 15 Sep 2021 08:31:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CE482C0011;
	Wed, 15 Sep 2021 08:31:51 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 86A30C000D
 for <iommu@lists.linux-foundation.org>; Wed, 15 Sep 2021 08:31:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 632D240260
 for <iommu@lists.linux-foundation.org>; Wed, 15 Sep 2021 08:31:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id c62zZ1ogzZ0s for <iommu@lists.linux-foundation.org>;
 Wed, 15 Sep 2021 08:31:39 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from theia.8bytes.org (8bytes.org
 [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DE6F240181
 for <iommu@lists.linux-foundation.org>; Wed, 15 Sep 2021 08:31:38 +0000 (UTC)
Received: from smtpclient.apple
 (p200300c27738100089e3d694f7531a54.dip0.t-ipconnect.de
 [IPv6:2003:c2:7738:1000:89e3:d694:f753:1a54])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by theia.8bytes.org (Postfix) with ESMTPSA id 8A57B2A5;
 Wed, 15 Sep 2021 10:30:31 +0200 (CEST)
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: AMD-Vi: [Firmware Warn]: EFR mismatch. Use IVHD EFR
 (0xf77ef22294ada : 0x400f77ef22294ada).
From: =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
In-Reply-To: <3c61d4d9-f6e0-d847-3b60-bde8b3733f09@molgen.mpg.de>
Date: Wed, 15 Sep 2021 10:30:30 +0200
Message-Id: <D1BCBF26-0F73-434B-8C95-B2CB4934D0A4@8bytes.org>
References: <16533743-de8d-6355-211d-1b4f8949fcfb@molgen.mpg.de>
 <2f5b07e4-5492-330b-b057-55230639cd5e@molgen.mpg.de>
 <YUCRC0CI7rWXt4VA@8bytes.org>
 <38c22e95-aa19-4166-be8a-28749bfacd3e@molgen.mpg.de>
 <3c61d4d9-f6e0-d847-3b60-bde8b3733f09@molgen.mpg.de>
To: Paul Menzel <pmenzel@molgen.mpg.de>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

TWFpbmx5IERFTEwgc2hvdWxkIGxvb2sgYXQgdGhpcywgYmVjYXVzZSBpdCBpcyB0aGVpciBCSU9T
IHdoaWNoIGlzIHJlc3BvbnNpYmxlIGZvciB0aGlzIGluY29uc2lzdGVuY3kuCgo+IEFtIDE1LjA5
LjIwMjEgdW0gMDA6MTcgc2NocmllYiBQYXVsIE1lbnplbCA8cG1lbnplbEBtb2xnZW4ubXBnLmRl
PjoKPiAKPiBbVXNlIE1hcmlv4oCZcyBjdXJyZW50IGFkZHJlc3NdCj4gCj4gQW0gMTUuMDkuMjEg
dW0gMDA6MTUgc2NocmllYiBQYXVsIE1lbnplbDoKPj4gW0NjOiArTWFyaW8gZnJvbSBBTURdCj4+
IERlYXIgSsO2cmcsCj4+IEFtIDE0LjA5LjIxIHVtIDE0OjA5IHNjaHJpZWIgSsO2cmcgUsO2ZGVs
Ogo+Pj4gT24gVHVlLCBTZXAgMTQsIDIwMjEgYXQgMTE6MTA6NTdBTSArMDIwMCwgUGF1bCBNZW56
ZWwgd3JvdGU6Cj4+Pj4gTGludXggNS4xNS1yYzEgc3RpbGwgd2FybnMgYWJvdXQgdGhhdCAoYWxz
byB3aXRoIGxhdGVzdCBzeXN0ZW0gZmlybXdhcmUKPj4+PiAxLjEuNTApLgo+Pj4gCj4+PiBUaGUg
cmVhc29uIGlzIG1vc3QgbGlrZWx5IHRoYXQgdGhlIGxhdGVzdCBmaXJtd2FyZSBzdGlsbCByZXBv
cnRzIGEKPj4+IGRpZmZlcmVudCBFRlIgZmVhdHVyZSBzZXQgaW4gdGhlIElWUlMgdGFibGUgdGhh
biB0aGUgSU9NTVUgcmVwb3J0cyBpbgo+Pj4gaXRzIEVGUiBNTUlPIHJlZ2lzdGVyLgo+PiBXaGF0
IGRvIHlvdSBtZWFuIGV4YWN0bHk/IE9ubHkgMHg0MDAgaXMgcHJlcGVuZGVkLiBUaGUgcmVzdCBv
ZiB0aGUgc3RyaW5nIGlzIGlkZW50aWNhbC4gV2hhdCBmZWF0dXJlIHNldCB3b3VsZCB0aGUgMHg0
MDAgaW4gdGhlIGJlZ2lubmluZyBiZT8KPj4gQW55d2F5LCBpdOKAmWQgYmUgZ3JlYXQgaWYgQU1E
IGFuZCBEZWxsIGNvdWxkIHRha2UgYSBsb29rLgo+PiBLaW5kIHJlZ2FyZHMsCj4+IFBhdWwKCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxp
bmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxp
bnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
