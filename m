Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F03053E31
	for <iommu@lists.linux.dev>; Fri, 24 May 2024 11:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716549798; cv=fail; b=C0FOUrX9P8PBSQArUjNflas+GF9659Wyvf+l9CU4lUGd+D1eLUCaEHTTgI4POJDjzkF68OkDJEJo40rT8Sfvp+2sQv6PiwI0FN7I+gH+l984ozFwcnVDDNLbXo13VfVe5PAzGfFkCL7bwskHMZCeRf1jlx/DDUM2voXiAd9GDhI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716549798; c=relaxed/simple;
	bh=jVJwoVMEGTfHlESmUqGyhLX+dEQc1H8j3DB/Vhm2OXg=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hVwe82iduyrMNGpK0FAr16BKgv8Z7+h7b2VpkKEj/8BHkFQVzVTCNbO+lD0+vg74BanQ2EV1bzY3xU10QUuA67cn/ocaPzHbgwioWPRL8zDAzUhJKwBXECXux5G43t8In8ijKOOVeEmMNICmaZZSyjTBUqi4CaB7eOLoXuhuZKM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=IZNk4Ntz; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=kdvk8vMo; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IZNk4Ntz";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="kdvk8vMo"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44O8wpWM023030;
	Fri, 24 May 2024 11:23:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 from : subject : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=9jinodNHdLI+FAtzZgq1Dgzib+d7yPn8wi0202yTAP8=;
 b=IZNk4NtzeCxbQH76Te6JPuE7bfA3zjKxNy0ipe+u3vqXKAp2joB+dDybVmQ8xmb7keQk
 IIjHxyCamFJjOSD2T/4UULK+jAkgIzEN6C2FNs7Hu6gDrQqUWPkmzZpoDXclcd/SSLFw
 x3xKZknqj2P9MtUUsq8EgnLGXc7egbEoXfo0fQzcB1DnJhqlkSaqJFE9//wV8PZ2Kttf
 Q5ydyUK1ZcO49KPkOiD4bI3PWcN13N0PbayKFIkXVeanGIz0upS48LDp8GJeM1umrL2m
 wjt7C+HZ5b1XeqJT6S0I3KX2Z2fcaJKj4CLMHRB3cOwTKqb6RdaGOWsO5e8/AgfvxDuv +Q== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y6kxvca6w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 May 2024 11:23:05 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44O9M4MU019631;
	Fri, 24 May 2024 11:23:04 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2041.outbound.protection.outlook.com [104.47.74.41])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3y6jsbtuag-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 May 2024 11:23:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hDlyCbyNxrpOX9RsbmydM7vuzd+wpuKAtcWNj27JCgTSSRAGG/NGlAmXk5SABhLzLcrIEYxb63oTKCQ8cpOWVmZWsXElo8vYbIr7Ckhg2iraXg8bZQ5FviayCeksYm2kINqwyJ8sKoQq4uFxKWncPez6UuTxkPSDGg56tSmPIar21PvCKL85vXkQpKBudpzPPeuIBJsL9K5zeCchpM2vqZYwMy1MwHo1cWp5QoXzy96w7/EjbZpoeMcbDXkLeLg7mAqIiK9usSIyKHlKOf7nY1/LJygXPEF0F3JzujMztvZwfZFzipCrWRNWBtnUC/vZ48nS5htEArx/byJwq3iUDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9jinodNHdLI+FAtzZgq1Dgzib+d7yPn8wi0202yTAP8=;
 b=KuGwSpCd9Qs5L6/nyRjQgS0yzEHj9G/cJe00UIWdAMiaBJgakDW9mifKzj945CzqNbtIQiMqvhxafAhH9oFy3D6w//9xN1ApglLPm2r3uXEOf2Utb8T3zyzKByREQo5CmrrOo8uSS0BEadtrT7YejefYyz2PjTeyFvmjU3vaxsm4HeqSQQMh6/1DCgR3OfnAhudJiIVVhTvy9zleZ8D/OhOM+lbG6o/07+yxNP5vbswxEXmTT2RLW7syL5G3EcCCCa7xq4DMFwAnosPGTogRpFogz149zaD+puMSgeFtS1vIaDzthfWK/lL72OhvzHEDuQDNbVVwMIXT/K9fFkrs1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9jinodNHdLI+FAtzZgq1Dgzib+d7yPn8wi0202yTAP8=;
 b=kdvk8vMoYXgw+q+B4pn9x9jr+3tMIeAlhudZLlzsPsOMljDop7r/wM4MD9GJA91Z3z7YMKJSdg6f5B3bs/a2lHRJeBCj8Anl2yvwtFzb0X66RawiCFxxq4aOAnqsx/H+ZG/lUdqRTb00CWR9FcwlG841D0JIEhQov4NHE45qQvo=
