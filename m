Return-Path: <SRS0=6I1K=SK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12EEDC282DE
	for <iommu@archiver.kernel.org>; Mon,  8 Apr 2019 20:05:55 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D592420880
	for <iommu@archiver.kernel.org>; Mon,  8 Apr 2019 20:05:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="HHoiIeQu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D592420880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id D3EBBD09;
	Mon,  8 Apr 2019 20:05:53 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 25DF6CF3
	for <iommu@lists.linux-foundation.org>;
	Mon,  8 Apr 2019 20:05:52 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from NAM01-BY2-obe.outbound.protection.outlook.com
	(mail-eopbgr810057.outbound.protection.outlook.com [40.107.81.57])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id EC3C57ED
	for <iommu@lists.linux-foundation.org>;
	Mon,  8 Apr 2019 20:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=8sKqEH2JecqxziU9ZKJL0jPd5FIwVqm4apVu23/eG8w=;
	b=HHoiIeQuPPmHjSH1FnOfZelb7Zf0+XmuzGPaDaEaXxkx53VbvJYhsOmRuu8K7n5zFdceBixxNVROmjBlFvdSmiFaYW0xHbGH2L2fRnAQ4o/FAzXsO8aehTyqKXiV6b05LHm5+D6m9Mu98YyLXZAPpbHKIdKVueqsMcmUmdX6gLw=
Received: from MN2PR05MB6141.namprd05.prod.outlook.com (20.178.241.217) by
	MN2PR05MB6032.namprd05.prod.outlook.com (20.178.242.15) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1792.7; Mon, 8 Apr 2019 20:05:49 +0000
Received: from MN2PR05MB6141.namprd05.prod.outlook.com
	([fe80::91e:292d:e304:78ad]) by MN2PR05MB6141.namprd05.prod.outlook.com
	([fe80::91e:292d:e304:78ad%7]) with mapi id 15.20.1792.009;
	Mon, 8 Apr 2019 20:05:49 +0000
To: "hch@lst.de" <hch@lst.de>, "torvalds@linux-foundation.org"
	<torvalds@linux-foundation.org>
Subject: Re: [PATCH] Revert "drm/vmwgfx: Improve on IOMMU detection"
Thread-Topic: [PATCH] Revert "drm/vmwgfx: Improve on IOMMU detection"
Thread-Index: AQHU7fmiB6y8RJSDbkO+jrn2WRu5saYysPWA
Date: Mon, 8 Apr 2019 20:05:48 +0000
Message-ID: <88c0cd21b11a385b3b0130715a25673b71b57112.camel@vmware.com>
References: <20190408105525.5493-1-hch@lst.de>
	<20190408105525.5493-2-hch@lst.de>
In-Reply-To: <20190408105525.5493-2-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=thellstrom@vmware.com; 
x-originating-ip: [155.4.205.56]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a8fd10e1-15ef-4af7-d454-08d6bc5d982e
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(2017052603328)(7193020);
	SRVR:MN2PR05MB6032; 
x-ms-traffictypediagnostic: MN2PR05MB6032:
x-microsoft-antispam-prvs: <MN2PR05MB6032B2AFB0B00285DC8E4FDAA12C0@MN2PR05MB6032.namprd05.prod.outlook.com>
x-forefront-prvs: 0001227049
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10009020)(376002)(346002)(396003)(39860400002)(136003)(366004)(189003)(199004)(8936002)(305945005)(316002)(54906003)(53936002)(105586002)(8676002)(110136005)(6246003)(118296001)(186003)(86362001)(76176011)(446003)(25786009)(81166006)(81156014)(256004)(2906002)(99286004)(106356001)(6512007)(66066001)(11346002)(6436002)(26005)(486006)(476003)(68736007)(6486002)(7736002)(2616005)(6116002)(478600001)(71190400001)(71200400001)(6506007)(229853002)(36756003)(14454004)(5660300002)(97736004)(102836004)(2501003)(3846002)(4326008);
	DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR05MB6032;
	H:MN2PR05MB6141.namprd05.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: vmware.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: kTuLcrh+rGjNpnfXCadAgpZkqf9vCamIfeBPZwMaN3GMIt2qrL8D5TaeG1FfcvkM1Ar9VCxCru43HomUuxmxBWRvMAvpLO4nzeyJasnvVrjIZGkIKIspKFDg0ASUJfcPYI1BdwVY1/5JLcmWXFYn9k94xNt+U00QKDbuhQoGTqo3+6JE2OBq6Ocybsantbi3/yeQqF2bkobZPKGaESTgd5I7dDp4cetIiUUN+NvP8p3/lveF3eAt2fsDuFQliFNAE3bFkE3BtKT9FTugqfW+uNLKuWDrs1lpH0CwOD7NiRKQCz9A4gXbEKCrgtCTYUMLBxPxV/06vvQlXvsJjbR18/+Q+dIlTH9CQX7n75Wr7tYKI6rCJ/g5iSxWd27xoBG6xOjPoW7VDaxO0HVhnmRkYUcO/2U2t6aYg/m0kiEX5tI=
