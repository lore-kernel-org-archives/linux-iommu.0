Return-Path: <SRS0=CWSE=5Y=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 737A9C2D0F4
	for <iommu@archiver.kernel.org>; Wed,  8 Apr 2020 22:32:25 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3252120730
	for <iommu@archiver.kernel.org>; Wed,  8 Apr 2020 22:32:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Yg37UVCg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3252120730
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 0442386BBD;
	Wed,  8 Apr 2020 22:32:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7hAytHxD6GC7; Wed,  8 Apr 2020 22:32:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id D50E286B70;
	Wed,  8 Apr 2020 22:32:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B7FD6C1D7E;
	Wed,  8 Apr 2020 22:32:23 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7E4A4C0177
 for <iommu@lists.linux-foundation.org>; Wed,  8 Apr 2020 22:32:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 6B08D85022
 for <iommu@lists.linux-foundation.org>; Wed,  8 Apr 2020 22:32:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rdH5lOr-n+73 for <iommu@lists.linux-foundation.org>;
 Wed,  8 Apr 2020 22:32:21 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-qt1-f195.google.com (mail-qt1-f195.google.com
 [209.85.160.195])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 9D4C984FB1
 for <iommu@lists.linux-foundation.org>; Wed,  8 Apr 2020 22:32:21 +0000 (UTC)
Received: by mail-qt1-f195.google.com with SMTP id i3so1295719qtv.8
 for <iommu@lists.linux-foundation.org>; Wed, 08 Apr 2020 15:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=heWkEG3W+dP90EL0fqKIhj7Bt8Iqsr5ZPYg76zYydNU=;
 b=Yg37UVCgZ+sS/m/qzQRH5W4CviclVKBeDcttHgXkFYLyuxx6LbDpA+b3iOEaOPgXGH
 DI7ZEnrDHYBINHFmuF0i6xRvOthaoJ8CFAWL5T/IbqLBnOsun6rPOA+7vIZBjv6XKUX/
 RnRnUqHS992721sp34YWiZLdHimKBqi34BA7QbRKPf7Z0dzWrlz5WTR5t3HT/OUL5nOi
 NgJd1gXy9OglXhu2HZvyAqnfYkbgQXtIabDnJcMp/50e+vTEMuT+ME/uitpikHssXZMt
 Pw3z5uHRMs6g8/80vV9DjuZnQQM+HeeWjYWbWfUdETflbLPVsEhHYmxLg72MgQq+HBBG
 Fxyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=heWkEG3W+dP90EL0fqKIhj7Bt8Iqsr5ZPYg76zYydNU=;
 b=UKawbAXMQV2zJhWaQ4n5zvD5OWu9bPfBlIMF4LbbKNwOCLvDTwr4N4VdCwl00ca/Uu
 9YkmCTS1T6D3uZUZ09FN52LYwrG1fTqj0s2WTWUYeiYnaB050xeqb0ab7OL4E/p+46Q0
 WS+PZW6TT5CZ0M7CSK1/PEX95NFcakkxGLfkVEcSTYEWCTtuHGvg16LmV/RKtoygGbsv
 pU5sLmp2OsUVDFyNMtByyhUZ/PoWfm8FOgsdyKnzI4SZaFU5nocap4ggMIeBdwntPZpo
 Wii7rnMwNQLIg+dOgfUI9/sMn6L5hSuFOxCfh+aZsHCQTe4qOoSy/VpAtItme+z4wrnl
 UAHw==
X-Gm-Message-State: AGi0Puafvjp2mrt2gZ2yS8aAZzhTP5xFxuNwlxhk8HgjhIdI7tFonXVk
 ESAjBqQ4SQm7fjPJ+TWE6w06pw==
X-Google-Smtp-Source: APiQypLSnW69OZymRLL7tyTZaySVjS5/28/MzL8/KeIOYxOBpSY1bY5RrUEMMg+mZesUcJIV561Q3w==
X-Received: by 2002:ac8:41d1:: with SMTP id o17mr9421997qtm.17.1586385140487; 
 Wed, 08 Apr 2020 15:32:20 -0700 (PDT)
Received: from ziepe.ca
 (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.68.57.212])
 by smtp.gmail.com with ESMTPSA id x68sm20252501qka.129.2020.04.08.15.32.19
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 08 Apr 2020 15:32:19 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
 (envelope-from <jgg@ziepe.ca>)
 id 1jMJF4-00068c-Sa; Wed, 08 Apr 2020 19:32:18 -0300
Date: Wed, 8 Apr 2020 19:32:18 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH 0/2] iommu: Remove iommu_sva_ops::mm_exit()
Message-ID: <20200408223218.GC11886@ziepe.ca>
References: <20200408140427.212807-1-jean-philippe@linaro.org>
 <20200408113552.7888bfee@jacob-builder>
 <20200408190226.GA11886@ziepe.ca>
 <20200408143552.57f5837c@jacob-builder>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200408143552.57f5837c@jacob-builder>
