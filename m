Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2074.outbound.protection.outlook.com [40.107.244.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D98D8BA58
	for <iommu@lists.linux.dev>; Mon, 26 Jun 2023 15:13:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NNmnh2wSCDyt52yVIvPXeE3toHUWw/O/N5ZZjcC3MUtjOR4cQgW7TlMV3D01CtDOSUTEd9m9DIctf8hg3mko3VDbc6eAPrBcBjHKtb5bPi/pm34HJrVBd+z9JXnPwLTDiXTVjJBXEL4wfU3pFTET3aizMPe4M/gUT5kAfa97I1yNSzjRQ1kSxgwNJAnmRZBVLbSCmKoudd0bN1GWdCaBsN1ydntbbfinhW3PsUwSDEn4So32Y/0aTs3dvEFkeB1iv+fyHpbPdXfUcv9Gl5x7om0aFm9Lv6jVBjJ0CiE2phQ+nQhCcoo8bFNccvEkITII2agXGbF8VuGd/xaKFBdV8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mAhQu/yNSMIYgV3rteVd9psFzFelzEUTfdi0/rfd8hI=;
 b=D5ExBx93f+M8Dq9aMo1bcuB19t7ln9KxRqW3EBdlyWph1TbnJJMnRmIpFGPhT1tBzX/22nwqceWP0EV+c9/JnVfSbljEIfkF9aj6ufFnyrQb/bONrYMIkdEQZvNZMYFPOmg/1psqlDYVBUbcpxoo9gLa+1F6T+/JvMgrUVX2cN0hHrzf9sarlYcxWuxZstsAd5n5afbu0jpE2ybtAaMaubqUR0HOBKi/jq9X0SV0e3/jComnyxa0aMe2dYG5G5xRjiUok1sXCs3CbYDU45PL5ct4qBfSoP6UmZksvt2r6dNC2l0z4Kprnufhmcf/9sa2E6yPKjjg3xOo7wlwnCLFpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mAhQu/yNSMIYgV3rteVd9psFzFelzEUTfdi0/rfd8hI=;
 b=eqM6ros0iWZvrQSodNCXunhCMCrbUlBWgCYzBxEJ/kzoAAnxgCkzgK3gk8y7pp2iMR2ArqViRvwEUQLFakCRBxGkkiLoKKj2BI7X8ky9cc3pDqdZw1U9qfe4asDrbCoorecw5dwJrZEz6rso1EECX6rf4xm3Y3q2OSFqCpCcAJazYssuFgF/V2pG3WP2d+R/NRA6mNFIB6q9fX/VcAMDL6NE7nCyUC3AxICKbwesZApb3JcvrSic0NmctxZuhzdyLAVKTHHpCJJAz/znDu+U2LJYIVUkmM9aOBLTdBIytmzowC9s1ykHo8yBQuFH+qjKqq98f6JiDh3gaOkkty0bBw==
Received: from MN0PR12MB6102.namprd12.prod.outlook.com (2603:10b6:208:3ca::8)
 by DS0PR12MB7926.namprd12.prod.outlook.com (2603:10b6:8:14a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Mon, 26 Jun
 2023 15:13:14 +0000
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MN0PR12MB6102.namprd12.prod.outlook.com (2603:10b6:208:3ca::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Mon, 26 Jun
 2023 15:13:13 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%7]) with mapi id 15.20.6521.024; Mon, 26 Jun 2023
 15:13:13 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Lu Baolu <baolu.lu@linux.intel.com>,
	Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Joerg Roedel <jroedel@suse.de>,
	Kevin Tian <kevin.tian@intel.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH rc] iommu: Fix crash during syfs iommu_groups/N/type
Date: Mon, 26 Jun 2023 12:13:11 -0300
Message-Id: <0-v1-5bd8cc969d9e+1f1-iommu_set_def_fix_jgg@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR02CA0028.namprd02.prod.outlook.com
 (2603:10b6:208:fc::41) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic:
	LV2PR12MB5869:EE_|MN0PR12MB6102:EE_|DS0PR12MB7926:EE_
