Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE428C433EF
	for <iommu@archiver.kernel.org>; Tue, 25 Jan 2022 16:49:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 57FFB40216;
	Tue, 25 Jan 2022 16:49:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EuyfhZ1_J0rt; Tue, 25 Jan 2022 16:49:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 40B7A401DC;
	Tue, 25 Jan 2022 16:49:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 222C3C0031;
	Tue, 25 Jan 2022 16:49:37 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 38C40C002F
 for <iommu@lists.linux-foundation.org>; Tue, 25 Jan 2022 16:49:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 218CE40216
 for <iommu@lists.linux-foundation.org>; Tue, 25 Jan 2022 16:49:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JSmj2EXGoG1l for <iommu@lists.linux-foundation.org>;
 Tue, 25 Jan 2022 16:49:34 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2061.outbound.protection.outlook.com [40.107.92.61])
 by smtp4.osuosl.org (Postfix) with ESMTPS id EE348401DC
 for <iommu@lists.linux-foundation.org>; Tue, 25 Jan 2022 16:49:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WQI6bbQSE9N6Hv04gtVvui2a9sGruZtVAuxcATxSWEtp9IPFA3yOmBBUsk9Xq1xDnnVyp+zw49Q9ZwYMhyQ5hAGpK3Re36RMLtX2unN2JNWB/3hMSeyIdVENy2BolcHbohoZX6s9i0iHG6r2FuEXKPFz9DRfpl9oeirW31BHoNEi24j3zDUgWz89VxJo/P3wl2K77NKVqly5+fiumLl/N5Wnz/bfIWWO+OOeFfYhzmIyvGUej7237TtdwE98x24z6v0rynJ6WbQKjXEWw9HqkKQk2mBKM+CmRyEw+JN560AQ0xx/Z3qqQpYZIfh3rxTEocoSA//ItISWr864EUjrPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6lt84xEPVmObfshzuhpKniMOeistcn0ggolyIr8f/bg=;
 b=cH+YjWw9Ej4tdEBQdmFESod3VaQswWTWln11QbpkarhvaFQDmIaMNsZ3wnvLM79BFDUiZ5on3HZOezT6ivByZidjfNKOaxgMh6fsXuAlthJTDpfdVHF6vayc1CYNPivBIDliTe3Q4TJMDa1P36odjayKW0ccWaQkGcHgsH9Dpiz8bIMocruESvG6MT6Tvt4xEU2XBQ5hP659LyoL1koGPFXBdweUvE06XNQFfwhPDahTJjC6jnh6oYUH0X3WMd0jcqOsRjMSeMBNfEVYn5Zfg4dmCCUyIu8PYic5rKVKk0RzotL57lzUdkcXjYSuZ8IStfdJhPifDR4yHxMFfxIHcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6lt84xEPVmObfshzuhpKniMOeistcn0ggolyIr8f/bg=;
 b=wYHQqZsax2czHy9jb844Co39JGlAcCJ+2a+zSM5bGe/Ft0kda9GwuRDA/x/rhdfzxToJvYPzi7T+zZXX5zwJkF9XYeZ/5Z9OXUDGP0zjkhxJYvQpizJuNWAtkrOLpjlJb2pQx6zR0AudU8QwQlCqYFRS3COu83E9SYVYCACUE34=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by CY4PR12MB1797.namprd12.prod.outlook.com (2603:10b6:903:124::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.14; Tue, 25 Jan
 2022 16:49:31 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::ccd7:e520:c726:d0b]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::ccd7:e520:c726:d0b%7]) with mapi id 15.20.4909.017; Tue, 25 Jan 2022
 16:49:31 +0000
Message-ID: <ef5e3efb-ba02-94e3-67f9-5c2b65cfa850@amd.com>
Date: Tue, 25 Jan 2022 10:49:28 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] swiotlb: Do not zero buffer in set_memory_decrypted()
Content-Language: en-US
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 iommu@lists.linux-foundation.org, hch@infradead.org
References: <20220125132001.37380-1-kirill.shutemov@linux.intel.com>
In-Reply-To: <20220125132001.37380-1-kirill.shutemov@linux.intel.com>
X-ClientProxiedBy: MN2PR06CA0023.namprd06.prod.outlook.com
 (2603:10b6:208:23d::28) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 85c26ea5-aa50-4aa7-bfa1-08d9e022a883
