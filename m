Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2077.outbound.protection.outlook.com [40.107.243.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05023443A
	for <iommu@lists.linux.dev>; Mon,  7 Aug 2023 14:08:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q5uxDbKNWgsh9GNam7h33kHAW+7Hh3WcvhA7aKTnHv+5K6ky2nxOF+xMS1JnnWxeeaiPPnr0pegzrGmgKZJk4/So096dxi0wByvhXAQvisxqDQXL4VZnv/Qwk7E3Xm2p7Ni3goKXTMuntUZLi2GxtHbXxOS/ndGYibirZ2pNLZM+OFedK7rlTukEbC8PY8ngIWuYt0Frpz14hpjLxC62wpNSqBvd8wJkBe9RA+jf27l0LkIUgdqYfCSyUUadq3aMNsgjLs+Z+9x4ysrxh2uo8bjHFaZxXE0Ru4EKf1rzFMyoOwMXHQfaHshRZNUbJ8+9U8CBDuXG0TW5zrKY4f+qeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v64TIbDLM1vmrlms1AJSzwct5CHB40gTDgOjmGqV3wE=;
 b=TPjiMrBDFYvpFLRj/dQ8gxEI99H48kyxtTt54aFswKHvTxMQFVj+H5qBZ1fdyIXoPUajVvfrcO/b8qQKx5rpM6QKCXASkny8wCNz7eZQsMIOUGxzIYpjQFzA9t7ktka+iGRjV03nBcA9dOotgd33tTZEu+bZy/d0duxktuooRC75OO0JJWYW4it8huh0hQPkTFePePasLCFmKq7Yena1YoxS+V1VRTPbWNiqc7oTpINrnjt91XFslQibvDl1e23GKBLwqsjCr7thNgadmwUqu0cyVXQ9Oj3GwXzU8LDdgkTRKCL00lU7TXVkYtsee2p2G3S02JUgMjs1mR2aRfDQpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v64TIbDLM1vmrlms1AJSzwct5CHB40gTDgOjmGqV3wE=;
 b=AJLbG/gqUBKh57PkUwxKiRgNfnLRF7oz9FIIr/bEy8bTimEnzpwlY1ZeGE0rQJrK/FV2VcLiLtmEkQTQiNBZNrSk/cQLQAPgu4whavuyZPCoxWZ6ITRebId+sJF3kWvf4dWP8Zda9OftFx1FZ/EjztWt0rf6moWU23C4VcYPH3Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 CH3PR12MB7715.namprd12.prod.outlook.com (2603:10b6:610:151::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Mon, 7 Aug
 2023 14:08:33 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::67ec:80e:c478:df8e]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::67ec:80e:c478:df8e%7]) with mapi id 15.20.6652.026; Mon, 7 Aug 2023
 14:08:32 +0000
