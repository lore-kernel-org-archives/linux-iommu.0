Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010046.outbound.protection.outlook.com [52.101.193.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAEE32D738F;
	Mon, 12 Oct 2026 13:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791810465; cv=fail; b=tqlgWujsEHyBvveN8ae/pmPvXlkQ/kUSICNpezROTcTFHSS0iYfJNABXqkA4tcN5qcaNZFK/ISZsVPqOdtgB6JnyFS2+pjNeYfEsjVpHR1/jaPcrsnqsCQVnaHGXiY35+9Vu6ew2AJvQcgSnwyarWpcdfhV+zgaRKd9+9So5Yg8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791810465; c=relaxed/simple;
	bh=bdQdtUs152P37h0az2qbWFE996hu2OkY4YLp69SIzMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=t8rt3SfYpn8mZe26otWawZmIwllS7398CvD/ekLMCT3CL3fDdQwJa9oKhBSmHSGG399PPxhM0Qsq5Xjsg3HNQBUS1lpnvTzZRQ1sevulNMTRA9XoJRkZ9dKytovMon+G9ZFmP8vr/XtWS6coEh22GMhTcrx9YTSxMY8rBumXHh8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gd42O2Fi; arc=fail smtp.client-ip=52.101.193.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gd42O2Fi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QR/E1Hu5Nai5vxr93RxFA1ZNHbpYfmyIft1x3Am1i1VPvV2h73mH3np70C6D3QY1gBVosRJFLiSDGCtz400vxRRVEjxDY/ipiI7ZVhEYL1D1XxDwwEKfecyBqYHQbmDx7FADra1DqZqRpHfZbpp2f9MPUQFSfU0PttF5BfxIe/G3vBwH6JQGuJ6/rR5FNYc83zQmlK1aRj2keMTrbDLDngXQmXluUtTFN/FlJZswIyq317Jt0PbHVuJ5nm5VvMQKhVeKDMA8nWfp906e5zr2LcvhzVQwvzpeJDxyJiOYYKuHr0kmLWNFZPbyxYRTGtDkj3C6o9C5IwmSNEuH2hZarg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bdQdtUs152P37h0az2qbWFE996hu2OkY4YLp69SIzMQ=;
 b=WEUarqDypF/x8m2oTSw86h6vPfPqhCGHnu/P8KRS4HGlEDSNgwITHgf9ZRKc4C+X9ZqkysZBFplbtGPWpSxL0u4tZzrs9mYpKRkpAXwm8a2mlYSpOhGHMDA+hqgdsW0OVaXZmk6zMYDmZpdeQNP4VtSJ2RhMUG6QGH2WHRV+ck1b0JAQ2KELgju3HC4ohJvhbZ+8GsYJeO8+7SgcXW4rB39NVEyowB/sCB1gjFv/FoQHf5Myx9Bcap5n6yvSwq35n/TAO8o3QgXoZ4zH5qNg6Qj51m+mNC1v48AZTlrNnk4lUC+ZRxD+iMfZI2T621wYnXJkIwwDoiUyTuacLf8ASg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bdQdtUs152P37h0az2qbWFE996hu2OkY4YLp69SIzMQ=;
 b=gd42O2Fi2MrSS9lEzbrrdOA9nQHWvcMG2koqFDf1EWcEXLumIndyMmYVuDd/g2GKcrgRVRdBXWyIgq0n6oBDJt5oqe8TizecpomhpKQBJmwhIueY0GndqHNcuVOcgN3NK3oZEvJg41xOcELCrGA+73ipSlwPQYqkpKV8NNW63HdppMFHVbKqk1meo5Munvj+ZQ50ZRh2sw/sCCZBnPpvaPP68Wppme5z/NnW2UJyaj+zXsNjdu1zSj535citzt5fXEtMNf+MP/WdKbCM9Uw3lQ3R2KKiRcxLqPR8ItvTGrr/YL7s0J+NsoD0SRa7l/+27P1kp3hQNOVfnDgrmTFing==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12) by SA3PR12MB177419.namprd12.prod.outlook.com
 (2603:10b6:806:53f::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Mon, 12 Oct
 2026 13:07:40 +0000
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d]) by CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d%6]) with mapi id 15.21.0496.015; Mon, 12 Oct 2026
 13:07:40 +0000
Date: Mon, 12 Oct 2026 10:07:39 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: sashiko-reviews@lists.linux.dev, iommu@lists.linux.dev,
	linux-coco@lists.linux.dev
