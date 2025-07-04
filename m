Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2082.outbound.protection.outlook.com [40.107.92.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41495309A49
	for <iommu@lists.linux.dev>; Fri,  4 Jul 2025 15:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751641670; cv=fail; b=cAtbCtovDb1kP/iSqRPJShnTnHQGQYfh3ahAsZP/Bj1OqnROg3Wvc1t2e5VI1qWlJ90JXmbDyOHIXjHUIgNiIgyQrtx6JyunXEp+KIK1ViBqX+ArIa8d0BoKSIX9XqTGAPCAUnePq1RFVfOxkmRIxVf1ZJ36M21AcXUUKPJBT3Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751641670; c=relaxed/simple;
	bh=o/DLLFIEEqYMGNwxJV4KlB9n5hq9IYQAAILmf22UYsY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EEnc6AdKBla3w0LY3YTHqN+1/BNgFCsOZSIz6WKaHqq23b/OSXwqGrEiKeGzmboFxaR6t0uccGh4KAmO0PtuXSvdd7v70bdnwpX7tHVWrAEovToF65B1G08OIfxlPqNEbq380XRXEly9OLLb0C8PwzM9U9snc/ngSCL/pSOil5Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FKC+q+iC; arc=fail smtp.client-ip=40.107.92.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FKC+q+iC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V/DoUIr7mSI1VfYb962QurHNI4gOyXXvx1mtGeK8oOe3yralgELlwgLyxhV5Uo7+XQYS6GvKFEty8XzkMku5iFA3Dstdt0awqvOlfImu/Wo/BzjEIrnSHjbz4zJA9GH5AioKdxCMrYkFdGMuRvPzt/gUDiQdb2+CFrzKEVZWjk4I3Za8gE/6K7VNgu0Qis4xJIUCYoOdldI+6yd1hT35uKoZ9/uDtqArMsrYnVSaVd9I3NYANsSIs0+CVbrLIlynsMcM58CuCmajbqcPqYRCJzmrfd+z0vA3doBJZ8Se/N66e+I48EoCiq3afEWe47+9n1+GqzXnvkK1gwZgpDX6LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pFGeDFn/GatX6WIJKx7jB7W1KprZepzUAuQXLK9fqJY=;
 b=WZribyykXiv4Z5YIh/rbj5AgzK3WKGV4gMewVgbkadyCAr6z58AgyDuXYXwL17xzuyLBOKcbnCvEjjIP42iAOgo0mbnFaWx2VktsLXEqEaW8GMf5es5Gmllms7xc+Ubv4wG4e0L6OTvGboVvWp/L18Y+NhzAwWXqt5dFD/uuhepolfdNqk8db/oZ3Va28gFFMmmJPy5HiyPawK7KCkVaYbdsoW+8UqHW38mzxeRkDbeKmDBWs8cVx5kz+gy0S2SjrOhbAgfDS/gVU+bO5tHezKPJkr0ho36s9cTYSfzMC61GtkWrJQUP8GNDrUi8exJwbHzwunrL5VhK6KNyjQzYhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pFGeDFn/GatX6WIJKx7jB7W1KprZepzUAuQXLK9fqJY=;
 b=FKC+q+iC+qrA+GavGXAxu+axxz5bkqTwPywpLGRGf0hPH6jqz+l5e8VX5L5BDBRfZtZHC/bTHTZVWdYXJxHZ9c8ep9dYShPe3u1RdkQtv4H6VqtNtXB5Yf5y7w3DKza7AMI7VcNTFvxUFU5l7APRX2BSw77Y4Yc0CZdj8/qB9uOSl5puPXLQGv2U6sVpPCRZuLUpxF5NlspG93Id1Vwa7/h2XUi6h3zOaVZj9oz97zjV5SlcCNl0XG7ntipis90gaR9MLqZaXK2KpFhFPzv00QP7NKjEOG4e6GdRyI0iqcMlcKRGa5tDyHSOXL2pcW6pPbC75MG6wxbjlRjJD0ob/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by MW3PR12MB4444.namprd12.prod.outlook.com (2603:10b6:303:5c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.23; Fri, 4 Jul
 2025 15:07:46 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%7]) with mapi id 15.20.8880.030; Fri, 4 Jul 2025
 15:07:46 +0000
Date: Fri, 4 Jul 2025 12:07:43 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: kevin.tian@intel.com, will@kernel.org, aneesh.kumar@kernel.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	joro@8bytes.org, robin.murphy@arm.com, shuah@kernel.org,
	nicolinc@nvidia.com, aik@amd.com, dan.j.williams@intel.com,
	baolu.lu@linux.intel.com, yilun.xu@intel.com
Subject: Re: [PATCH v3 4/5] iommufd/selftest: Explicitly skip tests for
 inapplicable variant
Message-ID: <20250704150743.GK1410929@nvidia.com>
References: <20250627033809.1730752-1-yilun.xu@linux.intel.com>
 <20250627033809.1730752-5-yilun.xu@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250627033809.1730752-5-yilun.xu@linux.intel.com>
