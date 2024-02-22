Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD1C1132C1B
	for <iommu@lists.linux.dev>; Thu, 22 Feb 2024 13:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708608246; cv=fail; b=U2VdusqdBqCMpQiXdYnSPDqGQb/fGuchQjwIFFzuuLf0eWUU96ptpvsbNOfDDbh7Tl3wowQXSoDB/+gYUl5tPK8gVPV9fUz5m/tfEb+Kxq1KR3iyFrfKakNkYZNUZAN8xMnxHlgLflE0J3uJmvHXU9zr904btg4jJT/1tMXQCao=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708608246; c=relaxed/simple;
	bh=JI2dyBCthcDgCEc9/+p3twMERFvXxG309H2Ex/KS7rI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ANpckeL5e1aD1VV0/XzAvrPq/dKgt8KsjbNpMGInuUE0KEWgTjiygixGMsmbgw77Z7y37K4HShLgGfT1t30EZmJx3gw+GnilTkcHULLncz4vYYDcQkh5S0x52NRGcex5YCHmE7NRMsmHXxML8nQvV96BUcYtlx1fxhE+nqch1WI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jmcQW6yP; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=c9SrpDqk; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jmcQW6yP";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="c9SrpDqk"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41MBaH8T018110;
	Thu, 22 Feb 2024 13:23:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=1T6l1FO46vjtSTUhfEg1zaRA4gcDxkCDlL62LK9/c0w=;
 b=jmcQW6yP51cFJKgZT63ktHaRlX+tSgjYaf87yrKeI3BN0eqKcfgEJjw2iiYPv41UKST6
 C1NF1AtwxRDF54vCTVM3YG9ZDW+rmCLHSxjTXYSJaA5RF6j3qyCZcjK2pockgqqAua4Y
 P5ha64graU+POCzW4G9T2vY8XdZgPg+J4xlaAl8FO+Tde9yh0BDHT/Tg+87XxlPrfkjv
 zy84WIiIyyf7n4BSDJ3XmRvPUInU81ND/p2nY3ZntxTqzZ9esu2ibYniDcORMJpaCmve
 /mRi4ZNE1Dp2e9+3ADOkvnnf/a77cUywK96G433kRE8LfdBk7QUfUkX3za2AXVfGm1SM sw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wakqccn9q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Feb 2024 13:23:40 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41MDAjk9037761;
	Thu, 22 Feb 2024 13:23:38 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wak8amgbp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Feb 2024 13:23:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mvqXQnzJ/M/1naMn7i1MOBKYzDWFvzUSsZvej9dguQZTwOkAa7GKJfILMbOB+tjcvnQ37zBYAqKuSJy66lfMBpjrjaURSpDuTQFPFGD7u7V/7f0gQPWSp2X1Tu4FOUrH6U9tAIxr9DLOMSxtmaQ5RZDXZ9N2t3zPJq4lbfyfwDPTfwtvglsDxzPXUGtSzNO6F9eA7dBhRgZcp0eInaGjNo70KNLnW8pXuGN6qMLwnDDLnhqZHQFELaP/0RSdLzFKjQYnWCU32afD7lvoWp6P5NWmTKNtFc6OSfYMMRpAnKSfqZEaksBghRyxqhbNHZ7H0VrE2pLsLToGFxYKVyR0Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1T6l1FO46vjtSTUhfEg1zaRA4gcDxkCDlL62LK9/c0w=;
 b=B6Z6gvkGHzI38lnaaio1ZMG/jdnimcamXoycgMPC4+jxy5gWU9yj2Vsq4DGWTtlAit5GaUrg71J/rUvecfvsB93INvcMHRelPnF1X9k7GxllxSUWDOEviWaZs9b0WRf7EwzSLEX3uyx9QpMAEUZeE6jrxQyXqJ/6UKsznKC7XAk9xILjUSy/Zu8C4tMZfBe+tgg7aMz5toOgnJsE9MALYsp4xEyZPyakqZTfdw4MNxcGZuFjTWD7CatJCgJUKebHkj9s2q4Fn9I5y8BnvCEreS7+Cyusaac7mvNMF0J1sUbglbYjYnekjHlPuTgssnnxkupqX8sU+9gkKfdmBvTfog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1T6l1FO46vjtSTUhfEg1zaRA4gcDxkCDlL62LK9/c0w=;
 b=c9SrpDqkfoolvdSOb0mewlgeXYq0dekF8/6VzeZMvUS3nzT1BD+T0Dk0i6qkj4siqQrINsEfpzFYSiw6VdZHxzoxsDrzCa0hdi42ETGDVsgxwgMKH5dSmCpoUGA+/raDzGzS/fJU20XZdpr3dbS3gYUWYFck6wPsjo9iQbmWOVg=
