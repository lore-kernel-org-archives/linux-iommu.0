Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2079.outbound.protection.outlook.com [40.107.237.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47DC216EBF6
	for <iommu@lists.linux.dev>; Thu,  5 Sep 2024 17:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725558736; cv=fail; b=LjbRTpBNPFv0pIBH7HDdog1vo6cFtdldJxAG54hP9gAFUAZZsFv1eP4N8eMkKHIERX1OnSnCUfZ/yv5QXO37S4tkHT+eQ2OeAO2MgGtoVi22Iqgo12tToMVmB/u6XRrItu4QsVdDoJBPprg30Svp5/Zv02CG76DOVuuNEuQG+HI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725558736; c=relaxed/simple;
	bh=p5jTXVipXgmfkZwv6A5WgRHOE/FJcO5wx2CUACanJdQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=F/lAXKFzRduySGdFVWM1v7QGCrLTySB4F5TmHmk2ZQm+jqVhLpHEV6UVEi39lMD1AD3fTESBXPQBKz4FZWbfnauKIaZbYT2yekrLZ2oOS90GjBChl3BR7AXxkI9HHbsWUYqjGnsOO2cdCKWakkbeVjqRljRLnAgnMDZRgkgZ5FU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nBBvncBn; arc=fail smtp.client-ip=40.107.237.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nBBvncBn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fnKDQiwktR0YlMDEkUpedT2b8jcUpd/ubC24H/woTgMZbaZhalUUZmI+0aCMHuxNpucAqTeNfPAvHeGxWdyEjltQuMEPVGmxTmQX1XWWfiLiyUjwbzv037235ph/6gxI/pMUHlB9FRUTVxUmD6Hs8zkBGXIrdAOqAQAPSfiK9TXF8vaPbTBWhosbNv3y1ALO+h1P4KlPpbIsLsJi5l5+ExnMkwZ8/C4FI1GV+LtKD5OVLaa/1p5LicGGne43LqScnpOxA9geBkOuKTVtmFXAILw1hnDCab+E9xU4gQDDPJMgQTUJmFudfVyX/P14UgwrzqgcAqAn4M+V9YAdcoI95w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R3khQziqV6rAzADitEbuRpgdybeHDYSkVh5LC4Uests=;
 b=YINyiBVT5/bGYv8zePcswXluLPcAdmob1ZheSRDiUENlspOFmbS+MRUi3Gx6hGyfgnq3gm9fNZirr1ZADECNfAloCTUnzvFB9YYajlqHiwyCibjat6QdGU+Sht+wCkWu8tEhaCZlIOZiNzG+g9eWYYal+U2L46P/Ugxc3msi0Sm87MsQ1SurkHTl8SD5varLuQKqcBEotxgAUpPkaoqXtB+QTyJRskNbvZ/EVpBtLlTbZJ6Poibhq3cAJOsesZMqW4Q4Z/DT65FnplLXew6K4Awx7j1fqf/rPX8/0P2b9hG8kfCRdeOyyaTV7F48O30a66QlVqqAu0oRTOYelGX4jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R3khQziqV6rAzADitEbuRpgdybeHDYSkVh5LC4Uests=;
 b=nBBvncBnMf/ws+SBHFbtUdyLqYNo8JHqaaWDKJ2rWVUX8vZuTKzHvlciF9wDZF+m3t1exfYBbLL/2PJlU2i+voxGGnDGh7imc1bNRVmsyga814xACgDgM1Wae9N+h+zTaAvUYsW9VroFAUnZhZkhQUBEsrB5CnZvOcMHBy/oSr2wlbUZcEoucjj3OIDXpxnd+G6GpPGRx/vwQ8oAxl0Q5VoNfvvdlQ7khXvd1jxVYf86kIkKVN6sGIv0T3DEqozN8GjwVr5jrZ3BzevNUkW9g928dHRkA/kbGXaOyW2/yv6fmI5KRk+EiTattdmQGV6Idekmgka+MENWJ6TMLcEZCg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7763.namprd12.prod.outlook.com (2603:10b6:610:145::10)
 by SA1PR12MB6945.namprd12.prod.outlook.com (2603:10b6:806:24c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.28; Thu, 5 Sep
 2024 17:52:10 +0000
Received: from CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8]) by CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8%3]) with mapi id 15.20.7918.024; Thu, 5 Sep 2024
 17:52:08 +0000
