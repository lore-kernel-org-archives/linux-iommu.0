Return-Path: <SRS0=32yV=6V=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14154C47257
	for <iommu@archiver.kernel.org>; Thu,  7 May 2020 06:37:10 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8CBB2078C
	for <iommu@archiver.kernel.org>; Thu,  7 May 2020 06:37:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="posz9yWs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8CBB2078C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 8AB3788156;
	Thu,  7 May 2020 06:37:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Fe+Xz4ddsahi; Thu,  7 May 2020 06:37:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 7D7468815A;
	Thu,  7 May 2020 06:37:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 681C4C0859;
	Thu,  7 May 2020 06:37:08 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1C170C07FF
 for <iommu@lists.linux-foundation.org>; Thu,  7 May 2020 06:37:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 0A0E087B5B
 for <iommu@lists.linux-foundation.org>; Thu,  7 May 2020 06:37:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yhlXFX63Sufh for <iommu@lists.linux-foundation.org>;
 Thu,  7 May 2020 06:37:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by hemlock.osuosl.org (Postfix) with ESMTPS id F009D87B45
 for <iommu@lists.linux-foundation.org>; Thu,  7 May 2020 06:37:05 +0000 (UTC)
IronPort-SDR: xTScMQs6tGtpvSb+JK9tZSxUuQTV2JDR544iWGg7WEe3Jvfjt1tOzfO9TvCiV4z2Jl8ThUIY2V
 gri1+6ODAcow==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 May 2020 23:37:05 -0700
IronPort-SDR: 8jk5RGkotiY5dqYGt2w5f7WBCS+FDzzhnI1GwLN9Qf8q6R0zo9l5Hx8N0iebgIYmHksgEF0C1Y
 n84hRBSyIVig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,362,1583222400"; d="scan'208";a="435173728"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
 by orsmga005.jf.intel.com with ESMTP; 06 May 2020 23:37:05 -0700
Received: from fmsmsx154.amr.corp.intel.com (10.18.116.70) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 6 May 2020 23:37:04 -0700
Received: from FMSEDG001.ED.cps.intel.com (10.1.192.133) by
 FMSMSX154.amr.corp.intel.com (10.18.116.70) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 6 May 2020 23:37:04 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (104.47.37.51) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (TLS) id 14.3.439.0; Wed, 6 May 2020 23:37:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rdc4W0OINrD+X5T2NW1Qtn7eKTTxDZA76+78ytFepvz5Ihl8HeieA86J3XHJ3ARUG5+WWH5DG+stKZPWn5i7ZamOtKvkJ8bLXIckW4Xe2bUyeQ1UWxsJEJytilDN6xr4M6+yRQAU9cu0hKtck/jEG+5ekbFSbBiBjOGb19DwcoKc3JNWiTcYWRLYAp0H8HRLmlBh/lQBU2w0X7HAnNfMprmTgXHdNAScXyIAX98KzURByuMr9j4Y+OSh8FwZ4VBClERQjQLeiq907Xrx7zSghv+IuaokW8+YIXKcKG3Axwm08aw4K2DdS/g0ldnjKCTBkAaQOD9zbN7N9yIfz1VqaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HcOhJjG9WIveXdvVjiMFEA/Nra/PrUO3pbY88iy+S5o=;
 b=AUNqoB6Y4n+qP2iYVm0mxM5ebaOsKfCf4RlbD6MbrHyDvlhcj8Zcxy+beef0Ui5OXmKaJq2RPrE26HN/EkNntrmQSqbzkc3qfiJPb9aI6Umuk5hu+wtkqeYSjzKv29lZPZAnpjRMqPvquGbdcF4SXoDdJLE1jXeTcAwa05DbZ0MyzPcL9GrSSMB7jlq5oWBbQWcpDK5MjMx2pMzIWupBvZR1g2xR9hMjWQne3t4wDMXPammSPb8fhvwxbOcUK3Ntc6urNZS6sSWxxbvMGJNuH3vqVVi5DCKJpBSR6Trtye33O7KRZxzgnkkoJEHlyCnLRypoDy4rsXllyoTEe1VtuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HcOhJjG9WIveXdvVjiMFEA/Nra/PrUO3pbY88iy+S5o=;
 b=posz9yWsoJMy/Ke4yeEjOa+i/sG+1nYYfsibKkYgip/yLK8n72wulBpdAuXohiS0/4aN0os1+2OOMMUSoOCPMf/fIec+tqP9dRZ1doEIfAARL1FLvP30kDFKPLkOkLeD1zLbyNNW+dQag0a5heXqLEa3ZJtx2x8NGaLq8oYrIWA=
