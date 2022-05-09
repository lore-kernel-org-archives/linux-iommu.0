Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15691C433EF
	for <iommu@archiver.kernel.org>; Mon,  9 May 2022 18:33:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A792B60E26;
	Mon,  9 May 2022 18:33:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sLwlGrbeSeKr; Mon,  9 May 2022 18:33:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 7EC4660E1A;
	Mon,  9 May 2022 18:33:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 54648C0039;
	Mon,  9 May 2022 18:33:17 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 63702C002D
 for <iommu@lists.linux-foundation.org>; Mon,  9 May 2022 18:33:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4764A60E26
 for <iommu@lists.linux-foundation.org>; Mon,  9 May 2022 18:33:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NOZamiq8iSFn for <iommu@lists.linux-foundation.org>;
 Mon,  9 May 2022 18:33:15 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2060e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::60e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4EC9260E1A
 for <iommu@lists.linux-foundation.org>; Mon,  9 May 2022 18:33:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SghI7RcHJdTnISBHMMBpCZxbvH41X+gzOh2i1CmSNNATMwuGoMd5peAu6F4Z4ZF8Uw4PLE/M4E7vuwR3szb0LqUgxwWxNkWVb61iSainqRMN1avBTMuAmLh5QSa5hLRUfIlhpP+sjBxmb9xkXQ4Gp7FJsZ4sYWurcu6bRm1OD0Wl/QxdipdskvzLjhAO7pC5tHwbvb3IF4BHmuM8lR4olBAYfHoKeuQDm/Ld7e3Rmqq7X9zzH9XsAVUTkNZRvZgeBkbyEKuCsOcq/tCFusDUw66HXRUmilhLSOQTqw6TjuHAnJ5ZfgPIuurXj3kWlRQEdeJqbAmtUPBD/I7m0a904Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CwuYh0u+FGcj9cA4nSzeA+5h+C3emDseAQ2b5sgrH/o=;
 b=ajwiZtUb1wsKLTNEZnDDT+PWZhNVdcGr4eU02eNb+dJviMh9wbJQX1AhejiHtufAqRkqVfnY2FCuEbVUjdwzhUL4WJ+V013TkT4r/KJAQ1pDMnb5RuvaMhYKHPqPgvnWFlonKtWRscKyApQ7YXia+dydbPqXxgCNhjaCP+USSbLMD7Hbft6tYLTtoqVZZSyG7bOC1M2uXRf01Dtz9B3GPVORZzD0Mw0zdqxfONyY2QOyVK/O0lBRTfI1aFRaNMdczR3XdOsYkmY8uK0LB+Eb+mx14kM/ge5neHHnbfMsGD04HwrEsE6c6bIBKpoulu1w9OSXdSgL3f9PzX/48tiB/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CwuYh0u+FGcj9cA4nSzeA+5h+C3emDseAQ2b5sgrH/o=;
 b=H6l1NokTpKpbvoaQYf0caF0FZV9ubNf4kCmaILG9i6fBVKolxnvWskmbvG7p5Bao3TAeIPay8NKzuStBUEZiHrcI8jJ+3twqTCFTX098/JrW2FudInPO91azBVdB9WBJpRnSx9XlZwnLZ96k51M94LfZnqaOn7Xc+xN+UANBSmnRbX0by+xba6y3ukttru0VK3ob0aelg+S2kiQEP8R3ikd+Iq+kJP/AH7uZFSk5+UZm7GVLu5tqXN4/mcSR2cggBqyegnaQV4xS4XF9MjV7IjKpnktOuqkX5RH0FZnEtWvxC+wyg7Dq+lvkOeyLex6Q4WkK1MpOglfOH8ir8gutYQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by MN0PR12MB5812.namprd12.prod.outlook.com (2603:10b6:208:378::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Mon, 9 May
 2022 18:33:12 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2%5]) with mapi id 15.20.5227.023; Mon, 9 May 2022
 18:33:12 +0000
Date: Mon, 9 May 2022 15:33:10 -0300
To: Joerg Roedel <joro@8bytes.org>
Subject: Re: [RESEND PATCH v8 00/11] Fix BUG_ON in vfio_iommu_group_notifier()
Message-ID: <20220509183310.GS49344@nvidia.com>
References: <20220418005000.897664-1-baolu.lu@linux.intel.com>
 <20220502161204.GA22@qian> <YnI8Xy54M3XQpS0T@8bytes.org>
 <20220504115135.GA49344@nvidia.com> <YnJqER3qbzHucfkx@8bytes.org>
