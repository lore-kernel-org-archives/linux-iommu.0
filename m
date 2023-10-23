Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2076.outbound.protection.outlook.com [40.107.243.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F1420F6
	for <iommu@lists.linux.dev>; Mon, 23 Oct 2023 12:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hXhzFByi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aICqED6L8U5tYwBRZM/vo2nPN+8/n+alMePDP9RDiHAVboigoHwVbP4/4bJ+sDblrumsg8djSRylWw3LIxVi2lGLAj9w6Qe0exI/6XMlWmaDvqne1YfFLMiRg3aaaghJBiwq7D9NvpBExwYwULO5BY0Jcp1jKm5Z4iJmy6JUmt99t8oSC8YQKheAx5AL6ORq08IgA8lx/lS45A4N08QhG46AK96p0/cpJZadwCHsbCvXSsbTehKZ7mzDPym0I/HWi9LMKCizwySycVv47VG2YFpROjt2WHEvD28i+gfwzSkNwHVEdpt6i+4sxdKt4z9SvawamK5azbHk+Qb3TxmjEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q1Yx0PQa2BwqWcdqjxwVf+e4wW7wX9KzckXSlM1SuWc=;
 b=bqFXD1II1tUqUrYSrx/pVVCTO+axa97IHlY82dZHRB4pk/4qDb2k6ZJlpo5gz8hVmqrDNUYN/QdwZTGoaZGXsdpTs9oQzy4Olceicn7C9uFaiLHm/UsW7e611WOzVvLejOMxN90MTu8VQWrMac8wx7YrVB9HaX7mM60eabCahdxwbQYWAwuJUUN+ByK0S5LwdPy5GBVBSZcAZTX9nplvddItBPedCb2w9QQRGJPgd7RNrRzstZfsn9i8fvAg+l3Xu6b2M2mLbtKF9ZTP9cwpuIBrQP8z89J8HNk5BNrodt+DOJaOdE81AMdk/frUnGC9GDMyxN9GkJAnAlug9807DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q1Yx0PQa2BwqWcdqjxwVf+e4wW7wX9KzckXSlM1SuWc=;
 b=hXhzFByiVc+jpaRIMg5hdFmLgnUDZppp/Lg1/sGQ1CHU5sZtwL6bbpXATirkOtvv9LXVeT+4H1dBO94ePCrMgA2SkwemIuTDWwctWZG2LdTs7ZRKGzcpAeL0RC6rfI3n2xYdvXnKuVUUj2yXALz0smX7Bp+6zIIbdxpKBp9IOqtwsE42w6V4A6/ji0ntelKlb8sQf7LGbIIyrfHA9U5nRrGwBN0moWbnSovaZxFwefs4oVt2FJvqoulr3ibHJLsWBoApRF994OXi09d5uHn0dx7NgZaeiD+H/iYGKy1HbypzulypChE8dREqs1+tTJ2Izgnc1dHj3zzeHjqOglST4w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SJ0PR12MB6807.namprd12.prod.outlook.com (2603:10b6:a03:479::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Mon, 23 Oct
 2023 12:05:21 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2%6]) with mapi id 15.20.6886.034; Mon, 23 Oct 2023
 12:05:21 +0000
Date: Mon, 23 Oct 2023 09:05:20 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Michael Shavit <mshavit@google.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [PATCH 04/19] iommu/arm-smmu-v3: Make STE programming
 independent of the callers
Message-ID: <20231023120520.GO3952@nvidia.com>
References: <0-v1-e289ca9121be+2be-smmuv3_newapi_p1_jgg@nvidia.com>
 <4-v1-e289ca9121be+2be-smmuv3_newapi_p1_jgg@nvidia.com>
 <CAKHBV24UGZuG6+J4cybadJCTyf9hN+e_VgAC0NVOPotmEur7SQ@mail.gmail.com>
 <20231012121616.GF3952@nvidia.com>
 <CAKHBV27G1PLZ5gkYkOOCZdD9waZOZypkWqk4_HSR4XXGFT-+LA@mail.gmail.com>
 <20231018130455.GU3952@nvidia.com>
 <CAKHBV270uJjdj4zeK-NNt+j3TiqoGDdLUQ5uRrLw9PN0ysCDbw@mail.gmail.com>
 <20231020113918.GD3952@nvidia.com>
 <CAKHBV274M-DDD+vJgO-k9s4MF=FLhKajPdphfBVofjyOS3vHbA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKHBV274M-DDD+vJgO-k9s4MF=FLhKajPdphfBVofjyOS3vHbA@mail.gmail.com>
