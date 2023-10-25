Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2051.outbound.protection.outlook.com [40.107.7.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C891DA5B
	for <iommu@lists.linux.dev>; Wed, 25 Oct 2023 15:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="cGsgmDvy";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="cGsgmDvy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ac6tAgThnwUoTXpT6dH0fSf4M5O/Gv2Td33A0mwXxaQ=;
 b=cGsgmDvyn2JCPF2p7Cnfyr2P58kY1vvp0co4FEO5llkIWPg+DCfGlSZkMrztPSO3Z+MSi9oVFtOomoi3F7WVyjFMEta57BhSYJlzQTagMUv/fulplojlGsJfp+cYkP+GaB5cg3f3r8bzv9J2S8mt2o6amXkYY5fuT2I7S0i+qqw=
Received: from AS9P194CA0027.EURP194.PROD.OUTLOOK.COM (2603:10a6:20b:46d::22)
 by AM8PR08MB6450.eurprd08.prod.outlook.com (2603:10a6:20b:317::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Wed, 25 Oct
 2023 15:11:49 +0000
Received: from AM3PEPF0000A793.eurprd04.prod.outlook.com
 (2603:10a6:20b:46d:cafe::b6) by AS9P194CA0027.outlook.office365.com
 (2603:10a6:20b:46d::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33 via Frontend
 Transport; Wed, 25 Oct 2023 15:11:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM3PEPF0000A793.mail.protection.outlook.com (10.167.16.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6933.15 via Frontend Transport; Wed, 25 Oct 2023 15:11:48 +0000
Received: ("Tessian outbound d9a8e74be042:v215"); Wed, 25 Oct 2023 15:11:48 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: ed5a77ce380fdfd5
X-CR-MTA-TID: 64aa7808
Received: from f4bec29366ee.1
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id 5A7ECDFA-9A7B-4B20-81B2-16CF7B4BA618.1;
	Wed, 25 Oct 2023 15:11:42 +0000
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id f4bec29366ee.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 25 Oct 2023 15:11:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dEVohUbqxup3npwr0e52ggubQrT/KqmjQ5o29m/SyVu2VCm1W/Zk6e/uSlBb6KP0YqyVz4FHV9diI+VrBFQcBqYDANs4Ebk4DMlFA2EBpLwUotL6r3va+jSu2a9vLirjUuHXl23mzLpaxDtNyd82oo0gLHYWrZmZklpYGwAgOXjJwklgQbJG7V0LrX0m089C+y+rFkVd0YgVMXbzz3W/f2tM47KZ+z+UqWmrx5ycfv1sO709ElbjSu+gN8lh3S9e3p36LtCKmErlVrDogzHlr5oXIiac/IOEiJXRiEfM0iOn4TeAldYK6fgVzNamFxb6MyGs04kegr1Tuchsf1n56g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ac6tAgThnwUoTXpT6dH0fSf4M5O/Gv2Td33A0mwXxaQ=;
 b=j/hUy7KdUyuRzw1f8tZP0YZ65ucDl/GMmOEn8iotwMhNGUpHwg4IEVOyjhqMpJjoQCtyutkd6cJWiTrE0owLnxQOBQXrYmCPj5Qs/hgHwjUcPTbP7tvetvqAs+triCJ5XGWsoi+YHXDVoYI1D/u1hzqzQ5WvjSiC132z6DdlmPRcfIaDfok66yXK2N3AxKtlVaY4/sarQcmSVqGA31SKFzScnqQ2r3o2srF/M+lfYzfVcEInla7djFfJt+/rtSBlWOhnlKDCPlbT8wk1OHLB1nANXphFC3DRMlxYVDoePrYfbK47wwOOUyRlDgLA2wX1PiFoKZJVSVeWtET3DTOWwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ac6tAgThnwUoTXpT6dH0fSf4M5O/Gv2Td33A0mwXxaQ=;
 b=cGsgmDvyn2JCPF2p7Cnfyr2P58kY1vvp0co4FEO5llkIWPg+DCfGlSZkMrztPSO3Z+MSi9oVFtOomoi3F7WVyjFMEta57BhSYJlzQTagMUv/fulplojlGsJfp+cYkP+GaB5cg3f3r8bzv9J2S8mt2o6amXkYY5fuT2I7S0i+qqw=
Received: from DBBPR08MB4538.eurprd08.prod.outlook.com (2603:10a6:10:d2::15)
 by DBBPR08MB5884.eurprd08.prod.outlook.com (2603:10a6:10:1f6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.31; Wed, 25 Oct
 2023 15:11:40 +0000
Received: from DBBPR08MB4538.eurprd08.prod.outlook.com
 ([fe80::eff9:51cd:788c:cdf]) by DBBPR08MB4538.eurprd08.prod.outlook.com
 ([fe80::eff9:51cd:788c:cdf%4]) with mapi id 15.20.6907.032; Wed, 25 Oct 2023
 15:11:39 +0000
From: Justin He <Justin.He@arm.com>
To: Christoph Hellwig <hch@lst.de>
CC: Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy
	<Robin.Murphy@arm.com>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, nd
	<nd@arm.com>
Subject: RE: [PATCH v3 1/2] dma-mapping: export dma_addressing_limited()
Thread-Topic: [PATCH v3 1/2] dma-mapping: export dma_addressing_limited()
Thread-Index: AQHaAC/A5SmqvDnr60Cv0UxHfdKNELBW7ouAgAO7NoA=
Date: Wed, 25 Oct 2023 15:11:38 +0000
Message-ID:
 <DBBPR08MB45389A8B34B3412F904126BBF7DEA@DBBPR08MB4538.eurprd08.prod.outlook.com>
References: <20231016125254.1875-1-justin.he@arm.com>
 <20231016125254.1875-2-justin.he@arm.com> <20231023060919.GB11907@lst.de>
In-Reply-To: <20231023060919.GB11907@lst.de>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic:
	DBBPR08MB4538:EE_|DBBPR08MB5884:EE_|AM3PEPF0000A793:EE_|AM8PR08MB6450:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f77cd6b-d79f-480d-7d06-08dbd56cb60b
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original:
 eLTk46SQqMf2p9xq7drjgxHnw0FlJvB7YRxgirGSSHDNd2+SxYCBsYwgZXhWiXEfKGNNSLN4DDQKOA7BCkAHOkORZDxYj96ICmnbwlA6R4GE+6W0fk1ZkbVGJyv1xNP9nAp8wYzqUO5ez8NhfY/zDajdH7F+v3BpoAP5ImxfeXf5cFoZr+iGrm7HcNAKnTVQdPE4ay1ZsDuj6e0qmTz5n07PnBicFPSedycTXU2u3CfosY5pQS0fck0pgGIfcNRzYWe4DdzQnDxKz9cFM114BAh3J+THqp1kGXVXIiUuPgLeCYUVq2ztf4nbxf36J0+6KgZVJl4rbbvs/FQqDvPqLQfYg3P4qgz+vLvQZZuQGBnp720qsquhBpqn2h4b07gUodF8avxcN5qIs01pgyKbVUGVoOtYlhoi0OyX4L32JqKgCa6UwL4vocLF97g5ZX/Rk+RVzAd2j5HHPyzSKDPxAFESn7EIOENv/9w4yQ1x6bdfwrBsJdKJ6cTrjDF9n28ueP394wFVgCq32duL5mtmeTlmU/kjpiW4t58cTt9B/yacxb7Tw7x6s7DjwonEjBpRWW8mQe/MSmY5CwfIQ0MZgmSnP4RFl0m8aEqK7CiX2DPK83KCII8eZqrLbRxYVWCG
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR08MB4538.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(376002)(346002)(39860400002)(136003)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(38070700009)(26005)(55016003)(38100700002)(122000001)(2906002)(4744005)(5660300002)(86362001)(4326008)(76116006)(8936002)(8676002)(33656002)(6916009)(54906003)(71200400001)(64756008)(6506007)(478600001)(7696005)(52536014)(66556008)(66446008)(41300700001)(66476007)(66946007)(316002)(83380400001)(53546011)(9686003);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB5884
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM3PEPF0000A793.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	7cf51d93-d166-4016-f8f5-08dbd56caff5
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	5XU+NALClmSbyhdUPICuErNn/Qq6nl6Rd2jYgAH7JtMlxi3GysOb1tYzEQCvkcbE5JtWTj3+H8UkRd4EzfY6/dRn6TANAFJvGHLG838RV5bHZW0prYaUTB9m77/Sm+tzvYTqTIN+26aDVkTpmd4C+OXUo4dvNgU+ueYK1S8Dlp7AoBsjUZM7iDXReI68LW6gSR3XmhQMUjZpfy1nCMAEqxZWmpc/kiY8Lza/mXOypiBcbx/ITgLYD0dUDRG1JMzz363NEjXpzunZ99zd+e5z6Jl7/EHSWMhSZ49tQvnTEq8H1TIYzLdboQ78fXa+1Su3Z91VFBEyBqnP+dd4BKdsx6PqLxQqs1hIkrYQv2sCedWTIvvYIEmxjETKFiu5o9PHGeU3CoAXRRksP+ZLpxffrloAa1rLAPe3l86Je39bJIgZDBmPdac59uqo4cndImYdY7rMSO38R0YFb+OmxETQtT45hLBxwOC/JwHP2nGyeu+GAiDh7AMQYFIJ+lr0cIfmPecDJlJDrnHPMWWrmMSTKOCnR1nesZf4odSTDlVF4mKpTxHzDldp39neLFyCuVIlNLrsX8NRX+zAx4JOyYL4h6MpUT619zwBzbB3cHmBO3v9yljKyV3sCYOu13ViCSF+T3X5NeT7gupRGW3wECnItkKInjDdb9CHzGBdUTzccQbgn5981y9HyElRd7D5AJD+tRW14pGMDo6XGMcD54Z+7q2c3xHd+YLEeDgwXLgWTvZcW70tcxMd4B9neXozMQ0c
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(346002)(136003)(396003)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(82310400011)(46966006)(40470700004)(36840700001)(40460700003)(52536014)(41300700001)(40480700001)(55016003)(53546011)(7696005)(6506007)(478600001)(9686003)(70586007)(70206006)(54906003)(316002)(86362001)(33656002)(36860700001)(47076005)(336012)(26005)(82740400003)(356005)(81166007)(83380400001)(8676002)(8936002)(6862004)(4326008)(5660300002)(2906002)(4744005);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 15:11:48.9978
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f77cd6b-d79f-480d-7d06-08dbd56cb60b
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF0000A793.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB6450



> -----Original Message-----
> From: Christoph Hellwig <hch@lst.de>
> Sent: Monday, October 23, 2023 2:09 PM
> To: Justin He <Justin.He@arm.com>
> Cc: Christoph Hellwig <hch@lst.de>; Marek Szyprowski
> <m.szyprowski@samsung.com>; Robin Murphy <Robin.Murphy@arm.com>;
> iommu@lists.linux.dev; linux-kernel@vger.kernel.org; nd <nd@arm.com>
> Subject: Re: [PATCH v3 1/2] dma-mapping: export dma_addressing_limited()
>=20
> On Mon, Oct 16, 2023 at 12:52:53PM +0000, Jia He wrote:
> > This is a preparatory patch to move dma_addressing_limited so that it
> > is exported instead of a new low-level helper.
>=20
> So while this exports dma_addressing_limited that's really a side effect.
> The primary thing is that it moves the function out of line.
Ok, I will update the commit msg.
Thanks for the comments!=20


--
Cheers,
Justin (Jia He)


