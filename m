Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D42DDC43334
	for <iommu@archiver.kernel.org>; Tue, 28 Jun 2022 23:44:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 691D74048A;
	Tue, 28 Jun 2022 23:44:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 691D74048A
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=ZFKa0zjQ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id K-8AWj6tokfg; Tue, 28 Jun 2022 23:44:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 19BAA400F3;
	Tue, 28 Jun 2022 23:44:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 19BAA400F3
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E18A0C0032;
	Tue, 28 Jun 2022 23:44:14 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 58D2DC002D
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jun 2022 23:44:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 325B360AC0
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jun 2022 23:44:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 325B360AC0
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20210112 header.b=ZFKa0zjQ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kWmdREjW3UiP for <iommu@lists.linux-foundation.org>;
 Tue, 28 Jun 2022 23:44:11 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 69282600CB
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com
 [IPv6:2607:f8b0:4864:20::1035])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 69282600CB
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jun 2022 23:44:11 +0000 (UTC)
Received: by mail-pj1-x1035.google.com with SMTP id
 c6-20020a17090abf0600b001eee794a478so6857622pjs.1
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jun 2022 16:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=XXACMyBth2YuRsa3JBFFU2eR9hpIP7dUr/uMuQH5Oj8=;
 b=ZFKa0zjQT6sOAjCHXXkRsROHleG5wCDjvaAfz3h3OP6cgT9grR5oBZm0ZBvAWAay0r
 DR4PyHuT1QNC9LfX+RGxE2XCIQFVlFTEhqlmuIbt4B77yTiI6mL+mqc2kzFUWGgJL3DE
 xqXaW3fwHeQ1Tq9+eDu9x8IB61VGIWMo0s3NI888MArONazUjDsSuXP19BeJL7dtYHwQ
 Zwl3asU6pETG2ISfXFTMTcM6zTMGwEr28kXEV9D1VpMLrcpN6K4XgUsrTwn8x7Uqv2vl
 6hSbXMXNOxewCZj52M37+xep3zYfiDtYF+BjqZMNmFdSwg4GmcfShZeR26gbmY2em+2z
 ik6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=XXACMyBth2YuRsa3JBFFU2eR9hpIP7dUr/uMuQH5Oj8=;
 b=ZhmKQgRjCmgooTfHy1RUlNvBFdGQG69DctG3oHiZOYJfOKxSVFIgtcIxYYC1QmXc8K
 P0qfpObjuo+NwoDMaLnUINb/0V0NM3wRhzxpIVAKkqQxTdMKwc7hoZY1/2A8Bx8QZXc3
 ZOfulzURctpyUyJ0bHP1i08jUu+z6z+3sXaJsC+XUQTZyiB7dVH9lTKQvJ66rCMqFGZY
 Buz2yk7Mqtvc0tQZtsMEvZQxILvAxFAoVJYtLGYBsdrHrfxkTm3rxU1x1KgVQOP+JDJm
 zmjXT+IfnkFomMngI7KgZzosrFki4QkINIjSUhMGvl1bM9LJQ2BWouqmzzJq4P/UYCtd
 27/w==
X-Gm-Message-State: AJIora/L2XGe7M6kMKjrXfvOU5pS+cu/wz/rqoW8d3PrdaQ+j3EnJ71w
 N+ZQ5G95nD4bwGfQxTnAY6o=
X-Google-Smtp-Source: AGRyM1sRtrsuQuzCfjcf7lUp2PQTiLP05lqRjX8Jhrrxh7WI2thOAB1H+VjvYu/axVXSqK04FGuj3Q==
X-Received: by 2002:a17:902:f606:b0:168:ecca:44e with SMTP id
 n6-20020a170902f60600b00168ecca044emr6130806plg.144.1656459849291; 
 Tue, 28 Jun 2022 16:44:09 -0700 (PDT)
Received: from ?IPV6:2001:df0:0:200c:75aa:d6ca:4354:6033?
 ([2001:df0:0:200c:75aa:d6ca:4354:6033])
 by smtp.gmail.com with ESMTPSA id
 t11-20020a17090a510b00b001e2fade86c1sm489400pjh.2.2022.06.28.16.43.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jun 2022 16:44:08 -0700 (PDT)
Message-ID: <9334bac7-c9d3-b17b-f6d6-12c4bec3d138@gmail.com>
Date: Wed, 29 Jun 2022 11:43:55 +1200
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
 <CAK8P3a1ivqYB38c_QTjG8e85ZBnCB6HEa-6LR1HDc8shG1Pwmw@mail.gmail.com>
 <b1edec96-ccb2-49d6-323b-1abc0dc37a50@gmail.com>
 <CAK8P3a2jvFQBvKfdR5ivDBECN5tEej6Ja4=7Loze646hrQ5wzg@mail.gmail.com>
