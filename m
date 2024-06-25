Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B27A1494A8
	for <iommu@lists.linux.dev>; Tue, 25 Jun 2024 11:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719313885; cv=fail; b=Ja23CX1uCkBuY752fJwnPJ29IXI1hsFskKiC+aYvmjJ8Fwy7Waz14ekCHbmhh4DZUHbZ/YdcyRUVLJJ+342bTaxvL+3QYnmMSgJ1K1MASuWbssMWjI935n5K6re1LExFf9lv1B5sUTTHIMRK9Om9T9u10oVU98/W+d50PESQPFs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719313885; c=relaxed/simple;
	bh=J8MK0jWdGv/bi+D5mk5mhrFMYTJw60YTpLbEplP6w+U=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=l67mzN0hbBW7Ge4/kpapOtkwAqwbGrS6nP0gHKf7CkQX4jllK9SkNBxN8a10h2DSn0hrk5a6riGHpAsSkp8apibLRDnleP1+jV/nb4c9wI48Gr6h3vfNsT2xwta2mg/XAt2J1NCnWIy/deQK55OQGD1KIUiUmeAy8gosI3HcvoM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WGs64PgJ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=h4kHiQ3U; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WGs64PgJ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="h4kHiQ3U"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45P7tW2l024962;
	Tue, 25 Jun 2024 11:11:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=frdqwKSe9QWReNfbo1BEJLjG81hqhJ2DSyX92TmFfRI=; b=
	WGs64PgJ0pbOn3e6cONF+58ht/WlZILhowqEjq3JGcMbhPU2pLGBNDRQrqCQBS73
	iqN/lzy4FDN74/WQRlF55zKL86VP6GDi+U/tr4/LmFbDyIUyCMfuvRlZdvRrpplY
	b2xFIboVK7Y2i9l7SNfCSbSelbiMj2ZGIvstvSReAfNizbHG64Bjnm+3qhgj/Tyi
	vH3Mqp7T8dtBwThPA+8fCj2+zev1UKoJ3/qCu38vAChlnHi5YyYvQukz6WoD8Y99
	prVH+QvQYYSU40bb3QjZiI0xIymp1XPKFFeoRYkqeYj4jXKbt4gcjTFTlywrTfOJ
	v1F3gwT35waPT76Dt6Ybyg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ywn708d4f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Jun 2024 11:11:14 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45P9GdaW037265;
	Tue, 25 Jun 2024 11:11:14 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2041.outbound.protection.outlook.com [104.47.55.41])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ywn27t3x0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Jun 2024 11:11:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N68nsU4SgTzs+41Wb5X74PHpHmnim1xBqvTKM0u9yAgjxecot8xs6PoavpI5fBR9aiJe+yWih4wJKjbLkYEAWW6NkUvHmIXnt/46tches01mWy3nD0uxs8F+Blq2mbOjxYK6/0l9WuXhZzCDgjnqTe54TUUC2Migk9mfj3NKD0FKhYNawQRi2gULGFJKLPQx4IBV7Ta1I/FmrPE6vqIkQYrdkJ+B2pCCXwmvvXIILHVCXXjT5fKU/nbfGTJNecVqW6wfP/kZ6EHCDnu9vdbzGKLumaUdAMKoF2hUX5wIN4gBrMi5y4Gp4rEHa/FwW1McsWABEAX2vP4JIn5lfl0IEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=frdqwKSe9QWReNfbo1BEJLjG81hqhJ2DSyX92TmFfRI=;
 b=dosziYIoPMnqs4qJuwpJTeL5qm5OjSHp6TuLVkgb0GXRzfN3/ml7RY5BZqeIkgFnkGo1tWM+al252x+P6NQN7B5uAdYxM67h3gfOqceV/o9zmFI1AXQU16nl7q7FVdTDQKOX9G0Q3p3W1jvQzlHS2ya5e08aWm+O9M3Njgh0NqEWb+ue/8vR9DA8ChCKvC5mvV/K12/tmafQJxIGe/TvUBWM9gSbQ+sbeRCyu4w1QeXHA6jJtga2FgzgPNgAy9A0l9cmEoDZ6pjj8mou8wjAwYMDYvklcVYFtNAXDWnIfpH7/9hMxKJL5tm8Q17djitMFzkmy6Vf2L/l4xko0xU+ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=frdqwKSe9QWReNfbo1BEJLjG81hqhJ2DSyX92TmFfRI=;
 b=h4kHiQ3U/FTiSUZRxvDTxq1RCWREpHaV/dS6euwgAlFw/5hDs6Fhjq+9k0LVv4KgZ+kbkPi3V005SHzc0PyD/bumoGCvM4vA4eiFi1DNkGkeDnXBbIToj2EZ/FuAlTyeQ/AbQpFvJ6I2ABa5bBqgTkb6suwwp/oOXDEbqP1T7H8=
