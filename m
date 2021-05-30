Return-Path: <SRS0=A9HU=KZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B0C7C47091
	for <iommu@archiver.kernel.org>; Sun, 30 May 2021 07:51:19 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A8FB61107
	for <iommu@archiver.kernel.org>; Sun, 30 May 2021 07:51:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A8FB61107
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3C59460611;
	Sun, 30 May 2021 07:51:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9fOEv4amYJFg; Sun, 30 May 2021 07:51:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1D07560637;
	Sun, 30 May 2021 07:51:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E2D24C000F;
	Sun, 30 May 2021 07:51:16 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 376E4C0001
 for <iommu@lists.linux-foundation.org>; Sun, 30 May 2021 07:51:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1350D403D2
 for <iommu@lists.linux-foundation.org>; Sun, 30 May 2021 07:51:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id V_EZMaRqSYBl for <iommu@lists.linux-foundation.org>;
 Sun, 30 May 2021 07:51:14 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2078.outbound.protection.outlook.com [40.107.244.78])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8E516403D1
 for <iommu@lists.linux-foundation.org>; Sun, 30 May 2021 07:51:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kKsqNHCk+gzd0b5uEm2e9NSgbi6cp2GXQg7S7Wbs7MEaqeZjLxBjEeqrCwVPpy1jwl+CO4lHYZ8rqKBOAI/bIXvgUYEKLOYPVBTCb3RRi1hxo5xH4mcFU66/g3PaCl+A/rWQxkWNK3/0p1jdGaPDxEdndGlbB+8Z8fwMy6Xjgp9ebPaKw8AbuNTehtS0CRHjju1NeiJ9W5Kz+SjeoL7wvq4kUUx5j7MSxIbWXzTHx2Xhk+VydcIpUZxbVZ3PDbxQnaox1pD0kPi/0yb6UyarbKeXhiWij7172xU/p7z+1cw3NDJ0w48FxM+4Ls5YLHex+7UkvkIXoxG3fthPN5DlSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KBwbIBzj8imPWG6EEYgamRQFrEzs3zpY0tjYft0+m6M=;
 b=M3273Ahg2COJXVLYVKdXbnE3UYQf+InqJxGeLwm/6upse0sZdrqPlgGcfbDJWTJlqwFXnT0On+adQDlaVm5LtRhz8QXHOTJmyeNzXEsoPi4OtzInWI74Kk2l2SVUtbsVjwzq8q8icfO8gZ5zxyy+828ayd/MyPAAANXQVTy9nvVa27sFzvDfcJwPPzmxoUw1neXNo35ESqPfZ1TFbi55I2NoejqCPbY/Ov2sgx6jSPhTwtwZjn9bvRCrNf+Xghet3dmt/KAmFrWD9heh4wM5WAs2tmSFbFTpUoevnMPh7OYx8BAy+cABr3av95NBE6p6Uv4UNE/MEOYRWAXqBpSFZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=8bytes.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KBwbIBzj8imPWG6EEYgamRQFrEzs3zpY0tjYft0+m6M=;
 b=Cm93n4VfZrefZF7g5MGc3HzWg8fN/HIs+nQdubwrzMtdV6D9oza6ZJ+H52YrG/xU1rMMQIeLoeAGhdc8vr7+bja2gn6uzmNY90a6p0U5JfkR7q4gedDOdVYJc5hgiSr3vuzR5fSkP45/uixgggOoQJMFlu+6uXeVtr8nq8ZRkiYjnx4PNd3e9PO1AxQt9XAfqfYgzyjnr/5+dRA3tOrutPPW8wsvptsOlDmn0K+YWBqxwXSi/OE7AjUWCqRz2cDpzd9OT+xl4ybMubywAt3/MTNpNVIWrO56B4hul5EUZuDWqEo/60sI9GqBLJvqD618Z9+QtFXkKjRigDQSiqoyeg==
