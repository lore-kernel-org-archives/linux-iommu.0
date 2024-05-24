Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2080.outbound.protection.outlook.com [40.107.223.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3AF6126F06
	for <iommu@lists.linux.dev>; Fri, 24 May 2024 13:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716555934; cv=fail; b=oFA5IX/R0AU1Qcg9cd4b5QF3MRkGxnKIIT1bC8NGNFV0f7+ZPS1iao86qUCAo3WD0GKUma1Ad7WSbbju6J5gaLzIBclEuKLnzReqnpccGvu7fnyysAEbKZUgjtavedhgMs3o30LuYPswSSQ8xlW52KOeHnrfW4oE2wlJ1xH1k5I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716555934; c=relaxed/simple;
	bh=d9V5RWWcl+TM2TWEQq1LLLIeha9CNJH9mN7+SAncLdE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=To1ezYgq5tNxwKiWGyw/C/epBTMqTIWWzIs7ne6r3rvKJ2DG/U7nA4NdhSAYu2nxd87Fpk2QpEGE8T0iVJi1xwJxZUAirlWHky4H19pv+px737ovCNPISqMyzHd0vc6rCeUNPquVTsyXg05166qlAsrqANf435G0jN233DNk1ww=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mR+CSFnm; arc=fail smtp.client-ip=40.107.223.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mR+CSFnm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FyYBXMnRuIHlrTinWKoxQDNABVChBfWdoHVjN44/eJT+tMSggvScaCqS8dtURQ6jw2hpwsy9vwNW3t5aBFtVkk0KHVWAIhhk6gwpwq1NFwdDFbM4dnNIpv3kt7kJ9oDZ/q82vTvWxLQ5bmq6EQeKxIKPQgzXbZjSrxOOVE6pmT1jeRhytgciMSSlkl7NonN0Q1Ee2q9GySk1dhAX/evxIq8wrLRLLgVqMzLMCz/WolsfrwuZemKWLdH89Z4zp2sd9k6X3f+QTgVfeARbeyzWt1ud6nlJyz988gqH/L5pDtcaIAiDVaAVrxnK4QBfBv6g+re+MjhKMiX6cUT/c87Gww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uZENabiq0tQpvAdDdPTNtQHpvO1K8KyZtzVpkktdiXo=;
 b=T0BoNf5oggRI0pOCeorkHn9Y0KEFxKsNWKqsLm1rjuucQQVImZZRYyd91W4jhWwTttScFGFBc+CBMXuzLkoTplCmY9JGjGM1HJ/7kJeI25drbQgGjZb+o84KgIcot8fwOkTOhYlkhXkrbXxm9Z9huG/Xp8gXM/W97BjFTjV6DNwAQqX21vGcXc9TG9Sbxqu1NIU4c6EbAhUGNO4bs0pcDnluOZib2M2jqzRwntYJYiiG0fsYJcAz8/lns0IZAdd1etcoiD/Yb0r2Ah/ZTcQODeoTY7iWU3kj1iGCB6UHdaKyTy5YoZpoVI0cPxSixM62SHjYslsUZSpROfAZdEGhLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uZENabiq0tQpvAdDdPTNtQHpvO1K8KyZtzVpkktdiXo=;
 b=mR+CSFnm5gLsVxwZOgBk8WVhDIUaffc6zD/rZcK1UCDe+sV2WPT+e/KFAiuIE7FkKF9l86ljlDUta79SU2hoSf7+3zoBbWgFK6aTlmFqHnPRPj4NKfYna82+LIOrugAIEYjcVLTpHXllyjqiT3sQQ2ORKborePaRvO00wS2NunzAIDk4JMb1NMMYeBqnoDmq+ghYEt8pFlu1e2ppciju9C77EkIc1If98TJiHxoskU4IE3q0sVbHaDMAppu6aAzuSjbGmqJ9JhIbTEwge8NZio+Kl0U2xdEVPGcapqLzN3bOih9wAwzBj8M0xk8qp5DE+uybnsZoHBBxb/e4G57CKA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by MN0PR12MB6079.namprd12.prod.outlook.com (2603:10b6:208:3c9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Fri, 24 May
 2024 13:05:19 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%4]) with mapi id 15.20.7611.016; Fri, 24 May 2024
 13:05:19 +0000
