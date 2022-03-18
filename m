Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC566C433EF
	for <iommu@archiver.kernel.org>; Fri, 18 Mar 2022 06:10:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4B28B817B3;
	Fri, 18 Mar 2022 06:10:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JcQO8GDrowrb; Fri, 18 Mar 2022 06:10:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 29DB5812F6;
	Fri, 18 Mar 2022 06:10:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F2081C0033;
	Fri, 18 Mar 2022 06:10:18 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E4857C0012
 for <iommu@lists.linux-foundation.org>; Fri, 18 Mar 2022 06:10:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BD48B817A4
 for <iommu@lists.linux-foundation.org>; Fri, 18 Mar 2022 06:10:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id F5GGyzPjX-OL for <iommu@lists.linux-foundation.org>;
 Fri, 18 Mar 2022 06:10:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D221D812F6
 for <iommu@lists.linux-foundation.org>; Fri, 18 Mar 2022 06:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1647583816; x=1679119816;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=NuvVo8/70cvIRVYEes6ejrGDxEdXI+vhiZ2ktqNmEes=;
 b=UMMqybN0zWSWsUA5u79TF34Qv1NJl85mKatyTDHjOPgQSScBvCXjM2R2
 TktMQwOL8Vzhrno79OAkGWMiSmwceekghiAfUcdV9HxkEPotQDisZcCro
 CwvX5KIoYx8rh7IWxtByENpxODrh2kg9yWlpTdW3eoDp32NGE7/5rsYrr
 yaC0Ajdvat5k5W6/TKBIKxzR4r77Ifmm+NW2GANP7dGlmtew4ny7qGxGd
 DEL9iI9kFyfV7jrhfwd0E8MOwjut+DPAOgxQATv1sF740NpuqjehNLefw
 AergW84+sHUbGlXDheG7cVHh1o29qpDOOXCS7HqSrGZ8eo0j5BDBW/ESa w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10289"; a="255887989"
