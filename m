Return-Path: <SRS0=4008=J7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EBCBC433B4
	for <iommu@archiver.kernel.org>; Tue,  4 May 2021 22:09:11 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1013A613D2
	for <iommu@archiver.kernel.org>; Tue,  4 May 2021 22:09:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1013A613D2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B8B778470A;
	Tue,  4 May 2021 22:09:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id x1Fc6qLxcqkP; Tue,  4 May 2021 22:09:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9E81D84704;
	Tue,  4 May 2021 22:09:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 77E0AC000E;
	Tue,  4 May 2021 22:09:09 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7EB3EC0001
 for <iommu@lists.linux-foundation.org>; Tue,  4 May 2021 22:09:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6C8A884704
 for <iommu@lists.linux-foundation.org>; Tue,  4 May 2021 22:09:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VXOMYLzjBmrP for <iommu@lists.linux-foundation.org>;
 Tue,  4 May 2021 22:09:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B50968471D
 for <iommu@lists.linux-foundation.org>; Tue,  4 May 2021 22:09:05 +0000 (UTC)
IronPort-SDR: Lztnhv4U7IjCrWmX8au3BIgTyD4fcVhTM/GHplBG/KIiW5OiEhPWdnNMRGZP6qrU5u0qH53G1V
 9lg2Bl2ZWHgA==
X-IronPort-AV: E=McAfee;i="6200,9189,9974"; a="259367688"
X-IronPort-AV: E=Sophos;i="5.82,272,1613462400"; d="scan'208";a="259367688"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 May 2021 15:09:04 -0700
IronPort-SDR: SuLTDiqHXM8cd3yT7FXZf7uhVJgQJ2nTgf8+4zbG2ekswyEiVikeXRe1aAw3rFb3TKUSyGk+eU
 uKLTEkKkso9g==
X-IronPort-AV: E=Sophos;i="5.82,272,1613462400"; d="scan'208";a="433492852"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 May 2021 15:09:04 -0700
Date: Tue, 4 May 2021 15:11:54 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and
 allocation APIs
Message-ID: <20210504151154.02908c63@jacob-builder>
In-Reply-To: <20210504180050.GB1370958@nvidia.com>
References: <20210421133312.15307c44@redhat.com>
 <20210421230301.GP1370958@nvidia.com>
 <MWHPR11MB1886188698A6E20338196F788C469@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210422121020.GT1370958@nvidia.com>
 <MWHPR11MB1886E688D2128C98A1F240B18C459@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210423114944.GF1370958@nvidia.com>
 <MWHPR11MB18861FE6982D73AFBF173E048C439@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210426123817.GQ1370958@nvidia.com>
 <MWHPR11MB188625137D5B7423822396C88C409@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210504084148.4f61d0b5@jacob-builder>
 <20210504180050.GB1370958@nvidia.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Jiang, Dave" <dave.jiang@intel.com>, "Raj,
 Ashok" <ashok.raj@intel.com>, Jonathan Corbet <corbet@lwn.net>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 LKML <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Alex Williamson <alex.williamson@redhat.com>, Li Zefan <lizefan@huawei.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Tejun Heo <tj@kernel.org>,
 "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>, "Wu, 
 Hao" <hao.wu@intel.com>, David Woodhouse <dwmw2@infradead.org>
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

On Tue, 4 May 2021 15:00:50 -0300, Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Tue, May 04, 2021 at 08:41:48AM -0700, Jacob Pan wrote:
> > > > 
> > > > (also looking at ioasid.c, why do we need such a thin and odd
> > > > wrapper around xarray?)
> > > >     
> > > 
> > > I'll leave it to Jean and Jacob.  
> 
> > Could you elaborate?  
> 
> I mean stuff like this:
> 
> int ioasid_set_data(ioasid_t ioasid, void *data)
> {
>         struct ioasid_data *ioasid_data;
>         int ret = 0;
> 
>         spin_lock(&ioasid_allocator_lock);
>         ioasid_data = xa_load(&active_allocator->xa, ioasid);
>         if (ioasid_data)
>                 rcu_assign_pointer(ioasid_data->private, data);
>         else
>                 ret = -ENOENT;
>         spin_unlock(&ioasid_allocator_lock);
> 
>         /*
>          * Wait for readers to stop accessing the old private data, so the
>          * caller can free it.
>          */
>         if (!ret)
>                 synchronize_rcu();
> 
>         return ret;
> }
> EXPORT_SYMBOL_GPL(ioasid_set_data);
> 
> It is a weird way to use xarray to have a structure which
> itself is just a wrapper around another RCU protected structure.
> 
> Make the caller supply the ioasid_data memory, embedded in its own
> element, get rid of the void * and rely on XA_ZERO_ENTRY to hold
> allocated but not active entries.
> 
Let me try to paraphrase to make sure I understand. Currently
struct ioasid_data is private to the iasid core, its memory is allocated by
the ioasid core.

You are suggesting the following:
1. make struct ioasid_data public
2. caller allocates memory for ioasid_data, initialize it then pass it to
ioasid_alloc to store in the xarray
3. caller will be responsible for setting private data inside ioasid_data
and do call_rcu after update if needed.

Correct?

> Make the synchronize_rcu() the caller responsiblity, and callers
> should really be able to use call_rcu()
> 
> Jason


Thanks,

Jacob
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
