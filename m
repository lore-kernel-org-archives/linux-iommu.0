Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2057.outbound.protection.outlook.com [40.107.93.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A901E25F2
	for <iommu@lists.linux.dev>; Thu, 20 Mar 2025 15:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742485740; cv=fail; b=rsbUivjFwenG70x+vs2sSkRcV7Sd6X8AU8H/Y035aQzOGt/w3jCX8IlkuLpoMTPg7GNbGhX1c063ZKnI8M0vF2LKF7qsoVUCnZ4Z17i6w57MrjHA7yDpvVA0BbKIEFE4wq/nOsQdyGFW3mxE2/F+9Ej/O6JfCA/aY+sqzb6yzkk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742485740; c=relaxed/simple;
	bh=YNufwNPx0OVENIjUIcLJCgVq67filYsKhj0QNFM1tK0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=F/l2jRu0D0x0u156t2DHAX9EgZTSK02TPmdgCsrcg9gCqF6kQ79X9XW0ZDq7JsjNOA4vFsE514GBIKZXmGTlGtVnpk/+o9r0rjK67YUMVxpQic1bEBU4JISpC/dyQJ/IyMGgasugc07J505xJ2TkxslPkZXw/hZjU9M+gq1Qjjg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=A8XRSfS2; arc=fail smtp.client-ip=40.107.93.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="A8XRSfS2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=svf7Iy/JFGK/k63TPvMFor3Z9ghh5kUFakrdPJfTZ4S4wzz3JzN9hs1BAFQi0Er67LtrGzk4G4eIx9bdaHoAr/6NLbhg+xi6wHPH0mUE4J1WgY85Vp+3s9N/VSTlQphtiXR/NXJ9uuogTTugetgz+fHI7sVbSzOGuutJ+gPmf4JJFbiniUCAcWBzGyYfabj4qsGJq+f61JP055gQi2qBjQyv87cSEtRFyXnAtusGRWgbk8bst1/cTdArpWHwu4ZkMumlFFurDMwuLBYkPxyEDr1GYvktEZpRFesCMBLjkP2WIflvGTLLbEhKm5UAUot3IciHiZwLE7moTILy339FPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XdVO65YXdP3PgH0+YTD/1bGzLzr2MW3L9f480ZTGttg=;
 b=EfI0SyvqyjVWD73AIxPxCP/j+E67Dey9YH5oOJlpu1+iNOF2BMoopMrm2TCBXoNAB/KR7a2H/FzoBPijdn+Wa3vrEWMJQ+2VUrrF4aTY8aK9GI3HSqkNIWJPjcKHWkqorGlmwuPLSA5urQg3aeKQXSPrM8lN0U+chugKZWarYm5qlY4bO764YOO4DdQNBIjo/lfchEDHSW6PSEuW6y3yEMSSLVtBJw04iTUmSKeeAUO/FzsM48Jnxg82yJnkIyPChJwpy86UXvc08LW4zJmpEzbeWd2O80d6zEavEN82Fwdt07L6TbsixCLYqQNxMi2dJirmwRw0lIW0EXMd3KjpqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XdVO65YXdP3PgH0+YTD/1bGzLzr2MW3L9f480ZTGttg=;
 b=A8XRSfS22pr6TnzNh5xvqm+mpYykqmn2geIhdOAIKLNDf5lfwV3rmay/YGXixtO3nJBiYaWxQtSOMORBbjuc/1Bbi0BzisCocDvcGzzad4Bo6rLhI7fQYO2bIbKQSiuEIA+XuCM2h+ne/7Y15LdYDIx++AO1cZ2+peEBHPR6uQzps4QNNWn1pYSQm/xF+WLLk7DPJoSRSKKxgLSd/rNxFaFKykDI1yjjqqNHaWue5zj/h4Ps0mbY49Xv3UFpmg+gsgH1Z1nJ0iEvoTOpN5X3mZTgzIRDJcC8E+7QuQ4MPSmj6obOdZjWS6sYhvRf0f217gbOYkm9ZHK/EOwXDqkkAA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SA1PR12MB7411.namprd12.prod.outlook.com (2603:10b6:806:2b1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.36; Thu, 20 Mar
 2025 15:48:56 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8534.034; Thu, 20 Mar 2025
 15:48:56 +0000
Date: Thu, 20 Mar 2025 12:48:55 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Yi Liu <yi.l.liu@intel.com>
Cc: kevin.tian@intel.com, joro@8bytes.org, baolu.lu@linux.intel.com,
	iommu@lists.linux.dev, nicolinc@nvidia.com
Subject: Re: [PATCH v10 07/18] iommufd/device: Wrap igroup->hwpt and
 igroup->device_list into attach struct
Message-ID: <20250320154855.GA9311@nvidia.com>
References: <20250320134744.5777-1-yi.l.liu@intel.com>
 <20250320134744.5777-8-yi.l.liu@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250320134744.5777-8-yi.l.liu@intel.com>
X-ClientProxiedBy: BL0PR0102CA0020.prod.exchangelabs.com
 (2603:10b6:207:18::33) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SA1PR12MB7411:EE_
X-MS-Office365-Filtering-Correlation-Id: 56973ea4-e339-4994-a52e-08dd67c6b8d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OxjwbHzDsixAe0BelzMB3s+Q0ewwRFx8FntJXbCHgNYw3o/cEQk7xioZl9ug?=
 =?us-ascii?Q?GbLMG9+cOY4tyE+Vz1v+528VzBX+yGD4f22yBZaCRP1e4jJnvtQBQAAfW18p?=
 =?us-ascii?Q?NYTfH1seEMWk1TBz5ZukYdc9PQadcfkhXoCP5SAvDdwahODBwDg2WJFOBYh2?=
 =?us-ascii?Q?us0RIHM3FP1xCrkmguG5PDNqhKBr08M8lDWIYMCCZEPjblv00qttCqT73olm?=
 =?us-ascii?Q?3Cq/l3GHDnKlF+u4MDhsF6sw3upZZKZImUxrt9fK3bTlaE7Oe4bB+yLXLTbM?=
 =?us-ascii?Q?EGv6ZEOQW4E8/rZxgITuiblZqqjOf3lyvOiQAQB+bmfoI+T0apFGcaQLM53S?=
 =?us-ascii?Q?nUZ0eENcYL18e7uQRwc2EXCPBMsQPrcx4nMwvGo0whzj8K/nIDCOdHZOQTi7?=
 =?us-ascii?Q?S8TnR9f8lhx8p0fEticlEm4LDD1ekiWZ1ZF3b7gKgJd3HlLHw0HuQveZdgXa?=
 =?us-ascii?Q?EJbP+oziL6Zpl2EUb1b84cYvTIeVR41BEEKeoEm8StSgtks6CQnWyUgNIZXC?=
 =?us-ascii?Q?175t4D3xm0QPZtfE5mFjrsyqtE4VUhJUJqqF0r3IrW7F4X584OJ0s9157liI?=
 =?us-ascii?Q?BbPT8YjBKGW77zZAVyHB28g++Ly01JLe0XwcVFjSHeoWaZUmGuNKPr1CyVbI?=
 =?us-ascii?Q?SXZPNqJMZP+a2hyFeel07PnamfcWKgFHPeClrIoeUCqzyR9lsP+4jdSADFHn?=
 =?us-ascii?Q?WlIoAzjD+jT3hnP0uIItNdWUsV19JIlRf94dVPPAcW/e2pXqhsWEpTXcGFjB?=
 =?us-ascii?Q?EECMR5iRCG4C9yQGY1REGWk2yqXCLcAMuOMztwyQTPHEzhNJuqrH1MQagpaQ?=
 =?us-ascii?Q?ZkQ/hlMBYMI3WD7J11C6mx0N84jF+UuurefD3cKgHOcR27C+/O+w6CcgQfV/?=
 =?us-ascii?Q?UG0seQiEghZwwa+TDwDfYkgfls9el1KEBJaWnwFe7GBvYFEcRIzXZv7zgxNn?=
 =?us-ascii?Q?r5yPs1hy8KXReWQeXcWcGncd+Ks6McwhRW1eK14uBiPY4jeaFPoMmxYi4QtA?=
 =?us-ascii?Q?b4gFXJsoN07VMLSjW11dE5WYAsvYgspCPCvg54m054foTU3QZY/qrugDFBWv?=
 =?us-ascii?Q?vBfX+t6MsjaBx0depcWqASKRZza1f/3+rnUM7CWqlL3sGAPBeceTDRDhot2B?=
 =?us-ascii?Q?KuQ67eveGjouVACjAzK7wkvh8yhaO2uejZAqfWbg4VpiCV0eBpE+BAYCMHsS?=
 =?us-ascii?Q?HZvn4gUPTrwllK9aM/NcpFCak36ey+68kgade4QTZt2m3s3oPforRrMVtGmT?=
 =?us-ascii?Q?OMi8gZv+5VGf7xJgFJJ/n1b0c4vW3qObFqMtgvE9/uiYkoyX+ntx/nH9+IBJ?=
 =?us-ascii?Q?Z9rum/H+DSuMHM7cChXXGxmZ1TBvx9OI6lTn6vH5wbQrYXWj3ruQUsQ/lZUm?=
 =?us-ascii?Q?XUnpwua4j7UNmiG/8E7VbzVPT62j?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yzv3XMS5Oko2ktDs37wm80RrrvcmEHt9wV/kPyWZYrM7k47Mo2fVzmofRO+S?=
 =?us-ascii?Q?DwA8k97MuowDaaTOsIXyK55X4CqUDL7FR32Ui0q+2NPQy6R5ME00yWaVtbJ1?=
 =?us-ascii?Q?L8MB+1mYbprj2GKAJ/GgHltmOTYhoGbSNY4IegZyXEum1glAZpg08GVdgOdr?=
 =?us-ascii?Q?ZUbNWOMW5NrFVXk8g/hwxZfCdLaEjpQ8usj7qeV8+ciDQJwpRtl8jaV7lBtI?=
 =?us-ascii?Q?jJ51P+hsqe1N3EKr971nBUuVtjcRdPKuygD9N/WlXJ1YJ0pxjn6nZWKfrNWS?=
 =?us-ascii?Q?t26zvjVkIWkd8hmJYm/tJz2bpkPtSMStlJ8kHAuTPUyjn6AwJOzi/2MVZrWf?=
 =?us-ascii?Q?ZT1ok5H7NvdGqitaHiV/S2ooR8BupekTReX80WZKIk8nsRBrFqu9dGtz5nEq?=
 =?us-ascii?Q?s0cELmo1d31UOOpL7lMK/y3iN0ht8n/UyppG7FN2thmzRKM/uocVsCxMMcDA?=
 =?us-ascii?Q?Rt5dlKgGF8+ysQO50aQB24xbwr+pjoAZI0uivVOSD1VdFr2DqrR5W1P+taP/?=
 =?us-ascii?Q?X3Doubzg6NrFeltGwLPmunYOQQFMPA6wLuHfEXgeMavyJemKFsOjF5balkZo?=
 =?us-ascii?Q?uVWRdHoieYrANm1MiW0B7iXBvx57QjfnxASIUS8E/onbZ5VVZSR7mzer9PjO?=
 =?us-ascii?Q?+8tus8Vt0msIbBY4DH5DTtF8nMgknNGxMkekw4WlruXIlrPRIPu390cXYOFM?=
 =?us-ascii?Q?lX33cum/EkA6lw+tSsdYkxP6cdUZWL4Rr+7cUXw3RbxfLRo2Pl1NCbXnVDwh?=
 =?us-ascii?Q?FcjxhdNw+IWe/FWMbvBiPGwb6gfSVqKPQhxACSGDg3cpnZsRbvo/3mauuM7/?=
 =?us-ascii?Q?Npxjd5WkEnXAsak4+ze5xTJUoBU4L9gjwI5L9zWO+VsfL6CDSReVCTJOhWg7?=
 =?us-ascii?Q?WpYveqwWlCBh2sQ2eVLDi8h1T0DVfaoFsTeyfwXheeg84wziZ3Tf+NGQXbLK?=
 =?us-ascii?Q?izCjEzvvYDBSkemcTCFpuhTKAnFG+2jp9169bPDfmWfK+vhj+KNuvlYSDVvM?=
 =?us-ascii?Q?RN/+8pZtFAzM7MKdiI/9cauOFDT++dAH+fPV6Zo3FKZMsxx+DffvUGms5599?=
 =?us-ascii?Q?/eerRM0fMUtFkI093Tbco3c01LrlEQl1+r8va1mKRJgsbbjFiewfEXU2v9SM?=
 =?us-ascii?Q?dfcha0EIL8mLf1NA53Pxf/MVlGMDM1Qm0Bp+3Gd6dTz2RzZf+6i2aBRB60qK?=
 =?us-ascii?Q?7O6ZxxkHP3VvZNtCIzjZUXMI5Q3uYUL1hpBzVd2fgXxTHN/BfSicB/IaLRPV?=
 =?us-ascii?Q?YJzUdGNZrDS5mhxD+pXwBQRVQ8r/UxIww5JIf860IF5YqZPWiDKHH7PUs5hu?=
 =?us-ascii?Q?uuCvRShQzkH5bRyS4BIAl0DZBb7c0JoVU67t3E5+qGA3MjrWCWxUzxb6pzNW?=
 =?us-ascii?Q?sQxoegfI9aohUrRRNr6ETT2IyjRIJMuJ9GO/Lx4ug3nRhBa0wrhnii5y6mLF?=
 =?us-ascii?Q?iMuEe/jUtVewD58v4a/AJbiZQYgjA+ykaWR0CFiP0m+Sr/htTWYrEh4QWtwT?=
 =?us-ascii?Q?3NvJNkQV7v6ehB5upjtf2IBi4+EJgafeqJ0Kh0gAawAinceuWnqWLv+N99Ye?=
 =?us-ascii?Q?FAz04HFKXy99Z7/Sn4S3MK5ZE5qzKVQr3yc6HkQK?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56973ea4-e339-4994-a52e-08dd67c6b8d7
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 15:48:56.0292
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t2Llz7ioy9/HWjz6LNis2kWI1wfQCdxu2i8TgkJh/dz1aI5H8RKUeapg1acCE2mY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7411

On Thu, Mar 20, 2025 at 06:47:33AM -0700, Yi Liu wrote:
> The igroup->hwpt and igroup->device_list are used to track the hwpt attach
> of a group in the RID path. While the coming PASID path also needs such
> tracking. To be prepared, wrap igroup->hwpt and igroup->device_list into
> attach struct which is allocated per attaching the first device of the
> group and freed per detaching the last device of the group.
> 
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> ---
>  drivers/iommu/iommufd/device.c          | 76 ++++++++++++++++++-------
>  drivers/iommu/iommufd/iommufd_private.h |  5 +-
>  2 files changed, 58 insertions(+), 23 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
