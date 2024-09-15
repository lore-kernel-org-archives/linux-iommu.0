Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2042.outbound.protection.outlook.com [40.107.243.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF8614286
	for <iommu@lists.linux.dev>; Sun, 15 Sep 2024 14:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726409376; cv=fail; b=sgmpwocmWy8EXCZjDo9ir2Qpx9ckgnuHn5igRBZ9IGdJyQOdC0iX1tFdytrdfHI145B4BcL/T4zTNu60oHdhYm/xT+4dd2hOhg5sWMs8RAqpL4f9vimMY7bhUnPwoprkZDCNsyQTgCQjiyd46rM/6V7kGkDOZPTt05814CFgPok=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726409376; c=relaxed/simple;
	bh=b+nuNVI7r3XRxFGxVBUX9FluNq1w0abU949epGtute0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kpkHgUkuK0aVyUxg21Nzx0QFpaVTmhiRGZQ1FhbrdJ3nnWMc+PhoHRMcRb48QNCIqixPQz4WKkgWTBoc7fkPtti5B/vixrdAU4BwyY3q26GkpSsLsJz0VaaLljRxKY6M4XkRcTRi+MdWSVLw6ZOspEU0seZJN03s/6gOZ1KAAoo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sWYGRVBh; arc=fail smtp.client-ip=40.107.243.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sWYGRVBh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aPTPMJOOeoc40UxOl7iUp1Dq/jJr0csyBTATSi6RwPa4GqtBajsfONL5YmqL1TeyPeEj3G3o80btvC7dv2asDMkcuyIyJSnYqQvkvHgKqko2aQq9UICCSy6NttSCvKF8R/dvlfuy/dvDC9DCI8o/BwtqDpAsN/EjZhG7kJ6aZvq6U26gTHikzsWbLC21ypDqfqpCtKDtiN9mQ8TgnRfDLwTei2jrOkfaIIadz2B4rdDyLStoaP86mJV4qL0Q57lTSsE6ltuay8CLEBCODWAitm67POOUERU2AyW47ubYtRCzWCghdPbRQhGs6X8o5BKLqAXeB2MaK+uWU3PjffJUyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w8q7Ss4voT2Es6gfClwLfylCjqLeFVW4hDHxIz3EtYM=;
 b=htHJ+nwNasN7ocYI2yhCEpSKlDjlcVAAiOWMDZSivGjCU5uyEU2kF2+o14z9EFT5nLad5YuBmeqTmUC3UzAshWYfS3xz7kNvhbAk+IZ7HgbIAjPPxQdiSFSbJmsdM0cAHzYD2jGkrOmOb1836X7MNo7KE1kePsjJi6DSp1lquHDsQHmg4P1PIW0TKYhExNVkdvqDULjMZK5POldwowlSvjrJqIjvGvPnhz2BeuJlwPh2IfQgk35HHlpie8hSWwUFLiUdYKMA7SKjFSAEd1Hqu0uYJAIQUAk8YEGRYphkqx0ixPfm5rrCBh7tYYZuS9fHfWXmC9l9kT2qYfb44PupuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w8q7Ss4voT2Es6gfClwLfylCjqLeFVW4hDHxIz3EtYM=;
 b=sWYGRVBhwFkIWeyk5nqNxw/85Y4nDaO74zuupi3RfkcRS/i4DIm+asQfzbs5jSCW1GVxY3/JHJkLuUD+yltTNMBf+5Q9KRM35TT8DxWYAmmPk8mUT77gblYXQCiWMLMIhOl6sAqjnvyqFrnAfQOvEVNdbBM3uCmO6F2WUjZfcxXtpJLnF1VIqAeH/7vovIYrxFbY74z2VpKkulcW5R3ZFn3GShpWhPrtgFz5AhQdBH6G2KfnB7t7IKUMpvt/9tyG1O8lraIQ/gtgGygZ+k0Zp2eH9sdOcwHDPkecenUNCVO1rMhJIPvO0kfktY9TCcmO1p952doOflvDhlFaSyGaiA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7763.namprd12.prod.outlook.com (2603:10b6:610:145::10)
 by SA1PR12MB7038.namprd12.prod.outlook.com (2603:10b6:806:24d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.22; Sun, 15 Sep
 2024 14:09:31 +0000
Received: from CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8]) by CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8%5]) with mapi id 15.20.7962.022; Sun, 15 Sep 2024
 14:09:31 +0000
