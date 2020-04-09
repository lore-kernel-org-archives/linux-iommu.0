Return-Path: <SRS0=CVo8=5Z=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBC54C2D0EA
	for <iommu@archiver.kernel.org>; Thu,  9 Apr 2020 06:39:20 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AA3D20757
	for <iommu@archiver.kernel.org>; Thu,  9 Apr 2020 06:39:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Uk/ak+uU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AA3D20757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 4B66522246;
	Thu,  9 Apr 2020 06:39:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZA4EQqW7Edmv; Thu,  9 Apr 2020 06:39:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 947E9203E3;
	Thu,  9 Apr 2020 06:39:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 87CEAC089F;
	Thu,  9 Apr 2020 06:39:18 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E5702C0177
 for <iommu@lists.linux-foundation.org>; Thu,  9 Apr 2020 06:39:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id DC55420529
 for <iommu@lists.linux-foundation.org>; Thu,  9 Apr 2020 06:39:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cpPQ-cU5E12r for <iommu@lists.linux-foundation.org>;
 Thu,  9 Apr 2020 06:39:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com
 [209.85.128.68])
 by silver.osuosl.org (Postfix) with ESMTPS id 5675A203E3
 for <iommu@lists.linux-foundation.org>; Thu,  9 Apr 2020 06:39:15 +0000 (UTC)
Received: by mail-wm1-f68.google.com with SMTP id x4so560638wmj.1
 for <iommu@lists.linux-foundation.org>; Wed, 08 Apr 2020 23:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=Xw8oFKTCw8UvO1T1xqfqpTmnZOgCyEdPNhItv3mKQzs=;
 b=Uk/ak+uUKrobra/cPfW2wTLbwFPuf3wPq2SmbKKHS3Exg0pmZT763RaDvEC+4H6GTV
 EtrTPhvxc3WZbI4knj6wrrPdtOix0t3KamOMqgbm8hjdQkFCt3r7xLMNFJifw79624s8
 SMGv3LDzUoX3DbJ4rmUcbm1txKOBmjK2J45phjERiny2PFiCIfzTLm+jBmDj32Su4ysT
 +JgqD4dyL6T1Y+LOO0hKTHvpNh4byzbhWBcJPBt5JjA4nx9aDEOCV5/omCktcBs50Hq3
 vIzJT/luQYLuohaNimnnb6l+nKFHRNA1O0+lQN/Nmnl7mQOjmWRPbQSiNKLoXbrYKccm
 shPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Xw8oFKTCw8UvO1T1xqfqpTmnZOgCyEdPNhItv3mKQzs=;
 b=I0eZ4q3aXjcuJg7t3z0MoJ+gG8Os+UX5fHenNQZc0qjX9NafSpRy1pQBia8QEgBc38
 TV0azFsvyldvWDLH/047wVYNisML9HKCCPt9EQyyumELiZJLPDelpBieiehpOg1Myia0
 sRjMQsULi/NGpDY6nxQHGVhidnF2lm0CHSL0gtJUBcj2nOl2XAa7+qJp0dpgt7hAEs6P
 ms92varT8BkxgF5I5BhSU4+8YvnHj0TFyrghzT60oiaut0emgO8D3NO7zairzKZphkRO
 MpOvuvZePluERFK0Rs+3BvNzBFyxcU6cng7FQtUm6tQb/n4Ur9C8T/lOa/0+NIddc6fK
 uYxg==
X-Gm-Message-State: AGi0PuYtZM7LGUh5fcjCwgxmgRXlLomSne6B7ltV3rkL7jv+dY3D6/Ln
 Usdvv1YCxXdQxTtB569YAu6e8A==
X-Google-Smtp-Source: APiQypJMqc16joFNV9Ftn1MtCq9kNeSPLw50/5u8eoNEzS+JZ2LdNdI3gplaQisuTJ3h2/AL7V1zJw==
X-Received: by 2002:a1c:9c47:: with SMTP id f68mr8154209wme.148.1586414353707; 
 Wed, 08 Apr 2020 23:39:13 -0700 (PDT)
