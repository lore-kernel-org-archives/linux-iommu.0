Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2060.outbound.protection.outlook.com [40.107.220.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397411DFE37
	for <iommu@lists.linux.dev>; Wed,  4 Sep 2024 16:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725468943; cv=fail; b=h36YSms9ZH+EULCcG5NZF0EKM/7/EM8FjR/FsNgAOgwKSYFNuoPhL8OH3PveI+7WZcK7HsM8Ny2nxwWi5/EtvxA+Nc093/6pqM6VU4AKiR53GLtU1KWcNpESfxh/8rGGYydO9reqvXV55QY/82tk6aLvmDT9ySIse9kMZXAHRek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725468943; c=relaxed/simple;
	bh=HLMQrA5JSN3bxwZF2vJKqOT3hCzU2Ate70bDafKTppw=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IYB8S68u4i0+FJINgOTCeQ5QDqQlhW4N8pill3a5NaXptEV3cLRq7P3b7dfNEscGqsXvEQdt0sq9IiUgoEasMzAqTojPHQJBzk+a2YHqP6laZGtwOkJf7cQtabsrhb71iuPmeG0RlJY4Z+8bLihN+XCnMTOMuQXFnq0IUT+wiRo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QJQ2OOK+; arc=fail smtp.client-ip=40.107.220.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QJQ2OOK+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H4dBmyh5Zmfrt9YKxdyqZqzufe+3SvFKAT79TwcVa64t5+mS1qEQ8dchQ/+6wg7zYsBqbP9dJN7FLY06vaOyUeVYaJFFtGwJ0H1yaNlxtGXX5mgMgYs3L+u0RCVqtJFZgLgscsMQLmG6pIqsHORhHPPx5NEzrKk2UH/Si4YGXIKDuEuFAGOuVJig13dZtPHZP5iX7MsMzb5wc/GuTpVv1RtOK/X6WbSOnRdBNfE0ugbrv6ZADF/u3pGkq+FA0hqtxNW8n1JnMVDQAuBUpSgAXyGZvB5wnTgxfpjP6Rb+3Pa28gubQDKLc1ICtkPC97l44pox8Qg3oq7WKNPEhsDZzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ayPnDxRlJ21bYaR6HGBTg1HmCZqcqqApjlzJjeYUWe8=;
 b=KObb0orQKuVR0EuWPM7MRKaAE099j1gylXySaRPq/+y5m/DcTUI99MhRCNUpA7mmtM5hWjiT/qa6T/Smcr9YWVCs+oQT6VdL98D13ybZ71f9dJFxwSrhCsinUzVyVjDzChU0KxddMo10bRMAOaMvHbPdGqa8jCB1/Ph+5xV8rgsEOM6Rn/6djAVlDHuQ90QGZTYc1CqFxhIz/ufoZfN6TceQe/oxQ6hUGHnEncMtsTwlJvpkw3s4E0STUDNX0DptokF0CzLoDFEU+2SdlRqrE6iEj7Mcd3XxsEEv0L3+/wA9Rm+0cIRPgkWxLK8sNa8IA/uvZMHqXIm0Z4flcCXN/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ayPnDxRlJ21bYaR6HGBTg1HmCZqcqqApjlzJjeYUWe8=;
 b=QJQ2OOK+UTROdRBEs91jkq0O0kkXj9T/G9ms5w9R0i/NP/9Jz+UGSQE+JFcK6vGPgc3mB/Q7qvfy0qcAV2GeMjE+WEfH7H0tZQ89LdkrpPcnbBeeWPwdrM967Z5eMeYoi6MiptqsKgBlX6C+hLSSTxXmN2OmRgs5+Fr+LFyCSzaoHIa5QCSy/a60i72QwZuZJ0hLaXT4ojAcRsl0c1Nf3/PKc6gtfpb93X4mzC6ApWNEA6xtbtJIDHcBQRpnOpA8pgeTfDUy7Ca576s3MahsB++refMSCBJr2F3Xfi4eXiEzCjfbXM2r/xC5YpyJpjO8giGNOxfOdeJyASYvKni+WQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7763.namprd12.prod.outlook.com (2603:10b6:610:145::10)
 by CY8PR12MB8268.namprd12.prod.outlook.com (2603:10b6:930:6c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Wed, 4 Sep
 2024 16:55:38 +0000
Received: from CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8]) by CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8%3]) with mapi id 15.20.7918.024; Wed, 4 Sep 2024
 16:55:38 +0000
