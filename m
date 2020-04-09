Return-Path: <SRS0=CVo8=5Z=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DF43C2BB86
	for <iommu@archiver.kernel.org>; Thu,  9 Apr 2020 17:26:45 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44F1620768
	for <iommu@archiver.kernel.org>; Thu,  9 Apr 2020 17:26:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SMSIs7zB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44F1620768
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 1B3F886632;
	Thu,  9 Apr 2020 17:26:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nzwrQIXTsefT; Thu,  9 Apr 2020 17:26:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 7EAA2864CF;
	Thu,  9 Apr 2020 17:26:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5EBF1C1D87;
	Thu,  9 Apr 2020 17:26:44 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A64C0C0177
 for <iommu@lists.linux-foundation.org>; Thu,  9 Apr 2020 17:08:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id A1EC986AC8
 for <iommu@lists.linux-foundation.org>; Thu,  9 Apr 2020 17:08:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id s4hZStf-iqpA for <iommu@lists.linux-foundation.org>;
 Thu,  9 Apr 2020 17:08:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pg1-f194.google.com (mail-pg1-f194.google.com
 [209.85.215.194])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 2103786A94
 for <iommu@lists.linux-foundation.org>; Thu,  9 Apr 2020 17:08:18 +0000 (UTC)
Received: by mail-pg1-f194.google.com with SMTP id g6so5242770pgs.9
 for <iommu@lists.linux-foundation.org>; Thu, 09 Apr 2020 10:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=bQvrRMm1xrJntOiYTsW2Lx5FztmdO0PKJyWqixStKZM=;
 b=SMSIs7zBXCYahuaxAxR+LoWlUnZeIr9zTb2pf+IjX3ssSGO4f/LJ71rs7cs+jdg3O/
 IC2318r5GGhJcELuDl/Ze0uwNXia0OcIjwna6k5blB77mj0Y4XtCiMcbIK8st3rNlQ+e
 osVfwDBBL2rIaU7lZns6ACclP5PoeUh8qegQnwkKt4YjmRM4qERNzP7oJBRDLPzgJljZ
 qy1lKCQ8rFVztGlVzfI/Rkmzy7LEt8LalUdIpP0YHvwYF+bjfC0BE4mFZcwtZ0vyDnDC
 IIFREURwImK0S68ylJtyrSaPkrzDPGZiOeOLFfr2hQJsER61wmNg7KZF/yKS5L8L3Igm
 o7XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :references:mime-version:content-disposition:in-reply-to;
 bh=bQvrRMm1xrJntOiYTsW2Lx5FztmdO0PKJyWqixStKZM=;
 b=NiWNDifC18PIEXorLxnjVkpFZiraonSnW22R+wvnoL60Xf8WI9bM63kQ/EAXvMSdgT
 wl5iNQwOi618RZaUCgNDvwnjOn3tMmacgtBvlF1x6p8NCkkU729fwDgakhk76A7XRImq
 1AcprKsbhp3xPyZ6XXLA5QQP9sXbo+R/Hj+bdFrzDo8Pvkw/ce4oBwXo4FAYmdIZl/gL
 sd9tzSTRXKh51L6Uuak/4nT765k6JVsfrpazO+PWS/WdOKxtImSjk4fy/jt5N0WYdequ
 B+ELqulUcC1pp1iqJfGU3Ub/tnwwJZGYQm1M52OTNgFEGgxi+WNyDAzbOsujWvtdg2Ne
 50Hg==
X-Gm-Message-State: AGi0Pua4xk2XS5v1eLp563gxd8GDACNkgDl2LcZPi/4SYgGGqe9mVQZx
 e8xUopk3jtZW22WZF1Q5Y58=
X-Google-Smtp-Source: APiQypIGXl7ptK897jLts3QdF+EDBFxPJWcYJ6uqbpmOLvOgFWAldqFqZYwLtwgtv4/3t4lh0qbzWw==
X-Received: by 2002:a63:d143:: with SMTP id c3mr401112pgj.171.1586452097545;
 Thu, 09 Apr 2020 10:08:17 -0700 (PDT)
Received: from google.com ([2601:647:4001:3000::50e3])
 by smtp.gmail.com with ESMTPSA id w142sm1167934pff.111.2020.04.09.10.08.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Apr 2020 10:08:16 -0700 (PDT)
Date: Thu, 9 Apr 2020 10:08:13 -0700
From: Minchan Kim <minchan@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 10/28] mm: only allow page table mappings for built-in
 zsmalloc
Message-ID: <20200409170813.GD247701@google.com>
References: <20200408115926.1467567-1-hch@lst.de>
 <20200408115926.1467567-11-hch@lst.de>
 <20200409160826.GC247701@google.com>
 <20200409165030.GG20713@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200409165030.GG20713@hirez.programming.kicks-ass.net>
X-Mailman-Approved-At: Thu, 09 Apr 2020 17:26:42 +0000
Cc: linux-hyperv@vger.kernel.org, David Airlie <airlied@linux.ie>,
 dri-devel@lists.freedesktop.org, linux-mm@kvack.org,
 "K. Y. Srinivasan" <kys@microsoft.com>, Sumit Semwal <sumit.semwal@linaro.org>,
 linux-arch@vger.kernel.org, linux-s390@vger.kernel.org,
 Wei Liu <wei.liu@kernel.org>, Stephen Hemminger <sthemmin@microsoft.com>,
 x86@kernel.org, Christoph Hellwig <hch@lst.de>,
 Laura Abbott <labbott@redhat.com>, Nitin Gupta <ngupta@vflare.org>,
 Daniel Vetter <daniel@ffwll.ch>, Haiyang Zhang <haiyangz@microsoft.com>,
 linaro-mm-sig@lists.linaro.org, bpf@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Christophe Leroy <christophe.leroy@c-s.fr>,
 Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
 sergey.senozhatsky@gmail.com, iommu@lists.linux-foundation.org,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org
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

On Thu, Apr 09, 2020 at 06:50:30PM +0200, Peter Zijlstra wrote:
> On Thu, Apr 09, 2020 at 09:08:26AM -0700, Minchan Kim wrote:
> > On Wed, Apr 08, 2020 at 01:59:08PM +0200, Christoph Hellwig wrote:
> > > This allows to unexport map_vm_area and unmap_kernel_range, which are
> > > rather deep internal and should not be available to modules.
> > 
> > Even though I don't know how many usecase we have using zsmalloc as
> > module(I heard only once by dumb reason), it could affect existing
> > users. Thus, please include concrete explanation in the patch to
> > justify when the complain occurs.
> 
> The justification is 'we can unexport functions that have no sane reason
> of being exported in the first place'.
> 
> The Changelog pretty much says that.

Okay, I hope there is no affected user since this patch.
If there are someone, they need to provide sane reason why they want
to have zsmalloc as module.

Acked-by: Minchan Kim <minchan@kernel.org>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
