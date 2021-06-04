Return-Path: <SRS0=eMD9=K6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED586C47425
	for <iommu@archiver.kernel.org>; Fri,  4 Jun 2021 16:22:13 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A032C61009
	for <iommu@archiver.kernel.org>; Fri,  4 Jun 2021 16:22:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A032C61009
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6D95560795;
	Fri,  4 Jun 2021 16:22:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IE4_ZaolIjmT; Fri,  4 Jun 2021 16:22:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9F3D0607AA;
	Fri,  4 Jun 2021 16:22:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8AD69C000E;
	Fri,  4 Jun 2021 16:22:08 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C7F5FC0001
 for <iommu@lists.linux-foundation.org>; Fri,  4 Jun 2021 16:22:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B666E843DD
 for <iommu@lists.linux-foundation.org>; Fri,  4 Jun 2021 16:22:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cvO-ay8T7by1 for <iommu@lists.linux-foundation.org>;
 Fri,  4 Jun 2021 16:22:03 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2089.outbound.protection.outlook.com [40.107.244.89])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6CB3A83DD5
 for <iommu@lists.linux-foundation.org>; Fri,  4 Jun 2021 16:22:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OM87wg96pX3HYhy79916tX6U3Va//ndbTlhFxyVQEGNtpH7HeeHJCrENC+TNPLelsHI7tZyjsiF9iuSxOFv2YAbH/0eaR4W+WzvNNXk0YSClwgBxxmQNaW2iwTJ61esxZCftxHLG6yKQEBQ0ytPKtbXjmJcwqxIe3jasVPoj7mPA1Gw6cki/y0XaBkhRlF8KqspWL5zlGynFYNfwt/RJQOyaCNr0jMMa8AY+a9LVBf/EzsIReI4YA4PmSugzgdLcaZw42ntTaMiyri7Lby/10tpEtkza7B1E4Z2Hiyd5skzhjfJnKGMvIVXuvlOiPTlIvwLQQqMKOx45RDb5RLT24Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lXvrsT7NEXTPaNfq1NhAo2T1ImtgwQLu5twOJd6mOkI=;
 b=bmovn+0vICGxrA8/CQ1CVRbuO+0LrsfeuQQ3R7jC/wF9RXbOM0b1xsH20c5boWL3QyDDfE8AjcnWD/ln73k92UmpiXs9nMVDcoYO5rSrhCpQho2tJ21YDymeRnJo4dRnVrJpEeW+62stRxGEjmS1aOmj2Guys4wZ6/NWLuxJ9skQWnTvUlJHY2ReLgaV2zmNfKVkVYi7bVOAb9+FKavwpEpZXmzx2I/fHc+Ozinys4wIUFc97Q9OBA/aVv8vti3CvRE9HPZnF8qX7pqKiAuczUhcEIs/8sKPf9XMJpKn+AHysgFxbrsf3Mz1BrhmeT1wOSMrwuR5hmL/LSSoUVZtDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lXvrsT7NEXTPaNfq1NhAo2T1ImtgwQLu5twOJd6mOkI=;
 b=hUZGOjrW+4KELOQHIkQS8mILN4fy+PudKuyHNNmX0RTqCPBgsGn1K8/HD39ILnT3tl/G67/ZowdgZZSaH+HvEb83PJMvdyYwchq2cFfPmZ2v6s75mIo2b0VEYG7bqUXc+qY1OxSLkSDIjiMxRFtVvuJFLJNZp6sIYI9ArUM+7gdRUIuKNdofPRZ4C/ZVVc0pSWoug6qhum7NkwyH+jmfL9VGyvhqvl2dWj+qy4VFFu67aO44GPUfuk5GuIpKwikMrKveE+4xUZRwpK7Qu92jc9s48AzN6waKl9nfai+1Xg2pgc5agCNJfCbx9WBr30SJogZWy63eZO32PnBfmuHrgA==
