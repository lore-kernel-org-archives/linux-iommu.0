Return-Path: <SRS0=HP9a=ZP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE252C432C0
	for <iommu@archiver.kernel.org>; Sat, 23 Nov 2019 16:51:16 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1E432070E
	for <iommu@archiver.kernel.org>; Sat, 23 Nov 2019 16:51:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f4EoZznN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1E432070E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 1B7378748A;
	Sat, 23 Nov 2019 16:51:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oj0q8ycH226M; Sat, 23 Nov 2019 16:51:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 3F9FF873C5;
	Sat, 23 Nov 2019 16:51:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1783DC1DD8;
	Sat, 23 Nov 2019 16:51:15 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E73C5C087F
 for <iommu@lists.linux-foundation.org>; Sat, 23 Nov 2019 16:51:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id D2EED203D5
 for <iommu@lists.linux-foundation.org>; Sat, 23 Nov 2019 16:51:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sjvP7e86MXwD for <iommu@lists.linux-foundation.org>;
 Sat, 23 Nov 2019 16:51:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ot1-f67.google.com (mail-ot1-f67.google.com
 [209.85.210.67])
 by silver.osuosl.org (Postfix) with ESMTPS id 9B7E6203AE
 for <iommu@lists.linux-foundation.org>; Sat, 23 Nov 2019 16:51:11 +0000 (UTC)
Received: by mail-ot1-f67.google.com with SMTP id 66so2827070otd.9
 for <iommu@lists.linux-foundation.org>; Sat, 23 Nov 2019 08:51:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=Upjd5FUUY2gldqhTrP6G3VfXwkiVp2ftazHWWknqWA4=;
 b=f4EoZznNRknE5+5KvGz4gn6nVLdgpGkAnfbkGyUIqGaP+UAxcV/BrOLd2UxApPRrEY
 GK5bvfrDftwMSeSG2J5qWQsQbZKNzEWE1UscURDcyZ/Mf2IozhUK2hD7H7Wk6P+fr+Lj
 vYt3DfrNbNBDK2yymxFGV/wFQn08Y+ugjt/BabLIUwHrZDgdzC99OIHCsK3JPAOKI3Fl
 E0wzoBe1QNhnGqHxm235gEr3NX3lPvqWuX5gUSiK5gp+50CKyLWdeQC3cHqdNJ1vHc0O
 Pu1CfHPZkXkBFCovetMk4xuIxH7tOZ0Zyl87WOiEm3Q62Gxg8qmKNTjf1qf5qKp1IeyI
 ugIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=Upjd5FUUY2gldqhTrP6G3VfXwkiVp2ftazHWWknqWA4=;
 b=ZpEW094cT//aZGfI7J9Qr8Sn0+3rnMQn8/Imc2wnWwx1INCCHRbQb0Za1QH2CGx2WG
 jQW5yn/PImPnnCJaYKoAUzfc8N5ILCj3hQzY1M7QDyd/vBROg18LLs9bu0Ro3JMKFrKt
 xHgPZZsJLbATYGwN6Up9V43dHnhNBoZHuLkYavgkt1LX0AYYNrbk+Fc+E7Z3hW/euwaD
 tvbHd/IsNgYBWVCHIMIytrFjrSuFLZnC5ODXzn+7FjXs3dGgAFjPsNrhKE0TnkHOLxQ5
 6NifAloJy/17LOThK/8uDT4/rkrd9HVn4eBGjDQbrVztkDFBtcBUksBOyPBLZzde9NXR
 q5fQ==
X-Gm-Message-State: APjAAAVByvmVHjmObrRezD5YIDprVYJTnU4wn9QRxo2j4MR1Y3OcL1WQ
 wXtWxSapUxAM1O8nMaeXj90=
X-Google-Smtp-Source: APXvYqy/FuuHH8tC1YjzsbuxoICI/PjIU8E8OEmgejzSAAA40pPWUGyBa/f/fjeP66p0eSxGD/kxCw==
X-Received: by 2002:a9d:7399:: with SMTP id j25mr5600107otk.155.1574527870570; 
 Sat, 23 Nov 2019 08:51:10 -0800 (PST)
