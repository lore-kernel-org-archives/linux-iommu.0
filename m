Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD4B312DD8A
	for <iommu@lists.linux.dev>; Mon,  4 Nov 2024 13:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730728770; cv=fail; b=TYbQl1L2L3utf/QL6FyapXXPm/sh5KWaWhdIx5SEJZAS++623Y1C1eDnvCMkJkmgANPD/7xn9AgBdTZTPzeGzmp+i+nAkKsTQDmq9AEzKhbQWsVMh6xxiTt7SAxp7131BldSgRqO739OGoLQvrXkcBpRmFInIoZ4LZxSaFLtGs0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730728770; c=relaxed/simple;
	bh=3/RVxjAYPjkd3bNy129iyqW5sR6fmXteEmE9rXHHdq8=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mK4INLVW3srBgjGeeI69a3g9f1+s7zshQZGIB5nVC7RWjsMk7S5PCNylrpgYG6VZq/u/CWXvPBEdZ08yRFiE6QLevH2JnGyXozcp+vwOVD2p0l0Nmn9VqqoGeIFhNTRDXMyyiYMyF4KyjfExcmLjviUdU5tuKyIMPqqXDv/Mdw0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mD71bXNd; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ZlGpyP/U; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mD71bXNd";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ZlGpyP/U"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A4DNr85003061;
	Mon, 4 Nov 2024 13:59:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=vzCFcdNlIj+av1rRyxto4+VmuJeyFhoeBw5MF61irhA=; b=
	mD71bXNdtBCaf7KpD8I/UFxUBCDpef8y/LeEkmJOveQpP0Li2AH6nf4eVhLlgB7N
	9CDgMqFMfhqALfzFlWgCtyPg3lxfe/mFnr+x9Mts5px0IsCkiqBge9QfMU7KmV1r
	EDRhZbhYJDGJkxSEuEjK2YSZCkmt34T5/oU0NSZ/JvFawi4t0cN5+4AahE2WCTms
	ozAfyde43z/zhP6iQ69d3mSvEeJfMJpV16UUQY5V9rodjzfRxb+0OrbvaaawjOAh
	6iO/EW0+6jwXlClc01kFEzWy88xv/rGLV8ibLJM5/n79DkTrDRTpPDp1JaoWItIg
	fJ+E7Yz1Jyjzaz8NYn9GXQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42nanyttp9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 04 Nov 2024 13:59:25 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4A4CKDFC008670;
	Mon, 4 Nov 2024 13:59:23 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42nahc1njm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 04 Nov 2024 13:59:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uP+Xt59n1+Y6cxu8h5I9Cui4tgi0UUHX6qfqIrq9i34RgE+Ak71Zq69r8cjxi1rvToBPdXbANHj8Dodcma2r7ZRgEp1b6E6q8QVL2aSDJshZU/ZP3F8e5/rW1UVr7pa4tY9aaEnI9jsb+bF5X07FWH+Yf9wejDU2Xnw5XFMobhM0QRPJQXxzWLvkuW5Za5Y9olnBgEgCFbDq7q0+zfA5NKm81UH9Mck0EFgkar53GUDh2h8FsfJyXOlIs7Eun3jiyZkRU2ERov3jfyixVm5jzCP/2sv+QclwbvP4eIUE3TJUBJFbKJPOC9/afcxn1nIgGCgYW9eFmCxxDECQyfbYpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vzCFcdNlIj+av1rRyxto4+VmuJeyFhoeBw5MF61irhA=;
 b=DTDHl38pXCu013u+yRYef1uVuzL+hDuT5I40uSDqOC7v7MI1pUb3KAjb7DoDjUSHTfF8rYk1/wkMLShpoYOn14uoR3MfDTL6kc1l4Lu+DkbLS7vD09WPrEolKfbfEi4tuLw8Cxj4It5qgqJFRODyb1Qz9x4GBtmMDrUdKsBWmiGSkS7Y3umoLI0Be7/vgL+7hXGCUdvo3X7JUXQPhVilTB7jYMd/LNw9Fe/2xmNLMHOMTJbw+4jo7vq8GRmsaI3G1fxc1ZJZTGSqbDkhJZZGAlIqKN5gfu72JXxfDKnV/ei+DjdOA8GkdtHunxO0OxBIQCvfHRjAcMCtD+hVeS/rww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vzCFcdNlIj+av1rRyxto4+VmuJeyFhoeBw5MF61irhA=;
 b=ZlGpyP/Ub9d8XQku9uCJEYRm1DZVTkeMmuyviSPFGv0Yr1OBi9fx5hfkT1K5k2jimnbaXiXxYTiKa/GG+UehSlqAFvDX35mBhdXGGXUc7IFhWUZPEOFLnFfUEopxWizArtVdtCDkssZetssP9dFuMwXBmSRe+XB8v+S9ZXMBF6Q=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by CO1PR10MB4628.namprd10.prod.outlook.com (2603:10b6:303:6c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.31; Mon, 4 Nov
 2024 13:58:33 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%4]) with mapi id 15.20.8114.028; Mon, 4 Nov 2024
 13:58:33 +0000
