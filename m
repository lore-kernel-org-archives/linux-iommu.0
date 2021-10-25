Return-Path: <SRS0=+9ml=PN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16C40C433EF
	for <iommu@archiver.kernel.org>; Mon, 25 Oct 2021 23:36:14 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B378160F70
	for <iommu@archiver.kernel.org>; Mon, 25 Oct 2021 23:36:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B378160F70
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 75D39400FA;
	Mon, 25 Oct 2021 23:36:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NbKawV0xhj1C; Mon, 25 Oct 2021 23:36:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id A33C0400FD;
	Mon, 25 Oct 2021 23:36:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 87DD9C0012;
	Mon, 25 Oct 2021 23:36:10 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 38477C000E
 for <iommu@lists.linux-foundation.org>; Mon, 25 Oct 2021 23:36:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 33AA5403D5
 for <iommu@lists.linux-foundation.org>; Mon, 25 Oct 2021 23:36:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8rRwsyF2hsBD for <iommu@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 23:36:08 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2061f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8c::61f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 59B7A403B6
 for <iommu@lists.linux-foundation.org>; Mon, 25 Oct 2021 23:36:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a/HUCUckOedSxoQ2Iw+vJIiGxktYeluDRdReHhYgdTrk7f7qSO4tPXD+5H5D5n12f6/PocEOMBHxhUi5kkaS+2gm1qVH6Y3OMGDTFLmugUwOUtnLpksYep96otlswtzsdX7jLO1ByMxynIdKlI+CW2ouMLmD4sSqh44eoD59bIT/rCIZjz1BCXpU3QClLEzx9lJ54KJIT0N7Q/6WdNUU3tn6PuCPcP7/tehDiKkxUtxnnjjyxFO/BIjm05dpgMPMvoQ7vDUojOysvqkULb03KCW4Pt4bP2hTYRNFf2BcOcQRWyHopCxmR0EBFFU8flnBnmJ4ZO+4srFGvHFu+svxAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HxvBcwVILG66nShmXfon9WS3k26KsqYCmF8AG3q9A08=;
 b=OvnAEnyy/T/NR37qUaF8rSRr2K8befh1UsZ4lx0ahlR8UZfJMfrI+S+OOnPYlXUQchLUsYkx/dcaNqLugtsrbus8TkVBR50Iiw8TnrpB3Gul0gUshGh18S7qnXSncnKBAwpijaQXcFHE375y6s/eBpD+JhLGTLWASai1U48Ia/tA4Zph8sweTTGTNmo0iXzFb2fGjDiH31CT7r7tWeaA1rtTxOy5tD12bpGFnrCfPMuUcLL/Sp1xy2dLF/9aEOIEUuLkSyq5EX7cBf7xwLD/TTAQbampQ3KFIAYMuFj7Sr9Lw1A4tnqskDmQ7rFOSBOoZDYYekxZK7yGVnsW54+LvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HxvBcwVILG66nShmXfon9WS3k26KsqYCmF8AG3q9A08=;
 b=Fgg5teIrWYw48u1JqzAe4su6AoAH3KzhUkZDEUHmMnT6z3a1AAoaoVGfyRR9ZHA6iaon4BiEZ0R7qDMuOkwsDMBeQ7HZgaFI4vFU9tuBLzfJTfxFFMfk/KG8Yj+PW07Gvuiwfj1TCRh3IQ3TEHaiJ7voXh5OF5jOdAYquA6/wJxHmJ+5hC+eQoVlbKUHrE9Yp2Kt7X6W4fpz/gNWGrxEjlNrxWIpi6zXEzeixyjne7SgPwftTUpGfhyzpZTMRqID2wCs5ZXpBJpeo3gdGG0S7KJVUxvVgTap74opCmcIdq8il3aDVXdv6MSCsdlh+MRMeIESJzoapnLrU2Yn/PtKHw==
Authentication-Results: gibson.dropbear.id.au; dkim=none (message not signed)
 header.d=none; gibson.dropbear.id.au;
 dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5238.namprd12.prod.outlook.com (2603:10b6:208:31e::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.15; Mon, 25 Oct
 2021 23:36:05 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95%8]) with mapi id 15.20.4628.020; Mon, 25 Oct 2021
 23:36:05 +0000
Date: Mon, 25 Oct 2021 20:36:02 -0300
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [RFC 13/20] iommu: Extend iommu_at[de]tach_device() for multiple
 devices group
