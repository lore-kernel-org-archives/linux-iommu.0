Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A8BFC433EF
	for <iommu@archiver.kernel.org>; Tue, 28 Jun 2022 23:09:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C415560EA0;
	Tue, 28 Jun 2022 23:09:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C415560EA0
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=EqbuEMnr
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HgZFSdm7sjMA; Tue, 28 Jun 2022 23:09:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 5F0A660B57;
	Tue, 28 Jun 2022 23:09:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5F0A660B57
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 224C0C0032;
	Tue, 28 Jun 2022 23:09:13 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1F831C002D
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jun 2022 23:09:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D7F85408D2
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jun 2022 23:09:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D7F85408D2
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20210112 header.b=EqbuEMnr
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id enToSe3c0CP2 for <iommu@lists.linux-foundation.org>;
 Tue, 28 Jun 2022 23:09:10 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BC9B740899
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com
 [IPv6:2607:f8b0:4864:20::102c])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BC9B740899
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jun 2022 23:09:10 +0000 (UTC)
Received: by mail-pj1-x102c.google.com with SMTP id
 m14-20020a17090a668e00b001ee6ece8368so8192807pjj.3
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jun 2022 16:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=dNlrbJyo72p6W86+4oHtq0SFKKEweCfCqBRbkZwsc7M=;
 b=EqbuEMnrslAV+CNK7icH3sIdyHFdJJt4o0XreMd9PWJnnZD3urkUIczP47SLJfHLt2
 a9Hb2RY2iAMPDYrZzzSebZiLkEkZAZ2GjO1a/YmSZkK2Xp17oEjfDGogNixZdLL3HOfT
 MzvWAi3e8vTQIn19ErTtVtK9046FovgWZzO54p+FjfQ0vKr2M4MHFIDFYcsnV6vwqKlZ
 OpVSBU4xgvKUep3BWnCx5mqYbaYMbM8l8r4kRGa0fyiirmqh9Q5Jv5kmLBa0iY42WhAG
 mXPGja9Jz5H3RSM3uxCyFKm/5U62U9tV2w1DJBxZ5P0LBgo5T9Yd1NziQJflQEY9hQZf
 YhCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=dNlrbJyo72p6W86+4oHtq0SFKKEweCfCqBRbkZwsc7M=;
 b=4nR8oUKV7qYNWEFr/VrFxrPHcuiF7Azx1DUm0dvCpLFXkda5z9lv4sq1x/bZfXOpSF
 r1bnfioYO30XVu5+kBnjBR0GwQEeIZ6WiHGpLqY5YlsF2afxyrIhINnwziLDKd1icjoi
 XVJxc2nwBGgtrH/9i78hTjoREbhBzd8P2D7D/xAGHzyeKxtX043TByZyUgnIE+KoHNAg
 noZOFt/ZWFnmZVOI6o0f6IfJ0i8J3DXFzvn3fHDBjatO8i3YfT5CIN9aajY6qd131Vsb
 bQ2xw9+ksUJ4mxVL7hbjL9hP7UZFGg9l8CGd2glj6DsQaIDyxC4zI3g8kB8h+VIS3xAu
 V5xQ==
X-Gm-Message-State: AJIora9NoRV7lkmTMsEiAGDOMRvzVNY3Tk9oHkpFW0rWa+5Rch0AHg7O
 I49NX8IAO347KVbJUTvnoqk=
X-Google-Smtp-Source: AGRyM1sKFPd7rmb+HZNy3hqqLYOU4RMipHtRZ0GXpNrqgiP6rjxKGk/MTbwV1Q3gFv+zgJ5mODs7jg==
X-Received: by 2002:a17:902:d50e:b0:16a:13d:30ab with SMTP id
 b14-20020a170902d50e00b0016a013d30abmr7366924plg.31.1656457750171; 
 Tue, 28 Jun 2022 16:09:10 -0700 (PDT)
Received: from ?IPV6:2001:df0:0:200c:75aa:d6ca:4354:6033?
 ([2001:df0:0:200c:75aa:d6ca:4354:6033])
 by smtp.gmail.com with ESMTPSA id
 jy18-20020a17090b325200b001e31803540fsm450854pjb.6.2022.06.28.16.09.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jun 2022 16:09:09 -0700 (PDT)
