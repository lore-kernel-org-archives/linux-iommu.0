Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E76DDC43334
	for <iommu@archiver.kernel.org>; Fri, 17 Jun 2022 07:44:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8513141BE0;
	Fri, 17 Jun 2022 07:44:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8513141BE0
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=TyUpnJKr
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PbqUB8TY1IPk; Fri, 17 Jun 2022 07:44:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 5BBC741C24;
	Fri, 17 Jun 2022 07:44:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5BBC741C24
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0FD47C0039;
	Fri, 17 Jun 2022 07:44:08 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9AB4EC002D
 for <iommu@lists.linux-foundation.org>; Fri, 17 Jun 2022 07:44:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 79D83844CC
 for <iommu@lists.linux-foundation.org>; Fri, 17 Jun 2022 07:44:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 79D83844CC
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=TyUpnJKr
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IQwMb5XGgXxb for <iommu@lists.linux-foundation.org>;
 Fri, 17 Jun 2022 07:44:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 93B5A844B4
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 93B5A844B4
 for <iommu@lists.linux-foundation.org>; Fri, 17 Jun 2022 07:44:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1655451845; x=1686987845;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=pi5rNEUy+nakUFCYbibdatdBn8jOsJDlGf6bewAQzno=;
 b=TyUpnJKrHsunwNz1a+A8gL8E+Jcq1F/bhs2tnr3CiWxY/iPDEQJNwrP5
 GJPNR9y2Hdo6PY7OzlQcIuHqHt1nGyXeW2KYMlQhYPVQp22cuz3IYC4bd
 yjVX+n1KDaNjbGk+kf1n+yIBsZqGJx4esUVxhWn5JRjuB3AJbuc7AMZsT
 CP3lEoleiAddKFrqEcH3ymRz7g7PsUHm/lFMGJMODciiyjL28Pgp4RRxU
 ERMxumXR9nN8WOWjO4YWAJNkT063KOvQFa7DdNBLoyOEP8LIvZonB6jZo
 SbjoIFfkkATUnMHmv5iyL+Q5+ANlOR5u9IMtWnEsE48/AmpiYhn84OqlX w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="279503979"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; d="scan'208";a="279503979"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jun 2022 00:43:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; d="scan'208";a="653526267"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
 by fmsmga004.fm.intel.com with ESMTP; 17 Jun 2022 00:43:49 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 17 Jun 2022 00:43:48 -0700
Received: from orsmsx606.amr.corp.intel.com (10.22.229.19) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 17 Jun 2022 00:43:48 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Fri, 17 Jun 2022 00:43:48 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Fri, 17 Jun 2022 00:43:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J0alheK3+U6jtrexXWIGrpEbSgKj63sNHbL70chXNNUTzidvDgzlvHliO185DkfvjZFAlTx76C3RJaNoGi2mCp3+j54LmYgNyVBUn31EbvmloXX8KKnpi0inz2d0cEut+J2bRcnMm6npvukh5qSzzcr1RomIrHCSbvtjec2qtYPFyKYFs0Gyh1BOCSXWVBo1rFhQSP0G9RbqFTQdLdU69vXpz1kS2lk5VerH0wPnKXe4PQlLxUXBlKHnJSqVpAwRx6Dljab4pYj9wz5HfhkDqB2lTAvsIOZsVuiLpMJcfP0kGmVZuDPyZdTv4pyBs2x72nq1qJyOLyvlLXCL/o2zag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yEFyahhiGlwYWh/+Ly4aS6Q1ldSiKrzOk2dp2AHJZKc=;
 b=GMp1VfN7clC56Qlb7nZGkUI8Ldk+a2Z2Xmn3cYN/nYlZ8kOWsDPXfSP71plGkGGMe76vfS8GHyCgdWzt5gUzhPPyDClTgkLk/lObCCZQQlrf4Pr4TG3uwE8CNjB0dfhIFhd8gpxEE+UyV/YWyfnOZ/lEbN8Uk/yFJcooOmRLdGHX42JnzD/+HPmFDOu5L4sla4hUI3gwPtZTK+z+kyWDPO4P/hwy6NGRJoR89LB1prQO4l0lZd4yMiJH6Tcw9qtUfa2zTzrE4/rSvIHqwpu2dfJPZSN/HvScp3V+b+X7Hsg9mpIhMGx4CX9ZQrqBtoIc9CWxn2i9ZHMkd6tt06ht0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DM5PR11MB1771.namprd11.prod.outlook.com (2603:10b6:3:113::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.15; Fri, 17 Jun
 2022 07:43:41 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::8435:5a99:1e28:b38c]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::8435:5a99:1e28:b38c%2]) with mapi id 15.20.5353.016; Fri, 17 Jun 2022
 07:43:41 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Baolu Lu <baolu.lu@linux.intel.com>, "Raj, Ashok" <ashok.raj@intel.com>
