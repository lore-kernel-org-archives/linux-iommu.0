Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013063.outbound.protection.outlook.com [40.93.201.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE101F0991
	for <iommu@lists.linux.dev>; Fri, 10 Apr 2026 22:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775858816; cv=fail; b=FC+nMOI+CKCjvHQrAcuEmhRp19RO52vm4haEFRpvCusL4DOdGalqKdpgMlLNewMtgkfFhUneY+LyURIWLX9GjVugJHkdIZuS4MPYazZBuqgJMdIGRDUbGu52/37vE5ihuuescRyhTpO1TwfXZxCObIgr8BirMxYXFbT45iOf304=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775858816; c=relaxed/simple;
	bh=Xh4rczV2JndIGcORkZwmgdkdvFKs0DXGttscBNuFUzE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qG6hbYkZW5NpShH4AnaZ9LAl6JsTH+T8jGISwPkwIK5M/AlgocGTiXBvrqi2vDE5HD1EEWS23pw4b6TXPKi1Ox9yLPVf2mLDmvkIwmirDSuI6UR4LnpQTJcV+V4IPRgi18mZvwB3tXCKn5q9vWLS3M0PlvTswQzFijjt3gwrMw0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uGH9MgYU; arc=fail smtp.client-ip=40.93.201.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uGH9MgYU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s1k50b1wEFvgSsKb2bhpPRAd222KE3+KWT0z+aHn2KYD1gBPqGxzDs7ChRPnBkekIrD71X/7k7NFxmFm/HZ0n+tcUMGocQFqPhroeEyoX5mxU4DjKG9DalXpIZgkSDRglhFacZ7z2KcpAOOrXdp2co6Vm4fZlILzHOA6gtvuaOBn/Xgg4jMfeihRLRE/PjV5RuiCMTKgKwtG/J04y9YMc5EuBvDh6+PNr/ILNzWJnQaXwaEB4vn6H4T5Xrh3gfHkkJ+Y6tZWNNa6eLimWElupC0cAwDyJntOX3Xq4jpCsszznaBdQC5d4JYS1HCi7sF6msJBuWWQjGxLfsE3WfSKCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mHQY2sKvQ6ToTZWyHX+tcNsJY/woHZyxFxEt2908S7Y=;
 b=t00ClX+84AHziOqzQdMaGmqxdD1WsTdyfN+VHd+PGivEs9c+CNocO6+4UgKEu9LjxgKZZiM0Q/+eYWdUzRIALLpnMrQafCmx7yYA/V5yB+4zD+Q5zhIlYBa3K5wq2sNptKNot97gKv+t2gkLmLI2EDsXPpWuOAcLD77aqPyd6eNIhmG6zeEop1gWOXg8XcuF6HgbGkYrjDP8n8Mr0XIHxB2CPnl3zxCOoBlGJkB/qs1CtGZRr/yEmqzzuZKaDgwd+SHxDdXT4v+dikrD2a1mtPPNcvG0y6slf7VQQdF+NSolrj0emuNf0MM9cMyQ9X/n6rq3yTB2hVj1cizD5R4Shw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mHQY2sKvQ6ToTZWyHX+tcNsJY/woHZyxFxEt2908S7Y=;
 b=uGH9MgYUqidD9BIgOTka2HEO+U4S+5zPCLf4OwIn/HG64ODHb39VuhAnyySiL95H+oKVC3Jm0azHP+IzrLR2R3c/1jJBvg9w4XCilREdlkLPAgprfJWvKm0+ohMygyWzO0q0n2eqwiG4RyaZm0YyLizmKsOpoTUEnQ01QFULwzwLkVF+fNNAib62OLnhoWxC4stMnnCN3DFPBPbRsgLvNdWKPSLxaegcO/6Z2iwKE+Osf6ATtHluAAY7vWCQPlHmuJ42n3heLdpmZo9BPtrwtMmoRVXhFqudgGcw5vXXSDfRJC5rwrxuJkJyrwN6vglJEgDOJQAeMVuRWqu6mQVDQw==
Received: from PH8PR02CA0023.namprd02.prod.outlook.com (2603:10b6:510:2d0::15)
 by PH8PR12MB7280.namprd12.prod.outlook.com (2603:10b6:510:220::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.42; Fri, 10 Apr
 2026 22:06:48 +0000
Received: from CY4PEPF0000FCC0.namprd03.prod.outlook.com
 (2603:10b6:510:2d0:cafe::e0) by PH8PR02CA0023.outlook.office365.com
 (2603:10b6:510:2d0::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.45 via Frontend Transport; Fri,
 10 Apr 2026 22:06:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CY4PEPF0000FCC0.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Fri, 10 Apr 2026 22:06:47 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 10 Apr
 2026 15:06:35 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Fri, 10 Apr 2026 15:06:34 -0700
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 10 Apr 2026 15:06:34 -0700
Date: Fri, 10 Apr 2026 15:06:32 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<jpb@kernel.org>, <praan@google.com>, <smostafa@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<jonathan.cameron@huawei.com>
Subject: Re: [PATCH v4 09/10] iommu/arm-smmu-v3: Remove ASID/VMID from
 arm_smmu_domain
Message-ID: <adl0aEfBAKmBsMs6@Asurada-Nvidia>
References: <cover.1773949042.git.nicolinc@nvidia.com>
 <b6d87a722635d29e896b277cb60f0208859073d6.1773949042.git.nicolinc@nvidia.com>
 <20260410002734.GC3357077@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260410002734.GC3357077@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC0:EE_|PH8PR12MB7280:EE_
X-MS-Office365-Filtering-Correlation-Id: 60835ea3-1edc-41d5-f815-08de974d75ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|376014|7416014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	RTcrAO0DOhJ8bCBx4Ku/OYuMCE9khHB/WoLyrg3LyqtSQj0I54h7Ml5ApevL0Z3i9Q3K+6ulT+1Ksu0LqDzN8CoJ1I9iScsj3g+fl+I4dIItNns0gIJpXGOgyJ7P2mUSRRjvkx6C1Hmb9gLmpmXpcCgDNo+Plidg1qEK5k8ZkcRZ/YDh/uL+9BQPvY9xTxNCOWF7XCMn6rmCOn2TNB+kEZwHTJwyQVw2PxDH7cDM4vtYTeAxlcfK0x+qQD2lNs8pHTCOew/zSAn7NcxW6AXkhDz8bBoJPe0l3oGXhH809C28XlK4rNMECbOaFwY+TWuuqcJH7L5+qJUj19AwCgM9joZPL8FC8bbMr3nYs8P6zcELr8HJp59tUxGveYfbbF89Sb9UTA7A9f9F+mOG6yZcmdeHs19slf9WWbl6smOWJu/n9gCBWtM22kQ1yaPDEkDROU1/GiNxI3MQW6rD/Ty1piAI5pyvM8Je+j7hIdiwdPFjdditmezYkqKK88rzgrcef3MTgtuI1drJVCLhfZHukK7v1M4IPwN05ajFKnGWtCVOir+8WyDKVfLLSR6SwTsqmtEaHT2IlNKftYhIAYZmxENb3nlipNx+pLwPxPNtu6F5FaMailAo05CeMpaTMqEPmz6UpllTRGodLQZCJutC2XuS3csK/ythaP2dyOLo0hIH40/0K+n1LX++BFPlCaGeUJV/H7XVHaxSwlBG6cD28a8xvBW0A3j5nXozBBSW6FR5nks2LJJ1qdR0QELS9t3ieidjQeo3FwTqAHnLtM2RQQ==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(7416014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	zK59KaLunRjGuVaSq91smkR+2mGYCJOGAgKqZL6lEmYRVnIYnWTDA8WBP44QGXJZvxLvdAEXKqx3amQOtHadGc6Wu4Mk2oJ+fvnOA4q/eSc9gk+lunqzHYvsgvnO/kZ8zIBkft+UGzezu64ZgH5uqWVzBoX0WQdtxal2HaCR92SwBc+ILjCjEghyYEFCrWKaHJr54d8UWJkQ2ZsbnaWV9nQqFELeVCj9oZwhjpbCGDLfmGneUdDZe5uTDC8cvIhwoUe4iLOVs1zJGxT6ijrjLWIuCbvbB/PaSy1Cff8vxvOq1rRVk3OLgUwfwXddj6/n1E4SFlk23hMpDcdprFJKziXJtEX6q6JtR9oDJCsjmGka6pz/azFfjRi2JeqC/sQ1BoNAtoPxZl/67fyyZ+qjCjrF5ypxKaAakE8U0yz+qZl3bE3KCTOnjojSJIUhjwyx
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2026 22:06:47.7205
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 60835ea3-1edc-41d5-f815-08de974d75ea
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7280

On Thu, Apr 09, 2026 at 09:27:34PM -0300, Jason Gunthorpe wrote:
> On Thu, Mar 19, 2026 at 12:51:55PM -0700, Nicolin Chen wrote:
> > diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> > index 846a278fa5469..0e48264ccd01b 100644
> > --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> > +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> > @@ -300,14 +300,6 @@ static void arm_smmu_sva_domain_free(struct iommu_domain *domain)
> >  	 */
> >  	arm_smmu_domain_inv(smmu_domain);
> >  
> > -	/*
> > -	 * Notice that the arm_smmu_mm_arch_invalidate_secondary_tlbs op can
> > -	 * still be called/running at this point. We allow the ASID to be
> > -	 * reused, and if there is a race then it just suffers harmless
> > -	 * unnecessary invalidation.
> > -	 */
> > -	xa_erase(&arm_smmu_asid_xa, smmu_domain->cd.asid);
> > -
> 
> I don't think this artifact has disappeared so the comment should
> probably remain too. It has become slightly different because it is
> now running under RCU protections so it will clear alot faster.

By taking a closer look, I think either the arm_smmu_domain_inv call
above or any concurrent arm_smmu_mm_arch_invalidate_secondary_tlbs
call is a NOP now?

We reworked the ASID lifecycle, which now ends when the last device
detaches. So, ASID was free-ed in arm_smmu_iotlb_tag_free() that did
a per-ASID flush also.

So, when freeing the SVA domain here, the domain should have an empty
invalidation array and the HW cache is flushed as well, right?

Nicolin
