Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A12FFC433EF
	for <iommu@archiver.kernel.org>; Mon, 27 Jun 2022 21:12:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2442B83367;
	Mon, 27 Jun 2022 21:12:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2442B83367
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=UuI0dBFg
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SKsGxrkHATKg; Mon, 27 Jun 2022 21:12:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id D7208812D1;
	Mon, 27 Jun 2022 21:12:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D7208812D1
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A6889C0032;
	Mon, 27 Jun 2022 21:12:49 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 25804C002D
 for <iommu@lists.linux-foundation.org>; Mon, 27 Jun 2022 21:12:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id F35FF4094C
 for <iommu@lists.linux-foundation.org>; Mon, 27 Jun 2022 21:12:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org F35FF4094C
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20210112 header.b=UuI0dBFg
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UUqDsXU1CfJj for <iommu@lists.linux-foundation.org>;
 Mon, 27 Jun 2022 21:12:45 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org ECA5A4090E
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com
 [IPv6:2607:f8b0:4864:20::436])
 by smtp4.osuosl.org (Postfix) with ESMTPS id ECA5A4090E
 for <iommu@lists.linux-foundation.org>; Mon, 27 Jun 2022 21:12:44 +0000 (UTC)
Received: by mail-pf1-x436.google.com with SMTP id k9so916018pfg.5
 for <iommu@lists.linux-foundation.org>; Mon, 27 Jun 2022 14:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=Oa0Pw8WRwWFDk13UOTNU8r4Zj28fKsbMsHZJFWhjWbI=;
 b=UuI0dBFgPO4diTfHy/9LPAgfpBMcc774BorzXErxQR5b8AL+fMoTv1/RUwCaUUs5Wz
 wZ41GicoS5ofRiqUMfzJSjLcsa3Lrxfcq7QsnrIjny3YpmiuCR7VENM6FYB8xkBQFZxV
 /SvrqOuGEaAsBy3VjIJv2hWBCfpevI/Qjf6b6TAcBGWsZyeAXg1pQFprfgEMNNGBMg2o
 tYBcjNK8DJCwca5jr2WTeEiIenBQUcRBZixJW3S/qcpsfVeN23O6kRkqiR3GcuTz6FFB
 bxC1nlLwsXhKrEY7yB3vYz/3Q3omwcdSNomhexVJsFmeYGEIJmGjE/zTpXa346zjItic
 z0yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=Oa0Pw8WRwWFDk13UOTNU8r4Zj28fKsbMsHZJFWhjWbI=;
 b=rWaVME00B+tcP6tbEJqdKwBks1mMc4745djWfT4YMl8eA95CEsHicZVWeYPLStDP0v
 EeLbpubRQAL5uEl4NHPZjwFfjT4yh3hJvuXx06u44xRJFIVdVDvH7nQ1K2kILL9IFWzx
 R86pYp9VU6Ndnua+ADf5dev92B87l56dzLRHGHS3Pi+BIPYLGE9TbP4Xk6DqNrKO8RqR
 7dx1G7JFs2l+ACcRvkuMyqU3Pn6rhejcwJZ1hEb+F2tu6MLCERSvx93Bwve4uCwYrFn4
 DfXLgEsszVJ8BhaDSnKKERbayDprPdkD+gnxBhi148h2cvQwRi+Yil95t/0tPv7H5Qo7
 flKg==
X-Gm-Message-State: AJIora+/JTIaN7AVJUB6PBOGBKNwTcajKX2Li8rwEJFe/Dhx8dFH3/eX
 0nwI3aNhKK1JogMIDuT2gG4=
X-Google-Smtp-Source: AGRyM1uTPLx0FmbccmLLTUeOwpDtfjfY9meoJGws1yrh1VdVD8/6CKl+WA5aLqzWBJfSXBuzMThY8A==
X-Received: by 2002:a05:6a00:2311:b0:4e1:52bf:e466 with SMTP id
 h17-20020a056a00231100b004e152bfe466mr16676782pfh.77.1656364364243; 
 Mon, 27 Jun 2022 14:12:44 -0700 (PDT)
Received: from ?IPV6:2001:df0:0:200c:310d:de36:ea8e:ce87?
 ([2001:df0:0:200c:310d:de36:ea8e:ce87])
 by smtp.gmail.com with ESMTPSA id
 v11-20020a17090a6b0b00b001ece55b938asm9847689pjj.32.2022.06.27.14.12.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Jun 2022 14:12:43 -0700 (PDT)
Message-ID: <b4e5a1c9-e375-63fb-ec7c-abb7384a6d59@gmail.com>
Date: Tue, 28 Jun 2022 09:12:33 +1200
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
From: Michael Schmitz <schmitzmic@gmail.com>
In-Reply-To: <CAMuHMdVewn0OYA9oJfStk0-+vCKAUou+4Mvd5H2kmrSks1p5jg@mail.gmail.com>
Cc: Linux-Arch <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@kernel.org>,
 scsi <linux-scsi@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Miquel van Smoorenburg <mikevs@xs4all.net>,
 linux-m68k <linux-m68k@lists.linux-m68k.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 "Maciej W . Rozycki" <macro@orcam.me.uk>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Denis Efremov <efremov@linux.com>, Mark Salyzyn <salyzyn@android.com>,
 Christoph Hellwig <hch@infradead.org>,
 Linux IOMMU <iommu@lists.linux-foundation.org>, Matt Wang <wwentao@vmware.com>,
 Parisc List <linux-parisc@vger.kernel.org>,
 alpha <linux-alpha@vger.kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Khalid Aziz <khalid@gonehiking.org>, Robin Murphy <robin.murphy@arm.com>
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

