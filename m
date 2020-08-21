Return-Path: <SRS0=6E3Y=B7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URI_WP_DIRINDEX
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 124C5C433E1
	for <iommu@archiver.kernel.org>; Fri, 21 Aug 2020 00:53:58 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5D32207BB
	for <iommu@archiver.kernel.org>; Fri, 21 Aug 2020 00:53:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="oByEL4n2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5D32207BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id C6A5288656;
	Fri, 21 Aug 2020 00:53:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UK4WYS28pJYv; Fri, 21 Aug 2020 00:53:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 0AC5C88646;
	Fri, 21 Aug 2020 00:53:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E0D1DC0889;
	Fri, 21 Aug 2020 00:53:56 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BE183C0051
 for <iommu@lists.linux-foundation.org>; Fri, 21 Aug 2020 00:53:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id A6E748864B
 for <iommu@lists.linux-foundation.org>; Fri, 21 Aug 2020 00:53:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id G1p3EeskhSiK for <iommu@lists.linux-foundation.org>;
 Fri, 21 Aug 2020 00:53:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by whitealder.osuosl.org (Postfix) with ESMTPS id D983688646
 for <iommu@lists.linux-foundation.org>; Fri, 21 Aug 2020 00:53:54 +0000 (UTC)
IronPort-SDR: WChf50bm1CQyub2N/80EqPx+oneLiZY9IDVZBWG8l1nbNHbRNANKv+hORhjBEiGyWj9AlsdySh
 9hdNpNvmgPIQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9719"; a="219733792"
X-IronPort-AV: E=Sophos;i="5.76,335,1592895600"; d="scan'208";a="219733792"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Aug 2020 17:53:54 -0700
IronPort-SDR: DO7YEgSsi/zSZCdemwDt1pt8t8MHbaZJ+S5iPXFSjHbrDvKblRT70lA3ZUaaAJztLBCprMi98G
 Zvwi+5YPKlgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,335,1592895600"; d="scan'208";a="497814420"
Received: from fmsmsx603-2.cps.intel.com (HELO fmsmsx603.amr.corp.intel.com)
 ([10.18.84.213])
 by fmsmga006.fm.intel.com with ESMTP; 20 Aug 2020 17:53:53 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 20 Aug 2020 17:53:53 -0700
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 20 Aug 2020 17:53:53 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.173)
 by edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Thu, 20 Aug 2020 17:53:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DzcfZvRvUQ8H1QPJltkecqcVxo0hhDF7ABhaKpxiUR1JwcI/6oXxn+P4qmJ5Fxns+Z6XVj7D18VgvRjJnaIGuad+otDHaJDjTdcsAXlvys8typgGHW5uQGY4y2TbhrOPR4iOh5bBP9yAwvrTTPGMjwvgDojmHSHfk3THiPydEnXrEvOQzLl0WeyLy1HoNNOPcMOlqSFz5zQK+PDRZc9lWYPbH4CdX8t40F/Ca/y7vFz/7eOZVvLWv9ReSTsgS0MfInKpxBaMhB0L/qTqmqgx8S5rYL2rOneZj8OYjhv2ZWDvAFGg59/F0aBmXCWPQzrrg31NRkqvZ92RyuECuWjj7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZGtTwoTDKYOJzPRFMweWBbjkLv2DXlwkeCIl1ymRuyo=;
 b=NHLwfUuePsyrCILWCdRQMznGUfwOIBZ0OwRnzEPYGqa50N/0hmReSSucLILI8IqiNduJHhu8SFzmteh2EktZSr3LKJNInXpfgORce/AAeWifSGZX2JSDVxocF2lLc53udHxRPsLs8YcnfJ9J1NtBRz2PaAFgSHx1s/ehE7nB9aWJmt6TL3AjebmQsNMzJsf/X6mncUIHkIAssQSCVUJFai0y+YikSQHwuxFqX1pIu+lPJ0RqE5z2+dImEnbfx6PYKkovDKjxiiiqwbqpSaJwIj+dQBUasqK6YskjBETslIDBPP1hBvxQhTAvPEyisI9jymo/2zIxTfAA924ytMsiZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZGtTwoTDKYOJzPRFMweWBbjkLv2DXlwkeCIl1ymRuyo=;
 b=oByEL4n2l1q6VyHfrmkZd1t4H50pKbuRuDeTLoSFMuLPgBrZQ1OV9DToM5uudEpvQWxIsR3Pr1GZKam3H66UrLEZN0/dVj3ryfmWAKRYQrLQwYVoA54v/RkmMJScP9rllqtNk/+6evEhmvCu8Ff7litp39xAalSg/CHkGIlUysM=
