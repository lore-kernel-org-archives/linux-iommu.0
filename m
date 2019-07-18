Return-Path: <SRS0=oZX7=VP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 517CEC76196
	for <iommu@archiver.kernel.org>; Thu, 18 Jul 2019 15:46:02 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E9CC208C0
	for <iommu@archiver.kernel.org>; Thu, 18 Jul 2019 15:46:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="0yy+Sydx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E9CC208C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id E7019187C;
	Thu, 18 Jul 2019 15:46:01 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id A268C1879
	for <iommu@lists.linux-foundation.org>;
	Thu, 18 Jul 2019 15:45:44 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from NAM01-BY2-obe.outbound.protection.outlook.com
	(mail-eopbgr810079.outbound.protection.outlook.com [40.107.81.79])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 615888A0
	for <iommu@lists.linux-foundation.org>;
	Thu, 18 Jul 2019 15:45:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
	b=KDdKtH8sUkBRn+OuUTTnXATa9T/91lyZGQCHfAO5nAGxEa3nQ905mM8Ul0kfQh2VfoX9T07Bq9CLQ+DggMbdY8hlePwb3AtPfigg9B4iEarKSMlP/H3ng/vrTMXcIeTRHGNsNl/WOZjuxgFw6iSEDW60/BVu5SCfr6cCm/cuWFKDHOyOWz3kRXp3IztLDBDe6DEtGRtJPFVG0ABQfRAH5em5dWhRIcFeada4afTekva3Gc2VPkF82Qk7QMLg0tMrOe7wtYvy55OkHkzF1gZbn0Jo/Y9R3/flHCd/y7DanDanRjVl/dOrOTfOlvqirC0C/qdl6y9j0dCV8giljkAGFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
	s=arcselector9901;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=5kDhGC5v8hBWCYdTegwihvnBbV1lEFQX/o+PT+cXgik=;
	b=KuM8T1MxIMktF8pHv9HCekOiYdVGm1J3NziSq82BGJyK7KmbxwPRTJFAmKcD1igztny4HCwL28xEcpdZrXSWVwvtbJHpoOp0N73NDv4c7xCJsKW4gFanL1o+okY1yenepqvAVxxAHEHZF6Gwq68FArlUE/rQTo23SPnmLWhJgdCyQdmqtsWrAftg7IkFpx7rfmD3fBeT0sRo3U1PoISzSVsDuY+rTHVl+WmoZrzDZmaj2XuZrLRZLVB36o0yTEI8CKGtZx0NqzmsP5BnEX2UQbxvHOAwEoE9KctE138Z74WvVe+0aULgnhst8+pGTnNlgl7bPpc6PD00GYVv+kXUDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
	smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com;
	dkim=pass header.d=amd.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=5kDhGC5v8hBWCYdTegwihvnBbV1lEFQX/o+PT+cXgik=;
	b=0yy+Sydx2o98zFYdMDcd+gw2bCozP8kTygELSU5QyQowtTFXHWdf6+DMNKI2sPFMIc4bySbcIB5QVImk4uYrhlcw5+rkPBYhp1u3ml7aLmC+ACLY+acrg3hNHXYEj2BfK2GywpJEGnqLgwuQcJFHZhZ6RBRVKYO82zSPNZJiHdg=
Received: from DM6PR12MB3163.namprd12.prod.outlook.com (20.179.104.150) by
	DM6PR12MB3147.namprd12.prod.outlook.com (20.178.31.93) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.2094.14; Thu, 18 Jul 2019 15:45:37 +0000
Received: from DM6PR12MB3163.namprd12.prod.outlook.com
	([fe80::9c3d:8593:906c:e4f7]) by
	DM6PR12MB3163.namprd12.prod.outlook.com
	([fe80::9c3d:8593:906c:e4f7%6]) with mapi id 15.20.2073.012;
	Thu, 18 Jul 2019 15:45:37 +0000
From: "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
To: Christoph Hellwig <hch@infradead.org>, Al Farleigh <AWFour@charter.net>
Subject: Re: x86-64 kernel dma issue; bisected
Thread-Topic: x86-64 kernel dma issue; bisected
Thread-Index: AQHVPUuW1SAvwACtPUa6izGd6UaPdqbQhRcA
Date: Thu, 18 Jul 2019 15:45:37 +0000
Message-ID: <980c809c-0aed-566d-e0c9-48f3fad64256@amd.com>
References: <c04211d3-5e4a-daa2-4410-88c8c84e5735@charter.net>
	<20190718093129.GA25126@infradead.org>
In-Reply-To: <20190718093129.GA25126@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN1PR12CA0113.namprd12.prod.outlook.com
	(2603:10b6:802:21::48) To DM6PR12MB3163.namprd12.prod.outlook.com
	(2603:10b6:5:182::22)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=Thomas.Lendacky@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c6131576-89f1-4f6a-42f9-08d70b96faaa
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);
	SRVR:DM6PR12MB3147; 