Received: from ubuntu-x2-xlarge-x86 ([2604:1380:4111:8b00::7])
 by smtp.gmail.com with ESMTPSA id n5sm609133oie.16.2019.11.23.08.51.09
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sat, 23 Nov 2019 08:51:09 -0800 (PST)
Date: Sat, 23 Nov 2019 09:51:08 -0700
From: Nathan Chancellor <natechancellor@gmail.com>
To: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: Re: [PATCH v2] dma-mapping: treat dev->bus_dma_mask as a DMA limit
Message-ID: <20191123165108.GA15306@ubuntu-x2-xlarge-x86>
References: <20191121092646.8449-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191121092646.8449-1-nsaenzjulienne@suse.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Cc: Peter Zijlstra <peterz@infradead.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, linux-mips@vger.kernel.org,
 linux-ide@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 Hanjun Guo <guohanjun@huawei.com>, Frank Rowand <frowand.list@gmail.com>,
 Christoph Hellwig <hch@lst.de>, "H. Peter Anvin" <hpa@zytor.com>,
 Paul Burton <paulburton@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>,
 x86@kernel.org, linux-acpi@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
 linux-pci@vger.kernel.org, James Hogan <jhogan@kernel.org>,
 Len Brown <lenb@kernel.org>, devicetree@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, Borislav Petkov <bp@alien8.de>,
 Andy Lutomirski <luto@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org,
 Jens Axboe <axboe@kernel.dk>, linuxppc-dev@lists.ozlabs.org,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org,
 Ralf Baechle <ralf@linux-mips.org>, iommu@lists.linux-foundation.org,
 Sudeep Holla <sudeep.holla@arm.com>, Robin Murphy <robin.murphy@arm.com>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Thu, Nov 21, 2019 at 10:26:44AM +0100, Nicolas Saenz Julienne wrote:
> Using a mask to represent bus DMA constraints has a set of limitations.
> The biggest one being it can only hold a power of two (minus one). The
> DMA mapping code is already aware of this and treats dev->bus_dma_mask
> as a limit. This quirk is already used by some architectures although
> still rare.
> 
> With the introduction of the Raspberry Pi 4 we've found a new contender
> for the use of bus DMA limits, as its PCIe bus can only address the
> lower 3GB of memory (of a total of 4GB). This is impossible to represent
> with a mask. To make things worse the device-tree code rounds non power
> of two bus DMA limits to the next power of two, which is unacceptable in
> this case.
> 
> In the light of this, rename dev->bus_dma_mask to dev->bus_dma_limit all
> over the tree and treat it as such. Note that dev->bus_dma_limit should
> contain the higher accesible DMA address.
> 
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
<snip>
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 041066f3ec99..0cc702a70a96 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -421,8 +421,7 @@ static dma_addr_t iommu_dma_alloc_iova(struct iommu_domain *domain,
>  	if (iova_len < (1 << (IOVA_RANGE_CACHE_MAX_SIZE - 1)))
>  		iova_len = roundup_pow_of_two(iova_len);
>  
> -	if (dev->bus_dma_mask)
> -		dma_limit &= dev->bus_dma_mask;
> +	dma_limit = min_not_zero(dma_limit, dev->bus_dma_limit);
>  
>  	if (domain->geometry.force_aperture)
>  		dma_limit = min(dma_limit, domain->geometry.aperture_end);

Just as an FYI, this introduces a warning on arm32 allyesconfig for me:

In file included from ../include/linux/list.h:9,
                 from ../include/linux/kobject.h:19,
                 from ../include/linux/of.h:17,
                 from ../include/linux/irqdomain.h:35,
                 from ../include/linux/acpi.h:13,
                 from ../include/linux/acpi_iort.h:10,
                 from ../drivers/iommu/dma-iommu.c:11:
../drivers/iommu/dma-iommu.c: In function 'iommu_dma_alloc_iova':
../include/linux/kernel.h:851:29: warning: comparison of distinct pointer types lacks a cast
  851 |   (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
      |                             ^~
../include/linux/kernel.h:865:4: note: in expansion of macro '__typecheck'
  865 |   (__typecheck(x, y) && __no_side_effects(x, y))
      |    ^~~~~~~~~~~
../include/linux/kernel.h:875:24: note: in expansion of macro '__safe_cmp'
  875 |  __builtin_choose_expr(__safe_cmp(x, y), \
      |                        ^~~~~~~~~~
../include/linux/kernel.h:884:19: note: in expansion of macro '__careful_cmp'
  884 | #define min(x, y) __careful_cmp(x, y, <)
      |                   ^~~~~~~~~~~~~
../include/linux/kernel.h:917:39: note: in expansion of macro 'min'
  917 |  __x == 0 ? __y : ((__y == 0) ? __x : min(__x, __y)); })
      |                                       ^~~
../drivers/iommu/dma-iommu.c:424:14: note: in expansion of macro 'min_not_zero'
  424 |  dma_limit = min_not_zero(dma_limit, dev->bus_dma_limit);
      |              ^~~~~~~~~~~~

Cheers,
Nathan
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
