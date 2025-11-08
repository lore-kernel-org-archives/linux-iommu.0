Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010053.outbound.protection.outlook.com [52.101.193.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65CFC25783C
	for <iommu@lists.linux.dev>; Sat,  8 Nov 2025 23:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762643033; cv=fail; b=sWkM1Y0FLweV1sCP6xtsdRemrr4Ihh3jwWwHQ8uxDikgZgzNFPEEHNYAaM88vJcODhS6W3ERxpcgxmJnH+m4XdjYDc2j8Zw7/Y0RbqQv8y8jwBJFiVFQuBEkBnI5G0XryZJd1kFQZ/2mJtsFjX5hYIwHpLnywGdgbk4Z9h16W48=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762643033; c=relaxed/simple;
	bh=UVTH+p8g+br0ketZNUP4Dw0J3aTez809bz02m4G90TU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=j9Y2J2OyfUbb9cD6ozq3l+ZNjKUb+pVV1UibW81IqH4DGwWUX2/n+aol+PMiTsMv01Iz2IO8WGIHITkBIjsb+IitKh8NKQSd22hoCLkIpQHmL2UErg+gY1Yuexe2DvBRhH/P1m2EN4nmsVJgeufDrSxgwrrP49NzO9v5gy9YzMU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jaQZcAJk; arc=fail smtp.client-ip=52.101.193.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jaQZcAJk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sT/0gfDX61dmpOb+FDSIN3KwSk6ouGtBKvcfS6bko6PDPW60Gh8CxFtrxvO4UIInC7+xTIIE0w6uByfmj+ozxfxHehlY5cIads+TQ+jjF926q/rmwLnxaYC35Eo8I4sWsA62oPuPapSIaBwie01Ur1Zb0KWM+riKH7ZgfE3cKpQMtOdZBhunpQI6YuJNAvfPSmNofM8HRkQVsTlkdMcA0jp48/stIvpfqG6Lj+4qB+PkSUH2B5VisQ/uG0uPJCfkWot0MBEn+jAPbsoCOPyH32Y7Aun0OPIkWXF6IEg5sEVolEw0Dnr77I21yCmPoOZTOSYlxQnNgWI55wlE6iJkHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LDkRwUUl0JgzCSgDcPuwFt49qt/yPbWzrCOcPMKpDHE=;
 b=uzN3xSDV0wuzz6Qp/qHkZaW9gFzeQlutQY29zvOsbmGG0EYiyzoSbhrF87MNr/dmrKQHb+twyQ5cV0+4UJ9u3QUYSRq1N/azwAAOY1bPxPKHI5DsNbmMJO63nFQZuFjgWGZkMxq3kf79P3ILbaDEhWLdkD7Fxnf3xsT+x203S60E7POYZQt8S6DHYFZLkrvG37WQ0LrUjRB+/PPtr/5QM7ZISa6prkOUEU/jiuN0YpWF5EK2ZbDRBSudesUatXhhGgtK7qCbN+JMJDEFzvErYBRT/5krA2P+paofqYeuGosbjTOKHHOdhmlvTGD4odPX1xBud2M1gJUEy6jUY6gr5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LDkRwUUl0JgzCSgDcPuwFt49qt/yPbWzrCOcPMKpDHE=;
 b=jaQZcAJk5BgiIkat64DbGbL71TGcaS68R+8LIklmKm9D2WqQioVb0dNLxIBzXbwTYOf0zUw1WRGfCSUFVrz3Lo2ekku36DKi8o2Z5dd5iky1ex2eiRa9ybjuj4dLAG2U0sSh4viKNVhHrrVPmMdn4SPGMzYlkxicm/MOJzuT2h92v/B89RwSk8Onop6O9tNCOHmXJUD1FM6a1mf6lALItJh4W8rJP17dhIqphWXeoMUg1CGf41tjkRS+4zVgv2NaS1hNkACor71/DMHmgZmBvTUhlKTdP6LjkN3/5zI/BzNr6aNuZsBgrRjeBSg70MvglOzAnbyIaLsLL4m2x0aXqA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by CH3PR12MB8509.namprd12.prod.outlook.com (2603:10b6:610:157::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Sat, 8 Nov
 2025 23:03:49 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9298.015; Sat, 8 Nov 2025
 23:03:49 +0000
Date: Sat, 8 Nov 2025 19:03:48 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	nicolinc@nvidia.com, linux-kernel@vger.kernel.org,
	robin.murphy@arm.com, will@kernel.org, joro@8bytes.org,
	kevin.tian@intel.com, jsnitsel@redhat.com, iommu@lists.linux.dev,
	santosh.shukla@amd.com, sairaj.arunkodilkar@amd.com,
	jon.grimm@amd.com, prashanthpra@google.com, wvw@google.com,
	wnliu@google.com, gptran@google.com, kpsingh@google.com,
	joao.m.martins@oracle.com, alejandro.j.jimenez@oracle.com
Subject: Re: [PATCH v4 15/16] iommu/amd: Refactor logic to program the host
 page table in DTE
Message-ID: <20251108230348.GJ1932966@nvidia.com>
References: <20251021014324.5837-1-suravee.suthikulpanit@amd.com>
 <20251021014324.5837-16-suravee.suthikulpanit@amd.com>
 <20251023130833.GF262900@nvidia.com>
 <62ba61a5-d172-400e-beb5-e593297129ef@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62ba61a5-d172-400e-beb5-e593297129ef@amd.com>
X-ClientProxiedBy: MN2PR08CA0023.namprd08.prod.outlook.com
 (2603:10b6:208:239::28) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|CH3PR12MB8509:EE_
X-MS-Office365-Filtering-Correlation-Id: fb5a06dc-e9b2-4ffe-f878-08de1f1b1418
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gETF+PWa26FoY6YWALl9AFmiz9Hl09MbA+BhPsxiLedACDm297FUa6nGzbsZ?=
 =?us-ascii?Q?UFagHS1mf0lkJIPmMNvHguKMpRHU9pFesbBZQTXxmV9vuLCyOmuHeuGGAUJm?=
 =?us-ascii?Q?NOi7//2/lBfNDo8zZsu8WIOS/qjt+6loCdlyAQTNMgOR69wlfLXmrznIK5mD?=
 =?us-ascii?Q?qtXq+vzHvi6GkmS0GM15U6H6xyAzruv44Nhsj2blDBY9R60JQtF/ptikv8iw?=
 =?us-ascii?Q?4HbV6VrquIccpZW/895AEvgDu92xsLSX/jUQoxd59QClDXOLLozehJ8s3viu?=
 =?us-ascii?Q?ceBmLBGluKuwAFS9Lmqw1ZF/KVt244xew58SvVZC85O7hLAy+qqaA5l8AqBI?=
 =?us-ascii?Q?f2KqMGjBgklbydVV4hEBL7/KnlQAxWMafrszaQ63g7xIjFbaPhOeFhEKiNUU?=
 =?us-ascii?Q?M8mRoPNqshFavw6RWpPpL8Y8DLXAbn2R1hVOOkYDyQvxSnGwiRJF7NkhpETe?=
 =?us-ascii?Q?LMJr1YQxv12N4VguSkhCIzooaVlMkfGJCt5hjQEecMsPVxl+ka0hv+ozvjR/?=
 =?us-ascii?Q?sjeg7b5xUO860PcBaFCs6Ng4aJ09jCJ/JzP9GO4F2xSPnv6Sdd8eJoR91kgI?=
 =?us-ascii?Q?kdna/+xwGbLYmyxuBqfPPx+IHqL1W59Jj7kEFXTtCQFtc6AcnS5gRnwwguWl?=
 =?us-ascii?Q?60U3zTsr8WH147Vbn/ddJqK/L02gQoMSkJZ+/dTvlMcZiYOUdK5d45MBn0+6?=
 =?us-ascii?Q?+YOoWMNVvjPPDQ3ZkfJlk4CeVBVfaf7RlwMBYJhmunQEMeRB69l768AwWaB2?=
 =?us-ascii?Q?5dO61MWJe3JizISGx8z5Utt2fcEWFY6MHK2ONBrG42gNIfAV+rEA0gMbW2ot?=
 =?us-ascii?Q?C1Mfgl7J9VEt/uI93r6YFnwFBSagPvn4EmQSgdPql+Oneean/HDfdWazfo9J?=
 =?us-ascii?Q?ww/dMwZ6QTeR8hEQU7vOgin4r2BxRW2R4XXP4c2BmpAonNuourdyREIcf84P?=
 =?us-ascii?Q?DN4u+UzGc54yKl0oR+FLf/sANIjsEBcl3c/Ibjm9WgyQzodWluefBAJAUw/o?=
 =?us-ascii?Q?3ZznTTD3paIuz3o31Nne4p0cggPBmcDReW2t2DlhMxqJNEYFtOMF1tuv9aGE?=
 =?us-ascii?Q?CnlJ7aFfzPwt1U0Ac1Qj1CdPb6/8h71qRDuiAN2Hm2v9HfTvUN6B6yj1Lro6?=
 =?us-ascii?Q?y5k0blxRIuxC0L1f9hh0CZHzmqR91V+Qgdi8XQHzI+HIN/9dixkygJb8971i?=
 =?us-ascii?Q?DMek0cLBiZuqZXO0GDXT9RsfNq8gmSxM/bYMV//1fOYB/Ws4B/cNrdKKGBlj?=
 =?us-ascii?Q?x5EInaMbKSi6tkd6XU9BXA0sGUQHiUxU8U/aKQa8CHxNZileADXAURcX5ygY?=
 =?us-ascii?Q?7NTJpTdxNgOG4TGZltNCzR2kCEQ+XNZe84Ylm7x2TZ+pv+hhT+clRqCk28OG?=
 =?us-ascii?Q?79fS3ccOyhCNr6qSwD4dSvF6QfPjF6E6Tuyo/gwyf/d04WX/ifZMqRwj15PA?=
 =?us-ascii?Q?G4Jberyi8JvpkgkSC0uwT/DPzaaDL4Gh?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8Fg9+c+3vMi3GtFkmZgamJaATHFiJGKNAIErMk0FCcq2ruRt+tm3zBCAHfUt?=
 =?us-ascii?Q?3rIEXNXs1mANfzoCD+8yxZMALSwCphfhMU2JJJFCCs4dI1w3XNVHB37KLIxc?=
 =?us-ascii?Q?EK2f94u/3vZc8lztNOO+aJ0p1YGvdkqbBW23N0zb7/7KP+UvOpszOPuXwkiW?=
 =?us-ascii?Q?zKqhF/2pBUV4Bn6yo5kt7YxscXGhuzCLfuy/z4NypN22Kf+5vvXZb5LoIMne?=
 =?us-ascii?Q?Pnpp/pSkmC6tnGS3Z2ReN07D75xbyNZ3k6RRxidMyURNzbhq/CSpeBmbWAZq?=
 =?us-ascii?Q?6R7UFEjGvEuF1+tScX4uPHiGdtIAJ2Tyisxz3LcBuFYcBjZ1yXSasu355AoJ?=
 =?us-ascii?Q?v4uztC6Ldqpwv8c/UMwlJWru76hlg+ezfkfl7Ao1VEl8zO24yoU0hFSmcrLs?=
 =?us-ascii?Q?5yKoAsJCafxE17vuYxruvl6dquBlc09ju9F5534ii6Em56uE1PWMQm+hjuW1?=
 =?us-ascii?Q?bQ+cl8g+ze5j7ickx9NUGKhzPqAV2rKtgTorCcrgln9p0uGXJdpJ8GStFWo1?=
 =?us-ascii?Q?8N3Y6LiQKYubJBpsQ6EvWMWEPkLCLHn70Km8WpjuNOuBju8vR67POUkRazmL?=
 =?us-ascii?Q?e0qmTaT9iaJWb8Yn5GAAAwAyPi/DTpSWSxHbt3OQVe7fUZ5+iCeG3DwCvKCK?=
 =?us-ascii?Q?T1QFzIaIzEOAENzvd9ATvAd37CdnamT085AUCGGxdNz8v3vk01Zc5mHC5bxN?=
 =?us-ascii?Q?Dlm7BtxjCCvW8zMZ4BghqGle4sVncRIaVzo8yQUgClzyWtgI9nc3NZbSJEj0?=
 =?us-ascii?Q?2WSICsLV0avK0XsNmsWYYY96g+jtndLA1xEHXPHjb73X657bxTcTuvV3xJMU?=
 =?us-ascii?Q?Hw6/NlDPvm2KUZj7mpOBZ8IFJ8gK/MKKK02KgVhe/eQ6JkN4POJ3juyIXkfF?=
 =?us-ascii?Q?9RdDJm7CxcOCh/K7WlM1uC8xV9HtErVMNUlgRn7tRRkfON+1zC8VX2TESCDw?=
 =?us-ascii?Q?CU/4iGnMPVGwGNyMfM0988joSVEWgeTtB/Pk9rfdLKHricFe53itS6jdI6IB?=
 =?us-ascii?Q?ysSclHoEmBqKMf5BUK0WRlX9I/JzrZseZtCqcGAmPkH+qy68il+29Epr0FcG?=
 =?us-ascii?Q?SpxoWGA3SHSXgNidvgucPybaJ1GwGgjQykyLYHQLCrOXCL7a+YySsCP+geXF?=
 =?us-ascii?Q?fj56dEAxMDiKQuDBlmIUJgG0E8dJPd7IU/aRaCvZd6wWP7K8fPtzFV/ublzZ?=
 =?us-ascii?Q?H1zWbSs+s09GYxeUYgh6kDYMPXB56/7AZJ7593s4I4U2RXaymS5Q7Z6gzfgu?=
 =?us-ascii?Q?C4nLzBF0RmtzgLRAk7Cdb7mD2S7KjDPzPHJ3kEmpKIdXRf/J82N+iu5oHlBD?=
 =?us-ascii?Q?Rc6CsakrmpzRiDi4ugQKsbfNQkop60XyvOEsZIPkIaFJ5QCVyBh9DLuWufkq?=
 =?us-ascii?Q?ynN3irWzVblDzl85qLZH0ulOcphiO5blFpr26M+tU/TTuq7ptiKRDHOk/kym?=
 =?us-ascii?Q?mkkmgFkit59qyNbFEs4DwCL4sySlYcsWT4+1q3wk14ExNU+y7aEuTmAkoTBI?=
 =?us-ascii?Q?yYxE/IhEAm/tlMr3Fcu3f4E8wJBehGoXRRUg1zZo1/HY9xrRJDa4RKsAh6vb?=
 =?us-ascii?Q?BABuDJwhBNPybGDiTYI=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb5a06dc-e9b2-4ffe-f878-08de1f1b1418
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2025 23:03:49.5967
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OPeOEYHJjrolqanIxgTJcdnKCORjV3P1tnMaZ2es2BtABAaLl5PZifJS9jBIHUaU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8509

On Sat, Nov 08, 2025 at 10:56:38PM +0530, Vasant Hegde wrote:

> > On Tue, Oct 21, 2025 at 01:43:23AM +0000, Suravee Suthikulpanit wrote:
> >> @@ -2088,37 +2104,28 @@ static void set_dte_entry(struct amd_iommu *iommu,
> >>  	else
> >>  		domid = domain->id;
> >>  
> >>  	/*
> >>  	 * When SNP is enabled, we can only support TV=1 with non-zero domain ID.
> >>  	 * This is prevented by the SNP-enable and IOMMU_DOMAIN_IDENTITY check in
> >>  	 * do_iommu_domain_alloc().
> >>  	 */
> >>  	WARN_ON(amd_iommu_snp_en && (domid == 0));
> >>  
> >> +	amd_iommu_make_clear_dte(dev_data, &new);
> >>  
> >> +	old_domid = READ_ONCE(dte->data[1]) & DTE_DOMID_MASK;
> > 
> > This old_domid stuff doesn't make any sense. I think the commit that
> > added it is bonkers: 36b7200f67df ("iommu/amd: Flush old domains in kdump kernel")
> > 
> > The problem is that the dom ids that are present in the re-used DTE
> > table have to be reserved from the domain id alloctor at boot.
> > > If the kdump kernel tries to create new DTEs it MUST NOT re-use any
> > IDs that are actively being using in DTEs already or you get data
> > corruption. Randomly flushing IDs is just getting lucky..
> 
> Good catch. Thanks!
> 
> Looks like commit 38e5f33ee359 ("iommu/amd: Reuse device table for kdump") broke
> domain ID reservation in kdump path :-( We will fix it.

I suggest just reading the whole DTE and permanently reserving any
DomIDs from the ida. Just leak them forever, that is good enough for a
kdump kernel. Then get rid of this stuff above.

> > (though how does IDENTITY on a device with a PASID installed work?)
> 
> Probably set_dte_identity() should call  set_dte_gcr3_table () and update
> relevant fields.

Yeah, maybe so, though it might be best if the caller can detect it
and have it call both functions instead of trying to bury it.

There is a fair number of variations here as you have
blocked/identity, RID/PASID attach and PASID detach to all consider.

It would be nice if it worked properly, identity on RID while PASID is
in use has a strong real use case.

Jason
