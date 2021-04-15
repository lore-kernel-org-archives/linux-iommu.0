Return-Path: <SRS0=SOau=JM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FC1CC433ED
	for <iommu@archiver.kernel.org>; Thu, 15 Apr 2021 11:59:49 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B97AE613A9
	for <iommu@archiver.kernel.org>; Thu, 15 Apr 2021 11:59:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B97AE613A9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6287E6071D;
	Thu, 15 Apr 2021 11:59:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BKKf5_N2uHix; Thu, 15 Apr 2021 11:59:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3C88760657;
	Thu, 15 Apr 2021 11:59:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1235EC000B;
	Thu, 15 Apr 2021 11:59:47 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 124AEC000A
 for <iommu@lists.linux-foundation.org>; Thu, 15 Apr 2021 11:59:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E778E401F8
 for <iommu@lists.linux-foundation.org>; Thu, 15 Apr 2021 11:59:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rad3a1OX3wFb for <iommu@lists.linux-foundation.org>;
 Thu, 15 Apr 2021 11:59:44 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2052.outbound.protection.outlook.com [40.107.95.52])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D2EE840129
 for <iommu@lists.linux-foundation.org>; Thu, 15 Apr 2021 11:59:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c7RwiH24oKBGZ2EdJ/pf7l/zDQSSFDtJIGQXnykFa9XTiFSSEL31HMcUMwdrKBIOgFFNyyJO6dUD4lhNlwJMtvkRp1ELpIfb0WApVJUfumjO6Z4z9P2G7MJ9dgjQL9fgb3n5o5SKCkVdUWxAG7qYfpaf53m6rHTZZE6uU5qFloaEc/gN1uD2c9k+f9YMCcpvByp1Jt79Fp59bqBi8YgH/+GABP9X6Z2TH2vFtFhqxpFaw1V69Ggh9YSEo0fxWIPDRhFz+Ge/rH54r5LPtqw4/3Dlqf9FNCKo5QO3Jmc/dGQdZ30g3L+kjMGJnACIDySFNZLQPj2aAT0b/Movs27HXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WjagX6Ea/EXVbM8VEs83/WsyErFkpl6VCNatYg3SkVc=;
 b=HJfEH0GNFwjFWrDyBzOZIT3uyqCt9onvPdr27qx/YTO2RgoeDjz7H/fwIP/skhm918zBW0yUQZ1M0RIHrlWX77HaH1QdRGQHIKsrNAxq3K5XIL+44cWTwJ6qoZq4pGU+RUWR1iAFBsni9Lno4SjJIHprtz+2bPaZx5viufQRL8+A54dbVKHXtUdn4yY8vI7g5AyGY048RVBxtiHS7lwi2O0Bd0V+LKvMvtPZYFf3BZ7R89QJjFyG4KMdF9apZJFO2fJqH7pl897S1EFp/LSP4tacblxUkA4pg7B7n1Q7ApCroj4Ocl/Lq/vOlskpNQObCk9BjmFw5ngW4w9xdi3GOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WjagX6Ea/EXVbM8VEs83/WsyErFkpl6VCNatYg3SkVc=;
 b=tqJDyUNBhAvPDssGyOx//vwKNTFGFM1xGwq3QAOGtsPs6SaW0pkpNx2/nrilUiTwDxfoT3p7dYkqd/UaQvgtCxkE6ab3UaV+GNcMz6FUaYCZGLDOLQ2ETbrI/rSSv12EQIcl1hO3vLr+NCELOKrn/l3qOpoJRzfBQnEoKclEnj/v6CoUp4s0SCFkl4cX83JCHyXK5VV3dcmjV89hVdQyIzxYAOdjJaYm1GIAnx06E7aAMTJ3N+ii7+mq9bw8xV7Arw0Z9fLskvnjvkd3yOzBjA3QhWQ684EckQ6YYBqPqDVMPCxp8PLDb6nVXD/uQIrazY/LF+wlEqr6OmnLNVfeDA==
