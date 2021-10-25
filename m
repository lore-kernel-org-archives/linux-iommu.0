Return-Path: <SRS0=+9ml=PN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B4D1C433F5
	for <iommu@archiver.kernel.org>; Mon, 25 Oct 2021 11:23:45 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC07960F46
	for <iommu@archiver.kernel.org>; Mon, 25 Oct 2021 11:23:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org AC07960F46
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6A95180D77;
	Mon, 25 Oct 2021 11:23:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fJ7OgzBNmFfC; Mon, 25 Oct 2021 11:23:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 29BAF80D75;
	Mon, 25 Oct 2021 11:23:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F22FBC0012;
	Mon, 25 Oct 2021 11:23:42 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 74486C000E
 for <iommu@lists.linux-foundation.org>; Mon, 25 Oct 2021 11:23:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 63278400C8
 for <iommu@lists.linux-foundation.org>; Mon, 25 Oct 2021 11:23:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jjeGUMnHZlNS for <iommu@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 11:23:41 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 by smtp4.osuosl.org (Postfix) with ESMTPS id F20094009D
 for <iommu@lists.linux-foundation.org>; Mon, 25 Oct 2021 11:23:40 +0000 (UTC)
Received: by mail-wr1-x42c.google.com with SMTP id w15so8551012wra.3
 for <iommu@lists.linux-foundation.org>; Mon, 25 Oct 2021 04:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=pnAOfuMn5EWMJj8YVjvNcYDnPGOu1OrWcdPGU69i9WU=;
 b=dcLz/4fMoOzmVl2D+aaGjBKG2ULuC3/o64EkVkImWK67kW3V4mwvpKWoMWuTA7VaYw
 Bg+hj+NxCwOr87qPewiOOkZ0VT4MMcDzpEBDNYRGPXT0GRgINVje/dOiUaQlZSIhXbtE
 FbflKlBYNaekSlStrbDOZJil1+qZvf4BsNbTIaLOJXTgsf0yoON4Mh0U3MOOphN53OpI
 3PAPBIlNXzNcF6AV6XmkshR4Hd36eQrglS4qF+PCBDRZ+w2QwVNm/F5NFro4zyolq+hQ
 8bgafTrKHxRz3FLrauXnlc+TgF4X/GNFaj6lfg7d3xqm4y1l7VFGBukPzqk2a+gFEDEU
 NuRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=pnAOfuMn5EWMJj8YVjvNcYDnPGOu1OrWcdPGU69i9WU=;
 b=gxIxdB+e9BjrLQALuif0Fs73qBYPC+kd6Fxfi4UEHfa/bBkgIWU8FvHxfjZ2t4y44Z
 nPqLjZvxaU6TVQt0a/fgmsKbaE0mGNPVTzHnJcfjT5PcXWGyDktAHVSRWsusAUYjYkxu
 2JpzlRUgMsqr2Uhy4q2l55pk4I19GOLmrsIV1ZAmlE5k4KmdRwz/I2p9FkGRssRzMdwc
 FnTKkoG7qkw7GAZzBukrwiM0qlV/F4lw3IZvrKv/UA/ZNAz8uUZrw0NwD6BhNBF8lTNm
 gF4iuOBw8MIwPtcHfXWuVdZT+0vWZICzN05ln33o8H9HA3xlQQHoFqMFXMy3EbhC5QCJ
 wTag==
X-Gm-Message-State: AOAM532Rbxv1gOT442haL4QTYQlUVSRJaLRLLL4VWVacDBn/u/mcKuYj
 vEKFONm/lNnPzq2Ae5UEykU=
X-Google-Smtp-Source: ABdhPJx0t3+Pcy8GZqhqvya20QCKopu7PsZvwn6w0Fdd4q31S3HmDFYbbvzQoRHLvC2Af/Pma2lIXA==
X-Received: by 2002:a5d:62d0:: with SMTP id o16mr22842373wrv.206.1635161019070; 
 Mon, 25 Oct 2021 04:23:39 -0700 (PDT)
Received: from [192.168.178.21] (p5b0ea1b5.dip0.t-ipconnect.de.
 [91.14.161.181])
 by smtp.gmail.com with ESMTPSA id j7sm20229073wmq.32.2021.10.25.04.23.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 Oct 2021 04:23:38 -0700 (PDT)
Subject: Re: I got an IOMMU IO page fault. What to do now?
To: Paul Menzel <pmenzel@molgen.mpg.de>, =?UTF-8?B?SsO2cmcgUsO2ZGVs?=
 <joro@8bytes.org>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
