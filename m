Return-Path: <SRS0=yPOf=A7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76996C433E2
	for <iommu@archiver.kernel.org>; Mon, 20 Jul 2020 13:33:31 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D35020B1F
	for <iommu@archiver.kernel.org>; Mon, 20 Jul 2020 13:33:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="blnM3EuP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D35020B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 072E287EA6;
	Mon, 20 Jul 2020 13:33:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ec7dlBnhFfjr; Mon, 20 Jul 2020 13:33:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 24B0087E60;
	Mon, 20 Jul 2020 13:33:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0A7E1C089F;
	Mon, 20 Jul 2020 13:33:30 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 98530C016F
 for <iommu@lists.linux-foundation.org>; Mon, 20 Jul 2020 13:33:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 8314D87677
 for <iommu@lists.linux-foundation.org>; Mon, 20 Jul 2020 13:33:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kBtt3ViPpIGO for <iommu@lists.linux-foundation.org>;
 Mon, 20 Jul 2020 13:33:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by whitealder.osuosl.org (Postfix) with ESMTPS id B43CE87117
 for <iommu@lists.linux-foundation.org>; Mon, 20 Jul 2020 13:33:25 +0000 (UTC)
IronPort-SDR: 1K50jwNPkeivk0WMuGlMJG6uF8xZfMTS0ZPmrFGUQyiFSXRIYsgsgzos1c8dhrx3hFmEjfDcfz
 w8lMszHa3TFA==
X-IronPort-AV: E=McAfee;i="6000,8403,9687"; a="234759063"
X-IronPort-AV: E=Sophos;i="5.75,375,1589266800"; d="scan'208";a="234759063"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jul 2020 06:33:25 -0700
IronPort-SDR: hbKC49QTN1FSOl2K1vGA+c+wMUiKyFO6q+EMu1+UeR71FpKHl+5AsYTB2aP0SZWFNXc7TyiFez
 eAJuYnvyyT1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,375,1589266800"; d="scan'208";a="283516710"
Received: from orsmsx110.amr.corp.intel.com ([10.22.240.8])
 by orsmga003.jf.intel.com with ESMTP; 20 Jul 2020 06:33:24 -0700
Received: from ORSEDG001.ED.cps.intel.com (10.7.248.4) by
 ORSMSX110.amr.corp.intel.com (10.22.240.8) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 20 Jul 2020 06:33:24 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.103)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 20 Jul 2020 06:33:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iL+zMWLFX8v3oQWPQMk2VJA/V1pZ2YrJFUBDBjdxubMDQkjcYjOWyrElIc1YbqfZyENyd33/oWJEBgroKO9k8rs5dMQrhW/8UheH/CESWJUe8D7d/rjL/fNyBOWslXjH0FDIEWKsBomO7nSP/HH0RoBcnCckmxnrPUP9c2jCobonAhVqrbmqzxysqLV9TB3oaHfNHPhFmknl532R/Nx+FsgzPsMOr1xveFuAtQktC0a7Fk2xMLw9RRoWicPoV5nm8ET8maIB5DICCpLJJqWDcY/2e+J84EqP0gNKPo87bFB7Idlg3IqoMgOABnzZ+mOhBKBDnahh8KV3YhblbTTfKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Did4OclTlVLRsl7kyk1lieVKCNHUQM2WmEl2pF2OUQ=;
 b=Ix2PiG1JL8cSsb+gx10yzEipo9E+vAHo225m+9teEw4gKv8cPtd2SYmQVR3uCMvZAqn/4NtmaNUIH1QvT/qwbiWaJRCEZZN2N9au5BzUaZow5UejD4kOI8/CZslwCtzpU2bdUIE8wZxj4MsOHntfj697oaQoSYwqJGMo07tDoiMjZg+mSfac7uYlwj/Um+ZxZscXOGQZKEe1+/+JyWqpIwUuUOXFzJBnoIuArfqiRrprmEGeib9bVFLbvZ8m+u2Rppeg2gw4d5JyTcFAzoDx1EMRWIlI969x/frIW5b88UHYQYbE5TQK5SSP8N54OSRshzYK6IscolyinWd31tF0UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Did4OclTlVLRsl7kyk1lieVKCNHUQM2WmEl2pF2OUQ=;
 b=blnM3EuPKgsfaTkUQal6IHeVYpL+/zkilUtvewXJIYPq6/SUS9X0VReNgMPZai9auePKxXVhLw8UjCeNq/VgIdjQNMYjMaXvNCZxQIeaxQPZJCNYL3IxyytpjxYxdt2hnq5bgm7nGRGZNwbdtrdQtsaBxXJuGAziJNq3OhRP1Z8=
