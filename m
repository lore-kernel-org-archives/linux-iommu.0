Return-Path: <SRS0=cxdO=AM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BAF4C433DF
	for <iommu@archiver.kernel.org>; Wed,  1 Jul 2020 18:48:33 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4551B208B6
	for <iommu@archiver.kernel.org>; Wed,  1 Jul 2020 18:48:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="MsngOlu5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4551B208B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 22FE7891C2;
	Wed,  1 Jul 2020 18:48:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Tj72URrVxsGN; Wed,  1 Jul 2020 18:48:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 4967489152;
	Wed,  1 Jul 2020 18:48:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 345EFC0865;
	Wed,  1 Jul 2020 18:48:31 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B06AEC0733
 for <iommu@lists.linux-foundation.org>; Wed,  1 Jul 2020 18:48:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id ABEEE8BFF4
 for <iommu@lists.linux-foundation.org>; Wed,  1 Jul 2020 18:48:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yJb2o0PYjvUl for <iommu@lists.linux-foundation.org>;
 Wed,  1 Jul 2020 18:48:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from nat-hk.nvidia.com (nat-hk.nvidia.com [203.18.50.4])
 by whitealder.osuosl.org (Postfix) with ESMTPS id CB0FD8BFE9
 for <iommu@lists.linux-foundation.org>; Wed,  1 Jul 2020 18:48:29 +0000 (UTC)
Received: from hkpgpgate101.nvidia.com (Not Verified[10.18.92.9]) by
 nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5efcda7b0000>; Thu, 02 Jul 2020 02:48:27 +0800
Received: from HKMAIL103.nvidia.com ([10.18.16.12])
 by hkpgpgate101.nvidia.com (PGP Universal service);
 Wed, 01 Jul 2020 11:48:27 -0700
X-PGP-Universal: processed;
 by hkpgpgate101.nvidia.com on Wed, 01 Jul 2020 11:48:27 -0700
Received: from HKMAIL104.nvidia.com (10.18.16.13) by HKMAIL103.nvidia.com
 (10.18.16.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 1 Jul
 2020 18:48:24 +0000
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.47) by
 HKMAIL104.nvidia.com (10.18.16.13) with Microsoft SMTP Server (TLS)
 id 15.0.1473.3 via Frontend Transport; Wed, 1 Jul 2020 18:48:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eK6OvV51BaiDprPgWV1ixPHHi/nAvIQ0koTeFBzK02leHuBd1V+LTjfabc38rbwnYsBhzGTISkl5G+s5bGlCvSQlf4Q9Fy7zIXKKCtpa1B483ES+AJwjvcxyvnjsji/WZnCpciL2E13nmDgQ44KT3p07XfO+jC1ZTEk2LbD/Go6ltUOe1cEyBAKCJatw+2QlD5FAYkyaJuqK3X5rTsdxJ6WqgMtK470pzVezKj46yG7zOPSTYda/DkpzZiraw3W/3KTCE7PrT069kGVAglqHVzaDd5l6eG4kczJum82HztWpC3Ouj7FWE5x2uw/scEwqVu/H09zUNRDVhhvyaLjdBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HMlAxghR2/clqNmApd87U8FikBSTSt/+1kn5kdOogfk=;
 b=IWkqyJRjOEc/fj7ZHFn6EeU3nACMjfmZ2JY2fYh3aVH6+IDXkx76+p2QgoMppeoVkxmGz3qYdwsfhRB4/1kxtAWYOvf9io+JEXCcY+8AtkQ9Udpj4grwPet5pw4WlL2NRSVBE0Mdq04TOxn+zwl56JvafLbPO5WtRz8GSeWNZGAaH8/nO1p9Jo9kF0xqUCrViDRUGkkIAHNrMTHWjdvSjAjcJ6UHeJH+H8wr1rbxM6fd3aBeL8EmlsftOmuFfHPQAltb660BtNNeK/m9GvTlYnIw7b7k7RhRONG2NGm0+lkG6/kI/pCvGN7nARPCvu+hoqeWy/PBirOsOIwu8NUqjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from BYAPR12MB2822.namprd12.prod.outlook.com (2603:10b6:a03:9a::17)
 by BYAPR12MB2728.namprd12.prod.outlook.com (2603:10b6:a03:61::25)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.26; Wed, 1 Jul
 2020 18:48:22 +0000
Received: from BYAPR12MB2822.namprd12.prod.outlook.com
 ([fe80::70bd:803f:78b6:ebf2]) by BYAPR12MB2822.namprd12.prod.outlook.com
 ([fe80::70bd:803f:78b6:ebf2%2]) with mapi id 15.20.3131.027; Wed, 1 Jul 2020
 18:48:22 +0000
