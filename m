Return-Path: <SRS0=FZ/Z=M3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B356C4338F
	for <iommu@archiver.kernel.org>; Wed,  4 Aug 2021 14:04:56 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE48F60F94
	for <iommu@archiver.kernel.org>; Wed,  4 Aug 2021 14:04:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org AE48F60F94
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7ECB8404A2;
	Wed,  4 Aug 2021 14:04:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kcoPCcYAzENo; Wed,  4 Aug 2021 14:04:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 5C00D40378;
	Wed,  4 Aug 2021 14:04:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 33E95C001A;
	Wed,  4 Aug 2021 14:04:54 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9D5CEC000E
 for <iommu@lists.linux-foundation.org>; Wed,  4 Aug 2021 14:04:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7998340398
 for <iommu@lists.linux-foundation.org>; Wed,  4 Aug 2021 14:04:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ed2yQW4tK8QC for <iommu@lists.linux-foundation.org>;
 Wed,  4 Aug 2021 14:04:51 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2057.outbound.protection.outlook.com [40.107.94.57])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5275040378
 for <iommu@lists.linux-foundation.org>; Wed,  4 Aug 2021 14:04:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y43FUj1nye17suq7A2XOSs0VdL66KHDOkUB1z7fl/sl/K3M6rTjvL5NzFv2lgXE3mnExMiuzH9xXrYaNMjbVkMquxkp1MIelg3UqjLkzt1zQqJufSQLnBcNtdeTLM9aHynRFtSTlaAYyj/K21iw6kLMXXeYGttqxQ0GKONUYIlSCAcsuH+BPbpl2lTFA4/vQY5IE1JgsiD6mm9nEXUnlySEHDWGaP/VWYba48gZoQgVZMVBO8YjhlH118rGuW1cH/HlLMIKQBvoZzULKF6L0DfRfJritVysOiv1HJmwAOmfF4eOT1WsZyNv0ohqxKpvSSS4/1zgNwMhuciec0NdBtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OutaHicx1472GLKvTK3Di6MPdFT8419t24QpYyasbfA=;
 b=NDeq3778TtYd7bTNBOtjCQSMptPlvKSIpKvOwpUcrzlFvOYwtq39tB0Y48XcEiVuBaPCApV0ow+tsJuHoY7qik4QMGi8HBivcBK/kDovRhXw3Mrbein/7RnJtmpO6lnTHpYP/Qcucp2vnwN45QTmkOllYr9CyOYH/1KqjBBlEhKjqtEjDA4t2prCo4igLXaWD8WHo15jQDQwI9k9bBi3s1r1J18lOSTknC1O9BaKhVaUJspX1FYURuTRZP2uanIMse526s385KOlb5f8FRNlwtrFDQld5FE2ApofY8bVIxIffzfQ9wyoi+JM3qwsnVJtnE//OzzLqLZ4xkdevU2b9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OutaHicx1472GLKvTK3Di6MPdFT8419t24QpYyasbfA=;
 b=OG+qwFKGs9X60jek9NKTiBGO5bEbRkgjbPCuRunRcN/Qe/ryIe510/17ifZHHRgKgdlMnm70/eemh4Lts5QyFn0FitYnQ+XLHr0aoLsLr+YItN/oyUCbt+uFHCmZe8TYxHYT1G7UlEBS3HC/CnysxvIsMaIHjqETqhGa9yRwdjmkMkw16mMC/kTL3Hbq3qr879tf+5I1zJYsV51w3u2pWVEHNJhGoyJSs8BVpSC2bW/M+bFk43vHOyu721Jc8JUKohsDCZxjCXM2LZyLXPEo/3IuX3mzHbgH9sDs9lQWauErdOMNV53lf7tVZv11ofSAbgvMMhE2XDWrFDIuR1Zh+w==
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5520.namprd12.prod.outlook.com (2603:10b6:5:208::9) by
 DM8PR12MB5494.namprd12.prod.outlook.com (2603:10b6:8:24::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4373.21; Wed, 4 Aug 2021 14:04:49 +0000
Received: from DM6PR12MB5520.namprd12.prod.outlook.com
 ([fe80::81bc:3e01:d9e0:6c52]) by DM6PR12MB5520.namprd12.prod.outlook.com
 ([fe80::81bc:3e01:d9e0:6c52%9]) with mapi id 15.20.4394.016; Wed, 4 Aug 2021
 14:04:49 +0000
Date: Wed, 4 Aug 2021 11:04:47 -0300
To: "Tian, Kevin" <kevin.tian@intel.com>
Subject: Re: [RFC v2] /dev/iommu uAPI proposal
Message-ID: <20210804140447.GH1721383@nvidia.com>
References: <BN9PR11MB5433B1E4AE5B0480369F97178C189@BN9PR11MB5433.namprd11.prod.outlook.com>
 <YP4/KJoYfbaf5U94@yekko> <20210730145123.GW1721383@nvidia.com>
 <BN9PR11MB5433C34222B3E727B3D0E5638CEF9@BN9PR11MB5433.namprd11.prod.outlook.com>
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5433C34222B3E727B3D0E5638CEF9@BN9PR11MB5433.namprd11.prod.outlook.com>
X-ClientProxiedBy: CH0PR03CA0100.namprd03.prod.outlook.com
 (2603:10b6:610:cd::15) To DM6PR12MB5520.namprd12.prod.outlook.com
 (2603:10b6:5:208::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by
 CH0PR03CA0100.namprd03.prod.outlook.com (2603:10b6:610:cd::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4394.15 via Frontend Transport; Wed, 4 Aug 2021 14:04:49 +0000
Received: from jgg by mlx with local (Exim 4.94)	(envelope-from
 <jgg@nvidia.com>)	id 1mBHVn-00CbbP-U9; Wed, 04 Aug 2021 11:04:47 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c9c68e38-6d63-4c24-c512-08d95750d2ab
X-MS-TrafficTypeDiagnostic: DM8PR12MB5494:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM8PR12MB5494C6C7F0A079AA3052FC89C2F19@DM8PR12MB5494.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Gv7XxtdH8D9qIjlaSxwzwAW6Rzw+8+U5eLElvxuz7z6Jnl5ThQC/rx7vBg0Y4qLQz/CIhShz20sXq4mABYrxUQ4UYNI8YgVw5DbVQr+oS7xWG7DTgxLKly0w3yrFDzVuwFPitqMMQcUm8tHlaMe0zqfd0UmFPbuhXpwmdp1cVpi7kTZlpE2Hv3/ZUtGI9JQN16Gl4Q42dFbUgGE8uGBSa/TibGBI16ZvaOxDvfCdkEsr3I4myG2VUNmsS3XpQMhRMj7Sm7HMTqDQ7EecEvmXJ+1A0UPoB2ObYO4auSSazf+Vu80PKX91L457UUVpPn67PRUmwliHY0bLsZt8nKnVjavOF+ooFd3d5yFr2f1T4VM23HzsMKGcaBee9X4C0hdzYPjbY4RKghSmSrl1tyF2njx2naNDLz4wAWUEB1d9/QwveI+CgRlCW/94qH43MFNIZi7Fi4FZ6QNckUGzXSq38v66iiiB68+N7mKcGbx3kW1Ck3Gk4BAUdwIpd9gdhe8LwsrxaUqNMu8QVDS6fesdrnOvsMG9JEc8oichPQli8XKSKsN0uJjBYxzIQXShp7zXx6L4YRnBTqRlwuZ7TSFsvt/qZ/jdUQJioZf1dZmNto3OPsuVnGk21becYnl442WyaJzgNJvi1y2OKT/wUCpUMg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5520.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(396003)(39860400002)(376002)(136003)(8936002)(7416002)(36756003)(9786002)(86362001)(9746002)(66556008)(33656002)(4326008)(8676002)(38100700002)(66476007)(54906003)(66946007)(2906002)(5660300002)(2616005)(26005)(316002)(426003)(6916009)(4744005)(478600001)(1076003)(186003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7pqhaeP1fKe9nNnCX1AJE9eXr8h5Dpc+rb1mUO6fBrT49Xo4zF5fqBgCc5T3?=
 =?us-ascii?Q?dE5A4aKfn8c+R1cIWE+pLpEE5oIP+4U5JJ04sd/KnhjOTjPC3J1YQ2DCKDGo?=
 =?us-ascii?Q?iRFls3n2H5z/GYmy35/NzyJHTS96Kg/br2UK8yXOHX8k9ig4AEgsJTZRpY3g?=
 =?us-ascii?Q?7XE1AHpdSGghmQqxyNpN16XuvFfXC97eRosRwLz7Cvrd6PjXE5YO+qZGq1dB?=
 =?us-ascii?Q?u489JQduvLrfrStfc6KRXwOMxiJr+ggO521M7Q035DptktakHcbBZJ2BtCtX?=
 =?us-ascii?Q?wZYgDnAAVGQndSTS3JgjTenvyoW9uWz4YZZ6Kt5xDIO7PukPm5sB9kStKJaV?=
 =?us-ascii?Q?Mp3mY/lREqDl0Oc0xWl6kJQvg/bKOF7ZBXci7WGfIK42ujdddJdTaTMBU9FZ?=
 =?us-ascii?Q?xujYHF/t6Cfo4zWVAZndeV/+Ui+1WOdTkxVx8yxRYt/dloNMZHCasivNVzKU?=
 =?us-ascii?Q?hB/9ZoxvhxwlHYgzD+TJDBETZwlu+wcV1I/yOA2VBTsspw84TP9bfmq88d4/?=
 =?us-ascii?Q?6q75VgfrnYJxP8DasftpFSiE7wAdUwpzXmaZwMyvnmAstkMFZyx25svSFUMF?=
 =?us-ascii?Q?U1ioBSXTSLU810oaIzrTSteIetBkTz0XZMT6MQ9eD0ysi4Wm1BqNPSb5Rl7P?=
 =?us-ascii?Q?q80Lqr6w0WJJLWJEWCYkH6t1bnymuz0iRCy23HL9KbhDOQyY0Xpmd7V9XT97?=
 =?us-ascii?Q?E+18LdPURbdOoqHnlwQ2Wsxh3gCSkpt+Yo0jKNa9MkqUpp3CODpBtmnNZuZZ?=
 =?us-ascii?Q?tc9gndEh1Ksr6jvO6J5sdP6QWmahVk1orPj+kAi1pi35d3CTLBRObUSUW/mj?=
 =?us-ascii?Q?iUsiw/oXnc2hHzhA/iD1BMpTujtV5KIACc9fSVC5KNzVkb918iRTLC3ttu7s?=
 =?us-ascii?Q?LxBPA6zJOwPo7t3FI3rhiI+3Xba9EIQPCiMRUNs2bHRTczCtfsNVN0rEUdaf?=
 =?us-ascii?Q?dhWiCAg0qvGAzgZXVPi/p7C/A/UtKG96HK8kcFctMxMSq2RewWHP29MgDmiQ?=
 =?us-ascii?Q?kTJQT0qRYzrGjQ0xPl7Nwdon748/9ks9qfKMtnzzcFQGkXqd84pMtPgE2dn7?=
 =?us-ascii?Q?RVjeWoMvN5BVebagWsr/YOpB6Tkt/b2QfRngYiFs7M7Ykz8wp1+48vDXdyqJ?=
 =?us-ascii?Q?SCWYO9xJonJHZjqjduh57EmX5sih1CTmD4orXsuHXVejXayxKQ0rTjJcuny9?=
 =?us-ascii?Q?s5Gf0QjrnD+2lOrQF83dRIBgwuUQfknUipQFY7H6GZaYxNS728EDEcNH4Mmm?=
 =?us-ascii?Q?uf6uXSFjK+uBlDdytNgWYqwfyk0tW2hPGGUiT8Z5NfuCtJlKyH0p76zs+iaT?=
 =?us-ascii?Q?2g1XmfcKLDejFbKPjY/bWSP4?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9c68e38-6d63-4c24-c512-08d95750d2ab
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5520.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2021 14:04:49.5338 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: arnZmJ0iZYMj/x87ECDahxzzjylihWu2ZposmrZA7NecZkQ/y44JGsN78JxkyovD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5494
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Jason Wang <jasowang@redhat.com>, Kirti Wankhede <kwankhede@nvidia.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>, "Jiang,
 Dave" <dave.jiang@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 Jonathan Corbet <corbet@lwn.net>, "parav@mellanox.com" <parav@mellanox.com>,
 "Alex Williamson \(alex.williamson@redhat.com\)" <alex.williamson@redhat.com>,
 "Enrico Weigelt, metux IT consult" <lkml@metux.net>,
 David Gibson <david@gibson.dropbear.id.au>,
 Robin Murphy <robin.murphy@arm.com>, LKML <linux-kernel@vger.kernel.org>,
 Shenming Lu <lushenming@huawei.com>,
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
From: Jason Gunthorpe via iommu <iommu@lists.linux-foundation.org>
Reply-To: Jason Gunthorpe <jgg@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Mon, Aug 02, 2021 at 02:49:44AM +0000, Tian, Kevin wrote:

> Can you elaborate? IMO the user only cares about the label (device cookie 
> plus optional vPASID) which is generated by itself when doing the attaching
> call, and expects this virtual label being used in various spots (invalidation,
> page fault, etc.). How the system labels the traffic (the physical RID or RID+
> PASID) should be completely invisible to userspace.

I don't think that is true if the vIOMMU driver is also emulating
PASID. Presumably the same is true for other PASID-like schemes.

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
