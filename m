Return-Path: <SRS0=Ithz=52=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE1CEC2D0EC
	for <iommu@archiver.kernel.org>; Fri, 10 Apr 2020 03:23:41 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C68F20769
	for <iommu@archiver.kernel.org>; Fri, 10 Apr 2020 03:23:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AVSNgz0e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C68F20769
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 3CBD286D53;
	Fri, 10 Apr 2020 03:23:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OX6+T9Q+ObUR; Fri, 10 Apr 2020 03:23:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id F2B1D85540;
	Fri, 10 Apr 2020 03:23:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D89EDC1D7E;
	Fri, 10 Apr 2020 03:23:39 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 51871C0177
 for <iommu@lists.linux-foundation.org>; Fri, 10 Apr 2020 02:38:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 4767F880CB
 for <iommu@lists.linux-foundation.org>; Fri, 10 Apr 2020 02:38:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GOll-4DnXEoO for <iommu@lists.linux-foundation.org>;
 Fri, 10 Apr 2020 02:38:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com
 [209.85.214.194])
 by hemlock.osuosl.org (Postfix) with ESMTPS id A5F0C87A6B
 for <iommu@lists.linux-foundation.org>; Fri, 10 Apr 2020 02:38:49 +0000 (UTC)
Received: by mail-pl1-f194.google.com with SMTP id m16so226318pls.4
 for <iommu@lists.linux-foundation.org>; Thu, 09 Apr 2020 19:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:date:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=cm3qEVUblIBWQEP7R8pxH+eUa0WNyfWiM9J7eM+Fwmk=;
 b=AVSNgz0eR/mu36t1jtB1pHxzPsuhsLJ5Dgmcn/9c7jPOTV+CNdcyL0zkXP7nLHQzQV
 A10fzku8OWDIGvjGdvgdeH+jWjXzrllDIeVhKdprzXhQynX714rs3Td/tjGR+coEL5Aw
 9O9rN2XFZJ5QvZNpH7rO2zchnfDG/1aaYCeqb4UwllljqxtOrpvrRcKDBEk9COBYQQFO
 1jJAN0Hms3ovic+Bal9KAkQ1W5BRhoTGfKl7mwDWNfIHMcC8IP7152Er0GK1ixcZQijG
 71dIgnkhRybaZPDMrOAJ7jaWMDsjZpbv/oC14bGuigw82SaeZ2oRTYvVKah0eRNKXHb0
 NEUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:date:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=cm3qEVUblIBWQEP7R8pxH+eUa0WNyfWiM9J7eM+Fwmk=;
 b=D1GYxadtwvx7fAD6zbPfU3vZV2kdb2e6MDDASYdHDkjYXHbTj3wUihUzMiNYwa+F54
 qT5T1NcwgOw5VLFHJU4040NTKyjUsv+gaRGyaAk+u1TdRqy5t2Jubc4iSUWJsQAn9lUu
 x1w53+p/MljW67OAd5Dfr834NaFKPhZU4T5Kznq+IfqA6CaP5Ffljr6Nkru092j+S5hn
 5i4K/6b0NkPiiyLwftK+BqkNUKRL7mgWW5eoxSEFWwrNVJoOnIz3hqOfptFElrlrdMAZ
 3Qclu/QGmTBI2GKyRL5cUPa+WH2+PvgebTTe1gwVnUec3f459t31BGk5nOvsvJFJqewR
 WLoA==
X-Gm-Message-State: AGi0PuZAIPoQ8JgcG9ZdlvFXitjjSMRAl8aPRAE7C3XDHrGvIUHOy2ZS
 Zeu3JVwPBHNrvUlViR89GZ8=
X-Google-Smtp-Source: APiQypJUNzW2Kf/YisQ7Gm6MjGoHraf0uboGBOm6Ai9D7kmeIiXDGo0t/+GLEITvv65wjz5MhoeSGg==
X-Received: by 2002:a17:90a:628c:: with SMTP id
 d12mr2775900pjj.53.1586486329072; 
 Thu, 09 Apr 2020 19:38:49 -0700 (PDT)
Received: from localhost (181.56.30.125.dy.iij4u.or.jp. [125.30.56.181])
 by smtp.gmail.com with ESMTPSA id f4sm456109pjm.9.2020.04.09.19.38.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Apr 2020 19:38:48 -0700 (PDT)
From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date: Fri, 10 Apr 2020 11:38:45 +0900
To: Minchan Kim <minchan@kernel.org>
Subject: Re: [PATCH 10/28] mm: only allow page table mappings for built-in
 zsmalloc
Message-ID: <20200410023845.GA2354@jagdpanzerIV.localdomain>
References: <20200408115926.1467567-1-hch@lst.de>
 <20200408115926.1467567-11-hch@lst.de>
 <20200409160826.GC247701@google.com>
 <20200409165030.GG20713@hirez.programming.kicks-ass.net>
 <20200409170813.GD247701@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200409170813.GD247701@google.com>
X-Mailman-Approved-At: Fri, 10 Apr 2020 03:23:38 +0000
Cc: linux-hyperv@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 dri-devel@lists.freedesktop.org, linux-mm@kvack.org,
 "K. Y. Srinivasan" <kys@microsoft.com>, Sumit Semwal <sumit.semwal@linaro.org>,
 linux-arch@vger.kernel.org, linux-s390@vger.kernel.org,
 Wei Liu <wei.liu@kernel.org>, Stephen Hemminger <sthemmin@microsoft.com>,
 x86@kernel.org, Christoph Hellwig <hch@lst.de>,
 David Airlie <airlied@linux.ie>, Laura Abbott <labbott@redhat.com>,
 Nitin Gupta <ngupta@vflare.org>, Daniel Vetter <daniel@ffwll.ch>,
 Haiyang Zhang <haiyangz@microsoft.com>, linaro-mm-sig@lists.linaro.org,
 bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
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

On (20/04/09 10:08), Minchan Kim wrote:
> > > Even though I don't know how many usecase we have using zsmalloc as
> > > module(I heard only once by dumb reason), it could affect existing
> > > users. Thus, please include concrete explanation in the patch to
> > > justify when the complain occurs.
> > 
> > The justification is 'we can unexport functions that have no sane reason
> > of being exported in the first place'.
> > 
> > The Changelog pretty much says that.
> 
> Okay, I hope there is no affected user since this patch.
> If there are someone, they need to provide sane reason why they want
> to have zsmalloc as module.

I'm one of those who use zsmalloc as a module - mainly because I use zram
as a compressing general purpose block device, not as a swap device.
I create zram0, mkfs, mount, checkout and compile code, once done -
umount, rmmod. This reduces the number of writes to SSD. Some people use
tmpfs, but zram device(-s) can be much larger in size. That's a niche use
case and I'm not against the patch.

	-ss
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
