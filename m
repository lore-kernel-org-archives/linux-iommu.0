Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2048.outbound.protection.outlook.com [40.107.20.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7047E
	for <iommu@lists.linux.dev>; Mon, 19 Dec 2022 12:03:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dG+UNBBLrTSYv5guvZ1Mm7bK6XYakwE00XRqgnRun2TuV9cA4kSaNmOqzZpdZl5ldHRta4L5diqauDU+EnT1sgLOlrGDEs2/J8UrBuf6wjm258Ws5LSgjJtBh6UQFx0BrmE01k4zlih59aDTWwlxAQVdyOquwXr6AMFCbd7adi84EnJqUjBVRr5ONkbrC8Ii1pxx26fY64Z017sKEJfu8YbnPao2cssCzillFDHmva/jYjk9k5BjEQScp8ItJM09abNOAEcmlTOtZurYB9EClUTLti7yYYVNEKswY3RJoyLU0IxYEWAHfumlVqz5Q+CBg0qub1y44mQrW4TvF0/xbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T0rn+qTVu/0JLw53ON5WONKkEvwqFBo3pSZmXrsK9Bc=;
 b=Xx3zFeCQe+1fKE9L2IGDhttSLGstQ10smvmt78toqsQuPUr/L0IZudUa/YJFhti2Ht6ajXO5KIDoc44PRAkVrvITGpP+QZz4vj7wCiFKqcHrdSFA4ZLbuBf0cAWDpDgfqKuZQA/rwPb/4KpTX+Arw5uR/ieC9BV6dfsbH/xWl9d0bUKjKjPSG/sbcJIM9WFoqSqSdepj3n2u8btGSsqQ7L7Fqn+pffgq700+74AMHE9cchJJb18uR1E760FIDZbjBsA0fE9BQgHF1CDLkbA5VPnAmbuteJ4p8w6ZE8TmPwK1sGpBIoCsCyiNYcsNcs5fBmDazfimNTq9pyBY5EuxHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T0rn+qTVu/0JLw53ON5WONKkEvwqFBo3pSZmXrsK9Bc=;
 b=ps5D3CtoP1BfyrBeE4Nx0HsKskpfMWC5+RqEpsGJH7ncFfJViOe8cFzNV+Ddkrn0egDpBY+o+bCTSTaCvydcOwQb5TVH/r0XgWlMgMfWmmK+KJrD+TadKXZ0j/Ap6mfEMewLqhqmiCnufbPntRH4oeE0pmLAipk5xwGxchXyrUc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5136.eurprd04.prod.outlook.com (2603:10a6:803:55::19)
 by PR3PR04MB7305.eurprd04.prod.outlook.com (2603:10a6:102:83::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Mon, 19 Dec
 2022 12:03:15 +0000
Received: from VI1PR04MB5136.eurprd04.prod.outlook.com
 ([fe80::7c13:ef9:b52f:47d8]) by VI1PR04MB5136.eurprd04.prod.outlook.com
 ([fe80::7c13:ef9:b52f:47d8%6]) with mapi id 15.20.5924.016; Mon, 19 Dec 2022
 12:03:15 +0000
Date: Mon, 19 Dec 2022 14:03:10 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: will@kernel.org, joro@8bytes.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] iommu/arm-smmu: Report IOMMU_CAP_CACHE_COHERENCY even
 betterer
Message-ID: <20221219120310.hf3343kmzovuvxw3@skbuf>
References: <d6dc41952961e5c7b21acac08a8bf1eb0f69e124.1671123115.git.robin.murphy@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d6dc41952961e5c7b21acac08a8bf1eb0f69e124.1671123115.git.robin.murphy@arm.com>
X-ClientProxiedBy: AM4PR07CA0032.eurprd07.prod.outlook.com
 (2603:10a6:205:1::45) To VI1PR04MB5136.eurprd04.prod.outlook.com
 (2603:10a6:803:55::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB5136:EE_|PR3PR04MB7305:EE_
X-MS-Office365-Filtering-Correlation-Id: 61c45f4b-4c85-4cd1-9160-08dae1b901f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3LZOkHfMszAHLkKvfaddZQCfbs9kDxBSfm1mXo8R/r7w7MWPMfhEOQXeRCF2anUiqVY0PVt9onb91Ys6e82bMUvmdj32XG/m4g3CJfaZ6Bydcil/pBwsyc212lSYavk7wycxJT8XuBPn4GULdSBh6QWg5LN8Iik0uLqZyMsEBp4s2vaKqtE+RiyyHRFO4hMWrjyhw2CPvAm9Nzo4RlbRsowYG/QKa2WBcciwe2YUtVSpSZaUhmooRnsKW1MAVGSTQMK2MOsuiBQE5suML1Uwy0u+KzztOLKZtGQcEZJ1eMZW1OjzgpcR3vv6j+xqWTQPSj3TiJrCrmyGGAJlgLv6M73lOTKhPrWA2EdBzHB8AFbjWNoKeO2bCuxr819S82xcFQnxjIL3kITwex6ilj4STUyNCNwilLJEbVx48MGAhtkim37Fg/zzoYLA+JAcvzaCP9hMbyDIxr1grqkRNFjEOPjOaZlRrdI6ppnl/vTjvvCZgGXgozTDdut5CufF+bG4UxUNQpYxorwtIfDEtYllzCMas1mvHxzN0o6L2stZTKc4dzNzi0IzSydxtVhub/iMhRnBSpA1odaintDBO9abbF8+pkcBW1plApXKird/vg5KaCrfAiqZm0tGmNIlmXmo32ccu1OtxdLul7RxFL2oRQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5136.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(4636009)(366004)(39860400002)(136003)(396003)(376002)(346002)(451199015)(6666004)(6506007)(6486002)(26005)(9686003)(6512007)(316002)(478600001)(6916009)(66556008)(2906002)(66476007)(4326008)(41300700001)(8676002)(66946007)(1076003)(44832011)(83380400001)(5660300002)(8936002)(186003)(38100700002)(86362001)(33716001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OZxLUAN3o21CovLaRcB3Uecg8wgAkpzFPimfu4bDV+L5v1tNVkaBBcGQEEuh?=
 =?us-ascii?Q?K5fANpnH5NHTRivh1411QaevXvzlQWq+ozLHnrx9cthnFtgiLw8oxNzeA4Pz?=
 =?us-ascii?Q?7oO+yLV8SOreSlIkgO26DrmCYgEAz/99oUmrO1mWkfEFTDGf7xvDMzEE2y0c?=
 =?us-ascii?Q?a8P7sO5rM3FJm4md6EHtkMtdI2lyvZ/UYF9HQU1tZCKqJ/jjx0qTw1ks7iJf?=
 =?us-ascii?Q?j+nJ3MdYcHrkFz+xQp/REmCsxDJkDaNKB78bypMBbG8Zbndn5FG6kx1KHLik?=
 =?us-ascii?Q?8OQzxNnnjkaSFoJY7/REDEbddriqCEQ4zOZiVgJyouN/apjDP6e3cdjkTy+I?=
 =?us-ascii?Q?r5vhYbF1V3v9QLB7hP+I/OD/HoaNEqKG8ucTgiqCpUxRGSCTibAO0XTd4sYF?=
 =?us-ascii?Q?3CAWHwEds+irwdcoDMim95LZQJthK7/RsSpbCqLgL3DG0BtQbIr1ParKpK+i?=
 =?us-ascii?Q?sxqLfr8h8TmO2PrWLX6GScDCkEdluS/IBy4uBX+Sbj80yncMS0RcSpl38enA?=
 =?us-ascii?Q?qRc/Tknz8QNBKQTR6zE2duimB+qmpOYy+xZ9vYzUx+6mqDqC2qs8zJP/BQml?=
 =?us-ascii?Q?MHTWCy/KrUTHQWNGoYB5r+M0RY1Br2WaYo8iIytkREMlj/9c0PPVeDRyzqdp?=
 =?us-ascii?Q?c2KMNM9KpOfFQG8w49PEdUCw01l8hSfx/ILaKDxYNfzBgT2ZPXTK2lREoVME?=
 =?us-ascii?Q?3DVsyGbgPzsnkZvostMDK7L8C2m9pMsY+ns2tvx4XrD8rvuvrz51VOXrEGOA?=
 =?us-ascii?Q?60xvdR17mHZx9CVsDNY93FAbS6XwSCBDrjXASEO/TP6RFgTzW66KHbjf9HIQ?=
 =?us-ascii?Q?DbLisPXS2+JNyn9dAAXMzfoq2XSkzgBlW0ktBQTBOkt0psQaWG3/Kwnx60jx?=
 =?us-ascii?Q?IiDNtfF0FAiq0VIIBcijjPKWEwZt+c+YeAL60fCvx76N+lqnf7sE78zhpNrs?=
 =?us-ascii?Q?pykUT4fBHhh81N2eder9gyErsRyjspMTXMO0ifDQxprIfhVIldhkKpzsmNIn?=
 =?us-ascii?Q?oTkNHSAaZ+/lH0TUV3k69iaAPKr7BEDRG9MYSuhJvlzwrj4p/VhU+4MzpZpr?=
 =?us-ascii?Q?Y0RwXb3YCcthffksX+yMeFJfR73ujkX/RzJ4wnQrmAiMwYuXiGxUvyNX6Q5b?=
 =?us-ascii?Q?PniPq5G+EhKwlR6k8e4xANOHRzJc3rPMLxOUYEh8+MKPSEBa3LiIZpUo7fLb?=
 =?us-ascii?Q?3tfzLV+2CKYjnNNDk0UkXYjj0bQbeI5WST5g5JQSVeA9x/bDLvRrp4ENuzcb?=
 =?us-ascii?Q?ksSa3oqf+BdbaZPxIQqxE8XMR+Namkw2iwb5TZD3mIXH4dmZK3d+q/lZRL+T?=
 =?us-ascii?Q?WuezBcjcWUMHrSTsL6ULnKGhbaIPQKUplMNG8Vk9/qW0y1pnI4Ba8eySz3xZ?=
 =?us-ascii?Q?bUyU7C/10GA/QlWoAjhpKJ2D8CDfV/vxAUgJT+dJFoSM+op2LNJBy/zvqhNq?=
 =?us-ascii?Q?shWWaG41t8claNi3bZBYGtcvVg7iJJslMLPB0Pc7mF0fCecot5kwsT20TUis?=
 =?us-ascii?Q?QHpmuawDJ74wh/yoQ05GWHRNGvfOg/Qvc69+VY3gMx2P26Dg5NkJ8XZ8o5pw?=
 =?us-ascii?Q?EtyGwJiupSMJLVEmG4JhnqcT0yFJDjoV6IjucS3impv50FezNawHCe14CU9l?=
 =?us-ascii?Q?EA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61c45f4b-4c85-4cd1-9160-08dae1b901f0
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5136.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2022 12:03:15.7056
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wvc7olfiSFgvLPV/SlEZTW9HiD8tpRcxie3x/EAiu5DQyThOvd/IhWsvku7JofNX4EI40lcJr1OvH/YYWJJ1Uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7305

On Thu, Dec 15, 2022 at 04:51:55PM +0000, Robin Murphy wrote:
> Although it's vanishingly unlikely that anyone would integrate an SMMU
> within a coherent interconnect without also making the pagetable walk
> interface coherent, the same effect happens if a coherent SMMU fails to
> advertise CTTW correctly. This turns out to be the case on some popular
> NXP SoCs, where VFIO started failing the IOMMU_CAP_CACHE_COHERENCY test,
> even though IOMMU_CACHE *was* previously achieving the desired effect
> anyway thanks to the underlying integration.
> 
> While those SoCs stand to gain some more general benefits from a
> firmware update to override CTTW correctly in DT/ACPI, it's also easy
> to work around this in Linux as well, to avoid imposing too much on
> affected users - since the upstream client devices *are* correctly
> marked as coherent, we can trivially infer their coherent paths through
> the SMMU as well.
> 
> Reported-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> Fixes: df198b37e72c ("iommu/arm-smmu: Report IOMMU_CAP_CACHE_COHERENCY better")
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---

Tested-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Thanks for the help!
