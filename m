Return-Path: <SRS0=Xpq5=OT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D897C4332F
	for <iommu@archiver.kernel.org>; Wed, 29 Sep 2021 10:44:14 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD9DA61407
	for <iommu@archiver.kernel.org>; Wed, 29 Sep 2021 10:44:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BD9DA61407
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8159F4013B;
	Wed, 29 Sep 2021 10:44:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0k2DKxTo3VHP; Wed, 29 Sep 2021 10:44:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 1813340012;
	Wed, 29 Sep 2021 10:44:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C725DC000F;
	Wed, 29 Sep 2021 10:44:11 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 99E0FC000D
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 10:44:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7B4A2407F5
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 10:44:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qLd7zeCJMezT for <iommu@lists.linux-foundation.org>;
 Wed, 29 Sep 2021 10:44:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A5951407F2
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 10:44:09 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10121"; a="310461873"
X-IronPort-AV: E=Sophos;i="5.85,332,1624345200"; d="scan'208";a="310461873"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Sep 2021 03:44:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,332,1624345200"; d="scan'208";a="707219678"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
 by fmsmga006.fm.intel.com with ESMTP; 29 Sep 2021 03:44:09 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Wed, 29 Sep 2021 03:44:08 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Wed, 29 Sep 2021 03:44:08 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.46) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Wed, 29 Sep 2021 03:44:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZptbE6dgdTP4DjjTEHOQW2/ZqAnHR2To09RrEFRVCf0p2qedW+AOrz25hsssPSBDsZuu1owwGbrzSuXwwBVj5AFhLv0udqTgo3Vsb2vuP2kEveDEu8qCGWSS5zE/fYuKjJLFAy5D89DPpHxgQO2oFBE6is7nq7msHOOcS+2XN8nKpZiWCRPxm/QlslQjibzl1jgfs04w252c0WAjyQtrCWy4LrPNufzDqq2ydpcwJauTFF8hjnydRlqJWQA+6lndHD5vCFO1V53IdjswDiMRrioLxyDQ3QIsIXXAnfgHNgdsrsH4IqIOVh6w2rDo9zTfjZkgWkEUOrWmKPqwbAKrEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=iKa3zSj2daSrMfuIsNnEgUxVpq73ZWJt3l2s13oJQr4=;
 b=hoku1M2m4DvPL1pW0g3B2Dfd7XD4kDeCR2+q963Kadzf2GogcbaNuG8m/XztZNF2pw3YkUWlPIdcw2nCBjbo4wSNnPJb9DWNbHj2BPlj8K+6HgaK5VpfXEs3EVfi85AmzrJcgPfEpaNsRN0C/XKrmb3uNfD+awq14RSaoSa5+2yvYPQzUtuDn8A23Fgn0YdFxMBWHrx1Jk6DMBL3v0XLDjZHs8GaNcvKvw4K0BMEXJKMqOrjo4d/GR2JVievL+Zai/YOdr16XbzpRxbJDukAkI6QrwXHFU6ex7GeD+CJBjiIezu30D3ZNZxnnlW0duW8MIzzxCApURXnqOPU4ctdbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iKa3zSj2daSrMfuIsNnEgUxVpq73ZWJt3l2s13oJQr4=;
 b=PGz+ep/7kWth9bX0HJPHQmL5wjVBWzOafNF1wPdbx0WkR1J02q5dnx/zuf5ZAfY00joBXHdJQTSSVDSdPfCIb0Zq3PvMENTW6kT22uFzmGw7YkQ4jdMepPcxnrKCPl7lJYTuZ50cHij3YrU438qhLQDJND68mmQSxZp3vZkzZKQ=
