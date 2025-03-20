Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2040.outbound.protection.outlook.com [40.107.220.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA29D1B422A
	for <iommu@lists.linux.dev>; Thu, 20 Mar 2025 22:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742509639; cv=fail; b=SjkCYg40AJQoBLcUS1Ef76uiE8y6f8EPtyW1KBG+SGKRjUbjF8ZzXeS7ib+5wmxMSjjy9NcIO/ONaYnv9BEIAfJyxnxF/ctBb75FFLdGPBlj2rZxo/A4mC+BP8lGxLQ2SqD2TUa1LPgRwS6sesBA45x7Pxh++qQpk6pceIyk3as=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742509639; c=relaxed/simple;
	bh=nz4AKJTZ+f9EcRCBmYffm3Zms3bv7ycNcXA/Rg4Qt38=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QIUhGkRlVXdrWUXHDcUsMOeiCm7s2kKD7V/sHUyjEqarwsqFiUysJnm5wSSmrtA7WfACpaGUCh7FvVbd6GLADcR4eMiNLbYcqSE79GoFfj0batHeA0QAQO1lrs4S37INIQX4PSywZrW/7bbT6IMP9VZAVQ5bY56D8e/aRTMhIvY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=omXdMelS; arc=fail smtp.client-ip=40.107.220.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="omXdMelS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JFyXmB1yE8IGcjW0oi9Euc4WUL7wu/IlWoipnB+BLHaELlIkSQMxtjuOjnQoMqr04zupPMgz0OEPWnHu9+HFwKdfJQrqlBZF1ZMgaBR+wjCalG6eChK4ouFi2xaxxTOzbf+gnAYAEXLt3X+RFkzHNAYpv06AS3bVg6D95sssr1yeJJ+8jWUKOGaueVXCPVjsldjF4mS0+K+0uRBdc0yJAdEwS6PK1g0/bwL93P7dhhsVdTJXkhINkXS1NDS0ed6uTsIw5pDR+GWTj2uwvrVeBKTnpiNDz5zglO3LrdqtiSajeiCYGvvf9kLdZm/vvgzdg7vR9zN3LAauT6Fa6aiYzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=soQV+jEWZUP/Juv5NxrkB5VVtkhy3BUCO1+jMOFkfNo=;
 b=uQPAk16pZCCNehFVUm8TavBviD85EjeX2lacLluFRj0pZti9IJGAM7JoJ2KDKXgHv3CX6iqAHO4KHibFqKYvF8lSP8Tsg9g7Sgk1ZMFuHecJ/Gr+OAHoSCpHG62O9qQby+y7mhzJFBAKGwKChP9yma3Ihj1MId/m7jb6rqLP8tkYYvVpYAOI7yXEQXJ7lVZcxwAx2t6MZYj3OghtGq5Sn6HhoZ++3/q9f2HLW0BY4NIwX8ehS1zXrCddW5wH0I1aMRZKkhv0v72auSdcMpk6SawL0vQEKvSFv1aRC+D+wEn76H9kbQAwzNSkKK5MvYa8tRCpvtFmqfKph071VLkoiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=soQV+jEWZUP/Juv5NxrkB5VVtkhy3BUCO1+jMOFkfNo=;
 b=omXdMelSsUlpSfelrCVTE3c4OF2CMnBWdFmIlSdHII8RZQRwDBw1iuoSmAezU+HJYFBotWV+tRrREEh/Ytc88njvDnheNFhjkKRIiq4IlZcA1dQHxMCD42Xy/R39MhzPXesxFuldKwsh+YLi3qH3VdLexCXiTg38ATFae1pLSoGYAPRxA7FDe1YIPu6Ne+ou3dETp6sIgKMm/w2ktfGsu4ibNpfEmL4THg1wQsuFNr3alDsD42RG1xV/JzNxf/7WxZGwFio9NpWUOB1i1i+y/yeZ5u1LuTHV5ZTBVvpF/FFdjIYpPdKulsEszAKGvPHIEnZ9eL1Q/Dt6tr10oalZLA==
Received: from CH2PR14CA0057.namprd14.prod.outlook.com (2603:10b6:610:56::37)
 by SJ0PR12MB6991.namprd12.prod.outlook.com (2603:10b6:a03:47c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Thu, 20 Mar
 2025 22:27:13 +0000
Received: from CH3PEPF0000000D.namprd04.prod.outlook.com
 (2603:10b6:610:56:cafe::bc) by CH2PR14CA0057.outlook.office365.com
 (2603:10b6:610:56::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.34 via Frontend Transport; Thu,
 20 Mar 2025 22:27:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH3PEPF0000000D.mail.protection.outlook.com (10.167.244.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Thu, 20 Mar 2025 22:27:12 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 20 Mar
 2025 15:23:18 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 20 Mar
 2025 15:23:17 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Thu, 20 Mar 2025 15:23:17 -0700
Date: Thu, 20 Mar 2025 15:23:15 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Yi Liu <yi.l.liu@intel.com>
CC: <kevin.tian@intel.com>, <jgg@nvidia.com>, <joro@8bytes.org>,
	<baolu.lu@linux.intel.com>, <iommu@lists.linux.dev>
Subject: Re: [PATCH v10 12/18] iommufd: Enforce PASID-compatible domain for
 RID
Message-ID: <Z9yVU0GSbl+b6C0y@Asurada-Nvidia>
References: <20250320134744.5777-1-yi.l.liu@intel.com>
 <20250320134744.5777-13-yi.l.liu@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250320134744.5777-13-yi.l.liu@intel.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000D:EE_|SJ0PR12MB6991:EE_
X-MS-Office365-Filtering-Correlation-Id: 045b7a83-4754-42af-ff43-08dd67fe5ca4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VOwTA+r+mc/aealN0Y6AlunQNNN1mJq53iQDS+6Xa6MMMFgOIxebSuL1TmrE?=
 =?us-ascii?Q?d3RF3QkiHDBgNKpkdSDQTLeHPFdQELXRzgjKoOWi2ckeBOMRkH6JLNkSa3vW?=
 =?us-ascii?Q?Aa3vbS3cwcNzOC1VO2vAvWDRaZdQQP72Q0MepcNuGaESluUr3wiNOVVTbFKi?=
 =?us-ascii?Q?xHBh3jD2EO6nprYCZ/9aLsLkIp6u36yNCG22YU87+aK/JzPw3TMATKIsRD6o?=
 =?us-ascii?Q?DfedKwBhC5CC/C5Myi28ylXpgqi2NL25KiTaSjVgFOClXv6e/stIVWWbOsba?=
 =?us-ascii?Q?lFqAM+fMMUx/wmr/9JWIVjkK7Sz0EwXqWl1pCNavWi6dVAvz5PjLPcEBNL7E?=
 =?us-ascii?Q?JRpQyzefUPCsx7OvMKGbL03c0JD9su8L/r6wDaJ6yqNLOIvDgBfJ/fh9JzTj?=
 =?us-ascii?Q?veF18nyp+Wi0NPR9ZZEQu2QsPJRZ+Y5Hm2nM55ggY9uWrbyo16+hMD2hh+Of?=
 =?us-ascii?Q?HnizrmUSpgFnMdfqpbktcqJpiimPZPGIIzgvl0xo4nAVbUQF4Op1klWAKiZ8?=
 =?us-ascii?Q?axzIAH3A9asG2cyJ6xXxjMpGZcslIYMQDYFdyRkwI2pnMN1VPWwnUa1TxIoi?=
 =?us-ascii?Q?0mQQPiV1QHMEdjvNST0tO8x7qTJ+9t8S37TRctGv3y99zv9JMNP+Ww4+QJAf?=
 =?us-ascii?Q?MCziSwQGSw2qDI9hQarqSMksnN8O55uHVK81ASAMLS40PobtqQ0i6rW7+WCO?=
 =?us-ascii?Q?RM6FipWgHUqESG522xRMkYsF91QfhGJwt+ymwpViNjUwVrEFTyuUhvMbq19q?=
 =?us-ascii?Q?/dbjUNspMHj2i7Vx1O2vNOLAnKhXVieFrrXAlWuAqWADgla8++uw8nbjIQCC?=
 =?us-ascii?Q?uiieiqU7tIh0bHMaKwu3bxX0BMxn69Xbyhwu7MPMBHnuLPE8Q7X7z8aVVNrK?=
 =?us-ascii?Q?PEnnKkTyCu+Qir3+JlXNT3QGJyFrJKzwWzJEvLjTl+vqrQUUTqHQtSKXK60q?=
 =?us-ascii?Q?o+McwAyC98vk/1j5sY/3YV2xHvDM9j26BdvrHX3dRgPP+IOyijSc9ZNzk9J/?=
 =?us-ascii?Q?vSld7YnfMATtj0F6TjBXJO+F7MDenlM5a6oZG7wLFqvniNaKUMea4hvDKscy?=
 =?us-ascii?Q?aFS6evGo0cy8eOrx0/55uxSG6TFevLVYNOkyPak4PojYMeXG0vuKGl69nRJ/?=
 =?us-ascii?Q?w28AQ9r+y2dJwha4v4b/bfRbC2lC1uYY5JVtlNCnntEUwo2I6qzHfefAkQLT?=
 =?us-ascii?Q?KZ0ZgJ7pxwETM2B4EXZeGOkRYGm81Pe0iso1ZZrfPEtnf+VaeWHz8InatYtU?=
 =?us-ascii?Q?AMRp5BSbxqa5DrLzHX8QUNbNMI+LEppe+X+1uZZBkxdXtewB3f8QFO0REi+v?=
 =?us-ascii?Q?4FVvTb/IjA8ul9AWycSN65ok/7Szxkbs57TCVpYgzfvALiwsAfvTMrwI+0kn?=
 =?us-ascii?Q?gy9LEC60M+lKSeJEITWgDePTIcL20+ArH4cAAx+3DPhx5HC1N8KJ/u7COzRm?=
 =?us-ascii?Q?RbAuxpfRSg/sJ8f0auHClLHZTePEqGPZbC64lanZDlGKids9SxyAWMjqCcjQ?=
 =?us-ascii?Q?fOoHp3AMq0glkJY=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 22:27:12.8899
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 045b7a83-4754-42af-ff43-08dd67fe5ca4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6991

On Thu, Mar 20, 2025 at 06:47:38AM -0700, Yi Liu wrote:
> Per the definition of IOMMU_HWPT_ALLOC_PASID, iommufd needs to enforce
> the RID to use PASID-compatible domain if PASID has been attached, and
> vice versa. The PASID path has already enforced it. This adds the
> enforcement in the RID path.
> 
> This enforcement requires a lock across the RID and PASID attach path,
> the idev->igroup->lock is used as both the RID and the PASID path holds
> it.
> 
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>

A question:

this isn't about pasid_compat, yet...

> @@ -514,8 +514,28 @@ static int iommufd_hwpt_pasid_compat(struct iommufd_hw_pagetable *hwpt,
>  				     struct iommufd_device *idev,
>  				     ioasid_t pasid)
>  {
> -	if (pasid != IOMMU_NO_PASID && !hwpt->pasid_compat)
> -		return -EINVAL;
> +	struct iommufd_group *igroup = idev->igroup;
> +
> +	lockdep_assert_held(&igroup->lock);
> +
> +	if (pasid == IOMMU_NO_PASID) {
> +		unsigned long start = IOMMU_NO_PASID;
> +
> +		if (!hwpt->pasid_compat &&
> +		    xa_find_after(&igroup->pasid_attach,
> +				  &start, UINT_MAX, XA_PRESENT))
> +			return -EINVAL;
> +	} else {
> +		struct iommufd_attach *attach;
> +
> +		if (!hwpt->pasid_compat)
> +			return -EINVAL;
> +
> +		attach = xa_load(&igroup->pasid_attach, IOMMU_NO_PASID);
> +		if (attach && attach->hwpt && !attach->hwpt->pasid_compat)
> +			return -EINVAL;

Should we also make sure that RID hwpt is attached before storing
any PASID hwpt to a !IOMMU_NO_PASID slot in igroup->pasid_attach?

Thanks
Nicolin
