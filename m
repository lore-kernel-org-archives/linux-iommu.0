Return-Path: <SRS0=oZX7=VP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DC11C7618F
	for <iommu@archiver.kernel.org>; Thu, 18 Jul 2019 17:42:44 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 198A421019
	for <iommu@archiver.kernel.org>; Thu, 18 Jul 2019 17:42:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="P85kKbAz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 198A421019
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id DCCB71AC5;
	Thu, 18 Jul 2019 17:42:43 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 92FBC1AB8
	for <iommu@lists.linux-foundation.org>;
	Thu, 18 Jul 2019 17:42:21 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from NAM03-DM3-obe.outbound.protection.outlook.com
	(mail-eopbgr800058.outbound.protection.outlook.com [40.107.80.58])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 0BEBB8EE
	for <iommu@lists.linux-foundation.org>;
	Thu, 18 Jul 2019 17:42:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
	b=drFoWFi3QIdUpTZPJN6g7kpRgJDTiQ15e9nNHzkX5BrZIj9vjaijqrVtlFO+aYcNIXWIMdb9mh7uQJ9k6WHsb/MzEhdhDLRRmdF3J6SnCcX0lgI2hnUP26uyLDq1sEXtWv+9HlftrIBJSj5Vx9W76yR8gFz+8f/vUsGxOSJXxvgOYuVU65/VDbGhAOmGg9iTnqvTPJoek2f7xTfoeL99pUZ+ytJA9NBs6MI4Cw6RaGLTPWIzKkwIftuVBM2bb+S/6N67GndU+NSt5iW7z8eDUwKCBCzHSuUD8Qg0B8Wtp73U8Vl86afpCvLL9OlqqJhr+L5Q2mSmrvRhVptNgH3K9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
	s=arcselector9901;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=pvk/f5VP0rQP3go5PWBd23rYzHqqAjPoZM7BgH7OsRg=;
	b=FUSce7XoDf6mdHF6tu5IhCykss2dSi3QaGahJBFmZLJQEMeYkK5qw0wsFXYh1jVQK6KlLtMU54ZIB+ozhYnhnbjk0GCoiJ9x2k08WRZb8/QHhE4cL3/fP3MSL40M1G0RnJyYAv+qey5pltwFxlQB1R/ee6yRebmHsM95wpiUB+tlrpC/dTOwQ2hoEDXE4mjP01X/jrx9q5P+EYeHF8RPIgGQJLFe1o0OjDEJhS4VH3skwHTSFBtrkf78gSMhkcWrgv1ADi30TeDsjXYmBsITqQKHq4lco8GuoD3ZtvHQA8Mv4MFfUzTGAyI0VI8ijQzx1Z6iWigoidAQZLmgkzfiBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
	smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com;
	dkim=pass header.d=amd.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=pvk/f5VP0rQP3go5PWBd23rYzHqqAjPoZM7BgH7OsRg=;
	b=P85kKbAze8Sv72t8t6NNr09QWiw7qxaEeuSPjmMETZcQIviw3tRabQbnOAoZUnHz/zSSEQUKFHrpN4uA/U5q03yb0r/TqE7xAWL1FgGinqlfbVvKVzHCL+XYsYBzlPOK1N29u9/3CE5vfSaxH14j46wD6bAdV951g/3q1Npeuyw=
Received: from DM6PR12MB3163.namprd12.prod.outlook.com (20.179.104.150) by
	DM6PR12MB4155.namprd12.prod.outlook.com (10.141.8.79) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.2094.11; Thu, 18 Jul 2019 17:42:19 +0000
Received: from DM6PR12MB3163.namprd12.prod.outlook.com
	([fe80::9c3d:8593:906c:e4f7]) by
	DM6PR12MB3163.namprd12.prod.outlook.com
	([fe80::9c3d:8593:906c:e4f7%6]) with mapi id 15.20.2073.012;
	Thu, 18 Jul 2019 17:42:19 +0000
From: "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
To: Thiago Jung Bauermann <bauerman@linux.ibm.com>, "x86@kernel.org"
	<x86@kernel.org>
