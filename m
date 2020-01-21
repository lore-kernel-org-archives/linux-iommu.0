Return-Path: <SRS0=k9Qp=3L=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11078C2D0CE
	for <iommu@archiver.kernel.org>; Wed, 22 Jan 2020 00:43:53 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA0EE2253D
	for <iommu@archiver.kernel.org>; Wed, 22 Jan 2020 00:43:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="VSLj6DYT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA0EE2253D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 80D9420372;
	Wed, 22 Jan 2020 00:43:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5+-cB+bhkhhW; Wed, 22 Jan 2020 00:43:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 800F620355;
	Wed, 22 Jan 2020 00:43:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5EE1BC0176;
	Wed, 22 Jan 2020 00:43:51 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 63662C0174
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jan 2020 00:43:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 51C98847C5
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jan 2020 00:43:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZXigSnmq9CRc for <iommu@lists.linux-foundation.org>;
 Wed, 22 Jan 2020 00:43:48 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700072.outbound.protection.outlook.com [40.107.70.72])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 1B3D6847BD
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jan 2020 00:43:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nNYAksSQ/a1DjbhCeDLSTqkvNbwhipSIaKoj6evXs9S4dHNixxywnlsJ5lzFwia89ncntKa8aylR7imPFzOM6AAkia1yc4McD+uyysBJOookKbmrsMXBbN5CAPsTqC3NPHd5NIewYdb9gcVKMxS+eAqrsiICI/evABU8vz0hlJphynnJCwgderM6ryoBBAskqhs3Yt7mC3tHgbKnuS3PW7nQJiqcmck8PXMGw8S8IH5iBLCz/asIiLWRUApOyKakpZ/Xzxkn1Uc0N9BhEMhDIN/4QUhGkCYz/ijd9DYx1Lj9M3ZSVIXRn2onzBuNc1QKldtMLF4ZMCMlpDRAuWUhuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RI0cBqZKuGRuC4ia8Flphx2so19JCK0sC27NUbcrKNc=;
 b=NkK1bPbtghSml9i1XNZ4pL3V7wZ/p+Ev9w7OSLln0YhtHrseMXB8ncaBqIs57ILn29GTSVpqC7NuQJSmzzjYzKuyBt573M4Y8KcBjporJKpKxhOHs754nfXueO/cqqi4PWDd4Gu+6BNxbRS2JzqLDfsXV2/ZgdinQclgpfIVSSKUPW9u01LorEM0H3tvYR3575C7GyoEasxTdBx9+evhQScANF1k7ZmI0qjQEZ3DYCOuWaUIBuEr557oDGR7i+TP52sRv/AzwcHHK1u9xvSTjc/1WDjJWAbGjBYcMpM0sN8T7Q8URR1QZpxNEl+AjRpmokkQ80JqIArDs0DRdFcdZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RI0cBqZKuGRuC4ia8Flphx2so19JCK0sC27NUbcrKNc=;
 b=VSLj6DYTLrzyrhSIHOpPZpqUXW4x7n+DVeYUtTPz86ghhSYdc2dm3D/2T9ftM5YpZnWR8L+wt4w2BCkp6l6BZDaZ3Fl1L398tVvLfvG6R1oyOl9NygPL9pm8YoJZubkZPNNmwiWPHv8x9DRMmBGBcbxyKibwdBhnUDj8GNQjTCw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ashish.Kalra@amd.com; 
