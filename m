Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0802D2110E
	for <iommu@lists.linux.dev>; Fri,  3 Nov 2023 18:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IcpdCpx+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y65MQBe30AlEBY3e+ZQuNzsWVWIiZ6mP7X/8PdK57ILNx7uLR2B2EO+dKyzwINiwQ0FO1QPpZzy12xXVJ+q5NXL8zXYFWAxyqAn4KP/tNjaN4SmbJle005AdhCa4g/XzQi/c/DdyYr69hjjwB9m/+HbgofpJkB747N59jmX3MFUiUMYUPQKqMacdMVYmqrf5T/gfOrR/MxWeADZethua8ouQszunseOjFD8og2Ab0jOBoTs2SqJMQxRwkdWMZNwiblL2z80S2nI9RQq+BMzbJ2d+kTAS0F9DtnAQ3wegXEnfQZbmHXIkPLArE7KE8WfvnN+jyN6upKXFxneZ7K9lIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EWX9pWbx8BkX4+galxOkl3mVHcVxlXkTdsL8+ZitIz4=;
 b=cIbW/o7D0nuS7OmPw8f0fxdfPtLiABPfaWk2i06mCTI0cfzJcZKYf2l1M924XKdsOiDnOL4/muiMCclIsrdPjyrKUr4KLpGH79r6Z9QLF5+PDeZpIanudkomwib7MfuMuPLjKGEKlBt+2RCjfUZhLxNrmpDrisrf1ue29uON5bDYnPXsRpYJ5A+0FXNNfBciFBQG5nzbMYRmK7TC743ovabkaQ0iWFlSV90d/kDMqUqbE3FPIMpMUEwZjIjnbjMPE4opkeNwSBZWEoMT5134Fw1C6UijVa2MSPUc7lcJagSFNL7LKi8ATQ9hM40vu8ePzPs2iWjN/7mFbE1apyW/8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EWX9pWbx8BkX4+galxOkl3mVHcVxlXkTdsL8+ZitIz4=;
 b=IcpdCpx++6VhjSK1PjK8/p9qTBtKj7Ff467J2ckXW6KV8+3oQZr+bITMCGPnFbpJr90fNyy+o7bOOficWF5mVoWKQpbSQcIWfg3+OiWJkORUomnBTmWO9fsAz8lYaJm+R7Dxm6nCu/YkgoAa2xfzawKYave/GN6cMo43sh/jo7t86Sp9OMS8VcOjPC7hryV9stGdPWBwyfHFnl49T2n8vQ1GU9DEtuA5CpnFwfXWeeF8AIv2Z5MEOg0bb9cCvGzhhshgIIcukIWFSiW8n8YPrN9SkYctt79+yy5tjRxVOZEupQ5PmQU54YOCuvRhOXC64M9or2qYdRbqGTZ2JRKuZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM4PR12MB6133.namprd12.prod.outlook.com (2603:10b6:8:ae::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6954.21; Fri, 3 Nov 2023 18:11:07 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::b53a:1092:9be2:cfb9]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::b53a:1092:9be2:cfb9%4]) with mapi id 15.20.6933.027; Fri, 3 Nov 2023
 18:11:07 +0000
Date: Fri, 3 Nov 2023 15:11:06 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com
Subject: Re: [PATCH v1 03/13] iommu/amd: Remove redundant passing of PDE bit
Message-ID: <20231103181106.GC223197@nvidia.com>
References: <20231006101624.5912-1-vasant.hegde@amd.com>
 <20231006101624.5912-4-vasant.hegde@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231006101624.5912-4-vasant.hegde@amd.com>
X-ClientProxiedBy: BL0PR0102CA0028.prod.exchangelabs.com
 (2603:10b6:207:18::41) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM4PR12MB6133:EE_
