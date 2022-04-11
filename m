Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 078A7C43217
	for <iommu@archiver.kernel.org>; Mon, 11 Apr 2022 15:16:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A57D04094D;
	Mon, 11 Apr 2022 15:16:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vyuwN1nauvwg; Mon, 11 Apr 2022 15:16:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 4581740932;
	Mon, 11 Apr 2022 15:16:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C6423C008C;
	Mon, 11 Apr 2022 15:16:19 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1B9CAC002C
 for <iommu@lists.linux-foundation.org>; Mon, 11 Apr 2022 15:16:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1035A40A82
 for <iommu@lists.linux-foundation.org>; Mon, 11 Apr 2022 15:16:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Hj_vRQUua8Xm for <iommu@lists.linux-foundation.org>;
 Mon, 11 Apr 2022 15:16:13 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2060c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::60c])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6BF8D405F8
 for <iommu@lists.linux-foundation.org>; Mon, 11 Apr 2022 15:16:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ee87VU7dH4fcUfA4z8oR6OjYXBr0BCMjCeeQgnQNaRgemAwugGk3aN/RDh2tKOOBpt9JCcUpGszGVizNiyJq9tWDdfkrwlaD5ORwepteXNC4Ornm5b8VJM3o4DS0IKFNYuOkO3oNImsoBn1cpeYnc5fzr1PWIfCasR6mlknCD5lCmpTvuaw71OdPTgfpu+5AvMF+CNVHLYVOaYBIbOdRrroDbHKE2I+l0C1u/7cwOH6ZcW65QOAFzy9QgGyvi93AtXZJLyKnewfZy7PA/c2SuBpzSxHghXaU5SvTbSCmXixby09nlHZl5qE/IeHuMx7MULoFJcpZL2ey96M6RzAXkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FGGLPjLm/08CdBsZSYP/Ahk61gENfv0328NMlQ81r10=;
 b=aZKglbowhW/j9BHxT6n9dM21v8dsqR1dbowtCx2LcJrGnIIvJZr02ai/DvwmpnBOF3L7M/kKKVNZ8ehV8pnpjq+iLuHxguBGCL5yf5EDz6HTfEnqnFIsAH1GavwgM32/qetZJL/XO61rprQ4/h/279LEiBRL7N7kDZJ1hiGsjv43b2SW4oj1cK5UY0ToNi76yFTFTB6xmZrBW4Vp0qQNK9oBv5NTD+0J65Nym2gKcUEPF4jGovhcJvA96zVdM8kEFM0r4SrriihpbrzzYnakByRMqjs9jvYYiYyQxd3DhXtZexQpei/j3IsDZfW1wSgbb1iwv04KBJbEkZaHY5d6vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FGGLPjLm/08CdBsZSYP/Ahk61gENfv0328NMlQ81r10=;
 b=qJGyjI5K/inYQajwq6kCzdJQocovrAPJkT1xnVmrpkdZhtlXTs3cWTFZXAi0gV6WFs6QiguunR2PFW8TgNqzNmdSf6rIQ8DtbRY0Zov5X3hpBvxP0mGOKWOpZKVUW1jm/z6R3EtdTjwPQnY7jUfUeokOqlLfd2sqLl8It3OuGKXGlx1GkjcOhPTWnnBqFz2UmbkmAFzLIQGTQqIokPW8WuGhZWXrrsqrebq/8PbQQzXsy+OD0zZKUk7xiy8eO9xvMOoa/zaXWaY5CW6nw6EbdQF8elOaySGXB4Mh6ohFjqglnw+emjWuzegBtOVO07NzxSL4wZBI0Zr07T1Zl2eALA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by PH7PR12MB5927.namprd12.prod.outlook.com (2603:10b6:510:1da::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Mon, 11 Apr
 2022 15:16:11 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::cdfb:f88e:410b:9374]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::cdfb:f88e:410b:9374%6]) with mapi id 15.20.5144.029; Mon, 11 Apr 2022
 15:16:11 +0000
To: Cornelia Huck <cohuck@redhat.com>, David Woodhouse <dwmw2@infradead.org>,
 iommu@lists.linux-foundation.org, Joerg Roedel <joro@8bytes.org>,
 kvm@vger.kernel.org, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Will Deacon <will@kernel.org>
Subject: [PATCH v3 4/4] vfio: Require that devices support DMA cache coherence
Date: Mon, 11 Apr 2022 12:16:08 -0300
Message-Id: <4-v3-2cf356649677+a32-intel_no_snoop_jgg@nvidia.com>
In-Reply-To: <0-v3-2cf356649677+a32-intel_no_snoop_jgg@nvidia.com>
References: 
X-ClientProxiedBy: BL0PR02CA0133.namprd02.prod.outlook.com
 (2603:10b6:208:35::38) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 01f85673-d122-4b2b-4589-08da1bce356d