X-MS-Office365-Filtering-Correlation-Id: c3fe183d-78a8-495c-7778-08db7657dbcd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	az2a4VfX+eVzCYiw5J3nwXff9npQyaZ/VhHGLbFWJ9aA53Ng8iW5Fqa/he43Lw4hoA5yqG95eaLjYfYW+7dcSOaXd4d7LgmqYCqe23sja7FDzRnERmZLApo59TsG2QMaygIsXVV20C5LyNXqZ3yViUMMmen8ts10S//R0pZksO4KQxwHV8yBN++osFoW3Tnl1QsulG912W0ws2bQUUMzn4D8XTadOGhIaIl9wP/eBiah6oebFIQJchqGSfAv9kZSXv+qlJxu5MLXpyb5mJipC731JsFjIWmM3Ci52XTgXQ/mM+eJeYFSGgXBq7upFJiLuUChij/xCuHyHMePPdo9gqpRZyVGOVp4iH+ueA1eeMaZz3L6L7slf5tKHNHSrjLCaN7LGzyZKlUn/D8D5rGRLsy53ztYSt1Rl/eTvgOvhxjs7LePNEzL14mLiO4FFt2tc5bSM3gV2PH9uRSPAs8u2WbLh+/oXfos1qhDPGHPcZs02JkpDWQ6V2oXLiL/qE5EC6amHfQEly2FsPh0AYTPnf9G7O7WIcmHS+5LAG/QxtBDq0a5DKSsgYkbEhhe3GbHZdwUpjtLeDvIbipTpoKkuZdleg+hzyxtjA8jR/A87cw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6102.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(346002)(366004)(396003)(136003)(451199021)(2616005)(83380400001)(6486002)(54906003)(110136005)(26005)(6512007)(6506007)(186003)(2906002)(478600001)(5660300002)(7416002)(36756003)(38100700002)(66946007)(4326008)(316002)(8936002)(8676002)(41300700001)(86362001)(66556008)(66476007)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2i69S2lH0ni5BfqzEdToy9x9/sMerWTsAa5LjtaXj3TdTjNhGcMdu/GJXFZF?=
 =?us-ascii?Q?lXls2h5Sk/Xme9bdQY6NYpdGhJBZj5SFI9lD2fRbiBV8qV0+YI8T0dOyeQ6M?=
 =?us-ascii?Q?4hsL4sKhjSm7JpQWYdirS0HV/9hsCF5sCD/ECXzy5KJYocFdnSqScSeCjnfv?=
 =?us-ascii?Q?T506dnVgZ4hJLgvasQ/7HHKNAcwMgcOp7PUBghjmY8TzGtSbpDxXUBBpHhMY?=
 =?us-ascii?Q?HcJtxgL2fdDrdyMaiA7a12EvN3ckYRkhnepSCNNKX3UnukOVWbYvKrHnONx7?=
 =?us-ascii?Q?3wIZ7Jn3LzbxSp1Im43LgTUGxiomGfJYMDl9wnuuZXI2/CO9qzDCzfu3RJhN?=
 =?us-ascii?Q?sLg2oHAN4MO75+r2e0Oq/neZnn4DblfU/r1he9n4W0D1ecIA5pCo1pOxaS7Z?=
 =?us-ascii?Q?gmTv1UAlMQcNCf+PEjX0sutxc4r1mtXdVvVzoZcHizGGlMOChQ2v2hMGA+48?=
 =?us-ascii?Q?PvQctuADN2kTzR0np2bX6xjOuEaXMNELMzACLExuhHnRq/T016PeQMqUrV2q?=
 =?us-ascii?Q?h8WAJ3cWQgiC+2WwG+q/HHy70CPfKxZO2UHavGef63mbgpD8N/tRyFTgb910?=
 =?us-ascii?Q?RH/Zb/T6vAPUVo8cIcTH75zu4yDWEr2h0T7CpkgsMcPJSXxMlUXkomoWe88u?=
 =?us-ascii?Q?adFeA11FHSqfV66BAuMiKb+h9mXC6aMegvtuV2yasHWAbYp695j8dVqcGQPe?=
 =?us-ascii?Q?MK+qDHq7UvIPjz4p7tI+qLX/2akoAeLEkXK8Rsv9Gp79CkaVvlN9HJPPT4oS?=
 =?us-ascii?Q?9cOzte58l9iaFAJEsxj0PLvn65Mi98k/ofupyPTCBbqee2rfiMpGuYc1yvdk?=
 =?us-ascii?Q?bg81cRHtfqUBqWaz7LmdcIjXJup/X/9DeY5+/t8ddeM/iTTInFRmbaSJbwyU?=
 =?us-ascii?Q?wKODAQNt+6ORjbylW3MEi9pV376fb8me6kUn5rx+4JS+GnePd/GKKUD0NIua?=
 =?us-ascii?Q?bfpT+XWm+zm6dV0IL99sps/8brcjmSsXJThkXUKnIW3agoK6Ox4ktQdezYaC?=
 =?us-ascii?Q?utYG+WTpP1U7qsQL3bmezN5ZeTnPI4cfMYyPE04VUfB+cM7ocBLfx6pwrbJ/?=
 =?us-ascii?Q?EgQgjyqTIqY9aKeaI2XzAEO4ru++ONtK6Y102HbmMtrJsl6bttj7sJrmFAnk?=
 =?us-ascii?Q?OQZGHriY0jyxjS5ojVnY3HitocPcy47uGBhsQ2iw5RmW2EEg1qXJ01mrV9BS?=
 =?us-ascii?Q?aJORrx4Dzqsw14KmLfhFmZ1PTmmbIjYD7X+9tRTD72n/dBurkdqFwthjs8Oj?=
 =?us-ascii?Q?ssuFC4GYk9gSUIhCPkDYbGrpxaCPu0i9AjtU72A57bCx1jkNZLb57phODMMY?=
 =?us-ascii?Q?EjYsh25rcnQoeExgEQA0NNVDrVlE+3/CzZVngR7S8t0R0hp9ERV2O6btOgqe?=
 =?us-ascii?Q?+xjg56w4FVFov/1UfCws9azXUav0vs5lsw4sEcXKpLK7oVYT/NZ3/V56+scw?=
 =?us-ascii?Q?vmB3emT2CvYJoSNvPXypxw4eIDBAXc2w3PUfzfVyqrC0E633WsMLg5JCvBT1?=
 =?us-ascii?Q?jdh71IfBlidqaSelUSApkZbBs2Ns5a9xPN3bvLW8pYYSe8nx4EoGVnk9gd+G?=
 =?us-ascii?Q?Sa+YzTX9PjPyZnTkapdWwzaJcZgfZN5MK+mgnM+5?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3fe183d-78a8-495c-7778-08db7657dbcd
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2023 15:13:13.1885
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FMzmsl9fV4CgTBU9JKLY3G5lDKfBOQ3b0ScnsJvFdzQ/QZkOWu7izjOOVEX7WgzF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7926

