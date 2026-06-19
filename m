Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013066.outbound.protection.outlook.com [40.93.196.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CAEF275870
	for <iommu@lists.linux.dev>; Fri, 19 Jun 2026 13:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781876430; cv=fail; b=AMNsFomYBMKgWnPZ0TR7bmMsAQMgHd+0VgT7YNCNUh4mtgaXC6EaSSjKyS/Txw/bvOPFgPhAXtiUQOsZfCxgtwmxafOg7gEubNxEYN6tdLVzFk85IAThfomIagibBe9fBMpx1VyDMLEU5RoRyh3TQLfA3T2JB3WvE8R+HIuRvbs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781876430; c=relaxed/simple;
	bh=mgtspi8d1+f7AiZ4MserR9+ue9V9CwWn+YPxJ0E4Ao8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Aa+y5DCtyriEDIxReywsHd1jLNT10wMc+4cKf8LdTFQUCJF3U87sEDDrIi0CLeZtpO3PlWwG+ZvTl7+dLc3hmfLrhpBpw3V6MVRKdpsdvnsTiRZGHtMA34eMW6gZt8Of9rwnOYnQkna4mv/JKxLzTZInZhWLAiSJeM8+Pys0dYk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JRidSRl1; arc=fail smtp.client-ip=40.93.196.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JRidSRl1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rPjGoHIukFWt2Yg8LNQuwV8CnsiJnAJZeworrux+EEQlj5y7deHZrPabfP/Fsnv/gKMhy9jKzBZHih/U1H9G+SaRr6wpTzP3wJ4tqAwMXjbZHL+7h7IteaRZKftDNiNj+3WlOeog49OBRnWMwl5VuGY36I7Ka+VfTr71+r81PcGcHpQPbfSD8irIVZeq4Ap+hTfniy+dy9FnyBqW6n/zzO2VlDLUzJRpa8pRkDbsrdA+5u33bbaeZW4v1WFTZhX1dW45Gq6JkX/NgOfJz/WHNZe5MaiJfl2HehQJ7y7of+1C2aGFQGvjk8wyVgFHw9Z+nKoSv+YOfzNnDtpveZHDTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mgtspi8d1+f7AiZ4MserR9+ue9V9CwWn+YPxJ0E4Ao8=;
 b=OBk6Uqeo0j3J8VqDlJMS1rxkhm/TTNUYzXsRQrufNs2MDq6EezXir8Tga5F33TyT65S+YfUsE/B3BJnwPj9EnjaLHIp/h9dvmcANUeBybcUz9DHSg75qYgNIJV2hJnZ9yTuIrLXa56rJ7/AKdNVec8Dz12pS77HOe3ieh5L9mp4xGrDCSIOb3x4J3Lo20SKHqfW6DofvwpDVTTtQE4fPZeb2UUglqt56xw8d4DqGyqH4/oEhKuQcZzXmJMb/bIMipPsxedmZ1X0Km6Qd+g5+GbtrPpjCSYs2DlXcxFN1/BS2tpeWvwJmNGoykFVt8TAGKeNkCjDs1aCaeRW9aDw/SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mgtspi8d1+f7AiZ4MserR9+ue9V9CwWn+YPxJ0E4Ao8=;
 b=JRidSRl1W0lK4DgKmt2FKtd1bp1RrzT9bPlAI9PdlaBX3uw+J6PhZuNcmU7OUogq1ePREx9or3YBwm7qwaSoOQjmUSE4v445EGaJE0TIESfMvFrwEPlAUu5WsoVOTJGFlC6JdvELMHA8WBenkkK/Ulx7mAe6+nqJX+dPpxD4Gj/BiMcsZdFSWQI0wuwHzPMhFO6t+3+65xZ05BbEMe/AhgABPBxh/xVop5QSZoucqDnL7m6f99kg1vkDzcdWG/O2aVmc9HSwCGa69fa5ERoc/nMHik1LWM8ss29TRWf1kBhKYWuun8PzCwyK6G0jjxaFtgi0wpRYu3vryiXrx3N+hw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by PH8PR12MB6844.namprd12.prod.outlook.com (2603:10b6:510:1cb::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.21; Fri, 19 Jun
 2026 13:40:24 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0113.015; Fri, 19 Jun 2026
 13:40:24 +0000
Date: Fri, 19 Jun 2026 10:40:23 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
	yi.l.liu@intel.com, kevin.tian@intel.com, nicolinc@nvidia.com,
	vasant.hegde@amd.com, jon.grimm@amd.com, santosh.shukla@amd.com,
	sairaj.arunkodilkar@amd.com, jay.chen@amd.com, wvw@google.com,
	wnliu@google.com, dantuluris@google.com, chriscli@google.com,
	kpsingh@google.com
Subject: Re: [PATCH v2 21/26] iommu/amd: Map kvmfd to shared translate device
 ID for vIOMMU
Message-ID: <20260619134023.GC278945@nvidia.com>
References: <20260528051738.596013-1-suravee.suthikulpanit@amd.com>
 <20260528051738.596013-22-suravee.suthikulpanit@amd.com>
 <20260601133552.GO3195266@nvidia.com>
 <f07d767a-3e16-4598-b7c8-a36b5315a38f@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f07d767a-3e16-4598-b7c8-a36b5315a38f@amd.com>
X-ClientProxiedBy: YT4PR01CA0029.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fe::8) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|PH8PR12MB6844:EE_
X-MS-Office365-Filtering-Correlation-Id: 2eaff72a-cc54-4cad-1653-08dece0850b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|23010399003|1800799024|4143699003|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	rt5btcWK9KvkAJ20LBRmy7cmBmROORYXaUx8zDUUMgtgQiBXrf8WXGzOEjTfB3HBlDzBZ8PKTpujnspnvt328/0uOGPD2HJv6yPdlaaZZp+YpxlASxagDoBtYoUZdp/80w0S8iSOmoel/0hfz8HZzj4G5SqWPpcBOqDLTFRZDk06luCE2oHENZVze3uIXIsb6mig8+SctRe8Dr7cRbyCWlNohQTlag3CZ0eqyrFUlZEGl6GFZUZvxOgb8hgSEJScGINgYPxA6AagK7/eyioulCjv/8l6D+CesN8pVLPRUHF9M0y8krxSXO56O75OtND3hju6YT9pMuXmnEQjZJxkMxOnNjmtbKtDxuixZ5mp3aS6Q6uUK5Jy3Dp6OaGP15FVe+C9oVhxexldMNoFbW76uX8fF6u/EKcXBUP4InCQKv8WwSBfL2VMcIIQnXRaiv8+0aK/XVEkM2l3+7F3NmW3yEUE2TfWDs/w9PWXe7Joq+5D2KlgjbM5iqFdhISeppLdmkqKhF1vNbtg9+xn6cDLfqNBlnX23Uoi9ergXj9s7pyeitGHeW+g04Ut43qpqbpG5O6iWjGGC906Ww1bZjvsMCFNyDzp6zF/Z48L69JssI2kIVllLOouq8lCTod5ugDt1ZZVCbscMzxgHR3x9ZZMaCzwDq/UqypEZqAiijEX7fA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(23010399003)(1800799024)(4143699003)(22082099003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EIz9oXVIikHeCgt805eidh/DXn6VoT0QVRkikpLaC4agu2gPODlYqYHgY5xZ?=
 =?us-ascii?Q?NEpSia0HDFPPsv6HEpc4YFO+Zv418lpGSPIwaBiLMbSdjZbS5JKb9SVJFR+c?=
 =?us-ascii?Q?wE5evbMSUtCNqCHsEwAnmN5TrKuEKV4V6y92Dmjo89KT6ujKfvhgDZI7uSDm?=
 =?us-ascii?Q?PW+rYE3nTtR13K8pbqJyPCAV0DfpRaCI8ncrurrIEcdJzbvVrvWZcGSmKNx6?=
 =?us-ascii?Q?06X7d6x26+8oy0ENBX17Fm8+iHynlSg3rGTfGljSlYDM/iHl+QCckEPGowSY?=
 =?us-ascii?Q?SWGx5ahaB/c0zeoaXUpJvjxh6iOQGHXRL5WTPPwTAAN1aBNpztwcRScKdfoT?=
 =?us-ascii?Q?0EKQ8ZiiiaPWJy/aE0ouWVmZIim+mOoHZU74NbWAFFRI9+IboYmwc2UMna2f?=
 =?us-ascii?Q?uoWDHZ+hBpFYUmhmPQ/1P9QoXjAoMJn4DNezlVV8iwKFdGBWjBkAgXKo4iz7?=
 =?us-ascii?Q?hKhHICAZV4ZJe//7mgQ3LY54KWOy/shj0fC2OU6Vt/ytLfUxxz9tgaJ8aapM?=
 =?us-ascii?Q?Z1Z7Iz+llhfov6Z/EIjTzyKwkGcYnUpcWx2RcrpBl3i5jhYmJU1ktzxriRLp?=
 =?us-ascii?Q?FUR8408YyFfncbfUj204gSryzrKQWgrnIpvEjud7kbXWtBDgIm/6bVzZ0f3M?=
 =?us-ascii?Q?knZFlYJ0lKlE4XHfZdodlc6rVXk3AJ8D6Kpl3tumeHJnFOmK02sY6MrFuWMr?=
 =?us-ascii?Q?i+2LwnE4nFikKpt+rHecW3AUVbvTc1RmZ9edX25LsG1TdXYu4rT/iGgFyuVZ?=
 =?us-ascii?Q?qMTVH5p6FNZz9rM+NKUGOXY6aUVLFE/0rvf0Dn9lPNySm/BgqEbGyqnfwfKJ?=
 =?us-ascii?Q?PCCV9Kete8EtMBMDVaGXGF2jHRG7BwVI1qRCPDNBU7nv52fO+f9XorcbnaRq?=
 =?us-ascii?Q?6tZtKRvuEG9ymcOOXMe72grKIfsSzyXgH0gDXT8h6uqq4AKKhmwAFQjPIJNu?=
 =?us-ascii?Q?aQztRXhXFvoLwty4X2wRTwxBdvP8QuwOBgXI47+cF4fxw6A4mdI/RUXvdPR0?=
 =?us-ascii?Q?P3V5mvQQrVLk1KBSk8rjj1/hz1SMub+vrcMnIvzc0M1f4UuEAv4tHNH9FPWK?=
 =?us-ascii?Q?9NwVqsZmUF1m5gnTIEtPEyYQQ4S79MJP+JvUcFy78YlrqRqL7kt7Dh6uo5lD?=
 =?us-ascii?Q?vmJ+MUMzfma2tn3V59DEihozdUID2IOq/b4W3/cy2GaFw/83SLcPZdlb+8zK?=
 =?us-ascii?Q?+r+jbjob4ZeVO8Nt/3xGA9P4c7JVnDLpg6l8TiP+nS587uGJx8MLG893QUOs?=
 =?us-ascii?Q?PZmRzGJTLxQJ/GT/1cy07YiASaUwz4sX6qok9tLqXER5tusOUePSYISyyuTr?=
 =?us-ascii?Q?JX8veoftvqZGApwJRQ9gY5aGXCwfUy6MODxSaEoy4fzpi8ItEFwXo5PBK/Eh?=
 =?us-ascii?Q?UoOrxdIj7jFdsnlzWAJEqfv//rdbzNg644XfhKDV1nYf6XFxJY9OxeT3/g4j?=
 =?us-ascii?Q?icf0Clm+sHPNFaYtgnXw0Cj5ZfB8OXffJvLGlJzXLC6S3fSsFkLMBb+7mQaU?=
 =?us-ascii?Q?+0UwoC8EVcp4QfoRrfyGSyvTLScsqRXJIayBBnUWIK1HSWtiLvTRZWkPsQu6?=
 =?us-ascii?Q?VGt7R2G1fZhOGqmrp55G8Vo2fdeVJGFs+1aJD2PnB8zXG6yR4k+YZ1BPWrsB?=
 =?us-ascii?Q?g+60ZztnhLxT6s8kSeYYLkvH3k/ubf5V2Q+3teImXVb2Aqbt16oiJj3j+Xa+?=
 =?us-ascii?Q?FgMPfzQg2tdQ7wZEjLR5Fz5vpMXS2dqzz1krpq52ZT3EPq0J?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2eaff72a-cc54-4cad-1653-08dece0850b1
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2026 13:40:24.4245
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q5ma9lh3Xpc+gI0EQqoNmrbayQMl4rC8/6niTr2dkrroTwDKz/pEYBa/Sj5TaWXy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6844

On Thu, Jun 18, 2026 at 12:50:48PM +0700, Suthikulpanit, Suravee wrote:

> However, in upcoming series, when introduces vIOMMU EventLog and PPRLog
> virtualization support, we need kvm to get SVM AVIC information in order to
> setup extended interrupt remapping for EventLog and PPRLog interrupts. Any
> suggestions on how to achieve this if you do not want to pass kvmfd from
> userspace?

That sounds like a more appropriate use of the kvm fd, to extract
KVM specific information.

However, interrupt virtualization is its own distinct topic and you'd
have to get the KVM and IRQ maintainers to agree to whatever you are
doing. I would generally expect that the irq bypass is setup in a more
general way, not by directly poking into AMD KVM stuff.

Jason
