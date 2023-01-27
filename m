Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2085.outbound.protection.outlook.com [40.107.92.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF45A290D
	for <iommu@lists.linux.dev>; Fri, 27 Jan 2023 12:58:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mEXRrLYQ2ZEywY6sBG4qIn88YbNTUrfH/LtpP/po38eGNIB1ST/81meoelmtgegm86JMTryiPohqKCitgCJ8mNgzFOGMJwoQUT1KfGOOqOYsD+YQJQJIwHq9wIIQyh8GWTAnNWVonVkVf4wt5c7DFTVfIr2DmDVaprveABMlExrCYi4+W1FRQM1j93PWJ35F/OHViz9/8KoufJjlSpgUW6QlzJ6CuCedISt6T4ntJVm5eqjGlJH9shtktrKC0796rbzbtrfCG4g/7IAKKyShXesgaRA0oNM7Hstig5tOOs6QZUd3iQDv1fk8yP4+e7EE+DCj1Pw6n26YQVMxhGvGnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pQDRuaFi/3ze5HG2gxhX1/RRHakUya9WmrQL85j25rc=;
 b=Bmv3kRINajrxk1D1m5s+z14iR7JUnnjFdwMh5IqJdNqSYfN63kkNCwCJZ4Ika2UJDarK3Kb1BRcK3UX5a+ahWsFQGin8qcTvH8MoNdCY0fEAZULdlqvVot1GPZd+QV7tzvoGmYzwNpcF/r/EXc1whxOHfol6EUqHNZkFCkZlmhiAvceTo3dmY2ga+Ha7TDOv8cNcOVoRlJOE/VI+IL/7nc8kyz2QrEGelyR+KP5wrvz9RQr+x49cpu7b0wryK6aKaqFpzBlvVHPskMZaxIc7nOvbZW1pNOqmC3IaFEsIEKhLioR0PxWf6gzuhCgiwUEbEjF+8UkABXdz7xPBNTtWjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pQDRuaFi/3ze5HG2gxhX1/RRHakUya9WmrQL85j25rc=;
 b=cxEM63f78/bJO91PfrZGWHuybFnEgeTXdsvXY5CJL61UC8ntKq1mkVr9WSqbMgBFzeXpkXZWArOpz+N2+Wwyi3SCaya5VTqqRlcie3kq0tSNcgrDhh6RAF9+KCTNeQ/2bOH/GLdPXpokSV7V/0Nfn7hcykW3tQYMqf2BPMMPe/qGiOtZ5PHLvMp89+2UNjCVm8EOAF8CVdsLfkBNdeavaAX3ijg2tb6r/JYr0RmEv0No33MatgpNkWX1aM7N3g+vXZfkEOU8+T9OP/PTkjcwyEJssmyL/IhHLrTxCEfTylUdEAMbMmrSBEKY3LHYDb00UWDk7ADUEXoHPE259QmZXQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH8PR12MB6676.namprd12.prod.outlook.com (2603:10b6:510:1c3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.23; Fri, 27 Jan
 2023 12:58:11 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6043.021; Fri, 27 Jan 2023
 12:58:11 +0000
Date: Fri, 27 Jan 2023 08:58:10 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	Daniel Marcovitch <dmarcovitch@nvidia.com>
Subject: Re: [PATCH 1/3] iommu/amd/iommu_v2: Fix pasid_state refcount dec hit
 0 warning on pasid unbind
Message-ID: <Y9PKYqdxYevgFbNq@nvidia.com>
References: <20230124104355.119166-1-vasant.hegde@amd.com>
 <20230124104355.119166-2-vasant.hegde@amd.com>
 <Y8/32rScnCHTacQT@nvidia.com>
 <6fa315a8-844f-19eb-1a23-41cf8b51313a@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6fa315a8-844f-19eb-1a23-41cf8b51313a@amd.com>
X-ClientProxiedBy: BLAPR03CA0064.namprd03.prod.outlook.com
 (2603:10b6:208:329::9) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH8PR12MB6676:EE_
X-MS-Office365-Filtering-Correlation-Id: 734957e5-4c1f-4706-bf42-08db006624f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	N2gTQX4lv1dQGOJvY5EWzYM6F8u3L01maVRZC+gR9yvKIvSaBHdwWNg8LH2r4HEqeOKU8sliky2Db47LJuQjbZssrhFsGndv4GKasnoEa10Tja0rtgwzBxUbLk1Y56ATnLEoUiv/44NQPYJCUQli2h/6xma0eeahvdaRliaC08EWthh7Kt/Pp9H3W3/WF4aWq6P1pjoCRJrcQZFXNBcGAuZrpeehpI8ENY4I+57xXvKtvNOR6pnIWDtKbxetVOAhbBMOqGJYjE84c7bh1J2ZmmX/ijFdCIiwrw4oaIzhVt9GDaKxuk3MS8qdKKI+BOfRfi1UhhcEvuBfoGY2qwkrIebmMYrrTldy5kd7rUyVBXWvtaWQRvY6G4HnBJljQYFYWrR82SweXUcrZsepXaNFT8TbnjJAe3sAthRXA+QYNVKYEUu9NzmFgzIF3D8YqQUoz872dpwx+Fi6v9jWKSAMe6+LpD/ZdkqxaT6NgMVDTXVRzGM9YV/6C8yFUXZvXc6l44eHhg+jROXXRa2p1cXt3txd+T5sKbXqtOfUguDZYfHpyr/MFzA7biZF5qL13/FZO+9tcSJEVG+3dHTnoFSePCaVlySknP2WbNHvcoH3nJ5eSNRq0cj12KkmxgU9ofgqNsKZD8yWiGKRVTHjsvQMAA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(366004)(396003)(376002)(346002)(136003)(451199018)(316002)(8936002)(6506007)(107886003)(86362001)(478600001)(53546011)(38100700002)(6486002)(186003)(2616005)(26005)(6512007)(36756003)(5660300002)(2906002)(83380400001)(8676002)(66946007)(66556008)(66476007)(4326008)(41300700001)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?i0mH7Hr1yhx987srmGb5uIs4ULx6I3fFC5ahMvDQpRvjUzwv3KIMDPaBYMdb?=
 =?us-ascii?Q?eK95QmcR8ynNlTiaU89kfPzXakgeRQcbRqullie3SelZSWwxtCAAsflLZh87?=
 =?us-ascii?Q?tbBHDGoc8hDWOQF+HQ2zV+vSiqoCz2vvCeNibg93A0VRemkboE8EHwaYauSs?=
 =?us-ascii?Q?nKxodrmNO6LD/R4XLRsHbHuFkPo4eQKJ3FEPNc/VjSJqNMuo0AIa+zbJBbfY?=
 =?us-ascii?Q?iZOYKCz0CDJW1R8UmTD43m7R5NrrprgQIV8uza9c4ERby0f8TaGza2UzREzv?=
 =?us-ascii?Q?1vDG1nIjDgNDsXmQCDjXqlFRx4sBa7cur4Ln+P5yK6UzMaVdIVBzAG1yuf5M?=
 =?us-ascii?Q?SmwU90N+H7zPIpYNIokGp+3VqYoxFbm3OAKBfpgfe2RkMHans9C59k+U8m17?=
 =?us-ascii?Q?pMh9pG4chUQr91oQI8KDPf9vK2R3WGgpd5n4Cs7Z7NJfcFjmJypGQ/t6Zbg1?=
 =?us-ascii?Q?0H9E1h2+jt974+R+MqyIheR28s+1Tc6nVIo9mhS9JdHwJ2KA+CicJCr/fkwf?=
 =?us-ascii?Q?hGVPzpRKdBtudrldYggNRrpmyfsvThUYYkkL49jTLyJsT1ZrXNaLcSreYcsq?=
 =?us-ascii?Q?QR5ijuH1YK6joLYWo7nWg7Ccigg9hZRfLglHrxKZOXRzdrT/+ile6VOkSbTR?=
 =?us-ascii?Q?/hW37nV27NO0pw0MBhl5Gov6uc2uYRnrNYFZKw/r0xX0KVUqxGa9FvmIszJC?=
 =?us-ascii?Q?hj7whSYeK53GKzii/HAPsinzFFW5lj8V7aFlnp/LQY6VaP2eoMQuY0tlYczG?=
 =?us-ascii?Q?CosU9XP5FKlmqjfwEoEyNJaXeETvl2+J0UlRXHfAfeTtunJ+9F5rJoREBYOM?=
 =?us-ascii?Q?i5my66qfsQjLvgDURUHX4sxdNAjMC1Xyg2gNAiL0xhUWhbb3YURPkGl64wwT?=
 =?us-ascii?Q?hnnvQ1kIIL+JmizUK+L7F84TsOHhfbD4QxAf5B+FrC+K4HtUskcoi+llvdB2?=
 =?us-ascii?Q?6Plbv5LJ+HHirX32d98daOGxoTEdohc++Yd/WuPSAJ+SKMB9LXZFOxU+IDtU?=
 =?us-ascii?Q?OPtj1eaeouhRAcElxnvdGnD8+LUekFJXjToN5zlDma94YAkzsthO8M2Mjdjl?=
 =?us-ascii?Q?oPBVFUSTltaCGX5EsSYknf7Jzt0eiZNeEtQ1vcaLlwqEqSx+Nz4VQXGE0HkR?=
 =?us-ascii?Q?rcX9TKPwWBKG5sEtDnqZokFLA4rFs2Wuqpmqww5heuEI6hntAED9UySdhydS?=
 =?us-ascii?Q?D9rVjmMT8mBl6soyfL4EimN6OklKHcI4VlmQoVyV/5JQaVx2Ds1xL8NNH3Yy?=
 =?us-ascii?Q?zPgX4TBO8weKWriU79m93MpngOjNB2WhlHquRmg36g8JurYF9YlLWDgdLj67?=
 =?us-ascii?Q?y3MgKdeRwXnQ4hD74iarW/tSwy4Q/U6ZmPCwmPEIeiSKRZOpCJqD2FFnUR51?=
 =?us-ascii?Q?faszr9BR074QkvM3qr/Ta5jIkz1MzCgtcNbNI1sRy7PfdUkR9tA0hZFOZpsT?=
 =?us-ascii?Q?WcXbx5durYLmGWF7zdC5EClXWi3a9Hn9c6dhh1qETASUOL7RTlRp4fquhv+l?=
 =?us-ascii?Q?gzBUCmeBDmlWA5lBMv25+HaXjT5dV2WfCuxJdNDCZyiiVkjzU4vQO7vcSQUp?=
 =?us-ascii?Q?t3ErXzdthCpaeTw+OAdsnQDs1nkFDJjFEVVbo+15?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 734957e5-4c1f-4706-bf42-08db006624f2
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2023 12:58:11.1015
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dnvgm62CDpJ/Xxp9lrjs9g4MSnuJ0wvF5/KNIo3QhwkuZaSKjXCpfcv9zxKlOxjv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6676

On Fri, Jan 27, 2023 at 10:14:15AM +0530, Vasant Hegde wrote:
> Hi Jason,
> 
> 
> On 1/24/2023 8:53 PM, Jason Gunthorpe wrote:
> > On Tue, Jan 24, 2023 at 10:43:53AM +0000, Vasant Hegde wrote:
> >> From: Daniel Marcovitch <dmarcovitch@nvidia.com>
> >>
> >> When unbinding pasid - a race condition exists vs outstanding page faults.
> >>
> >> To prevent this, the pasid_state object contains a refcount.
> >>     * set to 1 on pasid bind
> >>     * incremented on each ppr notification start
> >>     * decremented on each ppr notification done
> >>     * decremented on pasid unbind
> > 
> > I've no objection to this quick fix
> > 
> > But the issue here is using a refcount for something that is not a
> > refcount. This usage model is should just be a normal atomic if it is
> > only counting the number of notifications in progress.
> 
> Originally it was using atomic counter.. which got converted to refcount by
> below commit:
> 
> commit 8bc54824da4e8fcf0ed679cf09ac32f23d83254a
> Author: Xiyu Yang via iommu <iommu@lists.linux-foundation.org>
> Date:   Mon Jul 19 16:32:58 2021 +0800
> 
>     iommu/amd: Convert from atomic_t to refcount_t on pasid_state->count
> 
> .. after this commit it started throwing warnings. We thought of fixing the
> warning instead of reverting above commit.

The mechanical clean up was wrong because it subtly wasn't a refcount
:)

But given the other problems here you can fix it with the approach I gave
in the other email

Jason
