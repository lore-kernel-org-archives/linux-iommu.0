Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010037.outbound.protection.outlook.com [52.101.46.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B964A33FA
	for <iommu@lists.linux.dev>; Thu, 15 Oct 2026 23:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792107604; cv=fail; b=kmtZ92Yh2dYDe12iPYmlhAci71Kra5dM7nydJMSJtlfQzt4QyIFNnBaBEtcqT36cmBFJDH0T/MFMix5m5AiNfGySphp6zYpQttvtGaMWgBm9PwRFR3d7/eljygRMA1sxrimMrsu1Ah+G7+wcfUqWkXW+dgtEZcHfmcuSf9109B4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792107604; c=relaxed/simple;
	bh=Obp01HqA5LVvy6eE+Zkw0QTx3AVUaLdVIN5IzHXpoCk=;
	h=Content-Type:Subject:From:To:Cc:In-Reply-To:References:Date:
	 Message-Id:MIME-Version; b=blnvfxUOAkU38k/iIXTrAt2Ty3MB68dOlg5N3O1rO7uZrvdcWZfBeD1FJdjnJF7YawkDKA1nuZATpYuyF0fD+jKoLS5jZyo0dN9FlPEcDwp4XR4uivdVjEyS+HRWGuTE5jA7lnnfhL5zyS17kKxJJgvZ6RF0NzXoQZOk6u/rhPY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kgjkPQgT; arc=fail smtp.client-ip=52.101.46.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kgjkPQgT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CFbdg4YWNUH++U7bNurA2J5C3+gcapbyudfaLskIiyfUORgG8c+LxrKY9vGWevFMddafYiNPlACwl+P0qWFyL80MucTiRG/8GE/bOB3LZ2f968QkQQeDkSfwKa/Vj8ijWPPBoVimwBl0DWTI3oKotSTdvj+P2nxPXlMjk4Kxpn+Q5D2PGgF2yHsaXkjEZI9eCOyFpKxwGwHptqyI9xtcxcXh3qgcYjhNA/c8PXVp3v6HXn7vutKZZt+aPPNV8RfLrAgkpoppFo0pBH2D7N3Vs3rrOV+wOiviVavSPC5bkGx2nvsu8vV2Mqddhjo+ZPQzysLXvYIZQWHM2eeC6WVy5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zfOJcN6/8uBHLXQDrd43AsF8zvGI8OFXzpF5Tz0H+Ik=;
 b=CLisKtDbMnAakVz4W78wCXknxtHs4SCRAT0NgHOo5tceAlQRVCodacP4JMCTfCdbuDdDgDY/nuyX6ed75fXeVfCcYYoiDqCZtaiRNu10hfBy7Bkle4MpnnOiruqipREWkRAvx/Vn1FZUfbowC6s6wH52NEkRmugGvyY6u5mCcfSn8wm783yKa30BrodFHXG/5tplpUv0WsoqBs5kPT7WyQ8v7W29vlAGivm3zEpGgzdNpzdQ1QQVyfpzNLXxzgPpKyEfH8hBHgUY5oubf0FsbqW5HpEsnon5mfoAs7jHq9V2I8MTZE/OD2afrJ+g2tkyYB6XJOLrrWdlw2Yn5MvrNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zfOJcN6/8uBHLXQDrd43AsF8zvGI8OFXzpF5Tz0H+Ik=;
 b=kgjkPQgTA2hhdiT+IcA48VnYVF6jGMRhkmRPmtrTualWDKCPn6AkhpiFoo4gPxe6x/xvI7Y8c+X0xQiMWcsqHGe3m77PGww1DgXEJh3LrSuyomFuJ5AB8uKv2kv8+SyD/h7VatCTOqWod4ykcbIhTIi23Zq7/U8D3214b/B6+KkVToZjrV+ytDxgCph/1pwAal6tOzW2Smp63xjq3XcBHsWrE/cK8UWGwAiMYjZPo7zJ//uYF/lvPzu5X6C41QNPN961Vboexh6A36Y4akc39Ehbjo3+ux9MQzI/m1QCDHDQhl6HH9dH7INiiLgRA9h3VJzRZpDlRk7+tctGZ2sl4g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12) by CH9PR12MB209431.namprd12.prod.outlook.com
 (2603:10b6:610:315::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Thu, 15 Oct
 2026 23:39:56 +0000
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d]) by CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d%6]) with mapi id 15.21.0522.013; Thu, 15 Oct 2026
 23:39:56 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v6 17/24] iommu/amd: Program nested DTE and DomID map
 on attach
