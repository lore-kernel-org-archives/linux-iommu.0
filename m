Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4D32C433EF
	for <iommu@archiver.kernel.org>; Mon, 11 Apr 2022 14:13:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 951D94052B;
	Mon, 11 Apr 2022 14:13:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CUD8LX41kECU; Mon, 11 Apr 2022 14:13:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 371C3404C0;
	Mon, 11 Apr 2022 14:13:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F38A1C002F;
	Mon, 11 Apr 2022 14:13:40 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 273C5C002C
 for <iommu@lists.linux-foundation.org>; Mon, 11 Apr 2022 14:13:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 061D1410C7
 for <iommu@lists.linux-foundation.org>; Mon, 11 Apr 2022 14:13:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yyQXQvpxFgCP for <iommu@lists.linux-foundation.org>;
 Mon, 11 Apr 2022 14:13:37 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20626.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::626])
 by smtp4.osuosl.org (Postfix) with ESMTPS id AA218410BE
 for <iommu@lists.linux-foundation.org>; Mon, 11 Apr 2022 14:13:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VP/L5HHkWDo6TSZA78HKxCvyOYKMu9IPqtxfjEJV+M7Nn/AK5rrI4XR4S9Ca36FzdAbrFkFMm6Ec5pzUbU2rOeKgYIU1ELWkRpYBxfrJtTFUitxCHWZ6pdpp5inynibYfxXJ0jHJ5jwjRzUTu1x2KZtslzxFYchcBOyJ3u2vSXhHwLrfrEVbIM69Vvq8bEjCe/ZoJPhETS+pQGGujOVOYAIjnTx8Lcy5Zc0pXjMk2Fe1774GCnWByS4SE2XgQP5LQ+9Zb9j6J9OCuiXtmCQGklF+L9GQl/IcL+JBcAJUak2psxSbMiCdG4XqVjddXWspc2jLSCO3BEY4CGqBtpaxpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=josvuwXSee1or+V4uJYKAd8Gog0QImST4G8WwRzlcHk=;
 b=Bqoq94QfvN6PDEJzOGRcEGKmUisveV98WE38PQsCuYQF97mIbWmoiqA8VGd+phcO4+XpDLap29XPe+qd3J3aGEYV1NhgBQPVzQpg/ZHgFYCHPbwF3FQXt2gJ8ufrrgxKF8p+PT+PtMpLaiy8P0qYyHzv3BfyZ/rWVxnKNAJ/qzIXqh3xN8TgdSUsa7VPiJhqj5CKYaHRc97d7IlyZpvck94MFSjkjXZq5wXhsY53VCV8/EeGHygT44geviRgROMrnS3EF2w32gMB0oas5Ae6btuH7Ny3mirzIVzJrAPI1UdlTBf88bCfI0+kdx4h2J1Ta7p9kq6ySz+xWXRo90dtBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=josvuwXSee1or+V4uJYKAd8Gog0QImST4G8WwRzlcHk=;
 b=NK6VRIUeU88Lq5QS6ih47fcgtRWSHLuCWUG3LoA/yLbNPqWFQ6AGUg/GOxPxMgZkSP8j+SLo3JWZYQUXgTn4Wu44vSFSTTSQj9xb+7XuB18LUazBm2lU0c6srT8DSnqzHh3COoDbcL+fmfmSJQqzkiU6tyakhe2kPOWRg5ednABNCAnXmMfRPZHgwfzNyNuEXcZhXV5BHbJphejtvh617JdT+mDCRY1gSPi0ooTJeFQsmiNLGiqh05IA8t3F4xkEZpI7iWfh+HkqhOkEzjr1Pa6QKMlLky/sVs4mSVPRzW084OuY40OfcfV6BX0Wnez247+ijfR0UJ1oKmfZeoQbmw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by MWHPR1201MB2526.namprd12.prod.outlook.com (2603:10b6:300:ec::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Mon, 11 Apr
 2022 14:13:35 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::cdfb:f88e:410b:9374]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::cdfb:f88e:410b:9374%6]) with mapi id 15.20.5144.029; Mon, 11 Apr 2022
 14:13:34 +0000
Date: Mon, 11 Apr 2022 11:13:33 -0300
To: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH v2 2/4] vfio: Move the Intel no-snoop control off of
 IOMMU_CACHE
Message-ID: <20220411141333.GB4085842@nvidia.com>
References: <0-v2-f090ae795824+6ad-intel_no_snoop_jgg@nvidia.com>
 <2-v2-f090ae795824+6ad-intel_no_snoop_jgg@nvidia.com>
 <20220408094757.4f5765c8.alex.williamson@redhat.com>
