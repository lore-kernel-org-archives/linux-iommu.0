Return-Path: <SRS0=cxdO=AM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F256C433E1
	for <iommu@archiver.kernel.org>; Wed,  1 Jul 2020 18:29:11 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E5B620870
	for <iommu@archiver.kernel.org>; Wed,  1 Jul 2020 18:29:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="EQ3H2l8O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E5B620870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id EBF13824E3;
	Wed,  1 Jul 2020 18:29:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eucKtwUL-wzW; Wed,  1 Jul 2020 18:29:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 5AB2E863D9;
	Wed,  1 Jul 2020 18:29:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4BAC8C0865;
	Wed,  1 Jul 2020 18:29:10 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9BCA7C0733
 for <iommu@lists.linux-foundation.org>; Wed,  1 Jul 2020 18:29:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id EADDD8ADCA
 for <iommu@lists.linux-foundation.org>; Wed,  1 Jul 2020 18:29:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id R4E4P5J4QH+g for <iommu@lists.linux-foundation.org>;
 Wed,  1 Jul 2020 18:29:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from nat-hk.nvidia.com (nat-hk.nvidia.com [203.18.50.4])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 1357C87903
 for <iommu@lists.linux-foundation.org>; Wed,  1 Jul 2020 18:29:05 +0000 (UTC)
Received: from hkpgpgate101.nvidia.com (Not Verified[10.18.92.77]) by
 nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5efcd5f00000>; Thu, 02 Jul 2020 02:29:04 +0800
Received: from HKMAIL104.nvidia.com ([10.18.16.13])
 by hkpgpgate101.nvidia.com (PGP Universal service);
 Wed, 01 Jul 2020 11:29:04 -0700
X-PGP-Universal: processed;
 by hkpgpgate101.nvidia.com on Wed, 01 Jul 2020 11:29:04 -0700