X-ClientProxiedBy: DM6PR01CA0021.prod.exchangelabs.com (2603:10b6:5:296::26)
 To LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SJ0PR12MB6807:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c6ebb54-191a-420c-b702-08dbd3c054c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xamgVENmuiLPoTy4uEyW355IIQUHJO8Dll3rHExOcI9DIW6tn7k8g3/mw/CjeENlPqctEqImaQX82q4VngfwzS7EVBJHNLi4o0RF/gNtaY9q3Z/hjoG5mV7A3kI0zIqj+bWTBFl3WpCorojMbAGHbyMUPLd8gQfbL6GjUrqdjkJ6z5fVr/cpveROjW1YXxklpzq43Ab2dAt1Tx7Q848AhIJ6iMTYGYX9CagqmwH1C/SL6zUHCBLFoAcn3oqUfkSZ5C7ajyoVgCfTQJc3MUg5RTO3sgG+fzd3mB0g+AAcqCTOpexnSk3rM0k9DL2+yYb4I3NTokNRkW8+tbhWH7XHZ5P7owVak7arr8JcaSIAHIYYcVmE9XF8MFmbbjCBXT2F+iqtt5dgyYB150YKmIk2tzMuGe254ijIl6ZORmYidDv7KsjBv8lTZdYNDeBXP2yExI1W0Hu2JWwcO54VK6/V9mhB6dpwyh012PCWET6pZEgDG48rT6/j8bwqUkNdjGg3fUOTkMwgXRzauENNcB4nXsV4aPwN9YhJkeqzKXNqM/PI7i4VbydPsxqeHXKA002x
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(136003)(366004)(376002)(346002)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(33656002)(6916009)(2906002)(5660300002)(8936002)(8676002)(36756003)(4326008)(41300700001)(66946007)(54906003)(66476007)(66556008)(86362001)(6506007)(6486002)(478600001)(6512007)(53546011)(2616005)(316002)(1076003)(107886003)(26005)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SjdTYjJqNXVVU1l1NkFzbW4wUkFsYnVYQ0F5a3J5S1Q5K2NoOXp0NlU0MnRD?=
 =?utf-8?B?ZjlUbUpIaFhZTkdScTIzMzBUQ0laVjI0UGtzbXM3a0JkTjFhQVVtSWd5U1J4?=
 =?utf-8?B?TjNuYzA3Mmdwd0NSNjZZSitlL0kyYVNWSVR6dGhNT1o0ekIzUGhIQWJ1V3lK?=
 =?utf-8?B?bUFsaE4wTWNsYzdvdDUvdVpuN2lsTFF0Myt3TC9Cb3VwalZ4M1hWaDU5RWpY?=
 =?utf-8?B?S0hXTEJhNWpHNG5Xcnk2Q1VsQ2lXVGRIMWRWa2tqQkQzUTlmSXlRUnp2Slpr?=
 =?utf-8?B?Y2RtMU5HTlZRUllYbjR2VU9xNGJQd25uK212eGJmQTNHZU1YZGRnQ1lBanBI?=
 =?utf-8?B?TVdPRzlURjZ1Nnk3RXhPMkwxYTFyVkNHS05FcjZzeUlXcGxoSWc2T095Zllv?=
 =?utf-8?B?emQ2RzVuamljWncyNkFVZVJVUThaSE0wWS85RThRbGZVSU82Rm1od2ppVzM3?=
 =?utf-8?B?Y1FWVXFpZ0Zsc0RRM2tzUDZZeWk3eUIzejREUGUzZEpQU3E0TytUYjhuTHFH?=
 =?utf-8?B?b0pGVWM0M1g0SWcxb0N2SWgvbVJETUN0K1EwYUVidS9UdnNmMmJ5RWhmVURG?=
 =?utf-8?B?dGpBVVJZY3BKVWFJQnhiUFBWL0hIQmFrckxSMmhKWFhXdjJsa09tcmtGUTZ5?=
 =?utf-8?B?RmhDZkx4SFBIMVJXWTVVeUdTOHkzWmZFSHNrdnV1empYMVV1b3VkTEFBdmFF?=
 =?utf-8?B?NnQwbU4wUkdhTkpsU1ErV1IwQlZFdEdTNTFVOGxrYXIyM3FpUFRUcjc0aWd6?=
 =?utf-8?B?YTFOQnlHWXhIK1hNcSs0QWJiZXJ5R1Fsa0g2K05OR3g3eVhrNEQ2QWkrR0pJ?=
 =?utf-8?B?MWROaUM0eThlRFhzcFFUZG1LWDJ3RXBsbXNPbk40SEJEQ3c4N25MaVhlUUVH?=
 =?utf-8?B?b2F1Uk04b1V2SlptRDR1c2wyNGVITjNGeFZOeVpoZGFvd0VaTm1UQWhmMndi?=
 =?utf-8?B?SGo2YS9BUDhjLzFLTDVqa2VMQkhVWW9WU2JGTklKNUVXb1lOdmVsdWc1ckhQ?=
 =?utf-8?B?SW1kQzVsbU1lUGJnU0s5MmluMGROTFJkQmFuYURhRW1pWWhHZkdLanBNa0Z3?=
 =?utf-8?B?RVdaWkdHTDZ3d3hwbmRHdUFsL2RNQ0xqL0t0TTBrN1Q2Z0xhdXpXMUEyZTRt?=
 =?utf-8?B?b0FPZ1RnOTAzVS9QYlRpM3dSNG93cHJ4dW80MXU0WkpiWjZBQnVtSlAya21J?=
 =?utf-8?B?dE53RDBZYkVBUGlDdGRqWEM2cDg1dUI4TVNlLzdtYkRGNmtDdXFUWStiY2lz?=
 =?utf-8?B?VzdIRjdqUTl6RDUzMTRNUDQ5OGpzNW5BQk16elhNb0drcXhqUTVtNDdnb3dQ?=
 =?utf-8?B?SEJDbmlrbnJsV0gzK0hUT0JZYjZQSDFGK0g4U0Y2RXZxc24zNGQvckdjdkww?=
 =?utf-8?B?ZE5pMmZqTnhiQi9lS3NLem90L1RwNDNXdEdnRzRMUzBVYVU4UmxFcE1BczVp?=
 =?utf-8?B?VjN1VEVHZFFUT3lPcXJVRDdQZE15U1BpRUxQUGpLekpVSy8yQ0RpZ0VjREh4?=
 =?utf-8?B?bFBNa0xtN0YxOEZjd0w1OWRsZnZQSDRHNkY5V1VmQ1V3TjdiYm0yYjR5akhK?=
 =?utf-8?B?NDBrNUxVTmFGcXp0bVo0YWdBdnpvR21RSGVKdjN1NVFjVnpQRlNYMW5XZmJG?=
 =?utf-8?B?OU8weDRhZlJVa01pZi9vaEJITnhOalF5eXdoK2RUUlA1N2F5L0t1dEFIRVFW?=
 =?utf-8?B?ZEJlU0NzUC9JSEVrdTlQTEpKNjRTNDlHYmFVOC9OSjlxZVhIR2ZTNVVzcFNh?=
 =?utf-8?B?b0lick1STVpkVk1RZ1hxTEFIVE1pbS9aUVFTSzJGZ2VXbHluaGtQNUJxWDNQ?=
 =?utf-8?B?MURVSC9lTW1sYXNMak5IMnkzSldpcUJFalJhTHVNQzBuQU4razZVMjhIeUw5?=
 =?utf-8?B?azBOYVJSNHVhMWxNaWhmRG84NkF2dnpqREVYeEhwWU16ajRPbC9kbjBnZ1pp?=
 =?utf-8?B?Y2xvRTNDbnRDSTlWRHVBOG56TUMwMGxia1lTU1ZYK0FDNy8yY0lzTmQ3VVEr?=
 =?utf-8?B?WHVxeHZjQ3FWREZNOXdiMGZ3bTZucTF1eXRCSzd5dHNVTTBFblNtVzNrZFZk?=
 =?utf-8?B?KzhiNENsWjF6OEo1MFFFV3EybEFQR1RjVjUrM1V6dmRFQ3RpM0ZaNW9DU2xT?=
 =?utf-8?Q?Bk48=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c6ebb54-191a-420c-b702-08dbd3c054c3
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2023 12:05:21.4350
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5QxuRFl/7UpJXOSITGlrr1DEVIr4Akdu450gA1We2dRobGXzuoYAYWcQ+amZ7lC/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6807