From: Krishna Reddy <vdumpa@nvidia.com>
To: Robin Murphy <robin.murphy@arm.com>, Jonathan Hunter <jonathanh@nvidia.com>
Subject: RE: [PATCH v8 3/3] iommu/arm-smmu: Add global/context fault
 implementation hooks
Thread-Topic: [PATCH v8 3/3] iommu/arm-smmu: Add global/context fault
 implementation hooks
Thread-Index: AQHWTnL3VCCI3Y3jhE+XVIWcwjPCvKjw1msAgAA8hACAAf2WwA==
Date: Wed, 1 Jul 2020 18:48:22 +0000
Message-ID: <BYAPR12MB282244D2B008E1C8CA57916BB36C0@BYAPR12MB2822.namprd12.prod.outlook.com>
References: <20200630001051.12350-1-vdumpa@nvidia.com>
 <20200630001051.12350-4-vdumpa@nvidia.com>
 <4b4b20af-7baa-0987-e40d-af74235153f6@nvidia.com>
 <6c2ce909-c71b-351f-79f5-b1a4b4c0e4ac@arm.com>
In-Reply-To: <6c2ce909-c71b-351f-79f5-b1a4b4c0e4ac@arm.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Enabled=True;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_SiteId=43083d15-7273-40c1-b7db-39efd9ccc17a;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Owner=VDUMPA@nvidia.com;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_SetDate=2020-07-01T18:48:17.8986883Z;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Name=Unrestricted;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_ActionId=f93d34b0-b07a-440c-a2f3-1629f40dd0fd;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Extended_MSFT_Method=Automatic
authentication-results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=nvidia.com;
x-originating-ip: [216.228.112.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 56572b60-cf84-48ee-babf-08d81def5459
x-ms-traffictypediagnostic: BYAPR12MB2728:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB2728D2868A2C448D3E5071F3B36C0@BYAPR12MB2728.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 04519BA941
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /fnYqZMxFRokfK4vl4l/s2ze8k2PZDSU2chagW0giNnRtEzNgMBJXDcENTMP/0ihGaT/xRmd+luYLsClf+s/0oKWoEbQ1GnIs+Tzxd4Wf8WYhK1t1Mtw9uHC2cvxAqaWb/1RfvHhxq41H8n1x+w4+7pYOkfGfSLlUfcIr4L6IYbSkxA9nu5eESO0Zb/1n4OCz1btdIwTemwO0nL7/A/hj6p+G8VnXcyywS84xzFY7P30xN0YZOiToehpB8JYFYh2m97eGQNMScmqsBQilaY5LM3bVorO19MODv3FWY2gWGixiHJIjvsILAXFyfGxIbn7Fv8NTwS5qlEBB+wRhYEUPw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB2822.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(136003)(376002)(396003)(346002)(366004)(110136005)(54906003)(107886003)(86362001)(33656002)(9686003)(6506007)(52536014)(7696005)(66556008)(66476007)(66946007)(76116006)(316002)(66446008)(64756008)(83380400001)(5660300002)(71200400001)(186003)(26005)(2906002)(8676002)(6636002)(8936002)(478600001)(4326008)(55016002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: /weF3qAHvMFY0B+nAZBnndnjSKOp3ydPVTRUV/Lnf77qaC9/VB2J8VI+i9CRPhlZJSWKeEKA1LRdtpTYnCRuCbsAfYo6QLwJFKXMNS/a05W6iwpKwPtxEVDH9+/QlaR0pGMAcjcbZ6Trhw1gauaKDUrxUw4JUjwlV3ea3TImzmGjG4P8RNIZqT4MjuIIm5gJSMTbRHI9AyNqmlAvmo43EuvcHXjaKzarnA7Yz2BAFys11lyhVDA5HlSAoGcskiuNBbMpFbDbSB4CPGsbszmWCLJFkd0btuz0MuhIHSAr2mEEgr9NK6+JKSBWG3rreVbGRAgS+5DrV9CGY00aOSM/RMZ5qKTAi6dWmVwlW5gBCg8UxyaNUgmDqSBYiBARbPXwf4sQpkBwcXa62VJ2dYmvoEds1kkiAcDwipVmGVlf/k2M8tmtOHXeDHDZ8Pv0QjhZCjtUfzOno7iMSdWHHAN2GxEcnL7wIJ16UiwMnkqwUEGmryg39Z0sZ51Yk5b7ruqc
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2822.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56572b60-cf84-48ee-babf-08d81def5459
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2020 18:48:22.0332 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tf2hrNOpJ/csNdF/I/uEgUTPlRrpy+vTScF29tFrefxWJQox9dJHLbseV0tAXKVcu/bLyPSeh80NeAX3jTKkEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2728
X-OriginatorOrg: Nvidia.com
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1593629307; bh=HMlAxghR2/clqNmApd87U8FikBSTSt/+1kn5kdOogfk=;
 h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
 ARC-Authentication-Results:From:To:CC:Subject:Thread-Topic:
 Thread-Index:Date:Message-ID:References:In-Reply-To:
 Accept-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:msip_labels:
 authentication-results:x-originating-ip:x-ms-publictraffictype:
 x-ms-office365-filtering-correlation-id:x-ms-traffictypediagnostic:
 x-ms-exchange-transport-forked:x-microsoft-antispam-prvs:
 x-ms-oob-tlc-oobclassifiers:x-forefront-prvs:
 x-ms-exchange-senderadcheck:x-microsoft-antispam:
 x-microsoft-antispam-message-info:x-forefront-antispam-report:
 x-ms-exchange-antispam-messagedata:MIME-Version:
 X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-AuthSource:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-originalarrivaltime:
 X-MS-Exchange-CrossTenant-fromentityheader:
 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
 X-MS-Exchange-CrossTenant-userprincipalname:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg:
 Content-Language:Content-Type:Content-Transfer-Encoding;
 b=MsngOlu5HIKxiwszy0g4rgSSwkKQGok8T/J5WxXqBDHiRhmoOURHqj+9X7cCMnBE8
 Bc3oImAZyQWIxSi0EnM9L9P4iZc2761/V1uFMk52cXxlLGVqVmXEpzYG+5z1LeJm34
 ROYlZ5xUlYVgwjIgA1KVI2QWsq7F/iX5iMnNe6WraimVE0Zts8n47PNKyE583AhDTy
 zouTcULjPoA67SnYITKPCxnOqP2Zf41JTeDhnL20FRJPJhEJ4woy9SDN7cZD/aFGlW
 2no1cHvsZMzxOAs6q5vBTCJXoSI+1NEv6r7vyJP6VUA5sGWtmb8JvZ7+/qWQ4nsefU
 rrlEKfgNBaxWA==
Cc: Timo Alho <talho@nvidia.com>, Thierry Reding <treding@nvidia.com>, Bryan
 Huntsman <bhuntsman@nvidia.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Mikko Perttunen <mperttunen@nvidia.com>,
 "nicoleotsuka@gmail.com" <nicoleotsuka@gmail.com>,
 Sachin Nikam <Snikam@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
 Yu-Huan Hsu <YHsu@nvidia.com>, Pritesh
 Raithatha <praithatha@nvidia.com>, "will@kernel.org" <will@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Bitan Biswas <bbiswas@nvidia.com>
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

>>> +    for (inst = 0; inst < nvidia_smmu->num_inst; inst++) {
>>> +            irq_ret = nvidia_smmu_global_fault_inst(irq, smmu, inst);
>>> +            if (irq_ret == IRQ_HANDLED)
>>> +                    return irq_ret;
>>
>> Any chance there could be more than one SMMU faulting by the time we 
>> service the interrupt?

>It certainly seems plausible if the interconnect is automatically load-balancing requests across the SMMU instances - say a driver bug caused a buffer to be unmapped too early, there could be many in-flight accesses to parts of that buffer that aren't all taking the same path and thus could now fault in parallel.
>[ And anyone inclined to nitpick global vs. context faults, s/unmap a buffer/tear down a domain/ ;) ]
>Either way I think it would be easier to reason about if we just handled these like a typical shared interrupt and always checked all the instances.

It would be optimal to check at the same time across all instances. 

>>> +            for (idx = 0; idx < smmu->num_context_banks; idx++) {
>>> +                    irq_ret = nvidia_smmu_context_fault_bank(irq, smmu,
>>> +                                                             idx, 
>>> + inst);
>>> +
>>> +                    if (irq_ret == IRQ_HANDLED)
>>> +                            return irq_ret;
>>
>> Any reason why we don't check all banks?

>As above, we certainly shouldn't bail out without checking the bank for the offending domain across all of its instances, and I guess the way this works means that we would have to iterate all the banks to achieve that.

With shared irq line, the context fault identification is not optimal already.  Reading all the context banks all the time can be additional mmio read overhead. But, it may not hurt the real use cases as these happen only when there are bugs. 

-KR
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
