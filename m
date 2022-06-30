Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39070C43334
	for <iommu@archiver.kernel.org>; Thu, 30 Jun 2022 08:20:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BE41060EE9;
	Thu, 30 Jun 2022 08:20:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BE41060EE9
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=b2oNsF44
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dxbWhd87TTTT; Thu, 30 Jun 2022 08:20:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 4D91D60B52;
	Thu, 30 Jun 2022 08:20:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4D91D60B52
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 15A67C0021;
	Thu, 30 Jun 2022 08:20:04 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 35852C0011
 for <iommu@lists.linux-foundation.org>; Thu, 30 Jun 2022 08:20:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0907D60EE9
 for <iommu@lists.linux-foundation.org>; Thu, 30 Jun 2022 08:20:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0907D60EE9
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1ImirSZnsKPY for <iommu@lists.linux-foundation.org>;
 Thu, 30 Jun 2022 08:20:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B06B960B52
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B06B960B52
 for <iommu@lists.linux-foundation.org>; Thu, 30 Jun 2022 08:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1656577201; x=1688113201;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=02cTyyD/kaWYK4rimO80JS++3jR2pueEhNhuoHrCOHM=;
 b=b2oNsF441Nxf7iP524cfCSsM841D1UVrTAMpYyc6uileTBfHC/WZmgG/
 7icqAyZ2ORyxrxUDYgaAwvp1VAXfZlo258GsXFVdZIkqQy5ZJvmkKRF59
 5GejPsLR2aSsnz4VZOMjqvvZcbXmaJ8cTpusDEIFbFmtiyUTdrc5C1z/n
 NsqI82ZSNwNInsNKYtqlY7Hk6PKjC7PCa0MJ5wQEX9SwacBdFRf5wfuUp
 E7BmHpWLjQnVLCNEGOC9Gn23Yab38N5v4LLQBXpYUE2JfLO/0odSJmpVp
 FH5Xd5x1DJbWrn6pVde2SXcfHW6+5pU74u72Htfv+uvCCAUQtOumNlJ9i A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10393"; a="343971062"
X-IronPort-AV: E=Sophos;i="5.92,233,1650956400"; d="scan'208";a="343971062"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jun 2022 01:20:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,233,1650956400"; d="scan'208";a="837510123"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
 by fmsmga006.fm.intel.com with ESMTP; 30 Jun 2022 01:20:00 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 30 Jun 2022 01:19:59 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Thu, 30 Jun 2022 01:19:59 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.48) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Thu, 30 Jun 2022 01:19:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YkVyW37ny84fRF8M7A0Z3HMuTKzwtiEzzFmxORfck5JYqOyrxj4f7Ca7T0e15NvYyMpEOnK90QzFvLu7tOkcDqyLqV82YNQKtBLvDwsK4KmCb6oM4U4ctuwr5i1qmEYXRNdBeF02EeNqD2/NZZHwgtmEFx5xCqPnv797Cdb6DREfHT5jsTsDSB1xbZJ2m4XLK3dTKO/T/9Hems+IyHIg4az80y1yHdXUZYihqHIuZ8GScTbv9CNnG86ejIKgsnhnIh6fv4YegHNmFE1YFu/ohRinq6/wYO0/VdY/m3cqtWnq9Uly168lfCuseTAfI2WKXoR3QBm1z/vokcB5lXwPvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=02cTyyD/kaWYK4rimO80JS++3jR2pueEhNhuoHrCOHM=;
 b=SrT8dEPNH5ytRfJtBMvwjn7NUxQ4lbGMszv+KNO4JPrCwlKx0rivn38SgcKmGvrOMYemVjsDTT9Ms6uGl6LrPaDLslTrBgaqNw1wr2AfB4y3GC0di9jict7Vq7nL6tpulUTKd2DqjoZihq6Fw+ieJix317C2MSQYxxiZAqx6P9G3v/pR5yu82BaWPtmV3dbt0gfpHEoriwWL4LnWOdCajQzV5sQtJw2X+1VWVmdXYw96zshN3ukg4VG9tAfKbDS7ycYT737FrWlue11F8YmJbM5UUkTVbTykB5nQJFRMeliYms50h+vn5yXRI6+mhPdZ8VFCwFN+yaiq3DLd+B/Y8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5271.namprd11.prod.outlook.com (2603:10b6:208:31a::21)
 by BL0PR11MB3188.namprd11.prod.outlook.com (2603:10b6:208:61::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.18; Thu, 30 Jun
 2022 08:19:57 +0000
Received: from BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::4847:321e:a45e:2b69]) by BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::4847:321e:a45e:2b69%6]) with mapi id 15.20.5395.015; Thu, 30 Jun 2022
 08:19:57 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, Steve
 Wahl <steve.wahl@hpe.com>
