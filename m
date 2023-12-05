Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2055.outbound.protection.outlook.com [40.107.95.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D337E692BC
	for <iommu@lists.linux.dev>; Tue,  5 Dec 2023 19:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VwTLPo4D"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jKFGxWCjH/23j7O+LVR65X7EufV2MT+XMrY592L3IVZ7kq7yfA5RHHcXBBFlTsCvIVt5ScbIB9kMaS5I0DM/zjVXZvPV+kptcgd1m0WvcDaKg0te2LW9zKwTbA24vYqN2C1T/nD71XUFfO028cBaCvrr+umz2epDn6Mhzixt6/Gy85yte+Xw4Fce9/lpwBRK6CzRoWfETXJdzbDDpiXykzExpM+UTHboeyijudJlY7c50g1ItZ+IhlkbqzFEltluIw6wUKLQCXMk6/MpUioXRvn5PysSjc5eTNuqDIfP0+RuRnZjF8yZFR8s70kmvrGqrgY2d3vG6I4+rl95QzKxVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q0DCjG9vRzYuBeUi9SZAPF8v06RuExDD3x2kXA5wc3g=;
 b=QfOol13PLbxhnhPM6Hb9PaUS4YikqszoTpJdvGGtuY8k2xirrFggrjYleYmRu7oEEB1MpDYWug/GuolNW0OjUuOm+lDN4P1BLQbsKZpvoQj0zJlUkLmxdkQ0UXCE6FsbIcT5p5cokIr8zALOCtyRF6LZiqA4hbtYPgDeeqX/HdMWWy1s0S0lUwa8VrBF0aoW+2CbSnH4imGZbT3J5QnLfUk76r1kPd0NDAvBeJSE4je4UtOGnsanfVM0sJSaKyAMU7CD7DELUGOdDkTXwCdLYPjPM7u5HFYHQZ+BwJJ5e7NnG1KmiYm4oKRO6vs7nA8zq8JE+hyb5K8hnPJaxZi1/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q0DCjG9vRzYuBeUi9SZAPF8v06RuExDD3x2kXA5wc3g=;
 b=VwTLPo4DvLcsVhZym/+qaVBRGKsZEWzPJjthfCm4oea6+Z9936b100ShJCPkxhOV+cxfBvNEgeGEft7DsZkWRzKK0WwAXAW+aTyFKl5SD6FIDJkmGfd76UNGexRXoxrH9Yh2RvZPjjDSCGSi1O9qPePmfHssoXfnBQ3/3ugifWR95CqD4+c9jSi3roVV0EXh1skK7ADmHxigLAXiwomsbsPYoOE79wkUg1eV8bLFwPRP3f999rjau+iB75XDscTloooTFmDeSlk92fDOL00tDD1BL6ppjpC43LwLBk8LrnO6G0idg6Lw0V0H8dO9m61tS0psEZssW004X/prVHCiNA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CO6PR12MB5442.namprd12.prod.outlook.com (2603:10b6:5:35b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Tue, 5 Dec
 2023 19:03:23 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7046.034; Tue, 5 Dec 2023
 19:03:22 +0000
Date: Tue, 5 Dec 2023 15:03:21 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
	Michael Shavit <mshavit@google.com>,
	Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH v2 15/19] iommu/arm-smmu-v3: Add a global static IDENTITY
 domain
Message-ID: <20231205190321.GK2692119@nvidia.com>
References: <0-v2-de8b10590bf5+400-smmuv3_newapi_p1_jgg@nvidia.com>
 <15-v2-de8b10590bf5+400-smmuv3_newapi_p1_jgg@nvidia.com>
 <ZW6m54yS2rpk65kE@Asurada-Nvidia>
 <20231205143742.GB2787277@nvidia.com>
 <ZW9dJ1yzsdCjpMGm@Asurada-Nvidia>
 <20231205174219.GI2692119@nvidia.com>
 <ZW9qHsORHC5obMLS@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZW9qHsORHC5obMLS@Asurada-Nvidia>
X-ClientProxiedBy: BLAPR03CA0108.namprd03.prod.outlook.com
 (2603:10b6:208:32a::23) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CO6PR12MB5442:EE_
X-MS-Office365-Filtering-Correlation-Id: 247c63fc-8ad1-402b-8507-08dbf5c4da4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	JCxsQDR2P8Jm4Q/e60oT0IsGbGRGMuYouZusLhj1HmjCNsi1aMxgtAsIpF5/xgtJxi5v8fDdatpR1JECwyqMbRcnNF8HIv0v3hC18pipxQgGt4xsxJ/J+ImKxzNN/IPQ808kGjAr6vK7XPT1WKbHrW02SgLFBLGtajCSkvjG6krtvne7R4pBUmm6cLLf8hrjvEr07bhkzFEDOtOaQMSwJTg5S3lIOjWPXtWhsU57BaB2RPNzbGFGGIjxyJbbATlrFJx15T6UhogHtVii9oHe9djE8Gfoyvk2o7xErBd1Nm81ANgD9XKcY+LRifysC15LPLrcPxBebTsmtuA5rXUGTZO4hI8gQhmt9UhHmaXnawpq29tCVEHU8HFJ2Pp0LkID8RBSJrYN0c3DsOUdTqjsgwZ9W3cQWi5418g5R2L5I++R1+wzbbs0s0AzD/3tSFFlEkjGptrZMd2NXjn1Qk1akCJd5XBRGdhM0Dx5jE4DZrX8+TgCaghJBOqDZGA1vaJ5ky9y/6ULElFyhmqH/ADAvZn2r47GijRvbhbNiJZjnS03Xhj0tbzLNI8A+yCbp7Q8
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(136003)(376002)(396003)(366004)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(2906002)(33656002)(316002)(37006003)(66476007)(54906003)(66556008)(6636002)(8676002)(86362001)(66946007)(36756003)(41300700001)(8936002)(4326008)(6862004)(5660300002)(38100700002)(6486002)(83380400001)(478600001)(26005)(1076003)(2616005)(6512007)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?grNPIWYgnpusu96o/MXpNa+TZurcRGJF5CLj+ey2kRbYgARWFNzhUnOEZNce?=
 =?us-ascii?Q?T1M8AwmexEmr0Ih2e0SwF+1pVHnjIyUTqDveStUUoBhpDh4L4NbQCnYM+D9X?=
 =?us-ascii?Q?6arpJMGujV3pPJWjbnBcft9bFKnMuqxmAxbohGvvhxAaVR9+RhiaK3xOwT5F?=
 =?us-ascii?Q?Vgv22njcZGd32FXUcwXnkk13TiQA3jPxKOItLKQj8kNiTh8SreGg7dwma7Hl?=
 =?us-ascii?Q?YAThz2YdHOCxqCJkb4/qAvjxvtNDLcEZ/3n/1H9hJ435Co19+Z3akZoXG6h0?=
 =?us-ascii?Q?asVCODn1N5Dus3vosWSZGrE3LZWge6pGK8rzEXHWdnJAVTQLp/VxnzpJr6n2?=
 =?us-ascii?Q?3r4MtF8LaocFHvAK8bkL9sVXj7eruq900I7AYqn+ODAexgmWhpEt2Hp7577Z?=
 =?us-ascii?Q?BLkh2bvXk/J0P5FJGTnwuummoqIV/zdDQgIA43X2fUEREgDhG1QDyNSpiGtX?=
 =?us-ascii?Q?A6XRqIo6kgqoThscnL5OuCTIRCaTCpYUswnTP/OJ7Ymkc/8uA58u9o7U89Vo?=
 =?us-ascii?Q?ULoTS7B/g+vFqYDPlvW3KR/xbkyR6QFeU5cugdtpDFi8KnhSEMIthxdPQer5?=
 =?us-ascii?Q?VMiALLBrHXK4w3wkxMX72/+SfMTJ+EO1oPIf/FA89LSH2+BTfgy4TjiNkVRB?=
 =?us-ascii?Q?lpvFTPCkBFeiD1R0ln28wZmSA959X299D1z0WuqDb4p3hKvfcJCFC4SZ0zrG?=
 =?us-ascii?Q?nOlIW4hwJGORW4JsKzUcPNJ7k9YhpWkqhpOuvsVz3y/sKRmkRwQUq3BfK8tz?=
 =?us-ascii?Q?FP4bwqQcjTtUdj4emPXERpZeH0GuBFsqFP6a/o0RLGi8oTjQUQdaad/bdUsF?=
 =?us-ascii?Q?Clgga1ZmYot8fEncNuop6y4+hqnBnL4dsxU3En0irFeY42vFwo51Wl7enYYl?=
 =?us-ascii?Q?HM+Dz6G3i4GWUswCQd8Fpc6Q3nZnJ9eLYELd97iXxZVkXjQh3GYoqZNpSqdp?=
 =?us-ascii?Q?K2CnaOvq1Es1jvExK7mI8fxEYKTAN8cr6jNWkMNl+99VEMSzMpryFS2rAnH7?=
 =?us-ascii?Q?Hn8z3C6i7wnrwWNGzhAPDSAFIiSVuFPYn7aoW8pbt452upSaeTowMmdT46Cr?=
 =?us-ascii?Q?o6IT0G3BwED7Omiy/IV4ZjRgZt1WKYdpImgW8b6HYrDSGy3SDGg3KTmaLWjd?=
 =?us-ascii?Q?ZG8XUat1gJ+MnFCxBH6faZ4oJffc7X7ae5PvvoA7kq8AkOi9tCyzlfi67XSt?=
 =?us-ascii?Q?Kd68kxxCQpoeJp7f+XczSuQUXos/7+K5VAtHU2/H5+8tCI7E7wZtuGugXrMA?=
 =?us-ascii?Q?nBofcALhWlzEaoEYuHG/9JGIr0Gjhy3fofL03t5KL0ZP2uiVQJ5H2O/aeZPb?=
 =?us-ascii?Q?8G65shiyzMAznfFcdWoE4+EktA+YqOcuzvCVE5soGMp1iIJo1rHyM3BXvups?=
 =?us-ascii?Q?xtJdlttr+RcBmiL7tjnAC+euUgs3ORJ0fNcZL655clgdQzrMTSdMcOf1IhtD?=
 =?us-ascii?Q?2VH7CdRPN9gufDBqwLD05hInnbtQfV/q2u4lYTEvAq2ueEsktK4MVIylzswQ?=
 =?us-ascii?Q?Xc2sPMt72CvgcVSOnHofzGq3mOLtWdZvXm0khvQ+m9X47N/rPsz5M009syjX?=
 =?us-ascii?Q?RtmJxJADntAuOW1U5zgnh9yMvn73n45kuFKiuUeX?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 247c63fc-8ad1-402b-8507-08dbf5c4da4d
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2023 19:03:22.9674
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tp0ZffxfQ+J0Zxt9fTgFjRdQ93LwoJdNr3Rr0gDIq0QB6dwm/OHQoDs80JL2tTp/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5442

On Tue, Dec 05, 2023 at 10:21:18AM -0800, Nicolin Chen wrote:
> On Tue, Dec 05, 2023 at 01:42:19PM -0400, Jason Gunthorpe wrote:
> > On Tue, Dec 05, 2023 at 09:25:59AM -0800, Nicolin Chen wrote:
> > > On Tue, Dec 05, 2023 at 10:37:42AM -0400, Jason Gunthorpe wrote:
> > > > On Mon, Dec 04, 2023 at 08:28:23PM -0800, Nicolin Chen wrote:
> > > > 
> > > > > > +static int arm_smmu_attach_dev_ste(struct device *dev,
> > > > > > +				   struct arm_smmu_ste *ste)
> > > > > > +{
> > > > > > +	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
> > > > > > +
> > > > > > +	if (arm_smmu_master_sva_enabled(master))
> > > > > > +		return -EBUSY;
> > > > > > +
> > > > > > +	/*
> > > > > > +	 * Do not allow any ASID to be changed while are working on the STE,
> > > > > > +	 * otherwise we could miss invalidations.
> > > > > > +	 */
> > > > > > +	mutex_lock(&arm_smmu_asid_lock);
> > > > > > +
> > > > > > +	/*
> > > > > > +	 * The SMMU does not support enabling ATS with bypass/abort. When the
> > > > > > +	 * STE is in bypass (STE.Config[2:0] == 0b100), ATS Translation Requests
> > > > > > +	 * and Translated transactions are denied as though ATS is disabled for
> > > > > > +	 * the stream (STE.EATS == 0b00), causing F_BAD_ATS_TREQ and
> > > > > > +	 * F_TRANSL_FORBIDDEN events (IHI0070Ea 5.2 Stream Table Entry).
> > > > > > +	 */
> > > > > > +	arm_smmu_detach_dev(master);
> > > > > > +
> > > > > > +	arm_smmu_install_ste_for_dev(master, ste);
> > > > > > +	mutex_unlock(&arm_smmu_asid_lock);
> > > > > > +
> > > > > > +	/*
> > > > > > +	 * This has to be done after removing the master from the
> > > > > > +	 * arm_smmu_domain->devices to avoid races updating the same context
> > > > > > +	 * descriptor from arm_smmu_share_asid().
> > > > > > +	 */
> > > > > > +	if (master->cd_table.cdtab)
> > > > > > +		arm_smmu_write_ctx_desc(master, IOMMU_NO_PASID, NULL);
> > > > >  
> > > > > This arm_smmu_write_ctx_desc was previously within the asid lock
> > > > > protection, yet now it's moved out of that?
> > > > 
> > > > Yes, arm_smmu_write_ctx_desc() updates a CD table entry and that does
> > > > not need ASID lock protection. The ASID lock exists because of the BTM
> > > > code rewriting STEs asyncronously.
> > > 
> > > I see. Thanks for elaborating. For this patch
> > 
> > Actually wait, that explanation is not right..
> > 
> > The BTM code is changing the ASID which is done with a CD update
> > 
> > The ordering is OK here because the BTM code iterates over the
> > &smmu_domain->devices list.
> > 
> > The arm_smmu_detach_dev() has removed the master from the devices list
> > under a lock so the BTM code won't see this.
> > 
> > Thus there is no race between the arm_smmu_share_asid() flow and this
> > code, indeed we've already removed the cdtable from the STE at this
> > point.
> 
> I see. Maybe worth mentioning this in the comments above or commit
> message?

It does have a comment:

 +	/*
 +	 * This has to be done after removing the master from the
 +	 * arm_smmu_domain->devices to avoid races updating the same context
 +	 * descriptor from arm_smmu_share_asid().
 +	 */
 
> Also, the arm_smmu_attach_dev_ste seems to be used by IDENTITY and
> BLOCK domains only. This turns its nature to be a cleanup function
> against a translate domain, while the naming sounds very generic.
> I cannot think of any better name than this one, yet maybe we can
> highlight this with a line of comments above the function?

I would not call it a cleanup, it installs a domain-less thing via a
raw STE

Jason
