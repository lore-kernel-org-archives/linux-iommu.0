Return-Path: <SRS0=8RI2=CG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADE29C433E2
	for <iommu@archiver.kernel.org>; Fri, 28 Aug 2020 01:33:57 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F68E20872
	for <iommu@archiver.kernel.org>; Fri, 28 Aug 2020 01:33:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="JeiFSxiH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F68E20872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 36E0C864D4;
	Fri, 28 Aug 2020 01:33:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NcxzBtcERbvH; Fri, 28 Aug 2020 01:33:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 53A7F86124;
	Fri, 28 Aug 2020 01:33:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3D0E1C016F;
	Fri, 28 Aug 2020 01:33:56 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 43FB7C0051
 for <iommu@lists.linux-foundation.org>; Fri, 28 Aug 2020 01:33:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 332DF882ED
 for <iommu@lists.linux-foundation.org>; Fri, 28 Aug 2020 01:33:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9rTEhA+cijQA for <iommu@lists.linux-foundation.org>;
 Fri, 28 Aug 2020 01:33:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 1AEC8882CC
 for <iommu@lists.linux-foundation.org>; Fri, 28 Aug 2020 01:33:52 +0000 (UTC)
IronPort-SDR: OnZqdfsl8tn4KBzdh58OI4NXrtsZ/r7QTHZRHInBDwH/mf0toNfsD46emvKP57oKwZmZV6qSLP
 A+AAGxziUcgw==
X-IronPort-AV: E=McAfee;i="6000,8403,9726"; a="154140285"
X-IronPort-AV: E=Sophos;i="5.76,361,1592895600"; d="scan'208";a="154140285"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Aug 2020 18:33:52 -0700
IronPort-SDR: 05t/14MdG/I7uDOKWUYyf4Hcv4IYpWmhrC7KGryFZZBKTBpgbiwjcNf4FEdZ7nr57KUosAE2q/
 gp5+Wh49r+2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,361,1592895600"; d="scan'208";a="329793601"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
 by orsmga008.jf.intel.com with ESMTP; 27 Aug 2020 18:33:51 -0700
Received: from fmsmsx606.amr.corp.intel.com (10.18.126.86) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 27 Aug 2020 18:32:35 -0700
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 27 Aug 2020 18:32:35 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.41) by
 edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server
 (TLS) id 14.3.439.0; Thu, 27 Aug 2020 18:32:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mpCnoZzSTa1AuCBkiUnKp/EfrTS3LlYFNIJqw25nkQtxY2QsMGc1dgi9U51BtJ88RI7YPTWJPl9FBvdJ17ZzfwrnNvOIHnD+YEe/q7DwqkV+M8sru89Xizip7TOu9EHfayUaLNJCq1gOMwTZLGKuzlTalNgkwKrgv1OHZ34xqzqbQAlnY6IzqsQZbRwHyM2pzPX5JxxNfObbooMXFEmyuu/it4AJ1AZxFM98lodLDnNChghPTmDLZnqhf6XTNK+uccfoNhpiMb2GAKbLnl7tM9k6lnv3Tl5aPNGNto9dhuVFBa/zRJ6c+LJMQWHUtUkGC/xuY6OA2qyKBIN9DPVvHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kbU24cWYlh4+unlOhffa3mXZFB9jHSMa2pLbonvTowg=;
 b=QUOoxsUkRDRJkdnBqOCDaYGLcALVmOJAV/g5Xki3T3J2aNJCDtO09vtHM6vl+PHr+VvViZSQvF3ya3CSoCPXbhvnoLDPV9JKwT3cOX4TC7ouuTDftb9TRo55YjVQUSwp18hNA9iVpYo3W8l3Dmxv8Sy9t2mAkCOYqKGFKIZVcz4yJeHP7SY207/ke+5373yUTF0VKYjNSCFLLxmH3h7lSd4HHSa+2dN+E6p0ZPnDmWwXwcqHm3po4f/vAOZlCLcfanBqEr2AU6orDNwVWm5Vvqzot8SvFP1fJLK1Lpnzdfkwrbr62pAzrAwzsZ1ctlGEQILlKilZ7yzjq4qekO/M+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kbU24cWYlh4+unlOhffa3mXZFB9jHSMa2pLbonvTowg=;
 b=JeiFSxiH2p9Xz/Y72lfxaYI/JkVpWwbii95QODZW1HJ9nMctcQx5B3ktfoZ5wbzYMIEMbpq5ZnMRoL5eRjP+phIJZ0n7wje03ia+fpiz1rEIImZMrOBQvi3fFlAnIKj9S0bUbTVsH79rOIuUEj37au4XAd6B+ofM6ggSVCaJYzg=
