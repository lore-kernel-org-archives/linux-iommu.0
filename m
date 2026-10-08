Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013018.outbound.protection.outlook.com [52.101.83.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C7F4A5EC8
	for <iommu@lists.linux.dev>; Thu,  8 Oct 2026 14:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791468169; cv=fail; b=oRS7waJTgsWom8HfzbLvXBPsweuDfdr7oK5AQaf8264WIqAtTBZ7LiwX5sCNe+0mT2r16E1qX3DxqhBRGuj8eHn35a2Jett4p8jywI4oobuhnG1ZmuJ9sQ/vPvzKnxbG5OzqcW2K+8Hl3ET2Dkz6wGvvkQG0CsOEslCS1jPBe1w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791468169; c=relaxed/simple;
	bh=4eYpzg2Hw231uld5SKP1J26Eg0GrP4Ol0/3O6vPz8e4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WQhnxkbakURzvgufLpL1jQON/IUYTEug1+QTenTb834SiLQ2CAd/kBo4cJsdgLAhfTKtd1qVd9pScHaA0wiTLGuwsElV6PL/9nM+Nqt3WPabIUCDiq7aN3z/6dNQ+5R2qy6cind+uNRgbuybO2gtL09z8FPUHjsGnQdFmEd2msc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=eoQnRMJi; arc=fail smtp.client-ip=52.101.83.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="eoQnRMJi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q0NtHlfckNxDfHXGXdx2rK0yO6L4T1kE6BlRyaIkK2lu17XUyfGcFzL0HxE+tOy68FuHOtG35183BdIuzFyYCfAyoLzmmL/nVU4bWBMVzl5BzrOhDP+vFs3ffa1vr48BWoRduyF83pDigzY5+qoK5+8eYW1x+r9V3RhYU/0AJdNZ0FMxU0KKS1rlU6XoC0v7/jhgQyY1DwpgoZLX1AGwjlfyZ5cG8ytPt022caO6hM8CGPbvjdLhFm9CNhEv5hseP1drEjHwUAP4YgbNpDJoc/pzVhzhQoSD4Q4YKMxyH8fM/c8I6znmkXKph5kRqXYXKrrmxDruZTxEsjQEYdDJvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6vNcHKfQkJv8VoJoO5WlHmPbl6malqjflPS+to4/dOw=;
 b=akD9XX0Icmrmb1vod9+q+JF9FSmywcFcRqKMpr8lgD2IUD67yDQEHlb3IKkt8U/tcVlNLleePfkX6rr+HTgvTuZMkTyj3qxyarYLMl5yocEzMx/V9VobmiS0BsnrNUBwPFCcshXT9PglEXfc3RwMzNmYjtVrHbI3Ix7LkLoavx3pbhZmdzAGB5DcM10xhZ2aGa2/lRwR3JASTrAZwr0a0Q4XIsm9K2sfg6QkYaFXuQmAYMgnTie8O+Eug/dHt2Q9fL0v5q048dcH2DgODLC16/Up6d5NH25ccfep5t08VgwYNrrfMDzobuMoj0NJ/IK2VQCmuy7sO3EK78lOZx11SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6vNcHKfQkJv8VoJoO5WlHmPbl6malqjflPS+to4/dOw=;
 b=eoQnRMJiwz1i9cEjvL7c1ujWmaBy2HJ9MtruTfOsnmYtzAUiz2kmOHW1OtI/Vz6QBcxnQI07FjXBKdAnMZzbTjH1cjs+N2EZqt+ZG747rGkJczihOxdvmq8Y5XrzH/+m0ERbJCpAV8QL7uUD9wIJQP6OS0n2aANJSx0/GrzpFyYGwfT2IK3fCfcv8JZcFoD7sWWQcz2JZWd07Qft4byUkQAv6bwlCHNe5RONwQ7hznUVCRzHo9/UtToFZzjk65unXBSTKHPp99DiM6E544vIPdSAVBkMwralPvxH3gbfwhJwsabOQOry4ZBQ40TBTB3iapZ1SgiGNZPPi30qtIS5Sw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by PAXPR04MB8733.eurprd04.prod.outlook.com (2603:10a6:102:21d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Thu, 8 Oct
 2026 14:02:41 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%6]) with mapi id 15.21.0496.010; Thu, 8 Oct 2026
 14:02:41 +0000
Date: Thu, 8 Oct 2026 22:07:13 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Jean-Philippe Brucker <jpb@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Thierry Reding <thierry.reding@kernel.org>,
	Krishna Reddy <vdumpa@nvidia.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
	Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH RFC v5 4/6] iommu/arm-smmu-v3: Support shared SIDs in
 insert/remove_master
Message-ID: <asejkRrL1osIhIGR@shlinux89>
References: <20261006-smmu-shared-sid-v5-0-169a59c671d3@nxp.com>
 <20261006-smmu-shared-sid-v5-4-169a59c671d3@nxp.com>
 <asbrixWURytrZgfx@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <asbrixWURytrZgfx@nvidia.com>
