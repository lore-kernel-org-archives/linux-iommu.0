Return-Path: <SRS0=ynGH=LB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_RED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72745C47094
	for <iommu@archiver.kernel.org>; Mon,  7 Jun 2021 17:59:34 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E42C611AC
	for <iommu@archiver.kernel.org>; Mon,  7 Jun 2021 17:59:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E42C611AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DAA8A402E9;
	Mon,  7 Jun 2021 17:59:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rKmVaV6sSbs4; Mon,  7 Jun 2021 17:59:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 69627402CF;
	Mon,  7 Jun 2021 17:59:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4D3A2C000E;
	Mon,  7 Jun 2021 17:59:32 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 07153C0001
 for <iommu@lists.linux-foundation.org>; Mon,  7 Jun 2021 17:59:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E12EB835C8
 for <iommu@lists.linux-foundation.org>; Mon,  7 Jun 2021 17:59:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BzTeBEsGpjGl for <iommu@lists.linux-foundation.org>;
 Mon,  7 Jun 2021 17:59:29 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2043.outbound.protection.outlook.com [40.107.92.43])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9319283486
 for <iommu@lists.linux-foundation.org>; Mon,  7 Jun 2021 17:59:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WKSr52yLS5rs4d0q1QV1gYjj8JQ2iTRDgXdHLZaE2Oywi0EqVDhbYgzJxbV8W+qQc2RBcsPNckzvB07PUiwglWck0AqMRo1GwWLTRzAMclws4ZvqtC3b9wOtTuk4h8K8Tph0Tj4Qpcja2ZioqG+AC2OJF80XyKIM+3OGmAmCL8lbUo5Zp0+9UtpUKDK/FBOFLz0c4mjO8CGzqar1VWLwWO2fUA31/szu/jpZjShsbP2nMuRh0aU/o5H5CUv9mThfPMbcJPKnKcxy7hFM+5FRNeP63FlERfqsGO+gnGaSrJ0XtX3EPpkH22L3PamKVQ9pxWxwv6CGFY8gMDoag4sahw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZRzoU0raxfRLumkWv0fQhV5VJUNEey9cDTIygXPd6MY=;
 b=aeWXh67zs/831XQa9OEFRIGHeK0lxGVHX+svwBxaA8RfMuVKfXtGsJOg5goljTAZfSw4ZDewLuFE+jveDks+BHHcMmwAFntS/xmO592hkhvTsg7ckRuR5ILS2FF7gOFCXxnMkeiQNUp009RAHCRu0a/P7f2e1whbSfGPDzL8zmO4kpxXenDjQ8c+tFlkEgSmmXrtSQu0qU24bZIBcQC3CC4Si97+M+OEhAEDwh48xF1TTs443myo/Ixv9S8W7PTEDx7Zc721OIK5r3ODemWC7ie3dvKJY4Q2qpnU6QuNR9c1kUrMs7NSNwpUlKuzBPpHeUr2wX/TJRIQKL3/6Am6YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZRzoU0raxfRLumkWv0fQhV5VJUNEey9cDTIygXPd6MY=;
 b=oruBtuDKODA/k8ahqZtp5iOyY6aJZlq7j13waznng/P26Si1mjX0Y/qLAzLMEVg+6U9gJHsfJHdbzV+avRHT3+K5om6Rdbt303BeVGoV0jpQENkVne7DruAxfTmo5ida2rjADHnvodHDp4R67cW8aoHT4EgIFh61eNkpRWEZPdDO2iISjQBvGUM5iq2hBpn/rgfrGzpgVtjpj3kYEdXdzXa+m0uVMSi8HmsJEfb0DV9l6OcsJnOF/9dqX9tFba/qSj3LRWWuDGGwM7KsW1PjcnShqXiVNV5gQ10wzqHmGluq4Fl0ZLD6h7E2XsSpB2vVySrJB0JmvOdzDjs5S+5tCg==
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL0PR12MB5521.namprd12.prod.outlook.com (2603:10b6:208:1c7::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.23; Mon, 7 Jun
 2021 17:59:27 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%6]) with mapi id 15.20.4195.030; Mon, 7 Jun 2021
 17:59:27 +0000
Date: Mon, 7 Jun 2021 14:59:26 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC] /dev/ioasid uAPI proposal
Message-ID: <20210607175926.GJ1002214@nvidia.com>
References: <MWHPR11MB1886469C0136C6523AB158B68C3B9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210604122830.GK1002214@nvidia.com>
 <20210604092620.16aaf5db.alex.williamson@redhat.com>
 <815fd392-0870-f410-cbac-859070df1b83@redhat.com>
 <20210604155016.GR1002214@nvidia.com>
 <30e5c597-b31c-56de-c75e-950c91947d8f@redhat.com>
 <20210604160336.GA414156@nvidia.com>
 <2c62b5c7-582a-c710-0436-4ac5e8fd8b39@redhat.com>
 <20210604172207.GT1002214@nvidia.com>
 <2d1ad075-bec6-bfb9-ce71-ed873795e973@redhat.com>
