Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4A2EC433EF
	for <iommu@archiver.kernel.org>; Wed,  1 Jun 2022 08:53:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9C2C682B2F;
	Wed,  1 Jun 2022 08:53:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id F_YME_BDZmD9; Wed,  1 Jun 2022 08:53:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 51E60827CA;
	Wed,  1 Jun 2022 08:53:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2873CC0032;
	Wed,  1 Jun 2022 08:53:58 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 160E4C002D
 for <iommu@lists.linux-foundation.org>; Wed,  1 Jun 2022 08:53:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E973540364
 for <iommu@lists.linux-foundation.org>; Wed,  1 Jun 2022 08:53:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1HajJlHM1P-v for <iommu@lists.linux-foundation.org>;
 Wed,  1 Jun 2022 08:53:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 027D8402F7
 for <iommu@lists.linux-foundation.org>; Wed,  1 Jun 2022 08:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1654073634; x=1685609634;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=8CxWWtNXXRSk8bDE3scy/uU2EHj+ESg6tKwEi5qh7sc=;
 b=QwNnS+xtHtKgh8uGEsz3Fmaa6JIE2zleMVB28wR/733/42EAIwtnN4Yd
 44b/FgmuCddykIm2lMTYJUvzgf69Q5x0awQuzeqkqa88bR3EsfEMvWpFk
 1fOFiiCm3/pWGP/rG5Wj2lxXpRVZNJdiIm4a/MB3qcJRuqYeaHclZyP0C
 eNZeZwymba7IlQUAcPtGpYRClCnqm3ax8p1GbfyvHzdJtxslpmJyE3baH
 hQVjGgaIoHirEeXnYet7+SGvxcMS8OAjMIgAdAkQAEetZNb08TSXxBSbY
 liVzsDNQpgN1tcCXfXZfE5ws7HwrvzlYDq8gteSIzHOCmelKoVovWEg/Z Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10364"; a="257593270"
X-IronPort-AV: E=Sophos;i="5.91,266,1647327600"; d="scan'208";a="257593270"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jun 2022 01:53:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,266,1647327600"; d="scan'208";a="645402752"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by fmsmga004.fm.intel.com with ESMTP; 01 Jun 2022 01:53:52 -0700
Received: from fmsmsx604.amr.corp.intel.com (10.18.126.84) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 1 Jun 2022 01:53:52 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Wed, 1 Jun 2022 01:53:52 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Wed, 1 Jun 2022 01:53:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PsY/49TpKjDuXaipYdUo8JK50J0EoruxmSnzl2f/iMsNLxdKlVx+PTZ2nmIAd1kQsfsRz/ox2sGN0T5tx71uE8YnVH8q3Dd0RXYi3ETicV9w4AQHv5/h8U4Ho2UY31+XqFn6VL0IZ3f65ZmV+4wwAcl64kJwwu4XywawSxSquuQUQmDjqWpBvcoZDVyVJu58mKCFIiRcgFyPrR3oA8OiVEDWN3hpnFLdeDBBgZZybxwJc2zrFglPXPyNW2WA+rrDITsB58xWRI6f6dVb1+eFDsaDVjjCjjOwfjC4OJLrduNqtQpcz2LyxzUkDEp0koN+nmKj7OGE9K0MEEHpV61m+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TndGWk60QKHwwkww7BksO0DZmbkLhhZJiWdFu1Ml/zE=;
 b=jFw4F7BSsIR1CB7PxXjdbXN4UBvzyeFZJPy8N0DEPMeZa3q5eLryqS8MkEUfA2nYTziHCbJKflsj4qV+kWDI2pn3sFNhu/7ejix7vo9WDcYvLeBWCMztOZgei3N4Tx1Sngd4WBejCix7TXBgjrlvqvshyFA5cFljYZqHen9UxWyO7qfV3LOMxGPWuZ95i7xrbxFj+D4ZR1oP+LtzioV6YV2lI5RmwDIyRiAfzvv4CsYa5U/78SS4XJIMGGbcmtEqOUgy5gnuNOQTw9GYTBBA00eVxmRvCGEQxomJ/PYFOR1M4VSfFXChwkmN3DgLu24ibzzWQdm+MJFuyW5BH7ShHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by MWHPR1101MB2368.namprd11.prod.outlook.com (2603:10b6:300:7a::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Wed, 1 Jun
 2022 08:53:49 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a1cb:c445:9900:65c8]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a1cb:c445:9900:65c8%7]) with mapi id 15.20.5314.012; Wed, 1 Jun 2022
 08:53:49 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, "Raj, 
 Ashok" <ashok.raj@intel.com>, Christoph Hellwig <hch@infradead.org>, "Jason
 Gunthorpe" <jgg@nvidia.com>
