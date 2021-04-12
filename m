Return-Path: <SRS0=Qw7g=JJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6367AC433ED
	for <iommu@archiver.kernel.org>; Mon, 12 Apr 2021 18:07:16 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C98DA61357
	for <iommu@archiver.kernel.org>; Mon, 12 Apr 2021 18:07:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C98DA61357
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 782BC4049B;
	Mon, 12 Apr 2021 18:07:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SCmiO81nIdU7; Mon, 12 Apr 2021 18:07:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id F10704047E;
	Mon, 12 Apr 2021 18:07:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 27662C001F;
	Mon, 12 Apr 2021 18:07:09 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6ADBAC0011
 for <iommu@lists.linux-foundation.org>; Mon, 12 Apr 2021 18:07:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3F3F9400CB
 for <iommu@lists.linux-foundation.org>; Mon, 12 Apr 2021 18:07:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rv787f1ILtEX for <iommu@lists.linux-foundation.org>;
 Mon, 12 Apr 2021 18:07:04 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by smtp2.osuosl.org (Postfix) with ESMTPS id AD65F400AF
 for <iommu@lists.linux-foundation.org>; Mon, 12 Apr 2021 18:07:04 +0000 (UTC)
Received: from [192.168.0.2] (ip5f5ae88d.dynamic.kabel-deutschland.de
 [95.90.232.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id C369520647D4A;
 Mon, 12 Apr 2021 20:07:02 +0200 (CEST)
From: Paul Menzel <pmenzel@molgen.mpg.de>
Subject: AMD-Vi: [Firmware Warn]: EFR mismatch. Use IVHD EFR (0xf77ef22294ada
 : 0x400f77ef22294ada).
To: =?UTF-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
Message-ID: <16533743-de8d-6355-211d-1b4f8949fcfb@molgen.mpg.de>
Date: Mon, 12 Apr 2021 20:07:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
Content-Language: en-US
Cc: iommu@lists.linux-foundation.org, Alexander Monakov <amonakov@ispras.ru>,
 Robert Richter <rrichter@amd.com>
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

RGVhciBMaW51eCBmb2xrcywKCgpPbiB0aGUgRGVsbCBPcHRpUGxleCA1MDU1LCBMaW51eCB3YXJu
cyBhYm91dCBhbiBFRlIgbWlzbWF0Y2ggaW4gdGhlIApmaXJtd2FyZS4KCgpgYGAKW+KApl0KWyAg
ICAwLjAwMDAwMF0gRE1JOiBEZWxsIEluYy4gT3B0aVBsZXggNTA1NSBSeXplbiBDUFUvMFAwM0RY
LCBCSU9TIAoxLjEuMjAgMDUvMzEvMjAxOQpb4oCmXQpbICAgIDEuNDc5Nzc0XSBzbXBib290OiBD
UFUwOiBBTUQgUnl6ZW4gNSBQUk8gMTUwMCBRdWFkLUNvcmUgUHJvY2Vzc29yIAooZmFtaWx5OiAw
eDE3LCBtb2RlbDogMHgxLCBzdGVwcGluZzogMHgxKQpb4oCmXQpbICAgIDIuNTA3MzcwXSBBTUQt
Vmk6IFtGaXJtd2FyZSBXYXJuXTogRUZSIG1pc21hdGNoLiBVc2UgSVZIRCBFRlIgCigweGY3N2Vm
MjIyOTRhZGEgOiAweDQwMGY3N2VmMjIyOTRhZGEKICAgICAgICAgICAgICAgICkuClsgICAgMi41
MDczODFdIHBjaSAwMDAwOjAwOjAwLjI6IEFNRC1WaTogSU9NTVUgcGVyZm9ybWFuY2UgY291bnRl
cnMgCnN1cHBvcnRlZApbICAgIDIuNTI1MjIxXSBwY2kgMDAwMDowMDowMC4yOiBjYW4ndCBkZXJp
dmUgcm91dGluZyBmb3IgUENJIElOVCBBClsgICAgMi41MzEyNDBdIHBjaSAwMDAwOjAwOjAwLjI6
IFBDSSBJTlQgQTogbm90IGNvbm5lY3RlZApbICAgIDIuNTM2NDE1XSBwY2kgMDAwMDowMDowMS4w
OiBBZGRpbmcgdG8gaW9tbXUgZ3JvdXAgMApbICAgIDIuNTQxNDg1XSBwY2kgMDAwMDowMDowMS4z
OiBBZGRpbmcgdG8gaW9tbXUgZ3JvdXAgMQpb4oCmXQpgYGAKClRoZSBkaWZmZXJlbmNlIGluIHRo
ZSBNTUlPIHZhbHVlIGlzIGEgcHJlcGVuZGVkIDB4NDAwLiBDYW4gdGhhdCBiZSAKZXhwbGFpbmVk
IHNvbWVob3c/CgpJZiBub3QsIGl04oCZZCBiZSBncmVhdCwgaWYgeW91IGNvdWxkIGdpdmUgbW9y
ZSBkZXRhaWxzIGFib3V0IHRoZSBmaXJtd2FyZSAKaXNzdWUsIHNvIEkgY2FuIGNvbnRhY3QgdGhl
IERlbGwgc3VwcG9ydCB0byBmaXggdGhlIGZpcm13YXJlLgoKCktpbmQgcmVnYXJkcywKClBhdWwK
CgpbMV06IApodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC90
b3J2YWxkcy9saW51eC5naXQvY29tbWl0Lz9pZD1hNDQwOTJlMzI2ZDQwM2M3ODc4MDE4YmE1MzIz
NjlmODRkMzFkYmZhCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpo
dHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
