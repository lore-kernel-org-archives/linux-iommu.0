Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0CF1C1759
	for <iommu@lists.linux.dev>; Wed, 18 Sep 2024 14:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726671102; cv=fail; b=GJBa5bZ88NoVZ+169Gj2n26zjBSp4BaNV6tZsU/L919Rq9ijOHEMAYInc3nD4vi6AAcpc1UhS/1xPP1ORc25K6jomEBWydfQjSMLJhutlZRFYbdIM8xxcfxKfwC6096jZeGuKFwLbo+ZysOftEAFSKsenF/vECTSaR5uQzTogF0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726671102; c=relaxed/simple;
	bh=OpoKgfjfgaa2Q1Bo0Z99KULfOul8ykmqfAAFlSrnQBI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=q+N09OV5SaNxM09jnG7hsOsSQMUMNt0LTzjfdcLsyaNDo+LfBp0AFDTLcFQL8RRaC+ZL2I5HBJUi5TRYhNTavkFeER+xXpiEyB1ULuesrmJOvz3I1LSNSQ1XVetos03PUt7nW5wIomcY1NjnwxI0xqkKTz6UYv4uAMlJjEa68Oc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=F0lXxm6N; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=jwERdW8y; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="F0lXxm6N";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="jwERdW8y"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48IEl4fh024004;
	Wed, 18 Sep 2024 14:51:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=DDPWfuthKH67o3IQVGgKASGK3j4cNcaJhC6CWpZylJA=; b=
	F0lXxm6NmXkKQaGHOWXIBf8Zc2E+wU5n4LkI0225GO/L01wA8Bomxb3cMpA4TaLW
	QdTmrZr7/wUm4Kh5s3CJACI81coObpJVqoO46xdhcF4Eurh+V0QARdwqQocyLMvp
	bpV60yhV7EJ4s0u0GmOBNoTA6LOBw2G68KKy/cR77e/nf12ZxxoRIlZOmcQTwWHB
	HlwU4vIyDOkeKwHKWysa/a+vAjX2MM9XKKpwEF9La9WUFSv9ri7RNp57Pc+GM8dI
	OwjY/SdVnBmmgEkdGyteJ+p4gPKoqSyfQwCgVBjB4KQAws1W5Kq3GqcXMXapxJJl
	0oJwQ0KJedZt6rFP3qWffg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41n3sd1jvg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Sep 2024 14:51:38 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48IDwa4R040420;
	Wed, 18 Sep 2024 14:51:36 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2046.outbound.protection.outlook.com [104.47.70.46])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41nydwq4c8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Sep 2024 14:51:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F/WLqr8I7tDcdo7KkgyD2/KNpHwpLYs5GFAVRoQT7JspdRTI+b7hs9XSZxEw5IG7DJ3tT/aW8czok5qVZjSsF+2hW2c3ieULnSwdZ4w6AtYOzgIj4qqadleA5BLUsEC0m1cZVAw63qr0sr8l8UKse3HAOZrDlF6OzcoGSlMlBVkKNL3bfcrKciqUeJ1FEV4lxiyOd9PUbT5VaSgJXiRe9A6ke0SatpNJU8mSGYFximxRJI78BXQ9+ZwfFkOODu3DvhiuS4AGdJDegs35fEfd5ckkY2245zcn09NPhw2VnL4W/JgWRF0CAiwxy6c3D3/SMaJxChq+8WjdbfDfJN9NHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DDPWfuthKH67o3IQVGgKASGK3j4cNcaJhC6CWpZylJA=;
 b=gCPIAcVNh9KgsCNQHpc0RkmXgAdMLYLYduQa4Qug0f2wyVHn2TkrQb/dcBRP2UyGBAoCjkM5VBh78S10TJDe5GspKRwczZ66NJYNGoulr9VPvNMP1UCLbS9UGoWW0CyyV9UyUdQffNGvs5wL+d3GiIzdbqX6RLzys9zPbvUjddFS3IU7Lz7rV8XFb5dpkrEu4h3MDthvZXohv/MHffq6IicBTg31BZmk42AEUHJaBwqUfbZusAJCyjBhHBy7imJ7UlhFDL30NYzyR7T1JB4gzaj6LX9UhFOds6ZaNyCVGB0CzxodpY7qPr61RL87gPKp1aYU6i88ucBj6yqnJkDl1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DDPWfuthKH67o3IQVGgKASGK3j4cNcaJhC6CWpZylJA=;
 b=jwERdW8yy7ywnXLmiYJETrRPWEyqDCGK264HKfOkiJ/oGXH12sjDXlSu5MF3CEU1dnnIBFC60NlyKbTRDmklX2qHKmfCBEdQLBSFpIEKgb55LoWfZsbene2gKg5/u4kJFAU9w9kzdRo8u5db1wTVR2b+06ZuB+mpI5IHikUeE8c=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by CY8PR10MB6825.namprd10.prod.outlook.com (2603:10b6:930:9c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.17; Wed, 18 Sep
 2024 14:51:35 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%7]) with mapi id 15.20.7982.012; Wed, 18 Sep 2024
 14:51:35 +0000
