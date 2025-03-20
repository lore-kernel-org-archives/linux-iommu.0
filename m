Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2061.outbound.protection.outlook.com [40.107.236.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38F516D32A
	for <iommu@lists.linux.dev>; Thu, 20 Mar 2025 15:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742485021; cv=fail; b=bDj5EeNxU8YWiGWgACHtgIL6F8SzzQtnao41s9GHS8XLWW/BJs7jltuXZuKSiamKZV7Vqv4fNeT7MeVxsuS65tHZrJTizkZ5+pO8gmhOXtNenleq7EGmNJyUzVATl5TSyQRQtcjlv7DKVINzcdwCJh8qBMXTfurMn1zj9oBMz3U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742485021; c=relaxed/simple;
	bh=kirXtMF3RruHLU5s299U1F6IcpK3wETcqRp+NMW0884=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=O9vBIHHPrSCIR1oYAlKOnzOOeuZpVZUMRmGrdB6CZpFoV9Dh9/QOwbjT2Wr4c7Cyzp5GEZjsdMI/LFGOu0UShVb0OX7voDuC1ACqon22cX2rgF9sl1bAGek0s7TZG0eroS98hc4xhHCSKxELxWPXKsKspT/z/zBbtM/5hP8LpZQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mHNDiB2P; arc=fail smtp.client-ip=40.107.236.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mHNDiB2P"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AWfGGLTQ2MXgA2oznktFZP4xTKdH1gKmf1larlksgV7VFu63clE32uxpNkX6cODSw0nnuynuDO3DjyFHMXm3ilPi3a1KVlSYlqO9gnv1qnWKIUDyQbut5WQUnU3ATohRExDvY9ZPr+saL1k2y/eXcWsjcomCT1lyHwJlpHOpPy1bsODU0DOC4pEjCAyaWQhWFJEqo+6CjwiiBnfsTq8dHLWh1zjrce1zyAL+lv3WiDcY7ywkI5g2W/YSl0OhEULVOvd2X4BHHbMjvs16h2OkUI52Pbbb8xsPRseCQHAx4lL1lWNk1sOgnOX/KVKNjtXllfauzBaNcbN3gXUdXvHALQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TcKkZZSUePXMMYtOQezatx1SyYJ1rrufEKO4QZ1FWvI=;
 b=Ks7vWZS6tKcWtJX9wVBRsnFgJlUrvyS/Zwo/n/+KHv3LwfO56FirUbu+TgLgTPC6TqyMxjf2JGQ6VTRMaJ0Iu6Ho9nkcPdnkMcru6hb6du7M/IRJrJd7+CUea+YP2KHR2LodQrEvCc/7b8vyGRYmllRLyFPqunXzXpGNI1713bNQIh7ZdNwUY5m1KQr0NQCMmbDY8Y9hbzINq6QOZikPTI0LXGygkNAFAJ6kkPOQq6r4j9EWSgrmmoBAGwv56xUzjUPNioYV/0tFcoECdTInb2NYqmFnv2syhFvQiCwLEYbqPLMMHti8To6sKQ38AN42J7GiGZ4T9NHXmUtVU9Vyyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TcKkZZSUePXMMYtOQezatx1SyYJ1rrufEKO4QZ1FWvI=;
 b=mHNDiB2Pm7cv64PvgFfIA1Gg93IzyHeVstG07G5QRvlVkpDf9dt7+po8MuadYy3YrCS4jWj5aO8bmJx7ULnCeVvTT9kAyNwcJhTdUbmEKQoIqMBzN/ObzEvlg3uq+fj4j05a2HQhJM15y6wQDhCUAMygFS8TNsXX3VrglAE6ShthwAY65ZT0jxH2LwLwDW6cgIDRuZRAKIv5eihZLe1B4+1mXq3Kaiq+yWMz+e7aJ4X9OYhv0aDqxzAJw1vxxpcXVRGerck99zsHEBILhsbYC/uOZH9evY55xBagVgYk/nIOsWBNq2H7MJwlh2kzv1+eYYnfIIO27e2Et8utUurnNQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by MN0PR12MB6175.namprd12.prod.outlook.com (2603:10b6:208:3c4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Thu, 20 Mar
 2025 15:36:55 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8534.034; Thu, 20 Mar 2025
 15:36:55 +0000
Date: Thu, 20 Mar 2025 12:36:53 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Yi Liu <yi.l.liu@intel.com>
Cc: kevin.tian@intel.com, joro@8bytes.org, baolu.lu@linux.intel.com,
	iommu@lists.linux.dev, nicolinc@nvidia.com
Subject: Re: [PATCH v10 06/18] iommufd/device: Add helper to detect the first
 attach of a group
Message-ID: <20250320153653.GZ9311@nvidia.com>
References: <20250320134744.5777-1-yi.l.liu@intel.com>
 <20250320134744.5777-7-yi.l.liu@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250320134744.5777-7-yi.l.liu@intel.com>
X-ClientProxiedBy: MN0P220CA0008.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:52e::7) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|MN0PR12MB6175:EE_
X-MS-Office365-Filtering-Correlation-Id: ac78f385-e3c7-46d4-788d-08dd67c50b10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SGgt8UjLHW2vF8hLOw2kGBzTAPJb+3ztbsgmIyswX0VaLWACZuoS5ooaeqsn?=
 =?us-ascii?Q?Hmgg4jtBH1XyRRF8dLNNDKiEHI+ErvDzD9M784hS46uWKiJNAOfqgkWUcAYr?=
 =?us-ascii?Q?p+DMJUC3TS+yh0hreM68529QU5aQDaFhmJT2h5vvIIXOPQzJtobc1r3YnpAq?=
 =?us-ascii?Q?7KXKUNdSl/wISW8taR2TpQ51ac0/X9ZzsF0h+KTBDl5JAisCRMTcRf/z0yOT?=
 =?us-ascii?Q?Gs8pBWfpHB0vUnlaOlNpAipCmEGL0le13zG7wHzQPpBQJUDK7PihRPrl+pxe?=
 =?us-ascii?Q?hoVdN4/yVq0kKXBT8C5xYv5BjSjCYAXctsJ/88E25dYlaR3u5gf4VwvCb8Kr?=
 =?us-ascii?Q?J2fNuiR+9SMscFNYyGobk4fIFhIzCBdagspFv2H7eASbGql+wwfSMyhl5fZw?=
 =?us-ascii?Q?ybXc03SIq4DSupA9qp/Zk2JJtwAfcl37BfMRuGigmsmeWGHiPNLK48s62+oL?=
 =?us-ascii?Q?6jcFQsV05qBkOVWot+R5QoL76BegI8xxBJ8cZV8LUk+9f5zIS2WfHnfvL8h1?=
 =?us-ascii?Q?sqELPh065xZN/k62vsyb57nmEwEfPms8a4b8GY6ViUHyHGM4QCArCkVcUeW+?=
 =?us-ascii?Q?IrJtjLWL2eRMR38GX8dBdfJjVFGbRgU8brVFmOHCLbpsaRK6dCOS0TAN4zDV?=
 =?us-ascii?Q?OA89hng0XlGqdUbYUT0YEbiHo5UHQKO6i1MYyxPicujssUN01eiJj1UM9++m?=
 =?us-ascii?Q?MC91s4ncQw2nh8pcGJWU3K5hxlusZNAsNT3/8MFxPU9kAMUBQVSsQhH9aEdI?=
 =?us-ascii?Q?n9AS0n75NvRT2mNymuBH1JK8AjK9wJZ7rQlapdQPU5lfJJbavw7d+7kWd02j?=
 =?us-ascii?Q?5ybZTX8YnNh/ZBwRP8mtj/y8t1gTkXqR5qxY4JlachwMX2q+x8bhJllAV3H5?=
 =?us-ascii?Q?n//zr78WKKEbI6DtA5HzBsdaFQYn7AdHgHrVoYBavkZumfDmM9QJb3bez83U?=
 =?us-ascii?Q?zvXZcCLp1SLB5uauCtjqgEDO0ogBZBtXYGLeDKRxX3iulpnibb5BrxFE/4xw?=
 =?us-ascii?Q?jsHetCzy3szRjU/JIUAfda4/k3BbUgDkQZaGtGPBRvtZiMM28ShPKalkqeHz?=
 =?us-ascii?Q?iG+q0h6/0xyFQlimeTpVzD9zPe25pZ3spFwAaHzB5XQFFLutetoyeBvkiNrs?=
 =?us-ascii?Q?OlvhgIQcbmm32QPtrxWHS8WGIsLDmsaO4evBH5sz0NG9h95+i/w5pK2d8YrD?=
 =?us-ascii?Q?f6dBUt08vdt1KlcXC3uJDGb4wBmVbKcTC+91e/bFxov+GW6GibrFYpKAObou?=
 =?us-ascii?Q?HGCF79A8BwutLpFUQF9xLzawxrwIUeYaf1Ovb8Lz4LrUKeb/dsi2HCw5+Ohq?=
 =?us-ascii?Q?i+BZTGQ9ofhT8vOT/ur6rerNtLVOyg3b9i1q/ePW37Fxb/zTg++UG9cu7PSv?=
 =?us-ascii?Q?g4V8eP+jsF94o9R4hclPzqMyMEHz?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?L6Ey57Q9u0S1Ck3Gbvzp1Eq283ZlvU0Rcw/Vli0N5jai7Kx3mA6rsRfuPlWG?=
 =?us-ascii?Q?8eAlyuzYwBqX1+41bQJWe+Ndykj3pDxWp0czhvo+R3x7joVwooLfZwJNy7tT?=
 =?us-ascii?Q?TGCiGGhOhFaqmeJ2yBwUALBSpZeOiwUCWdeeUIRJv3qhDYXZSBp2zDU5Ciw0?=
 =?us-ascii?Q?6NrSej7J8ko6psEC+Ld3oidBXDXorThcnA2UFyLhU+xYO1l2/niTujhLYse1?=
 =?us-ascii?Q?sM18io2WEc8C54LPFklhYhVWl2rKnwfEjHz00smnEHLP56N4+yOSQREeBgNM?=
 =?us-ascii?Q?E3j89hukcBN+b9/DqGlYcPuTHT0FgjUW1DUbLutgZxPaIWLWzY8PQDWKOmVr?=
 =?us-ascii?Q?g6fYKb+gVA8mZlDc3Cj+9AJq6mJqm9AK7/9mvePHdv6U6a3iWDTxcVFXGdst?=
 =?us-ascii?Q?iS6nTGYNXJrgs7n4IHhbGoftCLecJs29IfxQci0yRHk0vHBfpaGj4eRxBc4j?=
 =?us-ascii?Q?GzZcdaxYCK8YO8iSXQZ0IMgD9Z5Yzi9b06Wm0N488a5gkNTobpCL68XABANj?=
 =?us-ascii?Q?4diXuGj1xd45QiOvDJmTzrpCanMjTOTRLtWSQq2WSowX+mb64Xu0gwF9yjgA?=
 =?us-ascii?Q?SHi5iuNEpF0HsacfNqJlh/z4uBQxhUjtfDUIzyk9FrU26WdJw6BA6NT+T7DX?=
 =?us-ascii?Q?KGp8HjjKfy6rL0WQ2pXcut09nAtsm/BLCM6ztH/AKz9VoJ4Pn84PKwdFZzoh?=
 =?us-ascii?Q?zDNUpRUIbtmA8czn8Emb9vB0zhjRgI431civHK9SB8QB2EfO4+iqwqO7+o+T?=
 =?us-ascii?Q?h1xBqkugs9MRDKlCteLgRDpZPzassiTL3ko+usHcCod2FSMezcNXdN9Xxbez?=
 =?us-ascii?Q?ZS0EVtmkDG00aznSAE08+vtaCqkcDDh9bGg70NtQkNHK8oPqL+RTdMjuuYx2?=
 =?us-ascii?Q?Q0xqwM1yclaLwpGWt1RrVAUniEUsNzokP3JNXM8SB1bMy0tK6gDJj8a9GzHR?=
 =?us-ascii?Q?E38jWxHzxzvsaPKK7M3ml2VEdoi2JVzC0Hxpn79qC2lU+KoD3wpTHSYY251w?=
 =?us-ascii?Q?CybH1rMSrxOfTyDz2KCstgwgEAbqVXoQmN+U87xQQIk90QdfqU/398SOoldt?=
 =?us-ascii?Q?IxxOvKeCmpgWu6kHF04MnYcj1tN0j0WTjROz0ZpvI4XPCzGhBchavPyaC+IP?=
 =?us-ascii?Q?PyNghSPA7+hzUf+aEjNSNW2+8SwzFkQn6SgfZXiHYl66+nfE6YVcgzBvXBQF?=
 =?us-ascii?Q?ssTucltNI8x7oLVsALI3Rj9kgCqa3GcJQJ7ODhkkGKpxTQu3/kIiJ7AEmGPQ?=
 =?us-ascii?Q?Dcvkj9dNFbES9QkPDEkTRrM2EXFl2TGo/xUhV3ljNy/c77tfszq7kLjDHxrn?=
 =?us-ascii?Q?P2+5cvpwkIoq0ZU0QRWnMEWW3VU1hDe/SnAkk0EPVMDj6WVE9L1JLrLHKe18?=
 =?us-ascii?Q?kwmkHx7awebankYCUTdFUyX+Xcf9+o4JU5oTnUWlGAN/kt7v7Biny1w86nNy?=
 =?us-ascii?Q?H9SvBMIY+O5kyXGRB5nG7chwBpy+WyHqllKVy5CzUWd3pwH3W8Xl5KSnGclC?=
 =?us-ascii?Q?CCRTzq5GHw6m5mgiL3hBrZJn9CMyKR6GWF5qrvxJV1BLnJdsiXoM8/C21ysW?=
 =?us-ascii?Q?9881hibwNISmpC2hW8D40TX7eMq4vS0xY7qM7nMK?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac78f385-e3c7-46d4-788d-08dd67c50b10
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 15:36:54.9750
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e887ehCNkjg6jcXdy2a61CcGi8oUC5aK0jmQrIcQf/MvC50RTK/ECVRHpunVwYiS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6175

On Thu, Mar 20, 2025 at 06:47:32AM -0700, Yi Liu wrote:
> The existing code detects the first attach by checking the
> igroup->device_list. However, the igroup->hwpt can also be used to detect
> the first attach. In future modifications, it is better to check the
> igroup->hwpt instead of the device_list. To improve readbility and also
> prepare for further modifications on this part, this adds a helper for it.
> 
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> ---
> v9 -> v10: It is patch 07 of v9, it's reworked hence renamed as well.
> ---
>  drivers/iommu/iommufd/device.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
