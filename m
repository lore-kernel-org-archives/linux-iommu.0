Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C884BC433EF
	for <iommu@archiver.kernel.org>; Fri, 22 Apr 2022 03:07:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 78E2160EA4;
	Fri, 22 Apr 2022 03:07:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qoGHCiEkWhqS; Fri, 22 Apr 2022 03:07:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 4DD0E60EB8;
	Fri, 22 Apr 2022 03:07:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B3FE9C0039;
	Fri, 22 Apr 2022 03:07:12 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2FEF7C0039
 for <iommu@lists.linux-foundation.org>; Fri, 22 Apr 2022 03:07:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1CBF460EB8
 for <iommu@lists.linux-foundation.org>; Fri, 22 Apr 2022 03:07:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id v0GlWpueug2a for <iommu@lists.linux-foundation.org>;
 Fri, 22 Apr 2022 03:07:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 534BE60EA4
 for <iommu@lists.linux-foundation.org>; Fri, 22 Apr 2022 03:07:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1650596830; x=1682132830;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=IjjrooUcE6xIdhMJi/LXWVgZXj/lfBhy4rBE6Nd4l6c=;
 b=aGWiOdOAWsNez7nHRBndWMeA+lwZHqBMKOhMsi6r1IwypKlOZcegvqGv
 FGNuy/EJjCEkfdRhfTKnzU3B+PZ7BndIfiG3sztiEfnVBN88jkAxOMB9s
 Keugh65DIh9nPCNpjpEzQSEu16TAQwukjga1wncph1nEiIQb72G3hjWHu
 pNXxoYYDGdKwLOJ4wDk9q7du/cs9dy2z7AB+H+GMTxbcaTD2DSUu10UzU
 uLKTaZ6r4QWanGVAYEora6/Q2EzA8TGfUccgES0qKnsbfFA9nVsvWEFsa
 OZzZOWOqJfYR6yFL8aJ1vlPdh7RX9XyVA5z2suH0ncPLYz819asayMbXh Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="289671342"
X-IronPort-AV: E=Sophos;i="5.90,280,1643702400"; d="scan'208";a="289671342"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Apr 2022 20:07:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,280,1643702400"; d="scan'208";a="593958721"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by orsmga001.jf.intel.com with ESMTP; 21 Apr 2022 20:07:09 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 21 Apr 2022 20:07:09 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 21 Apr 2022 20:07:08 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Thu, 21 Apr 2022 20:07:08 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Thu, 21 Apr 2022 20:07:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Quu0TdkJFCvsd2hG6/Vj3NZ+AZxuOVvai78Hxvk45xj+aYTW81QQow58BUcuA7MiaShVAMd+xH28lkTVWE0kj4Z6gqlxtr1UjBNO+eYJidd9I2K8kYV0qWxGVyD1zmI/Asnjmhe+afKY5sp9UkDBxwuSo20dmoPLojcq5mMML00SoG5VNZzO9rGWjx/pMzL+hBJyWsS7r8yF3mQZKO29MSyJqBOK2ZRh2GjSiiorjKluHgKD8IObrEqcehUjuiLvcsqI6vcoxkoHv/4EV0EfGMO7wJ82Co6FkAp0zaJINNvOBSuhZgUy41EHOV7OVFPhXiMyCc1tViRMgmvQmF84lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aovGql+5F43+BJqWOpZ0EIP7DespbazR+Psvrs6Qwsw=;
 b=lz0gx3lHbuPqBa/lepJgJgtFsHOxmv690HjtG3JukY86Y7y8oVU4sjfRegraYzAVAejnbr0xiRd9OAUFaaCGaEQd5X9Bjm/MWJEH8dwTOuEkKB88TfVZP1H7lMk8Pqkd2c5Stke0SAisAgnJP5CMo5bvwRz9wOWGiDSgy3GVRHUZBd6mP7aZoNQ9pV3bP4/eSMkDYNnNzuWAp/Q3XCWjJbc4xCDtDup2JP0cvka2sHExvviE4sq/oG9QFh7+lXXKDq70oPM2SnPUx9ox1qZOymMggQSKfh6u8W18jRjYgJdGTek2eMh/rRb0eqUjNLBOqnAquCW55n12Yk5TMeHeTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by BL1PR11MB5544.namprd11.prod.outlook.com (2603:10b6:208:314::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Fri, 22 Apr
 2022 03:07:06 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::24dd:37c2:3778:1adb]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::24dd:37c2:3778:1adb%2]) with mapi id 15.20.5186.015; Fri, 22 Apr 2022
 03:07:05 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, "Pan, Jacob jun"
 <jacob.jun.pan@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>, "Liu, Yi L"
 <yi.l.liu@intel.com>
Subject: RE: [PATCH v2 4/4] iommu/vt-d: Size Page Request Queue to avoid
 overflow condition
Thread-Topic: [PATCH v2 4/4] iommu/vt-d: Size Page Request Queue to avoid
 overflow condition
