Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2073.outbound.protection.outlook.com [40.107.92.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43EBB28FF
	for <iommu@lists.linux.dev>; Sat, 12 Apr 2025 03:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744429187; cv=fail; b=l/He+mKqCDLcxn3KK6j0eflg3epOEVwVGM+bGoto1JlPhJ++tR1/tPHcxqlvPEahLm6EqT8JoMZE0WTF9+2DabKDYB5kPniXvxU5ALJg9OFs7wsoEi6w/ugOxJeOqPC+s5KSV6bAsbW4usposNwEZG+XT5TwSURBC13t6+G6xfw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744429187; c=relaxed/simple;
	bh=F3sI72mNXUt0pTkNG3zWhD7srfK3vOzxHurL7hRQ4SI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RktsHtv0rtfVuTwL1eM0ZLdha5yJGsAqSPof4ydJnsh6zu9wIKBeErLfLrK6ZXXON/8A/AfS/fedNNF8CpXZAsYAKeZngzGBZmz1oQlAH9dyXSlHEw7wuARPNc6FRWXhdtDA7GHk1efAZjTI7GD6WnOtwtPJl5voFgv6/tOXTqM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gfUTb1EC; arc=fail smtp.client-ip=40.107.92.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gfUTb1EC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C0dKrg00HSlQ5EN5TMvXVMDcp2dJQCn8jDSB+pjME5e8LSLJBE3zMs6FI5cEcNllTOIeA/tUNHEFjqKyv5EgORR7jcCEXudnu59BdttO6JeXtIc1fSxv37J3sNerBrmifNhX1p84re/+6Tpx+Dw7HOQsskOXwHHQiXfraD9wh15zfNNYKVWKr5DXYiNyhSV5KdCauXGxJvUwKxytNvQ4BkQsmRNuszG45Q8ucrTw+8HgTUTDNd6PAv4nqs9Y/Gm7BlwWbugzgzbov/QJfYm7bM7R1OBjQi5wyOFwrm7WlNtBhUmYIKDWKhysLd1hSCzLUiAobLI+jyRQDkZMsb3L4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n8Ta1/tG9qF5fWRxBI6z6PpLcV9KETeHPlK8Sg57X1k=;
 b=cACFJiCUuHE5ogYvdjKWTQk94idRaCPJ9+xPeoV781KKwXDZwaaTenMghRCj4HKkt3LbcSegwYGCz5/DGJ+QfYUvY+DQ8ysFXq+U2OUXQINMwx0mMj1CfgfrIukgdLDKDyIg5L1CXJ/w8DY9JpKqd+8v34OeQwWA6mwhuKdXZA2SpFd8C15BPWxVMJsAUJQYHQZibe1qHVpuHqogGPqpMQAEWYSQsnmbHBGWTo+I1V5IrM3POsrSAdvrlpD2Eq7A3dOH+3IMG3GK/Phxqu3Ylp9YLndAuTH3U7YIxsvFcrA+pW09DN65Ahh6+YMunLHU+r/yTycaR3Fm+0sfEv+WCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n8Ta1/tG9qF5fWRxBI6z6PpLcV9KETeHPlK8Sg57X1k=;
 b=gfUTb1ECNcVniw6cwQI4/EETJrlcyzTmRoNx5MP7lvAcVPeW/8N+5DssFp7EAxiz1WdN/SUjRzkF/jz6hS8w1Iuypo7e8FAwqaHJxjflwALRmJXVSEMTuPZrh3rWYND7YCV7q6+M+vWAob/gmWUe3FBzwrLsTKhAicgjHiu/0Hp9Gax1QjrcWMo3x3hibKw0UNO4rMD678FKzS5v9cvotWLSgnf4pdzbjE2GE7SXqAHu+hJkCj6cB+W32KxgSQgpsM6UlHpYihV9SDVr0fx/JLmmQr3VM3ydhl4VpSe+WH1g3dX1kNzQSFcUlRpq/pgqDPy+AwS3whiSlOrqIflEHA==
Received: from CH0PR04CA0102.namprd04.prod.outlook.com (2603:10b6:610:75::17)
 by IA0PR12MB8974.namprd12.prod.outlook.com (2603:10b6:208:488::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.27; Sat, 12 Apr
 2025 03:39:41 +0000
Received: from CH1PEPF0000A345.namprd04.prod.outlook.com
 (2603:10b6:610:75:cafe::8) by CH0PR04CA0102.outlook.office365.com
 (2603:10b6:610:75::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.30 via Frontend Transport; Sat,
 12 Apr 2025 03:39:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH1PEPF0000A345.mail.protection.outlook.com (10.167.244.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.12 via Frontend Transport; Sat, 12 Apr 2025 03:39:41 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 11 Apr
 2025 20:39:39 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 11 Apr
 2025 20:39:39 -0700
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Fri, 11 Apr 2025 20:39:38 -0700
Date: Fri, 11 Apr 2025 20:39:36 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Robin Murphy <robin.murphy@arm.com>, <will@kernel.org>, <joro@8bytes.org>,
	<jsnitsel@redhat.com>, <praan@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iommu/arm-smmu-v3: Allow stream table to have nodes with
 the same ID
Message-ID: <Z/ngeFHmygxnPn6f@Asurada-Nvidia>
References: <20250411044706.356395-1-nicolinc@nvidia.com>
 <5c8d16f9-246e-45d0-aaac-45b7712cefb5@arm.com>
 <Z/mm2EQAQtOqpVCy@Asurada-Nvidia>
 <20250411234419.GC252886@nvidia.com>
 <Z/mupP6m0gRbeYtg@Asurada-Nvidia>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Z/mupP6m0gRbeYtg@Asurada-Nvidia>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A345:EE_|IA0PR12MB8974:EE_
X-MS-Office365-Filtering-Correlation-Id: d8f835b4-c6a1-4382-09a0-08dd7973a8a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kI03sahckJWUg+96QCkU9oAXeoZWQ0J5/cqdLgLoWcikbYI8EfDI17QoI0cP?=
 =?us-ascii?Q?1MHDxkoOsJ7Nt01RQG++PyYxGiIRoTRlCmqYci3LSdhG1p/LbP9fXCHWt8JP?=
 =?us-ascii?Q?09kjEfI4MHR1972XHFdh09C1DJeilt6a1VlycSflMtzacL8hDOee4zOFu0sV?=
 =?us-ascii?Q?KJd0tJdrLt5bNLmI1m8BtfTR9iJVw+Wn9PDOTGX7UkWuO039YOCqUOsIJsgx?=
 =?us-ascii?Q?2oLYVmYsr9ECdAIr7jeO7F2OFELm0fIs9cpnLwQB7Zr5sInyuH+B82Dlxu1O?=
 =?us-ascii?Q?tNrO6gYgC9MObxyBLD89nB8x+BgyUxuwVueilbQKnoTUjGTOFK2y3lFEQhWL?=
 =?us-ascii?Q?3775TkwOclQALedIdjWzndIZWo3m83cAV1ms1Iu1buADyLgKaarbVB8A5Kzz?=
 =?us-ascii?Q?LxOeJQsyRhLVwpGfL5FnHpFfs2cz8AQw6BkbgB5YTLfo9S3bYyGAzUEcaI/z?=
 =?us-ascii?Q?AAq7sjFj5DNN4zofkvegbYWeC7aOHam56gx4k+TzMlP6O4qfEgREJL262for?=
 =?us-ascii?Q?wDPKldreq+RbQ/kLEvUCcuvRaIsPb4s0UDSfyzE06SXWEYEVjLgdsu1YkoLf?=
 =?us-ascii?Q?EVMXca8ps/xpKTAuyHXl+BP5EU6SzLg05ndWHLlyVVrUaYlCa0/ZIT26T4a8?=
 =?us-ascii?Q?gT20wfekETmC57JVc/69H0j6pexYe7lqp6ZA4CPfqK4wIG+pu1+E5w/ZAemV?=
 =?us-ascii?Q?Ualg1vZVSyRUGszG4NkYlPB6+N6Jh7tF3Gtd5dqBFdVOYf8crsEUEJ1U6izF?=
 =?us-ascii?Q?WUErMNvDzXpHYkLzU/Q5SG61ya9gMyLJ1FvSn5H+s1vQJulooMPn1g/N1knW?=
 =?us-ascii?Q?MlkWGzodccsBY9HCQ7fEU3APohF72MWnopkk8MikObdpRD1+tBKbkhh1pKWk?=
 =?us-ascii?Q?HijMmmOHOlWb6O0giN0h4kgFSVpOVDQNNb9AliUUMXb5DQwXWRmxYZFxNGey?=
 =?us-ascii?Q?LC3iAn8U1NwiucPpLW88OM8skMF0KM3dtla1TcR1bygetiE8zHs5gn3ad0Ec?=
 =?us-ascii?Q?QHrsUhRqPDMJfZpCae3OAAGwn9dUvBHSddQ3JH0r5cVWsbpGWDg5LbGesder?=
 =?us-ascii?Q?aMhFBwXMVNb52wzmpn9lFW7sRb4vAd0otpkBcwWL8ZsXOSf0GmYDjZj1QnVC?=
 =?us-ascii?Q?uM/4fxqr5/LpRlOZ17Z9SYcwWhVf/Q3sF9t+4cHib9QmRF5gNFNKwmf3bhPk?=
 =?us-ascii?Q?ypuiB9dxu00ejKQnVsek+3N1Wbk6ohf5W+gVarfPMKV4ek1VGXatqkQi7BmI?=
 =?us-ascii?Q?g6oZ1buQvQCprG9MGP8Pr73S1pb3FE6U3DhLExMB2rBaVCPwHaWz60sBbQ/I?=
 =?us-ascii?Q?qLIl5UZHXDFVtPTmJbnots9hPRT19+swy0WUPSvuTTw0R2t8vNfOVGFscNUM?=
 =?us-ascii?Q?/8NTlS/JYWVIG6hqumtMwwNeS8triDl+rYFbukOfg374rbaL9XSnX4I6WefS?=
 =?us-ascii?Q?39zvsP+7NdId2oZa4DgA4JioG+7oADBjoegmg3NKGdUoZykM58nvImdYN8ym?=
 =?us-ascii?Q?C3g1U1To9YsxmgYgJL7j5+7QR9TRyFoSMXO7?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2025 03:39:41.2176
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d8f835b4-c6a1-4382-09a0-08dd7973a8a0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A345.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8974

On Fri, Apr 11, 2025 at 05:07:03PM -0700, Nicolin Chen wrote:
> On Fri, Apr 11, 2025 at 08:44:19PM -0300, Jason Gunthorpe wrote:
> > On Fri, Apr 11, 2025 at 04:33:44PM -0700, Nicolin Chen wrote:
> > 
> > > > The bridge *does* claim its own RID, and per the aliasing rules the
> > > > devices behind it claim both their own RID and the alias to function
> > > > 00.0 on the bridge's secondary bus, like so in action:
> > > 
> > > Yea, I just found out that the bridge does have a different SID.
> > > It was actually the VGA controller itself having two fwspec->ids
> > > populated by the IORT code. Then, the SMMU driver allocated two
> > > separate streams with the same set of device pointer and SID:
> > >   pci 0008:06:00.0: arm_smmu_insert_master: fwspec index=0, sid=0x10600
> > >   pci 0008:06:00.0: Adding to iommu group 21
> > >   pci 0008:07:00.0: arm_smmu_insert_master: fwspec index=0, sid=0x10700
> > >   pci 0008:07:00.0: arm_smmu_insert_master: fwspec index=1, sid=0x10700
> > >   pci 0008:07:00.0: Adding to iommu group 21
> > > 
> > > Perhaps the duplicated fwspec->id should be avoided in the IORT
> > > code at the first place v.s. bypassing the fwspec->ids[1]?
> > 
> > It is a much easier fix if all you have to do is ignore hits in the RB
> > tree that match to the same master, just don't fail on duplicates and
> > don't add the duplicate rb node at all?
> >
> > Seem strange though. Where did the duplicate come from?
> 
> iort_iommu_configure_id
>  |=> pci_for_each_dma_alias
>       |=> iort_pci_iommu_init
>       |    |=> iort_iommu_xlate
>       |         |=> acpi_iommu_fwspec_init
>       |              |=> iommu_fwspec_add_id(sid=0x10700) //index=0
>       |=> iort_pci_iommu_init
>            |=> iort_iommu_xlate
>                 |=> acpi_iommu_fwspec_init
>                      |=> iommu_fwspec_add_id(sid=0x10700) //index=1
> 
> We could add a piece of code in iommu_fwspec_add_ids() rejecting
> a duplicated ID, which would be smaller than we do in SMMU driver
> that requires a device_group change too?

I figured that we could do something smaller too in SMMUv3 driver,
somewhat similar to what Robin did for STE in commit 563b5cbe334e
("iommu/arm-smmu-v3: Cope with duplicated Stream IDs"):
----------------------------------------------
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index b4c21aaed1266..4b66e8ebef539 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -3393,6 +3393,10 @@ static int arm_smmu_insert_master(struct arm_smmu_device *smmu,
                new_stream->id = sid;
                new_stream->master = master;

+               /* Bridged PCI devices may end up with duplicated IDs */
+               if (master == arm_smmu_find_master(smmu, sid))
+                       continue;
+
                ret = arm_smmu_init_sid_strtab(smmu, sid);
                if (ret)
                        break;
----------------------------------------------

This would bypass the duplicated ID. And here is the test result:
[    6.327800] pci 0008:06:00.0: Adding to iommu group 21
[    6.327847] pci 0008:07:00.0: Adding to iommu group 21

Thanks
Nicolin
