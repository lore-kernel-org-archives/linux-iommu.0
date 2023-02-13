Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2087.outbound.protection.outlook.com [40.107.220.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644B3AD20
	for <iommu@lists.linux.dev>; Mon, 13 Feb 2023 18:02:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e1Tkyen0HjfL1Xd48lSVr8BeuUX6jIE9+gj+lsHJwkrnXDOWuTTapcSbPGZKwirsxPnYaieNWzWXhpLJJC9JGNfHXB1wGxhIhVUHg9VZYMNPNYYCWXi6ErLCQF9Kkh87ELQuE6gv1MAA6DVhrw0tV6UhK4FexM3J7Zj7ynEZH5JT36gIccDXdlu4Hm45oRC6SyuKFuIU2948cLlx/zySXHO3+3VeUJixps3XTf4baMPXxXUAdmZY7i/Jh6KaKCN2RBC7wi5EGeD1VsOuDLlpnY6jKiXUyMRkW/8TUtatSlevB9xX1otErTTlxtxBxVROaSQUuo6/tB6bqpol0mjlSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=91Vrq1DfZnwAfZlVXNwGuwUHv8MRpiavXcmUJIKGxUY=;
 b=LlM66KbxUxbc5ZNi8ayca8uL/Pin4fosA6G8CSN9nHnfLxFD9+nYUp35/gx12zo2Pz6PO3rcbdC+RqwUvkduvKhSFinLcrNHtY92PXSb8gDnF4Lwp5jeq3I/XGUlbY+lpTzCYdfPsUquRxwSPkTbLDH4sbeZRhXNVJmTkzFZB/xxZwpMW+4xHKinMa0DcfnXHiRGPe6d0C6FmWa2hDe7x1+a9VjnBlRcy8nRTm2fe77+VWRR4/PSg9JJ9G5Zrs3RGUDYm2UXITjBiOTbR1NnKo6Mf3749EBzsKutZYdqyQ3Enm+Eics81XYux9P/C9RiB0eVbfZTGtDhRbPK5ikcYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=91Vrq1DfZnwAfZlVXNwGuwUHv8MRpiavXcmUJIKGxUY=;
 b=cIZrMdDiuVLy973GYxT0i9+xUVe8HxIVhRqMjEystuzrEawEctwnXdakROGDz7sw02E/ZQyhBKmqjGMJr4VP2kPHOSiFHy3WgSE4NzQQkY5SJaO8ealZbXD2SBMoPDWcwbzgh1liCdtxPRyxaf2feEdGb8/G/MTYaxotHb2vV4LQztO+o+Pwef+rsyrIdSWSduzB2qX4D2Em1k6NaoqCVycriy2noD4mM7l0J3EBkYxl39Xewvg+ahHbnu19yAoWcaJN9i3dRhWaP/Kxx0ZFU7uM/w7tR8J6LiDzVNQLe9vg/DHrFNAi28hHt4Po+ZP3DCqd3VU9O6nm25nYccp5hg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA1PR12MB7493.namprd12.prod.outlook.com (2603:10b6:208:41b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Mon, 13 Feb
 2023 18:02:49 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%6]) with mapi id 15.20.6086.023; Mon, 13 Feb 2023
 18:02:49 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: iommu@lists.linux.dev,
	Kevin Tian <kevin.tian@intel.com>
Cc: Lixiao Yang <lixiao.yang@intel.com>,
	Matthew Rosato <mjrosato@linux.ibm.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH 0/4] Fix hwpt lifetime and detach bugs
