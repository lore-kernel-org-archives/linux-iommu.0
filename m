Return-Path: <SRS0=s4mY=HE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE126C433DB
	for <iommu@archiver.kernel.org>; Tue,  2 Feb 2021 02:51:38 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F14664DC4
	for <iommu@archiver.kernel.org>; Tue,  2 Feb 2021 02:51:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F14664DC4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id BF99086730;
	Tue,  2 Feb 2021 02:51:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9mu-yUl0A8ES; Tue,  2 Feb 2021 02:51:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 0D56C86443;
	Tue,  2 Feb 2021 02:51:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E551BC0174;
	Tue,  2 Feb 2021 02:51:36 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 14599C013A
 for <iommu@lists.linux-foundation.org>; Tue,  2 Feb 2021 02:51:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 071C585533
 for <iommu@lists.linux-foundation.org>; Tue,  2 Feb 2021 02:51:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id w7Wp-Jm_I3i1 for <iommu@lists.linux-foundation.org>;
 Tue,  2 Feb 2021 02:51:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 15010854B4
 for <iommu@lists.linux-foundation.org>; Tue,  2 Feb 2021 02:51:35 +0000 (UTC)
IronPort-SDR: k9zd1KN4daIH8ymEUfeGMJvBKWlDkUPiv1EiSxWQ526XpzapjN/56PbwGoMtg9KLUfcfyi6w9Z
 FPuLH86shBJA==
X-IronPort-AV: E=McAfee;i="6000,8403,9882"; a="177279111"
X-IronPort-AV: E=Sophos;i="5.79,393,1602572400"; d="scan'208";a="177279111"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Feb 2021 18:51:33 -0800
IronPort-SDR: khm3BZdAsfu74Occ8OnHG2vO8hswtJRPiLnEMluv9KggU5DPIkzBkemravpHGsZxvwKn/sND8L
 Vd1vaz2dla2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,393,1602572400"; d="scan'208";a="354713343"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
 by fmsmga007.fm.intel.com with ESMTP; 01 Feb 2021 18:51:33 -0800
Received: from orsmsx606.amr.corp.intel.com (10.22.229.19) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 1 Feb 2021 18:51:32 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Mon, 1 Feb 2021 18:51:32 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.106)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Mon, 1 Feb 2021 18:51:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MMLeDUDAcaIwfKwYHT+R4vLE5yh1rF6i/F+VzxIPgkbWoGt7JDxa/4bwMvOdEzabwcamLgT9RTk2FPZi3W5J0w9W/yNHIoyS7klpTQKlalt91jeq7a0q6TTyEJxFKKllgw8Ug6tT7XwdMm5RZgaa15F3Csv8bVeNtHmsnyPXiQEx5abHeZJstbakrPgyhRNhnxf+amrqsasbA5TF1Yh+wII839Go7jV+1OqFzfr0+kRR/Oqw0yM/zQr5JSBkDpG/8YRJPH2kR1qyO2M1j4ZPZ/WFcD9dLfOUDfLwE66DUV9C1koFEPuVoK27BVOLPLAIJ0JpKCO38IOAppRBTVaYsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8z850udIdmmeGi3rL3eL46GEAkSl0abkPxSbhwNYqwg=;
 b=m7cejZ26Ifpu3ff2NKRRyntYIr9/WesS5k7kxgek3pnjQ7Ruw4Hyxi2KWI5fygXDDaFln5V2Z546hVs7R+lETyQZpS/H/3HX0mj+ddL639RgB9IY4vCzaO90yrUBMtDyiqJurY4KOcZNqgo+IaxfK55y+AOgACUlWiyOcb8HdlQdfHL9e2Qx4ILkePG4IDxHs/daxS7NTxGTWHot8iQjhPJSJkS1xeDx0ysiFlj9TdPKl6O8oGh8crKm0F8Qlri4inrLs6fpYdUMuaDRkjnq9mCelzegL/s50kENShxFzLn3P8X63t3dKj8YyWzShyRHXXiSLukNd8iTN9162UzsMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8z850udIdmmeGi3rL3eL46GEAkSl0abkPxSbhwNYqwg=;
 b=UOdrdgjKNf0TljwYnzcwXDW8daZExcAhQeCgUIOJ7yAMHuk0cXFRYjyTpyjJATmBA/stnnXP5FfCBPiv+P/LrGlYSQlgZCfgl6s55pOV4mhOX1/q3PWUM8zDfZTjdNvs3dRrve/0u81SHqIeX4fihaYFToeURNqF1IeVdl3wekA=
