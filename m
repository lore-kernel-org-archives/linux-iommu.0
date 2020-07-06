Return-Path: <SRS0=S+y3=AR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34D0AC433E1
	for <iommu@archiver.kernel.org>; Mon,  6 Jul 2020 10:32:01 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1C9120772
	for <iommu@archiver.kernel.org>; Mon,  6 Jul 2020 10:32:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bytgTj0I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1C9120772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 90AC22151E;
	Mon,  6 Jul 2020 10:32:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LHDdTuP9lFex; Mon,  6 Jul 2020 10:31:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id E302820522;
	Mon,  6 Jul 2020 10:31:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D1E94C1798;
	Mon,  6 Jul 2020 10:31:57 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B7F71C0891
 for <iommu@lists.linux-foundation.org>; Mon,  6 Jul 2020 10:31:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 684CF20522
 for <iommu@lists.linux-foundation.org>; Mon,  6 Jul 2020 10:30:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iZqaKQDSmlxG for <iommu@lists.linux-foundation.org>;
 Mon,  6 Jul 2020 10:30:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com
 [209.85.208.46])
 by silver.osuosl.org (Postfix) with ESMTPS id 557782000B
 for <iommu@lists.linux-foundation.org>; Mon,  6 Jul 2020 10:30:55 +0000 (UTC)
Received: by mail-ed1-f46.google.com with SMTP id e22so34265569edq.8
 for <iommu@lists.linux-foundation.org>; Mon, 06 Jul 2020 03:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=guZYpzX8YFjpu7IK/QjLRK3HdD06qZ9ZoBhsUhNn6Sk=;
 b=bytgTj0IMzpwxhqKqf3QYbeqTVEHhBhmq/Ar+h4+MFlR42vkVcbQP2yUpXU+pMY/6F
 0UVl9BnSl5H8/4PkiciR3NwWtNcc4Ly7Gn5hLFKj/YPsmifKGQXdygfwPZDIQ15JvNyH
 GlXkz6zJ5odofMl4agFQy4FMHzJpRLV9CD1GuKrFj87blLMuZKEt+fpE7KvJgbEemGsr
 SxolseD7RnsMtr3PO3+Isihk1JZpI9rl8ADH2vfQpVfmjIX1OF9HrTA5jlnTIxKj5/he
 14ViKqi2Q6Dq7EO10e2+tPn1avArbC9dJ8EDuX56k6nv4fvCrfpuREWd7V45L/36m6nf
 pUVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=guZYpzX8YFjpu7IK/QjLRK3HdD06qZ9ZoBhsUhNn6Sk=;
 b=IVbrqm+Fo9XVli8crUzVuijfhbJccEdm14IMq6Ru5gJlxjXkcBL6ZQAD3Pwu0+EtRX
 oNq30D5Ll1OpOV9hgao2+jZEDgkolNajvyRIzwLZxuWs19qp3ZZjp5x+lVnY+5im2MxG
 vzkOoMBKw1ekRSPuuABUNpk/xCvn1jtlYEBtocwz0L3tjfAX+I5TsMbZZzh5v+9y8YaG
 9rs6I1KJFBtOZB6u0dzZNuCLhE6eZAlz9YSrk+yAxo652XaIb3dcLXCz1D63QKN8PPO1
 DxhSMUtN4SlsrV4Q7J4q+JIOdbEIi4EenPNTEOb2cf8QcHkKyEq7ujs+8jn0v4QTaS16
 Q/lQ==
X-Gm-Message-State: AOAM533Jcm6mqZrmIj3s9H0QopySFtxqpHEAUq/sP92vaRnYZG/9axEM
 A1xkeqrurXF8Kfk++mTDlfK8LQ==
X-Google-Smtp-Source: ABdhPJzMZAsDl25f1drfa2xcV58dXfanc9gOgL7EOslPt4eotm8WH+2PBHU9F6ftyEmF4LV/+T9dgg==
X-Received: by 2002:a50:cf43:: with SMTP id d3mr57657274edk.40.1594031453591; 
 Mon, 06 Jul 2020 03:30:53 -0700 (PDT)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id v11sm16153406eja.113.2020.07.06.03.30.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2020 03:30:52 -0700 (PDT)
Date: Mon, 6 Jul 2020 12:30:41 +0200
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: IOASID set token
Message-ID: <20200706103041.GA3214@myrica>
References: <20200701232916.38fd7908@jacob-builder>
 <20200702064825.20f9d2b1@jacob-builder>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200702064825.20f9d2b1@jacob-builder>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, "Lu,
 Baolu" <baolu.lu@intel.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Wu,
 Hao" <hao.wu@intel.com>
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

Hi Jacob,

On Thu, Jul 02, 2020 at 06:48:25AM -0700, Jacob Pan wrote:
> Hi Jean,
> 
> Just realized I should send this to your Linaro account instead of ARM.
> So Hi again :)
> 
> On Wed, 1 Jul 2020 23:29:16 -0700
> Jacob Pan <jacob.jun.pan@linux.intel.com> wrote:
> 
> > Hi Jean,
> > 
> > Have a question for you on whether we can have a fixed token type for
> > ioasid_set.
> > 
> > Currently, ioasid_set has an arbitrary token. For VT-d vSVA usage, we
> > choose mm as ioasid_set token to identify PASIDs within a guest. We
> > have multiple in-kernel users of PASIDs such as VFIO, KVM, and VDCM.
> > When an IOASID set is created, there is not a good way to communicate
> > about the token choices. So we have to let VDCM and KVM *assume* mm
> > is used as token, then retrieve ioasid_set based on the token.
> > 
> > This assumption of "mm as token" is not a reliable SW architecture.

I don't see this as a problem. The token type is tied to the IOASID set,
so users that pass those IOASID sets to ioasid_find() can safely assume
that the returned pointer is an mm_struct. That said I'm not opposed to
consolidating the API with explicit types, it could definitely be more
elegant.

> > So
> > we are thinking if we can have an explicit ioasid_set token type where
> > mm is used. After all, PASID and mm are closely related.
> > 
> > The code change might be the following:
> > 1. add a flag to indicate token type when ioasid_set is allocated,
> > e.g. IOASID_SET_TYPE_MM
> > IOASID_SET_TYPE_ANY
> > 2. other users of the ioasid_set can query if an mm token exists based
> > on the flag IOASID_SET_TYPE_MM, then retrieve the ioasid_set.
> > 
> > Existing ioasid_set user can still use arbitrary token under the flag
> > IOASID_SET_TYPE_ANY
> > 
> > Would this be an issue for ARM usage?

In my current implementation of auxiliary domains for Arm SMMU (which
might never be useful enough to go upstream) I don't even use a token for
the private IOASID set. However I still think we should leave the option
to use a type different than mm_struct as token for some IOASID sets
because device drivers (e.g. AMD kfd) may also want to dip into the IOASID
space and use their own token type.

For the moment, though, we could actually specialize the IOASID API to
only take an mm_struct as token. For example the functions exported by the
IOASID lib would be:

  ioasid_t ioasid_alloc_mm(set, min, max, struct mm_struct *mm)
  struct mm_struct *ioasid_find_mm(set, ioasid)
  ...

And ioasid_alloc(), ioasid_find(), etc would be internal to ioasid.c and
deal with IOASID_SET_TYPE_MM (or even be removed entirely for now). New
users that need different token types could then introduce their own
IOASID_SET_TYPE_* and use the lower-level functions.

Thanks,
Jean
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