X-ClientProxiedBy: MA0PR01CA0008.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:80::15) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|PAXPR04MB8733:EE_
X-MS-Office365-Filtering-Correlation-Id: 6adf5160-18d7-42f4-be53-08df2544d191
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|19092799006|23010399003|366016|18002099003|22082099003|10067099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	fM8QuOAxRr5dccjoh1ZH+vcsub2d1nkPv6JvT7Ci8bhUMtCViXg7N/U5NEEZQtzUXiGbNloFpxjITxFcWeuRxwT4PAPWA0JUlkUVGuOPnOEi6MVQDjOWQ0XqKMsxIw+DD98jHgcB0Zb0t3wA6VnKfdyeMfgaAYv6pmCKCSefeL/EZ4GF+sLTBgFtU7D1Bzt3ups3VpJYiSJ/My1XWo732mA3PTet8NdgFekWVn1YwYNKacYcaIDiBetkZ7njqIr1Gx0ZUmaI0VIl0+TZXZREGsiVHHrU/aUGJwTbcHmNntfYC2YP+HgWrHhEonQhQkfmCE8UbFLvtj1UiUFDvVMDKddTX7fhBpPANjBjekRlDEuftd5IMhLc5/gmZKW5Y07jkSXFkRPACdzsHsB/BmIXmy7OICYqpR1bHEU959HUhc+T6NbEWUfHXyn8g/WBQKlIb5Zpb/+Kk7Zoxrlv2JVTuiQ9XFFMSZzTlpx+H0uVpywzXbSGbvT53O3dVkxdwdkQJDrO7Gy2vgfxwxNZCzF9PyNuT9U6V0lAd34yXX5FK+UbVOds0vvynwijNHuerDCNyB9d4xX9APubLqccx3xgQHm3m9Ilf9t9WlEgzwebXXGOt7u/A41W7mOEe7vGt9jXk8lKDK+Qg6pvaulsfMqlCT6/omb4D9eJVWbQOTGK/Nk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7874.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(19092799006)(23010399003)(366016)(18002099003)(22082099003)(10067099003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sui+Lcx2TF6Up4CQxFNetKBsAR/bONjZGLMKDoR18JDkIJLooApw0i6kWD6e?=
 =?us-ascii?Q?1ZI3CHQZ85sIria626MAvD9kib61oHQBO1g6A9hOShK1nMNCrqR6zOnfq4jy?=
 =?us-ascii?Q?r/lzIVHraWF+yEzPrSm+b0P5aFhWIg5AtoT0uVMWW/8rVDnIt7XI9PrSQ9kF?=
 =?us-ascii?Q?Os06IMAieAQm/MWOxYQE5BLLub6P7/fful63xD2kef4brhZwqrau5ji8DJVg?=
 =?us-ascii?Q?HLZcYIUn4B03XL8snksIoE7DFe64Xh7OX/0LUUhZssJb46hZw+3m2EhPFyJC?=
 =?us-ascii?Q?rIhPC9siWOFO3YOCZMj4Ul2K6jHWkeBwuH1wVuhZqsTlWDzEOQUE7U9aubXV?=
 =?us-ascii?Q?dVas8b3Yp4xZhcorGhUN3ivuXQs0Psoupb7nJSZpTsKVU8/s4mQvwQ5LWLNL?=
 =?us-ascii?Q?ZCgt7yTMOWt8GF589IuZzGthZhT0x0XC0S6H+NpUj3w2oY+N2M5k715legDc?=
 =?us-ascii?Q?nmUDAVz3hRDnOpphlyzwIB19y3qKV2nVB/0iFDMXUIhkHLiCPsGMlddNf8sL?=
 =?us-ascii?Q?d7mED+2nWjkXgIsnARAFC5NM3rZPOI7Bu+nWpCjDt18lxyti+tZKgfn42SWN?=
 =?us-ascii?Q?TGvBSQHY45z873VImfflWoieVNhptsf3e7xUmrCTQnUMI4trok/vE1qx/6Jv?=
 =?us-ascii?Q?QWy7TYqYWq3nh04/8dTYX16wpv2y2wTTC2gczWjZzu4dn+zboT/KaPP5Fyhr?=
 =?us-ascii?Q?k7RGupbGYSmmmiu/nrhp8s0WzaGUWgQe5ALvfX7DsT8UEgX3my0LhxtowWn5?=
 =?us-ascii?Q?i7rtX3q7Pv+pblzHAFaSz/ekOABHJPtQFJ3kSB3cgp6oZVGJgjfb6qTYWcLv?=
 =?us-ascii?Q?XEWXfexbanZ/52YF8OtVYTYmfOgaI2g2Ch3GArsR/uAxOCbC32UBjGxSH8uh?=
 =?us-ascii?Q?uaqYLWFyRiH4ZOMb1LGpYpDLKckbMKtvofA63DiD12j60kk77+6YTf5Z69k1?=
 =?us-ascii?Q?/Dc9rdYw9dCTZs0esBgSCyYk15aJ9fElsiwG08Qtd00ohDRvwXFUwpEvYmwe?=
 =?us-ascii?Q?MiaDShiLPa3N0LYDOPQtXaiNkrWrUxSEqmoJ1llrlkipZuOws3cklWf4ixV/?=
 =?us-ascii?Q?t0yx3Qm0He0GrhT3dnxTmk45VZ2hnjSXALpvZ8jTtYCVp6UJE0JafC3yOmyP?=
 =?us-ascii?Q?bSgIJVm+7ZAcBmtpP5wop4tkg61C4Oi8EYN7PbL+GUxbHuY8/uQi1SzWWPPH?=
 =?us-ascii?Q?wrQCGLULDB5f4zLDlaXcEUKSaF0cCo1ZD5FEWhaM1z3i+w8HihigV75DQrha?=
 =?us-ascii?Q?IYITD4tVUwvDRKyrfns4V7zrI6pv6OGisCGjjZWSYTb2bCcO3jv6PEW33f5V?=
 =?us-ascii?Q?hn8eDGRiF8CzsSZCXmUUtTjbgrNNIRDpgi+J+gvsYP0kgTvDXYNJp8pGHNki?=
 =?us-ascii?Q?UDEca/eO27eD6rJ1n2cifJi/okQ/+04eslvGsKrps4szu4L1/FS03iqgDYRS?=
 =?us-ascii?Q?sAoI1xmJdxK07CTxr/ij8o/CQvshM4f1IoT2SBDYWKANdvfKCKb1IO3Kz3sh?=
 =?us-ascii?Q?VeE/1wRFKrlFDTiisPpv0U+7jNU9ZCQuGTP9Ya3tEX0s1l7jiPWPeKPGa4wY?=
 =?us-ascii?Q?BjpAOry9j7NsBO+fTvIpS48XlswBwgxt3jdbvBzWzYCNYirmKB0lOz2t3uoM?=
 =?us-ascii?Q?MwNeNIWLyDxs1nnjJgsDqbisSu19LuvtCxI0TLouTdwswmrtpchfTPY+B0ZE?=
 =?us-ascii?Q?mTv2QoNd2qyVYEMBiaEMDOgjLlBaM3GI8UyXxR+r+ypZH4dDfTA/TEd6ONzs?=
 =?us-ascii?Q?JQIdN+OISSzbbu9rbKjURY/B7nktjkTsekhpQll91cxcALEoUMQY?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6adf5160-18d7-42f4-be53-08df2544d191
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2026 14:02:41.6164
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fpStMH9y5t3ezqM+ggTN0RTeVkXgrAAQpLXRPZ2PS0h1TTRWbuNWONe4dJUJWxPugJGfYJZb0jHjeuJ1evLBSxMwNhfr3Fez77ae1zl9HeQ9Faud8jQ7p890UFwzIezM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8733

On Wed, Oct 07, 2026 at 06:02:03PM -0700, Nicolin Chen wrote:
>On Tue, Oct 06, 2026 at 08:19:10PM +0800, Peng Fan (OSS) wrote:
>> @@ -4193,17 +4213,31 @@ static void arm_smmu_remove_master(struct arm_smmu_master *master)
>>  		return;
>>  
>>  	mutex_lock(&smmu->streams_mutex);
>> -	for (i = 0; i < master->num_streams; i++) {
>> -		int j;
>> +	if (!list_empty(&master->shared_masters_elm)) {
>> +		struct arm_smmu_stream *stream = master->streams[0];
>>  
>> -		/* Skip duplicated SID pointers already freed */
>> -		for (j = 0; j < i; j++)
>> -			if (master->streams[j] == master->streams[i])
>> -				break;
>> -		if (j < i)
>> -			continue;
>> -		rb_erase(&master->streams[i]->node, &smmu->streams);
>> -		kfree(master->streams[i]);
>> +		list_del_init(&master->shared_masters_elm);
>> +		if (list_is_singular(&stream->shared_masters)) {
>> +			struct arm_smmu_master *last;
>> +
>> +			last = list_first_entry(&stream->shared_masters,
>> +					struct arm_smmu_master,
>> +					shared_masters_elm);
>> +			list_del_init(&last->shared_masters_elm);
>> +		}
>
>This doesn't look right: it still needs the for loop and also needs
>to compare master with stream->master:

My bad. Thanks for sharing the code. I will take care in V6.

Thanks
Peng
>
>		if (!list_empty(&stream->shared_masters)) {
>			struct arm_smmu_master *next;
>
>			list_del_init(&master->shared_masters_elm);
>			next = list_first_entry(&stream->shared_masters,
>						struct arm_smmu_master,
>						shared_masters_elm);
>			if (stream->master == master)
>				stream->master = next;
>			if (list_is_singular(&stream->shared_masters))
>				list_del_init(&next->shared_masters_elm);
>			continue;
>		}
>		rb_erase(&stream->node, &smmu->streams);
>		kfree(stream);
>
>Nicolin
>
