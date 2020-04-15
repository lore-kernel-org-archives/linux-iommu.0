Return-Path: <SRS0=YkH/=57=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57031C2BA19
	for <iommu@archiver.kernel.org>; Wed, 15 Apr 2020 07:47:50 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC21C20768
	for <iommu@archiver.kernel.org>; Wed, 15 Apr 2020 07:47:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TDBhmMLC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC21C20768
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 89F4785F8E;
	Wed, 15 Apr 2020 07:47:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IM2IX-5poWfn; Wed, 15 Apr 2020 07:47:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id E2E5885F6E;
	Wed, 15 Apr 2020 07:47:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CA762C1D7D;
	Wed, 15 Apr 2020 07:47:48 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 30052C0172
 for <iommu@lists.linux-foundation.org>; Wed, 15 Apr 2020 07:47:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 268B186CF0
 for <iommu@lists.linux-foundation.org>; Wed, 15 Apr 2020 07:47:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nQgt8J7xHfx5 for <iommu@lists.linux-foundation.org>;
 Wed, 15 Apr 2020 07:47:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com
 [209.85.128.68])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 25B0886C94
 for <iommu@lists.linux-foundation.org>; Wed, 15 Apr 2020 07:47:47 +0000 (UTC)
Received: by mail-wm1-f68.google.com with SMTP id y24so17696333wma.4
 for <iommu@lists.linux-foundation.org>; Wed, 15 Apr 2020 00:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=zxP+vrc6HAuh67yKoPp3KLX+JghVINugrAZp8NdkjBI=;
 b=TDBhmMLCzJjXj8kNLjcPVE7qowZPaJn4q6iKX8rf+66TJr/K/cZTXjOvBQGn6fSFAb
 YS76eNDI7y/5dtrMOgUEChFhSuWj0MOUVfrmc5Swfpv+0EvfdtcCkAVIf/gazdaY0TnK
 U9lRas0EYkFAPlsJmpSskidjxvxeOPwEEJLbY2yu9UYSeZRZ6kw7BMWOo8wuvVpqEJbt
 IBeb3QAebMgFCws/95Wrx1WPuvMNWvr0Sn2rpXBgX2Xs5WmDjWwnhftXbANP7g61hPMV
 a+wx+fh26TAN6EOokz73fGL0HSonpZkj90rU/9lHJ4oIWXQUlAtK958rVV24HMIEl2dK
 SZcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=zxP+vrc6HAuh67yKoPp3KLX+JghVINugrAZp8NdkjBI=;
 b=S40l0AWXB9XSbrFGnh5e/Aehsg8+nZ6l8gOy+ZFeWVLrZbW9BN5bBHGpaSqZfBgNiK
 1CXwiI8Omd7s0SRyGnFTQw7uB2pmxORMn7IxHb0aN0wEaGWy9tdmyXA5tvbv9yZBId/a
 6clvawW11LXJa+GsZEmer7iKH9dVrNDbg1S5vQTLBuiqFxHxjNfZfNrBzL3X2lkMjUXJ
 9Hf/6c5mL+KrdvuxHQgkJkoGa7XFPQJI/X7ADttlSQSxCeBkFh3MMiTw7WtdrJ+TpaEQ
 yFBVLldWa9/1Dqjp667JXUF6R7dX+nvEnQKUn59m4uzr4o0qov7H9C19/8w/1RdSYHGY
 2Juw==
X-Gm-Message-State: AGi0PubIErJW0kzKlUS7dY+J+wU+zd2tnJJ/pNGtmcGbP/ZwUE4SVx4z
 3K9dwoICGukPAYuGHpKsc/j+Jw==
X-Google-Smtp-Source: APiQypIXrmOKiqRu3yQHzfL5uL/l1ADwIXLNxpdUOczAtk1Dm9UmLS4y04gx727dlj++eJFT38A40w==
X-Received: by 2002:a7b:c190:: with SMTP id y16mr4057172wmi.50.1586936865557; 
 Wed, 15 Apr 2020 00:47:45 -0700 (PDT)
