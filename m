Return-Path: <SRS0=EsFc=PR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B600C433F5
	for <iommu@archiver.kernel.org>; Fri, 29 Oct 2021 09:47:38 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3478E610A0
	for <iommu@archiver.kernel.org>; Fri, 29 Oct 2021 09:47:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3478E610A0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id DF7B4400A6;
	Fri, 29 Oct 2021 09:47:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ye3ItFfBMHcP; Fri, 29 Oct 2021 09:47:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 7FDF540017;
	Fri, 29 Oct 2021 09:47:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 54B0AC001E;
	Fri, 29 Oct 2021 09:47:36 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E88E7C0012
 for <iommu@lists.linux-foundation.org>; Fri, 29 Oct 2021 09:47:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C4D4B80C8B
 for <iommu@lists.linux-foundation.org>; Fri, 29 Oct 2021 09:47:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bhiKAiJXjW_q for <iommu@lists.linux-foundation.org>;
 Fri, 29 Oct 2021 09:47:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0E08180B98
 for <iommu@lists.linux-foundation.org>; Fri, 29 Oct 2021 09:47:32 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10151"; a="316831727"
X-IronPort-AV: E=Sophos;i="5.87,192,1631602800"; d="scan'208";a="316831727"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Oct 2021 02:47:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,192,1631602800"; d="scan'208";a="557163249"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
 by fmsmga004.fm.intel.com with ESMTP; 29 Oct 2021 02:47:31 -0700
Received: from orsmsx605.amr.corp.intel.com (10.22.229.18) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Fri, 29 Oct 2021 02:47:31 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Fri, 29 Oct 2021 02:47:31 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.170)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Fri, 29 Oct 2021 02:47:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eVIc+kp+F8nnJhm4sqQ9tDuf24vbLGDSqqbxXxQ1XsppuRl7fwxnWThPrJR+Hgl8ukW1yg/DqxJjWMzLSaFYa0P/CMNh/kVLGKwCTDLp8aXkSIVOj9tIi/hycWyYF9dnrMLgLBktOHCf4jjG523gpAqpyt86xUlQpB1/ezzC2vTRyRe1lb8WeT0igh3WFPf1Qio42D1MtSx8AYL6dMuII2sRJ6yGMoWaRb0x8ORqwFoIEktA3KqoVF7ej03KvmM1yAv1U1QwkcAn3k0h16J3A1WpRuepnpVJya0Byczxt1CA3PSn+ayx40y0AwYbRPnfsDZacKm+0LKbF7CDYEZzGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xSGVDrCgcgSRkXfLh/lVYlgmKME89K8w3nLtpJ/gZvc=;
 b=kpwWmBGtjPmJcbyTMJWZDdfUR+qhqPY75JACc9tdORCwNOEJy9mabTqXEbVHzH+s6Ve7DVQxz7/E+w17zUgbzhmhktcZ9qyT89LCcTfLMTB90eUf94TtPPf2m1+dRhPIlzEHDMk487XiHBH6ODKXan9R5GQ4JEH4kOzGY0596z4gvN0MIStaHAKYqA1AQz1F6U53gKG7aMlzZ/2QhoaBa735nXR4jseaKw9oc+ti32HrEDlTebXNaAOoWvhGRvE/SX/ZkWBlsqKrDFt59NVeMJr/LdOfZLHc5a5MmWF3Wfp/uedANci37Jul4XcXnpqydus8Km+yfXAAgCTuSohGEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xSGVDrCgcgSRkXfLh/lVYlgmKME89K8w3nLtpJ/gZvc=;
 b=dqjLmp2LABCwAHJs2eeE+WzZVcyw5Ecd84ckME5RhmOMXB4T/V/k5E21v8c3mhRgxvcEOiJngDf59f9Ehp7bLuiIC2Yoo2jL3aV0CXRxrApnfMxrlqSng51kWM5GhRzLgJbotv2yc0g/N6SojoVAi9H3V8novv7YH7SzQQYahmg=
