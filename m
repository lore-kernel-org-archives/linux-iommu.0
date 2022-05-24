Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3E24C433F5
	for <iommu@archiver.kernel.org>; Tue, 24 May 2022 13:26:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 09BD140C7A;
	Tue, 24 May 2022 13:26:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fYfp4YRXVrrs; Tue, 24 May 2022 13:26:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 245D14029B;
	Tue, 24 May 2022 13:26:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E34BEC0039;
	Tue, 24 May 2022 13:26:02 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 41EF4C002D
 for <iommu@lists.linux-foundation.org>; Tue, 24 May 2022 13:26:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 11E788403B
 for <iommu@lists.linux-foundation.org>; Tue, 24 May 2022 13:26:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cwVcG9MXz_VF for <iommu@lists.linux-foundation.org>;
 Tue, 24 May 2022 13:26:01 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2060a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::60a])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1FBC684037
 for <iommu@lists.linux-foundation.org>; Tue, 24 May 2022 13:26:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ij+ibwK+MEPLCEB3YH7izQ6G+lbI6dvvo5D7e+251iVOeXxct7Pxkrs/AOBReLt1FjytzF3+lpko5qpKORfk9DwY1a/UnnjWQry8kO3j7/RAz7iH5twI5xpWHRiX3bl6tMx0r3Zu6LaZSKdd/3yQNl3RRqaZjZYFwKDga4k6WPJ8xs8MSSkbK4NyXmGGmOAOfmJ3+V79PBdaphrQHke6WUUxV5hnzXMyOyTdsqSdO6DfvZTQ9sM7xzHAEyqzlX5vdY7sKFHk3B+d9pkW0IhSKumt528RKGBQX2Fvf7bgc9DTvWkJU2QHcZCx1LraBiPv/b9T8Oa5SH8tplZPilk7Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tq2oK5rl27043NFQFZ35CNwCfL7crE+r0WDoLQKtD+o=;
 b=QwMcDIdLPpQ/dyH30fiFZer+v95RAlId8hdc015lC+AM4lCZ3eLRpFamkcvsQf0qNHfC5SQeoJP1G24unrbzhVx8PgQn4SYBx1Q2yoGjzvOs92wJPw/lzMU6dlkEpfcXwUqjGE52uFk7puR4OX78BXu6kKOCBBp6qQseRoSxg/MvdEuN1AAfF/CAP4McvLJLvN04fsvtmCpV5TipryBp+RLbglTB9MWpJeV01heidlj6hnRYjwGPj8UiTIlYlEclcxgJIxm4xdN1BZxWuiJOeuuir7A/zwYqqqom4xsSbqfTGM+ucVowT9GCURie44HCtS+70WXw2NPpJ/BNQET6vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tq2oK5rl27043NFQFZ35CNwCfL7crE+r0WDoLQKtD+o=;
 b=pWCfeFxNXISwvYIchKFp23gKbQuBbpjkeAHR2EKqYfIrEA5YxU7m2pNMP0ygMTeu+MHFsxAuTbkufNW2c9U8yxykVzG3FMcClEAGNuJEQS7OZQTvsRD5Kd1ZDdiuRMdKcxjdePaGE7h2eyRbzyCbh+45+FVjOHH017jxBjiCae4rM0bLdJoV1IBRBHFDmxinV5CpLBQeY86WhfbdTAOmsjQlxYNWxhL64pbrvMue3g45OjykU3oR+nvnxt65P+QfRXTBMVPIBilQlrV30zzjFBc/LTUN9WyroeSBcm/YD65bfL6BxIhzZPvf9H9oVD73xrR/UtONJbYAG9+NLRIOJQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by BN6PR12MB1219.namprd12.prod.outlook.com (2603:10b6:404:1c::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.15; Tue, 24 May
 2022 13:25:55 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::2484:51da:d56f:f1a5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::2484:51da:d56f:f1a5%7]) with mapi id 15.20.5293.013; Tue, 24 May 2022
 13:25:55 +0000
Date: Tue, 24 May 2022 10:25:53 -0300
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH RFC 11/12] iommufd: vfio container FD ioctl compatibility
Message-ID: <20220524132553.GR1343366@nvidia.com>
References: <0-v1-e79cd8d168e8+6-iommufd_jgg@nvidia.com>
 <11-v1-e79cd8d168e8+6-iommufd_jgg@nvidia.com>
 <20220323165125.5efd5976.alex.williamson@redhat.com>
 <20220324003342.GV11336@nvidia.com>
 <20220324160403.42131028.alex.williamson@redhat.com>
 <YmqqXHsCTxVb2/Oa@yekko>
 <67692fa1-6539-3ec5-dcfe-c52dfd1e46b8@ozlabs.ru>
