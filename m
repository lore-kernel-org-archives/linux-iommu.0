Return-Path: <SRS0=ODk1=W2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37302C3A59B
	for <iommu@archiver.kernel.org>; Fri, 30 Aug 2019 17:26:21 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0814423427
	for <iommu@archiver.kernel.org>; Fri, 30 Aug 2019 17:26:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="I3AOU4gY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0814423427
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id D64B36336;
	Fri, 30 Aug 2019 17:26:20 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 2A0326333
	for <iommu@lists.linux-foundation.org>;
	Fri, 30 Aug 2019 17:25:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from hqemgate15.nvidia.com (hqemgate15.nvidia.com [216.228.121.64])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id BE7C313A
	for <iommu@lists.linux-foundation.org>;
	Fri, 30 Aug 2019 17:25:14 +0000 (UTC)
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
	hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
	id <B5d695bfc0000>; Fri, 30 Aug 2019 10:25:16 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
	by hqpgpgate101.nvidia.com (PGP Universal service);
	Fri, 30 Aug 2019 10:25:14 -0700
X-PGP-Universal: processed;
	by hqpgpgate101.nvidia.com on Fri, 30 Aug 2019 10:25:14 -0700
Received: from HQMAIL110.nvidia.com (172.18.146.15) by HQMAIL105.nvidia.com
	(172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3;
	Fri, 30 Aug 2019 17:25:13 +0000
Received: from HQMAIL107.nvidia.com (172.20.187.13) by hqmail110.nvidia.com
	(172.18.146.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3;
	Fri, 30 Aug 2019 17:25:13 +0000
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (104.47.33.58) by
	HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server
	(TLS) id
	15.0.1473.3 via Frontend Transport; Fri, 30 Aug 2019 17:25:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
	b=MAQlqwyjG5bfVXbSD8cBchSgnB+VlKokPANq1CYKxbPn4a1V2suKI/OURCFx0X91E9A8LpeZO35bBftL/S50RdrCpNET0maSwO58hmBQyDQIP1vy66M8CstKXnY1pPtZ/V2uIeqTyxkgQdxL5LiqRXsfIyJN+1YbHtKj8KqXpgOjByNIBs/awYpsy+m2E0WvTpO/9h0qYYsOdu1RrXYOyZXrKZoLd0hrDYJnCCgf2Xy7OrSAv2/AnfzTBNxFHRLMT/J7iFFaNduSPMBBVjG4+dDzNcKZQPxpvY+w5hlTag9bbR0QiWa1Pvl2+Ol8I7EFwhb49VAOLma8bC2T4yQKzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
	s=arcselector9901;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=hBYQzXGSSqiSlRRKp0339GbPc2xiTkMeMT/N2OIhMlU=;
	b=GtrvGDePBAbVsHXAQzYrn7LZlUOMd3Cou+It2hn37u/9IV6cOrkzU/63hbXic+KPbO/Q8T3bFN7vqQ111zCmWx7v2SQUpItVL1dlZLctqqTqgkeeVKd9yzsPLuAq9eDilXNMpHWyh3ir9Z4u0KLhj+UnFB79ey865k3fAnQBogTUWhhlS6vSYyKX0yPDT5F0q86zVKtW35vtLPb9pefk8Vy96E49b0BUac7FwwCD22CmNES3MnKpK0Fz62sIqJgXkw9wKi0ItXWZnIMt9YHwRZqqqfPIoJpNUMajrd3z2MJuFTJwuDbDoas63ySJGEhHImzhHFz0bABYnCEKXf+zuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
	smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
	dkim=pass header.d=nvidia.com; arc=none
Received: from BYAPR12MB2710.namprd12.prod.outlook.com (20.177.124.11) by
	BYAPR12MB3574.namprd12.prod.outlook.com (20.178.197.16) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.2199.21; Fri, 30 Aug 2019 17:25:12 +0000
Received: from BYAPR12MB2710.namprd12.prod.outlook.com
	([fe80::60a8:9757:8be2:2c56]) by
	BYAPR12MB2710.namprd12.prod.outlook.com
	([fe80::60a8:9757:8be2:2c56%6]) with mapi id 15.20.2220.013;
	Fri, 30 Aug 2019 17:25:12 +0000
From: Krishna Reddy <vdumpa@nvidia.com>
To: Robin Murphy <robin.murphy@arm.com>
Subject: RE: [PATCH 6/7] arm64: tegra: Add DT node for T194 SMMU
Thread-Topic: [PATCH 6/7] arm64: tegra: Add DT node for T194 SMMU
Thread-Index: AQHVXruJJaNjwNgb20yUxCVyNgmdfqcT1imAgAAZ92A=
Date: Fri, 30 Aug 2019 17:25:11 +0000
Message-ID: <BYAPR12MB2710BDF98FA472A77D106814B3BD0@BYAPR12MB2710.namprd12.prod.outlook.com>
References: <1567118827-26358-1-git-send-email-vdumpa@nvidia.com>
	<1567118827-26358-7-git-send-email-vdumpa@nvidia.com>
	<b834ceb2-b296-0a52-c913-5a8923466cf2@arm.com>
In-Reply-To: <b834ceb2-b296-0a52-c913-5a8923466cf2@arm.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Enabled=True;
	MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_SiteId=43083d15-7273-40c1-b7db-39efd9ccc17a;
	MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Owner=VDUMPA@nvidia.com;
	MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_SetDate=2019-08-30T17:25:08.1305198Z;
	MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Name=Unrestricted;
	MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Application=Microsoft
	Azure Information Protection;
	MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_ActionId=27c1526a-15e9-4826-93e8-329f3444bf1f;
	MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=vdumpa@nvidia.com; 
x-originating-ip: [216.228.112.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 177d8ee7-67bd-455b-ccb7-08d72d6f03ad
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);
	SRVR:BYAPR12MB3574; 
x-ms-traffictypediagnostic: BYAPR12MB3574:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB3574EA79B6B4F8776EF29C02B3BD0@BYAPR12MB3574.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0145758B1D
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10009020)(376002)(366004)(346002)(39860400002)(136003)(396003)(199004)(189003)(446003)(256004)(52536014)(14454004)(5660300002)(186003)(6246003)(7736002)(305945005)(486006)(25786009)(71200400001)(71190400001)(4326008)(4744005)(86362001)(316002)(478600001)(33656002)(6916009)(229853002)(26005)(6506007)(11346002)(66066001)(66446008)(66946007)(66476007)(66556008)(99286004)(64756008)(55016002)(476003)(81156014)(81166006)(76176011)(7696005)(8676002)(74316002)(6436002)(6116002)(3846002)(54906003)(53936002)(102836004)(76116006)(2906002)(8936002)(14444005)(9686003);
	DIR:OUT; SFP:1101; SCL:1; SRVR:BYAPR12MB3574;
	H:BYAPR12MB2710.namprd12.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nvidia.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Vv1qDg0j9Z36PuJi5cFFCBaZE8WkMB3f1ZgN6yJDSXMpKkEOPaKPqOQ3MyLq0ITRe/LzRzVtpK/1IDJtRKjpDCOZmK/Z4H01XQKcANM/88Imv04ce65mKfsnStzbEbll5KVuVoNGu4kdZY1cvlpxXomBBfy2lZ0HCy+PMfQB02hDDdbz51CSQ6YV5OgfrWaGBJ7UwQ64DOXUpaKrhgfMJcPa2B63dSOA2jcRfV7nWvQTZBoxViO8a1UhUhXGjHzuaxJPG26uZtmfawBBy5ikL+cgh59zKv86YwfFmx0bv6M0K8ThQV9DgOFy7Wb8ZAdSp/+uOG0RTPPm//ERgEjxOT2fcW6zMXpg1aMWgF9+16ZZw2NMISoy+Pi0ENEvTeiJut6F7qXUfhPjXokwi/keqmiexSMsXm2k0sFdtREiHc8=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 177d8ee7-67bd-455b-ccb7-08d72d6f03ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2019 17:25:11.9887 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qazTpIEnqfmVXCUzxG6Phze+I9RVmDL/w16KUfalKe2ImOvoJkf6+/AVhzXEIrKVAFDUs+ZtL5JPyM4glgb/mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3574
X-OriginatorOrg: Nvidia.com
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
	t=1567185916; bh=hBYQzXGSSqiSlRRKp0339GbPc2xiTkMeMT/N2OIhMlU=;
	h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
	ARC-Authentication-Results:From:To:CC:Subject:Thread-Topic:
	Thread-Index:Date:Message-ID:References:In-Reply-To:
	Accept-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:msip_labels:
	authentication-results:x-originating-ip:x-ms-publictraffictype:
	x-ms-office365-filtering-correlation-id:x-microsoft-antispam:
	x-ms-traffictypediagnostic:x-ms-exchange-transport-forked:
	x-microsoft-antispam-prvs:x-ms-oob-tlc-oobclassifiers:
	x-forefront-prvs:x-forefront-antispam-report:received-spf:
	x-ms-exchange-senderadcheck:x-microsoft-antispam-message-info:
	MIME-Version:X-MS-Exchange-CrossTenant-Network-Message-Id:
	X-MS-Exchange-CrossTenant-originalarrivaltime:
	X-MS-Exchange-CrossTenant-fromentityheader:
	X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	X-MS-Exchange-CrossTenant-userprincipalname:
	X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg:
	Content-Language:Content-Type:Content-Transfer-Encoding;
	b=I3AOU4gYw3gBtNvcJt06i/GXDwcKXX4STHTsLZRGJj+3VvfCKxmWhh88jznceHO3q
	qpwtwWUFXv9i9KR0rOZbIWjv5kGljd5QYFmAATWrSebSTwTNH886UNoNbwM1S6Qh9Q
	Ft3abSwDUv/w4jFyoMGfH8q//4ZGMKhNCaXRUdkCjL16JksCUnYiWqUFUBfAFAZdu1
	4XmYazhfYi9jAtn7K+3ek4xrdq50PBI/fpxn50MxUgK3NziWuRsW7n//Xnzfek60vb
	7TLiQtlu6ASdANsruhvXDgvFsoOWzJ9VCZXJmxpIveIbY3AC8SX9+/6XsRKOhAfbSa
	BBbzaxWHVu5KA==
Cc: Timo Alho <talho@nvidia.com>, Thierry Reding <treding@nvidia.com>,
	Mikko Perttunen <mperttunen@nvidia.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"will.deacon@arm.com" <will.deacon@arm.com>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	Pritesh Raithatha <praithatha@nvidia.com>,
	"Thomas Zeng \(SW-TEGRA\)" <thomasz@nvidia.com>,
	Sachin Nikam <Snikam@nvidia.com>,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
	Yu-Huan Hsu <YHsu@nvidia.com>, Juha Tukkinen <jtukkinen@nvidia.com>,
	Alexander Van Brunt <avanbrunt@nvidia.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

>> +		#global-interrupts = <1>;

>Shouldn't that be 3?

Interrupt line is shared between global and all context faults for each SMMU instance.
Nvidia implementation checks for both Global and context faults on each interrupt to an SMMU instance. 
It can be either 1 or 3.  If we make it 3, we need to add two more irq entries in node for context faults. 
In the future, we can update arm-smmu.c to support shared interrupt line between global and all context faults.


 -KR
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
