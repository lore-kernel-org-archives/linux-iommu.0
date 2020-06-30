Return-Path: <SRS0=0Jez=AL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B575C433E0
	for <iommu@archiver.kernel.org>; Tue, 30 Jun 2020 03:01:36 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6268C2071A
	for <iommu@archiver.kernel.org>; Tue, 30 Jun 2020 03:01:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="x7RLnwHI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6268C2071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 3002E2034D;
	Tue, 30 Jun 2020 03:01:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id McHwQ+NDg1XN; Tue, 30 Jun 2020 03:01:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 1981820349;
	Tue, 30 Jun 2020 03:01:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F039CC0865;
	Tue, 30 Jun 2020 03:01:33 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5467DC016E
 for <iommu@lists.linux-foundation.org>; Tue, 30 Jun 2020 03:01:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 4F2B588515
 for <iommu@lists.linux-foundation.org>; Tue, 30 Jun 2020 03:01:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id K2cSYzXi7ZHZ for <iommu@lists.linux-foundation.org>;
 Tue, 30 Jun 2020 03:01:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 965C38853F
 for <iommu@lists.linux-foundation.org>; Tue, 30 Jun 2020 03:01:31 +0000 (UTC)
IronPort-SDR: WvqEG9l/izYlhKsYlKNnT7lW8kO0NIW571Jp3UgmxKm/JFy0UCUNZ3etyonTeB9/QXn7NfLVUu
 f8kAxcFhDzEA==
X-IronPort-AV: E=McAfee;i="6000,8403,9666"; a="144315487"
X-IronPort-AV: E=Sophos;i="5.75,296,1589266800"; d="scan'208";a="144315487"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jun 2020 20:01:31 -0700
IronPort-SDR: rZvobpWbzC1ulShMTOaMJtyG9zmkdBg7Pzhgd5qs5fWH4cKCHa6Pqdh+q9Nx6EkTHpRHgq8J8q
 Q4zTk4KiSCJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,296,1589266800"; d="scan'208";a="313257998"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
 by fmsmga002.fm.intel.com with ESMTP; 29 Jun 2020 20:01:31 -0700
Received: from FMSMSX109.amr.corp.intel.com (10.18.116.9) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 29 Jun 2020 20:01:30 -0700
Received: from FMSEDG001.ED.cps.intel.com (10.1.192.133) by
 fmsmsx109.amr.corp.intel.com (10.18.116.9) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 29 Jun 2020 20:01:30 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.173)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Mon, 29 Jun 2020 20:01:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=io1WU/8mt605AXfLy0MHTVrCgH1a44eMbyQH1Zjy2biOeIXr1KJ8Pigu6C1bUW+0ooa0nx3MSwd9LzXpIjcaRXdEPKxwoGQ6zMzlbuZOgZo8f5fknm3fLik9o78YWqBPP+1l6Nwe674dhWiiJaYmStJNh2V5l6P2pCJtqE8YOPPjpn2Jfb2Ofdwr/tBsMlF7tDIlRjX4cjAO1t73+2vrFLGm0kDfLkcv2pR2cc0zEDaty3xdtuORBRal86Vfzz5xSoDtgfyhhc5NUuA4TOWZc83ID03/XR5HEC97dD5xlY7L/mOIHIa1HCUjCXmsd+p4RRc6HODoA2bl6w/0kLdB0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=do3KWTwRQPgVIYDXXIktkDjDNP7GvFKJrMAM6kMnD0Q=;
 b=J2deRoV9MR7tOqlVZLrNZUM5mUR5SLnznBeZXmaJA6ZX8HIuwMfb3rlzrRQLJwfM0wIPQ+AtCt30V5mH8frCVTSm2Hje1YJooHnx9+HfRJOEApvB24dG+GBndJHlrsGHfSiSANzbwSsFxTzmowRne8bw6hmiBOI7WlGzrNQNwrTWJ+EfkU+3O+HL9xBlmKuiD1N9t85S9uO9pyZonvQ93B8lr6INTQVCaGuB/AB7MzVWmvafKCdtGhvVD4hDt8vKK15Gin/B9OTqZsU/+4rDVP+l/jUE9x+TVzbFivhfd1Upmfi513lhjL5N1Wbp8OkznqKYGc/HljM4yvw26xf32A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=do3KWTwRQPgVIYDXXIktkDjDNP7GvFKJrMAM6kMnD0Q=;
 b=x7RLnwHIkWnGNWCTaGr+Jmm9Y9pjxrTUQ9y+q6OEHSuQAJvE5oe96NrWdK/zmlDPH8flGPV1BY3kAN03+61u+f9YNZlBj6ytbidwIfA5om6zOnu0HHsCr/daZoIxYqW6Ns1GCMNHlmSzqbzOIfpuFk+AEN3o5zsgpA14hjjmEbA=
