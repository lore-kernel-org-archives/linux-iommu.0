Return-Path: <SRS0=cOz4=6E=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FBCCC3815B
	for <iommu@archiver.kernel.org>; Mon, 20 Apr 2020 08:02:52 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6642206D5
	for <iommu@archiver.kernel.org>; Mon, 20 Apr 2020 08:02:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tKclP/kz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6642206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id A299A85A80;
	Mon, 20 Apr 2020 08:02:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VVPy7A_P8GQR; Mon, 20 Apr 2020 08:02:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 11B20859F4;
	Mon, 20 Apr 2020 08:02:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ED585C07FF;
	Mon, 20 Apr 2020 08:02:50 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CA5F2C0177
 for <iommu@lists.linux-foundation.org>; Mon, 20 Apr 2020 08:02:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id B517885A80
 for <iommu@lists.linux-foundation.org>; Mon, 20 Apr 2020 08:02:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VCkDvgqYyUcy for <iommu@lists.linux-foundation.org>;
 Mon, 20 Apr 2020 08:02:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com
 [209.85.221.68])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 5DCA1859F4
 for <iommu@lists.linux-foundation.org>; Mon, 20 Apr 2020 08:02:48 +0000 (UTC)
Received: by mail-wr1-f68.google.com with SMTP id t14so10852892wrw.12
 for <iommu@lists.linux-foundation.org>; Mon, 20 Apr 2020 01:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=UewxKsBAJJewfkJUMKHAk+NHtgTRHDA841ZwOvO2wII=;
 b=tKclP/kzfr0db6nc9Mi2O+K2adr/YqoP5585eRqRJtwkSEMU34ZWe7taODLE9U5/1f
 jpf2YPNw+y52462WKfXLZMQ5gnE4OxZJkDwvho2S/8W2elSP+i18X843PY1NCu4T7Dhr
 fU3r/BE+G20f7nOj7EgdnrQ/2FabsQ5lDzQ5w0irgj9LbdjetrLcFRjbvFS/RdsKzDeC
 LmtewgcDluLqipXtS2WaZBUapwWn2mENl7Kez7BhEbGM0LRDV0BeUwaRJ6wcdCAdIZX1
 BWs6zL7HJPf/93FrXEn6fP2afKKlLkzHzgX0bjzRjc/qrorrsmrjHknrgLnWo3vFsZBf
 FZ+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=UewxKsBAJJewfkJUMKHAk+NHtgTRHDA841ZwOvO2wII=;
 b=Cz+sMW6Wa+zrjbF08exmS+fqsJ+PhA3AwMwB1rZqlsrizJlkvlAsKHwdTy9SKH54eE
 UpSfnoAKQSZmYBkL5IuwSciYyAGIl2M4jjq3p0abUcM0Zu3q4aQx/ZPyoOHJVhV6EIjR
 WRgPoivGuzJuzrmk6TKw+lljAeRZ7Edi+ilUJQo9e8PhMmrVBQIWuUU6epEZOnAB58V9
 74rvg08FpOyW5Qnhvzps/3gb19h0omA3k/wQsLgVN7AxdrMCFliHnQRzHUxzajGkc/CL
 CUOMm+LvsZ42SpZKdWPJJLpqT9z6Mz9EyZf7LZ14fpvuOuRsA+MW5C5eYDVIdBFVOIiu
 QL3Q==
X-Gm-Message-State: AGi0PuZsIwBgh4M+DSAchjt5A2aWKhK8FnvfvruqZ6TbIFUzYbiZZXYn
 Gjr5EETCCyDtPSdZNfr4phTVZg==
X-Google-Smtp-Source: APiQypI3fsMFHnyeYpkHXCnJEp6APcmFiAV2+shbajM3XxWk4IvHZ1bdz8ojbqKm232sBAneJmSJfQ==
X-Received: by 2002:adf:e982:: with SMTP id h2mr16628968wrm.425.1587369766674; 
 Mon, 20 Apr 2020 01:02:46 -0700 (PDT)
