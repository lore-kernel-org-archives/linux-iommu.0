Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2049.outbound.protection.outlook.com [40.107.243.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1D6AD29
	for <iommu@lists.linux.dev>; Mon, 13 Feb 2023 18:02:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UKWgKQ7KOBoXfsh1NulRchko3oWG3ZnwKz0/o4jEO3nMjGPhULkhH71SkheHjb2eKgcHXsJHhBD6gqqq9cuKRA/SM2byNxXKzwcmDQhxVKM+yxNwgWj88keSqfMlRcOK3gsWBEXHo46EImiNFPrCeyk2Ayjz6B7REKWUAf22UCT2jgsvtYiqKD4y1+8JvCJE6a8Y5zv5RLjH+S4Oqx51MyuzeDFiReQAPAz8yMqDx88ft17Zxm8ybBBCBEj9GvIqp1ZDVvndE08yoPzOO5FUvldyZ1s7yhwDaOmLbEFFoe6PErwLyXNVYmP2YlLGT/7pZ1aL8qJCO/AeUe+emp6vGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zh1GDm2zN7pPvvkDAhJRFWgamhAugTOqc/KQg/qAywU=;
 b=TEqILXyWBSmOri3VneSnlY+IiXnaJBlVWtCo8pxKCBw/pYT85uKP+Mv/26ABhPUrEwNV32fkAjtzg6CVFN/WtwD2S3zZexhpA8beds7w0CkwyYhQonI+ef9OmFybVmiWjACJ+zgk+NOxJtgVPlewmMks2Om0LVg+3dhQbLwtA2AEt6hLI8RGMZql9HJjIW5GBfu7BkXPtSPDm8dd29EWWqTzJmvCNWppxNtSjA8wL/OT1OTxNyTouipyagcyT8+fmw+YZvF6397fKYsjFjuleKWOw2siWr/IW5r36VzmPzOZ3zR5dX3ROOZM9DES3ln70AeLF7+AcwbgXQeiumWa1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zh1GDm2zN7pPvvkDAhJRFWgamhAugTOqc/KQg/qAywU=;
 b=m9GKiVsML9yUVDMVKBCErM63Hmaf8SPr3ztSEqYlpi0VSlisI7hUa2wpI6/iTnsrjcYyscnx7E2Rg+2pxiWFZr2cANpVM+cZk67Pk9/8gW87t945TvhNAHqwUbOkhKYYdrbqRBjAD7jcXAOTiJc1jKOt2KC/HRIjCfGaqi9Zdsr9LUz0TxrZAx+W+qtNmZYHW/Y7YH2ql3aQOX8WQ16TLIkI7x91ol7Z2GpWWnb9ZNZF08sBB2HyRzOiNL46TPQkqwp6HIlrsYLN3qH3tuOIgMCgedC2/UJa07GT6XhV7ORtNLIrebss49q8BOupREQ91rYxAdws5h2uaof/hnGA2g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA0PR12MB7676.namprd12.prod.outlook.com (2603:10b6:208:432::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.23; Mon, 13 Feb
 2023 18:02:48 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%6]) with mapi id 15.20.6086.023; Mon, 13 Feb 2023
 18:02:47 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: iommu@lists.linux.dev,
	Kevin Tian <kevin.tian@intel.com>
Cc: Lixiao Yang <lixiao.yang@intel.com>,
	Matthew Rosato <mjrosato@linux.ibm.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH 3/4] iommufd: Add iommufd_lock_obj() around the auto-domains hwpts
Date: Mon, 13 Feb 2023 14:02:44 -0400
Message-Id: <3-v1-4336b5cb2fe4+1d7-iommufd_hwpt_jgg@nvidia.com>
In-Reply-To: <0-v1-4336b5cb2fe4+1d7-iommufd_hwpt_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR18CA0026.namprd18.prod.outlook.com
 (2603:10b6:208:23c::31) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA0PR12MB7676:EE_
