Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837701AA1E0
	for <iommu@lists.linux.dev>; Mon, 28 Apr 2025 17:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745862954; cv=fail; b=PZFJq9PjVi2OokRPKKDgNZI7jT2q+xUQuay+GLlh/gC+n65eZxRT3GPTO0w6TOdwRmDnXAkFZxwP1BkBVFG1EEjRHOTSGPZqms4cC2CnINcx2Q6kP1kQyt+LkibVueQp2rHGME57nPqOS0Ml1+IHfZRUo+VzGJ6WCfnJwSG7e/c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745862954; c=relaxed/simple;
	bh=J10Xqq20KC28wLs3F3vjLvdk3BtIYGv4aS93nh2zlxo=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bmR04hkoCHsUape86x6tLIobcE0yvNGc33r1qwHPV7WVA76FMpgKHzS+lVsPxc0isZtIXBH4wQj1gcsEsAIcsakwcQlGS+aBO3tuoDulUJN7nueE5xG0+R3qFEsXhbrSmZXhFS7FkU6yDWKMGlq/+/vKlLPYxkigjJ4aP1fgUGU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XD6GLaAb; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=k6wJLbwq; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XD6GLaAb";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="k6wJLbwq"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53SHrb63002789;
	Mon, 28 Apr 2025 17:55:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=HnyPxnIT2//lnYjRgs0H4Xx56TeRjTQG9806FgFNhIM=; b=
	XD6GLaAbXfQEL1hpv1undVeS+cxb/rfIavQId5rOf/8xGnGmEoBGsK2pqJRnuzZE
	enTFune0NPmdJ58qQ5UohcewSnLtplYgTxnzg8xwBFgrEbjtCH6zdhtYLH4t+XRh
	p/MAEluKZ56xs3KGTJw37MW35UWVAPWIUz2CVJAhHbk0blaz/5y8oLsfD20hwObT
	4EGg/pHa0hq/WY+nKfDcXuMvX8Mjdc2FwtoaF7hoyUFqFGIJ0FpOpVjkMxjacY4y
	RQN7Cga6Tnvo+uS0XVs3r6vTRfdK+L3XdjFebf37Aog3vGK8AGTLcA0i3SvhYwcR
	KWfpq9ZkaDAYmBUonKGaWA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46aeeu807h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Apr 2025 17:55:27 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53SGqGSF033509;
	Mon, 28 Apr 2025 17:55:26 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azlp17010023.outbound.protection.outlook.com [40.93.12.23])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 468nx8s20g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Apr 2025 17:55:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cbPhFEYtV4WD1chG6vlVXBTi2ll0POafQDvPjiIOxTC6/TMPN/sRabZcC7Bnbc8kMyDOEqxt3IjF1tcFW2B0F2Xk0MPSicH5SaPoyOyQPUXzlwsagZMUX1Coc2OooOTXKFfXpTv03UZVu6yKRTXtynDQ0i7z+zA0tmVAxJXMSjWjq4kuxWeIS4sheFUJ77tP7Pv/h3lCMoMfdMEZR0clyhZyZpHYQ0poBqsJBMlqs6ya+IBm5BCbdhXFGg/0CC8/PMFHvBFDGoi6O2+4TpQkJuCI4D35uC/a+5pEiK+QAP0fLZlHx7XoVoh9GPC8jAeV1PDJolww5/oqWe5KzuslWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HnyPxnIT2//lnYjRgs0H4Xx56TeRjTQG9806FgFNhIM=;
 b=k1zpl4FaqZAZ9j41F9wfA5jJn4aEy5maElOZpBuXiV73e6Lp5hUxKq5HLmmSQf5plyouk1n8XZK1SV5lytSWUlRN2ZOzNeKJCDGADPBOefdR2gOeb94DbdIr9AOWpBEHejXfYcCiP9qRoBM+xO8bsSClGNPN2fE70Lyfk5SkQYHaZg9c30DBVKytVQAOG26895NgOsKcTIbiIbI2HYEhQwD9VUchvOYSLOo6BgpgrqumMPJWOhT3P+aF5mhapaogQvy/plJujK5eS6vwVfEhRINOUWg6ToXjE8poiIsMqUKPBc8D6uCq3SM7LgPGyjbySo39D0nKNgtysRkHpDB97g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HnyPxnIT2//lnYjRgs0H4Xx56TeRjTQG9806FgFNhIM=;
 b=k6wJLbwqSUxuGg5WeCK7pKdEaPx1txwE0idvnvW/0T2s0CXbO+/2wtcc9qvY18MIk1eRB//PgB1j7Ijaws71iIUCHgx5s8/31GomeyGWUXWtXpFV9b64G/zBYajgU6Gd8tQEDBz0QB5lt5RL1Q6Fkv6CV9CXcylBut5JjFIwHuI=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by MW4PR10MB5725.namprd10.prod.outlook.com (2603:10b6:303:18b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Mon, 28 Apr
 2025 17:55:22 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c%2]) with mapi id 15.20.8678.028; Mon, 28 Apr 2025
 17:55:22 +0000
