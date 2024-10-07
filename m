Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2053.outbound.protection.outlook.com [40.107.237.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A6BD1DC19B
	for <iommu@lists.linux.dev>; Mon,  7 Oct 2024 16:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728320202; cv=fail; b=Nzdw50JcZLBD+5kmeKf3Y+M3C2s1DgTRMdDgONkxkAXzi0YQxCF82jAoxRi2EApEXMhc7PBIDNTEeWEwj5CSP51WV3xRrTzTlP2GgkTgkR7fuKTjmWYbtJ9atEGI0yaYR/nNyEF3UgiXWDG/O5CqNxqxzrp9CvTmaiGqTPSxuFY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728320202; c=relaxed/simple;
	bh=Nyyjon31U4WLy2Re5Ha0lU/mJz9iyZAEWj5yxzcIYjg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VmDbOtJ9hTenoWjdW7zVduDobSG671JbzTIOWYVP+gXgY85fNcNyRb9Tw5X5drRtQ2scDGSqGT0O30H62tmnVOFYlO4wN0woJ4Nsw6nBSVZFJT2i6yO/CwSNWy47Q9i3AZv8Atz7FFKguEH+Xe3JI0ACMsTTBGUXgH4CWWcd61s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BWFTRIPw; arc=fail smtp.client-ip=40.107.237.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BWFTRIPw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HpEq41NUkcDlIZu7LytkL/miw/oTvJOB0QFXQvXFOMOtbDedKrN4vH5dLhZvrkq8Ql2DIlljM2Xt7NpWoM3XmAXk38I4xVRJXrTXsh9PULQHV0oiFawUS2AXx6c0rgzPvJ9bgrSx7pOaDHpe0zKc+0OzQzM5YaMH1ocM5EN9Fxqdr5tQfrgJ5TvIXOa6ZcZlZg3FN+0ZsDW+Tc1blQm6azS51AqURBeeQgrl6NEH2/OHgr7rKQAJKf7XYwF7zy2wtdITRZ2E1GxaqSwqwL9ng7ZGd8hneVd1rWMz4wR0XTsfNwjwc0e8ao7I+RCixv12YELbbZn8oXmqqgqijkxHyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nyyjon31U4WLy2Re5Ha0lU/mJz9iyZAEWj5yxzcIYjg=;
 b=vDfvQBXKUL2hRFAXYEshBKp0jp0opjuF8mGPV+Jed9RELDN1fmio9K63bRwquXEj621InxaRUHvzSDNGxz5ZCZF4B3ubIz1D2iPjTpKFLuUhwRG12wADOK4HlHLCqGQTH8kR6N2eFBND0hr3e0wUmpW3n48/nSC4MnNntXI/KcRWSTn8CgHjC33qwKLXsY4AmhPmM1hYmwuvPOhWfm8rJ8kYGG5+h3GpS6gJO+hPSB8h9w0XpPiSLRnkGKcQcruwo1IQj6D+Qb4gB8n26Ag7lK2P15+Uk7QZjcfN3sPAKO1SnWDEhMj2GzNxHQKL6A1dIEsfrV3kzosM76O47TUCRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nyyjon31U4WLy2Re5Ha0lU/mJz9iyZAEWj5yxzcIYjg=;
 b=BWFTRIPwFCFFVdiCjmwsf85PqX7A2rBBeGhkHlDBj+xMo3FiCaL1HheKw1/pDGPmpcYMlfy8IinMtq4AJ5WK/00itYxhLQ/aV0ISchSFdvgwvxH0YIw+PqPjRyW17SaXl3t4dfEMhpAx1fQV/zB6psJLh5rIss9/Sp7BI+Q+FfcfRiu7ZZHBdt1RRmAMrEcQ2WQWekwCFfPTa81NjpIBISXcYtQyKg11zkFqoAQQE6dF5T1VMS0YXGmXd9iHiyoaeYMGQUFz4bogLg2dzfByGFPeGtns0Diu2U6/FTlYgazMbyuLSVOKzqBjtBa4lmCnpGg/leMK6M86oRd+ncan+g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DM4PR12MB6230.namprd12.prod.outlook.com (2603:10b6:8:a7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Mon, 7 Oct
 2024 16:56:34 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8026.020; Mon, 7 Oct 2024
 16:56:34 +0000
Date: Mon, 7 Oct 2024 13:56:33 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH V2 4/4] iommufd: IOMMU_IOAS_CHANGE_PROCESS selftest
Message-ID: <20241007165633.GX1365916@nvidia.com>
References: <1727358828-97791-1-git-send-email-steven.sistare@oracle.com>
 <1727358828-97791-5-git-send-email-steven.sistare@oracle.com>
 <dc921950-dd84-4796-8ed2-c644b0d10a9d@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc921950-dd84-4796-8ed2-c644b0d10a9d@oracle.com>
X-ClientProxiedBy: BN9P223CA0030.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:408:10b::35) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DM4PR12MB6230:EE_
X-MS-Office365-Filtering-Correlation-Id: 944972a3-1912-4c7e-4d7c-08dce6f1001b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rnMrD804jOPAFy70nSmHi+RfWosfghUSaHApuuSA2gBe72Fl67433HgAz8s6?=
 =?us-ascii?Q?NepfzoYbeggVPs0x2tlyAuBzVPLIitd+vyfKw1jcG5dp7PpAa6s5UaRFEMDd?=
 =?us-ascii?Q?byBnjOnJL7HLDaCqE+5aEt1Kh9U8Nijlsx2B4QVx/gVVwBPYGlwAirTJqI5m?=
 =?us-ascii?Q?za0p1gN3XCzCViiWM8E/VDBLzddZK3KrS+yEWIuxk8Vz09yWUmFSrbKXTGjE?=
 =?us-ascii?Q?eq4okevtaQPGUUHVcu0C7wVlYDl4oIh7ChUh/tsQ1O2kR1LMyaIq8TZ1p+Bx?=
 =?us-ascii?Q?Ue8RzpA1kKLIsWTohBcddhrwuKn9zt1hGAB97MEMTT8JW7LCbO9Z62hkdpsY?=
 =?us-ascii?Q?h1Lf4/UZHfuu2L2QNi7WER/0Li8PysqTrati5fzh9H8VlM+SuYBhk081q7u/?=
 =?us-ascii?Q?xfa5NplVBmowLYx2hTNiwTpbfXsYn5t2G6Jgtq6nNtmS4vSLDW8ykon2kQPj?=
 =?us-ascii?Q?y+L5I2O7Okp10K6AypuAkWjRnTuNQy098f1kYQhGCelSiQOz/3efK2b+X51B?=
 =?us-ascii?Q?yCCFbmeQyOGLA+1vgG5VqTNKudOnYQHhof9uxjSnhVDGcnqMKhFEDqgO8vQr?=
 =?us-ascii?Q?0xSg5vbzrlA4bzt8IT2Uadu8fCJHIcnroSmOXBjquks/Ei5kCmNs7bZJkbXM?=
 =?us-ascii?Q?QH357CEt01Ut4RGCDyt8sbSWd4e2FqlLTdnEqAMRiy/zKxmRf5IYDbxhFczK?=
 =?us-ascii?Q?13dW7nuuELoLjLt+aXsVt6mnGF53HVqiAmOkxNYSXieTuY9g7fzeTqDA20L+?=
 =?us-ascii?Q?yUvbRSxZeqnfd7xlryAblZX1HtngStWWXW/YGB0n9mVXd5cBd1hVyDO6x2Cc?=
 =?us-ascii?Q?3bfaS7j1I39tEdNHXCS8Scw7XGTOqroTZoYoiOasYbIbHPu79e+R9e8jUxik?=
 =?us-ascii?Q?UPNn0ebtbufzKzTXu6zkutNna9dlXQIUOnik1uUq5nw4nV7bwwuo22ZSjZyP?=
 =?us-ascii?Q?PBpKcok9DDwymyyLJnfeBMzY+2lPRCJfccQoPAPETCxhAf2cQBBk9yUj4sbm?=
 =?us-ascii?Q?xL7V/hITXKGJxA5L0TEC1YtZpr//moK4vXQs7zc3+E/GBBdVtlS7CAEpTS8m?=
 =?us-ascii?Q?UPXDNh/dw6wtf4IyvPgTLBq/5CO934ZRPEphApotogQsB+Nshh+0ccS7WrYc?=
 =?us-ascii?Q?alISDiTMRhx0DwT/+5R9frP450d9uUvb9HkpxoTlMi4Xg4mxIea8nIkV3dlb?=
 =?us-ascii?Q?/BHeCady5xaFTn594zrbtEojW7g4f1R2GZkgPZlYnhHQlqgpPv5uyn0CCOLX?=
 =?us-ascii?Q?S//ZbGB9VumzsWdJYy59oAkLJpGQNtulnfezhe7nmQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jx0b/lERDIuJF88wZDhhuln8mV5x6WyZy/+8rs1qd0z9nXpwbpx7S5cDbAo6?=
 =?us-ascii?Q?NrcL+XlBkEVC9a8x+3fnhZGjIc0e+nHcZPdsMSBFoNEHUfEQ6loidsubF8q9?=
 =?us-ascii?Q?volx2xbMpBqL7PZ1SjM1lZ/n/NAqnsvyVA/tf6fFaXQGDJWM79FQua5VeF/Z?=
 =?us-ascii?Q?hx9gycEHlF0fX4wbJCqZc9XGFgeoDeJPY1TT4aOjZF2xqV9Pi4/efxYXYGnC?=
 =?us-ascii?Q?cEhjDU9sKBvwkG5BDzsgsApiSnfM+fakKM8uJlpqMnBkWz/Aefsy9x4TmhT5?=
 =?us-ascii?Q?sX/OZiKEKPGzTJtcfgaKlfpkRP6u6GEgVvIDdb4vVjxd1rX1ZygFBd8Fk2EB?=
 =?us-ascii?Q?/9GV7nvE7YeyF9hSb4ezxZjLS79Cf5DU2Qee3zfft+3yB7uwB0ykD7InqFQX?=
 =?us-ascii?Q?KuukbFl2K8z93Y8p+EMULShX4r51Cf001oaDP32U+X2qVVXQJAYBBItVjS+5?=
 =?us-ascii?Q?P6Z+gYBk7rX6NOVbFQ+ijwcF0OluP00KLWXjujVE3kDlCxemKxi5pxj/4ei8?=
 =?us-ascii?Q?iNpmUDWRDgZrLNire1ZtavUkoBr28W7mRQW9Hl8VyM7bzQfWSEgwFZHeRvun?=
 =?us-ascii?Q?BLh6pdRJvbgbvVr3xrFp88BkylzSwl495nuxenjDNayInt580y8R4PL9Haq1?=
 =?us-ascii?Q?2wZYQtoPw/rKdQYznACxSP2MHRlHEIrr59dB0jhvw1l3UdSKDbQhe9MSs9h7?=
 =?us-ascii?Q?rqpHeta/U+2M0CeJFFAE+l0G0a4c091z/dIqxdIwW8XPZot3ploJROvuJ0zw?=
 =?us-ascii?Q?biyAUwm0nUXOKiqPucQmoeCx8BErJMLaRoLe+eKM8WC7ppNRfkE8B3SZ/VqF?=
 =?us-ascii?Q?1ItXtz+qM2HvtHutJqHQFfJg6wqvtPpWfDhBgUXbt+/R2eSYze9gtwNJuckz?=
 =?us-ascii?Q?laFwPLH1HSLHeexIx5lsHiRwfbgkXWEJo4itg/cp1i38P1zYJn6v21/Vpk4Y?=
 =?us-ascii?Q?YQczGhcVioo5hFVWbbguE0CzfrctYxvHPuShC8vbyMpxkY6cQ2NUEvmcs830?=
 =?us-ascii?Q?BApeSFDivnZxCaK1bn0ZPYFTm6/AYzJzYCFn7aPwumNnmGNHdNAPVShdOAIw?=
 =?us-ascii?Q?4sGe0Ys5AyjQq8aGEibCO8EYuRwe6rsCcKY1NmAFsZ3yKsyh/fepFb52xcsc?=
 =?us-ascii?Q?SVEIigeyufIhIdKnPOzzzv+SBTuqT1RoJ6iPVe4o0q8jFPNabTQI8R8I0i8D?=
 =?us-ascii?Q?6c/2hTfXKJehNY+Yp+dJVUPfJqLhfXuVEvx3yO+Ph04o5uNhy8xfv/+W/oGe?=
 =?us-ascii?Q?8GlYa35dacScmdGAmzRQ1redJaH1ysJQ3hDRT0TwXDf2VWdYNURSP5GppNaH?=
 =?us-ascii?Q?7QdmA+QGe/jpcK/x64YF5XFsflLjnZV5urI1qjyUqjAu7bgIXXLcOHx8o8go?=
 =?us-ascii?Q?yv6MQ/M0haxcGfaxP6hMIH60Y1sD2MYNFY5P3ClSmp8HWCn4aqc0JSqhnIYV?=
 =?us-ascii?Q?5iwl6a94X/BFMoI4sh3G2yYv1a3QSo1+3498aTehGx7h+wyh0yL683CY8maW?=
 =?us-ascii?Q?APqhYJ3nOAL27rz5pZGSKUcGtXYqMk190R8iem1/GUin5OecXm8lMZDrJ7GL?=
 =?us-ascii?Q?pPvSTjVADzFSIL64GdI=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 944972a3-1912-4c7e-4d7c-08dce6f1001b
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2024 16:56:34.4402
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MS4o2mhvJXjG78nPw6aGI3r8nrZohLomQsIj1Jhbrzf+LI60NQjiBZBTyTS3Lg64
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6230

On Mon, Oct 07, 2024 at 12:05:54PM -0400, Steven Sistare wrote:
> Hi Jason. Do you have any comments or RB on the selftest?
> I am ready to post V3.

Nothing stood out to me

Jason
