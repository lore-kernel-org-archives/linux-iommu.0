Return-Path: <SRS0=VhPo=Y2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FBD1CA9ECF
	for <iommu@archiver.kernel.org>; Sat,  2 Nov 2019 00:28:37 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0B61208E3
	for <iommu@archiver.kernel.org>; Sat,  2 Nov 2019 00:28:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="jPPNgZee"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0B61208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 88DD5DC5;
	Sat,  2 Nov 2019 00:28:36 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 8FBA3BE4
	for <iommu@lists.linux-foundation.org>;
	Sat,  2 Nov 2019 00:28:35 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from NAM05-DM3-obe.outbound.protection.outlook.com
	(mail-eopbgr730115.outbound.protection.outlook.com [40.107.73.115])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 98C5A14D
	for <iommu@lists.linux-foundation.org>;
	Sat,  2 Nov 2019 00:28:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
	b=dGlrPLxi5ESjdzwZJJn4QJVj8sgkb2Cm1gTN7sTG6NaKtAEbQ3Tc8VGxSomq1y2nV20Ng88Wmit/WBPszhpdLSvSbsMTbKtxcHSr58tPVnz6wpg4fdv5ZiKx1mRGnWC+eTKM8buOXxX9gf2fOhiJj2YVw/OCqC8RNtW47qtFZYJCdw+QjlZaXqbexocVkLXSBaJCIM3XHn+qA/hCmWXfaExH0Vza/c7ffArpJ1Sp1FkMbH2vT6T2z6bnUiQGBoHXn2C3SZewhTNXakCdNJS4uZ2DbQGer6Rjk5W0wFzJSm9MzFaRWhwxjyfkady+ApHef9zPeKFzXQOueVN6b4TqfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
	s=arcselector9901;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=WC3ptnWa0j3LcydmdreViOJBDzZG3YsCBxAO5hCgx9M=;
	b=Mtb0QD+jn/o5yAv/ZOtzbYt7KXez6ajufIBxLAtroPxrAwT9UtYI47pW80aRf5l3IG4b2r9tpFQZHil6Iw/r3fdIZnZJBMsid3SM6joSTQlhgNPku5aRxoOjR3v+vHhs6gfbnlcrHtXCel7FsiT9MB8yVrhwZouKpQ6jJTsWo6Ab72s6g65htBxkgzW5vC1uA2IzaTY42LTB6iphtMLwZBshnGwHHzx2NIL1QR8ENFDbzxuOKdlpOnEwo++0I4+Egbw6GSYZkpVK4oPtWu/gXPFzsSJbSVvvJKyPDZuoU+oi+JP9C3ZW8sqUH9uq8nQYeYFyluRTn2C99XbPaoUoWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
	smtp.mailfrom=microsoft.com; dmarc=pass action=none
	header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
	s=selector2;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=WC3ptnWa0j3LcydmdreViOJBDzZG3YsCBxAO5hCgx9M=;
	b=jPPNgZeepJZjFJgl2mMdnYpk2lr7OEfIH+I+Wt6IR6HGqWVG4wxDbulwyxuBce/Kq0hplf00rhMaPOFHjlqGJvbmPZCmVECsDk+BnG3ecwciIYpuxZxaW9/8CQVa7+meWnP0t4AgnOCwrEnnxqfYTK712yFMt9MmY9th3S2tKpg=
Received: from DM5PR21MB0137.namprd21.prod.outlook.com (10.173.173.12) by
	DM5PR21MB0794.namprd21.prod.outlook.com (10.175.112.10) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.2408.8; Sat, 2 Nov 2019 00:28:32 +0000
Received: from DM5PR21MB0137.namprd21.prod.outlook.com
	([fe80::9cc3:f167:bb63:799]) by DM5PR21MB0137.namprd21.prod.outlook.com
	([fe80::9cc3:f167:bb63:799%5]) with mapi id 15.20.2408.018;
	Sat, 2 Nov 2019 00:28:32 +0000
