Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88BFFC43217
	for <iommu@archiver.kernel.org>; Wed,  6 Apr 2022 01:00:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1539081463;
	Wed,  6 Apr 2022 01:00:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2Joj2bYlHM0U; Wed,  6 Apr 2022 01:00:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id EB34B81451;
	Wed,  6 Apr 2022 01:00:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B2DAFC001D;
	Wed,  6 Apr 2022 01:00:20 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EB3B8C0012
 for <iommu@lists.linux-foundation.org>; Wed,  6 Apr 2022 01:00:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C32B7610A7
 for <iommu@lists.linux-foundation.org>; Wed,  6 Apr 2022 01:00:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YohltKvfSdf6 for <iommu@lists.linux-foundation.org>;
 Wed,  6 Apr 2022 01:00:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8E559610A4
 for <iommu@lists.linux-foundation.org>; Wed,  6 Apr 2022 01:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1649206817; x=1680742817;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=HMcXFbqRaqV8cIIpNTOE//SpWhqgEgc+X7ifraCFhzI=;
 b=O0KWP0d0FINuZjxJmyastZ4gowRfxbeAA5OsDEeMSgU/+4hQtKPGSy2X
 khKYkGrw3JRYkx9IFEruzgppBGMKbS5U7cRvVLMay/MCktCwrt/3EtSm5
 goimRMPnzEMic7jW2WgAmDTPdrJNYW500JDlcYhzSR90UsYspeILVfCSS
 BujLFPbAvMEQy0qiPdquFVn78yxXVYTVwxpSqdcL/WcLt8I5tYYeEeCJF
 KWuj+BqWHXy8zohyg2UOEhebd5EKExx5iMyQdq7Iwq5VKDF41esnbFJhn
 NNU7LB1bUiZ2uhMTxfZ8o0pZ4+tt/dZgVnSVnIyEnnv+M2ZDsFvs20GHd Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10308"; a="258497122"
X-IronPort-AV: E=Sophos;i="5.90,238,1643702400"; d="scan'208";a="258497122"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Apr 2022 18:00:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,238,1643702400"; d="scan'208";a="570252569"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by orsmga008.jf.intel.com with ESMTP; 05 Apr 2022 18:00:16 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 5 Apr 2022 18:00:15 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Tue, 5 Apr 2022 18:00:15 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.109)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Tue, 5 Apr 2022 18:00:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k8osDL57J1PBf41Y45te2/wQ7q4wEH/DlaiSYc13YbZ3XImhSfVWB3qcKuQFFhQsJVtK3WLYeh6EpVYfovt8VCZj3NTclMFUU1onwFkBdlXxATXR7gryhS91FewSA4mJtc9d9BfAXitgPz6GSliY9BybLPSWC1kDoTFtiZZOKpvCtbgaEnwLIgKBwGnJTC2Lgau02r6+hPLYD9YKHqbaC/eL/h9fMHWyFKOc3mXHrc8/cUH177dObucE0zhGvOfhjKFSmX4vA9nKzJ8hkjkDLTfe/BHaDEYczYARHEJ9ZsJCyIb/QFhIKCPx1AwykHQNjMQRS7rAt1vueREfvMb/7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HMcXFbqRaqV8cIIpNTOE//SpWhqgEgc+X7ifraCFhzI=;
 b=AEEmJOwi7W300KInoNWEWgCCPSQten2tWyUKWET2iMlJ87BO6vGmqjE8B6o4ruOs4+yQB3Qr0h6VThRsG3yQa9O7wzk2KIlPRMx+gDYZ0lVTOTWGnRJbj1XB7Qs0eU92bZ3YLBlo/DgalkI7AQZQtALg3VMOZckgVYoUrPQKvojPsSFkp1T3eGt8aRpjPF1pLSPSiPRzy5ziwgZiKwAxlZ6VMmhT0X/jHweocSrEc3gqL0ITSAsArTL89Pw5RDPNJn842YqEzLEd3XF3Z8qOMnLcTpu8h5CPLN3QKtB8sjBfETDGyrIlXALMq25/s/SnS978X80laCIjNb15o5sX/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by BYAPR11MB3286.namprd11.prod.outlook.com (2603:10b6:a03:79::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Wed, 6 Apr
 2022 01:00:13 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::c4ea:a404:b70b:e54e]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::c4ea:a404:b70b:e54e%7]) with mapi id 15.20.5123.031; Wed, 6 Apr 2022
 01:00:13 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: RE: [PATCH RFC v2 03/11] iommu/sva: Add iommu_domain type for SVA
Thread-Topic: [PATCH RFC v2 03/11] iommu/sva: Add iommu_domain type for SVA
Thread-Index: AQHYQy+FIia0eWaSv0yH5HJtvKyQTazYSueAgAQE+8CAAP1+AIAEzMlA
Date: Wed, 6 Apr 2022 01:00:13 +0000
Message-ID: <BN9PR11MB527660D99D154F922B0A628B8CE79@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220329053800.3049561-1-baolu.lu@linux.intel.com>
 <20220329053800.3049561-4-baolu.lu@linux.intel.com>
 <20220330190201.GB2120790@nvidia.com>
 <BN9PR11MB5276A39F481E2E31B0FCFEAE8CE39@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20220402233210.GM2120790@nvidia.com>