Received: from MWHPR11MB1645.namprd11.prod.outlook.com (2603:10b6:301:b::12)
 by MWHPR1101MB2095.namprd11.prod.outlook.com (2603:10b6:301:5b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25; Fri, 28 Aug
 2020 01:32:32 +0000
Received: from MWHPR11MB1645.namprd11.prod.outlook.com
 ([fe80::6dfe:feb8:25f1:ac9c]) by MWHPR11MB1645.namprd11.prod.outlook.com
 ([fe80::6dfe:feb8:25f1:ac9c%7]) with mapi id 15.20.3326.023; Fri, 28 Aug 2020
 01:32:32 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>
Subject: RE: [PATCH v3 1/1] iommu/vt-d: Serialize IOMMU GCMD register
 modifications
Thread-Topic: [PATCH v3 1/1] iommu/vt-d: Serialize IOMMU GCMD register
 modifications
Thread-Index: AQHWfM/j6AUtGbmmA060Vwjc7g7XzqlMvGyA
Date: Fri, 28 Aug 2020 01:32:32 +0000
Message-ID: <MWHPR11MB1645978AC5FCA5954174C8E48C520@MWHPR11MB1645.namprd11.prod.outlook.com>
References: <20200828000615.8281-1-baolu.lu@linux.intel.com>
In-Reply-To: <20200828000615.8281-1-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.147.210]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b1dadd58-c8a2-441b-6894-08d84af23c3b
x-ms-traffictypediagnostic: MWHPR1101MB2095:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR1101MB2095DB84F58C45E32EE2C71E8C520@MWHPR1101MB2095.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TwkRJMnyjsceAVdNw649BagOFHfvi9I5IfFIGOl64zQElklH24KqndeLjptkDCs22aMbB7AZ+o2sjW50DBNbX/7E1fKlkqbef/Tn56KQLyrS/hnuZ9ceOK0eYGJo0n/egQailFqsb8Xa2YMHrzUl+wQBWWZtSgqR1naYDpupigIAS3f+wiyPGtcy+5cQn5s19ePsKAzYnCAXCyUIkOcC16lGGrVQaKMnhU5l7ApHoODRk2e80D9qbS6EtG2GSXqYzQMh2PHUdkJJiY1ys2Bbb3KH2SRUhnL9US2wnvvxi+xBHkmdsFG/DtJ5hLiWBmzemmZUUM/YWWO8zqHomgkD7KsKKkC3cxf92Q4yyu84vbMdP2lPpJDxU5/LYbG4fzIgA/Ylw/FyE0/uhv79cVv4fQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR11MB1645.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(39860400002)(376002)(136003)(346002)(33656002)(64756008)(66446008)(66476007)(6506007)(71200400001)(66946007)(66556008)(76116006)(26005)(186003)(110136005)(7696005)(316002)(9686003)(55016002)(83380400001)(54906003)(86362001)(8936002)(4326008)(8676002)(5660300002)(2906002)(966005)(478600001)(52536014);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: qgTOnCIEOcQPsmmwm/m8zuJz/Z/wR20IfATQfqtK/YlWvUTlVNK046LRj3OAOFyPZIMy3fVQ+fNN3PJj2YFIaeX/h3ooorgxrYoVyWaANvbI9GE6+ZpapgswlYkehKExH8qTXp/y6igluG/QsQoCc+Yk/Ggshfd4mDToJi7EPSQ+7htWZmuznTX2zAJihTUyBA+uVzfs83m0B9XQKS6q3jblDLBSYzZU5AhYVVZcoKKujkSV3RVMbTWNs9l6TJk5xn9I1DvXKPwigfg9MhZlczDX8YTicJitLdw5rtVVe/Rrz3NRlwdF4TtI7sSb8DvbOZCDVWmQ+Nqh7ZjkWtaqwS3w3o7UqFWeH7PPdEyv9WrfUBPJc8wf1JGkNS57vlheNVW1FAT8We5BOhUuhd3j8P1UYJ8YWljSV5ipyJELi231qLWJ/ogPrqc3Dp0y8zw3g9VXntv9fDVUjEwO4LQUys45INdHOklYLdgeP5Mv7BZDJ+N5cf0Z4SK4CxikA4vJYk1mIS6nTDsDwOHUirZTiocU5xEHh6dY2uxncyGPYOW5rgFZbcuZDuQDSoyAb946guDLxWfs5EpAyLiqiJZXsbdCKZQJJp99Xppn0JJkQbpkXfkrjnimmkLTk20MBC/IQtleLsBjOYtX31A7cdf0HQ==
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1645.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1dadd58-c8a2-441b-6894-08d84af23c3b
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2020 01:32:32.5092 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TTwm9P1sxxMpAi838OtmPX+gqWFzjb7/ApgtWKDCIlWckQT6p7gdF1beQfp+rCGAv6EdB7K4tbkUZ7DUWwcZBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1101MB2095
X-OriginatorOrg: intel.com
Cc: "Raj, Ashok" <ashok.raj@intel.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andy
 Lutomirski <luto@amacapital.net>
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
> Sent: Friday, August 28, 2020 8:06 AM
> 
> The VT-d spec requires (10.4.4 Global Command Register, GCMD_REG
> General
> Description) that:
> 
> If multiple control fields in this register need to be modified, software
> must serialize the modifications through multiple writes to this register.
> 
> However, in irq_remapping.c, modifications of IRE and CFI are done in one
> write. We need to do two separate writes with STS checking after each. It
> also checks the status register before writing command register to avoid
> unnecessary register write.
> 
> Fixes: af8d102f999a4 ("x86/intel/irq_remapping: Clean up x2apic opt-out
> security warning mess")
> Cc: Andy Lutomirski <luto@amacapital.net>
> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Cc: Kevin Tian <kevin.tian@intel.com>
> Cc: Ashok Raj <ashok.raj@intel.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/intel/irq_remapping.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> Change log:
> v1->v2:
>   - v1 posted here
>     https://lore.kernel.org/linux-iommu/20200826025825.2322-1-
> baolu.lu@linux.intel.com/
>   - Add status check before disabling CFI (Kevin)
> v2->v3:
>   - v2 posted here
>     https://lore.kernel.org/linux-iommu/20200827042513.30292-1-
> baolu.lu@linux.intel.com/
>   - Remove unnecessary register read (Kevin)
> 
> diff --git a/drivers/iommu/intel/irq_remapping.c
> b/drivers/iommu/intel/irq_remapping.c
> index 9564d23d094f..a91dd997d268 100644
> --- a/drivers/iommu/intel/irq_remapping.c
> +++ b/drivers/iommu/intel/irq_remapping.c
> @@ -507,12 +507,18 @@ static void iommu_enable_irq_remapping(struct
> intel_iommu *iommu)
> 
>  	/* Enable interrupt-remapping */
>  	iommu->gcmd |= DMA_GCMD_IRE;
> -	iommu->gcmd &= ~DMA_GCMD_CFI;  /* Block compatibility-format
> MSIs */
>  	writel(iommu->gcmd, iommu->reg + DMAR_GCMD_REG);
> -
>  	IOMMU_WAIT_OP(iommu, DMAR_GSTS_REG,
>  		      readl, (sts & DMA_GSTS_IRES), sts);
> 
> +	/* Block compatibility-format MSIs */
> +	if (sts & DMA_GSTS_CFIS) {
> +		iommu->gcmd &= ~DMA_GCMD_CFI;
> +		writel(iommu->gcmd, iommu->reg + DMAR_GCMD_REG);
> +		IOMMU_WAIT_OP(iommu, DMAR_GSTS_REG,
> +			      readl, !(sts & DMA_GSTS_CFIS), sts);
> +	}
> +
>  	/*
>  	 * With CFI clear in the Global Command register, we should be
>  	 * protected from dangerous (i.e. compatibility) interrupts
> --
> 2.17.1

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
