Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2076.outbound.protection.outlook.com [40.107.95.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D813133987
	for <iommu@lists.linux.dev>; Fri, 18 Oct 2024 16:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729267477; cv=fail; b=p70kOGEmmvDDbmUBkoblL0KFQdMyQVrLV5MApa5bPZyXZceNhqPn8Zju0j7vkS69J+2Gb38IfE6dvoE7kWAn+O9v2YlSHy63pWQNjaOdGoRALBK14teVnuqr1OQgrx4bPVHad2ZdKYtfxGbja6nq2eHi5UKcFgs6FTGpPQgpV2M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729267477; c=relaxed/simple;
	bh=5V5N0OzglO4M+c+zzskaeDgGdSUk/JVMu3/qu0pAhqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jDOskD0pl1IEtrjzccDf28A1n/vzxICER8oS7qZy3ig7zHmUyB0jEsZ20k5I9+qxWKPVE8vpNjuXBQ1Qe8uYm+4Y24BoFrOnXoZOUFvXxj3tKMKgC1TfZ7aNG6uiXeF/5TIWiFJlTcuUiK9yCf5JXj9C87MzSIWCfjnD5t7+BDE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=a56zxQa3; arc=fail smtp.client-ip=40.107.95.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="a56zxQa3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BjCsknVMvzyJ2qbHre4nWu7ZLrfnXPE8NUDoTixSI8H7Cm+VKO9qKmNLlwrPBJ/FL3Ad2y5EmNFq54Apz2PmavwrthzWHfejR+1zW1Td/i2G8DEH5LzNsZHvQzBTDyCEN0ECFr2EbiQrPXTSJpF3Bi3XE6KCKAufNyxGtcrC0V+02w37bYxazhaCWv+7c5bwEyBZQI2JmrHG30FJx0fEwjQTPyxcrFXb1QP2w99COxmplQLlbszw5sI2jxDYftrKXGYkzdjTOsW2X4Fm7Z/5tHgOY+x/d1s+5bDN/cRB0B47jFr3AmhkFgCXbm26Y3Iqtpn1JxYUIPTUf8IvWhYEBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cCMYHuuqGT8Ptq/gC63su1IcoPwk3Y4slNmZbybQr7U=;
 b=mmBA9DxxuBZmdq0kRZPUSUoSvbbu0kpV7Ipnj9SimJPybznU1wQ18bATXc1v/3UrAGFEH71BvZ+3arEtRJsyvFXyVLEYrn7xJZlbk9Sr3BlW3BMcuEikzOBRDBnIoRi0VVR1U5uQALK2fW08j1u+h+8/v//w8ep96nB65rhTmR8AhRfAffM+83NB9BC/M/KMjWHEQLUGqbtSCryUa/lt/OFXx+lgTr0Z5j7OGP07T3ZkmdZn/2wH8ZDZ4e3nO6ZjBfOwEFivcl6s47wRq5RGCb+baqIxAkngsIBAcDToymFZQPtWuLMGthuZRyb+aPgNJMVR7KpRIJHrm4WkZZMztw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cCMYHuuqGT8Ptq/gC63su1IcoPwk3Y4slNmZbybQr7U=;
 b=a56zxQa3NiYS80TdzF/7rn6q0sYpjowbiA9RLv5bGscRg2znfFq0KWKnlqNiSticCyP4RtxLAalfNXQV47xF/24MOhtjLSiG7No5eal1YjNG6ZVQJSETrijzytncKriAxh/AqtwHyCiryW33YKog1mDcnwfjgaf7K50D/p5fwO1evty1YvzFYmTqwLnvjaIU8kZK4tQ3P693uGUZcOVbPkZ+ac2tlhxnzVg2K6HhFH1dX5EgUpRRkm8o8LNNpG3tHqh8bhmMNvIkPrPLD4Tw26IBqKB7KgPFyHgf7fMjWtjMHf8yQAL+wvBdikDQrFLLarlw7Q24awMbHEafhjwdpw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SA1PR12MB8724.namprd12.prod.outlook.com (2603:10b6:806:38b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Fri, 18 Oct
 2024 16:04:31 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8069.020; Fri, 18 Oct 2024
 16:04:31 +0000
Date: Fri, 18 Oct 2024 13:04:30 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [PATCH V3 8/9] iommufd: optimize file mapping
Message-ID: <20241018160430.GJ3559746@nvidia.com>
References: <1728067700-32092-1-git-send-email-steven.sistare@oracle.com>
 <1728067700-32092-9-git-send-email-steven.sistare@oracle.com>
 <20241016130001.GI3559746@nvidia.com>
 <6fdad0c2-8b6a-433e-9405-016aaee40413@oracle.com>
 <20241017192418.GD3559746@nvidia.com>
 <c4574487-346a-427e-a97d-6e1ee366ed1a@oracle.com>
 <20241018001046.GF3559746@nvidia.com>
 <279c7e80-1d72-407e-bfb8-d286760a5e11@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <279c7e80-1d72-407e-bfb8-d286760a5e11@oracle.com>
X-ClientProxiedBy: MN2PR12CA0032.namprd12.prod.outlook.com
 (2603:10b6:208:a8::45) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SA1PR12MB8724:EE_
X-MS-Office365-Filtering-Correlation-Id: 3576b48c-7f64-488a-8706-08dcef8e8d3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8dLXf4daCTfBwKE3KT03PC4dt4pVve3Zw7gLa6oKcR6niHc/UA+ygKZHDziX?=
 =?us-ascii?Q?O6VJSEVD39eAf4GJloYYdgSx2VlPMHglE+sCo/1xG4hF6kUGCGA5bAlrwQkz?=
 =?us-ascii?Q?zHDQyYsMCmpDvj5cd7oH/4uvxi7XsSwoy0Sg90EpfiqRXoyzFuHLVKCf/H4m?=
 =?us-ascii?Q?JLSvjXgO7vC9fTOE3Li/M3k8TbnGr97qlM8NzHeVhvl/GOkrsQTiypEf7Xrh?=
 =?us-ascii?Q?eQ3Tow+JkrB7XksxR6fksKTFcfbX8uOcQ8O+RGz2V4dNAc90Cxoymv/Sn9gj?=
 =?us-ascii?Q?jxVS/apxwEKIjC7tIjIn2FhWX4SeZW3xKrZSGvPTVPhPNIBQ1PqhkeQaAU3o?=
 =?us-ascii?Q?4Z2SuPsIY75QPDwZIFIMqXXvoxMGYvgMcpL1AWFU77C1IIjLUE0exmpG5GVv?=
 =?us-ascii?Q?v+6TRb/EsB9CGV/Q0NWKfaZLVXQxHp/6kxzK4XcBafK4lPKhU0cPS2BEOblk?=
 =?us-ascii?Q?9YIyh2IwfDfAPRx6NsW22/t5dyUqihD1O8BSQjHDIKL2VomAzmA28KtCRUdr?=
 =?us-ascii?Q?zCrRb7hD32IktcLg2w0Lzy7389mzmV9ATCYzlpQGF5XTvSsJzNRMr7jKEXvd?=
 =?us-ascii?Q?HG8/4jllOZu+d9c9CYY/giPem5+x13nMv1AQgkgCf5kLY6EkxRcRb2HyC8k7?=
 =?us-ascii?Q?4+u0Tw7TuLStnMZNWjYKFblCfDLI7nMsYLELTBLvVe20KxTViuG8skNnnM/C?=
 =?us-ascii?Q?513p9uHWp5iU7Oe9+y6Dra6AEqHaxWds+Udf5Xx2BDk8FDPgqtO2iLGXcU+r?=
 =?us-ascii?Q?OGIKxV9+2HPYyk3vizvlU39RACdsPP+HeyUTqtAVv89CbM8wvPdse4wyn3vn?=
 =?us-ascii?Q?j/mLeZZnJUPkhUZItFJDsIhhpMzT2/HMho9QtbqxT1kZLJjQFIpDyO+q8Svm?=
 =?us-ascii?Q?E8nJIsvIzWAyHp/imbBmCPRUfyYE/a8ALP3Jd5YtBlSel4UYVAYHS2nG0Df1?=
 =?us-ascii?Q?AiahWNlge8J5nCVMbdta+Hq1GmwEx4HYytvvtxkyHXcKcGMNsFXKeyEOj+SR?=
 =?us-ascii?Q?w1Va+Ujn3Xsnjciv+TWKFBMrf47zwkpJbm4yVFOop0FRLGXmL1lXfkykbmHY?=
 =?us-ascii?Q?DCe4rhU1s4CGFw9ClAvouQo2DCFfr7DFEIgCc0yT4614Zz828R01HUWyuLZP?=
 =?us-ascii?Q?4rVjKKiNx1o1Paq/XHP375meke0HiZDYBS1naJLRqDeLPpo0z0dOu304Vg8/?=
 =?us-ascii?Q?f2DV5Z7KepNjwR42YgutBl5L9WfUJoDN2Z6X9BFQrJw1D5WbqORVjGbwU2/K?=
 =?us-ascii?Q?N9tspLrXX3D3XzMPz3xGLNAdLuxYqXlDJC6Jgz69HdMrMlAu8/eL/l8JBCDP?=
 =?us-ascii?Q?RZfQ7U/WT5f1Sywfe7Wy2Cvu?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cmdWB0odA0PKHf8o9I31NLJU9qqKp+CxT9r70CPLxjaUB+FoA01M8f2kLimN?=
 =?us-ascii?Q?1I9te2C0B8D29Ji3ByUYDp3EV+b92dekODvcKijx58vbUwmYDhA6c9OdBOUd?=
 =?us-ascii?Q?6dn6LlFH3k5ynNXTfng6f8wCZERQAYUofSxck/kb0e/IYh+KQUSO39RG8Dr4?=
 =?us-ascii?Q?trQlh+qmp5blBjBkEk81gGagO/wDbc1QR7OY2vgmNrTFfFQLhyNKtdGwuYNn?=
 =?us-ascii?Q?t1iZ0NiruaZlcpX0fMHBW+/sljo/NFBSurrRO8bvaVnQ3guL64vYZfOrFYF3?=
 =?us-ascii?Q?qoBHUYZlyC0pmMFje75bb5v4P69rJpNC20AUXwFstLwo3wo716Iz/8hEOl7I?=
 =?us-ascii?Q?IUJcz7ldMo35qLIuBS7BhBxYzM0zkhhgvuJ6FZQA9IadfI6yC8j+B6ZMtYV4?=
 =?us-ascii?Q?cHlXVJ7zS2Qj7qZeE3OO6ZtSxcqN7wSQMWxs7E3iTiPxEfAJbxOzGPezT/0g?=
 =?us-ascii?Q?v/HztJeFg6/48jG4vLsSUEiubr1uxbLxO6/c0EqeYLmiuwt1up9pfkyqynEh?=
 =?us-ascii?Q?V95yIKEoaYkteF4DuiRYZSPEXi6/ea2WJ9I/4/GvyKWwY/nnYTYg8nNiFS2c?=
 =?us-ascii?Q?udnvb/PWC0KJy+mJSFfmWvK6BWwGSjwO81Lq2hbB0kjWtuqwkMkBgCytSI8J?=
 =?us-ascii?Q?ml/jHcvB17yhV9+lhnx4O455Zi87y3qsWMEijFT2GW4vXOLQpviTQ1ugqG+e?=
 =?us-ascii?Q?J5J8MjjnXHVr+ifU3vuru6ezA3g43grl40H1hsvX6XNTzhLtHQQbYwxbYvaL?=
 =?us-ascii?Q?coVTA5ouVWrkaRIzFHtIiLm800efLk+NJtk24ITWIrSFs9Pz0+WD5D0hfJCx?=
 =?us-ascii?Q?vU06yPB8ZpbWO7An4gOhGHciTxf4mRMuwOMee9LuJ7utnSvT01ZgEgx5/5bc?=
 =?us-ascii?Q?n4xJBswEXJKBY7qke5+A3Biun2bLIARlnap4SAANkIB0tFvrB8OZcA0Zw2WK?=
 =?us-ascii?Q?tCZMjYRUuKrHdO7hPzJWRdtcyOP5D90a6/vtFDU08x7NmEyecuOKK18LOUau?=
 =?us-ascii?Q?7nmmN2iEjfM/MPW0KPKpTemkFQ+2ZYh+myj8DfZCnDDxs0fZDhlXfTl0LiZx?=
 =?us-ascii?Q?fdTLEaJMe3PVGnunUtOiNmBlkk7Rwo+sGlY44SaRlTRDPXpamnW7e1jxlWSD?=
 =?us-ascii?Q?5P5MQui938unh1JxdZrjhhAllyrvhAH/QAwLWB5PH7quqU+c0rdpKnn75Aof?=
 =?us-ascii?Q?whzeaYH89sPoUMiTHJbnigqMw2Bx+OA+L4WVhAwFQ3T/so2UoTrPw+u4mALS?=
 =?us-ascii?Q?A1x6kgaL50yeLLJay5oJWnEadM80ibDafGq2667QOC4Z8EZQSX/zA/i6BT/m?=
 =?us-ascii?Q?ntBLSWy0C8kaCuQAA4+8j4FKWbPzakVnQdNaHKRrda6IQlnNKWmwIRuo8UJC?=
 =?us-ascii?Q?jyDgvsdZ3kbF1AHckMebQSg1RGJ5+cmbYYKy1t/mifcC4xerxyn2a7QzDau1?=
 =?us-ascii?Q?wj/aoHUzl+I704imsAKItKX7Y9ELdLX1Z4pvFTrYJ9jaL9UfS/IoWoJlQey/?=
 =?us-ascii?Q?htK+PP6TledkEfrPlvqhwwq2JtocxqSOwzJhMxPKyWDm/PwXHAFs3cpvLHEU?=
 =?us-ascii?Q?WzPEyxxoec3lxN/E74rlrud/NFkeX4yQcEiKabOl?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3576b48c-7f64-488a-8706-08dcef8e8d3f
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 16:04:31.5606
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4h5zDvJA0KMpA58oegRtgkKTu5TL+K0TWsdpUBdO/0895bchboszDUQtXASQUEIc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8724

On Fri, Oct 18, 2024 at 10:34:39AM -0400, Steven Sistare wrote:
> > Ie instead of things like:
> > 
> > 		batch_from_folios_huge(&pfns->batch, &user->ufolios_next,
> > 				       &user->ufolios_offset, npages);
> > 
> > Where npages is the total number of pages inside the folio list, it
> > would be nfolios.
> 
> The problem is that a batch may reach capacity after accepting only part
> of a folio, a condition I forced in testing by reducing array_size and
> MAX_NPFNS. We need to track which folio is partial and what is the next index
> to use in the folio.  That is ufolios_next and ufolios_offset.

But why is that such a problem? The ufolios_offset already handles a
partial folio.

If the batch fills you leave ufolios_next alone and adjust
ufolios_offset. The next iteration does exactly the same as the first
iteration and takes the partial folio.

The refcount has to be handled carefully as the the portion that has
been put in the batch needs to be refcounted at 4k and the remainder
remain a single ref, but that just means adjusting the refcount after
putting it in the batch.

It seems like it just works naturally and avoids the double loop

Jason