Received: from myrica ([2001:171b:226b:54a0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id s24sm20715125wmj.28.2020.04.15.00.47.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Apr 2020 00:47:44 -0700 (PDT)
Date: Wed, 15 Apr 2020 09:47:36 +0200
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH 0/2] iommu: Remove iommu_sva_ops::mm_exit()
Message-ID: <20200415074736.GA718903@myrica>
References: <20200408140427.212807-1-jean-philippe@linaro.org>
 <20200408113552.7888bfee@jacob-builder>
 <20200408190226.GA11886@ziepe.ca>
 <20200408143552.57f5837c@jacob-builder>
 <20200408223218.GC11886@ziepe.ca>
 <20200408164802.155a69e3@jacob-builder>
 <20200409063905.GA2435@myrica>
 <20200409071424.1653b889@jacob-builder>
 <20200409145058.GB69482@myrica>
 <20200410085249.04eeae4e@jacob-builder>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200410085249.04eeae4e@jacob-builder>
Cc: "Yu, Fenghua" <fenghua.yu@intel.com>, arnd@arndb.de,
 gregkh@linuxfoundation.org, iommu@lists.linux-foundation.org,
 Jason Gunthorpe <jgg@ziepe.ca>, zhangfei.gao@linaro.org,
 linux-accelerators@lists.ozlabs.org
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

On Fri, Apr 10, 2020 at 08:52:49AM -0700, Jacob Pan wrote:
> On Thu, 9 Apr 2020 16:50:58 +0200
> Jean-Philippe Brucker <jean-philippe@linaro.org> wrote:
> 
> > > So unbind is coming anyway, the difference in handling in mmu
> > > release notifier is whether we silently drop DMA fault vs.
> > > reporting fault?  
> > 
> > What I meant is, between mmu release notifier and unbind(), we can't
> > print any error from DMA fault on dmesg, because an mm exit is easily
> > triggered by userspace. Look at the lifetime of the bond:
> > 
> > bind()
> >  |
> >  : Here any DMA fault is handled by mm, and on error we don't print
> >  : anything to dmesg. Userspace can easily trigger faults by issuing
> > DMA : on unmapped buffers.
> >  |
> > mm exit -> clear pgd, invalidate IOTLBs
> >  |
> >  : Here the PASID descriptor doesn't have the pgd anymore, but we
> > don't : print out any error to dmesg either. DMA is likely still
> > running but : any fault has to be ignored.
> >  :
> >  : We also can't free the PASID yet, since transactions are still
> > coming : in with this PASID.
> >  |
> > unbind() -> clear context descriptor, release PASID and mmu notifier
> >  |
> >  : Here the PASID descriptor is clear. If DMA is still running the
> > device : driver really messed up and we have to print out any fault.
> > 
> > For that middle state I had to introduce a new pasid descriptor state
> > in the SMMU driver, to avoid reporting errors between mm exit and
> > unbind().
> I must have missed something, but why bother with a state when you can
> always check if the mm is dead by mmget_not_zero()? You would not
> handle IOPF if the mm is dead anyway, similarly for other DMA errors.

In the SMMU a cleared PASID descriptor results in unrecoverable faults,
which do not go through the I/O page fault handler. I've been thinking
about injecting everything to the IOPF handler, recoverable or not, but
filtering down the stream is complicated. Most of the time outside this
small window, we really need to print out those messages because they
would indicate serious bugs.

> Also, since you are not freeing ioasid in mmu_notifier release anymore,
> does it mean the IOASID notifier chain can be non-atomic?

Unfortunately not, ioasid_free() is called from
mmu_notifier_ops::free_notifier() in the RCU callback that results from
mmu_notifier_put(). 

Thanks,
Jean
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
