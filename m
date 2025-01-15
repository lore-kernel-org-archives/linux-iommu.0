Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2085.outbound.protection.outlook.com [40.107.92.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D84E139579
	for <iommu@lists.linux.dev>; Wed, 15 Jan 2025 14:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736952242; cv=fail; b=cf/SAImKgAQUTt0kTOyZpSmqC1neXkWZZq0UrPIsxAjExG0oJhg3EvqHgmtxip2CqlF1PDIn9LCpG+bLerT+YEMmVPJ2TL+lnOPpowZoJkjcwQMikIMHBSTUObrcg9Tw0r0w6tCFTR9cBhtlsJ3AJL7Ch6hZkzlIBVuIIFc4Zc0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736952242; c=relaxed/simple;
	bh=JBQK/3FQHjpQtlW4HAeLSbaOLkJnBkn9Df1t22bXIGw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=I1d4wgUvQDaesJkntflB65gncEDtvqiNa7LHyblFmYuTKw6VzG2GHfNiixBh13DfGr5e290p5nsm9x8QZH6j6Rgw2SKs6hHjDSioRJ5dTAt/hmqj3JYjsOj58mMf0p01xBXEa8rSj0ZI8yxEdIEzCp+rVlLnPkc4JyUyHcgLd7A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Hei61D3u; arc=fail smtp.client-ip=40.107.92.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Hei61D3u"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p0KwUJzUO9isYY4go16yU0yMZnsHXyBH6fRTryF6dmmujIWdvR5sROmox/N2n02WkUuOpEejtBCZCsM36XDNgozvOkeX4YdCwp5kySSxsR2yGvmoZ0MIPyKmBERgm1Xh3OAxx0kmrhitKylUK62kpYTnSMAQED38Lwmt55TQPpnNhZk6hjH/9TLT6qqrY7fYBippBgIdUblPTul1Rq2I9Gp4ieSbeKJSigRFKKJ8xty+GYVTZDGn5fjo415z5OCgicp2EppRygN5s9CP7J0cNuxCB7sZ4AX21uIn2ateyCwcYfRF2qrQ1A+dFgWnXImF7GIXF8Ad4RMY9WDtETV2Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VewL4P1ayE1n6Keh3YG9J/NMyTMv2b0kYrX527yXOJM=;
 b=y3DKmvv+MlcrL3D5PlcAwdoScQPNejrIc3/LxGJ8iTxJfTcGt+nczpmQngv/sg5w9DvEHmRWawUcTPHzduIY7gVed1/YkGFe46Urp/hKxpqdEisC2a6U+/AwlFqV8sv9D1UzpUF9XV6nIVIiC158SHL8wcIHeI18Q5dx1DDyrcH5sUnMKMGEdnUq5YkkYFtb35eNkE54M2eDwJx1GAFlgfkvjmgifHPXd6AQ3+Egc6OKzRZ3sks+cXsldsO+R+WfggejNZO1nC9HnRc8ImsqIPnELbjVYN30Qj8hFALzuQd4gbIEuMVd++Pbxv4vJLZU0jtfaLds0MSOhxBenZTp3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VewL4P1ayE1n6Keh3YG9J/NMyTMv2b0kYrX527yXOJM=;
 b=Hei61D3u7VhSlJKdKzwBgW7O8AKMI06GTueAjPChfrQd8d2kzKjzyuCoK/gLEZjbOT1f1AzT9tJ4IDFQ62rLiALtgXmO1nUPpAxMa00i7tEZS+UbrF4Khrs9tzYcRtv5vvXLdiYhbARaGnnrm/1v43ccToBaAZqOacLZyBXDXMJ1yFaqP83eYgmWHzjY/Ser3+D5RSOt5rNEF5BgbVwbmr4HVv1IbCBAUBzYNRU34a9gy8x+6ithIVGHwiZZWE0kA1/E24JTS8kcv4Yiq5Rsv4xPobpVCbbMcxnf+AEY4GkUu/VBbFuU0t1vujZE17k7Cqy9+YCCiXM9fWX2kcNUEg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by IA1PR12MB6330.namprd12.prod.outlook.com (2603:10b6:208:3e4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Wed, 15 Jan
 2025 14:43:56 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%5]) with mapi id 15.20.8335.017; Wed, 15 Jan 2025
 14:43:55 +0000