Received: from DM5PR11MB1435.namprd11.prod.outlook.com (2603:10b6:4:7::18) by
 DM6PR11MB3196.namprd11.prod.outlook.com (2603:10b6:5:5b::30) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.24; Fri, 21 Aug 2020 00:53:49 +0000
Received: from DM5PR11MB1435.namprd11.prod.outlook.com
 ([fe80::9002:97a2:d8c0:8364]) by DM5PR11MB1435.namprd11.prod.outlook.com
 ([fe80::9002:97a2:d8c0:8364%10]) with mapi id 15.20.3305.024; Fri, 21 Aug
 2020 00:53:49 +0000
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: RE: [PATCH v6 12/15] vfio/type1: Add vSVA support for IOMMU-backed
 mdevs
Thread-Topic: [PATCH v6 12/15] vfio/type1: Add vSVA support for IOMMU-backed
 mdevs
Thread-Index: AQHWZKdGYVW899YIZEKAgl5vKmGxWqlBrhWAgAAzauA=
Date: Fri, 21 Aug 2020 00:53:49 +0000
Message-ID: <DM5PR11MB1435AF11115CE8FEF6977BCAC35B0@DM5PR11MB1435.namprd11.prod.outlook.com>
References: <1595917664-33276-1-git-send-email-yi.l.liu@intel.com>
 <1595917664-33276-13-git-send-email-yi.l.liu@intel.com>
 <20200820154853.21b660d2@x1.home>
