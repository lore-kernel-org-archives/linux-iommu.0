Return-Path: <SRS0=oZX7=VP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3AB2C7618F
	for <iommu@archiver.kernel.org>; Thu, 18 Jul 2019 17:47:20 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9BFA21019
	for <iommu@archiver.kernel.org>; Thu, 18 Jul 2019 17:47:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="mWnSia1t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9BFA21019
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id A023A1AC5;
	Thu, 18 Jul 2019 17:47:20 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 0CE971AC4
	for <iommu@lists.linux-foundation.org>;
	Thu, 18 Jul 2019 17:47:04 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
	(mail-eopbgr690083.outbound.protection.outlook.com [40.107.69.83])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 640B08F1
	for <iommu@lists.linux-foundation.org>;
	Thu, 18 Jul 2019 17:47:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
	b=dadVJznFYDOQz8y7tDnbEp+cUJhcjou+zVL9cZLOElASvhLURJgj0X5TCOuqT7fUmQHGhrQmxu3dYaNg70LCE8Z+MhA8tshcFVkldR5O8+/HIva35EA14jWMyxE5+twg3EFxihbtXDfSvCWwVysDFRz4x7OuwBmbQ1msOtc1OgkeBrKHQLWY59USn90w9ANmwSLOyLJaB5k3cZsJvjKBU47eR/xMFX1lERfTlYWshElxTF/xOKQETdF/ErhZ+OZMiOueezYxF6BhB3MtIjZGo/FYuVs+tCb8JL5Gs0k+7R2HFjja7Q7v4xEl7HkpRZFQAaAvbKA4U/ZTidz3akD4lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
	s=arcselector9901;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=8tOe0visBYdGs3MXpfdztXVmFPQbX+FomCoT7LIxekQ=;
	b=aMrcdtaX0IeXOxYJUCdSbUpOFQHt5czpv6XhCWtyGGn9+tde4y1dCyh6h/aVY2zCbV4mgr+nbYjYCo+w5/TQh1wSKOyzaMMmOAdIAKO6GLd+OHKO21ZUsPwo3F/Mceal6Oh+Z+VdoEugvjxkdh4QuxcytI8IWQLzzs+rspQ+TBXuTpvmZEWxeGtIY/ojFRK6jQi0/X1ivZMesDEmJHfWpqzCu2jTb2iQP72s20HttaIsfCX3winVKifjyJsw+EXce9iQj4ys9+0RkJsr9Z8y1+M2Cdraz57u9bcXJBfWGxSIhIjqSKS1lPUkTBa0W4MRk38GYqjskaPRGQVr3F6nxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
	smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com;
	dkim=pass header.d=amd.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=8tOe0visBYdGs3MXpfdztXVmFPQbX+FomCoT7LIxekQ=;
	b=mWnSia1tFvzDrjnTmewSMH9L/V2xSxt1LWNQWUBHmDvxGuXid5KRPTLoC36rcILAIoZZekClfIci6nKLN1gr+PA+BdD2xaPn50T8tKb3YfrunOiz4fFK4HZJiW6cCz8gvuCTj7fBqEt0sCZ4ik0I7paUIom4f3/Vh/PnXRH+xYk=
Received: from DM6PR12MB3163.namprd12.prod.outlook.com (20.179.104.150) by
	DM6PR12MB4155.namprd12.prod.outlook.com (10.141.8.79) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.2094.11; Thu, 18 Jul 2019 17:47:02 +0000
Received: from DM6PR12MB3163.namprd12.prod.outlook.com
	([fe80::9c3d:8593:906c:e4f7]) by
	DM6PR12MB3163.namprd12.prod.outlook.com
	([fe80::9c3d:8593:906c:e4f7%6]) with mapi id 15.20.2073.012;
	Thu, 18 Jul 2019 17:47:02 +0000
From: "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
To: Thiago Jung Bauermann <bauerman@linux.ibm.com>, "x86@kernel.org"
	<x86@kernel.org>
Subject: Re: [PATCH v3 5/6] fs/core/vmcore: Move sev_active() reference to x86
	arch code
Thread-Topic: [PATCH v3 5/6] fs/core/vmcore: Move sev_active() reference to
	x86 arch code