x-ms-traffictypediagnostic: DM6PR12MB3147:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <DM6PR12MB314775C81C0A457E9CDA9EABECC80@DM6PR12MB3147.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 01026E1310
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10009020)(4636009)(136003)(396003)(366004)(376002)(346002)(39860400002)(189003)(199004)(966005)(66946007)(14454004)(66066001)(6246003)(31686004)(53936002)(68736007)(66556008)(36756003)(64756008)(66446008)(2906002)(66476007)(8936002)(14444005)(256004)(6486002)(478600001)(6306002)(81156014)(81166006)(4326008)(31696002)(305945005)(52116002)(5660300002)(7736002)(86362001)(486006)(6116002)(25786009)(3846002)(6512007)(76176011)(8676002)(6436002)(11346002)(446003)(2616005)(476003)(229853002)(99286004)(53546011)(110136005)(6506007)(386003)(102836004)(71200400001)(71190400001)(316002)(186003)(26005);
	DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3147;
	H:DM6PR12MB3163.namprd12.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: yJLpPRVM3KuWX29uoS2cc3DiUhSXYNw11ip7xCIFgu9YxwWxMjuJSqdGoAdKgnNs0mB/oISMo9mCnSYaRl1veEWmMtPjbdKr4mnv2ZpTeUDjd1WeKRLjRgdhaPSIENBE4ojAdTohs7S53fXp9ihLC7YMHY3Xtv1vnQStOyxUvSybQKpY6C22V5HJKtGakDMb7hY2BS5JkVy0Me6Xfo/3QcbmOHgq9Y8KVYjKuA1ii66oy6l05Zpm0W6JYFDMJMtWkrbGw18vDh5hcgA+g9lvf/tsq07uV32h/3sv0dLBpJm+oQjqcisFeHBHR/57+kqde59iJkzf421saPJyvtEY39FwhvAjtI5vDujdhKkeRYLqJkSoagCGDxRx7MkX0gylNW2Wr+rgezHx5rDg5Ix6K5IQTBFH6h8nxdGe1JczAoM=
Content-ID: <38B73B43588BA04FA8EEDEE7DCD9626D@namprd12.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6131576-89f1-4f6a-42f9-08d70b96faaa
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2019 15:45:37.6685 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tlendack@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3147
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On 7/18/19 4:31 AM, Christoph Hellwig wrote:
> On Tue, Jul 16, 2019 at 10:43:33PM -0400, Al Farleigh wrote:
>> re: the dma-direct code commit below
>>
>> I have bisected the kernel to isolate a PCI board problem on my AMD x86-64
>> ASROCK system. The board worked at (Fedora kernel) 4.18.16 but stopped when
>> moving to (Fedora kernel) 5.0. I then used (git/torvalds/linux) 4.20-rc4 or
>> so to locate the fault via bisect.
>>
>> I now have two kernels, good/bad, that straddle the commit.
>>
>> I was asked to try v5.2 just in case it was fixed; I compiled it and the
>> fault appears to still be present.
>>
>> Simply, mpeg video does not stream from board; no errors, but no video.
>>
>> My work is documented at
>> https://bugs.kde.org/show_bug.cgi?id=408004
> 
> I've looked through that log but I'm still not sure what driver
> you are actually using for video capture.  Am I right in that your
> are using the saa7134 driver based on the dmesg?
> 
> That driver uses a 32-bit DMA mask, so we should be bounce buffering.
> 
> We recently had a bug with the AMD memory encryption and the encrypted
> bit, are you using that?  The "Freeing unused decrypted memory:" message
> somehow suggests that but I can't find where that would come from by a
> simple grep.  If your are using AMD memory encryption or are not sure
> please try the patch below:

Based on the dmesg, this is a family 15h processor, so it doesn't support
memory encryption.

The "Freeing unused decrypted memory:" message is a special section in
support of memory encryption, but since memory encryption isn't active,
it is all freed.

So I suspect this is a different issue.

Thanks,
Tom

