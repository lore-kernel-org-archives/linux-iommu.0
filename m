Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D837C433F5
	for <iommu@archiver.kernel.org>; Thu,  5 May 2022 14:07:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B22FD83E75;
	Thu,  5 May 2022 14:07:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id M6t6bdpE3Tsz; Thu,  5 May 2022 14:07:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 917D283E09;
	Thu,  5 May 2022 14:07:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 766DAC0032;
	Thu,  5 May 2022 14:07:43 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D86A0C002D
 for <iommu@lists.linux-foundation.org>; Thu,  5 May 2022 14:07:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B894661104
 for <iommu@lists.linux-foundation.org>; Thu,  5 May 2022 14:07:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id M7OqEvlBX_yW for <iommu@lists.linux-foundation.org>;
 Thu,  5 May 2022 14:07:41 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::600])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 08E2F60F6C
 for <iommu@lists.linux-foundation.org>; Thu,  5 May 2022 14:07:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PnI6M+OZ92GV1azJxmyeuOVHQWB8UcNuzSAyBcDGTmPYO5dJH3efWRs5gA2WBOSQEbleWbg4TRzjx/Ycc/ttfkFjyJhUrB/mvEFmGhy+4jxk606o6m4iQ6L7/rjfEMrAKPGEC2Z5nLhe4IuUcKnfkks37lbuhKKLJHerXRUDiay31E0lh6ek8AsPhQKG3LhCAQuhuH8mZcoA8ki3frbWw4CMa0EvtQQQKrpxh8liWwW+RzSr6L2Duw3f7h0pgMOnAF3oxR/6/jogUffIpIVAfVUsLMHi01sAM8goRAwUyCc0cwOOmkjRs/8jAKMa7uVyp0GYSpoBzmt38D7o6KW5yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xyAaW1lIBrsSC+pZs3TUhellxRs9oZaoO6XzykLzaxI=;
 b=OhMaGdxwrrhjrza2MiuuGizP6seiEAZd+Ax5ChNQNfrMJl8fYgT4UMfzzZuMmX48uQzqpKNaDPXu1oi4HbG+TuqbIIfQNIhJDyVcow/xl1DFz9vGTgcEmJiPZqztv9BKhIo9NxFQxI3Anx66SJukiZhfqGi5NyDOrzpIQji1lv0JV2urj9VOq2IQ4k59D2zf9yUef0SmakLxEURJMKIR/Sc5wAMBN5gGzh8Jzf6RwH+1/4IebkwlL660ztcYSA54zk2WehKGQNB6u1TZ1r716e43owr0pKoE7YosdG4Lyj+X1iqdbNaB1+b4kGWJLi7VwwsHpbreXO1ZSGLdZmBoLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xyAaW1lIBrsSC+pZs3TUhellxRs9oZaoO6XzykLzaxI=;
 b=hAkQ+beVlfxjEJCktkvgOjAlFZRemXPzTAQyMg/PNyl+VxtIwiKmZ1t6XOm0BmGWgUgcT6vC+Av/3LTSlUKXJEii2nImIj2Kb1Tepp02q5LG9z9g8I0F64YJPlsbCaxfJDQGRF+Q40+vuQkRmE+t+3wsGAzqe+m9jmxhXagbD4WEXmDBxx5eacQCvYaPqFTQTDuOyL8E6woHK1D/5jUiTPbE4OEWFFcNrAtDf+0cmUpy+hHc+Kk2shh+HqLucJ7jgTOmxui/oA0op06//Buy3pD3V7ymmdQ5e6jMItm7ObHcXABLLXQBBQiiMKc8FaVqJLhUbV9eBYQ/v8hBdyZo/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by CY4PR12MB1493.namprd12.prod.outlook.com (2603:10b6:910:11::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Thu, 5 May
 2022 14:07:38 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2%6]) with mapi id 15.20.5206.027; Thu, 5 May 2022
 14:07:38 +0000
Date: Thu, 5 May 2022 11:07:36 -0300
To: "Tian, Kevin" <kevin.tian@intel.com>
Subject: Re: [PATCH RFC 00/19] IOMMUFD Dirty Tracking
Message-ID: <20220505140736.GQ49344@nvidia.com>
References: <20220428210933.3583-1-joao.m.martins@oracle.com>
 <BN9PR11MB5276F104A27ACD5F20BABC7F8CFC9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <f5d1a20c-df6e-36b9-c336-dc0d06af67f3@oracle.com>
 <20220429123841.GV8364@nvidia.com>
 <BN9PR11MB5276DFBF612789265199200C8CC29@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276DFBF612789265199200C8CC29@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: MN2PR19CA0052.namprd19.prod.outlook.com
 (2603:10b6:208:19b::29) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2d11f63a-26ef-4dc4-23d8-08da2ea09c73
