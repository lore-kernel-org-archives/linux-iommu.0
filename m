Return-Path: <SRS0=0Jez=AL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DDF5C433DF
	for <iommu@archiver.kernel.org>; Tue, 30 Jun 2020 07:51:41 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4D4820775
	for <iommu@archiver.kernel.org>; Tue, 30 Jun 2020 07:51:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="AX5eD223"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4D4820775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id B8FB0884B2;
	Tue, 30 Jun 2020 07:51:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0hFwp2SM0r6d; Tue, 30 Jun 2020 07:51:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 40CCF87AFF;
	Tue, 30 Jun 2020 07:51:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2D6E3C0865;
	Tue, 30 Jun 2020 07:51:40 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3E949C016E
 for <iommu@lists.linux-foundation.org>; Tue, 30 Jun 2020 05:58:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 37A3487C2E
 for <iommu@lists.linux-foundation.org>; Tue, 30 Jun 2020 05:58:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id c+Hr73dqMv4U for <iommu@lists.linux-foundation.org>;
 Tue, 30 Jun 2020 05:58:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from nat-hk.nvidia.com (nat-hk.nvidia.com [203.18.50.4])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 007CE8793D
 for <iommu@lists.linux-foundation.org>; Tue, 30 Jun 2020 05:58:20 +0000 (UTC)
Received: from hkpgpgate102.nvidia.com (Not Verified[10.18.92.9]) by
 nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5efad47a0000>; Tue, 30 Jun 2020 13:58:18 +0800
Received: from HKMAIL104.nvidia.com ([10.18.16.13])
 by hkpgpgate102.nvidia.com (PGP Universal service);
 Mon, 29 Jun 2020 22:58:18 -0700
X-PGP-Universal: processed;
 by hkpgpgate102.nvidia.com on Mon, 29 Jun 2020 22:58:18 -0700