Message-ID: <3fae7bb7-32c9-78db-87cc-1bd6bb216f79@amd.com>
Date: Mon, 7 Aug 2023 19:38:22 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH trivial] iommu/amd: Rearrange DTE bit definations
Content-Language: en-US
To: iommu@lists.linux.dev, joro@8bytes.org
Cc: suravee.suthikulpanit@amd.com, Jerry Snitselaar <jsnitsel@redhat.com>
References: <20230619131908.5887-1-vasant.hegde@amd.com>
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20230619131908.5887-1-vasant.hegde@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BMXP287CA0013.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:2c::35) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|CH3PR12MB7715:EE_
X-MS-Office365-Filtering-Correlation-Id: b2c576e4-7a5e-4152-b4d5-08db974fc880
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	9ib9xbBb1O45uJju6zhLbKPSkQL4T+U16g5ZJ/QcCdBTp1k4EZGdRYoGtovBoMAKnNh1Qyde8bXuWuVgNNiLLlKKomMe4d5P9Cu/5aAf8DNG0e7JhCs4WMHody3o0XGWhUzcIV+o3eU7IKFAL4vBtko8Rm8nxh5NXc2/H3PypU/ZsKz66UZvwEdO2aNMmfehO9/UH8uqcwFjn2aTUdJRtzcyJtAS7lW4DnGTVEPiMNHECg9EvbTruWnV+IgsL5Gv3itMHxmz3RRAET3qbJnj3NHteeeebUqvh/eWMFQqXmnivhN2gpuyZ4KnocTO5o+mJWDPNeYwdwCjyO9z6bWFfSLATpZd7eRdKnqlUqjkHVSsxv7uSV1ZUQA0ViT89U9w3DSArl9olHbkjNnl9BZEbdmlI80HfIVPjdfZ70TlkFWy+k2we+AmCER9c9KCZ+Rw1/duVoSJ5PJx5qJobgVn8xBz+uvF10E1CRh8euEmaed3x5x5faMSDOQ9H3y1fnW7R6mFuRFDrriCmsvkwWLXIT3rvgOPffxRfHh9YvMyHaWbs/x9Rbwffs4aJ499xLn1qhfe0CpcMwrR3KxO8FVkN/0j/N+Du1SAkIqyK+1iF8F0na1Sf4yNWKaNnHDK14NheSdVdfUdSWEASjO5/TBs8g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(396003)(346002)(366004)(376002)(451199021)(1800799003)(186006)(2616005)(6486002)(6666004)(6512007)(86362001)(478600001)(31696002)(26005)(36756003)(6506007)(53546011)(41300700001)(316002)(5660300002)(44832011)(8676002)(8936002)(38100700002)(4326008)(2906002)(66556008)(66476007)(66946007)(83380400001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VWVkOEo1Zk5Wdkl4OXM1eTliMVY2bEJwVDYvUjgrT0hlQmNWaVZaakJSaTJh?=
 =?utf-8?B?RDMxbHRsR0duR1YyNm03SWV0RDNHbXRnR0tvb2NxZHlBM1ZwSU83UTNEMjRE?=
 =?utf-8?B?a3kya05aQjVaNUhhbUNaeDFiREpXcmEvV0ZyRk8rV0s0QWdDYTJ5TEYvMlpP?=
 =?utf-8?B?UDJpZDBJdzhhS0RRdE5ud0dkdFc0UDBuUlhSNTlNcEYwRHN0NS8xY2FveVVz?=
 =?utf-8?B?K25pd2hJUmhJeFNLS296R1VacTVzMCt4LzlXS1R1WXloTEdyc2MvTmk2Y05K?=
 =?utf-8?B?cTljbWg2MXRNYTE3RWhPbUREd05ZQ2RmSEN1bTNwVjJocGNaTE5QTUx2bWtM?=
 =?utf-8?B?dzdFZlhmTDVxT2RLRjBaTkhFM2pwZi84UW5tRGJOaFRpQk5wanZqS1NOcDkx?=
 =?utf-8?B?S0VJczVUaktsOXFVOVRQWWV1UGFTYkxkNWQ5c2NSRkhlcFdESGNGenM2OXdC?=
 =?utf-8?B?NXA2ZzBjVUtIV2ZUaDlobjdldDViVUN3VHBDTjdtOHBQeXpMN2J3TDVHT2My?=
 =?utf-8?B?cUxBcHR4YTBqQ081K0k5Nll6NnFQSXpEbXFLM0pCY0t0UFpHK0QrY01yQjNC?=
 =?utf-8?B?UmRmdEJqWlFmR1FOSHQySDA0WnB3YzBDRTVRclZQaUNBNGhwLzA4dktSSFNx?=
 =?utf-8?B?ZFdGKzhOZW1ISHNNSWh5ZktGMXMwaFFTNTZzWjdRRjdMeUVWNUVZUWNrN1FE?=
 =?utf-8?B?YVJDa1p5b1dlWUZBU3ZRSk9nUUNwYW4xeDVMZGt3K1BLNmJkZWZQQW5kUTRB?=
 =?utf-8?B?V3ZTNStjSFN3N3I2U2RzbHhDQUpXSjU3K2FvSmtlRnJTZG1BYlRQVWlsUUVm?=
 =?utf-8?B?dkNFSFdhRjNqQlczSlpjSkpON3Jyc0FGOTQ3U3N3anJ4dWpwTGtnb2IrZXJ6?=
 =?utf-8?B?cWdrQWc5K3R3b3RpL1B3RGNkVWZHOG16a28yeUQxV0VockFsZXYvMFVsc3Q0?=
 =?utf-8?B?bGJFbFgvZmdneThjelorM2RkRFRyRmVZalBvRzE0ZERscEFiZi81STlvRVI0?=
 =?utf-8?B?VmR3U3ZSTlpmbVBKQ3AyU2haRkVPTmVDbk0vM0NqYURlM2VJdFZ6MXlLeVIv?=
 =?utf-8?B?TGtCUURCL0VaWkVZZFlLWE9KUVZzVzNYaVpUdHRyR29TY21wMG40YUFUK08w?=
 =?utf-8?B?RnlTMzYvNkhraWJ3THNibWZNWEI3d0dUdmh6U1N0R2JyaFZLYnBKYkRxNmZS?=
 =?utf-8?B?MHlyT25mMDM1cFVkRW1UZGpHV2ZZTGhzSWR5VDY5WHpMOHhhK1RtZVJIS1VN?=
 =?utf-8?B?WkcwUk41cUZueGFITEE5T2xoL1g4djIxTnlUSHN0allXblZ4NG8zMjFnVk43?=
 =?utf-8?B?UzlaQ2orUzdlQXIzSWlLV3p6LzZFUGlXcitFdWtaWkpCa0J0UHRDSEJ4WFNp?=
 =?utf-8?B?U29lYlVqWTA2d1lzbXBLY0UxRWFuV21EOUNrcm5VRThkSkpaZWVjQ2tKQlFK?=
 =?utf-8?B?YUpaTVFyQ01IWXBPQS9rMXZYbVAvVWRiQnFMZ3pHZmEyNDdTUFc5WHNWaHp4?=
 =?utf-8?B?SGR5NHhoOTdsVnZzR0UxWUduWEZGbUF5SU5HQ3MyYnh1YllSRjUwZjRsYk8x?=
 =?utf-8?B?NnhPYlRvYmtmcnA5aFpZVnkrcC9DcVBxWWhlSEJPcS8yeHhLRHg1WUFENk9Z?=
 =?utf-8?B?QXNwUVBzU1VHUW4wZzd0cEFBYXNWY2dmaW1OenVyS1RyUlVocXY0ajExTEV0?=
 =?utf-8?B?d0ZWMzgrMzBJc1AxMGlVSHczdFVHQW5MTW9LUVhKYTJYT0JkRE4yN0hCY1Fw?=
 =?utf-8?B?VjVybmR0QThaVzZMYUkxbmZqYUFuVGM1amZ1UXZJaFZxZnIrNms5cUFIUncy?=
 =?utf-8?B?c05ZeWJYUGYvamZUN01KSGY4dlRIbHVFcnk5QU1QeVFPMEpVRXNWYzV4Ry9n?=
 =?utf-8?B?ZzlISFRBcUt5WjdvbWc3UERlWkRnUmt3YUsrK3dyQjFIa0t4WVd3S3hCeHli?=
 =?utf-8?B?SjBBb0JTNGwvZUhpZjduMWwxL1hiSTkrdVVWTERiUUZvOXp5Wml0N2VXVWVu?=
 =?utf-8?B?MDFjblJZZEFPVUZTVVJnMmlFczVIMXl4UC9RWkVLZ3c2TDBINlhBM293a2NQ?=
 =?utf-8?B?U1puVnZBbXV1eEc0RDE2TnhyNzZyQWpVY05TL0tBNGlVWkF5ZUJoaDU4ZDQ2?=
 =?utf-8?Q?X2MPI9qxqiLdxoj6a9YaER0ck?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2c576e4-7a5e-4152-b4d5-08db974fc880
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2023 14:08:32.9499
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ovao1sxhH8+vIZppQSOorRwhW4+8sIWUXjkdsrGmgZFRqXDMBSqBTiKtKDUzSME2EFdJWpvbvqcLWDXvXPE4RA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7715

Hi Joerg,

On 6/19/2023 6:49 PM, Vasant Hegde wrote:
> Rearrage according to 64bit word they are in.
> 
> Note that I have not rearranged gcr3 related macros even though
> they belong to different 64bit word as its easy to read it in
> current format.


Ping. Did you get a chance a look into this one?

-Vasant


> 
> No functional changes intended.
> 
> Suggested-by: Jerry Snitselaar <jsnitsel@redhat.com>
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> ---
>  drivers/iommu/amd/amd_iommu_types.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
> index 53443d6f7b13..082c57b8c2d6 100644
> --- a/drivers/iommu/amd/amd_iommu_types.h
> +++ b/drivers/iommu/amd/amd_iommu_types.h
> @@ -381,15 +381,15 @@
>   */
>  #define DTE_FLAG_V	BIT_ULL(0)
>  #define DTE_FLAG_TV	BIT_ULL(1)
> +#define DTE_FLAG_GIOV	BIT_ULL(54)
> +#define DTE_FLAG_GV	BIT_ULL(55)
> +#define DTE_GLX_SHIFT	(56)
> +#define DTE_GLX_MASK	(3)
>  #define DTE_FLAG_IR	BIT_ULL(61)
>  #define DTE_FLAG_IW	BIT_ULL(62)
>  
>  #define DTE_FLAG_IOTLB	BIT_ULL(32)
> -#define DTE_FLAG_GIOV	BIT_ULL(54)
> -#define DTE_FLAG_GV	BIT_ULL(55)
>  #define DTE_FLAG_MASK	(0x3ffULL << 32)
> -#define DTE_GLX_SHIFT	(56)
> -#define DTE_GLX_MASK	(3)
>  #define DEV_DOMID_MASK	0xffffULL
>  
>  #define DTE_GCR3_VAL_A(x)	(((x) >> 12) & 0x00007ULL)