Received: from MWHPR11MB1886.namprd11.prod.outlook.com (2603:10b6:300:110::9)
 by CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16; Tue, 2 Feb
 2021 02:51:30 +0000
Received: from MWHPR11MB1886.namprd11.prod.outlook.com
 ([fe80::f1b4:bace:1e44:4a46]) by MWHPR11MB1886.namprd11.prod.outlook.com
 ([fe80::f1b4:bace:1e44:4a46%6]) with mapi id 15.20.3805.028; Tue, 2 Feb 2021
 02:51:30 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Subject: RE: [RFC PATCH v2] uacce: Add uacce_ctrl misc device
Thread-Topic: [RFC PATCH v2] uacce: Add uacce_ctrl misc device
Thread-Index: AQHW8vXFZzEtyXCrG0WCf1cOBJGRp6o39q+AgADtcaD//5AFgIAAh9tQgAAe3wCAAAPTgIAFRl4wgAWdWwCAAClPsA==
Date: Tue, 2 Feb 2021 02:51:30 +0000
Message-ID: <MWHPR11MB1886464FFEF10DF9AE708C4A8CB59@MWHPR11MB1886.namprd11.prod.outlook.com>
References: <1611563696-235269-1-git-send-email-wangzhou1@hisilicon.com>
 <20210125154717.GW4605@ziepe.ca>
 <96b655ade2534a65974a378bb68383ee@hisilicon.com>
 <20210125231619.GY4605@ziepe.ca>
 <5f64a68042c64f37b5cba74028bd2189@hisilicon.com>
 <20210126011304.GZ4605@ziepe.ca>
 <d7fce136c3644755a7aea5794bddf453@hisilicon.com>
 <MWHPR11MB1886DC78C5FBA3636B94F2578CB99@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210201234424.GI4718@ziepe.ca>
In-Reply-To: <20210201234424.GI4718@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: ziepe.ca; dkim=none (message not signed)
 header.d=none;ziepe.ca; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.147.199]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f02d8458-8832-49a7-444e-08d8c725717a