Date: Mon, 13 Feb 2023 14:02:41 -0400
Message-Id: <0-v1-4336b5cb2fe4+1d7-iommufd_hwpt_jgg@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR18CA0017.namprd18.prod.outlook.com
 (2603:10b6:208:23c::22) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA1PR12MB7493:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ac2a208-321c-43ee-bbd4-08db0dec84b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3ysUYFebKJiLBlwE4bmTsdz5VywsULcEet0qeJkYzavUWO9pEh5K+9jMvWbBScteEene8SJAovIOkSO+J6LfteCDPLSuOumnYElbMikk+fgMA7pRkhnLHdfDWCnrO9qtrL+fqiPvY6Bnz9vry1mTuq81KHSlMkQxVGSDRgeLEQbuNSQ8m/Ey9lzqltC2vaDj/AbafjxPF8H/wQoGaZ3RjG9OCNNjXAJ/Kf/gIpgfYohTQ7Xb2Qg+65eMxntlnbttC3FB+S+KSCn122qYQbZURPUtDtlQ9zzhj7C1lgTqkVlfrq2MZ93mT6Tm4yyHfX1iurWt5RBbfiYlwEozRNFkhC3mcO9gxg5x2Kj31KGMDsU4Q6Q0bTpFhVKzjZ34csD0o01Ld1m38RAiWcGKUVsnxLffQSJXc+nFReE5Wl3vJrJTUb8ngRlVChp50cS2oMHWYNKQ9EYJHCOgLYAVhLtkAq6wkLYlfWlTUV3IyL5Sqm9IXisASp/VHlicoNlU7Bl1kyXPzevm56Rhe+PH9XhLZgMSbnyAl15S4++qLGJf0FFCtwHDoArCjzrzOCEwyRfraurqhlTgIlzmADPMA7fmZDWOHWK9wsDc1XLTy6CeEWsfSOyMiXM3f9DTKvFruKWgBSamrelrukRGJD0DCRzWASz8Bp4iF4C3kYeXPFpi/dOW/aYUR9vMKMJSb051Fzyo
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(136003)(39860400002)(366004)(376002)(396003)(451199018)(5660300002)(4744005)(36756003)(2906002)(38100700002)(6486002)(86362001)(478600001)(186003)(26005)(6512007)(316002)(66556008)(8676002)(2616005)(6916009)(66476007)(6506007)(4326008)(6666004)(54906003)(66946007)(83380400001)(8936002)(41300700001)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?koufKqSqGZp5FuJmnZziQ0sJDskXkMw51DyCAXySCOmAbzxer9VEjMWR7wKC?=
 =?us-ascii?Q?q5XXhtSVjlS/WeVFdCeb+omHX+f0wx4IBaHNAAlnQz9DaX1hLr4YCYiNro/B?=
 =?us-ascii?Q?sF+gVkoVIDsqHyJdczs2tZgC7xKM6pNf+AFt4hTltQrlevfhMVKWSTgt4Wm2?=
 =?us-ascii?Q?HQjpQricXjhaNA9LEc6XyM1g6yf+xwTwyUmLR74abQfuNRHRUUY0HoUYWjun?=
 =?us-ascii?Q?vxipQ0nuTt1gnc7b1PTr7CzYzFvPSfHlRKA4OYqlc+9WdnYDnEI/V0Vr3CH6?=
 =?us-ascii?Q?ljLbvT6ZAVj49RtQCMJj2dy6GXhiqEw1hgomM7GUVX4o1YlmaZu5U21YpoRq?=
 =?us-ascii?Q?ZMzPYYP9AiYLTFXpLy4BR4Jl2sp5vqlYoIUTrCocZq47fEZK3jB4EaKu599U?=
 =?us-ascii?Q?9we7QRboY5/m3v19nPnjiofsW7iT4FE00MsR1+0849ffsVEP/4yDhbPKxjbD?=
 =?us-ascii?Q?5ydmLGfm6yMwmLyK8dfLoMcb16FwniH7zfOGG3M27aGR9tkSBpFu9ulLfry6?=
 =?us-ascii?Q?rM2WKra2QNNr+eGJ2gyTePIkdugdx6xOY990VlFyaL0YrI5YP7iIvIONtoSd?=
 =?us-ascii?Q?0AWCbu/7vBh76g0tPY11NodCmXYR0wqIRiA+aNkEibfyFWwXu6aSLBTjSTxX?=
 =?us-ascii?Q?tl8mL9IZxhfIHHGGQDzStY/dDxDVC7cyfiJ8wy9Ml7JVV+kdv0B3CNquxFl2?=
 =?us-ascii?Q?8eGq5CGqOrOk4K3yl25uomyF4FQJriINZRgEbomLw/TOYkFgNVJ/Jxxw/U6U?=
 =?us-ascii?Q?lmM04LlSF9ShiZiaGq0K3h6izAgA7l5zsNu4deS90rGNrRCMl9t3GV1idg7v?=
 =?us-ascii?Q?VygophpP4RPyEpCKwELayAww/DpNDAo6ndpvUN7tPgZmwl4GQY2Jp6dv6l4l?=
 =?us-ascii?Q?swnOqtNPOZHpgSzdOzmjbhLG6DahlOWO4oI8Nw7wtR0LhE2hJmDsMm4+G0EH?=
 =?us-ascii?Q?LcQQVAGDhOE+TOPfr6SNtbaUH6QGXYorsCaBKWB+/vo4XQtVHgGqJJwEUxtD?=
 =?us-ascii?Q?jclq/dBD5wgGRR1kbAbyZTOHV73EpcyAxe3wVDCMk19R3os6WDc5kQDt5Sct?=
 =?us-ascii?Q?2OxRLNHKFeYNwOj0iIOpm4Qq4vSJweNA+HRMvIZb+UaJGHaByE1k5wRI+987?=
 =?us-ascii?Q?k38Rt3jCEK2UG+K/I8tACj9R2zqEfww+3YV+HbCvfaXZwALVeSOBHWaz7MrL?=
 =?us-ascii?Q?EEG2os+9IjPRScGXAGGmw9sPxkhP7aI7HfhXA5Mq2cakeL5dyKln7TwMoBiC?=
 =?us-ascii?Q?6PM9tWPA9X4TkbrAHybHzkN0Etg3X8APGhvTMN6wPEnD8vsEEKbrwTCgE1wC?=
 =?us-ascii?Q?76ZAZ8Z3q3WLYQhiaj8wj7wCSoFO1Hxw3bxL/sCJzafhP8FYUAF7mwgvtdf1?=
 =?us-ascii?Q?0Qm04XTeJLhK1ok2MDK6te1QEvmaJsbDVqWgmB1Du/VWFfzRhoSRKrNQy3de?=
 =?us-ascii?Q?AGWjsRIt0b4s16QMxLgM6iNYXuS1Ncp85SqOaSOG5c7ESIzI0iHRtM+7nf7C?=
 =?us-ascii?Q?JrAZJG/jQRbTnBb8G3NKXDU0nNKvTFRnT0Ge6ZEz5PIweNG5uQBSaX7LrdvJ?=
 =?us-ascii?Q?YXg8DZbgof7WTQ7Y2N96XaqkAa384wE0s4c9mZfN?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ac2a208-321c-43ee-bbd4-08db0dec84b3
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2023 18:02:49.6620
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rkZwf30lHKuk/k/Mzvzl7h/rYmFd/wnxtGtnJfKq0+xh2jtc95KbRfh+nw1d9JVA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7493

As discussed here is a small series to address the confusing lifetime
scheme for the hwpt. This was some leftover from prior rework that was
never fully cleaned up.

Make it clear that the ioas and ioas->hwpt_list are associated with the
hwpt during creation and never changed until it is destroyed. A
post-finalize hwpt with a positive reference count is always valid for
device attachment.

This should simplify the nesting and replace series.

Jason Gunthorpe (4):
  iommufd: Do not add the same hwpt to the ioas->hwpt_list twice
  iommufd: Assert devices_lock for iommufd_hw_pagetable_has_group()
  iommufd: Add iommufd_lock_obj() around the auto-domains hwpts
  iommufd: Simplify the lifecycle of a hwpt

 drivers/iommu/iommufd/device.c          | 47 +++++++++++++------------
 drivers/iommu/iommufd/hw_pagetable.c    | 25 +++++++++++++
 drivers/iommu/iommufd/iommufd_private.h |  2 ++
 3 files changed, 52 insertions(+), 22 deletions(-)


base-commit: bed9e516f1183faa0e484479701cc669efd9049a
-- 
2.39.1