Subject: RE: [PATCH v1 1/6] iommu/vt-d: Remove unused domain_get_iommu()
Thread-Topic: [PATCH v1 1/6] iommu/vt-d: Remove unused domain_get_iommu()
Thread-Index: AQHYiJMEP8ake8SQ3UOLuyjt2TKUmq1nox7A
Date: Thu, 30 Jun 2022 08:19:57 +0000
Message-ID: <BL1PR11MB52710FBCBD22DE63B4B646598CBA9@BL1PR11MB5271.namprd11.prod.outlook.com>
References: <20220625125204.2199437-1-baolu.lu@linux.intel.com>
 <20220625125204.2199437-2-baolu.lu@linux.intel.com>
In-Reply-To: <20220625125204.2199437-2-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 202d781f-f2d1-4cdd-dbfc-08da5a7151d5
x-ms-traffictypediagnostic: BL0PR11MB3188:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9N3wbAZexxyTgMuIqpM5FSqRSDFJjLJE3LxEZTtuSYNklUE0B6UiYFRVOG7u/5An2tkqzPONOec3ULsa/oG0i2GTbOi24ueCVtiw2/k5pZ4s2PUN8lewY4bQki2ju0ltu2AlWCvJWDNhEG+xqDnCNgNYU25OD/OF7+zJKon1i8D6VlUXAcCoCzDU6UAIA3UXQ+W4Q/yJBYAxLhD9C9mQcYsdVO1dB/VpmY0XKsRfmmoNCFjc5pGKuP7wBZpBau2Zjfpf4OslCF3Ex3vWhJdhYqle1+6wRTogrlrjInZq6HIujjghCM+LkCpK4tYf3fLIlP+b8YhuuJwzMacwmq0eL5zVYjfahMWP13ym5tiJdEMJl8b0/o2M0NqDRmOsmriaYwwZi6ekE71zZzBSxmMcpdkDtIumQoW+vfKgLURmMHhPIb9r5peMCeZJJ9WYm1uNvXWIboqqiPcdRpz0YRIb9BR6Uyz1ZKxTqNief6mPB1JfB8DScLm7wyhGvG8mDM3pJ58fWmEH0X5RzVSXKukozu8Iy5AFX/8nuWgBupV9xhOHY+R5mvv2ZXQn7KTMTLddCWfblq8puUZgivjOMr5UGDjxdMixX+Dk5Kb+Mwhi93Qy7f+z1Nog6WO72H9ETf0nL7O1D9Q/vb4NOs9wQmlWMOKvYIkIGWn8YDtGmU4W1vGxw9vrea/uCxRTFj4Uhi8aqUviQHT/t36EWgLBCzqHUT1uZY+Qz44Hh8zcwo/2na+jueyzCx5DtLNhd3nrdnirs7LV9V/nNUojBDhQGN21oDOfZrPkYkEs1kgsdZZ8n4jnQ19yszXCiGzsYOTn5+1x
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR11MB5271.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(346002)(39860400002)(396003)(366004)(376002)(136003)(186003)(55016003)(6506007)(316002)(110136005)(7416002)(86362001)(54906003)(2906002)(41300700001)(7696005)(558084003)(38070700005)(38100700002)(9686003)(66556008)(66476007)(71200400001)(4326008)(76116006)(33656002)(26005)(66946007)(66446008)(5660300002)(8936002)(8676002)(64756008)(122000001)(52536014)(478600001)(82960400001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?a5LFaoHT8PB1dnQRbBDYXxp4kyBmdo8vuKBpue0aAS0G+v9GbvGNKHbsPo4Q?=
 =?us-ascii?Q?J2t8I9L3tGGSnxUjDRF5UhHmbc6QT4BoGUzTzUJ7tWAJsEWqSnyQ7ddaO/XE?=
 =?us-ascii?Q?R2KV+S/loNQJpG8gvZUMEliDq3livCqOt2db37df+GIUK7mJAm5qDasPjdkv?=
 =?us-ascii?Q?IgZ1/sEKcxJUbYA27R+cLwvT+lLrGEVCG0fVvnq7mkhjxqLenVtKxbPSLL1M?=
 =?us-ascii?Q?eTuPsbuzF6HwHvaoIjVkDfxAs1eYPQmVdCWD2zTMIsZPz0xDcxKpejjHPaNw?=
 =?us-ascii?Q?SccOaWRrMQ1TGG5GcjXveObmqy6vi1qL2+urPiGKqHs+FgW8+DTPMJxbPHhQ?=
 =?us-ascii?Q?0TR9BxFxJO/H3SzucBlZxrxr3wnpHbDYhonrgk8gPy24DG9/lIf2gIQ5hweu?=
 =?us-ascii?Q?OGnuoqVlUJlFj8UKOziTWt2i5J91DpDPU4R9gRy2yghPrEPFoG4AZzz7FuPY?=
 =?us-ascii?Q?KN+2MBZPmxpLEhZHRhO16zI9IzoCMogI0SvSO3Jt4FSTt+zjMQgy6fmLnzrf?=
 =?us-ascii?Q?BmG2hNt1W8ZdwI4ZN6GtnLZow64aw3ZKhDcx4HqJ8gjkVx2IbRain9TE6nff?=
 =?us-ascii?Q?9UmsA4z4c+/Sr26KBCn0ftJ7hF/WrUz1OL+hqfKsBUH0+IMq8pUpPZO4J1nB?=
 =?us-ascii?Q?b12SEh152Hdap9L8psBbP73bXfP1HEn428Os8g+w39Iaz8YpuVMaoRqul4WX?=
 =?us-ascii?Q?uIGZb2enTKFO8kJ0jrlVPHBI9eUXVJ/CFb2e52IFc0ClG9YokUudOQyBEDEu?=
 =?us-ascii?Q?ch+v0fHOyHOuuljn8Hkl/lMIZSm0g/jfO4G+h4Ys7rhCFTXOaQxGS1w+GOQZ?=
 =?us-ascii?Q?vo+YBbY8isF0bVJFeUWprM8W8M5Eo0pKEd97PS9UtzXXbB+LSMtwcQK2B56+?=
 =?us-ascii?Q?r8blxZj+O0qxTnFgdmlmjIwwx6Gx1Ef+FcCliAYn0yrKff1rZcok7UWjERUw?=
 =?us-ascii?Q?6v6s5tQhQsKQLf/v6FfaodkqhVL6/1461PajxMDydRoZlOiCf5oGz8Vf8/NA?=
 =?us-ascii?Q?p8gXOo756l1DPNjKuNma5N8FJKrYyGFCGViR/ekdrRPM1Wnttp/xuRcftkaw?=
 =?us-ascii?Q?qWoJA2xioCrAzwWqzCIq3/d/8yfV32Ry6/B5/8BU1jQ8s6SMk/dE3orIHk5A?=
 =?us-ascii?Q?xBWoK6Upgyzs5/gB34VmD0T2me2O72c4VZPyCGf7hNClxRUbXSjr9frCp+I0?=
 =?us-ascii?Q?dQ5N5ey0g4B6JGuUIXxQRE2bdOdFcSU6f3T8tHUhwX7h5Bo+P6fFsqKFJZim?=
 =?us-ascii?Q?NeYUlrmZCVW/8GYDJ8QkGE4ivQHV1XESKGJH/IIewwvfP616TN00l8slYuZB?=
 =?us-ascii?Q?viyP1LNH5itfnDe+W6UdQPWpbN6UOuNTNT4LZqN3TWLlGMpUnMq8mcWiANUL?=
 =?us-ascii?Q?yP7s0YfN4ckGpKgEnmNw6FgoF+0DScMoCMhaMwahfCbzMxKdTJ3uszLZPAyS?=
 =?us-ascii?Q?FjTOrrKCjcRWSD2gMAQHJTWSP6jnlKnrrscsD1WF50QflBrgqoorktpvp1qL?=
 =?us-ascii?Q?Ow/qdmpu035B+VUj9LKpc+FnsgOjPsoKz+I6XvAx0cCKRvrK5eXqEKMtAayc?=
 =?us-ascii?Q?JSjmvAyARjoONIiyX1O4b5jmhuLAJa10/60r9uET?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5271.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 202d781f-f2d1-4cdd-dbfc-08da5a7151d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2022 08:19:57.6807 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FUu0p05DE6xBn3TVaIfCpRrBj4b9K12IG9+6fyvDsca76KERvGFvApj4Yo5cUn6ZKNvxiE/Tn+DvanfcEvTPnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR11MB3188
X-OriginatorOrg: intel.com
Cc: Dimitri Sivanich <sivanich@hpe.com>, "Anderson,
 Russ" <russ.anderson@hpe.com>, Mike Travis <mike.travis@hpe.com>,
 Jerry Snitselaar <jsnitsel@redhat.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 David Woodhouse <dwmw2@infradead.org>
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
> Sent: Saturday, June 25, 2022 8:52 PM
> 
> It is not used anywhere. Remove it to avoid dead code.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
