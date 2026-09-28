Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010057.outbound.protection.outlook.com [52.101.193.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF01375ADF;
	Mon, 28 Sep 2026 18:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790619633; cv=fail; b=BsreWoNuUttJ3bqugWz1Cd024u6wu3LLYLU3jdA298a3AL+aiLBkcmGXdbyYvQA+Ds5Tnr3aZ6NlpLobbGl5KnKEayJAZZnP5UtIVsb3CKu5nS+I9xtjRhuPKjOl/Magz9SZb14tB0iSMaarFFzIL/LcKghK0+yyRFj/6WaI4Vc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790619633; c=relaxed/simple;
	bh=I+/nvKHYmOSFaP8SE1LEngBWNiOJKFq064WnbV8jT58=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=edRwwv8Q7MR8SuqJERIS9SlkFf/mTMKszWdk1TtwDYihf+0aYSfbKUI0qvWV/txFF9OMtEWuvNyxyV7eoKRzqV2JALny0EDzePuD9fbzwxY4z01cOMFbmEK6tjUenF5ySjN7BTZsEykN4kHCaSun4LW7jrWHqGvMo/DsSAMT528=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aOuGssDf; arc=fail smtp.client-ip=52.101.193.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aOuGssDf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o3xK+pqXHYoEDtXtqnlZahk0WYp8D/SbaMGYXCvPlIvjuI2xFce6VnNT9mTxtav21GBXXJn0+dQHRjGmGlXyv1tzB/Rh+7X40doFxy/Ez07YxEznNtZBx7WiV85NGPavRpklDziPPE76Ii8DWc9ToM8ptsWhlclIQ456WnEyKT+yJo4zJMFYPy172QHDiDG6G6b86SUrwFh+RQXhOALd3tiwrG6YASHd6PUL0n7Hx/utdnFCxXzMACG+sdfQu9f/2GL1MBBrIkyIGE39vRISBHeFMBlHEsZrlKwumQX83XP7XtIZCw++rN5n0nIKiy2ZH+4XeX7s0GfyyxH9J+p8LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u0p2CpX6/crK/BZG67C8wEygLVcJ68lS9Jqh5RP2Jdc=;
 b=N0UdlSoPletjgrYzKSkVmiBqOprWVmlyuXndtJu1uVBwfi7b0J59VtPbSp+xKDGJnzxskJotQEGty25LhZcja8+KsGj+9SdSqUePrk/cr3yGeQqWMXC/V4GEmOK9biKscdyX55SMvr82nEye5glsN/T/XPLVfn/l7kYPKNIyOras+dziK3z0Iwu1h2a2fIXTQnO/sBQ8PZV889OzJcZjQp4m4cPD5KyjQd9pIGoJ4vee4rlqFzSwYH/KBmoJjUpsfiesekMtzB5xs6w98SbBfeCijD4t+1PdCgkwU/u+NjF1QsVs4PorH6wGxPeo6mRgVtAzlPkcpaI03i5LWKggyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u0p2CpX6/crK/BZG67C8wEygLVcJ68lS9Jqh5RP2Jdc=;
 b=aOuGssDfG2dViURM+j1b0Xuv4MaZu+WBZBef8xnyvEl3yaMqlbOiqdu7+OEL2jjbnsDR1D/hxeneuWyh8SfnoSwnLyarvJ8m2DlHDyWHfw/V6vlC9eA+JYEHYOsermDOrMstP31bNdVUArO+bF3erMrOHD3BK0NO2xx7k5qrUr03zlrW1xYpgzNqJ6olTi6P5t4/uS04o7WxsYxtjfRF31lBanyZ3f8+sdFr3RRSpS/3HvS1x8czGVM7MeavPnJ6DNBRwXFGOKiZ3B9mcEwsllr4hxmCtvfdAIo/sLkBuwNC0WJJ8xosUjaeRw6uBm2fsgY/Bl9xuNRiFuXF/BEikw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12) by CY8PR12MB7609.namprd12.prod.outlook.com
 (2603:10b6:930:99::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Mon, 28 Sep
 2026 18:20:24 +0000
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d]) by CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d%6]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 18:20:23 +0000
Date: Mon, 28 Sep 2026 15:20:22 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jacob Pan <jacob.pan@linux.microsoft.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	linux-coco@lists.linux.dev, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	Alexey Kardashevskiy <aik@amd.com>,
	Bjorn Helgaas <helgaas@kernel.org>, Joerg Roedel <joro@8bytes.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Kevin Tian <kevin.tian@intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Samuel Ortiz <sameo@rivosinc.com>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Will Deacon <will@kernel.org>, Xu Yilun <yilun.xu@linux.intel.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH v6 05/11] iommu: Add a helper to validate a vIOMMU
 parent
