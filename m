Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8317C433EF
	for <iommu@archiver.kernel.org>; Fri, 24 Jun 2022 06:31:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6A759848AB;
	Fri, 24 Jun 2022 06:31:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6A759848AB
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=fMxFzuxA
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id v6i6ZWMWM9pD; Fri, 24 Jun 2022 06:31:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 3A603848AA;
	Fri, 24 Jun 2022 06:31:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3A603848AA
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 15EBCC0039;
	Fri, 24 Jun 2022 06:31:51 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 38D8DC002D
 for <iommu@lists.linux-foundation.org>; Fri, 24 Jun 2022 06:31:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 11E9D4179B
 for <iommu@lists.linux-foundation.org>; Fri, 24 Jun 2022 06:31:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 11E9D4179B
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=fMxFzuxA
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0bYi3_oLE4Df for <iommu@lists.linux-foundation.org>;
 Fri, 24 Jun 2022 06:31:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 10F7B41583
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 10F7B41583
 for <iommu@lists.linux-foundation.org>; Fri, 24 Jun 2022 06:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1656052309; x=1687588309;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=hI+5wy7XFsTnnUSh755hITNMO1shxmiWTds7IpoTd1k=;
 b=fMxFzuxAsVfmNcm4u6wsfcblqKdfulnRbfz+31cLMOm91jo5y8eUnH8I
 KGZd6ggZkJl8EELc06LvynFpsjpeCR9bsPDNZ0uULkrNVHqng2k+VA0Nc
 cC31/D+ko0571vuyVV7GHshpnVciEIM4aCs+RRwad5/JNm+yeZRurftgp
 IJE7zC4eU7zuROwhIdkPHmEzCP4p5ixBQIkzQijxBhs9XVH2mMozpjRKc
 TOhHBRXVd7e7KdBNO5mWPqKd0OBSuoNeSHGxQyEoRCJS4WMvaTftwkwlD
 l22xzj9Xmf8xLUj6CRz37LcN+W7rWiCyFyfALRUTb2ZwZ5a5kmelq+XTU g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10387"; a="367254242"
X-IronPort-AV: E=Sophos;i="5.92,218,1650956400"; d="scan'208";a="367254242"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jun 2022 23:31:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,218,1650956400"; d="scan'208";a="621619915"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
 by orsmga001.jf.intel.com with ESMTP; 23 Jun 2022 23:31:48 -0700
Received: from orsmsx604.amr.corp.intel.com (10.22.229.17) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 23 Jun 2022 23:31:47 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Thu, 23 Jun 2022 23:31:47 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.108)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Thu, 23 Jun 2022 23:31:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WOEjieCc+4mGXbSuECyhIcjzUxt44r0Za7Jw/SbxAc8YBLSwETYezFS5AMcxYoajOAtZrQiVuqC7u6pegzjbLdnIvQeBxah32o41skmq+tyi/2Mn+uQTrQ9mU7JCY9tlRRicy8ajodNo6agrjqLQNvF1kxGBKxlqZ09vWQxI1sGuqM7Mp8SRbj6CCpsw84uDaOxaYmX6UNzU7HwQI8hkqxjdv1qtm3Ob6CaMk4IOEbUclm755TJtZ7qJg+JApH8oLFxR7UBQ02lEfS9Pjpts3SzSEJf7PWS29wABoN/UIDt42ogjcjM0IP5dreol9fARGS8b6ARz7tdFDpGyNyWvTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hI+5wy7XFsTnnUSh755hITNMO1shxmiWTds7IpoTd1k=;
 b=Udllrt4MhyYnKyV1g9FdUHcxvkWOpCYIqIsbcbmh4t3JgkEfig8farzaqPDmf0/dagG8IqVIMYc2W2xwYP7TYYFjkHx0YMvpGjhacn4kp9lqkJZA3rN9TTNV8WJcOIszV5Z8CE5vBYAwg9a1DgciArlTfppGgxxweFXcWsupx0B5QnlUh6BQ/lP0U7NApNXlQMZiMfAC9trIeQybaTUj7+1uQMk9kafMAafd53l2UZeHkTkW89qV+x/Th++sOmL6HaNhtqLOtH+RfhwCk2xKO4mwuKqjI9jrwCbNtvxbuJdQ5X8kDpLlkUEXnH1fapmRlb8hELB6V+EVjvm7i1pmrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by MN2PR11MB4285.namprd11.prod.outlook.com (2603:10b6:208:191::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15; Fri, 24 Jun
 2022 06:31:46 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::8435:5a99:1e28:b38c]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::8435:5a99:1e28:b38c%2]) with mapi id 15.20.5373.017; Fri, 24 Jun 2022
 06:31:46 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, "Raj, 
 Ashok" <ashok.raj@intel.com>
