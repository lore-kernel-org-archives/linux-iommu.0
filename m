Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A24817BD3
	for <iommu@lists.linux.dev>; Wed, 22 May 2024 14:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716388731; cv=fail; b=Tk5ZFYhL35QKogBw+h+LGr40gO8HXGX/38a7Wcdne0hXpkA99KDkQuZJetiEt0o8qIONP3LiLeLDG5Ye/PUSm7VLQkksVYbBpQexBanpGrBKgocjRFpUG3DSRjhSUEkCCOOCCf7UZEzdZtuULCkxnwQKjz+ZEIx7nw6xI6y3jK4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716388731; c=relaxed/simple;
	bh=BrNKxZzvyZbKpJjtApwc47HUar0dqrPHSpVQyPRGEmo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fXXodDYUgaIZLoHCSYRupvPgGAXiOcbLow6NSD3s+lVdCbekVHY5iH2wJBwwG/8v1hYAjlyyRbncX9NfY7VejaIxSNCPjs8S+UCtC5qHcsA8Z9r8E0wNik6e43kb4jOSjXCiFXubhs1YwLrLut+ILg+1XrB2+vM1oF8LsRTpqMI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VbxA6UfX; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Kim/rq+k; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VbxA6UfX";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Kim/rq+k"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44MCqdBN013783;
	Wed, 22 May 2024 14:38:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=9s3irHms8Imm1KP9rSADlcL6lP1Mp+RMCKQ8CYyNDuM=;
 b=VbxA6UfXy7h9UybqIJ27+RM/HABAvXuelhkdQw6ZhHs3+pptwafL7C+CxS+eUgtHWAB9
 Wg2BTW+8ZwK+K2ANMCj9G/l65rKOyokeYYzsFFqZ0MDYzsnGuHDy5ltxTwwAoEn4I4Hl
 s759bDnzq87SkmlLyujTmLLX8ygXopqpOOiev0kL9wJj8NEyTg+Bk2iT1IlggIitYP1M
 BfDfPsNTi2w3TclHpvD9KdRSgE82RNEhGuuPeR+ZXDUs+l0sBzh7nWbaU/KTtSTCpH+0
 AWKROlJPWTQQ2+aLM/bU4qvExvsSPHe+5JWtjOD9uQ8HMM3tV3FIBpHnUcrDmQ30grqK xw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y6mcdyy2v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 May 2024 14:38:14 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44MDVwx6002660;
	Wed, 22 May 2024 14:38:11 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3y6js996ev-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 May 2024 14:38:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OxyBmYaHZvpwNlANEElm7ogGFpoUIyzCPNh+ChuNRq39wyk1mJwdNzJagmMT9IFDIG7xaJddG8Yal8K5+BXCf0MmpAG48E8N+Ai5Dg/RskRujIixdzFOsE59v0iGUTO4OrenpmMddKrHcA+RKOanh8Oao8fkefnLOi3Jym/KbXg2c/8hcyVCx63nOLjKv/NcJijVBeqcAblZLPwY2oEYCLZJn8G4mKO6oDzoP/zCdN6n6sVIazHIMMUzGuFngwYN4JTBnVTPGuGeOhOgFBlOKdNFgpZGe4a9aAWpsGI8SmuGSHdPNnU6EdgBlErYgRyAvEHnjkNJlsPqTkVfqxpcpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9s3irHms8Imm1KP9rSADlcL6lP1Mp+RMCKQ8CYyNDuM=;
 b=IVIjr+jkaS0lkR2VJmzeg7I9MI6+Uw4raxFYXtazY/sxoWs5oOYTplfXE+F/ilD6HxX1eCThv/xUJo2gBnS90c0jTsWl6iOnYA5lstMpj2sOStngyX5fv/7RWYdkDBcyfurPEYg/z40onWJZo0Zy7X3DCPtDB29yBFJvlnZmQpcVyefZMp64tB9vGnyw1409mbOW4h9ea6m5M6bzKnga7/p9JzI6xV0E2Q3adnT3k0eEvQlg+aPdpZac4y2hv7L5cUZvpy8sMUnuRXxgsQEsRLfvnCLaBFgETeoOoduu/mu6e/qUXYmczzUKMPis9NIkWjkDx3wBHE2qB0RARFEfNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9s3irHms8Imm1KP9rSADlcL6lP1Mp+RMCKQ8CYyNDuM=;
 b=Kim/rq+kv11SXmq77ql8acVRfgVIugzna+XGxSV51c3LmujsE9d8ScKSre/udfXUolm4VetZzpY05kKYgIbbWUR6DrCq4inxmx2W9ck5JmHull6+J666HtTcL8f4R4JzNHAQV9iTub5LKx1KAo9TiYYt46DgfaNb9x8GeP23e00=
