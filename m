Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012007.outbound.protection.outlook.com [40.93.195.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA21441A790
	for <iommu@lists.linux.dev>; Tue,  7 Jul 2026 14:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783434783; cv=fail; b=IP0h/1aZ/ZG99/3dfoQyP6H9qckTYrLg7q8o0QuS+7AD0uHRSXvuVSTqiHII9mekRDYOZhqY4UgxLWn0ZxNvo3+zwiO7GU3u/WV/kCt5QndQq7QOieeCJ5FsJBC8j3T156oYFcNpWlW8EyD0QVRS+emDSvheblPu5btdMdkCp00=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783434783; c=relaxed/simple;
	bh=ca7hf6i3E+moDiraJrWk5KivwCWBufHfK6q/vEG5Yi4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gmxMFzKFfJGV00FrqDvABX2FnntzTGywPnBhfGRKT/KdD2GsClMBA/QKdAK+incQza27vPdIhBY/LZfZAx3YhJsVpeCEgpXVq84rcjqbIKsqSLF9B0mmDUUVpa2r/Xl04qkITu3F4BtfC3cqguugnZYLckrGYzjTrzBe6L/kRyI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UODae0mq; arc=fail smtp.client-ip=40.93.195.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UODae0mq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wnCxcvHuN/6D+4sht2DJZbbJBQjSA9deCjP1WT/IuyoYFblgcGM/VGg1YsfmJLREItngrsSmtfLvw6RlLXmCLC51VPB+ugdN55g3FS+POUMDnY1wcftQp4xgRQiYpVYwUxegeuMH0KPP9p2rD4ddeIUV+C0C9QNCE8fIa9bWqTqiciMz/ZRGuNhV1Aj0It7uNxxa/OdPLjRkZZD9Li7GW8OtW67t8XLbWljVc8mgtWQ/is/gD4R6Z+JNXhyStDYT+go/rO5vQEzSnkDRHYbqaVpm2Ut5sD96XKWCuMxF2X8G+K/kpbWMHS8ZpRhT/p6jViWf6U+IVoOO2lWMOHOuew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7XuWhLe3rTWadOp70FNtnGTlw2E47jsgcmAqKUT/A7I=;
 b=NnRApwrrC17z+zksd6mvZ0DOo7+fktpqB7HGFLRCgL41ITIUkosSvqIoQ9zks1laJ9cGLDmEJ0WGaeKHqX8uwihO69NCLdMmPC0+j4cu024w1KzJBGnlfKCNmDq/pL1gZoRvl4SOqQtd9vtgNloqovuwiUqlen0s/PBVvjokO5BOm18H0/jOOXE1VVVwQN7cAR2v927ktIGfhlk9oeEqei2603dQk8LgNCDmL7E6sjueGCrua2siwo+n8CMCOo0ydPFgiV6zeOGjiJ7qU2KPndjL6F57cZ4Y2592sBGZTA43N9OAl6aCuZlgY6RSr5cD7TIIi61F5nGk+0Y24K3N+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7XuWhLe3rTWadOp70FNtnGTlw2E47jsgcmAqKUT/A7I=;
 b=UODae0mq4ZgQ8xPFzHQ9hxtv09MtSUZqQFvjY84yjPCNIk2j2b426Fv0diYU2Oa/Z/3jdSQT9f4V04LgVTZO5tq0smHb7VTTD9S1p7QOdiBrp1zanOUo0rjkksGlWRpt3yhHDW5Dqy/Swktjt9zNwB2ApuxLQTevzEmUGrL16QZG4H4O+s/IHkxaJ5vnMn/DMkwPLERJbQh8oAvoWl2pSfJgihP/HIu2bzoqlpcipfAcigxOOq5ZxEnTL2edy+w3yM0h8lYzWjn/CgwzQlhM0jeuEwau/MGAJxizAPRUtxFjLMb700a33IIb1u61uMpM8Qhz2vwUEf72se/nTGrmtQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by LV9PR12MB9806.namprd12.prod.outlook.com (2603:10b6:408:2ea::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Tue, 7 Jul
 2026 14:32:54 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0181.008; Tue, 7 Jul 2026
 14:32:52 +0000
Date: Tue, 7 Jul 2026 11:32:50 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
	yi.l.liu@intel.com, kevin.tian@intel.com, nicolinc@nvidia.com,
	vasant.hegde@amd.com, jon.grimm@amd.com, santosh.shukla@amd.com,
	sairaj.arunkodilkar@amd.com, jay.chen@amd.com, wvw@google.com,
	wnliu@google.com, dantuluris@google.com, chriscli@google.com,
	kpsingh@google.com
Subject: Re: [PATCH v3 17/22] iommu/amd: Introduce helper function for
 updating domain ID mapping table
Message-ID: <20260707143250.GE220801@nvidia.com>
References: <20260629153535.15775-1-suravee.suthikulpanit@amd.com>
 <20260629153535.15775-18-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260629153535.15775-18-suravee.suthikulpanit@amd.com>
X-ClientProxiedBy: YT4PR01CA0392.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:108::8) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|LV9PR12MB9806:EE_
X-MS-Office365-Filtering-Correlation-Id: 23fcd100-1447-46e2-44c5-08dedc34a03b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|23010399003|22082099003|18002099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	xjeZ0drcPAFWVdR1CiJlLVclP8QoipglMcDRF17s99EKGn+0dRh1KXUz9oazHR6wEFbdzIa2+2IBOZXnskQVLQKBLEhxaNlzzzQx69jh802WLgUR1pgdMXLQ3Sk1evVN515EFEQR6yap4/he7CEyFYlQTFYIAK/C4YJEn1wWi9+Vhs3n0laYysfucxYEcEtbe5IKliginLNYeXR3mRQT0LG+aFi/tvTOpoDoUW/e2jVO0jxRB/DFJ7JzCBaFLEGuUpxMdr2uk1QbHNngVHHnepHUUke/k+GPhdlvtVt4fPM/EK7dOsaGqWzuSC9mMlnIDRapz1XpvoGGuD840F1nHV5wkx0/MuwaIBOsmJ5dx5eoiLnaQV9lirLFLPMqhh6/0XPAaZQmadEmTQ3m+V4Kl9WbPrXTx0WilSbjK73F94OlzzUsofJLeu+JucZNs//JsyRd6H4JZNCSWwcmUsrwXXgaUg30AP3XL6IQ9KmexzgEAyG4t6Z328Q2J/ONAIYHfyfHc8dc4tJrGEjPGT87B3z6LRYWJi6kv2tnE+kw7/7o3IUbnsaoNK7txrVNuhjXWEruj+s1nK6ktx4pXKQPiio0WUXiqnQAmw/bc3ZF3JBpaUyu/qAer5+KHVmseglFR5pizFeqElbsjei+5CfTBPEse+jBvenhd1rmQw5Yx8k=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(23010399003)(22082099003)(18002099003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AB4OgcnBam/M1sl6lcCabgKxeK5PvQczDvvlTM7ZptkbyGGp5nNWUfrtYUh/?=
 =?us-ascii?Q?9VLqILFLJn6PsFTfLXdsPHEZnmttOBsncHsAX+NPNRp41lnzxFXnOIDNVuOQ?=
 =?us-ascii?Q?YM7hY3ISBSzFiwXbjYfxIoky7lSaG4vga6XKxseLvpxFA2dN12VLi5k4tKA3?=
 =?us-ascii?Q?R9T0YcaLkJM3cxsdJcXSpg1XJlCttMDOcBhDqZlpmpTgwS0qRR/bmpCGr6Wh?=
 =?us-ascii?Q?/BwyRZgjRllzuu2QCxZIAzrfGWjY2i+7oBDvbDzK0fEHSel2BcxCIFM34ESE?=
 =?us-ascii?Q?AxgL+RBlHp6jpd1zbnvCzwi7ubXBsWIDu1Gf2bCXwKWKGWnrNlBBKUD2rl8W?=
 =?us-ascii?Q?VkIPHftLSDcT+z7fgsbmrQQYM8pfFGq9WMpcMc4blpg5vnj6NbVOLhnnSg+g?=
 =?us-ascii?Q?CImr8pHyLxtuch8FceyIIIgCZZ9frqliTY3GRiSVjNUobSsYgK3KmbgYpWOQ?=
 =?us-ascii?Q?7SdV+06IVdXBIXZpslGooulwqpgL26o9gbNO3T9e0+CCqBU0NCiEXI/IjfXu?=
 =?us-ascii?Q?nRRmXjCBHNCwsaKnsFiXxVwMqBjnODL2bBWTB/pIpMDpK68etFFjxbt6wIZf?=
 =?us-ascii?Q?FfKNtrwoDSRjTFCsORP3tYS7Etigjc1U06DOYfxUf7r3gUXDcwafdo2iKo3H?=
 =?us-ascii?Q?r0S4oIkzi0lnUzSxMBtieoIRm/ZK+aCvTgKqecaTt4b/VjAcpLNOSTyCYdP6?=
 =?us-ascii?Q?RNqckcKRyqu4g91igF9CHTKbgrhhIjIEPnXrOkLq2IYzP7v48g4EPwk9siiG?=
 =?us-ascii?Q?LxB8MsMVLmM/NOmJLFqDgQrQUfg4lH1MTmXroG9epYVyGNdA4+7ULu/3K0GG?=
 =?us-ascii?Q?9SdXZPhCmN/EeZColyhtwStUS7IRlKnvVTyMU99yJJj1wdFzfZMKGr0nhFTZ?=
 =?us-ascii?Q?Uqbfk0TAR8yFD38XcZ3oIR5udVBZGz6p2+2BvnMdXVVghhTCGeq4SiLZDXGp?=
 =?us-ascii?Q?0RdtltBOxTJQnru/8mzRhx1j5UBm7rrmQ3o5NtQGFUCxUfSnz+M9p05Dipjr?=
 =?us-ascii?Q?r0LJDNRXS/hRgSFBtvrgHzp/lCRpelM3PxsR6P3DL0FwNhifzpssoREf2TGo?=
 =?us-ascii?Q?Vp6zqTm3ztt/f5LN7qdPhx0E8e9F8zl1WFZUsypwe+izDuyun0unGlMYA7Tj?=
 =?us-ascii?Q?nayh8K0jl+8hUxcJLbEsYo5kZbb9JOjzIhNVcegESSvSkuPcMufXuGHSLVYT?=
 =?us-ascii?Q?zMX4iluPZrj9ToCLi91F99AK55TCVONeRwIp9rBBLw5Gq1uf54hg7hLxQbNo?=
 =?us-ascii?Q?epg7l4z/1FZY1KqzNomPwgnGe8heI6+QxbIhROxMdhJGAft/dLlyLw7vU18e?=
 =?us-ascii?Q?Y49qMZ7i5FHja004KHu9G/NzlhBJR3aPbT3Z+q/jOCA0YenGN/U5RYkCN7MF?=
 =?us-ascii?Q?h6N2RfYef9kq2AlJOYnbCO1hsQnZhzEMiRti1Q5Fqw5DG1eQGiMXD/YTHIC0?=
 =?us-ascii?Q?P9tLg2m8oPgXD1fvyQZYrLE5Dft17PZxg2MTEaSsD/ffM8M4mAtQfqlcYyzU?=
 =?us-ascii?Q?Ceh6Wd8tt0mbKmZa9tR6kEMhtCyeZUWzEQ1eQLEJUQkUxaIeSKDhFMkfOjIc?=
 =?us-ascii?Q?TdAUPFCsEdSIHsSu8sI14IXrEDsFkYs8iG2bynAJSqUapxawYJbSTbRvpaHQ?=
 =?us-ascii?Q?y7TrVjrVf+mhkNbZS9PjeJEV+mlfFFpLdIg69esvkpKh5KBQqeH6UAgEBeXl?=
 =?us-ascii?Q?knuqfubSbfnF7pQy9txFsS6di6nyvanKLgfCbzvEdgpwNPID?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23fcd100-1447-46e2-44c5-08dedc34a03b
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 14:32:52.3361
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YkAZxZhJqVw5i/6YyyzI3Dq0d9TW9QZQ0Py+FfWyTRe2bxvfOXFnchbI1lrfPBQV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR12MB9806

On Mon, Jun 29, 2026 at 03:35:30PM +0000, Suravee Suthikulpanit wrote:
> +int amd_viommu_domain_id_update(struct amd_iommu *iommu, u16 gid,
> +				u16 hdom_id, u16 gdom_id)
> +{
> +	u64 val;
> +	u8 __iomem *vfctrl = VIOMMU_VFCTRL_MMIO_BASE(iommu, gid);
> +
> +	val = FIELD_PREP(DOMID_ENTRY_GDOMID_MASK, gdom_id) |
> +	      FIELD_PREP(DOMID_ENTRY_HDOMID_MASK, hdom_id) |
> +	      DOMID_ENTRY_WRITE | DOMID_ENTRY_VALID;
> +
> +	writeq(val, vfctrl + VIOMMU_VFCTRL_GUEST_DID_MAP_CONTROL1_OFFSET);
> +	return 0;
> +}
> +EXPORT_SYMBOL(amd_viommu_domain_id_update);

Why is this exported?

Jason
