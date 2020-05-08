Return-Path: <SRS0=CQae=6W=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31495C35280
	for <iommu@archiver.kernel.org>; Fri,  8 May 2020 02:12:35 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEB72206B9
	for <iommu@archiver.kernel.org>; Fri,  8 May 2020 02:12:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="C156U2y4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEB72206B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id B8F4F8967F;
	Fri,  8 May 2020 02:12:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oYFnJb2Iwhdv; Fri,  8 May 2020 02:12:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 675AB89678;
	Fri,  8 May 2020 02:12:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 59C8BC0865;
	Fri,  8 May 2020 02:12:33 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 39A52C07FF
 for <iommu@lists.linux-foundation.org>; Fri,  8 May 2020 02:12:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 1F4B7204A6
 for <iommu@lists.linux-foundation.org>; Fri,  8 May 2020 02:12:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oCHwnmSjXeAB for <iommu@lists.linux-foundation.org>;
 Fri,  8 May 2020 02:12:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by silver.osuosl.org (Postfix) with ESMTPS id 70CA620455
 for <iommu@lists.linux-foundation.org>; Fri,  8 May 2020 02:12:30 +0000 (UTC)
IronPort-SDR: ZY62UUoyp7kqWmnq4vCajM3jjPrSPJFrF2LrFp6Z3RvZg2rypgKtcg4APO9jLOlcwEz2X99V4O
 6l9FVC1V3g0g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 May 2020 19:12:29 -0700
IronPort-SDR: 4nbpUhmYmmi4BprSnKAkerJPkFXI9F8gkAnmKq7DdzcPRdrgBdIbs1RVyojcUbD3OftwG/+w9X
 SNTnn9PW/Liw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,366,1583222400"; d="scan'208";a="285224540"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
 by fmsmga004.fm.intel.com with ESMTP; 07 May 2020 19:12:29 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 7 May 2020 19:12:29 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 7 May 2020 19:12:28 -0700
Received: from FMSEDG001.ED.cps.intel.com (10.1.192.133) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 7 May 2020 19:12:27 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.171)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Thu, 7 May 2020 19:12:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WPAMwHdVIsd2u+w7TTGsINlWMEIMVlgvKc3Dih0T6N77W1pUkq7WHH3I2iZ0McFuchAijWbRXTAAOfhFD6bedPaG3uKkzX3fPgsmIkMJ7acGjbECKwCnlDwgMJA23DcIWeNWc76LMJBpWNL6ZZRPgLckGJ4NvJrwIaQf+Lmd58+OBjSrCbzxW3NVvzkLyT0VbZAb/r8vzBPS0RRylMABCEb3Y6mZpmYj3ezg4StS+9fXv2k0x3IZ6NtWp/V0O7NN0DmgqGt7Vze6rn1I8z3wwmI78kkV1Xo+2ZCO4434ZlFoNpGZb/d//0YQNq/UNZ/FQsTYpHMGhQihjE3tJbQHdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8tRYP4drHgJcJ2ZkZSf/1nKLtEFfVaX09yRi6v/7bHo=;
 b=HY8n7kX+TZtuHBnHQbLLcgAB9Vw8chX7QSCF036PO8JVWOT46uEIKuVTh5IXF6bAVB0YKyKJuG4xqq12I/jQJPhLWzr32ZlEhhlB1yw+BzJJSgQqkyUKqyisv1H24lh/vp0GCfJhWtr38ydI5xp8Quz+d0Mp5UVZ/sA9xR3E73BvaLuFytqfL4kdt2jCjJViLI3ATOwFCbQT54OWbbT8dqVE3Ys7FY7bH1WqGyOPEn8w7hpBay1uVD/OCp2MTF5LdYZZ1OWGMeIvIq75LNoLuYbAWWIXVVWYQCwG1QOrYUVsAvK/nqqRTsoU39aOHE+sF7T2kGReW0YPWVpzNhM7Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8tRYP4drHgJcJ2ZkZSf/1nKLtEFfVaX09yRi6v/7bHo=;
 b=C156U2y4wz3ynntkHR8pHT9X9QurTU3ltheaNSjQSu6Bs/HYVVABhvgncbWHtMqd0eM9RCRKw46fy6Ap/gXW6pADEltmIAjZ9Yqk9K5xshbJ5Ro27Q3KRzC3+7rTavfgAFbhfH8x2YODSD38dZrupUK5C7Wk6xt1q29VXNZ4Nqg=
