Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA6B3C433F5
	for <iommu@archiver.kernel.org>; Sun, 24 Apr 2022 05:55:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 62CBE60D59;
	Sun, 24 Apr 2022 05:55:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id y6KXetPfPvk8; Sun, 24 Apr 2022 05:55:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 23752605AB;
	Sun, 24 Apr 2022 05:55:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D4A6BC0039;
	Sun, 24 Apr 2022 05:55:36 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3EB58C002D
 for <iommu@lists.linux-foundation.org>; Sun, 24 Apr 2022 05:55:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 24681408BD
 for <iommu@lists.linux-foundation.org>; Sun, 24 Apr 2022 05:55:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uumVFF7k8DWZ for <iommu@lists.linux-foundation.org>;
 Sun, 24 Apr 2022 05:55:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 361FA408A5
 for <iommu@lists.linux-foundation.org>; Sun, 24 Apr 2022 05:55:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1650779734; x=1682315734;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=ty86MNbN1cTVgpBMtgfw1qRiaW/r+Ls3dQPDP+gBLtk=;
 b=Q0kBjk4T5l18o5RXT+mEy7gCdtHSNZT0YmI5uZYxQc9JmJTo0cyHSCBf
 9v3k8coOL7FHOWYlTrrNMaaPlT6KzP4Ru/pm/KTpsXZuse4HsbUM+qNKW
 h1wFMIXTnxkGm2/Cc1E0VroUdKenz7hDI8c/P4BOsZbuo0H+ysN4F+rdW
 krjDq52y9pnjVlwCkYYfjL6OR7s3kNH7xhzujEs+Tbf9y7MmROmP9r+7X
 JjaG0hHPaEV+sPMs79v68P5rGr8ShkEo7xmT8l4ihFm3lVaiEk9DKSj1Y
 ycUaVWd3MCdcrsYR1uypRnWnKIaOaG8Y5rvlYnJDr3AeCDoFlYAN5IuBq g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10326"; a="325467747"
X-IronPort-AV: E=Sophos;i="5.90,285,1643702400"; d="scan'208";a="325467747"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Apr 2022 22:55:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,285,1643702400"; d="scan'208";a="659666552"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by fmsmga002.fm.intel.com with ESMTP; 23 Apr 2022 22:55:32 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Sat, 23 Apr 2022 22:55:32 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Sat, 23 Apr 2022 22:55:31 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Sat, 23 Apr 2022 22:55:31 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.49) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Sat, 23 Apr 2022 22:55:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VL5VS08GNxJep073WUL6rNGFeLZoi72PUtf0mkGvFx/GeHoWIyANlJBiCdH4jtFiSHJvEPnuN91tlq4b6wYaQdnNNaYSbML/bJCMiRjCB4xkV7ukFP9ZGlJ9rST1BRKuYFRv3s+08RSl+Gad7r2VjgccGJlv9DGy6c+sFGuwiIMdh0/AoMy+G8IlxZ9t7snWCTgRRanQZwQYIagmx7WIuj5OGDUnWf2U2eg19ElFlydPlXeSP6HUawVnvQwYAWIykc3dzTrPr8xtdcWKMUU1BrKQm8rZw+28ClOLA50YRoCioJKPglaj3+5b87Z8YBkfz/Xiyo62o3C9xz6uoWKFoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ty86MNbN1cTVgpBMtgfw1qRiaW/r+Ls3dQPDP+gBLtk=;
 b=nMKFHp3Cc4W+Wdd9AbnT2kkRR4E1l6LdNsF3plq6x5/QTVNmIOSYL9Hy7CNlx2UlX0+vBMeC/JmSngLkP78OvC7oxcBJTFEBaZeAFXo8lw4iucGYZZJdHJNBtAlvPqzkj6MS9EZ9AJAcTXIQaG0HV3i4vUCXvlELfCp6VhJQ4yDziMqxgx4Ioz03eRMMXFbZ181PxbzXAnMaagtZPTmg2PNUQ57841YJ0w1VRnxOId1tfYgrVBfLinbqkuANM5k798M5CwLFSAgEqImdvKa6ixofujQiZ/Z6kK9xC4Jh6pLsm8kGMAVT1oF/lMNWaGRETwCvnXNnKi2jcTCLtTsBAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by BN7PR11MB2689.namprd11.prod.outlook.com (2603:10b6:406:b2::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Sun, 24 Apr
 2022 05:55:29 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::24dd:37c2:3778:1adb]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::24dd:37c2:3778:1adb%2]) with mapi id 15.20.5186.020; Sun, 24 Apr 2022
 05:55:29 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, "Pan, Jacob jun"
 <jacob.jun.pan@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>, "Liu, Yi L"
 <yi.l.liu@intel.com>
