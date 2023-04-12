Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2083.outbound.protection.outlook.com [40.107.223.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D5315696;
	Wed, 12 Apr 2023 13:52:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VnbBnaFYmmAOQDCCWkN2z0GLZGrdCwTume0gnmhDWxJolS7yVVNnZc9pqzp6n8onVcQzdFhaP1EOEN8/jhae8GZ1AmxFi/eHPDW0GaCOuwcYtcyjn5Y79Rc1pMoVTg0v/RvDqiEDf/Iwk8gvJlCwTiJOZ91Ivu94sH/USjjkGNdJL9EVM7YcYLuGLiZ0tqykOpR6qE/SklzF9k8qbikC24jB+4cS0OIiuLQBK4sFwZGOvthaCg2EI8P1CayGGIxFHJfdWdA64MbuIOeP3ze6cFkmK1GI5dGflyOFweT156cmYSC6KiBJgqxmuGANV5NKk5v3x+dbrG63Nmhg3GSYxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R8R9E7PXLM/6Wcqnl1KZs+No0MZTexjhjW+ucjw45ic=;
 b=G7sKfYFs0FNSSW+IJIXvpOOKmNjC+isQv6xIEbyoQMLHAoodc5C4l+a0LLIV8qx2bpoqh1M4DnuNo44x6NtAwqY+v7oyUJjPpZhhhdm7BA+xk/DQGG5prNhbW3N0/LXfpT+gU608dvAlMOr6mvc00C4Jp2q9wF8w1V/a94b77GRTFOICEW7ePAk1siaLBWlpl4AQD1C3xkKrsmdJxPPmaIiyeKGI/MZJoUBWjppLiOmlU7QcJRauX4lkdKW3gRIHr80nn9H0Z2zeVoPh9I0vmR9VUhqy63n+VUAo0+mCb9XMRDu7iTBJ+xo/n9ipSe9ytIZ+71ZGKIyRsGOZq5Tkfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R8R9E7PXLM/6Wcqnl1KZs+No0MZTexjhjW+ucjw45ic=;
 b=dW8g0UQr+JXjgrO0kkSGDifu6F2MDMSj055uKuHHnN4gz02MsCrv5G+9w4KvbHlePwBBO+PzFm39QgvrZIl3xu3Na5/itF0ozbkH0niVo/JdvxGeoSI9acdhIPRcaGiMvAC20TKphosK2bjluyatHnC0Wmt/qElpr1S2IOTQZOT4dayCKTD05vBEyq8BamkQmWbvINMiwaZIf/VmZzveOUKa7qY4CVyzjqB+sci4xhfJKYxwGOOL7FkuKAiJJaHjsEyKUiqwGj6K6INlbkgpaiY2FZ5H3TqKM6DiVN36VHFPEY/K17JGMn3PKx7UfO7vngiamfkzauzrX/0CaW87Zw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SJ2PR12MB7941.namprd12.prod.outlook.com (2603:10b6:a03:4d3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Wed, 12 Apr
 2023 13:51:59 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::6045:ad97:10b7:62a2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::6045:ad97:10b7:62a2%9]) with mapi id 15.20.6277.038; Wed, 12 Apr 2023
 13:51:59 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	llvm@lists.linux.dev,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Tom Rix <trix@redhat.com>,
	Will Deacon <will@kernel.org>
