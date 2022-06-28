Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EC00C43334
	for <iommu@archiver.kernel.org>; Tue, 28 Jun 2022 21:03:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CE7B1415A4;
	Tue, 28 Jun 2022 21:03:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CE7B1415A4
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=Plf/V32R
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id v0Rzf-fIia-l; Tue, 28 Jun 2022 21:03:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 235634148F;
	Tue, 28 Jun 2022 21:03:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 235634148F
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0001CC0039;
	Tue, 28 Jun 2022 21:03:50 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6E08BC002D
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jun 2022 21:03:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 44F97404F8
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jun 2022 21:03:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 44F97404F8
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20210112 header.b=Plf/V32R
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id edYQITjylX6B for <iommu@lists.linux-foundation.org>;
 Tue, 28 Jun 2022 21:03:48 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8F9FF404C1
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com
 [IPv6:2607:f8b0:4864:20::102d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8F9FF404C1
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jun 2022 21:03:48 +0000 (UTC)
Received: by mail-pj1-x102d.google.com with SMTP id
 i8-20020a17090aee8800b001ecc929d14dso209839pjz.0
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jun 2022 14:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=LLK2uhNNvPadjp2Oh/1lKQPTCLeKdmpKaTeJ3RDCHv0=;
 b=Plf/V32RTHjAIcY0bkPGhJbIRr6v2P2QgRVB8+7eP0P4RsyHw26WFtNVMjh4450VSL
 X8EowJeUAPv65bojUQi/l4q/mcLgIz1TUZop7B8mMf4UYeSMN97O5PhtCWd4P5KjohDY
 ALLie3yLHIm0bsPU/TnBkkd6JuMbBayFBbZiLBvLd2yar7+HLEz7eMmp19DAOWF3IuTH
 PHvtCurN4N9bl0vEQmQzWlMPAd2VaDMz3hbsjPHd4Xm7SbhJbAT/RBX6xYjOUAqBtWrm
 FLKt/ZIKzNjI8UX/5SZnYKO15W+v0GW/s3+FFXv5IZLkJGau9LvwFj0fBmt76ie2MA/E
 v/wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=LLK2uhNNvPadjp2Oh/1lKQPTCLeKdmpKaTeJ3RDCHv0=;
 b=ts2uCvGI8o+1JnRW0crKOdhrZLmhqv8AOZlqz8rr773CnlL+4v3TTKwnZzczuHX8zw
 nDNaj8KcXMS4gfp0DyTh+NSlI5CzXFXlx4VDtexb26dcQjuKVLjq/Zjw9IHF7qPcc4fR
 JT1Rkkyjg65eFa2s0DCPMLqj0Cq/RR+4BOt2EuEFSI9nyEP8FILdaIsKm9rvos8LCh1j
 V73ClUgDpIc6w/poR7IQVUBwiiibvWVBHDgVEsXqA7xkYEzOO3nDHlogVrzcQwu0nN9z
 TO1lOZcqF61iDeX7f5aFqVL6TXR5Jhx5paxwzJ7r6uH/od0fNqTWOHeEISv+eQby6DrO
 QnMQ==
X-Gm-Message-State: AJIora8GWXI3SolkUG9Bvj7nQXdTZ+bz3IZtII4JD4tw05FgiiG3P8Nn
 DD7XD8bleY8Dpi3haUS91Ko=
X-Google-Smtp-Source: AGRyM1s3Nd/my/4+QoWL+yZMzu+YZKCug56iAjfd8RAtHTbgADBf9oHlpjvJ/8KE0n/2rDkR0+nsiw==
X-Received: by 2002:a17:90a:1485:b0:1ec:788e:a053 with SMTP id
 k5-20020a17090a148500b001ec788ea053mr1707919pja.16.1656450227992; 
 Tue, 28 Jun 2022 14:03:47 -0700 (PDT)
Received: from ?IPV6:2001:df0:0:200c:75aa:d6ca:4354:6033?
 ([2001:df0:0:200c:75aa:d6ca:4354:6033])
 by smtp.gmail.com with ESMTPSA id
 a14-20020aa795ae000000b005259d99ccffsm6254097pfk.8.2022.06.28.14.03.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jun 2022 14:03:47 -0700 (PDT)
Message-ID: <c30bc9b6-6ccd-8856-dc6b-4e16450dad6f@gmail.com>
Date: Wed, 29 Jun 2022 09:03:37 +1200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 3/3] arch/*/: remove CONFIG_VIRT_TO_BUS
Content-Language: en-US
To: Geert Uytterhoeven <geert@linux-m68k.org>
References: <20220617125750.728590-1-arnd@kernel.org>
 <20220617125750.728590-4-arnd@kernel.org>
 <6ba86afe-bf9f-1aca-7af1-d0d348d75ffc@gmail.com>
 <CAMuHMdVewn0OYA9oJfStk0-+vCKAUou+4Mvd5H2kmrSks1p5jg@mail.gmail.com>
 <b4e5a1c9-e375-63fb-ec7c-abb7384a6d59@gmail.com>
 <9289fd82-285c-035f-5355-4d70ce4f87b0@gmail.com>
 <CAMuHMdXUihTPD9A9hs__Xr2ErfOqkZ5KgCHqm+9HvRf39uS5kA@mail.gmail.com>
From: Michael Schmitz <schmitzmic@gmail.com>
In-Reply-To: <CAMuHMdXUihTPD9A9hs__Xr2ErfOqkZ5KgCHqm+9HvRf39uS5kA@mail.gmail.com>
Cc: Linux-Arch <linux-arch@vger.kernel.org>, scsi <linux-scsi@vger.kernel.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Christoph Hellwig <hch@infradead.org>,
 Matt Wang <wwentao@vmware.com>, Jakub Kicinski <kuba@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, Miquel van Smoorenburg <mikevs@xs4all.net>,
 Denis Efremov <efremov@linux.com>,
 linux-m68k <linux-m68k@lists.linux-m68k.org>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Khalid Aziz <khalid@gonehiking.org>, Arnd Bergmann <arnd@kernel.org>,
 Parisc List <linux-parisc@vger.kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
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

SGkgR2VlcnQsCgpPbiAyOC8wNi8yMiAxOTowMywgR2VlcnQgVXl0dGVyaG9ldmVuIHdyb3RlOgo+
Cj4+IExlYXZpbmcgdGhlIGJvdW5jZSBidWZmZXIgaGFuZGxpbmcgaW4gcGxhY2UsIGFuZCB0YWtp
bmcgYSBmZXcgb3RoZXIKPj4gbGliZXJ0aWVzIC0gdGhpcyBpcyB3aGF0IGNvbnZlcnRpbmcgdGhl
IGVhc2llc3QgY2FzZSAoYTMwMDAgU0NTSSkgbWlnaHQKPj4gbG9vayBsaWtlLiBBbnkgb2J2aW91
cyBtaXN0YWtlcz8gVGhlIG12bWUxNDcgZHJpdmVyIHdvdWxkIGJlIHZlcnkKPj4gc2ltaWxhciB0
byBoYW5kbGUgKGFmdGVyIGNvbnZlcnNpb24gdG8gYSBwbGF0Zm9ybSBkZXZpY2UpLgo+IFRoYW5r
cywgbG9va3MgcmVhc29uYWJsZS4KVGhhbmtzLCBJJ2xsIHRha2UgY2FyZSBvZiBBcm5kJ3MgY29t
bWVudHMgYW5kIHBvc3QgYSBjb3JyZWN0ZWQgdmVyc2lvbiAKbGF0ZXIuCj4+IFRoZSBkcml2ZXIg
YWxsb2NhdGVzIGJvdW5jZSBidWZmZXJzIHVzaW5nIGttYWxsb2MgaWYgaXQgaGl0cyBhbgo+PiB1
bmFsaWduZWQgZGF0YSBidWZmZXIgLSBjYW4gc3VjaCBidWZmZXJzIHN0aWxsIGV2ZW4gaGFwcGVu
IHRoZXNlIGRheXM/Cj4gTm8gaWRlYS4KSG1tbSAtIEkgdGhpbmsgSSdsbCBzdGljayBhIFdBUk5f
T05DRSgpIGluIHRoZXJlIHNvIHdlIGtub3cgd2hldGhlciB0aGlzIApjb2RlIHBhdGggaXMgc3Rp
bGwgYmVpbmcgdXNlZC4KPgo+PiBJZiBJIHVuZGVyc3RhbmQgZG1hX21hcF9zaW5nbGUoKSBjb3Jy
ZWN0bHksIHRoZSByZXN1bHRpbmcgZG1hIGhhbmRsZQo+PiB3b3VsZCBiZSBlcXVhbGx5IG1pc2Fs
aWduZWQ/Cj4+Cj4+IFRvIGFsbG9jYXRlIGEgYm91bmNlIGJ1ZmZlciwgd291bGQgaXQgYmUgT0sg
dG8gdXNlIGRtYV9hbGxvY19jb2hlcmVudCgpCj4+IGV2ZW4gdGhvdWdoIEFGQUlVIG1lbW9yeSB1
c2VkIGZvciBETUEgYnVmZmVycyBnZW5lcmFsbHkgaXNuJ3QgY29uc2lzdGVudAo+PiBvbiBtNjhr
Pwo+Pgo+PiBUaGlua2luZyBhaGVhZCB0byB0aGUgb3RoZXIgdHdvIEFtaWdhIGRyaXZlcnMgLSBJ
IHdvbmRlciB3aGV0aGVyCj4+IGFsbG9jYXRpbmcgYSBzdGF0aWMgYm91bmNlIGJ1ZmZlciBvciBh
IERNQSBwb29sIGF0IGRyaXZlciBpbml0IGlzIGxpa2VseQo+PiB0byBzdWNjZWVkIGlmIHRoZSBr
ZXJuZWwgcnVucyBmcm9tIHRoZSBsb3cgMTYgTUIgUkFNIGNodW5rPyBJdCBjZXJ0YWlubHkKPj4g
d29uJ3Qgc3VjY2VlZCBpZiB0aGUga2VybmVsIHJ1bnMgZnJvbSBhIGhpZ2hlciBtZW1vcnkgYWRk
cmVzcywgc28gdGhlCj4+IHByZXNlbnQgYm91bmNlIGJ1ZmZlciBsb2dpYyBhcm91bmQgYW1pZ2Ff
Y2hpcF9hbGxvYygpIG1pZ2h0IHN0aWxsIG5lZWQKPj4gdG8gYmUgdXNlZCBoZXJlLgo+Pgo+PiBM
ZWF2ZXMgdGhlIHF1ZXN0aW9uIHdoZXRoZXIgY29udmVydGluZyB0aGUgZ3ZwMTEgYW5kIGEyMDkx
IGRyaXZlcnMgaXMKPj4gYWN0dWFsbHkgd29ydGggaXQsIGlmIGJvdW5jZSBidWZmZXJzIHN0aWxs
IGhhdmUgdG8gYmUgaGFuZGxlZCBleHBsaWNpdGx5Lgo+IEEyMDkxIHNob3VsZCBiZSBzdHJhaWdo
dC1mb3J3YXJkLCBhcyBBMzAwMCBpcyBiYXNpY2FsbHkgQTIwOTEgb24gdGhlCj4gbW90aGVyYm9h
cmQgKGNvbXBhcmluZyB0aGUgdHdvIGRyaXZlcnMsIGxvb2tzIGxpa2Ugc29tZW9uZSdzIGJlZW4K
PiBzcHJpbmtsaW5nIG1iKClzIG92ZXIgdGhlIEEzMDAwIGRyaXZlcikuCgpZZXAsIGFuZCBhdCBs
ZWFzdCB0aGUgb25lcyBpbiB0aGUgZG1hX3NldHVwKCkgZnVuY3Rpb24gYXJlIHRoZXJlIGZvciBu
byAKcmVhc29uICh0aGUgY29tcGlsZXIgd29uJ3QgcmVvcmRlciBzdG9yZXMgYXJvdW5kIHRoZSBj
YWNoZSBmbHVzaCBjYWxscywgCkkgaG9wZT8pLgoKSnVzdCBsZWF2ZXMgdGhlIDI0IGJpdCBETUEg
bWFzayB0aGVyZSAoYW5kIGxpa2VseSBuZWVkIGZvciBib3VuY2UgYnVmZmVycykuCgo+IEkgZG9u
J3QgaGF2ZSBhbnkgb2YgdGhlc2UgU0NTSSBob3N0IGFkYXB0ZXJzIChub3QgY291bnRpbmcgdGhl
IEE1OTAKPiAofkEyMDkxKSBleHBhbnNpb24gb2YgdGhlIG9sZCBBNTAwLCB3aGljaCBpcyBub3Qg
TGludXgtY2FwYWJsZSwgYW5kCj4gICBoYXNuJ3QgYmVlbiBwb3dlcmVkIG9uIGZvciAyMCB5ZWFy
cykuCgpJIHdvbmRlciB3aGV0aGVyIGt1bGxlcnZvIGhhcyBzdXJ2aXZlZCAtIHRoYXQgb25lIHdh
cyBhbiBBMzAwMC4gU2hvdWxkIApoYXZlIGdvbmUgdG8gQWRyaWFuIGEgZmV3IHllYXJzIGFnby4u
LgoKQ2hlZXJzLAoKIMKgwqDCoCBNaWNoYWVsCgoKPgo+IEdye29ldGplLGVldGluZ31zLAo+Cj4g
ICAgICAgICAgICAgICAgICAgICAgICAgIEdlZXJ0Cj4KPiAtLQo+IEdlZXJ0IFV5dHRlcmhvZXZl
biAtLSBUaGVyZSdzIGxvdHMgb2YgTGludXggYmV5b25kIGlhMzIgLS0gZ2VlcnRAbGludXgtbTY4
ay5vcmcKPgo+IEluIHBlcnNvbmFsIGNvbnZlcnNhdGlvbnMgd2l0aCB0ZWNobmljYWwgcGVvcGxl
LCBJIGNhbGwgbXlzZWxmIGEgaGFja2VyLiBCdXQKPiB3aGVuIEknbSB0YWxraW5nIHRvIGpvdXJu
YWxpc3RzIEkganVzdCBzYXkgInByb2dyYW1tZXIiIG9yIHNvbWV0aGluZyBsaWtlIHRoYXQuCj4g
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgLS0gTGludXMgVG9ydmFsZHMKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBs
aXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhm
b3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
