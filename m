Return-Path: <SRS0=yPOf=A7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4D60C433DF
	for <iommu@archiver.kernel.org>; Mon, 20 Jul 2020 13:00:24 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70D15207FC
	for <iommu@archiver.kernel.org>; Mon, 20 Jul 2020 13:00:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="PkpoY4R+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70D15207FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 21CD72050E;
	Mon, 20 Jul 2020 13:00:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7A-7UzU+czRd; Mon, 20 Jul 2020 13:00:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id C28792042B;
	Mon, 20 Jul 2020 13:00:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ACF89C0894;
	Mon, 20 Jul 2020 13:00:21 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6CB58C016F
 for <iommu@lists.linux-foundation.org>; Mon, 20 Jul 2020 13:00:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 6672185BDF
 for <iommu@lists.linux-foundation.org>; Mon, 20 Jul 2020 13:00:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id s8qyx1O384nL for <iommu@lists.linux-foundation.org>;
 Mon, 20 Jul 2020 13:00:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 21D2785BB0
 for <iommu@lists.linux-foundation.org>; Mon, 20 Jul 2020 13:00:18 +0000 (UTC)
IronPort-SDR: mcQ7+Il7MEIalY6ss1GBk6X8EQcDW//N4VhUB2TKiIm5E1EhlRToBZvC3cm1wFKuQPmV4ZFrE6
 VPc4rcjOOALQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9687"; a="234753154"
X-IronPort-AV: E=Sophos;i="5.75,375,1589266800"; d="scan'208";a="234753154"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jul 2020 06:00:17 -0700
IronPort-SDR: JdONsuqgKYK9ARt2Nm5PMCXYydE8D7eK71cXjB3AvmL0zo7Fhg12DhoWVVKJAAIH7QcHRgJOr9
 dRUC7R3Sugyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,375,1589266800"; d="scan'208";a="487233624"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by fmsmga006.fm.intel.com with ESMTP; 20 Jul 2020 06:00:17 -0700
Received: from orsmsx605.amr.corp.intel.com (10.22.229.18) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 20 Jul 2020 06:00:16 -0700
Received: from ORSEDG001.ED.cps.intel.com (10.7.248.4) by
 orsmsx605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 20 Jul 2020 06:00:16 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 20 Jul 2020 06:00:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yf+18PMfJsbw4dZuSXjVePkEHZVlferIuJitLFSF3OCP+/OCtPw9QRW7v4dnrl04HJADVi8Le5SRitum8BGD4JkOmutHwzRpB3BwyNddDJt9l888o96GzBAggjWKRPlK43Hv4dX2184zEKnt3xq61i23/0kxeO+lsmXIJi6lZCWYG5x0W4xhmE2f8CxOYQE6ZnH52+fBOXASgQiQUqWIfdY/lob5Cy+9q8m/Vu/iBXScM4fPRxX3etaJEYQShiZi7edZWf7FYfGb/54gPCV3ab3epmwj6CHe7HAI78iIZ+PMJk/1CdbLYnujr5o9PPpjVXcMMz6R5US2FgZXi34y3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pl8vfuW0QH9mxKLIpUOPIjA/vdzixjdaQkifaEZrr0Q=;
 b=nL7Ormy+xRAISx+Roxr2DrNh2KwOhXOqqmJ9o/o+MorkFEYDIEB12XF4gFoiGtEOOIZCEHkFNM9oSA948sI48e94i7zTGOWJBWBs60MSW6x/po42oqG6WJR2RGs5ofelXjk0uTXAX3fPfjHcztkesdOs/hkUjd0AzTnQEJx1pZRcWNbnLsveqSqCp+QlLnr+WR+4BdqEkZE5cE3imXzDT5M7Ssehw/6Fpxc5VoQIxwzzrNLDy7+nOYrF11Y+FTO4a0NIftA9eXffPZcZ5gERw7fa5J+FSlpEu47f82Rt+hYhPLB6rCjVLzI3VbvRw7mTouiuIt33bOb4mdt3Xf1/PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pl8vfuW0QH9mxKLIpUOPIjA/vdzixjdaQkifaEZrr0Q=;
 b=PkpoY4R+Zlepu51AEOBJ0JEiIf1SCNor/ZhYAjEB22QR2VsXUce75nfOdkdQRcyI224N4PRyZBsHOMWX2VODYCUsyTPy1LnQnACx3GOs/3eydoNbxv9NstYTmCkGayurLGloXqOW/gSnasTrKDNDwhqfVIyxkugC5A0+QNoGNiY=
