Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2081.outbound.protection.outlook.com [40.107.93.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33AE134CE
	for <iommu@lists.linux.dev>; Tue, 15 Aug 2023 14:45:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dzMdZAr33kPDOSPuRI+JDM6zzaAs0P9pxkCW7vBIGDFlBS+X8q1G7q3GPpxYuo+cudvQE1whXuIqalJkSG8V1yGIkhEbVLvT0VcVagiuVM3ZxuK2CZSmtlTOx9cspEx15kEx6mlAa+mFnN95lleBxhDRqDcpMUNdUs9qYMu9H8R/2br6STilNkIVH0N8/UBXxoRVQDHbe1A15TJFoIGUcCt6VoxZOohCunLWZKtBf7efJxRmWgq1zvh3/9XAvCYXz8lJ/vFX9k1JqxYtP10d7cRV4JKFiph5VEgMM6KooPP2OEOECwgRIRrU6glK+M66MHFU6BmZl3FIp42Hg+jA+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Endmlo8QhiWxSG58/yperLW/4Mv2GiN0Dmf15Ze/MC4=;
 b=UXJBKX/soyXRYff7TjyoozJf2IRPSIuVWofDUDj8/JYZClo2eOpvXtU9N8wv1j9103Ei8vFWotilwOxTVVnrYo8BKTWSfxtKbIfYAVpyG7zxxYWWt2Xnoq0KtxrecHIee9qIg3wcJFA0H8pI7ORnSa7Q5k7Vbwn78ni2SRDkHvWvWI3koa+d1DEe/mjm+H/YihWNAcrk5aKEiaM9DyjWEU66AfR0b3yMUGKOKP7RYCeSAAT18Ml6/OSLDw6UZbT9tyzpJ4WX8J1lHpUCpbWtaA5Dv13dCeZKnm6aSRAX+jBx6FylmeGEaayJHAoimcO7QZ0KI7Hc9gUNHgvbVPcqRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Endmlo8QhiWxSG58/yperLW/4Mv2GiN0Dmf15Ze/MC4=;
 b=uAITEYv1uXFz6CLFAPkff0qAznLHfv+bm3w+tudyHRIf7PIHudKkgrdxV3Qxv9DMQ4ZfXQN4quyMFwq5tb185K8A08/CRykrbhAXiTRAzKnAbzyeda7Kl77f267HyoNTWG1B/THCSUo2ZU6WwTOEww2LF3i6bIM5g14spMB9SbsbWIcFdoxFEdm3/DOoALDlEOnTo95j9PpW16JBfZAUpdC6LhaVkDwyeVrgOK/UWgbapChqxwPMLfYfovaPEZA+GeZEU/zvA5Lb2t/qhyLyXt5YxCq54nHx1pbFBgmnpj7o/IOfH+F+By/ryJYSnDeTwAeG9WoT29KlVMvJ2LkCzQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH7PR12MB7140.namprd12.prod.outlook.com (2603:10b6:510:200::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Tue, 15 Aug
 2023 14:45:42 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6678.025; Tue, 15 Aug 2023
 14:45:42 +0000
Date: Tue, 15 Aug 2023 11:45:39 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: iommu@lists.linux.dev
Cc: Kevin Tian <kevin.tian@intel.com>
Subject: Re: [PATCH] iommufd: Remove iommufd_ref_to_users()
Message-ID: <ZNuPkz9cikHM0ERy@nvidia.com>
References: <0-v1-abb31bedd888+c1-iommufd_ref_to_users_jgg@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0-v1-abb31bedd888+c1-iommufd_ref_to_users_jgg@nvidia.com>
X-ClientProxiedBy: YT1PR01CA0149.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::28) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH7PR12MB7140:EE_
X-MS-Office365-Filtering-Correlation-Id: 3086c929-ba2c-443f-03cd-08db9d9e4c96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	EUvb6k68EBd/H/eFPkl/FpqtEfvQ3NVOjPW+79oh3ClSq1/B+slN9SRlOKE1sKeChGz5lj1SQWcnkjYGfz6R+XHVOej+Yxayi8Ou6cZW07vfyblVepsrKFmjSN4KFl/6ras9Exp312IhW00+yx+HddGArGlcW/xyeqa0P/y3qbCnlyQRwnsB4/FGx/W/qvnQpWs8r9vKh6UPnTPaRmlQkutSMTTKj9nhuhT/g72+cjhFHap+ZC00eMGctWJOcBXMCg/009jE/1vf+c3uztnZBG6TN4nA0TsQh28+OULjpkYgMHwEDWo0cKqgVSrBYR5u1M0FeuQuf4CMhz/xPNdC7X41iKaWQeVXeRHwwwn77SszjskJCL5vvHOdfqOvy4c1Q6kHPowvNlBWD1GAMhgoPMRc9GlpcpwCgEzCIFh84psuLH9ng/0KiMAgK0nXkx9AczVVho0mKkJsu9wTfVgmkOMFZOYUTLIMJXvoqxrTjO7DGfz2bkVw+kfinYSptCIXQKJ5RjVh3yrpjausXaDkFkO5bhMa5iiDvRdnaTn8pNApo3wPLeqPVfoYSHC7r8Fg
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(136003)(366004)(346002)(376002)(451199024)(1800799009)(186009)(86362001)(4326008)(41300700001)(6916009)(2906002)(316002)(478600001)(5660300002)(2616005)(38100700002)(83380400001)(66556008)(26005)(8936002)(6666004)(6506007)(8676002)(6512007)(6486002)(4744005)(36756003)(66946007)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nZIfkrkX2v4y2jSgQ+wJN9ZMwhhaS/sxW1qiRNY0tiIj6AyK4Uu13sQDQIzt?=
 =?us-ascii?Q?sHySmW42cdPmpui9RWD5zwUgUxg8fHoSjincRc4eLkWWPmf5F0t+nhwvBjpJ?=
 =?us-ascii?Q?iTdoA4TSVOH34m51K5D60AVGTVIQJqj8/F7n/NhS5jmLAP6EI3fGC+MgXNdm?=
 =?us-ascii?Q?FXCLa4o99kbczB5Ktb2UclyU4dcuGgx4O+5G5gkgiEkmz9oCoKYDVEIJxPln?=
 =?us-ascii?Q?cTAESkGdEZbCEgCLjjKbG7uRs66ZpWMXRTi7oZQA4dSKizGF302ovxCyvKmt?=
 =?us-ascii?Q?3Zxx+bTjnLiJNZiVfSZRJV2bPjppx0VCpgA/Wq4mIRRQnKtKspPgjSW6v1Iz?=
 =?us-ascii?Q?JczD1ZCGpM4/EFI7Z5alHo9AimDhMSUplAr5IQeS5DUJ8b7n86yA2mOuyH4P?=
 =?us-ascii?Q?xcxMhi4kXmly6/o8SRg8VgUxiLOstqvXFQ32trV48eDpmhsp7beU/dTkUL2O?=
 =?us-ascii?Q?8X/iMSBJ0IIqEPdr6L4MbFOvr5aDA1amTQ8Nzpx3mg31cuzJSABJibxkhJ23?=
 =?us-ascii?Q?NmUHhM2FxIBduONHcuwbnPAoTLggcYtmUS4ob5VDYXMgUG5tPAnn8qPXFdX6?=
 =?us-ascii?Q?4xPzmXYkWVEKd4m+kawyadmfW4MkJ7Cj1kI1w18guKBW3qqtPCvobOhYt94q?=
 =?us-ascii?Q?UewKSC/7xNmLcxLHkY76zhs3+4IAPPIgyMbNM2Mbc0tn1Hjnk8GHUHLzQYzG?=
 =?us-ascii?Q?TnrdIIA+VboGLAaw0MwgJOss8S4GdPjuxFC5z6MgJ1k83TtsG1G1ojTb6+cW?=
 =?us-ascii?Q?GWR+ilYV3jkIdXZiptXPkDNp4/g00APDNaV0kuegSG2idwQKzqK0h9ar3ETs?=
 =?us-ascii?Q?9vx/3irtD4Cs9190tMax2lsqA795UUPkypK+H/9RjW2X4rUSzqEEPAC715bc?=
 =?us-ascii?Q?OmlHrdXEC7oG6zUL5e8qgMe7P7PFASWMT3tR7c9PyClVzWHyzxjiomzF4Bz8?=
 =?us-ascii?Q?Pm6H1+Qn2bHGl/npJX1Lf5WIPOdQzAFDirPHHBuoB1YZCF5xGf0Io7TfW7Tw?=
 =?us-ascii?Q?DiUiEyY5/FuMkn5CiONZp1AlEtQ+icF8YKVsXZZyXMpY1uF8VVDVqR+yYAtb?=
 =?us-ascii?Q?3eBVU/EfRJ0Qv80WV0+iQTw2BHnpCdt0qVvNmOppWfsR74qIaD7Yfmnz1Sjb?=
 =?us-ascii?Q?ldQvRGoy7hzPk1/ziryORLvxw/ePM4wvYTeaFnSvxctc3/C72kK9Y9bOk/IL?=
 =?us-ascii?Q?iVD5AAr3AMdE+e3TNVMH1NE6VdROL0LUYhMHxUyDgQb/ctDkGiYfmCSD2tE7?=
 =?us-ascii?Q?fbJCPPftMOSQwcQQzXwVhlnMjGoiVLz3wGu2JHW1GpbuVni8M5+JFArVVKzo?=
 =?us-ascii?Q?ZVsol02C7qF3qiwEb9ciTyTe6uZV+NP9NddjOpQZ9pc5xZPUu050GWrmSXiH?=
 =?us-ascii?Q?d3lrhXY29XBievVXRTwqfqSSTkDwS+s8P9+vvwMXrrVrZxw0Sji4GzU9uxf0?=
 =?us-ascii?Q?z848x2+trRWsFoL+aSXpeF+HOKhNUcKt80PtTdQsEbGv7AXbZSMkzpudZ5II?=
 =?us-ascii?Q?7sz24AK2b2Bl0W4aOLS5lxYrsyiZuJyjoWGkDJJ7o5Y9kZWHZeEac+Z/A6KD?=
 =?us-ascii?Q?fjzmmOAZ+CTn1cFJpxtNhLyqWeviFFoZyXHwO+gO?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3086c929-ba2c-443f-03cd-08db9d9e4c96
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 14:45:41.9883
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EWVNL5u96LxLlPe3gdZ0TTlQP994LwGmICGBDG6E8jHJsl4GuuVoK3D/HxvhfI3u
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7140

On Mon, Aug 14, 2023 at 08:24:34PM -0300, Jason Gunthorpe wrote:
> This no longer has any callers, remove the function
> 
> Kevin noticed that after commit 99f98a7c0d69 ("iommufd: IOMMUFD_DESTROY
> should not increase the refcount") there was only one other user and it
> turns out the rework in commit 9227da7816dd ("iommufd: Add
> iommufd_access_change_ioas(_id) helpers") got rid of the last one.
> 
> Suggested-by: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/iommu/iommufd/iommufd_private.h | 23 -----------------------
>  1 file changed, 23 deletions(-)

Applied to for-next, thanks

Jason