X-MS-TrafficTypeDiagnostic: CY4PR12MB1493:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB1493F5ED7046794EB4835B48C2C29@CY4PR12MB1493.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N9hiZrZIPuKqElF5rLtqa5fW26JLHDEW3cm4x5PTwk1xBbptJUTMu14n4UbZri8awMyRZt0nvs3oatLWAB3hmL5T1O61PkbQNcLOzavBmR7VSmwMSOIDL4AY2bsNOXsrT2KLjrRANIi56yxAXY78ihJisyyYax4GK1nMga/yL0mDh01/eLczZXHdMqxSN78UFJSlarpUekNtb9HsmPfjF/ijwsPs0lw694wB3qYvdgEykjE7+l3RiibHHAhjIX31KndeXam3ckaxiYbD0fy+GXHTAsDUPdS/yKWJgbrTLYhdoMcjkc1E7DkvTjOUEEm5XjwWV1lhcZXfyhac2X4MlYrN2oOSF6p9Wo05VyqH12E7tp+N+fUJ8rnSmxn9m7U7aOpITn5iPl3FwNaGSKIpHQF6CDc2eZlLYNdXNzHjx8JDVr04AmPu3Rgrrvq3MyTmTLvV7dnJYgnpEa0wJ4K/8jBP2lLsP+KXTqzq8t9fDuGt7LR7IOOeeaQFoJx9vlNQbzbVoGTo24BYsO23ueRwIVNH0kb/cUKNzYrudoFyZ4m/WPp6qxTZFMl39FYnfONrxog2/dIQIwcpB79FULVHz1jxvmtc23PMAah1SQz9++jxhXfQVrGC8rldHpGOsvVKV+a1nBVzZkAosM4BFitj3rQ6ZxuCXz5UhNVFtqNhaPRzILFe5VwxFWGVd5Dq4qbd
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4192.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(316002)(26005)(1076003)(6916009)(54906003)(2906002)(6486002)(38100700002)(6506007)(86362001)(186003)(6512007)(2616005)(36756003)(508600001)(5660300002)(7416002)(8936002)(8676002)(66556008)(4326008)(66946007)(66476007)(33656002)(14143004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tlZBcaQhRUf7hcqxqH3NWKmbiJIM/7UfojJpMtC2HycWicz26FeNEJ4Y0fYt?=
 =?us-ascii?Q?eD0UI8rBs/kpmC1hNIJSPA4jFWhmCMUdws3iChxPaUy5q3zI52mbPNnc6sVU?=
 =?us-ascii?Q?JzLkZU/20rQL4Y3TSIObC4327E0LQOs9AyixEgRrt5calZ1NRkY/8hocaLeq?=
 =?us-ascii?Q?/TQ72MeK7Do2Dg3jDywLXGeP25DvBuuCe05e1BHzPNUV3RYQFlPHjTqZ4b0W?=
 =?us-ascii?Q?O3md3/8ZVAcO+8k2gZ29QsH8GUJMCFcroaHhrShIPo1p+6c7lF+Bd7/lmdWc?=
 =?us-ascii?Q?2uakWvcA0DE0zdqZp1gfjfQ4EdABa93IgLW6Bn4BQonw8SzrXoH5n+2TT107?=
 =?us-ascii?Q?sNBwdcxvYYi0Jdos9+DOpbdyS6wYsCBn1VNzvz+l7tOVBS/7lvrIMHnK3Ioe?=
 =?us-ascii?Q?FYWiB4pJ7bHuBOUzIYReyreQh+0RME98s406geG9W4gddtqMod8sneGZPTmz?=
 =?us-ascii?Q?GNMbRuq7+hdYhgsmgJ/KKS97TOdZpSl9LYHHN+GXotIj8WVRSOBx0AerUVts?=
 =?us-ascii?Q?GBrvwCBFmNr4SFGE3ZwGzgTee0YbKBMnk4m49Iom+gwzoz/gb6lI+3M502Tl?=
 =?us-ascii?Q?vPdP+qtMQWGqFuDJ6+5tccwNkX4BuRerOsmnLPKguiVNFgRlXXIP7xzxBd5w?=
 =?us-ascii?Q?ETpxZ8ivmimPFlltGV/OhMAaleCqTs7//1XdOXY8KJCQQ4Yj1oVGAKatvR1+?=
 =?us-ascii?Q?uzzSJCRJ5ZVFzgsvitBgo/oI+sOjPPDqyRike9Fk+ce7cVAotDDNRjQfRXYi?=
 =?us-ascii?Q?iuFmq6+u+pnbynFZED7j6KXFUlgsmYE3V2V/GpsJs1efi7iPBXk1thnOy7Rf?=
 =?us-ascii?Q?EFK7/z6yMAR6x5BGJCQUtFdKm8pPZYyfc58C2180P9Fir1Om+Tmc7FRwGVsj?=
 =?us-ascii?Q?la8rT1LF9hD4vaPz4H4M1QToWXXJFvncp+5yGwk9DO0ZuBbTq321a0tknZBs?=
 =?us-ascii?Q?HjkOfdrScEQ0Mq/KBSgvhyCc1QtK1EzRomdWs+K/68EgwRKt7sZgv5K4yBvo?=
 =?us-ascii?Q?5TCGOoa1a4vNJmu8vXIS01qx9tkIf8gV+Y+K1nZC6vy2P8K5GVSRnFtnM9To?=
 =?us-ascii?Q?RuTKIUyg3QNDgLjSPSn5UIDU1vJoBvuLskIUu8J3aXCiAHo+ETDo8bMlK1d0?=
 =?us-ascii?Q?biyJ3iAGrS4Y0yg1D61aaTZ4w3Yd0D+xdWpfVWrvN9HzAjtXRt3gFRqmjQ6I?=
 =?us-ascii?Q?u8wC/h+FUAUWPlMD3PdJhT7kr5CuzWrcoSolqqn454gxgAVnlXK81c7fvoOX?=
 =?us-ascii?Q?1Mdk1ypXuVckI0zJK9I+GBhycL2XFfEkRs9EUtHRTugv5aL16+D9rntPMB/W?=
 =?us-ascii?Q?cvARzgl2nQKtUKWA1c6hmtOF4CwSjzNlcACOHeeUGpTKZ1qHqJKR9YE5+V6h?=
 =?us-ascii?Q?XF2JGeGsYmeZ99JnGiKMR9DMhYRrBeiusq8HnaOpWvJP7d2D+VkzeCZpXjL6?=
 =?us-ascii?Q?TsI9eSzeYzJfQ1/Cj9V/Mv830I0R57vtcLXD/nGwOhPzKyPiHBW9Nbbdw4k1?=
 =?us-ascii?Q?VDgfZ5V5HtfFd1AQqJP7NhLocUoZc7f5zZ8nE1yDYz7+BDCvE+A0XXG55Ttf?=
 =?us-ascii?Q?3Zhu8Gkka5ARlaEDvhKr9o9LCuV5o8gzqHRrjYUqK8ygt4eMz2p7WddBNupA?=
 =?us-ascii?Q?ZUn9w5yjVuqE35XaZ2ye49Q8g4kbcLTw7orW5ivyC8lAK63plh1quXfcqcva?=
 =?us-ascii?Q?7AzkjA9+iRQgGqoCzjYO6clphzuLCqaCXHqorTIwvp5zLfLvYwvYsxfN9Bzh?=
 =?us-ascii?Q?X08BGAyflg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d11f63a-26ef-4dc4-23d8-08da2ea09c73
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2022 14:07:38.2501 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EP9UIAMX8RObVs7z1QH8Teqy1ZkAlHXDzR+7Uu/CPcgN2Lwar+Am6HsB83F2L/VZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1493
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Yishai Hadas <yishaih@nvidia.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Will Deacon <will@kernel.org>, Cornelia Huck <cohuck@redhat.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Alex Williamson <alex.williamson@redhat.com>, "Martins,
 Joao" <joao.m.martins@oracle.com>, David Woodhouse <dwmw2@infradead.org>,
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

On Thu, May 05, 2022 at 07:40:37AM +0000, Tian, Kevin wrote:
 
> In concept this is an iommu property instead of a domain property.

Not really, domains shouldn't be changing behaviors once they are
created. If a domain supports dirty tracking and I attach a new device
then it still must support dirty tracking.

I suppose we may need something here because we need to control when
domains are re-used if they don't have the right properties in case
the system iommu's are discontiguous somehow.

ie iommufd should be able to assert that dirty tracking is desired and
an existing non-dirty tracking capable domain will not be
automatically re-used.

We don't really have the right infrastructure to do this currently.

> From this angle IMHO it's more reasonable to report this IOMMU
> property to userspace via a device capability. If all devices attached
> to a hwpt claim IOMMU dirty tracking capability, the user can call
> set_dirty_tracking() on the hwpt object. 

Inherent domain properties need to be immutable or, at least one-way,
like enforced coherent, or it just all stops making any kind of sense.

> Once dirty tracking is enabled on a hwpt, further attaching a device
> which doesn't claim this capability is simply rejected.

It would be OK to do as enforced coherent does as flip a domain
permanently into dirty-tracking enabled, or specify a flag at domain
creation time.

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