Received: from DM5PR11MB1435.namprd11.prod.outlook.com (2603:10b6:4:7::18) by
 DM6PR11MB3291.namprd11.prod.outlook.com (2603:10b6:5:d::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.21; Mon, 20 Jul 2020 13:00:14 +0000
Received: from DM5PR11MB1435.namprd11.prod.outlook.com
 ([fe80::9002:97a2:d8c0:8364]) by DM5PR11MB1435.namprd11.prod.outlook.com
 ([fe80::9002:97a2:d8c0:8364%10]) with mapi id 15.20.3195.025; Mon, 20 Jul
 2020 13:00:14 +0000
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: Auger Eric <eric.auger@redhat.com>, "alex.williamson@redhat.com"
 <alex.williamson@redhat.com>, "baolu.lu@linux.intel.com"
 <baolu.lu@linux.intel.com>, "joro@8bytes.org" <joro@8bytes.org>
Subject: RE: [PATCH v5 13/15] vfio/pci: Expose PCIe PASID capability to guest
Thread-Topic: [PATCH v5 13/15] vfio/pci: Expose PCIe PASID capability to guest
Thread-Index: AQHWWD2mzUJ6HDvde0eWOdamhXnigKkQdAEAgAAFwTA=
Date: Mon, 20 Jul 2020 13:00:14 +0000
Message-ID: <DM5PR11MB143507550E22674C76F881C0C37B0@DM5PR11MB1435.namprd11.prod.outlook.com>
References: <1594552870-55687-1-git-send-email-yi.l.liu@intel.com>
 <1594552870-55687-14-git-send-email-yi.l.liu@intel.com>
 <63d4c058-246d-1a11-af66-e97fd5ec9bd3@redhat.com>
In-Reply-To: <63d4c058-246d-1a11-af66-e97fd5ec9bd3@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.102.204.38]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c8ca0755-aa8b-4b5e-6882-08d82cacd863
x-ms-traffictypediagnostic: DM6PR11MB3291:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB3291275FA30F671FE9B7CA08C37B0@DM6PR11MB3291.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HKKCqVwlviiGLSmzV3rN1h/ReiT76kTDrpgDHVu3kQ6vNQGd2YHiQDI66FOHeM6HSmB4Nt9FoYOipftkyF1QdpfeITjAlFi5DhsjAhIZueljH+j4fA+INGtvssRQrxnsCry6qhIdYnx64NuqjmPI3nze1XTe5/EGCrME8lAN9KwwMXyJBNV5CRcPLzvZh4+FApePioWxFOb+5Rp8mYtEUd4OPVbzIesR/C6X5GIS+JV+F4gk5IvE1jh0VcaGcgYYdX7eCJ69uID+QRwu9LoTanoBX1D0k9a/Of6E+I0YKR8LSgPxdB+Kj+KRbzjuIvpKSDdQwqAXx+pz+guDfWAZVq/dJnvU7VWqkigq57p997ckpp4EM1MCB9KdF4+l7IEHnYP9OKAh+g09vOaWgtau6Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR11MB1435.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(346002)(396003)(376002)(136003)(39860400002)(76116006)(186003)(55016002)(66446008)(66476007)(66946007)(33656002)(86362001)(9686003)(478600001)(26005)(966005)(64756008)(4326008)(66556008)(6506007)(8676002)(83380400001)(71200400001)(316002)(5660300002)(110136005)(53546011)(7416002)(2906002)(8936002)(54906003)(7696005)(52536014);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: SzWF5Z9wFc00rDUGYoJt2V+tQJ1zPcWAj4/X608guE2atZ7BUD00gyfj5VeHihLrKVlqN9JdwhIXtRirkOx0fcPqWFLzWRZh77bL4N2UnJiAmilo9PI65yP3/WZGdCbgqgnC2ghNOCV3X1i3YWbGxppH3wIBO+9oyOUJvYztoTVL2lOwy89a+hPux63DiTNVvmPYdF0Z9dI4SSYtdMrniVBWNGDaelLMzjR2ACLcjXQeGplUJzuxHTrioNYoCesuBIKh/TACvqngYmXfx0z3ifHDDaESh+6Wb8Zi6m1M9lFRY2CoUQNstzTeMLL5vMiAGyxNx2f90U01Xu5rUD3QLMA6pDGGvk4YtqELqPhH0PzQb9jy0fj5VP1wy6K79cVW4OlKOdoUTXFYxXJ1ecshZgfLrBHNxWrweCXjDqmAy6N2gjvaYVYd8T4jy0rn0zEWlvIY3viAxyBFKGy14LUfohy3YIeY4YuTU58uusgVByrW0jT5nZrJbfl1E29EbMMH
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1435.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8ca0755-aa8b-4b5e-6882-08d82cacd863
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2020 13:00:14.8646 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TQM8XteiVfkYXoP7W6bS65U1x9T/bar0F0I9EWiRT9kgjrRLC9cEwveO28eXybFWIZCIzSsMs8MBjuhReW7BCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3291
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