Date: Wed, 4 Sep 2024 13:55:37 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Vasant Hegde <vasant.hegde@amd.com>, Joerg Roedel <jroedel@suse.de>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Will Deacon <will@kernel.org>,
	Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
	Joao Martins <joao.m.martins@oracle.com>
Subject: Re: [PATCH v2 10/14] iommu/amd: Remove conditions from domain free
 paths
Message-ID: <20240904165537.GP3915968@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ff5cd6f8-4338-4174-81e0-9cd31442aa21@amd.com>
X-ClientProxiedBy: BL1PR13CA0172.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::27) To CH3PR12MB7763.namprd12.prod.outlook.com
 (2603:10b6:610:145::10)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7763:EE_|CY8PR12MB8268:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d3f20cf-c28a-4fed-d0f7-08dccd02672b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Mqr68JFT27F4+kDnedk003lucEhRPFsavY5sN3OE0FOveOgyY+2QLQ4Lxj9W?=
 =?us-ascii?Q?jGm5aIrrSS5Zc+RKf0ppiS3jJC4wyJSTQZAeEjwKINdQUbubU+jXDl5xH4L3?=
 =?us-ascii?Q?xLFVc3xyEju34g0r0Rq+aRoapqXbxd+F8dixlKmePyyRnY+V3AOB9xYmRUfw?=
 =?us-ascii?Q?RMqCTmjM11aHMFzTQ2rt667Jcz8MaTrOHtHqtetuoVWliyGonFul1L668mLf?=
 =?us-ascii?Q?2LWmDP2zEZFwabLUr6CeMBNflkgAQQK8xY1bWE9Z2toqkViLKm41kDxMX9Lj?=
 =?us-ascii?Q?hgwFvaogDiIDXl1mUAJWQY9QE3B7A6MNXf1dt7V7FocidYadyFy+y5uVMTiA?=
 =?us-ascii?Q?uwKqA9313s8LEBhTGsP+DVOsote6iCKv7M5kyfCB1Bd6dubM8X9ZYdVLI2wD?=
 =?us-ascii?Q?qowbZEmDo8IRj1bY+lgPc91akA1+RE33tAJNS241hBuY+YIaVe+pXVNq/bwj?=
 =?us-ascii?Q?H/29D5w6Bky4f2+9RU0Ejj0qXNWUNXfh9kJ/VzjBks0gLAYAXT10ih/TtaSy?=
 =?us-ascii?Q?eh076D7YMrJqP8LNfGSQLfppAHqzXSptA5s6wdgNuN2sawY0HYxHoByeYKa6?=
 =?us-ascii?Q?oN3xNp4ed7KcxXRqUCs/mDyyB+iI9RKuZhZ8mewtmQZazRGly+oX+F2kcouZ?=
 =?us-ascii?Q?8VlU92yxBlYxyphei9K+I6GX3fF9YQDQU1+zoxHZSL+GokypIbNVykqbksHS?=
 =?us-ascii?Q?KddBnrQOlrOYJ8SFcBDmL9x8fL72T7KOaA0J5n7sXFHIgzZehzrvqp47I5Re?=
 =?us-ascii?Q?nd2OKN4LxeibQglZdLz4YJM60C+NPgZFgps666bO2qwycmPdJtum9CVNZBgE?=
 =?us-ascii?Q?OKeyyhnfMWVL1A50qowt68koi6zx/nkzs3Xvy9XSpN91R95LyFzXkHZFqLc8?=
 =?us-ascii?Q?8k/bp4ha8zjtpsuSxDRiAaHRrAVDmW6qIyrDxUAyFBn0Uv3KaiHX8WIGxkCh?=
 =?us-ascii?Q?rA8ii86ZU03O1a703qlnds67JXE1K2NK4sR8K0Dv/U2uInLH/VkPWiHr70nw?=
 =?us-ascii?Q?ymonk2dgOplsr27uOlr6556DyDwjWOSrJiU4FR/tOPd+gXXrHadYx1A/IU7e?=
 =?us-ascii?Q?hf2+XBzRDgppFRiRFHCxyHRHDJV1ySQQncW+cDelXO9FHf0huq0+V9AS5vPV?=
 =?us-ascii?Q?2eiHi1jhmgfsQ9+M9zzSZor4Ph0tVS/6h5hKs6stcEpqUunDscnvv2u2XPRl?=
 =?us-ascii?Q?IgRdB/IoG2dZ6t+mpopzxHd4kBlnCs6Cdrib+nQVL45oYOBKk2hbLcTv0yBE?=
 =?us-ascii?Q?l35f9XKUMOk1C5YJu0iyCZSafhMzHNFZiz44wS9DJRgU3s3QCF8Q3oqwmtSf?=
 =?us-ascii?Q?7F9fJ+aBcpptJQ67sBSXu3MT7w0dWlDGwtW3Ik/Xk/4L2Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7763.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pjrUZHSla7ptzo74pVTiHNgBHAm7elRnN7XHsGqrfpdBNr0c+6dV0KPbau9l?=
 =?us-ascii?Q?KSw2aIbnnUhGO2ytkSfBBj8sKCoNkAL83xGgpWn3czJP/0rhDZe8arn+t1AX?=
 =?us-ascii?Q?wMMw6AB8oxiL8xDI9/E1+iClE1SlnoqL1Mes/CDX7/CTgJ9pqLWxpmYSGxPj?=
 =?us-ascii?Q?3eEodzIdga2uaeffjxttGhZEcGylVV3YP1laLBwnPSUTHWAo1PTt/666qZH7?=
 =?us-ascii?Q?Wy5aeZPJGMv2CpssIgQFniSesqgDzWZuzTAx5/BYW0TRwK8qnegDm+iLojPW?=
 =?us-ascii?Q?J0MavGbHjo8D5I36UasCUmhkb2bkmfSyDwm3ARPQinje2Z0H6tKXyYqbBD4+?=
 =?us-ascii?Q?DXuIQuFBHbKTYHo5Aq8pnttzrV+Oo+c8ZIeVC7ktcYOv2BwY3mv+u/tjfwcF?=
 =?us-ascii?Q?sja4J2scGtec9Ua9QKkGdqBoRBDdEd6KmLautW0160P65vZ7VqRNHw84+b2O?=
 =?us-ascii?Q?ZuNwlH3dscjp8klkoTOXNxyrMAYkx7Vm2hfzMYFiPp5DlchBr4Q3ATxvoDmP?=
 =?us-ascii?Q?hNJcKnzwGfhg5J8V9cyKNvJD5fOyHIEeUE4a4vN4pfF8eKwQnA9B068g0IqY?=
 =?us-ascii?Q?ib7kMg8tiU/sAx1n4GOOwZSVbA1fe8q6Ytw3zIxfMCpPAVMomVF+4O3oEjp2?=
 =?us-ascii?Q?LUHuTrGhbDoxbZ6iWi6mKH04GzewiD8Yl8sx/bruvXZ1vEi7a9jlx0MyqlaM?=
 =?us-ascii?Q?05DYlkI0kEczSnR59KuSTq4DX6MIRWZ9Lyef7rIm2Z9/LKUvBOtrc596F8I5?=
 =?us-ascii?Q?XWCUSK7itFG/q4q9Uq+Gjc9CnhNToUPP2TmC9Evcl1E3s7jCxJhPH7A0e3xU?=
 =?us-ascii?Q?TFO6e996Tcetj/qz6HaB02ZsJyaqNwjcpDs0mA3Alsqf/etUhVSDOor51kPE?=
 =?us-ascii?Q?LzFGlI6elH74d+0WCU03d20mkpVJu+Izol8xGNcBQ7VB9iKS0J8PQWN9wgao?=
 =?us-ascii?Q?NLwI7IuH5ouEXDgzH8sJZofBp95HZ0iNrGlqgNpSry3XC7XNT8OGYi12xuZQ?=
 =?us-ascii?Q?0OW7QJhZZQD5xvCVmYaKGlDYlNMzc2azLbOUB6bSDYOZ8pbsKTvmSzySxE9b?=
 =?us-ascii?Q?2iMcxgRtgbGivtSFRMeZV/s95unZIXc16eMp16LdikYHkCVbfsyf9GMBk6IE?=
 =?us-ascii?Q?+l935osiinerhaYWjMqYuXHvYCeTfBc/+Lpyemc4OLgmQ83cpS/j7q6URlm5?=
 =?us-ascii?Q?1OW4jRJbaCSoY4PyrNPpkZj9Uy+m0HxMTyDTR8IraYDbC//zzpTlgpape0gV?=
 =?us-ascii?Q?Jupj7+01e/2FwN1L+fb/u9ggB7HE2/c1NzHVRIXxCyCUrBiNH970v/oaMrKh?=
 =?us-ascii?Q?5daNi65/E7QZl4RG8UBjuek+8aU23YerX2nTDHavY80vl1p60T49ANa4vmEe?=
 =?us-ascii?Q?dKyPEuncwKfSFBQRLB3tZktG132kTcRMx6uKz8W3bo71wGB7O/kwAxLM8JpC?=
 =?us-ascii?Q?/LvND0Xf2/DihEhgXuqnPZZgiOiKyOCMdoM0YJ56tm8skz9jeGjN3MxTMPOQ?=
 =?us-ascii?Q?kstG9Heb0ksiB8ctanH6kbDshQUgSEN2/JUgTi21WrWVcZ1WPbBztggV5oJF?=
 =?us-ascii?Q?lWSGuIOw/gFQPpYDI5uNmhxu0tvwZymnUroQgwBo?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d3f20cf-c28a-4fed-d0f7-08dccd02672b
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7763.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 16:55:38.5832
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JFHtDNbq9cCWwBxi9HUhJhpAfBeJ5qCDMzrqZZ9ZHOxQsQAM8C8gBpTrGmXZaJ9r
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8268

