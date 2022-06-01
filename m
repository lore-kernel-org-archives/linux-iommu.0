Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 885E7C433F5
	for <iommu@archiver.kernel.org>; Wed,  1 Jun 2022 08:56:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1AF9E40364;
	Wed,  1 Jun 2022 08:56:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qwvdzcAR33eV; Wed,  1 Jun 2022 08:56:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id B2B8D400DB;
	Wed,  1 Jun 2022 08:56:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 95075C0032;
	Wed,  1 Jun 2022 08:56:35 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4495BC002D
 for <iommu@lists.linux-foundation.org>; Wed,  1 Jun 2022 08:56:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2C87D402F7
 for <iommu@lists.linux-foundation.org>; Wed,  1 Jun 2022 08:56:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0Zc1gpMpAQs8 for <iommu@lists.linux-foundation.org>;
 Wed,  1 Jun 2022 08:56:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D6FF7400DB
 for <iommu@lists.linux-foundation.org>; Wed,  1 Jun 2022 08:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1654073792; x=1685609792;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=oJi9EzlmSaafrpT+/kkMoFnvKilS3eqFdUY3udhUjYU=;
 b=V1ygJO/mQZzN2EfLIVDZBGgVxvQ+cVRyCLrBXadXfH77uP2VvZT2gEbL
 LFzWL8Xzry5MbDNIJ1GxXahvSjp7JynBhKxtC8NWwTivDTqcarFOIYpEP
 STzAlu2y4bi2qKdC1P/paiw4cL7S1qHSIuIanwtF5BDxRdaj4SqGlruDe
 hd8pP8yn/b3rA4RvP8wLH+FOi4KnCRP9GeV6jdoAE2ioBbjh/wSiMHC5f
 l+goa/iMmSLOyksNsfllossaHoBxt0eVtUdk4SQxHYujfgQqhugbY6BuC
 0WbPSKLItH52iJxONRBVAO4pu2DudU2SuS3pBrBWMxdOgmHgepD7LcFZ3 Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10364"; a="256000888"
X-IronPort-AV: E=Sophos;i="5.91,266,1647327600"; d="scan'208";a="256000888"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jun 2022 01:56:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,266,1647327600"; d="scan'208";a="645403341"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by fmsmga004.fm.intel.com with ESMTP; 01 Jun 2022 01:56:31 -0700
Received: from fmsmsx604.amr.corp.intel.com (10.18.126.84) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 1 Jun 2022 01:56:31 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Wed, 1 Jun 2022 01:56:31 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.171)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Wed, 1 Jun 2022 01:56:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DJBGDv9QOBM1DcNEIJxn58N3lpQn5PexA+AejjGJar3U9fRyn8A2kHdDU26vOxYr5sjRyBd7maoisE4hQ3udNURMnNVxyOvxvFzvqbxoZN4CPm9l02dCl0El2UyPtFJX5CT/XNIXtxSNlNZqmrwERu5VCVFBuwbjkLNyy3MN5HORFOYLltTSIJuYGWYdioAbKhrvHxNcOY4X+h3rPii3+hZLSnZyqbtf9foTap9STK1+okhaW0YHZfe7Xda3WaFJ5HbT0qktQw4/ZPqCvCN7CeqkIKWngZ5XHZbYaZsqBliNwr2EzIy8tW/P5H/6RmdpgZQgOmnO+UQwhCF0uZNWBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FXPAaNJ9ogUQ0JIoL5VlnpBrdWkk6sQg3lsb8eMxCYI=;
 b=WVYln0z63QqWjekgIOFBarr2LIH9rRFDGq6ez207IPhHTg+3wR8qKxiy97kGDe/KG+qc28Pcr3obiqpOIA/ycMw9sSaIjorrFA1mm2SJC0KUexz42J56lE4kZlzy/2HfcSifgw5mYclV8yM1/5zt8XX/tbm3j8KuhmhzunNprN+KW2K5GxI+XQkiG/Hj3PAzJrbPNUuyEbDew6do4bVqEWUoyhmUGYQ+D5WQD7c4iwCQ2RxkaVZY3dw2rpjwxtyJ/ViRUzVb1oRntD4hIPmlrL68bDbf7DpYsYkeQoZZQMZkqG7xQslPiY59XVg/dQhz20fJuu06v7rkRg3a7AM/YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH0PR11MB5627.namprd11.prod.outlook.com (2603:10b6:510:e4::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Wed, 1 Jun
 2022 08:56:24 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a1cb:c445:9900:65c8]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a1cb:c445:9900:65c8%7]) with mapi id 15.20.5314.012; Wed, 1 Jun 2022
 08:56:24 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, "Raj, 
 Ashok" <ashok.raj@intel.com>, Christoph Hellwig <hch@infradead.org>, "Jason
 Gunthorpe" <jgg@nvidia.com>
