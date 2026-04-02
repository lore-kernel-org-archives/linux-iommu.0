Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013068.outbound.protection.outlook.com [40.93.201.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65503537F0
	for <iommu@lists.linux.dev>; Thu,  2 Apr 2026 05:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775106008; cv=fail; b=O+VpMQMiwleoxFASkIQ1SHFAuhuWtSEF7jQi0SyJ8WtdIZk54KQvaOk8TJrzMH+OXL4ks52bxgy/ZEhWy2G9P5kRfuDkLusL5WzZr6tdfz3eNCfxo7NNhPBe2f3Oaz9D5aiNNy3gNfOXozBJwv5r4/Qlyv+IFQCszQeoKEliYbE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775106008; c=relaxed/simple;
	bh=irfvQZN3zLZIRel8yTBtsBolkKRcOcBB+B1JpIzRT6Y=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=B8dkqwqsO7GmsHzhulLfUKvRbBOVzIf9TEixHAkW2vdfRPerNuUIN5VXctlMXUxlkBbBZ5SalMw+/8z4tyQB6QiGzrU7uAYYZLsNq/BodNOdVtsVwFAbp1W4iIiBdptiPBZTNUYHOHXIQdY2SwcQmoWoo3w4I8u9+yWrFAI1Yp0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rFG8uQPC; arc=fail smtp.client-ip=40.93.201.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rFG8uQPC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HK37k6rrKef2BopbdyfvDEbanUw2FByz3c8t7ULmEg4Kt5zKbQlbXj0QbekuFxz/Y5nCYZFBsIK3EsQE70TgCLASK2hMizjho8DZWti3piCCRkrCJGSttSDUl7+HXIwu1KQPOzpmETyBJuOz6Hrym+TcqblnJHzPc7k2PK/41uZtvWrWNsoe1JdeChg1sUaWCSvek6SBOdTQ7tljeqsjRGPQVBmpfYnkuqaCGEReVPno6CBVmOqqYZbs1hy71G9gMyQn3EtAxd8kf5YZqe8qqMPKuZraA/o8MySd+GtqcJpxKwzqJHaYBiEoxBhH3x+xNJufN1mvXzewWm9LkZgC3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jKsHu8sOJOuqDqO2q5ziNdVT/TGb6qIiEIlVQOSoOpo=;
 b=igAK6bA8DEYM+ZruhC7jKzfAamvVzo5gm/rMN1khveebZGSbzVyOMDOQwyxu3BsIgJoQooyvvNojdYsaf7OnoEKL0QpELTHBruZnk1EjCIAP5yt+GPElKb+oFQcKIgePoE2D/SoMicbvCO2fJwC1pwiH2dgX9R4L+beairC1XD1f804pdo0mVaXdra+f+d4PHrX11g+3sAAlVOCtjXwU1R92au9eRjpI3BdcIrpprUCN4wtLcCtnGxB7MjLhOd3ugcbcRlsuwrll4enFPysMEII4qJ0aGyN6RrNGT7t4iXmMwzomuz77Mo3PV/4lTUujVEje43Ot5w6qz1fTb6XGtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jKsHu8sOJOuqDqO2q5ziNdVT/TGb6qIiEIlVQOSoOpo=;
 b=rFG8uQPCmGUhpUbJgaa+UiV3QXO2ut1cWGVBKbBZ+VbWyNRmTsgqGx/WGkpz7DS5XGa7fHwlXhst9F0SUuKhd+K3JB0Ib1fP3pLvWjk7F1eEltYXuf3cOqmHx52rHOdiMYK7nmjkLwkUdkTE1XF5DtrTgvTwkrwkm24JnaZ1pHc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7SPRMB0143.namprd12.prod.outlook.com (2603:10b6:510:201::21)
 by SA1PR12MB6774.namprd12.prod.outlook.com (2603:10b6:806:259::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Thu, 2 Apr
 2026 05:00:00 +0000
Received: from PH7SPRMB0143.namprd12.prod.outlook.com
 ([fe80::a6b4:32ff:a323:b46f]) by PH7SPRMB0143.namprd12.prod.outlook.com
 ([fe80::a6b4:32ff:a323:b46f%3]) with mapi id 15.20.9769.014; Thu, 2 Apr 2026
 05:00:00 +0000
Message-ID: <9204da81-f821-4034-b8ad-501e43383b56@amd.com>
Date: Thu, 2 Apr 2026 10:29:53 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] iommu/amd: Invalidate IRT cache for DMA aliases
To: Magnus Kalland <magnus@dolphinics.com>, iommu@lists.linux.dev,
 joro@8bytes.org, linux-kernel@vger.kernel.org, suravee.suthikulpanit@amd.com
Cc: dhsrivas@amd.com, jonas@dolphinics.com, larsk@dolphinics.com,
 torel@simula.no
References: <20260401112021.76806-1-magnus@dolphinics.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20260401112021.76806-1-magnus@dolphinics.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0207.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1b0::6) To PH7SPRMB0143.namprd12.prod.outlook.com
 (2603:10b6:510:201::21)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7SPRMB0143:EE_|SA1PR12MB6774:EE_