Content-Disposition: inline
In-Reply-To: <YnJqER3qbzHucfkx@8bytes.org>
X-ClientProxiedBy: MN2PR16CA0050.namprd16.prod.outlook.com
 (2603:10b6:208:234::19) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f30a86e6-450e-4e2f-6d4e-08da31ea5f4c
X-MS-TrafficTypeDiagnostic: MN0PR12MB5812:EE_
X-Microsoft-Antispam-PRVS: <MN0PR12MB581277653D778E02527F6CB0C2C69@MN0PR12MB5812.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e/dRIDAu/jZ/YI7Rsv0tnKWWg8pn8oTqlWwSEndya1guw83ZkoCxnLj4dsLZxF3tY7LKYN9AfshLSZ8jWh65hcSibzkhoMbg1Jp02ZQDc3oKn4RIAgH1Md8xiOt9fYjkMQYkA9BlgnmJQoPIg/lhRWloAj1axgRbvQkAGiyNqzvaEvRGBh3QIarWFo0I3VI1KhdjyZK7sc9Z+iwLx1wxMjKSOXR4Je9wSkZefEyiBvxYn1x3/1q7mViA3Gh9CQeuNdRjhB3aX8oZa+wjcqt3NT1JkIa0/Tf8ZlATBEBYbSKobcE0e32pNz3Sq43wvIc+euQ2kavFoS4CMM1yEz4fUf4V9NGScg90At2H/zDcAGSStftckmgnpgIugUsvt/EZ8tBiUnjCj4n22fHK/VOjBJI19I3A48SGfCEKxfbYPzUetoA9AnyzJ/PUD9uQkFp8svuUeUNX+qO+Zwh5zWlNM0G5D4ZIQKQPo7udOEGJc82xeTvqShdtWm2BOyaLnOeZLvdDYPvnGLvJnvSvmyD6dJQNtdlFkaIKuBq+kcIR7Qv+h9B2z6Js74hjgn4NdHGO8Of0b3lXHz8y9E+O92EAZXej3K/PAF9PHbgsJ+6fA08HaQGQniRWvWmx0JAu4SUCvHEU64SgR//ZX4r6BlBjcg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4192.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(6486002)(54906003)(33656002)(508600001)(66556008)(66946007)(8676002)(66476007)(86362001)(4326008)(316002)(2616005)(6916009)(26005)(38100700002)(6512007)(5660300002)(6506007)(186003)(2906002)(1076003)(4744005)(36756003)(8936002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Q5Ums4rr//fQ65z2dRb5m20fsxc4XCTGpNecpdeB55OqLnQBrwqnyhDixQoC?=
 =?us-ascii?Q?tZJI86FjB6/IcAl+LeS4yA6KCPpwuFZcPU+qzZKuJ1eUoLlSx+vzsYcOOGQ6?=
 =?us-ascii?Q?r4OycmN24xvF+6hjxT/uaWJCFCwpllX7j3AoKVwnHEmZsW+Y8a4lXBpsgaMc?=
 =?us-ascii?Q?bAzia8ndtgG/p2nnrk+/ZtNHdr0YVj7jL2x924V/eg0YLH6w+WrpHfRCs6dh?=
 =?us-ascii?Q?gPTmmlbZEcFOrpWNhz2wSYESFh9LDhSoJKWmIJy/wgScm46AaPMtITejVFOV?=
 =?us-ascii?Q?+Lbu8Yl/aNfLQZVEnPJINuxBNWh3w6fez2M9ZeBICMG2Pq6Y7XB6jxH5ujaA?=
 =?us-ascii?Q?20o4LVnGepAL03pkOj1twTAWUQjyLbwdVrLOM6vBatKorplpQrxLqutUrjCX?=
 =?us-ascii?Q?G+13tXcafjhVPOTgIMwuihP2GwmIoYBV4/K6CE1DroOEV2WKZlySAqk3IZRA?=
 =?us-ascii?Q?YqRy0foV4A6xbPKSyQDSz/LPbabkYv9ussKkvyvXoHx4ZZANirQ2LRk8tii4?=
 =?us-ascii?Q?MPHK9pV+1eSmQrcS9dQaZ4C6X0glZQpp7//qY0lmq2dP09lsO/EMoQobkUOo?=
 =?us-ascii?Q?ideKb9UTwXusn20EolRFBYpUGMSpVSpMJDTaTwwiZs+u6O4CMey2twP34zul?=
 =?us-ascii?Q?NpwPAhpeyXpgsQQGuBI8L02Wt+rEz0coq8OaTB9ZK/fmyqi5RQqYN5yUTTl3?=
 =?us-ascii?Q?lmroRSTE8MCzcZi2W2LdWnkHM3QcnayPl8jzNjvnaTCI/mNObn31+GaxJitM?=
 =?us-ascii?Q?e7f4LuZ26dYQOZeeCyANr2G06LzXcIPOuU6WhF/GX0dKpKVTiE+HmG1qoQlO?=
 =?us-ascii?Q?DGubZQMM/gEikmmYDLsycBu4LhojRcu807jjbBa/p8f3Hses1TxjLkwLBPR2?=
 =?us-ascii?Q?43X3BMzdxXMAJ339Gtye+65BSLgOy0xx33cV1q4dZH0RuKU6S1QwoT8Qgz5w?=
 =?us-ascii?Q?QqjpG7MnEBktgOiDsVz162e8K5XWH77pgc0S8HgHUyicDkc6WKL5fnGnKxMY?=
 =?us-ascii?Q?Fm/9ABajiwd0wODJf7zHplts6kpB1VFxj3sHGL3B987MtRx3vPRpU8OBGwKK?=
 =?us-ascii?Q?2trSPt8AAIsriItN8+UpXIatO0sycndCTw5Sx7MsH1p/z00oqgLRFOZ6aI2y?=
 =?us-ascii?Q?p5SinUOAcRDAfwwoXGg/xGhgdYchfRzuvfNWnK5RsjDrivO9zAEwTK7ourYL?=
 =?us-ascii?Q?Xl8UcjMmbRDQ/5oojAS/0ijUv3i9p9ApPqDBA2sdZWfdoO82GPWpfXenMs7f?=
 =?us-ascii?Q?hp2m0MXdhoX2L1S6deqlcWfn5df5LRslSluH1iIolKzdZlT46xpsmnf9TkJP?=
 =?us-ascii?Q?+x2FUHUwbt7fx4uwbJhj/vQkMdt3ONYrC0nevsGaHrNzwOHXd/mHjaDGriXq?=
 =?us-ascii?Q?os6dHbHba98GNiTTnmOuAuWRqWipOczKTnJLgl4WR/DkFQJFplaX79otYdUX?=
 =?us-ascii?Q?R8Tm65RdXdcSTkZomSkae+i3kkW7ijlRcf2/ai03JjXXecjg7pH0pclhv7ek?=
 =?us-ascii?Q?AxcvAMRJZzLosAcwbd3NVt9YO0tbYeBVKuxJrv0gjbRSikGXG0ZkeiI7yyMt?=
 =?us-ascii?Q?IINAnHK1WCTMpGoQeEXkc85NqnqdqDnx7QOCBYNqxYgNLZWLq5GDv28uk16S?=
 =?us-ascii?Q?fS8Fuu882Fzg9AGtin77bY/FjGTLOzaoX11rtKNMifAPHSWu/c6QzSPhjxaK?=
 =?us-ascii?Q?VC7d2SFdetdYlHnP0zzH/zu3ZXTAeAWKhQNXTKbd8B7Mge1ISxOTUtUEP72Y?=
 =?us-ascii?Q?tYd+nCB8Pg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f30a86e6-450e-4e2f-6d4e-08da31ea5f4c
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2022 18:33:11.9005 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GlYrfGBbUjgQ9waBMXdAMpAZ2T4V6Vzq8/ao98fg/EaaZEPuVEyub9yfQK8gA+zR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5812
Cc: Kevin Tian <kevin.tian@intel.com>, Qian Cai <quic_qiancai@quicinc.com>,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 Alex Williamson <alex.williamson@redhat.com>
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

On Wed, May 04, 2022 at 01:57:05PM +0200, Joerg Roedel wrote:
> On Wed, May 04, 2022 at 08:51:35AM -0300, Jason Gunthorpe wrote:
> > Nicolin and Eric have been testing with this series on ARM for a long
> > time now, it is not like it is completely broken.
> 
> Yeah, I am also optimistic this can be fixed soon. But the rule is that
> the next branch should only contain patches which I would send to Linus.
> And with a known issue in it I wouldn't, so it is excluded at least from
> my next branch for now. The topic branch is still alive and I will merge
> it again when the fix is in.

The fix is out, lets merge it back in so we can have some more time to
discover any additional issues. People seem to test when it is in your
branch.

Thanks,
Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
