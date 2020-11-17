Return-Path: <SRS0=JfyE=EX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FE35C5519F
	for <iommu@archiver.kernel.org>; Tue, 17 Nov 2020 17:38:42 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3EAE2467A
	for <iommu@archiver.kernel.org>; Tue, 17 Nov 2020 17:38:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="jbZBlzgd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3EAE2467A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 548DE2094E;
	Tue, 17 Nov 2020 17:38:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jg-4NR2G+h3D; Tue, 17 Nov 2020 17:38:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 027F42034B;
	Tue, 17 Nov 2020 17:38:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DED16C0800;
	Tue, 17 Nov 2020 17:38:39 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 47B71C07FF
 for <iommu@lists.linux-foundation.org>; Tue, 17 Nov 2020 17:38:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 3553E86F9A
 for <iommu@lists.linux-foundation.org>; Tue, 17 Nov 2020 17:38:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ffY2IFaMQk2s for <iommu@lists.linux-foundation.org>;
 Tue, 17 Nov 2020 17:38:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2080.outbound.protection.outlook.com [40.107.243.80])
 by hemlock.osuosl.org (Postfix) with ESMTPS id D840B86F98
 for <iommu@lists.linux-foundation.org>; Tue, 17 Nov 2020 17:38:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=maSQNh8djHfW0gKS1RrhYwUBh5aqvxgBTbAyvxaikZGfrlV5itHGRzFwt3isYr51i0ePaaqnySxpxtrq80O1/yepAtH9AqUF9f/csBqCpmlqWgt/bkOjo+Oa5T6QPwvQm2aaUFdNL2mxmM1FaFKXFEwzHmr6gW20QnfXjr7zUnplbBPa4T75JnryEcVGGEJcVATivKa40+nHfL/XyXHK5VWVUNWuhQ/gAI0dOKC6SlC7LGJvWvnVM5vnaUPQDPAYS+2Ur/s4mJp/uFbyoBDa7Oz0N848VjmXGlaAijh4DrqbSbXSIK0vsb95sL4TOCXcEmNNcCJs0ykIvMWIR5pfiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7wSUrdgb2oA2gldZCeW8TqFXaHDSyjAvq5h8+yUNZO0=;
 b=eNKBcXffuS4MggWDYVeIv2TJ4tIF7CAbrjCm2YtjoCHjA5O1v2mpGUjB5xOSbV75RNv8Cdv2VQ5Vx8ZKoF98xJ0mIuAv/mq8vrpDFq8kZg2+27j1SYySH5aRjkZs3mQ3rL0fegLl3t8h3sZR4wWJRB2xy70s45SzqWxBkM7gWNj73H6EyoRRqzcCW3hlv7k9bXVxrVV58IWOskAUX11dUjk+BqgeaPFjgQTueTyj0HUYzb1lOuQEmppdn+t0f+9TKDQ01CQaZhgpT52nJGa+fBiMmHm3FqG9aU/TT77QrK8E3RnVrWTGG89+ER6bMR1gIon7YyofgT9SQe7yeir5Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7wSUrdgb2oA2gldZCeW8TqFXaHDSyjAvq5h8+yUNZO0=;
 b=jbZBlzgdWFSF1BkM+cmI3HYx19xgrbhhe9qMw+bhoMVTj4C49PCh/5JDWX2z8gRnSzNpK+dGbwUD+7siZkPXZyl2rtYb84j+GPjN6aG5oMZZ/nS00d/8OSiwC+EnnIJP0vF684GpRWghOvh4JXTplulhv61l5MOHzZNBl1X9bNk=
Authentication-Results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2767.namprd12.prod.outlook.com (2603:10b6:805:75::23)
 by SA0PR12MB4510.namprd12.prod.outlook.com (2603:10b6:806:94::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.25; Tue, 17 Nov
 2020 17:38:35 +0000
Received: from SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::d8f2:fde4:5e1d:afec]) by SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::d8f2:fde4:5e1d:afec%3]) with mapi id 15.20.3541.025; Tue, 17 Nov 2020
 17:38:35 +0000
Date: Tue, 17 Nov 2020 17:38:29 +0000
From: Ashish Kalra <ashish.kalra@amd.com>
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [PATCH v3] swiotlb: Adjust SWIOTBL bounce buffer size for SEV
 guests.
