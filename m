Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2062.outbound.protection.outlook.com [40.107.244.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED0F1CBE98
	for <iommu@lists.linux.dev>; Tue,  1 Oct 2024 20:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727813407; cv=fail; b=TIfnB6SELfFUJI6S08KKCsvBp+Rp75Vw417sPa07GbIXkKDHZl157s84zIusNQL17bkvY0MCixW6d4Wa+5RFrbhqUTUUe8T+bMUDvGIW5kRAVFUBPr2D2cAuPDqQyr21Z+ACkfCG5P6NALmVrgc8QJAXWGk8ceiFanc9Ub8v7UM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727813407; c=relaxed/simple;
	bh=z2M96eBnrSUIDbvYFcqz1LoiTUq6AiZ0wy4ZFlY13ok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FC6OgJnMhQsrqx4/7MRxASnsToVdLqeMeSgVihHeToo770IkvU+znS6/E6mGrMKQst496Z/c7eKxZ79wMAlnpx1YgON4bg+6T6lKk+1jXVxb0zyjrp03oBtXAaNELpLhjRPefimu7QVYYknllT41Kpl00Nt2ds+3lYEXIZ9rf3k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jOlBRxAs; arc=fail smtp.client-ip=40.107.244.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jOlBRxAs"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n/KcORBtxaP5DPtTUradF/zm+SBn7fXQ4V643avIhGQuybA7RbGDlD2ro9Zmofk7RznI+p1iHtehmhjv2r4grsoIdvUM9e03Cx63HYlgG4gOLbfKKHQ4Xt/CdX2zGDVE+TZ4sS3qQ2G8Ok4WJDBDwy7upBCOe4k1ML9bXvGgAdtPzmmawhlBjSFWtiq9n/h6pXKwV8nw5ZmEL2RqS0XdAEE5Mu3Cpmtu5s62spM0NyrgrJpENK3dE+djFcpqsX8Tt0wRO53QKy7ID9nIc/gR4ttqrMK0mXa39pfnh8xBiZXL5+DAddz6jzzQU5ChPJNVaXDltPXTSbVanjiEdbHWvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FA4VpkadtwIzo6qMuzhnFPW9mAEKtcrs4ircrKwa83A=;
 b=xzoTS19lqFOaL8/l7q/9MuBeXdm+GKz5FuFbLyN5jOinbr9HmpfH0RxpTCrn0dXjvoP4Ln3nbylXW/1ibVJXvs1yygnNPdmPPQB1hQSmWcW5aBOTSf3YF2HN0ypxdujXe7ewTszo2BgEBzSQyWt4eNy15d1XI5FHnrNNnP3q0Fwilrdwv9QlHQ5zZ+JM4726yY9m12dgtdBP5cIQ1ZWnIf4X2JoPUE1Nd1h2IaWPIBu8d+wn2tsUq/m59dxDoiM+HHp/5Rw3I2Pzj46OYFbHftFb86voV5rhtQMfles7H1iCw4LWzUtOFozJebU4fZSALnmAoMm5nanlKIm108TPVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FA4VpkadtwIzo6qMuzhnFPW9mAEKtcrs4ircrKwa83A=;
 b=jOlBRxAsyiV+scV16LKdpj+MLP7E0642jMfcfvxbSK5VIMuRqvHkCUjYQDFX0G50BBDhog07JObJh/fAOAGRplX8c8HxLY4lubzmMAUm8dRPOcAV2GCZSP79J4/Uy+5rpw4ajimD8pa33cjoVoxFzdWFBPMGryNKzVUmppmcm8hqUWw0aCRgafKYP9wLtorVThzgjTFQqBTIokLXuqcgdLXyUDmCaKR5ULmJ9DxpvtxJK8r68nGe10VaDz9fV/DsjImDiXzvh+P99FLdbHSw6HYwZ6XMLmQxIvBXtDe9UVr8L/mWJllsBzP+igAsw/Tn+2p590j1loqRJRt95YNWzA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DM4PR12MB7647.namprd12.prod.outlook.com (2603:10b6:8:105::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.28; Tue, 1 Oct
 2024 20:10:01 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8005.026; Tue, 1 Oct 2024
 20:10:01 +0000
Date: Tue, 1 Oct 2024 17:09:59 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [PATCH V2 6/9] iommufd: file mappings for mdev
Message-ID: <20241001200959.GN1365916@nvidia.com>
References: <1727190338-385692-1-git-send-email-steven.sistare@oracle.com>
 <1727190338-385692-7-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1727190338-385692-7-git-send-email-steven.sistare@oracle.com>
X-ClientProxiedBy: MN0PR05CA0001.namprd05.prod.outlook.com
 (2603:10b6:208:52c::6) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DM4PR12MB7647:EE_
X-MS-Office365-Filtering-Correlation-Id: 996b10c7-c0ee-437f-10d4-08dce25507cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?akS78OQoSzlu9w3JNFAuxYo61wq0L4fSLRMlnaS2ITl2OtBBBKzo/m9S1PbT?=
 =?us-ascii?Q?CG9LqBHdTSDKeJ/bH5VnzEET2xTEVEcjNMElGePnjtX2rf7qT7u15hMEgHKw?=
 =?us-ascii?Q?bgZL0BiwBUyu1lB6kzjJO4PpILHPHAd73If0r7Cwqm6LSl9J5xFWLgEgcGG7?=
 =?us-ascii?Q?vtHnLCdx1aoXcdyvqliOZK4gLMisx5DB3W+z19KQPcibaK6s7huHNRBYyfEN?=
 =?us-ascii?Q?VLI7l2pV1amCEMEZTtnu6okRMjSrIyKEnq5KG5OfqpR1mSUqVpd68wvZ/zNI?=
 =?us-ascii?Q?kdJuycO95E2CIRwqkryGYaNO5wc22B3Jnrsy94G1L/HeHWD5Gx1/p+6XPVR6?=
 =?us-ascii?Q?Q9mKycnpSXuGFoMgexVFiI3PrtXmJQBKv24jRwUm3ygbqDUwafLHaqOH/1gF?=
 =?us-ascii?Q?RASReF3+iu8Efc4Hd2euu+I0tOlKTT/ZwEMJtWYVC5CTob66LuFcaFbhwOaU?=
 =?us-ascii?Q?aH5nZOYl7JIEIuwq89TmR28kaSgONQ81d7msY3XIyubtxF7oFjO64u8SR+Pj?=
 =?us-ascii?Q?j/D3SNE20UQz90DYtvvuz8TnURp4/MlNwfXBcRztXr91bCsQxxpaTy5dW5Zc?=
 =?us-ascii?Q?rutchs67X2sq6SIYgaXqUg2UIU9Ie7EKscRZcg38m3x1m3kfFJrpUD8vmFb5?=
 =?us-ascii?Q?PHzsI5StFkR3JnuxOtfmZ7MZutZI117qs1uarA9OuMjoqemYxqCwiaf6k6Hv?=
 =?us-ascii?Q?+GaRohk+atHG5vGh1NF3JQmNQFov9jWtr1djNNu4zdFAFiyL4wGmGunz9JRg?=
 =?us-ascii?Q?oL474nxRmvQAvm+s095yCYrgAoblj9r73rr4OgpxQ/NSNJk8D++p3fEBvbNG?=
 =?us-ascii?Q?zYnFJZEOVTZKRMyVWzJn2zV7T3q7z+Kum2epMFclzkESOla5kB/rVBFTme9o?=
 =?us-ascii?Q?4bbc4Ntbm45K4Bw5ufsHvsTknsVqje1f5azQ7PoP7fNrM3kXEsxxb3/Fwk7i?=
 =?us-ascii?Q?hPvmzvNMlXkbxqnbDnBwybBkAw+ziMlT7L6z211O5RQafir21jUJYDu8G/qY?=
 =?us-ascii?Q?WCuGOD9682xeCVSVM61SZct1kv0fu6DyBGpgAy+EsKrA0yL/epQPt2OmjDxp?=
 =?us-ascii?Q?ZByUaIv0mVkFnDfFq+q4gaVefEmbmbjoZmvIg5mF67oVtZ0tnAHXWleXyuc/?=
 =?us-ascii?Q?VtQ7X+OzODxV0Pv3pdeAQG3gtR8ulOzA61fp4a962npJdMVdghgn0TZbQRv1?=
 =?us-ascii?Q?eautz3u8Oq9K8z2wULlcmZXgfvJjIq9O0nwOZFJxB5KJEs9H+q8ocWdQI7+d?=
 =?us-ascii?Q?GnL4vbqGtcXgg5K+F6sTRpXFFOVrzgUwOsEcNA0WFA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Mq3V7V3dgBL4F0ualsokcmt0mIMyDrdWuejqEdr+rEsDlkQQlbWCXGcxlvYW?=
 =?us-ascii?Q?6AiAtxClZmhLAFheNRuiHN/LPN6XMq/va8H3E+IXfJU7CSz4+f4Twf0FJ1Zs?=
 =?us-ascii?Q?Ytl/djiY8kHXuYyvorlokOnJLWP3tPGvbANOEiaditIFlYZV3Zl0MhV95Swx?=
 =?us-ascii?Q?zSRO/BLla5KXcElCqIhGo3/yCBn1S68ASGLVKv39sqLE8wl7RO7zaN8ZVQlK?=
 =?us-ascii?Q?G5W+IQWkeIlgxiJjl2AiVl5cY8ICBTnj0iKjklFX3TRmW2BBH+sJCGGy4laV?=
 =?us-ascii?Q?qFK2te3TaEBXa783lHFC9ZhKho3/4x/zgttZZwX+HJpISHhrgA18flCTT04W?=
 =?us-ascii?Q?BrDWz6Bnx6mWheIwlzxHHsWLxZm8FTHsn08cfAn0K0DfP0y5vyDCzHdA7IOd?=
 =?us-ascii?Q?nNJGIGvG7iGMpwsBUsuqifjOXykckyddSjf/FacIbGMHD/IMKpbTevks0iLm?=
 =?us-ascii?Q?3inuhI+b0W9FxBNKQ5RIockxxMaBzFDelba6+oXL51cvBpLuW5jk4uEBoiq4?=
 =?us-ascii?Q?YkA7Vx1ES6ogMu6XTzRjDA/2cELEIJJqKOTT9Ur0byDY8fvVjeFXSIO/k2aH?=
 =?us-ascii?Q?RxaO9ekvszfuiKJcViFCG73jGv6w01TZ4P2W9F1UfNGeE8HA4ZrPUk6+9/pd?=
 =?us-ascii?Q?f0Q0ruFJVL1AYvnzIYyaqXO70QOqjmZptDFcfL/cCX9piqnLxX4oGrIGPjU6?=
 =?us-ascii?Q?C+gRgBhWCefySjdyZu18L0Jhsj2FoOsxnieprwG2X/pi2Sok8V72OIYoGXBr?=
 =?us-ascii?Q?C7Updg71Gp84TLB+yetTmcg8OPeLkOiAcVc/bnYoYSs79vo4FTVGkTVNLXbm?=
 =?us-ascii?Q?d+1dSc+S7oHrVj93N4NjiuBpy1Lp9Ikww5olJCN0NzlIGksrRYCYJEify8bv?=
 =?us-ascii?Q?o+rEZdp7Qyn/8/A5v3HiQAeeVh6bC6tBbHezJuCCMrPTS3ETBUA0HhuMN1ca?=
 =?us-ascii?Q?Dx0qAzwdQwzAOQuJ76if6GFQnnSQwIpOOlryl7HuePqXv4qz9LqmK+45uBaH?=
 =?us-ascii?Q?Pu4YkBVCDTxWZx+u/g38AVB8tzvy18OHf4Xj1e+EW8A89qTRbsbphH6opwIg?=
 =?us-ascii?Q?ioGpO8jFloFwWC+f9YPeZsiQ+euSfK+tJTSZbnp3ufOlKG6e/urQkQJX9Qj+?=
 =?us-ascii?Q?hLqoP6K1S5SfPRLEhpDnbSzoS23nP7A3CtGK+7A+4UNQ9hX9gJASpgRAb4GT?=
 =?us-ascii?Q?WArVTpfUA8yOTOqo5YUf2iq9P9ee6fzAroyr6FcmopuEEskxzNbKRUEaADpF?=
 =?us-ascii?Q?sXLb3xmzYAzwsuyNMdemc9zBtuPq1pBAwYVTTqSqH2tD5o8tkZrehNHN5omr?=
 =?us-ascii?Q?ay/gzlTmThWrfobXrzqpAOff+XLwyBdnmbzuLWQ0r1Ho898bvHi59thbGJDc?=
 =?us-ascii?Q?vNxAmHRrrBo/CjLp5Ar6T+TIKzAWMMC/a1HpzZV/IpqB/3wC23uTlobM9Pc6?=
 =?us-ascii?Q?Ujlx/nRttCkhsYwDGvuD9gua0ft2b2vtJcILUxrsfK0GSWy8p09cVqL+LC2x?=
 =?us-ascii?Q?DdmOtsv46AKsJeZvqgKscq5kHmZ3fYxKZGeFSSpoxar/2WFKPVcKac3wmJ6R?=
 =?us-ascii?Q?TB0uVAHJwa9EZ18GT1I=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 996b10c7-c0ee-437f-10d4-08dce25507cd
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 20:10:01.2006
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ve7tWZqrYYnqGvO4+serfYTAVoQrsh9g6eFHRM9EkdkWzxwYcee+LIdKz7dUwcvq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7647

On Tue, Sep 24, 2024 at 08:05:35AM -0700, Steve Sistare wrote:
> Support file mappings for mediated devices, aka mdevs.  Access is initiated
> by the vfio_pin_pages and vfio_dma_rw kernel interfaces.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>  drivers/iommu/iommufd/pages.c | 22 +++++++++++++++-------
>  1 file changed, 15 insertions(+), 7 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

> @@ -1884,6 +1884,9 @@ static int iopt_pages_rw_page(struct iopt_pages *pages, unsigned long index,
>  	struct page *page = NULL;
>  	int rc;
>  
> +	if (WARN_ON(pages->type != IOPT_ADDRESS_USER))
> +		return -EINVAL;

You can can probably wrap this with 
  if (IS_ENABLED(CONFIG_IOMMUFD_TEST))

since it is supposed to be fast path

Jason
