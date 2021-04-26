Return-Path: <SRS0=8mM2=JX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_RED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EA53C433B4
	for <iommu@archiver.kernel.org>; Mon, 26 Apr 2021 12:38:29 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDB2E6100C
	for <iommu@archiver.kernel.org>; Mon, 26 Apr 2021 12:38:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDB2E6100C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8AF59402CA;
	Mon, 26 Apr 2021 12:38:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IlKfoCHZtHvv; Mon, 26 Apr 2021 12:38:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id CE92E40290;
	Mon, 26 Apr 2021 12:38:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8880BC000F;
	Mon, 26 Apr 2021 12:38:26 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6BB8DC000B
 for <iommu@lists.linux-foundation.org>; Mon, 26 Apr 2021 12:38:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5A2EC83926
 for <iommu@lists.linux-foundation.org>; Mon, 26 Apr 2021 12:38:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1pheKXH2rG3O for <iommu@lists.linux-foundation.org>;
 Mon, 26 Apr 2021 12:38:22 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700049.outbound.protection.outlook.com [40.107.70.49])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2E34A8387D
 for <iommu@lists.linux-foundation.org>; Mon, 26 Apr 2021 12:38:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FPkljl33hgZRobT2CtqZDNuLbaZKUwsqY3unyeEChco4eHgKQ4lbHnOvQ6ktZkuklnlZ06WcRbVChZjKGX0xC0eFLIs6G5UMzVRFdIoPL9LgoQmC6/BB3W8EZup3/eS2GeetYRfxyMAh9DpPtyXn264qKGoMVp3L619K03yGctdT+B6LIcDjFdUUFj2LVcyy869cjf012oz2VI1pOPDBsM4+ijSkfiiztBo/VxzI0jzpF68Q1yEvpeeO9WIlnUSugM/ZwgGoWcShlr1zAsszc8RNhMwPUp3jFVmIvIvi7V7ybhNMugyOGJfmfqXlWqBaF7YyJcN+Cr2rzAh7vqSlww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tOlurQmXmbDShxP4zI/UwwA0xTTiZnMgbw91KKw+w9Y=;
 b=gQsFEecWa147XIrvj4n4HgbRqtdeKz982OnUapT2YV4jQb1rkY05KpxhWKg5viaw0L+mJR4uHVPp02DUkA7HWrP0d5I8+FpAMc8d+BKLuiu6XtjzI6YuTduJjxj5qI0aws/+W63k6m+smCQZw5jWMdtLwVZKPqktTsHiuWs+PGxwE1rChx8M5Actr63keciPg08qA19wIgBdR7g8Nddsioc1e6elCynp3TI8UwwtTk1bgDYcl/oRtjMzKt2xvzRRu3c/rSjR8YKaeSchInETMTzCecpr79XTGtaX5lv7xX46lhXrEYdnHcPb3CY8sBKM3iSlyLCs3pcEFUT1sqzBlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tOlurQmXmbDShxP4zI/UwwA0xTTiZnMgbw91KKw+w9Y=;
 b=pK7tjSDVxjWxR6OBPJP8VKdsxlAQbnRrbjt+npzKtVjTr5cMRt9EXhftMNvnApUZOHK1NMyzYfw3XzylK5w/DAImAF1yLXN7WLHpUMnobk1maWeRazoJS4U1N658hSj+Tcc1Sgrny4vF2NT9WuUKwdUtAd68pWTguRe877ab13+vUo4p9yPEtnC+M82n6ic4c7YfMRG3H82+xvfgWss2rskXWixT4j0A+taeGe1vky3dXb/hVA1W+QncsGpqRJj0e2rVS58Duwgmd6yWy22e29c/tLhTiYFdi/+psJdfOWisbEiZr5dfYqX44OBU23qzDQr8eheNAhmeGcSkima0jQ==
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3019.namprd12.prod.outlook.com (2603:10b6:5:3d::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.23; Mon, 26 Apr
 2021 12:38:19 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.4065.026; Mon, 26 Apr 2021
 12:38:19 +0000
Date: Mon, 26 Apr 2021 09:38:17 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Subject: Re: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and
 allocation APIs
Message-ID: <20210426123817.GQ1370958@nvidia.com>
References: <20210421162307.GM1370958@nvidia.com>
 <20210421105451.56d3670a@redhat.com>
 <20210421175203.GN1370958@nvidia.com>
 <20210421133312.15307c44@redhat.com>
 <20210421230301.GP1370958@nvidia.com>
 <MWHPR11MB1886188698A6E20338196F788C469@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210422121020.GT1370958@nvidia.com>
 <MWHPR11MB1886E688D2128C98A1F240B18C459@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210423114944.GF1370958@nvidia.com>
 <MWHPR11MB18861FE6982D73AFBF173E048C439@MWHPR11MB1886.namprd11.prod.outlook.com>
Content-Disposition: inline
In-Reply-To: <MWHPR11MB18861FE6982D73AFBF173E048C439@MWHPR11MB1886.namprd11.prod.outlook.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: BL1PR13CA0263.namprd13.prod.outlook.com
 (2603:10b6:208:2ba::28) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by
 BL1PR13CA0263.namprd13.prod.outlook.com (2603:10b6:208:2ba::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.16 via Frontend
 Transport; Mon, 26 Apr 2021 12:38:19 +0000
Received: from jgg by mlx with local (Exim 4.94)	(envelope-from
 <jgg@nvidia.com>)	id 1lb0VF-00D1ep-Sl; Mon, 26 Apr 2021 09:38:17 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c2170c46-5d03-4a24-f48b-08d908b02bdb
X-MS-TrafficTypeDiagnostic: DM6PR12MB3019:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3019E03A67CF3F21DD50B1BFC2429@DM6PR12MB3019.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nNVj1rhmTEedxXaBNBZ2fbaZYV9SIHm9MUTnYeOAVRUu3W1rIbWRSasdcHgiYJtQICxA5xdXK1PYzVhoZrlLCDTavBz3285VEnenxhqYDYAuIIcRmlBZyS9gAavg/nm3L+dGjR93/dXwKapu30lEPLt5//SOqJEs0GHB1RpyoHzsiGIpSviDHvgkbf30ttiX08nQLu0eLcyYLM2hp7gL4nF/jD1+qleivZg2dqndeBJrih90vxSPgNQZW0W1r2PAk3qvUzX1pl8ihvvyMU72zXB19fjwH3TbxsFtUUOGZoN+njNRaeCmH7+Y+yfOrd+QXhpKmLdoyIL/uv825UggyU0g2HgqUFFkoeU5r7hxPGYbJgSSSbSwfGDUHKVuoj+Pl2ObvEBcSabvv/5FPsL1mGVpa6B/rsAlK5nJQQVZLEtXm6w8Z3NksTYI6xoQW73TIn5ZewIzXFOFXlb2G/k5gzT0lGws8Pi+7IMBTIxpiRGaMXBOl2mQ/rzj9FnQjGtzuWf3OT1AX1RyMMTuECU4t+6ZUPImBt/EVP9O5frTx6WebgPhz29Sz3KqQm/aDEsVxCjp/8yIAjYUKVMB+KdUs9AUBMvPwCIBCruAn4bY/ZI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3834.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(376002)(39860400002)(346002)(136003)(1076003)(5660300002)(2616005)(38100700002)(2906002)(7416002)(33656002)(316002)(66476007)(66946007)(66556008)(26005)(54906003)(426003)(186003)(4326008)(83380400001)(36756003)(9786002)(6916009)(86362001)(9746002)(8936002)(8676002)(478600001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?YjEyZUN3ellURyt6cXR4Q0RiWTJiQVgrNjR0QnhpS00rbXl2bnlzOWdUN3Zj?=
 =?utf-8?B?Q0lsSW5PaWUrTDVJS3FLSDh2T09uS2JqdFMrbEhvRURhbWthMkY0QzdlMHFB?=
 =?utf-8?B?TUpNVVEvd0RtNzhtRGZib2svL1BIU0dMRXVlamJjYy9OOFFnV2VOUkN1ODNY?=
 =?utf-8?B?Z1N4MzdWY01UYUg0b1MySVlEV1JLZnRkNEJNeHlTdkd6RS9uTHBaakF0K3NE?=
 =?utf-8?B?alEwTEk2K2tOeXh0YTJySjJWV2tQZkIvSVh2NzdSYlRHa2tta0ZnSi9LNlpB?=
 =?utf-8?B?cUtjTGtjcVBHS1Z5Z2lqYWwxejVBaW91ZHArQ0IvSFlaMlUzWjUvbzF3eWpV?=
 =?utf-8?B?SnI5djJpMDc3UlpJTnpiV3o2cnF2ZE5FVDhTTzhXdzBFM3BVT2Y4a3JFN1VD?=
 =?utf-8?B?SFNJQ0VFZzlQdGRJU00yK00vZkdXM3o2QXFyZXVMYThiRnB4b0VmMEQyWDls?=
 =?utf-8?B?MHJLT2hsTlMxS0RTeG5CNlFIQ1IydUdPSUZmM3VhVUQyUHQwTURGd2d4emFp?=
 =?utf-8?B?V29KL3lWbERKRkpsN214MElhWmFYK0l2SEVsNUZtMThQSWhadHNzZ1lvclFE?=
 =?utf-8?B?Um4vT09JSy9FZzh5WTVXbXJQMXNBUytTWURTaFVEWlNyUEhRa2VBYW5vamRN?=
 =?utf-8?B?OXJHVE11WEc3ZHpsL0VieFZKeDVscCsxbFFCOVZ3YTQ2VFNRU1V5WXJYY05o?=
 =?utf-8?B?TVFXTDNjdjhaR1NwZXBvc2RmcVpzbm5YOWRNMmZYY2NES2luaG9WZVc5NS9U?=
 =?utf-8?B?bzNLU0lyVjF1VUFRMGtHdk1kQ2Y2bVNqaHZodGp1NHhZVWpIcks4ZlFFRTU0?=
 =?utf-8?B?S0pudEp4dHR3NUtjY2hEVEtWRTY4cnFERHREdzkvbm5ZY1RKWGhIaHV6ZFl2?=
 =?utf-8?B?KzJOVVNnbTdram1CZCtoaTQ2bCsybVJMcXFkSFd4dWZva2dzaXNsU0lkVDhx?=
 =?utf-8?B?L1lteEF6aTh5NzJPUDMrT09DMDIzM1hTSjR6a3l6dTlaaFFVaWtKRXU1eGlk?=
 =?utf-8?B?U0RCNFpZc1dKRWlLYk90aDlYRVE0N09GOVh1UmZ5Nk5uTVhvSm1wYmJiaE41?=
 =?utf-8?B?TjVOMXlSVFRIazBrOWlKd2tTc3hhcmIxRXFFa2NLUWRUZlduS3dZc04wcHhx?=
 =?utf-8?B?VmJoLzhIaTNBMVFWSDErUGRoaFJ0VmRzUVhlbmUxSVFYTHZkSWRTTlQvYzFE?=
 =?utf-8?B?ZThsZVV2T0VOM0FTbVpqWTJ2dGxkUHdqdHBLSFVrTlpjZ0VMZ1U4bjFCMEo5?=
 =?utf-8?B?V09nZHlpV0RiTzRmbHJHMHBnRHJETHQ1TDY3N0pvYnFISkc4TlZ4L1BUNDdv?=
 =?utf-8?B?OGxYU2V1WllZV3BBT3lMSXgrd21WRXdxV29Vb0RGSktaTFRWcDFBMkRCWHd3?=
 =?utf-8?B?S1lpVXBodUlPTGRVNmN0R0ZkRUZiaWYwTTVhK1h2MVRxYjFFU2l0bkJUb2to?=
 =?utf-8?B?cFE3WUlFWjl1OVFiSWlHZXBPbFJucmhNdmVMMm5nbjh0OFlzTTM3Q21rQTd5?=
 =?utf-8?B?cGNaVG51clgrS2JQQTNzQ0QyWmNTTHBjazYyUklEVGxPdlc3WC9CNDFhQ0k4?=
 =?utf-8?B?RWlCOFhGOEhxcFN4SEpJZVpSc1IxQkplTEltaDhQT2VKaitiSDRQcVdaK05o?=
 =?utf-8?B?czZMbzhGMUR2WUV2QmZjRGN2SFk3V3p1MjVoby8vTFRMQU5PK1hEdTA2U2Zz?=
 =?utf-8?B?L3hDK2xUMW9pdDl2bnNPWnZOUXFlcUlSMElreEU5RVQ3N0thVVBCdS95eDhH?=
 =?utf-8?Q?7UfbYxBKPd8CCsGmHvxpmJqClC2FAYMriJCf5oF?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2170c46-5d03-4a24-f48b-08d908b02bdb
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2021 12:38:19.4846 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JL5z5a0vWea9uUudvLqZ/Id4YhlxETzuOx1dK0sjaGglm9o6k1RKhhS74ilq7Af9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3019
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Li Zefan <lizefan@huawei.com>, "Jiang, Dave" <dave.jiang@intel.com>, "Raj,
 Ashok" <ashok.raj@intel.com>, Jonathan Corbet <corbet@lwn.net>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 LKML <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Tejun Heo <tj@kernel.org>,
 "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>, "Wu,
 Hao" <hao.wu@intel.com>, David Woodhouse <dwmw2@infradead.org>
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

T24gU3VuLCBBcHIgMjUsIDIwMjEgYXQgMDk6MjQ6NDZBTSArMDAwMCwgVGlhbiwgS2V2aW4gd3Jv
dGU6Cj4gPiBGcm9tOiBKYXNvbiBHdW50aG9ycGUgPGpnZ0BudmlkaWEuY29tPgo+ID4gU2VudDog
RnJpZGF5LCBBcHJpbCAyMywgMjAyMSA3OjUwIFBNCj4gPiAKPiA+IE9uIEZyaSwgQXByIDIzLCAy
MDIxIGF0IDA5OjA2OjQ0QU0gKzAwMDAsIFRpYW4sIEtldmluIHdyb3RlOgo+ID4gCj4gPiA+IE9y
IGNvdWxkIHdlIHN0aWxsIGhhdmUganVzdCBvbmUgL2Rldi9pb2FzaWQgYnV0IGFsbG93IHVzZXJz
cGFjZSB0byBjcmVhdGUKPiA+ID4gbXVsdGlwbGUgZ3BhX2lvYXNpZF9pZCdzIGVhY2ggYXNzb2Np
YXRlZCB0byBhIGRpZmZlcmVudCBpb21tdSBkb21haW4/Cj4gPiA+IFRoZW4gdGhlIGNvbXBhdGli
aWxpdHkgY2hlY2sgd2lsbCBiZSBkb25lIGF0IEFUVEFDSF9JT0FTSUQgaW5zdGVhZCBvZgo+ID4g
PiBKT0lOX0lPQVNJRF9GRC4KPiA+IAo+ID4gVG8gbXkgbWluZCB3aGF0IG1ha2VzIHNlbnNlIHRo
YXQgdGhhdCAvZGV2L2lvYXNpZCBwcmVzZW50cyBhIHNpbmdsZQo+ID4gSU9NTVUgYmVoYXZpb3Ig
dGhhdCBpcyBiYXNpY2FsbHkgdGhlIHNhbWUuIFRoaXMgbWF5IHVsdGltYXRlbHkgbm90IGJlCj4g
PiB3aGF0IHdlIGNhbGwgYSBkb21haW4gdG9kYXkuCj4gPiAKPiA+IFdlIG1heSBlbmQgdXAgd2l0
aCBhIG1pZGRsZSBvYmplY3Qgd2hpY2ggaXMgYSBncm91cCBvZiBkb21haW5zIHRoYXQKPiA+IGFs
bCBoYXZlIHRoZSBzYW1lIGNhcGFiaWxpdGllcywgYW5kIHdlIGRlZmluZSBjYXBhYmlsaXRpZXMg
aW4gYSB3YXkKPiA+IHRoYXQgbW9zdCBwbGF0Zm9ybXMgaGF2ZSBhIHNpbmdsZSBncm91cCBvZiBk
b21haW5zLgo+ID4gCj4gPiBUaGUga2V5IGNhcGFiaWxpdHkgb2YgYSBncm91cCBvZiBkb21haW5z
IGlzIHRoZXkgY2FuIGFsbCBzaGFyZSB0aGUgSFcKPiA+IHBhZ2UgdGFibGUgcmVwcmVzZW50YXRp
b24sIHNvIGlmIGFuIElPQVNJRCBpbnN0YW50aWF0ZXMgYSBwYWdlIHRhYmxlCj4gPiBpdCBjYW4g
YmUgYXNzaWduZWQgdG8gYW55IGRldmljZSBvbiBhbnkgZG9tYWluIGluIHRoZSBncnVvcCBvZiBk
b21haW5zLgo+IAo+IFNvcnJ5IHRoYXQgSSBkaWRuJ3QgcXVpdGUgZ2V0IGl0LiBJZiBhIGdyb3Vw
IG9mIGRvbWFpbnMgY2FuIHNoYXJlIHRoZSAKPiBzYW1lIHBhZ2UgdGFibGUgdGhlbiB3aHkgbm90
IGp1c3QgYXR0YWNoaW5nIGFsbCBkZXZpY2VzIHVuZGVyIHRob3NlCj4gZG9tYWlucyBpbnRvIGEg
c2luZ2xlIGRvbWFpbj8KClN1cmUsIGlmIHRoYXQgd29ya3MuIEJ1dCB5b3Ugc2hvdWxkbid0IGhh
dmUgdGhpbmdzIGxpa2UgSU9NTVVfQ0FDSEUKY3JlYXRlIGRpZmZlcmVudCBkb21haW5zIG9yIHRy
aWdnZXIgZGlmZmVyZW50IC9kZXYvaW9hc2lkJ3MKCj4gdG8gZGVzY3JpYmUgdGhlIEhXIHBhZ2Ug
dGFibGUuIElkZWFsbHkgYSBuZXcgaW9tbXUgZG9tYWluIHNob3VsZAo+IGJlIGNyZWF0ZWQgb25s
eSB3aGVuIGl0J3MgaW1wb3NzaWJsZSB0byBzaGFyZSBhbiBleGlzdGluZyBwYWdlIHRhYmxlLiAK
PiBPdGhlcndpc2UgeW91J2xsIGdldCBiYWQgaW90bGIgZWZmaWNpZW5jeSBiZWNhdXNlIGVhY2gg
ZG9tYWluIGhhcyBpdHMKPiB1bmlxdWUgZG9tYWluIGlkICh0YWdnZWQgaW4gaW90bGIpIHRoZW4g
ZHVwbGljYXRlZCBpb3RsYiBlbnRyaWVzIG1heQo+IGV4aXN0IGV2ZW4gd2hlbiBhIHNpbmdsZSBw
YWdlIHRhYmxlIGlzIHNoYXJlZCBieSB0aG9zZSBkb21haW5zLgoKUmlnaHQsIGZld2VyIGlzIGJl
dHRlcgoKPiBPciwgY2FuIHlvdSBlbGFib3JhdGUgd2hhdCBpcyB0aGUgdGFyZ2V0ZWQgdXNhZ2Ug
YnkgaGF2aW5nIGEgZ3JvdXAgb2YKPiBkb21haW5zIHdoaWNoIGFsbCBzaGFyZSB0aGUgc2FtZSBw
YWdlIHRhYmxlPwoKWW91IGp1c3QgbmVlZCB0byBoYXZlIGNsZWFyIHJ1bGUgd2hhdCB3aGF0IHJl
cXVpcmVzIGEgbmV3IC9kZXYvaW9hc2lkCkZEIC0gYW5kIGlmIGl0IG1hcHMgdG8gZG9tYWlucyB0
aGVuIGdyZWF0LgoKPiBXYW50IHRvIGhlYXIgeW91ciBvcGluaW9uIGZvciBvbmUgb3BlbiBoZXJl
LiBUaGVyZSBpcyBubyBkb3VidCB0aGF0Cj4gYW4gaW9hc2lkIHJlcHJlc2VudHMgYSBIVyBwYWdl
IHRhYmxlIHdoZW4gdGhlIHRhYmxlIGlzIGNvbnN0cnVjdGVkIGJ5IAo+IHVzZXJzcGFjZSBhbmQg
dGhlbiBsaW5rZWQgdG8gdGhlIElPTU1VIHRocm91Z2ggdGhlIGJpbmQvdW5iaW5kCj4gQVBJLiBC
dXQgSSdtIG5vdCB2ZXJ5IHN1cmUgYWJvdXQgd2hldGhlciBhbiBpb2FzaWQgc2hvdWxkIHJlcHJl
c2VudCAKPiB0aGUgZXhhY3QgcGd0YWJsZSBvciB0aGUgbWFwcGluZyBtZXRhZGF0YSB3aGVuIHRo
ZSB1bmRlcmx5aW5nIAo+IHBndGFibGUgaXMgaW5kaXJlY3RseSBjb25zdHJ1Y3RlZCB0aHJvdWdo
IG1hcC91bm1hcCBBUEkuIFZGSU8gZG9lcwo+IHRoZSBsYXR0ZXIgd2F5LCB3aGljaCBpcyB3aHkg
aXQgYWxsb3dzIG11bHRpcGxlIGluY29tcGF0aWJsZSBkb21haW5zCj4gaW4gYSBzaW5nbGUgY29u
dGFpbmVyIHdoaWNoIGFsbCBzaGFyZSB0aGUgc2FtZSBtYXBwaW5nIG1ldGFkYXRhLgoKSSB0aGlu
ayBWRklPJ3MgbWFwL3VubWFwIGlzIHdheSB0b28gY29tcGxleCBhbmQgd2Uga25vdyBpdCBoYXMg
YmFkCnBlcmZvcm1hbmNlIHByb2JsZW1zLiAKCklmIC9kZXYvaW9hc2lkIGlzIHNpbmdsZSBIVyBw
YWdlIHRhYmxlIG9ubHkgdGhlbiBJIHdvdWxkIGZvY3VzIG9uIHRoYXQKaW1wbGVtZW50YXRpb24g
YW5kIGxlYXZlIGl0IHRvIHVzZXJzcGFjZSB0byBzcGFuIGRpZmZlcmVudAovZGV2L2lvYXNpZHMg
aWYgbmVlZGVkLgoKPiBPSywgbm93IEkgc2VlIHdoZXJlIHRoZSBkaXNjb25uZWN0aW9uIGNvbWVz
IGZyb20uIEluIG15IGNvbnRleHQgaW9hc2lkCj4gaXMgdGhlIGlkZW50aWZpZXIgdGhhdCBpcyBh
Y3R1YWxseSB1c2VkIGluIHRoZSB3aXJlLCBidXQgc2VlbXMgeW91IHRyZWF0IGl0IGFzIAo+IGEg
c3ctZGVmaW5lZCBuYW1lc3BhY2UgcHVyZWx5IGZvciByZXByZXNlbnRpbmcgcGFnZSB0YWJsZXMu
IFdlIHNob3VsZCAKPiBjbGVhciB0aGlzIGNvbmNlcHQgZmlyc3QgYmVmb3JlIGZ1cnRoZXIgZGlz
Y3Vzc2luZyBvdGhlciBkZXRhaWxzLiDwn5iKCgpUaGVyZSBpcyBubyBnZW5lcmFsIEhXIHJlcXVp
cmVtZW50IHRoYXQgZXZlcnkgSU8gcGFnZSB0YWJsZSBiZQpyZWZlcnJlZCB0byBieSB0aGUgc2Ft
ZSBQQVNJRCBhbmQgdGhpcyBBUEkgd291bGQgaGF2ZSB0byBzdXBwb3J0Cm5vbi1QQVNJRCBJTyBw
YWdlIHRhYmxlcyBhcyB3ZWxsLiBTbyBJJ2Qga2VlcCB0aGUgdHdvIHRoaW5ncwpzZXBhcmF0ZWQg
aW4gdGhlIHVBUEkgLSBldmVuIHRob3VnaCB0aGUga2VybmVsIHRvZGF5IGhhcyBhIGdsb2JhbApQ
QVNJRCBwb29sLgoKPiBUaGVuIGZvbGxvd2luZyB5b3VyIHByb3Bvc2FsLCBkb2VzIGl0IG1lYW4g
dGhhdCB3ZSBuZWVkIGFub3RoZXIKPiBpbnRlcmZhY2UgZm9yIGFsbG9jYXRpbmcgUEFTSUQ/IGFu
ZCBzaW5jZSBpb2FzaWQgbWVhbnMgZGlmZmVyZW50Cj4gdGhpbmcgaW4gdUFQSSBhbmQgaW4ta2Vy
bmVsIEFQSSwgcG9zc2libHkgYSBuZXcgbmFtZSBpcyByZXF1aXJlZCB0bwo+IGF2b2lkIGNvbmZ1
c2lvbj8KCkkgd291bGQgc3VnZ2VzdCBoYXZlIHR3byB3YXlzIHRvIGNvbnRyb2wgdGhlIFBBU0lE
CgogMSkgT3ZlciAvZGV2L2lvYXNpZCBhbGxvY2F0ZSBhIFBBU0lEIGZvciBhbiBJT0FTSUQuIEFs
bCBmdXR1cmUgUEFTSUQKICAgIGJhc2VkIHVzYWdlcyBvZiB0aGUgSU9BU0lEIHdpbGwgdXNlIHRo
YXQgZ2xvYmFsIFBBU0lECgogMikgT3ZlciB0aGUgZGV2aWNlIEZELCB3aGVuIHRoZSBJT0FTSUQg
aXMgYm91bmQgcmV0dXJuIHRoZSBQQVNJRCB0aGF0CiAgICB3YXMgc2VsZWN0ZWQuIElmIHRoZSBJ
T0FTSUQgZG9lcyBub3QgaGF2ZSBhIGdsb2JhbCBQQVNJRCB0aGVuIHRoZQogICAga2VybmVsIGlz
IGZyZWUgdG8gbWFrZSBzb21ldGhpbmcgdXAuIEluIHRoaXMgbW9kZSBhIHNpbmdsZSBJT0FTSUQK
ICAgIGNhbiBoYXZlIG11bHRpcGxlIFBBU0lEcy4KClNpbXBsZSB0aGluZ3MgbGlrZSBEUERLIGNh
biB1c2UgIzIgYW5kIHBvdGVudGlhbGx5IGhhdmUgYmV0dGVyIFBBU0lECmxpbWl0cy4gaHlwZXJ2
aXNvcnMgd2lsbCBtb3N0IGxpa2VseSBoYXZlIHRvIHVzZSAjMSwgYnV0IGl0IGRlcGVuZHMgb24K
aG93IHRoZWlyIHZJT01NVSBpbnRlcmZhY2Ugd29ya3MuCgpJIHRoaW5rIHRoZSBuYW1lIElPQVNJ
RCBpcyBmaW5lIGZvciB0aGUgdUFQSSwgdGhlIGtlcm5lbCB2ZXJzaW9uIGNhbgpiZSBjYWxsZWQg
aW9hc2lkX2lkIG9yIHNvbWV0aGluZy4KCihhbHNvIGxvb2tpbmcgYXQgaW9hc2lkLmMsIHdoeSBk
byB3ZSBuZWVkIHN1Y2ggYSB0aGluIGFuZCBvZGQgd3JhcHBlcgphcm91bmQgeGFycmF5PykKCkph
c29uCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11
IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xp
c3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
