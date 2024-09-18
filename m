Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08AAD1C173D
	for <iommu@lists.linux.dev>; Wed, 18 Sep 2024 14:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726671089; cv=fail; b=lGJ3tPGruoVukiaG4hc2tqwkMvAojFs0gwgoUyxsg2X0mUDlFKP513/YtnPxeSdZTopCu7viErmSuSXGaaOwDBnfjUCeTn8kNmOl4vi6lCIOIa9hmTOtyO+UJZfw3YpDV3ElrQtgG5xRDEHxfg/b1ardAyy0YJeZ0LZt0KhYUXI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726671089; c=relaxed/simple;
	bh=MLwrY1W8495enm1UmFN/mVc9CIqwg0awk+IcTur6luc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cb0f3xsyVJBRxzyfTMX3wa3AicoTegmHpHsF6yvV/IYIjHkae0vdmOLAmTkempvvBJFa6Ge9iN3ujEBNLwT5v51KyLO2BOHsT8IWSoTQ2t8A4g7GyoKo3ORbJOYztuoWciZYH+w8CT6Mfh2897eeWpu6iIWZyyitmsRNdQOXKEc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UBKU8k5L; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=hP1DyUcr; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UBKU8k5L";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="hP1DyUcr"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48IEl1MP001173;
	Wed, 18 Sep 2024 14:51:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=pS3KsQzgD/a6BDR/d2Q5sdYEySeApsgjfNoRR8K8fNE=; b=
	UBKU8k5L81kYg9YpcO4HnXXWJZM8qJE3C6G1jvGJzC3il/qcE8k6HTSGiE7T8FsV
	bQz8TGr5k47W1nMN2PSrKhFgZZawG0d/ftmwhKf5km3KP0zqGqB5+kXxzE2X2Iha
	Gq2r93Tjxh/cBfZMiofTIIkkJJLPUPOVTqII8fCeP2iBDn8enaYRVlQYKGd1eDqo
	MRac5x2drjgHAlloPPJNsnvN6xzsbFpBQNGNwKJX9Zzjh0RSZYi8Gp48hnBb2vKn
	fa1eehvu81sHMGNWIjUPpfyW1c39T81+uphELsgrLbli5Al5dQ1XpRXsvnuWAgjl
	2AWRUxOOIhRdtd00u498xA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41n3sfshrk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Sep 2024 14:51:18 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48IEeesm015841;
	Wed, 18 Sep 2024 14:51:16 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41nyg4q02x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Sep 2024 14:51:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J38M7EiePeoQG1CDAA+SCKUeepIpkYksfDK2Ab9XYHU4q9dOZqJOiy90N8s2T3NGBjFY7xVODYyAanjOsO1X10HHTUUpulZxACrS3htepe7YIFm8KIUn3H+zkJCSb5/k6dHOhZsI4Doz83V6ArOzWLpZ/DbGuezivHX0JZCxCgbJt/Z76uQtBaY3LhSZTM6YviBBatIFVWhJByHUrSUaY15jrKlCDkqtck5qmv+KRNpHKyirO46ytJNeL0a9ek7JzbrgD+ahAE0oErNM7scvwzs+vzHthfxPPQqSVVcVyUeoXYSzx6SfWg+aLRcyelfNC3VdZd9QY66uJiPttNpN5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pS3KsQzgD/a6BDR/d2Q5sdYEySeApsgjfNoRR8K8fNE=;
 b=AhfPEsuuEHgEhMOdE7/8T2Tq7er+X0lUllrCB3lL/YCCntYUBk3jvVYcJ011qpwnH21IqTPyiw9ULCMQApeIXdBaMLOC0Eveo3byyFWIFDAV5XAuSVd1w8M3yadOlBkEMoxYQQWc0E3Owjlyj18w0miZYHXS8+ZLXyTHRQxHUMnTNeHtYIkE30sTDaQ29PyOSGDf0KX2i4lKcCv4fdqIcTtD9KTxKzduUD2GFZ99LQVxwJHdWQ7RkRdIMQ2IQgqlXmaKCZU4AFYj75R/XWqKYiuK9MM7/GKJPow8c+luNSKmssIGeqVmZl52FQAD4pjw3P4Uq99wUwJjCPuf9DhrbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pS3KsQzgD/a6BDR/d2Q5sdYEySeApsgjfNoRR8K8fNE=;
 b=hP1DyUcrc4bPx6OtlCS0fiEccD93bughmZ0g+z5A1lZVVSx+jkeBVgbDvwm/skdJcD969hjZRI02iyYp3uvkvpJmBZdp/4WbLy4K6YEt1wkGyAET9LY2T9yExU+QLMExIPP8wq2JffY194B74i+sDQnIiexs/bCxixgWufrq5ck=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by SJ0PR10MB5672.namprd10.prod.outlook.com (2603:10b6:a03:3ef::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.16; Wed, 18 Sep
 2024 14:51:14 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%7]) with mapi id 15.20.7982.012; Wed, 18 Sep 2024
 14:51:14 +0000