In-Reply-To: <20200820154853.21b660d2@x1.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [117.169.229.112]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 92d43066-f0e8-482f-3908-08d8456caa8a
x-ms-traffictypediagnostic: DM6PR11MB3196:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB3196C64F65A28F790CE96916C35B0@DM6PR11MB3196.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bK1buVi53xF5YLcH8IwzAeMtLqcTjfmHosnkLUDqJxskfJRgqD6y/cGgWKxeEldDUPHHhPgZiKOhKQkhgZpYSQgiIYf7kSYUKrmEq3sqMDWc6G4Kr+Kj4RrtHf+TBBp12ycJeAyHIYUj8qCevJURc7d0hkVa+auZ6x90ewRBinQS/Nn+RvYkPt66LJKFwdgFB0kIQDi7rQ+peQUSRDms/LvNhH5N7PAz8fnEp4eS0BhLvgKQ2Rgq4uS7qOnM/cAmRFT31F7VOooMc280n4+H4LKbdJjmyL5B5gLa0h9CNOWPu8rhxFYJkqwraj2az01HgUwTtGTVW7aY1G6L1AAWzj8S2OPkeX+/P1cHLLbywTaY/2bLONHfGS0i+1rmP3i2q3YwaXMizcdHGonkjNnQq8qmKvnKE2QcAj7oZTwSfp9gxx8d8e9eg3FHAZfWQVx7K0w2KuQ31XMLgox4JzN7umxJmxmlVHTuceG2M4y0IJgUQapUpy5gZQ4xy2lXx/5U
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR11MB1435.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(39860400002)(136003)(366004)(396003)(33656002)(83380400001)(71200400001)(478600001)(7416002)(66946007)(76116006)(966005)(2906002)(55016002)(8676002)(9686003)(4326008)(64756008)(26005)(54906003)(86362001)(66556008)(7696005)(8936002)(66476007)(316002)(5660300002)(66446008)(6506007)(186003)(6916009)(52536014)(43620500001)(15398625002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: 72HhEyMeI6srLpGtHglph8bypkD2wY0hOUPBMzWq/qe1mLNgMDhlzWtpkqbIrXioMVLfXouNhTV8O0/l/wme93Z00nO6JiymkziNFP0w0T+bJ9iLLIvdUNhCz5LIEBxjdnMT3Oniw7nFTC4Oxt/2u6cx3Zibt37HOek/nQ6ASv+2UQoAkSbFiG+efebnjUksknYzDnU0BP1aXCwZ0y9P+BXmHoxQXKzy72Ym2LrnOdzlG04SBB7yRtJg6NzCxfZ8+cj2gILmnRZQmtCON8CZBFSwrPohrAErLqO1/+ZkEgSOMFq7B7qbbf1lNX2LRD5kyGbJ9iNJ2SHQO3ScqEG+enoxgRztm2eytnn8Gc27gil7RB9K77wUQE0onfhD9Psi67ywmjrxG0IHPBErfDWkV7NSNUiH/K8I/sRSqpIH0WAa7yMHCAisXEPAgQ98opIaWzrQ4UypdvsjwqdojVTgLUAAE03EhMYdFbcsT8YZ8xywYVl3R0v4yQV4fqwYoxrQ7JHHmdeEJWYAeabXbkuQVAE8HAK3F9mZUL16DJWpFv+rZbbSAWqQOKKmOhdWHTZGt04Bc/tsgkVF5S73IquYKAIczPSPjqw/oMC0k5SiXcd8n+IKtMMpXLXL+pNzoSWKtiZ8wXkPRT3MmFCEzs07Vg==
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1435.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92d43066-f0e8-482f-3908-08d8456caa8a
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2020 00:53:49.1155 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9A30hjau1HcTby0DZdmEUktVB8pLV+3YW9nmRoJsrkir8I+NH3Z45gjBgjn6wj+uVR+AZTPIesVhwp7Zzi/WYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3196
X-OriginatorOrg: intel.com
Cc: "jean-philippe@linaro.org" <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "stefanha@gmail.com" <stefanha@gmail.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Sun,
 Yi Y" <yi.y.sun@intel.com>, "Wu, Hao" <hao.wu@intel.com>, "Tian,
 Jun J" <jun.j.tian@intel.com>
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

Hi Alex,

> From: Alex Williamson <alex.williamson@redhat.com>
> Sent: Friday, August 21, 2020 5:49 AM
> 
> On Mon, 27 Jul 2020 23:27:41 -0700
> Liu Yi L <yi.l.liu@intel.com> wrote:
> 
> > Recent years, mediated device pass-through framework (e.g. vfio-mdev)
> > is used to achieve flexible device sharing across domains (e.g. VMs).
> > Also there are hardware assisted mediated pass-through solutions from
> > platform vendors. e.g. Intel VT-d scalable mode which supports Intel
> > Scalable I/O Virtualization technology. Such mdevs are called IOMMU-
> > backed mdevs as there are IOMMU enforced DMA isolation for such mdevs.
> > In kernel, IOMMU-backed mdevs are exposed to IOMMU layer by aux-domain
> 
> Or a physical IOMMU backing device.

got it. :-)

> > concept, which means mdevs are protected by an iommu domain which is
> > auxiliary to the domain that the kernel driver primarily uses for DMA
> > API. Details can be found in the KVM presentation as below:
> >
> > https://events19.linuxfoundation.org/wp-content/uploads/2017/12/\
> > Hardware-Assisted-Mediated-Pass-Through-with-VFIO-Kevin-Tian-Intel.pdf
> 
> I think letting the line exceed 80 columns is preferable so that it's clickable.  Thanks,

yeah, it's clickable now. will do it. :-)

Thanks,
Yi Liu

