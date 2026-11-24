Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.22
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795494706;
	b=pDuMHsF0LLcrNialPGBxqI0qXV87zKwCTHFvP4xp+WqUHBg43Ak6os+wgH4RgYi0qVYU
	 HkACV6KwvD4j0W7FYO/mP9XA0MwHWxBO+/hP8KkWk9JIPwz1NQWC11Ea27/liG2Oeaihl
	 T1dqxH8xRbt6z0nEGfmldYKnXGCPEZO8OWFuwbReAxC3nLwGfSDBK4f1eoVQUVgMvkHmE
	 f4Q10qhKZgxVgabpN3JiGiyPHC3z2sZb7mMvWlPF0bL0qs/3znJbjHlI38qxfEJOL25TV
	 2QPI76M2/cnWLj3kBaU57CwA006D6mGVsWlovuNVmjOYDhG2evFGtYi4usNRKRRoG2g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795494706;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=xwqth3F1a0+mWjF2a2eGYTbnhiR7+xKNrIokMnfTigk=;
	b=4jE8dN5GjJ9aXK81B9/GuTwXEs0Tyg3ZfL4tarvlQGHcrT3e15Sc2r4IV1/jAwIhgnM+
	 iNZ1Pa4NN68jVhUi8Dem3OZDmmgSv+6fO86/tqfjns+3GgzfqbIzPPi4NTDtf4ceVLNLd
	 o9CEXX+dbzP2ZnHS9ikdt6WEt+10SrX+rxfHsxdwl9eylopi0wgDYchw/wIbVW2UTijGW
	 DKJf/cK2iuLtHVZTsse2VqaFiLnbGGDKi6XzoX95V+zTBkTMs1k6zEWxsGbv0nkNSfSnm
	 AyJSSjvh9yu/Zi0atsPcT43V1NyV6z8pMFpoa20TgsHbwfmnOz0bp4L1jM57DK/Z28g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=101Z0k4d;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.22
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012022.outbound.protection.outlook.com [52.101.53.22])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF15606A327
	for <iommu@lists.linux.dev>; Tue, 24 Nov 2026 04:31:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1EF15606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=101Z0k4d
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CLimhIq2ACVSwAvP37LcdwCHYcMDOBnBm76Hkb2MFCct8gTmzNOR/GlEHhPUqeiat+eXrwcFTmU1FzNnRCs+bBEY+Zl4PNWJcvvkAGgJWpamJ1mOND91v3V3YQsJfAAgCENAxL0KwBv93QhJaN5bSVHmoZEJQCeZEHvduEz35HylJ466yN3tcoRqkEdqVCHbNRDyRMlACsMflOAdPZ35HxoCav4Dcxl36vJ4Nvzk/y1sjnRbnXu5f06D0IPRtTMWLLtY9Rs2Bgm0mLUlGFcq3Pa1+JeZl2Kw6IMclzbehX55OxXOPYRZ688F3ldTHweWZNpemfdxw9LisAO2+agdxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xwqth3F1a0+mWjF2a2eGYTbnhiR7+xKNrIokMnfTigk=;
 b=j4p5BN9spNNTxv8gihYS9J/OzCGIrOgNvf9rUaU4Od5c4/rvfxL0J+y1EPmt+p4lXsjg/8bSmech3V09epgNMKMkRKFtB8WiWWTkiqe9P+DvvcbN5eb0dYn6Rztg2Zc/z5Ky3HDhueACCgUk6wie/YeQsU1LjbPYqSZPonHAvJukABbgLmcIs2YD65Kaw4BWkVmGNX7nLuzYUcn6o4KJXoLvq3KTktqNcQnFi9Vqn2LYDtT89yTbkHejjyTjS8xJN1rczo/Pytq4JpR3bCWY/wbh7RSkytIySPd0PxpKugLRKfJxHQvQSxbSjsTpeDl1I+zQ/6AyXtRXJxWBWS7G6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xwqth3F1a0+mWjF2a2eGYTbnhiR7+xKNrIokMnfTigk=;
 b=101Z0k4di0KSAl8vBiodZ+7sFRm9lsrVrvOQWmBCLQJF8Mrwv0O97tht8EXTg+y7Uz+4XUbvtvZsMC/WqkXjm8x7Qd5azR0J6QYzQQfO6Td0sysgesliEtE7RGXX8SUoSs+hw7Xh7i6ZYCbpFjU4y6To1KhVZYCWj3VM7/LQzFk=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN7PR12MB6837.namprd12.prod.outlook.com (2603:10b6:806:267::10)
 by SJ0PR12MB6879.namprd12.prod.outlook.com (2603:10b6:a03:484::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Tue, 24 Nov
 2026 04:29:39 +0000
Received: from SN7PR12MB6837.namprd12.prod.outlook.com
 ([fe80::42e1:d1c1:d50d:b2d0]) by SN7PR12MB6837.namprd12.prod.outlook.com
 ([fe80::42e1:d1c1:d50d:b2d0%6]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 04:29:38 +0000
Date: Tue, 24 Nov 2026 04:29:25 +0000
From: Ankit Soni <Ankit.Soni@amd.com>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	David Woodhouse <dwmw2@infradead.org>, Robin Murphy <robin.murphy@arm.com>, 
	Kevin Tian <kevin.tian@intel.com>, Alex Williamson <alex@shazbot.org>, 
	Shuah Khan <shuah@kernel.org>, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, Pratyush Yadav <pratyush@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, David Matlack <dmatlack@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Pranjal Shrivastava <praan@google.com>, 
	Vipin Sharma <vipinsh@google.com>, Nicolin Chen <nicolinc@nvidia.com>, 
	John Starks <dev@jstarks.net>
Subject: Re: [PATCH v8 06/18] iommu: Implement device and IOMMU HW
 preservation
Message-ID: <i7i7msbox2idxet5xfzkf5zg2hoznnjpaivbpsjrpeoko445ys@trkpzp6zceqz>
References: <20261123044949.3610702-1-skhawaja@google.com>
 <20261123044949.3610702-7-skhawaja@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261123044949.3610702-7-skhawaja@google.com>
X-ClientProxiedBy: MA5PR01CA0023.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:177::15) To SN7PR12MB6837.namprd12.prod.outlook.com
 (2603:10b6:806:267::10)
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB6837:EE_|SJ0PR12MB6879:EE_
X-MS-Office365-Filtering-Correlation-Id: 01af1f59-1f75-4f77-ef9d-08df49e38c86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|7416014|376014|261026140227099003|261022105027099003|261022075727099003|261022113327099003|261026121527099003|261021121427099003|261102130727099003|10067099003|261021123027099003|261028144727099003|261102123227099003|261009223027099003|261009221227099003|261009223327099003|261009220027099003|261009221727099003|18002099003|22082099003|56012099006|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info:
	VYzCU7fyfcZq9DFvKhCEagbeGWxYLGHP3K7IH7bThJX7wL6mGc5r2G5Xsuj2peBxVsZDW4DOQPHu1/xDrpo4dEfTyBXEh143UwwvY3yFhHGbu3RKyohW26gj4E2Y92R0HJjJEcRhja5sJG+HEkIgm+6IujGTOPIMIN4WwcWM8smpebJwvaP0HbmWF76K7Uq2Kn9n5OYkL3AfE8xTb/LGW1zBx6wagidYBgjJ2rF9tExvXicUHGVwwyCS9sjTfBYghzIBcwLpJ/YscEGTsRYMEtXJtwvFa7SRx+hZt3nJMToWrR9JUZHWjvcJiFG8leqfjNqyDQv70hF4OyvToZ9/n1b3z04Ef94Bculj4UtrP/KD3IwrD1I6EOLt88QWtd5Pw2eOw2lMPHoBmZgGrqHMEcxuuUfJpsxFllyy4gk/+r8fp2FciMgFd0hW7SnCZLvAHbeYI8YYVBisZ3svErbTKKoD2tk36FhAktdBizyjs534g9siDNb1KaNgYkkDMEkqtdXALK4z1w7zJY8NRWaXRWYjqXcMykiDSaSzE3qCvNFWWK3W9q2ykFmro/36udNVziCJCB1rTEg1Baewrmpmun3tlsip9QZNo/H9uEDMp+n4GSZ/FBLbB67sVClE0wwOaM7S0QIE39FuOZpF5Lm5lTsNMtCylSnnXhsCWC8h+QM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB6837.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(261026140227099003)(261022105027099003)(261022075727099003)(261022113327099003)(261026121527099003)(261021121427099003)(261102130727099003)(10067099003)(261021123027099003)(261028144727099003)(261102123227099003)(261009223027099003)(261009221227099003)(261009223327099003)(261009220027099003)(261009221727099003)(18002099003)(22082099003)(56012099006)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MAkiM+ayhfLAt++50lrDpnR05bzRvr+UJdrBNc/ETyGDEMRmR6/gVWk9SGtv?=
 =?us-ascii?Q?QUE7kndZ9pCpccpQxjHro60iqrDOtg5Q9zOBbRuyVLpSp0BwYo1sB6pkhDED?=
 =?us-ascii?Q?f8coBKatZG4xex7eCRxl77DJ11Aefo2Y9InQpvJrSU1ClkUULEBSbEEC+7Gb?=
 =?us-ascii?Q?wJJzLIB231SPCTLGu9Bnswrpawrc4fyst74Sr2G6WyasiSA2Q5kTL6zfvn8A?=
 =?us-ascii?Q?x1fEOf+w2CUVv98WnRzrxir9k7tsLVYYHv+2nshashUsSEnjYSJpazrf7BeK?=
 =?us-ascii?Q?ke/W/v1bb+d6R/stE9YQ65iRw0EgtYl2U1KZErceDDLwaj3bBLqQSU+NN5GZ?=
 =?us-ascii?Q?aC1ISvqW2ew5KVBW858Ct+5S7bQiXykOo2ZzUuKxT31ZzNQ1b05EGoW3yRNv?=
 =?us-ascii?Q?sc+8W4/r0pBXl32WCZjlGX3OXcOBp4o4PMf9BPm4PXwS12ECkz93VIstdZ0s?=
 =?us-ascii?Q?s0wlo8Ug6omEnIzc/+Yev5I2KIZ3YeKa/9lW2LYHckkzWxVJ1mHAFsj9sL9w?=
 =?us-ascii?Q?ZIaacKEHLaBiLKZEiE0HECe3Shjuz4MAGr4/MQiL9KmEKkj82PC3m+DmiomM?=
 =?us-ascii?Q?uO1yPi3hYkHVTdYXnj3qWdbLS09mrEjouvkxDX1VFcijPYLd9/ovA8/QynaR?=
 =?us-ascii?Q?O4m1UHjjkzEkvsuIz0A3wCVvmqMlqFAE6WWUTba1c6LEwVDKldEQ8eifvfvG?=
 =?us-ascii?Q?zo+uP2KgNgOoIm+l2cDgPb6tfxXNAaV1WVj7HPzNe9n2Z1PmqH7kxDexOe2t?=
 =?us-ascii?Q?0o5qZW3FcL8HT+2oVrXKsXzU4kcDDCCDnPt9NHqzTVR5xMVdgTGO2azhgcNM?=
 =?us-ascii?Q?nGlGdAAmYOJ64O44NdaIreYOW5dkrfczN27Ci7eCmF7c7ORfbmGpH9L0bfx+?=
 =?us-ascii?Q?0X+BSZlR+Xfx56jNukDdy3VPl8Jwxogwgr06cATiowRgSgyfeOuW2l+b6GoQ?=
 =?us-ascii?Q?auki6dtb5vI72J8TF7YKRuYd5amVRT4rrKTe2KyACozma8nVTcOuK+2ByrN1?=
 =?us-ascii?Q?ZaOGE/cJUACgcNBf+TP2QAx13RYCh0vSxC1UNNc4Zy/AM+cHwXAai9UtFhun?=
 =?us-ascii?Q?+NFrYgv2Eebp324fqE2tWOXCuPWMPaOkZZKXu14XO1ToOnGjdTqg5GXtR4/S?=
 =?us-ascii?Q?N6UFPND8BpTQwmTcQpKZ36qHOeqkplkMbq5Gb9W82fAefzgzuHKMzNr1J+Qi?=
 =?us-ascii?Q?A02/wIpdAgnunw7aCmlLuYt5lutCCO4rBCea9jtoPU+P8zj8fVmg1sYx5NGN?=
 =?us-ascii?Q?LvpGlDrT1lgE1/oDW4ZR5aygad/b73ucSzP7GQyuhS3L1CZG/eQzgc+QigMm?=
 =?us-ascii?Q?UzpcY4l18/ZH2aCqowFcrkORmaPm6B14Y0pn1769/Blp5BgAe+3RXeZ/ngiy?=
 =?us-ascii?Q?zXcuS1tzmme1Ed5kFIWfoLHx52ZyQBIUcjfvkcDhTFYD4QzEqfPIIGO6I2oA?=
 =?us-ascii?Q?Oh90gsIy1bwPn6518J/vCVirEhO8V4uJhoGPfUvLUqSJt0SZK9zmJDNVCFOc?=
 =?us-ascii?Q?TwVW+7cw5sTcWLhgIIvx8bKZX2nKe+Os4pBVQO3H1O2GQezBdv2jOEItBhE6?=
 =?us-ascii?Q?e50lZbCjp8IYZQj7y37Xjp4qRasIEufywcksQlsaxm/u7pYJkqtoVV4DW8xS?=
 =?us-ascii?Q?0iJp0UEnxkZNLW4tEfH/rXiw6JNb/w2CIUeeTpWXtzEUxDT/v5lGwkkGQ0Be?=
 =?us-ascii?Q?FfzsDoJA8Qa0c9ramZlIgREhVl7gkyzFYUnk/9dfYXKwg/zXtw8U2m10vZ56?=
 =?us-ascii?Q?rl1u46qapA=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01af1f59-1f75-4f77-ef9d-08df49e38c86
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB6837.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 04:29:37.8630
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M+klbabwxP5vnoN6Mn6/iN7Z45y/Ar34BmapkVA7Losg4Mt/qvnY2L+mYEdvb7LEonpnCdGBvJB0hD2SLgVGbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6879

On Mon, Nov 23, 2026 at 04:49:37AM +0000, Samiullah Khawaja wrote:
> Add IOMMU ops to preserve/unpreserve the device state handled by the
> IOMMU driver. This is IOMMU specific state of the device that needs to
> be preserved for liveupdate. These ops can be implemented by the IOMMU
> drivers that support preservation of devices that have their IOMMU
> domains preserved. During device preservation the state of the
> associated IOMMU is also preserved as dependency.
> 
> Signed-off-by: Samiullah Khawaja <skhawaja@google.com>

Reviewed-by: Ankit Soni <Ankit.Soni@amd.com>

> ---
>  drivers/iommu/iommu-priv.h       |   3 +
>  drivers/iommu/iommu.c            |  58 ++++++++++
>  drivers/iommu/liveupdate.c       | 185 +++++++++++++++++++++++++++++++
>  include/linux/iommu-liveupdate.h |  76 +++++++++++++
>  include/linux/iommu.h            |  21 ++++
>  5 files changed, 343 insertions(+)
> 
> diff --git a/drivers/iommu/iommu-priv.h b/drivers/iommu/iommu-priv.h
> index 1f9f886b2c10..9b0b9d37ebea 100644
> --- a/drivers/iommu/iommu-priv.h
> +++ b/drivers/iommu/iommu-priv.h
> @@ -21,6 +21,9 @@ static inline const struct iommu_ops *dev_iommu_ops(struct device *dev)
>  
>  void dev_iommu_free(struct device *dev);
>  
> +int iommu_group_reserve_liveupdate(struct iommu_group *group);
> +void iommu_group_unreserve_liveupdate(struct iommu_group *group);
> +
>  const struct iommu_ops *iommu_ops_from_fwnode(const struct fwnode_handle *fwnode);
>  
>  static inline const struct iommu_ops *iommu_fwspec_ops(struct iommu_fwspec *fwspec)
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 8da858154949..f8837ab1b526 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -18,6 +18,7 @@
>  #include <linux/errno.h>
>  #include <linux/host1x_context_bus.h>
>  #include <linux/iommu.h>
> +#include <linux/iommu-liveupdate.h>
>  #include <linux/iommufd.h>
>  #include <linux/idr.h>
>  #include <linux/err.h>
> @@ -71,6 +72,10 @@ struct iommu_group {
>  	 */
>  	unsigned int recovery_cnt;
>  	void *owner;
> +#ifdef CONFIG_IOMMU_LIVEUPDATE
> +	/* Group is reserved for a device with live update state */
> +	bool liveupdate_reserved;
> +#endif
>  };
>  
>  struct group_device {
> @@ -624,6 +629,19 @@ static struct iommu_domain *pasid_array_entry_to_domain(void *entry)
>  
>  DEFINE_MUTEX(iommu_probe_device_lock);
>  
> +#ifdef CONFIG_IOMMU_LIVEUPDATE
> +static bool iommu_group_liveupdate_reserved(struct iommu_group *group)
> +{
> +	lockdep_assert_held(&group->mutex);
> +	return group->liveupdate_reserved;
> +}
> +#else
> +static inline bool iommu_group_liveupdate_reserved(struct iommu_group *group)
> +{
> +	return false;
> +}
> +#endif
> +
>  static int __iommu_probe_device(struct device *dev, struct list_head *group_list)
>  {
>  	struct iommu_group *group;
> @@ -661,6 +679,11 @@ static int __iommu_probe_device(struct device *dev, struct list_head *group_list
>  		goto err_put_group;
>  	}
>  
> +	if (iommu_group_liveupdate_reserved(group)) {
> +		ret = -EBUSY;
> +		goto err_free_gdev;
> +	}
> +
>  	/*
>  	 * The gdev must be in the list before calling
>  	 * iommu_setup_default_domain()
> @@ -697,6 +720,7 @@ static int __iommu_probe_device(struct device *dev, struct list_head *group_list
>  
>  err_remove_gdev:
>  	list_del(&gdev->list);
> +err_free_gdev:
>  	__iommu_group_free_device(group, gdev);
>  err_put_group:
>  	iommu_deinit_device(dev);
> @@ -3545,6 +3569,40 @@ bool iommu_group_dma_owner_claimed(struct iommu_group *group)
>  }
>  EXPORT_SYMBOL_GPL(iommu_group_dma_owner_claimed);
>  
> +#ifdef CONFIG_IOMMU_LIVEUPDATE
> +/**
> + * iommu_group_reserve_liveupdate() - Reserve a group for live update
> + * @group: The group.
> + *
> + * No other device can be added to a reserved group.
> + *
> + * Return: 0 on success, -EBUSY if the group is already reserved, or
> + * -EOPNOTSUPP if the group doesn't have exactly one device.
> + */
> +int iommu_group_reserve_liveupdate(struct iommu_group *group)
> +{
> +	guard(mutex)(&group->mutex);
> +	if (group->liveupdate_reserved)
> +		return -EBUSY;
> +
> +	if (!list_is_singular(&group->devices))
> +		return -EOPNOTSUPP;
> +
> +	group->liveupdate_reserved = true;
> +	return 0;
> +}
> +
> +/**
> + * iommu_group_unreserve_liveupdate() - Drop the live update reservation
> + * @group: The group.
> + */
> +void iommu_group_unreserve_liveupdate(struct iommu_group *group)
> +{
> +	guard(mutex)(&group->mutex);
> +	group->liveupdate_reserved = false;
> +}
> +#endif
> +
>  static void iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid,
>  				   struct iommu_domain *domain)
>  {
> diff --git a/drivers/iommu/liveupdate.c b/drivers/iommu/liveupdate.c
> index a98f16d11727..06234f9c604b 100644
> --- a/drivers/iommu/liveupdate.c
> +++ b/drivers/iommu/liveupdate.c
> @@ -43,6 +43,9 @@
>  #include <linux/kexec_handover.h>
>  #include <linux/kho_block.h>
>  #include <linux/liveupdate.h>
> +#include <linux/pci.h>
> +
> +#include "iommu-priv.h"
>  
>  /**
>   * struct iommu_ser_set - Set of serialized objects of one type
> @@ -358,3 +361,185 @@ void iommu_unpreserve_domain(struct iommu_domain *domain)
>  	liveupdate_flb_put_outgoing(&iommu_flb);
>  }
>  EXPORT_SYMBOL_GPL(iommu_unpreserve_domain);
> +
> +static int iommu_preserve_locked(struct iommu_device *iommu,
> +				 struct iommu_flb_obj *flb_obj)
> +{
> +	struct iommu_hw_ser *iommu_hw_ser;
> +	int ret;
> +
> +	if (!iommu->ops->preserve || !iommu->ops->unpreserve)
> +		return -EOPNOTSUPP;
> +
> +	lockdep_assert_held(&flb_obj->lock);
> +	if (iommu->iommu_ser) {
> +		iommu->iommu_ser->hdr.ref_count++;
> +		return 0;
> +	}
> +
> +	iommu_hw_ser = iommu_ser_set_alloc(&flb_obj->iommu_set);
> +	if (IS_ERR(iommu_hw_ser))
> +		return PTR_ERR(iommu_hw_ser);
> +
> +	ret = iommu->ops->preserve(iommu, iommu_hw_ser);
> +	if (ret) {
> +		iommu_hw_ser->hdr.flags |= IOMMU_SER_FLAG_DELETED;
> +		return ret;
> +	}
> +
> +	iommu->iommu_ser = iommu_hw_ser;
> +	return ret;
> +}
> +
> +static void iommu_unpreserve_locked(struct iommu_device *iommu,
> +				    struct iommu_flb_obj *flb_obj)
> +{
> +	struct iommu_hw_ser *iommu_hw_ser = iommu->iommu_ser;
> +
> +	lockdep_assert_held(&flb_obj->lock);
> +	if (WARN_ON(!iommu_hw_ser))
> +		return;
> +
> +	if (WARN_ON_ONCE(!iommu->ops->preserve ||
> +			 !iommu->ops->unpreserve))
> +		return;
> +
> +	iommu_hw_ser->hdr.ref_count--;
> +	if (iommu_hw_ser->hdr.ref_count)
> +		return;
> +
> +	iommu->iommu_ser = NULL;
> +	iommu->ops->unpreserve(iommu, iommu_hw_ser);
> +	iommu_hw_ser->hdr.flags |= IOMMU_SER_FLAG_DELETED;
> +}
> +
> +/**
> + * iommu_preserve_device() - Preserve device state across live update
> + * @domain: Associated IOMMU domain
> + * @dev: Device to preserve
> + * @dma_owner_token: Token to identify DMA owner of this device
> + *
> + * Return: 0 on success, or negative error code.
> + */
> +int iommu_preserve_device(struct iommu_domain *domain,
> +			  struct device *dev, u64 dma_owner_token)
> +{
> +	struct iommu_device_ser *device_ser;
> +	struct iommu_flb_obj *flb_obj;
> +	struct dev_iommu *iommu;
> +	struct pci_dev *pdev;
> +	int ret;
> +
> +	if (!dev_is_pci(dev))
> +		return -EOPNOTSUPP;
> +
> +	if (!iommu_group_dma_owner_claimed(dev->iommu_group))
> +		return -EINVAL;
> +
> +	if (iommu_get_domain_for_dev(dev) != domain)
> +		return -EINVAL;
> +
> +	pdev = to_pci_dev(dev);
> +	iommu = dev->iommu;
> +	if (!iommu->iommu_dev->ops->preserve_device ||
> +	    !iommu->iommu_dev->ops->unpreserve_device ||
> +	    !iommu->iommu_dev->ops->preserve ||
> +	    !iommu->iommu_dev->ops->unpreserve)
> +		return -EOPNOTSUPP;
> +
> +	ret = iommu_group_reserve_liveupdate(dev->iommu_group);
> +	if (ret)
> +		return ret;
> +
> +	ret = liveupdate_flb_get_outgoing(&iommu_flb, (void **)&flb_obj);
> +	if (ret)
> +		goto out_unreserve;
> +
> +	mutex_lock(&flb_obj->lock);
> +	if (!domain->domain_ser) {
> +		ret = -EINVAL;
> +		goto out_unlock;
> +	}
> +
> +	device_ser = iommu_ser_set_alloc(&flb_obj->device_set);
> +	if (IS_ERR(device_ser)) {
> +		ret = PTR_ERR(device_ser);
> +		goto out_unlock;
> +	}
> +
> +	ret = iommu_preserve_locked(iommu->iommu_dev, flb_obj);
> +	if (ret) {
> +		device_ser->hdr.flags |= IOMMU_SER_FLAG_DELETED;
> +		goto out_unlock;
> +	}
> +
> +	device_ser->attachment.domain_phys = virt_to_phys(domain->domain_ser);
> +	device_ser->iommu_phys = virt_to_phys(iommu->iommu_dev->iommu_ser);
> +	device_ser->devid = pci_dev_id(pdev);
> +	device_ser->pci_domain_nr = pci_domain_nr(pdev->bus);
> +	device_ser->dma_owner_token = dma_owner_token;
> +
> +	ret = iommu->iommu_dev->ops->preserve_device(dev, device_ser);
> +	if (ret) {
> +		device_ser->hdr.flags |= IOMMU_SER_FLAG_DELETED;
> +		iommu_unpreserve_locked(iommu->iommu_dev, flb_obj);
> +		goto out_unlock;
> +	}
> +
> +	WRITE_ONCE(dev->iommu->device_ser, device_ser);
> +
> +out_unlock:
> +	mutex_unlock(&flb_obj->lock);
> +	liveupdate_flb_put_outgoing(&iommu_flb);
> +out_unreserve:
> +	if (ret)
> +		iommu_group_unreserve_liveupdate(dev->iommu_group);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(iommu_preserve_device);
> +
> +/**
> + * iommu_unpreserve_device() - Unpreserve device state
> + * @dev: Device to unpreserve
> + */
> +void iommu_unpreserve_device(struct device *dev)
> +{
> +	struct iommu_device_ser *iommu_device_ser;
> +	struct iommu_flb_obj *flb_obj;
> +	struct dev_iommu *iommu;
> +	int ret;
> +
> +	if (!dev_is_pci(dev))
> +		return;
> +
> +	if (!iommu_group_dma_owner_claimed(dev->iommu_group))
> +		return;
> +
> +	iommu = dev->iommu;
> +	if (WARN_ON(!iommu->iommu_dev->ops->unpreserve_device ||
> +		    !iommu->iommu_dev->ops->unpreserve))
> +		return;
> +
> +	ret = liveupdate_flb_get_outgoing(&iommu_flb, (void **)&flb_obj);
> +	if (WARN_ON(ret))
> +		return;
> +
> +	mutex_lock(&flb_obj->lock);
> +	iommu_device_ser = dev_iommu_preserved_state(dev);
> +	if (WARN_ON(!iommu_device_ser)) {
> +		ret = -ENOENT;
> +		goto out_unlock;
> +	}
> +
> +	iommu_device_ser->hdr.flags |= IOMMU_SER_FLAG_DELETED;
> +	iommu->iommu_dev->ops->unpreserve_device(dev, iommu_device_ser);
> +	WRITE_ONCE(dev->iommu->device_ser, NULL);
> +
> +	iommu_unpreserve_locked(iommu->iommu_dev, flb_obj);
> +out_unlock:
> +	mutex_unlock(&flb_obj->lock);
> +	liveupdate_flb_put_outgoing(&iommu_flb);
> +	if (!ret)
> +		iommu_group_unreserve_liveupdate(dev->iommu_group);
> +}
> +EXPORT_SYMBOL_GPL(iommu_unpreserve_device);
> diff --git a/include/linux/iommu-liveupdate.h b/include/linux/iommu-liveupdate.h
> index caa9778eee2d..2d49885b9fcd 100644
> --- a/include/linux/iommu-liveupdate.h
> +++ b/include/linux/iommu-liveupdate.h
> @@ -8,6 +8,7 @@
>  #ifndef _LINUX_IOMMU_LIVEUPDATE_H
>  #define _LINUX_IOMMU_LIVEUPDATE_H
>  
> +#include <linux/device.h>
>  #include <linux/iommu.h>
>  #include <linux/liveupdate.h>
>  #include <linux/kho/abi/iommu.h>
> @@ -15,8 +16,58 @@
>  #ifdef CONFIG_IOMMU_LIVEUPDATE
>  int iommu_liveupdate_register_flb(struct liveupdate_file_handler *handler);
>  void iommu_liveupdate_unregister_flb(struct liveupdate_file_handler *handler);
> +
> +/**
> + * dev_iommu_has_preserved_state() - Check if a device has live update state
> + * @dev: Target device
> + *
> + * Unlike dev_iommu_preserved_state() and dev_iommu_restored_state(), this does
> + * not dereference the serialized state, so it is safe to call without holding
> + * a reference on the live update FLB.
> + *
> + * Return: true if @dev has preserved (outgoing) or restored (incoming) state.
> + */
> +static inline bool dev_iommu_has_preserved_state(struct device *dev)
> +{
> +	return dev->iommu && READ_ONCE(dev->iommu->device_ser);
> +}
> +
> +/**
> + * dev_iommu_preserved_state() - Get preserved state of a device
> + * @dev: Target device
> + *
> + * Return: Pointer to preserved device state, or NULL if not preserved.
> + */
> +static inline void *dev_iommu_preserved_state(struct device *dev)
> +{
> +	struct iommu_device_ser *ser;
> +
> +	if (!dev->iommu)
> +		return NULL;
> +
> +	ser = READ_ONCE(dev->iommu->device_ser);
> +	if (ser && !(ser->hdr.flags & IOMMU_SER_FLAG_INCOMING))
> +		return ser;
> +
> +	return NULL;
> +}
> +
>  int iommu_preserve_domain(struct iommu_domain *domain, struct iommu_domain_ser **ser);
>  void iommu_unpreserve_domain(struct iommu_domain *domain);
> +int iommu_preserve_device(struct iommu_domain *domain,
> +			  struct device *dev, u64 dma_owner_token);
> +void iommu_unpreserve_device(struct device *dev);
> +
> +/**
> + * iommu_preserved_state() - Get preserved state of an IOMMU instance
> + * @iommu: IOMMU hardware instance
> + *
> + * Return: Pointer to preserved state, or NULL if not preserved.
> + */
> +static inline void *iommu_preserved_state(struct iommu_device *iommu)
> +{
> +	return iommu->iommu_ser;
> +}
>  #else
>  static inline int iommu_liveupdate_register_flb(struct liveupdate_file_handler *handler)
>  {
> @@ -27,6 +78,16 @@ static inline void iommu_liveupdate_unregister_flb(struct liveupdate_file_handle
>  {
>  }
>  
> +static inline bool dev_iommu_has_preserved_state(struct device *dev)
> +{
> +	return false;
> +}
> +
> +static inline void *dev_iommu_preserved_state(struct device *dev)
> +{
> +	return NULL;
> +}
> +
>  static inline int iommu_preserve_domain(struct iommu_domain *domain, struct iommu_domain_ser **ser)
>  {
>  	return -EOPNOTSUPP;
> @@ -35,5 +96,20 @@ static inline int iommu_preserve_domain(struct iommu_domain *domain, struct iomm
>  static inline void iommu_unpreserve_domain(struct iommu_domain *domain)
>  {
>  }
> +
> +static inline int iommu_preserve_device(struct iommu_domain *domain,
> +					struct device *dev, u64 dma_owner_token)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +static inline void iommu_unpreserve_device(struct device *dev)
> +{
> +}
> +
> +static inline void *iommu_preserved_state(struct iommu_device *iommu)
> +{
> +	return NULL;
> +}
>  #endif
>  #endif /* _LINUX_IOMMU_LIVEUPDATE_H */
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 77f78c88c627..c44f7d1c8498 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -684,6 +684,10 @@ __iommu_copy_struct_to_user(const struct iommu_user_data *dst_data,
>   *               resources shared/passed to user space IOMMU instance. Associate
>   *               it with a nesting @parent_domain. It is required for driver to
>   *               set @viommu->ops pointing to its own viommu_ops
> + * @preserve_device: Preserve state of a device for liveupdate.
> + * @unpreserve_device: Unpreserve state that was preserved earlier.
> + * @preserve: Preserve state of iommu translation hardware for liveupdate.
> + * @unpreserve: Unpreserve state of iommu that was preserved earlier.
>   * @owner: Driver module providing these ops
>   * @identity_domain: An always available, always attachable identity
>   *                   translation.
> @@ -740,6 +744,13 @@ struct iommu_ops {
>  			   struct iommu_domain *parent_domain,
>  			   const struct iommu_user_data *user_data);
>  
> +#ifdef CONFIG_IOMMU_LIVEUPDATE
> +	int (*preserve_device)(struct device *dev, struct iommu_device_ser *device_ser);
> +	void (*unpreserve_device)(struct device *dev, struct iommu_device_ser *device_ser);
> +	int (*preserve)(struct iommu_device *iommu, struct iommu_hw_ser *iommu_ser);
> +	void (*unpreserve)(struct iommu_device *iommu, struct iommu_hw_ser *iommu_ser);
> +#endif
> +
>  	const struct iommu_domain_ops *default_domain_ops;
>  	struct module *owner;
>  	struct iommu_domain *identity_domain;
> @@ -829,6 +840,7 @@ struct iommu_domain_ops {
>   * @singleton_group: Used internally for drivers that have only one group
>   * @max_pasids: number of supported PASIDs
>   * @ready: set once iommu_device_register() has completed successfully
> + * @iommu_ser: preserved iommu state of outgoing kernel for liveupdate.
>   */
>  struct iommu_device {
>  	struct list_head list;
> @@ -838,6 +850,10 @@ struct iommu_device {
>  	struct iommu_group *singleton_group;
>  	u32 max_pasids;
>  	bool ready;
> +
> +#ifdef CONFIG_IOMMU_LIVEUPDATE
> +	struct iommu_hw_ser *iommu_ser;
> +#endif
>  };
>  
>  /**
> @@ -877,6 +893,8 @@ struct iommu_fault_param {
>   * @pci_32bit_workaround: Limit DMA allocations to 32-bit IOVAs
>   * @require_direct: device requires IOMMU_RESV_DIRECT regions
>   * @shadow_on_flush: IOTLB flushes are used to sync shadow tables
> + * @device_ser: preserved (outgoing) or restored (incoming) liveupdate state
> + *		of this device
>   *
>   * TODO: migrate other per device data pointers under iommu_dev_data, e.g.
>   *	struct iommu_group	*iommu_group;
> @@ -892,6 +910,9 @@ struct dev_iommu {
>  	u32				pci_32bit_workaround:1;
>  	u32				require_direct:1;
>  	u32				shadow_on_flush:1;
> +#ifdef CONFIG_IOMMU_LIVEUPDATE
> +	struct iommu_device_ser		*device_ser;
> +#endif
>  };
>  
>  int iommu_device_register(struct iommu_device *iommu,
> -- 
> 2.56.1.809.ga0b61035b5-goog
> 
