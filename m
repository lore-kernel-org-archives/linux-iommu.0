Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2056.outbound.protection.outlook.com [40.107.100.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B2E13C66A
	for <iommu@lists.linux.dev>; Thu, 23 May 2024 13:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716471247; cv=fail; b=G2oJscYFmsG7t53OAOLA6SBXDc4sfy4kNvV1TDTJfEpvjshRAZ58PmYkJ7g47K+HykTCBMquL6JVVYTfZH+BLgfhRDDBpXH+xBZklfF4ohMj1zH9FQy+SoPFZFt1rU5iNVtVuSTo6S0BLHLqyplgABTWVoEFMgLuAn7x2nNwNA0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716471247; c=relaxed/simple;
	bh=Zbdejv3TLFxtaOtpGKzxcerEKnFPcP8as3iJew9hClM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lqY2BwA7nLvNTPTX89mQGPIz4zdu4ZkTc57ONbOrWiEW/owuAzuQEPPV1ocV2pDx/I35+b9XOXIhlluzzngWnzqiJdoCeDdFbocrO8/3fT8eANC1BLQH1yt0cdTwsXUPoFbAO7lxmeN872v9+w0KikcwUbvNyu8XThZFCpWELpw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=m4thKEIB; arc=fail smtp.client-ip=40.107.100.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="m4thKEIB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U11GalEsjedWCN9WFCi6CzoHaQUbMaeVa5ftc3m4XQauMHHlpxncbOXykCVb9q1WxYYqLK+HuaOrYxuolNSGL3QMBtZn3BWVKQkfLp0gxxBIbr794uLxpIPZ7HixWD43mJvdnag38Nqgk8leVjT/m2fH9WFGq45N6bcIvRUgk9bz/Arr01klgPGaKaHaZ3g7lA8Hw1dQWNgnqzuFfM/ZCvAzo3aLNdfK3j2517U/E9Q7jurELJDO6NpEXW6twJQJUA9lgJCnSGW2vJY6te/TWkgLcls6jCwbsYZL6ER5dLkocX7vhz29K477gTqrTF4vRJhNmZCgkU6wn9E4ygosUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aIII4iUOJHBZh67E0x2FGFR/W0KFROXrB69JX9DmPr0=;
 b=CYcdRiEQoiKCiTeSSxW9hGSO2fGI3ZEiNgIMk2MFnFucTByKb2djgBTD7IE4he644qAnyojTf+kqm4LuGGNXYdPvB6jSbqt6dTwkYyjXVeGkUiydnW17LUZ8ORdd3i/lBdAS7uq4ipfNxLYgCjqZwd0KieDKkfe9DbQChPjBoE/VSyBXYO85ViUTF+SeSTrOeB4YBlKBDnDEdEZVPh5bmx1EyVPvkd3h+MLf46aGf6KI2YKfaUyhgRtDnOSOaSXY4jgurXGbCBFrkk9BwmzLp+D2SjnSBdl2crQI9VKh3FUKrXGlaD9zQTJ16qB//t4jW7frdaUp6XGDmOjINjV4UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aIII4iUOJHBZh67E0x2FGFR/W0KFROXrB69JX9DmPr0=;
 b=m4thKEIBfEkYJ07mt4/rdsxrstFNHWETDMvpA5oSboSA5fLc9C87OSJ6BuUfexqXeGZp1RiFQwaOsbP5ifhHdMQ3a7tXEgK2OhfH3h0M/S4WQSzZMFE8B14FfTvhFn7YShxiPTLiN++TYHqUQPne2q0aWNgDFb8K5tP6Vg2z1j1FTV2fvstpaC/MXnwK9IgAaRsY2A5gnRmAGomO7djheCIXp409l8QLGiV1Ve3NLbZhViOU2SYtaJ25TNYvQZc7mIHNCxZezut/wmZx484MGjI3MtLFGhbUQhqY6NjhFXIc5etRPjGMkkXqn2+jPfiDJfOnKQrONSZuzYmih5loxA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by SJ1PR12MB6266.namprd12.prod.outlook.com (2603:10b6:a03:457::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Thu, 23 May
 2024 13:34:00 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%4]) with mapi id 15.20.7611.016; Thu, 23 May 2024
 13:34:00 +0000