Received: from HKMAIL103.nvidia.com (10.18.16.12) by HKMAIL104.nvidia.com
 (10.18.16.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 1 Jul
 2020 18:28:59 +0000
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.175)
 by HKMAIL103.nvidia.com (10.18.16.12) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Wed, 1 Jul 2020 18:28:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=glucSAEgGXmN0OAailQjNnqxv1KUbwptN4HnxwMa0xTM5WS1wIO3+/fmurC24+ljwQFYVZAfqe2rJxvgGrTDAkDSM4FfeoV7kirH/jtrIpzPSbBC6aMTS8afuIH3Eiuxoj7But/I589cCWN5Gf53y3MdMH8tTtKZ3vSxPBoBBzDOANqSGmwAtHl5NbZEzdyLRYt/Wjhik5xtgAhHwT3uMjWtv6frE9OONcI0KL5DFyzjc07qRBMfpNflR6Z2YudffkSuoHniElMia8ZHb3XuRwbBpBTCBMudwXEGkMcVsjYwXwxMe58N6hQ/koFiU3ysJYrIHRNfByzlIICoBELezA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0xGmsIQyx378Ka0zvcKLlLY0LRBQ4IdRw2hONYcURCA=;
 b=Bx3HuD21fSVb2tUu9JszVzIgJgF30RYvMlLAnzN0ev7/Erg77Pg/augICmxsQplH/iq7tl2mnpy6qkKw6zvgprjGfre7j36Nk3qiQOb7FRmdMLemxcYB2zicerIOzrDXIZI68ZuLF6PSdmfU/KQUJQ8h7LkQ/dHglQGxigw7KVmiJcDol0mTV5OAMek1zF+sWYqbm3utpn6JIZ99WLWh6Q+qdjXSsjbe4snhwU3V3a2f0sz6Ci+JsNOQ0nWx7tfVKTeUNN3qRGpR+y+XVzTt3WknN1fuAESr58QnCOIoBy1z/1RjGyneD7IdhWhrkJm8R7cK4hQ/XSpqLtXf7UO4NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from BYAPR12MB2822.namprd12.prod.outlook.com (2603:10b6:a03:9a::17)
 by BYAPR12MB3575.namprd12.prod.outlook.com (2603:10b6:a03:ab::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.26; Wed, 1 Jul
 2020 18:28:56 +0000
Received: from BYAPR12MB2822.namprd12.prod.outlook.com
 ([fe80::70bd:803f:78b6:ebf2]) by BYAPR12MB2822.namprd12.prod.outlook.com
 ([fe80::70bd:803f:78b6:ebf2%2]) with mapi id 15.20.3131.027; Wed, 1 Jul 2020
 18:28:56 +0000
From: Krishna Reddy <vdumpa@nvidia.com>
To: Robin Murphy <robin.murphy@arm.com>
Subject: RE: [PATCH v8 2/3] dt-bindings: arm-smmu: Add binding for Tegra194
 SMMU
Thread-Topic: [PATCH v8 2/3] dt-bindings: arm-smmu: Add binding for Tegra194
 SMMU
Thread-Index: AQHWTnLtO+c1bLqxQk+6SvUQTirpX6jxFsYAgAH0qfA=
Date: Wed, 1 Jul 2020 18:28:55 +0000
Message-ID: <BYAPR12MB28222D6ADEBA966AA27FA9ECB36C0@BYAPR12MB2822.namprd12.prod.outlook.com>
References: <20200630001051.12350-1-vdumpa@nvidia.com>
 <20200630001051.12350-3-vdumpa@nvidia.com>
 <3e655881-bac4-f083-44ed-cfa0a61298d0@arm.com>
In-Reply-To: <3e655881-bac4-f083-44ed-cfa0a61298d0@arm.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Enabled=True;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_SiteId=43083d15-7273-40c1-b7db-39efd9ccc17a;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Owner=VDUMPA@nvidia.com;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_SetDate=2020-07-01T18:28:53.6229888Z;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Name=Unrestricted;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_ActionId=8bbb85db-f166-41aa-8425-8b40b3ee3ffb;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Extended_MSFT_Method=Automatic
authentication-results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=nvidia.com;
x-originating-ip: [216.228.112.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f9573370-45a5-4d53-c854-08d81dec9d56
x-ms-traffictypediagnostic: BYAPR12MB3575:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB35750064366E0695F8794CA3B36C0@BYAPR12MB3575.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 04519BA941
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iTZDVxskHget1SgaE5X23IZKUimnGrGhZPrfDAvAj5tt5SXWVZhNsOzVGdC/zfUKR5xHbO2NRvICw7bf/HcWcnAKJH9iz904ezZQsAMGVqdEzSUt02uNMGsyvjes87drhokwYgyWOGtjrMIXTPdSGvQHEQLQ1r2f6roKlFk6q5+7GFR9T4nRaMHFihUnqpJavVWYQciOzU91KwuXQeclDI4mKtiwBD9c2BGI7Ueq0oaayZC4FljfAzfNvQP0iC7Pgrm7gxD++CWU0gTw9EvR6JhrT5Ewy34QXqmh8iD4thT3AMZgjBrwVTXiyixKLuC6lOTbeFy+nTQuB+OUN9K2Wg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB2822.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(39860400002)(376002)(346002)(396003)(136003)(55016002)(8936002)(2906002)(76116006)(66556008)(66476007)(66446008)(64756008)(316002)(66946007)(33656002)(5660300002)(478600001)(52536014)(8676002)(6916009)(71200400001)(54906003)(26005)(6506007)(4744005)(86362001)(186003)(7696005)(4326008)(9686003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: YWf9QKgcNw6MmNSvdD8He+OZuIoYmTND3ewJRknmGwemHJaGG3CVCM0W85/kIV0K/58sV6gsEKAZAT5xlQYJ7NL0drPCb3TP/wGR50vO6QjhNZRzdkDg3lpwPmTRlHKU7mh55VZFzp90w8FPZItJKBCVNuqmzNKpryLO9y61bYUiWlSRA9eTptvqWmWWNm7qVONTNPnLuei/U9lfJsuiOPMMjVUb+Ll80kMKJuONUOArPm5F3oBcMl8nDtGiOeJYmDZdELwqyR+PsQl7YauskEEfeST/rMI6g4Kq7D4l7sm0BldH8b5Bsw5qEPZbCCdIxeE1VeaYQNrlp5LBqC8qDZJ97QFXHErAmmtHcuRCDVAuThsovDdrgl+4p5jOpVyW85dhoUKz6KFNcr1GTqzSich8/YqGcfMOunmDKjcbPFTr23KAervi/cxSihWAsa5XOx8bxSdvAnbcR63ARfaBN4SOdh1NpsKuVvphx30qYeZEtWvY11J6LmMxkSFA83qq
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2822.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9573370-45a5-4d53-c854-08d81dec9d56
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2020 18:28:55.9974 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N8RBIFNLUTwMKs7Z/Anh7VK3XyOMeESR2c/wUbmXtMpe0/7Iueup+ciDE4zFX8MPJzqpLN/6xMfTR2uiklZgoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3575
X-OriginatorOrg: Nvidia.com
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1593628144; bh=0xGmsIQyx378Ka0zvcKLlLY0LRBQ4IdRw2hONYcURCA=;
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
 b=EQ3H2l8OmiKEO/Q5trSPUQNo8vXgbwF8fK4AmsL0rXh9iURkOKqVtiVd6jPRi/yFU
 WT5Mm5gwddshIKpWz5oxnfXdVz60cRPTYtyIBLv8hzmJbvXCr/u8xDMtDtzgUBF0eD
 LvphJH4Ns7kzfQc2xu82YcnxOF7zrGpGOJMJYxjj27xiiMizo5oh6mPwBUjDuzHYMh
 +JJqeKufnSjiGMf4kVKH0UNFY8fKvSecI55bmNNzHoBPiZSXXOxVRqZ8GgAzoFA86r
 DXoSAZ/nyF6cWheGW4pbsq5eAN+vGkVo5y99UDetSjtWPrNvItOB0OQuE7eGhWYMCS
 mI6PtD/iGbVSA==
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

>> +      - description: NVIDIA SoCs that use more than one "arm,mmu-500"
> Hmm, there must be a better way to word that to express that it only applies to the sets of SMMUs that must be programmed identically, and not any other independent MMU-500s that might also happen to be in the same SoC.

Let me reword it to "NVIDIA SoCs that must program multiple MMU-500s identically".

>> +        items:
>> +          - enum:
>> +              - nvdia,tegra194-smmu
>> +          - const: arm,mmu-500

>Is the fallback compatible appropriate here? If software treats this as a standard MMU-500 it will only program the first instance (because the second isn't presented as a separate MMU-500) - is there any way that isn't going to blow up?

When compatible is set to both nvidia,tegra194-smmu and arm,mmu-500, implementation override ensure that both instances are programmed. Isn't it? I am not sure I follow your comment fully.

-KR

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
