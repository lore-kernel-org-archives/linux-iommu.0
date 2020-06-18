Return-Path: <SRS0=cSHS=77=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 644EAC433E1
	for <iommu@archiver.kernel.org>; Thu, 18 Jun 2020 11:46:23 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DAA02085B
	for <iommu@archiver.kernel.org>; Thu, 18 Jun 2020 11:46:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="CK60Grkl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DAA02085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 0330086D24;
	Thu, 18 Jun 2020 11:46:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bw1f60rOsU5k; Thu, 18 Jun 2020 11:46:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 251C786356;
	Thu, 18 Jun 2020 11:46:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 056AAC088C;
	Thu, 18 Jun 2020 11:46:22 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D09B3C016E
 for <iommu@lists.linux-foundation.org>; Thu, 18 Jun 2020 11:46:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id BEB3587F52
 for <iommu@lists.linux-foundation.org>; Thu, 18 Jun 2020 11:46:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eoXbiX3fGi1w for <iommu@lists.linux-foundation.org>;
 Thu, 18 Jun 2020 11:46:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 1F88587EBB
 for <iommu@lists.linux-foundation.org>; Thu, 18 Jun 2020 11:46:17 +0000 (UTC)
IronPort-SDR: 50flQzd0Soka7+n0IH0I1M6k9oW1zZdEt3MxcCZYM1xZ4WEcJk9T6d9JLWIUpIpMItB83CM7C0
 aB310rfOseTQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9655"; a="141616539"
X-IronPort-AV: E=Sophos;i="5.73,526,1583222400"; d="scan'208";a="141616539"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jun 2020 04:46:16 -0700
IronPort-SDR: skJ/m7HCEEOJpJDHueF17lGDMtd/CqH1rHAXjEcf/s8tVYVUmPBoMZy/lfhi4wWArcimEU00Gk
 WLVkB4pPBO9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,526,1583222400"; d="scan'208";a="477168236"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
 by fmsmga006.fm.intel.com with ESMTP; 18 Jun 2020 04:46:16 -0700
Received: from fmsmsx154.amr.corp.intel.com (10.18.116.70) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 18 Jun 2020 04:46:16 -0700
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 FMSMSX154.amr.corp.intel.com (10.18.116.70) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 18 Jun 2020 04:46:15 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Thu, 18 Jun 2020 04:46:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S7Bnwp3CMLslNqZb/leek6Zx67D+CJkiWsNnCmD/7WgrrH2a754WcIsi7rrWmwjZSQb+NGNCC45sP5gdIf56zSgZBL7Xrq1PvSwBz21cOdi/o5scwUjyVmaAuJd3mdck6omiGu4HJ3JvbDC2bVDH3lLgnANJSsBxsDECeJIz1aKpZZa8wfip5llJfknJzd1Fl+b7fDmcqvCOY9p5IiezB2N676QtGHMt0yVP7xxk5zuBZDYIqKL/KpXsMH/qVmBxpf8Igx3epoHTLo8SuHyb9BMTM2WkNzcW8Z0liHl8y/P2iGyKywrUg397gOJVowkI5FdT7cIfQjiIAAGxs8n3yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ol9zyn9oa9grmPjVICjgwEjvWL/ohYiZouqtGV1UmI=;
 b=NXnuHFb2O//zk5BESGQND8wff1cPgH5NM2x+VWRfghUR6IsYvEGIwCIuPZCCk/DZNgIhQiU+XJHth4mLBdzgwUAIKiIQRhrMZs4krejcsGBIZ4KnRlYtu4L7N3ZljgAVMCpJujsleMloIkYQZcb+uR1ru5h6WntzCGhkmS9RpdJ44jESg0YotTFznQXFB85oUcmpdcJWLC+ExfFEeOoPYc5ioZu58LOph90C2F0YNUMwWxfw8DTS0y4bCeg5IUHNdDzQA0vMaoeVcDGkzYGkZf3dikILvbJW6OwppaFXE4TxrIFHV3daaekSwPmyyylpRSSXvfwWQCtuV6iICrSRKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ol9zyn9oa9grmPjVICjgwEjvWL/ohYiZouqtGV1UmI=;
 b=CK60GrklKgsLzy+Ot4SIDD9aPHBMhZOUk4rvN1mT/f2jMfqqjFfgO0B6pl3P/BC4AMYu+8fV3Gz2xKcbF77+rccTbid9BLh0bAdlxj1AO/Pg7cmWCDeZ/aJntnke2zYLbAZLSiHeKd+CcDWzTZx7xalUSisLtLHXLhmBSNBrIlQ=
