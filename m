Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2056.outbound.protection.outlook.com [40.107.101.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0065529D06
	for <iommu@lists.linux.dev>; Sun, 28 Jul 2024 23:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722209777; cv=fail; b=YvQtHX3aeTNtQRqenakVgvj1CnxLgZ1V2+xWEsDAEEMntF9+E7gXSGXI6y6gZzJhbXofkeiT2U+CLpcFsbnFoROWlwxNNRMUooNV75WiEaRBDqgdTHr9DCfGEVrwEbAtXpDxUpMVN8moJTyzL2cSUdpgK//MpJOt4twR0wQ99gM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722209777; c=relaxed/simple;
	bh=H7qxBN1JFnIoem4FtjhiO0Iz9l7/4jiPMrpJyZo/rs8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NBZ1TSRF8GIMkXliZYPPKFkLkEpmPx4ILws+Z1XEwm5oXV57Z1XwSgxtaDebyZ3UfTLcgCO+stM2FpTR0rMUM6yX2ljdgI64/ghP6qyuZ+gZeroxtFbkL5UWKb6TGJvz/zxUsQfJY9ylD+fnexLULjkcqGUfpKxYeJP8Il11A1c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ktWKGEua; arc=fail smtp.client-ip=40.107.101.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ktWKGEua"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QzTpNGZM3igbNW310zOfj0xqU9hdS2Nip4z47mmK9LLrfr10k+2iUEgiwZqiQlWEmYgo+2u+a7tc8frlGXVmkvIJW0LNxZbw8fDTPAn9YHN63Py2CWWaJDZILPx5IQ5f1lDi3s1uuMHJhKslW8BpTEAAy9aTg5LZteVNjn9FvdfE4NNjRewgqH364Qayw0uA7chQkn61jqCMeRHufZOST72/J04bIxW80lynbDFGgh9J7eHIWXN/ICD8AuMw/ZZfiWIDy73Qf7ymwYQRl9RY+YFYI9LlQzUCo1l8nXb+1c2VSG6wl+u95zHQ4UIE9oDDsKUwQdoy3zrqqElbFAOjKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e4kD0KPRV2xhXbCz4uWL+yD6B1h9wfeFI13pk10hYGc=;
 b=YxV7yq+XX46ctzWzjvW9mGBIlm5yG0tOdzDY163+ge7Dv2bGXYRhNcKv/Z03Z0ne3XKt0i1qehxcxTDbYnh3yjZpjjWc9zBkfu+iXYBWzWe9SKn++TLrvySw/k8Ob0mQeQuT0NWbQYlDwQgVaLjjw8AB04dYxE8HSMljhKOaLCA+WRApCPLRpCZSWXsuljr6GrsEc3dQKmH5DA2uMVl6brN0DTU4Kb+iMArtLjtBL3stTkAqL8KjgTsupZEVrFCY70qK8w3Cv3DK6ZTYGMhCp0qsoX/RWUXpaYg/Kgk8Bom9hqj3UQ4bo8XcL2UuyO0rI6HQXHbBHF92VwtZhvhnVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e4kD0KPRV2xhXbCz4uWL+yD6B1h9wfeFI13pk10hYGc=;
 b=ktWKGEuaWyeD489ypmv5b0iTkbm4SxNd/1B0MHFFXmclrYB9r8I/F4T+Dbh3emE2Rq+FBrpmZ2KMdLV0ZFTFV5F7msuHqIOBvYZEwyIHuKWYP4eIqOAfGmXuBKuJZilR94CeXLxYArJMMZkn9bcjz56Dm/cZMSQc9t9VsdiVDfGMjtWrMvxJC6LUhQS4Nno5ZIFyMGtatH82kEbfSZ+Gech7vr6/fmCDDbO34gDeYiqLEOAxItE/UQwVWPhne5/wPhfUrDFUocSCsCLpJJaUP5H9YRIpi+HhEWA+RuJEadSoNoPakbvGzwKsCcQN1RZhWbgox2drQXuaVYstNoFLNQ==
Received: from SJ0PR03CA0233.namprd03.prod.outlook.com (2603:10b6:a03:39f::28)
 by SA1PR12MB7443.namprd12.prod.outlook.com (2603:10b6:806:2b7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20; Sun, 28 Jul
 2024 23:36:12 +0000
Received: from CO1PEPF000042A8.namprd03.prod.outlook.com
 (2603:10b6:a03:39f:cafe::a2) by SJ0PR03CA0233.outlook.office365.com
 (2603:10b6:a03:39f::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.34 via Frontend
 Transport; Sun, 28 Jul 2024 23:36:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000042A8.mail.protection.outlook.com (10.167.243.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7784.11 via Frontend Transport; Sun, 28 Jul 2024 23:36:11 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 28 Jul
 2024 16:36:02 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 28 Jul
 2024 16:36:02 -0700
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Sun, 28 Jul 2024 16:36:02 -0700
Date: Sun, 28 Jul 2024 16:36:00 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: "jgg@nvidia.com" <jgg@nvidia.com>
CC: "Liu, Yi L" <yi.l.liu@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iommufd/device: Fix hwpt at err_unresv in
 iommufd_device_do_replace()
Message-ID: <ZqbV4KY+H+tdpIhs@Asurada-Nvidia>
References: <20240718050130.1956804-1-nicolinc@nvidia.com>
 <BN9PR11MB5276718A6C5A02FC53D7E9C38CAC2@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276718A6C5A02FC53D7E9C38CAC2@BN9PR11MB5276.namprd11.prod.outlook.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A8:EE_|SA1PR12MB7443:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e273051-7cf7-4c98-d3a5-08dcaf5e1059
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?COibXDnwGuHaLzSoyeQ3jzHbAPKfTUYTun/sg0FmvLYEeks7Wnkaxq5cncbf?=
 =?us-ascii?Q?k87J4nRO73W1wcjrZ8RjtFyate1z/rWJRinKN/UiO4NjBeUY3eqYzirtDmUz?=
 =?us-ascii?Q?fLazGbjpHJAhjD76o64PU6iYxxjfjOgmfalpzDnRVarx6HmW2+/LUuyQ7piK?=
 =?us-ascii?Q?st1tUaM0g8Vdeps1GpOPG0YMQLnSMPJg6fGtHC2i29Ji2edSJ7nfurQda0uF?=
 =?us-ascii?Q?XBs7rijz5o5xTxxat+I3C++m/zToKz6nnQOBb+u1CQQYp3kyoFNlRSXnZ1co?=
 =?us-ascii?Q?Z/6P45HoVjVAddipMwFvCQsAaNdMp6jNT7HCVG53vJfkzLVnP57oHgK0dP9O?=
 =?us-ascii?Q?9yif4vfbUNBTt6fnM0rItFoUvj8m0RHk2SSS4wXpresbYUZq875G72eHZ3UC?=
 =?us-ascii?Q?LSLKNW4kXlcrksBUSdXHO7t09dHow95At+VnAgB/3R73aiQQGAKypCrZyqp+?=
 =?us-ascii?Q?M+yHl+C+PwP8220xGV8mrhTkUu6Jmq/Se4f511hF3l+PaXKLRh5OWoFPgEbd?=
 =?us-ascii?Q?2SZB3pilCu6dEJ8noHttWpGCAa2AKwBLvkcIbFhy4VlOM/csSi0uAcwXTM8C?=
 =?us-ascii?Q?XkyOE6HuZJzBzYP7JtdajGkjyuzm+GXvFDw9lErQyX2DGgAsg3sVDutOEK9C?=
 =?us-ascii?Q?qesJ0IBHGzRJH3oDwFASZYS+LygLDOtty9Pv9rWntC7K4+B5/lf3qxTXqMLA?=
 =?us-ascii?Q?lwE1fo5oZGBNGZGV8BERRfLfTHVpTRgVs8N9z5xGphZZvLY3RHxFlpEBzsYH?=
 =?us-ascii?Q?IdPqaALM4KruMe1RikkD/E5isnMPg6OANuJwgxEuFuJh0pvdmk+ccUsjPJl4?=
 =?us-ascii?Q?+aJmmEG2jlTBmzGWl0xCrj65cgwoZfJ0sZ7MpFFjMyTapbuL4RW3qL25vDZD?=
 =?us-ascii?Q?HDIuz2ROQ6XIj39Nf5D+FJq/xaIw7myZF4Gd7/OB3YH9enbI/S9PnZEZdXMw?=
 =?us-ascii?Q?xQxZ9XR89bKETJMEJWzf0CBJjjBGTNDMuk+p4CWs1ZQNeQBhLFqu/R/278Fq?=
 =?us-ascii?Q?J8rXfS/BpYFcho5JjtSelq+JQou7UJcOsju5VASa0Gwzx+dNykvEkHTxldjY?=
 =?us-ascii?Q?ihglciyjn2nXWzVRwFTPT1iRE0YaIOafZnaI179WO6Ztp3+q3spBJQXbaI8s?=
 =?us-ascii?Q?PpzuMHvLbMUBrrtr4fjvlyTg66ba+6Q+L2WIs9iC1IQpratyvR3SvGtF2fI/?=
 =?us-ascii?Q?Ny3tk+YhmwgnGqNbwsAsZwtcOGxDUprq5kVmk0+LP7vsPuwtq5VSrdO2FurW?=
 =?us-ascii?Q?wze1Dlkd0BTZk/T/TtXhFu+lJ2NIUNJACHlxZrcDWiKbRWALQMmFmCnZYEO6?=
 =?us-ascii?Q?6L0RCSEivZVwrC4P45gZ1mtXZL9z2Mi9mZHMGILCDQrVNw8Ct3Apr9As7+UM?=
 =?us-ascii?Q?FEOHkAwIlGfEisZ/5/CiAwTmXlkDL01IYJHhjnK1Wsnb/Pumdd6+LRvzcM9k?=
 =?us-ascii?Q?1P7aqeVhE4H/p4aDj9WcYD8oX/Y8jwkF?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2024 23:36:11.4939
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e273051-7cf7-4c98-d3a5-08dcaf5e1059
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042A8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7443

On Thu, Jul 18, 2024 at 05:13:38AM +0000, Tian, Kevin wrote:
 
> > From: Nicolin Chen <nicolinc@nvidia.com>
> > Sent: Thursday, July 18, 2024 1:02 PM
> >
> > The rewind routine should remove the reserved iovas added to the new
> > hwpt.
> >
> > Fixes: 89db31635c87 ("iommufd: Derive iommufd_hwpt_paging from
> > iommufd_hw_pagetable")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> 
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>

Jason, it seems that we haven't merged this patch, right?

It still applies against v6.11-rc1. So no need of respin.

Thanks
Nicolin
