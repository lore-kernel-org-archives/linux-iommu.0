Return-Path: <SRS0=A+5j=IY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,URIBL_RED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8064FC433C1
	for <iommu@archiver.kernel.org>; Fri, 26 Mar 2021 08:07:07 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFDFA61A38
	for <iommu@archiver.kernel.org>; Fri, 26 Mar 2021 08:07:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFDFA61A38
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 63568414F9;
	Fri, 26 Mar 2021 08:07:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZPoABmsNZNLW; Fri, 26 Mar 2021 08:07:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id C99BD40F60;
	Fri, 26 Mar 2021 08:07:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 91258C000D;
	Fri, 26 Mar 2021 08:07:04 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 21406C000A
 for <iommu@lists.linux-foundation.org>; Fri, 26 Mar 2021 08:07:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 07B0D6067A
 for <iommu@lists.linux-foundation.org>; Fri, 26 Mar 2021 08:07:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SFYTRZAxss9l for <iommu@lists.linux-foundation.org>;
 Fri, 26 Mar 2021 08:07:03 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D62756061C
 for <iommu@lists.linux-foundation.org>; Fri, 26 Mar 2021 08:07:02 +0000 (UTC)
Received: by mail-wr1-x42f.google.com with SMTP id x16so4723875wrn.4
 for <iommu@lists.linux-foundation.org>; Fri, 26 Mar 2021 01:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=NacPEJvwU26BHEcF1r3DKOPrdoZ0K2lnEiVQ/oV37r4=;
 b=kus60msoSJlwyU1GomSA58McYHQudRjt8lZoUOVyLCyxExYPuQiC/FgDUjEDEdiFJH
 OtPkVS983YcgkVOZ3NbX19SKHfGojdxWiV+mZsVTfFS3PH2ZKq07YDEns8DQHizqSqjj
 kAlYqYai0ZCtnRvwuakJexNRFQxOeUsmhfllUZTGd3aMTne5GjehFbclbRF9zPTDvxfr
 7mUrcCG9VaWh1DWLhfC1B0KnAzLxhwQqcmOk5cN/v/L72Qlm6lRW3AGNrgKkaY+vlaHX
 i+2MikP0ctvy5L5KCWHU8Q958BKQKlSB4DTgMhSfZv+A2P690PsjqM55+5z0YJQ2NIsx
 6Bpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=NacPEJvwU26BHEcF1r3DKOPrdoZ0K2lnEiVQ/oV37r4=;
 b=mvIaFloluogeKgRi+tUhv3ytjNWVpJiAGeKODgGVg0ncvXwEc0RBOHPI0bImGLAATm
 HOfvOcAsKD8QiRHodVYceSg0aeK2YBFasSzjrCgetK4m4vQIuFlE0VLKK2EyHOaIblMe
 jksYygytn2+xkCf+tO2v8VQDen6im5f1dM+XdDRhLzQIS7/+llhAU9N39JvwIAx7NvKX
 jfLrjAbPaIARgKiO5zza8nccG+CoC0/Cl5zkk2wsB+BtQDkCBeMhsR7eGG6Yt0U3bZ0K
 4VHylMhLiFKBzVbbVIko/oEdBS3+AnULfQDPcUB/W4l4WrpgX9qprEmvCVZE14yAHQyt
 h5kQ==
X-Gm-Message-State: AOAM533xOZM9/1iNGIsUG6dSyo9lefU+f4ceE9SKQNu7hYiVFzPqYIWR
 a5/loxn43zCbOZRhRK9VgSzhTA==
X-Google-Smtp-Source: ABdhPJzrQoMie+cZs+TTXzwMUWiYsj5CUy6yLxtxOwZG8ozx04KgN++aU+MFHI+ixkkVUGXl1VqrvQ==
X-Received: by 2002:a5d:591a:: with SMTP id v26mr12982847wrd.172.1616746021071; 
 Fri, 26 Mar 2021 01:07:01 -0700 (PDT)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id 7sm9654955wmk.8.2021.03.26.01.06.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Mar 2021 01:07:00 -0700 (PDT)
Date: Fri, 26 Mar 2021 09:06:42 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and
 allocation APIs
