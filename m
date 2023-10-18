Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC353419C
	for <iommu@lists.linux.dev>; Wed, 18 Oct 2023 12:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="I8AWM8Ra"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KFT1Q1szEQnMfnon7Py33vRI3YRff+JSvKYG0tskvR6pgQJiHkYv14lG1TRxOYiQZl47uxjCLOZjDsWRy4MzaIo+AZTZ/6+h4tE4mVjkttHpLZud5ZFM5tnxhUPlo+YfzKMzRBf2BaoEWa6t9qk9KJ/QTOwtYiVo2yQY91nQJXRnvITfkT7BdlMUOJ4rjBlbr3aaWRRMjFQI+OnBLYT+b/ucaCmVx7Px+wIQf1oFjPJFfsFLi8TDqXR2moZRl+cZrnIPDXULo4Bly2WOvae/r13Q2bBOSGeymD9T4bJb6/MkkcmQDB8D8/6S8+BdZAjGVfT/43k/VGgYnmmPJNZTxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SUNfTOE0EmTDz28jqlO0NlfTyMB4B5HtfTKMrnC61Wo=;
 b=JOfjGl+nOGqzkg+5f1zQeflCEQ5wJWzhj72PHpM8COwlKXYgjLlzNsZoHMppx/f3nKyUj6gCv7X538ireCq9u4J0hYsT92qY0rEThV0XRrGt1Ev9SJ/XZx55JJ+hP/ODzjM3A4WSX6Po0ytu0P3/7ZXinzJrsc7oW+VQDty5Jk00T9/U5ZIudLMmyJ7aw5a67bybl8n8GSjbeAWHgGx3V+EUGr1awrFD3E4as19rfGGMaowJeesBk1UPZjeKW8pl1JbaKdhoDCjMfqhwBsvws8/ZrEGI9Sqx6ABfQu/8O7L7Zm8UXG6gmznfKuvbvRLEvXvV+a83pcKEvTC5oCy4aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SUNfTOE0EmTDz28jqlO0NlfTyMB4B5HtfTKMrnC61Wo=;
 b=I8AWM8RagB5qKl2rfuFYLTX+YmiICvumCNEMAHX8+/4l1xmvE4yJvXfEmcPoq/U5zUGOO/hidY4sKWs2Z9ua+imqVtSxHwJSUSdWkJHGw4loVJaNAcv7xylnyG3w0W7Cij3EoQeU0q8J5umMBdwvrjgKQI+IfprFSx8mxyeBnewWgTeIfKQikX4gRAn1zVIpN3+xiqh2Xt1E6kn5YS2RmNHQZAIrXvcrkRbW1+2IPWFyJoHrcdRZjeERZa5gy23XddxtzdUjyVPiDTrui2hKq6HhYvuMHzATWgH9Y5JIIVWscjmTuUOXjwgAtLAsi+Z8plOamtFeDnR3YrQShsakxA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by LV8PR12MB9406.namprd12.prod.outlook.com (2603:10b6:408:20b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.23; Wed, 18 Oct
 2023 12:24:38 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2%6]) with mapi id 15.20.6886.034; Wed, 18 Oct 2023
 12:24:38 +0000
Date: Wed, 18 Oct 2023 09:24:35 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Michael Shavit <mshavit@google.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [PATCH 04/19] iommu/arm-smmu-v3: Make STE programming
 independent of the callers
Message-ID: <20231018122435.GS3952@nvidia.com>
References: <0-v1-e289ca9121be+2be-smmuv3_newapi_p1_jgg@nvidia.com>
 <4-v1-e289ca9121be+2be-smmuv3_newapi_p1_jgg@nvidia.com>
 <CAKHBV24gTmBTEVGx__mSs9bQ93DLTZ-VDbpE24S87kgXS+nHhw@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKHBV24gTmBTEVGx__mSs9bQ93DLTZ-VDbpE24S87kgXS+nHhw@mail.gmail.com>
