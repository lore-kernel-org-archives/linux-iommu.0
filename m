Return-Path: <SRS0=Ithz=52=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8974BC2BB86
	for <iommu@archiver.kernel.org>; Fri, 10 Apr 2020 23:11:44 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52472214DB
	for <iommu@archiver.kernel.org>; Fri, 10 Apr 2020 23:11:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q7YTOEbn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52472214DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 288A387D57;
	Fri, 10 Apr 2020 23:11:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9JlVtVCl3lln; Fri, 10 Apr 2020 23:11:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 884D087C9C;
	Fri, 10 Apr 2020 23:11:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 70C5FC1D74;
	Fri, 10 Apr 2020 23:11:43 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9B237C0177
 for <iommu@lists.linux-foundation.org>; Fri, 10 Apr 2020 23:11:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 97421204E5
 for <iommu@lists.linux-foundation.org>; Fri, 10 Apr 2020 23:11:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id szlVCtBRtPFf for <iommu@lists.linux-foundation.org>;
 Fri, 10 Apr 2020 23:11:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pj1-f67.google.com (mail-pj1-f67.google.com
 [209.85.216.67])
 by silver.osuosl.org (Postfix) with ESMTPS id 8FA37204C1
 for <iommu@lists.linux-foundation.org>; Fri, 10 Apr 2020 23:11:41 +0000 (UTC)
Received: by mail-pj1-f67.google.com with SMTP id b7so1308887pju.0
 for <iommu@lists.linux-foundation.org>; Fri, 10 Apr 2020 16:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=bQcdpto7s/yGk2w0OzvQ6UptVyKViN3oMFbbBVW84wQ=;
 b=q7YTOEbnyV60h/2JZUSD3yvsv3FfYyTmAHedS5dXvC6eEJqoWdAqQM8fRMbYNEb/DL
 TWa8f1bEPIXO2DpHtzWmZ1hQdADUheduicV44X6NhmrZnsTNDIZa9VTHkg2rqK9WXs9O
 CtfQg7RxKV1aU+9PajTKBmDFHloR88hUsjTCxairuAofrjSvkiIjlmrksHhAsr4eSull
 P/eN5aSURPoT5uOWbLvn9TO2HAsL3MlV2FT0WDF8H+ov5BHzMNCa3A04caDPl50c1Iqw
 Q60AlHo9v7XVZ5xht9Dtvdi6fj0cEQuu9XG4/VxucECmylB5pc3N/jO1PdzV7ryJfNk2
 odzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :references:mime-version:content-disposition:in-reply-to;
 bh=bQcdpto7s/yGk2w0OzvQ6UptVyKViN3oMFbbBVW84wQ=;
 b=Mkd25Xp0aOmw0Cw6R8NuWCbkYz3TSpe5ZaLv/cw2a+Ducujp7aghSP2oqBK1T4G9Xe
 SZSLKEAYhGOHst6wBG+B/1Ya37JjzfU0ZEPgIKwdT/FYBlihceju0hCCrGCIB7J+gxY2
 yKuuxc++inw9qHMhlX7T5BRdSoKg472uerSQz106FS65eOpYm2WK6H0WRpoQAyDQUJUJ
 jJlFq+RvDXUYMxcza7hyx/OMbYNcpgBPg09XudBEvSxavmt5P1G0KFLH9E5YKvS6uSPF
 d8pmUarRu8Rn9RbJeEepCqp0UGXw28ucB7/QnsTwv+gZi/vjHcvZaZrTSrxv0meqpx2q
 6u7Q==
X-Gm-Message-State: AGi0Pubr5lt0PlMlJOGwxpuAVxuqubeJKlF2AnLg++Aln7xDX2Zcp6J9
 Y94lKYDb/A8r3RYjq6lKs5I=
X-Google-Smtp-Source: APiQypIEPforRWpT0WXypxL4A3ey15BGc+kDge0iIn1cftbyny3ESjfu/Br0BZMCFGD2PtWlRrOKew==
X-Received: by 2002:a17:902:b409:: with SMTP id
 x9mr6968379plr.125.1586560301031; 
 Fri, 10 Apr 2020 16:11:41 -0700 (PDT)
Received: from google.com ([2601:647:4001:3000::50e3])
 by smtp.gmail.com with ESMTPSA id 15sm2629073pfu.186.2020.04.10.16.11.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Apr 2020 16:11:39 -0700 (PDT)
Date: Fri, 10 Apr 2020 16:11:36 -0700
From: Minchan Kim <minchan@kernel.org>
To: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [PATCH 10/28] mm: only allow page table mappings for built-in
 zsmalloc
Message-ID: <20200410231136.GA101325@google.com>
References: <20200408115926.1467567-1-hch@lst.de>
 <20200408115926.1467567-11-hch@lst.de>
 <20200409160826.GC247701@google.com>
 <20200409165030.GG20713@hirez.programming.kicks-ass.net>
 <20200409170813.GD247701@google.com>
 <20200410023845.GA2354@jagdpanzerIV.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200410023845.GA2354@jagdpanzerIV.localdomain>
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
 iommu@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev@lists.ozlabs.org
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

Hi Sergey,

On Fri, Apr 10, 2020 at 11:38:45AM +0900, Sergey Senozhatsky wrote:
> On (20/04/09 10:08), Minchan Kim wrote:
> > > > Even though I don't know how many usecase we have using zsmalloc as
> > > > module(I heard only once by dumb reason), it could affect existing
> > > > users. Thus, please include concrete explanation in the patch to
> > > > justify when the complain occurs.
> > > 
> > > The justification is 'we can unexport functions that have no sane reason
> > > of being exported in the first place'.
> > > 
> > > The Changelog pretty much says that.
> > 
> > Okay, I hope there is no affected user since this patch.
> > If there are someone, they need to provide sane reason why they want
> > to have zsmalloc as module.
> 
> I'm one of those who use zsmalloc as a module - mainly because I use zram
> as a compressing general purpose block device, not as a swap device.
> I create zram0, mkfs, mount, checkout and compile code, once done -
> umount, rmmod. This reduces the number of writes to SSD. Some people use
> tmpfs, but zram device(-s) can be much larger in size. That's a niche use
> case and I'm not against the patch.

It doesn't mean we couldn't use zsmalloc as module any longer. It means
we couldn't use zsmalloc as module with pgtable mapping whcih was little
bit faster on microbenchmark in some architecutre(However, I usually temped
to remove it since it had several problems). However, we could still use
zsmalloc as module as copy way instead of pgtable mapping. Thus, if someone
really want to rollback the feature, they should provide reasonable reason
why it doesn't work for them. "A little fast" wouldn't be enough to exports
deep internal to the module.

Thanks.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
