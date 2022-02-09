Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 600E0C433F5
	for <iommu@archiver.kernel.org>; Wed,  9 Feb 2022 08:41:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0CEE34091F;
	Wed,  9 Feb 2022 08:41:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SrC3OLXzcIL1; Wed,  9 Feb 2022 08:41:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id B758A40123;
	Wed,  9 Feb 2022 08:41:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 93C49C0011;
	Wed,  9 Feb 2022 08:41:36 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A1FD5C000B
 for <iommu@lists.linux-foundation.org>; Wed,  9 Feb 2022 08:41:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7061360F96
 for <iommu@lists.linux-foundation.org>; Wed,  9 Feb 2022 08:41:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IVEekNqaHlnO for <iommu@lists.linux-foundation.org>;
 Wed,  9 Feb 2022 08:41:33 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20604.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::604])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4020F60F95
 for <iommu@lists.linux-foundation.org>; Wed,  9 Feb 2022 08:41:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mXfYNMUuuhgNUKnhFmpOXLKMwn44K7juUuspOgKPldHJhKLns3JEj0nGrVaiHazL5GXY6fz/A3vVqX63cH5oAAmMGj6vsCPlL4yuow5tBBQzYPoYheAZyhbvyHquV8sFgpAKGga4oKxdxXiJlHiyUStDiIJT3CyNNgaQkrO886vullCIyRkXZev5ywkn9tcswunV3rZ/ebFgs3n9xSBcPwlLOGuIEyCoAmDYERtAlFTh2ntYeabTj4CTvihocuVyCnKlNEXP1lbSdmMQHNVK7tEW+0Q+XmatgxCHBGiBjIxVDYRRqTvFyIqR8YgO0pSuW3NQVbiHHfHImQRModHQRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cVOGMd2fu1/RTnal7ugV+22PhaBclwGF6CeB1tY+xxU=;
 b=DEDZ5jUqo+vD6A0EWICFeR0p0I2cGfSw0ROWnjMtWdYPdEqM6ocHCt3ZQlRzRPtCg/xj2Mk8lQMhDvo2XlHnAOYUUsqjCYJURUOXOqqNZQ940USmKfHpRFtRO2FL2NPtMdpKYRFCg/KU/ZoKEbFiCn3nu8cGiHmFxuCbuvow/2+wehC70NcPhhBvQdfTygbXIOy1bOV1usueczkRGSlcYEjkGfJAd7CMMQT7rsbd78RD3DRGUS4XuMv9xSFeoq9PPz1NYQzkXJGTbsHCWcIAqFnuyCbwztSjaQRusIRiASUuhzo9TmmLgUGHIrPgcDahcRl1c7YP7doW3RLQMQYNJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cVOGMd2fu1/RTnal7ugV+22PhaBclwGF6CeB1tY+xxU=;
 b=shEDq9+MZPdhyqGB8zMCH73qiRZdzjQmMyb6XiXKul+eubDMC5NTrIy25C+v/dknCEGsjlZQS1ppDKiNuzxY0ppphNqkT4mCq6WDfbrMrNQj6N4JBqhNT+YoQacfvPoBJQPBt6/Z++cn6OiAOaJmTr3g2xlJ74Tt1A3fwMP8A8CCgRhN/TFrohjSHZsBVYfEyh/9422r0zUJ1Jl4C1a+nq1Y7yT8sqmkMVa83KuPg3+ks7671coy9nCA+OgrnLhMK469mqMHrqCYiRHeujiYBiVxwRhGkmvlIo2g86p7QJWOQPh/LW1OrQxnMOVRE34wYcVcnmApncoF8pTep3EFjA==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by DM6PR12MB4910.namprd12.prod.outlook.com (2603:10b6:5:1bb::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Wed, 9 Feb
 2022 08:41:31 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::846c:d3cd:5a30:c35]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::846c:d3cd:5a30:c35%5]) with mapi id 15.20.4951.019; Wed, 9 Feb 2022
 08:41:30 +0000
