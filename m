Return-Path: <SRS0=Fh/M=IX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,URIBL_RED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9705C433DB
	for <iommu@archiver.kernel.org>; Thu, 25 Mar 2021 10:22:04 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44A5A61A2C
	for <iommu@archiver.kernel.org>; Thu, 25 Mar 2021 10:22:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44A5A61A2C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E1B8B40193;
	Thu, 25 Mar 2021 10:22:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id x_MPERdeP5XL; Thu, 25 Mar 2021 10:22:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id D4B64400B8;
	Thu, 25 Mar 2021 10:22:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AD836C000E;
	Thu, 25 Mar 2021 10:22:02 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7B15EC000A
 for <iommu@lists.linux-foundation.org>; Thu, 25 Mar 2021 10:22:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5286340146
 for <iommu@lists.linux-foundation.org>; Thu, 25 Mar 2021 10:22:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zYkoNEVnh5Ex for <iommu@lists.linux-foundation.org>;
 Thu, 25 Mar 2021 10:22:00 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4C260400B8
 for <iommu@lists.linux-foundation.org>; Thu, 25 Mar 2021 10:22:00 +0000 (UTC)
Received: by mail-wr1-x436.google.com with SMTP id c8so1678004wrq.11
 for <iommu@lists.linux-foundation.org>; Thu, 25 Mar 2021 03:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=2bl+T//9tmIfvggnKu8W5/72RtiA3Lc/gNcBZ4TaNT0=;
 b=HDBMmQHjxhDfBDa8NUpbssXQOf02VdhzwNOvL6z/sjlS/ob6nTDjDFdk7Rx19nR1hs
 SQS1m7CNqJDQUJQrPvFOlRsKplOR4HvnzIgwuwJzay62ap35JEwN/qhpACoPzMAWxfWI
 XO4MYnlDxfTay5ZNPPLBaE8XvkwnoB0y15l1GoemjCgivvxfYqd4SqDye10bL/U1sDgq
 2q58EeYToO3fsZktwBu5V51IOdt2ibMB1IaBNKKSb4cr+C+as3JCUfzbgdL92Xba3w9V
 ql45gXFLeCm10iNBjvSTa/BEbpZQtQ6N4qHGai0lWRLpSVaztsL2TRhlDZbX05OJR9Pk
 EKxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=2bl+T//9tmIfvggnKu8W5/72RtiA3Lc/gNcBZ4TaNT0=;
 b=R3fFJS1SYT0TZLOL9nR/J+Xb4aWQMYCY1vnTGOuXSpsYbiA/mYAuyIU/eeEV1NvciF
 Py6LBX3hiW+c9d8oDdhTj6sD/0A998Qyixa44j3zmu03AIvVbL/FESFq9wOfH0U5UPIV
 vE7lXAB6JpOl5J8VyIqKIon65sKi8PlckwxZKGe0xjvMb4N9TFOHAtlK6mCBVzMWwzx7
 LrV6Z8Vnpu423xlyJKbIOINm49CM6Pqt8qQ/CszdgiUL1Qxed4or8e7bFQ1ak/PE4LoS
 Mo7vJSurqhNg7qNlf80A4JR7FVGjS4pI8vSE90taeOJUkh8ZtqLWDn2mSiNMHdUzEqq6
 GMug==
X-Gm-Message-State: AOAM533neUuyi2Z29dRPXr9hVGxu+5c9Zea5SHPB450g+0zudgAcupHU
 Zly7zf5/fpcSPubSXhapiRILwQ==
X-Google-Smtp-Source: ABdhPJxdNpCXhheQbUGXl/BE6FBzNDPbXq78nFO9owhDJs9Gl4Mz6+SKSrv2in7tl4ijY3NP8j4Dxw==
X-Received: by 2002:a05:6000:12c5:: with SMTP id
 l5mr7958343wrx.208.1616667718538; 
 Thu, 25 Mar 2021 03:21:58 -0700 (PDT)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id g15sm5458756wmq.31.2021.03.25.03.21.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Mar 2021 03:21:58 -0700 (PDT)
Date: Thu, 25 Mar 2021 11:21:40 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and
 allocation APIs
Message-ID: <YFxkNEz3THJKzW0b@myrica>
References: <20210318172234.3e8c34f7@jacob-builder> <YFR10eeDVf5ZHV5l@myrica>
 <20210319124645.GP2356281@nvidia.com> <YFSqDNJ5yagk4eO+@myrica>
 <20210319135432.GT2356281@nvidia.com>
 <20210319112221.5123b984@jacob-builder> <YFhiMLR35WWMW/Hu@myrica>
 <20210324100246.4e6b8aa1@jacob-builder>
 <20210324170338.GM2356281@nvidia.com>
 <20210324151230.466fd47a@jacob-builder>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210324151230.466fd47a@jacob-builder>
Cc: "Tian, Kevin" <kevin.tian@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>, Raj Ashok <ashok.raj@intel.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 LKML <linux-kernel@vger.kernel.org>, Dave Jiang <dave.jiang@intel.com>,
 iommu@lists.linux-foundation.org, Li Zefan <lizefan@huawei.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Tejun Heo <tj@kernel.org>, cgroups@vger.kernel.org, Wu Hao <hao.wu@intel.com>,
 David Woodhouse <dwmw2@infradead.org>
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

On Wed, Mar 24, 2021 at 03:12:30PM -0700, Jacob Pan wrote:
> Hi Jason,
> 
> On Wed, 24 Mar 2021 14:03:38 -0300, Jason Gunthorpe <jgg@nvidia.com> wrote:
> 
> > On Wed, Mar 24, 2021 at 10:02:46AM -0700, Jacob Pan wrote:
> > > > Also wondering about device driver allocating auxiliary domains for
> > > > their private use, to do iommu_map/unmap on private PASIDs (a clean
> > > > replacement to super SVA, for example). Would that go through the
> > > > same path as /dev/ioasid and use the cgroup of current task?  
> > >
> > > For the in-kernel private use, I don't think we should restrict based on
> > > cgroup, since there is no affinity to user processes. I also think the
> > > PASID allocation should just use kernel API instead of /dev/ioasid. Why
> > > would user space need to know the actual PASID # for device private
> > > domains? Maybe I missed your idea?  
> > 
> > There is not much in the kernel that isn't triggered by a process, I
> > would be careful about the idea that there is a class of users that
> > can consume a cgroup controlled resource without being inside the
> > cgroup.
> > 
> > We've got into trouble before overlooking this and with something
> > greenfield like PASID it would be best built in to the API to prevent
> > a mistake. eg accepting a cgroup or process input to the allocator.
> > 
> Make sense. But I think we only allow charging the current cgroup, how about
> I add the following to ioasid_alloc():
> 
> 	misc_cg = get_current_misc_cg();
> 	ret = misc_cg_try_charge(MISC_CG_RES_IOASID, misc_cg, 1);
> 	if (ret) {
> 		put_misc_cg(misc_cg);
> 		return ret;
> 	}

Does that allow PASID allocation during driver probe, in kernel_init or
modprobe context?

Thanks,
Jean

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