X-MS-Office365-Filtering-Correlation-Id: 56a085b8-983c-43e3-dbaa-08de9074b173
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	OkatCyqF4/g60b35zotZCdfqr8Pzs+PS6P7hL/rKbflz9DMuCXrDggqBnDJv8Luey44fS4XpG8pVYXC2lzMdTnagbveRy3FIQMZFzQKHszqFGSFRTItjnnnBOpI1ksxEA4wJhaFcgY24jXuoPKDhUi2zMNtO+LJNSghMP4lQumzPV1bOPsHrqAmsuAR2C3YoPXXgcofMePUI11fo7e5gAaXgjQ1Eo8/gpTHZQWU8AUt0AmvJFAhPiiuzrzGpCvFAevVSeJ2v7qTrt3o6hqg9fPvooSvHj4htg7slwOcMLvGnFgCEyC1Sfe6tTeLeFyjxCZs8RNAwDRAS4eKyusAMkDx8Y2735LXN1LQptz8JojXb57ymUdy17WNg9rqmGg7IK2vtVnrOPjwvrJLDNMF8DAT0Z4VucKlTQkJXrJNLYavnus5f6hCQ9yD6b1I5gM8ChlYfx5/QW//InUa4OujbU1H/RO0/HEPZOCv+gRdlOn+NYMN3EjqyyynX3LZiaU7h1tKQK2PE8nM6Lm/8lx9Y/tzCTjUBDjL2iPXKhp4QT+vuLEPnofA6gBkgu0t6lKpCzLoxiWP2APWR+yYRR3MOCpSMbrtQNdY4FQ+KqBlFMmEHjjLWK1YxFpFMat9QqdVtq2Q1c8dOHTnI/UoWKLNUSMnI+sGBq3bTE1kun+d0IhArtxpfSBO5Rama7PloWPgY
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7SPRMB0143.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z21kOXBJcnBwTU4vQm41SXY2OHFOTG9MK3FTL1dBdnlTdVBMYTVkQmI0SWo2?=
 =?utf-8?B?QXVaSWJqZHdSWFJEaEtyOGlyVGxEN3pNazI1ZVB2a0F5TzJPZjdteGJUV0p4?=
 =?utf-8?B?THhidlpEM3BoTEJUalBTNUtTMnlzbk14enlLSVZyV1VncmNEL05oSFRsdVEz?=
 =?utf-8?B?dUVPVWxOOTJwdFF3UTJTVzZkR3dzdXBJNU5FdlE0ejZvdHRhYXBKWm5NdlZk?=
 =?utf-8?B?eXE1NHp5bVJUUHppaFVnZmtoNWh4djBzV0l2cS9LMkpjRDNTOUZSbndUeENF?=
 =?utf-8?B?bWVtWnRSL2pqZnZQTXZtQXRhK2FienVjZXp2dWo4cXdBT1loY3V1NkRJR1BX?=
 =?utf-8?B?TXJ3aFVSSGNWNmlrUEFuMjRqL1FsaHNTZU1XN3h3Y1ptdWJGWG9sbGttVjIw?=
 =?utf-8?B?QTV6SHdZd1BJRXdLazQrNFhZclVIVmw1VWZ1a0EvT3dNemxqS2VCZkJ3akxF?=
 =?utf-8?B?ckdER3pqd1N6Z2t6bStIeVlVZ2x1OHJkbVlISXpHNTR2NkJVbTJqZGdlUVhv?=
 =?utf-8?B?ckRBR0RzMXM4c1cwd0JHYzNGR2VGUlJZakJNbXYraUV4MUREd1ZscVZSTXFH?=
 =?utf-8?B?ZkM4N090OE8xVmdZQW1pOGoxY3FDUmljWk9ONG41VEZZaitJNXp1TnNmWVk3?=
 =?utf-8?B?eFF2ZHVhMDBmazNnbSs1NGlENCs0Mjhxako2LysxZS9MZGx6Q3UxdnR0eksx?=
 =?utf-8?B?dm91cDZCTk81VHFpQWFLRmkvRy9mSlNpQjM5UU44dk9CMzNtRnIraFBuZjBL?=
 =?utf-8?B?R2NuYm95bThzS3JaYkpKdGhqdUFjREIvRXZHY2dobWhRZk1DWjQva1RYdmdv?=
 =?utf-8?B?b0labi9GanhGdlFSY3Rsc1FsMUV5dzhQL1o5UnJFRHhnVTRmb0YwVXVZQUxK?=
 =?utf-8?B?RzJkYjBvck44djJ6MXluejZLSVFVckovaytLNVltcUYzT28yS1lqQlB1TnNh?=
 =?utf-8?B?Mi8rM0ljVW8raGY1cDdPeU1LV1FPTDF0WWEzS3ZFNi9JYUlQRWREbnhLSWEy?=
 =?utf-8?B?ZmJxUHNYZkdaVUluOWhpb1BKemlJSEtpRHhscFZxb283OExaTEdzM08zZWxJ?=
 =?utf-8?B?T2YvVzJNVlpnNTdiRFhsS0VXTnhuaEFIRFNYdHNnWUJtRm1TcnJwUExlU3hJ?=
 =?utf-8?B?ZnJGaERKUkRic01ZdXgyd3lRa0Y5Nlc0Z29BL1NBbVZlOG0xdFlBdXZzdGNM?=
 =?utf-8?B?YVU5Unc1SHArckt3aEJsQWtRMjBWaS9NT0VJMkh6OGpEdlJucHRSQk1HcE9R?=
 =?utf-8?B?ZHRLMzlTN2h3K0kzUFFvWjM4RmdCZWZrZ2xyc3I4bjZWL2xxbHhFV1BwNjBG?=
 =?utf-8?B?ZjZxQW5ZQldQb0xhN2FrS1d5OXE3RTdrRHlhNUNoOTBncU5qS1hqOUlISWdq?=
 =?utf-8?B?WEQzQllNcDY3ZnRxTTBlajlSVWpxRU54SjcxUVpsWC9nYWppWDlFZEU1Smk1?=
 =?utf-8?B?NU0rVHMzYms1U2k2YWJFVnRsYW8yVVVoWHFFT1pta3VwQVNURGdzU05SR1J2?=
 =?utf-8?B?eXY2a2dVekZmNnM5MWRDSVQ5RytYZWpmenUzbkxYdDNTZjRLTzRqQ245Tjk2?=
 =?utf-8?B?bWZLTkw2cnJoM1p4eWo2aUJEazQ0N1hKWWRvUWN0MGRJUTNIbEozdCtCcnVO?=
 =?utf-8?B?MFJBUG9uc1I5czhNR0QzR1BpcWhsWnlWOVZkanpHcHZ3aTBRbFhHYU1HMUxi?=
 =?utf-8?B?amFWdVU4cWFhZ2RyVkpHRXphU1F6ZkZ4M3hpQzEyVDY4YSs3MDBISE9naytV?=
 =?utf-8?B?MUR3QXpyT2d2bHZOMU8xQVpvOUV0dGZlc1hxbEdTVDgyMTRITFp3YXlkZXp6?=
 =?utf-8?B?MnNZajBPNHhIbXFUUWxwdTUzTm5xdlFFVUNTU2UvbmgwMHVHVUIvUWtabzZ1?=
 =?utf-8?B?UmdDZVpBbUhYNEloMG5Pc0dDS2N0WXJQVkJkN1BHYVFPdTJPT1RCcmR5VmVZ?=
 =?utf-8?B?bCtQZGJOeFRObGczOXBiZXNIc0RoZW94bGZoY3lxMWVHSVVNd21sb0RuTUFS?=
 =?utf-8?B?UUIvTFZzUUpSOVpvM3BYdEd3WGkrT2U1R1lXQUM1Rzk3STMvNHdNdHVuQzJV?=
 =?utf-8?B?YlQ0REVHYnZmZ3lSbWlGRFFCRkJ3Zy9PTSt1Z1h2U1AxQmZvdG9xNjZDdmtO?=
 =?utf-8?B?ZWVJa1huZzBKbldWMGtneXNmWXFTQVBTdVh0S2RqOGlueWsxVHpFV1N4a3JP?=
 =?utf-8?B?Zk5IMDY1cjhERWdGb3JRQ0hZRDExaWU3L2pzUU05dXBYazk5eForNzBFdWY1?=
 =?utf-8?B?WXlpZENlUkN6UldBUC82L2tTWW5KT1lmUS9JUVNTa2c3eEpnZ1VBa3l4K0RJ?=
 =?utf-8?B?M3lBdWxuWjhTMDBuNWRKK3VWc01FR1IrTXN2QVhHUDNmblNDUnF2QT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56a085b8-983c-43e3-dbaa-08de9074b173
