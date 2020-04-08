Return-Path: <SRS0=CWSE=5Y=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DCCAC2D0F4
	for <iommu@archiver.kernel.org>; Wed,  8 Apr 2020 19:02:33 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E3392075E
	for <iommu@archiver.kernel.org>; Wed,  8 Apr 2020 19:02:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="iKZdVLlm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E3392075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id D2EA188306;
	Wed,  8 Apr 2020 19:02:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FLHqQDyl0yNb; Wed,  8 Apr 2020 19:02:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 42ACA856B6;
	Wed,  8 Apr 2020 19:02:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2167BC1D7E;
	Wed,  8 Apr 2020 19:02:32 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7C432C0177
 for <iommu@lists.linux-foundation.org>; Wed,  8 Apr 2020 19:02:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 654B688306
 for <iommu@lists.linux-foundation.org>; Wed,  8 Apr 2020 19:02:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jv1EyI9CYwWu for <iommu@lists.linux-foundation.org>;
 Wed,  8 Apr 2020 19:02:29 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-qv1-f65.google.com (mail-qv1-f65.google.com
 [209.85.219.65])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 9C74A856B6
 for <iommu@lists.linux-foundation.org>; Wed,  8 Apr 2020 19:02:29 +0000 (UTC)
Received: by mail-qv1-f65.google.com with SMTP id w26so701978qvd.10
 for <iommu@lists.linux-foundation.org>; Wed, 08 Apr 2020 12:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=wmZQJl1c8KNXXGGe/GQg8T/tvo9g582t9MAA5jK4wfg=;
 b=iKZdVLlmzPaid2T0oVGdZog7Pd7AiPe2km7Fg3sR0wh1yb/AJai1ESSU82FKz79FYD
 Mef1LhgRdLsFyhU4YlVNtTe88wSQSA1cnjbdyRI+myYv5h9nOacgJx25HbuY+OkAg5vh
 iMTdqGiSbGYzrhuYQS8c2VRlKL6THdwyN4emB1KMt0Po94kGPePRnpVzIcX++Xt3V5Im
 7Ym1WYFFy/lF9T2H8pFmujE5sjduhyCEy1iNMAst4uWpVk/omYmdtDo2zUUXhefn4kWq
 WZSYwtjwMw4iCA2m+qYRqEJswj6VSJ5oPxX1E1Sj4PdEtfPxaJaiUodrESLZkzHtrORQ
 n0XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=wmZQJl1c8KNXXGGe/GQg8T/tvo9g582t9MAA5jK4wfg=;
 b=cv1CMPzPC9SE00jISKZ9lNQevMVgLQrBTSKOjRqG8fEfHC9lg0g0r+bO2EfwvQzyQi
 /0/GqCCV1jJBbel7AsjNmqgtSFBbhY274I2DNel9vrppyeGAVEuaa9a3F5Wx17ELJ28o
 AXlljfGUMoLwI+jZxgg1aH3/i9OpMtvSSi22bkpkNGxDMnhmEoAaBMTprx6VaScSzNnS
 9gU8ZU61dEMPPBUMHohpZOVeNNlavLsQv+a3fbBIw8GHOh++OC3LalKOEBpFiZ0B4L/d
 ut2Ibmtc4Z5Jgbw+wvaRiU/gyUFqCAjmYF8obD1Xj+iRjvRHUOR/9Gyj4yz+i+pIlQZQ
 9ogg==
X-Gm-Message-State: AGi0Puatjv2nsNMkP2m0EGl18AuqQXuooUM15OpG34lpe4QhP7dSTJuW
 H+lSh4EjA33K+50LS8GmwPqwyQ==
X-Google-Smtp-Source: APiQypKTUf6t3DH5r2pxOWHjSz6cbLk1+4lwMdAn7tIQAb4eFo1dUVmlL28uN2EIIJmkYwX8yKG0kA==
X-Received: by 2002:a0c:b896:: with SMTP id y22mr8943351qvf.182.1586372548492; 
 Wed, 08 Apr 2020 12:02:28 -0700 (PDT)
Received: from ziepe.ca
 (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.68.57.212])
 by smtp.gmail.com with ESMTPSA id o187sm9353041qkb.40.2020.04.08.12.02.27
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 08 Apr 2020 12:02:27 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
 (envelope-from <jgg@ziepe.ca>)
 id 1jMFxy-0000qT-V7; Wed, 08 Apr 2020 16:02:26 -0300
Date: Wed, 8 Apr 2020 16:02:26 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH 0/2] iommu: Remove iommu_sva_ops::mm_exit()
Message-ID: <20200408190226.GA11886@ziepe.ca>
References: <20200408140427.212807-1-jean-philippe@linaro.org>
 <20200408113552.7888bfee@jacob-builder>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200408113552.7888bfee@jacob-builder>
User-Agent: Mutt/1.9.4 (2018-02-28)
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, arnd@arndb.de,
 gregkh@linuxfoundation.org, iommu@lists.linux-foundation.org,
 zhangfei.gao@linaro.org, linux-accelerators@lists.ozlabs.org
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

On Wed, Apr 08, 2020 at 11:35:52AM -0700, Jacob Pan wrote:
> Hi Jean,
> 
> On Wed,  8 Apr 2020 16:04:25 +0200
> Jean-Philippe Brucker <jean-philippe@linaro.org> wrote:
> 
> > The IOMMU SVA API currently requires device drivers to implement an
> > mm_exit() callback, which stops device jobs that do DMA. This function
> > is called in the release() MMU notifier, when an address space that is
> > shared with a device exits.
> > 
> > It has been noted several time during discussions about SVA that
> > cancelling DMA jobs can be slow and complex, and doing it in the
> > release() notifier might cause synchronization issues (patch 2 has
> > more background). Device drivers must in any case call unbind() to
> > remove their bond, after stopping DMA from a more favorable context
> > (release of a file descriptor).
> > 
> > So after mm exits, rather than notifying device drivers, we can hold
> > on to the PASID until unbind(), ask IOMMU drivers to silently abort
> > DMA and Page Requests in the meantime. This change should relieve the
> > mmput() path.
>
> I assume mm is destroyed after all the FDs are closed

FDs do not hold a mmget(), but they may hold a mmgrab(), ie anything
using mmu_notifiers has to hold a grab until the notifier is
destroyed, which is often triggered by FD close.

So the exit_mmap() -> release() may happen before the FDs are
destroyed, but the final mmdrop() will be during some FD release when
the final mmdrop() happens.

But, in all the drivers I've looked at the PASID and the mmu_notifier
must have identical lifetimes.

> In VT-d, because of enqcmd and lazy PASID free we plan to hold on to the
> PASID until mmdrop.
> https://lore.kernel.org/patchwork/patch/1217762/

Why? The bind already gets a mmu_notifier which has refcounts and the
right lifetime for PASID.. This code could already be simplified by
using the mmu_notifier_get()/put() stuff.

A reason to store the PASID in the mm_struct would be if some code
needs fast access to it, but then I'm not sure how that works with
SVM_FLAG_PRIVATE_PASID ..

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
