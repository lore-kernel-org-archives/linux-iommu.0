Return-Path: <SRS0=cxdO=AM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFBB3C433E0
	for <iommu@archiver.kernel.org>; Wed,  1 Jul 2020 19:40:01 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC6D22082F
	for <iommu@archiver.kernel.org>; Wed,  1 Jul 2020 19:40:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="LzgCldV1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC6D22082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 7812D8B96B;
	Wed,  1 Jul 2020 19:40:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BrIxmrre5jsT; Wed,  1 Jul 2020 19:40:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id D9E728B791;
	Wed,  1 Jul 2020 19:40:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C1282C0890;
	Wed,  1 Jul 2020 19:40:00 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 50CF8C0733
 for <iommu@lists.linux-foundation.org>; Wed,  1 Jul 2020 19:39:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 3923D8B791
 for <iommu@lists.linux-foundation.org>; Wed,  1 Jul 2020 19:39:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id n6xJsNJqMoIj for <iommu@lists.linux-foundation.org>;
 Wed,  1 Jul 2020 19:39:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from hqnvemgate24.nvidia.com (hqnvemgate24.nvidia.com
 [216.228.121.143])
 by whitealder.osuosl.org (Postfix) with ESMTPS id DB3F98B947
 for <iommu@lists.linux-foundation.org>; Wed,  1 Jul 2020 19:39:57 +0000 (UTC)
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5efce6290000>; Wed, 01 Jul 2020 12:38:17 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Wed, 01 Jul 2020 12:39:57 -0700
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Wed, 01 Jul 2020 12:39:57 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 1 Jul
 2020 19:39:52 +0000
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (104.47.45.57) by
 HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server
 (TLS) id
 15.0.1473.3 via Frontend Transport; Wed, 1 Jul 2020 19:39:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jAaYXohNvaRkKVndYFg+8BDD3WztYiTxA4Cbo0HOSw/bmAg5hlnxqGFtLkveusvripKMeQyVP18h00CZYYyHHewTxi8cdw1tEUdMuo04YUDEzEJefo/AdT3hsRqIKeEU+egCjI+78/1Aq2iqk+S5UK8FGUZgoDmNhHXWRlJfk1UVTVuLKvImm7Ajx8Ypy/jMBeMb2MZ23C65n+rHgU/VodWyNqYRMTJCvL0EKwS18EQLdHz9twlmdfPSOz8RR5W1Lt1QZQN+mortIPC/piG4kxmKkKjM6P9OWdC6J52UD6Nr5pgyaLt7bcZN5J3+wmMvWw37lzQFjwVDQ7ubOSWcBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r0VyKIKMkZ+TYVRHj9ciDY1OJts+8wIb9MgTV3QWNwE=;
 b=IP1+DFNJmd/EDgYbXISM59Bx276RXz4IbVwqKpeczGo+Ena+4kV0e4e+bq05jfCauSWwHOScEoqc9H9r10E8B13FYz+SBgyBE7rrOqAAnfCpb8RuvhLE6tOzsFFJ1Ytn8sljmJdFD2BX08y77N23Br4k2MghFXVXYMR+PfOZ2wF9gkEE07fOkGcrNrXwEmL0cDm/1c3DcKbC+1XwWeUyzIpBpXdUOXzXCkdL691+IhOlepxDRyLumMD0sDpHjQytoI+DOV8RnaB/d/Ny2YZRUlDwl6v3iPO01cmLZ3sAg9AQo8pnQt2U8O5qahk6QC7LYqasW0DCzWXjHUkZdG5i+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from BYAPR12MB2822.namprd12.prod.outlook.com (2603:10b6:a03:9a::17)
 by BY5PR12MB4292.namprd12.prod.outlook.com (2603:10b6:a03:212::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.22; Wed, 1 Jul
 2020 19:39:51 +0000
Received: from BYAPR12MB2822.namprd12.prod.outlook.com
 ([fe80::70bd:803f:78b6:ebf2]) by BYAPR12MB2822.namprd12.prod.outlook.com
 ([fe80::70bd:803f:78b6:ebf2%2]) with mapi id 15.20.3131.027; Wed, 1 Jul 2020
 19:39:51 +0000
From: Krishna Reddy <vdumpa@nvidia.com>
To: Jonathan Hunter <jonathanh@nvidia.com>, Robin Murphy <robin.murphy@arm.com>
Subject: RE: [PATCH v8 2/3] dt-bindings: arm-smmu: Add binding for Tegra194
 SMMU
Thread-Topic: [PATCH v8 2/3] dt-bindings: arm-smmu: Add binding for Tegra194
 SMMU
Thread-Index: AQHWTnLtO+c1bLqxQk+6SvUQTirpX6jxFsYAgAH0qfCAAAfXAIAAAiQAgAAKGICAAACGQA==
Date: Wed, 1 Jul 2020 19:39:51 +0000
Message-ID: <BYAPR12MB2822EE99210BFA984ECB954AB36C0@BYAPR12MB2822.namprd12.prod.outlook.com>
References: <20200630001051.12350-1-vdumpa@nvidia.com>
 <20200630001051.12350-3-vdumpa@nvidia.com>
 <3e655881-bac4-f083-44ed-cfa0a61298d0@arm.com>
 <BYAPR12MB28222D6ADEBA966AA27FA9ECB36C0@BYAPR12MB2822.namprd12.prod.outlook.com>
 <0d4f46d6-6a4e-bca0-bcf3-0e22a950e57b@nvidia.com>
 <BYAPR12MB282245DD6BB50ECA700AC69EB36C0@BYAPR12MB2822.namprd12.prod.outlook.com>
 <b10673f6-2a01-b9e5-0948-9684ffbe1813@nvidia.com>
In-Reply-To: <b10673f6-2a01-b9e5-0948-9684ffbe1813@nvidia.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Enabled=True;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_SiteId=43083d15-7273-40c1-b7db-39efd9ccc17a;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Owner=VDUMPA@nvidia.com;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_SetDate=2020-07-01T19:39:41.3476805Z;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Name=Unrestricted;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_ActionId=1e5a298f-6414-4cb8-bb73-d5ee44b12e28;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Extended_MSFT_Method=Automatic
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=nvidia.com;
x-originating-ip: [216.228.112.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9241ffa7-9222-4404-e82d-08d81df685d6
x-ms-traffictypediagnostic: BY5PR12MB4292:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB42924217DD3DC4C4BFD37E7FB36C0@BY5PR12MB4292.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 04519BA941
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uHzpEdXw/efaxLf49tRoDJLwwsC00mCILb1qx2TvJfwPEwSnbuu3GdXhqhhgz0J6aagrk47CRhgtw7OWETYNFaFnLXsrFVHQkIp6yNGXAVvCH+EpT1xAPcKBnMDKUNw9ZHRz9K/6S4FwPIGzMMjQ5jhP8xX/jkn1oFD2+AxsIeD6gafYViqOdeTV0ahxaWk+O0NEyc+OzTsd9asjndQE6qI4bpGjFNEU/FXG9eZN46TsitUKo7YOmvPKv3ynZ+8JLVAHHmtrNtdmu3/aDKinJwzV48NMSeqp4pjlPXHn040ObtBbJlo5gSCNqTwquo2k
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB2822.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(39860400002)(366004)(376002)(136003)(396003)(5660300002)(8676002)(53546011)(26005)(86362001)(2906002)(71200400001)(33656002)(186003)(83380400001)(8936002)(52536014)(64756008)(66556008)(66476007)(4326008)(55016002)(9686003)(110136005)(316002)(478600001)(54906003)(6506007)(66446008)(66946007)(76116006)(7696005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: NYdyN8JhSWjrbOwgP2ds2hMOfp4Ll7Z1Fvwkk2aP/aGjI8rIeGu8uprVWCjgrSQTqUmJUemezHefTrpo7/16xsoueJWbjAGhLkbQmHP4FZqGd5sevewdF+VvKtE1TeDyLXlO95GMGCMc9osCrlZNEe5sxBBXUqzYVjBlta2r9zyzO+5B1K9pVoIO65q/3sdeyidyCK9FNUtZteCVPKyMYjtFnwnNyg4H5bOKqegthkUiFk/CTbgVWhu7lHAtnUV8TESRJhegs6+qoA3QLtONKWkzjpJyAf1p9qTEez0fT+OQgk0sLu1FueT+Ay27GYd3QReSVuGYaqHBwArXAzDftbTS/6tj9xnf+CYw+YdrYIuOLKD97jdH73a/8jB7OUP85LaOQ1vj1nN/yTcPF5yPs+oY/H5iL3BuO/dZSjRNVYKnYXTf8k2JS+VrXelqRlvy4cXMCKjE4iY/NneMZr7TzUsEsOVoUIe2KOXLlWiMKTWqoxxjQkWxxsxPJ2Dav71f
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2822.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9241ffa7-9222-4404-e82d-08d81df685d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2020 19:39:51.5460 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MxphPJO3M3dGtCfJUgjhvdXnksn9fvw3VFO2FucLU8bCXuPkRMG5UPC4LIJZg76/FlDe6LdNXoPoft9BQyOyRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4292
X-OriginatorOrg: Nvidia.com
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1593632297; bh=r0VyKIKMkZ+TYVRHj9ciDY1OJts+8wIb9MgTV3QWNwE=;
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
 b=LzgCldV1XFk449rQei2608bSZKcTjXYqyFgLNfVNU0BzPLHN6oDC/5I6jpAaaUwLv
 Q0DBojr0SyQ57ao7XyQQ4lyNLXJgm6sigF27DhQDxht2UbCB0kr9rqQKzL9E6zVQOr
 V9mGrmD1vtQDPTMj4z6dSq9xeBatF2A+Ma3VwAknp3ZDBvJeAW1b1RIOU7nZvceVSX
 9NhI97FW6jwWr13+u0pnp/u2uBD0DAZs7DpClymfUjgcYNIbroAkVdWP4y5MP2jtpv
 o7Mj72BJb7AD2OSZYNJFVK+joLvlRgZ+SEU4pb6w21UJFw9IM5TlJNfPlgD/A5f8+X
 rp4HSkFd8jXig==
Cc: Sachin Nikam <Snikam@nvidia.com>,
 "nicoleotsuka@gmail.com" <nicoleotsuka@gmail.com>,
 Mikko Perttunen <mperttunen@nvidia.com>, Bryan Huntsman <bhuntsman@nvidia.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Pritesh Raithatha <praithatha@nvidia.com>, Timo Alho <talho@nvidia.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Nicolin Chen <nicolinc@nvidia.com>,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, Yu-Huan
 Hsu <YHsu@nvidia.com>, Thierry Reding <treding@nvidia.com>,
 "will@kernel.org" <will@kernel.org>,
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

On 01/07/2020 20:00, Krishna Reddy wrote:
>>>>>> +        items:
>>>>>> +          - enum:
>>>>>> +              - nvdia,tegra194-smmu
>>>>>> +          - const: arm,mmu-500
>>>>
>>>>> Is the fallback compatible appropriate here? If software treats this as a standard MMU-500 it will only program the first instance (because the second isn't presented as a separate MMU-500) - is there any way that isn't going to blow up?
>>>>
>>>> When compatible is set to both nvidia,tegra194-smmu and arm,mmu-500, implementation override ensure that both instances are programmed. Isn't it? I am not sure I follow your comment fully.
>> 
>>> The problem is, if for some reason someone had a Tegra194, but only set the compatible string to 'arm,mmu-500' it would assume that it was a normal arm,mmu-500 and only one instance would be programmed. We always want at least 2 of the 3 instances >>programmed and so we should only match 'nvidia,tegra194-smmu'. In fact, I think that we also need to update the arm_smmu_of_match table to add 'nvidia,tegra194-smmu' with the data set to &arm_mmu500.
>> 
>> In that case, new binding "nvidia,smmu-v2" can be added with data set to &arm_mmu500 and enumeration would have nvidia,tegra194-smmu and another variant for next generation SoC in future. 

>I think you would be better off with nvidia,smmu-500 as smmu-v2 appears to be something different. I see others have a smmu-v2 but I am not sure if that is legacy. We have an smmu-500 and so that would seem more appropriate.

I tried to use the binding synonymous to other vendors. 
V2 is the architecture version.  MMU-500 is the actual implementation from ARM based on V2 arch.  As we just use the MMU-500 IP as it is, It can be named as nvidia,smmu-500 or similar as well.
Others probably having their own implementation based on V2 arch.

KR
--
nvpublic
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