Date: Thu, 5 Sep 2024 14:52:06 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Baolu Lu <baolu.lu@linux.intel.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Vasant Hegde <vasant.hegde@amd.com>, linux-doc@vger.kernel.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH] iommu/amd: Add kernel parameters to limit V1 page-sizes
Message-ID: <20240905175206.GX1358970@nvidia.com>
References: <20240905072240.253313-1-joro@8bytes.org>
 <45a3ae40-6e59-43b4-ae57-d159bd2b54df@linux.intel.com>
 <Ztle72HfrjBjlJGa@8bytes.org>
 <20240905120531.GD1358970@nvidia.com>
 <ZtnKsf71piBohHt_@8bytes.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZtnKsf71piBohHt_@8bytes.org>
X-ClientProxiedBy: MN2PR13CA0025.namprd13.prod.outlook.com
 (2603:10b6:208:160::38) To CH3PR12MB7763.namprd12.prod.outlook.com
 (2603:10b6:610:145::10)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7763:EE_|SA1PR12MB6945:EE_
X-MS-Office365-Filtering-Correlation-Id: d5b34997-517b-4574-220e-08dccdd375fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6IcrQkOmoTneznj4K20m0cgcYXmHseZOcdKzwwYNUtpkUZNZg2FB91PGIchM?=
 =?us-ascii?Q?9Sd9e/LVfW3raPab+d3NvQOGjRZ4gepWWe+QjLiys5CN5TNGH83Ayn8E7qCU?=
 =?us-ascii?Q?zuVrZ1moRfBYp5BWUunJnuBHQ7Dqae8Y74PAwyHb/9taCMdP+XYu4XrbucBf?=
 =?us-ascii?Q?HNHj05/Z0mxF79iGcjZ8T/WHtmuByp6Du5ni4Yi2UPIGo8qn1BAk9vHBPqny?=
 =?us-ascii?Q?KFOLu8eSF2/w7EVqqoGG4sBi3Fg5sF/chQdsOnMQyOywQf+SdproxSY7G+ta?=
 =?us-ascii?Q?qmvrXnVp/mllB+ZBEwlD2ZL8A+8pFpjih8fhyuc1K/ucThMRx65iizHdIakj?=
 =?us-ascii?Q?6bEnwwKfovzbA6xcVng2n4V9SWNJz+wQTQ4NCwVkr3njD+O7BerEuO2DHjfK?=
 =?us-ascii?Q?xKMhC1HHA5BROwmeUtRSlcSSkNTCW0uHDlSivITTpSwgB4+ueGGB+dNFh2+f?=
 =?us-ascii?Q?dR4qbeFcIllzMSp3yy/mFVqSV/NkIeX5Rebbp/lfGJknM4Ws6I+0/kKxoDaU?=
 =?us-ascii?Q?McSNVHh6l7oKxXylNR/VxEJjEs1fXCqX3sITsKROO0oCeLkmcL2yDn7c0CVX?=
 =?us-ascii?Q?gr1MdL2Zu6GesDPchX1++hOvJR1p7pk7NiQXoEvD8+69vGHL9+7Wdf2amtFJ?=
 =?us-ascii?Q?AmUx/Exorqroua1PhDXZ/pOUfiu8jCV9JjxarKaip4KV1bniICPN1UZuiBEM?=
 =?us-ascii?Q?H7nDVlXlEzwWzECIzfPDZpm43+3G++E0mm6Fy0qYD+5O4azGbU0lgJtw75jl?=
 =?us-ascii?Q?q5TxKqX6KHCEQ43wdQRMI5H08JCgzAj7K7r2uUVTir3p5TOviGxkd/Y8G23E?=
 =?us-ascii?Q?mkCo6e3EKPq9WLiLMvdMnFWXMaLRrldhc+Dl5lkhDleunVx8jYkb+Ml4byWy?=
 =?us-ascii?Q?+4Rw+F4vcXoTPQE9DDCEW+x4kiVuoEvt4nywIvQU269+R9ugSjNSzC7h4PNI?=
 =?us-ascii?Q?lB4MUFLEhyQbkqWwFWQisxvd5UwQp9GnOC8m0a9S9RqAcDuMKBZw6QQprfyY?=
 =?us-ascii?Q?cQiz4ZD8NF2EiDHuDuPuSfT3r8vbu6sCxrFA74zyvZyC5kJjpCvnDBlDQp7E?=
 =?us-ascii?Q?fQHtcwagDfsU3BSqXB5GGAJvBhmSI5S8xCKwWOsSexKw+fhAsm7V4ieP/NDA?=
 =?us-ascii?Q?uaUqgF60zBrxZpA39fytxiD+LRV8e/wgDwq0+9MimEFgfjroQGmNRNGvPQ0v?=
 =?us-ascii?Q?dHmN6nMDWOYjh2LvnJNJtLwotbLlAe1NgXRy4TrFhHW1gvlJIVpS9uvETmkW?=
 =?us-ascii?Q?HKhoGEt0u7i/yTDJ18YylDXMOh7af3Kx9P9qgsE3Cgd7zGTiNmygg9OQBTxH?=
 =?us-ascii?Q?T58pf+q1E19YvVf+UgAI59bwZgHU5uefToWru5Ci99xuFA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7763.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?k/tFDRpe2Avkm04YmoNiNMWQl/vP3MOO8095KtAe2ZHGdWdwaoocF7ioq4zR?=
 =?us-ascii?Q?DeAc9wnGXravZMxojU9Tqi3naTcUlpse0TXwuCqSoRBZ3xgP+9Rdqam/ma8/?=
 =?us-ascii?Q?KAStEhNGmiFvVr0x5ZeeVCufSLTUYFotYle/TOBQDoQma219gQdw7Z9/4BMD?=
 =?us-ascii?Q?IzDdwePysJJeBD/0atUigDh1Q4ONVJVDeqSsON5WqvTcRfHLWrgHXNLByC1k?=
 =?us-ascii?Q?ASRtx+FBiN4MlYMsquoNRLT0vKJ8wmioK/xuA39mFfYCg0+D+Bn9kzXybgq3?=
 =?us-ascii?Q?s82hOLxwNddu9GjPfP3v4WdxjnPUluxotVStPVZAsgixPOcz0R+QA1pPgl5U?=
 =?us-ascii?Q?3k0UCYNJ2RqlZlNCev//Xq9Wkj7LPiR7rc2doXUBne9gCG2dXofwJP+7/b5C?=
 =?us-ascii?Q?qdoA41NrnIMuXXrqqdE9653YcpIy6VC18CGE6512HdqZGL/IGEjGmvb4UCIy?=
 =?us-ascii?Q?ARM0ACwl71tI3FPLm7pRufXs5XqjeWrzDNtkrTWIkLo7T6FuITUqrrTKatRr?=
 =?us-ascii?Q?t+I3a57SKJnmhu9ngT4GWPjhdkVobGwdxrpEKzLWVapT7cYaXpuE49/g3K3T?=
 =?us-ascii?Q?XQGjpmfkKSS4pz7m76xnbfG86yogaszSCV/ciWlXVqL7mHssTnmgiVTYlbdP?=
 =?us-ascii?Q?4clqcdahA6rmvr7NnS/piUvDQiomMOAB/psOa73F4yTbdHQYITaTaN2teBfe?=
 =?us-ascii?Q?m7itlsayVI+Dt0y/3KsPUjjun8p9xNRaC+ScD2SslC178khKBa3TTuFmzScJ?=
 =?us-ascii?Q?wsoyhmyim0qPnqHAdw0+gqE0DEqp+c3w4H4/xxAIlTTi+t2NjN9DBVWaNYJv?=
 =?us-ascii?Q?MlDQhpcr6W0WGiNE+XvoErJ+YCr+LBXKYZQhfZOwtc/5Qy+SfweyMj+4YZtm?=
 =?us-ascii?Q?bfTUIrUuzGB6MXHZhlXX4tn88fMdjxf4z5L+nR0I85b4yaaG7RQOYUjzzUcN?=
 =?us-ascii?Q?D6UFXR+R8EW+MhUlPPyUlbrwXLwn8jyXtc7xkwZ0sh4R4M1Si9+PwalAnynA?=
 =?us-ascii?Q?9zZsPbiSJUq93I4KzjodskMy+/gIMr6umPpqraEqOm1baRV5v2wNmv21TCqH?=
 =?us-ascii?Q?zwRlDFEk79mhzBVv9i1KamI6+OIOickfoyWQFMsCsz/8PYCnT1D2grnmGkYq?=
 =?us-ascii?Q?CQUTWD8S0MqDzwVeIiKYKaHXofeNW5JsSDeXKjSZdeK30YPb/dFwkaFWj5Hz?=
 =?us-ascii?Q?XNr9dKduPuz+qOZbC4c3SBwQrEndrqkDyrau3aXrzYv5ENz7qJGgf/ee5uFw?=
 =?us-ascii?Q?pa3+9ZdtxkFv5i1M9kqbWmLJ+zzzoSP4IAL4zqRA+MsdzmvVTUgEqA7iWpqq?=
 =?us-ascii?Q?F53V1Sf1GeYJg1CqRZWRPhyeRMAJatn8HxtvU+P23gdzVYupy97YeWU6BtoB?=
 =?us-ascii?Q?PeC/gCH9OYwwb29Sz0kC6iLxE+HA0xYJu3WUDxDi7yJiYWGL983zJGhuk56q?=
 =?us-ascii?Q?yR6Umv9PEN9b54lNdh0hayorDef3P22Ip+3a9T7cVULA85fRTGXPm6KUV3oZ?=
 =?us-ascii?Q?Eabpg5xeg8uQRrBnNg0IWEnoDarsIDKcB+BNb+tktAFUp/faD3Yv1gkyUAJE?=
 =?us-ascii?Q?lLZqyWqfCs4Ug2m5AjNpy9Sm1PbJW535aQzAEIN3?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5b34997-517b-4574-220e-08dccdd375fd
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7763.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 17:52:08.2268
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rXc3gEj8L/SCrg4wjrDpsK83db/en4xGy3nXyXlcEhJakAwLFilbi01MzikPeUqI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6945

On Thu, Sep 05, 2024 at 05:13:53PM +0200, Joerg Roedel wrote:
> On Thu, Sep 05, 2024 at 09:05:31AM -0300, Jason Gunthorpe wrote:
> > On Thu, Sep 05, 2024 at 09:34:07AM +0200, Joerg Roedel wrote:
> > > On Thu, Sep 05, 2024 at 03:31:08PM +0800, Baolu Lu wrote:
> > > > "iommu.nohugepages=1"?
> > > 
> > > Generally yes, but that requires to touch all drivers to make the
> > > behavior consistent. We can start this effort on-top of this change, if
> > > desired.
> > 
> > Let's at least use the same keyword that already exists though??
> 
> You mean amd_iommu=sp_off? I am not in favour of that, in the Linux
> world the term 'hugepage' is more common than 'superpage'. So I
> would avoid spreading the use of the later. We can extend that later to
> the iommu.nohugepages parameter suggested by Baolu.

I see, okay, let me check with some people if the mlx5 part is Ok

Thanks,
Jason