Date: Fri, 24 May 2024 10:05:18 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, "will@kernel.org" <will@kernel.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
	"Liu, Yi L" <yi.l.liu@intel.com>,
	"eric.auger@redhat.com" <eric.auger@redhat.com>,
	"vasant.hegde@amd.com" <vasant.hegde@amd.com>,
	"jon.grimm@amd.com" <jon.grimm@amd.com>,
	"santosh.shukla@amd.com" <santosh.shukla@amd.com>,
	"Dhaval.Giani@amd.com" <Dhaval.Giani@amd.com>,
	"shameerali.kolothum.thodi@huawei.com" <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH RFCv1 07/14] iommufd: Add viommu set/unset_dev_id ops
Message-ID: <20240524130518.GR20229@nvidia.com>
References: <cover.1712978212.git.nicolinc@nvidia.com>
 <6e57d7b5aa1705bdd547b1cd2aca93d3bf70dfa4.1712978212.git.nicolinc@nvidia.com>
 <ZkDWXnPW7CaX5TtA@nvidia.com>
 <ZkGZc5dvLigXcWib@nvidia.com>
 <ZkOI8ztR1mUMJ8oe@nvidia.com>
 <ZkQW6/OAQ8MzN6Go@nvidia.com>
 <20240521182448.GN20229@nvidia.com>
 <BN9PR11MB5276EEC2A1DDA9C92F96737C8CF42@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20240523150120.GO20229@nvidia.com>
 <BN9PR11MB5276A896D215E1FA61DECDC38CF52@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276A896D215E1FA61DECDC38CF52@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: YT4PR01CA0130.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d5::19) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|MN0PR12MB6079:EE_