Message-ID: <20260928182022.GD1616761@nvidia.com>
References: <20260917140159.1163281-1-aneesh.kumar@kernel.org>
 <20260917140159.1163281-6-aneesh.kumar@kernel.org>
 <179027891416.104879.10365675178574704349.b4-review@b4>
 <yq5ald8pkhj7.fsf@kernel.org>
 <20260925122305.GG9354@nvidia.com>
 <yq5a5wzpr7b9.fsf@kernel.org>
 <20260928121147.GP9354@nvidia.com>
 <yq5azex1peqt.fsf@kernel.org>
 <20260928161738.GB1616761@nvidia.com>
 <20260928110854.00003ff0@linux.microsoft.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260928110854.00003ff0@linux.microsoft.com>
X-ClientProxiedBy: SJ0PR13CA0112.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::27) To CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CHBPR12MB731189:EE_|CY8PR12MB7609:EE_
X-MS-Office365-Filtering-Correlation-Id: d6327c65-c49f-4b95-d960-08df1d8d29c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|7416014|376014|10067099003|11063799006|56012099006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	SwpLFt2yWrbQ4nzHInr99gnelrxbCX+1UFJ2yO2K6HD/XaeS6lpTV+wBrBv+xdIi+T5vKTeSBFnVusoix1cEJ18tljgzHORTUWByDghbTPpymH2VEo9LO29WAR8FTS7Lwlgixa07pI6CuiUVc1vUgsHKmjhDX5C620vFWPYFtA+prRbhJQdyd3sKjhGfISpIVf+CdxEVhZ+xVH2D/zDMjF4KzeuxV3LTo/FnkvMAV7w14V503LDO8miVLIMA4oKQdHdK2k9mOED023wsfw6BvhOC86aX/pR+IowP5CRfrJri3WgBPoRD95gHSX8Y3sd9QEHBxdwt4Stav2k//silDjVwK50L8FRqoLNBFFw364exdoIsUluIIkkr1g3U8NFG1+G0vcbcYORIP/1nTViKIk7PeFbjTMJJXh+0n7YYKkbPMH4ssneh8RG0Nx8n31Ggm56UBkwtIq+qCpT5Btz+dndzfQ+OphHh+WwZfuqQ0AWRtAx0A+Ukjv6nn+WeNpSVLcXYCh6ZhWocMA1LvYL/NyGi3RSUTnBAOHlJWORggyAKCKKvwXEJKHf4GmZ0ZKZtj2fxkeco253LC4MwgjIZhTQ8XOy21eYHceaNAZqrztMBg0QDtA7uBX0cQz8mweesXTRq7yjURiYt0BADRtPz9W6mMdAvSA5fIKsFEYZ2Nyg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHBPR12MB731189.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(7416014)(376014)(10067099003)(11063799006)(56012099006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HJeFgGK4WG1wmDbkMzgKMgNHiyJeQzu69zpNo42zz24lLMuCZwfIZAzq2vNg?=
 =?us-ascii?Q?nQf3evlreucE171xk+iEqstTTboT+8z7uVoRSvbO2dcV4IvA7dzv0H0N96nx?=
 =?us-ascii?Q?KTY+1LJbpFtg+qJ0zixVEwYw+xKOFqA+Don8xaxPWiY+G0b40a9dekd/L4uz?=
 =?us-ascii?Q?ScC5J3L+/ySTKqTWIIRSh7Q0EWoBiObCl/oiz7LHI+OXvif1LUIA5IC8UmJO?=
 =?us-ascii?Q?6tmY8QTQx58mZN26OtWNtvVVPKOhHGyJ/dEkDe9uTDV99M4+wc4YS66ynnAH?=
 =?us-ascii?Q?YNdpfK3j3FyF85b083jUBlgngVQ3JqkKxjzGBIQJ4eFmDJF4YbQkIg+GsfVY?=
 =?us-ascii?Q?Klc81YCzafmxLyT9FzvkYXGEVFWycA9UFk1zQtvz6StSLVBwAmcI0LIcXK5V?=
 =?us-ascii?Q?qJu21EagU1CJvI5lDmB17ocUdG46bSw3TCO5vMa5gG40arKmcIGxTUD8nvFE?=
 =?us-ascii?Q?XBh2o9rmZb982I1K7eCc0aaaOLrLphrnv+gALZSn0cbPix870Z58nGF1Sf7W?=
 =?us-ascii?Q?nE8ZL/LcIBaELQkbXx2NYpfBYsYwrtdMnFUv22vpcMZwFnZ/j/Ui6BjCysXM?=
 =?us-ascii?Q?D3qNNURvlbml0Kabbm/jK9aM8UCa71wf/UAn3m9q+hru0H9Ze4fKMsZuS57N?=
 =?us-ascii?Q?jt/UfOKlLm8ZekmeF+rd1BAGnDl3845W1Blw+udH/lze8Ii1oWpNS1edLWmL?=
 =?us-ascii?Q?zcUh2k6N/WcXvzrb1AlfCNJywyLHgiXlKG1Fnm7GtAZSJCvGorXi1oSOCNx+?=
 =?us-ascii?Q?B65bOz1AqYPf+vvmLzLZMYW8S+/ixanFhVdAePliCUwuEWW2qh/DwA8JagpB?=
 =?us-ascii?Q?gJv9ZI3m9grTmeKx6e7QmIRbo/9hz+6bbQvV4UfhueWrKMhRx+ZSZR9FHYAp?=
 =?us-ascii?Q?hFFgrcMRzYdII4fDXkj0ixlc8w1Zkm9R6C+y+yhlgLOcWktrDMfWxuY/uKVO?=
 =?us-ascii?Q?NVb9kuF285UbkIH9VsOgWLhedi5E8JelGTnww5wAl7fYYyo5PFc40PGkGs5N?=
 =?us-ascii?Q?hp0nnGRVetmvro9FR5WEkBlMO5VGP+gjVGaSSOLv0U80lb5qB6XncjoUggW3?=
 =?us-ascii?Q?rYiltg4zYyf6+d1B4qGkdtUKrWSwq2+aJn1T9jDRZftXXJ3OJKN1180BVXkY?=
 =?us-ascii?Q?2cSxV7wfYD6Z80lEkJ8bTXpFwuq8al2ZZ9SWb62EmCLrtPoVa2psjUsFB31s?=
 =?us-ascii?Q?wLKuQXswCgS4gx3DwLjG5Y1U/ik9yqhyDTJK64Y2aPc36JISfPsN01/vx3Ea?=
 =?us-ascii?Q?8Ftfrviho2gjbevvMDCqo1cNnWcRR1/2qh00+XTdgiaKaPA/Y70JifKTRp7Y?=
 =?us-ascii?Q?3syLwkdHXsqY6m4zrXNApMtea9yRxlm5nB2UfcvXtTXvlxjqTpVrSiDW0iBE?=
 =?us-ascii?Q?aEiQ8BE/WhzRdJwnVqKhvmY+Giqm32Wk7IPF8tZttP9wYS2pqkHGT6EOdABD?=
 =?us-ascii?Q?aiggijbAxmQnyvbQyYQzZcqKkNJ7tiFWx1Jq8OXGPQTUUzZJj2M0eRG9mplc?=
 =?us-ascii?Q?obM8nsCYHHe4HvH6XqWs9+LcQwHpw2Tm9XBukaB/hZ7Va2DS0s/iQ3KoTnaq?=
 =?us-ascii?Q?HK7Bjck8zQkShyFf4sMqz8hp4YcPXrcNBQGIr2r4FGuKTxOXRUBU6iaLLCnw?=
 =?us-ascii?Q?Co+1baR4e7MMig5nVkuSfvxyGk9w47vGQd4MTN/YRJfSb45aAVCB8zCXlt3n?=
 =?us-ascii?Q?Dv4wS1Q6uUiKb8gbA58GewJZ1jIk2rq1+J7PGF+XixWdYMJ6?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6327c65-c49f-4b95-d960-08df1d8d29c3
