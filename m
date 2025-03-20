Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2060.outbound.protection.outlook.com [40.107.93.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A232B1DE8A8
	for <iommu@lists.linux.dev>; Thu, 20 Mar 2025 23:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742512947; cv=fail; b=KjaGHjmLmvv37IZZpLK3FD80DcgqO0YiM8vVc2rSH5nWK8rHf2Cm2d7rDrBSiC9IANyINgRdTp5t/ixabz/Vil2dx76Nxi/BuXYnOeJYD4jdEPPQ41K/lFDIMW3aW7T+j/5YO1QrL0ioKXdHmqPw/bQXoW4IzmQwsg4N0HpT+dI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742512947; c=relaxed/simple;
	bh=8drlotwRNzddnKzJaSe2nk2kArke+xMCwuFGHRgqGHI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WHOxnvQm0tSr9z/0LDDmunNSc/ZJWYCE2j3uv9zc1ec/S6h0t6yY9rckQX04Vo/BVjv+i50tXqFnkuyImfDsk3P5G3/z5hB2itQJ+KUQN06LRRM/kjf2oU1UNszmQvvaxzftC8HtO0ClbSqjKns2+bvtCYmt3c97yfcsLEBoKp4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cdGo6Rs9; arc=fail smtp.client-ip=40.107.93.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cdGo6Rs9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qtsugy2aoYmwmHLevGEwTwnenrDqC95DlvW5UlVZh73MHwqPfy1hQhFXmzpJEEH7rnaBh20gRQSxrTSdwE+a03eZCjLhQzbmbWdyRVwPQL0XI1mrYudbw6+zWZhafcipsqf05sTPlrMB/EvUm00pEn9gr3OIorbkK4iVKYwI0aCr5rnY5fh+mtj+U+vl7Sn6lLu7E0hiFVxWmp0gPZc81jVMUuL41xzxX38Zn+En/yNbHCPzAO0w7M+9Sx7jWeTjocDA2ImBps2/j6FHz92zqnInazhnYzJM2e62HzrMs+voRZDd/L3gcYRzdOGNjXyEtwMR9G7lJFNGCYz0PdlXyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OuJIay/xbzGhMxr6iWg6dlRJaFpatGpj0lUS8gAnazE=;
 b=Tsx0tfVNDfscomz6jDEdMPRVlfaWsYbe6Mi+2TP0frkEOfCz/cBAMBBxKlXlyjgyO1XBgU/U9iSX9U8GbJAjINXS5ZO7ZeZm8NR8ViYY1F/ES0jZCO4x5g/aNPkEbnfFEPeK/mSVmIsiFw0rGdygq59SmMGbXGjMcM6eKedbvEMI1nBq0Y30VQZFds5jjSzjpuAgU1u8LlMzsfj4oDjb1Mawex6boi4IE/ldTUPlKdVx7gd27KH5r6eNblB4EmnZodheIESEb5AMnKPqmm69NcRdUQzzxOezvP8TImIyvswkJuRQUdyLG7UDzKqdKiGa8RLRWLEq82/Kt8To+U3BBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OuJIay/xbzGhMxr6iWg6dlRJaFpatGpj0lUS8gAnazE=;
 b=cdGo6Rs9ulB2oPSKnd1ArD7THwN92El1kM0md5sjJEl7kSdUd+c0M0NWTVKX1RsHSeTt/3lUdmq75lBWw0mY1bkcUm0gP5Ase1ceo6wQY5iXKVkOZp2mYRRV40Y5DlOS1B7EvKoUzyeiOiP+Nx101Oe3yb5151gI9BVPRyOuSgVXehjlNIiQdAs+K4WtdTTO4RR9a3fTyFds+z1JSHgYXKqf26yzpBIXh7KAkfwcRC/fukLSCtt4Rf1HCyBtdf3FosNkWDI/Hc/ulUKIE/9oXwSSIG/iIKUTAcNnuQL74BNDcaNU5YR+l3tsGEZTe1FLrrRpI10o50ypgPNkG39hIw==
Received: from SJ0PR05CA0192.namprd05.prod.outlook.com (2603:10b6:a03:330::17)
 by PH7PR12MB5760.namprd12.prod.outlook.com (2603:10b6:510:1d3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Thu, 20 Mar
 2025 23:22:17 +0000
Received: from BY1PEPF0001AE1C.namprd04.prod.outlook.com
 (2603:10b6:a03:330:cafe::f9) by SJ0PR05CA0192.outlook.office365.com
 (2603:10b6:a03:330::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.33 via Frontend Transport; Thu,
 20 Mar 2025 23:22:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BY1PEPF0001AE1C.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Thu, 20 Mar 2025 23:22:17 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 20 Mar
 2025 16:18:02 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 20 Mar
 2025 16:17:54 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Thu, 20 Mar 2025 16:17:53 -0700
Date: Thu, 20 Mar 2025 16:17:52 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Yi Liu <yi.l.liu@intel.com>
CC: <kevin.tian@intel.com>, <jgg@nvidia.com>, <joro@8bytes.org>,
	<baolu.lu@linux.intel.com>, <iommu@lists.linux.dev>
Subject: Re: [PATCH v10 17/18] iommufd/selftest: Add test ops to test pasid
 attach/detach
Message-ID: <Z9yiIEaWyMGyyc2A@Asurada-Nvidia>
References: <20250320134744.5777-1-yi.l.liu@intel.com>
 <20250320134744.5777-18-yi.l.liu@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250320134744.5777-18-yi.l.liu@intel.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE1C:EE_|PH7PR12MB5760:EE_
X-MS-Office365-Filtering-Correlation-Id: 18707a38-02a0-43cd-9858-08dd68060e62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?awBM4xA0X6gaKIrmxnZJ96WCjhHp21FSIgseqCeOPaft9pbxT6Vqe1xAxFto?=
 =?us-ascii?Q?lOWe1njwdqk8dtVWDdi2mojqj8d1F2Fi/7718pLryH8tYKVUa6NGO53bQOr4?=
 =?us-ascii?Q?7PEQ7mBI7U1Lf+BFENao4Pf5b4hfFNOflPjPARZiJSs1pfgxpPOUk9uTPpdr?=
 =?us-ascii?Q?6OR4JHo8o6j2JdkD4reGkd/Itblxf8YGG8nE/IuXN02Yit3NnLiZlNPjBHq/?=
 =?us-ascii?Q?5ectI4jS8F3yI9tKSyuRVUAL4+Rgtqi9hx1ScXx7WWBL9vHGFFZx+11dY8AB?=
 =?us-ascii?Q?KtmjwL3J4IzaDosq9HJPwMonkc/Pily80cCF7WC0ANAGzJtvK3w5AoodZlzU?=
 =?us-ascii?Q?eXU5RASX6Wsgc3Gn48C61mvCt+WANFmaJ3KKDYTW+4bbFRlgEeVJjyMYTeZX?=
 =?us-ascii?Q?WW4/JClBDNfkhi+DYWF1nhzab3ctFEMdYjPtzUDLUQKMED43PvPbVvjy3yhn?=
 =?us-ascii?Q?5uj15505jYOLuIAgULyT7RW2hgfBmwFs/r2iowq+dlUFgPv/qb2kyx9xHFIx?=
 =?us-ascii?Q?OdEnFHLGMkZw3CiH/Iv0Fm0zf/RYY1GVOmDxpyAg85LIQY8kxwI5kJJpdx4D?=
 =?us-ascii?Q?Oj1sT+i/2UlPKyMgjHvNYPPGPbb5DVCdVWB32DRoGe2kEpG34FruYeTLqxuq?=
 =?us-ascii?Q?vcui9YXz+/xYSA1cHAgeQjsQaSWHz7iHs7JRjcZWqfMK6BOyzvUXFLBmPOSx?=
 =?us-ascii?Q?RGUFkyaNuKASXmh/cdmVfDVzGrQuPwLnz79tycqr+xL/0t1RG8JwPjyp/0Hq?=
 =?us-ascii?Q?gECmNwJeld9ASTtliS/VcVyCgPGVq+/+KPvJq+4MgfNUvZ7yMpd/kKH6GO+n?=
 =?us-ascii?Q?6uX2khYZgK07LoJlJYLaM0xxqVHmO7ZTzTW1OEBmfG3H//MFbUtMf11YNbXr?=
 =?us-ascii?Q?YtfxqxMk+chdMfPV+6uzJ9s3cs7hfhBp6LGkugscIQ8SqaW+TyAJdIZt0UIF?=
 =?us-ascii?Q?ypLtKbjlwaKMP+4RPKkejwMICa8StjuCexPS2/YsTixLq72OS9UhN8eU87RJ?=
 =?us-ascii?Q?TDULukzjXNPLRb314rMfvjlvR2vyi9mm7tiB6pV4JU/UyM082ik7zBIWCMGP?=
 =?us-ascii?Q?pjPe7p6ow2uY2QmeRYAoOPxcnbVHPbTshPea2gvPnXUbLZXtGYwwkO+mQRks?=
 =?us-ascii?Q?5gavC3rXJxCiQn4SV1NFpLiGiA63TqWGgVsxxI6o3xppg/cl17TmVX5kLAx6?=
 =?us-ascii?Q?GlUr1rdoPJ8WIs7TVxYO+FBt9ixLsUguasbGgoGP2q9ND0OXolDAYdn6DNeK?=
 =?us-ascii?Q?Qu7fdOCQfoqDx8IU2aK5r6X77RX/rOm6yrPl69czmt3FLVmOeInyu9RV3poS?=
 =?us-ascii?Q?cT6XI4fCxhVXu1jO7fmdzn2OjJbpXDhufgtPCzlzWJZu0kRBFmrEzjKrFU4i?=
 =?us-ascii?Q?BdTI6RX5TQ4HvPu0UyK2eUUy5sVXNiVuO8xALuCrdRs4imMuimtbTBMz9yD9?=
 =?us-ascii?Q?xWe+AFPWcw/ykU1a820OY6Wc2r8qBUj3Bya8n0uMFS70Doj+YtEIGm5jGigQ?=
 =?us-ascii?Q?5WWMgW+kONLmXdE=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 23:22:17.5664
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18707a38-02a0-43cd-9858-08dd68060e62
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE1C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5760

On Thu, Mar 20, 2025 at 06:47:43AM -0700, Yi Liu wrote:
> @@ -150,6 +155,32 @@ struct iommu_test_cmd {
>  		struct {
>  			__u32 dev_id;
>  		} trigger_vevent;
> +		struct {
> +			__u32 pasid;
> +			__u32 pt_id;
> +			/* @id is stdev_id
> +			 * pasid#1024 is for special test, do not use it
> +			 * in normal case.
> +			 */

How about add on top of these structs:
#define IOMMU_TEST_PASID_RESERVED 1024

Also, the coding style of the multi-line comments is a bit odd.

> +		} pasid_attach;
> +		struct {
> +			__u32 pasid;
> +			__u32 pt_id;
> +			/* @id is stdev_id
> +			 * pasid#1024 is for special test, do not use it
> +			 * in normal case.
> +			 */

Ditto

> diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
> index 691e7a23f300..37c9cd285541 100644
> --- a/drivers/iommu/iommufd/selftest.c
> +++ b/drivers/iommu/iommufd/selftest.c
> @@ -223,10 +223,29 @@ static int mock_domain_nop_attach(struct iommu_domain *domain,
>  	return 0;
>  }
>  
> +static bool pasid_1024_attached;

I recall syzkaller would do multi-threading... We might need a
global mutex or something atomic_t?

>  static int mock_domain_set_dev_pasid_nop(struct iommu_domain *domain,
>  					 struct device *dev, ioasid_t pasid,
>  					 struct iommu_domain *old)
>  {
> +	/*
> +	 * First attach with pasid 1024 succ, second attach would fail.

succeeds?

> +	 * This is helpful to test the case in which the iommu core needs
> +	 * to rollback to old domain due to driver failure.
> +	 */
> +	if (pasid == 1024) {
> +		if (domain->type == IOMMU_DOMAIN_BLOCKED) {
> +			pasid_1024_attached = false;
> +		} else if (pasid_1024_attached) {
> +			pasid_1024_attached = false;
> +			// Fake an error to fail the replacement
> +			return -ENOMEM;

/* Fake an error to fail the replacement */

While failing this, why does it detach pasid-1024? Maybe some extra
comments for what's doing?

> +static int iommufd_test_pasid_check_domain(struct iommufd_ucmd *ucmd,
> +					   struct iommu_test_cmd *cmd)
> +{
> +	struct iommu_domain *attached_domain, *expect_domain = NULL;
> +	struct iommufd_hw_pagetable *hwpt = NULL;
> +	struct iommu_attach_handle *handle;
> +	struct selftest_obj *sobj;
> +	struct mock_dev *mdev;
> +	bool result;
> +	int rc = 0;
> +
> +	sobj = iommufd_test_get_selftest_obj(ucmd->ictx, cmd->id);
> +	if (IS_ERR(sobj))
> +		return PTR_ERR(sobj);
> +
> +	mdev = sobj->idev.mock_dev;
> +
> +	handle = iommu_attach_handle_get(mdev->dev.iommu_group,
> +					 cmd->pasid_check.pasid, 0);
> +	if (IS_ERR(handle))
> +		attached_domain = NULL;
> +	else
> +		attached_domain = handle->domain;
> +
> +	if (cmd->pasid_check.hwpt_id) {
> +		hwpt = iommufd_get_hwpt(ucmd, cmd->pasid_check.hwpt_id);
> +		if (IS_ERR(hwpt)) {

Do we need cmd->pasid_check.hwpt_id to be optional?

> +			rc = PTR_ERR(hwpt);
> +			goto out_put_dev;
> +		}
> +		expect_domain = hwpt->domain;
> +	}
> +
> +	result = (attached_domain == expect_domain) ? 1 : 0;
> +	if (copy_to_user(u64_to_user_ptr(cmd->pasid_check.out_result_ptr),
> +			 &result, sizeof(result)))
> +		rc = -EFAULT;

If we do want it to be optional, we can't unconditionally check the
result then?

> +static int iommufd_test_pasid_attach(struct iommufd_ucmd *ucmd,
> +				     struct iommu_test_cmd *cmd)
> +{
> +	struct selftest_obj *sobj;
> +	int rc;
> +
> +	sobj = iommufd_test_get_selftest_obj(ucmd->ictx, cmd->id);
> +	if (IS_ERR(sobj))
> +		return PTR_ERR(sobj);
> +
> +	rc = iommufd_device_attach(sobj->idev.idev, cmd->pasid_attach.pasid,
> +				   &cmd->pasid_attach.pt_id);
> +	if (rc)
> +		goto out_sobj;
> +
> +	rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
> +	if (rc)
> +		iommufd_device_detach(sobj->idev.idev,
> +				      cmd->pasid_attach.pasid);
> +
> +out_sobj:
> +	iommufd_put_object(ucmd->ictx, &sobj->obj);
> +	return rc;
> +}
> +
> +static int iommufd_test_pasid_replace(struct iommufd_ucmd *ucmd,
> +				      struct iommu_test_cmd *cmd)
> +{
> +	struct selftest_obj *sobj;
> +	int rc;
> +
> +	sobj = iommufd_test_get_selftest_obj(ucmd->ictx, cmd->id);
> +	if (IS_ERR(sobj))
> +		return PTR_ERR(sobj);
> +
> +	rc = iommufd_device_replace(sobj->idev.idev, cmd->pasid_attach.pasid,
> +				    &cmd->pasid_attach.pt_id);
> +	if (rc)
> +		goto out_sobj;
> +
> +	rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
> +
> +out_sobj:
> +	iommufd_put_object(ucmd->ictx, &sobj->obj);
> +	return rc;

If iommufd_ucmd_respond fails, do we need to revert like we do in
iommufd_test_pasid_attach()?

Thanks
Nicolin
