Return-Path: <SRS0=8RI2=CG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,RCVD_ILLEGAL_IP,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A844C433E2
	for <iommu@archiver.kernel.org>; Fri, 28 Aug 2020 12:20:10 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD51420848
	for <iommu@archiver.kernel.org>; Fri, 28 Aug 2020 12:20:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="qyhIGy71"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD51420848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 7AD3222FB9;
	Fri, 28 Aug 2020 12:20:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id plBqLw629Z7i; Fri, 28 Aug 2020 12:20:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 3BD4C22843;
	Fri, 28 Aug 2020 12:20:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0E3CBC07FF;
	Fri, 28 Aug 2020 12:20:08 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 09E1CC0051
 for <iommu@lists.linux-foundation.org>; Fri, 28 Aug 2020 12:20:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id E9C1887A47
 for <iommu@lists.linux-foundation.org>; Fri, 28 Aug 2020 12:20:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7xgVgaRQFpRo for <iommu@lists.linux-foundation.org>;
 Fri, 28 Aug 2020 12:20:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from hqnvemgate26.nvidia.com (hqnvemgate26.nvidia.com
 [216.228.121.65])
 by whitealder.osuosl.org (Postfix) with ESMTPS id BA0B287F04
 for <iommu@lists.linux-foundation.org>; Fri, 28 Aug 2020 12:20:04 +0000 (UTC)
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5f48f6640003>; Fri, 28 Aug 2020 05:19:48 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Fri, 28 Aug 2020 05:20:02 -0700
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Fri, 28 Aug 2020 05:20:02 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 28 Aug
 2020 12:19:47 +0000
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.108)
 by HQMAIL101.nvidia.com (172.20.187.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Fri, 28 Aug 2020 12:19:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hebqKh7w1CN5QSqokmyTFT4aQRaSHymEVBca0fyE55So0jv8ZChGzK5BYrtoJREMXoVz971RIS9cCnG1++EnjNsAozYphCt/ShQKc6HzCd45HJk7Og6UtqxQdE+I3lT9z/xTM1rYnQWdV899K9GauIU4IKsUX5uqk85zIfQBCxSFG1lSnIZbHJqRWzSTxSW6bJGYW75/LABOzIMjEess8i2/1MHvixA5AwBW2W5fT3huuDCTEONL7RsFacQcWXF8t7dhJxo3mvxfIe35UUo9/3ZqdntpjhOFOWI4zWU7bU/4rDBfwB/cOJwV257nfFeuVXiXdPlO9A4h8yeXFGbiDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OGx9hDmAfgVaIDDyEUWtLiXLoSqpVp8tJKifKU9se5A=;
 b=ZyMsJ5oH4W9hQN+dgOt5m7Q5fSv4DRnKrszrAJlcYU9JasjYpTVO2V17tBZ2glAwoeAEBb+iZYcG+dB2PxmZ1XX3QtZgF0etYWdqUm4dt5/jojZ3/FnuX8lCbKmBARnWwZlheZPLqxm8SSgA8eYlCfhB7ExGT/nnMF9jilUtP7wqJO+Mtm4rih86hL2RdDJNzN927oH4SI9bQjT9lpUXYU7nBvYvHcXIkpXAvLrUuSePX0ab+FVunG1pDisDVt2quc7RZ7+1y0VBmfpijnR3lZMJn8aXf1Ci0c+LQEeRNNNAwi9lvFS85+3jWJUM5Ou+xEsarKBI4je/Hlwi9xa/4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR1201MB0107.namprd12.prod.outlook.com (2603:10b6:4:55::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.21; Fri, 28 Aug
 2020 12:19:46 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76%3]) with mapi id 15.20.3305.032; Fri, 28 Aug 2020
 12:19:46 +0000
Date: Fri, 28 Aug 2020 09:19:44 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [patch V2 34/46] PCI/MSI: Make arch_.*_msi_irq[s] fallbacks
 selectable
Message-ID: <20200828121944.GQ1152540@nvidia.com>
References: <20200826112333.992429909@linutronix.de>
 <20200827182040.GA2049623@bjorn-Precision-5520>
 <20200828112142.GA14208@e121166-lin.cambridge.arm.com>