Subject: RE: [PATCH 04/12] iommu/vt-d: Use pci_get_domain_bus_and_slot() in
 pgtable_walk()
Thread-Topic: [PATCH 04/12] iommu/vt-d: Use pci_get_domain_bus_and_slot() in
 pgtable_walk()
Thread-Index: AQHYcZPOC4tEV3ebJEK9SGlZ5uddJ606R6PA
Date: Wed, 1 Jun 2022 08:56:23 +0000
Message-ID: <BN9PR11MB52760466E3E4AAD92DB0F91B8CDF9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220527063019.3112905-1-baolu.lu@linux.intel.com>
 <20220527063019.3112905-5-baolu.lu@linux.intel.com>
In-Reply-To: <20220527063019.3112905-5-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 27fdc7e2-795a-4ba2-1dd8-08da43ac9afb
x-ms-traffictypediagnostic: PH0PR11MB5627:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <PH0PR11MB5627F6BEE985F9BBBFAD0E168CDF9@PH0PR11MB5627.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DpoADSi2FITUDwNSX9lLAQKJ6Ki3nUei27cJIu2lMYMNVxfmtG3+cmuiOE4JorFA8/PM/1+oabsNcuA3aDH6R8Abf6ZM0Ktwg0oHVSkAeuLwAo0BCflE4Z3IPW0XKpqE5tPVfyAtD6LrdF64pyXmnIAyEB5QKvjImPMgcEvJ7RDx7cSjxBbbOmKJUvUA/NJbe8PjVIXZed758qmhF6N3IG7Hovw80NJHfnFUBUh4N4QKqNVmzinwbhMobelCaNNVKhKuEey/VjujBTtl8i4q5MRd6bm5KNwe9Jy7tUbWZDJWS9rQIfZRtKkQDSyYP5QFEsFDvlBmA2dBngH5Jac46PkPKQ/VuxGvAEBH8yocr7qnOcTBheDHwr1nbBC/tmDSjufvtwEjhEcVbX3qlL4Vh3UnF1ZhgJQqQj3AQOkoGBxxxN+Or6POLNksBoez/ZMOcq3b56T2Lrbvv3mrf+/UN7p5jZS1JUU8ZhqmV7Zg4+l/zX0zUZlz2v5Yv9AcbKnkF9fF4V7LTEOcj8HEz980eIrX0yY9EnLTPk2x2zQbkxLzBtL5D47POvoc6abr6UOWdYRwXByMQJFUT7MwVHMTi/5xswug+zDkx2+tqf+aOuYc0V1MD3XhrvqhNrQKLAk37+ZyC8rv6cuFMEqGYsAo4Iq0Jtf3EcW3fZTTi+2+qYQxhW1OU/9lLIxc/rNQL/rE4FkLba4e9nty5rt150AmfA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR11MB5276.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(366004)(38070700005)(86362001)(316002)(2906002)(33656002)(122000001)(110136005)(186003)(54906003)(26005)(9686003)(83380400001)(5660300002)(6506007)(508600001)(7696005)(82960400001)(66446008)(8676002)(64756008)(66946007)(4326008)(8936002)(76116006)(66476007)(71200400001)(66556008)(38100700002)(52536014)(55016003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?AH8gR7TAjriE/riH341e3iCONtQvQCcSI6qXQi7ArKHiCssJl9w1/xiL+x3f?=
 =?us-ascii?Q?CFVU3kDMHGyrklEEtous7UWWN80jz75xCV/OUfwHF/RtN1uTBoVDdx0Kvh0/?=
 =?us-ascii?Q?enBvXrTYHijnUyNEQ+0Bzyfcq17LYIGTl3EiDJ9oWDfKWl+sg2zWnfsrulJh?=
 =?us-ascii?Q?IuMBJrQFXaOhClWBfgw7cQOsAfhnwdjxW/5TDLl7PQMiwl+2aBXsYKgUHeaP?=
 =?us-ascii?Q?t1+ZKkl22XprAf1pBnzCRXR0LJkZ9eJ5C2kc8OauxoiHk4y/qH3wk0rf+rUO?=
 =?us-ascii?Q?5fJac4mjwby0Jo1DEoR2UeKZcVQVgTz5zua4DoIvJbOfRi/438pVvAGQC4P1?=
 =?us-ascii?Q?8ei4z6eNzQKKL3bPY/J4ZwPHYWw6wC3nh9A+e+n7tahCD0VhE05eNqy887yn?=
 =?us-ascii?Q?xNuSHpH8t0f8s9c32mgDWy6lCg/Vt7jtAZ0GNtHhf2zTKBGSIzgk3zc+4bz8?=
 =?us-ascii?Q?xxWVapFpf7LlsbYP1zFA8WGUFNM+u+VEPLHm7JAgg2O81lBbHn8jLXBOlwP7?=
 =?us-ascii?Q?sSWotGuMymo+4pFY51O7gL7G4yOeEbBrGDMzMiL7wa0kiwGA/E9A5uxojeHx?=
 =?us-ascii?Q?g9QTmMFff06STps1q/I44Z8NnWmoom3TGz+9zhMLnmiYaTHst5uRuonkjKNJ?=
 =?us-ascii?Q?nF3T66Y7cosVudWEHbYCItv43/+buqA2SnJA5eYFVNvNNwwmWDplG4WiSEiI?=
 =?us-ascii?Q?3iSp1fQnbqg+eCM+gWZXRJlCDIZErRLvKZ63H90FA2BlpUwR/gDT3S2uuyV/?=
 =?us-ascii?Q?8gU39My+uTFJn4B1el4aQ9ACs2gcvCD896wM1Rp9pp6dlF9Gurme2FP3ZfIC?=
 =?us-ascii?Q?hpfEJTosFXbDm0Mk4S3VxnwfJ9FUBJkgrU6oeSZ3dX5R3XHdkzdtNiH/cQA1?=
 =?us-ascii?Q?Q5dwHnGmQ5IiuE3e3XOMQszK70oLdjbmCUrS89y1FLdGPtNe3WrxV9Z8uF21?=
 =?us-ascii?Q?PE59aMTXPm+tpxaV9qUJCHpzCZtoIKOnR5nlPJNnqhOEcOfFIHpOMOjABMy7?=
 =?us-ascii?Q?KXt/ocbKfZgFCopmWGMSzjEQDJzZFGam2qzvZ7XFDArKgx+0IybcsiirbdPU?=
 =?us-ascii?Q?AkMjQR5KFqLDy/kUEe8nK8xABVUKLTDOa/jMNlxDs47L5JCxLKiL/SKiz2zP?=
 =?us-ascii?Q?ir9KDXMNgxuQmKFY4Ane/he/RD2Z5jwCc8dSQ0hOKLVHoDtoTsmkKCIrsfMZ?=
 =?us-ascii?Q?WWsbbeEST8O8oR8CExPCtoXd17u/ncSXLaJleljsFgKykmcu0npp4NlNlhD1?=
 =?us-ascii?Q?UY7gWXXtWJ+SV9pMpXE8vnH0byfrL1JsmOe01ngyvTaQ3GJew/g1N8MxNQyA?=
 =?us-ascii?Q?hykyLuEbywQu2e29ilscxypYpuFEg2aCUnQnFx49ibT0W69Z5SCo1pmu7BOJ?=
 =?us-ascii?Q?Qu6yysLpaM/qJ+9+QJOTiHWaibqJf7VKkLU1evMldssDGyGqIyd4CIC1UGHs?=
 =?us-ascii?Q?bs5IrJ7/JQCKgb4TS93f+5EfUkhwHmglaMtiUmUgHfBJyvDpZjDpLw3ZgNEb?=
 =?us-ascii?Q?aARjrDHfqwhHdG8Q+Jr+V3zGFiuLpC+LgBNO+ZNvslFxZ4/g/2IOmo4oiszv?=
 =?us-ascii?Q?Wk5mq5qfqR8sWZCJQ//dtFR+lgzm/mkoYg2T0MrnOOKBs50CwKPUWB00ogNf?=
 =?us-ascii?Q?TavpVnPSigI031Qf9j3oZvU1iLI8dWzxcfrHRIVpCZHWlya7VY0zMqep1Wb5?=
 =?us-ascii?Q?PPclVRrU4gN97ApPKif5WEGjCsdMPObPTmF9+nJMQidAybbFIrRrW8J8JLMn?=
 =?us-ascii?Q?1Gg1AvYCYw=3D=3D?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27fdc7e2-795a-4ba2-1dd8-08da43ac9afb
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2022 08:56:23.9617 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iO+kAc85vRH6iFCiTErmA2haDipk+3BVyMzyBDW0d3V9AUxfNTAfsu+nnaHc8n0ikWdOsQSs5tnSUa4/4v0PkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5627
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
> Use pci_get_domain_bus_and_slot() instead of searching the global list
> to retrieve the pci device pointer. This removes device_domain_list
> global list as there are no consumers anymore.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

> ---
>  drivers/iommu/intel/iommu.h |  1 -
>  drivers/iommu/intel/iommu.c | 33 ++++++---------------------------
>  2 files changed, 6 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
> index 2f4a5b9509c0..6724703d573b 100644
> --- a/drivers/iommu/intel/iommu.h
> +++ b/drivers/iommu/intel/iommu.h
> @@ -609,7 +609,6 @@ struct intel_iommu {
>  /* PCI domain-device relationship */
>  struct device_domain_info {
>  	struct list_head link;	/* link to domain siblings */
> -	struct list_head global; /* link to global list */
>  	struct list_head table;	/* link to pasid table */
>  	u32 segment;		/* PCI segment number */
>  	u8 bus;			/* PCI bus number */
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 25d4c5200526..bbdd3417a1b1 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -131,8 +131,6 @@ static struct intel_iommu **g_iommus;
> 
>  static void __init check_tylersburg_isoch(void);
>  static int rwbf_quirk;
> -static inline struct device_domain_info *
> -dmar_search_domain_by_dev_info(int segment, int bus, int devfn);
> 
>  /*
>   * set to 1 to panic kernel if can't successfully enable VT-d
> @@ -315,7 +313,6 @@ static int iommu_skip_te_disable;
>  #define IDENTMAP_AZALIA		4
> 
>  static DEFINE_SPINLOCK(device_domain_lock);
> -static LIST_HEAD(device_domain_list);
>  const struct iommu_ops intel_iommu_ops;
> 
>  static bool translation_pre_enabled(struct intel_iommu *iommu)
> @@ -845,9 +842,14 @@ static void pgtable_walk(struct intel_iommu
> *iommu, unsigned long pfn, u8 bus, u
>  	struct device_domain_info *info;
>  	struct dma_pte *parent, *pte;
>  	struct dmar_domain *domain;
> +	struct pci_dev *pdev;
>  	int offset, level;
> 
> -	info = dmar_search_domain_by_dev_info(iommu->segment, bus,
> devfn);
> +	pdev = pci_get_domain_bus_and_slot(iommu->segment, bus, devfn);
> +	if (!pdev)
> +		return;
> +
> +	info = dev_iommu_priv_get(&pdev->dev);
>  	if (!info || !info->domain) {
>  		pr_info("device [%02x:%02x.%d] not probed\n",
>  			bus, PCI_SLOT(devfn), PCI_FUNC(devfn));
> @@ -2348,19 +2350,6 @@ static void domain_remove_dev_info(struct
> dmar_domain *domain)
>  	spin_unlock_irqrestore(&device_domain_lock, flags);
>  }
> 
> -static inline struct device_domain_info *
> -dmar_search_domain_by_dev_info(int segment, int bus, int devfn)
> -{
> -	struct device_domain_info *info;
> -
> -	list_for_each_entry(info, &device_domain_list, global)
> -		if (info->segment == segment && info->bus == bus &&
> -		    info->devfn == devfn)
> -			return info;
> -
> -	return NULL;
> -}
> -
>  static int domain_setup_first_level(struct intel_iommu *iommu,
>  				    struct dmar_domain *domain,
>  				    struct device *dev,
> @@ -4564,7 +4553,6 @@ static struct iommu_device
> *intel_iommu_probe_device(struct device *dev)
>  	struct pci_dev *pdev = dev_is_pci(dev) ? to_pci_dev(dev) : NULL;
>  	struct device_domain_info *info;
>  	struct intel_iommu *iommu;
> -	unsigned long flags;
>  	u8 bus, devfn;
> 
>  	iommu = device_to_iommu(dev, &bus, &devfn);
> @@ -4607,10 +4595,7 @@ static struct iommu_device
> *intel_iommu_probe_device(struct device *dev)
>  		}
>  	}
> 
> -	spin_lock_irqsave(&device_domain_lock, flags);
> -	list_add(&info->global, &device_domain_list);
>  	dev_iommu_priv_set(dev, info);
> -	spin_unlock_irqrestore(&device_domain_lock, flags);
> 
>  	return &iommu->iommu;
>  }
> @@ -4618,15 +4603,9 @@ static struct iommu_device
> *intel_iommu_probe_device(struct device *dev)
>  static void intel_iommu_release_device(struct device *dev)
>  {
>  	struct device_domain_info *info = dev_iommu_priv_get(dev);
> -	unsigned long flags;
> 
>  	dmar_remove_one_dev_info(dev);
> -
> -	spin_lock_irqsave(&device_domain_lock, flags);
>  	dev_iommu_priv_set(dev, NULL);
> -	list_del(&info->global);
> -	spin_unlock_irqrestore(&device_domain_lock, flags);
> -
>  	kfree(info);
>  	set_dma_ops(dev, NULL);
>  }
> --
> 2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
