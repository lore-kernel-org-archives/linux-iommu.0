Return-Path: <SRS0=AdPL=CY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98599C433E2
	for <iommu@archiver.kernel.org>; Tue, 15 Sep 2020 23:45:58 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1753720715
	for <iommu@archiver.kernel.org>; Tue, 15 Sep 2020 23:45:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="oQrTpV7E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1753720715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id BDCB0872C4;
	Tue, 15 Sep 2020 23:45:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 87n-u-TrHab1; Tue, 15 Sep 2020 23:45:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 2927786FB0;
	Tue, 15 Sep 2020 23:45:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 09B46C0864;
	Tue, 15 Sep 2020 23:45:57 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C2A34C0051
 for <iommu@lists.linux-foundation.org>; Tue, 15 Sep 2020 23:45:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id BA1FC86BC5
 for <iommu@lists.linux-foundation.org>; Tue, 15 Sep 2020 23:45:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9RrpUiDXkjIZ for <iommu@lists.linux-foundation.org>;
 Tue, 15 Sep 2020 23:45:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from nat-hk.nvidia.com (nat-hk.nvidia.com [203.18.50.4])
 by whitealder.osuosl.org (Postfix) with ESMTPS id C780A86B89
 for <iommu@lists.linux-foundation.org>; Tue, 15 Sep 2020 23:45:54 +0000 (UTC)
Received: from hkpgpgate101.nvidia.com (Not Verified[10.18.92.100]) by
 nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5f61522f0000>; Wed, 16 Sep 2020 07:45:52 +0800
Received: from HKMAIL102.nvidia.com ([10.18.16.11])
 by hkpgpgate101.nvidia.com (PGP Universal service);
 Tue, 15 Sep 2020 16:45:52 -0700
X-PGP-Universal: processed;
 by hkpgpgate101.nvidia.com on Tue, 15 Sep 2020 16:45:52 -0700
