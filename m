Return-Path: <SRS0=S+y3=AR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC46FC433E1
	for <iommu@archiver.kernel.org>; Mon,  6 Jul 2020 12:28:36 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4C2F206E6
	for <iommu@archiver.kernel.org>; Mon,  6 Jul 2020 12:28:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="WXJLh3YI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4C2F206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 66C8688A0D;
	Mon,  6 Jul 2020 12:28:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xSJvJn4tCYJe; Mon,  6 Jul 2020 12:28:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 0BEF188A0A;
	Mon,  6 Jul 2020 12:28:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E3829C0891;
	Mon,  6 Jul 2020 12:28:34 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 37EAAC016F
 for <iommu@lists.linux-foundation.org>; Mon,  6 Jul 2020 12:28:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 2434E25AD8
 for <iommu@lists.linux-foundation.org>; Mon,  6 Jul 2020 12:28:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id A+am+y4FR6Qn for <iommu@lists.linux-foundation.org>;
 Mon,  6 Jul 2020 12:28:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by silver.osuosl.org (Postfix) with ESMTPS id ED00D25AC3
 for <iommu@lists.linux-foundation.org>; Mon,  6 Jul 2020 12:28:30 +0000 (UTC)
IronPort-SDR: oMTLxzpz3z+Xw3rJN5njTN9v1sxeH6BhXtPHNnMPwVVZoDJslfjrbGR4UMIXZzAGqGvqNESlcv
 i+x7Md2i96RQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9673"; a="232253276"
X-IronPort-AV: E=Sophos;i="5.75,318,1589266800"; d="scan'208";a="232253276"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jul 2020 05:28:30 -0700
IronPort-SDR: vXwojdEXOpj+Qevv2B+CudT13PNp6Bl4l359VdAl8rKopFCsKlFlzoNWqpH21bUfgPId+mdmpv
 ZcuogUMbODWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,318,1589266800"; d="scan'208";a="322367707"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
 by FMSMGA003.fm.intel.com with ESMTP; 06 Jul 2020 05:28:30 -0700
Received: from FMSMSX110.amr.corp.intel.com (10.18.116.10) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 6 Jul 2020 05:28:30 -0700
Received: from FMSEDG001.ED.cps.intel.com (10.1.192.133) by
 fmsmsx110.amr.corp.intel.com (10.18.116.10) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 6 Jul 2020 05:28:29 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.176)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Mon, 6 Jul 2020 05:28:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YRBnoJZV7LIeXIxRaXyfs1/abKIUPfryFh8+cuaAxBY0bfOAvdZaMNPc1hn1r5kPJJVsLVuWS42AIRHKy1UuiPKm/sfuPB2WgtbHW1OO0QB3zuGIlgyUkuEBEmnhNFHs3T9EQ5QOLtf2+CJgn/1rNupIiwzRuFBDkzOwtJeLBQZszLZ8vwyYGkXntzxxgE2CgGs+IMEpZclXbMTjww8zC0ea6QSeojT2sVPbVMhSvqfgUezrM8YiSAJGlMF7N/164wVr5pTayI+fowVF+Rd+NV/H18p+pgzBXt2ZlujhrB38XFP30ZAjVPAV2G4PRfiG014xQ5B7w9zL+nVEzwgRaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YnbMOFLfoEFebGPc748yAr2swf4UYhNAW53P5XzqKcg=;
 b=KEDuhz86sGfuWy0h4uwYvrrcLvnKSsaX5O1tR1KHTb4LWYeK7fQeR6ICdD97PfTU+UrSEkGU7Q8Uts/dxllEH+VyxAEnWsB9HiP6e7RgNuCbq1wNy8hAt/X7ogO+0TJHxPr+H2Vw8eM3vYqB8Mk0lmsdxNr9/ksnaXY0EGVq/aCqyfv3LD79lE4Ilk/iP/YBGp8ZDoFFepkkkplhJq8fU0SLYcRcQjEv+e4us8DY7dxmrr4fKkTg7Vc/8vPmrrNup5hARjS77UkIffUcmE7pnC+Jf8iQ+i3mwG/wMOVsi5iD7C/dzx4yV6f1XQfMaLHyPu/6qzEo76eUtIiOJDIzUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YnbMOFLfoEFebGPc748yAr2swf4UYhNAW53P5XzqKcg=;
 b=WXJLh3YIOyOklGQISOxbIZWpq/Tz45dCGIAxNcrCJcb1jwqzaYhUWOXKlPzudMHE2+atbGV9hf2hZavplnC1PQU7iXV6UEuweh5x69VxhOcrnUEKa4p73y/X5V6FfS6l+a6rcOUJkOGDoxlxHt4MLNjiPF6DsTD8fL/LllEg6WA=
