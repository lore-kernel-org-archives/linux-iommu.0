Return-Path: <SRS0=d8dU=JF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 034E2C433B4
	for <iommu@archiver.kernel.org>; Thu,  8 Apr 2021 11:41:22 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F2BC61139
	for <iommu@archiver.kernel.org>; Thu,  8 Apr 2021 11:41:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F2BC61139
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3F4BC400EC;
	Thu,  8 Apr 2021 11:41:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id k76M_9MsHbtc; Thu,  8 Apr 2021 11:41:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 338BF400A7;
	Thu,  8 Apr 2021 11:41:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EC147C000B;
	Thu,  8 Apr 2021 11:41:19 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 807C0C000A
 for <iommu@lists.linux-foundation.org>; Thu,  8 Apr 2021 11:41:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6EC3C400EB
 for <iommu@lists.linux-foundation.org>; Thu,  8 Apr 2021 11:41:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GQHnSesllXqY for <iommu@lists.linux-foundation.org>;
 Thu,  8 Apr 2021 11:41:17 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on062a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe44::62a])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4CCEF400A7
 for <iommu@lists.linux-foundation.org>; Thu,  8 Apr 2021 11:41:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dirQRXoh1J8XF+FPqZFBwaa/X88vpba1m3dikJIr9t92bWLCoj4nQAR5UGZWOQrdpm9g6NsTAw0aP26tx228R7SnY8EuFl/fkMpDb5Us9CBJ7oy//wlPfZiNZwDzsWTagWGhI3KMZw0Xwq86zkaHRKmIjktoEBRUiALu1o1T3qs3/d80hqBf8c0NEfUdMPJ02FGyG8EQhRk/mfE2TtlQjIBvTrWPnYtu6CfARWuF38X5a0WHyLq2+4poRbVRDLp0ZserlfwXmEywEJrQf21PHfzVWD5yIv67yZZ6ydJFcgVw8nPrrqsQqdzCnSPkXKFzOoTtd1h5dsumhklJHmn0IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=48OHsp5mI3yQn9DHcjJ1PrziL5UqaHpzIRwLXkKu7z0=;
 b=PwzogAIPPemmNz20lWPnCoYecb0fWp1uQEeeD52aHsVxpDGu+8b0XXdVluuTwkbMyG867r4LCj/MusPU6RtHqR4WH3KEi1MOcECzotq+Tq0Kdb009DBeoS4LfLFf2H4b2U9YGjJumT98DByeI3asn4suxSQajR9Hb6eOnyp7S1/DGJiwg1bCP1VEdn6iDJfPSe//1gtAzdXsSC028C/MR6MS5vSCdS9cjglGN63EBhXmd5ckg1WAVZuifdH2aRP1mZWuhFSnhonOF++Yxgptk+GKb7YbeQLi2rjfazfvqImclRsnGu1cdXbuReGSzLpdGUGyrofTwjrkjcQS6vwpYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=48OHsp5mI3yQn9DHcjJ1PrziL5UqaHpzIRwLXkKu7z0=;
 b=eHaPZOGQChk9LAHLgFwQD7YeZuLpMvNdeyclyCf7PB2H4FY7mAjGNyAp7qO0UO6KK+5AgDh1WrBY/2ZIimgmxDh1B38HLLStt1FjSV6mn4qmMB1QDKZjtlI1xwbWO5c2PeW2y2XMrUBVtdZ1oCXMNkzwZ3LDY6FybWDl9/brPgvQ2yvnEtCyocJQs1WQXF5soAHdnch8E5O+gJiwayiVFaOKsOjgbexxddaVlBxQT7yEnQTq4PjHmTYHSlMcxw0GOCCCGD76njQxYXp+8sjhAIWzuu4Z5htTQqNdjA0sbhqAzykjShPpDIztYCzULHzZVAHwlLkx+4wvNhfIxuwoag==
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3113.namprd12.prod.outlook.com (2603:10b6:5:11b::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27; Thu, 8 Apr
 2021 11:41:15 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3999.032; Thu, 8 Apr 2021
 11:41:15 +0000
Date: Thu, 8 Apr 2021 08:41:13 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Subject: Re: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and
 allocation APIs
Message-ID: <20210408114113.GN7405@nvidia.com>
References: <20210329163147.GG2356281@nvidia.com>
 <MWHPR11MB188639EE54B48B0E1321C8198C7D9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210330132830.GO2356281@nvidia.com>
 <MWHPR11MB1886CAD48AFC156BFC7C1D398C7A9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210405234230.GF7405@nvidia.com>
 <MWHPR11MB1886CF7C11ECE0396A0215078C769@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210406123451.GN7405@nvidia.com>
 <MWHPR11MB1886CB8F558C6C17F921F77F8C759@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210407122042.GF7405@nvidia.com>
 <MWHPR11MB1886AEAE97A9E6972C63CACF8C759@MWHPR11MB1886.namprd11.prod.outlook.com>
Content-Disposition: inline
In-Reply-To: <MWHPR11MB1886AEAE97A9E6972C63CACF8C759@MWHPR11MB1886.namprd11.prod.outlook.com>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: BLAPR03CA0076.namprd03.prod.outlook.com
 (2603:10b6:208:329::21) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by
 BLAPR03CA0076.namprd03.prod.outlook.com (2603:10b6:208:329::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17 via Frontend
 Transport; Thu, 8 Apr 2021 11:41:14 +0000
Received: from jgg by mlx with local (Exim 4.94)	(envelope-from
 <jgg@nvidia.com>)	id 1lUT29-002gu0-Bb; Thu, 08 Apr 2021 08:41:13 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bf2ee5d3-ae12-43db-37d0-08d8fa833743
X-MS-TrafficTypeDiagnostic: DM6PR12MB3113:
X-Microsoft-Antispam-PRVS: <DM6PR12MB311345EA793C5FA1CDA9C122C2749@DM6PR12MB3113.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x7f86JSlLT3HDyCU3AtMKPNBzH7riFib8cjWXyYC7QZ777SSYTNLMpKmT8M7TrFOyoehBeVv9yuN6ywvrknJtPXc0XMMMMVZtGjkUIw9aLI0t2hjG6eQ7cUERmpMmkV9sstw8GM6jLQ9Q8GXYdH3XMZk+ieJahv/XFLtoOlhKvcK8lZ87SCg2FQepxQJCbPLeQtCGBDdNEuK6FdSzZYQjnfV0zDNJxW8CTE6MvC3fqX7XxX/c+wsolc7reWflCvxO2yOIMD5Ygz8If+UU1j4HifdNrMrA3vLJxT3DoANhtJwQgmXXFLE2rMH8BPBg4+L+hsZI31WrIvwYLyaflimRWEEWP29RsEb3nVO+2yI6Pakge84sEpHjEpw49LTOPGzCTvbC0W7H6cIsnIK1Jq+fabmfKjDFh83KNoJf/n/hYtda3qhmLJY9Pzp18c4Hk4DzoIIxdxRh9jNGaepVwfgeiXx1S3bqwkI/WNSXJZEeoVYQKGPujifxHRdhntMPoWMCAFxWXY/r1T0aufXx/7o6qzF45a2F7m51ZM1W5TxxaD5T51o8K3RthE/RSLJu+2LhUoBfQyR1h28wWk411g6amg5PI7gjJmKhcN9TTDhZKndcchRIoKGRafIgaeteUnB6sikdBaNu7CsoiFG6UvftmE1lDfsRu+Fix0C2w9CwaU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3834.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(136003)(39860400002)(366004)(376002)(426003)(36756003)(54906003)(9746002)(8676002)(9786002)(2616005)(8936002)(66476007)(66556008)(66946007)(316002)(83380400001)(6916009)(2906002)(478600001)(38100700001)(7416002)(186003)(86362001)(5660300002)(1076003)(4326008)(26005)(33656002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?Sk1IcllHYkJ4MXdzOWx1a01sTU8wRG1HNnpIaGVXVEg4TGpVSFFEVGtzS2NS?=
 =?utf-8?B?R1l5cUhTODE3cHNzL2paR3FsOGc1eExOamlja1R0R1lIY1FXVzgwYmxNalRJ?=
 =?utf-8?B?Wnl3SE9STG5iNEkxbXZldHdaQ3Z0VjJwZFE1ZjZMMVIvUnEyQlRPOVRDQWZk?=
 =?utf-8?B?Z0trcW1qNGdMRHdSTEYxZG5HU1k4Q0dBRVovcTM0eFdyeHJmZnJ3bEpnYnh4?=
 =?utf-8?B?ZStuelVIT1hDaTk3V1ZLakg2WkVzc2hRWG5Cakgrb0ZQank2YmlBeUVFbEVW?=
 =?utf-8?B?cFNOWWFGU3dXV2loeFRuU3p6V0lGeG1BUHVSNmVxSXFBeExQdGhmMTJVbmEr?=
 =?utf-8?B?SlpaaHo3RnkxOGFGZ0xsNlR3Wk40b2dydlU5eUVBNVRweFVqYVFBMGh6TUZt?=
 =?utf-8?B?dEszSFpsM25RRnBRVXYyU1dlalRtYnZuRDd5V2JicWlUVU5lMGJaaHFLU3FT?=
 =?utf-8?B?TEQ3VVFNdHMyZTEveHYzZnoyUjFsQWduUmtUNmhVbDJSWWtZQmhneDh6eHJa?=
 =?utf-8?B?WVJvNnZWNGlzSmtaWThKYkpCaUdveVhGMXZXN21xZWVxdDBWd21EL01QRG5o?=
 =?utf-8?B?d3JJNnRYZnRHNk1wemkrb1NLejY3RDcwSGxWcmt1NFBMaTR2V0YzQm5YWWhH?=
 =?utf-8?B?cXgwblhHaG9JcGdBb2VhMEJiOVZneVZsdHZVbXBtTEZxWWJzRkwxQVdlc2lk?=
 =?utf-8?B?STJaR1BXSWZXdlVYMTE5RFd6MUEvZ1RjR0g2VWZPOGJxOWIrNGQ5Sm5xZENL?=
 =?utf-8?B?YWpsbXgxSHRuOUl5QXg0SlZUSnVpOThpY2NqQmZCSjZvY2FkUTBITW9zTjhN?=
 =?utf-8?B?Q1IwazRHSUNPZVFUdFZEemI2d1JBamYyOWdacFJ5TVAyQmlROHhVYzBoOVcx?=
 =?utf-8?B?ZHdBc3BWMjJodWxDWFZ5bkg4bEczTWhzTnRESWhVN3R1ZzAvZFhBS2Q3VUUy?=
 =?utf-8?B?eTJPRUhJaUlrTmFaL0MwS0FLZzVQVzZxOUh1VjZtY1dDTXhxbks0b2tQamxj?=
 =?utf-8?B?K2czMGtPMkZBSDlSNzBYZlZBaTRpMmlVRzYrL1NCNUxxOGVlMXlackd4eE1h?=
 =?utf-8?B?VU56Zk9mdHBoNzFtS1NzQ2svMytLQlg4dHRrSEpJd0tXMnRqSnROSUZOUElp?=
 =?utf-8?B?YXRrZWJOVk1TbjZmaUlEMjcvQ2RjQjdqYTEzSklwYVRpMWRoUkhXdkJoRmt1?=
 =?utf-8?B?L0Q3Q2RCYkw5aEJHcVlWNkUrdmZXeTAxWW9WMzh0bThuc25RTGEvbk9QRXpK?=
 =?utf-8?B?QXN4SW1ENVdiZDFWYWE5RGd2d1M3blFVdXdKd09YS3RxSnVLWTIxdmpTZy9T?=
 =?utf-8?B?YXB0RVJ2UHdadGZZVFhhbjA1MmFiMXJhMkJYdGh4bkF0UmMrRHVyVG5NUU9J?=
 =?utf-8?B?Y01ERzJQTTltcXJJMGRMMUpwQnk4YTJlYzdPeTZ6Qmt1cDAzdC8vVURmTG9h?=
 =?utf-8?B?ZHgyR1p6RTN1bGJhTHhaNzZkRUNzT2d4U1l3dUl4T21NT1JHS08yUEVDVHdy?=
 =?utf-8?B?cy9Ta01jZGphc2R2cGJnMmVnRVc0cGVjZWI1N2srMDlTOEJ5OVQwcTlWbm9T?=
 =?utf-8?B?dldqRFE2L0pTSitMNmRxY2d5SW9aYnVveHpIUy9yVHlBbnVTeWo5dEJIOVlq?=
 =?utf-8?B?M2xnaFk1by9vRU51aGlIM1E5QXBYZWxJSDRaMXE1alljRC94TXBWSm5XNkZY?=
 =?utf-8?B?SnVWT0ZFa3IyRUcySHFPcy9MSmxEVDljaTVieGdJSVlxeUtNbGtSNjlwenBK?=
 =?utf-8?Q?QAWFtUsbdhD0gxbrxFu/UNafD6EyR4MMjqOccyl?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf2ee5d3-ae12-43db-37d0-08d8fa833743
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2021 11:41:15.0315 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hppP1EQxIDE2JqzFbsRJneV2TEDenuRBviLxrHQiWtijBlptfVI53YJZUxNCBwwr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3113
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, "Jiang,
 Dave" <dave.jiang@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 Jonathan Corbet <corbet@lwn.net>, David Woodhouse <dwmw2@infradead.org>,
 Jason Wang <jasowang@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Alex Williamson <alex.williamson@redhat.com>, Li Zefan <lizefan@huawei.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Tejun Heo <tj@kernel.org>,
 "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>, "Wu, Hao" <hao.wu@intel.com>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

T24gV2VkLCBBcHIgMDcsIDIwMjEgYXQgMTE6NTA6MDJQTSArMDAwMCwgVGlhbiwgS2V2aW4gd3Jv
dGU6Cj4gPiBGcm9tOiBKYXNvbiBHdW50aG9ycGUgPGpnZ0BudmlkaWEuY29tPgo+ID4gU2VudDog
V2VkbmVzZGF5LCBBcHJpbCA3LCAyMDIxIDg6MjEgUE0KPiA+IAo+ID4gT24gV2VkLCBBcHIgMDcs
IDIwMjEgYXQgMDI6MDg6MzNBTSArMDAwMCwgVGlhbiwgS2V2aW4gd3JvdGU6Cj4gPiAKPiA+ID4g
PiBCZWNhdXNlIGlmIHlvdSBkb24ndCB0aGVuIHdlIGVudGVyIGluc2FuZSB3b3JsZCB3aGVyZSBh
IFBBU0lEIGlzIGJlaW5nCj4gPiA+ID4gY3JlYXRlZCB1bmRlciAvZGV2L2lvYXNpZCBidXQgaXRz
IHRyYW5zbGF0aW9uIHBhdGggZmxvd3MgdGhyb3VnaCBzZXR1cAo+ID4gPiA+IGRvbmUgYnkgVkZJ
TyBhbmQgdGhlIHdob2xlIHVzZXIgQVBJIGJlY29tZXMgYW4gaW5jb21wcmVoZW5zaWJsZQo+ID4g
bWVzcy4KPiA+ID4gPgo+ID4gPiA+IEhvdyB3aWxsIHlvdSBldmVuIGFzc29jaWF0ZSB0aGUgUEFT
SUQgd2l0aCB0aGUgb3RoZXIgdHJhbnNsYXRpb24/Pwo+ID4gPgo+ID4gPiBQQVNJRCBpcyBhdHRh
Y2hlZCB0byBhIHNwZWNpZmljIGlvbW11IGRvbWFpbiAoY3JlYXRlZCBieSBWRklPL1ZEUEEpLAo+
ID4gd2hpY2gKPiA+ID4gaGFzIEdQQS0+SFBBIG1hcHBpbmdzIGFscmVhZHkgY29uZmlndXJlZC4g
SWYgd2UgdmlldyB0aGF0IG1hcHBpbmcgYXMgYW4KPiA+ID4gYXR0cmlidXRlIG9mIHRoZSBpb21t
dSBkb21haW4sIGl0J3MgcmVhc29uYWJsZSB0byBoYXZlIHRoZSB1c2Vyc3BhY2UtCj4gPiBib3Vu
ZAo+ID4gPiBwZ3RhYmxlIHRocm91Z2ggL2Rldi9pb2FzaWQgdG8gbmVzdCBvbiBpdC4KPiA+IAo+
ID4gQSB1c2VyIGNvbnRyb2xsZWQgcGFnZSB0YWJsZSBzaG91bGQgYWJzb2x1dGVseSBub3QgYmUg
YW4gYXR0cmlidXRlIG9mCj4gPiBhIGhpZGRlbiBrZXJuZWwgb2JqZWN0LCBub3Igc2hvdWxkIHR3
byBwYXJ0cyBvZiB0aGUga2VybmVsIHNpbGVudGx5Cj4gPiBjb25uZWN0IHRvIGVhY2ggb3RoZXIg
dmlhIGEgaGlkZGVuIGludGVybmFsIG9iamVjdHMgbGlrZSB0aGlzLgo+ID4gCj4gPiBTZWN1cml0
eSBpcyBpbXBvcnRhbnQgLSB0aGUga2luZCBvZiBjb25uZWN0aW9uIG11c3QgdXNlIHNvbWUgZXhw
bGljaXQKPiA+IEZEIGF1dGhvcml6YXRpb24gdG8gYWNjZXNzIHNoYXJlZCBvYmplY3RzLCBub3Qg
YmUgbWFkZSBpbXBsaWNpdCEKPiA+IAo+ID4gSU1ITyB0aGlzIGRpcmVjdGlvbiBpcyBhIGRlYWQg
ZW5kIGZvciB0aGlzIHJlYXNvbi4KPiA+IAo+IAo+IENvdWxkIHlvdSBlbGFib3JhdGUgd2hhdCBl
eGFjdCBzZWN1cml0eSBwcm9ibGVtIGlzIGJyb3VnaHQgd2l0aCB0aGlzIAo+IGFwcHJvYWNoPyBJ
c24ndCBBTExPV19QQVNJRCB0aGUgYXV0aG9yaXphdGlvbiBpbnRlcmZhY2UgZm9yIHRoZQo+IGNv
bm5lY3Rpb24/CgpJZiB0aGUga2VybmVsIG9iamVjdHMgZG9uJ3QgY29tZSBvdXQgb2YgRkRzIHRo
ZW4gbm8uCgo+IElzIGl0IHJlYWxseSB0aGUgb25seSBwcmFjdGljZSBpbiBMaW51eCB0aGF0IGFu
eSBuZXcgZmVhdHVyZSBoYXMgdG8gYmUKPiBibG9ja2VkIGFzIGxvbmcgYXMgYSByZWZhY3Rvcmlu
ZyB3b3JrIGlzIGlkZW50aWZpZWQ/IAoKVGhlIHByYWN0aWNlIGlzIHRvIGRlZmluZSB1QVBJcyB0
aGF0IG1ha2Ugc2Vuc2UgYW5kIGhhdmUgYSBnb29kIGNoYW5jZQp0byBiZSBzdXBwb3J0ZWQgb3Zl
ciBhIGxvbmcgdGltZSBwZXJpb2QsIGFzIHRoZSBzb2Z0d2FyZSBldm9sdmVzLCBub3QKdG8gaGFj
a3kgaGFja3kgYSBnYWludCB1QVBJIG1lc3MganVzdCB0byBnZXQgc29tZSBmZWF0dXJlIG91dCB0
aGUKZG9vci4gCgpUaGlzIHByb3Bvc2FsIGFzIGl0IHdhcyBvcmluZ2lhbCBzaG93biBpcyBleGFj
dGx5IHRoZSBraW5kIG9mIGhhY2t5CmhhY2t5IHVhcGkgbm9ib2R5IHdhbnRzIHRvIHNlZS4gVHVu
bmVsaW5nIGFuIElPTU1VIHVhcGkgdGhyb3VnaCBhCndob2xlIGJ1bmNoIG9mIG90aGVyIEZEcyBp
cyBjb21wbGV0ZWx5IG51dHouCgpJbnRlbCBzaG91bGQgYmFzaWNhbGx5IGJlIGludmVzdGluZyBt
b3N0IG9mIGl0cyB0aW1lIGJ1aWxkaW5nIGEgcm9idXN0CmFuZCB3ZWxsIGRlc2lnbmVkIHVBUEkg
aGVyZSwgYW5kIGRvbid0IGNvbXBsYWluIHRoYXQgdGhlIGNvbW11bml0eSBpcwpub3QgZG9pbmcg
SW50ZWwncyBqb2IgZm9yIGZyZWUuCgo+IERvbid0IHBlb3BsZSBhY2NlcHQgYW55IGJhbGFuY2Ug
YmV0d2VlbiBlbmFibGluZyBuZXcgZmVhdHVyZXMgYW5kCj4gY29tcGxldGluZyByZWZhY3Rvcmlu
ZyB3b3JrIHRocm91Z2ggYSBzdGFnaW5nIGFwcHJvYWNoLCBhcyBsb25nIGFzCj4gd2UgZG9uJ3Qg
aW50cm9kdWNlIGFuIHVBUEkgc3BlY2lmaWNhbGx5IGZvciB0aGUgc3RhZ2luZyBwdXJwb3NlPyDi
mLkKClNpbmNlIHRoaXMgaXMgYWxsIHVhcGkgSSBkb24ndCBzZWUgaXQgYXMgYXBwbGljYWJsZSBo
ZXJlLgoKSmFzb24KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0
dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