Received: from PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11)
 by SN7PR10MB6572.namprd10.prod.outlook.com (2603:10b6:806:2ab::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Fri, 24 May
 2024 11:23:03 +0000
Received: from PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53]) by PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53%4]) with mapi id 15.20.7611.016; Fri, 24 May 2024
 11:23:03 +0000
Message-ID: <6b90f949-48da-4cb3-ad9a-ed54f1351a9a@oracle.com>
Date: Fri, 24 May 2024 12:22:52 +0100
From: Joao Martins <joao.m.martins@oracle.com>
Subject: Re: [PATCH v1 4/9] iommufd/iova_bitmap: Handle recording beyond the
 mapped pages
To: Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>
Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Lu Baolu <baolu.lu@linux.intel.com>, Avihai Horon <avihaih@nvidia.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
        iommu@lists.linux.dev
References: <20240202133415.23819-1-joao.m.martins@oracle.com>
 <20240202133415.23819-5-joao.m.martins@oracle.com>
Content-Language: en-US
In-Reply-To: <20240202133415.23819-5-joao.m.martins@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0081.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bd::9) To PH0PR10MB5893.namprd10.prod.outlook.com
 (2603:10b6:510:149::11)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5893:EE_|SN7PR10MB6572:EE_
X-MS-Office365-Filtering-Correlation-Id: a6e42604-3b81-45ce-22a6-08dc7be3e01e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?U3lod0YzOEZvTUZydnYySE9MekJhc083S2xIZVJFeVIxVm85dHZoQTRpVmhj?=
 =?utf-8?B?U0Q4U2Z1QXpUS2QwQWYwbm84bzdDdUFpZ0Vuc3BuMmtjYUdrcklNYXZpdjFT?=
 =?utf-8?B?Rm9QYUVBOWlwTnVmZGdXM1RPR0xJWjRBN2VBWHZLY2JOelMvU0lpZHh3ajRD?=
 =?utf-8?B?ZkdhdDYzcS9LZDFyd3E4THY1Z1A0TTV0K2JzTm9YUFQwRkVwVUZsc1pjTjNX?=
 =?utf-8?B?Y3J4cmpGUnhadUpUOUVyTlUrd1cxSTVaMTZwMVFBNTRLSWR2VlNaUnBXYUlJ?=
 =?utf-8?B?ZFF4WGo4WHZrbUhaSjZ0dmZmZ25RdzQ1dEVrUFA5cVFaRnNBVzlvdmhKNmpU?=
 =?utf-8?B?Tk0xcmkxc0QrQ0VhVVBSOGFFNHZycldRTmdwR2MrYXZFd1VqRVVERWUxVllJ?=
 =?utf-8?B?UjZudmFIenB4cEJwMXlXM09iWXhWNnJ1SlVhbUo1N0M3L0RxSlI5V21Kd05j?=
 =?utf-8?B?eVVadG01TjhvUkZaeWZGRi9pektDRmZJcWpsYTM4Szk3RzdOOFR3SDZHNU5s?=
 =?utf-8?B?M3hUOGNpeXpWck1zZE9tRHR4U0ZzbmtXQ1VEQlBxNDQ5THlSeHhtR3lGMGFt?=
 =?utf-8?B?UkhudDZtTjJHaGVDRC9TWmV0ZDQ1UER0eTh6MXhzamZvNTJpa0lNWStqa21F?=
 =?utf-8?B?RGR6MkswRDZqMHB0RklaQmtYS1JodmwxOFhsd2F5bHlDTXZQVHVKbzFCUmJt?=
 =?utf-8?B?Q0pDYVZ5WlJwV2h1bVd2c0dLRzZvVU5qTnUvRXdRaWFWZ3RuL003LzYzbHFw?=
 =?utf-8?B?anovbHFwSGdrdnh4L0trb0ZoNzFPSnlvY09yTUFxa2haWGVtbTlLNWFZemtq?=
 =?utf-8?B?NXhrRXFkSU9IeXdBckhFYnh5Y0hONVVram1QZ2xOYTd4N2pDenNDSGlLY1U0?=
 =?utf-8?B?YmhTbldmcTVIQlJvajJ3TnFuTVVCYk1zeStUelRlU09GdklkVTlqRFZ2SURj?=
 =?utf-8?B?cmVJa0xlM1ZEaFZ3L1hyS1VUNFMzakd4S09WRTh3bVFvN2hSZ2dGc2hSZnYx?=
 =?utf-8?B?NFJaUmtZdisxaCthZkVmUjVPSTdYSVVzcUl4TEVMcGZpNW84Q3BmRUtPWnZq?=
 =?utf-8?B?Ni9EVnhPNDdVZ1FOWmFmb0VjYmRWbFBqblZSdE5EN3k0YkxMUlhQY3R5V0hG?=
 =?utf-8?B?bUx1T2EvTWkyTERUUHhwV2hOYjI1eHhpcFlYYW5JeXdmVi9peGpDMXJEM2p5?=
 =?utf-8?B?Um9vbFBuNXZrTHpJYlZaczBzb2NadFBveXZEYTJPa091V3QxN205YzdraGZZ?=
 =?utf-8?B?ODExSkNJVnIvMHhqaW1qeldxK3JjN29URHJObCt1eHFQVjdWRVA5M1VLV1dN?=
 =?utf-8?B?UTdmcEZ2a3Y4Y1dZY3VQejdBeGVaQk9jQXI2RTFmNWF1UFQ0Yy94VWd6MTJk?=
 =?utf-8?B?SXFRa3EzNnNDc3grMDBjUWtzSTRRcE5FRW9WOVQ1bmZSTHdnUWJtWmNhcG1V?=
 =?utf-8?B?VWVYVUFVUkxRV1dxSmhnRkJncWJQeUlhVEpOdWhNMkRISWovOGlpRnpGZjJn?=
 =?utf-8?B?L2Jjay9wdEV4a3RJeW9aenMxNm1uTDhCaE9RUnVqSmFRS0RkQVRuWGwwYXVl?=
 =?utf-8?B?SEl6RXUwWU5iSVNhWk9GUTlJaHRMNlh5QmhFZlFocFdXSk9Hc09ac2FaaU9I?=
 =?utf-8?B?alFvNU52TlozZ1psOXFpb0ZpdTdVSHA2OHF5T1JlT3ZZUzMwRldpSzJaTzJi?=
 =?utf-8?B?ZitEM1N5dVJYRkxxWW5iczlJa01HZHlJdEQwSTZRZXpwV25MTlZRQ2ZBPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5893.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?UmgzdVltSTNVb1hwd1NpSDBJSm56SnVVM2NESTlsVkJUZ2tJNFlxYkNqRWU5?=
 =?utf-8?B?Y3J3aVlmR1U1MjE3ZzJpVXdIYkFDMjk4eVAzS0FLcGhOcjlFeHZHc1lid1BW?=
 =?utf-8?B?VWh1U0dZL2JQK20rWk1JbS9XYnhoTGE3KzdmWkQ4ZkpQR3p2a3NxTmxSMGl3?=
 =?utf-8?B?UUVhbWkxd0drQ2pyZW03T25pRHg5dmMzTklrSHNJYnFodUhENUEzc01jYkto?=
 =?utf-8?B?cXZUcTFtZm5IZ3R6VDlXZFQzRmJ0VHZsSEN4SkR4ZjgxOEJVVFZwNWRLQ1l3?=
 =?utf-8?B?R1c4WUNuUWFIMmEwSFB1V25pZmpZajdkWVRnRVE1emFLSUVCcEtvRUNYNFNC?=
 =?utf-8?B?M3VqdEgrUEFBZWZPZ0w1cU1Vb0FCN0hta1FCdkdVTDJNY2k5VDN2cEs2VVgz?=
 =?utf-8?B?WU1KSmtVS1ErSHc5Vi9uNU5FNmgreWZGZ3RacWw2QnAwdnpVUHZiajN0Nkh0?=
 =?utf-8?B?bnp2cXFUZFdQaFJoMjVIOXNHR25UOVd4bHczU0pKSVdiWUNRSkJid3BDSVJR?=
 =?utf-8?B?ekJEdEVnS1JtclBZOFZPZmZTdjE0dTJPWTZYcWxlczBtUEJhR081VVZzQkh2?=
 =?utf-8?B?UzhUZEtrUzd4MzZzKzJoNUVDTnlHZmRrSllYaElEelh6dmR2WGV5L1VDZSt3?=
 =?utf-8?B?aU5BWlNBR0duUFBwUkJJdldFRW5TMUxuNkd2Zkw1RXZROW84UVh1c2M5SUZF?=
 =?utf-8?B?dVN4RmNia0FzSUFxdkxnUGNIVnluV0thQ011UHkzcEZQSE9pOThpclpTZ3lZ?=
 =?utf-8?B?UHFJU1lvZTNRdWM4aXV2Ym5icHBQSm9yTVRhWlozKytPZld5OXpVeUxRZlIx?=
 =?utf-8?B?aTF0WXFNcWhuOFg3WmQydmFUMHdOZ2x2R2cxc2xiMmt2QW5DbE4rczg1UjhG?=
 =?utf-8?B?Uzd4RHFoRlNXVHpIU3VqTWJHcit3K1NGNEFYbXI0YjZmYnRoRWFtZS84cnlv?=
 =?utf-8?B?bGIwSnhMZHAyQnJFczF3ekxISnBFNm1pRC9qMVNMeDZBTlRMbHpaYlhlRkpY?=
 =?utf-8?B?YUNndzVxUVA5RVJIR280ZURhMU9DeDB5VjlLdGV6WEF5WHBCd05VV3cvb0RW?=
 =?utf-8?B?UnZtQjRPYlJEVXp1Y2U1U2FHV25lMldEQ2srcVhZRVRqKzZZb2tsdmpsUllm?=
 =?utf-8?B?eU9iWDJ0SDhRUUt5L2tNd29WMngxVVpCTHFLNFBHNVBPSFBMemk4ZHVUVWRT?=
 =?utf-8?B?NFpyRjFvbG9ubHpJZlZPeS94bG1SZUdDTE9oYmxDOE5mQlFXUGdVbVZ4Q3JD?=
 =?utf-8?B?ZlhVR3ViaW1tUDNiOWZKeVNKNi84ZWZ4UGQvMkN6ZXJGRHAwViszWU02alVL?=
 =?utf-8?B?WlF1RVBYcFpCTmFJdHVQdzg1SHlSb1hNNG9xd2xDbUx6N1FxSjN5b0xxVUN3?=
 =?utf-8?B?ZHY2bjhVVzA0OUUzRUxNVnZ2OHcxeDhiZjl5TXU3VkplQjdPUnN4dUR0OTY2?=
 =?utf-8?B?RzM5UElmWk9FYzRPWWdXOXBkYUdVRDJIV2lWTFE4SVA5RlBWWDh3TmZnMDM5?=
 =?utf-8?B?SVA5UFV6VjloUkxnSmw0UDhGeEdnM0h3K0RFRWRBajlUUXJTWEplTHRReTlj?=
 =?utf-8?B?Z1Q5Y2F3UEFxL1puZWJqQWdRaTUyeU0yNUsvTFJ5VnhTbG5XS1RPQ01MaldV?=
 =?utf-8?B?TEpqTUh0RCtKNWdSUTFPSDdnQ3ZzSVVERHRCVWJOTlJSOE5zeUt6Ty9adXdY?=
 =?utf-8?B?WWducEFESTFmbkVlQUExT2I0OW1XVUxpQlVJR3FTdGJDTHFCVzc3RlFNYlMx?=
 =?utf-8?B?bzF5YmU5RnpWQlZiMW5QdXRJbDNXRm13UTc3T1NNdnlMRFp4cG15RkduTWQy?=
 =?utf-8?B?Q3FoaStJaVVCNUdScVhzQURtekFHWlk1cVkwKysrclRMZ0xlMHFzV2hSaHAr?=
 =?utf-8?B?N3NvZ2UrSFBzNmJsbU1XUDhneFhyaHBIMWE3ZXljRkJpSDE2NVRIRVdXOGtJ?=
 =?utf-8?B?NUFoalpWcmFXMmRRRU5yZW1mRlZZMjJSYmF4a0RSTzVBQzBRRTZaQzhNVU9G?=
 =?utf-8?B?TkxWU0p6ZHhZSHBpb1N5KzlzcGZ4MU51bkVPdGxFNHNJZjVnb3hWZU9sdGx2?=
 =?utf-8?B?eVR5WVBoS08xMGthYjN1NEJIdmlZemFGM3prdXpQN0VWb3c5K3hoMUdyZlFW?=
 =?utf-8?B?WEdkOEl2Z0MraFNWUGpLakJZY2h5cVc0V2s3SDY2VVEzL0d6YTdySk05V1pV?=
 =?utf-8?B?MXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Ic3FsuuR5aleUYq9wstybQrOOJLErVtlrOJ4gfhuQfwG+Trhj8cDhq4L7kiI1b7X+f07ihJSmA7nYgAMCnB2iqfAXih32QXx+5SfAaLTh0LfYZV4PpXVG4cxm9boZhSu1h6D9LLjF6cEwZHvZ3R4LK2omPtMY9WDoZ2O5ZeGiQ6JqSxIfAuL05+maDhJ5ymdWBWXt8pfhepkaxH126n9kwz5GGLxtktQKe7MVk7mbC3cus8r92Z0B9jDlbgjaR5uc0E8KXW+xlp1SgroozgLquo1lzj+4l2rG39XlCOqeD3Tk3XPHtjjW+zJ7lNWOLXjvGllbcdmYtlpvXFP1eQJN94L1rl8p9DTrnK0JqbQXaZL8H1UB4/4Dw1VneMgL1ynW8MDBo83IccxLYtnXX2VPb1kN/AjniaNULQwt79zlfoZZmqFwhF1JvQn/ddbGZcTtvjOuxU2yBKluGPwyLmNk01d/4uRr5KSFg+68OJCb0UIQz+/KaYtZtz/Y1Ed104q++3s4d2yDsyVABCSYkL54i3Bh7TU1LMl+y+l7W7nny5DCvhyyoR0ktdIWARDgQJci1PSxWPY+0FMeq2I1mv23ehmS5gvyZA++wwditF8V7U=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6e42604-3b81-45ce-22a6-08dc7be3e01e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5893.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2024 11:23:02.9650
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q3Ya3qoDr9BaAOo2PtTX6zc2bs2rIW01MTdpHQmpko6fSUKHRHF65YjduU05VmrX9tDOW4LkSzSKRvPjkhz70z+3+PSFQCqeHu+GC39uW0k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6572
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-24_04,2024-05-23_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 spamscore=0
 adultscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405240079
