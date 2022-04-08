Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B2CAC4332F
	for <iommu@archiver.kernel.org>; Fri,  8 Apr 2022 15:59:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 94F8B41C69;
	Fri,  8 Apr 2022 15:59:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TfRzqD7sghQy; Fri,  8 Apr 2022 15:59:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 5334441C04;
	Fri,  8 Apr 2022 15:59:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 120FEC0084;
	Fri,  8 Apr 2022 15:59:28 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 840BBC002C
 for <iommu@lists.linux-foundation.org>; Fri,  8 Apr 2022 15:59:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6C69284347
 for <iommu@lists.linux-foundation.org>; Fri,  8 Apr 2022 15:59:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qpYuL87MwDKm for <iommu@lists.linux-foundation.org>;
 Fri,  8 Apr 2022 15:59:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E18E084339
 for <iommu@lists.linux-foundation.org>; Fri,  8 Apr 2022 15:59:25 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id C43EB62065;
 Fri,  8 Apr 2022 15:59:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E40ECC385A1;
 Fri,  8 Apr 2022 15:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1649433564;
 bh=L/Sp0bHMk3mx20gCUpx3dC8SctQpezEy6viyRYrihq0=;
 h=Date:From:To:Cc:Subject:In-Reply-To:From;
 b=L+lo9BrbQYtTNb1DgX8qbVaefwj4fxENZ6ygVswZmOCj6jOCN4fwQ0t128jZQZcqP
 oE+tKEyuM+tzHDg+kNKbBBUXMaqHJ7M9b+3yuVjqWAnpdETm2UjaLZFVwPpfI738k9
 qsC/CCdiwgwfVTJaObIWfnFHKD9wWez8IpG2fGVrcTYmXP7soBZdStZylnYn3jpLEL
 6WURLmm/sjdcKB/tQigWF8K694tsn0BLmrulsl3+3HBt7euzzB7WNR7ENbF8S6OdLG
 jcORWeAxDxx00czoe/2M0CP9zRBo1yWKngoKpVOO3FpUXY1JFvrFS3mE0/DvjCS3vt
 OGrqAXQzsGUtA==
Date: Fri, 8 Apr 2022 10:59:22 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v8 00/11] Fix BUG_ON in vfio_iommu_group_notifier()
Message-ID: <20220408155922.GA317094@bhelgaas>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YlBWrE7kxX9vraOD@8bytes.org>
Cc: kvm@vger.kernel.org, rafael@kernel.org, David Airlie <airlied@linux.ie>,
 linux-pci@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>,
 Diana Craciun <diana.craciun@oss.nxp.com>, Dmitry Osipenko <digetx@gmail.com>,
 Will Deacon <will@kernel.org>, Ashok Raj <ashok.raj@intel.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, Christoph Hellwig <hch@infradead.org>,
 Stuart Yoder <stuyoder@gmail.com>, Kevin Tian <kevin.tian@intel.com>,
 Chaitanya Kulkarni <kch@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Alex Williamson <alex.williamson@redhat.com>,
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

On Fri, Apr 08, 2022 at 05:37:16PM +0200, Joerg Roedel wrote:
> On Fri, Apr 08, 2022 at 11:17:47AM -0300, Jason Gunthorpe wrote:
> > You might consider using a linear tree instead of the topic branches,
> > topics are tricky and I'm not sure it helps a small subsystem so much.
> > Conflicts between topics are a PITA for everyone, and it makes
> > handling conflicts with rc much harder than it needs to be.
> 
> I like the concept of a branch per driver, because with that I can just
> exclude that branch from my next-merge when there are issues with it.
> Conflicts between branches happen too, but they are quite manageable
> when the branches have the same base.

FWIW, I use the same topic branch approach for PCI.  I like the
ability to squash in fixes or drop things without having to clutter
the history with trivial commits and reverts.  I haven't found
conflicts to be a problem.

Bjorn
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
