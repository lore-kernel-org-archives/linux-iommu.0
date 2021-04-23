Return-Path: <SRS0=1bbG=JU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3D62C43461
	for <iommu@archiver.kernel.org>; Fri, 23 Apr 2021 18:21:52 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 322DA6144D
	for <iommu@archiver.kernel.org>; Fri, 23 Apr 2021 18:21:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 322DA6144D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id CF7D5400E9;
	Fri, 23 Apr 2021 18:21:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id amNkElB1Am1r; Fri, 23 Apr 2021 18:21:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id BF0D5400B5;
	Fri, 23 Apr 2021 18:21:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A9B42C000E;
	Fri, 23 Apr 2021 18:21:50 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E9DCEC000B
 for <iommu@lists.linux-foundation.org>; Fri, 23 Apr 2021 18:21:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E4680843D8
 for <iommu@lists.linux-foundation.org>; Fri, 23 Apr 2021 18:21:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id n84yEAU7YpPW for <iommu@lists.linux-foundation.org>;
 Fri, 23 Apr 2021 18:21:49 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2081.outbound.protection.outlook.com [40.107.220.81])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 253CF843D0
 for <iommu@lists.linux-foundation.org>; Fri, 23 Apr 2021 18:21:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jJI2nb4gsa5N0RRyGE/x2lmqBLM+eGd0O1fb46VUWwJMi6BdbSMbBafoFlEA505xZJ/QicuwmTZSS9dWiJ6BAtnraYogArFJfqqohTHHfbtE6Jjv8AL7WBuFm6Mu69n3aSHUdZjYL0ARi9cgm4wGK0AuJX9hDkXV8L0uy/S44w1j2rNCA9BqC3yBtMxH2607St2xZb04BNYcldEd+tsuk9lx4iOLoh9mcjaj+8xGAS5r94mrUSwCdI2iHrpTXqVY+Ljf07C32f8MJ7he/CUP+kahqgxrfTYnxVBUsuk1Ce/GpPtBTq3Ardr3isiwmwQcmEN73Fah/bYuqKkaRVg2qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eWGmaU3ww88NX4aApDuAs3qQBSJ6XOY+wHx365XbuRs=;
 b=WpWnvfibEwcqnq1PonHimA0PXfUQSgsgANr8pjrn5euqbqZgsc3hdG4M56ylCanR9wczzagCC8bS+XMsiUHtJ133fyjWnby95Imi/ELu3vjs3vM+RAJfstxFSYA404W5sSnkNlOs+OZfNAQ7Xude9/SXosT6fyzJyjyijZ7ht6ojk8GBfJPBAs7N7AGi1zf/o2UzXPep6BZvDLs6vr3qwnraox+1EXlKYD6DQM3z9WmELCybr2FK9eM5THP/XlYBVehBKFdQMHK2skF15okJr5HIVwhRNAbNw109PdL6SVJ7iL6lx5Y3KGnlmyxvpQjyegJNHFQC6GoofxGsbK8hxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eWGmaU3ww88NX4aApDuAs3qQBSJ6XOY+wHx365XbuRs=;
 b=S9uiXGxlBfRcrhWIqm1kNSe2EeIXU00uQRlFDw/uB8MShN4a3SaAyj2lmTi3mtbgAO4LUfpWhFGLpHDsZE7Tg8XUweoGaQCvjcsOJbYdNyRLakYsT4J2mLCoMlRAWqeFkcZYsD8dJawpQorsRL+C4hYLJ5uXhQ+ypwgyAw3OJjOxzHDTZ1QZJzZUrdL6AhdMPt//nQ0915NMMMWd3irfheqtgoPxTXrnlRPKQvVdeGPKuFwI3jHJKZ69XnbGmkUllrVS6P84esrheE157mWGr81Gegxnp2iFqIxqLnqmNLZg1GcpO96QQm37/DMRogKccBxpSgPs5EBY+L8rQe5Kig==