Received: from PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11)
 by PH8PR10MB6648.namprd10.prod.outlook.com (2603:10b6:510:220::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.24; Thu, 22 Feb
 2024 13:23:33 +0000
Received: from PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::3356:4cc1:701e:dde3]) by PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::3356:4cc1:701e:dde3%4]) with mapi id 15.20.7292.036; Thu, 22 Feb 2024
 13:23:33 +0000
Message-ID: <5beb0b15-04d2-4cc3-821f-c6ca445e5c0b@oracle.com>
Date: Thu, 22 Feb 2024 13:23:26 +0000
Subject: Re: [PATCH v2 3/4] iommu/arm-smmu-v3: Add support for dirty tracking
 in domain alloc
Content-Language: en-US
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Cc: "joro@8bytes.org" <joro@8bytes.org>, "jgg@nvidia.com" <jgg@nvidia.com>,
        "kevin.tian@intel.com" <kevin.tian@intel.com>,
        "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "mshavit@google.com" <mshavit@google.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        jiangkunkun <jiangkunkun@huawei.com>,
        zhukeqian <zhukeqian1@huawei.com>, Linuxarm <linuxarm@huawei.com>,
        "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
References: <20240222094923.33104-1-shameerali.kolothum.thodi@huawei.com>
 <20240222094923.33104-4-shameerali.kolothum.thodi@huawei.com>
 <a47699c9-4f3d-4cd0-94f4-f19e117ea6a3@oracle.com>
 <dfdc7daf8bd14b04b9bd29faaa1e6a96@huawei.com>
 <5607ece8-ce00-4834-9ae9-f4aa16fc4886@oracle.com>
 <d6442be07c9d4f999286e073ed221984@huawei.com>
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <d6442be07c9d4f999286e073ed221984@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM8P251CA0006.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:21b::11) To PH0PR10MB5893.namprd10.prod.outlook.com
 (2603:10b6:510:149::11)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5893:EE_|PH8PR10MB6648:EE_
