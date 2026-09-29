Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012062.outbound.protection.outlook.com [52.101.48.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4551F50E5B0;
	Tue, 29 Sep 2026 13:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790687216; cv=fail; b=Wt0KYKOc/NzrzG8a/Lra3nzK90Yth6cftCbU8AZnS9mGvYb7sgwLJCNmkQQYMlw/bk97slqP1QnCXLJp6U6tdp5cw0+ceuxtiA2gpkG8Opi1jngOt0CfwjImyr7Y+LTIbYw0YLqVgMiOYXxv1GMUFlH2fS/KMpYNEJXUCcF1OU0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790687216; c=relaxed/simple;
	bh=TXeDympNQjTZNHnJ7h3UVTJKmSMikAnqdwOavCuGDe8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=W+6ScdGNgyO+0UGczesWyDIC45PDKcyNUZD/APHD0ToTy7XQ0o9d/GI0Xzb4+SFc+a3Km4BNytabj8V69lvMbVmdux4cn+9qYNN17Mqek6OEccGJj4vBaO1fkDKLcAQ6ben1WnPaEtypEhjmUE8flXXopETbguUCOSL0mD3fQlc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=h2FPLH8/; arc=fail smtp.client-ip=52.101.48.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="h2FPLH8/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aixYaLV6mcGkT5ztVBF0/lOINZxV+UIDoCRZesPjVED7EFyuqAjGXxdpT82v1bTrbnRC3DD0SwmXQiOuSfHB9kiz1xOxb+s8MqukBNztkvOIW1YcPH7r0v64M7kXf9479NVzvtmIJC4+PH+nOONyFfdLoICECeQq3+Sz8BsboIDFkkcG3qZwM4bahR1iIa7eIqR7kk2BD0CSUMpeuOZtGqm8c1Y9YzRNK4rprH+I8jS6Zp3rpWFnH3MJL9lBRpQJj/ArYMpDuS7Fa1SuZeDF+i2FPw4kZQNjH4L0Wn1rc5bWlqLuT8ujdcWb9s07/2+1/wl0NIm0dbJKxQSM2EPPJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G04UasHxc0ROenVMtmy5sD4YuDN7AdK9YKNkcdL81ko=;
 b=KKAZ37k0OyFYX0SM3ky5QYZuXGxd0MBs14f1PRka510OCVGVaUEa1Xigl55UH30AZ60mIk963qjfklomWZjQJWml+gSCtC8nJUYaJcqDAwxfR8WpswP92GCrKiFZMzYqgavtUkKS7EUzInAWj05LNjPXECXeuknAAG9Zz+xpRDTahl/1Qn0eiNTGvMO6nLp3r2Uv+BDhK3RVAG9wTqvv6ATsz0wjdU7DE36LIBs0AufdUwK/xDJcgwdLeQJtYi1HNBP3yYMXFvEz621QitYwHZ4ELwX4vxkgtFLuaqM4iC7mnMu2d9kMxcSAYi1IA0vxMO1ONHaRWsQOLIxMrMJQEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G04UasHxc0ROenVMtmy5sD4YuDN7AdK9YKNkcdL81ko=;
 b=h2FPLH8/C1Da3OYJfS3+S4G8JZOn42O08dED6PJ9VHyYF0GWePZAPrQqXZx3pCE4CPniTe+XM+ciPNRIZaoU1ktxB0E5iz1xf1FXsyXcVZe6PeV5jf3bebiRuZR0NyelV44hY8XthCM1BdLL+D9gIpEkvdDC6zOmaH/0luX2n0vPWUDDJuZY6/mrNacsmBtx9wvQHcd1Gz9zCi3XqKCjACE73C1+Z52EDThluyeqh9TZZl64C0YT95z08zPH0opuUSZglAgGyrAQ6qlOiurMRyj0QeogK1cDGPOL7uBgHmReFIpuCwOXxwVKZZCC3B5fBdXMwYTopfV4HnOGeBzsSw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12) by SA1PR12MB6847.namprd12.prod.outlook.com
 (2603:10b6:806:25e::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Tue, 29 Sep
 2026 13:06:46 +0000
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d]) by CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d%6]) with mapi id 15.21.0451.024; Tue, 29 Sep 2026
 13:06:44 +0000
