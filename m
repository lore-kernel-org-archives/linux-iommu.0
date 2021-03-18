Return-Path: <SRS0=56b4=IQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B16EFC433DB
	for <iommu@archiver.kernel.org>; Thu, 18 Mar 2021 08:27:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B9AD64F33
	for <iommu@archiver.kernel.org>; Thu, 18 Mar 2021 08:27:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B9AD64F33
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E36B24ED4E;
	Thu, 18 Mar 2021 08:27:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 63orcInpnQOi; Thu, 18 Mar 2021 08:27:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 95C844ED2A;
	Thu, 18 Mar 2021 08:27:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7185AC000B;
	Thu, 18 Mar 2021 08:27:17 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6FEE2C0001
 for <iommu@lists.linux-foundation.org>; Thu, 18 Mar 2021 08:27:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 55DD44ED4E
 for <iommu@lists.linux-foundation.org>; Thu, 18 Mar 2021 08:27:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id M1GL7w5ucdmk for <iommu@lists.linux-foundation.org>;
 Thu, 18 Mar 2021 08:27:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 607A34ED2A
 for <iommu@lists.linux-foundation.org>; Thu, 18 Mar 2021 08:27:15 +0000 (UTC)
IronPort-SDR: BQ4hThjVCuEnXKeUHvG+MmFFflL8yGw/Q7bmToAeLx2X+/IHPklZubT2TWSaIOtW4B5UY3jVqe
 wn4SEsxiPUyw==
X-IronPort-AV: E=McAfee;i="6000,8403,9926"; a="209626243"
X-IronPort-AV: E=Sophos;i="5.81,257,1610438400"; d="scan'208";a="209626243"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2021 01:27:14 -0700
IronPort-SDR: vstgSKM2VffLkrhErG8VMQvgb0jc7dPXvQjAWhJPzcYWmHpWe+IJbsllj7z5BRwk/h4Lod/+D5
 OvLVk4mxgsXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,257,1610438400"; d="scan'208";a="606060257"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
 by fmsmga005.fm.intel.com with ESMTP; 18 Mar 2021 01:27:14 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 18 Mar 2021 01:27:14 -0700
Received: from fmsmsx604.amr.corp.intel.com (10.18.126.84) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 18 Mar 2021 01:27:14 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Thu, 18 Mar 2021 01:27:14 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.45) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Thu, 18 Mar 2021 01:27:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=itd8kAp3R19LNuBQW/+Zc4TSLDji7yNg3bbQ154p4j9IIUTZGwYjgpYzqqHU3AtZh0qIeVlQ4/FCHyQWvDCIQ/WdlKMecZNXqHaZYmbo0y2ukYrrPTDYP1gUJf94PkVL4lBs5KCRDIYbCHw00SqK7UFSIBwMvTv+hIZcdEgizJwFTRtwVjUrqf2yaGHMjEw2FI3r8aunnOTBHCFmc+NjVZNBas9Yo34gaLUtjeIqhb22hLx9N241iQkTfGzVUCxrT0O3IYEy+4Pvi4R1xKjshx99J6jeMAr0mG5sO9zcL3+Hslnyz2MgKxq4y8mgTe8LsUttImEJBHhc1sxdTn4+Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YzEo3Hvt3Z55g5VciG97cyyU6vqLZluxuQ8UQDlO85c=;
 b=HxCLM93hNyq+NnaT5oGhcLRXQT8Y0KZuKaAB2QwzpOVQvOnO2Kq8Ts89YhlNb8nMdo23tzbuve64Vlq9Mt7p+/KgfCeOd2+jOP96CyZIdzKKTFGkz6VHmQKZS/Ve6DxavkaMZsUwaholFVZNVlJEYgvr9CcFsWftwdPK6hgf1fyxmeE9hTMRj6dj8SMn7nXbsjKdpn7n8TQhDGzCHnRfclZ7SWBDE9L6H2fZKDQTRU5ytkbmKBlaco9aCtbvmC54fRV92jbWrZvwIQy3ys8BNl5U7U1DLb8cQ55yhCy9BtBX87laWONiW4vZxsbSVP/t3MdwzD+r8IYOBr4FAnLrwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YzEo3Hvt3Z55g5VciG97cyyU6vqLZluxuQ8UQDlO85c=;
 b=IxercLPU2hGFFdkY5m+OyksGd5qmWsDq7vA4IXbNNq/loKh0s/zb72ZAP42accW+UfXvqWGRigojcL9+HzBK1uDTBSiE4kSi9nP0fkO2kSsV0nJWP3K10SXTT48pTjreQBSxLKjZAJ+wD/WDwaVACAuRMhKL6/ydIdGYs8suYTg=