Date: Thu, 23 May 2024 10:33:58 -0300
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
Message-ID: <20240523133358.GM20229@nvidia.com>
References: <cover.1712978212.git.nicolinc@nvidia.com>
 <6e57d7b5aa1705bdd547b1cd2aca93d3bf70dfa4.1712978212.git.nicolinc@nvidia.com>
 <ZkDWXnPW7CaX5TtA@nvidia.com>
 <ZkGZc5dvLigXcWib@nvidia.com>
 <BN9PR11MB52764728D4A8F54CCDE9B6C38CF42@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB52764728D4A8F54CCDE9B6C38CF42@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: BL0PR02CA0087.namprd02.prod.outlook.com
 (2603:10b6:208:51::28) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|SJ1PR12MB6266:EE_
X-MS-Office365-Filtering-Correlation-Id: 8aaf65fd-32ac-4cc4-b39d-08dc7b2d0135
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7ImyD5Yh009+m49Ft/lryyJut66WNlpTAqBAzR9gPeEBP7p1LyW6x/24cdeG?=
 =?us-ascii?Q?j/VAX1qaVK6V7D5JNborZDhG1O35aRcgrP/1VfDQoSgCTtx3SWknVoHzwd/B?=
 =?us-ascii?Q?/5AY47BhaZ5FlhjXgMxZgEn4ageAxPofSsD6hvU8znUj+YQPssG2+7opuJ52?=
 =?us-ascii?Q?1m7yL21roJUGykDNn/qQCuDsKJWi6qyTNqkp7rxmSVG/iD9hDNf0IL5xIrUH?=
 =?us-ascii?Q?drn6ypZrc6fd4X4wA66qWbRtLMpFyvwn/DxuTpP63mmCCMXsLcZheGskasRg?=
 =?us-ascii?Q?DG1sjU1Q2iKo5uI3qWH7efJdITHBmEa7Euus4oFUnHesu7B9wEa1STUNFBLF?=
 =?us-ascii?Q?SCy6+wsaDjo6/90nS39CXvcSe7qEUxqtHfmWHWq6Wrkh7LgOAPr3Ig1fewvk?=
 =?us-ascii?Q?2LTm47IN4dDPu2fyrrGKh+SgQJ5AMJNj3y3fr8MzY4VArOk/2S/3VnUle1yL?=
 =?us-ascii?Q?nL/avdMEO0yZwV+53/6LmiKgxemYc9gBuGATpDEVksFmFsz1g95hi7PsT41E?=
 =?us-ascii?Q?pQ9lkVmsjjkzTdcxURH/01EyYU5iDvM+RPxH8XlnGs37vTOZaKiiEQg+0Utt?=
 =?us-ascii?Q?t6vXWH/nkR3NVMf8CCSHs7ObhVNPQVts6xOX3JmSd/QnjC2ycL4mNlJZiSGx?=
 =?us-ascii?Q?+ZQhJr4dHAt5Lf3allBRWNahLnDkC/+xx1PEWjD77peVy8MVQ6j0UAxo2WTE?=
 =?us-ascii?Q?qO8Yg80uATsBPoYtz4sf0tmG+szhgAdWCYzd+lZIHkdI1XbO/NDRnbeennEk?=
 =?us-ascii?Q?7udNfOJ8ejnBHKP5y2xeZsc9pl1UbUmUSytewokuKyYXWBYvrpnqUhLrWZih?=
 =?us-ascii?Q?y6Hc3k1OsnEleAC62xz0rQXs64s8locybWOkL26/LMezI5FtY/QvOYAwhjEZ?=
 =?us-ascii?Q?nrywWJtb+h3Q8lvBfIgppkDmwaZi+gqug5qeiLQK5CpU9ZXqXBF0UOJ6CKWs?=
 =?us-ascii?Q?Y8DhgWSyHiZNgMDg2+z+2CIa7Sm1MzfepmszSmKXSTiczwMBRTHvX4BP983w?=
 =?us-ascii?Q?Sn5bDHXU8pGQrojsmB2alkqXPCwwTuRhuT8m1Lvgg6wlLbadWFt1k4+C7+Lc?=
 =?us-ascii?Q?pc6A8BGbVRwr4Yr/VmcK49XLQg87AT2W00LHeDt8sHA/w2i9iUQTMDhiIW62?=
 =?us-ascii?Q?9Ez0PO3yxOCDXyXnaV6Rj4bYE2dS/lHQXOqroQuzDbBG5XxrXsX/pdJ27u0Z?=
 =?us-ascii?Q?KAA6JL+Ydy5sdIOo4Y1WR0NdU1vw6O/fQsw9AREMCdb8OuA8KJ1aNQOcbmhE?=
 =?us-ascii?Q?+Oh8QMQfzOYpxRO1/F/cEguHeUnkn25mTU8/7PRulA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qGRorE3gUWCDv75iuBg5w0BLGMEXyz0oGLmISPOn1jEPQE7wMxT5DvBFrXh9?=
 =?us-ascii?Q?Jo10AwxzpOxp7CIeiML/4U2l6MfufuJD3lfZYma33puEMI6b2YGKFSWO+n0T?=
 =?us-ascii?Q?B7z2mM61kWRdI0rObB1IE6lOi4yRO/znIBw/sGXUfQrrsNAO7X8Nr0f2jdyh?=
 =?us-ascii?Q?3MutD0Rpf9bpRmJr7h8cek8DuZ0Q1s0aiQMr534jYFXphFk0nKA+NRaUTweu?=
 =?us-ascii?Q?9KjTuvfc3q6SapqRNlKDZSF8JW6YJxK2lK2MAghF7oNk7tNK8hqtUwl4QfjQ?=
 =?us-ascii?Q?wErhJdUXZY/S7OduQ6tCPuYneyEOaGdZWeeb+EKSRkMYWuwfITU1+k5j4Ren?=
 =?us-ascii?Q?1wT/6gJlJzoYiNFu68cH0/KZ28p70wD2w8AGvpF8obdRYeDOj9oyuvgZ7pDD?=
 =?us-ascii?Q?YlD2ivVaJ3Gla/PdHBO8fBlFYxe7cS4eR2U29eaPZ8it9kdo35xCR7WdzGh7?=
 =?us-ascii?Q?yNgYOi5fQO8+REGQeE63G1gDDtZJiOBQIaPgqQWcKpb0oR+BwY4l1wr996s9?=
 =?us-ascii?Q?12+foET0YjWjXb5oIWNsAOok13MtGui1XP/gbglSCRrvIXKb2xNx5d4uA0JY?=
 =?us-ascii?Q?qH0r8VjhaaOoYkhzjxAeMyoem0yQygRHy1GIh9yNqbNodNzxyH5GIZlQKBqP?=
 =?us-ascii?Q?lmGd/S5e2p9ypHUCUFhIUfOBFvS+kpfjbdwK/D3RqVJ54vQzF5eeKE43/XdA?=
 =?us-ascii?Q?VJpiKlh/Zua9gZmLXDY40hke+OC87BMDElnotJL7iEjtBouvLG5sdLxqb3lp?=
 =?us-ascii?Q?ZWIKfNI9dpBcZQkMhMrhTPeQksBUgqSPPhlnKk6VkVy5LwJ0uzAete8Idq0P?=
 =?us-ascii?Q?zDLwwTc92769eCwpxqmjCmvE19yXGqOMKf1d638cDA5Ug7REMMcQx/dVNXmz?=
 =?us-ascii?Q?3HcsNYh10XOwb1B6UrEX03CDQA63VydSnhhPiAnQhnChYJmq+xODxQwXlwoG?=
 =?us-ascii?Q?ycuIr18YstMlaYrq4dR+OkeBh1tjjYvz+w78g6b3KCsx/k8V7BjB4E9va9fD?=
 =?us-ascii?Q?K2rwAxWeFBs57eKTUw8uGnC6RCSbWtagpAjRhPRIPZX6jDMQ9AfFpGhX568/?=
 =?us-ascii?Q?4e+IJAILFFARDvEgbT5quVlzoh4oboghGzgGmMYqnAJCBY4x3xRjxtxymuGe?=
 =?us-ascii?Q?4qFQygpDO2VQs9YXSRmBMcROwL5MtXalfIlZexhfMySM8OA5yuSBV/03NGVp?=
 =?us-ascii?Q?CmYYZzwtpGWas12RcEd6R+3RkrXCFVp0D8UWk8M/COFTPZ02Y+7TCzKVhGae?=
 =?us-ascii?Q?qaW3waOPYG1tJEAXZ/AOHZrBr+pufH7104yi4Dx56ArXVa9/bRMqnWwFJOiI?=
 =?us-ascii?Q?+QqzND9+oQTE64cBVMdRi0ThOERFrXg47pQOFHTWRIb9p5Zup3CqNYGQbW/q?=
 =?us-ascii?Q?ib9n6rkhSf54Qcm9VUptpEsC6GOjVKMF10snH6qGKAYNxwJP8aKGFcrWtKU0?=
 =?us-ascii?Q?h6v8wZrLhBWwin/Q1UKBkEEF713SeOIyIQemeCIZxaWIjGmGtuFZ4AtesHnL?=
 =?us-ascii?Q?kghm08BEU4Ywu/z7k68wOuwNzV0+SEzBOr4Qpju5i1vaHrpqeTiuk6vcJnIX?=
 =?us-ascii?Q?CMatfAZiIo8R5Ea9e6M=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8aaf65fd-32ac-4cc4-b39d-08dc7b2d0135
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2024 13:34:00.5079
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Uxfi2rCD6EB1ALgEJGi9q20rhaxz/9/Q9dx0fNdpXbeVLGqaF1TrQqo2JOI64cuu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6266

