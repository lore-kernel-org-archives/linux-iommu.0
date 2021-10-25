Return-Path: <SRS0=+9ml=PN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FFEDC433F5
	for <iommu@archiver.kernel.org>; Mon, 25 Oct 2021 10:25:54 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 614FA61029
	for <iommu@archiver.kernel.org>; Mon, 25 Oct 2021 10:25:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 614FA61029
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 219A840290;
	Mon, 25 Oct 2021 10:25:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1Ysdo30DwlD3; Mon, 25 Oct 2021 10:25:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 472AD40286;
	Mon, 25 Oct 2021 10:25:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1CD5EC0019;
	Mon, 25 Oct 2021 10:25:51 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8B566C000E
 for <iommu@lists.linux-foundation.org>; Mon, 25 Oct 2021 10:25:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 795D04028B
 for <iommu@lists.linux-foundation.org>; Mon, 25 Oct 2021 10:25:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XpOhSgn1XdOn for <iommu@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 10:25:47 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9E8EB40286
 for <iommu@lists.linux-foundation.org>; Mon, 25 Oct 2021 10:25:47 +0000 (UTC)
Received: from [141.14.220.45] (g45.guest.molgen.mpg.de [141.14.220.45])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id CC99861EA191C;
 Mon, 25 Oct 2021 12:25:45 +0200 (CEST)
Message-ID: <7a5123b0-6370-59dc-f0c2-8be5b370d9ba@molgen.mpg.de>
Date: Mon, 25 Oct 2021 12:25:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
Subject: I got an IOMMU IO page fault. What to do now?
To: =?UTF-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
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