Thread-Index: AQHYVXRp8Xn0v+nT40GU5MeJ9U8hK6z7QQfg
Date: Fri, 22 Apr 2022 03:07:05 +0000
Message-ID: <BN9PR11MB5276F593B25A1D3C8B2595638CF79@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220421113558.3504874-1-baolu.lu@linux.intel.com>
 <20220421113558.3504874-5-baolu.lu@linux.intel.com>
In-Reply-To: <20220421113558.3504874-5-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4da2555e-d69a-40e3-f43a-08da240d2e71
x-ms-traffictypediagnostic: BL1PR11MB5544:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <BL1PR11MB554419ADF26CE261D29539AE8CF79@BL1PR11MB5544.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: A6vM3OLXYzUAybewea1LiZpop7WjvcZIZ/PTYpCXlz1kvq2uSEkkv6Zue8t8Yf65n06CM8bmoCywg7PXzze8YhZcduJP7vduZDg8gC2Nm/M3Bqoi/sSdVaVJfUdMxcQk85Ph4yfy2/klWd4Xq1IiJVMLTYPQ8Mug3XI2citHONDGkdozs/7zuzhuNpX9iEdfhDS6a1Vvd91mraBNvpQIV1a+hBBNDXlwU9gUCHeINIRGfywXlWQTvfTe9TVVoTx5WpimNij9HRpSkR5/5/beVRqkhbX3w1Jr3ztEFncrpc7sCAvDKLn155TeafRHr/P4EJch0T6N5DDTMs49RR9cJ7KDY3ClfgYtEodZFPbleTkdMA5TGcSvgYEKQfiaEqiZLcZvfq5tUTPhjBRQK8uThonE7Prj9STM56qU9Wc8fB28yljO+joRM/PR3hgmgp3NwaB1xyXqwDDZBD1LZczKZmOk0ipTRhL8t4sIYech/1KWGbs7lN4b8QoQ51ClKXt2R1k7dF+kxR3SJl96RPTKbuA0sGxMu25VhIU4KYcUWpmgUci4hmzVihf8wZJhQGPXW6I/oAwJfK9hUfR9z1Mcb7WBfE7ELuTjBake1g4dXmpNcbPSicfzXg3Q5I4fBrJym1xswBoOqJbsuxxFYTUhLDitk2odjnEK/X2eEKb4xZuHR4FlbaIIYpmx5EsvBulGh/Gai/fpfTp36RygjQmzju9xI22gEbVPJvOO5S+S8r4r6vr67qtd5wcbFlaj6vcf7AAOceP3H+qkbCxI2z+WzLdplzLdEfwseZ0ckKCspv8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR11MB5276.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(366004)(4326008)(71200400001)(6636002)(54906003)(7696005)(110136005)(38070700005)(33656002)(76116006)(66556008)(66946007)(186003)(64756008)(66446008)(66476007)(8676002)(316002)(5660300002)(86362001)(508600001)(966005)(52536014)(8936002)(6506007)(83380400001)(38100700002)(55016003)(2906002)(122000001)(82960400001)(9686003)(26005);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ceaEkJ3XaZZzYQ4ESwzlo57247cS9loEoA9rZFF1b/5rcWbXtjm1Od0aQWz1?=
 =?us-ascii?Q?XmPTgWHPn0LKt0vrDRgU+ne4eYgBEOgXPju9SS5uPMNK9BKQz/JnJNs4QCBC?=
 =?us-ascii?Q?FwJIrT8BL0lBTufm2pOwCpw9h1/i9tB5yNIxRdH6jkamaQwrFAn0Deh+XOPy?=
 =?us-ascii?Q?ha6kSTJFDyJ+1oBPewRjCDRJ0W5GQ98rcPnVeAR339SP6axxqcP3IGYMyZws?=
 =?us-ascii?Q?wP3TdWxAs1Ihtvg2zUdt3IE1sWTlccmPEDRz0ClQ11t9u3Bjf46fO9CJglzC?=
 =?us-ascii?Q?UUOCo9wG2nXThd6QkIEvi7e4iOKirsAdlSR0taSus+BFHXBi+EERIAf9lCBv?=
 =?us-ascii?Q?CVOYNxIecdkqQnYft86NBCclGbaB9KUVk0zZRIY72DDCXZJDS3EDSD83I8LR?=
 =?us-ascii?Q?+3Ge4Bm2ExGwFQygj7QhyAT/Vo7XEfNZwlYSig9Ot9ojNhU6vlu8Oe8GpB2J?=
 =?us-ascii?Q?vXPqluXtWezv+6vnake8d2Q3fseCL3GHz4b/L+k88R3pW3AgSC3ByR3dykTS?=
 =?us-ascii?Q?4PXu+nPKq7BNeuVybrAmleskpB1izU4hg0dOKQqxw6sfIkhGJ9jk06smIZy6?=
 =?us-ascii?Q?ZsHI7RuEOROEtxahLMbAlrqVNb4gyZq4bpEYviROAc+gfIppbf0tPOzPrFr7?=
 =?us-ascii?Q?HaWftSjiyR8mjnS7HOdD9hCRBiTne/C35VpSIyphi7x2KnkrXoVDurFPtzHV?=
 =?us-ascii?Q?1nhZ+kDs4maudt+vGLRGct5j8lpeTza8Qu8vrYKtWaNf23YWFhWDz8QbgbOD?=
 =?us-ascii?Q?Sse7rYB2M7O3J4t4DLHbCFROQJHwudBD4sm+RiENf6j21a8ZviThLXpaJ8u3?=
 =?us-ascii?Q?ouemigEHXjKjGuECCXNBZMc3I/6v6LPDJHzMtVSSBTP0SRArhjyaXqa0pT6K?=
 =?us-ascii?Q?CM+Uk0HD7wNmotgR5BVLJcvF4/rCTIDBXKvCU5sDhI0+oI7CwPdUDDhjFusR?=
 =?us-ascii?Q?02UMBXmGMQ3XPQ02Xdil0hxB0/CytAmGHvDGhHJVgPuwavtPXhdYKaeNakQG?=
 =?us-ascii?Q?Td42KHomS2PJa1g+PeDnI0fHuMp1I2JUFaiwgzKdoDGqfI8wy0qWIe7Oj5OY?=
 =?us-ascii?Q?kUxRjwdZBXlrMYiDYAnnaAYbl19rjQxw2yMLI1XBvvCjAeAQWC0zxyGZTZvU?=
 =?us-ascii?Q?0k1YQxuLX5NP4ovwcBcP43TozY0e7levL8egck63BTGgMreqW0uYctgnMGBd?=
 =?us-ascii?Q?cElOI0NA0gOvabu0KESTT8tCH7lYLDdz040O9rdp/Nu4UV9wFHu5rnlUsmJ7?=
 =?us-ascii?Q?8LCSNH6705VstFtjxaPMwLo51l1LKPSEjpioDxr8MqTmF4WocQ6haqtkywUQ?=
 =?us-ascii?Q?eWHdBoViOwkU2Zr0SHAPonBfYmGTJ7RbNLqUrHWG9wNUqk49ezhuT10ZiOwC?=
 =?us-ascii?Q?fIVxU/5csUZvB4qB7+/2L3Q68ayuZbs4C16KPn7xdz7qLfCqhpFdCcfKNZOh?=
 =?us-ascii?Q?G7i2USO+glXE9Wyn9GWbTT4gwWAtnBqGTsvQXuHQbrXXWnDNHN8HAgwCk+n+?=
 =?us-ascii?Q?B3dAwDFdbl+ayfidsbaqedkWAd6aa6CmfJA61x9TAvOxNuLHDRKUn/Zu039E?=
 =?us-ascii?Q?/0TTc65QYnMQw8DeouHXs44ukv6m8ZU0uPwOCJGdjlAq6CWSN/karFUKMD6h?=
 =?us-ascii?Q?qyAMRyKevD8XESUw3vIQxwKdbnX8CgQFJgRqEsiJ99YCfsXhFaYRxjNSDrL5?=
 =?us-ascii?Q?qSs/NazyP/8uTeUVBsfl+EmDXsq9wE7nRh5opPAF8F1vjUzqw+q1COQhqcg0?=
 =?us-ascii?Q?tEmj7CALPg=3D=3D?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4da2555e-d69a-40e3-f43a-08da240d2e71
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2022 03:07:05.8116 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lJg//+JRI3f1JnHofMo7cqgCu9CSmtQJgpyS9S7OErcDuX1FBtmJkI2/2tZHI0SWd5pZsWmjNMWWQoPxaxlinA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5544
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

