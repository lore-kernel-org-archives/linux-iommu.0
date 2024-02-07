Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D61092555F
	for <iommu@lists.linux.dev>; Wed,  7 Feb 2024 10:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707301449; cv=fail; b=SXfFwKl/oGYNCadlgavOGeOj3wvnfhJLLIawKibDbEQj33gb8336oYrjDc73CyrRleoRLQlonu6nje7w5DlxSzdBFG11zQqfxyFWAdxukPgyNgeHnkaqiIqkQn6Z7OKmynuvx2HzCFsKwI4HrFrb81HogEfutFHNkjIiRki6Yhw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707301449; c=relaxed/simple;
	bh=HFgqmRsw1zZVRGTa9seabGJQG95eK1qEq2eAYhTV2lE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SajtzHam4j95BPVsWBNqwU41lU3+/oaKR/NMBOrtGSmYwxrZCtCdnnhadYR3BzSg6mIISBBZmaHD3DQnwqhp06BITidEwdjjOGbeWzT5/u0s7jHnsyYS8zmQgA+meqEr2QGuJRVSL42QCpvkT4anFo4L0HnZT+NFnAynLizI57I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=m0EPbRSq; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Rdbd+aTe; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="m0EPbRSq";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Rdbd+aTe"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 417AE4SO022511;
	Wed, 7 Feb 2024 10:23:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=HCc11xPzt8VL56W8nWnmPIDQ1F2IOFrKs4MlPVDfbNA=;
 b=m0EPbRSqvZdleOupP1gUdMjQl6XHiA9fiZPF1XElElGNHhsJUoKMZZeT0Q2y/BWu0hbn
 kFnkGFiJtyF9R+JRuw6q4wg+oaaEdSzpt3dYWNfC/iO1r6X1I6S9OZZ4Zjbu9iOPFAv0
 8uInanHQUGm6N74qfvmOKngGBsPTFt6oYeU81yxj6//NXqpXwg59OCF0xo2bLKlgFT78
 NbD3cuY4sf1dlcWipin6s+Z+frVH7fEkHm/uU1xG8hD4WgWhRzE/YwfC27276YQtv7hj
 8jQuC5jOshean34NPfqBoGGKYKspM+OPFKFtCf20kmG8xOHKIpGDYx1kG8TGCz+O5SRR sg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w1c941g4x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 07 Feb 2024 10:23:58 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4179DvW6019741;
	Wed, 7 Feb 2024 10:23:57 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3w1bxf2q1v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 07 Feb 2024 10:23:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rb7S92Qzo8hlHS6u1EoSh4b42mG35pvNn9cF69oEH0rNf3tLr9C7Jj3mDE6xwbpSjt4QkjDnuJpFqXRz2gtehf0vVWj/7hR9oGnb449A6iNeLFPqIBCmw8ywLRl3SwWYanECmIbivccwD0K7JIU12gFCRNfBprgawkA1nq61obf2XPW0VmOt6hxOVVZoASOz0taj0q2SOP0o6TfDAtIQpGjSkJyXlScd95N/4Bsci7tWcTATs/ult49SQwEGiECHEAiCfcT7aT0PeYoOM72qG8UJbHSAhL7pxW6hO/hV6iRJ5fgwQ6U4Y037xSIxmUtqiAC0wBNcgiJW75xOlcda7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HCc11xPzt8VL56W8nWnmPIDQ1F2IOFrKs4MlPVDfbNA=;
 b=h6JptjSLFZpJESPWCEndg8Ok3JB3is6mk3sD4KojF9t2Q/rmSmHb7uxfUSyZta38WkgYAMk3JcXWuo5CzHn5usgJU4yjDaROagQY6vb/EIFLM23+LcN5+JH980Jr6LVG8LxRFqvAYPOlMKA2qo6rOATB6TthPf3jHhOVNE+bClhau02/uYyV+Y/DNp8hxxrsk8upPe4vzoeIH4GyStftvnG0duYcm6NRz1TGCdnXaxqD4rop9/nDaeemhP7Z47aq+g98dvfIl2Sr4ksWatcLqnjJdbLZzM5+KjOvg4sUdGxhiHcKpPJVyHdZlwOc/mxZ6xJDVfFgjWAM9A6ZzgHHMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HCc11xPzt8VL56W8nWnmPIDQ1F2IOFrKs4MlPVDfbNA=;
 b=Rdbd+aTeEIdkSfVSNpAI92jJx5I9Uux51Fw+MY4DpizA3osDtJIcNU4RsYhuRHz9+qJ0w0Av3DzWgWOihTV1LjCLYV9HXe2yjmflsEARgFIA/4YNOOcKg1qw0xxI0+wb6Q+lSBGp/tl9Q9bJtWDvuce7g/vOZWC6pjNpWG8TQiE=
