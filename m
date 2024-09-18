Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047451C2303
	for <iommu@lists.linux.dev>; Wed, 18 Sep 2024 14:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726671127; cv=fail; b=bejyvpfaN5Sbf0Kig1jQnXeE4YrLFL68EHLyOKPi7SngAQ7W8vhRoaHqfnMNLjLQ2lBdUPEZmYnAMlaEo6TmYvQuEAhOP6j/v8MDUwye34sne+nRikjmUl1kSeKt6HA0lednTHF1k/yQd6Aeft71xn1TdAUGwrSIU0nyoI/SyTo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726671127; c=relaxed/simple;
	bh=lw3kMoj1e57e389b5alkX8g0JGQm7Q6GvnFedyaSTqk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KP3qFBT/edL4VHBgOhYIPWv+KNdi/OYRCHH7SYpZnh5SK42/GifIXgWpJPqjhZwtXZXuZTaRKQdOIHt1/C1Na3c4Bg7HPOb7R9KvIMiphgow4QIKvy0atAQFp0Z9dD0KXQSTEfkqb59S0hffKfwkZTl60fhGh5GYEKS1UXS7xRk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Ion5wlhd; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=vPoknXfL; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ion5wlhd";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="vPoknXfL"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48IElNA7001867;
	Wed, 18 Sep 2024 14:52:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=RwA/9Wrs7++GFnmlQnzaY/A9iH+1Yu02GAvIxcIEllA=; b=
	Ion5wlhdjfrtFXacraG1vkbtiY76Lz3QjzP3cWAtrQFbCdiYmtlwLG77LFDXVPug
	XQia0LZtznZfeXLwn0u0o941D4ubtDAWd1gFk7TjOKj6ReXSEQmCd+9GCgA76Kat
	5kn7zRcNKRebFyeaiNlsyBazY1L6VDhLgLxqeZ2MXRwoify2zxcZ64/+/peQTfbj
	LiCVHqsYW/0RYLwutg/l4isGI420S96PYmKkhAbWqwCQA5oCeWwsAHpBgVB5wXJQ
	5J3+z9rWSbh6OTP6xk9MGUdu/IhiZPUzQ5W5/8lUfwvnVOf5piHIMT/nNQErKZih
	3RJF75o+6sCsy9Ve7Lwi2Q==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41n3nshk79-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Sep 2024 14:52:04 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48IDgGM1035317;
	Wed, 18 Sep 2024 14:52:03 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2043.outbound.protection.outlook.com [104.47.70.43])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41nycjdpmf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Sep 2024 14:52:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yg7MmvY6y2X1UqS33fD9qzBqciuwBF/Zr8r/eqk/GSZBxUWSpKAW3AmPkb7eqG2C8pvdyqpTZ+PU61BATdL7GA4IDPppFLNKfJdKzYUKfvK0R01ieSV7cnxO98Ta60BSPKyjLv7nTtGoy+aoT7pPyNKtYlpzVLlRGcpsjaGeD7i4ZiCWRNoqk/0rOnuEeCWU5OtwMd4kt6dibGjuYjFoVOCsB2BOM2Muf80ramiOUpYiRP/VncVb7IVj9PaALYtAAhlJbN7X0YiVQDx8lBHfKkS/0bTg76gB3PSuht0kmJDisWXQshA1t4cWBQuZWxeB5o32KwuAgmQy+aJGwVm/DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RwA/9Wrs7++GFnmlQnzaY/A9iH+1Yu02GAvIxcIEllA=;
 b=kw3RyiCtS1+ui0lEGOCOgxBhMnfwXBTUikWjGHHTOJQ9EscLLLPCveLniE7h7pyjtO5JpGjIaCdOJ/55T0GSY4ASWygzPw4OL6PYevfVqA8+vxLzvZimNuEtCyhvHuS9nmD7xEjb/n1Eb67f5tu97LBAYTuyH6KPgWP42b/zD7/BB0yL+u8sb6admg7J71eANyQpIIA884kivCjHKKoWbRnhR4PruGLXGPBq0WXLxTwatgu3xqjajSCMjyk/uDi1maVs0QIuMCqiSUOXoVo7nqU/OHd82HhlrKQN4/nSAT61L+YCJ6nzTrx5eYrlGoJr8rf15rOYmwtgac4ln4qv4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RwA/9Wrs7++GFnmlQnzaY/A9iH+1Yu02GAvIxcIEllA=;
 b=vPoknXfLUtcV0rhJVlTSWYwZiyiUY/smyT1caK9ZdxBHnNq9+cYINYzrWyIOfBA+HRt9TAG7oFz+4hfeRlBn0IPY+Rh5NS66BKA6cKru5jEAXSQpeC9du970KD+v8poK232QogHhPoFKuEw2jItrUvtrjxkGL5AtxOkGObIkszs=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by CY8PR10MB6825.namprd10.prod.outlook.com (2603:10b6:930:9c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.17; Wed, 18 Sep
 2024 14:52:00 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%7]) with mapi id 15.20.7982.012; Wed, 18 Sep 2024
 14:52:00 +0000
