Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3EF1C433EF
	for <iommu@archiver.kernel.org>; Sat, 18 Jun 2022 14:05:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7EC3B60B3B;
	Sat, 18 Jun 2022 14:05:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7EC3B60B3B
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=mYCiRA6j
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fCJgUOnAWQZn; Sat, 18 Jun 2022 14:05:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 3F4F860888;
	Sat, 18 Jun 2022 14:05:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3F4F860888
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1E051C0032;
	Sat, 18 Jun 2022 14:05:20 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B0C37C007C
 for <iommu@lists.linux-foundation.org>; Sat, 18 Jun 2022 01:06:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 763D660B25
 for <iommu@lists.linux-foundation.org>; Sat, 18 Jun 2022 01:06:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 763D660B25
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id v6FWbIBTFzmp for <iommu@lists.linux-foundation.org>;
 Sat, 18 Jun 2022 01:06:54 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2679360B05
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com
 [IPv6:2607:f8b0:4864:20::102c])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2679360B05
 for <iommu@lists.linux-foundation.org>; Sat, 18 Jun 2022 01:06:53 +0000 (UTC)
Received: by mail-pj1-x102c.google.com with SMTP id
 g16-20020a17090a7d1000b001ea9f820449so5921687pjl.5
 for <iommu@lists.linux-foundation.org>; Fri, 17 Jun 2022 18:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=subject:to:references:cc:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding;
 bh=KRIeihzYwpT99jVYyWrBvkWlYlvrvIZJfg260Yku6Lc=;
 b=mYCiRA6jX3TZBBpH5i1bdKxf86pnFybirRcUnA7+QegXGbzOVw+vVyBSconShTfcN0
 cCwY9Lg+Wp1DUlN7ZuDKZXZp+Lq9oTrhj5Egt9NASpHMRY0WFnq2TqiOXmxGI5seYlbP
 q0BPpHgaiqex7reMZd7eeiSPLbAesZfnXOSNpNddBnH0OtREDZ0fHr/GsKwCbGO2CEAh
 0hN2+Q0eH6pq4ZYITkDSH3pFg/hKtXahXOuIosfi8Y0II3BWuxt8tZ5GTulif6PPtR6w
 mWvi9cySEswvHdKCNsD70zRyxq32NFDfKs677RtcCSsSo3yIFNheD9lUFe9of5dO2FCw
 T3OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:references:cc:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding;
 bh=KRIeihzYwpT99jVYyWrBvkWlYlvrvIZJfg260Yku6Lc=;
 b=7Qbd8x5F4KyaBksw9kogFRAfxQpf8gXrT5WS/WCKIlZJIqg0YXVvetBGw9VZAKGAEl
 36PeAfPMKt5quCQ6Iju/ALZ1O/JmNwBfNwdq85DsurCzwC8LTcxkDi1kWtkGX+CJsMes
 7ataowTSpqRA2DhdalQl6PXbObtis3av0ljZT2Fqng1jfmMrawdK9E4RK3BkKuY5r7wE
 aE8T83y/VK3On2ZAKLoGHKU8Vl0bmVuIPzpVB2k5v7IEYYRCahFK1FNS82bA2zkUmc53
 HiMUBawVQMn3gks+1MC7akdJopwnwDsmwMk1g9Juggm9c9XLpDiKjqSJE4RvyKhKU1y6
 Wj2g==
X-Gm-Message-State: AJIora/N/vkZ0Vy2W1cTTgV51P/MTrhco0+PBVIeNWoGViFB8WdCp1pi
 eEOb1P8f9j9OhMvMMriBEXw=
X-Google-Smtp-Source: AGRyM1u1j6XUfwl32yRCm+A4vEBywEwNGmaCfY9KqlZE6/HghD6w2fj/KwvqmOMndnHwj1ctiT07Vw==
X-Received: by 2002:a17:90b:4ac9:b0:1e3:1dca:d995 with SMTP id
 mh9-20020a17090b4ac900b001e31dcad995mr13457922pjb.111.1655514413476; 
 Fri, 17 Jun 2022 18:06:53 -0700 (PDT)
Received: from [10.1.1.24] (222-155-0-244-adsl.sparkbb.co.nz. [222.155.0.244])
 by smtp.gmail.com with ESMTPSA id
 j3-20020a170903024300b00161947ecc82sm4126766plh.199.2022.06.17.18.06.43
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 17 Jun 2022 18:06:52 -0700 (PDT)
Subject: Re: [PATCH v2 3/3] arch/*/: remove CONFIG_VIRT_TO_BUS
To: Arnd Bergmann <arnd@kernel.org>, linux-scsi@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20220617125750.728590-1-arnd@kernel.org>
 <20220617125750.728590-4-arnd@kernel.org>
From: Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <6ba86afe-bf9f-1aca-7af1-d0d348d75ffc@gmail.com>
Date: Sat, 18 Jun 2022 13:06:40 +1200
User-Agent: Mozilla/5.0 (X11; Linux ppc; rv:45.0) Gecko/20100101 Icedove/45.4.0
MIME-Version: 1.0
In-Reply-To: <20220617125750.728590-4-arnd@kernel.org>
X-Mailman-Approved-At: Sat, 18 Jun 2022 14:05:19 +0000
Cc: linux-arch@vger.kernel.org, Miquel van Smoorenburg <mikevs@xs4all.net>,
 Geert Uytterhoeven <geert@linux-m68k.org>, linux-parisc@vger.kernel.org,
 Arnd Bergmann <arnd@arndb.de>, linuxppc-dev@lists.ozlabs.org,
 "Maciej W . Rozycki" <macro@orcam.me.uk>, linux-m68k@lists.linux-m68k.org,
 Denis Efremov <efremov@linux.com>, Mark Salyzyn <salyzyn@android.com>,
 Christoph Hellwig <hch@infradead.org>, iommu@lists.linux-foundation.org,
 Matt Wang <wwentao@vmware.com>, Michael Ellerman <mpe@ellerman.id.au>,
 linux-alpha@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Arnd,

Am 18.06.2022 um 00:57 schrieb Arnd Bergmann:
> From: Arnd Bergmann <arnd@arndb.de>
>
> All architecture-independent users of virt_to_bus() and bus_to_virt()
> have been fixed to use the dma mapping interfaces or have been
> removed now.  This means the definitions on most architectures, and the
> CONFIG_VIRT_TO_BUS symbol are now obsolete and can be removed.
>
> The only exceptions to this are a few network and scsi drivers for m68k
> Amiga and VME machines and ppc32 Macintosh. These drivers work correctly
> with the old interfaces and are probably not worth changing.

The Amiga SCSI drivers are all old WD33C93 ones, and replacing 
virt_to_bus by virt_to_phys in the dma_setup() function there would 
cause no functional change at all.

drivers/vme/bridges/vme_ca91cx42.c hasn't been used at all on m68k (it 
is a PCI-to-VME bridge chipset driver that would be needed on 
architectures that natively use a PCI bus). I haven't found anything 
that selects that driver, so not sure it is even still in use??

That would allow you to drop the remaining virt_to_bus define from 
arch/m68k/include/asm/virtconvert.h.

I could submit a patch to convert the Amiga SCSI drivers to use 
virt_to_phys if Geert and the SCSI maintainers think it's worth the churn.

32bit powerpc is a different matter though.

Cheers,

	Michael
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