Received: from PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11)
 by SA2PR10MB4409.namprd10.prod.outlook.com (2603:10b6:806:11a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.38; Wed, 7 Feb
 2024 10:23:55 +0000
Received: from PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::b787:9523:eb1b:4413]) by PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::b787:9523:eb1b:4413%7]) with mapi id 15.20.7249.035; Wed, 7 Feb 2024
 10:23:55 +0000
Message-ID: <b17fbaab-8d35-4084-947a-c955e9f1a541@oracle.com>
Date: Wed, 7 Feb 2024 10:23:49 +0000
Subject: Re: [PATCH v1 0/9] iommufd/iova_bitmap: Bug fixes for IOMMU dirty
 tracking
Content-Language: en-US
To: "Tian, Kevin" <kevin.tian@intel.com>, Jason Gunthorpe <jgg@nvidia.com>
Cc: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Lu Baolu <baolu.lu@linux.intel.com>, Avihai Horon <avihaih@nvidia.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
References: <20240202133415.23819-1-joao.m.martins@oracle.com>
 <20240206181333.GE10476@nvidia.com>
 <91aee5f5-82ce-476a-bb53-cc65c369db2c@oracle.com>
 <BN9PR11MB52760A86CB0672C0A646B6BD8C452@BN9PR11MB5276.namprd11.prod.outlook.com>
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <BN9PR11MB52760A86CB0672C0A646B6BD8C452@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PAZP264CA0122.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:1ef::18) To PH0PR10MB5893.namprd10.prod.outlook.com
 (2603:10b6:510:149::11)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5893:EE_|SA2PR10MB4409:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e612dcf-8ecd-4de0-6db4-08dc27c6e360
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	tU7eNziNpn1LtNSY+cpDxNi5GUHfCkdP/eIdnR1fhJWSpHxiYnLD8brDBWgaXJs+cWy/5OVXxpovebKBSSmy99HjuYmsj4glw9pG33OEgSeXcS7lK60QImV+E1fp+MJrtTT4i4kFisYpu6VbjYq6pqudDo0cy+RGH+qfTJuoalXd3BiU/wZBSas1ul4T5RQ25pVcaJIicQUAdgVc+y27g3HPwD9LgEbImsxTf//AkonPA5wurvBQv/bz5duQyMhlasjEEjHdEAg1TQEgWZnLsyYSLdMauiTgaRVt/0Vk+MKIY0kjbBeosip1vXULp/IJ/+I4kFcyXq8kNyTRCM4L/pf1hav598Tv4wUhUW015pFV7qJUmWZUyYpi/JrqAhz3yaomX4uPXrce2xlVGLCEHXfb8uuu0GU3R+zjyW7rfYpTDVvUkCczQDxqERpROfMHtsT2ebdGfPeFsfP4cgghl60amZxHyP+0jL8HYVCrf3rKcSa5+1Z0i0yCzSHK0W6kUsnuC9209qi9e+SM3Wpq/lauhp6vybmv5xNZSwJfslhYA6WX6d363NAJZvRMF8IvMAw7ri61cnKvYo+TP61r7Yu62VWc3Ug6bIztVdXgJ2QBUjzKhSTcpaCgocqKycS1
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5893.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(396003)(366004)(346002)(376002)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(2906002)(5660300002)(31686004)(66899024)(41300700001)(31696002)(83380400001)(38100700002)(26005)(2616005)(86362001)(6506007)(53546011)(6512007)(316002)(110136005)(54906003)(8936002)(6666004)(478600001)(66476007)(6486002)(66556008)(66946007)(36756003)(4326008)(8676002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ekdiWDJ0bGJGcENvaWlRcHdRbkFWcmJwbzNxbjdMUXc2OXZnekpNTmVXWnZZ?=
 =?utf-8?B?VkQzNEl0cVB2b2NjQ0RBUTFQV1NQMWJnNWxLT0N5OFFxTGI4akRqeTdhYmxl?=
 =?utf-8?B?RGlKZUtUcXVHVHZxQ1VLVTl0ZWVMYzBESStwcmZXQTB6N0FxWVcyaGNYQ0li?=
 =?utf-8?B?R1A2Y3daUEVTWEJwdThRQjlxc1RmRHo2cGYrWC9tWUx1VTR4aDBSdkd2QjdT?=
 =?utf-8?B?ZzBJdVNWUlZSSDRNSGJDVld6L3dEUVBiMTZqU2dDby9vMGVBeTBNV1ZBSnla?=
 =?utf-8?B?UTRkcnp4S0lOVWtkUUhCakYvT2hrVFlTZzl3UkZHaE9GeDVMYW1hd1Vza1Ur?=
 =?utf-8?B?UEd3SmsvTFVYUWJXdVdZNCtmRGZoaVk0eiszZ0Yzc3lvdDVrQ3hlRlVtdGNh?=
 =?utf-8?B?bUdzSjF2d2JYWTUzTlZFU3lxTE9QUWcvNXhCSzlGVVRiTDJueHA5UG9FcjRY?=
 =?utf-8?B?SnBsaFBsSXRTN01YWEVmZ21HRTh5SkZ5bzRXeDgvMVdjL1pzMlc4UVF6K28r?=
 =?utf-8?B?MTU5ZTlCRDErRHFHSEFYdXJTZUl5MEJGN1ZhWldpQ1RFNC9Oekx3VGtsdkJy?=
 =?utf-8?B?NnpPeDhBWDRCK1F6Y0g4MGpsVFNwd2lGMkljZWN6dkZXV2RNd2tPT3NpMGQz?=
 =?utf-8?B?THBYa0h3OUZkS253NjBQcU9GaUhjS2pzUlBORG1GQkJZOW9vT0RMcW1VSElI?=
 =?utf-8?B?NHBCY0YyaG1xbHl6UnBqK2diUUEwNzV3K0UybFNvTDJGdFpBeDBkVEM0Vm5X?=
 =?utf-8?B?SkR5dFVVRjVKWm1HZHJjWDhiTEhxUkVZYyt0dnVrOGhsTWhvOGpPa2tYTTEx?=
 =?utf-8?B?aGhwZEhGK3JYQmhUQm9QcW5IWWFqWHdiUDBoSTZvaWJaQUNIRnYvbW9mY3JN?=
 =?utf-8?B?bHJzNWljZHpxYi82N1BNVE11dlk2Zzh3Q3hXblFmM1EwamczbUJZT0VJd1ZE?=
 =?utf-8?B?U3B2bmZYdmVNNTV4YVZibkZmNjlhNlBYWE9vNHppa1pkWC9HZHpGRzFYb0ow?=
 =?utf-8?B?eGdIOUtSVDg5UDRGcDlyS1o2T1VpU2RndERqMjdlUnoxOElBaW9sVnJ3SGNN?=
 =?utf-8?B?VXVyWGlzckNadUxMakUrYUVUWFJDTmptQklhbTNjM2psUG1ERWdBM09Sdi9M?=
 =?utf-8?B?V05sVGFudkhIYTIzSUtRUW94Vi9yL3lXREEvSUhrRUxEMFB5TWw2dUUrWFBW?=
 =?utf-8?B?ekJ0R0Q4Yk9WYitnK3VISk1Na3VRNjRlUENDcG45bTNVbDI4Tk5IdmV3Rnp3?=
 =?utf-8?B?dTNQUVdxNVdNRHdkdXZzNnhuenJpeFc0OWhmSmduNkpKVGl6ZXVRSVEvcXhX?=
 =?utf-8?B?OUprK1VlTE5sVkRSTGliZUZOeHhyQ1ZnZ0V4NXRtUUY2ZVFEdDVHVnBROWQ0?=
 =?utf-8?B?ZDdTVGdxQlo1TGx6WVI0cTZ2LzdDU2U0RzRmY3JGcm1MY3JRZndTaFZ1cERu?=
 =?utf-8?B?ZVh0TTRoZDZpbVAvZnZEbjVJVitLcXhuaWxoc2xhdHgvRGxRaGpZSTJlVjZu?=
 =?utf-8?B?L05ldS83bDdHTEhJcnFMeS9VcE54N2RtL29hbnZKOTNMQlZGWmlFZUJhSU5x?=
 =?utf-8?B?c0pkQStsMGZXOHhqMG9VWUNrTG0zcnY0c1gyRDZtVjBLUTJJTjkzRkRlY2FO?=
 =?utf-8?B?eG10MjNpZmVsOFFZbDRYZlN6SVFmREN6SHBQYmh5Y2I2WlBJb1JNZ3RuR0pl?=
 =?utf-8?B?MDNRQitrSFlBU2NvdllTZGt2OW1lMDN3emhQaStaamZpeE1qeXM1VGRXRDNs?=
 =?utf-8?B?bFlXem5Jc1B4ZWk2RldRQ2UxbVhUT0F4N0toVHI4S084ekR0cmM4TU9Tb3NK?=
 =?utf-8?B?Qmk3WU5RWDY2d1pPSUE4MmszZFFYZnNVYmQ2NjJBS0d2OWp2cGY4QlgxMEQ3?=
 =?utf-8?B?M2VXcEZ0KzhUY3lVOUVCVlZrQjN6M2h0WEFtTjMzZ0psemZxN2dsdmllMUtx?=
 =?utf-8?B?QUhLSXZPcmN0QzVVQWhSdk43bEJQMlpwM05lUGtyNXdVYzJlcFpiRHFBa0Jz?=
 =?utf-8?B?UmFsOEZnaWN3OHk5dGJMUklkRmZXT1RQL3ViTXgwUk1GK2lkamhPRS8xTDFo?=
 =?utf-8?B?ZmhoRnY5ZG9MMzRJd2xKYzNtVkhmN1lrZzBFVXlMTlAvSkRFUmFuanV2c1pK?=
 =?utf-8?B?TUN4QW1mRGJiZ1V4NDhOQWZoN2dETktjUXFPWERidk9XcFZQb1hLLzkwVjh1?=
 =?utf-8?B?cGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	B9wLp7SImp3Mbcq6VGrhO43aGgtwa/MqXa5lgbAIX0S2S2r8jqbNSbf0UqWVOd67vMb5kXuXS7DLfS0CsARjiNHfRb6rvzKodjWyY1sMdH5vtmVHBKWH8R/F8eMUj4GGa76QNJXaXMaTKxMKZipw9qSemugRTdV+CjYpUclwSXzJfIY2XANi5aXirH4VGHvl//uQ+pYEyyM4dwui/3WK1B/bkmGz6Q9xjA8Wr8/uZZdh1qC7GyOvFgjXHw50UNGZcS4ESZfxA8FzlAC7priAptrad1aUGv2GbbwMihu/SUQKBg32YaiLWRk9UXozZclq/Md/LZafI1gbJJFezfmsscDcR1y03TW0C48JfFPinpeJ0T/JV/0pOIl8Ig/5pXjrrFIQyLalVap3dMJLn0+LVn9yQuIXk1esSmZn8Gi1Id131+3c4rKK5PbYnp3WmYLTAeC1uXW/5jQDyVYFaiiRyy24/kTUcSG0Onfr+Jxgpj9Cgk3bp5oWjQKfjfHLnuttaDy+ORbhDOXCPI6T0d5//DRVnWqKbr+NZEXiLekMA37tzSh5pXNcZt2wnVIHyt8cZCNHG2PyC1UedaUE9KNd6MDSZNz052ROBmUFCod9rS8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e612dcf-8ecd-4de0-6db4-08dc27c6e360
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5893.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2024 10:23:55.4298
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 31WVPVmBKWy/vhAXDjiNXfhppy9E+q1baR6N2pbwJLPg7ItIf/r/+/ZWXKRcYs2lnWriF7kBYOFfUvT2rzyzVmrZV7AwgxCHAtBIWRtmyLo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4409
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-07_04,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 mlxscore=0
 adultscore=0 spamscore=0 malwarescore=0 mlxlogscore=541 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402070077
X-Proofpoint-ORIG-GUID: o_vDla4omEF4cRuPmJUK5QXrtubq8AHv
X-Proofpoint-GUID: o_vDla4omEF4cRuPmJUK5QXrtubq8AHv

On 07/02/2024 08:41, Tian, Kevin wrote:
>> From: Joao Martins <joao.m.martins@oracle.com>
>> Sent: Wednesday, February 7, 2024 2:32 AM
>>
>> On 06/02/2024 18:13, Jason Gunthorpe wrote:
>>> On Fri, Feb 02, 2024 at 01:34:06PM +0000, Joao Martins wrote:
>>>
>>>> I have a separate set of changes, that proved also instrumental in
>>>> reproducing some of these corner cases in a more predictable manner but
>>>> with IOMMU drivers instead, rather than IOMMUFD mock IOMMU driver...
>>>> without relying on VF specific behaviour. Though, it relies on being
>>>> able to map IOVAs as dirty. This is not included in this series, as I
>>>> am not sure yet if such direction would make sense (outside of testing).
>>>> Comments, appreciated.
>>>
>>> I would love to have a test suite that could drive real HW. I think
>>> that would make a big improvement to iommu driver quality.
>>>
>>
>> Ideally we would merge the selftests to use real hw domain rather than mock
>> domain, and skip what's not supported when hardware lacks. Specially as we
>> add
>> more and more features (IOPF, DPT, nesting) and underlying testing, it seems
>> the
>> most natural point of consolidation.
>>
>> Dirty tracking is a little strange because one needs some sort of block/packet
>> I/O done to hit the path of having something allocated, which usually
> 
> same for iopf
> 
>> requires
>> some driver operating to mark things dirty plus page allocator luck in picking
>> the right pages. So the straightforward way to manipulate all this without any
>> of this complexity on real hardware is this is to "map as dirty" and check if
>> something is missing. It proved useful in these bugs as I couldn't reproduce
>> this by just using the thing (even sharing the same test as Avihai). In any
>> case, the gotcha is consuming a new perm bit.
>>
> 
> is this something which virtio-iommu may come to help? e.g. virtio-iommu 
> backend may be instrumented to fake DMA requests w/o relying on a specific
> device to actually touch memory...

I would think that you don't need a specific IOMMU model to have VMM do fake DMA
(any model should do I think with the right VMM code). But well but then this
assumes guests, not applicable to baremetal. The issue with doing specific IOMMU
models (besides incomplete functionality in virtio-iommu vs arch one) is that it
is tied to a specific IOMMU driver rather.

Initially I was thinking a small kvm guest created and instrument the VF. Though
then the latter would like take the majority of code in getting there. And it
wouldn't look like a test suite and would likely be better acquainted for
specific cases.

For the purpose of code coverage (of iommu drivers) we could possibly have test
ops that instrument the missing hardware i/o path that a real PCI device would
do, though done in a real hw domain, much like how we do with mock test ops. I
gave the example for MAP as dirty (which I guess we could restrict it to
IOMMUFD_SELFTEST kconfig), I guess for IOPF one would fixup the user fault (much
like how we fault when we pin pages). I have some hopes that the selftest mock
domain adaptation into real hw domain could be done (but still need to attempt
at it once have spare cycles)... that would cover a huge portion in terms of
coverage. And perhaps have a tool for the subset of test cases that require
special handling (dirty-tracking, IOPFs, what else?).
