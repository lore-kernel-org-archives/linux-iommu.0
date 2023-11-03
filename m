Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E478E2110E
	for <iommu@lists.linux.dev>; Fri,  3 Nov 2023 18:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Z4B8iVBG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XZfcBJoMVKWcUS25xzGbHbI6UdaItbtztll240dYVQv17pKe4A13v07BVX7BOFCoXyXU1Z5XVIFxuVw6oi95arVA88RQzwHLsiOnLMHFUWEKB91obvKu6sZ1MPddJftacpdDeKTQL6NIbIr1EN25zmxK/wEpj7OPNhdvKbQlg/yOuas/QuKV0yMzRyOm7tZS3iiQqxUwlCCmS3P/Yn8kR+3SpYpWKGziBK3MOLhW0ZozdO9ZGdGR5wFNBE7kAYM5QXvjFE1xSDfsqHvg7lK/G+wFqU/BEuejixz+RXCXGZIP4RfG2TwPYnwJu5dC2Q8kQ7KlHAiG0EKV/htKEdYfcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F6KHvKTOInGyz+pTYAnrOMN1nlpXRN6uoi/szVeiwlI=;
 b=ibIIiz9F17ZMVp82/8pOz3bL+6Cp2EN2IZF4oB0kzATC6dtyOPSNTpaiBtcTrygCNFbNfuJl5gY5HYDLmcsJnbwKgzXBvYRztca+RBFWNU/AJYXNfxYqOtydNJzDx1Qv4DqOaZg9aUDpP7GVrT4en7NI9mKemWUBh7SXd0/njkic4n114VuLog9EdeAlqeouAK0iI6V+eeOoq5oWgXBXl5/ItcOyP9wOutticcX/vItLZ8imSpilUMnfsDo/zsrsDMzf4mMNs9V9GqnoRFoqLv52U9LebR+5GRzlu2mVvaqT9AURvRAotXgT0eOBnyEAPFmnAta8FXh07Qh4zPoStw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F6KHvKTOInGyz+pTYAnrOMN1nlpXRN6uoi/szVeiwlI=;
 b=Z4B8iVBGgr/hzRSmZitC0NYFMLZArY2Q7i8NJo4hjJanXewKnjnqFvOJWOuOonYDTi63MNV1S6tv80Y4tymoFAC6CApdObnoBEO2InYDi+Nu818o5fbMpXizGOwM4avTW5ofxxLmuiUEbSXHncAZxguZzy8/7Of+MajTVLRJNVSl4fikqd41XGVeGAo7gGi+rvtEQDDRkaBvbYaI76pEZPZZ8sm7JrfWyG3kVbd73I95FqoeEk6kBy0dptaNCPVK4FG5W8x9jcklbLWlpAojPKi/8YT4wIyUKqjO0eUvIYEF73ey1ED91fE1jYv6gRYUuWjR+c7b2Nyq9ZO0zpP0hw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM4PR12MB6133.namprd12.prod.outlook.com (2603:10b6:8:ae::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6954.21; Fri, 3 Nov 2023 18:09:32 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::b53a:1092:9be2:cfb9]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::b53a:1092:9be2:cfb9%4]) with mapi id 15.20.6933.027; Fri, 3 Nov 2023
 18:09:32 +0000
Date: Fri, 3 Nov 2023 15:09:31 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com
Subject: Re: [PATCH v1 02/13] iommu/amd: Remove redundant domain flush from
 attach_device()
Message-ID: <20231103180931.GB223197@nvidia.com>
References: <20231006101624.5912-1-vasant.hegde@amd.com>
 <20231006101624.5912-3-vasant.hegde@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231006101624.5912-3-vasant.hegde@amd.com>
X-ClientProxiedBy: BL1PR13CA0345.namprd13.prod.outlook.com
 (2603:10b6:208:2c6::20) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM4PR12MB6133:EE_
