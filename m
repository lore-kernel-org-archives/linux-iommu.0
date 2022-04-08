Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9378BC433EF
	for <iommu@archiver.kernel.org>; Fri,  8 Apr 2022 15:37:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2634261354;
	Fri,  8 Apr 2022 15:37:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id S_nJbfg8AbSd; Fri,  8 Apr 2022 15:37:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 02DB06135E;
	Fri,  8 Apr 2022 15:37:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C9CE4C0084;
	Fri,  8 Apr 2022 15:37:23 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B351EC002C
 for <iommu@lists.linux-foundation.org>; Fri,  8 Apr 2022 15:37:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8C08C4039D
 for <iommu@lists.linux-foundation.org>; Fri,  8 Apr 2022 15:37:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dRPnZgVQf6wq for <iommu@lists.linux-foundation.org>;
 Fri,  8 Apr 2022 15:37:22 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by smtp2.osuosl.org (Postfix) with ESMTPS id CE89040432
 for <iommu@lists.linux-foundation.org>; Fri,  8 Apr 2022 15:37:21 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id 2C05D1E9; Fri,  8 Apr 2022 17:37:18 +0200 (CEST)
Date: Fri, 8 Apr 2022 17:37:16 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v8 00/11] Fix BUG_ON in vfio_iommu_group_notifier()
Message-ID: <YlBWrE7kxX9vraOD@8bytes.org>
References: <20220308054421.847385-1-baolu.lu@linux.intel.com>
 <20220315002125.GU11336@nvidia.com> <Yk/q1BGN8pC5HVZp@8bytes.org>
 <1033ebe4-fa92-c9bd-a04b-8b28b21e25ea@linux.intel.com>
 <20220408122352.GW2120790@nvidia.com> <YlA//+zdOqgaFkUc@8bytes.org>
 <20220408141747.GZ2120790@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220408141747.GZ2120790@nvidia.com>
Cc: Stuart Yoder <stuyoder@gmail.com>, rafael@kernel.org,
 David Airlie <airlied@linux.ie>, linux-pci@vger.kernel.org,
 Thierry Reding <thierry.reding@gmail.com>,
 Diana Craciun <diana.craciun@oss.nxp.com>, Dmitry Osipenko <digetx@gmail.com>,
 Will Deacon <will@kernel.org>, Ashok Raj <ashok.raj@intel.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, Christoph Hellwig <hch@infradead.org>,
 Kevin Tian <kevin.tian@intel.com>, Chaitanya Kulkarni <kch@nvidia.com>,
 Alex Williamson <alex.williamson@redhat.com>, kvm@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, Dan Williams <dan.j.williams@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Cornelia Huck <cohuck@redhat.com>, linux-kernel@vger.kernel.org,
 Li Yang <leoyang.li@nxp.com>, iommu@lists.linux-foundation.org,
 Jacob jun Pan <jacob.jun.pan@intel.com>, Daniel Vetter <daniel@ffwll.ch>,
 Robin Murphy <robin.murphy@arm.com>
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

On Fri, Apr 08, 2022 at 11:17:47AM -0300, Jason Gunthorpe wrote:
> You might consider using a linear tree instead of the topic branches,
> topics are tricky and I'm not sure it helps a small subsystem so much.
> Conflicts between topics are a PITA for everyone, and it makes
> handling conflicts with rc much harder than it needs to be.

I like the concept of a branch per driver, because with that I can just
exclude that branch from my next-merge when there are issues with it.
Conflicts between branches happen too, but they are quite manageable
when the branches have the same base.

Overall I am thinking of reorganizing the IOMMU tree, but it will likely
not end up to be a single-branch tree, although the number of patches
per cycle _could_ just be carried in a single branch.

> At least I haven't felt a need for topics while running larger trees,
> and would find it stressful to try and squeeze the entire patch flow
> into only 3 weeks out of the 7 week cycle.

Yeah, so it is 4 weeks in an 9 weeks cycle :) The merge window is 2
weeks and not a lot happens. The 2 weeks after are for stabilization and
I usually only pick up fixes. Then come the 4 weeks were new code gets
into the tree. In the last week everything gets testing in linux-next to
be ready for the merge window. I will pickup fixes in that week, of
course.

> In any event, I'd like this on a branch so Alex can pull it too, I
> guess it means Alex has to merge rc3 to VFIO as well?

Sure, I can put these patches in a separate branch for Alex to pull into
the VFIO tree.

Regards,

	Joerg
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