X-Proofpoint-GUID: LfLHK5A1zJZJDpYqDRjnIOO-JZnO2Apx
X-Proofpoint-ORIG-GUID: LfLHK5A1zJZJDpYqDRjnIOO-JZnO2Apx

On 02/02/2024 13:34, Joao Martins wrote:
> IOVA bitmap is a zerocopy scheme of recording dirty bits that iterate the
> different bitmap user pages at chunks of maximum of PAGE_SIZE/sizeof(struct
> page*) pages.
> 
> When the iterations are split up into 64G, the end of the range may be
> broken up in a way that's aligned with a non base page PTE size. This leads
> to only part of the huge page being recorded in the bitmap. 

Sigh, it seems I haven't fully fixed the problem rooted in this sentence with
IOMMU hugepages :/

When the end of the 64G page is dirty, this is OK, but the problem is when the
IOPTE isn't dirty: if we are dealing with iommu hugepages, imagine a non-dirty
2M page at the end of the current iteration window of 64G which is not fully
included in the 64G range; we test it non-dirty and finish read_and_clear(), and
move to the next iteration to check the next 64G; pin the next 2M of bitmap
pages and hit the second part of the hugepage, and we find that it's dirty. The
hugepage being dirty, we clear the dirty bit of the huge IOPTE *but* we just
record part of the hugepage in the bitmap. We end up checking twice the same
hugepage IOPTE but not recording the entire page as dirty -- and future calls to
GET_DIRTY_BITMAP don't check/send either because we cleared the IOPTE dirty bit.
So we end up not sending such data in the migration stream.