Content-Disposition: inline
In-Reply-To: <20220408094757.4f5765c8.alex.williamson@redhat.com>
X-ClientProxiedBy: BLAP220CA0027.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:32c::32) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ff70b501-9978-4c7d-0e5c-08da1bc5770f
X-MS-TrafficTypeDiagnostic: MWHPR1201MB2526:EE_
X-Microsoft-Antispam-PRVS: <MWHPR1201MB2526B8281883523CC066A6E3C2EA9@MWHPR1201MB2526.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6NmkJK/V9du99ynGziQwLZ7M8h1Xb/MMeGxREomoZ/noOhOpuE6ZZFKZO7Lx+AZDNP8nbkYqkR4qTmgWWBVSEzCNqqxTcO6BKX+5Ixcv/7CKW+Bbyz9PI81LxKJcC9fz7qn6Dzpz6NIZicsfHkf2DLU6ptnCPVUAaMMqbnWzRTIOmWeHxxAguW+vthwrPPhgQjvSmRh4Y+UHb+n4eNMTAkRI74WgBz/ba8tiUfuVHwAJnkCgHh1N+F8ma/DcYl7SiI1oMPXj41by6KVwHQ6Z31Sh8pappCn14TO7wqkfREzhcZ93Zm+geZARSbqyLzxPDP/Qd06ICA/jaJ7axGnrnisaktkzZSaobEwZxdLmMQYnf2+4WvYbRfbrlPu2SReJBatB/x8AWg2nqFZEFlgpSP9r70GL5U2c89bhDgO9DFz/2lUFYFAklkOLVciOr6UToqSoQYPM4EDVOFQDSkkxFAht/7JnlTOqimMIIWKuZbLwl0SMY/ULOyVErx9G5U3KJyVD+8XQtAFYBEUCJ3KEonjXcvpXxE2264Z3hj4hTIvjipOT6LEbDUA48xfoHQE9S7+K7xPLyA8LlBDxHleLCvUd+ZVSbk4IjZ6HzoxmBfhhWe5ps+K1aLQn1ZjWa+qoEbgrfAm00KGZpAlgtSDIjA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4192.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(6512007)(316002)(8936002)(36756003)(4744005)(2906002)(33656002)(7416002)(5660300002)(6506007)(38100700002)(6486002)(86362001)(54906003)(6916009)(66476007)(8676002)(4326008)(186003)(508600001)(66946007)(2616005)(66556008)(1076003)(26005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?G0qoHAxmoYXcAVRM3rrY3kmh8Hy2krk2EuHDOqAhmyrhTbx4wqum0RbidRWn?=
 =?us-ascii?Q?10zY7MnNSodLdGfcVfHv5eZ8AJwXfNv8u+nbM6OI1aLCAnfPQtmUL68kQ3Oj?=
 =?us-ascii?Q?IAQSZDwmG5NqbckbeCQKWiS4EKfR5F/o0yMr47tXNv6+bUO89fK7tZKm0MWS?=
 =?us-ascii?Q?GDBvI6vkrl9GvhYGFWggMsT/fVeF2xflpm7+YYhTsuqzYRyykVztXeYSvNlk?=
 =?us-ascii?Q?EUxF4N9h1dug8kwCuy0lTZsQRJvv8yABKqHoIUSJCaiObVvHqbySXlfvVw4Q?=
 =?us-ascii?Q?bvpzcoOAXNcqmsGICuSeGwyCsGAIkFl8s4pQ92o00q5eZ7mtUXNTIWUiWSML?=
 =?us-ascii?Q?t9KajI6EOe55Lptt4Lgz6jQrbanmDmCGDLlmkJY1gPYFBZPhWZg2o2uuuuQt?=
 =?us-ascii?Q?w23nxGRH0rxkPrVeQACNQmR4aEHHObnA66L4kTZ8H636OZbKutc4yBvOgbjX?=
 =?us-ascii?Q?Xi7UHcr8IW06YL4AtNLHF60fEvGS7wY7UWIxhiK1ruV5LWa7w2JBfDneDYHD?=
 =?us-ascii?Q?X4uiCX8Px9rQh3gU3/N30nADMFzF1Wyv03L3/hxB99vfnnDJoZSVuDb4aEEr?=
 =?us-ascii?Q?pVUL9T+kYCbcJnahyh1A8UlfUnPaMxqIZiddKtkX5IDVPKFRRWzALY+gX/3g?=
 =?us-ascii?Q?pqx0tbFuTIgfNGlgqXygUvrcNeIfRt6l7eG9jV/29ac8aV9/H5PcuWQMAUhr?=
 =?us-ascii?Q?58YWr/0y/PjK/9Nl+w9BqphQUDcnKte9cl7Bj5v6rSsbuO0OLkKQ3R5ZsSEO?=
 =?us-ascii?Q?S0KxE60tay8kC5Rf6zdiu133WfreBFcWScDO3Ofe5H9X3RZi7jiNqwMcWTYU?=
 =?us-ascii?Q?jeRkD/ojxtUpu1RqmiLpJUdX9qTdbsmm9QkQpHulqX8geVMNQQP74/OlcMtg?=
 =?us-ascii?Q?FVsG0qPNxffwv+WY0yuUxiEwx7JE50WC79LW8DggdPpliJHgOU1U6ZekyduT?=
 =?us-ascii?Q?z8nUFIeJfP8HgzY3A+d3IEbhlriSyRVt7U+UAP03kEqtw90c0xJlVTUVA8TW?=
 =?us-ascii?Q?eJaeTqu3a583XiK4gERJMnaxcyQfvcSLGceRpQcALg4iANW+xoh0zncpP3WF?=
 =?us-ascii?Q?5Y09rL8iQGdje0Gw1iYode284u+Cn8SGhRhLCSDzskDsBUG/zJmqj8qWmuwV?=
 =?us-ascii?Q?P1MCjDwmXb7a8ZvOiixvVHONdKWs+ChFJ4hy+nlMwSSjGJbNHF4BoavMjUg+?=
 =?us-ascii?Q?9jQzZcKUGPB6X4ZkHkWnbpGgAD2T3mbU200IMDIyZ9P2rGRqczKVaD0tyXa2?=
 =?us-ascii?Q?IblNJCCo0VA6u8+B2nzcAUyzq8n5z64XkBGxQNPqT3MmYkh0L+Ko/7g3eF0Y?=
 =?us-ascii?Q?v5lY0OEhuOvzkvUrsMc38avnoQhfIH9bxbSM3CPYFyZ3l1euKrvovNESvrBk?=
 =?us-ascii?Q?iFP1LgFeLbYwIkEVGJNLbfJhG5/8P4VRoNdNQwlbGdEYHOBE5DwdnjH7BcGc?=
 =?us-ascii?Q?8b/f6WyX6faexejoxRpdALkb+CCfZFVO7s9YACl6h5sU0jTKrQTCfTYJ8DmZ?=
 =?us-ascii?Q?gwZL2TreKIRsDdNjHCOI29NK2nHm1XkP9wb8PUOm6PYsaDg/VzuDHvuBYWdH?=
 =?us-ascii?Q?PjJ2B3J2NL/X9fCXwTtrO+7aJ5Na8S3TAOugdW8WTy23zicVjBLz1b0ansfx?=
 =?us-ascii?Q?johMnZrY9HFPiJx+4ursSNFUHkTlKg382ZGXvLoKkxST2QTOHotzXsiSu0fq?=
 =?us-ascii?Q?1Lo0WugcOEHpExebYDVJ3FNHPNIPHaC07yfEKDXkGnCcDKplXn3VSxsYyw+4?=
 =?us-ascii?Q?iAdelWavPA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff70b501-9978-4c7d-0e5c-08da1bc5770f
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2022 14:13:34.8203 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FOwRQGxWT41zyBRMtAonqciGEXHhrzrJwv0OWUkZKZ3tIZyAAo+yQC3LMqdm/IbC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB2526
Cc: "Tian, Kevin" <kevin.tian@intel.com>, kvm@vger.kernel.org,
 Will Deacon <will@kernel.org>, Cornelia Huck <cohuck@redhat.com>,
 Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux-foundation.org,
 David Woodhouse <dwmw2@infradead.org>, Christoph Hellwig <hch@lst.de>
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

On Fri, Apr 08, 2022 at 09:47:57AM -0600, Alex Williamson wrote:

> > Ultimately VFIO plumbs the result of enforce_cache_coherency() back into
> > the x86 platform code through kvm_arch_register_noncoherent_dma() which
> > controls if the WBINVD instruction is available in the guest. No other
> > arch implements kvm_arch_register_noncoherent_dma().
> 
> I think this last sentence is alluding to it, but I wish the user
> visible change to VFIO_DMA_CC_IOMMU on non-x86 were more explicit.
> Perhaps for the last sentence:
> 
>   No other archs implement kvm_arch_register_noncoherent_dma() nor are
>   there any other known consumers of VFIO_DMA_CC_IOMMU that might be
>   affected by the user visible result change on non-x86 archs.

Done

Thanks,
Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
