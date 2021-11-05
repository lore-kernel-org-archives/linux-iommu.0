Return-Path: <SRS0=j10w=PY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCB13C433F5
	for <iommu@archiver.kernel.org>; Fri,  5 Nov 2021 11:56:17 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4589D61352
	for <iommu@archiver.kernel.org>; Fri,  5 Nov 2021 11:56:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4589D61352
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E48CA823E2;
	Fri,  5 Nov 2021 11:56:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7s1NQeGliNqb; Fri,  5 Nov 2021 11:56:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id DDDA582410;
	Fri,  5 Nov 2021 11:56:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B1488C0019;
	Fri,  5 Nov 2021 11:56:15 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 40B2AC000E
 for <iommu@lists.linux-foundation.org>; Fri,  5 Nov 2021 11:56:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2280B823E2
 for <iommu@lists.linux-foundation.org>; Fri,  5 Nov 2021 11:56:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id co4_BAHighP3 for <iommu@lists.linux-foundation.org>;
 Fri,  5 Nov 2021 11:56:11 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7901581D98
 for <iommu@lists.linux-foundation.org>; Fri,  5 Nov 2021 11:56:11 +0000 (UTC)
Received: from [192.168.0.2] (ip5f5ae8e7.dynamic.kabel-deutschland.de
 [95.90.232.231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id 8229861EA191E;
 Fri,  5 Nov 2021 12:56:09 +0100 (CET)
Message-ID: <de6706b2-4ea5-ce68-6b72-02090b98630f@molgen.mpg.de>
Date: Fri, 5 Nov 2021 12:56:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
From: Paul Menzel <pmenzel@molgen.mpg.de>
Subject: How to reduce PCI initialization from 5 s (1.5 s adding them to IOMMU
 groups)
To: =?UTF-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Bjorn Helgaas <bhelgaas@google.com>
Content-Language: en-US
Cc: linux-pci@vger.kernel.org, x86@kernel.org,
 LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Thomas Gleixner <tglx@linutronix.de>
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

RGVhciBMaW51eCBmb2xrcywKCgpPbiBhIFBvd2VyRWRnZSBUNDQwLzAyMUtDRCwgQklPUyAyLjEx
LjIgMDQvMjIvMjAyMSwgTGludXggNS4xMC43MCB0YWtlcyAKYWxtb3N0IGZpdmUgc2Vjb25kcyB0
byBpbml0aWFsaXplIFBDSS4gQWNjb3JkaW5nIHRvIHRoZSB0aW1lc3RhbXBzLCAxLjUgCnMgYXJl
IGZyb20gYXNzaWduaW5nIHRoZSBQQ0kgZGV2aWNlcyB0byB0aGUgMTQyIElPTU1VIGdyb3Vwcy4K
CmBgYAokIGxzcGNpIHwgd2MgLWwKMjgxCiQgZG1lc2cKW+KApl0KWyAgICAyLjkxODQxMV0gUENJ
OiBVc2luZyBob3N0IGJyaWRnZSB3aW5kb3dzIGZyb20gQUNQSTsgaWYgbmVjZXNzYXJ5LCAKdXNl
ICJwY2k9bm9jcnMiIGFuZCByZXBvcnQgYSBidWcKWyAgICAyLjkzMzg0MV0gQUNQSTogRW5hYmxl
ZCA1IEdQRXMgaW4gYmxvY2sgMDAgdG8gN0YKWyAgICAyLjk3MzczOV0gQUNQSTogUENJIFJvb3Qg
QnJpZGdlIFtQQzAwXSAoZG9tYWluIDAwMDAgW2J1cyAwMC0xNl0pClsgICAgMi45ODAzOThdIGFj
cGkgUE5QMEEwODowMDogX09TQzogT1Mgc3VwcG9ydHMgW0V4dGVuZGVkQ29uZmlnIEFTUE0gCkNs
b2NrUE0gU2VnbWVudHMgTVNJIEhQWC1UeXBlM10KWyAgICAyLjk4OTQ1N10gYWNwaSBQTlAwQTA4
OjAwOiBfT1NDOiBwbGF0Zm9ybSBkb2VzIG5vdCBzdXBwb3J0IFtMVFJdClsgICAgMi45OTU0NTFd
IGFjcGkgUE5QMEEwODowMDogX09TQzogT1Mgbm93IGNvbnRyb2xzIFtQTUUgUENJZUNhcGFiaWxp
dHldClsgICAgMy4wMDEzOTRdIGFjcGkgUE5QMEEwODowMDogRkFEVCBpbmRpY2F0ZXMgQVNQTSBp
cyB1bnN1cHBvcnRlZCwgCnVzaW5nIEJJT1MgY29uZmlndXJhdGlvbgpbICAgIDMuMDEwNTExXSBQ
Q0kgaG9zdCBicmlkZ2UgdG8gYnVzIDAwMDA6MDAKW+KApl0KWyAgICA2LjIzMzUwOF0gc3lzdGVt
IDAwOjA1OiBbaW8gIDB4MTAwMC0weDEwZmVdIGhhcyBiZWVuIHJlc2VydmVkClsgICAgNi4yMzk0
MjBdIHN5c3RlbSAwMDowNTogUGx1ZyBhbmQgUGxheSBBQ1BJIGRldmljZSwgSURzIFBOUDBjMDIg
KGFjdGl2ZSkKWyAgICA2LjIzOTkwNl0gcG5wOiBQblAgQUNQSTogZm91bmQgNiBkZXZpY2VzClvi
gKZdClsgICAgNi45ODkwMTZdIHBjaSAwMDAwOmQ3OjA1LjA6IGRpc2FibGVkIGJvb3QgaW50ZXJy
dXB0cyBvbiBkZXZpY2UgCls4MDg2OjIwMzRdClsgICAgNi45OTYwNjNdIFBDSTogQ0xTIDAgYnl0
ZXMsIGRlZmF1bHQgNjQKWyAgICA3LjAwMDAwOF0gVHJ5aW5nIHRvIHVucGFjayByb290ZnMgaW1h
Z2UgYXMgaW5pdHJhbWZzLi4uClsgICAgNy4wNjUyODFdIEZyZWVpbmcgaW5pdHJkIG1lbW9yeTog
NTEzNksKW+KApl0KWyAgICA3LjA3OTA5OF0gRE1BUjogZG1hcjc6IFVzaW5nIFF1ZXVlZCBpbnZh
bGlkYXRpb24KWyAgICA3LjA4Mzk4M10gcGNpIDAwMDA6MDA6MDAuMDogQWRkaW5nIHRvIGlvbW11
IGdyb3VwIDAKW+KApl0KWyAgICA4LjUzNzgwOF0gcGNpIDAwMDA6ZDc6MTcuMTogQWRkaW5nIHRv
IGlvbW11IGdyb3VwIDE0MQpbICAgIDguNTcxMTkxXSBETUFSOiBJbnRlbChSKSBWaXJ0dWFsaXph
dGlvbiBUZWNobm9sb2d5IGZvciBEaXJlY3RlZCBJL08KWyAgICA4LjU3NzYxOF0gUENJLURNQTog
VXNpbmcgc29mdHdhcmUgYm91bmNlIGJ1ZmZlcmluZyBmb3IgSU8gKFNXSU9UTEIpClvigKZdCmBg
YAoKSXMgdGhlcmUgYW55dGhpbmcgdGhhdCBjb3VsZCBiZSBkb25lIHRvIHJlZHVjZSB0aGUgdGlt
ZT8KCgpLaW5kIHJlZ2FyZHMsCgpQYXVsCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3Vu
ZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0
aW5mby9pb21tdQ==
