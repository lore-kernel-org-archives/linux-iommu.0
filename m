Received: from SVZP279CU002.outbound.protection.outlook.com (mail-norwaywestazon11020102.outbound.protection.outlook.com [52.101.180.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C30D2DA75B
	for <iommu@lists.linux.dev>; Wed,  1 Apr 2026 10:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.180.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775039812; cv=fail; b=G8hEnMtb8W/CT/LUni++iIMyNtKdz6oT0lI2h1fSkCVYSGAOS1NgqaQOvO6inil1bxjTkiaA0Ij7hK1zLKctVOssHZ5psteBI+mwpDn9vXI41IR+wEoGWIcS3yS/FnNgT0g+c9bQ/KQoBTuP9Atkwq2+XuwTHJwewNZmuLApg1o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775039812; c=relaxed/simple;
	bh=2XEKx3qeXVfTrSzeZ025bFLvMm4isBGquK3fAUgWlCY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=n4WW09icNmCQmEC+YmW3+C4goPPO8rT/XMtm3jbwE+DMNRzo4s7SM44feoKvziC5luiXuHidevH+UI//dQ5au3Q0o+BpCPPFEeoLaYv64QDVJreHgY9PXUT4r5gP9ue5HMp+2KhvQMQ3xfK0XReHN53tT7Hc5lSAnvLcZNDZNYY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolphinics.com; spf=pass smtp.mailfrom=dolphinics.com; dkim=pass (2048-bit key) header.d=dolphinics.com header.i=@dolphinics.com header.b=QFwyr/+k; arc=fail smtp.client-ip=52.101.180.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolphinics.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolphinics.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolphinics.com header.i=@dolphinics.com header.b="QFwyr/+k"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cz36ay14t39UpMneHkOJfaIPJ0KlVeFTglIm58l4+5f7Jzax+dVkgrsq5OBl7E2Uc0vXXFAQxrIfWejEi8V9I9AvnKVxM66GZZ3kmhckeG8lwOFXBeu/BI9QNaK4N5nLzN1aGEwNHbCbXtil26DxUX2VWfNDtYoQtJbFbcJxd4wb59U3aTvB/+HYE88DYlwYwWsZW6pNH0yRRkFZffXLhn0yUE2R9j6fsWn27UmcwaAqcZSlcNgzHq738BnYE9xLc+XY2NgnwL8XoamWaHJbl98XvnC85uGhzUYbC1bbvXqql60PYu397z5ZbMKLaKdcSO+KTKrOFfpIzdhNhvu5rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WjHJOtwWrPmO6BdHv5IsMa0BMkeqVSdrFJs5zEkUc+s=;
 b=qZO3R+7zzbOpmvHWf+atf0IZ9pTDTGOMmCBg2kCWHxttWohzChfYdVGqWOyjzqLprAsaYRYg9u7P8X8hb0OVJF5U/JgWWBNlJNHABDXYh/ENe2E4quuOL87Q05HLQh/Cmq+bpYQsLTZt9oYDRFl5HoB4pUkH8PCSPmlk6iChRSa90ln7pvZceHj+tUFgTnBdV21+iUKuzEWfpBMJ8u9pkklAoAcGjBQxVrpGIsi4CAIBz8c7JkYwP+EFmz6TMe2/CQUv8nC9w7jBDnB/8hqp8/kF8NUj1ihFdLy4hKBDSceqLdZ+60tlj67bhSyqowd/Gae2uX6/lRZ/FjBmBMIWfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dolphinics.com; dmarc=pass action=none
 header.from=dolphinics.com; dkim=pass header.d=dolphinics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolphinics.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WjHJOtwWrPmO6BdHv5IsMa0BMkeqVSdrFJs5zEkUc+s=;
 b=QFwyr/+k8vhHwwaHj5Zl1YevvAOa2lc/PfkJg/GueOWq4UGXUaj4Du7PrnIQNmZE5JSwmMStUd0auN+i2Jk4WWdRRe7ZXFfM7HPl9dAUg/sM8i1udL93nmTbKuhQYDgcFZQL83OmO9W9aoYo51EZvxNsComxxdMbE0kZY/Z3nF9qBZi7KcfSuXo1+gWDcmo868Bwbc0G8huq4i7qslrCKfmguUNEYPtt0HMfukLh0XjBwFeO7JKVuUT/n1pOtxcEFF4vk9zX+BHmJ9B+gEOYAyp2L+cosswWEU15JvrTcunC0cSOlVJS+TfahQUPV1B9z97mE5k5O/zWPiwQrEcxdg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=dolphinics.com;
Received: from OLAP279MB0055.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:2::7) by
 OS4P279MB0620.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:29::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17; Wed, 1 Apr 2026 10:36:43 +0000
Received: from OLAP279MB0055.NORP279.PROD.OUTLOOK.COM
 ([fe80::c82b:8ba6:653a:2875]) by OLAP279MB0055.NORP279.PROD.OUTLOOK.COM
 ([fe80::c82b:8ba6:653a:2875%3]) with mapi id 15.20.9769.016; Wed, 1 Apr 2026
 10:36:43 +0000
From: Magnus Kalland <magnus@dolphinics.com>
To: vasant.hegde@amd.com
Cc: DheerajKumar.Srivastava@amd.com,
	dhsrivas@amd.com,
	iommu@lists.linux.dev,
	jonas@dolphinics.com,
	joro@8bytes.org,
	larsk@dolphinics.com,
	linux-kernel@vger.kernel.org,
	magnus@dolphinics.com,
	suravee.suthikulpanit@amd.com,
	torel@simula.no
Subject: Re: [PATCH v3 3/3] iommu/amd: Invalidate IRT cache for DMA aliases
Date: Wed,  1 Apr 2026 12:34:56 +0200
Message-ID: <20260401103559.63865-1-magnus@dolphinics.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <122231f6-3aa4-4f7e-a663-a182460c9436@amd.com>
References: <122231f6-3aa4-4f7e-a663-a182460c9436@amd.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: OS6P279CA0157.NORP279.PROD.OUTLOOK.COM
 (2603:10a6:e10:39::20) To OLAP279MB0055.NORP279.PROD.OUTLOOK.COM
 (2603:10a6:e10:2::7)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OLAP279MB0055:EE_|OS4P279MB0620:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e5191de-3b9c-47c7-686f-08de8fda90fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|10070799003|366016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	O7ayqL9rrOF+oTjmVe5Bith3KArTrhnKAi+dEOi44Oq7LdZAV/zEbrcqSnONd8DVTphDrql1QnuNPsOaGjqX9kGpHhPk5hifK0ogJal315VFMUmsnIDuYshNRC6nptoJDOejThTgsXV2NzBtXQN7oIjvGGUWqLUKyF4zyD4fZWUdY0X9LeEGaGSspbvxjBbiH96qA53QPGolu1E6wpjd0gANYpx2LK3ChMLQrs4NiP8/vaQmiqzZq3cFsm4TfELWnXCFbjwSd7oiFzIxdpnuZF93G8FasNuYHK7CdX5eAYNlIQq5LWvw2uRb5qooVpGhb3CskjLa+NneW8KtOc10zPXOt2Y9qTOL1CmD/RZbczsevehNYNB7d/BQka9oXwC68eNUDJSnyrE2bECoTqkK+LnbLaynkKWqZSFcHK8ptP15LNglD9GK9+zYMO1goH0y8i7/VuDk1xENWO5qvcb603yOD14WAhvak9VHpS6npe0ooibuSWH5lwlSgkB8HPr2ulkpYB90e8Ml9O7DidJw9dJaF7CdcV6j1EHqti1dCCgf7KOV7Id9qIXO3z8QpB2E3phlSa5kNEnT4xL8tkGR8SdvCO41C0K+/bCWDPqTCV/yez6KJv+vDu1grCBI2wklzdLU2CwOxmbUi9BeWqnWja/FsyPtmqWHP4tXJ3BfukKsGEity14PytavI0dB1SZ/ovXPjv3U8PmBjhZYpsNAimCZJm9GD6VzTCpzxpz+xZA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OLAP279MB0055.NORP279.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(10070799003)(366016)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?e326lK05TTLmgt4A8FHNAIBloU7OBltf+Vhh9WDmiJQuhNB1abqsujBMi2UR?=
 =?us-ascii?Q?dIsuOSNPqyleCAnVg4mKQzlJrFKP/IkEg5o47kw2xrGgO3jXceBc5FV97wDP?=
 =?us-ascii?Q?VO3MPNJs4dVH+/jpnaI7v39d5NMnFX0wlS1R8hP1t/gg/B62252m2N9gxhpX?=
 =?us-ascii?Q?5v2ybyJ5ud41BpUR+EKadfiB7N6yP97DzWWkRleq6h0sAsTxAeD6mAhJ95XY?=
 =?us-ascii?Q?kjrTRfdffo1SRmUOdLBVmLws8N0/TYfoZPaHRNojh5UlvqrZxMQllyl4n7/m?=
 =?us-ascii?Q?IOiQqetlfsp7F16NlWlxHQO70XAP/+V2gIPYD0tneTGfGP982NhSBHM458K2?=
 =?us-ascii?Q?9T/dq/gkKbYsldJCbk/cotDEIsK5nCnbbRSL2lNPVdL7hTQombrhIuA4qYFC?=
 =?us-ascii?Q?5kgXXsIRTu1EwgXDoxKSU9WxPw9T1jCaUBkc4V3y0vyqxFy7qQ5FbS/0oSrb?=
 =?us-ascii?Q?XXK9LoPnL9Bg4v6u+TNl6Ls3xjc+TGHJfWfCJVWOsYvUEBJI8DCnTEh8pJey?=
 =?us-ascii?Q?1pXDlz1k0KzvrZ0/qwInlI4jHrEJEe1vdJY6dfUmEH4sLx97752kwgqRg/Hu?=
 =?us-ascii?Q?VJZoLaDTUM754Q+PROcDus1ys7gtK01gpF27EsNsOniRRsjq64WJJT0WzBXT?=
 =?us-ascii?Q?w5Aa94SXEDM1/sz9QP9V04Ip21Wyd5VIxtQtNKMwDkRI3FhX2NsIkfdDCYne?=
 =?us-ascii?Q?AgafhmXSKAu1LR8vqZ5YYOlU/UPj2JZpKTnLTw6KSkqhWRuxPaTGaTHtnxLK?=
 =?us-ascii?Q?riOO25JD9zuDn3b/moh5Ijf8L3wUZQPjJ1c03V7UNlt1C+K07/CGAthagOho?=
 =?us-ascii?Q?Q9OKynflNWtKV4qAICSrJMPVI0b4UNwJiE8Rmfolh4tAu1niPX4oIUouTbCQ?=
 =?us-ascii?Q?GsPp/DQZm/p8O1/y8WTFx3rC9Hps6IYrZPSrWpVfahEdfN4KGsoZsphT0doe?=
 =?us-ascii?Q?brr8iRq2E7/dkXjJelZjuQVR1wmZ20oKmRuLg/NYy0GikM06t6A8zDVENUuJ?=
 =?us-ascii?Q?/0f7GI0wU5IaobztvU3WO2iawhgYtNwefbRP0XIILORqCtlPhWYRe5HmP2CC?=
 =?us-ascii?Q?Qv4FF/b3DgaWklwjn+oFbZb5o6HbZLV9H/J0v+pvAgrp/Y74QqS/8chAN63e?=
 =?us-ascii?Q?BuF36o2Cw8vmllwka7yNq5rxuvFY0L5Acl5AK7PTUNh3Xpe+KUex7H91Vyg9?=
 =?us-ascii?Q?vtRFbda6/dxZplndWfiiXrRM8SQYKAX1f47SjLGpKM5DUNZd37b770jJMroS?=
 =?us-ascii?Q?6rBjiMWAY/ORw7K5ZLp5/l0d/4QrqdhOldUSkmuMQddXhMhDOcLUiVP3g2Jz?=
 =?us-ascii?Q?r2NziDUHgljAn6g30vBiFBkZ5XUeL0L6X/H0TKLfW/EszTST69z4lJVDhC8O?=
 =?us-ascii?Q?76nfgAmWEOJ+d5WKXXkV9HzXEZv88j+rCQGJJqW+Xdc8Bdt8YWnRKahqlFzd?=
 =?us-ascii?Q?AFJsWgKSEpHqSUsO+jVOYhTlVUGXIeQCWEXgDEhvNy6xm0JQ99yuNZd/9Wv2?=
 =?us-ascii?Q?Y3q+o4xnsU3pACwSKLKGrb870idm/2pAYPk9c8wy3QI0Zt9NXUk1MgTeGsIT?=
 =?us-ascii?Q?frA72Xo7ZLPQu/lBJ6j3DmhVcYTSAx8iW8HtGJMe6fUVHz/yD1NNF6WcTvAG?=
 =?us-ascii?Q?N2OH4poEjsK+ytg/rcVw/ITvlSncNvjQiHX+EMK3W1KPbTlYFZXuzyKs7jnq?=
 =?us-ascii?Q?FvFdQ+wYpP4sITJsoZdX4si0gDj+zmMUpxCa4YtQFYlOWhDxZohPWZF33lBu?=
 =?us-ascii?Q?5y6ydQFsH/cJkKBAwT1+R3ECYDw3d2u54tXyR9W+RReIXWkFy8Xgm0mX6QGr?=
X-MS-Exchange-AntiSpam-MessageData-1: cvP6EtHnQMgvBw==
X-OriginatorOrg: dolphinics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e5191de-3b9c-47c7-686f-08de8fda90fd
X-MS-Exchange-CrossTenant-AuthSource: OLAP279MB0055.NORP279.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 10:36:43.3430
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7fb89e52-625c-45cc-a50c-adf3af1b0a6c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X34AIBzjFSTWPMVNXcto9P0G7APSa8AbzgxQRtCOIvbP5rVuoTWege+uuE9H0JSb9KjxAoX9mZqJv/AUCcpoeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS4P279MB0620

Hi Vasant,

> I went back to those reports and reviewed it again. It looks like
> pci_get_domain_bus_and_slot() takes spinlock which is causing the lockdep issue.

> I think V2 is good w/ some changes to get the pdev.
> Instead of pci_get_domain_bus_and_slot(), we should use dev_data (like we do in
> other places).

> >
> > However, we have a v4 ready doing 256 loop iterations instead, since aliases
> > are always on the same bus. I think that's a better approach.
> > What do you think?

> Its a performance sensitive code path. Also during init path, dma aliases are
> set properly. I think we should go w/ pci)fir_each_dma_alias -> flush irte path.


