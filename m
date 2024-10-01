Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2076.outbound.protection.outlook.com [40.107.237.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39DA41B86E6
	for <iommu@lists.linux.dev>; Tue,  1 Oct 2024 20:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727813139; cv=fail; b=CMWBmeUKwaBFMLK3cco9fOs0wCrTaVmHd5W6TLoLZ3p/b/AsoNPsk3Pyi24xlLKplZO7XKjFKm2uC8bUHZRVUfvlxzyz/SZilhMlyAO0ueVnu9pOonCDePUxAmqrM9gD83d2R17hLVFj3efJAL3Ss6YnZMktW6F/wMz6NCMfRwQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727813139; c=relaxed/simple;
	bh=eCfc62pZhvNwg/Gc2eyuyrNaDoLdXP+6WwR1sRTffys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QZyWAc+IuXYwJCUAoNnsLVUG9QH9+2hUJhpVhF7+J/u3SGqX5A9EKgGaz6fyfkzOfjLmwv8fo+oerj0Pp7XceqjkzmHJ+N5G/Nbi/UZOnCJ70hltPu5Rxv19RAMiBMupBtJqe29rS/c27JWBQvO9Ta/vZBwJmxgdYbvC0RPdKdY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qGC0F/0t; arc=fail smtp.client-ip=40.107.237.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qGC0F/0t"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sZxm/ynr3UukM+BwwRBoGRbrfiRpyUXb0QiA+Ee9KAjZ1/tkNuHtrbNDCQAjxS9PS7o1zIkCncUkDEVsyjqU2somwF0bTbzrLAla2jHns2/GDoTFrVcsVizZiXpCdznVPeAI1liEhiNsVGSc7Ytqj5p24ZUD8xa4U0HO+iTg7vGjCjyHj7jg+u1dkbRKMNWL/HI11Sih1/zn/GcrfmjPS5br9S81CVRRLgfs5GbtuLzZBvy0ACGLCMa34Cg/5CDDFyRdqwyIZvWIIHGeV+VkNGCb+fL7WC3UAvFYmZITkXCwz1e++7HM7iYNOFyebMXe8Vc7k3qGoZASGu493PE0Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5IOuSyS0A1w7AvBmxVJd6MlsmY/3A7/g/JVSzSXhxLo=;
 b=XB7sSx07bLfJGpgiyj9me9hx0w4OCCoAL1rAnYQe5cmvwN8YUXTfF+NSLkAOqJ/BH+U9oPZ+5stzTk7exzTzkMQkkfTlCkBsmk5JajSYa/fOkZnww+uja3wxLa+RMxfAo5BF0MN8VTrJzxVUiYaDUNaTnGfMTYvXnKHU20biNMeI3O4QTpKkyRk2aWvrKplB/J7rmMnYbBjFPuxdqiqeWd8lU/3j06zbMey9sQ1F0x48fwz864AyfWFJJv1TdJr1+G5bcrepykJFuSztOlkT+TBVK06a95J6Hd6CCBq4udj6PjXh+Yf2etth84gROGi3+Dib6x3bM6Hyz7qYOKCuSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5IOuSyS0A1w7AvBmxVJd6MlsmY/3A7/g/JVSzSXhxLo=;
 b=qGC0F/0t0rw5RMnDu+v0vaVZZf/rzYFSPCW1lQ9WX+ZscsW0qmwWDHzJMT+++41OC6M7OKVt0d56TkdiKV0cvmNY1QlGIiaZuT7/k/jMK72hOI9+rOdVwniwExMoFGl5NpJdfUmdO2VWnBvP27GTXqCYAVcUTJr1ttmLd5OHe3AMQoovv9AoYZfPJ8JHNEa+2FpYm43gI+xa/7o6tIwl8i5Vrfv4USUQbuK7ZYTz6sTaHGp13RTkb4AbMCjjeQxzNj2NC6zh+9USQsZWuFOIqDSMYHg2cN214wikpHHcWbpH5HKP+wEIhKCtmI5kAUGi1OC1LYj5rmo4roBe/7CLAQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by IA1PR12MB8555.namprd12.prod.outlook.com (2603:10b6:208:44f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Tue, 1 Oct
 2024 20:05:34 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8005.026; Tue, 1 Oct 2024
 20:05:34 +0000
Date: Tue, 1 Oct 2024 17:05:33 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [PATCH V2 5/9] iommufd: IOMMU_IOAS_MAP_FILE implementation
Message-ID: <20241001200533.GM1365916@nvidia.com>
References: <1727190338-385692-1-git-send-email-steven.sistare@oracle.com>
 <1727190338-385692-6-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1727190338-385692-6-git-send-email-steven.sistare@oracle.com>
X-ClientProxiedBy: BN9PR03CA0212.namprd03.prod.outlook.com
 (2603:10b6:408:f8::7) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|IA1PR12MB8555:EE_
X-MS-Office365-Filtering-Correlation-Id: 68f84fbc-914a-4735-1693-08dce25468d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gRUoQjf10akrgP7RmM7A+mDx4zJCGgyYHZS5+g6/LYRIb4Ec7QQx/vbdCg6Z?=
 =?us-ascii?Q?7ybjwRpOUPejhzX7n9Fqa50QeSZhGFZ8nykPUHlIJbbYw4kSY+08s7FUQFlK?=
 =?us-ascii?Q?Hr8tItdeCSqRUtaLjnaID0GRGF9tCquNv6FNZg71qZRgZXNmaEvawJzz4xuN?=
 =?us-ascii?Q?gdDuO2P+o0Oe3RjvMKuYuw3Q2duo7XjrHKxmGHFCsbcFcO16AmWbPEkncv5s?=
 =?us-ascii?Q?azjpjtZpnnd7MJvhZcp2mSMalkRFGQPkaaOyVCPnMQf67yC981v5NZtDX0Fl?=
 =?us-ascii?Q?SmF5tbTCK4Oxm/NRlLhe2c3/gXfP0gMTFXv7efIDSDPo9YEIQHAitp0KoPSR?=
 =?us-ascii?Q?O0rnZ3bWIy7M3ZyTY0W/Ruxx+sR0reQkmHsOZsd9dfmlAuGAsObYHBSuS9is?=
 =?us-ascii?Q?Lhy5DZJEsEO6pJAbe061KdTc8crpbodx4fZaFLLvOl6hTjE1uA2b0AeQopVA?=
 =?us-ascii?Q?tUPXbDQST2hP9xCkthb39ZbRA47Hzrl4hbft2fqIqTSQO+oX6bUG+b9+FtM8?=
 =?us-ascii?Q?WTeCmpeTt08eWeEYuvSB0Qyi4vpZ74L71MmrQAUIhr0Inm8TIWxCtXgbVWja?=
 =?us-ascii?Q?MSl0nxN2+0vJrNmw00Wt9NfP5D4YyiSAt1wTUpozxwhCD4DZiqWJ6zJW1kOB?=
 =?us-ascii?Q?f2bd4UHjqCuQWL5RXlJGWQHV2pF6/PNBtsv+QS+a47+6WheRwtQ9yNPygiQD?=
 =?us-ascii?Q?cykNAvab4v7FVD3DAkH4ceZ1B1/TiwAL7tPot1qssqkagwZUu+lnPAER3uIU?=
 =?us-ascii?Q?rn3+9mqphBq324Ftvqh0x3I+UtADAN0N108yiLkJdjxYZ35jY4pIhUspEm1J?=
 =?us-ascii?Q?F/LuLyfbOFKwfr8nQg/F6OyrivTL/Kgxs88QgiuZIi6n81jvkZwOwwsq7h/7?=
 =?us-ascii?Q?rJ5BEeh19zqbFFl2+cEfW8+KRw/P7H9O3/VcL9dy++m7Nw68DJLTA8G3wjAg?=
 =?us-ascii?Q?/r15PxwAWIOwCuq2vksktmoLZ8vs+RHSyY8w1EZ/kxU0hpeYnkuqmAUycABq?=
 =?us-ascii?Q?HvhjOagzaucvokhSXgGthVPfKvdbolMRuToB2AQw4hfoJoI89JxKvNow9a8+?=
 =?us-ascii?Q?2laUE7Y9X+y8qKg06PKgsN4/G4eMc90L7XW83LovaiTM7HU14T+ZrmM7uYKP?=
 =?us-ascii?Q?+GYuh0Wn+jIraCjQ6VSPsr5cWxAJ9l0LjINOOCCNQnpHkjABfPt4G+klFx9c?=
 =?us-ascii?Q?kpXGqz0p1MSX/fGR2rDgVCyQyWlXGQa+t29iJ1kAWceOX3UaMhJb/rutWbRj?=
 =?us-ascii?Q?AYxzbh9WFWTjY+Rn7Hmt1KfSUtcA9IaAxuNzYVxlj2ty1REE81Pv1t4fSXvu?=
 =?us-ascii?Q?kXK+XuyaBihNrajDSv/kVJzpq66Ojb5gPtz34qPDHdjJVA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mS2QQ5qa09A4vAKR0ixv7rfU6aP++/SyiIi9Xk+Dav/abSEDII4Cl1NbyXRV?=
 =?us-ascii?Q?CPNjDEI1pLFkDqcn/DQUYp9KywfFmUz3QCU66lkevo/S4A2arm0o9cauWVfy?=
 =?us-ascii?Q?e9TvVRs8iRhLPBjDpCTtfx+JDS+C18YvDTgYZ05YiceCqJ/PehKBbovF+16w?=
 =?us-ascii?Q?lw9+LtWqGbecQxum+lRL7Fuc9jzK+ZVg8TP7SReA7ICTQfHxJVhMTp6Gbz8e?=
 =?us-ascii?Q?KRMhf1YR9FBLdUwX2FBZb7FDa9JM/jISUQatUnxzMb5+INVoTdC/fo5IW+FX?=
 =?us-ascii?Q?8cT0/Rsnfz7am9ZXurjpajnqxtNwNdBiaOb5XsAo2IJ8+Qou3kaOcKKF0wzh?=
 =?us-ascii?Q?kjNLZAlgZgsHYfQ3NoLbzJ8XjHecyoBzIRmF17xyRA51zyWse/iaeg2lumq2?=
 =?us-ascii?Q?RZYtXpZfnDFPjZmBvrbYsoFw9BCzEZX/zvW6jyL4KkFDDSwspB3wk6fdgWz+?=
 =?us-ascii?Q?4NvaLW9L0R417rTb95hRytTbvy4TYSYOgvis4Wq7r6/Kha1UohZIrgMed9Dy?=
 =?us-ascii?Q?SjVHhqowSQgMcbvuaOehnSsMMFPvSW01mM6sHVrac05lOsirzNy8/JVDUlty?=
 =?us-ascii?Q?95pG3aWG+0L1SNt00gXEhTVeNL8gqJeKYswmbqzippClsQvYGwyJm7AxaYM0?=
 =?us-ascii?Q?v8iKGTpkwoSjeLGfMaJG+pHjPMdl2c1tfQZoFFWSeiHvOw9sPueKLgNio+R9?=
 =?us-ascii?Q?OwHy/aWW8FApY2KctQ0dtbo1PKb843xpKLB9eR1CcuR2iNdh9DDi7PyuoQye?=
 =?us-ascii?Q?IraSzrzFfL6Qxr4KjEWAPBo4jCW031rsgXbmLOXJhNWOhm4LK6ZR8tl11fYv?=
 =?us-ascii?Q?5VCXUc286lY/TC93rFhIl4NtTRyCEmZA6I9jkFs7FlZq+c1Jt7R0kBFjlaP5?=
 =?us-ascii?Q?Z+DWUnYOed1qP6jso1hXLrgQryw0A8nP0vsL7rk7BrOCF8yRMAD0dtAgCshO?=
 =?us-ascii?Q?qEVW54+BmXE+MqW6DpoSCkm29Uxb/VfeyX8+fdZgvnlJDSlz3i9QvLP14FwF?=
 =?us-ascii?Q?Wqd+6TXr7Dq758HOkxBSwbMTtdNAN/F/10rq19j/zTtIg+dgZbiImkf42KrU?=
 =?us-ascii?Q?E+AkzW4IB2YeCiV6w543L4a6R7HvxRdOYm2PBEpOvd9WRedayn+kKNmAxxea?=
 =?us-ascii?Q?/vwxRLhopCRCX0vtcDLnBGkKjk0zGlSvB/ZaVF6/AOXiLiWSg3Ewpox8E+hg?=
 =?us-ascii?Q?O9pM9FAu94bKoxuV2pnQLmg115dxCCTkTG1R5JFZfy2yPz8L3rDNRKHcGJyt?=
 =?us-ascii?Q?azNwBxdcWUMV7XjHE3b7h8upQCDOdlLOieADc9w0rYmuRZeglzo5aQ7AsMX+?=
 =?us-ascii?Q?6NDLLq57ec8Ue8GutZw+RMwlsKW0IgTfXM/obekqUQXRVhfdQAWMqNP0V1T7?=
 =?us-ascii?Q?nysAyOg9TVY0dVB4+9A9plnaLlOajL4x02QJqVegzCkyFRT/pKevIbOXJ/po?=
 =?us-ascii?Q?bklL5VgNhHzmZVwXovaV1bKliKU6ZtSAAoZeTjXkXvQa5Aw8hH+UNq7nS4BE?=
 =?us-ascii?Q?KiK62qeuo3LcG9QyIfoNXEZdBI+0P2Ecg9tVg4gqj6VE8j9Po8CPjA6y9M2t?=
 =?us-ascii?Q?MF4R6ZQzSJSGYrE1GAA=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68f84fbc-914a-4735-1693-08dce25468d6
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 20:05:34.5104
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j8EahI2Ug1tMG7sUbVTGKD0qi3yLsLlDdT2ynD0HM2FXD7uC2ostjli/FPvo0kNq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8555

On Tue, Sep 24, 2024 at 08:05:34AM -0700, Steve Sistare wrote:

> @@ -199,7 +200,44 @@ static int conv_iommu_prot(u32 map_flags)
>  
>  int iommufd_ioas_map_file(struct iommufd_ucmd *ucmd)
>  {
> -	return -ENOTTY;
> +	struct iommu_ioas_map_file *cmd = ucmd->cmd;
> +	unsigned long iova = cmd->iova;
> +	struct iommufd_ioas *ioas;
> +	unsigned int flags = 0;
> +	int rc;
> +	struct file *file;
> +	unsigned long end;
> +
> +	if (cmd->iova >= ULONG_MAX || cmd->length >= ULONG_MAX)
> +		return -EOVERFLOW;
> +
> +	if (check_add_overflow(cmd->start, cmd->length - 1, &end))
> +		return -EOVERFLOW;

Do we check that length != 0 before doing this math someplace?

> +	ioas = iommufd_get_ioas(ucmd->ictx, cmd->ioas_id);
> +	if (IS_ERR(ioas))
> +		return PTR_ERR(ioas);
> +
> +	if (!(cmd->flags & IOMMU_IOAS_MAP_FIXED_IOVA))
> +		flags = IOPT_ALLOC_IOVA;
> +
> +	file = fget(cmd->fd);
> +	if (!file)
> +		return -EBADF;
> +
> +	rc = iopt_map_file_pages(ucmd->ictx, &ioas->iopt, &iova,
> +				 file, cmd->start,
> +				 cmd->length,
> +				 conv_iommu_prot(cmd->flags), flags);
> +	if (rc)
> +		goto out_put;
> +
> +	cmd->iova = iova;
> +	rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
> +out_put:
> +	iommufd_put_object(ucmd->ictx, &ioas->obj);
> +	fput(file);

I don't see a second fput, what does fput on the success path?

>  int iommufd_ioas_map(struct iommufd_ucmd *ucmd)
> diff --git a/drivers/iommu/iommufd/pages.c b/drivers/iommu/iommufd/pages.c
> index df5ba4f..0a432dc2 100644
> --- a/drivers/iommu/iommufd/pages.c
> +++ b/drivers/iommu/iommufd/pages.c
> @@ -902,7 +902,8 @@ static int update_mm_locked_vm(struct iopt_pages *pages, unsigned long npages,
>  		mmap_read_unlock(pages->source_mm);
>  		user->locked = 0;
>  		/* If we had the lock then we also have a get */
> -	} else if ((!user || !user->upages) &&
> +
> +	} else if ((!user || (!user->upages && !user->ufolios)) &&
>  		   pages->source_mm != current->mm) {
>  		if (!mmget_not_zero(pages->source_mm))
>  			return -EINVAL;

Does this hunk go in an earlier previous patch?

Jason