> 
> ---
> From 9087c37584fb7d8315877bb55f85e4268cc0b4f4 Mon Sep 17 00:00:00 2001
> From: Tom Lendacky <thomas.lendacky@amd.com>
> Date: Wed, 10 Jul 2019 19:01:19 +0000
> Subject: dma-direct: Force unencrypted DMA under SME for certain DMA masks
> 
> If a device doesn't support DMA to a physical address that includes the
> encryption bit (currently bit 47, so 48-bit DMA), then the DMA must
> occur to unencrypted memory. SWIOTLB is used to satisfy that requirement
> if an IOMMU is not active (enabled or configured in passthrough mode).
> 
> However, commit fafadcd16595 ("swiotlb: don't dip into swiotlb pool for
> coherent allocations") modified the coherent allocation support in
> SWIOTLB to use the DMA direct coherent allocation support. When an IOMMU
> is not active, this resulted in dma_alloc_coherent() failing for devices
> that didn't support DMA addresses that included the encryption bit.
> 
> Addressing this requires changes to the force_dma_unencrypted() function
> in kernel/dma/direct.c. Since the function is now non-trivial and
> SME/SEV specific, update the DMA direct support to add an arch override
> for the force_dma_unencrypted() function. The arch override is selected
> when CONFIG_AMD_MEM_ENCRYPT is set. The arch override function resides in
> the arch/x86/mm/mem_encrypt.c file and forces unencrypted DMA when either
> SEV is active or SME is active and the device does not support DMA to
> physical addresses that include the encryption bit.
> 
> Fixes: fafadcd16595 ("swiotlb: don't dip into swiotlb pool for coherent allocations")
> Suggested-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
> Acked-by: Thomas Gleixner <tglx@linutronix.de>
> [hch: moved the force_dma_unencrypted declaration to dma-mapping.h,
>       fold the s390 fix from Halil Pasic]
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/s390/Kconfig          |  1 +
>  arch/s390/mm/init.c        |  7 ++++++-
>  arch/x86/Kconfig           |  1 +
>  arch/x86/mm/mem_encrypt.c  | 30 ++++++++++++++++++++++++++++++
>  include/linux/dma-direct.h |  9 +++++++++
>  kernel/dma/Kconfig         |  3 +++
>  kernel/dma/direct.c        | 16 ++++------------
>  7 files changed, 54 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
> index 5d8570ed6cab..a4ad2733eedf 100644
> --- a/arch/s390/Kconfig
> +++ b/arch/s390/Kconfig
> @@ -189,6 +189,7 @@ config S390
>  	select VIRT_CPU_ACCOUNTING
>  	select ARCH_HAS_SCALED_CPUTIME
>  	select HAVE_NMI
> +	select ARCH_HAS_FORCE_DMA_UNENCRYPTED
>  	select SWIOTLB
>  	select GENERIC_ALLOCATOR
>  
> diff --git a/arch/s390/mm/init.c b/arch/s390/mm/init.c
> index f0bee6af3960..78c319c5ce48 100644
> --- a/arch/s390/mm/init.c
> +++ b/arch/s390/mm/init.c
> @@ -30,7 +30,7 @@
>  #include <linux/export.h>
>  #include <linux/cma.h>
>  #include <linux/gfp.h>
> -#include <linux/dma-mapping.h>
> +#include <linux/dma-direct.h>
>  #include <asm/processor.h>
>  #include <linux/uaccess.h>
>  #include <asm/pgtable.h>
> @@ -161,6 +161,11 @@ bool sev_active(void)
>  	return is_prot_virt_guest();
>  }
>  
> +bool force_dma_unencrypted(struct device *dev)
> +{
> +	return sev_active();
> +}
> +
>  /* protected virtualization */
>  static void pv_init(void)
>  {
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 879741336771..d1afe92bf994 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -1528,6 +1528,7 @@ config AMD_MEM_ENCRYPT
>  	depends on X86_64 && CPU_SUP_AMD
>  	select DYNAMIC_PHYSICAL_MASK
>  	select ARCH_USE_MEMREMAP_PROT
> +	select ARCH_HAS_FORCE_DMA_UNENCRYPTED
>  	---help---
>  	  Say yes to enable support for the encryption of system memory.
>  	  This requires an AMD processor that supports Secure Memory
> diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
> index e0df96fdfe46..c805f0a5c16e 100644
> --- a/arch/x86/mm/mem_encrypt.c
> +++ b/arch/x86/mm/mem_encrypt.c
> @@ -15,6 +15,10 @@
>  #include <linux/dma-direct.h>
>  #include <linux/swiotlb.h>
>  #include <linux/mem_encrypt.h>
> +#include <linux/device.h>
> +#include <linux/kernel.h>
> +#include <linux/bitops.h>
> +#include <linux/dma-mapping.h>
>  
>  #include <asm/tlbflush.h>
>  #include <asm/fixmap.h>
> @@ -348,6 +352,32 @@ bool sev_active(void)
>  }
>  EXPORT_SYMBOL(sev_active);
>  
> +/* Override for DMA direct allocation check - ARCH_HAS_FORCE_DMA_UNENCRYPTED */
> +bool force_dma_unencrypted(struct device *dev)
> +{
> +	/*
> +	 * For SEV, all DMA must be to unencrypted addresses.
> +	 */
> +	if (sev_active())
> +		return true;
> +
> +	/*
> +	 * For SME, all DMA must be to unencrypted addresses if the
> +	 * device does not support DMA to addresses that include the
> +	 * encryption mask.
> +	 */
> +	if (sme_active()) {
> +		u64 dma_enc_mask = DMA_BIT_MASK(__ffs64(sme_me_mask));
> +		u64 dma_dev_mask = min_not_zero(dev->coherent_dma_mask,
> +						dev->bus_dma_mask);
> +
> +		if (dma_dev_mask <= dma_enc_mask)
> +			return true;
> +	}
> +
> +	return false;
> +}
> +
>  /* Architecture __weak replacement functions */
>  void __init mem_encrypt_free_decrypted_mem(void)
>  {
> diff --git a/include/linux/dma-direct.h b/include/linux/dma-direct.h
> index b7338702592a..adf993a3bd58 100644
> --- a/include/linux/dma-direct.h
> +++ b/include/linux/dma-direct.h
> @@ -32,6 +32,15 @@ static inline bool dma_capable(struct device *dev, dma_addr_t addr, size_t size)
>  }
>  #endif /* !CONFIG_ARCH_HAS_PHYS_TO_DMA */
>  
> +#ifdef CONFIG_ARCH_HAS_FORCE_DMA_UNENCRYPTED
> +bool force_dma_unencrypted(struct device *dev);
> +#else
> +static inline bool force_dma_unencrypted(struct device *dev)
> +{
> +	return false;
> +}
> +#endif /* CONFIG_ARCH_HAS_FORCE_DMA_UNENCRYPTED */
> +
>  /*
>   * If memory encryption is supported, phys_to_dma will set the memory encryption
>   * bit in the DMA address, and dma_to_phys will clear it.  The raw __phys_to_dma
> diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig
> index 70f8f8d9200e..9decbba255fc 100644
> --- a/kernel/dma/Kconfig
> +++ b/kernel/dma/Kconfig
> @@ -48,6 +48,9 @@ config ARCH_HAS_DMA_COHERENT_TO_PFN
>  config ARCH_HAS_DMA_MMAP_PGPROT
>  	bool
>  
> +config ARCH_HAS_FORCE_DMA_UNENCRYPTED
> +	bool
> +
>  config DMA_NONCOHERENT_CACHE_SYNC
>  	bool
>  
> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index b90e1aede743..d7cec866d16b 100644
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -23,14 +23,6 @@
>  #define ARCH_ZONE_DMA_BITS 24
>  #endif
>  
> -/*
> - * For AMD SEV all DMA must be to unencrypted addresses.
> - */
> -static inline bool force_dma_unencrypted(void)
> -{
> -	return sev_active();
> -}
> -
>  static void report_addr(struct device *dev, dma_addr_t dma_addr, size_t size)
>  {
>  	if (!dev->dma_mask) {
> @@ -46,7 +38,7 @@ static void report_addr(struct device *dev, dma_addr_t dma_addr, size_t size)
>  static inline dma_addr_t phys_to_dma_direct(struct device *dev,
>  		phys_addr_t phys)
>  {
> -	if (force_dma_unencrypted())
> +	if (force_dma_unencrypted(dev))
>  		return __phys_to_dma(dev, phys);
>  	return phys_to_dma(dev, phys);
>  }
> @@ -67,7 +59,7 @@ static gfp_t __dma_direct_optimal_gfp_mask(struct device *dev, u64 dma_mask,
>  	if (dev->bus_dma_mask && dev->bus_dma_mask < dma_mask)
>  		dma_mask = dev->bus_dma_mask;
>  
> -	if (force_dma_unencrypted())
> +	if (force_dma_unencrypted(dev))
>  		*phys_mask = __dma_to_phys(dev, dma_mask);
>  	else
>  		*phys_mask = dma_to_phys(dev, dma_mask);
> @@ -159,7 +151,7 @@ void *dma_direct_alloc_pages(struct device *dev, size_t size,
>  	}
>  
>  	ret = page_address(page);
> -	if (force_dma_unencrypted()) {
> +	if (force_dma_unencrypted(dev)) {
>  		set_memory_decrypted((unsigned long)ret, 1 << get_order(size));
>  		*dma_handle = __phys_to_dma(dev, page_to_phys(page));
>  	} else {
> @@ -192,7 +184,7 @@ void dma_direct_free_pages(struct device *dev, size_t size, void *cpu_addr,
>  		return;
>  	}
>  
> -	if (force_dma_unencrypted())
> +	if (force_dma_unencrypted(dev))
>  		set_memory_encrypted((unsigned long)cpu_addr, 1 << page_order);
>  
>  	if (IS_ENABLED(CONFIG_ARCH_HAS_UNCACHED_SEGMENT) &&
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