From: Michael Schmitz <schmitzmic@gmail.com>
In-Reply-To: <CAK8P3a2jvFQBvKfdR5ivDBECN5tEej6Ja4=7Loze646hrQ5wzg@mail.gmail.com>
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

SGkgQXJuZCwKCk9uIDI5LzA2LzIyIDA5OjU1LCBBcm5kIEJlcmdtYW5uIHdyb3RlOgo+IE9uIFR1
ZSwgSnVuIDI4LCAyMDIyIGF0IDExOjM4IFBNIE1pY2hhZWwgU2NobWl0eiA8c2NobWl0em1pY0Bn
bWFpbC5jb20+IHdyb3RlOgo+PiBPbiAyOC8wNi8yMiAxOTowOCwgQXJuZCBCZXJnbWFubiB3cm90
ZToKPj4+IEkgc2VlIHR3byBvdGhlciBwcm9ibGVtcyB3aXRoIHlvdXIgcGF0Y2ggdGhvdWdoOgo+
Pj4KPj4+IGEpIHlvdSBzdGlsbCBkdXBsaWNhdGUgdGhlIGNhY2hlIGhhbmRsaW5nOiB0aGUgY2Fj
aGVfY2xlYXIoKS9jYWNoZV9wdXNoKCkKPj4+IGlzIHN1cHBvc2VkIHRvIGFscmVhZHkgYmUgZG9u
ZSBieSBkbWFfbWFwX3NpbmdsZSgpIHdoZW4gdGhlIGRldmljZQo+Pj4gaXMgbm90IGNhY2hlLWNv
aGVyZW50Lgo+PiBUaGF0J3Mgb25lIG9mIHRoZSAnbGliZXJ0aWVzJyBJIGFsbHVkZWQgdG8uIFRo
ZSByZWFzb24gSSBsZWZ0IHRoZXNlIGluCj4+IGlzIHRoYXQgSSdtIG5vbmUgdG9vIGNlcnRhaW4g
d2hhdCBkZXZpY2UgZmVhdHVyZSB0aGUgRE1BIEFQSSB1c2VzIHRvCj4+IGRlY2lkZSBhIGRldmlj
ZSBpc24ndCBjYWNoZS1jb2hlcmVudC4gSWYgaXQncyBkZXYtPmNvaGVyZW50X2RtYV9tYXNrLAo+
PiB0aGUgd2F5IEkgc2V0IHVwIHRoZSBkZXZpY2UgaW4gdGhlIGEzMDAwIGRyaXZlciBzaG91bGQg
bGVhdmUgdGhlCj4+IGNvaGVyZW50IG1hc2sgdW5jaGFuZ2VkLiBGb3IgdGhlIFpvcnJvIGRyaXZl
cnMsIGRldmljZXMgYXJlIHNldCB1cCB0bwo+PiB1c2UgdGhlIHNhbWUgc3RvcmFnZSB0byBzdG9y
ZSBub3JtYWwgYW5kIGNvaGVyZW50IG1hc2tzIC0gc29tZXRoaW5nIHdlCj4+IG1vc3QgbGlrZWx5
IHdhbnQgdG8gY2hhbmdlLiBJIG5lZWQgdG8gdGhpbmsgYWJvdXQgdGhlIHJhbWlmaWNhdGlvbnMg
b2YKPj4gdGhhdC4KPj4KPj4gTm90ZSB0aGF0IHpvcnJvX2VzcC5jIHVzZXMgZG1hX3N5bmNfc2lu
Z2xlX2Zvcl9kZXZpY2UoKSBhbmQgdXNlcyBhIDMyCj4+IGJpdCBjb2hlcmVudCBETUEgbWFzayB3
aGljaCBkb2VzIHdvcmsgT0suIEkgbWlnaHQgIGFzayBBZHJpYW4gdG8gdGVzdCBhCj4+IGNoYW5n
ZSB0byBvbmx5IHNldCBkZXYtPmRtYV9tYXNrLCBhbmQgZHJvcCB0aGUKPj4gZG1hX3N5bmNfc2lu
Z2xlX2Zvcl9kZXZpY2UoKSBjYWxscyBpZiB0aGVyZSdzIGFueSBkb3VidCBvbiB0aGlzIGFzcGVj
dC4KPiBUaGUgImNvaGVyZW50X21hc2siIGlzIGluZGVwZW5kZW50IG9mIHRoZSBjYWNoZSBmbHVz
aGluZy4gT24gc29tZQo+IGFyY2hpdGVjdHVyZXMsIGEgZGV2aWNlIGNhbiBpbmRpY2F0ZSB3aGV0
aGVyIGl0IG5lZWRzIGNhY2hlIG1hbmFnZW1lbnQKPiBvciBub3QgdG8gZ3VhcmFudGVlIGNvaGVy
ZW5jeSwgYnV0IG9uIG02OGsgaXQgYXBwZWFycyB0aGF0IHdlIGFsd2F5cwo+IGFzc3VtZSBpdCBk
b2VzLCBzZWUgYXJjaC9tNjhrL2tlcm5lbC9kbWEuYwoKVGhhbmtzIC0gd2hhdCBJIHNlZSB0aGVy
ZSBpbmRpY2F0ZXMgdGhhdCBvbiB0aGUgcmVsZXZhbnQgcGxhdGZvcm1zLCAKcGFnZXMgbWFwcGVk
IGZvciBETUEgaGF2ZSB0aGVpciBwYWdlIHRhYmxlIGNhY2hlIGJpdHMgbW9kaWZpZWQgdG8gbWFr
ZSAKdGhlbSBub24tY2FjaGVhYmxlIChhbmQgSSBzdXBwb3NlIHVubWFwcGluZyByZXN0b3JlcyB0
aGUgZGVmYXVsdCBjYWNoZSAKYml0cykuIFRoYXQgbWVhbnMgSSBzaG91bGQgdXNlIGRtYV9zZXRf
bWFza19hbmRfY29oZXJlbnQoKSBoZXJlIHRvIHRha2UgCmFkdmFudGFnZSBvZiB0aGlzLCBhbmQg
bm8gbmVlZCB0byBtZXNzIGFyb3VuZCB3aXRoIApkbWFfc3luY19zaW5nbGVfZm9yX2RldmljZSgp
IGluIHRoZSBkcml2ZXJzJyBkbWFfc2V0dXAoKSBmdW5jdGlvbnMuCgo+Pj4gYikgVGhlIGJvdW5j
ZSBidWZmZXIgaXMgbmV2ZXIgbWFwcGVkIGhlcmUsIGluc3RlYWQgeW91IGhhdmUgdGhlCj4+PiB2
aXJ0X3RvX3BoeXMoKSBoZXJlLCB3aGljaCBpcyBub3QgdGhlIHNhbWUuIEkgdGhpbmsgeW91IG5l
ZWQgdG8gbWFwCj4+PiB0aGUgcG9pbnRlciB0aGF0IGFjdHVhbGx5IGdldHMgcGFzc2VkIGRvd24g
dG8gdGhlIGRldmljZSBhZnRlciBkZWNpZGluZwo+Pj4gdG8gdXNlIGEgYm91Y2UgYnVmZmVyIG9y
IG5vdC4KPj4gSSBoYWRuJ3QgcmVhbGl6ZWQgdGhhdCBJIGNhbiBtYXAgdGhlIGJvdW5jZSBidWZm
ZXIganVzdCBhcyBpdCdzIGRvbmUgZm9yCj4+IHRoZSBTQ3AgZGF0YSBidWZmZXIuIFNob3VsZCBo
YXZlIGJlZW4gb2J2aW91cywgYnV0IEknbSBzdGlsbCBsZWFybmluZwo+PiBhYm91dCB0aGUgRE1B
IEFQSS4KPj4KPj4gSSd2ZSB1cGRhdGVkIHRoZSBwYXRjaCBub3csIHdpbGwgcmUtc2VuZCBhcyBw
YXJ0IG9mIGEgY29tcGxldGUgc2VyaWVzCj4+IG9uY2UgZG9uZS4KPiBJIHN1cHBvc2UgeW91IGNh
biBqdXN0IGRyb3AgdGhlIGJvdW5jZSBidWZmZXIgaWYgdGhpcyBqdXN0IGNvbWVzCj4gZnJvbSBr
bWFsbG9jKCkuCgpUaGF0J3Mgb25seSB0cnVlIGZvciBhMzAwMCBhbmQgbXZtZTE0NyB0aG91Z2gu
CgpDaGVlcnMsCgogwqDCoMKgIE1pY2hhZWwKCj4KPiAgICAgICAgIEFybmQKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0Cmlv
bW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0
aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