> I have added below fix on top of your v2 and did some sanity tests. So far it
> looks good. I have requested Dheeraj to rerun the tests.

> (https://lore.kernel.org/linux-iommu/20260205140059.11857-2-magnus@dolphinics.com/)


> -Vasant


> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index 050178cf388f..eb23b9e7bf03 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -3118,12 +3118,10 @@ static void iommu_flush_irt_and_complete(struct
> amd_iommu *iommu, u16 devid)
>{
>	int ret;
>	u64 data;
> -	int domain = iommu->pci_seg->id;
> -	unsigned int bus = PCI_BUS_NUM(devid);
> -	unsigned int devfn = devid & 0xff;
>	unsigned long flags;
>	struct iommu_cmd cmd;
>	struct pci_dev *pdev = NULL;
> +	struct iommu_dev_data *dev_data = search_dev_data(iommu, devid);
>
>	if (iommu->irtcachedis_enabled)
>		return;
> @@ -3131,11 +3129,12 @@ static void iommu_flush_irt_and_complete(struct
> amd_iommu *iommu, u16 devid)
>	data = atomic64_inc_return(&iommu->cmd_sem_val);
>	build_completion_wait(&cmd, iommu, data);
>
> -	pdev = pci_get_domain_bus_and_slot(domain, bus, devfn);
> +	if (dev_data && dev_data->dev && dev_is_pci(dev_data->dev))
> +		pdev = to_pci_dev(dev_data->dev);
> +
>	raw_spin_lock_irqsave(&iommu->lock, flags);
>	if (pdev) {
>		ret = pci_for_each_dma_alias(pdev, iommu_flush_dev_irt, iommu);
> -		pci_dev_put(pdev);
>	} else {
>		ret = iommu_flush_dev_irt(NULL, devid, iommu);
>	}

Thanks for the fix. I've tested it and it looks good on our end.

Currently the v2 does not apply to next. Should I send a v4 with
your changes that applies cleanly?

Magnus
