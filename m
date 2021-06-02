Return-Path: <SRS0=kThj=K4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4D48C4708F
	for <iommu@archiver.kernel.org>; Wed,  2 Jun 2021 16:58:48 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9752E61C8E
	for <iommu@archiver.kernel.org>; Wed,  2 Jun 2021 16:58:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9752E61C8E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 5FD8C4043E;
	Wed,  2 Jun 2021 16:58:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IGGsPfxUjTZK; Wed,  2 Jun 2021 16:58:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 35C14400BE;
	Wed,  2 Jun 2021 16:58:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1378CC000E;
	Wed,  2 Jun 2021 16:58:47 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 12667C0001
 for <iommu@lists.linux-foundation.org>; Wed,  2 Jun 2021 16:58:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id F3FB583004
 for <iommu@lists.linux-foundation.org>; Wed,  2 Jun 2021 16:58:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9Rpd-nio7xeZ for <iommu@lists.linux-foundation.org>;
 Wed,  2 Jun 2021 16:58:42 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2079.outbound.protection.outlook.com [40.107.93.79])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3D86A826E5
 for <iommu@lists.linux-foundation.org>; Wed,  2 Jun 2021 16:58:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ON0eOvk02TtiRS5s//jvDhhB7OBHX0ZVDmjjY++Ej7kZEkD04c3Q0A/aq2LDQfhWmkEOvQB+bmRRQjShEX0O08b+xj5UAEx9ynREFQ9vnuQk9QNJWljcw7AaTXlExM+mWpfyaBBzRxWhKpvl3uqQIt7W5/rxhEuvX656x10zuthhHBVuQs61cup7vZ9EF7ClcCf/fr2sjXGJ3omPSsqi9pkmL/MI1n1B+3XW+vCVa8N0MORa7DlnYuR6eJvLN3mZz+J625Q6M+m2zZWlBEOskBf+xSElqyVxu6+b9ymtM0+PhuCIH0NNuGNvhOam6I4KkvuR/+kDKRDtwce3cpU84g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ITGWZotb6mHzQ3KEMl8jVQ165cDtXqCfKh97T161YQ4=;
 b=bk4V2HjfJQChQ9sE/67DiyddRdOHyHUr9Hlsv4ZfYlTerFNCaAIRPF5k2nNWIVfnpqVlDoUxyN1Fgtx7AoqIl483NVuqPdUFIAHjjYTID16t1ZXNLw1CdhyQ2apUXGGLtqo0fxVnXQMsRNG0zBxHbAygHf+82uEVizi82EIQpYGAWprGJ1vaFFHQLhQz92M6hv77Vc9tuVsaSrRzNgC30TEMRzqdVhcpQTmZqbvTllj0kVB4CYmIUvwvHm5VN8P/mc/U1dgup09S09IydzLJ8UJ6e/q45lQWqy9koSgkLSiy4EScM2VjIQ1tXAHtlOppwv4JU7bK1jE1EfMq3sCCJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ITGWZotb6mHzQ3KEMl8jVQ165cDtXqCfKh97T161YQ4=;
 b=ZnfejACDeCe26UEAyved5/5yP1ilXLIjNFd/OVoHsCKY7cufopYepaflVGEKqNXGZkQR0bzwIQYBn/aKPM3KoSzIrNBkpMCuZ6VW9RGr7KRHzUOG8XWcMwxEHAAvVZ4miHFHkMiYS/iyFnd3vowg+n2Jn7BbYpnQH7wBl17BbjqI750O6pdw04hhPHo2dxn6jVLOtiE5hjk8Uniht0GBiWWGUrULi6XtAizWSzazrKUrapNIJFohQkYZ2K+eZ6Qo1bHyC9wl8wUp1Ie+kH0HXh9kzE5GZgekXFQ4u5j87MRuC4Wmyb2Xe5yV//NA8SNPFyWXPysbSygpHBpbmpmnvA==
Authentication-Results: gibson.dropbear.id.au; dkim=none (message not signed)
 header.d=none; gibson.dropbear.id.au;
 dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5047.namprd12.prod.outlook.com (2603:10b6:208:31a::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.22; Wed, 2 Jun
 2021 16:58:40 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%6]) with mapi id 15.20.4195.020; Wed, 2 Jun 2021
 16:58:40 +0000