Authentication-Results: linux.intel.com; dkim=none (message not signed)
 header.d=none; linux.intel.com; dmarc=none action=none header.from=nvidia.com; 
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1337.namprd12.prod.outlook.com (2603:10b6:3:6e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16; Thu, 15 Apr
 2021 11:59:43 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.4020.024; Thu, 15 Apr 2021
 11:59:43 +0000
Date: Thu, 15 Apr 2021 08:59:41 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH 2/2] iommu/sva: Remove mm parameter from SVA bind API
Message-ID: <20210415115941.GE1370958@nvidia.com>
References: <1617901736-24788-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1617901736-24788-2-git-send-email-jacob.jun.pan@linux.intel.com>
 <YHAoY9+w2ebYZ7VV@myrica> <20210409110305.6b0471d9@jacob-builder>
 <20210413170947.35ba9267@jacob-builder>
 <41433d99-e413-f5bf-5279-695dae6c58ba@linux.intel.com>
 <20210414112602.GA1370958@nvidia.com>
 <eb700675-f698-62e5-bbab-3d199ff58dcb@linux.intel.com>
Content-Disposition: inline
In-Reply-To: <eb700675-f698-62e5-bbab-3d199ff58dcb@linux.intel.com>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: MN2PR01CA0050.prod.exchangelabs.com (2603:10b6:208:23f::19)
 To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by
 MN2PR01CA0050.prod.exchangelabs.com (2603:10b6:208:23f::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4042.16 via Frontend Transport; Thu, 15 Apr 2021 11:59:43 +0000
Received: from jgg by mlx with local (Exim 4.94)	(envelope-from
 <jgg@nvidia.com>)	id 1lX0er-006WSX-HO; Thu, 15 Apr 2021 08:59:41 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8f69ebf2-1d48-41f3-2ce4-08d90005f4be
X-MS-TrafficTypeDiagnostic: DM5PR12MB1337:
X-Microsoft-Antispam-PRVS: <DM5PR12MB13371B2A068DE47FF313F81FC24D9@DM5PR12MB1337.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +yhcMn5iZCm8DIPrEdb8UswMc0CvhGeN9iHa8uKVt8qAntoUuypxYeKb/2cwzJQ6P+7ghM3PIq1+k8coOS65vdGBXunhxdVf5HoyYZ8XV6p0zFvzFslXVSFchLB+lqnlRclTcQw4yuBkzsLhawZf1h1oVqaIbiLz3bxOdb8BMBS4RdRNmEwO0+Y17XFHhhy8FMxFqJxgbvJkQZ17v2TfPac1J9HrbI5AcSti9IRPOCbu6AF+6oWKZGGGuMW2upY8ttF7g2i3Gf/KSV1jxiNzN3FI7elDS8HXW2fGA80/m9dUjQej+I/KYBspjZd1kC8UcgLc5MrtRHUDaaGziuvaZktk2XbjBHhY4bqFUCHMHRHcYKgKFXwl8vZbXdk7+lf/cKj67VZGxNpsUuL/zNRa8SEMCzkIKYi0lgAQLyKFaRKelTIlByChRNQSJYFRd0NteTXGLfqTCdq9U14hHkMAp+HuXRf4zGj0Xjqtqsz+hnJVDNe4tpns34eoFLSuzAF8DxnetFU+kPcAWyUaJmvjva6QEswRQgGCLKJVs+xp6Pt0OFnmUdo4UZzp10lor8hdPOtrQ/luiw8g7VReBRDv4bCUA6BAwDgl/BEOh1D7ObI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3834.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(396003)(136003)(346002)(376002)(53546011)(5660300002)(8936002)(26005)(7416002)(66556008)(66476007)(2616005)(8676002)(66946007)(9746002)(33656002)(9786002)(426003)(316002)(2906002)(36756003)(186003)(478600001)(6916009)(1076003)(4326008)(4744005)(38100700002)(86362001)(54906003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?LPNd183AMLvNbOYunMVN0OEvoHNthjhz5WnfzQFpUX+s270yVuJaJsPaA2Xd?=
 =?us-ascii?Q?uaLHUv7FR11EZgARZHC7z4JCrDOA9GeeWlRjZ9XnFLvWiuGCUNuanUSBMGtJ?=
 =?us-ascii?Q?oesmy+v6meR+dp2/FPSySKGr5y3wy9p2LDrVAeGcM4VEmsBUrBKLKIrV/en+?=
 =?us-ascii?Q?cGJbs4CGg/mXsUwn5c/LnqrmlsuA3oVoyM8GwvJMcMjrzlkf39OxNG6sJT+u?=
 =?us-ascii?Q?RYq0f8wI0hWPKths79+bzV4F4i5rvAHaMuH5aFt7IDW+bskjkAsmxBujQb69?=
 =?us-ascii?Q?CgPkf8T/QyfAQspj6gz0z1JxmTZo5v7Oev933w7VAqiw4qOfbnXJkd5zO0f+?=
 =?us-ascii?Q?s5OdWnhzqzgsg6+mBjYXRhuCqPxOqURyGeih433G+JyN3G52UzFPtrIZF3EL?=
 =?us-ascii?Q?I6M45fx8E0rFkfy+0rrqYepQ3PNWlmgFes79vQ+1VneZy2mmGcbIcdLYRi78?=
 =?us-ascii?Q?Z67G5+lHSmuRdBgrXGNfP5l0Hoq4g/Xrnp5xAdoPDxYJi1w9wcocmD+BSKjl?=
 =?us-ascii?Q?r4x7LPmla9pG+LDvkgWP/3OFreQKWZMfhlraBs1pl/0hT36umNp0j3/8LvZD?=
 =?us-ascii?Q?q0EJXRwKgaeBubHO932WEUNt8fC8EfKN0426vc9L6Yc6b0X4gFOG7WAOh4mL?=
 =?us-ascii?Q?NESMTjxNAbjqNl1nDQj9msAKeVY8eJqQN2Qnf8ugF7yNAbBjspOK6z4aDggX?=
 =?us-ascii?Q?MLl7S1RVJUwP4Lnt8SsgHrmQk8UPaFxxyi6T6lAo0ftAxPJ9/kO6T4udvLuc?=
 =?us-ascii?Q?G8jzk3xz4+hTloKqFWlsBqotsjVxr9oAO9ZP9gzdCJLFZiRwIUBENabIUxES?=
 =?us-ascii?Q?wB3zaXR92XBFL/ERdK2oif3MUazznSy/hZgDV/AnS6By0NP6cBA08J0S2H9W?=
 =?us-ascii?Q?97w/B0szbjjtSuepw7UsH8umPqdugh9JvNYCfZy1Fql7nu8TVrY8lxTQ/N0m?=
 =?us-ascii?Q?vAMlfdyvAG9cpTmEQSyzPEhxcZPI/yali4DLh/A8obe6nf61przbhAnlxF0a?=
 =?us-ascii?Q?cBEpTM4d8vGqrgZR9hVe60AJNQ7fcA/UtdgUNqZbEV5Qp1TsVI5ns7SkWFsb?=
 =?us-ascii?Q?vomyt1w0iAzXWLU3hQOMvWc+5y6orqlK1gECefr1149yBGFf+3wt46bx9zus?=
 =?us-ascii?Q?ycLfnIR1PST+lbageqP1ANQUoop3QnxWnZx2vkOEmFxJpmWW/cIlro01H+UA?=
 =?us-ascii?Q?olPEKhP/bkV2fT51MldYQsZa3lEEReHZ9/M8o9Xa54CqJJXvbHzZDYeeAgm8?=
 =?us-ascii?Q?KXKZCb7Mu7ZSFeK5o9HktBMLwuksDANWkQC9QmrtgnxmmrLHRyXiKn8XPApZ?=
 =?us-ascii?Q?6mpjd6QUHSXIBQfUFW825hmn?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f69ebf2-1d48-41f3-2ce4-08d90005f4be
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2021 11:59:43.3044 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EsVqENgkG+/G/z0rPpukF7K31ZSygvIzZpA6vN+uDmTYJ9KO9lfR+iW4wRlNmlHU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1337
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Raj Ashok <ashok.raj@intel.com>, vkoul@kernel.org,
 LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org,
 zhangfei.gao@linaro.org, Jean-Philippe Brucker <jean-philippe@linaro.com>
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

On Thu, Apr 15, 2021 at 01:33:24PM +0800, Lu Baolu wrote:
> Hi Jason,
> 
> On 4/14/21 7:26 PM, Jason Gunthorpe wrote:
> > On Wed, Apr 14, 2021 at 02:22:09PM +0800, Lu Baolu wrote:
> > 
> > > I still worry about supervisor pasid allocation.
> > > 
> > > If we use iommu_sva_alloc_pasid() to allocate a supervisor pasid, which
> > > mm should the pasid be set? I've ever thought about passing &init_mm to
> > > iommu_sva_alloc_pasid(). But if you add "mm != current->mm", this seems
> > > not to work. Or do you prefer a separated interface for supervisor pasid
> > > allocation/free?
> > 
> > Without a mm_struct it is not SVA, so don't use SVA APIs for whatever
> > a 'supervisor pasid' is
> 
> The supervisor PASID has its mm_struct. The only difference is that the
> device will set priv=1 in its DMA transactions with the PASID.

Soemthing like init_mm should not be used with 'SVA'

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
