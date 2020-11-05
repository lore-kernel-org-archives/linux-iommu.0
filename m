Return-Path: <SRS0=eQNl=EL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ED6EC55178
	for <iommu@archiver.kernel.org>; Thu,  5 Nov 2020 17:53:04 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CC2520709
	for <iommu@archiver.kernel.org>; Thu,  5 Nov 2020 17:53:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Ah4kJARp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CC2520709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id D443286151;
	Thu,  5 Nov 2020 17:53:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id J-oX6SCB+JSX; Thu,  5 Nov 2020 17:53:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 18FE7861D4;
	Thu,  5 Nov 2020 17:53:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E9728C088B;
	Thu,  5 Nov 2020 17:53:01 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A06E8C0889
 for <iommu@lists.linux-foundation.org>; Thu,  5 Nov 2020 17:53:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 8670D861D4
 for <iommu@lists.linux-foundation.org>; Thu,  5 Nov 2020 17:53:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nS7MXLgsccRH for <iommu@lists.linux-foundation.org>;
 Thu,  5 Nov 2020 17:52:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from nat-hk.nvidia.com (nat-hk.nvidia.com [203.18.50.4])
 by whitealder.osuosl.org (Postfix) with ESMTPS id A0C3886151
 for <iommu@lists.linux-foundation.org>; Thu,  5 Nov 2020 17:52:59 +0000 (UTC)
Received: from HKMAIL102.nvidia.com (Not Verified[10.18.92.77]) by
 nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
 id <B5fa43bf90001>; Fri, 06 Nov 2020 01:52:57 +0800
Received: from HKMAIL103.nvidia.com (10.18.16.12) by HKMAIL102.nvidia.com
 (10.18.16.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 5 Nov
 2020 17:52:57 +0000
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by HKMAIL103.nvidia.com (10.18.16.12) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 5 Nov 2020 17:52:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kT6jWBd5lj42nWmxy6QIYmlD1VXymbKlx0r+otRMaeC/HLb/idbh/OtlbZ4BWQ8CRLx+wxe9ZU0tFgLk/Rgq83Txl3znPgmDvAMgjAddxQd3ZYmf4VUaqCRHoEJ73MZbFFeRrmMYZHN0U5Of99AmH4DXX1YenFFHnOpATCHY+H88UsSaWeQx/ecaTXZWw+OMvxQvASKX8ZnQAE6Ewr2UA6BlB3dEz0YDpEMtoEQW0dFhfaQrAorUMhdt4IoeLNrRSd/FzOxoSwOWnNsJTkBadCXNBOQnYyKCr5dGKquv+HkPDBeMOWnv7lr2B7UN3ut1pP4nU7gDUMLKhxpRWyOTHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=esruBjUIV9csi9Z2DV68UuDn0TgwbmhRo4AlIrUG3aM=;
 b=gH8GdHh2gL6Ang8bkN1DmlH+DQ05Y2RS451aERYxtsWLZ8pxTyjh/3gT7V1zTZxaaVCWRfGPka1MdYj7frK5fE+4cUQ46r7tf78KBEo1u0eMo9HgfyceqIJXibwMSPDCuVt+VHryzo9zOqt3V6UnceQ/yjeBDC95i1nbmaQ8K4bEcg/sj3dKeyjwvRldlKCCoFoMu+1JUCf3ZWkysfo6/QE2tESqI8FEImx9dnY4y9wQSg29kqM2UNsr9y+JTEjRCGGcEjOrXNsBrgU9/BO9hPhVeoUiRyp2RMffYhhfxh7LA1idxCDe9La0jl3XkUd5I36sjK8RuT+IBovwl2CTjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3308.namprd12.prod.outlook.com (2603:10b6:5:182::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.24; Thu, 5 Nov
 2020 17:52:55 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3499.032; Thu, 5 Nov 2020
 17:52:55 +0000
Date: Thu, 5 Nov 2020 13:52:53 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 3/6] RDMA/core: remove use of dma_virt_ops
Message-ID: <20201105175253.GA35235@nvidia.com>
References: <20201105074205.1690638-1-hch@lst.de>
 <20201105074205.1690638-4-hch@lst.de>
Content-Disposition: inline
In-Reply-To: <20201105074205.1690638-4-hch@lst.de>
X-ClientProxiedBy: BL1PR13CA0158.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::13) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by
 BL1PR13CA0158.namprd13.prod.outlook.com (2603:10b6:208:2bd::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.13 via Frontend
 Transport; Thu, 5 Nov 2020 17:52:54 +0000
Received: from jgg by mlx with local (Exim 4.94)	(envelope-from
 <jgg@nvidia.com>)	id 1kajRN-0009F7-BJ; Thu, 05 Nov 2020 13:52:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1604598777; bh=esruBjUIV9csi9Z2DV68UuDn0TgwbmhRo4AlIrUG3aM=;
 h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
 From:To:CC:Subject:Message-ID:References:Content-Type:
 Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
 X-MS-Exchange-MessageSentRepresentingType;
 b=Ah4kJARpCj0xBw/Ygap1PJau2gU9YIZ8Y3K+7V5srjsdPYs+Q4B3ud0uUky73Sm12
 ZSZBAVEyNYqZ12rk6EMJKrcgJQgLzM+YwJdhPJtfgFyebmqfy/rSZmSIgncUyEu1fU
 8V+gMcjtsyeiXtC/apDLQ5BgII6ODsB04lhDjWVfI0ufBDaKFfLyp6dCQZO9uzn7zL
 0Y6hzmQ+NN53i4KnMgi6C00+HKR39UMJpnOTO6AGGo8kyWz06aHHEYtNwTJYliouDB
 b3PiGkW0kNv4offwLexQQ2ETxoiZXeVZVFV8iJl8bvgh0PAcgpS84aC5T4YCw4bpw7
 5FdAC60p0+wSg==
Cc: Zhu Yanjun <yanjunz@nvidia.com>,
 Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
 linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
 Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
 iommu@lists.linux-foundation.org, Bjorn Helgaas <bhelgaas@google.com>,
 Bernard Metzler <bmt@zurich.ibm.com>, Logan Gunthorpe <logang@deltatee.com>
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

On Thu, Nov 05, 2020 at 08:42:02AM +0100, Christoph Hellwig wrote:
> @@ -1341,7 +1322,14 @@ int ib_register_device(struct ib_device *device, const char *name,
>  	if (ret)
>  		return ret;
>  
> -	setup_dma_device(device, dma_device);
> +	/*
> +	 * If the caller does not provide a DMA capable device then the IB core
> +	 * will set up ib_sge and scatterlist structures that stash the kernel
> +	 * virtual address into the address field.
> +	 */
> +	device->dma_device = dma_device;
> +	WARN_ON(dma_device && !dma_device->dma_parms);

I noticed there were a couple of places expecting dma_device to be set
to !NULL:

drivers/infiniband/core/umem.c:                 dma_get_max_seg_size(device->dma_device), sg, npages,
drivers/nvme/host/rdma.c:       ctrl->ctrl.numa_node = dev_to_node(ctrl->device->dev->dma_device);
net/rds/ib.c:                                              device->dma_device,

No sure what to do about RDS..

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
