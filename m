Return-Path: <SRS0=vqUx=OG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8876AC433FE
	for <iommu@archiver.kernel.org>; Thu, 16 Sep 2021 18:29:58 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20A44611CA
	for <iommu@archiver.kernel.org>; Thu, 16 Sep 2021 18:29:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 20A44611CA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E22D5605FD;
	Thu, 16 Sep 2021 18:29:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0AsMktAhUUIQ; Thu, 16 Sep 2021 18:29:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id A8EBC60611;
	Thu, 16 Sep 2021 18:29:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 89D1FC000F;
	Thu, 16 Sep 2021 18:29:56 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4E0CEC000D
 for <iommu@lists.linux-foundation.org>; Thu, 16 Sep 2021 18:29:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2950160611
 for <iommu@lists.linux-foundation.org>; Thu, 16 Sep 2021 18:29:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id J0mKszOjAhIa for <iommu@lists.linux-foundation.org>;
 Thu, 16 Sep 2021 18:29:52 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2062b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::62b])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D9A0C605FD
 for <iommu@lists.linux-foundation.org>; Thu, 16 Sep 2021 18:29:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VUbaVO5RfyX88f/7sEFF7CnxU/YAOGqQuAwdRUUG9nzieEjThOWOeb1XZ/EsLkyO5JWFOstpXfUxnZ3S/Gty+ilPr7cfvHVABtT69VWaE2GPyWn3bCAbqcL9QZvttjRYLaISLKc5L66m1WnO1P+5VTpv1uULf0etfHTmKHabYKpAXX0dbH9RT8gURoR4aW4/V2BpzyJaL+rjns35JyBNVrIKBVaU1JxckzZmXiisw2eg3rzy+PMjDqab8y/JF3KBZjGiktRyLn1pFVkJUXQ5U8tjBb0JCoVGQ/yAmKeSJns74VRpPkgLiofi4sNQHatkPRFa85FJ3G2xA8lbKr92+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=QDyDV7jWAEb4taF1dRSbXiMJAeWJGyX96WXp+4fYUdc=;
 b=BN4Irf/753DLCFe8NRu7hCcCR7pKdtT3uQKXS9jQKBvG4/QSaVOD9SXOJmIukjjr58kZNaZvD11Ti2XtzwlR5azRbvQA7hDw5EYMnqMB3jbEh8NvZ17rGPIzBp4og/mR/zfZAs3PpcOEeD5kFDnjiW435xAfUWrja8S8kVsCXayMEiSAOWdptHxIhrQUS7zRg+Je/eXpoCFQcutildRSQBOUTf5Cj48uMAUosZRxc3B/luj89QqwwV+rxCff0dJVT2vIblhqolVcR6vNg5dUXCIaN7ggvjR5LFFi14hHsG9ncZ25ulVo/Vo7HmXIO5pmM1b7copjOkoA8O2YN4/QDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=quarantine sp=none pct=100)
 action=none header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QDyDV7jWAEb4taF1dRSbXiMJAeWJGyX96WXp+4fYUdc=;
 b=igNTpOm0dwhWght1NOBD8s/XCvUVKIM19oVUeHzxgwx1HA+9Hi31lOLGRFXosNInjSTmc2EXyKjUofN3JYlezvUyIKfBByVibKe1K2Rb2hgIC8fCEZ+HV7M7Mc2mPRNCm8fU0cFgc8mlnp/i1nqUz2iWAYvCCA3V3JApuK8b1c5T4tmOmTrJYXMYGYUWkT8wtOCStUMPBziSCtwA1QTwcvRrmHVuprkprbzNlKXtmfHMw/ioYymDuCjJfJCEvNqkHnUR3NJoCjVKAqK9GSjdF/y3ZwVFBcqrn3FLR2lTVA15q0nVbdAVMPoXTS/F1OQjvrmwZfkk48OA6H/NqN15xA==
Received: from BN6PR1701CA0022.namprd17.prod.outlook.com
 (2603:10b6:405:15::32) by BYAPR12MB4694.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Thu, 16 Sep
 2021 18:29:45 +0000