Received: from HKMAIL104.nvidia.com (10.18.16.13) by HKMAIL102.nvidia.com
 (10.18.16.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 15 Sep
 2020 23:45:50 +0000
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by HKMAIL104.nvidia.com (10.18.16.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Tue, 15 Sep 2020 23:45:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oJb9wigF93QY02BXL+CcE0ZJUmQ3DRVMtH39zyYed3YCINTUibo6rZhHCUyktt5BZhJKcxNWaBac5GQCrfSXqDBgd0YJQ0Q2pv+u4Q517V/6ceHkTrMC74egHq2aDFlVNYwCBLF+ohGpUbWfDnoq9dy2C06yj9Du5BU29MoXIprQIVunegF8NLovC5fmwO5vSbHZTiDDcXwTGpatCu+MNRygVISYuTpkr8nwqktyp3Kgbjw116QCYfg6MJldM4vn4v7nPTPbcKMty1bpvtmnbr8+4Fj0vwo0NjZNZuIJKRi3Sh9137+lRylVjdmPbfxz2ffGwGt+ikNLxpbuJhX6ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QY+b1rFwc5347NsCZNczbrKa0TOjMxbqKrnitb0+iV8=;
 b=TvZdqZ7QX6qMAmxfhmWpU7R0fvb2ls99MuJEzS4VJijZsWeZP33pbpCTA6EjqAI1I33ARSQnaTShoSAKIdn/ySdrCQ7IvEbO2DPrceTUqtpbLzhjuoUSmVTsvbu4d0PWPUEaiEp12t3+uZlwjWZNW4Iqtj6Dmb4aY3HH/GcAzK0F5QzU9m+dH7Nr3F6T2fdLiMRpz7FMQBumcIAuAx/lYcmUqWWh+1byVOrG+CJX3vjMa6z4emY48e+5G+P+QuxQ4Iu6ySR60AQBf6g9tfRlxaWeOaIu0RVJITR/yuy5D+rH4ztyG3Xq+a3H6x29n+1x6frOYK/ISzbYqDDBCusLpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3593.namprd12.prod.outlook.com (2603:10b6:5:11c::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Tue, 15 Sep
 2020 23:45:48 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3391.011; Tue, 15 Sep 2020
 23:45:48 +0000
Date: Tue, 15 Sep 2020 20:45:46 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Raj, Ashok" <ashok.raj@intel.com>
Subject: Re: [PATCH v7 00/16] vfio: expose virtual Shared Virtual Addressing
 to VMs
Message-ID: <20200915234546.GJ1573713@nvidia.com>
References: <20200914163354.GG904879@nvidia.com>
 <20200914105857.3f88a271@x1.home> <20200914174121.GI904879@nvidia.com>
 <20200914122328.0a262a7b@x1.home> <20200914190057.GM904879@nvidia.com>
 <20200914224438.GA65940@otc-nc-03> <20200915113341.GW904879@nvidia.com>
 <20200915181154.GA70770@otc-nc-03> <20200915184510.GB1573713@nvidia.com>
 <20200915192632.GA71024@otc-nc-03>
Content-Disposition: inline
In-Reply-To: <20200915192632.GA71024@otc-nc-03>
X-ClientProxiedBy: YQBPR01CA0066.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:2::38) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by
 YQBPR01CA0066.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:2::38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.13 via Frontend Transport; Tue, 15 Sep 2020 23:45:47 +0000
Received: from jgg by mlx with local (Exim 4.94)	(envelope-from
 <jgg@nvidia.com>)	id 1kIKdu-006jJu-6R; Tue, 15 Sep 2020 20:45:46 -0300
X-Originating-IP: [206.223.160.26]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 61325356-da4b-4882-6fde-08d859d178a1
X-MS-TrafficTypeDiagnostic: DM6PR12MB3593:
X-Microsoft-Antispam-PRVS: <DM6PR12MB35937CB7E8A990A82F79CD59C2200@DM6PR12MB3593.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MluzXhpkfLSm4fPsMykZFS5AAX1IwCImxTNL+Za2NN2VzI847pJsPH8STmFgs0J/z/AKRyXGVdTFbKblKUO86886k3CKV524DKRyFt1Wvj02LqkyVX43ET3Zuyc4UW/S/AL+TJBP5Eht6yp/Boiv+KGOUIage0VHyFCwH8a+X5WnNWDth1+RhBLamA02UBEdUUQWfYiHhyJ8R4fd3CalHyFdd6HcW5rJSiHL7I1VW82CS03qPJCBSF3+Yc3ujUfMF15EWycltsJpHKU8OeSW6NiUhUXtkrUjR19ntfN1SZ08iGpA0ZekIk1mw2aCReVu9Fc8caXTDfQOQTiE0xRycUG0DlyryE0fHFmdTK//7NsPb2Kk1bkCC5i/0uzKc4pW
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3834.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(396003)(366004)(346002)(376002)(26005)(9746002)(9786002)(186003)(2906002)(316002)(2616005)(426003)(8936002)(36756003)(4326008)(8676002)(7416002)(1076003)(6916009)(54906003)(86362001)(478600001)(5660300002)(66556008)(66946007)(33656002)(66476007)(83380400001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 4C6iOdesv/pjBQE4z2N+qiKt/Yan4MYKll+3g0tt1CG1ypKgt9CJvX8PdkEG90AVLLi3QNX4IWNrvY4X32DRKd17fvImPFCkmEMbvZAjAbqOCafRSqt4L3L5eHr6Ci6hbPCYsi2QtChArw+hU9gJpIj8mneZjkpu68Rk+j7B9JMZck7H4ABmXO3Qo8jUzQYfhzudBFjORjK4vS5rfD4OdylWjPFJFXEl8ut8eW5e11Lw3JgvMzr1wN7IcO4qmiroVKJDJqGAuJRjVH7bUcPNH3uL+dYpEebou0iP+ZwATVunl0ygELCKDHNBbfE2rptqhHMeDMDek3n9vePkmI1RoXpGBl9Z+mwmtImENDbfQb+tJ7fiqcOeHFBd5hZvrlwqJZBtepTqzblO9iKIt4dsxcv6iid4n86oGVR66KAPLaA+7nAiLV99KBxUB1LfgDfN8eCHHH5Cnbc/V7pqmsGzCmMscmyzgffwF13yrYMp6Eq3rymDrpRvK47CQAmFNZ9+Qg8BCMNt6HpJAltmuf3ZV5J4PsznHC9bNWryUpbOj0gaFLTvQao/x9J7a7XgY5n+nWMAZmclAthgAp5QFn8TzyuNC9QjI6Iv2GfwflIpt+qViesvfLTGSQuYGTiDduf/FseEjwMlhrqkxCePrOJ9IQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 61325356-da4b-4882-6fde-08d859d178a1
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2020 23:45:48.1836 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dIITEXJTs143gGdKWNza8bdv5FSAMY1n541MFmIVjDfuNSX0UkGTS+t2PG3FosQm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3593
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1600213552; bh=QY+b1rFwc5347NsCZNczbrKa0TOjMxbqKrnitb0+iV8=;
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
 b=oQrTpV7EoKCSiRRX2H7y6mt+Gj3xFSotHdEwfTngUXTToUXcKkSfr8pE9An7fkqCK
 FJep1PDX5sHtE2ZW5/TIpl12Si7ldc/Lt8SySOC+MNkEnBZnjfwvvqGidEtyF4q7CP
 sO9carqaaj6ppy8wxOlwXmQOrTCVJwxdn4Z8Co1jDQTlnZssUy12/czD0uzEgXjj4f
 tGnEKSVuXQisFNhT6MaIdwRo/2Yn9YW8rAysp/0wafIdDFQKxJmHkHbhNKd9fapM+H
 A21BqxinKOSiTAhwAnJkPDAfxCOvk45K7dYpS2sSwbU002EO2gTHpbi9zmI+1ya+I+
 U/eS1upROgewg==
Cc: yi.y.sun@intel.com, Jean-Philippe Brucker <jean-philippe@linaro.org>,
 kevin.tian@intel.com, kvm@vger.kernel.org, iommu@lists.linux-foundation.org,
 stefanha@gmail.com, Jason Wang <jasowang@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, jun.j.tian@intel.com,
 Alex Williamson <alex.williamson@redhat.com>,
 Jacon Jun Pan <jacob.jun.pan@intel.com>, hao.wu@intel.com
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

On Tue, Sep 15, 2020 at 12:26:32PM -0700, Raj, Ashok wrote:

> > Yes, there is. There is a limited pool of HW PASID's. If one user fork
> > bombs it can easially claim an unreasonable number from that pool as
> > each process will claim a PASID. That can DOS the rest of the system.
> 
> Not sure how you had this played out.. For PASID used in ENQCMD today for
> our SVM usages, we *DO* not automatically propagate or allocate new PASIDs. 
> 
> The new process needs to bind to get a PASID for its own use. For threads
> of same process the PASID is inherited. For forks(), we do not
> auto-allocate them.

Auto-allocate doesn't matter, the PASID is tied to the mm_struct,
after fork the program will get a new mm_struct, and it can manually
re-trigger PASID allocation for that mm_struct from any SVA kernel
driver.

64k processes, each with their own mm_struct, all triggering SVA, will
allocate 64k PASID's and use up the whole 16 bit space.

> Given that PASID api's are general purpose today and any driver can use it
> to take advantage. VFIO fortunately or unfortunately has the IOMMU things
> abstracted. I suppose that support is also mostly built on top of the
> generic iommu* api abstractions in a vendor neutral way? 
> 
> I'm still lost on what is missing that vDPA can't build on top of what is
> available?

I think it is basically everything in this patch.. Why duplicate all
this uAPI?

Jason 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
