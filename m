Return-Path: <SRS0=1MD/=LF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_RED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CC6AC48BDF
	for <iommu@archiver.kernel.org>; Fri, 11 Jun 2021 00:37:35 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29F4261357
	for <iommu@archiver.kernel.org>; Fri, 11 Jun 2021 00:37:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29F4261357
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id ED7DA828B5;
	Fri, 11 Jun 2021 00:37:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jfE_yTEVkroW; Fri, 11 Jun 2021 00:37:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id E411182864;
	Fri, 11 Jun 2021 00:37:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AB081C000E;
	Fri, 11 Jun 2021 00:37:33 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 39FBFC000B
 for <iommu@lists.linux-foundation.org>; Fri, 11 Jun 2021 00:37:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 14292401EF
 for <iommu@lists.linux-foundation.org>; Fri, 11 Jun 2021 00:37:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FdVujgkocwXg for <iommu@lists.linux-foundation.org>;
 Fri, 11 Jun 2021 00:37:30 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on20614.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8d::614])
 by smtp2.osuosl.org (Postfix) with ESMTPS id F1FEF401B9
 for <iommu@lists.linux-foundation.org>; Fri, 11 Jun 2021 00:37:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gE0ccfk96/kVcJWQcj1rEgdHtyNSjDpaY8RGV1YNyDHzBsQieQFKfkOUl7rnyYZm9ccTeeYQWTb4Yk9oJ8Xn/M7ush+aLvBj+2kMC09qUWMTbze7sXHI+8WalCCYZf/+vL7Zu/yuH6+uFMLDl84B03gVuhSjMNNuWbXLtMDSOy4C2nUVJSvBWly67XEeZ49XHrYTLw8/qllz5cnAHBl2Jg4KbiTF9sJ0ATXoHo6vCD25RdRGfMHerfJfNalAGzE0Jumc2b81+wJWx+iD1xTycM3DlY9ZbViq9bbuV1z8rhWQSR1HvnNcUjg49ZYYnZMEaDHhPjvCHjwf/SsFsFqNAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GoiCu82qVBGBjCcV+qKodYol4zynnQNjwbimZNFDGXA=;
 b=dD76Zwz0afsTk4LvrJXiyvGAfdW1vqu+dOwWD0XiSSLHULWE0kj1aeoBSg3J6X0CYmY29/GcwRnhEyl1pNFMmx1w4gsgLcSfskLykY+iTZj61KZ9IXYElQDYwGKHBxYWOeYa4FOrAGpKPYck8EiOhQoObuZsse+oBZtffDAEL3vJ7dWPG/5n+SuXgnlLorSsVnBaTwXa4oT1M0tWVdaLUP7zYRsZobTmAkgzSrVtJJf6UTktmUAZBDuiZ3Hqau6yZwcW20A7pLRmfzzjrrJQ3qHZVuIz86AHqwGh6R4tOeuWxwiaxZtdcgCbwUVYsPv2xpcrcb4UdaoWBxxxelGScw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GoiCu82qVBGBjCcV+qKodYol4zynnQNjwbimZNFDGXA=;
 b=KVTsOgsshLFqP3b3mexwektolnJPLxFV+K/OORTJdC4KknXZzPs9DYpBgY70dVrYxFQq28HyjcVEf8tMXeMFUR1jKDNrBgIIPzRyWeVoqAKxMm+psGVNO61/FW9uNGQd1tVWfYzBDAM8wYPr8EkMS6AUx6+/lKzAarsyqdhp7plAj8ErqR798H08m3NJO0hGU/7+tIQJuj8p8bC/Gl93vkr1+bcVMSPB8aDko0oxV/zy7XIg8EUMG9GXFaPGIRB3AGHsnj3C0fSRrYbJZWqDXiBqAJ5mpIvoCHB5pBydLk8kYeYRKaaz7LXhOvXMQXfE1ntpPUlcTDBh/wPqCefetA==
