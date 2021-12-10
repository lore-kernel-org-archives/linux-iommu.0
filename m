Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA070C433EF
	for <iommu@archiver.kernel.org>; Fri, 10 Dec 2021 18:14:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 98670851FA;
	Fri, 10 Dec 2021 18:14:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dobUSWdwJnH0; Fri, 10 Dec 2021 18:14:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 74FB0851F8;
	Fri, 10 Dec 2021 18:14:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 513A1C001E;
	Fri, 10 Dec 2021 18:14:04 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AD603C0012
 for <iommu@lists.linux-foundation.org>; Fri, 10 Dec 2021 18:14:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8C5E1614B6
 for <iommu@lists.linux-foundation.org>; Fri, 10 Dec 2021 18:14:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sz462FaNWMDy for <iommu@lists.linux-foundation.org>;
 Fri, 10 Dec 2021 18:14:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0A4F2614B4
 for <iommu@lists.linux-foundation.org>; Fri, 10 Dec 2021 18:14:02 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10194"; a="324674287"
X-IronPort-AV: E=Sophos;i="5.88,196,1635231600"; d="scan'208";a="324674287"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Dec 2021 10:14:02 -0800
X-IronPort-AV: E=Sophos;i="5.88,196,1635231600"; d="scan'208";a="659713475"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
 by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Dec 2021 10:14:01 -0800
Date: Fri, 10 Dec 2021 10:18:20 -0800
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH 3/4] iommu/vt-d: Support PASID DMA for in-kernel usage
Message-ID: <20211210101820.58b24b77@jacob-builder>
In-Reply-To: <20211210174848.GH6385@nvidia.com>
References: <1638884834-83028-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1638884834-83028-4-git-send-email-jacob.jun.pan@linux.intel.com>
 <20211208132255.GS6385@nvidia.com>
 <20211208111659.6de22e52@jacob-builder>
 <9f724b3a-6028-43d7-b4fc-d8a939e7b2cf@linux.intel.com>
 <20211209152113.64b817b9@jacob-builder>
 <921a766f-d826-2ca4-f739-4d196b32a681@linux.intel.com>
 <20211210095025.38af67ce@jacob-builder>
 <20211210174848.GH6385@nvidia.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Tony Luck <tony.luck@intel.com>,
 Dave Jiang <dave.jiang@intel.com>, Raj Ashok <ashok.raj@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Kumar,
 Sanjay K" <sanjay.k.kumar@intel.com>, LKML <linux-kernel@vger.kernel.org>,
 Christoph Hellwig <hch@infradead.org>, iommu@lists.linux-foundation.org,
 Jacob Pan <jacob.jun.pan@intel.com>, Barry Song <21cnbao@gmail.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>, "Zanussi,
 Tom" <tom.zanussi@intel.com>
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

On Fri, 10 Dec 2021 13:48:48 -0400, Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Fri, Dec 10, 2021 at 09:50:25AM -0800, Jacob Pan wrote:
> 
> > > Tying pasid to an iommu_domain is not a good idea. An iommu_domain
> > > represents an I/O address translation table. It could be attached to a
> > > device or a PASID on the device.  
> > 
> > I don;t think we can avoid storing PASID at domain level or the group's
> > default domain. IOTLB flush is per domain. Default domain of DMA type
> > is already tying to PASID0, right?  
> 
> No, it is just wrong.
> 
> If the HW requires a list of everything that is connected to the
> iommu_domain then it's private iommu_domain should have that list.
> 
What I have in this patchset is in the private dmar_domain
struct dmar_domain {
	...
	u32		kernel_pasid;	/* for in-kernel DMA w/
PASID */ atomic_t	kernel_pasid_user; /* count of kernel_pasid users
*/ struct iommu_domain domain;	/* generic domain data structure for
					   iommu core */
};

Perhaps I am missing the point. "private domain" is still "domain level" as
what I stated. Confused :(

> But it is a *list* not a single PASID.
> 
We could have a list when real use case comes.

> If one device has 10 PASID's pointing to this domain you must flush
> them all if that is what the HW requires.
> 
Yes. My point is that other than PASID 0 is a given, we must track the 10
PASIDs to avoid wasted flush. It also depend on how TLBs are tagged and
flush granularity available. But at the API level, should we support all the
cases?

> Jason


Thanks,

Jacob
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
