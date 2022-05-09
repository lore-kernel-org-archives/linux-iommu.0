Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5798DC433EF
	for <iommu@archiver.kernel.org>; Mon,  9 May 2022 16:19:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id F2C1D40525;
	Mon,  9 May 2022 16:19:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DUgBXgoySe4j; Mon,  9 May 2022 16:19:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 4119940104;
	Mon,  9 May 2022 16:19:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 23EB3C0039;
	Mon,  9 May 2022 16:19:27 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D8D12C002D
 for <iommu@lists.linux-foundation.org>; Mon,  9 May 2022 16:19:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C5BC760AEA
 for <iommu@lists.linux-foundation.org>; Mon,  9 May 2022 16:19:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jy0exwog-o_u for <iommu@lists.linux-foundation.org>;
 Mon,  9 May 2022 16:19:24 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2060e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::60e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 363F1605EA
 for <iommu@lists.linux-foundation.org>; Mon,  9 May 2022 16:19:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C6OagS35dyiINByS8Qd3mUt9eir2mcfXYm5DV4uAy6W6pYS7Ly9Sd1wP4QpgFr5T6uwB0UGrgN1wapfCdHxDahpvLvV67LetMIpj/mPeI1LDHohZJM57QX2bSxF5W1GmB+OA+WsHdFiNLbYWaFY2hNAR00xWqkSpndrRPPtWpMdTLU8j4nI2wDfyczw3xNNTJDxLNxzsYLaDDIJ+w6c4JWhLJlf3FuAW8C5I5OK+Onm1Mw+QBkPFlVsxXQQhtF6orWz2Wc6YLHTbN4s7PPvnL4jkDEhxaEUYRHHoDVAOW9Fq3hPFIiUQM+odAEiy0/CgWdvLv61z5+/5SdOeo6BgIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bsSE0xNlqjeytL6u3lQqqdQYS5VsIEYhW1f7+We4QS4=;
 b=Yo4jNBtH+iu/pAEv1MuN8JrMunWQNWcbkmCFEeoaTPvcdJzhTwMeRXITTWMkVR15u5Jn9enpkrX/wqfDBRJJXvLw+rj2TimD1oHozoW3SPx17dnv11cy4rIdfczgZRzdrfkr62sVRbTFxcEgiZGd/WkY6oSgH7aMlBq2YBN9KyYIcUYjLJROIp/Vrs5u9daEwdZKB0lB0gMH//1Oce6U+xojTEPGkgfCEjlJ86UTB5JgnonEHN2+jV4gwwZxwqRCWfmTO8j/IH9uexu9YtEzkrGxcWLWQo7QkR8TG0mKmJNP5qaSsBRMkesEwuk3Z2giFAC7/qicIVoo83b4MFsmPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bsSE0xNlqjeytL6u3lQqqdQYS5VsIEYhW1f7+We4QS4=;
 b=CajuCguaVx936cMoh+dQ6wL7nViDXjcN29uRunC2I4H1lOKKszVxWYriogykohaekYAljTTcjytDO2OuEJojIlA9MZzYIRN+bQAMoWBaYypAK2RHc3aXqaD3KyL9bf4oIkdJ6D3D9rHRqmRfmKc5ACcbuocLCXX8l1q1BWnHHf3brSMAuRmQs7G3qWi0zv64UKEjwYqnr0vF9B64uBFtxi5ADPvMGiu+vAgcAAX8fL6lxtfdJyTueSJH/3SRxuuHScWekLd5NJlmyGQkCmD+iriMiK5+Ak65G/ViNBQQxMMl+3APuU8s+OIH9NlC7GrWZtKQVx5lnH/k1teGTT1eDQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by DM6PR12MB4172.namprd12.prod.outlook.com (2603:10b6:5:212::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.22; Mon, 9 May
 2022 16:19:21 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2%5]) with mapi id 15.20.5227.023; Mon, 9 May 2022
 16:19:21 +0000
