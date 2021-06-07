Return-Path: <SRS0=ynGH=LB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82B20C47082
	for <iommu@archiver.kernel.org>; Mon,  7 Jun 2021 03:51:09 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 345CE61209
	for <iommu@archiver.kernel.org>; Mon,  7 Jun 2021 03:51:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 345CE61209
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F361B8364F;
	Mon,  7 Jun 2021 03:51:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2rkJ22CUehDj; Mon,  7 Jun 2021 03:51:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id E4A3083005;
	Mon,  7 Jun 2021 03:51:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 98AE4C000D;
	Mon,  7 Jun 2021 03:51:04 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C4FAFC0001
 for <iommu@lists.linux-foundation.org>; Mon,  7 Jun 2021 03:51:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9D7426075B
 for <iommu@lists.linux-foundation.org>; Mon,  7 Jun 2021 03:51:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8Ftu0Mpo1-nS for <iommu@lists.linux-foundation.org>;
 Mon,  7 Jun 2021 03:51:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 84155605D2
 for <iommu@lists.linux-foundation.org>; Mon,  7 Jun 2021 03:51:00 +0000 (UTC)
IronPort-SDR: 2RxK3R4NcKCoMEcOSV03mwJsChRY4xubQYAz5NQ6Dxe9ylwJCkuMpY8sxy7O8CxqLNFZelnnFe
 kODld6TRwdCg==
X-IronPort-AV: E=McAfee;i="6200,9189,10007"; a="204576911"
X-IronPort-AV: E=Sophos;i="5.83,254,1616482800"; d="scan'208";a="204576911"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jun 2021 20:50:59 -0700
IronPort-SDR: vihYOprQ0xPonVf/MqttbddJoucKykUrf+9zqaL7+K8B0tZG1HRFNN1KaxYfy7ggFdi/JgY+1g
 AEYA7bHWNT+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,254,1616482800"; d="scan'208";a="468949988"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
 by fmsmga004.fm.intel.com with ESMTP; 06 Jun 2021 20:50:58 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Sun, 6 Jun 2021 20:50:57 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Sun, 6 Jun 2021 20:50:57 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4
 via Frontend Transport; Sun, 6 Jun 2021 20:50:57 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.174)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.4; Sun, 6 Jun 2021 20:50:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FhSWIDznk61QT9FbU4HHVLOow/mB+PL53/SsxTJSYRWQTR5cEJfPwNvX0eiyDBN0G/LHWnFrVhFtlwpn4WgGUEcDZWZHRTRdOE+3o0KOmAACIIKmw2J2n5NdwjM4Wnrja5QxIHyONuorlaaDLU3ixwWNbl/hBigAOV144ISVfLvmBPSRk3+T/haq+dq+be0WzAH3TXA/Km7jM0txmMvF04fI//gujQGQE0lpI8o+qDoSAV4uVND1u0huIRccItRfcVkvzKyOmiE2GdMvm71HPeW2YeEfvebLkJPaJWnhKxDUCFUHDU1xCnsNxMAE7oKyNsWOHzBx3sTrEvTPIb5Ffg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sWs6WICC/G6I9jJx7wmbUk4UcsQolsp3jHtYBFeeHYQ=;
 b=CxyJROGy6/bIfyu/p9/eEtj7GufW44rY1kPwWSTEWBOoCthDYAl9DoSCvVZ/tPa20jUgeqSP//vhvpP9x5Ep16YzVneF+SwB6LxOCCUkNTgsK9Z+nd0uWmpDkwgUnmI5XapvZ5Q5fEcJM2udO9vdj5j8KTMVQTcV8lflb4Ot/4bZ1WWldynCIVFizLnsxLanGF0EvShbWf3UyWeexPCIJptnFlJAAO3B4wipXsgOdnL/C25LFr9MC7pdxnZ+B+djaqRQFrhJJYjJ7n+XXkCwP8Vyneo2s4uw6/cC+jBTHDK9iCX8L+xWq4gtjvnZEYnYfaJ/h+qiaI1vAjwa7r0Kfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sWs6WICC/G6I9jJx7wmbUk4UcsQolsp3jHtYBFeeHYQ=;
 b=I2ePOrI9RAxR1O/x/kmQRMTC4gohkK45IpzejKHfZrbdYYCgtoT4SoQj1ZTzpNctxVPhboFDJP5sOsR7nAsgFEvqS9hK81EoIMp4oi4vmL8I5/q65ZnO6+cF6kBBqerVPmdpk/TzuT5ZqDCxup+Vby8odUfwaIfuFGoOqPtKsAU=
