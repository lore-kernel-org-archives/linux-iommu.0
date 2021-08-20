Return-Path: <SRS0=ckUw=NL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20BB3C4338F
	for <iommu@archiver.kernel.org>; Fri, 20 Aug 2021 20:08:50 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3E0E601FF
	for <iommu@archiver.kernel.org>; Fri, 20 Aug 2021 20:08:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B3E0E601FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7DCA74254B;
	Fri, 20 Aug 2021 20:08:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NZae3ZoV5PKQ; Fri, 20 Aug 2021 20:08:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 412484250D;
	Fri, 20 Aug 2021 20:08:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 02714C001A;
	Fri, 20 Aug 2021 20:08:45 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3F42AC000E
 for <iommu@lists.linux-foundation.org>; Fri, 20 Aug 2021 20:08:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1BDB642543
 for <iommu@lists.linux-foundation.org>; Fri, 20 Aug 2021 20:08:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uMQ7Ykn_OD4d for <iommu@lists.linux-foundation.org>;
 Fri, 20 Aug 2021 20:08:39 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2066.outbound.protection.outlook.com [40.107.101.66])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 114634250D
 for <iommu@lists.linux-foundation.org>; Fri, 20 Aug 2021 20:08:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lFw8Do2zplJcF6Uf6S7x+aTJfrTUihoHQUZa7HnArrY3m7dt7YvfegGblkgAsIDsy9x3vJ7OxOeN55xyX44ujbIWog5+fmnM1S8oS0anYAe0htNe6cSvgytLs41iZ60f16MFl9IQTJ0bD8zzI7AszksnjFPqot1+VUSWHDNUC04HchdUMa+h8/EzWuaIgzjaD8fGdgQEod2KEMPpupM4l3RtSzz/MMUrPKr1xa5O6NesDVWqx4NnQgz3qr3I7yUR2kj+GSEJ750XgyS+5TticOVyVMjIkIB05nmy0FRAWHp1lVgjMVr9Iee+fvbbNbINIU7wT9zVppibYMT30K8cQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FXYvhwGVx5/KwBmIh5W6Wi2BkO1+fD7jDZ8t4P1yi00=;
 b=Ud/erc8CrUaoH4cGb6OmWxxsZ2uPV9l7wMpEKHqx7a+ww8AHzyWnmkaCK4FXn76dlMPlMI/FOeiLQW6q/GVYM9S8n6L6fYX93MmS/UCmg+g2uBF3Gtudw0baiLBHcwCdMogV6GSLNpMMbtdyrF8IQRE3uD12rKnVSvlipTsam6HOgk/ytmqpXnqp0hrsiQpbxJoiFKDn4pYM2+q0oI8X3ilh3KjhctcLwt0OKYsGC0n2Bkfa5rVCMmaoWLKTo+AN5ew/nnjudlq0JcaNh2kT5RGYWg9wZMK000Lb1IsBUwdKXTXfsCn4AR0ipHT6z/EWUi1ShUZY/I9N2zC/UJu46A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FXYvhwGVx5/KwBmIh5W6Wi2BkO1+fD7jDZ8t4P1yi00=;
 b=QzJFnEvMCYY2aeDo80Kz6axsbjMCjVXjV/xboP5g4TQJzBzxqmSi1L/cNAB3UkrsHxgANsGvpXjz2m9TaKx08BeF8uo73hGdy+Rpao2jyFel3NC6rVhw1jwR/o4MnCN2dmYzUIOPhs3/0QaITb98kBJr61SIlPdzi8ifZxuZxy8=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM8PR12MB5445.namprd12.prod.outlook.com (2603:10b6:8:24::7) by
 DM8PR12MB5429.namprd12.prod.outlook.com (2603:10b6:8:29::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4436.19; Fri, 20 Aug 2021 20:08:37 +0000
Received: from DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::1dbc:947c:2913:449b]) by DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::1dbc:947c:2913:449b%3]) with mapi id 15.20.4436.019; Fri, 20 Aug 2021
 20:08:37 +0000
