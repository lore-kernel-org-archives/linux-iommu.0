Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2065.outbound.protection.outlook.com [40.107.93.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07B31380
	for <iommu@lists.linux.dev>; Tue, 20 Jun 2023 04:42:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hJDYwPasbKJRkvQUWy0V5EXvDb5NSWw2R0AMe5s0ClLf5K1JvbFp5MMG4+wGJPnqbYz1c8DfwL60YhVoewBwN1Ly3PBvsK9Oi1+tF6etzQDEyfuTTlza5+o/s1wSsCxI889HuLxBbIN0uzCp+FXs9CugjuHgFwjFwo3MxR1TBRvO/wPehJY7kt5mcGAsCjybSFOFZYSxuzg8c0+cXnxEwZYDMm1esIbXD/7cZjn/3ySQy+wtkIwalbPia021C44KD2O1APxqWNDwIjxlQi+OwI8w+8uoJyTtNKbe9ARsVGz5tbmTqVnav/gVCBa4mpnDJ/V5l1O3Xc1Cg/nlZhGbvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wh1H/gKrVnXM5wqFuRv31OLTIDNsZEJtHTDvyWV4J6I=;
 b=fqcFGfJz12LQEFfqdL9wFFT+kfSxNGB/OjIhfZgBmmHq41c6xpny5phRwe6f6W4mLdEr6Hpnw+HDr0smo/UWLBLOsG/o7g93DLfIZTmEQlUUau216a4a4kIO3c5IhZeboeV0AWlZWMnvXKmpt0RfORS3AY2tRrqz3h6ZR7zzfKFTtujVcQsFxH6bcO+Y76tZ6PnpFQTSWzUIWLJgT17gCnJYQU3So3MwBtuctf4QS6IYSWIMEzj4qICLRylnr663cDdHPiV4ddAsKZuua5mRiluhLGdky2hKncSnaj0iPMoAXFKpBwqoPnLENlEqmW1nO4zggzD+cXMNZmcHXSk9qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wh1H/gKrVnXM5wqFuRv31OLTIDNsZEJtHTDvyWV4J6I=;
 b=fT6E40K04TIXXwj6qoxHGOnLa+rgh+R0vsseHwc0HNVUWh7lQ2LbDv1ylQ/VWYG3TjXW3Jp7FlHswYAbTI/IWQyg+LwT9pRsn6VvZhWYrnFtR4cWaX5J4PkudoT5kff8awtuHERxm8Lch4sdJ/fhJ1ubiG7uRpp/C48V1MbbQTUgj7AKSI7S8YFLktzPkJZvxmku+Lmab1XTk6KS9Cc+E5DNShiS2lDPYZTJTsVI14RGO+5v/GZ3hDT/nr5/zL4/xBJ346MmdotAQsnpjL+Ys67cFSWyL91DOyrFeUOC99THbFIwA+usEXe7Ql63p6C7iASmRdSXJN2cZtqdYpw5ug==
Received: from DS7PR07CA0010.namprd07.prod.outlook.com (2603:10b6:5:3af::29)
 by DM4PR12MB6279.namprd12.prod.outlook.com (2603:10b6:8:a3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Tue, 20 Jun
 2023 04:42:24 +0000
Received: from CY4PEPF0000EE35.namprd05.prod.outlook.com
 (2603:10b6:5:3af:cafe::bf) by DS7PR07CA0010.outlook.office365.com
 (2603:10b6:5:3af::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37 via Frontend
 Transport; Tue, 20 Jun 2023 04:42:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CY4PEPF0000EE35.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.17 via Frontend Transport; Tue, 20 Jun 2023 04:42:23 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 19 Jun 2023
 21:42:21 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Mon, 19 Jun 2023 21:42:21 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Mon, 19 Jun 2023 21:42:20 -0700
Date: Mon, 19 Jun 2023 21:42:19 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <iommu@lists.linux.dev>, Kevin Tian <kevin.tian@intel.com>, Lixiao Yang
	<lixiao.yang@intel.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
	<syzbot+1ad12d16afca0e7d2dde@syzkaller.appspotmail.com>,
	<syzbot+6c8d756f238a75fc3eb8@syzkaller.appspotmail.com>, Yi Liu
	<yi.l.liu@intel.com>
Subject: Re: [PATCH rc 1/2] iommufd: Do not access the area pointer after
 unlocking
Message-ID: <ZJEuK3Tw6NnuA/Oi@Asurada-Nvidia>
References: <0-v1-9f7c19e02561+31-iommufd_syz2_jgg@nvidia.com>
 <1-v1-9f7c19e02561+31-iommufd_syz2_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1-v1-9f7c19e02561+31-iommufd_syz2_jgg@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE35:EE_|DM4PR12MB6279:EE_
X-MS-Office365-Filtering-Correlation-Id: ae03e138-7568-43f7-a846-08db7148bda8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	IMAObuMimfcw6R10mweWnfDy73xrS+YRXTuZMeekvhLPyyL/wjs4Pz6cpuF9EKvl720bRRarBLVYWe+QAJM41xQySqyGjxtRDOvzfvkpDtgLKwlAfR6SsRCmiBBtVaCJ8qNrrtNse52Ot45lUMYaZScE9oc0ENwxA948P59uV0eScAQVtCgotNPDS5whZ32H8y0hEOdQnZKVqLjW+5vPsws7Ss3F7Oe6TUgIw/4cmGaynRwyC7tewO7XqUF4panBDptGFqYoDJ8VIcojJt9ekM4cPUmpzW5em0RUqS24dbQxSqsd1cHYm/s5k1pWD9CvEtu2wZ4K6EtCaJF7Syx6d+Xh8entj9VK/H2uZpkbRC3Gpi2k+kmh4ilbulyk5ZainiSy1i9Y6i1fntyDLoeE+rvkjMMz6ysPVbuLFxs2VreSr8Y+e1fRfNlJHsIG1lJ2vk0AfktT42WUz/DAgOrGY/l93RVj9xXCQDyaYpHmtuMxgdyFmVNGTyJUvamgcFk1SG13GPF45EdgLriVrjfDVdtmG2xfNRhsc63Jbpd8HU296QtKWHILeszGIHaBDBJuPEdO/RGaldhWCpyLJt3UiUhFaxXYAhLVfBGEkkZKWexZgl1TyEeFPMcvwwOHJx9P7IAiejySIIueQZ+scbmq+qzvwSS9dBePwJtQ+5R0fJLgYWZ1RiQOSiSp+wHXcA4WBG12mbkgIQ/SZXiLXmhJ5LZO1aGmLN+uxVT8wsEp8dZqUf24xMbywHpOb1OmRzIX
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(136003)(396003)(376002)(451199021)(36840700001)(40470700004)(46966006)(8676002)(6862004)(8936002)(82740400003)(356005)(5660300002)(7636003)(26005)(9686003)(186003)(40480700001)(86362001)(55016003)(36860700001)(47076005)(83380400001)(336012)(426003)(40460700003)(478600001)(54906003)(41300700001)(316002)(4326008)(6636002)(70206006)(70586007)(2906002)(33716001)(82310400005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2023 04:42:23.5494
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae03e138-7568-43f7-a846-08db7148bda8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE35.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6279

On Mon, Jun 19, 2023 at 03:24:58PM -0300, Jason Gunthorpe wrote:

> Precompute what is needed to call the access function and do not check the
> area's num_accesses again as the pointer may not be valid anymore. Use a
> counter instead.

> @@ -458,6 +458,7 @@ static int iopt_unmap_iova_range(struct io_pagetable *iopt, unsigned long start,
>  {
>  	struct iopt_area *area;
>  	unsigned long unmapped_bytes = 0;
> +	unsigned int tries = 0;
>  	int rc = -ENOENT;
>  
>  	/*
> @@ -490,13 +491,17 @@ static int iopt_unmap_iova_range(struct io_pagetable *iopt, unsigned long start,
>  		 * without the pages->mutex.
>  		 */
>  		if (area->num_accesses) {
> +			size_t length = iopt_area_length(area);
> +
>  			start = area_first;
>  			area->prevent_access = true;
>  			up_write(&iopt->iova_rwsem);
>  			up_read(&iopt->domains_rwsem);
> -			iommufd_access_notify_unmap(iopt, area_first,
> -						    iopt_area_length(area));
> -			if (WARN_ON(READ_ONCE(area->num_accesses)))
> +
> +			iommufd_access_notify_unmap(iopt, area_first, length);
> +			/* Something is not responding to unmap requests. */
> +			tries++;
> +			if (WARN_ON(tries > 1000))

Hmm, just trying to understand this piece here...

IIUIC, the iommufd_access_notify_unmap() notifies the vfio device
to do a vfio_unpin_pages() that would do a "num_accesses--;". But
how does the counter work instead? And why 1000?

Btw, there seems to be a small typo in the comments above this
piece of code, though it's not in this patch:
s/iovam_rwsem/iova_rwsem

Thanks
Nicolin
