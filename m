Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010018.outbound.protection.outlook.com [52.101.193.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E8245D90D;
	Tue, 29 Sep 2026 19:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790709047; cv=fail; b=IHnMjJuxCpk98ckybF4q8NgNuT5b+DbapmqKn4TOwE07dKa2SNZVesWJ77Wvt2I84HsZxhrjXzKijWEVAlUW91cJG73jb/Cpv3dOpKo/qtJQMt42hVhMkmEleJF3r6q+mWl3IhPLQu99flEwiUmm/MqDVRwU0Z7BhG2+n5hLpXk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790709047; c=relaxed/simple;
	bh=t36GaFK473LCDnekCC3CYqVgvCYlnlWgeYpWvTj2qrU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tauOQD+AuJ9Kez/MUXeh3dngdmDhTW+Kbt2QPSxAGnbG159QhgkITJoPW9B6obekY+6Mfo9tUUYBziCIlKyFsOu3K9Yt2yG0oNIe5H8ApLuqtHeGApXwucoQRJnRSXgIDknhwnO8SKOoQVyxElAgvg0zktRUb6zgbMsZ+9fAoTA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LXqEmSgj; arc=fail smtp.client-ip=52.101.193.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LXqEmSgj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tJTUdxTeOOUb4AQuxQztIy5tJu1MsvYJ6FfoFsudSj4I03mBlO2ckchLyQkCT0ECS+HEnnkiOcVJz6uMn0iQ7sW3D1Ig+AmfKfh3RYgx9cvdB9zC8HQBAdqF8c7leK+k/IrI4yUOPBiJGu6P8QLhRtXkpfXqCerpL7gv76hnnKCiXXLJbUNd5PkaD6VY6EGOEUBxuGe3U9+A8jyXBqiX5Fv6ZKpcmh42xku2V2CuLsTCpraxdClpNTbKZn7pT2SyqGqdzgbaVgu7O6ZNYOnQnibD6s4AWKzWKh3Z7ohOzAnGEErKdfE6K2q6bR+Oi9fBw/KKw6JdDXXJoL1ezfwXgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zI8Lv26UzNIVqgveJdbNAIcXue0En+gsq2cV4G46D54=;
 b=GDNs6Akcmqh65qaSzfDMDuBotGdDrAjpiG2/32mWHLUPuOjigiGPTUDSBJy0yQfQ1j5vfLoQNL9DK9TGkGwRoxu8dCjjH+5qE+T28JMVbU9Hh2bJV8fhWBknoPqITGzEG6lp+b9UEZgCVZ/I+8ROlUGpUx/zRIW8gY4eVm4R/UDUpoppA88VMumtuiGMb8xIv6ekOuo138SnWTBzI0hXIB6OcZkZJekKeAkYY0hamfB4ZT4yyMlPd4tkac6pd7kycNfuRpvMZY5RAHQZ0+wrjVuTV2FbFqmuZ+BPo6hYesa+yjPcR01nuqODCWD/+AGGQR0kD1B63/IOYmGm3dfUcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zI8Lv26UzNIVqgveJdbNAIcXue0En+gsq2cV4G46D54=;
 b=LXqEmSgjRNxszZFpFnyUu+jsWZYiCGvrC5zwr5J3CpGUsDiHdBH2t1YeemuAEVdao+WHQDcxIQ73E7XE778g+MkzPDH0ib5Wfnq7mwqGkFMbVdUz3epAXJ+EbPh7qPw3soFMBlFMcx3neIkEteZl9EG54P9f4XJ/Xy1DlD2ENZBiQDJws20hikyxDiluiCezEmnHzhBs112fHTEhoKTkj6rtdyCjv9pCrjl4GM/9lQNk/XaZNouea1NXYnleiR3QQcZ/M17e4yXQto1UygBfUFcXMZuzf2V+rlpjrHhIGOPKIBu/3FhWuMoIHlLHeh6JY2JlfYlw3zolvSPbyPKBOA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12) by DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Tue, 29 Sep
 2026 19:10:40 +0000
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d]) by CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d%6]) with mapi id 15.21.0451.024; Tue, 29 Sep 2026
 19:10:40 +0000