X-ClientProxiedBy: SA9P223CA0003.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:806:26::8) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|MW3PR12MB4444:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e694577-1b44-4fda-4c2f-08ddbb0c882a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Krmm1UMa5IvYrXAvs8cUfF+ToXLhvUODja2MlD/yeyhtGPG4gL2l2fHlEw2N?=
 =?us-ascii?Q?8Puz1dJ8+SPIymlPGulYcMmB8NDodU7sISiG32gzuPU/0DSMLBtj8P+cjzVC?=
 =?us-ascii?Q?AXxK5virkRonRgZs2VdHvmC519Z016WNrYjkelLv917aADzeDrYuh/U/4SMt?=
 =?us-ascii?Q?08fonBm+JqaKY1wslutuX4OZrLpp2Ujah13sPQTc54tiZ8tjs22gsQ0JhWne?=
 =?us-ascii?Q?lJe/W0515yLBnwnwPSYe9Cu5oLMNSDZXUneOmiBqwhHSxtoZ+3f3A/oMrkc2?=
 =?us-ascii?Q?nLaubbW2Uv6xUmM5jI0y6gXEN7sAt0l1nUYjM3iPjfMSL7n/i9Ty6mEwTsHL?=
 =?us-ascii?Q?YJ2OaEmAnZT6IU0UatAkcUreKZ0a1yHI4t6HGQI1pR9H0lUacoRsxRRUYlsC?=
 =?us-ascii?Q?vOlXELbffr4bad3DwE9O7QPlRWiYw3O5h+8Rp9WDAuyn+2TpIP3mYsW7K14E?=
 =?us-ascii?Q?w2FA2sJGCTtM1Lotb3cFcjRI48UAuQYmC/1WoeaQePo4l0wU1USuP3f7M/Ji?=
 =?us-ascii?Q?DXIai9xr0LC159vhw6SsCKvPedygOEKKj1Zg8cARZ3B5Zv8qVgaCU2BCw3pm?=
 =?us-ascii?Q?vIBudBoDgxBp9YEqaddPN/xrR6JJ0hEjb19WPF7lEQgRPAKcAIZKoqyLFnRy?=
 =?us-ascii?Q?/09aiykHO2C+s7mh9m2yM9JFcGUFkRXolaJfsJguqmCzYzb+cwC7SI3b3p/P?=
 =?us-ascii?Q?IzPKtscSE+7saqGBODyH514Es/j/p8cqUVrBGEGcRYu2A/zSwiButn5b4ni3?=
 =?us-ascii?Q?PxMlmktNKMQhUMcIak0vtyIkhi0lsSMGwFuT0uhQ9k9jy0eJoHzgBlbSOr8A?=
 =?us-ascii?Q?yRCb8k8b0IS0L7pencKKEOnsWwMiy/noj8gj5iFznZS9s9yZ1F1TOZUMt8ID?=
 =?us-ascii?Q?pl63Z6n7k7H0X3peFzERmhATRuQoCZFGp0sgOU+3zk3GIhklnkyP4fhDRIMO?=
 =?us-ascii?Q?WdiE1JGdD9Nxd/WLVZD+xGws/U0ALZGn29YV3Hsi0wblFpWkcOoXqdwb1E8t?=
 =?us-ascii?Q?rI9684gLyZcx8iOL+pZbNfo+oJD90Ba4dnzLw1X5izHBvFArBj5Xjz/aBfgJ?=
 =?us-ascii?Q?jT7mXBBB0B3mq93DWJUHuaJxHPIb2LV/kLJhaosuLhBZAcRyEjS+RRMAmkX+?=
 =?us-ascii?Q?p+eeGphx394eQg+/Gdu0iWGGYsjU2TluXTzAI1dORukmm6PaRI2Wli0XBh08?=
 =?us-ascii?Q?D1BoD4kKlsSZt6UAC416dZ3iJAc49EtSixZ3okJGGORrlGuud2dP/9Mdzo7+?=
 =?us-ascii?Q?pSLME/YpgK6QmFrKvmPJ/9QMk+gSmY7WMd/ug670uF7uF3bQxdDX2ENolqEJ?=
 =?us-ascii?Q?Q2Ycd4ktWQSMEMt2JXiY9JFwTGILGrOrStdzPSacyOWctlTpPwhTzBwBXHxN?=
 =?us-ascii?Q?LA7soi979px0tMmkfca4ksH9LsdxZv9lj16qSFYgWdu0vkPLECWm13Z0xixJ?=
 =?us-ascii?Q?GbpEjAYE8ic=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SDbH+gzbkaO8CgTgK1gxYaeRAXS/em22dJ3D55nCOZMPfHbLPdV4mA0wcKQv?=
 =?us-ascii?Q?KskHRr73cgsbt/smibk3iH6Ee2H+ec/yCZxqzhE++0xLZXjEgVNG2yYfVdtE?=
 =?us-ascii?Q?Tk+YNM7QGCG4ozRR8rzJ+fwdkNqwBkPbUSGF+Zk+1chSxXMA0BFz4pBsOl9U?=
 =?us-ascii?Q?DaOVWu9bFd3FG+QBC5WLf11DHcpLQZlRSSZkkeptfVDG5RNFMKIGD5lRshYu?=
 =?us-ascii?Q?FW2yWoDb6PdYc65uIct2mpff7o1oZkLWnay5PoYwEgqW0bKvvQ+nO2El+YcX?=
 =?us-ascii?Q?1Ar4sTk9rn6e73Bd3q24c07yfPAAoot1lvtw1SYpLkDvn1p6IExPBmZXmwYv?=
 =?us-ascii?Q?I+1Svao0NndZ9uLkK2hZHg0AitlcQRAb5PvJ1eoBJRkVQ4XY+7UKK8UM5W03?=
 =?us-ascii?Q?GPDoUymcJ3adRODpO0Q/EM7UR5ir4ARpmc7YbpL+x+U2bvlFs7LFcr4zcifL?=
 =?us-ascii?Q?4wz4o/5pAZBivQOiMjL1qNTy5sfuZyYPIXzRQrnpwJbyJKlucAQmUISuewsK?=
 =?us-ascii?Q?cAhgVkop020Twi3+sLSknQi8f8IiWQTM8sImPPkTEGKh91HF59hrMGpWe1xa?=
 =?us-ascii?Q?G7nLotvxLV6b+n5tslQR0frRhdtWz4nedeB7ELHSF1b83BH6saigKTAuuS7b?=
 =?us-ascii?Q?d6O3umwe2D1Goy8bC/0ZwXivgi/M7QdwWrtqwad+DCOslAyLvPCu6XfLxPfM?=
 =?us-ascii?Q?1XVWj0gSpNdEKII98x8gkUcJmIty461BF0hUIoUNc9fB9VTg72YH9yRdzI2i?=
 =?us-ascii?Q?ZEcW5IN1UCz4wUSNLJODJs7t/1bnXdWSM+xUcxztVOYEy7HxXO6iI9se52hc?=
 =?us-ascii?Q?IHqeF6GqRB9MzWv+rLJiN8WHtDem6abespbKv8Fv1n6eIjbZOxqDzqL0Fv1r?=
 =?us-ascii?Q?kNILbRQg3+XUTPREtwsb04JHEQslruOr7oReBzIECsCNuUDS4a+M2VpDyJC5?=
 =?us-ascii?Q?e4LMfhbub9Hrjdwn2Jmxv8AzMJgAJurv/NbSjHLEoch56Yy0MJnwyQdC44ad?=
 =?us-ascii?Q?RIE/2OwruBnKxHQuAMqP6Cqtk3OPz322PhL8uhqgSxWt6jP82Ii8BfuaXmFU?=
 =?us-ascii?Q?VElocN+Dhw9V1UUA4OzhSD9AcrtATBestHkjDK3fw3xJj70++f1dOkVl3Iaf?=
 =?us-ascii?Q?CqQGt3DUnw6yCxd+sGnQiDfe1ri3yqHfodjlZ2x62LzH+v2bWWMTPJ228774?=
 =?us-ascii?Q?c4hscRGeW+h50njfTJwi71MZh+TxmMjmkIyDnmXPp5pwu5hm6epVwcJ75/VG?=
 =?us-ascii?Q?jna8kKCMy9Nzr0v65Lyubs4lmPp2XCybv6aWT2r1H+plyCPClIlZN/RHAPXP?=
 =?us-ascii?Q?gTi4IYirTnV3ETYOepW45Jbb5aelCJ7YAR1VYSaLC18hyQ/HnDN9eM4VoWT+?=
 =?us-ascii?Q?heQMLTvFgDS0iBwrtmCZUkW/kuuo/55yrHVkjkcF4UkUVuWJ++wmlIr+/qhN?=
 =?us-ascii?Q?L9h0j8qTVE/yw9SQxN1nurVftRtnbcQda6kMsvAbValVLtluZbIwgpfVfH2x?=
 =?us-ascii?Q?eBESUOZAuOTZdo7tqTcHvunqQ1JJ2x0hHpURgeMJcXwqctUANz14PWF1LSMt?=
 =?us-ascii?Q?r/4i9WUf+NuESzQ1nc6xz0zWHiy+dLnMJg84/VI+?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e694577-1b44-4fda-4c2f-08ddbb0c882a
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2025 15:07:45.9341
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qNNgQrkFFSp+E0sy7u9r3qMuiN2a7bAQ1GI2QWzlkWvdgl1WNfpPdfeFKB+Bo0JM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4444

On Fri, Jun 27, 2025 at 11:38:08AM +0800, Xu Yilun wrote:
> no_viommu is not applicable for some viommu/vdevice tests. Explicitly
> report the skipping, don't do it silently.
> 
> Only add the prints. No functional change intended.
> 
> Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
> ---
>  tools/testing/selftests/iommu/iommufd.c | 378 ++++++++++++------------
>  1 file changed, 190 insertions(+), 188 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