Received: from MWHPR11MB1645.namprd11.prod.outlook.com (2603:10b6:301:b::12)
 by MWHPR11MB1807.namprd11.prod.outlook.com (2603:10b6:300:112::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.28; Thu, 7 May
 2020 06:37:02 +0000
Received: from MWHPR11MB1645.namprd11.prod.outlook.com
 ([fe80::bc06:71a6:1cdd:59be]) by MWHPR11MB1645.namprd11.prod.outlook.com
 ([fe80::bc06:71a6:1cdd:59be%9]) with mapi id 15.20.2979.028; Thu, 7 May 2020
 06:37:02 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>
Subject: RE: [PATCH v4 5/5] iommu/vt-d: Remove redundant IOTLB flush
Thread-Topic: [PATCH v4 5/5] iommu/vt-d: Remove redundant IOTLB flush
Thread-Index: AQHWJArPGqJyDnNz4U+UxtCjnL/77KicK6HQ
Date: Thu, 7 May 2020 06:37:02 +0000
Message-ID: <MWHPR11MB16459175B02D3DAE0109E6F48CA50@MWHPR11MB1645.namprd11.prod.outlook.com>
References: <20200507005534.3080-1-baolu.lu@linux.intel.com>
 <20200507005534.3080-6-baolu.lu@linux.intel.com>
In-Reply-To: <20200507005534.3080-6-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.55.52.202]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 44c3b933-adb4-4801-a103-08d7f2510d67
x-ms-traffictypediagnostic: MWHPR11MB1807:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR11MB180721FD4625EAF8AEB810E28CA50@MWHPR11MB1807.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2150;
x-forefront-prvs: 03965EFC76
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZuVcaFFDiOh1cbOmDfUJ2wR6od8PK3ipFyPjn4QagavnGCbET8TnntZsr6Bu6CH6HmKDJgKwQpWk/kv0cTickuMmbxz2TPm22H8DZFqB+A09a+3mu4n8bVd+khI+9QvlfJ4sk+pF7IeoH+UYHyZ1JQJO3IEpya793dwF9zSunK0UTEWN7bfaslrEkNBmiOexocl7yWvFL88NKdSphKFn5JGf51gAWMTg8kDA0WgZlOWH0KGwz3kSPLWVUaIioeRJw8A2+x7TBPJ01SwsyufNbr0MQDSVysSbM67Ptbc3edBNC7HZM0utVTH4msnaFcCiMhM1ujaVV6Nwk1oG7wIgI3UF3zEACd29S5e6r1WP5B8bdNKKHSYSn6KIueWECpv9wmI4gh/noXC/gIrJdY6XMWZ0xGsYLkgPenVZQfRnYwYctFwlGwoNACUx/8rc2s/YVsyIevvbUV/mMQ5AtLbsycA3Cb3lQQDXp3Z4ANinmg0bCcWTnK4kv7n72v1jDDuQyG4y+Ek/2vv+PYpR5K9DWw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR11MB1645.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(396003)(39860400002)(136003)(366004)(376002)(346002)(33430700001)(478600001)(76116006)(5660300002)(4326008)(110136005)(66556008)(64756008)(66476007)(8936002)(66946007)(66446008)(54906003)(316002)(8676002)(86362001)(26005)(2906002)(186003)(71200400001)(7696005)(6506007)(33656002)(33440700001)(9686003)(55016002)(83280400001)(83320400001)(83300400001)(83290400001)(83310400001)(52536014);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: AtorIBVZxSuT3CI4FC3XvpKNr9nhw4RKbMkfWREdBehPyaPAavggjDTq/pLRvm2z12xvIvYdRv/p00Q4wQp7e+tnVwuIm/EosmQ46cTO7+DFnujk04h/t+r9fTae/M/bHYwA3hyEr3OM1Z0SONsnIpJZe0xDFD8NcxmhYSdXLm1rLnMRrZcczhGGRBR1en8NczyE+bRJYUwfbSHqpPsCUX9AGIfpBYi1G1Fl6Lt6LL0eccmPuiIP0alE+kGelZl+M4uL12XqrQ1EkMnzOm7Yk5lBd7YNbLGrldg2oE7E7gSyswBU2fnJfFIx8DYGdsdkAMmypraEb65gSYuknIfDEQ6l/nfJhW6IrwofHyikG80aVc4Hc46vIiHfBPVgQLTXZtJgFF5LdVtYBzY5+eM56d3w0L9ioQddHFlEYYUpfnCmCqVRMfZFJCJjpua1jDDgabM2+rblSh7QfVDe6a60lX+MM7EkfiU96Ei4UALUw8TMZsS+SYUobQ8jybVmwmYhC2Z0BdHMDfpKu/7V2fWVfbQx8nTDRB921NE2AQgp5ucQHye6PN7cEDcOZ675cUl/wMBIm/IWOm1ghYQi7CZQwXobUMDfawtO/tU3BoTmxKjgQhcciLSHspLU4A7V2IY3/2i4Lf/t3RhOVw2ua+C0rukhZopAkBZDnrlVnkOOiOKQHF/J0E27nBDDHfYu+82kLPVWHUxcaESRrJMy8FxoG8lJTkoq2S0POs0KsN8CCGiFDr9wlW9rwckgxQkuqgr3HgYDzSuHV8O5ejrRgQjBzJcXnQqrj9id4xHUiBuIN9Q=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 44c3b933-adb4-4801-a103-08d7f2510d67
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2020 06:37:02.6283 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YvQ0Nec4NxmL2Tfr3SxHjuXMqsODHn/NIH85LrPCvdYBuHjuB3DKjzaeZlGGsFLBAI3G6sr/l06qCbCXPatfTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1807
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