Content-Disposition: inline
In-Reply-To: <2d1ad075-bec6-bfb9-ce71-ed873795e973@redhat.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: BL1PR13CA0092.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::7) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by
 BL1PR13CA0092.namprd13.prod.outlook.com (2603:10b6:208:2b9::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4219.9 via Frontend Transport; Mon, 7 Jun 2021 17:59:27 +0000
Received: from jgg by mlx with local (Exim 4.94)	(envelope-from
 <jgg@nvidia.com>)	id 1lqJX4-003OjS-UE; Mon, 07 Jun 2021 14:59:26 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bafa5231-9cfe-4fe1-d24c-08d929ddfe04
X-MS-TrafficTypeDiagnostic: BL0PR12MB5521:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB55214E1E6FEA171CEC254E5BC2389@BL0PR12MB5521.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OZrNt+F21iRxfMLUAdktHNhk3ATSEmp/hCcUL02yUTW3Kyzh1UQuIToEgCSDmcrFEjx/Io5P7ivmF4g8Fg2DsFGw+ru8VVYuPBMhFEr+2cDkDrzWaCfGNm7ui/eE747nmUu9BjcsZWzf9VMsS4rOPWWFQ2VR6dHeK2+KOkqYUvE5UKLLId994UC09ia0SxMffTIe86AxPKU6vEBQa9sFLfWPtJ6ER058vGDSPi70zMUJD/KzsepaAVV6WpTcRsjMc3uvxi/U9kPOUP6u2JeKzJLIVPW5kvfOj64aHOEwDZ5rvZlOwLrf/bEERjWIdm8/t9s2SPBLmlcQTyNWNfCFQFh7h8HbWNIIfrSqeV1ddsspkl7uZJ179kGW7ZpXz2Q+JbxiD2Fpy423fACjSaR98G0eGSpiDAKzt4Leu6g4ZT9izDlQmT8TE5z6DyMkL/AKlJVvL2jZuwVODXGNQA8AYNYsJ8rBMiYz2xpVdVOl7C4tTt/XjV+/j5qFL7W/ocmT3YGwzzGwpLyuJGP0yZfhJ2tEWJaAud/Ss58Qb40H+60IF/4XAsNl975uzQ3AEKITJ7+pUzxJamOdkAABQd080VVR+PQcZ1N46/37l3kHj7E=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB5506.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(376002)(366004)(39860400002)(136003)(26005)(6916009)(38100700002)(53546011)(36756003)(9786002)(186003)(2906002)(4326008)(8676002)(2616005)(86362001)(83380400001)(66476007)(9746002)(5660300002)(66946007)(33656002)(478600001)(1076003)(426003)(8936002)(7416002)(316002)(54906003)(66556008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?zjeURorse2PG2j8EdRuuYMGD49D9YQIofKc4YA9+nV7pXzSJK+/dRNK9D6jC?=
 =?us-ascii?Q?0JqdZkHXZ4IWmL4j/dJQZFSqbgypYhXlBW3jfnH8elbaJvWYkgh1tN8Wz/DO?=
 =?us-ascii?Q?nQeJYC+bnG4qlMigBohXBwXpNcZkoXs8zpAzQK0IE0A3o9L8Y207rDdjQNVz?=
 =?us-ascii?Q?pmX9HBaYjyjY/jz+QDWo2xZYkBr3N/wgSzB75VGhLrfUgkWUqwAaAbVf3oUt?=
 =?us-ascii?Q?PKZo7Cn7m7sKHDsI175gUjtH9ZGOAVgrK7GvNDLaIUgb9YYbE6nS2jhLT13d?=
 =?us-ascii?Q?gw1ew2ZbBBr7U5S0PM4R8Pvr4qiBpMbPPtfXU6E1FlB3FCouiRxJ9tB0JWtW?=
 =?us-ascii?Q?AmLFIvWHzKeyzpLexaCdwMWFQKn55x1bKb4SrilJJJQR9q+p7/GplwKgSSLv?=
 =?us-ascii?Q?EckA9n2zXnWQaJdNtlUXL7cWdz6sFoXvA4oag06bidY30DLDrVPouHpOXv//?=
 =?us-ascii?Q?iNxaG7L9utzhq2O9mfrUkkR3MzmkJ513Z98CqD9AhohgTNHsa5TqiFp3cS/s?=
 =?us-ascii?Q?qf4MaaKZhMyHKNwisTmDnAtAI5a4avlM/T48lCFa/4V6IE35dEY9O0YrPpDq?=
 =?us-ascii?Q?f5SIJc0ALRV/XOYnN3ZpaOvv6uuBeUECWJ8yfN60DUD1og3yZh2dzEXmznmd?=
 =?us-ascii?Q?4m1GrdVQWlfZt1x3+aK/iaMAMDL64kCtq5eK1v4aBU3lcHgViOko+vMz06hD?=
 =?us-ascii?Q?agk13W6TicUUSxbIiJOYzfpZocFzjPTDLXFcz+vCFQ3MVuUxmdXxIAUjhwSa?=
 =?us-ascii?Q?MNO3dZqxf7H2dBr6XUb4d94qpiczQlMv1dgxdYEHVBqtgKwyyZEs714tKOJa?=
 =?us-ascii?Q?8BxSW9296FQDBettio6HNDUm+ByuspxLNxwE/l4REMzHRJn9tyhgngmid5of?=
 =?us-ascii?Q?En/2cqYC+zqDO+/SlAKEbpsP8raYMEQ8+bbPqwf7cDnagL/H1vV/8FnpI1rw?=
 =?us-ascii?Q?wM9YHwazkJp3Ee3bNh0VI9BCBThSazgHS1bNpwkprl0utMwd5QfzA3y4W/bK?=
 =?us-ascii?Q?s1IEn24XCSWKbVjA85KRC1vfqhK8sQ2neuID5uH/sFPc5ai7qSHkXezwNHUG?=
 =?us-ascii?Q?KyDeU1eYAUUofAT74N1P0L2Lsxg91ZnX0GTAIKkyqCeEYdgtmT7YtpRJfZGX?=
 =?us-ascii?Q?w+jXUoE51cUkGYucc2rT0bLmvwCST3eBF80LGljN1LphiciQnu354HbJKYTu?=
 =?us-ascii?Q?z8WaCsSxkw6vtJmik3kdUtg1v9oHRvPvaPpNhuZxfMA5PLB9K7Rkv+Q6N6+K?=
 =?us-ascii?Q?D5ePMM0AdcjpTn9jtiOg0s1t5VYBZXBLnvizvi8L6ZnaUO+PjhB8p4JcMZVx?=
 =?us-ascii?Q?TjJC+5hIBIL06iLKfdsGGJql?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bafa5231-9cfe-4fe1-d24c-08d929ddfe04
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2021 17:59:27.7508 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nhbZjjTZx2zgy/9i4lnclDQHtkHidLNWFCwtmV58WgOC3T6D4UMViUf/K3FEA8Hq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5521
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Jiang, Dave" <dave.jiang@intel.com>, "Raj,
 Ashok" <ashok.raj@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, David Woodhouse <dwmw2@infradead.org>,
 Jason Wang <jasowang@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Kirti Wankhede <kwankhede@nvidia.com>, Robin Murphy <robin.murphy@arm.com>,
 David Gibson <david@gibson.dropbear.id.au>
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

On Sat, Jun 05, 2021 at 08:22:27AM +0200, Paolo Bonzini wrote:
> On 04/06/21 19:22, Jason Gunthorpe wrote:
> >   4) The KVM interface is the very simple enable/disable WBINVD.
> >      Possessing a FD that can do IOMMU_EXECUTE_WBINVD is required
> >      to enable WBINVD at KVM.
> 
> The KVM interface is the same kvm-vfio device that exists already.  The
> userspace API does not need to change at all: adding one VFIO file
> descriptor with WBINVD enabled to the kvm-vfio device lets the VM use WBINVD
> functionality (see kvm_vfio_update_coherency).

The problem is we are talking about adding a new /dev/ioasid FD and it
won't fit into the existing KVM VFIO FD interface. There are lots of
options here, one is to add new ioctls that specifically use the new
FD, the other is to somehow use VFIO as a proxy to carry things to the
/dev/ioasid FD code.

> Alternatively you can add a KVM_DEV_IOASID_{ADD,DEL} pair of ioctls. But it
> seems useless complication compared to just using what we have now, at least
> while VMs only use IOASIDs via VFIO.

The simplest is KVM_ENABLE_WBINVD(<fd security proof>) and be done
with it.

I don't need to keep track things in KVM, just flip one flag on/off
under user control.

> Either way, there should be no policy attached to the add/delete operations.
> KVM users want to add the VFIO (or IOASID) file descriptors to the device
> independent of WBINVD.  If userspace wants/needs to apply its own policy on
> whether to enable WBINVD or not, they can do it on the VFIO/IOASID side:

Why does KVM need to know abut IOASID's? I don't think it can do
anything with this general information.

> >  1) When the device is attached to the IOASID via VFIO_ATTACH_IOASID
> >     it communicates its no-snoop configuration:
> >      - 0 enable, allow WBINVD
> >      - 1 automatic disable, block WBINVD if the platform
> >        IOMMU can police it (what we do today)
> >      - 2 force disable, do not allow BINVD ever
> 
> Though, like Alex, it's also not clear to me whether force-disable is
> useful.  Instead userspace can query the IOMMU or the device to ensure it's
> not enabled.

"force disable" would be a way for the device to signal to whatever
query you imagine that it is not enabled. Maybe I should have called
it "no-snoop is never used"

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
