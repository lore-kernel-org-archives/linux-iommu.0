Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE38EC433EF
	for <iommu@archiver.kernel.org>; Thu, 19 May 2022 16:54:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6D24741925;
	Thu, 19 May 2022 16:54:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uGlFVI3v1IRQ; Thu, 19 May 2022 16:54:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id A68C941873;
	Thu, 19 May 2022 16:54:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7E21EC0039;
	Thu, 19 May 2022 16:54:04 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 91229C002D
 for <iommu@lists.linux-foundation.org>; Thu, 19 May 2022 16:54:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 70CC660C24
 for <iommu@lists.linux-foundation.org>; Thu, 19 May 2022 16:54:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3ZgwE1SNUkKP for <iommu@lists.linux-foundation.org>;
 Thu, 19 May 2022 16:53:59 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on20616.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8b::616])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 61791607E3
 for <iommu@lists.linux-foundation.org>; Thu, 19 May 2022 16:53:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n+NQXFQQEb0jIUotnme2Z5QsDyhTZgQNAPfAth1Tddn/nkuHsmkxisWUlLfqfFnGLJVooWYjvt7/5SvmCnJoKFO7+Io2OzMY+BzFb/jDWHTmAHm9r1JySzJfUeG1z9Gp2udaojn+lqSZ7uFl7WEln7hY65EyGies2xSNo0qy3ZYvpVtjNj1td1VHAIt195PUVt4NApNpHoqyZZDgaClcaUzZ83LwofTHVTwYa/UHhZBaamBSTXy4FKAm5517z2hTj4ke+1JBPe2h2r72ZxhU74TAtMTuGBodwH44gBRiMwg17fJNZt19xkKSHe2QheySGjxDK8nVpyPnnOtItDprjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y0dQiYU5EKvvoRVL9NRnuGnCrBmvQwLo8IC1beGvBEw=;
 b=MNkT3vcKP0W361K6SPq4xFN/zGDHV7kRTrZh/3iQ+en17T1iwG2RsOkp3BjpgLfHw9un6O94vXZbYWFLtx4VJVBleIOUUyHUTGWiRs+akBzdUscWsFb0hBxlhsGK2emuwPZJNINmU79+X4INkDHtQaEKj9ro39MiuzKo2gg2nE5deuhfH1unJwJ82nthj+jhKthuUyu8hr0kYYkWExoEDddVR9PUuYed7tVT734Sd7hb3Rx4J/s96jgTSZ1f5H09ZpSHhsNSz3Tr0BGxfDD4eJO+0XSI6skSC3e7iMDyNBjstHHExyMNXF0eXLcZ2y5dd8pHdfN5aWazq8i6E678fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y0dQiYU5EKvvoRVL9NRnuGnCrBmvQwLo8IC1beGvBEw=;
 b=fYLuONX66ESv8uzD4Vi8lw1tFNw+1KHGdbYGTBupkk9damvVlKFzOPweopl93tjK+7y+tItl0PS+VAZ39hnHX/1f15ZgYbrbjdCMwrSKXZ0xxqtFZrzSqHkx0VBVzqqMe0WiqE02/8IoRbahSAYd/urFe70LfnFy7zZAPkuP8GreT8wmBTZkU5PI92b7bLjg5pWw5jDez7VomoBpLX1utSrp01g8SYAQ9LGO2mtShz0sfgTZ9cvzlPWPD5kJ4aL45IplYrrqkRKMG0ykiVq3niPMWy1bDMCNvVVzEp/dmTc4DdGdlhphoBY+GthH5/+MK6D816UTInpMAw5FmxugAw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by CH2PR12MB3797.namprd12.prod.outlook.com (2603:10b6:610:27::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14; Thu, 19 May
 2022 16:53:56 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2%7]) with mapi id 15.20.5273.014; Thu, 19 May 2022
 16:53:56 +0000
Date: Thu, 19 May 2022 13:53:54 -0300
To: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH v3] iommu: iommu_group_claim_dma_owner() must always
 assign a domain
Message-ID: <20220519165354.GC1343366@nvidia.com>
References: <0-v3-db7f0785022b+149-iommu_dma_block_jgg@nvidia.com>
 <183e155eae268c32e7d02f68846250702fe99065.camel@linux.ibm.com>
 <20220518191446.GU1343366@nvidia.com> <YoXydUP7TCb2YmOW@suse.de>
 <20220519105147.21b0b9d0.alex.williamson@redhat.com>
