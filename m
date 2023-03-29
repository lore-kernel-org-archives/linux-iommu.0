Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2084.outbound.protection.outlook.com [40.107.92.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC1EAD30;
	Wed, 29 Mar 2023 23:40:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ba63dJTriLFSLQP/Ftt8FXSF5XfOxCZ/PM9gRF9S685Hj3qTgQ4XATX8ZrucyxeCrKPQyY4dLM5O59fQtQThr1zg0r70lCm3x8oii8z2pu1qBJx3vYclvU9Z3CunpnZ4xJHdpA11/yh0cP6NOa5I1yxx3w8tvMl8ffXXVZDfJedwrIb3Wmf7eoPzoD131n/UQyDM0OIJ5Oz1TLTKrG9eQ6HMv6AjoQQZf4bXChrXF4opRt4EkTQkSinFVqU2B8Qi0sJhZ4xlesN9SjH8BR+swd+zoWnmoyRH6mNfmNPpDUafg5dcOI0et2rnanQczHY84QdeU6lQAtHfy9v0xCCfLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ceiE3tuBqubRkLxcQVmexjgUXYHugIo4tyiS6VbHEaY=;
 b=inBsPljwjuXNcmwgcuZOD1AeM1vKAre/GJpyBptA9sxf+0n3LS+80dBgznDkz4jKnfYEjT3KnYeel4P0aVvu5sEK+rsoYk0Vo0O/bpFo673qKPZMy2qotBvNGrUJlnDtH1ZZMpbfXL37ktOPFkQlJJk31Ol4Lqz+z2/hsoY0fVwfmc8w31+4zh/kYlHATsybEeAcQNiJpdJHuKkJJQ5dWPt7j0V32rF9WL9qP6krCCMM4DBs91OQktdyWRisAZ5wKhdiVj2Hy8r3RrFByrq4ih1+PIqOta8N71JZfV3CW2B9FKjGXI3gusvCkzgSBvvmlbeT1fuCN/idkYlZgrbfLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ceiE3tuBqubRkLxcQVmexjgUXYHugIo4tyiS6VbHEaY=;
 b=KR5kT8+73rZjzYflBlSBRQwsONlzC2oSpwuOKccMES9BTVPp0W4OwRMpCfTYx4LJkQwjVdqKKCdBCYu5AIDdsHos5/hRwEpxzQbSGWNs1JB4WSkQN5JapL3rcN5jIdi17JOzpzJbXJ3JD40AJbDpMIQhIX3/rrQyHBcgkhtJnXseVUDESTFa7PUHZ4MLGcEuxm+ih/hvWJnENTVPunbEUCTNL/3VrVoxKgQHsed521A6MyWe7Lt4Tr1pIiNWg6t8QQD8aZ2ltWfFU37qREAKGdN3bBneiGIj6ChKg3zGB0cRGh7ZqorGoCOpztNhYwMxr0y3cX/TrbKH6pitcnpBlA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM6PR12MB4515.namprd12.prod.outlook.com (2603:10b6:5:2a1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.35; Wed, 29 Mar
 2023 23:40:39 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.037; Wed, 29 Mar 2023
 23:40:39 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	llvm@lists.linux.dev,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Tom Rix <trix@redhat.com>,
	Will Deacon <will@kernel.org>
Cc: Lu Baolu <baolu.lu@linux.intel.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: [PATCH v2 00/14] Consolidate the error handling around device attachment
Date: Wed, 29 Mar 2023 20:40:24 -0300
Message-Id: <0-v2-cd32667d2ba6+70bd1-iommu_err_unwind_jgg@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR03CA0012.namprd03.prod.outlook.com
 (2603:10b6:208:2d::25) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM6PR12MB4515:EE_
X-MS-Office365-Filtering-Correlation-Id: 33f282dd-4a0b-4406-f1d7-08db30af0090
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	phZtAsZDbOr1biRT9CUN4SPt5aMRjud93jv0sEtNrzILnq9d6Ec3psR9ryOfAQlYvZ3Uq7a8rB8YVFXWfOZVVvp8zSP5Hh/1ckmVtixITlLNxHQhzLDswwZpo1f+k3BuWqecfK8647/QA70II5phX26wJFixdiA5mLlECH+vTnuvwHCZ3bqhbag9YTVbJABwwCTorZgcBWdH3CoYa6JSP611+RValRE49udU390fLMR8oxmVg5HKTbOGa3k1Entb3cSBJNcwQx02lok5wO/Rsp4nVcMvQTLoa6F2j3BrcJ4P4f4AIlRX955ya/LW3OS0pvn/yh30wXuQIBq5YM3FcW2Tky7D0EoB5fhDJaJjUvUtvbvh9QG7VT3dn1SSvwvFtA2yFlFYGKDDvwdoRn0qwaLdPFu/WYsHW5nuiT1KocmhddIwSse79gpCohkx/B0N/6zG12aocs8tSqnnmHIacSsWFwpD7QKDjGh8oGwtJAy/bqOSfjUD6hPUh0jxoPmD0BjUgzjnWU3wmtoqhgjUmzHdej8z/ueH0C2Q0L/UZRHc2IeKv6IWwxr9eXd9d3XVuqrRQvx/+LsZvCCuOdrgiSWn04pQx66yro95w6lOfdRFPa8tEoRwAlQbg/JS0JCmx+p87dInEi9n2UJ64R2O1g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(346002)(366004)(376002)(136003)(451199021)(83380400001)(8676002)(4326008)(7416002)(36756003)(5660300002)(86362001)(41300700001)(8936002)(38100700002)(6486002)(966005)(6512007)(6506007)(26005)(6666004)(107886003)(316002)(478600001)(2906002)(2616005)(66946007)(54906003)(110136005)(66476007)(66556008)(186003)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tYFcK1VjYlunkcKBwvJw43PKMPVO+dF9tKrB6pHcpuZ7dPuNVsrZNMbDDdpb?=
 =?us-ascii?Q?r5ZswFGjByKNsEM4oSwnXICz9OBdpuEYwA73U4pwglAKSxRpxf4e6Hu9no/e?=
 =?us-ascii?Q?6qBKNk4HPx89+0wwMrWG0ahHszk38ttyRxcM4Bf7Uj3rWhJX2hpmO/n6m5Rm?=
 =?us-ascii?Q?/Fu2rE7PAPSh0opsqD1g903ZjjeF85HwpyxEx3k5N+IEyF2tnkx48peflLqu?=
 =?us-ascii?Q?Y6boVGxCNSOEKcgp62EI+xkHK6RNqiz8fCgeb+FiB94XHeCWlUrRZhegTycG?=
 =?us-ascii?Q?rrGTO9419GDDEwb9Owj9vXrhlB8nw7Gyb4UbXCh+UITzHf4z0M2QEut9UFG5?=
 =?us-ascii?Q?Bk7i1ZFUsKYJ1eg5X/LjZ96vhCXCZLlXhA3/L95xIS1qLgY0MCi+P+HhuyTy?=
 =?us-ascii?Q?jT9oCdKZgeHHVMoy7naywcTVoP89W8PNxC8BpT5bGTG3e8aNxqfUSZXxL/Sf?=
 =?us-ascii?Q?WyTgo0Emi19e6iCB43okn5z2rVUwgDNgK3crLdfduR+plHGDCcWpYNBPP+H/?=
 =?us-ascii?Q?R0qcIPVLjLpbzhzeTmloT8m3Hd6IzPXE0P3E7WLKfYDiGLOtZFivJ/Do5/Uu?=
 =?us-ascii?Q?OvbTiacP5miohrfWk1oCGlyw6mw4oJlQvzBz7+FCgPIeGjIxGTnOiTNAZXnv?=
 =?us-ascii?Q?UzSSeL8DO9G3RVGJQ8PtvdTAAmzCU5NNzMm81vwdk7vmzcnl8rb3DQVJDqz1?=
 =?us-ascii?Q?25EkKc35avTGXGkBxl59q5rAhbqijbOaY3+FOPRfwnFZuEok4dQT0utEfHOc?=
 =?us-ascii?Q?OYkAMVSTKlg14mTmWUgi2yfBLc+HFLRCCsQnejU1zeliQJQamph9eFpUjUp8?=
 =?us-ascii?Q?c6aYUBYtqzEN9FYecQoejVZcKuWg4/yznDAgmPzVeb2gbVBB5OD7gtYTLsJo?=
 =?us-ascii?Q?Y2GPjdLT7EaBiwCxto8tjgd3MqtKbWzS+nrMoR8efMZYxsISrrJmoLSPjWyo?=
 =?us-ascii?Q?D4VYNn3sl8UjH/4jLVx9OGczACicm5ReIBpnNh/p8jAA1jjaGg/fd2HBlJrs?=
 =?us-ascii?Q?tDi3ZrW/12JlDaUGcmZmmPasCx7Bx9cTmJsn40nOW4b1GLK7wgCFFQX+WSPF?=
 =?us-ascii?Q?kcyxGVDTV6G8WqJ6TTib+sfspu2I/ezPpsaTdSAp5O8tGONq59PhX8nAexxp?=
 =?us-ascii?Q?stSlWH5UWipFgTxSjF3hN/SZgGTi25kqojHPD5hAfb7qhvWwXfk+UI7D7wgG?=
 =?us-ascii?Q?QpjwrmS9OyhdurJkRkeTBH09NzYwzMWiw+kh2bvXVepd5XX7U0sZu8Q+hpFp?=
 =?us-ascii?Q?GX+C4ObJiaDKqC5CK0SykBWzE9o48C4Y1LmpHUbYYBv2eciJNKW5sDiX8Nch?=
 =?us-ascii?Q?JXhlj+O92VrTBczM1xuToldoGyRMv1El8SRfjNP4Py0IEtTyf7UnPEUNoNek?=
 =?us-ascii?Q?zomGpQHW+fLJtDhMp+pkQCAm84nMmJulKRznO+i8Pup/CXMvdtSPcTeZ32Nx?=
 =?us-ascii?Q?BFpkrdfjLejf+t981UlPHg5kZaO/APsBX/Q5jEHUxzZuO/2li76MseWza/0N?=
 =?us-ascii?Q?oUsqDNuss1kiCKwzrT36/LzJ1om7hrF7exp3F5Qj0G7SIkiqeEqCXAHk7VhD?=
 =?us-ascii?Q?IRTlyEmy8FRYjUSmsXBhHCbbk/MDq/e3vHnR1IUo?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33f282dd-4a0b-4406-f1d7-08db30af0090
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 23:40:39.1528
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1ShIjeHHZbwOzMctJn8jGW58dADv0fwpw7RRGjm/c84xWmvktnAlgCclwwCmJ5A/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4515

Device attachment has a bunch of different flows open coded in different
ways throughout the code.

One of the things that became apparently recently is that error handling
is important and we do need to consistently treat errors during attach and
have some strategy to unwind back to a safe state.

Implement a single algorithm for this in one function. It will call each
device's attach, if it fails it will try to go back to the prior domain or
as a contingency against a UAF crash try to go to a blocking domain.

As part of this we consolidate how the default domain is created and
attached as well into one place with a consistent flow.

The new worker functions are called __iommu_device_set_domain() and
__iommu_group_set_domain_internal(), each has sensible error handling
internally. At the end __iommu_group_set_domain_internal() is the only
function that stores to group->domain, and must be called to change this
value.

Some flags tell the intent of the caller, if the caller cannot accept a
failure, or if the caller is a first attach and wants to do the deferred
logic.

Several of the confusing workflows where we store things in group->domain
or group->default_domain before they are fully setup are removed.

This has a followup series that does a similar de-duplication to the probe
path:

https://github.com/jgunthorpe/linux/commits/iommu_err_unwind

v2:
 - New patch to remove iommu_group_device_count()
 - New patch to add a for_each helper: for_each_group_device()
 - Rebase on Joerg's tree
 - IOMMU_SET_DOMAIN_MUST_SUCCEED instead of true
 - Split patch to fix owned groups during first attach
 - Change iommu_create_device_direct_mappings to accept a domain not a
   group
 - Significantly revise the "iommu: Consolidate the default_domain setup to
   one function" patch to de-duplicate the domain type calculation logic
   too
 - New patch to clean the flow inside iommu_group_store_type()
v1: https://lore.kernel.org/r/0-v1-20507a7e6b7e+2d6-iommu_err_unwind_jgg@nvidia.com

Jason Gunthorpe (14):
  iommu: Replace iommu_group_device_count() with list_count_nodes()
  iommu: Add for_each_group_device()
  iommu: Make __iommu_group_set_domain() handle error unwind
  iommu: Use __iommu_group_set_domain() for __iommu_attach_group()
  iommu: Use __iommu_group_set_domain() in iommu_change_dev_def_domain()
  iommu: Replace __iommu_group_dma_first_attach() with set_domain
  iommu: Make iommu_group_do_dma_first_attach() simpler
  iommu: Make iommu_group_do_dma_first_attach() work with owned groups
  iommu: Fix iommu_probe_device() to attach the right domain
  iommu: Remove the assignment of group->domain during default domain
    alloc
  iommu: Consolidate the code to calculate the target default domain
    type
  iommu: Consolidate the default_domain setup to one function
  iommu: Remove __iommu_group_for_each_dev()
  iommu: Tidy the control flow in iommu_group_store_type()

 .clang-format         |   1 +
 drivers/iommu/iommu.c | 623 ++++++++++++++++++++----------------------
 2 files changed, 293 insertions(+), 331 deletions(-)


base-commit: 3578e36f238ef81a1967e849e0a3106c9dd37e68
-- 
2.40.0

