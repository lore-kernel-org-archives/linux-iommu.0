Return-Path: <SRS0=bVsO=I6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EB18C433B4
	for <iommu@archiver.kernel.org>; Thu,  1 Apr 2021 13:42:44 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2167261263
	for <iommu@archiver.kernel.org>; Thu,  1 Apr 2021 13:42:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2167261263
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id CA65540004;
	Thu,  1 Apr 2021 13:42:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Is-FPnggROyD; Thu,  1 Apr 2021 13:42:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id B1FE1400A9;
	Thu,  1 Apr 2021 13:42:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8A433C000B;
	Thu,  1 Apr 2021 13:42:42 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5799DC000A
 for <iommu@lists.linux-foundation.org>; Thu,  1 Apr 2021 13:42:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2FB8B414FB
 for <iommu@lists.linux-foundation.org>; Thu,  1 Apr 2021 13:42:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5voM47Kl3dAQ for <iommu@lists.linux-foundation.org>;
 Thu,  1 Apr 2021 13:42:40 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2080.outbound.protection.outlook.com [40.107.244.80])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 17DEC414E0
 for <iommu@lists.linux-foundation.org>; Thu,  1 Apr 2021 13:42:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S13qQEJCafTfjKDfK7Jj97ywFg+f3e58HftnrgHF3mHARocqfINErkIOFRXCNUcCtL36ROFXGmgh1/4A0bQNPzBicR1uHacjwVKLguJYkjGHeqXk951a5GT5pyAVIGmFVZksUfkLtx2Uen3MTBUDV/oimpgUT9AKLU516mmiIvrzcudtNmlRunHVLRl2jQZfyr2PGx7k8CPGvo8Pa6YeQwUZGlNIsl/3I4SKVXjKE6XpCMljkbLLRYZM6xELM5r9/GFRDKPwtGC2IyByWZpVVKV1CBHfpcf6mb7LqD1zF/nCGvUkRwVAQcftjBsKQr5cKesahrXojDoKdedqJIT67A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fthnHC1tlchbkHLDDg4kmayDrcxe/8FosyLQuPElWAM=;
 b=mLo3XP5In1L93qLYU1ZIyQ14Mq0iURG5efQq/imj70vprOs154dO6pNPbvePQ3+18xn4SsRZNkGd9o2+uIwRhI8kK9aIyvTRIrrYf3+OMhw4hCKWp/IowTHxcfYN2ZQykfarImOd+nGUyikkepRUVnTxguFAFO4vb0P7+sIzR8QAjC1wKbZx0YS2oSi1SpLjX3ff7nTZRKO22MXEh26NqsWC2FzQmUgT00g+C0+OXsCPRg3SYMROZ945YnJYDC0+hCRSctu6+aygWDTga0i8l32tmmwDNQfCbS+/BP9D6TtULpyC9KaoEfTLBpLr/0syF3Mg6nJ72tZMk1+048jdTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fthnHC1tlchbkHLDDg4kmayDrcxe/8FosyLQuPElWAM=;
 b=nwG7uJjRmQr6usWjkeShgT7NF6Q8vmCt8zlhQwF8yYqHidCAE9PFPFAvpmaCsq8BqHBLGPcbWLX0NZpYNwNSbPuw6B4kTcGUAFs4Pa4BtNUcoXRE+37vLBSGgW/yH5AFUZLzD36xPp39MfQTlsweLbf3V1vNPtIUH175VZ9l0oORlldtaiYysHC773NdFfC4hFgevYa2XVLR/AIRG9OfiDJ3CLk7ehfV5mBNepyVIYw9x1i8byvwdGdEglwjEu5btrCa+ajT094KdWrBWq1affAcZwta/n+lpxGovEYJP9bkeN3phYRZe4Yu1XrxhnzlGS/TZZ5JsogJPDLOhZ4TUg==
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB2602.namprd12.prod.outlook.com (2603:10b6:5:4a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.30; Thu, 1 Apr
 2021 13:42:38 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3999.028; Thu, 1 Apr 2021
 13:42:38 +0000
Date: Thu, 1 Apr 2021 10:42:36 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>
Subject: Re: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and
 allocation APIs
Message-ID: <20210401134236.GF1463678@nvidia.com>
References: <20210324120528.24d82dbd@jacob-builder>
 <20210329163147.GG2356281@nvidia.com>
 <MWHPR11MB188639EE54B48B0E1321C8198C7D9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210330132830.GO2356281@nvidia.com>
 <BN6PR11MB40688F5AA2323AB8CC8E65E7C37C9@BN6PR11MB4068.namprd11.prod.outlook.com>
 <20210331124038.GE1463678@nvidia.com>
 <BN6PR11MB406854CAE9D7CE86BEAB3E23C37B9@BN6PR11MB4068.namprd11.prod.outlook.com>
 <BN6PR11MB40687428F0D0F3B5F13EA3E0C37B9@BN6PR11MB4068.namprd11.prod.outlook.com>
 <YGW27KFt9eQB9X2z@myrica>
 <BN6PR11MB4068171CD1D4B823515F7EFBC37B9@BN6PR11MB4068.namprd11.prod.outlook.com>
Content-Disposition: inline
In-Reply-To: <BN6PR11MB4068171CD1D4B823515F7EFBC37B9@BN6PR11MB4068.namprd11.prod.outlook.com>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: BL0PR1501CA0005.namprd15.prod.outlook.com
 (2603:10b6:207:17::18) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by
 BL0PR1501CA0005.namprd15.prod.outlook.com (2603:10b6:207:17::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.26 via Frontend
 Transport; Thu, 1 Apr 2021 13:42:38 +0000
Received: from jgg by mlx with local (Exim 4.94)	(envelope-from
 <jgg@nvidia.com>)	id 1lRxam-006l3C-TF; Thu, 01 Apr 2021 10:42:36 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2030c06a-d12e-422e-8ce3-08d8f514039f
X-MS-TrafficTypeDiagnostic: DM6PR12MB2602:
X-Microsoft-Antispam-PRVS: <DM6PR12MB26029E9ECB6104EDFDD9BB58C27B9@DM6PR12MB2602.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jB9JkX3oqTuhF7nsfAV0er4ikhctdcvctlUCdVdVereqcNVVZqazrWgeHV5mjkRON1LhnCfIpgRbLL/rNcT94fQ5o5xNrNCCnuqw5hOFMj8NV5n3r03m5MWZ9Rqe6XlkYgeaHFJ7C62GRtVRqyGvrMX7l8dJDjVbKX1Q4amkxXHJaT2fEMijRCBrTWzFF4FSgG1dA3KC8DBcUcsq3QNnlQ+hJoTkid+56WyrazeEzc7dWUjE5ObrxUT3cXWAIFst7g+Mct6SYLIFpmbAuK49MbrgXc+LnF18mJhZBI+24l5skM/iNinStM6xZATPu8ipa9KMZGc1keGy43cXYzslaWfVvu8dqqVfYm3OImsJdBuHUdhF77C6hVvnV+sf3DHHJauQ5ICa1DF6HJjfPhx5r/ig1yc8rD4JuS1GvgZ6ED+5R6aaAcOIrDhndtKmPy7uFT6kJjlO65v4bjZItE7yNojnv7+YTQeSdOBK7CwlHqF5mwU8LtDnto6WQEvnGysNJMlkR/zW6qLe9iFmjJb0DUvOLrhJXb2y8ID2Tddnugvki2bsuEo1qKE6Z1RcZOawmHZuWRxfJSzhjwoJjifFdUuLJKyOKRzvrSlbGl0StRshwPcFhq6x1RoSO9LP0K0tQ7lAjvxCkPJeOW4c/+CGkcpNFbyBkfugWBlqoI1ZjC0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3834.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(396003)(39860400002)(366004)(136003)(54906003)(316002)(2906002)(36756003)(1076003)(66476007)(66556008)(9746002)(9786002)(33656002)(5660300002)(38100700001)(86362001)(7416002)(426003)(478600001)(8936002)(6916009)(8676002)(186003)(2616005)(26005)(4326008)(66946007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Uc1IWQgPT8RAdz2eSZzjWY19O5ma6gJPhdy0cf3oYHWrqdDwWuPxdLYFBYxL?=
 =?us-ascii?Q?dWB0Jz8HGIuRm+dZNO038/391yLUU5FTk7pZPeP+4hbeQuYXzA7ir0i/LYaW?=
 =?us-ascii?Q?n/2vUxaFqdo9woVdiG0uPn+asn1ZKRHyCfoGHDqkygcYF4Jq7CT+CLlZSUPP?=
 =?us-ascii?Q?fCPZUc2RotpyQuPMmzp6SDkwsK0p6XXhg7473UndF2i95r9MCIkQEML+w5bn?=
 =?us-ascii?Q?XPf5mOh0Fhqk4jeWKjS6JxSZy0/vSvTZ7XPpyr5jCyiXLHfWxGW0pXDnbMkk?=
 =?us-ascii?Q?CWVqugy/Bl3cQK69mpRfW0bOb6AHl9pG8bJzj+4OJNunqolwgUrGYvkPkqSF?=
 =?us-ascii?Q?x3idjMMeLqjw7UaACgfKCYTS37plI/TQG9BUNQmZXAxvIc98La4k+TyNoK7Y?=
 =?us-ascii?Q?QN8XQO+94oqq7ym9zS3mHHjmiUXRt2IweFT3M9LT3dK0xLUCvhqu1wjEW7Bj?=
 =?us-ascii?Q?z+xYxfUBqOi2l8yBpHDEfHUaUBiio2aajYrPWcbYsO3QspTJ0DAo+0GGrfFn?=
 =?us-ascii?Q?GjFoR4JAv3HiPgOCMe6ejku9FUXOxJr2nqmF3AlFCtxjs14sgUa3/uUCNDY9?=
 =?us-ascii?Q?LNjWh+Y2dV0LIxOOGI1cYQOfF3+02kXIDsIN8h7xNebFs4BqripOsX0xxJrq?=
 =?us-ascii?Q?h0f9G+0g9ICdJwLYBkxH7EhCaS2tLTszCqcCnzJI0+blFGQgeNGpXjO+s1k+?=
 =?us-ascii?Q?RBAUrmfeXbWLsFvZR2jt5VycE/TWXyegH8JvNwuldEmd4NMXPknEKe+5EIPa?=
 =?us-ascii?Q?Hu1wqFzKs+Sca+JXS4XyJNXsT6ZGnR8t4vY8ZFMc2sAROBi2YADzxBC6tovM?=
 =?us-ascii?Q?t/pmyI8r4rb4xdNJoSX5p7nATgfaxTDXnGpmBtI/93bWn01JNlPwVplLs16+?=
 =?us-ascii?Q?7PcvzY8fft1P3eMx8svClbnt4tjV3Ed/UnGzDDrCyrs3aEJPieyZy24SwqMS?=
 =?us-ascii?Q?L6jQE/+ubSag8OrUJY7IXKwGDBHG5GyfMgTkuIujk/d6NYI/KYU+GUb7wW4t?=
 =?us-ascii?Q?YAFamHoVbVlpDJ+1D66+d7b4mkyXSyj36wp0weURgy+805EnKpf0VsHJ0mZK?=
 =?us-ascii?Q?G1XIixyVWLrcqTYEQK6PPxH0SZvxpmG76GvKH+T++6bCaVB/J50ImKiw6t+s?=
 =?us-ascii?Q?BI0XXXFAcilYWXbNLngyPp9q0dZbtv4SdeTADnNHk8RKke9R81WwUc66z+ix?=
 =?us-ascii?Q?kdAvmH+6oP4zDGa86dI7zxl0gN81PsPh1E1O7UbiU+tzXF8MQMXvWa89/OKl?=
 =?us-ascii?Q?1mJ4luNY6D2VYG3kpmlQoebhSV4OcXUqoiO4VtfD2diSpkB3PzlbVuBdfZhf?=
 =?us-ascii?Q?tcOgCnU9Oc1jWL9lEYGiufcfxRVgLvSTADcj9V+rzZsi4g=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2030c06a-d12e-422e-8ce3-08d8f514039f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2021 13:42:38.3573 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o/Z660vurPJSoVC+hHcerDL/YxCgXgr+VfxKJTqf6HvI7jJtx3JLeitDOfHBPMMI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2602
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>, Alex Williamson <alex.williamson@redhat.com>,
 "Raj, Ashok" <ashok.raj@intel.com>, Jonathan Corbet <corbet@lwn.net>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 LKML <linux-kernel@vger.kernel.org>, "Jiang, Dave" <dave.jiang@intel.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Li Zefan <lizefan@huawei.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Tejun Heo <tj@kernel.org>, "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
 "Wu, Hao" <hao.wu@intel.com>, David Woodhouse <dwmw2@infradead.org>
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

On Thu, Apr 01, 2021 at 01:38:46PM +0000, Liu, Yi L wrote:
> > From: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > Sent: Thursday, April 1, 2021 8:05 PM
> [...]
> > 
> > Also wondering about:
> > 
> > * Querying IOMMU nesting capabilities before binding page tables (which
> >   page table formats are supported?). We were planning to have a VFIO cap,
> >   but I'm guessing we need to go back to the sysfs solution?
> 
> I think it can also be with /dev/ioasid.

Sure, anything to do with page table formats and setting page tables
should go through ioasid.

> > * Invalidation, probably an ioasid_fd ioctl?
> 
> yeah, if we are doing bind/unbind_pagtable via ioasid_fd, then yes,
> invalidation should go this way as well. This is why I worried it may
> fail to meet the requirement from you and Eric.

Yes, all manipulation of page tables, including removing memory ranges, or
setting memory ranges to trigger a page fault behavior should go
through here.

> > * Page faults, page response. From and to devices, and don't necessarily
> >   have a PASID. But needed by vdpa as well, so that's also going through
> >   /dev/ioasid?
> 
> page faults should still be per-device, but the fault event fd may be stored
> in /dev/ioasid. page response would be in /dev/ioasid just like invalidation.

Here you mean non-SVA page faults that are delegated to userspace to handle?

Why would that be per-device?

Can you show the flow you imagine?

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