Message-ID: <204fd4a6-6461-40ab-bcb4-066dbf087232@oracle.com>
Date: Wed, 18 Sep 2024 10:51:11 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1 1/9] mm/gup: repin_folio_unhugely
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
References: <1726319158-283074-1-git-send-email-steven.sistare@oracle.com>
 <1726319158-283074-2-git-send-email-steven.sistare@oracle.com>
 <ZudFcANtENlaRJ+r@nvidia.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ZudFcANtENlaRJ+r@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0986.namprd03.prod.outlook.com
 (2603:10b6:408:109::31) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|SJ0PR10MB5672:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a40c3cd-7659-475c-87f1-08dcd7f157bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aFlrNWl1ZjkyN1RQNHVuUEpvQTYzR0J6SVNrMmNEODZwYkFUMmFDeDY4U3V0?=
 =?utf-8?B?bE0rSmdqVjNoZTRHdmF6UW5qTEpBSmVWMDAwb3dWdEQvcEVvdWUxNXJCYlds?=
 =?utf-8?B?NEEwK0Z5TVUvWjBkSkllMGZLbHRZUkVSa0RkRGd0OVgxNndtT0NwZnRtNHpn?=
 =?utf-8?B?c3UwZ01NTlB6T0xvYjlITklPNklwVjl5YTBzaFM0c3lTVjVkY2ZCcjEvbThH?=
 =?utf-8?B?bzc2eE5DeXlQSXR0MTd0emp0ZFZPdEZDaU1BOFJNa0hiUTV0dUJYSnI2aFg0?=
 =?utf-8?B?a0FjTGM0WW5WaU9RNTNQQzI1ZXdFdjJqRkhYZWJERElZdGNyRUhDNEVtcDNy?=
 =?utf-8?B?aTVIaFBBdmtiV1N5SjhlZ3NHYkRoRXhxNldLanhWVmtWNGkwRUNHZ3R0TytW?=
 =?utf-8?B?WTM2SzEzV0FjdkxaNWY2ZWFKemR1eG5PK213K2JLbjJzaWdkbjFobGVZQ3hL?=
 =?utf-8?B?M1ZZM2dPalBmTVZTelZ4Zm1XWGxvRHFLVkJ6ekI1L085RjRnQ2RTQkJIRkc5?=
 =?utf-8?B?MVpEdGgrSVljbGt0R0daRTh4anhSMzFlajhPVFlFeE9rRWp6cTRZTnkzelZw?=
 =?utf-8?B?ZWN2eG9lK2lMR0RWVGlVcWYwRG92R01kNlhQSElOYjNQaXM3ZTZpVDd6OTNz?=
 =?utf-8?B?blM1VW9jM3ZPN1RuWjNsRlRDWXh3dW13MGdHUVk5T1d4by9EdnB0ZEZndkc0?=
 =?utf-8?B?OFk0SFZkclU0Z0lYSzRsbXh3Z210RU9kL1hNWlVRSGRjR0NjUGZCUWRsZU9T?=
 =?utf-8?B?R1duZ2Zkc0o4WURIS3FPODJYMjN4UmFEaGN0ZFFVbVUvNmVla1Z0MWNoeFE3?=
 =?utf-8?B?NG9oZzFTOEwxT1B6Q3VSMVcxVWpkeFowclpkaDduTndub3JqM1ZBb1R2ZW9n?=
 =?utf-8?B?TTM1VlliYWZzeExVZlFlRXhGR3htdnJzZCs0cGQvWGhBNVJnZWdmR3ZRcHE1?=
 =?utf-8?B?VitzZ3Nod2MrY2xzVjlRS0JSM3IrZmpKSk5ueElnckxmQlQvUCtpS2hhUXht?=
 =?utf-8?B?MEZyNkVyOTNmNkljRmJMV3JNL2U3ekt5YmZUL1kzZzQxcXdDNU52d0F2NHpj?=
 =?utf-8?B?RlJqYllvdDAzZU55L0RyR2pnclkxOE82ZzFkWFRFLzI0T0MxYjhienBFNjRS?=
 =?utf-8?B?NlYwTHhKcHI3ZllrR1VhQVBrSUg1SEpLVlBYY3BMRXJhVlRwbWZ2bURmZmFG?=
 =?utf-8?B?a011eU40TnM2akVOY0FBZHQ4a2hKbTl0QUM4V1UwNGRHUFhIM2htZnpsVk0r?=
 =?utf-8?B?Rm5xdXBJQUdlTG5hMUNxZU9nN0REeTJ1emVCZzUzYVZhQ2dFMkxRMnE1MTQ5?=
 =?utf-8?B?MENvZU5mc1Q3MExoalVtT0l3NHZZZHprMm15RktaTkdJZ3MxV0M0U2UwTnRC?=
 =?utf-8?B?WlpFTEhiSXVVSXdwWlZCSzlWTmtqUWNQVk43cHNlNFNLNTFzdzVkWlRxNGxX?=
 =?utf-8?B?TktJdlQya05iR1FkT1lOVmZHU2RZV0ZVeEl2dnQwQVNYckdGZDFPMEtpTGRR?=
 =?utf-8?B?RkR4NnZRRjV6aDJlQzl0ZUJKNUZKVm5rc1hObEpIZ3U0Ylpqd01ncmpFbk1s?=
 =?utf-8?B?dzVWOGdHem5ieCtJN2JzYUdHOG9iQU1aYXVNUjJEVWxLUi82U0NjdzU3ZFRB?=
 =?utf-8?B?Vnh6c0hsbVd4dXZwUVRCcjFUTDE3ck9ySCtNWFpFMmxYRnpET0gxL2hRYjgw?=
 =?utf-8?B?VW5CKzBlVEQxMmVIaFQ3T1hKMWwwSWQyT2lwWmpjbzVoaWpJSHE1UDFDa2p5?=
 =?utf-8?B?S0gybndlcDRuMEZEZVo3QzFDTmZKZ1R3SXFMWng2d0k0dWM5d0VLYVhTeGlB?=
 =?utf-8?B?cEpCVXhYVFlRYW8vUWxlUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR10MB7447.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aEdtSVZBM0txN2hITkF3OEhmTTh3eWFLU25TdFpLdFBJZkZzR0hiQkQ4Vytu?=
 =?utf-8?B?c3BheU45cWt5TXMxbTREUDcxOEV3THZjVUxuSmFBVjZmNCtxL1lJRnkzT293?=
 =?utf-8?B?Wk9nRThqVUs5aFg4SFlXa3ppM21oRjdDT01VK21BdVJibllwcS9JUTlHL3Jz?=
 =?utf-8?B?R1dwbndMb1NiN2gyZFpLSG9SVyt3cTRaMjR5VGdEalMyK1R0OE9CYkprYk5D?=
 =?utf-8?B?aDdJcnR0Wjg2Q1VFUkc4dDAwS29PeUt3eTYxaEdiWTJxZGhTeXNwQTZoRHZE?=
 =?utf-8?B?L0FRSEliSnVORXZ0anY1U0lEeGphS0VDNjdLakxOMzlHZFcyYTZqZ1kveFBK?=
 =?utf-8?B?c0hKUUhFQ1NGaUphOFc3SjhxMTg4MVVjZ0RDZm81cHJ5RGxuejc2MktXSm42?=
 =?utf-8?B?QWdiVVZ3U2I4QnJseUNISXFJelpuY2t1RjV3eTNGKzZnZG1oR3gxNnhCRllr?=
 =?utf-8?B?Q3NIQkdINHA5eE9uSFVxU2tRZ3k5R25Mazd1U05naEN2NGJWMnczeVd4cTdN?=
 =?utf-8?B?aGw2YzhWYjBHMVQ4YWxtbTErTjdUZU9md21Ba2ttMTlGYlpkT3BISHUyUFJX?=
 =?utf-8?B?b2lXTGpVSFUybEdxajFoMDhGMThZWVdNTVpnUDdubko4SE85OWJXUDNtb2Fn?=
 =?utf-8?B?MTVQdGVxNnF2eUpKSTVtME5HMG9HWkRLZkZXeVNEd0doR1BYaXA4MUdZNThs?=
 =?utf-8?B?Z0hFbDlPdkZZZWJvaWdQdmg5b1N3NXRYVVdYV3N5NE11R1J6eGM0T2p1VlRn?=
 =?utf-8?B?ZC9GYnpXdUk0dlRMYll0SlY4TjI0c0lOK1lzaE5GY2VBamZScnVRT2Q2Y0Ex?=
 =?utf-8?B?RXh1ejc4ek5tTjkyN0NtWm44cTFTeWtNZVVNUmJGMEtWb1o5c0tSNlVNNVBo?=
 =?utf-8?B?Rk1CUXpTaFhoc09HOFM4cGhhNHRvRE9mc3BxZ3I0eElqMUN3cFhCd3Rjd1l2?=
 =?utf-8?B?emg4TE1qOVdPOXVaV2hLMitUQjNudll0MGVzbkR5Um1Fc0dXbnY2NWFPbDll?=
 =?utf-8?B?R2xCN3QwQml5WFh4c3I3YnZRYnFJSTIyVFgvQkZTR1FVQ2ZMWXRmS0JSbGx2?=
 =?utf-8?B?eTBFdVZSMkdEK2ZqZ2FZZm9oTjlTL3BvZ2E5RGpBY1huV1JsTjdpTVVRUXQ4?=
 =?utf-8?B?WW40TzkwT25FcHFlT1JVQ0hMMDIyeEdFYk02dCtxeDlrcWdKWmNPQjBmUEJ5?=
 =?utf-8?B?VzVpVEcwcm5XQWt2SkxPZ0FqaVBHN2JRbnQxcVpJWWd1YkY3SUJicEVUTW1O?=
 =?utf-8?B?RlQ0Q1NCbFZyRmZiT0ZvMm1Rd3hyRTVlRW1jZ2xKUjBMSHplNDlWUlhZUTNj?=
 =?utf-8?B?bzBCK05Qa3Q5ZnVhbCtRd3lrL25UNExIUVVRdkVyMExjdkYrdEZzV2Z0NC93?=
 =?utf-8?B?YUVxTEE1SXNQMjJuYUE0NUpJcEJwdkNLZWswSXNxZWJoRWgyaHpUdHdxU2Y3?=
 =?utf-8?B?c1EyYm1FQ0Q2dWdLck1XVnhTVVo0WnhsbHlmalFHSUdaRkljKzVzdTBZMDk2?=
 =?utf-8?B?SWR0UU05TEFWc0k0bXlnRHVwZHR5TEFydXk1MnkzenVKNGh2Skt6ZERVTVpu?=
 =?utf-8?B?TlpTcmNGQWhJU2VaT29mRXZVSFBnNnMwcUhqVTRURmxpUi9xWFZCTldDR1RO?=
 =?utf-8?B?L1p6QWtkaXhQZlpTaXF6OVM2MzFERllOVkNnQytOVnIyRzNycFIrSlUwakJr?=
 =?utf-8?B?OE40Y0hLaE85QzhoZlFQdTVibjVsK25sczkzOE80SXBnMlJNWkM0ZlEyS1hm?=
 =?utf-8?B?SWJvc0w0c3hNL1ZmQ0drYk9pR0s3T0dXa0xvSENYS2h6TkgrcGhwV2ZtWkJ0?=
 =?utf-8?B?aFk3SDVYaE16Umk2S1ZZNUF5TkRFamhHQlpJZlMyYjdSNjlCQTdNSXFCRllM?=
 =?utf-8?B?Tm5rME9SUldpR2VKeW1KMmhFOFVlNUQ4RGJ1MzhHVnZTbG9xWmxVNi9adGgr?=
 =?utf-8?B?SUxSUmtkT0k1RFhtOGlPVHJBZ3M1aThFVUVGRTFYSTh3NU5Mb1hUSUZ5ZTNB?=
 =?utf-8?B?dW1oaVQ4WG5lcjB1bG0zR2ZQamxjL0c0OFhVakM1OVhsNEJCdnZ5eWZJUXU4?=
 =?utf-8?B?K0FTV1YwVE5tSkNXUGptNmtreGxTNmFYUUVObjE4N2pWQnlNTExpZS92Q1l1?=
 =?utf-8?B?VTQ4ZFNtRUdoWGFscGh3UGZRaHRYKzNmNkJVUDQ4R3JidC9PdmhxMkIrMlo3?=
 =?utf-8?B?bVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Wmz7ODqE0wMmYSVzZi/1bGKIKSJ3LfsjNVlevxvyDgXaejmRvFpDIdDdXKDaszexKT4UB9rmapnmqUvGhdjNeoomTf6DZjMX7iDLZDsl6apBOHG4IHpO3KmxN+DMwVZd313gRH7SXRiHVnt7vb+RxgAkbLbLq+LCeBsFqG81OUSIwaDH50Ha5xqEOIGVwP0YRKhOfJVeayucj7xca3ZqLJCFCQEU+/SQB65gY2OSCrE7eZZaCIXm/q9RGbCL0M7Pk4BuB43WocZSEHGEtVYu30Fvq8ApJaHlhWoSVShLEDo6bb+WTfxJ+zrjMWU1e+qNjQpzDF39AJXu8UAKWQhms1e3H/TpE6zIQiA9rkYv4RUtTW9UhU6ZnnTM+mjLvj2+s0HZF+ms8kb2cH2wR7g43gxv8QPI6dIvnaHpnWRcdKzpkaFYs/SYxRbSYsWZQg176MvGyG9RCW+mk51+tILPv/i1hvlF/J7CzygTc+Q9Pa8lZk3LHBKfwBg0YQ9EVqio3/WLUhVfQqdCE/TwPtHM2Vr8RnoItKyg3oVVt5xL24oHkMr4zoGhp84FXHb7gkm5FgervpglDjQt9oxVOZkiIcfhBTso3fIV82kz1Jbwvcc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a40c3cd-7659-475c-87f1-08dcd7f157bc
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2024 14:51:14.0077
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1MJyOVxlViJRqal7wyjZl2Nrhdva++nuv3uq0IMuLNL8h8tzVZ/OQ/axRXN7sMkSuXgtvOalBb9jsSAZD/tqNBSmwuU5cX+a4ZHo0MtESuo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5672
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-18_10,2024-09-18_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2409180096
X-Proofpoint-GUID: Dd0-l9XPMaaCWzPJ3IrzqPPHUmSTlndG
X-Proofpoint-ORIG-GUID: Dd0-l9XPMaaCWzPJ3IrzqPPHUmSTlndG

