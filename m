Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54867C433FE
	for <iommu@archiver.kernel.org>; Tue,  7 Dec 2021 13:30:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id EF5BA401CE;
	Tue,  7 Dec 2021 13:30:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lTVEW40X36QC; Tue,  7 Dec 2021 13:30:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 29A664019A;
	Tue,  7 Dec 2021 13:30:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0EFD3C001E;
	Tue,  7 Dec 2021 13:30:33 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 883E2C0012
 for <iommu@lists.linux-foundation.org>; Tue,  7 Dec 2021 13:30:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 762C381C6F
 for <iommu@lists.linux-foundation.org>; Tue,  7 Dec 2021 13:30:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id y6mB1FpsjiwV for <iommu@lists.linux-foundation.org>;
 Tue,  7 Dec 2021 13:30:31 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2077.outbound.protection.outlook.com [40.107.92.77])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B622181BC6
 for <iommu@lists.linux-foundation.org>; Tue,  7 Dec 2021 13:30:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DDhRqe9OAqqDi1vUmdsY5MaR9ZyIKoPgSq1AAXr2rOWRrOhkBWFzp1T3BlAJMUUGq/Yk+jWYrpY7URqwP2GhXz7RjI93DSaMUuu9Seg/bN+te8TNgD6DxtRTfEntPp7Zqxl4zBaRWUqkXoNoTSlF0xozWwH4Yah9tgzuiubPqxx4z9cg+ZLbTHf2HXqkDhK80xqObUrAOZ4z3nHPNCm4NdpdyWzByqB5O4dQBMXqU5zn9dA5YkQ8noSyqq30rN+WjqAjaOekr9qGfjmwvDKCr01ljdmu6El/GPape0LxVaGwCF1ufEYimDLJx+gDzs2zgp+eHuJK0kuYi9PAFFT4ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gm+IrkEw0+t8KnKQEusg5zIr/+5xQSJPo0xcyyCTv2g=;
 b=MfGp79QeORRiyP8UKXjm7HVc6VvsbFepNMYS24kvsE8WVnGHIEI7I526FBJjbVftuHCIpEH8eclV2N15DFh1hFM5o0CGpOMdbvaFqgvBy1reeD2y7z1jrRR9m3RAQAG78j56o2IN/GRhF4HM70Q7Tkr76xjlCW2JpI5v/ET4MMOEJHfZChqWn0pjAsOnB68Nk6bf2kClqm43qtGTvQhA099u9qZT2xH7t6zLtg/As8Tk4ZeGLZTyeJofVXXc4PJAw6AYsr3atFrFBWrhsqU3Lbqq7tJ980xK2DqHJFvkiKQJssHs7EoJ+qWAavsKu9G99vSz2gWFd0VqEC7aIUMBVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gm+IrkEw0+t8KnKQEusg5zIr/+5xQSJPo0xcyyCTv2g=;
 b=Jx5VzOiD1arjDZih2+XWOtm9zkuA4pI88uEPAUMmApqJ2LB/6FWd6KuocBKXfhzk3HM6FHmqWWonZlC6EKZaSVOhQo9A+Pc+kwa33jgzGrnhmp2mm8tUh9QzA+ZHZb3eSX30oq6ZwWwLr2gCIXr7CIisVVUrivZSbVDvb4xnwNdfnWSlAscDHw2DZRXdrcxq0EchkhokJCypiMgUou7o/Dmpy/231tEGqSVpIJhl3+7lIk+SfVWXTOkUKu3vgjT8b0Hss6CYEI/cQaipBgLZ2xfndXVe7Ba0Aqenc4CsUprqVq3mYfszHu+FuXkA69FXLgpyYUAWe4lKqh6YJJD8Jw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5223.namprd12.prod.outlook.com (2603:10b6:208:315::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20; Tue, 7 Dec
 2021 13:30:29 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d8be:e4e4:ce53:6d11]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d8be:e4e4:ce53:6d11%5]) with mapi id 15.20.4755.022; Tue, 7 Dec 2021
 13:30:29 +0000
Date: Tue, 7 Dec 2021 09:30:28 -0400
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v3 04/18] driver core: platform: Add driver dma ownership
 management
Message-ID: <20211207133028.GB6385@nvidia.com>
References: <20211206015903.88687-1-baolu.lu@linux.intel.com>
 <20211206015903.88687-5-baolu.lu@linux.intel.com>
 <Ya4f662Af+8kE2F/@infradead.org> <20211206150647.GE4670@nvidia.com>
 <56a63776-48ca-0d6e-c25c-016dc016e0d5@linux.intel.com>
 <20211207131627.GA6385@nvidia.com> <Ya9gsMmQnVdQ0hyj@infradead.org>