Message-ID: <70cd1f1f-95a1-48ee-a5cd-97a5769a1210@oracle.com>
Date: Wed, 18 Sep 2024 10:51:32 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1 2/9] iommufd: remove uptr from iopt_alloc_iova
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
        Nicolin Chen <nicolinc@nvidia.com>
References: <1726319158-283074-1-git-send-email-steven.sistare@oracle.com>
 <1726319158-283074-3-git-send-email-steven.sistare@oracle.com>
 <ZudGjUsw17YDggfz@nvidia.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ZudGjUsw17YDggfz@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN0PR04CA0029.namprd04.prod.outlook.com
 (2603:10b6:408:ee::34) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|CY8PR10MB6825:EE_
X-MS-Office365-Filtering-Correlation-Id: 17078214-ac5e-4849-b732-08dcd7f16451
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q1BKU1Z5aDJCN0lHdzdQNUE5aVowdG5tSW94dnhaSHJ2WUhHZEhwcUZwUGNt?=
 =?utf-8?B?Vjk5RGh1WXI3eHA5YjZ6V1JXemJ5cTB5dnNKUWNXOWc5bVRwNEJtZmY1N3Ix?=
 =?utf-8?B?TDdteGxrNGJRUzBEVXdmdld3UFYraG93TmN4dElZb204dDN2YXN1bkVuY0tC?=
 =?utf-8?B?QXhRUkZLYitZODhwdlhNQmlDUDI2aHdhbkk5dTladFp1Z3JzYXgvVU1vdlAr?=
 =?utf-8?B?ZXpjM0NIVmpHTzRxVU03UHhNV0VRUnhvOCt1TGJiNHhvSXllODh0TjZ2VWpv?=
 =?utf-8?B?Rng2VkdGaE13NDBLTmRScGpRbFRydERxcmMwYXQvRGtTZVI0QXFEZ25Wbjdt?=
 =?utf-8?B?aGZmM1R4YVhDTHkxWTlpcGRNNXNKNndvSittM1gwNlIyVExqVGFHWFRDWllv?=
 =?utf-8?B?bWNrbU1ocUtOYWU3c1cxUG1ZeGtmSDlmanNQTWdFTlAzbk5NVFdtRmZVdVpM?=
 =?utf-8?B?NFN3eXJ3T3ZGZzNCaW1hUlpFeE4vRDZuN1F1eHdkV0VDa2hpWk1BRW5wUkk1?=
 =?utf-8?B?VVZ6Y0V3UlQwOE1uY1IrOEF3WHNaUDJyaXFLaHlGNzg4a0dIN0FkZC81Vy8v?=
 =?utf-8?B?WWttMUw0SC81cFJsT0JmYURia09ad1RuSGVhK3pzR2pYOGNBRm53cjFlUkZT?=
 =?utf-8?B?N2xaUFFTR2lHblcwOXIxU01sTExmdUpWZFV3QStHNWRnd0FuZ1k5SDBnM3ZL?=
 =?utf-8?B?YXkxRCt6bmYvM0gxUG44a3I4UDlZK082MFpZcWtnM05rRjV1eW1UMjJCVWR5?=
 =?utf-8?B?ZmZJN25RMi9DRDBRdXhSN05QZ0VkSnhhQmF4dG82YzhQaDVvM245SjROYXU5?=
 =?utf-8?B?UURUdkh1amtSWGpINE1oTWlsNy9kVjR3U09GTDMzenJpUytaaXR5Z081N1Fn?=
 =?utf-8?B?aUVIWk1VZHFodVU3NmlvK3o3eFQySU5DRXlZcVpNT3d6UzlVZUsvK3ErL3Vn?=
 =?utf-8?B?a2FZUXQ1dUdFUEg3UWowMCt6bHpwZHN4ZHhTd1JWTWx6SXhOSVRpK3Nsd2ZK?=
 =?utf-8?B?OXRVMHFjU1ViaE5iNk55UDZqSDBSeGNyWkJoQURpNFI0ZDk1TFdETmpwcUhj?=
 =?utf-8?B?QVVrajE2NksvczZrc2F0M1B5dWZkVjcyTDMvVUpVUWFsR29KVVNTNVNtQno0?=
 =?utf-8?B?NGpBZFloemNiRWlVVzd4dXRTYWR2Zms2c3Y3aTVwZWhvZ2hraytkYW5yZE5T?=
 =?utf-8?B?VnZjM0M0ZjFsak90V0ZFS3liWnFzc05mSkJWYU5UQVZtbDhpK1VnZVRLVndI?=
 =?utf-8?B?R3oyb1l3aWNBeXp0OWZvaHo0bmFqRyt5enlheGxBRDJrcWRpaFVjRVBqSmli?=
 =?utf-8?B?TEpqQnc5bU9uR2lGRzFCMDJBRVNSUm1nVTZOOHlBTmo3Z3VJeE00QU9LTEtv?=
 =?utf-8?B?SDAxU2M2RW1sUWhLQkEwQ29BTG55clRwSWRJSExGTlBmTElWb1V6NEx1a1JW?=
 =?utf-8?B?RWhiT2xIUGoyN3lUN01xUVQ3d0NZTUc1djNTNDVoUk5XdlI5bE9tdlVFNEo1?=
 =?utf-8?B?QXRkd05Jb0JNOFV2d3JZVkZMZHRjTTJZVE1EUkZybURqT2NFQUZNc0ozL0Vy?=
 =?utf-8?B?cVVxaE5KVmkxVlBTZjNXNFBzaTlYaTBNQlRJZTNuMEFFTm4vaEpnS0IxaWtG?=
 =?utf-8?B?cUFzbFl4cERsZi9JR0l3L2M0bldCY2s4Y3BVZWxMTXRjdzI3NXgzMjk1UXVz?=
 =?utf-8?B?R2VZV1RHbGxPSmJoN25MUlJ1Q1Z0WXFNcEpSeGQ4dWl0YjVITlBQWDV2Vkpn?=
 =?utf-8?B?ZFd6SE5KSVhtS0tBdU51YnplbXg0NzdJUkpwc3J6QTZtVytPb3J0TGkxY2VL?=
 =?utf-8?B?aEtVcUFuY01oeXByNmNYUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR10MB7447.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TDJpY0M0V2lRWEkyNnlsZGZrR3RpcCtFWWNnME5mdmpzdU0xRGJVUDJHTVhq?=
 =?utf-8?B?aU42WXNXa2hDUzhMZ3lIRzZUSG9NYk1EWU02dnZSbEl0M1p5NU9lOXMwV1RG?=
 =?utf-8?B?T0Z2N3QvejJwQ0t2WEpHWVRYeE5zR3NmVFdrR0N4WXFBMkZUa2ZFcm5XQzdn?=
 =?utf-8?B?VUNuN0FJS3Z2L0krOHllekx3TFdmcldCQTFERlBzanVyZ2krRzFFcU9sK3NV?=
 =?utf-8?B?Ynp2eVVNR2hPSU1PZUhGT2NSOW9EeDA3Y0paNmY2V1JhS3Vhb3FuRnBaTG1S?=
 =?utf-8?B?SzI1cGRmUWxrQXdJbm5IeVlWR1QzdU8zd2tJbTVRSzdhaU9Tak9KbWQzSTR2?=
 =?utf-8?B?ajZsKzNjcmI5NThIb08xcUx1MnIzRjh3T0dNV2JIWE03TEhsQm84NURpTVp3?=
 =?utf-8?B?bExXL3BPWExESlcvVjAwZWU2TnFtVFdIMEZXb3k2aTQxc21xWWNXdkw4c09N?=
 =?utf-8?B?b3N6dnFhMTBXT2xHcHluaWwrTzF3QTNzYnF3OEhDOXdpRWl1dExXc3pBUlh6?=
 =?utf-8?B?VVNwamN6eCttbWpTbW9jZVdRUDZibUdSWHZXcGxHZ2NTK2J6MlM4NXlDaCtK?=
 =?utf-8?B?c0FNc2F1cSswVzllaHJRTW1yc1AxWGk4ZFUxMUxGSFR6N1Qwd0F4VUhEVnll?=
 =?utf-8?B?dlp1MzBacUpFcWVBY0pYSjh1NnRKcytvV0piS1Q1UHVrcHZYcmltaUQ1N2Fz?=
 =?utf-8?B?aWYzT1l5Z2tockVmZG5TNzlVeVc1T2RTdm5oc2hMd2hTUzlPaitWdHY2MjZj?=
 =?utf-8?B?clRhR3cwakc4eDZBNWFrOTg3Y29hS1ZWcG94Mk5qeFF6YXRrSEEwR2xPZFdD?=
 =?utf-8?B?MUJ0OEY1R3QzZHpTT3ZhYU9KZGNLbEh3SFU1WGFMNHB0alIyQUJUWlFUK1Fo?=
 =?utf-8?B?SHNaSWxuTUZXejhaSmJ0blZhZU5CVVR2MFpUOUpYNE9ydjI4bk9icnFVaHlQ?=
 =?utf-8?B?L0NBNUhwNnZVMlJpRWJSd2VYVkVqeW5icHQvMW5nNEt3OVIyVnlUZEVYUWlI?=
 =?utf-8?B?K2RDRkt4YllIb1VycGpVcldMWXcrNUxlNXUxOU1lL1hiWjdYY2hUR0tjemxE?=
 =?utf-8?B?Sy9XRjdBSVJFc29iSnBNUU5VR3Z2RlNXVWt4ME5wVUpoajhML0ZRT1dCeVR5?=
 =?utf-8?B?c0VIeWtMV3poSFQ4TVBLV24xUEFtNDg3WUlyRk5rcFV4UjlVWS9xN2JudmNa?=
 =?utf-8?B?clk3OHN3TWNLd1hQaWptQTFXMFdKRFhmdEswQTU0Y1QxRUtlQWFQbmdBQ3Nu?=
 =?utf-8?B?aTVzdEl6aUtHTTl6OWlIOG4yKzRYaGFtbDFlMkhZMU5oY3lsZEhGclppY0th?=
 =?utf-8?B?WmZablF0YS9lSG1VU2tHaXNKWWhDNGlLZVBzUlh6K2FFUERyU3k0OC9JcnY5?=
 =?utf-8?B?eG40OFdMVGhpWTZUcWwxdzRYWUVhU2hTb3JkTmtSbXI1NjVoYWVFZ1IzS0ph?=
 =?utf-8?B?V21hOGtCL1ZIOGR2MlBldjE1MXFXQVJYTGhYMmluZEZzN0M1bmViS2wxS3Mx?=
 =?utf-8?B?ZXRzYWVzWEF4T2tZMmdNUkpOd2UveGtnb05XdVViTDFJUWN5OENrNWZRMm5I?=
 =?utf-8?B?YUVVSUVkSW0yWGlSaTRJUmRPamJ2VVB6NUlXVGp5dERHbEJJMUgwYzNrU2cz?=
 =?utf-8?B?R1lXNW0yWmxkVXdvZ1hrcEdwY3hMRFI4aThrbkhZNkRVZ21LMGsyS0YzQXc0?=
 =?utf-8?B?OTVJN3JFL0N2Y0VGSytWMmpQbHl2M2s5OUE3VEVham5BblYrd2U3d2tuOHdn?=
 =?utf-8?B?K0VPbElkT24yUVRxN0NQdUk0MDZUMnpYNk13QU1NUE9JVEpmcVQ2WGZEUVFK?=
 =?utf-8?B?dk10ZzNublFRUjJJOEVTTXBpckVmc0F5Y2xzYUJCNHBhcjVBdTFtTyszT24r?=
 =?utf-8?B?Z3hjMHJjM21TRy9ML2crOXpnQ0tlRG1MSitGaXJnUkxDU0tzU2NpaGR1eDVm?=
 =?utf-8?B?ZWk4UEQwKzUwZk5ZSnhQdHRSMlF6Nk1WeFhwZW9NQUFwMVV6UllCcUZ2UktF?=
 =?utf-8?B?Tms2UlczMVpvSzY1N2J6dGNNbTNHc0poV0d3bFFldGU1ZlZtTnhsWkZvTXlw?=
 =?utf-8?B?TmtwME5aNXR5MkRMUysyVmNXVzJFaFR2bjlybFhabGZpZmpIVUcxSGZkQmFU?=
 =?utf-8?B?SC9zS1pzSHljYkF2d0ZvVTlBaC9uSzh2VUFJUWZWUHRodlU1SXAvRHAvUFRB?=
 =?utf-8?B?MkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	XBR1Wd9xou9dwHdmD+gwRx+MPAanolpuMlLPuMm7G22Fma7kPIPYgHaJSkB8aUgPZY47qTFHdg2EE20YtMxMBrtS5h+DOsdvHo5WEEMpSbO0gd+Uxfq7x7SG5wZ7Xfgr4I23OF+JOt7NEZ2w8Ti+1PjXxyPV5/x1zA49vtlzKkwubhP5B2sNzj4ytbV7D7Dqty4dp5WbOdZKsmlYGhL//v3DVUHIVcoM4gYSDf8jD1xoj+9md55P0gpnJMC5wOw5ZfsnFStia79FLqp5QvNkybp58ePdcR7HTdnY3wl90obEtop/0Zyb3VoqWiQZLeUdCFjcIn6+0ePcf0PFcd2f5hB9ZfqqyTkQMpWrmIUmsxgNoQn1JahcRGfz57Do11TSohjFL/0l8wN+by4ho4Ek95QNopywSnm8F24P6fZMgFV87La/k6Dq0FCwMsuCe2rT+XyuZoZy41/p6nA2jWWBvF1aNoyGb7Y//lEKzJGo86WcvE9GmeLWPngshWPZK0kDHC8mE3VKv5SokBr8eDdhHIbnzYolYJRLNqHcxa7xVGpPnbxXPtc2Zjd6GcZ0oR3DqXFnxQf5wpgLe+egHK8+UehegcNjg0HlrDIaffWjn+8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17078214-ac5e-4849-b732-08dcd7f16451
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2024 14:51:35.1046
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zm6PMgVL4/3/GcAHngsNDB3tLVaSqoq8EN2iTY2cqiasPUBxl6GEZkpmODCR/ghex2IqJsm9YuYz/q2DMV1AT0WpSrVqnfcz8juueEWZKx8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6825
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-18_10,2024-09-18_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 adultscore=0
 mlxlogscore=999 suspectscore=0 malwarescore=0 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2409180096