Date: Tue, 29 Sep 2026 16:10:38 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: "Tian, Kevin" <kevin.tian@intel.com>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	Alexey Kardashevskiy <aik@amd.com>,
	Bjorn Helgaas <helgaas@kernel.org>, Joerg Roedel <joro@8bytes.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Samuel Ortiz <sameo@rivosinc.com>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Will Deacon <will@kernel.org>, Xu Yilun <yilun.xu@linux.intel.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH v6 08/11] iommufd: Add vIOMMU provider support
Message-ID: <20260929191038.GO1616761@nvidia.com>
References: <20260917140159.1163281-9-aneesh.kumar@kernel.org>
 <179027891417.104879.5995584402952067518.b4-review@b4>
 <yq5acxu1kgmo.fsf@kernel.org>
 <20260925123918.GI9354@nvidia.com>
 <CO1PR11MB483580AB119687B7EC2DD8518C8D2@CO1PR11MB4835.namprd11.prod.outlook.com>
 <yq5atsn8posb.fsf@kernel.org>
 <20260929121723.GI1616761@nvidia.com>
 <yq5aqzicp6oc.fsf@kernel.org>
 <20260929130643.GL1616761@nvidia.com>
 <yq5ald8koxqa.fsf@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq5ald8koxqa.fsf@kernel.org>
X-ClientProxiedBy: SJ0PR05CA0199.namprd05.prod.outlook.com
 (2603:10b6:a03:330::24) To CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CHBPR12MB731189:EE_|DM6PR12MB4202:EE_
