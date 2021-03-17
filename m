Return-Path: <SRS0=kdPY=IP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_RED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2259C433DB
	for <iommu@archiver.kernel.org>; Wed, 17 Mar 2021 10:49:59 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8969764F45
	for <iommu@archiver.kernel.org>; Wed, 17 Mar 2021 10:49:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8969764F45
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4FFD46F805;
	Wed, 17 Mar 2021 10:49:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4uIzd88T8bmr; Wed, 17 Mar 2021 10:49:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 284986F6C6;
	Wed, 17 Mar 2021 10:49:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F1628C000B;
	Wed, 17 Mar 2021 10:49:57 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A9747C0001
 for <iommu@lists.linux-foundation.org>; Wed, 17 Mar 2021 10:49:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 975374ADC2
 for <iommu@lists.linux-foundation.org>; Wed, 17 Mar 2021 10:49:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rAeao7_k2swW for <iommu@lists.linux-foundation.org>;
 Wed, 17 Mar 2021 10:49:55 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2060.outbound.protection.outlook.com [40.107.94.60])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 80F3F4A061
 for <iommu@lists.linux-foundation.org>; Wed, 17 Mar 2021 10:49:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MjWf9lFNZ5BA07xjm5MdoDldtuH9l4W76CT8mpKxD8/GKAmuShIBQW4NTnfa23l5CQzu+AcrVkAgOS8Y7o5lHS97gSOuieetVw8wEBTkNSV5au6/9Vs+EvDIqvBwvhYXO7GyeNATu+O8ooGATCCKtAjqSq1k8lL/RG42Shl8xtF1+cMFgrsmpyMwdCqTJ5a/zTATcI+XzjgL0GwxXvQevke5AygdKkk7NHjUOTaGxrRFABNp3+I7hp9KEDYxclO1rfzgxhbFmRQrUR82xs4o4Y+7NBtvOnkoKDroQmeLvDgCPohqRiclyU2W97Na6nTAmpT1SnGiR2RVE3oMV7CYUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1RMxDvXMyxWjo7wwhHu7r2pfErUkt69pk8SDWlQrkkI=;
 b=ml8gTugkRQHKFVZqiYwKSNjbTn1ex02DJCtG7aP0HOVz3uWDJHqcO2VEAwkq6YzNAOL3bIDyXEj7BtDKIyGJt74sTzs5pZc4AMLwnEiEg9cjV4LJZXiNu3L+kIHtO8QMfx5DDU+na7rkqzgkeutDBwz8ItDu1bH7/H0aF5SxHOsgm4I19NFn5B6RWNV/0CYtN8MuXR1imwFHPJi1DSgEULhLVIfaj9W02e3zZFYDbtbmiz0oVAMFNCDYmoSLCthrX/Ea6Gs+MhZSXzvOiQCCTKUEM6DcB80g+IFqa97Qu5FeBp2UL08YbyytGfrSUZm/FxskgjUOYAEluBqrMHOVaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1RMxDvXMyxWjo7wwhHu7r2pfErUkt69pk8SDWlQrkkI=;
 b=QZnLvJJa/56XAoSH17XTa+nG2XM1QwA18hMz5/YowgznKd5Yd5iWCcDsONDDDbCuYyRjOAj7iraco9iBOrBa/zDv0zYxzIr73OpWs5nq/cvT1n6+ObWwZDhQCjNR6xcDk7G5Xm2F1fOqMd+XdUc35JC1f0ldUV5c26YsZ/b2lmg=
Authentication-Results: 8bytes.org; dkim=none (message not signed)
 header.d=none;8bytes.org; dmarc=none action=none header.from=amd.com;
Received: from MWHPR12MB1248.namprd12.prod.outlook.com (2603:10b6:300:12::21)
 by MWHPR12MB1790.namprd12.prod.outlook.com (2603:10b6:300:109::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Wed, 17 Mar
 2021 10:49:53 +0000
Received: from MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::5094:3a69:806f:8a28]) by MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::5094:3a69:806f:8a28%5]) with mapi id 15.20.3955.018; Wed, 17 Mar 2021
 10:49:53 +0000
