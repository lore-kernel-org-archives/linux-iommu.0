Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13EAD9475
	for <iommu@lists.linux.dev>; Fri, 24 May 2024 11:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716550272; cv=fail; b=urd0imQNGoYzOhx0IvBY414owQ/UuR0AeLWwWs8Fjv12vzumE6yGHUINm33WF/i3ZLui/fj7Kfwh+Bk218Bwa5lxwocEGohE/PjjfObfjBSqJ3WbzcMSjZDfRw/tDOG6Lg2zVkh4X9AL5+aVJRrEXj4blUzn4bRcmq760iKiw48=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716550272; c=relaxed/simple;
	bh=F8qlqV0gn3k3wfbQ0LwexP+He4aizy2lJY4LIXUuT1M=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JvPxOXfHWcvCXv1KNqH3VH4liN/T4brc9wamH7sL31QRPpJnXAajJ2YUXKnfQPdg0ftf0fM9U9PBCyNi9BpqNkVzxX47vLcyYbkpESsGFPxiAHHkUdiGlUTqheak86uf5lhsXYgw3srnTLYHAz6Ys2arEr39vhkXiifMjWNA0W8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hISZvonz; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=uzDs5Yjv; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hISZvonz";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="uzDs5Yjv"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44O8wgA4030338;
	Fri, 24 May 2024 11:30:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=ZR83/XrwWD4YAGgtD/Bo7d6LaAM9uhvXTqy6Ly7oPDY=;
 b=hISZvonz8FeO4suePvomGadM6n9mpUYt2MjLencPYUrAJlPuU50u5gOa6FIwTFTc0BVZ
 gyKDNLnnMnI2ObJV6T2WKEg17mAJAfcoHkgXE0cLFy0cjAvg+OJmJBHaVL61CT4NO0Ry
 b+HnYdYgHVrG/5c1o336tBk9g/nKD6M3PL2XWdH8DWwnHo/3FoiBbfL4PaB5WzS4yVmF
 ggx+mOIVhz1kAiiADF4cCh90TYyoZqz3NHMq8UCfoh/wA75duueUpEKq6Yis0WnDpIBi
 9oNbaNrk18I0XkcvWo1FlwlqCuNWnwkXOVRuTfnlpAYKnB+aHUMOy1U90+W9aE7tJPyR bA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y6k46cafy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 May 2024 11:30:39 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44OA11tE019534;
	Fri, 24 May 2024 11:30:38 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3y6jsbu1ms-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 May 2024 11:30:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lCNDlo8caWvJSq2GiW9fuyFBbhFacA12Vz8b5HYsf81p9VqRp0r0hekjfXqqFP7HdzhpY75wUdokiN8hijyjYhgFEhbGfIfwIM8TUV9ZUtIbRkx9h7Uev/ZsyN3IhEe39ruCZKds4K1vt+GDdeQSFE63BHFhgMuGSfynGNpWKAFRHXfgTpnhGX6CvMqw/2m2h6FDgiHhCRqFgst5WyCHuqPqKpcwFtZkiPIvY3KucbmWjovBjlznTU0EewnW9K1Y8qCFXmf94LgQo9k7GGcMCsoRBTUuQAPwsRQw6Y0Nr8oZF9sOMeY2xY1u576S7wKR+xsRY+ywm4YtzjYvbZL1hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZR83/XrwWD4YAGgtD/Bo7d6LaAM9uhvXTqy6Ly7oPDY=;
 b=PJUikhLY0FAGg/rOoqwN+ViLvDixpFHri3jgSBRzJkNu2hNI+t70UqiIWuKC6DxZ8Q4RG1JUI+1AKSD921XwDa6MjXn3NsaqKxUX9EEskRYsMUM6d8Ad/44AP/LpNhtNZBq0q7wUS0IHg6P9DrEoF37MOek09jVtB+n1NjCyBVDYpMMkWouVt/ktrrWB2EsfdO6coZwwqSSTFps9nJFKu22EahOl7pTf1A5QXYPiOzWZ7X5JufNegFoqMV2Q4FmRJbUmu0SoifxMD9IxVqvf05zNzaArCN34+wlh840CysOYdqMeyvtuyEYyAQZk+xrjZ/08EZj7F7djFzLpakFnaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZR83/XrwWD4YAGgtD/Bo7d6LaAM9uhvXTqy6Ly7oPDY=;
 b=uzDs5Yjve59uyL265Iei9pkT/WiE5qfdIrmO391nXafOBQkAgB121uKLtN0KyS8rI5BqQqnr/3XInSerl0NB8I+UedwMN8L72vca5KDj79DAQb79Uq5/Rk/UdJglf0N1jGcZC6QBETAAn/Yy8e6HT1Bllhf/N7HBFYfwCizstkM=
