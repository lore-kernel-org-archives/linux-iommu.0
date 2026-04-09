Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012028.outbound.protection.outlook.com [52.101.48.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B7C313552
	for <iommu@lists.linux.dev>; Thu,  9 Apr 2026 18:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775759195; cv=fail; b=j0X7wZskpA5upxck+fdA3oMW6fG+ghHQS9/OawXitdOWQFmMGHGEDddo5AaoGKGChVLvmBzfeXZWW/WKzzurv/m7saOQxpNlIH6KtqIJmz3gKpgtl4cAzWebh6tusIDmczR1LyB3FWXI5rhF1Js6IHZ6xNg2JMcdlDRhagTFgEQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775759195; c=relaxed/simple;
	bh=GK1LPrM/kAinwUUJDROeNkHXRgx0xJnbDNIIlEomBrM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Y7MODTtOPtCr/IjAeg/1Q87kSOwef9VKvVeYs183zJYAxLOtI1dVS221HSuHIuoZ1Vt5eDwtj4yuZfyx8y0Ez9MoUJrHsxkXlcxhnUx5DQb1YVyx+DomPEc5phABcBymWPXzttlCocwtmw/SLd7Y7XjfiAgiv5zoUi4idYPVzw8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pz/Tc5sw; arc=fail smtp.client-ip=52.101.48.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pz/Tc5sw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IcjR0x5T/H3pEcXAPydMzPEXE5XRXKaspFkxIx3vuBDzsYngWDz5DvgorAATgzcT+E7mQ1J3PwURySV/yvE1tV2aRuSQfFuQnA7b3XuIkODhYFMyuYoW4hLImDBSAMp84Co0wNCE0pT9XF+ko27Ol/DwU8lN/VLEKBKUOQiPXdUNN8Fxsj91S+h/LzKPkIWboWPL5H/U6O046xdE0/414v+w/EfxFKnH0vaRMV7dnvA8jSeLl+pQrtFNxXs/ngsc8rWiERWzvlFeM2WHWCIuycZ1udMJAq0DgUl69GpAuSzQTsFidjwtRc0lAFYUUwn8CCXPrGweecAZRNp8QFoAvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hWDH8asmMLjzZiigqnP0RhEsaFRJmBZ7mo3b8GTe1w8=;
 b=O3XAV/omX1pNiue23rUuO7nRlJ6udvRGLIUNiAFtckj5OHT/Djwwj5vb7KoYccdwdUIUWZOwopwpK0uI5xBI0PI08hNNz2XT68Iw1QU+sLrB5cyrAppV9/6QcwdP1VGO8FC4L/IbLxuYX1CEluL/TeLai67UWFxrPPb8GxhiSk2tGjJ+pET6x4iaQK26abP0BXfDW4B2cPdiF66ThbtqiuBHH3kY8YyjBktu4Zx5OLPoCwFNKdB/wXI6rcZuahpwlMrBUGwpZ77jWTNx7D4j1z5Jrim3Nr3CV2AoZfbL4eDj8knzTbzWQZ1kIXDeJAuBe4gp0Xe0m0j21XNnOFbt/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hWDH8asmMLjzZiigqnP0RhEsaFRJmBZ7mo3b8GTe1w8=;
 b=pz/Tc5swK+301hZtsYWP9Pb1NXK4s+fY8FbEmZtclJWGgEaWOzOLsbN5i8fW/8mhe6e7BGVGYYcN2KZyFBEjoUksWkTlzby+QebFLB37mifr/HrdCFYTrg7mAMm9FcqTjffKCdE3h+r+kzhYRYEwC56H3dM63TIOaDTBSQ3zjQuQtqG5P60JvRyM5EDn8nrZ2orCdjRghKZ+TOjxbn0h/X7y8JDdrufgbS5JZJkKePpe6yVcUHIHo3NoXcxvmUYHzeWedTXSLaxuPSj0ipWB8Zr8WBMkwU61G26rkakMOdL5jQMZQfXCW9wltJgud2F9JBAsebg1qJEvUK2DEK3hfA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by IA0PR12MB8207.namprd12.prod.outlook.com (2603:10b6:208:401::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.42; Thu, 9 Apr
 2026 18:26:25 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9791.032; Thu, 9 Apr 2026
 18:26:25 +0000
Date: Thu, 9 Apr 2026 15:26:24 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jacob Pan <jacob.pan@linux.microsoft.com>
Cc: linux-kernel@vger.kernel.org,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Alex Williamson <alex@shazbot.org>, Joerg Roedel <joro@8bytes.org>,
	Mostafa Saleh <smostafa@google.com>,
	David Matlack <dmatlack@google.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	"Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
	skhawaja@google.com, pasha.tatashin@soleen.com,
	Will Deacon <will@kernel.org>, Baolu Lu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH V3 04/10] iommufd: Add an ioctl IOMMU_IOAS_GET_PA to
 query PA from IOVA
Message-ID: <20260409182624.GN3357077@nvidia.com>
References: <20260403051146.10210-1-jacob.pan@linux.microsoft.com>
 <20260403051146.10210-5-jacob.pan@linux.microsoft.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260403051146.10210-5-jacob.pan@linux.microsoft.com>
X-ClientProxiedBy: MN2PR07CA0007.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::17) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|IA0PR12MB8207:EE_
X-MS-Office365-Filtering-Correlation-Id: c0dbe917-46f1-4927-6957-08de96658239
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	IoJ6sIiTimuE7ZfG75XYwYJfEwguKhuIXEZ+YGkJAzXi5/EJ+abOQx7gpcw3Cgyi3IM8B9SyvPlIqjAd2kTOtyXoWd7jsKuDpJBbADgU0CLjKFsY+uUQV2Rlxprgq4pYRv56EaP+XSrX9S7e+DxfhFTp4FbnjvT/pgPt3g4baXFBmTwhjR3+q69v1sbCRWIAqj3snBik1V+9MKimU59qQ7rxiQFDxjRoAi/d+c9MVhS1ij9SJ3urOmx7XKjWfjB/0MbwUguM1kDFHjI6sHEN0Z2WZ+IqJsv4O9AQMExtJzpa7imu4r/ZUWMsOFxsZtwp8WGvGLqvUWsr9MEqqzZw/OcT75AaII3i2zRHqjqjW2sIKEYlli8iSW2nzfcD6T7FoQljMVuNlJ9qqbDKyrtyo3wy5N/LT4VzGf7Fpu48m1XN/R7KP983+iDqMtwG5cFZ0NS6EpEiXEJOLTorjNMBjUcJxHYr9K6zxKDuNFHjmts4XxI+5y63hgnJxJKj2dkCM4Z9B8TpeqimGPRHSw0heLRXKsPDPDJ9AdSO9CjjCx1M2QNONQeJZ2WI+W5/btwdrEP5VfxYoMSz4cBLpKRrLcVFzCI7MwslVY+WMTBcu/2Xf6YA8TXqAS1CHN/GRx3yQiKwU3LPCPcelB3PYRKZPnA5GYfNZciiBTWzleLk98NBrl5rPVUb/qQGxhk5CHfHjaBewP55Y3m1N0Dy0Ums2Amr4tPqlvMmHC5e0tWQvH4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gNJxBou3tvgGDyMmeGvPdUQ1/Zvs/QDj4qPCokmP+TLbBGFLqeMMVHQDxBZz?=
 =?us-ascii?Q?633j32BrE773L0edgVpVq5e95CZSsEnNwSg+9juqUx/IBSZCyWQDIsbpTp3C?=
 =?us-ascii?Q?hT5ePsXmog8hccpE5FVFZktGXzORNkgwJsuA+SuukaYCN9T1FYZojT1wlPtk?=
 =?us-ascii?Q?rGhQFwN4JK2PPHBPaoHXUpAzMNLMvPy0hzBxiAZ/AMkwQKWtUDVF6zc9Yils?=
 =?us-ascii?Q?tMY+ydDvopEPUwWnCxNbvsC+pyhGmNyJ9QFBnj2dPvtM8vKjqzxR/sGI+mI7?=
 =?us-ascii?Q?2AaKaHbE8CC5iZgp2EshGJTie9z9dOG5zpyxiSsJoMfqxiwUomVaVHdPhWQL?=
 =?us-ascii?Q?EontMFo8zO+Y1tgTungeAbco92JIgKIxuaIpZglqYt3TiDPSPJpAPViFAACb?=
 =?us-ascii?Q?T6MwpNhButvYDib0s4zISdB1x3U5Jzg3BZEIl5bXU18UVOLZKMYzFn7qyhNk?=
 =?us-ascii?Q?od18d5aOXt6eDGndcHUh1GEyZ+k+ITIeduGuu5fjQI2hqCImplNBc3IZyCx0?=
 =?us-ascii?Q?i5gPjYKc06eIgYib2+wUOl42SdKX6yw4vXDV4Afja2ehHgOOuFVx2bnUtvmb?=
 =?us-ascii?Q?6QEXvirD4kIJYah9QbZKfkC+BQhqPgkCnchr1WT6hlWq27p+ZrQKBXfK0CXV?=
 =?us-ascii?Q?rwNBTML1qKcP4b9tufrOtZJCNYTEDupiGS3nEAWfEziBnhIdYgIdkbXWvZZ+?=
 =?us-ascii?Q?Emhfinar+1S7l0apZrz3uvqdZXYwYn9QU5+H+/5BuXeePXF2dy5zLwvyRJBA?=
 =?us-ascii?Q?k5vNKGKLVs2iODgCfti1jXRzV9o0GPFPvXfPH7knDVIVhQzzmM0c776hkDjs?=
 =?us-ascii?Q?5VyRHyvL8ASeaAgCOWsOgCL03/hdkOB3MUmTZqsNocXK0qVjXyYdIK9YyPqu?=
 =?us-ascii?Q?QXyxnyQZMTEsaw1OYTrtCMDVs0EO59DucZu3t1NYv3k5IlPb7lkxh7aeAO2a?=
 =?us-ascii?Q?J6MdpfY7iuT5FOTbHldsWJvVoTuto9xRy2hkKsQpC9kLbzkhLkU0fFo8vyQi?=
 =?us-ascii?Q?6Sk6mpaxAikaub+GwHD7IQk1Z8a+0CRRnAbm4de4Lr6xY/Fa0vLU1sLZrAzO?=
 =?us-ascii?Q?2pViWHhZ3jPy/HB7T+0Ty6SyEgogQtzS4riFds8okZHmMz62o4UquWRyscn+?=
 =?us-ascii?Q?eJDC9HKsrUBdX7E6x1hyKQoEMXbJXwVQVwJSfvXvl7xmixJN6GfKxkhoiXGc?=
 =?us-ascii?Q?pH3JrAJrMSqLXVX9ijCe+OdNLxEgFBzHGb0iXqbWPrdXkbiKOHnlnZiX2Cmo?=
 =?us-ascii?Q?M2bFiq+dr2H382FSnh5IcwCd/79HR6VHiQO5WxRzKcl4Om8JaPkZgQPsXJy/?=
 =?us-ascii?Q?SJjG6BYkuqXqFuH1Z+1K6U/MDrtAsAlcLAXses8bC808PCNSK77o+lPr8dUZ?=
 =?us-ascii?Q?asxKwIYAtaGPENk4ROOEwcl3UgzFibMCgDoRkNpYFC+cDG9rsR8rr/U+TNIu?=
 =?us-ascii?Q?/YyIGw+mLC33lI7LMqM/yF56yC9vY4avbihAn65uu0CB0jTk0k9OT3RoQV+M?=
 =?us-ascii?Q?Q3YvdtCkp7ssLv1NixpHKqQM3WNWNB5gDcK/6SPMqzMySsG8V6w45Eles5O6?=
 =?us-ascii?Q?ZGWzUhRwsOhW7+V2eykz9PB8ID29gZwL728NK2nsmswgCavAtMlMngEGMejI?=
 =?us-ascii?Q?XVvozLIZVcC8TMHW01AhVMUHyOmRJINpLpVoPc+p2jixQ8bLkuTGYrPSQkwv?=
 =?us-ascii?Q?uBS9hzD6YJC3uhTUjROOsdjnP8uDbWOC5BaqQn5EhN6RFwks?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0dbe917-46f1-4927-6957-08de96658239
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 18:26:25.5176
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 432OYRnLMLf2Cx87XV7qGg7e4BUFh10nw83Co+VwC06K2ynpyVaf4mIv1J7h6R3g
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8207

On Thu, Apr 02, 2026 at 10:11:40PM -0700, Jacob Pan wrote:
> +	*paddr = iommu_iova_to_phys(area->storage_domain, iova);
> +	if (!*paddr) {
> +		rc = -EINVAL;
> +		goto unlock_exit;
> +	}
> +
> +	tmp_length = PAGE_SIZE;
> +	tmp_paddr = *paddr;

shashiko also points out that the length is too long if IOVA is
unaligned. We adjust the phys for unaligned IOVA but not the length:

@@ -879,7 +879,7 @@ int iopt_get_phys(struct io_pagetable *iopt, unsigned long iova, u64 *paddr,
                goto unlock_exit;
        }
 
-       tmp_length = PAGE_SIZE;
+       tmp_length = PAGE_SIZE - offset_in_page(iova);
        tmp_paddr = *paddr;
        /*
         * Scan the domain for the contiguous physical address length so that

Jason
