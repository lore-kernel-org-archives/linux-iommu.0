Return-Path: <SRS0=BMGV=BC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URI_WP_DIRINDEX
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A96C3C433E8
	for <iommu@archiver.kernel.org>; Thu, 23 Jul 2020 12:06:14 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70C1120709
	for <iommu@archiver.kernel.org>; Thu, 23 Jul 2020 12:06:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="P56rWQmR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70C1120709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 3937589974;
	Thu, 23 Jul 2020 12:06:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7a43UoD+VfcK; Thu, 23 Jul 2020 12:06:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 8592288C08;
	Thu, 23 Jul 2020 12:06:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7344BC004E;
	Thu, 23 Jul 2020 12:06:13 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EAC5AC004C
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jul 2020 12:06:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id CE82F89975
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jul 2020 12:06:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id g2cbPPSH2hEf for <iommu@lists.linux-foundation.org>;
 Thu, 23 Jul 2020 12:06:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by whitealder.osuosl.org (Postfix) with ESMTPS id E376888C08
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jul 2020 12:06:10 +0000 (UTC)
IronPort-SDR: T0MGFgRSnPxt6ZqdRF+ECAhoVmUIo3ycyyQBtl0bZTLGeHUdtx4ZS3qgM19gK1v54noELbXwIq
 RBaflY7gxCfg==
X-IronPort-AV: E=McAfee;i="6000,8403,9690"; a="138584679"
X-IronPort-AV: E=Sophos;i="5.75,386,1589266800"; d="scan'208";a="138584679"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jul 2020 05:05:56 -0700
IronPort-SDR: SBisw0KLhXfk9DVG+dAku/va1s5OZ4NRVe/T0a6CylLFrNB9dWnoeA6dasD+PArKRPcOjIazig
 St5VppGdqxSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,386,1589266800"; d="scan'208";a="320630836"
Received: from orsmsx106.amr.corp.intel.com ([10.22.225.133])
 by fmsmga002.fm.intel.com with ESMTP; 23 Jul 2020 05:05:55 -0700
Received: from orsmsx111.amr.corp.intel.com (10.22.240.12) by
 ORSMSX106.amr.corp.intel.com (10.22.225.133) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 23 Jul 2020 05:05:54 -0700
Received: from ORSEDG001.ED.cps.intel.com (10.7.248.4) by
 ORSMSX111.amr.corp.intel.com (10.22.240.12) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 23 Jul 2020 05:05:54 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 23 Jul 2020 05:05:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T6gnJAKz9S5yraYiYGbHrsMTrtlbJ/BPuQZVNlg6fmA+5We8rq9zX/MZWPqe70IQYDSyCMvP42S4P980LVRXH+lnOzuHJ0wztqOc+NRBii/j59s9x3x9uK6Bwr/EzuglQaVtM3mKEcIrCzS7WGaP7UP8ipDIId7aqy71ZPeqaGtvVXZ9j/7DibPO7DF7SHjWXew9EnyeLY2dEXBOt3GIcoDujH+nCv7UisUwVc7U5WbmGpsglugA9EFCYZBQz2n1NtXEYtikkVek8Amb1SQqSs0kmHI23XSJBl09UrgIIZI96Gy3rtzogH6jdOTVBW2s1hw0pjy2k9lpknSY7A/OMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XU0xVkNRG7Ih/+Xs97zWNr94AjZozEaUK4V22gBuO2k=;
 b=UmTDczu1L+AeZzAliG0aimbJKqWd7+c2RedxHqWPVhxAyWL1yhZrJZ5ljxHa3KwCtiWXBTnl+xNH4Mek2leoTC3dkJnWklBeZelqzzLgLjz9QPKJoLFrriNa7OXnJj3PplGTJV2RRfmMVllD9dWVBJ66pDOmhxT7LAm0dDDbsvkz1WTQnQ+MvOZv063DlgIS1XOZ7iBAlPeaf8OmnLOi4EcJVyaLId3yB7DqFAfMGHxkduHaqVvcHifxQ/Ohyg2MM2TJR9QEG8n8fh6qk/+Es+XmUbJmF/iqFzeudi8CiSgBCJaAiQzI4Qa/seY2CZyqX02WAJWuxbkPkaw++uAVUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XU0xVkNRG7Ih/+Xs97zWNr94AjZozEaUK4V22gBuO2k=;
 b=P56rWQmRDrysrIygAYJF4pdM97HBxWHC3djYyH8LOeCKN2Nxgq5QTJzDGN+v+fyfF/c8mfaWUbuX20ZY6MCSI9u1BpZRMOcZ/Su62zkSGRAn28D77AFRV8/h3ro69k8b6xB+mPcsnxseA81Hsp5IVrWKngOHMlTp6G8GPTo+KAA=
Received: from DM5PR11MB1435.namprd11.prod.outlook.com (2603:10b6:4:7::18) by
 DM6PR11MB3515.namprd11.prod.outlook.com (2603:10b6:5:6c::24) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3216.20; Thu, 23 Jul 2020 12:05:52 +0000