Received: from PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11)
 by SN7PR10MB6641.namprd10.prod.outlook.com (2603:10b6:806:2ac::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Wed, 22 May
 2024 14:38:09 +0000
Received: from PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53]) by PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53%4]) with mapi id 15.20.7611.016; Wed, 22 May 2024
 14:38:08 +0000
Message-ID: <4618c24f-aaa8-453f-aa9d-67a864e1c93b@oracle.com>
Date: Wed, 22 May 2024 15:37:57 +0100
Subject: Re: [PATCH v3 2/4] iommu/io-pgtable-arm: Add read_and_clear_dirty()
 support
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
        "Tian, Kevin" <kevin.tian@intel.com>
Cc: "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "joro@8bytes.org" <joro@8bytes.org>, "jgg@nvidia.com" <jgg@nvidia.com>,
        "ryan.roberts@arm.com" <ryan.roberts@arm.com>,
        "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
        "mshavit@google.com" <mshavit@google.com>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
        jiangkunkun <jiangkunkun@huawei.com>,
        zhukeqian <zhukeqian1@huawei.com>, Linuxarm <linuxarm@huawei.com>,
        "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>
References: <20240430134308.1604-1-shameerali.kolothum.thodi@huawei.com>
 <20240430134308.1604-3-shameerali.kolothum.thodi@huawei.com>
 <BN9PR11MB5276ABF99FDF6CF0F863501C8CEB2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <13e93238f21b42539097d7e347be684e@huawei.com>
Content-Language: en-US
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <13e93238f21b42539097d7e347be684e@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0172.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:312::15) To PH0PR10MB5893.namprd10.prod.outlook.com
 (2603:10b6:510:149::11)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5893:EE_|SN7PR10MB6641:EE_
