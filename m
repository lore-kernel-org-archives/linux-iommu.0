Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.85.57
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794828010;
	b=TMvbX5aCMdKpo3O1lqbZ3SqQAwogsBt2guihVEhX11OtuuxKbP2V06bgPNgWbzdVUiXA
	 4CKh/2r8xMgWlfYPANTce8A8FaVS7/uK4lBFcxyEUv6/AO/XXdCPP3KtnaLf4yWnKsLZ+
	 jz3rIJs6bJc1DDZ8tgjSJIcb4XUXwbx5tE2gPajgNveWly4KXxSENJKrVY5V4pcFqJPEk
	 ktuEWRc+PHifzRl8uUzkgyAlyJlsgwLrinVvQfGH4e01gKJhJQ8/FYf8Sn5X3Orq/2gIn
	 mI5fQQw9QKTKx+Ptjifl7RRk+dnuDuZuZyqeEvcEUG3KXfmZgdYsohjFDHuzOCY/F0Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794828010;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=vzStwCy/RenlnGwPxhdmBRynttxJciqHG6Wx71uoN44=;
	b=DyDKAUWHvYhw2Ucwo+NQcJLon+D81stQKK0vXA1599yiJllRYA17XNqeo7sOfuF95eEf
	 OYcJVvLCzoqz9Kuu71W3C0Uuf0rzHt2CeY8aX8DC3Xt7Wq3W3cCs4cTtadKUSxrtEaWes
	 i+3puVvUID6DBBl3o1UMsz2l9q6b628DOD6sJePvvFIiVnK0aJlNFhZdJne8LqcekyYPY
	 Wdd6MBZG9f2b8kA+vavbWORAaZK/loKpbCJnXlH4BHDXEJeWZZOiGb1anMWjTrP6LdrhP
	 qcSR5EV7mGzVWNlmWvXhAvkT/Cv5MdAv07G+ukrwzIbzKBcznO9Fkr4h8jo8BSNjWSw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=An15usLY;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.85.57
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010057.outbound.protection.outlook.com [52.101.85.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD93606A7B4
	for <iommu@lists.linux.dev>; Mon, 16 Nov 2026 11:20:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8CD93606A7B4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=An15usLY
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BYlpafMzNtO8lcx64wzP0jSrpoCEVFeZsAr2+ST9HVlv3yzpxY6AOcPIpQPhz4Yg1+Fy23tMxpFMlsDmSJh1EA7Wep8jehll84C3RkkoXcL85ATCImQ0c6QN/DgnNJW+9UTI9gWyo7JPkzE5+/4OT9VwGarF2cOcd/P1CMDUjilN+dKa6R6STFYl7EgPj+MJTCmDBPQ/FFalSGDfgWj7G5Kvzao7gpxKLMffNHoV+z2fdetieG+jMD46+qCK7MwH0JHthXmB5CJp4jj+9t41mXdLdayjVlPf/nvPt78+Zk9v0Siw1bV45Kpn8cbXmUFktfxGLnoRCurarc2AXABdSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vzStwCy/RenlnGwPxhdmBRynttxJciqHG6Wx71uoN44=;
 b=ey+LIVtYjaThoosVgpVfKB6wEF+D6xjt7VwzW8njN7tTZik4FkkLGdbIiANIzwZr1XzqUG1+byo/zW5Q6GDI2/WJkJglyI7+Dxq3Jc2PaWLWI52/CXUTOZIA7bYcLvewLiy9O2b0+DNQ+bJJIniutbWhS+tu72ohIL6fhiz7pwvZTc9KgtZhBUd+PHbL8L/2/7i0b1encxZDSdEQx67mTYKHM9L2sGrbC9ooekgNrjnLbDYAEYXLvaPn41oKh3ORk0lQ4fH40O22Uxo8nNRXJraweHCxpkgyICidjX57bdDfHWbD2136eXSa2xORne+CWSMGzpQ2TAgKuEIMxPS8Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vzStwCy/RenlnGwPxhdmBRynttxJciqHG6Wx71uoN44=;
 b=An15usLYmA9LOIDrXvOVDwocUGgfgG2IrlmjCGfP4tiPwJxnhr/eobsbdiFsJl+uksQcuQAPSoVt54aHwcpD/aPb++a1J9cOwcWLmBRLVnUUvGf+JKowHNYu32BP5i3stdmjWPtj8abeiEP1mALj0mGOuAYMYTg/M3bas47JsrI=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN7PR12MB6837.namprd12.prod.outlook.com (2603:10b6:806:267::10)
 by DS0PR12MB999079.namprd12.prod.outlook.com (2603:10b6:8:302::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 11:20:06 +0000
Received: from SN7PR12MB6837.namprd12.prod.outlook.com
 ([fe80::42e1:d1c1:d50d:b2d0]) by SN7PR12MB6837.namprd12.prod.outlook.com
 ([fe80::42e1:d1c1:d50d:b2d0%6]) with mapi id 15.21.0615.009; Mon, 16 Nov 2026
 11:20:06 +0000
Date: Mon, 16 Nov 2026 11:19:55 +0000
From: Ankit Soni <Ankit.Soni@amd.com>
To: Guanghui Feng <guanghuifeng@linux.alibaba.com>
Cc: joro@8bytes.org, vasant.hegde@amd.com, suravee.suthikulpanit@amd.com, 
	will@kernel.org, robin.murphy@arm.com, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/amd: Do not clear unobserved log overflow status
 bits
Message-ID: <l6vwegv7ju3csy6calsdhdoxvu7tq3eza4wmujtdd2yno5lykw@tzhh53fljavd>
References: <20261116033902.3277875-1-guanghuifeng@linux.alibaba.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261116033902.3277875-1-guanghuifeng@linux.alibaba.com>
X-ClientProxiedBy: MA5P287CA0130.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d2::12) To SN7PR12MB6837.namprd12.prod.outlook.com
 (2603:10b6:806:267::10)
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB6837:EE_|DS0PR12MB999079:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c9e1df2-a9da-416a-746e-08df43d390dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|6133799003|261009223027099003|18002099003|22082099003|261026140227099003|261026121527099003|261021121427099003|261021123027099003|261022105027099003|261102123227099003|261028144727099003|56012099006|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	jXdv+Zm7XxEGnIXJvdhkL3NqNm7kLTKf/GDGnf/b2cBXbHb0a2S1p/Ty3nm+6veygEQcs5+X0vOH1RjsJIkGYijNGRtOh1KBxtSGd+hun2pJOXvlVQV34UUxX5MCq5g6COz9SXTewZ+/BrHQ7+UQuuOKEULA8ViQrbUhDCfAjtSujSgVkM0tOs4moNkBllQXuSfTsiwISMuWnx8a1+gjIl8bpl105S9wDGpcHloOTtiu45HnjyVv339JCtiJRm1cfZmKNx1IOPiuH5Tpysyso60cjD9IjWPcOcSL94QUg01omv3BspnA8MdXCPe/PB1F0hMMOH/MjYeMblEJB2kWe5ascRoq5YmDk9jyEacPF77oIJPGfg89rOEukpQKzrfLcK/o4ZnG0e6Y5QA7RO6TnUVSahV9PHwHcKrPbTKGW1EltbHzC1RHdJADFuRz5N8+oW8DdloeH1PeZrkP/dVfR5lQVI5TuPbRtA86g8xqlmw6D9BpcFfCYEUw1+UZQEV/HHUt0s5bYXbMgU89NSxIMNjXqR3ftiKzS+neNacX+j1qMztEtBdpWhqsu5JsRcMG5bYxBH4gw5R+XgVDERnqSirMn7DyisLV+ServvXExIfUT+xA2vB69uwWZCHn3x8JyewuWmXr7BR4lRCadeOC4+5HMy2EH+mT0hfEvnLh4bM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB6837.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(6133799003)(261009223027099003)(18002099003)(22082099003)(261026140227099003)(261026121527099003)(261021121427099003)(261021123027099003)(261022105027099003)(261102123227099003)(261028144727099003)(56012099006)(10067099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vxKKana4Ju40noKQwRpBY07P1Ei1f+aphiiwO4N8bYn1HFXRYgWOzi72P4FE?=
 =?us-ascii?Q?W6ikAJ6rqjGgjroyLAOxicVVUTS5f7e4I9cMyzKSDpfRAGVzcUg9DtBKoRoC?=
 =?us-ascii?Q?zkfE+rVyIDeXGIQpUR1MPQ6hGzw+Q95YHjuX3IRuHE8nuPSYA4O+05L25pVn?=
 =?us-ascii?Q?+qohz3IaTNRpcvxDZuEb/1Xv+PCE+QRyl4Tjd/n4ZegQ10OZ5WNhmaEs1f2y?=
 =?us-ascii?Q?ES2PFojOLxP6JI+DnB9yjrZL51FScKF4WoSLnC0HHZ0wXVWZ3jrDTryIuQLY?=
 =?us-ascii?Q?go9PcPOP53GwGT2jd03mxSBypEcSZ8mhhrzBebzG8NxHDN4LaYMDFHsHWl1V?=
 =?us-ascii?Q?OuiQZ07H83xjOkaY0pEhtiY3LDaifzY9Hl9zJtBhcOgckGe/uJCtm1jzq+Tz?=
 =?us-ascii?Q?ITeEfK8BD6EBmC2yLIL//b/yL6mho+9ToqAXx0H0er1gLPdB7emhTYJuiH4Y?=
 =?us-ascii?Q?t+9EMregYDUg1kHqAdzexmF9nApiqxd41PWKlmHHEwygSIRwpBMEqstx9ELT?=
 =?us-ascii?Q?FyRC3cGhi/nBmy8BoPrAlkZFuZlW1RINGmgm3aMWJVSMmxg/1A7MX3ZeQpBk?=
 =?us-ascii?Q?AHqHkbfw/E7OAkfzzeVmvq4xMUuRdxIfuov3jFRzpU9Lc2MVX81rPhijGWsO?=
 =?us-ascii?Q?Z0ICTcS+9obGIuJN0ybnIyXmG8PI+1bsg5fBxxUFNSmTt9jcdNjTIx76NwSM?=
 =?us-ascii?Q?KGp8yIq9VpAEZrw6TaM7fyC3AVQu4sYLscyxNmEJVn6toNshmtGrmxgDM2UM?=
 =?us-ascii?Q?J/a1iCc62BknYRkuA4B93zQCCkpvlzwrpx4DFBTXcr4nwhRWuG7UZtwspOKp?=
 =?us-ascii?Q?WBmOFVGwyta6uFvES05wKdcNIZSM3jfBEuvJQMklHqJ2JydCCKGxP8Mqgz0k?=
 =?us-ascii?Q?/KDJ+e98DhrN6EKhuTFpGuaw6S/RAb8nO83XOamSi6kbYpsy1MTVjkyHiK2e?=
 =?us-ascii?Q?b+cBiX8OOx3Pler3krgVPOHKO1QCUszOFCnlmnILqsFzU8TMQ/I2I9mdwlCE?=
 =?us-ascii?Q?a711q9O6mXxUZxoAAke+XcoLbuT6NOAdBR3oF9IFLcBBiCcGyfHd9xG9MIlh?=
 =?us-ascii?Q?l4QhbJ5x2aA931FxEfQ+BcnBuO91O8FckYm7qTDIY5uwYqGCkTPxFZMnjLEk?=
 =?us-ascii?Q?X0jARbCOFLqnwcpsThJGte6XR9tjlV9qD06CsK3qvJXw5RY1KURwSPLzaMM9?=
 =?us-ascii?Q?awRJMSXBz0jaF6Q+AwI+Ngyr+a1mcSNYP4sD59jk4m12QbraUG0Yzitu14+y?=
 =?us-ascii?Q?cLW3RbiiA5L6ahBgecqtvgG8n559Nex43SywmebUgJVvr5p0uGVjsGX8GLMR?=
 =?us-ascii?Q?9HEDkKbUzsDCoNtvOOCx3MhDtYLQttD2xlzwgnjvO+06avBTpkt62s+Ao7L2?=
 =?us-ascii?Q?d+VyzwvyZjU9opcjHqkJbieVICjeKq/obFwOJx+g6GoWHCPIhXfx9NK4Y60X?=
 =?us-ascii?Q?3/ou9E6gMsZCQCMg5vFs2QNbyfRy+QK56V7SQuZk/MAPk5cMV+KGvoPvs8Gd?=
 =?us-ascii?Q?YfEWSmjw9KUkwVB/8vCvfVtzGIUPVsgI0oc89Z5R/GdU0cuPvl5KBYiaHhh2?=
 =?us-ascii?Q?yE1wHTuKF717R4dzq8fyczFtAZMp9BX+cJ/qaM9bKRpjXVyA+3A4HE4kDbo8?=
 =?us-ascii?Q?EdJ5C05WJVhSe2d+yjhdd5iM7yjfwyzsjljO8X6j208xYSobDepMeVkjW/s4?=
 =?us-ascii?Q?KKzSX5GyZurj1qHsb9VpzuJbQzSvQPPCeGWti4UPsSeSNWCkWTMECLMj5iYl?=
 =?us-ascii?Q?xZOM1b7lEg=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c9e1df2-a9da-416a-746e-08df43d390dd
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB6837.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 11:20:06.3708
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9QsUkDKrlLG2XHJOReUILfYADv48iBn98REbil1+ipPqKTEGDe+S/TvORt/PSMKXgTYiPbSIet7PK0Yb5IvTfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB999079

On Mon, Nov 16, 2026 at 11:39:02AM +0800, Guanghui Feng wrote:
> amd_iommu_handle_irq() clears the interrupt status with an unconditional
> writel(mask, MMIO_STATUS_OFFSET), where mask is int_mask | overflow_mask.
> The log overflow status bits (GALOverflow, EventOverflow, PprOverflow)
> are RW1C and, per the AMD IOMMU spec, transitioning them from 0 to 1 does
> not itself generate an interrupt; they can only be observed by an IRQ
> round triggered by the corresponding log-interrupt bit.
> 
> If hardware sets an overflow bit after the status register is sampled at
> the top of the loop but before the unconditional writel(), that write
> clears the freshly-set bit while the stale sampled status does not
> contain it, so overflow_handler() is skipped for an overflow that really
> happened. For the GA log this is fatal: amd_iommu_restart_ga_log() is the
> only recovery path, and per spec section 2.7.4 logging stays halted until
> GALogEn is toggled. A bare W1C of GALOverflow is not part of the
> documented recovery, so the GA log stays halted, no further entries are
> written, GAInt never re-asserts and the GA log interrupt line goes
> permanently silent, losing all AVIC non-running vCPU wakeups on that
> IOMMU.
> 
> Clear only the bits actually observed this round by writing status & mask
> instead of mask. An overflow bit set concurrently is then left asserted
> and is picked up by the existing ERBT1312 status read-back at the bottom
> of the loop, which re-enters the loop and runs overflow_handler().
> 
> Fixes: 2379f3485239 ("iommu/amd: Refactor IOMMU interrupt handling logic for Event, PPR, and GA logs")

This commit only moved the existing clear into amd_iommu_handle_irq(). The
unconditional write already cleared overflow bits before that refactor.
The first commit that put an overflow bit into that write is:

Fixes: 5ce97f4ec5e0 ("iommu/amd: Recover from event log overflow")

The GA and PPR overflow bits were added later, by af47b0a24058
("iommu/amd: Handle GALog overflows") and 274c2218b8b2 ("iommu/amd: Handle
PPR log overflow").

Otherwise, patch looks good to me.

Reviewed-by: Ankit Soni <Ankit.Soni@amd.com>

Thanks,
Ankit

> Signed-off-by: Guanghui Feng <guanghuifeng@linux.alibaba.com>
> ---
>  drivers/iommu/amd/iommu.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index d0d55c93a480..39254671b924 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -1168,8 +1168,17 @@ static void amd_iommu_handle_irq(void *data, const char *evt_type,
>  	u32 mask = int_mask | overflow_mask;
>  
>  	while (status & mask) {
> -		/* Enable interrupt sources again */
> -		writel(mask, iommu->mmio_base + MMIO_STATUS_OFFSET);
> +		/*
> +		 * Clear only the status bits observed in this round.  The log
> +		 * overflow bits (GALOverflow/EventOverflow/PprOverflow) are RW1C
> +		 * and do not raise an interrupt on their own; clearing them
> +		 * unconditionally here would drop an overflow that hardware set
> +		 * between the readl() above and this write, without ever running
> +		 * overflow_handler().  Leaving such a bit asserted lets the
> +		 * existing ERBT1312 read-back below re-observe it and re-enter
> +		 * the loop so overflow_handler() runs.
> +		 */
> +		writel(status & mask, iommu->mmio_base + MMIO_STATUS_OFFSET);
>  
>  		if (int_handler) {
>  			pr_devel("Processing IOMMU (ivhd%d) %s Log\n",
> -- 
> 2.43.7
> 