Received: from myrica ([2001:171b:226b:54a0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id z3sm2248120wma.22.2020.04.08.23.39.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Apr 2020 23:39:13 -0700 (PDT)
Date: Thu, 9 Apr 2020 08:39:05 +0200
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH 0/2] iommu: Remove iommu_sva_ops::mm_exit()
Message-ID: <20200409063905.GA2435@myrica>
References: <20200408140427.212807-1-jean-philippe@linaro.org>
 <20200408113552.7888bfee@jacob-builder>
 <20200408190226.GA11886@ziepe.ca>
 <20200408143552.57f5837c@jacob-builder>
 <20200408223218.GC11886@ziepe.ca>
 <20200408164802.155a69e3@jacob-builder>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200408164802.155a69e3@jacob-builder>
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

On Wed, Apr 08, 2020 at 04:48:02PM -0700, Jacob Pan wrote:
> On Wed, 8 Apr 2020 19:32:18 -0300
> Jason Gunthorpe <jgg@ziepe.ca> wrote:
> 
> > On Wed, Apr 08, 2020 at 02:35:52PM -0700, Jacob Pan wrote:
> > > > On Wed, Apr 08, 2020 at 11:35:52AM -0700, Jacob Pan wrote:  
> > > > > Hi Jean,
> > > > > 
> > > > > On Wed,  8 Apr 2020 16:04:25 +0200
> > > > > Jean-Philippe Brucker <jean-philippe@linaro.org> wrote:
> > > > >     
> > > > > > The IOMMU SVA API currently requires device drivers to
> > > > > > implement an mm_exit() callback, which stops device jobs that
> > > > > > do DMA. This function is called in the release() MMU
> > > > > > notifier, when an address space that is shared with a device
> > > > > > exits.
> > > > > > 
> > > > > > It has been noted several time during discussions about SVA
> > > > > > that cancelling DMA jobs can be slow and complex, and doing
> > > > > > it in the release() notifier might cause synchronization
> > > > > > issues (patch 2 has more background). Device drivers must in
> > > > > > any case call unbind() to remove their bond, after stopping
> > > > > > DMA from a more favorable context (release of a file
> > > > > > descriptor).
> > > > > > 
> > > > > > So after mm exits, rather than notifying device drivers, we
> > > > > > can hold on to the PASID until unbind(), ask IOMMU drivers to
> > > > > > silently abort DMA and Page Requests in the meantime. This
> > > > > > change should relieve the mmput() path.    
> > > > >
> > > > > I assume mm is destroyed after all the FDs are closed    
> > > > 
> > > > FDs do not hold a mmget(), but they may hold a mmgrab(), ie
> > > > anything using mmu_notifiers has to hold a grab until the
> > > > notifier is destroyed, which is often triggered by FD close.
> > > >   
> > > Sorry, I don't get this. Are you saying we have to hold a mmgrab()
> > > between svm_bind/mmu_notifier_register and
> > > svm_unbind/mmu_notifier_unregister?  
> > 
> > Yes. This is done automatically for the caller inside the mmu_notifier
> > implementation. We now even store the mm_struct pointer inside the
> > notifier.
> > 
> > Once a notifier is registered the mm_struct remains valid memory until
> > the notifier is unregistered.
> > 
> > > Isn't the idea of mmu_notifier is to avoid holding the mm reference
> > > and rely on the notifier to tell us when mm is going away?  
> > 
> > The notifier only holds a mmgrab(), not a mmget() - this allows
> > exit_mmap to proceed, but the mm_struct memory remains.
> > 
> > This is also probably why it is a bad idea to tie the lifetime of
> > something like a pasid to the mmdrop as a evil user could cause a
> > large number of mm structs to be released but not freed, probably
> > defeating cgroup limits and so forth (not sure)
> > 
> > > It seems both Intel and AMD iommu drivers don't hold mmgrab after
> > > mmu_notifier_register.  
> > 
> > It is done internally to the implementation.
> > 
> > > > So the exit_mmap() -> release() may happen before the FDs are
> > > > destroyed, but the final mmdrop() will be during some FD release
> > > > when the final mmdrop() happens.  
> > > 
> > > Do you mean mmdrop() is after FD release?   
> > 
> > Yes, it will be done by the mmu_notifier_unregister(), which should be
> > called during FD release if the iommu lifetime is linked to some FD.
> > 
> > > If so, unbind is called in FD release should take care of
> > > everything, i.e. stops DMA, clear PASID context on IOMMU, flush PRS
> > > queue etc.  
> > 
> > Yes, this is the proper way, when the DMA is stopped and no use of the
> > PASID remains then you can drop the mmu notifier and release the PASID
> > entirely. If that is linked to the lifetime of the FD then forget
> > completely about the mm_struct lifetime, it doesn't matter..
> > 
> Got everything above, thanks a lot.
> 
> If everything is in order with the FD close. Why do we need to 
> "ask IOMMU drivers to silently abort DMA and Page Requests in the
> meantime." in mm_exit notifier? This will be done orderly in unbind
> anyway.

When the process is killed, mm release can happen before fds are released.
If you look at do_exit() in kernel/exit.c:

	exit_mm()
	  mmput()
	   -> mmu release notifier
	...
	exit_files()
	  close_files()
	    fput()
	exit_task_work()
	  __fput()
	   -> unbind()

Thanks,
Jean

> 
> > > Enforcing unbind upon FD close might be a precarious path, perhaps
> > > that is why we have to deal with out of order situation?  
> > 
> > How so? You just put it in the FD release function :)
> > 
> I was thinking some driver may choose to defer unbind in some workqueue
> etc.
> 
> > > > > In VT-d, because of enqcmd and lazy PASID free we plan to hold
> > > > > on to the PASID until mmdrop.
> > > > > https://lore.kernel.org/patchwork/patch/1217762/    
> > > > 
> > > > Why? The bind already gets a mmu_notifier which has refcounts and
> > > > the right lifetime for PASID.. This code could already be
> > > > simplified by using the mmu_notifier_get()/put() stuff.
> > > >   
> > > Yes, I guess mmu_notifier_get()/put() is new :)
> > > +Fenghua  
> > 
> > I was going to convert the intel code when I did many other drivers,
> > but it was a bit too complex..
> > 
> > But the approach is straightforward. Get rid of the mm search list and
> > use mmu_notifier_get(). This returns a singlton notifier for the
> > mm_struct and handles refcounting/etc
> > 
> > Use mmu_notifier_put() during a unbind, it will callback to
> > free_notifier() to do the final frees (ie this is where the pasid
> > should go away)
> > 
> > For the SVM_FLAG_PRIVATE_PASID continue to use mmu_notifier_register,
> > however this can now be mixed with mmu_notifier_put() so the cleanup
> > is the same. A separate ops static struct is needed to create a unique
> > key though
> > 
> > Jason
> 
> [Jacob Pan]
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