Message-ID: <d03d2ea6-323b-490e-b53c-d2e6d9c31b6f@oracle.com>
Date: Mon, 28 Apr 2025 23:25:07 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH v6 1/3] arm64: Add BBM Level 2 cpu feature
To: =?UTF-8?Q?Miko=C5=82aj_Lenczewski?= <miko.lenczewski@arm.com>,
        ryan.roberts@arm.com, suzuki.poulose@arm.com,
        yang@os.amperecomputing.com, corbet@lwn.net, catalin.marinas@arm.com,
        will@kernel.org, jean-philippe@linaro.org, robin.murphy@arm.com,
        joro@8bytes.org, akpm@linux-foundation.org, paulmck@kernel.org,
        mark.rutland@arm.com, joey.gouly@arm.com, maz@kernel.org,
        james.morse@arm.com, broonie@kernel.org, oliver.upton@linux.dev,
        baohua@kernel.org, david@redhat.com, ioworker0@gmail.com, jgg@ziepe.ca,
        nicolinc@nvidia.com, mshavit@google.com, jsnitsel@redhat.com,
        smostafa@google.com, kevin.tian@intel.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev
References: <20250428153514.55772-2-miko.lenczewski@arm.com>
 <20250428153514.55772-4-miko.lenczewski@arm.com>
Content-Language: en-US
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
In-Reply-To: <20250428153514.55772-4-miko.lenczewski@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG3P274CA0009.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::21)
 To DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|MW4PR10MB5725:EE_
