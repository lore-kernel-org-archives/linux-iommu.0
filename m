Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2058.outbound.protection.outlook.com [40.107.92.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9658621B8E7
	for <iommu@lists.linux.dev>; Thu,  9 Jan 2025 14:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736434477; cv=fail; b=eSCZZIRYRhk6Ai92g0tK1tHVnyuWnZ7tr9CmKZ93x6j3BwE6GR9xU+jDmdThc811U1nB93WQRmKymA7x6zetWnZhDSWwLlbYpHU0oci2d/VCc9c+kJxe9O7zMiPdxgWlTAYvv4XQod5uQ814u0SkLDyTDLn+RBfYyOC4hS8SlqI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736434477; c=relaxed/simple;
	bh=N+SNU1rYnerPSgISY62aWQ+dNlT1H+2fVlrn/IMOkR4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RY9I/BWuv8c8JSqRy2S3WsojOatu7fm6PvnQ05E8P3QAXu+4e2PvPoHgYXy0CXdmNjY2/HWDLzARAou3GSos0DvRzQq+DF42C6PRDR3V/rh853VUoNfYtro63DrtRaYi93hQCvLbd0D1x8aG4cRe2wTD/NmaldjTzSr50Of32XA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tikBxrj3; arc=fail smtp.client-ip=40.107.92.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tikBxrj3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eGKxXuwpx2LZn/r5La4yh5XTlZ/Hw1UMgPwc4Qua3Y+hhsgKqi+xSAPa9SNuus7j8YVmWknfukOMndi3lro2uvsw66cIJsOx5BMjtRG0DKQDdgSqyVwqdoRj1ePh7qMaW1rGi9v41kVJ0zfNr5kXeoM3EjslhmpC7B23X/qtgwLCP15z5MoeyRV7lmtH7UBcZplL0CAzebNKVkL/G3hWA6kJCoqcjpIOWtIeKR07nPdoJgpoHyd1I2m37+cSgUyz6qZEG+/572FDdeX8wlsFT3CInmbSWWH9BulagEPbP026YjVLpsiYTcfChPpdDN9I+Jx1xPHAXRh2iqpI2f0FAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LuFRl/XjjD7i4H+PknJRyzcqJ+EUDUZE9mfpBGOmiI0=;
 b=RJM1z0rxgXMqZAJas1KoTztPDC3A2Mt22PzkpTsnl761/RdzbxMOiFpXx3IWdnEKFgqCcfo71hH6ed91o5hpfdcidiU9FJC0lciwWMq2f1QFKS6Zxtq40fnQWDb8tIjKZOVm+Nlp3IAoT/L8EvqCRoiUb28LvJLwtyPrM9fWAXCYU3LBflfamW8EiWME4NeHFDYWH9Qbopi6h/mKNL0IgsqZUccP+AyC6bkoB/FkSZb4ylRndd9nNhzPXe7dA1YW8PaGtKbrzkPLlJ3AVlVzo2RPGPOf3wWmW2pN4uACIu+k//PrjUWy6JGeILZMrs++cFKiLnuksE5LEnmywtOqwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LuFRl/XjjD7i4H+PknJRyzcqJ+EUDUZE9mfpBGOmiI0=;
 b=tikBxrj3At3d2taiOzbd+xhPnVJeIslcZnPm9sX0qTay4qZ95qoWgFxQjq97YYpQkCakVs2osl6v/UnAWTobDDur3h+KIO5C1IUN9v/D+hp2tBk8FxtU864vyHYxpLV5P2FGjUREc1IvG4VGTGCglvCtc7L1CfnDARXv7i35P3E90nyiO8D4HgvA4p8F6Wj4chUWf790I21bThPKEno/liNmFwWVOMN2vzPtouS3NcK8ryWGpCXPqa0GQbR2JlHb/Cf3Lr6amq740KMDMnXrtlrmBFT9zFvqLpl52/rx02vZ7O9Xmn2Dpst7Th41qD4FFOACifABHQ7zUYTM0XaD9w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by IA1PR12MB8556.namprd12.prod.outlook.com (2603:10b6:208:452::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.11; Thu, 9 Jan
 2025 14:54:32 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8314.015; Thu, 9 Jan 2025
 14:54:32 +0000
Date: Thu, 9 Jan 2025 10:54:31 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Yi Liu <yi.l.liu@intel.com>
Cc: joro@8bytes.org, kevin.tian@intel.com, baolu.lu@linux.intel.com,
	eric.auger@redhat.com, nicolinc@nvidia.com,
	chao.p.peng@linux.intel.com, iommu@lists.linux.dev,
	vasant.hegde@amd.com, will@kernel.org
Subject: Re: [PATCH v6 06/14] iommufd: Mark PASID-compatible domain
Message-ID: <20250109145431.GA5556@nvidia.com>
References: <20241219132746.16193-1-yi.l.liu@intel.com>
 <20241219132746.16193-7-yi.l.liu@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241219132746.16193-7-yi.l.liu@intel.com>
X-ClientProxiedBy: BLAPR03CA0011.namprd03.prod.outlook.com
 (2603:10b6:208:32b::16) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|IA1PR12MB8556:EE_
X-MS-Office365-Filtering-Correlation-Id: 297d9cef-eb06-4634-d251-08dd30bd8676
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UGNQL0PsN18cSiY7jRqPyFKwF2auW/tLX0pI8Azs+isVzmlqa8yeVZkPlK6S?=
 =?us-ascii?Q?MpkDTOmq7UChnd4EYvN1VbX2eUslVQW4kWquacpXXa18zxY6B3myNdX4bQLv?=
 =?us-ascii?Q?seUTINBw0k40+7gOSGiwHQCatRgiUa1tkDayaIT4ztBrU4eXdUac1R5gZj2l?=
 =?us-ascii?Q?caie004rfUstIpSIAJarH6rUhZDy7zOqP2Zj9SfCWy9mwS51CVMXI00Swd6+?=
 =?us-ascii?Q?X23yTiq8sTyQMkZOEQb0Zvdj4gXyYOjJnTtozQnm37d5zqUC0+tbnZ/tU83S?=
 =?us-ascii?Q?VdAaVgSvOR8efwFUqGDjF2aYaRykDZ08Y+m5rXK80at/GRvgNrJiLTJkLaLY?=
 =?us-ascii?Q?JBYmgaTQZgAv4pKG8sAcya9YBg3SvZd/6Vgr1aYlVqcuokWB+smknDpdTMqm?=
 =?us-ascii?Q?sd4E2KcvMjlN1Iz5drqt4E3rEnVF452JVKiDhMxHS3hkGitWp7xvA6YIP5wp?=
 =?us-ascii?Q?u0l3BSpvKQlO6faqnUMMVMkZKqL/d+meiJ8hmlO4HCxk9/HUtu/DiPZzYH+X?=
 =?us-ascii?Q?NRzgDrRIsytvc2oMnLNAUfuHSy6OrXnrsW9rkXMjvdo9aiXPi7lifZUyOtTo?=
 =?us-ascii?Q?meopHIKNQ548juxBqU/GGDS7w8hNDTwhGoYBPakdlf9w6f6UcILQ2DeCuh+T?=
 =?us-ascii?Q?1Ek43LBhtfsdUE0CmS/3z8b1N5ZGJaJ1tiK8rqkvVm4lFV04gZhvypn9nYV+?=
 =?us-ascii?Q?qn0ADBw1lipLa7L1D2SxxjgO1r+pjAoeG2NUFp5DYeakLnsnKqHVZ76WNlCA?=
 =?us-ascii?Q?hMoeK24e29Yl30PKG1+w3L6hQuvRslWvQ56glQggcfg6NZ/uwP5LY2aus0wf?=
 =?us-ascii?Q?lZG212RE4WlZsKrmWu31ZJibdWSNMbidLF8bFwl5W37pUqDP7iwUw2+R/mDF?=
 =?us-ascii?Q?lgpyR2dzNbJtqYkPnTpfTbIIQ64XO83LBviNIQvZEg1cbOMX1xRyTBGyzJo6?=
 =?us-ascii?Q?Hn8KUTTtuO4j5Sx4nwIFyjdO4zMNQwgTErQN6Z2/QgPhJ1omc+1KKCOKwNm/?=
 =?us-ascii?Q?4fDV1GOw6lpswm9WxMUeLjcHFvPEzg64ndSvLLgWoBW7gGhrVG8SWBuUkRLJ?=
 =?us-ascii?Q?6ti0GQU3SCdp/HMvIlP3N7sgWXQA5Tq6VmTsS6UI9/WGWyld8yCAjHqU2S4I?=
 =?us-ascii?Q?KWZanJ+dUv875+jfh2K0S+dXKLYVho+KZNJCOTwu/OyhFRI2tTQXGC3GqoWZ?=
 =?us-ascii?Q?yLFdVr/PbTn8cEhpSTOTpdbaIzJ36La5OHwo52dk9YudANVz/SrQ2N8EOBos?=
 =?us-ascii?Q?UQkOVi4RUTP9in2jIZwkQTlh4SoNs/pdWtCL4spnpDJ+nov1Y4yztsy6KjTW?=
 =?us-ascii?Q?sv0jRzRrG+51RWH4R28h34JyDgQcJTfhogGtS9NoEnbVHSl6RT6kwoPRWrUs?=
 =?us-ascii?Q?wz1txT2Z3NBSDnNI3IWBzOpw6g+5?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QRuA4VzGe+rLEkcUUzUWisxA0ujQltCpaoFnEOq+SiuRHs3645iAHcGw0CG5?=
 =?us-ascii?Q?zxWDLWbIi3dOTkXKXz2Pns9uSPwVM4hkP0dz2zS/aX6KJXVZ7TidgB2k4JQC?=
 =?us-ascii?Q?A8yaYolUzUm8itEsWuHFU2RF2c7akyPIXqlPqMrKfv3xSMeKSAOP2eSgsbul?=
 =?us-ascii?Q?LWEqbuCHM/g2wiyzjo0BqTbXmOmFinCFaXQzp2bnSNa36/M0ivXmMWiOEgqx?=
 =?us-ascii?Q?VzEyfUFITQm6Lm4cYl65ZtVUrh/mS5JwDu1g4ebA4/zNREqtzjJO3LZaLPl9?=
 =?us-ascii?Q?+CSdZn1SqwKEsfo8fhxBbkQJNuxOGBvZWOFHcms47WPTJ+aJDBNFtDjRHNP3?=
 =?us-ascii?Q?OKfcaWPNOvuMsPZfXAXjXKSqhgtnHYfxSkVVjIeX9TAest3D9YeuyD6wjjWe?=
 =?us-ascii?Q?tbR2U1VLT+rM4usoteyT2JSojKH6lyGflRMuddJ1WQIxe19yDjzmfF1fsIT5?=
 =?us-ascii?Q?yPvFyVudWExuqDAryjf6HM7nyqp93E9lorq3IC8Wje/Wops983WRDUzITGQP?=
 =?us-ascii?Q?5Al6xYwyLlSj5GjZbUbXxdTdEYh8TOmAiy9tznD5t3DF4o+FBqUN6uoa8RyX?=
 =?us-ascii?Q?rcKuAFKJUBOoIrs1HNY+9LkNSYxx3dURKKSJOA8UOtm/WhHTgoNPbfkrp+d9?=
 =?us-ascii?Q?ARLYiupLzhbILFg1M/NWqyEc+dyuHtXhSsdaZRV+3rHyWPv8cLFDHh4djIzX?=
 =?us-ascii?Q?Su4ss3gC61mCEB7nCm5KZY7RRuZh3mpTbE4V1ypbc5bTB9zCofmBTnB8BARD?=
 =?us-ascii?Q?jEIJRXS6AxcGWgvlglYk08YPubYPcABVDREIR5EXMXEI1nGkYD7VqXrT2nic?=
 =?us-ascii?Q?OVjYfncFFoh3sjX0o33SjzvaGZDiFJZsKG6w5v1eCC1NFLtyW+kPfNpcS3aI?=
 =?us-ascii?Q?1lC57nMzxHEDaw/o6cSmDKhKCWr9B0ig4Z84c72SUPZ+F6C/HuMF1op04fZP?=
 =?us-ascii?Q?5apki0x7QMuVOrrDSj9vnlpQ0L3muL8jcJC/Bno1qj5p7HsNRVeptkNBlrzu?=
 =?us-ascii?Q?hCeL2/GmQ/oFKqpuZUkefLKwMl5qWLXqFWw/2gkppueriqNlPKmzSpIbcVvh?=
 =?us-ascii?Q?oYLsSQTPFTz3zgcIXeqYzyzhB8mMRxGcaujaQkbtLR9SUZeR/5l5UnvqocZ7?=
 =?us-ascii?Q?4MY4jKsTCyFmUCDmOdzDcXmFkCsdzOZclbNAHiLO9JaH8aQzvZ8uovdhRbGy?=
 =?us-ascii?Q?1OOV8JJJyi5Ye8z1bSPSVkrSfm/8yMtyQ0np7iwAdYGVOv67RhN0EKYdzqcP?=
 =?us-ascii?Q?lUqXSbTwR1yq5yl77epB1OK3tNMN3gOcXrvnzu/qrR9YA/uaQ9f2dIY34i/M?=
 =?us-ascii?Q?TzNMMvXY4+xHBbI4Penx93Ji5EGcOToxTTBMizExAkyNNWGDdFxpX9yd0DCx?=
 =?us-ascii?Q?UQUVB5A1v/i57CmlSJkqiHPcDQFnCiTLiCprP3ghqEORGMSbw5arxpcWKj7q?=
 =?us-ascii?Q?XQ/8KAZ7xf8tZTwrADL3jHuMpDedUUHE+InZBIDsYYawJZjoGCJHbkJKM1P3?=
 =?us-ascii?Q?qw6FqS+UFGQ8x8jkuOzLmHEiC3fZYiX0chUZTw+31RTTPeZwQBlWXRF5NUgF?=
 =?us-ascii?Q?d72OpXW7BaS4dh4YmUz2L2ji36pG0iJLuObu7bMb?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 297d9cef-eb06-4634-d251-08dd30bd8676
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2025 14:54:32.0635
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dZjwhtvQ82UzZvEvkwJ298edpszfPSBGhQ/9FmoGyCFHy98nu9GDM9zoVn8V6uBC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8556

On Thu, Dec 19, 2024 at 05:27:38AM -0800, Yi Liu wrote:
> AMD IOMMU requires attaching PASID-compatible domains to PASID-capable
> devices. This includes the domains attached to RID and PASIDs. Related
> discussions in link [1] and [2].  ARM has similar requirement but does
> not need extra hint from iommufd,

ARM does use the hint now, exactly the same as AMD, it is merged:

https://lore.kernel.org/all/2-v1-0bb8d5313a27+27b-smmuv3_paging_flags_jgg@nvidia.com/

Jason
