Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2050.outbound.protection.outlook.com [40.107.92.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D752D8DB1
	for <iommu@lists.linux.dev>; Fri,  4 Jul 2025 12:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751633518; cv=fail; b=Jv6DVDzdnVezYJwHoV9E6dKgyVVr9r9GG3P+KzhpCNoY5t2N1Ym9FPo2+fka2xoSwuafBaE5PjfEg1TLQdvhcuyrOQd/5DoAgZkhGOZTfy30mr3gaiyOZORzSCztpV2Sq0h3cFbK7MNNDr/KQkXby81xqn3AZQszyXyNbNo0Vmo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751633518; c=relaxed/simple;
	bh=kTA6pFvDITX7B0ol5AOnTP6fRiDF+42RI+3l5WCdreI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pvUbTRp5EWb0U/zWKXsgAytsvOYklPkP9bSd10PmWJdZkJ/Sj9TlOQYJNQY3/DJlaGgjf6m1NtbxgQY4cB43rbyEqHYtTquh/CQRtAYVlp4os33AizZ5F3h9VRqGg4SujwSVUPu2H63Tmn2NTXkVarQ/SP9TqAm8Jm1h63G1QCQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DRwuMiHc; arc=fail smtp.client-ip=40.107.92.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DRwuMiHc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PucQuk9DAoO9lza28Uj8e9mtPDcZ3AL7mdH+LhRgTad0LWsYTwP5gR5YZQIU2WiaQToQ9lYUkVu7Fe3lH218rZFl/6R7961tfNSVCqjaLWC4PuQ1Kebk6bw8ptDO9VpKcC+QRo4E/jFK42fGEW35t+HXISIexSCEt1tU5fLBPdyVyLAKNIEtbZkx/lF0gT6zzSYw+UteLCoBQETe/2+cIlLqFOeHxmBpK8GWfOAlQR3/dwhtkibHIuDSj4pzEWHUBa7LKLyIMHu9gt6bLXNBimkPv1uWOzkp6Cn6WI4q6ZfLR4V+1phD6lTU5KdOjtIIjo0wrp1aKOsGXynN7hGoXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OtO5MwsQeBWiwOvyAR1v7SEZ62OWgjcMS/uUKMko0RM=;
 b=Tad+kddJVP6F18vDGTNgL6tz8oan2TSjo6S+pEGHRc+t3ejLu0rm5YKx0vBK8iHMK8TGh7MFQ9V93/ZQpRMEleZ4duJiizq4NKzvi0JVDfJ+0uR+gnUkobY52+wMyagCr9IJ7QQL/vT2/FiI3yL3j5EbH4eagpIJkx3fBfGZg2SJTESKBMB8WnDbU8HP7oE4M4Gk/kyYLZ7gyBeZB0Z+IcXSefcYumFeZoypNtIa6ZMpVyBLlHj2KPyrfDY6Tp8wCRIECSqN17+5xFUS81xo5VF74DgHNSX8EipqqrfkDk6z85BbTgixilxZx3WFC2VtbvETa1gQ4FbOvzzppnb1cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OtO5MwsQeBWiwOvyAR1v7SEZ62OWgjcMS/uUKMko0RM=;
 b=DRwuMiHc1jY2aPU95+Y5cNoDeTq413l7A6ZnPLJE/QVdFPi5r1vpXMq3pR8D35qUV50oXHhixZYleYPTdKJxTpbcw80VEDOuj7g64T7/Pfe4saD+6JEzlGooZNyRonFeV4B2Wvv3ECy3P1W35WSAFvwFaxHgGisDfMimnTTYIv+F1FEexcHKISWCBpqK1gdfBmZ9KzDQza2LwlatartXcCOtAPDVX+2VX/+FAT6/wnRSj+a5MWNGvi8vAEDWR8HBWi+zD01NmmDTBFOvTJh/Cshzk03UUv1xnACB7OE40Z9ZFgB6OznqZmY7Ng8iw9NTBtekBfFUGue8wCIUZKsldA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SJ2PR12MB9238.namprd12.prod.outlook.com (2603:10b6:a03:55d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.37; Fri, 4 Jul
 2025 12:51:53 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%7]) with mapi id 15.20.8880.030; Fri, 4 Jul 2025
 12:51:53 +0000