X-MS-Office365-Filtering-Correlation-Id: ad08004d-1f6e-4fff-e11b-08dd867dd8bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WUZCOGxQcDlKTmtjbXp4dm5FQTQxY0Mvek9MUUhCeXZEVUFpYXorU25iZGVJ?=
 =?utf-8?B?UU9tQ1U5QzQ2ODJ0Q3NCS3lPNjZ6cmE1Y2dXa2tqRUhHSHhSUnY1bXRybXRP?=
 =?utf-8?B?aUp1eVBhWWtFMmZqQ0VPOFVCd0ZQWmdmdktQanNjMUtwUFZqUmFFRVRKVnkx?=
 =?utf-8?B?dWdicEg4b29JdUtOZmNOcXc0K2RDTW9WOFIzS21aekxvUUJYVVhkTVZTS2FJ?=
 =?utf-8?B?S0hwZDJFQ3lZdnJGUFhINWpDY1VjSFpkQzZmQ2lHbmx0WHRVQkQ3RE54dTZP?=
 =?utf-8?B?cVpyaTY1MFE3Q1ZDUS9tY1hRZEZwckU4ODNzY2ZVS0hiTkNqR1dobVlHeEJ4?=
 =?utf-8?B?bWJNNzdJaVJJVkI2cGtYNkhZcnJkOXMxUVdld0tTSnRvOFkvY01vMzFkTk9C?=
 =?utf-8?B?aXhXR2NkUi9pRzhYeXJkbUFNK0lINkFLU0pCVkt2OWtvTGZlN0U3azVqa0tX?=
 =?utf-8?B?NEZBTE84TUFmZ3BlVW9hRDgxT0NzZVhpU2U4M1FMWE5wYlpocW9ONjNMeC9I?=
 =?utf-8?B?dFNMNW8yTVVjVGgwZVI2bmp1ZDhsbVNFSGRSTktrcEI1MEpNWnRvYVIvTkl6?=
 =?utf-8?B?aVRtS3lRVldwYjF0cG5NUCtXb3FrK00rdHdWazRHd0ZHRXdlTFlMTmViOVRS?=
 =?utf-8?B?cTZwY2JadTJPdG1FUDNaZDUvc2VlQm5DWno1b21mbzRiMm53M0NzSS94dzZy?=
 =?utf-8?B?dTFPeGhmNHhUcXpaOFdjQnBlVHQyNGNEbE5oeFhBczBzRWdlQ29aYTdvL2dC?=
 =?utf-8?B?M2hZQ21nR0FtNHZTZHdLODdyeWpJeHlMSmhKNzJpeFdWekx1ZG1RYTI4STFs?=
 =?utf-8?B?Q0F6RGYzN0FnRWJBWnhqKzZoQUNwQW5JK2hCWm1OWTJPSzdsemdDSi9VVDVV?=
 =?utf-8?B?ZU9CTGJTd2FiVjVOcWJIUldUQTVoZW9XYUx4WEhwelhWWGpRRnh1cWY5dTBz?=
 =?utf-8?B?ZXNEQm1DTE9tbUdEcHBHRXI5UVMrQmhqdWVURXZiTmNubDJNb2hqK0hFWW9w?=
 =?utf-8?B?aW1CZkI1MDJ0WXpEcENZZEVnNFBBRGZIWTZsd3dxeDlXc2RQekI0ZHc2bDk0?=
 =?utf-8?B?TjUrZEN6SVR6Z2pQNDdlNkt1cEFQUElqVC9yazVTWS9QTU82b281NE9jT0ZU?=
 =?utf-8?B?NlA0RDlsRFp2SnVCV085emhzVUlGS3FPSnhnKzBUVWpEMHBVY2pyVWhvcldP?=
 =?utf-8?B?SktIcWdZSDZObW5DeTRUYm95SzE2NkgxRVFmTmQvbDZBMFo3c3FkNnUwdlF1?=
 =?utf-8?B?ZWlIM1Qwcmo1TERGcEYwcVpla1RLc0FWZk5VbitqZ3F1QlhYSlJZUVpZSS92?=
 =?utf-8?B?UUlQdWhQYXZTY1oycTZTcGJEd1A4UXNzR2lvbmJwOHhFTXd5d1FmM0V0cUo4?=
 =?utf-8?B?RlpxbkR5UGtXcXJxaktMQUh4dEd0aFhCN3NITmF2aFBUZXF6YWJWS2I2d2R4?=
 =?utf-8?B?clFqR2hpLzFmSG9tbG9IVjA0ekMyWUNyV0RxRWorVmVtMlZLN0J4UC9IS1o3?=
 =?utf-8?B?UXEyR0VFMURVVGlTQ1pkY1RZc3g0ZVNhd2RwcG1aUE03dWwxRU1CVEVrQjNq?=
 =?utf-8?B?Y21vcVFKb29ubVM0UHhDUGlUZDAyL1h6eW9SZCs4bUZ0bDRTck50VlA0eXZa?=
 =?utf-8?B?aTlSN3dweW4wM3lCQ09vQ1A2ZmZxSzZoaFRLdElKUEVJVlJMUk52c1g2Qng2?=
 =?utf-8?B?S2FiT3ByR0FHa1JDVWkyUlVNTHV1UTNFVUZiOGpWaDBZTXFTVllYN2pqdXJZ?=
 =?utf-8?B?NGx3ZGlkeWhpbVBKbFN3YlIxc2o0SUY4SHo3MVZVeUkzcjZSbG1XV1JXMklH?=
 =?utf-8?B?VmhodGVHVkQ0ZTU0ZnJZbmxPa1p0cHhibHFkamZaT3dheUhYZ29KdW4zY0FN?=
 =?utf-8?B?UTZ3YUU4QlZqdTdFLzVDV3hKcTNIbExQanhRT0ptRWJ3UkZWdCs0YUdHTlB3?=
 =?utf-8?B?My9FZHpoelZONVMzTDFtVDhUbytSdXRHaHdSbTlZZ3gxSnY2ZDBoSjNLUTBo?=
 =?utf-8?B?d3VabWVHNFF3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5328.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Vk9CTlJDSkllaDcvRWNkR2VmR1YvTithRXRWdmN3Sm9lZnpVYXZNYVFmckFt?=
 =?utf-8?B?YmI4a1hEYWhiTHJFT2c4NmQ2b1E4bGNKZHkvQmNyczFhYS8xaGIzZEs4YVB0?=
 =?utf-8?B?ZlBWaUgwQ25VTVdxRVQ2VW9QWUFrRlFRR291QVRZbjNLbHUwbFcvWGEwZlRB?=
 =?utf-8?B?bnFHdVVhN3FlK2xuc3dxOFd1bXd2Q2U4Mk5rb2VtZzAzZ0E5c0NOU2dYcngw?=
 =?utf-8?B?OEpGQW0zSGQxYXM0NGlaQWZ0M3RiYVFWNnZ6RWpaOWd5ZU1rdGRlUDVpOC9U?=
 =?utf-8?B?ZmFCWHFXWU45YThaTStKVGNKa25iWDRvNHI2WVBjUXJOWWpuWDBJYlVoUUpC?=
 =?utf-8?B?M3NQT09xbVllaUFic0dNMkhEM1cxVGxUdWhmT0thc0dPZ0xyQzh2bmFKNUdn?=
 =?utf-8?B?NSszVFBNUU1oT1hRSVFpdCtxWmdja05xcStVb1hrYkdVU04vQUNMUzFHTzdD?=
 =?utf-8?B?cjNENnZlV2lNbDV6NnBoQmVBaC90OE5JaE5LNExpVXh6REEyMWtISktRWEFk?=
 =?utf-8?B?MjhDSVdWcFpOaCtXNlF5WjQyazFUTVVhaFlPZ3BSM0dRRE04dlJVelhGeDdo?=
 =?utf-8?B?aTNVcVQvNGI2b2hsSmxnWmRSNEh6ckFsYmk3a3pjUmpjU3NQcGZ6Sk9zem1h?=
 =?utf-8?B?QVBGeFdaU3RGZjQyOTJLTmR3eUc2OFlmcE90VDR0K083R1RvUkkybHdGbkt5?=
 =?utf-8?B?NU5pU0hOQWFHSTRiUENrK0dhSDRTQXNLbmxFMjZLVDlEQmZEZ2pHYWRxd2d6?=
 =?utf-8?B?YWVPOWVUdk1IeVBMNWpYZVJsWk1lMHBPc0s4TkNaMy9DZjVQUk9iOVIyZ2dj?=
 =?utf-8?B?MUFBcW1HNkFRMVZ5NDNWVzEwcEswUzRJTWxvRUFFRVVZVTI3K21JWHc2dFU5?=
 =?utf-8?B?aVgrR2tJSmxvdlEyT0x6cVUzZTQ1VDR2TE0rYjVTSWdlOUFCVnJJUDNxNmVr?=
 =?utf-8?B?NFRHZzdxNXI3MmQ1SkdZU2tPbUtGWUxjcjgvWEdNQmZUYWRNa0NoaEZxZWhY?=
 =?utf-8?B?UUpmai9Uc2g5ekVKNzY5dm9ESUx6czdrbkNuTUQ4M3J2M3cxWFZ4TWJoVHpR?=
 =?utf-8?B?SmtDWHI5TWxzNzZ1eVlCdGI2QXJmaHNvZ1c3Z1hac1NrZ1NsaU5jVXROYVAy?=
 =?utf-8?B?V0UwQ3pqaEt0VDBaWWxSSzlvM1NYVCtydE1zM01xZWVPWTNSL29hdGdPSGU2?=
 =?utf-8?B?dlBzc0hJYzg5aXJqY3czZm9UdytjajVrcnpkbHNEZko5cmRtMUhESjY5Qm1x?=
 =?utf-8?B?NlVuNmx2QTYxcGRMSjF5cDhHYnZucWg0azNkVkhOL1daUjJ3VzJmcDI0aStH?=
 =?utf-8?B?Mm5vTkZSaTFtWFh3OTlCanRob1RrR1hqYnltMDZwcVdvS3BJUHlNSkJMQ3o5?=
 =?utf-8?B?SnFCbTVOVzR0Y3kzdHNtNTNPUXhsOUxNRTR5ZlVnNWE5UFBseFN5Z25nWDgx?=
 =?utf-8?B?Tm9mZ1cwZml5RndYQXM3cEFKQnFLbTB6TmdndUhvRmxFZHNkSmdFaEJLNGYr?=
 =?utf-8?B?MGRkVlpFblk1QXFvT2JBWWNoalVuclJiLzJHQW0xcVEzTmtxZC8wS0lEZHRU?=
 =?utf-8?B?SjFuMEpralo0S0JPR1lhRDZEQXE3YXBndzl3NG9oaWZudDRRYTBMWDEvUGZO?=
 =?utf-8?B?aXR1SEJJWW1PdHQ5c21ieUpncXI5bmE5UGNLMjBjbEhjZmR0di90dE5Tc3h0?=
 =?utf-8?B?QWlXTzkzR3ZYRHFYUGNkajkyRkhZTUxhZGFXMjRHUGpNSlk0NlZxeDRYcVAy?=
 =?utf-8?B?MkQ5WE54aW85TXVaSFFadEp3MnBRWmF1U0V4aXJKYkRDVjNRaXBNWHpEaFRE?=
 =?utf-8?B?Y0JjUFF0d1FjdllvUS9tLzNacmFaM2N2NElzUzg0TUlrOGN2SE0rV1JmWUI1?=
 =?utf-8?B?R2pTMEoxUFRTYUcwZU1GOVlxSW9PNTZIRUhKYkJGMTA2eGJROU5tQ1lMT3Y2?=
 =?utf-8?B?bkVwR3FvUUFoQkRDQ3FLL3ZGc3RQbUx0MHJHeEIvNWMvNVdRamx1elNqRXVR?=
 =?utf-8?B?Y1pCeWJrTC92bm91M09kVWttYWJEWmFNbjhEcjFRUEtoSWdKd09qaHdtTlBm?=
 =?utf-8?B?WitnT3M1MUIrTnZCUE8zMUxnS2tOd2l6NFAvTmJRMStLNTNucEtxbHdWR3BC?=
 =?utf-8?B?emVrVDZ1VnIrSmk5NkszZ0YxSnJheFFqWmtkVWM0ODducUtJaDVtU1ROM3dZ?=
 =?utf-8?B?WlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	cfpEE3R6KQSCO39FRLXZxCGXbbuSphpEA0n8CSKzjGcdOoLgE+9W8P2A5wJPXhxQWm0vWIKVFE5s2p6GM/V3nOMdh6dVAPTf7SUjYAwyKApXfgIsnnKa5mkfm1cuIBxWDK3nhDVpzU+WuUNm7akev4qBmlxusq92W0gRfV5OcMBgjzHz6B6igvBMEL/yCPeaTbHeb64zC/IYB4OCGtKV28p+ApIpMS51m2SevAqrd4v3UpdWB2vU7AFnTnPUG3jmUW+Kt/0mXMmHBORC8/FiEAre/wz2IJ7RhYW2GIUm7Ybqa9cZEGT8axraz4/lPo0IWhzFmV9CBLt/MOkS+W+BG3GbibyxxpIg3zQkeqiNBwv7BaTt9Ra8HtNhe4mTa2fyq8dsp0GfsvYQbQtbQH11kOPdkh67Je4t71yHvpcuWi1AODfdk5Ea3W+mMVgD/214m5J+SEUm+o5l3MVpw9wQhVNgUS1LuiA3CnunyT4CpKjQDotJaUER7l3ZGXppwRH/W7TuezcVaXK4kqJxb9+C4OjCoWZSjMnMltS3pWse4ji0HY1+kT/yzozLDk0PUSgCLbTcLbNthbQuKztdEgLnlzDSQt9UgWESbbe/6EeyKeg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad08004d-1f6e-4fff-e11b-08dd867dd8bf
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 17:55:22.5687
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sm5pqoWGhb6u2F1W94wGj9b/MgN/z/eYW3vt5YPE6h7wTwqyYHhwEaQq50OcB5n/5SyHUTn7/MkFScfBX1dapaWFDvsnqsAArb3jeqx1oq4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5725
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-28_07,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 malwarescore=0 mlxscore=0 bulkscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2504280145
X-Proofpoint-GUID: NzsICi3zv_0OPXZrBYFUWjUNlMT0j1EE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI4MDE0NCBTYWx0ZWRfX47rUnTr48Ji6 7bSBVNtUbYcgvW52UKiIpck466zoD8h6SI21e+4Yv4QEZ2ImlPTIhyqBVi7SplstQEwQCgu4/DN 3EqMh/trqqmIKRFde6ZuWn798Wlle0mLsZDBf9gSa1CASZ2rP6wqnN9fZjIIqCkKRDTXBg9pRN4
 Be6ddOe+uAerIgMSKNvzMkxtwaz2gSWgDgDMbEuSL89v4qbBUg8NvJXapT6B7HI/MD9LzHh0vyA OUrqdVQGc6b82cKIRXC9mFbMr646TXlwtXRr3EFSQNCnqUwo2yZbjuhQB6MHBVb4pD74hAw2poW nJvU/4wjNADX4bzskx94tvyNBCGVDUc6wu1AB4NQWjtsKmUsEC2WVV2LLJz/GRfyshxUAUBRnjS 8RTVRJuY
