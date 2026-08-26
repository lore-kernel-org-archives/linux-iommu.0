Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011002.outbound.protection.outlook.com [40.107.208.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C89E399358
	for <iommu@lists.linux.dev>; Wed, 26 Aug 2026 18:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787768356; cv=fail; b=CeNppBJ8QZJz0AarnQ8sKNP62KnBfjtaKjP/dGsbvDKft7+66ybHboSy+gdIcyf17beUd4/mE943Mi+GL8LQy92krzXZ3qcgjh0+NwsHPW7PdPnya9DxPgRALAgQQN+ZVQMC1WuIk9+j5dwG9s1dPgOYE1vEPPE0BZ4kpk57bBc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787768356; c=relaxed/simple;
	bh=Ae3aY/512AUijuAvIE71UxRzoW21aoZt6aYLd+Zi9+A=;
	h=Content-Type:Subject:From:To:Cc:In-Reply-To:References:Date:
	 Message-Id:MIME-Version; b=IcUVAXmPW6Vjk6+vwHNHXXMtkocT5L0gD1y4KPT6ldNdGKxWUNYKMsNOSK6WfTSJk0EcyQ4A+5tWnFejeGdHhp5LO8+Uhqla7UdSb3BJzeOFCiI/4AhcZUFwU8RpiVLiK6zq0jtdr+45IYFIxjSm7i9I3/WVeQqbazYs5gZipF0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qWAXUNSB; arc=fail smtp.client-ip=40.107.208.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qWAXUNSB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aeyv71py8uf4cTc1xAWJdL335L81KME6BXJIza5QJKqqi+DVAz8Ezuly3SXYHEZyIRQOzzsZdeTnQmO4bZju+rhSbT1OXFdjv4OhKfw1cyPe1XNV9+p+dVIRNTLBPjgbpuVarQ690tNbD9/BtUsrbedcPKsEHFDv+X58t+w4w2btTR82+igacqYsw//nodJwuIYLvRkBdtemXbDBik8rgKPGvRvzAnbHIg3IKnMhl8eRnh/dXf/qO5ca98xKXz+S/OJkXcljQ8m2Fus75iXzQd18EQRyJ1l6sniH0mnO2w02yzE4EXdHvJ9q10fXHdFa27RoE3v2/au+a9bfn5V6Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k+oZbQbnnfmQOjZcOf9yyzWbvlcIyJ2yqZDj3w2uUcA=;
 b=NiKo0hxSVWKLG3im/LEYfm+BEBchCQtFoisjBy2Uj9CnngxoHhexxnuaEdqiVbds7CfSCYLzihF8sGOX5QQLdYC8JUioqE3XvlmF8TvpihUZlJ8tv13BccYmfu3lzib5yHAesnzK100QHufYL4viqoNwL6AMa7i/kbdfvusJfvAJ7DKR5HGc7L1t0NOjMwaCFgHt3FZqNKndci5aEaAuC2Wxwhg/vlfIxCMQK2Cn7EVC2zIpNDjnMX1/XQqJqm2DMiB/oLQTb3Ns1KIsdunwhPlbsODzFqrTiubi9k1IGyfDKx5OaUAZmuayk9gP5+dLeVgbKvBF/+4KIq/C7Q1Iuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k+oZbQbnnfmQOjZcOf9yyzWbvlcIyJ2yqZDj3w2uUcA=;
 b=qWAXUNSBSFpkNGHbENos0/fe6Hp9n4Ft89CZe8X3k662OhH6KYnLvkJ2dSHMVcRFPuhObXAmND3rGfnQTtf0eC2dAY1RVFnyRyakBvILfZE7VwGXlSMl9DFm2AD4Bb6IqLoAjpE38IL10Z+Vs3CMCjDmhmTRMXUsM70ae+osPshV/0a8dQTXlPRMcJdZvVeDfKNn1TWf+epX90jXSj7VJRecdx2ulgMd0fLo36Sdsd2alpRwi1W9qfgjHdoqq32U4ZqD2ac9DeQGsN2wTrFFmYE0USCGGTmcnzDXjQh1xRtLsJWff6UIKnXDGP7eHU3C8Qb6ZQkXWlt67CSu2LoN3w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by MW4PR12MB7437.namprd12.prod.outlook.com (2603:10b6:303:21a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Wed, 26 Aug
 2026 18:18:48 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0360.006; Wed, 26 Aug 2026
 18:18:45 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 4/5] iommu: Add Broadcom BCM2712 IOMMU driver
From: Jason Gunthorpe <jgg@nvidia.com>
To: Daniel Drake <dan@reactivated.net>
Cc: "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, nick.hollinghurst@raspberrypi.com, 
 james.quinlan@broadcom.com, Jason Gunthorpe <jgg@ziepe.ca>
In-Reply-To: <20260825-bcm2712-iommu-submit-v3-4-7f143e7289b6@reactivated.net>
References: <20260825-bcm2712-iommu-submit-v3-0-7f143e7289b6@reactivated.net>
 <20260825-bcm2712-iommu-submit-v3-4-7f143e7289b6@reactivated.net>
Date: Wed, 26 Aug 2026 15:18:41 -0300
Message-Id: <178776832191.3356902.9927042211862758454.b4-review@b4>
X-Mailer: b4 0.17-dev
X-ClientProxiedBy: CH0PR04CA0038.namprd04.prod.outlook.com
 (2603:10b6:610:77::13) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|MW4PR12MB7437:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b63d02c-9cef-48d9-4725-08df039e76dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|23010399003|366016|11063799006|56012099006|10067099003|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	qu5OMAD83SbAZa6nUh+jcfL5qbZqgUuAm4E1FoHfqOji5Lg+qla0uSY/dTuyPGEIA0lHX5cXEC9INymLnp8AqPcQjnwRS7fjCH7Bcxt7VVivHe4KFOKrfMg7r9/W7W+gMUDQpedCqx3r/pdbZhWP5/WPaxD2ALmME6q20YIxY+6rZGEuo/vpu3JytF12lGNl5PWRI5Swsd6YxUR9nWrVoROx0vZu+wQg5yJwqQgc48WznzNWqVspCX+1l47enmP6eft51sciC0nT9g0L594YnjjEqhkNSLWs5KSIWWTRoW/5RcWumnAYy1GGtHWxI4L5KMw0Go/PZ2u0jvOpJkXAZfCpQGO7G/qSnB9U+PMhBpXWA3Q9ivQfayx+mgf9CPpr9ukhozOusKRmC2YuXvnIKUq/fAz8gqhCVHZFp35yntzackH6YKw0IfN6j0hX7E9DkL72BoAS+xy7glHAaqS7FkoKUjgPs4aQ6ZRVPJ1FLCTNgi73/53tdmGbF5ZqLirdtxZXgPKcNkb06koy6W2KcHKdpporTQFH6yml//g9VKidlF1S1NLDzz69nmbMLuIYbDCHT+4eEdjcM1pX6+LBBRs1P/aF701yUAP2uUbWEqpCiXbc9h+Ht3Hi+/jSoUwfPjm2/hK27C6qQJPwLnLuq5SjSjtxu5qK4YATGAiOh5g=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(366016)(11063799006)(56012099006)(10067099003)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V1IxT3JKT0pkVnA2ejJlaGxsa2FDaitZVnVDbExyNDAzS0N6MUxsUkF5WHVn?=
 =?utf-8?B?aURFVDhma0Z2cjNuMTk2c2crTVhBUUhLYnBITHJ0NW55NWVzUFZqczcxQW9U?=
 =?utf-8?B?ckM0c2RERmh6U2ZzOWE1dUZobTRRUWVrSDFyR29WY1RjeFIvTEpxeWtKT1NG?=
 =?utf-8?B?SGFYUGV3TFlkKzhmSUVzMzNZSUx6bVIxRmZValpWR29MWUlEZEhtRVM0SU5K?=
 =?utf-8?B?blc4LzB0N1hwS3hnNzJnVUpHb09TY1lWbXFMRE9BUU9Sa3ZYM205bzBOYjNn?=
 =?utf-8?B?VEZMR0JQMDV6MklnbXpTbURGdXJLdng2N3pDMDlSWUdidUtOTTFJQ0dmYmRD?=
 =?utf-8?B?Q3E4cExZc1FjT1RET0lrSzZxSEtmYzJETDhKblYxektiUDBpTlJaRVhSTUZo?=
 =?utf-8?B?TEpiT1B4anE5bXZhRGNVN3oxN2Y1SVhBd1FiVUFFNGhYeFE4WmlCdllIalMy?=
 =?utf-8?B?b0k3OW5QZHF2bXQxcVpGODl5cVp1UWdaNlRKM3RHa3ljbWRYdUF3YnVOanNL?=
 =?utf-8?B?eXpnVWNwTkhVaFN3WFNZSG9vNWtJdVJkcTdXb1JQbVp2eC9XUFRGenpmaTQ1?=
 =?utf-8?B?cE1WdDFqMDdhR3ZOeS9RTlgrbCtCc3diQS9lVWVjN2ZDeUQxeWxNbWdHWEZq?=
 =?utf-8?B?V3NlQjAwT2xYbGtYRVpSbWZ1VVNvSjZ1QUJQQ1RvRFBZbGJkSkNOblJZZ04z?=
 =?utf-8?B?UUhUdEljL3hFRGluUFhHRDRkZkY1Z25IVE5mWmNQUE52TTNvRzI3anhDM2kx?=
 =?utf-8?B?bjdIalhDZkhqMHhLd25YVlBZZGN2UzRyNDhnbWxwM0FPK2RLRWNxdzc2ZzNp?=
 =?utf-8?B?M1kyWkYzSlRSTk1LQ2E3NVNaN0ZUM1BpcmkxeGxURUg3b0xPQjg5c2NaZE1Z?=
 =?utf-8?B?bjlOc2s2SjZldUdIMEpYZjBjbEFrYk1tempCVEtwTmwzWmJLNEs1RTFSd3FG?=
 =?utf-8?B?c2xSTTNZUVFqZmNwa2RRTHdhbEl6Tk45RVczSlZCc01RbEpyekxXSW1Nb0Rm?=
 =?utf-8?B?OWRKTUdZSjRrZVd1SzNHeVltLzZWNlZFaXR0dWZnekZxSzNCUGJrYXltQTI4?=
 =?utf-8?B?OTFYSnRkTm9ETE50YVlETnRCanpEemdQeTRoZlAxZTFPQXlubXIxM1lNVWgv?=
 =?utf-8?B?ekRRS1lrcWw3UTdGZlROWHNrMUIyR3NNRzdqcjBWcTZhMVg1N3UzdWFRT0h2?=
 =?utf-8?B?RGNOOURXcHNkZHVybkhJZURKVTdNbTRPS3g1R1l1dG9lMCsvcjF4S0FPUFo4?=
 =?utf-8?B?VnFiS3AxVjdlYTBCNEJ5QytsbnUvOU9ZU1pJTXdHWUMzVCtYVmIyMGdqakJD?=
 =?utf-8?B?Yy9DcFEzVk1CVkpZejhucUhwZk5OZXQ4b3k3K0czWE1jcWZWajhEU0lUQ0NR?=
 =?utf-8?B?WWFRWXZDdStyY2RvT21nbTVBZ0lyVmExejIzdDZVa3RQK21MdzlCekhLd0Jz?=
 =?utf-8?B?OGxyZXRReERtN3NMZnV5V1puYnc4RVQwakRGY0g5S2lraVlNdzlJK3BxR2pY?=
 =?utf-8?B?UU1FSG9GOUJJejJEaGN3dG9QbEIwcXRwWXRQVlZrMTBwbURaS3J5b0tpcUlX?=
 =?utf-8?B?R2dHRzQ5c2Q2Q3hQRWlLTmhwYU9rK2lWcFlKTFR3UkVEbVkwWUxzK21kSHVm?=
 =?utf-8?B?ZTNJdnRlZ0NPZExOdWcyQmhsSm1yS3JoL21RMWhtQUlmeG5CVHhWdmFUcjNn?=
 =?utf-8?B?Um9ObUppMmFFcW1RU3JtRU5OUmRyQ1p0V2J0dGllWHhDZ01IbFpCRTQxM20v?=
 =?utf-8?B?U3d4b3NGVzZTTWQ1b2JUVTdFbFBwQms1RnJ6Rmlsd1JDOXBRVzZlYTFjUDB3?=
 =?utf-8?B?WHFxMWNGRDQveENaUWVaOFpvdDFhc1JpOXRZaC9PMXlHZzBjOHZyY2ZMMmY1?=
 =?utf-8?B?bFBEaytOWVJSUkxaNVhMamMrMXVhTkx4S0lUUWV5Q1NKNHltaXRqWWRFQ1l0?=
 =?utf-8?B?V3FrMUEySzVTS2xiNGJvTzlyYmFpbnZBWlJ3cGZ6eEk5VXVqeVdZTTByMlhL?=
 =?utf-8?B?ZGRDcHlJUGQvNENSYnpCK0dtNzc3b3VrU2RjZFh6N2kwN1FFVGJGTGpXYUhq?=
 =?utf-8?B?K1pEd2FPbjdIWE8vYUVkQ3N5NzY0dUZDODY4MTdqVUFnWDB3RHNQY1BYaStz?=
 =?utf-8?B?MXo1RklkazJtUE9PYUNJbWg0bE5JcnR5MEhpK2xacXhqNzZvd1A3clpNTjBq?=
 =?utf-8?B?elNkSVJZaG4va1F2YzIwZS9EelZrN3VZc2FqRkFNeEFFaERzd0xybVp1b1hR?=
 =?utf-8?B?bFY3Z1hqd0NTbnJuSXBHNVA1MC9YL0lrMXBuRWNlYnhkOGU2YjU1cW5ZaVhk?=
 =?utf-8?Q?C2NNCpIgGunt50BfJp?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b63d02c-9cef-48d9-4725-08df039e76dc
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 18:18:44.7032
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MiX6I1/2yncsjyw167Lls81mm6SpoXS3Zu8AMntqvCNX2wPFntGYhIeFQ1daKdRN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7437

> This IOMMU translates memory access requests for the VC6 display
> pipeline and various multimedia devices in the Broadcom BCM2712 SoC used
> on Raspberry Pi 5.
> 
> The driver uses the generic_pt framework to manage the 2-level page
> tables. It also provides support for the centralized L2 TLB (IOMMUC),
> which is shared across the SoC's IOMMU instances and must be flushed
> when modifying or unmapping page table entries.
> 
> Adapted from Raspberry Pi's downstream bcm2712-iommu driver
> (original author Nick Hollinghurst).
> 
> Signed-off-by: Daniel Drake <dan@reactivated.net>

This seems OK to me.

The sashiko remarks all look wrong except maybe the bit about leaving
stale entries in the IOTLB and leaving the ILEGAL_ADR_OFFSET programed

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

-- 
Jason