Received: from BN8NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:15:cafe::dc) by BN6PR1701CA0022.outlook.office365.com
 (2603:10b6:405:15::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend
 Transport; Thu, 16 Sep 2021 18:29:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=pass action=none
 header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT003.mail.protection.outlook.com (10.13.177.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4523.14 via Frontend Transport; Thu, 16 Sep 2021 18:29:44 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 16 Sep
 2021 18:29:42 +0000
Received: from Asurada-Nvidia (172.20.187.6) by mail.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1497.18 via Frontend
 Transport; Thu, 16 Sep 2021 18:29:42 +0000
Date: Thu, 16 Sep 2021 11:21:56 -0700
To: "Tian, Kevin" <kevin.tian@intel.com>
Subject: Re: [RFC][PATCH v2 00/13] iommu/arm-smmu-v3: Add NVIDIA implementation
Message-ID: <20210916182155.GA29656@Asurada-Nvidia>
References: <20210831025923.15812-1-nicolinc@nvidia.com>
 <20210831101549.237151fa.alex.williamson@redhat.com>
 <BN9PR11MB5433E064405A1AFEC50C1C9F8CCD9@BN9PR11MB5433.namprd11.prod.outlook.com>
 <20210902144524.GU1721383@nvidia.com>
 <BN9PR11MB54337332A83176241C984EC58CCE9@BN9PR11MB5433.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <BN9PR11MB54337332A83176241C984EC58CCE9@BN9PR11MB5433.namprd11.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 58d49d23-25c3-43d5-21e5-08d9793ff4d7
X-MS-TrafficTypeDiagnostic: BYAPR12MB4694:
X-Microsoft-Antispam-PRVS: <BYAPR12MB4694071662EC2C4EF2EBAFBAABDC9@BYAPR12MB4694.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /W+GJbluUwgxjml3MEQoeki7zPIuneZBYfJBnhLbWam3O5gRZJN+OBq4BqB2bUtHV7XWptOz6CqFycFvX5ht+5V5yF33mmcF+YWrdfzN3sab34pwUo1NLgr7vaueG09zTR33Ej67NoUkDttM05ZlOo5kKl/CcUGPyIIWCFD38rbNUAJKs91BgzpfZNpQBCDbgVBMwW7bZHwtpgF6l/eW4zau34ueDRi4CBfJYrGA9nSDAupfhv/pD07GfnAnv6Zc7NKsIEfE0GfT+YWjZIEsUI73XvqUB+yG8rPXfJm12YAHceDJW0CYXeBxyo4FZ9VK8CI6MIK/w7T9VtpbdJ80lOK65fJdxH8sHh27H8TE3GjFAPh98JxrQ8gc07kCtF1UyxuwBie+2w1zVS1fwCoInnQAlfhfot4ap0dOvRF9Zs971HvrXep3rKP8Hv2vfYI5c3uhlAEOqcQBRpNgD4RAIDs+7Dd7OELjdSYUaiVa671fh0ZXCujI29ZC1orr/LeIphlyizwpm6DKwJ8eGRzteEW4YfCexRDhecyZlyZ6jSBYIybcQCv0K19EypKTa4CCHHRxtNXueWc30Li9AyPrBSpRVYbqA0GqeqVApMJu4ejsS2409rEhVljj17WnNilrKuEoOfu1jd54yEPTgGdqssEWqoNFuVEcBuK37n0uehMpC4GwVP/At/KWykilNZayD2D5YXM2qyegYfQi12S4Rg==
X-Forefront-Antispam-Report: CIP:216.228.112.34; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid03.nvidia.com; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(8936002)(508600001)(54906003)(6666004)(7416002)(33716001)(316002)(356005)(5660300002)(336012)(8676002)(26005)(186003)(83380400001)(4326008)(82310400003)(36860700001)(86362001)(47076005)(55016002)(33656002)(426003)(9686003)(1076003)(7636003)(70206006)(70586007)(2906002)(6916009);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2021 18:29:44.5536 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 58d49d23-25c3-43d5-21e5-08d9793ff4d7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.34];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB4694
Cc: "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
 "cohuck@redhat.com" <cohuck@redhat.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>,
 "corbet@lwn.net" <corbet@lwn.net>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
 Jason Gunthorpe <jgg@nvidia.com>,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
 "will@kernel.org" <will@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
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

Hi Kevin,

On Thu, Sep 02, 2021 at 10:27:06PM +0000, Tian, Kevin wrote:

> > Indeed, this looks like a flavour of the accelerated invalidation
> > stuff we've talked about already.
> >
> > I would see it probably exposed as some HW specific IOCTL on the iommu
> > fd to get access to the accelerated invalidation for IOASID's in the
> > FD.
> >
> > Indeed, this seems like a further example of why /dev/iommu is looking
> > like a good idea as this RFC is very complicated to do something
> > fairly simple.
> >
> > Where are thing on the /dev/iommu work these days?
> 
> We are actively working on the basic skeleton. Our original plan is to send
> out the 1st draft before LPC, with support of vfio type1 semantics and
> and pci dev only (single-device group). But later we realized that adding
> multi-devices group support is also necessary even in the 1st draft to avoid
> some dirty hacks and build the complete picture. This will add some time
> though. If things go well, we'll still try hit the original plan. If not, it will be
> soon after LPC.

As I also want to take a look at your work for this implementation,
would you please CC me when you send out your patches? Thank you!
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