Content-ID: <0151265B32F40043B252873E3BC44AB6@namprd05.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8fd10e1-15ef-4af7-d454-08d6bc5d982e
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2019 20:05:48.9419 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR05MB6032
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	Deepak Singh Rawat <drawat@vmware.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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
From: Thomas Hellstrom via iommu <iommu@lists.linux-foundation.org>
Reply-To: Thomas Hellstrom <thellstrom@vmware.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190408200548.mY3T5W8JDRmnbTSTtDBc7srJ3UgjGubRwvrSRcSBgtg@z>

On Mon, 2019-04-08 at 12:55 +0200, Christoph Hellwig wrote:
> This reverts commit 9ddac734aa310c5fbc0ec93602335d2a39092451.

IMHO, rather than reverting, I'd like to see the dma API provide a
function telling us whether streaming DMA operations are coherent or
not. 

With that we could fix all drivers that would otherwise just blow up if
somebody happened to enable swiotlb with bounce buffers...

/Thomas



> ---
>  drivers/gpu/drm/vmwgfx/vmwgfx_drv.c | 19 ++-----------------
>  1 file changed, 2 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
> b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
> index 6165fe2c4504..9294b76c8084 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
> @@ -26,7 +26,6 @@
>  
> *********************************************************************
> *****/
>  #include <linux/module.h>
>  #include <linux/console.h>
> -#include <linux/dma-mapping.h>
>  
>  #include <drm/drmP.h>
>  #include "vmwgfx_drv.h"
> @@ -35,6 +34,7 @@
>  #include <drm/ttm/ttm_placement.h>
>  #include <drm/ttm/ttm_bo_driver.h>
>  #include <drm/ttm/ttm_module.h>
> +#include <linux/intel-iommu.h>
>  
>  #define VMWGFX_DRIVER_DESC "Linux drm driver for VMware graphics
> devices"
>  #define VMWGFX_CHIP_SVGAII 0
> @@ -545,21 +545,6 @@ static void vmw_get_initial_size(struct
> vmw_private *dev_priv)
>  	dev_priv->initial_height = height;
>  }
>  
> -/**
> - * vmw_assume_iommu - Figure out whether coherent dma-remapping
> might be
> - * taking place.
> - * @dev: Pointer to the struct drm_device.
> - *
> - * Return: true if iommu present, false otherwise.
> - */
> -static bool vmw_assume_iommu(struct drm_device *dev)
> -{
> -	const struct dma_map_ops *ops = get_dma_ops(dev->dev);
> -
> -	return !dma_is_direct(ops) && ops &&
> -		ops->map_page != dma_direct_map_page;
> -}
> -
>  /**
>   * vmw_dma_select_mode - Determine how DMA mappings should be set up
> for this
>   * system.
> @@ -583,7 +568,7 @@ static int vmw_dma_select_mode(struct vmw_private
> *dev_priv)
>  
>  	if (vmw_force_coherent)
>  		dev_priv->map_mode = vmw_dma_alloc_coherent;
> -	else if (vmw_assume_iommu(dev_priv->dev))
> +	else if (intel_iommu_enabled)
>  		dev_priv->map_mode = vmw_dma_map_populate;
>  	else if (!vmw_force_iommu)
>  		dev_priv->map_mode = vmw_dma_phys;
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
