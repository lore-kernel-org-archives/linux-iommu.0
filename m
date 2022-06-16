Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D363CCA480
	for <iommu@archiver.kernel.org>; Thu, 16 Jun 2022 00:03:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id DECA340150;
	Thu, 16 Jun 2022 00:03:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bzChljRGBxVE; Thu, 16 Jun 2022 00:03:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id B6654400AB;
	Thu, 16 Jun 2022 00:03:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 730A1C0039;
	Thu, 16 Jun 2022 00:03:16 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BB522C002D;
 Thu, 16 Jun 2022 00:03:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 913A040150;
 Thu, 16 Jun 2022 00:03:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ru2JcdVF_t6s; Thu, 16 Jun 2022 00:03:14 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2060a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::60a])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 81A5E400AB;
 Thu, 16 Jun 2022 00:03:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AMq+I0d+rv6DWK5+5MjKM8t7O+Nm+jW4m3qqF/ZowqEylM46rIxJH21BfiwPpPGIWHCcwyZuw6x70xvJj+SSBE8gO634aKu9Fi17THEtKBAeMcMMFi3CdplsEpWgfEWrv0foJgwHrl3arw1fL2ZQ/h7FoQntOekgd7rmdhwqaLPt44XR8kYtrsWV8G3ElAHWBfssVr955swKF//ouAEhoIt3ioxRSfCJlfGT46bcRbB7vT1d0bKlBZQ7AWf9y8XallflzAE01q3AOeT3tst/zgZ6Ot66qrehUckPEMLTN7hX55NePHuO2MUoYyInzahTheSJMQf7mus+djZtbnE8Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j9qe5GyGJkoJT4N85UUxHSJo8/UuOJlxedrgg+sXxBA=;
 b=Bt6oYtCVnrkmdEPocaB8ZERwdLQJfCKvQgkkJ2iOeF1mCamawXGPAZAg9NuUBDgpnZqQnJNqj4IlTrn7ePyrPZnQbNlLXfboPEcKIkXJzduqskvjbZnjewgsfbUiNxfSBZPEj0M9VF8jfYOdoR3+XTtBtdh9NY03LKBE6UveoRMDAoIkJ8cRBP22f1xgqQRy8b+MzQyppvUrWDSl2x9LYRkM0/cIMw5ylgE7O3BFtSCSgHCmTmXqazNs1MiAazo7l+Qf2MrPKjXgpuZiR5yQsgTRt3wqTbaxMwSkrlpW2FRohq5pORTg50lYXtKKHMkE3rt9+1LNYaW2s/6RySM3ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j9qe5GyGJkoJT4N85UUxHSJo8/UuOJlxedrgg+sXxBA=;
 b=iklFvp/DWW+EG3fkjCu5jNiwyB8NV9b90FOutlU00OdPpe7t1oQN7YHA/gYCnnQBL22beSrCtEU6fX0hhc1R2vTpg3/27xD3ajaGFhyMXqWelfZFir7IxdYO4X0QnkdA8Lw2/Sk+0xcdukFIxipMqfQ4Gh+pjbla/XA+xAUA7Fk2uvbFZnQHrJT40+Q4eUtPF+MKOnltHYNpneOE+5GeCFAamUEub82CjmDHWuX4lNmm836AJPSj8IHvgwxAEJRUto+gH3q6FeXPpEfWGif/XxhborHRYYlzKyo7fj1d/R9JQmMsq2OxqS1oTpwpbdPmB+asIWCjwtEukA1vBO8dvA==
Received: from MWHPR19CA0079.namprd19.prod.outlook.com (2603:10b6:320:1f::17)
 by MW3PR12MB4571.namprd12.prod.outlook.com (2603:10b6:303:5c::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.16; Thu, 16 Jun
 2022 00:03:11 +0000
Received: from CO1NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:320:1f:cafe::b2) by MWHPR19CA0079.outlook.office365.com
 (2603:10b6:320:1f::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14 via Frontend
 Transport; Thu, 16 Jun 2022 00:03:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.236) by
 CO1NAM11FT013.mail.protection.outlook.com (10.13.174.227) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5332.12 via Frontend Transport; Thu, 16 Jun 2022 00:03:11 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 DRHQMAIL109.nvidia.com (10.27.9.19) with Microsoft SMTP Server (TLS) id
 15.0.1497.32; Thu, 16 Jun 2022 00:03:10 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 15 Jun 2022 17:03:10 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Wed, 15 Jun 2022 17:03:08 -0700