Received: from PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11)
 by IA0PR10MB6699.namprd10.prod.outlook.com (2603:10b6:208:441::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Fri, 24 May
 2024 11:30:35 +0000
Received: from PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53]) by PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53%4]) with mapi id 15.20.7611.016; Fri, 24 May 2024
 11:30:35 +0000
Message-ID: <2d949dfb-ea40-418b-81f2-f2711b796d4a@oracle.com>
Date: Fri, 24 May 2024 12:30:22 +0100
Subject: Re: [PATCH v3 2/4] iommu/io-pgtable-arm: Add read_and_clear_dirty()
 support
To: "Tian, Kevin" <kevin.tian@intel.com>, Jason Gunthorpe <jgg@nvidia.com>
Cc: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "joro@8bytes.org" <joro@8bytes.org>,
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
 <4618c24f-aaa8-453f-aa9d-67a864e1c93b@oracle.com>
 <20240522165640.GD20229@nvidia.com>
 <cb2ab7ee-9e31-468d-85cb-71e70d7a7e0e@oracle.com>
 <20240522175053.GF20229@nvidia.com>
 <BN9PR11MB527660CCD250C176DF86F9EB8CF42@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Language: en-US
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <BN9PR11MB527660CCD250C176DF86F9EB8CF42@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR04CA0035.eurprd04.prod.outlook.com
 (2603:10a6:208:122::48) To PH0PR10MB5893.namprd10.prod.outlook.com
 (2603:10b6:510:149::11)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5893:EE_|IA0PR10MB6699:EE_