Message-ID: <20211025233602.GN2744544@nvidia.com>
References: <20210919063848.1476776-1-yi.l.liu@intel.com>
 <20210919063848.1476776-14-yi.l.liu@intel.com>
 <YWe+88sfCbxgMYPN@yekko>
 <BN9PR11MB54337A8E65C789D038D875C68CB89@BN9PR11MB5433.namprd11.prod.outlook.com>
 <YWzwmAQDB9Qwu2uQ@yekko> <20211018163238.GO2744544@nvidia.com>
 <YXY9UIKDlQpNDGax@yekko> <20211025121410.GQ2744544@nvidia.com>
 <YXauO+YSR7ivz1QW@yekko>
Content-Disposition: inline
In-Reply-To: <YXauO+YSR7ivz1QW@yekko>
X-ClientProxiedBy: YTOPR0101CA0032.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::45) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (206.223.160.26) by
 YTOPR0101CA0032.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::45) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.15 via Frontend
 Transport; Mon, 25 Oct 2021 23:36:04 +0000
Received: from jgg by mlx with local (Exim 4.94)	(envelope-from
 <jgg@nvidia.com>)	id 1mf9Va-001vCH-9d; Mon, 25 Oct 2021 20:36:02 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 16411d71-9f03-4d9c-57e4-08d99810364b
