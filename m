Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0846BC433F5
	for <iommu@archiver.kernel.org>; Fri, 18 Mar 2022 06:17:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 83CD584160;
	Fri, 18 Mar 2022 06:17:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hjygOV7-ilQA; Fri, 18 Mar 2022 06:17:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 522E48403A;
	Fri, 18 Mar 2022 06:17:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 10BFFC001A;
	Fri, 18 Mar 2022 06:17:06 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5BFC3C000B
 for <iommu@lists.linux-foundation.org>; Fri, 18 Mar 2022 06:17:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 38F834184C
 for <iommu@lists.linux-foundation.org>; Fri, 18 Mar 2022 06:17:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CIuBWItf5Z7v for <iommu@lists.linux-foundation.org>;
 Fri, 18 Mar 2022 06:17:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8AEAA4170A
 for <iommu@lists.linux-foundation.org>; Fri, 18 Mar 2022 06:17:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1647584223; x=1679120223;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=ar9rhJb+qhiQF9WVlXC3Ve5wbrVZgWXhOHndqFGSrjw=;
 b=JkXfKnIHRj7hQ379TAlnSBRJQau+qyzdm5QZpp7xQCJCCgXyscudaxEl
 Epb9xQQrAfvQIy/Hout9ajej0Wq3QP8+2Sldc705qu+vtVp5bLO3EePgt
 OT0NmCsfreNvE3KkbpWIs2UezUocBk7OfJhye4MKG1jor2caVVfPEkoay
 AzqgtTWR80F30IVMruTfvYqEYRiSRZLohFXIq5Sqa0LrUea9AcxoUL+8K
 IdFnhBlB9D/xWH1gWM7f5BILZIDi6CTnjNXWAV1J42Jc2HayF4I6O3TfR
 fP2Fq2J8qWyJ9HD3CZBiVLQsPEiQdPst1X9FSwf/CUjP19CkPBENiG9gH A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10289"; a="254618079"
X-IronPort-AV: E=Sophos;i="5.90,191,1643702400"; d="scan'208";a="254618079"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Mar 2022 23:17:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,191,1643702400"; d="scan'208";a="558271330"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
 by orsmga008.jf.intel.com with ESMTP; 17 Mar 2022 23:17:02 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 17 Mar 2022 23:17:02 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 17 Mar 2022 23:17:02 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Thu, 17 Mar 2022 23:17:02 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.109)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Thu, 17 Mar 2022 23:17:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OIIA+D+bmSlAA3HPnru+dYNPybuH9o/utZnMKLlLu/amoDIK88xmW8lk3Kk5y74AlUfUFw65Wcoq63vF6KEkM7JSNwumJFDgSMoIuyf0LU91PI9Cv4PHg3jhBCQIKwcQXOFhEYA6XAi/pOIhvbp+/efOn+fUWrhTDZcy2yRgRY+vE4zQaWHxVb7ODllfWQmDFytUnjwkWYcyB8QVYccvoQqTI0C6HBWTsEKGS1TIqyEmsOu/mnoynTNw/Zw1wKmN4AS/viCP34Y1T1M6hFZb7bkmg0kfmnPyojDU24AwinGDXW+PiOYvhVzFupwQRkeZ0t3LZ9ec341a3nNTPdfpXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RF/ta02Pb4DSqeJLpDqvRUsZ20yUjGwYtdmRhYBanq8=;
 b=SOO/tPsCcSx0tJID+167hUyDhk0XpilUWJdibQBQSlVPizVmulqI80fMbAlBtxsGWL0b3hzVoau7c34Ir9y6DpRIMfLMkyIi57M08TsYCCqzD1f+oLdYiHPXApRJd7XWJRMcPHY2B2/a2BlXFYQmOWrEvqDfISvjtdHyMLI5Ku/CV3wmmrkSjFLHj4VRI9gE9nYjAsjWInophgD7cFwCk7OzmQej7E8tqSpNPX1mc4DGHBQZaoVRn42CijuQ5MQCmXZJwJcpBT3kiPrdcMyewuVuuLG5aTDUW/O/AINBP7VdUrWvS22Yu7BHEkc0vNSz+ozSdg40ugahQe7rA+mkqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SN6PR11MB2909.namprd11.prod.outlook.com (2603:10b6:805:d5::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.17; Fri, 18 Mar
 2022 06:16:58 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::c8aa:b5b2:dc34:e893]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::c8aa:b5b2:dc34:e893%8]) with mapi id 15.20.5081.018; Fri, 18 Mar 2022
 06:16:58 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jacob Pan <jacob.jun.pan@linux.intel.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, LKML
 <linux-kernel@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>, "Jason
 Gunthorpe" <jgg@nvidia.com>, Christoph Hellwig <hch@infradead.org>, Lu Baolu
 <baolu.lu@linux.intel.com>, Jean-Philippe Brucker <jean-philippe@linaro.com>
