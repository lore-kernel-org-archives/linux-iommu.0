Return-Path: <SRS0=OQvg=FN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C034C4361B
	for <iommu@archiver.kernel.org>; Wed,  9 Dec 2020 19:34:31 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEAF123C90
	for <iommu@archiver.kernel.org>; Wed,  9 Dec 2020 19:34:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEAF123C90
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 9046587B01;
	Wed,  9 Dec 2020 19:34:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VMEHi07tvJa0; Wed,  9 Dec 2020 19:34:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 94B1E87ABB;
	Wed,  9 Dec 2020 19:34:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6746FC0893;
	Wed,  9 Dec 2020 19:34:29 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C5509C013B
 for <iommu@lists.linux-foundation.org>; Wed,  9 Dec 2020 19:34:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id BE5C986D61
 for <iommu@lists.linux-foundation.org>; Wed,  9 Dec 2020 19:34:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pWrNRzjM9Opo for <iommu@lists.linux-foundation.org>;
 Wed,  9 Dec 2020 19:34:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2049.outbound.protection.outlook.com [40.107.220.49])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 7ED5B86D28
 for <iommu@lists.linux-foundation.org>; Wed,  9 Dec 2020 19:34:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZuQQxOuS1Fb/KglYqU8e8t9S1/njUIofqg20kOq8ybtnG/QR5/0+ui5lpjWR8XZCFpWSPSWJLVaI9Eo9kC6pEutW1cBQiQ+uGRYgHU38QE9yM+6apQPEiFeq7DVuCEteXVpluuyQmVfO3isAh3ipufJ3VZhk85rkJlK20cC+RgFyVTy+Gt1ReJ5zQUQPLrFcMTkFFh0iQrYKemAjdxK+gcSGsMTy0MeSts3jjNpB9nVfrkTMZo+oSpJercBYF13J3s99mpS10QU8lUqlUIDAyu3PBr41+0IGzHE/+vM5o/ao1FZbwwvd8MDRkBnkZZlyiQpOOtwPHFMBHHuK3lmPtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FxdkVFPosi1spsl3lm5nD+1mSICujk+qiRhj0+WhS+o=;
 b=JdF+r3g02hlBpht31V5K5OOQnqDT6c5lGaObNHsP85ehhapBt4ZNHj65cm9D1YNoJNhHnHy5wyc3fDVsfeogrfPpSbGvsBqcboGuq130/PpIkXOFk7gGdRLrNgsN+uDIwH6cH0igIoYtZWiDyx59ppveVUNTAZtHT/yp4JfCE5kViCo79On+g442R1KyagVi7HYX677aFXOEIkUbUG4Yc7BzanDy7FgqBvqF3DCzhyYhkg03rA1W6miinBtaiCZop3scr1VgD4Ybfvz3D7FTKTLW31shGYCPd+fsM37s652FhXigiVbktLW6soGaDtcUexv3hfCFO4xA0oohj6h09w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FxdkVFPosi1spsl3lm5nD+1mSICujk+qiRhj0+WhS+o=;
 b=a7xpyxXMyKi0dOwT+lWdSz1HX0oVVMy911EIVuw8xSlTj9cQTHEAlYVeowJIdVZSKd38FsSBvZ4+kE7gW/VefOxKPnWZyAYGezngge+Zm6AobCUBCrrYEkj7TPLu5JVZVeB+d/EwwPC60CbxypnQC08TGV6CElnYdb+TP9SGb6M=
Authentication-Results: alien8.de; dkim=none (message not signed)
 header.d=none;alien8.de; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2767.namprd12.prod.outlook.com (2603:10b6:805:75::23)
 by SN1PR12MB2366.namprd12.prod.outlook.com (2603:10b6:802:25::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12; Wed, 9 Dec
 2020 19:34:23 +0000
Received: from SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::d8f2:fde4:5e1d:afec]) by SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::d8f2:fde4:5e1d:afec%3]) with mapi id 15.20.3632.021; Wed, 9 Dec 2020
 19:34:23 +0000
Date: Wed, 9 Dec 2020 19:34:16 +0000
From: Ashish Kalra <ashish.kalra@amd.com>
To: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v8] swiotlb: Adjust SWIOTBL bounce buffer size for SEV
 guests.
Message-ID: <20201209193416.GA6807@ashkalra_ubuntu_server>
References: <20201207231057.26403-1-Ashish.Kalra@amd.com>
 <20201209110115.GA18203@zn.tnic>
 <20201209122907.GA6258@ashkalra_ubuntu_server>
 <20201209125442.GC18203@zn.tnic>
 <20201209131946.GA6495@ashkalra_ubuntu_server>
 <20201209175105.GD18203@zn.tnic>
