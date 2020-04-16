Return-Path: <SRS0=meaX=6A=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F85AC38A2C
	for <iommu@archiver.kernel.org>; Thu, 16 Apr 2020 20:37:44 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31ACA22245
	for <iommu@archiver.kernel.org>; Thu, 16 Apr 2020 20:37:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gnCYkWmG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31ACA22245
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id F306420425;
	Thu, 16 Apr 2020 20:37:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id G9t02FRViGIq; Thu, 16 Apr 2020 20:37:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 06D7C203DF;
	Thu, 16 Apr 2020 20:37:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E71AFC1AE8;
	Thu, 16 Apr 2020 20:37:42 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 418C2C0172
 for <iommu@lists.linux-foundation.org>; Thu, 16 Apr 2020 20:37:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 2FDBB20425
 for <iommu@lists.linux-foundation.org>; Thu, 16 Apr 2020 20:37:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Tv5MssOhuwjJ for <iommu@lists.linux-foundation.org>;
 Thu, 16 Apr 2020 20:37:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com
 [209.85.215.195])
 by silver.osuosl.org (Postfix) with ESMTPS id 72792203DF
 for <iommu@lists.linux-foundation.org>; Thu, 16 Apr 2020 20:37:41 +0000 (UTC)
Received: by mail-pg1-f195.google.com with SMTP id t11so2205475pgg.2
 for <iommu@lists.linux-foundation.org>; Thu, 16 Apr 2020 13:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=XptGLsb8LK835cBV0jSCf0HRG/zsBSED6dv7tPgulp4=;
 b=gnCYkWmGETLB8PFSLV04Wdrz2FK+gEIIVYi1koqv0Kj68T1sE9a0zKATXAPY7gyzfJ
 suAROh/dNMoI6pHy/mCCmAEukmmvuLcuT+oRiOR7pSsJ7zs8in52Gebp1M1SYorAU4tK
 gOw3D6aDwjxZUg6c2JW6Y26Oj3CTSIyaIex5HlRUwrN0Akr9mc2rJN/ETJ63AkMWNaPZ
 lBqmfTlQr2tQLv3hxk3korpwrPMIzUOkCHKM9MiAc5EcYNrnyoXofMkm1N6eYHhs/DeF
 913mMDnNGshbbDlgR/ygTf2Uto9ROB2t1oEKoFobtuWYnROIBcT0nnQEOaLeZGRWafc8
 pefQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :references:mime-version:content-disposition:in-reply-to;
 bh=XptGLsb8LK835cBV0jSCf0HRG/zsBSED6dv7tPgulp4=;
 b=SVYB/Xa9xZP5xrC2Cv/0IkuKyJYx+KvAlmXCgFHYZLMNibO4HxLZ5rCRa/4P+l4nfl
 eKu4IHhVRCa7CmLgAXrrthqTqbVXdxGCtrg4xncuSJNo2c7tCpw7mIPs5ecBZr8Zl3qN
 GkFDZkc4D38h18XfkKKopTV8YCgPO9u02V1120WHOXGGEfusvmC7Ax7kDhLLXDDfscIg
 pxbrDG/vN9ZdatzFZduq4+RtwdEZLbmH8zDFvmzr1MQZPbvK/MVYTO/aCzoF71bAwEhJ
 FDqWtp6cN1VYSIf68fqgCevL/YoSYHFx8MYaF3e9dLE1wnaQ+dtXFeThuNwqaAH51xxS
 62wA==
X-Gm-Message-State: AGi0PuaFnGwwbodY9+k2k/kvp+j50ClBOgcLyQIGkA/F/O3hWM0lrPm4
 D1+Uymwp4WoQcQWRUF/62E4=
X-Google-Smtp-Source: APiQypLz/G622vMAZI/1t7tx6iXdrAiprqdhsptFvPk2bcCnaQJR//IYq0Xxli2CBTatOLYd6eCB1g==
X-Received: by 2002:a63:2e03:: with SMTP id u3mr15186804pgu.121.1587069460712; 
 Thu, 16 Apr 2020 13:37:40 -0700 (PDT)
Received: from google.com ([2601:647:4001:3000::50e3])
 by smtp.gmail.com with ESMTPSA id u13sm3654978pjb.45.2020.04.16.13.37.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2020 13:37:38 -0700 (PDT)
Date: Thu, 16 Apr 2020 13:37:36 -0700
From: Minchan Kim <minchan@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 10/28] mm: only allow page table mappings for built-in
 zsmalloc
Message-ID: <20200416203736.GB50092@google.com>
References: <20200408115926.1467567-1-hch@lst.de>
 <20200408115926.1467567-11-hch@lst.de>
 <20200409160826.GC247701@google.com>
 <20200409165030.GG20713@hirez.programming.kicks-ass.net>
 <20200409170813.GD247701@google.com>
 <20200410023845.GA2354@jagdpanzerIV.localdomain>
 <20200410231136.GA101325@google.com>
 <20200411072052.GA31242@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200411072052.GA31242@lst.de>
Cc: linux-hyperv@vger.kernel.org, David Airlie <airlied@linux.ie>,
 dri-devel@lists.freedesktop.org, linux-mm@kvack.org,
 "K. Y. Srinivasan" <kys@microsoft.com>, Sumit Semwal <sumit.semwal@linaro.org>,
 linux-arch@vger.kernel.org, linux-s390@vger.kernel.org,
 Wei Liu <wei.liu@kernel.org>, Stephen Hemminger <sthemmin@microsoft.com>,
 x86@kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Laura Abbott <labbott@redhat.com>, Nitin Gupta <ngupta@vflare.org>,
 Daniel Vetter <daniel@ffwll.ch>, Haiyang Zhang <haiyangz@microsoft.com>,
 linaro-mm-sig@lists.linaro.org, bpf@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Christophe Leroy <christophe.leroy@c-s.fr>,
 Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
 Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
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

Hi Christoph,


Sorry for the late.

On Sat, Apr 11, 2020 at 09:20:52AM +0200, Christoph Hellwig wrote:
> Hi Minchan,
> 
> On Fri, Apr 10, 2020 at 04:11:36PM -0700, Minchan Kim wrote:
> > It doesn't mean we couldn't use zsmalloc as module any longer. It means
> > we couldn't use zsmalloc as module with pgtable mapping whcih was little
> > bit faster on microbenchmark in some architecutre(However, I usually temped
> > to remove it since it had several problems). However, we could still use
> > zsmalloc as module as copy way instead of pgtable mapping. Thus, if someone
> > really want to rollback the feature, they should provide reasonable reason
> > why it doesn't work for them. "A little fast" wouldn't be enough to exports
> > deep internal to the module.
> 
> do you have any data how much faster it is on arm (and does that include
> arm64 as well)?  Besides the exports which were my prime concern,

https://github.com/sjenning/zsmapbench

I need to recall the memory. IIRC, it was almost 30% faster at that time
in ARM so was not trivial at that time. However, it was story from
several years ago.

> zsmalloc with pgtable mappings also is the only user of map_kernel_range
> outside of vmalloc.c, if it really is another code base for tiny
> improvements we could mark map_kernel_range or in fact remove it entirely
> and open code it in the remaining callers.

I alsh have temped to remove it. Let me have time to revist it in this
chance.

Thanks.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
