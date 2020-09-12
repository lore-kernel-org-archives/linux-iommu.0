Return-Path: <SRS0=7x6w=CV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44EF8C43461
	for <iommu@archiver.kernel.org>; Sat, 12 Sep 2020 07:17:41 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C46C82158C
	for <iommu@archiver.kernel.org>; Sat, 12 Sep 2020 07:17:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="x4tMLA6Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C46C82158C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 69031876BD;
	Sat, 12 Sep 2020 07:17:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6TIz8fiP7Xsd; Sat, 12 Sep 2020 07:17:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 334518769B;
	Sat, 12 Sep 2020 07:17:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EB5B4C0052;
	Sat, 12 Sep 2020 07:17:38 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2377EC0051
 for <iommu@lists.linux-foundation.org>; Sat, 12 Sep 2020 07:17:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 125678781D
 for <iommu@lists.linux-foundation.org>; Sat, 12 Sep 2020 07:17:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AAMaNeKuVaV3 for <iommu@lists.linux-foundation.org>;
 Sat, 12 Sep 2020 07:17:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 7220487810
 for <iommu@lists.linux-foundation.org>; Sat, 12 Sep 2020 07:17:36 +0000 (UTC)
IronPort-SDR: ydAvCjI7Fy6od2yNrObNUveAWe0YU5/F0m83WTx6qJ8ZxUFYLKgKT/uVu3mMs4ZCpy/GSqJF4H
 a9ACynx2IWaQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9741"; a="220452926"
X-IronPort-AV: E=Sophos;i="5.76,419,1592895600"; d="scan'208";a="220452926"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Sep 2020 00:17:35 -0700
IronPort-SDR: 7moUXU4ikPVV/iSIElD21lAlxkVcSICFulFQhL5ZQDNolr5F1y5Qi+ehrxTg3iD+pIaQ7oZbAb
 a3b3qRrYobYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,419,1592895600"; d="scan'208";a="344852781"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
 by orsmga007.jf.intel.com with ESMTP; 12 Sep 2020 00:17:32 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sat, 12 Sep 2020 00:17:31 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sat, 12 Sep 2020 00:17:30 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Sat, 12 Sep 2020 00:17:30 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.174)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Sat, 12 Sep 2020 00:17:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mXXTz/Rl0FWRB5wjg6pZWwfKazgQ3o1glRXavyVzwqH2M/eAj8zDLVs61Abdf0ae8Twf2+KbbisIN9HKtw2QX5Por/6CSdl6QgkvucbfwJPhMbB3WfOFy5bgKXOESh+MiAPs1m3DIB9oLo7rZg6/kJIvauuyUOPeC21PeIL0il7FKNImYQR8bjeBZu8a0/PDP8fCKY43WBaM8AZf1bf8WvKFDTgw/kTgsy6PkN1Igd8DWx6n5Db2Hx0fjqckexURz9HgfRzxanZLvk91rDnkVuBTnRg5OrkqrwREgiDR3myFDNDhcF9skrZsbU2RXWj43YZeosNbOmxOKtu6fXrWXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xWqLgjOgFyRluOPLcTVvzpnCgIObryxpS69QZCI81D8=;
 b=LyP5iJuPVMp15/6TspumVbza5HzK9KyBtU/1HeRjgBK65fyTK8eZCrGnxKY009QvtKVqd337687jjTT+wawMrPIq+1M/wfkrzZKjvX7+iflp3noAJ9DZLzqC98NpXFYz6D546qAOX4uMEksuVdkW6ZKY+8Q1Ue/174AQtnQi0KgaULiPtqaDEO3pHLwOlx7ANG1g4/X9wydl0VGwLfUB0FZm58P8hQGJBEQR5Ph+SZwzZQP2DA79cU7zRwLuITbewdS8IAUGs5HxzlTDS2ZUjvDzwemDJE8jxIahdQpUMl/30LHhca1xtg9J+L9BgqKbgexRba7dfFkECYYKnhbAVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xWqLgjOgFyRluOPLcTVvzpnCgIObryxpS69QZCI81D8=;
 b=x4tMLA6YPBfXSNa10HzBZnY+WIi3X25nXvaXx57BdHidIOI+Pf03rLLR3+1/DE89OnfQWkXQSdxHlJaUaJkotz96g3bngF1pr7uUP3nN+6zmBC4B8hj7JGcySCZPUlnttVhNo+GwgOQNBmph3ljzkxH020eb2FS7PWHRc9z/hQk=
