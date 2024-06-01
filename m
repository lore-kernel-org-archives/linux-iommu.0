Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2053.outbound.protection.outlook.com [40.107.237.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0C52032D
	for <iommu@lists.linux.dev>; Sat,  1 Jun 2024 23:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717283132; cv=fail; b=KfWsJeVy/42F1tdB/GVKghuIpqKT8X3dNJ4C9o41PagNLoGrsKJQfE2X23ycV5QXh9qoJ3KtWF4ywMMaIz95BEwsvSDaLPGkzfZxGEv49Dxsniym9QOh9xkrlJ2MyjjcZXVOskDAzSMP9pUZcxvBQyawDpoDgvwTN4nvnC0/4lk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717283132; c=relaxed/simple;
	bh=GIA88Cs5QAJ+SnCmUh1vg9IiD6TjXainI/ygKwYrR6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=chYu9fdlZauJG0BlygQzDkPjUwXct3UOZgrGIvvmoyudlqLCe4o3pL6td6akRrO3HuTwmYs4ODztz05osioX1aTYpuwQaW5UP/FAUltvY9OMfvCQ4RzJ7Mxdg1rD4AnfARhn3TAD+YEDn7rkqlwwy0gl6TMYWmHzGKM4b6GPYMY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qiDdXnLw; arc=fail smtp.client-ip=40.107.237.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qiDdXnLw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SiBkvSHf7fa9WU5sOtkmezFCBM99GaNBZ0JbSdr5twEjvSpGmUsSKAPmCw9yEDcNv7yMwPOCq9wxE5yYIHrB4LTBBHomRSjb8IzYS26Skh888q6MBwJ1Ihu3X+aFo5x56mniVeNNTD38fn6mJgzkUOTA3jJnDl6/89d1WahKu1wYaXW7kNaaWh8akAdOrfpKiVnsZwHQtkXa/a7Flm1yvs4yq6hHRSFE9gMM3Fw9ZNFcUXciGbHiX7VGqTvGxazVNBuOR/hYO6/F+AjmmWfZ+qZbnWxmvuOPq27ZvOvlIT3/Fg7mijgXqXFBSE2CdCH+QOOwd9fZtzxkkMpiOwsfyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pDGJ5iRUCjnBNSqG8iRKYMqrAygPidV7HbfHMK2KRZ4=;
 b=ndqHpaAp9sWqwAPJqWmKxxT7tdUVOBu2LxDAerDluhGlGmLLGVNpUNBrXBr2vcTnR+q5J4Uqe6ye0WzRr1cc2D5WZnRp9DDCUaHgECU8hwj4Qq7nCpVa3F7dHjH0QKiYERCNBl1hX9Da1+zbkRJK3hMBji+BheiC4lVZF4vGyZBKtzj0J0cgUDAkl3K1RxWQ/p7M6506mT9/Og/OaPAINoYcUsS+kvvR1UftklskhNUTNNt+a6Pu8P+bakPOuW6RNdQZCeMuMYQUxgVmpSphFXaK5Pn26zNArPoo2CJjUdtr42ZOYA6hO83UqOsI5+rfvKEtr2h7oPi2d3MopZIhKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pDGJ5iRUCjnBNSqG8iRKYMqrAygPidV7HbfHMK2KRZ4=;
 b=qiDdXnLw0xVuW9ZghwKUh1nLqgpkIvFs6sMr3pE7erJB+U3uigRPgorW9zOraTVkOPLe/pHZ5Di7XZE78kEZ9IybZ0Uwii0Ky181W2EN2JmfuGnHPnTK6MbvH21qAxVNETSJmfAXVEhJu1s85JENT5vqn4AEIrivXEijg6cBU5jOGaYC75ttTNCH1DUKiRJ3AKz3gpB0JT5pAflbvTSScQ2b5OWIXSScxoI//jVtz6OowtEuamwAtFM+poEwWMhutDWAJA4gFK5lz0NosnysffrkVPDbL+FYsB+88h2tiIXlON/dBWTbC7V5HtVoX9lMGCxoFudcylPpxaLl8vUk3w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by IA0PR12MB8906.namprd12.prod.outlook.com (2603:10b6:208:481::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Sat, 1 Jun
 2024 23:05:26 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%4]) with mapi id 15.20.7633.021; Sat, 1 Jun 2024
 23:05:26 +0000
