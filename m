Return-Path: <SRS0=eMD9=K6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D32D3C4743C
	for <iommu@archiver.kernel.org>; Fri,  4 Jun 2021 17:40:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6496B610C7
	for <iommu@archiver.kernel.org>; Fri,  4 Jun 2021 17:40:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6496B610C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3486460621;
	Fri,  4 Jun 2021 17:40:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cvCz2JXVj5Gi; Fri,  4 Jun 2021 17:40:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id C0BD460866;
	Fri,  4 Jun 2021 17:40:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 95A99C000D;
	Fri,  4 Jun 2021 17:40:12 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EFA6DC0001
 for <iommu@lists.linux-foundation.org>; Fri,  4 Jun 2021 17:40:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D0868843B1
 for <iommu@lists.linux-foundation.org>; Fri,  4 Jun 2021 17:40:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zXMbwHm8-lpu for <iommu@lists.linux-foundation.org>;
 Fri,  4 Jun 2021 17:40:07 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2061c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e83::61c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D50C283DD9
 for <iommu@lists.linux-foundation.org>; Fri,  4 Jun 2021 17:40:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RA/B/s3eSoV8axjp0SCm9CNH8K+i8yQb/bHmJtb7RGWoYXobvonE6PmKyZXQfYlzljB/+dBUctxmEneT5Uo9dFXI9vD2gG1ik6fYKYxkeniYRwqMZnVfThiI3EbISdaarYXRO28/ItfVHo/pdm5YtHednspmg9msO4xnE22Zi9NImW/20of+6KmtcYajnx9t4prqW/t1fqkJFlid8NQu9zk8hogzW3mdxCrlK+ZZT95VLkDaiWQpndUPPmEFdmOSJGjxlpt16t16zAYXdRb2u4FrBlXp8Z1cXWc+NcWq0Kfry7ZhGmbwrsSNxXFsbOgS/nVtVK8jMduK7fQ4aecvEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZBuL6sv6WD6NBNmJ1OyUwTW8M7E2pQ4HKWKVJxVHRiU=;
 b=N371Vhdc4XTvEk5x2wGikcNIW+hxUobL8zaIOr8v9LJ0PAY1vEhhjyoJE8yx1Q5qj/bGBupuNZMFrtVYpdpyg5nA+JD5KvhObEi9nMzge75Hmw3Iw1k3TU7vUOOjpVAaf6KGAckrQcrniUmzkYtaD32KW1obesmx2HN7JBSbzSEUeM5NgJHoqyzxK+66JbOT79ic3Uu4BuhCPTapbV7b2hW1dIrlmRP0L6l4w+6o9Gao65CqP+oZqQ3Vrbkp/5ttmnzaerkcn0lH4Q7d9R2lUOBLW1mhn1hcX5oojrhQdwkDM3chPtGalCkV0C3zftYbQVhw5RAa9EukX8hsNXn2rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZBuL6sv6WD6NBNmJ1OyUwTW8M7E2pQ4HKWKVJxVHRiU=;
 b=RDyUUkEaZDaKZ0IZgiqNPOcsm181Y5HMbGPvXPtfyxdMDzosuSSybMseQ+CsaUALsQV4TPeVNMsqyHqEvW2D6QO4JzbLJqHFBjI7VwypacnUiFxTFka9ZGHWEPRCpppNM/eAlNH6k5tQXWC+JW/Zubo+jhvzOgYghQLjomsq+pmFLtn3+SqtkE9Urly8tGXbbKa+TMvuII9fywPyM7xQQxK2/RFxBqNgXn8CBNgbYryhT+j4q3ZnoX6j/3heEHqcnfJbe0IVVFiTT8rkReEREbVGQhG3GL8/5QJUctoubE+QjrHm1puC96Iam9VaC8dBct5uM/o9crSTTeikUnwckQ==
Authentication-Results: linux.intel.com; dkim=none (message not signed)
 header.d=none; linux.intel.com; dmarc=none action=none header.from=nvidia.com; 
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5094.namprd12.prod.outlook.com (2603:10b6:208:312::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.23; Fri, 4 Jun
 2021 17:40:04 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%6]) with mapi id 15.20.4195.024; Fri, 4 Jun 2021
 17:40:04 +0000
Date: Fri, 4 Jun 2021 14:40:03 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [RFC] /dev/ioasid uAPI proposal
Message-ID: <20210604174003.GV1002214@nvidia.com>
References: <MWHPR11MB1886422D4839B372C6AB245F8C239@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210528195839.GO1002214@nvidia.com> <YLcpw5Kx61L7TVmR@yekko>
 <20210602165838.GA1002214@nvidia.com> <YLhsZRc72aIMZajz@yekko>
 <YLn/SJtzuJopSO2x@myrica> <20210604120555.GH1002214@nvidia.com>
 <20210604102743.0bebc26a@jacob-builder>
