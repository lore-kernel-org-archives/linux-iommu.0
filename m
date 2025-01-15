Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2079.outbound.protection.outlook.com [40.107.102.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B2E22DFA4
	for <iommu@lists.linux.dev>; Wed, 15 Jan 2025 05:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736919646; cv=fail; b=aWf5oR2PwziYumLiYUMS3F2Gr3V5bqHVH4b+JwzVeiMjkI5WxbI40ByRLb+Leu9VtLfyd1CI0VSECcXT5BnISovVpzunN/nK89YG+VPmd9f8RgsF4LEixdqTbGgA0uERhNtYOzSo5SLTE1Ket/hP1aoHexbhFRFAqJfbgNFHeMA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736919646; c=relaxed/simple;
	bh=EFcko16eIEFVtO7wVqap8sCZdkgagZ6uuPpMXtkNSCQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IM4nqhx3WOHywRbeMO6IqqulFZjPZsnCdTtz1M+2XDpIl5gTG0WWGLwixqrEsWMc8G0I27qQT2sZleU3ucRWJzV2LT8x1rfZgKZl+IIrji1x7LYAQ3LpXrzLNG59ejwjUAMcyF/EHpb5wBT5HKTe+RXxSYv0+lZaD+EBEfHe5po=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=V9dCSUmu; arc=fail smtp.client-ip=40.107.102.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="V9dCSUmu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kB+mZ84m8p5bPTZAZsib+sgVsBPsl0PSdK+SV0Ll3RQ9escbriZ8W9BR3D8BSexujdb1T5B1Ibw68HW7880ryRu61SqfZr6aU7GxhQhKForu1unPzCmZu4R+eqGaaPNwOamuzcSoQkDDuQqBIHHpXEKwRIFiWDLKXe1Cf967izQNsWWj1yobxxu/4urdHYt474kIl6DWmVwaeLksJZ+3VqCXfLIiCNe5JAs9JLNqLz84sJvY3liCD/DBiTbH8BYY0fFajE1+63kmDDEMgRM8lnNa/cMWkrFikayTRaAe8sJfl7IDwOPMicRHkQ7ZXzd+VGUanudLRrP8qDrHID92fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n7hZEXdrtOy2Wo7dLXBHGFWZmUTpED+9Orn3i1EXDWk=;
 b=m5/GsDsY5VZmzZyx9UY1x6xVDJZNJzgMWiaSRrtZBqg5RUb3E/3QHGTPyO2tQycNE9k9s0KD5sbW3Cn8ZNt9LXWCbBdARxwSrIxWxo3zX7wQVGoor8Tx64fDtj7FXVO0+9WlUffdIGrh8R0bDnJmGaIrcMXKYMifTIXELgRhqjAirR0kMXdNPSG+xzGcpewQ2Ni5xiiBzhGk3jGuULwFtVwkwMMV0zU2EZd890lNrDxu2na485NbHrSQ6bjFJQCFtL4v0en5ToviQibFzJDkCnrKQHVLHuXv3NjH3FqfsMxMeB2QTy983CpnCSCeJ3+xLv1dPV14Uv7xGrNffb20Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n7hZEXdrtOy2Wo7dLXBHGFWZmUTpED+9Orn3i1EXDWk=;
 b=V9dCSUmu1VeI12gB631lYz5yVhJcOHMjmtFC53aGZdbqPgetzMV669cMju9Xj1L+tvhFyk/i0ahBL6mqmoMi/jqM/OWMX6uif0RwoVUoSJNGuAob7FtgMq22Uduk+GUfVBpVscDkQVA8BQkHW31DTxEmbFSk2OJdUKAEGXJKHIUrUen1pJcVtB8JHkfq4N3nE8EO4CmNizM/aDW02GlpbNlmRQ6QlArY/HImb29sCH4Ohad+JoVya6rj1MLTw+hUu2gGYFBgI5hiMbv37nMTytK/AFD+TM85C3odOkGyrj51QJZrbq9t5SKe7QkZWaNHPqWWl7mubfDD8hcX2CUz3Q==
Received: from BYAPR07CA0070.namprd07.prod.outlook.com (2603:10b6:a03:60::47)
 by MN0PR12MB5713.namprd12.prod.outlook.com (2603:10b6:208:370::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Wed, 15 Jan
 2025 05:40:40 +0000
Received: from SJ5PEPF000001C8.namprd05.prod.outlook.com
 (2603:10b6:a03:60:cafe::e5) by BYAPR07CA0070.outlook.office365.com
 (2603:10b6:a03:60::47) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.19 via Frontend Transport; Wed,
 15 Jan 2025 05:40:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001C8.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8356.11 via Frontend Transport; Wed, 15 Jan 2025 05:40:40 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 14 Jan
 2025 21:40:26 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 14 Jan
 2025 21:40:25 -0800
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Tue, 14 Jan 2025 21:40:24 -0800
Date: Tue, 14 Jan 2025 21:40:23 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
CC: "jgg@nvidia.com" <jgg@nvidia.com>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"joro@8bytes.org" <joro@8bytes.org>, "will@kernel.org" <will@kernel.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>
Subject: Re: [PATCH rc 2/2] iommufd/fault: Use a separate spinlock to protect
 fault->deliver list
Message-ID: <Z4dKR4ORF/FcfCSD@Asurada-Nvidia>
References: <cover.1736894696.git.nicolinc@nvidia.com>
 <56c73c27b572e9c677182e99b5244184bdef7541.1736894696.git.nicolinc@nvidia.com>
 <BN9PR11MB52769D7C88B3DBBB4DF3A0028C192@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <BN9PR11MB52769D7C88B3DBBB4DF3A0028C192@BN9PR11MB5276.namprd11.prod.outlook.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001C8:EE_|MN0PR12MB5713:EE_
X-MS-Office365-Filtering-Correlation-Id: 01da9ccf-b58e-4a74-0b0d-08dd3527254a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cnrL2lEvgKBtR7IOPOw2lu0ZNAj+Fa0OIBG5d7BR8rYPFRTn+3lvSoMaVmXq?=
 =?us-ascii?Q?WLwtomRXCVPkIuhxSZOKXbjf03jYyEjTWisu9izD63jBslFcCwTIjCLwX52E?=
 =?us-ascii?Q?EqulW7uSvNU0kyV9z6dYjmHicLaGqYJc4xsBPaW5UN3MT+1vvKniMsvolLN8?=
 =?us-ascii?Q?AWgFldtDIv/bVTzGvkJaLFp0uco7p6431JmCV33uwFLyPrfWOUn8By9JW7CK?=
 =?us-ascii?Q?NnLyPYWB0rPtut/TrjBbUNvJm3pRruYWhZIz6LGBKty3xPV/IudLNJkWIElb?=
 =?us-ascii?Q?BhRJaFXOwq8CBVbFpOhhgohiYofOJKdL8K6dI1800fRQyzP8RtQTzmWua0rf?=
 =?us-ascii?Q?bCkJuYlHsQFT7LFEsjTxe9v5+UD0PPKIRfRYTzSRDccR2yyMPA0dPjNlewwO?=
 =?us-ascii?Q?bsILwjheKrPky59NQNQ+S2QwUorGH2bLlmh97taWHpmg7xxx5EV9FN5sbdid?=
 =?us-ascii?Q?jEaq0XNByv5X+fY4vExtFqvLz+l/n4XnTx0HOs74xp+4wlReZ69DdlUJUgEM?=
 =?us-ascii?Q?RcvL1ttGUbE4K8NgY0nKpp/uL58p9XawgNbdmMQLrjsF5orYrctUd85Cgu3g?=
 =?us-ascii?Q?T5eu2LhXYx3QxyDsIdkFaN5cknNOOeaEfUBeEIgQ9cXcrXFHhKnsrcFLgAlS?=
 =?us-ascii?Q?aaMSBOHE1TgypoqPmaVDrWQxg3kapCVJpXc11TvnE+dbutc1J0EAr2Ip8ZYb?=
 =?us-ascii?Q?GCrhTUZ+GV7h4bEc/0YNrSL+Zb64ik4ULARVExeD3lThmyY5st8L71s3Wu/m?=
 =?us-ascii?Q?i8pOdgwExqYISI8scGkyBgCRGyEPWJ54aqh3iEIgfAx1AgJlmhUdk64MUD8a?=
 =?us-ascii?Q?k8sUkH6RjdrV/i40K6Anp1L/Aw548wsGyoXVcnwa3khNjkHnrrHzCu10gIdd?=
 =?us-ascii?Q?NOJAMP01i4OhiWx+hdt/jPQw/23PYx8JV3teSuBRm9B7GtK+743+5mFKTXEI?=
 =?us-ascii?Q?0PpUP4Hq9mIjQn0UQ+fmWW/+FS3NYr/UmuRdkNKf3xQQb6lc9iUaexKFb8ql?=
 =?us-ascii?Q?Z7G8b6xCHd8zw4KtpN81HuhsYynhh5LQRiZnejm4vNSibgO8VHQnIUGDxHxz?=
 =?us-ascii?Q?K1olY5jkZ+bAbnl2iZpMLx2Jt1hZmLPaAzQRAz44NK2NH5im2Pjbczs5AzCI?=
 =?us-ascii?Q?MSFXKIcxXXSZvkvf9zN8r+JuyNhWcbSjJRgzu8yEZgp0tTN0MYo6kpl+Qv92?=
 =?us-ascii?Q?XELPDLdU4HJHPudXd9pvk6Gf6R+uf5cxmlxJsjPpDoopZB7wfd5MxgLxc1vt?=
 =?us-ascii?Q?al334cHcETPm2H3qwy1o/jxmH9LiArFxFhl/f58nEYpH1cSvgpTvYoJrjqVM?=
 =?us-ascii?Q?c5u/2phkamhv2PWbnYOZRy5hrp3ldYH46IIXHKAFqHGxElq5MPo9FmpwaWtb?=
 =?us-ascii?Q?XgOhJCiOrwLiUJ1wQ5aW+32+LiYHFkIl2uEUbjoWPX5Hk5X7Ivoet53cv43z?=
 =?us-ascii?Q?/3PEHEynvTd78gt8MCHyq8izbrBGZ/iSurTCPLaCxwNKyOKbigOeKA8hJdkz?=
 =?us-ascii?Q?hKQYBLPcdMRGqDc=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2025 05:40:40.0678
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01da9ccf-b58e-4a74-0b0d-08dd3527254a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001C8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5713

On Wed, Jan 15, 2025 at 05:24:44AM +0000, Tian, Kevin wrote:
> > From: Nicolin Chen <nicolinc@nvidia.com>
> > Sent: Wednesday, January 15, 2025 7:29 AM
> > 
> > @@ -445,12 +445,38 @@ struct iommufd_fault {
> > 
> >  	/* The lists of outstanding faults protected by below mutex. */
> >  	struct mutex mutex;
> > +	spinlock_t lock; /* protects the deliver list */
> >  	struct list_head deliver;
> >  	struct xarray response;
> 
> Move 'mutex' together with response then?

Ack.

> > 
> > +/* Extract the first node out of the fault->deliver list */
> > +static inline struct iopf_group *
> > +iommufd_fault_deliver_extract(struct iommufd_fault *fault)
> 
> Probably simpler be iommufd_fault_fetch()

We have deliver and response two lists. So I think that "deliver"
would be necessary. Yet, I can do "fetch" v.s. "extract".

> > @@ -102,17 +102,19 @@ static void iommufd_auto_response_faults(struct
> > iommufd_hw_pagetable *hwpt,
> >  					 struct iommufd_attach_handle
> > *handle)
> >  {
> >  	struct iommufd_fault *fault = hwpt->fault;
> > -	struct iopf_group *group, *next;
> > +	struct iopf_group *group;
> >  	unsigned long index;
> > 
> >  	if (!fault)
> >  		return;
> > 
> >  	mutex_lock(&fault->mutex);
> > -	list_for_each_entry_safe(group, next, &fault->deliver, node) {
> > -		if (group->attach_handle != &handle->handle)
> > +	for (group = iommufd_fault_deliver_extract(fault); group;
> > +	     group = iommufd_fault_deliver_extract(fault)) {
> 
> 	while (group = iommufd_fault_fetch(fault)) {
> 		...
> 	}

Ah, right...how didn't I see this lol.

> 
> > @@ -266,17 +268,20 @@ static ssize_t iommufd_fault_fops_read(struct file
> > *filep, char __user *buf,
> >  		return -ESPIPE;
> > 
> >  	mutex_lock(&fault->mutex);
> > -	while (!list_empty(&fault->deliver) && count > done) {
> > -		group = list_first_entry(&fault->deliver,
> > -					 struct iopf_group, node);
> > -
> > -		if (group->fault_count * fault_size > count - done)
> > +	for (group = iommufd_fault_deliver_extract(fault); group;
> > +	     group = iommufd_fault_deliver_extract(fault)) {
> > +		if (done >= count ||
> > +		    group->fault_count * fault_size > count - done) {
> > +			iommufd_fault_deliver_restore(fault, group);
> >  			break;
> > +		}
> > 
> >  		rc = xa_alloc(&fault->response, &group->cookie, group,
> >  			      xa_limit_32b, GFP_KERNEL);
> > -		if (rc)
> > +		if (rc) {
> > +			iommufd_fault_deliver_restore(fault, group);
> >  			break;
> > +		}
> 
> The scope of mutex can be reduced to just protect the smaller trunk
> touching fault->response.

Ack.

> Otherwise looks good:
> 
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>

Thanks!
Nicolin
