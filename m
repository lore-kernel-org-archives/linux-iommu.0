Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 272BDCCA480
	for <iommu@archiver.kernel.org>; Wed, 29 Jun 2022 00:01:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9891E82726;
	Wed, 29 Jun 2022 00:01:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9891E82726
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=D7i2Nged
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3tCF-PYn8pdc; Wed, 29 Jun 2022 00:01:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 442E78271A;
	Wed, 29 Jun 2022 00:01:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 442E78271A
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0D052C0032;
	Wed, 29 Jun 2022 00:01:43 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 146FCC002D
 for <iommu@lists.linux-foundation.org>; Wed, 29 Jun 2022 00:01:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DA71F400F3
 for <iommu@lists.linux-foundation.org>; Wed, 29 Jun 2022 00:01:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DA71F400F3
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20210112 header.b=D7i2Nged
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id T2-H5rgrAAuq for <iommu@lists.linux-foundation.org>;
 Wed, 29 Jun 2022 00:01:41 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 010EC400E7
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com
 [IPv6:2607:f8b0:4864:20::435])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 010EC400E7
 for <iommu@lists.linux-foundation.org>; Wed, 29 Jun 2022 00:01:40 +0000 (UTC)
Received: by mail-pf1-x435.google.com with SMTP id d17so13425085pfq.9
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jun 2022 17:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=0kpjfuIly1nOW0q2ELB2CmN7oIQ7HX+3B2PaKKHsB78=;
 b=D7i2NgedY/bHyI8emNN+y0jr/G9IOYRWkIjlIhVn6DbWgwRG2UARyfZk3UwO7T2V+D
 ESqmy18MQo7RMsisYmEMOTQj203NqQOZVs7qiFGDUYY81Hru7Iv0ADFCQgagZlaKMdVq
 xung15+Nlj1soULvCk9mS+bfRYyJ9ltpn9UcH1mz1cQDWfJ2ax2IcuBr2SQ3tsjHpoK1
 NeL3oeSuqVVYbcSBohKZ73kauU8T3VpyxipPF6h/oJ8e2qxtdKJwYj9HlUbwfye7QPMt
 PuFn7aX0KOb+qDfsVshvX0sC/38kqLR1JFdKMTuOuvGx8cb2fuTFMwQneoiKRpnAUU2m
 4Xkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=0kpjfuIly1nOW0q2ELB2CmN7oIQ7HX+3B2PaKKHsB78=;
 b=QwPlwAd9a1lsm+BzqBDQ+KLYPAfP6HkjvG9MFdcaiu+RtvT1BH7CGFnr/PcSUQdK6O
 bNdi/wNtvdoQbn2h6w93LH92fakrDQw8+sHnXd1P78Ms+wvlDobuWamUhGAtvuYvwasg
 WBi1oLPLFZpYuIlI2fs2S2V9bwPo5IBV+d4mvYlY0ovhJjhpZ61T5CBVufqV9GNgEFzz
 DGuXXi5gIgp1+HyNJBSexIHJchajtt5/7yKkynjJbLicbUhC+4vElg3e2Y3RPCY/gArp
 zld4yB/ElTwoIjqKiSFRamBGFb3sVe9YZ2ifkgxWsx0KZPpCFNAkDXTXTfVLQOrISa0D
 Id5Q==
X-Gm-Message-State: AJIora+ABNChqFzEdxS+Rmh/8vYmYSNcV8uQmvd4dwSOhUptSOcDDawm
 BdZO20wwae5SBlUCKf4DXwU=
X-Google-Smtp-Source: AGRyM1uB9qD4Z15I0Lke4zy2AkjVbLhbeqqf5QXYDPBQAVzl/v0z9XhcHbOncWmuxVZyAGIQBi5g6Q==
X-Received: by 2002:a63:2b16:0:b0:3fa:faf9:e6d7 with SMTP id
 r22-20020a632b16000000b003fafaf9e6d7mr446010pgr.325.1656460900460; 
 Tue, 28 Jun 2022 17:01:40 -0700 (PDT)