Received: from MWHPR11MB1645.namprd11.prod.outlook.com (2603:10b6:301:b::12)
 by MW3PR11MB4666.namprd11.prod.outlook.com (2603:10b6:303:56::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21; Tue, 30 Jun
 2020 03:01:29 +0000
Received: from MWHPR11MB1645.namprd11.prod.outlook.com
 ([fe80::9864:e0cb:af36:6feb]) by MWHPR11MB1645.namprd11.prod.outlook.com
 ([fe80::9864:e0cb:af36:6feb%5]) with mapi id 15.20.3131.027; Tue, 30 Jun 2020
 03:01:29 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, Jacob Pan
 <jacob.jun.pan@linux.intel.com>, "iommu@lists.linux-foundation.org"
 <iommu@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>,
 Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>
Subject: RE: [PATCH 3/7] iommu/vt-d: Fix PASID devTLB invalidation
Thread-Topic: [PATCH 3/7] iommu/vt-d: Fix PASID devTLB invalidation
Thread-Index: AQHWSXQh0KL5ddeuG0+Q8wSlo27Zdqjo8NSAgAeRpCA=
Date: Tue, 30 Jun 2020 03:01:29 +0000
Message-ID: <MWHPR11MB1645B3CAC72D63AD535FD6DC8C6F0@MWHPR11MB1645.namprd11.prod.outlook.com>
References: <1592926996-47914-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1592926996-47914-4-git-send-email-jacob.jun.pan@linux.intel.com>
 <57091f4a-fb53-40a4-6a28-a498f548f8b8@linux.intel.com>
In-Reply-To: <57091f4a-fb53-40a4-6a28-a498f548f8b8@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.147.207]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 443614af-595e-4847-4691-08d81ca1e300
x-ms-traffictypediagnostic: MW3PR11MB4666:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW3PR11MB4666CDC20377B96C938A72F78C6F0@MW3PR11MB4666.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0450A714CB
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: x7JyaneNpQ0dq/xR3B2E8CPGSbwCF3Bi7GpcG0Y9APAZMJox52E4x5ePdf+zN4DsqbARZV1MlSNFGdBFBexNLmNLlXowPAlhfMZIYk+rXgXT+fk7rLWmOUX0ah2vApXV9UMZMdYDebpD3+NGeptr5soJU5CP7+yfaTxyauFisbPuM/Z5S+gjOzh4/I5lftqjHjg4JT/vPWJW868bv+U1cbR4k3GQWESlSCI+EtOBjo8ekEQ9WLPHXnLqE09U6xjAujNdH+AvLYzlwqWgMdIGj36nWomko/rW3CcNrA+MmktwEyCCj7s1IJJZh1Fw7YcSzNxWzvNuffa6Ji4KeMI7hw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR11MB1645.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(136003)(366004)(376002)(346002)(396003)(33656002)(66446008)(316002)(66556008)(478600001)(76116006)(4326008)(66946007)(66476007)(2906002)(7696005)(64756008)(55016002)(9686003)(5660300002)(6506007)(8936002)(110136005)(26005)(54906003)(52536014)(8676002)(186003)(86362001)(53546011)(83380400001)(71200400001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: kP5hIRVf63SgTafsi4gcEOpvZ1/cihzrVexg9nXP7ef62TimrUIyH1+WYD026WW3fEhweZlReNqS4lX60sC8+zp9uVIP0plla3AMlABHwbUttNgcjFOBnlrlmL6V/3IH7AegDSl8kPyaAGRQq8r64FmCJ2XAqOy5OMiRfeNM79wQA186Sp94Q/4lZ0uCZ364JSk3G4HOpxlgeoJoXxi7DDEqfC1rtHB2zDWegkd9n9L6w0uK9tcIX2T9BXNdrlqkvKRMvXx0UTiy5J69jwEzsO1YLHFoa0jlzF2LyJdnfWR+obqOIT6FR3rRXCIG0dtZGC4u99eB/5hrIZ8ZJK+Wkt7n7eVNB6PjJxRRmMXQpUuYIa9gz4xmwcg/jBhqkbScBCwPIGu0SqHNzwfNU9mBCNqbVSRlKc2xtWybRMaj1t4mXBVkEpHb5N8036g2iRcSm1p5IEobaG7CedEqYD7RSHP/rXlNuD6F4dWYIpcXqjDRH/9nN/6nvudelVV2Q5uw
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1645.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 443614af-595e-4847-4691-08d81ca1e300
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2020 03:01:29.4454 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mMyptfyuk2qxNXgV3VcIUclY17mdpXMeiEf/1dYHjDmzEffMnHu/zRexckppNmc7O7wmFbvrf6zvfKb+1PErkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4666
X-OriginatorOrg: intel.com
Cc: "Raj, Ashok" <ashok.raj@intel.com>
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
> Sent: Thursday, June 25, 2020 3:26 PM
> 
> On 2020/6/23 23:43, Jacob Pan wrote:
> > DevTLB flush can be used for both DMA request with and without PASIDs.
> > The former uses PASID#0 (RID2PASID), latter uses non-zero PASID for SVA
> > usage.
> >
> > This patch adds a check for PASID value such that devTLB flush with
> > PASID is used for SVA case. This is more efficient in that multiple
> > PASIDs can be used by a single device, when tearing down a PASID entry
> > we shall flush only the devTLB specific to a PASID.
> >
> > Fixes: 6f7db75e1c46 ("iommu/vt-d: Add second level page table")

btw is it really a fix? From the description it's more like an optimization...

> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > ---
> >   drivers/iommu/intel/pasid.c | 11 ++++++++++-
> >   1 file changed, 10 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
> > index c81f0f17c6ba..3991a24539a1 100644
> > --- a/drivers/iommu/intel/pasid.c
> > +++ b/drivers/iommu/intel/pasid.c
> > @@ -486,7 +486,16 @@ devtlb_invalidation_with_pasid(struct
> intel_iommu *iommu,
> >   	qdep = info->ats_qdep;
> >   	pfsid = info->pfsid;
> >
> > -	qi_flush_dev_iotlb(iommu, sid, pfsid, qdep, 0, 64 - VTD_PAGE_SHIFT);
> > +	/*
> > +	 * When PASID 0 is used, it indicates RID2PASID(DMA request w/o
> PASID),
> > +	 * devTLB flush w/o PASID should be used. For non-zero PASID under
> > +	 * SVA usage, device could do DMA with multiple PASIDs. It is more
> > +	 * efficient to flush devTLB specific to the PASID.
> > +	 */
> > +	if (pasid)
> 
> How about
> 
> 	if (pasid == PASID_RID2PASID)
> 		qi_flush_dev_iotlb(iommu, sid, pfsid, qdep, 0, 64 -
> VTD_PAGE_SHIFT);
> 	else
> 		qi_flush_dev_iotlb_pasid(iommu, sid, pfsid, pasid, qdep, 0,
> 64 -
> VTD_PAGE_SHIFT);
> 
> ?
> 
> It makes the code more readable and still works even we reassign another
> pasid for RID2PASID.
> 
> Best regards,
> baolu
> 
> > +		qi_flush_dev_iotlb_pasid(iommu, sid, pfsid, pasid, qdep, 0,
> 64 - VTD_PAGE_SHIFT);
> > +	else
> > +		qi_flush_dev_iotlb(iommu, sid, pfsid, qdep, 0, 64 -
> VTD_PAGE_SHIFT);
> >   }
> >
> >   void intel_pasid_tear_down_entry(struct intel_iommu *iommu, struct
> device *dev,
> >
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