To: <joro@8bytes.org>, <will@kernel.org>, <marcan@marcan.st>,
 <sven@svenpeter.dev>, <robin.murphy@arm.com>, <robdclark@gmail.com>,
 <baolu.lu@linux.intel.com>, <matthias.bgg@gmail.com>, <orsonzhai@gmail.com>,
 <baolin.wang7@gmail.com>, <zhang.lyra@gmail.com>, <jean-philippe@linaro.org>, 
 <alex.williamson@redhat.com>, <jgg@nvidia.com>, <kevin.tian@intel.com>
Subject: [PATCH v2 0/5] Simplify vfio_iommu_type1 attach/detach routine
Date: Wed, 15 Jun 2022 17:02:59 -0700
Message-ID: <20220616000304.23890-1-nicolinc@nvidia.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 38d382b3-0dd0-492b-deb6-08da4f2b9a1a
X-MS-TrafficTypeDiagnostic: MW3PR12MB4571:EE_
X-Microsoft-Antispam-PRVS: <MW3PR12MB45714E5B1234D1BF01D22472ABAC9@MW3PR12MB4571.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7nlymCkSZvHjAlogTUosVWCZYUw6233CO79vDT/r97bkZN0dVM0gxMnlV7L85oYQUGk/Gh2GuRwtpRASF6UKg5DJ+lEsdZ8bK+Km90B6FuR6h4h3zITBXlCmOG9yoKw+iOGsyMnns5YEYVKkVlZV4QKYcBKPQiEfNeCSWwsZKA40iRR9viGB3Z5JtePqBB4KRJ51E8a/2szJM6GDtjQfgiIEgU9VIjNryyUnGqKEDB6vn1vraoTRS24kL+2eMsJznKeJAkwuDu1d6ySmLqvFSMZ6x2PknqRjSgdtRu6vGZvjadJ2Io3X0cA/auG1C5iH9ajCsWzBPD7C+BTUg4N460jiqUaG35cChBYbmgaXmNZVWQUrtMGLREzAyYhsIhu0yZtMQhp68KEWfzBWiKXN0Zxm88N+Fmaa3yi5Zvq/iGChKIZ3oXrDakFcxumoM20XYJ3+D7jC/ZfPYIO9X9zyKU6qaqcItyKJFglH3YQfB5pyEWQsJo8u23UOJ58slfYNo6UGd3ng0/S+X/GA6UMSg7VYpvfSi0+RA16KNmA9PYAKFl1uRVZNuGDIONEnpqGhSS+JMQ4wb1eyO1jmk1jTX+r6a3Bmf9ud66cJA5+Ir4UAPNtSXn8/Q7Xp3gcV4gxqkgJvDQno2NgkC0G4W2t9jeQ6BMAklLE9btIKqSFyRWoitFNlG4YBAKkgxOJleq6781jYSXoxAf+/ykRH39VJ97pjUEdyq7QOJsPSOjyOUQhRmQtPP+PUNynLqnfh5hlOCMi6Kujy6TbvKmmoAKgbuLjnoSPo6fCJpdcqNJfh8AmsebN/IS5akV/n9Otvh2DcBXFSyy7rU7AN7Pam41mAmPgV3kohxmyinUvesqKC9PRH+yyzMYS0KZcsxzAK7nak4r+uVZGt3U2uc9gcYwFCGQ==
X-Forefront-Antispam-Report: CIP:12.22.5.236; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:InfoNoRecords; CAT:NONE;
 SFS:(13230016)(4636009)(46966006)(36840700001)(40470700004)(426003)(6666004)(336012)(7696005)(316002)(110136005)(5660300002)(54906003)(36756003)(82310400005)(7406005)(83380400001)(7416002)(47076005)(70586007)(2906002)(40460700003)(70206006)(86362001)(8936002)(81166007)(356005)(966005)(4326008)(921005)(1076003)(36860700001)(2616005)(186003)(26005)(508600001)(8676002)(2101003)(36900700001)(83996005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2022 00:03:11.2736 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38d382b3-0dd0-492b-deb6-08da4f2b9a1a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[12.22.5.236];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4571
Cc: jordan@cosmicpenguin.net, thierry.reding@gmail.com, alyssa@rosenzweig.io,
 linux-s390@vger.kernel.org, saiprakash.ranjan@codeaurora.org,
 kvm@vger.kernel.org, jonathanh@nvidia.com,
 linux-arm-kernel@lists.infradead.org, yangyingliang@huawei.com,
 gerald.schaefer@linux.ibm.com, linux-arm-msm@vger.kernel.org,
 christophe.jaillet@wanadoo.fr, linux-tegra@vger.kernel.org, tglx@linutronix.de,
 virtualization@lists.linux-foundation.org, isaacm@codeaurora.org,
 cohuck@redhat.com, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, linux-mediatek@lists.infradead.org,
 dwmw2@infradead.org
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
From: Nicolin Chen via iommu <iommu@lists.linux-foundation.org>
Reply-To: Nicolin Chen <nicolinc@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

This is a preparatory series for IOMMUFD v2 patches. It enforces error
code -EMEDIUMTYPE in iommu_attach_device() and iommu_attach_group() when
an IOMMU domain and a device/group are incompatible. It also drops the
useless domain->ops check since it won't fail in current environment.

These allow VFIO iommu code to simplify its group attachment routine, by
avoiding the extra IOMMU domain allocations and attach/detach sequences
of the old code.

Worths mentioning the exact match for enforce_cache_coherency is removed
with this series, since there's very less value in doing that since KVM
won't be able to take advantage of it -- this just wastes domain memory.
Instead, we rely on Intel IOMMU driver taking care of that internally.

This is on github: https://github.com/nicolinc/iommufd/commits/vfio_iommu_attach

Changelog
v2:
 * Added -EMEDIUMTYPE to more IOMMU drivers that fit the category.
 * Changed dev_err to dev_dbg for -EMEDIUMTYPE to avoid kernel log spam.
 * Dropped iommu_ops patch, and removed domain->ops in VFIO directly,
   since there's no mixed-driver use case that would fail the sanity.
 * Updated commit log of the patch removing enforce_cache_coherency.
 * Fixed a misplace of "num_non_pinned_groups--" in detach_group patch.
 * Moved "num_non_pinned_groups++" in PATCH-5 to the common path between
   domain-reusing and new-domain pathways, like the code previously did.
 * Fixed a typo in EMEDIUMTYPE patch.
v1: https://lore.kernel.org/kvm/20220606061927.26049-1-nicolinc@nvidia.com/

Jason Gunthorpe (1):
  vfio/iommu_type1: Prefer to reuse domains vs match enforced cache
    coherency

Nicolin Chen (4):
  iommu: Return -EMEDIUMTYPE for incompatible domain and device/group
  vfio/iommu_type1: Remove the domain->ops comparison
  vfio/iommu_type1: Clean up update_dirty_scope in detach_group()
  vfio/iommu_type1: Simplify group attachment

 drivers/iommu/amd/iommu.c                   |   2 +-
 drivers/iommu/apple-dart.c                  |   4 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c |  12 +-
 drivers/iommu/arm/arm-smmu/arm-smmu.c       |   4 +-
 drivers/iommu/arm/arm-smmu/qcom_iommu.c     |   4 +-
 drivers/iommu/intel/iommu.c                 |   6 +-
 drivers/iommu/iommu.c                       |  28 ++
 drivers/iommu/ipmmu-vmsa.c                  |   4 +-
 drivers/iommu/mtk_iommu_v1.c                |   2 +-
 drivers/iommu/omap-iommu.c                  |   4 +-
 drivers/iommu/s390-iommu.c                  |   2 +-
 drivers/iommu/sprd-iommu.c                  |   4 +-
 drivers/iommu/tegra-gart.c                  |   2 +-
 drivers/iommu/virtio-iommu.c                |   4 +-
 drivers/vfio/vfio_iommu_type1.c             | 317 ++++++++++----------
 15 files changed, 220 insertions(+), 179 deletions(-)

-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
