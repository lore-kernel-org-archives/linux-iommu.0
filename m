Return-Path: <SRS0=bVsO=I6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92CCFC433B4
	for <iommu@archiver.kernel.org>; Thu,  1 Apr 2021 17:26:16 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40A0261373
	for <iommu@archiver.kernel.org>; Thu,  1 Apr 2021 17:26:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40A0261373
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 02A7060BE8;
	Thu,  1 Apr 2021 17:26:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0gCU8acHS2O5; Thu,  1 Apr 2021 17:26:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id BA23B60BD0;
	Thu,  1 Apr 2021 17:26:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 94587C000B;
	Thu,  1 Apr 2021 17:26:14 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 44A6AC000A
 for <iommu@lists.linux-foundation.org>; Thu,  1 Apr 2021 17:26:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 19DC241870
 for <iommu@lists.linux-foundation.org>; Thu,  1 Apr 2021 17:26:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kappjPM_ijFz for <iommu@lists.linux-foundation.org>;
 Thu,  1 Apr 2021 17:26:10 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20609.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::609])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5424240F9E
 for <iommu@lists.linux-foundation.org>; Thu,  1 Apr 2021 17:26:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G7n3eZXagTwg3F6QTliwUyA0m2UTWOWHfZ07O6l+f2n+GlQRjj4F67Oq1qjA400PydCY14GBzFdx5AuO4orBQjqkyCHcepGTLFlVLSXNwxNp3YQcdRu0Tb1KgnIAxCjvdYyyTIz+b6GXINLu/MhcuEumsoyIVdDU5HLQKbPZSUGI7U5rvRa42xjOGVB69vMTJN9pIwCt7LIlQfnJm+aNSSDjpwHQKfKyV+6aSFZ2HVpuQBZckS1BE6nM7VD0kgPGiufbE1blF4zQwEJnsL0QPf1KUHC0BsrDnHAMUL6DOV74VIH1WoQnONOSjLMILT+hykYNiP/ymxYdsRq42nFuwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ziwf1w5DA8l+3uM9hK6DzOugzV5jzyrNOz7y/RdgICY=;
 b=DwVj2p0U9QoaiQcSP/dxOEdcOQZGVNtcOraaBM6Iw6iawcOuh4jWVjy5s/ZKHHd0svIgvSl6cvFC7dptRXMW4ynvuyLlMc4/7m5EG+qNJvezsnoQsIA3FfUsYOORb7gRE9bu/pLASpqr8/7QunZwUJj9fSxHmNjQds1VNpJ1ipbDxY3pOyaGD09Gcr1QiAdCApdzRNAcN9DMbR1jtk8+9k/oN5NR5OD4VrbdN8XqcsRmbIKYrf9dO8v6/khbybBVVNZ8qOjno/uNi4qEIaYPfc3Sbqk4pb/DZumNS6Mek1pDQkiHziyl/vCKgqLwJKxmypGrgU+D2BHKQbVOJiEiyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ziwf1w5DA8l+3uM9hK6DzOugzV5jzyrNOz7y/RdgICY=;
 b=ODGfMh1+QBZDYa/FGBFHjgz5L8qh0H3bOxSDR5QUAA3YbCV9H+bfGlCK4+wr6CiNpEHzvF3y0LqDy0FgACGthypU2LGcNB/wFqHKT4VSE60R8Lr63OYmrlh435wMpJwCi+47ShEqutwZGISH297ecxN59g1yL3JrJ39XAJAbfVnQqe3WsJBjk0RzDP1pelWLr/nkPhZUnDrmJ0hYM6Si1K0XutEYjvhuWDhLbAHNXFR9itvetNrPpQoyg214XK3P5O7xL8pN+hV7z8mRj/IEFb/OMaj2sF2Nia0oq4sClV8BZ7wwEcjUNqNqg6R7VOkhKgcinqBPJ7mv0o76e+499A==