X-MS-Office365-Filtering-Correlation-Id: 906e8b9b-92fc-45c9-8017-08dbdc98079d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	gHW4Q2uIP0xhWKMzdmfhUQTRy4dfHiecjOWJRfTBz8nKhiur5Gj+QqusND1x/t2Zp4cOHkN3RB2VTYb/AqRExJ0hEkNvS5Vp4EvBJt9k/GiQ2bQyckuZgNvFJNlcJ9PCA8LaEBRyfqTRDjRlcXSqQevmXvLgX+NyG0KeKaLhTu8w+Btp5vLYdgIo5B9XOrkLnjP2mIX2L8UUPn3wZ4bJPuYS+v48qHn8fYAeQe1889zCsRCLYwabV5F0tKlPJ5AYHSu406tzXDA9cSL2FHPp0nVyDD5QsASwqYsBoi5PeroFAqlRXaeaw8cjsBoeBC34IaPv1gHb0vzP2fd95XHM0zUwaCovjqRORo/92cLJemUaxKASIbL+t23yslPI/VJMd3nm515uVpBhnAlPLBR2oRFnCK3uJSUustK50HXgclfulXG+02KfA8qe9m1mZfsySF5HDnr2k5AvqzHpcpgM3+pljkfoS41bs2/RMaN6GvJiIhWpm5Nh99aHc6Ni3Pvj/EpX1Sx1jcAWvrEoLejy0Fe7ysAWMtnOPGqtw2q3dniSbey0U3JzlXOyZbrykwqLGGi+1OKLp7c6lRm4AO9gOPAdEgVWC+s7DrzG3fsREknmdjSVxRlG0yD+sO5P4nrU
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(396003)(366004)(346002)(136003)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(1076003)(6506007)(2616005)(8936002)(41300700001)(4326008)(8676002)(5660300002)(4744005)(2906002)(6486002)(478600001)(316002)(66556008)(66476007)(66946007)(6916009)(26005)(86362001)(36756003)(38100700002)(33656002)(6512007)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CHIhJxlCPY4TvjmTrNgOjFe/ilnHDXB8RAprkLU42oZr4dE2ragWSLV0XdEJ?=
 =?us-ascii?Q?ooYqUB1crr+Ylh0U3m82bdbbkiwve8ffneDLHNeJadxvZrmZojWrAn4CDP04?=
 =?us-ascii?Q?VVyIY/DLkTTQQpx5wFnjSbPJQM/sq2uH+TeVzmWnunnfqW4FdEMwCCeaT0QC?=
 =?us-ascii?Q?/vu3sM+GvQ9bdUYv0IO9yOlqUeSiiyNVpZ4K2C21qMrGV26ZAYsns5fVoZvq?=
 =?us-ascii?Q?XlS/ia78EsqlxRuEPbGSjw5kEEVKIC8dylK6HkN6fRre33SNGyBAwcSfkoDr?=
 =?us-ascii?Q?0TH6WrP7VKUMhzW+6dylFnU2vEcQDicpLASXTeWT5jw3eL1OpkcxJR9uYiXA?=
 =?us-ascii?Q?EJhEAu0Oa8/0OR+xlzeXokKc+T0REdUgapU06nR29jKucTphntknXjs5ROiT?=
 =?us-ascii?Q?Oegf5gTnZkH6oxz9WK3BXZliteW/uJFGt7TqX4YSO1IyzXN6iD6jFJ57ZqDA?=
 =?us-ascii?Q?AGcHx4CC5EvbL2HVI9Yg88h8TJBYNaFDohpjTV2TjIzZ/rsw20AlIU0GiOuL?=
 =?us-ascii?Q?qDfkwulauC8Zoi1oBuRIWcLrUBfvNj7cvMWDSkNYYvFmhZl3T3Y2cCK0if7d?=
 =?us-ascii?Q?djgWcwUJHppMjjiZ3ZF33FYUy+913r0y1FuDMUE4TBzPxoQo/k/np3UVjRaz?=
 =?us-ascii?Q?pq3sx3VHd4HhAo90fk2zcN8rSDhq+ttWV/rDUmbPajKYBcxwcfgbbcchhRVj?=
 =?us-ascii?Q?+ZxBMfgtZiPhSh2O701fegnfU9DyCqRsOVHi3UBtcXte4FblLAlX9QkR+sk0?=
 =?us-ascii?Q?sqeOIoGqbn0wv0Enllb5fIQW21NErfxmJGDt4c/g1pBVrk/OzmnoQ0yBgQVI?=
 =?us-ascii?Q?6FbjOC9LVLMGOIZXwFHmEXqBw3EXVPP4uPeX9MUG0LZZmpdwSBjt1lY1mYFo?=
 =?us-ascii?Q?7ljk5phGeNZoQj6W6knpPz5xXVwfeZHsIB3ma23zQtgvNZd+5LO9YOLO54Tj?=
 =?us-ascii?Q?4LRGqwrpDfKDD4taEIXWaVpp5QeIcfttGVRiQI4l45aCASVF3ZKE9VWTxOoj?=
 =?us-ascii?Q?jCJkHuI1XvLlZDppyAYB0MlTgvaKfCiyFd2d7kULMO8CVbIZjHjVtnDaGwOT?=
 =?us-ascii?Q?T0OQybaXJg2so4IgLKCyDhimvr7kPC0chz/XTp7f+qYkaK/bSYPcic5cripi?=
 =?us-ascii?Q?zT68E/tMGshMgFSj+ogbwKxCLU8lsCB34BDwCWu/nyxw/4LFI7mTagUu8aDm?=
 =?us-ascii?Q?m/Omcaw44bwNhSTxTsIzXJmCfeaMmzta2KBRtxqY4xMZslpCtJ9vqIOaZufj?=
 =?us-ascii?Q?DNDQmOOlROIzNEFNQhGxv2HXcU98jmVk1eNXIcNwjsHX0s26nUOK3kDporxK?=
 =?us-ascii?Q?+GmVCXR348iDlL9+rTlEu60ILX4LtTw2eNS3//FmiaE+rwqS0Zvgh2iFeHzS?=
 =?us-ascii?Q?9NsDx1WAB2prlnSNAEUsg7yMJj6bNveMPGEBgTyxYwyXZpv2kYkaKs4w11LU?=
 =?us-ascii?Q?wwoLGru3DEPL14rdrRhkgEPd7ew3AjmBgHM4ej8oIpks/OXcNan+IegeBLae?=
 =?us-ascii?Q?sP7Joet5xRtJldUos6cDG7ussJErOOi/vyFiXJu3nQI6e8uTgABxCJd+NOTi?=
 =?us-ascii?Q?53lCVmHvkXuYknsOA9FCjUrWfOW36R1y9iBkX7b6?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 906e8b9b-92fc-45c9-8017-08dbdc98079d
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2023 18:09:32.5909
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jFjmySF/SiiF0pUpvpaN9NmSWTyPwFlmt09yMOdlxUfQBnGYHerqafvKw/IH9Rxb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6133

On Fri, Oct 06, 2023 at 10:16:13AM +0000, Vasant Hegde wrote:
> Domain flush was introduced in attach_device() path to handle kdump
> scenario. Later init code was enhanced to handle kdump scenario where
> it also takes care of flushing everything including TLB
> (see early_enable_iommus()).

Yeah, this is the right thing to do the caches should be cleaned
when the driver starts up.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
