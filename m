Return-Path: <SRS0=KP5g=OF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34469C433EF
	for <iommu@archiver.kernel.org>; Wed, 15 Sep 2021 08:47:27 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA49960527
	for <iommu@archiver.kernel.org>; Wed, 15 Sep 2021 08:47:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BA49960527
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 85721826A8;
	Wed, 15 Sep 2021 08:47:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QPn3RVspkWiA; Wed, 15 Sep 2021 08:47:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 8139D82661;
	Wed, 15 Sep 2021 08:47:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4ABA6C0011;
	Wed, 15 Sep 2021 08:47:25 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 69D27C000D
 for <iommu@lists.linux-foundation.org>; Wed, 15 Sep 2021 08:47:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2EC134011C
 for <iommu@lists.linux-foundation.org>; Wed, 15 Sep 2021 08:47:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XNm8Mq2vBF0D for <iommu@lists.linux-foundation.org>;
 Wed, 15 Sep 2021 08:47:22 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 70AEF400EE
 for <iommu@lists.linux-foundation.org>; Wed, 15 Sep 2021 08:47:22 +0000 (UTC)
Received: from smtpclient.apple
 (p200300c27738100089e3d694f7531a54.dip0.t-ipconnect.de
 [IPv6:2003:c2:7738:1000:89e3:d694:f753:1a54])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by theia.8bytes.org (Postfix) with ESMTPSA id 4AEF82A5;
 Wed, 15 Sep 2021 10:47:18 +0200 (CEST)
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: AMD-Vi: [Firmware Warn]: EFR mismatch. Use IVHD EFR
 (0xf77ef22294ada : 0x400f77ef22294ada).
From: =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
In-Reply-To: <bb53516e-6d48-cff8-d14e-32bc76754a26@molgen.mpg.de>
Date: Wed, 15 Sep 2021 10:47:17 +0200
Message-Id: <2DF5BF35-DF81-41B1-825D-E36AF83242DF@8bytes.org>
References: <16533743-de8d-6355-211d-1b4f8949fcfb@molgen.mpg.de>
 <2f5b07e4-5492-330b-b057-55230639cd5e@molgen.mpg.de>
 <YUCRC0CI7rWXt4VA@8bytes.org>
 <38c22e95-aa19-4166-be8a-28749bfacd3e@molgen.mpg.de>
 <3c61d4d9-f6e0-d847-3b60-bde8b3733f09@molgen.mpg.de>
 <D1BCBF26-0F73-434B-8C95-B2CB4934D0A4@8bytes.org>
 <bb53516e-6d48-cff8-d14e-32bc76754a26@molgen.mpg.de>
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

UG9zc2libGUsIGJ1dCBzdGlsbCBERUxMIGlzIHRoZSBmaXJzdCBwb2ludCBvZiBjb250YWN0IGhl
cmUuIElmIHRoZXkgZmluZCBvdXQgdGhhdCB0aGUgcHJvYmxlbSBpcyBhY3R1YWxseSBpbiBBZ2Vz
YSwgdGhlbiBERUxMIGNhbiBlc2NhbGF0ZSB0aGlzIHRvIEFNRC4KCj4gQW0gMTUuMDkuMjAyMSB1
bSAxMDo0MiBzY2hyaWViIFBhdWwgTWVuemVsIDxwbWVuemVsQG1vbGdlbi5tcGcuZGU+Ogo+IAo+
IERlYXIgSsO2cmcsCj4gCj4gCj4gQW0gMTUuMDkuMjEgdW0gMTA6MzAgc2NocmllYiBKw7ZyZyBS
w7ZkZWw6Cj4+IE1haW5seSBERUxMIHNob3VsZCBsb29rIGF0IHRoaXMsIGJlY2F1c2UgaXQgaXMg
dGhlaXIgQklPUyB3aGljaCBpcwo+PiByZXNwb25zaWJsZSBmb3IgdGhpcyBpbmNvbnNpc3RlbmN5
Lgo+IAo+IEkgYW0gbm90IHNvIHN1cmUgYWJvdXQgdGhhdCwgYXMgdG9kYXnigJlzICh4ODYpIGZp
cm13YXJlIG9mdGVuIGNvbnNpc3RzIG9mIHBsYXRmb3JtIGluaXRpYWxpemF0aW9uIChQSSkgY29k
ZSAob3IgZmlybXdhcmUgc3VwcG9ydCBwYWNrYWdlIChGU1ApLCBwcm92aWRlZCBieSB0aGUgY2hp
cHNldC9Tb0MgdmVuZG9ycywgbGlrZSBBR0VTQSBmb3IgQU1ELCB3aGljaCB0aGUgT0RNIGp1c3Qg
aW50ZWdyYXRlLgo+IAo+IElmIG9ubHkgRGVsbCBzeXN0ZW1zIGFyZSBhZmZlY3RlZCwgdGhhdCB3
b3VsZCBvZiBjb3Vyc2UgcG9pbnQgdG8gYSBidWcgaW4gdGhlIERlbGwgZmlybXdhcmUuCj4gCj4g
Cj4gS2luZCByZWdhcmRzLAo+IAo+IFBhdWwKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1m
b3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9s
aXN0aW5mby9pb21tdQ==
