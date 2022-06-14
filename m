Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBB65C43334
	for <iommu@archiver.kernel.org>; Tue, 14 Jun 2022 06:43:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 576BF60F02;
	Tue, 14 Jun 2022 06:43:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dzKaJY0izOik; Tue, 14 Jun 2022 06:43:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 1CC6C60E06;
	Tue, 14 Jun 2022 06:43:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B9B33C0039;
	Tue, 14 Jun 2022 06:43:27 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3C926C002D
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jun 2022 06:43:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 15493607C0
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jun 2022 06:43:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PY6AaXDvkUOK for <iommu@lists.linux-foundation.org>;
 Tue, 14 Jun 2022 06:43:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CFE5460E06
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jun 2022 06:43:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1655189003; x=1686725003;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=VhJTThmCmWcipjE5QyqGu6G6RqSNZxesoGoncMWs3dA=;
 b=MKafemd4J5Ql8yq/xGPD6i4sWfBJ/qYp0R761GnbfesW3pIwxLTD7Ggq
 rhyKcsibtQQzBM7CeAIxv4GZN3ugfz3Ed76jbc41mt+vHHCtPO0J+cK3/
 bTf1xY1UauMIiCSMr60MORs9fYI+UzKBfq8J+mRlVbaX5xWTf/VaWRBZm
 th1XrJl34KaTOW28CwhgbLC6kXLgowitATNfRL+ZmSSi5jTX0sR712kH2
 F8tWaPCV2rtKPxpOiDiabfemsO1TBQHBpNQvzBNTJr8lKp0MIuh78oMxX
 cSJz/2z7VdAgaLOC30V+xco0p4sBNfFBSBU8+xEUARyCXLW/nXUHRpaE9 Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10377"; a="276062466"
X-IronPort-AV: E=Sophos;i="5.91,299,1647327600"; d="scan'208";a="276062466"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jun 2022 23:43:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,299,1647327600"; d="scan'208";a="686500516"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
 by fmsmga002.fm.intel.com with ESMTP; 13 Jun 2022 23:43:22 -0700
Received: from orsmsx606.amr.corp.intel.com (10.22.229.19) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 13 Jun 2022 23:43:22 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Mon, 13 Jun 2022 23:43:22 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.47) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Mon, 13 Jun 2022 23:43:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jQL0LeffT7HoH2pp8sAn9FyPXTc6EYH9YaoaMoIP9uxqI/9Kgw08mbTcrlklcAgw4W9AXqQI0tmvyutQ1YjJM9zgb3SwK2C7QQyBDz1r0GySLaEXo5UV64bN3jq3gU6NiKcA/wgSPS+lMKke8X/5AWbO2AGkgL3Or8EJozdC+FESA/bw4O8tR+zCcCX5vuhuroCw6pgjqFkollpjXaji9Mm5e0rFGawPew4qE8sZOSmWBrg7LUEBOvKzu7WgEmAqFzBxRxK21BzZZkYeZeYvBse3DcPGiBwoVMKLcFLCHVWxEVfCOfExDEcbQjpxJGX76eczSi/hj76Ev002lIVcFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8DU92pJghFyH6VQmlmvfwNeoQtk91YqTqjV66lzPZfI=;
 b=aDXrXKFK0Im6LT3H6fFBChN4nJ9Y6zAfF9E/gYMYh04P6EUEVX+4sMsdRfyVXonJ6rIt6OK4JGD0Hu/+PJl3YyDdRwfQrrsBi2vnHrBcctZpGW7EOvHw4IjJKU7zHxVTyZHaIotDXEWKfttJq7fh+ynECnbtUSHs0dtNxyYSFC6aHqFOHDF1X+weIJonHnbLmFDyV8w9Vk5vbsK/WXj6GgWHJQMIrZq8pHKV+y2C9dE7W31p80CI9I1TxZGDCCzWpkWuCm4VEfI57EGlA+tLJFnpgbgNJrrBl/20POWDOUX755s3my8UiC0ZIWl7RubZc6XiJ1wkm8qi5h37E46hcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by BN6PR11MB1475.namprd11.prod.outlook.com (2603:10b6:405:9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.15; Tue, 14 Jun
 2022 06:43:15 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::3583:afc6:2732:74b8]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::3583:afc6:2732:74b8%4]) with mapi id 15.20.5332.022; Tue, 14 Jun 2022
 06:43:15 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, "Raj, 
 Ashok" <ashok.raj@intel.com>, Christoph Hellwig <hch@infradead.org>, "Jason
 Gunthorpe" <jgg@nvidia.com>
Subject: RE: [PATCH v2 01/12] iommu/vt-d: debugfs: Remove device_domain_lock
 usage
