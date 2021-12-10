Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EA2BC433EF
	for <iommu@archiver.kernel.org>; Fri, 10 Dec 2021 12:30:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2A01B425F3;
	Fri, 10 Dec 2021 12:30:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id E0tz3dAAilyg; Fri, 10 Dec 2021 12:30:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id C9C9E42542;
	Fri, 10 Dec 2021 12:30:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 77977C0012;
	Fri, 10 Dec 2021 12:30:36 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B464AC0012
 for <iommu@lists.linux-foundation.org>; Fri, 10 Dec 2021 12:30:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8E3FD85313
 for <iommu@lists.linux-foundation.org>; Fri, 10 Dec 2021 12:30:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IBs7gxZoQfav for <iommu@lists.linux-foundation.org>;
 Fri, 10 Dec 2021 12:30:34 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20630.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::630])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 462B385292
 for <iommu@lists.linux-foundation.org>; Fri, 10 Dec 2021 12:30:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gu5CMrxngDS1yy5MVXtdwk4zrlKIU40ZMoa7LgJblZQVQlzIAoprE/q6l5XugkYmoDjLEUyPl6xcV4fCmZf3y/tl+Dj9J4CQL2cE5AmfGIsK/J5ASAJILqRI8hf5nD1GV7V1XGiFxnFLdEP0hqXyhc81a9Mlto+0OYNhlgvDdDfz9FWxIQ3TpFWIOpAH0lGdgdz09qoCP0DhkTe9PmmyWRHSwPHE0KJSzmbSRw7w/sRV0Rx+sYieqJmj1zI/vMOWN1lNP/6yLrw3wQyCqM9JlAGacp+CaFiBhI3Ime91VTkXjbkrdtWtXt0/Nlvj7LBQB/UQ4sT7ZQFPPTHDBYDwnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Vc9XEu/HF/mw+9vjsMr0xpXkkWqJbrTDGPuUppisAU=;
 b=YmxN6OdoPaPpBzw6eLY5gBRRDVRS52k7llqEPGZ0N9TLEg6A/mLJbeoWxgM15FpLsDRS5CPMDOLayzIZ2MU0Wj4a8yVH2bJtkMCoj64l+Bc3whOom5W2594tnJv2CP05gB5mSS6OlM08ZVIEv0lhM+3OBTbPvTA2LQ2UqoX9k3tMob3WJEcAjb2DBSMC3I7UQ4iCJoC+unqKdH71G0hD/hC61VPPTQMccFyqZJd+dqTin3XL/oXD6sbkodHtY7SkeIgihaOnWeho/6JbLc5zh3MZ5OHJNBlj0fjjTOMjr0+fSapAxWrk9HaaN/fT7miK7xU7ju1o7ISP6kIwM1mYWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Vc9XEu/HF/mw+9vjsMr0xpXkkWqJbrTDGPuUppisAU=;
 b=R71nXRaSL7lxUeD1pjbZb5u4HsvwTFsUkaNsKof9man/fVO6XdY5WEOXl5diKAZOUoNPLQ4FLie47Zs8G7eaIHmzp5agjMVus+3rnCBTinSzV+0ChSuTCW18C61BsWZY1OPcvMhpYVs1oIzcK8qYZ9GQgLcqauZ7hRSrlXMKTpQbohPptBRMlhWGak/gGrOFGiuqT/mKhgqTIX4N8/0dkw4Z0Dx1hiiX1rECFQxUrsYf5gANd3S4kg5uOb9wr9qFBPqJVRndYngsGc8F0+DPE86/JIVGQ4N3VlnYH4DwfP8C/N1+BhxbCc33yB0lLYwIHrv6SM7xMfsjOj8mdStxXw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5285.namprd12.prod.outlook.com (2603:10b6:208:31f::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.12; Fri, 10 Dec
 2021 12:30:30 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d8be:e4e4:ce53:6d11]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d8be:e4e4:ce53:6d11%7]) with mapi id 15.20.4778.015; Fri, 10 Dec 2021
 12:30:29 +0000
Date: Fri, 10 Dec 2021 08:30:28 -0400
To: "Tian, Kevin" <kevin.tian@intel.com>
Subject: Re: [patch 21/32] NTB/msi: Convert to msi_on_each_desc()
Message-ID: <20211210123028.GD6385@nvidia.com>
References: <df00b87e-00dc-d998-8b64-46b16dba46eb@intel.com>
 <87k0go8432.ffs@tglx>
 <f4cc305b-a329-6d27-9fca-b74ebc9fa0c1@intel.com>
 <878rx480fk.ffs@tglx>
 <BN9PR11MB52765F2EF8420C60FD5945D18C709@BN9PR11MB5276.namprd11.prod.outlook.com>
 <87sfv2yy19.ffs@tglx> <20211209162129.GS6385@nvidia.com>
 <878rwtzfh1.ffs@tglx> <20211209205835.GZ6385@nvidia.com>
 <BN9PR11MB5276599F467AD5EAC935A79E8C719@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276599F467AD5EAC935A79E8C719@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: YTXPR0101CA0047.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::24) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 44481053-c0ae-4ed3-710e-08d9bbd8da0b