Content-Disposition: inline
In-Reply-To: <20210604102743.0bebc26a@jacob-builder>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: BL1PR13CA0268.namprd13.prod.outlook.com
 (2603:10b6:208:2ba::33) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by
 BL1PR13CA0268.namprd13.prod.outlook.com (2603:10b6:208:2ba::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.12 via Frontend
 Transport; Fri, 4 Jun 2021 17:40:04 +0000
Received: from jgg by mlx with local (Exim 4.94)	(envelope-from
 <jgg@nvidia.com>)	id 1lpDnf-001m4S-Kc; Fri, 04 Jun 2021 14:40:03 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e14a62de-b439-4fc7-2113-08d9277fc96f
X-MS-TrafficTypeDiagnostic: BL1PR12MB5094:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB5094B8E485CE39658AB4027AC23B9@BL1PR12MB5094.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tP/WzymR2c8tpUtqjZJ9r+tgA9yFpzJzanWaUrKZBVa5FH3znYwpp8IS0EzuMu3ChK6GjJbT7dgmASRoeBKkutDtTdcKhV1qYUmcFIYUBNkg1PeGzDAAb8y1xFMQTv9ikCgtHMK4EoSIaOa3/xE5b0Xs/uc1fpg8nWMMyduNz/gW6CZY4VVNpX30gRbc7IzJiv5lkes0sxPyp2lQzq6T68Bh+VkMwZTg+K5ZndFaDdhIyXNeEX2TcjdAhNa6MgOXcmzZSPSkpn9sA3zFrbMP6ohcYHUfMHnvfUGAEhDKZyRsrpFzt4d/9zXjKKKeZxYJiDyWGZmbfd/lz2ctHmH1UT2EOuAmgsSYwObQJwYUE91KavbtkDG0WlF4xCGueB4neSQlNzWg0wnkOxQTinDe/L8knU/qOTp0O3dfHekJ0Fb6v2LCegZP/Y2SrGxkbQIjg/6ZpTUNB0DOJN9lK5BXjy1bl3OZIqN0FdBTfDmens+Hjm/liEQWmQm4W8eupATHM124ZuP3bGn7I/qdUDSUtRKlja21MCMV4451B5T4H7uTG2Vkq4AbX8hNGSZiosiDQypcA5XOJE5qGh1ujn78j1AlADxnRhNWddoZiQlQdFI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB5506.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(346002)(396003)(39860400002)(366004)(38100700002)(2906002)(426003)(9786002)(9746002)(86362001)(1076003)(33656002)(36756003)(316002)(7416002)(8936002)(8676002)(2616005)(66946007)(478600001)(66476007)(66556008)(54906003)(186003)(26005)(5660300002)(4326008)(6916009);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?sVYdlMqDqeFau24gZEot8URalpKYABG+t+aaIVIwCnFfSrwlJH8avUDhIite?=
 =?us-ascii?Q?M3iZOPpSI2CnuHB7r68NRQgZTgYKCF+/c+g4Vw9JYgMbxli+CpBom7N6aYXz?=
 =?us-ascii?Q?qA1UAbx3YkTY6fVSbG+ql+davJ7Yagrw/3c3yMUaAvM0UnG173sGTdQQ53Gl?=
 =?us-ascii?Q?8n5vo3Ugz0TLMVYahwHaLCmgokysN2YdJPDM/ER4SUeyQhstBly4fwpczPgz?=
 =?us-ascii?Q?MQJ2s1CJEcGaLhsVCPV3/usWuVIUv8jIgXHL2Dk/DOPbkKJOZ4cVqHaE6LMO?=
 =?us-ascii?Q?RoZZcXtlXDUAydTLO50R3cg7TesmHQIGvAwDxOkobr6c8W+dUGr83a+OWXkk?=
 =?us-ascii?Q?MHBchdHXrfsIlipn4iPuTAjSSpRBmuK07i5titQbWOM680v4Udsd03Wl7jT2?=
 =?us-ascii?Q?2lFpkEAShGdX3bD5bfLwk2xqwPqB5v2raqVh89+Af4Q8xmiSQ79mvtXUvwOq?=
 =?us-ascii?Q?5pZ6WytaMAuWEkEZ1yz/8E0gdxSko1OSrpHZ8hhLM8OcAAWZ9MsTPT+LilPi?=
 =?us-ascii?Q?JxkGvlNHr5L/fapD/RYZASMQVvgy2ufvUN9vd18SdqnqCnUZYWAE6k0VVWYv?=
 =?us-ascii?Q?dTyCan9Dd8kOtPICVoxGoqdhNTIcODxYNBkdjtky7LrcdPQtscxmPKEAPw3i?=
 =?us-ascii?Q?ou/Bh1YjLH2yyo5H4u0vg61w4NtM/rdJjI9sZvirOpDKXYTPKlZBwW9tQ03q?=
 =?us-ascii?Q?XWCCG/NEuiC74kEQUpDuLKjtOTmt1RltTY2u+pMaHHALDhQ8rNmJthuxra/+?=
 =?us-ascii?Q?FCZAoxaM+zMmUWS9C76ilyPttOHWiuWPorxhdMLXo0HjRU8UDVLRDeW/RuRa?=
 =?us-ascii?Q?TIfVoNDGcZb/r7MS2g5pd75yt3x6APsZXG6j0zoUmGF9VACH+oL5xGPKPs/u?=
 =?us-ascii?Q?ZwnSoyN+SsuGMY0ZXIyEs+KErkidhAX7V5EzgdoECR3YLlJWJqlIdDhKSdWl?=
 =?us-ascii?Q?sjo1UJeF6ZW0sSKCJyPTufAxduZgs0vFHzxn8o+0cYhLsacj5GrIuNCDj6IE?=
 =?us-ascii?Q?GmkXOqXHvmWUzSrTuts8hxMtmoly6OVLYOBNBJb8teO2dqOT36k/OBpa/bEz?=
 =?us-ascii?Q?Fkk5OQ1gTodEr+BeVZhxAZHXdNBOrWtI+syGIXcrhLrNb6kKvm9QeThF7LN1?=
 =?us-ascii?Q?zq2AaIgshbjqDr4U1jT/qvazkm17qt0IIYhzJHH8Xw03Lp8YGmAXPPMZXbWx?=
 =?us-ascii?Q?TBxq2nDAts54qPLZ0n7Lux1kdkS/LAEbVkTtWy0SDVMRv4xdWYrzQKM7LdXn?=
 =?us-ascii?Q?A9lBz9f1/zsiicMjB4cOTn5ZIP/okrO8+knot0R98Uooy3C4a8I/cqMAf57Z?=
 =?us-ascii?Q?GDKI0iGx9ptGMyFD7sQ78Xi1?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e14a62de-b439-4fc7-2113-08d9277fc96f
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2021 17:40:04.5072 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5SQS4W12w9atWKWmPCEKK7jaKGqkN1uxbVevOIkmRmUhOP3t1AAdz7fYF7lIQBLq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5094
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>,
 "Alex Williamson \(alex.williamson@redhat.com\)" <alex.williamson@redhat.com>,
 "Raj, Ashok" <ashok.raj@intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Robin Murphy <robin.murphy@arm.com>, LKML <linux-kernel@vger.kernel.org>,
 Kirti Wankhede <kwankhede@nvidia.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Jiang,
 Dave" <dave.jiang@intel.com>, David Gibson <david@gibson.dropbear.id.au>,
 David Woodhouse <dwmw2@infradead.org>, Jason Wang <jasowang@redhat.com>
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

On Fri, Jun 04, 2021 at 10:27:43AM -0700, Jacob Pan wrote:
> Hi Jason,
> 
> On Fri, 4 Jun 2021 09:05:55 -0300, Jason Gunthorpe <jgg@nvidia.com> wrote:
> 
> > On Fri, Jun 04, 2021 at 12:24:08PM +0200, Jean-Philippe Brucker wrote:
> > 
> > > I think once it binds a device to an IOASID fd, QEMU will want to probe
> > > what hardware features are available before going further with the
> > > vIOMMU setup (is there PASID, PRI, which page table formats are
> > > supported,  
> > 
> > I think David's point was that qemu should be told what vIOMMU it is
> > emulating exactly (right down to what features it has) and then
> > the goal is simply to match what the vIOMMU needs with direct HW
> > support via /dev/ioasid and fall back to SW emulation when not
> > possible.
> > 
> > If qemu wants to have some auto-configuration: 'pass host IOMMU
> > capabilities' similar to the CPU flags then qemu should probe the
> > /dev/ioasid - and maybe we should just return some highly rolled up
> > "this is IOMMU HW ID ARM SMMU vXYZ" out of some query to guide qemu in
> > doing this.
> > 
> There can be mixed types of physical IOMMUs on the host. So not until a
> device is attached, we would not know if the vIOMMU can match the HW
> support of the device's IOMMU. Perhaps, vIOMMU should check the
> least common denominator features before commit.

qemu has to set the vIOMMU at VM startup time, so if it is running in
some "copy host" mode the only thing it can do is evaluate the VFIO
devices that are present at boot and select a vIOMMU from that list.

Probably would pick the most capable physical IOMMU and software
emulate the reset.

platforms really should avoid creating wildly divergent IOMMUs in the
same system if they want to support virtualization effectively.

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