Date: Tue, 29 Sep 2026 10:06:43 -0300
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
Message-ID: <20260929130643.GL1616761@nvidia.com>
References: <20260917140159.1163281-1-aneesh.kumar@kernel.org>
 <20260917140159.1163281-9-aneesh.kumar@kernel.org>
 <179027891417.104879.5995584402952067518.b4-review@b4>
 <yq5acxu1kgmo.fsf@kernel.org>
 <20260925123918.GI9354@nvidia.com>
 <CO1PR11MB483580AB119687B7EC2DD8518C8D2@CO1PR11MB4835.namprd11.prod.outlook.com>
 <yq5atsn8posb.fsf@kernel.org>
 <20260929121723.GI1616761@nvidia.com>
 <yq5aqzicp6oc.fsf@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq5aqzicp6oc.fsf@kernel.org>
X-ClientProxiedBy: SA1P222CA0101.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:35e::9) To CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CHBPR12MB731189:EE_|SA1PR12MB6847:EE_
X-MS-Office365-Filtering-Correlation-Id: ccd92db2-bbfa-4c2e-2c7e-08df1e2a831e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|23010399003|376014|1800799024|6133799003|18002099003|22082099003|10067099003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info:
	Nzv/MLC3RisVjtX+EPRfNqAfUnlZqERTPzvKHFaqkMS+dv7yQatb1m0zFRYV/svwvfDir3aTbgny22rq8u2pwAzkoDPsT0ppMs+RiLlGty7W+pKcAnMj+/sUsLoYElr+oWGQTfkHyIjR46Umh/c132nZ/Wuact9dGGJMWX61Ms5LloLQRZmrc/LM05AJnIJaKxHfr9Cu5YqIVNqkNzwdJk1y0S245YjXa/D94cbeVNWNxGKZZOreurX//foNoonsAxv2bF5y268FNv2EJUqopmQ/nuXzpbx3JQXB/2/ET3k4pFLV3TLwrfVHmouC/ukdfl7BKME6AswGxiXn6l3xIcW3oCBM+9fCKBXBwiNj6XrxA32fGOzggJS8MrbaFt1kPG3ZqGzQ3HFLWZWjDhgDrTNxyuNjKkSr1wJ09WWX0C8qeBtmLooCDvwNHhf15w382wKAoD5b1Msd22/TE4syCDWOsUbsf0Inn3TJ+wRWAMY+gm4eU9JMNHYQxInMRFZYZupc2hOH0JxZmhZSeSoBLdijIG8CpoRyd9peU7BdRm1NcePNl8jbIlR9mdPUTjB5tI0DfxZ2n8Of9k0U8Aim8xF5VmusxiIkWtMppmN9XWix14LTTnm9nAYx1Vby9ecsnqmA4b6xsRI+j0gDuvQdb6sohKlYAXYFQ9eYrEMySSs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHBPR12MB731189.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(23010399003)(376014)(1800799024)(6133799003)(18002099003)(22082099003)(10067099003)(56012099006)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vjE1SNvTShosyyq+3ipHb5raMOH5oZ34gVNlr7TC+QGsxlyJUO1crrO9R8n1?=
 =?us-ascii?Q?bQ2/5fCqj7hQDyzT/rcTtmeTRlSpc/FwdjF7e5qXeWnjlADNrGNjyVv3uKN6?=
 =?us-ascii?Q?tE62iLJ3q5JtFVKc2LAl3lElV0PuKxkEiIiKoFjGKZU7hR/bZ3pvBUfOHNec?=
 =?us-ascii?Q?v38QTQgsLlqXKmU/PQ/k1FGuaPN1Nfh5I5E2Wta/CFNmx7Lfy+U8fa55UrKL?=
 =?us-ascii?Q?OoRcANvCp5REINaYpwq8vsg9x79fXwR49qKsr/HNmyI2QtS6xloSc35Gjlk9?=
 =?us-ascii?Q?8+snNaJ6prI6HgSvzOdCyuIfXzdTuzTwtCgxeARYCB0J8SSmRl+P6nezWvmq?=
 =?us-ascii?Q?Fdn6DDkKaLzqXhwYeWz2Pp0stGmL5dCCxN/m2vMiYDlmGqfzvf2dHEwUPwGw?=
 =?us-ascii?Q?GBx5GTSN5wtIJ4lCgCoLciAlb4QVH1dXcZd0R07SZfkDYNaSBfCSzXF4QKlJ?=
 =?us-ascii?Q?fcPCoh3bH28X/glC38qhGGj2OXyTHtqd1zGF10vCkOfm5ujpNee+8xK5uHN7?=
 =?us-ascii?Q?Elh++M1r+z1R4SdOjfMJQu9V+zQP2qtxjsF1qGFmCpYWDZiQf99tXE2i29o2?=
 =?us-ascii?Q?VemsaaCWeswePjp2wDxK7SZqEvIIklHIsHaVAUHGTmfdwvS/Q61G008rqBY3?=
 =?us-ascii?Q?j93eU3eNGWtlOU3B9nGHyECPpkoloq5DZwm5EaJzoSWLGAPk4rK/Sjh7P23G?=
 =?us-ascii?Q?8qAEMj63G6QJkyFShTqMUFpRZjQmpUtFmvVLRck0AuhLROrrlQGSgsBaHqrW?=
 =?us-ascii?Q?1qh8kIvK9tVqha5JZtmGDSdwx7debLzhaC9oK/djw9Nby21s0pCT+6BMGiUE?=
 =?us-ascii?Q?keOuHxToa5KA5vAHAqRisgAaUiiksdFNlDd0ZxaCfTRhyx/JdGSVKyDqfBWV?=
 =?us-ascii?Q?wUQxvnMsYMliSOT+miMFwnZ8ec9ff6nvJsNBWIBlsKqfmnFsL/cG5jPY58ae?=
 =?us-ascii?Q?zJuxicIQMqj+FL//prCjRsSgqZ5/qZlBIokEx0w7gBNRLRbkHpPagYT1QB9+?=
 =?us-ascii?Q?3Y9jjWxcxdPWg31hew4imYznNd2pbdu5DhY02K0YYaS1gpU1tfhIWpC3QkSY?=
 =?us-ascii?Q?TmvrY7gvi3xFYAJMOV6+wU20T67exZZ6QtrhD47ROpWWFB+bDljKjZFYyyq+?=
 =?us-ascii?Q?6LjInbMvM7OLVDiBSSQSi3dDhtEwtC0xXx5vRl12jCss4gEipPI240KVbm7U?=
 =?us-ascii?Q?5RDPZTAR84P2Iv3kIgXWY+W/iLnWU1twa9gxGyGOAzsMM3l03oOQw3UK5xEA?=
 =?us-ascii?Q?JY/+oOjBoZ6QlT8XWm+stJGNxzM43S2fY+S0FmtuFxAHeq7HimYuuCIwy2g4?=
 =?us-ascii?Q?P9eIBIvUVTwWvTaiEg89Zm4ROknfHPTjzxzDLMykaE13JAEQkD+wIkozqPAw?=
 =?us-ascii?Q?askJhck/HzXHcuxjgDN/Yi1EJ0lqk0VMF3soqkKLc9bRy48grm/co0GMuXlJ?=
 =?us-ascii?Q?gijmYQlbE9zESUcegXxflrZJsUaCRG/+bDb2xY+Otj+IdDJtiB0bcOno+jX3?=
 =?us-ascii?Q?8e2vQceISAcf93fyYGjziteDjFvm1Qtn9E8AgG1vjtAsGeyKmWKUfINRVnE3?=
 =?us-ascii?Q?uEORhZD1C+f4AJeZqdz5qgN5J0vtt5jTpiPYmtHD4u9tcDxW+kk20ionRDsl?=
 =?us-ascii?Q?thRttd7fSxVZNizMFGPd+C9MgSlVeR3/grpUXTLHa5VK9cZd0irSuILdHY/B?=
 =?us-ascii?Q?Rmtl4dcg2d1Qf4zqC4DLbCd/dTYJFaQBhpJoeB9gL9CVPUzl?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccd92db2-bbfa-4c2e-2c7e-08df1e2a831e
