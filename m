Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA147C433F5
	for <iommu@archiver.kernel.org>; Tue, 15 Mar 2022 17:05:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 879CC842D7;
	Tue, 15 Mar 2022 17:05:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id g6XarjowT6jg; Tue, 15 Mar 2022 17:05:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 427E4842E1;
	Tue, 15 Mar 2022 17:05:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F18FDC001A;
	Tue, 15 Mar 2022 17:05:14 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BE4B9C000B
 for <iommu@lists.linux-foundation.org>; Tue, 15 Mar 2022 17:05:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id AB52C60FAB
 for <iommu@lists.linux-foundation.org>; Tue, 15 Mar 2022 17:05:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NL4AR-XFIRdk for <iommu@lists.linux-foundation.org>;
 Tue, 15 Mar 2022 17:05:11 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::601])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 776EE60E73
 for <iommu@lists.linux-foundation.org>; Tue, 15 Mar 2022 17:05:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nCddxm1xeEADVzIZe1YPZ6QEUW3irnylPvJBKz9HBAUOexlo2JNvJI+Da8cxIhlZFZFU0tAonqS7OM/XV9fZvIiTynzuTZC7CwEM/afPPS5mZolhG7BXt10Bzf/OWFf1aCNlYwkI6tdrCbc3S/rIlED0kwWhCqZfqV4phjJ0ISJ7X6k3bd+J1Du4pvypcRjorSc+VsOZXgX3KV+oQT/edFCcDVmenV+NyH5Ma6iyBZPHeIyuAXalX+S4Ea6ha3/fg41OESKUDZMWU6coOzpX9If5JXjYD2GQb4GE4A8DmzEv454+AZS0OdFQNBbBGRBY40ds4Nn6PHrSdJLd6aFIqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r0vBWxXxOUzElNhZk0hTIQ9iymjNLn6vibo9LnkPUuk=;
 b=NTXm3CWLui2e+NhfIJuwXC0/fouOoDkOqE+roMcTIiAFe7EFHL/ZPgg6LT3EW1RC5V1dUomEGBjl+v4BFiB3IV0noduWs3IRutsScv2HrZpE0jhQ4JvLQoctJAM1QaciWzzTlTm3iRtbADSHUxWCX2/EugDijaC6sJlN7dgOi9SCb8UKxGKeYFQDqli0V6lysSdhM0NJhFVono9MYylf/R4Ooy9cVvvJPCiNuUgf60CNIGDTsQdnT24fOYqaruSFP8bEWc0AFv9OvkkV9OYJbVKaTaJPnKA2Z0tOTkDoAp1xhksoN9GpaJh3XEidGEokUqAHqH8s2meojhR7wi3pNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r0vBWxXxOUzElNhZk0hTIQ9iymjNLn6vibo9LnkPUuk=;
 b=skMqjolIREbdLLiv6cZeQYekGOIw16eXRzWsu3XxqpNW+g7KX+puqbNcbcdEIdlJ5XBHGNMCbl2QQhfLQ5HnUbSelMP7HsSapZfYI7cH5QBraButDuhfDGOrErJ0Q69KHVj3CP9soj3vZkWTnU/m+p86fjv/sexczICpDRpxqnY/9RzRQ1NrYNKmMLAR0dE3VmhKcqnP6SxRaHEw/vWAnxTbFvb4Hy2o4x9A6B1IYc3cvOYbn37ynikmriUD9tulUCCvnXXAGyCEY2a7ZBeJ5k70c/iarAEuGugVBluC+uFqM8m0xq9h48InXphXu0Uwg+02iA5Kf/xcxkNaBeuxoQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by CY4PR12MB1286.namprd12.prod.outlook.com (2603:10b6:903:44::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.26; Tue, 15 Mar
 2022 17:05:08 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::51a0:4aee:2b4c:ca28]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::51a0:4aee:2b4c:ca28%4]) with mapi id 15.20.5061.029; Tue, 15 Mar 2022
 17:05:08 +0000
Date: Tue, 15 Mar 2022 14:05:07 -0300
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH v2 5/8] iommu: Add PASID support for DMA mapping API users
Message-ID: <20220315170507.GH11336@nvidia.com>
References: <20220315050713.2000518-1-jacob.jun.pan@linux.intel.com>
 <20220315050713.2000518-6-jacob.jun.pan@linux.intel.com>
 <00286dbb-fe73-3604-4dec-340eb91912c3@arm.com>
 <20220315142216.GV11336@nvidia.com>
 <20220315093135.5c11066d@jacob-builder>