X-MS-Exchange-CrossTenant-AuthSource: PH7SPRMB0143.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 05:00:00.2267
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iH9q/VNQUL2pfZo3Xcbe2OwToF0Dx5FTwF8VhK08Go71AHhbMPm5B427mdBGejCl9GqIMkN/ffvau4wwywcaWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6774

Magnus,


On 4/1/2026 4:49 PM, Magnus Kalland wrote:
> DMA aliasing causes interrupt remapping table entries (IRTEs) to be shared
> between multiple device IDs. See commit 3c124435e8dd
> ("iommu/amd: Support multiple PCI DMA aliases in IRQ Remapping") for more
> information on this. However, the AMD IOMMU driver currently invalidates
> IRTE cache entries on a per-device basis whenever an IRTE is updated, not
> for each alias.
> 
> This approach leaves stale IRTE cache entries when an IRTE is cached under
> one DMA alias but later updated and invalidated through a different alias.
> In such cases, the original device ID is never invalidated, since it is
> programmed via aliasing.
> 
> This incoherency bug has been observed when IRTEs are cached for one
> Non-Transparent Bridge (NTB) DMA alias, later updated via another.
> 
> Fix this by invalidating the interrupt remapping table cache for all DMA
> aliases when updating an IRTE.
> 
> Changes since v3:
>  - Revert back to using pci_for_each_dma_alias (v2), but look up pdev with
>    search_dev_data instead of pci_get_domain_bus_and_slot (lockdep). This
>    avoids changing any locks
>  - Rebased on iommu next
>  - Tested atop
> https://lore.kernel.org/linux-iommu/20260401080017.117549-1-vasant.hegde@amd.com/
> 
> Link to v2:
> https://lore.kernel.org/linux-iommu/26cfa307-6c33-41f9-a7a0-fbf202b38a00@amd.com/

