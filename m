Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2075.outbound.protection.outlook.com [40.107.93.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB5A1427D
	for <iommu@lists.linux.dev>; Mon, 19 Jun 2023 18:25:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mmLWWrv+P+NWWC3RVMhq9EYFZge7qNqDwtJ1hiP77lYo/JnnizC8FhORa7rLVEVjc+Z7rl70y1Yq8JXpZK020dqyzNlUea9VLHbwloudhLv5yEB9C2QiBhDvFW5wiKxKmHa2ug1WVcSIh4SEPGlODeKrJCVpiTK/tx/aa2LlIvUzVYPl18ENTPCacmUttDTy7kvNUVurvuTbUfVDB9awO+3yNCPhg81ehpo7OhcDC2nYvCTQ88D3IEWvI6nuEOfD6S5odgiaYUTxCnxAffvc/pChex5U73SqkEdtpSAd4wOLuIMPIEY790/l2GKAaflYHlOIefY70d1HFaaqw073Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q8GbLIaEvmLfESrfNoiYeHqa/ireevLn6Ae6Nvaw8sc=;
 b=hW5hHhXPQ8NN37dzS3OFLnKWTjGcCH1NiSSkUa62rt6XK7bonGvFQUUS0dzTTVJTBDKrbhXu3JvoO7TO53c94ubcYQUHX07z177Oh7XKfNMgn0cRrcf7aLt4yZnp4+yC9oCj0jI0uBD31X0bMBWzG12GBugzl8fidG7sV3AhAfRI0zMBRfsFtYD9CeIUBm/+nNy4L9SESaeyt1SDzjov2qfWq/SyEKePnAn/9KAN/Lh9rSNZ6ODSXKtMY8qcENoFCLO7RKhkPdSBPOBHposntH1WaFSGTLyed9Z2HkW4NT0H4ytXvcg1BYtB8hyUF53A69ri6Zg2lVaDHXe7UkEjZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q8GbLIaEvmLfESrfNoiYeHqa/ireevLn6Ae6Nvaw8sc=;
 b=eOWERRKtTsbYmc2QelwUu9SbaULuYXzy4qNVYO65q2eXuxc9zOgQ4O1p6EWzLxYxDEP+WmPbDO54xhsZwUk4WQYTKVPWs12ejE9HOiduqQjccklgoVjW6PH09BbSflRP9useahBPZNiGX0SecRvJkWqXWLS52idGz0TdL2eGn1Xl7zfGTiYk4KpkJOeSwlhcb4uArJ+aCSIg425D6pGDfhyYW4RP9rCZolmNSWELttqb8rD0RPF35Xm0t0C/FMPjMR6oe9hlEWAbTXslNjxm3C/vQKJZOpSCVx05qHfNnhRv3akB2Z9Br+by469TlDwef1PW2ca+bPiqjt7AE07EUA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SN7PR12MB6863.namprd12.prod.outlook.com (2603:10b6:806:264::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.35; Mon, 19 Jun
 2023 18:25:01 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%7]) with mapi id 15.20.6500.031; Mon, 19 Jun 2023
 18:25:01 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: iommu@lists.linux.dev
Cc: Kevin Tian <kevin.tian@intel.com>,
	Lixiao Yang <lixiao.yang@intel.com>,
	Matthew Rosato <mjrosato@linux.ibm.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	syzbot+1ad12d16afca0e7d2dde@syzkaller.appspotmail.com,
	syzbot+6c8d756f238a75fc3eb8@syzkaller.appspotmail.com,
	Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH rc 0/2] iommufd syzkaller fixes