From: Jason Gunthorpe <jgg@nvidia.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org, 
 jgg@nvidia.com, yi.l.liu@intel.com, kevin.tian@intel.com, 
 nicolinc@nvidia.com, vasant.hegde@amd.com, jon.grimm@amd.com, 
 santosh.shukla@amd.com, Sairaj.K@amd.com, jay.chen@amd.com, 
 Ming.Shu@amd.com, SooJin.Tan@amd.com, chrisl@kernel.org, wvw@google.com, 
 wnliu@google.com, dantuluris@google.com, kpsingh@google.com, 
 alejandro.j.jimenez@oracle.com, joao.m.martins@oracle.com, 
 guanghuifeng@linux.alibaba.com
In-Reply-To: <20260930092344.5616-18-suravee.suthikulpanit@amd.com>
References: <20260930092344.5616-1-suravee.suthikulpanit@amd.com>
 <20260930092344.5616-18-suravee.suthikulpanit@amd.com>
Date: Thu, 15 Oct 2026 20:39:49 -0300
Message-Id: <179210758994.4133959.15105804722823597831.b4-review@b4>
X-Mailer: b4 0.17-dev
X-ClientProxiedBy: SCWP298CA0006.CHLP298.PROD.OUTLOOK.COM
 (2603:10d6:300:14f::8) To CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CHBPR12MB731189:EE_|CH9PR12MB209431:EE_