On Thu, May 23, 2024 at 05:44:40AM +0000, Tian, Kevin wrote:
> > On Sun, May 12, 2024 at 11:46:54AM -0300, Jason Gunthorpe wrote:
> > > On Fri, Apr 12, 2024 at 08:47:04PM -0700, Nicolin Chen wrote:
> > > > Add a pair of ops to set and unet device's virtual ID that belongs to
> > > > a viommu object. They will be used, in the following patch, by iommufd
> > > > to support some HW-acceleration feature from the host level.
> > > >
> > > > For instance, every device behind an ARM SMMU has a Stream ID. The ID
> > > > is used by ATC invalidation commands so SMMU HW can direct
> > invalidation
> > > > requests to the corresponding PCI device where the ID belongs to. In a
> > > > virtualization use case, a passthroughed device in the VM will have a
> > > > virtuail Stream ID, used by the ATC invalidation commands in the guest
> > > > system. NVIDIA's CMDQV extension for SMMUv3 provides a v-interface
> > to
> > > > execute the guest-level ATC invalidation commands directly, yet needs
> > > > the HW to be aware of its virtual Stream ID so it can replace with its
> > > > physical Stream ID.
> > >
> > > I imagine using this as well for the ATC invalidation commands. It
> > > would be very easy and simplifying if the command fixup just extracted
> > > the vSID from the ATC invalidation and used an xarray to turn it into
> > > a pSID and then pushed the resulting command.
> > 
> > You mean the nested SMMU series right? Actually the set_dev_id
> > ioctl was a part of that until we wanted to try DEV_INVALIDATE.
> > 
> > So again, yes, it makes sense to me that we move viommu and the
> > set_dev_id to the nested series, and then drop DEV_INVALIDATE.
> > 
> 
> I'm right about to ask how the nesting series is going. Per earlier
> discussion iirc the nesting series will go in before VCMDQ?

It has been sitting on my github, since it is now the N+1 series to
merge I will post it in a few weeks. There are still some details
yet to be typed in unfortunately.

Jason