Message-ID: <20201117173829.GA29387@ashkalra_ubuntu_server>
References: <20201104223913.GA25311@ashkalra_ubuntu_server>
 <20201105174317.GA4294@char.us.oracle.com>
 <20201105184115.GA25261@ashkalra_ubuntu_server>
 <20201105190649.GB5366@char.us.oracle.com>
 <20201105193828.GA25303@ashkalra_ubuntu_server>
 <20201105202007.GA6370@char.us.oracle.com>
 <20201105212045.GB25303@ashkalra_ubuntu_server>
 <20201113211925.GA6096@char.us.oracle.com>
 <20201117153302.GA29293@ashkalra_ubuntu_server>
 <20201117170003.GF10360@char.us.oracle.com>
Content-Disposition: inline
In-Reply-To: <20201117170003.GF10360@char.us.oracle.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: SN6PR08CA0012.namprd08.prod.outlook.com
 (2603:10b6:805:66::25) To SN6PR12MB2767.namprd12.prod.outlook.com
 (2603:10b6:805:75::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ashkalra_ubuntu_server (165.204.77.1) by
 SN6PR08CA0012.namprd08.prod.outlook.com (2603:10b6:805:66::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3589.20 via Frontend Transport; Tue, 17 Nov 2020 17:38:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 28844cac-fab4-43bb-d510-08d88b1f9bf4
X-MS-TrafficTypeDiagnostic: SA0PR12MB4510:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB451090EB6B7D1CA0BB5F8D108EE20@SA0PR12MB4510.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aEPadPnWEIhlr83XtuvSsUH3sVMyUecftxNUESAaCiwHi7wqVzrhmm9X0aILCQELND6BvTjru1kLghXxi2KIJ+8SHpW6H2lCuCre9u2Ia4oV0YRJUByBMt/bmLum4GejIi5MW6qUlyvN14wZb0Dda4Ib5SzO9G6rfXISPw1MwGgF7Dzg2aD3kJFEHi5p4Zx0sJNI9X5ahaDJCN5QGoYPho8aM9E229mLXs/4hxvGl3l140mxVnCWhWyjlbJLPkRzvo/6cgtk1zsBUrwQH+0RDI6J2i4ZgmTseaIe1xyRgxSEVy/HroebCE/1NxRm/kDhhJv6j3nATTrwycCtohLs2Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR12MB2767.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(396003)(346002)(39860400002)(366004)(26005)(478600001)(8676002)(55016002)(66946007)(6916009)(33656002)(66556008)(9686003)(66476007)(16526019)(7416002)(52116002)(86362001)(6666004)(186003)(956004)(1076003)(316002)(8936002)(5660300002)(6496006)(83380400001)(4326008)(44832011)(33716001)(2906002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: NE9u3DwMk6rP/leRa7AjnJIU58r8uuoUNmLTSAy93Ttlh4Z2B7/jIiDl5cvaytDaSKUe0QZ+4JrJzbnb4PNq+hfH6ezUnpl2w+Qbh27yej4DTZ9ESp4sVv98/fG+GmeFfGKNfqSFvYtfLKbBDL4tk8C7UA9IJPqMb89ZC7GnD1ZOQNu5Uf7SL2oMWa71064QxtKqtI3brX3kh2xN1o+in/Jjf1oKnYRJ/rGje2xSvqVWna9SYnEf+veYX5ZkW8NpHUiNfKaacBw3d2a1yMqLWigRv/d+ENFeGEdc934kJkTWEovSYs2rMB61BulTXBSKhR9L0qEIT3j2lpTnbf5PcJveWKbW/4nSnUvF1GQIpNK76IaxuRsFcz7f26sE34O+INcAYsaa8a/2wOB5hLJe8mG94evcrkpohTkU69VoUWOvbtKkUuUBKVUFllkN5ekxJKSAXJlEiJRGenoYLEGH7HXa5IKHy7Xagz2Uwqu9viIJPW5AghPRQHb6B+KkAXFzBe1KsmZ5kbSojflGulKXEEt+BcPKcQtYNMTh1t1JYF+qrKlr0aYtSlD4UrnS7jR1S4iN+dzd+nnRjeO9/Ldd9aZhpBKcXDi7na035L2/t4/UKFVKCeTBj02nfUByj/dC58CCpCjKn4f7cyYn4yktR1rOsAUhL9SnAFhsCTPNdHdn5hZ0bcybyvSMIIB9txB9QT7JPqVm+95/9CWSYBa4KopkKM+ujmxLINb3UQw9nNjRNfWYkDXNnaNf7yfax1UNa6g57addqxpSa3v2psJirh6EqiWXlzPvW5SXGaXG2ROiuAwmhGMIMtmIg6K5AJ26BMheKuSO51TQvjvzX8YNyGfTIOqwjasCgkl4GfFMhxqE+RA6apfuSy2ZqMznKnQJtRe7+FHN0QDEiU4EAarbMQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28844cac-fab4-43bb-d510-08d88b1f9bf4
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2767.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2020 17:38:35.4083 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vSbeSL1J2MBMhy75nm18h3Ye80usWIb3/v1dM2sBTrpq5CJNefNTEQtmbPQ5eyN5BhwbYmDegFgJf2q8PjX9YA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4510
Cc: Thomas.Lendacky@amd.com, jon.grimm@amd.com, brijesh.singh@amd.com,
 ssg.sos.patches@amd.com, dave.hansen@linux-intel.com, peterz@infradead.org,
 x86@kernel.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 mingo@redhat.com, bp@alien8.de, luto@kernel.org, hpa@zytor.com,
 rientjes@google.com, tglx@linutronix.de, hch@lst.de
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

Hello Konrad, 

On Tue, Nov 17, 2020 at 12:00:03PM -0500, Konrad Rzeszutek Wilk wrote:
> .snip..
> > > > > Lets break this down:
> > > > > 
> > > > > How does the performance improve for one single device if you increase the SWIOTLB?
> > > > > Is there a specific device/driver that you can talk about that improve with this patch?
> > > > > 
> > > > > 
> > > > 
> > > > Yes, these are mainly for multi-queue devices such as NICs or even
> > > > multi-queue virtio. 
> > > > 
> > > > This basically improves performance with concurrent DMA, hence,
> > > > basically multi-queue devices.
> > > 
> > > OK, and for _1GB_ guest - what are the "internal teams/external customers" amount 
> > > of CPUs they use? Please lets use real use-cases.
> > 
> > >> I am sure you will understand we cannot share any external customer
> > >> data as all that customer information is proprietary.
> > >>
> > >> In similar situation if you have to share Oracle data, you will
> > >> surely have the same concerns and i don't think you will be able
> > >> to share any such information externally, i.e., outside Oracle.
> > >>
> > >I am asking for a simple query - what amount of CPUs does a 1GB
> > >guest have? The reason for this should be fairly obvious - if
> > >it is a 1vCPU, then there is no multi-queue and the existing
> > >SWIOTLB pool size as it is OK.
> > >
> > >If however there are say 2 and multiqueue is enabled, that
> > >gives me an idea of how many you use and I can find out what
> > >the maximum pool size usage of virtio there is with that configuration.
> > 
> > Again we cannot share any customer data.
> > 
> > Also i don't think there can be a definitive answer to how many vCPUs a
> > 1GB guest will have, it will depend on what kind of configuration we are
> > testing.
> > 
> > For example, i usually setup 4-16 vCPUs for as low as 512M configured
> > gueest memory.
> 
> Sure, but you are not the normal user.
> 
> That is I don't like that for 1GB guests your patch ends up doubling the
> SWIOTLB memory pool. That seems to me we are trying to solve a problem
> that normal users will not hit. That is why I want 'here is the customer
> bug'.
> 
> Here is what I am going to do - I will take out the 1GB and 4GB case out of
> your patch and call it a day. If there are customers who start reporting issues
> we can revist that. Nothing wrong with 'Reported-by' XZY (we often ask the
> customer if he or she would like to be recognized on upstream bugs).
>

Ok.

> And in the meantime I am going to look about adding ..
> > 
> > I have been also testing with 16 vCPUs configuration for 512M-1G guest
> > memory with Mellanox SRIOV NICs, and this will be a multi-queue NIC
> > device environment.
> 
> .. late SWIOTLB expansion to stich the DMA pools together as both
> Mellanox and VirtIO are not 32-bit DMA bound.
> 
> > 
> > So we might be having less configured guest memory, but we still might
> > be using that configuration with I/O intensive workloads.
> >

I am going to submit v4 of my current patch-set which uses max() instead
of clamp() and also replaces constants defined in this patch with the
pre-defined ones in sizes.h

Thanks,
Ashish
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
