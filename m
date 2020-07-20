Return-Path: <SRS0=yPOf=A7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F28EBC433E3
	for <iommu@archiver.kernel.org>; Mon, 20 Jul 2020 07:26:17 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC3E6207DF
	for <iommu@archiver.kernel.org>; Mon, 20 Jul 2020 07:26:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="bvH607wX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC3E6207DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 86FAB86E1A;
	Mon, 20 Jul 2020 07:26:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id P68A2OB3jGAI; Mon, 20 Jul 2020 07:26:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id BF2C686DA3;
	Mon, 20 Jul 2020 07:26:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8963BC089F;
	Mon, 20 Jul 2020 07:26:16 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 765A7C016F
 for <iommu@lists.linux-foundation.org>; Mon, 20 Jul 2020 07:26:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 5F25F86DA3
 for <iommu@lists.linux-foundation.org>; Mon, 20 Jul 2020 07:26:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id j3V-0yvqYjap for <iommu@lists.linux-foundation.org>;
 Mon, 20 Jul 2020 07:26:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 436D186DCA
 for <iommu@lists.linux-foundation.org>; Mon, 20 Jul 2020 07:26:14 +0000 (UTC)
IronPort-SDR: r+DToc+VgDMycDu49KPSx6L5R7xOuzdkUedaE6b/wan7hitonMqs8QAWOOdGQ3YUogHGJS1c7n
 f53gW/joc07g==
X-IronPort-AV: E=McAfee;i="6000,8403,9687"; a="151210405"
X-IronPort-AV: E=Sophos;i="5.75,374,1589266800"; d="scan'208";a="151210405"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jul 2020 00:26:13 -0700
IronPort-SDR: gGJGoEet6hHRDf439fPoMRRwb9wYMJrfHeOJR2TmvVCFY57lv07xTJ6BMhN+/kmNuKJzJ2nCuQ
 Ka2w2G3kxjBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,374,1589266800"; d="scan'208";a="319439673"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
 by fmsmga002.fm.intel.com with ESMTP; 20 Jul 2020 00:26:13 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 20 Jul 2020 00:26:13 -0700
Received: from FMSEDG001.ED.cps.intel.com (10.1.192.133) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 20 Jul 2020 00:26:13 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (104.47.46.51) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (TLS) id 14.3.439.0; Mon, 20 Jul 2020 00:26:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bGsx8lUyKPTVP1+ALGXXK/Dc3GePR/1UtjY0rpq5uCBjB63zDmKzFtOPNeFmHeLe9RQowV2NJOVIS7AazmaUsddyGtVyTUSQF1CxT0jidiJ4yWcwKC6+h3pXNrA+jGHE88p2cLNdmUD0ub+6I6nFzoT0R2LFJ8E2DGLkTpRrSyjrT/EDY0QcwtbimxvsdtRUEHZqEdEt7V1CnUIQEHnNJz1L43Ufn0u6Kp29jFRB0e2EpQ6pbE7zpQYDdSu97MtCHmMCpK0NPnPE98V7ztoM/bA7R3SHcLENuG5vdbt9DS7m8KbOwQi+PpK9UYreGVuy6c2oKMp7TMs2VzMp5nmfHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qy/sMhRYB+WN7aAeagfUO4zW6pX7UdFKCrkSmrSUd78=;
 b=H64+2Ti/mJ+IQASO0dgrqPfpZTH1e0h504aZFwrfPJUpyW89IKAAh8bMeiskozO4wlk86j6lVMFXAhIteKk/STWENt9/AvN1DknM8yE1EVCrYbvg4Hj+bM6h05GkfLhrbVXz76aSzR7NoT6GcKDlWqnF9L46SOZ8HWjGoRIUNI0RWp7w33sLa/NYL2X0tyuHoO1JMXyhsYjgEXFXZlt8v8GQx0glF/ejPgbeyaydjb5tbJTAPO7bZ249PcSCX168BdNd/A7bT40kqlCrabIf78lFDQxtbiBJp5VGIeh5T/akfctbhWkDCzKOycfQWX6X+kMWDTcK2srDjwhxSGLU8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qy/sMhRYB+WN7aAeagfUO4zW6pX7UdFKCrkSmrSUd78=;
 b=bvH607wXDYquHXKjjaxkp4BvsuxLd7czIu4UWpponHSiKpJWGBPSETt3hkxIYzfMANgKfGS20v7K8GLN++dC4q/j/Tcf7fmnPgdItvLzxVtDPB9n3H1NvIbo2i3avonpAoYMl4Fzd215TY/Es2tTVwm23GbXALhJU//JFFKklFQ=