Content-Disposition: inline
In-Reply-To: <Ya9gsMmQnVdQ0hyj@infradead.org>
X-ClientProxiedBy: BL1PR13CA0355.namprd13.prod.outlook.com
 (2603:10b6:208:2c6::30) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by
 BL1PR13CA0355.namprd13.prod.outlook.com (2603:10b6:208:2c6::30) with
 Microsoft SMTP Server (version=TLS1_2, cipher=) via Frontend Transport;
 Tue, 7 Dec 2021 13:30:29 +0000
Received: from jgg by mlx with local (Exim 4.94)	(envelope-from
 <jgg@nvidia.com>)	id 1muaY8-0002Ze-3p; Tue, 07 Dec 2021 09:30:28 -0400
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 282a0511-14bf-4b4e-3c24-08d9b985bc49
X-MS-TrafficTypeDiagnostic: BL1PR12MB5223:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB522340679FE18A956B04B939C26E9@BL1PR12MB5223.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3J6WRNz6Py4N9JH45NEwZCEo9UWjVh3jAfVJpBij9HqDJn8Wj0xCJtShOkNHFlBLuetokj+K0cT4mQ4y3q6iF66UW91L7ELC2tKfv0sipvhI1Rrf9rEUIbzwyrL9X6xoArtwzRPt9troAC8hGLHSlIgL/KyqGBaQAov9K+4XKu7Sd6o4qqx28+6AmnWj5tJvBEZeG+cLBxoM1Nu99/2SzK5hDpoVuGvgdvqotbxqbr2ntveSLFyDZgBrdP3mL16h/pX9JTK1FoMFTr/6Nu3HH096PSGPPGv4IlcX/FfYqHbLJ0sAjuPAnviT3F9Z/ddbslgInyNfCKXANOw1JVKYpJiSHO4rvsBJGQ3neO4iLcgsTEJ7gfL92q4xGPqlBnhCmLpPgXa+SzvVpY9Jt5O3ApJaPoEWZ3b+uUk/b14+zgVr1n90N6SqC7WF9xFr8K1x8hzbqwBuM1ssvK5v6aN3dB0YUkmBJlfpkvLwyllc/ltHNZhV1wC8ard4XBG/GZS/naYTW0KcSkYltZj5jgWUt6XSaN6WYPGG+YAtYvHAfD4PK8B8c/vH5elJWEjlzfrtWZt/z/wK329IgZb8XswS3pNig8nPcL8M6KJl0oaw8w7k5HlaVwizo0pQrMqzq9GuQDY2OkzTimWWg9jZnLX28A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB5506.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(86362001)(9746002)(8936002)(4744005)(9786002)(83380400001)(54906003)(36756003)(8676002)(426003)(508600001)(7416002)(1076003)(2616005)(33656002)(26005)(6916009)(2906002)(66946007)(38100700002)(186003)(4326008)(5660300002)(66556008)(66476007)(316002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4JcYfwAPfcl4HhBPO/G8ufZEEVQubApl5WspBcXSBUKKZ5/AWDklBrACVSG+?=
 =?us-ascii?Q?M+azLDJVb3UaWWn1fRhrbTlokEZUN/XENJLvruGfKSWvjVtKMWGAssQW1gDv?=
 =?us-ascii?Q?cM+ZYsJ5j9tT38ZLTXUlvfnCG6Whm0oXg1ubMA8KKumMvvh9isGtEo4mY91L?=
 =?us-ascii?Q?dQH6VkQAS9YCnRzqFb38fDpiGGNHAns5ReEPstQ37NMh3LBnjEoPNd7VE+OF?=
 =?us-ascii?Q?Je+GvRRvEccSvhk2hjUqHjDyoCweRCQVGGSt5xr8q1ndGmdTeZwzaE3eBDUI?=
 =?us-ascii?Q?+6qP40OLzQ7Ei6DpsVUScmnJJygF2LxeagsBxoIHK9gd2/qvOQVv89p2KfA1?=
 =?us-ascii?Q?+UwrGVh4z/I603Pe2bLpiXP/uNluCJ47+0MjaFG89NeKsa/+MkvCncg1azJz?=
 =?us-ascii?Q?9aozEiXzyGJ2QUETNaaDsdokb1AXc4Reyipbnz6kWry5KXqJxPpQWiaulSgL?=
 =?us-ascii?Q?SzefnxlumO6ni3+xqpMT0GD7GI/cpbGbULfFJFbvEoahHoDVeTUAKs+RFEYd?=
 =?us-ascii?Q?bBGI8qzpnpFDwclyIHYDTmrYfIxwt1ac0x1IsJJ8utket64Qv7muPDQs9xMd?=
 =?us-ascii?Q?8z495Vpy60xi34+kjeeG+5co2ip2AvUG0T5Me++xi/rYmuR5AR5GNxA7XfWi?=
 =?us-ascii?Q?BFDNwJ/xYxG4he042HU7fIyMyGf9L4tcnIyBWCFprphmIATTSzANoD3Bac5K?=
 =?us-ascii?Q?JfTfaf3vUikb+z5kc9GcIfKDC47DmENAOsZ81/Mtu2bCVT8GADRJJqIc5kJw?=
 =?us-ascii?Q?aw6ED++Hhp4rBxJtXlsgQl2o/YeGric8F1zkTVu9y+ytXFFN/y0IARzanbwr?=
 =?us-ascii?Q?infX/yHYHUu+WVRLHChur0VBcOldTtG1Y2QY95TBQ1gdBxos7UrOrraZTv02?=
 =?us-ascii?Q?lYegaam6tpHZa0dsHPi3rlbcPHCwE8VJt0XV1XAQ5SSjMgmxW5LsztkOBZ+Y?=
 =?us-ascii?Q?DwshEAMZCHnXe7YaUCH8F2LsQ4jiItydWktxiJqqM+HHCGWL+sFeLHbuwrfJ?=
 =?us-ascii?Q?sLe2JMlhWcKLXxm5XB05HQiTILuwbxp4WrSS3pquH5vXiPhxUOnN7z0WXbEW?=
 =?us-ascii?Q?wRy2YP/NAGkVEIP2nil7fT8efRMkJbeWSJNgit568l4SXVWc6OxtHL7IkJed?=
 =?us-ascii?Q?028EMUdULpjpDbUk+DQfNn7W92vrXrskGqOqOg6DhZkOWF3C+AjVi4eEzEgl?=
 =?us-ascii?Q?+ERMC2QGRA494QnOiJrd5A2iyaEMbrHZMCTrTS5I8TOk7udFFjSM2+RQaPP4?=
 =?us-ascii?Q?UJwe2x9iqlZSWXJtWFsIXQHylsH/lvfLOZfedqXRYFxvwjUIGTDLcOLpIhwq?=
 =?us-ascii?Q?emEOsPwVrnOgNPjoTgQYsY3Jp/06kbdRL4aKj3fLNfm8yqMPk599DEuQ4KkR?=
 =?us-ascii?Q?e1/3o8MMOcSQDQAXl1lgkR4A3tPB3cQos2gN3ypKUZb5+A7nFmHS8l8lAUAA?=
 =?us-ascii?Q?mvJH5y6IF8nwII7vWblWwdxfFsqVetAPB3z+9z4k+uakMDjc5Sq+PH35G9hY?=
 =?us-ascii?Q?yx6+/ouYYh+4VImD0wrlIrJTGsjrMcEGlUikidIoTXmhQAu9Fzjlhehx63kZ?=
 =?us-ascii?Q?T+XpqWN82O/GC+J6Enc=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 282a0511-14bf-4b4e-3c24-08d9b985bc49
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2021 13:30:29.2696 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Oead6dE0r6hAqyEnvQaB42yhGjaXRdk8rSW9RIPC3jtLzO3lzIz8lIXZiwCrhVkE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5223
Cc: Stuart Yoder <stuyoder@gmail.com>, rafael@kernel.org,
 David Airlie <airlied@linux.ie>, linux-pci@vger.kernel.org,
 Thierry Reding <thierry.reding@gmail.com>,
 Diana Craciun <diana.craciun@oss.nxp.com>, Dmitry Osipenko <digetx@gmail.com>,
 Will Deacon <will@kernel.org>, Ashok Raj <ashok.raj@intel.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, Kevin Tian <kevin.tian@intel.com>,
 Chaitanya Kulkarni <kch@nvidia.com>,
 Alex Williamson <alex.williamson@redhat.com>, kvm@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, Dan Williams <dan.j.williams@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Cornelia Huck <cohuck@redhat.com>, linux-kernel@vger.kernel.org,
 Li Yang <leoyang.li@nxp.com>, iommu@lists.linux-foundation.org,
 Jacob jun Pan <jacob.jun.pan@intel.com>, Daniel Vetter <daniel@ffwll.ch>,
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

On Tue, Dec 07, 2021 at 05:25:04AM -0800, Christoph Hellwig wrote:
> On Tue, Dec 07, 2021 at 09:16:27AM -0400, Jason Gunthorpe wrote:
> > Yes, the suggestion was to put everything that 'if' inside a function
> > and then of course a matching undo function.
> 
> Can't we simplify things even more?  Do away with the DMA API owner
> entirely, and instead in iommu_group_set_dma_owner iterate over all
> devices in a group and check that they all have the no_dma_api flag
> set (plus a similar check on group join).  With that most of the
> boilerplate code goes away entirely in favor of a little more work at
> iommu_group_set_dma_owner time.

Robin suggested something like this already.

The locking doesn't work out, we can't nest device_lock()'s safely
without ABBA deadlocks, and can't touch the dev->driver without the
device_lock.

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
