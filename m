Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012032.outbound.protection.outlook.com [52.101.53.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E487463B7E
	for <iommu@lists.linux.dev>; Mon, 24 Aug 2026 17:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787592320; cv=fail; b=ZweVsrqp9jP1FOvy+qqaPt1m7+TcjMX5RyLT/mgAVjoB70CxaqXz4BXWFTY43sboV3LK7BDaPwoS2UJ8Md9x1UKpDF+oOy51e9y0k3lJyVxX5yDkkqRBxk3WDIf3pnKQ62iFUWszSeucS2i47KOIasi42WMn7GaAuafs/pEVP88=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787592320; c=relaxed/simple;
	bh=8CIdhanBiKEYeZoqYnlNXsgFe49rvRGz/twEgqaQdSg=;
	h=Content-Type:Subject:From:To:Cc:In-Reply-To:References:Date:
	 Message-Id:MIME-Version; b=S62XTaVtKSZmBWQK6osnGSghmRhM7WdXVVFW6IQueAu+sEHKJQHIqGy2uzoon4U7c/ruOx3ZERx5AuxMvyY/nD7QIPlU6rYSDy+fmKfDkGnG9gS81S/Nsf6RAEkKcH8dJfG82pXfdKDwhDS5rE25JVB7/dOEAhM4SO8+iv+5rHY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=I8hNItO2; arc=fail smtp.client-ip=52.101.53.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="I8hNItO2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ljl5PUdeOl3cCYw4WYpF+ILSLev6gVZZG5vjynLKp9evZT+yFEFGA8eCkT/PSeavqKXY8f4fBKbb84sTDQ0JsfEDTDLp5s56VUVSNaJyBKl9WyKkhkYz1YkGzHvoSX8vbNGOZ1DXpKK6Nwfx0+8Wbzj+/OdOILKbg3SA1xdGA5ixMPi00qtz5IISgyq/SV++e8aAEqHGtGPt4syj8axoB2r7S1PRXYAyh/QGe/ci8tkdMe+6kMWWLWjNlYKX/+bhTeGF1Kg0vLhV43COZ32JSlSNHqknm2qwPWbjtoryJtgdTP23z23q/Kj0BeWa9EvexBYk08iFCHD3/qL3MkX43A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sXNWyfAaZVlxKFQ1scqUkbUtoxNdeZGrSPV9R9WqdOo=;
 b=HV+QdnHWGCMQsCstt7xeuDB1R+po9rpoKYkvAdoDcLTKuyouv6pXxxtiuwWFL9WmXWu7L6+Hv0VXo43CCafCx1/sK6CffKBOVeWD/s4X2jDWlukxps2PVmh3GXwzLL/sijL0VWKEUM35/SCznYQ1ub73dL0u4pd4RzySmVM1C32BwA3L5r2K5MY3EXiboxOuaLCuHxZ+29unf/QTZfwgbKXj1CIbDAItYPHDX1JIUsBbRzwSi41/xy7J2cbdzoESjw4ylSnfD5kfrsAR9FOgIvVKjGAv9UARtI+16wX9qAARochRW3JOUo3a8xqjyMv86tLrJ+k5C74Z+/ZDssup9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sXNWyfAaZVlxKFQ1scqUkbUtoxNdeZGrSPV9R9WqdOo=;
 b=I8hNItO2e6b4jNKyEyKHj/qt8/lM2+geCZNGPI4x73D3bMX8G5eH2nTeFvOUssdZvbPD8JIgU7k+T9nVUnXNcjcYHKSn45WC3H2kS6lMAqZ3sgg/9lsSicSipyQ9ZjFSDaid9oapVKbs1DvEHEXHn+rxdHW7g+i5SGPSEFszPW8eA0ZNOe7LgyHJj1S4LZHFJuNYK6OgeStJRqKY5MNZaOaRucbRAIbidPAi5kP4+OSXU7HA5ZO2po0R086CrXxrGSgbN/KSD7aAJAZ/VUSyvAA1+1g1aPKbKeeFW+G+icNFC6R2ID+6jNoFmz/jYw7sX/uzobFru3mft875A5uT0Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by MN2PR12MB4302.namprd12.prod.outlook.com (2603:10b6:208:1de::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 17:25:08 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 17:25:08 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 16/24] iommu/amd: Introduce IOMMUFD vDevice support for
 AMD
From: Jason Gunthorpe <jgg@nvidia.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org, 
 jgg@nvidia.com, yi.l.liu@intel.com, kevin.tian@intel.com, 
 nicolinc@nvidia.com, vasant.hegde@amd.com, jon.grimm@amd.com, 
 santosh.shukla@amd.com, Sairaj.K@amd.com, jay.chen@amd.com, wvw@google.com, 
 wnliu@google.com, dantuluris@google.com, chriscli@google.com, 
 kpsingh@google.com, alejandro.j.jimenez@oracle.com, 
 joao.m.martins@oracle.com
In-Reply-To: <20260727132913.22475-17-suravee.suthikulpanit@amd.com>
References: <20260727132913.22475-1-suravee.suthikulpanit@amd.com>
 <20260727132913.22475-17-suravee.suthikulpanit@amd.com>
Date: Mon, 24 Aug 2026 14:24:56 -0300
Message-Id: <178759229636.3131778.7852603360369389792.b4-review@b4>
X-Mailer: b4 0.17-dev
X-ClientProxiedBy: BLAPR05CA0046.namprd05.prod.outlook.com
 (2603:10b6:208:335::26) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|MN2PR12MB4302:EE_
X-MS-Office365-Filtering-Correlation-Id: 91719b20-85b0-4e4f-a18c-08df0204a377
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|7416014|23010399003|11063799006|4143699003|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	wWEjJj70o5s7hrnwIK2bFtp08b32erbOL+NHMUC1t6sxIVAYQyVJwaHpktXGvjYkD3/K4yn1aTMCuvzyujye/na/52mqwcQY0EKZ02Q7TVHSEmWH75Rl8vZ3jQPB33rJ0NbsxS1KSDs3zkQyBPzcqZBS1n/etdnWJf1JhbsqVTFVS7j+ykOLQzXbU5KQYqTnoQkuFfj90dMth6XdLgSySt5BxfUqvu5cP2NWBu8YF6ssXfTgGizpRYUcjMixgDgYO4OUl1QwSFQe6yZPiZwpXOjAn1Z4zId6unWhVhtxG1huLImGrbMhEifQZN54CHuH4pNggFCJcqcaq1RlfLzlQLj3w9IeyypcKkldCWwVmx8xpdqa1daIjd/HkSCvpMREYC/dWk+BvCqSzzUOeQL7TdUCXlXjNmjGVxI92HOOr4bz1A44iUtQmsmmS1hazXjbilKBcOhN73yldzz9i/qK9Q9oBr1lV+BKI4SCOvQm73Gpna1Qqc9FgwEwzCedbu0RVxddLvjY2t+nRXxiFjngR/x4rxbvrvlUrdz1ib/FWay6JsV3bTZElWE1qqEXP5mHKDjyIfRfGsdw4g7k6PeB7W/F7ZgiJsHKa7eOvIj/isgtHZLl2JEF4acn4S/4N1brOP1UkvxpKZdImICnf2CqUvR0mnr1qL8VrCd79vd93Hs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014)(23010399003)(11063799006)(4143699003)(56012099006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZTZXWElINTdPOS9JOG5HWC9QeUNVeFJIYXR1bGd5TDFhckVHamEzZHliRHVi?=
 =?utf-8?B?YnZNZ01Fclorc3BrdTgyQUxZbUlKTW9QOHpkL3c2cFBoQnlLb0l4UmVOWGYx?=
 =?utf-8?B?SHdHeTZkMGtvT1dnSnozNXZsTk1DM2kwSXJ3RS9zMHZjQWhhRk9mZ09DbHB5?=
 =?utf-8?B?aWtsbC9oRnZOSTM5TG9qMm9QVG8xczN0ekZqdjNuR1NYQjhybU1jV0Z6RG1C?=
 =?utf-8?B?dFNVckdsL1kxaGdKeU11ZDhHaHAzcE11eGdxbzY3L1d3TlFDTUlnbFdGNEw4?=
 =?utf-8?B?Q3d5QjZvaUQzR0ZkU3hNMlhMR0I2NThSYyt6Y3JZa0EzUEhHRURuR0RnUk43?=
 =?utf-8?B?RFlsRGtGMmJDV0lZTnp6U2UrMlhXMTk0bjRlSmwzU0lUdEtoU1dUb0tSUm1C?=
 =?utf-8?B?UUl2Q3l3V2RES05SMHdhaUI1LzVYaXZsSEY2bVNvV2hqZ0U5Tm5QTkNqbVRi?=
 =?utf-8?B?TW16cVBJNzlObStMQ1hpcURzL0JsOENaZnRUNThqRnY0Y2w3MmpGZTVMWHBJ?=
 =?utf-8?B?dUNOUDBNWERrclc3azNqK1AxYUQ0OUhUTVYwMnNkd3RQRzNYaTRuZkpQa2Nq?=
 =?utf-8?B?eTNpUzI0Z3BZMVluK2x5VVNuOXBZTmxpOEdEOWY5MXM4Zk5uMzg0TTd3QnpY?=
 =?utf-8?B?REtScnY2Zng4YlhXMUxLdDV5RGdiYy96eVBHTTZpYzZ4OVU1Z2ZxV3lVRHQ2?=
 =?utf-8?B?dWlCRXgvd01jVG1MSHBVcFlSOXp4L3JoT0p5MDFmSlIyejhRWFlVNUc5MTlM?=
 =?utf-8?B?UXZzUGtGUWQyMndkQk1hRkkweWs4SUdJOEFlc1BSQkRicGE5bHUwc2ZlU1ZD?=
 =?utf-8?B?SlJLZ0NCK2E2R2F5T2x2SDRVWE00cnhyRytiM1BjMmhZSi9OTDJBelFVM0tZ?=
 =?utf-8?B?VDFiWWE1MEFVUW5VeUZMWll3ZGF0UlhHZVpJYnRNZitYUmZBUEo2bHB5ZUls?=
 =?utf-8?B?UzkrYnpBL0h0TXlZRmJvdWtxTm1mbFN0cnE5Yk9ScGI0VXdWdFlQdGw0cldD?=
 =?utf-8?B?RDJyeUcxaDZEQjNySkQ3WHhrc29vT0ZyM1FNaGpjSlR2RmpnZEJkQTFuNklL?=
 =?utf-8?B?UGk0WFVBR2h1UjBsNlVHQzAyWktYTTJzb0ZGbi9VZXJ4amNjOTg1N09JVW15?=
 =?utf-8?B?M2d0VU96ajUrQ0FDelVjOTNPTk1hb2Q0S1hVRmxFcGYyZFMvV25sUUVtRXJW?=
 =?utf-8?B?ZU5yY3FDRGx6dGt1TGVGMjdiWmE5NDhzODFKUXd5cUZxY0VVb3B2OVAxSy84?=
 =?utf-8?B?dUkyZzV2UFdiamRienhNSzNBbGZLQi9JNTFOTXZyR09jUGZUcE9YOFhIa2pM?=
 =?utf-8?B?bUdEb2pldklMRk4ySnZDTUVqa21DQ1VyY3ZyS2JPV1laMkhBRUhwaXRrSnpT?=
 =?utf-8?B?ZVJDYnJ6S0J4a1hDaGcxNDYzb0s4UDNEU3Q0MnRsSkZjc0EvTlFpY2dXT0FT?=
 =?utf-8?B?bGU4SGh4ZldRSkJzL0N0T0FOT2gyNllaL2oyWTVWOEttLzRTM1lLbGlwMnVG?=
 =?utf-8?B?QWlnZDFLeHJDZi9qV3N2SmdJQXVBR0hUaWxETzVVK0trcUxiUDhFbSswZnh1?=
 =?utf-8?B?aml1V25HRVNObHNQSTYycldDWThHSnpTMVVTT29yNithK2JTMzkzMkZkV1RZ?=
 =?utf-8?B?VGJZVmZlWlkxdHN0dm9KMjdXODFIUS94YzlkaE03bnZXbUZVL0RlYVd0THM1?=
 =?utf-8?B?U2FuTmpPWThUblMwVEJYc2pPbVo4OTk2ak05bkRmODFkV1N0eVkvNDlGUG9R?=
 =?utf-8?B?MlJMdlVqVDBGSUxOYWJINFBrdGs5eVZGQkNNbWh2VTkzMHhtblhlMUVNR3Zk?=
 =?utf-8?B?amFSYmc5WFhJeGg3MStrOHFFMGMyOE1MMlgvQ3ZHRTdySDZrTi9McjBzLzZs?=
 =?utf-8?B?Y240cUtQb0tFaVE3M2JpN3B0N1VKNGFyeGVlTmdiZEllSi9sUUVOSWJnc0pp?=
 =?utf-8?B?MEFQVjBOOG1oY25aRXNFclN5L1FGa1dVb0cyZWFad2lKM0hZWmlBckRqWFdu?=
 =?utf-8?B?czZFYm8yQnVkakd6TC9YY1JieGc2RXhSTW52WHdYQkt0MDVGRS8vMDFBam9V?=
 =?utf-8?B?SEFnQkxScjZEaUp5UnFRYjdTa0hRYTNYZVNUMmJtT1VtNzNaYWM3TEJNQXlY?=
 =?utf-8?B?Qk9BbGxwL0VzTENvRmdoSnhDL0JqU2ZxUGVNczVwRU5QZzcwbEpuQ0VxYTlH?=
 =?utf-8?B?UDVTK3VPTUZqMnpNamxxUVlXKyt2bUltbER2ZHF1Q20xYm5UWU5WczRlVlpa?=
 =?utf-8?B?NUpYNzFxaDRUYlBxT1ZLeVBKVGtjcHRIWnNNdm1RWjBXbHVqbmd3OEpXcmFu?=
 =?utf-8?Q?r0wOYNsZvuDJN6ghwC?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91719b20-85b0-4e4f-a18c-08df0204a377
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 17:25:05.9850
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EDwYMJpfpogA5S5j6f5VO2UoW7vHWLBDb+9SEnLAz4uI3mQUNq1dgAhA5lT/AA+i
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4302

> [ ... 56 lines skipped ... ]
> +/*
> + * Called from drivers/iommu/iommufd/viommu.c: iommufd_vdevice_alloc_ioctl()
> + */
> +static int _amd_viommu_vdevice_init(struct iommufd_vdevice *vdev)
> +{
> +	struct iommu_dev_data *dev_data;
> +	struct pci_dev *pdev = to_pci_dev(vdev->idev->dev);
> +	struct iommufd_viommu *viommu = vdev->viommu;
> +	struct amd_iommu_viommu *aviommu = container_of(viommu, struct amd_iommu_viommu, core);
> +
> +	if (!pdev) {
> +		pr_err("%s: not a PCI device\n", __func__);
> +		return -EINVAL;
> +	}
> +
> +	dev_data = dev_iommu_priv_get(&pdev->dev);
> +	if (!dev_data) {
> +		pr_err("%s: Device not found (devid=%#x)\n",
> +		       __func__, pci_dev_id(pdev));
> +		return -EINVAL;
> +	}
> +
> +	pr_debug("%s: gid=%#x, hdev_id=%#x, gdev_id=%#llx\n", __func__,
> +		 aviommu->gid, pci_dev_id(pdev), vdev->virt_id);

What is the point of this function? It doesn't do anything, and you
cannot have a vdevice that isn't already bound to the iommu. Please
don't add random !dev_data checks where it is impossible

> [ ... 66 lines skipped ... ]
> +
> +	/* vImuEn */
> +	new->data[3] |= 1ULL << DTE_VIOMMU_EN_SHIFT;
> +
> +	/* GDeviceID */
> +	new->data[3] |= FIELD_PREP(DTE_VIOMMU_GDEVICEID_MASK, (u16)gDevId);

No need for a type cast?

> +
> +	/* GuestID */
> +	new->data[3] |= FIELD_PREP(DTE_VIOMMU_GUESTID_MASK, gid);

The comments are a little redundant with the field names :)

But the dte construction flow looks OK now

-- 
Jason
