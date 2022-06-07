Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E334BC433EF
	for <iommu@archiver.kernel.org>; Tue,  7 Jun 2022 11:58:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 74CC6410B9;
	Tue,  7 Jun 2022 11:58:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7eNZmx1iYdzn; Tue,  7 Jun 2022 11:58:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 57D164014B;
	Tue,  7 Jun 2022 11:58:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2E7D1C0039;
	Tue,  7 Jun 2022 11:58:27 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AAE81C002D;
 Tue,  7 Jun 2022 11:58:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 85F8C84355;
 Tue,  7 Jun 2022 11:58:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ny2CZaIQJ96I; Tue,  7 Jun 2022 11:58:25 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2062b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::62b])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 55C4184353;
 Tue,  7 Jun 2022 11:58:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gtqq4tQk6nzpSln2zUm0X2CY5p/bfbPCKgc3O19riC808arlrgVn4vRshg05dOM8PzFAOJQwEDRZUR0YFaxd8wJrYV52lFw4tXSX1FrEJL7uGsq4LjJTJ/qoZoGi3pYWIKUxvTHlfJyPZt6zn4kQgwBBftAcDsxyK/4RH07zieWNLLqU50Gsycz6UGaOJPaDujqujvmXQDxQ/td0VzIs+G4AlyWMWQI56atgeyzBHQ1aHELGcTv2A0u3Wh1NHw3gaNlQRBe+EUPEe8jn6NcKD29qUMQOOKcjweLhyAucTNiXOEofu6SLcCR0i45GtDx9w10NovvN6mimK3eRCOSyKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hyQ7FJG645S4QF9ib6147Xx09KY8YPpUL9WcHbeFmLw=;
 b=RvXRJzQ7/TJvy4tUajRfD9LDrmNrNe/myqEbd2IDlLnWWm3sh0eReT5cMtakY2q/FSgAONb4qUOrdrQSECVexBEFQyKfc8qzPJn1djkWp1wvJUn8z0AX56iE/5H88y6xYGloth2nz5OJs6SDH99xYWvycJAH2JotXjlDs10Wcl580iJWW1iEwXZsZQdF00OZt7wzjJ5oG1hfyGWb6JAMhIFOyXtutrq94BEGY97g0BdzLOBBydDYVd9d1mOq/ZcjUm+usmFLTUEx9AuxQZGGUJuI+Zv+XL9DlN8XPlSVwtvp3vIXTO1rtS6FbGgCBPyPuFJWa5zpKWkmW94zzj3Rwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hyQ7FJG645S4QF9ib6147Xx09KY8YPpUL9WcHbeFmLw=;
 b=m0tT/9jkFNdqHGV9JszjPpvwRwakHbfF7FccTnjn1cv6kj+hvpB7CwUC+0a0OSHCGpbPJq889iBKXHTDuMjPUQX5r0OfFUQVxBzBNiUkERMdgJojls1j5s2OmdIznZc7RIlju6o8T7VvdGVzpbyv1G0MYq3BHsIFcUW5wCCghP5/UZG+idQcqnwZ+hAj6WXrguEL4jMMXFQvlTJBrWlha6ltIlB/YF96pkBajldJ7I5S6GRkCZyRX1gkPJhkgw2VtNhb5P4oFRP8tAu2kd4mDhJJ0pzgZHOdzADCiGQkWLK9n8EoxWpDke+CwzTt9fIl2GjJmjNLtZUdwlOah0zNYg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by DM6PR12MB4403.namprd12.prod.outlook.com (2603:10b6:5:2ab::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12; Tue, 7 Jun
 2022 11:58:22 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::2484:51da:d56f:f1a5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::2484:51da:d56f:f1a5%9]) with mapi id 15.20.5314.019; Tue, 7 Jun 2022
 11:58:22 +0000
Date: Tue, 7 Jun 2022 08:58:20 -0300
To: Baolu Lu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH 0/5] Simplify vfio_iommu_type1 attach/detach routine
Message-ID: <20220607115820.GH1343366@nvidia.com>
References: <20220606061927.26049-1-nicolinc@nvidia.com>
 <d357966b-7abd-f8f3-3ca7-3c99f5e075b9@linux.intel.com>
Content-Disposition: inline
In-Reply-To: <d357966b-7abd-f8f3-3ca7-3c99f5e075b9@linux.intel.com>
X-ClientProxiedBy: MN2PR13CA0035.namprd13.prod.outlook.com
 (2603:10b6:208:160::48) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8cc5a917-b8c4-446d-7322-08da487d04fa