On Mon, Oct 23, 2023 at 04:36:36PM +0800, Michael Shavit wrote:
> On Fri, Oct 20, 2023 at 7:39 PM Jason Gunthorpe <jgg@nvidia.com> wrote:
> >
> > On Fri, Oct 20, 2023 at 04:23:44PM +0800, Michael Shavit wrote:
> > > The comment helps a lot thank you.
> > >
> > > I do still have some final reservations: wouldn't it be clearer with
> > > the loop un-rolled? After all it's only 3 steps in the worst case....
> > > Something like:
> >
> > I thought about that, but a big point for me was to consolidate the
> > algorithm between CD/STE. Inlining everything makes it much more
> > difficult to achieve this. Actually my first sketches were trying to
> > write it unrolled.
> >
> > > +       arm_smmu_get_ste_used(target, &target_used);
> > > +       arm_smmu_get_ste_used(cur, &cur_used);
> > > +       if (!hitless_possible(target, target_used, cur_used, cur_used)) {
> >
> > hitless possible requires the loop of the step function to calcuate
> > it.
> 
> Possibly yes. Another option would be to have a list of transitions
> (e.g. IDENTITY -> S1) we expect and want to be hitless and check
> against that list. It defeats some of the purpose of your design, but
> it's also not obvious to me that we really need such flexibility in
> the first place.

When we get to nesting the change of the STE from a VM should be
hitless if the VM thought it should be hitless as a matter of
preserving HW semantics in emulation.

Even if you had a list there are several different methods to do
hitless, this is more of the direction of the old code where things
were carefully open coded and fragile.

Jason
