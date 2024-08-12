Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 426AB18953F
	for <iommu@lists.linux.dev>; Mon, 12 Aug 2024 18:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723488973; cv=fail; b=Fd4XqERqhTKVQ4REI5U+YVxB/8i7rAiKuj9JB2YrZWp7bEie1pXfcPf8CoX0IVR7gIiUmxfngrN2GSWTn4yziutWkIB1kJyzVAZGeYZ+D4WQFiAcBoOu5H3OWnP2vNwVZ3Z91j+BCej5wqz1CRXBUp9SqREH6whFlvm85kvcckI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723488973; c=relaxed/simple;
	bh=ImkJcGfVyuB9aAYq+a/5rdGQSyakk61qpz2a4zqWnl0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Jbf0pCOc5NvU6X7wbWwFqmCpP2prXu8v4Gb9zAvCfl1BlVqzVcDvMKTvABGne+C0oMJbGLzRkEkBc1QC4JDBAjhfUCshSYI/BEitdUetNZ29p5MkMjUoCxU0h1NdYWuJJPCn8wjMesOzglgsH5dmDAOksiTmrv47q0SB0bwfX9A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=IXFKgPc5; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=u9yGnWgf; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IXFKgPc5";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="u9yGnWgf"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47CHXTax024060;
	Mon, 12 Aug 2024 18:56:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=NP0meckW9glEd5KLDVfUFqEseJ8Hfqh6ho1rqfksAjc=; b=
	IXFKgPc5sZapsjKV0gcwS1q5xyyIFSZQnlAFXCZx5E7p6t81SYYy67LrB3W84qI7
	EqLvxOJ5nKbLnzkb8eo7HGwLqAC6gysg+gM8wJsEBCr/iPyttNhXr+v3vPSqmr+y
	Np5Jc0Y6n51WUjJBQYX2KbYFHDB+Dgr1BS3Otc9NIgXYent9ZS2O8eZGmG1RKOSa
	AzyeAQUrzLSGhjfAmYKL6WDxyEKOVFs0cLwdQkGXKcSuqE3Ce1RmcYDXAjffr49Z
	LxDFt+egJUEIjIcKzQlr+JmIJQg4Ds2Og5sCqnhP2UPsakhiTfEuaPMtHDtsUlSG
	DM37Nk0PkTSYikRkfdJhCw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40x08ckca6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Aug 2024 18:56:09 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 47CHEiFB020871;
	Mon, 12 Aug 2024 18:56:09 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40wxne1mv2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Aug 2024 18:56:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TEDlQ6edkn9XfEsMuHwrZ/9kr2v89De9/+Ui7e/+FrCIaN20r24V7E2jhXTfNEWcmUqF0zloIDBNSIEkMooB0meyBgLR095OkY/OqVjuXDqVvnEaTC9r2Nw/WDSicq0atcIzZkjRYRhHgZqh5MV0+hvWCHHDmICc7GDqXjyX94jntuYH8dx8V4Hi4TtoqQDqfhbdtk6cP8LJVYz/QZIX4mE4xZsKrYQntEILEymiBEY8NcQdtDXqg0IilIWlwdlQfb1oKNL8zREACPi/WGzikWuxQgfteIg7qxjhVIHoVQBvkDJqWgE/TVvG9y2HV75fGkKKcOQILqKhZ/vfK5sXiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NP0meckW9glEd5KLDVfUFqEseJ8Hfqh6ho1rqfksAjc=;
 b=BAb6vi1v2KE3Z34VS+K5JbMUUKPhCa429fVdCpE1x9PSgH60aTeIciLP5Q3B6cebt7GvfzC/GJke9QCEArIMhybqkGUqhNn+WpMmuJ8Knc1aJKb250aEWMz+92cJ+AeUh7bTIXdetYGNpMI20yvYGs/JNbedVujJOYcAJuB5VMqv0KiccOk2hkvpDvbaoOig0pgPxSKZQ/VD0hJlBy3V0RC4N/RIaXHfavaWS7K7faEeK1PdrOY9ntBLnMROe3y7qMklsqkMcvklyxfhD0JttjGTj/di0eTRgGWu28/VcmZ/88fIOY5Z9LTHE+nHOW1FsN9di5MlNBoEM8+IgaXbPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NP0meckW9glEd5KLDVfUFqEseJ8Hfqh6ho1rqfksAjc=;
 b=u9yGnWgf6dtiiAwoy3Eje0dYVZRoPGkXzfKNcJ6Lmn/A8Xvjqbv/QvC7m1o/tdLKsX+nl51KOiMyKy/3OkEwt2ypU7aXnM+TaXs5ncCcI0DWo94bhWw/IvRi4nTBxxU0iF9ETkLivv6OPNOIy9YXtUqy8jj4gsenPGbUuFon/+M=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by SA1PR10MB7753.namprd10.prod.outlook.com (2603:10b6:806:3a9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.15; Mon, 12 Aug
 2024 18:56:06 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%7]) with mapi id 15.20.7875.012; Mon, 12 Aug 2024
 18:56:06 +0000