X-IronPort-AV: E=Sophos;i="5.90,191,1643702400"; d="scan'208";a="255887989"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Mar 2022 23:10:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,191,1643702400"; d="scan'208";a="558268675"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
 by orsmga008.jf.intel.com with ESMTP; 17 Mar 2022 23:10:14 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 17 Mar 2022 23:10:14 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Thu, 17 Mar 2022 23:10:14 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Thu, 17 Mar 2022 23:10:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WXzi542gfBrw1ld5Ld9TzvERLa6Y3BNTFyGhNkwZmflm+Lb1yxmfe82DTWyLIH38iREsZ+Fe63nTswMWu+luvxBkJeog/xsOsQJ8f/yEu9o/9KPzj6oxQM/HBo+UQW3gQx84AkSJ3pnLYGJIhDhTjSroJsU1EA9uyO+QVJO50c+1+5nShXVvsl+C48ue36kXQpHj/1Fc9RHKs8tKSxE7XmJMa4J9gUApIjJhewu1BCEzGi0YBkgNJLBW+rhDYFxgCTaEwDcx4eYaucbIgKOO5f3SflntRv6HyR6t29gwfpeiP8OELNo9cr/n/CcC1uWdjwkGf00K6i5XbeXrN87F8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DKfZBp4Uuz9UHCybbSU8VEFrp8yfkJVxVeTtzsDeqnY=;
 b=nDkPw7VMxF+gXs1H/CRUP32NVLejqmCc8e1iUAjV7TbJpMU40tcreMomVwcnELdYzWrpc7NzNuP+wC2IWNreiBek0c4hd2WUEx68646ekY4JHeR0K/9cgjZDXUeufdA7gYSqHh/D0nqAvvSU6Iu/Uca5RF7YVr7cpl58XyJ+KpbkCXjdtD8N80eXaMxGVFWSwKEq8I7G+ZXTIAN3qk2eIg7QiJIhpWhZx4x1nGfwRtMzHGq1j15oPec7oKW2dZr4hclOoMz0/Z8ybq8hKhreMCXA7QddffgPOqvjELBiFbEX+gKAOOpYr/rrG6aQ/rsSjDZn/zwM/X9WBl9rJakxTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW5PR11MB5881.namprd11.prod.outlook.com (2603:10b6:303:19d::14)
 by DM5PR11MB1563.namprd11.prod.outlook.com (2603:10b6:4:5::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5081.14; Fri, 18 Mar 2022 06:10:13 +0000
Received: from MW5PR11MB5881.namprd11.prod.outlook.com
 ([fe80::a111:6656:1e4c:303e]) by MW5PR11MB5881.namprd11.prod.outlook.com
 ([fe80::a111:6656:1e4c:303e%4]) with mapi id 15.20.5081.017; Fri, 18 Mar 2022
 06:10:12 +0000
From: "Zhang, Tina" <tina.zhang@intel.com>
To: David Stevens <stevensd@chromium.org>, Lu Baolu <baolu.lu@linux.intel.com>
Subject: RE: [PATCH] iommu/vt-d: check alignment before using psi
Thread-Topic: [PATCH] iommu/vt-d: check alignment before using psi
Thread-Index: AQHYOPP2k+OmAPRtKECVk7qmmqzhO6zEpgdg
Date: Fri, 18 Mar 2022 06:10:12 +0000
Message-ID: <MW5PR11MB588107B2F311E1211E95690789139@MW5PR11MB5881.namprd11.prod.outlook.com>
References: <20220316050711.1855533-1-stevensd@google.com>
In-Reply-To: <20220316050711.1855533-1-stevensd@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.6.401.20
dlp-product: dlpe-windows
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d491a966-a0f4-43a1-04b6-08da08a5f6cf
x-ms-traffictypediagnostic: DM5PR11MB1563:EE_
x-microsoft-antispam-prvs: <DM5PR11MB1563C3A3D4DD5B9E1CCD0FA789139@DM5PR11MB1563.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +5I854NYJC8uqnW/OcFXJu6vA6uBoajbRhVXXnEtDyGHpj9G5DLeGV8//ksMkLIJHqept3V/Ndl5IV2uMyzPNY8Evfyrm3oDEMkrdxyzAj97lY/chMUDME0Ds+P+iNhC+yRo4lMBqgRff0iKFaOH+YFdmdzPCZCIRRAY6cmnLqsk6hOu7RvZfGLAu3W8l1ObzVJ4OQ07N2xFQFK2+PRcj4RX9bo75Nlp0m2eThwRWGfqCzQGsdVKHmCyaAeRbaoob5a5YiFyJjnGQR2PDfkrJ+jMKc9vUJ7crkYPth75omjAedl6Kt08igo5E6p/cUDRxlRtJRCNgffQ7XhVCkusr6CDo/GG70leQi8NvgDXU18riMpVK/C/izv+RVgctTY7nvkysJxOkhsEbQ+PdCeUohs8YHa4CoVMNqvup0W5U/DthEhhPLNmfI65i8jG2UcpWGl93BCmUD0xYbRvRBTcTuHCoUlq+X7Q+ICK7BWNSPmyNETEL2UuTrwpmGPQXeBB13G3LxDVi/scocYFTc9Y2BJzkbu93/yAgsJbEF/xD8jC7HfOBx0QXWfHLEmglOSFULS40gDqoV5mfjtXF+oHOxDrF5yKgdGjwqb8cVWybCkd6iv59qL7C4fCg1MzXWaEYM1zFAN/aCo5ornbVbOKk2S9ezSa+GvT+jd+3nRPeWAhCZggh9KDpLAsVSSGLolkrAkbCykbXxade4u929URB+uCAl+f4jcq1eXHmgu1wdAbD7T0LgvNnMy7L860jDOhuw+2gVAWYQ6U3pfxBFfLFHT8zsg+PTq0j5BRlHwCmLg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW5PR11MB5881.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(366004)(86362001)(66446008)(76116006)(110136005)(66946007)(8676002)(66476007)(64756008)(66556008)(2906002)(52536014)(4326008)(5660300002)(8936002)(83380400001)(122000001)(82960400001)(38100700002)(186003)(316002)(26005)(54906003)(38070700005)(508600001)(9686003)(71200400001)(55016003)(7696005)(53546011)(6506007)(33656002)(966005);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?PMk40RkQIG+QAHs6RbjmGzo/84em/kmPwUc0+gYFawC7GqoMDM8kqXLLqPz5?=
 =?us-ascii?Q?Jv9u00G7h7FEZdRNjnudaZ+6IC6AxZkgWVH/1G79FpfJjNjzgSLergJFjpD7?=
 =?us-ascii?Q?a4lIlLIVzoRjAY6rYFQpqi0zCSVMMmCanNJ4DB6XV3quVZ7+DMGRcVzLuTXz?=
 =?us-ascii?Q?nOXzEOAv9qlvtXz95+IEIMUUZZkKnBVJc8dbOr7JkzI1ubv1WKtmDcm/LCCz?=
 =?us-ascii?Q?P4dOONZ7QyjjiOgNa8kwtytKpT3LcdoDMd8z1HrFM813gy2WtFf2fj3phlnp?=
 =?us-ascii?Q?T2InVHTw54N+4Fdjb0UXgz84yV8a/X3zaz5X+pV+3MoGt3we76d+YZ40hjwp?=
 =?us-ascii?Q?4fmz0G2XwSgy+Eev0F4Nc6nN8s1n+QEwXE0CTXorDNNbKOqS1RJQdEgycJ5t?=
 =?us-ascii?Q?+bHjATPSuPb7Rjt14QH8MDNeFN2EMWctcuxNm04y4W07xo2S4yUGPSd/CleR?=
 =?us-ascii?Q?ECGmDQI81Mvy4HBbQtYasCGbEP5Jtd5ZNpoA4aQ9suIc9pAoXv+DznoGi3K9?=
 =?us-ascii?Q?SDhM3UpBRBBf+oHx0n20IVDF7L9kysL1DzoNBhEavHtSVX2Gn7iXmc+Qlztk?=
 =?us-ascii?Q?WXfLVTg5PkA0AmlEg1JEs6h/GCooqoOSedUWXGJyFG20Iw2Zy0HD1ST1YsqA?=
 =?us-ascii?Q?WCBAtCU1tue58ZsJZcb8TBoDhisnmLnoqFIzmSIHTcw8DnP9fx5+Ns0sAD0S?=
 =?us-ascii?Q?shtTLYYFJoaVko32zvxdi9AxDxcqMpDJUACOKP1lkEQFi83xYHkExn/kDOSN?=
 =?us-ascii?Q?W7je/SukVJZZjOqXEH9JHAngSUj4L4/eofTWCrYE8QX1fyKqHT+hl9t3da3Q?=
 =?us-ascii?Q?hSYou/RMSTZfswUMdcK2xgktqgWdmBGCsQxfVoEuPa2qY6s77rezkFuvlCFF?=
 =?us-ascii?Q?cZTsFAn4bYR6wi023YiM4GI8MUOZdIvP+79Bp9mktpapfyyL7iH8we/zwxVO?=
 =?us-ascii?Q?c9ecwGuv9pIg/+AFLzgRTQp2kI73cFaJWsEJUHm4i1rULLhnp+vvqX4sqQ9K?=
 =?us-ascii?Q?YKalALWkkDLUDFja6ZP1pgsI/6Vd1B2SbwQ+UtkCVbx5l2Tp3jDNEKZBd/xv?=
 =?us-ascii?Q?m3TG9F8kKQMWOkotOtlQRvPfzv5vZWYtj15GijSoxbqUXVaYbpMHQgXN74TH?=
 =?us-ascii?Q?hFEfVOwFVYiqJaOeDW8jw3wDaKaWiiSMe5SxhTiGEJkp5dUHMhAJFj23bM81?=
 =?us-ascii?Q?l2lKe0ab9TnSYBz13G81ogxiSE8NLSu6k2wS33+yqQ1E3pZPFTWHrZZZopMI?=
 =?us-ascii?Q?khHfl1eXW4oL/i4rqWv2YpjSHt5eF1yGtg1+6P9dmJ89uzot7/dKJhsWZEi1?=
 =?us-ascii?Q?09UnvUp2kLIJGnA7wqJk+xDqcTHYQI8ZxLa9iCwlOvnolXG4W2mSELzYcO5v?=
 =?us-ascii?Q?vhnlQ1cJ80Fhm5WJVMo+Mnh2GnKCaNaCMFv/IAcdicIVS7xcMvYE1WE1R/CW?=
 =?us-ascii?Q?+Xdq9ztzp05UGkeAMy1Rn+O518gw5kY+?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5881.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d491a966-a0f4-43a1-04b6-08da08a5f6cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2022 06:10:12.8954 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r+rOn3LuERyZDJ6dcTSBMXNd3Byk+Rz+utAwxKC0VHxM+ON/knb19T0TEIJJXorMS9l6cULH3YUVrobWyNqQwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1563
X-OriginatorOrg: intel.com
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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



> -----Original Message-----
> From: iommu <iommu-bounces@lists.linux-foundation.org> On Behalf Of
> David Stevens
> Sent: Wednesday, March 16, 2022 1:07 PM
> To: Lu Baolu <baolu.lu@linux.intel.com>
> Cc: iommu@lists.linux-foundation.org; linux-kernel@vger.kernel.org; David
> Stevens <stevensd@chromium.org>
> Subject: [PATCH] iommu/vt-d: check alignment before using psi
> 
> From: David Stevens <stevensd@chromium.org>
> 
> Fall back to domain selective flush if the target address is not aligned to the
> mask being used for invalidation. This is necessary because page selective
> invalidation masks out the lower order bits of the target address based on
> the mask value, so if a non-aligned address is targeted for psi, then mappings
> at the end of [pfn, pfn+pages) may not properly be flushed from the iotlb.
> 
> This is not normally an issue because iova.c always allocates iovas that are
> aligned to their size. However, iovas which come from other sources (e.g.
> userspace via VFIO) may not be aligned.

Indeed, the dma_map/unmap always use alloca_iova(..., true) to allocate iova, which means size_aligned. But the iova used by userspace might not be size aligned. And it seems we cannot expect userspace can always use size_aligned iova base address.

BR,
Tina

> 
> Signed-off-by: David Stevens <stevensd@chromium.org>
> ---
>  drivers/iommu/intel/iommu.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 5b196cfe9ed2..c122686e0a5c 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -1735,7 +1735,8 @@ static void iommu_flush_iotlb_psi(struct
> intel_iommu *iommu,
>  		 * and the base address is naturally aligned to the size.
>  		 */
>  		if (!cap_pgsel_inv(iommu->cap) ||
> -		    mask > cap_max_amask_val(iommu->cap))
> +		    mask > cap_max_amask_val(iommu->cap) ||
> +		    unlikely(((1 << mask) - 1) & pfn))
>  			iommu->flush.flush_iotlb(iommu, did, 0, 0,
> 
> 	DMA_TLB_DSI_FLUSH);
>  		else
> --
> 2.35.1.723.g4982287a31-goog
> 
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
