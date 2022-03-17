Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35FD4C4332F
	for <iommu@archiver.kernel.org>; Thu, 17 Mar 2022 16:25:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id DD44140B4D;
	Thu, 17 Mar 2022 16:25:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VesXp5RIsjOn; Thu, 17 Mar 2022 16:25:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 6653B40B4B;
	Thu, 17 Mar 2022 16:25:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 077B0C0083;
	Thu, 17 Mar 2022 16:25:50 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6494AC000B
 for <iommu@lists.linux-foundation.org>; Thu, 17 Mar 2022 16:25:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 518B8417B6
 for <iommu@lists.linux-foundation.org>; Thu, 17 Mar 2022 16:25:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=microsoft.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id znxq4Lkg-fK3 for <iommu@lists.linux-foundation.org>;
 Thu, 17 Mar 2022 16:25:46 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from na01-obe.outbound.protection.outlook.com
 (mail-cusazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::3])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B5DB0417AB
 for <iommu@lists.linux-foundation.org>; Thu, 17 Mar 2022 16:25:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EAmeEfozy1ICrxUzvNM1+D9t8rxdPI+QTazfes5mpWTuBnRHsl5nhzb3FbkzlBgH6b16HHWcjPpADRmCDPdWpi6kB5efpbdxX+6euT5rSA/8DcxrwTSpmZy21OW4wIkwk+mAauIAAotVrrWyi6FiL3/+etYKIL5RcvJbomsDgNwEQ2cGwuTRDhqFd1tkK2tWTsVkv9Y823LF0RFRa2c/fsO58YV2bJQ9xJ5l0nA6A/gG3XBvZkeb3jmdw8nkcGCAoDOVypPI7eiKxjYxGhGbEMCXjbpSrFB4P4yRvofq0ZJjDYTS2W2jFqH2s1qdz4l9O/Ec80pW9hBnlDgESGQ91A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2yDLDyXVr4lWPvqstJjFwb/JQmGOxqMwR4p51AL2DjA=;
 b=JCEPgHJkxpVaKLCdLVHFBHWBModwZS5KxkoiA5bT6Df5/Kt7EhOHE3UeZheXUBT02BygFjNJEJ5XzE0r9WbBvF8WJRTIEie9YntIghkB3Mf9frdhFetOtNAXIl5qCuHx0pe6EUnU1Xfg3o6FocgtoOY2YF1Edcyjbh66CbCzckiL1c6P0gT2X8wfLb7oQGKnITZLl09zVMYyxlVAK19Cpf8eIOMfpZ8Qwd0Lks79U/gfANTIck+kBaXYCIgCI1St3WrR7Z8N6W/SDRUo4DKIkEVUq/o3nG/Ltlr+hHjck/iAlvQ+aq/Ld/Ei6hw19tESL+WGRXbtTeGfOyGQMYAjqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2yDLDyXVr4lWPvqstJjFwb/JQmGOxqMwR4p51AL2DjA=;
 b=Ox6SoDTR6ZwroRn7UIOMjYKCETmwMeANcUdl7gOhAUTMEbf1BYhsRurRu+rDc811okNdBZVP5i5Nf8zKZGhQgigCVlA4qwbvNMOBXRduU6W8fvwpYvpAVzjaQ+WYn/uJuk9+9pFHJbx6a8yliLcy1XDToLONIUjXGsSJimRqtd4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from DM6PR21MB1514.namprd21.prod.outlook.com (2603:10b6:5:22d::11)
 by BL0PR2101MB1796.namprd21.prod.outlook.com (2603:10b6:207:19::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.7; Thu, 17 Mar
 2022 16:25:44 +0000
Received: from DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::8c81:f644:fc1c:1357]) by DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::8c81:f644:fc1c:1357%4]) with mapi id 15.20.5102.007; Thu, 17 Mar 2022
 16:25:44 +0000
To: sthemmin@microsoft.com, kys@microsoft.com, haiyangz@microsoft.com,
 wei.liu@kernel.org, decui@microsoft.com, rafael@kernel.org,
 lenb@kernel.org, lorenzo.pieralisi@arm.com, robh@kernel.org, kw@linux.com,
 bhelgaas@google.com, hch@lst.de, m.szyprowski@samsung.com,
 robin.murphy@arm.com, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
 linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org
Subject: [PATCH 3/4 RESEND] Drivers: hv: vmbus: Propagate VMbus coherence to
 each VMbus device