Content-Disposition: inline
In-Reply-To: <20201209175105.GD18203@zn.tnic>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: CH0PR04CA0021.namprd04.prod.outlook.com
 (2603:10b6:610:76::26) To SN6PR12MB2767.namprd12.prod.outlook.com
 (2603:10b6:805:75::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ashkalra_ubuntu_server (165.204.77.1) by
 CH0PR04CA0021.namprd04.prod.outlook.com (2603:10b6:610:76::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3654.12 via Frontend Transport; Wed, 9 Dec 2020 19:34:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7c7849b9-097a-4369-3e9c-08d89c796ef0
X-MS-TrafficTypeDiagnostic: SN1PR12MB2366:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB2366443774A77FBFC0F4D0408ECC0@SN1PR12MB2366.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4X+iYCzU2IWixhnf+CBO5jxYoReaJoLLSa4QXaJMGcWrclrVPLdIeG8o6FwE9T5Xt+IJV3TzuvPj3RMxmD9SF5Xo4E8O9a09Sbl6hZD5JH5XhsJhAMsYWIFutRRY5Wh82U5w6gbU/XvDaHzohmtE+rHYdBsoHtR7R8G1z2odhlqxPhrfwYP26Co1+AjRK+fEDy8ZTuaqd7zSOPCwyYNZXMYSOyHtEdKFWU+gN8aCmP50EaA8I9Dg7xPd+9ttz3hsoHqDvEEqsSsGFbVUwr0YUalqLvvpAWWBZVI3fN2ZBcLXBAYn5BrBBsqr28pVkJ3Fkspu56PtSPpH9APCYFZEBFID3hJoii3Q5e103mMwhsVYgKEbPY6yFlFeehgAFmiEZts4WSEhW9KOI/YxqsBSmfIUs3OKV+EE+HUY69XH3S4EMdSV9mjaGyrs4/DpxF0tCZowqY50N4bm+0FFM9Tygw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR12MB2767.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(136003)(366004)(376002)(52116002)(8676002)(33716001)(956004)(55016002)(9686003)(44832011)(1076003)(6916009)(86362001)(8936002)(6496006)(45080400002)(66476007)(966005)(508600001)(26005)(186003)(16526019)(4326008)(66946007)(2906002)(7416002)(66556008)(6666004)(5660300002)(33656002)(34490700003)(83380400001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?oE7xC6BOR62+2VVTZoarhMjDr+aZsY4sLWCdcvtb48G4XxDLuH6tvMPRJqj2?=
 =?us-ascii?Q?N4mEQ94pDwX/lKxi02T07ekp02Yqn/UrihLlxsPtLsKayL6MX5xD/ZT/3x5l?=
 =?us-ascii?Q?qcKx+v+zN51iPAEC/wQIl5mosVM6z6rEvyH08nLcZ1d62WgDsvg/SOFGRxky?=
 =?us-ascii?Q?Q/Iw4qMJC3oj0IY4a+AC+n3EOX5td/wapaN6B+r6NNgbV2oW/Wq+S7g82HC+?=
 =?us-ascii?Q?PDcZ8WcLOKzr8N9CRdB3KJ8NXi5HP922LVn121JxFVG/qoYbNZwQtedlq33F?=
 =?us-ascii?Q?RFB7T1fEtQL9HnBgmB1iIwGL5XcXU1e2k/M1Z3Yl0a9dFYqZYRiYtEWPsh2N?=
 =?us-ascii?Q?zMWdDVJ3pUdt0O/Iu1J0faDIOpmbZIvQZRzgP8vxea5L7+JEwX2bzWfprBAH?=
 =?us-ascii?Q?6f+Ix7ZFnobOaCJT64cGI7BAaZYbQYrOgtAbXcAvsTS/SKMzbmv6augbsgW9?=
 =?us-ascii?Q?JApppkt1U03Lpao9sddbcXn3MGyF7y1H9GMgwXm3A1HxetHarZHqXk4AiGYj?=
 =?us-ascii?Q?JyDpeIptTXyb6K+JS+mGFptIfYSXURnBXaCHSvOxMH7W+L3L1h+qGkcXaIIz?=
 =?us-ascii?Q?jMjJf7pU1OrLscY+/d7aCY8KNLTDtg6Pz16PGfRnr07BSPoXb8koeufgqoSK?=
 =?us-ascii?Q?iOv4BZgMeBkjz+59dXpbm0OwPOXZ3TV9jbiPTbnml4F50ecn9ltPaGXgRksJ?=
 =?us-ascii?Q?+MUh1G6HqON62WTxu6W3+rXG4iMm10jr5NGM+Pe9qxjIWKL8pL4hLAC93SdX?=
 =?us-ascii?Q?GcpjOhRq2ywCPC+3fJbDnYgfjMST/Nt2l4qIcYlwo8GdF5rDs34TO1zrCwot?=
 =?us-ascii?Q?Vrj7/OKbRy3OQ59AsrTu5Qm9xXv/1BrHMLEssZ/QZTx8LyAfEyZn28ilEebk?=
 =?us-ascii?Q?LPLIgg+keQ+z4J8lv4qrhQTxWC9wFfqiaIeSdsxkihopo0haJsmPeUMlnIU4?=
 =?us-ascii?Q?bNzL7g7/uV1STnHUfvb2WecYs3q6nK201M92dQRW5s9mMyGXtZnVCwpgzpKn?=
 =?us-ascii?Q?vYPc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2767.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2020 19:34:23.8379 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c7849b9-097a-4369-3e9c-08d89c796ef0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NXyQopaocKVjSIxvmLtV5cpFS0LXsPpiL8lnxKqp1+uq0G/EN4cx+nIBxmfgAqeqtqgQaLbVIZ3Yo5/u1AwlmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2366
Cc: Thomas.Lendacky@amd.com, Jon.Grimm@amd.com, brijesh.singh@amd.com,
 dave.hansen@linux-intel.com, konrad.wilk@oracle.com, peterz@infradead.org,
 x86@kernel.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 mingo@redhat.com, luto@kernel.org, hpa@zytor.com, rientjes@google.com,
 tglx@linutronix.de, hch@lst.de
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Wed, Dec 09, 2020 at 06:51:05PM +0100, Borislav Petkov wrote:
> On Wed, Dec 09, 2020 at 01:19:46PM +0000, Ashish Kalra wrote:
> > reserve_crashkernel() calls swiotlb_size_or_default() to get SWIOTLB
> ...
> 
> Thanks for explaining.
> 
> > There is a need to introduce an architecture specific callback
> > for swiotlb_adjust() because of the following reason :
> 
> So what your version currently does is:
> 
> 1. from arch code, call generic code - swiotlb_adjust
> 
> 2. in generic code, call back into arch code - arch_swiotlb_adjust
> 
> But that's twice the work needed to get you where you wanna go.
> 
> What you wanna do is, from arch code, call into swiotlb generic code.
> That's it, no more.
> 
> Just like mem_encrypt.c calls swiotlb_update_mem_attributes(), for
> example.
> 
> And other architectures can simply do the same thing and you have it all
> solved and other architectures don't even need to refactor - they simply
> copy what x86 does.
> 
> IOW, something like this:
> 

This should work, but i am concerned about making IO_TLB_DEFAULT_SIZE
(which is pretty much private to generic swiotlb code) to be visible
externally, i don't know if there are any concerns with that ?

Thanks,
Ashish

> ---
> diff --git a/arch/x86/include/asm/mem_encrypt.h b/arch/x86/include/asm/mem_encrypt.h
> index 2f62bbdd9d12..31c4df123aa0 100644
> --- a/arch/x86/include/asm/mem_encrypt.h
> +++ b/arch/x86/include/asm/mem_encrypt.h
> @@ -37,6 +37,7 @@ void __init sme_map_bootdata(char *real_mode_data);
>  void __init sme_unmap_bootdata(char *real_mode_data);
>  
>  void __init sme_early_init(void);
> +void __init sev_setup_arch(void);
>  
>  void __init sme_encrypt_kernel(struct boot_params *bp);
>  void __init sme_enable(struct boot_params *bp);
> @@ -69,6 +70,7 @@ static inline void __init sme_map_bootdata(char *real_mode_data) { }
>  static inline void __init sme_unmap_bootdata(char *real_mode_data) { }
>  
>  static inline void __init sme_early_init(void) { }
> +static inline void __init sev_setup_arch(void) { }
>  
>  static inline void __init sme_encrypt_kernel(struct boot_params *bp) { }
>  static inline void __init sme_enable(struct boot_params *bp) { }
> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> index a23130c86bdd..740f3bdb3f61 100644
> --- a/arch/x86/kernel/setup.c
> +++ b/arch/x86/kernel/setup.c
> @@ -1049,6 +1049,12 @@ void __init setup_arch(char **cmdline_p)
>  	memblock_set_current_limit(ISA_END_ADDRESS);
>  	e820__memblock_setup();
>  
> +	/*
> +	 * Needs to run after memblock setup because it needs the physical
> +	 * memory size.
> +	 */
> +	sev_setup_arch();
> +
>  	reserve_bios_regions();
>  
>  	efi_fake_memmap();
> diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
> index bc0833713be9..f3db85673eae 100644
> --- a/arch/x86/mm/mem_encrypt.c
> +++ b/arch/x86/mm/mem_encrypt.c
> @@ -198,6 +198,37 @@ void __init sme_early_init(void)
>  		swiotlb_force = SWIOTLB_FORCE;
>  }
>  
> +void __init sev_setup_arch(void)
> +{
> +	phys_addr_t total_mem = memblock_phys_mem_size();
> +	unsigned long size;
> +
> +	if (!sev_active())
> +		return;
> +
> +	/*
> +	 * For SEV, all DMA has to occur via shared/unencrypted pages.
> +	 * SEV uses SWOTLB to make this happen without changing device
> +	 * drivers. However, depending on the workload being run, the
> +	 * default 64MB of SWIOTLB may not be enough and`SWIOTLB may
> +	 * run out of buffers for DMA, resulting in I/O errors and/or
> +	 * performance degradation especially with high I/O workloads.
> +	 *
> +	 * Adjust the default size of SWIOTLB for SEV guests using
> +	 * a percentage of guest memory for SWIOTLB buffers.
> +	 * Also as the SWIOTLB bounce buffer memory is allocated
> +	 * from low memory, ensure that the adjusted size is within
> +	 * the limits of low available memory.
> +	 *
> +	 * The percentage of guest memory used here for SWIOTLB buffers
> +	 * is more of an approximation of the static adjustment which
> +	 * 64MB for <1G, and ~128M to 256M for 1G-to-4G, i.e., the 6%
> +	 */
> +	size = total_mem * 6 / 100;
> +	size = clamp_val(size, IO_TLB_DEFAULT_SIZE, SZ_1G);
> +	swiotlb_adjust_size(size);
> +}
> +
>  static void __init __set_clr_pte_enc(pte_t *kpte, int level, bool enc)
>  {
>  	pgprot_t old_prot, new_prot;
> diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
> index fbdc65782195..7aa94e2f99c6 100644
> --- a/include/linux/swiotlb.h
> +++ b/include/linux/swiotlb.h
> @@ -30,6 +30,9 @@ enum swiotlb_force {
>   */
>  #define IO_TLB_SHIFT 11
>  
> +/* default to 64MB */
> +#define IO_TLB_DEFAULT_SIZE (64UL<<20)
> +
>  extern void swiotlb_init(int verbose);
>  int swiotlb_init_with_tbl(char *tlb, unsigned long nslabs, int verbose);
>  extern unsigned long swiotlb_nr_tbl(void);
> @@ -78,6 +81,7 @@ void __init swiotlb_exit(void);
>  unsigned int swiotlb_max_segment(void);
>  size_t swiotlb_max_mapping_size(struct device *dev);
>  bool is_swiotlb_active(void);
> +void __init swiotlb_adjust_size(unsigned long new_size);
>  #else
>  #define swiotlb_force SWIOTLB_NO_FORCE
>  static inline bool is_swiotlb_buffer(phys_addr_t paddr)
> @@ -100,6 +104,10 @@ static inline bool is_swiotlb_active(void)
>  {
>  	return false;
>  }
> +
> +static void swiotlb_adjust_size(unsigned long new_size)
> +{
> +}
>  #endif /* CONFIG_SWIOTLB */
>  
>  extern void swiotlb_print_info(void);
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index 781b9dca197c..7c42df6e6100 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -152,8 +152,6 @@ void swiotlb_set_max_segment(unsigned int val)
>  		max_segment = rounddown(val, PAGE_SIZE);
>  }
>  
> -/* default to 64MB */
> -#define IO_TLB_DEFAULT_SIZE (64UL<<20)
>  unsigned long swiotlb_size_or_default(void)
>  {
>  	unsigned long size;
> @@ -163,6 +161,24 @@ unsigned long swiotlb_size_or_default(void)
>  	return size ? size : (IO_TLB_DEFAULT_SIZE);
>  }
>  
> +void __init swiotlb_adjust_size(unsigned long new_size)
> +{
> +	unsigned long size;
> +
> +	/*
> +	 * If swiotlb parameter has not been specified, give a chance to
> +	 * architectures such as those supporting memory encryption to
> +	 * adjust/expand SWIOTLB size for their use.
> +	 */
> +	if (!io_tlb_nslabs) {
> +		size = ALIGN(new_size, 1 << IO_TLB_SHIFT);
> +		io_tlb_nslabs = size >> IO_TLB_SHIFT;
> +		io_tlb_nslabs = ALIGN(io_tlb_nslabs, IO_TLB_SEGSIZE);
> +
> +		pr_info("SWIOTLB bounce buffer size adjusted to %luMB", size >> 20);
> +	}
> +}
> +
>  void swiotlb_print_info(void)
>  {
>  	unsigned long bytes = io_tlb_nslabs << IO_TLB_SHIFT;
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpeople.kernel.org%2Ftglx%2Fnotes-about-netiquette&amp;data=04%7C01%7Cashish.kalra%40amd.com%7C426a6f6ef2334ac4f8e308d89c6b03cf%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637431330751727796%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=xdEJqIPZUvIRmKbvM9Zv%2BVLvoyNYlSejjSyQ3ip%2FiQ0%3D&amp;reserved=0
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