Received: from PH0PR11MB5658.namprd11.prod.outlook.com (2603:10b6:510:e2::23)
 by PH0PR11MB5643.namprd11.prod.outlook.com (2603:10b6:510:d5::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14; Wed, 29 Sep
 2021 10:44:01 +0000
Received: from PH0PR11MB5658.namprd11.prod.outlook.com
 ([fe80::5009:9c8c:4cb4:e119]) by PH0PR11MB5658.namprd11.prod.outlook.com
 ([fe80::5009:9c8c:4cb4:e119%6]) with mapi id 15.20.4544.021; Wed, 29 Sep 2021
 10:44:01 +0000
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: RE: [RFC 17/20] iommu/iommufd: Report iova range to userspace
Thread-Topic: [RFC 17/20] iommu/iommufd: Report iova range to userspace
Thread-Index: AQHXrSGpfnufovxqLESc6zzFg8xwc6uwJ7eAgAq5dCA=
Date: Wed, 29 Sep 2021 10:44:01 +0000
Message-ID: <PH0PR11MB56580CB47CA2CF17C86CD0D0C3A99@PH0PR11MB5658.namprd11.prod.outlook.com>
References: <20210919063848.1476776-1-yi.l.liu@intel.com>
 <20210919063848.1476776-18-yi.l.liu@intel.com> <YUtCYZI3oQcwKrUh@myrica>
In-Reply-To: <YUtCYZI3oQcwKrUh@myrica>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.6.200.16
dlp-product: dlpe-windows
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9caa162b-cd3f-4a13-f477-08d983360c9e
x-ms-traffictypediagnostic: PH0PR11MB5643:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR11MB564378EC8C958811A4B5EE97C3A99@PH0PR11MB5643.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7ccelcu2iNXmcwisFIdXQDH+p/Q2fZ8pue3tTXHvUyrpbjZQgs//MgfGeMw1C9ytvv2WOnQSHnbShkunobULl+23zUJ6Xdjhyia/3E7WlJhQzdfrHD/42hM5spi+9gWrUefz9ihEoENTud+ukcsoL3w2kTC/xUiLlYDXE0Ju80ryJ/6N8E3Cj8zvASiOYtRyfvnlOLK3QuuPcQcZyzaIr876KxZCx7wAv2c8yv6bJ2H+1POuWU78GBf5TqxpKz5lwnQLGiIq6gfGBDsk4/0Fldn0zufdUhNMPPBDMvFSUmUgkyBbAIluDydgyYzy/JWh8VAvZzInTWmCRSfPVwZgNvGFRqcWd+ynhS2K7fn/Qi/REoJUykzaHM4swJm4NPnY/J0I0E/WkVCkxhKzQBAOl2Vm+p9ue5L4Ne2DVIcMGkSgTf+V3SfxXYynUY7k/56C/kSP5yWuljkJMAX9JgR5cOfm3m/3/ZOWsdjx0ZHpVB4pDss0S+pUOvgn5WVES05aGhDoK+TZVkWPsEkJ0QKreUs/dHSoxEdXH43fMXk8vhm1KM34X56S9DBxyRv9W6zfybaCgMGe1Qb/WvmFc+PA1FNtE2Iq+nhJxIuBF7lxvGb96olEUNZFxi5keZmJHp9TANGe1rMAo2FC4g4YEBkzbQut/meqRvV3VVU/ruSDqkw/QlEXcDRjHTGvgPTGMcTTcnapjxi8a0LnzWWG6qj4mQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB5658.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(6916009)(52536014)(508600001)(33656002)(5660300002)(122000001)(54906003)(8676002)(186003)(86362001)(38100700002)(9686003)(2906002)(66946007)(7696005)(64756008)(66556008)(66446008)(66476007)(6506007)(8936002)(26005)(76116006)(71200400001)(316002)(55016002)(38070700005)(4326008)(7416002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wqU4Ob2xfdFvJ8tPjZGP8Cxf7hYvYUqenqthq2gy854JGt/dCaraRofe+pyb?=
 =?us-ascii?Q?bQBDRVyEl/hUJibp1DMvJv0Fo9BlZQG91H48xw9VYtk2DQoomrdUJiMoe2XL?=
 =?us-ascii?Q?60c9QhMb2P1iC1q4s9QfHAxu70tDi+Vgcbb0CxpZu0HjfJnZDnqqQ8KpNRaM?=
 =?us-ascii?Q?jR2MgGHwfvGkwagVV9qcF+ddnsxQ4QiNq31Lg5QWBTf0i/OR/Fn18fl0rniz?=
 =?us-ascii?Q?IQ+VTvyZzW2DRDeBm4eAKjxrmxCa83gHxAVj9W0QPUzjtor9kgjSq2LQdy+4?=
 =?us-ascii?Q?nu4cOYckl9drlhI3p251CJR8JhDLWOwf48HKvZ0t0b+lpRY8TlqwkFGdRP7j?=
 =?us-ascii?Q?BiefX7u3bnMTVcb/J0mTRj0uPLj1XI7JOD+9Lcmr9FB06fMwzFKmTqkHC1yy?=
 =?us-ascii?Q?9d32xkToMI4b+cL+yT1xWBiTc4f7Uqh7MiT68TBg0TVHcHAAgcBhEskXJpB/?=
 =?us-ascii?Q?9I5WZbLi58nRVsadcJGq9R7N/hHaQq42wqZ48zf6/+OG21tKGPEEgzzAeqvV?=
 =?us-ascii?Q?Nmcr9/ZseJfZje5kW8Sf1oE0yjXVKNbiom5IE2IuL0JExpRuSuO6eh1fBslP?=
 =?us-ascii?Q?IbW/RZ/3mUkKSkliW7jTtrOVDVTvfgX1heSFsq7SN7EfVIKiO7Thki8I+Ac0?=
 =?us-ascii?Q?7JmxzAhk09TbaClosAkz30fzq41vw5GZoxj+oEzX1r3aCvNi+hLfNKBZtEXb?=
 =?us-ascii?Q?yF0OLslsw4f3JqgQKqIFTBhJWiXQQNP+MKtMLCtUJKqeWKIcqPs0wzwZ87t3?=
 =?us-ascii?Q?Yndx0uStVutNA2JKRz+XbnaZ59LhPOUX8nDYVa7TqjQ6w16VDbhu1XijgyKM?=
 =?us-ascii?Q?W3GaeGvvPTmQA6sTC7uVNwctlT1dl0VhyIfvEx5FaCbOr+9mVbygHcvO8z2i?=
 =?us-ascii?Q?Pp7uhl8duxhiLyZ7fQ3plrNsHa4KTVs95EJh120gV91AokxjpIIS3B8I9ngG?=
 =?us-ascii?Q?1A+bp9JUTgkt3X0Pps+sX66byINnr141dBw011hMCQCZ7jJqRZFx8uJoRCJy?=
 =?us-ascii?Q?Xn7aQoIb3kFUgDAil1v4E1WTC48MA9oAwxuCg8tSn/k7nevtqOnbrDiUY48U?=
 =?us-ascii?Q?V6bFkbAlkQrfAWrUYGbLz3oD5MseZIDcplur1AqDdwDlFtDAQpNHWTdV2ikg?=
 =?us-ascii?Q?HtYeuzvYIT4jS21Wxnp+/DeNNrNlEF0WCWU4g2JD39lgvR9y9I45+1FY7fB7?=
 =?us-ascii?Q?aVIZfAo+Z4+F7NH8/m477WvvqQZ7emafWHFQPBteuW5grdPpHuLH8LrlHpza?=
 =?us-ascii?Q?OonLv6GhqbngPU7uE4nT7GL4Obas9ClT9DYYxeH5HW8f0xHDrsI4z8MKDTCt?=
 =?us-ascii?Q?PgFejOnYROaeUVan+h1NE36A?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5658.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9caa162b-cd3f-4a13-f477-08d983360c9e
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2021 10:44:01.1627 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Rk5sMINXhu78CeUfhVTm5uaH0tGR3yugiW0fypKpw/GXlbAcMUtyrzeBP2c1+BOlHaTU2e7XNKa/XVQIONIe7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5643
X-OriginatorOrg: intel.com
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "kwankhede@nvidia.com" <kwankhede@nvidia.com>, "hch@lst.de" <hch@lst.de>,
 "Jiang, Dave" <dave.jiang@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 "corbet@lwn.net" <corbet@lwn.net>, "jgg@nvidia.com" <jgg@nvidia.com>, "Tian,
 Kevin" <kevin.tian@intel.com>, "parav@mellanox.com" <parav@mellanox.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "lkml@metux.net" <lkml@metux.net>,
 "david@gibson.dropbear.id.au" <david@gibson.dropbear.id.au>,
 "dwmw2@infradead.org" <dwmw2@infradead.org>, "Tian,
 Jun J" <jun.j.tian@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "lushenming@huawei.com" <lushenming@huawei.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>
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

> From: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Sent: Wednesday, September 22, 2021 10:49 PM
> 
> On Sun, Sep 19, 2021 at 02:38:45PM +0800, Liu Yi L wrote:
> > [HACK. will fix in v2]
> >
> > IOVA range is critical info for userspace to manage DMA for an I/O address
> > space. This patch reports the valid iova range info of a given device.
> >
> > Due to aforementioned hack, this info comes from the hacked vfio type1
> > driver. To follow the same format in vfio, we also introduce a cap chain
> > format in IOMMU_DEVICE_GET_INFO to carry the iova range info.
> [...]
> > diff --git a/include/uapi/linux/iommu.h b/include/uapi/linux/iommu.h
> > index 49731be71213..f408ad3c8ade 100644
> > --- a/include/uapi/linux/iommu.h
> > +++ b/include/uapi/linux/iommu.h
> > @@ -68,6 +68,7 @@
> >   *		   +---------------+------------+
> >   *		   ...
> >   * @addr_width:    the address width of supported I/O address spaces.
> > + * @cap_offset:	   Offset within info struct of first cap
> >   *
> >   * Availability: after device is bound to iommufd
> >   */
> > @@ -77,9 +78,11 @@ struct iommu_device_info {
> >  #define IOMMU_DEVICE_INFO_ENFORCE_SNOOP	(1 << 0) /* IOMMU
> enforced snoop */
> >  #define IOMMU_DEVICE_INFO_PGSIZES	(1 << 1) /* supported page
> sizes */
> >  #define IOMMU_DEVICE_INFO_ADDR_WIDTH	(1 << 2) /*
> addr_wdith field valid */
> > +#define IOMMU_DEVICE_INFO_CAPS		(1 << 3) /* info
> supports cap chain */
> >  	__u64	dev_cookie;
> >  	__u64   pgsize_bitmap;
> >  	__u32	addr_width;
> > +	__u32   cap_offset;
> 
> We can also add vendor-specific page table and PASID table properties as
> capabilities, otherwise we'll need giant unions in the iommu_device_info
> struct. That made me wonder whether pgsize and addr_width should also
> be
> separate capabilities for consistency, but this way might be good enough.
> There won't be many more generic capabilities. I have "output address
> width"

what do you mean by "output address width"? Is it the output address
of stage-1 translation?

>
and "PASID width", the rest is specific to Arm and SMMU table
> formats.

When coming to nested translation support, the stage-1 related info are
likely to be vendor-specific, and will be reported in cap chain.

Regards,
Yi Liu

> Thanks,
> Jean
> 
> >  };
> >
> >  #define IOMMU_DEVICE_GET_INFO	_IO(IOMMU_TYPE, IOMMU_BASE +
> 1)
> > --
> > 2.25.1
> >
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
