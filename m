Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 035D4C433EF
	for <iommu@archiver.kernel.org>; Tue,  5 Jul 2022 17:42:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7D7838145E;
	Tue,  5 Jul 2022 17:42:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7D7838145E
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=E+wsESQz
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hluBX3I6-S5t; Tue,  5 Jul 2022 17:42:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 381C28143D;
	Tue,  5 Jul 2022 17:42:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 381C28143D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0B5BEC0032;
	Tue,  5 Jul 2022 17:42:40 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B8B4CC002D
 for <iommu@lists.linux-foundation.org>; Tue,  5 Jul 2022 17:42:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A244D81352
 for <iommu@lists.linux-foundation.org>; Tue,  5 Jul 2022 17:42:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A244D81352
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gbdHlhPRkDmi for <iommu@lists.linux-foundation.org>;
 Tue,  5 Jul 2022 17:42:37 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 517918133A
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 517918133A
 for <iommu@lists.linux-foundation.org>; Tue,  5 Jul 2022 17:42:37 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 01C0361876;
 Tue,  5 Jul 2022 17:42:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4620C341C7;
 Tue,  5 Jul 2022 17:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1657042955;
 bh=18T9JrVrQmGUhIeB/JuQTrGy9yUM/iGt2yUQiwv239s=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=E+wsESQzjBq0Jm7GRcNunkZNg/B9u9pWxluE8Hvyw5c8ngmjtRMeYZplVgH18CEMg
 +CWBPqMRpf6vtqHc8uVHP4AxL8xobnRkwM4XtCynMLc+/O8b28/frnTwxcKPJt8aG2
 gLkaIa6aOTwyOr/X8xpnr7Wu6h8BVukKTtB9ibvU=
Date: Tue, 5 Jul 2022 19:42:32 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [PATCH v7 20/21] PCI/P2PDMA: Introduce pci_mmap_p2pmem()
Message-ID: <YsR4CNDgtt4JWonv@kroah.com>
References: <20220629175906.GU23621@ziepe.ca> <20220705075108.GB17451@lst.de>
 <20220705135102.GE23621@ziepe.ca> <20220705161240.GB13721@lst.de>
 <a509b13c-244b-23fc-f989-339750a733a5@deltatee.com>
 <20220705164315.GB14484@lst.de>
 <acb91f37-0470-8ce4-19e4-426903cbc3a1@deltatee.com>
 <20220705165039.GB14566@lst.de> <YsRzNqmZYlgkL7fI@kroah.com>
 <1bd43ef7-0403-bd25-087c-d54d5af677e4@deltatee.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1bd43ef7-0403-bd25-087c-d54d5af677e4@deltatee.com>
Cc: linux-pci@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
 linux-nvme@lists.infradead.org, Stephen Bates <sbates@raithlin.com>,
 linux-mm@kvack.org, Jason Ekstrand <jason@jlekstrand.net>,
 Ira Weiny <ira.weiny@intel.com>, Christoph Hellwig <hch@lst.de>,
 Minturn Dave B <dave.b.minturn@intel.com>,
 Martin Oliveira <martin.oliveira@eideticom.com>,
 Matthew Wilcox <willy@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
 Bjorn Helgaas <helgaas@kernel.org>, Daniel Vetter <daniel.vetter@ffwll.ch>,
 Ralph Campbell <rcampbell@nvidia.com>, John Hubbard <jhubbard@nvidia.com>,
 linux-block@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Xiong Jianxin <jianxin.xiong@intel.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
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

On Tue, Jul 05, 2022 at 11:32:23AM -0600, Logan Gunthorpe wrote:
> 
> 
> On 2022-07-05 11:21, Greg Kroah-Hartman wrote:
> > On Tue, Jul 05, 2022 at 06:50:39PM +0200, Christoph Hellwig wrote:
> >> [note for the newcomers, this is about allowing mmap()ing the PCIe
> >> P2P memory from the generic PCI P2P code through sysfs, and more
> >> importantly how to revoke it on device removal]
> > 
> > We allow mmap on PCIe config space today, right?  Why is this different
> > from what pci_create_legacy_files() does today?
> > 
> >> On Tue, Jul 05, 2022 at 10:44:49AM -0600, Logan Gunthorpe wrote:
> >>> We might be able to. I'm not sure. I'll have to figure out how to find
> >>> that inode from the p2pdma code. I haven't found an obvious interface to
> >>> do that.
> >>
> >> I think the right way to approach this would be a new sysfs API
> >> that internally calls unmap_mapping_range internally instead of
> >> exposing the inode. I suspect that might actually be the right thing
> >> to do for iomem_inode as well.
> > 
> > Why do we need something new and how is this any different from the PCI
> > binary files I mention above?  We have supported PCI hotplug for a very
> > long time, do the current PCI binary sysfs files not work properly with
> > mmap and removing a device?
> 
> The P2PDMA code allocates and hands out struct pages to userspace that
> are backed with ZONE_DEVICE memory from a device's BAR. This is quite
> different from the existing binary files mentioned above which neither
> support struct pages nor allocation.

Why would you want to do this through a sysfs interface?  that feels
horrid...

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
