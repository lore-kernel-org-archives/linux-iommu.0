Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2067.outbound.protection.outlook.com [40.107.220.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8204821506E
	for <iommu@lists.linux.dev>; Thu, 27 Mar 2025 13:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743080426; cv=fail; b=JrDus0ZUmEsHFj85FeTzshPfGbKHEzXx0V6+8v49FgswnjhhCYAcvh9G/PYdQBwsm3++MC0URe2szBLwOfduZ8VNjPPM1dTGQtq78qwiotrPxQYlJU0q1MX9wTAeXkC0W8kJTaGtfvkirFpCP98dlq2xPpWQRUiOpmXaROxRMdc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743080426; c=relaxed/simple;
	bh=baO8kTTi85aHQdpewtfb+yaZpf7ehUttsTSrkMMCSrk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iiE6L+yRiKumzfxO+wtpvGlmds/m33EBX+ZlwyiwzpPTCR77/4Zu3Lyqfp3fyCE2ueVrmH1IiUO5mx741FGjLE2USB0YXl/HJzW3xaAd5gViyM9Aj83gJzm9AX/Va+ohlm3ScHO6JAcL5QUvJcFoqDNVaUCg9IaKv2SwykHW73I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=S9n8DPpn; arc=fail smtp.client-ip=40.107.220.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="S9n8DPpn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M2VEP2D8AZFfsjwROk/9tTkHQ0MHLlO4BHneVN5SQwzF6r4NlUkFTKjPANOzApPHdG2OyIltWw15JVr20dTsDgu2NPY8FV0A1bujPsN/w6pP/fGzFUOzwTacNDlulg7BUK45BnJ5Hn+WL56uO0byGcq6q5ZGcp9+0xs3hUcWm8J1dFTDdz+r2luwmeGusMzHnM9S9RuZu/g1Bxf6Kaqrn+21ZLIn85Op/k9ArAduogUb1STrF3HFkgBmbjljZSKdehknpbQPXm/3t01tmQ7gwid7FtABjVxNffc3FwVIRIG2f9TOz11lPPtLi7RXUKUGJK89wjI9LobpylVwsBKBcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zRFdAvd6pexWyzTb5s8ZY8XSaKKsUKESYAUu/FHONh4=;
 b=F0Kt+YDfSKd0DLBDUoUs4hmio1t5Hmdr1M7a2t4OmqCJeoiijTPV5RfMnOHZ8HsYORe16Ou8DU3yG5AmMb8dlPsvOHlOlYAHfXvDXi3i8IGiWt5PBcSKiYGbALr7l1NW6EhXO2i/C7Af+h2kL+Hio4MxxrUdVPEdAB3jf4n488obbjIFk5KBT8pNQaWR0dxgpuU6QkUinGsgLnU+gOEVChSBU58ip8ZRQt+dZ3v9Rlsfse39zFtn0gUG0ULjAFjJa/aJxwVOoPAtCN1hcKdssdgBDG/6vYyykZZlIY2PR18A/ReG3xwMGD9WFYF//cVjmbtGHq25RfsWaJb1qcRsiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zRFdAvd6pexWyzTb5s8ZY8XSaKKsUKESYAUu/FHONh4=;
 b=S9n8DPpnIIGhEAGwyobttuHdYW8aYehFXTMIh9yKrQQaBkBwHbEF/DuT3snTT3TPz0SkeWZeHiiRntmCjiiufQtf7tF2MmwejjRYJr6fFcKp2PAYz0VRCXH2dC6KgM484QPNEKY9CCbullT3rSRyMFu0+/KEGwlTqpiz8uqcctD/TXho1EXnb6qI/kPC0bUFEEZcEFYj688nRYBmtQTtz6K+RDFi6Ec6pRFqtuufzn7dgmKab8NCadbal0fGod9U3rSLrl57ba5qQQQ5LRDbSvXY8BmYMVe0cLf9yrI/wDebJzHtlmdR3Z02rPoHfwuwCxFdUi9LdIonsVcxm12LXw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SA1PR12MB9470.namprd12.prod.outlook.com (2603:10b6:806:459::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.47; Thu, 27 Mar
 2025 13:00:20 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8534.042; Thu, 27 Mar 2025
 13:00:19 +0000
Date: Thu, 27 Mar 2025 10:00:18 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, Peter Zijlstra <peterz@infradead.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH] iommu: Convert unreachable() to BUG()
Message-ID: <Z+VL4osULGr7tHwX@nvidia.com>
References: <0c801ae017ec078cacd39f8f0898fc7780535f85.1743053325.git.jpoimboe@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c801ae017ec078cacd39f8f0898fc7780535f85.1743053325.git.jpoimboe@kernel.org>
X-ClientProxiedBy: YQBPR0101CA0238.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:66::18) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SA1PR12MB9470:EE_
X-MS-Office365-Filtering-Correlation-Id: fb001141-8a85-49e1-302b-08dd6d2f53d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?daU3hFYt74k+IJBfKEaHwr7rU6oYQJH3VZa4Jqvg0EtGTnKJeg40Ml9AD7pm?=
 =?us-ascii?Q?SBP473EnsTLBAOtuJ9mGpv2X5c2UnbaxnjP+JGHGdRCZNoEo0ePsaWvSwwKh?=
 =?us-ascii?Q?la4OnZwxR+cpCYjN0hB4CZvdVR5NVx/894OqbruQ04+b1gdDB/pl7zU6EjPH?=
 =?us-ascii?Q?S9y8QX5mbKzy0gEw7zy+I7sbkD/pGyeF+xSXBfhFHi83Ylbk+Ug/zdukdYl+?=
 =?us-ascii?Q?6IlFXcCMtgsFC+p7VjpgfRCkexBuv7vUo9phS/HaoUzksnlaltWzRbSO8FQd?=
 =?us-ascii?Q?CM33P5eRt7td9BY2lxIntKx0gvEXPV568GrDf60442gowy3v87sAakfVPj2U?=
 =?us-ascii?Q?CbkQvGCq1VTjPqXUxyS0A+5RTAvo3mo651LLwvTe4RzjPAqbsHmfsblQtIq/?=
 =?us-ascii?Q?ja7fqWPAj+qIkOfLte0cs/8hAd6XgiCBu6fcyFne4ksXkEI/iGCTtf/EB5+r?=
 =?us-ascii?Q?CDUCCtPyoU0nNLvNcuAwn+EJlRLe2glEMKDSemDAMnwMswQKYOOVNpGU3MAG?=
 =?us-ascii?Q?QiBu7iPqDQ0ztdG4ajKvX4jECdSNhAhqwkaNvzz6meJ/DH1aMCLbrQgzigWd?=
 =?us-ascii?Q?ZF4F9woEX8Dj+2XamaOa78bFZkSKp/XVbihAJKFlgDSBCQ3CbHA3IBGVHu8V?=
 =?us-ascii?Q?rSWDZfd7luzJhsIoFImmpxECOMNESuo8Bu5BH8spM05pai5xEu7U5xL8PrKY?=
 =?us-ascii?Q?YbuCYkxRCgzQ/PyhlbRsIj3PVzKY87h8aU2xWGhAWpzbaBiZZ6uOo0jOVSly?=
 =?us-ascii?Q?wK+7gma8U/Whh9HGTO/+hwtfQxf2EtJ5vofA23DajpSG/M59AzRodeiNrejT?=
 =?us-ascii?Q?JIn9Li6Dmp2PN4C+XLise2+fEBB09IheIDRNZuKOp34tjRLqqV+YGzxkS5uF?=
 =?us-ascii?Q?Lxti+nTsapsLsmVBD2ZjZ64T8onNxdVaEbONOAPo+L+dUiid5u9tQSYB9J7D?=
 =?us-ascii?Q?/vGMfq5qvo1BvW1+0Dh8jJpECr5ybNyvAL6Vz7BJX7Um9bkDG1Duf1gYJV7q?=
 =?us-ascii?Q?z3gUhFVq8FS6Mt0DlVzjJd5bGGoZ7yC062AHw0FjAD0t6ww/8q39WQmJyCKg?=
 =?us-ascii?Q?AtFph7699b+AHMFsAKNPaBPhbflBfc0eLgtDxDmTum1g+cAUyHuI4Hj6EQGP?=
 =?us-ascii?Q?6bAuF6EMdqCI01S6xiNKVhSiwcdvNryImX4gNaD1iyFQ+zlf4ViTnec/6rQo?=
 =?us-ascii?Q?p0nzkKfFMxg5lZdxqDlo4ZAIE7a9n9Gi+VSbLfpfOnyBU171Ll5dYHl+Setj?=
 =?us-ascii?Q?1Yy+xk2N7k31HnRvQ2fUYILHvAKT0PseZcVxjUR6u+qdbvFafkliOOdlG2Ky?=
 =?us-ascii?Q?Dh52QEA9DnzP5ujHB3EX+kI4T8pPfhWrV/xvmZ+ihJ8Ww9CGV3UzPIGRRznF?=
 =?us-ascii?Q?FLnNCOrzVb48oTupZCvBkNOxfePa?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?15Om3ieKJH8Z0ClvVL7feNZAuhy1d33UPa/142KCyB5I42yV00UUv15ZxRsl?=
 =?us-ascii?Q?VSAphgNfnfHueQNTScIef/1DwBtonj7DgploVPR6BkdqbksMHOzwJM3uvpnG?=
 =?us-ascii?Q?WYLaCPzgjYuQtcBARxDmXHaa5+a2aSIW+yzEJ+CB/6jlySq36TkCryORySd1?=
 =?us-ascii?Q?Unqket2T8L25CilbxxelebEYys18rmjCAXvoxXlKfL4+Ptf9NxYWU9wJeyac?=
 =?us-ascii?Q?Hr8TQBuu5H1uL68Fc0LFyRhbt0qH1mSa5NdAhZVynuTUBJBg66z3MNYpPw9s?=
 =?us-ascii?Q?6eA2LNL+GZNWhmbjYBK9pwMfKNk8OyIs9Kf4pR4yXIjPDKXjdlcUBG28fi74?=
 =?us-ascii?Q?Y7jB6T17K0BIKrKR8PMm4AkbgKqQ00B5HcvYyRelPI72hjRJYGDFmW0R0QXX?=
 =?us-ascii?Q?AUGA5SCvImAP99p03YyzzYz5Nvgi78WPUUHh/KhS2+UPMgxdJ3jucN7JsDX/?=
 =?us-ascii?Q?DCB7+SdKqW9n3a+KSH7at5J1K+k7M1rhnURNqE9341GD26KoaVI2fzyuylEN?=
 =?us-ascii?Q?9/0y9e/mJ11DAyZeogdFsTqANIOclBsJOZZlRMcpIwMYsU7T7Wckr8t6JV84?=
 =?us-ascii?Q?wVuTV212fMsUkmTF3mQ3+5H4Ih19HTqT6Co6YSdFijTIk+eXyH7Z1R7ajGb5?=
 =?us-ascii?Q?Ibyj6aIX3ui3PEma14hlsP0TMKsbm2g1x+3HxQSjAYz5TjWOTnrOI5IGCh7X?=
 =?us-ascii?Q?h4nqbuwNJqX0Jol7vsLoED/pEBd3wlzDYamBo2KsiB4VGFicZFl95IpYAmwa?=
 =?us-ascii?Q?eHpO2AYDHN6qIWIrqbXDLhXtMG8KQ5+ONlENOWWbJ8MJZ2Z7/zmvjjyvjTA8?=
 =?us-ascii?Q?GPsFHc8Oe/FgV6z5JS12E386smmpsXEIEoaoDmQ7tX1mht2QhL2qN0ZKbl48?=
 =?us-ascii?Q?nAzuRLQKMYWbTQ+CdHVaTRlIm0K/jtnBLuzxHjuYG8/nTk5oaHqomZywzNHZ?=
 =?us-ascii?Q?dX9snvizCqyMHW012BFe7epDDQn449DSgH4TngksMykRQh9vyhhCCPbbre/R?=
 =?us-ascii?Q?xF82LVhfjEdQiZiCyxA2HV1dMWU+tgy5E28cGmfaw/YtpQyLJZGllGPd6gIg?=
 =?us-ascii?Q?xJMTasa/MYZ1PbX3kQt5AkhrG7yP2nS+7IbIKlIyjjuX108+kSfox4eaksuN?=
 =?us-ascii?Q?TheeTXD1XNl43YFF0r3sOs5LDcXSzBSzbjo6humDrkwf2EbSh8gKbW/4qnQV?=
 =?us-ascii?Q?0fDfi4WhKcFT7HzG/9uZOl197CNWKW9luiwnrz1P6AL4qoGRRoY8/P6H8fQD?=
 =?us-ascii?Q?gqFmyBLrFunfBdG0aV6WJh8OZwwVzvkE06Ds8ttyM3RwbslVbLuNL75rR6JH?=
 =?us-ascii?Q?fvMBzDX+LnYkQ7ihPkIUcDHZXWlfb2N7FC+IfpLuk2KP/I2CtFXO7Vu5lIY+?=
 =?us-ascii?Q?DE49uDibNtQayDX+MA5weFv74c4AJp6LVjQbURJP4jWoKOs+PKBr3VS3f9d9?=
 =?us-ascii?Q?Po5J8PyF2NDhJiFHR0oxCEUIgTTF7VTlfGIyH9vtIazsMEUmtoIq07F6YMOA?=
 =?us-ascii?Q?itKw3TNaxTNkjilL7ese+lis0yXmjRBxCMffdkSrOxiBku8ZDGAodB/EYaPZ?=
 =?us-ascii?Q?2rwFwCWKSqzj2K25KHg=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb001141-8a85-49e1-302b-08dd6d2f53d1
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2025 13:00:19.7952
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ix2LCx9xCMhKGDiFit1wqvSdEFkSCvW9t20NxWGNyHYXvoNGpSI0bpS2kR/2KqJc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9470

On Wed, Mar 26, 2025 at 10:28:46PM -0700, Josh Poimboeuf wrote:
> Bare unreachable() should be avoided as it generates undefined behavior,
> e.g. falling through to the next function.  Use BUG() instead so the
> error is defined.
> 
> Fixes the following warnings:
> 
>   drivers/iommu/dma-iommu.o: warning: objtool: iommu_dma_sw_msi+0x92: can't find jump dest instruction at .text+0x54d5
>   vmlinux.o: warning: objtool: iommu_dma_get_msi_page() falls through to next function __iommu_dma_unmap()
> 
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Closes: https://lore.kernel.org/314f8809-cd59-479b-97d7-49356bf1c8d1@infradead.org
> Reported-by: Paul E. McKenney <paulmck@kernel.org>
> Closes: https://lore.kernel.org/5dd1f35e-8ece-43b7-ad6d-86d02d2718f6@paulmck-laptop
> Fixes: 6aa63a4ec947 ("iommu: Sort out domain user data")
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> ---
>  drivers/iommu/dma-iommu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

The offending patch is in the iommufd tree, so applied thanks for the
quick response

Jason