X-MS-Office365-Filtering-Correlation-Id: eb7924b8-7986-4ac3-e7f8-08dc33a977c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	YT2tfaBdzZIz7HExUfIPJrYYr3IUtF4sLY1dWt7yPSUerlDcUkcu3em8fWjIxeoU0m9P9+QS3raEhyjB0mJtjQJqPMXRaIRpAM7Ud0S7rBu9/R+pLwsxvB/bEu2/LiAJHpqkF12pV14XrOpVtixDxGYqDwoHSnV9WsTjOk4GQ3opAcGKDATsmCxzbNRYsswQW3d/PWuUjW9qG+GTAz4YXh/GEySfviI/fCDgnpgtIOkjnGxmn3jhwAYnA7oezqEDr4xvOjPwB8m1iGA9GwKcTObrVpEl6S79zNA1WgVKix8+c5aGHkiLkmAG9le3YOjY9wL8vkVEQ6RZugVd5U8UizYlPQvSVSjp8LPil2epdeIC2H6T5nAvY/NAoz2CkLzcJpQZfQPnE2bHpg6D/Q4sfbLG1K16KvkBF69sxpdyowQrhXXV1DJxaSJEvLKz87fR/iNLu425GuEqiSSCI24PcKBsFaKZo8cosM0r5ENhXKByma5mme0Kn6n/KzZwxeysf1+VY5ZE1Kv5/3vzv4T76rXETd7JigG0332u7iv9fS4=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5893.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?M0VQS3J4b3NQQzFuNGtvRVFIb0RsK1ByQTFoQXQwWjlZdGNwL0sxS2hraDNC?=
 =?utf-8?B?RUpYenRZcEhsMG44YU9tZHJPTzZ1L2hFcnRPaHBPSEVUbkRSOXRxSVVuSXJ4?=
 =?utf-8?B?VzZQYVVHTzJGUCtTMDZnU0lPOFBLZHVUekZGS3ZIaUdSbytRRUx5MVNSTUNt?=
 =?utf-8?B?VGRrMHFQdW54bXRrSk5kaVNaeHZDUUZzKzkxMlNIV2NRZVk2ajZtWVdsckJp?=
 =?utf-8?B?OVNrZkk4ZGVmMTZtZzlqTTB4WVBJb1E2cHgxVmhIYkJobUtSTzZYcGI1cTls?=
 =?utf-8?B?ejZaMmg1YmdScVNnOXhScEp5dGQ3bnA5UTAyMlUrQWdhSDVjMjZYWU96bnc2?=
 =?utf-8?B?Zk0xSEFOcGlGYTNQOG16MU10bm9jOHhBMjlCbmRPUGNWQ1NDS0M5UzhFUVky?=
 =?utf-8?B?cDZGd29GNXp4VkI4N244VTNMeVdDeHFvV2I0U2w5cUkxMGlMZk9DUUxDRkQv?=
 =?utf-8?B?M2owVUdINUZwbnU2Y09hR0xvM0g1eHNRK1JXVXJkeWJLY0ZhdWNHUys3ZUJ2?=
 =?utf-8?B?amdmRkw2UnhuRHF2d1lnb3M0c1RLSm1jZGtwdTA3RExtL3VvOHRVbDF5Nktz?=
 =?utf-8?B?R1M1NmVybWRMR1k1MXU1dXFmVG1nT0VEQUZ0djJCbkJmZHBxakorY1JqRjZq?=
 =?utf-8?B?ME9CNE1mQm11aXJKenpCT2ptUEs4aTR3a2NTRVZDeU9EUU5uQWUrT2s0OTMv?=
 =?utf-8?B?dXlyZlA3SGhPMmFYR1RwR2JKTjB6NVY2ZGtUMkRCeEZMWVJCME8zR2RmdHha?=
 =?utf-8?B?SFlHd1p1QzBLdXJkTTlNT3J1VFVCaXJDRUwvM3FjazQwcXVDOFBSTVdWSlph?=
 =?utf-8?B?dzBjV0wzemEyN3RZQk8yK05kTlRER3F2Q25naklCQ0VzalM5WlpQOC8vRDNz?=
 =?utf-8?B?T21LeUx4bzVoV2gxU2VqOEs5TFFGNzZVNjJra1NmTE1BZW4yTWVjQW5ZME9q?=
 =?utf-8?B?MjFXbjh2V3pPKzdHUmluZDNwRFRqQ3drMzliVkVXalg5SnpxeDczQi93L1pG?=
 =?utf-8?B?TTVwdFFCWUtTQXhMVmJuaTByNk9vVkdMcWVMdU9hVE92RGY2dXZ3aHlGcUsr?=
 =?utf-8?B?eklYY3J2OWVHU3I4OGdYKzF1ZjN5ZUtiOFJta2Fpd2d5YU9rMGFjeDdrVW1G?=
 =?utf-8?B?SWxnQnpWc3htRkQ2NVBJQXVmS29OQTNHQk5OZjFhNWRnY0pvcHF3K2FjeUVr?=
 =?utf-8?B?MnJIb0Uvb1NlVlMvT1ZEam01dGN4ZlVyMEVabGNWWUl3b3J1YVRBbjg2WVlz?=
 =?utf-8?B?M2Y3RVVKeVZwQkRqT0tlZUZVcWNpNi9tSWxUK2RtbzBMKzE2OWErbVJNWm54?=
 =?utf-8?B?V0VPR1hZdS9oWitncVBteVl6UGR5Vmp4ZXY0a0U2K3gwODNKOUJOR2tkdWFT?=
 =?utf-8?B?ZkdCangzV1YvM2hmNXJkaExrSGQrNUFGNW45Y2hUakFQeUJVaUlnRFBhdm4w?=
 =?utf-8?B?M2dnblc1Mjl6cmYvWCs1NXp1Qm9YYlY1Yk1oeDFMWkEzK0lXcEc2Wko0VEtE?=
 =?utf-8?B?amJKLzlHU3dxamt0WGhydGdXYmlHTEhJM01maEhoTFVEOUtTOFM5Uk5oNjBx?=
 =?utf-8?B?ZDJSRnp6VUJPcjMzaFpLVVcyd2RUaE5yTlMvVE5vNU9IcnVqQ1JNT3dzNUVp?=
 =?utf-8?B?OEFGMHhCb016UnpSUEdNRFBDaTFhQkVDTUI5RXhwV2dDajFJWVcwanJPRlQ5?=
 =?utf-8?B?Nk42SHRoRXpWZEVobUQvOFNRUmppTEYzaXlmejZwajdsMW41RWRIYmlVYXQ4?=
 =?utf-8?B?cFNOczFZUG01Y0lFVjVwMUxWdnBpbU1adnhaeVpmMTRZY0NxM3dpbnFDRURZ?=
 =?utf-8?B?N2M1d1BLaHRmU242YmhzVkJ4SGtNZFpIbkJCbmFHWEU2cXJib3pDZkNCNFYx?=
 =?utf-8?B?alNnanlrbWk1VUNkUzlwci8wYnhjSEx4UjIvRXMycXhWOUFOenM4VnUwdk9u?=
 =?utf-8?B?dER3L1M5aFVmaUVIMFRWTGR3OFdWVmVjbjkraVpUM01zSDkyVkt4Yk5JUGpN?=
 =?utf-8?B?MndUSUl5YkFvWmdBSnQ3S1RmYWJKWFJSdHAyWW11U0NXVVNzVjVhOTBGdlBF?=
 =?utf-8?B?eWdPby9QNm13dnJYd09ZK1pNNm9HSER0RXlVc1BlQU1CRldTUU1LLzlOZ0ll?=
 =?utf-8?B?UUNSOHFuMmpISy8yL1FoV1JmMmVaNTAvMEtVcUsxMUdRc3ZCc1kwcnlRRlo2?=
 =?utf-8?B?QUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	CJMCfau1QMW3zYQ92IWGXazCGIxeiOfCNZ+dYo4BU5Ol7HAXAecWcACAr6+0gkdVfkZH1/+7GP9bGDQ/WIG/K0OUfg8CyIc3y7TAr9QTb2ZLGJDeliDJXklzsKtbr/04Qqr+vb83V1F0r4bvL9LJoTdsa6nn6u3WyRAL89oNiDhhH4+cKu9kO02Q/olD2xkbDHfVV6CDkF6lzfAJbndK0yPTe3S6OXKqrgvJhxLzXX2f6fml596lRzjCz0FRyLM6CSnPzb2tlDbNuGvleEgC5bGJaNzjODmTvQoYQiHIw5DUDOaEvok3Uwwt8d6DyGmz4yTlt2O/R74r3a7sFvHMyQu/ZKxaZwU7jLrFYh/PMi0W5zI1WwMzG0iOQ5U8AMk9F1sjPW2+tPO7LIhHsTS+PGY7tW8ZdpDkku2w1e/SFrDGLebASCkucjzoPi7eNgLdEWK6FeG3oLga9vhibPk3b6vHEkw9+zc/PnMBnMgQeFLGVUshFFuE8gvy1aHpXobQ4kz9K+PMmVsXuZJ01nfSuxhb8zixzIUR5Z4b4Y/L9PT4uP91mEzMKPpnQBHdUxr851PnmI7YffSTVRfn4KYrl5jmgXXxcXJcofdEH6t5+P8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb7924b8-7986-4ac3-e7f8-08dc33a977c5
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5893.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2024 13:23:33.4215
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: soDhrGIlMpP8lGiODuXN2Bw/Id4c0QUPOBMI2laQUt67EWf8qFYdhkRN6tkXRibs7SJmVijJve90qjSv26CuRX9AZkuBxm93f8JBYXY4OAg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6648
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-22_10,2024-02-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 malwarescore=0
 bulkscore=0 adultscore=0 suspectscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402220107
