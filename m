Return-Path: <SRS0=42j6=W7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0655BC3A5A2
	for <iommu@archiver.kernel.org>; Wed,  4 Sep 2019 03:09:05 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C61C722CEA
	for <iommu@archiver.kernel.org>; Wed,  4 Sep 2019 03:09:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C61C722CEA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 93387F42;
	Wed,  4 Sep 2019 03:09:04 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 5EBF2F3C
	for <iommu@lists.linux-foundation.org>;
	Wed,  4 Sep 2019 03:09:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id D54BF709
	for <iommu@lists.linux-foundation.org>;
	Wed,  4 Sep 2019 03:09:02 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
	by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	03 Sep 2019 20:09:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,465,1559545200"; d="scan'208";a="207319319"
Received: from orsmsx104.amr.corp.intel.com ([10.22.225.131])
	by fmsmga004.fm.intel.com with ESMTP; 03 Sep 2019 20:09:01 -0700
Received: from orsmsx112.amr.corp.intel.com (10.22.240.13) by
	ORSMSX104.amr.corp.intel.com (10.22.225.131) with Microsoft SMTP Server
	(TLS) id 14.3.439.0; Tue, 3 Sep 2019 20:09:00 -0700
Received: from orsmsx114.amr.corp.intel.com ([169.254.8.225]) by
	ORSMSX112.amr.corp.intel.com ([169.254.3.89]) with mapi id
	14.03.0439.000; Tue, 3 Sep 2019 20:09:00 -0700
From: "Prakhya, Sai Praneeth" <sai.praneeth.prakhya@intel.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: RE: [PATCH 3/4] iommu: Add support to change default domain of an
	iommu_group
Thread-Topic: [PATCH 3/4] iommu: Add support to change default domain of an
	iommu_group
Thread-Index: AQHVV8qWE2w4hNV0n0iqYRgWzGAzZacacisAgABxZ7A=
Date: Wed, 4 Sep 2019 03:09:00 +0000
Message-ID: <FFF73D592F13FD46B8700F0A279B802F4FBECD3E@ORSMSX114.amr.corp.intel.com>
References: <cover.1566353521.git.sai.praneeth.prakhya@intel.com>
	<03cbec8c95b13d417dd1c44f545241d01e7b9654.1566353521.git.sai.praneeth.prakhya@intel.com>
	<20190903125046.GA11530@8bytes.org>
In-Reply-To: <20190903125046.GA11530@8bytes.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMDBkNDk5NTYtNjYyZS00OGUwLTk0OWMtOGZmMjQ1NjVjYzQyIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiWjg3alNIWU1EQ0VcL2d5NlNBVjVxdzFjaElEeVFDR08zWUIrTUlxdWs3SkpZWnI0WmZycW5STmNxQlBJSEdtcEgifQ==
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.22.254.139]
MIME-Version: 1.0
Cc: "Raj, Ashok" <ashok.raj@intel.com>, Will Deacon <will.deacon@arm.com>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

Hi Joerg,

Thanks a lot! for the review. I highly appreciate for sparing your time to review the patch :)

> On Tue, Aug 20, 2019 at 07:42:25PM -0700, Sai Praneeth Prakhya wrote:
> > +	/*
> > +	 * iommu_domain_alloc() takes "struct bus_type" as an argument which
> is
> > +	 * a member in "struct device". Changing a group's default domain type
> > +	 * deals at iommu_group level rather than device level and hence there
> > +	 * is no straight forward way to get "bus_type" of an iommu_group that
> > +	 * could be passed to iommu_domain_alloc(). So, instead of directly
> > +	 * calling iommu_domain_alloc(), use iommu_ops from previous default
> > +	 * domain.
> > +	 */
> > +	if (!prev_domain || !prev_domain->ops ||
> > +	    !prev_domain->ops->domain_alloc || !type)
> > +		return -EINVAL;
> 
> Hmm, this isn't really nice and clean, but I understand why you need it.

I agree.. It didn't look good for me either :(
But, I didn't find any other better solution. 

> I will think about a better way to get iommu_ops here.

Sure! That will be great!

> > +free_prev_domain:
> > +	/*
> > +	 * Free the existing default domain and replace it with the newly
> > +	 * created default domain. No need to set group->domain because
> > +	 * __iommu_attach_group() already does it on success.
> > +	 */
> > +	iommu_domain_free(prev_domain);
> > +	group->default_domain = new_domain;
> > +	return 0;
> 
> It isn't obvious to me from this patch, how to are the dma_ops updated when
> the default domain changes between identity and dma?

Thanks for raising this.
For intel_iommu, dma_map_ops is defined at drivers/iommu/intel-iommu.c and
all the callbacks like alloc(), map_sg() and map_page(), check if the device needs DMA mapping or not 
by calling iommu_need_mapping(). The callbacks inherently do the right thing based on the outcome.
So, essentially the dma_ops are same for dma/identity domain.

I just realized (sorry!) that other iommu drivers (Eg: AMD) doesn't do it the same way i.e. looks like the callbacks 
aren't checking if the device needs a dma mapping or identity mapping.
I will take a look at other iommu drivers and will handle this in V2.

Please let me know if I missed something.

> > +	/* Check if any device in the group still has a driver binded to it */
> > +	if (iommu_group_for_each_dev(group, NULL, is_driver_binded)) {
> > +		pr_err("Active drivers exist for devices in the group\n");
> > +		return -EBUSY;
> > +	}
> 
> This is racy with device driver probing code. Unfortunatly there is no clean way
> out of that either, locking all devices in the group and then do the re-attach will
> introduce a lock-inversion with group->mutex. But please put a comment here
> saying that this might race with device driver probing.

Sure! Makes sense. Will add it in V2.

Regards,
Sai
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
