Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2087.outbound.protection.outlook.com [40.107.212.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236EB3C07
	for <iommu@lists.linux.dev>; Tue,  4 Apr 2023 16:20:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mfvxo5krEaqgP/HBQeGe1c4s7fn+zRzyUWz5+KQwqITRes82Dbaj9pkDezOt5EJzdwkOtlIJUlQkbOez2ZJt4do6eN4bwjbY/c7sy7dDUdZJsNspM163C30vAskRfCFv2aKpDDjPsE4P1cCUZLHzc9MORo6yt/UI7RB8j32KgjhEQlyJlQISRvgQHU2LPOaP2gBVTwy2SkmAdVqLP5VSR5JlYt+obxOo7d5hcPEoihb6n9viWOQKVPCZX84cI4GNhYcMGw37kb+3mVqIGthVggH0kUfj4KP1EYZY5/af6tqBt99NwdLmuKKRgP5Dh9QVi03ss6fl/Wq6lzwHugNlOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pOrlGrNKB5wHA90IvHCZRLKq5yI8pmIbCFjc9J6keyc=;
 b=NOaSOhKkAHyWuXfmc8YJyqRdxmAvJKwkmJcREbys9QM+2nSnn68xjMq5Hh6Nrgvn6BocWfQ3izYtdnDErkeMRWmQiV79FZQJvsXCEcuv5pgLBIhNshzCBmtRekj7IgEzMj/mRLizy8IXQhB46zIqiGPKnXS0fztyhexCCFHMEyQyhOkGzpzpO604fSyB0BHoEYae/3/uLkHm7tp6WggzRVbzRhyLXFl6WQ89pVu72KmgWKIP+psl7f3t+Ph064rwrIhIQAFGrShhku8CXP/zbQBwR0rTj13ii2sCTZOMwtJwFp5fgfX60IDQo7dK9sH7j3aGSuiLZQHzr2maQJJUTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pOrlGrNKB5wHA90IvHCZRLKq5yI8pmIbCFjc9J6keyc=;
 b=jw0WzrmLiWQ5i0xuPJQDRgqdEjNwPF5PtAMuR6OGYCvBwPXRh8ldtNoqvAHguy+FBtCDj2P0GvUBm4Q8TFuTOOxa2ZehrnE8BgLy/mth+PBRmQH6SIpGtoDgOw90HWu3w2VzMdsyWNRwvaaVK/kY0lJH+JHel5pae13m/sFDFozQ+b4csTzizWnLafYDJxjkeXogQIeA4Gn3Jw2KzRBCUqLjd5OydH5Ew32A00uiRybg9CaTRm7q4BlLLShmQ0sXQ+lJ6fOsvCV1BWLhDYImB1iBT+fMt8Ymp7w0Qzz1Oq9pMAJ8rQciUmXZrcjBirZnTOml/+6uokxeIrSYSEOLTQ==
Received: from SJ2PR12MB7865.namprd12.prod.outlook.com (2603:10b6:a03:4cc::9)
 by DM4PR12MB5056.namprd12.prod.outlook.com (2603:10b6:5:38b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Tue, 4 Apr
 2023 16:20:03 +0000
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SJ2PR12MB7865.namprd12.prod.outlook.com (2603:10b6:a03:4cc::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Tue, 4 Apr
 2023 16:20:02 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::6045:ad97:10b7:62a2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::6045:ad97:10b7:62a2%6]) with mapi id 15.20.6254.035; Tue, 4 Apr 2023
 16:20:01 +0000
Date: Tue, 4 Apr 2023 13:20:01 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Robin Murphy <robin.murphy@arm.com>, kevin.tian@intel.com,
	yi.l.liu@intel.com, eric.auger@redhat.com, baolu.lu@linux.intel.com,
	shameerali.kolothum.thodi@huawei.com, jean-philippe@linaro.org,
	iommu@lists.linux.dev
Subject: Re: Cache Invalidation Solution for Nested IOMMU
Message-ID: <ZCxOMSvR+6rYbIfy@nvidia.com>
References: <ZCoe3+1q5ZLJsmeC@Asurada-Nvidia>
 <ZCrd1wphkCp8uFt0@nvidia.com>
 <ZCrn8PPPyEJ/VqFU@Asurada-Nvidia>
 <ea6fba01-b483-94e6-8c84-d096dcb64b5a@arm.com>
 <ZCtpAYn76u499p6G@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZCtpAYn76u499p6G@Asurada-Nvidia>
X-ClientProxiedBy: BL1PR13CA0284.namprd13.prod.outlook.com
 (2603:10b6:208:2bc::19) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic:
	LV2PR12MB5869:EE_|SJ2PR12MB7865:EE_|DM4PR12MB5056:EE_
X-MS-Office365-Filtering-Correlation-Id: 8de71019-b5f7-4e4c-42e7-08db3528712f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8lqpLbwzi+YGB8EquTHw2gfZnXrQxfG0BqZgoq86OmPxPgvTF4qXf6CxBXBcAQwWT47n9/lp9Yn0a4oKxQX+PQvT4lNgFtbb1C9WF0kbwJEkP556zL8jDYsldIFnM2Fp1c8MmSYJENiim1mdBDP8KPkVG22PKFTeHu+rjx361Y2gfWO7C3wJrPGS2c5mTq7KwjSktk/MV7ZdVov4W5w5nuVKOLv82NP7mDbf+mJPUSJXCM9QcPKiANCb3q888tpKm+7MhMVtZtmGUZAYso5/0O/pTBQIbJQkAW8+IcykPsDXT4MMDlnW7BcADIr0sAvnve2rC78LlxerlE/eFPXZcWSwK/+c1MMT798AC9NLUwnSOzDZzqaGLDApE2/y3m62sg17EGewVy71hk3HCXQKncGe3uvp+Z67Cx4rLvYJQA7AWfMg0yfEM9tx5Sg3Oz7hsTrMITT9wOuCE0j4mehqL2F3bPBbt1oZoUm+icFugrv2QI17wEWA2PWAUCjm/4Em9X4DCQf83O0u4FEDoMqFfPfSg2EJC/qpn3t4wGNXpnlbVy+FwSUFTEJkKMMmpwPWdLR8XI8lNcSlYdxJZOtcKSHv5pTygxTExyTXVlAGFCg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB7865.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(39860400002)(376002)(366004)(396003)(451199021)(26005)(6506007)(6512007)(66476007)(186003)(478600001)(37006003)(6636002)(316002)(6486002)(36756003)(5660300002)(6862004)(8936002)(4744005)(2906002)(66946007)(86362001)(66556008)(4326008)(8676002)(38100700002)(41300700001)(2616005)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hTnFEHWugbfcyM6XHanhrsWtsc9pkJavTvvylouafUOU8itb7cnVeF6F2usL?=
 =?us-ascii?Q?Ukk2TFUIo2h19mZfKJifrLtHmbVpXxhO834NrindyAP5JWI19QNVjdx84c2/?=
 =?us-ascii?Q?ivyTS4JLByl/naTxwoV+r5JgmiC0EhLqntIOU2lcw2rkNqqR09lNEPgxQz42?=
 =?us-ascii?Q?VyDLkDA4EKGEJZMfGEFZ6VrN7KW60rY3X+QUAZpmGU3rHabd8G3x7CE3dKJ8?=
 =?us-ascii?Q?6R4w0one3VumQfXOaNQ/yT2ibuKwyrNcNbl/4e+4N/keKmmgfmEC7L88DMuv?=
 =?us-ascii?Q?cEpprEa5/wUegXNWpV9qyPuqBfdv2o8PE5AWNOBIuNQAwYssNJtfNk3VLGLS?=
 =?us-ascii?Q?/MIlmCGrloIZhkqJxJJ0jcvJbMWZMlNt8GQMkNYewRPlP1PgGJdxffxSxsG8?=
 =?us-ascii?Q?A+Q9aP4vn4BHfHRAxMGxp8Ghcww09hgwlTTjTzpSPMej7/qDh2nqSL9iquYP?=
 =?us-ascii?Q?4WQOTDJlN23sMavh2ULoygkAV2+6Err2RFEl5704v5IYXIDIx6AuxBjBr/8L?=
 =?us-ascii?Q?8a4M+fzNiMsdjuQnwXxlofWNZJBFhWc8eU65xIcLVpTamr8LcpU2Wk0wyHPX?=
 =?us-ascii?Q?j6ktq15HZW1+ANOMIZa19rgi2ut5CUghYJXbPlJH8NbTidulaZ9B4xS2lQ6U?=
 =?us-ascii?Q?wjIOw3yTQpWECQDHr2m+QFGJ/O+g/lPf4paPBpflgUSHi/HhPysQjHqkuyTD?=
 =?us-ascii?Q?OXHSOuNr3jFNLX38n8pHyaQABM4wd0wt93G4D9OD/g3ddUI2JC69xhkRwasZ?=
 =?us-ascii?Q?YkO69d42xF5aNyy5IC9hm6o0UksQjuagr4tU5Rn8+/HySqy6p5r+9APmudXW?=
 =?us-ascii?Q?yXXS2sC1YpKdx3zR5L1p42Szi5oYwhAKh0wtRSyahA+ymbNUcFkMxws4rZH3?=
 =?us-ascii?Q?eL6zuwy7DmIgbgD4yuul6DVRTXCDK5f1bptmz+bxeYgb20LOI0IKCWZOvjxN?=
 =?us-ascii?Q?jCfCM5Hg4Yqj43238sqN+CHV0kiht1rH42x6tYip3EGe2JmlZopT3gCoFzKx?=
 =?us-ascii?Q?stqQ4gV7aI3BCa2YsSd+dGjKeVpzj2cqHQKl8QRHAzVs9BxlaB5NsTrVqwoj?=
 =?us-ascii?Q?Ux3cF3sy/p3yopXGxw8PZJYApG5+qnc6XTFsfHv0zIU3eIAMvQD7rvoJQGD2?=
 =?us-ascii?Q?slLJZI8ks1HrMS1QBwro2OWE9hmtYVfBA2H+MTCzC8JUn2Gpoq3uoJgXJf/t?=
 =?us-ascii?Q?pglvkliyiEahAVLkox6T6D4guwmqGi3P3WOvJYdR/AC4enTD09F5LbUyhovT?=
 =?us-ascii?Q?wIPGnCcPP6IYPmSZDGdDc8ESv6Nf6vNy6k16tzzq1lndPjNT0C1Q50Wjk6SN?=
 =?us-ascii?Q?ZCRXhjAsHfGlvesXScfWpC3zJvEX5fjewIcUXQ+Dg0jW8Cxu/YpErJRMPZHa?=
 =?us-ascii?Q?xXxrfDAc45RwFOA3e5q4aVq06ZQpfwsPrnfbV3XIXyWrMWPQutFYr8ls9bIE?=
 =?us-ascii?Q?Ouwm3a1Og/KD9rFe30O6OXv10p+pBoYXIh5gIjbqMngCcmckrHKD44TpQm8w?=
 =?us-ascii?Q?FQHvDsAB9JsJE9NaktC29uqddNRjmJTP224G84pbO5k19eVCn/cvT8EuJFqE?=
 =?us-ascii?Q?lVGVTijBA+NGtMTRorc=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8de71019-b5f7-4e4c-42e7-08db3528712f
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2023 16:20:01.8706
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yWfgCgMQZanVRBuqeR+Sb5ZHL7euVx4iX95FsKxQoHo1QR0BdIMx4hGFZncTvTM9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5056

On Mon, Apr 03, 2023 at 05:02:09PM -0700, Nicolin Chen wrote:

> My preference is to have a mmap'd page, so the interface can
> be reused later by VCMDQ too. Performance-wise, it should be
> good enough, since it does batching, IMHO.

You can't reuse mmaping the queue page with vcmdq, so it doesn't seem
meaningful to me.

There should be no mmap on the SW path. If you need a half step
between an ioctl as a batch and a full vhost-like queue scheme then
using iouring with pre-registered memory would be appropriate.

I feel like this is a topic Shameerali should share some insight with
since the Huawei implementation will rely on this SW path.

Jason