It's relatively rare to trigger this, but this is essentially the leftover bug here.

I have two alternate approaches to fix this; but this is
making me think whether I should just drop this fixed windowing scheme and make
it dynamic to avoid further bugs[*] i.e. pin on demand only when we have
something to dirty.

Here's the two different approaches to fix this bug:

1) Fix iova_bitmap_set_ahead such that the next iteration is able to skip fully
the hugepage we just dirty. Right now I increment the indexes, but the first bit
of the index might still be referencing the hugepage that crossed the iteration.
This is a relatively small cleanup, but the more important change is to have
IOMMU drivers skipping the second half if we are scanning in the middle of a
hugepage. This later part is what I find ugly considering the breaking of the
hugepage is self-induced due to the bitmap iteration in 64G chunks coupled with
the fact that we can't really guess the hugepage size until we walk the page table.

2) Alternatively: never pin anything at start and drop the iteration logic from
callers, and have iova_bitmap_set dynamically pin the range that contains the
bitmap region we want to set bits. It's simpler and the gist in iova_bitmap_set
would be something like this:

@@ -481,6 +487,25 @@ void iova_bitmap_set(struct iova_bitmap *bitmap,
                        mapped->pgshift) + mapped->pgoff * BITS_PER_BYTE;
        unsigned long last_page_idx = mapped->npages - 1;

