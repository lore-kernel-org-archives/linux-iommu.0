Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2045.outbound.protection.outlook.com [40.107.93.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2999FEC2
	for <iommu@lists.linux.dev>; Fri,  7 Jun 2024 00:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717720033; cv=fail; b=SLr1bh/E22+J6EBbXxk4mm83Mimp9D/zG9p63IakjGoOM3n69SK/xEuYr5wYLcSN28ZaKrFCPCnIQvbuunop9gGLLeapxf5eemWRNGn32PAl3llt3YAE/IY6pAAEYvTYfLpvQS942DhXJMt5ecRqDLsFkCCIrF2zRqkaVA8zeNY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717720033; c=relaxed/simple;
	bh=Xm4g2VrLbdZucedad+rLR4uWbL4Wcbpu55WZtkQOaAc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=u/Pxt4rth89fNdIuhsqAb76IspJzqhYnf7Ycq8NEjlFlShfBkGx+jZiqb+QphmWuvMrFo8NMsJPEeE2jaiNxQNbuMYMMWt1DyUGIqzkEybr4xs/BiDPK/DLnfUqxEAO9cezzTZJJ9gt8Zlk1Vg1GfPCH340bZeU59yRWt6Yfc90=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GB0D2AzW; arc=fail smtp.client-ip=40.107.93.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GB0D2AzW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GLlGuCZKDdHFfsa+Re1Uo2XLv9iLrQlN7cYYQj1z4w9a/vCrVjPmWyLO448BczrUlNnYd+vDtbeaIZJ314ITl2rLkjnd75a3U4r8ZmkraV3XXM7w0I82XnkOWeLMtztqprfAanCDZJBKIPXTV7CdAO/R0czxRqxBlwAfsH8XhgFFeezTS+cXYsFC5cU+HT3GFaKfyAKiSPTetqYRAso8d1Tt7ckLDIlkJNebkqozaGvYFeGS7aZkhfjNEswx/9sxmlIK3WDXHgldXbJ6ZzaYwB4xMwD5G91Y7rDFtDM8knW+O84EAvZErKk1HHgZVtITeUXMgxoSVInvcMA0/fFL/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Jgvqix4kViqoOF+wETPfboyRGmtCnuuRQm3YAaUabw=;
 b=gGXyU1mb6rkDoewvKDYAFek5IOQYfdDjJU2IWJQWaDMXWmGieyAX+OONVNg4vpR3N/MEO/EWlzG+8v/YjoRKSeFrST9deYo+/fPhPkFQs1IZ5wWH69UhVube7Hb9yrI7fY5LvORm/CvohB1In5BWBBbSVB+qp63f3Ql4HyWfR6JzCOrwcZwyHKyo4BO4RRalqqk6e+Yia++vzTJ9qWsr8Wp+7ZiIBzYA/MRy/T276IXC6ANXW3ecZcPss+uQe+mxwCm/v6+DFLvJtNmNumSquuahjBmUMR8Uv4ZcGtcHSoIbuR24U7fHiueQ1ZjcQZBR0kMi9CM73ltmS9e2Krh06A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Jgvqix4kViqoOF+wETPfboyRGmtCnuuRQm3YAaUabw=;
 b=GB0D2AzWGO9VVhyqNbQVCnzkBOvmJL3HhuB+ACh3I5KU2VaD6foXmuH4dXCl5yH4vAzp6ROmdT5VakyprOmLeR3JxxXnJ6QtG6wfj7ypBiS5I9utA7KoowxiQnzlmG+e/+oMT6VBkEvCgo48Wqiv0+dOLidh7WbOfMjVmnwNrXNYGzl7kTv1wrrTNgSTmQldKOQGFm6jGsLW1Ka0sBQETBOYy9eOdhaK42u7xy5gfUNIFbZZVltOJyPkxpbpw9bdSAffBiOiwiw+mSBGiJBpo7TGdZdqKSHvXU6fefiK3acRulLoWb3p7vNWdJ2SUTBN/r4E0BvSyqcvcNkvJ9uRlA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by DM4PR12MB5769.namprd12.prod.outlook.com (2603:10b6:8:60::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.34; Fri, 7 Jun 2024 00:27:08 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%4]) with mapi id 15.20.7633.033; Fri, 7 Jun 2024
 00:27:08 +0000
