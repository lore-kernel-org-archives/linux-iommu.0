Return-Path: <SRS0=BxgK=4Q=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99E5FC3F2CD
	for <iommu@archiver.kernel.org>; Fri, 28 Feb 2020 14:48:49 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63BEE2469D
	for <iommu@archiver.kernel.org>; Fri, 28 Feb 2020 14:48:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="CV3X+nQK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63BEE2469D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 268F420499;
	Fri, 28 Feb 2020 14:48:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dhC46DYG6hqy; Fri, 28 Feb 2020 14:48:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 504012014B;
	Fri, 28 Feb 2020 14:48:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1FDABC08A0;
	Fri, 28 Feb 2020 14:48:48 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 41D58C0177
 for <iommu@lists.linux-foundation.org>; Fri, 28 Feb 2020 14:48:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 3AC6C86B81
 for <iommu@lists.linux-foundation.org>; Fri, 28 Feb 2020 14:48:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mOpr2D_QbkAZ for <iommu@lists.linux-foundation.org>;
 Fri, 28 Feb 2020 14:48:46 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-qt1-f194.google.com (mail-qt1-f194.google.com
 [209.85.160.194])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 7932A86108
 for <iommu@lists.linux-foundation.org>; Fri, 28 Feb 2020 14:48:46 +0000 (UTC)
Received: by mail-qt1-f194.google.com with SMTP id y3so1648200qtv.12
 for <iommu@lists.linux-foundation.org>; Fri, 28 Feb 2020 06:48:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=rsM6P0iWQtYbTIZfDH4GZGs0dcL9Uy2VcIbqhq4DVAs=;
 b=CV3X+nQKX4SjkWXOCXtPcfUWPbWcnGZIr5HXT0td8jCm8UnHLWOJGbCDin+fnDMVh6
 HJjdT1BDInHrt1jgg7+HKPKmxJ+UWR8YMidtypOgu4QTRFY9Wu0jLvzuIF2MK/mIyaDX
 U6540tjncMTP9HxIc2pcrk8RD8kEm4WNC+qgrATMR0y1E2OgtHFcKDmfecdvihyCtKzE
 5z/LqZfYlvAK7Ftc6n4Me1dMh0Y1wkVX2SLDydwWUd9444Zrts13ZQcXeFvt1tJDmWyx
 pVirruhQetio5UlZFpFM8fniSZUI6ZOWFVd0j2FrnRrxsI3M0zlRlNvFarECiOVYnx29
 GpFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=rsM6P0iWQtYbTIZfDH4GZGs0dcL9Uy2VcIbqhq4DVAs=;
 b=L4u5vnALKSgurd2y1GqixvPZlAIGqK7mQlHYKe3U3eGsADUQDtrdSeBVj3zr5067Lu
 RyE/DLtP3L7mdnfOnw1tc+XbJno1EgXXawtr4GTrgBSNSdbR6FkHs3ycRzW9vTQGD1ws
 vb4BW8CDQYKzqpDdfWgCgEQBN+LAyyat0X5zG9eylnHTCa19i4n9nN5oneYyifn/jnFC
 C1BzvRdHRi1mW/z+kdxkkAK4T0I2IU06sWgupjou2A1y5oB2HZTO6Oh8eEeWgF7UAei2
 FJrN6TKBqaUEgSOXt9ZceocSGLE5lAPXpG6rmlCtUbupdjWo6wNbZz73Z3mv2ykrqcWD
 n6LA==
X-Gm-Message-State: APjAAAVjIZBN/rhMOyoJ/syMsfmsOjt0dYaehxscYpXaFSdXsyh7K/8S
 uJP47iW9Y6q0+NK/2Vv7Pi9rzw==
X-Google-Smtp-Source: APXvYqx4if0FgrogA1eRtXiNBtPg1pCTbepMjiVN00txoqKmRdlRgAbN74CUZqB71Vhu4mXSAdk1Rg==
X-Received: by 2002:ac8:425a:: with SMTP id r26mr4520637qtm.138.1582901325295; 
 Fri, 28 Feb 2020 06:48:45 -0800 (PST)
Received: from ziepe.ca
 (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.68.57.212])
 by smtp.gmail.com with ESMTPSA id t29sm5422548qtt.20.2020.02.28.06.48.44
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 28 Feb 2020 06:48:44 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
 (envelope-from <jgg@ziepe.ca>)
 id 1j7gwW-0002z7-9g; Fri, 28 Feb 2020 10:48:44 -0400
Date: Fri, 28 Feb 2020 10:48:44 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH v4 01/26] mm/mmu_notifiers: pass private data down to
 alloc_notifier()
Message-ID: <20200228144844.GQ31668@ziepe.ca>
References: <20200224182401.353359-1-jean-philippe@linaro.org>
 <20200224182401.353359-2-jean-philippe@linaro.org>
 <20200224190056.GT31668@ziepe.ca> <20200225092439.GB375953@myrica>
 <20200225140814.GW31668@ziepe.ca> <20200228143935.GA2156@myrica>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200228143935.GA2156@myrica>
User-Agent: Mutt/1.9.4 (2018-02-28)
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, kevin.tian@intel.com,
 Dimitri Sivanich <sivanich@sgi.com>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pci@vger.kernel.org,
 robin.murphy@arm.com, linux-mm@kvack.org, iommu@lists.linux-foundation.org,
 robh+dt@kernel.org, catalin.marinas@arm.com, zhangfei.gao@linaro.org,
 Andrew Morton <akpm@linux-foundation.org>, will@kernel.org,
 christian.koenig@amd.com, linux-arm-kernel@lists.infradead.org
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

On Fri, Feb 28, 2020 at 03:39:35PM +0100, Jean-Philippe Brucker wrote:
> > > +	list_for_each_entry_rcu(bond, &io_mm->devices, mm_head) {
> > > +		/*
> > > +		 * To ensure that we observe the initialization of io_mm fields
> > > +		 * by io_mm_finalize() before the registration of this bond to
> > > +		 * the list by io_mm_attach(), introduce an address dependency
> > > +		 * between bond and io_mm. It pairs with the smp_store_release()
> > > +		 * from list_add_rcu().
> > > +		 */
> > > +		io_mm = rcu_dereference(bond->io_mm);
> > 
> > A rcu_dereference isn't need here, just a normal derference is fine.
> 
> bond->io_mm is annotated with __rcu (for iommu_sva_get_pasid_generic(),
> which does bond->io_mm under rcu_read_lock())

I'm surprised the bond->io_mm can change over the lifetime of the
bond memory..

> > > If io_mm->ctx and io_mm->ops are already valid before the
> > > mmu notifier is published, then we don't need that stuff.
> > 
> > So, this trickyness with RCU is not a bad reason to introduce the priv
> > scheme, maybe explain it in the commit message?
> 
> Ok, I've added this to the commit message:
> 
>     The IOMMU SVA module, which attaches an mm to multiple devices,
>     exemplifies this situation. In essence it does:
> 
>             mmu_notifier_get()
>               alloc_notifier()
>                  A = kzalloc()
>               /* MMU notifier is published */
>             A->ctx = ctx;                           // (1)
>             device->A = A;
>             list_add_rcu(device, A->devices);       // (2)
> 
>     The invalidate notifier, which may start running before A is fully
>     initialized at (1), does the following:
> 
>             io_mm_invalidate(A)
>               list_for_each_entry_rcu(device, A->devices)
>                 A = device->A;                      // (3)

I would drop the work around from the decription, it is enough to say
that the line below needs to observe (1) after (2) and this is
trivially achieved by moving (1) to before publishing the notifier so
the core MM locking can be used.

Regards,
Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
