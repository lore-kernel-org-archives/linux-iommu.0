Return-Path: <SRS0=TTgE=JT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81FC0C433ED
	for <iommu@archiver.kernel.org>; Thu, 22 Apr 2021 20:00:36 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E02E861435
	for <iommu@archiver.kernel.org>; Thu, 22 Apr 2021 20:00:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E02E861435
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5D5C960C26;
	Thu, 22 Apr 2021 20:00:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JzzBbzuM8r23; Thu, 22 Apr 2021 20:00:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 19F1860908;
	Thu, 22 Apr 2021 20:00:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E42DDC000E;
	Thu, 22 Apr 2021 20:00:33 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C13C9C000B
 for <iommu@lists.linux-foundation.org>; Thu, 22 Apr 2021 20:00:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9B52783EF9
 for <iommu@lists.linux-foundation.org>; Thu, 22 Apr 2021 20:00:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4FbNM3lMAZh7 for <iommu@lists.linux-foundation.org>;
 Thu, 22 Apr 2021 20:00:28 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2079.outbound.protection.outlook.com [40.107.93.79])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5D10383EDD
 for <iommu@lists.linux-foundation.org>; Thu, 22 Apr 2021 20:00:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DReJYAlTu4k89jbvORYnIRFIC0dEqWDR9+cbpLdf37crlh3ugXcu1i/NKOMdydGFwZF73i8PoqHHUNZh/FJhjYvZDBsUxFOF6+UykBRmTZeBixRckKgmquszvqSetYoM+Behjovsj8Tff4fvWZCkIBEYNoK6mKgEXQj7mJxFBMw3XrbExfap38MyoXXtLTMRi8UKA8aICi9rTWHVVmHcWBLIU5ZGCGLURLSDVwf8gDDxITAjKMBP1CS5D+Iew+Z5kgpLdUfd6rDy3jraTNj6FEez3hk3XZOpx+badErViOHMSVEegkdJPJp36HKb5tJ6wL2GIu9A3KCRCgXvMN2ypg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wpI3uhw2idxvllqb0b1WkVBppdZyY4wvA+Jrv6UhY1U=;
 b=lbS0KTR0piovB+zGUd4lsm4q2VlcvMoUQaZdwjDyfPH7d/aeX3h17rkFKjcZ3O1Naecy4LzNVg8LmqrXmmxFW2bSX6Qg+nn4WbkuF6ZgNOOa5oBPU55taz2KGzGVnYCnXXMPMtSwmsck4J+DNHGcj10C1Lgga8VEo90TWl4ZaO1Z2wJyZ1VGlO8v7u+Zkl17fCmOyfBt+US7j1wwNZbqwKASLOGAjoHOnG7LffEw9XAxHfSUyxFeMy1damgHCUbuUZ4FC6Tc2l55fHAmHEk/8tpSdwFloC/6xcWcBgiEzYt8aNWLsLw3jrZeuKm76JuZBA696aju4VLdjb8RHdoGlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wpI3uhw2idxvllqb0b1WkVBppdZyY4wvA+Jrv6UhY1U=;
 b=fKgcVqCdyqCpiValgGc/Jaq/WZeBPs1zcFx93cdDLFGYCtcuycqa95glEgHfAMjhxBAZs1EkLxudXjiqubXQviyOBOV8iEnWXdfdRpxYhxu7xDqC8Uljw24myqlEev7sOC0eQvG2opzXLC6ytQbaTgsD0bfUWyZYB8OTpG31wLQ9MNeUIDLFNJ63audeTyzslprl8eO8mKYRtKXbFsoyZmvNZs+YdXm8VC4fKOAznB6TEs3KaavATQuqORpKv/zNmr7Ip//aLEcjB0IPUUWv2TxVPr5t4msGDnb/643q91KZ7ZQIvpXqPdx8WIWMwIXD5KmKgN3dJZ6X1mbyO0zfOQ==
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4500.namprd12.prod.outlook.com (2603:10b6:5:28f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.18; Thu, 22 Apr
 2021 20:00:26 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.4065.023; Thu, 22 Apr 2021
 20:00:26 +0000
Date: Thu, 22 Apr 2021 17:00:24 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and
 allocation APIs
Message-ID: <20210422200024.GC1370958@nvidia.com>
References: <20210416094547.1774e1a3@redhat.com>
 <BN6PR11MB406854F56D18E1187A2C98ACC3479@BN6PR11MB4068.namprd11.prod.outlook.com>
 <20210421162307.GM1370958@nvidia.com>
 <20210421105451.56d3670a@redhat.com>
 <20210421175203.GN1370958@nvidia.com>
 <20210421133312.15307c44@redhat.com>
 <20210421230301.GP1370958@nvidia.com>
 <20210422111337.6ac3624d@redhat.com>
 <20210422175715.GA1370958@nvidia.com>
 <20210422133747.23322269@redhat.com>
Content-Disposition: inline
In-Reply-To: <20210422133747.23322269@redhat.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: MN2PR15CA0045.namprd15.prod.outlook.com
 (2603:10b6:208:237::14) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by
 MN2PR15CA0045.namprd15.prod.outlook.com (2603:10b6:208:237::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20 via Frontend
 Transport; Thu, 22 Apr 2021 20:00:26 +0000
Received: from jgg by mlx with local (Exim 4.94)	(envelope-from
 <jgg@nvidia.com>)	id 1lZfUu-00AJR6-VH; Thu, 22 Apr 2021 17:00:24 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 869cf86f-601f-42dc-039a-08d905c9458f
X-MS-TrafficTypeDiagnostic: DM6PR12MB4500:
X-Microsoft-Antispam-PRVS: <DM6PR12MB45004F6E5797EB669D4A2EACC2469@DM6PR12MB4500.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5uMKjjMcMIjmNmI2LIfeSWg3YG/l5jQxb60Pvtm380W5ifWx+/OVl2apZL4ndKFSmT/4cmkuRcm0xZgFheotuRb2iAZnO0dEJAQzkRilUfp32aruyTK9TZPDBLOBNk2N+5jkHb8S4gnUrZcJMMrtfCeAhS9LJVz3V4252q8HWuu+ntBrZUckWlsQLu76xRc1MhOvQDCxFDasuoL5lPk9FtWB4KPcYY/CqFSwk5dl5M4gUhhBp+K5+jpsFBvenkafkZeixtR8vxfsO0vQVZMyi/mtj1wO59999NxA1R8oebgJ5CAEbpGDvBxOvGN/eZmwjdE7+SaT8Zol04CY9mVNY08GAybnnFi/kNxbGFapiuCENL0iVWSvHVD2Jaw8AeEkRBcwhkDyH+/ZnF0OqwcCut2kCXgSBc9/DgEr+w3uh78CEW+/ONbDAnCyEkYVpInKXJFVRemEsbUADvtgJWJkPU5uhtRL/ZM1KwFJr42SHVvp85GH2pfso2JiVFRz3XMTaiI3cU28BmwMboCX3MR1Q9DCz5GYqNErOkka3OpPxIJDqMVKnOZbKZ0Ol1puha7W29Tk2NOC+iIMl/+oFVLX/p+/mOlcCCbbcpyRlGiZEXw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3834.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(366004)(346002)(376002)(396003)(4326008)(9786002)(9746002)(66946007)(66476007)(66556008)(33656002)(8936002)(2616005)(478600001)(6916009)(2906002)(86362001)(8676002)(38100700002)(26005)(316002)(7416002)(83380400001)(426003)(186003)(1076003)(36756003)(5660300002)(54906003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?B35Jd0iIdmZnkFl8UG4+GdrWhNyN7vKedlZz1B0s2oqs4RPClt0c+nKEQ8bW?=
 =?us-ascii?Q?rNN6KIYzk3ONX/ktGZI0/dymSjQJE/gubnzC8Op1D2POM7JFashCc/Tk0Dnt?=
 =?us-ascii?Q?h0oO6jx2fL/SrRRW3oYnQ3d7pqNobYtXrmA6/qXz2G+Y1eSJ0oZc2oQQEl0t?=
 =?us-ascii?Q?TmOEomFnz5QSGPFD6RoNSM6tvJPCXYJOPsBw6x1HuH1cEvawAOPxTqDRWY0b?=
 =?us-ascii?Q?R6kArEblKmO5Ohse2gxJroVmkBSXq5rk8RkrCvLYIBZrQmOu4GmanfBlS30O?=
 =?us-ascii?Q?d273uZD3OPiqk7IBfo/sty9boYZ/t5iDk8Em7WjqeA8n1MrmSf4gAXKCB/IM?=
 =?us-ascii?Q?I0zjNGvl3qfb82+dLbQUVoFuSkvrYejcKfcqUhJIu59A0J3jRexKfoLbmbML?=
 =?us-ascii?Q?G4Vruh76DTBBoWeqZ+51lJUt3BvNJR/0bZ3Q7C5Sl8S0bTCUrc+/+XFkIqff?=
 =?us-ascii?Q?AnTvYJA1l9xeCL/uumZRMemFdv2ckdIBKbFFb3PAgPllBb3CrJrfPXYIEOEP?=
 =?us-ascii?Q?eV8JJpek38jQMAux4jS31UlAwi1wHqm1MvUrjfosFdJWSPBVme4kMHVb0UOe?=
 =?us-ascii?Q?PDfudXIPWIVlYxYG9QmrApON4WvSyL8Yj5rseNTEgg+26l0ymc+CbVxXDpBa?=
 =?us-ascii?Q?O0MiQ4bt/wUE/lWq04PUZ/jSb1XWCT4LqZNjeXIJQakNSqaq4HuxqDRvJ70B?=
 =?us-ascii?Q?JOrNRwoL2YKyIfY9A2uEbkcNtxvx3YsCRcFM0HYf7syKNpc2CKGuVKw3PCP2?=
 =?us-ascii?Q?fOBKyRnWOaednQSIWLVYCNmZNEUAWOrC/pTpxkWhj8Ws7UX/7biBBYMZHfa5?=
 =?us-ascii?Q?D4t2qOjqeOIpseDOOLH6hHIGSQ4vm7gM/t2tNj6q17vydXSm4TfA4YhA5RFn?=
 =?us-ascii?Q?mloMrzd1ZZWhEDI7IsxJ2TZZM6JfbjUfHJWd4hXNM39J7MF5u3qHXed61LbO?=
 =?us-ascii?Q?cprcUjK0Ga58a7cFJoRB5BB4nQtX7QbgoKhyyS1VJV6yftqULDWEr5qi/Wuk?=
 =?us-ascii?Q?cOPc0cqEnLNqJHNooXGbMKoYR9/+IRzI9p+Mt1+LWwrno8x8KVnY5wI5VQaH?=
 =?us-ascii?Q?P2GmULMuyH9ZZPMaN+kxrTaUie5P7/u+3lMRV7XXe790mTxGoUIHSN8llxsC?=
 =?us-ascii?Q?xOgaYRQxREfrnQjZcEx4DSQqk9A7OOLKstOIOVRSooa82l4lw4/qrxm4qK9z?=
 =?us-ascii?Q?1y+CwcFwW6YdOQjIFJ+LE3O/gfL8XVAb1Teg2XlQxnNYy47iB45Wvg1QfQIL?=
 =?us-ascii?Q?+O/Y5Xzcc91jAZwN+N3IyOn0IxMMmFZZblGt+voI6HoQ/0SFximJsKv9/BeA?=
 =?us-ascii?Q?2ycm6Abi5hUAXvQWFoGnfFU+?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 869cf86f-601f-42dc-039a-08d905c9458f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2021 20:00:26.6040 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GmOhtSOUAeWmmU0Uty/6T6N7VtgOIpxFhkzKhqeQ9KTQzVbot1KIoM21TYhu8TpV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4500
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Jiang, Dave" <dave.jiang@intel.com>, "Raj,
 Ashok" <ashok.raj@intel.com>, Jonathan Corbet <corbet@lwn.net>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 Li Zefan <lizefan@huawei.com>, LKML <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 David Gibson <david@gibson.dropbear.id.au>,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Thu, Apr 22, 2021 at 01:37:47PM -0600, Alex Williamson wrote:

> If by "classic" you mean conventional PCI bus, then this is much worse
> than simply "at risk".  The IOMMU cannot differentiate devices behind a
> PCIe-to-PCI bridge, so the moment you turn on the IOMMU context for the
> NIC, the address space for your HBA is pulled out from under it.  

Yes, I understand this, but this is fine and not really surprising if
the HD device is just forced to remain "unusued"

To my mind the bigger issue is the NIC now has access to the HD and
nobody really raised an alarm unless the HD happened to have a kernel
driver bound.

> the vfio world, the NIC and HBA are grouped and managed together, the
> user cannot change the IOMMU context of a group unless all of the
> devices in the group are "viable", ie. they are released from any host
> drivers.

Yes, I don't propose to change any of that, I just suggest to make the
'change the IOMMU context" into "join a /dev/ioasid fd"

All devices in the group have to be joined to the same ioasid or, with
the flag, left "unused" with no kernel driver. 

This is the same viability test VFIO is doing now, just moved slightly
in the programming flow.

> vfio users are extremely aware of grouping, they understand the model,
> if not always the reason for the grouping.  You only need to look at
> r/VFIO to find various lsgroup scripts and kernel patches to manipulate
> grouping.  The visibility to the user is valuable imo.

I don't propose to remove visibility, sysfs and the lsgroup scripts
should all still be there.

I'm just acknowledging reality that the user command line experiance
we have is focused on single BDFs not on groups. The user only sees
the group idea when things explode, so why do we have it as such an
integral part of the programming model?

> >    ioctl(vifo_device_fd, JOIN_IOASID_FD, ioasifd)
> >    [..]
> >    ioctl(vfio_device, ATTACH_IOASID, gpa_ioasid_id) == ENOPERM
> > 
> > I would feel comfortable if the ATTACH_IOASID fails by default if all
> > devices in the group have not been joined to the same ioasidfd.
> 
> And without a group representation to userspace, how would a user know
> to resolve that?

Userspace can continue to read sysfs files that show the group
relation.

I'm only talking about the group char device and FD.

> So the group still exist in sysfs, they just don't have vfio
> representations?  An implicit grouping does what, automatically unbind
> the devices, so an admin gives a user access to the NIC but their HBA
> device disappears because they were implicitly linked?  

It does exactly the same thing as opening the VFIO group FD and
instantiating a single device FD does today.

Most software, like dpdk, automatically deduces the VFIO group from
the commandline BDF, I'm mainly suggesting we move that deduction from
userspace software to kernel software.

> basis ownership on the group, if a user owns the group but the group is
> not viable because a device is still bound to another kernel driver,
> the use can't do anything.  Implicitly snarfing up subtly affected
> devices is bad.

The user would get an /dev/ioasid join failure just like they get a
failure from VFIO_GROUP_SET_CONTAINER (?) today that reflects the
group is not viable.

Otherwise what is the alternative?

How do we model the VFIO group security concept to something like
VDPA?

How do you reconcile the ioasid security model with the VFIO container
and group FDs?

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
