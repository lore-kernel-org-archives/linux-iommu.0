Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2064.outbound.protection.outlook.com [40.107.243.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44099749D
	for <iommu@lists.linux.dev>; Tue, 24 Oct 2023 23:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jzj8e2kn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fOFlTSVMDi1eOT17pNt2SeJ+HZla8PfCtS3h9I0PID7QGcwTH66Yma4gyRaZUPiBPhjUtQC3Yfst4EAJ8nNWvtxuCMwZd5IhlYqkdRvWBY92D1U1NeYj3HXMV7zTpVdqVZe7sAwS44VWlj/OeLgpcQGemc4TyWd4JhZVi3k5LPjdNuq7A/C9TMrzptlkiNCsV/X6jckPA+sVrQ3HV4IaDv3r6FN78j2dQxe/bF6IQTsLfCml2cW0E2sbNtqtmSeU6elo+dW3VjiEXo4hyVToChA1i+m9NwIXiWmWwYWkcZkJ1KiiB3ho9f5vIgGWEwFnET3gnLKqkj51+82BIUNK3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yAY0w1XCmCauVvy//DLQqbH0GYPelGJ9Y9GtcDMo0ro=;
 b=JcrxZFpDbSoUZhYKwtA3opEzqBxOb0gByeXnApo+T4/5F6gmbLvJ+LNdar5M6yhRTmWmWb4PVVqX6F3HjDBIe6wiZtuigi5/CHwJtR0J/WQmoe1h5VpwvSPCCprD+yNgLlF7m/lDKkIS5CAsrZB4Mhhuq/fk4xSsidM7UlmfYF6btsEhWJly22h3nZdCDNLvD1qufxIzi6U9O1TzarYOmtxRBP39wEa13JT4XeM+H+QjalE+IjAQpBy/pmEO9UDvgqC/5o3L3v60gP33KJNhzalnM8Lo5ZPwgVXSJfMVX1cs3/tn9fG5RC2nA2z8Pmcf5ftosllbFybpRhXzG57/MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yAY0w1XCmCauVvy//DLQqbH0GYPelGJ9Y9GtcDMo0ro=;
 b=jzj8e2knVRlFbRJ7pqeK2JJN9GJPDwk74im4M72CPxwz4uwwQHzFQowEGKcK2Qo1TDT5D0mds9PSy5TgaLEVTggMkev2+Ro6+STNIYPMJgzOWK7/boSHIfMFO96Yaz8vTK6ejCtihmkJS1uOAw0IVEscp4vwXAB92gP1P+QsrtHDNVAIR1059ZD6sIOndzK5jegFF8bArfmpzJaJGI7V9T7ARfYAzvZthBT4UzV+18KH1tm5Pt+j065Ev4B+KmXQ76SoCjUli7+4sGaaUH5TMidMlRaUoqZO9CwOYd2ROuIwtyzKxso7R/OfPOGDaywFG2QNsGM/y64q9Zfwt5u44w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SJ2PR12MB8181.namprd12.prod.outlook.com (2603:10b6:a03:4f6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Tue, 24 Oct
 2023 23:56:51 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2%6]) with mapi id 15.20.6886.034; Tue, 24 Oct 2023
 23:56:51 +0000
Date: Tue, 24 Oct 2023 20:56:49 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Michael Shavit <mshavit@google.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [PATCH 14/27] iommu/arm-smmu-v3: Make changing domains be
 hitless for ATS
Message-ID: <20231024235649.GE911568@nvidia.com>
References: <0-v1-afbb86647bbd+5-smmuv3_newapi_p2_jgg@nvidia.com>
 <14-v1-afbb86647bbd+5-smmuv3_newapi_p2_jgg@nvidia.com>
 <CAKHBV248yjmRUi+MyJXuDY8V1OKa0WF-eP7GYfthpGE5CFsMCQ@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKHBV248yjmRUi+MyJXuDY8V1OKa0WF-eP7GYfthpGE5CFsMCQ@mail.gmail.com>
X-ClientProxiedBy: DM6PR08CA0033.namprd08.prod.outlook.com
 (2603:10b6:5:80::46) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SJ2PR12MB8181:EE_
