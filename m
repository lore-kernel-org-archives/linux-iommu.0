Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011061.outbound.protection.outlook.com [52.101.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8BB34AB06
	for <iommu@lists.linux.dev>; Wed,  8 Apr 2026 16:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775665734; cv=fail; b=gVtAqu6j/1XGM5OjpqVs4YhBtv5rJQ8lkNd5hpvzS689AT12xBNnSxIzZSkKwlkoLFeXBDO+OlKQAEcFjumk3/RzDp/3MKCt3zvWa6B6/LzoV4iAbbGYU25fH5EiJabbFm3O2/nxB7tJ6q/0uzMYR038LwWUNx96nJgfgl6sRBs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775665734; c=relaxed/simple;
	bh=XFV7Jka4SDoxmkHCerqxO7dX5HeXIkEZHk7kV4eA/MY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=peuVuybOz9pNXr4wb6bzjuwrv2HmDKAMHF9qZeEzJIMgdH9aLjDbP814/hPrqdypQzwvUsWkOsSHSlXGCORDfJHnvIqUhXIfAVxP0AqrmtkuXLSzNiYqdxhMVXoqfoeOWS/VbUufaBvgd7da8dFtKFZjYmVUYY1vHgz5wbuVERo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=onrITpeZ; arc=fail smtp.client-ip=52.101.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="onrITpeZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kaoPTOaKybP1O8CXl2o0DHc4W4A4Nj7P069PyIDR8HV9LQ/hUhgOG7MZYxdLa50iPtVQ6DRM5cyTGJZ93z43Uw+tdnHJP4tQ0+6w542KNvC8wcq5R6TWs1DIq0sTAFY+O0hJmQ9rv4lv9KIBEpE0fCt9iL2GF8v4C+4w+KbH9dPRr/vaxgMBc1ib13s7zAKjf/SEkCi4BEMMkvrw4sh1JEWwGo7/Ir0yP8prP4VkyqloS1nqDfCZzktMMZP3F7x3ZcyMSC01yTM/uM1Dkhbh54h+pUnLeEmDIQSOEhwaoKTH5Gp8lm1i+Z3uE2VB/VDOLU5p2/MkQRi7F++8dXL9iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bQGCqPJfPJwO+txCoVipv7aorf/CHq32Pau5jsk5tYo=;
 b=Hrwkmu7r9KMiTH3dNA2VM3nFCkgtgseckG+y2dlEUZQKM9woDac4BcoiAiOFvIgmEHCWbQa7TuReaKE5sBWkSbUzmwqfE8r2vju0lypF3E89mqy161XiMM/+/VfJgd9Y3c6Fs/viqcvez84nhn1JDPNg3Yd7y5O8RxmnYaLMOz/9WUav/BZIYxqH153vbnSwahZOU9ZAYqeAA/l/tHYkwaDaZEcYwfizUTrNhxRJi+PF93wRmUneBSa/M23eV5TYHAztIqfCBWlg49srmXMM9NEniNxDFpQu/F0eaSxkK6SfnAjY980ocy3XQPRKM89uHIaNqNLofVY1pkp1/qJeKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bQGCqPJfPJwO+txCoVipv7aorf/CHq32Pau5jsk5tYo=;
 b=onrITpeZZpcBxb2HSPNWBAxQSaeBe5iprCweWGAMyyLU7mGt6BMxr0fxqzOG0K7SGYDzSegKlJ6/AvdoTdil/Cgm2hq/LzrlasuQI4MT23hTjBrzPLhww/Sz2gGLyn9CJ4cbv+lA2gi0m4p+0s9Zh40zQ+FSZVRTeKmP+XVnIHlNZHXQRecVSBcuzm86ASj4CNrPyNRyJXDEsNjwJj17i4N+fFk4IU6xzBlf2WtPMgdNFmXya2JqrwOl92ahDo6DgKJzsARtUO9k3FNtNWN9Jn5axB+ie1l+1ECSF2XjOydGruzXJreZTgSmM2eIt8vq4VCT8WyKWD4CH1KZzDbmVQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DM3PR12MB9328.namprd12.prod.outlook.com (2603:10b6:0:44::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Wed, 8 Apr
 2026 16:28:48 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9769.017; Wed, 8 Apr 2026
 16:28:48 +0000
Date: Wed, 8 Apr 2026 13:28:46 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: joro@8bytes.org, will@kernel.org, linux@armlinux.org.uk,
	iommu@lists.linux.dev, linux-tegra@vger.kernel.org,
	Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH] iommu: Ensure .iotlb_sync is called correctly
Message-ID: <20260408162846.GE3357077@nvidia.com>
References: <8982e3412563cf91e106d59228dfb6115024c75e.1775659257.git.robin.murphy@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8982e3412563cf91e106d59228dfb6115024c75e.1775659257.git.robin.murphy@arm.com>
X-ClientProxiedBy: BL1PR13CA0406.namprd13.prod.outlook.com
 (2603:10b6:208:2c2::21) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DM3PR12MB9328:EE_
X-MS-Office365-Filtering-Correlation-Id: 024020ca-b2e8-49a7-a15a-08de958be949
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	m0CejDfb7aFWKXuRq1RoyxQktKV1/LHVjS+NMU8btc5270EVhmiSppeyaLYxMH+TcOs35jD53nVWKlbp3MolMpIg6xc848mUyiQFoj8yXSi2maX4OoJ0SdFeXRFY1oBziNoGk0XEtk383z7P7F7QBTTS5G1nLsoSjv/taQ4kNiR2aaBbcDa5s2Juvhv3ERiSVUAmHI1Gz5ellqTytArNNWKTGbGjp/7uQo2bOXgEFT0IhuCdq9Ktf5KuBn6Vd30MtKewX9p2PB4s3EhkLefxAROtMCAI3y3M1C/Pb5hofvB2ShaNy17D3G5ppZluuRbdl4kjd2FbVy/lY97Kd8qwmkziQ/IBIKG26xMcxpxjzwauygsDRmPwg8XE65B3yGSdHxcy3ve4/ZvR7sUMCBmZyq75DI7I2f8KS5uzW7esMVMV3o3XqS0xgI7Icggaz5R/b3GLqrieE0e0s8Jcny7zX4Jrp65XnZBmEguWpT8Hmg3/C3EGaBpb06GQGU7bwFWPpA+3PlneiZI73FLjkMWYLA4bOXlPYGq9qYAJRJJcbWUuXGeTIBHwHyCNzWUhjZccxiVVWy/bqHd2ZLg9/pXClMb/hdKzbfnThVdZCsz6BIJvUl933iuif421pyD2FTtLW9OC5w6lVd9d8vg4d+fF9mNGjYhzdETZJKaACNZ9oRe1t4cb5qTJ9/lv3enCphuwP//94w6Z+0Asrsx8BF4JF3Lv3YUvm9lU6n153l7kQ/Q=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PLRcL9PUwsAjPIz2JW9Xnrr2VM2+GJYQ9/FvVbqIcPsdKfX28yhxfggpnEQs?=
 =?us-ascii?Q?ysvSW51vAvY0ZfUkbvrGKAhtZ/5fUetK34wYl6rvP3D3RQ0Rs5oxz/0F9kO3?=
 =?us-ascii?Q?86oMs8Xfa93IU3o+imrrmcjhHRk5KweTCWOfiyb0v+c7RgIHwuFbtokuY386?=
 =?us-ascii?Q?7NHnO9RsRpWv6QVq0ejpiRh90gGt0JxByZiSJfJdPhvqyUM+1qA3EZTpluyN?=
 =?us-ascii?Q?yR9CX+hWveuCjBrbsPWTU3BTHfNh0IZV86G/TJvLXpJV63ZsNFKhcFPZW8WU?=
 =?us-ascii?Q?+p5zBCTHmEaTpa2iTXrxHfDsPEx4jgVc6bBLM7rUaV0oYZm0qw1EEKyWsszt?=
 =?us-ascii?Q?ODaxt+iS9f8MrzUmNXcwiVRsVI42rJst0ZPCKWgn70iGd5th/xDZDd7qZt9D?=
 =?us-ascii?Q?MFXMtLVlIXbBTdKkmck4FV1cgX8RDwVrrb8IZ+wJkgaYxqpKb+NxA37NuZlN?=
 =?us-ascii?Q?Q+TGX7HzqdCu+IxIit6gDHPRxUWhQACtM0ZUPBSZcvtSKu0Bx2zS9E26hZ8I?=
 =?us-ascii?Q?p0LvcabM1P8pMfBmXypmjUjfSFr+oIIVzYQqXc7H0b8S0XgR71X8YgLtwVuE?=
 =?us-ascii?Q?xMLwxKA2GzqHrVo+lFXnqvDjBIjoTEiO6Alsz3c4XMPjJUp7/Prnaln4KH0g?=
 =?us-ascii?Q?XVGVGPT0eOnpKUvLv32W7rGdtqzNHVctryEi8eD7pAKDtLBQ2j+YyMbIPpOM?=
 =?us-ascii?Q?c8k2wHvCRBpyAgzD5eQDo3qECYpKK3LJrxSzXNDDXmevDzOC3rcnoMcLC3kb?=
 =?us-ascii?Q?cT18iGoABGVdTiMcqDykKJ/0XEr9X6ffvKDru2e4r2wzBuuqwk0oe6/aY8/x?=
 =?us-ascii?Q?E4ItOviSF5PqLw5lw19gRNlH7eR319oz+wv0ssp8dXqgDyRV9582q1eEXFjS?=
 =?us-ascii?Q?TOEF6qPjDYvqBqgOoym0LoFO4OzFxworWyc2ouqbuoZuulrZTpOFHWnJGqfi?=
 =?us-ascii?Q?dJWtKJxl4rCR74WowiIyiWj6k6Y7ga1gQO5xPE4REO4pjpcaBbO6a9+qD3Rl?=
 =?us-ascii?Q?fSnD9uXhn1YphTu957zoz5Jt7TFAGYbjXtfm7DMyEZEX06BGZ+vYBMQ50ozU?=
 =?us-ascii?Q?lL2crGyneZKXmn2x7AUIqH8L61Ca5ZsO4Sz0V5eUj+OChIoe8PuOtC3AKWla?=
 =?us-ascii?Q?QoAkEZlX/AaYF+1INRTb/tR6mMzVKf6fdDSKz0WS0FaLbOO6TYHTM8i2cAt0?=
 =?us-ascii?Q?fTrdOsPDaVqYNf6qKr7zlM7NH50fLILNsNfARt3XsJ5UV5hdNYqFPkCQ4eKl?=
 =?us-ascii?Q?DWzKpOUAHss3oiQPfUmhveHIuqtRFL13oV71lOzJZmAlNNFDJ1cK2sXdkp+o?=
 =?us-ascii?Q?4h2BhIW5ays2sJ1iKDCAxfx12WJDdZn+IVBwR/Roa5TMBKCoS/vTw5ufVrJ1?=
 =?us-ascii?Q?r5fYObc8xLk4ET+gtyqfhgzZFaSz4mMpPaYUDBl4caUH3l0YURAkiFlPhnbs?=
 =?us-ascii?Q?3rsENOE22gPER3sRFdqYLMOaVxoYdBRWJuA0Wqx82bW07rx+AWTnjbQ4CgaJ?=
 =?us-ascii?Q?5fJIRE0KJN7nfUwD0g1Prnx4ACd2KsIEdQreDvQSAQyLgfbQcoDc5xomwv4Q?=
 =?us-ascii?Q?9f8xoyNrqB5kdahK1j6syV655NRXX/HyQTykb5FI4JW5TcSFPls3WVLneht5?=
 =?us-ascii?Q?2jDPbHerZAwA7sEMdmUs+BssiScwHuloXTICfS4pPS/rZV2YM0l3lN+Jj5Q2?=
 =?us-ascii?Q?3PrXjwxsjd5AUkUEVE6Neb/6Oyq8ELNOdTLPO+squeLJY9Bm?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 024020ca-b2e8-49a7-a15a-08de958be949
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2026 16:28:48.2226
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2m0ba3smGaKfa6orUBLlSC2BAKI/EDi9UhWAh2a6Jq0n679enAaJ9sOMVVGYYrOZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9328

On Wed, Apr 08, 2026 at 03:40:57PM +0100, Robin Murphy wrote:
> Many drivers have no reason to use the iotlb_gather mechanism, but do
> still depend on .iotlb_sync being called to properly complete an unmap.
> Since the core code is now relying on the gather to detect when there
> is legitimately something to sync, it should also take care of encoding
> a successful unmap when the driver does not touch the gather itself.
> 
> Fixes: 90c5def10bea ("iommu: Do not call drivers for empty gathers")
> Reported-by: Jon Hunter <jonathanh@nvidia.com>
> Closes: https://lore.kernel.org/r/8800a38b-8515-4bbe-af15-0dae81274bf7@nvidia.com
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/iommu/iommu.c | 6 ++++++
>  1 file changed, 6 insertions(+)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
