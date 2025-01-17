Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2084.outbound.protection.outlook.com [40.107.244.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C091A8407
	for <iommu@lists.linux.dev>; Fri, 17 Jan 2025 18:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737139762; cv=fail; b=j+I1CDyc9kd3k0ItVcSeMwIm2hMVI4DXbRNyNsmuEma8skyvYmWjpTwiTvcjmD8klzRxBWrX1G5MvqJPpZaG+ztjY+h74r5uf41/CY5QerBwi7qIX1H7UToIUQOFtQs1M8UnsSvCuNu+uvBt9/OOp3o+X3tyzBdPEagrJ8Up1kM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737139762; c=relaxed/simple;
	bh=vMEY4FBdZK6EdZBC3bDgoG0RrPuQjsOc2IbFwFEKUSM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lc1/FZSgLMh5PbSX+1SuwKFsLkAUqj3m1VcQKAxbmPMvAnGA4O4wO6hhFn43w8SzDEt743RmBxdMfsjj5O1MX1VXmx0XnMhgTxyHo29Gn1kJ7814VEhPUpKz+UfO2fffWrO6PlYsLTQjAYlkn+Y9BERW8N1KhxhgfJR+JKoBF+8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nS/s4GLp; arc=fail smtp.client-ip=40.107.244.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nS/s4GLp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KHp3J7TnQP1Bhr7PngpBO62QPSkY+iDK0+TNMQkYaDCnhXeXWSsUAHzX9GY0hDddQ8T0vAlBSZEXDj67VCDO5ysiAhDAudvJLHNz9jUi1eHOJx+C/dmImzf5SUnqIP34nf/+9OLM4Rdl4l6Ds76ETVNgo5sdBoUWyJqmRASTFvpdSV/chipVK4oTb9GZCa3jg692z2yCT19qJPBK4whmK7vveP+M4+BnloHXaTtCUkegpJT7y304WW1ccZXbMklGlR+GsgZIabKAhACJeZ6Vo7tQZrMopN//y7qpnRoCwxVy8F1pge1w+ap+A8qvItneykjohmE10U+oIFkbxlNETQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PMpm2VBk4KhpmgbLBG5GSE7mPluH5pu5dWHCEQn01C4=;
 b=EHoLKd0bpcOpJ9yfAQT6nFN77imeS3pMUmqI9ViTlpEo7mieJvqXSVoRyRnjej1vCpUK6NZmPvpTadvhRTmmyV80RqJ7uhW/6sM42+yKcNuU/9A3ck38IJXXoW7vUauWxaA8kZ0XytQjFnoc2GElpur6LwBK8a46LXxuC1OAxuMG9S2/Mz1dLTalJe1GB8nNHxZGl63NiA0KUlHpVuI6vSvYHiLT+Xb8AJnnh4gs1s0o0IVtATc8jWpanYAikUW52/FHkRyYLaR65rrlu1iCwaBL5GX83Ngc/6nUjHsHfkFtllKAm1hxnR8TKijSVBnum4U5n6iOx+mrMMVf8UC60g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PMpm2VBk4KhpmgbLBG5GSE7mPluH5pu5dWHCEQn01C4=;
 b=nS/s4GLpyoSoRRm+G2C1HBglUzN1xkiVReRwPUfaIODjhORdeMls2vz315lqCWmsP+cmBXcaR2BFipOU5k/UwA/sR6uvRbhCC2k/Dx00sm9OOW8QbsM38kQUZw7i2E43DF6EaOTGcf1rkL8kQJFqmZHquKw4nTuXOLR2LuLVXk/U5Ein7l3dDfws6Vvdllz8ymIJohpljFVcI1kCqKi9Jb7+xhy99kNuL/aHSAMGrBUhl7Hpca+Er8OL3W+mo1mxY8xhTdcPcczLBWMR04VA+vUaANp4TFMrfFARx39Zj2L20jgfhHDY3qEyn09/iZfP0jsvIRY+friOLECQBqbyrw==
Received: from PH8PR22CA0015.namprd22.prod.outlook.com (2603:10b6:510:2d1::23)
 by PH0PR12MB7887.namprd12.prod.outlook.com (2603:10b6:510:26d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Fri, 17 Jan
 2025 18:49:16 +0000
Received: from CY4PEPF0000E9D5.namprd05.prod.outlook.com
 (2603:10b6:510:2d1:cafe::8b) by PH8PR22CA0015.outlook.office365.com
 (2603:10b6:510:2d1::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.17 via Frontend Transport; Fri,
 17 Jan 2025 18:49:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CY4PEPF0000E9D5.mail.protection.outlook.com (10.167.241.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8356.11 via Frontend Transport; Fri, 17 Jan 2025 18:49:15 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 17 Jan
 2025 10:48:59 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 17 Jan 2025 10:48:58 -0800
Received: from nvidia.com (10.127.8.14) by mail.nvidia.com (10.126.190.181)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Fri, 17 Jan 2025 10:48:57 -0800
Date: Fri, 17 Jan 2025 10:48:56 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: "Tian, Kevin" <kevin.tian@intel.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"will@kernel.org" <will@kernel.org>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH rc v3] iommufd/fault: Use a separate spinlock to protect
 fault->deliver list
Message-ID: <Z4qmGLQ1oB+aS9h1@nvidia.com>
References: <20250117020449.40598-1-nicolinc@nvidia.com>
 <BN9PR11MB52763118C04E83C14683CBC98C1B2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20250117143856.GD5556@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250117143856.GD5556@nvidia.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D5:EE_|PH0PR12MB7887:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a94c0c3-419a-4ff4-14e4-08dd3727a47a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Bkh2B3GAGEF6Hb+q8hLp/MhNjB84pS91B02i5OA41N6tAqLui04WZenmGOd1?=
 =?us-ascii?Q?cUxedNo9ZsI0vwgwjam7zNYhmHzzxfHWxazyg2A+svMdSeCuGeGdHignsvKu?=
 =?us-ascii?Q?FmNV4ryXPULn5kfSZiV/Qz1XHrUDYUX6CIG8udgPYBjJPS8UDXJ+8nZR/WYc?=
 =?us-ascii?Q?zdon8sjaDtCxlWda/TkJ5tp7pcPuqjvSJT5n0Y+E0+sZKubgBmcr7N5PoSzU?=
 =?us-ascii?Q?/4GTbjRoBL6oLS3xZBLvt/NKAfnqvC74fuLrErdV0HDixwam2tK9fzTvoW9u?=
 =?us-ascii?Q?j/jQNtwrhlwvWpa7ed6Kpf/ksZVLV84Fputb/rKtPsgXA5Ay4KOzMBX23lMW?=
 =?us-ascii?Q?/xYQ5mul0Y7NzIgH0uzMg5a2/5hWG5ZTpVpKUttftAv4S3GrziDIJe610Kz3?=
 =?us-ascii?Q?ZnrP+q8+0N68oY3xlKOCkEPSDgaUCRCLoFlYWgit8Fe9JcxyZMkilodN3Ft9?=
 =?us-ascii?Q?EWL+MKow4Eik5/3C2nD9TOgw81Pn3i3nHjw7hT2BYXkiRTpYfQy2oX+nEdGF?=
 =?us-ascii?Q?fQUFXLZGu2UKZBgskBTbORJSY+fOs/10ETXaqtSsF1Ldro4XToaO/i5PwT5J?=
 =?us-ascii?Q?sC8TNy2oTxqnY68cGTUBuab+1k6XrXq5ECCXKzA1GjDRBPjhsZ1eK7k9k4Qe?=
 =?us-ascii?Q?EWijRjpLoPUkRHL7lqv9lk3NLgmK6KtBqVEAj/tjBRBuQdhnpr5aeqyb/xPI?=
 =?us-ascii?Q?v2yJKHQ2ON935LQaPEwEean6IkBwKpLxoGw+4wXEUKZiO1ljji47FYmHonqE?=
 =?us-ascii?Q?kY/pCuQr/L8Qw21rzCFJZ95tBCo0z3UNWcQFCCOtXnjnUeHqvHZ3vA3TfaXO?=
 =?us-ascii?Q?xBtIQ94mJpsXW4+kQgqONOCchOrAiwSzn5X2Uua6ZZB026licIAUvpXcndV7?=
 =?us-ascii?Q?Pus2ibaHkawPTV1OGiANC0HAHmy6hb97w1eCrSScftIcDN/DijEsf5A8gwnr?=
 =?us-ascii?Q?cfqbAxwiqF6VMqWgwojWVc4ODqpsB00XziBUwUGXqxOKZCxTIrzegTj5F6BF?=
 =?us-ascii?Q?/WjaogF3FHFHq/+owfiU4eQ9L9muZ2V/zmtcj5uIuZcM56INmWmxi0x748J7?=
 =?us-ascii?Q?by6ip71OoD2aeX3FhDHSnjSMXKYtp4hiQbEC8RNB0ow9hIKUCiTpSlRdhTBc?=
 =?us-ascii?Q?uFwZaRUUOxhXBvnHY8LL4QUu5Nxf5gopBj5jboR9dRMlmxwDjUW0XPivwU2f?=
 =?us-ascii?Q?thTVnHsTo3Emb4jdspNAibQHcJ7Rp+AKSb9Wsb0s5hhiOKYOlcUAt6foFu9e?=
 =?us-ascii?Q?fiSEk8+0IW/hejKrJMvr0YS5xm2mZmVaYcykIxilKAWfEazlisjGwu11VJ8J?=
 =?us-ascii?Q?SfnFn1CNhVMrIVq5wvncjB8+QwXSKSbPCvDFiS+YqFcTnTpz7W/szEP3IVpz?=
 =?us-ascii?Q?nSSaAEkH5DkKjjdNv9/w3KmVb9fzeEvat0PP88D8ZESm2S6B0wEJE0NgOBt4?=
 =?us-ascii?Q?wZbyXb6MXKQoAVtrA3pdce1E2ZLBfNUn7jjOUJRZ2qLnoIIDEw/bAib4C8ry?=
 =?us-ascii?Q?shI+TsQ1ejqI/wI=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2025 18:49:15.8569
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a94c0c3-419a-4ff4-14e4-08dd3727a47a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7887

On Fri, Jan 17, 2025 at 10:38:56AM -0400, Jason Gunthorpe wrote:
> On Fri, Jan 17, 2025 at 06:20:15AM +0000, Tian, Kevin wrote:
> > > From: Nicolin Chen <nicolinc@nvidia.com>
> > > Sent: Friday, January 17, 2025 10:05 AM
> > > 
> > >  	mutex_lock(&fault->mutex);
> > 
> > Nit. The scope of above can be reduced too, by guarding only the
> > lines for fault->response.
> 
> Hmm, I think you have found a flaw unfortunately..
> 
> iommufd_auto_response_faults() is called async to all of this if a
> device is removed. It should clean out that device from all the fault
> machinery.
> 
> With the new locking we don't hold the mutex across the list
> manipulation in read so there is a window where a fault can be on the
> stack in iommufd_fault_fops_read() but not in the fault->response or
> the deliver list.
> 
> Thus it will be missed during cleanup.
> 
> I think because of the cleanup we have to continue to hold the mutex
> across all of fops_read and this patch is just adding an additional
> spinlock around the deliver list to isolate it from the
> copy_to_user().
>
> Is that right Nicolin?

Yes. I've missed that too..

A group can be read out of the deliver list in fops_read() prior
to auto_response_faults() taking the mutex, then its following
xa_alloc() will add to the response list that fetched group, and
it will stay in the xarray until iommufd_fault_destroy() flushes
everything away.

It might not be a bug to the existing flow (?), but doesn't seem
to worth touching the mutex in this patch.

Let me send a v4 changing that mutex back.

Thanks
Nicolin