Received: from ?IPV6:2001:df0:0:200c:75aa:d6ca:4354:6033?
 ([2001:df0:0:200c:75aa:d6ca:4354:6033])
 by smtp.gmail.com with ESMTPSA id
 cd21-20020a056a00421500b0051b32c2a5a7sm9863096pfb.138.2022.06.28.17.01.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jun 2022 17:01:39 -0700 (PDT)
Message-ID: <859c2adc-d3cb-64e8-faba-06e1ac5eddaf@gmail.com>
Date: Wed, 29 Jun 2022 12:01:24 +1200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 3/3] arch/*/: remove CONFIG_VIRT_TO_BUS
Content-Language: en-US
To: Bart Van Assche <bvanassche@acm.org>, Arnd Bergmann <arnd@kernel.org>
References: <20220617125750.728590-1-arnd@kernel.org>
 <20220617125750.728590-4-arnd@kernel.org>
 <6ba86afe-bf9f-1aca-7af1-d0d348d75ffc@gmail.com>
 <CAMuHMdVewn0OYA9oJfStk0-+vCKAUou+4Mvd5H2kmrSks1p5jg@mail.gmail.com>
 <b4e5a1c9-e375-63fb-ec7c-abb7384a6d59@gmail.com>
 <9289fd82-285c-035f-5355-4d70ce4f87b0@gmail.com>
 <CAMuHMdXUihTPD9A9hs__Xr2ErfOqkZ5KgCHqm+9HvRf39uS5kA@mail.gmail.com>
 <c30bc9b6-6ccd-8856-dc6b-4e16450dad6f@gmail.com>
 <CAK8P3a1rxEVwVF5U-PO6pQkfURU5Tro1Qp8SPUfHEV9jjWOmCQ@mail.gmail.com>
 <9f812d3d-0fcd-46e6-6d7e-6d4bf66f24ab@gmail.com>
 <fc47e8da-81d3-e563-0a17-4eb23db015cc@acm.org>
From: Michael Schmitz <schmitzmic@gmail.com>
In-Reply-To: <fc47e8da-81d3-e563-0a17-4eb23db015cc@acm.org>
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

SGkgQmFydCwKCk9uIDI5LzA2LzIyIDExOjUwLCBCYXJ0IFZhbiBBc3NjaGUgd3JvdGU6Cj4gT24g
Ni8yOC8yMiAxNjowOSwgTWljaGFlbCBTY2htaXR6IHdyb3RlOgo+PiBPbiAyOS8wNi8yMiAwOTo1
MCwgQXJuZCBCZXJnbWFubiB3cm90ZToKPj4+IE9uIFR1ZSwgSnVuIDI4LCAyMDIyIGF0IDExOjAz
IFBNIE1pY2hhZWwgU2NobWl0eiAKPj4+IDxzY2htaXR6bWljQGdtYWlsLmNvbT4gd3JvdGU6Cj4+
Pj4gT24gMjgvMDYvMjIgMTk6MDMsIEdlZXJ0IFV5dHRlcmhvZXZlbiB3cm90ZToKPj4+Pj4+IFRo
ZSBkcml2ZXIgYWxsb2NhdGVzIGJvdW5jZSBidWZmZXJzIHVzaW5nIGttYWxsb2MgaWYgaXQgaGl0
cyBhbgo+Pj4+Pj4gdW5hbGlnbmVkIGRhdGEgYnVmZmVyIC0gY2FuIHN1Y2ggYnVmZmVycyBzdGls
bCBldmVuIGhhcHBlbiB0aGVzZSAKPj4+Pj4+IGRheXM/Cj4+Pj4+IE5vIGlkZWEuCj4+Pj4gSG1t
bSAtIEkgdGhpbmsgSSdsbCBzdGljayBhIFdBUk5fT05DRSgpIGluIHRoZXJlIHNvIHdlIGtub3cg
d2hldGhlciAKPj4+PiB0aGlzCj4+Pj4gY29kZSBwYXRoIGlzIHN0aWxsIGJlaW5nIHVzZWQuCj4+
PiBrbWFsbG9jKCkgZ3VhcmFudGVlcyBhbGlnbm1lbnQgdG8gdGhlIG5leHQgcG93ZXItb2YtdHdv
IHNpemUgb3IKPj4+IEtNQUxMT0NfTUlOX0FMSUdOLCB3aGljaGV2ZXIgaXMgYmlnZ2VyLiBPbiBt
NjhrIHRoaXMgbWVhbnMgaXQKPj4+IGlzIGNhY2hlbGluZSBhbGlnbmVkLgo+Pgo+PiBBbmQgYWxs
IFNDU0kgYnVmZmVycyBhcmUgYWxsb2NhdGVkIHVzaW5nIGttYWxsb2M/IE5vIHdheSBhdCBhbGwg
Zm9yIAo+PiB1c2VyIHNwYWNlIHRvIHBhc3MgdW5hbGlnbmVkIGRhdGE/Cj4+Cj4+IChTQ1NJIGlz
IGEgd2VpcmQgYmVhc3QgLSBJIGhhdmUgdXNlZCBhIFNDU0kgREFUIHRhcGUgZHJpdmVyIG1hbnkg
bWFueSAKPj4geWVhcnMgYWdvLCB3aGljaCBicm9rZSBhbGwgc29ydHMgb2YgYXNzdW1wdGlvbnMg
YWJvdXQgdHJhbnNmZXIgYmxvY2sgCj4+IHNpemVzIC4uLiBidXQgdGhhdCBtaWdodCBhY3R1YWxs
eSBoYXZlIGJlZW4gaW4gdGhlIHYwLjk5IGRheXMsIG1hbnkgCj4+IHJld3JpdGVzIG9mIFNDU0kg
bWlkbGV2ZWwgYWdvKS4KPj4KPj4gSnVzdCBiZWluZyBjYXV0aW91cywgYXMgZ2V0dGluZyBhbnkg
b2YgdGhpcyB0ZXN0ZWQgd2lsbCBiZSBhIHN0cmV0Y2guCj4KPiBBbiBleGFtcGxlIG9mIGEgdXNl
ciBzcGFjZSBhcHBsaWNhdGlvbiB0aGF0IHBhc3NlcyBhbiBTRyBJL08gZGF0YSAKPiBidWZmZXIg
dG8gdGhlIGtlcm5lbCB0aGF0IGlzIGFsaWduZWQgdG8gYSBmb3VyIGJ5dGUgYm91bmRhcnkgYnV0
IG5vdCAKPiB0byBhbiBlaWdodCBieXRlIGJvdW5kYXJ5IGlmIHRoZSAtcyAoc2NhdHRlcmVkKSBj
b21tYW5kIGxpbmUgb3B0aW9uIGlzIAo+IHVzZWQ6IAo+IGh0dHBzOi8vZ2l0aHViLmNvbS9vc2Fu
ZG92L2Jsa3Rlc3RzL2Jsb2IvbWFzdGVyL3NyYy9kaXNjb250aWd1b3VzLWlvLmNwcAoKVGhhbmtz
IC0gZm91ciBieXRlIGFsaWdubWVudCBhY3R1YWxseSB3b3VsZG4ndCBiZSBhbiBpc3N1ZSBmb3Ig
bWUuIEl0J3MgCnR3byBieXRlIG9yIHNtYWxsZXIgdGhhdCB3b3VsZCB0cmlwIHVwIHRoZSBTQ1NJ
IERNQS4KCldoaWxlIEknbSBzdXJlIHN1Y2ggYW4gZXZlbiBtb3JlIHBhdGhvbG9naWNhbCB0ZXN0
IGNhc2UgY291bGQgYmUgCndyaXR0ZW4sIEkgd2FzIHJhdGhlciB3b3JyaWVkIGFib3V0IHN0LmMg
YW5kIHNyLmMgaW5wdXQgLi4uCgpDaGVlcnMsCgogwqDCoMKgIE1pY2hhZWwKCj4KPiBCYXJ0Lgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWls
aW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5s
aW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