X-MS-Office365-Filtering-Correlation-Id: 497b8145-2d88-468d-3dbb-08dc7bf229dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|7416005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vsnjbMgOwjrQ5xFYrIzMAl0M71jLr7FmY4YYyNHxbj2zmz9sNf62OkoImd7K?=
 =?us-ascii?Q?bxdBPTjbfV+aqmIA0E9Fs6dgL3bm017mW4Nb0WmNwg5hJqmIua4j5tebS6Y2?=
 =?us-ascii?Q?i9TT3y7A5X3a6dXA9ZxTrUuylBHH7F4H3W7YcVqUEtk4wuscVB8coJ+y+2xA?=
 =?us-ascii?Q?XSkATl0YiRJh97Sl7IZRVzho25zY0gDiDEH7CB9yPXhB8ayI1ne8SQ8SK94I?=
 =?us-ascii?Q?viPVt+zMbWmawKgSDtUCmvNhldzpZkihyjNlCLue7HXMzUpRYtL7qO7H79+Y?=
 =?us-ascii?Q?YhPlP0ENRmmzlkgEJZF5C+o9mIo/z2n7KBJixIwV4oH0/sa1KDwKw7eXcm5F?=
 =?us-ascii?Q?KWgxYQiXUZ/w0ZIZ4jcJzpxVUAxTypios7NMLfTRX/TO+P1NqkW7aldJq7v+?=
 =?us-ascii?Q?DxOo045d9kD71tFBA4FKEYSlJ2SlJr+XXtjqwTcrrNA1KaSKvOuoTty1tfZH?=
 =?us-ascii?Q?RvHxUB+OtR7tk0cy2bgFCX2sc3bjSkyDYg3e5VVCj/K9VyLCSXD2BbhXOFhw?=
 =?us-ascii?Q?bWJEMlK9pv87lcFwexSNxsK0S7V3AmoUH6pFTrH9NLVcPo9E2xe6jXUWctev?=
 =?us-ascii?Q?W3cbuiNkNPVX5O8YB7YoweMM8dEHLixcp4mQw4gJPjH913RVczstXM3zuFYe?=
 =?us-ascii?Q?WvLEsSsBSlmZfdyOfhTAV6nOXon2T5VieJeFI7cuLu250z8kvUGLzI1U8FJY?=
 =?us-ascii?Q?sdDrk88Ns/GXiIh5dTaJ546Rq3Oe1UhYKjXRsg1DWqhlenPr6DOVUZMTUs0G?=
 =?us-ascii?Q?H0g3FNjdbZCi3WN6SinWOFjb4zAT/eDaHydKmomfde53eEi0AUbBk8+tNXoi?=
 =?us-ascii?Q?eRhnNh1Nkgfj4RLfYMoS3VCTNpCAYVukbOcvtnhMvzm8P8ryRh8Ufr3coZMK?=
 =?us-ascii?Q?4K2qo4PVbFaM8oVGDWodRGBR3z8Ouxz+hHFje4GAwIbuRyMYlKQ8V86NSjfz?=
 =?us-ascii?Q?Pg7Ofc/Zr/fI84LIHWpXC/pgctUDJWK3y6xOwhZ5B1OsTkMjsKLbnn4geUUq?=
 =?us-ascii?Q?gpZFZLQ/hmwkjJwFbVVE24ht61pYe92e/4pzhzvozs2ripDPZHjBn+Tckstd?=
 =?us-ascii?Q?zvHgOleo6Es2JC5rPe7QgqspXavXBegAPLEZX6vP3kkmk1vx9uphwwd22Q7S?=
 =?us-ascii?Q?u501VdhBWiVXSUkmK13VHYJlHCMldoHRBa/umFDQ27QuufWSkYa+i1LmKvAL?=
 =?us-ascii?Q?5MxtgiUV9xqcpBu5RoMM5dHM3fa2g8ypjlVrS3EZIYZSV3nAzSa2ZtGGYlgH?=
 =?us-ascii?Q?tUw85Ly7Z3LVzoiKo8tiHe0Nj2ShV1pWeyn26sVcdA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Qf4kJqSLc4QPdf/tTgvmFj/qwG6JDHk8DrmvNfnzflvjRPjD6dTM2mIFiDKW?=
 =?us-ascii?Q?wDe3gwcRFez/Y6d5WalKbEwpucuqZGMEIWkq0FiTmJl74pXEko17kJB+55IJ?=
 =?us-ascii?Q?sUV1x2iDjR63e/Deld6VBMbcmLiZiB8oF0FKdx09yGHPHTlVBUU4LC7s11Vq?=
 =?us-ascii?Q?j+QdRRDp0tQuZxcDmtPaaNxYMmVOz0iVBvR9SDjonKnoNsmwFzQwBolnUqzy?=
 =?us-ascii?Q?a8BNqQ1nqQOKp6AGwwwus8cS/JgvPxYbB4YxxX2eoE+Bon9RoRsoPjFQfLGe?=
 =?us-ascii?Q?A5hNU5mSr62jNZuDICrgyA/fLpOttsKZnqPuy1kTJBn9mOfrj3pd9AytfmS6?=
 =?us-ascii?Q?n6oLivDdH8FBXaLHg6VIozmdHY7D+3Fk2/t8oHbPOPGADssC4GDTG0kkENWC?=
 =?us-ascii?Q?VU61GcA7hxmrNtz/s2YC28EB4uPWR9mN1rORNkjdSFLCC/kLchTj95+Km63i?=
 =?us-ascii?Q?EpmVQsFWq7hzGF8/T6ztw7X+0vD2FYq8TjdpC8xrBeh96sTQrF3mdgN32zu6?=
 =?us-ascii?Q?CS6VwFhtE8TdH6i4bl8Q6yn4i6egQM81vvQv0iriEOzbitvFni2kJd3K4tnV?=
 =?us-ascii?Q?K3vurABO6M+yVmhRxEsvS4D2VYVFJAXNQF3BxKxDAfu+uDYGpXRoHKaSiaI0?=
 =?us-ascii?Q?atCgdFrTmlH6NmE3FD+HKbpvSNbHrL7DcvX1fbOQKTnQy9g+4HTngVgdL8gp?=
 =?us-ascii?Q?Kq52FmQ8Z8bGju/ZKVccK09gzBqya+lYTjN38zMJ0HBF+a7Jb0rbWTyu9xzl?=
 =?us-ascii?Q?l1PAeF4bTyavB9xBvziermpQA4VLgSip9WqgGjbGTEZ/iMK+XeLpVqkOp9Jz?=
 =?us-ascii?Q?2bYS5C7L20GK/S/EVczPj6V0Rx60Gq5GVQLuHuAcUlB+UL3VcUF34aryp1k8?=
 =?us-ascii?Q?lVBKa5OKAJvHY4W2ZG0VCkkFvVreJDHssFxDwn3iRgKGzyFXPVgL9eIMGZhB?=
 =?us-ascii?Q?8IWZVoMYRuBS8/8JXUPF1YE8E01nyYGH+58FVZmaZF6Uvjv3+7BClZ0M/Y0C?=
 =?us-ascii?Q?MgjArUEhYlxlMGnrbyotfFcaAbVigjThIniTp0bPRDVuOTctws5J2fz7EYHV?=
 =?us-ascii?Q?3F1UCFdHEyQPp0N9+hU3CcL2ao2scz8zB4jbwvELxyxwpNZV6JBF6v3WFEHD?=
 =?us-ascii?Q?eHzL+L3c2o3Y/Lj0h5CoJS8ztNReehZ5iCZfCoTprwuM7vRiTRCccbJIPkPg?=
 =?us-ascii?Q?KNA5kS0FdRHA9y2hZW4svWV23NhMBOK6iiPPWyBD93oJ9+F5FfM0hGm+sLCp?=
 =?us-ascii?Q?gA97ujBTxjIfodoXPO4GSeSV+gHx8gJ4sW9mkC8wGEpusmewttdbkANg4KfJ?=
 =?us-ascii?Q?NdDaoU1p/RDLxeFv1yKOAAfCY9qO7bvMNEuJtbZY80kXjXEkrAYFiVqN355t?=
 =?us-ascii?Q?YvOrB/8Un8QNI3mFzBrwQ6ueDDIb9VB/UH/isBycQ2FfZ8bsFv07RbVfeBed?=
 =?us-ascii?Q?TEF55/GUw08CjDFinbu7wkG7VXgapMRvjT+xT7cvpGpEUJS9J6MSisA3W5yG?=
 =?us-ascii?Q?B8jvmP9XZSxxq8Yn4LY5ItZUDnYrKXZ6MjusxwvtypyL6bWnXQosdkj4HJfY?=
 =?us-ascii?Q?R6u/6VR7vsGog6/DG+PigOICLj6cYR1cPTZ5UDH9?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 497b8145-2d88-468d-3dbb-08dc7bf229dd
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2024 13:05:19.5700
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DAhT+xO02L15NR0etfwBtR1wrJsEvtDvJNUnjyfUPayiKXst8DwcWT8mqf0LF+nc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6079