Received: from DM5PR11MB1435.namprd11.prod.outlook.com (2603:10b6:4:7::18) by
 DM5PR1101MB2108.namprd11.prod.outlook.com (2603:10b6:4:53::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3109.23; Thu, 18 Jun 2020 11:46:14 +0000
Received: from DM5PR11MB1435.namprd11.prod.outlook.com
 ([fe80::2c3d:98d9:4e81:c86c]) by DM5PR11MB1435.namprd11.prod.outlook.com
 ([fe80::2c3d:98d9:4e81:c86c%6]) with mapi id 15.20.3109.023; Thu, 18 Jun 2020
 11:46:14 +0000
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: RE: [PATCH v2 02/15] iommu: Report domain nesting info
Thread-Topic: [PATCH v2 02/15] iommu: Report domain nesting info
Thread-Index: AQHWP+lAvgybSaO2NECN4P16s7e2zKjc6kyAgAFaSXA=
Date: Thu, 18 Jun 2020 11:46:14 +0000
Message-ID: <DM5PR11MB143583396465E5DEFF8BA8CDC39B0@DM5PR11MB1435.namprd11.prod.outlook.com>
References: <1591877734-66527-1-git-send-email-yi.l.liu@intel.com>
 <1591877734-66527-3-git-send-email-yi.l.liu@intel.com>
 <20200617143909.GA886590@myrica>
In-Reply-To: <20200617143909.GA886590@myrica>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.147.217]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f0d44784-4e10-4ec2-7294-08d8137d34ac
x-ms-traffictypediagnostic: DM5PR1101MB2108:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR1101MB2108AC57E7CA7EB1601768DBC39B0@DM5PR1101MB2108.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0438F90F17
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KtsLESTArB/qOy0K5OMCWSdlXSlrPsUyKXOtmeBmYN3RBqOBGrLUxLmLLr0aeLXwf5gaD54GYOrPrdj4P1IhEXQEcOD/JtyRccmHcOpBRhJ1+1s6/keNQrO6AIYbkhnDOQbIRrKYT8aYmgRoWjZjMGbkxCDOd6T6pKQp0s/LyiCn5vMu/31OAd9U8RLxmAexFA3MQKy0B5PhLDExTJe+SCPCxF9ypV1jZJTVTqFly49Shqg6mcgBDDyNA6R9Xb/2J2Ajorb4GgDGk23/84Xdbh1G3fhpSnuspLlDwUttygNJyLiOKrSCBdE9B7lek2ZK90Qmg5lUVuJXqhe1dxQu5A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR11MB1435.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(376002)(136003)(39860400002)(396003)(366004)(5660300002)(52536014)(6506007)(478600001)(86362001)(8936002)(4326008)(186003)(26005)(71200400001)(83380400001)(7696005)(33656002)(7416002)(54906003)(316002)(2906002)(55016002)(6916009)(9686003)(66476007)(66556008)(64756008)(66446008)(76116006)(66946007)(8676002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: 3YLUHKosrlkGtpx5GI5Yk3CSTowreJFJGNbAAfN1rVMaAIX6Y/wd0mlVHaQWnLS+HY89tFzxaMYcmgPMJEtpahNa2P7hQDcjtF68LEasbX20o4rs2XMANlk0mK1n/rO/dI7JgMSg3lXYjIss2pNVOJBxZh3urQXMO/4rS1CHoYG3+9bSzmt+mUs3TCb+qLa9erY0NFTFcfDZXNU6x05jPf3N0sKCduBh/i0eaznRfBHfh5B8CVlfwPSw1SGQzS5e79Zdd43ed/ELVqQCy1+VuNn15Hf+YoiI8lZT8zw35T+p9zB64JUo/hNncW3+ycGtzruxdj/+9nzXR/zDxQPoVMqdynakwgw9ifXbXE3WMzdvhbrVRal9f2cg4ETGX62vch8XfUMt0gpBHWuS7kmugh5ADY+yWvuuB60zEJdvGmJSGX/NIlhtvFBA99lpxltqLcW+BDJatWtimKRwXO/v8F6qQyWWrvOSpASwiLx9ZqQtLeGL0dtVbuBSrIwB3Iib
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: f0d44784-4e10-4ec2-7294-08d8137d34ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2020 11:46:14.5852 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9BUmJTMLylUgoozkzduI8YivJzT2ev7eVNDBRBkrD4YA1Xt/2BwytlVSlqNKrigGWFrQchPBj/I0BOIAbNwvbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1101MB2108
X-OriginatorOrg: intel.com
Cc: "Tian, Kevin" <kevin.tian@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>, "Sun,
 Yi Y" <yi.y.sun@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Wu,
 Hao" <hao.wu@intel.com>, "will@kernel.org" <will@kernel.org>, "Tian, 
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

Hi Jean,

> From: Jean-Philippe Brucker < jean-philippe@linaro.org>
> Sent: Wednesday, June 17, 2020 10:39 PM
> 
> [+ Will and Robin]
> 
> Hi Yi,
> 
> On Thu, Jun 11, 2020 at 05:15:21AM -0700, Liu Yi L wrote:
> > IOMMUs that support nesting translation needs report the capability
> > info to userspace, e.g. the format of first level/stage paging structures.
> >
> > Cc: Kevin Tian <kevin.tian@intel.com>
> > CC: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > Cc: Alex Williamson <alex.williamson@redhat.com>
> > Cc: Eric Auger <eric.auger@redhat.com>
> > Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > Cc: Joerg Roedel <joro@8bytes.org>
> > Cc: Lu Baolu <baolu.lu@linux.intel.com>
> > Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > ---
> > @Jean, Eric: as nesting was introduced for ARM, but looks like no
> > actual user of it. right? So I'm wondering if we can reuse
> > DOMAIN_ATTR_NESTING to retrieve nesting info? how about your opinions?
> 
> Sure, I think we could rework the getters for DOMAIN_ATTR_NESTING since they
> aren't used, but we do need to keep the setters as is.
> 
> Before attaching a domain, VFIO sets DOMAIN_ATTR_NESTING if userspace
> requested a VFIO_TYPE1_NESTING_IOMMU container. This is necessary for the
> SMMU driver to know how to attach later, but at that point we don't know whether
> the SMMU does support nesting (since the domain isn't attached to any endpoint).
> During attach, the SMMU driver adapts to the SMMU's capabilities, and may well
> fallback to one stage if the SMMU doesn't support nesting.

got you. so even VFIO sets DOMAIN_ATTR_NESTING successfully, it doesn't mean
the nesting will be used. yeah, it's a little bit different with VT-d side. intel iommu
driver will fail ATT_NESTING setting if it found not all iommu units in the system
are nesting capable.

> VFIO should check after attaching that the nesting attribute held, by calling
> iommu_domain_get_attr(NESTING). At the moment it does not, and since your
> 03/15 patch does that with additional info, I agree with reusing
> DOMAIN_ATTR_NESTING instead of adding DOMAIN_ATTR_NESTING_INFO.
>
> However it requires changing the get_attr(NESTING) implementations in both SMMU
> drivers as a precursor of this series, to avoid breaking
> VFIO_TYPE1_NESTING_IOMMU on Arm. Since we haven't yet defined the
> nesting_info structs for SMMUv2 and v3, I suppose we could return an empty struct
> iommu_nesting_info for now?

got you. I think it works. So far, I didn't see any getter for ATTR_NESTING, once
SMMU drivers return empty struct iommu_nesting_info, VFIO won't fail. will
do it when switching to reuse ATTR_NESTING for getting nesting info.

> >
> >  include/linux/iommu.h      |  1 +
> >  include/uapi/linux/iommu.h | 34 ++++++++++++++++++++++++++++++++++
> >  2 files changed, 35 insertions(+)
> >
> > diff --git a/include/linux/iommu.h b/include/linux/iommu.h index
> > 78a26ae..f6e4b49 100644
> > --- a/include/linux/iommu.h
> > +++ b/include/linux/iommu.h
> > @@ -126,6 +126,7 @@ enum iommu_attr {
> >  	DOMAIN_ATTR_FSL_PAMUV1,
> >  	DOMAIN_ATTR_NESTING,	/* two stages of translation */
> >  	DOMAIN_ATTR_DMA_USE_FLUSH_QUEUE,
> > +	DOMAIN_ATTR_NESTING_INFO,
> >  	DOMAIN_ATTR_MAX,
> >  };
> >
> > diff --git a/include/uapi/linux/iommu.h b/include/uapi/linux/iommu.h
> > index 303f148..02eac73 100644
> > --- a/include/uapi/linux/iommu.h
> > +++ b/include/uapi/linux/iommu.h
> > @@ -332,4 +332,38 @@ struct iommu_gpasid_bind_data {
> >  	};
> >  };
> >
> > +struct iommu_nesting_info {
> > +	__u32	size;
> > +	__u32	format;
> 
> What goes into format? And flags? This structure needs some documentation.

format will be the same with the definition of @format in iommu_gpasid_bind_data.
flags is reserved for future extension. will add description in next version. :-)

struct iommu_gpasid_bind_data {
        __u32 argsz;
#define IOMMU_GPASID_BIND_VERSION_1     1
        __u32 version;
#define IOMMU_PASID_FORMAT_INTEL_VTD    1
        __u32 format;
#define IOMMU_SVA_GPASID_VAL    (1 << 0) /* guest PASID valid */
        __u64 flags;
        __u64 gpgd;
        __u64 hpasid;
        __u64 gpasid;
        __u32 addr_width;
        __u8  padding[12];
        /* Vendor specific data */
        union {
                struct iommu_gpasid_bind_data_vtd vtd;
        } vendor;
};

Regards,
Yi Liu

> Thanks,
> Jean
> 
> > +	__u32	features;
> > +#define IOMMU_NESTING_FEAT_SYSWIDE_PASID	(1 << 0)
> > +#define IOMMU_NESTING_FEAT_BIND_PGTBL		(1 << 1)
> > +#define IOMMU_NESTING_FEAT_CACHE_INVLD		(1 << 2)
> > +	__u32	flags;
> > +	__u8	data[];
> > +};
> > +
> > +/*
> > + * @flags:	VT-d specific flags. Currently reserved for future
> > + *		extension.
> > + * @addr_width:	The output addr width of first level/stage translation
> > + * @pasid_bits:	Maximum supported PASID bits, 0 represents no PASID
> > + *		support.
> > + * @cap_reg:	Describe basic capabilities as defined in VT-d capability
> > + *		register.
> > + * @cap_mask:	Mark valid capability bits in @cap_reg.
> > + * @ecap_reg:	Describe the extended capabilities as defined in VT-d
> > + *		extended capability register.
> > + * @ecap_mask:	Mark the valid capability bits in @ecap_reg.
> > + */
> > +struct iommu_nesting_info_vtd {
> > +	__u32	flags;
> > +	__u16	addr_width;
> > +	__u16	pasid_bits;
> > +	__u64	cap_reg;
> > +	__u64	cap_mask;
> > +	__u64	ecap_reg;
> > +	__u64	ecap_mask;
> > +};
> > +
> >  #endif /* _UAPI_IOMMU_H */
> > --
> > 2.7.4
> >
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