> From: Lu Baolu
> Sent: Thursday, April 21, 2022 7:36 PM
> 
> PRQ overflow may cause I/O throughput congestion, resulting in unnecessary
> degradation of I/O performance. Appropriately increasing the length of PRQ
> can greatly reduce the occurrence of PRQ overflow. The count of maximum
> page requests that can be generated in parallel by a PCIe device is
> statically defined in the Outstanding Page Request Capacity field of the
> PCIe ATS configure space.
> 
> The new length of PRQ is calculated by summing up the value of Outstanding
> Page Request Capacity register across all devices where Page Requests are
> supported on the real PR-capable platform (Intel Sapphire Rapids). The
> result is round to the nearest higher power of 2.
> 
> The PRQ length is also double sized as the VT-d IOMMU driver only updates
> the Page Request Queue Head Register (PQH_REG) after processing the
> entire
> queue.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

> ---
>  include/linux/intel-svm.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/intel-svm.h b/include/linux/intel-svm.h
> index b3b125b332aa..207ef06ba3e1 100644
> --- a/include/linux/intel-svm.h
> +++ b/include/linux/intel-svm.h
> @@ -9,7 +9,7 @@
>  #define __INTEL_SVM_H__
> 
>  /* Page Request Queue depth */
> -#define PRQ_ORDER	2
> +#define PRQ_ORDER	4
>  #define PRQ_RING_MASK	((0x1000 << PRQ_ORDER) - 0x20)
>  #define PRQ_DEPTH	((0x1000 << PRQ_ORDER) >> 5)
> 
> --
> 2.25.1
> 
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