Thread-Topic: [PATCH v2 01/12] iommu/vt-d: debugfs: Remove device_domain_lock
 usage
Thread-Index: AQHYf5o9PBZqbtPZ60ix6nIaRhUsd61OcNnA
Date: Tue, 14 Jun 2022 06:43:15 +0000
Message-ID: <BN9PR11MB527680C1957C0E29E8AE85168CAA9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220614025137.1632762-1-baolu.lu@linux.intel.com>
 <20220614025137.1632762-2-baolu.lu@linux.intel.com>
In-Reply-To: <20220614025137.1632762-2-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f09b75eb-365d-46f8-0877-08da4dd128e2
x-ms-traffictypediagnostic: BN6PR11MB1475:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <BN6PR11MB1475B62DEEBAF94720ADEE4D8CAA9@BN6PR11MB1475.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HIAWg9XfgNrWyCIg9zXMA6JPKo3qfxKwo27r52aic85J/sFF6jI5v2y1BW65qPaOniazKzTd+ohegcDSRgzMOT87r68bXhfWfQCVMTXahnHkNeEWwJieBiQ/W/IHn481E8z7A0DtDLanK7NWbj4TyEz/DulSbdo+Fc3oUe23jfKtjJm71pzXLZ7UndvBcQUT3vPaZkEz9YHt1pPw0NTW/Qs4N+EkReBiC65IAE3umz3pokffVbFBibWuo1cQohckErl2xlrOKthtuXgCCExE/CTmTJRV9XNzvONYIjYJrky1gPMBeJY+hlzR+i9wxMXvkdPbmh9ZsgfdWLg9BugRfZX7gWBwl0+Y5BGxA/s4spxbyomc4VXu4p8Pz1JamSQwk4EUyM5oAuud/pYrvHj/5nr8msssfZKz/8maukmPlHPQ/4CoEpQDZkXWxMi68Xt0DiobGrXDxIlIMb6YbCH4tT1msFJwtslQUuDXu1Jd2iG3Jiw1/rp1eB4NcunPPK9YSHvteYOL/Ywqq9cfZsP7eFwz7orFajBWiW5cD7pUtwi/LSZDO93GkTKGiSzcKuZurJKchls2OEBI/FWgOvNUhjYv7Mj3QF8pparMzWe+BYGShKvjLhbr4HYMnifRzgqp+6GKt8uXjgY9yCx3A5lKRoPz8jNa3rxk02IfObjs4ShaulcPsTU5NDLZq9UPDcd9GZiQ4hEFLzRnbJz1pTSa9w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR11MB5276.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(366004)(82960400001)(316002)(110136005)(122000001)(64756008)(7696005)(6506007)(38100700002)(66476007)(66946007)(8676002)(66556008)(4326008)(54906003)(66446008)(83380400001)(76116006)(52536014)(5660300002)(55016003)(38070700005)(71200400001)(508600001)(8936002)(33656002)(186003)(2906002)(26005)(9686003)(86362001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?j+T5ZxUqPOGv+jv8Y2Pg6OCnm7Y3N/GWG3hvZUSIS8g/g5qkEy0vRVNKH8IN?=
 =?us-ascii?Q?TWi9y3vHomh4EpeNIeJnSBlrPrnbrf918h7gDLW7hyF2s0HTSAPSJODIcQcN?=
 =?us-ascii?Q?E8/7eoxViX9RkhcT359pc7vbi+oVuGaarrRgTfxTZ8+cY3FWub32kexMs8eT?=
 =?us-ascii?Q?SaLjNE6yzUNVDIz0WbiiZdm7MOZ0zTDLywDi26NbbBiJ+S/FJN4b94NYFcLj?=
 =?us-ascii?Q?lnykAhIiv3Ns9myrP9gu2bj4BgHDCqfkVg87IOJxU7HDlZs1yN0/PwS3ZMcf?=
 =?us-ascii?Q?/o9sBfIyH1f7FRBHUnIuLyXjiPY/mxYHxQyEsEnn0Awc65XJicN9szCXqzXL?=
 =?us-ascii?Q?5lOfsLBtjOI2fQwxlZyLh7Y4s9TtT04I0npeE8aM8bjzvt44R1FlceDYWkYb?=
 =?us-ascii?Q?fFqA6/LFif7yBIc2Ar6FYZZ1SmIGx0Modkq+cxwl5ZF1N92zE+tRThKcjFOP?=
 =?us-ascii?Q?IX03VTGnjgEnS1Kd5Y9ry1+raIeqRDbPqCqf//uaPNGTG3PtsA6oopaTRU/4?=
 =?us-ascii?Q?JVFm42tcQWQpQArKHT5dly743wkMWS12drKWewHH/uxy0wpqCq7N86utp5Fr?=
 =?us-ascii?Q?4c9c9cVS2QN8ibuvAnkdocnXQ4QAlrNX3XL2kHlXwL6MgwmGp+HiDzDAf0j2?=
 =?us-ascii?Q?6K8FDs4lSORGDjWsuMt7ngts/1YViK5X4IKrA2+/a9s8hnZCQSNrS8H1uKKC?=
 =?us-ascii?Q?+CdahVXjeKBHByn2LrHESdfEnICJaF6yrPXM/duXk+D9KfOHSKGc1L9ru9Sh?=
 =?us-ascii?Q?++2F0ZTkR19liBrYLZKUtizp2A6xGJj04Ze8tV4ELoYR/66IQk8g+yo5aaVo?=
 =?us-ascii?Q?QenaqH4Z/Gvyq/RREQExXVNgUSzWNiB1zhvkkGSPB0rjDxWI1oCXu08Kv8Mp?=
 =?us-ascii?Q?wqT8rji5FI22nDRR5lwaeTOyLsU98vI5RPXcFMazJsRpL1Yb9HA010Y9GEFQ?=
 =?us-ascii?Q?Fa0xmPlfNvfXcPkPR/D/1CsFus4S5Ff+dkGAP/fgSDaGmnhs2F/BzRRepG/v?=
 =?us-ascii?Q?3IRsFVzm496k0WXzEOaPIwm7hAn2gdUTDiKoNuluiptfYuz+8glNeJqcPqFo?=
 =?us-ascii?Q?NSnFgw89+NRE22F6tSHcZJ5lM3M0vmjB9rB91QkoRZzMVd2cvQGLm/UinTwS?=
 =?us-ascii?Q?xmZxG50fPnhB2X4mhVtP2XA+oHcE1Ej2MixYcdNb75wTruh0lXlcQIquHDiL?=
 =?us-ascii?Q?C6xh//E+vssefKPfD0moY/XKg7gs+udToeFyoxAOSusyoID/p03hXqxoLP0G?=
 =?us-ascii?Q?M+jpXH3ASPvCGdykqpK4PdEKmJBiNnmV0zxs2DLsY9K+5FT/jNToLykhhpNN?=
 =?us-ascii?Q?dT/Z+WO8AxEQVato4XLMxp0w0fSsXy4caEGjRXiSoI0/uB/adHGml4UvxgNh?=
 =?us-ascii?Q?uYe4OgzcJ8wj/DkNUfOajyN+Ab7MbONKq+ooklzm+EyV4UzmsJXkazBsqURK?=
 =?us-ascii?Q?gDId8XuGJYHr17LzTMk0dobZE0/JlMI5yYr3KIBs7Y3bg51JRMPz98W70mo2?=
 =?us-ascii?Q?xGG7bZpiRpcbdQxdFVtKNlBpvCc8gbhJ87MCjvACNO439HL55Kk/XajVcTac?=
 =?us-ascii?Q?KUplsJduUMzelzYl9+NzAjDiJzLW/OyMCGIF/Gev4h5Zy23q0xDk0Hy2PDK2?=
 =?us-ascii?Q?fDaZiCqV+AFbCyHHm9924Jd769Lnh6UodrULqjaSeUUxWCXNSRKoXr4S5ZDb?=
 =?us-ascii?Q?M+a9zL1QdmEvj4Yb0z2xq6bJk509S0yhDYaobkSUW80pmbTG0vYVJTFNJtWq?=
 =?us-ascii?Q?fv44B1tQug=3D=3D?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f09b75eb-365d-46f8-0877-08da4dd128e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2022 06:43:15.5127 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rd+6G3BFCegwpjfnMzvHUm5v7CLSnmIkThOFv7ywAD2/OczOGpnO4jfa6L4oyYtqkmFloKUrDCoK6nKelSBJmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1475
X-OriginatorOrg: intel.com
Cc: Will Deacon <will@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Pan,
 Jacob jun" <jacob.jun.pan@intel.com>, Robin Murphy <robin.murphy@arm.com>
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
> Sent: Tuesday, June 14, 2022 10:51 AM
> 
> The domain_translation_struct debugfs node is used to dump the DMAR
> page
> tables for the PCI devices. It potentially races with setting domains to
> devices. The existing code uses a global spinlock device_domain_lock to
> avoid the races, but this is problematical as this lock is only used to
> protect the device tracking lists of each domain.

is it really problematic at this point? Before following patches are applied
using device_domain_lock should have similar effect as holding the group
lock.

Here it might make more sense to just focus on removing the use of
device_domain_lock outside of iommu.c. Just that using group lock is
cleaner and more compatible to following cleanups.

and it's worth mentioning that racing with page table updates is out
of the scope of this series. Probably also add a comment in the code
to clarify this point.

> 
> This replaces device_domain_lock with group->mutex to protect page tables
> from setting a new domain. This also makes device_domain_lock static as
> it is now only used inside the file.

s/the file/iommu.c/

> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/intel/iommu.h   |  1 -
>  drivers/iommu/intel/debugfs.c | 49 +++++++++++++++++++++++++----------
>  drivers/iommu/intel/iommu.c   |  2 +-
>  3 files changed, 36 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
> index a22adfbdf870..8a6d64d726c0 100644
> --- a/drivers/iommu/intel/iommu.h
> +++ b/drivers/iommu/intel/iommu.h
> @@ -480,7 +480,6 @@ enum {
>  #define VTD_FLAG_SVM_CAPABLE		(1 << 2)
> 
>  extern int intel_iommu_sm;
> -extern spinlock_t device_domain_lock;
> 
>  #define sm_supported(iommu)	(intel_iommu_sm &&
> ecap_smts((iommu)->ecap))
>  #define pasid_supported(iommu)	(sm_supported(iommu) &&
> 		\
> diff --git a/drivers/iommu/intel/debugfs.c b/drivers/iommu/intel/debugfs.c
> index d927ef10641b..5ebfe32265d5 100644
> --- a/drivers/iommu/intel/debugfs.c
> +++ b/drivers/iommu/intel/debugfs.c
> @@ -342,15 +342,23 @@ static void pgtable_walk_level(struct seq_file *m,
> struct dma_pte *pde,
>  	}
>  }
> 
> -static int show_device_domain_translation(struct device *dev, void *data)
> +struct show_domain_opaque {
> +	struct device *dev;
> +	struct seq_file *m;
> +};

