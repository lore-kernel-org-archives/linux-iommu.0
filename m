Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2056.outbound.protection.outlook.com [40.107.236.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26CDC1D07BA
	for <iommu@lists.linux.dev>; Tue, 15 Apr 2025 22:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744756159; cv=fail; b=dIZYUEoR2eyHazQPyxd4ZJ5yvAkkeatUQaWbaHQupMuEImg4hUyk1aT4sIScg7yu8jrnFSxdh0bvjo0sV1OZCZRNGMQ0yaAP/3TPo1dHz5SLo4tBo9P2V0+RwBjVvzhq9smdQSxF4yifTjQJ7GS3XBsdCbkRrfmX4nYqZZ5eKUA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744756159; c=relaxed/simple;
	bh=6Yw4EvBqUfBdFEPc5sVSq3K6Uqc5XsYbMkgKgFtm5rg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KVlMKXLQsvrdJOineSJ65RS/Rb2wvYO/wtZJnh6uw603xt1D+v6Gk83yAQwEafj67sA+h2sMQYySZ8SSh8eH6zgSJEZ0QS7wZN9/cS3Hhsuj8VezyzMAqv/4sRpT+WOG/P7N1sznhGFxTOutNcLH7xUcSqE7yIB5e7TlVHDA6Hw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jX+03PxG; arc=fail smtp.client-ip=40.107.236.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jX+03PxG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MMNfQK1ad8yqsHrXkO1/tWzuL+FpwznDazUQdZv7ZXrFihUOTGJ7wgZbs0n7nphphZO5pUi4L35DHVD9OXA49SHGS/K5ESQ5giVOeqR0Yum7ujkIn37skRw6QZlcWIaB9NCqCsw0p4L/RNhhDhAwpsqd/JXavnPcgklTooMkw7pvmPNixOWz/bFKMCeyiJ7/pV9jipF5nChFOsQohs0E79YZQ9KQz3yb04xROqr8t2Ar5iwndBXIqdSWgH9L1sHQACm1WgLaOUwziQE5wLZWbUIPpDAWCaVTEjKzjWu9KqFtsFB6sfxI8aiMpDEtqEXor+scS+AVUPZ0j13KMJNS0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JjZle46tXM7FE0eQtJYTho7EHdl3o14UQXOd4ZqvVE0=;
 b=PMgvaSKjeS0ehU2Bu7yCStrgrkNRgMolkfizCs+A/leW2ImmyiAwOdlqICx0KpUPl2f4qgpMMUrzH8MuLg6iUhGbMRyIYkAxlmKOSYFFSDI6Rm5sZTnUkfrXhVUTGoUz2DMrN9A4ly7A7CRQwiDmsM0M0ddHfgHEvcDkqJW/yIAVqIy33yQ8YsT2AQI7kLzM6KfmXyEIslO6hUWHe7TZnOC4zguy94L69KaB3Jcra4IMvpsVy7MNkSVYy6sYAUp30zEHiBli67iaibih+6MMc8n8aYo7Nx/i280veDt6MkGpxokuTkAqz/HHydbfIE+TjWgOSHJ7BkON4p+0BlyFXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JjZle46tXM7FE0eQtJYTho7EHdl3o14UQXOd4ZqvVE0=;
 b=jX+03PxGC4ZHiv+mZab84FVBh8mYwPnxi6UbM11rTf9roYb0Bh9tF36WkMn01TCLa8yYroTM0cGkzxRX7QFDsPDnxaKQLkrLlUDKGhUS8/HE92qbCELx1+kOPtcTsSuTFLtb7M6ZctREQHz5l8so4hltG0t1bnY9DgYeGoqK85MN5ICiVez1lCCpSpKZ5y8av1v21eWnnZYJtDBDYjUbXo4Gel4VAswOrKLyn+7BhKjVfzginnb99iHClwQ6fbbAE890zmc0HwU2+y44gse8C3QzRbTcaotmqT3yALggl98Dp93h5nvAqjZR65Zz4KOm5VP3hrxYNtTNdIRJpTOwHw==
Received: from SN7PR04CA0175.namprd04.prod.outlook.com (2603:10b6:806:125::30)
 by SA1PR12MB6824.namprd12.prod.outlook.com (2603:10b6:806:25f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.32; Tue, 15 Apr
 2025 22:29:12 +0000
Received: from SA2PEPF00003F66.namprd04.prod.outlook.com
 (2603:10b6:806:125:cafe::21) by SN7PR04CA0175.outlook.office365.com
 (2603:10b6:806:125::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.34 via Frontend Transport; Tue,
 15 Apr 2025 22:29:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF00003F66.mail.protection.outlook.com (10.167.248.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.12 via Frontend Transport; Tue, 15 Apr 2025 22:29:12 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 15 Apr
 2025 15:29:00 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 15 Apr
 2025 15:29:00 -0700
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Tue, 15 Apr 2025 15:28:59 -0700
Date: Tue, 15 Apr 2025 15:28:58 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Pranjal Shrivastava <praan@google.com>
CC: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, "Robin
 Murphy" <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh
	<smostafa@google.com>, Daniel Mentz <danielmentz@google.com>,
	<iommu@lists.linux.dev>
Subject: Re: [RFC PATCH 3/5] iommu/arm-smmu-v3: Implement pm_runtime & system
 sleep ops
Message-ID: <Z/7dqjiVdjnoZ+2w@Asurada-Nvidia>
References: <20250319004254.2547950-1-praan@google.com>
 <20250319004254.2547950-4-praan@google.com>
 <Z/1MjDaAM4Em53gE@Asurada-Nvidia>
 <Z/19e4eyj1k/pqsh@Asurada-Nvidia>
 <Z_7Fx-Q8baoyzJe2@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Z_7Fx-Q8baoyzJe2@google.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F66:EE_|SA1PR12MB6824:EE_
X-MS-Office365-Filtering-Correlation-Id: 481388c3-797b-4853-d27f-08dd7c6cf2c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AHmq1FWWezgGkUxciwWXtlvFPXq5ImR2BIrg0alXwFd1wunTXCA/rl+JYQSi?=
 =?us-ascii?Q?WqJ7Z002chdMGeAcwEqffSLK6CKm81EjWA/HQGz5Snd1U90D/4SXQF/n+amY?=
 =?us-ascii?Q?SgJcSLRSCffDRkwn8VD9jeIJHkQ8nsQM57LEi1geS8y5J80cVPmheaOlozYH?=
 =?us-ascii?Q?ivg9xyYxNfWRuI+JsJRuZZivOVJCtst0fNqzmmfu3ai6TFtPPq76iAHmNkal?=
 =?us-ascii?Q?Wq2thozIe2qhtia4JujFleeY/65g7AqGyQO5sTqdvU7XqLClt9eqGl71VL3N?=
 =?us-ascii?Q?fqHScDDhw0q3FJK+aCvLyynbB7PADgZI+1y2gZfCmmc9lnMiWmxHw8nOFCP1?=
 =?us-ascii?Q?fqC6Olu/Tt6dN6PgPoXexN5vmc2XD6O+eGPGzucZHlg7lWdD3021ymYjsubs?=
 =?us-ascii?Q?RHz8CBM9sm5CTHrqbuu0IliqXGDTKdhI9NXeMDjcomGjM1JxbQzxgGbpxaAn?=
 =?us-ascii?Q?sW26Kjt8jN2m9YBy2/PKEQ0/YffVdZlQNQHr1GjRrZvBjLvZfRMdzeS25kJ/?=
 =?us-ascii?Q?elbOw4q0fexEYSP2MmlTy/Vv2iCkH5L8kOLRYNKXf+kfG3ZxtI26M5gFnwRJ?=
 =?us-ascii?Q?hCTXdrSCrQAtsCGViH+JXiOjnSov8WPMeIdAACsZdQGiQCSitNe/ayzWQmZJ?=
 =?us-ascii?Q?qOFBRPW1SXLLQaBwJk8jHY95zX5LPcy7CA648EhqchyDA14gJrozbMrRgf90?=
 =?us-ascii?Q?huJjIpyGwPTJX8MMdlYlLsJPGA9IcFQP8LnUAhEJDcYW8yRDHYQu0WLN6Ymj?=
 =?us-ascii?Q?rvnuDRob4R5oKGQKN/s1rG0SakNOnZxtGSNM14PiQ6LAi1B8gLOo48lWJOYr?=
 =?us-ascii?Q?O6e17fB4Mh7bwIzWvLpLYq/AY3+9w2FhBsUpLUcEKgWPFfYY+6gPeknG4lds?=
 =?us-ascii?Q?cA6es//Mwhj217VCURFSESvjkr7hAjPGAJASFdQakgStRz281drY08Xqyolq?=
 =?us-ascii?Q?nFCcqKyo77/Mf1Qg5OC1FCL6xB2uFxZNCzeCX6hBfiGCLKA39z4CuO08/tYs?=
 =?us-ascii?Q?pEvkdk5fTuEtJxepFjaJjKSvIOKpOr5J1rdJYPOzz2tevZHIWUUmtR/nAmU2?=
 =?us-ascii?Q?ZQcVyljKElMjw3zSt2TM3AyqNjT9HzSRvdEx6MHc0ZDm3MqNEUUMYE5rmt+x?=
 =?us-ascii?Q?va/UssDjNMrKQDLu5Om56dp7aRGANxxjGYiG9OpKj6qZlLRtMbsk3rnW7WW4?=
 =?us-ascii?Q?gEBhAwe9YHYeypAm4npPF3D55HgNs83uFgZpTfB4mfnJt++Yb+SY0nsKdqb8?=
 =?us-ascii?Q?5IJT4ZEY6lPK7qTCXeu44f44RcEFQYPe68te57mKGYeyD5MsXFB6Efy4y1HW?=
 =?us-ascii?Q?tIu+/lXpP3VxDlGyOix/9uWfW5v1KfZeqrjFDJCkSldofzvUf0cZxDfxt8h3?=
 =?us-ascii?Q?zozs4j/H5w1BiXorBeWK0E0kmbcuG+Uf0ikm7HphB9+3ZABhyeBsEtIgbh87?=
 =?us-ascii?Q?DaY8juLAga1iXPYPGgM56ctFrJw4x2wfoCikcMQspIfSvcH2j9cxGwRcemi1?=
 =?us-ascii?Q?0x0WvbNN4BY0m7Hk+LaiPVOQTDlUR1eRp7WB?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 22:29:12.6631
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 481388c3-797b-4853-d27f-08dd7c6cf2c8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F66.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6824

On Tue, Apr 15, 2025 at 08:47:03PM +0000, Pranjal Shrivastava wrote:
> On Mon, Apr 14, 2025 at 02:26:19PM -0700, Nicolin Chen wrote:
> > > On a system with vCMDQs, there are currently one standard SMMU
> > > CMDQ and two vCMDQs, i.e. totally 3 cmdqs that could be picked
> > > in this context. Perhaps SMMU might need a list of cmdqs that
> > > any new allocated cmdq must be added to, so we can iterate all
> > > the cmdqs in the list?
> > 
> > Another tricky thing: if a vcmdq is assigned to a guest VM, it
> > won't be added to the "list" above. Should we wait for them or
> > simply rely on VMM sending a suspend signal to all its VMs?
> > 
> 
> Hmm... I haven't looked at the vCMDQ series (of the vIOMMU) yet but I'm
> assuming that's what we're talking about here?
> 
> I'm not sure if sending a signal to the VMM would help if we have some
> stalled transactions? I guess we'll need to somehow figure out if
> there's some PCI device assigned that's using that vIOMMU/vCMDQ ? 

If all VMs go into suspend prior to the host machine and all
guest-owned vcmdqs are ensured to be empty, we would be fine.

But this is difficult to tell, since a VMM might not signal
a suspend to all guests VMs. And even if it does, not all the
guest kernels might have implemented a suspend routine in the
guest vcmdq driver draining all guest-owned vcmdqs.

> Maybe we can smartly flush only the PCIe ATC inv and pri resp commands?

Yes, I suspect the host driver will have to do something like
that for the reason that I mentioned.

Thanks
Nicolin
