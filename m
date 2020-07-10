Return-Path: <SRS0=wTTv=AV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6A88C433E5
	for <iommu@archiver.kernel.org>; Fri, 10 Jul 2020 20:30:11 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2D9B20748
	for <iommu@archiver.kernel.org>; Fri, 10 Jul 2020 20:30:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Smcoh1p/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2D9B20748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 627CC2E7F3;
	Fri, 10 Jul 2020 20:30:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mGUj1uvAQmRH; Fri, 10 Jul 2020 20:30:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 1759F2E80F;
	Fri, 10 Jul 2020 20:30:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E6A33C077B;
	Fri, 10 Jul 2020 20:30:09 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 08525C016F
 for <iommu@lists.linux-foundation.org>; Fri, 10 Jul 2020 20:30:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id EE17B89367
 for <iommu@lists.linux-foundation.org>; Fri, 10 Jul 2020 20:30:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mQz3rR1klFh5 for <iommu@lists.linux-foundation.org>;
 Fri, 10 Jul 2020 20:30:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from nat-hk.nvidia.com (nat-hk.nvidia.com [203.18.50.4])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 01DDF891E2
 for <iommu@lists.linux-foundation.org>; Fri, 10 Jul 2020 20:30:00 +0000 (UTC)
Received: from hkpgpgate102.nvidia.com (Not Verified[10.18.92.9]) by
 nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5f08cfc60000>; Sat, 11 Jul 2020 04:29:58 +0800
Received: from HKMAIL104.nvidia.com ([10.18.16.13])
 by hkpgpgate102.nvidia.com (PGP Universal service);
 Fri, 10 Jul 2020 13:29:58 -0700
X-PGP-Universal: processed;
 by hkpgpgate102.nvidia.com on Fri, 10 Jul 2020 13:29:58 -0700