Received: from HKMAIL103.nvidia.com (10.18.16.12) by HKMAIL104.nvidia.com
 (10.18.16.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 30 Jun
 2020 05:58:13 +0000
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by HKMAIL103.nvidia.com (10.18.16.12) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Tue, 30 Jun 2020 05:58:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c++XqhAB4AOlb+khJfelHguzy75b6HD2Xcm76kdsT6UsY1IqcGdbSKKn+IVIP3dJ7YqU08fjqT2xrOVd5dhKbsMX4R44ZZwos2e8C77t4DPmuxgTAsRisvhD6twDTNyz/rLamyJQFY6IdCiSJDp5VEvSgZUaOHiog5obdBd0/9PG6EC0NI9X+2mnvCGDlGLI0+ZhvWa4HA350KKJtmINrlkWspojR6XRXiAB7r9s6/kLsasCVu/Xx+xAmEWuupVB1hrLpjaTuLZ7tfgBFDIqAOZOIlveqrwqZC7bfCZoPkCnqdq74C/6fmijCvYgWtLsbAWOj0vFUH16yc9XESBASQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=76NIu7kuYKCZ49S1tAIY8iQ2mAjWvmN/q55TYjlfRDk=;
 b=ODE83Xiw6kdH1k15Jf8TsyJ0V6QL/N1y7bIpKNVhVmcGDbozwGpO6MygGrvcrpfzli1zp3bzd1hh4qvloAZzQYOmHP1VnbfUXptxJnRmMnIMYKaE1uTJELOTH6PZ2p9J/gzJ1hsYXFdjUCosp9H/ZEPyl5WqAUXn+Nt2IUzl7k9ur0ajg095J5fzsb+dJqzlL7bb+Wf59/TMjR1Y5s3gLzbjKW5GWns5T7IpsQao1cWiwFNgnZBUvDfmdKimWTt3s4wXoxl+tO2hqIPyEpunEQiX3Y/duG/u04bPDlA5GGeJmaCEY1emfvaYOACsXXw8scMBDi8oiPfqVHXWE/Vwxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from CY4PR12MB1688.namprd12.prod.outlook.com (2603:10b6:910:8::15)
 by CY4PR1201MB0024.namprd12.prod.outlook.com (2603:10b6:910:1b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.25; Tue, 30 Jun
 2020 05:58:09 +0000
Received: from CY4PR12MB1688.namprd12.prod.outlook.com
 ([fe80::a976:61a8:970b:d874]) by CY4PR12MB1688.namprd12.prod.outlook.com
 ([fe80::a976:61a8:970b:d874%11]) with mapi id 15.20.3131.028; Tue, 30 Jun
 2020 05:58:09 +0000
From: Pritesh Raithatha <praithatha@nvidia.com>
To: Krishna Reddy <vdumpa@nvidia.com>
Subject: RE: [PATCH v8 3/3] iommu/arm-smmu: Add global/context fault
 implementation hooks
Thread-Topic: [PATCH v8 3/3] iommu/arm-smmu: Add global/context fault
 implementation hooks
Thread-Index: AQHWTnL3f6gglWZBokCvw47z1EPWK6jwqcGA
Date: Tue, 30 Jun 2020 05:58:09 +0000
Message-ID: <CY4PR12MB1688F5D894490CADDF0B2B02A26F0@CY4PR12MB1688.namprd12.prod.outlook.com>
References: <20200630001051.12350-1-vdumpa@nvidia.com>
 <20200630001051.12350-4-vdumpa@nvidia.com>
In-Reply-To: <20200630001051.12350-4-vdumpa@nvidia.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Enabled=True;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_SiteId=43083d15-7273-40c1-b7db-39efd9ccc17a;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Owner=PRAITHATHA@nvidia.com;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_SetDate=2020-06-30T05:58:03.0385428Z;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Name=Unrestricted;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_ActionId=b1fb364d-4113-4a62-8245-b80f61cbb114;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Extended_MSFT_Method=Automatic
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=nvidia.com;
x-originating-ip: [202.164.25.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b82d8864-a27c-44cf-9186-08d81cba90f0
x-ms-traffictypediagnostic: CY4PR1201MB0024:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR1201MB0024C6773CE77F6F920D7CC1A26F0@CY4PR1201MB0024.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:506;
x-forefront-prvs: 0450A714CB
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: y5bTiyVaK6JroSUOgu81XXabJ49f7A0wXTiQ7I9P76cyD4E8Z9AAkT0QZoJlSyq75vUc5eyF7YJahlNWvZ3/xFVgzbdE2OPGeUIwGOB2NuL7WyQSnvsVMPE8wvxHNN/JDAXtH9DPtWje5pIXdbwJIF7I+xxZGvfKB2/4fBDP8ISQXdjYg8Gz3CW1hLsGyWFRzuQDa5CYgXTnckotItv2//vyQ2DEEnM+g1LaadVQ59EWnJgKIvpn0iMhM+EOhFb2akCoJ5PI0NxjSwWY/1t/+bC5wjtfFuQUQRQRqOOlG5qDtnVYWWkHGiMJQ5KgbGgmgtUEnFB3zIaGjzKrlRNlzw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1688.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(396003)(39860400002)(366004)(376002)(136003)(76116006)(478600001)(66556008)(66476007)(558084003)(6506007)(6636002)(2906002)(316002)(26005)(52536014)(6862004)(8936002)(66446008)(8676002)(71200400001)(4326008)(54906003)(186003)(64756008)(66946007)(55016002)(5660300002)(9686003)(7696005)(33656002)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: NRZpvCd+ELqyFAZgXAL+94MBRzeL9CQAc+fZSxUaJXrbjuArk0fkLTKGD0T5In9UWBLV3+tAhhK8yps2eelmBzw/4WkUwZQflbDms6hxSoVSMxVnQSTC/ASl0Wmmlp++JpG9Vs0NeOyLkwmibmMfawEeC9a2iTQ4Y5L/vyI/g/p7QNo/3f9Rbrvs/sb28hieejAIcKKk2G95m9ZnEAOdXZiPlHU4rjrRVNKqMbHb7pDNM/fBkM+p3XMlJ5+0nld1pWBYGYATUge1p8gEKjQMN4VPsSMnZ/sITwBPy/sa2v7GYbW8/mFJI5MmhEeD8/ecNBVfpiZN32KpKa+d3EcK7f5zNbCUw0xKazc9rHaiZltoagjelGTdhXiw0fzEXV7ftOFOeWT3qxI3ShdDJPU7zXXcbWqaKGjwa4c91StMN7WPdccc4l/cJcEooqFm0DydOyAr99kfnmv09XsHaPE06DOHkJN78Ii+CfYUvFSr7w4=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1688.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b82d8864-a27c-44cf-9186-08d81cba90f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2020 05:58:09.1985 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t3HBPqN5Zs33jbKjkyfBPp3g9frz3QdNatB0CxVKM2lTdm1MvvcOl7UmP6YD8YFeqSH7RFW90tEvkw97vNgV1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0024
X-OriginatorOrg: Nvidia.com
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1593496698; bh=76NIu7kuYKCZ49S1tAIY8iQ2mAjWvmN/q55TYjlfRDk=;
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
 b=AX5eD223pgBjGij5tUeuqjrOxW8EMoSlmVh9JiY2xwsHvF4StQT11eiSEMmKDD+R5
 FF+1GM7CMaIj/i4ZIKg+wC+AskzGG2+QMS8dmbHnXi+7meuwLx5DT10b8CCEVnzADe
 LVvAHHyJY7K2Q+F4nck34vj9WRI0FvN5p9yN6wiGxLwb+8RpTjywVwsmNITVWVoUZm
 Djx7cabqeHe9wvE/yq0S++H61+pd/7xsTaVMpSmOsqhN2SdWhTL7XB3/V5WsiuaTpg
 J90dZumeJytOS+x7tOYUpoTWAOWrM7vNNpIQ9zdxdDHjBzBuYUsSY3vOnavdvnMjZD
 Byt6USYC6qE8g==
X-Mailman-Approved-At: Tue, 30 Jun 2020 07:51:38 +0000
Cc: Sachin Nikam <Snikam@nvidia.com>,
 "nicoleotsuka@gmail.com" <nicoleotsuka@gmail.com>,
 Bryan Huntsman <bhuntsman@nvidia.com>, "will@kernel.org" <will@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Mikko Perttunen <mperttunen@nvidia.com>, Timo Alho <talho@nvidia.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Nicolin Chen <nicolinc@nvidia.com>,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, Yu-Huan
 Hsu <YHsu@nvidia.com>, Thierry Reding <treding@nvidia.com>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>,
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

> Add global/context fault hooks to allow NVIDIA SMMU implementation handle
> faults across multiple SMMUs.
> 
> Signed-off-by: Krishna Reddy <vdumpa@nvidia.com>

Reviewed-by: Pritesh Raithatha <praithatha@nvidia.com>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