RGVhciBMaW51eCBmb2xrcywKCgpPbiBhIERlbGwgT3B0aVBsZXggNTA1NSwgTGludXggNS4xMC4y
NCBsb2dnZWQgdGhlIElPTU1VIG1lc3NhZ2VzIGJlbG93LiAKKEdQVSBoYW5nIGluIGFtZGdwdSBp
c3N1ZSAjMTc2MiBbMV0gbWlnaHQgYmUgcmVsYXRlZC4pCgogICAgICQgbHNwY2kgLW5uIC1zIDA1
OjAwLjAKICAgICAwNTowMC4wIFZHQSBjb21wYXRpYmxlIGNvbnRyb2xsZXIgWzAzMDBdOiBBZHZh
bmNlZCBNaWNybyBEZXZpY2VzLCAKSW5jLiBbQU1EL0FUSV0gT2xhbmQgW1JhZGVvbiBIRCA4NTcw
IC8gUjcgMjQwLzM0MCBPRU1dIFsxMDAyOjY2MTFdIChyZXYgODcpCiAgICAgJCBkbWVzZwogICAg
IFvigKZdCiAgICAgWzYzMTgzOTkuNzQ1MjQyXSBhbWRncHUgMDAwMDowNTowMC4wOiBBTUQtVmk6
IEV2ZW50IGxvZ2dlZCAKW0lPX1BBR0VfRkFVTFQgZG9tYWluPTB4MDAwYyBhZGRyZXNzPTB4ZmZm
ZmZmZjBjMCBmbGFncz0weDAwMjBdCiAgICAgWzYzMTgzOTkuNzU3MjgzXSBhbWRncHUgMDAwMDow
NTowMC4wOiBBTUQtVmk6IEV2ZW50IGxvZ2dlZCAKW0lPX1BBR0VfRkFVTFQgZG9tYWluPTB4MDAw
YyBhZGRyZXNzPTB4ZmZmZmZmZjdjMCBmbGFncz0weDAwMjBdCiAgICAgWzYzMTgzOTkuNzY5MTU0
XSBhbWRncHUgMDAwMDowNTowMC4wOiBBTUQtVmk6IEV2ZW50IGxvZ2dlZCAKW0lPX1BBR0VfRkFV
TFQgZG9tYWluPTB4MDAwYyBhZGRyZXNzPTB4ZmZmZmZmZTBjMCBmbGFncz0weDAwMjBdCiAgICAg
WzYzMTgzOTkuNzgwOTEzXSBhbWRncHUgMDAwMDowNTowMC4wOiBBTUQtVmk6IEV2ZW50IGxvZ2dl
ZCAKW0lPX1BBR0VfRkFVTFQgZG9tYWluPTB4MDAwYyBhZGRyZXNzPTB4ZmZmZmZmZmVjMCBmbGFn
cz0weDAwMjBdCiAgICAgWzYzMTgzOTkuNzkyNzM0XSBhbWRncHUgMDAwMDowNTowMC4wOiBBTUQt
Vmk6IEV2ZW50IGxvZ2dlZCAKW0lPX1BBR0VfRkFVTFQgZG9tYWluPTB4MDAwYyBhZGRyZXNzPTB4
ZmZmZmZmZTVjMCBmbGFncz0weDAwMjBdCiAgICAgWzYzMTgzOTkuODA0MzA5XSBhbWRncHUgMDAw
MDowNTowMC4wOiBBTUQtVmk6IEV2ZW50IGxvZ2dlZCAKW0lPX1BBR0VfRkFVTFQgZG9tYWluPTB4
MDAwYyBhZGRyZXNzPTB4ZmZmZmZmZDBjMCBmbGFncz0weDAwMjBdCiAgICAgWzYzMTgzOTkuODE2
MDkxXSBhbWRncHUgMDAwMDowNTowMC4wOiBBTUQtVmk6IEV2ZW50IGxvZ2dlZCAKW0lPX1BBR0Vf
RkFVTFQgZG9tYWluPTB4MDAwYyBhZGRyZXNzPTB4ZmZmZmZmZWNjMCBmbGFncz0weDAwMjBdCiAg
ICAgWzYzMTgzOTkuODI3NDA3XSBhbWRncHUgMDAwMDowNTowMC4wOiBBTUQtVmk6IEV2ZW50IGxv
Z2dlZCAKW0lPX1BBR0VfRkFVTFQgZG9tYWluPTB4MDAwYyBhZGRyZXNzPTB4ZmZmZmZmZDNjMCBm
bGFncz0weDAwMjBdCiAgICAgWzYzMTgzOTkuODM4NzA4XSBhbWRncHUgMDAwMDowNTowMC4wOiBB
TUQtVmk6IEV2ZW50IGxvZ2dlZCAKW0lPX1BBR0VfRkFVTFQgZG9tYWluPTB4MDAwYyBhZGRyZXNz
PTB4ZmZmZmZmYzBjMCBmbGFncz0weDAwMjBdCiAgICAgWzYzMTgzOTkuODUwMDI5XSBhbWRncHUg
MDAwMDowNTowMC4wOiBBTUQtVmk6IEV2ZW50IGxvZ2dlZCAKW0lPX1BBR0VfRkFVTFQgZG9tYWlu
PTB4MDAwYyBhZGRyZXNzPTB4ZmZmZmZmZGFjMCBmbGFncz0weDAwMjBdCiAgICAgWzYzMTgzOTku
ODYxMzExXSBBTUQtVmk6IEV2ZW50IGxvZ2dlZCBbSU9fUEFHRV9GQVVMVCBkZXZpY2U9MDU6MDAu
MCAKZG9tYWluPTB4MDAwYyBhZGRyZXNzPTB4ZmZmZmZmYzFjMCBmbGFncz0weDAwMjBdCiAgICAg
WzYzMTgzOTkuODcyMDQ0XSBBTUQtVmk6IEV2ZW50IGxvZ2dlZCBbSU9fUEFHRV9GQVVMVCBkZXZp
Y2U9MDU6MDAuMCAKZG9tYWluPTB4MDAwYyBhZGRyZXNzPTB4ZmZmZmZmYzhjMCBmbGFncz0weDAw
MjBdCiAgICAgWzYzMTgzOTkuODgyNzk3XSBBTUQtVmk6IEV2ZW50IGxvZ2dlZCBbSU9fUEFHRV9G
QVVMVCBkZXZpY2U9MDU6MDAuMCAKZG9tYWluPTB4MDAwYyBhZGRyZXNzPTB4ZmZmZmZmYjBjMCBm
bGFncz0weDAwMjBdCiAgICAgWzYzMTgzOTkuODkzNjU1XSBBTUQtVmk6IEV2ZW50IGxvZ2dlZCBb
SU9fUEFHRV9GQVVMVCBkZXZpY2U9MDU6MDAuMCAKZG9tYWluPTB4MDAwYyBhZGRyZXNzPTB4ZmZm
ZmZmY2ZjMCBmbGFncz0weDAwMjBdCiAgICAgWzYzMTgzOTkuOTA0NDQ1XSBBTUQtVmk6IEV2ZW50
IGxvZ2dlZCBbSU9fUEFHRV9GQVVMVCBkZXZpY2U9MDU6MDAuMCAKZG9tYWluPTB4MDAwYyBhZGRy
ZXNzPTB4ZmZmZmZmYjZjMCBmbGFncz0weDAwMjBdCiAgICAgWzYzMTgzOTkuOTE1MjIyXSBBTUQt
Vmk6IEV2ZW50IGxvZ2dlZCBbSU9fUEFHRV9GQVVMVCBkZXZpY2U9MDU6MDAuMCAKZG9tYWluPTB4
MDAwYyBhZGRyZXNzPTB4ZmZmZmZmYTBjMCBmbGFncz0weDAwMjBdCiAgICAgWzYzMTgzOTkuOTI1
OTMxXSBBTUQtVmk6IEV2ZW50IGxvZ2dlZCBbSU9fUEFHRV9GQVVMVCBkZXZpY2U9MDU6MDAuMCAK
ZG9tYWluPTB4MDAwYyBhZGRyZXNzPTB4ZmZmZmZmYmRjMCBmbGFncz0weDAwMjBdCiAgICAgWzYz
MTgzOTkuOTM2NjkxXSBBTUQtVmk6IEV2ZW50IGxvZ2dlZCBbSU9fUEFHRV9GQVVMVCBkZXZpY2U9
MDU6MDAuMCAKZG9tYWluPTB4MDAwYyBhZGRyZXNzPTB4ZmZmZmZmYTRjMCBmbGFncz0weDAwMjBd
CiAgICAgWzYzMTgzOTkuOTQ3NDc5XSBBTUQtVmk6IEV2ZW50IGxvZ2dlZCBbSU9fUEFHRV9GQVVM
VCBkZXZpY2U9MDU6MDAuMCAKZG9tYWluPTB4MDAwYyBhZGRyZXNzPTB4ZmZmZmZmOTBjMCBmbGFn
cz0weDAwMjBdCiAgICAgWzYzMTgzOTkuOTU4MjcwXSBBTUQtVmk6IEV2ZW50IGxvZ2dlZCBbSU9f
UEFHRV9GQVVMVCBkZXZpY2U9MDU6MDAuMCAKZG9tYWluPTB4MDAwYyBhZGRyZXNzPTB4ZmZmZmZm
YWJjMCBmbGFncz0weDAwMjBdCgpBcyB0aGlzIGlzIG5vdCByZXByb2R1Y2libGUsIGhvdyB3b3Vs
ZCBkZWJ1Z2dpbmcgZ28/IChUaGUgc3lzdGVtIHdhcyAKcmVib290ZWQgaW4gdGhlIG1lYW50aW1l
LikgV2hhdCBvcHRpb25zIHNob3VsZCBiZSBlbmFibGVkLCB0aGF0IG5leHQgCnRpbWUgdGhlIHJl
cXVpcmVkIGluZm9ybWF0aW9uIGlzIGxvZ2dlZCwgb3Igd2hhdCBjb21tYW5kcyBzaG91bGQgSSAK
ZXhlY3V0ZSB3aGVuIHRoZSBzeXN0ZW0gaXMgc3RpbGwgaW4gdGhhdCBzdGF0ZSwgc28gdGhlIGJ1
ZyAoZHJpdmVyLCAKdXNlcnNwYWNlLCDigKYpIGNhbiBiZSBwaW5wb2ludGVkIGFuZCBmaXhlZD8K
CgpLaW5kIHJlZ2FyZHMsCgpQYXVsCgoKWzFdOiBodHRwczovL2dpdGxhYi5mcmVlZGVza3RvcC5v
cmcvZHJtL2FtZC8tL2lzc3Vlcy8xNzYyCiAgICAgICJPbGFuZCBbUmFkZW9uIEhEIDg1NzAgLyBS
NyAyNDAvMzQwIE9FTV06IEdQVSBoYW5nIgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91
bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlz
dGluZm8vaW9tbXU=
