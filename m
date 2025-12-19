Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010013.outbound.protection.outlook.com [52.101.46.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 651993446C5
	for <iommu@lists.linux.dev>; Fri, 19 Dec 2025 18:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766170574; cv=fail; b=ki9hCh0FuBK96x+y3SiGxRVkV2zwF1pQDxfAqz4PqX4ehtXYj1XCN5lpabydaw38mR5kSl/8E4SDVFHYIo+6Up/lcHDO/29LyMjSBI3qfOoYPgslyhgT08ECfSV6sx5EH3JXkozZslotFQxCr8c+71P7fgYXG4mkOaNqVeXDbNI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766170574; c=relaxed/simple;
	bh=eWnuBFa5gfZPmQJhCfhIPLTsrYVghAX2S9s/EOUn/iE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hnlteEpOSFXrDMlgH5P+w6dxx7iqwC2S7tIywUnXgrGVBBwbG3lbEIwQsFx34ytCDr5XPUXEly2cFK1wZIBVRJ/Ep+YQhQWmemtYtZwSQTeL7KDc0Ge51FOEjdxfd7H0m21ksvkAm/T5Yp355BIkIQ0TqkuFl69ndLTNzqaEqTQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YEY5vAGq; arc=fail smtp.client-ip=52.101.46.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YEY5vAGq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FnEbv2kikJjgvciuDWjJmFKe+gmLAe9xvWlQe52vP4rFzrr6sou87la7RjcscB1B0UtoO0oudGf/Xn/LzEjSojdBghrM4IQwV5SQynkOljsxXOizTbUUjwvAmYv4CUKTWQ44wjnwUzUSaD/X180CczPKqXOo58dmIYo2fZqz0Cvr/7hNtivctaNLSBjaFcbOZGNemODdo/ro+YfYzEI0/krkLQyfGy9U9RhO7TSYETSDQQpEOPQ/ifoiicgx25us9xLUBQrJfH7xXI3Ck6cLLQr8wG+NCodKJJI4XMx5rI69TzgAZfwqefI7nYq8YsZ9IyqDPAyfWbF1kzskQ7faZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aze8ZuSXxbk60pjM8zcBTxIC55rtkHgcetSKJnrfygw=;
 b=fSYI5DHyvriDpWNw4gJ0M56GDM0gNPkIKFLPLCYMvelnchS84ct0KuGQEilMjv2UBSVwbq7nV39A6AgAL2pM4fDPnI5t7Ku5ZhaUinO5PAKRQ4s9ESoNyT330iCXp/zlWXtUTPb5X+PYtkaKNKvOzXYcrWygnWKyd1cxIu9s8MgDWM/FC9izZI8aAU0+RUukHbi5Q5u4qXsWJHViIDNhnD/eRVue6D6/YGHO6aKSDw8Zmuho2z0QCwS7y1NAjvxpq5OsByQFUYo3aQpBvBAmcix+1pvfRj6oQQy1Y6n2/uduC83a8UwhvjHFpnQahUODxon+MpWNb3nY1feGl6+6Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aze8ZuSXxbk60pjM8zcBTxIC55rtkHgcetSKJnrfygw=;
 b=YEY5vAGqJLCXxntsDfgoPydAq/o6ejWeHgNk9Y4w0za335QhJoXXp6myGhaWaRRBEwuSNo3mwvTMo1B/aE1EGyww/CNOhMUxkRxJAeKazAjpOJm3mxhky0F9Sa5CxmEvwdd4yuBjlOeeU+J83GkOf2isLKgWIdGyQ4vvoI4Z6l4m5Xnuiz/6qAckfjQLrj3AAYalWJrqguAVSBTaLOp452zi2neh2jSP0kjI3DqEmEIbUTD25KuE6yzLw/lmJj7mm7hcQl5wRYweBFxMTJQigYn1F+KmErEoW/7sTkus99vT0kOE8YjTjaykpj/V+CHmkMIUqDxBDaDbQnj6T4gPWQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by LV3PR12MB9187.namprd12.prod.outlook.com (2603:10b6:408:194::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.9; Fri, 19 Dec
 2025 18:56:06 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9434.009; Fri, 19 Dec 2025
 18:56:06 +0000
Date: Fri, 19 Dec 2025 14:56:05 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, jean-philippe@linaro.org, robin.murphy@arm.com,
	joro@8bytes.org, balbirs@nvidia.com, miko.lenczewski@arm.com,
	peterz@infradead.org, kevin.tian@intel.com, praan@google.com,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 5/7] iommu/arm-smmu-v3: Populate smmu_domain->invs
 when attaching masters
Message-ID: <20251219185605.GI254720@nvidia.com>
References: <cover.1766013662.git.nicolinc@nvidia.com>
 <79cd18a1a959ee2e54683e8c465b799d49ec48b5.1766013662.git.nicolinc@nvidia.com>
 <20251219155151.GA373575@nvidia.com>
 <aUWfVzhVZ+Qo1efT@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aUWfVzhVZ+Qo1efT@Asurada-Nvidia>
X-ClientProxiedBy: MN2PR14CA0027.namprd14.prod.outlook.com
 (2603:10b6:208:23e::32) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|LV3PR12MB9187:EE_
X-MS-Office365-Filtering-Correlation-Id: f6e6590c-c876-468f-70d0-08de3f3043a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?InO+Zu02a4wBKzeuVPtKmej+PgT1Ud3ieH4I3yxm3Ty29IImVrwcfhbSsg6B?=
 =?us-ascii?Q?sX+xGq/Lq1QUdmDiO67xTRAun9iYNfQyTdtDG0bjrI+1BEmGYLmlBxbuP52h?=
 =?us-ascii?Q?/Q2T9mb5eN584uAvD88pxl9Hgws60UfNALw8aaLhUJ46yexNRUgdEFgC+WFC?=
 =?us-ascii?Q?eGV24hcrp2P3M1JiSDCQbzmKbIMVF/ts0+QeHPcZII5K8alr7WJ4xkrZTpwc?=
 =?us-ascii?Q?DKPim5V9Ewv0gpH2gfL1E37HGYize3gB3/5hfxVFEF350V3meeg+hiWJ94lS?=
 =?us-ascii?Q?MFKoeOJDk1fqQNHp7Z7gZvtR+qDILpSuv1km6g/VG8SRAeCIFw2V2ZqoCEiV?=
 =?us-ascii?Q?ibnC8t+dfIOF2rA9vD0dyV8K8zG4opfJztgiYAuNWjZmedAJFAgF03CEI4Zg?=
 =?us-ascii?Q?hmo7OFqHaKGz4TvyxaoEiqdDqBvqmT3ip3jLLPuWQM8W193C1vyKxOLsXCEs?=
 =?us-ascii?Q?XSORibP/SfbmoeVMwfYprqDOT4Uq7BhWk7SfZNy9OtkgmpX5h3btgrVLSqQX?=
 =?us-ascii?Q?qL9mMhgRm58WKhWJbc0zsHxPEJzi/wEJyJSEJpNvJCH5keRJCfdZ4ndADY/b?=
 =?us-ascii?Q?PYC/tVwrUyn8XNmOzJISp9VQJbV6JK+a70eRQWx1t7HxMDoM62pVyusnAOeZ?=
 =?us-ascii?Q?5Nnr20boRQiOUlLMADAGnsF0o54gM5c8oLccZUb58U56ykthgfIvB/rz7L+U?=
 =?us-ascii?Q?Yzymd1brcbkg/PLG7AmwxlMikmj+CFF8h1gMPknql7n32rP9gKOWdkn4St2b?=
 =?us-ascii?Q?6dWbd1iK8H/uT0fGrZabDEgAR0Pi26HvzVNvC9WhNXKw109Whr7KKVk55Mpo?=
 =?us-ascii?Q?Uvmrt6OvkJOn7LdebVhNgVW75eot0bpq0MHXXoH/bGg9vxoQ4IaNvVAO59BP?=
 =?us-ascii?Q?Es8w1gNurtsl8w6q3PF1Q+Z+pHlteVeCHdn90eEoOAWDFEwoRyhwpQ91lgqn?=
 =?us-ascii?Q?cK3Yr88M01ykKSQRfcP7EMg9y9t0t7OpIGjeLiH1Urxp/IPbF2a2Oj0sohm+?=
 =?us-ascii?Q?hb2MhOrDKNBaNwDs9xDs7G+k93i4E63azQiJ1PwCWswyhuPLM2gOt/PmGasc?=
 =?us-ascii?Q?2FkFmHl37vI/bIOCeiS+zJSsgzSnNJ60BwfL0lBiJajhRyMxZNdomExyPZHm?=
 =?us-ascii?Q?996MF84+lowwG17+cW2Ve444hJCyzwUqMV2feHxP9Ojs+Eh3yssHPIolFV5q?=
 =?us-ascii?Q?JsgPxP2i3Qryj1DXbJpNJyerpH0c9Ngs9v74nDWRw+PF0vt3Y+TCraalEZA8?=
 =?us-ascii?Q?yAIXJIBrVWdRsTw858DcpaXg07HMZRVKk6RY8fU+WN0JN5DNgHtV+RX0clMr?=
 =?us-ascii?Q?qEeBiq/dBiItOrIfwYIjgFNfT4Z+m+9JzleNjprqd7PekmJOGywDfcYRqA8H?=
 =?us-ascii?Q?tbOfCEmki7PflGPmUi/MEOpVxUN5n91liZ5WRkqDALvoP17elzW+j4anwftE?=
 =?us-ascii?Q?z0h9sDW8G4xBFQ83Nkle1UCfSYCVYG94?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fbDk5ChFXsqE8vmVGjf5q+CanGO8Q35naC07do76VSjfX3Dn+JjD+yfTmurh?=
 =?us-ascii?Q?7g1JZoCAoIGXvZ+9MvTQwNVhdsOtYqGzaOvu/SZIUoOTf4Yk607Vlq3SWrjj?=
 =?us-ascii?Q?2JfmK+bdIg1DeiSSvlzWJ6IZ4G8XzrMjxdPLuIfcM+ErNX+lHpbLxlzDC6HC?=
 =?us-ascii?Q?WOgKZWaA4L/jznV3xAE8q0/A/oWkzAA8CWM+X1xZBHQVfxr5ve/DI2AwqEwU?=
 =?us-ascii?Q?3glW+zLwc6QyoGsq5WhU0puKd+YezRbzVsACiM+oKF/kjDbMD+Q/HvP5GrxS?=
 =?us-ascii?Q?j3qau+uUbVo/ExIlNJsE7936LSp5OsEKpTNWJt22CCir/iI0s223cmmENyav?=
 =?us-ascii?Q?pOjN7jMsrJ9VlMU90zfbrE9Ph5UPbcKoOW8LdF8HKgWjwr8o09OIOzIvpy8v?=
 =?us-ascii?Q?uPNyE8sImpxTjKp2MZRt6fVHhhKbUGdHdVBUEH5aCAlhs+9N2aR/4kZVLRew?=
 =?us-ascii?Q?YBfPuD8W+Z011PvFR2ckEOBW5eBHPxdzVyVjgnK/+Dm6O74T6nPpjrZ1yx2F?=
 =?us-ascii?Q?by0JjccEawJUAn4rJIZjnAQHyBT3/0CzfRHwTFfl2CPKZ3BaMQJFv/aDb0zB?=
 =?us-ascii?Q?xMb1HGWI4d8rZHWLTirW+Ex86PLx5/b4MmMhR9YWsSbo5AJyF2ruZBW5iyF1?=
 =?us-ascii?Q?nBsaj1rdHD9TP78XkG5hWNgh9QqHFZz+1q6uee1139Ooaus6+yoOXrzU1fk5?=
 =?us-ascii?Q?9oriUPMz95CbCS2TA+daK17ICZ+t9EVh0Q21YX9TfAJK5LG+5WeBFu0Izbey?=
 =?us-ascii?Q?jVQCIKLa+DX/Dpahw5qQzTecwI/CyUjpRvoFfM6BuOu1v3QjdrEJ6L4jgRiP?=
 =?us-ascii?Q?gqm4Iq3iEKoNLgbn4T1Ha2F4ljjpJgBc9HauKxsklnvDhalFSm5DL/M8mq61?=
 =?us-ascii?Q?x3OIuguuGzS36ENEZ/7VibFe3+deis3aVi2zRA6nDSv/cvWIa8XuEJSgYwgb?=
 =?us-ascii?Q?kKJ9nEz4F4IMc83NOPQfyBszKDmITGv5wzfZQZsgW9ngzXgpQ7m6ZAjk9Ds8?=
 =?us-ascii?Q?Ebhxf+BfUtHmEhJ45NJ1OXAVOdRXFHVNS41lX615H1AMbB8ZFknU5VGJksWU?=
 =?us-ascii?Q?DwejwrHgOh7MJ7jb+IVU5Zts6SCoqn0t7vSZocJ5v9v956onCHRPlmUTEK3/?=
 =?us-ascii?Q?0VKcnaeqNqE0X9Lt9avvhO0SEw91PftfDObjosAW+jHxU3DcpIQV0IcSt+QD?=
 =?us-ascii?Q?jrtaQ0jItVoWFKiISfq7YYou0J8qhaReOuUk8XZeDXUKp4FRLylObMn7+4dp?=
 =?us-ascii?Q?KY5SJfB7odvGC0TPOD8nme2IWjcqzNZlVcnNp9h274mDV1DiSGNRE4Gz2M+/?=
 =?us-ascii?Q?jsJNYZONVJjVBsZx82iKTznQfACQHnk8kGgTg5nY76W8kwTgOgktnOF12W6i?=
 =?us-ascii?Q?F9J49UWD1UpC+X9Po6MA8cmQCopJ8nXkGXYuT/+Cs5k34kIbPei/4NotHbrL?=
 =?us-ascii?Q?acM9QLH0tAYagUFm7C1HnVPe2I683+7PyVdj4mFjd8dXoAPlSV/4+IynnMzK?=
 =?us-ascii?Q?yVpdFUTHU0yzOpgEiOs3js5CeL+FzIewiOMmmkkQL/o5on7FVO6vZW5SFLTK?=
 =?us-ascii?Q?dJpuku1p8xGL2THQ/ukby0oiAPm9Efcpduk1BfU8UIlIqHyXPVQeUfpS5Igo?=
 =?us-ascii?Q?WzK9WlCr8antn9yLW4ZhYf3IhGY2Xjeqnle86rnTpKV7C3LnIlEL7rG+Pwlt?=
 =?us-ascii?Q?tszyWASiPG5eVgnkay6p2DussW5Dq0zcN1lIyJwCYoAmoz4j?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6e6590c-c876-468f-70d0-08de3f3043a6
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2025 18:56:06.1145
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dVGZFyV5fpMhI8EH8L8pVVJfbxcri854rxlDKd+6VKbepoMrxOuuEKXxlJX8nKTK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9187

On Fri, Dec 19, 2025 at 10:54:15AM -0800, Nicolin Chen wrote:
> On Fri, Dec 19, 2025 at 11:51:51AM -0400, Jason Gunthorpe wrote:
> > On Wed, Dec 17, 2025 at 03:24:30PM -0800, Nicolin Chen wrote:
> > > +	*cur = inv;
> > > +	switch (type) {
> > > +	case INV_TYPE_S1_ASID:
> > > +		if (master->smmu->features & ARM_SMMU_FEAT_E2H) {
> > > +			cur->size_opcode = CMDQ_OP_TLBI_EL2_VA;
> > > +			cur->nsize_opcode = CMDQ_OP_TLBI_EL2_ASID;
> > > +		} else {
> > > +			cur->size_opcode = CMDQ_OP_TLBI_NH_VA;
> > > +			cur->nsize_opcode = CMDQ_OP_TLBI_NH_ASID;
> > 
> > There is a tricky little gotcha here that probably requires a comment.
> > 
> > NH_VA and NH_ASID both take (VMID,ASID) as input since the ASID is
> > always scoped to a single VMID.
> > 
> > In this case the invalidation logic always wires the VMID to zero,
> > which is also the VMID the driver uses for S1 tables when the S2 is in
> > bypass.
> > 
> > Which is fine, we don't support an actual S1 table on top of a S2
> > table where we issue invalidations through the invs array.
> > 
> > So maybe:
> > 
> >  For S1 page tables the driver always uses VMID=0, and the
> >  invalidation logic for this type will set it as well.
> 
> Ack. And I will drop that ssid too.

It looks like the ssid is needed for ats:

@@ -3156,12 +3162,136 @@ arm_smmu_master_build_inv(struct arm_smmu_master *master,
        case INV_TYPE_ATS:
        case INV_TYPE_ATS_FULL:
                cur->size_opcode = cur->nsize_opcode = CMDQ_OP_ATC_INV;
+               cur->ssid = ssid;
                break;

Jason
