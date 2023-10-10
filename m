Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2058.outbound.protection.outlook.com [40.107.21.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB955C12B
	for <iommu@lists.linux.dev>; Tue, 10 Oct 2023 08:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="4n0vPzch";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="4n0vPzch"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WReaLO+Bi+jdCyBSatO7f9CiKs04Ra4x58t14cbjXqU=;
 b=4n0vPzcha5qH2U93Fdx2Fy5yrL/Ar/N25l13qLeIYtVTQIvJfwbyGqzaDtGno3vsRLu/gARKqKY9Rzd8l0V2vTwBIWiPabf+3JS1XXFtUQzezxmrZmmoxAt531AymsgvSiVIh+hgi2QrZhP2B4Zhzgtf8AkSgZeS2zjgALhu49E=
Received: from DUZPR01CA0342.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b8::26) by PA4PR08MB7642.eurprd08.prod.outlook.com
 (2603:10a6:102:260::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37; Tue, 10 Oct
 2023 08:42:57 +0000
Received: from DBAEUR03FT062.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:10:4b8:cafe::9c) by DUZPR01CA0342.outlook.office365.com
 (2603:10a6:10:4b8::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37 via Frontend
 Transport; Tue, 10 Oct 2023 08:42:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DBAEUR03FT062.mail.protection.outlook.com (100.127.142.64) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6886.23 via Frontend Transport; Tue, 10 Oct 2023 08:42:57 +0000
Received: ("Tessian outbound d219f9a4f5c9:v211"); Tue, 10 Oct 2023 08:42:57 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 631310271321bc19
X-CR-MTA-TID: 64aa7808
Received: from ddca825836c8.2
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id 74B6B72E-0817-479C-BD8A-AC15810308F4.1;
	Tue, 10 Oct 2023 08:42:50 +0000
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id ddca825836c8.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 10 Oct 2023 08:42:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OMRxI+Jt2qj+huRRZXGOyfllEApI5ARv2lxMl1EsZF3MEbRFzylsmdVyAITonJevV0m52BtTRR19bFLjQ9OpkcWxxPy0/1itepXA2N/rZXUp6LP5Jk7zElOpC2835wVE6TbTPdCEwXEmvzH7ILrlcivg5aaAZ6Tr1Mx/bcxTe1HBVQkByjEHDb0e8DD6lpOqi7P1RmV2Pwd30oIjiWenA6IuWUisnACZVu5KZ/IwgrWC9XGJWD1Z5dCGQc6d29Fyk0SlOag2tX0L37DkZ65u9M1B+2u9pwvHyR2WDdaZwikwDnNuv3I0meN25NPBkC3M48gblDM67epOpgueecFMBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WReaLO+Bi+jdCyBSatO7f9CiKs04Ra4x58t14cbjXqU=;
 b=G7nv0wKAmWjk/MOBjeaZVWvXJAfZjr7jwnI0NYTeUZ5M0OiUjY6SWx6IYhrSEMrGtx1Z1rIvxtyhtNQcu3pL+os51izh7xyajTM8yIA4b6du5ion376qhJzkrvzHaGgv/cWuwLfXe8mlGyKGZux+VK3k7ZMRk96oSby2n3JahB+zfOm4FDCwclpYtAdfD27h4MDsQiBxa3y8TSsqQgQCiggIuGoFU/pv475p4aCfvkklK+uqz6CtiKGCJrdtvZE5zAyXF6ROvRiqv17zgXqkGSUntyn6bdUZq7zWQVtJ2O72BpZajgKUNH9T+b2SJsecDBQSmAB/JiWq1oV+PH+qMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WReaLO+Bi+jdCyBSatO7f9CiKs04Ra4x58t14cbjXqU=;
 b=4n0vPzcha5qH2U93Fdx2Fy5yrL/Ar/N25l13qLeIYtVTQIvJfwbyGqzaDtGno3vsRLu/gARKqKY9Rzd8l0V2vTwBIWiPabf+3JS1XXFtUQzezxmrZmmoxAt531AymsgvSiVIh+hgi2QrZhP2B4Zhzgtf8AkSgZeS2zjgALhu49E=
Received: from DBBPR08MB4538.eurprd08.prod.outlook.com (2603:10a6:10:d2::15)
 by PAVPR08MB9603.eurprd08.prod.outlook.com (2603:10a6:102:31a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Tue, 10 Oct
 2023 08:42:48 +0000
Received: from DBBPR08MB4538.eurprd08.prod.outlook.com
 ([fe80::4dfd:1da:8b2d:1afb]) by DBBPR08MB4538.eurprd08.prod.outlook.com
 ([fe80::4dfd:1da:8b2d:1afb%5]) with mapi id 15.20.6863.032; Tue, 10 Oct 2023
 08:42:48 +0000
From: Justin He <Justin.He@arm.com>
To: Christoph Hellwig <hch@lst.de>
CC: Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy
	<Robin.Murphy@arm.com>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, nd
	<nd@arm.com>
Subject: RE: [PATCH v2] dma-mapping: fix dma_addressing_limited if
 dma_range_map can't cover all system RAM
Thread-Topic: [PATCH v2] dma-mapping: fix dma_addressing_limited if
 dma_range_map can't cover all system RAM
Thread-Index: AQHZ+x6+h/4wKq8NfEOap6kHBNK73LBCpgQAgAANcwA=
Date: Tue, 10 Oct 2023 08:42:47 +0000
Message-ID:
 <DBBPR08MB4538F40E9499F1450C32AE0AF7CDA@DBBPR08MB4538.eurprd08.prod.outlook.com>
References: <20231010020835.3678-1-justin.he@arm.com>
 <20231010074816.GA9082@lst.de>
In-Reply-To: <20231010074816.GA9082@lst.de>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic:
	DBBPR08MB4538:EE_|PAVPR08MB9603:EE_|DBAEUR03FT062:EE_|PA4PR08MB7642:EE_
X-MS-Office365-Filtering-Correlation-Id: 902893ad-5966-4c9a-05b4-08dbc96ce739
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original:
 0UFrp2oxF5HsvIqw0hR5GM1MYKqsjTuT3VXw5UQXhG6O/RsyCN7Io8ySyyyr1xlcJevujpj8pzkA89soBh5gxNnjaxtDSlGpN0lp7CjSjcwYDYAoK40UciNqYnPL0dDq7XB0sLekLq5ERZamgdMsasp4xKMq2iphv3hvFbpv0Un9EQXV4anryG5Pk5ZYlxHIUdheWFQ4UUFffIuPeo9NHJDyFvqhGwue0eEEqurvxnJdU3lTE9Ku0hXUBPPKdA0xCUylzcKL1OwYyZVVv/u9Rh95Ntzk7w0Cs7luwmiHVMuyWeLBl/xhizEj6wwGI9+FwrQwIpoY/XvfN5fWzS4axWdO1HxFpqf1v/y5beyh+Yf6pqKTtdd1DHHqQJVFXs8qa5JHv/TaEzRLsU9E/aiwi4kqr7tyWcWj2ScSh1Aw1b9IWJF5Vz5BN04JhnV7PatPDMMph6N80sizeT77kUC3DpLoRaQC2BqV9RHz+O/OeXAh69JFdMB4diLTJWykSDEWJUNbE0itFiN5NELnP6GUl1bLUEqCsJzvPsDoZCMv3hIFc5Bpb2mzpccKyvYqFok8ly2OuRZFTvHsJVXpfbZZVaxKPDLVDBQnt4PTvh2Hl9D1SNZ5uCKu1PJnxx8LB7IL
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR08MB4538.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(136003)(346002)(376002)(396003)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(316002)(66476007)(66446008)(66556008)(66946007)(6916009)(64756008)(54906003)(38100700002)(41300700001)(5660300002)(76116006)(4326008)(8936002)(8676002)(52536014)(4744005)(33656002)(86362001)(6506007)(83380400001)(38070700005)(53546011)(7696005)(122000001)(9686003)(2906002)(71200400001)(55016003)(26005)(478600001);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB9603
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DBAEUR03FT062.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	2d3befc4-472c-40a9-de34-08dbc96ce126
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	waDuFbL9KojQfFKLDd80XBgJZ98R9d81v4+jHRiCFX6dDGgrVTTwMxdJMAIHTGULMyygyPy5ThTNalBe2IfMOWKlLQ2qCygGYSNldd92CBu6a0fTQ0QMSqNK/1Lc7nQid8EGl3wDH3GBkBL/OHyCnXWTvP9QzqZ5uVCsNrhrtqPxD4lJ6wW2HXeA+5toCTr/vKKEiE1yG8LwUYq9p91jMHf4Vv/62duCJzan+uPZuyThRFZWB+d9gG9tdFqzxqvdLF2mUik3gXdDx8dKmP7x0/gpjTMrVclYLzJPvVvCQ56hszQPRrSZjjvczJmFEpsQdCc6MQh3Wi0qtYYOviTQ9tE/USRTxBvFg3po7kdwiDBgySpzLwRcjuWTwNr0PePYzFOFydZ0lgKB/1ZfLAt7kfZD7wgswUFFFrcYcNLeMuJ0IQGtxGtp7FyYsZyeyPYoJWZZ4kpLdtrAj47MUB7mOPDS1OVkeJ40ib5UjKfMuz5gL4d1BDEisBgmu/JZnfeBZU8jBUmYeqGA4M1+OpLWuxoUjZa+hPfalKySOJKiSUHHgaKv07Sb5+jjiK1o29OXU+xPkwgStBVwY6b8mPTrahqwAt1m01+9ziQ2GVZWOSHo/Wwre60WoAdGK3ZIj8tKxpU4Q1yPmQON4GrVH9fq5n5GcOpQ29WAbKY2dtAtXv2IQvs8y3UKTkBmplTZH8JlwxQryx4jO4JrCQ2LlbAF07BB7Sze9dMesyBcVueB8IComZemuwR7Y4ti51JEBU6e
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(136003)(376002)(396003)(346002)(230922051799003)(186009)(82310400011)(1800799009)(451199024)(64100799003)(46966006)(36840700001)(40470700004)(9686003)(336012)(26005)(40460700003)(53546011)(81166007)(86362001)(40480700001)(33656002)(55016003)(82740400003)(356005)(83380400001)(4326008)(4744005)(6862004)(2906002)(47076005)(8676002)(54906003)(7696005)(36860700001)(478600001)(6506007)(41300700001)(5660300002)(70586007)(8936002)(316002)(52536014)(70206006);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 08:42:57.5825
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 902893ad-5966-4c9a-05b4-08dbc96ce739
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DBAEUR03FT062.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB7642

Hi Christoph,

> -----Original Message-----
> From: Christoph Hellwig <hch@lst.de>
> Sent: Tuesday, October 10, 2023 3:48 PM
> To: Justin He <Justin.He@arm.com>
> Cc: Christoph Hellwig <hch@lst.de>; Marek Szyprowski
> <m.szyprowski@samsung.com>; Robin Murphy <Robin.Murphy@arm.com>;
> iommu@lists.linux.dev; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH v2] dma-mapping: fix dma_addressing_limited if
> dma_range_map can't cover all system RAM
>=20
> dma_addressing_limited is called for every dma (direct) map, and this new
> code is way to heavy for that.  We'll need to cache the information someh=
ow.
Yes, maybe a flag is needed to set to true once the heavy work is done.
Hence, the flag should be set to false when the SYSTEM RAM resources are ch=
anged.
Let me check all the cases.


--
Cheers,
Justin (Jia He)
