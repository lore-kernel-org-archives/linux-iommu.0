Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2089.outbound.protection.outlook.com [40.107.92.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3469AA34
	for <iommu@lists.linux.dev>; Thu, 23 May 2024 03:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716433777; cv=fail; b=Ur+J+tjCJD6PScuxaVRdmR5O7Aml8ZKVUjvESBJzInHCwehojM4fYi+nwRI8OKbmGT0YMRzXTQ1KrWBg2S+N2CiNT3QkCFxkL5qiFCBR7yOSQzy75z9auKq4ffoIpZrN8YJwAIwKjgwJui7lWEv5iNhm2DVNzu4SwVGtHvPrVew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716433777; c=relaxed/simple;
	bh=PtEd7ynRPnJiEBSwlVR8TvZXkLY/E2ppQQkpERl6qv0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uyk57AMpfPQ7eRZFE0MhkYMiXu5Sq4S7yIfznSMUDKuzCi7w2JfbVrrJ/ps9J7f5En6po9IvYK5iZgsOuWtzWOK4EkspfWgtEe1dRTQPEInUCQmWQj4OngqjFpeJWDZGLNqoRJn3VjhoQNmNa9NsU1GvXokbc1q9xzhc2fVUSo8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mHQYeUlR; arc=fail smtp.client-ip=40.107.92.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mHQYeUlR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jIce3jIIq433U07RzCG174S1G4r/P8IjqVs4meAkng3/FAEzLqpmSSLwqOzwigBP6W1/iT2fky4ysWbsrGiAgWbuMOdqSEIjBjqmhiBu3mlWaN78K1wdU+XIKueluCJBHIdiimfuQJte/YmigRMt/LMtJ7sCzlnv0ZBgBV552faVZ51PMrHzI0TD9r7uwiFS4CPyq0un9LQ2036Ix/v7BQfuWYlqQSLiJDZoCt9OoLSLtyc9NHj+jeRgoxESELIzaNTGbNVO8SME5tfbXq3piVLUX+wmtwtJm/WBbTrS8anCRgGuexNfofHkNlQ9AJ7FU/XZEGXmley2YVqTZBBArg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5CrQCJIOt/4ild4erdJZgraCrySx80LVvxqhRaQQ7Mw=;
 b=f6IXd4Tp46Mfxzs0izubvtD7emAtSPdutcAlCjBrNjxIhrwJeBJ4RaAII1QwiBu5IJGZduW6rFuhhiecsJ+YxS+hqO6G1QYK1KwopENxHG+ErsIlRweJuQbyOkEKjcw3z8AGwWvRVSCSixI0vkclADvJfEk69BjDiD7RwpKfxApZHaSvaA13RksBLNOlkvBGNV2wgPzXzC+itq+Xgba+4BodOZ+3/hGLOZSxlp9WVnNiwKe+CyLLroyoSdXqpuWZGiAgSpu0voIXgIWqYJziJaSTORmwnNMEt3hEVCIJqlc6bBb4QQEU/dNeULIZoarKALJGgvn2qRx+LqDZp9YIsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5CrQCJIOt/4ild4erdJZgraCrySx80LVvxqhRaQQ7Mw=;
 b=mHQYeUlRvI0rqs8GPZM4LfAHGXtvNsKGicgiAArxR7arone4Kf/L9UZiPBHCTLjfDqRyC4q3mPACA4Jf8co2TUlPDzDwzeXLSs9qLO+zLQvc/2oQpUNGXknw3x0chSbm+5peWBDCX9eAYQ8zm/2THTHL1H2wa6AStGiTEacN/57YcJJNGY9U7O2ksp3gKYI8KM2LUEG3VsmUktgYAEm9eiHPXVjEWhazUJ2zCFs+bPnFeP2KEd70Ga3dfi8NmpcHzYZJeGhK1W70LROv8XeZxp1wvME/pF4MtJBIZKAQuWZXfUIX7QG8+p03/T+CnlPhNpfXU7VNzpCK0A613dqQqg==
Received: from BY5PR16CA0019.namprd16.prod.outlook.com (2603:10b6:a03:1a0::32)
 by MW4PR12MB6731.namprd12.prod.outlook.com (2603:10b6:303:1eb::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.19; Thu, 23 May
 2024 03:09:32 +0000
Received: from CO1PEPF000042A7.namprd03.prod.outlook.com
 (2603:10b6:a03:1a0:cafe::52) by BY5PR16CA0019.outlook.office365.com
 (2603:10b6:a03:1a0::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.20 via Frontend
 Transport; Thu, 23 May 2024 03:09:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000042A7.mail.protection.outlook.com (10.167.243.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7611.14 via Frontend Transport; Thu, 23 May 2024 03:09:31 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 22 May
 2024 20:09:19 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 22 May
 2024 20:09:19 -0700
Received: from nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Wed, 22 May 2024 20:09:14 -0700
Date: Wed, 22 May 2024 20:09:12 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>, "Tian, Kevin" <kevin.tian@intel.com>
CC: "will@kernel.org" <will@kernel.org>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "suravee.suthikulpanit@amd.com"
	<suravee.suthikulpanit@amd.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-tegra@vger.kernel.org"
	<linux-tegra@vger.kernel.org>, "Liu, Yi L" <yi.l.liu@intel.com>,
	"eric.auger@redhat.com" <eric.auger@redhat.com>, "vasant.hegde@amd.com"
	<vasant.hegde@amd.com>, "jon.grimm@amd.com" <jon.grimm@amd.com>,
	"santosh.shukla@amd.com" <santosh.shukla@amd.com>, "Dhaval.Giani@amd.com"
	<Dhaval.Giani@amd.com>, "shameerali.kolothum.thodi@huawei.com"
	<shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH RFCv1 00/14] Add Tegra241 (Grace) CMDQV Support (part 2/2)
Message-ID: <Zk6zWLcPCc+nWICX@nvidia.com>
References: <cover.1712978212.git.nicolinc@nvidia.com>
 <BN9PR11MB527641C15DD88FB0C44323D08CEB2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20240522164818.GB20229@nvidia.com>
 <Zk5Lx7IqvnE2q7a7@nvidia.com>
 <20240522232833.GH20229@nvidia.com>
 <BN9PR11MB527613C6094EDE9B2732928F8CEB2@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <BN9PR11MB527613C6094EDE9B2732928F8CEB2@BN9PR11MB5276.namprd11.prod.outlook.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A7:EE_|MW4PR12MB6731:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e79f045-2b4d-4815-cc20-08dc7ad5c441
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|7416005|1800799015|36860700004|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SraaloBUE0r2zmIsy2hVyDmeiXTHSBYeD7hDdbhhAIrqBo0atuCyT7SIZuXw?=
 =?us-ascii?Q?xaLuo45bOrEvaNTPdszQTX8iyOWScDHh8mOnszDMOyxgHc0EAbFWhK9zDn3n?=
 =?us-ascii?Q?S4kBbV/ypSI6shlZlMwRV5xWuE/b+5Uybz76RwHSRXq2q3f6MZPRi2JDyYIQ?=
 =?us-ascii?Q?QmOIl6fgFSTHemQ+LRXzusKf07otAz6PatiqPRzxxobXhDRI8EB9P966SKIR?=
 =?us-ascii?Q?uK4n3UsiowmZaL0FMJTjH8TPdolVV6HgvDvl1QCyIoH7ZYYHmCbYmIIDy1ta?=
 =?us-ascii?Q?k4xI7q9Dh2nERZLc+Lduj+FtnzGW1pKSbNQUQYt6JlCi50syEAFL+qhktimK?=
 =?us-ascii?Q?SXCuqawpjeT9uCbdXCJonNztVuVyD60WLu3XmA6+wGgJupa/9bvf33lFoC0E?=
 =?us-ascii?Q?2Ax5F7xr4iJFSNXMRilMK56brWsd5jPCcTO3mkMSdMkTnuQ6lyv//KcrvpVG?=
 =?us-ascii?Q?BdTOgTOrEp6T1SkjwbxxfQGje+O1epwdWXy8ZYtr81pdd4hfh5S5I3/S/1rv?=
 =?us-ascii?Q?EG4hQd6wfEMelT6YsK61dkcf0JearepukYkFjNyM4lOXs/SpF4t4NzW2vFHd?=
 =?us-ascii?Q?pnK9ToH6+dJKxDwB9+oXgiYLTlCxOcBXQFhscY34DwTl+JRfphIyJ3hVaoT4?=
 =?us-ascii?Q?RFJ157DRa6dHi7ylT/EKkqu7VnvWR3g27xWMLdhqopFMQY9GdcTLiiwj45L4?=
 =?us-ascii?Q?+zXsbSAPI4o14KrLnxizXJE5iHmVdHn+yx7ySV4861Iew1VhPn+HGNjQQvvb?=
 =?us-ascii?Q?SQgCKiwNjkTkUZcUoJrhzTmq541VTGPZbUgZ7glEhLbtlx+AU64/yz3tVkY1?=
 =?us-ascii?Q?mTxljEDMQbYLMsPS3MkWnetsTRNkGdhHoo1VgXlQz3KBrHDyH4Bpk7l6x6yV?=
 =?us-ascii?Q?pxwwqVbZKzbm3VOS9AxCaNln00jZskw89frGJHSCD3VA5VXQ4HCNsMvx7Dcw?=
 =?us-ascii?Q?94NYs4Nv1yy/gjlZ2jtHdrRbS7Nh6k3PXlVft6MkD5Gk6v++LdAb3VoeQ3b7?=
 =?us-ascii?Q?jJKz5gGKbVY+Z3fg26iQm5dua6U+5iGCfE5ZI/ckf+ChdFuqLdK9PtsSsUoe?=
 =?us-ascii?Q?tbnc2Id9nFLQaNpP2UTxZ4PFALEmuaKq79KajqoZJ/u0s9ygebA7Nw/OekeB?=
 =?us-ascii?Q?kAqGrr1e24LKDs/T8BiANDzPLxKjaiyQIffjPCzG5sBXai8Bk/1ePjI5dEb5?=
 =?us-ascii?Q?5T8ZQHwYnZXrQk79u43wJ/QpiBk1lZzzcgii4HQphg+xsk60LTi4lAQd51SD?=
 =?us-ascii?Q?9k94qc+1vku8//AhWVzv2zpu8UqWs4boOT6mq7hblUDcoD3JM2dSkxpusJA2?=
 =?us-ascii?Q?D3+IiAuxmCILAxIhS5d9jwlQflJZO8El8/IIRCp+p2XkFUpgaNbrzuUOWf6R?=
 =?us-ascii?Q?/NNGAsSvibik9vG5wZSlFgNlT5Ef?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(82310400017)(7416005)(1800799015)(36860700004)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2024 03:09:31.8099
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e79f045-2b4d-4815-cc20-08dc7ad5c441
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042A7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6731

On Wed, May 22, 2024 at 11:43:51PM +0000, Tian, Kevin wrote:
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Thursday, May 23, 2024 7:29 AM
> > On Wed, May 22, 2024 at 12:47:19PM -0700, Nicolin Chen wrote:
> > > Yea, SMMU also has Event Queue and PRI queue. Though I haven't
> > > got time to sit down to look at Baolu's work closely, the uAPI
> > > seems to be a unified one for all IOMMUs. And though I have no
> > > intention to be against that design, yet maybe there could be
> > > an alternative in a somewhat HW specific language as we do for
> > > invalidation? Or not worth it?
> >
> > I was thinking not worth it, I expect a gain here is to do as AMD has
> > done and make the HW dma the queues directly to guest memory.
> >
> > IMHO the primary issue with the queues is DOS, as having any shared
> > queue across VMs is dangerous in that way. Allowing each VIOMMU to
> > have its own private queue and own flow control helps with that.
> >
> 
> and also shorter delivering path with less data copy?

Should I interpret that as a yes for fault report via VQUEUE?

We only have AMD that can HW dma the events to the guest queue
memory. Others all need a backward translation of (at least) a
physical dev ID to a virtual dev ID. This is now doable in the
kernel by the ongoing vdev_id design by the way. So kernel then
can write the guest memory directly to report events?

Thanks
Nicolin
