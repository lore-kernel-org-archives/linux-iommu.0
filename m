Return-Path: <SRS0=kThj=K4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED374C4708F
	for <iommu@archiver.kernel.org>; Wed,  2 Jun 2021 16:38:02 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E834619A8
	for <iommu@archiver.kernel.org>; Wed,  2 Jun 2021 16:38:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E834619A8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 39BEB4028E;
	Wed,  2 Jun 2021 16:38:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Y7Eb0AvS0DTF; Wed,  2 Jun 2021 16:38:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id 82DEF40264;
	Wed,  2 Jun 2021 16:38:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 588D4C000E;
	Wed,  2 Jun 2021 16:38:00 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 63FC7C0001
 for <iommu@lists.linux-foundation.org>; Wed,  2 Jun 2021 16:37:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 44CE860593
 for <iommu@lists.linux-foundation.org>; Wed,  2 Jun 2021 16:37:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JrGkrABl-HSY for <iommu@lists.linux-foundation.org>;
 Wed,  2 Jun 2021 16:37:57 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2058.outbound.protection.outlook.com [40.107.237.58])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1CCAE600D4
 for <iommu@lists.linux-foundation.org>; Wed,  2 Jun 2021 16:37:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c10iq7iP87WZAxpHMEbIo9IXnXdfPHvNG+M/oqdYXxpyPZ5lFPNL1ZXZZgubRcNwmNdudSTJ+Ou7rx5Co7WnCbEWjjX3LCnaWe2ydwi0EEChQ9GCg9pDjIJBmFqjFDQkRCEOudd9nqad6Z/bbBkIJnNqlCAtOKLaTkJzw4dWp9LDmiUokWz0FQBxbi8FuzSYKoLZ6V/QOp/Gt+MM8ubcaM78oeBg61uUURX09D75nobLdt9Uu7uWaNvYggZ/SWOXstWvGm/YTYErI6jshSt0LVBnfk9d7vPrZa+FOhwqK3tO6IVRWIa3p06dF8xO+WhvOTzlOPvXYUFL1dw5zlxFoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fyxO4ou+YBaIeCUpymU5qJ8ZjGEZI+2EY1jY9Q0vMMo=;
 b=Nem/sjkeTiGS2L85YR0f+ufLXP+fAUNOP8aEkdiVO/6TKDkoUjwUAfYckwZKBz/8idkQwlIuZTG65pb1pFVW3e0u3pz2uRi2Z52XmhfhKuyUBj1cy7BlLc0TUZMX1CCoz01kt+yzZpKV2unSfrwvR4TF2d+4deZ5cqb1Mi2AHjgQ2W1cRuaWrTDP+xEPinhaY/pQCePTkqFgtxEfuDdZblSsD5Z5C1KIVv2rFF+caFvSsJLY6t+U9GJfjYV0PJhynzji21FuElatgQu32b2a/FI6OLTsVi4/10JTg8F5q5NKDlPt7DTprMxV95sYVqy6A03KGaRqoTN5xL+BqSTIbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fyxO4ou+YBaIeCUpymU5qJ8ZjGEZI+2EY1jY9Q0vMMo=;
 b=i/BFmhkWmZANafejxOaAkIKy0Rtegmt0aMRoOpx9besjUqv0MatPjaDIIBS2CGCP/cbIJZGy0A3afMALT/cu2A/9z1eBRYYJsznJZhTOziVYhu91xcPKgHrIyNpbAurWSBFopAr7BDgNLuHhs54UI62Udvt9z7SSilO8gcPpYEfEGyBAJHqMAlgkIVkRFmkYr+SsoVzINLY+k9OMl5XtC4Do5244Q7lkW9WNglfAu4ydsI/yBUTQoxzqOxEosCK9udxnnCIYRy14Ed6sWy5VyXCvtPB8vAAUMhLV4f1zx8osl/paw5gJivn8AD/7YVGTcGdlY5xdH0fD0oZeBBcA2g==
Authentication-Results: gibson.dropbear.id.au; dkim=none (message not signed)
 header.d=none; gibson.dropbear.id.au;
 dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Wed, 2 Jun
 2021 16:37:55 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%6]) with mapi id 15.20.4195.020; Wed, 2 Jun 2021
 16:37:55 +0000
Date: Wed, 2 Jun 2021 13:37:53 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [RFC] /dev/ioasid uAPI proposal
Message-ID: <20210602163753.GZ1002214@nvidia.com>
References: <MWHPR11MB1886422D4839B372C6AB245F8C239@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210528195839.GO1002214@nvidia.com>
 <MWHPR11MB1886A17F36CF744857C531148C3E9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210601175643.GQ1002214@nvidia.com> <YLcr8B7EPDCejlWZ@yekko>