X-MS-TrafficTypeDiagnostic: BL1PR12MB5238:
X-Microsoft-Antispam-PRVS: <BL1PR12MB52382724B15AC05D709895FCC2839@BL1PR12MB5238.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9uOyL+CmPCB1//m6N/9NS5wVpwIcfaW32VWkDqdpBT9q0s/elzpnRKXgV/E0vkJkDzBn+nq5JTSggIETe4/lEbEpqwl8Nrx9rUDyznUIs6tIyA9mVgAgSLm18XPRjA40ri96jSfJ9GKFGEVakKRnT74P7LLK2SS9mXBbHIW27MLUq2/hZsVrYGDn5l1LfylgGEwVwMMamUXMiTAzO3WblqRRLqdFfMqDnmzSXdcq91HNFvBjLUDLhXmWodlawlI5Rnh44dMD2M3yTeU2RanMkXG/mcJfL4gHtFSTt/hMEFC/aT4UOCsulWcM235Wb9sL6afHWe6xspPQLZwVVL+tUo8qvAmZ2Jk0K3w87wLT9XNJqSxSzGlUS/AkrNJANMHgHefwYxCTRt+NubzTVvapobDtfnu+eTbSR0xU010X/klaVAROJ34zF+mQeWVZ0Uy4mMPS4Ai0Ud2+joAazTIJu1S+y+iALe6LcE3NzEDddVMfz1uVU9YzAZYb5wCNsQqIClu20ShWGcshDt+8IIN0PdB+BwpkJ+4GGvQNvoJm+y1LZvFyJIZP46CEW11p52U10hVKnqOvXYq3Ayl5mPswC5b1Y7iFc4s7MHycsva3UtbJ3f9eickshyuvpb46kVdAElWICdvpxYZWEWp91dOiSA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB5506.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(5660300002)(316002)(107886003)(8936002)(86362001)(186003)(26005)(9786002)(2616005)(7416002)(66946007)(508600001)(36756003)(6916009)(9746002)(38100700002)(4326008)(2906002)(4744005)(83380400001)(1076003)(66556008)(66476007)(426003)(8676002)(33656002)(54906003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hd8G/xH7h/invK6JVZpn4eig7nxpZBWTib5jKIVkzsViIp8MLSWejPATk1WD?=
 =?us-ascii?Q?gLb/Jg8EZIpBXhDvS8FqO8JST+KDXR+qA2TkCFRtHOtnboz18e3zb4GkgRby?=
 =?us-ascii?Q?pAhjDEE0FeFt/IOFE5i/Be32xRN2lU/bfBUccL7GvD6zRwfFjvckTixIqeWA?=
 =?us-ascii?Q?68i7h8ZZyQ1g2PZ48BfjQ67zqBHgik6qpO2iP2kVk2N2oP6pjO+RIfIJYpl4?=
 =?us-ascii?Q?MeH0XFPOWtKHyvlW3TOTtp1t2Uut8dNjU7nOA5CEg5REEeFnWzAM/YdD+L/X?=
 =?us-ascii?Q?H9tFmLiNnhyyqU4IlCYl4KSe4o9QM6MSeDtwqzjwLtzXfHOt+jzDbwbeRfIj?=
 =?us-ascii?Q?Cu1Xl6iGvtwbJIu0luJSHV0TozKEkhti7zR1P6+JHsH51ut6wK40nLla4Rm3?=
 =?us-ascii?Q?Mv3U+SfHatOrLc8j9VYfaGY2bBWvin/L036CFcha1RgIiYD0aFaJbUHHU02t?=
 =?us-ascii?Q?ioq8uXH8RkZgfjjqozM5NHsYSgCAkT9Elg3Dki/bkSm6p3xsepCv1+hOM5dW?=
 =?us-ascii?Q?74ICZ/0V2e1mNlUxLtHQO8AAjrpeqOdVSuZEf8av5FA4QWdm5XddSAaBXfEU?=
 =?us-ascii?Q?qOqL3r8PaV3Z+TJYQQi5tKVeHhQzZiDg9VPYR960zIO7tLOlr8qnuqBwJ/e9?=
 =?us-ascii?Q?tUw++U2zJtIDhVlCXlo7rzqxBNiFAEDfyCPa3X4sRH9FzWFgx1EJ0ZEy5+P4?=
 =?us-ascii?Q?wl9pBXdJ4c89ttbJA7O8xq/rMgaBRh31vhxXlqb9TupKR6qjlwLVTDLwPUYs?=
 =?us-ascii?Q?3kstMJbCQEnbUKPZrbcK9ZVsX3eVTmO2ZZnPTDpoxc3oQb/v82Ci7Qm1qhsz?=
 =?us-ascii?Q?gGdHXFjpihjPBCkd6RAIXQhZwvf4LeSSNep/J9hEsgPblOd76CN5QqKcIvBZ?=
 =?us-ascii?Q?c2Fi2WC/rhnES2z9mV+S9akeawlVuM3i69WJpPh/zHe9BgFZxDVM67047U86?=
 =?us-ascii?Q?7mCy4Fzw3Cl4ZBhP00VB1t9q8ek1WX4nKs4drDxHviIDBm+9WIiPACLkg3NR?=
 =?us-ascii?Q?BR/fhaLjp0xsR/JobA3VZHkTSdSiB1wjcpHKrAbj3X0dgl923CXaE3XqD4/M?=
 =?us-ascii?Q?NNd4tYo2CEHS9gbp/C8lJKN3YUSlzgJO+OH9VWBChnFAB338mf1VLHQqz+dE?=
 =?us-ascii?Q?+MvEwXyEVOeu44i1ACwFkhpzBoXpuXN78PdGrw1xXMq6SzTktx4HGK8InhA7?=
 =?us-ascii?Q?CvNaRmEOLHWXq6W1GrhK2KsZGk4qgcwf7QAPze8NNEmgO2Tzf3MoMr2G8ElV?=
 =?us-ascii?Q?gJNAl35zDY3xr5Rs4qOQeTzNlX3jO7Arf3+3MbMYYjYuKndS8HPPxOVY9tRb?=
 =?us-ascii?Q?SCaaRFcEovREJQ+uPXtQa93mhlzsviNRn2i6wdw52xQj/6/dLPNp4jDJYxGG?=
 =?us-ascii?Q?WJrCDD7XjHFYQjzDepkVtm7TKDUg6uk6gNQx/kz4FXnJwLpQX4Jg0mWK4vUP?=
 =?us-ascii?Q?IzOKIMXpwyCrYtKX9K5dSnbBbmohZ7rkj6fM1M/To5Z6F5FH5CsCFDsa5PAa?=
 =?us-ascii?Q?hWRA4qGtjS2okay2JxlX/t7N2MLa4CxY8rnzDojZkRaFViOVMg2ReiIptNoK?=
 =?us-ascii?Q?uKxFEdy1gZVR4eX4nR4=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16411d71-9f03-4d9c-57e4-08d99810364b
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2021 23:36:04.9064 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IHGS/FMIWAekb0BjeWCM4TXIDeqxWp88RdjLZtFKyV5pcb7xauKGnUoXf5AAhaUx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5238
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "kwankhede@nvidia.com" <kwankhede@nvidia.com>, "hch@lst.de" <hch@lst.de>,
 "jean-philippe@linaro.org" <jean-philippe@linaro.org>, "Jiang,
 Dave" <dave.jiang@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 "corbet@lwn.net" <corbet@lwn.net>, "Tian, Kevin" <kevin.tian@intel.com>,
 "parav@mellanox.com" <parav@mellanox.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "lkml@metux.net" <lkml@metux.net>, "dwmw2@infradead.org" <dwmw2@infradead.org>,
 "Tian, Jun J" <jun.j.tian@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "lushenming@huawei.com" <lushenming@huawei.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>
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

On Tue, Oct 26, 2021 at 12:16:43AM +1100, David Gibson wrote:
> If you attach devices A and B (both in group X) to IOAS 1, then detach
> device A, what happens?  Do you detach both devices?  Or do you have a
> counter so you have to detach as many time as you attached?

I would refcount it since that is the only thing that makes semantic
sense with the device centric model.

Jason


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
