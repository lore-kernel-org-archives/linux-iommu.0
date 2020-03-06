Return-Path: <SRS0=/Eks=4X=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B6F6C10F00
	for <iommu@archiver.kernel.org>; Fri,  6 Mar 2020 13:09:25 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3B1024655
	for <iommu@archiver.kernel.org>; Fri,  6 Mar 2020 13:09:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="foqmJvTU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3B1024655
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id A9CF0882ED;
	Fri,  6 Mar 2020 13:09:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uenATxKxcMEu; Fri,  6 Mar 2020 13:09:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 25F1C865A1;
	Fri,  6 Mar 2020 13:09:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1887FC18D3;
	Fri,  6 Mar 2020 13:09:24 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C43C4C013E
 for <iommu@lists.linux-foundation.org>; Fri,  6 Mar 2020 13:09:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id BFD6F882EB
 for <iommu@lists.linux-foundation.org>; Fri,  6 Mar 2020 13:09:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ntMC1XrrX9RF for <iommu@lists.linux-foundation.org>;
 Fri,  6 Mar 2020 13:09:22 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-qv1-f67.google.com (mail-qv1-f67.google.com
 [209.85.219.67])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 0C3D8865A1
 for <iommu@lists.linux-foundation.org>; Fri,  6 Mar 2020 13:09:22 +0000 (UTC)
Received: by mail-qv1-f67.google.com with SMTP id du17so273567qvb.12
 for <iommu@lists.linux-foundation.org>; Fri, 06 Mar 2020 05:09:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=XKKq26i7LXXgJsW46mcbcSbPq8I/xYnL2HpEPyMqw1w=;
 b=foqmJvTUw2Rd/dJAzqjnhmFuMbsk1LtzLOifzjHgdZQbMzZ0fHXAAsUe/GdCO1ZYAj
 7Bn2iIOTlWGut2weejRp8AcX3VG/Qn4/y/RQG0WtfMqv+MReV5P5jcMiLxOXdqYalZiA
 /dVdSm1Sf6SyyIudvVIwFow4eMDAUcfiWaT/zF3cFXtW4JnKM0JErPEQqyhqPtB0Hhdr
 ol2bHUU9KfkJM+O1Bn3ayXm8dujSMw6pcJy7+pV2WuGXVVhtWpVQF3na2JpDadwaG7Lv
 FiGiNN5hAg+eY9U2557t7Y1y8aKkxx39cX6l7OgYqp4+v+dicxqKElU/9QEPZ5LM/fig
 63hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=XKKq26i7LXXgJsW46mcbcSbPq8I/xYnL2HpEPyMqw1w=;
 b=DqgdCrpE7G+wpGV6JX26TQgFVyDbmjq9f5VXfUKyFVPwnMZpVpm/xOFV8Br0ayki+g
 usS7BEUiLOclDwJ3rRwvpqD0fEEzjx4kcfi+kDKCRHc4VaqQjVGHMjt0e+Oo5y1uZOAa
 wSh3Kzrqs6YTORUTK08CZ3oIZ1yaqshHn8nVB2nzsNcjtdyM4aq1fGpTpjN2fgq3vcRe
 uBK428rmo+XYaR2B93ArabL4KNJ/L/JykYns1drxApRGFWaYM/XHlSMVm1q4JBmIbZSR
 WRYjnFs1JxqQsXYrECLjb1F4iz5orsYDBKPU2Ywwkxfa5eELHMIzn12OHBU+uTWtVATr
 fn0g==
X-Gm-Message-State: ANhLgQ0cH27tcEa8GZhiLDropjDLE4OOJKEhJeJ/5jhnJkSR+/PhH1ay
 dgzjhTBfo2qB7b4RcajhFfulQw==
X-Google-Smtp-Source: ADFU+vtl8tdBNaG32n8uRFCoIw2vjaXoLHT1yzW1F89T5e4eGpjKwith2OB8kDL1Ro6OTXnkI3ffpw==
X-Received: by 2002:a0c:f5ce:: with SMTP id q14mr2642141qvm.191.1583500160921; 
 Fri, 06 Mar 2020 05:09:20 -0800 (PST)
Received: from ziepe.ca
 (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.68.57.212])
 by smtp.gmail.com with ESMTPSA id e7sm8754949qtp.0.2020.03.06.05.09.20
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 06 Mar 2020 05:09:20 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
 (envelope-from <jgg@ziepe.ca>)
 id 1jACj9-0002zi-Hm; Fri, 06 Mar 2020 09:09:19 -0400
Date: Fri, 6 Mar 2020 09:09:19 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH v4 01/26] mm/mmu_notifiers: pass private data down to
 alloc_notifier()
Message-ID: <20200306130919.GJ31668@ziepe.ca>
References: <20200224182401.353359-1-jean-philippe@linaro.org>
 <20200224182401.353359-2-jean-philippe@linaro.org>
 <20200224190056.GT31668@ziepe.ca> <20200225092439.GB375953@myrica>
 <20200225140814.GW31668@ziepe.ca> <20200228143935.GA2156@myrica>
 <20200228144844.GQ31668@ziepe.ca> <20200228150427.GF2156@myrica>
 <20200228151339.GS31668@ziepe.ca> <20200306095614.GA50020@myrica>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200306095614.GA50020@myrica>
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

On Fri, Mar 06, 2020 at 10:56:14AM +0100, Jean-Philippe Brucker wrote:
> I tried to keep it simple like that: normally mmu_notifier_get() is called
> in bind(), and mmu_notifier_put() is called in unbind(). 
> 
> Multiple device drivers may call bind() with the same mm. Each bind()
> calls mmu_notifier_get(), obtains the same io_mm, and returns a new bond
> (a device<->mm link). Each bond is freed by calling unbind(), which calls
> mmu_notifier_put().
> 
> That's the most common case. Now if the process is killed and the mm
> disappears, we do need to avoid use-after-free caused by DMA of the
> mappings and the page tables. 

This is why release must do invalidate all - but it doesn't need to do
any more - as no SPTE can be established without a mmget() - and
mmget() is no longer possible past release.

> So the release() callback, before doing invalidate_all, stops DMA
> and clears the page table pointer on the IOMMU side. It detaches all
> bonds from the io_mm, calling mmu_notifier_put() for each of
> them. After release(), bond objects still exists and device drivers
> still need to free them with unbind(), but they don't point to an
> io_mm anymore.

Why is so much work needed in release? It really should just be
invalidate all, usually trying to sort out all the locking for the
more complicated stuff is not worthwhile.

If other stuff is implicitly relying on the mm being alive and release
to fence against that then it is already racy. If it doesn't, then why
bother doing complicated work in release?

> > Then you can never get a stale
> > pointer. Don't worry about exit_mmap().
> > 
> > release() is an unusual callback and I see alot of places using it
> > wrong. The purpose of release is to invalidate_all, that is it.
> > 
> > Also, confusingly release may be called multiple times in some
> > situations, so it shouldn't disturb anything that might impact a 2nd
> > call.
> 
> I hadn't realized that. The current implementation should be safe against
> it, as release() is a nop if the io_mm doesn't have bonds anymore. Do you
> have an example of such a situation?  I'm trying to write tests for this
> kind of corner cases.

Hmm, let me think. Ah, you have to be using mmu_notifier_unregister()
to get that race. This is one of the things that get/put don't suffer
from - but they conversely don't guarantee that release() will be
called, so it is up to the caller to ensure everything is fenced
before calling put.

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