X-MS-TrafficTypeDiagnostic: DM6PR12MB4403:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB4403AF135DE2F2CCACF4DA0BC2A59@DM6PR12MB4403.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qWjRiR0HgdFvAQmgwW9BJgMAGiT4zayOWQcQsoJK1Avh5U5BaA0Pxc+GbxXLc+nBfB7iSf/4m8cByAWMMf2LqxV9Xub13IuK0g1AqkqLXo69NiRZn8kSa16DzecbIjK+xTz8spBwmgIxDJviUSeuryPRNWdey/HjmZmHBA6kJJq8ouhuNMI6/Msp72Crc4xLuFN2gl0NaKRaZv15xoTyk4teKzNs0Ya3rEFZacm45N5CNBoduGeO7nYGXPJAbAOk1Q04aBc4J3tPI7PTiF1s7vOKzVJD7o6Ysk9zGEnzfijeiflXdDLHvNs0ZAHJgOZ24xd5kj1jizufnnQPOCazW2uqux8UNCEXEHPu76hQpRzBEMQWHyJo5wtXyik5lH5vxA0khI+69Ln0ifnRPKFI+4ccUJg0Bl+joj/H75T0Imeheyxdz/qR6PvZD4FMM+fmvUfSkOn3Q3AFrdduSQAVnhsElUgCrgGZINSEQxWLqIi3ziO2oy9cH5cGINMObkiCMkhMIVc20guO05VPT9Dh3nolc/94EeAyil6YTCZsjCIirmiMW0FWGBSN6gGJ2VWd5KkVgtXI/ZImW286Edrl29JABytHY/mGkOVpa28IQ7wCE1sREY60mS4U+zGYLK5syYfQy7KRNEryQ73e7BOjJQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4192.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(2616005)(36756003)(7416002)(508600001)(6506007)(8936002)(7406005)(66556008)(8676002)(66476007)(4326008)(66946007)(2906002)(38100700002)(5660300002)(4744005)(53546011)(6512007)(6486002)(86362001)(6916009)(33656002)(316002)(26005)(1076003)(186003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QEkwO8qV+DMoII+XdhdNjXBVl5qHAjfA/jzJcWkeAKXa+Steb3/LW/WZiHz6?=
 =?us-ascii?Q?S00g8axuYF+ssrPsIhwqzzkSgSGhjb+X+yNSc1Vw6rXNAeg2bQHQFqUbsbSh?=
 =?us-ascii?Q?umSHjkGdMSwCk3ckYcRXsnCw62OaoX+dWpa5JadGMY3H6GauE9BThHvO5zrQ?=
 =?us-ascii?Q?cvwNidfx9iu6zkOrTeVdY9XJOxTAW4l/lKKwcB6EY+frVT3ClZnb/LL4TKHx?=
 =?us-ascii?Q?eNP1pWRekH7auhPaWgp1E4qqmhvx/mDvoSrUmqQHq3YBcstKCwweeJqMEMHe?=
 =?us-ascii?Q?+Dyl3YjsF1nTWmg0kV3+alCBs/FhJwbT3GMNiZi3iPMxf7hLTY17R2M9N0Wg?=
 =?us-ascii?Q?eS9bA05ywqk3yGO/C2p+lRIc+lOLkXemW6IKqR/njf+pc5h+GhXUCLC9hGgx?=
 =?us-ascii?Q?4Ad0xh/oybgNnC8w2hbDSItUv5pFGkQIyI2OcGBYBdk5NhKeLuOf2aXF+jDe?=
 =?us-ascii?Q?Zty6XA7CL2rKo27xXYhwFvdKl5tdRrb8xMJT3XuuwIRZdZ8goEPTKbcAILSp?=
 =?us-ascii?Q?SwROnbizTZ/TKpV2zUpOwZY8EDbLlY4ThlMNRRTAYZ8+aChn3xwshBBSmKms?=
 =?us-ascii?Q?kWzlb9efK528WSnd+Soq8w2kJ9LLqMOtWWRW5GcCRhK+jLGqd2Ng8noBGl8a?=
 =?us-ascii?Q?1zwITKi8MgnYXa5dyIkzftIyhPWsZgLhBV2tnE4DF44dGYn7tnGEdH7+wbG5?=
 =?us-ascii?Q?XX/SCAA5XEx7O6jgc4NQwdSRdkS9nxCcTicRNZqb+kOHtzKdO6AGRZ/3aUtV?=
 =?us-ascii?Q?xYbLphs/wissPWCcH9/xcN/qoXIyWqJcrqqtxUMnWgAfrdWqdBpHacLjeCLX?=
 =?us-ascii?Q?cxRM5NmGT7ZpDeK1v/K/BWloejaB1x2c43r/F5XhhPTmqBOx5B7iUCpnLkRQ?=
 =?us-ascii?Q?E3wELXcgINvdaNo4+dexPrvKLYmizL7dgrGT0L03qVMGI1VDsteGZVLfzL8U?=
 =?us-ascii?Q?XfBuVt4v/i2ha92hO3SEAurYep/JrELcHYRaakuOm8X007tNpxicFnhYtXHA?=
 =?us-ascii?Q?rrGpkkIbjY8WDl2IIqdkGRWKjIGXYrnoDtdsg8yMH6GIatgAnCYafRi2O2XT?=
 =?us-ascii?Q?WH+IxNIfd7/c8085MJSQ5J3wROq+yeJd2JFmyICrPvnwR+ejTGNgti+b1xMo?=
 =?us-ascii?Q?THLw3qYixaCPylFYentKU1av/u6Cz04aSh06GT/c70DlEdgK1uzqxxiPXeru?=
 =?us-ascii?Q?ewfDmU6kFZoCV6OCXt6kXKMFLhXtDoV8QZ22zNqiSAifjZ8U5OwwjWBPVVmi?=
 =?us-ascii?Q?deDhMsShmV4p+Ga9ejrkdshDzG14U0k+rKLMFAjdWTyplvEu//nmJi/2sXPS?=
 =?us-ascii?Q?740D9Akr/tdv7LEC9pt7wUgfW6iw6wELdjKp/CTTgc0rv0RhiuckCUSW5atv?=
 =?us-ascii?Q?S0ywCbwhuGnz0YBVv2V1QQzJ0akYPx6foc3hmZca+rttT8NToMQgG15nVpbA?=
 =?us-ascii?Q?7HI0WC4DSG2j/f4eVTwh8n63uvjTcKdSjVJJP4w7VFyK4dFcFjDasp04PiFy?=
 =?us-ascii?Q?N0EHtgXNU5CTECDoKXhgSsCvY4EnXFY0xCgf3ReMk2e+Yu8kZtxMmK7reADh?=
 =?us-ascii?Q?yBVTohyPb/LsR1zo07XoPMNNo3NovlzljfqQOKMxNFk3BhG+19HhEgaCuIx/?=
 =?us-ascii?Q?9OO4Y350z/sVdOzK88ARm1fx2FaTDTfVHvd5go9w4XyNuQNHAqi5fX2XocCR?=
 =?us-ascii?Q?MZbLMl5np8FGzlUBoVdKqIf0xzIUARs/+EUt87g91C3WMAhHMWldtUGsMD4/?=
 =?us-ascii?Q?+OxvqbQR7w=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cc5a917-b8c4-446d-7322-08da487d04fa
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2022 11:58:22.0324 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ygtIfwM5keObquhDnrdqGDLG45tetbDL26LAnv1CjoRY9EUw3/i+WK2uzzzNuDxK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4403
Cc: linux-s390@vger.kernel.org, cohuck@redhat.com, heiko@sntech.de,
 linux-tegra@vger.kernel.org, thierry.reding@gmail.com, alim.akhtar@samsung.com,
 will@kernel.org, alyssa@rosenzweig.io, jean-philippe@linaro.org,
 linux-samsung-soc@vger.kernel.org, kvm@vger.kernel.org, samuel@sholland.org,
 zhang.lyra@gmail.com, jernej.skrabec@gmail.com, jonathanh@nvidia.com,
 linux-rockchip@lists.infradead.org, wens@csie.org, agross@kernel.org,
 linux-arm-kernel@lists.infradead.org, orsonzhai@gmail.com,
 gerald.schaefer@linux.ibm.com, linux-sunxi@lists.linux.dev,
 linux-arm-msm@vger.kernel.org, alex.williamson@redhat.com,
 iommu@lists.linux-foundation.org, linux-mediatek@lists.infradead.org,
 matthias.bgg@gmail.com, virtualization@lists.linux-foundation.org,
 dwmw2@infradead.org, marcan@marcan.st, linux-kernel@vger.kernel.org,
 krzysztof.kozlowski@linaro.org, baolin.wang7@gmail.com, robin.murphy@arm.com
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
From: Jason Gunthorpe via iommu <iommu@lists.linux-foundation.org>
Reply-To: Jason Gunthorpe <jgg@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Tue, Jun 07, 2022 at 03:44:43PM +0800, Baolu Lu wrote:
> On 2022/6/6 14:19, Nicolin Chen wrote:
> > Worths mentioning the exact match for enforce_cache_coherency is removed
> > with this series, since there's very less value in doing that since KVM
> > won't be able to take advantage of it -- this just wastes domain memory.
> > Instead, we rely on Intel IOMMU driver taking care of that internally.
> 
> After reading this series, I don't see that Intel IOMMU driver needs any
> further change to support the new scheme. Did I miss anything?

You already did it :)

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