Message-ID: <684a3618-ee15-4f85-ab44-3de0527f91fa@oracle.com>
Date: Mon, 12 Aug 2024 14:56:03 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: mapping files for iommufd
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Alex Williamson <alex.williamson@redhat.com>, iommu@lists.linux.dev
References: <a745cabd-5e38-4242-b3b1-da02c1e670a8@oracle.com>
 <20240812184005.GQ8378@nvidia.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20240812184005.GQ8378@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0605.namprd03.prod.outlook.com
 (2603:10b6:408:106::10) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|SA1PR10MB7753:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a769661-d82d-4ea8-10c7-08dcbb006c02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NUVCSFp6Y2xsREluK3FKNDgyVk9lRSt6YWxjc1NvdGhaQVBJSGRRUk8zNytS?=
 =?utf-8?B?RnNFaWwvbUdZVlkxYk1UdXNNTDhTZHRxSlRxdzFBSm1KR0J4c3hOVEsycG13?=
 =?utf-8?B?SWU4YVVVOHhidVdrdnlVM3FublQrMTRIbkFiNmZpVGVZc3ZhRUtYcUJWMGcz?=
 =?utf-8?B?aVBPUjJWU2ZRWW1nSUFyK21YbGJDVG9RRHM0N3lEemhMZ2gwMzcrMVRMd2F0?=
 =?utf-8?B?UEVGWXRtN2gwNEx5cVRwV2FSNllmcmJoKzVxQVdCOUkvZ212ODhSTmc0Unlu?=
 =?utf-8?B?SmFZS3o0ZTJ6alhORlJwNWxybVNzM1NsZWRiQkhpTlZ5V2NhdUNOY3pTZ0hr?=
 =?utf-8?B?MUs4SGtjb1Rjb3JzUHh5Qnp1TzhIRVdiZnJZcmU5WDNnUXcwcnNBZFdqek4y?=
 =?utf-8?B?NGc1aEZKd29qeGxBakQrbjR1c21RdXd1M2JEam5oK3E0czVIYXg3dGNEZHNM?=
 =?utf-8?B?ZWJHWUMrUURndWp4T1JkWXFrRnBQK2JhVG9FVWYxM1RsODJKVm1ONmFnS2Ju?=
 =?utf-8?B?bVZyVGVDMWZ6bzJlL1c4S25QMk1YdmlUOVgxcm1LZTZUaENUaHpXYXZzaW1m?=
 =?utf-8?B?T204UDN6eDZ6WjRmQXphQ24vQnRXeGV2eCtZdWdqMlEvTVJFN0lwWTg4bXJo?=
 =?utf-8?B?aXZTZGY3UUhLMDBUcDZPanFTeVJ6V3JNRmROenpZSlB6dG9rWW5CWlI5SHpy?=
 =?utf-8?B?R3lsR1lLYmJSM2twMlh1R3RsVHppd3QxbFJaeUFrQzBDZE1NOXQxZ3U2RThW?=
 =?utf-8?B?L29WQXhIOUkybDFEbzZyd0FKMFFJOXlHSytLVlNTTnExN3Z3THVRN1dadjBC?=
 =?utf-8?B?K3g0NFF5UWVHalIybjBDOXljRENoSW4vTW5DcW5aQ3ZQbGlSUmp5NlpXM2o2?=
 =?utf-8?B?MVhKZ0wrdGwrMjlwdDdXUklvRGdBVVpFajRLVUNPMGxrUmxSeHZ1cXU0Nyth?=
 =?utf-8?B?QjN5Nkh6MnBtWGhyaVlyQ2Evd3BTUkMrcXRLMGY0WVl2Q0hiT2wwK2hhcEJC?=
 =?utf-8?B?OGlvVFNzem9tUTdKWTRlelQ1SDR2ZXh6QWsxQkh4SWRtaFhnNlJIdmZhUkJl?=
 =?utf-8?B?L2paYlRacFZqbTNYd3NqWjdZZk5IN0NDV3M1TTBsbTBsY0tLc3g4blVGMkZX?=
 =?utf-8?B?Vm9HK0d5YlNIczMwK2JsL1NRazlyM0ZRK3RjNHMyazlsUFlZV0h1YjZ1RDdU?=
 =?utf-8?B?T0owcjdVWmo1eDN4cVNMaEJ5RkZ5dlRwVTNtU3JqU3p5TlRuTjJXYW1CRCts?=
 =?utf-8?B?N2F0NTdlVjRPeUUzS0xUZnNjOVBBR3RBdm8ySzdiUE9USnFLWWI2UVI5SVQ2?=
 =?utf-8?B?N2V4UGxQR3IrQWsyYVZnK1lnSEpEOEpUU2RrNnljWEFvUWYxdEdrR2tIVVcv?=
 =?utf-8?B?RXlYVnh0S3NyUkVoRzBTVUIyS2lZbGlOdDR5UHl4Z3pacE56MENnbXJGejRH?=
 =?utf-8?B?QnFqc1BicGdaZThEQzJSZGc2ek14YUZLa1dGcStRNVBvUHMrVlhQQ2dwN1ZY?=
 =?utf-8?B?dmtURVpYVGVyQnUxaEUzd1JMU1htaE93bzE4d2IrYlJ0K3N4NHZpODQ4V3RY?=
 =?utf-8?B?aWJkQkJHWlp5KzdUZTcyMTZETHVPRGdoaFlyVDU4ZHUxeW5tMW05K2drVmkw?=
 =?utf-8?B?VTZPanhMSmY2U1Fvd3V0eThXTWZKV3VNcG5seXhsd0ZCMzlWUWtiV0NIL2hZ?=
 =?utf-8?B?WENMbm51TG8rdWxtcXlWamNPdlMrUE5CdEM0NWRIaEFUUGZteTd6dzJIUkx6?=
 =?utf-8?B?aFV2ZE5HRmYwRjBHWU9LMnJHSjcyeWMxM3Zib05WWDdLTngvOU5mVXVxR1Vp?=
 =?utf-8?B?UG5pSUNsYUIybGxyamlsdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR10MB7447.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aHQzVWZXdEc0K0VBdW92RmVLQThaM1Uvbk5BKy8vUlh5Y0JXWVI4RVlRSjJk?=
 =?utf-8?B?b2ZDVkt3MWo4emM3TXBLSFhkOS9xMW5yM2VZM0IvQ1RKUkxFcUtmaFovbCt4?=
 =?utf-8?B?M2pDRTJMRVp5RjJYdThOLytuNGplL3ZzQ3JZMkZZL0pPL01nUnd0bEdSRXBv?=
 =?utf-8?B?OXNWbzZCOTFValRGZngzVTJZMW1meUdGNURqc0dSOUp2U0xhYmlPdGo4WXo3?=
 =?utf-8?B?Y0VtWjZuMG5Ud2lRZnlzU29SdUdJbjI0MTZEWE94SzdLYnd5dk03NGRXMWRF?=
 =?utf-8?B?b0VORFRTZ2hTSXZVd0VyYWpjNE1ydFZ0aXNwaHI1OTNrSCtIdDFoSnF6cjBS?=
 =?utf-8?B?SHhrNU15elBTQUZDa2hYMkI3dG9yS1hiSVQ4c1h4czNEQ1owRXcyVjZOVkor?=
 =?utf-8?B?NmdzM2Y5N0hQTitnWC82eHBoT0JLVDBSbVllZkpxeFZ3eVgxOEp4SFlSTU1S?=
 =?utf-8?B?T1dGR2ZTUDBJV1Z4MGhNZUticWZMQnZFMzFUOEc0bkJKaUw0WjhRY2pTYWRX?=
 =?utf-8?B?RVp5aFlCTjlCazRNYmwwWVUwcCs3cW9yWk1WbWJQNnoyQ0ZtVktXaHBhbzhS?=
 =?utf-8?B?U3IzY1VoZEtPK2hkTkN4VDJZZEJaa1R3WTFWdmRTWDJGN0YveFFpeFFxWGdh?=
 =?utf-8?B?bFIrbjFRUFlRUU1SYzZUL0FTY0ZxTHF2Y1cySGlFckd2N01IM2x6TWlpZTI0?=
 =?utf-8?B?WDJ1VlFQZEFzZnNLRHhNWXRKUjZjdFJkM0RMUG1WVlVzQVpoM2puTjUxUEVR?=
 =?utf-8?B?OE5qRHFTU3NPZjQzWmY1cmhSSnV2a1hFdlppNmxkNU5mVWg2bm5YTFl5SXFx?=
 =?utf-8?B?R1JjQkJoVTdRMGd4UmpSRXNSTHNpd0tzbGpobmVJOGYrL0JRdVkyL0hhbDVm?=
 =?utf-8?B?QXY0eE9KbXRjMlI1UmxUK05HL3M0aEduZ1hTeXhrck92K3VzSzhBQ2JXeG5W?=
 =?utf-8?B?cksrNTlvTlczRnFjZm4xUVpTV0xVUytUQ2tYSHd0ZFU1RlNtbFh6M1NqNTNF?=
 =?utf-8?B?dTVwMEpCcGpiQnAvdzdVamhaS0hQeGtGVXhGUWR0T2dvNS9FNnI4N3BhRDIr?=
 =?utf-8?B?ZTRNaHhIaUhwUEVTeGtJTmMxL3pDUnFvaE80eENid1VNYklFWHM1T3pIQTZZ?=
 =?utf-8?B?STJCbmwzZFNYdWdNSnZLUmxwWm4yYWpHN25LUnNsdUFBaEFXMkE4VGtxOVVo?=
 =?utf-8?B?c0cvNExsQkhVY2RJVjY3YTl4aWxVb0FIV21aRHpRREF2SndSZ2c4eENWSjdV?=
 =?utf-8?B?ekFqcHhjdERRTlZNbE1vYTNQbW5NdTh4ZFNsRm9Kb0lGSHorS2syL2JVczU0?=
 =?utf-8?B?aWJwNFd2YUh6R0VzUHhFR3lHTE1VOG5rM3BqNm14OUVUWEt2UFowaEgwdUJU?=
 =?utf-8?B?NGUrSVNNbWZkRFRKbks3L1B4RkEvOTdyTUZJcFNjQWFSV1Z5OG9HL0JwcEJO?=
 =?utf-8?B?c3RDMGlqUEo0LzhGanJHMnJ6ZDFSVVN5SHlEaGFzd0c5QXdBNm1ZWkZvNk9B?=
 =?utf-8?B?bm5kSDZKZVN0WktGSm5oTnNCelRNMjF6RFJRTGUxS25Dc2VLTWlpUWhGZGRq?=
 =?utf-8?B?d1ZuWDVoM0xCNjRseTBhSmtJajIyMldpYmdTaG13bDNCQ0t4Um11SjQweWFB?=
 =?utf-8?B?OVBTNVRqM0dxUjd6L0h0N1dITTFuOHFOZFlrMGNtbEFKc3kyeFcyNFZsTVc3?=
 =?utf-8?B?UEpzMGRxdG52bE8xemh3aXJrZDVKYVNmZUdYT1RyVWZYZjFsa01xTmY3KzJY?=
 =?utf-8?B?ZW9Kd3h2OC9JMlpHWEsyd0pGL2g3UEo2ZldldHlJdlBTbUt2NVlqQ3pTazh0?=
 =?utf-8?B?OTl4OW1RZlRTL1gxa3l0TWhUYVJTYnFLUXF5ZUd1cktaTGpOK3lqYis3NTlq?=
 =?utf-8?B?bmZZaE5mdXV5RlBDY2txS1l1WlJrL0d1S3hvSWdraTZEV0M5TzF1YktBaDNC?=
 =?utf-8?B?NGxyQ0ZZUmFjZEZrdmdiTjBtRFNvSDNlMmRlaEYwOGlOQS9FcWJHR2FGdVJ1?=
 =?utf-8?B?TVV5ZzdrTlhTNjgzS216Q1dJMEdLWHlqd2xSZ0tmaStyS1JTM2M4dW9BZ3lk?=
 =?utf-8?B?L2I0VmV3dDBpU3VUSHJXd1pIOGxqOUZGZDdmQ3VPMm5GTTNRaUo2blY2U1Jl?=
 =?utf-8?B?M1FDc09wblpDUnN2Rk5MK045QmZBN0l1cU54c29UN1JSNEpGQXVwcTN2M0pk?=
 =?utf-8?B?MUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	SVtCJd87fTPFXNOGG/dASBi/fGYDnpzNFbZidQirWOY7Xfod+pNrAE/LTZr+NASPPHb1xddxfY8fymQ6WHH87LlvGqSHaD42UrA50ukt3b4YK/rpxncoOVoufPeqzMKgjFD13bMG5l3wFt9tO3k6+vec57GbnpAidtmfDYzk6a7jef+D2MUlBsAw/3JnJTHUPIfG6kxavlstx8nt9ydJemMHTOgcA9lmGcvE+sD+wGZXepSr1Pa18zjXUM6YXSqPYB4M1m6f1mlSqlDM6E/VxBHg3ezU8ndFgrus6H0trJG1TNNHRYmeBrTIiaveY5xn5P2oEiYXgLxZGpMtffzRsl854GKZ06A7gWT9ayvwYigtdJOclTIkh9kO/tg0e3SgXy0h+qUY2h0tTiLZXO39dgNtPC+OMt4gSlg6YqnMzEP6r/d5LRUSFbN9uFejyCIY7GQSwlEZ6tUPIoGc35d+eRZTulcSlwtDxfFIO8KUkY9jkzhSro2VsImu3/7XaXZ9/UhfZ/Y05sx0Bnae3YND5dALKY9J3KAy0/iEmAyqxJKjUntkS8/d5hVzpyfbBkW0GEQZvI1EwXvdg3sdyCagCAwoIw5bo307carWDP2JD8w=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a769661-d82d-4ea8-10c7-08dcbb006c02
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2024 18:56:06.7487
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pGgP2W9mqMGc+3BAq10PXKMjatccpR0xXXheNAOACPrEfDP+5FT+m+g1VK70bUIuCDT2P0mWFyNHDzxjMGfZRYipakeJDHjucGe1EDsdxrI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7753
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-12_12,2024-08-12_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 bulkscore=0
 phishscore=0 malwarescore=0 suspectscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408120140