X-ClientProxiedBy: SJ0PR03CA0200.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::25) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|LV8PR12MB9406:EE_
X-MS-Office365-Filtering-Correlation-Id: c11d39e5-b6fc-4b90-a7a8-08dbcfd53275
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	5lw8o4XAnn2RwjVdiC4iHSgVRxmT6grsBe1/oZptCvyFMzi0kOLPYzzt5ttJuttNu2jx/VLu/Ii2r+6VLboeynwRRn5epTj8EfujP0fzG0mF3hfjP0mgbwwiifS+U5AYp819/KJTVIdotP2QqegzxzSc01Ec0N+YkX8yqpPReHrVV8tpwA5bp1RxIMT2yPVk5JcIv1wmir3wau+CDvDkHQgoZsHSCoQXOAD4Hz39k+mqe0CVACP4XGZheQGJ+aEL0WVIX3lP0YDalJ/iY14hgAJmjehP7uKYxReYQvHzIotZhSXss+I+N+HWG7baK8Y4+RF9NYSz1d2pVJqkKFW2b2VSzcluUlHIwDloh0cPsZica+zcRIsX/SOn6aYjTiD3POOsli1lLfnsIL02JaLBVUULgKMCjmQb207VkV8k5SzNJJGZW9RXkU3U0fnN7VnUtWdoFANF6wGtixAc9wl64wBKxiAYoQbcHuXD2pI/xcZUM9IM+gXQttEIXB/amQByPtDcg/FrmjNr8wmRNq09uja6ghgVoQWiI4gSDccms3uRenEbDdQrE2aoYAZOnUXE
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(346002)(396003)(136003)(39860400002)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(83380400001)(38100700002)(1076003)(107886003)(6512007)(36756003)(2616005)(316002)(6916009)(2906002)(86362001)(66946007)(66556008)(66476007)(54906003)(41300700001)(5660300002)(8936002)(4326008)(8676002)(478600001)(6666004)(6506007)(6486002)(33656002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QWu5mYlsqMg7U7Lf7By+MF+kvCublMe9Z+JYeyynAXGJ6GlZT06cBZUOnm7Z?=
 =?us-ascii?Q?NxlOfOicNJQSl0DnnNjePk/IyORQ2lQZu8Y//N5O+1b1za3A+VvG2vXnNZJp?=
 =?us-ascii?Q?8RBoqn4fOhDaqbfySBjAP2h7Xu4n+41Iy/B6fxNOrEj11LOQsa3uwNPdxoXT?=
 =?us-ascii?Q?hVibp6nfTEyUW3eTXE0UYrCo07zpJZ9pc6pBfg+9H/pSD7sDmXi7msa1i0lI?=
 =?us-ascii?Q?AWWvgOvD8+uP4TeKKfW/ctylyAuProYB8NQAIW7IdVGaLQTIFVRHA9ldJY+F?=
 =?us-ascii?Q?jDbaxdMr+eCCtPP0+oNeFlISljbwR0wBiMHUyyaOqBZZZXEMPff0u+hWHDUN?=
 =?us-ascii?Q?aNM1n5ECRfKhwEwcLaFZTLXeC+oVahqRLuTm5CwdUrHSPl8GHPdX/izGKePD?=
 =?us-ascii?Q?sFc8Mlia//LxhuHOCLAAFMYXbzne3o6zL/TmoxMw7sbhz1ecfAL402nJ42tT?=
 =?us-ascii?Q?ztcGsfN9hk7ihVu7xHa6qvOkdIT2cK2I1lRwNNpyGoKC8g0/6zceBudrEaOA?=
 =?us-ascii?Q?ZZA8M5ksa52+JXE9TBDjc1+28kPA0msv3MAYFlN0IJRQw5BQN1+i5UEsQr30?=
 =?us-ascii?Q?XsLT+3o6f92VF7TS38M308Yko+m5Z8MDScsQXEOAsTMnpa6IKqkcSl2llhP4?=
 =?us-ascii?Q?DPZbb7XGEsubF0cmvaPQtHB2WFmtY7o33TtfidtXh7RMj397V3GC2y/x4Fjv?=
 =?us-ascii?Q?Z1ac9Hh+JzZoAkLmjT4LZj+9mrvtB0n3iSi/kmuKt2ClqM73GBOycqf2dA+/?=
 =?us-ascii?Q?TImU5+ZB9BN0yo/wt3KV/5u1ObHH6HQlGlPFK/qX60ECJYAxXqmWqZXwUOsK?=
 =?us-ascii?Q?A7jplsMenbPgbXpLx5sOUo59Hsg4mWvj6imHTAGX5EiTwEF+kJehIiAwIgjy?=
 =?us-ascii?Q?sjtLpxuMLB4N+3vEnvS+0+53P5PweL7q6p2uCb/7dTT+viHVtRk3/suRtJMJ?=
 =?us-ascii?Q?NZ8eeiNEkRtoIxK2J1ecqCCpfMjyEQlFbxSVIxfumpokt9JWlfuqdy8Whnyx?=
 =?us-ascii?Q?oRbAlz3e6apLoMw7TOvzcDHfky83xVDqrpZZUQE+H9aO3haHK7BYxYaaovga?=
 =?us-ascii?Q?X+rdWVy6tUdsuNxN3Y1jYb76YNXmQvtbAhZVsZ8HJ1ZujJy73GP2YPk/coD9?=
 =?us-ascii?Q?R8RJJIyuJRrzHFGCgdFnjlQIKcntrWWLdWNApuBwL6JK9QFtGBsVtE78+xcl?=
 =?us-ascii?Q?oQ/JQvBq7L+NlU79Mf758VokYoIPOTmk2U7aPUb4mg4/8gA4SyvZOu8pp1UI?=
 =?us-ascii?Q?4AQSL93jKr24bl8wvU+HFmReFOxckihDsLqwf/0H/sYshGjk/00YvtOIyOWp?=
 =?us-ascii?Q?/AB5fBIjSlJWXyrdXMOg50DDoJFa4zcbFCN5SwjLSp/BsST0yl1eLbuBBhFj?=
 =?us-ascii?Q?khWVAo+EsXceZCSeH6469pOMiuR+8zfOEJ72dr0Kk7ALv5A3p2Pn4ptJ6LLX?=
 =?us-ascii?Q?yW5MDc4jodq/aPv9hQfD59ZAL8ZXSc8R90HcDbs060KiSECsxyHZZeKIvUNJ?=
 =?us-ascii?Q?qj9b6c2Ebw7v6QoGFOL3FIhKxwx7hzci8V6eRdTxvWuRK9Mh/mT/cFn+9jZt?=
 =?us-ascii?Q?htTQ6YvFP1EGk+6IditfWM175Bebv4Dqx607WLW2?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c11d39e5-b6fc-4b90-a7a8-08dbcfd53275
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 12:24:38.5423
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J1kOf9/CxLNLv4CXCEXMmQ1BdRKlaWlWnC9vupusFGh0U6879qjrvPSfghwrJNCD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9406

On Wed, Oct 18, 2023 at 06:54:10PM +0800, Michael Shavit wrote:
> > +       } else if (!step_change) {
> > +               /* cur == target, so all done */
> > +               if (memcmp(cur, target, sizeof(*cur)) == 0)
> > +                       return true;
> Shouldn't this be len * sizeof(*cur)?

Ugh, yes, thank you. An earlier version had cur be a 'struct
arm_smmu_ste', I missed this when I changed it to allow reuse for the
CD path...

> > +       case STRTAB_STE_0_CFG_S1_TRANS:
> > +               used_bits->data[0] |= cpu_to_le64(STRTAB_STE_0_S1FMT |
> > +                                                 STRTAB_STE_0_S1CTXPTR_MASK |
> > +                                                 STRTAB_STE_0_S1CDMAX);
> > +               used_bits->data[1] |=
> > +                       cpu_to_le64(STRTAB_STE_1_S1DSS | STRTAB_STE_1_S1CIR |
> > +                                   STRTAB_STE_1_S1COR | STRTAB_STE_1_S1CSH |
> > +                                   STRTAB_STE_1_S1STALLD | STRTAB_STE_1_STRW);
> > +               used_bits->data[1] |= cpu_to_le64(STRTAB_STE_1_EATS);
> > +
> > +               if (FIELD_GET(STRTAB_STE_1_S1DSS, le64_to_cpu(ent->data[1])) ==
> > +                   STRTAB_STE_1_S1DSS_BYPASS)
> > +                       used_bits->data[1] |= cpu_to_le64(STRTAB_STE_1_SHCFG);
> 
> Although the driver only explicitly sets SHCFG for bypass streams, my
> reading of the spec is it is also accessed for S1 and S2 STEs:
> "The SMMU might convey attributes input from a device through this
> process, so that the device might influence the final transaction
> access, and input attributes might be overridden on a per-device basis
> using the MTCFG/MemAttr, SHCFG, ALLOCCFG STE fields. The input
> attribute, modified by these fields, is primarily useful for setting
> the resulting output access attribute when both stage 1 and stage 2
> translation is bypassed (no translation table descriptors to determine
> attribute) but can also be useful for stage 2-only configurations in
> which a device stream might have finer knowledge about the required
> access behavior than the general virtual machine-global stage 2
> translation tables."

Hm.. I struggled with this for a while.

There is some kind of issue here, we cannot have it both ways where
the S1 translation on a PASID needs SHCFG=0 and the S1DSS_BYPASS needs
SHCFG=1. Either the S1 PASID ignores the field, eg because the IOPTE
supersedes it (what this patch assumes), the S1DSS doesn't need it, or
we cannot use S1DSS at all.

Let me see if we can get a deeper understanding here, it is a good
point.

> > +       case STRTAB_STE_0_CFG_S2_TRANS:
> > +               used_bits->data[1] |= cpu_to_le64(STRTAB_STE_1_EATS);
> > +               used_bits->data[2] |=
> > +                       cpu_to_le64(STRTAB_STE_2_S2VMID | STRTAB_STE_2_VTCR |
> > +                                   STRTAB_STE_2_S2AA64 | STRTAB_STE_2_S2ENDI |
> > +                                   STRTAB_STE_2_S2PTW | STRTAB_STE_2_S2R);
> > +               used_bits->data[3] |= cpu_to_le64(STRTAB_STE_3_S2TTB_MASK);
> > +               break;
> > +
> > +       default:
> > +               memset(used_bits, 0xFF, sizeof(*used_bits));
> 
> Can we consider a WARN here since this driver only ever uses one of
> the above 4 values and we probably have a programming error if we see
> something else.

Ok

> > +static bool arm_smmu_write_ste_step(struct arm_smmu_ste *cur,
> > +                                   const struct arm_smmu_ste *target,
> > +                                   const struct arm_smmu_ste *target_used)
> > +{
> > +       struct arm_smmu_ste cur_used;
> > +       struct arm_smmu_ste step;
> > +
> > +       arm_smmu_get_ste_used(cur, &cur_used);
> > +       return arm_smmu_write_entry_step(cur->data, cur_used.data, target->data,
> > +                                        target_used->data, step.data,
> 
> What's up with requiring callers to allocate and provide step.data if
> it's not used by any of the arm_smmu_write_entry_step callers?

arm_smmu_write_entry_step requires a temporary memory of len bytes -
since varadic stack arrays (ie alloca) are forbidden in the kernel,
and kmalloc would be silly, the simplest solution was to have the
caller allocate it and then pass it in.

Alternatively we could have a max size temporary array inside
arm_smmu_write_entry_step() with some static asserts, but I thought
that was less clear.

> > +                                        cpu_to_le64(STRTAB_STE_0_V),
> This also looks a bit strange at this stage since CD entries aren't
> yet supported..... but sure.

Yeah, this function shim is for the later patch that adds one of these
for CD. Don't want to go and change stuff twice.

For reference the CD function from a later patch is:

static bool arm_smmu_write_cd_step(struct arm_smmu_cd *cur,
				   const struct arm_smmu_cd *target,
				   const struct arm_smmu_cd *target_used)
{
	struct arm_smmu_cd cur_used;
	struct arm_smmu_cd step;

	arm_smmu_get_cd_used(cur, &cur_used);
	return arm_smmu_write_entry_step(cur->data, cur_used.data, target->data,
					 target_used->data, step.data,
					 cpu_to_le64(CTXDESC_CD_0_V),
					 ARRAY_SIZE(cur->data));

}

Thanks,
Jason