Received: from DM5PR11MB1435.namprd11.prod.outlook.com (2603:10b6:4:7::18) by
 DM6PR11MB3148.namprd11.prod.outlook.com (2603:10b6:5:6f::28) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3195.17; Mon, 20 Jul 2020 13:33:21 +0000
Received: from DM5PR11MB1435.namprd11.prod.outlook.com
 ([fe80::9002:97a2:d8c0:8364]) by DM5PR11MB1435.namprd11.prod.outlook.com
 ([fe80::9002:97a2:d8c0:8364%10]) with mapi id 15.20.3195.025; Mon, 20 Jul
 2020 13:33:21 +0000
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: Auger Eric <eric.auger@redhat.com>, "alex.williamson@redhat.com"
 <alex.williamson@redhat.com>, "baolu.lu@linux.intel.com"
 <baolu.lu@linux.intel.com>, "joro@8bytes.org" <joro@8bytes.org>
Subject: RE: [PATCH v5 15/15] iommu/vt-d: Support reporting nesting capability
 info
Thread-Topic: [PATCH v5 15/15] iommu/vt-d: Support reporting nesting
 capability info
Thread-Index: AQHWWD2ozEKwFS8Y2kWlIFOVw8dCH6kMCuCAgAR3s/A=
Date: Mon, 20 Jul 2020 13:33:21 +0000
Message-ID: <DM5PR11MB14355BD93D10F5CB5CE9F056C37B0@DM5PR11MB1435.namprd11.prod.outlook.com>
References: <1594552870-55687-1-git-send-email-yi.l.liu@intel.com>
 <1594552870-55687-16-git-send-email-yi.l.liu@intel.com>
 <be27f7ee-3fac-d1c5-0cd9-9581f8827de6@redhat.com>
