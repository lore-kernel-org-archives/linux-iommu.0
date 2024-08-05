Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA6EB1537D4
	for <iommu@lists.linux.dev>; Mon,  5 Aug 2024 19:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722884575; cv=fail; b=WShn03lkX172RjEDOl1iYCeXsLuOwR1jtmPs0ITwIyTSZWXtqtJeud/J5kNVhpsRPi1wquA1a1QgnZwEgBf6nAyHupoHE92aFEuFDPMAxFmOzmUN4QDE1dZLi7Fkl4JnX1sD1zwI35aVd9+tBr3oGR3l4UBVU9X0vR7J3JRZgV4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722884575; c=relaxed/simple;
	bh=IsdNOceKOAxOSP6FrxXSnBewDNwVlpDc6SDKmgsuiUc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qGic2CTM9SyoFKf7sRRCoENXPfhfUc7s1YYoQ1+jNo3yxmXk/2uhJhyzKzt3CO5MwwM4PAOPUDC6auTv1nhfkbJNBTvDWVxUzNf8q8TOv/WB3itT1Ce/nb4YgfVYvyb5sZIMkRTBrOCTqhz5xZfYqoVWuv8GVGy3WMG6XM3jF9k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=khd4AQr3; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=KBESUjbN; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="khd4AQr3";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="KBESUjbN"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 475GtWYq003473;
	Mon, 5 Aug 2024 19:02:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=eDyFeAC9+cidATCo3peN12EiN/4mO8le1Zl04nB9nGc=; b=
	khd4AQr3HFwWxmNjgZZdvJChhGeWt4gIJX7+576cheXt1lEsRBdaE7tC+lpYjO/4
	8lb1MUCzov7UNd1ID3b0UMVIgYa6hQH6tenL5duSoOLXlJJ84LqWzCVJBX4nbgKs
	OZrTUNk5yvm69+GFVw1vtIUpbfIO5EzKFW/QxrlfP3qEmX74Gxs//tIu+ReTJuFU
	Ajc8QRQ9/OCFLwsiZWB/lizPt7u2XzHkbHTd74oPpekYFiG0lfYeRYEfoES54qAu
	//QuIyftDN0zf+J4edtGvjsqtjKRVcckqXyxP0YU+KPpVa8jYIxddcRbggvItDV6
	PmhdTT/Uv03GWI8w+GCM2w==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40sce93ctu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 05 Aug 2024 19:02:51 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 475ITxe2035077;
	Mon, 5 Aug 2024 19:02:51 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40sb07tncv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 05 Aug 2024 19:02:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QAdHxtXJAssGHW4fCjyD7dB9uBTn+C1cEze6WWx+SZOvx9OURf+2m6xapjHJqV4xB9ZRLMvL0JWCZVIDthYuEaTifKDu20F/e5hOAKlpSqrTv7caoRTxGIPocEPfKHTZFimnmmSEK3VHbnQBlPDx3/lYB0uTOgRsAjW5vLeOZzdcxBa+aRt4hn1y9y+bDncw7TJtUMnrcSgO3wvIvetBsUzBXBh6UVynfnkHHG3D4wUjQNZPVkvPNcnD2MA2+m7hvEra/dBh0K68PQOGkrBSJWadHhOOdsdoN2ogFoMFSFy/YcZSbg7ZCnz5HweSgp5bWmpHSoQhTTX4AoP8vU/vyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eDyFeAC9+cidATCo3peN12EiN/4mO8le1Zl04nB9nGc=;
 b=COXfNIBT/2Hn9QvtCjFPqzeA7q5a6/AwGjpUqbPQ3+f2UooJV5hf3xNJYmwrHVgfBbE8/9oSBVtO/IEvHd7UFB0bF8bq9bJUczlDGXBEZinO6/hmyXbIl0jZzHdWS2WGRmTqSEjpunzi3Use83fu7N2xQOGIwJReXRU74Tz3vmY0BjZfKyGEcA0m9dK2Qqg+XCZQhaLxKtkhqAZAvUIXvomlus348YPcnMKf+lAcAT04c6YOAw8rcNj07IvrCBhXCpGCD0WNQmR5K/NVi2GB88gKfoYZKPpx/albvK8GIuH0DzK1SiQiskTAxiPZ49rVLomXrZ0NEZh+0zfU4ZOxnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eDyFeAC9+cidATCo3peN12EiN/4mO8le1Zl04nB9nGc=;
 b=KBESUjbNPkQth7VD5K5O/KZQt3LKC93Kb93znKb9vDHVuk2v1qUL+OBDn1iYQJT3CHrGiv8+AhH9tBgZmBkEnjr7rgTBqQAU3Bgcw7pNarpUMS+e38rjAYIYX9/xRMI7+VqgarEzGzfoxcnF/dxOR8Py6DbaJQn9gN9o8qFRku0=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by SJ0PR10MB4557.namprd10.prod.outlook.com (2603:10b6:a03:2d4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.25; Mon, 5 Aug
 2024 19:02:38 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%7]) with mapi id 15.20.7828.023; Mon, 5 Aug 2024
 19:02:38 +0000