X-MS-Exchange-CrossTenant-AuthSource: CHBPR12MB731189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 18:20:23.8983
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wh1F5KSHjwFbr0Y/wwFuuzLmxm1XJpddZfi8RFH6a+XkUkvMiPT3vX5Hu5a4NbOw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7609

On Mon, Sep 28, 2026 at 11:08:54AM -0700, Jacob Pan wrote:
> Hi Jason,
> 
> On Mon, 28 Sep 2026 13:17:38 -0300
> Jason Gunthorpe <jgg@nvidia.com> wrote:
> 
> > On Mon, Sep 28, 2026 at 09:09:06PM +0530, Aneesh Kumar K.V wrote:
> > 
> > > Does that mean the SMMU driver will return viommu_ops before
> > > iommu_ops->viommu_init() is called? If so, should viommu_init() be
> > > moved into viommu_ops?  
> > 
> > That's probably the cleanest arrangement, yeah. Then the TSM ops are
> > just the same 'get_viommu_ops' call under TSM and it is easy to put in
> > a flag 'must have null hwpt' that goes at the right point.
> > 
> This should also work for the parentless hypervisor vIOMMU in my RFC:
> https://lore.kernel.org/linux-iommu/20260925190742.1575380-1-jacob.pan@linux.microsoft.com/T/#t

Yes! That case is very similar, the hypervisor under Linux is a close
cousin to RMM/TDX.

> I will give below a try, I currently have below (can be avoided if
> get_viommu_ops() can simply return NULL for the hypervisor type):

The amd_iommufd_get_viommu_ops() must only permit its own type, but
AMD doesn't have a type right now because they are merging their
patches bit by bit..

ARM already returns NULL:

> > +const struct iommufd_viommu_ops *
> > +arm_smmu_get_viommu_ops(struct device *dev, enum iommu_viommu_type
> > viommu_type) {
> >  	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
> >  	struct arm_smmu_device *smmu = master->smmu;
> >  
> >  	if (!(smmu->features & ARM_SMMU_FEAT_NESTING))
> > +		return NULL;

Though I wonder why would you check for IOMMU_VIOMMU_TYPE_HYPERVISOR
in the amd driver?

Maybe hyperv should be a TSM?  Maybe we should also route the
get_viommu through the the "kvm" fd somehow?

Jason