Date: Wed, 2 Jun 2021 13:58:38 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [RFC] /dev/ioasid uAPI proposal
Message-ID: <20210602165838.GA1002214@nvidia.com>
References: <MWHPR11MB1886422D4839B372C6AB245F8C239@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210528195839.GO1002214@nvidia.com> <YLcpw5Kx61L7TVmR@yekko>
Content-Disposition: inline
In-Reply-To: <YLcpw5Kx61L7TVmR@yekko>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: MN2PR19CA0051.namprd19.prod.outlook.com
 (2603:10b6:208:19b::28) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by
 MN2PR19CA0051.namprd19.prod.outlook.com (2603:10b6:208:19b::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.20 via Frontend
 Transport; Wed, 2 Jun 2021 16:58:39 +0000
Received: from jgg by mlx with local (Exim 4.94)	(envelope-from
 <jgg@nvidia.com>)	id 1loUCU-000I5P-M0; Wed, 02 Jun 2021 13:58:38 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f3199601-1f04-4dd6-f716-08d925e7ab9f
X-MS-TrafficTypeDiagnostic: BL1PR12MB5047:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB50475EAC30CE519BA79C2866C23D9@BL1PR12MB5047.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YLK+1PYH0srXpBS7g8AwgzH0NgbFzQDrWaLhYdNvrZc1rj0ys4sgYXX/C3yi6JD1buuZ3dntHjQjFM8Uym/pmhfjSbxRWQG2Jf4F3RICZtORcGLC7kDhw8kRhxi9A8BBMR74EyiZ67eQcfrDpdFnIhdkDWhWD9Nyh4jS2Q55lVyNtcOQsR/Ptyq/da43rUdLOp6iCMjZKsNm9DPeypQ7nJGSBGqrzGidD6kbacfzJa5ZT52xTNCb6cTboi7sueGUtIqS4+LclUzO/FueUoJrwGA3BAMNu4ZsBSM04QVYZpdq4Af3RLLlKhIxoM6LO3MbMNDfxMTb+5Y2P2GMCaFoAx2ljPweqYl3haV3/5UHmvapVft3lG3cxT5W4UiKsPD4BtdWXzsjLGX8XDJ1CziPE0hi5ilH8zcP0R/fsFuM1yg2eEE0TSOoXHjExJKk4I+1QeCDaOU6wjaJBo8fYtGnH+zRw0ZAVsPHvwBYD6us4dfv1UbXRD5N0FH3f16paRIMd9WD3+tdFHXr2hvnscKNPcp10FZG9pghuWxAfX1ilDvnpc4ITaoesGOKYF1F7rcRNglODAVff49sK1kVD0nen69KKx6vcEukbcwz+96eHY0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB5506.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(39860400002)(396003)(136003)(346002)(478600001)(426003)(8936002)(5660300002)(186003)(66476007)(4326008)(86362001)(66556008)(1076003)(33656002)(2906002)(316002)(7416002)(38100700002)(54906003)(66946007)(8676002)(9746002)(83380400001)(9786002)(2616005)(26005)(6916009)(36756003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?tF3mKp4hV97hgCod4BFcgQJhR+N1dIG9VED1cEEiGcLB4SVNc29amUNH51zO?=
 =?us-ascii?Q?uS5V5zkD9YDxBBkLw1lCcjGEmAwUNflkZxONryOI8WWp53IX283ep88iZWOC?=
 =?us-ascii?Q?50SocG2DJADjoOIiNFGoFk1ZPz7zdm4DUCq2EkmuqmnFgh3c0mD3SblfC0Wo?=
 =?us-ascii?Q?NQO7hRxtmFyuxrQ1ZAFr2mXLldC5dEc7GVkF8vhZ7jUYKiD9f0nzoQ/UDIBy?=
 =?us-ascii?Q?iOlmNcZohdG8SkXY6QPeb3lhBdgYET3yyqJ1l0E8fHQcGXZtuI5MOJeq0VZ4?=
 =?us-ascii?Q?EqmNAT/glX2uMk2/FJ66KnbUYmX9L9wQFOw6Um1T3aXxe/7WmK/jd2kf3FQL?=
 =?us-ascii?Q?MaLJSkHo3kWFdwP9E22swNPzehxuD5qZ7vN344zRZBi6kTkmBLndPmJvJJNY?=
 =?us-ascii?Q?17r8p1p+yOpjNyUGPFNLl87U05axJgePV94V8QcxUiEmlzbeUWr4br6rWK7y?=
 =?us-ascii?Q?IUbevqa60sO1KBuPoHevlzL5hMRVRSqScdzqrnBwnWfPafmnb8vKaFIXwIJx?=
 =?us-ascii?Q?8IA2N24Jxk8ec7PgjZn9wKm/VfIiTik5JBgSC0AGQVsivDFwfXReGWxHsUe/?=
 =?us-ascii?Q?HIzZBcwy6fG5pNKaIHqh+B+d4FDNLzKkuk1GbzCqLLZlyjWdFqfyVMZws/RN?=
 =?us-ascii?Q?HFz99GzmSybLpDiG51Ws8pSt1J7GwGQyIeMVV1v0ula28ezUj9kSjnVp3NaE?=
 =?us-ascii?Q?COxXY5C42p8hSrHibaUCjX/jkvuPrwBWACkem4v6I8SOZl9G9dYDZUYePD+8?=
 =?us-ascii?Q?JY6fBtMYRLkguCq7aQksu0C2Q6JtOF7i3IaHDo3mDf7+9xtXyI1MJ6lG+TYM?=
 =?us-ascii?Q?PV01TnUPgY0S5MiAgzeyl4SbTE0QLcfK3uGq0HD1pZr2iM5Cc8QfPY/5TLxl?=
 =?us-ascii?Q?lliap3k5DQj+Of1HR1EZuC/cUkQbMNJzrLgnSCoQIYygyIbDV2CrA6924EFP?=
 =?us-ascii?Q?qhuRwKLL6Vs/Zg/uguPnIZpvYsyyHMcEKa0rdfvZGtlGT8uS/ULOs8fQnlTC?=
 =?us-ascii?Q?QciPxhe0MvNBQdu2iRUh45ps1F5dph2Lb3+XVq9+QWoxW15w35LbAxAURzwt?=
 =?us-ascii?Q?bRPE7QAywaUyABuRjaHDEyv/6x2rQUb1eOwVtNMaIkvCk6l18FWb5vJUshDL?=
 =?us-ascii?Q?BdzT7dqNxrvl+XFHT5xM9UqIzu33QTkQem0+WJMwp6ZWLKolqc/Ng5hvPIHZ?=
 =?us-ascii?Q?2zKf0dTnxEOVSTDvdn8VDIzp+suyE38ofM9lh0a+j5/+LfqnYsSXmlNLjPSm?=
 =?us-ascii?Q?kpgqt6T0gus75ZKxQ2KwUymqoPXyjiOJM+EbsBvJWeufQ5ebsTm4YqKj86dY?=
 =?us-ascii?Q?W8ZuzHmnNSnXa//jjoqvt1th?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3199601-1f04-4dd6-f716-08d925e7ab9f
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2021 16:58:40.1316 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JR9NPvSJ5rGtFNdWHoxWP3uKMQM5tmZclKYk3OVrCewzRGwKitiGlHHkLlDovq/S
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5047
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

On Wed, Jun 02, 2021 at 04:48:35PM +1000, David Gibson wrote:
> > > 	/* Bind guest I/O page table  */
> > > 	bind_data = {
> > > 		.ioasid	= gva_ioasid;
> > > 		.addr	= gva_pgtable1;
> > > 		// and format information
> > > 	};
> > > 	ioctl(ioasid_fd, IOASID_BIND_PGTABLE, &bind_data);
> > 
> > Again I do wonder if this should just be part of alloc_ioasid. Is
> > there any reason to split these things? The only advantage to the
> > split is the device is known, but the device shouldn't impact
> > anything..
> 
> I'm pretty sure the device(s) could matter, although they probably
> won't usually. 

It is a bit subtle, but the /dev/iommu fd itself is connected to the
devices first. This prevents wildly incompatible devices from being
joined together, and allows some "get info" to report the capability
union of all devices if we want to do that.

The original concept was that devices joined would all have to support
the same IOASID format, at least for the kernel owned map/unmap IOASID
type. Supporting different page table formats maybe is reason to
revisit that concept.

There is a small advantage to re-using the IOASID container because of
the get_user_pages caching and pinned accounting management at the FD
level.

I don't know if that small advantage is worth the extra complexity
though.

> But it would certainly be possible for a system to have two
> different host bridges with two different IOMMUs with different
> pagetable formats.  Until you know which devices (and therefore
> which host bridge) you're talking about, you don't know what formats
> of pagetable to accept.  And if you have devices from *both* bridges
> you can't bind a page table at all - you could theoretically support
> a kernel managed pagetable by mirroring each MAP and UNMAP to tables
> in both formats, but it would be pretty reasonable not to support
> that.

The basic process for a user space owned pgtable mode would be:

 1) qemu has to figure out what format of pgtable to use

    Presumably it uses query functions using the device label. The
    kernel code should look at the entire device path through all the
    IOMMU HW to determine what is possible.

    Or it already knows because the VM's vIOMMU is running in some
    fixed page table format, or the VM's vIOMMU already told it, or
    something.

 2) qemu creates an IOASID and based on #1 and says 'I want this format'

 3) qemu binds the IOASID to the device. 

    If qmeu gets it wrong then it just fails.

 4) For the next device qemu would have to figure out if it can re-use
    an existing IOASID based on the required proeprties.

You pointed to the case of mixing vIOMMU's of different platforms. So
it is completely reasonable for qemu to ask for a "ARM 64 bit IOMMU
page table mode v2" while running on an x86 because that is what the
vIOMMU is wired to work with.

Presumably qemu will fall back to software emulation if this is not
possible.

One interesting option for software emulation is to just transform the
ARM page table format to a x86 page table format in userspace and use
nested bind/invalidate to synchronize with the kernel. With SW nesting
I suspect this would be much faster

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
