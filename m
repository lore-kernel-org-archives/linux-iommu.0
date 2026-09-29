Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012022.outbound.protection.outlook.com [52.101.48.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7A43DA7C0;
	Tue, 29 Sep 2026 23:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790724616; cv=fail; b=NlKsrn+DMWLkl1sRO2O36X1PaMrolLdrB+tGikPIaIR/n9roRyKpwWR+OwlAGP8kO/xhXAeAKo1WxE9h4qfAzTng6KNcFPY/di/1PRY2kVNpk6e09hChQ87LzzKu9/1YzBdO2c+EVoxWscyAI7G9W2vAUhzuCnf0zdeJ+lAbIOY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790724616; c=relaxed/simple;
	bh=GY1o/keNep6k9v04VmCttJqMxxBoJVtbPdyxuGzXWos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Lmu8L0MDGmJVf18Oz8Fi2MA94O2fLFC6FAxje1idwgvCLMr3EuvfauBR8p+FJws9tYNl/srPczc/EZQ/EvHSTrjQkCyEFak/K32aUPxpNMmKQD8kmTDSyaMVgB0v3KnHqLE0ougH7ersXRC9Z8yQzqHwqkCD+Cvhxr+SgKw0pL4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=izDRdKsf; arc=fail smtp.client-ip=52.101.48.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="izDRdKsf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tEnsbZhPJbRNT+bsQdvTLgs5rhh7B1CDwD+OkfSV0JDvHVERlOLRoKcTUnHN0OPuxhPqwPsgEMdEb47Ijvg03uDdTr7y2U091BX7jV3ivFLcyqAQsVBiC1vN15iH7759Xc0+nC32rABx7bRE7O5ji1jIpSr8byHThX7vu6XttGtfvWPo3b7K6RTszBjZOWCHrjSjVQGpxVEu9EQwLunMmpJxC2sPccUhekxYLb8DdhKfmMwZIGgLlBBi89CdGwogTpGfqN3E07T8WOP2X/+KEwFcVr/WdC2Kz4YWb6BYyKi9ZYL++lOzMnQR/14EwqopPbHP25fMeuB5AT1fFz6bqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i83W+6kmNX1FMaqGUTEZZxF7o9EaGe0hOYvXZycjXv4=;
 b=gUAzQDdyAo4/PAteAOAVu1sASGcOheEOdja01xzl9D879Bkxw60lH4JokPn9ST6e/rGXL+26Y3upXo46TDK0mQ7XOHhloT4T/r9EvVituuO3+NL9QnP+63Sy1Q3UOpBdKyTK9ZqPAGLfdfqSHGnSWobDfwYyhG1UOfo+ovDcQ4RVmtIqVQa3OvLa2gI46pitavq20ShWtceraDW96u9u1u2iXK9kkxeWq2oHPtuIgdVTwLxDGui54Mqog8zFmFVVuBzHSMNBw9hSFxrDv8hSmhcvPHEx681biAHeGlFeeZv6vq5dIaNl0Te4odejc7dbHRCTQDB4zCujm0FyDymR8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i83W+6kmNX1FMaqGUTEZZxF7o9EaGe0hOYvXZycjXv4=;
 b=izDRdKsfYXxIg2kPVW+Ssy2jU9VJvT0mvauh5DtyvwQfE5HZn09lK23mepsUQwRH2J5RCiNA+sw3sLYnR+bwYLwXT770+jtCGsqsFQ5IkSXro/zvJOQE9fbKVhF08J+dh91BRlYfmkk0sqSQhXe9Npd/Dl4/CUbxu88gijelXW8U3mAR82tjNlRW60uE+cUv1l0pHDB1lhOzMEkwoVYLNbyxAHskP/mnXu9SwtNCJYYAYHopQY3GYnCyfN0yPgFG3QvoPfEb4dG18W4qwpgSDMOH3L7FirCmHjFb0BGXwzZOD9dhIHIVAm5hu00kCpn52hLyOFFLs6lyLyeRKdOrcQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12) by SN7PR12MB7812.namprd12.prod.outlook.com
 (2603:10b6:806:329::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Tue, 29 Sep
 2026 23:30:04 +0000
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d]) by CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d%6]) with mapi id 15.21.0451.024; Tue, 29 Sep 2026
 23:30:04 +0000
Date: Tue, 29 Sep 2026 20:30:02 -0300
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
Message-ID: <20260929233002.GQ1616761@nvidia.com>
References: <20260928121147.GP9354@nvidia.com>
 <yq5azex1peqt.fsf@kernel.org>
 <20260928161738.GB1616761@nvidia.com>
 <20260928110854.00003ff0@linux.microsoft.com>
 <20260928182022.GD1616761@nvidia.com>
 <20260928152402.000079ce@linux.microsoft.com>
 <20260928230328.GE1616761@nvidia.com>
 <20260928225524.00002b85@linux.microsoft.com>
 <20260929123048.GJ1616761@nvidia.com>
 <20260929161527.00001275@linux.microsoft.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260929161527.00001275@linux.microsoft.com>