User-Agent: Mutt/1.9.4 (2018-02-28)
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, arnd@arndb.de, "Yu,
 Fenghua" <fenghua.yu@intel.com>, gregkh@linuxfoundation.org,
 iommu@lists.linux-foundation.org, zhangfei.gao@linaro.org,
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

On Wed, Apr 08, 2020 at 02:35:52PM -0700, Jacob Pan wrote:
> > On Wed, Apr 08, 2020 at 11:35:52AM -0700, Jacob Pan wrote:
> > > Hi Jean,
> > > 
> > > On Wed,  8 Apr 2020 16:04:25 +0200
> > > Jean-Philippe Brucker <jean-philippe@linaro.org> wrote:
> > >   
> > > > The IOMMU SVA API currently requires device drivers to implement
> > > > an mm_exit() callback, which stops device jobs that do DMA. This
> > > > function is called in the release() MMU notifier, when an address
> > > > space that is shared with a device exits.
> > > > 
> > > > It has been noted several time during discussions about SVA that
> > > > cancelling DMA jobs can be slow and complex, and doing it in the
> > > > release() notifier might cause synchronization issues (patch 2 has
> > > > more background). Device drivers must in any case call unbind() to
> > > > remove their bond, after stopping DMA from a more favorable
> > > > context (release of a file descriptor).
> > > > 
> > > > So after mm exits, rather than notifying device drivers, we can
> > > > hold on to the PASID until unbind(), ask IOMMU drivers to
> > > > silently abort DMA and Page Requests in the meantime. This change
> > > > should relieve the mmput() path.  
> > >
> > > I assume mm is destroyed after all the FDs are closed  
> > 
> > FDs do not hold a mmget(), but they may hold a mmgrab(), ie anything
> > using mmu_notifiers has to hold a grab until the notifier is
> > destroyed, which is often triggered by FD close.
> > 
> Sorry, I don't get this. Are you saying we have to hold a mmgrab()
> between svm_bind/mmu_notifier_register and
> svm_unbind/mmu_notifier_unregister?

Yes. This is done automatically for the caller inside the mmu_notifier
implementation. We now even store the mm_struct pointer inside the
notifier.

Once a notifier is registered the mm_struct remains valid memory until
the notifier is unregistered.

> Isn't the idea of mmu_notifier is to avoid holding the mm reference and
> rely on the notifier to tell us when mm is going away?

The notifier only holds a mmgrab(), not a mmget() - this allows
exit_mmap to proceed, but the mm_struct memory remains.

This is also probably why it is a bad idea to tie the lifetime of
something like a pasid to the mmdrop as a evil user could cause a
large number of mm structs to be released but not freed, probably
defeating cgroup limits and so forth (not sure)

> It seems both Intel and AMD iommu drivers don't hold mmgrab after
> mmu_notifier_register.

It is done internally to the implementation.

> > So the exit_mmap() -> release() may happen before the FDs are
> > destroyed, but the final mmdrop() will be during some FD release when
> > the final mmdrop() happens.
> 
> Do you mean mmdrop() is after FD release? 

Yes, it will be done by the mmu_notifier_unregister(), which should be
called during FD release if the iommu lifetime is linked to some FD.

> If so, unbind is called in FD release should take care of
> everything, i.e. stops DMA, clear PASID context on IOMMU, flush PRS
> queue etc.

Yes, this is the proper way, when the DMA is stopped and no use of the
PASID remains then you can drop the mmu notifier and release the PASID
entirely. If that is linked to the lifetime of the FD then forget
completely about the mm_struct lifetime, it doesn't matter..

> Enforcing unbind upon FD close might be a precarious path, perhaps
> that is why we have to deal with out of order situation?

How so? You just put it in the FD release function :)

> > > In VT-d, because of enqcmd and lazy PASID free we plan to hold on
> > > to the PASID until mmdrop.
> > > https://lore.kernel.org/patchwork/patch/1217762/  
> > 
> > Why? The bind already gets a mmu_notifier which has refcounts and the
> > right lifetime for PASID.. This code could already be simplified by
> > using the mmu_notifier_get()/put() stuff.
> > 
> Yes, I guess mmu_notifier_get()/put() is new :)
> +Fenghua

I was going to convert the intel code when I did many other drivers,
but it was a bit too complex..

But the approach is straightforward. Get rid of the mm search list and
use mmu_notifier_get(). This returns a singlton notifier for the
mm_struct and handles refcounting/etc

Use mmu_notifier_put() during a unbind, it will callback to
free_notifier() to do the final frees (ie this is where the pasid
should go away)

For the SVM_FLAG_PRIVATE_PASID continue to use mmu_notifier_register,
however this can now be mixed with mmu_notifier_put() so the cleanup
is the same. A separate ops static struct is needed to create a unique
key though

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