x-ms-traffictypediagnostic: CO1PR11MB5089:
x-microsoft-antispam-prvs: <CO1PR11MB50892723D447204E43B2F3268CB59@CO1PR11MB5089.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pP31cdReOLnrMD/9D8a0belmBA6tDGHs5WjlfyqPPK/RBU6Zt5T8X2z4H+IyxPfSKbAACr412pMg7mgHqmLIQq6udt4kNOeDhZoCcf4xe/uc6kyNCEDhVTxheaEVZbuiTECl6bRsJN2nifXE6duh7eQDljizWS0bnQkdFsVATjq6XM5WlYVLB8nysv1BpA3Wjo2lveb7myWdL1kEb/34DPgKus0qyo4vTxNPsrUGYeBrT1PEV4Z3bGDMWqw1Kksz+cSF3SXKlmpfDy7Y5Lcu6CSqywqt3SHq+oE6MdRkDklU6Ax6Z3nRvkjKKtSYTnaW5QsTt6i38Jc+163zYzJGmdYlP/k68FZzgPkpdiqDDVdXVqGn/kvKNSlsARTPAlMUSomzq2BUI4gbpdvw6ew181ekPr2QKVBHHp5y/urvI0prPeZ1y5d/+HvDEc3StQvA9xXmD0gzfQFHGx0wY/lW6btRpmR8bIvK5g4DYpOieJ5pOUZlp3zVQR3mGbbXP7ReDYv8aAaEg7KhBtYPwtbrlA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR11MB1886.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(39860400002)(346002)(366004)(396003)(478600001)(4326008)(66446008)(33656002)(5660300002)(2906002)(7696005)(66556008)(64756008)(6916009)(8676002)(76116006)(9686003)(7416002)(52536014)(66946007)(8936002)(55016002)(54906003)(66476007)(71200400001)(316002)(6506007)(4744005)(186003)(86362001)(26005);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?HWfKwqiZ46ZSGmzbry2oApfqD5jRkgf6kovZqrb6K9GMeT9p3Y5qkycy7+JU?=
 =?us-ascii?Q?CacA3+LV1kHSKKSkdW5U+FlNcoK8zZf5Cthe/s37CS1V1mEuxfRNR7X5aveR?=
 =?us-ascii?Q?Ej8AsGUrBs74L8eOxk+axueV5RZJC94KbeWghuqzYsbanpizJZjNQtz73iAp?=
 =?us-ascii?Q?LpfUnjJcgeBA0rzZoDxe1cPkiXCZHuU9dSdgaIm+SbqFZHGs4IDrQHhNFR9S?=
 =?us-ascii?Q?hVl6el+lYRTb6LKs7A3j9AyiLwKOO5skYKHLP63DOmJH3KvRG8ru3gZY1vO8?=
 =?us-ascii?Q?xATfd5DzZg+vM8gMDvOwtqMy/0SszbcVkOX7s/SRy2jpvgE5wwmn+i1nL9Vl?=
 =?us-ascii?Q?A9iIufmFetsOpr8lKKq/6pFgvXuY3+CYz7P1rv9Ou8D38HmalnzdxWG82QST?=
 =?us-ascii?Q?nXmDq32yhIStAJzWnKUGX8exfNkhxoUuSmwtRXev6dsqrgDAXXG5yDO7SqHs?=
 =?us-ascii?Q?BIfmYC73qx12BPgyQ6SLn4PiS/BZ8BoXJD4QwuYRVBym5gWZH9IOWcx7FZq9?=
 =?us-ascii?Q?vkKnG8cm7sQjO1gfkcc8aj8kXIUELl7w10GrrLyfrJ3CoUnn8dnH8VknI8FL?=
 =?us-ascii?Q?pbVyLOrI7SYdV1oGGb85ChSGWt3MHEen2Fw/5PtxGVOCBhRMTCe0hsEYuYXH?=
 =?us-ascii?Q?SAtF0k22h6r8wWF1HdZZJP2uRIghMIepc+zVPDFquq6nJAyo06tpuj3GB78r?=
 =?us-ascii?Q?gxohy71qi8JGSJCS6vAheDcntFGY6ldQHogkIyGCxZ0qF6su1YnJc55HPxYA?=
 =?us-ascii?Q?U18sCXaTF8QYjeky8+/kB4MX9D0PwVhhBy+mVZDxi73QzDiAkTkPN9p4FVkU?=
 =?us-ascii?Q?ewkNhJec4xP8oTwxqf/dNvROUQvyTn5aAMyoomlBp93qGWITSbHfJjVb8N6Y?=
 =?us-ascii?Q?UB4Fea/jkGUzE1dEP1Ca4qshDlqk8LZhBgmwpyANyrEkuNc07CSMqweZ4TJ+?=
 =?us-ascii?Q?ICrRMBsbtQIcOO1iBmdM1WxDY9fHHWJFTWK5eOax5Q3FZap5BSe6wndqb1dn?=
 =?us-ascii?Q?x6rZeji4kIf4XPryOQYeH9xgFGpWv/k6pQDL7blflu4oxo8Yj5M7KQ3ydDKs?=
 =?us-ascii?Q?n+G9QMKc?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1886.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f02d8458-8832-49a7-444e-08d8c725717a
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2021 02:51:30.3011 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E+gsyGP5T36ERejSSkQBNYf3WfastEYgyl0GEL43Xmnjbe/VeQ1GNgCMkFL1WvHIDAl+uPlvf3XLFy5qjSXE5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5089
X-OriginatorOrg: intel.com
Cc: "chensihang \(A\)" <chensihang1@hisilicon.com>,
 Arnd Bergmann <arnd@arndb.de>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Zhangfei Gao <zhangfei.gao@linaro.org>, "Liguozhu
 \(Kenneth\)" <liguozhu@hisilicon.com>,
 "linux-accelerators@lists.ozlabs.org" <linux-accelerators@lists.ozlabs.org>
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

> From: Jason Gunthorpe <jgg@ziepe.ca>
> Sent: Tuesday, February 2, 2021 7:44 AM
> 
> On Fri, Jan 29, 2021 at 10:09:03AM +0000, Tian, Kevin wrote:
> > > SVA is not doom to work with IO page fault only. If we have SVA+pin,
> > > we would get both sharing address and stable I/O latency.
> >
> > Isn't it like a traditional MAP_DMA API (imply pinning) plus specifying
> > cpu_va of the memory pool as the iova?
> 
> I think their issue is the HW can't do the cpu_va trick without also
> involving the system IOMMU in a SVA mode
> 

This is the part that I didn't understand. Using cpu_va in a MAP_DMA
interface doesn't require device support. It's just an user-specified
address to be mapped into the IOMMU page table. On the other hand,
sharing CPU page table through a SVA interface for an usage where I/O 
page faults must be completely avoided seems a misleading attempt. 
Even if people do want this model (e.g. mix pinning+fault), it should be
a mm syscall as Greg pointed out, not specific to sva.

Thanks
Kevin
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
