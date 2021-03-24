Return-Path: <SRS0=zuxH=IW=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9E7BC433DB
	for <iommu@archiver.kernel.org>; Wed, 24 Mar 2021 22:10:08 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 274DD61A18
	for <iommu@archiver.kernel.org>; Wed, 24 Mar 2021 22:10:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 274DD61A18
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E2A0360B02;
	Wed, 24 Mar 2021 22:10:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id u8-yfEpenYf3; Wed, 24 Mar 2021 22:10:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id C7587605F7;
	Wed, 24 Mar 2021 22:10:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A0E19C000D;
	Wed, 24 Mar 2021 22:10:06 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 080E2C000A
 for <iommu@lists.linux-foundation.org>; Wed, 24 Mar 2021 22:10:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DC6318490B
 for <iommu@lists.linux-foundation.org>; Wed, 24 Mar 2021 22:10:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id caO7ZQc_22qO for <iommu@lists.linux-foundation.org>;
 Wed, 24 Mar 2021 22:10:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3C478848FD
 for <iommu@lists.linux-foundation.org>; Wed, 24 Mar 2021 22:10:04 +0000 (UTC)
IronPort-SDR: OpeULTy7JcDH/Ayje8i4z2YhKxsTm+oUJUDcgR8HkpReg7fsxov/e5TA1F4x9B1189EzMb+bXY
 1YbkSa/AxvMg==
X-IronPort-AV: E=McAfee;i="6000,8403,9933"; a="177913773"
X-IronPort-AV: E=Sophos;i="5.81,275,1610438400"; d="scan'208";a="177913773"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Mar 2021 15:10:03 -0700
IronPort-SDR: DQZSaLihhzL2eMMuOF5/+Gq/kYGub32TVjHTLJr/fySOgtaPJemHSPHFCx7OFGJFZBYCPKhCq1
 tkpDOzoJ4dTA==
X-IronPort-AV: E=Sophos;i="5.81,275,1610438400"; d="scan'208";a="413927681"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
 by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Mar 2021 15:10:03 -0700
Date: Wed, 24 Mar 2021 15:12:30 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and
 allocation APIs
Message-ID: <20210324151230.466fd47a@jacob-builder>
In-Reply-To: <20210324170338.GM2356281@nvidia.com>
References: <1614463286-97618-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1614463286-97618-6-git-send-email-jacob.jun.pan@linux.intel.com>
 <20210318172234.3e8c34f7@jacob-builder> <YFR10eeDVf5ZHV5l@myrica>
 <20210319124645.GP2356281@nvidia.com> <YFSqDNJ5yagk4eO+@myrica>
 <20210319135432.GT2356281@nvidia.com>
 <20210319112221.5123b984@jacob-builder> <YFhiMLR35WWMW/Hu@myrica>
 <20210324100246.4e6b8aa1@jacob-builder>
 <20210324170338.GM2356281@nvidia.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>, Alex Williamson <alex.williamson@redhat.com>,
 Raj Ashok <ashok.raj@intel.com>, Jonathan Corbet <corbet@lwn.net>,
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

Hi Jason,

On Wed, 24 Mar 2021 14:03:38 -0300, Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Wed, Mar 24, 2021 at 10:02:46AM -0700, Jacob Pan wrote:
> > > Also wondering about device driver allocating auxiliary domains for
> > > their private use, to do iommu_map/unmap on private PASIDs (a clean
> > > replacement to super SVA, for example). Would that go through the
> > > same path as /dev/ioasid and use the cgroup of current task?  
> >
> > For the in-kernel private use, I don't think we should restrict based on
> > cgroup, since there is no affinity to user processes. I also think the
> > PASID allocation should just use kernel API instead of /dev/ioasid. Why
> > would user space need to know the actual PASID # for device private
> > domains? Maybe I missed your idea?  
> 
> There is not much in the kernel that isn't triggered by a process, I
> would be careful about the idea that there is a class of users that
> can consume a cgroup controlled resource without being inside the
> cgroup.
> 
> We've got into trouble before overlooking this and with something
> greenfield like PASID it would be best built in to the API to prevent
> a mistake. eg accepting a cgroup or process input to the allocator.
> 
Make sense. But I think we only allow charging the current cgroup, how about
I add the following to ioasid_alloc():

	misc_cg = get_current_misc_cg();
	ret = misc_cg_try_charge(MISC_CG_RES_IOASID, misc_cg, 1);
	if (ret) {
		put_misc_cg(misc_cg);
		return ret;
	}

BTW, IOASID will be one of the resources under the proposed misc cgroup.

Thanks,

Jacob
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