Received: from HKMAIL101.nvidia.com (10.18.16.10) by HKMAIL104.nvidia.com
 (10.18.16.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 10 Jul
 2020 20:29:57 +0000
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.174)
 by HKMAIL101.nvidia.com (10.18.16.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Fri, 10 Jul 2020 20:29:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aw5hhF1MW1UL5B8uvRxHhqLGnarVOzVesa10V+HSZcYXakwqfNtj0fnwm7OMvAdmGKqYaLDxOr4zS46YDFT8nP0XnL9tgU4hGKWz1JupBFYVzatPN5xGuhP7i8uzBs15UwfZZ5RTspZYB9GzheH6SpRicYOQV+rhJHSW+Q5XyPXA/pZjCfci7sydMcOat/3ozWlj+s9BuNdMSwdkCMw8LQRJOyHzrpWFLrqDRXuDnb/vmBeeY6G16VXEuZYTUHpZUTM5/XBqfVrVwsnWfZYai7XdmVB7OxZEIAbxiE4tjwHDe2IwvBxrDXBRZS3mewhawGzXEpCgYXiq+SdC1Znm0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EmV8bfmQ8MFo4bzA2Q41Ohx9MfS0VJSqHj698eSkUmo=;
 b=IGM8th0vDvb0hcdrfG3Guj75eLR+lK3FG2jMw48eyxlGaMWdyZCvrrtKid1ABlCySOCrFHw+ZUWL+m0ZdI87/S8kCGuZnZvRMFza71OOJtODhzIzheoyQokMEAaG38pmDFqg3v2EWbQpr2rxaKYmsxxv+plmdjTXJgh4bvu/uvtyVF6Vq5NRbIvhLOOD7Jg52TFIiEHNXdwIjwP1jLa/r+l4LNMVEjAK+OOnwbNKLrZhOoDa/tyHH/G4lhmE4o8fkF7T7E8ywxSE7bTA8OofHaMh/+EtzvPq06XBbtvprLykK/wncarZxFVHDh6zAGCXFshAqUYCtY6flQ33GpUU0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from BYAPR12MB2822.namprd12.prod.outlook.com (2603:10b6:a03:9a::17)
 by BYAPR12MB2984.namprd12.prod.outlook.com (2603:10b6:a03:da::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22; Fri, 10 Jul
 2020 20:29:55 +0000
Received: from BYAPR12MB2822.namprd12.prod.outlook.com
 ([fe80::70bd:803f:78b6:ebf2]) by BYAPR12MB2822.namprd12.prod.outlook.com
 ([fe80::70bd:803f:78b6:ebf2%2]) with mapi id 15.20.3174.021; Fri, 10 Jul 2020
 20:29:55 +0000
From: Krishna Reddy <vdumpa@nvidia.com>
To: Rob Herring <robh@kernel.org>, Robin Murphy <robin.murphy@arm.com>
Subject: RE: [PATCH v10 4/5] dt-bindings: arm-smmu: add binding for Tegra194
 SMMU
Thread-Topic: [PATCH v10 4/5] dt-bindings: arm-smmu: add binding for Tegra194
 SMMU
Thread-Index: AQHWVOS3zMIxJUroL0+UAGESja2lEaj/sR8AgAGTnSA=
Date: Fri, 10 Jul 2020 20:29:55 +0000
Message-ID: <BYAPR12MB2822514F93F831507A811EE9B3650@BYAPR12MB2822.namprd12.prod.outlook.com>
References: <20200708050017.31563-1-vdumpa@nvidia.com>
 <20200708050017.31563-5-vdumpa@nvidia.com> <20200709201348.GA808454@bogus>
In-Reply-To: <20200709201348.GA808454@bogus>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Enabled=True;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_SiteId=43083d15-7273-40c1-b7db-39efd9ccc17a;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Owner=VDUMPA@nvidia.com;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_SetDate=2020-07-10T20:29:53.5607832Z;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Name=Unrestricted;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_ActionId=23cc9e9f-01f6-44f5-8d5a-b542cf46bcbb;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Extended_MSFT_Method=Automatic
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
x-originating-ip: [216.228.112.22]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2b4df9d0-2f6a-4aff-4194-08d8251001da
x-ms-traffictypediagnostic: BYAPR12MB2984:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB2984D7E03CA683FC0F61CE7BB3650@BYAPR12MB2984.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ui6Aca/1DauNO4+g7LOV5k3iXJ/ZI6bAv+4kpP/pO/9iGZ/cpzQkeMCYsLQ/tpK9NXznUwE2jG/ZzYCl5y57X6Fz4A0YaH3hcC9Pf38XVRQ0ZxXGQua+PGWLMDsVt1nWUBzhIj/kTI302DGPpgoNahAC8FlYNPnI7clnBZpSSlNadPp4AXZTNTNAaSI5GuqwUUwQYXgrLmOZPXUZirbEt2+W6aiWvx7ywzMqmJW67TmtJ/fbt3G/eVGOpRJk69e9WjHX2LgDhNuSvwGMBaDV1logX0TAxTdG48SdVtkknnbCWrq59qGjusuxsHr/8EeLJQptrEi+MjwgLACqPZm3MA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB2822.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(376002)(366004)(39860400002)(396003)(346002)(33656002)(66476007)(66556008)(66446008)(186003)(64756008)(7416002)(8936002)(26005)(54906003)(316002)(110136005)(66946007)(2906002)(52536014)(86362001)(55016002)(7696005)(5660300002)(4744005)(4326008)(6506007)(9686003)(478600001)(76116006)(71200400001)(8676002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: BlzVI7A2I+2R7bY/sKk4p6BqG4YHIqwSmYX7GcDadXz45h69LrdL5NjkY0pN3R9G0mwMozflB44C/hV4L91tGdusrWnpsE6ZyO5909EMx6cvZDeaEn6N13vb+3vsOH1AZHP7jTTQPG4c6x4FU4Xob+0EST1FhXQ70yg5eiXVpdkJLBl+oZ588+CLAMiBLT1AZS+6KuEBzP5Ye2VdW51ryW6L6+ufEILAs7UXXXNPJG/aEu5GntIYs0NqIbsp+gjRvjD+CsqNtVKh1sXPBMSkaFVIEpGs3XkqIkRZ0WUZ1BeUpGrlGmXJXY1wVzXNu1zV4fRJU2J8aIWgexpNd5JRaCcUGsnxDbIQGe5jMIGLmfhN4r8vZ2PNXdOwCEfK3v7S40viRyng/HkWQYsIV2ZmeflkAWa1+6XveG/iMdvqr32LuEPwKJ9tRe/zNxL1qASXOTbtECYYOxoDm6HSMt15ILNLn7wqURASHJJxYI8rerF14x82RiCwI4CubMcUrSyB
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2822.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b4df9d0-2f6a-4aff-4194-08d8251001da
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2020 20:29:55.1431 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iSB5184FiW0ez3CQRcv4/OMWuSS/Lc6NCXceU5Kt+sYA79zQcGI4IAY+D3cdb+OGIGUumSl06rk4dDjGRnAX6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2984
X-OriginatorOrg: Nvidia.com
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1594412998; bh=EmV8bfmQ8MFo4bzA2Q41Ohx9MfS0VJSqHj698eSkUmo=;
 h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
 ARC-Authentication-Results:From:To:CC:Subject:Thread-Topic:
 Thread-Index:Date:Message-ID:References:In-Reply-To:
 Accept-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:msip_labels:
 authentication-results:x-originating-ip:x-ms-publictraffictype:
 x-ms-office365-filtering-correlation-id:x-ms-traffictypediagnostic:
 x-ms-exchange-transport-forked:x-microsoft-antispam-prvs:
 x-ms-oob-tlc-oobclassifiers:x-ms-exchange-senderadcheck:
 x-microsoft-antispam:x-microsoft-antispam-message-info:
 x-forefront-antispam-report:x-ms-exchange-antispam-messagedata:
 MIME-Version:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-AuthSource:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-originalarrivaltime:
 X-MS-Exchange-CrossTenant-fromentityheader:
 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
 X-MS-Exchange-CrossTenant-userprincipalname:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg:
 Content-Language:Content-Type:Content-Transfer-Encoding;
 b=Smcoh1p/Qe0iB9mVdM7x+GFNPHk/7d7z4fb4F1pERMyAEkzEZ554ycZRSkZjYVSpB
 hSA/JLxTTiSsqaX9esjloPx5SG01bvjVq5xNhzCivVfcTFy9D00IoX2gsIhV5h7Muu
 QsQR6YxUNM4LN3wI1KOWkOMO8euxUoyIbLsHgNOIy9K2mR6eWdoX0zpxOXUPN6q6FI
 6owwum0vPOtHISMXUjBsDLHzBTDCANB6ZnNLX3J3og0XG9DgaFiAUxofZ2B0zJa4gD
 2EswYE8bLLSzY67Q8HuAsyqa0xj1CkZxDfEoPad9xACnL0Gi4996L7fZmIqbEAIaTX
 HVBPBNA/AHevg==
Cc: Sachin Nikam <Snikam@nvidia.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Mikko Perttunen <mperttunen@nvidia.com>,
 Pritesh Raithatha <praithatha@nvidia.com>,
 Bryan Huntsman <bhuntsman@nvidia.com>, "will@kernel.org" <will@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>, Timo Alho <talho@nvidia.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Nicolin Chen <nicolinc@nvidia.com>,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
 Yu-Huan Hsu <YHsu@nvidia.com>, Thierry Reding <treding@nvidia.com>,
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

Thanks Rob. One question on setting "minItems: ". Please see below.

>> +allOf:
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            enum:
>> +              - nvidia,tegra194-smmu
>> +    then:
>> +      properties:
>> +        reg:
>> +          minItems: 2
>> +          maxItems: 2

>This doesn't work. The main part of the schema already said there's only
>1 reg region. This part is ANDed with that, not an override. You need to add an else clause with 'maxItems: 1' and change the base schema to
>{minItems: 1, maxItems: 2}.

As the earlier version of base schema doesn't have "minItems: " set, should it be set to 0 for backward compatibility?  Or can it just be omitted setting in base schema as before?

"else" part to set "maxItems: 1" and setting "maxItems: 2" in base schema is clear to me.


-KR
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