Received: from DM5PR11MB1435.namprd11.prod.outlook.com (2603:10b6:4:7::18) by
 DM6PR11MB4722.namprd11.prod.outlook.com (2603:10b6:5:2a7::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3195.23; Mon, 20 Jul 2020 07:26:05 +0000
Received: from DM5PR11MB1435.namprd11.prod.outlook.com
 ([fe80::9002:97a2:d8c0:8364]) by DM5PR11MB1435.namprd11.prod.outlook.com
 ([fe80::9002:97a2:d8c0:8364%10]) with mapi id 15.20.3195.025; Mon, 20 Jul
 2020 07:26:05 +0000
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: Auger Eric <eric.auger@redhat.com>, "alex.williamson@redhat.com"
 <alex.williamson@redhat.com>, "baolu.lu@linux.intel.com"
 <baolu.lu@linux.intel.com>, "joro@8bytes.org" <joro@8bytes.org>
Subject: RE: [PATCH v5 03/15] iommu/smmu: Report empty domain nesting info
Thread-Topic: [PATCH v5 03/15] iommu/smmu: Report empty domain nesting info
Thread-Index: AQHWWD2lVc+q/avNRU2WMQZyTvsTFakMDAeAgAQRYnA=
Date: Mon, 20 Jul 2020 07:26:05 +0000
Message-ID: <DM5PR11MB143577DE3526B1BA09A99326C37B0@DM5PR11MB1435.namprd11.prod.outlook.com>
References: <1594552870-55687-1-git-send-email-yi.l.liu@intel.com>
 <1594552870-55687-4-git-send-email-yi.l.liu@intel.com>
 <5ee6b661-9c46-20ee-332a-1a449b6f3a43@redhat.com>
In-Reply-To: <5ee6b661-9c46-20ee-332a-1a449b6f3a43@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.147.200]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bb7192c7-53a5-4cc1-9b8e-08d82c7e2a3e
x-ms-traffictypediagnostic: DM6PR11MB4722:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB4722608E062C33321315D6F0C37B0@DM6PR11MB4722.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:660;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WzmFWBCwYRGKjJ5/+pOwLdac9TRPBWqGI3wht+JLN40hjHIv2q67jE+ThmwHFJ3Nia/3aYQxs+/JG2qXVc8bfJzPqdsmMV0ZGjz0MUwkk96etBv2j1xuj5LYsdZ8gkkfmd13DBX1wRn8gqh+HPSVcAbytHNsbe4m847wZVr/fnwrBOEaRbWB2SxLVYdNnziGIPkB1k7h29jSklBBttKyivqgrpjEaMbqqYfUZGOQSRA1be5ABaznLIx4vM3/Ei0FK3CU67uWs3NenMMuAhuAUB/NUsAcJk4YmSpdRhTXlK8jduoaVy+mt53IqvR+UejXXx5dEq9ZM+2KXPvzjR/qRg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR11MB1435.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(366004)(136003)(396003)(376002)(39860400002)(6506007)(53546011)(52536014)(26005)(33656002)(186003)(5660300002)(4326008)(316002)(478600001)(54906003)(110136005)(71200400001)(9686003)(2906002)(86362001)(55016002)(66446008)(64756008)(66476007)(76116006)(66946007)(66556008)(7696005)(8676002)(83380400001)(8936002)(7416002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: 9thVEy+/jwHsQKPagTzxEfEsIqP3RMLwZ2aLafGliQrqNTXVLSqffszLNGDjLQeb1dZ1RyHozPV5P9L/e7zSaCzZ1/NK+yCB490ZwEyXK+oamcHnbGM2Sg82dCmfyaNZrZ9zlzFGU8v25JfJqklbaUa6T5ZovxvhBhhrAz2/d3FmYvdD4+HJ/mmmXKLZmJt/a0dtYUUhH3hKIvvITeV8OKtsxfhyL8TiZr7X6vzj+ykCfukIJGsYiz/uEiHK0UpVKk+fqebExCWucsGuXOEG/tZBbZjnt8GT/ntQvbxqABRIggtZH77bZkEvVFmLzd1oalGkYeJtTJfVxRSm8c2Z7ntPw+Vy1Vd2jpc4V3mPKZX+Fr40QblOBWwLJZZPmj7suiH7Z6iCtBHCI1RocGDiBrLdZx5XFPNrMStXIPygqsnpB3pO/gnLotM41zY002nYTACMk/mDBkf1q5pkqae7He4Lb+2zog7/MKKrqKqCpqo9DVN4LXv5UFq4vqnSwDYe
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1435.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb7192c7-53a5-4cc1-9b8e-08d82c7e2a3e
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2020 07:26:05.7863 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ImGzk2KuGEzoVr6DtDa5W5cROKJjb5uvtkhKnmAN87hXjuATjSErMHWznOLvKCSauWuLkCgx+MP+ywrR3zM3Nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4722
X-OriginatorOrg: intel.com
Cc: "jean-philippe@linaro.org" <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "stefanha@gmail.com" <stefanha@gmail.com>, "Tian, 
 Jun J" <jun.j.tian@intel.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Sun,
 Yi Y" <yi.y.sun@intel.com>, Robin Murphy <robin.murphy@arm.com>,
 Will Deacon <will@kernel.org>, "Wu, Hao" <hao.wu@intel.com>
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
> 
> Yi,
> 
> On 7/12/20 1:20 PM, Liu Yi L wrote:
> > This patch is added as instead of returning a boolean for
> > DOMAIN_ATTR_NESTING,
> > iommu_domain_get_attr() should return an iommu_nesting_info handle.
> 
> you may add in the commit message you return an empty nesting info struct for now
> as true nesting is not yet supported by the SMMUs.

will do.

> Besides:
> Reviewed-by: Eric Auger <eric.auger@redhat.com>

thanks.

Regards,
Yi Liu

> Thanks
> 
> Eric
> >
> > Cc: Will Deacon <will@kernel.org>
> > Cc: Robin Murphy <robin.murphy@arm.com>
> > Cc: Eric Auger <eric.auger@redhat.com>
> > Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > Suggested-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > ---
> > v4 -> v5:
> > *) address comments from Eric Auger.
> > ---
> >  drivers/iommu/arm-smmu-v3.c | 29 +++++++++++++++++++++++++++--
> >  drivers/iommu/arm-smmu.c    | 29 +++++++++++++++++++++++++++--
> >  2 files changed, 54 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> > index f578677..ec815d7 100644
> > --- a/drivers/iommu/arm-smmu-v3.c
> > +++ b/drivers/iommu/arm-smmu-v3.c
> > @@ -3019,6 +3019,32 @@ static struct iommu_group
> *arm_smmu_device_group(struct device *dev)
> >  	return group;
> >  }
> >
> > +static int arm_smmu_domain_nesting_info(struct arm_smmu_domain
> *smmu_domain,
> > +					void *data)
> > +{
> > +	struct iommu_nesting_info *info = (struct iommu_nesting_info *)data;
> > +	unsigned int size;
> > +
> > +	if (!info || smmu_domain->stage != ARM_SMMU_DOMAIN_NESTED)
> > +		return -ENODEV;
> > +
> > +	size = sizeof(struct iommu_nesting_info);
> > +
> > +	/*
> > +	 * if provided buffer size is smaller than expected, should
> > +	 * return 0 and also the expected buffer size to caller.
> > +	 */
> > +	if (info->size < size) {
> > +		info->size = size;
> > +		return 0;
> > +	}
> > +
> > +	/* report an empty iommu_nesting_info for now */
> > +	memset(info, 0x0, size);
> > +	info->size = size;
> > +	return 0;
> > +}
> > +
> >  static int arm_smmu_domain_get_attr(struct iommu_domain *domain,
> >  				    enum iommu_attr attr, void *data)  { @@ -
> 3028,8 +3054,7 @@
> > static int arm_smmu_domain_get_attr(struct iommu_domain *domain,
> >  	case IOMMU_DOMAIN_UNMANAGED:
> >  		switch (attr) {
> >  		case DOMAIN_ATTR_NESTING:
> > -			*(int *)data = (smmu_domain->stage ==
> ARM_SMMU_DOMAIN_NESTED);
> > -			return 0;
> > +			return arm_smmu_domain_nesting_info(smmu_domain,
> data);
> >  		default:
> >  			return -ENODEV;
> >  		}
> > diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c index
> > 243bc4c..09e2f1b 100644
> > --- a/drivers/iommu/arm-smmu.c
> > +++ b/drivers/iommu/arm-smmu.c
> > @@ -1506,6 +1506,32 @@ static struct iommu_group
> *arm_smmu_device_group(struct device *dev)
> >  	return group;
> >  }
> >
> > +static int arm_smmu_domain_nesting_info(struct arm_smmu_domain
> *smmu_domain,
> > +					void *data)
> > +{
> > +	struct iommu_nesting_info *info = (struct iommu_nesting_info *)data;
> > +	unsigned int size;
> > +
> > +	if (!info || smmu_domain->stage != ARM_SMMU_DOMAIN_NESTED)
> > +		return -ENODEV;
> > +
> > +	size = sizeof(struct iommu_nesting_info);
> > +
> > +	/*
> > +	 * if provided buffer size is smaller than expected, should
> > +	 * return 0 and also the expected buffer size to caller.
> > +	 */
> > +	if (info->size < size) {
> > +		info->size = size;
> > +		return 0;
> > +	}
> > +
> > +	/* report an empty iommu_nesting_info for now */
> > +	memset(info, 0x0, size);
> > +	info->size = size;
> > +	return 0;
> > +}
> > +
> >  static int arm_smmu_domain_get_attr(struct iommu_domain *domain,
> >  				    enum iommu_attr attr, void *data)  { @@ -
> 1515,8 +1541,7 @@
> > static int arm_smmu_domain_get_attr(struct iommu_domain *domain,
> >  	case IOMMU_DOMAIN_UNMANAGED:
> >  		switch (attr) {
> >  		case DOMAIN_ATTR_NESTING:
> > -			*(int *)data = (smmu_domain->stage ==
> ARM_SMMU_DOMAIN_NESTED);
> > -			return 0;
> > +			return arm_smmu_domain_nesting_info(smmu_domain,
> data);
> >  		default:
> >  			return -ENODEV;
> >  		}
> >

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
