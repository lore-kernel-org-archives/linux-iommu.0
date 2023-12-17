Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2081.outbound.protection.outlook.com [40.107.93.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EACB44361
	for <iommu@lists.linux.dev>; Sun, 17 Dec 2023 13:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="H4L88R/h"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T0dUi1Td3GD3oYnhyhIfrk12NCdnM/Pj4z+09v2zjijk4tsMD+AmpWZlhERofUIamzRSnk3Zbod5KIxU1szR4VDL4DyOeU8xiHCTzO3ODkZuczKVuS6ojpU6mfmielYxdTrIhK7gPGQlZkUZIOSGuXjQ/fiFj1IUdb45PQ8uQXzJOoQ1ab1wh982DM1BGSQ5kauXUHUFj0Ta4fZ+aQevSDKyyp6lyngr/3AHG0cRhfvcwRh0+kYFFRngGmXfP7xU8ZNpod4rMn1WZVMT4HFCNxOgdodxEors+vhSbw3DucC3Mn0lJ+plSNDkk7QF/ovzBG/JmNxDLRMr8h38S4U9cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dOqQH6Hjex+J5dK56vzsttN/lBzlnnMQ3i1uyMVp5BM=;
 b=bCOlrWrp25djPu7D7vKgFXs7kQkSgup5v8SYc6BEKp23c0VNFiIjBdL6DGcs4811/N6hobjJgVN/aQ0BycYEHq0pmlixD8zT22SZlLOgwK7WujTAeYZ4jWztectRA5b6x1nA6D8E2GA11QTfyA12fBejRBgolxz0tblXwm7//GHiOKtGd9T4O88gsBBQZPo8B34qGDOl53UQzOkfn4llbLG62CmFixL9nqBMh7s2sTEfY71XUb+3zioZ3WPW8aXtTk6c2ndN2F9KemeHyVWsloHfmfsI0IiIE66x2xSxQhuTxwnoj/b+Hdv0E4FYmia1Q4QZ+wyKS2Z4bq2c6F3Maw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dOqQH6Hjex+J5dK56vzsttN/lBzlnnMQ3i1uyMVp5BM=;
 b=H4L88R/hac1yP0A6glRc33qJMxQBiqgY+TfP73hx9qdTt4lYYfk57iTkqqK9rQGEZOCYD1zVKykSsF7urVMHqDvKON3lby/M0+NJbmF+hr/r6ZR0n7td/27/4JG0a9jdf391yKpDSA8Fm4ho+RuffmkQMmKWmdnOeSwr8e3MLF1hhKnqxNC7Pp4s4uFRdzSbH6wUgME/6MAgu09DtiAeQapv0g4B7ZVw4QvYZbp/2Eqibsk8djBTTCSd56t7wEvAHgsnJBiuIJ2n/CHabKvhyONXqDUD8eldxwINLYqMiYqIAIIEk8YRE6xVQK+qvOluTOLHkAH+9PJEzShDh0rGng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM4PR12MB6448.namprd12.prod.outlook.com (2603:10b6:8:8a::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7091.37; Sun, 17 Dec 2023 13:03:56 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7091.034; Sun, 17 Dec 2023
 13:03:56 +0000
Date: Sun, 17 Dec 2023 09:03:55 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Michael Shavit <mshavit@google.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [PATCH 04/19] iommu/arm-smmu-v3: Make STE programming
 independent of the callers
Message-ID: <ZX7xu8jN/rBZ4A/d@nvidia.com>
References: <0-v1-e289ca9121be+2be-smmuv3_newapi_p1_jgg@nvidia.com>
 <4-v1-e289ca9121be+2be-smmuv3_newapi_p1_jgg@nvidia.com>
 <CAKHBV24UGZuG6+J4cybadJCTyf9hN+e_VgAC0NVOPotmEur7SQ@mail.gmail.com>
 <20231012121616.GF3952@nvidia.com>
 <CAKHBV27G1PLZ5gkYkOOCZdD9waZOZypkWqk4_HSR4XXGFT-+LA@mail.gmail.com>
 <20231018130455.GU3952@nvidia.com>
 <CAKHBV270uJjdj4zeK-NNt+j3TiqoGDdLUQ5uRrLw9PN0ysCDbw@mail.gmail.com>
 <20231020113918.GD3952@nvidia.com>
 <CAKHBV274M-DDD+vJgO-k9s4MF=FLhKajPdphfBVofjyOS3vHbA@mail.gmail.com>
 <CAKHBV24nfdq1q76T+DRQGNYeA-kP7ONnSjDsRFGsQCJVSrSm0w@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKHBV24nfdq1q76T+DRQGNYeA-kP7ONnSjDsRFGsQCJVSrSm0w@mail.gmail.com>
X-ClientProxiedBy: BLAPR05CA0045.namprd05.prod.outlook.com
 (2603:10b6:208:335::25) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM4PR12MB6448:EE_
X-MS-Office365-Filtering-Correlation-Id: 20003c56-a459-4093-152b-08dbff00a08b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Ca8JmlXaLfl5WalxM1K1Fl1L9cGBksPZ5tssU0xmnmNmsgXlrpgC0DCoQMVj9Bk00NJ0FZoJr8xUFJpi8NZU3n4jfU56/YQRoQE9u4blC8FblDkrM6kuJbB7iQIQmtZzvVw5TAvHrAR24FKIgRLDv3oLO9sJLbnsjDb9S1O/V7OSud3aSrOexQgMruclctPUOI+K8+uRhqKlA9SnLmYbVQSjTwZLDpMJgpiqPKteKsM4F1gKzaq5aOWqfFW+D9QBO8eoJcuURSmGay6rGR39sW23GQD3Fo444SK0njdbbj6MD4InWTlsIK1V8jzYheJ9HlKEAKbIXK6qpZ/HlQBpElHqSApqqytYf8T0hAtB9tiVpYIRosiP24zcEjZNotmBXJif4JEjR0+BdINdOZNhV/Hd/lwl5Jh9pYv19nEpzBvg06Jsc96NHmOPw2j6Kc5eOiYxI2KB6KgwOy1Zdyr9tBvI1DAISc4mXmFA2/Oa7CeGAZ2Dw8zeweYxyNWIAKmngQgeQ1eqKpfFvwMRwoOr13ZnVecj+G2CamrJ0yT/ysJQ+ojJSZK2yZgRJkMk8Hvt
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(136003)(346002)(39860400002)(376002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(86362001)(36756003)(38100700002)(83380400001)(107886003)(26005)(2616005)(478600001)(6486002)(66556008)(66476007)(54906003)(6916009)(6512007)(6506007)(316002)(2906002)(8936002)(8676002)(4326008)(66946007)(41300700001)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?m8wpEyJKjOUSXcXU/zG/Sa8fKAm9fytifjfp/Fbqjj6RuUiS8OuCRSqGkGFz?=
 =?us-ascii?Q?SN/6TEmGFTWBR2taehWWaTXpYAxm3RUYjvNstp7VoZ4hffKvh/6eKtpIWOIs?=
 =?us-ascii?Q?kGy/4QUBsTqwZIqV+CizAFFM2kg4l16jjATQBFAtGvZDa8EvQ9FmpFYCnPmp?=
 =?us-ascii?Q?TK7MGPHT4TLmJ/7wvgfERyynvRJHpXiFAahUffB+x7X+vSzYMGd0epGut6Aq?=
 =?us-ascii?Q?bk4ohFCSrSH43yu6aB8lSKjce04NvX2RJuhCTmqYGOxJuXKoZ9uKD6D47Pw1?=
 =?us-ascii?Q?kBwAmvLdmd9hW2OUfK/QQW0mecoDo1wvVLCHcadLmT2/a/8xXOhALIbHbnAj?=
 =?us-ascii?Q?c68ydma6XoSs8r/dJP4Wa2oyj9SboCZSw7LD/bSwc8x57ctAYJYiuUdzVpHg?=
 =?us-ascii?Q?pzPpG+jy1FYjStLniB0eRNKopTGrsmX+NEvpd6N1McRIl+kcnf7lOWtUcuY7?=
 =?us-ascii?Q?3VgI9cIwh1WtmyfIXXoixo90nN668VpVtJgLF3oVCiArIP+woKTV28Hwws8H?=
 =?us-ascii?Q?yDcgJAJxQyvpKKaXEYngIdBZuk0KAbhKVhB/OHOc3tPA8GnpWXE/5yTep/Da?=
 =?us-ascii?Q?ltn6GgHsw6otEPVeXD+1gwIPPrZ8ZSsdvKIZWss0g3HaUb0reAEax43q8Gf/?=
 =?us-ascii?Q?T0bDD65mxpt47OX4mK2VcjjZ1h7ESSQDJGqjXlDKeXkPOkcvoj4rSEvXcM1h?=
 =?us-ascii?Q?jxXP8b4+Cni99d/XL0dJ32yQMYfGn8gcf1mygazEooRBdw15Q7i6DU3bs4Ve?=
 =?us-ascii?Q?sEhs5VPVdXm2UBxZPXe6CkQ5vztc31DnSkUWOh8Ed0wfG2dIUlYeYnA20DPS?=
 =?us-ascii?Q?5RnSN1WpGWZqoB2XdEQSrz5QCr+eab1hpyWSzKFgjwezdFC49Y1nMMl2SiqZ?=
 =?us-ascii?Q?cY8Cbs+L50Fu6qNwRv4XJvgyIbN3hQImXgVyVBTS4gjXrqDMkmKBSgI4+dQx?=
 =?us-ascii?Q?framRg8GszA5pRmN6RWn2adn6HTH+rMTSVkFxYkBjqPcjx+bH3Buj6XkNfCa?=
 =?us-ascii?Q?sOR3IFNGXLklnaHEYtnJa87n2IHPL3iohsz7JZ5FhLDw7a8hVNv+Kyq8c6NA?=
 =?us-ascii?Q?mUFbCwbXjmQ761+e0UvhmOcuDMNXSb9kWBphr5t5PHxuc+0cf8jWAw2s6nE8?=
 =?us-ascii?Q?SEjkEQ/3jMn1N2rgWbAL64DiAtQisbDm8GmYoW5NmHU+S3fh9vuh5O/tIMBi?=
 =?us-ascii?Q?QzE5UKQ9RVaHYY/RnGkDqFJ29VHD/ZOVWVaNKbqpncHkJ3ImDDC2tNHraFk7?=
 =?us-ascii?Q?e2q0+TBk2d/9MsQ1oPEMTVws+PAbU/1DBxSPpiMhsEhbdv0nzKYMTXSq/ttl?=
 =?us-ascii?Q?Uzj5ipowgapyypHVncaJOwJtz6sJ65XKBLHSzUIU/ou+4IswEOqu3I+52R3l?=
 =?us-ascii?Q?I+MFylZJSIbMO2ZWA/1WI3wgmaQ8htxPiEsFcfzQXM+WVWFOby904tYYMNZp?=
 =?us-ascii?Q?hP/2EGFabJMEX1h8ZSujDKbx02wCFK0qd6Mmx3CfyHwCN6nsMlcqOCY8LY3u?=
 =?us-ascii?Q?fSsAZa5bAUSP9MgHOTvNr1RkYTkt57kFiotnEvkg4X9uRPgvnG3fMLseQQ9f?=
 =?us-ascii?Q?/06AxF0ZmIMHW9XUS+k=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20003c56-a459-4093-152b-08dbff00a08b
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2023 13:03:56.3199
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E5xk1aNX9S+L/YKqZG/aizAHPiirPpo3JlZ2Bs7YY74Lbtqwltz0AZUC3rtVOY1w
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6448

On Sat, Dec 16, 2023 at 04:26:48AM +0800, Michael Shavit wrote:

> Ok, I took a proper stab at trying to unroll the loop on the github
> version of this patch (v3+)
> As you suspected, it's not easy to re-use the unrolled version for
> both STE and CD writing as we'd have to pass in callbacks for syncing
> the STE/CD and recomputing arm_smmu_{get_ste/cd}_used. 

Yes, that is why I structured it as an iterator
> I personally find this quite a bit more readable as a sequential
> series of steps instead of a loop. It also only requires 3 STE/CD
> syncs in the worst case compared to 4 in the loop version since we

The existing version is max 3 as well, it works the same by
checking the number of critical qwords after computing the first step
in the hitless flow.

However, what you have below has the same problem as the first sketch,
it always does 3 syncs. The existing version fully minimizes the
syncs. It is why it is so complex to unroll it as you have to check
before every sync if the sync is needed at all.

This could probably be organized like this so one shared function
computes the "plan" and then a cd/ste copy executes the plan. It
avoids the loop but all the code is still basically the same, there is
just more of it.

I'm fine with any of these ways

Jason

>  static void arm_smmu_write_ste(struct arm_smmu_device *smmu, u32 sid,
>                                struct arm_smmu_ste *ste,
>                                const struct arm_smmu_ste *target)
>  {
> +       struct arm_smmu_ste staging_ste;
>         struct arm_smmu_ste target_used;
> +       int writes_required = 0;
> +       u8 staging_used_diff = 0;
> +       int i = 0;
> 
> +       /*
> +        * Compute a staging ste that has all the bits currently unused by HW
> +        * set to their target values, such that comitting it to the ste table
> +        * woudn't disrupt the hardware.
> +        */
> +       memcpy(&staging_ste, ste, sizeof(staging_ste));
> +       arm_smmu_ste_set_unused_bits(&staging_ste, target);
> +
> +       /*
> +        * Determine if it's possible to reach the target configuration from the
> +        * staged configured in a single qword write (ignoring bits that are
> +        * unused under the target configuration).
> +        */
>         arm_smmu_get_ste_used(target, &target_used);
> -               WARN_ON_ONCE(target->data[i] & ~target_used.data[i]);
> +       /*
> +        * But first sanity check that masks in arm_smmu_get_ste_used() are up
> +        * to date.
> +        */
> +       for (i = 0; i != ARRAY_SIZE(target->data); i++) {
> +               if (WARN_ON_ONCE(target->data[i] & ~target_used.data[i]))
> +                       target_used.data[i] |= target->data[i];
> +       }
> 
> +       for (i = 0; i != ARRAY_SIZE(staging_ste.data); i++) {
> +               /*
> +                * Each bit of staging_used_diff indicates the index of a qword
> +                * within the staged ste that is incorrect compared to the
> +                * target, considering only the used bits in the target
> +                */
> +               if ((staging_ste.data[i] &
> +                   target_used.data[i]) != (target->data[i]))
> +                       staging_used_diff |= 1 << i;
> +       }
> +       if (hweight8(staging_used_diff) > 1) {
> +               /*
> +                * More than 1 qword is mismatched and a hitless transition from
> +                * the current ste to the target ste is not possible. Clear the
> +                * V bit and recompute the staging STE.
> +                * Because the V bit is cleared, the staging STE will be equal
> +                * to the target STE except for the first qword.
> +                */
> +               staging_ste.data[0] &= ~cpu_to_le64(STRTAB_STE_0_V);
> +               arm_smmu_ste_set_unused_bits(&staging_ste, target);
> +               staging_used_diff = 1;
> +       }
> +
> +       /*
> +        * Commit the staging STE.
> +        */
> +       for (i = 0; i != ARRAY_SIZE(staging_ste.data); i++)
> +               WRITE_ONCE(ste->data[i], staging_ste.data[i]);
> +       arm_smmu_sync_ste_for_sid(smmu, sid);
> +
> +       /*
> +        * It's now possible to switch to the target configuration with a write
> +        * to a single qword. Make that switch now.
> +        */
> +       i = ffs(staging_used_diff) - 1;
> +       WRITE_ONCE(ste->data[i], target->data[i]);
> +       arm_smmu_sync_ste_for_sid(smmu, sid);

The non hitless flow doesn't look right to me, it should set v=0 then
load all qwords but 0 then load 0, in exactly that sequence. If the
goal is clarity then the two programming flows should be explicitly
spelled out.

Jason
