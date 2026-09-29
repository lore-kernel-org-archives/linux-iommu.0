Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013001.outbound.protection.outlook.com [40.107.201.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9CFD345725;
	Tue, 29 Sep 2026 12:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790685089; cv=fail; b=MNz8+nvR+SWHGY/IDvBvAXDNQQ+zYJvCMoIxv9hQxrPo8d2D+1ziymCYDuaNQTEGQ1vZJ8jNpJnhqncTCB3JmkUCWjoP4QvBxyOaFTlQeHy4L3Ld+AhaJeLnZ9YZww9Oj9XtOqAcKeDl7jNimsGc80J2pepm8MRVhfWNDgBMyYg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790685089; c=relaxed/simple;
	bh=WMW4eN6dbz4B3o6Oa685uGsisgkzGocRqIy8DvRB0Rs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eH0Ukz4ZfScys10cItTiOqBrbvtTYIH71u5xMAturqUepbDOXP253Ljc9Sg/MOeX3FyzNr2tRUVRen85VVd7GDlrv/nIvUdLBoLxo8NLe9kKZfhHREL3Gj4jW+9baxyDcmiCwH+7EapecG7mHQ3hzIZV8pPWckxoPstdQO7fiPg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JJhd2+0C; arc=fail smtp.client-ip=40.107.201.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JJhd2+0C"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kf2uV3I1qGmIcniWLPC65r3dt4DX0x7xCjLVaeyFpCmSSbCanFrDRGAnE+4iesW4ktB+sWYNhnqoVNTtvaGKIlaBon6NEWjE1WDhQDmKJSHFINedipkDGj+AR7Om5OS9Wfs+wUHC2p3r7pQ47Skwj2ppuJBtworQFS022C8XEcUmmqDvNOSj6BCYqo8e+5oTwCd11miCdNmKx13WRgygOY0V1DgaaqUIcQErfX105SqhEcXowcsd9wPBGoT/SjIKw1xUz8vWZFtnYeAql7aUJHlL527Ht6Ojta2N9XMBuJTtq1pLQo3WbbK0XwsYeWSr0CDZFE4j3/TwFlAz1suy+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uBuYLgQXbYpJem6/DVuh7WyvTlQEB3tqPDTmRxtSdDM=;
 b=VcwtScPDJcyTpJetKlcaeJNTvnq73+gCF+/EBH7aJOG4oh+0xbSCopsyrx4iw+r36EvPbQmPKbIL51Q/DHtYVhUqTgBlCX5XA6sI+R3+ItYwPPNftHkx/UYXVOO4Jg1yFMIHBB33IvtoUlwxjBRohrOF1BC/QkqFktycZqDQsVfaFErK/zEojk8d0JfIX1YAFKj3UdUvqdqW4pKs89Cya1kv7PbjBLWNEllMHpSZLn5kKBYfdGwI/w9gI8XrHuHPlYehE+tGD7xCrDaryGZo+lRNFoRDApu1Icj1g+4OqVn2+I3XajTNpM2a8I6suvb1cEc2VqG0smBpERi4RpgTWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uBuYLgQXbYpJem6/DVuh7WyvTlQEB3tqPDTmRxtSdDM=;
 b=JJhd2+0CNo1/xPRbSQPpVE5DiHg+9vFCqd/XZq2Gc53Dpll9VIWPmDYJcB8JdxA2rx6CJJnO7IrLuFNpGxmekTLuLHHH6oFBSJ/nfhGbIgQD4Omlkh5Y4ihLhFMUdFzRRswnm9pmbymgE/RQ+RN5laWxOFxC2oxtNBKeqXoZvMPE+c4Sqjc4puYALhixacFpdukYHNah4FdvpN/4tzFfyaExKOgbGBzzjOK2plFRIju30naBDs5OEpsU7+i/L929TneLThgPSdzbSLrl8lp0sbvHRDLjTknLy9kBvq+KVeq6OfNPYn1S92Fi78rw5Zt/wscznxwy8rpprOEd0Kh3rw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12) by CH3PR12MB8584.namprd12.prod.outlook.com
 (2603:10b6:610:164::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Tue, 29 Sep
 2026 12:30:56 +0000
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d]) by CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d%6]) with mapi id 15.21.0451.024; Tue, 29 Sep 2026
 12:30:56 +0000