Received: from DM5PR11MB1435.namprd11.prod.outlook.com (2603:10b6:4:7::18) by
 DM6PR11MB3420.namprd11.prod.outlook.com (2603:10b6:5:69::31) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3153.23; Mon, 6 Jul 2020 12:27:41 +0000
Received: from DM5PR11MB1435.namprd11.prod.outlook.com
 ([fe80::9002:97a2:d8c0:8364]) by DM5PR11MB1435.namprd11.prod.outlook.com
 ([fe80::9002:97a2:d8c0:8364%10]) with mapi id 15.20.3153.029; Mon, 6 Jul 2020
 12:27:41 +0000
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: Auger Eric <eric.auger@redhat.com>, "alex.williamson@redhat.com"
 <alex.williamson@redhat.com>, "baolu.lu@linux.intel.com"
 <baolu.lu@linux.intel.com>, "joro@8bytes.org" <joro@8bytes.org>
Subject: RE: [PATCH v4 01/15] vfio/type1: Refactor vfio_iommu_type1_ioctl()
Thread-Topic: [PATCH v4 01/15] vfio/type1: Refactor vfio_iommu_type1_ioctl()
Thread-Index: AQHWUfUZTaGhOIgs0kmjsvrJtAKWW6j6TVoAgAAuaYA=
Date: Mon, 6 Jul 2020 12:27:41 +0000
Message-ID: <DM5PR11MB14353D1D9476BE68C78B09FCC3690@DM5PR11MB1435.namprd11.prod.outlook.com>
References: <1593861989-35920-1-git-send-email-yi.l.liu@intel.com>
 <1593861989-35920-2-git-send-email-yi.l.liu@intel.com>
 <0622db04-8254-8068-e00a-4681ec8686a8@redhat.com>
