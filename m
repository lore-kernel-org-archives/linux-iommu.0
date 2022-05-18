Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1A06C433F5
	for <iommu@archiver.kernel.org>; Wed, 18 May 2022 19:14:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5460441C5D;
	Wed, 18 May 2022 19:14:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id l5wYe0Z-IwOL; Wed, 18 May 2022 19:14:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id A33EE41C60;
	Wed, 18 May 2022 19:14:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6081AC0039;
	Wed, 18 May 2022 19:14:56 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7410DC002D
 for <iommu@lists.linux-foundation.org>; Wed, 18 May 2022 19:14:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5C67284239
 for <iommu@lists.linux-foundation.org>; Wed, 18 May 2022 19:14:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id r88fe3p96IwR for <iommu@lists.linux-foundation.org>;
 Wed, 18 May 2022 19:14:51 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20615.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::615])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7DD5784237
 for <iommu@lists.linux-foundation.org>; Wed, 18 May 2022 19:14:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LfDHgQheMmfRtgmawIvd32ez4HbE3gxOj+mSMCZ/hFnFgbcXpqs2TuSbA3IPjb2w0+a0cygAHsrD/RaqfyS6KB7R+WdVM2zXPTPpNmRByR2ypV64icuMQWP/r/kSJsCpYaE1FBemWCIjv5YPkYhlZkB+i39mjuOCBwrsUzIGY15DjKMOWRpU0NDf77RLy+jGzVRpRRBli/PA5HpR6gG9r199XtWC/P1UboHxuh+Eu10hOMz8JEAreEjJTHx12bU4656gN/WqdHy4w1JC/i3AwxvgQ2bgUo16jJ6Cmp9jSLVuq+IN5qmebkUcxej5sB+mXMmim7rbLTOfi8KMpTIoJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rYOlHmHfYamfl1hjt6vbnBtzfQIFF0LV6S0BEx/+aZY=;
 b=BrzT6oYlOR2y2IgpT3/U2fN3wSOhCjAsclXmLlFAg1w+0HFrBOg0HXdsZdeQtxA+PEXcOqg5Oj6mddONNpd8P0PCGW2Rav52cmkKx3VLK55XJqA3kBYwPVJb7gQTU+Nr1bWJ3OQ+HaNgMZ35c7pXLoshZ6tyD0RoiDmJqAIRD3qMJnYcB94KR3ty9HOU0UzTvMLGzTPCiiWLkBI/wdp2Eiwhx5IgXSZirQfIjRwPFT8Tgi0py4EdgZXNW15W3K+c5k1+MdgeMIrSmbAdLu2DhWJetvKruZW2anHkM2amcJhalvUDk8Bh45jE0Dt7bEyfuAYRCW3SPKxCCRb3F+rnbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rYOlHmHfYamfl1hjt6vbnBtzfQIFF0LV6S0BEx/+aZY=;
 b=Odmakrqdl99m2Nh89hmBTQBMf4ru5ZQ4T7ot10LprDUKXNOYo1vuzu0utAcRYd+rE6SXE6U3XGau299qZjHDgDcCq/GGkB66AXXmjqN7sHfGC06NQV4r6glRx9117q3/SXxpwx+f8gn58+h8OOpKJtBezTHyUE5mvM/IBlTXYgvuLx1s63CP/prpBFsoUF5um9vhRF3skTHKes3yHyaWypDXkBes4kvjjHbvyQzCoLq01QZz3XO771j3bWKUj6K0UdG1WHLTQobV9/yalTloM0l+SXOQP7BspQ5zPqFo7AGzA+fMehH8xG9gcXmaEaV8GCGYGEnAfuy0RZkt6hfHhg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by PH7PR12MB5594.namprd12.prod.outlook.com (2603:10b6:510:134::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14; Wed, 18 May
 2022 19:14:47 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2%7]) with mapi id 15.20.5273.014; Wed, 18 May 2022
 19:14:47 +0000
Date: Wed, 18 May 2022 16:14:46 -0300
To: Eric Farman <farman@linux.ibm.com>,
 Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH v3] iommu: iommu_group_claim_dma_owner() must always
 assign a domain