Cc: Lu Baolu <baolu.lu@linux.intel.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: [PATCH v4 17/17] iommu: Tidy the control flow in iommu_group_store_type()
Date: Wed, 12 Apr 2023 10:51:47 -0300
Message-Id: <17-v4-79d0c229580a+650-iommu_err_unwind_jgg@nvidia.com>
In-Reply-To: <0-v4-79d0c229580a+650-iommu_err_unwind_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR02CA0044.namprd02.prod.outlook.com
 (2603:10b6:207:3d::21) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SJ2PR12MB7941:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e51a5da-7f68-4931-5792-08db3b5d10b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ahL2JqL4cxKsWnC2nKsrrKP3ZurDGQhY3ojm1ekJv1JIU3WJ/pdp7nKW5bTcNaYow6dDwpqjof1kbhYSrBwGOPQXKUYfadZvt+CYJdnOfCByfRRcH8DmHGXJdlP2dFuux/5Ir8BsXaHmEfuxv4YWOYJPf2R8mg5Ui81cJbFWBmFVAgdTGeCefoZHTSUcRoSNlOEPpmPqA5znq79/go48JZi76ToKP2MfT+MP5s5U+BBXrFyRlA+4qTWg/Ab1s5Je3ie71m9m5+4L5qZakFxcihqK6D0UF3YGwh2nGihBSzl84edQkB7ponZ+7Xj8sL8q+Yec/yr2AkFt6P6zJTlhFYcfJrWLI3u2OfzhF7wJoqreCm3cOLkqHZ93EZMPq3Hb143pwo6Id4LNDmpivk7MawXnOG/SvZJ2Y+9XzwLezOSVYwawNp7OdaOJW6VG1BvyIPpN9YsT+v1zzLT1rJ9UVbZ1oq7Aexi06xnB3xkOxnMM22OJ0VYkukn/iIRZUehF8cV29My/WOKigEujYwFyTiWFMs1Ye1e5nTJyD8XJXcTdhfzRrQeTbHxVeCyDUxi2
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(366004)(39860400002)(136003)(346002)(451199021)(4326008)(66946007)(54906003)(478600001)(6486002)(66556008)(66476007)(8676002)(41300700001)(110136005)(316002)(36756003)(86362001)(107886003)(2616005)(6512007)(26005)(6506007)(83380400001)(6666004)(8936002)(7416002)(5660300002)(186003)(2906002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0vts+U6DJmsSbi+0CTEhXcms+I5MY/5HFrv9r/4DMJqiJU2EdUo/6U05R/sJ?=
 =?us-ascii?Q?V7Wd0jBYE/XIeeYcS/VsaybqSrzfn/tevthbooKmtsp9ZxjEX2uVJcBfFq7S?=
 =?us-ascii?Q?okHET0reBw6ome6Pc9b+mnVy+K+/ohdM44UUYnCdFUyP2AfcYPcmnP+/X5zs?=
 =?us-ascii?Q?h/49Gau7ETJ/xLFPC/zSkB6vGxHnPKsXcY5CzESJZpSKSklx+utt+6KeLwe3?=
 =?us-ascii?Q?Cs525vVqxdixEOsY5fNBkVnl57VAbl0XSIBur+D0jUWfMP8kv2ODwxtdNc0G?=
 =?us-ascii?Q?lnJ2jkvfM3xNx2+4eoI3LLmUP0EqMHsl7L/IJGK0Vb9vie9mY+T6Fz+FQHS/?=
 =?us-ascii?Q?o4PPEJBu2WjdlQ9sxq4mFpakdF7419/ZYs+0gy9gP6wN+pIbc2jMt97fSM8I?=
 =?us-ascii?Q?az5AAkkOaxGAuTlDHsrbakM+Pdis1bLjKZGZ/rzBgUblHRQ+pWkDhxPN5yql?=
 =?us-ascii?Q?bB/tKcU1t9fezZj1pMyMxqD91taecDlBhfiDlYbj1XPmKDXy6r+I5bWEGdlh?=
 =?us-ascii?Q?eBz8C9TYz5z+Th8c3Jj65Zo8Q3Ts48BwvqO0tNMz7NPMUiqyAEbeAZ3Ncwch?=
 =?us-ascii?Q?l8NViXjpUB4+kmzsRzhMZw1IurVwskSCa4PbOcO3g5DMWvh+wlMgvhqR4XiH?=
 =?us-ascii?Q?ieNgfh1Rd1n+IEYfMctj6QnTlFp5lApJWu36Xab7E+OoYrzwI3ZGYTq/KgBJ?=
 =?us-ascii?Q?urMdTkmTyWxWIMAREDLa71cyZ1NoCtPNmrwfxVDDbfPjF36xhp0eaZ3NSBpC?=
 =?us-ascii?Q?XStwbitmrCIDcYGT41qgERw3KlntPR+pRJwzxqbDk0aJ8kglXw4M8SIISs+f?=
 =?us-ascii?Q?+J4LOPRVH9MGVLgFrGw5q6kS6MLkOkrzFyCPcKiS/HR8d7TGsFrWFcER5ZgZ?=
 =?us-ascii?Q?c+4AXJ+3B4kT0ErmQLnj+SZ0TcZOPD5FwGScbnMoyGXsh3+15Qcj+l/zVPJO?=
 =?us-ascii?Q?4W0Se7ADijQrJqsiYsaWK5tyaSzAoV4kZe8OZ3G63Q9ux/awwhMM0CLg+mcd?=
 =?us-ascii?Q?poTIBcrm0M06OVI9LAm/HnqF6Fx9PJgMUfs6cNlZVDBtTQFjd26o1t1pF4/j?=
 =?us-ascii?Q?KifkjgCPpKOaqtJCrJgn2jcBED5yItgpFTl2hnBaBGxJNg94Wb82FoJxy5LR?=
 =?us-ascii?Q?24GRKj+Fn4lbkXNVbqUwx1pCBG0udcyWZheRR14UOHK8vJYSjgmM3e34GJ3A?=
 =?us-ascii?Q?9Ejw96jN401/u0Al8AnXxreh5lYqnV6l7r+2t0MCrHqgGDx+P+j/ULWiSo8x?=
 =?us-ascii?Q?PcSEn56YW7nsNHfJoF3YB5/W5hsk7zBQRcojONdIGeSiqStcqn5+I1N2hXIN?=
 =?us-ascii?Q?jHkqHk8NzgduEFGmNKaBsYZjgNUCeYpxgY/muJLQBzNwvXmETNc3v1AzldvQ?=
 =?us-ascii?Q?gM2wybhExl83cABLJjs21KSvj/LB58q2Ve5vVL8cveX6fySPp+wMEtqC7zUk?=
 =?us-ascii?Q?ysz+oQ63GcAWpZ82u6InUV59lt6vRc7EkSIAmaVdeBlfEMZsWjj3m4d0B30L?=
 =?us-ascii?Q?j821f97phJDoGJyA0qt1aFFGwFbeb+mL1VJggqp5KjC8ReHXmRWG/AcxboRI?=
 =?us-ascii?Q?cY6cpI0gqQ+YeG7Cu193XL5gwLTCcULWXEmWojIz?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e51a5da-7f68-4931-5792-08db3b5d10b0
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2023 13:51:50.2082
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wbKy86dCng15R3LU2VzWvX9ryDtNGCWShbSdSYYNWlAnOTBXV7hSlx54jcPT6XrN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7941

Use a normal "goto unwind" instead of trying to be clever with checking
!ret and manually managing the unlock.

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommu.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 85b1faac641267..bd6ad6ba80aa6a 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2944,6 +2944,7 @@ static int iommu_setup_default_domain(struct iommu_group *group,
 static ssize_t iommu_group_store_type(struct iommu_group *group,
 				      const char *buf, size_t count)
 {
+	struct group_device *gdev;
 	int ret, req_type;
 
 	if (!capable(CAP_SYS_ADMIN) || !capable(CAP_SYS_RAWIO))
@@ -2968,20 +2969,23 @@ static ssize_t iommu_group_store_type(struct iommu_group *group,
 	if (req_type == IOMMU_DOMAIN_DMA_FQ &&
 	    group->default_domain->type == IOMMU_DOMAIN_DMA) {
 		ret = iommu_dma_init_fq(group->default_domain);
-		if (!ret)
-			group->default_domain->type = IOMMU_DOMAIN_DMA_FQ;
-		mutex_unlock(&group->mutex);
+		if (ret)
+			goto out_unlock;
 
-		return ret ?: count;
+		group->default_domain->type = IOMMU_DOMAIN_DMA_FQ;
+		ret = count;
+		goto out_unlock;
 	}
 
 	/* Otherwise, ensure that device exists and no driver is bound. */
 	if (list_empty(&group->devices) || group->owner_cnt) {
-		mutex_unlock(&group->mutex);
-		return -EPERM;
+		ret = -EPERM;
+		goto out_unlock;
 	}
 
 	ret = iommu_setup_default_domain(group, req_type);
+	if (ret)
+		goto out_unlock;
 
 	/*
 	 * Release the mutex here because ops->probe_finalize() call-back of
@@ -2992,13 +2996,12 @@ static ssize_t iommu_group_store_type(struct iommu_group *group,
 	mutex_unlock(&group->mutex);
 
 	/* Make sure dma_ops is appropriatley set */
-	if (!ret) {
-		struct group_device *gdev;
-
-		for_each_group_device(group, gdev)
-			iommu_group_do_probe_finalize(gdev->dev);
-	}
+	for_each_group_device(group, gdev)
+		iommu_group_do_probe_finalize(gdev->dev);
+	return count;
 
+out_unlock:
+	mutex_unlock(&group->mutex);
 	return ret ?: count;
 }
 
-- 
2.40.0