X-MS-TrafficTypeDiagnostic: BL1PR12MB5285:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB52856E3D1700E2EC13AE69EFC2719@BL1PR12MB5285.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MJ/WO+GHjPUc20CElGuMaL7GcuvH7TJ5Xlx9LINUHgG2cI4kzZW/mW5eZmyCuT34tdVAd/BszOQWvUzVTKahhkmR66fxPnMDGGXhyIVaqmlAj9qO4ItYD2eMGHD7sRhU+kOHlhHOeOGpw/uWrGHSuMsSTAy2/Y6q6tvi9uFTWs4JhzAxCN84ueOqRZPYXmu+R7MgAv6nSvHZxwQQlEf7i2exR8pHzTTVrQadng/j2VI7MzdtF7w9S9RmTgr7Cua6OQxKNLdyseoIvKQYOkoUlPg/nl2Ih0BprWY9W0tiG/L70wLIjlnz/X+FtNa8uX64bFXxV4/R0cKhsrx/7eB6Mr7MFB7OXKGAzvOdPMSGZzXLeiCrxW4dq2CPSIRlL8kSkszplyg8Kzups79kqdcRljytCz4VO7StVNAwXLdLJ3aOOqy0UC3tItGuuKYtKLwyb0ZLJCblwN4LarXHFFRrFhgOWPu+/fAMbH1JSAbQ8gBxwyaIHRhSccW8gCimWwsDawhl+jnTsF5kuXnzCtkJoADFeC9NWND3IaCKlqYPQJk7DwZmp88xBxUZquOp3NB437aB7bQkv/K+tK9DIXGETLjqSg0mVNucJMAg2Wi5LznotMPjOmI/JtjnYb889AJ5IrBRIF86M2wwDBn+ObCw2w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB5506.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(36756003)(33656002)(83380400001)(2616005)(86362001)(186003)(26005)(4326008)(5660300002)(38100700002)(7416002)(1076003)(4744005)(508600001)(316002)(8676002)(8936002)(2906002)(54906003)(6506007)(66946007)(6916009)(6486002)(66476007)(66556008)(6512007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/AQi6wOzUMnEgpm51M5pU936BFk4jC1x1SRFWSzHLVfYZ6tk+AO7GlpFUduh?=
 =?us-ascii?Q?t3CQpCSDpWk7UsgUXywpHKkAbjmW/867ZjvIc0STh6awn9YB/yLmsOixkXGh?=
 =?us-ascii?Q?GIcyk5NLVwAfGhDqOaynY71cyXIAnTsNtL9lGEs1rqrM9XXyS1EKXGF4GYW3?=
 =?us-ascii?Q?xy/l3R1GOZOVL3Dn5tVqs1IoagzQddjt6aewaJ4KXUC2OZeYZXYf709cJJRa?=
 =?us-ascii?Q?OB3ttAhzeMfyaA5ILGuwBqZ6Er9zwJuMuwzTY8rG4q0SG7YmAOfu9hl6VHOR?=
 =?us-ascii?Q?tejPpWEk67pgqyilHaPOlQ29VNrqK9iq3ztfpShmISumNbafp0nAXNhgD1+G?=
 =?us-ascii?Q?UQEuOqX83MoSX0yv0ykoFoR/LGd4Q10aJ36KmHgQzAwgdh2su0IWjiT0l7Ww?=
 =?us-ascii?Q?6FtNUFxjdjY9r25qwy0gfxWnetwZAv5lQ6SRZ9C/hiofpMcsw/HXa7Hnl/0D?=
 =?us-ascii?Q?Dx3FhAysiVgYoQS2rqnsoIiAZNjPgxxVImBGxAPKJk6dasld7n5uLGRYrVts?=
 =?us-ascii?Q?uEZY6PtVZgtq2t2BpbjJrQYtm/k0jKpIXZjNpn6zLkP1O8yRd39oZZOvhoge?=
 =?us-ascii?Q?BXphBnAEwyAySltHDSYT91XZQIzCRAl6V5StIM+l2LLSMwRbpIvxED96q4pn?=
 =?us-ascii?Q?FySwGFXdHFdlwokQoJBWDc4loW+HNiiUl/wMBx9Tv+SY572eSG3/biuJf4pL?=
 =?us-ascii?Q?jOOdp8y4AAfFAjkatek43p8A9fEgjYK8XOWnM3uJ2GoMI2LrF0TEj76RJs38?=
 =?us-ascii?Q?vra4evdDHfqrYX0eJ0zeh9svl/23OJCSuHf57MyUA5uvOHECeNuN4RiXhRSl?=
 =?us-ascii?Q?qMBzcjRPbMnvPvHHUykIixW7nsDlKGQf/WlBJpgBMTmQS/F6p+vlZH8gzuZA?=
 =?us-ascii?Q?5D26Yiwk93OWT8nbxOxQMCPPBseSk8hlNuUT+AQYzvSurw3MqkmG8KhQzT1o?=
 =?us-ascii?Q?NVsewcxSLicCH6jYozJqIryVBbYDMT9Wl87k9jTvi2RQvwsvBCMnqicD7i/X?=
 =?us-ascii?Q?8OVzjZJ41IampGzW3vGbRnU/6qeRlGE/O/UEmuWLJU99Xj1NSMUmu5sb3oKC?=
 =?us-ascii?Q?yvekQ2oZoPRQj1QL4eatr1XaxKnKHhsh6YrbXvI7q6mKmL4n2iwrF3hCKNeT?=
 =?us-ascii?Q?W+Agru9vs6ajDUWzaR+EeEY+UNpf7ucqdNszQli1YGwMCbdmnleJR3gS6DHd?=
 =?us-ascii?Q?JI1lmrjZAen97u5WozSaGx90TrZecHmWgxiPPSCcHag5co+bW7EYzyhs8dV7?=
 =?us-ascii?Q?HLd012x0v0CHUZ+XAbZUeccTolkWL/YGNI5dG3AhVvkhZQJPqcqtoR75a5SV?=
 =?us-ascii?Q?7UCU6gT5OlavlDBt2rmssZrvtQtMO7TtcE0+6s5X+qTGj+6WOmICRFBu6r0f?=
 =?us-ascii?Q?ZUfoShv5aZBiL7MgNGtCPtNmZlz+AjgGqCeOuk3XTDJVueem2RD/fxdukjnw?=
 =?us-ascii?Q?Gcse1FM+qOGxphVs4wl9XmvkLOozeCvf72mtHXhtnSJEqALRC7O/LAEiwhWP?=
 =?us-ascii?Q?V7gd0gXDTjct5EwG7UIPnQs0oBzUuQ48mx3enwD1N1hCZKKvt+qz3C2htwqf?=
 =?us-ascii?Q?vbda9FpA6qKdIbkdkWQ=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44481053-c0ae-4ed3-710e-08d9bbd8da0b
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2021 12:30:29.8898 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lYFVc3o7rAi0qCemi0BIdqgOeFI/2gbUrPbdPyCJAcfHD0eZO9WWhYnimevRZXir
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5285
Cc: Allen Hubbe <allenbh@gmail.com>,
 "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
 "x86@kernel.org" <x86@kernel.org>, "Jiang, Dave" <dave.jiang@intel.com>, "Raj,
 Ashok" <ashok.raj@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Marc Zygnier <maz@kernel.org>, Heiko Carstens <hca@linux.ibm.com>,
 LKML <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Alex Williamson <alex.williamson@redhat.com>, Joerg Roedel <jroedel@suse.de>,
 Bjorn Helgaas <helgaas@kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-ntb@googlegroups.com" <linux-ntb@googlegroups.com>,
 Thomas Gleixner <tglx@linutronix.de>, Logan Gunthorpe <logang@deltatee.com>,
 "Dey, Megha" <megha.dey@intel.com>
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

On Fri, Dec 10, 2021 at 07:36:12AM +0000, Tian, Kevin wrote:

> /*
>  * The MSIX mappable capability informs that MSIX data of a BAR can be mmapped
>  * which allows direct access to non-MSIX registers which happened to be within
>  * the same system page.
>  *
>  * Even though the userspace gets direct access to the MSIX data, the existing
>  * VFIO_DEVICE_SET_IRQS interface must still be used for MSIX configuration.
     ^^^^^^^^^^^^^^^^^^^^^

It is this I think we don't want, there should be no hypervisor
involvment on installing the addr/data pair

Guessing by what I saw in PPC there is a hypercall to install a MSI
and the guest never touches the page even though it is
mapped. Presumably there is some IR like thing making this secured

PPC has the same basic problem, I think they have a hypercall to
install a MSI, not a hypercall to provision a generic addr/data pair.

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