X-MS-Office365-Filtering-Correlation-Id: c335fc69-5f52-4334-86e9-08dc7be4edd4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|7416005|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?Qi85S1E2Z3Nsb3dxR3dCazh5aXhiYUxhUU1IKzhacUwwaTlKcnQyaC9Ca0lY?=
 =?utf-8?B?UmV3V3BycWlocURzcFpxTkMzMWlVTGprNUh2cUhFSTA1TENGRTAydzhvVXBH?=
 =?utf-8?B?NVIrN2VHaWdDNEFtc1RCMDN1MTlVdGNlaHVlRXJaWjNpVTFFZFgvVjdlaU45?=
 =?utf-8?B?aGs0b1NEdHk4TGovdm9wY0tQaitDTzF2T3RBTzVrYWpuMGV6a0l4OVhWcWJk?=
 =?utf-8?B?R25FNUF0L2JLQ09TcW1wT2tJRlRsdDV3Ukk5TmVYRWJtR2RxSVBFdGUvNHBN?=
 =?utf-8?B?ZktMVUZlZmh3WVNHKzhpOUZuT2Y2Y3laSkZOenFPYnk1WUdBNDRXS3VrRGlV?=
 =?utf-8?B?d0FJNWxNTFRDa3drNkJXQk1hNHN3RjA2NTQzWWtnS1laRmlkeEFpdTdPa20w?=
 =?utf-8?B?ZEFVSEpBUzFvSjBsajdlU2toZEhkdG5kaEtjeHA2QW1QNm9sRGVobjRpRTJ1?=
 =?utf-8?B?aU1GN1A3eW9Kdk5FYU9DcmUxanJpMitUS0ZXNmdUV2hsV3ZQUFFsWjk4NExw?=
 =?utf-8?B?ZWpsTXphaUU1Q3pMUzA4K1VpR1JiNG04amM0b0NDOG11QzZINFpzZUFDQlpE?=
 =?utf-8?B?clM4VXdtWlN6K0xWeUZEWXRWWWZJaEtKTVM4Z3lEMm9SOGdpRUo1YnhoMnJk?=
 =?utf-8?B?eE1DczByTmNDMk96Z3NrdUoxMzFjaWJCMk95VGZRWnBKL0dFdFlxZ050anp5?=
 =?utf-8?B?OUxQSi9YaWRiTm5LUGdTQTJlaFVnMGMvMHU2WmdwVXIrWXRzT01pNDZzUHdV?=
 =?utf-8?B?ZkpsQ1lBSTlnbmFNaXliOVZXazhmd2lBTXBqTmtPNTNYYmlJSFFSMUdXTzdR?=
 =?utf-8?B?aXcxM1NnM0FaL3VmNXFiWlV5OTVDM2lHYXpHUVc1cjJ6Z0loYWhHMjVoSVds?=
 =?utf-8?B?N205N3lEaU1lTkwwUUE0L09qT1d0QWptLzJVUEtreDhIYitWdnpEYU9TbW02?=
 =?utf-8?B?cHRpdnNJTUpoSjhTbjhnYUJEdXBoQ3h5QTBTUG9TNjBSWWkwcFd6QWtwTkJq?=
 =?utf-8?B?aXRKYmcvMDYrSU9xa1lKSGh4TTAzOUlMaHNnaWdsMUptQWxiNzlNemMwYmNw?=
 =?utf-8?B?NStEZVhvUkdaTTh5Y05JamZyYUl5am5FWERIZmJKUk5LUm9PVUhiNVZNSW9M?=
 =?utf-8?B?eGtXTjExZ0h0NWhGL3lsVWVzSHBnSzI3SEdZRWJUZzlJR1lOTWdGVG45OUx3?=
 =?utf-8?B?WjJwbWlTVUhnajBZRUNNUUFwYkFxMEZaTFJRbmNDc3J4ZnVzd000b214RUxK?=
 =?utf-8?B?Y3gxRnluTkptdGRndjJtV2FmYnRqS1FwV3Ura1ZuczRiNndOa1pmcFJCZkxp?=
 =?utf-8?B?dk9uUlphcjVpalpCbU1vc1BWckZ3Qnp2TzZ6clNyRnJWdW1lM3JnZmRCdUhS?=
 =?utf-8?B?d3FkUkVhVnh3QlQxbERYOFBrR00xeVljRVVhYlhyamtTVGlPNXF0T1paTTdJ?=
 =?utf-8?B?T0F3V3hXcGNFREFUWHlZYjRLcWF2eXMzSnRoRzZmK3dSdU0vTEdBc21hcjdG?=
 =?utf-8?B?dXNRYTU2OG5IUFVhRlRHb0VUU2ZRUkJSNFg3RDUwRVdUVmVIU09JdDA1WmpT?=
 =?utf-8?B?bVBwWFNOT2lVVURwbjM5M00zMDd4MDBqaHdRaHVHYTcrLzdYcjVRbXZSZ05W?=
 =?utf-8?B?U1IybzNjM2tEN3hZd1NaeGQrUXgrUHQrR0krNVR0TklrUjhsRkRjdlNHb1NJ?=
 =?utf-8?B?Y0VjcitSaysxUVh6TCtmQUg0bzRQcjhuUXlOeVBPKzFwZks4TFZNN2JBPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5893.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NmhDQnhDQUFmVWFnMkxIU3hOVEY5V2d2VVd2NmI4TFdkam1mRDlvUThtNWhN?=
 =?utf-8?B?MnAwR2M0cG1oK1dWeEVPWGpyb24wQnpGYzZMQ2F6eDNmam5IQURReHZWMk92?=
 =?utf-8?B?UEJYL3NpV0xPdWFhcGlrM25oRlhMT0hOU0MxSW5qbXBFbHgyTm41Q1pDWmhJ?=
 =?utf-8?B?ZUJGeUo1T1U5Y3RacExSZXRzM1pwakp0Zi9Sa1lCQXR3UktTV0lyS1Qwemoz?=
 =?utf-8?B?SWdCanpCSnNCS04yNjhFUGE1RXZ2c0loY2p2d1M0TFJGSmxFYW5rbHRNbGFX?=
 =?utf-8?B?OVB1QUxkU1ZkU3dPTEkyQzhNRjc1UWhON1RFQ0NlYitzRGo5WVZzaWhGSTVE?=
 =?utf-8?B?NHU3OGVyYVB4YTFLUnI0UGRmQ29hZ3hKNzJIdGdieGV2RzVWd2JBaU9ENU5n?=
 =?utf-8?B?M084V3MvSUdZQVlJMDlEU1BsR0JaQUZENmdFN0tibFkzNy9RSGNMNUQ3YVVT?=
 =?utf-8?B?Um1UU3hVVTRXeTlsK2VGd0QzdFlRaHlQT1VMVno5Nm1ZT0l2a2t3Nmt0S3Vl?=
 =?utf-8?B?SWlVeWtIYUlQRGpSQytYaUJ1Rzlhdkl4WXVhZmt5MG5lY2Z3Qm9iMGJ3OWpU?=
 =?utf-8?B?RmphUzNJQTBBaHlWeHhyK0tQT0xKRjdSR01TYU5uQ0V2QzFqWURTTTdENzlF?=
 =?utf-8?B?TjJZUU1oc0l0dDRzQmZrdzBMTmNpNWxmdGZ3YjhkQkhobDA5Z25od1dDVThh?=
 =?utf-8?B?dzFZemhUWHA3TFhOUVp5VGlsQTlDYmJuM1VSN0FGR1BGZ1JGVzZJMDlwbHhj?=
 =?utf-8?B?eUtiR1kzMHcwQ2RMK0lZVkxyTzh6SkgyVmQ0aXdDNTREUUJKQXdZRnVoTTEv?=
 =?utf-8?B?cDE2cHVLOGR1VFRSN29PbEhKak5ZSXdEemVCMHFjRjVWeDdYYjArZjJlR2g0?=
 =?utf-8?B?eDRTc2FHRUFoM2t1WkN4bmNZYXVXMnZpZFJoRURHUkJGc1ZRUG1tRzUxNGcz?=
 =?utf-8?B?UGdKeGFnbEE4dm11TFVIeDl1Mlk1RHhjNi9jeDY3anlURVk4UjJvN3Z5OFNj?=
 =?utf-8?B?UVY0Rm9iM2VYc3MwcGpEVTN4SlU2NmlzTElpb3VtN1dMVlBTeC9ZMmE3dTd0?=
 =?utf-8?B?UGJDa29LaHpSNVpVYjRveHovci9NblJFSHJEaGhvdU5pdTd1cTBvR1BXTHVH?=
 =?utf-8?B?SFlaYVh6azc1cWk3c0RHLzZLcXNzTERyRXk5Z3RYQlNvdFdwVk5DNDE3aUNs?=
 =?utf-8?B?UGdCdWhRNFRObTI1RTcvb3FCeWx4TzhKRXJXUkZ4R0p3R2crNFZhanZXV1o1?=
 =?utf-8?B?MitHb2UyaXhLQytQcDhTWmRMUHF6SURPS2VXVGV1L01acUdodTFtdVJDKzBi?=
 =?utf-8?B?R1NtbEcxR2VkdzloQnZDSjcrV3FJU1orWFg4azFRaks0aXoybTFtY2FCVksz?=
 =?utf-8?B?S3ZRSEMvcGJnMlJsMndMSDNFbUJQc3F5em1heXE3NGk4NDdmeDJVVHBXdStZ?=
 =?utf-8?B?Z2N0alNoaXBsRnNPditxUlZBL3FIN2ZRV0ZGaGNBSFk0OWtzTVdIL1U3eUNL?=
 =?utf-8?B?Z1ByaS9pcDRRbWJFM1UvVUhvK01yMUdGVzRUc2oycHVlSkI5WmFNMW1xUTZE?=
 =?utf-8?B?SFBJWG45dU5zWU5mQWRpajNGSXBaSHFMamRVMVg3KzJCdzgya09LRDhVUE5y?=
 =?utf-8?B?RHVCd2hxVFo2b1gwNnRzcUIwUUE4UnQ1SDJOSktMbU0rOVFTOFVYLytnL2JG?=
 =?utf-8?B?S3h4R29ITWw0U2JlSFhJTkRxWEd1N3FkcmVwSHF4dXN6K1hrV1ZFRkt0azFB?=
 =?utf-8?B?Z0hzSi94M1lhTHU3TEUwNDF2a1owS0c5S3R1S1lBeFBSM3VycVJCY3d3K05t?=
 =?utf-8?B?dEVING5xNitBbFFUYkdnaEtlcXVIV1N3U0U5SE9yZjZMc3FpNVVqRENac1o4?=
 =?utf-8?B?aWs2eVZ3OHZPTlUrYjJTVUxiSnU0UWJVQmJ4U1pMeDl0ck1nM2ViWXVhQkJX?=
 =?utf-8?B?QnNlVDVtbnE3aXdERlRJdWFsdE9BWGZGdkY1azZKVldLcjg1SXNmY0xVRmJZ?=
 =?utf-8?B?bDg2Z0pJVGdzTm03eStoYVlTVEMyTHl2dFg4UE9MMlJVNWRlekFuT0NNamdo?=
 =?utf-8?B?MS9HOXNVSEhBaWFrTm0vRG5GMEc1M1djQkFrSkc4ck50eXlINlkyOHpCOXNV?=
 =?utf-8?B?WkZtNytRcitWMCtSWlFqT0sxaEVhMjJuWlR0dytzWnNFM0pCVGg3VkNxSHhk?=
 =?utf-8?B?REE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	z6OuhkdnK4gUG0KfNhgTVIjnyzDAxHJTvbe5gE1cGo23l5i+0ODEnxRlQSkipdEZnGcA1yWQWsr9bCk1LnY6LwQcBM8nIyKb7ahwyzXKTU3IBnFnnxhyXgIxxuh2OvCXvra1Av2fundV4arFTYp+TpSlkUHb2Z3QDqnZPMoaoelnpTvENa8B6ObV+1lXncxVpIS6zOvu7seHI8VmY52mRpcQUIQPb7cWBIgwkC/tVV9ehovpOhUQJRDUx8dJxefv6fIdGCq7G2KeXf/ikZkaHCeTqu+yuUMa2h3/xBEoct3B3EM+XQEg/V0jRlUwzDlUC3/NbZMOpaeP7GWXXcrFyqRu3zsp61GOYdX2wUckoWZsC6qslzLbixFwXIA3BwhyDYBO94Or+3HT1fQ0OUHIKpndy2H9IUfBdJWu2G5S49nzXoAA9/HI4F1kYDMxNKWJZBYfjUOjMLht+el5g8UFufWnTxE9rWj1ZVyycuXZfJyVdthbcNb0057iSTve7YUCknW9zxqpb6jKBFfdWfXwo3Yy1zT1VknLrXWYjlf2iQOle40yE4U7fdAnblz9X2dW5JrUZRJCCV+TrKf/O3m892OJ+ppBu0CB9jTJcEC1990=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c335fc69-5f52-4334-86e9-08dc7be4edd4
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5893.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2024 11:30:35.5487
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EZgRhOm2VRfK5GXiInSRsVE4D0DL03o+xRku2wk0vjfyhpwOabX2zDSBjLyC4Kzo/qpkBvvMg09YgzBt61ooVCcvI5gqoJJCgJg+0EAWw48=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6699
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-24_04,2024-05-23_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 spamscore=0
 adultscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405240079