X-MS-Office365-Filtering-Correlation-Id: 298055f4-9a25-4f1e-08a0-08df2b159ec1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|376014|1800799024|23010399003|56012099006|11063799006|261009223027099003|4143699003|10067099003|18002099003|3023799007|22082099003;
X-Microsoft-Antispam-Message-Info:
	L3aIiQ92+FrEn4qJI5UVaxWTbRADaDpnjjvOIuNLPP76pIjYmJ9PE3Y+Bt69tJzL0/iDCaFQNVAU5xOMKZyOwflqUyunr0IIrA3lzhT1fcvlzNcKP0aO39rSz4HoVrPnVMCyzp5tWe6EVYhqTRVNRP2eyOghtvw6MuUOJe3V21TatrE58ZNsNtreti9+bWO8ibshq4/huQKHjTqaoTdAwMNz7otx2gnrZXvY+5wLk/t4axUo9JBxBcjAcgVckkengPaVDhOFcRvWpiiD5fTGLCfHN2l82rjILMRy4Xn5Eqtp9iTv7bP/J68YinbmRTiaPkTBYWqK+K6TFtQmATF5mZX5VMZB9Bym/NCCthexvLDOrIKsobMjMv3IvhWPu39WQrIAmSmi4lGQFmI4g/FUe9pp1Wzsz+fc/FI7lgWkvqsMsd8Sp1wPSsAZYlhYIdqaEm5Ru9lTBKyZ6MuC8dJPT9lRIa97ckKTMadMmWRnLHa/tvu4yLKj6++ACu9XIpCk83BbmM1AyO+EdW1Q2NcPiAon9cyoyp6lBb9np5F/naPfi30pZ1TbdRZahX7lJEIL0OHtUJb+nPKrG17yegS9Tx89c+XWVqAuWqcWFmtXKqD9UrETwWJ7Az29Tr7s/wO2Ywqkuvdo88mmt/hf2DXZ8D9TpFXwSsHMLqPBcn9dDAA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHBPR12MB731189.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(23010399003)(56012099006)(11063799006)(261009223027099003)(4143699003)(10067099003)(18002099003)(3023799007)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TkpjN2FGNFVGZmtDWjJJZDhWbUJTNjgyKzJnUnVqWlNXMUxiOFlGbFMvMFU2?=
 =?utf-8?B?SmZ3L1dvNnJNZ05KZ2MwYkpab25BUzNIUkJuUXlmZklMVlpIRDhGNWVtcnZ5?=
 =?utf-8?B?WG1jQ2JsTWtOQ2R5T0I1MmZHTXowdHl4blpNUEpOcktzT0Rhck9qSHRKSmRy?=
 =?utf-8?B?ZjdhWmh2clpzeVd6elA3S1pyVVNndGY0TzB6d0ZaYWcvZVArRnFrZUdLYlcr?=
 =?utf-8?B?anFYZEhoVjYwYzdIanVUNkg3MnFia3UvT1gvUk83aDRkQWtwZTFhZllyUWtE?=
 =?utf-8?B?Wm1zVUx3UGdKZzZXSmx0R2RlaFJGMFFISGNHdjFRZW9rMFRMSUp0eWhjSXBP?=
 =?utf-8?B?T1p2bEtKTjk3MElkWUM2Si94LzVEalpQQWxnNTBjZkFUaHEvM2hQaVQ3dkQ1?=
 =?utf-8?B?WFp0RzQvcmliZmNxUjcvQTh1QXFCdW9Ea2k5WURTM0x2ZjVyQlNNOG9SMFFK?=
 =?utf-8?B?L24yMUhIeFhMZDR1a1MyZG9qaEN2WUNKVXduNHRRWk9OdjZhbmd4NlEybWR4?=
 =?utf-8?B?cmJrN0dmMEZzUzNMOFNhMkVxMzd4WXdzMWdieVRRMjRmT21HaDRtRGxyZ1kw?=
 =?utf-8?B?U3dmZ3lJcUp3bUdLNkNhWEpnMi9rZzZOc0RTaWJqbW1uNERXUVMyQmYvVDJC?=
 =?utf-8?B?d29uZmhCV1NrL0FJVUR1K2hqVXVvaUR0ZmtiT3JEL3BBQ3RBY21zdjhhVjNU?=
 =?utf-8?B?cm1EV05LUnA4eUxHaStoYktjYURsS0xxRk90OXAxWjFCTUtRNkhhWUFzc29W?=
 =?utf-8?B?UHRPeS92SmdPczJhSGNabXQxb0xhSUZFZmdkMU1LYlVxZjBaSDJUcm5QQmpp?=
 =?utf-8?B?OW9MbkF3Wkt5QmxoL0JWY2RlS0pNSkFzZXF6SzVWUUNzTUxYM2l2SWF2aXlt?=
 =?utf-8?B?NHRwY1ZaRTJLUjlwM25EMlJVSDFBd1ppU0ovNFZ5UmhQNVkrNktLRXcwZkUx?=
 =?utf-8?B?M3l4VTV4RFVyWTRHTldWMWhhR1ZGNTB0NlhmUU1OdTZ1TE1vVUxEU3oyT0FC?=
 =?utf-8?B?V2tEM25rdmV3cXVuMlhFWTZ2d0FrdmhmMXNuSG4rNHlaZTk3M1doYVBlb290?=
 =?utf-8?B?VW5vN280ZmNTbkxXUnV4RkY4S2xqeVl6MUU2dlRYMi9VK2xCbEN3TjFPM21J?=
 =?utf-8?B?RUNkc3UzM2dpMTVvVGpiK2JtYWVEOTNkeFZlRDJIYkcyL3NFYmdDL1ZrdUxy?=
 =?utf-8?B?K0VhM3F1c0RzbkQyNTlMTUtpbWprcFZWL2JqVTV6MG1NbllneVlwbjgzUFNt?=
 =?utf-8?B?Q1E0YkZESHVGdkkybUdTWXBrQzJsV2s4b3dXbnFMZjdBMXA4aWM2OFV4MVd0?=
 =?utf-8?B?NS9YenpaTGR3V1Z6b2FKOVJNKy9hcU5BZ3BIS2ZuUU5RWXFwQ2Z4ME9tb3ZE?=
 =?utf-8?B?L0JPUGVwY3MwNExsQmVDUzFTbzhxVmt5ZmpqQysvemNtK3J0RGhyMWtvcmxl?=
 =?utf-8?B?UTZCVFlqd3dydWhSeFpWSmw5UTlLRUdoejZqTElld2RqdnNlMGNlQzdyQWYz?=
 =?utf-8?B?Ylk0L1puMXlPRWhvdVhsWFo5UUZrcTFlcjZNYlNZeU5BbHJ6cEtPeTF0RGNh?=
 =?utf-8?B?c2NZM0UvZlcrMFFhSkJjTTdMa1R6cjRidnJDZ0Y4b3R5bWZYeVljSjZ4eVIv?=
 =?utf-8?B?dUF3U2J2WnI2SGU3YWs2YnN5WEIxcVVUNHdSOXpTSy96ZzcxWklNUjNZbEtX?=
 =?utf-8?B?eFdBclJ4bGhTUVlVcWtnTzNSa2x4YXVCN2MydGlYcHNDUkxadllhaWpSYm1h?=
 =?utf-8?B?Yy9Gd3M4YzN3bWtYWG0rdDI3TG9uMStzZjBtRUozZlczN0srcmhyQkp3ZUw5?=
 =?utf-8?B?YXFXL3BNZ2RMTGJrUVJWWG9CalRuZlRSTUNNMmh5N05BZFljYzdOWEdDNHZy?=
 =?utf-8?B?WVhIR1lXdlduNVpuK2lRUERobmxPZjk5NjFjSVVzZHdPcEVHVm9scWttN1Vn?=
 =?utf-8?B?cEk0R3NHNzdnd0JRamdRUDdiMVpYbjdQS05OdUNRZlRPUVQyQXJiZlY1RlhG?=
 =?utf-8?B?RzU3MlVadHNvSGs0UE5wWXpHUmpSS0ZyRmhJVUNFeUx3QzVpajlmbng5ZC9J?=
 =?utf-8?B?TjdQRFhZdFR1cEVoWEVlYUF6cHd3clVNYjVSMXBnalY5Tysvekt6djdnN1pT?=
 =?utf-8?B?UC9RS2E5TGQ2elRWTEl0VFBYOWtlVmxBbVF1SDVxUTlIc3dVYW1vT0NsK2dx?=
 =?utf-8?B?emlKRHlhRHZOcGwyT1o0VFpUc1d3dDA2ZTB6cWJBOFJEZTZ6b1F4YXBwSmNL?=
 =?utf-8?B?eUJZcURIWTl3NFVhcVZEcWszQUs5S2gzT1pUa3ZycGlZMjlPWmNKVmN2OXk0?=
 =?utf-8?Q?vV0I0pi7iF6ovi4ijk?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 298055f4-9a25-4f1e-08a0-08df2b159ec1