Content-Disposition: inline
In-Reply-To: <20220519105147.21b0b9d0.alex.williamson@redhat.com>
X-ClientProxiedBy: BL1PR13CA0097.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::12) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ac3a447c-a992-4c4b-da14-08da39b8296f
X-MS-TrafficTypeDiagnostic: CH2PR12MB3797:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB3797E79765CA95F6BF507E8EC2D09@CH2PR12MB3797.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MhzX3zxwK1rwYZFtGckrePmgq4WpjlMQc2F5vrwwAjYMdOLAAHrcPPNj2myUX4wMfEmpIPSVB/afFx/B4byqcnkLt21FXosmRqflhCsZn7zbvnqUWzMeBxyuSpyxf2I0um0d6xKuZS3XI89l7QV7yUFI4+2yUesiQT7viD86X+Wk3l6y972S0ndI7B56k3iGICAlX9pCcubmHueVl9ectLw+aot8v71aORVCWRUkMo35KHXXxNCLfzroD9pAwAr1p9FYR0/VvGgQGMu4yu4egGpk8Xw242FpI4wOQcXYXMCp3mJX/8ucat0TYf2qza7KgxJX7iH+Bjx1ilDqee69nYu1TBYoS9CzdYIWqSu8T5kWtb3Ekq4duT+D8W5zAO42PKtk2LqN2IYqcVHyJjo/9UYXbdCjS9kBNS51CqPpmUX2d8VX7gWY/XB45vZGDs9o6VR9MgodsNHssw01mPcLvjKENqkBLS3OPvmViu6GEsMERR8tGXC7iW8w6srndRvlJPeWL8AcB4FJ/oBCTWSctaHj4UGqtf//bk3QnndNtLuAYhKHrYxapOEgbOFTd1dXcMB36CTp3rJSeGcx9pRwyeOpsSO6xL1CtS+WlvFZpsZ6Ys7kQxniqKlmXfu+aBMDe/sMWSabEVcJOy1fMIArIA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4192.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(83380400001)(2906002)(4326008)(33656002)(8676002)(66556008)(66476007)(6506007)(66946007)(186003)(38100700002)(86362001)(6512007)(6916009)(54906003)(8936002)(316002)(4744005)(5660300002)(26005)(1076003)(6486002)(2616005)(508600001)(36756003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dJn60VyDUhwDrXFsf/DWT9OeIPcpxGKPV0/JCSUHaWN4G5msutT+w0Tb8mUr?=
 =?us-ascii?Q?OPEAzjxIIXjgFg4R1wRaMW69j01GSKSaiHcuJKkuTbbI8UkXKUgRWYnshNsy?=
 =?us-ascii?Q?8jGChyAej9TcLN+eSyLcZUJa5abq3cc4FqWW5YHxWDr6aakaAbHGUI2Zor4Z?=
 =?us-ascii?Q?KNQz+4zHPaI7B+hgipRakpMIGBorST1EP/aT8nu6vK2IFrpirlNaZ+Ws7ECA?=
 =?us-ascii?Q?loe80ArCLQDcWMoebCCfCKVNsv8pUePX+o4e6jSiq9SoCS4faDXID/G4EJ9D?=
 =?us-ascii?Q?td68uUr4rMxCQZ5ZNbJYHv74YTm0Sn6FWycsoduKL9n/1f5UX0WA3A2Rh0Cz?=
 =?us-ascii?Q?mQrMw+s9uV+WsSD8OtF2H/g08MbIr6AjIzbHbvyd+8KuCdxmV1YfuU/ZP2pO?=
 =?us-ascii?Q?q5uOe82uylZltBrk1vgN8BVJUm3MNHzKW5EoIWZzdY5s/rCn9PdkhEjqqH1S?=
 =?us-ascii?Q?d2CAer5/vyOeX46d8S+oSvmsBgZjtMw5Eus1vtLUdVUE+spLj6ZrtbL2a8dy?=
 =?us-ascii?Q?PxTcnSca9UEPwnhLvPnXh5jEc71s4DJFev6NPhxHqfGC8W68NQsdUoIf0Qix?=
 =?us-ascii?Q?4kspRSnvTGYP0NSwXwAoIxsojHObpEMqThANpYzi/w7fzshxykEnmfz0HFw+?=
 =?us-ascii?Q?ziVoRQF0aDut+f5b+ie4CpENAgFM+91nfApRbDHO4tp8KNin7mFinFM9WNL1?=
 =?us-ascii?Q?JpfixexaX/Z3ScPQN/LbQ7Bv77nTEpN2CN1p4fXE7s8hlR1IGmMBFZCFmA+V?=
 =?us-ascii?Q?XvXkj2IiqEoWxsRboUnUUTfF2EQ7MR2GPSn1BKkwFm2Qszu4oqAe3iqoB1fF?=
 =?us-ascii?Q?Et8LKcbsblRDWUYUoAUG+aA08yPfyyXXuvJcSDluMX7/wia4FksolVtXgGLF?=
 =?us-ascii?Q?43NzyV7p3yxUqXVoqy+hzQBMTz4Y4diR1nB+w01KsRWhvClIcgVvg6THwbww?=
 =?us-ascii?Q?6Q7fSMauJSrlrhB+79buma05ITDmqtZKgR74pJShlOAiDG1h06yT+HGs2bM0?=
 =?us-ascii?Q?jITcuVLakbu9WyT7aE5iyt5CZuBgxpteaqZyD/70plgfQOJsIjS9LIymt3S4?=
 =?us-ascii?Q?M+Usd85mE/2UqmfCkA6ch628kJpP+GM2r7+Bi2xU0Dg6S4aYj8zRsWsOsrLF?=
 =?us-ascii?Q?vtalKeQvgdyrw2zrbJPbITemHNVFQ4WQKLAcQpo3HKeI57PnhHJNuwQkKOLW?=
 =?us-ascii?Q?6ngH7fM9gTsuJl+GcbvlViHoNhM1HK/1I0QhtWogcgoRlPlA//qMbU+3S0dY?=
 =?us-ascii?Q?yLs3qJihBKKIaDdDHC9kf+qJhuih2UNZALgZOV/KBgg/uJmYEntez2OcdZQ1?=
 =?us-ascii?Q?lqH5fFIFGo60u/62oil3ha9gETvDHA2DYjjqtENTgPC8ABp3YjFHQiF4PDuf?=
 =?us-ascii?Q?+0NVFDmeK8uG/kONuRGSiLJm9ljsDHAN45M12hKEK+nI7fJ7dFSG1dHBcCdf?=
 =?us-ascii?Q?HgjFbVV585trkWfcizVy5mapyB7llDYb4Wfx2uj8umIi3q78RriRMgBebwUw?=
 =?us-ascii?Q?7K9rDJQpSR1sZlI5uDorEHhT+/SGj6bhfZj1KmtFr8Tc/gQg0YJZxmNVbV7S?=
 =?us-ascii?Q?qT5y/3u6ImtWSf3p7xJ4b7K/UD8oFHK2j0kMpH0Nq+CockUIOL3wvN2Yfl7R?=
 =?us-ascii?Q?s9gBLG278GoBJcn3cISk/3q5AsxXnB7BTM4rWOiUtvDo9bfiE14AaT+uVDuB?=
 =?us-ascii?Q?wqWp14rHJDayYSZwIZCcoXDEgfcof1/5ydg7b7inEq/+oOnMSJcHYSwFVgFm?=
 =?us-ascii?Q?F8H3qRUH7w=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac3a447c-a992-4c4b-da14-08da39b8296f
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2022 16:53:55.9244 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 99k36a6/HrInBdhDP5Vv3odRNQBq60KKKCKcr3MVFBl3j5Jxhatc/r2+6gyuSriK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3797
Cc: Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <jroedel@suse.de>,
 Will Deacon <will@kernel.org>, Qian Cai <quic_qiancai@quicinc.com>,
 Eric Farman <farman@linux.ibm.com>, iommu@lists.linux-foundation.org,
 Robin Murphy <robin.murphy@arm.com>
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

On Thu, May 19, 2022 at 10:51:47AM -0600, Alex Williamson wrote:
> On Thu, 19 May 2022 09:32:05 +0200
> Joerg Roedel <jroedel@suse.de> wrote:
> 
> > On Wed, May 18, 2022 at 04:14:46PM -0300, Jason Gunthorpe wrote:
> > > Fixes: 0286300e6045 ("iommu: iommu_group_claim_dma_owner() must always assign a domain")
> > > Reported-by: Eric Farman <farman@linux.ibm.com>
> > > Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> > >  drivers/vfio/vfio.c | 15 ++++++++++-----
> > >  1 file changed, 10 insertions(+), 5 deletions(-)  
> > 
> > That fix will be taken care of by Alex? Or does it need to go through
> > the IOMMU tree?
> 
> The comment suggested my tree.  Jason, were you planning to post this
> on its own instead of buried in a reply or shall we take it from
> here?

Let me repost it with a proper cc list, I think your tree is best.

Thanks,
Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
