Return-Path: <SRS0=C6HT=CX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95194C433E2
	for <iommu@archiver.kernel.org>; Mon, 14 Sep 2020 17:41:37 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16D3C20759
	for <iommu@archiver.kernel.org>; Mon, 14 Sep 2020 17:41:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="GZmmSCoc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16D3C20759
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 939E62044F;
	Mon, 14 Sep 2020 17:41:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id q3alqoMg7QX4; Mon, 14 Sep 2020 17:41:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 38583203A4;
	Mon, 14 Sep 2020 17:41:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 10BD9C0864;
	Mon, 14 Sep 2020 17:41:35 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 54FA9C0051
 for <iommu@lists.linux-foundation.org>; Mon, 14 Sep 2020 17:41:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 49F4186752
 for <iommu@lists.linux-foundation.org>; Mon, 14 Sep 2020 17:41:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9lkI72DjRTv1 for <iommu@lists.linux-foundation.org>;
 Mon, 14 Sep 2020 17:41:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from nat-hk.nvidia.com (nat-hk.nvidia.com [203.18.50.4])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 4E12686750
 for <iommu@lists.linux-foundation.org>; Mon, 14 Sep 2020 17:41:33 +0000 (UTC)
Received: from hkpgpgate101.nvidia.com (Not Verified[10.18.92.100]) by
 nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5f5fab4a0000>; Tue, 15 Sep 2020 01:41:30 +0800
Received: from HKMAIL101.nvidia.com ([10.18.16.10])
 by hkpgpgate101.nvidia.com (PGP Universal service);
 Mon, 14 Sep 2020 10:41:30 -0700
X-PGP-Universal: processed;
 by hkpgpgate101.nvidia.com on Mon, 14 Sep 2020 10:41:30 -0700
Received: from HKMAIL104.nvidia.com (10.18.16.13) by HKMAIL101.nvidia.com
 (10.18.16.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 14 Sep
 2020 17:41:27 +0000
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.174)
 by HKMAIL104.nvidia.com (10.18.16.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Mon, 14 Sep 2020 17:41:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aJrT/feN6A9chhYHW1xwLE3+2ABjsya/UB6XAj9x86p1gUzRAdrsef6ahfOizIfZDjYSTefoPpgdtMm4ETMrI+DU5OAvEVcbgTa6efEEkee8XdZUsd7gCnc917qL0fFi1ct5/Nc/rIgfTm9BQLBwtW/dhnq8EUVW3hKmsUIaNo16uzWGZVcwoiVguUwdH63V496I1xvH21k5koqiRAN5obrXxmQ9zswnGoIzTLB7gR2jX2+CHyNdkm+1Z9vsg7qoQ9tVgu/Lzfi+dL1LswLsbu0iXJyY4fysu2WbPo8RtW4TskVXRelg64rTZFekW1x+aKfdY76nfg65uohUoDqejQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xk9oeKq288FSuGwzXHCFTHTvrASZ5X8dS44UH/GOg5U=;
 b=bC7ylK1uamg4GmPJndCWjEVOQtTnj2Cuzrwe3IOrXogILCbjgXK2Qa2Yry5SwDnJWLOmbbqX2UmhRZme05LB4I6ba0rIs2aE7/10VE2q5CsGZSltqLptJoDReoECnFQ5x6a5Ezpyj/VmSr726km7SDFC/BytcK69DoKfpndmtx1QpgHWAjpXD1aEn+dv949lOknd3xZ6EIpWBkcCiocRh86Yy5hQy+auyjLWiqA8HP7Ig7eHzu7k3siOEXqIA7MmOvt9NY3By/cSuHXMjb4LDuvWpZy3AbqXXSsoVuolLwRTJSwq3YMoiB/Xj2WWIpyuoxExyBzL2E0dbOCk/c2eSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4267.namprd12.prod.outlook.com (2603:10b6:5:21e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Mon, 14 Sep
 2020 17:41:24 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3370.019; Mon, 14 Sep 2020
 17:41:24 +0000
Date: Mon, 14 Sep 2020 14:41:21 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH v7 00/16] vfio: expose virtual Shared Virtual Addressing
 to VMs
Message-ID: <20200914174121.GI904879@nvidia.com>
References: <1599734733-6431-1-git-send-email-yi.l.liu@intel.com>
 <411c81c0-f13c-37cc-6c26-cafb42b46b15@redhat.com>
 <20200914133113.GB1375106@myrica> <20200914134738.GX904879@nvidia.com>
 <20200914162247.GA63399@otc-nc-03> <20200914163354.GG904879@nvidia.com>
 <20200914105857.3f88a271@x1.home>
Content-Disposition: inline
In-Reply-To: <20200914105857.3f88a271@x1.home>
X-ClientProxiedBy: YT1PR01CA0024.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::37)
 To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by
 YT1PR01CA0024.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3370.16 via Frontend Transport; Mon, 14 Sep 2020 17:41:23 +0000