Received: from MWHPR11MB1645.namprd11.prod.outlook.com (2603:10b6:301:b::12)
 by MWHPR11MB1374.namprd11.prod.outlook.com (2603:10b6:300:24::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.28; Fri, 8 May
 2020 02:12:25 +0000
Received: from MWHPR11MB1645.namprd11.prod.outlook.com
 ([fe80::bc06:71a6:1cdd:59be]) by MWHPR11MB1645.namprd11.prod.outlook.com
 ([fe80::bc06:71a6:1cdd:59be%9]) with mapi id 15.20.2979.028; Fri, 8 May 2020
 02:12:25 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>
Subject: RE: [PATCH v4 3/5] iommu/vt-d: Disable non-recoverable fault
 processing before unbind
Thread-Topic: [PATCH v4 3/5] iommu/vt-d: Disable non-recoverable fault
 processing before unbind
Thread-Index: AQHWJArS9bHSXYAkjk+yfEGapC3IHKicG8bggACBgYCAANZmwA==
Date: Fri, 8 May 2020 02:12:25 +0000
Message-ID: <MWHPR11MB16450F77A9A450AFE51D8F7A8CA20@MWHPR11MB1645.namprd11.prod.outlook.com>
References: <20200507005534.3080-1-baolu.lu@linux.intel.com>
 <20200507005534.3080-4-baolu.lu@linux.intel.com>
 <MWHPR11MB1645CE4337BEDBC4598318A88CA50@MWHPR11MB1645.namprd11.prod.outlook.com>
 <3c41a395-95b6-f80c-d3fd-bcd1ec166b24@linux.intel.com>
In-Reply-To: <3c41a395-95b6-f80c-d3fd-bcd1ec166b24@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.55.52.203]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 21cb00e1-3a67-4c6e-e6c0-08d7f2f54036
x-ms-traffictypediagnostic: MWHPR11MB1374:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR11MB137486BD3872CC6D6B850C058CA20@MWHPR11MB1374.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 039735BC4E
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cZqfv0DbkR4cdjEThSpg5M+eOqepMoBrGulJSt0JecMFwHqJO/KXDbo0PX3pxkjQAZHYkjLTslSNTpql/vQNBKxNfniptzOi2C7MiF3mJCAmCT+lksimy1Mq4oUVRTIj+HndD1kmsFMI+HARk1D7g1Jo5bAOW7xOJI1NaIWTB+JQkZ0hEpiSqJfsMEovgUnvbhqEQHSCsEBqXCnca1AQri29fF1YkIG/hsNWSxPnk9b5m1pqZHdCrIg0xX7qV+wJt4l4meFGxqzkyTFC49Vf9VzD9ypALqCMNMcv/JMg7xqnjjRTs1UpwtYzeye/fVHcZemqa9tk1WU/4p16j6akrIs4wEKnYfiQGRgQjREUrjcR02b8D9XVX58Vb6XobzTF9feqlpaOle/Ux6OqbCy3yz/PEYC6c4Klw547NitPH/rEUt7WvHJkDCT2qWy+xPzJJxTwDt87JaV3zfal+WFlfPsdzZz4piI5WxQnQCySbcOu0c5lpkABH7l7sIvv0AokLhrWPx+1uVHv/i/lr9u2Fw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR11MB1645.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(346002)(39860400002)(396003)(366004)(136003)(376002)(33430700001)(33656002)(66446008)(54906003)(66476007)(66556008)(316002)(52536014)(110136005)(64756008)(4326008)(55016002)(6506007)(2906002)(9686003)(186003)(478600001)(71200400001)(53546011)(5660300002)(86362001)(76116006)(66946007)(33440700001)(26005)(8676002)(83320400001)(83280400001)(83310400001)(83290400001)(83300400001)(7696005)(8936002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: wT+rjcynE4UuHA04U0/73TysUL4laMLCIWIrIC9H5LxRCXw86LwO9rothwL1IKeWLXEAZfC8HSFwp2etTgyDAS2AsX2kkhmhhz7Se9LViGBUh1sUmhEHyr1Vz9GRAKutha5UYVRbgGu8yLeyhOb/djJ8apLwehc6REeDlP/7Pi4wdJ7kE6fOFTMhVqigYFSA1ewdHQ7JFXuea97CPmNlHVbwr8v7+wJFph3X/7VTM+CoMD9oq9smZkyDtgRVlwdxzwRVJu23xqUlz8k7g+Ra0DnnmJwaBQ7wqGGs1r+Myo2aOcjfY0LNPCfJ9iSs3aNrqqWj6ChQBJjPobLK2anWDEnxXXuIEe3/uV5FOlT1ZJB/ZZXiIayP3GFOFa5YziKq9wNYuQmB8vrK6HRmmUz7dkC9xQjELsFUPhFnTLmJhmE5MBtWLOA1wM/FgBmk5do9/mEK21kb94A6+SclpT9Nkh9l5kDV5+2jFkzcXEO82eJYROokvLK2ANwyR7l9txauCnQzv5CHeGKUL37JwwFOPm3x99E5xcMVo+jt7V7GXDBfPg5lu9w6SR7Xwa5NSE0yPbC2DpubgofjMcx+g73J7JvnzR041dp1bmF0QwDpvL1QOUkZmYS7GRG3GAHy8upVf7M0HJM9rgSAyMQJNKL1NJa9e8DkzyE6nUaAjQ/nYF2GucuDS2WATaIoNQIgOfgxaeG238w8oUMcdWm+Uto3e9Uen3Y7MICM4156Q4VqK3y0w3dc2qcXk/fPyJO9UCbXg8Djr28AezCa+BZzf7pF0GFPtAbtQk4E91iG541WknA=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 21cb00e1-3a67-4c6e-e6c0-08d7f2f54036
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2020 02:12:25.2734 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JsZJ8AOoolUwPJUJZzzXNOaXNNY0kxG1IE25PmdmbEs0MAupRwNLnqPkAJxhoDa/D3hLFRMkfEliUZVe5yOScA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1374
X-OriginatorOrg: intel.com
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Raj,
 Ashok" <ashok.raj@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Thursday, May 7, 2020 9:23 PM
> 
> Hi Kevin,
> 
> On 2020/5/7 13:45, Tian, Kevin wrote:
> >> From: Lu Baolu<baolu.lu@linux.intel.com>
> >> Sent: Thursday, May 7, 2020 8:56 AM
> >>
> >> When a PASID is used for SVA by the device, it's possible that the PASID
> >> entry is cleared before the device flushes all ongoing DMA requests. The
> >> IOMMU should ignore the non-recoverable faults caused by these
> requests.
> >> Intel VT-d provides such function through the FPD bit of the PASID entry.
> >> This sets FPD bit when PASID entry is cleared in the mm notifier and
> >> clear it when the pasid is unbound.
> >>
> >> Signed-off-by: Lu Baolu<baolu.lu@linux.intel.com>
> >> ---
> >>   drivers/iommu/intel-iommu.c |  4 ++--
> >>   drivers/iommu/intel-pasid.c | 26 +++++++++++++++++++++-----
> >>   drivers/iommu/intel-pasid.h |  3 ++-
> >>   drivers/iommu/intel-svm.c   |  9 ++++++---
> >>   4 files changed, 31 insertions(+), 11 deletions(-)
> >>
> >> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> >> index d1866c0905b1..7811422b5a68 100644
> >> --- a/drivers/iommu/intel-iommu.c
> >> +++ b/drivers/iommu/intel-iommu.c
> >> @@ -5352,7 +5352,7 @@ static void
> __dmar_remove_one_dev_info(struct
> >> device_domain_info *info)
> >>   	if (info->dev) {
> >>   		if (dev_is_pci(info->dev) && sm_supported(iommu))
> >>   			intel_pasid_tear_down_entry(iommu, info->dev,
> >> -					PASID_RID2PASID);
> >> +					PASID_RID2PASID, false);
> >>
> >>   		iommu_disable_dev_iotlb(info);
> >>   		domain_context_clear(iommu, info->dev);
> >> @@ -5587,7 +5587,7 @@ static void aux_domain_remove_dev(struct
> >> dmar_domain *domain,
> >>   	auxiliary_unlink_device(domain, dev);
> >>
> >>   	spin_lock(&iommu->lock);
> >> -	intel_pasid_tear_down_entry(iommu, dev, domain->default_pasid);
> >> +	intel_pasid_tear_down_entry(iommu, dev, domain->default_pasid,
> >> false);
> >>   	domain_detach_iommu(domain, iommu);
> >>   	spin_unlock(&iommu->lock);
> >>
> >> diff --git a/drivers/iommu/intel-pasid.c b/drivers/iommu/intel-pasid.c
> >> index 7969e3dac2ad..11aef6c12972 100644
> >> --- a/drivers/iommu/intel-pasid.c
> >> +++ b/drivers/iommu/intel-pasid.c
> >> @@ -292,7 +292,20 @@ static inline void pasid_clear_entry(struct
> >> pasid_entry *pe)
> >>   	WRITE_ONCE(pe->val[7], 0);
> >>   }
> >>
> >> -static void intel_pasid_clear_entry(struct device *dev, int pasid)
> >> +static inline void pasid_clear_entry_with_fpd(struct pasid_entry *pe)
> >> +{
> >> +	WRITE_ONCE(pe->val[0], PASID_PTE_FPD);
> >> +	WRITE_ONCE(pe->val[1], 0);
> >> +	WRITE_ONCE(pe->val[2], 0);
> >> +	WRITE_ONCE(pe->val[3], 0);
> >> +	WRITE_ONCE(pe->val[4], 0);
> >> +	WRITE_ONCE(pe->val[5], 0);
> >> +	WRITE_ONCE(pe->val[6], 0);
> >> +	WRITE_ONCE(pe->val[7], 0);
> >> +}
> >> +
> >> +static void
> >> +intel_pasid_clear_entry(struct device *dev, int pasid, bool pf_ignore)
> > Hi, Baolu,
> >
> > Just curious whether it makes sense to always set FPD here. Yes, SVA is
> > one known example that non-recoverable fault associated with a PASID
> > entry might be caused after the entry is cleared and those are considered
> > benign.  But even in a general context (w/o SVA) why do we care about
> > such faults after a PASID entry is torn down?
> 
> First level page tables are also used for DMA protection. For example,
> thunderbolt peripherals are always untrusted and should be protected
> with IOMMU. IOMMU should always report unrecoverable faults generated
> by those device to detect possible DMA attacks.

when untrusted devices are protected by IOMMU, I don't think PASID
entry (of RID2PASID) will have present bit cleared.

> 
> ATS/PRI devices are always trusted devices, hence we could tolerate
> setting FPD bit in the time window between mm_release notifier and
> unbind().
> 
> Best regards,
> baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