X-MS-Exchange-CrossTenant-AuthSource: CHBPR12MB731189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 23:39:56.8396
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sEpOM28tUzilE6ipbG9PbW6YaMF5bfKCNIhLAcHY0zJnPo55kNzy+Bds8aZAt4xm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH9PR12MB209431

> [ ... 150 lines skipped ... ]
> @@ -251,10 +268,23 @@ static int nested_attach_device(struct iommu_domain *dom, struct device *dev,
>  
>  	mutex_lock(&dev_data->mutex);
>  
> -	set_dte_nested(iommu, dom, dev_data, &new);
> +	ret = set_dte_nested(iommu, dom, dev_data, &new);
> +	if (ret)
> +		goto out_err;
>  
> +	/*
> +	 * Program gdom_id -> hdom_id before the DTE is live with
> +	 * DTE_VIOMMU_EN. Hold vfctrl_lock across both so a concurrent
> +	 * last-ref free cannot restore the idle map in between.
> +	 */
> +	mutex_lock(&ndom->viommu->vfctrl_lock);
> +	amd_viommu_domain_id_update_locked(ndom->viommu,
> +					   ndom->gdom_info->hdom_id,
> +					   ndom->gdom_id);
>  	amd_iommu_update_dte(iommu, dev_data, &new);
> +	mutex_unlock(&ndom->viommu->vfctrl_lock);

I didn't find an explanation for why this is asymetric, or what the
overall lifecycle of the mapping is.

I would have expected the maintaince of the HW table to be aligned to
the gdom_info lifecycle. Establish a gdom/hdom mapping when the
gdom_info is allocated, free it when it is freed.

Instead we set it on the first device to attach and then free it when
the first sharing nested domain is freed?

That doesn't seem right?

> [ ... 24 lines skipped ... ]
> @@ -282,14 +320,34 @@ static void nested_domain_free(struct iommu_domain *dom)
>  			    ndom->gdom_info, NULL, GFP_ATOMIC);
>  
>  	xa_unlock_irqrestore(&aviommu->gdomid_array, irqflags);
> -	if (WARN_ON(!curr || xa_err(curr)))
> +	if (WARN_ON(!curr || xa_err(curr))) {
> +		mutex_unlock(&aviommu->vfctrl_lock);
>  		return;
> +	}
>  
> -	/* success */
>  	pr_debug("%s: Free gdom_id=%#x, hdom_id=%#x\n",
> -		__func__, ndom->gdom_id, curr->hdom_id);
> +		 __func__, ndom->gdom_id, curr->hdom_id);
>  
> -	amd_iommu_pdom_id_free(ndom->gdom_info->hdom_id);
> +	/*
> +	 * Restore the idle DomID map before releasing hdom_id. Every
> +	 * slot stays V=1; unknown mapping raises an event. Idle is the
> +	 * nest parent CONTROL1 map, same as vIOMMU init prefill.
> +	 * amd_iommu_reset_vmmio() only resets guest MMIO.
> +	 *
> +	 * Guest INVALIDATE_IOMMU_ALL walks the HW table, not
> +	 * gdomid_array. The pdom_ids IDA is global, so a stale V=1
> +	 * entry can invalidate a recycled hdom_id that now belongs to
> +	 * another domain.
> +	 *
> +	 * Detach does not clear this slot: hdom_id stays allocated
> +	 * until this last free, so a lingering gdom_id -> hdom_id
> +	 * map cannot point at a recycled ID.
> +	 */
> +	amd_viommu_domain_id_update_locked(aviommu, aviommu->parent->id,
> +					   ndom->gdom_id);
> +	mutex_unlock(&aviommu->vfctrl_lock);
> +
> +	amd_iommu_pdom_id_free(curr->hdom_id);

What is the protocol for flushing the hdom_id from the IOTLB?

I can't remember how AMD works, but generally it is a good idea for
IDs in the IDR to be known to be cleared out from the IOTLB so they
are always clean. I don't see something like that here. Is it OK?

> [ ... 49 lines skipped ... ]
> +void amd_viommu_domain_id_update_locked(struct amd_iommu_viommu *aviommu,
> +					u16 hdom_id, u16 gdom_id)
> +{
> +	struct amd_iommu *iommu =
> +		container_of(aviommu->core.iommu_dev, struct amd_iommu, iommu);
> +
> +	lockdep_assert_held(&aviommu->vfctrl_lock);
> +	domain_id_update_unlocked(iommu, aviommu->gid, hdom_id, gdom_id);

A _locked function calls an _unlocked function? That's confusing..

-- 
Jason