To: Wei Hu <weh@microsoft.com>, "b.zolnierkie@samsung.com"
	<b.zolnierkie@samsung.com>, KY Srinivasan <kys@microsoft.com>,
	Haiyang Zhang
	<haiyangz@microsoft.com>, Stephen Hemminger <sthemmin@microsoft.com>,
	"sashal@kernel.org" <sashal@kernel.org>, "hch@lst.de" <hch@lst.de>,
	"m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "mchehab+samsung@kernel.org"
	<mchehab+samsung@kernel.org>, "sam@ravnborg.org" <sam@ravnborg.org>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
	"info@metux.net" <info@metux.net>, "arnd@arndb.de" <arnd@arndb.de>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, 
	"dcui@microsoft.com" <dcui@microsoft.com>
Subject: RE: [PATCH] video: hyperv: hyperv_fb: Use physical memory for fb on
	HyperV Gen 1 VMs.
Thread-Topic: [PATCH] video: hyperv: hyperv_fb: Use physical memory for fb on
	HyperV Gen 1 VMs.
Thread-Index: AQHViMlWrXYtpApox02C+wFzOSr7Mqd3EP7w
Date: Sat, 2 Nov 2019 00:28:32 +0000
Message-ID: <DM5PR21MB013765D349FF1F90E22E247DD77D0@DM5PR21MB0137.namprd21.prod.outlook.com>
References: <20191022110905.4032-1-weh@microsoft.com>
In-Reply-To: <20191022110905.4032-1-weh@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
	MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
	MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
	MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-11-02T00:28:30.2103925Z;
	MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
	MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft
	Azure Information Protection;
	MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=1a2f7340-9a15-47d0-b70a-efdf7aa47e81;
	MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=mikelley@microsoft.com; 
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 42ee0b17-cf56-4532-65f2-08d75f2b979d
x-ms-traffictypediagnostic: DM5PR21MB0794:|DM5PR21MB0794:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR21MB0794F3CACBFB646A601A0CC7D77D0@DM5PR21MB0794.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-forefront-prvs: 0209425D0A
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(366004)(346002)(39860400002)(136003)(396003)(376002)(189003)(199004)(71200400001)(6436002)(71190400001)(1250700005)(66556008)(66476007)(99286004)(74316002)(7696005)(76116006)(14444005)(76176011)(6506007)(256004)(8990500004)(10090500001)(2201001)(64756008)(5660300002)(478600001)(66946007)(66446008)(1511001)(316002)(476003)(86362001)(22452003)(33656002)(66066001)(186003)(6116002)(10290500003)(229853002)(110136005)(3846002)(26005)(6636002)(2501003)(486006)(305945005)(81166006)(8676002)(8936002)(55016002)(81156014)(52536014)(14454004)(6246003)(11346002)(9686003)(7416002)(102836004)(7736002)(2906002)(446003)(25786009)(921003)(1121003);
	DIR:OUT; SFP:1102; SCL:1; SRVR:DM5PR21MB0794;
	H:DM5PR21MB0137.namprd21.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: microsoft.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5waLo2zE9XjbRpDIpsdLvr4DP97r/rjcZeBiTuO6YNqLPkRyUf/unvWs1Noq+gcmtqRTn3f6ks6ZwDQRc0Gjjy7aSz/cNyHbs3CV1Q1Y7RXqs/uDkvQ/AGhByzhgPFzjadVUE4MtjX5r7zb5icqBKrRgSiknVA7LdtdwKrq0ADXD6A3CGqHtp6XOr0h8uo/54LM3TgOvydUsGUwKF2t0pCr8cASEM9myI3u6ih5/uOoS6689j1kwMS/kjWxYIe3Qczz/K4k3A0V8ajhftyWo84qddc2WxIa6lZitI4ZNI3ihZ4m09ojXPXfT7hO2nKSkn36H77vtNvB+PVo9ob3xeQp2j+fVD/p0LWt2NX8YaX8mVs+2s9JlyogzunWa6YVH619f8AZ4j6e4rXZ914G3mXVdcEQOOSzOWNvAFIEpornhi5iCoKtcF/VhaRq8SVZo
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42ee0b17-cf56-4532-65f2-08d75f2b979d
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2019 00:28:32.5812 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y0oY9lvj8xN/1Vjn80vlfPwMe3Y84f8jiJ+one+ZtWmCPVcB4Rc04akudID0Ol76nZfoD0LACYq6aYZbe1oxrJh47L5O7o4zdC6+QClFawg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB0794
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
From: Michael Kelley via iommu <iommu@lists.linux-foundation.org>
Reply-To: Michael Kelley <mikelley@microsoft.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

