Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2054.outbound.protection.outlook.com [40.107.212.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1F9364CD
	for <iommu@lists.linux.dev>; Thu, 16 Nov 2023 16:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="unxeadZl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MJk7NODxncvlKb3cOaGcoOGi9KDziPGe+nGXeg0Ni9Jq3cKCcoLbp0vUwTBQZ2Tai00f3TSWyJWOLSql+INquKsenD4Yae9a/e4aB1qgfwJXXz4aYMpwsYnYF7oguI1trdLCSze7u4MZ3PX7W3n30PLV5zQLIgmTZO00J2e29CeVYlwHD3y+53NFOGL/BK3TU8ScwAwH218TNap7U1W6U+3jzGwWUAqpmsOwq7kCckQs/oPGVUf/GDBp8ISVSgTTTndAoSTiwKQn5dSqHoS1T/lKIgG1PRkf2nfVkqasYpV9h50GeOIFtAzbSRz3y1aHKoV3JFoTHFdN2BBKEmUYbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RaqMFKzuV8h96pKLUQ8JSNMPLwPQt8oRLxoFNd0Rlis=;
 b=nTYgfWaqeREKUHXC4JzTF4nyyq1okoK+cSN0xlnFAXzRypzm7SmHB2iJSL+kelGJHUOuTvEwH2jImSPXGXvv6a5DodU/8ewNB9V7OBKHn4GS8uA+bx5/3t6DfX2l09vF6n0Dn3XRfLlg4QUUN2XWOZFGMVkmOnroEn4Slm0CvRmetV9GyomxWz0O0c8zXirNlDgB1VXrRjh8wyLAQcVngmDhJWrrfF9yj7wsRQTNH1IhbCrwge62ciZ6SJ3m2isAmuceGWvrgSlYJwhgsf8JaLVMShOva7FbXIE3b6d7/LTio2Br1LqzMo7Z0oo7whrQNRnP2ju6Y0suG6OFmmSFNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RaqMFKzuV8h96pKLUQ8JSNMPLwPQt8oRLxoFNd0Rlis=;
 b=unxeadZlhwA/BjXCr8twPhs02kL7TD2u0oc3g8QNtmN2hW89l7R5k3WhJNh0LFO5rGzj4s1bA3d4tae83yw2QqExkBta/q/Ao0vUIk35MP7rt5LJb+LHLCdgpcnqA7Q6s1pgUSW907O86Ap19r87nk3YsPjfp4LgSi4VFN3Tqtd5oLMJEU4VZYzaCYyFPzLjociuaFV+7bh0KwP3qikYTxnBVjArYqum6pN2z+528O7dXtjYoR7b2cDYL0cs7ao90ICpkEd0cJNSSFaLQFd1zX+zu5VfdGbHiNQ/UApVQsvpWFtOX41iqCB1Ez0ShP8lmLahFWxWYOJjj2sTu4G9LA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SJ0PR12MB5487.namprd12.prod.outlook.com (2603:10b6:a03:301::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.34; Thu, 16 Nov
 2023 16:46:58 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7002.021; Thu, 16 Nov 2023
 16:46:58 +0000
Date: Thu, 16 Nov 2023 12:46:57 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Michael Shavit <mshavit@google.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH v2 12/19] iommu/arm-smmu-v3: Put writing the context
 descriptor in the right order
Message-ID: <ZVZHgbbey+zao0Jv@nvidia.com>
References: <0-v2-de8b10590bf5+400-smmuv3_newapi_p1_jgg@nvidia.com>
 <12-v2-de8b10590bf5+400-smmuv3_newapi_p1_jgg@nvidia.com>
 <CAKHBV25W3JoJ9CnX0+SWjtYauSznSx35KKu43X_9V0MWkBJC0w@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKHBV25W3JoJ9CnX0+SWjtYauSznSx35KKu43X_9V0MWkBJC0w@mail.gmail.com>
X-ClientProxiedBy: MN2PR17CA0002.namprd17.prod.outlook.com
 (2603:10b6:208:15e::15) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SJ0PR12MB5487:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b10a430-d5fc-4f18-cc4e-08dbe6c3a622
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ejc5wau9CzlHmL8T16jn5lforQm6mtlImTscUfUwzvIC0TdwDj3EjqPTuJnDJ4h+ux7etuEqAy96sZDtMA2QYbhXwZx/Z6+mIXVneEto46KejIxRp7iSw1/bdRQeBQUHzKzhE/dFcvaOANxDgxFrW1uTq6cE6he8PpIGopmp9HArJ5bB5OBFsNIyvZOSj4PqZKS8o4zLsUVBFoDIhFBkQOcpCdNu76whjLRYm3df4awYZftwoDdcrF7UfnmfjeySYFA5TbcvSm0ubf36oFzs3Ty3Du0NOo+jXS73W3+nNapICeVep9F//wvlnRthdGLLzTC9nWydYPf3RLcyedqx5N+DED1Na17Bqx3J+vSrRHSRuIn89bU/ddfia5kmt7wuWcAjRSaXtFZl6nmYpnXiHuLJZTjhZy/khIa5gGVsaf69rpwgMslH0rkD8Y4cyIckXYCu9eXFKKuP9E9Ei4Xpx+YT1CaNA0W8N6u3YQtXXiYzQsj58tCMwNjaymtvtohXLOTIdVSRutOhoqo5+U67QV9NxM1jkzjVeU4s7v22NGnPpZqrxSolY26Jvt0zAvPGpNn639cReVqMRnJ8ZNHGDpehE/OD3VYR1u77aW3kI38=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(39860400002)(366004)(396003)(346002)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(86362001)(6916009)(478600001)(8676002)(8936002)(4326008)(6506007)(316002)(66476007)(2616005)(26005)(66946007)(66556008)(54906003)(6512007)(6486002)(83380400001)(5660300002)(2906002)(36756003)(38100700002)(41300700001)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AE96ZKQsKxLsDMwGrrXHQNSXaSQxumWE75DSvLZWa5YG3O5SzyV0H+R8PgC1?=
 =?us-ascii?Q?+Yo7qxGIdYQ3UrxUtB95y3C5uAmgBfSCIRqJglAAYFKFNtB0k12E4P1TdV0S?=
 =?us-ascii?Q?oYnhR0hI59n7MFfNXCxcaAqUS09yUiT0iiAXaFpzNdMwTE6yk2Ytyw0qoWTd?=
 =?us-ascii?Q?K8Usa1jiW76XZNL+oBqcMmGePue0R2qjytELxXbCd4ViWd4RSdWi8jNqw0UQ?=
 =?us-ascii?Q?akEg2BSYlG3oVvBHVrQQUmrZNvR7yduUv8c9iW0CuvEsFc7VKor9x+Dgh/FO?=
 =?us-ascii?Q?LcRU7GcxStGiu9PScWO4r8W4e7dCWztUc7aJ9+3iz/660F1PvUegb7SCVlFE?=
 =?us-ascii?Q?xW4y2qbno0Q5SCThPabzoWPPgX2bDdNzyB20b6WXcYZvNMZewYLpzth+feFh?=
 =?us-ascii?Q?E13TsjWPAJvhVRw0ppzmLa5uXFPR4jQj7+jV40iSw5QDaRqlLCLy6Dbv54jG?=
 =?us-ascii?Q?sH51uCHoGXtpvmLEU5k6Cr2oqhUXuec50yWF6lqeNeXLxSub0O9RThVqv6DR?=
 =?us-ascii?Q?0SeKoS5o9hQLBNm0mADqBFP0YchCMfplBrd1u5wnWtFRkOvoch7WQV+dAQvK?=
 =?us-ascii?Q?K2K9DMWIhhoraGuuI9UAHrD186ahEpKNlo5qDO8nTw+XNbO4jAFOiHJeIuzT?=
 =?us-ascii?Q?gJN1BWTVLh0sw6+Xooh+isX0qYUtpBJlSXyNqSuXQ5+WB4GZZu4mekP2blvO?=
 =?us-ascii?Q?aJq/SSOypIgn8oxJhcmv947LwfAoIyoogVTHk+f0TF3iYcEumOjmYKTkpOmV?=
 =?us-ascii?Q?S3TFBUcUn2jgrjUc0zxPdFKiwDzldcpCzqaf3W05Kv74r94Xr+w44I5nDZsM?=
 =?us-ascii?Q?hHFJ36iqiIrhPeOaTAD+EKwoEffu5HeqBUw1E3ypYQWyLFVn1gLrbswbCFTo?=
 =?us-ascii?Q?RHzXf+ITx4Ia1L3rhKCEIK5LSngH/MdqODriEQ46+UGypnJhcxp6jkm7daSl?=
 =?us-ascii?Q?jSZAnfy0ALff5Wis9ImdQdIPvuaPn7L/3ugX7xcD6/BMF6MVvQn6CGGNd/Ts?=
 =?us-ascii?Q?vXP2fI30XtIppBnraVN2ZCpxA/+S4+EWMys7WgdtANsEBsKCPYfhRGJJE3ne?=
 =?us-ascii?Q?RsUqV+aFgNy6wK+Daochzi9BeIUI6WUnlGAFIqDVb0fNfFGQ5I0GNRxSflgZ?=
 =?us-ascii?Q?6rLwVSTXTLmvBDefY9VH4r3TwXbvTq+Eb6sAzDiinfodFko1EQtXCfw4ZWZQ?=
 =?us-ascii?Q?I4tFxOQdmPA1Z1olk+9+DldMx2E4wSs5FnPUv1B3lI/Iup6Jz1eDWx08kaX3?=
 =?us-ascii?Q?qNhszRdTdwCrbwCEjKrIoNimA5gzcRASj4Dci4cIYymR0xoQycxR8C4DOk9O?=
 =?us-ascii?Q?n/Ws9dhcno075EMkL+6hWS5ZiLUzEn4TnmfBe4+6LaSgcNtB/WAfgfUB7g2p?=
 =?us-ascii?Q?ly6HFqMjkqqGU39uDnVJT9dPS4AeYTl1p0vugHgpUplv/8NGgBdUPghIoFWk?=
 =?us-ascii?Q?kTbpzPcA4997GJELxurDepjyauhxsiMV8PUoik1EhnBkrXdhqqhJpMhCHgZ1?=
 =?us-ascii?Q?jO2cOOISuutrbYpEWKOyk1YYH203GbK7PfeC0mgcqEg5a8glkXU9z9jvEvJh?=
 =?us-ascii?Q?Irk4G+xziBaboexLsyuxYD5TVQlvY/BFZWP7QZPp?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b10a430-d5fc-4f18-cc4e-08dbe6c3a622
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2023 16:46:58.4797
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k29tD6jq+ffx8DDJLjK/c1XlUrJ/2b2imAMEDtJF3uq00yDFx6XOpEWl9M1Z0PeK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5487

On Wed, Nov 15, 2023 at 11:32:28PM +0800, Michael Shavit wrote:

> > Lift this code out of arm_smmu_detach_dev() so it can all be sequenced
> > properly. The only other caller is arm_smmu_release_device() and it is
> > going to free the cdtable anyhow, so it doesn't matter what is in it.
> >
> > Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> Reviewed-by: Michael Shavit <mshavit@google.com>
> 
> This patch might be a better fit before the previous one. When going
> from S1 to S2 or bypass:
> Pre-both patches, attach_dev() installs a NULL STE, then clears the
> now unused CDE, then installs a new STE.
> After the previous patch, attach_dev() clears the *still used* CDE,
> and then replaces the STE.
> After this patch, attach_dev() replaces the STE, and then clears the CDE
> 
> Reordering the two patches removes the scenario where we could hit a
> NULL-ed CDE.

NULLed = non-valid

I see what you mean, but I haven't thought carefully about a different
order so I'd rather leave it..

Regardless of order the two prior patches will have cases that hit
non-valid/abort STE/CDEs, each step removes a few cases.

Thanks,
Jason
