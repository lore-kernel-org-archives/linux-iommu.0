Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011058.outbound.protection.outlook.com [52.101.70.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1861F30CDAE
	for <iommu@lists.linux.dev>; Fri, 24 Apr 2026 07:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777014076; cv=fail; b=nxS5I+QajX4bOIMoxYHP2JLvv5Q0ymBweRFbLY7yb5hDCF9H8Vv9TJLvB4vrRHkWpJZYKFofdPds/mM8NTVAuiiOQdBekoeyNyBMcgsx3en/NVTnD0TPwhTAPTSZv9vge84jXw9dEYhhA+3CDhsM96FLdfszg32KcN8n4TJE0Qw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777014076; c=relaxed/simple;
	bh=2fScPobNOAJJ3XpNdV4LMTB38uAEaOecF8xpM1mSWVM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lre8HPchnh/18S3UpgXV4hWO8IuMe6CvWcWm6nI12iY0U+/7cXzj21U+kHHjzxj70AviXPcCawbG+psVRGl3ySyAUUSy4Wh18i4xIcZFS8ViawuHSrLOfWkvUFNCqCUm+pldtvtlnaeHNgbHWBA19VNeUo2Ckiajl0gMGcVyjlw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=fail (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=b1ZNCwxb reason="signature verification failed"; arc=fail smtp.client-ip=52.101.70.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="b1ZNCwxb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SJJEWl6eUsg7FJGRHBtb1pqagURtezzozstln08bvrssGQ9TDvlkr7tzjdbw245K7L4Vd7UdRyf6upEeIW8f9X7/sLD1G/70cVegKQtO3u9XZd+sqXL/fTZJQ0MIQ5QdSjG6SDqOb6+59zyCX0y82f2ikUVvcfidGBznQUKRnWgYbK3bjlm6zS9jYNI/uZv7zgAPaJoBwfrkMuO6ZgvvXwOpPTgmvPlSGamUnzsqAoa1ubEf5aNnfpIv/E7NrC1E0Z2BiDCf11hBpTrweIhhJYOpail07EV7N3Z/OUnpW9EW7kYyEtt5NGP0zpI2rR3/5jMIcInIK9NbOGF0JoQ95w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yGr2Z9sqmZh4cojztcKkGkFL8NLY0gWLf9f7OmFQdHA=;
 b=yMqc+cnfAtkDmzwxRqDwB2WykFsc8Urk+eh3jZVlZBHfM/p4FGIGofu1WSyKi9RyKR1oVAH3lHyI3yoEo21oPKfBiEr8AnCziJEg17+d6duWy0QCmZPGqCBLfN3KkA37211juYff2qvZmVodOrFZTJCt1IWITUEXSkzMrqdGoKgqChonbObit/f4Tz9NC2OU1hd/Qvx9gcHwhXnVhPabGIMlntzNiP34N+2ZRvrSHkegQ5+dynuOGzXMidABfKjwMQwRsVwhrf+RZDV1Ddjh00Zl4XfkjFraAwq091osSMqG/xsh9kJ5f0wuLdPRuZhk8aB4PWhBSuYd5QLVEKIipQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yGr2Z9sqmZh4cojztcKkGkFL8NLY0gWLf9f7OmFQdHA=;
 b=b1ZNCwxbg0gxjAZOUVzgHg2UbIdapLj36wuO56oIWN2dm8rA3l8mO5iiRhNsT1lCHXmY04oME3aO45Wx1XNJORahs61U3v3SFp1bZyrBhKfXj0g9Len3XKRlTRx56ioXJCjXFi2O5DCOfIyAde3FuWSUtFGtfykNGL29jni1gKtzJmxaakM6OER/PFTR5L8X+5EqsMvhjGK5600iKl6JqQ0Xjyi2Qz5tsZ7vlCe0QgFHRHDZKtYj6HCEVZJ8yIXzWM3adgILqqXYN5LnI758ykRYbCRrMLznnj4tjjXrg57RauBNtV5Mb4QID6pHxXCpH7okI/hzntL/uP3uiHKEHQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA2PR04MB10409.eurprd04.prod.outlook.com (2603:10a6:102:415::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.22; Fri, 24 Apr
 2026 07:01:10 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%3]) with mapi id 15.20.9846.021; Fri, 24 Apr 2026
 07:01:10 +0000
Date: Fri, 24 Apr 2026 15:03:45 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: =?iso-8859-1?Q?J=FCrgen_Gro=DF?= <jgross@suse.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	xen-devel@lists.xenproject.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH RFC] xen/swiotlb: avoid arch_sync_dma_* on per-device DMA
 memory
