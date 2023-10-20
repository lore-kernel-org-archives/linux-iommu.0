Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2066.outbound.protection.outlook.com [40.107.100.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5080F199A0
	for <iommu@lists.linux.dev>; Fri, 20 Oct 2023 11:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PVC4hNgx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EZp9WcUPAfZLCKSeprCowh2jX4IHQ3MuCMKaWa2neTOCo4bimDoPaqyZAz4+jGLz7cQvG8HvWSNZPi5Ei82EqjFYLYkMF+phR0HDuHZK9zVgVl34pYhBf1QCH5Fh8MCJZHH+g2Vem9eJRykBTQ4W4viwT9EpIuPNbLhioEdJXfrdTIL5OnUWJwUlJFd1AvLNzzsky3DJkvC+G3p1dmse0AR7DX54Roet8eJhH0h14Jj26V6HfirmkC6P/Ovv5JRteN+xinL9YbLDazlXidscX5zNJj0alqiHN9s/Yu4W+zBEzHyyb/LJWlhv0VlracSALmwTWfOOqDS+3XPuXEVMtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1iCqEkll9w0HOCsEGeF5yOFNLT0G+QARXX6zYRT/mO4=;
 b=NHka1+OyxY/x1XC6QPdGvBKWoJOT/kqXfZPJ5bQs2bLOyrlWyl9s2EFPxPsbdeiOcn88xBX6rGKG+QomJAa/dIrHkgjaGu/DuEAv1I0dit9FiMIQoZ37nelML0xDwQApvKJKu5tZSMmNECPjBzOX9+hXSrGS8lSae4IjHNoaW0BmpHn3/z/BKONMpNHSXhfzoA+4LqpjhsEyWd4c2cL0gadxv1/7JTQrTM9aFsHmtjSihD3B1wp/x+ETHlx2x0hF+3svbRyD/Zjd1gM7+laIuaHYQT6xXVpMWG/zoAWCqfmWUhuKbvk61CegdWc/AL1v1RxAsmF+Do2crOLE7HNqBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1iCqEkll9w0HOCsEGeF5yOFNLT0G+QARXX6zYRT/mO4=;
 b=PVC4hNgxIfgw42M1ziE2IMH+kROzNezXEpIiGP6QcctsHd5RyKNNqrUHgAgKgSzwsRC4T0RZEG++jRr1+qI7TuLEPj77SWiJMIKp02FuiRXbMBy9nZJc8pH5d7NaU8SlCGr3tHLKJsVpf3NXmrgB38GkmM58S7GxdazEpn8IqTI7HvSUGc2tPkEtqZfun3iFJduCaRqQi13wbKwy1VfMRR8EJaOyFgHJCVwRdLDUERNPSUwXjEYfrHGTAJ3eCUdmojllvq+UHk1vFj6x13wP8NG99kQEr6OJ48HD6/wK0EB1gyrfxJ0IAQLJ0Vy6EmnPbgrf2OJmHnhxa2Bzh6ExXg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DS0PR12MB6653.namprd12.prod.outlook.com (2603:10b6:8:cf::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.21; Fri, 20 Oct
 2023 11:39:21 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2%6]) with mapi id 15.20.6886.034; Fri, 20 Oct 2023
 11:39:20 +0000
Date: Fri, 20 Oct 2023 08:39:18 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Michael Shavit <mshavit@google.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [PATCH 04/19] iommu/arm-smmu-v3: Make STE programming
 independent of the callers
Message-ID: <20231020113918.GD3952@nvidia.com>
References: <0-v1-e289ca9121be+2be-smmuv3_newapi_p1_jgg@nvidia.com>
 <4-v1-e289ca9121be+2be-smmuv3_newapi_p1_jgg@nvidia.com>
 <CAKHBV24UGZuG6+J4cybadJCTyf9hN+e_VgAC0NVOPotmEur7SQ@mail.gmail.com>
 <20231012121616.GF3952@nvidia.com>
 <CAKHBV27G1PLZ5gkYkOOCZdD9waZOZypkWqk4_HSR4XXGFT-+LA@mail.gmail.com>
 <20231018130455.GU3952@nvidia.com>
 <CAKHBV270uJjdj4zeK-NNt+j3TiqoGDdLUQ5uRrLw9PN0ysCDbw@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKHBV270uJjdj4zeK-NNt+j3TiqoGDdLUQ5uRrLw9PN0ysCDbw@mail.gmail.com>
X-ClientProxiedBy: BL1PR13CA0260.namprd13.prod.outlook.com
 (2603:10b6:208:2ba::25) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DS0PR12MB6653:EE_
