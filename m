Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2067.outbound.protection.outlook.com [40.107.94.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D8C538FA6
	for <iommu@lists.linux.dev>; Wed, 31 Jul 2024 18:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722449612; cv=fail; b=KbVdvAHvQHOqgq1kv+5Lj0oVoriqxcqV4WIM13HH9rF781FkjieEh7eWlCxW2Cw/zzHaniaHzU8mKjLf+aH8gxLjeumDmidxcOezzcsvJLe/9/3ZVMkGErlOOfZuakdrfkh9Q8hgvDIhC3daaqF6TAVqPI50Ia2rLZsrPx5zmdA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722449612; c=relaxed/simple;
	bh=0Qp0ZQsAhs36cB0/3zAlCUn+3H5fbfMcX/X8LzQFe3k=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SM/PYOg9E/W+cx0rE6JzIgpmQEpDQkcKsFa3icYXVJ7apnJBuZM/gPyvlpjdTCMtgN10u7lQQL67hmH2MGeO6gTpwitIY9iMjap/GhMgZnisIe74GJZP9SKbilQg9RDY22ad10s4N8K5LbJeI+ibQFH8R2GDdzONfss1ebqlxBQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nTOWT+uO; arc=fail smtp.client-ip=40.107.94.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nTOWT+uO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uKB3EsZ9+5vSl1SRK8nxpa3GxUmKgwj5gYCnxaS/y91/PcEWd7Nu3W0Rv1aKeI5B9z7I36DTaYhKfJ4/ZWJXeoJWDU19e1cE1sfEVaAwyObE1pgCIb1yRPZ7sdkwBYPKvFVnzRhP9pqp1zictbTDpoyLCOWzm35t53kXh+3iuYdtlokcN8ozfkoB52Gn5Zlj3iIOmhNeCiHqMVNcHYwFdLae3hRorxE+NRg0X3tKPB6LpNXOpdbkztzbnNj2U0Y/2nd3LaAn3tyCev841NUces/raP5YUODyXZGf/QMYfhdXmgxGJT3yBxbF/c1G3iH0ptC1P2p78uTJIXk2W5I9FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6kjUUjTsXcX8K1uZ6LQ3uI8B882gDH2I2c+EbBAmcc0=;
 b=Vhkh0iJu1kE1DWo7kq0Qu2IweKYiXnf6jmgX9VVmlN4oMHQNEKITeqDDBaUVXoWFDWx1FCj95okSw3wOS0/+Kqy8iHvuOX3IhVpnqCmLe4oyCytUX4AppyCfWTF3mgIAt8EiP2U0/U3p3CfW0y+twSQNT6GZrHQshKVNKAu9bIkW87JFlzPeG9f2I0IIEBmyQuGRWSAnM81s3xyrGvPFu1UgKuL8IPxLPdmSZteqlRw8csIgD7mAMKmP3GputwdxCjR9uKScSf50/GTN4iN0KIrekhgIgD0u8KctKSp33/6qEL8mmRaOYzZOXRJqr+4F+dD1tdWT5/23uICWve6fmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6kjUUjTsXcX8K1uZ6LQ3uI8B882gDH2I2c+EbBAmcc0=;
 b=nTOWT+uOpErlNXizWCIZ5SPkBd8L9vZrAKnLUkkrMNrM+cwlBPS6bAFJz3pr8bQUFBd0Ydxou+dG2hMgxbPKiuhoagxzDalzzt+F7+hEkRsKR3opr4G7v4v1w8S7tVaRO7tSAW0KjFwPrDYv7eV6wI0vkQpAITATtvbofPGAKAYACUkAT/qcbuwmbjPpvqa2bOvBIsqpDsE150IKL1I92hTOV0vxUClmvBghqVLUx+6oKGSahMJA4f7w76pdzPcPLyc2W/unQpXaSXaIMH15kIRzXuU92GbV32lGMJIuCwGolIneN2Q7qzK5AL1uJq6+GkPbIVlCVJiSB2PtlsRLuQ==
Received: from BN9PR03CA0152.namprd03.prod.outlook.com (2603:10b6:408:f4::7)
 by DM6PR12MB4203.namprd12.prod.outlook.com (2603:10b6:5:21f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.21; Wed, 31 Jul
 2024 18:13:26 +0000
Received: from BL6PEPF0001AB52.namprd02.prod.outlook.com
 (2603:10b6:408:f4:cafe::90) by BN9PR03CA0152.outlook.office365.com
 (2603:10b6:408:f4::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.21 via Frontend
 Transport; Wed, 31 Jul 2024 18:13:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL6PEPF0001AB52.mail.protection.outlook.com (10.167.241.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.19 via Frontend Transport; Wed, 31 Jul 2024 18:13:26 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 31 Jul
 2024 11:13:08 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 31 Jul 2024 11:13:08 -0700
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.126.190.181)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Wed, 31 Jul 2024 11:13:07 -0700
Date: Wed, 31 Jul 2024 11:13:06 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: "jgg@nvidia.com" <jgg@nvidia.com>, "Tian, Kevin" <kevin.tian@intel.com>
CC: "Liu, Yi L" <yi.l.liu@intel.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iommufd: Enforce IOMMU_RESV_SW_MSI upon hwpt_paging
 allocation
Message-ID: <Zqp+sssdo80B7MaB@Asurada-Nvidia>
References: <20240728235106.2435208-1-nicolinc@nvidia.com>
 <BN9PR11MB5276497781C96415272E6FED8CB12@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276497781C96415272E6FED8CB12@BN9PR11MB5276.namprd11.prod.outlook.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB52:EE_|DM6PR12MB4203:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e2c156b-6243-4a79-0bc9-08dcb18c7902
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4o8/gnBhP66TIfWDFy+LOOGPhBHU84ZHB0JOucyx5EWTA+4l1eLc2src+zi3?=
 =?us-ascii?Q?o0Qg306Yy7B00juVn0BJp7RZ1WkKWxGpjowxayGkv8TT0XgcUQeWarbfr9oj?=
 =?us-ascii?Q?CEoAQLD0owZVq3WskukyvAarh5V+uMuR7ptARWYVNPRp2ZgHOnTVdAYqqsB+?=
 =?us-ascii?Q?nfKrOSrMvzjxKdI8uXX0L8Ctzxz55seHfGWKCMEWRLc9h1T304zWSiSYe0SA?=
 =?us-ascii?Q?rGe0Ua9m2qWzT5bLbgl0UESXI1E1ms7ZPwhC5FTLnj3MvTQQxwPeQ5sXlEj5?=
 =?us-ascii?Q?Od7zayudR9lUDrifSyyLj5H6scpcS2GUMUitGuB8PWj07m/uec6e8OG8QSdB?=
 =?us-ascii?Q?h9xcRCA6M8ZyKpp/XNp04D1YZSgB+X1Fcg2FDagv9D/nlzNcwkh+i7epF/7V?=
 =?us-ascii?Q?XSjlPsBhGsh32+CQd3mC6f+6QsxMHLCSRZpW1VGvNvUleTWpfIP3EMzk3B26?=
 =?us-ascii?Q?BokXQHbm9Nk4iEXyP2sndNTxkKkMa35fYZX8KkzuQB7RxmLDvqqRqUJ0m/UB?=
 =?us-ascii?Q?ED/IJF8+DrhlMUKMjd/VSybQQIUYWXfXK00Uiy7LzVFi2uZqsLasXJmqoGyL?=
 =?us-ascii?Q?tOMksM0XGHp8uDbIRcl5YOawVlnLjIy+1AJW0yhGBCM8E+xATGkLV/sI0MnW?=
 =?us-ascii?Q?57JdjMtHY12/OwHSoLiIrdOr4wyX/1fpjeeqAuw0ILV8uHk1c8XADPsrL568?=
 =?us-ascii?Q?lvHSauPDu7oqqEZ9Sit83vaeiHS/sFCpkcae593nRfjW1BfxvF/ItFIncvXr?=
 =?us-ascii?Q?Q3WOgyYzRGah02lVSADqd0T/PyVXGaGfP5ErnyPvlsVOvSjREKjOJmMXTOO0?=
 =?us-ascii?Q?888W9WCYFRC/ukUDcTIqq6SJ1M4DEnH7LwlLF2RhZOnoewEvE8QvzpMgrdso?=
 =?us-ascii?Q?IQ6J+XCc4d8Y8aGqClXf+0otm6+ikRbj/dCerHZx8G+2pof+W0/9ihude7O/?=
 =?us-ascii?Q?lUb5jkjOZGrtu+oRpboHm7YhH1h+cDMhMyv4hKMKxcj2z1DGmSPz3g2l4k7+?=
 =?us-ascii?Q?dv0UnRYbOE93JrOGjGpXjy10acIgO1lqAT8B1tx4bow9iZS3/yWpqXoO8Epi?=
 =?us-ascii?Q?jsk+ksxxsyIHsVrqX0sERRLZddhC9TsCXcMnktTdXFqgWc4LvV8+omNpjKy8?=
 =?us-ascii?Q?dFrDVAagLBjXpMqyqFIXHiZiCV4T2EukclWVoLAHzJFnXpZYmIYU6EWH//i4?=
 =?us-ascii?Q?Manf5s7JYlC9aId2ur19orQBs3ZQy71i3BVWzaX99yPx4x7rBnbJi+yhRK0j?=
 =?us-ascii?Q?UNj12sigWkASOhbieEdI/BC9PWNVDJ42GBv8rffGpRrYngzlrYxnGjYFija1?=
 =?us-ascii?Q?doROePcYF9Wf2T7gnrQWm2zmjcg4hrq24L0htgLDOwBfCGc/XdwQKM+4e3iw?=
 =?us-ascii?Q?k5Z3ucxm4yLVGyV4ech75cGsURUft2wp1QXXhj5CZvfFJPmiqIK3qQEfD+sj?=
 =?us-ascii?Q?J+M1cBfZ0m3qPFLlrnitiNuDozMhsv+k?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2024 18:13:26.2232
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e2c156b-6243-4a79-0bc9-08dcb18c7902
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB52.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4203

On Wed, Jul 31, 2024 at 07:45:46AM +0000, Tian, Kevin wrote:
> > From: Nicolin Chen <nicolinc@nvidia.com>
> > Sent: Monday, July 29, 2024 7:51 AM
> >
> > IOMMU_RESV_SW_MSI is a unique region defined by an IOMMU driver.
> > Though it
> > is eventually used by a device for address translation to an MSI location
> > (including nested cases), practically it is a universal region across all
> > domains allocated for the IOMMU that defines it.
> >
> > Currently IOMMUFD core fetches and reserves the region during an attach to
> > an hwpt_paging. It works with a hwpt_paging-only case, but might not work
> > with a nested case where a device could directly attach to a hwpt_nested,
> > bypassing the hwpt_paging attachment.
> 
> This probably needs a bit more context. IIUC it's the ARM-side choice
> that instead of letting VMM emulate a vITS for S1 and then map it to
> physical ITS range in S2 it relies on the kernel to continue the msi
> cookie reservation in S2 and then expects the guest to identity map
> it in S1.
> 
> With that context if a device is directly attached to a hwpt_nested,
> hwpt_paging attachment is bypassed including the msi doorbell
> setup on the parent S2 then it's broken.

Yes. That's exactly the issue. My bad that made it simplified.

> > @@ -364,7 +305,8 @@ int iommufd_hw_pagetable_attach(struct
> > iommufd_hw_pagetable *hwpt,
> >       }
> >
> >       if (hwpt_is_paging(hwpt)) {
> > -             rc = iommufd_hwpt_paging_attach(to_hwpt_paging(hwpt),
> > idev);
> > +             rc = iopt_table_enforce_dev_resv_regions(
> > +                             &to_hwpt_paging(hwpt)->ioas->iopt, idev-
> > >dev);
> 
> Is it simpler to extend the original operation to the parent S2 when
> it's hwpt_nested?

Likely. I recall that was what one of our WIP versions did.

> The name iommufd_hwpt_paging_attach() is a bit misleading. The
> actual work there is all about reservations. It doesn't change any
> tracking structure about attachment between device and hwpt.

How about iommufd_hwpt_enforce/remove_rr() taking hwpt v.s.
hwpt_paging.

> The only downside is unnecessarily reserved regions of dev1
> (attached to hwpt_nested) added to S2 which might be directly
> attached only by dev2 so the available ranges for dev2 are
> unnecessarily shrunk.
> 
> but I'm not sure that would be a real problem in practice, given
> 1) there is no usage using up closely the entire IOVA space yet,
> 2) guest may change the viommu mode to switch between nested
>    and paging then VMM has to take all devices' reserved regions
>    into consideration anyway, when composing the GPA space.

That sounds reasonable to me.

> With that I think continuing this per-device reservation scheme is
> easier than adding specific reservation for SW_MSI at hwpt creation
> time and then further requiring check at attach time to verify
> the attached device is allocated with the same address as the one
> during allocation.

Jason, do you agree?

Thanks
Nic