Received: from BN8PR15CA0008.namprd15.prod.outlook.com (2603:10b6:408:c0::21)
 by BYAPR12MB2838.namprd12.prod.outlook.com (2603:10b6:a03:6f::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.26; Sun, 30 May
 2021 07:51:11 +0000
Received: from BN8NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:c0:cafe::be) by BN8PR15CA0008.outlook.office365.com
 (2603:10b6:408:c0::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.21 via Frontend
 Transport; Sun, 30 May 2021 07:51:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; 8bytes.org; dkim=none (message not signed)
 header.d=none;8bytes.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT033.mail.protection.outlook.com (10.13.177.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4150.30 via Frontend Transport; Sun, 30 May 2021 07:51:11 +0000
Received: from sw-mtx-036.mtx.labs.mlnx (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Sun, 30 May 2021 07:51:10 +0000
From: Parav Pandit <parav@nvidia.com>
To: <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
 <iommu@lists.linux-foundation.org>
Subject: [PATCH 0/5] Short cleanups around DMAR
Date: Sun, 30 May 2021 10:50:48 +0300
Message-ID: <20210530075053.264218-1-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3a3e94cc-9dbf-4ce2-3034-08d9233fb160
X-MS-TrafficTypeDiagnostic: BYAPR12MB2838:
X-Microsoft-Antispam-PRVS: <BYAPR12MB283876B14D5286E60E921198DC209@BYAPR12MB2838.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Hr9e0ci7w5DyHrdonsNvaqkxq8NhR6GoQuT5BS21gaVD/l8TYEmo0CHjWORiiGm6vyrGHFNW8Pn4A5a86ceBox9ei+U//QISj0Y0+HW90IeaGZuoNSbjpWt4xlsdoOBlgin3RtpO/sr8eRuiVxK5dAsihWPT2ihlJIcO0nW6F95UUdAWYkds79CSG9HAL8gmSmv70eS4HcK0ygRcYfrmw0nD4VZ5c2cLS5nNhiLAxQfKhW9V1EDDTbSUeDp0NbZUOm2y3Vyz2Yo2rtOsrpbbuCzSyILvZCZaiEKaKkWRPzcGHFAlAAPEVmkyN4l2ckV3bpgA9HYg5N3v2TCXgwPL7U8OArkF42Em8xMi9i/+QxkQrEKCfDSvVxRs7A16GmW05k0MoCxbEdHqrqw9EAcApCFrcx5bYPV4w5HPlz6rcdpnptQWAYfJ1kXX9Memy3A0ZBpdfsfiwURnsK3h1Vo7R5+EiGYbtVBK0JCnhcxgbNou5P7YD/U3HJ4PSMYXsVDIcoKlESUm8WmQwfHyvFFnyVfWyIjveqB+Zkp1blSrwn/ZNbtnov4MzJaTfo8cYkPlBC1UqjGs2YmqoXifPrryze4mLl5/2Uu3T86QnQ1ziFZkrk1biCmd9EVeFtmQaANo3b37gZiOKY4KlLhJgge78AmuSpoCXeTdr8KRMSvt7aM=
X-Forefront-Antispam-Report: CIP:216.228.112.34; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid03.nvidia.com; CAT:NONE;
 SFS:(4636009)(136003)(376002)(346002)(39860400002)(396003)(46966006)(36840700001)(8936002)(1076003)(36860700001)(5660300002)(110136005)(316002)(36906005)(478600001)(47076005)(54906003)(426003)(4326008)(7636003)(336012)(2906002)(8676002)(4744005)(86362001)(36756003)(70586007)(26005)(16526019)(6666004)(2616005)(186003)(82310400003)(107886003)(356005)(70206006)(82740400003)(83380400001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2021 07:51:11.3669 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a3e94cc-9dbf-4ce2-3034-08d9233fb160
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.34];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2838
Cc: will@kernel.org
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

Hi David, Lu,

This short series contains small cleanup patches for Intel iommu
in DMAR area.

Patch summary:
Patch-1 uses bitfields for few DMAR capabilities
Patch-2 removes unused iommu_count
Patch-3 removed unnecessary braces
Patch-4 define count data type explicitly as unsigned int
Patch-5 removes unnecessary typecasting


Parav Pandit (5):
  iommu/intel: Use bitfields for DMAR capabilities
  iommu/intel: Removed unused iommu_count in dmar domain
  iommu/intel: Remove unnecessary braces
  iommu/intel: Define counter explicitly as unsigned int
  iommu/intel: No need to typecast

 drivers/iommu/intel/iommu.c | 37 +++++++++++++++----------------------
 include/linux/intel-iommu.h | 11 +++++------
 2 files changed, 20 insertions(+), 28 deletions(-)

-- 
2.26.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
