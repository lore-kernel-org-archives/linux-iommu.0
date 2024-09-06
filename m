Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2048.outbound.protection.outlook.com [40.107.94.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C13E1B85CA
	for <iommu@lists.linux.dev>; Fri,  6 Sep 2024 18:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725648175; cv=fail; b=bUBnf2X+RPnSTcGN36PwOQMpp18csd8G1/EnqSU5VT/eSescfp+U5IyGuV9qYP/pSWglROvKC90tEZ7E1xhOI1TBB585ntRAiRT0DY2Dsvb0AYJx+5k4z939JG2NxEVMa0FGiMNkbyxaGcA/y1FRFrgx7EH2tazfdHhzX5mx9Zg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725648175; c=relaxed/simple;
	bh=T4nSwE6v6ex/PKipLABMd17ujq7AzFdsifM/Maq/qis=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FUHmOSVbE9xpHlAdSgOLXBjgr1E4aG38WfcXCpisqHNz8hZCj7FT/o1hhAcxkc/p0btTfLvRdFw2hvJR8dIVexir7jmqTgwkB1RHSED88vPZHq9QZ2WpAxOE6puCUCxuSAKJmfkgwZXiet7e/nnI95caxAQmSFd7ZADjs0Rp9Jg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gYDZMuWq; arc=fail smtp.client-ip=40.107.94.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gYDZMuWq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gyzqx+sLqNThBT8twpi5bx6fWr/L1CEbGOntXsLNQyRlFLg6jOTKBtIFi/+9/+Uzo8OkG5SdqZQUb86aYX6Hh8jgKZojCXL89zAkSWIBwIP9aAdfpa49Mmj/HnNvY4ZBNxIOZrsLf74n1/kx7Y2+Kz4rMJvgDLUcVTO1Jzqd12kyt1WkwHHbsIVd31NjfSDeLnt5z1vDnV6v+1eWObjBL+UfIdi+CYMphOLH63pKj1Qx/MgMYEA71xuDsb0wEuvjdHgzm/1r9atSebNc8UbRLkZDlD8XwzgvRl4I+zVoyFh3GvZZQs5B2lVcJNI49n5guzqrKFv16s6/jtwqeTwIsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ypQiqX9yE38W5Q02dOHByw+RZ4lqILTlJMYoiFoiz9Y=;
 b=AbR0u/SBeiqN97d2R1j8LuOhUZkNUaqx8SzkPggwBHa6BPoc77j2qnwAFeG9JoiR0kKXbdhNgJsrwkpSPOn6+vM7LzCWTLVIXDRRHj3rhC5l6shFRM54MVj+oNMJ2KJ/yzsZAY+hvhBGtV35FcjlxVljA9Je78GCq8xg0WoEbmjbjRE2HMyfCk+EfCkJ162QMnwmzyC0eRXC3LhIIrH15VDIfABHlc7xz6GvRHNlRKkLwl2h0ysm1PX0mtIrCwcuh8JYlL9b5LqKOsc7W6A5Ao3zcUMnuqtYkBwl9/G6MrQMoVDI3RDpqo57mriZxzwoOiyQoPUcQdRtEdeixiuaRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ypQiqX9yE38W5Q02dOHByw+RZ4lqILTlJMYoiFoiz9Y=;
 b=gYDZMuWqlWBXkkpa7Ot0AtQO+nkirAdDaBVI3shb7x+dHtngSP0yTSpPWM9WTp8RERU3Z0GSDPtfAzsg8eDg9Sh4cVeCcZQGTcqQ5BCEtwLdtcjFnYWl47NODOYvYq5HZ4FYMJdPkcyy0EAVexvkLpH0FRKZfgbDItfLCniIKgAyo2BdEJTHh+EhIm7g0ZF/Qi3NGAAQczEIOBnE5KniEVwDWM157ZvrUoa0i0OjmpvOgdZ2y727nIia8MXOBq1WBREt6xacLxyOv1tuqbX0T0H+Lrcw1P1CaisXsdxOO9CON6FThCinCZIB0qVG9UbXS6QIhg41Xe62J7Tp6HMKZQ==
Received: from MW4PR04CA0234.namprd04.prod.outlook.com (2603:10b6:303:87::29)
 by BL1PR12MB5922.namprd12.prod.outlook.com (2603:10b6:208:399::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Fri, 6 Sep
 2024 18:42:48 +0000
Received: from CO1PEPF000044F8.namprd21.prod.outlook.com
 (2603:10b6:303:87:cafe::3) by MW4PR04CA0234.outlook.office365.com
 (2603:10b6:303:87::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27 via Frontend
 Transport; Fri, 6 Sep 2024 18:42:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000044F8.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7962.2 via Frontend Transport; Fri, 6 Sep 2024 18:42:47 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 6 Sep 2024
 11:42:35 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 6 Sep 2024
 11:42:35 -0700
Received: from nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Fri, 6 Sep 2024 11:42:33 -0700
Date: Fri, 6 Sep 2024 11:42:31 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
CC: Pranjal Shrivastava <praan@google.com>, Joerg Roedel <joro@8bytes.org>,
	Mostafa Saleh <smostafa@google.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, Daniel Mentz <danielmentz@google.com>
Subject: Re: [PATCH v2 1/2] iommu/arm-smmu-v3: Print better events records
Message-ID: <ZttNF5qcc+jH/3yE@nvidia.com>
References: <20240827193026.3993039-2-praan@google.com>
 <ZtAW0hVPFD6JbLTL@Asurada-Nvidia>
 <ZtEKMknbGaD9q170@google.com>
 <ZtEkUQ7tI3Nb0NOc@Asurada-Nvidia>
 <ZtV1-IL8AZu--jGp@google.com>
 <ZtZEFKnKasX6433r@Asurada-Nvidia>
 <ZtnXADX3b6qdqVs0@google.com>
 <ZtphFYr1jUhHOSnC@nvidia.com>
 <20240906125524.GA16773@willie-the-truck>
 <392451a1-784c-4c35-9924-1a1f4cba9120@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <392451a1-784c-4c35-9924-1a1f4cba9120@arm.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F8:EE_|BL1PR12MB5922:EE_
X-MS-Office365-Filtering-Correlation-Id: 51584016-d6b0-4b89-05b8-08dccea3b431
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sq6DGEuNv7HdDZDZS1g/3UZDTFg9tOI7Csxrzwo6kEMo5SYCIuurOTLbjgs9?=
 =?us-ascii?Q?1figzjzDicCDEzGCGjGASfnUWw3icwjLRJv6tSJiCQ7HwVrUpS1eDTSLqEOD?=
 =?us-ascii?Q?v5enjn6ObHRGb9hZVNH6mGTWTvplje4lzkRsa/QdNGXXpZQlz26Szu52vB6q?=
 =?us-ascii?Q?SQMzfrNPNWABRb94p7UD1Xbr+4V5XzKf8eF/99fMUkJUgl8IoOiMi8HhKktv?=
 =?us-ascii?Q?h1UNlrZpIzpkZ9xuwIy4PdJYZLcvV8HTIU95U9prfUap57arKIffAG8IWL2w?=
 =?us-ascii?Q?fkExEJ6372r+xryoti5Jivz906bb7u5ylne4nVV4Fe6GtsrdK2RlXCkSs0Vp?=
 =?us-ascii?Q?Fjsvd/WvNv3NSLb//w97X/DVTiTUuWClA0iKNfKjMFP4x7V9hAQY1RE76QZX?=
 =?us-ascii?Q?Fe/S2ModU+oH4cKkznwgiyJs56UDHeVfCdoxbDpcvgdqrVGf7EArgG+am9Rv?=
 =?us-ascii?Q?Vmu15g364GKI9myymLj8cqrMa1eSBqv3Pshr37mA9z4N5PGvfF1urUgcZp0P?=
 =?us-ascii?Q?XuLiDhE8oJXNxcIitTIwTam4Jz6sT0M91hLjHFfQQfq9Kj992XoDb6vyoh/i?=
 =?us-ascii?Q?Jo/ZKEPkW/vxffH7r5hCNhrYPdtuNWCayhUhQCbIwJqQzkuIAz4ksJsxSTt8?=
 =?us-ascii?Q?lJgm5Yn2A3nsHLYzk84C9NQse8/R9jKHgyLa63z4HVqk/HSmD0fgtPn/xRdJ?=
 =?us-ascii?Q?IErPb9nPaaxQQrsJSQn8qirvBnTx8zycsaqcwoRA9j9EnPBXb254WEYKzzcM?=
 =?us-ascii?Q?Hq08ninDHxKoVIiT6gbzCbzfDqMwSHghmeAoBQOs1fqB4mDuBFzy5YYOMmyB?=
 =?us-ascii?Q?Gj7NwBlRY1+uOI1Ylj4cC5/SMB6thbQV6VqBZd8HKGRcSIaaJJ9naCXS7lnf?=
 =?us-ascii?Q?kSpYRdrkecIB/qGKykcb72jbrtvLlpfGJwKoeRVdhzamah03HSu9lZM34mbH?=
 =?us-ascii?Q?sC3k0fxLCMffkxh5dRBcbuBc83e3sI4fNnjZo2CgcBYANZB46kUZTikUoiVs?=
 =?us-ascii?Q?DvpF3Iz07XN6GEMrkSAvN4TJb57YB5uVnMwiwjvgRfCiUrhfa7wScjsikjcm?=
 =?us-ascii?Q?HL8pbqRu9DcNrrmgpp3P8/4t+fpwr3+JKuItqvAWBu5hW1IS9P6NaAEH5UHf?=
 =?us-ascii?Q?VX17C0MlTWbp7JPac9e+CSSSGr491H8j1MnFZWRjRfQHrDMd033pvXFirOUI?=
 =?us-ascii?Q?1dBMjjN81qThn3k+5f+kF192PxPAJG7tpMiYtprdwQOvM7cF3G7O57j56LUJ?=
 =?us-ascii?Q?G4zwBeDmSVzP0/fFt0HemuXFzSiKw3K2nw7oI+4XevlYOkR44JUvDx8Y5Lvl?=
 =?us-ascii?Q?RQ0S7ZL9ieNvwlhpayiE2zXQpiGQyk9HdBJoC/KXggQ6r7+hzT2oIbTXP1qy?=
 =?us-ascii?Q?y2TDvV+KoCQev+jzMy26NZmWsAErOqW00T34vW2EhYQjVSAsdCG6FGpv3wht?=
 =?us-ascii?Q?Ii1YDpiYFpR0FMw0nsgDbu0kMdH7NhU4?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2024 18:42:47.6931
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 51584016-d6b0-4b89-05b8-08dccea3b431
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F8.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5922

On Fri, Sep 06, 2024 at 05:39:03PM +0100, Robin Murphy wrote:
> On 06/09/2024 1:55 pm, Will Deacon wrote:
> > > > > > +struct arm_smmu_event {
> > > > > > +       union {
> > > > > > +       u64 raw_evt[4];
> > > > > > +       struct {
> > > > > > +               /* "Good stuff" fields */
> > > > > > +       };
> > > > > > +};
> > > > > > 
> > > > > > and then based on the fault type we can use the "good stuff" or raw_evt?
> > > > > > So, basically just add a union between raw_evt and the other fields to
> > > > > > improve struct arm_smmu_event present in v2?
> > > > > 
> > > > > Yea, I attached a test code at the EOM for your reference. Please
> > > > > feel free to drop fields if they aren't common enough, and confirm
> > > > > those bits are correctly written too.
> > > > > 
> > > > 
> > > > Hmm, so you're suggesting to make the event a union instead of a struct
> > > > thus, making reading event fields easy.
> > > > 
> > > > The only thing I'm slightly worried about is if the bitfields don't
> > > > remain constant if more events are added in the future.
> > > > 
> > > > For example, the "IPA" field is in dword[3] for now, but if it changes
> > > > in the future, it may get difficult to scale the union for future events
> > > > If we can guarantee that it doesn't happen then I think union is better.
> > > 
> > > I believe HW has its own reason to put those fields constantly
> > > following the same pattern, and must have its tendency to keep
> > > in that way.
> > > 
> > > The "union { u64 raw; struct {} }" way isn't that uncommon in
> > > the kernel, here are a few existing examples:
> > >      drivers/crypto/marvell/octeontx2/otx2_cpt_hw_types.h
> > >      drivers/crypto/cavium/nitrox/nitrox_req.h
> > >      include/asm-generic/hyperv-tlfs.h
> > > 
> > > Taking a step back, if one field in a new event in the future
> > > happens to be odd, we could still fetch field in its own way:
> > > event->evt[4] is still available to extract via FIELD_GET; or
> > > just define another union exclusively for that event, neither
> > > of which sounds like the end of world.
> > > 
> > > Having said that, I'd defer to Will. So, here is just my two
> > > cents.
> > 
> > My only real concern is the fragility of using bitfields. I don't _think_
> > the compiler is obliged to lay them out in the obvious way and I can't
> > think of anything worse than being given a bad pretty-print when debugging
> > a real driver issue!

Well, if compiler is going to be an issue, I can't disagree with
your point.

Any reference to some existing issue with compiler failing to lay
out properly? I wonder how other headers could define their unions
using bitfields and stay safe..

> Shall I mention big-endian? :D

Ah, right. queue_read() converts le64 to native CPU format..

> FWIW I'm not a fan of the bitfield trickery either. However, unions

I am trying to learn here: apart from what Will mentioned above,
is there any other reason to stay away from bitfield?

Thanks!
Nicolin

> aside, I do still think it would be a good idea for the raw event data
> storage to be in struct arm_smmu_event itself - having one local
> variable carry a pointer to another local variable in the same scope
> seems a bit silly.
> 
> Thanks,
> Robin.
