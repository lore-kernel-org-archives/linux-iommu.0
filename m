Return-Path: <SRS0=dfl9=EW=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B0FEC5519F
	for <iommu@archiver.kernel.org>; Mon, 16 Nov 2020 23:22:33 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2D14241A3
	for <iommu@archiver.kernel.org>; Mon, 16 Nov 2020 23:22:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="jllMDa00"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2D14241A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 70048871A6;
	Mon, 16 Nov 2020 23:22:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Q9FGdQ7Yyfhm; Mon, 16 Nov 2020 23:22:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id CCE808716A;
	Mon, 16 Nov 2020 23:22:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B178CC0891;
	Mon, 16 Nov 2020 23:22:31 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AB8EDC07FF
 for <iommu@lists.linux-foundation.org>; Mon, 16 Nov 2020 23:22:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 9118086769
 for <iommu@lists.linux-foundation.org>; Mon, 16 Nov 2020 23:22:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VfUaod-Liaei for <iommu@lists.linux-foundation.org>;
 Mon, 16 Nov 2020 23:22:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from hqnvemgate24.nvidia.com (hqnvemgate24.nvidia.com
 [216.228.121.143])
 by whitealder.osuosl.org (Postfix) with ESMTPS id F282786762
 for <iommu@lists.linux-foundation.org>; Mon, 16 Nov 2020 23:22:28 +0000 (UTC)
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
 id <B5fb309be0000>; Mon, 16 Nov 2020 15:22:38 -0800
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 16 Nov
 2020 23:22:28 +0000
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.176)
 by HQMAIL109.nvidia.com (172.20.187.15) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Mon, 16 Nov 2020 23:22:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XqMYJ3fND+xM6LmnJxncZTLAlrRw9rzJcf5ESjpromsEzuW9YrpErmxWwU8kWcUlBkMw4fB8YirPGTH9znM6TzNmfZtFNzA6+c7CLcv8Ucco6aIAdF9SoxrHknF+gZ8JFiWVSwnKZDizvdKaJ0A6TXDBumGaHPg+sSsiPhyEBGQTj2KFLcyC/6T+Hn6tQf/3Z/s6PiYBN4ZdtFTEL1SWHnq2cWz3YW+wemeqK8Sc7dU80+z0IJ6QeYoWSR9fYGc56cbX6+r//eXG4vVpG1f+5uH48cQSo6NKjCjfLevEt/wHhHeh8XRFkPKZZig0qY8W4vlZzTwkOal5l25i0W8xGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=509+VmkLlEPOxe/lQoQ9OAnAIf0urLi7ZvhTpP11KWo=;
 b=iktqZ6+edGq54JTXYpvhvxwZ75TDHFiTlLlXoCunEbF1hnXeUj8e9UTU64NY6u8n5VaeG11Fp/tclotuA7D14puuC+XqWDlIK68/59gvpnrBXFxRGlItOdA+1VTn2BzfxP5DxbK5QqFjDSsnssiK3nfXNr7QMg4fvGCTmCIcS98Dsmps70GbJf8e4EZ3ouuia5egb7KTKzAUwOk52takcIappFJXjTpao/A8wxOZ8/1QAUmnjI0GpFLAKAYyD0SKnKrU/l2mxS+k3NvVIB2DYE28cTDDj2s0WYZg19kGs8ftYc6l1HTl3TzAZIX8tLWov1g9jMnQ0rMWT/ZuFaVJYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4619.namprd12.prod.outlook.com (2603:10b6:5:7c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.28; Mon, 16 Nov
 2020 23:22:23 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::e40c:730c:156c:2ef9]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::e40c:730c:156c:2ef9%7]) with mapi id 15.20.3564.028; Mon, 16 Nov 2020
 23:22:23 +0000
Date: Mon, 16 Nov 2020 19:22:21 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: iommu/vt-d: Cure VF irqdomain hickup
Message-ID: <20201116232221.GS917484@nvidia.com>
References: <20200826111628.794979401@linutronix.de>
 <20201112125531.GA873287@nvidia.com> <87mtzmmzk6.fsf@nanos.tec.linutronix.de>
 <87k0uqmwn4.fsf@nanos.tec.linutronix.de>
 <87d00imlop.fsf@nanos.tec.linutronix.de>
Content-Disposition: inline
In-Reply-To: <87d00imlop.fsf@nanos.tec.linutronix.de>
X-ClientProxiedBy: BL0PR0102CA0068.prod.exchangelabs.com
 (2603:10b6:208:25::45) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by
 BL0PR0102CA0068.prod.exchangelabs.com (2603:10b6:208:25::45) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3564.28 via Frontend Transport; Mon, 16 Nov 2020 23:22:23 +0000
Received: from jgg by mlx with local (Exim 4.94)	(envelope-from
 <jgg@nvidia.com>)	id 1kenpF-006rGb-Sg; Mon, 16 Nov 2020 19:22:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1605568958; bh=509+VmkLlEPOxe/lQoQ9OAnAIf0urLi7ZvhTpP11KWo=;
 h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
 From:To:CC:Subject:Message-ID:References:Content-Type:
 Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
 X-MS-Exchange-MessageSentRepresentingType;
 b=jllMDa00p/VQ6l3K63jHe96kycEVYbHGAN3FIs4kqwAHWQ2KK4OJl2a96Otea+zIX
 MGxCNp3a0sGWNh8Y2KRH+Za1PW7uhWV7oZiE3iqwvdaQve1ZzItDjv4UCRfUa37Ps8
 AKmMOrzuKITRp4g+Or64aT+lxillBOkoDud5wwts8fARCN8+1S2J8lUMo0UwUTzJN3
 9wgnHClx7YaU2M+c4kHe4gi7dhtcq5tk1R5ghbmbr8bBV0/+D5MBaiN116vbKAPLCr
 l306GhyMI3EW6VCnKvOsss4ltHS/mI62hkv+abTRt0w0nlCR33iGA7jUnM2qFmtocJ
 gUnmk2qKETcWg==
Cc: Itay Aveksis <itayav@nvidia.com>, Ziyad Atiyyeh <ziyadat@nvidia.com>,
 linux-pci@vger.kernel.org, x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
 iommu@lists.linux-foundation.org, Marc Zyngier <maz@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, David Woodhouse <dwmw2@infradead.org>,
 Moshe Shemesh <moshe@nvidia.com>
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

On Thu, Nov 12, 2020 at 08:15:02PM +0100, Thomas Gleixner wrote:
> The recent changes to store the MSI irqdomain pointer in struct device
> missed that Intel DMAR does not register virtual function devices.  Due to
> that a VF device gets the plain PCI-MSI domain assigned and then issues
> compat MSI messages which get caught by the interrupt remapping unit.
> 
> Cure that by inheriting the irq domain from the physical function
> device.
> 
> That's a temporary workaround. The correct fix is to inherit the irq domain
> from the bus, but that's a larger effort which needs quite some other
> changes to the way how x86 manages PCI and MSI domains.
> 
> Fixes: 85a8dfc57a0b ("iommm/vt-d: Store irq domain in struct device")
> Reported-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  drivers/iommu/intel/dmar.c |   19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)

Our QA says it solves the issue:

Tested-by: Itay Aveksis <itayav@nvidia.com>

Thanks,
Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