From: Wei Hu <weh@microsoft.com> Sent: Tuesday, October 22, 2019 4:11 AM
> 
> On Hyper-V, Generation 1 VMs can directly use VM's physical memory for
> their framebuffers. This can improve the efficiency of framebuffer and
> overall performence for VM. The physical memory assigned to framebuffer
> must be contiguous. We use CMA allocator to get contiguouse physicial
> memory when the framebuffer size is greater than 4MB. For size under
> 4MB, we use alloc_pages to achieve this.
> 
> To enable framebuffer memory allocation from CMA, supply a kernel
> parameter to give enough space to CMA allocator at boot time. For
> example:
>     cma=130m
> This gives 130MB memory to CAM allocator that can be allocated to
> framebuffer. If this fails, we fall back to the old way of using
> mmio for framebuffer.
> 
> Signed-off-by: Wei Hu <weh@microsoft.com>
> ---

[snip]

> +/*
> + * Allocate enough contiguous physical memory.
> + * Return physical address if succeeded or -1 if failed.
> + */
> +static unsigned long hvfb_get_phymem(unsigned int request_size)
> +{
> +	struct page *page = NULL;
> +	unsigned int request_pages;
> +	unsigned long paddr = 0;

Using 'unsigned long' for physical addresses is problematic on 32-bit
systems with Physical Address Extension (PAE) enabled. Linux has
phys_addr_t that handles 32-bit PAE correctly and that probably
should be used here.   This whole driver needs to be carefully
checked for the correct type for physical addresses.

> +	unsigned int order = get_order(request_size);
> +
> +	if (request_size == 0)
> +		return -1;
> +
> +	/* Try call alloc_pages if the size is less than 2^MAX_ORDER */
> +	if (order < MAX_ORDER) {
> +		page = alloc_pages(GFP_KERNEL | __GFP_ZERO, order);
> +		if (!page)
> +			return -1;
> +
> +		request_pages = (1 << order);
> +		goto get_phymem1;
> +	}
> +
> +	/* Allocate from CMA */
> +	// request_pages = (request_size >> PAGE_SHIFT) + 1;
> +	request_pages = (round_up(request_size, PAGE_SIZE) >> PAGE_SHIFT);
> +	page = dma_alloc_from_contiguous(NULL, request_pages, 0, false);
> +
> +	if (page == NULL)
> +		return -1;
> +
> +get_phymem1:
> +	paddr = (page_to_pfn(page) << PAGE_SHIFT);
> +
> +	pr_info("Allocated %d pages starts at physical addr 0x%lx\n",
> +		request_pages, paddr);
> +
> +	return paddr;
> +}
> +
> +/* Release contiguous physical memory */
> +static void hvfb_release_phymem(unsigned long paddr, unsigned int size)

Same issue here with 'unsigned long paddr'.

> +{
> +	unsigned int order = get_order(size);
> +
> +	if (order < MAX_ORDER)
> +		__free_pages(pfn_to_page(paddr >> PAGE_SHIFT), order);
> +	else
> +		dma_release_from_contiguous(NULL,
> +					    pfn_to_page(paddr >> PAGE_SHIFT),
> +					    (round_up(size, PAGE_SIZE) >>
> +					     PAGE_SHIFT));
> +					    // (size >> PAGE_SHIFT) + 1);
> +}
> +
> 
>  /* Get framebuffer memory from Hyper-V video pci space */
>  static int hvfb_getmem(struct hv_device *hdev, struct fb_info *info)
> @@ -947,8 +1017,58 @@ static int hvfb_getmem(struct hv_device *hdev, struct fb_info
> *info)
>  	void __iomem *fb_virt;
>  	int gen2vm = efi_enabled(EFI_BOOT);
>  	resource_size_t pot_start, pot_end;
> +	unsigned long paddr;

Same issue with 'unsigned long'.

