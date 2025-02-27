Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2074.outbound.protection.outlook.com [40.107.95.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96421AB6D8
	for <iommu@lists.linux.dev>; Thu, 27 Feb 2025 20:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740687429; cv=fail; b=J+0iT5m9JI3ZC61k3GaDHRLunpGVSXAyTFePyFULhjKUDm2bjuyLmtavvvC2SV0kL4BRBmmZ6SOWPlukpZc+SH+1P11vC3ZjtGkXxYhguhs+a7wF4sYHKb/HEO4b6IiXHb22ZZryRAsr+5rKTCjXx+WtwO8PJYXdxUHXdyFC6J4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740687429; c=relaxed/simple;
	bh=4jjod7fX4ptj8q23kpvEkjvbWQIHyVqZJQFmxjSXwzA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VIB8ip1PDYTdfk21cVGr+R31jkfDIUmOGYukJbH+K5kVcKqQXT+Sg0GNLfeB/uxE8vR8kQi3c8QgOzQ2KzXSo4NX/H2lmD+SvgiXGBUSbC27Wz5SkpwRNQulPUfPQZy4Du2AytjJHLnRufNjjMGLYT+uLBRSZz9V6JUWbXlF294=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eqzrRyz/; arc=fail smtp.client-ip=40.107.95.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eqzrRyz/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jI+h0svJhEEHBc30mLwY77gmI63rIpAW5poQpZQEm7vBSf+bqJQMwgmWepYEaGqZ3jCPCSAo/nWmi+WAQPX9/teiqJH3AD91uSkBZa22waqb9PAeDw7LqYqrYDbm4vkRgs3Gr0s8ENlilcNE0FgMWtIm08yppqXZYYDxuZFUfe56ePiVQQwkkJ086gzY4czywEfNvGgGLr8am1eIMFm5KeVi6hb7wO2zf0dfAL2wK5kf0KLOFQLF+QqeqV+hfBSb4KYNChLBZ8RDeCmbhGnoqpV68HuZlwxo7QPGr1YNYQDRGIpkhkqmDLZ87H32X4mxG7Lf7407R/OBdvGNGbmZiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4jjod7fX4ptj8q23kpvEkjvbWQIHyVqZJQFmxjSXwzA=;
 b=PFumpdQA+UNOXwsLciRe/qoCHSu4fAhODYgb/Bp6uzcOPvqS+754euzw5S28FPw1HGFjFum4c4LCzM4XM6EJs2v+2Uh/frhCywiC5vSm/bUuM+XVhUbodc5sxCMJa+KnfdpOh1ReHMKZYDaH1A+E/2TnwKsDrp9VkJ7T+8LjoXuuswvXg7xOUTwxvkg/UCoZ6B7ZZCuCJ2Frkq8+FGiqHWZCRoYWQt2NaYzyXseuVyFacbSym32BCG3o9auWMjUJNXoU/g/OWuNrML73VCoTbLDiqba6Iwgm1JJeFRrbjgXu/uYoF+bqfuszRR285WL1M/EXgCmISJ6n+UK3F2j/Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4jjod7fX4ptj8q23kpvEkjvbWQIHyVqZJQFmxjSXwzA=;
 b=eqzrRyz/Lwp8nU1SJQDS4CCkeOQWFmekI0EfhH8X7ZBYXc0G/KMnYfFTd56jAMd3oZRKIv6xrbJZH19wS1QW5iXNPzcQ9RXAYOfPBbxjdqgrb3t/HAHdqiCThCishpnfad6iDKtnssNK6ryIiVIvH2OLMhwfgbLeR6S6uAAbBmkRIw3inib1wyUtxnZl9dMNdHbtBXmML3UqOiQwrI5r/82gt59FVVJ0ONXtfV0XcHTv7qUEKghuLeq02bzbl9F/nUeQh/0KjZVes0lwHftRIbpDIzDr3asI4ujIuW7uWKlhhX5eD18Vmyy7UVJrYhJ+NLEnAGprX+ySBHEptcztfQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW6PR12MB8663.namprd12.prod.outlook.com (2603:10b6:303:240::9)
 by LV2PR12MB6016.namprd12.prod.outlook.com (2603:10b6:408:14e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Thu, 27 Feb
 2025 20:17:03 +0000
Received: from MW6PR12MB8663.namprd12.prod.outlook.com
 ([fe80::594:5be3:34d:77f]) by MW6PR12MB8663.namprd12.prod.outlook.com
 ([fe80::594:5be3:34d:77f%2]) with mapi id 15.20.8489.018; Thu, 27 Feb 2025
 20:17:02 +0000
Date: Thu, 27 Feb 2025 16:17:01 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Yi Liu <yi.l.liu@intel.com>, kevin.tian@intel.com, joro@8bytes.org,
	iommu@lists.linux.dev, nicolinc@nvidia.com
Subject: Re: [PATCH v8 09/12] iommufd: Allow allocating PASID-compatible
 domain
Message-ID: <20250227201701.GN39591@nvidia.com>
References: <20250226114032.4591-1-yi.l.liu@intel.com>
 <20250226114032.4591-10-yi.l.liu@intel.com>
 <2c03eeaa-d9c9-4b4a-bf15-c1d1c2a79b36@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c03eeaa-d9c9-4b4a-bf15-c1d1c2a79b36@linux.intel.com>
X-ClientProxiedBy: CY5P221CA0039.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:930:4::15) To MW6PR12MB8663.namprd12.prod.outlook.com
 (2603:10b6:303:240::9)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR12MB8663:EE_|LV2PR12MB6016:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ffd6aad-473a-4c8e-0e0a-08dd576bb2a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hDameekXYzcEroxmSeH6Tr9t78Hj5wLFjUr4NKNQ0BvG0r0R8LU39YAAuUHz?=
 =?us-ascii?Q?tdZ3BqaWYfIN3jyARPJJHeW5H32Xl7gbt+bZ/pP0m77iDbQSXSELg1Ic8I18?=
 =?us-ascii?Q?D11tnqVfpKD4kf45jAuEdUv+SzhQMAxrJMoAOOh4sgx0Roe0ckkyd7Az2wQ1?=
 =?us-ascii?Q?iIXoORqKI6s556ME6R4SZxhjJDUb5MgiRsWxWvIYTdTYVutunSzw/IebgJy9?=
 =?us-ascii?Q?jbcMBE//kD9v4C4K79KwJmektRZCJAObXHfiKDTRG4PvSCLZjWVcvCWsu1I4?=
 =?us-ascii?Q?mbjHgoHbjYDjLFCw/OvwYpTZw4MjtYGhYt5zkV9fjpp2p6zfdQcOrgaFdT7c?=
 =?us-ascii?Q?+2SroN7AJNfYc/3LiVIzQGgyb1Ri/Um/nCdMwKEm1gWy1eaubE1d0Zma9Bah?=
 =?us-ascii?Q?VtHhodKlZcDdgN13ECvkyLf7R5IF4fsOVjQPzpDkCipvuNtEztjHTJBMKQZ8?=
 =?us-ascii?Q?aZa/R2yGwSy96cD1h0mV8b7j4ngZVqdrC4gESoLQTLgywtVN2CdKZv7Rh8++?=
 =?us-ascii?Q?AE2NkzFPmkGdgeAs0FLExnHKrVtTqcyhG6IvlENocAH7+iICLe1H36+zXWI2?=
 =?us-ascii?Q?/sMH9RZUPFX7zmKwlhv5cZC7Ix6l4xvJ3SG8h2agUtSmGsYLiWZChtux98NQ?=
 =?us-ascii?Q?6byjwh0WXOvGJgZsZy9nH+duiIlVqk4079Qq3u4MKG40grmE2zW/3XzY/PQY?=
 =?us-ascii?Q?FXtiEjRuqefwISBcd2ImuWb2OJrKwXXGGGXLNidbP4avCbRgFSZ3sp4MK9Cc?=
 =?us-ascii?Q?qB66P3EEdKYHp4Y/hJzMLCPYLgzWB4w4VsF4Pws19WlzpFh5B0hKKx3Se27l?=
 =?us-ascii?Q?tOXo9QobslqVTLFhP4ZzVmqvu7OBjDccK4EM/DdJtgji5CHlhc59PYkABH+e?=
 =?us-ascii?Q?umpsiMzBtb5ginLEkoxwTREG4ZBuor8mguFWO3onahB61zq5pJ1CS5zdecYP?=
 =?us-ascii?Q?4F4b6Zw8Wbt24YpjhBp5etpOf+E9JaX7cyYHvwabf1vrb7bnpjAsteJjtGNu?=
 =?us-ascii?Q?2jhk2ABjIQ94AOa6wQMj+Vh7EAHy7cjdCIrH6njZfqW6fpjReBZJbPa9UurA?=
 =?us-ascii?Q?ITcZLt9ceG52wjEo8TMCnOUvJVLPBj/crg0JHYS66cewVL3hzFdmLuzaZbUN?=
 =?us-ascii?Q?CalndgTdJtLRyyjmdx89jg8su+xtFqhs6WIv80VdZHmEQaBGaA26+Oaj7il9?=
 =?us-ascii?Q?2SaKsa6L6D50EI5bfqQ1CURIh5cji5W6dSlkQQ9GoRE5ZawFo7grCvQLefAI?=
 =?us-ascii?Q?WGwDgfO8FD14EiJYMC/iZNv4N8AYsCU01Gvyfd0nlJTMuJezYqF2Lq4gRCmO?=
 =?us-ascii?Q?Tb84m5taJJrYZN9eIGihnGgGGOzN+GQGk60Ro/cAeSe4Z0qU+pzZCr3ykJNj?=
 =?us-ascii?Q?xXAQ4EHNeYD6ZdZ8RgET1p+uZj3g?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR12MB8663.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RGRd3YOYdhqBj2o6mjnNGH+Mo6TPyTU7TscJSRZRpQM2h/o9bLXERgXSnjRR?=
 =?us-ascii?Q?4FMuqX/hXucgeveiPOeIv4FZYaRNh8r/W57uLX0g6FcM6p9iH6Ju1frvMzxJ?=
 =?us-ascii?Q?6apT7sBSM7xoPXcyrFljNDvALwa57knB5hsYZ4gZ0ndvUYaz1vTuc8icqVdp?=
 =?us-ascii?Q?uFxwkmfMLmx3of88Po0JjSyF0e63wG12mXI/VbvgOwVVZlKuuNcDdEUEFn8w?=
 =?us-ascii?Q?uzy9983mLKay4k9RhwXIsUO641jT10zlIA2c137UjOwSHcGeklMxc0xyBjG3?=
 =?us-ascii?Q?riWuFyuamdzJ4R96g1CcK0IPz+Ex0rGfpOzn9Xhkqon96EDt+EuWf41I0SOH?=
 =?us-ascii?Q?HS9128x1IxqxPDaJ6szzGXVs7bdOY27Q2nR8UNO5YrMZfB/aOqDpDvdyOt7a?=
 =?us-ascii?Q?fX2zcQTG+HRBmtZosCx4lH40YB/2OkGWqda7gC71PJnO4kgbdyCoy23rvBHz?=
 =?us-ascii?Q?HHFAbN/Q9O8qBKg3idI75Tgm3jIaodJYhLdl1bsZQN2Ia+ohYtMgvk2WFlQf?=
 =?us-ascii?Q?a7nXmJ7V/x+gyeKPtIZ4sFXPu8+AQeD2RCVb77FRG3X3N7qd0kmBCz5lM4PQ?=
 =?us-ascii?Q?DYajm11CJOrbQYTW08WhNNGfyHx4wHUbcfHVHbKXu2w/a1cEzw8Cj5TuDMdf?=
 =?us-ascii?Q?AyF/EVvaPM3RxGc9BhrGUuVodWYdratPJ4Sw/K/PvJXmXFQj97/px0pGu0Pq?=
 =?us-ascii?Q?P6QRh8/6qzd8C/wvEcXiDcKrzatQbDAtWXxvm8ppBuB7fWp8XuKerg1kvwn9?=
 =?us-ascii?Q?UiEolSnBC2z4/cLkeihJ9btg5/BdXs8lFpZvU5L9wAbaBYdqW4MgvPlB1iA9?=
 =?us-ascii?Q?IYYy1d7Heo0tZ2I5w0lPYynHAzNbNEoYEDYGll+lC0YzULFPLB/aSo2q9CWJ?=
 =?us-ascii?Q?mC5ypwh/uo4ua1Vgy0+sjUJjHJx1MOTju1QhF3yuVR5sZdG3Xx1muAtTSseU?=
 =?us-ascii?Q?7Y1HOqODIiaEFgxNOHBBCuqQwGwb8uhVXehNg4V5cuxSaCww16eF6LMkIuhz?=
 =?us-ascii?Q?gPhsKXxFTlevAFQMqoq3GS2CZmitE9Ri5lFraJiv/iBxfps13+VnORex4/MN?=
 =?us-ascii?Q?wNTzLFqQFPMj6Hjeeun6Yxm6d8u8lIejeaxAxHJnruxgwUsc+QaHbKTn5hGp?=
 =?us-ascii?Q?u6h7Sy7aSAhFTYV2g7zRTleNbni01z/7DDLzwGxoNylDSuftpQckWrzt/JdG?=
 =?us-ascii?Q?wKB6AzMKx+1I7bBpJJw2H3RnAV05WEaSEgynFzlYcirtEYUa+ymhAlBKOW56?=
 =?us-ascii?Q?08YyCd4cOvwKWZf0+k7Alarb+kvu+4Wg04XSJR8npmpZi1yVL+VpCfMvmV8k?=
 =?us-ascii?Q?kwC5gXGU0FU78wcWz1dqzcCQFm57mdh1YxnWCIrr7B5PCx+5FAUwASEVj6pw?=
 =?us-ascii?Q?95/fcX11scI1ZcQkYCe6DAcIZHkmqUGllyyELuYMVJqbbennJvvPm7Znd5GS?=
 =?us-ascii?Q?qSlpo1WPRsVklLew6Io8EnH9IHvvrFDvo7XGgbd1PgmJ+EbJ93eT0zYuyICU?=
 =?us-ascii?Q?3ypUDIizDTGWVhoUS62Z/AdI9sgk/bPT16kvEr1+9NaFVhd29by3Y89FUwS3?=
 =?us-ascii?Q?ZUzjyQVWmzRhnchc8FZq5R5hcfZddoI2PoIMUEnn?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ffd6aad-473a-4c8e-0e0a-08dd576bb2a3
X-MS-Exchange-CrossTenant-AuthSource: MW6PR12MB8663.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 20:17:02.8490
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LJSeUTOcMtd6fx+pMgSWoMSUJnTrMcNIuTGftkpi1FXXV1nyvo2XXBow4GhygBg4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB6016

On Thu, Feb 27, 2025 at 12:00:18PM +0800, Baolu Lu wrote:

> If that's the case, wouldn't the PASID-compatible domain logic
> introduced here a dead code? Why not placing it in a separate series and
> test it on real hardware before merging?

ARM requires it too and does support general pasids.

Jason
