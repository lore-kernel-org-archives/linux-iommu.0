Return-Path: <SRS0=Mf8z=KM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32E77C433B4
	for <iommu@archiver.kernel.org>; Mon, 17 May 2021 12:53:33 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B870A61166
	for <iommu@archiver.kernel.org>; Mon, 17 May 2021 12:53:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B870A61166
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7EB3E83C82;
	Mon, 17 May 2021 12:53:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id y_XSKkYeaP2w; Mon, 17 May 2021 12:53:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 58A7E83C4E;
	Mon, 17 May 2021 12:53:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 355AFC000D;
	Mon, 17 May 2021 12:53:28 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F16CAC0001
 for <iommu@lists.linux-foundation.org>; Mon, 17 May 2021 12:53:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E010C83C4E
 for <iommu@lists.linux-foundation.org>; Mon, 17 May 2021 12:53:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 55XGlqDu_YKz for <iommu@lists.linux-foundation.org>;
 Mon, 17 May 2021 12:53:21 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0644583C61
 for <iommu@lists.linux-foundation.org>; Mon, 17 May 2021 12:53:20 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id 771D72E7; Mon, 17 May 2021 14:53:18 +0200 (CEST)
Date: Mon, 17 May 2021 14:53:16 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH 3/6] vfio: remove the unused mdev iommu hook
Message-ID: <YKJnPGonR+d8rbu/@8bytes.org>
References: <20210510065405.2334771-4-hch@lst.de>
 <20210510155454.GA1096940@ziepe.ca>
 <MWHPR11MB1886E02BF7DE371E9665AA328C519@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210513120058.GG1096940@ziepe.ca>
 <MWHPR11MB1886B92507ED9015831A0CEA8C509@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210514121925.GI1096940@ziepe.ca>
 <MWHPR11MB18866205125E566FE05867A78C509@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210514133143.GK1096940@ziepe.ca> <YKJf7mphTHZoi7Qr@8bytes.org>
 <20210517123010.GO1096940@ziepe.ca>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210517123010.GO1096940@ziepe.ca>
Cc: "Tian, Kevin" <kevin.tian@intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Will Deacon <will@kernel.org>,
 Kirti Wankhede <kwankhede@nvidia.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 David Woodhouse <dwmw2@infradead.org>, Christoph Hellwig <hch@lst.de>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
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

On Mon, May 17, 2021 at 09:30:10AM -0300, Jason Gunthorpe wrote:
> On Mon, May 17, 2021 at 02:22:06PM +0200, Joerg Roedel wrote:
> > Yes, I know, We have the AUX-domain specific functions now, but I
> > suggested a while back to turn the mdev code into its own bus
> > implementation and let the IOMMU driver deal with whether it has an mdev
> > or a pdev. When that is done the aux-specific functions can go away.
> 
> Yuk, no.
> 
> PASID is not connected to the driver model. It is inherently wrong to
> suggest this.

There will be no drivers for that, but an mdev is a container for
resources of a physical device which can be assigned to a virtual
machine or a user-space process. In this way it fits very well into the
existing abstractions.

> PASID is a property of a PCI device and any PCI device driver should
> be able to spawn PASIDs without silly restrictions.

Some points here:

	1) The concept of PASIDs is not limited to PCI devices.
	
	2) An mdev is not a restriction. It is an abstraction with which
	   other parts of the kernel can work.

> Fixing the IOMMU API is clearly needed here to get a clean PASID
> implementation in the kernel.

You still have to convince me that this is needed and a good idea. By
now I am not even remotely convinced and putting words like 'fixing',
'clearly' and 'silly' in a sentence is by far not enough for this to
happen.

> We aren't talking about mm_struct.

Passing an mm_struct to a device is another use-case for PASIDs, you
should keep that in mind. The mdev abstraction was made for a different
use-case.

To be clear, I agree that the aux-domain specifics should be removed
from the IOMMU-API, but the mdev-abstraction itself still makes sense.

> As above a domain isn't an IOASID, it only does a few things an IOASID
> can do.

For example?


Regards,

	Joerg
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