X-MS-Office365-Filtering-Correlation-Id: b1f8b82c-36b7-4716-8767-08df1e5d5a2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|23010399003|4143699003|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	DhI6fTvSC8XorMw45+rnZQYJGihbp6hQOJZ5Zrkgx4dtM4j2VcmPHK8So52kbaWpD0YR0hpTy7aDX/2HRwpVczphUGIB0rhit2J+RP5NZ55nyYB2sfkhLYNe829UshIgM5ThN88Sgr0UhXL4olkfTaNnjTrJIJ8979l5FECRqM7eWsAUHW+U8t+60dg0Qguspn2nicZctkCI7MiYePArogo30YZilu99f+UISoqC1/BYblCyXmlnyZokL9FjOQ3XbmH/8Tk+3ynZev8OWC2fdDvTEW4nYmp0rNb2zlrVlW87s/G+OCFK5idKOO4WMKUcTwWPNX22088W3UcNJBjJtl1LMByGJkSSiZiMk+siyfPW4XekQD//VzYBfDbmxtgadYLK8ABsXBMsvzVrgBUC1vpzSfxIvXWYFsZ/zFyqzgbErtf/BpHfYS8kH5Z8YSW9adXOwpdOPKvx5c5Jrei+uMie4x4JmHva/HNZRyuY2pqJv4UWZ3NjxdxwvIO10kH3T8/QXHbzskl+9ZjLP/mMR93uCUtyCCI44T6zzdDiG9ec8NZGjVUrkBDJU7ZYS8K1eRIsoX9DSYEWTucGAcKnjZYS6D6JLDbKrM2j68ciN4Cb1cLX6Ql7o/tmXbKeuIeV5bWzOuZTYv2yQTPxP9PD0zewBz4/3z+t6VmIUBnjNkM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHBPR12MB731189.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(23010399003)(4143699003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?I5X2zLxtScITxw7vRjg3Aunp8R5liIjpob2yj1CIVww/C28VLN90sczmEQ0z?=
 =?us-ascii?Q?wi3u4CPUJdNQSuPn8uOBmZqjHKC83QhfC2oMb5oQl9SLsFP1QJtcIbPKl1ht?=
 =?us-ascii?Q?N8KHv7iqx/doleqfEGzuZrzpwxQ9apwO0Ni/ywNdwvWVo7BCG6/U4ib8HGQM?=
 =?us-ascii?Q?rWIFvtrulZvqJ/Sk1coI0t/Y9m1RESo0zxdj17qH6inlUOVlxsbVcySM4hWl?=
 =?us-ascii?Q?e7+Njybr1XXXcWNtJjMHtteIkbF1B+bwH0ebLcmUMEFJyBY6chdF7Hez1cRo?=
 =?us-ascii?Q?th2x3Eswnni8+yNvfq/o54RVb+fg/YfX+KkSQzBEYoBXk5fWbek48WSDHDIG?=
 =?us-ascii?Q?xd8VcK56nagWqORGUkt87u/KMXVygoN2mI5qg56B1wP3aQLnrzv3KQduCCU6?=
 =?us-ascii?Q?hNj7l+aAJB1jq/uWpRyu9Yml5oYxIvQFGLKEqxT6tcjE90TgkY9dlDt2hPQF?=
 =?us-ascii?Q?ResQDfWw9VGhslKOALbXP2F6LrUobYihsk1M183akISwCn3qw7Q9N9KEwTUL?=
 =?us-ascii?Q?lMUfOhunotCd0OY4tqXm+8vKB48U0Latsqq4augvSuQfs+d9ccHLrun2791a?=
 =?us-ascii?Q?zHiZ8FVOpjoY9YxsOJZULu8SCbWGSGy9gSL7HhMUul8Z40uXfJNrSlhn9tQJ?=
 =?us-ascii?Q?ks1MeBHeH0nRGi93sM1+cUZnWUSW2gEwOCQxJwST3iKgAR/y+g/O4yhtu1z5?=
 =?us-ascii?Q?mdz+x3cYWe6Dybr7js7S/SiHf2OQW7eoRhnZyPSq4rUbIcOGB5oisksveJHk?=
 =?us-ascii?Q?h7G/R7kPl7IcKzsLWi6NjW9lvE/Jo+1KGeu4xzL1Mc8gpciS4NWCtr/Xk7dA?=
 =?us-ascii?Q?o3lH0AGr313/YYYm/CjqC0IdJkRtKuo/UohntaAxULrogb+V3YYzc9OEwubD?=
 =?us-ascii?Q?FeLHsrHWVF7FDXN1aE/D9YudKREKAo2Qec6CZ6FtfOsZyVBM+niJn/k7uYZH?=
 =?us-ascii?Q?1lQikcXVh0sImW5rKLKaYm87juOT2w+5Zf4ou0E4ysNQJWQfqc0/v3sz0IhL?=
 =?us-ascii?Q?FuBbOqOSswWV3/mSnltDRPzF7oQLH9agDPIaXj+4zHBV9PXPK7FE65rFHyei?=
 =?us-ascii?Q?kwrC47oybhwuWH+gI8d60r/2DUJw9Ye4bmB94/ncedcdWtCmFIdUU9eRdsH5?=
 =?us-ascii?Q?kVZW5jAF7D4heyHLWzCVo65IWy2Q7z1VvD8T8+8C/sDfJFip/tv4tCszJyt1?=
 =?us-ascii?Q?gGQUjf1QaQfA2+LECCl1na4wyAzeceLaIip2CSh+bcJn+m3FAPlAHUiOS54H?=
 =?us-ascii?Q?YlQlaIsG6IPto3g9iOK5jT2bdOYWjr7QyM0wBnWAqUdRZzy1qEffj0ozF7xb?=
 =?us-ascii?Q?1gTsWPrROYoxibRM9lbmVC84LnMfdH2TR7a1tIvG5UPMvpbwyCl33WNjiziU?=
 =?us-ascii?Q?fzIOfUREaEUY7nKt2yoc4POzoM+wAeyO3ddDNpuhWoBp1RnUloFycqrMJ19X?=
 =?us-ascii?Q?ynDg+HxaueWTvrJMy23NhWHdFEBQNsoBbC1Ek/BExYFh/9mtsmSqEzKA4LH+?=
 =?us-ascii?Q?Tv5QotAa+ifnFo6itIxRgVu42Fiuf2o1gz7OEBSK9c7kPLJRMahHL6rDdnE2?=
 =?us-ascii?Q?OG4NJFlsVBMtOvgemrjlqyliACQF8z/uM+Jm1943Qc9u1gNUjrKVdPxIJ6rd?=
 =?us-ascii?Q?AeYn5QO6vodcmZ3EEeqYLwpqEExgmon9iikwNp9ZyBLBE6XyzkRdhmznudAE?=
 =?us-ascii?Q?FTTAm3pD7vfGR9mgMPmC+dOco3xl7obAFEU0mZjxGNJOYrZd?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1f8b82c-36b7-4716-8767-08df1e5d5a2c
