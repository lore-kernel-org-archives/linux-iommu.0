Return-Path: <SRS0=ckUw=NL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBF47C432BE
	for <iommu@archiver.kernel.org>; Fri, 20 Aug 2021 20:08:55 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C2EA601FF
	for <iommu@archiver.kernel.org>; Fri, 20 Aug 2021 20:08:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8C2EA601FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 610BA60712;
	Fri, 20 Aug 2021 20:08:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KCpiLLGYIWUy; Fri, 20 Aug 2021 20:08:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 6B13360601;
	Fri, 20 Aug 2021 20:08:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 43F6EC001A;
	Fri, 20 Aug 2021 20:08:51 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A71FAC000E
 for <iommu@lists.linux-foundation.org>; Fri, 20 Aug 2021 20:08:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8887C4250D
 for <iommu@lists.linux-foundation.org>; Fri, 20 Aug 2021 20:08:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ekZtSQqJoSny for <iommu@lists.linux-foundation.org>;
 Fri, 20 Aug 2021 20:08:48 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2071.outbound.protection.outlook.com [40.107.101.71])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7655F4253A
 for <iommu@lists.linux-foundation.org>; Fri, 20 Aug 2021 20:08:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kl4MePnUV69AnSvxhoVa7SxpK45PRSQjCNmzqGZ+g+274dz/O/ABdTmmPnMvvN3+2/fJ7DvE1LEw/ASACRJO2QWmX5kzZoI2qfXeaWnw9Nydqs2tfdtufopbI6vdYZbEBhMGZ3eL/tz5LWxVRwSGTAX3juL1+qmscsDFdpOA0vr14Bo7tWx3cjjx40ceaXPdX2niVDxQuhfSb4dRVavY+Bi/WJOCFYhrWKTtOuxZb3vb47nWgE0wf4qWudCFSljk7/QABtlyzokxD3+MJWFY4LQIna+xLb7QBMcJhdgPQV1f3Wn4F1AWrhLpHA+O9ZkiZgrsDZXBNe3DzCB3sXGuhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BQD9DZAe6XCEPVeM9Eol/dVxtvPebJGMbygIq0/ld/w=;
 b=ZVdEpHpIKKGngnb5eAKBBPD7aWJ3HsqbC1Z9/hGXajjC7lABISosVWA37IWON69DVTbtj82mgIbUPsMnCDRv3QBebcd+zZzHO/Z1EqxjIZpFnM0+fxN190ortSe6aonkyAqxSw+3IG+XY7+g5B9OTFRxpvoV9XBVMSRgM3aALIsAAeA0mRe6XVz6UTIiwCi6AxjD8RMNWzOoetfZjBEsL9Dv3xT3aS2gYNa/UUafiiK9DB3TjTpVmrEAFePPZHr2hfwQYUyeC+IgqgXsX/BbhrBViR6PQuwyQPSq+B0UVg9zwWOi5cB2Njc4FDcGI2uaQlNKHvIOyrijMPjzCextlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BQD9DZAe6XCEPVeM9Eol/dVxtvPebJGMbygIq0/ld/w=;
 b=DoU+nqNIciQH9VCHlnvp8cAqfp5o4rvXxB+t8eMrymqCtkLVmEDQDDTn1/6MSxeSeHecVIY1sCkycC6keo+zTx1LbMSbRQ8dPH4I/zTLazz/xnJlKh40e5y0XPvd4ZNpFKjOB99FachWUklmaYfLVHeLjsNGaTcp4FQ9Ij9w7YU=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM8PR12MB5445.namprd12.prod.outlook.com (2603:10b6:8:24::7) by
 DM8PR12MB5429.namprd12.prod.outlook.com (2603:10b6:8:29::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4436.19; Fri, 20 Aug 2021 20:08:46 +0000
Received: from DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::1dbc:947c:2913:449b]) by DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::1dbc:947c:2913:449b%3]) with mapi id 15.20.4436.019; Fri, 20 Aug 2021
 20:08:46 +0000
To: linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org
Subject: [PATCH 1/3] iommu/amd: Introduce helper function to check feature bit
 on all IOMMUs