X-ClientProxiedBy: BY3PR05CA0047.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::22) To CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CHBPR12MB731189:EE_|SN7PR12MB7812:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f10067c-1736-42a4-0df4-08df1e81972a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|7416014|10067099003|11063799006|56012099006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	JbpU6/mr7XA2t3aWaUMACKMf0KirqnyXBC1q8WttQHO/fy9jgJF2WIwtSMKC6XGmCa9/3+jTA0tL+lbqUUCkX/PZRw0Go/qq6Ltd8PaS/UUm2zruR3Te5AX79RY0j4kVrwnTn0M9EHlZhIqseDRNO3FAk0IiAQG0KGDukRBKkU+L848vRRLLDdI0zX9JD+W2fqpnTW3MCKuaBQaPWNEsEMid0zJpgvFQtmNZ6oKYvvePwnMgML1BfjOMd2EuLPSOKXkHUY8OuFL88UQICE4uwb5/45D0OSpCBuU1Xd9vFxvSwGoEGWZx4lAIWlIdhnQ5Ehv/CGB7EP7FxfRv08FqJnLAowTk8bXx3/t6TOFIDyXBuyfDlyPUhosr/MrnYHby4RwzxQPtD+O0PI4Sh1nb/YCa7mOKZzlkIKVgTYfR2xPoBTzt1/c4Yp3b4mZwn/yESNeTM/f2FAh9G5vN62/2CwZn0JZk6F05qNd57Ce0FOhaV7Roh34swu3cesiqKi5A2HJ8r/fRVymiwLIuu8s8zhi+lLtjBTenMUXXYKsg+Nvl/uJG02431WEQnwi9jrQ+ZdlVPuyW1Y7ics1EVh/NLD+596eXbNrzNIFIYq7XtaDlyxfNnQzJ+XwFk7paGAvmhz0ZjEO7ICHZ5BZhPabCLyo6sIj0RhpSdNSp3d3bz4k=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHBPR12MB731189.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(7416014)(10067099003)(11063799006)(56012099006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qSd7jU19TFgHeOf7Cl4aTLlEQv5HdEcTIYOtdRVbI/eb0FTK3UzLam3PKVR4?=
 =?us-ascii?Q?xOr6axzrYBK4SBjRbNxfeA06ktGkbVoTFb5hoWboa+TEkjxHcKAwxj/JleZB?=
 =?us-ascii?Q?zO0RPkDH03lsZY4ObJ2f3zziw5WJGVXQNq/dLEbiSp4DhXA9cbnwgAbS0RwR?=
 =?us-ascii?Q?vFeUmUtjk2A3/HTi1Suj8vafVw+ycnZGFvzJQpsdDNtoowzh3zpdCOpb+36Z?=
 =?us-ascii?Q?87ME7uSxkMvNzG+D6InmoO5QVxfwGgEYjorcxG+NTORSUPn91h2LeWZwU065?=
 =?us-ascii?Q?lZKuMvTL1iBzT5ROjleY35xhb3BHRWI+Bv+bHR1n0wqjPZ0FWeLfrMoQNsn9?=
 =?us-ascii?Q?A99t8qYLmkLqq0xcvp5Hq6Lqe2fzc/pavXDWPkk1LVJkMaQa0ZXFWRgFz5AN?=
 =?us-ascii?Q?uXuPhuJCS7Xza+jMGXek3s5Q5JMS/pJ9R1foa1Fgi4kFTRpQGGRQJMeoQOtC?=
 =?us-ascii?Q?h86tVnBdlvfM3Ng7/b0miFq0Cu95Aq7z+UrozSheL0Rb08Ot/0E2GmVqZPYl?=
 =?us-ascii?Q?9n6Vw5wjSKXeSPABHprmPpSDYUulW8Ue54yG3rY5Vjm+wEfMD5VTUZqXph4N?=
 =?us-ascii?Q?aCDaa79Jm7OIgPDnAEn9po/TfNqR1A5RzqqjFgaiVSYMWxp81ftTvkBy/Pzu?=
 =?us-ascii?Q?w7qic3on/frzb0NGYXdfUoyiDUYc06n0jU9zJfZhLjiZEjltCD6s4FvNExXn?=
 =?us-ascii?Q?qmz/DdnZjyG5JUEuorxNorpB4o2CxJMsbqe7E0tGTJL5UJZIatfOgfDF/V0T?=
 =?us-ascii?Q?Mqc38TIHT7WpKfxQvNxoRwS3Mxz3af0mTxK1j0ORW/z4nxHibq5i5kqu4Jia?=
 =?us-ascii?Q?oPZnDtdBmGfsZXX4mz+Xp6SENJuRaThqPZivly4HTSIendH8IYhvKm3zGKkH?=
 =?us-ascii?Q?UeW9IeoMtq3JhXngF4QYo24mBtYLMeQxSfXx4ZzxcmErZPuefAxTHtYce8T3?=
 =?us-ascii?Q?FvmaKADi83xFuGuNHONjwcUfRe5UCc17Jd6iNDZePzgp6ElnD9TuiOed55mM?=
 =?us-ascii?Q?zGxLHmXn4GSLaxwVgaOb1mW6aiUmWskmWUzD10TzOPGLhXTx3Ay2sPFxAisc?=
 =?us-ascii?Q?EDZLW2EFuV1Iifof7MIVgrt5bNqFNicloLqq8g1CcWd3dpO3Zre378a87R+d?=
 =?us-ascii?Q?3Wd8lvbmavOvm764QbGuSP/L9jujPdj0L6dFwZdqMDiWl0jVsK6nBTQ1nZS2?=
 =?us-ascii?Q?WF164r/cDA/09FVrWjC5M5dXR/lT6Kg6HTIzQNEyXpYnw8TboNDWupakWJ33?=
 =?us-ascii?Q?fm8m1/YY0L65oTmoocf1gfg8pf8tMDLyErthClp8h/0PxFSdJIIF2Jw4uJhW?=
 =?us-ascii?Q?7NbDprG/4MZ1Hnua7KI69wtYcUSoeAds1/hi2Lr47HiikRYc4KyPrtsghILV?=
 =?us-ascii?Q?HHcd1fUn21gTkyyr54Y8Qe7CVN/tdET3hEi7y355cAOBhVO+Vj4DAOppIPn6?=
 =?us-ascii?Q?mQ6CPO0YksXE1fiIFZc/p8ab5i0YEuODSMlhIwZA1a8enNGC4VDxGY6SN0BE?=
 =?us-ascii?Q?4h6JH/Ib4KBxs/JHHNqOISn2eiupkC3P42s6NRguWwWL5qPzKhex2ihcgZai?=
 =?us-ascii?Q?C2f+oeIa/lv6FlQKf45X5PzrDSQ30RHiPD0rGSkE6nhFDwkhAUX3lKCs/xMW?=
 =?us-ascii?Q?89uI6rr21vYJc6hD2YHUkOHgz81UO0b3Sc8FM0J3TSfsPKSz7WCzPK/jlmel?=
 =?us-ascii?Q?LgclrFyEWJNSmtcszOBJ5MiSQS971nDvfmca/ZexagdqK5J6?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f10067c-1736-42a4-0df4-08df1e81972a
X-MS-Exchange-CrossTenant-AuthSource: CHBPR12MB731189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 23:30:04.6526
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KIddElH7eonM10AtNnYXuOPZPfHFaGcTdEIb+52nuf4iWhTB9BdVKaAs8SzLmo0b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7812

On Tue, Sep 29, 2026 at 04:15:27PM -0700, Jacob Pan wrote:
> Hi Jason,
> 
> On Tue, 29 Sep 2026 09:30:48 -0300
> Jason Gunthorpe <jgg@nvidia.com> wrote:
> 
> > On Mon, Sep 28, 2026 at 10:55:24PM -0700, Jacob Pan wrote:
> > 
> > > Also, we don't have a T=0 to T=1 transition, our intended external
> > > attach can be transitioned from a blocked domain, not from a paging
> > > domain to external.  
> > 
> > You kind of do, external is close to T=1..
> > 
> > > > I think you are going to have module dependency issues trying to
> > > > get the mshv driver's info into the iommu driver, adding a "TSM"
> > > > like driver would resolve that. ie mshv could just provide the
> > > > viommu. 
> > > I introduced a similar registration interface in hv-common to solve
> > > the module dep issue. Will look into if I can leverage the vIOMMU
> > > helper here.  
> > 
> > That doesn't sound so nice..
> > 
> > If we have to have registrations it is better to have the viommu
> > registration that Aneesh drafted than several schemes inside specific
> > drivers..
> Agreed. Now that the commonality with the TSM provider path is clear, I
> will adapt the MSHV support to use the generic vIOMMU provider
> registration.

Ah, I so I suggested he remove it as it was just for TSM.. We'd have
to ask it to come back

I still prefer the way TSM is shaping up because it solves all these
locking and matching issues nicely. I think you would have the same
general locking problems with a provider (regardless where you put it)
too..

Are you sure it can't be a TSM?

Jason