Subject: RE: [PATCH v2 7/8] iommu/vt-d: Delete supervisor/kernel SVA
Thread-Topic: [PATCH v2 7/8] iommu/vt-d: Delete supervisor/kernel SVA
Thread-Index: AQHYOCocpbq5DVETBUCsK14gZYb6VazErkaA
Date: Fri, 18 Mar 2022 06:16:58 +0000
Message-ID: <BN9PR11MB5276B2AB27F5AD50BC18AE718C139@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220315050713.2000518-1-jacob.jun.pan@linux.intel.com>
 <20220315050713.2000518-8-jacob.jun.pan@linux.intel.com>
In-Reply-To: <20220315050713.2000518-8-jacob.jun.pan@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1d92fb6f-ff49-4d41-f210-08da08a6e881
x-ms-traffictypediagnostic: SN6PR11MB2909:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
x-microsoft-antispam-prvs: <SN6PR11MB29095FBFB92770F36FF8FE468C139@SN6PR11MB2909.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yt5KiiuyEDjEaexw5+owbYr7tXk6n3EvuGlLacc7TwKuIvqjiX+NqjmoJ+NurUmpFoDkhzN+oWXfb/06E3slMBvsW1RmyuvVkXWejZ1PXXfWMrNDGb9jPyJngIVecNW0dic26qDj84jahVn98Xv/T/wzsebrBk8bSpPSG40NtvNFtZUi6oCKmw/JlmWJaXGvHztxqX9iek0aQCdV2BjCy+zH9fAilu2Clz0O7ymXYhVWcoHe8kzCmgz2S9SquRX947EMKvfhiDZPNXIi4x/UANujYm4ZTkyubr9Gvq3cYa6KkoXumV/lnRqHOnOe5CELthMHVB1qm7aIOsajIAtdJPbk/HgJcHwqqqlBzgcQuXbjc47RJI0X2+1TvIc+TiuDtiIWUhOXslFtS+xKaSanJRUV6qQDkbnzMhPo/G6lLPmxwvoqvho7A4fr/KQk1/V7YOIR8dHs3pJgfhfonoXuMQBZydAXCDcvYhGZLNJ6HrN4XjRdipXqECaO8IDotTJ6sbaD5RY73N4vuRynTWI1j82fGKxxYTMcL+x36p0aanWkOAzi1EQJB45ey+bIPhwW+Rz8LK8c0yt2vE3xjllWIXjElxZVax3k5pRMH74qVoQBIcW19HH6Mv6hfHB13WbouIvgVq/170iiaCUvEpR3eusNgzzQHZJ240XPhEEWEnbRbUmQTVQp65wWpqC0FvkKuJusNbmQJRyYvDgO/hI3eQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR11MB5276.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(366004)(6506007)(7696005)(2906002)(9686003)(316002)(83380400001)(86362001)(26005)(186003)(5660300002)(508600001)(38100700002)(66556008)(66476007)(8676002)(64756008)(66446008)(76116006)(4326008)(38070700005)(66946007)(54906003)(55016003)(71200400001)(110136005)(8936002)(33656002)(52536014)(82960400001)(122000001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bWKk8z4QQTC5Am6l0DCaO0j09FUA1TsJnIxwS6X1O8JyicpNhhZLYBuv0Kfy?=
 =?us-ascii?Q?Pv3fmXI3PuEFDjVizsrU5KXfQxodICV6LCd5u8xGUBujfD9WKTImZtkZ6lA4?=
 =?us-ascii?Q?OgVEPGXfzchgDm8aIbwJSBxwLjhD/qHJvrGxSel+zhSUBie97pUsvnCn2Jag?=
 =?us-ascii?Q?YDXVJP/y1L0zap4qROtS/GowI9nqMapjW1iN3pOfJOcT2Mkdep2R8un4aN/H?=
 =?us-ascii?Q?g5TOW832x3hl5s3tTKq9l9e11WpybydmnnoS3UQRaNtYvXfiv7PpNeipavvS?=
 =?us-ascii?Q?nUxPFPiFCAd6dZO/QDUeGPG+b0xuWvZT77PTVd+8MyVFsKH6msXCYrr3kzGA?=
 =?us-ascii?Q?pm4Lqd7EANIms2Becexy3z/fZJu0wAcYk5dqhOK+3y81yTwsbzFBnMI4E5hJ?=
 =?us-ascii?Q?cDFdu0PU7JMQKjpIcpiwRxW+SEPo5Zn+xeL/IoNSe56X/zMAlKIFlEJdGEk8?=
 =?us-ascii?Q?pMLvDZk/VGmAul4trOpjkJuWG1cfEWumHbNzKM5zJ4gyYHzFSinBTJwsOimO?=
 =?us-ascii?Q?h64ONK9mK20NBhE0leLPCVOoIpZqz+rwOmqBNCgwmq0rSU8D0iLuJNc/RyWp?=
 =?us-ascii?Q?Tm5ySDLxLFXl4I4qZUVh0Emp3SSUNR1RILfgcI5+5NDexmYHklrTUwLK8LSZ?=
 =?us-ascii?Q?QMQt07vruNS9TBPwAONpt1koAltk93UOgQQveLdTj6SylqiSd9biQD0fbtLt?=
 =?us-ascii?Q?Cqo/YIDGnmgAPWP8h0Wxn0PjH6JUHTldgylnTaXgbqmPMceFeSQDgyG44VQH?=
 =?us-ascii?Q?dt4qXBaBAey5WtoRcoiSbUEuhWJA5tsLAcd07qRPx8WNT6NY9dtKkHPV6tCw?=
 =?us-ascii?Q?1w3s/t+E3wcyufmj6MudBGeGVVOfqcjrsuquk6vf6skGxvRsZUYjxg1Yo1St?=
 =?us-ascii?Q?ayEuzo4p6feRZ+bP96eqtDNURxPIe4j/B6NrwScfRMWwsOVc6RWU/py4SnZS?=
 =?us-ascii?Q?kbCCXOJNfY4PWT/idqoIHSD8KGPM2LP501aPfnFN2s9BAT8Xm+v79FWbTmkM?=
 =?us-ascii?Q?2t/yuTNt/9yxkepFQbyWTkYIwFfFZWmrukInLz9JSsFw7zSWgWK9ThUlM6zn?=
 =?us-ascii?Q?5i6K/D3TskdYmdFg+yYEILzpYPKc+fIrBMGo8s9xLjgO+vmHNb58NjFBZTo1?=
 =?us-ascii?Q?GIOSWFVd0zrLBCXiFcxhKgWTMuikXjVUQ8LBiei8THGYKwuiC+jv0Y2I3My+?=
 =?us-ascii?Q?ipHOJqrMq6EQL2DeTA9thX7wB80gzMJXDky2NF1kXIdK0qH+mNJt1bHULXtg?=
 =?us-ascii?Q?umr6cF9B8wg4RVSq/ctLhEzmOg/+/sH1V44VF7/bIb5+NG0tQroaqerMSttP?=
 =?us-ascii?Q?N6CvmodvvH7GAx8i/kaJ+gD04lKNQhpbL0SxqYWDj+equ/CMo4BMbAIj4UqS?=
 =?us-ascii?Q?kvx4TixqarHVTUhsciG3sMA/nlHD9Pic5LoFrQRn3xoweMEPMJ2Au0iG5mqz?=
 =?us-ascii?Q?nsFBLQKKm8qEQP5ttT4vm7Zqo8YRbrCF?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d92fb6f-ff49-4d41-f210-08da08a6e881
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2022 06:16:58.3207 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SdOjEWLAI+3w0GDHBs/C6PUB0DffXijmXtgmaFW6JKc2S6gC9jUMWZuIkVU0Rudc44pSuUmGgu/MSH8StcGTjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB2909
X-OriginatorOrg: intel.com
Cc: "Luck, Tony" <tony.luck@intel.com>, "Jiang,
 Dave" <dave.jiang@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>, "Zanussi,
 Tom" <tom.zanussi@intel.com>, "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
 "Pan, Jacob jun" <jacob.jun.pan@intel.com>, "Williams,
 Dan J" <dan.j.williams@intel.com>
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

> From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Sent: Tuesday, March 15, 2022 1:07 PM
> 
> In-kernel DMA with PASID should use DMA API now, remove supervisor
> PASID
> SVA support. Remove special cases in bind mm and page request service.
> 
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>

so you removed all the references to SVM_FLAG_SUPERVISOR_MODE
but the definition is still kept in include/linux/intel-svm.h...

> ---
>  drivers/iommu/intel/svm.c | 42 ++++++++-------------------------------
>  1 file changed, 8 insertions(+), 34 deletions(-)
> 
> diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
> index 2c53689da461..37d6218f173b 100644
> --- a/drivers/iommu/intel/svm.c
> +++ b/drivers/iommu/intel/svm.c
> @@ -516,11 +516,10 @@ static void intel_svm_free_pasid(struct mm_struct
> *mm)
> 
>  static struct iommu_sva *intel_svm_bind_mm(struct intel_iommu *iommu,
>  					   struct device *dev,
> -					   struct mm_struct *mm,
> -					   unsigned int flags)
> +					   struct mm_struct *mm)
>  {
>  	struct device_domain_info *info = get_domain_info(dev);
> -	unsigned long iflags, sflags;
> +	unsigned long iflags, sflags = 0;
>  	struct intel_svm_dev *sdev;
>  	struct intel_svm *svm;
>  	int ret = 0;
> @@ -533,16 +532,13 @@ static struct iommu_sva
> *intel_svm_bind_mm(struct intel_iommu *iommu,
> 
>  		svm->pasid = mm->pasid;
>  		svm->mm = mm;
> -		svm->flags = flags;
>  		INIT_LIST_HEAD_RCU(&svm->devs);
> 
> -		if (!(flags & SVM_FLAG_SUPERVISOR_MODE)) {
> -			svm->notifier.ops = &intel_mmuops;
> -			ret = mmu_notifier_register(&svm->notifier, mm);
> -			if (ret) {
> -				kfree(svm);
> -				return ERR_PTR(ret);
> -			}
> +		svm->notifier.ops = &intel_mmuops;
> +		ret = mmu_notifier_register(&svm->notifier, mm);
> +		if (ret) {
> +			kfree(svm);
> +			return ERR_PTR(ret);
>  		}
> 
>  		ret = pasid_private_add(svm->pasid, svm);
> @@ -583,8 +579,6 @@ static struct iommu_sva *intel_svm_bind_mm(struct
> intel_iommu *iommu,
>  	}
> 
>  	/* Setup the pasid table: */
> -	sflags = (flags & SVM_FLAG_SUPERVISOR_MODE) ?
> -			PASID_FLAG_SUPERVISOR_MODE : 0;
>  	sflags |= cpu_feature_enabled(X86_FEATURE_LA57) ?
> PASID_FLAG_FL5LP : 0;
>  	spin_lock_irqsave(&iommu->lock, iflags);
>  	ret = intel_pasid_setup_first_level(iommu, dev, mm->pgd, mm-
> >pasid,
> @@ -957,7 +951,7 @@ static irqreturn_t prq_event_thread(int irq, void *d)
>  			 * to unbind the mm while any page faults are
> outstanding.
>  			 */
>  			svm = pasid_private_find(req->pasid);
> -			if (IS_ERR_OR_NULL(svm) || (svm->flags &
> SVM_FLAG_SUPERVISOR_MODE))
> +			if (IS_ERR_OR_NULL(svm))
>  				goto bad_req;
>  		}
> 
> @@ -1011,29 +1005,9 @@ static irqreturn_t prq_event_thread(int irq, void
> *d)
>  struct iommu_sva *intel_svm_bind(struct device *dev, struct mm_struct
> *mm, void *drvdata)
>  {
>  	struct intel_iommu *iommu = device_to_iommu(dev, NULL, NULL);
> -	unsigned int flags = 0;
>  	struct iommu_sva *sva;
>  	int ret;
> 
> -	if (drvdata)
> -		flags = *(unsigned int *)drvdata;
> -
> -	if (flags & SVM_FLAG_SUPERVISOR_MODE) {
> -		if (!ecap_srs(iommu->ecap)) {
> -			dev_err(dev, "%s: Supervisor PASID not supported\n",
> -				iommu->name);
> -			return ERR_PTR(-EOPNOTSUPP);
> -		}
> -
> -		if (mm) {
> -			dev_err(dev, "%s: Supervisor PASID with user
> provided mm\n",
> -				iommu->name);
> -			return ERR_PTR(-EINVAL);
> -		}
> -
> -		mm = &init_mm;
> -	}
> -
>  	mutex_lock(&pasid_mutex);
>  	ret = intel_svm_alloc_pasid(dev, mm, flags);
>  	if (ret) {
> --
> 2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