X-MS-Office365-Filtering-Correlation-Id: 424fe450-551a-48ae-02dc-08dc7a6ccc80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|7416005|366007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?RGZ4b3dDOWtVRUs2NmVRUllSUmlqQko4K3U3TDNzMnp5aHp2R0p4czZXRGVL?=
 =?utf-8?B?UktuQktPM2tTa0ozckp0SjdWODBRaEQyM3puMjF3aUx0T2Yyck1uWkdNbnU2?=
 =?utf-8?B?RUJaNGkzUDI3dVgzbXIwaHRaNGpINndSdnF4aEVrckZNY1R5YVhwbk5QT2tu?=
 =?utf-8?B?eU4va0pJSmVnRzA5ZU96QUwwbDJKU3Q5cHJNZUZ6d01RTGhndDQ3Z1BkTDdS?=
 =?utf-8?B?eCtlU3hObTFBUUVSVFBsOTJTdzNkeFBKS2RFSGFZcWROWnZ3OWNjdk5VSkYw?=
 =?utf-8?B?aXVKdW5XNlhEakhEd2NYS2VsOTdSdzRHRExmNjZFZDhHc05TNWl0eU96aEEx?=
 =?utf-8?B?TmlCSkw0QVVYZTdvY2QyZm9KUEUvMTFlNDRCVzR2ZWJwTlhDejNzYVQ1K1pj?=
 =?utf-8?B?bkRSWGJqOUdZOUxEUjJueHdqMWwxVnFmd3IwcCsySmdFRjlkUWowbEI5bVFh?=
 =?utf-8?B?dUpkZzBTVTVPQUZWamNyeWM2aVRlMzYxT2krYXhMMzRTeENSV0V4RWJRWTdQ?=
 =?utf-8?B?MXRiVmQ5SkRScG1WWXlpK3VoUktOWkxGT3ZGT3IvaGFBRTN2MTFaanRXNUJF?=
 =?utf-8?B?bkFYZFhSbHZVZmlDUDVFVURzN01qQ2Z4OEJWQnN4QmoraEJxaEQwTWxKZjV2?=
 =?utf-8?B?aEgrN215bEtKQVY0Q1B0ay9JYWZQZUMrKzNnYkdwRjJWVUVYOHRybFFzVzdq?=
 =?utf-8?B?cDJNMkJhcC9NWGVBY0gzUm83dm9rU0Z5Y2tCRlFTVDUzYTJhREE4M1RyUjRi?=
 =?utf-8?B?eGFqNmVHNnRFdE5XUXErQlZCTTMxNzRrMldYMjVzd293NjZPQ1BGU0hYL2lZ?=
 =?utf-8?B?TEk0YWh1bVgvQzNtU0NYc1U4ZENJc0I2RHo5dU9XOVppVmxoQXhVTHdKSUFP?=
 =?utf-8?B?U0VEUU9PTEhuWGt5cWdoVzJsby96VHhiRUZWOGxPbER2RERGOEMwQUtRUWpD?=
 =?utf-8?B?VllSa09nK1R1VGVtbVA3UmtHWjN3K3k0enZNcEpBWnJZMjJZbndYMHdNWHBz?=
 =?utf-8?B?RnFieGFtcUFNSnRCOWZYbENpY2x2bzN6ek1IQjA5ekNsNWdNVmpLTHdxcDNW?=
 =?utf-8?B?N1lCNjlsL2xudFVIOXVtNkFGbnltQ01XS1NWVGkxU0paQVNyZDNnNDA2b2Vh?=
 =?utf-8?B?d2ViNWlWUDYyZTZtNHZ1V3ZKRTF5OHhVcyt3cHhTVmlqQUpBTm84T3JHT3hr?=
 =?utf-8?B?bXFaVnErUDAvMWZGNmUwSFRQTkhHOFo4OEpKN0V0UFBhbkowdlV6U2hhQm9Z?=
 =?utf-8?B?ajg2ZU50RmREU3VJTDFSQjFVRlpLd3gwanZpR3NOQ2h4MGpFYVpmSFdyM0lW?=
 =?utf-8?B?STJzREpEV0dYcTRRM2kwcVp0eWlURG1pTnFHUWNHYUFmSEFOcjg3TEtlVSth?=
 =?utf-8?B?WHI0SFRNQS9XUjd0R0EzeVpyZXVTZ0o0UnVwdWRYM0pWQ3NkNkdpdUQ2RFNI?=
 =?utf-8?B?WkZ2b2VuUW90b0pWb0lsVXVIQ2xLSkVxUjl1TXpIVGVEcXZpbmRXYUpsVXdH?=
 =?utf-8?B?L1I0UldnZ1BxZEdpREVGZWZrRFFJZER2ckdiK1NtdC9ZcTg5OFlYVENoKzBO?=
 =?utf-8?B?NXhlWXlkZ0xEdUlaVHh1NEpRQUhtTXBpUmdGa3NrK2hKdGxDT3M5ejBSb0Qy?=
 =?utf-8?B?OE5raTVTNEdaWEt4Z2x5K3RZdnFkalRqcTQ2WmNUaTU1cXhMTUw2MWF5bTNJ?=
 =?utf-8?B?Smw3c0pmKzBEVDRMenp2OGNRYzhld0Nzd2kyVVhDQUZCNkk1KzdVY3VnPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5893.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?QkFXOVV0eHFQSzdaSlZYdUtxTEhLMThmTVdtSEV0REpNNUFFeEZ2ZjVReDJF?=
 =?utf-8?B?UTg5ZDJoZUVITDkySDVYbUlReXJKVzNWNHo5N2tkSnkzdU9RaTJGaUdncUJx?=
 =?utf-8?B?c043VDJIZlp5SytFZTlrdHZSVExCaTIxVCsycm5Oc01vbEVIVFMwZTRTTWpa?=
 =?utf-8?B?cUN0UXBaY1ZSS1RHYjdscmpja2czT000T0Z5ME9JdERpclVHS0MxNGZqNklw?=
 =?utf-8?B?THVoQUpmRUE5NFc4THVDVzJ3Z2lMT2Z1MWUrQnMxNmVVajBuZWZuc0JtZ0I1?=
 =?utf-8?B?TzVNT3k4akQzUUh0ajFrOFVDekNBeFoyY3ZDQ1R3cUxwNDlmcFdWK05MWS9X?=
 =?utf-8?B?TW1wZ2NxM0p4WndTSTczdHQwSnhFdmdKWXJSMTZ3T1h3OXhibFlDY0t4dDJW?=
 =?utf-8?B?ejh4TzY5TEVFM2xGRFhvcUEzVWdsVkZQczhIYWFuMGoxWGJnMGZqY081bnBj?=
 =?utf-8?B?UUluSlBOSExseFlRN0dYUGRIbXhwZVVKempFR05LMkhKaGpzVzBrMWU4SE1j?=
 =?utf-8?B?a3R1cTRONmRQdVVGYlRWbnZRUWNGVnJvZ3NQZGx6SldCdGhCSUZ5aDVsRm5O?=
 =?utf-8?B?TVFtTkQ4VW8yVkJYRTRwMFlaM1JhZEZhM0UvRTJxZHZRZXlUTnZKNjJFZys5?=
 =?utf-8?B?Q09nSXBqck9LY1hIUlpLazl0YTQ5UG1BcW5hODVCTFROdDBuZkVLbkdMMnUr?=
 =?utf-8?B?aTZRTjBiTFlEUzU2R3BmTjNleWw3ZVIzWWV6NXdDamtsRTNVY1g2Mm5mblFO?=
 =?utf-8?B?b2xPMHNzMzNiTmR0RzRBZlAzb1RKSE42aWdiakxHUFhoQk5SQUJVZmV5UGZj?=
 =?utf-8?B?VTA0SUV0V1NCeXJsWi9zRjltMTNlSEVEVWFnTmlYODVlSkpmVlhqbmhxWG1N?=
 =?utf-8?B?WllVeE5SQ2ZpY3VLK0Uxem5JMHhMS2F0NmNXL04vL3hiUXpRb0xQZGFBREhO?=
 =?utf-8?B?NnNNWGVSWU10Y3l2ZVNxUE9WYVpPd3hDaXZOM1dUS09ya3lEUmxlUnd3UzYy?=
 =?utf-8?B?eGpxVDBrUzRGdTl0TWFRck4vM3R1Vk1UbGRqVEFPSUx6MWFrV2tGQU9uaHph?=
 =?utf-8?B?Z25VQXZkRWJuR0xFaDl0MFpJVGFZTmliU1lwWC9NQkZubXNHM1ZzYm1teVZK?=
 =?utf-8?B?MDhYZDljeVVtQ1RyK1BEZDVqc3Q3TWgxQU5OMkQyUTZrN214dFoyK0J6NU5m?=
 =?utf-8?B?M3F1QmpadnVaSTU1R3BoKytTYUQzWjNhR2V2T0Vjc0dUdk1SSjVxZHBrcUR1?=
 =?utf-8?B?M0FoT3NkV3FxWC8xc3lwaDZKU1pjeHJNQkV2VW9IQzd6aWdXZThMR0RWa1Zo?=
 =?utf-8?B?TEJXd0tXVFJlc0tsang0L3IrVkFVNlU0RkR6QjhGdWt4TTQzK0M3K3ZDdC9s?=
 =?utf-8?B?N0hZaGNNVjZ1YVNQUVVuUTJsc3EzY3BhcXJzMWc2dHBRbHdnY1ZsUytGbmp4?=
 =?utf-8?B?cVhoZExhRFRrYjR6VTRheDNoQ1doc0hkeE1MQkVZUXB4cGV3NEJzQ0w1RFNP?=
 =?utf-8?B?Mkdab09XZmR1dGZad0VXdjVUSkFnSWMwZklvT2VESTRmMmR0bjNnMTY1anJT?=
 =?utf-8?B?cGpxOWk2SFRaeE5JZ3M5Nyt4STFNdnBEZTd4dVZPS0xzZnltNnQxSXJ6WVhJ?=
 =?utf-8?B?d3dJNTJqQ2hMVmdlRDZkSW5zcFlFRHo5MzF3R29PQUNmQlJLblZ5SGNqK3V4?=
 =?utf-8?B?NDd5QVBESytZYm1ic0NaZ2JvZ0dvYWE5S202bXllQkRKek1hMGJaTXdmcWYv?=
 =?utf-8?B?bWtLWXIwN2w4N3lVVjJWUnNGbWxoaGVtT1hsR0paSWxPR0ZYMUh2cFFpYjJk?=
 =?utf-8?B?WFpDS2FMcmtsUGhNNHZadTMvdlltZVFjY1c4RHlDcmtMWTVQTFNNaWZZazg3?=
 =?utf-8?B?M2I0dWJyTFV1bm1qdEljakVadmNSTEpGQ3QyNVpEU0JnaWI4a21ZNEtMTkR5?=
 =?utf-8?B?R3d5cWVqeFNYVTdEZnJmNmdsRDhSd0NkL3haKysxSE90dzJ1MmczR2o2d2hI?=
 =?utf-8?B?TXdvNnFwU1diaGRpbEtSSVM0Sm11QVpnK2ljamtVVlhaOGVuSXcrUXo5Q2RZ?=
 =?utf-8?B?M21tc3psV245RmM1Y1I1bXBoaFMvSXhHQjFrNlMraHVhRXR4N29XZkJGcEY4?=
 =?utf-8?B?VkhUME5Cd0hobUFrcWhBZkZLQVArSVZOTEwxaURYdmxzY1hVZ2wyYVM1THFn?=
 =?utf-8?B?clE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	AnK8ZcPb/Kk1b5QundaZpOToYOTgeJ1dmPGfqZjmyF2dB0vBQEOx6TnL4MxsRhEL8ir3Qbu1p1M8Irtk4CHy0ulDDd+yOIOgpBmiiIOhavH6+swuPaYQWNgGb4sENQDbZXYxQL7Lr7Z95thtk7SLFUVCzIjguNKGm3pypligmRqLLqzu+KjqCMb03LLl1SO4471BpwG4Lbf2C4/JgYy7bbwNjGwPoIqBYswSGbLpyB9vfOMTs5Kkf2jy/lvL5TuwKboKky7vdE8mUPBO8pUUVk+2jUp8DampGLSQh1WaBI/TaKJ1aNniW5E4AESNLg5CLyDZGzy0Qum/i07YoYTShRqCOIRKyvURWgelRv50SNlgQwV8OBCX3XUeXx/EoqKYGnL9lFpyOIAfF6jXm54YcW9jS7wITQgS5LUsIlStreJWt5V3Pqoq+ftWPKqhzNogUlOwHclDBz5S5R8k5s6lRqx3krdLpIO8B2cuz+IWjNcGWk4cth3EkLh+iu30Q8BruirTDY1fxgCiiRXMM/f6k+ruc+gpZytx2MoI32TlA8dmgMf4NdutsTzMBj5Q/3QWa7JOgflOSsqWo08MJ5Mfwant+IsVV9w5p2ONoEBZQQ0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 424fe450-551a-48ae-02dc-08dc7a6ccc80
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5893.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2024 14:38:08.8832
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gCeYc0SMyngRzVAfb+N1ovywUPcM9QlHmNMqn4pma687D8u9rUdfR1286oBB7+qhTPp+UOUPXiHo+OarfCQZy0dZuQQ9Dp6AoPykL9594I4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6641
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-22_08,2024-05-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0
 suspectscore=0 spamscore=0 mlxscore=0 adultscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405220098