Message-ID: <a2c9df0f-0fa0-4a34-9ba3-4368befc5dcb@oracle.com>
Date: Mon, 5 Aug 2024 15:02:36 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC V1 0/4] iommufd live update
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>
References: <1721501805-86928-1-git-send-email-steven.sistare@oracle.com>
 <20240723124847.GI14050@ziepe.ca>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20240723124847.GI14050@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR01CA0016.prod.exchangelabs.com (2603:10b6:208:10c::29)
 To IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|SJ0PR10MB4557:EE_
X-MS-Office365-Filtering-Correlation-Id: d5955e67-f3f4-4645-a1a0-08dcb5812c79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dWpFQUJVSVpOdzB0ODd4ZDRVR1M0MnRaS2g2QUptRU4xV0t2M21ZMmNFYTBN?=
 =?utf-8?B?OXdrUC9KSzV6Nys0VGdBSnRpeXFtRGtiUGRpQ2xpQjNEOEtCQXFtMnR1OVhT?=
 =?utf-8?B?K3UvbDZ4cjR3SGd1Z1Rjc2tqOU54c250a25ERXVOWDZ6NFFZMDVyNWxpaHlw?=
 =?utf-8?B?bDIvT25NUVNhYUtKOUs1Q21sbWVNd0Q4WTlpVklkOUVyK3Y4VVQ1Mk1jQito?=
 =?utf-8?B?ZThXYnNiOXIyTWNiMy9QOXRVVm9HTlkvcWpqbWpRdUtHSkdaNFRnMEYxK3Fo?=
 =?utf-8?B?MnErdWZscHJhS29jR3FSWlRSOGFKOWdaaTJ4bTdCQks5R0dpK0kxQVhUcG5P?=
 =?utf-8?B?elFMLzhuVzFwMDRBVW9jelIvVjkrenNZakVrbU1TdFY4R0s3YW1RQUlUejFD?=
 =?utf-8?B?c1FvUlhEVkxmZXNscWY1VXhjYVhLaGg1aXp6VTNLS2I3WXlmcUtLK2g1ejBI?=
 =?utf-8?B?Z0RYSGV6UEgzWXNQc0pXcWJiQWpTOTljMG1SRVdoanJ3c0laNHlxZE1aWHFv?=
 =?utf-8?B?WEkyUHdOQm5Nbm0vb3FXUHFRYkc0TEJ6eUx5aGZ4OFltb2JONm9tV2VoMTQ4?=
 =?utf-8?B?UkZkYmJ0a1dzWHJvNGNTSVVZdTZneW5GUVluaEREME9BdjYxbS9hUEx3T2tY?=
 =?utf-8?B?UDd5RVlOK2ZCd1NpbDBvbUQ2elJNc3ZtSVN0R0pwbVRLbTMyL01SY3NpcThp?=
 =?utf-8?B?KzlKdDhPT2t0L2hxVzlSblRWSVJ3RHNqek5yUnBIdDYyd1ZZMDEwVTQxZnYz?=
 =?utf-8?B?c3Z1OG0vMEdwRGZIVUVoNXExeUpZYjdkc3lwMEpFTGdpSVBHQWlETFhWQ3Ar?=
 =?utf-8?B?bWd3aS95R3dpVzNkZzdvRC9OTTI4YnpkTkh4dDJ2WWNOclArMEt1aFN0QTJh?=
 =?utf-8?B?WFp3TS91OGpZdlVlbTA1MTY3WU9OYTZURWtqaXpPakJRbnAzRUJLSEppQkRI?=
 =?utf-8?B?L0dDVHJjb3pkN2VOTmtwUnZsMnBiL0JMQldBdTF1b0xXaUpURy90Vk1KdllD?=
 =?utf-8?B?dy9sQkpNV3FPWjhpb0tzaVdSUnNJSWNQUVVnZ0FBdUJ6a2E0MWx6NU5Tcmg4?=
 =?utf-8?B?bkk1Rk82bHVBdVFkSDZSVnJnZSs3UUY5a2V5aFB6Vmd0eS9GQUhnbjlLMDEv?=
 =?utf-8?B?QW93eGwrV3ZnbkV3V04vUDNHb2hhZ0xLdXdmYUZTYlVFeW1WWWhYSk1QUldz?=
 =?utf-8?B?d28yMmdDRC9lVFhnVHIvbjhnbjVTbmhJWnNrUTFuQk9zdWZYVjJuQUlTc1ZI?=
 =?utf-8?B?dXNPT0xrWkFjTGhSWjE4LzlibkVtQXVYU1NlaUtnUU41ZG1IYkJScmQ0TUZG?=
 =?utf-8?B?K2FjVE1Db2o4aFY4aGJYeVdrNWlyaWV3aThVV1M0MTZVNms3ZHgxUEJwdUlL?=
 =?utf-8?B?UXhXU25kcUJNV0hnUHlMbXpxQWoyWTJTWXRyTTRpUVQvc2dhR0gwMmxGYm9y?=
 =?utf-8?B?dlkyM1ZDZWg5ZmZhbkVVaGVINEgzNk9nWDUzdTRqZ0lGa2Z0RVB0ZEhCdTBX?=
 =?utf-8?B?MHJLMklKSStUSUlMMVUvQUxCTVdXcExaTnE3ZWdQazlxTm5rTjAvcnJqVVNO?=
 =?utf-8?B?YjZEeGhuZm9iVmpZdlFqYWV6YjlIRDdhQjZyTkU0dEg2KzY3RFBWUWcxVHVV?=
 =?utf-8?B?VWNXOTRiWGRQTFFHOThlRVF5WkZZTjhjdkxMdVFoTHo5TTVHQXdQK0d4Mk9p?=
 =?utf-8?B?bk9pRS81RUxRT2Z5R1BhdUxSOU8yY0d5NzA5VWNGM3VMY01HMTZMdi9iUW9r?=
 =?utf-8?Q?jYKNlEfaeDwkkzol64=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR10MB7447.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WGRlWmJlS1Fxdjdsdmw3NUxqTWNzVjZCanhjTTZuTFZlVkEzcDZ3MkI2YTlW?=
 =?utf-8?B?czREMndteUlDTnJOWlZBK0ptSlVvY2lkcEZHenN2eE9RYnk5c2pkUU4xK0dB?=
 =?utf-8?B?eXRJQWIrVDNUTXBYWDRkSWdCRFhBbFdoU08rcStvRWx6QUhnVlNOT1NXdE1D?=
 =?utf-8?B?aWR4ZThzUVhpM3doM0F4NVQ2Mk5mK2xzeVZrVkFObjd0SlQybTJndUVUQU1L?=
 =?utf-8?B?WmY0bkY1SGtvNDEzMDhSdWhjdFdxbjhsR3I4NTIzUllDbDY3L2FSbHR1UDYy?=
 =?utf-8?B?RGlKV1BUNjNOVEx2S1YwQXd1YS9OWVM0N0FHNWRKUUNiSTFWUVVVemt0b3Bx?=
 =?utf-8?B?UitSTEUvSFpUcWFvU2JXbVFrcFRkZENuZkZiUWRLV200YnZiemlQRUZJOU9L?=
 =?utf-8?B?OXJkNXdRaDlUbVFBajN1bjdlQ0pCM2NvY0RuckVOcVdhM3lZcFA1aGlrSkkv?=
 =?utf-8?B?d3hlQ01Fci9aOGxmYjNMeGlUK0NVcGQwaTVDU0lhWVNWd2NhLzJ3QnlFYWJm?=
 =?utf-8?B?Y0wyeXRsN25EZllEdnd3ajJLaWtwRHlBcVRQWG9uWjk3YjJvWHZ1ckV5bG50?=
 =?utf-8?B?cTJZMVowRjBKV0lkWlhTU1A5RSszbUs0QVRuaDRtdjIxMjI0a2hJdWpKeWhh?=
 =?utf-8?B?SVl0SGx2QXQ4cEZXWDVJOWN3UDhqOVRHd1ByemgybWQ2VFpTSjNnR0pNOTZp?=
 =?utf-8?B?SStMeG16UlpwSTAyemRMYVZqby9ORnhidk84UVFlejBpNXh0U1B4b2NTcmxE?=
 =?utf-8?B?Q2VNZ3hRZTBCWjF1WXA0VXhZZlRQd0hMZ0w1NHl2ODUrV1hvYlVlUmMzNUVU?=
 =?utf-8?B?ZXh4Tk0xaHFKT09IWThldEI0N2VjMlV3RGo4RFBlOFRqMmFqYnpYOXh0SFNT?=
 =?utf-8?B?c1ViTjBiWUJXSkk2STNTVHJ3UGI4cGFMUmxieHZFdjFLYm5ISUhaZWZzbkZF?=
 =?utf-8?B?ODlSY01oNmZRRUgrVlVzSkJWRHEwTVV3Q2VKYU5IaVpFajdPQ0t6Vk55OGlR?=
 =?utf-8?B?cnNlTWdmNTNaOVB6UlRSUVlsZzdLNk96WTFwaFkzOTZZL1FzZFJZTmhncTI4?=
 =?utf-8?B?UVhBOGNmSTZXLzBvS2NnOXV6SVB5Y2I5NjBXRkNtRG5GemdLVC9zanZSRWtU?=
 =?utf-8?B?Q1R4WUlWNzZhRUdFOUZzZlEwaUxXa3JZNG5teldBb0UyVHk3d2tTdUttWmV6?=
 =?utf-8?B?L1dhQWpvRE55ZktOcklxV2dQUHZ2VXpxdTV6aXZSL0FVT2xDWEtvY0kvK2o4?=
 =?utf-8?B?Ymx2cERPZE5sTGdRbTR4ZU1lUWtUTzBlNmFjV0g0RWVRMkZ5NjU1MXI0Y3Vs?=
 =?utf-8?B?STRqTG43TW5Gd3VKZW52NW04endiYUcwZDhXQ1JFaVd5bjVtYlhxK0ZQS25C?=
 =?utf-8?B?ZUY0NTZOcmZ0WXd3amZLYkw3Nm5HNlVHUGQrVmtSbWlqWituTzFjejVDL3dC?=
 =?utf-8?B?OFZHcGNUQWlUc0hLVjBnT3drOFdqR2QzUS8xUEZsU0VQdE9yeDRwSEFGaHdG?=
 =?utf-8?B?dkpIOXVLSUJmYnBFOWx5blZHRmlsVmpwTWNIQ2ErbFh5N245azdZK1pUbmhO?=
 =?utf-8?B?VnBMUTJCbG43VmhlOFVBYXMzTVhQb04zYUJTWXFpZlhFQkhFU0dMQkdSTEU5?=
 =?utf-8?B?QXEyR1YrT2JwUXFsL3VubnA1NmhNbkc1OXN0MzdzWVY2MG9PRXd1d0JHOGJI?=
 =?utf-8?B?RGtqV3N3YjN6K0VLQUdCaGRFRmlrdjRTV0JmM1E5Y295b2kvZU1jaVhSU044?=
 =?utf-8?B?aW15SEh4ZVZFY0hJQUlHTC83QUdTUU9LVVpUbVVCRW1NNWV2cFAwVzFwNDll?=
 =?utf-8?B?VkNJWHpMWVhYaGhkMnFTak1MZGtsTG02NWVqbWFpbC95a283N01tbTRmdWxB?=
 =?utf-8?B?OTZQcDV0TkpzOTJHZU00ZDlNV0RRSzRmWHFiZTFyQlJSK001ZDlmSGJNYlp5?=
 =?utf-8?B?TkdiNFQzWnBKelhPZGF2NHFiYWI0bUN0YmFkaTAwa1V0d3l0cnVVSytFN3Vn?=
 =?utf-8?B?RkNXNDlEU1hteEMzKzBxby81WGI4MmU2VDExR0ZQNlkvK1l0eWwzOHV4NmZM?=
 =?utf-8?B?NGxGb01XOGtqMGFlRmo3eUl1cFd3QlFBN1JzL0NjRithWVlUOGl3U2J3V1Js?=
 =?utf-8?B?cnVlWUJrbFFvcDdNS2NNODJpclNJRHo5anNXVzVVY3dPVjJQREJKWXZJbUxC?=
 =?utf-8?B?VXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	UsIoQrVQJxUzNEFJVqSlWxYwHnA4sU/UtE4io42mKOWCAziMYWP0S2Mfpyj59+xNhVdPC1bn4ieic57FPtPfp682a7yI8F7Zgf2C4u1SPoAmS8qjzuhsPklWKoVlsMfzPExM+bH5FYCmGeYVopGo015SKBwgTa5qsl7eVhWglMa4PAUMgPmNgFfDcXoNS/CJO86eUwRqjqr3J/cp3pmR/dZ1TkEeAxjUSaPU2e8oG1UShXyhN9oN2cq/bNWq8auctLAa6BwsVBXVNpWaelT4T5n8xcjPYh+yJY1PYqZVaxIFGAOE6LQSOQ6LWfDRZFSG40wnt4iO/zTBLecbReRF+QqY3mPZmfKqSHvslx1PHg3dfCW6E/iVEHc5/RX2n8AM3DIB8oFBfbaTxIQFAKgaTubx9W7d1GNQVD1UpPEvyNjpBQSLgoWypoQp2OfL8DtBKdV02hCCBX/FGVH05E2prGh1o9EeXUveHmkWHExJT5jE6u9LAczHSK6ZmHcM2THYGXyhJncZh5/QGDdOqmjCKtiEsR/lG1H7dKAwtMkwZzkgFnLL6bHOEp02vOkxdEPJQ9zkDqy9HBNo2jp0Ehx/Ap2U1+UM20RpmMmwaepgrFU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5955e67-f3f4-4645-a1a0-08dcb5812c79
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2024 19:02:38.2121
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BUB2+FqY/DiM9QcZ+UdGNNambUheYqJ6d3kqwSlZG4DA4EaNwdNhSGs2PMpkmkN+XazktYc30VADPVnL9USgEl3hLZEwCkcUPM8ocPFHIL0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4557
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-05_07,2024-08-02_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 phishscore=0
 mlxlogscore=879 mlxscore=0 adultscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408050136