> From: Lu Baolu
> Sent: Thursday, May 7, 2020 8:56 AM
> 
> IOTLB flush already included in the PASID tear down and the page request
> drain process. There is no need to flush again.
> 
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/intel-svm.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
> index 7256eb965cf6..5ff05adc96e9 100644
> --- a/drivers/iommu/intel-svm.c
> +++ b/drivers/iommu/intel-svm.c
> @@ -209,11 +209,9 @@ static void intel_mm_release(struct mmu_notifier
> *mn, struct mm_struct *mm)
>  	 * *has* to handle gracefully without affecting other processes.
>  	 */
>  	rcu_read_lock();
> -	list_for_each_entry_rcu(sdev, &svm->devs, list) {
> +	list_for_each_entry_rcu(sdev, &svm->devs, list)
>  		intel_pasid_tear_down_entry(svm->iommu, sdev->dev,
>  					    svm->pasid, true);
> -		intel_flush_svm_range_dev(svm, sdev, 0, -1, 0);
> -	}
>  	rcu_read_unlock();
> 
>  }
> @@ -407,7 +405,6 @@ int intel_svm_unbind_gpasid(struct device *dev, int
> pasid)
>  			intel_pasid_tear_down_entry(iommu, dev,
>  						    svm->pasid, false);
>  			intel_svm_drain_prq(dev, svm->pasid);
> -			intel_flush_svm_range_dev(svm, sdev, 0, -1, 0);
>  			kfree_rcu(sdev, rcu);
> 
>  			if (list_empty(&svm->devs)) {
> @@ -647,7 +644,6 @@ int intel_svm_unbind_mm(struct device *dev, int
> pasid)
>  			intel_pasid_tear_down_entry(iommu, dev,
>  						    svm->pasid, false);
>  			intel_svm_drain_prq(dev, svm->pasid);
> -			intel_flush_svm_range_dev(svm, sdev, 0, -1, 0);
>  			kfree_rcu(sdev, rcu);
> 
>  			if (list_empty(&svm->devs)) {
> --
> 2.17.1

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