X-MS-Office365-Filtering-Correlation-Id: bdb1018d-726e-42bb-1d0f-08dbd1613309
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	rhMsS7xFCbJg+/36BOWyZ9EblP/gzgVbleM0DvcfbVrBE0FJFBRLQr0N2ufRxnsaJYeesCE2KubGR0MMyMkE/j1434/bxKgkv0ogfPY4KpqqVjYF0AXnzldCk6HnKxq7S+tglPVZfc6f8QksXOpMME3rPK7xi+bJaJhO0Brz/LwITpv1o6FQeaWVf172H5ApX4hQOkA40iIQo9icLV50iDeRanHoFoDs/KbfGtcdYofuRenf0ezCWptVYG8n9Js1NfnRSgzMKto80YyYhQ0lHO7sgkBQNiT9c67gHKt3Q0CxWRBmYEDOkTID4pk2MH12xvQf4LJY2wN9HpDwVvliHPixk3wX5q5OveW78tOh5O65RfnMZCKssVge3EX3dz0uf2ecop4nZg9RmpWktd9Kiaop6ajG+D59s/JMuR3WmQk56jLihDiGTz3Md8lHASvvqzWU1aJWxw0fEH53kqIvBcIRV94XfxVQUbNhNa5DzKHAf7kRdswBe/KKp4OZYMF7bkU4gDpcLLCmtiq74QzmL48IBl8iVGcYS1XrIA2C5KKPrvbmRrdaMv3SgOgH0WsO
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(396003)(366004)(376002)(136003)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(33656002)(66556008)(6506007)(316002)(38100700002)(41300700001)(2906002)(1076003)(2616005)(107886003)(6916009)(66476007)(54906003)(66946007)(36756003)(478600001)(5660300002)(8676002)(8936002)(4326008)(6512007)(86362001)(26005)(83380400001)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?i4hhDBUSgedBGztWhvL2jQNxMocxisfUM/1af1fWBksRmK+bV3SRnm1qWfOK?=
 =?us-ascii?Q?PxPSFkCvW7mrqeXfDXTTWb2KIqnQpt98mHeEcksTzPj7iAk8pQyTfpX9Q3+v?=
 =?us-ascii?Q?T1xuTWjqtfT/SAOWJzfWdFa6cnvmQry44nH+/1aSkd+2M43VwJ1pmyrnhLr2?=
 =?us-ascii?Q?IceyBBTDBFbjlhfLLVwZlRsjVpuNMBLbXCA2wh7onnCWqc2pOt/nfamhm2iD?=
 =?us-ascii?Q?wxjqBOKlGFCDH3HzawBa4Q4ExAdQRnpqAk5nLbftyLJEmDbjAT/AGryQRf6Q?=
 =?us-ascii?Q?O7Q1YKT6Sp+Rgg6qKdOPpederZY0WiM1HPn3rs7m+7bYCaOFORkCH6u3eGhl?=
 =?us-ascii?Q?N/4v1ME6bWzaFmTH1YUSSNuZ0AGYULBJGVYzesFOywlvM66AaBey2k8LwDJb?=
 =?us-ascii?Q?ZorkoqIhUiH6Nu/1pq0nPsRc9S+TELOAaZumVuOuakvbqQUnIg+4Eg4QUT1P?=
 =?us-ascii?Q?Ra1BzmUXRS5JottzuyWs72gdw3CBBknLeZbzdntQx2upvSeb91TorJiUNViu?=
 =?us-ascii?Q?AcqyFlDH7zCFTqgPvna9tlkkIauyUAaFC3ACBFlIPipQk7PTfQ2tSJLxZleg?=
 =?us-ascii?Q?z+04DteN//TgRQjcyFSoaUZkPcIIhs9s3u+iQe1YVIEdVJE8ncuC1chaSwtq?=
 =?us-ascii?Q?dy9YXlXBCtk0dBkGNUO11F6hb4F8EWyzz522U16NgmrN0urma1vm7GO6EODu?=
 =?us-ascii?Q?F79zSu+0ccWVt5VxxRu3gYqtXwMVqv/SAG8Sqk9NbkFWJeL51G0DbKOwmg0N?=
 =?us-ascii?Q?VG2MU/gVs/RgjoTgilOZe0Sl+CymD9W1J0bBj6WGMMN1i37w9UO9hRdMdrDt?=
 =?us-ascii?Q?jC7yZHzgKYHWCbFP8//cz7Dl44lNBinbvUJLV1dkcA6QMGAQ782JrJgMlckz?=
 =?us-ascii?Q?DrCwFKQbyGa8EU1Zbp3s6l07JN53jkmmErKKhqA4ERQlPPw4O7z4bev6V56G?=
 =?us-ascii?Q?UvHwoP0t1qanNUKiDw46tq/3k5hnVij+a4EVg9JNlKBYl06kX1oyCrKiHJXQ?=
 =?us-ascii?Q?ApfsEJipESFfJESkDT+bR4yLi35jYrflEIDOlQYk5DBRHO8CLjszO2DV6Qo8?=
 =?us-ascii?Q?NKsYC1I5sZ8Re+hGzLdRO2l3KiwU1iUna9Ew2uTihKfFahAJU98PC49ZqSNU?=
 =?us-ascii?Q?eWsHiTAbAlZrp7C3F+409nnph4C4Owp2OemjkzpuCNPI1xMqE9nLXvJeWpd5?=
 =?us-ascii?Q?GDlML0lTDFxh3MheOQ0zR2cvb4Kbz9++TF2TaozIAm5wVIQTq4gW1LEPL4OH?=
 =?us-ascii?Q?whNsu+G49UbuR7X+36K7NHH3+FjZrkjw0nR8J3PZBm40AU9WNbMBzyeaZeal?=
 =?us-ascii?Q?yX+iO/IG/zCQosiR0sko268QbhEjlFNCQYgTHPLZuuLW0M8paQD/GwLq9GfF?=
 =?us-ascii?Q?rlZoaY5uU494pnnRxH5vL9YN/nFAVSSHjjz2sisfBpwmrGBZZ8yGRai4JiKN?=
 =?us-ascii?Q?eOyR+bIns+pQuy+OLJMKfd7LbMiehP1CxJozQmxuP97XaXWtn0Uu9+80kY0s?=
 =?us-ascii?Q?4mjZvD6N1aq7LlyeC7YHA+W7kCYBw3xSTQrF+Cd0sKix048lUNVxqqQDE9dX?=
 =?us-ascii?Q?kZZjSTNS0G+sqAEKZOVwO07b5kOvm3BK8McldA4U?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdb1018d-726e-42bb-1d0f-08dbd1613309
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2023 11:39:20.2513
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I1ViNGv5qbH5tB8mriaiMWCtqtcwaknsbPIGb8v/5AzpwN2x2OmsFUQb7o+pGLfU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6653

