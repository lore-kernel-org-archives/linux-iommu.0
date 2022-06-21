Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EE6CC43334
	for <iommu@archiver.kernel.org>; Tue, 21 Jun 2022 03:46:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 180FF408A4;
	Tue, 21 Jun 2022 03:46:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 180FF408A4
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=mDMebuud
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id O_OWD9rIxwB7; Tue, 21 Jun 2022 03:46:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 8654F408A3;
	Tue, 21 Jun 2022 03:46:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8654F408A3
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4C90FC0039;
	Tue, 21 Jun 2022 03:46:45 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5B053C002D
 for <iommu@lists.linux-foundation.org>; Tue, 21 Jun 2022 03:46:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1DA2561024
 for <iommu@lists.linux-foundation.org>; Tue, 21 Jun 2022 03:46:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1DA2561024
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=mDMebuud
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id G_R_LBMuNJ3a for <iommu@lists.linux-foundation.org>;
 Tue, 21 Jun 2022 03:46:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1FF5F60BC0
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1FF5F60BC0
 for <iommu@lists.linux-foundation.org>; Tue, 21 Jun 2022 03:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1655783203; x=1687319203;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=h6rnThC1o9psJ0MOOnpyPQxJSxVics562O+rEdwkzA0=;
 b=mDMebuudS3+zZABK8ccHFMEr8DaSY/5PTBgZrAMQUNqogL28+Klyi6Ey
 frJM6G8nXQmXpCBNMLRZ8rcHtjrk1Kr9N4D52Ibz90aA1AXJMAnglytJT
 7uwqpnB90aGz0QPE/QRQjoA7g8EJrgblUuWJNBrp/U87wuXicqqNOgjDj
 hKe1cSPup2cjn5I0+JAPMjD5lz2ftWDcIRpDLWVLYApx9SGKo2WpwrUOw
 vT+f0lwzi6/VT2t5sWmpmYVWH9NQnmziHcPCMtMlPz03h4g4iQI7WWX23
 hAVULFxHw8nux2vDZrxeGmzT+pHljsHQDTUw6BiYL8DYigS5K9xPE7wUA Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10384"; a="260452174"
X-IronPort-AV: E=Sophos;i="5.92,207,1650956400"; d="scan'208";a="260452174"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jun 2022 20:46:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,207,1650956400"; d="scan'208";a="654953799"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by fmsmga004.fm.intel.com with ESMTP; 20 Jun 2022 20:46:41 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 20 Jun 2022 20:46:40 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 20 Jun 2022 20:46:40 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Mon, 20 Jun 2022 20:46:40 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.174)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Mon, 20 Jun 2022 20:46:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DrUqDZnmbf1CBnf8XvvwRSOg5+cHjIy/TbNV49meI5CEwKFuT1HDfKgF7jcPbtnuliyAoohOefc3LAiL3EQSVl6MatHzILL34JXqtVdrol+WPfBC0gxlPMx1lc4pyt9x5IWxmFGTzYbUZ42LdMKmVaSPJcBtAOzaIEeE45FWAlxjiXF8REQ6r+b3ulRDev0ts+HmVGLINycLlK2KYL77l1KshYF16LitBS/UD7U0GnNFomKm/yw937O3JMIe4iSe6oYoTc/xAEK6CsjhdYLST7Nx//OACYQ7Lw9glj073IHWtD0RQSXIFYVXW7qrT42g2ohfJGzDoS3rJNlzICIhZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h6rnThC1o9psJ0MOOnpyPQxJSxVics562O+rEdwkzA0=;
 b=iDoovchFiIYwOBw12Qnz2IyHUDQ30Cb5aT0unwlZY0zdHn2oto3CeagnjPqnMUpMl4BbZMArktSDWCzKU7oSE+OZFA5yFwtdLZ5ofXUhkmPetK1ohZouO4d8WjYyWPxuoQe1gxmhjRflDZN4J39q2D0ZRst/qLkfbCHjw0mO3i3M8huQg+OJcwKgtavwYh6a9s099Io8zH0vR3Lp6/S0yzuRX1cy6i3pi3r1Drw9fxx+OMV/UUTcKnnwp/1lzu6sCYsYR5Ay2ITgsha453N0lKf9A5DHyA+YOImXZKgeTRRcKbni86OP2FDxxwzoDYbCQnLYP5r1+/2mU4Gt3Yhvog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by MN2PR11MB4477.namprd11.prod.outlook.com (2603:10b6:208:17a::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14; Tue, 21 Jun
 2022 03:46:38 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::8435:5a99:1e28:b38c]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::8435:5a99:1e28:b38c%2]) with mapi id 15.20.5353.022; Tue, 21 Jun 2022
 03:46:38 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Baolu Lu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, "Raj, 
 Ashok" <ashok.raj@intel.com>
