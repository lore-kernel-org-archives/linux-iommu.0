Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011056.outbound.protection.outlook.com [40.107.208.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3DE722A817
	for <iommu@lists.linux.dev>; Mon, 10 Nov 2025 06:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762757465; cv=fail; b=a0nZcoX29DlsbOFfk6TU4SDctk+lj2fpmXnIm7HEVZIbElRe5jPmDSyP1wEyvyKoWcqgqa9Aa9iN5cf0Tc51HD3XKV/ZQOMEWAYIn8HcJHz7oHqKYy0YZDuQxE55OFvOI7EwiORpHdh2hI3btvMdzFrgW1MReBGX1yKxHi3I4hI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762757465; c=relaxed/simple;
	bh=c8mW/xLfs44hmnnCr/nlhsgb8csOJTDkuPkToiaZf6Y=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SFiiGxirkKLi1bMbwafHwFFg4K2EBtdXf3erDZxgJoaQIFkGExVFxek3IJ7StHTOnmbm+4xaoRcOwNTmPfPEmyV4bT03NXWt+cDwTr4fzC7qTYaTSSvJ9H4liH7GjKzHwviLwWEyFr5GtyBzszxJ7GXxdYUPGGk72i5QIQXAjwE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Bu+YY75u; arc=fail smtp.client-ip=40.107.208.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Bu+YY75u"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YZsRwcKRWg13YDwvuWBOah+cx5EaslMxrTz5jWRo8H/KHFTU1t+uQrZT0VTU35nL7/gXugwGjXm9hEjSpulCnnc8W0PJHOBuXuwkuKGRmpX9B/AodOuwm1uvLL42esK3WT4OPY/kqjXiMj1zQkEsOv1dG8cwQN+G+b0iOi5LM1e8jumbWw+7XOy+a/l2RAbfCu8ujzx2sLlgEWqHhzi3dHf5EHcKFOOkyIIs8JVgbbehUfJzPDKo0qUajf7aWZ0kyvlJ86h3Gg6zz8ZFErvL/F4e8ggUzTPKDx/SoN4HspOiYh6d0BoMrB/4BQFWe2OCGLvaUTr8N8mfEN+sdR+R8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F/3oZzp3mFtdejMsL/WCpGTVAI/O2H4YG0P4mmnBoqU=;
 b=E8eypp2tEYRs+7dA9B3ynwzdeD6NLnQyfc0OrmjWx/Fhtc0jaWlEiZgsPRnfWIgFruvSQfi451s++Pdsy6i1HyNVBwW0ovfI6wyRMZHncMefreEEAiufFSEFJ0r3PVhil8NtnH601jwco5UjJ8GLdfyEjmzR8InJOwx+nAjIUpQzle+NzJUtkkrSazlw25kjZYP6Iny6Nyl5qBT0SWlsnjrbh4mrJx6t+OHmXaPZLTdTxVD9Rqz161gOEEE5vxM3rzAFftOV+b1eoSgz6EqMnLSbilto1YOy8zj/6pH0WqywTTpZUGShWEqeg7uJvmLVgC0jc59BqnTqK62k1+4R4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F/3oZzp3mFtdejMsL/WCpGTVAI/O2H4YG0P4mmnBoqU=;
 b=Bu+YY75u/rvst9s1Kmdag9wVovJnnwFMTFzta7M14YI+Xpy/2gKe0vcieBBR8MSANw+/gv/Hj8NKRutDxKlDXcqzeF7ikvBSlOkHnPtZlbA0fZrHjkcn6owxysFL6fKW2GDBOD65TYFb9V59ZHRJAC4OKL6KKySlAsivU4gWhBjW+R2loE5KfPGGNvxsmfcYwh58RcnK0tvayeGrT+2K8p6Ej8JGn2TrPF0TIZNwmNkqzFZ7PXdUtKRH4az5kToPVp7W8pizg7CObs3cMlJL38Nilubz8s998ojXsOdy1uiur+EC4w0OBC3ASGDL97hDqT2KBAezTO9RytKPd6iOwA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB9056.namprd12.prod.outlook.com (2603:10b6:930:34::5)
 by CH1PPFF9270C127.namprd12.prod.outlook.com (2603:10b6:61f:fc00::62b) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 06:50:58 +0000
Received: from CY5PR12MB9056.namprd12.prod.outlook.com
 ([fe80::9a15:4da5:cfae:f5c6]) by CY5PR12MB9056.namprd12.prod.outlook.com
 ([fe80::9a15:4da5:cfae:f5c6%4]) with mapi id 15.20.9298.015; Mon, 10 Nov 2025
 06:50:58 +0000
Message-ID: <291ffac3-59a7-4f71-8201-e8477f71d3b6@nvidia.com>
Date: Mon, 10 Nov 2025 12:20:48 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] dt-bindings: iommu: Add NVIDIA Tegra CMDQV support
From: Ashish Mhetre <amhetre@nvidia.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, thierry.reding@gmail.com
Cc: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, thierry.reding@gmail.com,
 jonathanh@nvidia.com, jgg@ziepe.ca, nicolinc@nvidia.com,
 linux-tegra@nvidia.com, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