Content-Disposition: inline
In-Reply-To: <20220315093135.5c11066d@jacob-builder>
X-ClientProxiedBy: BL0PR0102CA0007.prod.exchangelabs.com
 (2603:10b6:207:18::20) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9451f8f7-f2b0-4d5b-32da-08da06a5f53e
X-MS-TrafficTypeDiagnostic: CY4PR12MB1286:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB1286F5C4C0E69520C41F9F48C2109@CY4PR12MB1286.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +UFZS89DMiSoMptd0EtBQAmS+CTQZeZkvJOcrjUz35XrscR56k5r1IMMZssPbkWBJuBWdZ/fyx4QXtnbFW4f83yxByHSS0GKPyRWeWmB94oy5XRtyaTEVI/QdUOM+UZEDw+WjUfT+M7nIRiPegWmoFtOyddUrN9TeZDAmQ0w9s/6SUnVxihf61HCizeHKFHMFrHr98VIM8TGiDdUf8rqiRthFrAmNM3b8lpULZsl31SiCa2v4jdMZDCVCmYYyptlrvaE1wdnNu35EnJxSlscFi00C3PdGHJ2wlJyan28WmwyPNbDuAQOWWcCrTS2cPjhp/QZR29CrSRtK6T9wWkYim91yRQsmnDQdn3StEFteNb7G7tdMwRF4vwvsmlFBM6v8RNKCwTuI8yRGWtnbSyZFWmG/vqs7orHpUDNynp5h667V6jY2bGiHKXf08E6qCdooN8eDebqJrSrQgb7jw52bjr/M55LTxxS7uyx1SB4xwR0EFCJIUAz8a8J83nkadlLxwxe4esHddBLS1D56TGR7gygU9UMk7Dx8d2f1ajioRk55soxyPDZIdrnv6nk0cx0Be+/Ph4UtjmLhQ/xzLCvb0dWiDq1mHgXcMLSPIDhZW1Ds5i/9ABZtFWR7SpRW1gbpITON4KvoF6slNDE5abyazyNe6TuzKhGeBy8EFBrCFGgD2YsZKij1obBdlWs3TzlP1WfgMkVAE23MIXqNjvVrMRM3GjireXpSFHzzMB3p8g=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4192.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(38100700002)(8676002)(2616005)(186003)(316002)(26005)(83380400001)(4326008)(6512007)(6916009)(1076003)(54906003)(86362001)(33656002)(6486002)(2906002)(5660300002)(6506007)(66946007)(66476007)(66556008)(508600001)(36756003)(7416002)(8936002)(26730200005)(19860200003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LeuG4URZYmRT4kSmRLrk/yRU9cpPc1JJb9mHbEulB3r57d/9uAm+DdhRPg1K?=
 =?us-ascii?Q?Q5pqQSdd4bYT8zHcT+SUPvwtW7bewxIVEyR7hapQLfdvTnUZ79RdjEVzV4eY?=
 =?us-ascii?Q?LfnB+C548Pb0P9AiPJ7mgBp7fWjX75qtPCVM3ddEVsNIv8Ojb9YelhPZo+Qj?=
 =?us-ascii?Q?3QhNWQTOO24+zjLLs3OU1e9mf4iWN6HwwE6+REWciMZUD1dw6csKNPaUe2Lh?=
 =?us-ascii?Q?pjjFDZTKEFuzrKcLjScqKezAVTFhNe2mqjmysJLqpGQNBkBM31bMXMlvW486?=
 =?us-ascii?Q?ONniejuM/JO9KQW3n60MF/7EUQC4D5OZDjPTPaP96/Wotl//2c5NoD+e2FbW?=
 =?us-ascii?Q?J4JYIO8Dq60+XO7WMMwmUKbdmweAuj957PLodHcMt35Rj+FvDWcgYRPIu27w?=
 =?us-ascii?Q?8xMl6tu92BYQf2y9+iOm1SdTi4cdEI6aa7rQ1CZwS29yLw8kifFs39137rhJ?=
 =?us-ascii?Q?/ScJ19IFNQk7PIuAVyIcTEIPyn/KVzc9vsaKn7svyYuAAzLBT44b/4KVw1xp?=
 =?us-ascii?Q?Q8DvlDmVj0IDCVb/Kd/YOarGg1QFoQ0H11j+4qsB/rsUqQn9gQKtUOH3GOta?=
 =?us-ascii?Q?jVgKse7zbvpzpELW3nMb90tKHCBAjRBLbMr66p7sO3qbD8uBYbz0XTPI7Ps9?=
 =?us-ascii?Q?+kM3A4m5+hFsZVxVjYgYYNUxzdk3T1EoTRArFgWWam+XdfEOYlkfoE8DRuMd?=
 =?us-ascii?Q?kqIV1EBLEzRw9oT2BwX7YACF7XmHhsBZnoo+KHLqH+9+W0S1BPd/DnW0D/NM?=
 =?us-ascii?Q?6Bp2xVUp43Hg+27PPeEGLFlGlZUzfdzZglS3rFRQPAe380/QsHv+q4xNMmZA?=
 =?us-ascii?Q?MHoOZsvQ4xwUFzmo7yfvfBpHKE1ODHP+kSRLPumaGVclN+SVdKvf0Am5osOS?=
 =?us-ascii?Q?LgiG0hG12nLI7l4B3r1NaOE5J2OgUQ2hKmxfJPSRRsIr47kDvak4vvyVNgfD?=
 =?us-ascii?Q?JoOlV2slOqcw5D7/JHWDJzckrq/Ls2DUVNEFp6HPwhu+P9/O2NssJROzI2uY?=
 =?us-ascii?Q?W/QKF9UlhfZuelzmEJQ63BYm/QjcjgkRX6mNPtGEGUY2BzUmfdH7d0Unn3Xk?=
 =?us-ascii?Q?ydEfhP2TzRzupirhUaCGXdeTzcLocoZE/BKqXgBgvXpKES1HijWaBoYqeAAN?=
 =?us-ascii?Q?gJ8iwZ4+0QCYCpUG/kKtKXDhBbg+ZA3sU0O8iYjqGFQaXzTc4f6y6nFKTBVX?=
 =?us-ascii?Q?CgS4j+/enc/iRvRjegZeM5akkRmwxJdlH5DMdYMKZAnyDjIh5QRimRPxuKPN?=
 =?us-ascii?Q?uCdLCd2MwcAt0ob4UNWbfhsmD6NFW+nQ7EY1VfXj6XpzDqA5P+xSYbrrvSoR?=
 =?us-ascii?Q?5fP2ehLRtmPaZckQQ+oaIWDzNRCcj0mpqQ0bXDquQGZCEleaLNKWRMeK/0qq?=
 =?us-ascii?Q?eIZy/+rKX2TqUu3Dwb17NUW3iEu/GXWSOP+jPvkxiN2sorgw8Md59Y8KMAim?=
 =?us-ascii?Q?UHaquB4E8Vor/DDxju+frHN5YCUl75Go?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9451f8f7-f2b0-4d5b-32da-08da06a5f53e
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2022 17:05:08.1317 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: COoFcvmPkN+LmWBtI5474lHwOGD1qwZd9ybMWfyNkygV6z4Ykv99yJX87VQXuIkJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1286
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Tony Luck <tony.luck@intel.com>,
 Dave Jiang <dave.jiang@intel.com>, Raj Ashok <ashok.raj@intel.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>, "Kumar,
 Sanjay K" <sanjay.k.kumar@intel.com>, LKML <linux-kernel@vger.kernel.org>,
 Christoph Hellwig <hch@infradead.org>, iommu@lists.linux-foundation.org,
 Jacob Pan <jacob.jun.pan@intel.com>, "Zanussi, Tom" <tom.zanussi@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, Robin Murphy <robin.murphy@arm.com>
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

On Tue, Mar 15, 2022 at 09:31:35AM -0700, Jacob Pan wrote:

> > IMHO it is a device mis-design of IDXD to require all DMA be PASID
> > tagged. Devices should be able to do DMA on their RID when the PCI

> IDXD can do DMA w/ RID, the PASID requirement is only for shared WQ where
> ENQCMDS is used. ENQCMDS has the benefit of avoiding locking where work
> submission is done from multiple CPUs.
> Tony, Dave?

This is what I mean, it has an operating mode you want to use from the
kernel driver that cannot do RID DMA. It is a HW mis-design, IMHO.

Something like PASID0 in the ENQCMDS should have triggered RID DMA.

> > In any case I think we are better to wait for an actual user for multi
> > DMA API iommu_domains to come forward before we try to build an API
> > for it.
> 
> What would you recommend in the interim?

Oh, I mean this approach at a high level is fine - I was saying we
shouldn't try to broaden it like Robin was suggesting without a driver
that needs multiple iommu_domains for the DMA API.

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
