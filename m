Return-Path: <SRS0=T/MU=ZT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D26FDC432C0
	for <iommu@archiver.kernel.org>; Wed, 27 Nov 2019 15:15:16 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95F8E206F0
	for <iommu@archiver.kernel.org>; Wed, 27 Nov 2019 15:15:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="ph9lVf4u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95F8E206F0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id CF44486C18;
	Wed, 27 Nov 2019 15:15:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FpOvHzegr4Ha; Wed, 27 Nov 2019 15:15:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 055B58665D;
	Wed, 27 Nov 2019 15:15:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E846CC1DDA;
	Wed, 27 Nov 2019 15:15:12 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DD1E9C0881
 for <iommu@lists.linux-foundation.org>; Wed, 27 Nov 2019 15:15:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id D8AFC20468
 for <iommu@lists.linux-foundation.org>; Wed, 27 Nov 2019 15:15:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dBso6yXhTn5V for <iommu@lists.linux-foundation.org>;
 Wed, 27 Nov 2019 15:15:08 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de
 [85.215.255.53])
 by silver.osuosl.org (Postfix) with ESMTPS id 6E213204B9
 for <iommu@lists.linux-foundation.org>; Wed, 27 Nov 2019 15:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1574867705;
 s=strato-dkim-0002; d=xenosoft.de;
 h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:
 X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
 bh=rU6EJZnQMWHiAAMrDnvCSg5GJl/7kaL3qM/q2ihcwWc=;
 b=ph9lVf4uZCtsNHV5En2AFDgYlF3Nc3pOQpoMIiG5L0aKsKfTUtK61fJysZJ352sHGn
 qs6hirz5guL+KODjKkRHVIsD49mDdpn8tmu+/c3sFvE3S9MwrQ2MV7cnxKYIjIUcMQQd
 f5+k1ed2L9olHIL9dXKi+M1jq96msuMTdzK3ZI5fZhovH3RDqQsSUrZ0NPS7oDEj8VLN
 mwOFuvYbPhovmadu1iIlxJsQCQBz3UxhZhfwTwMCrZmFFbfCzp7Mq7g7ONLR0/4/2QSV
 xVL/FSrtZeFOucbVuqI2HYl/aGHRhnvEykoZ8K3AjdH6YF1qI0PjWL4CkemqzM04kG7e
 FFZQ==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGM4l4Hio94KKxRySfLxnHfJ+Dkjp5DdBJSrwuuqxvPhUIxnPrrzntHiDgpTRUbNSOXek"
X-RZG-CLASS-ID: mo00
Received: from [IPv6:2a02:8109:89c0:ebfc:7591:d54e:863:4581]
 by smtp.strato.de (RZmta 46.0.0 AUTH) with ESMTPSA id n05ae1vARFEh10O
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits))
 (Client did not present a certificate);
 Wed, 27 Nov 2019 16:14:43 +0100 (CET)
Subject: Re: Bug 205201 - Booting halts if Dawicontrol DC-2976 UW SCSI board
 installed, unless RAM size limited to 3500M
To: Mike Rapoport <rppt@linux.ibm.com>, Christoph Hellwig <hch@lst.de>
References: <20191121072943.GA24024@lst.de>
 <dbde2252-035e-6183-7897-43348e60647e@xenosoft.de>
 <6eec5c42-019c-a988-fc2a-cb804194683d@xenosoft.de>
 <d0252d29-7a03-20e1-ccd7-e12d906e4bdf@arm.com>
 <b3217742-2c0b-8447-c9ac-608b93265363@xenosoft.de>
 <20191121180226.GA3852@lst.de>
 <2fde79cf-875f-94e6-4a1b-f73ebb2e2c32@xenosoft.de>
 <20191125073923.GA30168@lst.de>
 <4681f5fe-c095-15f5-9221-4b55e940bafc@xenosoft.de>
 <20191126164026.GA8026@lst.de> <20191127065624.GB16913@linux.ibm.com>
From: Christian Zigotzky <chzigotzky@xenosoft.de>
Message-ID: <6a4289cf-d2b5-2357-f1ad-eeab44ab3b1e@xenosoft.de>
Date: Wed, 27 Nov 2019 16:14:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20191127065624.GB16913@linux.ibm.com>
Content-Language: de-DE
Cc: linux-arch@vger.kernel.org, darren@stevens-zone.net, rtd2@xtra.co.nz,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, iommu@lists.linux-foundation.org,
 Rob Herring <robh+dt@kernel.org>, paulus@samba.org,
 mad skateman <madskateman@gmail.com>, "contact@a-eon.com" <contact@a-eon.com>,
 Robin Murphy <robin.murphy@arm.com>, nsaenzjulienne@suse.de
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

On 27 November 2019 at 07:56 am, Mike Rapoport wrote:
>
> Maybe we'll simply force bottom up allocation before calling
> swiotlb_init()? Anyway, it's the last memblock allocation.
>
>
> diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
> index 62f74b1b33bd..771e6cf7e2b9 100644
> --- a/arch/powerpc/mm/mem.c
> +++ b/arch/powerpc/mm/mem.c
> @@ -286,14 +286,15 @@ void __init mem_init(void)
>   	/*
>   	 * book3s is limited to 16 page sizes due to encoding this in
>   	 * a 4-bit field for slices.
>   	 */
>   	BUILD_BUG_ON(MMU_PAGE_COUNT > 16);
>   
>   #ifdef CONFIG_SWIOTLB
> +	memblock_set_bottom_up(true);
>   	swiotlb_init(0);
>   #endif
>   
>   	high_memory = (void *) __va(max_low_pfn * PAGE_SIZE);
>   	set_max_mapnr(max_pfn);
>   	memblock_free_all();
>   
>   
Hello Mike,

I tested the latest Git kernel with your new patch today. My PCI TV card 
works without any problems.

Thanks,
Christian
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