To: linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org
Subject: [PATCH 0/3] iommu/amd: Fix unable to handle page fault due to AVIC
Date: Fri, 20 Aug 2021 15:29:54 -0500
Message-Id: <20210820202957.187572-1-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: BN6PR1401CA0021.namprd14.prod.outlook.com
 (2603:10b6:405:4b::31) To DM8PR12MB5445.namprd12.prod.outlook.com
 (2603:10b6:8:24::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ethanolx5673host.amd.com (165.204.184.1) by
 BN6PR1401CA0021.namprd14.prod.outlook.com (2603:10b6:405:4b::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend
 Transport; Fri, 20 Aug 2021 20:08:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0d3ac43d-ca28-4a56-2ac5-08d964164bec
X-MS-TrafficTypeDiagnostic: DM8PR12MB5429:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM8PR12MB5429CA295FFFA89EB7933499F3C19@DM8PR12MB5429.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +z2wmPKGUTzD4LH0zFUnXFHduW1ERz5kopMkccn2so/9WYbSchrFvCtxovPKfFvPg3XLnF7+UXF6jXg2U5CiSvnEXTEWaZfb5Xp6ZIvs2Eg9gJ+L4haKahIcGlvLaXxH7KsWYDJ3XXscMxlvWR7bucFI6/lAaMRKxErNpKNGncc/Id8/94f9v3IsuQEl2Q48HvOZtSAiA7hGWnP6R8cBhdejI9qTd/H454U4AkmdE6zGjYm4NkDIYVR4aXWn/JaV1IKDWgO0KZrH4fFeLDZTlSG+WVP7D8vgT74bVHRaHpweZeFKBYj/0mcMEMki4ljPaxzeSiYsYUQ3RyYmL905sb9Y5+Wz8fBNvehRZ1Beopdu2nkPn6dFWnVrPLqAw4BvrLhvA/4Ug9K8dUbqTbPL9+LFyIwA2sUlkPAFFSXqqSndxLl/vmKiObPXo2/008E9WGPadqm19pPUxJ9TTgJs20xWc+MJ4kXJyWkH4VJqMXoQ0NpGKwAGae8oSBK6qtCBQYW2RmZgBbKmsWUmTf6u311asMicxmHCytnz4bCdLMy+fLD+Q1wwMGAWZamV/KsPIjo20WD5DHdVXCxLRwZskuuG5vlZSGLZmlwmYRSdx4OteBjzr/J8y46EzBRKjXD43Z91TDq3HZPz6iZ1pbG58mTh2RFYq9G7SRVG2GVuv9/DrXuw+f8VIx856IqfqBLZZIdtFbGpNBrBnjFZtaQj1A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR12MB5445.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(136003)(366004)(376002)(346002)(2616005)(52116002)(478600001)(7696005)(44832011)(38100700002)(38350700002)(956004)(316002)(1076003)(66946007)(5660300002)(6486002)(6666004)(36756003)(2906002)(83380400001)(4326008)(26005)(86362001)(8676002)(186003)(66476007)(66556008)(4744005)(8936002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZvENewwof/xYzYx9HK/UfCbsHopp27YPfGHvAQF5fkDJ+2lTJCL7b/0vIzkw?=
 =?us-ascii?Q?4oZKnIhyYFpDrtO5l1XIE6dLoG/lyLGrVh25orRaCZX+cKIWKK6gDch1H+B1?=
 =?us-ascii?Q?pRgQ5Lx3GtvQjixH6RYmebUwScv6wmhdLqCxso2BpQeU4jNPsDhr0h38qcln?=
 =?us-ascii?Q?d3U4o+3Pk+BWS3T6q/DTp19SGD8PNFC6nRiEDVEOZ041R0PKJVJNPiO3Fh1T?=
 =?us-ascii?Q?3JAqnYV6xsh36KCwcwYzYpa+Ce5RIUz76iXYE3nsz26g7W0fkagVEL3dvkdI?=
 =?us-ascii?Q?50CYU8wck+dnaLl3BF5N+6SFoUjRw9sxgi7nO5GzVzj+USYHyUvpD37MAksc?=
 =?us-ascii?Q?gV5rFrtwFn+t1w2oEcSnJfQzSLxuxDp5kTS2b2sN+DEQISj5+gskYZRJuQVi?=
 =?us-ascii?Q?XGD3t6xz71caGHpFToCOapJcbaulMmcy5fIEDyO1hyks2PU3ijfoHdlmcNDP?=
 =?us-ascii?Q?sihXHCyaPIKKROlvuszEUAWG9zqcRu6vUelDUMqvJSy5+Ffj3WcR9szewwNt?=
 =?us-ascii?Q?BLBO7o+G8JzQ09Cf7pUoTFY78QcvuCkYh81o2n9s/v/P93Hux8+C1+/io1LI?=
 =?us-ascii?Q?iPEuK2fbjtl706CdU3ltvCe0i7n9Ns4nC09Oj1hrRiwaGZJ4vgWa9+gwKek9?=
 =?us-ascii?Q?+Hnx9uY3loFsltSuzy+nZ9VxH9kc7R6MvnjTi0bvhoCIDO/UlQg+G9RVWkHR?=
 =?us-ascii?Q?yGlxKRh/9lXvcHrZKVCSnflO8MvWVqWxoGTN4FPIUxZIpuL7RNKTucMNmGeX?=
 =?us-ascii?Q?J91igmuf+tSr4wF64o31yHww6H8aNCF7uJCthD95+OEuouSkq/YPx+fB6MS8?=
 =?us-ascii?Q?KJ4eZ64C7MXsu+MyMWwkaLGVgPTTm50k6QEio/Xydy6QAZnT+98ceQZoZ/8n?=
 =?us-ascii?Q?GYyGqYE+E4ITO5ebwxNepqMjLDBB3a7Wd1Ynp5aK4hMagIJDUAHvFkm9dNaZ?=
 =?us-ascii?Q?aApqUk/4fCdawKbu6rNRuDF9zoPprxIsdwOgJF+aNZmqKIa1kAezKhv2ccJZ?=
 =?us-ascii?Q?nOWVP8h4YGJ5pnS4B8VXAL1gMHmmTiNh7jlS1A5AM4V/TWqDugat55EPpdPO?=
 =?us-ascii?Q?Jc3R6sBd+YbRLozhzAGxhbejXUkdxmi5Fqe+tmA9BlDMpRJD+S5Dit9j+kNg?=
 =?us-ascii?Q?NRzLc4yB6Reulz17zl64KO/BAK6wuBbrMCOvEOQWRxwSh/egANMwG9VYPAPc?=
 =?us-ascii?Q?HSCw+2MO3MC1DB94DFJ8GxffasCzq5Ye4suWgIKCMjqXumApoeofjAq/bLvh?=
 =?us-ascii?Q?b2U8lQG1MAm+ukQaptyJ1Z96oZ2MeHg1+HknsTrOyYDLTg1whKakiDFb8sKT?=
 =?us-ascii?Q?denTnm5BVXswuM2X6nWibSbe?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d3ac43d-ca28-4a56-2ac5-08d964164bec
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5445.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2021 20:08:37.7075 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dfo/bSrcD0XbUmLQdwfkeY5ihnUvq3cjudmh+vgvWOpIyaz3QLp5djbLN/EvqLJCMfaj+CzvRSDalp9ZsZAsDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5429
Cc: Jon.Grimm@amd.com, wei.huang2@amd.com
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
From: Suravee Suthikulpanit via iommu <iommu@lists.linux-foundation.org>
Reply-To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

This bug is triggered when rebooting VM on a system which
SVM AVIC is enabled but IOMMU AVIC is disabled in the BIOS.

The series reworks interrupt remapping intialiation to
check for IOMMU AVIC support (GAMSup) at earlier stage using
EFR provided by IVRS table instead of the PCI MMIO register,
which is available after PCI support for IOMMU is initialized.
This helps avoid having to disable and clean up the already
initialized interrupt-remapping-related parameter. 

Thanks,
Suravee

Suravee Suthikulpanit (2):
  iommu/amd: Introduce helper function to check feature bit on all
    IOMMUs
  iommu/amd: Remove iommu_init_ga()

Wei Huang (1):
  iommu/amd: Relocate GAMSup check to early_enable_iommus

 drivers/iommu/amd/init.c | 45 ++++++++++++++++++++++------------------
 1 file changed, 25 insertions(+), 20 deletions(-)

-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