SGkgR2VlcnQsCgpPbiAyNy8wNi8yMiAyMDoyNiwgR2VlcnQgVXl0dGVyaG9ldmVuIHdyb3RlOgo+
IEhpIE1pY2hhZWwsCj4KPiBPbiBTYXQsIEp1biAxOCwgMjAyMiBhdCAzOjA2IEFNIE1pY2hhZWwg
U2NobWl0eiA8c2NobWl0em1pY0BnbWFpbC5jb20+IHdyb3RlOgo+PiBBbSAxOC4wNi4yMDIyIHVt
IDAwOjU3IHNjaHJpZWIgQXJuZCBCZXJnbWFubjoKPj4+IEZyb206IEFybmQgQmVyZ21hbm4gPGFy
bmRAYXJuZGIuZGU+Cj4+Pgo+Pj4gQWxsIGFyY2hpdGVjdHVyZS1pbmRlcGVuZGVudCB1c2VycyBv
ZiB2aXJ0X3RvX2J1cygpIGFuZCBidXNfdG9fdmlydCgpCj4+PiBoYXZlIGJlZW4gZml4ZWQgdG8g
dXNlIHRoZSBkbWEgbWFwcGluZyBpbnRlcmZhY2VzIG9yIGhhdmUgYmVlbgo+Pj4gcmVtb3ZlZCBu
b3cuICBUaGlzIG1lYW5zIHRoZSBkZWZpbml0aW9ucyBvbiBtb3N0IGFyY2hpdGVjdHVyZXMsIGFu
ZCB0aGUKPj4+IENPTkZJR19WSVJUX1RPX0JVUyBzeW1ib2wgYXJlIG5vdyBvYnNvbGV0ZSBhbmQg
Y2FuIGJlIHJlbW92ZWQuCj4+Pgo+Pj4gVGhlIG9ubHkgZXhjZXB0aW9ucyB0byB0aGlzIGFyZSBh
IGZldyBuZXR3b3JrIGFuZCBzY3NpIGRyaXZlcnMgZm9yIG02OGsKPj4+IEFtaWdhIGFuZCBWTUUg
bWFjaGluZXMgYW5kIHBwYzMyIE1hY2ludG9zaC4gVGhlc2UgZHJpdmVycyB3b3JrIGNvcnJlY3Rs
eQo+Pj4gd2l0aCB0aGUgb2xkIGludGVyZmFjZXMgYW5kIGFyZSBwcm9iYWJseSBub3Qgd29ydGgg
Y2hhbmdpbmcuCj4+IFRoZSBBbWlnYSBTQ1NJIGRyaXZlcnMgYXJlIGFsbCBvbGQgV0QzM0M5MyBv
bmVzLCBhbmQgcmVwbGFjaW5nCj4+IHZpcnRfdG9fYnVzIGJ5IHZpcnRfdG9fcGh5cyBpbiB0aGUg
ZG1hX3NldHVwKCkgZnVuY3Rpb24gdGhlcmUgd291bGQKPj4gY2F1c2Ugbm8gZnVuY3Rpb25hbCBj
aGFuZ2UgYXQgYWxsLgo+IEZUUiwgdGhlIHNnaXdkOTMgZHJpdmVyIHVzZSBkbWFfbWFwX3Npbmds
ZSgpLgoKVGhhbmtzISBGcm9tIHdoYXQgSSBzZWUsIGl0IGRvZXNuJ3QgaGF2ZSB0byBkZWFsIHdp
dGggYm91bmNlIGJ1ZmZlcnMgCnRob3VnaD8KCkNoZWVycywKCiDCoMKgwqAgTWljaGFlbAoKCj4K
PiBHcntvZXRqZSxlZXRpbmd9cywKPgo+ICAgICAgICAgICAgICAgICAgICAgICAgICBHZWVydAo+
Cj4gLS0KPiBHZWVydCBVeXR0ZXJob2V2ZW4gLS0gVGhlcmUncyBsb3RzIG9mIExpbnV4IGJleW9u
ZCBpYTMyIC0tIGdlZXJ0QGxpbnV4LW02OGsub3JnCj4KPiBJbiBwZXJzb25hbCBjb252ZXJzYXRp
b25zIHdpdGggdGVjaG5pY2FsIHBlb3BsZSwgSSBjYWxsIG15c2VsZiBhIGhhY2tlci4gQnV0Cj4g
d2hlbiBJJ20gdGFsa2luZyB0byBqb3VybmFsaXN0cyBJIGp1c3Qgc2F5ICJwcm9ncmFtbWVyIiBv
ciBzb21ldGhpbmcgbGlrZSB0aGF0Lgo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IC0tIExpbnVzIFRvcnZhbGRzCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9u
Lm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9p
b21tdQ==