Authentication-Results: linux.intel.com; dkim=none (message not signed)
 header.d=none; linux.intel.com; dmarc=none action=none header.from=nvidia.com; 
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1435.namprd12.prod.outlook.com (2603:10b6:3:7a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27; Thu, 1 Apr
 2021 17:26:07 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3999.028; Thu, 1 Apr 2021
 17:26:06 +0000
Date: Thu, 1 Apr 2021 14:26:04 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and
 allocation APIs
Message-ID: <20210401172604.GK1463678@nvidia.com>
References: <20210322120300.GU2356281@nvidia.com>
 <20210324120528.24d82dbd@jacob-builder>
 <20210329163147.GG2356281@nvidia.com>
 <MWHPR11MB18867EC048E3E3FA37F9C38F8C7D9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210330132740.GB1403691@nvidia.com>
 <BN6PR11MB40688BB2693A657D411E33C8C37C9@BN6PR11MB4068.namprd11.prod.outlook.com>
 <20210331123801.GD1463678@nvidia.com>
 <20210331164621.5f0b0d63@jacob-builder>
 <20210401003705.GS1463678@nvidia.com>
 <20210401102355.38b0b7d7@jacob-builder>
Content-Disposition: inline
In-Reply-To: <20210401102355.38b0b7d7@jacob-builder>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: MN2PR17CA0018.namprd17.prod.outlook.com
 (2603:10b6:208:15e::31) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by
 MN2PR17CA0018.namprd17.prod.outlook.com (2603:10b6:208:15e::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.29 via Frontend
 Transport; Thu, 1 Apr 2021 17:26:06 +0000
Received: from jgg by mlx with local (Exim 4.94)	(envelope-from
 <jgg@nvidia.com>)	id 1lS152-006opu-Ml; Thu, 01 Apr 2021 14:26:04 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 94488ce4-964f-4f31-c3d1-08d8f5333b50
X-MS-TrafficTypeDiagnostic: DM5PR12MB1435:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1435239BD23BD4CD02F54FE9C27B9@DM5PR12MB1435.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dcO05XyPo2OQ2HER4YjIM20HPJtpuh5gnyAP5On4+C1x9PpleitNtkyjin6/7LYcI4ynnkOa2jztkpCMng0xvlTwXyXjJPzbZv5ayvHiSJDh/06tAzoa65bksKUKwl2WXQa1BUaFdclk+JFqWJb97V0Ek19vASOsaDLGo9EmgbU4z3QjZGxNOaCb82POkXoQUExI6omTlKttD0Sl5Ohm4JkWVyaOwBdmtJtDprTVnCdorA6wBdwY6SPB2g6D+3ypMwWQZq/aNxZj1NDxrFJl8i1H0MhONS6QBhiAlu3tT4GKfCZzFbh/YwAB8KybWX/HizhTaXjiRq9RLdFFTE7N+z6B3f8FuHSXuCz1soLa9KQonzCuTNj3fhQzBYJ5jNRDtqMm62jLqhR76v4cwXy7vItk05/bC0+CJ2vQR5irawGGqkbxQ3xnZq3FPbyxaha3ZMimWqEKeIL3EM9iSOzRfTePVpPJaitCR+BZ2XlTSFqc6kxuAHrxPpUSOmGb+8ufscDIyYhgBvtmk5rtj4ULx+nMiUnLCYAXRkGyGEwjLBfbp1pawO3hdx6lj1Zm7di1z7mGjlPEaEnoaDJHFuDwvR8oPzDe2bwndggsnL8RqodqyLfBLRw9CPIB5rtBFslmddhEzCNFfD7GMmaoeIw7KZ4+PIM9oB70UJwq433DjeY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3834.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(39860400002)(346002)(376002)(136003)(426003)(1076003)(2616005)(186003)(316002)(2906002)(9786002)(9746002)(54906003)(66556008)(38100700001)(6916009)(66476007)(7416002)(33656002)(86362001)(36756003)(478600001)(8936002)(66946007)(4326008)(5660300002)(8676002)(83380400001)(26005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?swxWzRGqXiiA2mjgOB/bbW6Sk9+yw3nvZ6XVCxGdU37JYefgy2ofVtkCGdS6?=
 =?us-ascii?Q?KCFKPtBvFuxTGyDMVIbFZU3MzQYqVG4USiqUfArBLBQFjqAlEAOeG9XSmuS8?=
 =?us-ascii?Q?HqLVe3tCLD8RJBCg1Gwse7fv4hqDsH+JXs/crnchDbENIznhDDGl9fgoAXHt?=
 =?us-ascii?Q?CqNA3WWqigywQTV/L5bJps8Lvbj9muWBPrcDJjO922DHH7ncHVTiadFE4u2l?=
 =?us-ascii?Q?1aJM+UjWDkRJldGFXkphyINwEzckmlzXojhmIQ5ZDSZQSAIIm5x/1Ok6kN3D?=
 =?us-ascii?Q?+IU4rzKcJezZ9UPt7wq31JTX3ZGlUKfl7jGDYlDqOm1GkQwk/T4kPwr1+c0/?=
 =?us-ascii?Q?3+6kG+hZcDUIvuiUOCgIa8xtXd+bkJg26iimeSyIOEw9uEJB8KY153MjevwB?=
 =?us-ascii?Q?8jPvREtYyEYncUDvhS/1y8uANyVZFYMQQapKImiZQEyZEvLA6TTKdPIQZF4J?=
 =?us-ascii?Q?1g8TPXxq8Mhf6p44z3Yq7kw9Vwch7xVie92n8o4yp4xXvNV4sKjOwnkorF4N?=
 =?us-ascii?Q?YP9218O5n3xai2we/lV6hAcLOIQI1uJkxNvaP+7nEbn0K3B8raR+BAjLjJcB?=
 =?us-ascii?Q?pFybRIx65SleQbsUA58IDXyOwJV1SCKuxbtQQ0A2U5SUz8pPswiJogXq8T7q?=
 =?us-ascii?Q?gPJembTwrIyVTUPYSJMkrQNDQ2v+dAAwfC9hQKxAp7DG8H7irFSrMaE1Qz52?=
 =?us-ascii?Q?q+IDcDcIBcogTOm1cuYYIARm0/9LMG8GboZ5NRSjovsZx5f8EJAxsHXpDO+V?=
 =?us-ascii?Q?FYbTh9ufVvscEPAStJ2+1nZ50ON9Vp1UDPePptgezmSajLQD9EVqkEK4MVaH?=
 =?us-ascii?Q?dkcHf4M2ztJHh/pzTXYZKaaBmfKWqbrxK94J24+QbZcE9z1fZ+1BaNo0BYxK?=
 =?us-ascii?Q?d+5SUwDmim4EUFrSm3vDk03EJKwEAPUO8e7O7ix4BTeQt3h9K/aizFDuL4KR?=
 =?us-ascii?Q?p1k/1XjditFMTsI8SsLtCvrHKAG2voHBrSKBLULUlkZbh6ZXpmLlWbRALnE6?=
 =?us-ascii?Q?wCimucdlLefEH293YZfv61NN44+CJFRotZkvFGpkjBGDefujJug21DGkZM/9?=
 =?us-ascii?Q?ptpklwzm6m7nA5/1fWy/js/QR8FWCXhoiCCoP6NqLimuZAABu9PsU58j3QXk?=
 =?us-ascii?Q?HK0A3bQueKIZjnAnCnUG76hLFKCYqvD4lob+JQG2+DDbwT5kO6JmLJVxQDJP?=
 =?us-ascii?Q?aPRNoPcFVjOeDT1MYvOWrcJc97misJP2pCAyd5or4uFBMk7Clg8sP+RMwH8Y?=
 =?us-ascii?Q?w2ni+PqubtlNU+hD4RJv6qwDD3nlOAeyDh7pEPrOgH5UDp4czlBvMBr9DqxT?=
 =?us-ascii?Q?+zTHIenRMNc8HGrzksttWtvLh+dq/Bbd3DhbKmx/YDNEBw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94488ce4-964f-4f31-c3d1-08d8f5333b50
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2021 17:26:06.2799 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lDewsFPi6lcKPsI7BNByD/s9sAv/0YZUJXuEXHZQAfb60F6tqXs/PHVAXxMpbJnb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1435
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

On Thu, Apr 01, 2021 at 10:23:55AM -0700, Jacob Pan wrote:
> Hi Jason,
> 
> On Wed, 31 Mar 2021 21:37:05 -0300, Jason Gunthorpe <jgg@nvidia.com> wrote:
> 
> > On Wed, Mar 31, 2021 at 04:46:21PM -0700, Jacob Pan wrote:
> > > Hi Jason,
> > > 
> > > On Wed, 31 Mar 2021 09:38:01 -0300, Jason Gunthorpe <jgg@nvidia.com>
> > > wrote: 
> > > > > > Get rid of the ioasid set.
> > > > > >
> > > > > > Each driver has its own list of allowed ioasids.    
> > > >  [...]  
> > > > 
> > > > The /dev/ioasid FD replaces this security check. By becoming FD
> > > > centric you don't need additional kernel security objects.
> > > > 
> > > > Any process with access to the /dev/ioasid FD is allowed to control
> > > > those PASID. The seperation between VMs falls naturally from the
> > > > seperation of FDs without creating additional, complicated, security
> > > > infrastrucure in the kernel.
> > > > 
> > > > This is why all APIs must be FD focused, and you need to have a
> > > > logical layering of responsibility.
> > > > 
> > > >  Allocate a /dev/ioasid FD
> > > >  Allocate PASIDs inside the FD
> Just to be super clear. Do we allocate a FD for each PASID and return the
> FD to the user? Or return the plain PASID number back to the user space?

I would do multiple PASID's per /dev/ioasid FD because we expect alot
of PASIDs to be in use and we'd run into FDno limits.

> > > >  Assign memory to the PASIDS
> > > > 
> > > >  Open a device FD, eg from VFIO or VDP
> > > >  Instruct the device FD to authorize the device to access PASID A in
> > > >  an ioasid FD  
> > > How do we know user provided PASID A was allocated by the ioasid FD?  
> > 
> > You pass in the ioasid FD and use a 'get pasid from fdno' API to
> > extract the required kernel structure.
> > 
> Seems you are talking about two FDs:
> - /dev/ioasid FD

No, just this one.

> - per IOASID FD
> This API ioasid = get_pasid_from_fd(dev_ioasid_fd, ioasid_fd);
> dev_ioasid_fd will find the xarray for all the PASIDs allocated under it,
> ioasid_fd wil be the index into the xarray to retrieve the actual ioasid.
> Correct?

'ioasid_fd' is just the ioasid number in whatever numberspace the
/dev/ioasid FD's use.

> > Why only one?  Each interaction with the other FDs should include the
> > PASID/FD pair. There is no restriction to just one.

> OK, one per subsystem-VM. For example, if a VM has a VFIO and a VDPA
> device, it should only two /dev/ioasid FDs respectively. Correct?

No, only one.

For something like qemu's use case I mostly expect the vIOMMU driver
will open /dev/ioasid for each vIOMMU instance it creates (basically
only one)

> > The act of programming the page tables and the act of authorizing a
> > PCI BDF to use a PASID are distinct things with two different IOCTLs.
> > 
> Why separate? 

Because they have different owners and different layers in the
software.

It is not about use case, it is about putting the control points where
they naturally belong.

> For a complex stack like vSVA, I feel we have to reduce moving parts and do
> some divide and conquer.

uAPI should have all come together with a user and user application.

uAPI is hardest and most important part.

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