Content-Disposition: inline
In-Reply-To: <20200828112142.GA14208@e121166-lin.cambridge.arm.com>
X-ClientProxiedBy: MN2PR19CA0019.namprd19.prod.outlook.com
 (2603:10b6:208:178::32) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by
 MN2PR19CA0019.namprd19.prod.outlook.com (2603:10b6:208:178::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19 via Frontend
 Transport; Fri, 28 Aug 2020 12:19:45 +0000
Received: from jgg by mlx with local (Exim 4.94)	(envelope-from
 <jgg@nvidia.com>)	id 1kBdM8-000Pby-UY; Fri, 28 Aug 2020 09:19:44 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3ccc59f9-bc44-4834-c3ba-08d84b4ca6bd
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0107:
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0107D6979C733BF03E0CB55BC2520@DM5PR1201MB0107.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aN6pwZshjPwciVfTjB2lY0nOoqBHHK+Fkoq6VYBg41C3r7rZMNEfINXBWEtztjvpeEwUR9vKveyMkcQVlV3zcyx6wnUsbecWzSTuq+CCHO6H3xQ2jOu6Mp6J9RaPkMOl6xrjvFKfSsiXypDbNGGae7sesz6MUXjdjTmyxEIy6SatLqrPuZl6BEgRpTpBAsqjuxFESQFnH3NurLub1OUI9qxMqP/LF0swzQ3bBmdJHP1Vmqw9ErGlLmCASU9rWaCkAf+riJg99NJw9sZwRLz3MYZ2NLp3VoWU1xQbkcXu4bd65Px3dpTD782eQbZ5ScxULU+WRPZaqMcQFpLivsoFeg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3834.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(39860400002)(376002)(366004)(346002)(9746002)(9786002)(26005)(83380400001)(6916009)(7416002)(2616005)(4326008)(36756003)(426003)(7406005)(316002)(8676002)(5660300002)(66476007)(86362001)(66556008)(54906003)(66946007)(478600001)(1076003)(186003)(8936002)(2906002)(33656002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: x6uW2p7VxZ0CYMgQym09Ex6nYRo09xOLRdp8JzvKppb1kjiNihesAY/ffRidZ+RdP7irgbOcCxdrAmQ6ukEqMwnzu9qTSD8Mx3BYEW/n1dfViSvrEfGwe5DgeFDW0AV73JYHnMRNkXJO/HttPI6iIxJYlmVzkj79KY3kYs6K4Vcn+bNVRsHgf6/neJcvmasm05Tv+H3WS2oqkxro14FkefKS31UIcEb+RpZFpM19U+mRtUpTkaAcaASF4aq+H6xw3kHQGmZlP/CUicEmavXWkFLAT401WdeOf9xCTE298ZHwNOeCDb/eRVtPxjOL0VhUpujKovL3qeNK8kJTZH+HNEo5nth3Wd/Fxyl75NlBBjqIzEuTr6Hb8jkTIvQar6XKX0vP8JyqZC0XrnNjQeu2aCaaYuRXwOXO8e+vcaomSFef08Q6AYgzKXeLSUt6d0ebfv8K1HD4xMVJv9UykMWPLGgMDpWsAy4wdhWosK15CbEgpHwWMg9+oPGZHZ8xIWL+7F1wJHT3m3//2ST84YHCrBrz1iR8DwepaBKqONoe/kGqL6JPBXnLTKoVUPAFtDi/fCYU8zyQBhjeSAacsn31NEWlrjqiHRZtKXqtKSOQobPbmbh6rquKS/WoLPZLb6T7IvADBrxkZ2e2gYEhdwbQsQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ccc59f9-bc44-4834-c3ba-08d84b4ca6bd
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2020 12:19:46.1736 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dMvp4GN7Ni7cTdNvWTVbAeri+3RaAm3vF9SqeJdGKEZ5kT7KS7BQIU6dbMsZgTLW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0107
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1598617188; bh=OGx9hDmAfgVaIDDyEUWtLiXLoSqpVp8tJKifKU9se5A=;
 h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
 ARC-Authentication-Results:Authentication-Results:Date:From:To:CC:
 Subject:Message-ID:References:Content-Type:Content-Disposition:
 In-Reply-To:X-ClientProxiedBy:MIME-Version:
 X-MS-Exchange-MessageSentRepresentingType:X-Originating-IP:
 X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id:
 X-MS-TrafficTypeDiagnostic:X-LD-Processed:
 X-Microsoft-Antispam-PRVS:X-MS-Oob-TLC-OOBClassifiers:
 X-MS-Exchange-SenderADCheck:X-Microsoft-Antispam:
 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-AuthSource:
 X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
 X-MS-Exchange-CrossTenant-UserPrincipalName:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
 b=qyhIGy71y21wkC3/iRecn3IDzIZav9598HZVKsWFOIz1S15zSO9UTDTw31d+APrew
 0jzkk4O01rjksIcZxjdbqLgCfnB865SvguEiuKsl9kHEb5hqhiZQAJGbcmRvmZARsw
 meT2y3DT32ggt233FZjQRMp8NdUlxBSavSWj5+g4mAr6JLJ8915ElGrug1Mojkk15S
 9EpU34HR3VYbL/G6ilWDlAkZl9yi23EdPYbMiGABeIq7M86f0V0erDDshi5EIPVPaU
 yYYQT7P2hSlyJG58exBW+R0/VQr0HXUrBv2U61rZfwUp52mySLM6UhYaRxLCpB8Qoh
 g4deVIIW+ktZw==
Cc: Dimitri Sivanich <sivanich@hpe.com>, linux-hyperv@vger.kernel.org,
 Steve Wahl <steve.wahl@hpe.com>, linux-pci@vger.kernel.org,
 "K. Y. Srinivasan" <kys@microsoft.com>, Thomas Gleixner <tglx@linutronix.de>,
 Rob Herring <robh@kernel.org>, Wei Liu <wei.liu@kernel.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Stephen Hemminger <sthemmin@microsoft.com>, Baolu Lu <baolu.lu@intel.com>,
 Marc Zyngier <maz@kernel.org>, x86@kernel.org,
 Bjorn Helgaas <helgaas@kernel.org>, Megha
 Dey <megha.dey@intel.com>, xen-devel@lists.xenproject.org,
 Kevin Tian <kevin.tian@intel.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Haiyang Zhang <haiyangz@microsoft.com>,
 Dan Williams <dan.j.williams@intel.com>, Alex
 Williamson <alex.williamson@redhat.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Dave Jiang <dave.jiang@intel.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>, Jon
 Derrick <jonathan.derrick@intel.com>, Juergen Gross <jgross@suse.com>,
 Russ Anderson <rja@hpe.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org,
 Jacob Pan <jacob.jun.pan@intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>
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

On Fri, Aug 28, 2020 at 12:21:42PM +0100, Lorenzo Pieralisi wrote:
> On Thu, Aug 27, 2020 at 01:20:40PM -0500, Bjorn Helgaas wrote:
> 
> [...]
> 
> > And I can't figure out what's special about tegra, rcar, and xilinx
> > that makes them need it as well.  Is there something I could grep for
> > to identify them?  Is there a way to convert them so they don't need
> > it?
> 
> I think DT binding and related firmware support are needed to setup the
> MSI IRQ domains correctly, there is nothing special about tegra, rcar
> and xilinx AFAIK (well, all native host controllers MSI handling is
> *special* just to be polite but let's gloss over this for the time
> being).
> 
> struct msi_controller, to answer the first question.
> 
> I have doubts about pci_mvebu too, they do allocate an msi_controller
> but without methods so it looks pretty much useless.

Oh, I did once know things about mvebu.. 

I suspect the msi controller pointer assignment is dead code at this
point. The only implementation of MSI with that PCI root port is
drivers/irqchip/irq-armada-370-xp.c which looks like it uses
irq_domain.

Actually looks like things are very close to eliminating
msi_controller.

This is dead code, can't find a setter for hw_pci->msi_ctrl:

arch/arm/include/asm/mach/pci.h:        struct msi_controller *msi_ctrl;
arch/arm/kernel/bios32.c:                               bridge->msi = hw->msi_ctrl;

This is probably just copying NULL from one place to another:

drivers/pci/controller/pci-mvebu.c:     struct msi_controller *msi;

These need conversion to irq_domain (right?):

drivers/pci/controller/pci-hyperv.c:    struct msi_controller msi_chip;
drivers/pci/controller/pci-tegra.c:     struct msi_controller chip;
drivers/pci/controller/pcie-rcar-host.c:        struct msi_controller chip;
drivers/pci/controller/pcie-xilinx.c:static struct msi_controller xilinx_pcie_msi_chip = {

Then the stuff in drivers/pci/msi.c can go away.

So the arch_setup_msi_irq/etc is not really an arch hook, but some
infrastructure to support those 4 PCI root port drivers.

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