Subject: Re: [PATCH v7 16/16] PCI/TSM: wait for vdevice contexts before
 removing a DSM
Message-ID: <20261012130739.GM13920@nvidia.com>
References: <20261008055955.4014342-1-aneesh.kumar@kernel.org>
 <20261008055955.4014342-17-aneesh.kumar@kernel.org>
 <sashiko-outbox-163687@kernel.org>
 <yq5atsmr44r6.fsf@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq5atsmr44r6.fsf@kernel.org>
X-ClientProxiedBy: BN9PR03CA0639.namprd03.prod.outlook.com
 (2603:10b6:408:13b::14) To CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CHBPR12MB731189:EE_|SA3PR12MB177419:EE_
X-MS-Office365-Filtering-Correlation-Id: 48c0180f-08f4-4ceb-a7c3-08df2861cbca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|4143699003|11063799006|56012099006|18002099003|22082099003|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info:
	phG1H1w69fWqfWD83Lbt4yJDFmSg5QCst4Dr4bObyevLrWXFrhSr1vziMHMm297f4wD5GqioYmw82t7pqbPcSToQv4i8xBej5pb7mfvXUHE3fo2XLq+3rlo/Pu7N1z3E+sq3SDIFDy97Aw7NovFQL58FbChoUohCNgwpmMkiVwpJdc6fm9NFFQ89OlcY1GtXX09ZiNSOl2Dn4uKm31gwVZmpGb8K2fHvXwcVAip09Xu8+ZOcE0kUb3Rgd5GebuIj+HciTQJ/MGvwq+H7NKsOnNZWHZsPlLf+0T12mlE0c2xQiBwtzUc5O4M6zunACjRmSV7aR6fGkwi4/65yOZUibDdKMuGFA1Pu0n30XWZUOxYTZ/cwrc1GNRNgVBtaZA7zpHrVURJRbs43I3rfVV5xkg9hPoWYf7OqktTYD6b8ZwCRt3DJLq1FweseEDwp8E+YeAVqj8Vx0b/wuBAI/5prIiHiboh65s4Wu6DhnO/M+DjfYKKpaXpBZfZP767Fmuf6mRYddjnejy3lXLts9hEbXDbSfbCXM5fTS7okOL//zamD7tUYdVbklMQEpIrl2PG6svprnqJSbsc2h06q13YA3Lj18pSiZP0w1X06Ag7zndEWF7YW6pt92BVSp5rqxwFSCHX/wgcsJCyIAK/megWAPn09eGR+sBx91SuV+8Wj22A=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHBPR12MB731189.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(4143699003)(11063799006)(56012099006)(18002099003)(22082099003)(6133799003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lHSDPGBuiFhrQ+t434OhWa27xhGsPONW/BrkrZhj2Uz3SghiMqpGapbs8Z+H?=
 =?us-ascii?Q?C3Ha6DGNSBtqw6njwxIuEwF+3aikRUpKqircsX4nXEdiTNsIz1cWz0QGGvxO?=
 =?us-ascii?Q?KG6eFu+YjK9keJC4wVkO8Yls03wi5cUZqeEXIkmO57GaS+98mW3LDTKFE4/a?=
 =?us-ascii?Q?fA/2XgpekW6SSDvXWItlsHlWyD+sx2X8lXX4f6WM3PhYFvOu4ojEt9YsMwFz?=
 =?us-ascii?Q?BIG5xPWC2NT/KLsdNubau6iOQarH4Q6uQCkSzk8JVMVaGvv4nj8Frf8Q5Ue0?=
 =?us-ascii?Q?GmPIT9Hp5QvDR2U0voyLAYKoG6eyJVC6V8utV9Gi/Tb/GRwj5PqOxWeoovfm?=
 =?us-ascii?Q?Vh/D3ihM0+4OagBRE9gFf5mn+KK/8Lyf6upXtSH6Jca5Ov97BLXjPB0N08BT?=
 =?us-ascii?Q?LxM7EL21lc/GGx1pBB95oxHff8X7Dyaibncd5bHQ8l94Xke55sn0j+aZj6tl?=
 =?us-ascii?Q?s1cjXcJW3qLXJgZhicPQJx3+qETZkpPXzZFNfiV50nLi25a6izxvRvwAPBOc?=
 =?us-ascii?Q?ZVgzgAm3xEOI2sQkTIT5ulDcjmkRYjVSFaLoVqxJ0AtYTIAEn4BlDKuxqWjw?=
 =?us-ascii?Q?APILbrwqbkff4iHOm057YM/jEzgRZhIB8SSZiQuwaBSUafLiwc3IT6BGquSl?=
 =?us-ascii?Q?NWDAONmrr3yExjwogUjIuvLNayNtOWkLIjsLa/DqW5B3o5VJ0eG2ZAKf2L4U?=
 =?us-ascii?Q?2GV9AxYyw1OeT5Pz/BrSFl4YHP1zBiKKfdd2ZTDDr0V+kOvflslJSgB1n4j/?=
 =?us-ascii?Q?sBIyZI+ROuUnPtcjMNgJooFfFzwgVHr8LcrbOIuSYKyQcQWJUP+fjl4TSvcu?=
 =?us-ascii?Q?UB6cwD6H7lh2ZJVXTW8rD0WUmX7bm+H8RL1HbHy+9brSM9Om0V8XQky73eq+?=
 =?us-ascii?Q?9gnjlCgJI+0udeNZO/UGAvgMKKqdB90ZU4cm56jIqabgn928HLFGb32zRzre?=
 =?us-ascii?Q?pMbmKDQx6wI7BmtcWRGxyRxLnvOME44YP7Rk/zNPOTqTHqPb7WghfHCy48cY?=
 =?us-ascii?Q?eZLCuknG/bs0KH/XX3orHStWM8yBCu1t1P8dse3xCQTlT84bhxe6TVvD/F3w?=
 =?us-ascii?Q?5BBJsdai0MPXJ5QtFhpRRNx9LECNWN+CnhNhBj2q85efaOTB+ZiGfWp7L5rn?=
 =?us-ascii?Q?XLzqmImuhAxRjk32QhFOBRhC5IFMrP1X5rE1jMqiDRcFq3V4D+bADD+Elz3w?=
 =?us-ascii?Q?TE6CG5y88zA8F5uZCe87dFn5q1hJ5sGyDkO5IARqTRr7xudWHZ01Az4m4xqQ?=
 =?us-ascii?Q?TS5TrgVhUMftqzvKuJT7ltX86XDlaPgJuP1VYNEHZIgCJJO0wdx9xCq2f6Ri?=
 =?us-ascii?Q?U6NGzf0KNKfMCGykl9VZXKL7emv3WjtuNumtKiZfePNPl4bz4DKfGMuAxEgO?=
 =?us-ascii?Q?wK1ja+ZtYQqpnTlEBKKJGoRJ684tWRUK+3K+7jxTjNoWkVRFymITmPtAIMRj?=
 =?us-ascii?Q?/vcM0woqd6BytKQpKt7M+7YnJ3gs36XNVzTqA4lDiXLJBkAjSiyA7tPXk07+?=
 =?us-ascii?Q?TJhmgVORBf6sXd7wBKI0NF44Z6GogUG8X7WpNYuJ+4Zj8AoL8opZ8XpqzJ5r?=
 =?us-ascii?Q?zP1QRqXW9IiKcSEk3jpSJDcC0mf4LRGRosQJJsAZljVx+sdSIOSd7+WMqEDt?=
 =?us-ascii?Q?IgNOg34ITSBn8WEPpiVrv7euGB+z7XDNlxm3wmBsQUnnzeCQmBjEO9HKu+dH?=
 =?us-ascii?Q?RT2SLzn3hraPwScZFMPBKo2BrjRFaHi1EANUV9zGTyaSeOW/?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48c0180f-08f4-4ceb-a7c3-08df2861cbca
X-MS-Exchange-CrossTenant-AuthSource: CHBPR12MB731189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 13:07:40.6698
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Agc3VCPW7S2tKfm3qvo2Tv5ppfMvZXItHEPqiGX9vdMRxB7257K0zIp4uLhr8Cjb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB177419

On Mon, Oct 12, 2026 at 03:31:17PM +0530, Aneesh Kumar K.V wrote:

> With this series, vdevices hold a reference to their parent vIOMMU,
> which pins arm-cca-host. sysfs unbind is disabled, and the SMCCC
> provider device has no hot-unplug path.

It probably needs some logic like vfio has to prevent unregister from
completing if there are active users. The module pin should prevent it
from ever triggering, but as a safety precaution.

Jason
