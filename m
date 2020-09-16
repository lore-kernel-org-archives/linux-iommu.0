Return-Path: <SRS0=cHis=CZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC8B3C433E2
	for <iommu@archiver.kernel.org>; Wed, 16 Sep 2020 13:53:13 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19E48222B8
	for <iommu@archiver.kernel.org>; Wed, 16 Sep 2020 13:53:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="R9J68+9g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19E48222B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id C234E85BDF;
	Wed, 16 Sep 2020 13:53:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5otn-oNYImCz; Wed, 16 Sep 2020 13:53:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 3095085102;
	Wed, 16 Sep 2020 13:53:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2401FC0859;
	Wed, 16 Sep 2020 13:53:10 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AC291C0051
 for <iommu@lists.linux-foundation.org>; Wed, 16 Sep 2020 13:53:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 9A79B86FBE
 for <iommu@lists.linux-foundation.org>; Wed, 16 Sep 2020 13:53:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aLQbkfb-KKO4 for <iommu@lists.linux-foundation.org>;
 Wed, 16 Sep 2020 13:53:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2065.outbound.protection.outlook.com [40.107.93.65])
 by whitealder.osuosl.org (Postfix) with ESMTPS id A3CB286FB7
 for <iommu@lists.linux-foundation.org>; Wed, 16 Sep 2020 13:53:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X5da7cNISfxChe0KkcXmjqHno29CSqeCU21shADvfKyyvM++byi1y9k4Q+EXRN57FzqNta0+J+e6P3hY93LkLsBKZFJqoL/eIGlnQkly/BVejOQzxkES1PEkFQcRMrvIYoPzEIIrEFwYRcrdgYT4TKadjT4Q98oD41SdUXtFFXKavoShPEw0zO0pzu3iXpggSjsR/JFeJovcaHxy9Q/l9HyZjzApu9rmNVv8OfHR50bjoDJquk/+RVNtGjOo1Sj5yNm+9cyTVKy9GBaopLmV7SOfUGJRow5lYgzIdBfXCJ1p9UX6yndPpqoyhgB2pFUOkADzwaS/RgF6LoTce588yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=djf7fjP+Vm9HzJ6fkqPzKMJSSUTbtpKj+TRNn8LmcaQ=;
 b=fynnWMKvstlWO8DJF8IXnSVDeteRLPnrCyqEicdbyWozIFHixUoK0RVQ+y2bCj9/pM4I046QigceTl2sm5+VXwSehrDc9vzHhrOW/nufDnSSUzeSFix17YP8cI4ryOgvu4dTlkKmWvMNUY2EQTAR7BYWHsBKI41TM8DGVo8AzfUzbMowYOfmBCgY1xwb7F2B6zCOmP47BMnOwVfbncu0lt8upx87M1yYWjGD1boVYjAgTY/Tckn7eyNFq3XD0bckVltDbv6RX2aBREYIFbquwWsQJiJo3TKZX6ng5+lNXh6Omysno1k89blfeBMNpmM+75G8QNAqxg3Iw96jT0WY4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=djf7fjP+Vm9HzJ6fkqPzKMJSSUTbtpKj+TRNn8LmcaQ=;
 b=R9J68+9gCy4FpKrjcLaKMXfHxavonn31Z36bgA5lGGZocqisoBl9Bw08gHIi+A7i3gyZR3qpGHEtNEX6Ob+nYC5J1NLFdgyFLF69qscs/OUrL8IU0Sr66OoutvzmmWn4ViTimMWuwNnWX6Sxnz6C5cjvA4GfK/Z10zLPGdXDiXc=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1163.namprd12.prod.outlook.com (10.168.240.18) by
 DM5PR1201MB0123.namprd12.prod.outlook.com (10.174.104.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.11; Wed, 16 Sep 2020 13:53:05 +0000
Received: from DM5PR12MB1163.namprd12.prod.outlook.com
 ([fe80::48cf:d69:d457:1b1e]) by DM5PR12MB1163.namprd12.prod.outlook.com
 ([fe80::48cf:d69:d457:1b1e%5]) with mapi id 15.20.3370.019; Wed, 16 Sep 2020
 13:53:05 +0000
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org
Subject: [PATCH 0/3] amd : iommu : Initial IOMMU support for SNP
Date: Wed, 16 Sep 2020 13:55:46 +0000
Message-Id: <20200916135549.146468-1-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: SA9PR10CA0011.namprd10.prod.outlook.com
 (2603:10b6:806:a7::16) To DM5PR12MB1163.namprd12.prod.outlook.com
 (2603:10b6:3:7a::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ethanolx5673host.amd.com (165.204.78.2) by
 SA9PR10CA0011.namprd10.prod.outlook.com (2603:10b6:806:a7::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3370.16 via Frontend Transport; Wed, 16 Sep 2020 13:53:04 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.78.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2de8678c-a855-44fe-6c28-08d85a47d60d
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0123:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0123C56A39CDAD416F257159F3210@DM5PR1201MB0123.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hto+kK8xTW4p1HpX5gSb4IFfj0uArq+tjd4PyTFhZi3GgQTImC0CVQXxvV0eho5kPgp/lzuBexR63RuLIy6DhSHvIMHeTXCCCxJFVRxYPyqxjU4jVXQ6/GnjKJrLcig3OS60k757Yf+uhxcYfOigtDcCXJKshsP+Ah6LrUxkR+cyJ3c6CbStdhkLZu9IQpGdN1ZwtmOSRDdqvLc7wPmfPQcJbk/7ldUftL2o9izeY2QDb1aVkItbZcHMmCMzzTfkGmOCCAYdqE5JI8BrgtO5aGcBJ1Eu3DrZxoInDpRcHmiRtlYndWH+nOImeejMXQVxdz2/1iP4PSJRUNpkvOwkV7emhrjtKXvz7WRYucPQbUiPEoIzTWc9sPe2Iwb0dvIBPJb8rgtou4f0k8s3W+/G7Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1163.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(376002)(136003)(346002)(39860400002)(186003)(956004)(2616005)(478600001)(44832011)(83380400001)(26005)(16526019)(6666004)(4326008)(8936002)(6486002)(316002)(966005)(86362001)(66946007)(52116002)(5660300002)(66476007)(66556008)(7696005)(36756003)(2906002)(8676002)(1076003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: ndaFP1Mxj60vYKDv9P9VHmHEnpjgY4aVY+0FOwYzpTwVmrOHgSUeKPTzgtKEdlMy98B4yH4Hg7vPni26hfsPFD8h888ijDCnLtm1ue2jKCggYDKAUtxDxTgylbEf9i2TB8R2E5uqJVPnsSqkRzW4Z7G4FBLsixTZUDKaI8vBkLR1zqhcgzYjFmjDZXvmDK6cxlF7kBOEuU/TXDyWKuoPtyu2wr5lg5D6ELbsr1qP4wgUrwobyrGRqmwz9YsGs677HM8yKMSHiokr859Rkf2RkDecLUWUNBg0uz5DIi59C4Pig6phCS+5LEMqqEfbkV652EYbwD5kL7YT4kPqqikKtIaq51P8uOfzJtJgZAAkcPpnl85XNBQyOuDEqjppvo50VquZZIx3JeT7PAQf3JHMRhjwhZQaNdJ5a0MveGU9pv9hvqFZc6rz3GXJUjSnwZE3xxLEJyVWsxaf201Zz2R+SSSj8/XHtTewfUGBGZpshFBFzt7RhDQRtOvY6UJXpVkYAjepMqJFqBOEjY3OpA0YBZwJodF8aRIi7/Ougi9v87bL82aVTNhf3KrQ+vPWNoQqwFbnpBHl9NGUgdUPRcEnlecbGpFsgwd9y2e3RUaLca51Q4xazgHn/aJPr+5pmfSL4RKJULiVMSbNB38nTdcf5A==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2de8678c-a855-44fe-6c28-08d85a47d60d
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1163.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2020 13:53:05.8179 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q7OoAHpr7n4LfUmGToTQCKclV3QKJCFFBLmrfeXxXQ6FiUise5YCBV/99HuSu+6BqejTYEvnMBcjyhuoJcbNaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0123
Cc: Jon.Grimm@amd.com, brijesh.singh@amd.com
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

Introducing support for AMD Secure Nested Paging (SNP) with IOMMU,
which mainly affects the use of IOMMU Exclusion Base and Range Limit
registers. Note that these registers are no longer used by Linux IOMMU
driver. Patch 2 and 3 are SNP-specific, and discuss detail of
the implementation.

In order to support SNP, the current Completion Wait Write-back logic
is modified (patch 1/4). This change is independent from SNP.

Please see the following white paper for more info on SNP:
  https://www.amd.com/system/files/TechDocs/SEV-SNP-strengthening-vm-isolation-with-integrity-protection-and-more.pdf 

Thank you,
Suravee

Suravee Suthikulpanit (3):
  iommu: amd: Use 4K page for completion wait write-back semaphore
  iommu: amd: Add support for RMP_PAGE_FAULT and RMP_HW_ERR
  iommu: amd: Re-purpose Exclusion range registers to support SNP CWWB

 drivers/iommu/amd/amd_iommu_types.h |  6 ++-
 drivers/iommu/amd/init.c            | 44 +++++++++++++++
 drivers/iommu/amd/iommu.c           | 84 ++++++++++++++++++++++++-----
 3 files changed, 121 insertions(+), 13 deletions(-)

-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
