Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2073.outbound.protection.outlook.com [40.107.93.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F36F2F56
	for <iommu@lists.linux.dev>; Sat,  1 Mar 2025 04:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740804436; cv=fail; b=TdYSYdNkQt7PDA7s6EeosJGny/51BBKR88NG7xtihm2BxCYfZpynpNgpdr35HLGACjfwn8MRyxyefE70s0FJ8BmyAm3mrx9pSY2ewyE64JO5/Z3yFQW46EfCf4gEqQxDdQ12yXDuheXoK8JM5/vkhH1ZWAzDm7wZlosOzGm+fD0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740804436; c=relaxed/simple;
	bh=8oz0qVJyxqknkPwSPxfoy0n57XfUr08iBgVBbQ/50Lg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hLdMgOcvI0BMvxA3s5KWX4o70gtLXIQwCno9qxwmwhXByM9FZyWIXOcsAT9fhmwukmiunQSxTQpB9U+sWKzvYcaUay5pldQLAeBUxfrJqFF42tA7/6nT/KU7+7JxG+hrR5CqfPP6II48cDxc64/hOk6OBigpIiQslJgZ3Qc9MxQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XVpHAcFI; arc=fail smtp.client-ip=40.107.93.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XVpHAcFI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MsaCdtcKwGCKxeQRSK3uQKrlENq4oehjjK/g3C8jK+JNqjlY8TBvf/1JHD5oCpRwDGdX1KD/6mQs32+uh3WfH1UxcCf62svwTsRnSdpw27GX8kqh+Eioa9F43i6IXlaQfPNP/xoo4cZmBO1zA9Kh4d93rmpu+q48bwsdVZiGrFwHh3hNw0b2zFnAg1UO3BsY/oLiBxdxvmTVkaqWKFioiPZq+ovfDy0xJfwKiyUoN+s9Th6OrDwPV8Lj4bJnS0PFrVjqcElp2HzsBLn3Ph3bKF1lJIW3GRgnEl0Hr03S7RmDgBmJ18LMDb/9zP1BGqyjUPfC87uzk+NJDmhr5AZY3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MEaQjHoY2Xqsqpl5qTBigdrI33/bxscw+xEzRW+NO2E=;
 b=PjXJzNNI5BXELPJ6KrQDQ1shmdODA36yrDWlXX74s6ltlqJwvBzlBKokpAgd5vZpkMq6FX94tmmN/a/fGEA+Cb2J7qDjYhQaEM7r6bez5jEVV13YPkUpCJaJ5sf9FE13eqoCaFfxUKUsOAWQpyxaUqtL0TFwE9phdx0EUwwgntQ5UlVQTQT/gIk/vHdW2cOuJB7SAEuUrxR52YWc639ishCB0rovr5/u44n/rlcD8poUQsSi9x0z39LFgz9NdczLC5tobH7e4Kew4c9lLAFQDmngWM22DR2AvjAqJNdn3TUpdZPvx/3qyczPX1QXzVgrK4V1JyPjODQSF5/EAuf0Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MEaQjHoY2Xqsqpl5qTBigdrI33/bxscw+xEzRW+NO2E=;
 b=XVpHAcFIOacGDcWQVwU7/D+4z/IKJlXUL3E0jOkdiCl42uNQMtUiZB2vrRjAFdtSAnHckXlmz6M+MZ94fZMxVy4qn5ZWhF/5Sn1kQ3N68La7fZoaR0+LvvtHikl4QymQ46S18jjSQpVLrDeSZHZT6s9a198Ml7g3wjmPYuuF3oaPbrl4s7o/e0BN283REkeCeFWi3lT7aFv8hIXcJmMraEu2ZOkRKcVF58SdmLJmhsgK+Ubd28CS/gIYkpJeM+Bhb07IKRmlZ/kUNX16eRFIXBEXH+eZH3JHHj2MBjl5omwN19vPIH/FSX9H2wG1HCWkZcbHpcHGKX+Rk7Mti7042Q==
Received: from SJ0PR05CA0032.namprd05.prod.outlook.com (2603:10b6:a03:33f::7)
 by CH3PR12MB8878.namprd12.prod.outlook.com (2603:10b6:610:17e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Sat, 1 Mar
 2025 04:47:08 +0000
Received: from MWH0EPF000989E9.namprd02.prod.outlook.com
 (2603:10b6:a03:33f:cafe::74) by SJ0PR05CA0032.outlook.office365.com
 (2603:10b6:a03:33f::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.16 via Frontend Transport; Sat,
 1 Mar 2025 04:47:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000989E9.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.16 via Frontend Transport; Sat, 1 Mar 2025 04:47:08 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 28 Feb
 2025 20:46:58 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 28 Feb
 2025 20:46:58 -0800
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Fri, 28 Feb 2025 20:46:57 -0800
Date: Fri, 28 Feb 2025 20:46:56 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Yi Liu <yi.l.liu@intel.com>
CC: <kevin.tian@intel.com>, <jgg@nvidia.com>, <joro@8bytes.org>,
	<baolu.lu@linux.intel.com>, <iommu@lists.linux.dev>
Subject: Re: [PATCH v8 02/12] iommu: Introduce a replace API for device pasid
Message-ID: <Z8KRQMxcOSn9Lytc@Asurada-Nvidia>
References: <20250226114032.4591-1-yi.l.liu@intel.com>
 <20250226114032.4591-3-yi.l.liu@intel.com>
 <Z7+fmawdDhATfOX0@Asurada-Nvidia>
 <d6b97c8e-f126-49b3-b752-92fe3069af51@intel.com>
 <Z8CNEDwUCZuNUv7C@Asurada-Nvidia>
 <51eb28e7-0631-4965-81c1-cf9633e46019@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <51eb28e7-0631-4965-81c1-cf9633e46019@intel.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E9:EE_|CH3PR12MB8878:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b16b6ba-bf6e-4bdc-e22d-08dd587c1f77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7sxf0P22PnQTKuzQMTg7w8ehXZE5TFAdX/OQHZ/KeODZ8sSbSqcV6HeXNs02?=
 =?us-ascii?Q?ITRxfJ4hoGnIt/iE3M6521mrViI+IdAkIeDRydRlufljrWpYfy97/zz7hwdp?=
 =?us-ascii?Q?fMTtdxGqSCS6G8F84jD8+Wjot+5/+UkM+lw29FrqXii2phFqxTR/aNo7bII0?=
 =?us-ascii?Q?1CBn/n9/9cFR3xUPlPLEjCbAM/U9v9P+bWwP49khpJwW2cRWS0D4qsVqK6Gy?=
 =?us-ascii?Q?jgGO1h5/CygPtCiijuq1l6Qi9R+c0LSzp8N5cZVnm7sMQY6dULf26PXiCVAj?=
 =?us-ascii?Q?Dv//maJDfnlo0Jn/xjzWYaxQoKdMIbfyF1lxuVO8eFhfX1iOD3oAng7ywBJL?=
 =?us-ascii?Q?sH24Xk6yW6tKg6kxXA/txU/pONG+sXEOKrdPnKfdIofaKRhcIF4FVR/B1HvL?=
 =?us-ascii?Q?Fh1atjk1MFnAjwC/4XvQznCwOhqI+3P7iLyrS9Nn7/3fYPKUijB6iVIXtBY5?=
 =?us-ascii?Q?ZK7EE9x4wH9TWha+VUorrxaF/D6VYVlsPFHcdkSNrhKI7T0KJ692q2kAbv7J?=
 =?us-ascii?Q?DtuPiFiJ8eVsGqr1tNS0sUnk2U7Ppj+vI4XWSCDJ65eaPAxnLIOXvgpgZPj6?=
 =?us-ascii?Q?fsu1c85P1SRI3AAVpQC7kRrMo7zRn+U7Dw560lZ8In/fB224eGDxOOx9Ca2p?=
 =?us-ascii?Q?Izx3SJHlumE0pDEs5VG5bYVK/2yE4fcQl9SuOzpWP19N+TEIA9vMO5OLSWVh?=
 =?us-ascii?Q?xAeKaW0LT/5ZIj8TxJ7FK9+MlZd3uuZAySRHDjuSeYmbtBD9G/QRkEHTiG2A?=
 =?us-ascii?Q?8pcaF2Ko7w2jrcF3m6LVXEt2xw87ztkM515TJBBJfa0ccDsR+k6qrTOgejC9?=
 =?us-ascii?Q?P9MY5KMyfpLSj6wXDoipTauC1KT/3bTXZWu24Q4nw5O+CAQsnHI6V94sN4t4?=
 =?us-ascii?Q?S9p3JynGheEozhJ7GdnWga4S9Hze+WHC0VfCqi2AAflsp6la5o6tGCf4V8+i?=
 =?us-ascii?Q?yB9Zh9+gW76qQIjoZZvdwU1I5aprJkZzVEGjqOAOWHatQ6oXAAjXfOkC0/cf?=
 =?us-ascii?Q?4w9vKoL7pZD5HQtRVx8xTRFgKUL9W+HD0Jadgd2NSZgESgWNU9KcLNJOdVva?=
 =?us-ascii?Q?2OLCojZ6MOIS79m5kCmjfLf8IaXl2HTSVohv8zrD/NNK+rTJW3t0zkSd7c+8?=
 =?us-ascii?Q?3ubbiorF7z518X1ZxrIF6hysrzOI4NoDbMdxIm+DpM3GGMwaCNrTesNxPY1t?=
 =?us-ascii?Q?Gtm59aXg/CcUsXV5Z041+xPQl1isb1Q6afd8h/aMpGYh6N9JA8JsYwcMdn49?=
 =?us-ascii?Q?WoBoEFDqPv5tC8WfUd4F0TfS6EBnGl2wQf4liVDicKXRZr6/sKO0qU/0y2rq?=
 =?us-ascii?Q?/nU+L1FW79mkehnXiB+5twESVETqKqUIbx3G5TZC9nI8wudP1qM7L4e5mLDu?=
 =?us-ascii?Q?zeZcZHtzEDGxq0fdNQR/DFttAfgqrhrXyvKN7lqK4Gzg2LUSl+83hDFO3DxC?=
 =?us-ascii?Q?Uzi8i6yZa541CVgTq4CoUSTxQEuQfVfoFBGqeI+1uGZXvMArClYSMZWgFHcK?=
 =?us-ascii?Q?w35JcuBr4uw2RKQ=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2025 04:47:08.2211
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b16b6ba-bf6e-4bdc-e22d-08dd587c1f77
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8878

On Fri, Feb 28, 2025 at 10:12:32PM +0800, Yi Liu wrote:
> On 2025/2/28 00:04, Nicolin Chen wrote:
> > On Thu, Feb 27, 2025 at 09:43:01AM +0800, Yi Liu wrote:
> > > On 2025/2/27 07:11, Nicolin Chen wrote:
> > > > > +	/* Not a replace case */
> > > > > +	if (!curr) {
> > > > 
> > > > Mind elaborating this?
> > > 
> > > If curr is null, this is more an attach op.
> > 
> > Does it mean that this function doesn't allow to replace a domain
> > that has no handle? But how can that be an attach op? I mean there
> > still could be a use case of replacing a domain (no handle) with
> > another domain (no handle or has handle)?
> 
> I think you misunderstood me here. The core stores either domain or handle
> now after the handle series. So curr==NULL means no prior attached
> domain(either with or w/o handle). That's why I said it is more like an
> attach and should use attach op.
> 
> replace a domain w/o handle to another domain with handle is supported.
> vice versa.
> 
> But replace a domain w/o handle to another domain w/o handle is not
> supported as I didn't add it. But it can be supported if there is
> use case.

OK. Do you mind sparing a few more words in the comment line,
to clarify that !curr means the domain has not been attached
to anything so it shouldn't be a replace case?

Thanks
Nicolin
