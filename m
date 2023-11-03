Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2074.outbound.protection.outlook.com [40.107.94.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BBBB33E2
	for <iommu@lists.linux.dev>; Fri,  3 Nov 2023 18:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ssh9leCu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IlsDV8IqgkrmoSsCnbyGIPNrFvcGJSldWFNCkFEzwa0goD/FCQWGyARggfj+bYlb0xTnDtwrHuhne2t5LtbynDNBfmzc5rNkcTquaCi+BWn0zbx8x+2I8bFjgaxbl51NIc8YsDic2T00V/L3qfAzncvdyMd+J3fPhJFvvUjJ4ixmlAMRuTJveYprd8kNeVwqS1rQsXDXrnrh3p4pWIm0GKoY3Z2DYezLiqLHiFFXhb0tU5EXnnuSZJt3buOB7KK8GMarwYyF9/KOMp1tT0DStzZao+OwfvqJpx+w8AssaL6kfw4WjE+RRtxnpB6HZI6U/xcXU4jSHNkl0TyURydWKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+5k2uftKTntI/mArOyQsLvgph01wgc2AOgv9k+c7axo=;
 b=UicBr7dHoxaIDPoU0tpHc+/gdddgSNrM/FLAnXfmjqobXc1OlHf3t7ItRpUoMS7Li85q2dn39fsk2I5SF4HrvtxLqdbBwnyjP6dmmx4N2z8OLK0cg11vDgORhbBlZOJZHwRuKrPBsyvWA+aM2xzHQiNtYLl9m4w5ZXb/J1V56dUO3mOETGf+UO+K8bbRzdXPfkTDksuvHHpRO6qXUclnIOdUNg9n7vaZ6reDj/4kV2yekZn+KYIAs/fTTF4T77b6ZQ7V71rCW61NhNRNTo+JLONJ9UTVzqJ5zqKOdtaZMzSkCXc9TDHUGDCwzjMB3nJVhoBuoKrAKeGZqo3cbq6pzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+5k2uftKTntI/mArOyQsLvgph01wgc2AOgv9k+c7axo=;
 b=ssh9leCuFxQL+msQDB1vrqPbh/6qC/dxHgE5Wx4dCc5wd2DwyWm5d9umispx7cwXvKF/6Lp0/ioTkCA5AQG34zmP9SJd4X/GhMIfwHMm9fIMwoiTzpscWpWq4aU3aZjd3E0vEUvaNXCIQ1A2RCb2wsJhtD1LYSXizVOyeMXHtic+/RnZX2c4EM9LjLALz/m3fUkNce7mE7WteJ+d1mSdRG2IiKAQ53dMabkEme4GXruxGHbvAoqfEYfWLJhsRGHjms8gIsJvL+Tw1dOSJB2jWXUm4Q+ojCHeIwK4g59btFSyWjNJiIyF+lkvCz8kkjQzPL+Lbz8Wp+/Qtxqnmk98BQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SN7PR12MB7369.namprd12.prod.outlook.com (2603:10b6:806:298::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.21; Fri, 3 Nov
 2023 18:44:28 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::b53a:1092:9be2:cfb9]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::b53a:1092:9be2:cfb9%4]) with mapi id 15.20.6933.027; Fri, 3 Nov 2023
 18:44:28 +0000
Date: Fri, 3 Nov 2023 15:44:27 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com
Subject: Re: [PATCH v1 07/13] iommu/amd: Consolidate device IOTLB flush code
Message-ID: <20231103184427.GG223197@nvidia.com>
References: <20231006101624.5912-1-vasant.hegde@amd.com>
 <20231006101624.5912-8-vasant.hegde@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231006101624.5912-8-vasant.hegde@amd.com>
X-ClientProxiedBy: BL0PR02CA0072.namprd02.prod.outlook.com
 (2603:10b6:207:3d::49) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SN7PR12MB7369:EE_