Date: Thu, 17 Mar 2022 09:25:10 -0700
Message-Id: <1647534311-2349-4-git-send-email-mikelley@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1647534311-2349-1-git-send-email-mikelley@microsoft.com>
References: <1647534311-2349-1-git-send-email-mikelley@microsoft.com>
X-ClientProxiedBy: MW4P222CA0001.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::6) To DM6PR21MB1514.namprd21.prod.outlook.com
 (2603:10b6:5:22d::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 03e43920-5040-4f7f-f532-08da0832c933
X-MS-TrafficTypeDiagnostic: BL0PR2101MB1796:EE_
X-MS-Exchange-AtpMessageProperties: SA|SL
X-Microsoft-Antispam-PRVS: <BL0PR2101MB1796A5C6F4BE391CDC7B09F6D7129@BL0PR2101MB1796.namprd21.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9x7i7ZIcI1bM/9NhjjosCWUOYKMju4ofDVqyu0/7B2LagKOoGW4Onj7COHZgbXSejtDqpZyR/l1T51d1+BNYpAhShiZ7RAv29zlBsLOEGg2n1qBJyHQr+4oHQaBcO/43h7jI4hTO6S6ipj6mofU7zfzrgJHJRGicWC9TB3n3LWOyQPndIbA43k2zfM2d3hf3yat2uRSPZXjCflZriJdjGu9WpS6FZ5HbRA8LkhjHNjmD2xEaroxdQlINJ4UwDWwAJrC01yWALSfgqHgc7ss+FN5d8fHO+9Teey/+slAFtPGO1N8dHku/CcRwMEQuotVQXqzDaiJ0Oa21IsFiizAeanNRB46ZtiHfriFUEambnYJrbkSy0N7xibsdpNTpWdxwo4lceJkroRoR5LXVKN+Bi5xY2DRgoj14lU7hoTfbTQaRZaslmwYAioWHNwtY5a151bmkDoENntLAp4wqFaDG4r8ffA8ipN27Ly9w4Bz2M9yzV5GEhkYlfSjb5mapeQWcYjqBEFbwVtxhd48xBVmS+G6lwgWHUvrXYd53R27AmCre0ieQ+tPbiKukINkDp9YHTFCfnr6PbiPJZFd/aBonI6ufLKujOrVKVZXYyvvANYDxwAR/mrfGZBYQwPr6i9wNuvUPjzeMtzlWgsX/o7zHBDx1/jC9JqXMAkU5DYFOD4CqmSkNs0PPo9ibZ2iRagne2PddUO0jYLg5D4ALvGepm3kjtQQ1AzmndXE2tBDDBdPDW+yHfqdvnsK3HsjJq+KZUA4UvcXtU1/DN/2DWu+OyA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR21MB1514.namprd21.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(451199009)(6666004)(4326008)(8676002)(7416002)(66476007)(66556008)(66946007)(6506007)(921005)(508600001)(82950400001)(10290500003)(82960400001)(52116002)(38350700002)(6486002)(38100700002)(8936002)(2906002)(83380400001)(107886003)(5660300002)(6512007)(86362001)(26005)(186003)(36756003)(316002)(2616005);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?a8i393B9wI3gEpiiJDMkqrXXrbo9yH5qmTdAf5SF+W5VBQpQcwctoyyBar3Q?=
 =?us-ascii?Q?oRHQrJ//ff82BeJEBnb5XYqN46XiWs4QiddR+A9Ft9BRj41iX9Yo5S4F5fVT?=
 =?us-ascii?Q?oM4bSDVlGaCXz9Gfl4m/NuK2qqJVIxU1y7PKFX69Y8GLPxbMfgqc/ucY/Es2?=
 =?us-ascii?Q?Kf6UlAd0dzgb0aTQijX8ZyOc/ir40uHV1X+SGySmZDM9596t3wK40fX55qse?=
 =?us-ascii?Q?GpqDx6K1UZDJAYVIwhGS0eOED1+OtKc6mN0n2Kld/MhwoNcefKkU6u8OXs21?=
 =?us-ascii?Q?KmNB48mV2anlCBxuYYaUGvr19XO4NiZaAHXWVs9rtyR7rEDqjusA5q0EZOk6?=
 =?us-ascii?Q?PD0cIioPlOZmYvrMnJS4+kqDniIPNKLLfRwe9nMW2KrV3dzZtzvuBABQY2qR?=
 =?us-ascii?Q?QIlpW7Rz1kq/eB1z6dHA0YzZ+y1YnznLcEZH8THHtYN8T2KMyKSZ6slGM8ky?=
 =?us-ascii?Q?/dG8BS91cJNJ+9hCvV8FFfKshytVMnf+hLGw1Iju7ASOKdsJxTwjhDBZH3CA?=
 =?us-ascii?Q?+dteCcCNcanVTs2I1dijgRK+QNf5dnRqFV7jmmXK8W9W/FEXIt23g4OnoFOd?=
 =?us-ascii?Q?/OtDps+73SLQuKa65Sq8d5alY1Hhf0hgCb+YZIg6UL5Aczcr3eKD33g4iyuF?=
 =?us-ascii?Q?hz79jeVhbFxmSYtXF0QRFGDVXt4NuFDUZm58pdA6rlo/YL98cRtXWU4EOXyJ?=
 =?us-ascii?Q?3fykALcW9rZa1a1lS4s+tLhW9InXPeEyOf2ZFhBWjUBz4SOxyX83g4PYMuBB?=
 =?us-ascii?Q?ODxAWFfU8Uulj43hmgdCmy4LtwI60+tuPTYxJ/lEvrGJ2iFt0Srt2kLd02jz?=
 =?us-ascii?Q?SeJq17jtFJqau0SNK7t8cBq36QEIppCC6sOJiiLZtXdeU4NJVSI5h8EjtN7r?=
 =?us-ascii?Q?DTmJFlEUEO9XvnVw60GxHdo24jepFonbV3Sei3zwwTEOhqLJn2We1Gw3n3eu?=
 =?us-ascii?Q?nGD0yia60MWrD+zCw41ixNfqd7G5Ds0t4LRr0q1mAG1b87cicolyNp1q7tCs?=
 =?us-ascii?Q?ixpm7FlxCwBUfPo/uQGKyhJFbudznyENHVHj2frKAtIXBraGEV06SGKLWM6e?=
 =?us-ascii?Q?1pf6381dBoqgc5vedk0D7Ss8XnX6dNPM26tWmMdyRDGa9U9fqV9nX7h2eQe6?=
 =?us-ascii?Q?8zHu2bCFbDwB7XUqajQL8aV714gFUoWbGjfv9zeIgntnHTmyyVaJTwml0HRT?=
 =?us-ascii?Q?oiRINtCK6UhT7lMbY99zT91QaEZXG9vRs6fS46mjM3z+BbQqq4poj4UU85yp?=
 =?us-ascii?Q?aMHw8cJw6v7ZyND+xH/w6HxuACaPjYLDjdanOOgcnAMhK8QSQ29vkLairFeC?=
 =?us-ascii?Q?2hmTVyJs9rjmQ7h83sVETwkC+otP2cIz6byPOYDkOIPWk2THIEkybMBTJiW8?=
 =?us-ascii?Q?/1aykhimaKi7b94jAO04bmvLBbhFKRS7WkQW6HDzmPsvftSxd24HJ+YJ4jGW?=
 =?us-ascii?Q?oP9JGJsQuca/oKk3RxzFtuh8JdEA/7FeVjpLgkZoAU7R4V+ZEygpOg=3D=3D?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03e43920-5040-4f7f-f532-08da0832c933
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1514.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2022 16:25:44.4708 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9KsrKkWFiu3a4jdU8kI380/s4lM/vWB/mIUIp4aia9PJvtlZkBYeXmsM/RStytXY5VKtvgrImeqsB8MJsXiarQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1796
Cc: mikelley@microsoft.com
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
From: Michael Kelley via iommu <iommu@lists.linux-foundation.org>
Reply-To: Michael Kelley <mikelley@microsoft.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

VMbus synthetic devices are not represented in the ACPI DSDT -- only
the top level VMbus device is represented. As a result, on ARM64
coherence information in the _CCA method is not specified for
synthetic devices, so they default to not hardware coherent.
Drivers for some of these synthetic devices have been recently
updated to use the standard DMA APIs, and they are incurring extra
overhead of unneeded software coherence management.

Fix this by propagating coherence information from the VMbus node
in ACPI to the individual synthetic devices. There's no effect on
x86/x64 where devices are always hardware coherent.

Signed-off-by: Michael Kelley <mikelley@microsoft.com>
---
 drivers/hv/vmbus_drv.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 12a2b37..c0e993ad 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -904,6 +904,21 @@ static int vmbus_probe(struct device *child_device)
 			drv_to_hv_drv(child_device->driver);
 	struct hv_device *dev = device_to_hv_device(child_device);
 	const struct hv_vmbus_device_id *dev_id;
+	enum dev_dma_attr coherent;
+
+	/*
+	 * On ARM64, propagate the DMA coherence setting from the top level
+	 * VMbus ACPI device to the child VMbus device being added here.
+	 * Older Hyper-V ARM64 versions don't set the _CCA method on the
+	 * top level VMbus ACPI device as they should.  Treat these cases
+	 * as DMA coherent since that's the assumption made by Hyper-V.
+	 *
+	 * On x86/x64 these calls assume coherence and have no effect.
+	 */
+	coherent = acpi_get_dma_attr(hv_acpi_dev);
+	if (coherent == DEV_DMA_NOT_SUPPORTED)
+		coherent = DEV_DMA_COHERENT;
+	acpi_dma_configure(child_device, coherent);
 
 	dev_id = hv_vmbus_get_id(drv, dev);
 	if (drv->probe) {
-- 
1.8.3.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