Next time please move the changelog after "---" so that it gets discarded
automatically when applying patches.

> 
> Co-developed-by: Lars B. Kristiansen <larsk@dolphinics.com>
> Signed-off-by: Lars B. Kristiansen <larsk@dolphinics.com>
> Co-developed-by: Jonas Markussen <jonas@dolphinics.com>
> Signed-off-by: Jonas Markussen <jonas@dolphinics.com>
> Co-developed-by: Tore H. Larsen <torel@simula.no>
> Signed-off-by: Tore H. Larsen <torel@simula.no>
> Signed-off-by: Magnus Kalland <magnus@dolphinics.com>
> Link: https://lore.kernel.org/linux-iommu/ea4cfd4d-9ad2-4451-a896-9f0435e72a06@amd.com/

Overall it looks good. One minor comment (see below).

Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>


> 
> ---
>  drivers/iommu/amd/iommu.c | 30 +++++++++++++++++++++++-------
>  1 file changed, 23 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index f22a7e9ecfdb..217da630d847 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -3186,26 +3186,42 @@ const struct iommu_ops amd_iommu_ops = {
>  static struct irq_chip amd_ir_chip;
>  static DEFINE_SPINLOCK(iommu_table_lock);
>  
> +static int iommu_flush_dev_irt(struct pci_dev *unused, u16 devid, void *data)
> +{
> +	int ret;
> +	struct iommu_cmd cmd;
> +	struct amd_iommu *iommu = data;
> +
> +	build_inv_irt(&cmd, devid);
> +	ret = __iommu_queue_command_sync(iommu, &cmd, true);
> +	return ret;
> +}
> +
>  static void iommu_flush_irt_and_complete(struct amd_iommu *iommu, u16 devid)
>  {
>  	int ret;
>  	u64 data;
>  	unsigned long flags;
> -	struct iommu_cmd cmd, cmd2;
> +	struct iommu_cmd cmd;
> +	struct pci_dev *pdev = NULL;
> +	struct iommu_dev_data *dev_data = search_dev_data(iommu, devid);
>  
>  	if (iommu->irtcachedis_enabled)
>  		return;
>  
> -	build_inv_irt(&cmd, devid);
> +	if (dev_data && dev_data->dev && dev_is_pci(dev_data->dev))
> +		pdev = to_pci_dev(dev_data->dev);
>  
>  	raw_spin_lock_irqsave(&iommu->lock, flags);
>  	data = get_cmdsem_val(iommu);
> -	build_completion_wait(&cmd2, iommu, data);
> +	build_completion_wait(&cmd, iommu, data);
>  
> -	ret = __iommu_queue_command_sync(iommu, &cmd, true);
> -	if (ret)
> -		goto out_err;
> -	ret = __iommu_queue_command_sync(iommu, &cmd2, false);
> +	if (pdev)
> +		ret = pci_for_each_dma_alias(pdev, iommu_flush_dev_irt, iommu);
> +	else
> +		ret = iommu_flush_dev_irt(NULL, devid, iommu);
> +

if (ret)
	goto out_err;

-Vasant