X-MS-Exchange-CrossTenant-AuthSource: CHBPR12MB731189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 13:06:44.8061
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2qRooxJD2GgSWfphmAEkdLVKULA3tHxrJwaIqu3upEDGVV6IDnwrMLukN2GUMZQn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6847

On Tue, Sep 29, 2026 at 06:15:39PM +0530, Aneesh Kumar K.V wrote:
> Jason Gunthorpe <jgg@nvidia.com> writes:
> 
> > On Tue, Sep 29, 2026 at 11:44:28AM +0530, Aneesh Kumar K.V wrote:
> >
> >> tsm_viommu_get_ops() runs with pci_tsm_rwsem held for read and takes a
> >> temporary reference on the backend module (the CCA module). This keeps
> >> the selected ops callable until vIOMMU initialization completes. iommufd
> >> then drops the reference. This does not pin a particular TSM
> >> registration or prevent tsm_unregister().
> >
> > That seems over complicated. Maybe we can't get to the sane locking I
> > suggested earlier where TSM module is stable while a driver is bound,
> > but we absolutely must have sane locking where we can "pin" the tsm
> > for a pdev and it cannot be unregistered for long periods of time,
> > such as while a viommu/vdev exists.
> >
> > That period should start right before getting the ops and continue to
> > until the viommu is destroyed.
> >
> > No hot unplug of tsm modules while things are active.
> >
> 
> 
> That is essentially how it works. I decided to take the module reference
> here and the tsm_dev reference in viommu_init() to keep the rest of
> viommu_alloc() cleaner. That is, we have:
> 
> 	struct module *owner = NULL;
> 
> 	ops = tsm_viommu_get_ops(idev->dev, cmd->type, &owner);
> 
> 	if (!ops) {
> 		ops = iommu_dev->ops->get_viommu_ops(idev->dev, cmd->type);
>                 
> 	rc = ops->viommu_init(viommu, idev->dev,
> 	if (rc)
> 		goto out_put_hwpt;
> 
> out_put_idev:
> 	module_put(owner);

if we have a get_ops we need a put_ops()..

> The tsm_dev and module details are needed only by tsm_viommu, not by a
> generic SMMU driver. For viommu_init() to take ownership of the resources
> acquired by get_ops(), I would either need to add a viommu_info argument
> to viommu_init(), affecting all IOMMU driver implementations, or make the
> error handling conditional and awkward.

Just don't, iommufd can hold the tsm ops if it knows it created the
viommu through tsm.


> >> CCA vIOMMU initialization takes a tsm_dev reference, keeping the TSM
> >> object and its PCI/TSM resources alive until the vIOMMU is
> >> destroyed.
> >
> > iommufd should do this, so long as the viommu object exists the tsm
> > for it exists. It should not be inside tsm drivers.
> >
> 
> That would expose more TSM details to iommufd. The reference must also
> be acquired under pci_tsm_rwsem.

That seems like overkill.

> /* Pin the current TSM and revalidate the selected vIOMMU operations. */
> struct tsm_dev * pci_tsm_viommu_get_tsm_dev(struct pci_dev *pdev,
> 		enum iommu_viommu_type type,
> 		const struct iommufd_viommu_ops *expected_ops)
> {
> 	const struct pci_tsm_ops *ops;
> 	const struct iommufd_viommu_ops *viommu_ops;
> 	struct tsm_dev *tsm_dev;
> 	int ret = -ENODEV;
> 
> 	{
> 		guard(rwsem_read)(&pci_tsm_rwsem);
> 		if (!pdev->tsm)
> 			return ERR_PTR(-ENODEV);
> 		if (pdev->tsm->tsm_dev->unregistering)
> 			return ERR_PTR(-ENODEV);
> 		ops = to_pci_tsm_ops(pdev->tsm);
> 		if (!ops->viommu_get_ops)
> 			return ERR_PTR(-ENODEV);
> 		tsm_dev = pdev->tsm->tsm_dev;
> 		/* Unlike get_device(), this also keeps PCI/TSM resources active. */
> 		if (!tsm_try_get(tsm_dev))
> 			return ERR_PTR(-ENODEV);

This is way too complicated for what should be a very simple scheme :(

rcu_read_lock()
tsm = rcu_derference(pdev->tsm);
if (!tsm)
   return NULL;
/* Prevent the module from unloading which must be the only way to
   trigger unregister */
if (!try_module_get(tsm->ops->module))
   return NULL;
rcu_read_unlock()

And this should be exposed to iommufd..

viommu_create:
 tsm = tsm_get_device(pdev)
 tsm_get_viommu_ops(tsm,...)
 [..]

viommu_destroy:
  tsm_put_device(tsm)

No lock, no registering FSM, just RCU free the pdev->tsm memory and do
that module unload rcu synchronize during module unload. No hand of of
the lifecylce to other layers.

Hold the module get in iommufd inside the iommufd viommu object.

It is simple and easy to understand.

> 		viommu_ops = ops->viommu_get_ops(&pdev->dev, type);
> 		if (viommu_ops == expected_ops)
> 			return tsm_dev;
> 		if (IS_ERR(viommu_ops))
> 			ret = PTR_ERR(viommu_ops);
> 	}


This should just be try_module_get and a touch of RCU.

> > ideally the module refcount handles this and the only way to trigger a
> > tsm remove is through module unload, with no sysfs path?
> 
> I agree. The existing code takes extra care to allow tsm_unregister().
> However, if unloading arm-cca-host.ko is the only way to trigger
> unregistration, as it currently is, we can avoid this complexity.

I've been badly traumitized by hot unplug races, bugs and deadlock,
let's not introduce anything like this here, there is no need.

Jason