X-MS-Office365-Filtering-Correlation-Id: c90b274c-e3be-41fc-9fc1-08dbd4ece469
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xELuD4IAnCCCce8Aqd1iOWRs87HuvJff5yq+eEkpCNT0Jg7yL2wtP8ztJjKEV8dPf68NFBJFz13VhgZy+T9fG+oluLOwd61Nponr4GenMGJsdrPcsHY9PVRWFGenyOOiNwMLIFHGlfhUgZ0LskFLQ0xKHH3tPzAyx9+85IBnjTpYZKPcO50whcaK6JAtGeVfT53D7EmmkwVDCvpTE0tXPKxdijBxJDcP+ZVr/lVa9pefN/S2bpXmzsp/fxZpWTgFKdjqNLqLdtjLqrDZYTs4lhSf/KAv6z1+SU9qbvvsfS2RJ0VT1cVlYurxYVGYBOLbvNk1wmLbXDMFa5E4dPApPkI75X3NF+hKYeugJnz1sSu28Qzpj9Q6WZ0DynM+gYKAcy7mcRBvJCKeBCHtsrEWDNVSDSQMh7L3szhXYP+0iLK9JJwyEKR7pETyTS5+LjIv9BgonF+N41kMTbQlRX3qKvY0rw4Xr9inausiGw0PgiG5jnuCovsITJehWoShXhZ7ODAYqD7EGeT3wBiI6Ta53djjs4KWS0qCrWwC7VskJJzIhrvE8eD0MpGhEyFeWiRTMvLevFro+5M/cblVdEd7rFMZ/Zex4aAM39i9SHNKNSQcUDStr43a8nxQ8GmpjOVQ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(376002)(366004)(346002)(136003)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(6916009)(2906002)(5660300002)(8676002)(36756003)(4326008)(8936002)(33656002)(316002)(54906003)(478600001)(107886003)(86362001)(6506007)(6512007)(41300700001)(2616005)(26005)(1076003)(66476007)(6486002)(38100700002)(66946007)(66556008)(83380400001)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vRaiK4V4ZprzGwnWXonkSB+CxlFYl7JSfG+2B6vXRZLEGCPY1b0Mb0CbVgGG?=
 =?us-ascii?Q?tFna8o9QpQpPi+LTbcOB0mqSNE5adkIFrvIgNJ1zp7GcxYuVwn403pRF219t?=
 =?us-ascii?Q?/lfeGSk/e+ZGnzEZB5iS03KGV4Xyup3JcaRgCvBLPCz1tkqacnBsNqBZLe+x?=
 =?us-ascii?Q?uruXZBmvVKL+QbW5rPpNBcA6rRtT23FjXcOyhuY+eDZljWbz8+B2cj80Uu+8?=
 =?us-ascii?Q?mDDevUXuRi4jhkglrwISyhp1ktQdvHAWZuw14ESuuj0aNq8wkntE96nuJJbw?=
 =?us-ascii?Q?cinznlc5MeBv8BHbwJWHYaNBxZlskLnq2wxHaxIgHE4MFlBISU5kOmTv0rAj?=
 =?us-ascii?Q?Hh/yKo08zGN83dOzLu+4W0C+o+YkKMkw8N0RSl/p9krvAIxefQCOFs02bJXL?=
 =?us-ascii?Q?Pm7RVsIUGtsXebKk1pwLVN1CEbNXUjV+ak8S7sGguQauzX6P+KY0YLhc8amn?=
 =?us-ascii?Q?YoGS8a19s8zpxAVkXzJRfDIhys3OkMXIj9gJcUvFzGQs4LdtUjvAVp7sqozW?=
 =?us-ascii?Q?I1R19laMyB4pHNfYYZeJOE6Vdp8iLgEBCSmYM4yr2pPUSA6KS5hb/y8QmY6O?=
 =?us-ascii?Q?7h6wYuOjwKGGu3YF0kZO5cXAtrpNJqsvpLbOp47MZ5vvijUclr6WvDPDiarL?=
 =?us-ascii?Q?HDMWsy8AgJC8ikS1lwo+aKBI3lLvFuS6qyKL/F1cc2pV1M/RdzdzFtWHTA70?=
 =?us-ascii?Q?8Mrfp3zypC25/eIsJmKAZFZI2WnZfdgGGQ50WiagMweEFAJPTmnIF3tCyXO0?=
 =?us-ascii?Q?I3t0rEs6zFOXWDzH8I9cA/VBN4QJQwV9WR/G+keIypXcX9qH5mXVNBcdeaBf?=
 =?us-ascii?Q?fLgcXawctGfTdtdKSYpAsJ/OYyn/UqtT5AufeBCSWONGdXxFkDY21/Ki8R+Y?=
 =?us-ascii?Q?53GMD1dUgIX3eSGzwkGzQvWQATWucBC4rWyrMVJNqQcS3fU7sGqnDJ4any2n?=
 =?us-ascii?Q?2bFsNdwgsQh58Su2R0vAYp+ur9K/m3d4KA5IeWIHOpCaKte7AbXg9eiD9gAH?=
 =?us-ascii?Q?zLrwFEyfnHTS4k9fErquBHkO3goaxr04PWTYuJtyCqSTpmA7TnhWGUkGbrVo?=
 =?us-ascii?Q?Iq01aTEixnjBjv44jvsNIp0/IMhI/u3djJBQN+WAVcM3Jp1rEaTQJmI3Z+uI?=
 =?us-ascii?Q?dMsbVFqQgMtFb3pVRhQgAWKQnpW6J0HkgCpe7n57kXsdkX1LI3xZc0lxZriL?=
 =?us-ascii?Q?A3jIrezgcXi3ENer2IkHTisQKSrzR9KKjBTQmi/bcCmLW8G9haL0sA3DOWBa?=
 =?us-ascii?Q?00w8QaBsmypMLnYvPIVU/k4rm9pUsL+9Ryhldv7JPjEBEV+dCc7rj8fwLKRO?=
 =?us-ascii?Q?YNtGEvvisbw0BQa87CJL2XoTJnhxvVC6i/Ie3GQA7ttB/u1krHZTxjChvKsV?=
 =?us-ascii?Q?mjojcYV1iHs8BpCqWHSHaBi3aHWkYkZV410wfxSccwL7OQRBEKPbfvqqNN6c?=
 =?us-ascii?Q?q1+13VVPz82+lP5PbElXs7dK6Ct+QVR0kaB4wI9LKmmDj0Ed0wgXxVwQp/AS?=
 =?us-ascii?Q?PxLxPBlmlA8JXxGUAYAqgV/LlGoONbVavq/Tx8W6uR7V0HzQAlGJEYVnExeO?=
 =?us-ascii?Q?K0fLqbw0ajwIXo7UT2A3rXTicFvfPt7zDrQyMM/L?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c90b274c-e3be-41fc-9fc1-08dbd4ece469
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2023 23:56:51.3922
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uX8kztfUq2IglFEV62kpUh/rFNeZ4AgAP0cAvFjiUU+2QLAnL7FP5CQ0KWFuDk88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8181

