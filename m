Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012067.outbound.protection.outlook.com [40.107.209.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267623E9C32
	for <iommu@lists.linux.dev>; Thu,  6 Aug 2026 14:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786025404; cv=fail; b=OZC/yk2JYkTW25P76PFNfkvS817YRtvHpghznmU4WEk0E7rMQPfPnU/erOiB37IWo0mT2LlQKWZGOIaVvs852SMu7yHw1AYmoKQnU0eFGDiUCSAbprHyojeS04MgaQlT+bA/Z/i+K+WU+F+hlTjuhO5TQ8zdXyqe+3xye8kpOhk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786025404; c=relaxed/simple;
	bh=0E0VGO59HhsAX1edu6O09hWCfjHtQSaX18etL9XMsS0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WkPILqnmcbQvPeRqBracZC+1ArwbN1Da5jlo9zadRj7OwiZ6+XTgU6bRxaN0vjwpO8IIjb8ll3gZM8FTum1Pew4+oO0+3T7E9LlHyzRpRACgmPpCpksesoXfWMHbZxO7vZOyPal1F/c3vxWnL446VnjvxHEJQvatuyIe8q+nWhE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=te5U1qH3; arc=fail smtp.client-ip=40.107.209.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="te5U1qH3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g0l5SZH49Ipyn6koyD724qfQtuDoAhgy3CSrPmGKt0i4UWWlNenOrgLt+1qWUKdkrJ/FA4cQWQeRTSUKn4BFFs37SKL/sYskG+quEX/XF6pscYGtf06SyCGJsfGSseCcIITQ3wbi6j1ICEI5rZTfteKZGeOXwaYcJgKHx7lU21BC50e5ZVRFR3ZiiYF96K0yEPO8V3gQvVLQ47QtKgOsTP3btLo8vTXL6JLuHJICYoY1fd3yJuClztNT12A5dMhQ+xAQbse1KftDfDCpKuJ4ECEDWh7xYxPBQ053yV4lO4VmxLu0goOFUbgReVrQmWuEq04e+fd/0dUx/Q+HeWPhlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7pMfYgYsPe6RYIlMfXawdb5sgBE6uIIG4t7FMT8HGy0=;
 b=IPNasRLgO+0Weun2KKsNLOyiYhQI0H41NVsucLfGhfqKhmBeU0ZuS/8oJpO2Ke4/xl+eajhkx05e3FsLrCIA1dQxpwfpj3pvH4A1/pdN1QdEw235zAiU0kfPX7kfss14cHkxPP3jKENwJbE7GMS0g3jsx2vyX+Hx7wMmNcZYVpK/NLCxVL5ZFsSmeevmebWHRvjGW9tBRHv6t6BSQWBLyVd3Wd3P84DduNGlgoP5TWZGagrR8PaFpAVIvxh/OW5ytjDcgHOnySFiiL75cWoIJifV7Ydol6Yx3Y1dBjZoRTOi8bItheqzDt6X6hE6eyHhbc7wM8RSY7BJEN3g7rKnRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7pMfYgYsPe6RYIlMfXawdb5sgBE6uIIG4t7FMT8HGy0=;
 b=te5U1qH3N9Vg8Vjn1osaaoeMsOAD3GIU1ZitFNNSV0R0JlQ5mLjrFxEKQa3ba40PQZOVp3mG11AL1J1wfrGD3TlaZy6voWyW44YQvtfdPXl+cUpZf6+na0oeB/6AQuECSXKCAYqj+l/j86dexZti9M4xfhYMzpMqYqvxAY0F780TSP8CK10W9UzRs9V5cwgnjRV/UgWoMVvS0JX4IJfNd/zJrdWe/2TQeY/+I133KyoDVkxhqa1CEx/TFIBXpMAfE1jyRl2azwIarmBOm6RhGptJkZ274Ong3Nbc1mDpv7htjeqjuM2tmKtBAxOUt4pk617GiUMV7STDBs4v3CMAxQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DS7PR12MB8345.namprd12.prod.outlook.com (2603:10b6:8:d8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.21; Thu, 6 Aug
 2026 14:09:54 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0292.019; Thu, 6 Aug 2026
 14:09:52 +0000
Date: Thu, 6 Aug 2026 11:09:51 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Will Deacon <will@kernel.org>, Nicolin Chen <nicolinc@nvidia.com>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>, linux-tegra@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] iommu/tegra241-cmdqv: Reject a VCMDQ base above the
 48-bit hardware limit
Message-ID: <20260806140951.GA71449@nvidia.com>
References: <20260729220329.805417-1-nicolinc@nvidia.com>
 <anSCXUjivdb_aOv_@willie-the-truck>
 <7e66d67a-f63f-465c-acb0-c1238f534c07@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7e66d67a-f63f-465c-acb0-c1238f534c07@arm.com>
X-ClientProxiedBy: YT4P288CA0067.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d2::27) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DS7PR12MB8345:EE_
X-MS-Office365-Filtering-Correlation-Id: 34bbf99e-71ec-4431-4b63-08def3c4623c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|11063799006|56012099006|10067099003|18002099003|22082099003|4143699003;
X-Microsoft-Antispam-Message-Info:
	GOldzsKZEldOrG37TJZg3nj3Ld/BOhha+DVn2iWuXp7813VvIJ08jWXR6jA5wXBKPQB6cYmGmHdq6OIB3HGuwWmcRVcM1SWD/FXyGGDx5vR06uPG6MAC7DvDU8eGJesL/9mPratJGX578IcjHHBV79vFl8veWUk9e2pY0jlHRZODObub5dKuDwTNR88uEQVK8AJ3qeLBSNdu5MnjSY5xNbpgqHJeQJSoNOO4q885FCsZH7kR/O2HjwPSnM/SylBFfDbjiNZULOawkfAvvZ/KNQ3kWieM7yxuoInU/Ax6dyZw29HUk+8u9NOZM/PmeEb/oyDEt4qjvZKZKVrX8dZyDipJihGIU3Wo5JFVRtuYrzmyFsJt6oupACc7S2nEHYP9EFJPo6lqAjpLXOVITTvX+KK1XkaiMPjrSSecCVJ1/9ILEX1j6Iz+W+nOaHK5LzQI3XDusWNXRDLbuI9k8OEZaeE8ONb5O2AhqZlrbUc/RyhfP+p4NtfsNf5/h6A8YUxkijQZRauE0ZsINbdy+bkTN5crmlRAU5UG7EjZ/s3Iu98ubMc4iI/dAvvTP8AAbnmg7Agz9tvqeiRPL4r3ACAbiiG1HMamkQzEEudnIt8ciVBDg7X0th3MpZ7ONXcgOs24aAsD+8do1KGRq6r9pwlz0sUCeqtObU1SFyYq5q/ZvCI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uPtUtMd1Wti030/G46w9MOaIjbkeUyFdV4TL+Gq2IoOBMKfAKp9gTlLwdY29?=
 =?us-ascii?Q?oFDKZKjtTOIDKgmRsMNQkTcjgv0GJPyFW3A6TskNHwGQNDbacyYlUJ+3EJKI?=
 =?us-ascii?Q?en+K8JKxxrMexd8/wje09957EdrQOgv9yP4nSioy5C1klPZZQnQxjztItNft?=
 =?us-ascii?Q?mwytiTevF3AYMw9DqutGhxET0Nw+TvVJvISXSQ9sfJMjaNkHMjwFx8SpR49F?=
 =?us-ascii?Q?jPhDJGGN2ObaP13QUKezO9QxspmSjD178KCwvDHBsDTq1NIe6Uxdg/tbdUC/?=
 =?us-ascii?Q?9L+fiZECIBcAPZScrHH9NsZJLNjNhuoTa3NAJrChTQFLbYN7EkN6BM02L5r1?=
 =?us-ascii?Q?SGiYA4SblneoOKbh+29Q/CBMjEmBheblvinIu7VTMASRfxbi0A8GIpUo/i5Z?=
 =?us-ascii?Q?/27XfRh9ftCx6SCmuU3FiHCPT6AVF/LZdtJjG3DRehVS5WkQ2fM5vPqruYrx?=
 =?us-ascii?Q?EVHGgl9J5rsIQgBDuoVIIgXz72baeoxYqrhtL4NHPy2tLDji/mbUsAiNXj4C?=
 =?us-ascii?Q?SiEO8a/8MGHJohkHxJG5iLqQpVVL8C2cTuZyseGzlQOZn4mpBnZdq64xL6ML?=
 =?us-ascii?Q?oy4RiMpSPcbTOjB2xOjqcKF1qV9ZX4MPWRSYmNqQVuSp9ldMoY3HawWR8+4x?=
 =?us-ascii?Q?a5MtnYNK5khNC76/IyFd0bPJoT2CMmPX0wC8L/3tNAeupVa8vsAIaoWvZgim?=
 =?us-ascii?Q?QzXnNDuChfoKDpMSpdSNTyLhxZeByyNgRBRs2AmvuEsbhs3ZkGPZ4lMYj0E4?=
 =?us-ascii?Q?bpVRu8UgqpijbgGPPKrLtSBfaSjEBq0aVxzZmQeCFMPlZTchUXq+mwz96N8/?=
 =?us-ascii?Q?TTC9/z1fZI6BjEpoM2B21lXglqRe9/aWihfWmiIjGGRgw8OU7JjvrYJQTi/d?=
 =?us-ascii?Q?p3YSttS0hNxOZOaVeMcA6UaYjPUt+vKMnu98eLR4NqsZui0Ow4mZe6JrTmja?=
 =?us-ascii?Q?tz9LafbRQ291j4a/zWYtQZrJB4P91/Dm8Jicz1Rkp2SWPtfdsh7Co4/KrbXe?=
 =?us-ascii?Q?Y04kj0WovGGv1OUGnQDcmySTik4b7tBCpvZ2SePFN+tWk0wLPYMf3q1pPqBV?=
 =?us-ascii?Q?ZP/cZuO8cqxlMf2crU8m9syPzRSfiAvn1VQ6gRgUExyU0Wb6UgkLUPpZpcIo?=
 =?us-ascii?Q?nIAt2qoqlkJIqo+ASvdK7mt0gD5Eq/ndKX5ZtNUj1gwiJJzwfx+qXR/yiQty?=
 =?us-ascii?Q?Fhrmef4Dzyoz9uHc26eCt4bPQDpeA6hHM+IfpHkonZ0XsCz5ARQgjY3cu5Bk?=
 =?us-ascii?Q?xQLid40GSpHUnhsb2RcZSrfcxgB9bG76pM+sQj7bqn+Kobg/X8R7S3a33xlQ?=
 =?us-ascii?Q?VWPFaGjefUKhMTmQEL82H8Q8LEv4lxkT7sJe34/+wdBRMIKJjGaHC+UV8vEc?=
 =?us-ascii?Q?qwclWO/q8oOEe6bH9/3JLDpW3dHf7kZXsGevbnPCEPpGV6xXa5nsWKq/XZ3P?=
 =?us-ascii?Q?UwcNROTpD/jC5mYr/+1ivJPGQ/i4aEe46OtFOjxM4PHiButv1KXivCyH5Hcj?=
 =?us-ascii?Q?1iPL5hdpI69aKa6LRqocCa5pOHToAAM1CF+4CQtW7lXDdfrMp+F6neUZWKeh?=
 =?us-ascii?Q?6VyhbSzGa8sg0ty1GAZfUzV5RdNzPm2cG55ei2VpBUjKuzH/CsgBRjlAGfY0?=
 =?us-ascii?Q?ko+uZGkJr1zDpTnMXZlQRVacqW2kIp4EC6LdflLLuHaPrZ+06EkL2o4hfimS?=
 =?us-ascii?Q?5fllYUhqw7JQdLO0BoGBG4zga7iKPvUTAjrLfialNgSZW+B2dfEvVts+yXz/?=
 =?us-ascii?Q?s7jNF9DF5Q=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34bbf99e-71ec-4431-4b63-08def3c4623c
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2026 14:09:52.2097
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EWwGHMpeVr6dVUZRWXc4dvriRnKxWBbbPEaX4watjvBUiOO3gxIh/w58i94eJugs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8345

On Thu, Aug 06, 2026 at 02:17:31PM +0100, Robin Murphy wrote:

> But if we really do want to bother sanity-checking emulations, then why
> allow them to still get away with being broken in the case that we do happen
> to allocate queue memory at a sufficiently low PA anyway? Why not actually
> validate smmu->oas itself (plus anything else relevant) in
> __tegra241_cmdqv_probe()?

Yeah, if the VMM has setup the SMMU so it cannot access all of DRAM
then it is going to be really broken across the entire driver. This
just doesn't work at all. No reason to add any special cases to look
for it only in vcmdq.

IMHO the error here is masking the base:

 	q->q_base = q->base_dma & VCMDQ_ADDR;

That's sort of a HW bug to design like that, the base should be a full
64 bit value and programming any base that falls outside the S2 should
always generate the same HW fault forwarded toward the VM. The HW
should have captured the unsupported upper bits and compressed them
into a 'fail all DMA' flag.

Jason
