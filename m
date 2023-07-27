Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2063.outbound.protection.outlook.com [40.107.212.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF4917AA9
	for <iommu@lists.linux.dev>; Thu, 27 Jul 2023 14:32:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aZZY7wyFJMcEd5f1ps5bigsJBcPouZmAh0DBpA58eIym8lMkhpKE9g+1cHeao3M8Y5uwaITunSbioFvji64iHfp6m0Sypj4u11AM4HFIZo4Mc49KIy4A9nLrDZUfitQK3S07ZPg4ZIcHetOBj5g91ZlQwrXHLr6svkqU40daMXT6brTeMJ1TCgEDKMOz9ycvb5qCPU3De+mLpkUeI09WpAlUk07kHSHA+x1jFyi+XzaNhbvrOYBn0Gz4APNjpCcDh9fn/5gpaFZNLFJZe3lpwfHl6gmAdQs6y7jFl8oBHcOFYh/zxldZCTIOsSvqKzkFSIsCX9yNZMGqgH1cdsycDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NmfQ6VBwHlVuEVzuRQIL4z0E972L0Q51s6jM/HL1BbI=;
 b=bwdbLaYxkq4QIYpGGgldNoGtICBMX0/XYKeDYAomXiTzyF7EDkA80VTDWipGNubntRZ1APNJ06PWYCbGRjrjXo7Hq61VMpQaNY6F3FDTN3pB547BuU/3q75OFY45Xb2L3z7h7QKsLnCVMa8KA0oe+D6oRP1nu1ZK1qVpoFzRvH1KuXmuzWGh1zGP6Vmbp0Zrgd4tvjQa7uAXzvmd2QEspXXlKzivJWdFQUd8neMiyoAIy9MFJWnMp9JtqJbW8I5li4yaMpSG7CswC6nyjHBYNV0AFm60kJMLg858OTA3PrTlx20bHFNvbSOL2pel0B24gF5+LUjS6a2v9EODDvUP+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NmfQ6VBwHlVuEVzuRQIL4z0E972L0Q51s6jM/HL1BbI=;
 b=MNXLpMD6NvtbwhMVVgjgvsbcbmOFBEIY95RYCQl9KZfU5e0+oaAVbX6UU2WtTV63Xaf6wKBW2srEPjT7m/Nb3hJGjXoMHBn7GKrlBmUOW3cObRUPHFyB9Sbz7+YR4FkCXeKgjCboxpbq5g+/xLASyb4kkwY5DydCN1p8sJOZwbBWKbBP+a/iL9U0bS06Zb/97E3q34RBbrZqOJni50ag29GmGXN/Zu+oqStMtqMmsAgnh4y2NcmKglSrplNZsazBVmcZK1/EwiBMIFJRZPmMEHUP8a6mxQo5LuDTf7jo80MHv6cVdPFd7ywS+tKJEdt2H5Ni4hocc6EBsT69t8+kMw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SA0PR12MB4591.namprd12.prod.outlook.com (2603:10b6:806:9d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 14:32:01 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6631.026; Thu, 27 Jul 2023
 14:32:01 +0000
Date: Thu, 27 Jul 2023 11:31:59 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: iommu@lists.linux.dev
Cc: Alex Williamson <alex.williamson@redhat.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Eric Auger <eric.auger@redhat.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Lixiao Yang <lixiao.yang@intel.com>,
	Matthew Rosato <mjrosato@linux.ibm.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	syzbot+7574ebfe589049630608@syzkaller.appspotmail.com,
	Terrence Xu <terrence.xu@intel.com>, Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH rc 0/3] Several iommufd bug fixes
Message-ID: <ZMJ/3yN709dGq2GO@nvidia.com>
References: <0-v1-85aacb2af554+bc-iommufd_syz3_jgg@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0-v1-85aacb2af554+bc-iommufd_syz3_jgg@nvidia.com>
X-ClientProxiedBy: YT4PR01CA0387.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:108::12) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SA0PR12MB4591:EE_
X-MS-Office365-Filtering-Correlation-Id: 0086e98a-6e34-467f-ce23-08db8eae3d60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	yyEHBt7fcT9arHf87qzLkcxPLkizch3gJDMQkT+bKXBAlv3I8wlAnCq0R6VmTNPnvYmKXS7ZjV2E/KqJulh92RQEBLGBeEjJGK8Wq9cCXdPn6u4gRmLOM0LX+cqZ6jDify7SJ/8LfeOmuqPy5y0S71dObhzgnPhMKdkdf/xwocTKOgATxf3KAT3ew8AdQeTKXX6eQrgf4ULN+U/aFoGBDJ3+qiQQUMcCK0u+fvsBJPDvFxN8OKFYFjWxMMfPCQdjhi3hldPFUIZ0ejp0MGtZU38pgzPgKqcBoGaQ7gDogBTFPeOG/M7br4fUYWiEukWc8qqUZtML36BGvMaC11RkkTlbHY4hoTSK4Mt7NZTy/lKkmkbWO70EfcsgBbbNEmHMdgXCB1dc1qQDKpMjfsMK7XLGeG8UMJF2BBBj+siG86Wap5p+SacB75dcSFKXslCwTzGLi53e2KSbQH7NMl+yfkOD/nPqqrWLOCw5heSsT2jE+hHtrZ/VHeMo6FRZr3H1chaztriAyTSzgf8UpcZvPgC4w6vhKUbHKSQBrEGIVqmK/5yGWSDceSyuGQ3dD5wO
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(346002)(376002)(39860400002)(136003)(451199021)(6506007)(26005)(54906003)(478600001)(186003)(6486002)(66556008)(6916009)(66476007)(4326008)(2616005)(83380400001)(6512007)(38100700002)(66946007)(4744005)(5660300002)(7416002)(41300700001)(316002)(2906002)(8676002)(8936002)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2m/xYUZmnVH1IIHbca/2+qdEBB2xwjPWTCL+F55XdlBR3p9d0CYpON/FrVvp?=
 =?us-ascii?Q?HrT7eDrH4Cn/cVQYa6/mZqdE0lLRuxOhh0TMg/Jgcn+VJpc27TxnELHBEV+0?=
 =?us-ascii?Q?r7L5cyKSVTu12+mhjJMMfss5l3wMnR/IBD/DzWrtuEYpU9EParx/a8eMUlAR?=
 =?us-ascii?Q?QZ6Z4nbnJ3wlMOGK38FrelhziBK6ZbVAyvZtwDym7n9l8vEtIyj5xiTaAchm?=
 =?us-ascii?Q?iC4VMXWsiEccHF+aPQXgB3Ovd7z0b4rMop+8kq2w26k3s0GvSvI1dlZ6Zmip?=
 =?us-ascii?Q?yRttsvMMLMafl2Goe2FnYevT1u7DTdxrBES4Iw2Yg+fVOhdmaEhLaNrsrHNd?=
 =?us-ascii?Q?4UsXR3DTaBZqRAKeqBnGZfUYTxN/ksRGz3hiVQL7ex7EIxCsqSFunaXm/0qQ?=
 =?us-ascii?Q?W94+NaK1YB+TOIzrKnoSDjZKfG/y8Tl3H1Az2i8psEvrvvCY7FbWh1xOZOrr?=
 =?us-ascii?Q?IYxEwBJyVTHF6KKZ1P/zelLFK+GjB6jlO+yOJGv+h99L86J1FM3RL1F0gdh5?=
 =?us-ascii?Q?ueR6RBscHRyKUCKitR87L7ChM9HZd/Wg0nqGCESkgf9htSrNvRW71HyV2UcA?=
 =?us-ascii?Q?ZvAX4GnIr+nuIlYTp52WLLwMDQKShKeKZT7VRLp9K44jbUEPHk3rkb5BkXS7?=
 =?us-ascii?Q?W1hPV66s8u4g1o61Yad1iTvjPWvasOK3d3dagSbzPTdrsvTta8NlnYsGWm2L?=
 =?us-ascii?Q?W4B/LVu39Tv1iwIAy5MPU9uaUsuBpcubW9gJ5yRxYeIhKghJqD+UmclI3NS9?=
 =?us-ascii?Q?F60S4jlxqlWnmEeT1wikdu3ahkD6VKGzRsy0F1udLXCFeL73U7GxuMKPVVIL?=
 =?us-ascii?Q?0Km8QMwcGpwuxoMEw0FAzrbRn6RQB8XUXRFMg0FOcvWAlDsWokQ4bljYmnFx?=
 =?us-ascii?Q?2XukN6CFgM1JEl8BhwXodb4UStW4ug3+7B73NAtpXge64fvbyC4puhVcZXzA?=
 =?us-ascii?Q?ImzwuLw+HbMTQJVxKAIDmIuA5TFHfwLYtr1BlWFB+9d3jYUR9vfCdaJ3e1nn?=
 =?us-ascii?Q?KopDMqoUO4q01k6zDuZTUcso1LgpPYUeG0Ikn+y8O4yxO8jiYjsWFswRuiHy?=
 =?us-ascii?Q?zWNdJDGUeHA6/mA3v7046qU4RTTSTaGD9Cv50cKrHt/amN+RXE0bM7pg7Up3?=
 =?us-ascii?Q?1zbwfeE1uUkmiZDnzF5r75sLQiWYk5/3EOQaAYnacHPLCbUkEagLaUlcfgjX?=
 =?us-ascii?Q?lhdVag73nflwN2rR3FVRV62VTFjzGG/vsHFarV09aI/I8/TZtAC4mUIXX+Wu?=
 =?us-ascii?Q?FyYhd8ju+xLjjBPvg+nHz6jgwFI6key+AZ1mphvgPW6mlLSouWJ31kal65gt?=
 =?us-ascii?Q?delhkJwdGVPTDCMPWYTdGki7uIDMkqW8hzhEQh+Pbi2w6VhHe9Wpnclg9Zr+?=
 =?us-ascii?Q?Ep7o0gd7W7Gy9BToWys84Oav20bE5Hjv9ASxS2OKiCfKDS5nCPWkfQ8fOpA8?=
 =?us-ascii?Q?da1HJHrEl3HDvVPYpRktzsjFtIeFR9qNel67DhD6cTf31PuBAJlTkUo+qIoq?=
 =?us-ascii?Q?VzHJoXWN1priRdCkfmYaOJeybE7fvv8baCm2fKqcU8hpWBA02yv2AP4ZjNMy?=
 =?us-ascii?Q?aNOGK6fwVjtMQebdsBSh3AFe+Cx9l2Hn+vcUSHtk?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0086e98a-6e34-467f-ce23-08db8eae3d60
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 14:32:01.4568
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: awROHM5RtTwPadPmSnBl+9beoLstFRCdC+jdLoejUg8ExXrCFcvECJzIr2tawHzI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4591

On Tue, Jul 25, 2023 at 04:05:47PM -0300, Jason Gunthorpe wrote:
> Syzkaller found another small issue, a race with
> iommufd_object_destroy_user() and IOMMUFD_DESTROY.
> 
> While researching that I noticed an error unwind mistake by inspection.
> 
> Yi and Nicolin stumbled on the last one running the test suite sometimes.
> 
> Jason Gunthorpe (3):
>   iommufd: IOMMUFD_DESTROY should not increase the refcount
>   iommufd: Set end correctly when doing batch carry

I applied these to for-rc, thanks

Jason
