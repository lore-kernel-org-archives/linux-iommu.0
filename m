Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010040.outbound.protection.outlook.com [52.101.61.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA08E3603C3
	for <iommu@lists.linux.dev>; Thu, 12 Mar 2026 14:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773325517; cv=fail; b=Oye52fY35R7/pai/4i7VH5Cl7tp9VEcU2CLbuqILGbgxhDE9EJJK9JuIbiOo1sQbG1YMPRlkw3ub7vtvKDfG7sImuBUYPs/GG6ThISrONivivcAGnMIaYZ1v9861tziSWCnYp9sJnwAds11Nu9GtaZ9XBx31XQG5PXFqOznkwns=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773325517; c=relaxed/simple;
	bh=lLahY9NbyusxY8bh+OmH2ZWcfd9Df7u5QMYJZSJnFFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EHTkjmP/lVOhKkElcfmR4TqUgskZvkoEgZUf4v4Y/CVlt+vB4B7iBTtj51VEvIKIwijby5+1ya1Y/sAvzTYahLaHWxkxM/e0dBtaJaOYlD5CN3L/Ul4AecFGWjeCba0Dp1VhoRp4xj7jSh7nGYfdKjqST9WpVg2XHMu+40cAaPg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qcYhoFau; arc=fail smtp.client-ip=52.101.61.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qcYhoFau"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jBzW1QS/Hlg91VAMqRj+fs6yEVLDNJs5HHhCrPRQW9oXC+Pm6XbFPf5iIKdw7cMYmtRy+88PVdDjiyTHwv4BTKrruzHQpQf9z0uC2qMkgbkuGB42kd5T0ghGgjQav1w5FPifh7D78SbL8/m56r6dVE5m8NlZndIPeOBaVT6M7zNjYaPEDg8KLXeBxCb8rDjZlT0gHIdUxq6UJQsflcErAYaT9ODTp/oaLlkK51l4qmmOC+R2YdCuj45sdkgMlL9WpYd2YtaHwVByyHAgI0IVNaxGl8yUcXIi2YDWCMksdSbLoxYVGHzvNr8bB/h3nDaBoNqHrEKvsVhS540Nk5H7Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bav5cnaVJjgsE90sUHCEPDMaHi8+85fVbsWclBM+M4s=;
 b=zPcVnPq0TJ7HQysUSKAx+5zlPyPChlEfAjIg1JtC3HY/JtvqwwJ9eotPH2U9XxwKox6r9T2o2Oj6n1tZogwa+uXCNSuavclbHzYuCl+SU+1ZXrULUpMVVrjHh2gQsAJMbnteBaFbjEnNwAqE3GDSBQUs6rK/c/nUQSLWVJWFfRr2xb9Zea6kI8CslkLcGz+KfuB32+wJN/xJDVRnjfDLFKjcMZbd64iWf8g8Dh6WkLKBNLt3ZER6UEyD35alSCjtUzfkYaKgBBOdefgz34blJ1DwdAv2bIczKqrl/tPmQixbKv+Vb2QS7SQLLetFUJR4/YXXvbI/RF+1fPmwaPDDhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bav5cnaVJjgsE90sUHCEPDMaHi8+85fVbsWclBM+M4s=;
 b=qcYhoFauLOo/mCiU0c93SialWAFZQu/B/doifSfbZsMYdzKMAR8joJGVRoGw6M8fFMpaA/TF+Lwm1RrHKrzhM3SWokuRpv7ka2HAkKT7gGlnqV0Iyz9N6wvPY0kHi79Puw66J8GN5gScaxHq5X0a2Mm3m2OYRf1EqAi6lHBR4Lurv4Qnbi7yyaY+yM3kKyrxRH21RjItMJVaJ1Q9V7lssqohDZ1W0OtBcTa3z0iPbwlnuzd+r/o9fp/Smsh9b274kVufclqYOKJf+L8jUt7C55JWKzlEvLyJlIQBM6rRYiqiu8fZXOujhE41b0cC9zsnxAE9IA/lJOreOTDcwTucMw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DS0PR12MB8341.namprd12.prod.outlook.com (2603:10b6:8:f8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.6; Thu, 12 Mar
 2026 14:25:10 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9654.022; Thu, 12 Mar 2026
 14:25:10 +0000
Date: Thu, 12 Mar 2026 11:25:09 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Will Deacon <will@kernel.org>, Lu Baolu <baolu.lu@linux.intel.com>,
	Kevin Tian <kevin.tian@intel.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, robin.murphy@arm.com,
	joro@8bytes.org, praan@google.com, mmarrid@nvidia.com,
	kees@kernel.org, Alexander.Grest@microsoft.com,
	baolu.lu@linux.intel.com, smostafa@google.com,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, bbiber@nvidia.com,
	skaestle@nvidia.com
Subject: Re: [PATCH rc] iommu/arm-smmu-v3: Drain in-flight fault handlers
Message-ID: <20260312142509.GA1586734@nvidia.com>
References: <20260307001723.964956-1-nicolinc@nvidia.com>
 <abLE3rdM9YAu81tq@willie-the-truck>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abLE3rdM9YAu81tq@willie-the-truck>
X-ClientProxiedBy: MN0P223CA0007.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:52b::27) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DS0PR12MB8341:EE_
X-MS-Office365-Filtering-Correlation-Id: 7aad57c6-5fcb-45ac-0609-08de80432a92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	2N68ywPb/f28ta5D3LFCIImqgy7ebVVvgTOI698gGDKSpq3hinnNBi0wQIJSrYGTUg3dWb6X+dgNHZpbxHE7HN8CqDpO3X8aQ54o2B5mZYdDwsoxAYTAMNcharGAig468Pp5AhBOLTdIgcRqUo1NGDqjT9M4TilkmGcb3lvVv19pSNo7EbZ/zwMhiucL5cGMamuIPG1KHYOJKOZGeOTfypZisIoVweC7uKt8UeDopLLknkHxbb57x5R6YZ7MZLvTMrMJWH6xKLPbWFdk1i2XMva3XzJYy7C8LzPNxR1Q5G2DMl7IXxwpqCueGIxLi9tl0/nwZZEn/BB49tDrzN9d3/fS0sf2h6hBQqdxt/7CTbpu/7/Lb2IPUqonECppbb1nfmLDYwiKlwLbPU6nEZzeLqJo4SlPdGThoHPbW19xmEerf5homvJ/8h3wPJBmq0FsypH1jaEg3GvEbHJaNRoft6eWblPZq0C/QOfNDQxUlT39CFD/gWEUsV9D4laK2C36UZdxDiMBDyA3/5C59FStge3+RFHI5CuhYXTjiYysrbJR2diItIsZEXYibycBYCW4Nlphs32AI+K6OPVnjxB/qaJst5PPzKprA+SEad9ttiIM1TEcOHo+7TjjxOAm5c2eXBLRSYHxM4fySZ7ihQFXNiFme8JMqKyWf+QQhuYuPhtIny6fFPryAPPf2M+I+xFmtS3VwnDkfN7f7oG0CUK8Djp5N+oZzQDAW7jGfU5Y/mI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iE/sWu7Gfa66UL1zLCHalHU7/+FcfraAFYjYMODRTe3+2UraS6TQsCx05uHF?=
 =?us-ascii?Q?aIJwHw0oSP7FKwZsI3yIpfhcW+OSFZUVh76wEHprnwOfKDAEzUOYCXbki9Ap?=
 =?us-ascii?Q?oKlDgRpDTzzsBeQwRibP5W8novBeZS1VmaO4mPnHy37M+fKN+BzkRUeK4FK4?=
 =?us-ascii?Q?UyIDAg2njTNkyy98RdNCosimkUFIvEhSebO0/tMg/oP4nNClMdGH6J5hzvBZ?=
 =?us-ascii?Q?Aegv29Gdz89plCfXkz8sQ6FbxAkVAQrxnFi///WZq9JY77VKtDfT89/K56pk?=
 =?us-ascii?Q?KUIad0yBfG+/WK2bMRW8DziNfw1anAoV7FriurCByAv/pACBWWCljDsAzofv?=
 =?us-ascii?Q?jOx6kDAcsD4W4YpdCsY2MLm+bowdBqCK13kXFpl3Ee7hLor8H9Mjp9mz2kds?=
 =?us-ascii?Q?Fh8VuPj9ZzjpquNOfJ8gJNAgXMHD6gwlQFA6YAUuexGD/SP0Vh0dyfQnJ6Y9?=
 =?us-ascii?Q?D+OGaKOEcXQtkidf5ve/7R3lpTu7O6I/jfT0VpEY+0iElMwjM5gbIOnjdpHP?=
 =?us-ascii?Q?IxhXjTGqj9TURwpvU37EPqGHG8PLkvTePxPEFOQTdF5savyRwEYKPkVhtT3K?=
 =?us-ascii?Q?xT4QgMlGjcd9pyy5hTBg8PBCS3IyNoBcYTee+n07VLOpGuxpFibQ35zRLNHj?=
 =?us-ascii?Q?bBmN7H2Ay3lutDph+7pIfch42J4o2Y+AcjOzD62ogQl2fwshtEx4gv3hZcun?=
 =?us-ascii?Q?7rKglcBApqwaX67Pxxpul4mUih3ignXl7J3xQVjcR4f71C/PZIsImY9V4oyd?=
 =?us-ascii?Q?yQE5HDdRqtjHpliN35Nd5aRdGLWBd2OV322oT31mQNmd9CfGs1xGI6oEAuU5?=
 =?us-ascii?Q?Y+38/z8HavUBJK1m182H8hQ2mibHNxVRXJ2vNigxex5+SqmdFbiHYitbKUAE?=
 =?us-ascii?Q?DXonVUmmIcwJdeKur13tgUIcK+o3/yZr4r36ao4JcOLEdE6oJe+q4uwfNFX+?=
 =?us-ascii?Q?NVg8mjUdBTfyyspF32C9O2srX6ulhk9bhxUpVVIYd/Ml2JEpn1BLq7RPsKp3?=
 =?us-ascii?Q?ViXO10gmnl6TNzdEdstaziJ6TS+dKzoPIua3+YRJ+4yNiyUfiK7Z8zL4GMJI?=
 =?us-ascii?Q?BP4RXO5Iqyh9lvCXBA9INgizt/rZFfqoXyUGjdl86AbwS5PBT5/CvgCtNv+X?=
 =?us-ascii?Q?NCge1lSNVXCl+TieM1+XZV9tgD1zgyn9dK+MdNVI4uNNqS9l3zRRjcrFGW7A?=
 =?us-ascii?Q?v0T4/jMfznY+/jbQB+QKGlYHq1CrEMaOs00IhNgQKh17ceF8J9qdASkfD+LG?=
 =?us-ascii?Q?vcNOdgKUl4FfnKEl9xgGKnkjDszKmW0gk81dYg0cIfipeCt3TcCVRhgoOaec?=
 =?us-ascii?Q?LidRHKAMXv8tOMFFCQUhEe5kvjGn0hE3urTuEVGXJwCyHtMfmBu0S8ByHyV4?=
 =?us-ascii?Q?cQqAHWbaA7xuZF3hTfrgJNI01jILN2fB7INvIxorY6G/Q22JdfWhDPAnPQ3k?=
 =?us-ascii?Q?9qg9lv5jZ06z63NExge9GBSpz/obqOOJ+xCoV9Jeg+5e6OEDORQvWnDWMhYF?=
 =?us-ascii?Q?Txy3tvlTTdOak1vK76480hVImJ44tjHcLqSW1st0IQ9pQoj+mZtvBthALsTD?=
 =?us-ascii?Q?APtkB3SPaP3e2H2TmUpA0QSZSp8Rm2WIkXSK26hU+3IvFB3gEJEqmUuzn67U?=
 =?us-ascii?Q?gWT11ABfb7WhkY+glwP/2adSiWZ/G4zhhTxgEAGmm8EH0knKqSC/Zt1THm8U?=
 =?us-ascii?Q?XEA+MobGXgPv1sW8u7i4N5g6vXNGj0p+MJw6krjuBaQsQ8O3KyhKcD+DLepO?=
 =?us-ascii?Q?UIUad+yFZA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7aad57c6-5fcb-45ac-0609-08de80432a92
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 14:25:10.0660
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KM90yTrER7KfPdIBVRyNqrUldpJf7FnIHM1NDQ85OLNWtFO0IPQ5CO8boh8WD+Xq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8341

On Thu, Mar 12, 2026 at 01:51:26PM +0000, Will Deacon wrote:
> On Fri, Mar 06, 2026 at 04:17:23PM -0800, Nicolin Chen wrote:
> > From: Malak Marrid <mmarrid@nvidia.com>
> > 
> > When a device is switching away from a domain, either through a detach or a
> > replace operation, it must drain its IOPF queue that only contains the page
> > requests for the old domain.
> > 
> > Currently, the IOPF infrastructure is used by master->stall_enabled. So the
> > stalled transaction for the old domain should be resumed/terminated. Fix it
> > properly.
> > 
> > Fixes: cfea71aea921 ("iommu/arm-smmu-v3: Put iopf enablement in the domain attach path")
> > Cc: stable@vger.kernel.org
> > Co-developed-by: Barak Biber <bbiber@nvidia.com>
> > Signed-off-by: Barak Biber <bbiber@nvidia.com>
> > Co-developed-by: Stefan Kaestle <skaestle@nvidia.com>
> > Signed-off-by: Stefan Kaestle <skaestle@nvidia.com>
> > Signed-off-by: Malak Marrid <mmarrid@nvidia.com>
> > Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> > ---
> >  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 11 ++++++++++-
> >  1 file changed, 10 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > index 4d00d796f0783..2176ee8bec767 100644
> > --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > @@ -2843,6 +2843,12 @@ static int arm_smmu_enable_iopf(struct arm_smmu_master *master,
> >  	if (master->iopf_refcount) {
> >  		master->iopf_refcount++;
> >  		master_domain->using_iopf = true;
> > +		/*
> > +		 * If the device is already on the IOPF queue (domain replace),
> > +		 * drain in-flight fault handlers so nothing will hold the old
> > +		 * domain when the core switches the attach handle.
> > +		 */
> > +		iopf_queue_flush_dev(master->dev);
> 
> So this drains the iopf workqueue, but don't you still have a race with
> the hardware generating a fault on the old domain and then that only
> showing up once you've switched to the new one? What is the actual
> problem you're trying to solve with this patch?

HW doesn't generate faults on domains, it calls
iommu_report_device_fault() which calls find_fault_handler() that
uses iommu_attach_handle_get() to find the domain. It then shoves the
domain pointer onto a WQ.

The ordering is supposed to be
 1) IOMMU HW starts using the new domain
 2) iommu_attach_handle_get() returns the new domain
 3) IOMMU driver flushes its own IRQs/queues that may be concurrently
    calling iommu_attach_handle_get()
 4) iopf_queue_flush_dev() to clear the iopf work queue
 5) domain is freed, no pointers in WQs or other threads

