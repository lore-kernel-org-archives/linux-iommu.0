Return-Path: <SRS0=/Eks=4X=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E49EAC10DCE
	for <iommu@archiver.kernel.org>; Fri,  6 Mar 2020 16:15:32 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCCFC208C3
	for <iommu@archiver.kernel.org>; Fri,  6 Mar 2020 16:15:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZzXz4A8v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCCFC208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 951A02036B;
	Fri,  6 Mar 2020 16:15:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZnUuAJEnnv-v; Fri,  6 Mar 2020 16:15:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 71FC020131;
	Fri,  6 Mar 2020 16:15:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 67859C18DA;
	Fri,  6 Mar 2020 16:15:31 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2F597C013E
 for <iommu@lists.linux-foundation.org>; Fri,  6 Mar 2020 16:15:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 1C2C62036B
 for <iommu@lists.linux-foundation.org>; Fri,  6 Mar 2020 16:15:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hiJcXXkPvCcc for <iommu@lists.linux-foundation.org>;
 Fri,  6 Mar 2020 16:15:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com
 [209.85.128.66])
 by silver.osuosl.org (Postfix) with ESMTPS id DE36D20131
 for <iommu@lists.linux-foundation.org>; Fri,  6 Mar 2020 16:15:28 +0000 (UTC)
Received: by mail-wm1-f66.google.com with SMTP id p9so3089294wmc.2
 for <iommu@lists.linux-foundation.org>; Fri, 06 Mar 2020 08:15:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=ao7/80FHIHDLP/KCunZJJgILy66emPF5N72zFy2TR8A=;
 b=ZzXz4A8vycCJh4RNBaNwHExa5FzLad69MAK4BZ+5/as1gVnRbY6GMPLpDuEkpCKWF6
 y6CsRjCx5QLX391p185dlNAY1Zcap1EnGsNaLq9XDn4MYET7xEWLNyB/6LDuPN6MRygC
 YZ5w1hGW0XSmAZgBTL6frJPrhb9fznVH9L9vwRNdIecRFk8QGoUr/L+Knolbah0v2qev
 1VwkncH2BAtFZIbRxurp6iliV7mw4l8C3XnXlu/qVJcZHUrF9gIymPJHAlq33QsB4aQ6
 QXgqfDAnyXp5rPLLQMnU0kpgkNyKPGKwvV48byaa1UK7DgR+lESHtDBsR9KfL7wvFZWh
 kldw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=ao7/80FHIHDLP/KCunZJJgILy66emPF5N72zFy2TR8A=;
 b=mgy5hcYt2d8fP3SVC3wn1kYQ0tkgZVGwWhm2KvM4T1XBsm4xhdafKbdY/IqUhrYHVf
 SlF3AFSooj8K0rUF5F++TFMqrn3qcG++OaZoeecNCkYh7TJpBzfp3HLqtRby9WGOoWf0
 57wspbrioaQYec1OC0XgjEwctducDReJlhPTkeC7QQ/UirhtoTShC+Qawyxmg2n8bF7i
 kgQ7vnNFc6T56Ns8FASAM3ALX0rOSKKhslItEyLVmvynhROi/+ovQJwPDwMJJ6Di5guM
 b2hy+bmGAx9NE1hlrotTisZIT3y/bRaqW2QB3jJYhK1697DF5lD8Fuon+K6Nl7DbHwgn
 AAgw==
X-Gm-Message-State: ANhLgQ1X5ea9VmdlhzTMNnamQ6XK2ic5M1ZRXavrd5p+ytgkky+rEHlg
 K8dt83mpByJl7t9nVTgwaa7m2w==
X-Google-Smtp-Source: ADFU+vu2BwVlJ/z2C8XR7GuNqHPcvrDYuSW70Gsa5PRrlPgFIIEEdN81oD/hv1UjzmKlfbVNO9GZjg==
X-Received: by 2002:a1c:7f86:: with SMTP id a128mr5012462wmd.185.1583511326318; 
 Fri, 06 Mar 2020 08:15:26 -0800 (PST)
Received: from myrica ([2001:171b:c9a8:fbc0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id i21sm3449182wmb.23.2020.03.06.08.15.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2020 08:15:25 -0800 (PST)
Date: Fri, 6 Mar 2020 17:15:19 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH v4 01/26] mm/mmu_notifiers: pass private data down to
 alloc_notifier()
Message-ID: <20200306161519.GB99609@myrica>
References: <20200225092439.GB375953@myrica> <20200225140814.GW31668@ziepe.ca>
 <20200228143935.GA2156@myrica> <20200228144844.GQ31668@ziepe.ca>
 <20200228150427.GF2156@myrica> <20200228151339.GS31668@ziepe.ca>
 <20200306095614.GA50020@myrica> <20200306130919.GJ31668@ziepe.ca>
 <20200306143556.GA99609@myrica> <20200306145245.GK31668@ziepe.ca>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200306145245.GK31668@ziepe.ca>
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

On Fri, Mar 06, 2020 at 10:52:45AM -0400, Jason Gunthorpe wrote:
> On Fri, Mar 06, 2020 at 03:35:56PM +0100, Jean-Philippe Brucker wrote:
> > On Fri, Mar 06, 2020 at 09:09:19AM -0400, Jason Gunthorpe wrote:
> > > On Fri, Mar 06, 2020 at 10:56:14AM +0100, Jean-Philippe Brucker wrote:
> > > > I tried to keep it simple like that: normally mmu_notifier_get() is called
> > > > in bind(), and mmu_notifier_put() is called in unbind(). 
> > > > 
> > > > Multiple device drivers may call bind() with the same mm. Each bind()
> > > > calls mmu_notifier_get(), obtains the same io_mm, and returns a new bond
> > > > (a device<->mm link). Each bond is freed by calling unbind(), which calls
> > > > mmu_notifier_put().
> > > > 
> > > > That's the most common case. Now if the process is killed and the mm
> > > > disappears, we do need to avoid use-after-free caused by DMA of the
> > > > mappings and the page tables. 
> > > 
> > > This is why release must do invalidate all - but it doesn't need to do
> > > any more - as no SPTE can be established without a mmget() - and
> > > mmget() is no longer possible past release.
> > 
> > In our case we don't have SPTEs, the whole pgd is shared between MMU and
> > IOMMU (isolated using PASID tables).
> 
> Okay, but this just means that 'invalidate all' also requires
> switching the PASID to use some pgd that is permanently 'all fail'.
> 
> > At this point no one told the device to stop working on this queue,
> > it may still be doing DMA on this address space.
> 
> Sure, but there are lots of cases where a defective user space can
> cause pages under active DMA to disappear, like munmap for
> instance. Process exit is really no different, the PASID should take
> errors and the device & driver should do whatever error flow it has.

We do have the possibility to shut things down in order, so to me this
feels like a band-aid. The idea has come up before though [1], and I'm not
strongly opposed to this model, but I'm still not convinced it's
necessary. It does add more complexity to IOMMU drivers, to avoid printing
out the errors that we wouldn't otherwise see, whereas device drivers need
in any case to implement the logic that forces stop DMA.

Thanks,
Jean

[1] https://lore.kernel.org/linux-iommu/4d68da96-0ad5-b412-5987-2f7a6aa796c3@amd.com/

> 
> Involving a complex driver flow in the exit_mmap path seems like
> dangerous complexity to me.
> 
> Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