X-Proofpoint-ORIG-GUID: NzsICi3zv_0OPXZrBYFUWjUNlMT0j1EE



On 28-04-2025 21:05, Mikołaj Lenczewski wrote:
> +config ARM64_BBML2_NOABORT
> +	bool "Enable support for Break-Before-Make Level 2 detection and usage"
> +	default y
> +	help
> +	  FEAT_BBM provides detection of support levels for break-before-make
> +	  sequences. If BBM level 2 is supported, some TLB maintenance requirements
> +	  can be relaxed to improve performance. We additonally require the

typo additonally  -> additionally

> +	  property that the implementation cannot ever raise TLB Conflict Aborts.
> +	  Selecting N causes the kernel to fallback to BBM level 0 behaviour
> +	  even if the system supports BBM level 2.
> +
> +	  To enable detection of BBML2 support, and to make use of it, say Y.
> +
> +	  Detection of and support for BBM level 2 can optionally be overridden
> +	  at runtime via the use of the arm64.nobbml2 kernel commandline
> +	  parameter. If your system claims support for BBML2, but is unstable
> +	  with this option enabled, either say N or make use of the commandline
> +	  parameter override to force BBML0.
> +
>   endmenu # "ARMv8.4 architectural features"
>   
[clip]
>   
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index 9c4d6d552b25..7a85a1bdc6e9 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -2200,6 +2200,70 @@ static bool hvhe_possible(const struct arm64_cpu_capabilities *entry,
>   	return arm64_test_sw_feature_override(ARM64_SW_FEATURE_OVERRIDE_HVHE);
>   }
>   
> +static bool cpu_has_bbml2_noabort(unsigned int cpu_midr)
> +{
> +	/*
> +	 * We want to allow usage of bbml2 in as wide a range of kernel contexts
> +	 * as possible. This list is therefore an allow-list of known-good
> +	 * implementations that both support bbml2 and additionally, fulfill the
> +	 * extra constraint of never generating TLB conflict aborts when using
> +	 * the relaxed bbml2 semantics (such aborts make use of bbml2 in certain
> +	 * kernel contexts difficult to prove safe against recursive aborts).
> +	 *
> +	 * Note that implementations can only be considered "known-good" if their
> +	 * implementors attest to the fact that the implementation never raises
> +	 * TLBI conflict aborts for bbml2 mapping granularity changes.
> +	 */

use bbml2 -> BBML2 to maintain consistency

> +	static const struct midr_range supports_bbml2_noabort_list[] = {
> +		MIDR_REV_RANGE(MIDR_CORTEX_X4, 0, 3, 0xf),
> +		MIDR_REV_RANGE(MIDR_NEOVERSE_V3, 0, 2, 0xf),
> +		{}
> +	};
> +
> +	return is_midr_in_range_list(cpu_midr, supports_bbml2_noabort_list);
> +}
> +
> +static inline unsigned int cpu_read_midr(int cpu)
> +{
> +	WARN_ON_ONCE(!cpu_online(cpu));
> +
> +	return per_cpu(cpu_data, cpu).reg_midr;
> +}
> +




Thanks
Alok

