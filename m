Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1458DC433EF
	for <iommu@archiver.kernel.org>; Thu, 12 May 2022 05:44:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9C5AC83E6C;
	Thu, 12 May 2022 05:44:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id i9dL164EPxjn; Thu, 12 May 2022 05:44:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 7958983E40;
	Thu, 12 May 2022 05:44:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 44FAFC0032;
	Thu, 12 May 2022 05:44:56 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AD9DFC002D
 for <iommu@lists.linux-foundation.org>; Thu, 12 May 2022 05:44:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9B44F60C0B
 for <iommu@lists.linux-foundation.org>; Thu, 12 May 2022 05:44:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fZK2X8a8KRUt for <iommu@lists.linux-foundation.org>;
 Thu, 12 May 2022 05:44:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C79BC60ADC
 for <iommu@lists.linux-foundation.org>; Thu, 12 May 2022 05:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1652334293; x=1683870293;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=UUGNKpz2rgaVYkDLQ07oRSzYeXkyQSzF5yySFlQiOLQ=;
 b=gpvfTUvpqb6rlSGKlb1OexTJJE9VtZaxh7kCresrGe/Rfkt22iZO6vXm
 WyJ+f3Gcr6tLrztTSG6JepnRPWXo9ReUoLqaxKc6IPlNhN0OSNEI8lJt/
 n0s3jDgfY7NMI6uWVS6huhJG7vNkFR60Og4Rqubpm65jDDFAuO5C6a1cM
 Onmes4DaaJ7kz5ZWLHY+CVBN4ic7tf3usDSuzEkJ+hPMH0n32lh1n6NZJ
 ckhvFDO2GCL4A3Eku7rBdpFcdGqGvTg8iqlHDy3AObWSwcV7CsnnN9ivR
 mxny3QHcPRCto4+LQ8U0ZkBDcfzz1LmObfTnieDQd6KEB3HbTmUxoykOw Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10344"; a="295144547"
X-IronPort-AV: E=Sophos;i="5.91,218,1647327600"; d="scan'208";a="295144547"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 May 2022 22:44:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,218,1647327600"; d="scan'208";a="739534669"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
 by orsmga005.jf.intel.com with ESMTP; 11 May 2022 22:44:52 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 11 May 2022 22:44:52 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 11 May 2022 22:44:52 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Wed, 11 May 2022 22:44:52 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.172)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Wed, 11 May 2022 22:44:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ry1KP0m2dVxWx8OvKjyNrsqW4hnNkeS3TRe+GkdfmfIwS+EOwwHmO1x2GJe2ENfo+7iDMTIDqKN7CjLJG8354NhRaK76sth5A3M4CRx4s7mUESsbe0wTOKuBHADJS0LtUs6z0YnPQfOjhHrJ4xtim5mqv/E00OK7esPbU6PdS99O9LCktib4Y/CHcfL9Yd81lBhIIdLFbtZbHOimxtcrySFIUfDGSBOE0AFXDVvSbXAIqfdEL9wrhCro6D6uw/jxae9yLDgJAeaKX9RnginMJ1gzq3+hUmPcMkB7MvOKLUnRnMMF3AWVCATvw9nRc4Rlaw4Ql76+rBmb0lyKraEGNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UUGNKpz2rgaVYkDLQ07oRSzYeXkyQSzF5yySFlQiOLQ=;
 b=G0wsWZ4hOAFv4gv+hYRqDf5OX8JjB0vaJxFVtI3JvnFCCfQ/WY27oUICCR6MNS8sKKN8YXMfQkGbfBrjpcUEQzjqfVxpbwoOBZJxPdit35tR3w5WVmKKER9gCaSI5aLItSGPKVBKK669MxKrZ+7p4n2ta26RsQo6Sya1Vwtydtpl2KV5uMa5p3QC5TdnjwX0p9uFpJ6JFeo2UwLHd9x1RzDWjx40T+PdwZTv6BTUU8EQF3sdJvdUzT9sy2c3DWp+279v8jOobUflvf986DqfPLqppt0QDIx568lkZukQiBhTZYmbctp41BiXQm+Dsja8AJgU1+0wJ2L6kdAjCg2lhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CH2PR11MB4439.namprd11.prod.outlook.com (2603:10b6:610:49::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.22; Thu, 12 May
 2022 05:44:50 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::24dd:37c2:3778:1adb]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::24dd:37c2:3778:1adb%2]) with mapi id 15.20.5250.013; Thu, 12 May 2022
 05:44:49 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Baolu Lu <baolu.lu@linux.intel.com>, Jason Gunthorpe <jgg@nvidia.com>
