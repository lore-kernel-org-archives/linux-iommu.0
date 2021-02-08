Return-Path: <SRS0=aVDl=HK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 594B6C433DB
	for <iommu@archiver.kernel.org>; Mon,  8 Feb 2021 18:33:55 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD03164E8C
	for <iommu@archiver.kernel.org>; Mon,  8 Feb 2021 18:33:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD03164E8C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 824402107D;
	Mon,  8 Feb 2021 18:33:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TDwRAfaCu4xM; Mon,  8 Feb 2021 18:33:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 7C5AF214D2;
	Mon,  8 Feb 2021 18:33:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6620DC0891;
	Mon,  8 Feb 2021 18:33:53 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C4FF5C013A
 for <iommu@lists.linux-foundation.org>; Mon,  8 Feb 2021 18:33:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id BC1122107D
 for <iommu@lists.linux-foundation.org>; Mon,  8 Feb 2021 18:33:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id p9F7pP2pFQGx for <iommu@lists.linux-foundation.org>;
 Mon,  8 Feb 2021 18:33:51 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com
 [209.85.160.172])
 by silver.osuosl.org (Postfix) with ESMTPS id 24AD32046A
 for <iommu@lists.linux-foundation.org>; Mon,  8 Feb 2021 18:33:50 +0000 (UTC)
Received: by mail-qt1-f172.google.com with SMTP id e11so11029076qtg.6
 for <iommu@lists.linux-foundation.org>; Mon, 08 Feb 2021 10:33:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=zsGQUeCVE+9P7aNp54v7uYNj84EfUFjIYL1mjfYFnhM=;
 b=FVZOhOlO1m/ZSXYxWqQ3/Ohq3Wp/tvRDC8GTvP+9bSnDEiozixF3Jhu580CVCPRbPm
 HJk4/2MMunffgKDn9bqK046yfyDvCxzIoA7T9EVtyNZfNB349GjItsMZSxgoMAhgi9KK
 nGadbvWT0KrcPvYiuq0YMFcdBLGx2QWttauttC9CmU/yQLFXG/FJzLeOF3qlZ6ifMM/6
 cG0R8kzOetckivQvI1vkoOdcGpp0+q8eD+xtEdsggBY1OP0qQ8kRpli+JjTQL4jj+cJE
 pYd3v7VG89h1Pnv0+WhajdC+jmuARDnJ7f5CKBccsE/96SEKVSqegmKaKZUt1ONCwfOI
 3mqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=zsGQUeCVE+9P7aNp54v7uYNj84EfUFjIYL1mjfYFnhM=;
 b=nV2fZwM1TrQ79u+1P4fhxFy1PwwWxUTecrebkKzQHBC7Ok5YOnTwO3brdVC9OcLvmK
 MeG7M2PM0dN9cGs4g38YigqC49SwnVP9RsM77lWNkbmu52jCn+cfM3opUgkhhXOtjBJi
 6wIJJWM/AJdu+swDOGKwVyIHqE81YkwGf2vmWmVFDtJCFf5wM0lGKILtKJLlL/qzF0y0
 t+TrDXUMyewSpOisJRtm4FjrtKXrJ7ASXikSt4K5VGOX3KQGknCs0MVCGiKkwex16tIS
 QudRxyi78ajcGzivqxYrbvOXTlX+yfE0TTE5uaP19IrxtnuNyYV4R1zKaM+zZetjc6Yq
 BvUw==
X-Gm-Message-State: AOAM533h1c5HgprGztB9oGESCdrdHVUaYlvJHWyvmKuAeau4U3AXrp1P
 XVTldYdqWBKffzqJv2kzRO6gVg==
X-Google-Smtp-Source: ABdhPJw9LB1ZweabsqrMBku5FA6d/KFYbPv37y2NqRoUt6oYBe0PrhVhU9GHDLJJPMyumQU59KaDBQ==
X-Received: by 2002:aed:38e3:: with SMTP id k90mr16286292qte.119.1612809230040; 
 Mon, 08 Feb 2021 10:33:50 -0800 (PST)
Received: from ziepe.ca
 (hlfxns017vw-142-162-115-133.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.162.115.133])
 by smtp.gmail.com with ESMTPSA id p18sm16809839qkj.130.2021.02.08.10.33.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Feb 2021 10:33:49 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94) (envelope-from <jgg@ziepe.ca>)
 id 1l9BM4-005254-G1; Mon, 08 Feb 2021 14:33:48 -0400
Date: Mon, 8 Feb 2021 14:33:48 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [RFC PATCH v3 1/2] mempinfd: Add new syscall to provide memory pin
Message-ID: <20210208183348.GV4718@ziepe.ca>
References: <1612685884-19514-1-git-send-email-wangzhou1@hisilicon.com>
 <1612685884-19514-2-git-send-email-wangzhou1@hisilicon.com>
 <a587bd61-9194-4b46-c122-8b4da7b941a8@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <a587bd61-9194-4b46-c122-8b4da7b941a8@redhat.com>
Cc: jean-philippe@linaro.org, kevin.tian@intel.com,
 Sihang Chen <chensihang1@hisilicon.com>, linux-api@vger.kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 linux-mm@kvack.org, Alexander Viro <viro@zeniv.linux.org.uk>,
 gregkh@linuxfoundation.org, zhangfei.gao@linaro.org,
 Andrew Morton <akpm@linux-foundation.org>, liguozhu@hisilicon.com,
 linux-arm-kernel@lists.infradead.org
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

On Mon, Feb 08, 2021 at 09:14:28AM +0100, David Hildenbrand wrote:

> People are constantly struggling with the effects of long term pinnings
> under user space control, like we already have with vfio and RDMA.
> 
> And here we are, adding yet another, easier way to mess with core MM in the
> same way. This feels like a step backwards to me.

Yes, this seems like a very poor candidate to be a system call in this
format. Much too narrow, poorly specified, and possibly security
implications to allow any process whatsoever to pin memory.

I keep encouraging people to explore a standard shared SVA interface
that can cover all these topics (and no, uaccel is not that
interface), that seems much more natural.

I still haven't seen an explanation why DMA is so special here,
migration and so forth jitter the CPU too, environments that care
about jitter have to turn this stuff off.

Jason 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