Sounds redundant as both bus_for_each_dev() and
iommu_group_for_each_dev() declares the same fn type which
accepts a device pointer and void *data. 

> +
> +static int __show_device_domain_translation(struct device *dev, void *data)
>  {
> -	struct device_domain_info *info = dev_iommu_priv_get(dev);
> -	struct dmar_domain *domain = info->domain;
> -	struct seq_file *m = data;
> +	struct show_domain_opaque *opaque = data;
> +	struct device_domain_info *info;
> +	struct seq_file *m = opaque->m;
> +	struct dmar_domain *domain;
>  	u64 path[6] = { 0 };
> 
> -	if (!domain)
> +	if (dev != opaque->dev)
>  		return 0;

not required.

> +	info = dev_iommu_priv_get(dev);
> +	domain = info->domain;
> 
>  	seq_printf(m, "Device %s @0x%llx\n", dev_name(dev),
>  		   (u64)virt_to_phys(domain->pgd));
> @@ -359,20 +367,33 @@ static int show_device_domain_translation(struct
> device *dev, void *data)
>  	pgtable_walk_level(m, domain->pgd, domain->agaw + 2, 0, path);
>  	seq_putc(m, '\n');
> 
> -	return 0;
> +	return 1;
>  }
> 
> -static int domain_translation_struct_show(struct seq_file *m, void *unused)
> +static int show_device_domain_translation(struct device *dev, void *data)
>  {
> -	unsigned long flags;
> -	int ret;
> +	struct show_domain_opaque opaque = {dev, data};
> +	struct iommu_group *group;
> 
> -	spin_lock_irqsave(&device_domain_lock, flags);
> -	ret = bus_for_each_dev(&pci_bus_type, NULL, m,
> -			       show_device_domain_translation);
> -	spin_unlock_irqrestore(&device_domain_lock, flags);
> +	group = iommu_group_get(dev);
> +	if (group) {
> +		/*
> +		 * The group->mutex is held across the callback, which will
> +		 * block calls to iommu_attach/detach_group/device. Hence,
> +		 * the domain of the device will not change during traversal.
> +		 */
> +		iommu_group_for_each_dev(group, &opaque,
> +					 __show_device_domain_translation);
> +		iommu_group_put(group);
> +	}
> 
> -	return ret;
> +	return 0;
> +}
> +
> +static int domain_translation_struct_show(struct seq_file *m, void *unused)
> +{
> +	return bus_for_each_dev(&pci_bus_type, NULL, m,
> +				show_device_domain_translation);
>  }
>  DEFINE_SHOW_ATTRIBUTE(domain_translation_struct);
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 19024dc52735..a39d72a9d1cf 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -314,7 +314,7 @@ static int iommu_skip_te_disable;
>  #define IDENTMAP_GFX		2
>  #define IDENTMAP_AZALIA		4
> 
> -DEFINE_SPINLOCK(device_domain_lock);
> +static DEFINE_SPINLOCK(device_domain_lock);
>  static LIST_HEAD(device_domain_list);
> 
>  /*
> --
> 2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