Thread-Index: AQHVPRkNny8Ij5XGSEqqm2aPE2P6lqbQp2SA
Date: Thu, 18 Jul 2019 17:47:01 +0000
Message-ID: <4a07bf75-b516-c81b-da7a-4b323e6d7e52@amd.com>
References: <20190718032858.28744-1-bauerman@linux.ibm.com>
	<20190718032858.28744-6-bauerman@linux.ibm.com>
In-Reply-To: <20190718032858.28744-6-bauerman@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: DM6PR02CA0011.namprd02.prod.outlook.com
	(2603:10b6:5:1c::24) To DM6PR12MB3163.namprd12.prod.outlook.com
	(2603:10b6:5:182::22)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=Thomas.Lendacky@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7e5801d8-895f-4f4f-9389-08d70ba7f053
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);
	SRVR:DM6PR12MB4155; 
x-ms-traffictypediagnostic: DM6PR12MB4155:
x-microsoft-antispam-prvs: <DM6PR12MB415592443717BF15C1C735B3ECC80@DM6PR12MB4155.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 01026E1310
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10009020)(979002)(4636009)(376002)(346002)(396003)(366004)(39860400002)(136003)(199004)(189003)(5660300002)(54906003)(256004)(110136005)(4326008)(11346002)(316002)(2616005)(2906002)(6506007)(446003)(53546011)(76176011)(26005)(102836004)(31686004)(14454004)(99286004)(52116002)(229853002)(386003)(486006)(476003)(31696002)(186003)(86362001)(25786009)(71200400001)(36756003)(3846002)(6116002)(66946007)(64756008)(66476007)(66556008)(7736002)(66446008)(478600001)(8676002)(2501003)(6512007)(7416002)(6486002)(6436002)(68736007)(53936002)(6246003)(8936002)(81156014)(81166006)(305945005)(71190400001)(66066001)(969003)(989001)(999001)(1009001)(1019001);
	DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB4155;
	H:DM6PR12MB3163.namprd12.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: CvML0RuBLuSMvHOHS0zIOgdYzrxVKhDksT3op0g1P9UO6JsfdTtbiMB4YY4G4vekdwn4+MyGVxCm84xYyfBeiIT7NPZI7X+L8nWK0ACoa25Y0aiLggX4pJt4p7DQK3+YRchOB8e+nVmXU+mkD0JtPQImnFZGyRpBzC1EoeEMut6FvsKqMP/Gt2+Lm7kJ+Ig9bra6eY6QAbLYHcrD4YoR1y4sbpWDgB0P4h6bu9n6URwfFGa7TomjJo5LuE4uP2cUhiASYubodHrihW38HrPXzT4LwMGZypnLVqRiK9yA23OP/cgS8x9IdhFg4x+JiLdcGdGJgzI74Q4x0SCBn/caC/QXj0icsv8qgKOSR3kKszmrJaiIdJ+eiSifiM1ZXxnkLarjoxF7f1+CdJNblR4IxPoV7V92aBtEzWbL3rE15kE=
Content-ID: <F2202C485E8ABF4BBFF76860864A3C18@namprd12.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e5801d8-895f-4f4f-9389-08d70ba7f053
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2019 17:47:01.8755 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tlendack@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4155
Cc: "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
	Lianbo Jiang <lijiang@redhat.com>,
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
> Secure Encrypted Virtualization is an x86-specific feature, so it shouldn't
> appear in generic kernel code because it forces non-x86 architectures to
> define the sev_active() function, which doesn't make a lot of sense.
> 
> To solve this problem, add an x86 elfcorehdr_read() function to override
> the generic weak implementation. To do that, it's necessary to make
> read_from_oldmem() public so that it can be used outside of vmcore.c.
> 
> Also, remove the export for sev_active() since it's only used in files that
> won't be built as modules.
> 
> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>

Adding Lianbo and Baoquan, who recently worked on this, for their review.

Thanks,
Tom