Message-ID: <b4fa2db8-192f-4cfd-880a-5e29bad58f52@oracle.com>
Date: Mon, 4 Nov 2024 08:58:29 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V7 0/9] iommu_ioas_map_file
From: Steven Sistare <steven.sistare@oracle.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
        Nicolin Chen <nicolinc@nvidia.com>
References: <1729861919-234514-1-git-send-email-steven.sistare@oracle.com>
 <20241030001102.GA251312@nvidia.com>
 <1bde901c-980a-44e0-8f6f-8e1985683349@oracle.com>
Content-Language: en-US
Organization: Oracle Corporation
In-Reply-To: <1bde901c-980a-44e0-8f6f-8e1985683349@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR07CA0068.namprd07.prod.outlook.com
 (2603:10b6:a03:60::45) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|CO1PR10MB4628:EE_
X-MS-Office365-Filtering-Correlation-Id: 068630ff-a5e8-4a7c-4e40-08dcfcd8c557
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UGVyUXowOXRQVVJsY1V6dVdaREZPcURFd1lwMGtRTjZPbUlqMU9WaS9UMWRq?=
 =?utf-8?B?Mlc2dVpKRXZ6c29yWExTdjBGNVB0aTdxTzFob3VzU1VtOUkyTHpMUDJxT2FN?=
 =?utf-8?B?WWIyTll2OTM1cTUwc1VGbHlKNkkwbGZXcWJCdytaZWw1QnJTRUFabkFzcWxt?=
 =?utf-8?B?Y21kMTZTM2d3dnlaNHV2YXAvckZqL01MVHlwTkU4WHBQV0h3WWozUE0yT3dD?=
 =?utf-8?B?Znd0UnZ6ZzJpL2ZGcm9HM1hnVE1IVDZSbEhMU0pWcXZiZE9YeHdzVVh1endq?=
 =?utf-8?B?a2lqYXdXRGZjRGhtVGtod0FDc2N5VHM5S09HVWRacTNTbTlYNjZFUzMxSkFW?=
 =?utf-8?B?TXNMWDB4QlQxK0c5MjUzZXV4NUJwMXNYcWpoMUVUcXN3NmY0NEs3NytTSVly?=
 =?utf-8?B?bzNvNTBUaDFndHRLY0lzUEVIQU1SYUg3SUlUV3lHOUdFMHlhVDduYmg4VFBt?=
 =?utf-8?B?TWpuMGRFSVhzTjQ0cWNSc2FxOXFUbk5JY1lHOWVxdklJejdXYUQ2Vit4ZGU4?=
 =?utf-8?B?M1lERklmLzhYVXFDM24vV1pGUW44K2tuWjQxU212cldMbDRmTWpnSEg4Z0tr?=
 =?utf-8?B?UnBsVWNWU0VnZ1BYUEZRYjNOZHFFV054NVM2MTgvWHRrM3MrWE9ObVlDY0pu?=
 =?utf-8?B?RWFMNng1NTZSOURTNGtWQmtXOEZPbmNYQnViVG5PLzlLdUl3anlybk9jYVM5?=
 =?utf-8?B?SEFOb0dPNk1XdXlSSkpramphWFRRVFRsM2diQTFuNU4zSmlvNWxQUytMbFJs?=
 =?utf-8?B?Ly9xSHRSWmJUbks4YWM4dGZQSkYyK0VpOWdFYVlMem5xaXFRdjJKeTJHcTlS?=
 =?utf-8?B?UWlLN0Z5aGxVVHlnUlRSWThySm1VNkxTUGZVRU5jaWdrNDY5bDFCYTl0eTU2?=
 =?utf-8?B?Vkp6WEJ5YTFaS1IvbkprWkxyUFl6dzFtRnpWN0pQdDRURkpBaWdrRW9wVUdL?=
 =?utf-8?B?ZGRaTk1rRGtiMnJLUXVLNWVwcWVXeUhPYmwrVko1Y3NEQVZnY1dMNDc0V2dt?=
 =?utf-8?B?SzY4TEhCVTVWem1wQzZNeWhYdEtaSlJNUm9aY0sxUlljampDcHZzRjgxYmpJ?=
 =?utf-8?B?SFhXY3NNNk5kcVZxcWxIeEpnUlV4c2JSdkFYSTRDZStXQ0VtemhEdnZXNFNy?=
 =?utf-8?B?NndtbXdLSVczOS9XaFRaZlRqd2RTek9rdndNV2hzN2VwOG9RMUVUSjh1OWpz?=
 =?utf-8?B?Qkl4enhmMVhEMFdnVlBTeE4waVJmdUJEZ0F5b2pGR0s5dVNWU2pwc2lqZFJE?=
 =?utf-8?B?VWdsWTEwaGFuOEtLdlM5NW91U25XRjRxbzlnaTJLdldCdGRuRXZHa2lKOEVB?=
 =?utf-8?B?bkV1eWQwaDVoVDM3OHNKN3hJWmRTK2dGU2ozRXN3cXlxV2huWjFVTjBDQmdh?=
 =?utf-8?B?MU4zaEg3MlBRN1BVWjlrNEhCVzZ3cWhGYU9iMFJEY2lTc1YyamQ5SXhoK0lW?=
 =?utf-8?B?RlV1VGk3QjlGRUdjZlVFeUprMG1vL3JLTm5jZjV5TEFPT25Kbjl0eTJTUDhP?=
 =?utf-8?B?UG5CUUZtL1FHRWdjbVNlbC9zZmg0YUJJenNrNlNaK3E3SGpRT3c0SzBGaldl?=
 =?utf-8?B?MklIbDVaYTRoRmRNVWgyT1BHWG5PemVDMngxdGQ0elJUQ1V1S0hIYVdVbWph?=
 =?utf-8?B?bDNDWmoxbU52a2JsYXhJYTFvT3Q0QnVJUDNpN0U0RnE0YmRsV3NzVm4wTCty?=
 =?utf-8?B?UWZRWDJDZGVnMUt1Tks3S2xnUXRnRTlRaHRISVhRNlBpRndwOHc3T3RvaDlB?=
 =?utf-8?Q?iLELLbvB16BC8PWkI2RHfCrMmAcT0bt63gDrsfN?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR10MB7447.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SXJyS0hmVElaNUpXdUNWQ0lIU0E0OEF2ZWZTUWhlZ2poTkhvSkZURFNHWFNs?=
 =?utf-8?B?RmhhbzVRVzZBaVY0QkM1NkZJWlpaaGxlTmVHcDk1dkYzWmpzd3d6OFpXWTRK?=
 =?utf-8?B?dGI5ZmZSVk5qWTloSDg0MVF5UEFXYjRUQ010ZkwreEF1RjdiQjNZU01iRnBP?=
 =?utf-8?B?MStwL0xEYTVXSTJieUpUa3FSSFB6NFl1WHRXTDVhU2RzUWlpR0d0SkFveDkr?=
 =?utf-8?B?ZkFVdEFENjRKWUx2ZEhkeTJZa1I5MFlEYlFIdXJ3aVV4eXFjTHlxbUFiQnJq?=
 =?utf-8?B?ZjdvWWxlSFpTN2ZEQ3lhaHFYSVZSRlRzSWtnUlVxOTQ3ejZKZEhMQ1JSa3Y1?=
 =?utf-8?B?MGQ5YmhwVGRhVVdSaVpRa040bUlXbEFQQjFiWUVHVVYwMTRuZytJZEk1SVFU?=
 =?utf-8?B?WHRoS2NhS2M0WFFiWFhOTzhMSjQ0THZ0ZEhVbC9zQ25aVGhRNFI5ZG9lQllQ?=
 =?utf-8?B?a1JySUpua2V5Vmk3cGxIVmZKZTNiWnpHOTRmcjZUYXVidUdTWWlUSjJMdmZ3?=
 =?utf-8?B?V1J4dFhzbzZadURxb1hFU0gwK096MThCSHVmSHJpVkgrR0VuTE5sT0JzSi8y?=
 =?utf-8?B?Ui9ZaUZ0cmhaZWxkR1ppWWlLKzdnU3lYWXZMdnNkdjBJSEtaL1Y5WGJMZkxF?=
 =?utf-8?B?SE41ZUxuSnZmaGNySktYQnRmdGw3VThhMnBmSGhWc0F6ZFZIcEsvd2U1ZWVG?=
 =?utf-8?B?NGltdm5tSUhST2wyeHhGTWxhbE9PQVpQbHhweW1Relc4allQWHkwMVd6QjBQ?=
 =?utf-8?B?QVdFTmx1MlNFOGtybmxrelpIT0ZITEdxOTlzc3VBWVcxNG1WMzJNeFVZOER1?=
 =?utf-8?B?QVZnNFZpU1h1R1NWTjNzc09paDl2YkRmZ1FCanFBRHdYMDQvQmlxdnEycUha?=
 =?utf-8?B?OEgwc2x2cDU0VVI3aTVreHFMZmJJYS9ud2ZzMFZsWjZJY0k0VWNkS3hsd3cv?=
 =?utf-8?B?aC9EWEc0QmhOOU1sY0pEMTNzVTN1NE1hM1QxUk12V3MwK1NsNDVCTzJGMFVE?=
 =?utf-8?B?SXpncDBacllidkZFTzYwM2JjY2VQcmVabUhnMThoSks3UlA5RG5YcG1sZlVU?=
 =?utf-8?B?dWVSdWIraXRaVmJoM0JjWGVFalAxOEllVnljeHZxV3UyTCtIRnRVeGNvQ1F1?=
 =?utf-8?B?MTJLUzdwaEdkTmt4Y25Ha1dKcUpvc2RiQkJ4TkJvS1FmWjJnS1YzM3pMRGxM?=
 =?utf-8?B?MnczTFBhanBsOEIrQlMveUpTbFhMZ2Z1V21aQ2VaWUtsayt6K1NpaDk0YXVm?=
 =?utf-8?B?R2RRNUI4cEFmOXhtTWhCMFBxSEs3VUV3cmxaOENQYjNUZ3o0dHlMaUFFY2FN?=
 =?utf-8?B?djFkanA4bXRCUFJmUXhDQkcyL3lEZUQxbWw3Tk1VemtsSUx2UEV5WXl0T1pU?=
 =?utf-8?B?cWlNdUZnTE16enJBQkw3ZjhIb0o4Sm55dGRSYm1iSzlEMjNoU3F0WDlLZnR2?=
 =?utf-8?B?emo5a3dXYU5KYUdKWnlCTVpKR0NuMy85SWRlMkhDTGV1bzN1THUvK3ZwK1JP?=
 =?utf-8?B?VFVXR1F5TGtkT3hSWkJyT2ptRTlQQ2svSGtRdmdMQ1RFNlB5MXoxWDFwWnVV?=
 =?utf-8?B?bXJCbjdrb1lCRG5ieHdxRk9FdEdNMmpvTmo0NWp0WjcvMWJSeUxZcFFaU1M2?=
 =?utf-8?B?N2lvVjRIYXZxaS9DOHg0SnNkdlIwbVlhYTZBamJXNDhCTmlPWjlwSHRpNkNZ?=
 =?utf-8?B?STZ1Q25VTnc1UC83WW5nZjV4SGd1blk0bUdxVlU3TStEWGtlZUlhY1lQWkcz?=
 =?utf-8?B?aW5DVVY1Q1hkbTlZNlB4VlA3VGp3UThGRWUxdFNIeS8rTUNVMnBzNDVBWXdK?=
 =?utf-8?B?dmxxOHpUNGgxcEthekQ0SHQwNHVVM2Q5QXBKNTRWZ1gwNHdTbk56bHBBd0FC?=
 =?utf-8?B?OTVBckJCTGtuMC81LzZOSjQ5WEtyNE01YXNLeGVQaDA4bnY5MnYxdjcybjFp?=
 =?utf-8?B?WmF0SFI5R2xaU0I4cWFYVldWUjIwenJPZmtDOU9KZVQycFNMOGNRS0hQSnNh?=
 =?utf-8?B?MElqdDU0Sk9HODZqK1M0RnphRTYzZTFyNFFQcnV4RnVnNlVVZHZDcldQMitv?=
 =?utf-8?B?RllUUllYWmxRUk1HaFVCWE5FZ1dxMnF5RFUxOEJTcUdKTzhxemF1dXdZa0ND?=
 =?utf-8?B?dnVZbmFQNFZUTVRsNmlTMU5jQlY0N0VKdEhkUW1rWnNCNXNsdXVObkRGU05H?=
 =?utf-8?B?c1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	+rbQWL9VvXDtsuxvpYX0I08FyBWCpUA9BIa1BTM7IKTem1HWMHl8lO68k9fonKSgws2q0pd0p3BhehYfl5bF56MGlH21QhtiJz+B9v+t3AGUcXSE2D2XjV7cdqr6EYYlpNuC6oPaI9UwE7UAeT+GIegdcHKQfpAD/y0q6DigXqx3gahu/Mwa/L768UuUJcfhfGKrzHd3GGz48tnVQJy3wC5kGWtilZ11SVbkWGLVtA7XJB4iKNLrRN2X4xxZOzBEbLUOaQex08+Dv2dMlsRB8ixRCWUjnq72dcstU8mjaJmQR6foN8OEenHGSwVb2OWTCvFrbrWUYTbn4rlmjEwUbiuibwg5VsS5re2f+JNtANLm54SQUew8Trl78bU2RejqivF6+L9qEqLt1/k8ak5JEft2dIKZzqKnkicFjHqqgSTZ3FKZ4uRlnB9YPLdwMTAanmVaN4Z22gmn6YrbspfHN5I0AAySroIz8K+gEkg621NzZC6ZWwLNTZp/McmrxVhFcWYeyY76Ma7Nwt1MO4MpUlddXuXxwXesC26Ub0O/CYj7SaizdyYYEHUTRizYThPd0d9KFZ98xV98a3+SYOmmU2ZqWOSHj4SVYQvKxcBea40=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 068630ff-a5e8-4a7c-4e40-08dcfcd8c557
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2024 13:58:33.6278
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fM0USKnkwMZIvBatR78kLr8bF2L+7LhruLXEWuU+pC2Q3DEXQAOP0M1w6JEQenJ0X23Dx5xK71vsmpplHRTELo1RI9Yeho2UmGFGzZ24Rqg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4628
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-04_11,2024-11-04_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 spamscore=0 mlxlogscore=999 mlxscore=0 phishscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411040122
X-Proofpoint-ORIG-GUID: OI_a6kvDihkIR9RydXPGu63wlCDfTv0j
X-Proofpoint-GUID: OI_a6kvDihkIR9RydXPGu63wlCDfTv0j