Subject: Re: [PATCH v3 4/6] x86, s390/mm: Move sme_active() and sme_me_mask to
	x86-specific header
Thread-Topic: [PATCH v3 4/6] x86, s390/mm: Move sme_active() and sme_me_mask to
	x86-specific header
Thread-Index: AQHVPRkIrZFaM8Ikf0iyeedsy3NkD6bQphUA
Date: Thu, 18 Jul 2019 17:42:18 +0000
Message-ID: <cf48e778-130a-df2a-d94b-170bd85d692c@amd.com>
References: <20190718032858.28744-1-bauerman@linux.ibm.com>
	<20190718032858.28744-5-bauerman@linux.ibm.com>
In-Reply-To: <20190718032858.28744-5-bauerman@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0601CA0011.namprd06.prod.outlook.com
	(2603:10b6:803:2f::21) To DM6PR12MB3163.namprd12.prod.outlook.com
	(2603:10b6:5:182::22)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=Thomas.Lendacky@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e2f5b774-a586-49e3-bac1-08d70ba747c9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);
	SRVR:DM6PR12MB4155; 
x-ms-traffictypediagnostic: DM6PR12MB4155:
x-microsoft-antispam-prvs: <DM6PR12MB4155B4A78E4C1B6E78FB1125ECC80@DM6PR12MB4155.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 01026E1310
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10009020)(4636009)(39860400002)(136003)(366004)(396003)(346002)(376002)(199004)(189003)(8676002)(2501003)(478600001)(3846002)(6116002)(36756003)(71200400001)(66446008)(7736002)(66556008)(66476007)(64756008)(66946007)(81166006)(81156014)(66066001)(305945005)(71190400001)(7416002)(6512007)(8936002)(6246003)(6486002)(53936002)(68736007)(6436002)(6506007)(2616005)(2906002)(76176011)(53546011)(446003)(110136005)(256004)(5660300002)(54906003)(11346002)(316002)(4326008)(476003)(486006)(25786009)(31696002)(186003)(86362001)(102836004)(26005)(31686004)(386003)(229853002)(52116002)(14454004)(99286004);
	DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB4155;
	H:DM6PR12MB3163.namprd12.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: aMBv+p0O8PA0MM8nKZUp/HxXHBQnrfAOt9MtrdR2SoniYa4Cz1m0lGkDQYde+tILo4j8ju8zrSNhKu0mEFGAuzKkxJWHAbzKQawG1cycc9Rlv8K5lVh1PZnZAjuaZlcHX10vw/uqBVd5MgaUD9kqtAqdQ3r8xvkfeE5Q/1s+kW5dBlKFF2mV1vhIa3nZaiXf6PHe0hqcCoKc4RamCio/q8K+nqyAU/0I1CjBW3TQ6arH8PTXg5FLJem/MWGrASE1VXZrdqWwW/R14WIM900avU2jreQncGr3ZKotidTCQOsVBOdgrpEWPIt2YUyGEVUyZpCYsh+1p6HYdl+jBr6h4P4lYekgp4IedmVvNEwypDu27NL0amvxEcC3TgDUr9YrB4LxsT63DrxM4OB3HCcOQebwpMqmOkicuTPxTWbcJ+s=
Content-ID: <D30328A1E6D7174797D57B6D36556B92@namprd12.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2f5b774-a586-49e3-bac1-08d70ba747c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2019 17:42:18.9170 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tlendack@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4155
Cc: "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Robin Murphy <robin.murphy@arm.com>, Mike Anderson <andmike@linux.ibm.com>,
	Ram Pai <linuxram@us.ibm.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Alexey Dobriyan <adobriyan@gmail.com>, Halil Pasic <pasic@linux.ibm.com>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	Christoph Hellwig <hch@lst.de>
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