To: Martin Oliveira <Martin.Oliveira@eideticom.com>
Subject: Re: Error when running fio against nvme-of rdma target (mlx5 driver)
Thread-Topic: Error when running fio against nvme-of rdma target (mlx5 driver)
Thread-Index: AQHYHRbxB1j8kCqLyE+mphWtfDRQH6yK53wA
Date: Wed, 9 Feb 2022 08:41:30 +0000
Message-ID: <62fd851d-564e-e2f3-1a40-b594810d9f01@nvidia.com>
References: <MW3PR19MB42505C41C2BA3F425A5CB606E42D9@MW3PR19MB4250.namprd19.prod.outlook.com>
In-Reply-To: <MW3PR19MB42505C41C2BA3F425A5CB606E42D9@MW3PR19MB4250.namprd19.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f3308915-30df-459f-f17f-08d9eba7f869
x-ms-traffictypediagnostic: DM6PR12MB4910:EE_
x-microsoft-antispam-prvs: <DM6PR12MB491042779A29FD4B05CD7D2BA32E9@DM6PR12MB4910.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /6/ej5x8JSDpf7sQy7xgdaODXNjDAxEZbAOUXca+I9aH2rJMii7qPIByNGxfHjlt/52DW4BKokWRfAZjekuRceciU+2/l3fZJRik22n9FluxqnYHLn4jRKaZRvI+CfvHB5P4EzgBL2GOPXleSqtRitEAqV/Ki+Hb8oaPCTt7FTYbBb1BP3MeNVsIaeJkvxei9mgkJtacJviA6jzR1/P9z4NM640Bxn8pNLFbgKCuNGhqczSTIW/owIHQJeGkBTfnmnrOjYybiiXuEeFaj0nl6MH2fD9sFH4C6utW0jrcwhACgt+mXu0K9n6LvmGQ17efzLwYH1/Ur059f9O8cv0sRofuJm8hHCPWoWXc3zQkYO7jUZ976PfFblASBshzSuO8n5U0W1+0U7Q0tIU4zv3jgw0HdlQCiB25Q+1BGK61PF+PDA3k/wvZ5OSXHQM8seYCdCGGPzszjNvj912mopy0xnurYYFV7/8H5bUwZQk59CAoJNHC8DR/n35u9KxTW8Ns44h10wX8bQwMFbv0l0/q3shJsJXXiG2oC+9H1zQQj262aiM680s3KoDJ6f4ArSMXtRUsxznfXnEHap0Vsv3E9/wL40v8zkddnEMz0dgxWiT1rVpzV5NBu2uTauQ1QB4gnOac6qVgATPxyuQAglVEKxrM1qAmPfOhx9pwlUuhndwkGIvjtEvnQj149/NPSv9iWWaTXMqpL17rIorfhzIaVuZFjQdHtSZr1NV+09Kc6ld8ict8ua5cCkNqBljRpRHvQRiDEE0vGsHcyQhu3fl0Kg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(6486002)(508600001)(53546011)(2616005)(36756003)(31686004)(71200400001)(6506007)(76116006)(316002)(8936002)(4744005)(31696002)(38070700005)(5660300002)(186003)(122000001)(6916009)(54906003)(38100700002)(91956017)(6512007)(8676002)(4326008)(64756008)(86362001)(2906002)(66476007)(66946007)(66446008)(66556008)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YXdRYzVyOWJwSTh4cHpNSmxwTXRNeVJiR0NjWDhWS2JXaGZlTEMzUXNRSnpl?=
 =?utf-8?B?TW1iNCtOSDlrMC9hZEs3ckt4Njc0Z09TUWNGNzRpblFDZjFBNXNTSG5aKzZI?=
 =?utf-8?B?eTNIV2hJN0JGdU9UZUlPaEZURzBXWHpYcGxwQkI4NFF1dituRlVhZ2ZtQUox?=
 =?utf-8?B?eE9tRGd3QkpnUnRhRTY5VExBVCtVVFlpMXJlRjZ6eTFZTWJTZkNPZVE3bHRv?=
 =?utf-8?B?UFhoV0tMNlF2RU4xbUYzM2ZMUS9rWU4ycUJaYnZhVUM3UFN0RHNBVlFGNVNz?=
 =?utf-8?B?dkhyeE9RcmdzQzNBcnRBUEpIK0F1ZUJlaFRwTUZEOUM2dmFqZ1dqZXU5OWRk?=
 =?utf-8?B?NmlmTktIT0NNaEVyTE1COWVUL2FIblR1Y3dETVNGSTExdjJOT3MrT1RzRko5?=
 =?utf-8?B?YVR3eEZSdFZPei9uV0RPNE4xKzU0VFlkRFNGK0RmMFgxa08yZTkxUEpMdUV2?=
 =?utf-8?B?NFFNMy9PKzZaLy9wL2xYNnAwUjgrNk5nMnZ0WU5FazMzVXhyTGhxRUhuRUV6?=
 =?utf-8?B?aVV3SlArOTZabk5UcXpKMStPcExMcDBNWFJQSE55a3FKTFhiaFlRSEpKdVMw?=
 =?utf-8?B?NTllb1h3ci96MkpMVU90QkYvL2N3bWtWUHNwcmJwelptZmM5ay9vTTBDN2Fz?=
 =?utf-8?B?L0VmNEIxK2tEUGM4ZVp4d2tsR2hjSDJEa0xuWnpWcE5DeEtNTWd6VWxiUVpJ?=
 =?utf-8?B?N1hhaHU4dnNqQkV2eWYybzFjVUtWMjcvZSt1aDlTSlNPZnRoR3Bta2x6UURw?=
 =?utf-8?B?ek1KcXB5Q0pEWlkyS0lEZ21QaTVwYkUwNU9lNnB5c1B4TWpPLzNuSEtVT2Jv?=
 =?utf-8?B?ZzFPZ2JOK0Jnc3pILzkyU3RWZ1hMVjlYSHBYNUYzdDJyemUzMEc4bGlSd2hY?=
 =?utf-8?B?ejlEL0YvRmNLOStUalRXaTFYQjZOQ3BxaUxsSXpuVTdFWXh2KzVid3Fta1JN?=
 =?utf-8?B?ZVViMzZuV1VsNVFOUGNlMlY2eWNXS2VoQ3h5V29mdDVSc2llbUg0azcrdGN1?=
 =?utf-8?B?L2RFY3FjaC9lOGFWWFkrNy8yTW9pWXJVajNvaUpWRzR0UjlRUjVVbm11THBo?=
 =?utf-8?B?QmZSMWl2UWhJZkZZaW52YXpaQmwxMVJFY3FyQUFBdlNpMlc1UW5HLzV0S20w?=
 =?utf-8?B?Vlhwa2txNUZVTnhhcUZqQ3pRNi85NkhlWTBlVUdiYXltY3hOcWJDVTZpS2gz?=
 =?utf-8?B?MVlPV25UbXVJRlRLenJacHN3RUs3eHlZS3QxWkNhOGdHVFRBc3YxWnZvZGRC?=
 =?utf-8?B?U1VSdUtzZlgzNmt1ZWtoc3l4NDdZVzFJaUM0TEpzQWRsRE9CTDdHYkpTZXpC?=
 =?utf-8?B?a2hEcG9GMWNHbG0zSnBDRmNwZUJSOUhwQ2JCTXNwNjRTQVVjS29CejZ4VkdL?=
 =?utf-8?B?a1FmZDJyWHIxNTFaamlsMlBiNm1SRm53UWtGSXJQTGJMdW5ZUW1kcXdBS1ZE?=
 =?utf-8?B?MEJoajk1cDNHdUN1VHFhRVhNbDJiTWgyRnpabjFxd3B3OGZkVlRXNUNDM0Jl?=
 =?utf-8?B?bUE5S2c0VEJZVGRIbExPSXdxTTRXdS9yaTNTT2dtSnZJZWFRejBsakFOaTN4?=
 =?utf-8?B?R0p3NnJiNFBHaUtMRUJsQ0N2aDBzY3Exb0l2NkdJTEgyMEt1andpeXlyVjZx?=
 =?utf-8?B?S2J2aHQ3ZFJ4eWdqRW83czhiZy9nd0RpZ1pjU21kN3U1M3ZkbTBOOVorclFp?=
 =?utf-8?B?Wld0N0kxR2M2dVQ0TzhwanNCT3o0Ull4QlBUZjlER2hMYkxIb1JIQ0ZTUG1l?=
 =?utf-8?B?Z3Bhb1dJbExIbnBDQVh3S0xFcUMvQjZRenRoZDgzaVZzTHVvNDcySXJjVVk1?=
 =?utf-8?B?MXlZQlpTbVRBbjdhVllqaEZkSXpPMmFXd0ZmYTBzK1R1V2g1aHVzYzRVTy9O?=
 =?utf-8?B?dkpKZ24vQlV0bDU0ZnJDL0Vxc3VQenc5akJKeWU5UHVFUWc3bU5IOENHZ21z?=
 =?utf-8?B?dis3b252K2cybU9xREd4eEt4VzNPZk8vdmQ1MXFURmJHU3hRQWRFUGhMcURV?=
 =?utf-8?B?blMra00zUEJMOVk3NG1MMTdmWG5wbk5jRyswRTF2emdLcy84Rmp0a0duRHhs?=
 =?utf-8?B?dTE4dGx5bE1CVkpCYmlrRitRODd3THppamlJWVZQcDNYWHJqZ25NMGJmVTF5?=
 =?utf-8?B?cXRMZWU2K2lDdkRLNXFUVzhvV0FKMVNrV3JqQjBwT3R6bmZjditIeGFpb3Fs?=
 =?utf-8?Q?2sFsH+geVKXQiPUMvqMWBYrVdW93SNqruFiu4e3ICrwC?=
