Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010010.outbound.protection.outlook.com [52.101.56.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7122939D3D3
	for <iommu@lists.linux.dev>; Fri, 12 Jun 2026 19:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781291510; cv=fail; b=h4Sn4Wbwo6RtNIQIQS+xZj2pySUBXDwDPUsaEMTcGW0CrSondQmZEQ+Dw4vA0TgHyVVRcSJr0dk6V25duqSDEBwoRxPOyNa2dObz/H+YFAMd0nrPf1qzxT3GAemH0jKZOXVQHhjvW9g4h0k88Y96yQfOSTSZuBtzH963Vs5+vYA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781291510; c=relaxed/simple;
	bh=CGFL7rcRNPgduubjpfFDdmcgw7sIdhpNPa9VfO2YJrI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SO2tMSFtAqAYfNK2zfwKL4dDtUyeYHF4m4BvWAfaxvM1kSAM3c8WF20mIvqp2PeYlX+p4uLqjFp59oE25CfDI8PXDoDg4vlixWkM2A0o+y8RFSpg+FTH0IP3hugRFQ5OnwpiPmG3ysHQ4zb8Fuo4pnnXizg/pfEvXTOKy9/yjQw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BjFXa9ML; arc=fail smtp.client-ip=52.101.56.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BjFXa9ML"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lWkgdHDVRwL72Uya+woVioZpY8nF/yU11VQVa/iGd9q7x379TDneCFnVPrL65ywdNDzfe1IudE5uYfYhknsAAh7/iYqC/xl+3pyxU/KxIfc7c5zot6im1gJVQSOmmmlpgfgxrhu9irjw8OboOIfkMrnTZHCxNGcn3EX0f+GG/wNtSLtc2KfGXPWKupzpsC4vmX8OzvDuXK//0rpuc5yl9pNcIRJvOeUN2EMS3MiA9lCuLwWH9tnZVaxM+A9ieIK6llyQERJGJDL0HnZGVt2gkmQEz3ayHFNnrIXQgX01/pNDrtllgQM9aXtrCPekuk10jhkjtpOpaT8X1C/fIsi/ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j8JizqIbPHlIecuV91nZmZXGP9oW0pqG3tLusttFP/g=;
 b=dqI+Cb+chRlvu2NMZtveQcfpYmZbUvcdzwAM5ISASyzEGLBkzmNScm+DdsR5h4EIryLmbfRbi9JQ747uP/BzrshjAOUjiG7W15XFi4eD2g+o5dEg2KdSYmvvTZs1SPQxqnEJIgmLangaHeie4qfTO5gnggyBTVlhU++UvQmz0QSDJrXm4zzp9mw0223KaLKRLrsYQH6rB6fsDWfnWqX0q2lA0kCt5IedLf3x/HeVaqw+jG6lnZvXWYOZpZMUDCuh8WMWhsoakEvo6bLD5yQLjB+Q3EJHxc9aDoOCeAd8ISliuKIrBQQndVJXVVI8G1+TqABCdGVkHlPBo2Ru5j7HCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j8JizqIbPHlIecuV91nZmZXGP9oW0pqG3tLusttFP/g=;
 b=BjFXa9MLKyumQWxIz/dLUaImtr9kycynoarnny0Bua4sBrqEaVq+zjQPYGyalwAs4P+fijYiVZQ8HVOiKjgx7wOkpTOy+fO36mxeD5WUpTtY6qyZcXpD2wczOrGMjPeNyqbZH5S7N2ejXgiD0szepdIl4LAW1yoE7Q3w4PcRMfvWK6p4SZpWCDtjpVsr7OXpkBmE07MiEpRWXIr722xViWQM6qD7ePkEkBJvA0GPYyDXsvyUJLeed1lRM6wf43c1+UiUlYEJZR8UcbrfutERwemTvqc+vM2VRuGNkwUZx/Z/D4X0DoJvRUJyG2+2m4jrTX6UvbRvijonL4tD57XcBA==
Received: from MN2PR16CA0066.namprd16.prod.outlook.com (2603:10b6:208:234::35)
 by PH8PR12MB7445.namprd12.prod.outlook.com (2603:10b6:510:217::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.14; Fri, 12 Jun
 2026 19:11:38 +0000
Received: from BL02EPF00021F6F.namprd02.prod.outlook.com
 (2603:10b6:208:234:cafe::25) by MN2PR16CA0066.outlook.office365.com
 (2603:10b6:208:234::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.14 via Frontend Transport; Fri,
 12 Jun 2026 19:11:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL02EPF00021F6F.mail.protection.outlook.com (10.167.249.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Fri, 12 Jun 2026 19:11:38 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 12 Jun
 2026 12:11:19 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Fri, 12 Jun 2026 12:11:13 -0700
Received: from nvidia.com (10.127.8.13) by mail.nvidia.com (10.126.190.181)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 12 Jun 2026 12:11:12 -0700
Date: Fri, 12 Jun 2026 12:11:10 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Will Deacon <will@kernel.org>, Kevin Tian <kevin.tian@intel.com>, "Robin
 Murphy" <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, Shuah Khan
	<shuah@kernel.org>, Pranjal Shrivastava <praan@google.com>, Kees Cook
	<kees@kernel.org>, Yi Liu <yi.l.liu@intel.com>, Eric Auger
	<eric.auger@redhat.com>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH v1 4/4] iommu/arm-smmu-v3: Process vIOMMU invalidations
 in batches
Message-ID: <aixZzvVWmAFEDQZI@nvidia.com>
References: <cover.1780521606.git.nicolinc@nvidia.com>
 <00748c5cbea95a938d032269001a598203b06bbc.1780521606.git.nicolinc@nvidia.com>
 <20260612135409.GI1962447@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260612135409.GI1962447@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6F:EE_|PH8PR12MB7445:EE_
X-MS-Office365-Filtering-Correlation-Id: 19e48bcc-a773-4144-6578-08dec8b66df9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|36860700016|82310400026|23010399003|18002099003|22082099003|6133799003|5023799004|56012099006|11063799006|4143699003|3023799007;
X-Microsoft-Antispam-Message-Info:
	JrxbLH5Dn1Uo8f34umaVZ5yFm4L9bzT9qjhMqGM9ez6MfatFcNrzsTzZWXiZLwet28fqSMjVkr70ArkVrdkupqtkRRkuhTCRIyd+dEIBjM85Y6F8C1E+nt+8HDWP3fiHX+NaqDOfDoqPblPHUD1Q4y8FgY2I0R+DLOu/h6Zw77IqH14M1CCRaEY3RPXthLLgHEWPIf88zgigK7rhsGVoj9OZhTLeoDU/hd+ZYWkJuHkms07mLLxYNI04LJxzSngLhxyxnOND6EZcbxxi7BFd1yoWlwS65NZyj4HMv58/Slmq1QF4NYnlvPqH8qS/XOOvdarUAGcBvA9cygvKtV1xJmuBrJ6jjQnnscCnFQRaQaUxGbwJZtzEBPKV28SOjKpVzusXsgfLbyVI9GeTPmQhyvXm1tRRxmpeCSNTUl+bB0AmtNIluZZZCtCrfum+qyS9s8k3eXUGj+b0SohZQiufHW0YoDZkUZ3ssevHkDHY+NkZixBtHZ+lA6rN3PQa5mQ0VSoOOPNzH2Ft2bdAvNC2RoBWAyPSpreYR8IRVPX9U1Aj4Jp7IJbEYPQ3UnQhXumYo9N6Q7os354ekwHO6hAh1zLoptmY3ObVVLAa7HxvJXyFTs2Z6n+pRLrKFpGHZRCXSXc9gYWlqMFIFbIqhpK8yClDzvO/5TbocXNWROfOQaM4hgubvy4EG3RZJXIpLolG0IdaytcFpO+7Msi5NijkNWHTT9gpf7RQw+gkTa5uk+o=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(36860700016)(82310400026)(23010399003)(18002099003)(22082099003)(6133799003)(5023799004)(56012099006)(11063799006)(4143699003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	tIV9YIc6h4Da6WRZ0WUGbB4Nj/tysvLVpBawvzVhvLF/DlESpCDNclrpLd2b2JaP4St/fTvRMDKtQcsWybMJjq+RrZM4koXkICupsTdRlkfvlb23vCqbPhTi8p7wsKvMo8RMJlmm/R1IBqIni/NN1r8ahOGxLII8zJuTuyy+5pQ8ywLBLhPNP5gRE8Ekr44FVt513An9lGZoxredjjItC81E2b/F2+V1W4U1Daspp6oZpo1NPAJwc4abdyEY/4+ueUJqbb8eOFq1OGh25Y8mx2L5AZOT/6/S67po6F4hvv2yX+AOEo2xcDwANPfMXjah3U+tpuuFdnCTBvwWKl+N1+/Dct9TZohGobn4MrKwA+9LNmX8bYZaWbRfVhFKos3nIMvSqDW5Dm2o4jsUjNCb8ZtXx1ABhcpBd9MQox9jHKu+0CENy0x8gEPoMwXmUwgk
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 19:11:38.5909
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19e48bcc-a773-4144-6578-08dec8b66df9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7445

On Fri, Jun 12, 2026 at 10:54:09AM -0300, Jason Gunthorpe wrote:
> On Wed, Jun 03, 2026 at 02:26:56PM -0700, Nicolin Chen wrote:
> > +int arm_vsmmu_cache_invalidate(struct iommufd_viommu *viommu,
> > +			       struct iommu_user_data_array *array)
> > +{
> > +	struct arm_vsmmu *vsmmu = container_of(viommu, struct arm_vsmmu, core);
> > +	u32 issued = 0;
> > +	int ret = 0;
> > +
> > +	if (array->type != IOMMU_VIOMMU_INVALIDATE_DATA_ARM_SMMUV3) {
> > +		array->entry_num = 0;
> > +		return -EINVAL;
> > +	}
> > +
> > +	while (issued != array->entry_num) {
> > +		/* Process and issue the command(s) in batch */
> > +		ret = arm_vsmmu_cache_invalidate_batch(vsmmu, array, &issued);
> > +		if (ret)
> > +			break;
> > +	}
> > +
> > +	array->entry_num = issued;
> >  	return ret;
> 
> I think every driver will have this same problem, how about lifting
> this loop to the core code?

Sure. I think that makes things a bit cleaner. I'll try that. Then,
this would become another iommufd series.

> Also not sure I like the validation flow, I think it will be easier to
> understand for everything if either num is 0 and nothing was done with
> an error code
> 
> Or num is non zero and no error code.
> 
> Like it doesn't make sense to fail immediately if zero pad is nonzero
> in iommu_copy_struct_from_full_user_array() but then to try to
> partially continue if arm_vsmmu_convert_user_cmd() finds illegal data
> in the very same buffer. Be consistent, validate the user buffer, if
> it is not valid fail immeidately. Then execute a fully valid user buffer.

I don't think fully validating the user buffer is correct..

VMM would have to know which command failed, to flag it in the CONS
register, indicating: a) commands prior to the CONS are issued, and
b) command pointed by the CONS is illegal.

Then, guest kernel reads the CONS register to pinpoint this illegal
command and swap it with a CMD_SYNC (__arm_smmu_cmdq_skip_err).

E.g., if the 16th command in a 64-command array is illegal, kernel
should issue the first 15 commands, returns -EIO; then, VMM should
flag illegal at CONS pointing to the 16th command.

The design in this patch is implemented in this way. And arguably,
I think the nonzero-padding case is VMM violating the ABI, in which
case the return code would be different than -EIO. And VMM should
fix itself instead of flagging illegal in the CONS register.

Do you agree?

Thanks
Nicolin