Date: Wed, 15 Jan 2025 10:43:54 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: "Liu, Yi L" <yi.l.liu@intel.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"eric.auger@redhat.com" <eric.auger@redhat.com>,
	"nicolinc@nvidia.com" <nicolinc@nvidia.com>,
	"chao.p.peng@linux.intel.com" <chao.p.peng@linux.intel.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"vasant.hegde@amd.com" <vasant.hegde@amd.com>,
	"will@kernel.org" <will@kernel.org>
Subject: Re: [PATCH v6 01/14] iommu: Introduce a replace API for device pasid
Message-ID: <20250115144354.GR5556@nvidia.com>
References: <20241219132746.16193-1-yi.l.liu@intel.com>
 <20241219132746.16193-2-yi.l.liu@intel.com>
 <20250113202134.GX5556@nvidia.com>
 <BN9PR11MB5276A7F34F2B4206AF4233228C182@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20250114134530.GD5556@nvidia.com>
 <BN9PR11MB5276D2FD6D1006B1C14087BD8C192@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276D2FD6D1006B1C14087BD8C192@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: BN9PR03CA0858.namprd03.prod.outlook.com
 (2603:10b6:408:13d::23) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|IA1PR12MB6330:EE_
X-MS-Office365-Filtering-Correlation-Id: 86eb0acd-9c13-42b1-cc37-08dd357309bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kIxiaLiItp73+4tuCqHa7XFXevDe+FqnDsIhM6xZ+huV4Xbl4gRJwsaKedi4?=
 =?us-ascii?Q?t4Qx4OSdbNICN9ZN+lpeJTpEZsSjjihryPveX/SN16dRC6Ek5sXVZrcuH8Be?=
 =?us-ascii?Q?pjhMmPzS/L1+TRBB40hlv7oPe8OWB+IAST6vtSYrmMqMGgVfNL57FV0zHdzO?=
 =?us-ascii?Q?5KVYvaVAypDy05+gW5C++u0xEgwp+G0L4mFe5DJH0domZ5TvnSobPgts88CW?=
 =?us-ascii?Q?5scnmFzJIC6D5Y/2BZGksCPbI16LraypGE7EwoJ0ner7MvLefoIQCnUWNCoB?=
 =?us-ascii?Q?OZNl5DGq26yWPwV7iEobwcZQbEI5NDrpJ1T7pY4geNjSS0Ni22FXcgMHYTpi?=
 =?us-ascii?Q?9hdsXJkz965i/JYHWFJS1sL2NJayRs90g/E6kVBxoi/luUP0eV33f6EpmQGa?=
 =?us-ascii?Q?q0ImVKhTXXnIy02VVyz0cv0axEqvQSLgmMeMJ5/3aNHhJJR2I/mwVnoZGUWU?=
 =?us-ascii?Q?Xp7jcV7nilDIQncxpnQfcFW5YD8Y0BEUPa/h72zLlmqRTYxlb9s6njkRXRaO?=
 =?us-ascii?Q?01vTiyDRYdWtceIBSz8Lw9+8+S3UL4hkPQYm2+VFzZFLLYQMsiPlo4JSS5n/?=
 =?us-ascii?Q?rJbtmDH1G07kOUAA7BR7GIZek/Xj74LJ1cOiUVjWxT61JJboG9fLhivhu+Y7?=
 =?us-ascii?Q?4sR7iN3R4fhnKRStXRssoHEFWnZVktE0g0KKcIwk8ctL5oLcw4plndmfo8uz?=
 =?us-ascii?Q?/hPriFRQ6nRdvDNZd4TDTQdOOVieIehCXlZz6NizVHcnX0ubxIc4kxuElJIy?=
 =?us-ascii?Q?jJ2hIKA2t76h+DNz1/BMIXta9i3tZq/eJn7pe+hyQVGufrkzHMvWHHwVP2/L?=
 =?us-ascii?Q?lWEUiRDX+F9TFIfTEJnpdPUwJqOBvJbDctHM1LdkJZZbKCvxI4+Wd+duXjAB?=
 =?us-ascii?Q?6lwvqw2vtFtjB7+rpWSq3mQFhu/deoIsBzdJAvv4ZUEAjyphJcjElo+e7DOI?=
 =?us-ascii?Q?dUkllngtyoKwWhPkngtOEARKx2Ft0BP2oIICXlH5RCjCD1K7onMBwPL8vUZ6?=
 =?us-ascii?Q?WXhkIJehXGUTzGgkcbW3rnR/gdiBI21yP8CPR+o5yjuvk4wicyFI2ak8/WlD?=
 =?us-ascii?Q?/5j3xTWhWXn73z87k6aZQER9msn8xTOg3foKsreb3jTN8VO3lpoVyWKMMDJD?=
 =?us-ascii?Q?BDDdfIF5yzqDZbP1DRvfshpBq1BHDhzR5hZXnDRRSq//LV5yaFlMkc8+22qj?=
 =?us-ascii?Q?48YRifK0o62+QH+w7DOBmYjUMU/B+IX63q0F0YMWKILwuILLO9QTRm+7nUkl?=
 =?us-ascii?Q?tgkjBtnKgq+ujGhQt3fdFURSLaiA7H2ZNBCZ4qtc+IDk8sGgQuhhJrCPPeEr?=
 =?us-ascii?Q?DnPmjqo9twKO0y25cskVK8cI5cManwExgbg3bzVMro7FYAx+ExhRALYHNyPj?=
 =?us-ascii?Q?Ah7vU1lPKvaAE3+DP2DXfBEkKyUv?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NWqjJUiM4QBxdpr/Zo7J+YHV9litz/3WVp1dxJO5NzFcx+wP9EnUGLBrSxOg?=
 =?us-ascii?Q?NZV0idAR9KmsytvZTe4Ar22whmV7hW/rx/CovHJ0JTWq7WU+1pk5l/Jvvz/X?=
 =?us-ascii?Q?aDPmZ0T0MyZr397GoD3MQZMsM8X/SQgmafdBJuB0nbVSY8gNRUSH28PEh07M?=
 =?us-ascii?Q?US2q7xIw4LDJvwZYN2BkfCIRAJ3E7Ue9Y9tvVzr2Lztao+h1FCRJgJ/6Iss6?=
 =?us-ascii?Q?/4iU9Kbfv1W6mewC7vABV45idT5U9l2kiRGq0hQIQlfuZgb0bBNn4l6/F6if?=
 =?us-ascii?Q?ji7OyGSVvvW+CQg+L2twc22az7zq9tVvudvzjHNzCEZWlix5vtYdcu3vV01S?=
 =?us-ascii?Q?dQ8dcbnndI72ACAmFIcziAmLVQ02gd7unzB2bNPQ7fhqsUWiPdhlMQZwEKXc?=
 =?us-ascii?Q?ZzIzOjW1JlApMD+gRRixADNezN1Q7Z/TwN2q8asQou8eXoDz7dfkk/N0Wk2N?=
 =?us-ascii?Q?iU6zwdEX/jXUWM7Mp+nFhN+ddM73cICECw1Ykn+RgJJn9MF0yNjIM5ilHbvc?=
 =?us-ascii?Q?vWUPpw+T7hHABZ0mH8VFcwlnOuaQd5MFKEDK+WNnMfjg32TxFcpS4kfX+fFa?=
 =?us-ascii?Q?Rif+VXh3BJTEdDht7Ss+jsX4SdNHfaX1BENczUIEli5+allUQTrKxp9+sUWR?=
 =?us-ascii?Q?Eu6LyONjkE1hUWzfS60C64mDWKYtxHS7+WzPitpTUorvJzOZvM+aeYg9Zz4Q?=
 =?us-ascii?Q?D3B3tt6UWrK5NlnJBT/W4PxIAaAX2I2Bb8hudJIzbJWqBXlfxfQJHGo3U5zT?=
 =?us-ascii?Q?edpQ/rJ7pVvcBSTc/ukJA1FGoVSysmph35jDEovj9laaQb9fz21honQ+t7y6?=
 =?us-ascii?Q?c6+981Nu/W7GE6jCCFjeWo6uCqARAKzYegRWX8EzCDL0NO7pFZjZpAQ2i59c?=
 =?us-ascii?Q?chbHnbF6rZcoyVZY5iflw4nvGd+Hu9hcIBQbDTA5iMCypyFTqGStKw45kV9i?=
 =?us-ascii?Q?QpheyNtdmDEk5+o6ROKtzbk9QCSa8qKLctYRGiHJwLteAkvEVKkdHv6vIT6U?=
 =?us-ascii?Q?euyG4NP7d7BtxNdZZwLuZoFtMm0wEfvdqObOjKHDgUUdICatzHyJcv0Pu7oM?=
 =?us-ascii?Q?Ar2FBr2fhv58nT4u5sLi/hI9ANjLPhxgCK7pUNVEnAMPEwK0CBZW7QCEHV+f?=
 =?us-ascii?Q?v4J1mgysuqkggBphvC1g+piSzwl3bCJoVH4ZLlHOOJ42O4GQCR4SI3/4nKUQ?=
 =?us-ascii?Q?aGHdZ507vE+nzTu/rgWYg16oMoKZEkiB2dRrbIwG/px7NFzg4Pf3xMmB1we5?=
 =?us-ascii?Q?m9zi9KVWdvma7QCcctQM59QXqznRSYkl+QaXlh7HEu5+s7/NJoYpzBazug7t?=
 =?us-ascii?Q?k3JPLLHr0PGqJJ8WNwAJMDbSBBtSi0v7l2dS+K7jR5Eus046bdtx3lBHNjfZ?=
 =?us-ascii?Q?EHwtRvl3/f3StsgWk1hNvET9fKZEpd6CX1DdunK4Ssqmn/69pPuWSSGIoRFm?=
 =?us-ascii?Q?7aLY9VzO/wdStEMH97J5WfFtiAG6VLeKGfR/Ck8Ksq6yr+LBSXQ2fYIvxQkz?=
 =?us-ascii?Q?ayjPMdNeW15jMIQMucPpj+jBe+lNqdJVR2Gp7E8ssqlMpyR3ogmn6fSO61SF?=
 =?us-ascii?Q?X5ZcDWpHmGlPZYvBosK6Skaf0CCemqYJzqQ91vKn?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86eb0acd-9c13-42b1-cc37-08dd357309bb
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2025 14:43:55.8849
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B9ayO3w4hnBEY/mNtuNq9TNa0gUNKcx1wi7wf8fE6uBAEQr2+SvCLP92UZwfFMwP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6330