On Fri, May 24, 2024 at 02:21:23AM +0000, Tian, Kevin wrote:
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Thursday, May 23, 2024 11:01 PM
> > 
> > On Thu, May 23, 2024 at 06:19:59AM +0000, Tian, Kevin wrote:
> > > > From: Jason Gunthorpe <jgg@nvidia.com>
> > > > Sent: Wednesday, May 22, 2024 2:25 AM
> > > >
> > > > On Tue, May 14, 2024 at 06:59:07PM -0700, Nicolin Chen wrote:
> > > > > So, you want a proxy S1 domain for a device to attach, in case
> > > > > of a stage-2 only setup, because an S2 domain will no longer has
> > > > > a VMID, since it's shared among viommus. In the SMMU driver case,
> > > > > an arm_smmu_domain won't have an smmu pointer, so a device can't
> > > > > attach to an S2 domain but always an nested S1 domain, right?
> > > >
> > > > That seems like a simple solution to the VMID lifetime, but it means
> > > > the kernel has to decode more types of vSTE.
> > > >
> > >
> > > why does ATC invalidation need to know about VMID?
> > 
> > ATC invalidation always requires a vRID to pRID translation and the
> > VIOMMU will hold that translation.
> > 
> > On vCMDQ HW and on AMD HW the vRID to pRID translation is pushed into
> > HW, and vCMDQ requires the VMID to do that.
> > 
> 
> At a quick glance VMID and vRID->pRID translation are both configurations
> of a vintf.
> 
> My impression was that vintf->vmid is added to guest cmd when it's
> about iotlb invalidation.
> 
> then vintf->sid_slots is walked when handling a guest cmd for ATC
> invalidation.
> 
> I'm not sure why the latter one requires a valid VMID to do the walking
> except it's a implementation choice made by vCMDQ?

Yeah, that is probably right. And then in iommufd we are sort of
doubling down by saying the VIOMMU object holds the S2 and the
vRID->pRID as a bundle together.

Jason