Message-ID: <20220518191446.GU1343366@nvidia.com>
References: <0-v3-db7f0785022b+149-iommu_dma_block_jgg@nvidia.com>
 <183e155eae268c32e7d02f68846250702fe99065.camel@linux.ibm.com>
Content-Disposition: inline
In-Reply-To: <183e155eae268c32e7d02f68846250702fe99065.camel@linux.ibm.com>
X-ClientProxiedBy: BL1PR13CA0332.namprd13.prod.outlook.com
 (2603:10b6:208:2c6::7) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e7e61f93-e5b4-4cfa-1e4b-08da3902acb4
X-MS-TrafficTypeDiagnostic: PH7PR12MB5594:EE_
X-Microsoft-Antispam-PRVS: <PH7PR12MB559491F4791609F755D48D24C2D19@PH7PR12MB5594.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LabHCjttW2dEJt4QInpF59E+Y3mIno2IxRNYQh4l6CQgIjpLLZIq7QsP7z8mxHJemhL2d6g+XABK6XpnPbN8pyc/o0PnwP7wYDQhv+547FYDfYO6eF0Fwu27FAbE7r/0XGQHnCpExHq14ZygQc8XXr5tQxUU5p0YwPgMKwePnavzreWSUmJ9hlwp19Mb/p3ZMnq95YVzwH+O1Bwe1MwXI15ZVT2TYkSNpulNsQSKwGwOQbM0T/Klj/kq9VOGoN4iDLCU8vdXIpgAkQk1NeY+bhvhKdok93kVd4mNIy6R36To2rlrbdRACbdnzkYMFJ+6K45IU3lfKKMj5L37Iur4ApSGFeBYNd0YF7k1PJdbb/NYDZwKjcwDL7ypUSzZo5lv/Dj9164oaRAoRobrIHLk+3wpQhuAx4UL8T3Nn0t5gW8pWCV5vUMKUUboGHy2WRrHx/gLeUcenUlCgjjhscGxB3RxbwLSdpHM0rkG1YpBhlt7EVUOSDzLMCHe3fKZDcBWhaRa7fj6HDaqtrKF4YiS6c2cbTgnBPkorEUi9aYbrFHY3ToEWVUqEJ1WJ8WV2FPslE+wAKXwEDKQv0tTvXV53MB1SUg7bfuGiJtJrskIPHo2BsaRcB0Ny0hoAhdeiHp3acFqxsbNpAUwiMGMQjRHqQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4192.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(2616005)(36756003)(1076003)(110136005)(316002)(186003)(6486002)(38100700002)(54906003)(26005)(33656002)(86362001)(8936002)(4326008)(8676002)(66946007)(83380400001)(6512007)(53546011)(6506007)(66556008)(66476007)(508600001)(2906002)(7416002)(5660300002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?R21PHpsnxGfvlXb5vtORHqeIgdPiDMbwz9fMvl5Hz1DC3sL2EOpYO2hmiY2f?=
 =?us-ascii?Q?JgITpnIwKFOJWLtwI0QrZtZecDvJLaLL0dl9VA/SgPh1UgdvQIwMuMqgTryG?=
 =?us-ascii?Q?7wROidFHitPWRO1s+JTjoJi695Fy4pvF6YOARBLyyoIfeurn/sXuNb42S4Y1?=
 =?us-ascii?Q?+l+Ck4Uj1s/1fyfmt/Hi/yriIs+ojCkId6mqS3368xAevmIozhn5whnZLwjJ?=
 =?us-ascii?Q?XHpI3XBLSD5yWv/t2gluYY65932RG1c8ckZcoAF2Rq/QRF/J7o19cbH8YWQN?=
 =?us-ascii?Q?vasnmZIPTFPhZly+V1kdZLo1c5u+E5eg1u/Gpqjr5FugXLqnPEGs8Swytb2d?=
 =?us-ascii?Q?VntIO/L0dgjZ+pTRqNbER+6h/TxwBqI4ZBJSl0KTazHcd7Y/3qoUt+UznpLX?=
 =?us-ascii?Q?I1YAmYUYcejoJ3ZNHp276TKD6cIJ8lufnpnvLBZww94ToPAq1uwYNHRxRNJK?=
 =?us-ascii?Q?13lybyePUJfcxXumWj8lAeakLgP+Ma2fVhmc3GmVYl2YOQg1VlhO/5zr5X96?=
 =?us-ascii?Q?1vORZ2F8MnMLGEWIH0K7K6J07xNUBo9XY4wPxIVvsVw9gr7xCyHAlSOegnWM?=
 =?us-ascii?Q?WdGHFBbwJO0Xh3zWNZnQy5OEya6UWGfWcUoO4bPnToBK+gVGWXwMbNm75Mih?=
 =?us-ascii?Q?lRdLya4lAKUYSubdA6C0eiNDfBvYAZEDTfNdcmkPFjR9deEFx432LIeTPrAC?=
 =?us-ascii?Q?F2sptDJ02dLIpOkBZwIlst5MeJubUU4lbaCVw2Tjyi7F4yv8Vf01+NlfBwLD?=
 =?us-ascii?Q?9umSf7qAh5hVCqSamg7J0rqxQK7/I4HeVW3KhQVrwARNAr7KDNSf3DFH35KF?=
 =?us-ascii?Q?XSKnmp/g0ocQh88glWj9+5SNoH8+jv0h/PGXw0Nxtxlqb6iZVgkYR4AAGWVt?=
 =?us-ascii?Q?2nSYRRsl3mB8c/fmaq0bqChJSAKajDo04aJhXoU1e4a79cdaIuKC5zrQonSj?=
 =?us-ascii?Q?KdlL/8IgXfv5EzSZKKQ9MA8K+zIIuJrRLzv9cJPVhyGX9d9vsxVHBf1Sxxgp?=
 =?us-ascii?Q?YxF0vTbRBUwaKTQ5aU5TlyrdXwlEUVNe/zPPKI9MdoC7HrjSK2kgZmI4dfae?=
 =?us-ascii?Q?p/bBsyZEzHno4RmyMbThrhjw6WX4RREYSSF2iLXIOAOSgcZJBkjtiIgic8L3?=
 =?us-ascii?Q?Tjc8jJdxO3u+ILqFkt95fWsQPlAlkzQ2ttCkoaIt4ru3kzgrMSu3pjE4tHzQ?=
 =?us-ascii?Q?PcGBa+ID19yrzbjfCX6uJ5bebHN9qG8cJyDfy/68aNjXcjN+VlyluV5uz4A8?=
 =?us-ascii?Q?EQ99NQCcJV+M8L383p7C+9hIZCZkOSZJJ36YXkri+oDQx9Ki1bI9As8M8L3z?=
 =?us-ascii?Q?kxM8ypJbn4lmNKJKINPcCP755dJCaqMOnsmBvZArFGP1bgWK9q/UKu9T6QRo?=
 =?us-ascii?Q?m3K3PQ6Rn1Ok4ItR/ATWBv4uqyaSRGvEhS+eW92gLRtjWky6aPv1Kjpr7Mz0?=
 =?us-ascii?Q?LxESjwwTamUxBur4i5QRL1gDtZYsp+OkSauc81/W2bfJyYsohdn+MAjuG6c/?=
 =?us-ascii?Q?I0YzHZMafNnc0E+CwEPCJ6JRNF6l1iI4jQuueTYPfgNSnjEqsqQ0Gst6+ieJ?=
 =?us-ascii?Q?WJZMckeot3wdRHsIEiz1fmwzNRdfHsncBcXoqlqg7kaWNEEBP4LOXCqOnVTW?=
 =?us-ascii?Q?b0TEC82LdeHwFttk5jpGfVkkl1GMwe3x/Mu5JktYHUdVp0uNjO7YE0M3cTRx?=
 =?us-ascii?Q?LzCB0lNV2JXHS+FLNTpvPqRWV46C85ZlMFKV3fbH5kZ2uzK+Wa4uq/2vMpkK?=
 =?us-ascii?Q?l/GMD7n1DQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7e61f93-e5b4-4cfa-1e4b-08da3902acb4
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2022 19:14:47.7955 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CdKwyJjTjY09+xDZKhNy0R4uYYg1Oxt++yiBuav/dwGT4Kdd3BJF5QHNXn5feBiu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5594
Cc: Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <jroedel@suse.de>,
 Robin Murphy <robin.murphy@arm.com>, Qian Cai <quic_qiancai@quicinc.com>,
 iommu@lists.linux-foundation.org, Will Deacon <will@kernel.org>
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

On Wed, May 18, 2022 at 02:50:36PM -0400, Eric Farman wrote:

> I got a heads up from Matt about the s390 KVM vfio- variants failing on
> linux-next.
> 
> For vfio-ap and vfio-ccw, they fail on the above error. Both calls to
> __iommu_domain_alloc fail because while dev->dev->bus is non-NULL (it
> points to the mdev bus_type registered in mdev_init()), the bus-
> >iommu_ops pointer is NULL. Which makes sense; the iommu_group is vfio-
> noiommu, via vfio_register_emulated_iommu_dev(), and mdev didn't
> establish an iommu_ops for its bus.

Oh, I think this is a VFIO problem, the iommu layer should not have to
deal with these fake non-iommu groups.

From 9884850a5ceac957e6715beab0888294d4088877 Mon Sep 17 00:00:00 2001
From: Jason Gunthorpe <jgg@nvidia.com>
Date: Wed, 18 May 2022 16:03:34 -0300
Subject: [PATCH] vfio: Do not manipulate iommu dma_owner for fake iommu groups

Since asserting dma ownership now causes the group to have its DMA blocked
the iommu layer requires a working iommu. This means the dma_owner APIs
cannot be used on the fake groups that VFIO creates. Test for this and
avoid calling them.

Otherwise asserting dma ownership will fail for VFIO mdev devices as a
BLOCKING iommu_domain cannot be allocated due to the NULL iommu ops.

Fixes: 0286300e6045 ("iommu: iommu_group_claim_dma_owner() must always assign a domain")
Reported-by: Eric Farman <farman@linux.ibm.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/vfio/vfio.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

I think this will have to go through Alex's tree due to all the other rework
in this area.

diff --git a/drivers/vfio/vfio.c b/drivers/vfio/vfio.c
index cfcff7764403fc..f5ed03897210c3 100644
--- a/drivers/vfio/vfio.c
+++ b/drivers/vfio/vfio.c
@@ -927,7 +927,8 @@ static void __vfio_group_unset_container(struct vfio_group *group)
 		driver->ops->detach_group(container->iommu_data,
 					  group->iommu_group);
 
-	iommu_group_release_dma_owner(group->iommu_group);
+	if (group->type == VFIO_IOMMU)
+		iommu_group_release_dma_owner(group->iommu_group);
 
 	group->container = NULL;
 	group->container_users = 0;
@@ -1001,9 +1002,11 @@ static int vfio_group_set_container(struct vfio_group *group, int container_fd)
 		goto unlock_out;
 	}
 
-	ret = iommu_group_claim_dma_owner(group->iommu_group, f.file);
-	if (ret)
-		goto unlock_out;
+	if (group->type == VFIO_IOMMU) {
+		ret = iommu_group_claim_dma_owner(group->iommu_group, f.file);
+		if (ret)
+			goto unlock_out;
+	}
 
 	driver = container->iommu_driver;
 	if (driver) {
@@ -1011,7 +1014,9 @@ static int vfio_group_set_container(struct vfio_group *group, int container_fd)
 						group->iommu_group,
 						group->type);
 		if (ret) {
-			iommu_group_release_dma_owner(group->iommu_group);
+			if (group->type == VFIO_IOMMU)
+				iommu_group_release_dma_owner(
+					group->iommu_group);
 			goto unlock_out;
 		}
 	}
-- 
2.36.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