Date: Thu, 6 Jun 2024 21:27:07 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>,
	"will@kernel.org" <will@kernel.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
	"Liu, Yi L" <yi.l.liu@intel.com>,
	"eric.auger@redhat.com" <eric.auger@redhat.com>,
	"vasant.hegde@amd.com" <vasant.hegde@amd.com>,
	"jon.grimm@amd.com" <jon.grimm@amd.com>,
	"santosh.shukla@amd.com" <santosh.shukla@amd.com>,
	"Dhaval.Giani@amd.com" <Dhaval.Giani@amd.com>,
	"shameerali.kolothum.thodi@huawei.com" <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH RFCv1 08/14] iommufd: Add IOMMU_VIOMMU_SET_DEV_ID ioctl
Message-ID: <20240607002707.GJ19897@nvidia.com>
References: <BN9PR11MB5276BBD592021507C3A0EBB38CF02@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZlY886FT3HHLC8Cf@nvidia.com>
 <BN9PR11MB52762EA9B444DA71F551C3868CF22@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZlafEktUu5znDsNt@Asurada-Nvidia>
 <BN9PR11MB5276AC43120376A2502D3D148CF32@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZlfPPwsnY6P4SoGF@Asurada-Nvidia>
 <ZluWXYQjroz0fqqn@nvidia.com>
 <Zl03rsgZl/msa3I+@nvidia.com>
 <20240606182423.GF19897@nvidia.com>
 <ZmIDqgfINXfB0i3L@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZmIDqgfINXfB0i3L@Asurada-Nvidia>
X-ClientProxiedBy: MN2PR16CA0028.namprd16.prod.outlook.com
 (2603:10b6:208:134::41) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|DM4PR12MB5769:EE_