X-MS-Exchange-CrossTenant-AuthSource: CHBPR12MB731189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 19:10:40.4622
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lh2inqU4sBzH9o02N6xh4NYIewPflQLRKTSJp/2uaE4/YSUkAWopUdqfOSC7SKlC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4202

On Tue, Sep 29, 2026 at 09:28:53PM +0530, Aneesh Kumar K.V wrote:
> Switching pdev->tsm to an RCU-protected pointer requires broader changes
> to the existing TSM code. To move this series forward, I will continue
> protecting it with pci_tsm_rwsem in the next revision, as that requires
> fewer changes. We can revisit an RCU conversion later if needed?

Sure, as long as we get the general big picture properties of no hot
unplug and a very simple lifecycle model

> With this approach, viommu_alloc() will do:
> 	struct tsm_dev *tsm_dev = NULL;
> 
> 
> 	tsm_dev = tsm_get_device(idev->dev);
> 	ops = tsm_dev ? tsm_viommu_get_ops(tsm_dev, idev->dev, cmd->type) : NULL;
> 	if (!ops) {
>                 tsm_dev = NULL;
> 		ops = iommu_dev->ops->get_viommu_ops(idev->dev, cmd->type);
>         }
> 
> 	viommu = (struct iommufd_viommu *)_iommufd_object_alloc_ucmd(
> 	viommu->tsm_dev = tsm_dev;
> 	tsm_dev = NULL;
> 
> 	rc = ops->viommu_init(viommu, idev->dev,....)
> 
> ....
> 	if (tsm_dev)
> 		tsm_put_device(tsm_dev);

This probably shouldn't be here? The way iommufd usually works is
these undos are alway here:

> void iommufd_viommu_destroy(struct iommufd_object *obj)
> {
> ..
> 	if (viommu->tsm_dev)
> 		tsm_put_device(viommu->tsm_dev);
> ...
> }


> struct tsm_dev *pci_tsm_get_device(struct pci_dev *pdev)
> {
> 	const struct pci_tsm_ops *ops;
> 	struct tsm_dev *tsm_dev;
> 
> 	guard(rwsem_read)(&pci_tsm_rwsem);
> 	if (!pdev->tsm)
> 		return NULL;
> 
> 	tsm_dev = pdev->tsm->tsm_dev;
> 
> 	ops = tsm_dev->pci_ops;
> 	if (!try_module_get(ops->owner)) // arm-cca-host
> 		return ERR_PTR(-ENODEV);
> 	if (!tsm_try_get(tsm_dev)) {

What/why is this tsm_try_get()? I wouldn't expect to see both
try_module_get() and tsm_try_get()?

> Are you suggesting setting suppress_bind_attrs = true for the
> arm-cca-host driver?

That or it blocks waiting on unbind.

No hot unplug of TSMs under active use. This is very hard to implement
correctly, and there is no use case.

> The driver model otherwise allows the driver to be unbound. 

Isn't this is a side effect of introducing smcc bus? We didn't used to
have actual drivers for this stuff that isn't physically hot
pluggable.

> We need to support tsm_unregister() in that
> case. I am also not sure whether there are other paths that can call
> tsm_unregister().  Currently, we register the cleanup callback via
>
> 	tsm_dev = tsm_register(&sdev->dev, &cca_link_pci_ops);
> 
> 	ret = devm_add_action_or_reset(&sdev->dev, cca_link_tsm_remove, tsm_dev);
> 	if (ret)

Yeah, since you have a driver it has to be structured like that, but
that doesn't mean we have to be forced into implementing full general
hot unplug across all of tsm.

Either block sysfs and use the module refcount, or hang in removal
until all the users naturally close (like vfio). Everything else is
too complicated to be justified..

Jason