Date: Sat, 1 Jun 2024 18:45:01 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>,
	"will@kernel.org" <will@kernel.org>,
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
Subject: Re: [PATCH RFCv1 08/14] iommufd: Add IOMMU_VIOMMU_SET_DEV_ID ioctl
Message-ID: <ZluWXYQjroz0fqqn@nvidia.com>
References: <BN9PR11MB5276A897A5386DFAC9A35F9D8CF42@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZlAoN3s96HL7ROth@nvidia.com>
 <BN9PR11MB52762A0BC67B64D4171480C78CF52@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20240524131912.GT20229@nvidia.com>
 <BN9PR11MB5276BBD592021507C3A0EBB38CF02@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZlY886FT3HHLC8Cf@nvidia.com>
 <BN9PR11MB52762EA9B444DA71F551C3868CF22@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZlafEktUu5znDsNt@Asurada-Nvidia>
 <BN9PR11MB5276AC43120376A2502D3D148CF32@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZlfPPwsnY6P4SoGF@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZlfPPwsnY6P4SoGF@Asurada-Nvidia>
X-ClientProxiedBy: YQBPR01CA0041.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:2::13) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|IA0PR12MB8906:EE_
X-MS-Office365-Filtering-Correlation-Id: 597b857d-8a66-407b-ca41-08dc828f52b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|7416005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ns9V9E6ltOacJ6KgOwifpzxTBa3w6zSipK0wgSddEToKb8FFYJyFkabLer0e?=
 =?us-ascii?Q?SkT9u9PR/15ggSQR8tIS4RnVnWWExctgmBU+Uork74CqDzKEEubwFEM7s7dm?=
 =?us-ascii?Q?KQDbyhevx2izeEr/AQMu+hEi+aSK1ZySZ9I1DGPSB60DoUgn/QvnXFivBaTS?=
 =?us-ascii?Q?RxY6Lvj9nCsgZAfa+fzKIx6jCor7iNvgWcwNrPya+wTdc5wf+8s8Hwvw66XZ?=
 =?us-ascii?Q?Ttb/x5UyuFkFfyTFoNe58gKKUhwy4o7zn6u+SA35ADHjfEC7F5NbY4QxPMiz?=
 =?us-ascii?Q?229wDh3hKgtILKwstiLijtM4lCgScXLaawQvXO/M9jeLd302dcF9lY9n0XTX?=
 =?us-ascii?Q?5qcsSUqpNcBCCUC2LiRdq2sFOhNFwLsOVTRRoPhzsFDp076SZ7zGJ7RbHcV0?=
 =?us-ascii?Q?PicUrzo5VgwfdAJYWMJqWo2mwMXh9+Af5RO2/rUln9Leo3iBC43AOuN5L25R?=
 =?us-ascii?Q?qsdk9v3ECr9IDN4f3+7ZbLi0DhpZLGQ7iwNmJkbIwJvA3yYIMUs5N7zEF5bD?=
 =?us-ascii?Q?vvXHrpYUs4lhZGAgzFV9LeiZsAWr7v43vUW98oqvEicBEUxX7FVHXgPJMIT5?=
 =?us-ascii?Q?Ak015Sx5Vp24fHgaNK1GV9MNKCZcmcnyvude21sYBMk465yg7zKdatvCxIg/?=
 =?us-ascii?Q?HavfoX3c47qM39jA7HwFGpV0fsYNNt4kZsnyMv597j/6kaxV3scJyYoiN7Z5?=
 =?us-ascii?Q?22UAj+2f9jmWG8b7HoKZN3PA5f4LXmL0XCp0H81qKTNqPxLSVXhS+EQ+cO8r?=
 =?us-ascii?Q?OMmQCci8d2R5zFLf+rpr0eHkREImsFSwb09Un486Qh2SruTNTmh+Hiy4m+uS?=
 =?us-ascii?Q?rQwTrP3Ush5/fcunW0RG245RJvcMiuJNk8VDy+q0QJaDYAykaGLkSsXKpa9q?=
 =?us-ascii?Q?k8lPVQJsW8/zKqH3c0CJ+PpmJ7etHprs/+feS3xNEGHnlfiom64uDNGKl2Vw?=
 =?us-ascii?Q?fNWrdW2W6KYVBMOfjJTohvVnJFNW0sfgLiXc1ga0bihhLbR6x671RhOSd3yt?=
 =?us-ascii?Q?NBtimm01EGLOZMjuMb5majEVstQzTk1hDS6rzqUatKcK5x74jWHXvP6fbI29?=
 =?us-ascii?Q?0kLMHSvJ6RHr4cMoW47GJIsrWrXiJ7IPJ4OKfsQUliC4NnUKiNETC2jR7EJA?=
 =?us-ascii?Q?MC5QlOald8vZ8tdtiXCDOFl57SG8itbpn3Rw2JszE+bvCjRqdtDNO/bo7jOa?=
 =?us-ascii?Q?2QFQ2FdCnIUSmswRnNh4+2AAhdWfdN0z54s8sWeeathYSQ4gvJiQyL0CjjXI?=
 =?us-ascii?Q?hHqeWKhxTwB1vHqAh8lAwPUG/FotRyELipkKQ3MXHA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BDHGH+/R5hRIslQtzdnYBfXMnJJuU4UfXtJiFH/WY0x9r71sf0X/EeffuQIx?=
 =?us-ascii?Q?2ZRl/9SeEwqzddQuWH8caStlM/u/fx3cPGSGAQRzGcERXNaMrSDyhgvDuVEN?=
 =?us-ascii?Q?I/g/sXPH1RE3mhhY3CUudJ9Wqqa8tpvT0ccSlLfluFripdlRJbdWPoOEssB0?=
 =?us-ascii?Q?xvg4DPWtY5cwUIov+pntsYop0CF9opzcJwY+pIp2jO1t+D/bZHRQwromqbfV?=
 =?us-ascii?Q?0NsLIdh7clYrSScnYzkMLtonpDPN9ZoBmevMvakdWN9jzx3xsATLgfCNsj2Q?=
 =?us-ascii?Q?1HJGXb9ryAJYwdpT+dvGyPG4QueNlgiDI9UcFivg1X8JvesFT3F+Djawycox?=
 =?us-ascii?Q?Gc+swTh514P3CUDDdup8g2uDhnANSoJ1lnPPQ/9nEKa3Bb8WYZbERhhO3eJX?=
 =?us-ascii?Q?fX5HeSgFSrLemr6YxPqdVU561l+qJNdzLiQ4OXOPr/7VXnEBC/U8fPz7IbG/?=
 =?us-ascii?Q?DQIct26r0W2pGjLwXtRW8uVgeVQ60it/Apq6Ij4Iw1ZfcvjmV/ytUHwfGxmK?=
 =?us-ascii?Q?zhnm40HXbpxohRCIgs2+MnNXvRtu1K4w2o3BzvdDxQfU3dEsfJN2vm1ZVCJe?=
 =?us-ascii?Q?bFVujfosS/36ZEuhpcKfyOhAy4caRuIJ+Kmj2+Eq07dOZHjqK9Nnv/RwtoxP?=
 =?us-ascii?Q?DiAiac+8UrXMq0Mndyq85aypTWocDtPcArn32OCYgqDFCIcPeAUEETJ2rEV9?=
 =?us-ascii?Q?WKzYP2FWA0+atmoQu+4nNgyDckbDdFA8aZ9Kut2fCizeI324FPnkPTzv8G0V?=
 =?us-ascii?Q?WiC12F2u5hQL3b3Bd98XklPNQjhIMHPqoBpkAggP0+j0XyB3Iqbx1tFv92WA?=
 =?us-ascii?Q?11j4niFlXjfqKUr4f4omyU6TOWbZ8QgKPifXawwdtF7ceK8inHDYU1Ssdwv4?=
 =?us-ascii?Q?wA+vWnUNwO2PmxqayNW/DSnO6Os/ZZXYPNZk2SMAz/AZNCAOCthO0QwEk84B?=
 =?us-ascii?Q?0YhHNvFZTGfe7FrYJ5cQwZWANJu3PZXAqVgST51dq5tPvBootWiWrjPQt826?=
 =?us-ascii?Q?snxVMfVnp3uFZwhcgUXHgFlxoIStTwoSoU0znSZRLLirMg4ZTfZH2WSAGFnz?=
 =?us-ascii?Q?XhiGDECPaPPyehjFKArrj2xtZEhwv41cOXKu/dpH5bKXffl89kBYipzShKyr?=
 =?us-ascii?Q?ukVg9QP5jKY/0IikhmodWZ2CXpN/RbYvrnlaxZH9YXuZfIab60BTzpDB1pIT?=
 =?us-ascii?Q?Yl7CHi0wZIr+FjqewU68atsHpuG+E59P5IKE0PAd0Rh5mloubvuNW6ct9I0V?=
 =?us-ascii?Q?38v3F9DTaIOeH1xBlT0s9D+DK8NLfyjAkMiOdBRLX0d1RyRH6Zh5kxGcrSc2?=
 =?us-ascii?Q?R0TcEvr2f4sRE923dOggVdfUYeMsopKDfzsGKkqMk8YGdFvUraxtAq7mYEFt?=
 =?us-ascii?Q?1VirZLCznI4N9d+uUZ4NxTGvcSWvGdkLMmy8eoqdEkZknjuEO/v84LyY6A64?=
 =?us-ascii?Q?jPv3D1sBqs+xCYNUlB5HVpI4f1q4oLN5IH46vrbj9ojhYmsyp0APfiXncJjz?=
 =?us-ascii?Q?9rw3lYv81IH6xvK5Iv6BhqZ3E0Ls5qngDK+jFsHP6+pXW0wz2duAk64gBjhL?=
 =?us-ascii?Q?+RFKcDDaimGUUqwR+to=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 597b857d-8a66-407b-ca41-08dc828f52b3
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2024 23:05:26.0284
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YQjkZKnJ2dsqnkPF+528MQ/wbRKTo37NQm4fq9qsBvEs5Mwblrdg8nlnDG654JuW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8906