X-Proofpoint-ORIG-GUID: 93FhdA4bswA-xrEqV5uy6A1KCNuMHtCK
X-Proofpoint-GUID: 93FhdA4bswA-xrEqV5uy6A1KCNuMHtCK

On 23/05/2024 04:30, Tian, Kevin wrote:
>> From: Jason Gunthorpe <jgg@nvidia.com>
>> Sent: Thursday, May 23, 2024 1:51 AM
>>
>> diff --git a/drivers/iommu/iommufd/iommufd_private.h
>> b/drivers/iommu/iommufd/iommufd_private.h
>> index 991f864d1f9bc1..de3761e15cab54 100644
>> --- a/drivers/iommu/iommufd/iommufd_private.h
>> +++ b/drivers/iommu/iommufd/iommufd_private.h
>> @@ -52,6 +52,7 @@ struct io_pagetable {
>>  	/* IOVA that cannot be allocated, struct iopt_reserved */
>>  	struct rb_root_cached reserved_itree;
>>  	u8 disable_large_pages;
>> +	u8 dirty_tracking_enabled;
>>  	unsigned long iova_alignment;
>>  };
>>
> 
> should it be a hwpt flag instead?
> 

Most of this deals with iopt locks and walking iopt areas to clear dirty. So
this being a iopt attribute looks cleaner in implementation. But I think I see
your point suggestion considering it represents a iommu domain property.

	Joao