X-Proofpoint-GUID: PRgY_p6471AjG7MimLRxrGh3jZj-pWmd
X-Proofpoint-ORIG-GUID: PRgY_p6471AjG7MimLRxrGh3jZj-pWmd

On 7/23/2024 8:48 AM, Jason Gunthorpe wrote:
> On Sat, Jul 20, 2024 at 11:56:40AM -0700, Steve Sistare wrote:
>> Live update is a technique wherein an application saves its state, launches
>> an updated version of itself, and restores its state.  Clients of the
>> application experience a brief suspension of service, on the order of
>> 100's of milliseconds, but are otherwise unaffected.
>>
>> Define the IOMMU_IOAS_CHANGE_PROCESS ioctl to allow management and use
>> of an iommufd device to be transferred from one process to another.  The
>> application is responsible for transferring the device descriptor to the new
>> process, eg either by preservation across fork and exec or via SCM_RIGHTS.
>>
>> All memory objects that were mapped for iommufd DMA in the old process
>> must also be mapped in the new process, but they may have different virtual
>> addresses in the new.  The application passes an array of new addresses to
>> IOMMU_IOAS_CHANGE_PROCESS, and it atomically updates everything to the current
>> process, grabbing the new mm, transferring pinned page counts, and recording
>> new virtual addresses.
>>
>> If the application directly exec's the new version of itself, it must take
>> special care if the mappings may be accessed by kernel threads, such as by
>> vfio mdevs.  The original process must fork an identical caretaker
>> process which calls VFIO_IOAS_CHANGE_PROCESS to take temporary ownership
>> of the mappings without changing VA's.  The original process then exec's
>> its successor, which calls VFIO_IOAS_CHANGE_PROCESS with new VA's to take
>> ownership from the caretaker.
>>
>> Thanks to Jason Gunthorpe for code and ideas in this series.
>>
>> This is implemented in QEMU by the patch series "Live update: iommufd"
>>    https://lore.kernel.org/qemu-devel   (to be posted shortly)
>>
>> Steve Sistare (4):
>>    iommufd: Export do_update_pinned
>>    iommufd: Lock all objects
>>    iommufd: Add IOMMU_IOAS_CHANGE_PROCESS
>>    iommufd: update VA
> 
> Oh, this should also be covered in the iommufd selftests..

Will do - steve
