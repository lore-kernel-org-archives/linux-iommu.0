Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2075.outbound.protection.outlook.com [40.107.236.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050723D561
	for <iommu@lists.linux.dev>; Sat, 12 Jul 2025 02:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752286994; cv=fail; b=Rfwv32lgQydN241JsCHNlEPfQxbUeKoWKoC21S+anLzeLaNt41wRk5yIIMuvgTkVJ3id2BJK0M0sheM/bk+klEkeBTNjshiQO9Y3iScX7sCzWJBVs8p++Ytq27vL12NiXrQpjbSKwSv24iPQnaqFt8wl4ZcVQLF28V+rGNadilQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752286994; c=relaxed/simple;
	bh=croeSp3YKGmuCTfL2V5aUODiUDR/cm9eI7CmAa/MsS4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mHXriqqYI/zMzOuvaj2nd/ScjNhPpWE1iemEOUDM7bikh2Ku/FhWl2SElOVvCmBenG0ylZACWS2Dp76a2lig8xNcEGR4xYZJgsueyhQvNHKpH+sOgcR43itpMRYTUdOSk6ua/zwX8YmmD1tvB0yMr1AmiPwxZ/71sibgSciTZAA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bIfQfjMz; arc=fail smtp.client-ip=40.107.236.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bIfQfjMz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jh1UwB8DNBfNIoAZQ6u/cjyRJvvlp0N4xfYZgMkkG4YNG7jKNJsrW71RlrhlieJ7FEUcCBIKqEepabiGj6c0Up8Odv8yj8OEy2Djyriye5tGpHCkBsMZ5GIE0P95xzKMjZzn/g2ru8nALdWyrncFlzstaDt+ZUMeUYyCAVgbXgA2qMqViU1kASl+DP4fwZwe2N+/gc9bMTOq1h/t6GNNXq16LTwWz/YkaCkIFx1tuDPwo40SS/qovX7S+P/5djMqXlF3DafWdduUH7pqcBJAtvpM0msAndN+zMES20SQqjHP+uXNZ/BkIlPYoL7r6cOQyP590yT/2o2vR7CwdII/Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dTF16qoxA19WJrClgRTEil2mTMWZfVcELcMt/sG7LCk=;
 b=b5daoQgUuUwUXBeo1FNuS52wlsspEEVPyLTIbUctW0bWnuFFTawJz0NWhYXdf0wx6hjdfMwJkwJzIWAexl0zrOEkRdKk4DILbkQeh60zwXZ+xOunjVp6ppYQnfG9sAULSNSWNM+FGIavbdKa8lHl4FmxeuOFCzXUhFg1dRPFdXNy7eMmRLRxoOY1Ao030w2I5tgg4yhgtkjIFKT0lXrXexuo8nV2eU+c2et+7uYTM5RAaE3GvjcehC+HnPn7GSupH0hgi8TgsOLbbz+V2QQlzrTcTp0vXHOv6cxUKGO5jmksou3EgKNmyMQzy0s40U23B5zrhDa6DEXtFWhvO2JXOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dTF16qoxA19WJrClgRTEil2mTMWZfVcELcMt/sG7LCk=;
 b=bIfQfjMz4DuF9KiKGmmEuJI6J03gB8HzxJZHT3EY8D3MJh2d462Im3UcYWI/aQNh1mfMraNstnQA9zK7VPfrt/afYGBIBE07GT94k+G7R90JoiEoi0MolW6WuuEpo2iruQogLcSLss8FTsgIQGPl28vbnprWJQ6vtNYklbTXB9tFpOpYVORA8MigTzEd6bETCSxUtuda6+QIvrQCWJ2t+IAwCsZrxcF2qxVyMCde4o7Of0yLSsEJ1iHm5mNtUx+SyWRrIWona9wT8xiKa58xeqszVSJMvyRmMKna0A9aTzUNzyPGvHhTQPLEEh8JFf18W/MjrD12p5Zyqzx3atuRlA==
Received: from BL1PR13CA0339.namprd13.prod.outlook.com (2603:10b6:208:2c6::14)
 by SA1PR12MB9546.namprd12.prod.outlook.com (2603:10b6:806:459::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.25; Sat, 12 Jul
 2025 02:23:07 +0000
Received: from BL02EPF0001A104.namprd05.prod.outlook.com
 (2603:10b6:208:2c6:cafe::67) by BL1PR13CA0339.outlook.office365.com
 (2603:10b6:208:2c6::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.11 via Frontend Transport; Sat,
 12 Jul 2025 02:23:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF0001A104.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.22 via Frontend Transport; Sat, 12 Jul 2025 02:23:06 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 11 Jul
 2025 19:22:55 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 11 Jul
 2025 19:22:54 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Fri, 11 Jul 2025 19:22:53 -0700
Date: Fri, 11 Jul 2025 19:22:52 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Xu Yilun <yilun.xu@linux.intel.com>
CC: <jgg@nvidia.com>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<will@kernel.org>, <aneesh.kumar@kernel.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <joro@8bytes.org>, <robin.murphy@arm.com>,
	<shuah@kernel.org>, <aik@amd.com>, <dan.j.williams@intel.com>,
	<baolu.lu@linux.intel.com>, <yilun.xu@intel.com>
Subject: Re: [PATCH v4 4/7] iommufd: Destroy vdevice on idevice destroy
Message-ID: <aHHG/H6IT9lvYy8x@Asurada-Nvidia>
References: <20250709040234.1773573-1-yilun.xu@linux.intel.com>
 <20250709040234.1773573-5-yilun.xu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250709040234.1773573-5-yilun.xu@linux.intel.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A104:EE_|SA1PR12MB9546:EE_
X-MS-Office365-Filtering-Correlation-Id: 2042701b-8bf4-42f2-ceb3-08ddc0eb09a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|36860700013|82310400026|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QoiBDl8axFm8WvlemDmzrCg5lYpF3WEvoCupSR87gWXLgnxwJ7+5e7DtQnz+?=
 =?us-ascii?Q?rB6U55IsfhowIeDDkPwHmO6GzCRBwWD4qAiVW/Qnqmu0zcb92hLmc7ejpVYE?=
 =?us-ascii?Q?A/22Mt/qoHSopQ6csE8iMaSQY7OAGbLaG/eWfIxeEOn5JbvuN8S7YNgT7Ms8?=
 =?us-ascii?Q?loEQd2yqtJq+JD3tf1zdad6F18FN5q/eKcF9e/GQV7eWexRvqg0xoKqMsaKK?=
 =?us-ascii?Q?0KphhJKbcneh9UO2QWUi58q8nyphBXTmB3Qos1jCK3t6sTQqveDwHCAHHk+8?=
 =?us-ascii?Q?LTiemC6yP6R3luMZCZU/C6klP6qZ8hYrzXhiO4LCc4ZPRJ5W9QmNNwpx8HCQ?=
 =?us-ascii?Q?rx6OY5Gk2wlmdMMtu0qGJP0MEojfv7Xcya1yjarrSxqgiKl9wNKuqErrNoqv?=
 =?us-ascii?Q?cNdrq85dz7q5sWEEqrhzd06IN6x+Xd1+BOzIMJu1qpVN/1qPhuVgHX/eHrSn?=
 =?us-ascii?Q?+DHClvlTC+jCtMivJpCq3ZjAO6dIlxYZmbW3qwNt4lUC9yr/xujbUG0oGHNp?=
 =?us-ascii?Q?GPrkkSGXB3Osy5JCA05CH6bqFl/vDJW9eMIcy9hlofb3gOIuha7Sy0bGblQe?=
 =?us-ascii?Q?fTEC/8i7L5EP1i4qvsqs1N3jqeWmStspQqxas03XTU3rt1Gv8fq2gt2MJMYY?=
 =?us-ascii?Q?UAMCIUB1t89kBwFWd7ouUoVX6RwozPZn41jmni655Oo3gx71jBthRazTKPIg?=
 =?us-ascii?Q?ibH4ntskMrhdZQmcFv5bx9bvSSzXJt3/TAuTAD5MfPuCMWSSdLH+3yuMQGp0?=
 =?us-ascii?Q?A3Tn88Csz1ERabjiL3ltp0yDpK+gigZfcHpNMzby08L3KjbkWoWoBKYRYjgd?=
 =?us-ascii?Q?/hDR7fzhMSfiU1V8fFLQvKECLbi3AWFpCQgfEr6Nc0hJnJgz87GsJTyK6/o+?=
 =?us-ascii?Q?MDTej+2KvHtZofBqozD3c898LYRQ6zL3ss5Nbc1OtvdC4knJT6hNPL5g9DkP?=
 =?us-ascii?Q?N+eW+wUeBBou5wEY7fBOwmy3pnSauJl770jedmSr9WuRXoTcyMUcDTcBTwcp?=
 =?us-ascii?Q?t6WUhTc82zrn3Zmho9mMt3qggvTq4M8NmvdQPzf8f9Fyhq0gpVPyrwcZZ3dh?=
 =?us-ascii?Q?aXllx4+nzI9CjWpdtvjrweCMIxY7Vm/XarlNc+TZ/BLmgrTz3fahZQW3UR7z?=
 =?us-ascii?Q?8L4KRUOokPjrE1Oc+f3VCGFMN51nz48Hi/5vX6gZWnSK9YHxlHK77ap84nyO?=
 =?us-ascii?Q?A4ZaYy3+P277QjVvAZI5tjAXGUhdpzeCtMbfvJfyDVYI7exgvgtnDQx472xx?=
 =?us-ascii?Q?iJ1YpnNxSwJWb2y1kCgXf02CEMpek4ymMANdLzs4fPH+r6a+WsScMB2mY9+g?=
 =?us-ascii?Q?LggmwnzV3BgFN6bjc9ahzKzCQ4K7EsHO0MVS+lhV+MtWsT5sacnJGj72wP+V?=
 =?us-ascii?Q?wWUgS75tRyQO3WIfJreY3rWqz4eRyr7499bYQZs3DVskwgmDYXtWxannnCJf?=
 =?us-ascii?Q?C5KBv9BTohQ87tvjELHVEt+A3VZCNZ9l6mUFTLDyjGCHKI9Nlx2pq9sstvYk?=
 =?us-ascii?Q?iXZ9vz3zUWIsMGVMjbiDJWnPUguKdioIJrep?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(36860700013)(82310400026)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2025 02:23:06.6108
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2042701b-8bf4-42f2-ceb3-08ddc0eb09a3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A104.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9546

On Wed, Jul 09, 2025 at 12:02:31PM +0800, Xu Yilun wrote:
> Destroy iommufd_vdevice (vdev) on iommufd_idevice (idev) destruction so
> that vdev can't outlive idev.
> 
> idev represents the physical device bound to iommufd, while the vdev
> represents the virtual instance of the physical device in the VM. The
> lifecycle of the vdev should not be longer than idev. This doesn't
> cause real problem on existing use cases cause vdev doesn't impact the
> physical device, only provides virtualization information. But to
> extend vdev for Confidential Computing (CC), there are needs to do
> secure configuration for the vdev, e.g. TSM Bind/Unbind. These
> configurations should be rolled back on idev destroy, or the external
> driver (VFIO) functionality may be impact.
> 
> The idev is created by external driver so its destruction can't fail.
> The idev implements pre_destroy() op to actively remove its associated
> vdev before destroying itself. There are 3 cases on idev pre_destroy():
> 
>   1. vdev is already destroyed by userspace. No extra handling needed.
>   2. vdev is still alive. Use iommufd_object_tombstone_user() to
>      destroy vdev and tombstone the vdev ID.
>   3. vdev is being destroyed by userspace. The vdev ID is already
>      freed, but vdev destroy handler is not completed. This requires
>      multi-threads syncing - vdev holds idev's short term users
>      reference until vdev destruction completes, idev leverages
>      existing wait_shortterm mechanism for syncing.
> 
> Originally-by: Nicolin Chen <nicolinc@nvidia.com>
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> Co-developed-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>

With a nit:

> @@ -155,6 +182,19 @@ int iommufd_vdevice_alloc_ioctl(struct iommufd_ucmd *ucmd)
>  	get_device(idev->dev);
>  	vdev->viommu = viommu;
>  	refcount_inc(&viommu->obj.users);
> +	/*
> +	 * A short term users reference is held on the idev so long as we have
> +	 * the pointer. iommufd_device_pre_destroy() will revoke it before the
> +	 * idev real destruction.
> +	 */
> +	vdev->idev = idev;

[..]

>  out_put_idev:
> -	iommufd_put_object(ucmd->ictx, &idev->obj);
> +	if (rc)
> +		iommufd_put_object(ucmd->ictx, &idev->obj);

So, this actually holds both the short term user and (covertly)
the regular user too.

Though it doesn't hurt to do that, holding the regular one seems
to be useless, because its refcount check is way behind this new
pre_destroy op:

183         if (flags & REMOVE_WAIT_SHORTTERM) {                                                                                                                                                                                                                                                                                                             
184                 ret = iommufd_object_dec_wait_shortterm(ictx, to_destroy);
==>			/* pre_destroy op */
...
214         if (!refcount_dec_if_one(&obj->users)) {
215                 ret = -EBUSY;
216                 goto err_xa;
217         }

So, I think we could just do, exactly reflecting the comments:
+	vdev->idev = idev;
+	refcount_inc(&idev->obj.shortterm_users);

Then, keep the exit patch unchanged.
out_put_idev:
	iommufd_put_object(ucmd->ictx, &idev->obj);

Thanks
Nicolin
