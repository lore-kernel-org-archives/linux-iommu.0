Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2052.outbound.protection.outlook.com [40.107.100.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B853E1487C8
	for <iommu@lists.linux.dev>; Tue, 25 Jun 2024 12:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719318478; cv=fail; b=ZKWA2kXgfXkC+sW/kyQpNgDdwDGQEhLl8M/VlUOpBjPUDaHuA1AGop2Q30BDNB0V3WKQoIBx4jD3/J2oR9Qc165aBjUQafs9OQpqZl4cPauI3f28pG3j76gSFuLXgZ0uTXZRZMFCBKMmas1hNW0Fp2ahBJXE82m8ZY5+xBoENpI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719318478; c=relaxed/simple;
	bh=Ru6LWjTruvFDkcPAZSMjlounKB1lgFBSXse9oEvR9dA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PMtV6qG5ti0e9kpC5n1jVLqBeCj3Bs+wDjbkqplwD+GKALiq+ZX/B7/C8js6kItUgu/SW+dLu6038kg/NrXgDrqoaE05RJFQ2HBafp8OD8lJYu2MuBWbqkjgzSfM4RH2F1KGoDtyJfmIFeTeFWRJQ/fz58g+cawt1wwXFDsvFYk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=m7NCgxPr; arc=fail smtp.client-ip=40.107.100.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="m7NCgxPr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aN6VFxVyYO3ObyhL5OyRTPNwC4kzEiLXfCyJSpKQ14dNRK9JTHKvUyuJb+aybWfH/aiO8JiNxIxUmNDTQuVSr+/DGNWxzwkWQZo/H2gHvAvkyZRUsgJJHUTN53cfwL03OQhnTr04qAgmLNAFGCzwtWkJv/0ribpDbMWrM6Z41uDz2vEB83Und6v7b6+c/RdwDXdDMwEYrz81qFzKIgRDEFu29EEl0tbk4TwfqgOhjFOOivggIdr3c43H+inOnel7voCVRAGpo3aTZLxpsh/1mopO0+GvwTZ1dyuIFwWLU1GNlTL8vl4zltvXrRrAmHE6/Pp2rKmC2+PyVheceQD2TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p6swrAdLF9pQCu7XrCJRPlx9qDOl3TOHwNZogfUKUZ4=;
 b=mPgpkS22LJmKIACUbW/8l9K625mvo48NJV2g9Jy5/BMd9GvW1L4nhRdyXiOP6y7Et0ccnr3kewaSeCG7SNbkmcaXMhnwUd8qhBzPmd1vbDlAZGuFHeyzRCEjAYjzqokuVFGqLTRSLit5Z3d8GZJ4zqiSi7eNJGeKsUnQeUxq1YfuCkYQnU4rQVVE6Fwc2eLOf5MWTIfKQTPRnZl5pkhe+tSgktpi/X79DsPwb4ghU18lOv16jqn6ytkgkCqRem4SYfGavXPZyyi7wAcvp726rcxAf+1ZQMhBj57xRHPoKL9nlFtgltWarG107qE+BFNfikQdlLzr9lXXk93RuqwDOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p6swrAdLF9pQCu7XrCJRPlx9qDOl3TOHwNZogfUKUZ4=;
 b=m7NCgxPrGgeoFGtpzFFTsjr5DFvGvC8ypZ3L+VDlfpwT1AgQoY+KpQ0e8F5mCaSyL+oXKIIFZ3PFWXgTssORips5ReBJKQg0rUVYu7p2W1AGTP53GbizRltjce3W9YdZUtAe9G8mikBj5RGeU4WhTfFI8YaP4nEoq5K90wOWjx0N/bIJbYZotTGOxyHKBnQl0kscNKT/DQNPEnKNh5HXV13bBL5z7/x8CmFF3tVO9D/b/X1jy/ZjMugDeyadI5itlfaeHti7P2fQlyLwghQdRuxwESHePa4PRRZyrV0W3T2S8Mm61Un3RDazrKd5Pcs0jrpoYts1KCvUwSyO6aiokA==
Received: from CY5PR12MB6250.namprd12.prod.outlook.com (2603:10b6:930:22::10)
 by IA1PR12MB7639.namprd12.prod.outlook.com (2603:10b6:208:425::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.30; Tue, 25 Jun
 2024 12:27:52 +0000
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by CY5PR12MB6250.namprd12.prod.outlook.com (2603:10b6:930:22::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.25; Tue, 25 Jun
 2024 12:27:46 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%6]) with mapi id 15.20.7698.025; Tue, 25 Jun 2024
 12:27:46 +0000
Date: Tue, 25 Jun 2024 09:27:45 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Joao Martins <joao.m.martins@oracle.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Avihai Horon <avihaih@nvidia.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH v1 09/10] iommufd/iova_bitmap: Dynamic pinning on
 iova_bitmap_set()
