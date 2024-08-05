Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBFDB2AD13
	for <iommu@lists.linux.dev>; Mon,  5 Aug 2024 19:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722884628; cv=fail; b=UHmufD5/tVqC9WwyCYr+FGF2FKCCCiPMHUwCf9im7oFaCBIWbBQTgYxJWWV2iDv4BPDAVPEh0i5ZrPuqfkLM60ehM/iaVALGcPxxB2ueSgsu4mqcr/MWBcQ1ICCgCT2QsABV90j9+6wd4KS6vZBI8fUTGc0WVvJoaFj/Rg3MhN8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722884628; c=relaxed/simple;
	bh=6Dl9ON+uuwaQSTqoQy3dmlVcX2XaazWw8jU3gAYQv/g=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FX3PouCdCto9ADX3lYwEgUd8ZwyQZCGeXxzpq+HCU9/1regIO1HgaoXk6QFltk64F1Lr32WDBC52XKNO0W1uDdK0O/Oh7jYIYe1gOGL2lc6RIILeCuJZ8gB3iBp6DKgKwmkEuKDcwFPawOzUCcxFnM6G6U+Cnxc/i1u5fu34lDM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hkMuUtB7; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=CN1rT7La; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hkMuUtB7";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="CN1rT7La"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 475GtU70016861;
	Mon, 5 Aug 2024 19:03:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=iPmpHWU+Sg7cOpEjNsmfC/uTNJVB/1/GBP+vsk/3318=; b=
	hkMuUtB7FlOLF9Q5x7616liHPV9IoGRMJEEn9A947WcSMqBL71v2Q/i/h/d6Bv1R
	tN+X6ehe64U1jc39BmjyTtX6d7dhNJ+saFZzg+vDQhjNQspdUntsvIzPemyGcoQU
	yFCEahqkscZNiWqo8oNoUlc3G7B8mV+HVdhb0O65jrBMXYXmWnWCi74j2/103oZp
	Qj3JyYWHCnv1YlmIc82vxCflYUzqCndYcnpfmS0Nd4BQwo6OsqIYBPg2YjhyHcb3
	eJ8f2VBWL6VDQ45LQ2wnO02g+0albKD0nLpbnDrYtdj5nHA6m/HIf7BBE8La2FQQ
	CgrNxHQ9+/fEHhgEAe3PbQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40sc5tbegk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 05 Aug 2024 19:03:38 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 475IFCtb035080;
	Mon, 5 Aug 2024 19:03:37 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2040.outbound.protection.outlook.com [104.47.56.40])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40sb07tpbh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 05 Aug 2024 19:03:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c9AA4+TiyE9hlTl0Deue9xmLzxXpecSgACie80MYOmBjrzirX+gNMyERfEngo8WSyjlKVRViWv/iZ3DA6sQqmekaMZqPOqywpYlyezWfBJCIOT8K4WiCrGMeKH+SMKkTLRW2zBUorButzT8JKS/lUSeL4/nkkTioi8REfbYuhtYKDJCJCSAmIiqjIWfQ3lpw1Zaw9kl5U65fq4yZMkJ7SBsN0GUuO3OGStgYfruOTA/oI22lnTeGqIUgfb7DZvWtiqGN6C6hOVGKP1nBdiLazygmLdwAve5s2J3hzGGJH/NT0IfZwvAG8BbW1Q4UTSlXv/KoD9S1nnhgNJ9WLJwMGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iPmpHWU+Sg7cOpEjNsmfC/uTNJVB/1/GBP+vsk/3318=;
 b=tBNBF7mmSCODKfm9eJPFIlp/KvPUNxdcu89mPDiOBoxl+snv2zY7pIpE8S3j2ectcNQbYXkw+5pmRNcz2vglBTFXN3oi/xDVCj5672dquQMqNInrDejwFY1vXO9w9/S5YKf5qD+Ae2C9y3bMMLzQJFSs+aWjDy4TDLFk/IYNzd672ARenkdGOYUOeXxNVWc5CI0NkNGKb+6J8sfw7rOCDWfVGy2Rj24L7pw9ccJ8inz2UW0fNSgSPKC89XwnEtxCH1UmaRnUqbwmvzvWN5pB6DAorBTujU8pNgU69hlgLAd3B0hhxektINxa0JZGDsQYpQueqYk9XPGFkX6RvJlE2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iPmpHWU+Sg7cOpEjNsmfC/uTNJVB/1/GBP+vsk/3318=;
 b=CN1rT7La9v2XnzfHk03z0hxrQ2uv8ZI+Xs6HyA9CudUq+aKIKc93C2obsLw7OAIB81X3WWAQTaZM32J3EPt+E+io1A1tCc+vG3/Os4H3guKaJ7H95pHsvNPSSeRQ4Apv6kPcSTbim8jf03npMWipBe1MZQLENwTUm7qRUj2K4Ys=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by BLAPR10MB5058.namprd10.prod.outlook.com (2603:10b6:208:320::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.27; Mon, 5 Aug
 2024 19:03:35 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%7]) with mapi id 15.20.7828.023; Mon, 5 Aug 2024
 19:03:35 +0000
