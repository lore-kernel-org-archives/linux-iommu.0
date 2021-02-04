Return-Path: <SRS0=5Yk+=HG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9FE9C433E0
	for <iommu@archiver.kernel.org>; Thu,  4 Feb 2021 12:14:44 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2231664F5C
	for <iommu@archiver.kernel.org>; Thu,  4 Feb 2021 12:14:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2231664F5C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id DB90286144;
	Thu,  4 Feb 2021 12:14:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QHFAHXgs1oHl; Thu,  4 Feb 2021 12:14:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 6BEFF8464B;
	Thu,  4 Feb 2021 12:14:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4E812C0174;
	Thu,  4 Feb 2021 12:14:43 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D3CDCC013A
 for <iommu@lists.linux-foundation.org>; Thu,  4 Feb 2021 12:14:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id B7E4385629
 for <iommu@lists.linux-foundation.org>; Thu,  4 Feb 2021 12:14:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id e82+b79XWN44 for <iommu@lists.linux-foundation.org>;
 Thu,  4 Feb 2021 12:14:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from hqnvemgate25.nvidia.com (hqnvemgate25.nvidia.com
 [216.228.121.64])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 1D11984BE9
 for <iommu@lists.linux-foundation.org>; Thu,  4 Feb 2021 12:14:41 +0000 (UTC)
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
 id <B601be5300000>; Thu, 04 Feb 2021 04:14:40 -0800
Received: from HKMAIL104.nvidia.com (10.18.16.13) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 4 Feb
 2021 12:14:39 +0000
Received: from HKMAIL102.nvidia.com (10.18.16.11) by HKMAIL104.nvidia.com
 (10.18.16.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 4 Feb
 2021 12:14:35 +0000
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.172)
 by HKMAIL102.nvidia.com (10.18.16.11) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 4 Feb 2021 12:14:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hcR8PDUzT5MtyOT6xrKl1BzVuald/qzeM1pHf99FVnZB+d/vEzKiOFiMTDeLxOo/O0766GKinVm8Nq8VPAsshEE0Ri1sylWXAJtS1dWkP77XaQbKiaFTpT2UA9uSJLI8Allm4A+YBMlSkAPD92dUCBIKyD7NgFrmhwZFdg2N0Qp/V/Lygl9/ChHxLykN9Q7epo411Z4yzkA6rGtM7h19Cnyh716aVORtp8wrS58G++FFgY1Gcd52jzmjYF0dmHs7ZfTMfeZTXY4tJeAPD2sExWz/B3dTrKI/vdDjQKqUubKnKfICYP7duRHap3YDo3IBMkOapEV72AxV5GA1KP79vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2VOJDGogQqjRgYUbfT1Iflm3uG4uRjcS1FsewGpHQcI=;
 b=JHAG6PBaeFX8hoeZMq71anAVPzS8kDsV/1VTVpYSv8ze1dh3DKZ31hDMUIkL+XijdaeHPJFC/AiYOPUExKLJ1Zf24+2ZLqLxMZh1g6Z2CXl72WtGlJCk3FrVSgWfUBQwkKUk3Tenham1UFfK8Bw/zpGGwJ8fxLs+SYcVZA4b7gUlOaZjhZ5oq0+hJBBr6Hf6bydygsvuTmULN1Qvh4+y58oog13Wy7e56o2rihA2WBHMPyjjyqWneBT56ZtjfQmrDUkksFiXYhx56arv9KcJfDuEhmfQewSQsUlN6vXXSEWCe8mMPsGQwprq7oav7WYE+GxyHvqGAI8Zb1uobGtQmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4617.namprd12.prod.outlook.com (2603:10b6:5:35::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.19; Thu, 4 Feb
 2021 12:14:33 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::d6b:736:fa28:5e4]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::d6b:736:fa28:5e4%7]) with mapi id 15.20.3805.033; Thu, 4 Feb 2021
 12:14:33 +0000
Date: Thu, 4 Feb 2021 08:14:31 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Megha Dey <megha.dey@intel.com>
Subject: Re: [PATCH 11/12] platform-msi: Add platform check for subdevice irq
 domain
Message-ID: <20210204121431.GH4247@nvidia.com>
References: <1612385805-3412-1-git-send-email-megha.dey@intel.com>
 <1612385805-3412-12-git-send-email-megha.dey@intel.com>
Content-Disposition: inline
In-Reply-To: <1612385805-3412-12-git-send-email-megha.dey@intel.com>
X-ClientProxiedBy: BLAPR03CA0012.namprd03.prod.outlook.com
 (2603:10b6:208:32b::17) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by
 BLAPR03CA0012.namprd03.prod.outlook.com (2603:10b6:208:32b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.21 via Frontend
 Transport; Thu, 4 Feb 2021 12:14:32 +0000
Received: from jgg by mlx with local (Exim 4.94)	(envelope-from
 <jgg@nvidia.com>)	id 1l7dWp-003L5X-9S; Thu, 04 Feb 2021 08:14:31 -0400
X-Header: ProcessedBy-CMR-outbound
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1612440880; bh=2VOJDGogQqjRgYUbfT1Iflm3uG4uRjcS1FsewGpHQcI=;
 h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
 From:To:CC:Subject:Message-ID:References:Content-Type:
 Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
 X-MS-Exchange-MessageSentRepresentingType:X-Header;
 b=aLngwBfsqqLwXA7j8VNyByLzXdXxLBBonQ/MDYEII5ORje9XKuuB0qK33JKyIRteW
 iwTL9Lz1QSvBDE/W3jQb3BTOwZenUZwS+hiB9UTWjyt+CjGO9JQ7nNw4wO8da9tzYY
 Y3smCB7fAgfEgHMPgkvzcECFjtLYmYJF6a+ouIO1ZkxaYzvt/XAoc0tcXwGlaDGPeg
 NF42DKicd7vojph972rT4KVmlF6B8GNF66Cbl9WhuB//KsOEj9G20oRaDWZ4PgAHjO
 fGRdhQ3Cl3XfN6XCWQHqVmXItDJroOL12a+2O9IOgTBSJaj0xKUFoXdKgb4ftt0LYI
 SjMnAzKfR7qBw==
Cc: alex.williamson@redhat.com, kevin.tian@intel.com, tony.luck@intel.com,
 dave.jiang@intel.com, ashok.raj@intel.com, kvm@vger.kernel.org,
 ravi.v.shankar@intel.com, maz@kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 linux-pci@vger.kernel.org, bhelgaas@google.com, tglx@linutronix.de,
 Leon Romanovsky <leon@kernel.org>, dan.j.williams@intel.com, dwmw@amazon.co.uk
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

On Wed, Feb 03, 2021 at 12:56:44PM -0800, Megha Dey wrote:
> +bool arch_support_pci_device_ims(struct pci_dev *pdev)
> +{

Consistent language please, we are not using IMS elsewhere, this
feature is called device_msi in Linux.

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