Message-ID: <20240625122745.GY2494510@nvidia.com>
References: <20240621184254.45477-1-joao.m.martins@oracle.com>
 <20240621184254.45477-10-joao.m.martins@oracle.com>
 <BN9PR11MB527647553CC48B598BC79C8F8CD52@BN9PR11MB5276.namprd11.prod.outlook.com>
 <8f2ba561-5f57-4abc-be7f-26f33124a60b@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8f2ba561-5f57-4abc-be7f-26f33124a60b@oracle.com>
X-ClientProxiedBy: MN2PR20CA0019.namprd20.prod.outlook.com
 (2603:10b6:208:e8::32) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic:
	DM6PR12MB3849:EE_|CY5PR12MB6250:EE_|IA1PR12MB7639:EE_
X-MS-Office365-Filtering-Correlation-Id: 2052ef84-c9a4-422d-3a72-08dc95123835
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|1800799021|376011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QRsIz8WQZnE9qcCYoa7sXfVjrSQkw1dl+S/jh5IsGDV4gWmSGFwAcxFUU0Di?=
 =?us-ascii?Q?cnbArs5fVwiEvcgQyERVOqXZNjCRKD8o0n9+hE3T+LB3vux8jMBNoa8wWW3i?=
 =?us-ascii?Q?m9rkxGSxAsu/xS3Zhen+FuX0/rC8jKJaqBQMG5Um3XDaCGkVjqJUApBTomkC?=
 =?us-ascii?Q?PMv9oeftsm7mncOEJStzni/DKOtKZM8cRF5jwQY3xgQiiXpcqiHpeN0wQvLs?=
 =?us-ascii?Q?CazteoaGuUAvohKGj9lVmmgkTikWf9MbsCB570tDPsz2KwXIzhyL5txQzbrt?=
 =?us-ascii?Q?jzzYjrdlXIkeYqqie0LSFWPBMOPwZ31Xv4AYuY+gFk2TxM+7j40cp5BkzqAQ?=
 =?us-ascii?Q?mdItVl1U+cTWGwrEa1oH0PaCImTGDoAjj1Tc2foJJr/7agGqtzjO+Dl5Dzer?=
 =?us-ascii?Q?UxUwx8+I2v3PK2Klqeh06bBycH2GM7vVwww93G9MPL7BC7Hfqd2CP+U+9Ucf?=
 =?us-ascii?Q?TtfCDEU9BGctQ/mi26EBd1UBc6+UvmCQWHoU80gFPvCSdQ3o+bgj5KX5+Wet?=
 =?us-ascii?Q?LQvfUHdHFptRbUO169TVUxkQMieLyqVx9gGOqSn/ZJZxh+Br9J5V8R410FwK?=
 =?us-ascii?Q?ZmCK8mDGb4HK5/49Pzq+wEFwoflNTcW9Mc07UXJhH/4u8jMdu8OFEJpYPT5g?=
 =?us-ascii?Q?hwJ1krm9riLG/kzW1MFbmFeWmGcrAoZ2GMXj68dfU+LSwD226Hyw+BipjtrF?=
 =?us-ascii?Q?jJ0KdoP/QbrghuVCKSqxNjrEylPL4TfdqivohlKdu/TmOdaBtFCrdx71aoP8?=
 =?us-ascii?Q?qD1Lne/B+n+zn7l8dZbqhEucBc/s7bpgaTtExAX4F4n4feke8ap6a/Plp3vM?=
 =?us-ascii?Q?eK/LA9yv7nfKojT0FIYAqYiXEYwoLDeNl1k+cfRSxUHq/FZl/UNEmxKPK63B?=
 =?us-ascii?Q?ynb/5CjwYuU+uqE8X6Yrl+FAJHfH4kiOpaGocQFFZs4ibBw18IR77/Af005t?=
 =?us-ascii?Q?ejGOq0pWxyUCVkiLyUUvL1KRHzbfjS4lbkJYLjzG6CxEUqgW0JFcYm7WaXAu?=
 =?us-ascii?Q?lWr2zd31TZGO2Tm6pLjzNCVQ9UXk9y4NoynESq7MN+fu2Sj29f8rFv5m9ZD+?=
 =?us-ascii?Q?G1IA/v45aPboKR0pFXI082M0b62rIsrd4EHe3By21fGFhG0zREpWzO8EP/oq?=
 =?us-ascii?Q?8AgZNv2OuP6r+LhJjNw5I679EKGF+/VUfBkwRKqA6udKAY/O+Xwz1istfrhJ?=
 =?us-ascii?Q?x+DAdA5j/MU8A+M6JC2qSkucD+R5sq/ta/csLK17nX0vroB/i7f9JrYyS7Ln?=
 =?us-ascii?Q?U9pqpOC8JLs0ps6FnIwL?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6250.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(1800799021)(376011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RXt/DyLc33szqwcSrjTIS9M5aze80TwO/J+8jWSHPOcqsfHJRNHLI1a69K0c?=
 =?us-ascii?Q?SRw7L35okVM2wOwqqTEQ44/qP1IMfullV6v8rVm2iaGJJFd0z3keVoOtINjh?=
 =?us-ascii?Q?TZ25gCDyDxBhSxitMizj4Q3UsxJmuonbFVdND2qLNFZ6UINX2N4gaQuiQrZU?=
 =?us-ascii?Q?5TXie1CsrXtVU1FznFb4IayAxRv3o31hDiQbcVH7NdBPlHYjNDqcGgsEc8bE?=
 =?us-ascii?Q?ZrIP7zBXBdS/+zoIurYeOicKZGqIIGn1EubDLfuSZepgnXYVj6lwaQjvxfUs?=
 =?us-ascii?Q?eldLmczy7Yd/oQGeT3iQWKEDpbTQ5Hr15KPMdCLv0iX4ZcNZjRfmIFO97XAw?=
 =?us-ascii?Q?/c9fy4HJ44EsNkOC/eH2V7lgCxWxrqqODX0yJiooWBYWb0eoZ5iwvStc9oZv?=
 =?us-ascii?Q?ky8tRD6yh0WbGUykP6kDKR+0rnX3CA61j5KrdxvkHZI8h7WCy4gxOOv5c+T9?=
 =?us-ascii?Q?C+pwoTzh9wrKr5x1AscGHRBTHCJdoupy4ho2lg6vyrkStbNpZ+8dq15hW7u/?=
 =?us-ascii?Q?PSrdZmk+JPgfWXd+aVkAT85MJEYac0Kj6yOIRM9Mnu7VU723kcKjzO2GSJMS?=
 =?us-ascii?Q?UoJDEb6puz0NGP3mL2llLpbxoRhcn6wp+h1rRRnlTifdfljfCu7RQgk9H1d0?=
 =?us-ascii?Q?ZE2CWdE5NDPBKVqXip670hmpN4CiVMC5TXn+LlSPO2pyIBJCOSHgHEEG5KP8?=
 =?us-ascii?Q?m1YApki8wXFpTM2thXBWQpUfpBiKNycr/Xd4q6UVhMKXSWYMyb1RlV5SBNoD?=
 =?us-ascii?Q?7efgCHmqSu6hhQvbX7ByFqunCZF836gNQyZ19qYQnzNwMtrvYpXEWVz0JeYw?=
 =?us-ascii?Q?6Q6f9KMypi4MZKrtdP5a09S6xQUmsyAbKsU7+sXQ1q8L34zfqNoR6ggxNe8K?=
 =?us-ascii?Q?LxXJookCnxTj1sQ3NDT51gr3muaUX3vanodFL5wYfuKg/pLSNG2bt/h8MQ9l?=
 =?us-ascii?Q?gqGV6kB8h/T7KLYuKMAzRqRf3MzdR863RSZ+KI7l6INg2PGxj6aOlGfIq7K1?=
 =?us-ascii?Q?EYrHWlEM9UpHmnTJ4ZvS2grPM6kCAKMgzJN3dAmlq9biTn2nRCQY/7ISNDAK?=
 =?us-ascii?Q?Pog4SOsE3H1Baz8ziHzHJuJ7mWXkJOI0R39gbQ+NKHszJWMFZ6acpE7AAlEq?=
 =?us-ascii?Q?xuXDI//VqllwrFT4gietm2RRVwEApxUvJjCu5XbjxAqc5k72nkkAL0QFAAnR?=
 =?us-ascii?Q?0sqGMJ6byKzfQWP3q+5h0DCyJbBuu40iQmKb9sZLDDTrno9FTuy05PbjWcTG?=
 =?us-ascii?Q?JjYS8ZkIMC0FxkBPcaPya5p2CtbSIoHZ+k67D086Rc505t6a1di7UXLYZ7FQ?=
 =?us-ascii?Q?YOfSYyPE+iVUQCVeX9f5YlHiJJa0UfAv2IyysehRgTnSxVagLktLKvcpXD0X?=
 =?us-ascii?Q?7+Ny+uS532ZhyYi+VdxUWcYS+RA/b+PPsJKSMY+38MVieS6mMx3UE8S7gvHG?=
 =?us-ascii?Q?bMkAg9qvUv04zYZVeM4X/bCFErubPXatq/wquT0sbcG4P5zAMsajqk7MAGRN?=
 =?us-ascii?Q?OhrJPUb12FhLyhLbtO5RBp4sMzhfZI5nMfJRE5aGEDdVp40+x0+fJbgdpvNZ?=
 =?us-ascii?Q?9vnEcNcLPFJkmZjbf4nx3P3w0gC0EZvPXwmlfUyZ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2052ef84-c9a4-422d-3a72-08dc95123835
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2024 12:27:46.6010
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Alm5bSeg8EYzuo3cWSmV7EdWdllh91EjPvU1HnZsxEyjY6b4qVm01oezTZicVTAi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7639

On Tue, Jun 25, 2024 at 12:13:15PM +0100, Joao Martins wrote:
> On 25/06/2024 04:38, Tian, Kevin wrote:
> >> From: Joao Martins <joao.m.martins@oracle.com>
> >> Sent: Saturday, June 22, 2024 2:43 AM
> >>
> >> Link: https://lore.kernel.org/linux-iommu/6b90f949-48da-4cb3-ad9a-
> >> ed54f1351a9a@oracle.com/
> >> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
> > 
> > missed a fixed tag?
> 
> Technically it is:
> 
> Fixes: 2780025e01e2 ("iommufd/iova_bitmap: Handle recording beyond the mapped
> pages")
> 
> Though I deliberately didn't add it, because we need the patch afterwards to be
> fully fixed in iova_bitmap_for_each() callers. Not quite sure what to do in
> these cases

Add the Fixes tag to both is better than not having the tag at all..

Jason