Received: from DM5PR11MB1435.namprd11.prod.outlook.com (2603:10b6:4:7::18) by
 DM5PR11MB1692.namprd11.prod.outlook.com (2603:10b6:3:d::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3370.16; Sat, 12 Sep 2020 07:17:28 +0000
Received: from DM5PR11MB1435.namprd11.prod.outlook.com
 ([fe80::7053:1185:558b:bc54]) by DM5PR11MB1435.namprd11.prod.outlook.com
 ([fe80::7053:1185:558b:bc54%9]) with mapi id 15.20.3370.017; Sat, 12 Sep 2020
 07:17:28 +0000
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: RE: [PATCH v7 13/16] vfio/pci: Expose PCIe PASID capability to guest
Thread-Topic: [PATCH v7 13/16] vfio/pci: Expose PCIe PASID capability to guest
Thread-Index: AQHWh19BL/4KVSMUYUyyxt1419EQD6lkArqAgACXU1A=
Date: Sat, 12 Sep 2020 07:17:28 +0000
Message-ID: <DM5PR11MB14355B145856AB30D3F938D6C3250@DM5PR11MB1435.namprd11.prod.outlook.com>
References: <1599734733-6431-1-git-send-email-yi.l.liu@intel.com>
 <1599734733-6431-14-git-send-email-yi.l.liu@intel.com>
 <20200911161311.13999a57@w520.home>
In-Reply-To: <20200911161311.13999a57@w520.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [114.244.141.194]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8f3c6d31-f72b-4a3c-d6a7-08d856ebe836
x-ms-traffictypediagnostic: DM5PR11MB1692:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR11MB169250F6FC61197B70603B1BC3250@DM5PR11MB1692.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:758;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jymuxbhEyJcBuLP8/qtN9CSdCHNVWk7oIDDbbx94O8WXywtSD43WtYoX1HkGNCJG4jRO7Cyak8UBiNHYLuufV60Ig3PpuXhkivL4ZrSadBnrnjOhcu879zULuSz1VZetmH2dAv/UqTBa4plbOowUAnX0UG05f0Lvlw8zkbc0ai+ejl9bffEMJHGPxJYmz1j+5dl/8N9BRpN9Y//CdUcfYRTVtwtTr9FfYSxmdkOhuhSEB4Ipv0Gk2qjMufMUCxDX8Ch86HKSrOHEIuIsREluzwADGiMkClRc4lzxvevCfPLNUXQL4RHVKqtQl/I7kr1HlnVwP5nCo86MLeche3ncMQr8RkVwV2DaIl9SFIO+m4HVAY0wBCGDURByAm8yRzJv+K1UQjGT8onEGvDanRl3Bw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR11MB1435.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(136003)(366004)(346002)(376002)(186003)(7416002)(9686003)(71200400001)(316002)(33656002)(8676002)(55016002)(52536014)(478600001)(26005)(6506007)(54906003)(4326008)(7696005)(6916009)(8936002)(966005)(83380400001)(66446008)(66946007)(66556008)(64756008)(2906002)(66476007)(5660300002)(86362001)(76116006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: e+YxQHPlJi4Z+F3kWWDMmLcTJQIDgPlUe8yzSal9XnE/uzDsZUWLPkuJsfo39aUs4W5+99gkpTIqTrhO+j+kTg/PuuMvWGRAcTeJ3v3uK9fCf1aT1KO4OIuIjWe/4VxBUUMLqgeDbKRDDOAqqSU1bZJ5JKCfBbYentuNpLQJaRkc5QRPB9g91KdsoJuZy67Tatikii33t5uU9TMKF3DWxbJ2173M71aap5y7JU3CXPM7bUcKaU3sJKu2VsDY1zrYc+oem4dD5AwVyRI3ije4geQqg0i/aImGRzCtCNav+GZS5axkmoZpGJy00pvTt+kpoh8y9uap926Akk9npW7pPKeQVBAn3MvB9DdzZiM084ijplIXKbyaRZ4yVMDTCMB90YyCRjWcAAAG8tamgNbZ/wIVhtX7ZGejYEPpvVjqXaA39tor6+se7eNKWkwmqv8uLyqcy/iUcu06SFbIld3daQp82y7IIcIM1iNV8wG68RVqx67Li81G10CacPtwbpn2pHMKnLZ0lHMxscapnFeyS3NWoSkrCpWxmn3xaYiN1YMRPnCM6gyD3qrRhMzP2PyGydH2e591Xbw9JcuxAmgxjFm7QJtyEZrZrfe7ZFwWSvYNN9Gs2SNnoN+SfS6ChdkROBfC/S2gYFk7tfcWNvGz1g==
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1435.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f3c6d31-f72b-4a3c-d6a7-08d856ebe836
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2020 07:17:28.4097 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KOWfrx0MCRug1LwyFlAj2fY9av8fUgZ7eh05cAkRFami790Ja29s4uJdvBDCpdRy1WITB88WvkP1vzr2kq8iBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1692
X-OriginatorOrg: intel.com
Cc: "jean-philippe@linaro.org" <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "stefanha@gmail.com" <stefanha@gmail.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Sun,
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
> Sent: Saturday, September 12, 2020 6:13 AM
> 
> On Thu, 10 Sep 2020 03:45:30 -0700
> Liu Yi L <yi.l.liu@intel.com> wrote:
> 
> > This patch exposes PCIe PASID capability to guest for assigned devices.
> > Existing vfio_pci driver hides it from guest by setting the capability
> > length as 0 in pci_ext_cap_length[].
> 
> This exposes the PASID capability, but it's still read-only, so this largely just helps
> userspace know where to emulate the capability, right?  Thanks,

oh, yes. This path only makes it visible to userspace. perhaps, I should
refine the commit message and the patch name. right?

Regards,
Yi Liu

> Alex
> 
> > And this patch only exposes PASID capability for devices which has
> > PCIe PASID extended struture in its configuration space. VFs will not
> > expose the PASID capability as they do not implement the PASID
> > extended structure in their config space. It is a TODO in future.
> > Related discussion can be found in below link:
> >
> > https://lore.kernel.org/kvm/20200407095801.648b1371@w520.home/
> >
> > Cc: Kevin Tian <kevin.tian@intel.com>
> > CC: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > Cc: Alex Williamson <alex.williamson@redhat.com>
> > Cc: Eric Auger <eric.auger@redhat.com>
> > Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > Cc: Joerg Roedel <joro@8bytes.org>
> > Cc: Lu Baolu <baolu.lu@linux.intel.com>
> > Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> > Reviewed-by: Eric Auger <eric.auger@redhat.com>
> > ---
> > v5 -> v6:
> > *) add review-by from Eric Auger.
> >
> > v1 -> v2:
> > *) added in v2, but it was sent in a separate patchseries before
> > ---
> >  drivers/vfio/pci/vfio_pci_config.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/vfio/pci/vfio_pci_config.c
> > b/drivers/vfio/pci/vfio_pci_config.c
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

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