X-Proofpoint-ORIG-GUID: f3r8xvkAJXy3owN1_fLEuPI9ZPVs2Rb_
X-Proofpoint-GUID: f3r8xvkAJXy3owN1_fLEuPI9ZPVs2Rb_

On 22/05/2024 15:03, Shameerali Kolothum Thodi wrote:
> 
> 
>> -----Original Message-----
>> From: Tian, Kevin <kevin.tian@intel.com>
>> Sent: Wednesday, May 22, 2024 8:12 AM
>> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>;
>> iommu@lists.linux.dev; linux-arm-kernel@lists.infradead.org
>> Cc: robin.murphy@arm.com; will@kernel.org; joro@8bytes.org;
>> jgg@nvidia.com; ryan.roberts@arm.com; nicolinc@nvidia.com;
>> mshavit@google.com; eric.auger@redhat.com; joao.m.martins@oracle.com;
>> jiangkunkun <jiangkunkun@huawei.com>; zhukeqian
>> <zhukeqian1@huawei.com>; Linuxarm <linuxarm@huawei.com>
>> Subject: RE: [PATCH v3 2/4] iommu/io-pgtable-arm: Add read_and_clear_dirty()
>> support
>>
>>> From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
>>> Sent: Tuesday, April 30, 2024 9:43 PM
>>> +
>>> +static int arm_lpae_read_and_clear_dirty(struct io_pgtable_ops *ops,
>>> +					 unsigned long iova, size_t size,
>>> +					 unsigned long flags,
>>> +					 struct iommu_dirty_bitmap *dirty)
>>> +{
>>> +	struct arm_lpae_io_pgtable *data = io_pgtable_ops_to_data(ops);
>>> +	struct io_pgtable_cfg *cfg = &data->iop.cfg;
>>> +	struct io_pgtable_walk_data walk_data = {
>>> +		.dirty = dirty,
>>> +		.flags = flags,
>>> +		.addr = iova,
>>> +		.end = iova + size,
>>> +	};
>>> +	arm_lpae_iopte *ptep = data->pgd;
>>> +	int lvl = data->start_level;
>>> +
>>> +	if (WARN_ON(!size))
>>> +		return -EINVAL;
>>> +	if (WARN_ON((iova + size - 1) & ~(BIT(cfg->ias) - 1)))
>>> +		return -EINVAL;
>>> +	if (data->iop.fmt != ARM_64_LPAE_S1)
>>> +		return -EINVAL;
>>> +
>>> +	return __arm_lpae_iopte_walk_dirty(data, &walk_data, ptep, lvl);
>>
>> Intel/AMD drivers also checks:
>>
>>         if (!dmar_domain->dirty_tracking && dirty->bitmap)
>>                 return -EINVAL;
> 
> Is that really required? Is the concern here is user may issue
> GET_DIRTY_BITMAP IOCTL without any validation and that may
> result in unnecessary scanning of page tables? May be we should
> handle it in core code then I think.

This is just to catch the case where IOMMUFD can call into read_and_clear()
without dirty tracking enabled and without a bitmap structure to clear dirty
bits -- in order to ensure a clean PTE data snapshot after start(). And thus it
errors out on others.

Right now we don't track in iommufd that dirty tracking is active in the domain,
vendor does so in its own way. I mean we could move that to core, but we end up
duplicating what the iommu driver is already doing.