X-MS-TrafficTypeDiagnostic: CY4PR12MB1797:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB179766D00223162315A231FBEC5F9@CY4PR12MB1797.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MMNo01rahIVk4rkENJX+IFollaCIM+36NpTKPyxLw1tpXVqR8OjwAWsyGatld0O9wOwFKj/blnGGziWPYyRRm7EX2bS2IRm4bSxGMbmlLE5qjwIMWPc6afPiviBZaDBzX3/6mEu+etiifdeKSaZxfhRij/b36bRgsxSkTvT7Nwjbx4Qwx8iPbX1BWYPnDasZdGr1FWpkoLty9CxtzyF9FR/TWcikufWzS0LmLalBjWkAEhxug3gP/aoxB2I8+x+7b3w8qTDavv/txCm+oZZplYjwNuCj46ri2ySY5r8yPJBWNlBoeETqKiLkGm4tgsoVwFQeJ3H9VR5YOkW5rQeSu1qPfwtCnCbaixAvzbDnDJY9JEpY0DKP1G3HrhVybzhWdw962A8tc8DHN71DiudGVzFdRbBADGDj2FUO/jI/ArvU/XUI0bEcBmt/4r116CE20DacfDuPU/IirQm9p5EdtyQAjyWmoqDnnZP5pE2ngG0lvTHXP1cD/O0+/AAESfIW4MItjWG4VNLmt/KPirJY6SwAbDXbOE0u5aPP0vI+lcD5AAb5asQyPHd2+H1vGcoXJDDkZhMpjVX/S1QL0gkA1O0wNVUT1oh2WL2QimfmaWYktHC7WRcQ2i5SGQCMe5x94kcoOBFtxyTUNTJj9+xo6mTSRkSAzMS63LZ2i+iHGa7Nog30VB3+OkVdvV4OEzf71eq+2svwBlGmO1H3ra7evBravXelnDE3GWhbsdj9aF930uVWg3HWfnvSJc+b12Q1
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5229.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(508600001)(31696002)(6486002)(186003)(66476007)(4744005)(6666004)(83380400001)(86362001)(2616005)(2906002)(316002)(31686004)(66946007)(66556008)(38100700002)(26005)(8936002)(36756003)(53546011)(6512007)(6506007)(8676002)(5660300002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NndCVVpsZXdQZmFJU3lObE5zdHRRTHdLV3FuS1lKczJrTDdQMlpHTTA1Vzl5?=
 =?utf-8?B?elg5cThXSytXMjFSVGtIeUJQempKN09FaE1jVlZmcHVJQ0R4VWphdmhtZkVt?=
 =?utf-8?B?bDRvWUpHUnpHV3R3SmZFbHRXOXhXaW1oZTlaOE1tbkF3WlhhL3A4U2Z4bU0r?=
 =?utf-8?B?cDExaGtTeEVyR2lBc0trR0ZsSTZDWkpCZG55T3FnL20yeUZzWENNVEQ1eHg3?=
 =?utf-8?B?WVNPd2FoYTRoSCt0Y1ZzNUtvWmc4Mk45SkQzZ2FOblNVaWVyNWxpcGtSVXhS?=
 =?utf-8?B?NkxURW9iOEZxOUVxWGhIdFpiVFplZTF1RjRzT01jODFrSjkwalhvQ2Z1TVhH?=
 =?utf-8?B?R3VZbERpall3VDZoc1ppRkQ1OXFUWnVpYjBCWWZGYzJjT3JjWDZVc1RyMEpo?=
 =?utf-8?B?SGhXVXV0WGVmbHZ1Qm9IbWxXOW9Jam5SZE9BL1paT25DaWFqNlRXWnI1MnFT?=
 =?utf-8?B?eXVnWGdZTGlIdEpjVHo2Rzk0V3Y2azBsS3JuSUZ4RTJMdVIybm55TjBtZ05V?=
 =?utf-8?B?MXJSRmNpQzdFN0srRkRjR3N3REZKcUpwclU5eG4rVGlMelV2YUVEejFpNVFL?=
 =?utf-8?B?dGh3V1Q5OFBmZDh4d3ZiblEvMnM1Tm1aek1KM3ltdEFBbkg0dVJ2L2VIcENZ?=
 =?utf-8?B?OHVBL1pESURKT1l5L3lFazlyRUx4VGFUTm9ZQjk5TkxOYkFqeTUxNTE4Q1FD?=
 =?utf-8?B?K05jclk0SlI1bjJvQWttRGoyemtENHc3Z0JoRElxZU92enJzaGI5ZU53VnFU?=
 =?utf-8?B?MStPQyt1bXhrVE5weXp2djdWT1pDdDB5bmlBcFB6emtMelhsT0RnUEFheVpR?=
 =?utf-8?B?OTU5cmhSZWRBTlZKd2d2UWh2UVF6S3V0YTFveVdKT3FENHhwRmM5ZTBwaTJF?=
 =?utf-8?B?dXBQMUZVMTJKL3AwZEllbk1RU3pNTjQzTUhhSzdPVVZ1azd0dUswOWVYdTNx?=
 =?utf-8?B?TnRNZHFoU01zUXFSWjNzMng2NGh3cnVGUzRQVjJEYVloVW5uSjlobi9pWTFt?=
 =?utf-8?B?WUsvTFgzTjFTSTZFYjF6eXJUKyt1WWYydGxuekVRTUIxbWNKc0hWK0c0TFNx?=
 =?utf-8?B?UVdZZWtCdENIMGQ0aVlCTzQ1SlU3UytBcUtIejlZUEJZd1NkelZlRU42STRN?=
 =?utf-8?B?NlQ2NFczaHdxMlB0Y0RCUzk0T2h3SnVaSUc5NGpIL3c1LzhLalh5aSs0K2lO?=
 =?utf-8?B?V2s3RVRXbGhHU0xvUUxHRkFLS21yT1lpemd2eUE1ZXIrd1RBQTBtZzlrZytz?=
 =?utf-8?B?SWZiMlpxTkpIRlJ0M1dOczRYV1UwK0s3RXNCNjV2bkZubTlOZ01OVTg2SmRi?=
 =?utf-8?B?akd4Y2xjcVVvZEw1UURnM1U3WUR3b00zRnpYcVROUTJaK25VZmh5MEhCMXAr?=
 =?utf-8?B?TDdFcTNLK3hlZ1JkL1c4NkN2M2ZqVG9DL2t6V1F0SVd4ZXhBcS9lTHhvM2Fo?=
 =?utf-8?B?TkJmTU9xdklaRjB4ZWZHcUJocEZTVVRxY0FWcGRLaTdmcXdSRS9qZVk2dzJo?=
 =?utf-8?B?a0o1NWtBb1ZGbTh1bXRPaktJRzBrS01PcUlpalp5WTZ4SG9jc1JWSW1CL3FH?=
 =?utf-8?B?UnhqdEx4QXhVK0xCWjNuK3BLU2tVNTBMYTAvQ2hrZ21WcW5ISVRaRG5Wclpv?=
 =?utf-8?B?dnZmRmcxVzkzNjdjZDB4RmZvRGlOd1AwQkdFQVJpb0wwakgxKzdFaHdxaVRJ?=
 =?utf-8?B?SlYzdjVoamJNdXJrcHVPRVF0cDVqaWdMcEI4K0tNRDd1NlRKYitJczlBZDUz?=
 =?utf-8?B?dFlIRWFqMkgyNGNVY2JtRUhNUmxtbTRtNm1yaXVWTXNVREM4SzJvSk9yZkhx?=
 =?utf-8?B?eWF6anhXR3BiL0tacy9xTmkxVnlTK1NuckJoYVBIZzNRV0RkbjIraVltcU9r?=
 =?utf-8?B?ZEltYTRyYjBGeEc4Vmc0WFl2VlVTYVhGejAyakVOUVVFck1INVhiMGVtdnBC?=
 =?utf-8?B?S0NrMDRGY2p2RnlHYmJoalA2Mkc4S0JHSmRDTm5oTlZISUdaV25MMnNCakpB?=
 =?utf-8?B?ZnVFNGl3TjFkMnpPdkxPOS9GckJsN09PT2xnZUpYZUtuQS9sMDZrSHJ5c0F3?=
 =?utf-8?B?L2tzUE00R2JHcmpmNXpHZU1KM0NnYkdtSG1Mc2ROL2xhNXA3UkNJWDFHTG9J?=
 =?utf-8?B?d1hDMTY5YjJFUVRwWVJuTkhEQ21nM0pldlZpZEoybnNKUitMUTJjSXNSeFFo?=
 =?utf-8?Q?aIRgGn8vwU04/0WW6dFsnKc=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85c26ea5-aa50-4aa7-bfa1-08d9e022a883
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2022 16:49:31.4257 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eKGBwjViPmUecl8OHi09oso/pxtoP2nFs6hviTNry1G8b2gdHIiF0S7HyhEcGUqVxojpDh0FDn0hctyWqAo/4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1797
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
From: Tom Lendacky via iommu <iommu@lists.linux-foundation.org>
Reply-To: Tom Lendacky <thomas.lendacky@amd.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 1/25/22 07:20, Kirill A. Shutemov wrote:
> For larger TDX VM, memset() after set_memory_decrypted() in
> swiotlb_update_mem_attributes() takes substantial portion of boot time.
> 
> Zeroing doesn't serve any functional purpose. Malicious VMM can mess
> with decrypted/shared buffer at any point.
> 
> Remove the memset().
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

Acked-by: Tom Lendacky <thomas.lendacky@amd.com>

> ---
>   kernel/dma/swiotlb.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index f1e7ea160b43..9390b38d2897 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -207,8 +207,6 @@ void __init swiotlb_update_mem_attributes(void)
>   	mem->vaddr = swiotlb_mem_remap(mem, bytes);
>   	if (!mem->vaddr)
>   		mem->vaddr = vaddr;
> -
> -	memset(mem->vaddr, 0, bytes);
>   }
>   
>   static void swiotlb_init_io_tlb_mem(struct io_tlb_mem *mem, phys_addr_t start,
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