X-MS-Office365-Filtering-Correlation-Id: 6dc8a84d-e83c-4b91-70f3-08db0dec8344
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	MFKQDltRUNKK/M6yUISYJMiwMAKWGDJkAGtlWH3gmChLPK9bDluqg1XnAbKcLrLZB7n9xNgnEdIbDLuVQVGjuE26N5dkDtCnXsfmslffPVQYLE1QNIWWEbB5qqvzrBltUlkOVFZ8W/Ye47NeXj0qkjDIPPNEwcRx3OW91QlMDIT24EnGfkfsxcVljULRvGbL4UI2XYyU4NendpC0kI3h6fpj5VKalhwiJFh5/94Y6sYKAwpdGoR3NbCDVtzVrfJ8sWliJAG5T9mHXsoq6M9g97NFcri0XsJl+yRFiorLVCpg+GnExcr6MId+hiI68QRFNkRgGh6I5GhDBY00PxkO4NQUgZy29bOuUdhb2a062xMTvergX+TSNtkUylw1b68rvnNISdXL4Dm20zCflY5t9M7EC5N0/b8T4ZmLphR7pmPG615NURn1/zJNXkEne+2TDASkykS4ZIlgqUUYTmoqLb0XQLWFb1k+EJ8UGbGM7LjGV42YobmzXpdY3Mlv7SDINwoPohEjUH4YUF+17+fFhv868PQgUy1M2dRfkhredAYA0qVpabX9AlC9LsT7IN/FC5MsDqJ6aAy665R3sUET1pZEKV0QhvEM/h0hf0sJY/DDGgNCX4vveYpB1uoGpTkgIv0AhFc3Ycwn9iwwmLleIlxh9GtYSvGtBgfAlia10p/U7MQ7mWdvgxwSv/KF1oiCSvxlX7uVkgW+t2KrrYPx9g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(376002)(366004)(39860400002)(396003)(346002)(451199018)(38100700002)(86362001)(41300700001)(36756003)(4326008)(66556008)(66476007)(8676002)(66946007)(54906003)(316002)(6916009)(8936002)(5660300002)(2906002)(2616005)(83380400001)(6486002)(478600001)(6512007)(186003)(6506007)(26005)(6666004)(4216001)(17423001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TzkkKRszbhvwrU8Tsd733OeVgqfLBWpXNtUK7+s2FOFUr/t2ACk0mRXg5PfN?=
 =?us-ascii?Q?WoPgKi2CYaxZ3PiGL/dBFZj2Mi2YypSN16Qw5yA6G1qYvMIbinlxNtIrNWst?=
 =?us-ascii?Q?xPCQk8O+EUhswP4JQjqK5b7v1OSb4MP34sk7KMNHTjeKjeqRuRBNvIpdBp1M?=
 =?us-ascii?Q?4KUjftOLjy9kuyQxf311CkSoaaZgZB+pJqyVzoOSw6kwMRAeaK6MUCx4vhph?=
 =?us-ascii?Q?QzQ82x5mGYusE/HJs+OvsDfcpCeFjBYraP4JSNOKh9C6nL8lhTEIILnGUd7b?=
 =?us-ascii?Q?QqI9R9ykB4RU7nHvFc/baRJGlE4wV5L41Nqf2ga7wwrBSm7/yxJtwgI6Wj/C?=
 =?us-ascii?Q?bZHcEyS5h6WC2KYEgA+ciO8Bz93l5OvO7K6APDdInSGlP/OopC3m0fXEp/D2?=
 =?us-ascii?Q?EXdUsiuxJT5YsYNjKti0NX0rphAmUlEsR++6K1193/h7E693qn2T5AHN4FZf?=
 =?us-ascii?Q?I/q5VcH9ZhCtWRTxwuwhUQgzutc9xBVHnyXdUO55zmkiDQ7FEXZICyiYNDJL?=
 =?us-ascii?Q?RbExeXzBzNqG9Bnc4TCEDuYnyYqKQZnNIN6XC8qebG3yoMXWp6M1mU2g8BH2?=
 =?us-ascii?Q?TT6aKoKWWn/QkZ0v0QTfNCCYKurMigL7sM7yeYJ5uzuVmvfXiXZg2xO+FRww?=
 =?us-ascii?Q?xRNPnNtm64uiRDBy+Enu0nUwjDiQwZ5hdw+hmc79nvEea+8JWg90zLooUO4U?=
 =?us-ascii?Q?javqerEVL9mLw+vrLeeGbZjBoYmHI887FNGdqaZX/vI7abuYzGuRdLi/j1PQ?=
 =?us-ascii?Q?e1FxO7yFudGMeTSLCwtcN/15A9NX6Gfj6O5kAxIV10CoMye/yYZ/xFm5I2LD?=
 =?us-ascii?Q?J3VeE53ENM5ZNZ8iS6IoWpDvOWshfZ4+VFtQ081mHcKpJNQXrt/074RlLzRo?=
 =?us-ascii?Q?Ij1X05gnFiaTMATSYTPmiD19s0woUgWpSi/Ck/c51j+TjoczQVKJcKkoMmCI?=
 =?us-ascii?Q?Swft+GeuarR6JUFcutQFUi4UQ5FP0dO0pi8vrMVPA5ZuPxQPf6GgmNrD79GV?=
 =?us-ascii?Q?2G7tINOE1b35k0OEZCzly3p4jUl7De0LcC9Yg60KhnHOHQbzfui6LAG6M0s9?=
 =?us-ascii?Q?PSjD7lgJ59qpOK8CN8hpkFSHpfRN1kHTGsalVig0fX77dcLmEVTMDYrf82kW?=
 =?us-ascii?Q?Fbt48rCdDxtVYMJ6ljvsqNx74MnL+gnKNn5TwuctkueIlbXyWCoz4crFyvEW?=
 =?us-ascii?Q?K2Tcimf5Fb7UsXNTHiX/ARMTo3UPgA6pNDbRcZOa8B5LEEZhCLRsCP7+1U7h?=
 =?us-ascii?Q?cIX8WUvJxkUz9Cqy91mQo3khLUtj8vHNC/8KCqOBIdC54BI5Iexxu5izm4eP?=
 =?us-ascii?Q?XtZwYcVUxyeq2LZmVCt/fusgonHy9KhM0Bu2dspR+m+EK5DN0OJ7oHDGs2bi?=
 =?us-ascii?Q?cD8mgmgw67hFgLteJ0Gt8glpE4UEuBEGADL/rC95Lvx6VKbTM6HPzhSylre1?=
 =?us-ascii?Q?2PZMJh48Fr8N1FP6gj0xXVk7q+WeLUrLG7BYFRMIW2XoFUlu8VY4d71g3Jzm?=
 =?us-ascii?Q?3x3qh8K+jLGULBZTXHaMJx1J6uCA1RW5JeyFBylvB6JuUtVllgb3pQCcnmnn?=
 =?us-ascii?Q?jpU2ECAU82n2tUZf9g8E6I/6WlFez0lzQO47yXge?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dc8a84d-e83c-4b91-70f3-08db0dec8344
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2023 18:02:47.6143
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q1Rb29nQ2EchM1y7r1uTHjY0SplgbRIXBKO04HRZw9GUCALhrWEWw3atyio4aBwN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7676

A later patch will require this locking - currently under the ioas mutex
the hwpt can not have a 0 reference and be on the list.

Optimize this a bit more by having iommufd_device_do_attach() consume the
reference that most of the callers already have.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommufd/device.c | 31 +++++++++++++++++++++++--------
 1 file changed, 23 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index dcfaf6567420e0..7b687d002c5c81 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -194,6 +194,7 @@ static bool iommufd_hw_pagetable_has_group(struct iommufd_hw_pagetable *hwpt,
 	return false;
 }
 
+/* On success this consumes a hwpt reference from the caller */
 static int iommufd_device_do_attach(struct iommufd_device *idev,
 				    struct iommufd_hw_pagetable *hwpt)
 {
@@ -247,7 +248,7 @@ static int iommufd_device_do_attach(struct iommufd_device *idev,
 	}
 
 	idev->hwpt = hwpt;
-	refcount_inc(&hwpt->obj.users);
+	/* The HWPT reference from the caller is moved to this list */
 	list_add(&idev->devices_item, &hwpt->devices);
 	mutex_unlock(&hwpt->devices_lock);
 	return 0;
@@ -282,7 +283,15 @@ static int iommufd_device_auto_get_domain(struct iommufd_device *idev,
 		if (!hwpt->auto_domain)
 			continue;
 
+		if (!iommufd_lock_obj(&hwpt->obj))
+			continue;
 		rc = iommufd_device_do_attach(idev, hwpt);
+		if (rc) {
+			iommufd_put_object(&hwpt->obj);
+		} else {
+			/* Our reference was passed into iommufd_device_do_attach() */
+			iommufd_ref_to_users(&hwpt->obj);
+		}
 
 		/*
 		 * -EINVAL means the domain is incompatible with the device.
@@ -301,9 +310,13 @@ static int iommufd_device_auto_get_domain(struct iommufd_device *idev,
 	}
 	hwpt->auto_domain = true;
 
+	refcount_inc(&hwpt->obj.users);
 	rc = iommufd_device_do_attach(idev, hwpt);
-	if (rc)
+	if (rc) {
+		refcount_dec(&hwpt->obj.users);
 		goto out_abort;
+	}
+
 	list_add_tail(&hwpt->hwpt_item, &ioas->hwpt_list);
 
 	mutex_unlock(&ioas->mutex);
@@ -346,7 +359,11 @@ int iommufd_device_attach(struct iommufd_device *idev, u32 *pt_id)
 		rc = iommufd_device_do_attach(idev, hwpt);
 		if (rc)
 			goto out_put_pt_obj;
-		break;
+
+		/* Our reference was passed into iommufd_device_do_attach() */
+		iommufd_ref_to_users(pt_obj);
+		refcount_inc(&idev->obj.users);
+		return 0;
 	}
 	case IOMMUFD_OBJ_IOAS: {
 		struct iommufd_ioas *ioas =
@@ -355,17 +372,15 @@ int iommufd_device_attach(struct iommufd_device *idev, u32 *pt_id)
 		rc = iommufd_device_auto_get_domain(idev, ioas);
 		if (rc)
 			goto out_put_pt_obj;
-		break;
+		*pt_id = idev->hwpt->obj.id;
+		refcount_inc(&idev->obj.users);
+		goto out_put_pt_obj;
 	}
 	default:
 		rc = -EINVAL;
 		goto out_put_pt_obj;
 	}
 
-	refcount_inc(&idev->obj.users);
-	*pt_id = idev->hwpt->obj.id;
-	rc = 0;
-
 out_put_pt_obj:
 	iommufd_put_object(pt_obj);
 	return rc;
-- 
2.39.1

