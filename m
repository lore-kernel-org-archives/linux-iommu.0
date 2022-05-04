Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66C51C433F5
	for <iommu@archiver.kernel.org>; Wed,  4 May 2022 19:09:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0C9F360B9F;
	Wed,  4 May 2022 19:09:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EtXmqvMNkjaT; Wed,  4 May 2022 19:09:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id D0D9B60AE6;
	Wed,  4 May 2022 19:08:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A2A8EC0039;
	Wed,  4 May 2022 19:08:59 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DCEF5C0032
 for <iommu@lists.linux-foundation.org>; Wed,  4 May 2022 19:08:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D951783F26
 for <iommu@lists.linux-foundation.org>; Wed,  4 May 2022 19:08:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uhNW1f9wmTqO for <iommu@lists.linux-foundation.org>;
 Wed,  4 May 2022 19:08:55 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20616.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::616])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A40BB83E32
 for <iommu@lists.linux-foundation.org>; Wed,  4 May 2022 19:08:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aDgTzftAQi1+XZHRFYjC4Eju+jCHMkmd0F9CattIkqlABCBk/oWMiM1fdWnnHIgjJhtnLhAWZ4K4JifF8ZpaOzokp7btMOkZ4NJl0nV0ao0YzoylOL7oyjElg4KRpiWSgfMkVnPWeD31kyzhZ1DRtDW8afu6JF2nsQ1dfBlTebeZmzucb4Npj8cp5VobO1gBW7rlFVIxAtltuh+BoA5ZHjWVGTHgD5qOcDSussK8pns9MYhg9EOTxgxSADRGYbnnR6FtZDt/rJVdKJ+55hfWftJhqId7L4ITQOF/zagdFJDajUU584VFZu0G7ws7li3of1AHpJCoN9rc2cEd2uaahw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rg3wxQ3zB7bHV+6VfzRKXm1Kdk39ShLAmJEfFc8n3/g=;
 b=hB+2aaZRoC9fQoBYmoBiMiKzAqvoN8eAAalZ0y/43h9vU90M+RYoCamPIUuAD0qv/6OuOlUMVC0Yyml8yewaz/ezOdvHQ3V8hXQw7Tmwdq4ImLMvBpR3FfijvqCtebPyEe95djeRjr/rtJSXa7Jh9E+3bR8NXlTelk40PzQBMsAyg7hV6ALmrFfyr9LoUtcQ4Htn06mn+AYrx6UOXnhwAKMy7C5tUQ1awvtfnTC5jWP0ofnDuhzEftLOMy4YKa1hiJhWnU0wfyssyluBGebH37RoqZ5D4OLoKn9SSRQckuDiWXrH/IUSY8hw7rU86iKUqE50EaWT1SGaTg4475NRAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rg3wxQ3zB7bHV+6VfzRKXm1Kdk39ShLAmJEfFc8n3/g=;
 b=E0LYEI5MNtTdtUFdT1W5kuvqLT3jCzCIMZJ483xbRYUM2o9GbueHAthstlRfnsL/Y4zqAWQG/bpZoEMmIqg/ICLp1ASlcAAdtmZ7avoayi0u8GpkJL2c9FAgMizPn1GOL/nc8gqk4J3MsVsL1MSKST/eZk/HeLKbBQAE5fdR1eTALaaYT9jAdhuAQqd40aRR1jyWlmYF4KXcJgUKzb7GKr8qfPG56/cujwB4gVbC9/3iu0nkNgndAD6C/WlPPeWdBxtsapsk9y70SP0J3MLrL1zS6Gt9aw2VHxeX/rGyYs2Rba0AKcoy8//iiDzxLrMIzy86JIGjcjWKX7TEaO+saA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by CY5PR12MB6180.namprd12.prod.outlook.com (2603:10b6:930:23::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24; Wed, 4 May
 2022 19:08:51 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2%6]) with mapi id 15.20.5206.025; Wed, 4 May 2022
 19:08:51 +0000
To: iommu@lists.linux-foundation.org, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>
Subject: [PATCH v2] iommu: iommu_group_claim_dma_owner() must always assign a
 domain
Date: Wed,  4 May 2022 16:08:50 -0300
Message-Id: <0-v2-f62259511ac0+6-iommu_dma_block_jgg@nvidia.com>
X-ClientProxiedBy: BL0PR02CA0057.namprd02.prod.outlook.com
 (2603:10b6:207:3d::34) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eace137f-b356-4a14-e11b-08da2e018690