Message-ID: <3329e042-e4b1-40b3-9875-623f26386609@oracle.com>
Date: Mon, 5 Aug 2024 15:03:30 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC V1 0/4] iommufd live update
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>
References: <1721501805-86928-1-git-send-email-steven.sistare@oracle.com>
 <20240722155500.GI3371438@nvidia.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20240722155500.GI3371438@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0361.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a3::13) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|BLAPR10MB5058:EE_
X-MS-Office365-Filtering-Correlation-Id: ecce5fa9-5bbe-4108-06b3-08dcb5814e32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L1IrcjlyVUp5MnNVZVFRQjY5bTBwREhTOGNuYjN1bmYwdGpXVmY3SUQ1c2lM?=
 =?utf-8?B?emxWdzZ2OHQ4aEVpNEpVRk1vRDVUZXgzandQTGN5dVBkYlR2cVpCaGo2RnJN?=
 =?utf-8?B?b3dUbVB2Zzc3K1NBeVhQdHJzcGVXNHFPZ3JCcmJmMVBNMTRBNnNwQU1TWHJW?=
 =?utf-8?B?RHJVTWx1eHNYMThXUXl0VmpudWJLbk1RV3QzWUh0NTZBM3JpOFN2OUY1T3Er?=
 =?utf-8?B?dXV1LzZZaXhEZkxXMnpVdzJmV3N3L3dpTWNRSHFQeGhia3BhSjJzeVF1K3d2?=
 =?utf-8?B?MU5uZG8yTDVTUmppSVg0WEJxc2crWDNVZDB6VFpWd2YzYVNXMmhpaEt4RzV3?=
 =?utf-8?B?NHJZMFZCcU9qY1krVHNyWkJYaFBtU0prN1FzMFl3TW1pWE1wMGhySWtXNm1X?=
 =?utf-8?B?dmc3YnV4Ym00WmZ2QzdjYVNKWmRIdy8xS3pHS1hwVEhvVk95SytabW1wSXFF?=
 =?utf-8?B?MFdJSlhiekhuTXBLTUZVTmUxUTdYYkZFUWRwTnc2eUpydkFvUVlweDF5K1BP?=
 =?utf-8?B?QXMvMVRGeEhSR0JOdnRLVlArWTc1N3RLeVVjaXFXZkhuaGRNVlQyTEZGWmow?=
 =?utf-8?B?YTlxVkE5N0IvRG5JVkROWGJIWWVBQzdDcE1MaXlkWG9HeUVXdTJuL3RhTW9H?=
 =?utf-8?B?dFBBTWU1R3p6d285ZTEvQkt0ZWdkcEU1Q1lNSlJhYURMc296ZlV6WE1kL0w0?=
 =?utf-8?B?a1ZSWXFKSjRGVEVBN2g2N0RjYVBSNnh3OXZQOWtWanBQRlJ2YjB6OEJnWkEr?=
 =?utf-8?B?S2xnU1JjWU5iNEkxTGxaU01mdFVFZFUvbDRmcmEyUzltV1YyYnpGMVZvMVJM?=
 =?utf-8?B?WVZHQ3RIeWZWcGVYcm1HQUM4VXRLTlNHSmt0U0owU0s2bG5La2FoNHJLYkdF?=
 =?utf-8?B?NkFNb0ExQXhkRWlva2FrUnVoaHZaWjh6UWV0K3RWL001a1AvWmFxL3R6RjVP?=
 =?utf-8?B?TDJ5eFRiV25MaGNQczRNa0pBSEgwQ1BQQ3JKRXczOWJPdEpvZnMrcEdxK3cz?=
 =?utf-8?B?UngzTTZVWUdPeTlaUi9qZ0wwZ29tYlc2b0lhdlZNbHdyRzRGbVNrYm1veVJG?=
 =?utf-8?B?UmhIcDA0MXErNk5aQlVJenMwc3R5R0l2ZXB4REl6VXhrdVBjKzVVSkNiWHpQ?=
 =?utf-8?B?U2tVS0E5T21jUFh1anFGM1NXV1NTeDdiSWZmOTJDV0E0RnQ1WXIyamY2NHh1?=
 =?utf-8?B?UFZsS2ZNWkdCcHo5U21Panh1M0tieFhTVzBqeGgwN1NiUkFhVWxTaTYxMk5T?=
 =?utf-8?B?UjY2UTFGVzRmWU55VlJuZ2FOc3FYSW9XczVJUHI4azlPOGRBbWlvR2NpL3Q5?=
 =?utf-8?B?UEg4SlhYdDAvRG1PNm9oeElzbytGa2liamZRRHhOSWJNUmFGaTBXOFpnSDY0?=
 =?utf-8?B?STl0LzI0RFVFWkc5YUZlNUo5MVczb01VMHc1azJiR0VoWTRSM295MVBUUWdl?=
 =?utf-8?B?bUZteUNZbkZGcXNTQnlRYVRqb3BFeXdHMFVtOEdpWjBHZUUxdXUxelRLZHpk?=
 =?utf-8?B?Y2lkc3lqN3Nrcmx3UEZPYStjUWRwM3VSRmliZEh3WlUzVFpCSUxKREZJbUhB?=
 =?utf-8?B?ZTRvU0RPUE5EdGd0TFVPQ2tXbGIva0pheGRRVy9NZHRmaUxyU2N2UzdLVC8y?=
 =?utf-8?B?dlJYVmN3OFcycDFtZytkNGtxWlFPQnVpUEJBYnUyT1ArYVlMVTFPSWdPaUdr?=
 =?utf-8?B?M2RKSlJ0UE5zQ3hrOUZJZ253cXdhSW9FT2dJY29JQm9RYUh0RFJrYWZjMnZW?=
 =?utf-8?Q?03n2JHXmrMxLp8bCsw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR10MB7447.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VFFaNnFWRU0zdldRVnRYQ3UrN1RIMmJkcHhCb0ZyNE95SnRUZElGaFQ3ejlO?=
 =?utf-8?B?UjBBL3dtVG5PODd6dkREY3h2SDZVRGd3N2Y0SUo5SitzeGV3bFR6M01DU2g1?=
 =?utf-8?B?UFRVckpBdTd5c2VSVk5YNUQyUjZQUXNGUnlTa0RPU2dyK09XUS9qaU5HS3Bv?=
 =?utf-8?B?cmRKZnMxZXY4bmpwdWNoOFlid08rMWR3d1NFSXdvNElMNU0wSXhhKzFIaDFn?=
 =?utf-8?B?QkJPL3J2NkVLL1J4T0Jvam9xUXJqRzFCRStmc2ZOdzdEYVkybDRXamtHREhr?=
 =?utf-8?B?RjRyNll5MHk1TVVpN0tZbGI5OVQvL3ZYVytVQjVXMkdzZ0lPRzdZd0lPWVJw?=
 =?utf-8?B?Unp5ZjdCY09JN1Jkb1BOWWNXWHFzaWtNTWRCejNnNTYwMTNKSVUwdmtEYVhE?=
 =?utf-8?B?aWQvNGsrb09sU1lMR1h0NytVNFAvMWJNeVhrUytqSXBpNDdqY2x6WDBqVGE0?=
 =?utf-8?B?RlpTVnJHUnZMUkVhNDZCV29JclVrRUNoM3hXcnNXMWxucHlQcFRQcklLMkJY?=
 =?utf-8?B?WjM1OXhxcjlVbVAvWUhYUDZJK0pZa2xYR0lyKzNYZlNUbTViWGRrRjBzWlN0?=
 =?utf-8?B?dkNqOEpZV2o2VDh0ZUphYzVoMTF6aUZWZkI3SFE1VzMzWG54WHlhNUVFdzZx?=
 =?utf-8?B?SVpIcjgwclV6ODIyS0hxZm50TjhDdmxGV0hsd2FhVFh2aTkzWUJlc01hZ0w5?=
 =?utf-8?B?a2g3cEpWaFg0NGttZDE4Z3JxU0dmVlI0NEFFSDhuV3I0cnRMaE1iS2VJazdY?=
 =?utf-8?B?a1J5aGxkVi9MVjlrQm9GamNMZkJLclRBcFNUNGJkZXptemtvOFZCREl5VGFI?=
 =?utf-8?B?S3NyRTlQOXBMOEJ0TE80cDZLZm5OaVdCZEw3bmRtOExiYjJleloxK0tNMWdO?=
 =?utf-8?B?dWYzREt6M1dpZXZEZTBJejlCWjZ5eGFZdGY0TUxhSERLc2RQSCtCRGFLT2xx?=
 =?utf-8?B?Qk9UNHFLcXJaL2RPRkhxWXpWelhYOTV0eHpzRlZUT1g4czZ2M1BLbWxwRTA5?=
 =?utf-8?B?c0w5eTBSbjNabk5GN0M2a2g2TXBtNW9BeUVZT0haN2pvY3c1a1grZHYrOXFs?=
 =?utf-8?B?OFdUaTlmZGh4bGVzQzZxSGpzbzVoTWxOLzFDSkVFb0F1VERhd3c2LzNzNnNY?=
 =?utf-8?B?K2ViYm1KamtjM1dySVM5eUlzZjZNNFhHN3FnVFd1bDlLeUlmK2NrdmFxY0Fo?=
 =?utf-8?B?b0szNUEvL0RvYlYvV1pscnNYYmptdTJVVG9ncFErNzMyWFhNcXczSjVpdE11?=
 =?utf-8?B?MlpvZGZ2cWNtMDRYNXpSNGtBMm9oVVprY0dPK295bHJoeG5DdmtRdW1UV3F0?=
 =?utf-8?B?SlBNNGdMRlNHcTRPYjRZeC9tek5qcHFOOFR5bGlQYTdZQWlBdzJLbjE5RU44?=
 =?utf-8?B?WGJMYjhpK0ZzTnhwZFlpNEhYWG03SkxpTEYxS3Uza3NRT2l2d1loNWlTeFJ5?=
 =?utf-8?B?eDVZOWcvSW5OM1hrck1wRW02a1NiQVFEelp2QmRnRlhOdEZYY1ZzQ21VZ3kr?=
 =?utf-8?B?VDE5cS9tZFcwRFM1Ri9jRzJyTldBQVhQaDYxNnJQQ0VLV0VhakFrUjdtTWYy?=
 =?utf-8?B?TUJQeFZOa3lHejhNVng3ejhsWmxIeGpENUpEU1hCaWZYZDF6akh6YUFqemJl?=
 =?utf-8?B?dzBHN0VWcTA2VHlGMGZZQkVDN24xVkNuVFkzZkJ1VDVlQ000TVhsZU9MNXpq?=
 =?utf-8?B?YlplcEk1bTVvVU9iekYxblhPUWJ4TTJkczJmMldhV0JYZ3dLMllVQ1Q4Lzdo?=
 =?utf-8?B?bzl6NzJCN2dRc0ZaSSt4Mi9DT1FKRXgxb1hCRERpWGhGR1F5ajA2Q0k0bjF2?=
 =?utf-8?B?V3NVanhMb2lJNE9xK29MTjZQOVpMelVsRWw3Y2FrV0d1V0ZaaHJmaFB1TjZl?=
 =?utf-8?B?MVRta1hxaFpwSG1IV1p0Ujl4U1MwVXd0ZUpROHcxdlYzTHF6VUxJLzdnQ1Na?=
 =?utf-8?B?amdBaDZVeHhBSVg3UUtrNGdhNUJyMDdvMGdRNlhndUV6d2YrM29tMkQwVWh1?=
 =?utf-8?B?TU5GditWZWI1VytIV2hjNWZFK2NjVEpmL282NGl1NmVlRThCRHAybVlBRzFF?=
 =?utf-8?B?VXFiMTNBU0hiZys0UW45NEM1YzF2SnJHU0dheDVtMVNrS2R0eFhZWUs4dmVs?=
 =?utf-8?B?cHpIYUlEYVlTTExqQ0k2a09FbUxhMEJzeklkcmd2ZmRKTjg0R0ZhZzdjeVV3?=
 =?utf-8?B?VHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	d6SADTMUk7kakOqraP2edlJdUUdss2469A0/Zk/nBG4WIlPgFaEimwyfbJnb2MROpWLTZ/LvObJjXQSQTK8nG2QFGp5wCIJDJrFjUfmnl+GR2uoVbwLnbW2YhgL/yDbrCVFFeJprvkU9nnGu1s+MifwuRu1G0X/cD39hbt9foNzQdRPOMtFN3vNXccc31snXk58LEUX5S3Lbmd0GB6iD2WBGtOvg3/4hwGZ+yxsn5Z9lD6qr2u7qVbiFQh2vPP0+m3InGUXfN3CuT+stwbEU/OJNj6JFbNJR3LRO62fnygY4j7UEuoT8LCfVoV2H51eRbbxuOIg6897L6eoGQpa8U3QHDy96Db8LTZNd5N50J1nHFq+O/5JsgMirMxq0Ei1L8mQu3jqR4NCvBYIFjpVQZzyOftfbH70kIwuXoHzR5u6Af9avfs0egCT3Et07dXlUHn0vetgr8EY3cqKtFGs2WQsiqF53MRJX/m4iMpGVwW/72rE8xDl77Y8rJUrCd7j6G2DTH3c1AqA/RNkWRCDt36qalZ+j83ykMfMeWzWIRpbmdWIYvJbfPkNZuWT/OGTY14BYOXPL6K1cZ9U3OqyfSA706nha2rInixnWlBTaNOY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecce5fa9-5bbe-4108-06b3-08dcb5814e32
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2024 19:03:34.9988
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gVJGIghagwzxxZNicUBXu9amITpymruXkVAW8WuQHYCV2cks5jSfl9bYhWOZjdZkzqVX48Zy9CFmsVeVjPiXqinJy1zNcaqJMvn8c8uA2KM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5058
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-05_07,2024-08-02_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 phishscore=0
 mlxlogscore=880 mlxscore=0 adultscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408050137
X-Proofpoint-ORIG-GUID: qqhCGdW2hzjbLL_jPYGnARdxQ8UGRTlu
X-Proofpoint-GUID: qqhCGdW2hzjbLL_jPYGnARdxQ8UGRTlu

On 7/22/2024 11:55 AM, Jason Gunthorpe wrote:
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
> 
> It seems Ok to me, I'm glad it worked out for you
> 
> But have you considered using something like the new
> memfd_pin_folios() system so that iommufd is bound to the FDs backing
> the memory instead of VMAs?
> 
> https://lore.kernel.org/all/20240624063952.1572359-1-vivek.kasireddy@intel.com/
> 
> I've been expecting to add support for that, but does it help this scenario?

Thanks for the pointer, I had not seen it.
AFAICT it does not affect live update.  The memfd is passed to new qemu, and
the manner in which its pages were pinned does not matter, as long as the effect
on the mm fields that we manipulate is the same.

- Steve
