Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2045.outbound.protection.outlook.com [40.107.94.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1EB1D7E41
	for <iommu@lists.linux.dev>; Thu, 20 Mar 2025 17:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742493095; cv=fail; b=caa4HUqopkolm/jDzZUCsI5ZvJ4sJtuTFt5yOZmU4rmjLk2tJdEyktDlQ5Q8VjN2Ut2Us+axkjjmoZLNV6q662FRsqq5s+clVaQk2/OIMeOPq6ZEqn/FXvyleX7c3KtwTvdGFkoRxWRQC1rwgT3wpr3uDF8DvyEZOWIqeYV3ur0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742493095; c=relaxed/simple;
	bh=xy+QvGcoz9eGqdZaJKKAGe1gsMjL+VUlboY2Ckmvue0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P4ugwxBmRRyRHzPJHtk/01IP06nfKhdnsJ3o6AF+JbgCOrosEJNF+CoBmS3WZK3B4GUPTm0KKWC4P9i+hLDqJvoY8msTpV9wZRe9v0+LWWOVm5bokkdkRoSuBl2EMBGi8OXVtFHDbhx0D6TXbFo+q13h3vmjiMP1BmZsW+7YFCk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=D7Cg5Edz; arc=fail smtp.client-ip=40.107.94.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="D7Cg5Edz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V74MRGFbHs01Ong0VhhQeDhOtrjydq+DCE6wHD1yArRJ77/zmOWKFhPYmt+5g8VFZIsfbSKPYpxSRb/Zs1+B2aOOm6/4ktYO2pj/ol5Lcg5CHQMQsgi2y0Gqxb3Yr9B2rSUJoUAQ43aDxjrgyvwkenOZ14NtQnxPyzL1MEJFU2xE8dpJcQX01rrvk9M3d+V/QLePUktRv7+DvnFgBB1sfYAymFIzwKZzPOKWAs9iZm9ez0cnuZ3yFvl+oBRnTSPqLM92NWS2ykSH/8eKUWiefY1xNMBOaZX/dyQwOmb2nznQNZhYpf2cNxFt3jkl+oJ3jmvSaLEKBwnr0SDU5W8XsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vfAnE4LURgm+S7d55sLB7/1kqRpqHyeobeR40OUAt14=;
 b=ggIUfbpOhUbc7+XYkuZTDN/OdF2V8+51l8ufOlNc2OurcFoBwrpzmVM/QcjWFFww+zDlWwSHQp0VFOj/B0gPJfkK1rfzVKIMYhOxtJM4tuvR5TWTuobM/YMSDoJ+90ln7ME4/5VbjYZx9xISY+AFmyxFxeNXQj7EhAPLLI+Ih20ByA5Mr1qwsfkak06yNPQTHbsx6YM75sCtol974/5i/JitKQHaZNH7NScsH+Z06wNe5AsOFX0ElbEvsyLTadbnRIdt9eAM5otvVhy9fXvdJ6IVz1YnIfz8LpcHDdkOg1fDdPx/4SqiqAPFauMjf4u1QyRy0kJs7i4nS7oB2uc0lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vfAnE4LURgm+S7d55sLB7/1kqRpqHyeobeR40OUAt14=;
 b=D7Cg5EdzRXSRj6S21AOQH7WWEbX08EyPpfVsiE2uxhjOSU8TGUevLc/WHT/vEG89Xjj416l29+1YaZcRgSv9CSzH2PmSOurVYgDXhwoQ+FnawCpJKOfPvVR/OAZohwgO0AhJ31XyqkwCGIf1YZkUmfC1lYnGlVzGPc/lVRuYPqLs2Y7a/SvTqUMBWVXg2pCrJdnKH8m7Mx9C9JUL3KAo2t3/HT5oPmILjncj3MWT5ZSXH9ihI+WjqBne7Xs0j8tTZDcm+wbOyLtbtLtDnRfGXboxQ0h9i4NCwLUE5m6LVGCuzC4fRFXfDv8kUCVy3AqrtzmKveDyDJe1ATDX3XnrKQ==
Received: from DS7PR03CA0246.namprd03.prod.outlook.com (2603:10b6:5:3b3::11)
 by LV2PR12MB5989.namprd12.prod.outlook.com (2603:10b6:408:171::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Thu, 20 Mar
 2025 17:51:29 +0000
Received: from DS3PEPF0000C37C.namprd04.prod.outlook.com
 (2603:10b6:5:3b3:cafe::61) by DS7PR03CA0246.outlook.office365.com
 (2603:10b6:5:3b3::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.33 via Frontend Transport; Thu,
 20 Mar 2025 17:51:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS3PEPF0000C37C.mail.protection.outlook.com (10.167.23.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Thu, 20 Mar 2025 17:51:29 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 20 Mar
 2025 10:51:17 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 20 Mar
 2025 10:51:17 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Thu, 20 Mar 2025 10:51:17 -0700
Date: Thu, 20 Mar 2025 10:51:15 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Yi Liu <yi.l.liu@intel.com>
CC: <kevin.tian@intel.com>, <jgg@nvidia.com>, <joro@8bytes.org>,
	<baolu.lu@linux.intel.com>, <iommu@lists.linux.dev>
Subject: Re: [PATCH v10 06/18] iommufd/device: Add helper to detect the first
 attach of a group
Message-ID: <Z9xVkwu62tXeLSsJ@Asurada-Nvidia>
References: <20250320134744.5777-1-yi.l.liu@intel.com>
 <20250320134744.5777-7-yi.l.liu@intel.com>
 <Z9xSO6pIPZZLP4lf@Asurada-Nvidia>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Z9xSO6pIPZZLP4lf@Asurada-Nvidia>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37C:EE_|LV2PR12MB5989:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b4449c1-b23a-4335-101a-08dd67d7d7c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Dw5mcs6Qn7O+NQDEbuHHMxwAywWXY/HTjR8I/Mxqc6laMNmh9Ti/cSkyJeiP?=
 =?us-ascii?Q?UyUVN9FjVbUoe6NzWDFxLRqRp46zfq2LHe9Qnr5YeqaQxwc3hzU4N5vhZ2UY?=
 =?us-ascii?Q?WfdPjYU58NI4Eedh6mrx8A2mF5civDeQ4bxvL/UG7q011LazhOGUXslJ0Eo0?=
 =?us-ascii?Q?LJHXF8fcKBkUAgRFMH/l7Kw1G2tg8qWCjPVK/tZXhMnXFmRIwoN+w8UCGn/B?=
 =?us-ascii?Q?gT9UvW6Lh8Wz1eZFtwHLO9Sg+pZrdFMzNji1c1Zv7W9rFXMJ0+7os2/Kuv4Q?=
 =?us-ascii?Q?QxihVIZ4gBgOy15lKRDGRS6x5DgCYWMrNCI5+Bb0DzMeetv4SsVq1D3WGdeL?=
 =?us-ascii?Q?48uxZgg4xZBBu4VccbWFn4IUVHFab71jEkS/uis4Rqi1h/xlbHGYCo79pzuK?=
 =?us-ascii?Q?Opy2mNeE0LqAyoL1bJWl4Z/J6NDbbbajoZuMka5jPex/AxvIBRZ5EM86pK1S?=
 =?us-ascii?Q?5wU6iuVYYnTgkzLhuGCbUX6hqWKe7YzMrt2gWEPrd8d9wfG1K0lpFL4LIWBC?=
 =?us-ascii?Q?N0+2+VBjr2gR+u9LL6VlEjGHreswX0jmtEWDJ9Kjq3iK2izAJjNBulKT99fG?=
 =?us-ascii?Q?DOo+oVhyV4CpzDAHKbNYJrXT656k2q9v9PQRPTRHDr6LlxCLqgX56t3EiH1J?=
 =?us-ascii?Q?cOsMJX7MpqDLPylavhQt4wS+ClGZtEa3TvnCtc/6SnuDAQv+pA+XQaaP1x3Q?=
 =?us-ascii?Q?ki5nlC25PFp4YKJMNCs5htfqGzr9OXV+DGxtQA0XH0gZdify2u3T1KgSLLmf?=
 =?us-ascii?Q?pojsCXqo0P99EKKgBf3Pyp9LISFtvHseTlGYm7LBFgLob0hoUDvmjHphuGoc?=
 =?us-ascii?Q?tWxvsogHIO3nr1Rc5HjjQxXI2w77uf1fJN2ke7oNWUcR1/W8kdBJg9ipKbov?=
 =?us-ascii?Q?QnsKi8OlFK+y/0bmY/F9hQDLlAw8sinqHfJinpCK9U5YhHeCR6QwjYC9cN2v?=
 =?us-ascii?Q?5wFF9U3K0GZKCpSH2OYInP1LO+wrQ9ffe/X5Mu7rl9gofHPrMiPkGcnfHgOl?=
 =?us-ascii?Q?IzxiHmMun3HR9g+9SyChjqA1tJZCbphU5GGq8/xY3zjkDyjS4hUbcdor2tXj?=
 =?us-ascii?Q?XM6fMHyh+uJV08S1sGL/Ok/HUmIYvOYh9Q6nrqlkmM53h54JRoDF3qfzjmRp?=
 =?us-ascii?Q?SBvAqqVQaNEfmxo/CG5gEabz8hVXQZMkqyH6rLfZXhJzb1h1QD9QyCH1TpMJ?=
 =?us-ascii?Q?Pox02mfH+jUqnOzCqPbYxOhMCGPJz217XG0OokCkrZxtQs3x3KVZMqvXe9CH?=
 =?us-ascii?Q?BF0HWJd+PwioyzlrejmadDWfx9IeT4nBXl9amXLlYeR0eWi/FeY/6aoBTv6Y?=
 =?us-ascii?Q?oEh+7vTcHKD80zz3D41HgOP0+wB4IoM8XNfXEKgUYK9FfTg/8SY3hfAi/fts?=
 =?us-ascii?Q?yDBrrfQmganFJxUPP9xPJigmvXwNWgmhpj27bABry62W3cC7VxkZs8+dWuxu?=
 =?us-ascii?Q?YcZoCo+srKwD7UFs2j9/Ci/4Cx8Wg7yoMTebU5xioICl1BeLSZ/9cJhpFKid?=
 =?us-ascii?Q?fhFQEwhqWZke5uA=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 17:51:29.0586
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b4449c1-b23a-4335-101a-08dd67d7d7c3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5989

On Thu, Mar 20, 2025 at 10:37:01AM -0700, Nicolin Chen wrote:
> On Thu, Mar 20, 2025 at 06:47:32AM -0700, Yi Liu wrote:
> > The existing code detects the first attach by checking the
> > igroup->device_list. However, the igroup->hwpt can also be used to detect
> > the first attach. In future modifications, it is better to check the
> > igroup->hwpt instead of the device_list. To improve readbility and also
> > prepare for further modifications on this part, this adds a helper for it.
> > 
> > Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> > ---
> > v9 -> v10: It is patch 07 of v9, it's reworked hence renamed as well.
> > ---
> >  drivers/iommu/iommufd/device.c | 11 +++++++++--
> >  1 file changed, 9 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
> > index ac54d734b819..9db36346328f 100644
> > --- a/drivers/iommu/iommufd/device.c
> > +++ b/drivers/iommu/iommufd/device.c
> > @@ -444,6 +444,13 @@ static int iommufd_group_setup_msi(struct iommufd_group *igroup,
> >  	return 0;
> >  }
> >  
> > +static inline bool
> > +igroup_first_attach(struct iommufd_group *igroup, ioasid_t pasid)
> > +{
> > +	lockdep_assert_held(&igroup->lock);
> > +	return !igroup->hwpt;
> > +}
> > +
> >  static int
> >  iommufd_device_attach_reserved_iova(struct iommufd_device *idev,
> >  				    struct iommufd_hwpt_paging *hwpt_paging)
> > @@ -459,7 +466,7 @@ iommufd_device_attach_reserved_iova(struct iommufd_device *idev,
> >  	if (rc)
> >  		return rc;
> >  
> > -	if (list_empty(&igroup->device_list)) {
> > +	if (igroup_first_attach(igroup, IOMMU_NO_PASID)) {
> >  		rc = iommufd_group_setup_msi(igroup, hwpt_paging);
> >  		if (rc) {
> >  			iopt_remove_reserved_iova(&hwpt_paging->ioas->iopt,
> > @@ -623,7 +630,7 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
> >  	 * reserved regions are only updated during individual device
> >  	 * attachment.
> >  	 */
> > -	if (list_empty(&igroup->device_list)) {
> > +	if (igroup_first_attach(igroup, pasid)) {
> >  		rc = iommufd_hwpt_attach_device(hwpt, idev, pasid);
> >  		if (rc)
> >  			goto err_unresv;
> 
> We have the same list_empty in the iommufd_hw_pagetable_detach()
> and iommufd_group_release() too?
> 
> And I feel "igroup_is_not_attached" could be clearer, as it fits
> the detach/release context too.

Oh, I just found that the following patch changes those paths.

Yet, at the end of the series this igroup_first_attach() is quite
similar to iommufd_device_is_attached(). So, maybe we could align
with that the naming here: iommufd_group_is_attached?

With that,
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