X-MS-TrafficTypeDiagnostic: CY5PR12MB6180:EE_
X-Microsoft-Antispam-PRVS: <CY5PR12MB6180D09A936B4D60BAC1E364C2C39@CY5PR12MB6180.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lbEHtFm0p2I/MNWM96tKuCixDx0Rh7CmY0tBliDxi5b9ezEkRT+ZR9+fMy0IqKg0gclvqol6SVqtas+ACZjlV0D5e4ufYFsKnT1bnfSrjIkxCoapfeGGmgqx1g1juYHuqhIipxiQBU+++xtpv3wGGZSQPtSA78aBeeHiTZkCcn5XBzk57uneKyj1p0Qhj5kaGhsH600VdHdcapgGR7TSCyn0QkCe0+BFXhEB9Er/9WwSN5sG8KIc5RTu6zHAFHcgHE74OlKu0aBETSAyVc8vB/sqmLygxW9wdouAydM8WSZt65ApCsJ/ZBm49c1b+uAq00dpaS22hS+NN/lrhimGHqxi5eHBYPt0DwX1sH3VSMT+PKaeeF2Fx8em2NNgXK7eztGpwEgk9wDTtcv3E61UWi+GTJQZJrLca80PIWg50XQTXXU5hesKAVEFDPc6prlnw5eDLcVhQgj3f++HMypl1ehn/+T4h1TT+x8x6lYoHMVVTZn4ef2XFzcAlcPmAeThAM1TSUxY7NLRLhCCgGtMY7FRUfa3Nq5aQDvt6fW8qKxLJnRiQH3+gfSFNs/fGuUbTFVACbL7k4Oh3klZJaPCR4anoI+l0umaHDtwOb1Jr7w4oXFvlDpFYTUNZt33zT1rtz7QLm8BHVVeANPgJmcY+KJPS5fHvL1R6KWw7HyyRSJZ8JIL+dz4BvyO6nI4OwluQnVUWSgabA/3YJq145NWvQqLkmu9GShPLwJc0txmq6LwTAml1BmjjKGWWvWaiSvzqmtOf610qJGVWf3O/5R59nvbc5bkMG0P0Zg880cMzgM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4192.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(2906002)(26005)(6506007)(86362001)(6512007)(38100700002)(508600001)(8936002)(6486002)(36756003)(5660300002)(8676002)(83380400001)(66476007)(66946007)(66556008)(4326008)(966005)(316002)(186003)(110136005)(54906003)(2616005)(4216001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RrtxYGv6s8w/vROtSOcqO0T9R7IZVNfYCHQFCAKrOevmcER7CWYjVkq8qbvk?=
 =?us-ascii?Q?A7I6MORqV6dwhCoGNP9ZC2hcFmukP+N0O/os4H6ku7BXkWglHWbZOx1KtT0f?=
 =?us-ascii?Q?+zCGBMP/ro3eWoaROHw7NT0nl3MOIlLQsFcm3njmLU8J7xoh9aRKVTfmznWT?=
 =?us-ascii?Q?9tqA6Mfem4iWfSzBd2yM22rx0dFOhIAYLtsKIA4iANM5c9pSzVjrbeqgtZU2?=
 =?us-ascii?Q?umQ9KuCy7GjBYd6KroLChL/exbH8cJ0inklES5Kf+im3XbWIvYkHTdoVe4gm?=
 =?us-ascii?Q?wEpFLwn8HiXNUJfl6wBut98EW6rBLoODiJ6qXHZixAu2fP9Ou2CBpLBc5aT6?=
 =?us-ascii?Q?FgIBPkyJZm69mjYN5Z62lH8vgg/n1kOEK7mGSYZbJjyQO8pH9o+Aik/Gnawq?=
 =?us-ascii?Q?cCBp8aalmHZE+KTSHMDtU6WeOFIyHobVEVeheYOZgDQsJgM/3QUdeXg3/xSf?=
 =?us-ascii?Q?zW5/Xpkf+Oe9i1Ct+216itMKlUlBlzQdkdSV/sXp8TffpAnqiQcz+Me5rl7G?=
 =?us-ascii?Q?Gn4LK/PfHVqdsLkE2Z1d6sdDBSTWaD+Me/6oKiVeV7hoJIGACUzUg3pz7RF+?=
 =?us-ascii?Q?OZ4s/evTZyd9Kvo1fI4lleEREvKumTRGEF5WKaBS6GUuH06trtpPOmGk+oI/?=
 =?us-ascii?Q?HwkMtzivfA8oc20jG+yju+mRJpb/Q/Ka/3/Xoj6qg3sl/hjFaay4EgNzFWLl?=
 =?us-ascii?Q?3vLj7gwUoJENybc4AjHv3b1EeO4lQx6/jMRRj6g0tQe9e4qcFBzv+mU+xiZN?=
 =?us-ascii?Q?a5eOEix9XHYAwavsnOjnWO3cECUbdhBMQwu3oDkRPP+Acy8EyOONx6QLfG5y?=
 =?us-ascii?Q?wDqrqLVeY2P0RAK9ZJE1L/gjhfwpwSVLxLbVuWWc4F7evf4w4a6xc7+oY7Fz?=
 =?us-ascii?Q?33YSkXmDEO/6Wl4SBa8YxNe2AszqjgocCgCB3Bk5TDyHyKuI9thJ0XX7rz6J?=
 =?us-ascii?Q?DpICQgr7LGP4q5JhNvoIiYVdk0x1r1BdGCNY3aQgdnNFpdafnlWnC9Ll64PJ?=
 =?us-ascii?Q?ijjrZkDL2v24GeS6ZEHIIIj+sscOe0IpMsVE7mYGIgWVum1OQ8Qxbzm7Vngy?=
 =?us-ascii?Q?uh1z/FgGozuPkPjPGccx+Uf7I9e3AC6og14va6OCLE3esd/FOhwyDyuyEhwA?=
 =?us-ascii?Q?ye++YDgzrE4fgTN33z9PdemCMfaHGAD1yqbw+OCoEnRXnYuG0efLTkVoGQb2?=
 =?us-ascii?Q?uNYSHeRmzEJwjdmQghy+tFPeL9ZKpm7VBJSUP7o8g61kV8OefXzbQ0Xn7XvF?=
 =?us-ascii?Q?vu8e0ua5YdbAW37qjKD+tMnJ7HL6Kh6C3Fnnhv47QjSW/HxWsmKBR0IDFKPN?=
 =?us-ascii?Q?Qas7rMYp84DAXrKDit3l6TGHwWhu9+XHNZQYMxXH89gdeiDsPPD8ILkaCJxu?=
 =?us-ascii?Q?QRMhnak6QBS0TeXA1YeVg+NJEWcwJNovDoAFHx5NkLdYoJaMwHHJmlCMwjR7?=
 =?us-ascii?Q?iyu8HLe4qC+8vluJfNP6ctM4WoBehx3n2sUsmxUve1ZGP3h9ut1FKM245Fhj?=
 =?us-ascii?Q?kMvUOOJRVtMK1jzD5eUroFRAUog9ZXbNmNOMaFmDU3907EQ39ErcmCSNtUgL?=
 =?us-ascii?Q?jUIc7n0eyp3DrMDx0DN4Zcp4jQlrKWk5Wybi5OX5r2Uq93y+VWoAiSltYENw?=
 =?us-ascii?Q?M5DdKI0+TWW52T9cQ6b+U3iwx/cHtPkECD8aUx3gw0PQ0J9eoK5WR+5zoiHg?=
 =?us-ascii?Q?Ewjf1A8tLGp02nUaXZKJedVydZwkF3216lymUso75ImwQRRU17rcnSYa8f6X?=
 =?us-ascii?Q?tZ+vS8yVYw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eace137f-b356-4a14-e11b-08da2e018690
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2022 19:08:51.5395 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yz9G47yliwSjVlblk+AzWzd0dFpm8prqz9qxU6Hb5NOqtx9e+PL9vyO1jT6wUODp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6180
Cc: Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <jroedel@suse.de>,
 Qian Cai <quic_qiancai@quicinc.com>, Robin Murphy <robin.murphy@arm.com>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
From: Jason Gunthorpe via iommu <iommu@lists.linux-foundation.org>
Reply-To: Jason Gunthorpe <jgg@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Once the group enters 'owned' mode it can never be assigned back to the
default_domain or to a NULL domain. It must always be actively assigned to
a current domain. If the caller hasn't provided a domain then the core
must provide an explicit DMA blocking domain that has no DMA map.

Lazily create a group-global blocking DMA domain when
iommu_group_claim_dma_owner is first called and immediately assign the
group to it. This ensures that DMA is immediately fully isolated on all
IOMMU drivers.

If the user attaches/detaches while owned then detach will set the group
back to the blocking domain.

Slightly reorganize the call chains so that
__iommu_group_attach_core_domain() is the function that removes any caller
configured domain and sets the domains back a core owned domain with an
appropriate lifetime.

__iommu_group_attach_domain() is the worker function that can change the
domain assigned to a group to any target domain, including NULL.

Add comments clarifying how the NULL vs detach_dev vs default_domain works
based on Robin's remarks.

This fixes an oops with VFIO and SMMUv3 because VFIO will call
iommu_detach_group() and then immediately iommu_domain_free(), but
SMMUv3 has no way to know that the domain it is holding a pointer to
has been freed. Now the iommu_detach_group() will assign the blocking
domain and SMMUv3 will no longer hold a stale domain reference.

Fixes: 1ea2a07a532b ("iommu: Add DMA ownership management interfaces")
Reported-by: Qian Cai <quic_qiancai@quicinc.com>
Tested-by: Baolu Lu <baolu.lu@linux.intel.com>
Tested-by: Nicolin Chen <nicolinc@nvidia.com>
Co-developed-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommu.c | 122 ++++++++++++++++++++++++++++++------------
 1 file changed, 87 insertions(+), 35 deletions(-)

Joerg, this should address the issue, Nicolin reproduced the original issue
and verified this fix on ARM SMMUv3.

v2:
 - Remove redundant detach_dev ops check in __iommu_detach_device and
   make the added WARN_ON fail instead
 - Check for blocking_domain in __iommu_attach_group() so VFIO can
   actually attach a new group
 - Update comments and spelling
 - Fix missed change to new_domain in iommu_group_do_detach_device()
v1: https://lore.kernel.org/r/0-v1-6e9d2d0a759d+11b-iommu_dma_block_jgg@nvidia.com

Thanks,
Jason

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 0c42ece2585406..c1bdec807ea381 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -44,6 +44,7 @@ struct iommu_group {
 	char *name;
 	int id;
 	struct iommu_domain *default_domain;
+	struct iommu_domain *blocking_domain;
 	struct iommu_domain *domain;
 	struct list_head entry;
 	unsigned int owner_cnt;
@@ -82,8 +83,7 @@ static int __iommu_attach_device(struct iommu_domain *domain,
 				 struct device *dev);
 static int __iommu_attach_group(struct iommu_domain *domain,
 				struct iommu_group *group);
-static void __iommu_detach_group(struct iommu_domain *domain,
-				 struct iommu_group *group);
+static void __iommu_group_attach_core_domain(struct iommu_group *group);
 static int iommu_create_device_direct_mappings(struct iommu_group *group,
 					       struct device *dev);
 static struct iommu_group *iommu_group_get_for_dev(struct device *dev);
@@ -596,6 +596,8 @@ static void iommu_group_release(struct kobject *kobj)
 
 	if (group->default_domain)
 		iommu_domain_free(group->default_domain);
+	if (group->blocking_domain)
+		iommu_domain_free(group->blocking_domain);
 
 	kfree(group->name);
 	kfree(group);
@@ -1963,9 +1965,6 @@ static void __iommu_detach_device(struct iommu_domain *domain,
 	if (iommu_is_attach_deferred(dev))
 		return;
 
-	if (unlikely(domain->ops->detach_dev == NULL))
-		return;
-
 	domain->ops->detach_dev(domain, dev);
 	trace_detach_device_from_domain(dev);
 }
@@ -1979,12 +1978,10 @@ void iommu_detach_device(struct iommu_domain *domain, struct device *dev)
 		return;
 
 	mutex_lock(&group->mutex);
-	if (iommu_group_device_count(group) != 1) {
-		WARN_ON(1);
+	if (WARN_ON(domain != group->domain) ||
+	    WARN_ON(iommu_group_device_count(group) != 1))
 		goto out_unlock;
-	}
-
-	__iommu_detach_group(domain, group);
+	__iommu_group_attach_core_domain(group);
 
 out_unlock:
 	mutex_unlock(&group->mutex);
@@ -2040,7 +2037,8 @@ static int __iommu_attach_group(struct iommu_domain *domain,
 {
 	int ret;
 
-	if (group->domain && group->domain != group->default_domain)
+	if (group->domain && group->domain != group->default_domain &&
+	    group->domain != group->blocking_domain)
 		return -EBUSY;
 
 	ret = __iommu_group_for_each_dev(group, domain,
@@ -2072,38 +2070,68 @@ static int iommu_group_do_detach_device(struct device *dev, void *data)
 	return 0;
 }
 
-static void __iommu_detach_group(struct iommu_domain *domain,
-				 struct iommu_group *group)
+static int __iommu_group_attach_domain(struct iommu_group *group,
+				       struct iommu_domain *new_domain)
 {
 	int ret;
 
+	if (group->domain == new_domain)
+		return 0;
+
 	/*
-	 * If the group has been claimed already, do not re-attach the default
-	 * domain.
+	 * New drivers should support default domains and so the detach_dev() op
+	 * will never be called. Otherwise the NULL domain indicates the
+	 * translation for the group should be set so it will work with the
+	 * platform DMA ops.
 	 */
-	if (!group->default_domain || group->owner) {
-		__iommu_group_for_each_dev(group, domain,
+	if (!new_domain) {
+		if (WARN_ON(!group->domain->ops->detach_dev))
+			return -EINVAL;
+		__iommu_group_for_each_dev(group, group->domain,
 					   iommu_group_do_detach_device);
 		group->domain = NULL;
-		return;
+		return 0;
 	}
 
-	if (group->domain == group->default_domain)
-		return;
-
-	/* Detach by re-attaching to the default domain */
-	ret = __iommu_group_for_each_dev(group, group->default_domain,
+	/*
+	 * Changing the domain is done by calling attach on the new domain.
+	 * Drivers should implement this so that DMA is always translated by
+	 * either the new, old, or a blocking domain. DMA should never become
+	 * untranslated.
+	 *
+	 * Note that this is called in error unwind paths, attaching to a
+	 * domain that has already been attached cannot fail.
+	 */
+	ret = __iommu_group_for_each_dev(group, new_domain,
 					 iommu_group_do_attach_device);
-	if (ret != 0)
-		WARN_ON(1);
+	if (ret)
+		return ret;
+	group->domain = new_domain;
+	return 0;
+}
+
+/*
+ * Put the group's domain back to the appropriate core-owned domain - either the
+ * standard kernel-mode DMA configuration or an all-DMA-blocked domain.
+ */
+static void __iommu_group_attach_core_domain(struct iommu_group *group)
+{
+	struct iommu_domain *new_domain;
+	int ret;
+
+	if (group->owner)
+		new_domain = group->blocking_domain;
 	else
-		group->domain = group->default_domain;
+		new_domain = group->default_domain;
+
+	ret = __iommu_group_attach_domain(group, new_domain);
+	WARN(ret, "iommu driver failed to attach the default/blocking domain");
 }
 
 void iommu_detach_group(struct iommu_domain *domain, struct iommu_group *group)
 {
 	mutex_lock(&group->mutex);
-	__iommu_detach_group(domain, group);
+	__iommu_group_attach_core_domain(group);
 	mutex_unlock(&group->mutex);
 }
 EXPORT_SYMBOL_GPL(iommu_detach_group);
@@ -3088,6 +3116,29 @@ void iommu_device_unuse_default_domain(struct device *dev)
 	iommu_group_put(group);
 }
 
+static int __iommu_group_alloc_blocking_domain(struct iommu_group *group)
+{
+	struct group_device *dev =
+		list_first_entry(&group->devices, struct group_device, list);
+
+	if (group->blocking_domain)
+		return 0;
+
+	group->blocking_domain =
+		__iommu_domain_alloc(dev->dev->bus, IOMMU_DOMAIN_BLOCKED);
+	if (!group->blocking_domain) {
+		/*
+		 * For drivers that do not yet understand IOMMU_DOMAIN_BLOCKED
+		 * create an empty domain instead.
+		 */
+		group->blocking_domain = __iommu_domain_alloc(
+			dev->dev->bus, IOMMU_DOMAIN_UNMANAGED);
+		if (!group->blocking_domain)
+			return -EINVAL;
+	}
+	return 0;
+}
+
 /**
  * iommu_group_claim_dma_owner() - Set DMA ownership of a group
  * @group: The group.
@@ -3111,9 +3162,15 @@ int iommu_group_claim_dma_owner(struct iommu_group *group, void *owner)
 			goto unlock_out;
 		}
 
+		ret = __iommu_group_alloc_blocking_domain(group);
+		if (ret)
+			goto unlock_out;
+
+		ret = __iommu_group_attach_domain(group,
+						  group->blocking_domain);
+		if (ret)
+			goto unlock_out;
 		group->owner = owner;
-		if (group->domain)
-			__iommu_detach_group(group->domain, group);
 	}
 
 	group->owner_cnt++;
@@ -3137,13 +3194,8 @@ void iommu_group_release_dma_owner(struct iommu_group *group)
 		goto unlock_out;
 
 	group->owner_cnt = 0;
-	/*
-	 * The UNMANAGED domain should be detached before all USER
-	 * owners have been released.
-	 */
-	if (!WARN_ON(group->domain) && group->default_domain)
-		__iommu_attach_group(group->default_domain, group);
 	group->owner = NULL;
+	__iommu_group_attach_core_domain(group);
 unlock_out:
 	mutex_unlock(&group->mutex);
 }

base-commit: dc7afe17339c2f5de8c377aaa0b976139a19e158
-- 
2.36.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