On 7/17/19 10:28 PM, Thiago Jung Bauermann wrote:
> Now that generic code doesn't reference them, move sme_active() and
> sme_me_mask to x86's <asm/mem_encrypt.h>.
> 
> Also remove the export for sme_active() since it's only used in files that
> won't be built as modules. sme_me_mask on the other hand is used in
> arch/x86/kvm/svm.c (via __sme_set() and __psp_pa()) which can be built as a
> module so its export needs to stay.

You may want to try and build the out-of-tree nvidia driver just to be
sure you can remove the EXPORT_SYMBOL(). But I believe that was related
to the DMA mask check, which now removed, may no longer be a problem.

> 
> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>

Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>

> ---
>  arch/s390/include/asm/mem_encrypt.h |  4 +---
>  arch/x86/include/asm/mem_encrypt.h  | 10 ++++++++++
>  arch/x86/mm/mem_encrypt.c           |  1 -
>  include/linux/mem_encrypt.h         | 14 +-------------
>  4 files changed, 12 insertions(+), 17 deletions(-)
> 
> diff --git a/arch/s390/include/asm/mem_encrypt.h b/arch/s390/include/asm/mem_encrypt.h
> index 3eb018508190..ff813a56bc30 100644
> --- a/arch/s390/include/asm/mem_encrypt.h
> +++ b/arch/s390/include/asm/mem_encrypt.h
> @@ -4,9 +4,7 @@
>  
>  #ifndef __ASSEMBLY__
>  
> -#define sme_me_mask	0ULL
> -
> -static inline bool sme_active(void) { return false; }
> +static inline bool mem_encrypt_active(void) { return false; }
>  extern bool sev_active(void);
>  
>  int set_memory_encrypted(unsigned long addr, int numpages);
> diff --git a/arch/x86/include/asm/mem_encrypt.h b/arch/x86/include/asm/mem_encrypt.h
> index 0c196c47d621..848ce43b9040 100644
> --- a/arch/x86/include/asm/mem_encrypt.h
> +++ b/arch/x86/include/asm/mem_encrypt.h
> @@ -92,6 +92,16 @@ early_set_memory_encrypted(unsigned long vaddr, unsigned long size) { return 0;
>  
>  extern char __start_bss_decrypted[], __end_bss_decrypted[], __start_bss_decrypted_unused[];
>  
> +static inline bool mem_encrypt_active(void)
> +{
> +	return sme_me_mask;
> +}
> +
> +static inline u64 sme_get_me_mask(void)
> +{
> +	return sme_me_mask;
> +}
> +
>  #endif	/* __ASSEMBLY__ */
>  
>  #endif	/* __X86_MEM_ENCRYPT_H__ */
> diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
> index c805f0a5c16e..7139f2f43955 100644
> --- a/arch/x86/mm/mem_encrypt.c
> +++ b/arch/x86/mm/mem_encrypt.c
> @@ -344,7 +344,6 @@ bool sme_active(void)
>  {
>  	return sme_me_mask && !sev_enabled;
>  }
> -EXPORT_SYMBOL(sme_active);
>  
>  bool sev_active(void)
>  {
> diff --git a/include/linux/mem_encrypt.h b/include/linux/mem_encrypt.h
> index 470bd53a89df..0c5b0ff9eb29 100644
> --- a/include/linux/mem_encrypt.h
> +++ b/include/linux/mem_encrypt.h
> @@ -18,23 +18,11 @@
>  
>  #else	/* !CONFIG_ARCH_HAS_MEM_ENCRYPT */
>  
> -#define sme_me_mask	0ULL
> -
> -static inline bool sme_active(void) { return false; }
> +static inline bool mem_encrypt_active(void) { return false; }
>  static inline bool sev_active(void) { return false; }
>  
>  #endif	/* CONFIG_ARCH_HAS_MEM_ENCRYPT */
>  
> -static inline bool mem_encrypt_active(void)
> -{
> -	return sme_me_mask;
> -}
> -
> -static inline u64 sme_get_me_mask(void)
> -{
> -	return sme_me_mask;
> -}
> -
>  #ifdef CONFIG_AMD_MEM_ENCRYPT
>  /*
>   * The __sme_set() and __sme_clr() macros are useful for adding or removing
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