X-Proofpoint-ORIG-GUID: FJKKR3nombZeghMnSTNEuU7dvSjSIg21
X-Proofpoint-GUID: FJKKR3nombZeghMnSTNEuU7dvSjSIg21

On 8/12/2024 2:40 PM, Jason Gunthorpe wrote:
> On Mon, Aug 12, 2024 at 02:09:11PM -0400, Steven Sistare wrote:
>> I have been using QEMU to test legacy vfio vs iommufd compatibility vfio.
>> I find that backing guest memory with an ext4 file /root/guest.ram
>> succeeds for legacy but fails for iommufd, with EFAULT in
>> IOMMU_IOAS_MAP -> ... __get_user_pages -> check_vma_flags.  Ditto for a
>> hugetlbfs file.  This is with unmodified kernels, no live update changes.
>>
>> Is this expected?
> 
> Yes - I'm surprised that VFIO is not failing though?
> 
> /*
>   * Writing to file-backed mappings which require folio dirty tracking using GUP
>   * is a fundamentally broken operation, as kernel write access to GUP mappings
>   * do not adhere to the semantics expected by a file system.
>   *
>   * Consider the following scenario:-
>   *
>   * 1. A folio is written to via GUP which write-faults the memory, notifying
>   *    the file system and dirtying the folio.
>   * 2. Later, writeback is triggered, resulting in the folio being cleaned and
>   *    the PTE being marked read-only.
>   * 3. The GUP caller writes to the folio, as it is mapped read/write via the
>   *    direct mapping.
>   * 4. The GUP caller, now done with the page, unpins it and sets it dirty
>   *    (though it does not have to).
>   *
>   * This results in both data being written to a folio without writenotify, and
>   * the folio being dirtied unexpectedly (if the caller decides to do so).
>   */
> static bool writable_file_mapping_allowed(struct vm_area_struct *vma,
> 					  unsigned long gup_flags)
> {
> 
> Why doesn't that fail in the VFIO case? I didn't notice anything
> special there that would make it work???

vfio_dma_do_map -> vfio_pin_map_dma -> vfio_pin_pages_remote does not call GUP,
it just grabs a reference to each page.

> I recall we talked about allowing old stuff to keep working but I
> don't see any implementation of that?

Nor I.  Unless "keep old stuff working" is implemented by omitting the CONFIG
definitions for iommufd.

- Steve