Message-ID: <aesV0ai8SM89cb3j@shlinux89>
References: <20260415-xen-swiotlb-v1-1-de24eda3c0fd@nxp.com>
 <f6cf1d46-9d2e-4b52-a6b9-fb45d01b874f@suse.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f6cf1d46-9d2e-4b52-a6b9-fb45d01b874f@suse.com>
X-ClientProxiedBy: SG2PR01CA0120.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::24) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PA2PR04MB10409:EE_
X-MS-Office365-Filtering-Correlation-Id: bc8f0303-5185-4b93-8be2-08dea1cf43d2
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|366016|52116014|376014|38350700014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	B0Ryomm9ILjLwzc2JpMtG8XWMGSGT7VPt4mF8rDk6UCtvYXPNj7Hukqp59n5wEq1ZPZLWaH/x/tUB8J3rvNxfQqpJeVGIhDKwPeX715H4yfNvkYDyR5ylsneJFSywV11t7oVojv9Qoo8Kh/n5oLnhwMUQMq3itygS+HLwwO8ZkMN9ZCXieSrIcL1LII03zE5CyFyCXAN95GDvXWnd0qsAnonXoLhkF53/Yne/sO4RTkWJY23XxIhuGp2Dz8NasitzgqFSuPKTBXT4xwyjEtrOZgSxPn7mzVWusnyNgagL4WCYVipTt9DWiiETRlL2mk0VEMZFQNEQIg3y7RUlLzGoA5Rz5NxwgVPb9dqrnI1VPjcAtagd8JnXDMBJZYT/kX7Jve4sXRmMQOSufgVMZgUNVIk2slhPh8w5pUvXa7B5DuvWvsggNmFspS8POZNWp+/eM5Itlqy9HSh/z422PGzRJifZX78BbaNuQemGzF/5mpOHCieDP4xflbA+1afJtWYopys2wBVVaw2/6ixqbSL6ZZVsVttmKSeks2YTk6zrq76kR+lf1/8LKfUFd6jjn3/zN4Kp1nqicSMDuGAbq7huGTonPGAgK+oSxje76Kh3181Vgl5BmZWcLV2sIb9CDST6UBKdjzVykYvHxqq4OfKSaG4xSTgfm7g+JhMx5KA+7XiqaOWZbhpk8PgoUmvaAU19WNRzaJGnL3805+kVHbB0/RpIM+WBZ2pQX6RFDYfJ80IYI8mYcI3TTcm1GWXHvoMObKHVdv+OKDkjI2SRFS7RtTobzDgjjodGlC4o993/VA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(366016)(52116014)(376014)(38350700014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?a8+nYhl5q7cDIeF+1a7B5U1WZwIHon3qdjbPZ9uW5BPhQbuMVXm5yqLy4s?=
 =?iso-8859-1?Q?OuTlRejUq/XrF69Chv/fwzxYphXohqJ7l1Lrk0A8eQA3+rMCZ2ja43aqRp?=
 =?iso-8859-1?Q?MPdyOaAuJXemrodo/OVtbeG7TfaQ7gtaifVaVjBlHtmNarUh+IxXYbPFWY?=
 =?iso-8859-1?Q?Ksz97qYLtcnoCZIZFmY/T9rWUKjojqhgisU1oWsjkZdzxzjs/0cgXiHD/P?=
 =?iso-8859-1?Q?ite3lV7o4iYBuucG2mzhnAv2CiN+8g+p2ARQqBTN0AXcAIaDMdDprrjKdd?=
 =?iso-8859-1?Q?kM/LcNCokMUSIWQtQzaC3DkJc9gx5T03+QJmL4TE880EWKN1ML4d7EtIT5?=
 =?iso-8859-1?Q?5YrfMEYmQynGXGclzP9L0MueZAfV82qTQlhuTzDW3D98dz5I0yKYakTgUS?=
 =?iso-8859-1?Q?4VS+aVofDfV597EK5pkIs/WJE5ajB88Jjaz1m9c5lyqeuXVZzXi+sszcHF?=
 =?iso-8859-1?Q?JRj+Ib+tYbNFGG1rGa2ZT4QGVWKi3l1Xo5o8S9Wec2C3PCjE55BNYZPbCd?=
 =?iso-8859-1?Q?EUv8r9EurrTy0SJ8h2HjVt8zr31dPcE9qTuQuzuigIaUOjPK2dBLFH92cL?=
 =?iso-8859-1?Q?WXtqTpEAcnZlLHxpsZM0eKzYv/JFzYkHMAYHB+ul9klTDFsIM8A3ntSTki?=
 =?iso-8859-1?Q?ky3XmABgFpfoSWAAPTxVfp4rN8pFqNeeGLcBLOupMcNH8p0y9mNAyaNO1n?=
 =?iso-8859-1?Q?47WxoTHNHPi82feeQ8FIbb2rDPds0Hw94nXWmQS7sxjcB7G+ehrru2M401?=
 =?iso-8859-1?Q?tUICXXCJpy1eTVKnkEMU5pYx3GQ3S/SrRkouzmXRpnpo/b2pCBoZ4HpSuI?=
 =?iso-8859-1?Q?yTmJhUHarod5Q2AumbyrJt/PvrdB+GF8SjynylYXa6Vgl+LAZnzC58j1+u?=
 =?iso-8859-1?Q?TMqyjOG68pLocfS5q/rZcfFy3XsUktB96CfCpvDu4YJzfQ9FAMww48R/EZ?=
 =?iso-8859-1?Q?wxLKgpn6pNMU/lyr/rpRzopNmVQWRmhQhR5QWx7nNbWp29lMvA76Mu6mCj?=
 =?iso-8859-1?Q?Hbw1aUz2gNsE3/ofMdroUs/YhBU+7r4NlzwA3v2h7tm/p5CV4EkoFwXfGI?=
 =?iso-8859-1?Q?O/oMAigYPjF0tHWGzakVIkaTf4QQ6x3kFuCDpuHbAFb+GbkgJzH5XK27Bj?=
 =?iso-8859-1?Q?ii4mQwT/VDNNJxaWbRUPjY3vBu+PkGqk9K3mnOcfhsnQF4s+PAEbyQODX3?=
 =?iso-8859-1?Q?9Er2beVtbJ0BXDazwkZvr+joXnd+kwndonc4WXmhMJ5M71PMRlBXyyK9wo?=
 =?iso-8859-1?Q?6jp5dEbKLUd/nW0XQqmfityHqh61pilq/Q4VYsv+GRC3oYWNvphbieVRcY?=
 =?iso-8859-1?Q?CaieAbw5e4p+9Kzqy4YQnJERC+bqO0dV+Xfy72zJEHDjR+6b+cLKlIvWM/?=
 =?iso-8859-1?Q?CNX1evFEnLQ6RsXS1hbjVOy7u+pIfrKdMBEcl6qaC9Z4pAZhlF3Hr3wOw2?=
 =?iso-8859-1?Q?/CNSiN3uiHBzs8rTkgc0Il8VoT3H2jYK6az/cGai/eUSx4Iif39E+OxZgz?=
 =?iso-8859-1?Q?+5dPRDhQfeOzcinK2jgWctko7BsostCXNanc160+etav1PvdzsZY53ea12?=
 =?iso-8859-1?Q?cD7Hp4Ur57VwXIKro+OaI6NcPVv4HMhVsHVDD5Fe3NdT59XW48E5J24VZs?=
 =?iso-8859-1?Q?wbOjNxgdUkLUvJyhTR4ZRP0cgsAAletV84p522wa5iVFJneVUQp3/vWTBP?=
 =?iso-8859-1?Q?YoktUT8JSJE0um3UoziCtJnf/nxbcogPAjm6BWEvwD2wHNvM+knouXDT0X?=
 =?iso-8859-1?Q?Z41eyHOVUcgY6sVBx5M1gGnNRb0kTiB0gTqqa9vIV9ghUUsBLsuOpjC8QH?=
 =?iso-8859-1?Q?s6j/4cp7Yg=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc8f0303-5185-4b93-8be2-08dea1cf43d2
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2026 07:01:10.4403
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RMKcCOlLbrk1wDDTOCW6LCsj4Iyy5vkraUDNrAjRY4tuYjtqbSZaFzG/DWZs5sb6vViwHT8OO8+5J6jxcnW/Fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10409

Hi Juergen,

On Mon, Apr 20, 2026 at 02:19:34PM +0200, Jürgen Groß wrote:
>On 15.04.26 17:08, Peng Fan (OSS) wrote:
>> From: Peng Fan <peng.fan@nxp.com>
>> 
>> On ARM64, arch_sync_dma_for_{cpu,device}() assumes that the
>> physical address passed in refers to normal RAM that is part of the
>> kernel linear(direct) mapping, as it unconditionally derives a CPU
>> virtual address via phys_to_virt().
>> 
>> With Xen swiotlb, devices may use per-device coherent DMA memory,
>> such as reserved-memory regions described by 'shared-dma-pool',
>> which are assigned to dev->dma_mem. These regions may be marked
>> no-map in DT and therefore are not part of the kernel linear map.
>> In such cases, pfn_valid() still returns true, but phys_to_virt()
>> is not valid and cache maintenance via arch_sync_dma_* will fault.
>> 
>> Prevent this by excluding devices with a private DMA memory pool
>> (dev->dma_mem) from the arch_sync_dma_* fast path, and always
>> fall back to xen_dma_sync_* for those devices to avoid invalid
>> phys_to_virt() conversions for no-map DMA memory while preserving the
>> existing fast path for normal, linear-mapped RAM.
>> 
>> Signed-off-by: Peng Fan <peng.fan@nxp.com>
>> ---
>>   drivers/xen/swiotlb-xen.c | 17 +++++++++++++----
>>   1 file changed, 13 insertions(+), 4 deletions(-)
>> 
>> diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
>> index 2cbf2b588f5b20cfbf9e83a8339dc22092c9559a..b1445df99d9a8f1d18a83b8c413bada6e5579209 100644
>> --- a/drivers/xen/swiotlb-xen.c
>> +++ b/drivers/xen/swiotlb-xen.c
>> @@ -195,6 +195,11 @@ xen_swiotlb_free_coherent(struct device *dev, size_t size, void *vaddr,
>>   }
>>   #endif /* CONFIG_X86 */
>> +static inline bool dev_has_private_dma_pool(struct device *dev)
>> +{
>> +	return dev && dev->dma_mem;
>> +}
>> +
>
>I don't think this will compile on x86.

My bad, I only tried the build for ARM64. I use below changes, if it looks
good.

#ifdef CONFIG_ARM64
static inline bool dev_has_private_dma_pool(struct device *dev)
{
	return dev && dev->dma_mem;
}
#else
static inline bool dev_has_private_dma_pool(struct device *dev)
{
	return false;
}
#endif

Thanks,
Peng

>
>
>Juergen





