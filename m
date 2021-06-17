Return-Path: <SRS0=K0Me=LL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_RED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF08FC2B9F4
	for <iommu@archiver.kernel.org>; Thu, 17 Jun 2021 23:04:48 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49A24613BA
	for <iommu@archiver.kernel.org>; Thu, 17 Jun 2021 23:04:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49A24613BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0DC12605E5;
	Thu, 17 Jun 2021 23:04:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cE2SiRz3t7Zq; Thu, 17 Jun 2021 23:04:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 3F14A605E0;
	Thu, 17 Jun 2021 23:04:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F31A1C000D;
	Thu, 17 Jun 2021 23:04:45 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 62615C000B
 for <iommu@lists.linux-foundation.org>; Thu, 17 Jun 2021 23:04:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 56A3883CB5
 for <iommu@lists.linux-foundation.org>; Thu, 17 Jun 2021 23:04:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0543YgvuSbhw for <iommu@lists.linux-foundation.org>;
 Thu, 17 Jun 2021 23:04:42 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2075.outbound.protection.outlook.com [40.107.93.75])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8128B83CB2
 for <iommu@lists.linux-foundation.org>; Thu, 17 Jun 2021 23:04:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TXkS6tPf69kxnM3PqIN5NnQC/N8yi4iVs5+zR/BvftF5t+XaTkfu6YW6qtBZCXy0YyDNdEDoAx+buOoY4S+vjmHbZkogiIrevQxdokbyOz1rWZTbGu7wRFQ+PrK90/8cQvnLn/D7E4X9GFfoSN62FGXsTBwTTy9NeKKBF+Dqz5WTHP1S4+xbPEk54GdUkqiq8nDxDZXSL5CeD3twHL2DoyKlW1jtepNB7rTlAMk5M0KX40uLdf3iewyHvJDc59hziFhrpw5AdRfa2bX+sV7M6HwhJbR8UM0GS7q+P4ZErm0rcCWTuUg3NkEzbIcHxTSDW4V20Wi+VoprJaAbay7/iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=57nNh4lj915iJ3BJAgiLrcGLbj4HT74P9lAEQffvS8Y=;
 b=TEXIc++3xa9IGaCrh2N/QHMJRBV2yp4q+YXoKx/+cR5c7ZypQfVte1yLrHOha99LYriEQvU3nP3BwDgb5bncu3Q9u0BAB/WpkoHDsVPAfv0W7xJBYFSxcDEIqfPRj+TkAbGYD/Fka0TkXaI4mH/LBjGO8XMeZlrb4WflYjMr25zYneSN1wDaHgLKktS4FcMrQODzT7fAfzpwJJC7zlKYfESdL7yIgdnszczKMuQUkLc9+jYMaDHYtbtPqGQuDVUWKtrmSQrrnbrfc0a9P7reeRWVNsHo3mmZMNhWSnV96vSMR2r1uFyGEcipOsSqYa4YkhQaT2Oi0b7xqEgcqnvMhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=57nNh4lj915iJ3BJAgiLrcGLbj4HT74P9lAEQffvS8Y=;
 b=t6V+qW1Ee863nhNnuiJuWXxmVWCh4Id3NH6G5zeOF5Ti1nG0r5ESAo4DdIzIRDxpl1ZVkaZGcH+VhdX+an795Qnzf09KopcPkQLsiHHGQcvjHCY97QaaETkh1peVFn4E/rZY05pnTw3Ej+M61RNfkMec/dTET2B3oapZcMUO0YT64r7r4AIJR7aJAoJpDzWtIO1LyhAUvKnDnd/nGhzSceDFelbmZC/esn0gjpPenPxrA16csPXA96JfXYdSvzey+2V0icKP85PIjDTabtXivuGlwf3mnSnYobtkfRSA17dR+jNHD4ZVarmUokFoDF2vDNJznTrWubm2q1W2NBn2ew==
Authentication-Results: gibson.dropbear.id.au; dkim=none (message not signed)
 header.d=none; gibson.dropbear.id.au;
 dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5128.namprd12.prod.outlook.com (2603:10b6:208:316::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.15; Thu, 17 Jun
 2021 23:04:40 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%8]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 23:04:39 +0000