On Wed, May 29, 2024 at 05:58:39PM -0700, Nicolin Chen wrote:
> On Thu, May 30, 2024 at 12:28:43AM +0000, Tian, Kevin wrote:
> > > From: Nicolin Chen <nicolinc@nvidia.com>
> > > Sent: Wednesday, May 29, 2024 11:21 AM
> > > On Wed, May 29, 2024 at 02:58:11AM +0000, Tian, Kevin wrote:
> > > > My question is why that option is chosen instead of going with 1:1
> > > > mapping between vSMMU and viommu i.e. letting the kernel to
> > > > figure out which pSMMU should be sent an invalidation cmd to, as
> > > > how VT-d is virtualized.
> > > >
> > > > I want to know whether doing so is simply to be compatible with
> > > > what VCMDQ requires, or due to another untold reason.
> > >
> > > Because we use viommu as a VMID holder for SMMU. So a pSMMU must
> > > have its own viommu to store its VMID for a shared s2_hwpt:
> > >         |-- viommu0 (VMIDx) --|-- pSMMU0 --|
> > >  vSMMU--|-- viommu1 (VMIDy) --|-- pSMMU1 --|--s2_hwpt
> > >         |-- viommu2 (VMIDz) --|-- pSMMU2 --|
> > >
> > 
> > there are other options, e.g. you can have one viommu holding multiple
> > VMIDs each associating to a pSMMU.
> 
> Well, possibly. But everything previously in a viommu would have
> to be a list (for number of VMIDs) in the kernel level: not only
> a VMID list, but also a 2D virtual ID lists, something like:
> 
> struct xarray vdev_ids[num_of_vmid]; // per-IOMMU vID to pID lookup

I feel it makes most sense that ARM (and maybe everyone) just have a
viommu per piommu.

The main argument against is we haven't made it efficient for the VMM
to support multiple piommus. It has to do a system call per piommu
each time it processes the cmdq.

But, on the other hand, if you care about invalidation efficiency it
is kind of silly not to expose the piommus to the guest so that the
invalidation scope can be appropriately narrowed. Replicating all ASID
invalidations to all piommus doesn't make alot of sense if the guest
can know that only one piommu actually needs invalidation.

> And a driver in this case would be difficult to get a complete
> concept of a viommu object since it's core object and shared by
> all kernel-level IOMMU instances. If a driver wants to extend a
> viommu object for some additional feature, e.g. VINTF in this
> series, it would likely have to create another per-driver object
> and again another list of this kind of objects in struct viommu.

Right, we need some kind of per-piommu object because we have
per-piommu data.

> Oh. With regular nested SMMU, there is only one virtual SMMU in
> the guest VM. No need of copying physical topology. Just the VMM
> needs to allocate three viommus to add them to a list of its own.

I understand the appeal of doing this has been to minimize qemu
changes in its ACPI parts, if we tackle that instead maybe we should
just not implement viommu to multiple piommu. It is somewhat
complicated.

Jason