The err_restore_domain flow was accidently inserted into the success path
in commit 1000dccd5d13 ("iommu: Allow IOMMU_RESV_DIRECT to work on
ARM"). It should only happen if iommu_create_device_direct_mappings()
fails. This caused the domains the be wrongly changed and freed whenever
the sysfs is used, resulting in an oops:

  BUG: kernel NULL pointer dereference, address: 0000000000000000
  #PF: supervisor read access in kernel mode
  #PF: error_code(0x0000) - not-present page
  PGD 0 P4D 0
  Oops: 0000 [#1] PREEMPT SMP NOPTI
  CPU: 1 PID: 3417 Comm: avocado Not tainted 6.4.0-rc4-next-20230602 #3
  Hardware name: Dell Inc. PowerEdge R6515/07PXPY, BIOS 2.3.6 07/06/2021
  RIP: 0010:__iommu_attach_device+0xc/0xa0
  Code: c0 c3 cc cc cc cc 48 89 f0 c3 cc cc cc cc 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 0f 1f 44 00 00 41 54 55 48 8b 47 08 <48> 8b 00 48 85 c0 74 74 48 89 f5 e8 64 12 49 00 41 89 c4 85 c0 74
  RSP: 0018:ffffabae0220bd48 EFLAGS: 00010246
  RAX: 0000000000000000 RBX: ffff9ac04f70e410 RCX: 0000000000000001
  RDX: ffff9ac044db20c0 RSI: ffff9ac044fa50d0 RDI: ffff9ac04f70e410
  RBP: ffff9ac044fa50d0 R08: 1000000100209001 R09: 00000000000002dc
  R10: 0000000000000000 R11: 0000000000000000 R12: ffff9ac043d54700
  R13: ffff9ac043d54700 R14: 0000000000000001 R15: 0000000000000001
  FS:  00007f02e30ae000(0000) GS:ffff9afeb2440000(0000) knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: 0000000000000000 CR3: 000000012afca006 CR4: 0000000000770ee0
  PKRU: 55555554
  Call Trace:
   <TASK>
   ? __die+0x24/0x70
   ? page_fault_oops+0x82/0x150
   ? __iommu_queue_command_sync+0x80/0xc0
   ? exc_page_fault+0x69/0x150
   ? asm_exc_page_fault+0x26/0x30
   ? __iommu_attach_device+0xc/0xa0
   ? __iommu_attach_device+0x1c/0xa0
   __iommu_device_set_domain+0x42/0x80
   __iommu_group_set_domain_internal+0x5d/0x160
   iommu_setup_default_domain+0x318/0x400
   iommu_group_store_type+0xb1/0x200
   kernfs_fop_write_iter+0x12f/0x1c0
   vfs_write+0x2a2/0x3b0
   ksys_write+0x63/0xe0
   do_syscall_64+0x3f/0x90
   entry_SYSCALL_64_after_hwframe+0x6e/0xd8
  RIP: 0033:0x7f02e2f14a6f

Reorganize the error flow so that the success branch and error branches
are clearer.

Cc: <stable@vger.kernel.org>
Fixes: 1000dccd5d13 ("iommu: Allow IOMMU_RESV_DIRECT to work on ARM")
Reported-by: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
Tested-by: Vasant Hegde <vasant.hegde@amd.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommu.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 9e0228ef612b85..36d64662cb21ae 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2891,14 +2891,11 @@ static int iommu_setup_default_domain(struct iommu_group *group,
 		ret = __iommu_group_set_domain_internal(
 			group, dom, IOMMU_SET_DOMAIN_MUST_SUCCEED);
 		if (WARN_ON(ret))
-			goto out_free;
+			goto out_free_old;
 	} else {
 		ret = __iommu_group_set_domain(group, dom);
-		if (ret) {
-			iommu_domain_free(dom);
-			group->default_domain = old_dom;
-			return ret;
-		}
+		if (ret)
+			goto err_restore_def_domain;
 	}
 
 	/*
@@ -2911,21 +2908,25 @@ static int iommu_setup_default_domain(struct iommu_group *group,
 		for_each_group_device(group, gdev) {
 			ret = iommu_create_device_direct_mappings(dom, gdev->dev);
 			if (ret)
-				goto err_restore;
+				goto err_restore_domain;
 		}
 	}
 
-err_restore:
-	if (old_dom) {
-		__iommu_group_set_domain_internal(
-			group, old_dom, IOMMU_SET_DOMAIN_MUST_SUCCEED);
-		iommu_domain_free(dom);
-		old_dom = NULL;
-	}
-out_free:
+out_free_old:
 	if (old_dom)
 		iommu_domain_free(old_dom);
 	return ret;
+
+err_restore_domain:
+	if (old_dom)
+		__iommu_group_set_domain_internal(
+			group, old_dom, IOMMU_SET_DOMAIN_MUST_SUCCEED);
+err_restore_def_domain:
+	if (old_dom) {
+		iommu_domain_free(dom);
+		group->default_domain = old_dom;
+	}
+	return ret;
 }
 
 /*

base-commit: 8553205b97bad79174137f3fe832fb328947e067
-- 
2.40.1