Subject: RE: [PATCH v6 08/12] iommu/sva: Use attach/detach_pasid_dev in SVA
 interfaces
Thread-Topic: [PATCH v6 08/12] iommu/sva: Use attach/detach_pasid_dev in SVA
 interfaces
Thread-Index: AQHYZDYuY5mdau8gXkqO6XGUIK16Ua0YO2IAgAELqoCAAH48gIAAy8WAgAAf/TCAAAWWAIAAB3Ng
Date: Thu, 12 May 2022 05:44:49 +0000
Message-ID: <BN9PR11MB5276AFC5784F4D1FBA90E6058CCB9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220510061738.2761430-1-baolu.lu@linux.intel.com>
 <20220510061738.2761430-9-baolu.lu@linux.intel.com>
 <20220510152330.GG49344@nvidia.com>
 <749a7d62-3e6c-ef5c-beaf-6b7add495740@linux.intel.com>
 <20220511145319.GZ49344@nvidia.com>
 <05a68e1e-8e18-5914-ebe7-d7b1a4aaa2ec@linux.intel.com>
 <BN9PR11MB5276C03134A898CA9EFEE9258CCB9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <64954f2d-2274-410e-269c-84efc0635633@linux.intel.com>
In-Reply-To: <64954f2d-2274-410e-269c-84efc0635633@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2fd0cdf0-2a65-4010-dc99-08da33da87a7
x-ms-traffictypediagnostic: CH2PR11MB4439:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <CH2PR11MB4439002AC12DCCFB669FBBE38CCB9@CH2PR11MB4439.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: k/TN0uSFVJX8VZM+12XWEj0EBMOBdQdWNZS4v1MIQWp4u9Q4tvjxvgpA5+LfHRaWXQ23QcfATbbQ3uWpBvNIDvGAHf1dTZtrjrXkYzCxZslDEyt1WBiIcUthIemdfjkoRkzTkJ782eKGQFuf+shMWqELALCSYIGlFCIWqp9YzWrudwuz+SZ+7TADTq+DTyJ6eFiQ5S1owPb/29Ki/x9cTRPE/LE8wfeUAI4xqlL3Q6O33MTrVXwIjztXZMFBDIDnqB20Y03ww2OCAjPgPtrWCu03LBs0ANzsj189cnRaEYjGkoOXeA1ZZ/5CrcEzG/oaIEOOLoadZ5fBysIae90H31tJaeuIgMOZtuAjWPJvX/IbXxVHJ6+Xk3ZaaDzBJs4FVSAVGhRf/qw1PaRQb9a1YrS0eR/qpSkkPHNTTm6Q8g3l08pDAKG5g5coCAGa+E2U+CBClw7EQc+u/yvin3Jk9F9UvCOlaxqs5uoI6Ey3WeY/XDxiBiuY9dDq1efYq3WVnt8jyCDiNPzaFYi3n8iRuBjID0HhTdzkfawzlpmOl8Ordeba+tZrPIyV+KSxqiO4D3P7sIPJ43X46n75caCfGClQWguK8oIY8MKuYhkkcHw2zRNw41Jr5RTCFRclsZtXukJUVIHi4NRqgz6kvmRHSLi2a045QWNNLGBUUtanvSaPaNNG8bQW3OkSBqU7fs5bW/3qx+CTUnzNAq27HiDppA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR11MB5276.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(366004)(6506007)(86362001)(53546011)(71200400001)(26005)(7696005)(38070700005)(38100700002)(508600001)(83380400001)(82960400001)(9686003)(122000001)(186003)(55016003)(8936002)(7416002)(52536014)(5660300002)(33656002)(54906003)(110136005)(316002)(2906002)(76116006)(64756008)(66446008)(66476007)(66556008)(66946007)(4326008)(8676002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UzlDSkZFU3JmNExCTnh6bnFBNzdISnNBUnVyTVl0aXZjQmIwZ0Q2UEZEZUI1?=
 =?utf-8?B?dGxOV2RBWnNodEJYWm9MYVBpQTE3b2pkK1FhWExCNzI2bkZtaUI5bTdHb3Fs?=
 =?utf-8?B?Qi9aWVk0ZEwvYlZldVlWSnVyWE1oMHU4WS9GQ21heVluMVJ5WjRWTDJXeTJK?=
 =?utf-8?B?U1l5UXVaaDVKTzMrczBUbWtlSVBGU2Q1NUduNlVuRnVta1lzRVVWZ2NtMDlT?=
 =?utf-8?B?ZXllZ3FhYUkxYkJ6WkU0QnorSHkwQzRHMXVGeFNRN3JDQWt2enF6bFZiVzVW?=
 =?utf-8?B?bW4vSFNrbmhGSVE0Zm0vWlJiRlplUGUxSGx6S3d3dkZiOHdnVFZHUDNFemRj?=
 =?utf-8?B?ck5wOFpUb3M0czZ6L1V4Vy9jV3BtUGhCeDVBVy9kemJ0MjNGRmNDV3RqbEdW?=
 =?utf-8?B?ME4vWDBEeFVXd0N4R2tWUDZyeSsyOW9VQlZrR3pJSldsdGcwNWNteVh2S21u?=
 =?utf-8?B?MFN1N1UyTHo4SjFwZk9yWmpRR1V3UWVRMklYakdjZmJxT3U1VHZORnNuRlpr?=
 =?utf-8?B?L0FNNmZIZjNVS3ZFa2ZsSUF5VTJmcXJ2c2ZZb09WQUUyVUw3d3NFWVhqTExQ?=
 =?utf-8?B?RU0rTVY5Z1lZeVljd2RBN3o0dnlEZmJHS2JneVQ4R0ZhQUR4NkdwSUF1UFpv?=
 =?utf-8?B?cW1YZ015V1I0QmZnbWttaTFraEFzcVlqVUl2TTBiVHEyVE5ra2pTRjZ1aG1p?=
 =?utf-8?B?ZVhlWXJSRHFqWE1UVnl4Q1JPWkl6NmI0U0Q0eDhDUVdzT3hUVmhmMVBsMmdJ?=
 =?utf-8?B?UnJGZU8vUUR0ZDY2NXF6MzJnRHE5dks3SktrWUJxUHZLM3Z4ODJ5aHZVaXc0?=
 =?utf-8?B?dUt6elNUb3NaNE52TklpRGszTTFRdHVHV0JGOS9rd3lTdEFRemlBb1dRMmRC?=
 =?utf-8?B?YndFNUVieVNrcWNTSmUrV0hQUTFEdzAzV3dROEVCZUU3RVhmSEdpV2hJUitj?=
 =?utf-8?B?OGd6QkZTYnJHYkFsanpWWG01cTdyNDhMOHUyVWUvRVNGb0VVUUJhbjF5V3Ez?=
 =?utf-8?B?UVFmN3hHSUhad09yc0Y4T1NJaGlUS3hFa0tySDhkRkdmOVZrOVc2bVY4cHRT?=
 =?utf-8?B?ek9QbXlsVk1oeEZ0OStnQUkvZ2NYRllRcDdrNUdQbXladTBoVlVBUEJSdTJY?=
 =?utf-8?B?aUVtTi90TEQ2V2JrTXJJTENLaXY2Wmk4MTV6akZHVHNRMitTdHlzRy9COTVr?=
 =?utf-8?B?ZDVBbkdNWWlxVkRsUWNua2FOT1k1aTFNcjRBR0NTV1dMNldBMWs4TDZ2MzZ2?=
 =?utf-8?B?VFgxY3hGZitJZEFMYTc0KzNMVWdPc3pybjlJQkhCRUNlall3YThzalRCVWpU?=
 =?utf-8?B?ZEFweVFDaGw0dE0xS0VBcEltcGdaNUhnTURJeXlueWlyNjNIbVFDWXp2VS9R?=
 =?utf-8?B?YWZsRGVDTnRYVnNMUXk3T01qL0s3Wjh1bU4wOEtUdUp5T3Z2V1A4RW9Rc1I0?=
 =?utf-8?B?MTRZaXAxMTB1ZWhaMUxrQnVqYmVQeTFGMHlYMm9SMGFUMzJYbGkwREhWdGtK?=
 =?utf-8?B?MGJEREUvTXNOL1UzQVhBdTB2R2h1NzdhZ3NxN0toRTNBZ3VIL1AwZ2tjV2xQ?=
 =?utf-8?B?V2p3QXc3VXIvZzlxaXFlT3hPaTRRS2t6akRHRGtCOVJrU0pFeTNweXI1WXV5?=
 =?utf-8?B?Q3ZLYm5vWVJtVnpSTlNrT0R3Njg5VndKcVlDVkI5YzJRY1cwSkhxUkcrZFhz?=
 =?utf-8?B?d05IYlg4eEI2TDdGdjFLMm9WME5yTEJ0dWcxblVSbFVSbDh4VWk3OFJYdThR?=
 =?utf-8?B?NFo0ZkloN3h2THl2YnlnRmNsMTJRLzgvWEhQdDlBZThGc1NOZWtNNHJKQW8r?=
 =?utf-8?B?UUZsblBnZEw1UHhobzVCaTNVTHdMNWw0SEYyRFJod29iZ0lxMGZJS21EYUt1?=
 =?utf-8?B?RjF5V0xwT1NLM0x4UjRmSjdpSVNlb2VTbzlHd0tOa2lxWVZuZnludG52RVRY?=
 =?utf-8?B?V1JuNUVTVm1zK05oKzgwYUxONC9WNkJiMys0OGF1citORjVrNXRUdmZwb095?=
 =?utf-8?B?M0Vsa1VxdWR3Nk1MUXZBMU0rdm43TjNYQ0RzbjJ1ZWRmemhXSTlwVyt0a1pB?=
 =?utf-8?B?UVJ1S2YxbTB1VXY4c1N1YXVLQjFuaytWK2hEVnRYc2VrOWJMMkFVZ0VDOUp5?=
 =?utf-8?B?VE5NZkptMVFxSklPUVovZys4bFZGVmdiZ3NIN0QxdHU5K29yUE5TNjJiUEIz?=
 =?utf-8?B?V21uM2M5TDJjVFZ1NTYyNW5DbnR5Y09oZzVvUWluTW1QNE1hTU9DRmRkY205?=
 =?utf-8?B?dzVwbm9JOTJydTh3cHdGUXBac3JVUzk5emZYMWJoeWpKeWl4VnVUY1B0dHdt?=
 =?utf-8?B?b3NlaTVvQXRxYys4akJydWtsNUw5VXB1Q2hmVlFDSWIrY2pzQzhhQT09?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fd0cdf0-2a65-4010-dc99-08da33da87a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2022 05:44:49.7689 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wQnQz0SXhE/zLRE5rsJc1O3Flhr7PBFEH9k94/rW3GqwYASiyJP0LnABJgTdO5oSQao7O/gW+EQdkNOlX/wh3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR11MB4439
X-OriginatorOrg: intel.com
Cc: "Jiang, Dave" <dave.jiang@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 Will Deacon <will@kernel.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Christoph Hellwig <hch@infradead.org>, Vinod Koul <vkoul@kernel.org>, "Pan,
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

> From: Baolu Lu <baolu.lu@linux.intel.com>
> Sent: Thursday, May 12, 2022 1:17 PM
> 
> On 2022/5/12 13:01, Tian, Kevin wrote:
> >> From: Baolu Lu <baolu.lu@linux.intel.com>
> >> Sent: Thursday, May 12, 2022 11:03 AM
> >>
> >> On 2022/5/11 22:53, Jason Gunthorpe wrote:
> >>>>> Also, given the current arrangement it might make sense to have a
> >>>>> struct iommu_domain_sva given that no driver is wrappering this in
> >>>>> something else.
> >>>> Fair enough. How about below wrapper?
> >>>>
> >>>> +struct iommu_sva_domain {
> >>>> +       /*
> >>>> +        * Common iommu domain header,*must*  be put at the top
> >>>> +        * of the structure.
> >>>> +        */
> >>>> +       struct iommu_domain domain;
> >>>> +       struct mm_struct *mm;
> >>>> +       struct iommu_sva bond;
> >>>> +}
> >>>>
> >>>> The refcount is wrapped in bond.
> >>> I'm still not sure that bond is necessary
> >>
> >> "bond" is the sva handle that the device drivers get through calling
> >> iommu_sva_bind().
> >>
> >
> > 'bond' was required before because we didn't have a domain to wrap
> > the page table at that time.
> >
> > Now we have a domain and it is 1:1 associated to bond. Probably
> > make sense now by just returning the domain as the sva handle
> > instead?
> 
> It also includes the device information that the domain has been
> attached. So the sva_unbind() looks like this:
> 
> /**
>   * iommu_sva_unbind_device() - Remove a bond created with
> iommu_sva_bind_device
>   * @handle: the handle returned by iommu_sva_bind_device()
>   *
>   * Put reference to a bond between device and address space. The device
> should
>   * not be issuing any more transaction for this PASID. All outstanding page
>   * requests for this PASID must have been flushed to the IOMMU.
>   */
> void iommu_sva_unbind_device(struct iommu_sva *handle)
> 
> It's fine to replace the iommu_sva with iommu_sva_domain for sva handle,
> if we can include the device in the unbind() interface.

can we just have unbind(domain, device)?

> 
> Anyway, I'd expect to achieve all these in two steps:
> 
> - sva and iopf refactoring, only iommu internal changes;
> - sva interface refactoring, only interface changes.
> 
> Does above work?
> 
> Best regards,
> baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