On Tue, Oct 24, 2023 at 04:09:06PM +0800, Michael Shavit wrote:

> > +       /*
> > +        * During prepare we want the current smmu_domain and new smmu_domain to
> > +        * be in the devices list before we change any HW. This ensures that
> > +        * both domains will send ATS invalidations to the master until we are
> > +        * done.
> > +        *
> > +        * It is tempting to make this list only track masters that are using
> > +        * ATS, but arm_smmu_share_asid() also uses this to change the ASID of a
> > +        * domain, unrelated to ATS.
> > +        */
> > +       spin_lock_irqsave(&smmu_domain->devices_lock, flags);
> > +       cur_master_domain = arm_smmu_find_master_domain(smmu_domain, master);
> > +       if (cur_master_domain) {
> > +               kfree(master_domain);
> > +               state->existing_master_domain = true;
> 
> I'm confused, why would we expect to find that the domain is already
> attached to the master??? 

Yes, it can happen, I agree it is
surprising. __iommu_group_set_domain_internal()'s error handling is
designed to support the wonky drivers (like smmu before this series)
which would destroy the domain attachment and then fail
attach_dev().

To accommodate this the error unwind for
__iommu_group_set_domain_internal() deliberately resets the correct
domain again, expecting good drivers to make it into a NOP and wonky
drivers to restore the attachment they threw away.

> If the iommu core really allows such attach() calls, can we check
> for that earlier and simply return early from attach_dev()?

We could, but that looked more complex.. We trade an extra if
under arm_smmu_attach_commit() for an extra if in two callers.

What do you think?

Jason