Subject: RE: [PATCH v2 1/4] iommu/vt-d: Check before setting PGSNP bit in
 pasid table entry
Thread-Topic: [PATCH v2 1/4] iommu/vt-d: Check before setting PGSNP bit in
 pasid table entry
Thread-Index: AQHYVXRiJweT3/DMakGQhv0qzMieEqz7Od6wgACuJICAAoO6kIAAE28AgAAVTRA=
Date: Sun, 24 Apr 2022 05:55:29 +0000
Message-ID: <BN9PR11MB5276FA1633851ED6CBD955E38CF99@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220421113558.3504874-1-baolu.lu@linux.intel.com>
 <20220421113558.3504874-2-baolu.lu@linux.intel.com>
 <BN9PR11MB52767A16DC6BB80838C876068CF79@BN9PR11MB5276.namprd11.prod.outlook.com>
 <503795b0-282c-2a8a-b669-5e7a0fc4a696@linux.intel.com>
 <BN9PR11MB52766E90CF544C2B00F364008CF99@BN9PR11MB5276.namprd11.prod.outlook.com>
 <4b2cd2a7-d715-882c-9cce-533dcff8bc79@linux.intel.com>
In-Reply-To: <4b2cd2a7-d715-882c-9cce-533dcff8bc79@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d6c9ba23-9a8e-4866-184f-08da25b7096e
x-ms-traffictypediagnostic: BN7PR11MB2689:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <BN7PR11MB26898A3FB4B212370B11E6988CF99@BN7PR11MB2689.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HBsENvAgbdSbLmrBIWPYihcUt62hHY6Wft8P+Qw6DXvDXKCtFy+NpPCEg1rQEQTBgZizkPa0OhGaePZlfIr3Fj3EWQMIAvg5tgD+F+cYefCnCN3HgCBzzaDsPnjrZ4puWQ1hUAxphqJP+B8PQ9fTVShwxpIp2tmDdi+vdnll9JY4KAlrGIZjIV4aOsVXekjlmN5jeQAZTMa0gAxa0C/i13COCjCxh6hqWZGWjqIu5gsHh6h4hN99qhkPp9dC94dQ9X4yl+RqMXCG8gnT4lslXndmdyVnCtNU45o6UsMUhAwlIGDhPqV6FkuzOlW9WqMYJD5luxzJNjevH67RIhYYEhbAkMqcdHANTemKtNtM71vRLnaAMp5W+ygOiv6iOMJ9rs+n1Av/1tGsFSVfxtLBVkd8sdZbUG4Ol5EmqC5yxBsw2ESBrdkYJUkEZmCIZLZRPiyznpyi+KnkBPMFQXpVhm8VOSG02p38PVrEB5QWJGkv4l2LXhxrLCHZTkQsM0ouFubYujl4/nJ2aobptDx78bVj01Ky1gfFSVsngHX1DHBmqGCFk0N7KxT276kt7cDDCkkc8bbxFLlz7VzbVHbI8kqvUTcoSMykNGTxTusR5ZIgqRkv+wX75+0gP0eYZlbanpTvAmsKP/FByNvuMpW40PUD1oR1wBVI09QHJjeKgLzjvOBNwBKNjzsr8ICzU7ZjOpg6aYCms3vBJTGj2rTe+g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR11MB5276.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(366004)(53546011)(9686003)(26005)(55016003)(6506007)(110136005)(7696005)(508600001)(122000001)(82960400001)(38070700005)(38100700002)(83380400001)(54906003)(71200400001)(186003)(86362001)(6636002)(2906002)(8936002)(5660300002)(52536014)(66446008)(64756008)(66476007)(8676002)(4326008)(33656002)(76116006)(66556008)(66946007)(316002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Mi9MelhUVEw0MkxjaEQrcmVVUlFPN21jRWZiS1NIM2dBYWpwSEZmNlgvL3V4?=
 =?utf-8?B?Zm4vT29DNkg0MFEvR2xiVTVGZHlBVHBtL2QycTROdXVQSTdMbTBRb1YrRjNV?=
 =?utf-8?B?bklUTTZzd3Zyc0Q5cER5VGhCTFhSTkp2MVI5bHVkZU5JREQzRjUxTU9aQjlo?=
 =?utf-8?B?NGpQUjhLcjVUeVBzQXlkdlFUeW51dFlSb056N3pVQXlUeVMrUDRhU1UwOVZF?=
 =?utf-8?B?WHMzbmN3cmQvMFFmdXBFazRmUzBzeDZQcVZGcmpSK0NGRXJPTWVrazIzTGNK?=
 =?utf-8?B?MER4M25qK2JPSFhCOWVwZThPWXkxTzVmczdsS2dCR1NCWnBrTEg2UmF5OEl1?=
 =?utf-8?B?L0tNWE5yV1FGWHdBdTYvVjdkR3o4QzF2NXBNbDJqYTZoUXpadiswcHZpQW9C?=
 =?utf-8?B?VURXUlN5YU01YlJsaWM1bDhCNytNZGJHY2NhTklSNHlRUk1KRkhVR1JIMHQx?=
 =?utf-8?B?TGZmRUdTZFJ5d041cyswZnNMcTJEQVRkUzBYeWR5TjZseUpZT0srKzdTNWZG?=
 =?utf-8?B?TWZYSTE1Mjg0TUV3cDRaMThDU0Rpak5rc0xORVp1VmExK2RLWmJMeGlJUFNX?=
 =?utf-8?B?UjN6b1VWR3pOd0RIaER2OFp2Y2I2YTMxeHRhcGZYTlhvVkhlWm8zOFp1aDRh?=
 =?utf-8?B?dys5eGJ2Vm1yUHpXQW5XK2lHOVBRMVlXNm52ZDZKMjhhMkdsV0lVVnNYOEJy?=
 =?utf-8?B?MUhQY2JTYmhVWitPUCtCeUNzTDdWbVloTVZ5bG1jN0ZMbUxxU3M1WXJEaTdK?=
 =?utf-8?B?Qy9jRnpLREdQVnZWTXR3U1psRVRqSW1FZjM1YzRBVDBJT3pqZ0FWenFVZGVH?=
 =?utf-8?B?VHZ1NTRFaWF2TGJIZERRdk50bk9XMHRPcmhOeXgyZkluRHNNQVVESG5RVGsr?=
 =?utf-8?B?Q1NHbjhFS0xDUUF0WXlOWEMyN0U4SWhYWWJEN3lkNjEva3hXUWJXbGpJWXpi?=
 =?utf-8?B?UHJjQnZZV1E2cVQ0bVhha09kZDBNYXk2Vi9ITlYwQm83c3p4dVV2NWJUUm5U?=
 =?utf-8?B?S0JzZkhlV3J1b2s2eFQ4RFJ5N0FLUjF0cUp5OFVKMldVV01pN0x0QVZ0dWxt?=
 =?utf-8?B?a1F2c2hZTTZNdnR2Q2pzaFE2RjdKTDUyUUJWZEROTUFjVmQzcFlhbEE3SWJl?=
 =?utf-8?B?RTZpM3NmVzNIclh2d1VsSzdMZ01lU0VLblhwZm1NQ0lQalVTL0RhUDAwZEFj?=
 =?utf-8?B?dXJFTkZ3a1pkN1c5L1d4d2NCU01Wa1BGYmUvT0RkalgxQlE2SUVBTDRwWkZi?=
 =?utf-8?B?OEdESzV1NTlGajJYWDkxNWJ6a2hibThGNDlxZ2lTVWc1eGFaemV6eDY1dEE2?=
 =?utf-8?B?S29hYlh0LzlNU2k1bCtSYTlWbEJpeGxXU3Zpakdqd2MyaDdxaDgrdEp0MHpp?=
 =?utf-8?B?a1V4b2tFQlY0U05tREd3TGk3M2x5SGFMUm82Wkk5YkVaczZWQ0lvUk5VRE9B?=
 =?utf-8?B?WXd3ZnI3VUFZd0k4Z1pnMmkvcytEckY3T1VZdDN0d010Q2cvNVA4VXFrQ3Rp?=
 =?utf-8?B?ZERtSDZPK1dPamtpVjFEZThGSTh4ZC9CVnoyRUkwUzRZWnpnUEdQYnJwR2l1?=
 =?utf-8?B?SlI5UmFWcjhCN01TYUdLTVk3TzRwdXY3YjlteTNDbGNGRG5UWEEyQm1hWi9o?=
 =?utf-8?B?OHJzRCs1YUZxVzFaLy9HL093eDk2c2l0R1ArV0ttR0RlK0pEZmUyaXBJZlFI?=
 =?utf-8?B?SzJwZFNaSDdmMGxnY3pWbFF2bmtCMjVLU2FWWFJqNVNYMkY4SW1lZ3RJa25K?=
 =?utf-8?B?OGM3N2Q3NDR0aEgyL09rQXM0VzFSWmFpWWlyN3hzU3IrU2I2UGhnMmlmV3JF?=
 =?utf-8?B?cE1BUURBRWFnTmFTRDA4RlhJKzRFTWJFcTUvcmNybUVGLzdrSXNRcis0WjZv?=
 =?utf-8?B?Z2ZvdVpObW1wSHRXNmZPcDg4L0RscURYUGhGejJldzUzM2pHOWZpaU5EOW5R?=
 =?utf-8?B?eTVoR2hybGNEa2FwcTNRRGx4RzRtc3YrVUNOQUxHckYrUkZBNXNMbG1YcTcr?=
 =?utf-8?B?M1lweFc5a1kwZjVlcjhNVEd4TnMzYkxaYlgrNGJRUmxXcllyRkhVOEgrZlFh?=
 =?utf-8?B?aUxaVHJZNGF3Q0M2SS83Q2RoV2p1clVjOHZEeXVLK3FmMWFPcCtrMU9CenNi?=
 =?utf-8?B?d3h5TkVQelNXVXl3TGkweWpTcjBJWnVZcFR2OGZ5L1VMWldXKzNHZzZub2Fy?=
 =?utf-8?B?QzRRNGgvNElabXZDMGNOSlNsV3g3endFWDFaVFBicVg2YUFjUjVvRjhQOS9Z?=
 =?utf-8?B?clpOMVBkelZBS1MrRkhkQnZoYjBnUC8wY2JURGFISjJjdjJBait5ZEdVT1ZO?=
 =?utf-8?B?NDZJUUc3TVB2SkJ4SWlzVDd6MmFVRXlXdS9rWitidU1SeGZiSzZCUT09?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6c9ba23-9a8e-4866-184f-08da25b7096e
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2022 05:55:29.3174 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0i4rhC5bOSR4Pvg8t9jxTn/0ZYbAxx7eLJIECyRFSEwtvyXJo6nz21BVr1kItmu57ODO4dL4Uq7fq1f/nfbLtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR11MB2689
X-OriginatorOrg: intel.com
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
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
> Sent: Sunday, April 24, 2022 12:38 PM
> 
> On 2022/4/24 11:37, Tian, Kevin wrote:
> >>> This should be rebased on top of Jason's enforce coherency series
> >>> instead of blindly setting it. No matter whether it's legacy mode
> >>> where we set SNP in PTE or scalable mode where we set PGSNP
> >>> in PASID entry for entire page table, the trigger point should be
> >>> same i.e. when someone calls enforce_cache_coherency().
> >> With Jason's enforce coherency series merged, we even don't need to set
> >> PGSNP bit of a pasid entry for second level translation. 2nd level
> >> always supports SNP in PTEs, so set PGSNP in pasid table entry is
> >> unnecessary.
> >>
> > Yes, this sounds correct for 2nd-level.
> >
> > but setting PGSNP of 1st level translation is also relevant to that
> > change when talking about enforcing coherency in the guest. In
> > this case PASID_FLAG_PAGE_SNOOP should be set also after
> > enforce_cache_coherency() is called.
> 
> Yes. Agreed.
> 
> > Currently it's always set for unmanaged domain in
> > domain_setup_first_level():
> >
> > 	if (domain->domain.type == IOMMU_DOMAIN_UNMANAGED)
> > 		flags |= PASID_FLAG_PAGE_SNOOP;
> >
> > Suppose we need a separate interface to update PGSNP after pasid
> > entry is set up.
> 
> Currently enforcing coherency is only used in VFIO. In the VFIO use
> case, it's safe to always set PGSNP when an UNMANAGED domain is attached
> on the first level pasid translation. We could add support of updating
> PGSNP after pasid entry setup once there's a real need.
> 

The real need is here. The iommu driver should not assume the
policy of VFIO, which is already communicated via the new
enforce_cache_coherency() interface. The same policy should
apply no matter whether 1st or 2nd level is in-use.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