Received: from DM5PR20CA0033.namprd20.prod.outlook.com (2603:10b6:3:13d::19)
 by BY5PR12MB4324.namprd12.prod.outlook.com (2603:10b6:a03:209::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.22; Fri, 23 Apr
 2021 18:21:46 +0000
Received: from DM6NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:13d:cafe::66) by DM5PR20CA0033.outlook.office365.com
 (2603:10b6:3:13d::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21 via Frontend
 Transport; Fri, 23 Apr 2021 18:21:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 DM6NAM11FT067.mail.protection.outlook.com (10.13.172.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4065.21 via Frontend Transport; Fri, 23 Apr 2021 18:21:45 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 23 Apr
 2021 18:21:45 +0000
Received: from sumitg-l4t.nvidia.com (172.20.145.6) by mail.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 23 Apr 2021 18:21:38 +0000
From: Sumit Gupta <sumitg@nvidia.com>
To: <eric.auger@redhat.com>
Subject: Re: [PATCH v15 00/12] SMMUv3 Nested Stage Setup (IOMMU part)
Date: Fri, 23 Apr 2021 23:51:37 +0530
Message-ID: <1619202097-13088-1-git-send-email-sumitg@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <20210411111228.14386-1-eric.auger@redhat.com>
References: <20210411111228.14386-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1523436b-7bf4-428a-c4f2-08d90684a723
X-MS-TrafficTypeDiagnostic: BY5PR12MB4324:
X-Microsoft-Antispam-PRVS: <BY5PR12MB43243967FEEE1EB2C61A7445B9459@BY5PR12MB4324.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xxK0Ge1GxhRuQw3iJtszeon8UQHk8Cf6bVrH/fRBhStEr6FOtUVXSvt7XSgbSidTNiC2+PLNAzv6g13YxKjwKPxyCjviK//VryTZbdV5XJpxpSg2NjGUz7Qt171s3ZzjPmOpfreaeVcrA/DWd9AC2LFdn557Tiozar2O0rMY3+DDfEJSbqM1WtV/l3Hb5qh8DQs9skNg5XQR/y6kbwi8Lxbgjp/a6YdIqJtW6LOLlK2K+wKfUSvANkyHvSypvPCZgtg7CawVlkFK1auFv4KPTB/SDEKCgxu3XfEDnVQq0oYZNE4TQy6DVDdjLXko4yh7iz8DKy/WJHpdn5KHLwebMxN/LPlgww5jcQlOQAor4IvYEYjJfHYxIMgbF7M2NaGOKqUhKKgOr5I4c2RKZqi2KRgZT4kPonaQJTyBeydxLf5TdWjAJRxP/Y7MXbdaw+xbhdtnFFsolxE9zvQG2s/tfICy1JmFBmZtvCorS73McvaCDFTXjmpQYhBEfNzvE3JyJpnPAMsqklzLSnBpHrJye+SgSpdqf6TqwVdOFbM3xE6zBLgxj3DUixtIdi6KFW9rCTgnRuGD9mJhpOWsK5sYXhCIlDfty/90aJtaC22RXyV4+ivTEktMuuNzAJM+pbdZZk0swzn3AbXxYNd+wPw+CA==
X-Forefront-Antispam-Report: CIP:216.228.112.34; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid03.nvidia.com; CAT:NONE;
 SFS:(4636009)(346002)(376002)(396003)(39860400002)(136003)(46966006)(36840700001)(336012)(6916009)(107886003)(82310400003)(558084003)(36906005)(316002)(47076005)(7696005)(36756003)(83380400001)(7416002)(5660300002)(426003)(26005)(86362001)(7636003)(356005)(4326008)(54906003)(82740400003)(186003)(70206006)(2906002)(36860700001)(70586007)(8676002)(478600001)(8936002)(2616005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2021 18:21:45.8085 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1523436b-7bf4-428a-c4f2-08d90684a723
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.34];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4324
Cc: kvm@vger.kernel.org, vivek.gautam@arm.com, will@kernel.org,
 kvmarm@lists.cs.columbia.edu, eric.auger.pro@gmail.com,
 jean-philippe@linaro.org, wangxingang5@huawei.com, maz@kernel.org,
 vsethi@nvidia.com, zhangfei.gao@linaro.org, Snikam@nvidia.com,
 alex.williamson@redhat.com, linux-kernel@vger.kernel.org,
 lushenming@huawei.com, iommu@lists.linux-foundation.org, robin.murphy@arm.com
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

Hi Eric,

I have validated v15 of the patch series from your branch "v5.12-rc6-jean-iopf-14-2stage-v15"
on top of Jean's current sva patches with Kernel-5.12.0-rc8.
Verfied nested translations with NVMe PCI device assigned to Guest VM.

Tested-by: Sumit Gupta <sumitg@nvidia.com>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