Date: Sun, 15 Sep 2024 11:09:29 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Lu Baolu <baolu.lu@linux.intel.com>, andersson@kernel.org, afd@ti.com,
	nm@ti.com, hnagalla@ti.com, b-padhi@ti.com,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>, linux-remoteproc@vger.kernel.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] remoteproc: Use iommu_paging_domain_alloc()
Message-ID: <20240915140929.GA1834200@nvidia.com>
References: <20240812072811.9737-1-baolu.lu@linux.intel.com>
 <ZsdktJEqR9BOgivK@p14s>
 <20240822162425.GE3468552@ziepe.ca>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240822162425.GE3468552@ziepe.ca>
X-ClientProxiedBy: BN9PR03CA0711.namprd03.prod.outlook.com
 (2603:10b6:408:ef::26) To CH3PR12MB7763.namprd12.prod.outlook.com
 (2603:10b6:610:145::10)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7763:EE_|SA1PR12MB7038:EE_
X-MS-Office365-Filtering-Correlation-Id: d9b87a5b-0886-43b8-d508-08dcd590049e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1XRFZe65ROne75QhsjlgXmUhi6m2/Y4sEvIznl2Tj8ORmmg1Eyw2LZWGdM7C?=
 =?us-ascii?Q?s4TCCpxeNvNYNRksBX6aLL1Q78GuTxMkkSIHUOrv/fyB54bW9OXDeEQ6vuyd?=
 =?us-ascii?Q?xi4n51ebn3mna2d84q/9qyYax8cedNaLDcyjssdRapD/+036PwV1aVWdJY9X?=
 =?us-ascii?Q?1FCfXnJM+3vMBr3ZdoLstNqTdp/37bcVnelwgv9smI9xVsFrrDLXGLTy9MgV?=
 =?us-ascii?Q?MziBSGHqL0T+56rDwiq5S0eHpSaU9E370+r/TDvYESWOByJAbKiN9EbHnv9i?=
 =?us-ascii?Q?0mmrFRbdqytBA4kAFH6R9zLojh0AhUk2ZZR4eP2JjKmCScYXvlGPqC8vL7k6?=
 =?us-ascii?Q?5J9T6TPu1iWxWrUhasSdBxKhnw3R6T3LvQUq7u6iQYJQgLmeb9tkmNLsN4IV?=
 =?us-ascii?Q?OwtivzzeIk1CLmmWnPElimiv4Vy0lHMUUQA7TKslJ4ZuezQF9a1nSeS8ooIf?=
 =?us-ascii?Q?aS3Y97aZFm5vy4JnnSXOHxcETL2+rQCkjnd/jBE0VURTieRwmEdJdrN8nqVo?=
 =?us-ascii?Q?mfQlLtiICJuMmUn2Is2EzD9/nmrrySCil/C/ucVORcR1/649hbCVLiwyAkTM?=
 =?us-ascii?Q?oNAIKLD44rCrR+buHH4INe5Y4khPerzZQYzTkB3scIYNVVwpVZYv/HssyS1V?=
 =?us-ascii?Q?Amue9iL/tVz17iTBm1GDPKa4x++qEuR39E4X8ZGI+kceAcvofsDh8tsjXzN1?=
 =?us-ascii?Q?/9npyTcBTlj6OOlNuV1iKKT1c+JQK5UEYx3Oubf4ezP39ApM5ixa07HUUK9F?=
 =?us-ascii?Q?RY1RwZyAeTqo/xcKqVNCh7qFE391ChZXU8Tt8EbtB0gGdcyTA2ZS0De5d2QQ?=
 =?us-ascii?Q?fEWJtln2nNaAeIW0C8QAt/JRsJqcw6uPyz9umu8LkvQNVJnWbJZ5wZtfo6nd?=
 =?us-ascii?Q?JX3VC3qzUJZeFAXA5lwzzoNc307AiWaQO3F+UM6rXVCnIiLyzlHr0wfLCeHY?=
 =?us-ascii?Q?xm8yxA1s4aKi5wPjAGN3wShjOH0brSV08xkux2Is9yUydmhcdR5aTardKjOp?=
 =?us-ascii?Q?tE3iNybVB6UZJsnskoiBEqu7AQ4cgwMM7ckv/uG5OWcl/YPnMl9adxA+Tc6n?=
 =?us-ascii?Q?EdmN9FjFknRa91viTWkD59KU/PH6WBz4U9NeJ71gLFuo/SR//qNyEZh2jnab?=
 =?us-ascii?Q?UOj689y/0Om0/X1b1td1q5BpP397pwuhruyUu1vWArHQ34y5bktwZaEH+hgu?=
 =?us-ascii?Q?2CqmqFBc716DQkQ2T/VxPSQ2zNhp5Xk7H8plAP06rEqiRCRnWn6ePduGYOdJ?=
 =?us-ascii?Q?/KJnnoHiEWOvf04n3Cw+jODoVeT6aT0nEsp95jvxB/JHl1Jxw76QfEyTl8f0?=
 =?us-ascii?Q?rUM5yH8PO8yo/SeCCJsaqBC4tm5+QqYD1wFYw4+eYnWeaQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7763.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kmbP6GVi7nmrtTaQ+JkuJUTXW72gXZwx93ZPYBCp3E2sLfj1y3v+n5w2eWFx?=
 =?us-ascii?Q?jOVfETx56HJtI+jY2ehJjFhGRVYSPr7c7iAALizEU/S+tITKpIADdWnSzRNl?=
 =?us-ascii?Q?XgFWVN9Xgq8hBiMOFYVRofWSIagt2P6uiy9ETSxpHLZSKSZ3HQx4uZSHccOf?=
 =?us-ascii?Q?EtRPvAj1PP3QKAmvOwZQpoiyXWd+QBQ9V5wE46BV1qzt2UCr3jXS2057Za5F?=
 =?us-ascii?Q?qmHgNp83WQVkf/cRmi+5QkunpA3QFwO1dCIhkl+MoPF4/21vYEPTy024Qs6b?=
 =?us-ascii?Q?DXNYUTGEjMrmzCvqALuDbM5VIqtcHNWkMHVt0DtdguzjkZtEjtIPliqJfF3x?=
 =?us-ascii?Q?+D7n41rNQrI/HX9MEtZFgteG/j+UFr5cHtVHfkB4Atd34HWmuO6baqqf8ugE?=
 =?us-ascii?Q?tXwN94TglAcA/hAz+t6zCuA5KuWymEKAM08acQb0bSIon7Hs0qzdWJSzXSC7?=
 =?us-ascii?Q?kkKFNhk4JS3PrIqDaxwvJ6OZJPH9h4Xr4NLiUF88Zo4//DFFiFAO0uFtkAp9?=
 =?us-ascii?Q?9oSSYxns72Ki7GMFauC24sLAoU9w5eKB1Q4FAxLUTpHitxBU4Egrs1XlLaPm?=
 =?us-ascii?Q?zExJAzzwqjGEnaEhf+pX0mMxsUvR+fL01c4TcYyMSGmmLLAjGEKQyXckfU+L?=
 =?us-ascii?Q?Is/BAf0dAfIm4rGbwA8qgcj21D5XR2RfV2WG1LsCnlLpwX5nDf9lcpv0fj1U?=
 =?us-ascii?Q?6qJslEHRPsZMCoWwKPQS0558PSbOdqwU2hB7zIt3V/rPrtXdgGb/tNB5UOs4?=
 =?us-ascii?Q?f1hqlrckHJWgWoqVeGNYv1jNQBDkqrN9Xj9oFvwygZLxqud2v1wyzNKrHrrS?=
 =?us-ascii?Q?A54Irj1UT5ps+L0RcnsTY4GhvMKSNlMAOXjMfPbxZlIV+/QrwrGowwGmTIHL?=
 =?us-ascii?Q?vwh+6pSBrfljjierPYAiC1LOdSQ9WgyUMFQMt77qBPtg+0JFYcmbEkXeaU4R?=
 =?us-ascii?Q?TlURI95bbF2kag2djsqk11rFk/NsVMSpwaxV0Z/x94YNdkWqERnRwede+YQ+?=
 =?us-ascii?Q?SFi7ElYCYIoZexYgVEOxMjwsBWlYsBgeKMqW/w8lQLUL/n2dXaks+XndEynk?=
 =?us-ascii?Q?B10i8ZVHnwVzW27Kv7Mngzt0hUEGEEZLegFcYycLYaxfF97xNE0nDTRw7owS?=
 =?us-ascii?Q?vBFW+BEcbTaeMl/jjfCRspjSpBicmcOIoSiArmJ6WC4p3G2Q55tqCuTmFHSz?=
 =?us-ascii?Q?iuXSNFSQucbWeTWObgH2q56rFMdA1ZdkvB2o0L+cNXLUnoiGqLfUaHL37K/r?=
 =?us-ascii?Q?sB1pwFcZtLecrCm4FAn+7L+1WIwbAi8aP3UuOITOTavQ4agGMFzCrbRSLht3?=
 =?us-ascii?Q?hUqkvVUc6NH7wqm1FDAmpiZmS+HMo9S8GyN/pv+o0RJ68b29uy64U6ZXUziT?=
 =?us-ascii?Q?/SLpDzLLqNesISMp9iL61zCqXN770ZBSfrTZteKDmfLHRcb2SJGgSDjKyklG?=
 =?us-ascii?Q?EwJeznpKcBRLw0rVuYKqHYAGM6xoU0m47uAJ3rlfLDcYItmt8Dtzu0rJ2m0F?=
 =?us-ascii?Q?f8vYR7V55LQNzH7yLKE1BfoCqpVU5JUY7V7VXzQx9K6TJ1eTiZKf6AR71c/m?=
 =?us-ascii?Q?gmVZJUOlqmYA0+zvNvE=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9b87a5b-0886-43b8-d508-08dcd590049e
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7763.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2024 14:09:31.0402
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4JTgKx8PXa6C+0WNAv6KnHIh7tMPYIfvCOHaan90t72dRMQ6DJQkALEUJStk3vyt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7038

On Thu, Aug 22, 2024 at 01:24:25PM -0300, Jason Gunthorpe wrote:
> On Thu, Aug 22, 2024 at 10:17:56AM -0600, Mathieu Poirier wrote:
> 
> > > -	domain = iommu_domain_alloc(dev->bus);
> > > -	if (!domain) {
> > > +	domain = iommu_paging_domain_alloc(dev);
> > 
> > I'm a little hesitant here.  Function iommu_domain_alloc() passes NULL two the
> > second argument of __iommu_domain_alloc() while iommu_paging_domain_alloc()
> > provides a 'dev'.  I don't have any HW to test on and I am not familiar enough
> > with the IOMMU subsystem to confidently more forward.
> 
> So long as dev is the device that will be initiating DMA this is a
> correct change from the iommu subsystem perspective.

This is the only call site left for iommu_domain_alloc() - we want to
remove this API on the next cycle. Please take the patch

Thanks,
Jason
