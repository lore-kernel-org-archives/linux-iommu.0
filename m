Return-Path: <SRS0=7Zqx=JL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DD68C433ED
	for <iommu@archiver.kernel.org>; Wed, 14 Apr 2021 00:07:15 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2A0C60249
	for <iommu@archiver.kernel.org>; Wed, 14 Apr 2021 00:07:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2A0C60249
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 98F9940637;
	Wed, 14 Apr 2021 00:07:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id W7Gr_r--S9Lk; Wed, 14 Apr 2021 00:07:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9516040154;
	Wed, 14 Apr 2021 00:07:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 69CE0C000C;
	Wed, 14 Apr 2021 00:07:12 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E152EC000A
 for <iommu@lists.linux-foundation.org>; Wed, 14 Apr 2021 00:07:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BCDDE40EE9
 for <iommu@lists.linux-foundation.org>; Wed, 14 Apr 2021 00:07:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FFKqGb9jPTV7 for <iommu@lists.linux-foundation.org>;
 Wed, 14 Apr 2021 00:07:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E987940EE6
 for <iommu@lists.linux-foundation.org>; Wed, 14 Apr 2021 00:07:10 +0000 (UTC)
IronPort-SDR: yfIdTxW1KxW0diO9R+x6v5ny7jelcCMPcmaTRS6vZ4Bo2EUmbgkuKSuBlPTqfjO1KQpJ/EwNrn
 C80lUldP+gYQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9953"; a="194553475"
X-IronPort-AV: E=Sophos;i="5.82,220,1613462400"; d="scan'208";a="194553475"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Apr 2021 17:07:10 -0700
IronPort-SDR: FW1+JDWFnnCJ0F8zcxYqh84SmkButXavMRcYvhG1wXMabDT20sJ6bofo8dJAA+BWwsfPAENdxM
 KRJBoeT0uySg==
X-IronPort-AV: E=Sophos;i="5.82,220,1613462400"; d="scan'208";a="424475892"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Apr 2021 17:07:09 -0700
Date: Tue, 13 Apr 2021 17:09:47 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH 2/2] iommu/sva: Remove mm parameter from SVA bind API
Message-ID: <20210413170947.35ba9267@jacob-builder>
In-Reply-To: <20210409110305.6b0471d9@jacob-builder>
References: <1617901736-24788-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1617901736-24788-2-git-send-email-jacob.jun.pan@linux.intel.com>
 <YHAoY9+w2ebYZ7VV@myrica> <20210409110305.6b0471d9@jacob-builder>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: vkoul@kernel.org, "Tian, Kevin" <kevin.tian@intel.com>,
 Dave Jiang <dave.jiang@intel.com>, Raj Ashok <ashok.raj@intel.com>,
 LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org,
 Jason Gunthorpe <jgg@nvidia.com>, zhangfei.gao@linaro.org,
 Jean-Philippe Brucker <jean-philippe@linaro.com>
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

Hi Jean,

On Fri, 9 Apr 2021 11:03:05 -0700, Jacob Pan
<jacob.jun.pan@linux.intel.com> wrote:

> > problems:
> > 
> > * We don't have a use-case for binding the mm of a remote process (and
> >   it's supposedly difficult for device drivers to do it securely). So
> > OK, we remove the mm argument from iommu_sva_bind_device() and use the
> >   current mm. But the IOMMU driver isn't going to do
> > get_task_mm(current) every time it needs the mm being bound, it will
> > take it from iommu_sva_bind_device(). Likewise iommu_sva_alloc_pasid()
> > shouldn't need to bother with get_task_mm().
> > 
> > * cgroup accounting for IOASIDs needs to be on the current task.
> > Removing the mm parameter from iommu_sva_alloc_pasid() doesn't help
> > with that. Sure it indicates that iommu_sva_alloc_pasid() needs a
> > specific task context but that's only for cgroup purpose, and I'd
> > rather pass the cgroup down from iommu_sva_bind_device() anyway (but am
> > fine with keeping it within ioasid_alloc() for now). Plus it's an
> > internal helper, easy for us to check that the callers are doing the
> > right thing. 
> With the above split, we really just have one allocation function:
> ioasid_alloc(), so it can manage current cgroup accounting within. Would
> this work?
After a few attempts, I don't think the split can work better. I will
restore the mm parameter and add a warning if mm != current->mm.

Thanks,

Jacob
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