Received: from BY5PR12MB3764.namprd12.prod.outlook.com (2603:10b6:a03:1ac::17)
 by BY5PR12MB4322.namprd12.prod.outlook.com (2603:10b6:a03:20a::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24; Fri, 11 Jun
 2021 00:37:24 +0000
Received: from BY5PR12MB3764.namprd12.prod.outlook.com
 ([fe80::d05:4bca:ea51:15af]) by BY5PR12MB3764.namprd12.prod.outlook.com
 ([fe80::d05:4bca:ea51:15af%6]) with mapi id 15.20.4219.023; Fri, 11 Jun 2021
 00:37:24 +0000
From: Krishna Reddy <vdumpa@nvidia.com>
To: Robin Murphy <robin.murphy@arm.com>, Sai Prakash Ranjan
 <saiprakash.ranjan@codeaurora.org>
Subject: RE: [PATCH] iommu/io-pgtable-arm: Optimize partial walk flush for
 large scatter-gather list
Thread-Topic: [PATCH] iommu/io-pgtable-arm: Optimize partial walk flush for
 large scatter-gather list
Thread-Index: AQHXXT84btg0466hEE2rkvq94oyuZasMBHAAgACy+QCAAD6WAIAAB6mAgAAg2ACAAAWcgIAAPESAgACQdxA=
Date: Fri, 11 Jun 2021 00:37:24 +0000
Message-ID: <BY5PR12MB37646698F37C00381EFF7C77B3349@BY5PR12MB3764.namprd12.prod.outlook.com>
References: <20210609145315.25750-1-saiprakash.ranjan@codeaurora.org>
 <dbcd394a-4d85-316c-5dd0-033546a66132@arm.com>
 <c600e9b2534d54082a5272b508a7985f@codeaurora.org>
 <35bfd245-45e2-8083-b620-330d6dbd7bd7@arm.com>
 <12067ffb8243b220cf03e83aaac3e823@codeaurora.org>
 <266f190e-99ae-9175-cf13-7a77730af389@arm.com>
 <dfdabcdec99a4c6e3bf2b3c5eebe067f@codeaurora.org>
 <61c69d23-324a-85d7-2458-dfff8df9280b@arm.com>
In-Reply-To: <61c69d23-324a-85d7-2458-dfff8df9280b@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=nvidia.com;
x-originating-ip: [216.228.112.22]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a9f980b3-1c9d-4733-7fed-08d92c71152d
x-ms-traffictypediagnostic: BY5PR12MB4322:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB4322F52D979E48BFDE3E79F4B3349@BY5PR12MB4322.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XmsM6MIPMK5pMy21VxMzMEDd+965bLWFExJp+Gnsjbks3KLWIsEa9HUQQjTK1TypORsadL/lNT/ENnxH+64ccdRZV2+/FHGK2lCPjDytNmu4g2pVAGI9LrTwP5Z0QKdTYDRDjIsYTMRKMY9dL7etysxErywED4JaSgp0wEmNY/26FLKYN9WN1YsNLh/Rj2LmKYp4A5qwT5Z0WktrSUAMEcUU7f3+kA9Za/vIsAttVXEEtjcbsMTLXJAwgYPnftXn5geNS5v2saWciHqM8Fe7zF7axXta6kwm7MfLr6zjj2kN34HuDhUKJ8o+SOZPznlEv/HchcNURbJsCazYU3CeCpBRqprGloFLGiu87QHacAaAmdkAsaXcjdp7whFcHvEulFHMo8dzkJQPbjMolPYl3o3NuRQ7NKo3qnlwxUQnP5Cbp6hZAol+hsoymVkD8L82ufcXJwWRhC/oQXBT9DKPc3vAYkW1nFF8aKQM3uMU1vufZUNlwZM6/FB+rgwy9vH+FGv5ojOYgvwRUXdDnJJMZ6ttYPT68xQolNADch9Sgs16RgSTtqkSiXUWURBkBAVR5tGIbi8V+7q1rocvSZM56YnNHFCKraRJEMxzSKgmXxQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB3764.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(346002)(376002)(39860400002)(396003)(9686003)(7696005)(55016002)(66556008)(64756008)(66446008)(26005)(66476007)(86362001)(66946007)(2906002)(76116006)(478600001)(8936002)(8676002)(4326008)(110136005)(54906003)(107886003)(186003)(52536014)(38100700002)(6506007)(33656002)(83380400001)(316002)(122000001)(5660300002)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cWIvZ2Z0MGtBdG84R1p4RC9VdkJSZnQrOE0vVytZbjZqTU8yelBWemY3UU1i?=
 =?utf-8?B?T0ozVVp3OHRmcXB5RHNuOWNpYVRJcS9IWEN5Z1NYcnhKbEJ0MmVWUG50dC9p?=
 =?utf-8?B?RmoyZUhqOUcwVWhOMzYxOE1JVUp2cFIwSmthNlRwWnlPcGg3SnZoaTFYNUJv?=
 =?utf-8?B?amhVRFdSRVRqQ2dET2VURDcyVDZiMkJNeDgzOVdWeGE1VTBjcGFwbkN3dHQr?=
 =?utf-8?B?bGxva09LNnJ4R0VjeU9rZjRhSk1ybVo5SEVJTGg3ZXI2a1hUTXpPRFE1RUhn?=
 =?utf-8?B?Q1h5VXkxN01MOXAwM3pMQnJFNmdJZVRlS0UveCs3SDVWdXozZy9BUmFyL21L?=
 =?utf-8?B?aVN1ZEhPUjBWZnhHYjl2MG5sbllWZFlRQzRjWHpDZ1Z3NDNzNmV6OGdSbXJE?=
 =?utf-8?B?SlNyWGdleGxIcGswOEZZNkxiMjRaVVZWMzFiclNaTGJYYVpKRGFMaGh1djhl?=
 =?utf-8?B?N24zL200em9LTEdEQ2JZZlhZSG0xOW9FSHE1cmhuTXVwL01UNXJSTDVWRjJm?=
 =?utf-8?B?dWxjemtzY0FpclJmWTVsRE82eVpESkIyR0ZRODNES09qNTVGdEtGMXMvbU1u?=
 =?utf-8?B?K3doejVHeXA2bGZTaWR3eEluTU1IM1ZDQjhiMFA5VE5KY2RmRHc3YjRxWHpm?=
 =?utf-8?B?alQzcHdZVVNzT1ErclF3TmpkV3F1Y1ZWVDUyZklzR2RoL25SL3JUblpDSTVF?=
 =?utf-8?B?eW83NHJqcVdnMk56K1l4amZ0VkZCREZWeStDWHpaR0E5R2Z6YWtpd0dXOGNn?=
 =?utf-8?B?dmsydGIrUUthR1NPQmlKSG9sVGRkOVVwVlBiT0ZobWZoc29aR3JDZXpRaS94?=
 =?utf-8?B?WHdmWEJiVmtzVG5scUk4Qnc5Y2FOQlZTa3NGV1M3c3lPR2VRelV5Snk3THcw?=
 =?utf-8?B?S3FCNDR1NDNSWUZKWitMQXFCanZKTWtxYld5a2tFVEtraE5SVE40TDRVcGZR?=
 =?utf-8?B?SG9KS0Y2dk56NGErTy8xMTBicGdLcDVDd0t5SEQzUUR6QVpiVnQ5TytaL3Js?=
 =?utf-8?B?MGp1OU9SaTc5VDlyd042aGF1ZDFrek5VaEFnZkNtNVZkVllXVjJOTzJlQmdE?=
 =?utf-8?B?Y0UxcExBVmExbjhGNHh2RmExK3BpYk9RQlBxdUNWYmN4elZXMk4vK0Z1dzlU?=
 =?utf-8?B?ZTc5L0l5R0FtelJPUUI4enI3U3UwUzZBaEY3NjFvaWUzakhmRzRjQWpDNlBJ?=
 =?utf-8?B?NjhzODhWUVREYXM2L2ZwTlJXS05ScjdrU1RnbjdGWFdBWTJLWlQwTFp0a1pP?=
 =?utf-8?B?bUVVaE5zQlhSWEQyRjQremN4Z3Z6ajFjWXlqMzUzd1EzRy9jSUFBUHdoVEhM?=
 =?utf-8?B?UmVvb01kSTUyUFJjSTJKbnFHSTJwODAwSHY2SjFiR2FRWmh3NEZtQWFiRzhT?=
 =?utf-8?B?NS83UTFvVFA5MFljdlpTYkd0MW1iMUtibGhmWUhZSkFyVzJYS3QvN2ZpaXR4?=
 =?utf-8?B?Zy9KMjRxWURJZlVxSlhySnJQalR0OVBxOXNvWkpKaG1FSzhtWE0xKzRIOWRq?=
 =?utf-8?B?NG13bjA3SVRiSDJKUktRQkloaERjbW5CbCs0RWhQVzFqc2JIdzZTanhRUlhh?=
 =?utf-8?B?cU9JQmpBZmNoUXpZZlRPZk11ajlucTlIMzBRcW5vZ2ttL0lkV2FEeXRNcmFn?=
 =?utf-8?B?NHhWNjdvR0hWZkY4WXFrdjFheG9KbURjYlRkK1Zrd3dMb0Q3WVduOU5WbnZR?=
 =?utf-8?B?azhwOW9PMzgrc3FWbUdpMnVuOEJ3ZnY0QWxsYjRvWmVPZVV4aHlacTRQcFMz?=
 =?utf-8?Q?hOGm3cga1nkADt6atwRQApRsKb0/8HWaBRAjR5H?=
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3764.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9f980b3-1c9d-4733-7fed-08d92c71152d
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2021 00:37:24.5946 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Aqvr7hqEOUFVdljp8+bGkD8LmBcL3d4gbnYFFG8TH4NMMgYU3k+QnHawUQPAWvLhnOgryDRISqw2ceqZxFjbbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4322
Cc: "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Thierry Reding <treding@nvidia.com>, Will Deacon <will@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
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

> > No, the unmap latency is not just in some test case written, the issue
> > is very real and we have workloads where camera is reporting frame
> > drops because of this unmap latency in the order of 100s of milliseconds.
> > And hardware team recommends using ASID based invalidations for
> > anything larger than 128 TLB entries. So yes, we have taken note of
> > impacts here before going this way and hence feel more inclined to
> > make this qcom specific if required.

Seems like the real issue here is not the unmap API latency.
It should be the high number of back to back SMMU TLB invalidate register writes that is resulting
in lower ISO BW to Camera and overflow. Isn't it?
Even Tegra186 SoC has similar issue and HW team recommended to rate limit the number of
back to back SMMU tlb invalidate registers writes. The subsequent Tegra194 SoC has a dedicated SMMU for
ISO clients to avoid the impact of TLB invalidates from NISO clients on ISO BW.

>> Thinking some more, I
>> wonder if the Tegra folks might have an opinion to add here, given 
>> that their multiple-SMMU solution was seemingly about trying to get 
>> enough TLB and pagetable walk bandwidth in the first place?

While it is good to reduce the number of tlb register writes, Flushing all TLB entries at context granularity arbitrarily
can have negative impact on active traffic and BW. I don't have much data on possible impact at this point.
Can the flushing at context granularity be made a quirk than performing it as default? 

-KR

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