Date: Thu, 17 Jun 2021 20:04:38 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: Plan for /dev/ioasid RFC v2
Message-ID: <20210617230438.GZ1002214@nvidia.com>
References: <MWHPR11MB188699D0B9C10EB51686C4138C389@MWHPR11MB1886.namprd11.prod.outlook.com>
 <YMCy48Xnt/aphfh3@8bytes.org> <20210609123919.GA1002214@nvidia.com>
 <YMDC8tOMvw4FtSek@8bytes.org> <20210609150009.GE1002214@nvidia.com>
 <YMDjfmJKUDSrbZbo@8bytes.org>
 <20210609101532.452851eb.alex.williamson@redhat.com>
 <YMrXaWfAyLBnI3eP@yekko>
Content-Disposition: inline
In-Reply-To: <YMrXaWfAyLBnI3eP@yekko>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: BL1PR13CA0407.namprd13.prod.outlook.com
 (2603:10b6:208:2c2::22) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by
 BL1PR13CA0407.namprd13.prod.outlook.com (2603:10b6:208:2c2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.9 via Frontend
 Transport; Thu, 17 Jun 2021 23:04:39 +0000
Received: from jgg by mlx with local (Exim 4.94)	(envelope-from
 <jgg@nvidia.com>)	id 1lu13u-008JqX-9y; Thu, 17 Jun 2021 20:04:38 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 98b10d07-bd8c-4cdf-8bdd-08d931e448bd
X-MS-TrafficTypeDiagnostic: BL1PR12MB5128:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB5128ADD39931FE4FD56DF68DC20E9@BL1PR12MB5128.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q9Ul3MS7Juckqr1CwU234XkBgPwv3fcJe8nUaNsi9rsFn10v/5RP+e3LWzVNOW9qWrZr08mH69+HIPa646Rgfy7xs+1z4OVyqxm01xGXIDOB8BHu49dJUf65uOmx0Ka2YicemKvMPLAJFgG3q4AzXe5eGHc7dUkzKXq2YU1DPSs+nAmW5xdK9NLYqKGmmKOdHwUlKBKVs88wNCaQjFpqVuPPa3LrT7ArybOPqeYJ99H1F6e6ESInclK4orOhgJes+TN32i6MZJm2c2mVcuwbqxEje++kreLnLyWDqOjRn5n9MFQOfdo8RziC1dSJj5R1dasi/8JyN2zL5W4C1p+KjWbU/SmVL4vxb2x9vKcJppkliwryi9jpL9xDqo8OSx8d0y6ZjDg0jWpCKfN3N3YAc2imGBvBGuiD6slHM0fEeDjJEXoxZzXzL2ffu8SNfgIaWCQZ8LedajRf3beuWBUAMxbvhU/GRqwZDMQzLTvfUd0vbO8+EYMDQUjtiFIIiNN0cwwZni6AuY5hKeXf9VvEByuFWpGDpjgDavegldWu9dKdJ+Ymg6v3e6PHZxQKwERF8oQafRYZu26VeCDPqEzh9je+eDMVlSwGstm+/LYo80U=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB5506.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(376002)(39860400002)(346002)(366004)(66946007)(66556008)(66476007)(6916009)(186003)(4326008)(7416002)(2906002)(26005)(54906003)(5660300002)(316002)(8936002)(33656002)(38100700002)(478600001)(2616005)(8676002)(86362001)(83380400001)(36756003)(9746002)(9786002)(4744005)(426003)(1076003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XvBb7bUf9LcRp3GZzrVWCmZ3K+QbAlhbEIUmE0zxFZivz4g0mQZOleFyfCwa?=
 =?us-ascii?Q?rGdVoZKeA3Fzrd0Xx/CMkOYsr1Q/9108ZI7/E4WvtjEifDNsR5gYiRyqI9pO?=
 =?us-ascii?Q?5iwdEYaYyCfq2Qy6RJNCPqbHoguYJdvq4wkqJU8Pv7ijc7XjRnGrUeTL/wNf?=
 =?us-ascii?Q?jFDX7ISfLxacwChPGdpPw6yFtXA/g69arWqmmaBVnt4q7mUC0bjQrmHGf4sg?=
 =?us-ascii?Q?IvUthzacty83c0aASyslobpEIIeXwuIRvPZgTsx6CDaVsHz8btlKta4lxfiS?=
 =?us-ascii?Q?O4wZRZolxtEevOp7AKtShEpzwyVv8W7ctrKJdaTNuNhMPCucmfIKFBJ34S/i?=
 =?us-ascii?Q?dNSguSlkYZB0txwDwJLDPBtA8eFzhMseyBQ2Uy9bNeZ2nE6dx32IOREcTVMC?=
 =?us-ascii?Q?LM0gi7o+WpoBUQVpndZbgPiy42HeMZ5v6MrsZT6RyddDxJ5C7nVqenBvE2jX?=
 =?us-ascii?Q?yJagXKkTV7Z4IdIxquVFaaqstkxGi36kSXK/pB5MWhg3kzaYE74BR0mhsxsm?=
 =?us-ascii?Q?ixluGcENcdgR3ouE/NuXcuZptTHqtkF9V0r17OBbGT4rG/BqegC+ch6ujMA/?=
 =?us-ascii?Q?/73fsuAzO6ByPRpPUcmgxG1reRytOj0BNqFmLUjawft356A6q1lePjCl9LD9?=
 =?us-ascii?Q?FKCYqJw8aoLXDPc4rGzLZ+mm1lIC8Gy0lCTG5Cd81mNYsQs7QhwEeZL562OP?=
 =?us-ascii?Q?22r4nDNpDjWt5v5fnUkmVe9V+I2rfNT1PgpHBcRmwnxN2F08Mdp9eCoHEj1S?=
 =?us-ascii?Q?dDwjuleMTwOpnmbCvaZdaVLqeg7pOt8MnG7r/AYL9bGbEVdY+Xi+5tzmOd1O?=
 =?us-ascii?Q?JRSlTaYCOByMiHxW5gyyw9tlMCbf3p0uN1bORnmwQoWwKPDK2+1UTWAkfG5c?=
 =?us-ascii?Q?mYysVXu3t5BNkXk3e+7OltWV/BSo2ybd8D+tP5w65gPKEwGXDUgHvRtD2yov?=
 =?us-ascii?Q?xXdaETN5c747CM4dbTfQNYzLbVi3pQlHjNFwRENpMCulkmY6pz12xGiGfiqX?=
 =?us-ascii?Q?YHp9mG6s5szMtDO9UbjS9evcJOhsaVeYQF6cgZ1nYARb9/0qlnSDpSJYTZWd?=
 =?us-ascii?Q?568gJdSlETW7DTHKFpDicvrqXMnbR0d1Oc1SybdYLNjJ85vrlHZk4EfLC9yS?=
 =?us-ascii?Q?MYysbDYMwZ985glA0H+QBm72BCb3HRFLl62HaGjaHavtnYZe6j0pEfjOjp6i?=
 =?us-ascii?Q?O+GVGh+6iCRMlzQ8phGN9GE1hsqfBS8WHYpuK6yZzMobcesfbrIxGcg6u2CA?=
 =?us-ascii?Q?98yzbrl0Lh732vieqD/PgYM8mpyoWRmfniaK2Q31gCltc4bKy6ocguqpKSaL?=
 =?us-ascii?Q?EVnKmSHWPwRg69hnNcx64qYF?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98b10d07-bd8c-4cdf-8bdd-08d931e448bd
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 23:04:39.5328 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D8XxTH0ANlGnancXx3KoO+OsKn1QvR15aTsF9Ja5TUPzIYzQUMczMYNrinRMHZtI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5128
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Jason Wang <jasowang@redhat.com>, Kirti Wankhede <kwankhede@nvidia.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>, "Jiang,
 Dave" <dave.jiang@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 Jonathan Corbet <corbet@lwn.net>, "Tian, Kevin" <kevin.tian@intel.com>,
 "parav@mellanox.com" <parav@mellanox.com>,
 Alex Williamson <alex.williamson@redhat.com>, "Enrico Weigelt,
 metux IT consult" <lkml@metux.net>, Robin Murphy <robin.murphy@arm.com>,
 LKML <linux-kernel@vger.kernel.org>, Shenming Lu <lushenming@huawei.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Paolo Bonzini <pbonzini@redhat.com>, David Woodhouse <dwmw2@infradead.org>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Thu, Jun 17, 2021 at 03:02:33PM +1000, David Gibson wrote:

> In other words, do we really have use cases where we need to identify
> different devices IDs, even though we know they're not isolated.

I think when PASID is added in and all the complexity that brings, it
does become more important, yes.

At the minimum we should scope the complexity.

I'm not convinced it is so complicated, really it is just a single bit
of information toward userspace: 'all devices in this group must use
the same IOASID'

Something like qemu consumes this bit and creates the pci/pcie bridge
to model this to the guest and so on.

Something like dpdk just doesn't care (same as today).

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