Message-ID: <YF2WEmfXsXKCkCDb@myrica>
References: <YFSqDNJ5yagk4eO+@myrica> <20210319135432.GT2356281@nvidia.com>
 <20210319112221.5123b984@jacob-builder> <YFhiMLR35WWMW/Hu@myrica>
 <20210324100246.4e6b8aa1@jacob-builder>
 <20210324170338.GM2356281@nvidia.com>
 <20210324151230.466fd47a@jacob-builder> <YFxkNEz3THJKzW0b@myrica>
 <20210325100236.17241a1c@jacob-builder>
 <20210325171645.GF2356281@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210325171645.GF2356281@nvidia.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>, Raj Ashok <ashok.raj@intel.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 LKML <linux-kernel@vger.kernel.org>, Dave Jiang <dave.jiang@intel.com>,
 iommu@lists.linux-foundation.org, Li Zefan <lizefan@huawei.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Tejun Heo <tj@kernel.org>,
 cgroups@vger.kernel.org, Wu Hao <hao.wu@intel.com>,
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

On Thu, Mar 25, 2021 at 02:16:45PM -0300, Jason Gunthorpe wrote:
> On Thu, Mar 25, 2021 at 10:02:36AM -0700, Jacob Pan wrote:
> > Hi Jean-Philippe,
> > 
> > On Thu, 25 Mar 2021 11:21:40 +0100, Jean-Philippe Brucker
> > <jean-philippe@linaro.org> wrote:
> > 
> > > On Wed, Mar 24, 2021 at 03:12:30PM -0700, Jacob Pan wrote:
> > > > Hi Jason,
> > > > 
> > > > On Wed, 24 Mar 2021 14:03:38 -0300, Jason Gunthorpe <jgg@nvidia.com>
> > > > wrote: 
> > > > > On Wed, Mar 24, 2021 at 10:02:46AM -0700, Jacob Pan wrote:  
> > > > > > > Also wondering about device driver allocating auxiliary domains
> > > > > > > for their private use, to do iommu_map/unmap on private PASIDs (a
> > > > > > > clean replacement to super SVA, for example). Would that go
> > > > > > > through the same path as /dev/ioasid and use the cgroup of
> > > > > > > current task?    
> > > > > >
> > > > > > For the in-kernel private use, I don't think we should restrict
> > > > > > based on cgroup, since there is no affinity to user processes. I
> > > > > > also think the PASID allocation should just use kernel API instead
> > > > > > of /dev/ioasid. Why would user space need to know the actual PASID
> > > > > > # for device private domains? Maybe I missed your idea?    
> > > > > 
> > > > > There is not much in the kernel that isn't triggered by a process, I
> > > > > would be careful about the idea that there is a class of users that
> > > > > can consume a cgroup controlled resource without being inside the
> > > > > cgroup.
> > > > > 
> > > > > We've got into trouble before overlooking this and with something
> > > > > greenfield like PASID it would be best built in to the API to prevent
> > > > > a mistake. eg accepting a cgroup or process input to the allocator.
> > > > >   
> > > > Make sense. But I think we only allow charging the current cgroup, how
> > > > about I add the following to ioasid_alloc():
> > > > 
> > > > 	misc_cg = get_current_misc_cg();
> > > > 	ret = misc_cg_try_charge(MISC_CG_RES_IOASID, misc_cg, 1);
> > > > 	if (ret) {
> > > > 		put_misc_cg(misc_cg);
> > > > 		return ret;
> > > > 	}  
> > > 
> > > Does that allow PASID allocation during driver probe, in kernel_init or
> > > modprobe context?
> > > 
> > Good point. Yes, you can get cgroup subsystem state in kernel_init for
> > charging/uncharging. I would think module_init should work also since it is
> > after kernel_init. I have tried the following:
> > static int __ref kernel_init(void *unused)
> >  {
> >         int ret;
> > +       struct cgroup_subsys_state *css;
> > +       css = task_get_css(current, pids_cgrp_id);
> > 
> > But that would imply:
> > 1. IOASID has to be built-in, not as module

If IOASID is a module, the device driver will probe once the IOMMU module
is available, which I think always happens in probe deferral kworker.

> > 2. IOASIDs charged on PID1/init would not subject to cgroup limit since it
> > will be in the root cgroup and we don't support migration nor will migrate.
> > 
> > Then it comes back to the question of why do we try to limit in-kernel
> > users per cgroup if we can't enforce these cases.

It may be better to explicitly pass a cgroup during allocation as Jason
suggested. That way anyone using the API will have to be aware of this and
pass the root cgroup if that's what they want.

> Are these real use cases? Why would a driver binding to a device
> create a single kernel pasid at bind time? Why wouldn't it use
> untagged DMA?

It's not inconceivable to have a control queue doing DMA tagged with
PASID. The devices I know either use untagged DMA, or have a choice to use
a PASID. We're not outright forbidding PASID allocation at boot (I don't
think we can or should) and we won't be able to check every use of the
API, so I'm trying to figure out whether it will always default to root
cgroup, or crash in some corner case.

Thanks,
Jean
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