On Wed, Jan 15, 2025 at 04:43:41AM +0000, Tian, Kevin wrote:
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Tuesday, January 14, 2025 9:46 PM
> > 
> > On Tue, Jan 14, 2025 at 08:10:41AM +0000, Tian, Kevin wrote:
> > 
> > > > > +	ret = __iommu_set_group_pasid(domain, group, pasid, curr-
> > > > >domain);
> > > > > +	if (ret)
> > > > > +		WARN_ON(handle != xa_store(&group->pasid_array, pasid,
> > > > > +					   curr, GFP_KERNEL));
> > > >
> > > > I wonder about the ordering here, is it OK to have PRIs being
> > > > delivered to a domain that failed to attach? What cleans up that race
> > > > condition with domain free?
> > > >
> > > > Should we replace the domain then set the xarray? (and same ordering
> > > > question for normal attach)
> > >
> > > That makes sense to me.
> > >
> > > But I don't think there is a problem with attach. xa_insert() will
> > > return error if an entry already exists. So there won't be any
> > > PRI being delivered at __iommu_set_group_pasid(), no matter
> > > it succeeds or not.
> > 
> > It has the same issue:
> > 
> > 	ret = xa_insert(&group->pasid_array, pasid, handle, GFP_KERNEL);
> > 	if (ret)
> > 		goto out_unlock;
> > 
> > 	ret = __iommu_set_group_pasid(domain, group, pasid);
> >         .. Concurrently a PRI event is pushed to the domain ..
> > 	if (ret)
> > 		xa_erase(&group->pasid_array, pasid);
> > 
> >         .. Now what? Who fences the PRI event thread before the caller
> > 	   frees the domain ..?
> > 
> > We arranged things so that detatch would fence the PRI, if detach is
> > not called then there is no fence..
> > 
> 
> Though I'm fine to change the order in attach too as it looks more
> reasonable logically, I'm trying to understand the actual impact of
> the original order (e.g. is the change worth of a Fix tag?)
> 
> If there is no detach happened before then it's the 1st attach to
> a faultable domain and PRI will be enabled right before this function
> hence no fence required.
> 
> Would a sane device trigger PRI in this window?

I would say this is not a "sane" scenario, this is a theoretical race
triggerable by the device. Perhaps a VFIO user can force the device to
trigger this race and exploit the kernel.

> If it's a detach-then-attach flow, detach will do the fence anyway
> before the attach.

The issue is the error, once we do the xa_insert() then any faults will
get routed to our domain and the fault path threads will hold pointers
to the domain. Once the xa_insert() is done we must flush the fault
path threads before allowing the domain to be freed.

If __iommu_set_group_pasid() fails then we do an xa_erase() but
nothing will flush the fault threads.

Jason
