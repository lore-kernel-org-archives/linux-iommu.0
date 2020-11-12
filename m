Return-Path: <SRS0=2i4G=ES=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF9FCC5519F
	for <iommu@archiver.kernel.org>; Thu, 12 Nov 2020 16:59:50 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60F4E21D7F
	for <iommu@archiver.kernel.org>; Thu, 12 Nov 2020 16:59:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="PolRm/+9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60F4E21D7F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id D589287175;
	Thu, 12 Nov 2020 16:59:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Cc058zeaOFJ4; Thu, 12 Nov 2020 16:59:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 058AD87096;
	Thu, 12 Nov 2020 16:59:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E2AB1C0889;
	Thu, 12 Nov 2020 16:59:47 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 24FC6C016F
 for <iommu@lists.linux-foundation.org>; Thu, 12 Nov 2020 16:59:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 0A48986497
 for <iommu@lists.linux-foundation.org>; Thu, 12 Nov 2020 16:59:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZiWFzO8mVRMJ for <iommu@lists.linux-foundation.org>;
 Thu, 12 Nov 2020 16:59:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from nat-hk.nvidia.com (nat-hk.nvidia.com [203.18.50.4])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 85C6187096
 for <iommu@lists.linux-foundation.org>; Thu, 12 Nov 2020 16:59:45 +0000 (UTC)
Received: from HKMAIL101.nvidia.com (Not Verified[10.18.92.77]) by
 nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
 id <B5fad69fd0000>; Fri, 13 Nov 2020 00:59:41 +0800