So the naked iopf_queue_flush_dev() doesn't seem right, I'd expect a
synchronize_irq() (is that right for threaded IRQs?) too as the
threaded IRQ is concurrently calling iommu_attach_handle_get().

Next, something has gone wrong with the ordering of the xarray stores
in iommu_replace_device_pasid(), it doesn't follow the above since the
store for replace is after attach and flushing. Not sure how that
happened, I remember pointing this ordering out at various times..

Maybe we need to add a dedicated driver callback that does 
#3 and have the core do #4 internally. The driver shouldn't disable
its iopf during attach, it should happen in the flush handler.

> > @@ -2866,8 +2872,11 @@ static void arm_smmu_disable_iopf(struct arm_smmu_master *master,
> >  		return;
> >  
> >  	master->iopf_refcount--;
> > -	if (master->iopf_refcount == 0)
> > +	if (master->iopf_refcount == 0) {
> > +		/* Drain in-flight fault handlers before removing device */
> > +		iopf_queue_flush_dev(master->dev);
> >  		iopf_queue_remove_device(master->smmu->evtq.iopf, master->dev);
> 
> Why doesn't iopf_queue_remove_device() handle the draining? Is there a
> case where you _don't_ want to drain the faults on the disable path?

Because it isn't needed, this hunk is redundant.

We never disable iopf on a master that currently has an attached iopf
capable domain. When the domain was changed all the required flushing
should have been done - there should be exactly one
iopf_queue_flush_dev() inside a driver and it must be inside the
attach flow.

Jason