In-Reply-To: <be27f7ee-3fac-d1c5-0cd9-9581f8827de6@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.102.204.36]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6b45749d-edf2-4280-963a-08d82cb17888
x-ms-traffictypediagnostic: DM6PR11MB3148:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB314819B977E01EFA2B80F102C37B0@DM6PR11MB3148.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:758;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kynp+ReLhq+xj8sORHe41qSjC24h5Opbn3RNwhwrvy0UH2KxDMKVP8WzXugfOkyf+OXrBj0txfD40Xa0NFfzQeVj/xO3ahqnhWs3Ry6ap16SNkCz4BSnElgEV72ajm3m34PJgN/lCArHhFXTfr8IsO8v6kLYSOkzkYCluTljlHQdcRX+vOncZZhcY/OLHYrrTH4QqfAqQHA2vwQoppTKshJE0MVIcnmTswmtpZqK6rZousTdWIz05A7lh8b1x0mbvVCEFpmsFIr2W1o4uQTL534TzRoUSvCy1eGx8so8RtinB835U47PnvbY6aqbtQHP+xAqEZyjGl/JV/lrX7gB6w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR11MB1435.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(396003)(136003)(376002)(39860400002)(366004)(86362001)(7416002)(9686003)(71200400001)(4326008)(52536014)(316002)(83380400001)(66446008)(2906002)(64756008)(66556008)(66476007)(66946007)(76116006)(26005)(33656002)(55016002)(8676002)(478600001)(7696005)(5660300002)(186003)(54906003)(110136005)(53546011)(6506007)(8936002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: 6SFI/QCFWOMEbBYuyOv1PatTjjgHeFqAk5aFpTaS2kAUa41znxuCvkRzMHlqQFtSU/Fd688idY4M3VgwD4I76fsq5bxu6muZA+bBVppR6WErdN/WpwPN9gz6IkytDr0haBDxlwO12JrLOvXwoZOo7zVKeCxnone2Ux8vJkux7NXqlePTIxjO3PzwkPjBH4E7NjMSXF/E50TwFDJFcC0YazxAAHCKtjpUQOM2yiOrYFNPQIIfBZ1SaiZi+bnB8SbNe145TYw8K3WLj2T91VluO8T0mU5sKVsb+9ay0EJTCSBDkfSl/fB8kHFHGaWK6WKr84EC5J8Soji+AF1OzxT6kxZ4djKeysOvuMpL6Dqq4p6ornO0Vjub1qNCHODjkb8Q8244FQQ/prxTjrz3HylOMZVmEWnuiQacNL1U9blCi+jMbTPf0zQbO9kyfLp9D2olbLqu3b2g5RF844lFIBG2C2HJbb2OH3q+6f2Kgaj/0O5D065ZOmnhFkofeRrNtr2a
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1435.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b45749d-edf2-4280-963a-08d82cb17888
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2020 13:33:21.5036 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h+Na1snQEW6fhLBuQWRJ12WBRhhIxk3SYNx8Snr56MrdoQ70DfmylqnS4XNFnTJV8XUnZwXL8cVsOr6WY53ejg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3148
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
> Sent: Saturday, July 18, 2020 1:14 AM
> 
> Hi Yi,
> 
> Missing a proper commit message. You can comment on the fact you only
> support the case where all the physical iomms have the same CAP/ECAP MASKS

got it. will add it. it looks like the subject is straightforward, so I removed commit
message.

> 
> On 7/12/20 1:21 PM, Liu Yi L wrote:
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
> > v2 -> v3:
> > *) remove cap/ecap_mask in iommu_nesting_info.
> > ---
> >  drivers/iommu/intel/iommu.c | 81
> +++++++++++++++++++++++++++++++++++++++++++--
> >  include/linux/intel-iommu.h | 16 +++++++++
> >  2 files changed, 95 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> > index a9504cb..9f7ad1a 100644
> > --- a/drivers/iommu/intel/iommu.c
> > +++ b/drivers/iommu/intel/iommu.c
> > @@ -5659,12 +5659,16 @@ static inline bool iommu_pasid_support(void)
> >  static inline bool nested_mode_support(void)
> >  {
> >  	struct dmar_drhd_unit *drhd;
> > -	struct intel_iommu *iommu;
> > +	struct intel_iommu *iommu, *prev = NULL;
> >  	bool ret = true;
> >
> >  	rcu_read_lock();
> >  	for_each_active_iommu(iommu, drhd) {
> > -		if (!sm_supported(iommu) || !ecap_nest(iommu->ecap)) {
> > +		if (!prev)
> > +			prev = iommu;
> > +		if (!sm_supported(iommu) || !ecap_nest(iommu->ecap) ||
> > +		    (VTD_CAP_MASK & (iommu->cap ^ prev->cap)) ||
> > +		    (VTD_ECAP_MASK & (iommu->ecap ^ prev->ecap))) {
> >  			ret = false;
> >  			break;>  		}
> > @@ -6079,6 +6083,78 @@ intel_iommu_domain_set_attr(struct iommu_domain
> *domain,
> >  	return ret;
> >  }
> >
> > +static int intel_iommu_get_nesting_info(struct iommu_domain *domain,
> > +					struct iommu_nesting_info *info)
> > +{
> > +	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
> > +	u64 cap = VTD_CAP_MASK, ecap = VTD_ECAP_MASK;
> > +	struct device_domain_info *domain_info;
> > +	struct iommu_nesting_info_vtd vtd;
> > +	unsigned long flags;
> > +	unsigned int size;
> > +
> > +	if (domain->type != IOMMU_DOMAIN_UNMANAGED ||
> > +	    !(dmar_domain->flags & DOMAIN_FLAG_NESTING_MODE))
> > +		return -ENODEV;
> > +
> > +	if (!info)
> > +		return -EINVAL;
> > +
> > +	size = sizeof(struct iommu_nesting_info) +
> > +		sizeof(struct iommu_nesting_info_vtd);
> > +	/*
> > +	 * if provided buffer size is smaller than expected, should
> > +	 * return 0 and also the expected buffer size to caller.
> > +	 */
> > +	if (info->size < size) {
> > +		info->size = size;
> > +		return 0;
> > +	}
> > +
> > +	spin_lock_irqsave(&device_domain_lock, flags);
> > +	/*
> > +	 * arbitrary select the first domain_info as all nesting
> > +	 * related capabilities should be consistent across iommu
> > +	 * units.
> > +	 */
> > +	domain_info = list_first_entry(&dmar_domain->devices,
> > +				       struct device_domain_info, link);
> > +	cap &= domain_info->iommu->cap;
> > +	ecap &= domain_info->iommu->ecap;
> > +	spin_unlock_irqrestore(&device_domain_lock, flags);
> > +
> > +	info->format = IOMMU_PASID_FORMAT_INTEL_VTD;
> > +	info->features = IOMMU_NESTING_FEAT_SYSWIDE_PASID |
> > +			 IOMMU_NESTING_FEAT_BIND_PGTBL |
> > +			 IOMMU_NESTING_FEAT_CACHE_INVLD;
> > +	info->addr_width = dmar_domain->gaw;
> > +	info->pasid_bits = ilog2(intel_pasid_max_id);
> > +	info->padding = 0;
> > +	vtd.flags = 0;
> > +	vtd.padding = 0;
> > +	vtd.cap_reg = cap;
> > +	vtd.ecap_reg = ecap;
> > +
> > +	memcpy(info->data, &vtd, sizeof(vtd));
> > +	return 0;
> > +}
> > +
> > +static int intel_iommu_domain_get_attr(struct iommu_domain *domain,
> > +				       enum iommu_attr attr, void *data)
> > +{
> > +	switch (attr) {
> > +	case DOMAIN_ATTR_NESTING:
> > +	{
> > +		struct iommu_nesting_info *info =
> > +				(struct iommu_nesting_info *)data;
> > +
> > +		return intel_iommu_get_nesting_info(domain, info);
> > +	}
> > +	default:
> > +		return -ENODEV;
> -ENOENT?

arm_smmu_domain_get_attr() is using -ENODEV, so I used the same. I can
modify it if -ENOENT is better. :-)

Regards,
Yi Liu

> > +	}
> > +}
> > +
> >  /*
> >   * Check that the device does not live on an external facing PCI port that is
> >   * marked as untrusted. Such devices should not be able to apply quirks and
> > @@ -6101,6 +6177,7 @@ const struct iommu_ops intel_iommu_ops = {
> >  	.domain_alloc		= intel_iommu_domain_alloc,
> >  	.domain_free		= intel_iommu_domain_free,
> >  	.domain_set_attr	= intel_iommu_domain_set_attr,
> > +	.domain_get_attr	= intel_iommu_domain_get_attr,
> >  	.attach_dev		= intel_iommu_attach_device,
> >  	.detach_dev		= intel_iommu_detach_device,
> >  	.aux_attach_dev		= intel_iommu_aux_attach_device,
> > diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
> > index 18f292e..c4ed0d4 100644
> > --- a/include/linux/intel-iommu.h
> > +++ b/include/linux/intel-iommu.h
> > @@ -197,6 +197,22 @@
> >  #define ecap_max_handle_mask(e) ((e >> 20) & 0xf)
> >  #define ecap_sc_support(e)	((e >> 7) & 0x1) /* Snooping Control */
> >
> > +/* Nesting Support Capability Alignment */
> > +#define VTD_CAP_FL1GP		BIT_ULL(56)
> > +#define VTD_CAP_FL5LP		BIT_ULL(60)
> > +#define VTD_ECAP_PRS		BIT_ULL(29)
> > +#define VTD_ECAP_ERS		BIT_ULL(30)
> > +#define VTD_ECAP_SRS		BIT_ULL(31)
> > +#define VTD_ECAP_EAFS		BIT_ULL(34)
> > +#define VTD_ECAP_PASID		BIT_ULL(40)
> 
> > +
> > +/* Only capabilities marked in below MASKs are reported */
> > +#define VTD_CAP_MASK		(VTD_CAP_FL1GP | VTD_CAP_FL5LP)
> > +
> > +#define VTD_ECAP_MASK		(VTD_ECAP_PRS | VTD_ECAP_ERS | \
> > +				 VTD_ECAP_SRS | VTD_ECAP_EAFS | \
> > +				 VTD_ECAP_PASID)
> > +
> >  /* Virtual command interface capability */
> >  #define vccap_pasid(v)		(((v) & DMA_VCS_PAS)) /* PASID allocation
> */
> >
> >
> Thanks
> 
> Eric
> 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
