Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010020.outbound.protection.outlook.com [40.93.198.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EBD225A324
	for <iommu@lists.linux.dev>; Thu,  2 Oct 2025 17:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759425144; cv=fail; b=pJFILFwHqrYIn4InL1A9brKlhwHGmaI1n00/FW/QRRQA1E4BbnZ3o19yUWUm23XsIA5G42HI8+1dnPzCPGtPZ4GNdTmnoD2LsGrmvpSE+hglvr2FF06l9h8NOXbhyPXDc+WPvn9tCmooO1jhyq7IHWFAZs3nP0tOocE25fslp0U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759425144; c=relaxed/simple;
	bh=Fx7mPM30sqxUM46NVOPDf6g1DhOlVVL10gqEcQ/ousQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xxy9FksTi2hND5a3t6u0ya02b+yZV+jIZ3uDYIy70oLSIe5pLArpTDjeZTUE5C/IHhHJsPtcZ48ERKMUlFccovK/xfVEM/DN1+A3z8Jhf/0VlZAeDORWPKRgCPzjTRiOBqvihtDx1hFxIl+RE3AGq5Ru5HPAsLEjDUuuNja8QGM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=USrEGhiP; arc=fail smtp.client-ip=40.93.198.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="USrEGhiP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FZBoqJyl1RBwB0sdMjgsM+bNe23r1+AEvTGlZlXypKN9pcNYtnBefRCOJlBcz++9OC4VqBqmmfhWa9f8v25nSh0bi3EvjiEwJ07ivlZcgQ+thyGQekGQR6m0hVpA2MqGy8zqVfI5/sie/NjHxrX3aBlb9pQmhf4y1JSOt8ExlW05fBJdn3xNcOV4DeiuiLmfatCQRURUCxZos3XPVH63gtslXj3dKaymGPGp6l7UTMJZsumwUHZX/UMwBCoz1soUvauVWJxFPmxiac9JPxNGqrCoVXibcjkvn8/PVlNpgyBSB5UX0JgjCjZMPHfDDkD4ctCkhMlBfYsMHDEd+6gFKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7x+qwToD60xRTXWP+7+8bjc3DVBF7/MbSCPB8TjLDsU=;
 b=hqLIkNuPwmsivAkzUN18E6ea0QZJh3Q2P7mxzNzlgSKxSbMCABTEOu4+evIfAnIGrAsH+YRj6k9BS/s0Dx7j3MhONa0OIFJcV8BjIgfPUp2hJINYA4FMQOnDca1arbdukoZA9Uz84KLPYCGJkxi5wrJbRniKcS0oHst2fX7geWdwaS7jfZr8Xc+eI+Ga70mY5xyS+e3l5FTgIglkea+KZuJr5Yg+ykNuB9Fq90QI4L5w2Xbba9SaA00XRbnFwWXKkcgnBpoUE10HAbhWS0opBjqMr1p4xKaroj+FDmoWmObSFdJPmzCHqaOGVMacNipdM5Y56BwzBBJV9nICup32iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7x+qwToD60xRTXWP+7+8bjc3DVBF7/MbSCPB8TjLDsU=;
 b=USrEGhiPER+M/Rpyof9UYA8qKsgjLttVuKn6dy6My4R0xSJFCelmYma8h1JcFYcjDz7Tdpxo/r/l/G28d05wXyn4w5qFxr7fB1lETDKBCnZyjUFWJgwIb0iB63UuKupavDxUeTbVSNhdLzL/VRmPBx4jP6GmkrZDBnoufwu+VIMkRSfcNc4S2CHEruzh7MaGkWI5BWu0IorZGeXfru9k3KeFNQAjMCTDrP0lAvmV9nOorWKceiOyN0zYIJpx2GCGATKpt/SaPFdW0gzpnQrA2UvCOUNmd2P7cC66Z1wIOdtMmidFbPUiRdh7nCZgzGT9xnBv36eC0Px4/C0hl+h3iQ==
Received: from BY3PR04CA0027.namprd04.prod.outlook.com (2603:10b6:a03:217::32)
 by MW4PR12MB6875.namprd12.prod.outlook.com (2603:10b6:303:209::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Thu, 2 Oct
 2025 17:12:18 +0000
Received: from BY1PEPF0001AE1A.namprd04.prod.outlook.com
 (2603:10b6:a03:217:cafe::44) by BY3PR04CA0027.outlook.office365.com
 (2603:10b6:a03:217::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.14 via Frontend Transport; Thu,
 2 Oct 2025 17:12:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BY1PEPF0001AE1A.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9182.15 via Frontend Transport; Thu, 2 Oct 2025 17:12:18 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.34; Thu, 2 Oct
 2025 10:12:06 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 2 Oct
 2025 10:12:06 -0700
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 2 Oct 2025 10:12:04 -0700
Date: Thu, 2 Oct 2025 10:12:03 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
CC: <jgg@nvidia.com>, <linux-kernel@vger.kernel.org>, <robin.murphy@arm.com>,
	<will@kernel.org>, <joro@8bytes.org>, <kevin.tian@intel.com>,
	<jsnitsel@redhat.com>, <vasant.hegde@amd.com>, <iommu@lists.linux.dev>,
	<santosh.shukla@amd.com>, <sairaj.arunkodilkar@amd.com>, <jon.grimm@amd.com>,
	<prashanthpra@google.com>, <wvw@google.com>, <wnliu@google.com>,
	<gptran@google.com>, <kpsingh@google.com>, <joao.m.martins@oracle.com>,
	<alejandro.j.jimenez@oracle.com>
Subject: Re: [PATCH v2 01/12] iommu/amd: Rename DEV_DOMID_MASK to
 DTE_DOMID_MASK
Message-ID: <aN6yY6ISLqQD+uu+@Asurada-Nvidia>
References: <20251001060954.5030-1-suravee.suthikulpanit@amd.com>
 <20251001060954.5030-2-suravee.suthikulpanit@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251001060954.5030-2-suravee.suthikulpanit@amd.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE1A:EE_|MW4PR12MB6875:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cc1c16a-5243-4e67-affe-08de01d6d77a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|82310400026|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Snlow4J3xWcnBGIUrLjR72etL3helWbGHza3vVFl869HJtWW0X/dwvmBC8Ee?=
 =?us-ascii?Q?7ryi7LLS9OhyMesZKIJX7qTOswSbYyE8boOh/14ROqeLpY2951cmS2ETEFyY?=
 =?us-ascii?Q?Uwxhu7nDcCGT7TrlR3IXcEwGA4CJk7682qN/F/p9ph+Ql3yEcDoE5W6jKFpc?=
 =?us-ascii?Q?NKyrZKtXyOraprUapapIbPttJuZRlt+Fi6Bu3GFZEGx+/kfkhzA2g7I/KeNx?=
 =?us-ascii?Q?7jFMxd/ubSdvT6UtZKx8sVdJoKLRxfSUSER0+6vpK4cs0QxuaRGPHLRRgau3?=
 =?us-ascii?Q?fO9BhcUMjnbIgiYYCiXXTuBrRpfoqlPMkqN80XqxkZPf291XE/MHLVnooHM/?=
 =?us-ascii?Q?oXXHV68uc9uCOuF57QkfUEdnGENYaVs8Ed5FhiR9g4mQ3ho94DMNGksxtGiK?=
 =?us-ascii?Q?W0muv0KYXo0pktHBBd6FNXnCowzKw2HPvqXy2x/kavM6ra0Nud22MhHdJeto?=
 =?us-ascii?Q?SyFY3664HHtb52OdniFDna4ieCGE6yW7NDgbGoRmVOhZew8oYTvporvQyiN2?=
 =?us-ascii?Q?vTobbEeT+VR7qvxrmyA6jLm19z7XHGEHZSBxlmRXEL/PVocrdtUbYrtahkN3?=
 =?us-ascii?Q?Q615K07lH6cINxqTHa5Q8VrX2820R1qtWdltO8nzOSKi+Nr1yYdIHjb/dLel?=
 =?us-ascii?Q?scDuB4T/1ssIJqWinkBBfXSXPU0laMNu+kKqKniQhyn98e5I+okG8J9N/7Gn?=
 =?us-ascii?Q?z9YvzYDBtrjk1bZaBFWIVjSPyjTy5WZuwRM40A9A2IfeSDZ/uXqKSnx2fdVa?=
 =?us-ascii?Q?1mMuJGqQnT1aBcs5Itz/CbDGI5xN10m+N8Y1TM1xOwWWEuoeVhOoIGnKGJvA?=
 =?us-ascii?Q?jDbc+P3pVbtxNMPYjw58akSd5rlkjIHhTNI81eLEK9zSGxhkMx/moA8omPIU?=
 =?us-ascii?Q?bD9HiK83xZarIEQHGRjwnMo9+Y+80yRKUSQI7HO9r8tVysZCgKKIHn+TY0B5?=
 =?us-ascii?Q?BUTlBjbFYOssurGo2/V1CbueYlWwa0XsDeMa3wJ7n5Tab3ImwiFufxKrJHWw?=
 =?us-ascii?Q?RZdcECfH5YEihkuda8vrGoak4XH83UePJAAHALbOmCgjAKYxM3ib0DcnaFVh?=
 =?us-ascii?Q?WKnBrjj9A2X+ph32NngIf5T4NybsU0UPAYxOjPip50JdVaf1/C4QS2h0K/xy?=
 =?us-ascii?Q?806uCHJpt4sKqxx6MWO6ydEZEzVscrQ+m/f6j/HnKh5K+fRReDkhsr6h6lIh?=
 =?us-ascii?Q?RJPkCXf1iZSo3lf5j+EDMZDKQtKaRHtBAHvtEpZSkg7mVK/4kzshZTqMio8z?=
 =?us-ascii?Q?QO0n7+nH6UlKxZRyiS/jIRQVe5aIuyuH5HUQL1bc47L6t29itCuImodg9Hro?=
 =?us-ascii?Q?uLwjJY+AatoCvhUEWnvgkOrgAujDdfOQabLN0RJjxKD5n9BNg0dl2SKKpOJE?=
 =?us-ascii?Q?VfOGP6jJNF0bnTi3hEd0REljgj6h2fugyXsCJStxNVapH8zPTzcvqf4L6n2o?=
 =?us-ascii?Q?RnGXtnBNE0vMlTeS3IwhO9gAccsNhfr7Pv/4loIcj2wk5n7yGd9TKm1GGqDy?=
 =?us-ascii?Q?+PLdWHRVCGGBhXlngxvQBZD+ndXDk21WsxmoB2iLgtIqrsS62zjautmWOF0h?=
 =?us-ascii?Q?uoX4Wt4k9HTAk95CSZw=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(82310400026)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2025 17:12:18.2203
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cc1c16a-5243-4e67-affe-08de01d6d77a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF0001AE1A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6875

On Wed, Oct 01, 2025 at 06:09:43AM +0000, Suravee Suthikulpanit wrote:
> Also change the define to use GENMASK_ULL instead.
> There is no functional change.
> 
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
 
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