To: iommu@lists.linux-foundation.org, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>
Subject: [PATCH v3] iommu: iommu_group_claim_dma_owner() must always assign a
 domain
Date: Mon,  9 May 2022 13:19:19 -0300
Message-Id: <0-v3-db7f0785022b+149-iommu_dma_block_jgg@nvidia.com>
X-ClientProxiedBy: MN2PR15CA0056.namprd15.prod.outlook.com
 (2603:10b6:208:237::25) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 33fd9fc3-26d0-4677-0004-08da31d7ac84
X-MS-TrafficTypeDiagnostic: DM6PR12MB4172:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB41721FAB1C11EEF20ACB2265C2C69@DM6PR12MB4172.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1q4NNzZpjoZx5hEC5TpwqBos7qF++tF28CugzAVyquv4vbryuwW6NHi7rU3S8IpG3YcJz4AmZxDvq/kvWTudpejWvmXY+C25gA6QXfQ7Tew4ANYC5LPSh7eDyxKHc21HP/aTpcXZjCdm562oofgcIIgl8oti+rCliM08vSR+ZTNh3ZqxkMWiV7ig1p1BIwWCpuvDRRVd3ucW/9A+f88xMcQP+7CL93FfQb1IvOoFbDOoePqlm/2bTsQqIoUovX7BnX6sY+GSzCPXsG7Z1w0YjxuaaEzoLtfIhIn2hQ2uqnoGocxId9F1ZrtRewzClU/Y+lPYs74+DbjiRdjeftz5hlT+4kSkGKFIXdfv2665sAfkKyCOG05LlIsnKhy5KBQVOKcLJePKJQHe/AU7wFVD3Nyz3B6PNtoexInxGilyt6ikg10dXks7dyURvVqQazHXlfbKx2UHEv+ric31GmcgIqHF/aBKEiDiYNUrApIAnwpidZOU3fkyf86Q55LLNpRsCjoOGWsFJIiqj6ZRJFWELBHUGztsFdjM2Al1pZbz9F7n+l4L0m/N1p1pmDvdc6pKJJgonPLolVOk/0g7qnfisgA+mk5MWcjP9OWrDPqtEdscBhMVqwMRSU+gxeCnZT6kmTef9+L5ko3ownEoBI0DVrl8Oa1P7mFmEPkUJBIb5RSWxc2hZw8F5CzakRavxc+sjUW4AZE7r1AAhmLVANjCGPuI7ML6KslwdgltUDRa5u20EoaYPDV0U2Mz90wlF3CAazlA3bdnfoJ8Uovzq/+iUaLIMGys5RKrcrIDZf5A4EZcOvtFhZ/ZzHHqZhdIDRw9Pq4EgFM2KZQ2F/5DQeNSuA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4192.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(66946007)(8676002)(66476007)(2616005)(66556008)(8936002)(508600001)(83380400001)(186003)(26005)(966005)(6486002)(86362001)(6512007)(6506007)(54906003)(316002)(110136005)(4326008)(2906002)(36756003)(5660300002)(38100700002)(4216001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?V2lHS4zg8g5Q7HpBdyrvO6f4e1liCS5QfT8xJyMNEHIiOwFHU56w7gCKym6N?=
 =?us-ascii?Q?71fexQMhCmU5H8p/FSqK6L9Tk5YZjEzTL+yHKdiKsHps8dXRvLVTE9O6GNyV?=
 =?us-ascii?Q?piJM8wNlMrntJCOhRVlYs8V/q3LmigvE2CXJBntSk7D/7Xo4DsB15ryOngIS?=
 =?us-ascii?Q?kn2QsB3Ag8kMac6jZE/3bSwMHqtOaupJ66Tbg5g0RkIlifF7t3XuFGXV29Jo?=
 =?us-ascii?Q?B0Bg58csujpTmy3NuIlg2GIgIG957TUaRwmK1dnN1wwl8zBSEhCGyMcal9zD?=
 =?us-ascii?Q?TlmMIfe17HAps0dmRYbtyzxyKhx0DYNPSEbOro0+ITUiiEmD+zZtGZOdP8Ae?=
 =?us-ascii?Q?VdJn7gUtnFDDp+ImnFr+bbbNAEPa/SzkmMWjXVf/EJFiGzQ7lgx3fZ9no0Rz?=
 =?us-ascii?Q?dMAVn/PNB35zyXgqDNEqMEdF44kYoRY0P3F2lQMWtKgsgiGKhBVf/eHyZu4a?=
 =?us-ascii?Q?putBFm0keeXw0QST0DwuOJMPdDwg6zrnDLP3yvaJK9DpTNQsTfeAqrujg39C?=
 =?us-ascii?Q?tm0J3AMNZcPUfjXT/cTeJO9NJBGc4C6qkvnRQO9N/v/8sykeLP+z2Tg4Gxu5?=
 =?us-ascii?Q?+DlgLLoaswEMX7xH+fG4jAx8BbPex5JlOt6qsOmzLbfOUj7TLJ5K22Fa2BTH?=
 =?us-ascii?Q?jh4eV6GzbpTAI94S0jmRz1gpS5rzv+hLj+4QJInjZITAKHH+I0ET1C/nOZxa?=
 =?us-ascii?Q?wFvyJBiaqUESvMllWcWCQ6JfNk8RdcvyIgKnFmewUmVCvCUFksaxm6wRksfZ?=
 =?us-ascii?Q?/bvJMaNdUY4V8E3WUvwKGdCtfYlMgkf5VO7zYnCWc0jEXgFV9hs1fRc+eU16?=
 =?us-ascii?Q?Zp8qVuX+KhBrbkxT+xSXwqskG/O8dqgJdNXTPj9NTioGPfZZ3zLSRzMX8Tep?=
 =?us-ascii?Q?1OTgTx15vDCoSFl9zsuzkMRLfAMHVSBmYvZKMPPFUVibNNTSySvZjbspAgPX?=
 =?us-ascii?Q?USkXgZk7YnrBs6zvBjjeoUQUZijpYhCMSDb9gnNlqi2z98hWh+T9s8eFYXV9?=
 =?us-ascii?Q?j5Bdr4wjYz4lomzSsgSGHRa+63uenIXrTEG06uz9IeMPL2/8x7vjRLwXUYgC?=
 =?us-ascii?Q?Df3cQg8esVwq+luBmgsaeF14W+Q524sEqdN8BTUmmHD7A2r3Bbpvx3DKPzqo?=
 =?us-ascii?Q?tnx0EKqfODRCZfh9GPuknMPMoOvVAfnYony5ZyZBbvhQVsMWcNGMtUZ+GYrp?=
 =?us-ascii?Q?ROafgPnZ6ahOIy2KhH9p/RfGHZumWsFRkZL/cKmSv6mO//+I+Y+p7IJztEuA?=
 =?us-ascii?Q?eDsOq9pdKK8C81v/aBcI2ANTt9DmqDsB3srTUcsf+pOcoqzIVGinmSstV1/W?=
 =?us-ascii?Q?4+aWKels9J5fE0wQv2HopQhfJhS9xVAGaHF0ysQh69OLO4Nl5nao3X4qZjBg?=
 =?us-ascii?Q?Iulvvs8y6FWqUKpR41BLDYXIIL73M/szNaujuZFO+3MgSYDOYqbv6ySNyS+J?=
 =?us-ascii?Q?RY/2cTAFCUysg27u1DRBK47aXN/G9yjUKFTdC+HgYTzRJ5EHmuTXK+7gFeoi?=
 =?us-ascii?Q?XUafjAcUlIUEGiELVWa1s090eDVcEDR+Ex9pYGdVUu+/O3y8bqsuN6cIceA0?=
 =?us-ascii?Q?d3ScGMVSNoYfynRsEiXoM2m8CHfqPweif8gwLzz0LK0e6zbjO1gNJN6pJY+m?=
 =?us-ascii?Q?7frg9Mb5x9zDdvr4V5hgj9oYEXSAzWaW4hmgyej7ODwENQlmYjQolMDwqSqP?=
 =?us-ascii?Q?AhP6ELA8erKgpqw4cYoEznHETk9PYqVRQJXmWk0vtObzTpvOOqsuBpfFnK3J?=
 =?us-ascii?Q?Q5TT44htzQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33fd9fc3-26d0-4677-0004-08da31d7ac84
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2022 16:19:20.9970 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9oVUYTZLcF2zx/yKsdy4XkHLtfHxa89kiajMgUYwEBiJeCjer2ouc14zpjp0MR+V
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4172
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
__iommu_group_set_core_domain() is the function that removes any caller
configured domain and sets the domains back a core owned domain with an
appropriate lifetime.

__iommu_group_set_domain() is the worker function that can change the
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
--

Just minor polishing as discussed

v3:
 - Change names to __iommu_group_set_domain() /
   __iommu_group_set_core_domain()
 - Clarify comments
 - Call __iommu_group_set_domain() directly in
   iommu_group_release_dma_owner() since we know it is always selecting
   the default_domain
v2: https://lore.kernel.org/r/0-v2-f62259511ac0+6-iommu_dma_block_jgg@nvidia.com
 - Remove redundant detach_dev ops check in __iommu_detach_device and
   make the added WARN_ON fail instead
 - Check for blocking_domain in __iommu_attach_group() so VFIO can
   actually attach a new group
 - Update comments and spelling
 - Fix missed change to new_domain in iommu_group_do_detach_device()
v1: https://lore.kernel.org/r/0-v1-6e9d2d0a759d+11b-iommu_dma_block_jgg@nvidia.com

---
 drivers/iommu/iommu.c | 127 ++++++++++++++++++++++++++++++------------
 1 file changed, 91 insertions(+), 36 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 0c42ece2585406..0b22e51e90f416 100644
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
@@ -82,8 +83,8 @@ static int __iommu_attach_device(struct iommu_domain *domain,
 				 struct device *dev);
 static int __iommu_attach_group(struct iommu_domain *domain,
 				struct iommu_group *group);
-static void __iommu_detach_group(struct iommu_domain *domain,
-				 struct iommu_group *group);
+static int __iommu_group_set_domain(struct iommu_group *group,
+				    struct iommu_domain *new_domain);
 static int iommu_create_device_direct_mappings(struct iommu_group *group,
 					       struct device *dev);
 static struct iommu_group *iommu_group_get_for_dev(struct device *dev);
@@ -596,6 +597,8 @@ static void iommu_group_release(struct kobject *kobj)
 
 	if (group->default_domain)
 		iommu_domain_free(group->default_domain);
+	if (group->blocking_domain)
+		iommu_domain_free(group->blocking_domain);
 
 	kfree(group->name);
 	kfree(group);
@@ -1907,6 +1910,24 @@ void iommu_domain_free(struct iommu_domain *domain)
 }
 EXPORT_SYMBOL_GPL(iommu_domain_free);
 