Message-ID: <f9d9ed1e-d3d3-4bcf-90e4-a3a39b08af8b@oracle.com>
Date: Wed, 18 Sep 2024 10:51:55 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1 5/9] iommufd: IOMMU_IOAS_MAP_FILE interface
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
        Nicolin Chen <nicolinc@nvidia.com>
References: <1726319158-283074-1-git-send-email-steven.sistare@oracle.com>
 <1726319158-283074-6-git-send-email-steven.sistare@oracle.com>
 <ZudJIicC9EWogmWh@nvidia.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ZudJIicC9EWogmWh@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0047.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::22) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|CY8PR10MB6825:EE_
X-MS-Office365-Filtering-Correlation-Id: 652477a9-690d-4666-e285-08dcd7f1736a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UHArUmFuQ2lXaEh2UlVkbVFiQ0t3a1c1VzBwaU9kNHN0REdsa0Rvc09yM0tU?=
 =?utf-8?B?QTkvWWtqYkJNb1ROWkZTR05JYWhQZTM4UGxPVkdnMkMzME5yVHN5WDY3UTRv?=
 =?utf-8?B?T0hLNFFJdjJIZ3dUdWJ0Y09seDlyUXQvcnVkSEVLVHVGU2FPSFg0eWVPYmZB?=
 =?utf-8?B?SkFYSXVtTTBubXFaK0pVMXpQL0tJR053ZkhDeW91b05zQXU5d3hmS0swbDIy?=
 =?utf-8?B?QklsZzRTemlKck5VZDZ5VzcyQlFQKy92UWREVjJjTHppQy9mTE5paDFpeXV5?=
 =?utf-8?B?UnJWczE2eUN4d05sZ2pJd2FkdkdXdzJ1dUdBRDRTQmN5ck9VTmRMc3Rnb0Vu?=
 =?utf-8?B?Y05ucG5FSktyMlBIdXdaUW54QjFnUTJvc05oQm5teUdYdzIrajlLZkVjMklN?=
 =?utf-8?B?NEJNcHJKS3FoSk5RTXJBT3FsNmNGUkpyM1BTTEQ0Y0NiRVd1ajFYZWprZ01y?=
 =?utf-8?B?Mk55a0tnQVY1TDlDNmlNbWtncFUxdGpvQzJrK242RFk3VFQ4eFFsUnpQUXFP?=
 =?utf-8?B?V09hSEhhaCs3YjRMU2txZ25oRWszQ0pZWVdWYTQ4VTVFbDZBOFdGUzBNQ01u?=
 =?utf-8?B?QTA3WHdGdDc2MGswczZnb2p1cW1XdmRQQit5c2JPeG5zN0wzbHZVU3AvcUkz?=
 =?utf-8?B?dlJHZGpuVFpyTUwxU203WWllY0FwRU9ramRFd1NtOFllOUtEMDJuM0poWWlG?=
 =?utf-8?B?VUcyeFdJTDBmcGJRdExobWxtTTFVT0h3VElhRGw1TEYyNnFXcyt3NFZBTnUv?=
 =?utf-8?B?WWxoUUtxVUNtaHJOTWJXTFRmWW9UK0FYb3hVTitNendUbjd4c0lxVExTbDhS?=
 =?utf-8?B?TS9VMjcwUGJDOUNsOGNqRkx6dHpoa05Gc1JvemJoZFB0ME1JeFUwb2pwNGJF?=
 =?utf-8?B?TzhDeUdvM3A2cWptdkNHM2tYNVUwUFVWeVpOR3haclZvZm93T2NGVHZGS0ls?=
 =?utf-8?B?dGdqd3YzS21adEhQeVBkNHJmQVlDbGhwVHpZMldwL0VTVTQ0WHo0NGtkQ0lj?=
 =?utf-8?B?eHBSei9JdXRFOWU2UDhwbHNGZlNNVW11Y0MyRkNtdCtxRG40Sk54UGJSeER6?=
 =?utf-8?B?WWxuSXFkUWg0a25haFViM1BycjZHMVNpczA5bG5oditXTys3V0RJTlp1ZUtG?=
 =?utf-8?B?bXFBTjFWUElqRWNVcnlON3V2L3I4eDVuRFRLaDEwYXdJV2U2UExaQW1qcmlk?=
 =?utf-8?B?U0k5ektzNnZ1WjBPelVJSmJsL3Q3UHJHV2xuZ0c1Ly8vUVFVbFl4YTNqUm5W?=
 =?utf-8?B?ZkRvTjk2blU4Z2x4SHJ3THljZ09qOGNQNnVWd1JWVUpuS29JajU1Umc5L2Zi?=
 =?utf-8?B?V0hKcDdrTk4wWGRqWUh1bnQrZUI0YWd4MjdtSTVxM2NFNEZ3T2o5aStNUzhJ?=
 =?utf-8?B?Um9BQUI5YjlZTGVrL3JRcncxaGFxZURVQ3UvNG0xUjZWUnFMelZRWURSSDlH?=
 =?utf-8?B?cmxDbyszL2wwcWM3SS9hc3dlak1DbHRVSzdMY3N1N2tjaVBqdlBXbkZEd1pI?=
 =?utf-8?B?ZFZ3WjMwbEFYZDExTTVTUXE1RFlFbGlqR3h4ZloydUhmaHk3K245ZGxranc5?=
 =?utf-8?B?MW4xUzU0bmVCMC9WNmJ4SEE1YjlzSFpUVHFOVzZsNmo3TlNRL2FyL2xKUnE0?=
 =?utf-8?B?cDVac3FjMDdjd2o4cVdnc1FYRm9mQTY0ejVQazdxUWJHMWRGck80Z2VGbVN4?=
 =?utf-8?B?RHNuU3Nuc2tJdHorTUt2anhZVXlzS1Z1R1ZCOUNINHEvZ2hPam5lSWlSazE4?=
 =?utf-8?B?QzVIQjZJVGlubWFKb1N3TFJsS0lvYU4wNHcyU0s5ZDZMcmNUZzhmZ240dU5i?=
 =?utf-8?B?QlU5TWNSOTRkbXZIWk4vZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR10MB7447.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VTQrWEk2MWlXcHBxeXNIY1pLNG1EY3pLKzF3b0N5T00zV0dZb3lsZVdqWC92?=
 =?utf-8?B?aWtibFoycmhPMUl0V2dvcjI0N01UMWFHMTdvaHNLbnFjZWI2SWU4R2xVZEQx?=
 =?utf-8?B?Mk9wZ3hWTTFHRjhFUlV4VzE3TjI2Q3pBQVp2RHJHTEdJNFNzd1M5dFpHQytE?=
 =?utf-8?B?aVB2UUFLU05qRE9QamI3VkNtK2pkM3BZZ0JRazFEeStVNHQ4bkpyOUtWMWJj?=
 =?utf-8?B?M3RzTGdneW1rQnBJdENUbFhFVzNGRURucUVkL1hxUzNQaXJxRmFsRXovS200?=
 =?utf-8?B?ZzBlZEg3Z1A2Zkk3U1NvRWUwN2FtMUZDdXpsN1NDT083UVBhT0FMQzdWMjRN?=
 =?utf-8?B?V3NESmhYV0hORDE3WFpyOU5MQ3BZNmtwWHlwdW5vSnF6OGdRY0JaMGlsdUlw?=
 =?utf-8?B?aWpqQno2MU1zUTZKV1pVbTVEZkNXVlFZd3dTaDRHeVhJNDU2dHQwejltaVR6?=
 =?utf-8?B?WWJBV05sS3R5RkpnSnZjaDRuYk9BMS9xK3lkLzR0SVJEd0UxeEE0eWt0bWV5?=
 =?utf-8?B?bUpjWHczZDNscFNnNVE2Z1NtSlNuOS9yL1lDRlpTc3l5OC9kT09CZmVYQjAv?=
 =?utf-8?B?SnRKRXBCckU2NUUxdEQ2S3ZycGY3MnFwZVc0cXpmYzhLcXZuMzBGWXVnY21J?=
 =?utf-8?B?Vk5Zb2xRYWUzRjNUazdqcGF6MnVxYlEvZlpvL1FDcmxyeE82WDlERStNUXF5?=
 =?utf-8?B?cGUyRDVFSytxdjM1NE9VR3RnNjUzdDdSSE81UUcyaUVJNGJPdTRCMnhDbGN3?=
 =?utf-8?B?aXZENHFtWStWeDMyekhXbWdFYjRmNkM5bTR1RkNnb1FtMlhJOFYxVW1TSFd6?=
 =?utf-8?B?Qm9wbDUyRkJaU1UrWGI2TkV3N0lLcVlMbGE1SkdYSmV2UzFHREprRFZPSENR?=
 =?utf-8?B?L3VUd2hUMFA4UjM3allCTWsyUm5DakFEMXBMS2dSMVFxR3pzV1Y3L3JVakZD?=
 =?utf-8?B?R21hVktqOVQ1YmR4eTBHWGhGakdNMjlMUWNJUmVPRVVWdjlFOUczUFBuamdm?=
 =?utf-8?B?ZGxwN09DY2F4U2MrNGdHa21BeGxtMGFOVWtsRm1BVEhhSy9OWmhWL1c0QXFw?=
 =?utf-8?B?WnJ6U0dGUEo0eXhDdUJycWg5N3FBNTVCbU5zSEZJbGZlcjhwMk50dG9lektJ?=
 =?utf-8?B?MEpvU1N0S0pmcFoxQWwrOVpYNnI4bUtFbml4Sm0rUXVMUksrKzBmdGdydXZr?=
 =?utf-8?B?cit4WTBoU3JVeC9EV0lXazZOVHRFR1FPd3l4L2hiOGZIWUkvTlByUkNIYzZD?=
 =?utf-8?B?MWV0YnlTMlpBRS9TYmtNRmZ2cmR0Qk54Mkk2d25qcGg2SU1CL2xENk4wQXBT?=
 =?utf-8?B?TE54dFByV3h4T1hRcHBzWUt0RDVlNDMvVWpEaVBBNE5taWhmcWs5Rml0elNU?=
 =?utf-8?B?N3V4OVh1eHVDR2lkd3hsNU1sZDZTa0R6U2diemZBdzQ4YlUrcWJwTmpNUm1T?=
 =?utf-8?B?WTlSSVcvWXNpYi82TmFyTG9QdlE2VnNZRzJmNmp2QVZPU0d5bmZUTncvZ3Jp?=
 =?utf-8?B?eXl5KzVGRkhJdFJYRHhENStRWDFxb2I2bFNxMjVTNndRQnQ5ZExaSmhwTWZE?=
 =?utf-8?B?bnBJejRuZ096S29JYU1BU0lyUGxtdkM5ZVlWNysvMzBYTkJuREVyR3Nkd0FX?=
 =?utf-8?B?R0tmMUZnT1pOUU9CempPNyswdzdLV1F2Z2dYZmN5N1Q4b1lpS1BLNnIzbmxN?=
 =?utf-8?B?b3JFOXhDMklVK24wRmRvaTdzTG1rZzdWeTlpdGxQL25lT3VFSTl2RHVHNThQ?=
 =?utf-8?B?WEQ5MWM5cUZvdHN0aFFqTkY5bFpYdVRTWXNiMnBTSTFmNlAwRTNWczU1QmVu?=
 =?utf-8?B?WGZjbUFUcDV0M2ZyeDVhRnlGQ2pRamdhTkU4Z2NvcklpS0Y2Nng0d1pQTU52?=
 =?utf-8?B?eFliek1aa2ZVMm1SUTlwZEJDTW95ZmlEZDhhamdPakcxNUZlUkZJbTRjcTZM?=
 =?utf-8?B?V1p1aHNXaUNOSGNMZ1FvSk9Xa3ZsQW1VYXNwb1JRaUpLMkl1clhoQXhUTy9N?=
 =?utf-8?B?bXB6SytFNmo4RVpURXZzTVd0M0x4T0ZwUmMvNzFQL05zYkx2aHZuVW13QXd4?=
 =?utf-8?B?QzNyUi9aSmhFZmZYSXdVSHdMRDFpMFIrei9LMjRsZDlSM01EZkhtaEM5Z2g1?=
 =?utf-8?B?TUNpazlVOUlZVUFnUDllWlNvRWxUcEdFRHJxbnlPeUtSOGFKZW5qVlJjQUdl?=
 =?utf-8?B?dGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	1+nQ0WTrtUyQD/M+Oe1CEtVMNbP/uhkTcz2/0vDokXfNEQg8E82t2yJ/0oCQNf9H6RwzA+ewL4kdPIrkGPHAEuaRDkcujKnS4MHr9yQSREOh9Kh8Ax9MR62ZRb6Z+bJPGpZK/hmRjKGf0ZivuMTxdB1XSrQWebVZywG+FLoqlZz290oi1oLAEYtAP0NjX2iQDkNtL8eHqbN0HMGsN6sH9W6r2fOFNS/NSH24GSpsL2Av+8/I0TKsQZ47OBhLPfJuNltSGNRrObi3Wn88MU3H4JNh+bRQgvqRFx/SbY7TtjLQOLFlSpC1WhgXQzFYzaXkJ07nbg3wJSNR6r3Zm43o3lrnMbxr18fFrWVotfNM9laj6x0SdOKrRgdhA0Fy+2JIcWAeJ/jiOm2nEwZhFMjGV2Cq1EiF83scprHsQKiA8bISZXuzqfRTBYF3M0zWSo0ClWeUQyE+XjTLbxxk66Xs4abq/+qRzp470cytXjQj+mlNgcWle+upeHdmXDZ9nlZ3JSWRYKXW+zWBXyTwjkEBot7WfSnJmW+uI3vlyCdsupG6U0ik2xo5wT98c2nmIoKlz6JamO6v/7pqjMrewRh+SWADjC3gfdPi1TZRv2y+GtU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 652477a9-690d-4666-e285-08dcd7f1736a
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2024 14:52:00.4890
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RBNbkz31HNIfEwm0hFEp7sTTsyGuAts835CjwIiC0zlrw+ReF7RlWweTnE392UP9N+GrDwGasiTDjqDF6DJzSLGq6W4fX7x/qenqWW9gw2c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6825
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-18_10,2024-09-18_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 malwarescore=0 spamscore=0 mlxscore=0 adultscore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409180096
X-Proofpoint-GUID: GbSB2qGsIc789ludWGxsvwpJSxQYONRj
X-Proofpoint-ORIG-GUID: GbSB2qGsIc789ludWGxsvwpJSxQYONRj

On 9/15/2024 4:52 PM, Jason Gunthorpe wrote:
> On Sat, Sep 14, 2024 at 06:05:54AM -0700, Steve Sistare wrote:
>> Define the IOMMU_IOAS_MAP_FILE ioctl interface, which allows a user to
>> register memory by passing a memfd plus offset and length.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> ---
>>   drivers/iommu/iommufd/ioas.c            |  5 +++++
>>   drivers/iommu/iommufd/iommufd_private.h |  1 +
>>   drivers/iommu/iommufd/main.c            |  2 ++
>>   include/uapi/linux/iommufd.h            | 22 ++++++++++++++++++++++
>>   4 files changed, 30 insertions(+)
> 
> This looks OK to me
> 
>>   /**
>> + * struct iommu_ioas_map_file - ioctl(IOMMU_IOAS_MAP_FILE)
>> + * @size: sizeof(struct iommu_ioas_map_file)
>> + * @fd: the memfd to map
>> + * @start: byte offset from start of file to map from
>> + * @flags, @ios_id, @length, @iova: same as for iommu_ioas_map
> 
> But please check that the kdoc tools accept this syntax?

Yeah, the robot already dinged me for it :)  Will fix.

- Steve