On Mon, Sep 02, 2024 at 05:33:50PM +0530, Vasant Hegde wrote:
> >  void protection_domain_free(struct protection_domain *domain)
> >  {
> > -	if (!domain)
> > -		return;
> > -
> >  	WARN_ON(!list_empty(&domain->dev_list));
> > -
> > -	if (domain->iop.pgtbl.cfg.tlb)
> > -		free_io_pgtable_ops(&domain->iop.pgtbl.ops);
> > -
> > -	if (domain->id)
> > -		domain_id_free(domain->id);
> > -
> > +	free_io_pgtable_ops(&domain->iop.pgtbl.ops);
> 
> This is common path gets for all domain type including passthrough, SVA.
> Hence its not yet ready for unconditional call.

Oh, I see, and ops isn't a pointer so it doesn't become NULL like
other drivers..

> This is causing NULL pointer dereference when I try to change domain
> type.

Yes

> For now, can you keep abvoe check -OR- add PAGING_DOMAIN check? I will revisit
> after implementing global static identity domain and fixing SVA code.

tlb is always NULL now that is why I had to do this.

@@ -2259,7 +2259,8 @@ static void cleanup_domain(struct protection_domain *domain)
 void protection_domain_free(struct protection_domain *domain)
 {
        WARN_ON(!list_empty(&domain->dev_list));
-       free_io_pgtable_ops(&domain->iop.pgtbl.ops);
+       if (domain->domain.type & __IOMMU_DOMAIN_PAGING)
+               free_io_pgtable_ops(&domain->iop.pgtbl.ops);
        domain_id_free(domain->id);
        kfree(domain);
 }

Is that OK?

Joerg can you squish it?

Jason