Authentication-Results: linux.intel.com; dkim=none (message not signed)
 header.d=none; linux.intel.com; dmarc=none action=none header.from=nvidia.com; 
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5111.namprd12.prod.outlook.com (2603:10b6:208:31b::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24; Fri, 4 Jun
 2021 16:22:01 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%6]) with mapi id 15.20.4195.024; Fri, 4 Jun 2021
 16:22:01 +0000
Date: Fri, 4 Jun 2021 13:22:00 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [RFC] /dev/ioasid uAPI proposal
Message-ID: <20210604162200.GA415775@nvidia.com>
References: <MWHPR11MB1886422D4839B372C6AB245F8C239@MWHPR11MB1886.namprd11.prod.outlook.com>
 <c9c066ae-2a25-0799-51a7-0ca47fff41a1@huawei.com>
 <aa1624bf-e472-2b66-1d20-54ca23c19fd2@linux.intel.com>
 <ed4f6e57-4847-3ed2-75de-cea80b2fbdb8@huawei.com>
 <01fe5034-42c8-6923-32f1-e287cc36bccc@linux.intel.com>
 <20210601173323.GN1002214@nvidia.com>
 <23a482f9-b88a-da98-3800-f3fd9ea85fbd@huawei.com>
 <20210603111914.653c4f61@jacob-builder>
 <1175ebd5-9d8e-2000-6d05-baa93e960915@redhat.com>
 <20210604092243.245bd0f4@jacob-builder>
