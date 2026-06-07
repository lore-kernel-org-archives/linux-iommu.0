Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011040.outbound.protection.outlook.com [52.101.57.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E293A5E6C
	for <iommu@lists.linux.dev>; Sun,  7 Jun 2026 12:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780834183; cv=fail; b=RM9oTuPv9/UjR8Bs/NyUqwW+rpExbl0LGSSXPNvXj2RvO8xK7fFM+PGgywkOAWqo83TBJJJCP6J71oX4sx2/I9J6jYRKwUlyysb00v88wCrOMetH6pxQ7c89z4JTRLB8SvXRHmuPF1pkb7hDx5szPUPZ2Bw3XzLQWVyvQQssPYU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780834183; c=relaxed/simple;
	bh=Gvpj3yrf0vzS1Z3DnBg4IqHtPmnX3PPvXJL2YZ3ZELM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=C90xQ4GGVxnFqaDdzr0N8kOG6II38RB32y97o4WB3a/pBMBmeBo3hwrZtpaBC3exkV4iUn5s/nAf3zWrbpN5WcrtZoYALDz2feIPM63Wrb+NxEuuKKaEMW9BKZkJYTp/ZsflHfSZeZopTNpEB0JsBBl+QwXYYtXkqLWjIDnbZDM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GWnGHAtp; arc=fail smtp.client-ip=52.101.57.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GWnGHAtp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=inKUO0LuN+Uc5GbJ0HQYKYaVSvyDwcG98bD7RCMqj9OSa6aiWOeGaVuDJH5tKNlZWY7PCdJw462ZcTvU5shLgghVozREJC6hICwrnE/x6tpHOuGGK6f5M6GirZED/XioadJLExGgxBmBH8BWB47ok0VFDEoUqPREPFCeskDUvBhb1KkSVGtV+R8/OJ3uiSaK732prT5A5dSMsQ9BXk5bw873QMyeOsS/2ixSx7t+01mBG/PHSyzoBhmLG3CtBncohsu4twBeHDIVCMFIfgoUG3aJ7dknAlZChSMIY2/AGOMyHVDnx1WjKbcOAtye75+61nPOMCbKv1xmyieAFaljOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pFXDSCKXAKi4kGupRZ5SQ9xE2oWSRiN0xua6nRQuhrs=;
 b=qmRpKvtFBAotyjH3l0axZfDDpXyx7Ivq1zUc5tDXf6mK0mo/db9+8uhdqx0Wdw/gzlVAl1SlPJLXidzM2HNUTLcql/sYwlYh28vlqXCBZY+gF24dAGn44Zzf/+JT8Z0zUIK25tAXxqU85c7BFitwLtmOHk/K80Yn2YXsURS/FxId/H+KnHLrx/EG7U1usuoaJn/9PmJU57C3Hrahr81I0Ao3b39imYxTvUR00qzrQlEkKlndc5tY5xeNpvSSvdrg/E/Bn+6sUHgOzcDvJOv1FMYfzrhbKpPW+/ycbj15i/DZfXCtcNslpp3bSH66AjEsqWybZuK4lN024nWCzhRixw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pFXDSCKXAKi4kGupRZ5SQ9xE2oWSRiN0xua6nRQuhrs=;
 b=GWnGHAtp0MEVqtiAwMCwORdH7K4vrvlKG2ULLsMcESRiheacyH807vC/MPRaeCjwnvjW+tn+ao3MuLWeI2KyNvTtr9Bh02Tp5Os5lvxrt1vJJcwFGAnBOOEz9Ss7JKqvyzeUJUnYwoOlG8+dNU8DNLPwuxspdCEWB8N0V3YhusFk0ZZcvqapOrD2JquPuKcm8Xdi6RHePm9k40+l29jxgYyNnDnHdJS0C69BIsMlKcTw5clS9YBUyhTSId5nr0qQtCGtUfelFgyI9IOOaH1T1QEYe/tK1c8QCyA3HQ9zhSLyMwVFngrusl+jtvyI3KwPItynx5cZquIIYWrNhlie0Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SN7PR12MB8146.namprd12.prod.outlook.com (2603:10b6:806:323::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.11; Sun, 7 Jun 2026
 12:09:36 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0092.011; Sun, 7 Jun 2026
 12:09:36 +0000
Date: Sun, 7 Jun 2026 09:09:35 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Yiming Qian <yimingqian591@gmail.com>,
	David Hildenbrand <david@kernel.org>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	keenanat2000@gmail.com, linux-mm@kvack.org,
	Christoph Hellwig <hch@lst.de>, John Hubbard <jhubbard@nvidia.com>,
	Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH] iommu/iommufd: Require write access for writable
 MAP_FILE mappings
Message-ID: <20260607120935.GG1962447@nvidia.com>
References: <20260607085320.73274-1-yimingqian591@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260607085320.73274-1-yimingqian591@gmail.com>
X-ClientProxiedBy: BL1PR13CA0421.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::6) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SN7PR12MB8146:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ab97a8d-6488-4952-5abc-08dec48da481
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|366016|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	5J8DUZpcT35yiUeS05SFaISnTzIH2tRZNa/Dc10RAK6dmogF3jqDaY2fcg/Xnjm0N86ei9L+4jxvx3vXEMwNOlst5yY5O0A5tx0hsQgQrqIq/XQKnn/sf8mcy0cQfvHCQqn6Tiqe4yz8ejUKnAj0ZeicI1+ueAN1rjTE38o734FszloI9Xxlyr6apMijhRSEqnayMRL7AhKHcxcqOrUk8JUi+BnKpnCDh+k8Zixt6MUsORtDZKh/A94598xuKIrQxBqobp0G7FGfdmxxMel/hnwUzwS9xjwLOonIKopDdASDYMO413EKPa0ydqR5f/OCDVfSCuQodPVr3CiMdDH6VVP9PsDs/J61J5zDJyHcdTSODf/0o31zPdPi0QZdDdvasipj2N3LYfpyGkumCnZjwYh1dxEe7/pMsRq/rdkIC8F6x9ovBi0TF5hBaqP/9D6/SeNPx/Pc67qYxWXzYWSL1+CgMvWl9OBfqxUozIa3bM3E2hgOeAJOHDO2G7ycCHlW80PgXz0SVWGpkcgojiWgpNOUqQ7Uvnz2qSQBKhtbVawoAi9vBz9O5lSqSE/UBTdi0gOn+k+OizxxzNXVEEQ46a4B1tIBTGOQ9EW9LwMq5fV1e8qNyic99xgnDHTui4z+GDwnyiWaL53LkdUXvj8qn8gF31/XcRadPbitRzT97/2nUpaUZpzv62VFAfFsa+r4
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AzpxnDcF6dOjDWt5abnnuq6B1WjDUwQxAsdCetKuiULpygNxSaoz9l79tSj6?=
 =?us-ascii?Q?VilVwLTH2DRxxAKOCxFOFHSAo85fnmTxuD/+eL4syh5FDPXKexokd/oYylAw?=
 =?us-ascii?Q?z/ndU488LyImfK9P5HjP/7VgNSdu1ZPocukaTBp8wyKqQsMiSEYH+Xh/CSIQ?=
 =?us-ascii?Q?hca3KIiGoKZZnLSNgQudf6aDiDkkVGVOeRweLU2qB9L8wWw5x0N2jCRa/XQK?=
 =?us-ascii?Q?8AqVWpKIRGJrKjKfm+wn76nymHFaVqJYzqZsSoF1ElLAYIKWBhM8As36gHPz?=
 =?us-ascii?Q?+4OpbLN47L5FXYiIFXXsg8KPxmBKOo5NYDjZlEobm+WzD2KpoOqsHc4vX8qr?=
 =?us-ascii?Q?jTn08tV8fOugqjcE6HEzbYm+MuZEgz7OHuR1dhiWS6z1sX+8d/0jLMn0MJRS?=
 =?us-ascii?Q?kNPCRLIwVQTgqLvgTjCsBDgxoUw27J5Iy2CYZ13x50k+CXpsdqLrQrsUniZJ?=
 =?us-ascii?Q?8J5BWDjUOh/N2LeEkLokO3cc2CS0E2JYzmHSHmbmEJkTLy04Qz5bfl6F28wK?=
 =?us-ascii?Q?JS1n6NdBwhYZptJz87Er4YzEjJIWCY/uh2f7vIH1G6Q9R12BcO+LxMr6KusS?=
 =?us-ascii?Q?B4LWGRVPbNFtMIeIRf2mdgsCjARG1zVP7vNUzkJjEnzsC4UZMl0RR1rXsgAa?=
 =?us-ascii?Q?oHO3Z14SeJV7dJ3Mk3ZIg6tDyo8P28GjwMCVSo8eyFhBnRjqSGdKkb4XvHkz?=
 =?us-ascii?Q?Q3Zx99iiiT3IykNGTjJnYEfqBpMjRRCnN8OK+QsbnTPkgsjQSdSmoCxLJnXY?=
 =?us-ascii?Q?XLHUa+1kkkqp3s1hrtPrtbuo0isAzqYBQL8306BN79bC8QAMggWAUi9K8Tff?=
 =?us-ascii?Q?e/tTTnaAtHlOUn+iETv7WBaPE5r/pkG7BcrPQoKcRG8GmuhPp7FpZ7WaYp9w?=
 =?us-ascii?Q?5a5aIIiPJzezIFsL7CeZA6UJUsV8+UkD+NQYHVboFop+aB36IydfZdCtLSdP?=
 =?us-ascii?Q?Galucc8ScwnZa589SyHPyw5VOdlX/Tg2+KxTaa179gANO1O/yZzoE2QuILMw?=
 =?us-ascii?Q?bQBprWX8zKAl77LxwsDUXBtf6cnwtrRFZRk5lLidr4+M0YGHQu1ijtzgH06u?=
 =?us-ascii?Q?QVHVKUXxyot3f3EnLM6eHs5AIetwK9DSXSnA//3vmPHSGYnEAkHzFgUAIa9p?=
 =?us-ascii?Q?RZeidGyfDWofdebyQecH4Co3i8euSvMhHwGkYBkgdOYAizC0Sl5hHPUtI9Ys?=
 =?us-ascii?Q?knwMH5azcnZRLsTRjLeKyzUNSTqLc/8hR5v0vKWbkoXJLX/x2rHo99Hl1sFh?=
 =?us-ascii?Q?B0pi1F2uS9COjQ0XY6g9MQgbL1zK0C3EKib20RLZOfGUrcuwA9PhlNSw2/Uo?=
 =?us-ascii?Q?rAL9EkSwKrFR4roAHJqIGRGaclNUdOUhhqV5tCeYrXjoXdAcWpEqe9Uw22+3?=
 =?us-ascii?Q?Y+JeDp0Om/a4j0DUk5RNmHFUt1WyZwwLvJd8J7EnmpTwup0+weHF4f8yib5h?=
 =?us-ascii?Q?35U2+gLEX0dx0eE2mz7eJMiU6ldyCB6s6TxkBC2Vadxy+EYnsN18VQjyuykA?=
 =?us-ascii?Q?rPBN8HOg6M5etibN0nSZDx9xQm4U0eJ5+kNGyWsJeIVIjeKjJ+p5du2uZ1lg?=
 =?us-ascii?Q?KwxvI9ZmkeWzAHqJqNOBc3cTBg9qfT8xeXXzO+fsEBtW9eKO/NfwE6b+HL7z?=
 =?us-ascii?Q?joZ/YuF/iYiZgqzVF+NhEU5rjgk8/+QbZrafAcsT10QIno0oVLm9MsCUCI2/?=
 =?us-ascii?Q?C2AYuIzNMfkqMyV37q0LCGlRP2w9KNWQj2yScW3dBMB+WaAs?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ab97a8d-6488-4952-5abc-08dec48da481
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2026 12:09:36.5414
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gu1YS7D97qKzrFX0KfiGkMVK5QB0BEz9TpIxIbig4qmJAuSkwk8y+6gwoORMThvu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8146

On Sun, Jun 07, 2026 at 08:53:18AM +0000, Yiming Qian wrote:
> IOMMU_IOAS_MAP_FILE pins folios from a shmem/tmpfs or hugetlb file and
> uses them as the backing storage for an IOAS mapping.  When userspace sets
> IOMMU_IOAS_MAP_WRITEABLE, the resulting IOMMU PTEs allow DMA writes to the
> file-backed folios.

This looks like an issue with the API design in memfd_pin_folios(),
all users would have a similar bug I think.

I don't know much about memfd but this seems like a legitimate issue.

Add those involved with gup.c and the patch adding memfd_pin_folios()

>  {
>  	struct iopt_pages *pages;
> +	int rc;
> +
> +	if (writable) {
> +		if (!(file->f_mode & FMODE_WRITE))
> +			return ERR_PTR(-EPERM);
> +
> +		rc = mapping_map_writable(file->f_mapping);
> +		if (rc)
> +			return ERR_PTR(rc);
> +	}

We probably need some kind of companion API for memfd_pin_folios(), a
start/pin/destroy kind of thing to manage this?

It should not be open coded like this.

Jason