Message-ID: <9f812d3d-0fcd-46e6-6d7e-6d4bf66f24ab@gmail.com>
Date: Wed, 29 Jun 2022 11:09:00 +1200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 3/3] arch/*/: remove CONFIG_VIRT_TO_BUS
Content-Language: en-US
To: Arnd Bergmann <arnd@kernel.org>
References: <20220617125750.728590-1-arnd@kernel.org>
 <20220617125750.728590-4-arnd@kernel.org>
 <6ba86afe-bf9f-1aca-7af1-d0d348d75ffc@gmail.com>
 <CAMuHMdVewn0OYA9oJfStk0-+vCKAUou+4Mvd5H2kmrSks1p5jg@mail.gmail.com>
 <b4e5a1c9-e375-63fb-ec7c-abb7384a6d59@gmail.com>
 <9289fd82-285c-035f-5355-4d70ce4f87b0@gmail.com>
 <CAMuHMdXUihTPD9A9hs__Xr2ErfOqkZ5KgCHqm+9HvRf39uS5kA@mail.gmail.com>
 <c30bc9b6-6ccd-8856-dc6b-4e16450dad6f@gmail.com>
 <CAK8P3a1rxEVwVF5U-PO6pQkfURU5Tro1Qp8SPUfHEV9jjWOmCQ@mail.gmail.com>
From: Michael Schmitz <schmitzmic@gmail.com>
In-Reply-To: <CAK8P3a1rxEVwVF5U-PO6pQkfURU5Tro1Qp8SPUfHEV9jjWOmCQ@mail.gmail.com>
Cc: Linux-Arch <linux-arch@vger.kernel.org>, scsi <linux-scsi@vger.kernel.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Christoph Hellwig <hch@infradead.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Jakub Kicinski <kuba@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, Denis Efremov <efremov@linux.com>,
 linux-m68k <linux-m68k@lists.linux-m68k.org>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Khalid Aziz <khalid@gonehiking.org>,
 Miquel van Smoorenburg <mikevs@xs4all.net>,
 Parisc List <linux-parisc@vger.kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Matt Wang <wwentao@vmware.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Mark Salyzyn <salyzyn@android.com>,
 Linux IOMMU <iommu@lists.linux-foundation.org>,
 alpha <linux-alpha@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "Maciej W . Rozycki" <macro@orcam.me.uk>
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

SGkgQXJuZCwKCk9uIDI5LzA2LzIyIDA5OjUwLCBBcm5kIEJlcmdtYW5uIHdyb3RlOgo+IE9uIFR1
ZSwgSnVuIDI4LCAyMDIyIGF0IDExOjAzIFBNIE1pY2hhZWwgU2NobWl0eiA8c2NobWl0em1pY0Bn
bWFpbC5jb20+IHdyb3RlOgo+PiBPbiAyOC8wNi8yMiAxOTowMywgR2VlcnQgVXl0dGVyaG9ldmVu
IHdyb3RlOgo+Pj4+IFRoZSBkcml2ZXIgYWxsb2NhdGVzIGJvdW5jZSBidWZmZXJzIHVzaW5nIGtt
YWxsb2MgaWYgaXQgaGl0cyBhbgo+Pj4+IHVuYWxpZ25lZCBkYXRhIGJ1ZmZlciAtIGNhbiBzdWNo
IGJ1ZmZlcnMgc3RpbGwgZXZlbiBoYXBwZW4gdGhlc2UgZGF5cz8KPj4+IE5vIGlkZWEuCj4+IEht
bW0gLSBJIHRoaW5rIEknbGwgc3RpY2sgYSBXQVJOX09OQ0UoKSBpbiB0aGVyZSBzbyB3ZSBrbm93
IHdoZXRoZXIgdGhpcwo+PiBjb2RlIHBhdGggaXMgc3RpbGwgYmVpbmcgdXNlZC4KPiBrbWFsbG9j
KCkgZ3VhcmFudGVlcyBhbGlnbm1lbnQgdG8gdGhlIG5leHQgcG93ZXItb2YtdHdvIHNpemUgb3IK
PiBLTUFMTE9DX01JTl9BTElHTiwgd2hpY2hldmVyIGlzIGJpZ2dlci4gT24gbTY4ayB0aGlzIG1l
YW5zIGl0Cj4gaXMgY2FjaGVsaW5lIGFsaWduZWQuCgpBbmQgYWxsIFNDU0kgYnVmZmVycyBhcmUg
YWxsb2NhdGVkIHVzaW5nIGttYWxsb2M/IE5vIHdheSBhdCBhbGwgZm9yIHVzZXIgCnNwYWNlIHRv
IHBhc3MgdW5hbGlnbmVkIGRhdGE/CgooU0NTSSBpcyBhIHdlaXJkIGJlYXN0IC0gSSBoYXZlIHVz
ZWQgYSBTQ1NJIERBVCB0YXBlIGRyaXZlciBtYW55IG1hbnkgCnllYXJzIGFnbywgd2hpY2ggYnJv
a2UgYWxsIHNvcnRzIG9mIGFzc3VtcHRpb25zIGFib3V0IHRyYW5zZmVyIGJsb2NrIApzaXplcyAu
Li4gYnV0IHRoYXQgbWlnaHQgYWN0dWFsbHkgaGF2ZSBiZWVuIGluIHRoZSB2MC45OSBkYXlzLCBt
YW55IApyZXdyaXRlcyBvZiBTQ1NJIG1pZGxldmVsIGFnbykuCgpKdXN0IGJlaW5nIGNhdXRpb3Vz
LCBhcyBnZXR0aW5nIGFueSBvZiB0aGlzIHRlc3RlZCB3aWxsIGJlIGEgc3RyZXRjaC4KCkNoZWVy
cywKCiDCoMKgwqAgTWljaGFlbAoKPgo+ICAgICAgICBBcm5kCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0
cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcv
bWFpbG1hbi9saXN0aW5mby9pb21tdQ==