Content-Disposition: inline
In-Reply-To: <67692fa1-6539-3ec5-dcfe-c52dfd1e46b8@ozlabs.ru>
X-ClientProxiedBy: MN2PR07CA0002.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::12) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 24fe28dc-1907-4d0d-7dc1-08da3d88ee3a
X-MS-TrafficTypeDiagnostic: BN6PR12MB1219:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB121983F2121B39E0026B2F07C2D79@BN6PR12MB1219.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eMaajp65Mb2HQN3+zUVKYl8S2K7rIgCqLSJ/MhjphRYAMYdVY5YfuEPqO5pEFrDEcaAH9ua5SJSJMIZHERYAmGmGTAOj3bvFU1OVEwjOlpBqlug0StBVfc8YmzuaZzeIdrJ0IG7tEdvb2gNuhLoYB/SpS65YJ9B7XKYydCYVhR5tf2j5YsWFpdZwbd+bPsDcnd1GH3MWMntLG/PklOM0vACiJ4vz2znIqfWqvcEdpHRgsfg5GTlUYouni+VP3KPP7JAFJjhYdN2ChfjHntzmyx3eVL/AgFGZhspyNNGxWl9Vo715s4qdaDfYCSGs4t9ErA58DKV/JsykrHm+5zy/5E5Bf+EIVwAh4aAOe58cc0IteWuPWNRNfIjP+vTXt4Haq/2bBrHMoeEaEEX/PFzBwBcWILrqh2fekqxynqNYtYzV7aruB/UKvgJTKuet9suHHmou96A0jPGH6G7347TWYJ33UqUzX629ricr64kH59a1u+c/wzP4RDSpdShXX43Eg7ykYVSSMIfgBehXNCpD9j608aXx8/Yo6FFALRLBicpbwizPLbO9Sf9OBhayyb9jQ1THXuIu+7HuBE9Fxdb5qbY4PZ2CtIXPZ1qvolyc9cESXmDlmrhBScXlks1hh4KeueJ8/0oiSKI6K3i3ZVYtEA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4192.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(2616005)(316002)(66556008)(6512007)(1076003)(6506007)(26005)(36756003)(54906003)(6486002)(6916009)(66476007)(4744005)(4326008)(8676002)(86362001)(2906002)(66946007)(8936002)(508600001)(186003)(38100700002)(5660300002)(7416002)(33656002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4fEERxEsj45TuBLA/xHofmKDkOging73emSNZOMgIfHnEJjrgqgrUj11O/6A?=
 =?us-ascii?Q?d1juv38uh/3udqy2raxM7bby/xcdftJhTVdrKCeanVJJaOiDQn3meVU7jhUC?=
 =?us-ascii?Q?sTCl02RYL+bamLaVi79EmIUEwxm3oH2tMhSO+ZW5xSozkM3bbg3uvtbmD3la?=
 =?us-ascii?Q?mYQOtbbrwQP4eNcwXR5ZAYOR1RIq1Pi4v4o9G/uZtMkMtwYHGkS/hUKySG2X?=
 =?us-ascii?Q?54ZnGlnOdRT6A2J03QlEnTZg9kvWooYM/temQ/Zk/yt1+A2gSCZ82X6v5p2E?=
 =?us-ascii?Q?eIRxO1DeOr2KirilvU0g7GqSMMdpaIqkOUSTUi3e0jM9laTShKynoOW0hXe9?=
 =?us-ascii?Q?Bbd6tbUuW2Nrpr0K0F3JwCb/2Sr6cnt9ydstYYVx9UL0IptAMmFWvz2EHH3X?=
 =?us-ascii?Q?zx67/0iUoLRg7s0jR5cgJSp0DorCD9Z4gT47LzeD7/1lOgtao+8nyZeRoe/o?=
 =?us-ascii?Q?Pys/DcYRFp7ZeooE4iw5GehUgNXYDaEYBXjqI8dOpevor5U67SusxfkWU+ET?=
 =?us-ascii?Q?lcHayM5CaO3sFB7CzMPnaA2j3AWjahJCgvagGUotO9XAEwSTUUaol2YLuMZD?=
 =?us-ascii?Q?r5Ap0X0ZNntCHufqvA+pMxwJltfdFl+e9GAYs6uZ46eZ6DgENzdcjW4FURyr?=
 =?us-ascii?Q?S/6F2ruJDDUWNp2aFkxYyHJsHzZ7GGM2UwTfPTbn3XYDvVBvFxbR3Uyfi56d?=
 =?us-ascii?Q?V5LQco4ZKWC7PN3D16STtVbFcurDXntSeNtFJqRwjJfHapVk4Mflbb5E/MTv?=
 =?us-ascii?Q?iAwi++Ppg9N723IwfcPfvyc5VPrqUoJ7scGzFWnPEzwezz4Z3GkBDEeiFz6Y?=
 =?us-ascii?Q?uayM+jZBuZyjQkvHNjI3+Zw19G9kTfM5ymNefNB+t+iql120x3K0/x8NO6rj?=
 =?us-ascii?Q?aLzQrWgE9iAqC5eRoezd3TXTmSElkrIhSldrlnb51EqfhpqV4KqZvWLb2Iht?=
 =?us-ascii?Q?QOfUC/CjXSF4g9nbe0IsFWQI2RMgcntbNCeh95MnI5lwV2Z2TOTf8QmzWy3O?=
 =?us-ascii?Q?HEsH+/D2wKYpoF2vug5Yl+m+0cqLLqorOJHP7VAqneLuEwG6W8SfZK22l57n?=
 =?us-ascii?Q?C/NNdKHmExHGXjgu9jCsUnFUGJrUTEJ+9GlUkvqw8qotvXgne2MDt5qKUo4D?=
 =?us-ascii?Q?/8bMJTfwfDJctKIQzB9Z9NtMdym293s2kIE4DmMNR3Jvg+CVnhalN5JP8iBC?=
 =?us-ascii?Q?cUsgxLLhxRyo6xNi41wMs0TQuEfoOcNJvLawlNp5qH/cEsr+553Hne6PhIau?=
 =?us-ascii?Q?9AiWaz4b/nEGe00oP1fvFG38IQiedzL3DoC2Qk6XTcdJN4sq+bhuKOqzYsob?=
 =?us-ascii?Q?Aq8BuGfUOxK6V8fZOL03IQ2Fqe//syyYfkTF9jvH7N3fhvme6PaqG1bWx3gv?=
 =?us-ascii?Q?goIkD6CsKCIAKtECfAPqxLDWsDNubUjMHW/EmDq9TR/5nDiVMjyUSC9VVjEI?=
 =?us-ascii?Q?pWrdc+s4+yCQaI/EtaQnJWiM5PMS6fksWT8aP1Q7b+KdbShmEnq4clSneRJN?=
 =?us-ascii?Q?H/zQldNry47BJqFAFKrDqC4PqJPpCo0iGb7FqyqnzHnpopOqWpi284NX85wE?=
 =?us-ascii?Q?egDuOfUSs4K9OIdMv6BVQLpykoY6vEj3qJuehIQDi3vMVyL0YfvbgHoWMsbW?=
 =?us-ascii?Q?8PXn6vBWSQlwAqTMrLWgamVz/tZLFgYSPd9i69iwcK0rZQAvCBH7v26YpszJ?=
 =?us-ascii?Q?Lc5TCHu4ZH4i0PqHW9Uh83sosNNxljsJRQ5VwCmf3xy3UpMa06Odc2hoRBGh?=
 =?us-ascii?Q?T1TvLmrP6A=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24fe28dc-1907-4d0d-7dc1-08da3d88ee3a
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2022 13:25:54.9878 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gtFh2KQBWwhnQTNorY6GRcpzq2dMMpjrTb8du4+32A1StLCIhvDyl2KwYx2Uvheu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1219
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Niklas Schnelle <schnelle@linux.ibm.com>,
 Kevin Tian <kevin.tian@intel.com>, iommu@lists.linux-foundation.org,
 Daniel Jordan <daniel.m.jordan@oracle.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Joao Martins <joao.m.martins@oracle.com>,
 David Gibson <david@gibson.dropbear.id.au>
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

On Mon, May 23, 2022 at 04:02:22PM +1000, Alexey Kardashevskiy wrote:

> Which means the guest RAM does not need to be all mapped in that base IOAS
> suggested down this thread as that would mean all memory is pinned and
> powervm won't be able to swap it out (yeah, it can do such thing now!). Not
> sure if we really want to support this or stick to a simpler design.

Huh? How can it swap? Calling GUP is not optional. Either you call GUP
at the start and there is no swap, or you call GUP for each vIOMMU
hypercall.

Since everyone says PPC doesn't call GUP during the hypercall - how is
it working?

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