Subject: RE: [PATCH v8 04/11] iommu: Add sva iommu_domain support
Thread-Topic: [PATCH v8 04/11] iommu: Add sva iommu_domain support
Thread-Index: AQHYehFzBYF+zsEoHkOtBqUHcYMQtK1HiggAgAC1yQCACwTnIA==
Date: Fri, 17 Jun 2022 07:43:40 +0000
Message-ID: <BN9PR11MB52765DEC46616F67185B1F1F8CAF9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220607014942.3954894-1-baolu.lu@linux.intel.com>
 <20220607014942.3954894-5-baolu.lu@linux.intel.com>
 <20220609202540.GD33363@araj-dh-work>
 <a78c5bd0-a9f2-2a6d-3099-8d03c123fa93@linux.intel.com>
In-Reply-To: <a78c5bd0-a9f2-2a6d-3099-8d03c123fa93@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 470ef0c9-449f-4314-f04a-08da50351913
x-ms-traffictypediagnostic: DM5PR11MB1771:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <DM5PR11MB1771D3C8EC5BC9D8A54F542E8CAF9@DM5PR11MB1771.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +ZzuRJ+9yIQfaaJlm+sXrJvaUB6cSAJIV4LxgT8EpLEZ/9o52/m8XKP4LE3F1K9+zqKTo87zgZF3/WklIboQ1kotVe9h6ZAujc5RhsEbwDpmsQ4HIRkpUmdb8LGCMQbSsH9ix/ubXyyIoRsSUfTBjK/9/NJzXK+rDsQ2rHf9zn20z8Yp8JmOzATqZskEkr5pWhVe50UKIVbafHntOj2ETuGCl2FXy+5W6rVlAVQMtZHTuMRMjlHreQalXuPdul4IXaTymZHUXeg2M092R9kJtl2IzKUsBjt75QAO2eNWSi1G6GxyX4QaUQ2i+IL7/jgKZiOhDV5TshVRWmzNIbaaRcZIq/S+7NfsI9iBXa2/YI1Nnr3rwSVAp54p9wPqeSBDUY9V7MkLTot1wyUnd1j2PTJklOirVNzsEI7c+mh7Vf8HbeMSmphOvEZN33b8z0CW/Wm6GRHgf615r0WOex+jqRtIC/GsrMxIaKvjQ0vgOf6kmCDPp2qCM4yboW99ojtEZWSVet2Cs4hSk9rsauRpIimBF/0N1AqaTxP0s4UGGz5zQsmqWAV/neBM7IeD0WVSWsEOxMMvBAM2R68vXkvHACLRrNg3q3j/2G+DtXlx+zeWi167IAlYnjCXzS+VSdcLk86779e5XmvugX+NEz6nzkP8NRdrNDBlsRKBxKpUltSnedaQn2pNBYyVGjK1njTMj4eGFoaXgW0aCVcpUPp9Qg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR11MB5276.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(366004)(26005)(5660300002)(2906002)(8936002)(86362001)(7416002)(9686003)(6506007)(7696005)(52536014)(6636002)(110136005)(316002)(54906003)(498600001)(71200400001)(38100700002)(122000001)(38070700005)(66446008)(82960400001)(76116006)(66946007)(66556008)(64756008)(186003)(8676002)(4326008)(66476007)(33656002)(55016003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Ba+uM59p+cMna58ZCdinlKVZL/GZH+798LACiidWJXpf3wam4M8OV4noKzJu?=
 =?us-ascii?Q?II7O4SRpYoJlPeAR8QdjOsmvDiijP78jkEiBSih1uHooATtYL4ghwhab8Nyi?=
 =?us-ascii?Q?Qft4kxkH+iDcndDLL/QKV2XC602YkKF05wAwnLi7sZ8cDGhzMxrX77QRr/w4?=
 =?us-ascii?Q?dyd9wHMo3vq6cZGHzA/7zV7b0qRylr+apJbnfsLkxLbOMPDq3ZkE+Adn/jaH?=
 =?us-ascii?Q?ndrsYaG0SIMTOiq7X/eAaG+vS5TQ8xewT55amfazCkt/uaMAuzkAYe7ra96H?=
 =?us-ascii?Q?6oZvK4SIZChtCRLkwpf+hr8RamUzL1WUrof69hz76CX26mMWz2gzhXUqHYmX?=
 =?us-ascii?Q?OFAkGf0OoRp4HxRCP25HzRBo646kzx9PeBtQkRD4/rz1vpUi9CyoX5lFtMMs?=
 =?us-ascii?Q?fyOpdPcc11EgcD+B6xyL7cWtxVYaOM9cb7nMDbBQs0A6MFPQfnFkFzp7+9s+?=
 =?us-ascii?Q?cpx+eP45JGr8b6vvjhZ/t3o8sKhx8HFDEBDEmXKSPrPztbFjD63dCIBRBTVb?=
 =?us-ascii?Q?2QjAcM4+jMUEJVjzDtoSbsMBpgNpd97ospcJ2of8ybmjNvt2rnklK6405vyE?=
 =?us-ascii?Q?QIF/B60esbTOadJYbtrHV2PthIWNxkfcL1zJd17SgrFbGiP1yOxMKeX7fR5N?=
 =?us-ascii?Q?29ri9OMAHeedSlI7yhHbP1WfazWwsjphLSjKjSxOKny3wL4hD3AlvEA1GBdJ?=
 =?us-ascii?Q?DISNRZVDfw/6QT7rB9VC3yKwgVp0ZO75s4SDOTQdBxyZDXkPeCrok+5pFXRA?=
 =?us-ascii?Q?SM4p/67FD65OU7WMpcgzNqk5w9w3z/UcRj0V82sIzEJhFe+wBZSP0AvcePLh?=
 =?us-ascii?Q?RXiDtXWVsKkqzN9KsikOjjAzmhOGvZ9vo4x3PSaOYEI2miprhilPfE/wX5md?=
 =?us-ascii?Q?QzX+Tf3FF1gEm2GwsL68DiTT6nsUGlKCqyH7mUD9rneqL/C98weJfHYbkrXa?=
 =?us-ascii?Q?8hW6FY5WaKN9WjiM18HduCRuRxiH2M8JYqAdXrzNP8ivYFx5aR4zQcFZoxJ9?=
 =?us-ascii?Q?rjH6XW5Nn30QTtyg+7h3Ftl2GrkPUQLFQWlRC4HjRjcxpsj4KaCCndxyWQQd?=
 =?us-ascii?Q?kMIrDfY2JEEJfWeutXdaDR1CFAh9aNtXxUhDXhqROan9Ibe1FuRkkBiYc+rT?=
 =?us-ascii?Q?/reA7eKMy80KYje3pG+nbMc45WIyYaz620/k1dR9FSosqG8g+f2/wGq+/1cG?=
 =?us-ascii?Q?RwTVCREVaRBwnkLCBYC5JW3kWOEJmxT4ww/gZW4157exQ2bZ9EvKHyKsuX5G?=
 =?us-ascii?Q?Za85v7nnL2saWr74qKiyz0BQiEr3RiwQbZeW8pxsLuR8vOwrAYjMgLDl7nJG?=
 =?us-ascii?Q?lZA06QrpzIjOSfgJSfFPcQ8R756nZh6I9VSyT+eMdIQwT1XJX7kkBhPYJ6Bo?=
 =?us-ascii?Q?wAUWPe3VWAFHg2zEpkltOpVZ0xoT3XlNPDmizhAEH3kgUva1B+73cKg+h9CO?=
 =?us-ascii?Q?m7+263fSa7TeFTv46+z5SX35dbI9oOzhl6gyLTya8FT2+KWOAHTitdWCOgad?=
 =?us-ascii?Q?l+cE02nFtn1ZJr/5ypnHWQFirveLC4gRLIcekiYhdMr+FVx1WQFd4xSR6ag0?=
 =?us-ascii?Q?EXe9eEZcnQQTj5gMWqiJIkLBYP7YERPOLWhRpnQ3GT+8JG7QsfxD74NFHZYv?=
 =?us-ascii?Q?6vhuUojFJeXFeQuvt4kdj6bgPKzhmdN1Dffj8j3zTJPCZ/3gwrNCbEB5NR2N?=
 =?us-ascii?Q?OGshnaM5zUOxAGm/CDWvuhlmarmQwztMna6YUvNV77F6E1QOkC3aq4kwlXO1?=
 =?us-ascii?Q?q3nMlEiCXw=3D=3D?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 470ef0c9-449f-4314-f04a-08da50351913
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2022 07:43:40.9947 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ipx+R3OKu3lY10GkX/7WzEFFRDtZWM+4N21mCe9Xe3muPz22jcy5lgaZindvnuzk+Uh7gwe/ibd3R3sFtJRiLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1771
X-OriginatorOrg: intel.com
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, "Jiang,
 Dave" <dave.jiang@intel.com>, Will Deacon <will@kernel.org>,
 Vinod Koul <vkoul@kernel.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Christoph
 Hellwig <hch@infradead.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Pan,
 Jacob jun" <jacob.jun.pan@intel.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Robin Murphy <robin.murphy@arm.com>
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

> From: Baolu Lu
> Sent: Friday, June 10, 2022 3:16 PM
> >
> >> +#define __IOMMU_DOMAIN_HOST_VA	(1U << 5)  /* Host CPU virtual
> address */
> >
> > Do you mean general CPU VA? or Host CPU VA, I'm reading the latter as
> 2nd
> > stage?
> 
> Host CPU VA. In the near future, we will add another flag _GUEST_VA, so
> that the shared page table types are distiguished.

How does the kernel knows that an user page table translates guest VA?
IMHO I don't think the kernel should care about it except managing
all the aspects related to the user page table itself...

> 
> >
> >> +
> >>   /*
> >>    * This are the possible domain-types
> >>    *
> >> @@ -86,15 +89,24 @@ struct iommu_domain_geometry {
> >>   #define IOMMU_DOMAIN_DMA_FQ
> 	(__IOMMU_DOMAIN_PAGING |	\
> >>   				 __IOMMU_DOMAIN_DMA_API |	\
> >>   				 __IOMMU_DOMAIN_DMA_FQ)
> >> +#define IOMMU_DOMAIN_SVA	(__IOMMU_DOMAIN_SHARED |
> 	\
> >> +				 __IOMMU_DOMAIN_HOST_VA)
> >
> > Doesn't shared automatically mean CPU VA? Do we need another flag?
> 
> Yes. Shared means CPU VA, but there're many types. Besides above two, we
> also see the shared KVM/EPT.
> 

Will the two sharing scenarios share any common code? If not then
having a separate flag bit is meaningless.

It might be more straightforward to be:

#define IOMMU_DOMAIN_SVA	__IOMMU_DOMAIN_SVA
#define IOMMU_DOMAIN_KVM __IOMMU_DOMAIN_KVM
#define IOMMU_DOMAIN_USER __IOMMU_DOMAIN_USER

Thanks
Kevin
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