In-Reply-To: <0622db04-8254-8068-e00a-4681ec8686a8@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.147.207]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5e8666eb-c0c0-49f9-2def-08d821a7fa51
x-ms-traffictypediagnostic: DM6PR11MB3420:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB342058D10DB79169C3E366ECC3690@DM6PR11MB3420.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:849;
x-forefront-prvs: 04569283F9
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: k44kEKp/3yooPpidPQneAVLG3oP0rghJbc7oOaiczxuzshkHfymY/ChYEj8fD2Agi6RDoEUL0afaau6tkZehoHMEdJW4nAi8dYKrMtW9I7MLazpbat0l1uWRtm4JgCPB63D+zSjNTxJ8REi1cIMUBJrLwSqcwZGKTACieY0wFnQhQDdzKMKlBZFtkywv1D2W0Z3s6Atm2TpI0sjZ12pETqFcn3q44XgT6gUE1Vr2qcQOIzqJuzvvfphAMLuE+AVy80krAR/+yQILw6ia6o/6vsnYbuOu1rMI53XpmExvRRTNIYRGENs4JTSNLExyD3ELPKZJceY/Q/IMMctY9FnGBA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR11MB1435.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(39860400002)(136003)(346002)(396003)(376002)(71200400001)(83380400001)(186003)(4326008)(52536014)(66946007)(8936002)(6506007)(66446008)(64756008)(66556008)(66476007)(76116006)(2906002)(53546011)(55016002)(9686003)(26005)(5660300002)(86362001)(316002)(110136005)(54906003)(7416002)(478600001)(30864003)(7696005)(33656002)(8676002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: IZuH9XZOA8C014Qmv+WbpkbGPoHXlrywZhQ7JsuHNtyCRzqZaExRikG1YlVqOjxYIw2hLHr6HsEpKpCMF1geeQVoOnIFGUUBULrHUPVqFGa+mhvpNkgrb9nEzzN2EXLLP8aIxJkjprotnGylgO70O3DFOyFkyQvAq8fQvu0XMasDz2zneX8o9vm2kpdJ6HoqLeFNmpiPpybzF5MxJQbhYo9DnXXIsUDjNHkfRanlgxoEDad49+CipCjduScxzWT6UTa6aKk9cmOlvnAc1MflCDdDFeWZDRmGfAQnk0wSHtCorJTGxjJMARZjNb40+qfU0Bh+FvItk13lmPs/bb5qvwp1fewmRbTVMpc93GIf2CjbZHaWQAIo8r+ae6pw9w3vAK95rOxvMcaC8SKJGl4CHEbo7PAnRaPRDniCUu53ZUSoQWjL9A0BfIhNEv3c1O47YFBojiT6W8n+mrGt56IyR25akgYLCFmHJRCgXpUlSZDdMc0c8+r/AZqwlVRnpDIt
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1435.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e8666eb-c0c0-49f9-2def-08d821a7fa51
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2020 12:27:41.4285 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HX+Hr2jSRDwMoal0uMY7c8dNOXZ9+DkDLk4Lo8J7N34njvw/Ovw8P2Cw+7YoUoTdGonxQ9tubPMabRTkFMJy8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3420
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
> Sent: Monday, July 6, 2020 5:34 PM
> 
> Hi Yi,
> 
> On 7/4/20 1:26 PM, Liu Yi L wrote:
> > This patch refactors the vfio_iommu_type1_ioctl() to use switch
> > instead of if-else, and each cmd got a helper function.
> command

I see. :-)