Received: from jgg by mlx with local (Exim 4.94)	(envelope-from
 <jgg@nvidia.com>)	id 1kHsTh-006BYz-VB; Mon, 14 Sep 2020 14:41:21 -0300
X-Originating-IP: [206.223.160.26]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ce948602-71f8-4fc6-ce2a-08d858d56605
X-MS-TrafficTypeDiagnostic: DM6PR12MB4267:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4267353CC2B7C8B01C1A7DD0C2230@DM6PR12MB4267.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: seGMj0E6jFxQywd0AObAH8w1WFIaVMZn2B+HrWL9CxVul+K+XwyoJ/AWUL7NGUbiMNp7CbXff4yUzKhGtpRt54GKoBJhXmLztABcixM9W5zfwmzQmJuVeW9uTansBr8RRhR4EAli4vOHnOVJeVdaG4+7oL2AYVOJVNZmStwEvqFvW0iycSqbXpnxhghJXAN5YpCtLBVygS3ugdCew2zrDXOgoYJYCK7xUj8cevHy/ucTP1tYvfeywS7Y7/hEp8waQHy2CwAMFy4hS9+3jxRnaGt4LxS7t4OfI3F/9dsRjkzSF1X5OFldFWY/+3jys0KhH7u3aiDtSLBbkBicFN1LeCwBTps2hiBL4x2vY/gV/5xvKP8HYX9FNRbcCJROAQhP
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3834.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(376002)(39860400002)(396003)(136003)(478600001)(6916009)(54906003)(86362001)(1076003)(5660300002)(83380400001)(66476007)(66946007)(66556008)(33656002)(2906002)(316002)(186003)(9786002)(9746002)(26005)(36756003)(4326008)(8936002)(2616005)(8676002)(426003)(7416002)(27376004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: abU9xq7TBOZVhpwna97wucZ9sa+G2tj01v5FXfkgkSa3E8RxHIj3NG+/3j2M5E2uH011MmDcrllaGEcFAVolnrr08JWnJgpdox6yvpbsZCHr677sbroUFqMvdaqhn0CTkyHzsd7EaEMwP1bY3ilacnqxIoHchDL4u6pNyqGjOVZi98D5z2JRoSyxLlahNZ6LMFJJEVi9B9eKJ+5C6w2Y17EB7HBQKMgWW4ux56Njr1eNmv4MDH6RXUEcHJUxWszJ6V0ZGHN9M5G52aN+NQvybVZYxhIJ0gDQm4wse40RUEq/QzkdHsefziekCHnNbjmt0deIwRmYJ87VoKUI9U1kNB5QDil1iCpZUaCcAG6akDh1da4S3/2feLXXWtR5nipUYIaf6ij0ER4VCfmmvQBI/swsxBfQJpnSliWOtPDFMF9G9C7Jr/UC+NddOcmD8o+EADf2KQez0LuK/2UW59bR71WFVTxMENZMwGhAOxvt5nGPN5sDjW5tfxuhbTjCs7z8GZ29qDY8am9NjlOYng8AoRZHlGTYa27wGi6ROV22GywMZ4GXgSOk9lOqhTHSEb5DN7Qc9L193736Z7/+yC5SrWTCykw3n5ergYYbXIQk3lgasd+FuhF5dYBoXNkv//sDhoEbwQFI9MdbuFqj5G3ERA==
X-MS-Exchange-CrossTenant-Network-Message-Id: ce948602-71f8-4fc6-ce2a-08d858d56605
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2020 17:41:23.8208 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IGAUooHJNqGn94WMdXvJcY0CXd3ANAfTxCJo9v1NVf2xOW9Cdha1/NpRbsHug5xO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4267
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1600105290; bh=xk9oeKq288FSuGwzXHCFTHTvrASZ5X8dS44UH/GOg5U=;
 h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
 ARC-Authentication-Results:Authentication-Results:Date:From:To:CC:
 Subject:Message-ID:References:Content-Type:Content-Disposition:
 In-Reply-To:X-ClientProxiedBy:MIME-Version:
 X-MS-Exchange-MessageSentRepresentingType:X-Originating-IP:
 X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id:
 X-MS-TrafficTypeDiagnostic:X-Microsoft-Antispam-PRVS:
 X-MS-Oob-TLC-OOBClassifiers:X-MS-Exchange-SenderADCheck:
 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
 X-Forefront-Antispam-Report:X-MS-Exchange-AntiSpam-MessageData:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-AuthSource:
 X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
 X-MS-Exchange-CrossTenant-UserPrincipalName:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
 b=GZmmSCocbV5b9EWNE2o/oumSph9EDAH5NHENgE9iPCiafl1NMfHR5f91mjT79quSZ
 wCOjXPfRAplElC98O9eeqxQfdl5k/I16Fu7AWDSjIdHuLz5nXbDcjTUMNMzqaxxDjV
 3q0k8Ingx+sBdAhdXoe2FEIZJolLtfArEROjA7/MZJ2TJynyMPnX6OOOZLWVbkxSI0
 obF4Ye/mSKlgMjhkpu3hjyx4RkFTxlsyociR0Y2sEU7kAg+H6HLD5Q+p+bQriLi81U
 2tmr79hgXLdB5KuXoYLyOZmr+HIKY29dN4GTs05uyAsbBtqQoVngP9zoppcsfdiw+a
 T8fk9pzUolQWQ==
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, kevin.tian@intel.com,
 "Raj, Ashok" <ashok.raj@intel.com>, kvm@vger.kernel.org,
 iommu@lists.linux-foundation.org, stefanha@gmail.com,
 Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 jun.j.tian@intel.com, yi.y.sun@intel.com, hao.wu@intel.com
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

On Mon, Sep 14, 2020 at 10:58:57AM -0600, Alex Williamson wrote:
 
> "its own special way" is arguable, VFIO is just making use of what's
> being proposed as the uapi via its existing IOMMU interface.

I mean, if we have a /dev/sva then it makes no sense to extend the
VFIO interfaces with the same stuff. VFIO should simply accept a PASID
created from /dev/sva and use it just like any other user-DMA driver
would.

> are also a system resource, so we require some degree of access control
> and quotas for management of PASIDs.  

This has already happened, the SVA patches generally allow unpriv user
space to allocate a PASID for their process.

If a device implements a mdev shared with a kernel driver (like IDXD)
then it will be sharing that PASID pool across both drivers. In this
case it makes no sense that VFIO has PASID quota logic because it has
an incomplete view. It could only make sense if VFIO is the exclusive
owner of the bus/device/function.

The tracking logic needs to be global.. Most probably in some kind of
PASID cgroup controller?

> know whether an assigned device requires PASIDs such that access to
> this dev file is provided to QEMU?

Wouldn't QEMU just open /dev/sva if it needs it? Like other dev files?
Why would it need something special?

> would be an obvious DoS path if any user can create arbitrary
> allocations.  If we can move code out of VFIO, I'm all for it, but I
> think it needs to be better defined than "implement magic universal sva
> uapi interface" before we can really consider it.  Thanks,

Jason began by saying VDPA will need this too, I agree with him.

I'm not sure why it would be "magic"? This series already gives a
pretty solid blueprint for what the interface would need to
have. Interested folks need to sit down and talk about it not just
default everything to being built inside VFIO.

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
