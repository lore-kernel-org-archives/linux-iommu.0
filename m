Return-Path: <SRS0=H7Zn=I4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 476BBC433C1
	for <iommu@archiver.kernel.org>; Tue, 30 Mar 2021 13:25:06 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E35B5619C1
	for <iommu@archiver.kernel.org>; Tue, 30 Mar 2021 13:25:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E35B5619C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AA8DC60792;
	Tue, 30 Mar 2021 13:25:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ep4odGyYtSoy; Tue, 30 Mar 2021 13:25:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6712260592;
	Tue, 30 Mar 2021 13:25:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4986FC000C;
	Tue, 30 Mar 2021 13:25:04 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 48E4FC000A
 for <iommu@lists.linux-foundation.org>; Tue, 30 Mar 2021 13:25:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2986B40312
 for <iommu@lists.linux-foundation.org>; Tue, 30 Mar 2021 13:25:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3HmcodyclJJv for <iommu@lists.linux-foundation.org>;
 Tue, 30 Mar 2021 13:25:01 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2067.outbound.protection.outlook.com [40.107.237.67])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 344F340183
 for <iommu@lists.linux-foundation.org>; Tue, 30 Mar 2021 13:25:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iZHSCov/CgGdovNj03iSKBWVMvZ/9jiVrJP027zt7WCZU+tg3CyHVNuYzAyjyd+x3yjyWQSJYzHrvqqbnUKh51OiwApFAg5EILHcx6YmC6BvaiR4wLFz2P8eaMZ4U0iFtfcPiLrvRNBnnVnliq30atd7Gh7InLGViXuwO4LmuSk1XjnQ7hr1ZqYPzgyHhFtOgWkQNBT7Wl8e46/NjXTE/+mt7R43P495fdzEcn7G8AjpJzzBab/wLMWKI4DxoVvOe84gCG/GStb7DT/2xDG71+O6VcjlmUDTDxYv3kJdBeqxFnViBzJWI1iwaMoIHyJXI8a7YeTaiBeC951K0G8etw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H0XJH7ETVgHxScn+F/M4QQ+3qsyIlvXRa+cgv5L926M=;
 b=Z974IcaWN8CKPNBTcy9ka5ZhfP5dgjkQT2vUZVJUdNK07ne6BEkNm7veC8wifxe9Ua51gRPl0Uu1zOy22Hb+rajyo96+/f9fsSpaweMTa3sux8lp/XMo8+C1S5DwksPjH1M8xzb3Gf4Bsvpkc/HFHObyw8EJJ5nRWmsoL2lELhkkwUSlntWFgQrrXpBNZPoVYQkrGkATmT0fSbJomzO8x4Qn106RafRRjpf8ppcE+H9kinscy/OATYEaAy/Z0TINlCH4OJG7CiAsbgbsu/a+RBNAykW2flWnJxedFPJEpVH/1WWRdtV5oipZSsrd4E3Tv2t1S5sYOmS6On2nRQw+hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H0XJH7ETVgHxScn+F/M4QQ+3qsyIlvXRa+cgv5L926M=;
 b=X2fcFfagjD0oNiVDXCyuKgQn/ZXflvlQ2lns1ZxNRlUPvJ2LdN199j/YNImYe9asymkWAEmVfNm/dPeeeVyz81Mdhq5uQ5Dk9SYkeilm2ccLIyAMiUBN5kK3JuJsHEH8ASIcjf8J1uDBoZ2Kk16duvOoh6idrxxlUn9M5RaS05FdXj7xLh+eAIV5RqRRpGflpSEyy2EK9P1RaBmhqFpAJPUw2CYbYKz8hyUn+D30+Qq4T9zNVcwhRq3caVxNHJX7iNvIPavzo1+uB2xT9Ky/C50U3g1g4UfZvRlh/G1+yfDa5GEK9TDqeSkE5f1ueG+BA4tXHXK2Q5Ae8w8CXlbZBQ==
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1548.namprd12.prod.outlook.com (2603:10b6:4:a::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3977.29; Tue, 30 Mar 2021 13:24:55 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3977.033; Tue, 30 Mar 2021
 13:24:54 +0000
Date: Tue, 30 Mar 2021 10:24:52 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Subject: Re: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and
 allocation APIs
Message-ID: <20210330132452.GA1403691@nvidia.com>
References: <20210318172234.3e8c34f7@jacob-builder> <YFR10eeDVf5ZHV5l@myrica>
 <20210319124645.GP2356281@nvidia.com> <YFSqDNJ5yagk4eO+@myrica>
 <20210319135432.GT2356281@nvidia.com>
 <20210319112221.5123b984@jacob-builder>
 <20210322120300.GU2356281@nvidia.com>
 <20210324120528.24d82dbd@jacob-builder>
 <20210329163147.GG2356281@nvidia.com>
 <MWHPR11MB1886F14B4C7C58C99F54FAFF8C7D9@MWHPR11MB1886.namprd11.prod.outlook.com>
Content-Disposition: inline
In-Reply-To: <MWHPR11MB1886F14B4C7C58C99F54FAFF8C7D9@MWHPR11MB1886.namprd11.prod.outlook.com>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: MN2PR06CA0027.namprd06.prod.outlook.com
 (2603:10b6:208:23d::32) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by
 MN2PR06CA0027.namprd06.prod.outlook.com (2603:10b6:208:23d::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.28 via Frontend
 Transport; Tue, 30 Mar 2021 13:24:54 +0000
Received: from jgg by mlx with local (Exim 4.94)	(envelope-from
 <jgg@nvidia.com>)	id 1lREMW-005tIl-Ts; Tue, 30 Mar 2021 10:24:52 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f60efef0-b37d-4f05-f121-08d8f37f3487
X-MS-TrafficTypeDiagnostic: DM5PR12MB1548:
X-Microsoft-Antispam-PRVS: <DM5PR12MB15482CA8ED474C528ECB756FC27D9@DM5PR12MB1548.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rJbIRYK5kuX9RwiOkISa+IN0IHu0c0jrGxLLGQUYEnGt/XCISWqsP0HwXUEvwYzYw/to60cHSvfMVci0j20DMujDKxuaH60HiNkwcpvdS+ZQ8OlaSzmlHqeByvC0oK47msfrPAacdsw7CgRrLpvtFy4TF4Cur/BBEXRXAqMviP0egGeb+rN5bj4eq4IRmOclK+WPU2Ub66E38I7sVQrzA1GWGJxKAKucgwKvm8puO0y37dZgvt7mWtbqTFc0zfsrnE+jieFN4BDI8rNYej4cimYd8zMr0JXBIcrnt30pXfWwzEZgn7JhodiK9ebrAyMgHeIVSAJBhqpEvWRkTIUmRGZI2pYnuPsqp3eseqPezx0fLWoPJJeNlVpC+7yyPGsGU5j+G9q9K330UdqwuZlHXSU9egKiIYhcQ+DQXK2x2WcRnYP9hTFcbEDHMI5sx4HxBhMz3h7gl9jUO342BgPZ82ajV83WIOnZlPzyHlUocBLfEO321VbhGai+i4zNj8NNROWshaQuPygjPlIVAXxDJZVB7ijVMzGB1M3Lx0r6RUIQv96niZSgeP14pwYZfzFIuIJWUXN0stbIk2kq1tXBI0sD7rhy4CBSvcyRupLQW6AYs058X5C4/ZfoD+yAKPt9rBLce9oD//cmOLjsfxKjpjWaQzaWteBegpkwNpRG9Mc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3834.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(346002)(366004)(136003)(376002)(26005)(186003)(478600001)(2616005)(9746002)(9786002)(38100700001)(54906003)(1076003)(8676002)(2906002)(4326008)(426003)(83380400001)(6916009)(8936002)(66946007)(33656002)(66556008)(36756003)(7416002)(316002)(66476007)(86362001)(5660300002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?elIJiTnReseKCl+tDtGEUImqRBtAO5tik+OEgFaJ3W9uFF9ymtALO5IMoB5X?=
 =?us-ascii?Q?0Nx0XIJDuRd4HB/YQfJL+hO5amVFI6n7g8h4ZNM9Rgl4EyGNOlDxhwktZEfa?=
 =?us-ascii?Q?bW8JiW9IH6HuAR1dvgGDijMSVDoSt9/uCDBcvsOvKQfbHADil/T1510QzLH2?=
 =?us-ascii?Q?kU2omHT4fmTzT2OPMV2WlaGla+dR0Kdi1nL/ywDDiy5j0Z3yUb9fUbAVwEca?=
 =?us-ascii?Q?lxhvrCUMagrSQMi9CM6LZQrTCHHBFrehGNm86/Rcb9L8QGxHZDK3rhQP+tn1?=
 =?us-ascii?Q?d+rbmt9qnZPfPwKk8WiBj50ssqiVpLiI21jRFjRpRYvzjTX+gtI2f0lcIG59?=
 =?us-ascii?Q?ffNfweIPJ8raKsStxVskYs2lPbj0N/3weiPuiHKi0S6TmBln22KE8DzOWA40?=
 =?us-ascii?Q?1+z5VW8E6lr/Yl91oqJ4F59uvHxzERN0MftOJnSV/Pj8Bwm12nhcLabxFpW5?=
 =?us-ascii?Q?ZpMinsEvtd/SEUT3pHuB4r5fl4H4Bqa5IrEX5yiDrQU92AuXv3E/HEroxMhA?=
 =?us-ascii?Q?XNZEG/FjsgEBhSeUPGvVOfjKPOSu9tn9XAJLQWKeZfkx7g98LyxWAFgrkfuO?=
 =?us-ascii?Q?Os1oE64Y1T5vPx1B3VkT9IadBzGRr9P2AFqIYyLXKvEHkrsHWoFLXJoPMo5Q?=
 =?us-ascii?Q?n4j3hUV1WDtCS3TtvXY/+/751zY8Nca8CFBlbTGgBh03jaD7uOjIwFq7RwfL?=
 =?us-ascii?Q?or4AWuBFHaziIxdljcgP7F+9LwpUu0KgoNDvilG/t8/Qru0yXULGbH7nYJVw?=
 =?us-ascii?Q?TH84pRPzydtFODXK1dicKPiSygX31VqFP9Y/zJ2e7JWEbIkBw6+EgxgXxrgm?=
 =?us-ascii?Q?K7+7JzmRQQeCVX9Cd5VpubpELMoz63qFmETTOZfXSvuuKYIA6Fxkluiu/DET?=
 =?us-ascii?Q?r418SEI7Nm65TUON1ojnU9cfho3xvwv6nXJqnjjK1pffD1uygz+mGaLNfaaK?=
 =?us-ascii?Q?kE5kXtxLnLz+jMoki9Yy/gfeWPEL5Fw3wU14bcHGyuUiee5wxl8bN3zHtZ21?=
 =?us-ascii?Q?EOzd7kg9t4DKAFSQ6OrCaZt2sEcSo14nd83prEGU0WRfCJMjRJcGAAqqCa/H?=
 =?us-ascii?Q?yCxNuZi1xWBc5T4o7OWI0MPxW86Bt2Bpn7WYXujnchRvXEyTKk4/fb6qv/Ij?=
 =?us-ascii?Q?6+m8cEQpiKyQ6huV+FpaXkumNx8CRO6PJUGGo/dDxwi130zKJl/H7oOYmX9u?=
 =?us-ascii?Q?OLlcMwOpHEvUwZJMiF5FcIwFGlgUkw7tBct3y5nZkpA3sGasU+2C6n++4Rj5?=
 =?us-ascii?Q?PIzZjIMtJorTzECXm53lDg1IjNiaclOw6fjtsIBQetj9Frj8g//kKIMLKRaq?=
 =?us-ascii?Q?rqjlSqpxlFvXs8NmS3DqBkn3QGNyPDdS2bPdqV2z9RMi7Q=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f60efef0-b37d-4f05-f121-08d8f37f3487
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2021 13:24:54.9260 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tqqp2KyTEEicKR7bI5dTyCJg4UyViuy3unTTwBjQtHjTVo/ef/4NTA/mraULB5Za
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1548
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Alex Williamson <alex.williamson@redhat.com>, "Raj,
 Ashok" <ashok.raj@intel.com>, Jonathan Corbet <corbet@lwn.net>,
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

On Tue, Mar 30, 2021 at 02:24:09AM +0000, Tian, Kevin wrote:
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Tuesday, March 30, 2021 12:32 AM
> > > In terms of usage for guest SVA, an ioasid_set is mostly tied to a host mm,
> > > the use case is as the following:
> > 
> > From that doc:
> > 
> >   It is imperative to enforce
> >   VM-IOASID ownership such that a malicious guest cannot target DMA
> >   traffic outside its own IOASIDs, or free an active IOASID that belongs
> >   to another VM.
> > 
> > Huh?
> > 
> > Security in a PASID world comes from the IOMMU blocking access to the
> > PASID except from approved PCI-ID's. If a VF/PF is assigned to a guest
> > then that guest can cause the device to issue any PASID by having
> > complete control and the vIOMMU is supposed to tell the real IOMMU
> > what PASID's the device is alowed to access.
> > 
> > If a device is sharing a single PCI function with different security
> > contexts (eg vfio mdev) then the device itself is responsible to
> > ensure that only the secure interface can program a PASID and a less
> > secure context can never self-enroll.
> > 
> > Here the mdev driver would have to consule with the vIOMMU to ensure
> > the mdev device is allowed to access the PASID - is that what this
> > set stuff is about?
> > 
> > If yes, it is backwards. The MDEV is the thing doing the security, the
> > MDEV should have the list of allowed PASID's and a single PASID
> > created under /dev/ioasid should be loaded into MDEV with some 'Ok you
> > can use PASID xyz from FD abc' command.
> > 
> 
> The 'set' is per-VM. Once the mdev is assigned to a VM, all valid PASID's
> in the set of that VM are considered legitimate on this mdev.

No! That is a major security problem!

PASID authorization is *PER DEVICE*.

If I map a device into VFIO in userspace with full control over the HW
that device MUST ONLY have access to PASID's that have been registered
with vfio.

This means each time you register a PASID vfio must tell the IOMMU
driver to authorize the pci_device to access the PASID, the vIOMMU
driver must tell the hypervisor and the mdev under the PCI device MUST
have a per-device list of allowed PASIDs.

Otherwise userspace in a VM with vfio could tell the mdev driver to
talk to a PASID in the same VM but *that process doesn't own*. This is
absolutely not allowed.

Most likely the entire ioasid set and related need to be deleted as a
kernel concept.

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