Content-Disposition: inline
In-Reply-To: <YLcr8B7EPDCejlWZ@yekko>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: MN2PR19CA0013.namprd19.prod.outlook.com
 (2603:10b6:208:178::26) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by
 MN2PR19CA0013.namprd19.prod.outlook.com (2603:10b6:208:178::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.20 via Frontend
 Transport; Wed, 2 Jun 2021 16:37:54 +0000
Received: from jgg by mlx with local (Exim 4.94)	(envelope-from
 <jgg@nvidia.com>)	id 1loTsP-000HpA-OT; Wed, 02 Jun 2021 13:37:53 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1e3986e4-bc01-4cfe-5607-08d925e4c5a3
X-MS-TrafficTypeDiagnostic: BL1PR12MB5144:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB51442FF3145E60AC6295EA1CC23D9@BL1PR12MB5144.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1x7eBkduPMaOk30fPfUbVwbrYTfzLtr5aw0xYom7pyyDtXmfKYpgwvAdVBIMfKlbABU94/O8ngPet5Yje3qg3eIdVk+TYFhtGuxYG3EBfCAIO6xm89MXy8RLBECsdtXWwpTBf7432/EBaHH0sOy9AAZINV92cj4FtsXfPjZ2i6s0Krf9EtYtKiVMGBltvT7+gIfvQn+eLT+Mx4fJSDtwFwSvhryI6YBxmDdp3sJLMHRM4g7d87A3Y6qr7Q4c8B7XRD4Rlq1amzm5ljUinHTqHBwm2lhYPOSkdpHP/3j5zY9wfVzrxg1b8W/naOuzU6YhyHPCI0SpHxfHJ1RWFKNkV9bfMVQzSRXSLe8tANX/80MHfphKJHSQxSKcRjewflnCXaReSOV9gWF8p2+qZLCDgMp0Q68tn5Tabc4eCWFVbaKtr1crl+Ld6SUP1rI1qmgby2cOUJY3VIXHcAfRr+LVUDW/r/Ir4huysOOHJ7H/trXievxLxIFvuequaI6FbSWrI+O15rymBOM7A+hBbGKAYQAykzQi2bhd1zzAEWpfCW5mJ5yO8ngwxcKstqB9WQxcSnJgV5sFaf+srKh71r95APzRxPL8VQG44Bzkpt7Vcmc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB5506.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(376002)(346002)(136003)(39860400002)(9786002)(66946007)(26005)(8676002)(2616005)(38100700002)(33656002)(54906003)(6916009)(1076003)(86362001)(66556008)(316002)(426003)(186003)(2906002)(4326008)(36756003)(478600001)(8936002)(66476007)(9746002)(7416002)(5660300002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?nbykn5jqSsX3qnDtQPZdCYz7IbS7zXniIpC5SnXHJgstX+XML6a1N6WrL6Mc?=
 =?us-ascii?Q?Dxc3xbi5M/LO8Mhn/XJjzV/VqXEgmDaDBGcaPBRqif6pqBP6qV6RfyGpWLqF?=
 =?us-ascii?Q?1Cz77VGVk4vmplkYRrlE8VhUW43oSgPhS/vb3mW1v4pNMrIpjYQsXJhlQnTk?=
 =?us-ascii?Q?Yh+HvHI4sNfhh1lRsSz9Qw7Pbe1SBb/L94lPvlWPT1JZvYQxhXpVvU5CW0du?=
 =?us-ascii?Q?KjdvYPwiul6K6MhTU84bd5IiTSMP4SuR7/WAg+nSISNrJrgsQkqh6ubaC4lC?=
 =?us-ascii?Q?K+YyflRyIjlc4xMD5Ezy5wlCAzgUUjFYJSjckgiiVgdBE8zZbKky2e7BYhWP?=
 =?us-ascii?Q?Z8ryd0N7ctT1nfv0gIfI2wLjUyBbmqC8sQW9hjJgsODtgNVD/7WwqICK6BXO?=
 =?us-ascii?Q?OTVi9v8clM9HylEZTrrxjnJ3klLW/luO+VnBMI11ubMs9sg5/AkjZHac5KF7?=
 =?us-ascii?Q?/axWBwvja4urd4FRheIJUFDwtIfhwQTU1w6hkFSQOltVloz4s5yHoEPweuoW?=
 =?us-ascii?Q?1WYU4CugVngQXTvyAmUG5cooz9vF0kKeqDjLNmPUfOEbj0tlRYt/YX2oENBD?=
 =?us-ascii?Q?r5paeYtrA8R5fb5c6M9AJIh+1AyhGUhLYaoiZYl8g0OudJYCUX6Q+aTzyeBO?=
 =?us-ascii?Q?Hr2G4iVPxPaP0xw29zEF46OjcDX5hCC6fqiXBWm5Lyit0SNohdKM5RngKL0x?=
 =?us-ascii?Q?yJEIaOJLq33n/XnvVckfC4ZBCTsReGzbGRyAxlgYhcym/zLyyGPChCaVCif4?=
 =?us-ascii?Q?M6bEYgfT4bNpVuM/NGUY72nXRUnqXufZvreB8Rkc1lSYQ28ADhEYpO08ExRz?=
 =?us-ascii?Q?bMiFqXA2vqnc1h9O9HDCf2wbHy7IRI0RDtDd/qllDp7fNBoiTCo+VCCLtZ4h?=
 =?us-ascii?Q?hmefp4OJdqEUOX7X9RmBciZJ0UEM9cSOVbBSQf7nHcEbS5n7dsza0rKf6+kM?=
 =?us-ascii?Q?jjSaBjJuEfvVptDGTHra0Uno1z2wag8jHcltbBMfpue1SWM4YE/7u8XIDNRz?=
 =?us-ascii?Q?bVhbqtmEPGEIHmdB23KaTybJrIEHnAI1FmHhyM0llcyIgGcooM+2nsR5jLvK?=
 =?us-ascii?Q?c0TTI/Np15yvnDa54sHfZJd/SbrhRvKlgvsJlqlDKUnD3+ua5N+E9lDf4DsJ?=
 =?us-ascii?Q?/lM8A2kvZhCl/52pdOXVfRM0R9NrYV4DrhOiPEwHhfluXXq8uDw00VDivWSU?=
 =?us-ascii?Q?x3Tl9DAgDYFAVuzIPJYfCnOYDUQzSokCmW0VthCrw8utd3tZVZ7kEFOgL3Yy?=
 =?us-ascii?Q?zBekeoADexWqIi/QFgHjqMAKjWSbcSPtGJrwMKLj53piwYbGeF8GMYvbfleo?=
 =?us-ascii?Q?jHqZQavYiMioSnAoiu3hpQ4i?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e3986e4-bc01-4cfe-5607-08d925e4c5a3
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2021 16:37:54.9736 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7BzzjNuVy/vrcA8KSqLPXB6EWZ/kEJCF/sxHHt6XFJhfMKWABZWoIGIrM65y4pt6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5144
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>,
 "Alex Williamson \(alex.williamson@redhat.com\)" <alex.williamson@redhat.com>,
 "Raj, Ashok" <ashok.raj@intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Robin Murphy <robin.murphy@arm.com>, LKML <linux-kernel@vger.kernel.org>,
 Kirti Wankhede <kwankhede@nvidia.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Jiang,
 Dave" <dave.jiang@intel.com>, David Woodhouse <dwmw2@infradead.org>,
 Jason Wang <jasowang@redhat.com>
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

On Wed, Jun 02, 2021 at 04:57:52PM +1000, David Gibson wrote:

> I don't think presence or absence of a group fd makes a lot of
> difference to this design.  Having a group fd just means we attach
> groups to the ioasid instead of individual devices, and we no longer
> need the bookkeeping of "partial" devices.

Oh, I think we really don't want to attach the group to an ioasid, or
at least not as a first-class idea.

The fundamental problem that got us here is we now live in a world
where there are many ways to attach a device to an IOASID:

 - A RID binding
 - A RID,PASID binding
 - A RID,PASID binding for ENQCMD
 - A SW TABLE binding
 - etc

The selection of which mode to use is based on the specific
driver/device operation. Ie the thing that implements the 'struct
vfio_device' is the thing that has to select the binding mode.

group attachment was fine when there was only one mode. As you say it
is fine to just attach every group member with RID binding if RID
binding is the only option.

When SW TABLE binding was added the group code was hacked up - now the
group logic is choosing between RID/SW TABLE in a very hacky and mdev
specific way, and this is just a mess.

The flow must carry the IOASID from the /dev/iommu to the vfio_device
driver and the vfio_device implementation must choose which binding
mode and parameters it wants based on driver and HW configuration.

eg if two PCI devices are in a group then it is perfectly fine that
one device uses RID binding and the other device uses RID,PASID
binding.

The only place I see for a "group bind" in the uAPI is some compat
layer for the vfio container, and the implementation would be quite
different, we'd have to call each vfio_device driver in the group and
execute the IOASID attach IOCTL.

> > I would say no on the container. /dev/ioasid == the container, having
> > two competing objects at once in a single process is just a mess.
> 
> Right.  I'd assume that for compatibility, creating a container would
> create a single IOASID under the hood with a compatiblity layer
> translating the container operations to iosaid operations.

It is a nice dream for sure

/dev/vfio could be a special case of /dev/ioasid just with a different
uapi and ending up with only one IOASID. They could be interchangable
from then on, which would simplify the internals of VFIO if it
consistently delt with these new ioasid objects everywhere. But last I
looked it was complicated enough to best be done later on

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
