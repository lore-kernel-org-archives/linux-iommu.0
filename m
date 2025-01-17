Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2043.outbound.protection.outlook.com [40.107.236.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC621D540
	for <iommu@lists.linux.dev>; Fri, 17 Jan 2025 01:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737076063; cv=fail; b=jXJ9RP2zgGFERxVCyl9uimpaP+wbEdSHNMIpctYXxM7sUoCBrM73w4Bp/rp8d6MSXcvrvkdB3Gq9MEL8ZqylKF/fR4VC6tgrnxv8w6s1fXRACeD/XoUbIJqNcGKRsYvOqIgeesNaEpn9GQomiS/ZEZB7yotLHLK6d2YVbVEw7xA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737076063; c=relaxed/simple;
	bh=JSAGmQNE920Tm5tNlCOc4+LCo6fhexuREfMBepp4iY4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b+9yBhl/U5oT4kOMtRY0mAGxaK6ZuMTagSI/eoUClC0cl9gIcy3LAS5s3MW0hidGKEStL8lNMvfJQorrlyEAcgjviIOqhtqKbsOVye+2uid7ox3pUE8ttO/+yTzpK3vh+eEgV5Xb3m5GpUHptNRjuuUvTJklqy9SRBHZRO2rFcM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=McEojgSL; arc=fail smtp.client-ip=40.107.236.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="McEojgSL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RdqRqrbjBPMupzuL0ZcjL8PCmKN5EFrnR3Ue2fGbZLG8GtC1QcyLSDxf3AtDjpBJlQwMamaJtpCt13/ZTVPfKniNYJ4FS0jiIqItTUbAhKfpf83MrvmZ5u2yclpDos2F9o6MxaNSTDY0jop/UOWNcThWH2Aj1LRtz577n+SwbVF2iDrQ7DFFtk1/B/q3BZpHh4fwudtZ+hGcPqQCF8FL1LnaZL5lZeYzdj6G1xrC+kZn6HmmyFdGVD8hgjeEq7uqc1PCEpFGJgMsql1Q0bK78wbvFQZmrwKBcXdCC3SWme9qixAwVXyZTZCi1cxjIqR3wP8tfUJtdXBwh0NsJ8//8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cK+jpU63pZL0mLbZkVlRrLubHLB1JDX0lXS7awSdW0M=;
 b=gqFVBOKywHjUnP9e8esU3iZeIu4jtCtqU83athshk66WXLKfrQoMou+2Kf3UCU+vD7PO3H3gXNCtKEZPwYKGS7w3iHU9obeqJbHeSAKAiGj6JjZ/EMaY6s3ffkwPowvRgoGzYYNirMhVMXEdhlgtMNR/FjhUbHcznLJ5snmP3Y3kJnoq+7dqDxp90alQpZTDLFk8ZjpAAx1DjVedZix3N+2pPQjidUYrxd1oe6LJAZw/rZ2PusDBgP65qo+Mbo6rhPVgzSjnBcKJwj9ZtmsbyBwtzUoCCy/PNP5mNGxGf+Wzw58zPj5xDJxWtAAap9hcHEz+Lt0D8SuZoms6fBuOSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cK+jpU63pZL0mLbZkVlRrLubHLB1JDX0lXS7awSdW0M=;
 b=McEojgSLXhHHQd6YC2nPx7Tjnxlpyw4ZAVjoN0kCR1yDDLLLX0vnNIt0xC6+eTmCgZ6JItKm6byYBAbJepvZEbRM+Wyb76mBTF3STjboGuBVtVo17qfQ3SRatU+I5aA6vvUlnfjdqkVJ/dOyyRMpXq51AVeHtdslW4mjjSLMqDAxWJ2DoEi7o2KAZIYQoDPTJkkDNN+wgMuSxAwhPVe1u8Woa/N8HKS1AG5texzlZOW+ih4GcS+YV50ae3uszPv+GwuU6bFlUE73wUI84pJZ8jv3DQKV2amp+TOFtXCCzI1upPCEH6Z1Bupk9bLvRcLR/5sUe8ZQWL6YEyaN7DgpwQ==
Received: from CH3P220CA0026.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1e8::33)
 by SA0PR12MB4365.namprd12.prod.outlook.com (2603:10b6:806:96::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.16; Fri, 17 Jan
 2025 01:07:38 +0000
Received: from CH2PEPF00000144.namprd02.prod.outlook.com
 (2603:10b6:610:1e8:cafe::91) by CH3P220CA0026.outlook.office365.com
 (2603:10b6:610:1e8::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.14 via Frontend Transport; Fri,
 17 Jan 2025 01:07:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF00000144.mail.protection.outlook.com (10.167.244.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8356.11 via Frontend Transport; Fri, 17 Jan 2025 01:07:37 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 16 Jan
 2025 17:07:23 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 16 Jan
 2025 17:07:23 -0800
Received: from nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Thu, 16 Jan 2025 17:07:14 -0800
Date: Thu, 16 Jan 2025 17:07:04 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <kevin.tian@intel.com>, <baolu.lu@linux.intel.com>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>, <joro@8bytes.org>,
	<will@kernel.org>, <robin.murphy@arm.com>
Subject: Re: [PATCH rc v2 2/2] iommufd/fault: Use a separate spinlock to
 protect fault->deliver list
Message-ID: <Z4mtOOqabb0tAzxD@nvidia.com>
References: <cover.1736923732.git.nicolinc@nvidia.com>
 <b727b09df331658f9bead42d6340e942e71a4cb3.1736923732.git.nicolinc@nvidia.com>
 <20250116203406.GY5556@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250116203406.GY5556@nvidia.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000144:EE_|SA0PR12MB4365:EE_
X-MS-Office365-Filtering-Correlation-Id: e695f7e5-eb3e-4fc3-1a06-08dd3693559d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JCdlFhiMOXh0sqxtyvmnNBiOcf5c0JMxQ8bV/pZikEnChBJfu136i/otiNdk?=
 =?us-ascii?Q?o4ZH2NRdGc+0fJduK47fh0d1CJSu0lcp5THdv/YJUrBmXQXg3BnbhJuIK4qr?=
 =?us-ascii?Q?4FaGFT9lFifu1wsnbPu01AieiP3GFgCLOaVKgOt9ouI1tWeDQMR/ZykBKPdg?=
 =?us-ascii?Q?T2NMMx06FxbWy0veDx4n27hBFa3+t70mfXzXjGafAMoHYjzHtVv5kU+X4nws?=
 =?us-ascii?Q?GoR1U2lBR6nxyraClXk7UbfPeUGkEh7yDOPK9SQJOR08eUjIb3PTk8rIrY2+?=
 =?us-ascii?Q?kGTiqzSZN5ydLiUKCMA9+NZzfTs6H7+39YAurxQNmcaUGLCKdYVzJ2asvUWV?=
 =?us-ascii?Q?rWLRyy01nyFqDJficMKIat25dMzoCslB+icfbgW6PoiRecuWZ+eF1zdiszWL?=
 =?us-ascii?Q?8da7oEXcJ1MQvHHrIMAkLe1gCBiz3+3lrAhRK5W9vn71fjtx4IebBN1fR6Xx?=
 =?us-ascii?Q?jG7HUDUiTFPEIKlh+BzIoILEKqvvkjUBjjvXz9beSc6V85BefBzgAoDktCNY?=
 =?us-ascii?Q?UX19gukVPxSgHWhK9MV56Y0uOd2Vk41UKrj8gyHXyy7ucKK0c7v9g0QgIIUk?=
 =?us-ascii?Q?RALXBQE0VrW/ljy+D1wVTT9mbvFDtU/zH2lZmYEkobXZyrs/tdBjspJwc4VG?=
 =?us-ascii?Q?U8CXNP5MfitWYR2uDEJQvb3NUC68nvSvqoMcOKqQC0Pjecj66XyINUqmibk5?=
 =?us-ascii?Q?Ms67XBslq1tjehEURgDPp9UPYFztkMPyHK7tzQsGdmmzEApX02+pOtusOs8J?=
 =?us-ascii?Q?YpKkC/fA7EeskBQMdUDK+eFXNA42MCOx3vlwSxTAFwF7zw1gda7C4irGkWT6?=
 =?us-ascii?Q?mddftCt6Yx6ojD/Q8lvSWI86eIiJEt7YawdgLIJ1RxtsiBNig2fEB1oVapgA?=
 =?us-ascii?Q?xYJSRNkyfaiUFFbrsk24Y08lMMovM5BfNIqgIZx92p9XSLxFHvP6FUkWmnjT?=
 =?us-ascii?Q?zAoRWWZgcLV8+dC+h29o1wI7997IH9viPeo3Zis0abHNF5KAePH17K8TiaIj?=
 =?us-ascii?Q?+BUvXXvDPR3aBqz5qa2Q7g+b1nFRWbKFN0QOh1CbE6fn5CC28ViuKz3OpTO6?=
 =?us-ascii?Q?aBUu2HbzmVyN5TikcI6Qk5zvnl0KY/6C3dw8Z7OCZ4RFOK1rZZ+YATISHGD6?=
 =?us-ascii?Q?qBTSapxNHHUvZ+zxCyWtGl2wiR67RC1QNsB2qe0yO0Pg3OaSNFc5FJ5ZdED5?=
 =?us-ascii?Q?Yila+8sKInbi5JN9cwfFfyXasspv8P6sKkeWzzi2AMohw7Rq6GSJ3eeeA+BR?=
 =?us-ascii?Q?ycz+XISulrEpF2fm3qwSrBorWiv3Re03ONvlqMVYghtxwpRDhTl9NG1iJvlI?=
 =?us-ascii?Q?sAdtKTwh1r2yDht+A23TmcQKzxW2FllCT5BmXvFKARVgjTTWzv8NGAWReWPl?=
 =?us-ascii?Q?auPYoxCfqrPylCwNJV3AW7o6Xr+Xk+vCcDVcDPC/glGaMqeEzgoylgeHHXeP?=
 =?us-ascii?Q?m/3h5pUw7e9yvFWjvaF2QoVYBfi5DRuKhS4xeGWjA11uZ8xoLcztC7nlFt/v?=
 =?us-ascii?Q?LbLLSknvKHUbqmY=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2025 01:07:37.9367
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e695f7e5-eb3e-4fc3-1a06-08dd3693559d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000144.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4365

On Thu, Jan 16, 2025 at 04:34:06PM -0400, Jason Gunthorpe wrote:
> On Tue, Jan 14, 2025 at 10:56:00PM -0800, Nicolin Chen wrote:
> > @@ -102,17 +102,18 @@ static void iommufd_auto_response_faults(struct iommufd_hw_pagetable *hwpt,
> >  					 struct iommufd_attach_handle *handle)
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
> > +	while ((group = iommufd_fault_deliver_fetch(fault))) {
> > +		if (group->attach_handle != &handle->handle) {
> > +			iommufd_fault_deliver_restore(fault, group);
> >  			continue;
> > -		list_del(&group->node);
> > +		}
> 
> I think this does not work, if we take the 'if attach_handle' leg then
> restore will put the same entry back into the front and the next fetch
> will pick it up and then it infinite loops without forward progress.

!! Needed more careful thinking. All these continues shouldn't be
handled like those breaks.

> To make this algorithm work I suggest to do a
> list_for_each_entry_safe() under the spinlock and list_move each
> matching entry to a temporary list on the stack.

Ack. I added a free_list for that.

> Then you can drop the spinlock and run over the temporary list doing this:
> 
> > @@ -221,8 +222,7 @@ void iommufd_fault_destroy(struct iommufd_object *obj)
> >  	 * accessing this pointer. Therefore, acquiring the mutex here
> >  	 * is unnecessary.
> >  	 */
> > -	list_for_each_entry_safe(group, next, &fault->deliver, node) {
> > -		list_del(&group->node);
> 
> The comment above says there is no concurrency so no locking is
> necessary. I'd leave it alone and just leat it be the efficient
> list_for_each_entry_safe()

Ack. Will send a v3.

Thanks
Nicolin