> From: Auger Eric <eric.auger@redhat.com>
> Sent: Monday, July 20, 2020 8:35 PM
> 
> Yi,
> 
> On 7/12/20 1:21 PM, Liu Yi L wrote:
> > This patch exposes PCIe PASID capability to guest for assigned devices.
> > Existing vfio_pci driver hides it from guest by setting the capability
> > length as 0 in pci_ext_cap_length[].
> >
> > And this patch only exposes PASID capability for devices which has PCIe
> > PASID extended struture in its configuration space. So VFs, will will
> s/will//

got it.

> > not see PASID capability on VFs as VF doesn't implement PASID extended
> suggested rewording: VFs will not expose the PASID capability as they do
> not implement the PASID extended structure in their config space?

make sense. will modify it.

> > structure in its configuration space. For VF, it is a TODO in future.
> > Related discussion can be found in below link:
> >
> > https://lkml.org/lkml/2020/4/7/693
> 
> >
> > Cc: Kevin Tian <kevin.tian@intel.com>
> > CC: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > Cc: Alex Williamson <alex.williamson@redhat.com>
> > Cc: Eric Auger <eric.auger@redhat.com>
> > Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > Cc: Joerg Roedel <joro@8bytes.org>
> > Cc: Lu Baolu <baolu.lu@linux.intel.com>
> > Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> > ---
> > v1 -> v2:
> > *) added in v2, but it was sent in a separate patchseries before
> > ---
> >  drivers/vfio/pci/vfio_pci_config.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/vfio/pci/vfio_pci_config.c b/drivers/vfio/pci/vfio_pci_config.c
> > index d98843f..07ff2e6 100644
> > --- a/drivers/vfio/pci/vfio_pci_config.c
> > +++ b/drivers/vfio/pci/vfio_pci_config.c
> > @@ -95,7 +95,7 @@ static const u16 pci_ext_cap_length[PCI_EXT_CAP_ID_MAX +
> 1] = {
> >  	[PCI_EXT_CAP_ID_LTR]	=	PCI_EXT_CAP_LTR_SIZEOF,
> >  	[PCI_EXT_CAP_ID_SECPCI]	=	0,	/* not yet */
> >  	[PCI_EXT_CAP_ID_PMUX]	=	0,	/* not yet */
> > -	[PCI_EXT_CAP_ID_PASID]	=	0,	/* not yet */
> > +	[PCI_EXT_CAP_ID_PASID]	=	PCI_EXT_CAP_PASID_SIZEOF,
> >  };
> >
> >  /*
> >
> Reviewed-by: Eric Auger <eric.auger@redhat.com>

thanks.

Regards,
Yi Liu

> Thanks
> 
> Eric

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
