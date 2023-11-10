Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2072.outbound.protection.outlook.com [40.107.92.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C781B26F
	for <iommu@lists.linux.dev>; Fri, 10 Nov 2023 14:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gUqnwcTy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TSqknLaMUwHVWPJe4lYJLXZZlFKh0md0NztBuiYhaIGedkihPtKqUH5UvT5n5GeYX9ihNqCumWCbqU1a2iqh2Z/JBtFYpbr7ivWU49886ekPpn3xhySseUtX1Q+5r/0EzMzLYtMn5fTobnOgBBQimNtJSwP4XzOg/rToahTj5XwIaxw4PLJM0hm49hGsgfygimqbJwzcDaN4xINpvn7PACKiQsw5iOK3eES+NtvWlPOdUgkRYNSzbfoguIzFyM38+a+CvixMDSBc9YePejZePo+s31BrekVZEXEYI/B/r+2mIVQ+JyMBWkvncqv+8A9B9bqiR+myCqEPpfqeLFoEEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TNCt3inkKQyoDj+MhaixD+eVKHlQo7qVqplj8Tl+iXE=;
 b=TIPiHja9ZX1HC6ShPfhzDkk+Qj/hl6g3XAttmQqY+ltdMLiM5XspViDm7D4Fis8fbUrDAr8eJLZq1OFCrp59f5BYbMEv45POJxlYFTj4HhkFb0FPq6I8KrdkmSGKu9ZDULEn9ibDcU/nJF5FoYp8wZaB0BScRjQ9mBpTdtyhinwp/pCBt1RhkmHup5b63BY2sw/UCmAITF0yX3KZ7WqzP3GWKn+6iyXT6S753VQEhLnx4NRzBGIX5vT2PBTgezvOkP+9htukHhE5785MDRF4Cc25LXGUomeFvtKxtZY6Gevc4uvZ6/nvHvK+KCq5JutEUiEG75SXB4jpDdHOy/9CSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TNCt3inkKQyoDj+MhaixD+eVKHlQo7qVqplj8Tl+iXE=;
 b=gUqnwcTyn/AiTW1hBCQRQBD4X97gKLD/jKXOWi3J1EWuwAXsRL0TuKFjuYiGp78k76ZgsXasqwWxh91BMo0sHgEjSWbjYGI6jw0HEWCPIi4EyeSPN6W1fiKAbbxNDf/eYQDgcYeEY/cpLGoJC7eRTXX/VrWZnphq589vX4g3hmomCodLMqnbBL1By0gJZHoBLdGqS/JojwljZ9sAQLHTG7rO50L0FvDvYvPkMHbOsFGl3PkqDP0h3jiDTs5xn2EppncyHkjBKmv+eqB+zfpaRLYGgxJo2BmNvl3rohWuasiZJ+xRObhF7ndkzh4Wgbf8VoDwT8/cEaiNDhhym9hP9g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CYXPR12MB9320.namprd12.prod.outlook.com (2603:10b6:930:e6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29; Fri, 10 Nov
 2023 14:02:36 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.6977.018; Fri, 10 Nov 2023
 14:02:36 +0000
Date: Fri, 10 Nov 2023 10:02:35 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com
Subject: Re: [PATCH v1 10/13] iommu/amd: Consolidate domain flush logic
Message-ID: <20231110140235.GN4488@nvidia.com>
References: <20231006101624.5912-1-vasant.hegde@amd.com>
 <20231006101624.5912-11-vasant.hegde@amd.com>
 <20231105175559.GJ223197@nvidia.com>
 <5e95d78b-4c42-6596-c1b0-057e044197fc@amd.com>
 <20231106131303.GG4488@nvidia.com>
 <4267e033-6cf8-565b-9a89-492746c6c257@amd.com>
 <20231107130917.GL4488@nvidia.com>
 <875d1c5e-05ae-7248-3823-38a5e1e2fecb@amd.com>
 <20231109141056.GG4488@nvidia.com>
 <c952fa4d-6a9d-5d47-8572-4a107e8bd198@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c952fa4d-6a9d-5d47-8572-4a107e8bd198@amd.com>
X-ClientProxiedBy: SA1P222CA0044.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2d0::9) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CYXPR12MB9320:EE_
X-MS-Office365-Filtering-Correlation-Id: 245d63bf-7dd2-44fa-5fd1-08dbe1f5b18e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	zMSfuGuxBSLRUGu1jrGPv0YbuPwZHRNdGcof7ARbkIR/dJ/X1LWLVbNssocRD+0HqxJPjNIFokxsB8rhgFsBItiDOSJDwlswNmoCDZvYaPzxNDYPdj9ezJ8glt4NCdiZukzg1mjat1iScd3VgkqN2exGHOn3+ed4C/qBKDc9ERs9jShMfWokXgDy0fqlnKcPwaKGyyKUmRWsIVFwRmZwZ+EQeSm4/xoecyipxtwXlM3KiSllqzd42uEdCRQ1QBdbdcm+hu5R1lIMwBTo7rDmgXo/5gbSl/1DhPIOIGDeS56KUIZ75WMadhZ0PPTWnCdeNDAC86LysL4OFiU2mXcH7CvbuTGiIbM4tgzXwrYH3zwp9KPB2Ow5a3y3EwsewGycBDJL48UkpHmhE0tI3l/M5LW79cha441R/JOZeGApku7QRV2Hj8JcvkNxoONW3lrglWdSwk82HaIZO1vxCBL3MNPsZqN7s77Svlr+6UHGHRiA+mKCVujYoGBxCTGfF/fbxtzg9Y94XfDMjAtmcx5+eLDa8/i73HppQGidtQ70c3o+O9YpbvcQtyt6WTIBumin
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(376002)(396003)(136003)(346002)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(38100700002)(4744005)(86362001)(2906002)(36756003)(33656002)(5660300002)(41300700001)(478600001)(8936002)(4326008)(8676002)(6512007)(1076003)(2616005)(6916009)(6486002)(66946007)(26005)(66476007)(66556008)(316002)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?q50MKhAdCA7Dh1hrOgVM2jpC3BtMd8tzZeTFwZ699RUNnwM31U2eQhmNQLYG?=
 =?us-ascii?Q?p84zxEa1Xo8wKTEFdRZAOfowIOPKo/2U9Nu2hRIt0zuvsyc54zp8HRidXpqm?=
 =?us-ascii?Q?i0rwKgt9As9tXyrhDxVPWwJ5E8tWHCFW9idc189g5qSbOLc+LNQwQfHbqYLG?=
 =?us-ascii?Q?evdnqZ/wem+NOb4Dd/KILT7cRvxGDUNi9KLqUfyvHawAOqHI+WlkF0ACH279?=
 =?us-ascii?Q?MNmutovmw/ihM3967mIT+SK8RaI56IjWYmLGJGp2AvaAPvtIKVWL+yWeLkwI?=
 =?us-ascii?Q?uiNKi5DKb8C7HUmueY9pjpWyg2J/sXtgrbVXODkEGTUtL10tPoh4qp224D7w?=
 =?us-ascii?Q?K8h91wknhcK4FAInGNmxC4hawgIoerKeASCl/l24BqnQsmfh1ZM7BOA7sf08?=
 =?us-ascii?Q?60LYDdix8CT/WJWPXGCse4RGFi15tT1ztwJLeWpOU1WCEVLzDbAWf2PX97Bh?=
 =?us-ascii?Q?9z6pKqRukoslbNEDtMTbNE+ZLUTxP2t1YexM5LBv4FckjxvVlCA+uqlDWcg3?=
 =?us-ascii?Q?O6lFvX4JcmAFXGOFUgewQTNGzL/jXFp31oK1sr/04gxAjEREHAjAISjpLDqF?=
 =?us-ascii?Q?8A2My4OIUTuvUiZh0CnB+U/GDq8fJMwHFQrQrPmeDF/OLclVb/E9o+s2Z8Lt?=
 =?us-ascii?Q?dLgy2RqezEizhqgXb3vvrg8WwDontp+p6pgIXuvjAV0FisiKNwIVQi7/chh+?=
 =?us-ascii?Q?HoGDPMOuRLr+7kBK6LHhNfGCWxr+LDQnzVBObs249F/GNlKYn8PKfE9JuzRY?=
 =?us-ascii?Q?7PYxa781nsg4c6LBVqcGjtiA40Rm+I8sb+tSmZM1WB8+8Yg88VxChwjB3cqo?=
 =?us-ascii?Q?h0zsWTvkF30lS0BebTOzLdwmN4SuSRb2+W4RHM5uosB69KRtn8BaCx2tuEA7?=
 =?us-ascii?Q?kX28HuO90r7GlklNGfnfNYYLHR2l/ugp7N8rtm487bcFLDRKwpd1zkbUtC6s?=
 =?us-ascii?Q?V8yRTnnfQbJrrEJYmWtqlUS/emvFdQN/6rGV+Gmja2OSsi3nSRFDN+O1izDR?=
 =?us-ascii?Q?VisitkmFLAE7U/5ThuPn4XPHE87oegHd5sylOp/IqUHlqGFRUrf8Gae+QmX/?=
 =?us-ascii?Q?GgInuPq+hYl74Fm11syIlG/vGK/DanAOsY+7bPH/TuND511OuRkVr3iyKiR4?=
 =?us-ascii?Q?fEH8DKAI1ar37g8p8XSODf/664AWOyx+kNC8we30KfvE+DN8MNJ8TpSG20zl?=
 =?us-ascii?Q?5LSDQjj+gkHRtC2U1dUzP3Sq71iiJQloGGg5tBwYWSaZp9freICWV1K4T9kR?=
 =?us-ascii?Q?UeEjX8zURVLe8z4SSaokQsJo3JGhoUAONs9ea6Rv/pRFOLggRJnyG2yW8qC0?=
 =?us-ascii?Q?72wzRb3DYvwnVhV0RVSfeQoLWhhq7QI5ZMdMu4JX6eyrb2nXNogH+Ix0sJM4?=
 =?us-ascii?Q?JsMcNbxTYWMbBtl+FNbmkQccZx2HwXTOeJ3rpo8PwT4KcdNH7TAfJ07jvqu0?=
 =?us-ascii?Q?lQUZb6VolkOXyD/BOhLKDqnb7b9dVZUMUwGzhEsrOsYide7JpuI791MhyUEc?=
 =?us-ascii?Q?KDBrrfOLKpzkDUzdZonSjPA1kIr+3NuYDwI0o16CIiKXnelsNt3pOCjmFbKk?=
 =?us-ascii?Q?Tr7smtCFC7EBAKnsZvY=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 245d63bf-7dd2-44fa-5fd1-08dbe1f5b18e
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2023 14:02:36.6375
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bozVqnwoHkfedKQVvjNVfwXqqUhySOyL8i8mCGYNAL+xswwzGYBAVYIv5csYrHzz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9320

On Fri, Nov 10, 2023 at 10:58:27AM +0530, Vasant Hegde wrote:
> >> /* Invalidation based on device */
> >>
> >> amd_iommu_dev_flush_pasid_pages()
> >> {
> >> 	iommu_flush_tlb_range(iommu, domid, pasid, addr, size)
> >>
> >> 	device_flush_iotlb_pasid(dev_data, pasid, addr, size)
> >> }
> > 
> > When does this happen? There were only two places in ARM land where we
> > needed a non-domain invalidation:
> 
> This is for handling mmu notifier callbacks for SVA.

SVA always has a single domain, it should use the domain invalidation
functions.

Jason