X-MS-Office365-Filtering-Correlation-Id: 365e2163-955f-4920-677f-08dbdc9ce8f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	gTMrlKs+Q6IoRiShf/yvEh9eH2HEadts5XtbsuT5Na9C6sVhsi0Qo2RuQSmH+02Fye7ttaSG7zSx6Wzg6RpWrhcx39NxyQhjrv+gjYftXRQE2f5ZUN73+i9SmxQUIyMJsYgeJatkrE7LBRCKeAa9kWWeZwpBYrl3lOHXPQ3bx5nhnIgXmw/Ycs8I+Hl6LczSrf+Tqv8HJPh+7pHJmZUFVWNp/d+Q6MTE+w9hJ1JRJR8viunyohCyQ4SuB1Lg+m/ysfkOr7QJc8b3RKb0WCnSdcbD+i1yFacOuU3VVibs0KiPqiYbH9/iZgPmZsyJrxli7IWS/hV0gXPdPMt/IZiNMu+m3duxyv/MXItagGTNPWGNbWtFCMfyBr8Jh87Gzjc3Je8T+FqsfE5KX1Ic/Vh52394os7/rlBGERar9+Jihn0BBIsTdl9IBIyjofEkUGt1LpXnIE31AazppSNqjMrMj5BwL1q3+pnFSghKLiN+q5Y3TRmC6fBZi/s3GYdeMuMKe5AjfVD1EY8ej3aOwtKMDoq3b0jdwz8I/+Y+dqsYMTkH7CM7zYJ4XwOJ5IV4mkhu0g1SkvN4fDX5voi5njyFiQbP4jKtRvGYXom0OwzjXLfosAEoEgy62ME/yYzecUW2
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(39860400002)(346002)(396003)(376002)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(33656002)(66476007)(4326008)(66556008)(66946007)(6916009)(8936002)(8676002)(316002)(478600001)(6486002)(36756003)(41300700001)(5660300002)(2906002)(86362001)(1076003)(2616005)(38100700002)(6506007)(83380400001)(6512007)(26005)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?snxL1BCwdaa15acietm+7UiqtentBs6I7bTyBlRiJkGD+FZcCHmhL4hVGlmT?=
 =?us-ascii?Q?xG9+9CIT+MrnCCO2IkmXTkb8RQFWwMiT/et9zUNknc5GuMz3i1p71QdNUVrO?=
 =?us-ascii?Q?vxwLm36Kh/x17EmVffB9RBJIO/FSJ9goIcFIlsB/tlEpGG8/CPp3NxPa9sh+?=
 =?us-ascii?Q?E5tQCwA3ttbHUFm/9UrwTbxTCDHuvABOqjFd7x+BGPmEiTGYwAgljxlVl4hy?=
 =?us-ascii?Q?5g8awSWuLKcU5s4BP7qSy1Z7K/e8KKjzWs6OXBseGNEJBtKh51Nh5oITaJYv?=
 =?us-ascii?Q?v+9oi3Yv0WfKAD8T98K4I9PK2/4cbKN2S4u8HhbCJH4o3DQ6sg2IkueM8JRA?=
 =?us-ascii?Q?vzJ/dkej+b2RfJ5apAL0frPozb48OlQdA/YBT4R+rWzqUmqcVmeElI7wBQ1V?=
 =?us-ascii?Q?aJJlx9Rrlh+RY1dMS4auen5KJBj2igrw9LucxbDuF2hYpEsZKkMN+bZbA0t7?=
 =?us-ascii?Q?wXEmBArDY4w578516JL1gq4Ipf3tShtyKugAOWt3OxwTA576J5DVii09hUr2?=
 =?us-ascii?Q?BOb1gNhVTn/4mc5Msyry4i2idLw1C0u74JDj04Qhf/HdqrQpkpXZuwUPYGxa?=
 =?us-ascii?Q?Hn5ghVgQHvD5I6GOrIGmIJO/mlVN1MabpHWmFO67UZLeQT4/YQIBUp4a3agD?=
 =?us-ascii?Q?iAfS6Uxmu92iik0jT3rFn1dbmvG0VCRN74SC977Jz/FWOqZLOHGB602x99Xv?=
 =?us-ascii?Q?KSECyKNpegwpXfqogyDzj3NGd//G7aWpt5tcL32Z9qWafesbgh+OCNHatHsk?=
 =?us-ascii?Q?XR27Z3h/Zh8pw++M67pu36LG2fUt/JSBRJwscUtu3P0BkQQo1ed5ClajqZ4X?=
 =?us-ascii?Q?25iLskxHkWdzZ1SaDfktYa1Wg+61ne5rfTBzeHmTklhuTcBqE09zO3kz+ZMO?=
 =?us-ascii?Q?L7JKj7R8/O0VOQEriyP9va88WXyT1V27iE45ohh0/09lEwkEG5bwpKnyhseG?=
 =?us-ascii?Q?vxWdGEKYlwfxZNBDyA0f5OF86MP3WIOL6FwWQXOJOLj/HqvLxOoOGVP+84e2?=
 =?us-ascii?Q?CEjaeDUbCaGvOCrpFAPZzIMn3jg9jZt4rLC+4wBZtGe10cmgzUeRpQVcR9ur?=
 =?us-ascii?Q?C4Z9kBwzo4nntm+R53MtA/9RO8fsIlJ+KzznrE22Qxu6KTJhGp4hgMLxaWXq?=
 =?us-ascii?Q?VEwZ1u9wdI8A40jR4ywBZUHhhMohAQpkl4TJrFbS2yMYjT36gZR9N/BeWmZn?=
 =?us-ascii?Q?wns6B73JvutKPcLEgiOrSBC24ibLuglbNkFKcDCEbSaIqVYy5XtLu5KirDo3?=
 =?us-ascii?Q?+/XRb0nXKqQogDKYVGKmRpuS+R/0jCk1OEf1uklkSk7AZHIP5hDrJ1488PR9?=
 =?us-ascii?Q?q+vrUJfMp4BJG9uMz37EV3ZT3YLzVJgUIdYpBzmGWB3Nam9C9xCdI58LB5uT?=
 =?us-ascii?Q?mAWstHodrTERbcORwvOYkqCGFCULGZRIIV/pAyM6minz0rfkPaNDRvKY34OR?=
 =?us-ascii?Q?d+nbeXDfl+sI9m7DkbP8CjWjfFEwgTGpDD2HgQBb1KTsg+KhLNUkRrfgirbK?=
 =?us-ascii?Q?VVhtLeRijN5zdD1Q7ijdAcfGVZthG0/DEh3EEbkzhuM1/+AEwR9sxWoT2xFs?=
 =?us-ascii?Q?zukQJbmxVnLU999eI2N3+5HrfIkCR3FT8triuWOg?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 365e2163-955f-4920-677f-08dbdc9ce8f9
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2023 18:44:28.6656
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JegVMz2zMK9JMrcYGGTbZS88ei81UOFpgJy+9xIq/afHGrRa8JEJNwsNjEguQxKI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7369

On Fri, Oct 06, 2023 at 10:16:18AM +0000, Vasant Hegde wrote:

> @@ -1380,12 +1396,13 @@ void amd_iommu_flush_all_caches(struct amd_iommu *iommu)
>  /*
>   * Command send function for flushing on-device TLB
>   */
> -static int device_flush_iotlb(struct iommu_dev_data *dev_data,
> -			      u64 address, size_t size)
> +static int device_flush_iotlb_range(struct iommu_dev_data *dev_data,
> +				    ioasid_t pasid, u64 address, size_t size)
>  {
>  	struct amd_iommu *iommu;
>  	struct iommu_cmd cmd;
>  	int qdep;
> +	bool gn = is_pasid_valid(pasid);

I've read this a few times, and this just looks really ugly..

Something has gone off if you have to encode the type of invalidation
to do inside the PASID.

I don't have a good advice for you, but I suspect this is a
consequence of not having robust datastructures. There is not a single
handle you can use here to refer to the thing that needs to be
invalidated.

I'm not sure unifying the v1/v2 flows is actually an improvement in
clarity. In all cases the caller should already know if it is a v1/v2
object, calling a specific function is not such a burden.

Regardless, don't let this remark discrouage Joerg from merging it,
just something to think about.

Jason
