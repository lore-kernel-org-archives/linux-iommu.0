Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF677C433EF
	for <iommu@archiver.kernel.org>; Wed, 16 Feb 2022 03:45:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8666E40576;
	Wed, 16 Feb 2022 03:45:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id b4nxq_r9Ndnt; Wed, 16 Feb 2022 03:45:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 0301240154;
	Wed, 16 Feb 2022 03:45:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CA7D5C0011;
	Wed, 16 Feb 2022 03:45:38 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0A1F7C000B
 for <iommu@lists.linux-foundation.org>; Wed, 16 Feb 2022 03:45:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D072282F98
 for <iommu@lists.linux-foundation.org>; Wed, 16 Feb 2022 03:45:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AnXsv6iyAsOb for <iommu@lists.linux-foundation.org>;
 Wed, 16 Feb 2022 03:45:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 20F2D82D75
 for <iommu@lists.linux-foundation.org>; Wed, 16 Feb 2022 03:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1644983137; x=1676519137;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=rpyCN69H97YohwYB1+kzzau5J9gH/AWUkgBaUwrHAvY=;
 b=P+/YDHbFgKCcMM0xD6XNQ9WfA41008AKv/270pojq+EpNTjHJhA8Vn5s
 cJ2NAR9yIIGk+sCY/vT4cb9AI6hAxTXcpvzW6EtJmvr5/9KYWqcXrHxfe
 GES9gvQ4jxPs67zoZawAYIKK9nETySABooI+8KFOCHe+E6JiEyqAAOYXz
 XaGJq7K124iZsyEs78G/xEmy4Q1eXqBIeI0F3iY5CedllnHrSp/KOTsiC
 3uJN6L/VewLtydameU+y769TDzx4w4xBEcAwYdAG6xXIylGO8plpqAcUm
 ZOHWJvywAjzafDHWmsCvdbk0a0fpjMN5tL1pdat/miRazjjsNqazWe2wV g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10259"; a="248114305"
X-IronPort-AV: E=Sophos;i="5.88,371,1635231600"; d="scan'208";a="248114305"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Feb 2022 19:45:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,371,1635231600"; d="scan'208";a="571108667"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
 by orsmga001.jf.intel.com with ESMTP; 15 Feb 2022 19:45:36 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 15 Feb 2022 19:45:35 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Tue, 15 Feb 2022 19:45:35 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.48) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Tue, 15 Feb 2022 19:45:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KyUScU7QtduFMVaxE9ckAgvJIaeezniLcT+gXX+qivUKVWNeD/YRP2nFYaVwWmelIdkws+LYo18ZnogqESVAo62ZVtgaBpF3hn0CtLXa6hsXEPhQj2PcRioiiKYgTCh/PA+S6edguN33NjMCfQ6LsHjBK0lPwKiz42GIUSNDeUhCR34NRfEINXcNooGOK1TkaCLT4H3c9rKf8C7QrR+Uz2fk6GTvlXaQZFGItTqNhkV/xXLRxNHDF3dOxzRGIkq7udW+HqH3vMXt9cA3556AErjnFvG0t9EViIhkXT86vHcO8Au5mYs0e9qSVRPV7iW91ypqTIdp9wOe5nY2utXLeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rpyCN69H97YohwYB1+kzzau5J9gH/AWUkgBaUwrHAvY=;
 b=lhopHcZyVwX1yu9463cug35BSW274kgXc/gaYNAH6cyqWEu9BZMvm05aoKARzLGtF3hl5m8rM3CDlNztl20o8jqJWVOgegTdrDbcZVtDhBqWFwFkS0iTVeuuf78zbe+cPA4CAI1TVET6g2zIupDvmiiP+gLfALVa0mTY62k9KGOzZZRaWQaWJHfe1V9FtsZ4hPfpEj5a/k3ecrujZap6oBQTia+Y0gmGT+ffH0VIx6qT/lY6lar5pSe5qmVyRauFMtFrRK9KLWo7nGYTqRPvlQUCeYpxA/TAUfRQ25gS3GtT4u/TLB0kpEgJCGnMGrc3vDlZFPo2pw+96zrMzkZ82g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CO1PR11MB4769.namprd11.prod.outlook.com (2603:10b6:303:91::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15; Wed, 16 Feb
 2022 03:45:33 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f514:7aae:315b:4d8d]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f514:7aae:315b:4d8d%3]) with mapi id 15.20.4995.016; Wed, 16 Feb 2022
 03:45:33 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Christoph Hellwig <hch@lst.de>, Lu Baolu <baolu.lu@linux.intel.com>