Content-Disposition: inline
In-Reply-To: <20210604092243.245bd0f4@jacob-builder>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: BL0PR0102CA0003.prod.exchangelabs.com
 (2603:10b6:207:18::16) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by
 BL0PR0102CA0003.prod.exchangelabs.com (2603:10b6:207:18::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4195.15 via Frontend Transport; Fri, 4 Jun 2021 16:22:00 +0000
Received: from jgg by mlx with local (Exim 4.94)	(envelope-from
 <jgg@nvidia.com>)	id 1lpCa8-001kBE-0O; Fri, 04 Jun 2021 13:22:00 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 04a94f8b-7e5b-4d88-8e4d-08d92774e1c3
X-MS-TrafficTypeDiagnostic: BL1PR12MB5111:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB5111733A352B90D66A1A4376C23B9@BL1PR12MB5111.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FVC6tp3/pGH63a5kLumwVUp+GJqVWirS+ecTG934AIxsJkir3ZBtbyrhdecjEz+zzt6mMhgxgkXwO9kqTIMNEAg3tob7H22rByhFWhohlcsdP2GrKiZHjJvuFVa2JoqfYhzg37t9buDy1FYSsmDEvskVRJY3ulv1BMrtBF8eUf4bbuSWI4aC1LLSkCWt417Gxg9zjY8Ovhg1rrdmu5V4Fu1vhWSsR8MVOj52ss8wdT/U3f4YSqc4wskTMBxHRD2xo/mPbhlhsiHtPTgwEiGGuRzXrdrvIy5dDUZ/M68+QcvJWrjU1qURFhdg0o6+PhHkzMAXwnHkSMep6Yq4JOVadyq1lUsoFt2O4uo0uS7lOl57DG8InUFra89v0NqnDynLYl7Ok9UrphuisXUEF3BkYPBDSsdq8wUID+lwz3LQp5u8wLP/9LU/9fKqPG0LsS3kR1qjc4hJ0cOke+NNtTUVGZursO6k9vNXBgAxgA4WZkVk5ubXAQtM1gz3W9yK+o6qD62HVB+8xOcRpvmMTtCaHGh1vOpTu52O0a/t1i5N6wgD3VoamFxtF6XH7hneC8WpSTtgILaKiWJAU+zdRNTRGrjosUte8TFuM2L8G+aa9u9ZPAGV1LXQjeNmTRjeX/BSU0QerMwm1ZDsaEih1VemWw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB5506.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(396003)(346002)(39850400004)(366004)(136003)(36756003)(316002)(83380400001)(9746002)(6916009)(5660300002)(1076003)(2906002)(33656002)(7416002)(9786002)(8936002)(478600001)(53546011)(54906003)(66556008)(66476007)(2616005)(38100700002)(66946007)(86362001)(8676002)(426003)(4326008)(26005)(186003)(27376004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?UVVsaGZPQXVYdzRsOWFjWVBodEZyRE4zQ0hFcjlKWFRvTHVqakljdW1xTkdR?=
 =?utf-8?B?bkZxZ1crc1EzWDZFYjR3aURaRHpuaDlRbE9adTR3NkZYNXdabk5HWGRjUnUz?=
 =?utf-8?B?N0VyNUdzU2ZaWENYb0JJN3RpMmU3eWxCYThOR0JObjM0Rm92NStpd1dJSi9W?=
 =?utf-8?B?R01lUGRYTGFJcHp3TER6Qm9ybCs2eHRRRDBFTC9FZ2ZFWFRjOWlKWlFQR3Iw?=
 =?utf-8?B?Um5kcURHQnpxOEFGOUVQWVhkRDJlbDFHNzdpL29acVd3UUxZb3laQWx5RXVr?=
 =?utf-8?B?VUVTS01BdnFDRDIxUTduR2puTytTSEdvb1ZXL1Exay9rV3VzVjdJWHRLV1No?=
 =?utf-8?B?Sk8wOGg4dk9OMlJkVjlmcG1wU0xqcVpEMStJc0o3djJmeGJ6YWNVait5RDc2?=
 =?utf-8?B?WnZJUGgreHUvTE03MjJCR1BaTUVFeEtxSitTVk93Mm5vQWpzY1A1YjZ6a0h0?=
 =?utf-8?B?RmNmSVVnODlrWUZxcHJSc2tGdkZyNDVSdHlkb1B5ZStxVlBObUtmbnl4UW1J?=
 =?utf-8?B?cFRHR2E4a0liaFgxNlNqYzM2UllkWXNuK09TK0xMY0pRa0tqYnV1Y1F6WjZI?=
 =?utf-8?B?bTd2K1ovVDhPOTgvNFczV0dqVFF0VzFmRGttTlBDcDVrMGpibTVESXVlbTcx?=
 =?utf-8?B?aUFxdWVxYzN5R2MyeFkvR0hHWWJZZ2FSb3lDUExMQTZrK2FmWThJNW9adkpB?=
 =?utf-8?B?UnNxckxDVDNXY2xFSDB0K1BvSDF4MUloWU5zYXdpSVowT1RsQS9jTlRSMlFN?=
 =?utf-8?B?Z1NhaUY2emlVNjcveE9ERHFQa1lIdnNydkR0NnFsdXRXd2ROOEpHMW92Mnk4?=
 =?utf-8?B?bGZkUlRWdWZUNklNM3JqUWV4NGlzM2xWcXNxcng2K0F6NlBqMGJDV2hsZEk1?=
 =?utf-8?B?YjJOMHIwVnJuVkZMMDhJUHFDUmpSdXN4cm1PY3BKUmZLdktISTRjUmdxcEF0?=
 =?utf-8?B?WXhjOWxCTWU4NzVhaVR6TmNJaTVtREFMZWNyR3NvcE5wZEVEQnZkZDJrdTJT?=
 =?utf-8?B?ajV2ZEpFazRwVzZJaGtnU0hiR1JjSERSUkNrYXVXZmFoZVptSkJnSXIyWWY3?=
 =?utf-8?B?TWtJQ1FQaEVnMWM3MEtwOWlOemF0bjA3MTY3YlpsSFo2Wmg2WnhjZVBXRjVB?=
 =?utf-8?B?UTVqYUZiUVdaTzNIUHBScUdLQVFJcFVvTzVFMUs0aDBKSUp2b1kva21LYzh6?=
 =?utf-8?B?OWxvQmFVTnZpaDRkRW1VTjVJYUxid2swM3BTM3pyeld1cTFFZ2h3OGt1VFVE?=
 =?utf-8?B?aDQrWnNhU211dGowRkZ0citFMG9hSHo4U254ZDVIL1JhbnNvaUtZUHl0czFQ?=
 =?utf-8?B?Y0VvTXh4N0VVZFc3anUrYW4zZjA4VGhUQ09rTmRlS1NUeVlmODhmU2dHNUpj?=
 =?utf-8?B?REczUGdOUTBwdFlKSzVYL2FIQUg5dXRRa3REdldtMElUQnNpeUpNYlhxVFdD?=
 =?utf-8?B?MXBueXZCQjZCd0dINDRlVHJBb2cwR1F5NHZGbXQ4WHBCM0hIK0d3RkQxQ2x1?=
 =?utf-8?B?YzFUQmhUbTV0bHd3dGlBNTlSS3JGbmF1d0RLZDh1cXNlbEZneUZGR01oQy9m?=
 =?utf-8?B?SFkvU05qeVQ1bTNCakluakZCaXQ1NkpSdTczLzF5WkxVSWRzeUtqZnFxV2cr?=
 =?utf-8?B?QnpyRW9TZVpIa1VSRDdHbEJKdW1qRnFlV3BUeW81Q215emM4VVZ5NjkwUzdv?=
 =?utf-8?B?bnkzRlVKZ0oweTB5bFY0cXlXVmJuOG1yUTdvL2FTVmUwUjRmMEZ3SUlRRmFa?=
 =?utf-8?Q?wXHz/O0wGQjhhJDwcCY9QTomcLzEo+ofkaUVv3Z?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04a94f8b-7e5b-4d88-8e4d-08d92774e1c3
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2021 16:22:00.9504 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PVbx8KP1EhEEIQy8/xjptmY5qrilNjEv4rzjt8eLLY1H4cZuLYCRFui+vhM8K1pq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5111
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Jason Wang <jasowang@redhat.com>, Kirti Wankhede <kwankhede@nvidia.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>, "Jiang,
 Dave" <dave.jiang@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 Jonathan Corbet <corbet@lwn.net>,
 "wanghaibin.wang@huawei.com" <wanghaibin.wang@huawei.com>, "Tian,
 Kevin" <kevin.tian@intel.com>,
 "Alex Williamson \(alex.williamson@redhat.com\)" <alex.williamson@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 David Woodhouse <dwmw2@infradead.org>, LKML <linux-kernel@vger.kernel.org>,
 Shenming Lu <lushenming@huawei.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Robin Murphy <robin.murphy@arm.com>
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

T24gRnJpLCBKdW4gMDQsIDIwMjEgYXQgMDk6MjI6NDNBTSAtMDcwMCwgSmFjb2IgUGFuIHdyb3Rl
Ogo+IEhpIEphc29uLAo+IAo+IE9uIEZyaSwgNCBKdW4gMjAyMSAwOTozMDozNyArMDgwMCwgSmFz
b24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gCj4gPiDlnKggMjAyMS82LzQg
5LiK5Y2IMjoxOSwgSmFjb2IgUGFuIOWGmemBkzoKPiA+ID4gSGkgU2hlbm1pbmcsCj4gPiA+Cj4g
PiA+IE9uIFdlZCwgMiBKdW4gMjAyMSAxMjo1MDoyNiArMDgwMCwgU2hlbm1pbmcgTHUgPGx1c2hl
bm1pbmdAaHVhd2VpLmNvbT4KPiA+ID4gd3JvdGU6Cj4gPiA+ICAKPiA+ID4+IE9uIDIwMjEvNi8y
IDE6MzMsIEphc29uIEd1bnRob3JwZSB3cm90ZTogIAo+ID4gPj4+IE9uIFR1ZSwgSnVuIDAxLCAy
MDIxIGF0IDA4OjMwOjM1UE0gKzA4MDAsIEx1IEJhb2x1IHdyb3RlOgo+ID4gPj4+ICAgICAgCj4g
PiA+Pj4+IFRoZSBkcml2ZXJzIHJlZ2lzdGVyIHBlciBwYWdlIHRhYmxlIGZhdWx0IGhhbmRsZXJz
IHRvIC9kZXYvaW9hc2lkCj4gPiA+Pj4+IHdoaWNoIHdpbGwgdGhlbiByZWdpc3RlciBpdHNlbGYg
dG8gaW9tbXUgY29yZSB0byBsaXN0ZW4gYW5kIHJvdXRlCj4gPiA+Pj4+IHRoZSBwZXItIGRldmlj
ZSBJL08gcGFnZSBmYXVsdHMuICAKPiA+ID4+PiBJJ20gc3RpbGwgY29uZnVzZWQgd2h5IGRyaXZl
cnMgbmVlZCBmYXVsdCBoYW5kbGVycyBhdCBhbGw/ICAKPiA+ID4+IEVzc2VudGlhbGx5IGl0IGlz
IHRoZSB1c2Vyc3BhY2UgdGhhdCBuZWVkcyB0aGUgZmF1bHQgaGFuZGxlcnMsCj4gPiA+PiBvbmUg
Y2FzZSBpcyB0byBkZWxpdmVyIHRoZSBmYXVsdHMgdG8gdGhlIHZJT01NVSwgYW5kIGFub3RoZXIK
PiA+ID4+IGNhc2UgaXMgdG8gZW5hYmxlIElPUEYgb24gdGhlIEdQQSBhZGRyZXNzIHNwYWNlIGZv
ciBvbi1kZW1hbmQKPiA+ID4+IHBhZ2luZywgaXQgc2VlbXMgdGhhdCBib3RoIGNvdWxkIGJlIHNw
ZWNpZmllZCBpbi90aHJvdWdoIHRoZQo+ID4gPj4gSU9BU0lEX0FMTE9DIGlvY3RsPwo+ID4gPj4g
IAo+ID4gPiBJIHdvdWxkIHRoaW5rIElPQVNJRF9CSU5EX1BHVEFCTEUgaXMgd2hlcmUgZmF1bHQg
aGFuZGxlciBzaG91bGQgYmUKPiA+ID4gcmVnaXN0ZXJlZC4gVGhlcmUgd291bGRuJ3QgYmUgYW55
IElPIHBhZ2UgZmF1bHQgd2l0aG91dCB0aGUgYmluZGluZwo+ID4gPiBhbnl3YXkuCj4gPiA+Cj4g
PiA+IEkgYWxzbyBkb24ndCB1bmRlcnN0YW5kIHdoeSBkZXZpY2UgZHJpdmVycyBzaG91bGQgcmVn
aXN0ZXIgdGhlIGZhdWx0Cj4gPiA+IGhhbmRsZXIsIHRoZSBmYXVsdCBpcyBkZXRlY3RlZCBieSB0
aGUgcElPTU1VIGFuZCBpbmplY3RlZCB0byB0aGUKPiA+ID4gdklPTU1VLiBTbyBJIHRoaW5rIGl0
IHNob3VsZCBiZSB0aGUgSU9BU0lEIGl0c2VsZiByZWdpc3RlciB0aGUgaGFuZGxlci4KPiA+ID4g
IAo+ID4gCj4gPiAKPiA+IEFzIGRpc2N1c3NlZCBpbiBhbm90aGVyIHRocmVhZC4KPiA+IAo+ID4g
SSB0aGluayB0aGUgcmVhc29uIGlzIHRoYXQgQVRTIGRvZXNuJ3QgZm9yYmlkIHRoZSAjUEYgdG8g
YmUgcmVwb3J0ZWQgdmlhIAo+ID4gYSBkZXZpY2Ugc3BlY2lmaWMgd2F5Lgo+IAo+IFllcywgaW4g
dGhhdCBjYXNlIHdlIHNob3VsZCBzdXBwb3J0IGJvdGguIEdpdmUgdGhlIGRldmljZSBkcml2ZXIg
YSBjaGFuY2UKPiB0byBoYW5kbGUgdGhlIElPUEYgaWYgaXQgY2FuLgoKSHVoPwoKVGhlIGRldmlj
ZSBkcml2ZXIgZG9lcyBub3QgImhhbmRsZSB0aGUgSU9QRiIgdGhlIGRldmljZSBkcml2ZXIgbWln
aHQKaW5qZWN0IHRoZSBJT1BGLgoKSmFzb24KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZv
dW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2lvbW11