Date: Tue, 29 Sep 2026 09:30:48 -0300
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
Message-ID: <20260929123048.GJ1616761@nvidia.com>
References: <20260925122305.GG9354@nvidia.com>
 <yq5a5wzpr7b9.fsf@kernel.org>
 <20260928121147.GP9354@nvidia.com>
 <yq5azex1peqt.fsf@kernel.org>
 <20260928161738.GB1616761@nvidia.com>
 <20260928110854.00003ff0@linux.microsoft.com>
 <20260928182022.GD1616761@nvidia.com>
 <20260928152402.000079ce@linux.microsoft.com>
 <20260928230328.GE1616761@nvidia.com>
 <20260928225524.00002b85@linux.microsoft.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260928225524.00002b85@linux.microsoft.com>
X-ClientProxiedBy: PH7PR17CA0072.namprd17.prod.outlook.com
 (2603:10b6:510:325::20) To CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CHBPR12MB731189:EE_|CH3PR12MB8584:EE_
X-MS-Office365-Filtering-Correlation-Id: b80bd7d9-346a-470e-5405-08df1e258259
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|23010399003|1800799024|10067099003|56012099006|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Sn78ScTS6hRZ7j9aS7QX1lhP9N2MZca3wA7Uqp8wy8zc9+iyfXVMH+pLbcOQCEtPecwQF07zqwGho781Z/1ilqsWDIhNbS4VEMhPTKkMTeXO3hqDFJpV7/kLHbdaRnnFvSdPokPQVIyVlF8DF7zzUrXKS7GV/TSAs9QCERPhUauwkVPLdczzWAN2PYD3Ji1OQkAd0OAV43lXC7GPqSKWKg48Ys4NiHkR2Zv32Rf/OKY1nqxg6i7KdWXJy/ZisMFeDtnrAKLExPfOhJp9+NMJOo3noOGY2GPZeuYxczc1ziQyUJV939RDC9CqlZ3mwv4zVhPF4IbFBkFkksjlUK1EFhTT9NPZVXC6c1S5w0s9ExsFBog1MU+6BlTELgBL9uricoORx8FzBs2CX053/08OL9DFk/Rc61c0GUn5hOLmI3Poel3fhKSqJLeHZe92jHdnY9b7YYikxo2LABpGQAk/1EUSEKwVMaJFe33QJAFrMiJKm8+Hr2My9PkbLvyWbeh8qzhbOrvWCaep7mnQt86ywMIx1ZnWkfRptwQvU38PH0bvqu1JoTFodhhTw6nT0CxGK8u06/rXhRJ/t2UPYZdqiaBBQ5dpM2WZ3GtMi78e0yz6ziPfM9iF6Ov+B7rAseenHU6LRGhfjR3wJZiAaUx2udvz1cF4FlKEh2tS8XTTPgI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHBPR12MB731189.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(23010399003)(1800799024)(10067099003)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?52wwgsVezR115qt9d33A1kKqqGE+LmyLq4nYlTmVqZNhv2BB6j256Hzo1NZQ?=
 =?us-ascii?Q?NKOAMnafoOqpJLbRMRHUiY3JILFVlm8e2Cno63JgTJUQgwx/GdcFSMaJzzZi?=
 =?us-ascii?Q?G1/v1UZHlpKBSU5PL6PmSGEhCPs8Fn4mRVOQEwLxzSj93W6+ss+vV4a3Tz2A?=
 =?us-ascii?Q?yhcAh5jPoSs16DNav0Hg0kGsSZkvOjOH6v2/l/ndVXtE+REh7OwODc+cDufU?=
 =?us-ascii?Q?EDBh8mNIHJgg/UtLZuViyt4QWJ8d4bk8aIFlL6s0E6d8kPBYXv15OkLN5iyB?=
 =?us-ascii?Q?q/vE/YGL17RWoHYAekD5v7qXyvKCOyvB+zL/2l6EeJOprXpXkZtmukPa8hFg?=
 =?us-ascii?Q?FD+ttmjbZBvFfUCfE8OKLN0LDYopWIAeEZki/IxEJpYmjjTS8SpfacDRSLxN?=
 =?us-ascii?Q?9IaUUTmpr+QPHOiBXQ1Y/tJ5lOcRNFmvxh0kGvuNhWLLBGGtaejtrw+6/Ilm?=
 =?us-ascii?Q?B+vwISMpHO61JkVE66Mj8EAeVBvsJCHokVVlko/boKKqJQomd9F5eo/Y6Jd9?=
 =?us-ascii?Q?PWPOXguhUceDDICM7Hedx74gyg9WDboGdPds3QQHGFnJ4klP4AdJ9c9eqmug?=
 =?us-ascii?Q?bt8wIyqcosxVXRsxEYQnSsDOKHeELygslhPRlu5LrytJm4TjFYgBUXrlVB1h?=
 =?us-ascii?Q?5WFl3UBqRS/DO4SLDzruohHedA0H0UuxmLFVpedSNIW16WTvzFx5+IZR1+lT?=
 =?us-ascii?Q?qTWYvmhUOAZhqWEGZbc7F5qm3zXmXZ2vSSvM5irO6X23YzzA22wAaSO3H9pv?=
 =?us-ascii?Q?NZolkUdVnhQJJIowGUtP5GeYJQxCaf6uJjCu9vTJMQI0Y0r2tgXs/yBOixYC?=
 =?us-ascii?Q?N0iw7Ji4Q9ZtzBMBHeS31MQ8C5m+YzGVI578sxuN7Lk09R7oEpW9jz6Y9Iyo?=
 =?us-ascii?Q?Z78pxeaObN9IXgSgriwzNmDRP1ffMaOZcLZh5AH3WFa/0aJPR4aeiDPFxELb?=
 =?us-ascii?Q?qxJq0fO6bDwsTOGNOGvF/kd00IsptRFLDbwZqPzii9KTGUycLHg8IkSfpngF?=
 =?us-ascii?Q?TmI+HIvdum2pQy8jLRC5iUSZ/xnGI7VTjC1eIrn/mVjpRIcSGqaUhcUJ9aLp?=
 =?us-ascii?Q?9rcScL9mJFb28DRUfETnijqgc5hrvBW78qQaULs/QgZCMESuBhzQUuJufadU?=
 =?us-ascii?Q?9Aw5dRUkwob8EolqvM69jNfEohB7JnXGEKFiZbpgCz66w1nzdPMIWFBeb1Y+?=
 =?us-ascii?Q?x9gdvI/EATpep/hz0gqTA6Zx3qJRDfb4xVm0Nv/x6WMxfzq3wULP8xglo0NC?=
 =?us-ascii?Q?pfabYB65fI9UyYSQjOIjsqd0q5hn7ETYQzzbOt4mKUyzuboM/cztrM1FcOCM?=
 =?us-ascii?Q?SvB69IL6zfQq6wYqhV+Gv0W752qG17tJANa3Qls+Xg0ppVq09OCUfDLq/TN6?=
 =?us-ascii?Q?Ai2KIXAXdPkMvYbKVcvk8//llFq67//W4MOPEkDEFbsVABqmYcnqXHy5VYzW?=
 =?us-ascii?Q?3bTSwfQgNqwlFyS5jQHPdJEgpP2oNjv5Se4ap3v8jVGzHYqIsvZ6nqZASYvJ?=
 =?us-ascii?Q?04Ea8/WY9wQD/CTkLb+AvCLgfT+OcXEJ9yQnifUVI7o33yFf4rEMhc7K8KG/?=
 =?us-ascii?Q?eEipWQ/w5LqhaROgN1sQzVKFVgaSTylAYUWO6wRUUXnihjqmdioX4heCE3t0?=
 =?us-ascii?Q?tJnklLnOQ9umdYElX4gTSeNlhQWg3m8gDJuO9D+hWDOZyJSbg5h0WMx5D/bv?=
 =?us-ascii?Q?etQsAPndZCB1xyysC0XRFbnkstb/ahZZLBrtwmJTSXqOWGdd?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b80bd7d9-346a-470e-5405-08df1e258259
X-MS-Exchange-CrossTenant-AuthSource: CHBPR12MB731189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 12:30:56.0533
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kqfTf9SV+gUILxH+ohnLtyxQp7g8HZEFAc2KhUxC/pJ4kiXCfiGTe0xXkJxUhURv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8584

On Mon, Sep 28, 2026 at 10:55:24PM -0700, Jacob Pan wrote:

> Also, we don't have a T=0 to T=1 transition, our intended external
> attach can be transitioned from a blocked domain, not from a paging
> domain to external.

You kind of do, external is close to T=1..

> > I think you are going to have module dependency issues trying to get
> > the mshv driver's info into the iommu driver, adding a "TSM" like
> > driver would resolve that. ie mshv could just provide the viommu.
> > 
> I introduced a similar registration interface in hv-common to solve the
> module dep issue. Will look into if I can leverage the vIOMMU helper
> here.

That doesn't sound so nice..

If we have to have registrations it is better to have the viommu
registration that Aneesh drafted than several schemes inside specific
drivers..

Jason