In-Reply-To: <20220402233210.GM2120790@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0445bdc1-4e38-4eb5-00b4-08da1768cea5
x-ms-traffictypediagnostic: BYAPR11MB3286:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <BYAPR11MB3286721CFF0809F1EA6D6E038CE79@BYAPR11MB3286.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: S0F4KMt6vXFNSv+DM5MKq06K4QAQ9MOJWfUEuccy1vZ12uYUDB66JaPnTSHdTeEXHARD1Wc3HWOBoyQZCf6PemeVqzW8V2DuhtXIFmwslYkRUgrCQ3rNI/Ov8lRli7cmX7GZwV9d255iaEWllu6kNySRQvu9Y0S6CckK1tO2/UsQpL9x4CN/NkJFRqlcvKjrmLCBTt9ML6W8WtZFnEoCBJf/TxQpSRs5iCyuT2RJQnXyCu+Ji4WD3zRHDsAZzA9ebtulzLpbdzHxGLrVdsrBb5QuM0aQHzHKOPk+htsdNsLm4x5E4M8vyUcnzGN6VMeW/oZ8USTIxiYf+jrtgz6RMizQKEZRnsOaZbph6aI+Eyy3u9fIOwWZMW+J97Q3h7uxVXgndjRVMZHT29F0QQAgpI2WHsVrL2d9kj+/IEg0bktj7GP8G1qPtX5/5U6yqnQitz6DGwFsuRPX6fY0ch0ObGxVgWSTrOKckIYfQOjycearBy+1LsWziQEfthLObgCyqD2Vl34dPRMFJBkZkEEWQaNOSxEs15Og2Dxy4XHvoiqzDuhf42vDT1oZVOVgoZd6bl9Z2R41NPDVhezGiWQgrYptV9cFlkttk+/PJGinQ8eOFtymB8RrfFMPH6EZaI/A47aH+oEjXcizGq98dHXp8V1RiCfUDzf7G7EbU3lhgGgIgn0foFXoGutlMF5uxvVHygTM1dbivzew2maflLxEdw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR11MB5276.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(366004)(84040400005)(26005)(54906003)(52536014)(33656002)(66556008)(122000001)(38100700002)(66446008)(55016003)(4326008)(8676002)(6916009)(76116006)(38070700005)(66476007)(83380400001)(2906002)(316002)(186003)(66946007)(64756008)(6506007)(82960400001)(508600001)(7416002)(71200400001)(7696005)(9686003)(86362001)(5660300002)(8936002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6rssYxJDj6PTdJGyuCdR1sqY4Sju1bXViNIqJZA/RXplaDkP7WRU4mwNAjk+?=
 =?us-ascii?Q?A5mkzKBbQxraRjHLyoBcojx7a4Dc4nnX+fsiKocIWyPjCLSHYPfmMzM7t2Di?=
 =?us-ascii?Q?srwo/qt8VnfPLbKf+veizJXVoQqyiNEFKsfRIBXedB4pH970UdAv/kfOmA6u?=
 =?us-ascii?Q?xnnpW+UBr1LrCD3oYoolXGx65Jt6IXDvF46vOKCpXN/9ZyANGQX3hYrKrHDr?=
 =?us-ascii?Q?I+bu2ArtTn3OyFDv4Afk3omxRz66aHCwCNr+0W9irrZOkKbDDeLSmpwffpyD?=
 =?us-ascii?Q?58hPGyB2z1iPUfm0KLY/uH7+NPP1BMNjevmyuQGaeQi0f/rDEV5WKW9TnuRq?=
 =?us-ascii?Q?R/TcTo2+QBHu7iBMUTAL2Y1tWJiCJJu3+ZR8YZ8gbvAT+YCvkcEiZSsidipC?=
 =?us-ascii?Q?Z1cZ6ROju8k9nAeWAsVbJILqLZFg8wV+iyzwKyGam7SmuM8Ea5n/K96t77Oq?=
 =?us-ascii?Q?FJOr2nUvQmZDSFWxeYA/RvyJvRE2e+ALWZrpCdOD299WGXpKOZBjHNYgHfQ6?=
 =?us-ascii?Q?AQRCe4TE8VYWb+Nw0UkQ+xQt1DhluvRdyL+rpcjPEyGI1CsR+LL4wjZaUtXa?=
 =?us-ascii?Q?v9X63Ba0h2Jg0yY0FMKeTX81mDmNwUWOSdEbAc4Q/pEAgHlj1VKRxylM4QEK?=
 =?us-ascii?Q?ghZ9aJpOi2I/oMF3TyhlbGMQ7RRrPVWxrcoQVuQJ5yMj7omoPuowgZ+Mpg7G?=
 =?us-ascii?Q?RGvfeJ3k6+yrWpsuQwhLIvNrd+mPbnv2uHjNuuVO9t7LcY3zqvuTPhTnY03R?=
 =?us-ascii?Q?PfsqB58u7ZP6pZZvlh5BciB93sVz8Lr8SWakjSX+dWHUwcCk6SlQQ4F8B/Q4?=
 =?us-ascii?Q?H/n2YcV0Q1EcSGiKJzRJT58IutkNtVaPkQvdxqGM1i9IvvUalVjKqXPEIk6R?=
 =?us-ascii?Q?HKvrPqteCiWhMDdDons4rlrKXkEtpjB3iawd4IyKqr5RX3mhAnmtWE+bf7OJ?=
 =?us-ascii?Q?qtab57NjBhqraWRdTHaasYDb80e+CNWP1WhGXnDPqVLa+7vxeD5pbUS4j3Q9?=
 =?us-ascii?Q?nGFMBlKplJe/3+SAHHPFgPkWSOeVb8rmmhmb7oOi8GzKYMIrJdDlZiYdnfSA?=
 =?us-ascii?Q?1XDjZoAWlWwEnMqALaPcXTmUF+EZplMATDiEpIMnzn4TB7wIIoejYY9C0oCM?=
 =?us-ascii?Q?hccaX1TKtbRL1qihaHkkahaEP2fQTRtgnEyb3ntery+/IGkryDF/fEbSyzrO?=
 =?us-ascii?Q?UWIAzN3OYkpojc5sAZrz2yqguBaQ1TDKPMuL++j3hpYXwGpi5YirPuFlp6I5?=
 =?us-ascii?Q?eOIMGGYB5NKHr6Px0LojFX/KRb3fpKpYgLX7vVGjTFyZnHqo3xSGHD+ldsGE?=
 =?us-ascii?Q?avQIbeXA5APqoh8Mvs1mCO7l3LP/O6/7SPS2t2VETRqM2rONomQu1iNhqHwN?=
 =?us-ascii?Q?CIMoqt1U5Wgu38CuwhHwXKsLkjSrMnGTho12hjjK8KaGff26UvMfU2V63gP8?=
 =?us-ascii?Q?GFxJWA/cy0dCVbfT8gNEPK8wmMfQW2N52W5iuBNQ7gR84BlzxvBT6T/dTS8U?=
 =?us-ascii?Q?7vBFGYrPV5xZA5xWsRSwSuQqUKndH8G+VOftwZFiUs51J1q1m2Hf5RxX8brp?=
 =?us-ascii?Q?HykWPjotH8J5yD8mxI9JXaQK3W6z4MvBDjpIMvUA9iQZKsCStINnxZLnH3vd?=
 =?us-ascii?Q?R5jiHLel6cgx1a/XjSlPSsl2rtEKndc7VPmjybnre3D93GF9N0vYrVst7Hu8?=
 =?us-ascii?Q?FrN1HxCt5BM9IFGOqBEjlSPzoZKg/fbgHQyjbo4gPmCKKO2C1oMbpni2On8r?=
 =?us-ascii?Q?ViTvDMyH8Q=3D=3D?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0445bdc1-4e38-4eb5-00b4-08da1768cea5
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2022 01:00:13.6835 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PPKnfqWD2sEt0vBrpkVgo4OffuI7lWCDdBwOQdEfyqRtdPguAQ/viOvaIQGLl7OKh4H552IaDTG32+xgQx62/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3286
X-OriginatorOrg: intel.com
Cc: "Raj, Ashok" <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Christoph Hellwig <hch@infradead.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
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

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Sunday, April 3, 2022 7:32 AM
> 
> On Sat, Apr 02, 2022 at 08:43:16AM +0000, Tian, Kevin wrote:
> 
> > > This assumes any domain is interchangeable with any device, which is
> > > not the iommu model. We need a domain op to check if a device is
> > > compatiable with the domain for vfio an iommufd, this should do the
> > > same.
> >
> > This suggests that mm_struct needs to include the format information
> > of the CPU page table so the format can be checked by the domain op?
> 
> No, Linux does not support multiple formats for CPU page tables,
> AFAICT, and creating the SVA domain in the first place should check
> this.

One interesting usage is when virtio-iommu supports vSVA one day. At
that time there needs a way to know the format of the CPU page table
and then virtio-iommu driver needs to check whether it is compatible
with what the host iommu driver supports. But possibly this can wait to
be solved until that usage comes...

> 
> > > It means each mm can have a list of domains associated with it and a
> > > new domain is auto-created if the device doesn't work with any of the
> > > existing domains.
> >
> > mm has only one page table and one format. If a device is incompatible
> > with an existing domain wrapping that page table, how come creating
> > another domain could make it compatible?
> 
> Because domains wrap more than just the IOPTE format, they have
> additional data related to the IOMMU HW block itself. Imagine a SOC
> with two IOMMU HW blocks that can both process the CPU IOPTE format,
> but have different configuration.

Curious. Is it hypothesis or real? If real can you help give a concrete
example?

> 
> So if device A users IOMMU A it needs an iommu_domain from driver A and
> same for another device B, even if both iommu_domains are thin
> wrappers around the same mm_struct.
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
