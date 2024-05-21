Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2089.outbound.protection.outlook.com [40.107.223.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E48A14291B
	for <iommu@lists.linux.dev>; Tue, 21 May 2024 18:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716315897; cv=fail; b=Fl1t5Jqcf/4/Q+f+ImSYzm3IEPNWdwJGomsTns7wIbkFRIjBWZpHIv6qwqSBF8qaMOMfUk+5gHtqrCet195Midw042MtyhmzQ35jdWjm8vZnzSdgqa1w9z4WjSG98TiBjPSIyUJJVVDIKL7c3G6XtHS5O1cQIPatT8FtPx4OUEA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716315897; c=relaxed/simple;
	bh=uui763MYmE7ha/qwx5WFR27Ur2QiwNR88Y6qinZDNIg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LSIxeRCcOyc2jCHSpPHpNGPBaEiPlgBotLpAKQhFWjRom/XvsdiCKl5oxsO8hp0qOlyqY33+QCcms3HrMyuSo0PFwzIwlrc/795exsUo70tKGL8YPoKmaO7M+H4WRF1MGxo1xmaB7bqAqKBk0j1YMadU2Ei5qkwi/vaFq8/ASKs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ud/bBAcJ; arc=fail smtp.client-ip=40.107.223.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ud/bBAcJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YaVVjhltUJQF7Zy47/6Z5sKku+Vmthjy9tXQBMx5qaWo+qMablRAQz/hRkWGx1H2q5vmIQ8bMkn1nzquUln4MnoaAHXUBKu0FNSPQR5NcJueyJx8SHYrUjFFdLjVVi993rFl4QjcvjWJa+/xFgtGBgODuBK+sm93VE+bAr6gZSFj64XJjTyBxyb/z2KVra6/UkNRp5hd2sI/xs1GiBk5wUAM/cb4FjhncAMFWUAV2IbGeG1CQgvzMahYyLMKNC3BSEGMngEyMsdOpqkRqhaIB8hHO7+0qlFRNdaYQ6uAcfiIdsPOFnVwnRMdv4W5rCYwHmQxt9OpVYgvbv0oEIdBmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qaHdqh0JU4Wm8YpFXwOqwSy5YLfyp2xe1qGKRs0jhgg=;
 b=YTj+fIVP17oLwNmhD86GaNxtcYyngD4VMJljKoBKikicnBdoZ/zhE0Q1QoLSKdBBjJ3H86zry7kmKF8Crb95CJrYMKkb2wW7J467l/gLkLHBMps/xlnDYsltS1rAECxBTuoudw66gUEDgEply3FU2HvVShx0hR37CzYBeEWJotWbYLXFVqMZNv0FI0xXesoxmh1b3/5q5cpFsNwany9klqZGLtMH/2UeQcQXSHNV1hOvLPgG7+UdC4VAZTQDRg+bLc1L3P2G6rXjPGxkrQ2fxzH9uxSLjlT/bv+j7owlUDaIShW3FXj/E2m7pZf/5xZQqbyqOZnAv3CNZoYTYy6Y2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qaHdqh0JU4Wm8YpFXwOqwSy5YLfyp2xe1qGKRs0jhgg=;
 b=ud/bBAcJJqvfkbpczDzTXQsziGAxWapGY3laU+TOaxS12IvEQ6hSeK9vXTCkSnEKALB1wlGLpJKvvnqLdp1RlpuBMgxeqCKJWPUDxW8Nw++Rzaez+kKc8xXnsYqpnmWF6T/cgW6ugT/a2HWu0SUoCNFJfvevxsVY10Z4ntP/SDaAshtbqD9i4x8MHmw0zHvieBhBkD3HP+3hPtaegrxwnZPIwMwrtukh7wW3PjqsigHolNqed4M03gp5j1l7JhBF2SSVRv3Ok7LtnB96en/VedUYoh1/ovIeyBTmdxHwwZ4Ks4kgsb9Ccmw8+mTqdorLisZfxS2xNlNjxf/CpgZw8g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB3843.namprd12.prod.outlook.com (2603:10b6:a03:1a4::17)
 by PH8PR12MB6961.namprd12.prod.outlook.com (2603:10b6:510:1bc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.18; Tue, 21 May
 2024 18:24:52 +0000
Received: from BY5PR12MB3843.namprd12.prod.outlook.com
 ([fe80::efc8:672:884:fafe]) by BY5PR12MB3843.namprd12.prod.outlook.com
 ([fe80::efc8:672:884:fafe%4]) with mapi id 15.20.7587.035; Tue, 21 May 2024
 18:24:51 +0000
Date: Tue, 21 May 2024 15:24:48 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, kevin.tian@intel.com,
	suravee.suthikulpanit@amd.com, joro@8bytes.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
	yi.l.liu@intel.com, eric.auger@redhat.com, vasant.hegde@amd.com,
	jon.grimm@amd.com, santosh.shukla@amd.com, Dhaval.Giani@amd.com,
	shameerali.kolothum.thodi@huawei.com
Subject: Re: [PATCH RFCv1 07/14] iommufd: Add viommu set/unset_dev_id ops
Message-ID: <20240521182448.GN20229@nvidia.com>
References: <cover.1712978212.git.nicolinc@nvidia.com>
 <6e57d7b5aa1705bdd547b1cd2aca93d3bf70dfa4.1712978212.git.nicolinc@nvidia.com>
 <ZkDWXnPW7CaX5TtA@nvidia.com>
 <ZkGZc5dvLigXcWib@nvidia.com>
 <ZkOI8ztR1mUMJ8oe@nvidia.com>
 <ZkQW6/OAQ8MzN6Go@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZkQW6/OAQ8MzN6Go@nvidia.com>
X-ClientProxiedBy: MN2PR04CA0025.namprd04.prod.outlook.com
 (2603:10b6:208:d4::38) To BY5PR12MB3843.namprd12.prod.outlook.com
 (2603:10b6:a03:1a4::17)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB3843:EE_|PH8PR12MB6961:EE_
X-MS-Office365-Filtering-Correlation-Id: 09b42258-a4a3-4a82-d236-08dc79c34dff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|7416005|366007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qaA9yQ2YaIjhBB22WMw31zXqqN5YyNwNu38fFpp/6tG+/HH8ALjo2/vnYqOx?=
 =?us-ascii?Q?ejVfmrrC7Q7xA2HdAiGo+bl/m7inBmXd9oeahgZZ6CNwbHQDUn0tn6T1vRVq?=
 =?us-ascii?Q?aCCdtoElh7GvIFt+wt10/oBmMmJQ0cNi7zZOFW3IJoCPCtm2brofoAHqUMs+?=
 =?us-ascii?Q?X/HypsyWG29Xn7AtdtnU6sV8pdsrCpgfrQyoVYj8thymuyYGwVdFEoxpGLsC?=
 =?us-ascii?Q?AacjEZAkkmmpPwhyeBRB2mM3tNHoaB2ZV31HHL/zrrdTO2KUWcTaaIkRcYIi?=
 =?us-ascii?Q?Hd7Ng7EUiEXw9bo9W2JRtNzztQcBaHJZXqFNzXxX+9tWkWV5GvoGnM2CLsMX?=
 =?us-ascii?Q?abb15Z4YYr9U2HpmyQK+43RY4SN0sQ6Id3eBWnzg3dyXu9IPY1PEYJ98rePD?=
 =?us-ascii?Q?R30veTArzJXy8gWBtNv+mQgfaWkUatXhCtcHrD/RBa1bZts89E1ZWUNU+JMD?=
 =?us-ascii?Q?bHE23yfjc6hRu6BzZkDGIrJ+e1iuuJ3jbxGKQyEYNdTy0MKF9QTPjZw9sWOu?=
 =?us-ascii?Q?8bykdTNqmFw1JXvwBDpenfIydYTZm8SZGl7cjjzCQ7IepGbO+DrK8cVMAJOf?=
 =?us-ascii?Q?Zj32Tl6DrocQxbd+i9Ndphz3PqgcnmXZ1bpXXe9x89fHtVWoMKkpipfef9vL?=
 =?us-ascii?Q?dvqxXKBMfcH1TS5B0cIXumrMlXt43vKhq9OSAz0YfpkQuvJKb9RFXXcy2ihv?=
 =?us-ascii?Q?Ml6Z5QiRXaHRJxOhjdylNdfJ1QxTaTRdTBWBpTWqlx9c1fSlw6t/T6WwBJxv?=
 =?us-ascii?Q?jX+RnuCK3/HMvt0kDEV2pFkkvErjS4vdSbv4aW4gxg1KhR+WyJ5SNVwHmd3k?=
 =?us-ascii?Q?T1gedWz7vDfjDksIp7scM4HxDJdVNl/IHw622usyHr6rCECb+obqWDnM9zmU?=
 =?us-ascii?Q?jIXd7wuwLzHkBMWwk5SCs1uLgE3tDLHt5nxOnIp4fiPlrwn6lCig2MqdONlY?=
 =?us-ascii?Q?fb2hVR8Ec6ixcZ2HsrcEZ2Xru85tGc9DGHKsI/1xt5Z4SUy45DY68G7qWYxJ?=
 =?us-ascii?Q?iF18MbJKTDbdiJx4cGaNCu4jKTLq0+ranoQ3zVLqtFp8UgMtS+Ep0nFQQaZc?=
 =?us-ascii?Q?vry+1JVPrcvwi8FmOsnQ1zkVrBpToPu9GEDb5nj/xfHrKU84CRA6UE26W2hx?=
 =?us-ascii?Q?0U8nSym8lJ+aga7XggNz/BJhRCsPPYksADyurMwwgzdSdg5ZKDpzAA4SQ5mY?=
 =?us-ascii?Q?mzk7uD7Pa97GYY7eVUGW9xwIFJS97MG3qypXaOxgn7npLBLkun8oMcMcJMTx?=
 =?us-ascii?Q?9JfSexltOVRQ91uWl/XNywnLRvnxcc+o82J3eNWkqw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3843.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sds6rhREMz77Wqh+8sK4GVBFW/KmTpGRIckPTpG5D5s9MGM/JEQ3kjsHrqFF?=
 =?us-ascii?Q?1Wsdy+wfIvCK15r8JhhA7aWyLOIcG+QrCKKIJruElhSnE2X9IR/jlfi27CAF?=
 =?us-ascii?Q?fAJQAc+CsS7s2ADUGF8e4XJ879VRoZsYp6lrwtha+UCipUBrfwT0Q6jvMAwV?=
 =?us-ascii?Q?Kb6GxrQAQzEesLAT/sBdeqgZNnMXuxbSKimNsPXFK0iilJUDcauwtzoCsnm0?=
 =?us-ascii?Q?dogjgzZ5970LzADFi2KluN4AHIQnZsJG4vP87ZOnsHePUTfrVeiEXzyINSoF?=
 =?us-ascii?Q?A64Lnzk8NwKbhTvyxbDwX7zw+RZb2etA4HsN+I/EY7CJVJiHgE9qzb98cb9c?=
 =?us-ascii?Q?VL8rPxJYV+Xm/vABQk1kVeeufDBk3SmhyfdPVwyfU/0dDiedFLM+zuD40iwd?=
 =?us-ascii?Q?ocjFC1iBRKYW9f6OxT33mDyPKb+2KzAeClOn0JWDtiYoKedFCnVpfPYjhS2D?=
 =?us-ascii?Q?zuIO6+hfoOIcpLUWsnG6hGo7AkhbO1J3tPLgJs54Ih1Netgw6nrGdJRP7TwR?=
 =?us-ascii?Q?zF4QUJ/0vtvgrumo18YPuWQGWekBG5aOmLmqFUql1LZDtRqHxoK1bI0c04Q5?=
 =?us-ascii?Q?z17eInTi8y18r638mM2bBmTgn52U4u4JYqRCczfeCcx3B5p3gVJ5euoZmPe7?=
 =?us-ascii?Q?hGXdl3RR3oqbcQuYvgJ0+BBLMU0wCmlzzn5DQ4Rlun3F06cogKBeP2gOvtno?=
 =?us-ascii?Q?06ukIML3GHXeA7Okn850jU+u+goC3P5o8bBfnt/JY8dl5DzzXeirH3uBTiH6?=
 =?us-ascii?Q?73xPFB3e07fGn7dJc9xlzsCdf1aV7vUqmK4Wi2Itdg9G0hY+DJscXDDYYMuB?=
 =?us-ascii?Q?QVqCd+bCD5gmzlquh/53aiZj9fuj3+EFKrkIvLLzc9BQX+/2VX5g7SkeEyHW?=
 =?us-ascii?Q?uHYGIdcb8hj4kT21sFZ7ohrGwQvYWRWL9R7t6qvuoNjF0nh5RMSGh1rUugyN?=
 =?us-ascii?Q?TdKwtQEl1hP6NM3pjUJ9Y53PRyywaJ8DXpyCoT1pJPZL1aQg7qNEo+EF6pAG?=
 =?us-ascii?Q?q7KhipM50fGHCKS/Fk+5+/aEqxDgDzQ5Qu8aDJIWDX/FKfqs75L4peHGRDJ9?=
 =?us-ascii?Q?PGTN5em2y1ndH4GaJ+Nl3WsrTib6L3N7fpplpmyfeUPeMb2HHfmOipA187Vg?=
 =?us-ascii?Q?DwBbvT5bvfJWVGF2eawu8h982qTe5z8vcPm+d+rLROSS0Gn/IigBjcdSY54k?=
 =?us-ascii?Q?zM7ZSPpyN5Pdl3rUwMDKDAzyeVufGoOlp8HqXY3qIbVn9WzkKlWgdb7yjqt3?=
 =?us-ascii?Q?q1gTl3hiV8rjwkEA3uRsfArG0Z6emGEGDAXA5HYCgFYaPB036Q8XJvrh77Lm?=
 =?us-ascii?Q?jz50f0cSG0elqHCHQPZfN74A6KAXmQ9PARmrmin0z9tiNLOFhS2W9AK9mc6o?=
 =?us-ascii?Q?Ws3vYjFUDs35Gp+CqGnumjIf8Wq47Ul9sr9eLxmmfDiBkehpxaQm/iGBaJJ/?=
 =?us-ascii?Q?UjNhkEFW64L2PhzQSyST19sC8yE9EYek+JDIaQbv/qwV34YKzfCUs5MXA7zs?=
 =?us-ascii?Q?reZSNlgkOXie5sJeWG7pf6GUoEvANtcGWe/XMZYm3R0V+eWknK3F+kt982Tr?=
 =?us-ascii?Q?OdT3QXlp5lCBVkcE3uk=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09b42258-a4a3-4a82-d236-08dc79c34dff
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3843.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2024 18:24:51.5201
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EoxoejxkBG4J0H/RcesGPWtnsdeiwyqQ0ED9RqN5ru6C/g4tjV/M2XXDuEsFvWFT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6961

On Tue, May 14, 2024 at 06:59:07PM -0700, Nicolin Chen wrote:
> So, you want a proxy S1 domain for a device to attach, in case
> of a stage-2 only setup, because an S2 domain will no longer has
> a VMID, since it's shared among viommus. In the SMMU driver case,
> an arm_smmu_domain won't have an smmu pointer, so a device can't
> attach to an S2 domain but always an nested S1 domain, right?

That seems like a simple solution to the VMID lifetime, but it means
the kernel has to decode more types of vSTE.

> > Functionally we could use that global nesting domain
> > to deliver the DEV_INVALIDATE too.
> 
> If my narrative above is correct, the device is actually still
> attached to S2 domain via a proxy nested S1 domain. What cache
> do we need to invalidate except S2 mappings in this case?

qemu needs a reliable place to send the invalidation commands to (ie
what ID to provide).

If we add IOMMU_VIOMMU_INVALIDATE then the ID is the viommu id.

If we enhance IOMMU_HWPT_INVALIDATE then the ID is the identity
nesting domain.

Either case leads to the viommu object in the kernel.

I don't know if there is merit one way or the other. A more specific
API surface is nice, but the two APIs are completely duplicating.

So maybe:

#define IOMMU_VIOMMU_INVALIDATE IOMMU_HWPT_INVALIDATE

As documentation and have the kernel just detect based on the type of
the passed ID?

> > > So again, yes, it makes sense to me that we move viommu and the
> > > set_dev_id to the nested series, and then drop DEV_INVALIDATE.
> > 
> > I would like to do this bit by bit. viommu is a big series on its own.
> > 
> > DEV_INVALIDATE is fine, it just can't do ATS invalidation.
> 
> I am not very sure about AMD.

AMD will need the same vRID -> pRID stuff and we want that to run on
the VIOMMU

> Same question: any other case can we use the DEV_INVALIDATE for?

DEV_INVALIDATE was interesting before the viommu idea because
userspace could process each invalidation command and when it reaches
ATS it would invoke the correct DEV_INVALIDATE.

With viommu we expect ATS supporting drivers to support viommu and
then to do vRID -> pRID in the other invalidation paths. In this case
I don't see a reason to do DEV_INVALIDATE right now.

> > We can add ATS invalidation after either as an enhancement as part of
> > adding the VIOMMU either as DEV_INVALIDATE or VIOMMU_INVALIDATE (or
> > both)
> 
> Yea, maybe step by step like this:
> 
> Part-1 VIOMMU_ALLOC and VIOMMU_ATTACH
> Part-2 VIOMMU_SET/UNSET_VDEV_ID
> Part-3 VIOMMU_INVALIDATE
> Part-4 VQUEUE_ALLOC
> ...

So we have this stuff still open:
 - Identity STE with PASID (part 2b)
 - IOMMU_GET_HW_INFO (part 3)
 - IOMMU_HWPT_ALLOC_NEST_PARENT (part 3)
 - IOMMU_HWPT_DATA_ARM_SMMUV3 (part 3)
 - IOMMU_HWPT_INVALIDATE_DATA_ARM_SMMUV3
 - VIOMMU_ALLOC, VIOMMU_ATTACH
 - VIOMMU_INVALIDATE
 - VIOMMU_SET/UNSET_VDEV_ID
 - VQUEUE_ALLOC / vCMDQ

I feel like IOMMU_HWPT_INVALIDATE_DATA_ARM_SMMUV3 is a reasonable fit
to part 3. Then part 4 would be VIOMMU_ALLOC -> VIOMMU_SET/UNSET_VDEV_ID
which brings ATS support the API. vCMDQ hypervisor support would sit
on top of that with just VQUEUE?

Jason
