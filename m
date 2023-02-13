Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2087.outbound.protection.outlook.com [40.107.220.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E606EAD20
	for <iommu@lists.linux.dev>; Mon, 13 Feb 2023 18:02:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XL6XyKdwH8tgGf5FWgDUWvBNAti7Kj7tT3dvUKWV1XhUf3D5qfUo2UvAOLRRDQBmkivlszGq1miPkmidpzIH1x4GYPGFmVHbkq14aJW+Fz3bwkZr8oMA2/A/JjXBKh5EkpTr73Up0B7ixtrXk0lFZ0UulA6vx79JDQGIy4BBJvpS0xRIUPS20IHqC55M+jgDbtErZauir/IBeVmD4MdFwsUdaj501/md4FULB2bfBiu8PnrdSJYOZAez6OcMYy06bUs+AHuMSS8sCMyOCMmgYAyeBXq5+GrTIKSPELE/wjUOIBoeRJ7BWO4NWC0k66ivshd5yT95LNb5dTFw9XNRZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5egLCEfjKkGkTjn01+0VP9JiBUIOtYb+2+pNNkTddYg=;
 b=bKIFbWu0gTsardskMFeemHasr/8Uz4fpf6bDaDcEFEWLIGzZxDEZm+RDr2GsKEiDIPBhKZxlECQfuTHOf4w8oBE8+C/i4xl1kM+etfQFyL2ch7KqVEDGI4CGEskEiVrs8lgTAJAk56fKh1QD4eAfecjfufRsHuiT0IviKHDZbLsP5DvpGbb1tN7czh5qcRnEmA5fXoapjA8gXt0IZdnNpzF/8o92MpTQd5LE4JtP/+c6x1yrurxs8LvnWElvIe7qzOJkxriVxr6mpMdQJVguS3Sk3feprftv/yRTslF0sMt5zdZTj9/rSyjN3MxWvjRelDqMfjRkDlU5wW9vzOaRxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5egLCEfjKkGkTjn01+0VP9JiBUIOtYb+2+pNNkTddYg=;
 b=hmyGRVu1hizo7YNmbdZ0Dzt5Uwk0fAMw7nxw4t+DaN3aCVgOE7v42WmP6ptBS6pq9HHOdQad6B94SmGn+q1yI0YMDGpOZWHHmGGprNxFwWY80d9Qo5bQZOZu2Vo8XY9lNT8uq+gKyrv+KrZV9+VAm9d0iLCAkuTSWfHgXAPtkx919g/y6r77g3CsHYiWTVkkpOD+r0SvXouti4n9rxBm/2J87FpgF/uiBjiiA5X13E+egQdGxFocv/RiJBWicuT7oghwyeHMUCc57ZkcJD0UHTG//itGnq4O/N8Q3oDewQoVbuoaqz/q9TPj7aIfzw53b4AR3duw+F9kQgJYAGWw8w==
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
Subject: [PATCH 2/4] iommufd: Assert devices_lock for iommufd_hw_pagetable_has_group()
Date: Mon, 13 Feb 2023 14:02:43 -0400
Message-Id: <2-v1-4336b5cb2fe4+1d7-iommufd_hwpt_jgg@nvidia.com>
In-Reply-To: <0-v1-4336b5cb2fe4+1d7-iommufd_hwpt_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR18CA0020.namprd18.prod.outlook.com
 (2603:10b6:208:23c::25) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA1PR12MB7493:EE_
X-MS-Office365-Filtering-Correlation-Id: f06807c0-687d-4e50-70f3-08db0dec8344
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	zYNVEM6EktI5oz77q1tYEvQD+XO1IeTnUyfj9c/Vcfn/1ni0XXe1l5A1tLgW/P2IE/Z2bf/w3AX1Vvi8nNxpTiAmGtvirEtIUoIXCjoAj6zPtN5oKh9KbiTSnZX3qjaZuT0f+niWUQAs1FSyHU0PRmSDKLAi6LWhLpx8EyQyt0KqxYAwx9+CAmiylejGDf/PqDGDcL/D1pA3ekVKQaX8rVJJl/0L8/NLHc1EMf1Dh5S+gp7BRTPtKr4bSLACOivyZ7mZtqw5aFs8IdiY2xLkIXZ5dg3btpx0kXt7BAbUsyopmelzhO6sbB2PGtrB5ZOhio4mMBed8J43C3Pl3zViFLcr6kvTiZyWXw8WABVLMDemLhejcoh7tnUiQV9HFsYkPDI+jcrZ3eiPABYI9YaNhfTJRP7mxHegNkKk0hu15CwmwcZ+2qDnu5oVhy+BFzc0D1htMg5OhmPO3OLukDkqs2qpVyjNEf2F3msa3Umqm7FTczamd8c9hFXfsaaSr5EZT9C+eCncuNHLrg7XR8lOpvuAKDpPILvIqsOga3ECSkmBtmAY5wHLigpRSWbp2NgnMyeyKpPkvH+Da7i0hhksmq8i0imDnugpzoEQEUxlH4f5sgoLfN+8RhnhWxvAzRrRPsOap+jlv0Ea5LVMpsINWHfywt/2IcJ/plg6dF4ZeBdqt1PQXuPMmaVN48d96Wr1
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(136003)(39860400002)(366004)(376002)(396003)(451199018)(5660300002)(4744005)(36756003)(2906002)(38100700002)(6486002)(86362001)(478600001)(186003)(26005)(6512007)(316002)(66556008)(8676002)(2616005)(6916009)(66476007)(6506007)(4326008)(6666004)(54906003)(66946007)(83380400001)(8936002)(41300700001)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dyvbW4jVio9izJa0DWHBLJLklMfePgyaDZLuF+WsRTgruNu+AIvSbw6FcRbM?=
 =?us-ascii?Q?nsuiPd7BiCY9JIAM6tNkm5ze4S1eypY5fM962+iPk6s8qiwCEYCeXuS/X0xV?=
 =?us-ascii?Q?/I4piEfV0M8DPNf3XMtrAwNCjBFQikIZv4mxHoxhHNT7VPfS/hPq6Ak76mCQ?=
 =?us-ascii?Q?9aiB0IqIYYBDA66fSpwVa3lhOqopXuEAoI+ugfE2qMyZ+VYsByyQGR2kdCWd?=
 =?us-ascii?Q?mhAng7Wykyp3y/pneqhOSw1uaCxReRr3S1SaFAAsfE6fRmCnNZfySDxv1MFv?=
 =?us-ascii?Q?CTa00Go9V0hSrjtZRKPDZe5X7+jHp1YFquTc/+iXl6PAemPmxLigheSqOBTK?=
 =?us-ascii?Q?KVuEqjqcS/uEArS7+3EMKL9ot2ugk8N0z0uOh/15VhHCunvrPlwnnZahtqxq?=
 =?us-ascii?Q?2tYrMNRbRHudnQz1BpczZK0CKiAE9wmdD9RnsyahRiwjQdfrdIkEe5+cItSI?=
 =?us-ascii?Q?N7gfzxld/c0VRjjm/pmsY55nz/4gH+fVAkarkvYaT43MPGGeXoHvF8jC7Hfc?=
 =?us-ascii?Q?Sd3iqjzCny7pc+TqPANSQm8QMrhi5S8lnZ/WEE+o00NAqKN0oOUeYq+yVBtV?=
 =?us-ascii?Q?5QDTtDYNPTdWmJIkRxUy24Afv3O9dQ/5q3rsPQiOCIpLy1XY/eWs9EReSjBr?=
 =?us-ascii?Q?w10Rx+chczUSeer2f+ZALJjeRkn84syfl2jVOLkO1H3RjPwFpNUUMD5Ma/T1?=
 =?us-ascii?Q?e0Oad2fF+544au20c8rONTlzupwRDCxfb9eXJNtN0wPS63mjrENVSjBRz8O/?=
 =?us-ascii?Q?I5OTnTxmptdg+kwQvXcLu7edi/yu+mZfMcomKfnZb5aAKVdX91W2EFA2MIei?=
 =?us-ascii?Q?TuWYWVUbsOrF2Wpdt66SaTYdmdnbgp0j1u9Ra1gVvCp6Z8/AKOdsW3aAEGy1?=
 =?us-ascii?Q?E9xMB7RlCOzCrkBk9Aimfka9xncJ/5cl/9ORP13h+2aQh4cT400mebQzDkLg?=
 =?us-ascii?Q?d/2WIvKtENciCvBXIe/xsNwpzi8tLVY6qBybDY/IOiSlg3m05CfeYXveS9SB?=
 =?us-ascii?Q?06z1sKJo9aHsrXe7LF7n/FJABcm/Kp2NFz0+EiZcfbGUFEj0g5eSK1IQx4Z5?=
 =?us-ascii?Q?XYB8G5oDq6u8An2hFvBzpQ1Kxi3qJE21nGdRg8QEfm0i/8EtebI+gY6apuZ1?=
 =?us-ascii?Q?89Cm2BJMZJHYZrJcX9GwfgxcPmTViEpPjwODXzR1twlUNkM1LXTuUlVT8NvY?=
 =?us-ascii?Q?BbcILpPEEJ7hCWEARLAk6GMetaPU+XIZC+IIdtu8EaC+rWjizTZTUQwfke1I?=
 =?us-ascii?Q?7JcRtLfXAEFQYf33dAA81maOPLSGbXOQHkghTCvCrS46x4fQHQSpksOyhHsv?=
 =?us-ascii?Q?3yrhLMr2Qmd3jUWZIWSnbPEvoZslWB1qJv+p/mXckkcm5V2wWDSqxZk0oknH?=
 =?us-ascii?Q?lj3o+AE7H5NJRCWHpUoqqyAkuxJWGiGm7kAzNsNAi3wt6Z94mWDfK4cw6iOf?=
 =?us-ascii?Q?MuFCI4U61838m5RC/zsDbeH4NMhoImWfgJzSElpw90RoEvr7/vnh4pMdv8Vo?=
 =?us-ascii?Q?foEs13dTZNO+s/Q+qsu0FMacIVkIfxZEDgXFLwQGL+A6qm5JOOVkSVDSDo89?=
 =?us-ascii?Q?gH+zVTLlWsH+7bI7w5/Pnr5kLLXaowjWdZi1OAac?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f06807c0-687d-4e50-70f3-08db0dec8344
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2023 18:02:47.7236
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d96shAI2t4rdaM+ya2T0YcY+KC2jG8ugMzF7j59g43tIs6F8pbkw4Ky3eRtBjmtH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7493

The hwpt->devices list is locked by this, make it clearer.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommufd/device.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index a0c66f47a65ada..dcfaf6567420e0 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -186,6 +186,8 @@ static bool iommufd_hw_pagetable_has_group(struct iommufd_hw_pagetable *hwpt,
 {
 	struct iommufd_device *cur_dev;
 
+	lockdep_assert_held(&hwpt->devices_lock);
+
 	list_for_each_entry(cur_dev, &hwpt->devices, devices_item)
 		if (cur_dev->group == group)
 			return true;
-- 
2.39.1

