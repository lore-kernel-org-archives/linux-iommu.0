Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28B83C43334
	for <iommu@archiver.kernel.org>; Thu, 30 Jun 2022 19:22:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A302040B2F;
	Thu, 30 Jun 2022 19:22:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A302040B2F
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=Ryekk371
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sE0-k8MjEyzW; Thu, 30 Jun 2022 19:22:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 4BD3540AC1;
	Thu, 30 Jun 2022 19:22:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4BD3540AC1
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 27815C002D;
	Thu, 30 Jun 2022 19:22:07 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B4EF8C0011
 for <iommu@lists.linux-foundation.org>; Thu, 30 Jun 2022 19:22:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8D67942437
 for <iommu@lists.linux-foundation.org>; Thu, 30 Jun 2022 19:22:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8D67942437
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20210112 header.b=Ryekk371
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id flcNDGYUq0jl for <iommu@lists.linux-foundation.org>;
 Thu, 30 Jun 2022 19:22:05 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A91EA42428
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com
 [IPv6:2607:f8b0:4864:20::52d])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A91EA42428
 for <iommu@lists.linux-foundation.org>; Thu, 30 Jun 2022 19:22:05 +0000 (UTC)
Received: by mail-pg1-x52d.google.com with SMTP id s27so222049pga.13
 for <iommu@lists.linux-foundation.org>; Thu, 30 Jun 2022 12:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=l005vzshb3NCX9X2VM+PRHsKSH+cwoE8+hpxYOqA4As=;
 b=Ryekk371jQ1QiVX/pYGZ1Fxnqlqp0Twrw4fdw7rwXdWNZd8linJuCpYUZVY+Q0iPyf
 MQtHmLDECOfQliv0UkVXxBpP1oEkjtqBA+m+vXUw7eTKeZQm+pLSA86FeQvRbD+P0G11
 vgeXEKD6isj/F1Ee/eKIdEVU/vkXQM/wI5kbLINfslHCrrzOI44xnSHDUGCbhqvwVddM
 j34tTrE1+UG2QZsXwyPCsEBPg2rxRpPI3L1pBalHzCrfK7rgExkmBMwK3cN5a26ttPxc
 nujxQaN3aRGOZJRNQAC0dUIV+4oE8cjHO5gI3kzVIoJ4RZMsmRwklddwhggK/OvBOGty
 iS1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=l005vzshb3NCX9X2VM+PRHsKSH+cwoE8+hpxYOqA4As=;
 b=3zlWTdoz10a9+bL2e6mrLXWv9nbCoycRBOTW3zCH/ojpN3bMb8wBBJ9m15aZ19WiUW
 oUp2Fvptc986w/V2IeyzYR0dC8ZfaJF2OAJlLKdSk/xUtwUPcAWdx1U74oqFX82Z+pPf
 xCHHXV8/m5UkKmIv6TLbxoaXz1/3/nDwHx6sl/UbklIxUnGZ7kSo5T75UflL3AQoh+Fy
 ibxrGjlj4hzmPiJ3euKg+EYFW+B24wNyU8N1l6ZPMVVrbUgS+35GyFpL1ewAGw2lfwGJ
 6n4eegRNY+Y9X8HuC6EqMgiMWrTwxUu8xH/KCA/fv7eX2VkoAn+fI24IufhNQbb+l+ri
 jHZw==
X-Gm-Message-State: AJIora+Rs8NDlgxtVIJya216idM8kM0LCt88Db31AYJk7NuUDuuDykr1
 dl1to3fyE/oAuiYHjbvkySk=
X-Google-Smtp-Source: AGRyM1slOrPQAMr1SPYrSza35gnZ53yO5OmKuyILVUgGuCU6HEAC2pr8Byjfbqxc2GodF/4gt0QEFw==
X-Received: by 2002:a05:6a00:21c8:b0:4fd:f89f:ec0e with SMTP id
 t8-20020a056a0021c800b004fdf89fec0emr17286632pfj.83.1656616925098; 
 Thu, 30 Jun 2022 12:22:05 -0700 (PDT)
Received: from ?IPV6:2001:df0:0:200c:b411:35d2:9458:bbe5?
 ([2001:df0:0:200c:b411:35d2:9458:bbe5])
 by smtp.gmail.com with ESMTPSA id
 q13-20020a170902a3cd00b0016403cae7desm13907355plb.276.2022.06.30.12.21.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Jun 2022 12:22:03 -0700 (PDT)
Message-ID: <c1d245ae-54c3-ec2b-e975-d50f9a863d2b@gmail.com>
Date: Fri, 1 Jul 2022 07:21:53 +1200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 3/3] arch/*/: remove CONFIG_VIRT_TO_BUS
Content-Language: en-US
To: Christoph Hellwig <hch@infradead.org>
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
 <YrvvfpW4MmQiM47H@infradead.org>
From: Michael Schmitz <schmitzmic@gmail.com>
In-Reply-To: <YrvvfpW4MmQiM47H@infradead.org>
Cc: Linux-Arch <linux-arch@vger.kernel.org>, scsi <linux-scsi@vger.kernel.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Jakub Kicinski <kuba@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, Miquel van Smoorenburg <mikevs@xs4all.net>,
 Denis Efremov <efremov@linux.com>,
 linux-m68k <linux-m68k@lists.linux-m68k.org>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Khalid Aziz <khalid@gonehiking.org>, Arnd Bergmann <arnd@kernel.org>,
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

SGkgQ2hyaXN0b3BoLAoKT24gMjkvMDYvMjIgMTg6MjEsIENocmlzdG9waCBIZWxsd2lnIHdyb3Rl
Ogo+IE9uIFdlZCwgSnVuIDI5LCAyMDIyIGF0IDExOjA5OjAwQU0gKzEyMDAsIE1pY2hhZWwgU2No
bWl0eiB3cm90ZToKPj4gQW5kIGFsbCBTQ1NJIGJ1ZmZlcnMgYXJlIGFsbG9jYXRlZCB1c2luZyBr
bWFsbG9jPyBObyB3YXkgYXQgYWxsIGZvciB1c2VyCj4+IHNwYWNlIHRvIHBhc3MgdW5hbGlnbmVk
IGRhdGE/Cj4gTW9zdCB0aGF0IHlvdSB3aWxsIHNlZSBhY3R1YWxseSBjb21lcyBmcm9tIHRoZSBw
YWdlIGFsbG9jYXRvci4gIEJ1dAo+IHRoZSBibG9jayBsYXllciBoYXMgYSBkbWFfYWxpZ25tZW50
IGxpbWl0LCBhbmQgd2hlbiB1c2Vyc3BhY2Ugc2VuZHMKPiBJL08gdGhhdCBpcyBub3QgcHJvcGVy
bHkgYWxpZ25lZCBpdCB3aWxsIGJlIGJvdW5jZSBidWZmZXJlZCBiZWZvcmUKPiBpdCBpdCBzZW50
IHRvIHRoZSBkcml2ZXIuCgpUaGF0IGxpbWl0IGlzIHNldCB0byBMMV9DQUNIRV9CWVRFUyBvbiBt
NjhrIHNvIHdlJ3JlIGdvb2QgaGVyZS4KClRoYW5rcywKCiDCoMKgwqAgTWljaGFlbAoKCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcg
bGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4
Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