Received: from DM5PR11MB1435.namprd11.prod.outlook.com
 ([fe80::9002:97a2:d8c0:8364]) by DM5PR11MB1435.namprd11.prod.outlook.com
 ([fe80::9002:97a2:d8c0:8364%10]) with mapi id 15.20.3216.020; Thu, 23 Jul
 2020 12:05:52 +0000
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: Auger Eric <eric.auger@redhat.com>, "alex.williamson@redhat.com"
 <alex.williamson@redhat.com>, "baolu.lu@linux.intel.com"
 <baolu.lu@linux.intel.com>, "joro@8bytes.org" <joro@8bytes.org>
Subject: RE: [PATCH v5 12/15] vfio/type1: Add vSVA support for IOMMU-backed
 mdevs
Thread-Topic: [PATCH v5 12/15] vfio/type1: Add vSVA support for IOMMU-backed
 mdevs
Thread-Index: AQHWWD2m9cYqxGch9Ui/XGA0vhDWoakQcFWAgASyDUA=
Date: Thu, 23 Jul 2020 12:05:52 +0000
Message-ID: <DM5PR11MB14359BEC34E22DD1921A39D4C3760@DM5PR11MB1435.namprd11.prod.outlook.com>
References: <1594552870-55687-1-git-send-email-yi.l.liu@intel.com>
 <1594552870-55687-13-git-send-email-yi.l.liu@intel.com>
 <5921bffc-9daa-99be-9a12-6d94ce1950d2@redhat.com>