+       if (unlikely(!mapped->npages ||
+               (iova < mapped->iova ||
+                (iova + length - 1) > (mapped->iova + mapped->length - 1)))) {
+
+               bitmap->mapped_base_index =
+                       iova_bitmap_offset_to_index(bitmap,
+                                                   iova - bitmap->iova);
+
+               iova_bitmap_put(bitmap);
+               if (iova_bitmap_get(bitmap))
+                       return;
+        }

[there are small changes around this to make it faster like cahing length in
mapped::length; but this is what makes the windowing dynamic]

The consequence of approach (2) is the added comparison(s) though I am not
measuring a meaningful difference with all-dirty cases. We would also need logic
to handle the theoretic >=64G hugepages with AMD iommu v1 pgtable and what I
introduced in set_ahead_length already does 99% of it. On the other hand non
dirty IOVA ranges become a tiny bit cheaper but the efficiency benefit is noise
compared to cost of walking the pagetable. The thing I don't like about approach
(1) is having iommu driver skip the partial[*] IOVA page.

With (2) we won't do the self-induced dirty subpages in a IOMMU hugepage due to
iterations, and neither of the two approaches leads to VMMs asking for a partial
range of what was mapped in the IOAS.

Any thoughts?

[*] Something important to note: GET_DIRTY_BITMAP ioctl can be called with a
subrange of the DMA range we mapped. I'll need to adjust the dirty-size in
callers of iommu_dirty_bitmap_record() in iommu drivers. Or introduce the
restriction which forces the user to issue separate ioas map calls in small chunks.