X-MS-Office365-Filtering-Correlation-Id: 11415b31-74f4-4cd5-2138-08dc868890aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TL1ZeejcWNnmPx2csz12P7QQger/snY+YToTSM0moQJ3upont0YbUEVW0TQ0?=
 =?us-ascii?Q?OCROqmTI6fBRnJkKU4AoGxGlJIcSK1ezZyL5a5F4fHLCid4expx29m/xfWnZ?=
 =?us-ascii?Q?80Fz644M8TN5wSwsId2bWPnMNqalvy3tpqHKlG5tjo/03AfyomllaUl2S7M/?=
 =?us-ascii?Q?V0EJ0f9ojPwqvVk8IXc1Njghjz7a3ORY0U4CSDOMisrOuzm3unXIKACw52Di?=
 =?us-ascii?Q?JXBAXTYqtvJ4tQ4MgQOfYBUnuzYqbp9/Il3P6SroOwb0q/xICOmG3alMqeFx?=
 =?us-ascii?Q?FYFyPfcf00X2kK+N4gTdLqSlXSUnlofwBApI2LNp0RqyOwtXyOQl0flm1OnU?=
 =?us-ascii?Q?sCsVYvbcQ6sAimtD7pp7XzCaZ5Pe3pK93UGRYnlREddbMIovQX3G76tJN2DE?=
 =?us-ascii?Q?xfJXIU4sGLLWhZSku6RMDNS8DZVokYsVFV34TJbC+8azFT5m9oEKGhhAOQ9b?=
 =?us-ascii?Q?XNn4EYrkthMUw2OgKYLFIxxBELnrheH+GQ3xxKcDL5S5AgFRakO+0xoXwmHp?=
 =?us-ascii?Q?97H204readqXu8DiKIyl8tGWExgsspnVYayr4HPDB4lMDN8oV9N3r1JOsu7T?=
 =?us-ascii?Q?qmeR0fwVlZFCX9VgaQDeL+b3yVYIZVJrF2RdRdLTgnf8hxasjrjSXq9kYrs/?=
 =?us-ascii?Q?8cuPm4+2f2lSjVGz/bjE+xp9jqxzYWUINMWTUTU4qdLImvuBSm2Ov0Z0tUSc?=
 =?us-ascii?Q?eVJl9olOlTIy+7JNoztqYJN88psBBN24m4Ek7lDzsGE8V83rd3IHZUbaRIk5?=
 =?us-ascii?Q?rhXYctFJCzsDu3Yieo2yHdyT5kCAHlH9Mk5HbpwOeqtmlsWoX44k8mTfIIew?=
 =?us-ascii?Q?L9j6cbrjCsHcHJQGRthQpY6y6QoFWyftkXdGN8OayPkun5F4LxAb8mfhpq5b?=
 =?us-ascii?Q?jpSYkaoTLKPZjepKoJirzwzWV65AhTP+q8QsCjx353mgr7jwxgjHgLJHmIu8?=
 =?us-ascii?Q?Hthg4o1PkdJ0jji8trw8FNZ6tolzF11Wo685gC1gNw0oVlkGh64kxLHPNyHx?=
 =?us-ascii?Q?b2Y+SY9DIlBSc5J2dp4TRz2OWw0QdbrpW6MJI+GK4yqjoRlT2Nub043qI1Pa?=
 =?us-ascii?Q?kk7209y6/LU+CdaKzZbAUgQHxxkqns8eNZQf1ubFPv4x+mWZBtW+eW3z7PAQ?=
 =?us-ascii?Q?HrDW4TD5OFLtUKBGz8ucGipbdcfnHGQTSs7XHeizsJlvYX0XZH+gx6bFDIlv?=
 =?us-ascii?Q?Ew+Kb/VcZ2GLf0FzPzIlTe6SsKS9nwc+a7KxJhD7xjg4WMDF1vZ32sF5eiNp?=
 =?us-ascii?Q?4JSExiteZmfdlVWa3OzO1bZkG4KFci+zOTw6E+uScGZM8U3MGSd+qLcpLYHZ?=
 =?us-ascii?Q?zrSgCfaSm2aNqLsrCw4s9NxV?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tETB4IHJUhAZ+2Oe0L57BPcXoE5vbGJzGcA03t/gzBvA+QVAMwmbvIwOVAE6?=
 =?us-ascii?Q?PS+oui4hRWdV/99tfMIjUavXq6Kzai9bRsGBvEIVGxHNyu4iLhCS/GthM7Ex?=
 =?us-ascii?Q?FTzQ8n0PS8uBoxCwIjEYbgdf9qeaJzEIm5uRC1UHdV838+lYWb2YTdTCgcvk?=
 =?us-ascii?Q?r8W7nLGDR+v8OJ2DUqgW35MQ2JRn09+RKk0pDhtRsK6rVWH1LJO7uyhmwt4R?=
 =?us-ascii?Q?ieByr9gEHx5B8RmllkZ3MiZKglyjCTvJp/jr22f3z/UaENMUoCYXaLYUOZae?=
 =?us-ascii?Q?9MqPK0sf8y+tWfTDSOcFZ0f6XWxna/IgUU5xx+kdjQv3t+ZU3TlBZaPzCa8b?=
 =?us-ascii?Q?Xz6cY7uF1PsCsWbrSGObWkJrJl4lnz9rpAsrAPFQy0o9d4E5b0JXnJqH9zap?=
 =?us-ascii?Q?/E/f8eqw9m9SS40kK6imI3Bw6zYkSMOk99x2tNQO1R9ha9J4EOYsnkDcPc/n?=
 =?us-ascii?Q?+BgTBfBwEdHzUWMZeV/gk1BWGNTrKkG3Xq6ttoAcaDj8rS95JFSE5Mh/7zCL?=
 =?us-ascii?Q?U4BFcUNdzFhJexgot1VS2PcnV2Y1xgmitu1N4Se8feplxL98130b9NMXxLyw?=
 =?us-ascii?Q?K1ZN+T2mlRok03n9oEArrAbd8I3RQ7uiBa7o2fcFwpPuq5lZ5YkbC+eDHlRQ?=
 =?us-ascii?Q?Q1QOXyJYg/H2YhuuyZ/oK6XjZ3+8JKhat49JbKkHuognOFCQK8oKONf4lYw7?=
 =?us-ascii?Q?G+RnieTGE+5CWkj4hNLBLrY9t9KRQoOwU3X49LpKdm96W7eqdgRER+jk60ng?=
 =?us-ascii?Q?hdr+ElEHsZxVkCqxh77q4lEkpM7zfZrfLOLPr0fUy/asR11zc95PnOmKPap2?=
 =?us-ascii?Q?ggVWRpAHh/W2Oq1lgDb9tl7YCNekudCq/tUONCfkElVcDeClMYbwJa6CCN/A?=
 =?us-ascii?Q?3cEwjatG/R0D2XKy+Jv3sy0/JoNUH/NqD55BlxZZJ/pA3GVXHxDUSCE0rFux?=
 =?us-ascii?Q?mAKQRmaowIuDfgXQImiQfH5VW39sO9Mrsuj2gKPf2q/nqHJBdFu6FGi4MABc?=
 =?us-ascii?Q?nKWwuyE6UkxdbjnLgaH/y5UJkyreF/lu9GimUw5Tom31L7AL9Ycz9UYmT8M3?=
 =?us-ascii?Q?Am5BN7mkeJ9lYHUvRhwDbJP3sn1L9V7nEvPNiuP8N/+SXGStRv6iKfbbVBdW?=
 =?us-ascii?Q?ToJd32UCHndT4rGMo0zFEPTHfybom2o33hP9QikLt5ZeGUwVdAnFHKTWVT9Z?=
 =?us-ascii?Q?1bSIzNEeoEloypx5Ieq7s8VwaJua8nZOD4ujziyyxKo1yBKUW61FrJA31uFV?=
 =?us-ascii?Q?wYbq6wELD2x2jupY+SVwI5d9ydcxCS3JbnVZrmOmHUVsI7I+O7zg8qdESMkj?=
 =?us-ascii?Q?nXx7k1GhvM/zojvAZaB4To0ukAtNqimsMalcS19APIS/ddYpsi04ySVL6VeB?=
 =?us-ascii?Q?Kt/MgJ9k+7xG5EiL9oCoyWL4ww6IaT6D+b7+n4pfes+6qbvkUfoOZf11av7W?=
 =?us-ascii?Q?ot7njvXho8K3A7s8BFmujjCcH+3YujdkS6j3zsP5asNG05JASzs9/g4JMDXX?=
 =?us-ascii?Q?4WcyoYvkWsZ2cg29D61aDJyls1Ex16xPLLH3N2pFFyG9adewpw/Th23pLNoc?=
 =?us-ascii?Q?upZC9/96arzCwwVdvZ+CiyHiZNfW1P+E+1bzSd2v?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11415b31-74f4-4cd5-2138-08dc868890aa
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2024 00:27:08.2779
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fkiM9s2C+oKh2xSWM7WtjRyInNQwGObVOWaQjh06Eom2B8WR7Fonb7TH6d5gQV8Q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5769

On Thu, Jun 06, 2024 at 11:44:58AM -0700, Nicolin Chen wrote:
> On Thu, Jun 06, 2024 at 03:24:23PM -0300, Jason Gunthorpe wrote:
> > On Sun, Jun 02, 2024 at 08:25:34PM -0700, Nicolin Chen wrote:
> > 
> > > > I understand the appeal of doing this has been to minimize qemu
> > > > changes in its ACPI parts if we tackle that instead maybe we should
> > > > just not implement viommu to multiple piommu. It is somewhat
> > > > complicated.
> > > 
> > > Would you please clarify that suggestion "not implement viommu
> > > to multiple piommu"?
> > > 
> > > For regular nesting (SMMU), we are still doing one vSMMU in the
> > > VMM, though VCMDQ case would be an exception....
> > 
> > This is what I mean, always do multiple vSMMU if there are multiple
> > physical pSMMUs. Don't replicate any virtual commands across pSMMUs.
> 
> Thanks for clarifying. That also means you'd prefer putting the
> command dispatcher in VMM, which is what we have at this moment.

Unless someone knows a reason why we should strive hard to have only a
single vSMMU and accept some invalidation inefficiency?

Jason
