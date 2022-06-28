Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31B2ECCA479
	for <iommu@archiver.kernel.org>; Tue, 28 Jun 2022 23:50:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C7BD581BC2;
	Tue, 28 Jun 2022 23:50:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C7BD581BC2
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vnXG7usjX8YB; Tue, 28 Jun 2022 23:50:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id C5B3B81B99;
	Tue, 28 Jun 2022 23:50:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C5B3B81B99
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A13AAC0032;
	Tue, 28 Jun 2022 23:50:17 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7A750C002D
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jun 2022 23:50:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5A9F6409EA
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jun 2022 23:50:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5A9F6409EA
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ILpq2vm85xlv for <iommu@lists.linux-foundation.org>;
 Tue, 28 Jun 2022 23:50:15 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 52413409DE
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com
 [209.85.214.177])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 52413409DE
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jun 2022 23:50:15 +0000 (UTC)
Received: by mail-pl1-f177.google.com with SMTP id m14so12488365plg.5
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jun 2022 16:50:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=SkmGWod1utKevQCGJfPo61gCs9z/vOcHKNlbLZdqJ/g=;
 b=uS1VG/JfNReeruASD9/ot6GYv6VDrY5ntK9EmUmj5P/cT4CWQyS3dzZ7TlrAsoiKBW
 0CrHwCjh6FUWJRv/tVFMXXu4qhmDIevd8qaNbeeMP6d5VAFKx5soLPOG1WED+tOA6cYV
 4bY/fiNsU4oGowwUWhrhB17lPeF1ygHIe+tGtir420zRNJ2O/Hur6qrAps4vVDk08w9K
 zXs9+8zMQoZAPHynMHBCA3F1aQRj2kwVGX5DH6VbFHCDF/6r0/lvDYx+SyjKOJbuMr9K
 kQQzMwq9WGW5G7/utKCNenmpj4InZDjxeD6X62hXxkz021kF7gY54JHF6Kr77uCIFiHf
 7oRg==
X-Gm-Message-State: AJIora94z3B7eBIv82MsepMkd6twyRvzbYcUPPloyLn/9Qs8fPYzOGEK
 q7heKCaPnSMsOL9pVvdPkVU=
X-Google-Smtp-Source: AGRyM1tnnxYUcJUuaxfKTDWykUv9yEoY4oVypBD4NkfNBc/cSEjrtWY1RB48/mXAX8MoxReO3fVA2g==
X-Received: by 2002:a17:90b:4c0d:b0:1ed:2466:c0d3 with SMTP id
 na13-20020a17090b4c0d00b001ed2466c0d3mr2517451pjb.6.1656460214627; 
 Tue, 28 Jun 2022 16:50:14 -0700 (PDT)
Received: from ?IPV6:2601:647:4000:d7:feaa:14ff:fe9d:6dbd?
 ([2601:647:4000:d7:feaa:14ff:fe9d:6dbd])
 by smtp.gmail.com with ESMTPSA id
 cr9-20020a056a000f0900b0052594a3ba89sm6923182pfb.65.2022.06.28.16.50.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jun 2022 16:50:13 -0700 (PDT)
Message-ID: <fc47e8da-81d3-e563-0a17-4eb23db015cc@acm.org>
Date: Tue, 28 Jun 2022 16:50:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 3/3] arch/*/: remove CONFIG_VIRT_TO_BUS
Content-Language: en-US
To: Michael Schmitz <schmitzmic@gmail.com>, Arnd Bergmann <arnd@kernel.org>
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
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <9f812d3d-0fcd-46e6-6d7e-6d4bf66f24ab@gmail.com>
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 6/28/22 16:09, Michael Schmitz wrote:
> On 29/06/22 09:50, Arnd Bergmann wrote:
>> On Tue, Jun 28, 2022 at 11:03 PM Michael Schmitz 
>> <schmitzmic@gmail.com> wrote:
>>> On 28/06/22 19:03, Geert Uytterhoeven wrote:
>>>>> The driver allocates bounce buffers using kmalloc if it hits an
>>>>> unaligned data buffer - can such buffers still even happen these days?
>>>> No idea.
>>> Hmmm - I think I'll stick a WARN_ONCE() in there so we know whether this
>>> code path is still being used.
>> kmalloc() guarantees alignment to the next power-of-two size or
>> KMALLOC_MIN_ALIGN, whichever is bigger. On m68k this means it
>> is cacheline aligned.
> 
> And all SCSI buffers are allocated using kmalloc? No way at all for user 
> space to pass unaligned data?
> 
> (SCSI is a weird beast - I have used a SCSI DAT tape driver many many 
> years ago, which broke all sorts of assumptions about transfer block 
> sizes ... but that might actually have been in the v0.99 days, many 
> rewrites of SCSI midlevel ago).
> 
> Just being cautious, as getting any of this tested will be a stretch.

An example of a user space application that passes an SG I/O data buffer 
to the kernel that is aligned to a four byte boundary but not to an 
eight byte boundary if the -s (scattered) command line option is used: 
https://github.com/osandov/blktests/blob/master/src/discontiguous-io.cpp

Bart.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
