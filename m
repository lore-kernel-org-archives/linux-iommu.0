Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2080.outbound.protection.outlook.com [40.107.94.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A08A925
	for <iommu@lists.linux.dev>; Mon, 14 Aug 2023 23:24:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=crSmP3kFol+IRoSSKrI4fzAqfHxvhc8yrL+XRs/GUkKmgZPpWSyEm7bn2DxvOkKpPQqVqBSPxsfnNrVskvz8cCfj1nyVPL4Trx1Ms9w6gG/AY7yWjh6TNg8dpMD1H/qWvEYJ4u8JDgN4PLVLieY9RXnmtAU3b6ROjCxZ5OyieNAfL2Mq4SUa7PvpjOD7RsNtyPbV83ByHAyiwoKWFRux8nxBb5EO+9RblpSHqSXxBkrZWzoHf5hO7Y1qy1vOjBxBkfeP0dJbuprWXqJobHlEifc1EKzxyuNqZjlEAxKE3S7sNhElYrjUQN4S72lOvbveFbO1J9irdL2TCL/Lg6Ex9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HFXm6iWgZFSP0TcXxLyDPrwPNsw2TEqGlave5g4gStA=;
 b=TtnyG0MjtmvRcr/BDwmLX+8a0uoyWa36irXEENQzQHm3mvNR06VsqHNymd2H258KdSm66wddgG7h15oMt68eb5wpVu+Rp8mwigAG7RZpY4Yzr+IPbmXj5s3hN+HRP81+kSkjGpf6aBMM0xw2Fu3r92xDWiOSNzQmNRfOj5dtbN3UIMLKJx6e5VqtvjpXjWPsJRlVh0WHdquAuL6oR3ffF8OU5+PbL+dEXhI5MwkpoCZh2mBZVevLf65Ze8URIN4B5xZbq89ZaBNfdq1PCmEWBnDRW/k1x6Okl9xbo6l0K3rwkHdSDt2uXOMCKr7aqmXKwRWMSl11RVw5kv4ZQCcEVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HFXm6iWgZFSP0TcXxLyDPrwPNsw2TEqGlave5g4gStA=;
 b=HWUFEtzRFnepbxyGIx9Q3bK/8iXh6Z3tza/Z1QXiNx0CoSE+dEhtRl48NAbuS0M8e5jABrGAtFsfD6+tZ5i9YVpVqjTzXiByZcl+b8eu6+xIwBkNVJNo1R5/rkphPuaulRWjC8om2UZCTjQxQuEyO/TR4UiZCvRVyKu7MFOsszQDzFlgztwNdrI6cJy6wfMbWiBlUDYOfokukeFZvVlVoR2NPRO2cOZ82e+yHuFQS9exUoMpNkHHFVZxYyFKxQDd2NMB0o+vVJX9S8iSMwaQJ1NMxt8ndIglpgs0DmmCg8TIsh+/zcr0/T4tuZF7I/NWkuLv4pdBRrZv5tvZ5iqy5g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DS0PR12MB9448.namprd12.prod.outlook.com (2603:10b6:8:1bb::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Mon, 14 Aug
 2023 23:24:35 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6678.022; Mon, 14 Aug 2023
 23:24:35 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: iommu@lists.linux.dev
Cc: Kevin Tian <kevin.tian@intel.com>
Subject: [PATCH] iommufd: Remove iommufd_ref_to_users()
Date: Mon, 14 Aug 2023 20:24:34 -0300
Message-ID: <0-v1-abb31bedd888+c1-iommufd_ref_to_users_jgg@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH2PR14CA0032.namprd14.prod.outlook.com
 (2603:10b6:610:56::12) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DS0PR12MB9448:EE_
X-MS-Office365-Filtering-Correlation-Id: 962e5404-8291-4ddb-d587-08db9d1d9f57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	19nnRz0IcU6MGiQBPNPWixOLBw6WI1pg/xTB/n4bGb7G6D2Tlh+iCCA86Ub1rmHM3YuLC63xv4mcCAn6Wpeoctqo3WKEprUUpkyqFxUZ+rhLRExh+HrLNyvi4mhNCUNqWw3nfAMK7OdJuuVjHUdwX5mMa0wNzWnrnKWGHtctxloxK8WeSw/QA88Uga0KXaJpOGckmNhx92cjt0vPyS3g+Ec1Tm4OOpgKUFLsCf+aN3LEMymJq7Tk2fzU1nsYZXjnkxOuL2rMvEbiSdcN55GvkLyiUbP4oZYOiFsQ/zqpJlIcXqpo+w7gEnefZ4g/ok3cVyRBcFShwbMZSd2FJhGx7uqWvT8xXDkcuL57uKb+ewIEdMfO3TzxPlQeHdnb620GIFtZ0LZS8J2z/wEV9urcNZ7ApQkWrymWRVpTtxDGyHtKPGFt3GW477GYpyT/r0GIzfyUgJMD6epUIuJtw0iu0+FmotKXu0PBEtM0jh+AeoZB9T8s0FXnStlKJR1DCipZuzkWcXGSfKyMMJG3JImcDa+i5TWhDsP4StzkubRHsx8OGYL8xVDIZ9fuGPF0/L+hxiBEtAZu+gLYAfXoqA/UJ9B30asos+S4E4zIGEno3mY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(136003)(376002)(366004)(346002)(396003)(186006)(1800799006)(451199021)(478600001)(6486002)(6506007)(26005)(6512007)(2616005)(66946007)(8676002)(2906002)(6916009)(66556008)(5660300002)(66476007)(4326008)(8936002)(41300700001)(316002)(38100700002)(86362001)(83380400001)(36756003)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DHSf9AjzsSZN1jp4Apd7Ve44EMNjA+FeoG9rdmRwFf3qlAT3XgkB7OnKPSnj?=
 =?us-ascii?Q?ObmfG3ZDY5G0EeoLAo5JyciIBYfhwphvdGrl8rsk45bGE8nO1aWuR0Asvsfi?=
 =?us-ascii?Q?ITcbHtM7+A9ylxgmYuvprni4KjWtV3pMzfA+sIXXi948PzlIpNrl/3oym6mz?=
 =?us-ascii?Q?kb0eUyLOJYcpXul3A1kBL0nU/K4Bva+JZQ/CwCKYlWpAdl2/vxYqpr/k7jcm?=
 =?us-ascii?Q?DGwrw+ETMv0IV3wpaSu0mxkaABUA7d4ShUJ4OB51X58uEDoS5p2jrkHOdCxN?=
 =?us-ascii?Q?290R05oEz+dd4bL6q9iTw90eRQv94aMVfLMqZswceaMhAqci6nVhzv7yFj6V?=
 =?us-ascii?Q?YzHiWTONhKrp5fRjU7YKZ8ZHvbjJQVdIcBxIw8RWTrQDgi3+FK31dnfQif9U?=
 =?us-ascii?Q?D0KJNWU0zK58k/XOwzP9XGSIbDuLC5aG+Ksibbs0evQojqyHUxz/ODuw8219?=
 =?us-ascii?Q?9vGon/SYphDPt+RdBGJg3zFrI5QF9a66ptvbrNiy527JXtPwkk2HVpAMyjNu?=
 =?us-ascii?Q?d46yo/viUvPux9dAbDcD+K0zr4brskidWVCrmIQMh9oScMRzQjbCQk44h1If?=
 =?us-ascii?Q?xDUEWMHJhF5UNdYQP8OHTDYXl0jAIS7+xNgPkc+HofgvSU64LMSfBn5MBkfP?=
 =?us-ascii?Q?q2Bic4uvR8RVCDZQa4VQgxm78y8jlYNtWO3UBLGvvQc2E8qH3pHBoi3IMU0K?=
 =?us-ascii?Q?gOP+ofEi9e5VizzxIq5vvcldl8DyLBt53SEuciKNw8uKKMk1lhmwqw2SApqI?=
 =?us-ascii?Q?4oIuDTv8kr3oTBE1WJWBkqqHxlv2rbPufO+VaNtAMsVqJYytjhH+mpFMMil0?=
 =?us-ascii?Q?Re0cw3ksPMTu5UbAltEeOcwTOo2AuSL+1HZbDfN8AfGHyRsPAorVliwlPfLi?=
 =?us-ascii?Q?6QMKAccpjYwsfYtzm5U90RTDY8LPdh4o0gPvjJVaLDmIhjBeJJeMoPsx44vZ?=
 =?us-ascii?Q?skkAS68U5XaP/iBPX8Ta7lefZ7VYh/0d0El/RwMUa/Wd+qRCQqNB1yUVtPLh?=
 =?us-ascii?Q?5REUAi3YcCmkeTVjzDyJNtNDgyHS6b3GaVE3A4WUXeFnku2XfDCzATzh10dA?=
 =?us-ascii?Q?1CqiIXcF6fOFMs/Xs09scTTwvYuYy7Uxac8Nvb3rcxPW46bwrvtKJiPJXk0g?=
 =?us-ascii?Q?9VeiyH5Xn7TzVrN/3SmB1kTBQL3m6KS2G5eKcL7rHo5LIBbA/n2KBl1EoLQQ?=
 =?us-ascii?Q?i1A4VRPI0XuW12X5hv5LU0UMDTgu4X5uUcjG6ZAW7byNANpXtSMNYZP4ZbWU?=
 =?us-ascii?Q?gXu18M+MxHe1z700L3c4lgZvpqssF9qidJ4EkMcSRjrvfhJHU+SByO7Yq6E7?=
 =?us-ascii?Q?dxYNXuMxekRowftvZLfF51alX264CSIJhITz6x+2KZ1rNG/KcyZlJx/XpwpS?=
 =?us-ascii?Q?HArxAooTSr2kmPcwfdWRND3OuX1rc7CfPtzejq11WxNSXgZDXwUZ0Am4GU49?=
 =?us-ascii?Q?ZyuMwN8cpCvr4nNV8JGHdtl4nl+m58yxkRHIOj5BBjEqp+7hc4+cespIdqLR?=
 =?us-ascii?Q?NduTFFAVJ+8mOdSnIqR/7ZUCzyBFZe1o2gUGtRiinTYAwqEBrThhwvvhyvj7?=
 =?us-ascii?Q?qg8RgGzvZsWat8WlFpzWhKx2c4PFvdBL/o8ugpuQ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 962e5404-8291-4ddb-d587-08db9d1d9f57
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2023 23:24:35.7371
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: prx6dvAdvzCuYfydgTwiCbgStd98WyPY9A6/AfVqZhBOBWkWpIIUROVMUlZu992d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9448

This no longer has any callers, remove the function

Kevin noticed that after commit 99f98a7c0d69 ("iommufd: IOMMUFD_DESTROY
should not increase the refcount") there was only one other user and it
turns out the rework in commit 9227da7816dd ("iommufd: Add
iommufd_access_change_ioas(_id) helpers") got rid of the last one.

Suggested-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommufd/iommufd_private.h | 23 -----------------------
 1 file changed, 23 deletions(-)

This is possible once the rc branch is merged up with iommufd to join the two
commits.

diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 15596a08a0571e..5a45b8ba2e26cb 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -149,29 +149,6 @@ static inline void iommufd_put_object(struct iommufd_object *obj)
 	up_read(&obj->destroy_rwsem);
 }
 
-/**
- * iommufd_ref_to_users() - Switch from destroy_rwsem to users refcount
- *        protection
- * @obj - Object to release
- *
- * Objects have two refcount protections (destroy_rwsem and the refcount_t
- * users). Holding either of these will prevent the object from being destroyed.
- *
- * Depending on the use case, one protection or the other is appropriate.  In
- * most cases references are being protected by the destroy_rwsem. This allows
- * orderly destruction of the object because iommufd_object_destroy_user() will
- * wait for it to become unlocked. However, as a rwsem, it cannot be held across
- * a system call return. So cases that have longer term needs must switch
- * to the weaker users refcount_t.
- *
- * With users protection iommufd_object_destroy_user() will return false,
- * refusing to destroy the object, causing -EBUSY to userspace.
- */
-static inline void iommufd_ref_to_users(struct iommufd_object *obj)
-{
-	up_read(&obj->destroy_rwsem);
-	/* iommufd_lock_obj() obtains users as well */
-}
 void iommufd_object_abort(struct iommufd_ctx *ictx, struct iommufd_object *obj);
 void iommufd_object_abort_and_destroy(struct iommufd_ctx *ictx,
 				      struct iommufd_object *obj);

base-commit: 83f968d8ba18e550acaef6921bf64cffe672df82
-- 
2.41.0