Subject: RE: [PATCH 02/12] iommu/vt-d: Remove for_each_device_domain()
Thread-Topic: [PATCH 02/12] iommu/vt-d: Remove for_each_device_domain()
Thread-Index: AQHYcZPIYhaiUmO/rUezTIT5CHjRpa06RvAQ
Date: Wed, 1 Jun 2022 08:53:49 +0000
Message-ID: <BN9PR11MB52765AA85090A90FE35ADAAA8CDF9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220527063019.3112905-1-baolu.lu@linux.intel.com>
 <20220527063019.3112905-3-baolu.lu@linux.intel.com>
In-Reply-To: <20220527063019.3112905-3-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 798fd184-acb8-4a43-e73b-08da43ac3f1a
x-ms-traffictypediagnostic: MWHPR1101MB2368:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <MWHPR1101MB23689A448AF2BFA6CADED5248CDF9@MWHPR1101MB2368.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EVTovk9YOYBP6hgMXufZQbPQMN2FZwP1azLiKc8VqGdYKc03LDW59IiT6yTFmqQEK9lvWFlp93Jj9qZ0iKmpU99A1LRH/6MW3lRxLCu6MFdA+GKo+Q06DBmkcJGOMjBKdsed8pSOuV/Q+2V1hi9S0cr3GpwZC0anlg3MbJXVRn6ffxdAtWYeh3pfIOW5lRfouezlmDjFRvGha1J6lB0fxRq3+8XxspUZfGpyPu6Zge1H+0DhCtB0mojha1OJm9oKut1FOnO8k90kTOSFqVhpxzYxx33vN7WF+FONJPCNkEAXmhakV0lVnPCYe0SHviCoNlvXfkECL24aKXbk0N47W7uyKD1QEL67lStTq08sK5dzfWNQNpNi7H0qQEl4d4rR6Q+979NOPPaldBq1zXKQs87oS9GMnzBPAqxDL8j0XmwC1czgFHXpVNQktPHQOBKksu1YZSZWfBSvvvDWAH9kqvbxngO/XmcOtPkvlkqT3xD9wMlqnNRT6wIOwur2Hwwimgh1F8i/K6AVmYhlFitaMxMnDQ67j/vJ3gxV80NlPfgATzN9ZfvwChW7P+RfvvEpbQhMjpOnYppAkIk6ab6TpR30TO64EKFYfDDLAsY1zWsmMJFDrwx2x5ad1/glPzWykR/2uK1kbr2VR+6/I2mr5mi4qczTnIztg0vgBTF3NhaZhU7HhC0hZw3ig14dtBX3oijD5u5jdbvgZMR6L653cQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR11MB5276.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(366004)(86362001)(5660300002)(66476007)(8676002)(66446008)(66556008)(76116006)(64756008)(38100700002)(8936002)(4326008)(52536014)(66946007)(186003)(508600001)(71200400001)(33656002)(7696005)(26005)(9686003)(110136005)(54906003)(6506007)(316002)(2906002)(82960400001)(83380400001)(55016003)(122000001)(38070700005);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?59V+iCccsBISjRtqZ7twk5S0IP9AJVdCkmloX65knmUe4WbBLprk73lpKh8h?=
 =?us-ascii?Q?Bz5p0FXeiZs8WU7ue1fqhByjEUdyE5dRJRCoabRrJHH6nYdfmMvHgktGptj1?=
 =?us-ascii?Q?eKz+OP9YjdS5/Pnkx05Sx93VEd361QPeivU/jC9MT3t9q0tV+hwZ1OzvA31g?=
 =?us-ascii?Q?8XCd404gcQgD0or+es/IfA23FpgBKyBNlx7E1XTBfmcit3vvSvpeXB7RVkbx?=
 =?us-ascii?Q?vNoZMp7/PjOJCKgubv+upUZM1/g4e+JKEWZMsPLgnpJu4AWpMildDiCbvHTn?=
 =?us-ascii?Q?33XD0tukWINmQ4OyR69AG6EE1t3VK6jPN+01cchujuOaCQcZpxwHPZ1VM/0R?=
 =?us-ascii?Q?wHlHjufFtHfG/2aBOpfUQ1zo6eFQPCXOoIPxUjkJIj7jJbbLharmoMnr71gk?=
 =?us-ascii?Q?qrSMdEOFAaH4gt4wtG5QqIR7tWhRzaM1Ifb/zyIliAR+y/AIgyyOXwTMTtSR?=
 =?us-ascii?Q?v//x4EmDtc4Egrh2dFz7ZHE9quJEZBvHv88mKaYtGTapo4aWtznjEXJgasn9?=
 =?us-ascii?Q?/Q62Z276KUFoTtsodQRwvtGhdio62CWZiHk3ekdFx+J6XhQJEFwoDmm7urHX?=
 =?us-ascii?Q?WcQkdYYvk33YSGdNQ7EGGrDIzj+/BP8/lsV+3MY6Cdep8/NTlUBQEpBfExcw?=
 =?us-ascii?Q?i49AU1UGpAXNDtPBeSVRMKwPD5ATfy6MR3OIw7IR1wYsvv+KvEhfoDbXfy1O?=
 =?us-ascii?Q?+iSKlUzUraasQRS6cjRI1occr5RNQiN06ehf0j/X2pRxnzgLi/T/LChMwGqn?=
 =?us-ascii?Q?Mb4cQ4j+vEcWBhBph0CuWquKFit5ZDmhAcCgk4iqFJ7tPN1nlyoz1ZeoyUUy?=
 =?us-ascii?Q?G+00dRquPmDKTR6YMcVOJCWdEPEiKRE1mQ3tgUUxC1SVS+YkBAPVVKtsyQ8T?=
 =?us-ascii?Q?t8VscTZ9KEyPavjCie1C/A6bX3z09EnaOe7UvU12qDFZ1t/X3K8CdUSxWgRo?=
 =?us-ascii?Q?PTr4Te4ise0fFc/S2+W5ro/fJjcSB0UTAsC7DGNgkBzZde/J+r+0igabDlaA?=
 =?us-ascii?Q?nyzFREXojAKGSXJV4+2fN7gVU3JdhkutqvxcPmiWW/+ndCZneMHw0TjeHLOX?=
 =?us-ascii?Q?KAHUY/qh4CC/8SH6yVNwMIQ7QRvQ9/twfE+aElzdwTbGtMuNebDZHEY92jB6?=
 =?us-ascii?Q?T52TAVE9UuKhgUWG7rE2+AhquMhvuCr8bt6zBLiZ+Dc1lg9nNHdX/m5qu+Aj?=
 =?us-ascii?Q?fFfuMrPwO9jm55fqCgpQaXGRcfsURHJ1ussRSXkIrsiDJo3PIYOuVPOR8Fm3?=
 =?us-ascii?Q?CEREyAGimTmPDWhwJbttmc2GfVFY3xL73k8/eYCSzj0wV2acrUKeFYXVCQRk?=
 =?us-ascii?Q?v20rHwdfSLHfzr+3aoDOe57KWGsc+bCYd7m48C/rGDcOJGmNWz6VmtxM6bVp?=
 =?us-ascii?Q?24GShbWf+UTbUgpiap/OxRvh1+Naf5MTPZd7aWqLOHZrHn8FA2W1FoDfAXSz?=
 =?us-ascii?Q?lxKukOJTI9wULKZLISTAjo2zk4Nsb6G/NFSFLivOw8TmjvAAFj+E4/uZoGgv?=
 =?us-ascii?Q?mx9ZKhHBQEDJU8qAyXkMctbbb+5bWqbd74ckimwqw4gNeRwRlfiLJMBbpciN?=
 =?us-ascii?Q?pwTXyGmidXVgzVfqajmt70UwtNYkote+sDWeBmmSTjJuNC3L/B3V1fRNvAJJ?=
 =?us-ascii?Q?R01G5Ryqp93VTyXRLzZsI4VjO+rM0VRR+YZSrzMQiLQld/z7ntYcc9g6c9aD?=
 =?us-ascii?Q?j7VFqZZ5+Xoy2ZfSEHnnANiVyVULD9uNO81ie9u1ouTvTnBtOOjI8O9wcVpK?=
 =?us-ascii?Q?vhynsPXelA=3D=3D?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 798fd184-acb8-4a43-e73b-08da43ac3f1a
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2022 08:53:49.8354 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yHGNdiSCGrLkzr4/H8Ox2NBMQCUczYz/IJv9t/VMa71dLoWs4e5ZvMUeuNxhQImiRqgo/UXWTA1DCVbhdtpn1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1101MB2368
X-OriginatorOrg: intel.com
Cc: Will Deacon <will@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Pan,
 Jacob jun" <jacob.jun.pan@intel.com>, Robin Murphy <robin.murphy@arm.com>
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

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Friday, May 27, 2022 2:30 PM
> 
> The per-device device_domain_info data could be retrieved from the
> device itself. There's no need to search a global list.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