In-Reply-To: <5921bffc-9daa-99be-9a12-6d94ce1950d2@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.147.216]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d440f6ab-454f-4d0d-12f7-08d82f00bf21
x-ms-traffictypediagnostic: DM6PR11MB3515:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB3515AE9288ADE948E8B678EBC3760@DM6PR11MB3515.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HHYWynRlaS6Zyr92pEyjSSFzWqp3TfyphmEHqCPyB03vnUM5ZzgbZBh/hN2Sk0G6ZDSWPPEOiCxU/9ttF9GcQDOTh9y82RYe2H2kORthqKXq87PMY8FWRSVPSpObg1NWlQmMoFZzaJZSw9/9GS9CYbngvRYea3o6Ml8Lds1daq/eIkMbOfXNnvGQg01CJ2MmMBZLEqUtm11hD59lPtUInBtWN5l5Yp8Y+cYj72QXGRVb6nXjzBxTU09dFzep1P6FlIrbic+jl0AEzeqH/XFfP/qGjw2Y5/3K8fLxmsltz/qWjPbxoJbI0rLMm/t2KQid21Oq0mqNCbsEsE9It+8FPpCNz2BXKiTGLEg+VJaIb/D/0cfm0luiahUlaWywsnvK5yPYLOU9p0ckCl7bza8vstbgssJaKRajJ4hzcDTtanvyBNv+Mvsr+ATaMSU0gNqCctYTOcFX6e9EozhnpG6uuqICq8sp3e+ZXQTF6yrvdrQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR11MB1435.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(346002)(376002)(366004)(396003)(136003)(8936002)(76116006)(2906002)(966005)(8676002)(71200400001)(7416002)(66446008)(83380400001)(64756008)(66556008)(66476007)(66946007)(52536014)(316002)(54906003)(5660300002)(53546011)(6506007)(9686003)(110136005)(33656002)(55016002)(478600001)(86362001)(26005)(186003)(4326008)(7696005)(15398625002)(43620500001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: AQVCJhZuGJhbwxv3tIMxtwti1Q7s2wFGtgQuzEjMbZndKJ1bRgOJG0O+Td3uSw0PM3JpBdBz2RbXYj6kurnO9z+VNvBwrdf0O6Si6cVMUrG5aUh/VGfFjfHKUe2oHQZfS/dXymV3rKRH7YLOkVEzBeBqmHaqc6+0KphWxV0U/kSgDwvxCrxFKGoaKHM4C9urEVeZ+0us3WvZxp9dFun33NyepkVd1pIOQ5O8TgrzhpS1LNSWWjXd29DTLgjqQSzHvdDMd6LdBuiY0kJOx2bNm2BFbT4Jz1ZDdDmnOj4HcwDFuJ3ibZ6sJeF9hVlvRTXmge85xTUYvJmcixTG+ABikStcM+JPi5NsW3J+vcxn4bQL935j6VbOPB4UF69ICzH0B9ihDEDg2igvGPb3Rjj9G2G5V5bfX9qL0bB4MSdSrm7n3tQoqaGFG0IkSk2OaRB7FL6O9Eyk3lwypGmbSBrfKrF7q+fWgh5I31Hm88vHXJPFxrA99slEJdMT3FUTDTEg
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1435.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d440f6ab-454f-4d0d-12f7-08d82f00bf21
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2020 12:05:52.4297 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n3/09sYkki1B0zf3hRUuPpHP7fAOoXqlF3qtaZGZLK+rSkoDB8oYoznHl9JDrMMaqlvmr1sWpxgql9Lcaz2noQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3515
X-OriginatorOrg: intel.com
Cc: "jean-philippe@linaro.org" <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "stefanha@gmail.com" <stefanha@gmail.com>, "Tian, 
 Jun J" <jun.j.tian@intel.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Sun,
 Yi Y" <yi.y.sun@intel.com>, "Wu, Hao" <hao.wu@intel.com>
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

Hi Eric,

> From: Auger Eric < eric.auger@redhat.com>
> Sent: Monday, July 20, 2020 8:22 PM
> 
> Yi,
> 
> On 7/12/20 1:21 PM, Liu Yi L wrote:
> > Recent years, mediated device pass-through framework (e.g. vfio-mdev)
> > is used to achieve flexible device sharing across domains (e.g. VMs).
> > Also there are hardware assisted mediated pass-through solutions from
> > platform vendors. e.g. Intel VT-d scalable mode which supports Intel
> > Scalable I/O Virtualization technology. Such mdevs are called IOMMU-
> > backed mdevs as there are IOMMU enforced DMA isolation for such mdevs.
> there is IOMMU enforced DMA isolation
> > In kernel, IOMMU-backed mdevs are exposed to IOMMU layer by aux-domain
> > concept, which means mdevs are protected by an iommu domain which is
> > auxiliary to the domain that the kernel driver primarily uses for DMA
> > API. Details can be found in the KVM presentation as below:
> >
> > https://events19.linuxfoundation.org/wp-content/uploads/2017/12/\
> > Hardware-Assisted-Mediated-Pass-Through-with-VFIO-Kevin-Tian-Intel.pdf
> >
> > This patch extends NESTING_IOMMU ops to IOMMU-backed mdev devices. The
> > main requirement is to use the auxiliary domain associated with mdev.
> 
> So as a result vSVM becomes functional for scalable mode mediated devices, right?

yes. as long as the mediated devices reports PASID capability.

> >
> > Cc: Kevin Tian <kevin.tian@intel.com>
> > CC: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > CC: Jun Tian <jun.j.tian@intel.com>
> > Cc: Alex Williamson <alex.williamson@redhat.com>
> > Cc: Eric Auger <eric.auger@redhat.com>
> > Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > Cc: Joerg Roedel <joro@8bytes.org>
> > Cc: Lu Baolu <baolu.lu@linux.intel.com>
> > Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> > ---
> > v1 -> v2:
> > *) check the iommu_device to ensure the handling mdev is IOMMU-backed
> > ---
> >  drivers/vfio/vfio_iommu_type1.c | 39
> > +++++++++++++++++++++++++++++++++++----
> >  1 file changed, 35 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/vfio/vfio_iommu_type1.c
> > b/drivers/vfio/vfio_iommu_type1.c index 960cc59..f1f1ae2 100644
> > --- a/drivers/vfio/vfio_iommu_type1.c
> > +++ b/drivers/vfio/vfio_iommu_type1.c
> > @@ -2373,20 +2373,41 @@ static int vfio_iommu_resv_refresh(struct
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
> > -	return iommu_sva_bind_gpasid(dc->domain, dev, (void __user *)arg);
> > +	return iommu_sva_bind_gpasid(dc->domain, iommu_device,
> > +				     (void __user *)arg);
> >  }
> >
> >  static int vfio_dev_unbind_gpasid_fn(struct device *dev, void *data)
> > {
> >  	struct domain_capsule *dc = (struct domain_capsule *)data;
> >  	unsigned long arg = *(unsigned long *)dc->data;
> > +	struct device *iommu_device;
> >
> > -	iommu_sva_unbind_gpasid(dc->domain, dev, (void __user *)arg);
> > +	iommu_device = vfio_get_iommu_device(dc->group, dev);
> > +	if (!iommu_device)
> > +		return -EINVAL;
> > +
> > +	iommu_sva_unbind_gpasid(dc->domain, iommu_device,
> > +				(void __user *)arg);
> >  	return 0;
> >  }
> >
> > @@ -2395,8 +2416,13 @@ static int __vfio_dev_unbind_gpasid_fn(struct device
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
> > -	__iommu_sva_unbind_gpasid(dc->domain, dev, unbind_data);
> > +	__iommu_sva_unbind_gpasid(dc->domain, iommu_device, unbind_data);
> >  	return 0;
> >  }
> >
> > @@ -3077,8 +3103,13 @@ static int vfio_dev_cache_invalidate_fn(struct
> > device *dev, void *data)  {
> >  	struct domain_capsule *dc = (struct domain_capsule *)data;
> >  	unsigned long arg = *(unsigned long *)dc->data;
> > +	struct device *iommu_device;
> > +
> > +	iommu_device = vfio_get_iommu_device(dc->group, dev);
> > +	if (!iommu_device)
> > +		return -EINVAL;
> >
> > -	iommu_cache_invalidate(dc->domain, dev, (void __user *)arg);
> > +	iommu_cache_invalidate(dc->domain, iommu_device, (void __user
> > +*)arg);
> >  	return 0;
> >  }
> >
> >
> Besides,
> 
> Looks grood to me
> 
> Reviewed-by: Eric Auger <eric.auger@redhat.com>

thanks :-)

Regards,
Yi Liu

> Eric

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