>  	int ret;
> 
> +	if (!gen2vm) {
> +		pdev = pci_get_device(PCI_VENDOR_ID_MICROSOFT,
> +			PCI_DEVICE_ID_HYPERV_VIDEO, NULL);
> +		if (!pdev) {
> +			pr_err("Unable to find PCI Hyper-V video\n");
> +			return -ENODEV;
> +		}
> +	}
> +
> +	info->apertures = alloc_apertures(1);
> +	if (!info->apertures)
> +		goto err1;
> +
> +	if (gen2vm) {
> +		info->apertures->ranges[0].base = screen_info.lfb_base;
> +		info->apertures->ranges[0].size = screen_info.lfb_size;
> +	} else {
> +		info->apertures->ranges[0].base = pci_resource_start(pdev, 0);
> +		info->apertures->ranges[0].size = pci_resource_len(pdev, 0);
> +	}
> +
> +	/*
> +	 * For Gen 1 VM, we can directly use the contiguous memory
> +	 * from VM. If we success, deferred IO happens directly
> +	 * on this allocated framebuffer memory, avoiding extra
> +	 * memory copy.
> +	 */
> +	if (!gen2vm) {
> +		paddr = hvfb_get_phymem(screen_fb_size);
> +		if (paddr != (unsigned long) -1) {

phys_addr_t

> +			par->mmio_pp = paddr;

I'm not really sure what to do about the above, because mmio_pp is
declared as 'unsigned long' when it really should be phys_addr_t.
But maybe a MMIO address will always be less than 4 Gb and therefore
will fit in 32 bits?

> +			par->mmio_vp = par->dio_vp = __va(paddr);
> +
> +			info->fix.smem_start = paddr;

smem_start is also declared as 'unsigned long', which seems
problematic with 32-bit PAE.  There are a lot of drivers that cast values
as 'unsigned long' before storing into smem_start

> +			info->fix.smem_len = screen_fb_size;
> +			info->screen_base = par->mmio_vp;
> +			info->screen_size = screen_fb_size;
> +
> +			par->need_docopy = false;
> +			goto getmem1;
> +		} else {
> +			pr_info("Unable to allocate enough contiguous physical memory on
> Gen 1 VM. Use MMIO instead.\n");
> +		}
> +	}
> +
> +	/*
> +	 * Cannot use the contiguous physical memory.
> +	 * Allocate mmio space for framebuffer.
> +	 */
>  	dio_fb_size =
>  		screen_width * screen_height * screen_depth / 8;
> 
> @@ -956,13 +1076,6 @@ static int hvfb_getmem(struct hv_device *hdev, struct fb_info
> *info)
>  		pot_start = 0;
>  		pot_end = -1;
>  	} else {
> -		pdev = pci_get_device(PCI_VENDOR_ID_MICROSOFT,
> -			      PCI_DEVICE_ID_HYPERV_VIDEO, NULL);
> -		if (!pdev) {
> -			pr_err("Unable to find PCI Hyper-V video\n");
> -			return -ENODEV;
> -		}
> -
>  		if (!(pci_resource_flags(pdev, 0) & IORESOURCE_MEM) ||
>  		    pci_resource_len(pdev, 0) < screen_fb_size) {
>  			pr_err("Resource not available or (0x%lx < 0x%lx)\n",
> @@ -991,20 +1104,6 @@ static int hvfb_getmem(struct hv_device *hdev, struct fb_info
> *info)
>  	if (par->dio_vp == NULL)
>  		goto err3;
> 
> -	info->apertures = alloc_apertures(1);
> -	if (!info->apertures)
> -		goto err4;
> -
> -	if (gen2vm) {
> -		info->apertures->ranges[0].base = screen_info.lfb_base;
> -		info->apertures->ranges[0].size = screen_info.lfb_size;
> -		remove_conflicting_framebuffers(info->apertures,
> -						KBUILD_MODNAME, false);
> -	} else {
> -		info->apertures->ranges[0].base = pci_resource_start(pdev, 0);
> -		info->apertures->ranges[0].size = pci_resource_len(pdev, 0);
> -	}
> -
>  	/* Physical address of FB device */
>  	par->mmio_pp = par->mem->start;

32-bit PAE problem could also occur here, even though the above line isn't
part of your patch.

Ideally, we would build the kernel in 32-bit mode with PAE enabled, and
test in an environment where the frame buffer gets allocated above the
4 Gbyte line.  There may be some similar bugs in other parts of this
driver that aren't touched by the patch.

Michael
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