> ---
>  drivers/iommu/intel/iommu.h |  2 --
>  drivers/iommu/intel/iommu.c | 25 -------------------------
>  drivers/iommu/intel/pasid.c | 37 +++++++++++--------------------------
>  3 files changed, 11 insertions(+), 53 deletions(-)
> 
> diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
> index 8a6d64d726c0..2f4a5b9509c0 100644
> --- a/drivers/iommu/intel/iommu.h
> +++ b/drivers/iommu/intel/iommu.h
> @@ -727,8 +727,6 @@ extern int dmar_ir_support(void);
>  void *alloc_pgtable_page(int node);
>  void free_pgtable_page(void *vaddr);
>  struct intel_iommu *domain_get_iommu(struct dmar_domain *domain);
> -int for_each_device_domain(int (*fn)(struct device_domain_info *info,
> -				     void *data), void *data);
>  void iommu_flush_write_buffer(struct intel_iommu *iommu);
>  int intel_iommu_enable_pasid(struct intel_iommu *iommu, struct device
> *dev);
>  struct intel_iommu *device_to_iommu(struct device *dev, u8 *bus, u8
> *devfn);
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index cacae8bdaa65..6549b09d7f32 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -316,31 +316,6 @@ static int iommu_skip_te_disable;
> 
>  static DEFINE_SPINLOCK(device_domain_lock);
>  static LIST_HEAD(device_domain_list);
> -
> -/*
> - * Iterate over elements in device_domain_list and call the specified
> - * callback @fn against each element.
> - */
> -int for_each_device_domain(int (*fn)(struct device_domain_info *info,
> -				     void *data), void *data)
> -{
> -	int ret = 0;
> -	unsigned long flags;
> -	struct device_domain_info *info;
> -
> -	spin_lock_irqsave(&device_domain_lock, flags);
> -	list_for_each_entry(info, &device_domain_list, global) {
> -		ret = fn(info, data);
> -		if (ret) {
> -			spin_unlock_irqrestore(&device_domain_lock, flags);
> -			return ret;
> -		}
> -	}
> -	spin_unlock_irqrestore(&device_domain_lock, flags);
> -
> -	return 0;
> -}
> -
>  const struct iommu_ops intel_iommu_ops;
> 
>  static bool translation_pre_enabled(struct intel_iommu *iommu)
> diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
> index b2ac5869286f..0627d6465f25 100644
> --- a/drivers/iommu/intel/pasid.c
> +++ b/drivers/iommu/intel/pasid.c
> @@ -103,36 +103,20 @@ device_detach_pasid_table(struct
> device_domain_info *info,
>  }
> 
>  struct pasid_table_opaque {
> -	struct pasid_table	**pasid_table;
> -	int			segment;
> -	int			bus;
> -	int			devfn;
> +	struct pasid_table	*pasid_table;
>  };
> 
> -static int search_pasid_table(struct device_domain_info *info, void *opaque)
> -{
> -	struct pasid_table_opaque *data = opaque;
> -
> -	if (info->iommu->segment == data->segment &&
> -	    info->bus == data->bus &&
> -	    info->devfn == data->devfn &&
> -	    info->pasid_table) {
> -		*data->pasid_table = info->pasid_table;
> -		return 1;
> -	}
> -
> -	return 0;
> -}
> -
>  static int get_alias_pasid_table(struct pci_dev *pdev, u16 alias, void
> *opaque)
>  {
>  	struct pasid_table_opaque *data = opaque;
> +	struct device_domain_info *info;
> 
> -	data->segment = pci_domain_nr(pdev->bus);
> -	data->bus = PCI_BUS_NUM(alias);
> -	data->devfn = alias & 0xff;
> +	info = dev_iommu_priv_get(&pdev->dev);
> +	if (!info || !info->pasid_table)
> +		return 0;
> 
> -	return for_each_device_domain(&search_pasid_table, data);
> +	data->pasid_table = info->pasid_table;
> +	return 1;
>  }
> 
>  /*
> @@ -141,9 +125,9 @@ static int get_alias_pasid_table(struct pci_dev *pdev,
> u16 alias, void *opaque)
>   */
>  int intel_pasid_alloc_table(struct device *dev)
>  {
> +	struct pasid_table_opaque data = { NULL };
>  	struct device_domain_info *info;
>  	struct pasid_table *pasid_table;
> -	struct pasid_table_opaque data;
>  	struct page *pages;
>  	u32 max_pasid = 0;
>  	int ret, order;
> @@ -155,11 +139,12 @@ int intel_pasid_alloc_table(struct device *dev)
>  		return -EINVAL;
> 
>  	/* DMA alias device already has a pasid table, use it: */
> -	data.pasid_table = &pasid_table;
>  	ret = pci_for_each_dma_alias(to_pci_dev(dev),
>  				     &get_alias_pasid_table, &data);
> -	if (ret)
> +	if (ret) {
> +		pasid_table = data.pasid_table;
>  		goto attach_out;
> +	}
> 
>  	pasid_table = kzalloc(sizeof(*pasid_table), GFP_KERNEL);
>  	if (!pasid_table)
> --
> 2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