On 9/15/2024 4:37 PM, Jason Gunthorpe wrote:
> On Sat, Sep 14, 2024 at 06:05:50AM -0700, Steve Sistare wrote:
>> diff --git a/mm/gup.c b/mm/gup.c
>> index 947881ff..f8f3f2a 100644
>> --- a/mm/gup.c
>> +++ b/mm/gup.c
>> @@ -3720,3 +3720,21 @@ long memfd_pin_folios(struct file *memfd, loff_t start, loff_t end,
>>   	return ret;
>>   }
>>   EXPORT_SYMBOL_GPL(memfd_pin_folios);
>> +
>> +/**
>> + * repin_folio_unhugely() - repin a folio at small page granularity
>> + * @folio: the folio to repin
>> + * @npin:  the number of pages pinned in the folio
>> + *
>> + * Given a huge page folio that is already pinned, and the number of small
>> + * pages that are pinned in it, adjust the pincount to reflect small-page
>> + * granularity.  Each small page can later be unpinned individually.
>> + */
> 
> I think the language choice here is probably not entirely consistent
> with the rest of the code

Yes, a good name was not obvious to me, to I submitted a slightly flippant
name to generate some discussion :)

> 
> Maybe
> 
>   folio_split_user_page_pin(folio, npages)
>   @npages: The new number of pages the folio pin reference should hold
> 
>   Given a high order folio that is already pinned adjust the reference
>   count to allow unpin_user_page_range() and related to be called on a
>   the folio. npages is the number of pages that will be passed to a
>   future unpin_user_page_range().
> 
> Which anchors it in the purpose a little more

Thanks, I will use this if no one objects.

- Steve

> The implementation looked OK to me
> 
> Jason