X-Proofpoint-ORIG-GUID: 4DLg9rItP0RC2SDNvLWTlNd8FrhiKPLy
X-Proofpoint-GUID: 4DLg9rItP0RC2SDNvLWTlNd8FrhiKPLy

On 9/15/2024 4:41 PM, Jason Gunthorpe wrote:
> On Sat, Sep 14, 2024 at 06:05:51AM -0700, Steve Sistare wrote:
>> iopt_alloc_iova takes a uptr argument but only checks for its alignment.
>> Pass an offset from start instead to eliminate its dependence on a user
>> address.
> 
> An offset from start is a meaningfully different thing for this, it
> throws away all the information it is trying to extract (is the uptr
> huge page aligned)

Interpret offset as "from the start of the address space, eg 0" and it
works. That was my intent, since I pass offset from the start of the file
address space in a subsequent patch.  But instead, I can rename uptr to
to address and describe it this way:

   iopt_alloc_iova takes a uptr argument but only checks for its alignment.
   Generalize this to an unsigned address, which will be the offset from the
   start of a file in a subsequent patch.  No functional change.

> But that isn't what this does anyhow:
> 
>> -		rc = iopt_alloc_iova(
>> -			iopt, dst_iova,
>> -			(uintptr_t)elm->pages->uptr + elm->start_byte, length);
>> +		start = elm->start_byte + (uintptr_t)elm->pages->uptr;
>> +		rc = iopt_alloc_iova(iopt, dst_iova, start, length);
> 
> It doesn't change anything but rename uptr?

Yes.

- Steve

> Thats probably OK, as you will want to pass in an offset from the
> start of a FD here eventually.
> 
> Just the existing uptr logic should stay the same..
> 
> Jason
