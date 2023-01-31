Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2057.outbound.protection.outlook.com [40.107.92.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A37CA93D
	for <iommu@lists.linux.dev>; Tue, 31 Jan 2023 19:54:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f67j2trpf3/pGGZWkXUnVhB21ToW++X3tA1gqsdppgH3OlQkEKbKvlQOsifNmID526MI7Rg8U32VFmc2XgxdGljUn2tYAvad/YFORzhUs2N18RGfd/2rG/sYgneBOCGO2IMXPP5w+8WFjS/4utNzRHpV8fyo6ifB2DKBa177giq/KZJOP4MGkxslPN0J3QNXNE5y3QTpkzzshazATxmWerQJ/7r59ZalBS9BhTayv/OYHGZj/30FM6h19uSjOk5G7zG6jUHLYvbuM+sEQVH3XmiIH1fjoZemAaIFdO6PlkYMSkUu+24N8z9PGyIthCk/NnpIK9zcJFACw7CL0e2umg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HvIoqcTikc1empkkxcEmMwT2lFkRQVnNNzbpVK/edRQ=;
 b=CqYCmFFWfq5TOep9N88Qs6sygQYscgQKiFutolRjtG1uOvuiirAry6F+BAAr+GnznxeoO7uAWKqPWyiibBt+47UXrfPvhFlW8fC57KdZjXFEPcCc7itaOI1OwdKD7kdY8g3OhRZvrsKyJRotWNyH+H/p3B3QmRMP5vPJDhXRXSrwKnOpQsoKXYaFUV+/F2su8ypx7RmMQPSLHcc6i/lealAwRLwoRLwGoy4SFUg0rF5wgrlksKCX+5FxOnVn0aP6s4WwVbBq/mSypxRhGLNps+ZYyOmg2FTMFnJXvnihxxfWVzG8ZV2Hp193jddkfGLAphuQjCQJcijVDECiwx3Ggw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HvIoqcTikc1empkkxcEmMwT2lFkRQVnNNzbpVK/edRQ=;
 b=exylRIw8rM9Mv+Da6+7P7br61+pZ7mHw7RgodWm63Rg3DotcPGwxxRyqfDNGgA/rBUY4URBzbocSW0RPt9b8air7FPbGOB4F3KXxMHbziYlGmWLEU2yddqZXZMt4Rjamyiri9qfKkpSimXp5rVZkcsHKgJ2uaIgG8RCHspwdqTFTM/5xczB5fthrAs/PlF3kOdDRarLP4LGG8U6faZx/5Kysn59w3vxTEDsYXrJUC2+OFzqoMIoxbUw8NwzT7yfUtXBK7TvuWSLAOrLa17OooekQImQuQYUtnN4rI+k+GzjuczDmjmOfIPdIgUhMG9dOEle8J7MKmaYGPW00mm5czQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA1PR12MB6282.namprd12.prod.outlook.com (2603:10b6:208:3e6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38; Tue, 31 Jan
 2023 19:54:54 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6043.038; Tue, 31 Jan 2023
 19:54:53 +0000
Date: Tue, 31 Jan 2023 15:54:52 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: joro@8bytes.org, will@kernel.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, hch@lst.de, baolu.lu@linux.intel.com
Subject: Re: [PATCH v2 4/8] iommu: Factor out some helpers
Message-ID: <Y9lyDDu/tLSX81Y9@nvidia.com>
References: <cover.1674753627.git.robin.murphy@arm.com>
 <959a1e8d598c0a82f94123e017cafb273784f848.1674753627.git.robin.murphy@arm.com>
 <Y9fyaRGp7Q8E5to2@nvidia.com>
 <01b0254f-41b0-2cbc-7d47-5507258f35b5@arm.com>
 <Y9gKewvVuVsrB4nI@nvidia.com>
 <5498680f-df9e-287c-03f1-020848ba9b37@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5498680f-df9e-287c-03f1-020848ba9b37@arm.com>
X-ClientProxiedBy: BL1PR13CA0002.namprd13.prod.outlook.com
 (2603:10b6:208:256::7) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA1PR12MB6282:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a856c12-ad77-425a-559b-08db03c50559
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	uBe9Niuo3qvDzyY2Yj3C1MlyO/oP4A09S+Pwrl2TjO1KGuBayenuzw1znoPmx+zOQZtCQaf9qp3fSNtbj4mH/iuGCBJl3mbd66xIzLbpsERi8QieaR5YtnK+eN2P5+l3HmdCzvY3rlLyTYoym9ZkfGSXC7gTWxtsMepi0lENqXZdVlpd7BayBupng4ebk5ArVlarSj9eJMZGzqIqXfbdKb5vIhmw/ADcDXZ6F0ZqfE3k3nONCheuX4LUhh7FVucPUxZs1M1tf2fchxdaZihaeckRf7p1E/YFD9g5/U74rg0Zt/gJ/JSfryze4rgAStG1xTc257kJ+kH05N1WkchgSOywPSBPD0NEqq9eLz7g/ze+yqeYZhID1nKFKTSum3ovnxHpSeYhCpNEr/7exFCfeUX1MuHvbPu0ohEStYDXDWB8crZ8zuIwyIX7FCB5ivgYlxDkU+QuYUNRKYAbW8qmUoK5of2XhgZPQBWIts4qiaashRELHYxhwanMmYlkhpPxToUgO1w1MzYhENP1drXrlc5OiwY4ALfvcL3dExL/4aIyMiw+xAEwanmfgUnRkX0cJd1NIj1O47YCBumyAWDtFi1jqSGpuNkAXcHvLu4L9BHJMgY4pfHCFit6vlRIVMIO7m9X8PoC9kyNawfH2jlbdA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(136003)(376002)(346002)(396003)(366004)(451199018)(36756003)(38100700002)(83380400001)(316002)(5660300002)(2616005)(86362001)(6512007)(26005)(186003)(478600001)(6506007)(2906002)(6486002)(66476007)(6916009)(4326008)(66946007)(66556008)(8676002)(41300700001)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0QeJpdAVZgS29B67scB2DpnM3aGMK9CA5eYeRpurXLkHADucGaCAuh6IIOwR?=
 =?us-ascii?Q?VChv4Rfz6bc3ENMS76s0thgp1NGJ3EredBanHdsxcNyVwNy2/dHX456Ke09i?=
 =?us-ascii?Q?/L1Rnho9fFZd61s850fYifL6BrrHsVzBIC2/Oyq17Eb2QYURUy8ZDk1es5Nz?=
 =?us-ascii?Q?LzKgGik0lqQKEaTCJ5QMi5tkxHgnm6HLRU/dpX4zV1cA/5cTQ/ggBRXYY7Vd?=
 =?us-ascii?Q?zzTljXEiUqOC5pI13zSGGKJfAWLZ/xc+Keuazw+9UiJqY0GS1PchpTlrGjDL?=
 =?us-ascii?Q?sBOqEn+rxew6TeIb/J3VRKHBixjnM4/KEHAVvMlkjgM7Ub/zHpGOJvfxw09A?=
 =?us-ascii?Q?KYMiAT/SVX83TPJDiVtb3KK6rH1iYe6pyZm547IuzEesMqLA7Kk/qCS970eq?=
 =?us-ascii?Q?ZwO1U+fVQib/Q5Piih/BSPpLv8Ggqk1z8TfVasMAjxlLmkB43B/r1KYrAQaX?=
 =?us-ascii?Q?ZNO575BQzogeEDwSaRLJVmgucWpjpQmgXek1dsAFqb79VI22UR/H6poIY+dc?=
 =?us-ascii?Q?9wnSuLktvSqO75LV5CE/mMdjbbiQkmhXpUnloUzG+ZyFy9/qtLxVX3YIls+9?=
 =?us-ascii?Q?GLCOUzeG2ZjoHzMRxSxFE/lbV+QvKmu0ghRT1YzkGImmqe3ISi08f46OKuNv?=
 =?us-ascii?Q?k+zvgx62g+dZ5A16yamtCmdF8M/RfWqPmzZxNynCGMTxBxD+qRM1tr7Tj9Rg?=
 =?us-ascii?Q?gJwM25gnvNNXXyi0lb47LRmAUFhS/dCvhc+B8w/ps+vQ6OM9YZx3LgRm16/1?=
 =?us-ascii?Q?qu/MCL7PeoxdpZXL+0ZPitHDpDX/2kDjsMmJdyLH+TAOkivFWUzMbwJECtuT?=
 =?us-ascii?Q?bqZvdrLbpln5UZJkLh15JjWea1OLOl07oN4tSfiE+vjacAsPQXbEf6MYW5ca?=
 =?us-ascii?Q?3bwcQprrEGvNvnPa/67S4CuT2B27hTTcl9fcEG3HDQaYHj+SFxsZmww/+jOO?=
 =?us-ascii?Q?+nONRQfZrBDXdqWvR5SR1JTwaM2+yTIK61fl88kzZO+WTPypRxERqkC5qajk?=
 =?us-ascii?Q?cZcd48/zGYyF/VdFq7VKMlFDjVhy/tWRqIL9ObuWgdKiXjnHRrUYIcH53T4N?=
 =?us-ascii?Q?36ZB8jJ+ll030mrTiZgcSkCFGyS/hdnesPIUwcxOyPInkhXZ3EpqADrO9UwR?=
 =?us-ascii?Q?OkaOD209XHjOyjtB9Y1+JuTZC62rkD1bK2COdGcp178MMRIgRoTtO/2jiY8b?=
 =?us-ascii?Q?70bYdlyClSLm72tj8vMo1X2LA9HELhfj7iuUbsHKORhPoZIUd4y2cgwkkfNr?=
 =?us-ascii?Q?s3xV5CVSY8VBWdRpSzEjlOIMuLzXtmlGQSBBU+d7XTaZER6NYkGoWw1oIEQc?=
 =?us-ascii?Q?wGdHnrVTsHG3Dd6QcxAkce8yV5jRPQhBoSwEYxtJ5mMwvIuJUGzCLI3uoQfP?=
 =?us-ascii?Q?SgQ/nhUNRke9jz5OutRXgSg6vfLpbiSDoGOqUTLvT/Knd4INtZ6PcUls2Shd?=
 =?us-ascii?Q?p6Gm6DI0QDsMcbdg89f2lIDFJ77hz1ogzSmfE/2Qp4WcEdrlk+9XPY+cC2LI?=
 =?us-ascii?Q?55vZP8fTHL7pxtI+9i2XFKMS5+3YzH8q+ouzWiA5kkkj0wvnu7bPaauU+hyw?=
 =?us-ascii?Q?163YxGPsTh6LZTES0VtD4fTRQwoWisnvI1u+6HhS?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a856c12-ad77-425a-559b-08db03c50559
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2023 19:54:53.8581
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RIuDBBvYSN5UUhsaYtjEHBznkZXQymyhkPUSVBetRTQ8czb/wJnl5ntbd9Px1jBy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6282

On Mon, Jan 30, 2023 at 11:33:54PM +0000, Robin Murphy wrote:

> Please understand that I'm not going to this length just to be
> objectionable; this is me genuinely being unable to rationalise your
> argument and spending my entire evening on a deep dive into my own thought
> process to lay it out and check for any obvious errors.

Sorry, I don't want to use up your time like this. It is a minor style
remark, if you don't like it then you should go ahead with your
original.

It is hard to debate style, everyone has their own viewpoint of what
is better style or not.

But to elaborate my feeling, I find this:

	const struct iommu_ops *ops = dev_iommu_ops(dev);

	if (!ops)
	   return -ENODEV

To be nicer code and more kernely then this:

	const struct iommu_ops *ops;

	if (!dev_iomm_ops_valid(dev))
	   return -ENODEV
        ops = dev_iommu_ops(dev);

In part because the former is a harder to type wrong and when used
consistently it is alot more obvious that the NULL test is
missing. static checkers like smatch/coverity will even warn on the
obvious possible NULL deref if someone misses the NULL test.

In general in kernel we have the API flow of call a function and check
the result for error, asking permission to call an API is less
typical.

This case is complicated because of the effort to try and document
cases that can't fail. I'm not sure if this is worthwhile, but..

Documentation of special cases is better by labeling them as a special
case, eg with a special function name. Think
rcu_dereference_protected(). Making them special by observing a
missing related function call is trickier to learn and remember.

Also if you rely on ops testing you are sort of forced into a second
function because the static tools will complain about all the places
that don't test for null if only one API is provided.

Basically, if you have dev_iommu_ops/dev_iommu_ops_safe then the
choice to use safe is obviously documented in the code and if you
mis-use dev_iommu_ops then a static tool will complain. Reviewers who
see 'safe' in a diff are reminded to look at it for safety rules.

If you have dev_iommu_ops/dev_iommu_ops_valid then static tools will
never complain and the choice to use 'safe' is implicitly documented
by not calling dev_iommu_ops_valid. Reviewers have to remember to
check every call to dev_iommu_ops() to see if it should have the valid
check.

Regards,
Jason