X-Proofpoint-GUID: j1UwiqKTTyym4_pBcU8hNuEtA2zVd4mx
X-Proofpoint-ORIG-GUID: j1UwiqKTTyym4_pBcU8hNuEtA2zVd4mx

On 22/02/2024 12:24, Shameerali Kolothum Thodi wrote:
> 
> 
>> -----Original Message-----
>> From: Joao Martins <joao.m.martins@oracle.com>
>> Sent: Thursday, February 22, 2024 11:38 AM
>> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
>> Cc: joro@8bytes.org; jgg@nvidia.com; kevin.tian@intel.com;
>> nicolinc@nvidia.com; iommu@lists.linux.dev; mshavit@google.com;
>> robin.murphy@arm.com; will@kernel.org; jiangkunkun
>> <jiangkunkun@huawei.com>; zhukeqian <zhukeqian1@huawei.com>; Linuxarm
>> <linuxarm@huawei.com>; linux-arm-kernel@lists.infradead.org
>> Subject: Re: [PATCH v2 3/4] iommu/arm-smmu-v3: Add support for dirty tracking
>> in domain alloc
>>
>> On 22/02/2024 11:31, Shameerali Kolothum Thodi wrote:
>>>
>>>
>>>> -----Original Message-----
>>>> From: Joao Martins <joao.m.martins@oracle.com>
>>>> Sent: Thursday, February 22, 2024 11:04 AM
>>>> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
>>>> Cc: joro@8bytes.org; jgg@nvidia.com; kevin.tian@intel.com;
>>>> nicolinc@nvidia.com; iommu@lists.linux.dev; mshavit@google.com;
>>>> robin.murphy@arm.com; will@kernel.org; jiangkunkun
>>>> <jiangkunkun@huawei.com>; zhukeqian <zhukeqian1@huawei.com>;
>>>> Linuxarm <linuxarm@huawei.com>; linux-arm-kernel@lists.infradead.org
>>>> Subject: Re: [PATCH v2 3/4] iommu/arm-smmu-v3: Add support for dirty
>>>> tracking in domain alloc
>>>>
>>>> On 22/02/2024 09:49, Shameer Kolothum wrote:
>>>>> From: Joao Martins <joao.m.martins@oracle.com>
>>>>>
>>>>> This provides all the infrastructure to enable dirty tracking if the
>>>>> hardware has the capability and domain alloc request for it.
>>>>>
>>>>> Please note, we still report no support for IOMMU_CAP_DIRTY_TRACKING
>>>>> as it will finally be enabled in a subsequent patch.
>>>>>
>>>>> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
>>>>> Signed-off-by: Shameer Kolothum
>>>> <shameerali.kolothum.thodi@huawei.com>
>>>>> ---
>>>>>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 95
>>>> ++++++++++++++++-----
>>>>>  include/linux/io-pgtable.h                  |  4 +
>>>>>  2 files changed, 77 insertions(+), 22 deletions(-)
>>>>>
>>>>> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>>>>> b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>>>>> index bd30739e3588..058bbb0dbe2e 100644
>>>>> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>>>>> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>>>>> @@ -43,6 +43,7 @@ MODULE_PARM_DESC(disable_msipolling,
>>>>>  	"Disable MSI-based polling for CMD_SYNC completion.");
>>>>>
>>>>>  static struct iommu_ops arm_smmu_ops;
>>>>> +static struct iommu_dirty_ops arm_smmu_dirty_ops;
>>>>>
>>>>>  enum arm_smmu_msi_index {
>>>>>  	EVTQ_MSI_INDEX,
>>>>> @@ -86,7 +87,8 @@ static struct arm_smmu_option_prop
>>>>> arm_smmu_options[] = {
>>>>>
>>>>>  static void arm_smmu_rmr_install_bypass_ste(struct arm_smmu_device
>>>>> *smmu);  static int arm_smmu_domain_finalise(struct arm_smmu_domain
>>>> *smmu_domain,
>>>>> -				    struct arm_smmu_device *smmu);
>>>>> +				    struct arm_smmu_device *smmu,
>>>>> +				    bool enable_dirty);
>>>>>  static int arm_smmu_alloc_cd_tables(struct arm_smmu_master *master);
>>>>> static void arm_smmu_tlb_inv_all_s2(struct arm_smmu_domain
>>>>> *smmu_domain);
>>>>>
>>>>> @@ -2378,7 +2380,7 @@ static struct iommu_domain
>>>> *arm_smmu_domain_alloc_paging(struct device *dev)
>>>>>  		struct arm_smmu_master *master =
>>>> dev_iommu_priv_get(dev);
>>>>>  		int ret;
>>>>>
>>>>> -		ret = arm_smmu_domain_finalise(smmu_domain, master-
>>>>> smmu);
>>>>> +		ret = arm_smmu_domain_finalise(smmu_domain, master-
>>>>> smmu, false);
>>>>>  		if (ret) {
>>>>>  			kfree(smmu_domain);
>>>>>  			return ERR_PTR(ret);
>>>>> @@ -2445,10 +2447,11 @@ static void arm_smmu_domain_free(struct
>>>>> iommu_domain *domain)  }
>>>>>
>>>>>  static int arm_smmu_domain_finalise(struct arm_smmu_domain
>>>> *smmu_domain,
>>>>> -				    struct arm_smmu_device *smmu)
>>>>> +				    struct arm_smmu_device *smmu,
>>>>> +				    bool enable_dirty)
>>>>>  {
>>>>>  	int ret;
>>>>> -	unsigned long ias, oas;
>>>>> +	unsigned long ias;
>>>>>  	enum io_pgtable_fmt fmt;
>>>>>  	struct io_pgtable_cfg pgtbl_cfg;
>>>>>  	struct io_pgtable_ops *pgtbl_ops;
>>>>> @@ -2459,31 +2462,31 @@ static int arm_smmu_domain_finalise(struct
>>>> arm_smmu_domain *smmu_domain,
>>>>>  	if (!(smmu->features & ARM_SMMU_FEAT_TRANS_S2))
>>>>>  		smmu_domain->stage = ARM_SMMU_DOMAIN_S1;
>>>>>
>>>>> +	pgtbl_cfg = (struct io_pgtable_cfg) {
>>>>> +		.pgsize_bitmap	= smmu->pgsize_bitmap,
>>>>> +		.coherent_walk	= smmu->features &
>>>> ARM_SMMU_FEAT_COHERENCY,
>>>>> +		.tlb		= &arm_smmu_flush_ops,
>>>>> +		.iommu_dev	= smmu->dev,
>>>>> +	};
>>>>> +
>>>>>  	switch (smmu_domain->stage) {
>>>>>  	case ARM_SMMU_DOMAIN_S1:
>>>>>  		ias = (smmu->features & ARM_SMMU_FEAT_VAX) ? 52 : 48;
>>>>> -		ias = min_t(unsigned long, ias, VA_BITS);
>>>>> -		oas = smmu->ias;
>>>>> +		pgtbl_cfg.ias = min_t(unsigned long, ias, VA_BITS);
>>>>> +		pgtbl_cfg.oas = smmu->ias;
>>>>> +		if (enable_dirty)
>>>>> +			pgtbl_cfg.quirks |= IO_PGTABLE_QUIRK_ARM_HD;
>>>>>  		fmt = ARM_64_LPAE_S1;
>>>>>  		break;
>>>>>  	case ARM_SMMU_DOMAIN_S2:
>>>>> -		ias = smmu->ias;
>>>>> -		oas = smmu->oas;
>>>>> +		pgtbl_cfg.ias = smmu->ias;
>>>>> +		pgtbl_cfg.oas = smmu->oas;
>>>>>  		fmt = ARM_64_LPAE_S2;
>>>>>  		break;
>>>>>  	default:
>>>>>  		return -EINVAL;
>>>>>  	}
>>>>>
>>>>> -	pgtbl_cfg = (struct io_pgtable_cfg) {
>>>>> -		.pgsize_bitmap	= smmu->pgsize_bitmap,
>>>>> -		.ias		= ias,
>>>>> -		.oas		= oas,
>>>>> -		.coherent_walk	= smmu->features &
>>>> ARM_SMMU_FEAT_COHERENCY,
>>>>> -		.tlb		= &arm_smmu_flush_ops,
>>>>> -		.iommu_dev	= smmu->dev,
>>>>> -	};
>>>>> -
>>>>>  	pgtbl_ops = alloc_io_pgtable_ops(fmt, &pgtbl_cfg, smmu_domain);
>>>>>  	if (!pgtbl_ops)
>>>>>  		return -ENOMEM;
>>>>> @@ -2491,7 +2494,8 @@ static int arm_smmu_domain_finalise(struct
>>>> arm_smmu_domain *smmu_domain,
>>>>>  	smmu_domain->domain.pgsize_bitmap = pgtbl_cfg.pgsize_bitmap;
>>>>>  	smmu_domain->domain.geometry.aperture_end = (1UL <<
>>>> pgtbl_cfg.ias) - 1;
>>>>>  	smmu_domain->domain.geometry.force_aperture = true;
>>>>> -
>>>>> +	if (enable_dirty && smmu_domain->stage ==
>>>> ARM_SMMU_DOMAIN_S1)
>>>>> +		smmu_domain->domain.dirty_ops =
>>>> &arm_smmu_dirty_ops;
>>>>>  	ret = arm_smmu_domain_alloc_id(smmu, smmu_domain);
>>>>>  	if (ret < 0) {
>>>>>  		free_io_pgtable_ops(pgtbl_ops);
>>>>> @@ -2811,7 +2815,7 @@ static int arm_smmu_attach_dev(struct
>>>> iommu_domain *domain, struct device *dev)
>>>>>  	mutex_lock(&smmu_domain->init_mutex);
>>>>>
>>>>>  	if (!smmu_domain->smmu) {
>>>>> -		ret = arm_smmu_domain_finalise(smmu_domain, smmu);
>>>>> +		ret = arm_smmu_domain_finalise(smmu_domain, smmu,
>>>> false);
>>>>>  	} else if (smmu_domain->smmu != smmu)
>>>>>  		ret = -EINVAL;
>>>>>
>>>>
>>>>
>>>> I think we are missing the domain attach_dev check for dirty tracking.
>>>>
>>>> Something like:
>>>>
>>>> if (domain->dirty_ops && !arm_smmu_dbm_capable(smmu))
>>>> 	return -EINVAL;
>>>>
>>>> But that helper is only introduced in the last patch, so maybe:
>>>>
>>>> if (domain->dirty_ops &&
>>>>     !device_iommu_capable(dev, IOMMU_CAP_DIRTY_TRACKING))
>>>> 	return -EINVAL;
>>>
>>> Ok. But do we really need to check this in attach()? As dirty_ops are added only
>>> if it is requested in alloc_user() and there we return err when hardware doesn't
>>> have the capability.  So not sure how this matters in attach() path. May be I am
>>> missing something.
>>
>> That's when you create the domain with dev A. Afterwards that dev A is
>> attached,
>> but later on you can attach another device B to the domain. So this check is
>> there such that a domain with dirty tracking ops set will only have devices in
>> there that support dirty tracking.
> 
> But that only matters if dev B is on  different smmu without dbm capability, right?
> In that case we already fail the attach with,
> 
>>>>  	} else if (smmu_domain->smmu != smmu)
>>>>>  		ret = -EINVAL;
>>>>>
> 
> Is that right?
> 

Oh yes, I missed that. That looks indeed to do the equivalent.

Perhaps a comment there at least to remind to reader in the event that such
check being lifted.