Received: from MW5PR10MB5876.namprd10.prod.outlook.com (2603:10b6:303:190::16)
 by BN0PR10MB4840.namprd10.prod.outlook.com (2603:10b6:408:12b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.30; Tue, 25 Jun
 2024 11:11:11 +0000
Received: from MW5PR10MB5876.namprd10.prod.outlook.com
 ([fe80::4e4b:84a9:89a9:c43a]) by MW5PR10MB5876.namprd10.prod.outlook.com
 ([fe80::4e4b:84a9:89a9:c43a%6]) with mapi id 15.20.7698.020; Tue, 25 Jun 2024
 11:11:11 +0000
Message-ID: <2d52d4ed-c585-466f-b428-c7ec24713f7d@oracle.com>
Date: Tue, 25 Jun 2024 12:11:04 +0100
Subject: Re: [PATCH v1 04/10] iommufd/selftest: Do not record head iova to
 better match iommu drivers
To: "Tian, Kevin" <kevin.tian@intel.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>
Cc: Jason Gunthorpe <jgg@nvidia.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Lu Baolu <baolu.lu@linux.intel.com>, Avihai Horon <avihaih@nvidia.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
References: <20240621184254.45477-1-joao.m.martins@oracle.com>
 <20240621184254.45477-5-joao.m.martins@oracle.com>
 <BN9PR11MB5276AB80727CF5521D5F20768CD52@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Language: en-US
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <BN9PR11MB5276AB80727CF5521D5F20768CD52@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PAZP264CA0166.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:236::6) To MW5PR10MB5876.namprd10.prod.outlook.com
 (2603:10b6:303:190::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR10MB5876:EE_|BN0PR10MB4840:EE_
X-MS-Office365-Filtering-Correlation-Id: 0decc984-229b-4d39-6d1d-08dc95078547
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|376011|1800799021;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?Vko4TUhOSlNhanZsRmYxS05qMW9SM01ibDhkeDNkbkMzN3hOTzhnc0plVDhS?=
 =?utf-8?B?MlRmM1hCV3E1bWZ1c0ZKb28wOEFERm5HTUZHM3o4UGttamxvUUZWVFlBOHVv?=
 =?utf-8?B?cVNxWUR6THB6cmdKc3A3MTU1a3ZlbHp4SFU3MzFNTUExd0JzRlFZWng3d01q?=
 =?utf-8?B?c2ZOSW8yNXJ0a1hjWHEzbG82eUVEbVBDNVdIdFBBVHJoeVdNNnN2UkZ5c1lK?=
 =?utf-8?B?UlJUeTN1TVd1MWo5TWNVRU5OOXdaM3dPQk9VS2RNYUh5WlRnUFM4dzZZNUZs?=
 =?utf-8?B?Unp5ZENSMDdnTE1DRm1JRjZsN0huT1BTbXFWbUxPODQ0R2dwczF0UXZ1eDJG?=
 =?utf-8?B?Y1N0UmZWb1pyeUp3RDFTaG8wUGtSVUpraXMzc3VqR083NXpQemYyWlZ6OFVt?=
 =?utf-8?B?dkF2dk5acFovNk5xMVBIQTVsYTVtam5LSXZiZ3N4bjAzcm40M1AvTG1JZXAw?=
 =?utf-8?B?R2hROE51dncwTzBZWEN6U3h0aGJBNlZONEFRTUMzNENXcWJCY2VlblZsdXVV?=
 =?utf-8?B?SjBUdzZNZkhSMUJ4SGowcUoxMDIzQzdibFk1ZzBrSnlsSVc2TzVoV1U2emZJ?=
 =?utf-8?B?bUJHY042UVVMaHdPQWpJdDlOdms2SnVGVnpTcE5zMmhyVXRKZjJZUytqVE1F?=
 =?utf-8?B?SmFhUDd4Vk9YSkhlZzJGSVFZcVZCQjFDM3kyNElCWkpLZEFleDhpNlhZR2pU?=
 =?utf-8?B?YnpjRmJVaXc4ODV1Qzg2akt6V3hwSzZYUVR0UGdnYnNCZEUvejc5bHNEVUlB?=
 =?utf-8?B?R3hMZm5MZHFtYmhwR2dzUzZjbDhjRTZ0aXJxUS90OTNKeHdIMy9YNiswaDVp?=
 =?utf-8?B?ek1RbVNRTEU5alRNU2ZmLzJ5Z29NMng2UkdNOFNtZkJvMm8rQmplbS91bURt?=
 =?utf-8?B?VDZzUHY4Q3p4ZVdBV3d1ZloveXlBYXZqeU96UnMxRkthaEExQWo2aWFNSUsz?=
 =?utf-8?B?bzQ2NmRCRG1TVEYvLzlwdURIb093OEV1MkY1UmtvVlhQMWIzT21GV2prbm9W?=
 =?utf-8?B?Z0Z5RUM0aWE4R2xDRHppTGdDVEROWVlDRWhNazN2ZndraFhOWnJmcTFyUVAw?=
 =?utf-8?B?V2QvT2tIbVdtYWgrdG0vOWJyNjZXdS9zaWcwUW1LK08xaTZNZUczeTlJUGZB?=
 =?utf-8?B?M1NyM3JpVkFSSjdZZWwvdk03dVlCMVowQ3dIdllLWFkrdE1ZN2lObGVWM3J6?=
 =?utf-8?B?TzhzbzNxb2dKZ01aakhUN0tFa3BSdkJFK0Z5RlpFUkkzZmczZVBhZDIrd3pX?=
 =?utf-8?B?ZmdoUGRXb2JmZFBQTEJqdVVrcFIzSklYanZ6UCtmaHRzKzNvVGpKN05NRGRR?=
 =?utf-8?B?Y1RmTjFqNUFwaTRKWis2TDdlcVJqaDVqZEtmVXN0ejZFdTY5WUNPSS9vNmxJ?=
 =?utf-8?B?L3RkN3BsVkRFVldiRGwzU0RFNmxNUk53MmJ2ay9saTlza1dBc05pUnltWSsr?=
 =?utf-8?B?WEphaU54Z0xxNmduRzl0eFRzS1NOYUlZdExITmd1V0pBRm15VU1weGtGTnVt?=
 =?utf-8?B?SER0cVJsUjJHQ0daemVrTytHZlZuZC90OUs0K2VocXFILzlPenRZTjlKSTkw?=
 =?utf-8?B?NkhsVVYyYmlibzNFaDdmYlFEMFJpRXV5MEV0c3J6V2hXZ3EzVXRWUDBjazdl?=
 =?utf-8?B?UUczTmtjSmJhT1lSSUF6T3RmTmNlNlIxeHJ5bVlLbitIMitqT0NXVmxXZ3dh?=
 =?utf-8?B?blEyNXlhTmVNTkZNRVE3WDZMYWhqZWJUYXdjVlVFbWVTY1ZqRmRNVFF2dGVJ?=
 =?utf-8?Q?/BzaIGAdmPHNvz8Bod9s59siWfaR/SpOELNPLJM?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR10MB5876.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NU92bFVxYjBGWDdEeTNTZ2RHWWpMNTdDZ3l5Z0pJS0ZzaWl2NEJZZzdGWDZa?=
 =?utf-8?B?WHNlYUdqQnUzeDV2SjZWWHFCWHFucFcyZWk0Z1ZURGhrT1prT1B2THFmMkpm?=
 =?utf-8?B?QVF4L0hxNnBFRnBubU9OZnJIQW96VUxQTXdvbE1rQUpZWVNVV1lQWkE0SlRV?=
 =?utf-8?B?TzV1Y0NYWW5lWlZSNyt4RC8yQ0tIeXdHVDJTbE93a0FHZzdIL2s5ZUZrdHBI?=
 =?utf-8?B?ZnhOUEhRQXN6NEhhWW5NTWMwM1JKWkVWYlo2SnZPUmpkeUxrTVEzWEIrRXZj?=
 =?utf-8?B?MU4weEk1SjM2VWZJc21BREU5cEtRemV5aWpkampYdDdIblVlVHVMSzJQUnB4?=
 =?utf-8?B?dGpVZzJMWk5NQlI5em1ObUpPekF4QjA3UUJjZGMrSGtSUmxRUm5ZY2p4RlBL?=
 =?utf-8?B?dVRwdTRZMVpoeHJDV1c1b2J6RlNsNXJxaUhzR09yWkZad2ppYzZ2MEtGNFov?=
 =?utf-8?B?VmVOQmJET3BWMEdGSC8wNVR2bE1nakNMeWRjSVNTZXpxRTgvaFBYV1dEMzFO?=
 =?utf-8?B?QlIwdmkwdFpPaFZZNlkyZWdXdHIrZE9MRDd3ZFpvVHM4MnNGK1g4YkNZQmtY?=
 =?utf-8?B?bDBwZnNLRUQwRmJhQS94U3pObmVMVS9aakVFZDBnK3k1c1FzUG9UY3VZN0ty?=
 =?utf-8?B?SlNwQzdMbnJsaDVLZ09RMUV5UllXMzRwZWRaSXdKZkNUT2R5a0FGNittSnJs?=
 =?utf-8?B?VXY4M0xleWVSSTNYMm1aeWdHdWZJYmJsa2xQZ3RZQ3FzYzlBbGZDZzFpTG9Q?=
 =?utf-8?B?dnBjdFJUa0grK0NzYStFN2xNTzY3OUE0SDExM2ltbHREOGhjSzBNNWdnUlZ5?=
 =?utf-8?B?K3VYczhGVTRuV0tSVjMxMTQwcVQxZWgxSDl2MGdVZVVXUmREeFpNY2t3VzFI?=
 =?utf-8?B?M0w3d1gzdjNSZUx5dFloTGphWFE5cGNFb092RWZmMVFMQlpxWEdUUzdENVpV?=
 =?utf-8?B?em5tNU8zQ1hzQVAzbG9WMytCRkQySENhYXd2bUROZ1dGS1NlOHVRZ21xM0lU?=
 =?utf-8?B?QjRTRDVyWDNMTGlGZHpaNnhCTGVFdW1TNlNybzd6ZU44RnAxY3R5bTUzYWNL?=
 =?utf-8?B?NXpHbGJMbEFKWEYyN09RMHcvRnJUUzFkZnlNSkR1NjJCSnJUWnA0aUM1Z1FH?=
 =?utf-8?B?OGVWaXZ0a1NHcUpsUFpNRWZoZVdiVDJoaURUR29xRE01RDdzWUtEV25USnNB?=
 =?utf-8?B?cTNxeDdRZW9QMEFCUGZ1VFJjc1Y2NVluVFRGbEs3K1YrejVHSkkzWGxzK3Z4?=
 =?utf-8?B?WWJxR0VyMkg2QWxMWGlJMjdlWG4wbC9kWE9qRWZCRHhlN2ZKdTJuUW1ob0ls?=
 =?utf-8?B?b3hDSXpUYkJmZ2luQmpRcFRtczB3NzQwUFQvd05mTTVhWXFKelVnbkV0UXlN?=
 =?utf-8?B?cjBpV3VReWFhdHNhRC9LYU1HOTBSVWE0dFEyZ3FMemJVaUZYblBsU0xQdmhE?=
 =?utf-8?B?elY3WksxRThzc29kMHFTdEtOYWFROE9JVmM0c0ZwNFNZbEZCemVkZWVGZVNl?=
 =?utf-8?B?ejY0NUhVT1loN2ZTZVBHbGJCSlpFQ2RiaFQzVDYzd2MwL3J4VVBtV09wWXg0?=
 =?utf-8?B?VlFSVW9WVER2blNvd2Z2WFBEZ2NUVDNVTGdIQmdLMldNUU1xeHVjREE0Y0J4?=
 =?utf-8?B?Z1A0dk00NHovYXpQZmRpbTljNlkrSjc1UVRlMFFRK0NhL3RjN3h1cWgxM0lG?=
 =?utf-8?B?OTRvaVBOQTNNNVQzS0JWR01jQlVKUzhxL0tOTlBZVFdQU1hCRkZySTdOeU1L?=
 =?utf-8?B?c0V1YWFkOUp6QlNKMThTdURRUHJkY2tWRlc1Tmc1bkNQdFBIYnBGNGdISEtq?=
 =?utf-8?B?dk9JaS9KdkVaZkI2QkIxYmR0dHlPOC9RYTc5d2h3NEN0OWtnamlVSUxCcnp4?=
 =?utf-8?B?QzhKNDhsbjBzZDREQzEvekNRNFFvYmxyY2xvY3BsK3llOUtpQ0NDc1g3OWFz?=
 =?utf-8?B?Wnlsc2hObDEwYmJPOUN5eHIyc1pLUWZnZDlkLzNTVFhPMitEaElvVXNPWHV6?=
 =?utf-8?B?VGlxSkRnSnJmcXlJRk53a0VUUGlRa3UxMU5FTFErSlFuRyt3U2hWSmxVWHIw?=
 =?utf-8?B?OHgrU013MWFSclplYXFTNTVsZGZwZzBQemkzWThUZGR0ZE90bHdabkNXRFFX?=
 =?utf-8?B?N2p0QUpwWHJvRU1wbVR0RnNWc1NFaWw2T0FjZmlTSktuWHBBcGpkSldTeWN5?=
 =?utf-8?B?V1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	i3MzWCR3MMas3CLObZ4++sL7DoztNr4Ew+URz/BB6WpBF9v5KetlFWQ86JKA/pLoKaHdWzmqHM5PxXcVrMi/QG8uVqOxed9hnV63vKDe9G1QwOQpkvlGURK2xnPC7CLVlNDlIyXTbWbKD6sNjMb450/PuSJ8kyCky9+tkpbtb07gnxORcOH6tIe+9vDZGBmcWorReb1kcgBupThAQ5HMV0JaeNi+1NTZncA5uSy4lX8QGKK169NUg2tHubkFXYHE1c7MmyQD775reALXE4syAUaya/4Y04Tye+pFUhWczkjrtMc8t8MtICMF5ui1yLy4aVmhgj6MRf87ebEmZ7p0UsP2FbPihLZu7RBzjxC0QkTSZ+bmsVUJPUdQaHCLkd86WuFtcsFmx9+iRwUSiFBa6cs5vq3SuZ1uBdyiksxaMD0SYFpzj89MUNbF2RA/imL1X4Mf8y0l55EGmlUKa5/J2gepktzf5G18my2yK9MqwrOPgCpiWA9+OdirxmPJfIdr0B8VRXoB2tcRs12z1JV7yAg6ZlPK3gb6Gl+eIQuRpkFsHVMPiMxl5AZcXQSfX3D5jWib3ZQj8W3fUe0gpa3lcRzoWSIxp0MFp6yhdKmqCAE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0decc984-229b-4d39-6d1d-08dc95078547
X-MS-Exchange-CrossTenant-AuthSource: MW5PR10MB5876.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2024 11:11:11.5543
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lsI37qKlsoc62ysgpN/naPzSbT9ijrnfxYv4RGf0WBAXYYpSUR3NlfTJSrFojrH/pldbNt0caob9YRVHFcie1HBh93fa2AbIK9frd5KU6j4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4840
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-25_06,2024-06-25_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2406250082
X-Proofpoint-ORIG-GUID: w6QCxMhBAbrdpH3elnIyVGgUqa1qlIdN
X-Proofpoint-GUID: w6QCxMhBAbrdpH3elnIyVGgUqa1qlIdN

On 25/06/2024 04:35, Tian, Kevin wrote:
>> From: Joao Martins <joao.m.martins@oracle.com>
>> Sent: Saturday, June 22, 2024 2:43 AM
>>
>> Do not se a hugepage-aligned IOVA for incrementing an IOVA, to better
> 
> what does 'se' mean?
> 
Meant as 'set'

>> match
>> current IOMMU driver implementations. Keep it for IOPTEs where it clears
>> all dirty bits for a hugepage even if it is starting from a partial range.
> 
> there are three 'it' in this sentence. Not sure the exact object being
> referred each.
> 
I have the bad habit of using 'we' when I mean the imperative form, so usually I
sed manually each we to 'it'.

'it' in this paragraph broadly refers to the logic of the mock read_and_clear()
i.e. rephrasing would be, keep the logic of clearing all IOPTE Dirty bits for a
while hugepage, even if the range being dirtied starts from part of the hugepage.

Well, now that I said out loud I guess the third 'it' was a bit misleading where
I should have used 'the IOVA range'.
