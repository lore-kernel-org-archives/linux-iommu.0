Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2047.outbound.protection.outlook.com [40.107.223.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B3E199
	for <iommu@lists.linux.dev>; Thu,  3 Aug 2023 00:22:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cU/YUzK3IRXMZr06D+ijUdWYy3xQtkr7Or/YwunTGI579j7lCHUCONWCqIXh/TGeeuhdcLJqMpswclwUwN1sItvSzkNoMcbos7rvoNy49AkYU9BWxPdMuQg04up25V3ULUsvvIMxjqh46ywgH27TJ4Mz3bGfi5JbRfVG6JF9sy2MLnMwfXNzYvReycxvxvYkjlsEJlDIF2dlLnuqSG02ZKiB+S1ln+RIf9Yr3n0UHzUVAfHiDCVS0BtDV2b9225epfXIJE7Se6zELaYOgKcpKw2ywFtYVkHon3yNvKcUvNJ8Ow/3nfDlEf4rcYFgoPHJUOsKdFhg+s6fxrdXSV0bhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zNrYXmTBd8ry8O5MSFckpuaX99Ab9H2cNeDuSqTC8F8=;
 b=Jf3J7zpo73Hf5LidgQRP2/EmDq/yxP5ptQksDgA9exSqU9xJbyQhgI4UAKl3KwdXSrrSqKkwEognIBT2FERjSoLqLCnRLke2f3ZXmD0YVHdHMGfeWzxs0jX3BHIy3GUHqgO4ZPlgChZxRkRw6/kbdm7jQzu/ye8RNbqd+fuD0nJplOeBiYXtS+u0Un7YshjR9Gfk06SaSdZscZo72yYVZ0/EYe3lpnBX2w54hTovVGfCN5EvN5Ar3BoxBTjgkz8vYA0Hj5gB4xKyLNx33K7J/rkY6T2PRD6wB+EywqcQadnDQ8HNDENj5vKKipH6Y0vEbOG+YNZ8wSKK58pYqbjQwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zNrYXmTBd8ry8O5MSFckpuaX99Ab9H2cNeDuSqTC8F8=;
 b=HCGlyKhE2n9TNI1vjQrgRy+a5SX3dCdvb8fpWFU9RSI6kWTQuEMtv6cmNuph3l2xW76nLLAdYLxmTkKTnVvgLOpUdiSwMGYASzh8W0PC3vtZMKwJESxLoZlAVycw+sKWBTryzCa9KcvhLNiXJg2j5ypJX5Yql13K4fBDKT5T24sSgpAFnva4u+Hy4lSY1E+HyN6InPlqCG972JtVYPEZEZYGR8YrsmsR4ckDH9F128aTLUhcwYC6r0QId2GnS79x17pemYoxKPBJSZk4KnevRUpwcL50R3xdn4RX+MCEwMAugOyhdpzGjEInZ52NR96auOYjc/BaG1ZWCm5+w47XlA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CY5PR12MB6297.namprd12.prod.outlook.com (2603:10b6:930:22::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Thu, 3 Aug
 2023 00:22:00 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6631.045; Thu, 3 Aug 2023
 00:22:00 +0000
Date: Wed, 2 Aug 2023 21:21:58 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Pengfei Xu <pengfei.xu@intel.com>
Cc: iommu@lists.linux.dev, baolu.lu@linux.intel.com, kevin.tian@intel.com,
	nicolinc@nvidia.com, heng.su@intel.com, rafael.j.wysocki@intel.com,
	lenb@kernel.org, lkp@intel.com
Subject: Re: [Syzkaller & bisect] There is general protection fault in
 iommu_device_unlink in upstream patch
Message-ID: <ZMrzJgoQfQFUT7AX@nvidia.com>
References: <ZMkMt1cTeXhg8yBM@xpf.sh.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZMkMt1cTeXhg8yBM@xpf.sh.intel.com>
X-ClientProxiedBy: BL1PR13CA0109.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::24) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CY5PR12MB6297:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ec56a8d-7f7f-4b5b-0a30-08db93b7a768
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	DVbta+znoFsXRQ+Om/xXJf+8FPO9g8m1XxHvG2MC3cXvxK6K+/3aZzvQmD+QS4yimmGfHaq5R12LmneT4FlkyldC+SoH8lyZcC85Wcj6hsOGLWUZkUCN9CGWwJGiG//DGD0SaNSK48MvVPh9X+BHD7gouZ+TWwVFQ5zvi8XEDAKMIMfYE1E7aFsC4N5Ru3/A0cE2S2rnZVqFwkGyz8Ve8VavYODc5TPCBOUmDVVlrA68bWJZwIS4LlEpmvxRz6hVV6gp/BRCw7/l3UxCr4+8qZLzdXANQLOg8vn7/Kqg0citJk5So304/sFeZvHtkFgOFy49CHQy/FhkeQ/Qmqi0QFST1m9VUk3I/L8rtoMm/KzkxkvCKJkVEicNNJgPZjzjyFsOrYVgFrp5eGgFg/jBPR2lpX/WF2up8xA29D+nGPUu7ezr4jvNRQH/N6sclg3crrAwVPsvdsQhO8riKTNiQer4uH02brlqt19DI8i9EqFoJfDFxqs8oolvqxE2EFdPkpCRr0QjL6LqeChv2m87knGpJsRBzqwVyOP49VA+TVST8/3hA0w3nnsIVOBR6YbVGVR9du/pTDfQi/6lEckmFw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(366004)(376002)(346002)(39860400002)(451199021)(2616005)(6506007)(26005)(186003)(316002)(2906002)(66946007)(4326008)(6916009)(66476007)(66556008)(5660300002)(41300700001)(8676002)(8936002)(6486002)(966005)(6512007)(478600001)(38100700002)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UA+Z8QJY1ktUfWo+hA9oa1MP6tiAGN6M+iNj+pFLWZdHtk0yEgdJ+o9p6feE?=
 =?us-ascii?Q?94JDbJbXhSlsO5d+jpgbIvE6C9Jr8hgIbV63SeDWCHXSuLRyyx9RMZuqbHjt?=
 =?us-ascii?Q?3BMzfmG78n0KxzTgVU6T1BxmkAructs8EHealhvi/7GsjUqoFi1oS4eFDCXb?=
 =?us-ascii?Q?oAwXGcuDdkNWrvTgnsR0nYR854UTIL8s/aZkD0zKsWmf5VWl9udD9C8lpjg/?=
 =?us-ascii?Q?1krVtIN5BKJd+30PI8RKKvm5mwnyAs3r6dV5vIvDLARqJK9AYNjvskcgxxSF?=
 =?us-ascii?Q?sGKJFcVfzLGQHGT563/v2xQM+AY/lLaFKZ5WV3k9CyQOB6jIpa9A8GO4NAp5?=
 =?us-ascii?Q?9GK97L1+q8i8QvGyMTP1DH6TSqK4pcytQDx7WFpcbssGZxhTY4Nxn1mxR4L/?=
 =?us-ascii?Q?fou48XeGJ0T+4g7hAfqxO60i6sORgP/u5mIcu9YVx79F1AcKswS+fL4aSlak?=
 =?us-ascii?Q?qzhsLs10kgis2LAxO6DCYdRLxEwo7e4AxYRviEGLzWV2SLg/uwYtlUOGkRJR?=
 =?us-ascii?Q?2F83UthLxxelykW0enWvYzx9jq52Z7jKnmGccgj/N2TyUaRBnKi+MfVb5cjA?=
 =?us-ascii?Q?LoAqmlxv/fWpkyThVka/cnUVmyZzbzkdqW+WktdSwqUSTPilOntqkeTdzoyf?=
 =?us-ascii?Q?E/ONkFWmbYhf7sdk6bwApbUqjtyimjfklOrKo2rO7bvi/+REdFwbenwZJRmp?=
 =?us-ascii?Q?WWlwxnxbdypY9rvMB7FwBS4mP++Cv4Np0HrcqN5q9NEh/oI2Ti8P3eWDTlyL?=
 =?us-ascii?Q?p+I+kQmUWvmv6wTugM2ClRfc+z5YeOsIeCZtUdznqA37m5rlDmMf77RhvaJk?=
 =?us-ascii?Q?3FdbAnFSPG+2TM8xjfYFNWaha/4aLork8JEr9aR629U1v8ZHfljlB7zN3frg?=
 =?us-ascii?Q?U0NUmRWM+x+QleTMDRR2L4chv7+4+BXvG/EA/wTitIXX+/jguKlM2OsGPJ2m?=
 =?us-ascii?Q?LbnbCsoyK+e7angc3GrXFAClZBIo117skfqZL7dkAOKMQI3E5WFhjQijkiDD?=
 =?us-ascii?Q?ZZSkm5BilqUiSmZonG8whvBAbwfayaOKySaHQYmeK+EgC6yp0PO3KDjLv4MI?=
 =?us-ascii?Q?K9TcmGCT5Nqwehtku5XzSdg0Cq4+wFP7x72T5ON4P421y0YAM88n92oxEO+y?=
 =?us-ascii?Q?P41WCpKX27YAjYC4DlFc2hpZ02yiV16m8Bylcz02rYxavgVBqdJ5l+TBFqYQ?=
 =?us-ascii?Q?H1ESwLdJeymc/mJ3R9IXv7dLfpsKquHpryzdNSc2h7tFYsXU1F/zfr75ylAm?=
 =?us-ascii?Q?TWHBzrhvHayA2vFBsf/047h7R9fEPhlkr5Yl4LHTH4Uk4mADyG6ZQgMl1nXJ?=
 =?us-ascii?Q?L70PxWiArjoAoCHCoGU8lnCUavvlG81jgzvb4/GrgyHx2R501Rd5cJvnDVyB?=
 =?us-ascii?Q?3Xgki0dwBUs2cJqoE5krN/U3hAaRQllfKHf9QXcQ+yNMvpY88u2ShTrCPfVj?=
 =?us-ascii?Q?JaDSjA4hUf6QgRjWVwqpPYObI70uZBb9jY2xJOamhDgSJsQ3Zzr/1CLHl7b9?=
 =?us-ascii?Q?7cSXgxgbpD2udvVjfxVQpnax3dJ3hR5bf0XBiBcNINCzyEffGJpYvp0fkZVC?=
 =?us-ascii?Q?kFKkbzb6BqipdjZhJ2DnlUygyXkkygN07Dq0bcmC?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ec56a8d-7f7f-4b5b-0a30-08db93b7a768
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2023 00:22:00.5403
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UQRr5LEf39ueJ+SV7FByAA72H+1Z/Jh5W7yZapSU4vlowWlEu0pPX09AVqkaNfQt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6297

On Tue, Aug 01, 2023 at 09:46:31PM +0800, Pengfei Xu wrote:
> Hi Jason,
> 
> Greeting!
> 
> We tested the intel internal kernel and found that:
> There was general protection fault in iommu_device_unlink issue in kernel
> and found the problem commit:
> 14891af3799e iommu: Move the iommu driver sysfs setup into iommu_init/deinit_device()
> 
> Above commit is same as following patch:
> https://lore.kernel.org/linux-iommu/6-v3-328044aa278c+45e49-iommu_probe_jgg@nvidia.com/
> 
> All detailed info: https://github.com/xupengfe/syzkaller_logs/tree/main/230801_150257_iommu_device_unlink
> Reproduced code: https://github.com/xupengfe/syzkaller_logs/blob/main/230801_150257_iommu_device_unlink/repro.c
> Kconfig: https://github.com/xupengfe/syzkaller_logs/blob/main/230801_150257_iommu_device_unlink/kconfig_origin
> repro.prog: https://github.com/xupengfe/syzkaller_logs/blob/main/230801_150257_iommu_device_unlink/repro.prog
> repro.report: https://github.com/xupengfe/syzkaller_logs/blob/main/230801_150257_iommu_device_unlink/repro.report
> Bisect info: https://github.com/xupengfe/syzkaller_logs/blob/main/230801_150257_iommu_device_unlink/bisect_info.log
> Issue dmesg: https://github.com/xupengfe/syzkaller_logs/blob/main/230801_150257_iommu_device_unlink/a3fe9a2e1692a413d887a6a0f1184c26481d6a2b_dmesg.log

This is only an issue for the iommufd selftest and it looks very hard
to fix in a micro way.

Fortunately I already fixed it here:

https://lore.kernel.org/linux-iommu/15-v6-e8114faedade+425-iommu_all_defdom_jgg@nvidia.com

If Joerg doesn't take that series for this cycle I'll feed the above
patch through the iommufd tree to fix this.

Thanks,
Jason