X-MS-TrafficTypeDiagnostic: PH7PR12MB5927:EE_
X-Microsoft-Antispam-PRVS: <PH7PR12MB5927A5AF0C070F4210885AB8C2EA9@PH7PR12MB5927.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Tgg2Pfli9qXVm7olquve4rpni1YuSG2kV/T3Fej8mxd/QGLJXSNz/G5Wgjb69FFEjetrRIENc+O0eiCKNxzt5gVTy9dirbRVHUzT7LsugD+FfW9ZursjeUcqTuKIx/495oTVjp9py7LqBjAFtg6iJvoCR9ZxQUBqOpMs4JKW8d3UqfXDZ+aXXdrcna1YQIRILAzWf8RKWsr4a6ve5vZdMA7X+7NAsx7Cw40DB6sd3z++l5u2zBuYZsqRrxlmanrbIGl5OSM7GtjqkCXBp/LZH2muyhVNAJdZH2jjbScIjL82ZpvIfrXAYu1eq0VCctmR1FSq87RqHP2Ba2ZyjewMuG7iE2EbsAibjoU6ijwreIaOHLGruC88JDpqrDYYh3Qf3XQTawr0hNL7ca8OCk5C8JIXHPrCtZtrnpe9lwaLMYVZa2XPzrmdvYgV/eJpcymn7Sa/RrcvNXXMcMJmssKebHEIGxY2dQyDhQ5Wxw10brCVSgeLgQJ36E1kbNFR1SnGV5Su1g5pt0hdTILyiV+Q3jhk7nLGePJpYwpuNVFa8BcIVnN/rGV25ODEKOnHGKb/CSq2tjLVJwy4ln4KmbHd458jmu+M7L38P8myWFfA8mwqg+Ksjq/UP966gOt+f9y58QE5QZ7c0ajxeMn89kws4nkvVgTSCSTjIxdLxg4M7OSdueU2PXxAFS2Xx9ePxfp6
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4192.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(6486002)(54906003)(6512007)(38100700002)(8676002)(508600001)(6666004)(6506007)(8936002)(5660300002)(2616005)(4326008)(110136005)(316002)(83380400001)(86362001)(66946007)(66556008)(36756003)(66476007)(7416002)(186003)(26005)(2906002)(4216001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5N5tfN4RVM0SkOZguhTNi1MRcNsgeoCUsgOTf7bpyoy93d1QZIaOYpgI94gN?=
 =?us-ascii?Q?GCugkNlyjnzZVTaF47qT7sJe1G+l2bjTk0BrVsNAw69E/jQKFu4uECYOi89j?=
 =?us-ascii?Q?IETRrG9rzGwCgWFYF3F+3hKX4Qji5sIuKS2IurSgd7wqOcNkY1sNRIZyL/Jq?=
 =?us-ascii?Q?psUaEVIOFVbyoH8J8fBwlhR8Vc5yZtjo/1zEX3El4AzSy1oyy4L50kNTKzfQ?=
 =?us-ascii?Q?L/IMIjSWPfEn2whTSJBpJ6K40dFa/yR4j/d8yJ8PuGSpmwDqMrpVBe8jeMJK?=
 =?us-ascii?Q?XKndTJJLi5UsDBdlM/lg4YF85HMMkl4G8EjPlj0d017zLMHbG7scW+QqVwN6?=
 =?us-ascii?Q?BLpRcEV55W+L6dlW4/eUrX8j+frWAYQP20A045HTZG/FioUStnmz7gCD65WU?=
 =?us-ascii?Q?b3o3kKvI7p6FHhn6lAWkc6vilvoVxLcup3gIsYw88uSdXdjbIavTRnznroS+?=
 =?us-ascii?Q?piZNeQ5XpYX/aM4eFsKSnidsn1oJsP7Na0iYxaINqQTyMUHAFMVzvm6bcoM0?=
 =?us-ascii?Q?AfWa7SubbgCjNlOc8ywZMTTKLpRV38nT16jYM03ClRlp2oQ/o+fy9WlKVMq/?=
 =?us-ascii?Q?KeHmiMnu/AEDOFfhqEhWlWk6QDUeuBZC75o0Wt0E1M+lQMCXL4sFwESySinB?=
 =?us-ascii?Q?8q6KSmIEtZ4NjFSTgwrC6jhbbmjo6u298vc+8vzrNsVNKGSblNtqV3NeoOJf?=
 =?us-ascii?Q?5YAkTORFnLdMxziQGk2Cjktt/60brcX7nRPW+/rtqZBzMj01np1HAAgBFK8Y?=
 =?us-ascii?Q?mImmf3eOWDpsJv8YOBNI0CVUfIRjB1nRLkyI2M0ToRlzvlZM9GgzOgbo+SCr?=
 =?us-ascii?Q?OfnY5P5vOBg8Bm4p+gqAyox1RTVkAk/ZtIKBx/wvtBwE090w8wzlxVICZ3VP?=
 =?us-ascii?Q?oK//HC5Y+FxxrFlgkK2lS8co1sL2KT22TnWsPintctHHgFVi9Z1hqh/G3CWr?=
 =?us-ascii?Q?cDp7oR2+fvhmz6LWJN9iRTcWaukLrHnY3MlF/HaDurRogyNqkfNLzInJHdrF?=
 =?us-ascii?Q?DZfqkRVX9L79gTg4TQlnUg5/+PzfTfeL3X9/56VW2n8AEx6kf5FbG/j71ZJg?=
 =?us-ascii?Q?1N1XkytyUIIjiUdXEU2qhSPnXkSp9c3l2Y0a6Jp/qLtEQfmoP4s3ss+xT9Wn?=
 =?us-ascii?Q?fUyL8RhN/JI971BcbNPjgUjSS4THEcB4s6qvjtljtcVjhqcOZUwD0BcM8++3?=
 =?us-ascii?Q?Ng04U5RGik0EzrM6WEEsjBtVro+UhqnW799XPEh8n/f3mAr+lj6KETXeJ1O4?=
 =?us-ascii?Q?LZPkgZtlDsYZpLuji8y0XRrRE0MynpbwRPivLYhot+lJ99UhRP5MB3QDRxGS?=
 =?us-ascii?Q?KVH48CPboRSyAZ0K4Jnndd5u6UPVNkBJF+VUi1Kj+hc4ZfefQAf8qico7JHI?=
 =?us-ascii?Q?QD9cvKEynQYy0ygV2XnrJgY5bkYGB+eMnrfTm4gwLRal4MwqMLZp8jUgttyM?=
 =?us-ascii?Q?EmgmKrgvOZj95RqRLP3xGg1zBcNDDtUSBVQnXHRneTVrl0uUwgjTdOFJ4AiG?=
 =?us-ascii?Q?1YcTckMJXTxDi9cbuRU3BZfFlmtV4a1cwCqWIue7cTRZ4xwXKRlNlMY7ZN4N?=
 =?us-ascii?Q?/lGaBmlLT2bVU6GHu4JVz7vzHOyHRvP2Qhrt4sb43GTXfsgPj3N3DPv4ufXG?=
 =?us-ascii?Q?c1388keKihN95Z60bZYwBuTpk+nVRR7klXlWGYrRDNb7EClDvxEozLxQgrKs?=
 =?us-ascii?Q?2sH0rB5mkHXBQGvtopACBbG08l0hHCIkjHAPiSRUEA1KkZ1hmS7Vb6MvvzT2?=
 =?us-ascii?Q?6rSvh54ozA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01f85673-d122-4b2b-4589-08da1bce356d
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2022 15:16:10.0694 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uXHdxntvopQFuckt8OvcNZ2N4OJKnVEBUVJnNlCQPHNS/5dPlfini/pHGFodya/4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5927
Cc: "Tian, Kevin" <kevin.tian@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>
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

IOMMU_CACHE means that normal DMAs do not require any additional coherency
mechanism and is the basic uAPI that VFIO exposes to userspace. For
instance VFIO applications like DPDK will not work if additional coherency
operations are required.

Therefore check IOMMU_CAP_CACHE_COHERENCY like vdpa & usnic do before
allowing an IOMMU backed VFIO device to be created.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Acked-by: Alex Williamson <alex.williamson@redhat.com>
Acked-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/vfio/vfio.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/vfio/vfio.c b/drivers/vfio/vfio.c
index a4555014bd1e72..9edad767cfdad3 100644
--- a/drivers/vfio/vfio.c
+++ b/drivers/vfio/vfio.c
@@ -815,6 +815,13 @@ static int __vfio_register_dev(struct vfio_device *device,
 
 int vfio_register_group_dev(struct vfio_device *device)
 {
+	/*
+	 * VFIO always sets IOMMU_CACHE because we offer no way for userspace to
+	 * restore cache coherency.
+	 */
+	if (!iommu_capable(device->dev->bus, IOMMU_CAP_CACHE_COHERENCY))
+		return -EINVAL;
+
 	return __vfio_register_dev(device,
 		vfio_group_find_or_alloc(device->dev));
 }
-- 
2.35.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
