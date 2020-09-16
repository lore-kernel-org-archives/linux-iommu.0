Return-Path: <SRS0=cHis=CZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C1BCC43461
	for <iommu@archiver.kernel.org>; Wed, 16 Sep 2020 16:34:10 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FBF620732
	for <iommu@archiver.kernel.org>; Wed, 16 Sep 2020 16:34:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FBF620732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 6471086ACA;
	Wed, 16 Sep 2020 16:34:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FQufCa-NbUQE; Wed, 16 Sep 2020 16:34:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 4936C86AD8;
	Wed, 16 Sep 2020 16:34:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 30DA9C0859;
	Wed, 16 Sep 2020 16:34:08 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5D3C6C0051
 for <iommu@lists.linux-foundation.org>; Wed, 16 Sep 2020 16:34:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 358882D002
 for <iommu@lists.linux-foundation.org>; Wed, 16 Sep 2020 16:34:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id V+soaCKMU+vi for <iommu@lists.linux-foundation.org>;
 Wed, 16 Sep 2020 16:34:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by silver.osuosl.org (Postfix) with ESMTPS id 63276207A4
 for <iommu@lists.linux-foundation.org>; Wed, 16 Sep 2020 16:34:04 +0000 (UTC)
IronPort-SDR: +NNV/29QZL7qNdE241R23U/o+PHYxrpsKCCcZF2NYp5D9V1ZZWcNXQIWo/r4VH2OFd4XoSLrR9
 rOzRroIYEBVA==
X-IronPort-AV: E=McAfee;i="6000,8403,9746"; a="223694256"
X-IronPort-AV: E=Sophos;i="5.76,433,1592895600"; d="scan'208";a="223694256"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Sep 2020 09:33:46 -0700
IronPort-SDR: JwVurvYhdZ9tRNeyZ2bbSVR/msRNcTlCZbI75pYea8hcHpWEOxy1xzYyq7jZQ44LRp/Ad7T+y3
 RKc/qzoQ1Cbg==
X-IronPort-AV: E=Sophos;i="5.76,433,1592895600"; d="scan'208";a="307104962"
Received: from otc-nc-03.jf.intel.com (HELO otc-nc-03) ([10.54.39.36])
 by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Sep 2020 09:33:45 -0700
Date: Wed, 16 Sep 2020 09:33:43 -0700
From: "Raj, Ashok" <ashok.raj@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v7 00/16] vfio: expose virtual Shared Virtual Addressing
 to VMs
Message-ID: <20200916163343.GA76252@otc-nc-03>
References: <20200914122328.0a262a7b@x1.home>
 <20200914190057.GM904879@nvidia.com>
 <20200914224438.GA65940@otc-nc-03>
 <20200915113341.GW904879@nvidia.com>
 <20200915181154.GA70770@otc-nc-03>
 <20200915184510.GB1573713@nvidia.com>
 <20200915150851.76436ca1@jacob-builder>
 <20200915235126.GK1573713@nvidia.com>
 <20200915171319.00003f59@linux.intel.com>
 <20200916150754.GE6199@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200916150754.GE6199@nvidia.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Cc: yi.y.sun@intel.com, Jean-Philippe Brucker <jean-philippe@linaro.org>,
 kevin.tian@intel.com, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, stefanha@gmail.com,
 Jason Wang <jasowang@redhat.com>, jun.j.tian@intel.com,
 Alex Williamson <alex.williamson@redhat.com>, iommu@lists.linux-foundation.org,
 "Jacob Pan \(Jun\)" <jacob.jun.pan@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 hao.wu@intel.com
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

On Wed, Sep 16, 2020 at 12:07:54PM -0300, Jason Gunthorpe wrote:
> On Tue, Sep 15, 2020 at 05:22:26PM -0700, Jacob Pan (Jun) wrote:
> > > If user space wants to bind page tables, create the PASID with
> > > /dev/sva, use ioctls there to setup the page table the way it wants,
> > > then pass the now configured PASID to a driver that can use it. 
> > 
> > Are we talking about bare metal SVA? 
> 
> What a weird term.

Glad you noticed it at v7 :-) 

Any suggestions on something less weird than 
Shared Virtual Addressing? There is a reason why we moved from SVM to SVA.
> 
> > If so, I don't see the need for userspace to know there is a
> > PASID. All user space need is that my current mm is bound to a
> > device by the driver. So it can be a one-step process for user
> > instead of two.
> 
> You've missed the entire point of the conversation, VDPA already needs
> more than "my current mm is bound to a device"

You mean current version of vDPA? or a potential future version of vDPA?

Cheers,
Ashok
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