Received: from HKMAIL104.nvidia.com (10.18.16.13) by HKMAIL101.nvidia.com
 (10.18.16.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 12 Nov
 2020 16:59:41 +0000
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.43) by
 HKMAIL104.nvidia.com (10.18.16.13) with Microsoft SMTP Server (TLS)
 id
 15.0.1473.3 via Frontend Transport; Thu, 12 Nov 2020 16:59:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fo5Fylpcqg1c1ICago8gt/nwxngqcg9pwCP0bbD+BLkp2jsR6iGi+ENnqZ+nQSAcxaoFHKAT9haAD9lDmwwTERdrR0gUe3cN0TMUPjwkx2EVNTHn6lFf4SBF18LK9nYfvA0SZW7khOeFL+Kq76OY26We/yxljzw6VVCIufvHFtywQimFw3LLsC0KrgdrKmzBZILVUhzAzZFrWJN1XsFqbHOXLpWtL+gz1rbExdv0+Hh27BRMAqw+mZPzWCg0nd0OIgLytsbnnmw9KrxHarajaR+WiUzqZ6r90qZ+PofZYQlEjdyGcJt0Vsrs7dYAbyQyOh0ZRZ7kV6fBmGyZEO6xLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mjYw2sGjcuhzNrZV2pwl3CFN9OypHf5Gzys0L+0bO88=;
 b=eDtReuw/trq0HvRSUcFSdVLzMQfhELH4HxfF0SpbKRFjiDOwMjpqAuYYMJzNWS5hrPFPdgqlRsephJ0+x15W4iKhfq42XOi3Zi4AYijBC0XWQQSx2ggw0NJeyuF6cBLEKYh2gioP12RzAeKeZzeeXi9tCsXPHr/9Q0Zb4365AuVjFOV5urvOxmxubiOLdM768UGuWaVMkdKK4uxraCaxwk7LLTmIStTmsMwyTPHHjrjdgVOCb/cr3rShpfE2b2TTwvV52hT8gN6bdW+VIDe74F9w8XIBgTYqye8LERz/RyyPaMUVmGbqjcoVds43YQazWxRCLZcYeo36kjfMcM07pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4042.namprd12.prod.outlook.com (2603:10b6:5:215::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Thu, 12 Nov
 2020 16:59:37 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3499.032; Thu, 12 Nov 2020
 16:59:37 +0000
Date: Thu, 12 Nov 2020 12:59:35 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: remove dma_virt_ops v2
Message-ID: <20201112165935.GA932629@nvidia.com>
References: <20201106181941.1878556-1-hch@lst.de>
Content-Disposition: inline
In-Reply-To: <20201106181941.1878556-1-hch@lst.de>
X-ClientProxiedBy: BL0PR02CA0078.namprd02.prod.outlook.com
 (2603:10b6:208:51::19) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by
 BL0PR02CA0078.namprd02.prod.outlook.com (2603:10b6:208:51::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3564.25 via Frontend Transport; Thu, 12 Nov 2020 16:59:37 +0000
Received: from jgg by mlx with local (Exim 4.94)	(envelope-from
 <jgg@nvidia.com>)	id 1kdFwd-003ul0-PF; Thu, 12 Nov 2020 12:59:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1605200381; bh=mjYw2sGjcuhzNrZV2pwl3CFN9OypHf5Gzys0L+0bO88=;
 h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
 From:To:CC:Subject:Message-ID:References:Content-Type:
 Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
 X-MS-Exchange-MessageSentRepresentingType;
 b=PolRm/+9iSArJhGLhQEUp/bdPhYEjooDTEC295gKwXUHVln7M7s9RORnhZwFicZxt
 PncGptw0xN6WVnpE1Bowh2O1W1fTRSWFGW06Z097NJganQnSWr1AFPn17kJhcW1LaY
 Xi/nL3UvYblGvNqK7wgy1A+y0uWNAIHJ0wtvChZce6i0nCIkyGh0PX3x2V9aZJUunc
 +eXQFJiHo8w7cb6aPwHubTNUGraCHyOFi6eW/RljHNZgpyjL0/uAD3g3SuV+++q1a+
 xKipKL9WrtvlzqQoEnB6d1p4Wv2f/sc/c98QFCZHMGrwfWdp9sZuxjxyr3qk6rfJk8
 npTADLGoUnAtg==
Cc: rds-devel@oss.oracle.com, Zhu Yanjun <yanjunz@nvidia.com>,
 Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
 linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
 Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
 iommu@lists.linux-foundation.org, Bjorn Helgaas <bhelgaas@google.com>,
 Bernard Metzler <bmt@zurich.ibm.com>, Logan Gunthorpe <logang@deltatee.com>,
 Santosh Shilimkar <santosh.shilimkar@oracle.com>
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

On Fri, Nov 06, 2020 at 07:19:31PM +0100, Christoph Hellwig wrote:
> Hi Jason,
> 
> this series switches the RDMA core to opencode the special case of
> devices bypassing the DMA mapping in the RDMA ULPs.  The virt ops
> have caused a bit of trouble due to the P2P code node working with
> them due to the fact that we'd do two dma mapping iterations for a
> single I/O, but also are a bit of layering violation and lead to
> more code than necessary.
> 
> Tested with nvme-rdma over rxe.
> 
> Note that the rds changes are untested, as I could not find any
> simple rds test setup.
> 
> Changes since v2:
>  - simplify the INFINIBAND_VIRT_DMA dependencies
>  - add a ib_uses_virt_dma helper
>  - use ib_uses_virt_dma in nvmet-rdma to disable p2p for virt_dma devices
>  - use ib_dma_max_seg_size in umem
>  - stop using dmapool in rds
> 
> Changes since v1:
>  - disable software RDMA drivers for highmem configs
>  - update the PCI commit logs

Lets give Santosh a little longer for RDS, I've grabbed the precursor
parts to for-next for now:

 nvme-rdma: Use ibdev_to_node instead of dereferencing ->dma_device
 RDMA: Lift ibdev_to_node from rds to common code
 RDMA/core: Remove ib_dma_{alloc,free}_coherent
 RDMA/umem: Use ib_dma_max_seg_size instead of dma_get_max_seg_size
 RMDA/sw: Don't allow drivers using dma_virt_ops on highmem configs

Will get the rest next week regardless.

Thanks,
Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