X-MS-Office365-Filtering-Correlation-Id: eb1871bc-5513-40a3-8885-08dbdc984050
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	YvDBb+cAGicXwc9qNQd3Q+qZUD5ElsxAzBGHO3CbcqCqK982yP2w8MRiJtHNl1xsAurm4v9I5SlTQLd3QRivgcX+9eplt/i/nbmMThZ1fEiiVv6hvg3Sa6j/pUY+l1MhQIDBr9cQCODAdX06ocDZowGlkKg+wCI5H3gaJO3D2O2JdBzt3Z+vUHnuVrEeK38MTF7uhfG/RxeoAqL1pCZaEivndRl243bsPRdSnk/CN+/sLhogdiXe6nmQiX8bTbqNYzpfB1ObdSzAcWZ+SLKvoFl8F3BaJEOO6fnNnQqOcAe3ft6exRGxj8m7R5hMnpDeBQNWOqxBOD5ugM0ZUk3wuhpcmsz6qwGVJgv8uwlMxe5vDyg7o1zl51Z43/P96xjVwkN1U1+cYAtPM0TweQO49Yd4AubfX+mQR3/OesXJ+vys8U/eOx55YadzD00HAZELRymGl+x/9+ayA582dRgN3iA+Sgovw6AVz+89lrDI0WuFXAFtS8JDyUVRWr2kmFBNhYhkzeteiwpb2zfmrlFJeqL05x4b9oUpjVDdzcxdor5JAtZSv+dFNbgAzmwfDN9tOX1/8cbw+EElGEnZBq3s0CWaHzdL1IDILEc9Njc7KQM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(396003)(366004)(346002)(136003)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(1076003)(6506007)(2616005)(83380400001)(8936002)(41300700001)(4326008)(8676002)(5660300002)(4744005)(2906002)(6486002)(478600001)(316002)(66556008)(66476007)(66946007)(6916009)(26005)(86362001)(36756003)(38100700002)(33656002)(6512007)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CqQAup6cfyBV2mr/dfm5JWQoHr9pTCIternqjo2OGB/yktgCZZnIgwQA8hI9?=
 =?us-ascii?Q?YT7/hiflU1iqrQ7HPiYpRYhhbpNx/+/grVjSJaP7MJf8HDBFE9BUUNu7LB5O?=
 =?us-ascii?Q?OyfYrTBXN8gL3l5UdZhAA5e1ZRvahP6mbeXf8fmAM2ZYu+9/jR9ljyrpnphN?=
 =?us-ascii?Q?Q04wSh/YhEmIczxvEF+Zt1dAEy6wMPJv15PZGEvboyGRANH3ghZpn5+QGYco?=
 =?us-ascii?Q?gNmMTK5fxw8d8SmNi2i548jQz6nnWKJtxwPwtW0Oxd+nDaiaxRjrLTn7BGnO?=
 =?us-ascii?Q?8xUfZV7Ip4TxHKoosfPZRDOr/kwdkt1Nb5+DynJYfC38NQupT6Oyv/FWj03Q?=
 =?us-ascii?Q?E1IxFn2A3sjVAaLs1dNlvGQm/kDO4/saAAz/c91AoMmsA8VX/vhyr+R5yTIF?=
 =?us-ascii?Q?pivXC9OQlzrWC/uaWbVvkwZN7Qgr6qe+/Lw3CYxzIxYzTW4RIA2MHUB5Bl/h?=
 =?us-ascii?Q?jg9/vEs6vaYxxITO39Vch/5NHt4lOGLpU4yZQXj2oqbF7bDhnC47wU65dCBL?=
 =?us-ascii?Q?2vuCOoGZmfoXeZl1sDluqkBjBycs/nGH4CJYu9svTUXLu+A3mLLvQ3c0KIq9?=
 =?us-ascii?Q?qZ41BQHmZZvazw0FjIPXKfpIVSvgT1A1gh2A3fIqno16/R2FXSKK9Cqlq9Mg?=
 =?us-ascii?Q?7rrdXaXTOb/qWA+R9re2m9+fque6ZkW1pfYyimJrdKK0UY8yygp7kYy8otO/?=
 =?us-ascii?Q?vLpMJ4fQWOwR6nfTUBUl8CNF4JK5mOexUNJjrW+6VSzSOL8RiUHazga9V9th?=
 =?us-ascii?Q?fjPH5tcHGzJto4d/8qhz+sf4/y2jhWqWK+WH+PSjJczOTELpOEwGn5FcVOGO?=
 =?us-ascii?Q?B49u6vZn8zHlwrqQIw7HWQdHj6PigMPJVgPssnh7KeXwzveyCLLJRUWc3yZz?=
 =?us-ascii?Q?1pYMoT7LDB6Scae6YQO619VSDmypuT0cAqsAPEfQoFDZtdFbhIUmAksINc5G?=
 =?us-ascii?Q?oIEX/YiNDQb1vCliWFRr1snRTiHHSZE+fX1S9BlfsHFrEAcvEEMikD664Z1D?=
 =?us-ascii?Q?JFt4pEWg78HA87nSYyR5GeYjYDUIExjJii3rhCsAEvfFX5bwlqv1ydUc+tCn?=
 =?us-ascii?Q?Sb6U6WxGCJS3ayr/YMCSIIslFJHC7ymaiXHCDeJ9n1PmMQQ2IlXHcZfGRwYn?=
 =?us-ascii?Q?r+7gSU2ChY6FzcQdkcIV6GP3O59156XppE4RGMU4DiQ+6JQcLrHdbYXkDTbN?=
 =?us-ascii?Q?B/u4oogFYWgvElU7JadO4AfTwX0DwV5Lu7kis6hBYk1+vdm8sPeSk4JNvJod?=
 =?us-ascii?Q?OSTvS9lHSpG10Ek+dwPNuk/0iachpEQ+5QmaWYvuN/66T4S1W/SC3quTbVPQ?=
 =?us-ascii?Q?Ns6Y0al02ZAyCGJFERw32vyAO28mP+43qUKjEaoDDP6t2uqS+dPYNOa2qypu?=
 =?us-ascii?Q?1gIIHWR+OiNoUUeipjYejCbSKBxE4PiLGTDK62/PhhfTKgrZRxmIyq3v6MLL?=
 =?us-ascii?Q?cAUoghvoX2S432I1G5AQGKvKrPE8vFa3glgUnflxjdJl9P/DlPUPvtVW1fdT?=
 =?us-ascii?Q?JpH6ZZwr5sqAToLAyUdjxkYa++8byVyVRFm+9zIv72NFl7zRByrwnZqAgkLN?=
 =?us-ascii?Q?5lXDECfNrNBbAENavcLuPWnX7cibgBWj7roq1xr7?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb1871bc-5513-40a3-8885-08dbdc984050
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2023 18:11:07.7447
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l8Cukzanl3dtDnbVI80PSTt8d3PMlFQgBg1Sm1aL7ZcGIb2yRvfqFcPDk3PCydxQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6133

On Fri, Oct 06, 2023 at 10:16:14AM +0000, Vasant Hegde wrote:
> Current code always sets PDE bit in INVALIDATE_IOMMU_PAGES command.
> Hence get rid of 'pde' variable across functions.
> 
> We can re-introduce this bit whenever its needed.
> 
> Suggested-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> ---
>  drivers/iommu/amd/iommu.c | 27 +++++++++++++--------------
>  1 file changed, 13 insertions(+), 14 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

'bool pde' if you do decide to bring it back

Jason