On Fri, Oct 20, 2023 at 04:23:44PM +0800, Michael Shavit wrote:
> The comment helps a lot thank you.
> 
> I do still have some final reservations: wouldn't it be clearer with
> the loop un-rolled? After all it's only 3 steps in the worst case....
> Something like:

I thought about that, but a big point for me was to consolidate the
algorithm between CD/STE. Inlining everything makes it much more
difficult to achieve this. Actually my first sketches were trying to
write it unrolled.

> +       arm_smmu_get_ste_used(target, &target_used);
> +       arm_smmu_get_ste_used(cur, &cur_used);
> +       if (!hitless_possible(target, target_used, cur_used, cur_used)) {

hitless possible requires the loop of the step function to calcuate
it.

> +               target->data[0] = STRTAB_STE_0_V;
> +               arm_smmu_sync_ste_for_sid(smmu, sid);

I still like V=0 as I think we do want the event for this case.

> +               /*
> +                * The STE is now in abort where none of the bits except
> +                * STRTAB_STE_0_V and STRTAB_STE_0_CFG are accessed. This allows
> +                * all other words of the STE to be written without further
> +                * disruption.
> +                */
> +               arm_smmu_get_ste_used(cur, &cur_used);
> +       }
> +       /* write bits in all positions unused by the STE */
> +       for (i = 0; i != ARRAY_SIZE(cur->data); i++) {
> +               /* (should probably optimize this away if no write needed) */
> +               WRITE_ONCE(cur->data[i], (cur->data[i] & cur_used[i])
> | (target->data[i] & ~cur_used[i]));
> +       }
> +       arm_smmu_sync_ste_for_sid(smmu, sid);

Yes, I wanted to avoid all the syncs if they are not required.

> +       /*
> +        * It should now be possible to make a single qword write to make the
> +        * the new configuration take effect.
> +        */
> +       for (i = 0; i != ARRAY_SIZE(cur->data); i++) {
> +               if ((cur->data[i] & target_used[i]) !=
> (target->data[i] & target_used[i]))
> +                       /*
> +                        * TODO:
> +                        * WARN_ONCE if this condition hits more than once in
> +                        * the loop
> +                        */
> +                       WRITE_ONCE(cur->data[i], (cur->data[i] &
> cur_used[i]) | (target->data[i] & ~cur_used[i]));
> +       }

> +       arm_smmu_sync_ste_for_sid(smmu, sid);

This needs to be optional too

And there is another optional 4th pass to set the unused target values
to 0.

Basically you have captured the core algorithm, but I think if you
fill in all the missing bits to get up to the same functionality it
will be longer and unsharable with the CD side.

You could perhaps take this approach and split it into 4 sharable step
functions:

 if (step1(target, target_used, cur_used, cur_used, len)) {
  arm_smmu_sync_ste_for_sid(smmu, sid);
  arm_smmu_get_ste_used(cur, &cur_used);
 }

 if (step2(target, target_used, cur_used, cur_used, len))
  arm_smmu_sync_ste_for_sid(smmu, sid);

 if (step3(target, target_used, cur_used, cur_used, len)) {
   arm_smmu_sync_ste_for_sid(smmu, sid);
   arm_smmu_get_ste_used(cur, &cur_used);
  }

 if (step4(target, target_used, cur_used, cur_used, len))
   arm_smmu_sync_ste_for_sid(smmu, sid);

To me this is inelegant as if we only need to do step 3 we have to
redundantly scan the array 2 times. The rolled up version just
directly goes to step 3.

However this does convince me you've thought very carefully about this
and have not found a flaw in the design!

Thanks,
Jason