> ---
>  arch/x86/kernel/crash_dump_64.c |  5 +++++
>  arch/x86/mm/mem_encrypt.c       |  1 -
>  fs/proc/vmcore.c                |  8 ++++----
>  include/linux/crash_dump.h      | 14 ++++++++++++++
>  include/linux/mem_encrypt.h     |  1 -
>  5 files changed, 23 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/kernel/crash_dump_64.c b/arch/x86/kernel/crash_dump_64.c
> index 22369dd5de3b..045e82e8945b 100644
> --- a/arch/x86/kernel/crash_dump_64.c
> +++ b/arch/x86/kernel/crash_dump_64.c
> @@ -70,3 +70,8 @@ ssize_t copy_oldmem_page_encrypted(unsigned long pfn, char *buf, size_t csize,
>  {
>  	return __copy_oldmem_page(pfn, buf, csize, offset, userbuf, true);
>  }
> +
> +ssize_t elfcorehdr_read(char *buf, size_t count, u64 *ppos)
> +{
> +	return read_from_oldmem(buf, count, ppos, 0, sev_active());
> +}
> diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
> index 7139f2f43955..b1e823441093 100644
> --- a/arch/x86/mm/mem_encrypt.c
> +++ b/arch/x86/mm/mem_encrypt.c
> @@ -349,7 +349,6 @@ bool sev_active(void)
>  {
>  	return sme_me_mask && sev_enabled;
>  }
> -EXPORT_SYMBOL(sev_active);
>  
>  /* Override for DMA direct allocation check - ARCH_HAS_FORCE_DMA_UNENCRYPTED */
>  bool force_dma_unencrypted(struct device *dev)
> diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
> index 57957c91c6df..ca1f20bedd8c 100644
> --- a/fs/proc/vmcore.c
> +++ b/fs/proc/vmcore.c
> @@ -100,9 +100,9 @@ static int pfn_is_ram(unsigned long pfn)
>  }
>  
>  /* Reads a page from the oldmem device from given offset. */
> -static ssize_t read_from_oldmem(char *buf, size_t count,
> -				u64 *ppos, int userbuf,
> -				bool encrypted)
> +ssize_t read_from_oldmem(char *buf, size_t count,
> +			 u64 *ppos, int userbuf,
> +			 bool encrypted)
>  {
>  	unsigned long pfn, offset;
>  	size_t nr_bytes;
> @@ -166,7 +166,7 @@ void __weak elfcorehdr_free(unsigned long long addr)
>   */
>  ssize_t __weak elfcorehdr_read(char *buf, size_t count, u64 *ppos)
>  {
> -	return read_from_oldmem(buf, count, ppos, 0, sev_active());
> +	return read_from_oldmem(buf, count, ppos, 0, false);
>  }
>  
>  /*
> diff --git a/include/linux/crash_dump.h b/include/linux/crash_dump.h
> index f774c5eb9e3c..4664fc1871de 100644
> --- a/include/linux/crash_dump.h
> +++ b/include/linux/crash_dump.h
> @@ -115,4 +115,18 @@ static inline int vmcore_add_device_dump(struct vmcoredd_data *data)
>  	return -EOPNOTSUPP;
>  }
>  #endif /* CONFIG_PROC_VMCORE_DEVICE_DUMP */
> +
> +#ifdef CONFIG_PROC_VMCORE
> +ssize_t read_from_oldmem(char *buf, size_t count,
> +			 u64 *ppos, int userbuf,
> +			 bool encrypted);
> +#else
> +static inline ssize_t read_from_oldmem(char *buf, size_t count,
> +				       u64 *ppos, int userbuf,
> +				       bool encrypted)
> +{
> +	return -EOPNOTSUPP;
> +}
> +#endif /* CONFIG_PROC_VMCORE */
> +
>  #endif /* LINUX_CRASHDUMP_H */
> diff --git a/include/linux/mem_encrypt.h b/include/linux/mem_encrypt.h
> index 0c5b0ff9eb29..5c4a18a91f89 100644
> --- a/include/linux/mem_encrypt.h
> +++ b/include/linux/mem_encrypt.h
> @@ -19,7 +19,6 @@
>  #else	/* !CONFIG_ARCH_HAS_MEM_ENCRYPT */
>  
>  static inline bool mem_encrypt_active(void) { return false; }
> -static inline bool sev_active(void) { return false; }
>  
>  #endif	/* CONFIG_ARCH_HAS_MEM_ENCRYPT */
>  
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