Date: Fri, 20 Aug 2021 15:29:55 -0500
Message-Id: <20210820202957.187572-2-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210820202957.187572-1-suravee.suthikulpanit@amd.com>
References: <20210820202957.187572-1-suravee.suthikulpanit@amd.com>
X-ClientProxiedBy: BN6PR1401CA0021.namprd14.prod.outlook.com
 (2603:10b6:405:4b::31) To DM8PR12MB5445.namprd12.prod.outlook.com
 (2603:10b6:8:24::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ethanolx5673host.amd.com (165.204.184.1) by
 BN6PR1401CA0021.namprd14.prod.outlook.com (2603:10b6:405:4b::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend
 Transport; Fri, 20 Aug 2021 20:08:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 175ff6a3-5f02-49da-a992-08d96416514b
X-MS-TrafficTypeDiagnostic: DM8PR12MB5429:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM8PR12MB542917F3D37B4F546686944EF3C19@DM8PR12MB5429.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Kv8JUTvtYkzdusT2IU+07BquJOHp6Adsm6rwYibz8DQiVt+gd/myqe6XjE3LqRR2QxnqeWEHCWmxh40TKGKd1mLNEDorgEU34mflBLm6RFQOZ9eZIW1InYLW6+ZafiajyYFjV/TieUZkr3X+hxzewPNfYnWbpMZliIwdGKwn/IKNj6y+7a5tGuGttIrvO9Dc76P5h+Idz/KHQnHmvoAFjoFAD2vl2pD0k6l6khtNJ0eGUFYVi0eFv0p5ApH39L6soyA/W3ttTdSwbjN4G4BqJVWeU5Q6Ptt3mz2CvBuSekEvjtmLREoUVX/7Jqi3AKW/u7DEDz3sMKLw/pMmmBaPS8D+vD5y7xQ1c8Ai4Hy1+4VHnOcpaP6KK+CV+sQU14RipGljkLahS/MGT8eLUT1KUFR/ubLA9WGLELnBEhg3Edw5Z5p+USXeCbwNdeJA28YfdzAdE/pyErXv5h4EUZRYoteq6j5vgRIHFqNqMdIg0ld7iSWeM1Y7TnB3wMF1wom9m37RcxNUEiyCMm82xDwZYz4Z+IzZa3KS81E2cuaR8CtwYVzNJIFqzoCBQ15Y3Mj7F2P/1D2WIYGYjI8hpM+X8BwKprE29ngs5zEhn1Qco4TPEAGgaL1jyCL6It11lk+QQa1nc03v7Aix5tVhazJ4Xhksl/L9FQEiMPW584fIVKf9Dkr5Ttaz85WJk/Jk6tclAIapNUSBi6l+Wy3PqRJs/g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR12MB5445.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(136003)(366004)(376002)(346002)(2616005)(52116002)(478600001)(7696005)(44832011)(38100700002)(38350700002)(956004)(316002)(1076003)(66946007)(5660300002)(6486002)(6666004)(36756003)(2906002)(4326008)(26005)(86362001)(8676002)(186003)(66476007)(66556008)(4744005)(8936002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2gbS+JZ+Kw0wAJmxVcH5iH4ILvMjlgyOihoL8RmHrQWxZVPS+SUZlkraBRom?=
 =?us-ascii?Q?V6yHF/oxI18t+48x9PskrRIzVu5fco5TrTsxlR8uqu2cbt7Q8JQIFrnVpIHR?=
 =?us-ascii?Q?w/Vuj9OGzZaDe3BBSxjyOntWa7iJddlVp9Ts7QUxvTzOqfIIYXMY2ER80n+b?=
 =?us-ascii?Q?I+MX/3GFzKILm0LCjzx++FtBia6ByY2eygokLzBqvbX6YBYYeKnN3mZ6E76X?=
 =?us-ascii?Q?nv9d6mpMRHQPLBQSbWJXaKATOBg3AFmxUAdv55p6/siHZhQ8ngnCDYuNdLcP?=
 =?us-ascii?Q?Mv8cS90S7Os/ISQsILZVixBNryswh9Z26bXudo0kKFm+jPyqdUrQIvSNiV3k?=
 =?us-ascii?Q?FcbcKbrwk+zxtMvKikXKWL3xfmwzfO5zUnOCy7lYj+Rn5FbrofOeehDiRTng?=
 =?us-ascii?Q?wTxJsA6GtvnQfAhHFDljKxvTcLWGyocAMCj3SRrX9Or6tJmDNrEENhfdI58V?=
 =?us-ascii?Q?HsthvT5vMwcMYVCRAEBVCmMP7SFWCV0ZawLbIOJX+8OzYmKmH0/WyVDmC9NN?=
 =?us-ascii?Q?LVygsv9INiaSOQ1X4F5PGAKf/FvtPPVlN/I21HggjvfsQ5zbkJmlM5563qMY?=
 =?us-ascii?Q?LP+AzQndMXbNQ5MaaA/M5aHKgACzUlKHWoRaRl+07J5AveSL06+t/oqAy6ez?=
 =?us-ascii?Q?geWV2u5biUA37eGEEGYGpjMcpmcp/TLcewz60fiSlZe5ZX/tCxJ8W8Tg/ZzG?=
 =?us-ascii?Q?jeABkJBhOnO0L48FRPbbjNfH6blO3Czy2g9qfsiGcNTOFgIU+F9e1CJ368YY?=
 =?us-ascii?Q?ej/JJhsownnHsyflzx9O9Hs3GWXMRW8DKOffmncLuqTBbX0dEYhknkngdLlO?=
 =?us-ascii?Q?by781uscoXFDwZ3hW/43WGIb+PBybCElAn2B4OcDtUOwUAbJJOeriZZUfZVZ?=
 =?us-ascii?Q?MBAYnIRs4FDis8gG9ZTtiuBwcu6xXmT+4Xw0US0YFtfeHIUuNH7oM7u+w3CC?=
 =?us-ascii?Q?865bsKcX1ZlFK0Nsclp4pWL3rLXn6+fFKgj4MN91XqE8EZAHLlCDFnD0HhnG?=
 =?us-ascii?Q?yrKItuOkjyLaDpynUBfpgVfUtvmJ3ML2Wn6YGZ3493u1AtSJv2ncNeO8s2WA?=
 =?us-ascii?Q?1xvWeyu+ql4lptbDhNGcuyL6O31WS59tvQ7XA3t3z2FzlraAK4S2vEDWiWz7?=
 =?us-ascii?Q?9hKuo9TM6N/yDad1fhUly2y4ZJ3VnCafdnf3331NALmZYYa6LEuamGrk5250?=
 =?us-ascii?Q?qCNCrpxE3sRJHW5wIOWrUsKnMelbwqxZUXqSm8nYrKvSKYZqPXtW2qI+TXLv?=
 =?us-ascii?Q?iQ+Wb0nwb/BP0xe4+lS5Om/FlRn5TG5koR+0DABYNIgbaSGG8eglpznmSp/H?=
 =?us-ascii?Q?xs2zwjauZWUu1OpopDMqWiTz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 175ff6a3-5f02-49da-a992-08d96416514b
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5445.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2021 20:08:46.6702 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I4PGXeltD7/YjvjUkD3hzE+vWUct/U0Pihb3mJnAORAwjh3MCJSY9fWGQ/h/C+rQ15bxUMAiA9Bp9InPd6OOtg==
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

IOMMU advertises feature via Extended Features Register (EFR).
The helper function checks if the specified feature bit is set
across all IOMMUs.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/init.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 46280e6e1535..c97961451ac5 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -298,6 +298,19 @@ int amd_iommu_get_num_iommus(void)
 	return amd_iommus_present;
 }
 
+static bool check_feature_on_all_iommus(u64 mask)
+{
+	bool ret = false;
+	struct amd_iommu *iommu;
+
+	for_each_iommu(iommu) {
+		ret = iommu_feature(iommu, mask);
+		if (!ret)
+			return false;
+	}
+
+	return true;
+}
 /*
  * For IVHD type 0x11/0x40, EFR is also available via IVHD.
  * Default to IVHD EFR since it is available sooner
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