Subject: RE: [PATCH v2 09/11] iommu/vt-d: Remove commented code
Thread-Topic: [PATCH v2 09/11] iommu/vt-d: Remove commented code
Thread-Index: AQHYIU7XPuQ1pkWoHUeQpg1h89xRqaySp/UAgALi46A=
Date: Wed, 16 Feb 2022 03:45:33 +0000
Message-ID: <BN9PR11MB527698691A1DF10EEB514AA08C359@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220214025704.3184654-1-baolu.lu@linux.intel.com>
 <20220214025704.3184654-10-baolu.lu@linux.intel.com>
 <20220214073424.GE17411@lst.de>
In-Reply-To: <20220214073424.GE17411@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.6.200.16
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 736baab1-c928-4bb9-f976-08d9f0fec8de
x-ms-traffictypediagnostic: CO1PR11MB4769:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <CO1PR11MB4769867547500DE67BA6D0A18C359@CO1PR11MB4769.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TvXMoCCl327lLKKNczAYHbVP1PWdBXR0Eb+2VRSS9s2oZgFcZgjsRCiciDcEKVCIieIDpo5YO/h1WL7J+FqNwDVkcs7Zo2B8ez8knOFaTWerQmJ3hRa/erOG248IYsk/kasCvQvsNizB1cog5i/T7wIo4TZxV/pTJ7zk5/oFEaZL9xg2y1OTLgqQjHOKY5Kl4sGJneAsAL28+xKBoWlokch+gF8HKr0C4IpIvmwgtVL/2JRm6GB9eVtbeFpPs726eiDdOPn4wdINFWDjRR78T7UfQAlWLemDqHXTS9VTnW5mrf0Ix46GFvPTrs+5A1UhspjN7wxlDewRPm29Hp8Kphk3ajJ2TZ9rmZNUSAAL9Uf2ADfWM7nCLXprD3A1WLzYN2YVENOG/psWkrxefwbX3aYee4AhtiwoTSTxn5nGGnMtoqS/s95NVDWkcps8Pq72ycwTJ8qV9RnVXuji7g2d3HQDTXD9o9eQadpjRTg/l93+r5gaK1JKeCL18ezLo0yFsG/zwDncxiVke6rYdXGP/uv6Zx8LkyapJXUVQF0bHGOuMeu7/h+9zWxPkI7iTtZL2e8uHkairl3lviv5AbSMHpP5w+2o7SmMdDZqnnNbFy36OnojIlpOnIjIS1+C+GFP/h5rZucfjcAuZvyakrTYOAFHPPV9XD1LLystNQq575e0axYCvkQSPEjWSjBzaqazZaJQTMtbCWakIgvJl29u/w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR11MB5276.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(366004)(8936002)(66446008)(2906002)(38100700002)(186003)(316002)(38070700005)(33656002)(54906003)(110136005)(55016003)(86362001)(4326008)(7696005)(52536014)(71200400001)(9686003)(66556008)(8676002)(4744005)(5660300002)(26005)(6506007)(508600001)(122000001)(64756008)(82960400001)(83380400001)(66476007)(66946007)(76116006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NFOzMflGGDO9TqGukzN57gvsKEcpnLA6yKGRnn0OKnZownqpdOY/ZqUBSW/y?=
 =?us-ascii?Q?vr5cAbKycM3p08XsRiGYtoS6j9ptAYsQoOQrb2xQXjfIrY2c5lf+JaNNBHOG?=
 =?us-ascii?Q?CWcMXe3BBeMHM8L4IxPKFbY/nnc3wcK6Y3JJAsTWIIK1PbnAnxWPLylVL5L8?=
 =?us-ascii?Q?TgpNfdlbgdLyIclAeHfoe0ohYedt4oPoo4GDRjI46DLsugWcQMU/MKsszQP6?=
 =?us-ascii?Q?txumgHwz9SAqb2wRbxToHiOCnuUl8uJ7jdU7/1zIH0Jw1hJYOjOG2PvkXlae?=
 =?us-ascii?Q?ase2jP4oWW4ELB1YPPS15ImKDcMWQALgww1nDXv6kT2PX+mHXzZwmuqTZFmX?=
 =?us-ascii?Q?MEDkxMzmyh5PJjMcPu7IxIeIJtelfC896czob3+RAEluezWrO6nwibpZoI9D?=
 =?us-ascii?Q?QKlkYVGUJhck5zjO6AVK1EkrE3gZn+Dhq4sVgyhLSz5TZwNLeEjFTmxmVy+6?=
 =?us-ascii?Q?DGErzrZ9lSFpnHGktG5AmY4FuXmtsxDHIBkjDgMxSmweTpLquIUzj9jSiDv0?=
 =?us-ascii?Q?na5Bc+OV2/Kqk/1rc81XD8NTRUn8r5f9aPFfhQHAU1kUKeiMe9BeIzyKzbg/?=
 =?us-ascii?Q?KJpo7H3PCL7LpSmqof+KY8JNFy84qFYaAjEkjqwxE9Nq3P6cXQ6dNE1x5GKb?=
 =?us-ascii?Q?JnuJ7Tslzhvq1TSnl2v3gzAoW4bqQ2lztciTLOF730sV2YolZkmO2EC+RABl?=
 =?us-ascii?Q?Wk6K1k+k+LaynikjTMb7v2iJkQ9AlfgdYf4Xh6oRNJ3NXYQCKNXwHsji2m+/?=
 =?us-ascii?Q?pM4Rke6GdCRvHRtWf/vZnMXYXYA1IYcnZalsOLqheyFlAnBE/dSbh8K9JNTG?=
 =?us-ascii?Q?Wvq/9ugWbRlXbvAE5PMW7uP6uyuAzNUgXXLtig9Kq58d9wzXHrkAyZKVFjUr?=
 =?us-ascii?Q?mDsRAOIPd3FzSS8F6Nk7LmlWSnd4OgdMvHDib8lK6Z75XrlDYhnUWoicoLyY?=
 =?us-ascii?Q?vHxDKaqtUAhJXujmCSMbTocu/zlUPPH6YtmwA5/QizdfDQ916tAz2oZiNoHo?=
 =?us-ascii?Q?pfmvUC10WJdNINar06/YjpLBN1hxLEZySFOSohG7/eK2iym5OPFqdzBxpkMB?=
 =?us-ascii?Q?b4AKLzIMhKj/iLlhrmITV/GqHfd0WjQEHuK4X4FthtPL5FvfNar4oJZfSvOO?=
 =?us-ascii?Q?VW0HA6PGKL3zPh4bpPIvprUhTXWXJk0/qeECU+GZ/MU++YxbzZc/1OvElM6H?=
 =?us-ascii?Q?tp03p3VSRXoFLxa/zN9DDDWLVwVmtgZ4orHdz859FTknNgMTrAN/7edc6PQv?=
 =?us-ascii?Q?7/SB/CFXKmtHFnRprMyCOuWk6TvZSHobRg/LWCyXba3yzMzEnf3alYIxsrkD?=
 =?us-ascii?Q?pdTdSOHmwR9+Ts3JM0MtgHV+bzVrTmWYDSavZg1e7qXK8DpbuC4B2EqG81gk?=
 =?us-ascii?Q?7RlpeTZ5rcjpHAB4ibBWozLCzhbaaqQp12GX8BgBasmu4xNj2IFngMOS6ARD?=
 =?us-ascii?Q?vay2SjG0ACBJNQvFEHKp4RrP6p+BMAIMsDDcFN5ilfT6DS1LLf8dFVfpMT7N?=
 =?us-ascii?Q?2Ny1rGwJmIPJCp07Ky1GXiAJ0jF0bpI/xiR3TklLmnX8XvnEVan5aQVxltfa?=
 =?us-ascii?Q?w9Ktq6PoaBR2QxcgPPVn1mUFfegxGwYx1NEGSYlrZ0dMB36iR/oS0HXMz4Ig?=
 =?us-ascii?Q?UwdubEb9HlR3zUQWnzUx/Gk=3D?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 736baab1-c928-4bb9-f976-08d9f0fec8de
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2022 03:45:33.0944 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lPizV+Y0W7lDRMX9H+9dv2jZgjirLKTzcuYWdTfq9xqJ7kv7UTetXsk3t5bO7wNQueV+xZihO4+YGFVvWcFbRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4769
X-OriginatorOrg: intel.com
Cc: "Raj, Ashok" <ashok.raj@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Jason Gunthorpe <jgg@nvidia.com>, Robin Murphy <robin.murphy@arm.com>
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

> From: Christoph Hellwig <hch@lst.de>
> Sent: Monday, February 14, 2022 3:34 PM
> 
> On Mon, Feb 14, 2022 at 10:57:02AM +0800, Lu Baolu wrote:
> > This removes unnecessary commented code.
> 
> Removing dead code is always good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> 
> But someone might really want to take a look if draining makes sense here
> or not.

Looks that dead code has been there since intel-iommu driver was
firstly introduced in 2007. I don't know whether we can dig out
the reason (Baolu, can you have a check?) why it's only special
cased for read draining but not write draining. I cannot find any
such recommendation from VT-d spec.

Looking at VT-d spec it stated that since VT-d major version 2
drain is conducted automatically by hardware and above flags
are essentially ignored. 

Given that possibly a safer option is to always set read/write
draining flags before version 2 and skip it after.

Thanks
Kevin
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