Received: from MWHPR11MB1886.namprd11.prod.outlook.com (2603:10b6:300:110::9)
 by CO1PR11MB5140.namprd11.prod.outlook.com (2603:10b6:303:95::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.23; Mon, 7 Jun
 2021 03:50:54 +0000
Received: from MWHPR11MB1886.namprd11.prod.outlook.com
 ([fe80::6597:eb05:c507:c6c1]) by MWHPR11MB1886.namprd11.prod.outlook.com
 ([fe80::6597:eb05:c507:c6c1%12]) with mapi id 15.20.4195.030; Mon, 7 Jun 2021
 03:50:54 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>
Subject: RE: [RFC] /dev/ioasid uAPI proposal
Thread-Topic: [RFC] /dev/ioasid uAPI proposal
Thread-Index: AddSzQ970oLnVHLeQca/ysPD8zMJZwBL2ymAAKTbxpAAKSt7gAAHpf9wAB1YcAAAAm5sgAAA1YgAAADonIAAAEmcgAABzCaAAAHbfwAAAYTsAAAEeLUAAAiRJwAAFF14gAAPozMAAABMSwAAA0bJgAAVeTBAAAlp0QAABjX0AAAAf0IAAABWuQAAAD8IgAAAOC4AAABA0oAAAn0sgAAbQLqAAF5vapA=
Date: Mon, 7 Jun 2021 03:50:54 +0000
Message-ID: <MWHPR11MB1886503741ED16CDFB2CDE258C389@MWHPR11MB1886.namprd11.prod.outlook.com>
References: <20210603201018.GF1002214@nvidia.com>
 <20210603154407.6fe33880.alex.williamson@redhat.com>
 <MWHPR11MB1886469C0136C6523AB158B68C3B9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210604122830.GK1002214@nvidia.com>
 <20210604092620.16aaf5db.alex.williamson@redhat.com>
 <815fd392-0870-f410-cbac-859070df1b83@redhat.com>
 <20210604155016.GR1002214@nvidia.com>
 <30e5c597-b31c-56de-c75e-950c91947d8f@redhat.com>
 <20210604160336.GA414156@nvidia.com>
 <2c62b5c7-582a-c710-0436-4ac5e8fd8b39@redhat.com>
 <20210604172207.GT1002214@nvidia.com>
 <2d1ad075-bec6-bfb9-ce71-ed873795e973@redhat.com>
In-Reply-To: <2d1ad075-bec6-bfb9-ce71-ed873795e973@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [101.80.65.46]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bf0c5a33-a244-470a-7880-08d929677383
x-ms-traffictypediagnostic: CO1PR11MB5140:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO1PR11MB51404E6EC3D87281B2B124E68C389@CO1PR11MB5140.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eBUJHM+fy/+dDIdfOlUEjDsouY7TVE9b1H+wlD+GmsPwUBMI1nYq6gpoKYvSgYt9wGyjj5DpdsG+s0P1oute01I5zM3yg2gBRrVrlj/RU5xHJliq2LrM7Ix601wPhGgNBFy0GZv7gGnbvPQNdW16JWlP2Lv0Dz6BHTi8A/Q0yzzeoB5RhXWcqR/UE3Sfa7IVw2H548qrJPAXgNdB19Dl5k/F27BLXauUnDFcwxOlUDzmmnG2v5/N4Sv4OyGhHbzGou2EDVwL3tugAAEI5UmCC4MiN5/6AsBA5rJHC6PkLGKD9ViX34I+g7hmPn16+yM93jWyIkg8Q9n3uUhk90ppdIRfANGjZDFOfDzxOc1i3pD9ciNwWK6nTF7mhBhdSERAp1pE0fZ5kJX5uslFnGNxqVPkaYrdKxgMrgdPEo9nHxmDJyqGegmFafrL3wV66t0tgKQh0YQTc/BsJEsm9dDl/VHN9D/xnq54Jp0G3ZRo+ENUWC/6nYqa1iDYtKb04eVAHjeGJd4P7XSEoG5WcV81HfrLCDMXQmdH8seRyGDFcHfn39Oy4ay/h8CHNdtpKUW79SVFzPoSGwEUFTlLaOCKI/U7SoU4GEeNxgIz54Z6tF8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR11MB1886.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(396003)(376002)(366004)(39860400002)(346002)(136003)(7696005)(316002)(64756008)(66476007)(7416002)(26005)(186003)(66556008)(66446008)(86362001)(4326008)(52536014)(5660300002)(71200400001)(66946007)(110136005)(54906003)(6506007)(33656002)(53546011)(76116006)(478600001)(55016002)(9686003)(83380400001)(8936002)(8676002)(122000001)(2906002)(38100700002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?bzhvRElSVHg3cHUxMEZjNlJ2dnh2NjNJOG1PWkwrOTZkV21Ld2hxYzd6Sm5H?=
 =?utf-8?B?WWpTcFQ4QUVEOXVzS21MUngzK3d1eWRpUVV4bzBLRUN6ZjBNWDBMOExsemZ4?=
 =?utf-8?B?OFVTS1pGbUIvQWcrTC9ES1ZLV1NOWGVmRmM2N1dKblhTQzNDRVhET1NtSHRq?=
 =?utf-8?B?ZHQvTS82Z1BiaFFXb0NXNEF5RlNGSS9Ub2czNGVLT243WnpPWjdHQkNRYWk0?=
 =?utf-8?B?ZUVLbldudkUwRFNGTGM4UmllRVd0ajgrNFpXQkJEV0d3TTZSSVRrY1BSTk4y?=
 =?utf-8?B?NW5vaXVFWHpOdkkvU0V5bFlDM2dUVDJ3dGNQU2d0bTdjT2hMNlZTN0xSWnJp?=
 =?utf-8?B?dU1Ma3JObUZnTkhmSEpMa0tKS1YyM0pZWkJmR3lDS2J0VEppMW1qSXYvU0JU?=
 =?utf-8?B?MEl0RXk1TVQzY2oweVI4UWlzS2dhYW1lZVIyUXhNOUZmN1J2Q2QxQjd3TVBP?=
 =?utf-8?B?aDVlazZFSmlzSDZyY0ljUWxLeXVUMThrbXUyZ0gyOTVqcVZxU1UxV3VqQUd5?=
 =?utf-8?B?WGhVMVhTVzhIV3pLWlkwNVJqd01teEtQZ2ZveHJWRTcvOGQ2QWJTVkVCK1hH?=
 =?utf-8?B?Qk1BV1RsdEtlVTlVdG1rZ2V0cnJwYXQybVBDTWJMQ1JFbWczSVRLVVhvVFh5?=
 =?utf-8?B?cUM1ZHU5dHE1TWd1TmFOWnZhRVlOaEhkOFZXcFBEQjhqUS9NcTlPa2ZQUnJO?=
 =?utf-8?B?bTh1MS84ZEVYbk1NWCtoMzliNXB4b09YU0crQ0YvVWZQZG54bXZCNG81aFdN?=
 =?utf-8?B?UFJZSnBNTUdRTkYzR0wxNDhmOG1KMEh1VWpHRWdVZERPQ1lWbUxLOUoxZWJ4?=
 =?utf-8?B?S2lDNm50d0JaZG9OcXhrTkVLWjVGMCtvajcxa0N0T0hiMjRxQWZHUS83Z0ly?=
 =?utf-8?B?a2xqM2xCMFFXdzlRME5tY3podzQ4aG14YkxhTGttZW9LSXd3Tjg5RCtPemFs?=
 =?utf-8?B?VWc2dEJBN2JRRFpvTmJSWllFRStsUHk2aGxKTFlnL3h5bFU5MDlpQVF6MlVj?=
 =?utf-8?B?SDdpcmp6dGtmWXRiMTdQVWI1UWVTclloM2pZT0VVZ1BEUjRQN0tUTU9kaGQ4?=
 =?utf-8?B?dmpPYkZhRkpmVXBpaW9xc3FhWXZrL0hFVmllQVRoL3V5b2VPMnJ6WUxid3gx?=
 =?utf-8?B?VU1CVnBPRDVuUnlqalVacW1nblQzbDRHTm9QQkV5aGVhRjNPenQ5NmQrRG1Z?=
 =?utf-8?B?SWR5d0MxdlYrSXMweFcvYlJaTEdXY21rdk9UZXh1UnhkTTFyWlRZODduS1RD?=
 =?utf-8?B?Q0EvRVZKcERKWUxteDduTHlLSDBFSzErbVlOV2VDM1JKblQxZ0h0Q1RLWmRZ?=
 =?utf-8?B?NW5ZUEQwdG93MkZBTUpPb1pPcENORVV4bUEzbFphYlNma2RoWkZqUmJkbUFS?=
 =?utf-8?B?MG9yVTNXNWdjQ1RQUFY0NEs2bUE1QlluRGN4Z2ZWMmVpRWxYcGVDSG5PcHB6?=
 =?utf-8?B?S2hRaHB6alVVK0s5Q3NMcW1kUmxlaFNSU1ZGUm02R3FJSVJhTVliYlBmUzcy?=
 =?utf-8?B?NjBHR2w3djV5eHZnZnZFRVhrVllaQnN0ZUUwVVRBNW5rYmtzY1dtbStBa2o1?=
 =?utf-8?B?SldpM3ZLU280NnR6SWIwcEFDOWZ6akJSMDJmSXp5dUpCR1p0QUJVVFQ3WG1L?=
 =?utf-8?B?RVg4bFJLU3Nwb1F0YVBQNjZqZ3RMSjhKUWp5YWZLQnBJSG9XZzdXOUtBOUpW?=
 =?utf-8?B?YU90WU9lSU5RS2NlbjdVdGE4L1hLWTZDWkp3VXlSdEFlZHhDR1BrNVdIdVJB?=
 =?utf-8?Q?WjAS0Mq51mxa6jOpUM=3D?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1886.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf0c5a33-a244-470a-7880-08d929677383
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2021 03:50:54.2473 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7Q7aT4vfo892hUtOJjtToD37HR+NMBxUhYc4pP9TkcwnEeZ6OqeDuNPjhe0NYm8AvYDS6aL7DqIBjZgf+qttPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5140
X-OriginatorOrg: intel.com
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, "Jiang,
 Dave" <dave.jiang@intel.com>, "Raj, 
 Ashok" <ashok.raj@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, David
 Woodhouse <dwmw2@infradead.org>, Jason Wang <jasowang@redhat.com>,
 LKML <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Kirti Wankhede <kwankhede@nvidia.com>, Robin Murphy <robin.murphy@arm.com>,
 David Gibson <david@gibson.dropbear.id.au>
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

> From: Paolo Bonzini <pbonzini@redhat.com>
> Sent: Saturday, June 5, 2021 2:22 PM
> 
> On 04/06/21 19:22, Jason Gunthorpe wrote:
> >   4) The KVM interface is the very simple enable/disable WBINVD.
> >      Possessing a FD that can do IOMMU_EXECUTE_WBINVD is required
> >      to enable WBINVD at KVM.
> 
> The KVM interface is the same kvm-vfio device that exists already.  The
> userspace API does not need to change at all: adding one VFIO file
> descriptor with WBINVD enabled to the kvm-vfio device lets the VM use
> WBINVD functionality (see kvm_vfio_update_coherency).
> 
> Alternatively you can add a KVM_DEV_IOASID_{ADD,DEL} pair of ioctls.
> But it seems useless complication compared to just using what we have
> now, at least while VMs only use IOASIDs via VFIO.
> 

A new IOASID variation may make more sense in case non-vfio subsystems
want to handle similar coherency problem. Per other discussions looks 
it's still an open whether vDPA wants it or not. and there could be other
passthrough frameworks in the future. Having them all use vfio-naming
sounds not very clean. Anyway the coherency attribute must be configured
on IOASID in the end, then it looks reasonable for KVM to learn the info
from an unified place.

Just FYI we are also planning new IOASID-specific ioctl in KVM for other
usages. Future Intel platforms support a new ENQCMD instruction for
scalable work submission to the device. This instruction includes a 64-
bytes payload plus a PASID retrieved from a CPU MSR register (covered
by xsave). When supporting this instruction in the guest, the value in
the MSR is a guest PASID which must be translated to a host PASID. 
A new VMCS structure (PASID translation table) is introduced for this
purpose. In this /dev/ioasid proposal, we propose VFIO_{UN}MAP_
IOASID for user to update the VMCS structure properly. The user is
expected to provide {ioasid_fd, ioasid, vPASID} to KVM which then
calls ioasid helper function to figure out the corresponding hPASID
to update the specified entry.

Thanks
Kevin
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