Received: from myrica ([2001:171b:226b:54a0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id e15sm119004wrt.16.2020.04.20.01.02.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Apr 2020 01:02:46 -0700 (PDT)
Date: Mon, 20 Apr 2020 10:02:37 +0200
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH 0/2] iommu: Remove iommu_sva_ops::mm_exit()
Message-ID: <20200420080237.GB3180232@myrica>
References: <20200408190226.GA11886@ziepe.ca>
 <20200408143552.57f5837c@jacob-builder>
 <20200408223218.GC11886@ziepe.ca>
 <20200408164802.155a69e3@jacob-builder>
 <20200409063905.GA2435@myrica>
 <20200409071424.1653b889@jacob-builder>
 <20200409145058.GB69482@myrica>
 <20200410085249.04eeae4e@jacob-builder>
 <20200415074736.GA718903@myrica>
 <20200416135829.233cf9cf@jacob-builder>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200416135829.233cf9cf@jacob-builder>
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

On Thu, Apr 16, 2020 at 01:58:29PM -0700, Jacob Pan wrote:
> On Wed, 15 Apr 2020 09:47:36 +0200
> Jean-Philippe Brucker <jean-philippe@linaro.org> wrote:
> 
> > On Fri, Apr 10, 2020 at 08:52:49AM -0700, Jacob Pan wrote:
> > > On Thu, 9 Apr 2020 16:50:58 +0200
> > > Jean-Philippe Brucker <jean-philippe@linaro.org> wrote:
> > >   
> > > > > So unbind is coming anyway, the difference in handling in mmu
> > > > > release notifier is whether we silently drop DMA fault vs.
> > > > > reporting fault?    
> > > > 
> > > > What I meant is, between mmu release notifier and unbind(), we
> > > > can't print any error from DMA fault on dmesg, because an mm exit
> > > > is easily triggered by userspace. Look at the lifetime of the
> > > > bond:
> > > > 
> > > > bind()
> > > >  |
> > > >  : Here any DMA fault is handled by mm, and on error we don't
> > > > print : anything to dmesg. Userspace can easily trigger faults by
> > > > issuing DMA : on unmapped buffers.
> > > >  |
> > > > mm exit -> clear pgd, invalidate IOTLBs
> > > >  |
> > > >  : Here the PASID descriptor doesn't have the pgd anymore, but we
> > > > don't : print out any error to dmesg either. DMA is likely still
> > > > running but : any fault has to be ignored.
> > > >  :
> > > >  : We also can't free the PASID yet, since transactions are still
> > > > coming : in with this PASID.
> > > >  |
> > > > unbind() -> clear context descriptor, release PASID and mmu
> > > > notifier |
> > > >  : Here the PASID descriptor is clear. If DMA is still running the
> > > > device : driver really messed up and we have to print out any
> > > > fault.
> > > > 
> > > > For that middle state I had to introduce a new pasid descriptor
> > > > state in the SMMU driver, to avoid reporting errors between mm
> > > > exit and unbind().  
> > > I must have missed something, but why bother with a state when you
> > > can always check if the mm is dead by mmget_not_zero()? You would
> > > not handle IOPF if the mm is dead anyway, similarly for other DMA
> > > errors.  
> > 
> > In the SMMU a cleared PASID descriptor results in unrecoverable
> > faults, which do not go through the I/O page fault handler. I've been
> > thinking about injecting everything to the IOPF handler, recoverable
> > or not, but filtering down the stream is complicated. Most of the
> > time outside this small window, we really need to print out those
> > messages because they would indicate serious bugs.
> > 
> VT-d also results in unrecoverable fault for a cleared PASID. I am
> assuming in the fault record, SMMU can also identify the PASID and
> source ID. So that should be able to find the matching mm.
> Then you can check if the mm is defunct?

I'd rather not add a PASID lookup in the SMMU event thread, as that
function needs to be fast and there already is a PASID lookup in the IOPF
worker

> > > Also, since you are not freeing ioasid in mmu_notifier release
> > > anymore, does it mean the IOASID notifier chain can be non-atomic?  
> > 
> > Unfortunately not, ioasid_free() is called from
> > mmu_notifier_ops::free_notifier() in the RCU callback that results
> > from mmu_notifier_put(). 
> > 
> I agree. I looked at the code, it is much more clean with the
> mmu_notifier_get/put.
> 
> I am thinking perhaps adding a reclaim mechanism such that IOASID not
> directly freed can stay in an in_active list (while waiting for its
> states get cleared) until it can be reclaimed. Do you see this is
> useful for SMMU?

Probably not useful for SMMU, but I don't see any issue with adding it. 

> This is useful for VT-d, since we have more consumers for a given PASID,
> i.e. VMCS, VDCM, and IOMMU. Each consumer has its own PASID context to
> clean up.

Right I'm still having trouble understanding the whole picture, will need
to read more about this. The main point is not adding too much work in the
mm exit path.

Thanks,
Jean
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
