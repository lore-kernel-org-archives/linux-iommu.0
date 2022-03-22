Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48BABC433F5
	for <iommu@archiver.kernel.org>; Tue, 22 Mar 2022 00:26:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DE3448430B;
	Tue, 22 Mar 2022 00:26:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cEzXpcKSLKvb; Tue, 22 Mar 2022 00:26:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 2502F842BB;
	Tue, 22 Mar 2022 00:26:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0730BC0012;
	Tue, 22 Mar 2022 00:26:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 740B9C000B
 for <iommu@lists.linux-foundation.org>; Tue, 22 Mar 2022 00:26:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 61F908430B
 for <iommu@lists.linux-foundation.org>; Tue, 22 Mar 2022 00:26:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bpHdIJ3-ebuH for <iommu@lists.linux-foundation.org>;
 Tue, 22 Mar 2022 00:26:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9B3B9842BB
 for <iommu@lists.linux-foundation.org>; Tue, 22 Mar 2022 00:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1647908803; x=1679444803;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=aPUV1bmG8qUftg1F74EZmpxAatgzoZ/2wsMGfbtk1Es=;
 b=ZXoOXZQWKSLp/GxiVIUTfk8eZcmJO6upn6YXnfQnoRTFBe3WjgOzZ7Vl
 X+CzXIGK03pq8ABWqAAq56CSDLBJLo+3ojfZLYWFC04bRKGI1slWml8HY
 UBDYCfYtNETSaGW9jHufim23uDSB/lCzbcINp3Qvw2tY7IHuyPQhlVigv
 686Ar3cwNCSgO9Fzsv+6BMJ+9gR0ilR2AVyXiAaxEe/IaEil62IPA1Onk
 sR/Z9xiPRkNzQtiMLKWV06TalkaGKCZhOYeDt9HMqifv8Rj5pUsuyFLst
 KobqeUNLSjxwLGma/5z5yg3mygZE+MhwlEYqGgCOX4bR6m7vbQW/qAlfg w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10293"; a="237625695"
X-IronPort-AV: E=Sophos;i="5.90,200,1643702400"; d="scan'208";a="237625695"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Mar 2022 17:26:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,200,1643702400"; d="scan'208";a="518649413"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
 by orsmga006.jf.intel.com with ESMTP; 21 Mar 2022 17:26:42 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 21 Mar 2022 17:26:42 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 21 Mar 2022 17:26:41 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Mon, 21 Mar 2022 17:26:41 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.173)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Mon, 21 Mar 2022 17:26:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fVIGZ2jyWmT1ZwFqcCGcJSNBUdfBXktBgYZ/J4qxFud/JzzM5P7GPcYsqJfTCHnCyRxaZny3tII8VQzdWAbErzEAYnbOzoq6j1mvFa1r3whrE2NivevsNHgrCmMOFZK2T4+NnigQMX6RaPp0RMwuECJhXpUcTNNyyghPw9oJt19+/sfGA9Tex1LWck35HyvThrfb8znlMxJm87cHxa1ppcLAo6iZfUEBnlZwWOg/TGJTSBx6Qf+oMoSFbsQIfADBqtJWkoYvKLcCDgU+qf8E+45Rk/LujQxPMWogB3Q2/WYWBr6Qx6BRyJX+VrQr5Wsx67rXxu/cmmAouQdUsWs71g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aPUV1bmG8qUftg1F74EZmpxAatgzoZ/2wsMGfbtk1Es=;
 b=YWUjp/P5TBj2sfK3c1zBHcLMh4mch8wSP7XXK/agBhhJnOQgOcgUnL5lpW7S7JF+h3AuqfmhcRp+vd5G4xvErEmCjGieft0tj8j2l22B2+SWf48Q79ZR7fN4tyfkOv5d/bz7JQXMgFlY8jMsbY1PHJ0hQrQzkN0o4BaZLRHAJ24CEXxAOmJI3MOI6qKHj+SoEkTWJJL8EuUg6Q+UD9lpTG1c04TF+81Iak9gwLmaGLx9HY//HaN4l+PlQ4fL/GIN4mkmkMim/q3Puxg6QqQR6ORQpXiXdrqFOd9yJ9zdwYcPbDBRxmEqRebP7CJV98hNRy2ldOyp0i0t0Mm1QDM8tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by BY5PR11MB4402.namprd11.prod.outlook.com (2603:10b6:a03:1c9::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Tue, 22 Mar
 2022 00:26:39 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::4df7:2fc6:c7cf:ffa0]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::4df7:2fc6:c7cf:ffa0%4]) with mapi id 15.20.5081.023; Tue, 22 Mar 2022
 00:26:38 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
 "Jason Gunthorpe" <jgg@nvidia.com>, Christoph Hellwig <hch@infradead.org>,
 "Raj, Ashok" <ashok.raj@intel.com>, Will Deacon <will@kernel.org>, Robin
 Murphy <robin.murphy@arm.com>, Jean-Philippe Brucker
 <jean-philippe@linaro.com>