Date: Mon, 19 Jun 2023 15:24:57 -0300
Message-Id: <0-v1-9f7c19e02561+31-iommufd_syz2_jgg@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YTBP288CA0027.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::40) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SN7PR12MB6863:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c26c4e1-934b-4bf2-d986-08db70f27e8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Vlo/TrcJ4czlN1QKV7ADXGIlESJz0wY2klGobN8TQxvlaEKqWuB2Koc3CbYVUZsn1h5Z5UFp18KSjjiCRd9dLE+SX3vt21KPv4mfGRY/vcmuDiR4CpqK3qWVVFoPtk9OYTmu4px45cTdtw+j62uvQKp+cnylYgSkI9UIwEqDtyrD4lj6f1amuiQ7OUoWE/FQ0im3/eI0EHhaAEkn6OvzLG9f4JIxYEJDtXgvkvCFOqPUzHEKODq4LsZ7fbWchwSMXeW+SCLHhCMDSxn6wfYKRTeAQ27SW7Cf0k7f2gtpTRRB0MkEylYO24PcHYbCOMb+38kLUJ7WCSF0N/gu4ZylgF8ZDTI1bvM1D/TJKjoyW5gfuu9XcODrTRMtAGFfdAmkgw2p6Tmp0ieqsJZbxnzt6G7Cg+Fz3ZPQAVGIu0709dFVYAWh60UElDoW6Pf59j79dgd/ME4kmSfoKqlrti+EbFJdyXhm37LL4EHczkVYIDPFVb6o82Rua0SxZUXP3TqF5/eU3XqJuWBCj40NRC1W57H5GE7VWYf0YN+m7Pwjwi1ym1bfigkPLHzUHuTXCrehmOXEYK55MB+6AZO7VbzSNzy/bcRYQBlnFj+cJR4ChdY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(396003)(39860400002)(346002)(136003)(451199021)(38100700002)(36756003)(86362001)(6666004)(6486002)(6512007)(26005)(6506007)(186003)(8936002)(8676002)(5660300002)(4744005)(478600001)(54906003)(316002)(41300700001)(66946007)(4326008)(6916009)(66556008)(66476007)(2906002)(83380400001)(2616005)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GS/o/7HxPMMFvd1+tDm2epgnjNnOfpM/oc5U6N5gEP0KeDd9O9WVDC3ZDUpR?=
 =?us-ascii?Q?zJzsa1u/Kq4fCBVKk3NyALE3z0/nQk/oqnO/JxcF3whqdJ0PuBtL48ttri92?=
 =?us-ascii?Q?AzIl/oBffGWsEhj1PUCS95Wu5wm0HJC5ylxWZnFFbJohSEVC6pyjnp7BHaDJ?=
 =?us-ascii?Q?zBkNihsfzw1f3E3AuxUlCC6vIV1BGph+YcrAjggFGEM+MA+Cre7SlME3pHpb?=
 =?us-ascii?Q?NwU9LhTgNR5jfKbK2QHif6uE6VRzDYwzbF+4l+r2cGCawGm4nnsUfbCm30LE?=
 =?us-ascii?Q?LIwkn+ktEpSxL1ivIexRkarVEpJu70rIsqlshafo7kcjo3IgTQOKEq67QPkb?=
 =?us-ascii?Q?SOZuW+YEzReXTB02MdkEgVo9TGmC0eFSFquSK+rt7dYlXrq4HotpAmoZ92Ij?=
 =?us-ascii?Q?2CMkmtthc7Ncq8AZLT2Fv2+g2hvz9XUHxVOJCxbNcIz6AGQFNnXaVk4LhI2i?=
 =?us-ascii?Q?9X3zFGDcagfpSuCZTQZuX2OcShL1OL4tV4gOtSdyjkXQ9ikMVqwN33pDTokm?=
 =?us-ascii?Q?jbKo3jpVl2C2DFB6KQO4gZ3+83pK0YLBVVb7IaZrU2S/f71gt5l6HqV5ySge?=
 =?us-ascii?Q?miMP4oSfnpsQPAYwgQ2AXJ5DF5NT3e78LWYCccNOcg5r3KVia4OEAHDGG+HG?=
 =?us-ascii?Q?tMRia6DLe7V+WyD8r08aIab0IME+oIeUBuXRxdZjIBwos3L6D56kzlKOWeUr?=
 =?us-ascii?Q?zofZ4oL6tBGm7DsWCL3pjGptc/TnT9hmCCY++Xn66J7wPgDnNAqEgbVrFTTf?=
 =?us-ascii?Q?SvFRsQylDGygKlpxOitHCnFmNHL7HUL8I3tXsaNTX64f3v5S0R9j5p4cLjH9?=
 =?us-ascii?Q?JDkVQPVtEL+jGEulyZ9z/++tD/6CJMv6w4MLUYMqKjSlM173YpA6jk1zlpS8?=
 =?us-ascii?Q?LXXYjHP9/xop/pHwBQ2YmCgcUMt390N0K3nbV3PYrqB45g6IexTsWZ8UGGUv?=
 =?us-ascii?Q?OtapFOxWQtXGHZElvrX9LzqvVQLwPloOi7Rl6CJ03d+BTNO/sICzlz/a34UY?=
 =?us-ascii?Q?h6FGYdoF+mxHfeWmmjPqcqYdMvopuKkdMbeGPSYTAc2fiAz28z0azzAs+QXO?=
 =?us-ascii?Q?DThC6ypKVVJj/L8b68CwNGTkc2x+gf054R86WEGCb1UKyQ80D7yBEjXEG0cW?=
 =?us-ascii?Q?t9yZXAoh46WAXnhzZIvNuI3biWFIJk0u0QhscCOO7xf4B/nl+kRlE7nsIrJh?=
 =?us-ascii?Q?guade9gIjDjSTp1xFsDGvJ5Me97PeFyVU8EWH9cAsVMXUjJtHRm7cRX2rySC?=
 =?us-ascii?Q?tBtPmkqCjdb+FBZDKAiblgvuxRHDdUKqhOoMSH4lXGw8tqbtn9WJvAxa2RkS?=
 =?us-ascii?Q?aMsK3+GM7S0LUBQ5IkIjqyd9zM9/YZuDWyFzWJlUCfSyLEt9lKGBhHG5ftlF?=
 =?us-ascii?Q?NeFt7Ap+O6j8mBtyxgUCYAs5B70hMkN4xRlUz1+WCA57NiOCTav6xMp9D62Y?=
 =?us-ascii?Q?SJ8sG2RA/xVAPcGMgQDZlOK2kwdLNqofySv+cLUU4UwOFM5F9qUYkrEqrY9c?=
 =?us-ascii?Q?b2VbCA1MgsvQJ2m2OVHf8mAkHp2RTKK+IJF3kMt79XFG6kDP5Z4KOPNxiMo3?=
 =?us-ascii?Q?ePK/cY26pz0VQQM0uJkTmFRqQm/+SVvs/h+/4URD?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c26c4e1-934b-4bf2-d986-08db70f27e8a
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2023 18:25:01.1259
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +1ZnhescS/xviAzU2jKYCuHB+3sEAAGXnzZ6hDRh67ffhgMZmFuMizMtmmRMYl6Y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6863

Two syzkaller fixes, both the same botched locking of the area pointer
during the unmap of IOVA being used by an access.

Jason Gunthorpe (2):
  iommufd: Do not access the area pointer after unlocking
  iommufd: Call iopt_area_contig_done() under the lock

 drivers/iommu/iommufd/device.c       |  2 +-
 drivers/iommu/iommufd/io_pagetable.c | 11 ++++++++---
 2 files changed, 9 insertions(+), 4 deletions(-)


base-commit: 45a3e24f65e90a047bef86f927ebdc4c710edaa1
-- 
2.40.1