+/*
+ * Put the group's domain back to the appropriate core-owned domain - either the
+ * standard kernel-mode DMA configuration or an all-DMA-blocked domain.
+ */
+static void __iommu_group_set_core_domain(struct iommu_group *group)
+{
+	struct iommu_domain *new_domain;
+	int ret;
+
+	if (group->owner)
+		new_domain = group->blocking_domain;
+	else
+		new_domain = group->default_domain;
+
+	ret = __iommu_group_set_domain(group, new_domain);
+	WARN(ret, "iommu driver failed to attach the default/blocking domain");
+}
+
 static int __iommu_attach_device(struct iommu_domain *domain,
 				 struct device *dev)
 {
@@ -1963,9 +1984,6 @@ static void __iommu_detach_device(struct iommu_domain *domain,
 	if (iommu_is_attach_deferred(dev))
 		return;
 
-	if (unlikely(domain->ops->detach_dev == NULL))
-		return;
-
 	domain->ops->detach_dev(domain, dev);
 	trace_detach_device_from_domain(dev);
 }
@@ -1979,12 +1997,10 @@ void iommu_detach_device(struct iommu_domain *domain, struct device *dev)
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
+	__iommu_group_set_core_domain(group);
 
 out_unlock:
 	mutex_unlock(&group->mutex);
@@ -2040,7 +2056,8 @@ static int __iommu_attach_group(struct iommu_domain *domain,
 {
 	int ret;
 
-	if (group->domain && group->domain != group->default_domain)
+	if (group->domain && group->domain != group->default_domain &&
+	    group->domain != group->blocking_domain)
 		return -EBUSY;
 
 	ret = __iommu_group_for_each_dev(group, domain,
@@ -2072,38 +2089,49 @@ static int iommu_group_do_detach_device(struct device *dev, void *data)
 	return 0;
 }
 
-static void __iommu_detach_group(struct iommu_domain *domain,
-				 struct iommu_group *group)
+static int __iommu_group_set_domain(struct iommu_group *group,
+				    struct iommu_domain *new_domain)
 {
 	int ret;
 
+	if (group->domain == new_domain)
+		return 0;
+
 	/*
-	 * If the group has been claimed already, do not re-attach the default
-	 * domain.
+	 * New drivers should support default domains and so the detach_dev() op
+	 * will never be called. Otherwise the NULL domain represents some
+	 * platform specific behavior.
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
+	 * Changing the domain is done by calling attach_dev() on the new
+	 * domain. This switch does not have to be atomic and DMA can be
+	 * discarded during the transition. DMA must only be able to access
+	 * either new_domain or group->domain, never something else.
+	 *
+	 * Note that this is called in error unwind paths, attaching to a
+	 * domain that has already been attached cannot fail.
+	 */
+	ret = __iommu_group_for_each_dev(group, new_domain,
 					 iommu_group_do_attach_device);
-	if (ret != 0)
-		WARN_ON(1);
-	else
-		group->domain = group->default_domain;
+	if (ret)
+		return ret;
+	group->domain = new_domain;
+	return 0;
 }
 
 void iommu_detach_group(struct iommu_domain *domain, struct iommu_group *group)
 {
 	mutex_lock(&group->mutex);
-	__iommu_detach_group(domain, group);
+	__iommu_group_set_core_domain(group);
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
@@ -3111,9 +3162,14 @@ int iommu_group_claim_dma_owner(struct iommu_group *group, void *owner)
 			goto unlock_out;
 		}
 
+		ret = __iommu_group_alloc_blocking_domain(group);
+		if (ret)
+			goto unlock_out;
+
+		ret = __iommu_group_set_domain(group, group->blocking_domain);
+		if (ret)
+			goto unlock_out;
 		group->owner = owner;
-		if (group->domain)
-			__iommu_detach_group(group->domain, group);
 	}
 
 	group->owner_cnt++;
@@ -3132,18 +3188,17 @@ EXPORT_SYMBOL_GPL(iommu_group_claim_dma_owner);
  */
 void iommu_group_release_dma_owner(struct iommu_group *group)
 {
+	int ret;
+
 	mutex_lock(&group->mutex);
 	if (WARN_ON(!group->owner_cnt || !group->owner))
 		goto unlock_out;
 
 	group->owner_cnt = 0;
-	/*
-	 * The UNMANAGED domain should be detached before all USER
-	 * owners have been released.
-	 */
-	if (!WARN_ON(group->domain) && group->default_domain)
-		__iommu_attach_group(group->default_domain, group);
 	group->owner = NULL;
+	ret = __iommu_group_set_domain(group, group->default_domain);
+	WARN(ret, "iommu driver failed to attach the default domain");
+
 unlock_out:
 	mutex_unlock(&group->mutex);
 }

base-commit: da844db4722bdd333142b40f0e414e2aedc2a4c0
-- 
2.36.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