Received: from MWHPR11MB1886.namprd11.prod.outlook.com (2603:10b6:300:110::9)
 by CO1PR11MB5043.namprd11.prod.outlook.com (2603:10b6:303:96::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Thu, 18 Mar
 2021 08:27:12 +0000
Received: from MWHPR11MB1886.namprd11.prod.outlook.com
 ([fe80::75b0:a8e9:60cb:7a29]) by MWHPR11MB1886.namprd11.prod.outlook.com
 ([fe80::75b0:a8e9:60cb:7a29%9]) with mapi id 15.20.3955.018; Thu, 18 Mar 2021
 08:27:12 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: "Longpeng (Mike, Cloud Infrastructure Service Product Dept.)"
 <longpeng2@huawei.com>, Nadav Amit <nadav.amit@gmail.com>
Subject: =?utf-8?B?UkU6IEEgcHJvYmxlbSBvZiBJbnRlbCBJT01NVSBoYXJkd2FyZSDvvJ8=?=
Thread-Topic: =?utf-8?B?QSBwcm9ibGVtIG9mIEludGVsIElPTU1VIGhhcmR3YXJlIO+8nw==?=
Thread-Index: AQHXGuJY/V4R/VN0mE2jjNDTL4ZYXKqHq9kAgABAOICAAJBrAIAA7MAAgAABDOA=
Date: Thu, 18 Mar 2021 08:27:12 +0000
Message-ID: <MWHPR11MB18860801196A9319EBD96AF68C699@MWHPR11MB1886.namprd11.prod.outlook.com>
References: <670baaf8-4ff8-4e84-4be3-030b95ab5a5e@huawei.com>
 <FB4E11A5-84D4-4DAF-889E-FAA1BCD2E66F@gmail.com>
 <6a218e7fe42d41489d02f0b4e3ad2756@huawei.com>
 <98DB71EF-FF98-4509-85EC-26FF50825A58@gmail.com>
 <4d1c3bc0418e48b1b9d44799d65ea375@huawei.com>
In-Reply-To: <4d1c3bc0418e48b1b9d44799d65ea375@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [101.88.226.48]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 39fa0f02-023a-4f07-9027-08d8e9e7a146
x-ms-traffictypediagnostic: CO1PR11MB5043:
x-microsoft-antispam-prvs: <CO1PR11MB50433CCAEF9227EF75258C8E8C699@CO1PR11MB5043.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: N0ECZYeOGiNbevIh5QWWJX9mTmclJwQpLw+wY3C85QVhnEEJ8Q7aajhkWu9uOeZ+KJczRjkSBatfq7/gTvrag1ZEU+VVVamVaPRXIMlR7v3JCHTnF/RnodfdAEdGK/sNT1K1l7b7RkAoJjJuLkJSVoHjYY4FZMGWn/1RrF+dku7U7GdXQUC1VvNgqxxQIdsxhvxhvljT4awwNQoMrvVl3t4jBjVlQlymBwhqLVrn97KBJNWSANlNEbRmX+3fCuKyGlkbDZUcUpN4hnMGVgyWbP41ol9ErUaz5M12QN3NtcWYxfngm5Dzn9IoIJwLyfx0t31kj46WOpQfd6kolme6z2NYvYZlTmokaofMmGmqXkwSXBc3YSCV4FzZI4NzoA15YCPGcPGqfQcTDHIn6azyUDza6RducXWmpHJBJtiA2rfJEkKbdrWjQ+1XtEBkVk3hGiYyzn69+hj8Ur6mFO1YAk9HBZN9W77EEXmkdb6q+p/9upOptdFl4tfy0DvBuPGBnMydjpO0SCPq8ugdRbdyn1ePKOoiA7sIcEHP3/AwVuTJHhPPq1eGqq+c5w38wJr861R6dJxApS17WbpD8VLhuk4rlMona7qv4LhyJ9Xez+zwgCjzaV+De6ed6gV7h7ta
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR11MB1886.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(136003)(39860400002)(346002)(396003)(366004)(376002)(76116006)(66946007)(66476007)(4326008)(9686003)(66446008)(66556008)(5660300002)(86362001)(186003)(71200400001)(2906002)(52536014)(55016002)(478600001)(316002)(7696005)(54906003)(4744005)(33656002)(64756008)(110136005)(6506007)(8936002)(38100700001)(26005);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?UHl1OENEbHpyMUpWQmYyS2U3ZzR6QzQ2RFF3ZEdTZCtVTnRnMVN3TnY5T3R4?=
 =?utf-8?B?bHNTVjJWTm0zSE9Oc1Avbk9rTlFXR2hCS0xadmlmSFpDVUFEWkRWRnhSYjd4?=
 =?utf-8?B?VTEwSlVLWWRqWlh6YTNiU3Vpc01hMVJLeGd0UENpZnRIUUhNY1JkY3ZRWnBQ?=
 =?utf-8?B?YXIyNUNGa2lkMUwxQ3Bqa0d3MWhEeTRhcE94WjVCSGVrMDcyMDlKU08rVTk1?=
 =?utf-8?B?OXpaTEZBSHZKTVprU0JEUU4xOGd3OEZyZ0Mzblhlckxwdzlvdzc2dmJxRkp0?=
 =?utf-8?B?Y3RGTzY5VUg3TExYbVJ2K3EreWJFbGZ4M3FNYlVxU2o3cVRGUnV5QytqUU44?=
 =?utf-8?B?bW9pdE9GRG4rdXdNTVdOeGZyWUlSRjRQR2RVdHVTKzd3djd1MlhyVmdkVXFr?=
 =?utf-8?B?ZUt3dGMzcDd6WkVRbEZHaUd6eU9DVXB4d29HSThhOXl2NlJiUkhrL3hNNFNN?=
 =?utf-8?B?MktUekVvRGFTall4NTRRYVVrallKVnZtSmU1NFFHMnIyZmNPbFBZVk1rdGNj?=
 =?utf-8?B?LzNsZHRVZ3dOclVtaHI4TzdSZDQzb2pmVkVHTGdKcEVJeFllK3hsTUU0TGVt?=
 =?utf-8?B?UWhzZEdTVTBBZW02QmtBWTNtRHVKR2ZuSXYrTUdUYVpoNHFBYnoyVWdsdnVu?=
 =?utf-8?B?NUY4TzFNQTlHeWlZcjNTZGkyTGlCL1FWZkdvWHZyT25kZVpqOW4yODY4cmNJ?=
 =?utf-8?B?TUF2dUZBN0pHY1RsQlYxQ0hXd1BQVHVYSmZMd3RTOFZvbWQvZ2o2SnlvYjR3?=
 =?utf-8?B?QlN2TGF6cExEZEMxRFcrVW1EMlZuRVNEVUFnT2xuaG16Qmdudm0vNWMxajRy?=
 =?utf-8?B?bERoVjhPVkt4YUw0emkyeTBoMm9vNE1LQSsvem1aeUtmWDZ2R3FVaUplQWNQ?=
 =?utf-8?B?Z3dHNUp3OVBGTjQvRDRnVFVGYUpPbnpncWVSMzViM1YzaGFWNC9vMURoRTRQ?=
 =?utf-8?B?aUNEaDZneFVoSzFWNmk3UTVweENBeXY1cUpyem5Wd3JnUmtIY25xWE8vSHhD?=
 =?utf-8?B?cWIrWHl0d0ViQjBXUVROaGJYeC9tdWcxTzZnN2xlb2x2ZE8vN3BRUWk0Tnpw?=
 =?utf-8?B?dW1GaURRRjEvTmpxOFZxb01nL1hjd0VEd1JaWkxNTnJwcW11OWh6aXp0bmh5?=
 =?utf-8?B?dkovMGRseGZlNWxZdDJkd3BUVy9YRzM2blM1Q1lrT0VJeS9YQWIyQWw3bEc1?=
 =?utf-8?B?b1l3VEYyLzFjVlZVTys4eGJZQ3lwYVZ4NklNUjIybWFwL09LRWIxRzR0TGJX?=
 =?utf-8?B?Zy9pdTRCR3BaR1hVVXJXTE92YjF4ZHhSR1B0SHhvR05pZk4xVjZFRVljWDBt?=
 =?utf-8?B?RVR1TU8vR3hZeHJJdzUyS2NsM2FvbDZyRmpGSUhicy9UK0ozRFNxSyt2NGFU?=
 =?utf-8?B?aldaV2M0STAvVlNjWGVLVFh6YnlSR2tsejByYUZNdkJBcTBnYVNVN0dyL1BZ?=
 =?utf-8?B?MStZUXE4V1lDSGtEQWhJMDVOUDNjbFdnUTdReGEwZGVxMzRYa3RJTDRpOVdy?=
 =?utf-8?B?Q3dLenppbHluMzAzdjdJMUYzY2Q2QzhtWEFDQ0I0VytLVkFIVVVGYmlvY0hB?=
 =?utf-8?B?eGduWXdXclU0bzI3UUQ1cUF1VVhkeS92ckdleTBnY1RjSzZpaFRPMEg4dXo3?=
 =?utf-8?B?RjlWOUNyY1grR2lXYmc4SWk3NFQrcWYxV0xrVC9ENVo1bDVKL1BTOG9vM1BF?=
 =?utf-8?B?V3FXTVB6TlZqYzk4VThGUHNHS1RkYUFTSlJ6cDZSb3Q1aXRjUm52MXdQSm1O?=
 =?utf-8?Q?dnTSSsT/RBYNVduzv3Zr1iK+AbUOdQaJID6scYp?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1886.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39fa0f02-023a-4f07-9027-08d8e9e7a146
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2021 08:27:12.3679 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pQMcqlzIjaCYBqwO5yjSU4bmD67jcM0jm9lHFWRadi7QL01/jc+1wwAL7Ee6MISGPVELEgy9bB+GIv702bjMFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5043
X-OriginatorOrg: intel.com
Cc: chenjiashang <chenjiashang@huawei.com>, "will@kernel.org" <will@kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 LKML <linux-kernel@vger.kernel.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "Gonglei \(Arei\)" <arei.gonglei@huawei.com>,
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

> From: iommu <iommu-bounces@lists.linux-foundation.org> On Behalf Of
> Longpeng (Mike, Cloud Infrastructure Service Product Dept.)
> 
> > 2. Consider ensuring that the problem is not somehow related to queued
> > invalidations. Try to use __iommu_flush_iotlb() instead of qi_flush_iotlb().
> >
> 
> I tried to force to use __iommu_flush_iotlb(), but maybe something wrong,
> the system crashed, so I prefer to lower the priority of this operation.
> 

The VT-d spec clearly says that register-based invalidation can be used
only when queued-invalidations are not enabled. Intel-IOMMU driver
doesn't provide an option to disable queued-invalidation though, when
the hardware is capable. If you really want to try, tweak the code in
intel_iommu_init_qi.

Thanks
Kevin
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