On 10/30/2024 8:43 AM, Steven Sistare wrote:
> On 10/29/2024 8:11 PM, Jason Gunthorpe wrote:
>> On Fri, Oct 25, 2024 at 06:11:50AM -0700, Steve Sistare wrote:
>>> Provide the IOMMU_IOAS_MAP_FILE ioctl, which allows a user to register
>>> memory by passing a memfd plus offset and length.  Implement it using
>>> the memfd_map_folios KAPI, and the proposed folio_add_pins KAPI.
>>> See the individual patches for details.
>>>
>>> Steve Sistare (9):
>>>    mm/gup: folio_add_pins
>>>    iommufd: rename uptr in iopt_alloc_iova
>>>    iommufd: generalize iopt_pages address
>>>    iommufd: pfn reader local variables
>>>    iommufd: folio subroutines
>>>    iommufd: pfn reader for file mappings
>>>    iommufd: IOMMU_IOAS_MAP_FILE
>>>    iommufd: file mappings for mdev
>>>    iommufd: map file selftest
>>
>> Applied to iommufd for-next
>>
>> Is v3 still the latest for "iommufd live update"?
> 
> Yes.
> 
> It's selftest patch no longer applies cleanly, but I'll fix that in V4
> after you review the other patches.  Thanks!

Just checking -- are you waiting for me to post V4 before reviewing any
further?

- Steve