Subject: RE: [PATCH 1/1] iommu/vt-d: Fix RID2PASID setup failure
Thread-Topic: [PATCH 1/1] iommu/vt-d: Fix RID2PASID setup failure
Thread-Index: AQHYhH7LXPufoGLZlE+CLUNrmpMHyq1ZKuMwgAANHACAAADskA==
Date: Tue, 21 Jun 2022 03:46:38 +0000
Message-ID: <BN9PR11MB527671B3B4C1F786E40D67408CB39@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220620081729.4610-1-baolu.lu@linux.intel.com>
 <BN9PR11MB52764F60972DF52EEF945D408CB39@BN9PR11MB5276.namprd11.prod.outlook.com>
 <5d13cab5-1f0a-51c7-78a3-fb5d3d793ab1@linux.intel.com>
In-Reply-To: <5d13cab5-1f0a-51c7-78a3-fb5d3d793ab1@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6b1a3918-478d-466a-7f1a-08da5338a530
x-ms-traffictypediagnostic: MN2PR11MB4477:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <MN2PR11MB44775C4A89D4B4855AF5835A8CB39@MN2PR11MB4477.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Wn5X8JPHJaxgV+eJ8J/iipFSWbQtIkqJNJBu0W1ExDS8W+rLrrs999rT5waqFI8sDUp7gVGFgbhDxnKs+sALL0QCyhS1B+tHTyswZY9RIXvg4FX3IfOwah5/xEHBHQmycpTElzNQZTuufTbtifxnZd1iLR6C+PEti2Kny+nlJO1jTLgnEOHSpiVXHr2Qv88wrDvr6u9RwqnZZoFv0fSug4ZrJXSfZr7DXfOL0rg75EJmuhV48/p/PrUsuI03RTawDSHHHk4fVV5dy/WuknN/XKzg1W83lMQLvi1vOHTfev6hlQHoxnoaQUhoiul7Ojqm7vkpLLMMxj647I0wknFJs/pH4WOVukrylHf7OAdp/8H3xC8fbnaodgoFFrPNIJQ/2PjDs8J5/uYRzrI5E9vAHOApsPQWOm6fAlmHMEzZ8Pfa/ohmWRXbUbYWQQges/tvn0Ku9UVKR5bHFOLnduKDRskL2Y6wy0WHfJghtE3cVMHd5TJ1TDBSjt/4349RFeIZDSqHvKj7/ObW80+EHDUQ/2KekFUUs0KtlcVUEOTNC8LxbnNutXgQJX3xpkjNlL2iIO4b0LKdpSPlv+N2qK6T7c8t6gHo8IfW+6np5AK2wt3dhr2UlyOqBlLf2cnO086LwoDSjMffWQNi6tNhEn9TYwREgsKhZ5axfeX/WWOXbczMmDpxGinCXzzfTZN9OQX1PAR7z2WzNrZkvt1JnDtmhw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR11MB5276.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(376002)(346002)(396003)(366004)(39860400002)(136003)(83380400001)(55016003)(66946007)(66446008)(76116006)(66556008)(38070700005)(66476007)(4326008)(110136005)(82960400001)(6636002)(186003)(8936002)(8676002)(54906003)(478600001)(64756008)(71200400001)(52536014)(38100700002)(316002)(41300700001)(6506007)(33656002)(5660300002)(26005)(53546011)(122000001)(9686003)(2906002)(7696005)(86362001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NC9iampMUlhsZ3VKd3pEQlZoMlhrUFJISGZwTSttUm1CczBnVkRQaDUxVmM3?=
 =?utf-8?B?R1lmc2dRMnM4ZnNya0NzQlhGU1FLKzRTR2tqNENTN3JLVUhjU2QzMEJFQjEw?=
 =?utf-8?B?QkVvTExIQU5icDJLSkx2Y2ExVTBsQU51S1BIUFdyclY3dWVON0RwcEFXRmE0?=
 =?utf-8?B?ZUg2aGQ5WWpOUC9sWW9xN2hVVmlRbXJGRVdEREZDRVhOeU91TnovUGxuTFRW?=
 =?utf-8?B?bHJnb0N1UlR3d3JoVE54b2RJckRVcjNza2g0TUR5RVlLVTJsWG1pejhsRis5?=
 =?utf-8?B?NHZuY0ZONFIyak4vVThSMUJoSlkzZDZERWpDRmdXTDRZYlFJaktJeVdEd0ZC?=
 =?utf-8?B?anduQlJaMC9aMWVKSWt4M1VxTzlZa24zTE5Balo4aFh6aVV1T0VUMHRMWno5?=
 =?utf-8?B?Qm01V2o1YWJHaFFPdGlDYUE3V21aSlZUSloxOUFSMGpiTzQ1a0s0bHJWb1BQ?=
 =?utf-8?B?SjlNNGJ6bnRqcVZnZVlDM0JKMitjSHhsTkc0dHhQTnpnQldoZ0ZaWHFuaXE3?=
 =?utf-8?B?bGgyYU5Xdi9zMEh6cm5PRVNBNjdteEgxSjVwWGViQU11RnRkSE90ZUVFWkxS?=
 =?utf-8?B?ajRnc1J1cXhzZnZiSmo4elBORzRQOFJLZlB1enJ0NVpROEJYQ01tb1ZjcGZR?=
 =?utf-8?B?MTErMUFVZkRPT1IrcFlsVkJJSDVxL0F0QVBzeWlEQzNKUmJLbnRwYXN6emZV?=
 =?utf-8?B?d05Wb3l3cldTNGNKNmk3N05YellIVFdDbEhhMTZEVGNsenZZQjhZTEd5aHpj?=
 =?utf-8?B?S0dENVpOSk5ETkwyU01MUjFhR09TTThmUmJ0aUpHdUs3MUhGdmIxTGRWaHMx?=
 =?utf-8?B?VEJIWGRTampQbU9qSlBVbW8xMUZWWFFLWFdCWVhOZTY4SGptQ0xzTEZORFpy?=
 =?utf-8?B?akx3eTBJNTNNL1QrZnIyaXdoVzc3bkFUNkxOeDhTWnZhWFB6WXZaMjMydkNp?=
 =?utf-8?B?QXdoQ20wQ3hrd1RDUk1rbjhXQXdzVEx6a3JKdldzSUtvdVZCdnQ3UytqdjVq?=
 =?utf-8?B?b2tvSGxqeCtxQTJNT3ppdFBrdTFiMXB4K2ZLU2NrNE9wUDRYV2p5Q2pVSFRy?=
 =?utf-8?B?WmZTTGFaTm1lMHI5VkVNdUtxZThvY3BKdmJaMUdzbFRiMEx0OEJXTWlUdFFK?=
 =?utf-8?B?YXl1cEs2eUxVNEZkdkRaZjM3RVhVMUZrdU5YUjFwZFdLVEZDSVZkV0VEcXo0?=
 =?utf-8?B?QTJGOVZxdUh3aWNFM1pIY0lBNFZUVVFhSGR0Rm1SSDB3YUIrWnNTZ3dyeGxU?=
 =?utf-8?B?L0VMU3JXdldacTlmZ3ZTVE9wbjhBYXd4RFUwYUpVdVhWYmUzRnJxUzNIZE1w?=
 =?utf-8?B?UWh0ZlhkNWh6TzNaY0thc3hKSjBQTGJoalRZcEFZOWs4STNxcVhDMlpVQ05S?=
 =?utf-8?B?cW01MnFSWHRkMjdkM2pSd3VaUUQxVzliUUE3b25xZjZxekpLNnByalRJNTRF?=
 =?utf-8?B?cFlwd21XN28ybCt5bXJNQURxZk9YRTY1RmovS3orMVVVdXdWYzFrTUJYbEVa?=
 =?utf-8?B?ZUJnK0w1bk9GM1JzNEZ2QXF0NW9HOWJTMWxVMFduU0RFdDZSMWVJWTVxWnBk?=
 =?utf-8?B?eWowNXU1VDhNejZaK3NUTC9ab29oTUtTYzBsbE1JSk1JL012UXExUXdlUElX?=
 =?utf-8?B?aXNHTyt2MUVsM2cvK3laMWpXa2szYjB3eUNDd1dVWnhBVlBkR3FCMUxHZnNx?=
 =?utf-8?B?NUpKNEVaZEZJN0REZU50UHp2ZHdXS2dqY0Z5elhQV3ovKzcrM3k0U1c5MDFZ?=
 =?utf-8?B?ZWo0eHBiQzlRdENaa2VmcmFKcFMrNjJETTZRYWJzbVg1N29IZmpMYXRFYUgy?=
 =?utf-8?B?ajBqbERvMVdacGtEWkFBVGw1RFZucmhQNW52VmdxM3VIbzgzeWtCaFFiSUI4?=
 =?utf-8?B?Ujg3YnBRNVRCMDJQNHpxR0F1WUplOFo5cXFjYnlaVFM3K095aUhQLzRQdHpi?=
 =?utf-8?B?SXRUTzAwR1J0NVdWK25ZalRQQTRHMW5YMXdLazFSMm5xc3pFUllzS1lWN20y?=
 =?utf-8?B?QlowWmd4eDh2ckhYRnE2UE1EQlpUR2VVY3E1R2l6enB2bjlRdGhnRVM3OHFP?=
 =?utf-8?B?TFByNHh1eHdTQjBIOEZoRElRQzRuODZTOXVSTjd4cG9tbmZ6cWhNZEVIMEFZ?=
 =?utf-8?B?clp0ZFd6RlczT3d5UUZuSTUyWDZsNTNqNEVqcnkxWmxkZ2lWWGllUUEyekNv?=
 =?utf-8?B?LzhzdS9RQzBMSWJLOGNiWko2RElXRFpVMUhHRHpWVzJpaEh4bHN6c1QyQnpV?=
 =?utf-8?B?MGYvcmx6TFJ0U0VwT1NodUhXaXJIWmV0R1B4bVpDNTFlQ01qMXFoUmZmUDI5?=
 =?utf-8?B?VlorejhXTUxkc0VNMWpCZTFtbFlNS0ZwdENtOXltMW9ZckRxdjIzdz09?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b1a3918-478d-466a-7f1a-08da5338a530
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2022 03:46:38.0726 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DsKObKKdTEprQp1g0VL6sRD13DyaMm89JxwzphyvTAjoC1F51ECNTDkylmU+YGiS77gRNrMy3LgzfDUk7An80Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4477
X-OriginatorOrg: intel.com
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>, "Qiang,
 Chenyi" <chenyi.qiang@intel.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Pan,
 Jacob jun" <jacob.jun.pan@intel.com>
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

> From: Baolu Lu <baolu.lu@linux.intel.com>
> Sent: Tuesday, June 21, 2022 11:39 AM
> 
> On 2022/6/21 10:54, Tian, Kevin wrote:
> >> From: Lu Baolu <baolu.lu@linux.intel.com>
> >> Sent: Monday, June 20, 2022 4:17 PM
> >> @@ -2564,7 +2564,7 @@ static int domain_add_dev_info(struct
> >> dmar_domain *domain, struct device *dev)
> >>   			ret = intel_pasid_setup_second_level(iommu,
> >> domain,
> >>   					dev, PASID_RID2PASID);
> >>   		spin_unlock_irqrestore(&iommu->lock, flags);
> >> -		if (ret) {
> >> +		if (ret && ret != -EBUSY) {
> >>   			dev_err(dev, "Setup RID2PASID failed\n");
> >>   			dmar_remove_one_dev_info(dev);
> >>   			return ret;
> >> --
> >> 2.25.1
> >
> > It's cleaner to avoid this error at the first place, i.e. only do the
> > setup when the first device is attached to the pasid table.
> 
> The logic that identifies the first device might introduce additional
> unnecessary complexity. Devices that share a pasid table are rare. I
> even prefer to give up sharing tables so that the code can be
> simpler.:-)
> 

It's not that complex if you simply move device_attach_pasid_table()
out of intel_pasid_alloc_table(). Then do the setup if
list_empty(&pasid_table->dev) and then attach device to the
pasid table in domain_add_dev_info().
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