References: <20251031062959.1521704-1-amhetre@nvidia.com>
 <20251031062959.1521704-3-amhetre@nvidia.com>
 <20251031-witty-sociable-chachalaca-b73dbc@kuoka>
 <4f6496de-d3c8-4701-a9b4-6f695018eb5e@nvidia.com>
Content-Language: en-US
In-Reply-To: <4f6496de-d3c8-4701-a9b4-6f695018eb5e@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PNYP287CA0105.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:2bb::7) To CY5PR12MB9056.namprd12.prod.outlook.com
 (2603:10b6:930:34::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB9056:EE_|CH1PPFF9270C127:EE_
X-MS-Office365-Filtering-Correlation-Id: 282653b4-0136-41ed-6883-08de202580cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Um5mcHhUNDNVc2EzSU5Uc3pQV2ZGRzM0QnhYNlBEc2JpVDBNaEFNWUZNSkVv?=
 =?utf-8?B?Sm9WT0ZUQ1FWVU5GZWxpU0F4TkJGSENLSkhlR3ZnUXhsUllpYjczVThtN2Rm?=
 =?utf-8?B?TjdtdWhjOTFEVnNxbDZUWDVFaTFWcEZ2VzVoeUlCTVBKZnQzSFFxeXJDSG5F?=
 =?utf-8?B?bTR2UTRTQzcyejFQeE1iTUY2bnZhL0tKMFQzMUZhR1RuQ29kRkZDQ1pKbVR1?=
 =?utf-8?B?NE1Rck5RMzY3Sm5LNG5GbWFtcGVGZm1LNkZVd3hBdlBxYldVbGJTbStkRGlp?=
 =?utf-8?B?VzhzMFRpNXduQ1RrZm9uYkZhaDk3L2VXSEVWQ1VXRUZtVHE4OEFhY0RaRG1I?=
 =?utf-8?B?SXczZ3dhS0o5SVI3ZkpOcDgzbkdoK2krc3BKTnNLUStZbUlkQ1VlNXFoSXdv?=
 =?utf-8?B?Y0N5dTYxUWluclVrVzNLbm4vNHI1UVB3UE5sREF0QTR3enNyS0pWV0gwd244?=
 =?utf-8?B?ZUl1Y2Y5M3dNd2FwM2prUjdBUWgzeVVwNlN4TXRqa1ZIQVVSQWh5eTl2NFc1?=
 =?utf-8?B?c2poS2pLOFkwRXFuZFZ1bDF2Q0JMUExDUml1LyttWkdZNW9KL3dwaXJ6REF1?=
 =?utf-8?B?Y25vYUQ2c3BpVmFuWklqdXlWRWFXUkc4RDIzTmYwbEY0by9paU10LzZMcFRY?=
 =?utf-8?B?MTBDTGRSK2ViUjBRcWIzdHJPSzlKNEk0d09yOW1sckFaVXcxL3VuR2ZlWDMr?=
 =?utf-8?B?ZDNOOHdTVFNTQVRMKzBGK000SklBb2w1YnZQUzdxN3hyMGlEaG9hb2NnR0RT?=
 =?utf-8?B?a2d5ZU1jZjQwOWhuYnNBaGIzSi81cXJGdVQwM1M4OG1kb0hVdnNZekJRS2lj?=
 =?utf-8?B?dWNRa0dJSDRmK1k1UHhzT1hyRTI5RkN3dW95d0YwTTFmRmZaeXl1WndUb2dv?=
 =?utf-8?B?WS96aU5ZdGVMV1U2RFFmYmVzc09KQ0RISXFLMDRBakxreVg0ejRJdTJhZGpx?=
 =?utf-8?B?dmNNM0lYTXlrTFBJdnJ6MTJ1RElQVlpxRURoWFAybTBGL1hJWS9iVGNLYXYy?=
 =?utf-8?B?Um1qNlZIdFBPTFc4dTRkNVdWSEduandpdWdXeDZ2WHVjYjBUZ2ZBWFhjOUNm?=
 =?utf-8?B?WTBsak9TNmRISGlxTU1xZXBXOXpvVll1cUk2dVcxVjJGWHVYbHVwLzVSMDM4?=
 =?utf-8?B?OGhPZEpoSzU4OGFYSFRQNlZpaFBGSWRRalcyRTFCL2lKenRSYzl1eFhIREhi?=
 =?utf-8?B?dWtyRndkSjZmOHFNM3JlYnNOWTBtQzFxOXNSVHVTK3hDY3FrVHdrS0xwdGRC?=
 =?utf-8?B?eG9YZE1tZDd2dWUyUGJmV2NrTFZmVkF1N0xjY0tBejhISGNtTFYyNWE5aEZy?=
 =?utf-8?B?bkt1SU5nZkhtb0kyYW9lQVZWSTBOTXRaWHpEZituenh6SS92MWFwa1F1V005?=
 =?utf-8?B?LzFCODJBNFZOZndDdkxwZHV1Wm1SNzQremZVVGo3K01sOEJuWGUvZ2hSUS9r?=
 =?utf-8?B?TkxKV2ZFdkZiSDJmVi9WLy9oOC9TR2cyd0JKdkM2Uk5xblZHb1AvNGJBRmhs?=
 =?utf-8?B?eUgrUmYzRnJqQ1hwMEtFdzlIODcvTVdkQ3FDQmdHeWUvWTh5N05WVWRGdWNo?=
 =?utf-8?B?MUVUTVQ0V0RqSXJXcWEwWDlVTENwamF0V2pLeVBzY3plRTcrbW80MUVBVnJW?=
 =?utf-8?B?K24xZXUvMzg2dW5iQS9aRVQ1YXV3VGZyYnc5R1NoR1FHeWxKMWNyOWhTTEM3?=
 =?utf-8?B?azV0VDEzaHhjRXFBbXUyTVNTOGhFTlhoM3IyTU1UR3FPQ3lMcnJXM1RvVXZK?=
 =?utf-8?B?T0Y0QUJVQmd5MEhNMFlramkzT3hMTFRCRjYxYWlVb3ZGSEg0L280bTgxeGdz?=
 =?utf-8?B?S3ZnMHR2OHhQYUJXU3FYK1JqdWlXT1V6eHU2SkFXbjJDZjZjUVp0NXJPSE5q?=
 =?utf-8?B?TE9QY1drNmJoUU45dG9ubmd3SnYzYnllc3RyU0VxdmVDWG5YSzdxTklodEFL?=
 =?utf-8?Q?Fi2MQn00KRhYhM9VK4ofD6xrpmwC4C34?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB9056.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M2pFTE9TcFpWNVkwNVpBV1hNZm1IUnN3NXRWTCtIR1h6Z3BrNGFhNjloQ1VM?=
 =?utf-8?B?TFBDZWtrc2tKTmJLcGVab0ZlRHFVcDNLNmZyZ0VVZVJVWGR0L2VTVEhqa0F3?=
 =?utf-8?B?VE5PR0x0bmhhNVJpZVJneTZucVNZM1pTc3I1MUVhaldubG9Sb3U3R3JEREtL?=
 =?utf-8?B?bEJ2dG9BVit6aVppUnB5bzlTT0IvdlhRYlVkcDBPS2Y2ZHhmTjRYb1pQb2hJ?=
 =?utf-8?B?ZmE3b1NSVEhnNHBHYWhnUDQ2SVFGM3l3dEIxT3pMZVB4NkxpZit4ZnJIS0Rl?=
 =?utf-8?B?cTRxcEd6TnRpOHJlRTVPWjZ6VDcxZ3JWTHZ5bXU2UDJtRWZjemlrbHZKcnNk?=
 =?utf-8?B?RzFDbi9NK09VZnVtUnphSTJXUFlpdXdsMUNEaXFGSHBnR1AzNG41Zzh6QU5w?=
 =?utf-8?B?NThnSVpEbGYxRTVycS91dVhZMEs0YklINHhnUEgyL1FkZXZ1Z1VKeWkzNmpR?=
 =?utf-8?B?L1VULzdLd0lDdktjVEZXYTlaVk9FSVdiVUYxdE5kOFdHZmxZNHJjYkNjTEVX?=
 =?utf-8?B?ZEhPYmdmbWw4TGtvT2RDSTAzZm84YmNvajgvaDBYQm9BRHp6a1FwSTBkeC9h?=
 =?utf-8?B?NGt0dkZGZGgvMTIrNHptV1hBckc1MHF2TGdHOHpDeG9zQ3h6RzZrdmhabXI0?=
 =?utf-8?B?b3QwTE1KRmhhOGVMWmNYNzl6QmRhbWc1S3kzQXZuREp4TkVzYWpCbjFpUk9k?=
 =?utf-8?B?QTlzNTZBdVdkTG9PM3FZQWRGRUZOak4weTZDZkcrMnZpdkw4dEo4VjlFSGRI?=
 =?utf-8?B?cGkrN0xOR2UzTmpwdlpkNkM2K1dYUEwyTU1BdmVNQXhjTWdIS3lxcUlIemNO?=
 =?utf-8?B?a083dENMUUpiSThWdnh4WTVaZWM5VlZ2Tk1hMlplSmRBZW1UbS9IWUxzaEh5?=
 =?utf-8?B?eWg1NjNJWHVtUStnSXg3a1Y4d1psb2htNHZCTmR2L3pmK3FmNjFGZjYwdU52?=
 =?utf-8?B?S0NtMDQxNzFIZ3Bta2JuR2FHRDZZL0l6ZUxDY00vdTBKMVNhallPN1dmRkxV?=
 =?utf-8?B?WURybDdnN28yM3Aybi9GWkI2RGNiQjc4emZEUFRVVzMyQjN2bXFxVUJ0RVZ6?=
 =?utf-8?B?aHV3WGJyZUhjQ2lCd2pOZkdLTkd6eUk3eG5nNWhycGhKWFl6b1BEY1hjcGlx?=
 =?utf-8?B?VW9FZ0QxOG5Ya2xXWDlVSXdicXR1bWQ1TUlITjFhdTQyRzBDWXRNU3JCL1Nm?=
 =?utf-8?B?TWpNVi9ma1lINjh2MStvUmxxaHRWZHNCOERrcHdtekFiVjY4OGRyOFA5YzJh?=
 =?utf-8?B?NFlQMzZmV3ZSbW0xZXJvMVdFZ3ZQbFVxOCtlOEZidkROdkFyUmk2UFI2bXFh?=
 =?utf-8?B?USs4aXAzQ1l3MWZvZm9OV0NCRHFPanl4RU5jNyt4elIzSm1vWUNJc3JqM0lz?=
 =?utf-8?B?TU5jc2JuQnZxUGtBMDNPZ1VDSFZKajhWSnNVUDM2SU9GY1BLNmdTcStpN1Ro?=
 =?utf-8?B?WFMwRXFGSTlzbkVGRFE0aWUyUVZWVnNyNnQyRlVSWU9QOUNmSmFTS012VHdj?=
 =?utf-8?B?QkNzZkhVRHBxTHNWZGVQMkJ2N3J3ZERkOFcxZFVBZmtuTFNoRmhUMVVTdzl6?=
 =?utf-8?B?WjFhSnpvejlVUTNYTFRNck5TdStHSGJPZDJIL3dPdmsrNjVod2ZocnU3Zmpv?=
 =?utf-8?B?enZDNUQ0aG1Pd2xZbTdQQU8xQkpTMFRzck81Y0p0WFhSd2ZLazdBcTZBL0Nq?=
 =?utf-8?B?aythMEgzR0NZamFjSklVNjRCR1J3MzQ2aGtDYUdmK1ZXTW4xTFIwK3hnc1FJ?=
 =?utf-8?B?ZzU0bFRFVWdVQjg1Wi9kWHdzM0xKMXhZQVNqM1owc0EzRGZST0NnUk9RSUtO?=
 =?utf-8?B?U3p0M0pMV0RvQlZCdnA2L0Y0NmtFTlo4YTcvODhMOUkzcmZCaXVBQy84bFB1?=
 =?utf-8?B?dGx3WUNwOXpMUS8zRFVSSlp1TWtlTTZ1ck9ibEJCUG1zUjM0UEVaKy9pZ1k5?=
 =?utf-8?B?elBUMEdlWHpFV1lPMW4vKy8wNmZydXFETldjcDA1RWtDYUFhY0RqYjZKeWxI?=
 =?utf-8?B?NGlhU3dyOU5rTVFiVU9NWnl3VFM1NjZpSXRNTDN1c0wxTXppOCswYjkvdjlr?=
 =?utf-8?B?YlhkUUluL1NNZ21CUTFuQ3Vpc0xrOXg1bnNCdVNKamVyYjNleHRtVWs2RFdL?=
 =?utf-8?Q?pqg4kJ4eoqauG/mu7S+H5ofgA?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 282653b4-0136-41ed-6883-08de202580cc
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB9056.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 06:50:58.3785
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kaNnOJCX1MqFn9I7CKl0y/r0qwubph76wwhBap4YzEgGg+FKEkJWpRwRAS3e7MXZ6RonMJdBE5OD2pTai9vnRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPFF9270C127


On 11/3/2025 7:24 PM, Ashish Mhetre wrote:
>
> On 10/31/2025 1:44 PM, Krzysztof Kozlowski wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> On Fri, Oct 31, 2025 at 06:29:58AM +0000, Ashish Mhetre wrote:
>>> The Command Queue Virtualization (CMDQV) hardware is part of the
>>> SMMUv3 implementation on NVIDIA Tegra SoCs. It assists in
>>> virtualizing the command queue for the SMMU.
>> If this is specific to Nvidia, then I think you need specific front
>> compatible and disallow it for other vendors.
>
> Yes, CMDQV is specific to Nvidia. There isn't currently a vendor-specific
> compatible for Nvidia's arm,smmu-v3 implementation. Would it be 
> acceptable
> to document this as Nvidia-specific in the description? Or can we add a
> new Nvidia-specific compatible string like "nvidia,smmu-v3" if that's
> preferred and use conditional schema to restrict the property?

Hi Krzysztof, Thierry,
Any suggestions on this?

>>> Add a new device tree binding document for nvidia,tegra264-cmdqv.
>>>
>>> Also update the arm,smmu-v3 binding to include an optional nvidia,cmdqv
>>> property. This property is a phandle to the CMDQV device node, allowing
>>> the SMMU driver to associate with its corresponding CMDQV instance.
>>>
>>> Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
>>> ---
>>>   .../bindings/iommu/arm,smmu-v3.yaml           | 10 ++++
>>>   .../bindings/iommu/nvidia,tegra264-cmdqv.yaml | 46 
>>> +++++++++++++++++++
>>>   2 files changed, 56 insertions(+)
>>>   create mode 100644 
>>> Documentation/devicetree/bindings/iommu/nvidia,tegra264-cmdqv.yaml
>>>
>>> diff --git 
>>> a/Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml 
>>> b/Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml
>>> index 75fcf4cb52d9..edc0c20a0c80 100644
>>> --- a/Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml
>>> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml
>>> @@ -58,6 +58,15 @@ properties:
>>>
>>>     msi-parent: true
>>>
>>> +  nvidia,cmdqv:
>>> +    description: |
>>> +      A phandle to its pairing CMDQV extension for an 
>>> implementation on NVIDIA
>>> +      Tegra SoC.
>>> +
>>> +      If this property is absent, CMDQ-Virtualization won't be used 
>>> and SMMU
>>> +      will only use its own CMDQ.
>>> +    $ref: /schemas/types.yaml#/definitions/phandle
>>> +
>>>     hisilicon,broken-prefetch-cmd:
>>>       type: boolean
>>>       description: Avoid sending CMD_PREFETCH_* commands to the SMMU.
>>> @@ -92,4 +101,5 @@ examples:
>>>               dma-coherent;
>>>               #iommu-cells = <1>;
>>>               msi-parent = <&its 0xff0000>;
>>> +            nvidia,cmdqv = <&cmdqv>;
>>>       };
>>> diff --git 
>>> a/Documentation/devicetree/bindings/iommu/nvidia,tegra264-cmdqv.yaml 
>>> b/Documentation/devicetree/bindings/iommu/nvidia,tegra264-cmdqv.yaml
>>> new file mode 100644
>>> index 000000000000..f22c370278a3
>>> --- /dev/null
>>> +++ 
>>> b/Documentation/devicetree/bindings/iommu/nvidia,tegra264-cmdqv.yaml
>>> @@ -0,0 +1,46 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: NVIDIA Tegra264 CMDQV
>> Missing blank line
>
> Ack, I will correct this in V2.
>>> +description: |
>> Do not need '|' unless you need to preserve formatting.
>
> Okay, I'll remove this in next version.
>>> +  The CMDQ-Virtualization hardware block is part of the SMMUv3 
>>> implementation
>>> +  on Tegra264 SoCs. It assists in virtualizing the command queue 
>>> for the SMMU.
>>> +
>>> +maintainers:
>>> +  - NVIDIA Corporation <linux-tegra@nvidia.com>
>> No. It should be a person. If entire Nvidia cannot find a person, I
>> don't think we are interested in having this in the kernel.
>
> Okay, I'll add Nicolin as maintainer.
>>> +
>>> +properties:
>>> +  compatible:
>>> +    const: nvidia,tegra264-cmdqv
>>> +
>>> +  reg:
>>> +    maxItems: 1
>>> +
>>> +  interrupts:
>>> +    maxItems: 1
>>> +
>>> +  interrupt-names:
>>> +    items:
>>> +      - const: cmdqv
>> Drop interript names, obvious.
>
> Sure, I will update in V2.
>>> +
>>> +required:
>>> +  - compatible
>>> +  - reg
>>> +  - interrupts
>>> +  - interrupt-names
>>> +
>>> +additionalProperties: false
>>> +
>>> +examples:
>>> +  - |
>>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>>> +    #include <dt-bindings/interrupt-controller/irq.h>
>>> +
>>> +    cmdqv: cmdqv@8105200000 {
>> Drop unused label
>
> Okay, I will remove the label.
>> Best regards,
>> Krzysztof
>>