Received: from PH0PR11MB5658.namprd11.prod.outlook.com (2603:10b6:510:e2::23)
 by PH0PR11MB5644.namprd11.prod.outlook.com (2603:10b6:510:ef::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15; Fri, 29 Oct
 2021 09:47:27 +0000
Received: from PH0PR11MB5658.namprd11.prod.outlook.com
 ([fe80::5009:9c8c:4cb4:e119]) by PH0PR11MB5658.namprd11.prod.outlook.com
 ([fe80::5009:9c8c:4cb4:e119%6]) with mapi id 15.20.4628.020; Fri, 29 Oct 2021
 09:47:27 +0000
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: RE: [RFC 02/20] vfio: Add device class for /dev/vfio/devices
Thread-Topic: [RFC 02/20] vfio: Add device class for /dev/vfio/devices
Thread-Index: AQHXyZ9N9hHTiUakTUi0phVNj8QgQ6vpuU9g
Date: Fri, 29 Oct 2021 09:47:27 +0000
Message-ID: <PH0PR11MB56586D2EC89F282C915AF18DC3879@PH0PR11MB5658.namprd11.prod.outlook.com>
References: <PH0PR11MB56583D477B3977D92C2C1ADDC3839@PH0PR11MB5658.namprd11.prod.outlook.com>
 <20211025125309.GT2744544@nvidia.com>
In-Reply-To: <20211025125309.GT2744544@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.6.200.16
dlp-product: dlpe-windows
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 80c5d844-cd0e-475b-9036-08d99ac11e2e
x-ms-traffictypediagnostic: PH0PR11MB5644:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <PH0PR11MB5644437FD91424CD2BD4B335C3879@PH0PR11MB5644.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hIEC71P9dqBAgQuhij+dTWGjl2ypuHAb7Cm/umod0CIoTM/PsmTx8SQqRFIhXYPYFpiISEBuDKw4OGPVuaED04N20yjy1rncyPUSxonI7cIcARuDvBRHQ/f1iS/n2vG61d0fdVN7p2B59XbUQj/Gedoccg1MR7VmjYnXHQUD0oPW6R1DX+jMoc7QdYAR7VJ0LC0wq7J1QHqeHIDpmeauBNM3Bzn/musas/geEue86IRoWkDiYxG3Q+VmsOfdIk8UmHODnS27KJCIJLJgcv7QWNZqIxl1ZkZOD7dN81gJ0VrKiQ/uPgmNl4uEAS7GLelwDS+EADx5Mwpa59SJyWQy8ZpCIBpJ2QtB/m8pAPbWytxsArMWxk7iQJIdwv8JG4JBpIFrXM87T7vQx8MTWXtVucZ0at0cwpxOm7oIjKUVA3kxsAbgSYZXtIMu/aJe/NBQJs1XfJWbSfOBY6zbWeMNzjPWN8aDttlrVpJETvPVKXBgdViEPoesBpme3/AefJTEwNYJtS118QkOX0I+xmfyZN1QCdewD1dwhn2J4H9jMfj8Em/N+dFtZ9f+ddHj4Cs5zPzznaQjyAw/2k5Q1kp02MH7uoXD10wHhoJ7AAfPPG1vuX2PUSkylKsDv/y9wjEQY3HAC4Zv5tadxbwNBzVr9DdRH043AUo5cxTLSpDBW+RcLBLRxUPjPm7RbKTpn9KKvXuK6fdzfkwWTvQqwudkqQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB5658.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(6506007)(7696005)(7416002)(5660300002)(9686003)(55016002)(71200400001)(52536014)(83380400001)(316002)(66446008)(8936002)(76116006)(186003)(26005)(54906003)(8676002)(64756008)(508600001)(4326008)(33656002)(38070700005)(66556008)(122000001)(38100700002)(82960400001)(66476007)(6916009)(2906002)(66946007)(86362001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?VHACYHR3sj8UWMRZHBiKnP+hiydylG9fcANQaFMiIJNrpj41rLpVI7FKNAtN?=
 =?us-ascii?Q?ayy3fzgQ8R9Xhg4IObyi3Z33mPuQnzlrIObsSDbW8acN3k64CptsQBPImi44?=
 =?us-ascii?Q?JNgeSonI3oZmwLzizDncUkKgDAV6llwRET/5zba8163HW1zLZMRIiCrc9NBn?=
 =?us-ascii?Q?ui3ogs2N0W4ixF4fUlsnPqKpqjtOlzAdm6fuWS86P4o6ESQ4h5yPBSfHDpos?=
 =?us-ascii?Q?wvNBDewaaY3HGySeYjOY3c9r/FS4Luo2IBHWYtHl9oAoAax8/7x0vyCHbRNV?=
 =?us-ascii?Q?4wtNrNiHSs3QSOKNIrignKZyr0CqOva3bVgEHx99u8zF7i/VaUckvWOw2tNl?=
 =?us-ascii?Q?7euKs7WW9auQU2Hziob5g/HUh2aXlEWjVgMYqfT0XFUY2EqdCsZh5rOW34L7?=
 =?us-ascii?Q?vsVv4XGzcu7HLiRtbCKjGtG5bzEKdQza4vRj4kQavCPeI7qdJogOcoIpOm9P?=
 =?us-ascii?Q?8fQPeY7ONv6E+le0vhPqxxFRi3tsf3WzujjekA2W2+oXHVK2Pk9TQ8hbe5VB?=
 =?us-ascii?Q?q3iEgog4m2W53xdrzdmdLDut46WxEt99BFflZrzYseKaxmc8nnzBRso3FmV1?=
 =?us-ascii?Q?ZIjl1zOS/43D9o9L8HWdlH4D3Wg1m05ufdunSlpjJqr+C1yVM7nvbYjUyaek?=
 =?us-ascii?Q?7ctghH4uPwmaz2qzsbcAL+cov9DlK7Uz1+dHIHuMMyQ9VNXDh1PpJuig/cVO?=
 =?us-ascii?Q?LsdmPT4PchDGNxyJiwS2xiqtqUbAqTQkMTZgudNJpZrtMpZQUJ60oVcM9JUZ?=
 =?us-ascii?Q?2gBjJloRXDyVyofYMAF6qx0a65R8DWIkPyagRWrcaQy8u7jR2HGueOjxhT60?=
 =?us-ascii?Q?oKAZcM7vP0Zepgye+IDiiukIjMl4W2d6WCCcuaxDYVu3kgZHJYQPJwHfczRN?=
 =?us-ascii?Q?I9vBekQX/juWHBgIigfystYMQPDHQkmT8h8BziOUXl7v7PkxIfoG+pz4SQ5U?=
 =?us-ascii?Q?oKaXqYiDnxcEeIfvAp2mX82hyaoIbw1MlH5hjm1vjlmPOSCbWkG7UZBj1kKI?=
 =?us-ascii?Q?z6enztUH4mu2mUCjkz+za4IJuNtbo3OHG+rUqcVe/cXZvGH7t7bREaRg4iHp?=
 =?us-ascii?Q?m6WqkBn4R0MwOesp5EH+VVhFr/zQAYQPfUGtMCktxZzKJUqK/d9e24nbZ0SP?=
 =?us-ascii?Q?qBjfi7RHzAPLsTOU/JvX3ewH3LjYtbzgqyOKFdrxToCrpCkCvujCjwrfWoUd?=
 =?us-ascii?Q?rKGTvClwCZwbIVk7b5xUiQCHjBCIFOmsV4aXLHq9KuJVKwrorhXhxc7AGFvd?=
 =?us-ascii?Q?7PwSmWGlrXTo3GFBmpWU5usnPKXaoITUT3ZVjUROjS8H/U35cIvU8cpZWhLD?=
 =?us-ascii?Q?mARxt9QJGtDmIBqsvXoTCGUFbRpGWCacPL3YQcRrpM+KmLsQarDUsmBPk389?=
 =?us-ascii?Q?fHVlkwHvrLiHGiUmE3F8SsawzYb+psLwD/9+35CbAE2kUSySPoUko7t9/Zys?=
 =?us-ascii?Q?EP7Q1oLh+7QrP9Hy1HHcLPhbYXIOt24sph+Yr4QJ8pXkJMO15dA4m8fa+wlA?=
 =?us-ascii?Q?Z/DqhX0Lg8CeoPzY+3hX467mYnKRhWFrlq0ENO7fGAm4nUq/WaNKWrb1cc22?=
 =?us-ascii?Q?Uix2d4M0yuhLWU27HxgDAZXfigTwnk6ctvuInrA0ni/IRiQJdV+w4a1qNZ7I?=
 =?us-ascii?Q?wCT1lXkIE5/zshGWySVBshY=3D?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5658.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80c5d844-cd0e-475b-9036-08d99ac11e2e
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2021 09:47:27.2641 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ks9I9MXQReUkj/WbTPohaU8T5RJR8S1hrsX++E/f5jvyzZS2X0ieGUrL9WMwYY00PJR5Tddd8E98Bd9+x5FGHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5644
X-OriginatorOrg: intel.com
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "kwankhede@nvidia.com" <kwankhede@nvidia.com>, "hch@lst.de" <hch@lst.de>,
 "jean-philippe@linaro.org" <jean-philippe@linaro.org>, "Jiang,
 Dave" <dave.jiang@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 "corbet@lwn.net" <corbet@lwn.net>, "Tian, Kevin" <kevin.tian@intel.com>,
 "parav@mellanox.com" <parav@mellanox.com>,
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

Hi Jason,

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Monday, October 25, 2021 8:53 PM
> 
> On Mon, Oct 25, 2021 at 06:28:09AM +0000, Liu, Yi L wrote:
> >    thanks for the guiding. will also refer to your vfio_group_cdev series.
> >
> >    Need to double confirm here. Not quite following on the kfree. Is
> >    this kfree to free the vfio_device structure? But now the
> >    vfio_device pointer is provided by callers (e.g. vfio-pci). Do
> >    you want to let vfio core allocate the vfio_device struct and
> >    return the pointer to callers?
> 
> There are several common patterns for this problem, two that would be
> suitable:
> 
> - Require each driver to provide a release op inside vfio_device_ops
>   that does the kfree. Have the core provide a struct device release
>   op that calls this one. Keep the kalloc/kfree in the drivers

this way sees to suit the existing vfio registration manner listed
below. right? But device drivers needs to do the kfree in the
newly added release op instead of doing it on their own (e.g.
doing kfree in remove).

vfio_init_group_dev()
vfio_register_group_dev()
vfio_unregister_group_dev()
vfio_uninit_group_dev()

> - Move the kalloc into the core and have the core provide the kfree
>   with an optional release callback for anydriver specific cleanup
> 
>   This requires some macro to make the memory layout work. RDMA has
>   a version of this:
> 
> struct ib_device *_ib_alloc_device(size_t size);
> #define ib_alloc_device(drv_struct, member)                                    \
>         container_of(_ib_alloc_device(sizeof(struct drv_struct) +              \
>                                       BUILD_BUG_ON_ZERO(offsetof(              \
>                                               struct drv_struct, member))),    \
>                      struct drv_struct, member)
> 

thanks for the example. If this way, still requires driver to provide
a release op inside vfio_device_ops. right?

> In part the choice is how many drivers require a release callback
> anyhow, if they all do then the first is easier to understand. If only
> few or none do then the latter is less code in drivers, and never
> exposes the driver to the tricky transition from alloc to refcount
> cleanup.

I'm not quite sure. But per my understanding, since the vfio_device
is expected to be embedded in the device state struct (e.g.
vfio_pci_core_device), I guess most of the drivers will require callback
to do driver specific cleanup. Seems like option #1 may make sense?

Regards,
Yi Liu

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