References: <7a5123b0-6370-59dc-f0c2-8be5b370d9ba@molgen.mpg.de>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <0cfccc44-6cc6-98f5-ecd6-2f376839ec18@gmail.com>
Date: Mon, 25 Oct 2021 13:23:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <7a5123b0-6370-59dc-f0c2-8be5b370d9ba@molgen.mpg.de>
Content-Language: en-US
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

SGkgUGF1bCwKCm5vdCBzdXJlIGhvdyB0aGUgSU9NTVUgZ2l2ZXMgb3V0IGFkZHJlc3NlcywgYnV0
IHRoZSBwcmludGVkIG9uZXMgbG9vayAKc3VzcGljaW91cyB0byBtZS4gU29tZXRoaW5nIGxpa2Ug
d2UgYXJlIHVzaW5nIGFuIGludmFsaWQgYWRkcmVzcyBsaWtlIC0xIApvciBzaW1pbGFyLgoKQ2Fu
IHlvdSB0cnkgdGhhdCBvbiBhbiB1cCB0byBkYXRlIGtlcm5lbCBhcyB3ZWxsPyBFLmcuIGlkZWFs
bHkgYmxlZWRpbmcgCmVkZ2UgYW1kLXN0YWdpbmctZHJtLW5leHQgZnJvbSBBbGV4IHJlcG9zaXRv
cnkuCgpSZWdhcmRzLApDaHJpc3RpYW4uCgpBbSAyNS4xMC4yMSB1bSAxMjoyNSBzY2hyaWViIFBh
dWwgTWVuemVsOgo+IERlYXIgTGludXggZm9sa3MsCj4KPgo+IE9uIGEgRGVsbCBPcHRpUGxleCA1
MDU1LCBMaW51eCA1LjEwLjI0IGxvZ2dlZCB0aGUgSU9NTVUgbWVzc2FnZXMgCj4gYmVsb3cuIChH
UFUgaGFuZyBpbiBhbWRncHUgaXNzdWUgIzE3NjIgWzFdIG1pZ2h0IGJlIHJlbGF0ZWQuKQo+Cj4g
wqDCoMKgICQgbHNwY2kgLW5uIC1zIDA1OjAwLjAKPiDCoMKgwqAgMDU6MDAuMCBWR0EgY29tcGF0
aWJsZSBjb250cm9sbGVyIFswMzAwXTogQWR2YW5jZWQgTWljcm8gRGV2aWNlcywgCj4gSW5jLiBb
QU1EL0FUSV0gT2xhbmQgW1JhZGVvbiBIRCA4NTcwIC8gUjcgMjQwLzM0MCBPRU1dIFsxMDAyOjY2
MTFdIAo+IChyZXYgODcpCj4gwqDCoMKgICQgZG1lc2cKPiDCoMKgwqAgW+KApl0KPiDCoMKgwqAg
WzYzMTgzOTkuNzQ1MjQyXSBhbWRncHUgMDAwMDowNTowMC4wOiBBTUQtVmk6IEV2ZW50IGxvZ2dl
ZCAKPiBbSU9fUEFHRV9GQVVMVCBkb21haW49MHgwMDBjIGFkZHJlc3M9MHhmZmZmZmZmMGMwIGZs
YWdzPTB4MDAyMF0KPiDCoMKgwqAgWzYzMTgzOTkuNzU3MjgzXSBhbWRncHUgMDAwMDowNTowMC4w
OiBBTUQtVmk6IEV2ZW50IGxvZ2dlZCAKPiBbSU9fUEFHRV9GQVVMVCBkb21haW49MHgwMDBjIGFk
ZHJlc3M9MHhmZmZmZmZmN2MwIGZsYWdzPTB4MDAyMF0KPiDCoMKgwqAgWzYzMTgzOTkuNzY5MTU0
XSBhbWRncHUgMDAwMDowNTowMC4wOiBBTUQtVmk6IEV2ZW50IGxvZ2dlZCAKPiBbSU9fUEFHRV9G
QVVMVCBkb21haW49MHgwMDBjIGFkZHJlc3M9MHhmZmZmZmZlMGMwIGZsYWdzPTB4MDAyMF0KPiDC
oMKgwqAgWzYzMTgzOTkuNzgwOTEzXSBhbWRncHUgMDAwMDowNTowMC4wOiBBTUQtVmk6IEV2ZW50
IGxvZ2dlZCAKPiBbSU9fUEFHRV9GQVVMVCBkb21haW49MHgwMDBjIGFkZHJlc3M9MHhmZmZmZmZm
ZWMwIGZsYWdzPTB4MDAyMF0KPiDCoMKgwqAgWzYzMTgzOTkuNzkyNzM0XSBhbWRncHUgMDAwMDow
NTowMC4wOiBBTUQtVmk6IEV2ZW50IGxvZ2dlZCAKPiBbSU9fUEFHRV9GQVVMVCBkb21haW49MHgw
MDBjIGFkZHJlc3M9MHhmZmZmZmZlNWMwIGZsYWdzPTB4MDAyMF0KPiDCoMKgwqAgWzYzMTgzOTku
ODA0MzA5XSBhbWRncHUgMDAwMDowNTowMC4wOiBBTUQtVmk6IEV2ZW50IGxvZ2dlZCAKPiBbSU9f
UEFHRV9GQVVMVCBkb21haW49MHgwMDBjIGFkZHJlc3M9MHhmZmZmZmZkMGMwIGZsYWdzPTB4MDAy
MF0KPiDCoMKgwqAgWzYzMTgzOTkuODE2MDkxXSBhbWRncHUgMDAwMDowNTowMC4wOiBBTUQtVmk6
IEV2ZW50IGxvZ2dlZCAKPiBbSU9fUEFHRV9GQVVMVCBkb21haW49MHgwMDBjIGFkZHJlc3M9MHhm
ZmZmZmZlY2MwIGZsYWdzPTB4MDAyMF0KPiDCoMKgwqAgWzYzMTgzOTkuODI3NDA3XSBhbWRncHUg
MDAwMDowNTowMC4wOiBBTUQtVmk6IEV2ZW50IGxvZ2dlZCAKPiBbSU9fUEFHRV9GQVVMVCBkb21h
aW49MHgwMDBjIGFkZHJlc3M9MHhmZmZmZmZkM2MwIGZsYWdzPTB4MDAyMF0KPiDCoMKgwqAgWzYz
MTgzOTkuODM4NzA4XSBhbWRncHUgMDAwMDowNTowMC4wOiBBTUQtVmk6IEV2ZW50IGxvZ2dlZCAK
PiBbSU9fUEFHRV9GQVVMVCBkb21haW49MHgwMDBjIGFkZHJlc3M9MHhmZmZmZmZjMGMwIGZsYWdz
PTB4MDAyMF0KPiDCoMKgwqAgWzYzMTgzOTkuODUwMDI5XSBhbWRncHUgMDAwMDowNTowMC4wOiBB
TUQtVmk6IEV2ZW50IGxvZ2dlZCAKPiBbSU9fUEFHRV9GQVVMVCBkb21haW49MHgwMDBjIGFkZHJl
c3M9MHhmZmZmZmZkYWMwIGZsYWdzPTB4MDAyMF0KPiDCoMKgwqAgWzYzMTgzOTkuODYxMzExXSBB
TUQtVmk6IEV2ZW50IGxvZ2dlZCBbSU9fUEFHRV9GQVVMVCAKPiBkZXZpY2U9MDU6MDAuMCBkb21h
aW49MHgwMDBjIGFkZHJlc3M9MHhmZmZmZmZjMWMwIGZsYWdzPTB4MDAyMF0KPiDCoMKgwqAgWzYz
MTgzOTkuODcyMDQ0XSBBTUQtVmk6IEV2ZW50IGxvZ2dlZCBbSU9fUEFHRV9GQVVMVCAKPiBkZXZp
Y2U9MDU6MDAuMCBkb21haW49MHgwMDBjIGFkZHJlc3M9MHhmZmZmZmZjOGMwIGZsYWdzPTB4MDAy
MF0KPiDCoMKgwqAgWzYzMTgzOTkuODgyNzk3XSBBTUQtVmk6IEV2ZW50IGxvZ2dlZCBbSU9fUEFH
RV9GQVVMVCAKPiBkZXZpY2U9MDU6MDAuMCBkb21haW49MHgwMDBjIGFkZHJlc3M9MHhmZmZmZmZi
MGMwIGZsYWdzPTB4MDAyMF0KPiDCoMKgwqAgWzYzMTgzOTkuODkzNjU1XSBBTUQtVmk6IEV2ZW50
IGxvZ2dlZCBbSU9fUEFHRV9GQVVMVCAKPiBkZXZpY2U9MDU6MDAuMCBkb21haW49MHgwMDBjIGFk
ZHJlc3M9MHhmZmZmZmZjZmMwIGZsYWdzPTB4MDAyMF0KPiDCoMKgwqAgWzYzMTgzOTkuOTA0NDQ1
XSBBTUQtVmk6IEV2ZW50IGxvZ2dlZCBbSU9fUEFHRV9GQVVMVCAKPiBkZXZpY2U9MDU6MDAuMCBk
b21haW49MHgwMDBjIGFkZHJlc3M9MHhmZmZmZmZiNmMwIGZsYWdzPTB4MDAyMF0KPiDCoMKgwqAg
WzYzMTgzOTkuOTE1MjIyXSBBTUQtVmk6IEV2ZW50IGxvZ2dlZCBbSU9fUEFHRV9GQVVMVCAKPiBk
ZXZpY2U9MDU6MDAuMCBkb21haW49MHgwMDBjIGFkZHJlc3M9MHhmZmZmZmZhMGMwIGZsYWdzPTB4
MDAyMF0KPiDCoMKgwqAgWzYzMTgzOTkuOTI1OTMxXSBBTUQtVmk6IEV2ZW50IGxvZ2dlZCBbSU9f
UEFHRV9GQVVMVCAKPiBkZXZpY2U9MDU6MDAuMCBkb21haW49MHgwMDBjIGFkZHJlc3M9MHhmZmZm
ZmZiZGMwIGZsYWdzPTB4MDAyMF0KPiDCoMKgwqAgWzYzMTgzOTkuOTM2NjkxXSBBTUQtVmk6IEV2
ZW50IGxvZ2dlZCBbSU9fUEFHRV9GQVVMVCAKPiBkZXZpY2U9MDU6MDAuMCBkb21haW49MHgwMDBj
IGFkZHJlc3M9MHhmZmZmZmZhNGMwIGZsYWdzPTB4MDAyMF0KPiDCoMKgwqAgWzYzMTgzOTkuOTQ3
NDc5XSBBTUQtVmk6IEV2ZW50IGxvZ2dlZCBbSU9fUEFHRV9GQVVMVCAKPiBkZXZpY2U9MDU6MDAu
MCBkb21haW49MHgwMDBjIGFkZHJlc3M9MHhmZmZmZmY5MGMwIGZsYWdzPTB4MDAyMF0KPiDCoMKg
wqAgWzYzMTgzOTkuOTU4MjcwXSBBTUQtVmk6IEV2ZW50IGxvZ2dlZCBbSU9fUEFHRV9GQVVMVCAK
PiBkZXZpY2U9MDU6MDAuMCBkb21haW49MHgwMDBjIGFkZHJlc3M9MHhmZmZmZmZhYmMwIGZsYWdz
PTB4MDAyMF0KPgo+IEFzIHRoaXMgaXMgbm90IHJlcHJvZHVjaWJsZSwgaG93IHdvdWxkIGRlYnVn
Z2luZyBnbz8gKFRoZSBzeXN0ZW0gd2FzIAo+IHJlYm9vdGVkIGluIHRoZSBtZWFudGltZS4pIFdo
YXQgb3B0aW9ucyBzaG91bGQgYmUgZW5hYmxlZCwgdGhhdCBuZXh0IAo+IHRpbWUgdGhlIHJlcXVp
cmVkIGluZm9ybWF0aW9uIGlzIGxvZ2dlZCwgb3Igd2hhdCBjb21tYW5kcyBzaG91bGQgSSAKPiBl
eGVjdXRlIHdoZW4gdGhlIHN5c3RlbSBpcyBzdGlsbCBpbiB0aGF0IHN0YXRlLCBzbyB0aGUgYnVn
IChkcml2ZXIsIAo+IHVzZXJzcGFjZSwg4oCmKSBjYW4gYmUgcGlucG9pbnRlZCBhbmQgZml4ZWQ/
Cj4KPgo+IEtpbmQgcmVnYXJkcywKPgo+IFBhdWwKPgo+Cj4gWzFdOiBodHRwczovL2dpdGxhYi5m
cmVlZGVza3RvcC5vcmcvZHJtL2FtZC8tL2lzc3Vlcy8xNzYyCj4gwqDCoMKgwqAgIk9sYW5kIFtS
YWRlb24gSEQgODU3MCAvIFI3IDI0MC8zNDAgT0VNXTogR1BVIGhhbmciCgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9t
bXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRp
b24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