Received: from SN1PR12MB2528.namprd12.prod.outlook.com (52.132.196.33) by
 SN1SPR01MB0001.namprd12.prod.outlook.com (52.132.193.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.23; Tue, 21 Jan 2020 20:09:55 +0000
Received: from SN1PR12MB2528.namprd12.prod.outlook.com
 ([fe80::fd48:9921:dd63:c6e1]) by SN1PR12MB2528.namprd12.prod.outlook.com
 ([fe80::fd48:9921:dd63:c6e1%7]) with mapi id 15.20.2644.026; Tue, 21 Jan 2020
 20:09:55 +0000
Date: Tue, 21 Jan 2020 20:09:47 +0000
From: Ashish Kalra <ashish.kalra@amd.com>
To: Konrad Rzeszutek Wilk <konrad@darnok.org>
Subject: Re: [PATCH v2] swiotlb: Adjust SWIOTBL bounce buffer size for SEV
 guests.
Message-ID: <20200121200947.GA24884@ashkalra_ubuntu_server>
References: <20191209231346.5602-1-Ashish.Kalra@amd.com>
 <20191220015245.GA7010@localhost.localdomain>
Content-Disposition: inline
In-Reply-To: <20191220015245.GA7010@localhost.localdomain>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: DM3PR12CA0136.namprd12.prod.outlook.com
 (2603:10b6:0:51::32) To SN1PR12MB2528.namprd12.prod.outlook.com
 (2603:10b6:802:28::33)
MIME-Version: 1.0
Received: from ashkalra_ubuntu_server (165.204.77.1) by
 DM3PR12CA0136.namprd12.prod.outlook.com (2603:10b6:0:51::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.20 via Frontend Transport; Tue, 21 Jan 2020 20:09:53 +0000
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: bcf013a8-e6ee-4958-0d49-08d79eade199
X-MS-TrafficTypeDiagnostic: SN1SPR01MB0001:|SN1SPR01MB0001:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1SPR01MB000148DD9882F0F629A111508E0D0@SN1SPR01MB0001.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0289B6431E
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(396003)(136003)(39860400002)(376002)(346002)(199004)(189003)(86362001)(4326008)(33716001)(8676002)(81156014)(26005)(6916009)(9686003)(55016002)(186003)(16526019)(5660300002)(2906002)(33656002)(316002)(956004)(52116002)(6666004)(478600001)(6496006)(44832011)(81166006)(66476007)(8936002)(66946007)(1076003)(7416002)(66556008);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SN1SPR01MB0001;
 H:SN1PR12MB2528.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ie4qgwXp1ydlBdCqOrXhC2LO/SizoSAEnRpLgf4ZyuIsQIcTS3Lb1DM9M0y5d66Nb8AK3klFdJkFDA0IgluhcBs3tieHqOooSyzE06PAOKqFYJhg+teDZRrwVTVfg+skk8IW65BnpfLdUD5ho+IZGeuuh8lHynnwWi2fj62y6E4PfETvEtfNIZ7/gvzvzaJK2De4DdQxXNYw0sSK8eMVLL2eEBC8/YGOm+7UiyXFYUMcZ5HjysZCcXlSXPFPpkkq5EG2S0Eq6HjGn+58vS0+t6+XAQ9pVfqlZGqsYMFPAZfpiiH1m8/0BMhSmuv3MIktGVula1qKGl4TgpQpQVetofOcF/3+rNAI7Yb9erEPva9oqJxD/Ub+668nrSW4D+/tlrWa84m+IrdQwMf2QkZn9PJkDjL8wHFAT+U1inCDXBvehM1bEq10rJi3FMb9NR3l
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcf013a8-e6ee-4958-0d49-08d79eade199
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2020 20:09:55.1177 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O44NrDU3q8CMjr8EonvHqIQkwyz6jRmFHFqmfFmZ3ARI6L4j0g47engoxBXwYVaGIUaEZthwXkf9nUnSyB9Lpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1SPR01MB0001
Cc: Thomas.Lendacky@amd.com, brijesh.singh@amd.com, dave.hansen@linux-intel.com,
 konrad.wilk@oracle.com, peterz@infradead.org, x86@kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 mingo@redhat.com, bp@alien8.de, luto@kernel.org, hpa@zytor.com,
 tglx@linutronix.de, hch@lst.de
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

On Thu, Dec 19, 2019 at 08:52:45PM -0500, Konrad Rzeszutek Wilk wrote:
> On Mon, Dec 09, 2019 at 11:13:46PM +0000, Ashish Kalra wrote:
> > From: Ashish Kalra <ashish.kalra@amd.com>
> > 
> > For SEV, all DMA to and from guest has to use shared
> > (un-encrypted) pages. SEV uses SWIOTLB to make this happen
> > without requiring changes to device drivers. However,
> > depending on workload being run, the default 64MB of SWIOTLB
> > might not be enough and SWIOTLB may run out of buffers to
> > use for DMA, resulting in I/O errors.
> > 
> > Increase the default size of SWIOTLB for SEV guests using
> > a minimum value of 128MB and a maximum value of 512MB,
> > determining on amount of provisioned guest memory.
> > 
> > The SWIOTLB default size adjustment is added as an
> > architecture specific interface/callback to allow
> > architectures such as those supporting memory encryption
> > to adjust/expand SWIOTLB size for their use.
> 
> What if this was made dynamic? That is if there is a memory
> pressure you end up expanding the SWIOTLB dynamically?

As of now we want to keep it as simple as possible and more
like a stop-gap arrangement till something more elegant is
available.

> 
>> Also is it worth doing this calculation based on memory or
>> more on the # of PCI devices + their MMIO ranges size?

Additional memory calculations based on # of PCI devices and
their memory ranges will make it more complicated with so
many other permutations and combinations to explore, it is
essential to keep this patch as simple as possible by 
adjusting the bounce buffer size simply by determining it
from the amount of provisioned guest memory.

Thanks,
Ashish
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