Subject: RE: [PATCH RFC 01/11] iommu: Add pasid_bits field in struct dev_iommu
Thread-Topic: [PATCH RFC 01/11] iommu: Add pasid_bits field in struct dev_iommu
Thread-Index: AQHYPCW67tZrDf6F9E+D6qob0d5J2azJabXQgAA4/wCAAOvc8A==
Date: Tue, 22 Mar 2022 00:26:38 +0000
Message-ID: <BN9PR11MB5276981B9328F10E5FC89B728C179@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220320064030.2936936-1-baolu.lu@linux.intel.com>
 <20220320064030.2936936-2-baolu.lu@linux.intel.com>
 <BL1PR11MB527130BAAC3B4F48E4901F5D8C169@BL1PR11MB5271.namprd11.prod.outlook.com>
 <7de05f5e-864f-175e-5604-29561d330884@linux.intel.com>
In-Reply-To: <7de05f5e-864f-175e-5604-29561d330884@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a5980596-4a7f-4473-6116-08da0b9aa187
x-ms-traffictypediagnostic: BY5PR11MB4402:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <BY5PR11MB44021D47E72712F292605BA68C179@BY5PR11MB4402.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +e/NsXI3TF6vpUhDPc8icZQtpAzc8Ptdsm91AhnHgIH9wVFbpcA6x7j2vrvaUL3is7t2OHh241LhCucGZydpZY8GbDLGOVPjqySBeEuKm3JPX0XwRDtV11FsabbflEDE6okZGkt8GkPuuNwOTC8SWvA+Q3ofFFDljKkk4nqXkZI9YEPuqKB42dBObxg/G1d7KvMJUpkN54t9f9OyfCatvTUYV2vmD+2D5CsbI/VkO2kkikuRAdBQKxNy2g24GByyVckaaFcZdjoXjFyo/uJRti7osiALhGpgdwGW3gCbbr/7uWUGfXtc9MPftNIlb5/FnzmG2Vo2S47vWXKsTYfjMoyFUn/Sd993Lu/9vUgfwvXQR8Zh2ft3yF33S+fABKRWN9rLcv3z/gEy006H8XsETH3Ra34c7yxS0+oeYFaQ+oWTUe285lAISS1tZZoBsnW0YDR/7TEFUowIDk7kPvCDaFPCWiC1wy08uTyJmr8qxeSDAzhR6CXsO3De2i3XwY3ni1t7hJwcfhiLd5WXPakBrhJNqTzW8DugN8kjJsXrgMRq00twE7SqwZ8ZiXRtj6t5aNFATpCR2KATmabSGFR0MqqLeAqrrsZ7l/q3T8YTSmS2w4zCbNBK3SIkCmUu0MrMkQMDCq+5OwZk4dU1QkZI0TI9qhLVhIVNLmBkEpJ6AHAhPyk5zQn0QUHOfYHDosx8xdlmjrAqDP5Rt/uIEJx4OA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR11MB5276.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(366004)(38070700005)(8936002)(82960400001)(86362001)(2906002)(9686003)(5660300002)(6506007)(7696005)(122000001)(52536014)(4744005)(7416002)(38100700002)(54906003)(71200400001)(110136005)(33656002)(186003)(66446008)(66476007)(66556008)(66946007)(508600001)(64756008)(26005)(8676002)(4326008)(55016003)(76116006)(316002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ai9uU0R2WHV0MU9mREtaMDVaSXFNYWEvcEI1d1A0SWJGZG1zMTVqWnJZUnNp?=
 =?utf-8?B?RmswYzBXVDJpNVp4aEVyeDVXOUJNQ3grMUw0RFR6ZythZi9lWFVqSExFNGZC?=
 =?utf-8?B?T1l3dzdleitFNzV4MmhneWxtVE5IczR3RkFSdDNETGFqcmtSeWZLcDNUbS9M?=
 =?utf-8?B?UXYyVmVSNHM0VzUxOFdpaXZMY3B3OVFmeFV5TitVNGNMeU02d1FZQ2tWdCtS?=
 =?utf-8?B?RGZHZGhSODFxYjZibW9rR04xUUw2OFlZRjd6OG90SjVNR05DRVdib0EzSkQz?=
 =?utf-8?B?RGZ0RDNWckhHMERXTGdNeHhWaWNoa2hrNVZaWXNDL1U3Vm9rUjhXZTI5bnk5?=
 =?utf-8?B?YU9FUHZTWmJablQzSTlSazg2cjFvVE1wSTJRa1dhdkJqNlF2bkdWWXJYcUQ0?=
 =?utf-8?B?VXZLS2FkSStFWlg1NE1NRDZjT2VBRmt3NmY3SHd2VG5mK0RTbnU3bHlSdzlq?=
 =?utf-8?B?eTU1UTdUUVFMVW1EK3VVaU40ZVBYVTF6TlNYWi8vbzdteW5rd0VSRHVubmxu?=
 =?utf-8?B?ZG1pL3dpek8zQ1R2SHM0b3U0ZFFxTWNNMzNFWitabW9sWHBPYS9pQmhXYTdj?=
 =?utf-8?B?SG9JU2lqeG5Mb2JEZ0xZRURrWjdNMU1nQWRtdUxBZnpyUFFIL2FHZzZEN0Q3?=
 =?utf-8?B?cHlkSUdIb3JITUthWi9PUDVNNVprVmdtWERzQVdNTkZteENUZEIxMVNPWkJ2?=
 =?utf-8?B?SitpZXpMOHlvTlZjTVBobGEybGVLNVhwaFJNN3dRTEg0TkhrTytrdlFLamVO?=
 =?utf-8?B?L0dLWmhaMklHby81YUlwQWpmVHhvMjRRaVdDZHFOSnFmaTJaWG9qY25wbEFs?=
 =?utf-8?B?UndiLzZ5T0w4Qi95aWo3K1FVSWlVWXorRmhtcG1mYTV3ckdydjRIMkpCYjBx?=
 =?utf-8?B?V215Qmw1Q2lHdkpPWTE0MTBNQzkvdUp2YVJlNVlHRWVwWWIyN3d1dnp5YXJW?=
 =?utf-8?B?RXRFdzJMYTZTQzlZQWpvTDhRVkxkZjJMdVdJbDJBaGlRV2hQTGd5TXcvRnVp?=
 =?utf-8?B?MmpZZUJxYVVXdi8wYTA5VENYT0E4bG9kcGl1bkNxM0lRTE45WDhzanZCSUoy?=
 =?utf-8?B?ZWx1djBwL3F6L1lTciswTCsvdGtNU1JEZS9SakZwWlgxS2lZSTRHc1JpZnd4?=
 =?utf-8?B?Mit5azEwa1ZJRTBTdTk3UlRlWGhwSy9ta0p4SFVUd3g0OVVZMDJKSHlUeTBK?=
 =?utf-8?B?dXVvY0x2clZpUXR2UXl0SUVwL2l1bDlxbTZpaTdzK2N4bWJsaHc5NTEwZTY5?=
 =?utf-8?B?Y1Y0bXh3ZCszZmhTajJ4UStRcHdwRW92U21RdVlQZzZibmtKZWVsdUsvYita?=
 =?utf-8?B?MEUyK0pSdjVvYXViVUhkN1hkaW9sUjdrbTlqVzN4ejJDM1g2b3M3eXV5SmQ2?=
 =?utf-8?B?RlpYUnVlcGNjTUFnelpxWExTd3BRWko0V0xiMXIzRllrRlFwNXF3NjhHSW45?=
 =?utf-8?B?dHFDbWpGbnNneHd3YXA4TURVNTBLUFJSZW40dENtdHNHekFDaVBpWTdDRnZR?=
 =?utf-8?B?TVpCOGFMQ0dPNUY0Mk1KWVc0UTk1S0ZtMHNZQ1FJeTZYelN1cWhTeWF5TGl5?=
 =?utf-8?B?enpYSmxEck1MYWU1NUVic3JpK1Q3eS9IWUhQS3cvV2lzWkhZV25hY0lpQVE2?=
 =?utf-8?B?LzhQNFBVaG9YcUM5VW5XOG13RjJFcG55bEUxbU1oOTRseUZ5UEx1ZDlTNFov?=
 =?utf-8?B?bEVSK1d3dGNwZ09ubzRTZXNISE1wRmQvalk4RkxBTzhHZXZqbVBZVHR3RXJG?=
 =?utf-8?B?YVA1NXhyU0RPQ1hJZnRPRm9mbmUxMHVBa3J5NGFqNE9hU25VWTJhYVpuZ1dy?=
 =?utf-8?B?ekx3TWowNnpFQitRMmZUbVh5ZWgvLzF1K0tQaGRIR3gxQlVWZ2ttYTZmK1NM?=
 =?utf-8?B?cnhsRnZaT21SRlpjVjYxQlA2QXRYS21BWXlDV3lQbnVodHluWnhpczFGV1pB?=
 =?utf-8?Q?VsjyROQI4G/flRBb7u94Fx6of/CV4JO2?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5980596-4a7f-4473-6116-08da0b9aa187
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2022 00:26:38.8438 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vEcoN9TIGPNrV3DfGrxfKmv+PNxwZHs266rjPV1/hNGax9mJP1+vPMpc1Vljug57TP7sMnbS314AgZPbb8kqlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4402
X-OriginatorOrg: intel.com
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Pan,
 Jacob jun" <jacob.jun.pan@intel.com>,
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

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Monday, March 21, 2022 6:22 PM
> >> -				if (features >= 0)
> >> +				if (features >= 0) {
> >>   					info->pasid_supported = features | 1;
> >> +					dev->iommu->pasid_bits =
> >> +						fls(pci_max_pasids(pdev)) - 1;
> > Original intel_svm_alloc_pasid() covers both PCI and non-PCI devices:
> >
> > 	ioasid_t max_pasid = dev_is_pci(dev) ?
> > 		pci_max_pasids(to_pci_dev(dev)) : intel_pasid_max_id;
> >
> > though I'm not sure whether non-PCI SVA has been supported indeed, this
> > patch implies a functional change here.
> >
> 
> The info->pasid_supported is only set for PCI devices. So the status is
> that non-PCI SVA hasn't been supported. No functional change here from
> this point of view.
> 

Then this information should be included in the commit msg.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
