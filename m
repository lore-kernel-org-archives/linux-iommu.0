Return-Path: <SRS0=oYak=EI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BA68C388F2
	for <iommu@archiver.kernel.org>; Mon,  2 Nov 2020 03:16:36 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 587A520870
	for <iommu@archiver.kernel.org>; Mon,  2 Nov 2020 03:16:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="pkP+J40X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 587A520870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id B207820486;
	Mon,  2 Nov 2020 03:16:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ly7Gz0rLTHG5; Mon,  2 Nov 2020 03:16:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 96C3F20116;
	Mon,  2 Nov 2020 03:16:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 71EBDC0889;
	Mon,  2 Nov 2020 03:16:33 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B4381C0051
 for <iommu@lists.linux-foundation.org>; Mon,  2 Nov 2020 03:16:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id A8C70873FA
 for <iommu@lists.linux-foundation.org>; Mon,  2 Nov 2020 03:16:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ofnAhgkejEID for <iommu@lists.linux-foundation.org>;
 Mon,  2 Nov 2020 03:16:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2083.outbound.protection.outlook.com [40.107.94.83])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 60AE3873F9
 for <iommu@lists.linux-foundation.org>; Mon,  2 Nov 2020 03:16:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=INlnlLDS1IlFVKjmRN11cEpJ+ktDG6dTmOc3B1jwAoXIDU8yZKgiIpFp8zl4oPr3ZJ7K4WCYrHDLCSQ2ZwtXxXOP+AhOAgOPinbHBD/nuUrjTlAcm5QWRzYUnFi+kXCnNyfyI2m+C4SUDBQCKft37vSZTQDUdakHAdi0wfu1B3PfmeqsbUBpeoaWei19RwlTIVgGDgv3pCaOR63qgVbRkoCQadg16N61AncPgQxDzRRrzoeSmbqx/GV33HPBvt8Ew5GzVn/OpT4XM8b2xGhJK16R61nBiFlEU0OrD87I35vcqTIZatTfn/chSKD8wwyn5FoPUwxbGzampPm/dcwQpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RTBrCE/Pf+0JqIZFSVMPfYI4Ln1s5BaMKmBtu5RyxDg=;
 b=cxaR8hQTGX1NxEbU7ZilMoYFARpwyXz1PJSX7E+TQs2PGWMhi6c0RlqBMrZZvCCVM+Q2j+RufjLEi0KOII/Y9YXmVuyMP2v6h81YLEH5Jmzznorh9BndykVjkm1FL836zcrooPYMuVst7v3W/IKI91fe/0wR8pyqN1GlgVEZ0qH8+QL58KqnOrjcLzQZQbIbE+jjmduuNxauNCg17Am/7xoaxUzr+jZtjRE/LI5UlL2JviFfLfvx+nO9Pa1cRPWqDWgMyr3SI8eiHzVG/CWc4kPJ2Wp0AeaeOM3B1NwrCJnCa30Z0/o/u3qmEtwSpPBufFPXMq3OHcH/4LQUkfJZ9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RTBrCE/Pf+0JqIZFSVMPfYI4Ln1s5BaMKmBtu5RyxDg=;
 b=pkP+J40Xz/Of9ED4d8alQX4J8HKPq/OBXsaj2aLMBgUgUfPwERWFUA7sSBmKDH3rPAS+e8QhC1rZY+qigygsvk8lbJn38EU9IkYugcjTkjvnlttV1nDQKD0Tmqn/NMu2Ums/e485VqD/BU72VYKzFgf3AgMubgqzlzPwfejLnTc=
Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4597.namprd12.prod.outlook.com (2603:10b6:a03:10b::14)
 by BY5PR12MB4161.namprd12.prod.outlook.com (2603:10b6:a03:209::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.19; Mon, 2 Nov
 2020 03:16:29 +0000
Received: from BYAPR12MB4597.namprd12.prod.outlook.com
 ([fe80::74c5:c3c5:26ae:524c]) by BYAPR12MB4597.namprd12.prod.outlook.com
 ([fe80::74c5:c3c5:26ae:524c%2]) with mapi id 15.20.3499.030; Mon, 2 Nov 2020
 03:16:29 +0000
Subject: Re: [PATCH v3 00/14] iommu/amd: Add Generic IO Page Table Framework
 Support
To: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
References: <20201004014549.16065-1-suravee.suthikulpanit@amd.com>
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Message-ID: <f28359ed-47dc-281f-7261-6320150ef906@amd.com>
Date: Mon, 2 Nov 2020 10:16:20 +0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.0
In-Reply-To: <20201004014549.16065-1-suravee.suthikulpanit@amd.com>
Content-Language: en-US
X-Originating-IP: [183.89.247.160]
X-ClientProxiedBy: SGBP274CA0008.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::20)
 To BYAPR12MB4597.namprd12.prod.outlook.com
 (2603:10b6:a03:10b::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Suravees-MacBook-Pro.local (183.89.247.160) by
 SGBP274CA0008.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.18 via Frontend Transport; Mon, 2 Nov 2020 03:16:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ef0c667f-1d99-4c0d-9905-08d87eddb0a6
X-MS-TrafficTypeDiagnostic: BY5PR12MB4161:
X-Microsoft-Antispam-PRVS: <BY5PR12MB4161704C27EFC58DB383EB63F3100@BY5PR12MB4161.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5Iqgg023CFrhcKTw4BcYIXZR47bJUG5E4F/5YQ0qxF/hr6d6/Xfc6HHzBrcHyimVCY9LXKaN43V9v4Kgl4m+CRZR/sUdhAfAEynwg9pJ9/3Xlx0JcoistaqbEj8a03qhQnrfu6NTGoZ8PJscA9vIsNHFcpBpFKYs6AT8l9/7haM++YzhI6v/L1BWc/kPgxuE3OV87Re+0TH1iLWJ9I727p8KzMhKQFOfozGFl3uecmY/4pHwbxyrEQmV1FCax1YVq9nJdAUAZ0R8yX2Uk4a/WlyVFrx+G4FDuomebyaI0QFieyS9ittNiTN5Yb9e+Vn7t/1GoXK9xm7g0lAM0tf4FzyLHybrsMOGMg9HwxlTmeC4QhHYHsrV4WP2gYYelAA8x7/aRv02cmEFBQWs+3HhqLirZ/sPPAa3ON0I6ign9JRqKGBtrTi55fS9DIvvHxwL12+YzbUqCqIgGgsaTQ28arxHoszzaE+FYO/Nv9IMFTQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4597.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(376002)(396003)(136003)(366004)(26005)(186003)(8676002)(478600001)(6666004)(5660300002)(8936002)(16526019)(6486002)(53546011)(6506007)(66946007)(2906002)(31686004)(83380400001)(52116002)(36756003)(31696002)(66556008)(66476007)(4326008)(956004)(2616005)(44832011)(316002)(86362001)(6512007)(41533002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: hwuXdJ3BD8ATCAVyCHeUQaxLzW7ZXYwW1lcwlpj7hwrQnYkVsVat7Ru1yCHJHv6eZ/+8qETuknjT4EyiOShJGOh7oWNorWcE8mYo2a4JtJG3WgGn+14iBTGGVLeFcxyL+KwfJBGKCBj9Y5e/hlfWCNCxnqflIq91IoXo0pH++bYzp5Su0Um25hLDQBUdPmtm9OeR5pTDZYWJmiLh9SCiEHzSbqmxuCPr2Q82QdHAxidElSDm1v4lOdpM9d3R1Ejalxy6aJj3mTjaguGPtvOzgDsEpG37nLCZJWpyDJ0N9L/bfJt4xKxXzr/TJvN0XBZuh05qreFECzdugTwlUEDhYXXBU/bMUVKNHTDkHb0uJq9lFsbBzaL4YWYAMSBfKhpmSSvt3oVr44xvlUvmk//W5NlGlafMbeg72yblz6kb/Q7zEUwflfI/fVlCFZwfdfPeVJ12JvnO7l0ZhBQhTtZ+DahFImK6alRvlxRlGY/S3xc8EEjafLocIhbCsvLU7ekedvByjQwsPxtz3r8WAIKlNnr/FJq/cR215ILXY5uYG6RsQJpN/g6zJWLQYMs4eOJIpBWhJ0BbgposURILEZ2HFir6hWA8uBEki/1VupNxpxxROu2b/PMsgVvGSvuQvjZf8CN+cYyQXMB+7exOSFmefg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef0c667f-1d99-4c0d-9905-08d87eddb0a6
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4597.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2020 03:16:29.1794 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AfTUIV4MO88Y/fygcMDEfYS+bQ27uh/TJ+F90m9jO23yiNGdk1Ly8KURTPjCBJ+OTNGrVDENrypkNrGuLzcSUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4161
Cc: robin.murphy@arm.com
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Joerg,

You mentioned to remind you to pull this in to linux-next.

Thanks,
Suravee

On 10/4/20 8:45 AM, Suravee Suthikulpanit wrote:
> The framework allows callable implementation of IO page table.
> This allows AMD IOMMU driver to switch between different types
> of AMD IOMMU page tables (e.g. v1 vs. v2).
> 
> This series refactors the current implementation of AMD IOMMU v1 page table
> to adopt the framework. There should be no functional change.
> Subsequent series will introduce support for the AMD IOMMU v2 page table.
> 
> Thanks,
> Suravee
> 
> Change from V2 (https://lore.kernel.org/lkml/835c0d46-ed96-9fbe-856a-777dcffac967@amd.com/T/#t)
>    - Patch 2/14: Introduce helper function io_pgtable_cfg_to_data.
>    - Patch 13/14: Put back the struct iommu_flush_ops since patch v2 would run into
>      NULL pointer bug when calling free_io_pgtable_ops if not defined.
> 
> Change from V1 (https://lkml.org/lkml/2020/9/23/251)
>    - Do not specify struct io_pgtable_cfg.coherent_walk, since it is
>      not currently used. (per Robin)
>    - Remove unused struct iommu_flush_ops.  (patch 2/13)
>    - Move amd_iommu_setup_io_pgtable_ops to iommu.c instead of io_pgtable.c
>      patch 13/13)
> 
> Suravee Suthikulpanit (14):
>    iommu/amd: Re-define amd_iommu_domain_encode_pgtable as inline
>    iommu/amd: Prepare for generic IO page table framework
>    iommu/amd: Move pt_root to to struct amd_io_pgtable
>    iommu/amd: Convert to using amd_io_pgtable
>    iommu/amd: Declare functions as extern
>    iommu/amd: Move IO page table related functions
>    iommu/amd: Restructure code for freeing page table
>    iommu/amd: Remove amd_iommu_domain_get_pgtable
>    iommu/amd: Rename variables to be consistent with struct
>      io_pgtable_ops
>    iommu/amd: Refactor fetch_pte to use struct amd_io_pgtable
>    iommu/amd: Introduce iommu_v1_iova_to_phys
>    iommu/amd: Introduce iommu_v1_map_page and iommu_v1_unmap_page
>    iommu/amd: Introduce IOMMU flush callbacks
>    iommu/amd: Adopt IO page table framework
> 
>   drivers/iommu/amd/Kconfig           |   1 +
>   drivers/iommu/amd/Makefile          |   2 +-
>   drivers/iommu/amd/amd_iommu.h       |  22 +
>   drivers/iommu/amd/amd_iommu_types.h |  43 +-
>   drivers/iommu/amd/io_pgtable.c      | 564 ++++++++++++++++++++++++
>   drivers/iommu/amd/iommu.c           | 646 +++-------------------------
>   drivers/iommu/io-pgtable.c          |   3 +
>   include/linux/io-pgtable.h          |   2 +
>   8 files changed, 691 insertions(+), 592 deletions(-)
>   create mode 100644 drivers/iommu/amd/io_pgtable.c
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