> >
> > Cc: Kevin Tian <kevin.tian@intel.com>
> > CC: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > Cc: Alex Williamson <alex.williamson@redhat.com>
> > Cc: Eric Auger <eric.auger@redhat.com>
> > Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > Cc: Joerg Roedel <joro@8bytes.org>
> > Cc: Lu Baolu <baolu.lu@linux.intel.com>
> > Suggested-by: Christoph Hellwig <hch@infradead.org>
> > Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> > ---
> >  drivers/vfio/vfio_iommu_type1.c | 392
> > ++++++++++++++++++++++------------------
> >  1 file changed, 213 insertions(+), 179 deletions(-)
> >
> > diff --git a/drivers/vfio/vfio_iommu_type1.c
> > b/drivers/vfio/vfio_iommu_type1.c index 5e556ac..7accb59 100644
> > --- a/drivers/vfio/vfio_iommu_type1.c
> > +++ b/drivers/vfio/vfio_iommu_type1.c
> > @@ -2453,6 +2453,23 @@ static int vfio_domains_have_iommu_cache(struct
> vfio_iommu *iommu)
> >  	return ret;
> >  }
> >
> > +static int vfio_iommu_type1_check_extension(struct vfio_iommu *iommu,
> > +					    unsigned long arg)
> > +{
> > +	switch (arg) {
> > +	case VFIO_TYPE1_IOMMU:
> > +	case VFIO_TYPE1v2_IOMMU:
> > +	case VFIO_TYPE1_NESTING_IOMMU:
> > +		return 1;
> > +	case VFIO_DMA_CC_IOMMU:
> > +		if (!iommu)
> > +			return 0;
> > +		return vfio_domains_have_iommu_cache(iommu);
> > +	default:
> > +		return 0;
> > +	}
> > +}
> > +
> >  static int vfio_iommu_iova_add_cap(struct vfio_info_cap *caps,
> >  		 struct vfio_iommu_type1_info_cap_iova_range *cap_iovas,
> >  		 size_t size)
> > @@ -2529,238 +2546,255 @@ static int vfio_iommu_migration_build_caps(struct
> vfio_iommu *iommu,
> >  	return vfio_info_add_capability(caps, &cap_mig.header,
> > sizeof(cap_mig));  }
> >
> > -static long vfio_iommu_type1_ioctl(void *iommu_data,
> > -				   unsigned int cmd, unsigned long arg)
> > +static int vfio_iommu_type1_get_info(struct vfio_iommu *iommu,
> > +				     unsigned long arg)
> >  {
> > -	struct vfio_iommu *iommu = iommu_data;
> > +	struct vfio_iommu_type1_info info;
> >  	unsigned long minsz;
> > +	struct vfio_info_cap caps = { .buf = NULL, .size = 0 };
> > +	unsigned long capsz;
> > +	int ret;
> >
> > -	if (cmd == VFIO_CHECK_EXTENSION) {
> > -		switch (arg) {
> > -		case VFIO_TYPE1_IOMMU:
> > -		case VFIO_TYPE1v2_IOMMU:
> > -		case VFIO_TYPE1_NESTING_IOMMU:
> > -			return 1;
> > -		case VFIO_DMA_CC_IOMMU:
> > -			if (!iommu)
> > -				return 0;
> > -			return vfio_domains_have_iommu_cache(iommu);
> > -		default:
> > -			return 0;
> > -		}
> > -	} else if (cmd == VFIO_IOMMU_GET_INFO) {
> > -		struct vfio_iommu_type1_info info;
> > -		struct vfio_info_cap caps = { .buf = NULL, .size = 0 };
> > -		unsigned long capsz;
> > -		int ret;
> > -
> > -		minsz = offsetofend(struct vfio_iommu_type1_info, iova_pgsizes);
> > +	minsz = offsetofend(struct vfio_iommu_type1_info, iova_pgsizes);
> >
> > -		/* For backward compatibility, cannot require this */
> > -		capsz = offsetofend(struct vfio_iommu_type1_info, cap_offset);
> > +	/* For backward compatibility, cannot require this */
> > +	capsz = offsetofend(struct vfio_iommu_type1_info, cap_offset);
> >
> > -		if (copy_from_user(&info, (void __user *)arg, minsz))
> > -			return -EFAULT;
> > +	if (copy_from_user(&info, (void __user *)arg, minsz))
> > +		return -EFAULT;
> >
> > -		if (info.argsz < minsz)
> > -			return -EINVAL;
> > +	if (info.argsz < minsz)
> > +		return -EINVAL;
> >
> > -		if (info.argsz >= capsz) {
> > -			minsz = capsz;
> > -			info.cap_offset = 0; /* output, no-recopy necessary */
> > -		}
> > +	if (info.argsz >= capsz) {
> > +		minsz = capsz;
> > +		info.cap_offset = 0; /* output, no-recopy necessary */
> > +	}
> >
> > -		mutex_lock(&iommu->lock);
> > -		info.flags = VFIO_IOMMU_INFO_PGSIZES;
> > +	mutex_lock(&iommu->lock);
> > +	info.flags = VFIO_IOMMU_INFO_PGSIZES;
> >
> > -		info.iova_pgsizes = iommu->pgsize_bitmap;
> > +	info.iova_pgsizes = iommu->pgsize_bitmap;
> >
> > -		ret = vfio_iommu_migration_build_caps(iommu, &caps);
> > +	ret = vfio_iommu_migration_build_caps(iommu, &caps);
> >
> > -		if (!ret)
> > -			ret = vfio_iommu_iova_build_caps(iommu, &caps);
> > +	if (!ret)
> > +		ret = vfio_iommu_iova_build_caps(iommu, &caps);
> >
> > -		mutex_unlock(&iommu->lock);
> > +	mutex_unlock(&iommu->lock);
> >
> > -		if (ret)
> > -			return ret;
> > +	if (ret)
> > +		return ret;
> >
> > -		if (caps.size) {
> > -			info.flags |= VFIO_IOMMU_INFO_CAPS;
> > +	if (caps.size) {
> > +		info.flags |= VFIO_IOMMU_INFO_CAPS;
> >
> > -			if (info.argsz < sizeof(info) + caps.size) {
> > -				info.argsz = sizeof(info) + caps.size;
> > -			} else {
> > -				vfio_info_cap_shift(&caps, sizeof(info));
> > -				if (copy_to_user((void __user *)arg +
> > -						sizeof(info), caps.buf,
> > -						caps.size)) {
> > -					kfree(caps.buf);
> > -					return -EFAULT;
> > -				}
> > -				info.cap_offset = sizeof(info);
> > +		if (info.argsz < sizeof(info) + caps.size) {
> > +			info.argsz = sizeof(info) + caps.size;
> > +		} else {
> > +			vfio_info_cap_shift(&caps, sizeof(info));
> > +			if (copy_to_user((void __user *)arg +
> > +					sizeof(info), caps.buf,
> > +					caps.size)) {
> > +				kfree(caps.buf);
> > +				return -EFAULT;
> >  			}
> > -
> > -			kfree(caps.buf);
> > +			info.cap_offset = sizeof(info);
> >  		}
> >
> > -		return copy_to_user((void __user *)arg, &info, minsz) ?
> > -			-EFAULT : 0;
> > +		kfree(caps.buf);
> > +	}
> >
> > -	} else if (cmd == VFIO_IOMMU_MAP_DMA) {
> > -		struct vfio_iommu_type1_dma_map map;
> > -		uint32_t mask = VFIO_DMA_MAP_FLAG_READ |
> > -				VFIO_DMA_MAP_FLAG_WRITE;
> > +	return copy_to_user((void __user *)arg, &info, minsz) ?
> > +			-EFAULT : 0;
> > +}
> >
> > -		minsz = offsetofend(struct vfio_iommu_type1_dma_map, size);
> > +static int vfio_iommu_type1_map_dma(struct vfio_iommu *iommu,
> > +				    unsigned long arg)
> > +{
> > +	struct vfio_iommu_type1_dma_map map;
> > +	unsigned long minsz;
> > +	uint32_t mask = VFIO_DMA_MAP_FLAG_READ |
> > +			VFIO_DMA_MAP_FLAG_WRITE;
> nit: may fit into a single line? other examples below.

yes, I can do it.

> >
> > -		if (copy_from_user(&map, (void __user *)arg, minsz))
> > -			return -EFAULT;
> > +	minsz = offsetofend(struct vfio_iommu_type1_dma_map, size);
> >
> > -		if (map.argsz < minsz || map.flags & ~mask)
> > -			return -EINVAL;
> > +	if (copy_from_user(&map, (void __user *)arg, minsz))
> > +		return -EFAULT;
> >
> > -		return vfio_dma_do_map(iommu, &map);
> > +	if (map.argsz < minsz || map.flags & ~mask)
> > +		return -EINVAL;
> >
> > -	} else if (cmd == VFIO_IOMMU_UNMAP_DMA) {
> > -		struct vfio_iommu_type1_dma_unmap unmap;
> > -		struct vfio_bitmap bitmap = { 0 };
> > -		int ret;
> > +	return vfio_dma_do_map(iommu, &map); }
> >
> > -		minsz = offsetofend(struct vfio_iommu_type1_dma_unmap, size);
> > +static int vfio_iommu_type1_unmap_dma(struct vfio_iommu *iommu,
> > +				      unsigned long arg)
> > +{
> > +	struct vfio_iommu_type1_dma_unmap unmap;
> > +	struct vfio_bitmap bitmap = { 0 };
> > +	unsigned long minsz;
> > +	long ret;
> int?

it is "long" in original code. do you want me to change it? I can do it
if it's preferred.

> >
> > -		if (copy_from_user(&unmap, (void __user *)arg, minsz))
> > -			return -EFAULT;
> > +	minsz = offsetofend(struct vfio_iommu_type1_dma_unmap, size);
> >
> > -		if (unmap.argsz < minsz ||
> > -		    unmap.flags & ~VFIO_DMA_UNMAP_FLAG_GET_DIRTY_BITMAP)
> > -			return -EINVAL;
> > +	if (copy_from_user(&unmap, (void __user *)arg, minsz))
> > +		return -EFAULT;
> >
> > -		if (unmap.flags & VFIO_DMA_UNMAP_FLAG_GET_DIRTY_BITMAP) {
> > -			unsigned long pgshift;
> > +	if (unmap.argsz < minsz ||
> > +	    unmap.flags & ~VFIO_DMA_UNMAP_FLAG_GET_DIRTY_BITMAP)
> > +		return -EINVAL;
> >
> > -			if (unmap.argsz < (minsz + sizeof(bitmap)))
> > -				return -EINVAL;
> > +	if (unmap.flags & VFIO_DMA_UNMAP_FLAG_GET_DIRTY_BITMAP) {
> > +		unsigned long pgshift;
> >
> > -			if (copy_from_user(&bitmap,
> > -					   (void __user *)(arg + minsz),
> > -					   sizeof(bitmap)))
> > -				return -EFAULT;
> > +		if (unmap.argsz < (minsz + sizeof(bitmap)))
> > +			return -EINVAL;
> >
> > -			if (!access_ok((void __user *)bitmap.data, bitmap.size))
> > -				return -EINVAL;
> > +		if (copy_from_user(&bitmap,
> > +				   (void __user *)(arg + minsz),
> > +				   sizeof(bitmap)))
> > +			return -EFAULT;
> >
> > -			pgshift = __ffs(bitmap.pgsize);
> > -			ret = verify_bitmap_size(unmap.size >> pgshift,
> > -						 bitmap.size);
> > -			if (ret)
> > -				return ret;
> > -		}
> > +		if (!access_ok((void __user *)bitmap.data, bitmap.size))
> > +			return -EINVAL;
> >
> > -		ret = vfio_dma_do_unmap(iommu, &unmap, &bitmap);
> > +		pgshift = __ffs(bitmap.pgsize);
> > +		ret = verify_bitmap_size(unmap.size >> pgshift,
> > +					 bitmap.size);
> >  		if (ret)
> >  			return ret;
> > +	}
> > +
> > +	ret = vfio_dma_do_unmap(iommu, &unmap, &bitmap);
> > +	if (ret)
> > +		return ret;
> >
> > -		return copy_to_user((void __user *)arg, &unmap, minsz) ?
> > +	return copy_to_user((void __user *)arg, &unmap, minsz) ?
> >  			-EFAULT : 0;
> > -	} else if (cmd == VFIO_IOMMU_DIRTY_PAGES) {
> > -		struct vfio_iommu_type1_dirty_bitmap dirty;
> > -		uint32_t mask = VFIO_IOMMU_DIRTY_PAGES_FLAG_START |
> > -				VFIO_IOMMU_DIRTY_PAGES_FLAG_STOP |
> > -				VFIO_IOMMU_DIRTY_PAGES_FLAG_GET_BITMAP;
> > -		int ret = 0;
> > +}
> >
> > -		if (!iommu->v2)
> > -			return -EACCES;
> > +static int vfio_iommu_type1_dirty_pages(struct vfio_iommu *iommu,
> > +					unsigned long arg)
> > +{
> > +	struct vfio_iommu_type1_dirty_bitmap dirty;
> > +	uint32_t mask = VFIO_IOMMU_DIRTY_PAGES_FLAG_START |
> > +			VFIO_IOMMU_DIRTY_PAGES_FLAG_STOP |
> > +			VFIO_IOMMU_DIRTY_PAGES_FLAG_GET_BITMAP;
> > +	unsigned long minsz;
> > +	int ret = 0;
> >
> > -		minsz = offsetofend(struct vfio_iommu_type1_dirty_bitmap,
> > -				    flags);
> > +	if (!iommu->v2)
> > +		return -EACCES;
> >
> > -		if (copy_from_user(&dirty, (void __user *)arg, minsz))
> > -			return -EFAULT;
> > +	minsz = offsetofend(struct vfio_iommu_type1_dirty_bitmap,
> > +			    flags);
> single line?

got it.

> >
> > -		if (dirty.argsz < minsz || dirty.flags & ~mask)
> > -			return -EINVAL;
> > +	if (copy_from_user(&dirty, (void __user *)arg, minsz))
> > +		return -EFAULT;
> > +
> > +	if (dirty.argsz < minsz || dirty.flags & ~mask)
> > +		return -EINVAL;
> > +
> > +	/* only one flag should be set at a time */
> > +	if (__ffs(dirty.flags) != __fls(dirty.flags))
> > +		return -EINVAL;
> > +
> > +	if (dirty.flags & VFIO_IOMMU_DIRTY_PAGES_FLAG_START) {
> > +		size_t pgsize;
> >
> > -		/* only one flag should be set at a time */
> > -		if (__ffs(dirty.flags) != __fls(dirty.flags))
> > +		mutex_lock(&iommu->lock);
> > +		pgsize = 1 << __ffs(iommu->pgsize_bitmap);
> > +		if (!iommu->dirty_page_tracking) {
> > +			ret = vfio_dma_bitmap_alloc_all(iommu, pgsize);
> > +			if (!ret)
> > +				iommu->dirty_page_tracking = true;
> > +		}
> > +		mutex_unlock(&iommu->lock);
> > +		return ret;
> > +	} else if (dirty.flags & VFIO_IOMMU_DIRTY_PAGES_FLAG_STOP) {
> > +		mutex_lock(&iommu->lock);
> > +		if (iommu->dirty_page_tracking) {
> > +			iommu->dirty_page_tracking = false;
> > +			vfio_dma_bitmap_free_all(iommu);
> > +		}
> > +		mutex_unlock(&iommu->lock);
> > +		return 0;
> > +	} else if (dirty.flags &
> > +			 VFIO_IOMMU_DIRTY_PAGES_FLAG_GET_BITMAP) {
> single line?

yep.

> > +		struct vfio_iommu_type1_dirty_bitmap_get range;
> > +		unsigned long pgshift;
> > +		size_t data_size = dirty.argsz - minsz;
> > +		size_t iommu_pgsize;
> > +
> > +		if (!data_size || data_size < sizeof(range))
> >  			return -EINVAL;
> >
> > -		if (dirty.flags & VFIO_IOMMU_DIRTY_PAGES_FLAG_START) {
> > -			size_t pgsize;
> > +		if (copy_from_user(&range, (void __user *)(arg + minsz),
> > +				   sizeof(range)))
> > +			return -EFAULT;
> >
> > -			mutex_lock(&iommu->lock);
> > -			pgsize = 1 << __ffs(iommu->pgsize_bitmap);
> > -			if (!iommu->dirty_page_tracking) {
> > -				ret = vfio_dma_bitmap_alloc_all(iommu, pgsize);
> > -				if (!ret)
> > -					iommu->dirty_page_tracking = true;
> > -			}
> > -			mutex_unlock(&iommu->lock);
> > +		if (range.iova + range.size < range.iova)
> > +			return -EINVAL;
> > +		if (!access_ok((void __user *)range.bitmap.data,
> > +			       range.bitmap.size))
> > +			return -EINVAL;
> > +
> > +		pgshift = __ffs(range.bitmap.pgsize);
> > +		ret = verify_bitmap_size(range.size >> pgshift,
> > +					 range.bitmap.size);
> > +		if (ret)
> >  			return ret;
> > -		} else if (dirty.flags & VFIO_IOMMU_DIRTY_PAGES_FLAG_STOP) {
> > -			mutex_lock(&iommu->lock);
> > -			if (iommu->dirty_page_tracking) {
> > -				iommu->dirty_page_tracking = false;
> > -				vfio_dma_bitmap_free_all(iommu);
> > -			}
> > -			mutex_unlock(&iommu->lock);
> > -			return 0;
> > -		} else if (dirty.flags &
> > -				 VFIO_IOMMU_DIRTY_PAGES_FLAG_GET_BITMAP)
> {
> idem

well received. :-)

> > -			struct vfio_iommu_type1_dirty_bitmap_get range;
> > -			unsigned long pgshift;
> > -			size_t data_size = dirty.argsz - minsz;
> > -			size_t iommu_pgsize;
> > -
> > -			if (!data_size || data_size < sizeof(range))
> > -				return -EINVAL;
> > -
> > -			if (copy_from_user(&range, (void __user *)(arg + minsz),
> > -					   sizeof(range)))
> > -				return -EFAULT;
> >
> > -			if (range.iova + range.size < range.iova)
> > -				return -EINVAL;
> > -			if (!access_ok((void __user *)range.bitmap.data,
> > -				       range.bitmap.size))
> > -				return -EINVAL;
> > +		mutex_lock(&iommu->lock);
> >
> > -			pgshift = __ffs(range.bitmap.pgsize);
> > -			ret = verify_bitmap_size(range.size >> pgshift,
> > -						 range.bitmap.size);
> > -			if (ret)
> > -				return ret;
> > +		iommu_pgsize = (size_t)1 << __ffs(iommu->pgsize_bitmap);
> >
> > -			mutex_lock(&iommu->lock);
> > +		/* allow only smallest supported pgsize */
> > +		if (range.bitmap.pgsize != iommu_pgsize) {
> > +			ret = -EINVAL;
> > +			goto out_unlock;
> > +		}
> > +		if (range.iova & (iommu_pgsize - 1)) {
> > +			ret = -EINVAL;
> > +			goto out_unlock;
> > +		}
> > +		if (!range.size || range.size & (iommu_pgsize - 1)) {
> > +			ret = -EINVAL;
> > +			goto out_unlock;
> > +		}
> >
> > -			iommu_pgsize = (size_t)1 << __ffs(iommu->pgsize_bitmap);
> > +		if (iommu->dirty_page_tracking)
> > +			ret = vfio_iova_dirty_bitmap(range.bitmap.data,
> > +					iommu, range.iova, range.size,
> > +					range.bitmap.pgsize);
> > +		else
> > +			ret = -EINVAL;
> > +out_unlock:
> > +		mutex_unlock(&iommu->lock);
> >
> > -			/* allow only smallest supported pgsize */
> > -			if (range.bitmap.pgsize != iommu_pgsize) {
> > -				ret = -EINVAL;
> > -				goto out_unlock;
> > -			}
> > -			if (range.iova & (iommu_pgsize - 1)) {
> > -				ret = -EINVAL;
> > -				goto out_unlock;
> > -			}
> > -			if (!range.size || range.size & (iommu_pgsize - 1)) {
> > -				ret = -EINVAL;
> > -				goto out_unlock;
> > -			}
> > +		return ret;
> > +	}
> >
> > -			if (iommu->dirty_page_tracking)
> > -				ret = vfio_iova_dirty_bitmap(range.bitmap.data,
> > -						iommu, range.iova, range.size,
> > -						range.bitmap.pgsize);
> > -			else
> > -				ret = -EINVAL;
> > -out_unlock:
> > -			mutex_unlock(&iommu->lock);
> > +	return -EINVAL;
> > +}
> >
> > -			return ret;
> > -		}
> > +static long vfio_iommu_type1_ioctl(void *iommu_data,
> > +				   unsigned int cmd, unsigned long arg) {
> > +	struct vfio_iommu *iommu = iommu_data;
> > +
> > +	switch (cmd) {
> > +	case VFIO_CHECK_EXTENSION:
> > +		return vfio_iommu_type1_check_extension(iommu, arg);
> > +	case VFIO_IOMMU_GET_INFO:
> > +		return vfio_iommu_type1_get_info(iommu, arg);
> > +	case VFIO_IOMMU_MAP_DMA:
> > +		return vfio_iommu_type1_map_dma(iommu, arg);
> > +	case VFIO_IOMMU_UNMAP_DMA:
> > +		return vfio_iommu_type1_unmap_dma(iommu, arg);
> > +	case VFIO_IOMMU_DIRTY_PAGES:
> > +		return vfio_iommu_type1_dirty_pages(iommu, arg);
> default:
> 	return -ENOTTY; ?

got it.

> >  	}
> >
> >  	return -ENOTTY;
> >
> 
> Besides
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