Content-ID: <12F8674CF6350D4DB366044C884075FC@namprd12.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3308915-30df-459f-f17f-08d9eba7f869
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2022 08:41:30.8769 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HNClqvQpXbjsaPltqNL2KOhA6d/l0eBjxcefl+wHjNgTNvnC9uP0mE6M2hr1ohLu0iDjLMnkBeefdpE+x6Duag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4910
Cc: Kelly Ursenbach <Kelly.Ursenbach@eideticom.com>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>, "Lee,
 Jason" <jasonlee@lanl.gov>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Logan Gunthorpe <Logan.Gunthorpe@eideticom.com>
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
From: Chaitanya Kulkarni via iommu <iommu@lists.linux-foundation.org>
Reply-To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 2/8/22 6:50 PM, Martin Oliveira wrote:
> Hello,
> 
> We have been hitting an error when running IO over our nvme-of setup, using the mlx5 driver and we are wondering if anyone has seen anything similar/has any suggestions.
> 
> Both initiator and target are AMD EPYC 7502 machines connected over RDMA using a Mellanox MT28908. Target has 12 NVMe SSDs which are exposed as a single NVMe fabrics device, one physical SSD per namespace.
> 

Thanks for reporting this, if you can bisect the problem on your setup
it will help others to help you better.

-ck
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