Date: Wed, 17 Mar 2021 18:48:50 +0800
From: Huang Rui <ray.huang@amd.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH 0/3] iommu/amd: Fix booting with amd_iommu=off
Message-ID: <20210317104850.GB2508995@hr-amd>
References: <20210317091037.31374-1-joro@8bytes.org>
Content-Disposition: inline
In-Reply-To: <20210317091037.31374-1-joro@8bytes.org>
X-Originating-IP: [58.247.170.245]
X-ClientProxiedBy: HK2PR02CA0198.apcprd02.prod.outlook.com
 (2603:1096:201:21::34) To MWHPR12MB1248.namprd12.prod.outlook.com
 (2603:10b6:300:12::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hr-amd (58.247.170.245) by
 HK2PR02CA0198.apcprd02.prod.outlook.com (2603:1096:201:21::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3955.18 via Frontend Transport; Wed, 17 Mar 2021 10:49:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 043e488b-b368-4e34-4a4c-08d8e932650d
X-MS-TrafficTypeDiagnostic: MWHPR12MB1790:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR12MB1790217EBE8FE87592EA4396EC6A9@MWHPR12MB1790.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2399;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AaAjG0IvDMf+pvBZMERAXB0RSEkC2n5vOXrS2hSI0FevGlXPmZosAwFZqm2CLtFMkgFydfbhhrmyWAF3vGFZGclp9LWUPsfLec9jtFXxTnahfOWjalPlZsFOEWSO7FFF2g4LF42mIDrn3AbQro5V8w78uUElu5mgBqjQmj/1X+uQF6fFQcSjIn0Pm/EmLnzOaxfmX6BVGYshZ/KjWbkMB8WhV54fOwzrBhRUppSIoB7l5q7xpnEc6pk93m0Hd2XtTFa1tAh5TU0MGk0xd4FEsF9MeunbTu/HsHWE3Ke4l4FXck9CqKCgxQbgKfHXQ9/FvBLlF+kcuHYHhc4ll+U72kFlzIoKhFhY+ZmBUq/7LgAp4mnAmTO3cby1cZFmNND/3ynFCVTQLM1VliBalNcgMTUThF9ZhewtwjJL89sBakkBJkYI4ka8Ws38BpzYQhsC3yhG6mrqOjHIMjGlu5bNvDJtv/j74tuNXzYzI3p+awN+a3DzkZkZjyau3xPdyWeGc34GtQNwdhk9Jk0z/hs+UoCsDP/lLGG9Ju/+o1WnsbwuYhSej0PvP1LDj9qDhIub
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR12MB1248.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(346002)(366004)(396003)(39860400002)(316002)(4744005)(66476007)(6496006)(26005)(66946007)(956004)(33716001)(55016002)(33656002)(8676002)(83380400001)(8936002)(186003)(16526019)(66556008)(52116002)(478600001)(6916009)(4326008)(1076003)(5660300002)(2906002)(86362001)(54906003)(9686003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?4gS9oHjQIK1zGWAdtIMvcHQtc2qcGFpAvaiFow79tccJ/gtmdlv1PjycTp8B?=
 =?us-ascii?Q?ezWY97HNIjh1JiUbj56UXNvQhIFHJVS3ktnEhMpl+JQyYXV4aRIGw3tWBR2/?=
 =?us-ascii?Q?O7b+lySTxUv+P6xJkHQSip99eQ7L7VzAHlwGcr8ZEhlHgjhIz9eyDk1o9Gic?=
 =?us-ascii?Q?9WzwAyAwIg+2pVqgeDSqr6tqfmOVMAHP8kzw7ABll41RIoAwNGeC0e8xtHSc?=
 =?us-ascii?Q?JC6u9BcvQqR/m7LYlGVEetqGqOX2VeoS5t9iyEk1nAwq84OMTrBgrRWVpmK2?=
 =?us-ascii?Q?IyCDw52b18EFZVG7lm95hkcdWnPfZwBHVWeyujbshr/VsQ1cvCUDzOIIoqfM?=
 =?us-ascii?Q?vDH4nrQlw3MNPxz8Qtqzfzi/+ADStkyLEcmdIKTGkP9wdBpp0sL3HyHG6RRO?=
 =?us-ascii?Q?53aiSgSiX4ms2M4FuSXMIW//HrRZxeLxn7h1IIHYOLU+uyUJcoA1hnSLk9Ht?=
 =?us-ascii?Q?2gEK9B/UraLsOyvQUB481I//JkaWGXWdGpOz9WyB18feeRoccuFI8cPWETIO?=
 =?us-ascii?Q?rl4G8SNCFgG3yWQeDjmNnDEV7XIll9fCxHvCYP6kTjLgjZb/2dRD6Vu4RnI9?=
 =?us-ascii?Q?06ypTSSce2T3iUZCSxEgXvQC/Mgd4XvRccop2RhJdB4KVGh4PwbGSTKLlOzY?=
 =?us-ascii?Q?SsqK+/2Wk3eF02P2AKy2ZMMtUaiGMYjvEKDvyP63gMnhiumjrCJmiAvqPdPa?=
 =?us-ascii?Q?PrDrowT1vgRQ6zvS53CmwxPK2lqzbovOz3KcTMrKd1GdxvA9hFmu6OM8aHJW?=
 =?us-ascii?Q?LcFlaQdB7vG0zlnAO1eID55xv2g37ft3oWuNiQc71D1sWI+kwl9FXxFQorV9?=
 =?us-ascii?Q?LwzBVo4vFeoVjWSwsSGxT6uPPJdtj+RtCINAWoSA/UuRiIfJnCX3IZagvnux?=
 =?us-ascii?Q?t/RPddlO9citNquIuElZh3vZIN4YFyvNr5NdkmIfgUrC3q40mSfPy5lcXaeW?=
 =?us-ascii?Q?Iec861Gm8dn1sGtvpCNPBDuxEc4bqXNI/PINQFtfreaIJ7zZprctUz551GOk?=
 =?us-ascii?Q?LuVHHz+2LcZHM7BwD56VfEp9bkh6GEoFVWIJeevAYiWev7Qzj3riRJL8WHpH?=
 =?us-ascii?Q?vJ88yrvwYNGXKBZoZ/4B4vxfoVuKOMIUntdFge4ogLmwvQ9g+c07wud9nn++?=
 =?us-ascii?Q?v9/cqRrRa9F6ByYSI3KnmYwFKOohOc/8VIJxKdxKduXFblAgh3cOgn0cNYKk?=
 =?us-ascii?Q?/Ijq2ORkNOJA47+nthPkPDOEOGsOB8S9229bCIs1sArTmf5EpBZx2c+zX/Wa?=
 =?us-ascii?Q?JSfOsmrtQW4wr1A9s2Xv/hiiGn3EIzRbYtAw9G/xSqOGfWP/9tpVvgeKA+xh?=
 =?us-ascii?Q?XDHn3HQsLvrWskGhVNFMBj5R?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 043e488b-b368-4e34-4a4c-08d8e932650d
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1248.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2021 10:49:53.0369 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vEFmali1hzRCpg+4/hRDt2md09c1IW2AJk95Rf+VlBbI1wZapQg7fNwqVih49S7WpAkSR5RwcD/XXCDpJ+IL5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1790
Cc: Joerg Roedel <jroedel@suse.de>, "Du, Xiaojian" <Xiaojian.Du@amd.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 David Woodhouse <dwmw2@infradead.org>
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

On Wed, Mar 17, 2021 at 05:10:34PM +0800, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> Hi,
> 
> it turned out that booting a kernel with amd_iommu=off on a machine
> that has an AMD IOMMU causes an early kernel crash. There are two
> reasons for this, and fixing one of them is already sufficient, but
> both reasons deserve fixing, which is done in this patch-set.
> 
> Regards,
> 
> 	Joerg
> 
> Joerg Roedel (3):
>   iommu/amd: Move Stoney Ridge check to detect_ivrs()
>   iommu/amd: Don't call early_amd_iommu_init() when AMD IOMMU is
>     disabled
>   iommu/amd: Keep track of amd_iommu_irq_remap state

Series are Acked-by: Huang Rui <ray.huang@amd.com>

> 
>  drivers/iommu/amd/init.c | 36 ++++++++++++++++++++----------------
>  1 file changed, 20 insertions(+), 16 deletions(-)
> 
> -- 
> 2.30.2
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