Date: Fri, 4 Jul 2025 09:51:51 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Easwar Hariharan <eahariha@linux.microsoft.com>
Cc: Joerg Roedel <joro@8bytes.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Vasant Hegde <vasant.hegde@amd.com>,
	Jerry Snitselaar <jsnitsel@redhat.com>,
	"open list:AMD IOMMU (AMD-VI)" <iommu@lists.linux.dev>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iommu/amd: Enable PASID and ATS capabilities in the
 correct order
Message-ID: <20250704125151.GL1209783@nvidia.com>
References: <20250703155433.6221-1-eahariha@linux.microsoft.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250703155433.6221-1-eahariha@linux.microsoft.com>
X-ClientProxiedBy: MN2PR14CA0030.namprd14.prod.outlook.com
 (2603:10b6:208:23e::35) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SJ2PR12MB9238:EE_
X-MS-Office365-Filtering-Correlation-Id: c8c69bed-3d8d-4e92-29ce-08ddbaf98cca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zrTgHVbKDxpHlAoPgfdjbwlxve3oZ1Cp5hOsV8LgcotDvwXMdQ7J11zcLven?=
 =?us-ascii?Q?ijerPS9s3kS8Ill8wZ0V2O7mAOgjQnqVRYAx6GirlRfoMJIPtH3URbaIXvin?=
 =?us-ascii?Q?JAvOlKNaBjVXYkQc5JRtXDYC85JcbNaxK/nCZPqwjIkoTAnWX3tcS0hgywAi?=
 =?us-ascii?Q?dd4lAYHgs9h7zMDwi5ZrTp6fyc/z4ualRuhqEvWTWuTdJ5OGvy+9R1qOZu8e?=
 =?us-ascii?Q?jCgD09572kTKlxES9fpweaUTbN4SXmd46Vp9q0LLt1u+r7KJlgd8xpnPuRFb?=
 =?us-ascii?Q?D/6suaLNaPob9hEEXNOiIBSoORCOFXUmwusTJ3dYID7s3LWIuBsRt1BMecw+?=
 =?us-ascii?Q?E41g83Ner/9lUa7+lq2MqSPcFP+ELWuXFyQquKYcijVqIS1eKeI6OYi5i3Yn?=
 =?us-ascii?Q?dJxicjAbeesQhYexvnIlqbUoKyTbUgEj1AvIA/57sWRQ0U6hDt5XcqIzTG+g?=
 =?us-ascii?Q?LV5mi1ln4qRrhChYGP/ki+kBst27oWUaGtj6wgP92lYigXfgGIxTebbtwjAj?=
 =?us-ascii?Q?dlWYRLIKqrohDA8P2U/PLHJqYRefhl4wBSg8L3gYt+SIz9qR0aMetj+ebvku?=
 =?us-ascii?Q?X66xtun8q0NgCVmYUeN8Fjn51yIZmX5+7Z119i2pBm75UKd/vydeeXoFtCeK?=
 =?us-ascii?Q?cIhV/GCpPzNeH/RVMqP1NO5uXCawQfJptZ1NVGWSX/WfQSQZHvODBVNwAmgm?=
 =?us-ascii?Q?nONKVEGHoq7wD2mzhxuJPdPulcTrzTg88IbWYVD61HKzOSMkSJ4dirbqysV/?=
 =?us-ascii?Q?7Osk3MSrGnJf446tAyRfXFHoVlU7JNej6G9pc91A3VGGoaU0J2Ftwf8/xt7i?=
 =?us-ascii?Q?0pNg7ULttpdsylcdzvqAUbKRjN5UH8ZR0cg0V9sL/zbEP4yRIlbBrRRosQdz?=
 =?us-ascii?Q?fyDQQpvA88+7O4otKzLtkT/X3BKB9LgkafuXPaZZanwPSTszutjNJJJG7ve3?=
 =?us-ascii?Q?IijmV/vvgsqOozxsZraczePQdwr/cYHsSc2YVhsjyVumchTQ27BsI6u24WCD?=
 =?us-ascii?Q?W1A6GCwagTUlPYDqEn1hSKeKMtkfZItwjSx4ahEjhGdGej/ucQZi1VErmMDC?=
 =?us-ascii?Q?geRQa9wRB+SoYdM92cHZkG7g01hkDStxQf/JQUMgYCP/pNkMXCE8rByKW903?=
 =?us-ascii?Q?biWaLD1rcc16zWTST8FSREqL9pL9cbernfuogJVPGjrVxiBx+DiYUt66nWag?=
 =?us-ascii?Q?JwGanVf1ewBOKq84Zel0w2bZc6HG75l00aQ4fRGOYVGvXQpCTS9ZafEaa92m?=
 =?us-ascii?Q?qw42DsoGeF0FyHAKtfTw15NE6xZrCem9lDYXmfCxU0CNjx07QXfIVIeQwGYQ?=
 =?us-ascii?Q?NDfCnjz20jgPMmuZEdEHc/ANF+VembHTfmR8nYRfdsWTf+Q7YoUR/FqQddxr?=
 =?us-ascii?Q?wagRITaALk8MYdIecuKUPSbhrW82J+zt7NxmOmvsk36601p0GS5mNSEBZ4HJ?=
 =?us-ascii?Q?x6pXLKeohy0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KvMGwlmeYgYv/7WAL0J9Zt5Pouvdf5FsNjHMqSbDH21BcjArlR9wmpSIU5o1?=
 =?us-ascii?Q?tpaK5z2NKfj94jtd2/3k1iPodELQqjs4yKU9NWJ700maK2oyIFuY2LDbc/Kd?=
 =?us-ascii?Q?WS/3+8mUOtaSNYVkXqEJc0q+1+ypb5o0iJKV6RciyW2VXRb/DizXAsg6CzTH?=
 =?us-ascii?Q?c4bgEBPyzDAliZurPZ12RGYqnAMeNuz91ndqccGWQQzg9z1sXF1dMHKesKvy?=
 =?us-ascii?Q?oiCMkjmwCyMVYZhyR97V715Vh8iiLJ0feP6B73Slahj4lXd2c1QQDta2vxq5?=
 =?us-ascii?Q?BO6Cn4y4dWwzoycj/OX91hC/KCgqqrSK5BqRIg9HHnVLsUsnQPZYAAsvWWS0?=
 =?us-ascii?Q?vcvvSYp+z6vz1VIZqBAl20Q+luJ/qCKmSMagFqWsPNulwoVMhemt9JiG1Svq?=
 =?us-ascii?Q?MhT6CjtL/U+qkyFkZ7lUD2XkkCwMwOVER8ZG/BAYxvErdNLmebdGXuB9IKF8?=
 =?us-ascii?Q?GiLozLKAgSWfMBfTflOYXIW6Yo90RrdjvoY0PIa/O1Hn7gcTmiDVXzDDHFrI?=
 =?us-ascii?Q?uPQ/amI6PTWLs1LYIBQcOSrevJLk4/8+FbFCK6zhQK+BWGZfIzix15hEuaii?=
 =?us-ascii?Q?cAJMNPrCLxqp8Odhiin0LMOakXtcTKgwCN8ZM1l+N/f7JmsdAxO7Qasd+YfF?=
 =?us-ascii?Q?WRw3jPDvXr7qefCvEKhgRLsSjIhey+epbof0g3guSdY7IV2h3XPXCZiAQY0K?=
 =?us-ascii?Q?wl7xzk6TyNXpKhSHMD92TkQLM/rGYs85RS4/6tvCYrEiosSFH/SzNwoZqTrE?=
 =?us-ascii?Q?3rra8aTJSjf99Pnx+HyPtLwKuW373zheEkw/6gz3+Q0vli64bCSihwr8m6YM?=
 =?us-ascii?Q?tOHYPUmwmjdAKWMnCNCrwOHL59/tOdl2jCDSct+rGjYtg0kEGy/9Q4R/7G5k?=
 =?us-ascii?Q?n0r1haEKz3rpb78PbrJq/dwo177kOhTyLDPZFS05tM7fZ8de6GAl8upksGJK?=
 =?us-ascii?Q?3/ya8NJ6Eu4ueNOpTJ/ZBHaHwaYlruVmY4oWemMLRrJVVFHbTN2HlQLGC571?=
 =?us-ascii?Q?SePRmjJbojE0xFTKYeQUo4aFSdTYFMxl5SzloyisoyEIhoo8IvWy/nuxZBEb?=
 =?us-ascii?Q?vSv0GWoEVtrHgUGY/5c/R6+TZGCiZH42hWABTPsYMqI8pzy+fY0sav3gtImm?=
 =?us-ascii?Q?B/A0oOcTZNLIrmKxoVTXulJqx23VjYwJHkULyF052lOHIQk+eVuwF6JIL+cX?=
 =?us-ascii?Q?Usyxtk38aG6arzfowtKYoCV5ghMTbsEpbE1AkJGHQ0Od4C5A5D/MqvbPlIJ9?=
 =?us-ascii?Q?HqXKiNtPFbAyHH/6GSKpLAsSyszWQ0TRrt91P50E3DeKZ6tH0YsSiNIYgFwo?=
 =?us-ascii?Q?XHh07LY2iWn7fVPYWVbuliyO1yYZ6mttcJPuOBx1FUJygwBT6p7JbvvyAf/X?=
 =?us-ascii?Q?3/ng06M1wGfZSndZB9/XPmUMIkJRn7mgkRUR4qElXosMvDni4VdQFFHPXJ2w?=
 =?us-ascii?Q?Vy/GlbQngIx8pfnoTDNf7kBsXmxk/uOUh3X7QL2ROP5EyX+KY12UujiZ0mLI?=
 =?us-ascii?Q?CW7WACfBgCYoMrRM8bMyHa7/CJ3XcMWa+YgYu+476je6jkTLuiwoHAT4fsgG?=
 =?us-ascii?Q?337CPOr4csu/OX6LAmYvRo3RUt/vMLEHP6bdrQz2?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8c69bed-3d8d-4e92-29ce-08ddbaf98cca
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2025 12:51:53.1426
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uqCJVC8l5WMO+9RwDh3OqiJ0tECvxga0fIDZTjG8xomtPOdPw9qYb7jqxrYGWXFf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9238

On Thu, Jul 03, 2025 at 08:54:33AM -0700, Easwar Hariharan wrote:
> Per the PCIe spec, behavior of the PASID capability is undefined if the
> value of the PASID Enable bit changes while the Enable bit of the
> function's ATS control register is Set. Unfortunately,
> pdev_enable_caps() does exactly that by ordering enabling ATS for the
> device before enabling PASID.
> 
> Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> Cc: Vasant Hegde <vasant.hegde@amd.com>
> Cc: Jason Gunthorpe <jgg@nvidia.com>
> Cc: Jerry Snitselaar <jsnitsel@redhat.com>
> Fixes: eda8c2860ab679 ("iommu/amd: Enable device ATS/PASID/PRI capabilities independently")
> Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
> ---
>  drivers/iommu/amd/iommu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

The other two drivers look like they do it Ok.

Jason
