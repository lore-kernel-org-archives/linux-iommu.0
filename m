Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2040.outbound.protection.outlook.com [40.107.244.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8BD526F46E
	for <iommu@lists.linux.dev>; Thu, 27 Feb 2025 20:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740687113; cv=fail; b=Lit2m8ayGsgQy2YMjtXOROuPMLX8q7oSsnXnpWPWzJJ74S6GwxevQGCfsKBziAXafM6pd80TDEmR9eNy4m1p7ZptcwSUdWISr+qbMWUXycDlHI9bjw6D11iOFv1v6vHIAO4WGFYVOF6sWHgN9sV9VLOySOr5wJkyONwS0vSahqo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740687113; c=relaxed/simple;
	bh=LOZiRNVEXLpVfVA/EAbsEbR7lF7Q7+0iQQVx9suVyo4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hRZYpXVFtP37OC6ZqOjz4sg61YNBv2UKOzhkpJ627jYbIQjej7pKMyt3It/ckpP0cW0uaZCykPD53vprbl9Dz8UAvTkFhE1kN6dHGqXND2X7SNHOm1pHvr0IQJrlsDGMXYVdGN45jmNxfzNjhsuBp0gxWKKzbMxT7IbQ5hslmOw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HF7JjJvd; arc=fail smtp.client-ip=40.107.244.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HF7JjJvd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PEriWk+62ZaNDBYn2o+uo0KpRzxxu4LBnxu+SNEvJBisEuaM8iWuNS/6v2BNETcg58Ec6XnVF+X7O61Q9v2e28jwMjLq5+XSdT42AQFAuSmIll8GfMJ5FR6PonEeXLJv9YSkU6NjnWw5Vjlgq7pYEKjQ5BFdgx+7Ud9K1tXlrx1SkBvSnQk7pfdkwrlX+JzdmZKezro1seVY5577A3aLxQ+ieR2ZzHqzGTOj7AJsBdaSV+RwXIYrV4OZbOk1jp5mWER0hUqKMf8hD2ol6adpbCkjs6cvDPELXwGB4wFsQ/TErytB08Ts/6+JCPFxF6/J/qhICyGY/Gf5xkT9r7hwVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LOZiRNVEXLpVfVA/EAbsEbR7lF7Q7+0iQQVx9suVyo4=;
 b=fivCj+uFtdVp58phmW9TaiokPp5gDD6B1u3JZ17jnPNMidp8KN4bJVFkqHKSg6j3HopDdjjU8ZfsaC2XorIBxti5akxxpwJMGwSjhhdXkUPeKgGjbGYs3+z3JHZi5N7N5PnV7J/oexnNxlguCvKPsfKJA9lR3yxIyvLocOSeUxuRTgfxMv1bAFh9M/K7jGT6yBdPsPbs0aRtfa3jlb8lG2BDlOaECh26seinScFJoZ2MOHlhJrVxgX7M6oI6Scis/Lo8ayRQeozVWpfP0G1MPYWiOJQARhOOPWYYj5K5m5B9Q3SC0mfzSCo7hRyGE4dDmJaNWM7q+iyD8QLFfhAtzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LOZiRNVEXLpVfVA/EAbsEbR7lF7Q7+0iQQVx9suVyo4=;
 b=HF7JjJvdTOPDA1NqMcw20+NWtACkmvausxBUj4ACvPhZlw+Wfxcvqnz17m5K3dPQLfbhaYiK3u/wBe3eEWSzHZxCHquXLefAR502psjfs9gzs3RVYA9h2BoHhQfVkCkhI5+SVEDzOCGeC6LV94QE886r2x4wPEF198lxF8RsDkbT+s1PDXV/zE8uVVXZEVE1gpHxykXnpsbBjXy/4CBSOddSN8m2bGNiAiaC5/liihEAQtbqYBufHQOw4faOMfrmfCY0+2rb9hhVZtRzjru6cwFGApj4v9FA5lfxe0+U20cX59GJLLA24e2gzdlcCjoyIkk9P5ygCFJqxBFq7isLVQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW6PR12MB8663.namprd12.prod.outlook.com (2603:10b6:303:240::9)
 by CY5PR12MB6550.namprd12.prod.outlook.com (2603:10b6:930:42::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Thu, 27 Feb
 2025 20:11:48 +0000
Received: from MW6PR12MB8663.namprd12.prod.outlook.com
 ([fe80::594:5be3:34d:77f]) by MW6PR12MB8663.namprd12.prod.outlook.com
 ([fe80::594:5be3:34d:77f%2]) with mapi id 15.20.8489.018; Thu, 27 Feb 2025
 20:11:48 +0000
Date: Thu, 27 Feb 2025 16:11:46 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Yi Liu <yi.l.liu@intel.com>
Cc: kevin.tian@intel.com, joro@8bytes.org, baolu.lu@linux.intel.com,
	iommu@lists.linux.dev, nicolinc@nvidia.com
Subject: Re: [PATCH 2/2] iommufd/selftest: Add coverage for RID replace
 between handle and non-handle
Message-ID: <20250227201146.GL39591@nvidia.com>
References: <20250226050130.5814-1-yi.l.liu@intel.com>
 <20250226050130.5814-3-yi.l.liu@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226050130.5814-3-yi.l.liu@intel.com>
X-ClientProxiedBy: YQZPR01CA0093.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:84::23) To MW6PR12MB8663.namprd12.prod.outlook.com
 (2603:10b6:303:240::9)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR12MB8663:EE_|CY5PR12MB6550:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bf5b09f-32b4-4b5b-dadd-08dd576af70c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?djJv1X+JmgswRjm47TO1AueaxIDIah6n1Fyh3XgaA538spOjPZt8F8n4ImV/?=
 =?us-ascii?Q?A532Vtj0RCHSuRtQR/xiq/h1UX2kFjG8j9K5+3fuonotltpcsBWmyY9iZvNw?=
 =?us-ascii?Q?hqZSdqSGinj4xAOv6Rh9qaFP39xbc1eJoKkp4evGIcaUeHJxzlwhzkrXSbPc?=
 =?us-ascii?Q?rGrVbAkBQ2AWOIYjM6Yz5s70aZIygvGZu5x6VwS7ui9j7sTj5EMRoz28RK3v?=
 =?us-ascii?Q?zJI71d9ZCc3lDJuxZnV4dUiE01Bp9TRAVrT7f5ONmLYGYq3rv/OtHTHi4VxE?=
 =?us-ascii?Q?+k0Q5vfCIWON3282/VNrnP5IA8Jsb80veIA+HfIQiYsC8rQTx0mKAToRRO1P?=
 =?us-ascii?Q?j5FI8VM5eVlnjrEbh1ZynYbHyDXozDgsPjAlLA5pV6idJFZ39oHwPP5iR675?=
 =?us-ascii?Q?owstaiSdwAuY46VoH8saOll8zYP9Earf2oKe6RXePIxESYhsoLNIxyM/I5Vl?=
 =?us-ascii?Q?1Qo8eXQJ24F+fk3aapACdc4+9WOIBJSocLUE6EdRLoHQSTt5Mxp+Y7zXp+2c?=
 =?us-ascii?Q?9o2+C5//wOMBureENmajrYeaaib33gAFJHnl0vcFdMFNN/1+Tgeqkh1wKTCe?=
 =?us-ascii?Q?+y7vfuZQdKSp6brpvQSPGvonh1drEN0gzM/IRUsVtn6GJdMfvZBbEYg08+YA?=
 =?us-ascii?Q?+x+G+RiRtaIWiqOTotBbfq9WHZncI4sduJ6c94kJMjQZBm7C3HyaPaGA+tvQ?=
 =?us-ascii?Q?v0hFhjFQop7nIe4ZYctw6oXF4QXpEbd0+WYJ4L9BYOFHylztmw493Gi4bGZM?=
 =?us-ascii?Q?k3SX9/3xDoSaS8quBeH4gYFY9JG0+NWyDnGbcZUiBBNw9cbd5ue+Xw0nwtQ4?=
 =?us-ascii?Q?IvxJod+Vl4EzRAv5PckVaz8235Zswx4wRMuNSOBiC1Mqntu1KMcIjjB1NQ9N?=
 =?us-ascii?Q?VArL3y9Z8uVXYHTZEmgDSNXSXCZ0d7VcUxD2HqnrSKNfmHbY4gSHzTdSzk2t?=
 =?us-ascii?Q?YILu9Fw32PCpt/dbUMX483JebMx8UniFJfG94xSmHIOnRrhWJErWIO8mtmki?=
 =?us-ascii?Q?LWI2jXkmv3xEdjljZKjq4T8ioyWHz3wKLPZp/Hd2I3a8FE86CA31vj6nyJcs?=
 =?us-ascii?Q?8syQsRtNkjiqemb+uf+/3YbRm0YVCjS/dCeCNEJdmw/mGsqxs+xsIX9AulAL?=
 =?us-ascii?Q?Mwm6dEgKZP/XZni5T71E6A+xK+AkbWe4r6FSkvPFlzKMGKe8aDYHJygnrn0O?=
 =?us-ascii?Q?AHIX2Mm0Dx/XXnsA2KDrmUihiCzFfMTsMVjCV1O0r+Nz1XXprumvUAW/7Eq+?=
 =?us-ascii?Q?s97b9k/3lO1wqydvQBP0WA9ngMdJzrZc3wG++nrZD5kKPhoQBxXqHV0QwJIP?=
 =?us-ascii?Q?ATwcQWWl8Xa7vCYvreBxRCiBN+wHpgRyxKKHxRJ4jax8zWFw8JkpAbS1N5Tw?=
 =?us-ascii?Q?vg7OyL/q30+c+kry8fH2Lfhaw2OK?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR12MB8663.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Sldx1lwwf+K2RboCf89CxPj5nXozhGhIJwBWZPXu49q4zz9Z3SkKTMnMG055?=
 =?us-ascii?Q?82u/3kdbbbCjDfqJQuEyEE72SPvR2Edxuw1OabGh4fjqULsvJaClJgMopute?=
 =?us-ascii?Q?J+MZ1CZkOoXf73oqJcSB+mDAoD46mXfTdj7jDCU6kP2kAfJuXTySkd4Rd0nj?=
 =?us-ascii?Q?JK6twQk4w9YtwsSpJCtEelKQwwDjtNDE/IcXuzaTiDV4khexa3KEEflJTqZE?=
 =?us-ascii?Q?8gZhdLDsX3LAa11RcwPhWRSTh47bkKoJqFlY2Elt70HEdQFJkuo1Nspu3TMO?=
 =?us-ascii?Q?Df79uv2jWP8kdOuNvslSttR1mxFXajtrWqedMDANVx1y4RDG7OzOS/oqvRch?=
 =?us-ascii?Q?WG9NI6IMT4nskr7nCFua1DC8rKWYfKC+uZOd1VeyloPmBPWYUYFwVq2c1yAS?=
 =?us-ascii?Q?R03KZDpDg0sdj8D0/UFDMBPs4T+848F63F4im9pdGkjsbd36k6FekhgIooWn?=
 =?us-ascii?Q?mf4qcYx2mHjql7PzQyF1xMt9MgzT7/1ff+IIyal0ntxvC3rn+nuypluh07TW?=
 =?us-ascii?Q?fJDcCO+Aalpq5yOkvkaoiB4+O4R5UN3iyN9ghEmFjswyaxZ91/k6mAQJ9QqU?=
 =?us-ascii?Q?QW1/wDcEF0Fmdde54v2is0IXFQNvUOb9x5jmOpjaZU/PRPx3e1h1wGuI0epP?=
 =?us-ascii?Q?uq2FFuYguaLNgUNSHu/l8Ei6ucDQxYhiYkI0MUOPYOxxwZGmKfl4xobNlAJM?=
 =?us-ascii?Q?nUVpdcmBurkuiElCsktZe9FWvUwFwLxLLv1DT4frXMCoyMj1nBpTp2+lVH01?=
 =?us-ascii?Q?ZtkfhKSSFGjifXLdOne4p3dqpLmwOEnU/Gd0mnAw5Db0TTi/AQuA1eylpejU?=
 =?us-ascii?Q?LxVpZq4I0QcZzXJuTjKuRLihl81r5XRQeLKB07doypwRHqbAviBeFScKD9b+?=
 =?us-ascii?Q?BQzukAOyGXvkjs7wsrvLKuHIbW1Et/vuw9CvVN3pQJgA+mPjq7kgvSWtG7q6?=
 =?us-ascii?Q?mHS1+XnHiZu+bKevljMbd2gLxhvIVzslya0cy8sTyGKJ6tbi7TRd2Vn+4XTg?=
 =?us-ascii?Q?zKY1bUa/3qxiYogDQQK7ON8+KtIAtxT/5UN/XHqZLec/CGNEU72fROxLYNIq?=
 =?us-ascii?Q?q9K/DM5Uv99JtyHxhcmQl4QNnfFYRFEHAe6l/NQ6NN4z2OhYrhfmYCIu1iCL?=
 =?us-ascii?Q?RjoxmCSwCzbl+92hd7pu31JZsWOsPkIMZKoQgbOvdRnDrDXQ6lMNKi0C0s11?=
 =?us-ascii?Q?gIPRX3xfmjjWK8cf7DLHwZtGW4+zSxCekgP8MSY8x0jlI9sOoKoHAGNp//WI?=
 =?us-ascii?Q?dSkrhQG6wRoOAvDjHvMuJPdbogqSGRw/rnRnUnjXM+Cqqnx4XtlCYc5xuaH1?=
 =?us-ascii?Q?Sol9NJGeLkPDR8uuG9QckYwu7fuCuwqvavNZCa3G2bYog/bGpXMmpjfxhi3D?=
 =?us-ascii?Q?QTntrI9OU0Hzyvh6Gj1KcOEg/GOJvjs0snH3kmjZ8JX1ZtWKj6Bp/nkUUGw8?=
 =?us-ascii?Q?F08Isv3zBXWfx8TdRefFxJolyJErMFvYYkcCkll61TAMBlyLcJdMtWD6dECP?=
 =?us-ascii?Q?u+AjzJL5ztIMolIqIq6aCDnjrZrkh/U2X6tUCDPLFmXfZ0mtwUoG/OR6MtG9?=
 =?us-ascii?Q?MzgpaNmbgpGUqd6yJ2D5AX1MOV+wEbTQFedspcsO?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bf5b09f-32b4-4b5b-dadd-08dd576af70c
X-MS-Exchange-CrossTenant-AuthSource: MW6PR12MB8663.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 20:11:48.1406
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7TUA0DD9IVahZI3EIBY6AG2Kj/sn8V6Iau1KZKW5tmPSyzxgKyztKcwktYuAbFE/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6550

On Tue, Feb 25, 2025 at 09:01:30PM -0800, Yi Liu wrote:
> The iommu core supports replace between the attach with/without handle,
> add test to cover it.

Hum, it is not really an iommufd test anymore like this..

Though I see why you'd want to it this way

Jason