> Alex
> 
> > This patch extends NESTING_IOMMU ops to IOMMU-backed mdev devices. The
> > main requirement is to use the auxiliary domain associated with mdev.
> >
> > Cc: Kevin Tian <kevin.tian@intel.com>
> > CC: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > CC: Jun Tian <jun.j.tian@intel.com>
> > Cc: Alex Williamson <alex.williamson@redhat.com>
> > Cc: Eric Auger <eric.auger@redhat.com>
> > Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > Cc: Joerg Roedel <joro@8bytes.org>
> > Cc: Lu Baolu <baolu.lu@linux.intel.com>
> > Reviewed-by: Eric Auger <eric.auger@redhat.com>
> > Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> > ---
> > v5 -> v6:
> > *) add review-by from Eric Auger.
> >
> > v1 -> v2:
> > *) check the iommu_device to ensure the handling mdev is IOMMU-backed
> > ---
> >  drivers/vfio/vfio_iommu_type1.c | 40
> > ++++++++++++++++++++++++++++++++++++----
> >  1 file changed, 36 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/vfio/vfio_iommu_type1.c
> > b/drivers/vfio/vfio_iommu_type1.c index bf95a0f..9d8f252 100644
> > --- a/drivers/vfio/vfio_iommu_type1.c
> > +++ b/drivers/vfio/vfio_iommu_type1.c
> > @@ -2379,20 +2379,41 @@ static int vfio_iommu_resv_refresh(struct
> vfio_iommu *iommu,
> >  	return ret;
> >  }
> >
> > +static struct device *vfio_get_iommu_device(struct vfio_group *group,
> > +					    struct device *dev)
> > +{
> > +	if (group->mdev_group)
> > +		return vfio_mdev_get_iommu_device(dev);
> > +	else
> > +		return dev;
> > +}
> > +
> >  static int vfio_dev_bind_gpasid_fn(struct device *dev, void *data)  {
> >  	struct domain_capsule *dc = (struct domain_capsule *)data;
> >  	unsigned long arg = *(unsigned long *)dc->data;
> > +	struct device *iommu_device;
> > +
> > +	iommu_device = vfio_get_iommu_device(dc->group, dev);
> > +	if (!iommu_device)
> > +		return -EINVAL;
> >
> > -	return iommu_uapi_sva_bind_gpasid(dc->domain, dev, (void __user *)arg);
> > +	return iommu_uapi_sva_bind_gpasid(dc->domain, iommu_device,
> > +					  (void __user *)arg);
> >  }
> >
> >  static int vfio_dev_unbind_gpasid_fn(struct device *dev, void *data)
> > {
> >  	struct domain_capsule *dc = (struct domain_capsule *)data;
> >  	unsigned long arg = *(unsigned long *)dc->data;
> > +	struct device *iommu_device;
> >
> > -	iommu_uapi_sva_unbind_gpasid(dc->domain, dev, (void __user *)arg);
> > +	iommu_device = vfio_get_iommu_device(dc->group, dev);
> > +	if (!iommu_device)
> > +		return -EINVAL;
> > +
> > +	iommu_uapi_sva_unbind_gpasid(dc->domain, iommu_device,
> > +				     (void __user *)arg);
> >  	return 0;
> >  }
> >
> > @@ -2401,8 +2422,13 @@ static int __vfio_dev_unbind_gpasid_fn(struct device
> *dev, void *data)
> >  	struct domain_capsule *dc = (struct domain_capsule *)data;
> >  	struct iommu_gpasid_bind_data *unbind_data =
> >  				(struct iommu_gpasid_bind_data *)dc->data;
> > +	struct device *iommu_device;
> > +
> > +	iommu_device = vfio_get_iommu_device(dc->group, dev);
> > +	if (!iommu_device)
> > +		return -EINVAL;
> >
> > -	iommu_sva_unbind_gpasid(dc->domain, dev, unbind_data);
> > +	iommu_sva_unbind_gpasid(dc->domain, iommu_device, unbind_data);
> >  	return 0;
> >  }
> >
> > @@ -3060,8 +3086,14 @@ static int vfio_dev_cache_invalidate_fn(struct
> > device *dev, void *data)  {
> >  	struct domain_capsule *dc = (struct domain_capsule *)data;
> >  	unsigned long arg = *(unsigned long *)dc->data;
> > +	struct device *iommu_device;
> > +
> > +	iommu_device = vfio_get_iommu_device(dc->group, dev);
> > +	if (!iommu_device)
> > +		return -EINVAL;
> >
> > -	iommu_uapi_cache_invalidate(dc->domain, dev, (void __user *)arg);
> > +	iommu_uapi_cache_invalidate(dc->domain, iommu_device,
> > +				    (void __user *)arg);
> >  	return 0;
> >  }
> >

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