Subject: RE: [PATCH v3 1/1] iommu/vt-d: Fix RID2PASID setup/teardown failure
Thread-Topic: [PATCH v3 1/1] iommu/vt-d: Fix RID2PASID setup/teardown failure
Thread-Index: AQHYhs8ZnDJgEPiUSU6v0m07+WgrOK1eGi/g
Date: Fri, 24 Jun 2022 06:31:45 +0000
Message-ID: <BN9PR11MB5276A576BABC8E9525966E388CB49@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220623065720.727849-1-baolu.lu@linux.intel.com>
In-Reply-To: <20220623065720.727849-1-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 92e6a4d1-2d17-4b3d-84e7-08da55ab35f0
x-ms-traffictypediagnostic: MN2PR11MB4285:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FzSWwi71dXqkhfuhnS3o0ujbfekNxIv1S5eGfbadnUGDVMUtnuHrSeMUEk2Buk5RcUpDUh9B5fkkrZUuDxXQ1JLIOlSPdgSDtr7JCmelUkwL6fKdwX/zFEP8wvlB4l7ZhckVm1DE8EaoVkH1wlIxbrw7YHqLAShKQ3fsWcy6XoIWlV8HNk1+enLVnqkQxX6SBPDgWm1E0+s3o8LVCUhJ+iY7LMfiD7+9v+jX908CJAGKBbj9O7kcON3S2hu7vplasOK4UJneCPLalFzNhKV/5o/JDZOdgzvTBwKUHFODsTKQFJPSIvTQq1KuwYjWKXi7sk9agLtOfTDt4hi41F9dt7Gx0EqHqmI37fgKRxKtvQbcf1250t3gvMWFLL2EPgnF5u3KaBdIKyKfbcm+0IgsiAUtJZ7PKmnPQ3yLeySxSkUPYVduVWxZGHheZph2wyVg8OVPPxqIMkPWveybxFUWAo6wvOnjxyVbQxk1xomv/Ol4grQSOgrSoucz4knUToSfl+OU8OkCMKoewPxeMAnCaFJwCd9j8xHFBiecE/TCTaKtDMYMN/7y/WCybF3iSL95Mz3ZEdC4Cm2rJIhbuZ4FDaKYPvMzrfrdudFD0EsQBHg445NNiHxqJjWTtbQ7Hgr8fin9BsYZIO0Mh1O4G+LnAvDlS9wfGYp/v8DgFsY4F6wYi79OKifHHRDz5GZLWExCL0jRlff7r1gtpoNFrZ3lBZo3Vq8tdSvg3ZiD1gzTBC0AiWDQcWzWorCBynwuPubmxfTwLUGrBBFXok3AsgMmolK54rwG25RtZtAS7IF2gjY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR11MB5276.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(376002)(39860400002)(346002)(366004)(396003)(136003)(76116006)(110136005)(71200400001)(41300700001)(2906002)(478600001)(26005)(66446008)(38070700005)(316002)(83380400001)(5660300002)(6636002)(66556008)(33656002)(86362001)(64756008)(52536014)(66946007)(4326008)(9686003)(8936002)(54906003)(66476007)(8676002)(6506007)(7696005)(38100700002)(122000001)(55016003)(186003)(82960400001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?XRUyskrgq1Q+UBz1Fy+6z6Ia8ihH7BVGaV7tUXDK5tO/VRN8z3XkiC95754Y?=
 =?us-ascii?Q?OaTH/bVZMUUfldqa8/86tOI3Nt6yp57dyMBWkl5Qy0i476eVcwXKxB4T/bsl?=
 =?us-ascii?Q?tC95ujpt4O6OesYcD5M6EAhzFpnHsZX0G928xNHIMLWE1uQ2IrVR8AjQTlro?=
 =?us-ascii?Q?LvveSGp1vXvsQo4cACT7D5kkj1Q6agnIafipKOSijumGuN+MAqGJ/+3GcnMk?=
 =?us-ascii?Q?7IeqjaGW9KvI6YcMn9eSz0lnV3n4oYFthtSI58STsbCPjhhbxBptRvMH8wdt?=
 =?us-ascii?Q?4SA7hHKfhSmoCnuPOYzmG0PBSeDtMm2//As/52s6mPyog7s0y4PKVrgDt7vh?=
 =?us-ascii?Q?i7SFGhyR7zsxtsQGwFARYCDddw5j4uBVMQtDGCUzbbYbx2Cll6iGmQAAYhvc?=
 =?us-ascii?Q?p4xC/noGHW9b5yo9zI06lNZ+dQ6nMfBOlfxpOCh34v+31nKnQJ3hkgxgqtGp?=
 =?us-ascii?Q?0aU8oGf0WMpsQl6dNR+OlCIj1zHHYfM2qAcAfFWKb/3mVdL2ph5F2A3IG1Eq?=
 =?us-ascii?Q?iGiqILrRScfL9S8+mL60/5Cry71+tWfD0E5P8g8cVv01p7pOF45wh+lE9+bK?=
 =?us-ascii?Q?4dPxmcf7akSWZCgOCz+WKboU2ZVP1TVzLyNvKeDtjyXIV/O02LC1T7oU/p33?=
 =?us-ascii?Q?9dyv0L8KHQ0d0fJmlyIk7xURgGHGlbPg42iRlFSTvLRewg9OBPmsuE0JpT5b?=
 =?us-ascii?Q?awB7guZrVHlfjyjGF/z63/A58Fuejn601KyV9h85MTnVrTZ1gR2XptaE3aiO?=
 =?us-ascii?Q?T5UnjpaIurz2aYfVZt7MBS5K9ZA5w9K60fZNRnK+maRRO16B8BhRdyNOe6/v?=
 =?us-ascii?Q?O/BDgeZYlmEklKP3MVBNZMYk3sxFqxBGjrhbovcWFykyW0bXk6F8qykhRRx8?=
 =?us-ascii?Q?YG5cFMoCPEC4ibzdze+kW4L8mNDXR1JqwJvaCyTsD59W9ugxaGN7r6D8tvyc?=
 =?us-ascii?Q?aieZspJzG5awIOru0WbLLXCKSZBhtAxbpdRtBIT9PQ4xgNZjO93xvRUnoUQr?=
 =?us-ascii?Q?DYWnj/OXl5lczS5STK6OOj8iUC2tjTBHiz3E7RjLXnsdtWpI+Zdd0xDJu0ib?=
 =?us-ascii?Q?cKgAaAOSV2SKrTshBFMcr1+cnrYi/3wFy642PNZXBfKyXM3NQFmElOj+Pz7k?=
 =?us-ascii?Q?2tP8xAKcQT0b/ITDZwee57vfDIHTNkLDBFUDpt0jsH0sC6JwRS93QNxSYM0z?=
 =?us-ascii?Q?Ov2sJPhUwjcn0V1Y0LfYrcbbcX0p8CtY/rdM4DV8k/N6VNdTqdI4ZIp5SYK4?=
 =?us-ascii?Q?wQjsH1oFEjcgO3FrWYb7xSG5ruBP/9r0+5sIBI/v7B3riBD+vKSuFcK+Ti69?=
 =?us-ascii?Q?xWmgiVCFq6lWFgA2lu81DsI9a2bSN5vrq5nRuXHtu27nq0ILegln3jTbTGpq?=
 =?us-ascii?Q?EeTXpcFIBb/qQ9s0Cb3WlG1pfxotKXiYjA5/3sP3l+hJP+PXVTB9yAsOIjbu?=
 =?us-ascii?Q?P/BcZl6pKeuJEOage0D1YNHj3vtSjPEcFlu72MbP59DajI9Jep/1KKdn4w1h?=
 =?us-ascii?Q?w8Sfg7OBBb50xoKjKPI/g/tB2DJizrf4opI4bHliAuaXuBE2K1NluOW1oV4Q?=
 =?us-ascii?Q?jYJAhSK2V8wvjCJvu0K6bQMPQoWX29zB4JBhwf9K?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92e6a4d1-2d17-4b3d-84e7-08da55ab35f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2022 06:31:45.8757 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +3Grq4NpXedhKFnr3DZxLcgI93EYW22gjF7qCRWfwBLFPfDD208gWu00uLu9oCSE1QdeU90aMDGaF24vu0IGvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4285
X-OriginatorOrg: intel.com
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>, "Qiang,
 Chenyi" <chenyi.qiang@intel.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Pan,
 Jacob
 jun" <jacob.jun.pan@intel.com>, Ethan Zhao <haifeng.zhao@linux.intel.com>
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
> Sent: Thursday, June 23, 2022 2:57 PM
> 
> The IOMMU driver shares the pasid table for PCI alias devices. When the
> RID2PASID entry of the shared pasid table has been filled by the first
> device, the subsequent device will encounter the "DMAR: Setup RID2PASID
> failed" failure as the pasid entry has already been marked as present.
> As the result, the IOMMU probing process will be aborted.
> 
> On the contrary, when any alias device is hot-removed from the system,
> for example, by writing to /sys/bus/pci/devices/.../remove, the shared
> RID2PASID will be cleared without any notifications to other devices.
> As the result, any DMAs from those rest devices are blocked.
> 
> Sharing pasid table among PCI alias devices could save two memory pages
> for devices underneath the PCIe-to-PCI bridges. Anyway, considering that
> those devices are rare on modern platforms that support VT-d in scalable
> mode and the saved memory is negligible, it's reasonable to remove this
> part of immature code to make the driver feasible and stable.
> 
> Fixes: ef848b7e5a6a0 ("iommu/vt-d: Setup pasid entry for RID2PASID
> support")
> Reported-by: Chenyi Qiang <chenyi.qiang@intel.com>
> Reported-by: Ethan Zhao <haifeng.zhao@linux.intel.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>

Looks good.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