> Note that in
> pratice this is only a problem for IOMMU dirty tracking i.e. when the
> backing PTEs are in IOMMU hugepages and the bitmap is in base page
> granularity. So far this not something that affects VF dirty trackers
> (which reports and records at the same granularity).
> 
> To fix that, if there is a remainder of bits left to set in which the
> current IOVA bitmap doesn't cover, make a copy of the bitmap structure and
> iterate-and-set the rest of the bits remaining. Finally, when advancing the
> iterator, skip all the bits that were set ahead.
> 
> Reported-by: Avihai Horon <avihaih@nvidia.com>
> Fixes: f35f22cc760e ("iommu/vt-d: Access/Dirty bit support for SS domains")
> Fixes: 421a511a293f ("iommu/amd: Access/Dirty bit support in IOPTEs")
> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
> ---
>  drivers/iommu/iommufd/iova_bitmap.c | 43 +++++++++++++++++++++++++++++
>  1 file changed, 43 insertions(+)
> 
> diff --git a/drivers/iommu/iommufd/iova_bitmap.c b/drivers/iommu/iommufd/iova_bitmap.c
> index 9d42ab51a6bb..b370e8ee8866 100644
> --- a/drivers/iommu/iommufd/iova_bitmap.c
> +++ b/drivers/iommu/iommufd/iova_bitmap.c
> @@ -113,6 +113,9 @@ struct iova_bitmap {
>  
>  	/* length of the IOVA range for the whole bitmap */
>  	size_t length;
> +
> +	/* length of the IOVA range set ahead the pinned pages */
> +	unsigned long set_ahead_length;
>  };
>  
>  /*
> @@ -341,6 +344,32 @@ static bool iova_bitmap_done(struct iova_bitmap *bitmap)
>  	return bitmap->mapped_base_index >= bitmap->mapped_total_index;
>  }
>  
> +static int iova_bitmap_set_ahead(struct iova_bitmap *bitmap,
> +				 size_t set_ahead_length)
> +{
> +	int ret = 0;
> +
> +	while (set_ahead_length > 0 && !iova_bitmap_done(bitmap)) {
> +		unsigned long length = iova_bitmap_mapped_length(bitmap);
> +		unsigned long iova = iova_bitmap_mapped_iova(bitmap);
> +
> +		ret = iova_bitmap_get(bitmap);
> +		if (ret)
> +			break;
> +
> +		length = min(length, set_ahead_length);
> +		iova_bitmap_set(bitmap, iova, length);
> +
> +		set_ahead_length -= length;
> +		bitmap->mapped_base_index +=
> +			iova_bitmap_offset_to_index(bitmap, length - 1) + 1;
> +		iova_bitmap_put(bitmap);
> +	}
> +
> +	bitmap->set_ahead_length = 0;
> +	return ret;
> +}
> +
>  /*
>   * Advances to the next range, releases the current pinned
>   * pages and pins the next set of bitmap pages.
> @@ -357,6 +386,15 @@ static int iova_bitmap_advance(struct iova_bitmap *bitmap)
>  	if (iova_bitmap_done(bitmap))
>  		return 0;
>  
> +	/* Iterate, set and skip any bits requested for next iteration */
> +	if (bitmap->set_ahead_length) {
> +		int ret;
> +
> +		ret = iova_bitmap_set_ahead(bitmap, bitmap->set_ahead_length);
> +		if (ret)
> +			return ret;
> +	}
> +
>  	/* When advancing the index we pin the next set of bitmap pages */
>  	return iova_bitmap_get(bitmap);
>  }
> @@ -426,5 +464,10 @@ void iova_bitmap_set(struct iova_bitmap *bitmap,
>  		kunmap_local(kaddr);
>  		cur_bit += nbits;
>  	} while (cur_bit <= last_bit);
> +
> +	if (unlikely(cur_bit <= last_bit)) {
> +		bitmap->set_ahead_length =
> +			((last_bit - cur_bit + 1) << bitmap->mapped.pgshift);
> +	}
>  }
>  EXPORT_SYMBOL_NS_GPL(iova_bitmap_set, IOMMUFD);

