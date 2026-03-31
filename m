Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010050.outbound.protection.outlook.com [52.101.85.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C836D3E1208
	for <iommu@lists.linux.dev>; Tue, 31 Mar 2026 12:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774959834; cv=fail; b=RvehovNDVUmbqH+UqGODwBR3mEaZv0HPM2HMaUFJmloEhEUg7xHLCxwE5JiB40IPjh6Gjm+LD2PIIu7CFNTKcXnSOgvOdOkpfHIlLdqsaJiPfn+4Mr+/PWub/1PUw3kCx1UuPJnDy3AOkXqte6yCMf1ZhM8CiHqeGhkcldaG7hQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774959834; c=relaxed/simple;
	bh=NjhywqhJmNZCieltt/XH6+m+b6AJrEsrwmS+UM46f50=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I0PVPWwSLipFYGH0m1/G6STE6CGoXShqtMGKkLQRZQhgVcGyyNeyeG/NYIwARbsf7izziqO+QKK3J7EmJW08Q/XKUdmfWoRNKhiS9EBiNIW2Mg5pYeebGSmh9y/S9HY4orzQtZ36npRUwBSq9KR+cZpCkDLR8Gv68XiF5G29UGU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kZbtNVig; arc=fail smtp.client-ip=52.101.85.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kZbtNVig"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rn8XyBzSHcuGAC06PJV3rgGp2eQEvRrZn1tuFhEtOMUKPDxkhmwU4ckT12YiQ6/EaVvdEDrV6Xz16gv7/pWtCeYCsG8By86wt7dbQObUMx0eCd+OEiQ5YZ2j+Pu2AitmexT4lFSqm4fTejykmljCmxRAJ8V/sXEclGbVHMSvEEAFZPKpl/ASHnsggvn4rB4UCtwpP+GYU4Y4eH07xrWatoYxLcwdpQQ8Ff0f9hmCK9WcCgNh/0Q6+IqoqXNvhh5WvCs4vj1AzmXfh/+9bHDTleg5m9xoBzXp4l97zTwpqYBWLhKhucb/GWt4g77pyCDLB14rf07DC/oYeTqMaCY6wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FpfTMQ899Si6ZiCEUbikg8Dmr4kgPbsCOzzB8K3JBJg=;
 b=Q+ApCXRCFcGaKDOXwkHzeMfMSfMNBhWtA0LreYo5GjjHYQlfh4COFf0iO/trc8MGl58Fp+WPK7mI0YR6Z4f0nbx3QQ5Jik9Hum4Nc5TZly+hVr1ql2eq2nGjTHSpFM1kX1mbDTv98q8E9+PmngrnGdOa53Bt5rfUiZTFxciCJPQpuuV2/jnYmY08ELxD+mM+76ZA3U+D3iYLuU0w2qeeO8U50JStFQ7rR0LLx4739XrD2qWHBjnMLsxf62DfAl3dGZTkp3Q98Z/Awtu3d/GnEcTajjxFJTmE8W5tB+pQEmBz0eEpn40N6rIfvBkgIhZ4aDC2D0hpFVcGRAHTDT0/bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FpfTMQ899Si6ZiCEUbikg8Dmr4kgPbsCOzzB8K3JBJg=;
 b=kZbtNVigPy7bl0jv6xb+QLbDbobaZMu0QQXfiX3RLz3PE99+KXpyh774uAZUOhwTKFPuSFHR2e/iQt7LstbNsXGs4Wxgx6zOH797VqgSghLPgJJzchnAW9Y9M5JtdiLA/wBKIyZkRYOG4R/PrIlpNo1C7eLEeyfTsFt+n4cAnQWsIO2+HGSFokV/ya0ceVxWsSdN3KZjziCJwcXrDBF9GqoqUeJlhmKRfoETztIApvvZMyHl6DuIsga0OPwSJJoqaztQLH1c4bK7SO+VhrGKsMyLt4A38gDdBTPxnrB7oi9rlu2xBv0d5WVBgh4ZgimwOg6YodZwccpkQBzanxtUZA==
Received: from PH3PEPF000040B0.namprd05.prod.outlook.com (2603:10b6:518:1::5c)
 by BY5PR12MB4145.namprd12.prod.outlook.com (2603:10b6:a03:212::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.16; Tue, 31 Mar
 2026 12:23:50 +0000
Received: from CY4PEPF0000FCC4.namprd03.prod.outlook.com
 (2a01:111:f403:f910::1) by PH3PEPF000040B0.outlook.office365.com
 (2603:1036:903:49::3) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.28 via Frontend Transport; Tue,
 31 Mar 2026 12:23:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000FCC4.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Tue, 31 Mar 2026 12:23:49 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 31 Mar
 2026 05:23:29 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 31 Mar
 2026 05:23:28 -0700
Received: from nvidia.com (10.127.8.13) by mail.nvidia.com (10.129.68.10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 31 Mar 2026 05:23:26 -0700
Date: Tue, 31 Mar 2026 05:23:25 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
CC: Shuai Xue <xueshuai@linux.alibaba.com>, "joro@8bytes.org"
	<joro@8bytes.org>, "will@kernel.org" <will@kernel.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH rc v2] iommu: Fix nested
 pci_dev_reset_iommu_prepare/done()
Message-ID: <acu8ve3mJ0loitQS@nvidia.com>
References: <20260319043135.1153534-1-nicolinc@nvidia.com>
 <dd72f3be-16d9-4386-82ac-1b8e06186e3d@linux.alibaba.com>
 <abxr7XrsK1WSmr7T@Asurada-Nvidia>
 <BN9PR11MB5276A9067B8D8FE3CB899B2F8C57A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <acbx0NYGq6BOiSDl@nvidia.com>
 <BN9PR11MB52763033F10069ECD005AAB08C53A@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <BN9PR11MB52763033F10069ECD005AAB08C53A@BN9PR11MB5276.namprd11.prod.outlook.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC4:EE_|BY5PR12MB4145:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b3c9a96-dcd9-489b-3511-08de8f205d20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	pDq/iZyivh0/bzzCs3r2N0QnqB6CMCA5fI8c7sW3z7WQeIy1nIKkUc61ZUiZsAzvOx6wKhjC6syN+wPzn8guWyZY3vHxWKm6T7yIfOb5SsgAz2eTkf9RkSTHM5dqj3L9vX5mmepvAnlgssh4+IcRxaHFv0G2CpkC7FMXTxGU9E6FqvJ1RiCpGtZfS3O5n99xL/sr6HX24XVf+YqrCvDXkev6ZhTi3N75MOrbGw171xhaJAu7JoACZFNIW7C469f+ImLFoVCzLRKS6//+UOz4+k5FBiLEXzljyXEWSr3nGlWHY4kZzdl2xUCzUBMsRi1up9RoojF1Tb+Gfayqgf1qm7BMAw5fd3LAJ+pISl8rRRI1LEXEnjQ5z9ck2II3Kx3W1XoB2vHdG4mbL7PF1scM0nB+kG3PYDQtSfbr+bf+ugEeDMF4dw2/8GFOPW73F748UhY8kmQsTnhE1PtnJkIiVXhY0gHjdeJuAcis8HQFCOb5ZEwLY5sSJcbDjhFm06/TmpGkF4IQj5xiTQANNcBl2rrRKY1sfcWEqMAe0k4NV9hMiK/SH3pKWmBfnbx5gsbwtfBEDehlSFAIiT+WkDyn53eXaCnvWY18WT1IWoKqJfXQEtZf4V3DI+D4mAKtxkZqugAiAADZIkbfTNd0s2r6nH3bT4D8Ted3VKbesUeiJSoDajWMl4nfw1xL1gO6giwSfZje7uAUxIOHowQBnVcdk10rpfVfloncABy9a5iBpPgLc5FU7cHQ75lfOODZaT2m6+B3McD4zzyonB5Ia92FOA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	qHof5ytoBq+0R9Xh02PreJGa66s84e0gdOYhFuQM8edUpvrX4oEmP8MTFFO3KKiYX69tMECwVU8gFTgaNHpNJTHXcWz9W1pJ4woPLl2zzwBRl5noFP3Ug1FvPIHdD47p8P8RU1+I0uh6erE30HIQxr7bcAEAb0l8f1t2I4Lcu3+oDsUuCTpPxZ88bzj93USEs6E20US0YXa/mFHLdsl9r96ppZ5vQ8v7Dg6DItxU6aEByb+eWnTeL8XwvQAAv5s2vew0pXwzJNzeelxujYG6fIGnrZJAKtCV/t80/7jD5qnpRcdHY93fhPbqt1dvyrZAc09VCOjVW1Gg2LhcFjES3LT5G3VVm3nmbmuXLbudkVXmRIx8CMBDrhkE/V9lgCpRQqTLuJ1LtlUX3qS8OSzOdnkQu8/JXK1v57yWbLNZcefD/27QbH4mOYJDfqpTMX0M
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 12:23:49.6200
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b3c9a96-dcd9-489b-3511-08de8f205d20
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4145

On Tue, Mar 31, 2026 at 07:12:19AM +0000, Tian, Kevin wrote:
> > > > >   - prepare() only detaches the specific pdev, leaving other
> > > > >     devices in the group still attached to the original domain
> > >
> > > no, attach is per-group. all devices are changed together.
> > 
> > I think prepare() should use the per-device ops:
> >     ops->attach_dev (via __iommu_attach_device)
> >     ops->set_dev_pasid
> > right?
> 
> it's per-device op but the condition of calling it is per-group:
> 
>         if (group->domain != group->blocking_domain) {
>                 ret = __iommu_attach_device(group->blocking_domain, &pdev->dev,
>                                             group->domain);
>                 if (ret)
>                         return ret;
>         }

If the group->domain is not blocking_domain, this device will
move away from group->domain to blocking_domain, while other
device (in the same group) are staying in group->domain. No?

> > And it is intended to limit to the resetting device only. Other
> > devices in the group can still stay in the attached domain, but
> > they cannot do new attachment (-EBUSY) because that's per-group.
> 
> how could other devices stay in the attached domain?

We call __iommu_attach_device only on one gdev, not looping
the entire group, right?

> > Since prepare() is per-device, the per-group reset_cnt wouldn't
> > be sufficient if one device is resetting while the other isn't.
> > 
> > iommu_driver_get_domain_for_dev() for example would return the
> > blocking_domain for both devices, but physically only the first
> > device is attached to blocking_domain.
> 
> what do you mean by 'physically'?

I mean SMMU driver will program STE to ask SMMU HW to reflect
the change "physically". But it won't program the other STEs.

Nicolin
