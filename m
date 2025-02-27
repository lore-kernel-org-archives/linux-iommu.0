Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2074.outbound.protection.outlook.com [40.107.95.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E67E1BEF7D
	for <iommu@lists.linux.dev>; Thu, 27 Feb 2025 20:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740687360; cv=fail; b=GSWP5hDlxmweyH5t61QMPg7afUWnGt4ngp+akaLtmZbvulZ3eDLmod4uLqyBOy/2S50Ko2HgXY5ikiUgVOeBUU/ybWMpPGX4cVCcUm7MXDed1HGavwlma4KdZuBJUGcc2og4jVm6v822hVl3nBbX1mpSpF+wEc9yyWHtBdN7T3E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740687360; c=relaxed/simple;
	bh=r/k9VEoKwYCOvj7vRW6sIBeFZL3QV01iJZlivOzl2Hs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=q/+VCo9xi0aGbwshAG9noeoEx7S+h+q+MCqaF+tV9VD8zxDZ2mMA8gJjcAQ91WnF2AlM3NpU4EPIH0eUDLpsLspqLCzOh8MLviyiKz0zK/sx5q+xGbMxpYCyesSt5HFMxX2PvZAuL6ZOgxK2th/8rmJsDr/zd15/9PKFgtikl8w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Uk61NyOb; arc=fail smtp.client-ip=40.107.95.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Uk61NyOb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cxb6+N+eYn+NiVChZeB6N/7OZfbnGRuOBBmo3tRvyw8ijLh3qRfm2mN82NnNUsITJbopYOieFOi99UPCnn7DawmFfHUhrh9bOTtWAxZKekDVA0dpd19/wP2cMGyIl4ddxvq7tqZSoMXT+bbfz85B2jodJZ//Dl9cAFQeKmm76iPbGMDD9I+MnvM4asnTVn0O4Tl/UGNqwudmbThpmJuJ6HE4FHI7eXOZpypAmmdy8o2/zu7KDgbKywP4tmDOWzsBRuoOQE5HI0Ni+hsXEqKXznju2lOYlDws8G0VpeNY8rzTg4s9DVkA0ija3caTLW2AFBZYaBSXLTgIdYx6b56CFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qTD0CBumUFUYNNeoun/ANnyYdYPu5KoOUQugTqQBbgc=;
 b=SOyhcoQAaj6f6zYYxy012kcu7/rgqqQ/kFxc/XhDkeNjkTlqfl6oseA/kXcnyQErrkpEEh7UkfxmT56MJRzQ2ZpQDo0q9b5Q9nDyI2Pbanh2aZUOEvkLCTRG42fW4NSzPaZbSohzwVQfp6wLWc6pvdcQHChiAT3n5RvYqso9Jwm8V2lhaw0qC82e/czHhdawfJqNewVq6jz1Byr8HnBPjWgfXYrRRDKOPMBAtiaNABGlBYTewVOEMZ5t+ChGDaJuTIYIeq5MvWLEj7wX9Vuip9pFQwYwPxdm78TGJRgcCrpL5csJjihTP1B48cOcXVLiaDIvkNDAwOpQIjV+HWbP2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qTD0CBumUFUYNNeoun/ANnyYdYPu5KoOUQugTqQBbgc=;
 b=Uk61NyObpO+OfIPhJDxzWEI4aqregAALRKe2B7o6pA/iY5CVLVeEV5fh0H4Ijpl8RJf3koyAL1/fDlGKsBhtSZ93HSQbvmzxRSg+OM7ysUCsAnXbtHhFvPQhtjb/RI751C2YND7wRGQ5kNVl0npR9htTnKYBtUezsOKdFAb2n2uAALE/h4o4MsciSzeG/qjhfuQLkN3TZYB0offlXKWh2SlGbAJuyRIsrPB9k5iBdgE9eSOOejQ6e5dtR/bShX3aiuYEVeA+PTA4TziPwQ9+qck/eEJVmkvw/zUhdDNpXmYJXflHq8pDRHzaaWgd0f2WOkIxc+XGhy78DkxIrCPmaA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW6PR12MB8663.namprd12.prod.outlook.com (2603:10b6:303:240::9)
 by PH7PR12MB5856.namprd12.prod.outlook.com (2603:10b6:510:1d7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Thu, 27 Feb
 2025 20:15:53 +0000
Received: from MW6PR12MB8663.namprd12.prod.outlook.com
 ([fe80::594:5be3:34d:77f]) by MW6PR12MB8663.namprd12.prod.outlook.com
 ([fe80::594:5be3:34d:77f%2]) with mapi id 15.20.8489.018; Thu, 27 Feb 2025
 20:15:53 +0000
Date: Thu, 27 Feb 2025 16:15:51 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Yi Liu <yi.l.liu@intel.com>
Cc: Baolu Lu <baolu.lu@linux.intel.com>, kevin.tian@intel.com,
	joro@8bytes.org, iommu@lists.linux.dev, nicolinc@nvidia.com
Subject: Re: [PATCH v8 06/12] iommufd: Support pasid attach/replace
Message-ID: <20250227201551.GM39591@nvidia.com>
References: <20250226114032.4591-1-yi.l.liu@intel.com>
 <20250226114032.4591-7-yi.l.liu@intel.com>
 <8839ae2b-014d-40bd-93ee-89a5791f95ce@linux.intel.com>
 <124caf04-629c-4b5c-847f-1e965ea5721a@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <124caf04-629c-4b5c-847f-1e965ea5721a@intel.com>
X-ClientProxiedBy: CH2PR08CA0019.namprd08.prod.outlook.com
 (2603:10b6:610:5a::29) To MW6PR12MB8663.namprd12.prod.outlook.com
 (2603:10b6:303:240::9)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR12MB8663:EE_|PH7PR12MB5856:EE_
X-MS-Office365-Filtering-Correlation-Id: fa6df207-9c19-41e0-7676-08dd576b893b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?I98Ci4bri2GVcinRmHqr452vWV9vOK+6GxynkHn5tfbxe5JT7V5nk20OoqoZ?=
 =?us-ascii?Q?VcXjPG/boV7u5womasc1iLYGvKhWIyK5DNacG5suRqFIUu4Xi+fG6JPAqKOO?=
 =?us-ascii?Q?ThQZg0H4xixv8U/f7ga3kbXNrKwQIG5bBd0OzgcudsBZNPrebpwN22zjeIUh?=
 =?us-ascii?Q?73FVaYGLbMZEDkViRB6D2sloKe3GG7TULCfmmKgbTiYR4JRoVMIxiDAF3sna?=
 =?us-ascii?Q?oK/FpARm3+1Ri1MuzaASPJgmjOheyTBolVYGCuZRPqNBhVWlv7iPxPhOzNaE?=
 =?us-ascii?Q?+vBn2yrJMFtFOE19/HOPU193QTu9z/RzETtHnsVuOgGAzzZz6ekmeupYus0b?=
 =?us-ascii?Q?+7i1fFagZ/8nnQoCXiQgP4cGmsZdNV6fSN1RJOnycdAlx2f7kWwax7Keb/hf?=
 =?us-ascii?Q?9ODkKheJs1q5NshvEltJlSjqnWxivMz3NpbFsRXFInnkuwq0DyghhZFqzVH9?=
 =?us-ascii?Q?VaIdFo1Iz6Swfk9vP3dX2ejKbSije5Ei5zJGaueDUJM/hHOxJ5T6n+x+63ku?=
 =?us-ascii?Q?1W6PZa/Fhrjq0jfBzTxdfGSkXhxlJZ819zYaGt9dOcCZ/e38Apt57vbAypLE?=
 =?us-ascii?Q?sg1n6zTjeXKLQwyNFoEF7NerYUmCisAiAsFfmwrEO3wag67bq68yK2iLeVpz?=
 =?us-ascii?Q?oW8eeiAL/pLLcS7h7t0uXIhv+gqK61jHsnb8B7SVtepmhrXVICMWxgWGzOAi?=
 =?us-ascii?Q?2O2p8rTwAtgHLud//OqU1Wslb5k7YvmsOhml4GXrLY9DETNhGebtHGKmrhQS?=
 =?us-ascii?Q?lac/vtSvDmQlWGuxIRmmt+QiXzqz9ramQgV71DXFFRCC+bhl8rRT0yS0OCEt?=
 =?us-ascii?Q?L6NT3e21WAYBakkrsBxVrFiBkIuoELrJ8auZRDChRqM2p8r5wAqEGA3u9fw1?=
 =?us-ascii?Q?aZumZwQHIL3y/Ymu9G66ymXZDiEHsziD5nG8r9sW+LYq5oLcMNk4U+oJw2eL?=
 =?us-ascii?Q?wRw9lkc0mhsbsogy4Tx+rZuVAqtVJIYKFALdfPcPbYsfSwwxqjyDQJ/Y7HnS?=
 =?us-ascii?Q?Iy9GvVm4YYc0kdwlJa7W2E2fwKbmECo/sMElpdrZku31dO7KoYHHv9puZWtM?=
 =?us-ascii?Q?q/0Gdhe/P4/L4X6cFYxot7XD2Hxe3+/EStoCS55kasfXVjhJiOA4P0Spo4tP?=
 =?us-ascii?Q?Du9JskcTBsx7QsgSS+M1w/t0siHrCm6Arka4V0Ol+/Yef5ThGnlJZUhnZmbx?=
 =?us-ascii?Q?2XG0w/Py54j5WEi0gdNxogaZrN80ap0ZyLsRYeg3C+EvQLxvb+2LdZUfVCep?=
 =?us-ascii?Q?bms8OcmwzbqTjS8p7x/qoPccIxc17sSt5nW8Nc83c5uQYGA5RO1LqqXb8IIF?=
 =?us-ascii?Q?0DoMWagHi276dhvj5DtqHUl5o0VYy0Zt/NVY5CUPrPs0YrKxl814/Et8uSva?=
 =?us-ascii?Q?sTRd0Metc2KyMVoRDaW/lrDELGzf?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR12MB8663.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ow3bSE23ZpKg5P5kAiQNNmEzLfJlccmbSBXL0tVdnClVYYhidH+7dSOkJCY5?=
 =?us-ascii?Q?FxEvIO8l9UddJlWA9gvDrZ5yKhJvEbYSVZYCzSDJJKzhgxBuYTyy64n2Kp2n?=
 =?us-ascii?Q?YlHNRaYGziLlFJULYwxXoxDhJGW0ZzdIukzR6bzn8EqHpJs3rV0dxgleXnaf?=
 =?us-ascii?Q?JAjzjrjJDifr4wkzZHXj9PsMYNYQePHjTf7EIidKfEKOI+obQVokw1Z/Ov9C?=
 =?us-ascii?Q?QI4tagG7io6h//zW9wO5+6+yGqfx76FbP5mjW7jo7qCdgoqf9Zr60qllG9jP?=
 =?us-ascii?Q?5KdovzBdy0sP5bIIZOPnqqY5dwryJYrmnuXFmHc0/ZXRRcTi5yCkuN4JSzZs?=
 =?us-ascii?Q?85IEad97bC91+/0x6rXUWdSPxIfMb1Of1Md811REIr1Eq9I0G3ZqGwNSzutO?=
 =?us-ascii?Q?hpKVhBSi+f879yPfzHQ7XSPqSsEg+lN8xWLNXtAfBeFKXvFbayAAnvK7vDr5?=
 =?us-ascii?Q?BjXXgFp9hDSznPaez4RUfCqNTCN+AIt11UO7I3j4AZOIhC0w2HK8M9PFu/Oi?=
 =?us-ascii?Q?IBgr1T0zp9K6/kpOcFwJBk7FgJPXVoJ0Xi4EPKa4Ey56jdK/wG16Xsfd6qV0?=
 =?us-ascii?Q?rcMW30UoaxifqiH2LTHaqnt3vyB2IHD+YIBwx5GsmIxe21PF60jguaLVFqEj?=
 =?us-ascii?Q?o+5G/n9420wyrCWMW3rAzMzuBOZw1YUVfLcGPQrVMXw7gNXXOXO3V3cYoJJM?=
 =?us-ascii?Q?r3Qix+Zq+KuLoTjrXptYGDpIDNigRLJa7a0NQnfVtjR8Y0jx+gnkGYOKwakI?=
 =?us-ascii?Q?4G7wAabI75Dlgy4U4rZILY4no9roN9RfZSq4FU/KelFun1uDY8W8QoL9Fayb?=
 =?us-ascii?Q?LdQsoHXgttmd8JJIv3isoW6ukJMhMA6b1C2hWsnsmkKmp1RxsIcF3gH8JoEM?=
 =?us-ascii?Q?oHHYa1+DXI0jQNfw8dryhU8B3rMwZwDYYIPJB10nk70fKiHNwtjUPiU+pvPD?=
 =?us-ascii?Q?bRLFjZvEtHxZanKaMpsKME/17QNn2M9nF0UC58jMO0wAtESdWIE7MgNncCeo?=
 =?us-ascii?Q?u/aa/axgXioDbnXE+NKbNSJh7MaJhGvFdwLdXy4nA/W9d1iLGctx3IkLZ950?=
 =?us-ascii?Q?+igc/IDhI7R4cDF95xP41WATaQAJoVAa528LIcl5h2CcRjT6IzR79nyQ7gT2?=
 =?us-ascii?Q?ZcdxxxEqCpDvpeGscaMraDPm2+ZI2pKujzIad1PlS1x9mjEDhDKdG45fohAV?=
 =?us-ascii?Q?57TsLBh87tlnLMTDoUpjMGQugVxFY+FoYT125S9PbWf0ZR+vEbYcA+q1HgK6?=
 =?us-ascii?Q?OH/2g4AIyVU22yQpZVelxgeGxd3Ti4O7TtfR2wILMp6jtyuD4G814aNxLjLI?=
 =?us-ascii?Q?1Py/75kAFvvqHJ2j0vXd62T1h6HLSAuaCDxY/FwFEuKThCnlwsTt078n5VvD?=
 =?us-ascii?Q?79D+iHyrF3621mX42MlMyxx0Gu37HE3hdtjWE/BSXepTYfSRHpQer5rxwu0A?=
 =?us-ascii?Q?5c4nayw5mT/Bx8luGlHj6ngWonOx0ACJDPG7aG3C+4jnqyKgT/Y5fJlWCOps?=
 =?us-ascii?Q?SniJeEod8UaN+u7uBjsvwuWciBUoy5POFZRu7qGsSYqOU4d1pHfz2Rj+LbxS?=
 =?us-ascii?Q?7OZnF29SCuTsYPORHztzt24/uABXIGA238vYq6XR?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa6df207-9c19-41e0-7676-08dd576b893b
X-MS-Exchange-CrossTenant-AuthSource: MW6PR12MB8663.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 20:15:53.3252
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5bW8fczKVRQQzo6ChH90RlF5v2AUdLYel+WQpMzCgxTXvws7QiD/511o0E67n115
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5856

On Thu, Feb 27, 2025 at 12:19:24PM +0800, Yi Liu wrote:
> However, the second one seems not trivial. iommu core stores domain/handle,
> while the iommufd needs hwpt to check if curr_hwpt is the same with new
> hwpt and the detach path needs hwpt as well.

Nicolin's series stores the hwpt in the domain:

struct iommu_domain {
        union { /* Pointer usable by owner of the domain */
                struct iommufd_hw_pagetable *iommufd_hwpt; /* iommufd */
        };

So it is possible

However, you should also to check that iommufd is the domain owner
which we don't have a thing for yet.

Maybe leave it like this for now and we can revisit the xarray when
more parts are done?

Jason
