Return-Path: <SRS0=8938=FT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01A4FC4361B
	for <iommu@archiver.kernel.org>; Tue, 15 Dec 2020 09:19:19 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F6DB2072C
	for <iommu@archiver.kernel.org>; Tue, 15 Dec 2020 09:19:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F6DB2072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 18B548734F;
	Tue, 15 Dec 2020 09:19:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id S78mujZMI-gp; Tue, 15 Dec 2020 09:19:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 413A186CD1;
	Tue, 15 Dec 2020 09:19:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F3573C088E;
	Tue, 15 Dec 2020 09:19:16 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1E337C013B;
 Tue, 15 Dec 2020 09:19:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id EFBEE87129;
 Tue, 15 Dec 2020 09:19:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QOn-yjOrMLzH; Tue, 15 Dec 2020 09:19:14 +0000 (UTC)
X-Greylist: delayed 00:17:31 by SQLgrey-1.7.6
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760085.outbound.protection.outlook.com [40.107.76.85])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 615C187127;
 Tue, 15 Dec 2020 09:19:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JbR8GxfHnYCrYClwgkYJRckEhl51P7f7vZke0C/MDPBYOcbUh0veP+EshNmZ7sOMMBbs42+V6cvazKc4W6h2RePfe9jdPy/hKz5BWR1YjsElD1Sr7Qv7L9yM5CktCue5HtTlq6Hk5GipgYeBcqHAnN0LamCbaANKxaSsOVczp3fkPpJESV5JlRvz/dE9x/Z8/oxAwQtDOdRuymMcNN8kZq+KpP8S5/gqUtjov53JrbVqWGWRQfpdjyTw/H/7uxLETMvS8sVelMQJxENrSKav07pXxqDJKFxAwAjCbgk74QvyURoRJwoG4I2/TmvyKfoGW9UZonk2hMTReKSzpyN6lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TumceRmf7UqzclKXhJhY4vlyX+wfvD2m9twK1sGG4e4=;
 b=b9l/OXqg4WzNEC0PTy/T62xe0+2vNaO9aAPvuxIWiKf78hbqj6kbS9vr1y4eElFKRFVSjIoTSbDokzb3BOzKo33WiT1ILzvDhBH40glR3GqbXkT2lsaiKmYGn9Veo8YqxFZZArI/nUPptWf+Ti+7vRmooZ3akMxBUvII/SELF6sZni8jwYeFfl7EL2hoonzgmj3eYocFV9R4zd9P2S5dshZd9D0RTlwaL2aTkHoTJrYMIEu2UiEkZtMB8z/OWoWGV3Ya6d2bn/XpLJr4RhVo+ULUmC8tAsV1pEe8IfnKTcuQEPHdgnNU5eEXQ/m636kYA6ayOr+TllFd8zcLc4aQLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TumceRmf7UqzclKXhJhY4vlyX+wfvD2m9twK1sGG4e4=;
 b=TNk3P1KfYJ7oLijSUhaSZiNru/hJTp5CxH55MZygB/j65oun2sFPe4TtsuXCmw3cPMpCzRxywjlxjP2tCLGI0RNUFpNCdgGb6LdAk2LFJRC07YKE3ScUXoIJ1mIENXCYTaidpgRLPcBQl8zgYLoh15oQ0HsPRSzaLy04tITzSpE=
Authentication-Results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2767.namprd12.prod.outlook.com (2603:10b6:805:75::23)
 by SA0PR12MB4382.namprd12.prod.outlook.com (2603:10b6:806:9a::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.18; Tue, 15 Dec
 2020 08:47:26 +0000
Received: from SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::d8f2:fde4:5e1d:afec]) by SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::d8f2:fde4:5e1d:afec%3]) with mapi id 15.20.3654.024; Tue, 15 Dec 2020
 08:47:26 +0000
Date: Tue, 15 Dec 2020 08:47:20 +0000
From: Ashish Kalra <ashish.kalra@amd.com>
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: swiotlb/virtio: unchecked device dma address and length
Message-ID: <20201215084720.GA9981@ashkalra_ubuntu_server>
References: <d2ae0b1d-332b-42a1-87bf-7da2b749cac2@sect.tu-berlin.de>
 <20201214214950.GC18103@char.us.oracle.com>
Content-Disposition: inline
In-Reply-To: <20201214214950.GC18103@char.us.oracle.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: SA9PR03CA0008.namprd03.prod.outlook.com
 (2603:10b6:806:20::13) To SN6PR12MB2767.namprd12.prod.outlook.com
 (2603:10b6:805:75::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ashkalra_ubuntu_server (165.204.77.1) by
 SA9PR03CA0008.namprd03.prod.outlook.com (2603:10b6:806:20::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3632.17 via Frontend Transport; Tue, 15 Dec 2020 08:47:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f62a682f-684b-428e-2423-08d8a0d60ca3
X-MS-TrafficTypeDiagnostic: SA0PR12MB4382:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB4382B639B9EE02C423FEE3D58EC60@SA0PR12MB4382.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EMKWJt/aSoon7mLujW+cd6WX+6s2Gzb9mcZjMLeCUp98k2qjy98AfJlvTRB+Mor0tOh485R1MnUGNENrggnRmo1NbKozRMklMEi72xWFvVleJQsSH+vp+31JTlpWZS/b44ALkvspLIwEaab/O6sF7/pSST1ZNbDWJDfMgEs57HdlRauklwo2s6mdu8Gmmxn+ApjtcmCh0OhuA4NXU/Mz+GY6PH1ZD/lLE15+j8OCDicJsVQ2Nsf0QSIkQplK7pcBH8Xsv/C2KYoMWgvvL2oGH1buMubab3ibJP5QqpbpZ824kKpWEoHgQxdoZ2pQJJb6RgMoAh32FQ9nP3CQSqmNKaVCgVAcWwb4hLOHWAJHlkxruQidqk9W4QbsBmXbfe6ojo5JgO3LFkIxFuyT9qgEquvJh9lEBECBCwRdg1IbFPKaQtCnXj85PVOIPchgP6OKA6BYU6wGgapE/9mrYinklQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR12MB2767.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(376002)(346002)(66946007)(16526019)(33716001)(1076003)(966005)(9686003)(52116002)(2906002)(956004)(6916009)(34490700003)(4326008)(8936002)(8676002)(26005)(186003)(44832011)(55016002)(54906003)(7416002)(508600001)(45080400002)(6496006)(86362001)(33656002)(6666004)(5660300002)(66476007)(66556008)(83380400001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?lbXVujagoDNHm9S68II+sv/GZwvDsUstmdR1NM/Q3yLuAnPvKhHQRLxapRq5?=
 =?us-ascii?Q?SBLu/ZDWTg2mQ1Om6wAsX2jA2fwj9iCI/vnU3XQVT6gTeTFKupGwU3ZpDCEg?=
 =?us-ascii?Q?7wueBlXqVGfBHvkYXGmqzqD3gF+BscNDG2zSuLxS87wzUZnNa3JfV8VCmUfS?=
 =?us-ascii?Q?bDIAg/qkrBNDebCdKGNc2xltvpVl3wsX5ipNClovud9b16r3yt64IF19PKc7?=
 =?us-ascii?Q?ghBCWsmVtIaAN5vxjkIeZcZU2eP0NLLe8B8gw9HXHFSno5+ONqa3N3VsWEJ2?=
 =?us-ascii?Q?tHvSO0IQeovtrZ44ujeLmh1CzifdT4OZ2/FGieEm3Y/OL1CKKulfBEBiw4Rw?=
 =?us-ascii?Q?8qyDUBbaZVvvolFWKqL/uTMKNNMRFcIaDOpmZ6yJWvDSCzn7glo12HuXRhp2?=
 =?us-ascii?Q?P/eeYSNNKKlFTkO14cgsyiZh3KkLNiNvCSmed+f6cqUaCG2ci+F+eEM8zXCI?=
 =?us-ascii?Q?ttAS40z4s7zT5KlTH0HXEKj+vW+0amZNg3oi3yz8XHuODffP680lYi+DbOdG?=
 =?us-ascii?Q?fouAKPosMcq2oVLfyBRaqAtzlcP+8Hhx3A7UTvpFUMM1QQCTGzcme9bMIXvq?=
 =?us-ascii?Q?8Q8KD+sRfxWfU64D4ldDaxsa1zSanbPVsdPIMCeeWOMYfRWe8bgWeeiFgdNA?=
 =?us-ascii?Q?0gabOC8jtvbQRHhU8wfiWmZ9+Yu0n0/cbKzLybclpGQCKfkEUss5U9dKfkGH?=
 =?us-ascii?Q?DaYJ3b99Z+jMOZgIkfriGTc/sdgI+WtRpwZDk/ZwvTgUg6fs2c6PVc6QHIHn?=
 =?us-ascii?Q?lsGL4S3k2o04ZUre+EK4GNUZTPaoVj8RCGuP4UXIhJHfPEJArvR9fNS4vP7h?=
 =?us-ascii?Q?2YjK/LizovBds1vfJFMZCrqa4+g63Nihr3rrZH1RkIqQUafkgaaC1QoFZzct?=
 =?us-ascii?Q?Ws4Uu6vk2a/VopuEzY9MsBeLDLmAKJmEFCW2VK/N2HBfbveXGrGEI4+GbNHT?=
 =?us-ascii?Q?2PktiDOF4i1p3vCWDkxszWhYL2KYhLrO+LmBcZVmqFOmThGriIEXOOzQYMRJ?=
 =?us-ascii?Q?6IPe?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2767.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2020 08:47:26.5710 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: f62a682f-684b-428e-2423-08d8a0d60ca3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HOThCrvgDkQa0V+/gQtRVHePfyq23q8Z5JwXer/ubkDaqqC36zbVTu9ruNgArHIhOEBHih+PNfSG9HIfzZKjZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4382
Cc: Thomas.Lendacky@amd.com, Felicitas Hetzelt <file@sect.tu-berlin.de>, "Radev,
 Martin" <martin.radev@aisec.fraunhofer.de>, david.kaplan@amd.com,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Jon.Grimm@amd.com, virtualization@lists.linux-foundation.org,
 Robert Buhren <robert@sect.tu-berlin.de>, iommu@lists.linux-foundation.org,
 brijesh.singh@amd.com, "Morbitzer,
 Mathias" <mathias.morbitzer@aisec.fraunhofer.de>, hch@lst.de
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

On Mon, Dec 14, 2020 at 04:49:50PM -0500, Konrad Rzeszutek Wilk wrote:
> On Fri, Dec 11, 2020 at 06:31:21PM +0100, Felicitas Hetzelt wrote:
> > Hello,
> 
> Hi! Please see below my responses.
> 
> > we have been analyzing the Hypervisor-OS interface of Linux
> > and discovered bugs in the swiotlb/virtio implementation that can be
> > triggered from a malicious Hypervisor / virtual device.
> > With SEV, the SWIOTLB implementation is forcefully enabled and would
> > always be used. Thus, all virtio devices and others would use it under
> > the hood.
> > 
> > The reason for analyzing this interface is that, technologies such as
> > Intel's Trusted Domain Extensions [1] and AMD's Secure Nested Paging [2]
> > change the threat model assumed by various Linux kernel subsystems.
> > These technologies take the presence of a fully malicious hypervisor
> > into account and aim to provide protection for virtual machines in such
> > an environment. Therefore, all input received from the hypervisor or an
> > external device should be carefully validated. Note that these issues
> > are of little (or no) relevance in a "normal" virtualization setup,
> > nevertheless we believe that it is required to fix them if TDX or SNP is
> > used.
> > 
> > We are happy to provide more information if needed!
> > 
> > [1]
> > https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fsoftware.intel.com%2Fcontent%2Fwww%2Fus%2Fen%2Fdevelop%2Farticles%2Fintel-trust-domain-extensions.html&amp;data=04%7C01%7Cashish.kalra%40amd.com%7C1d1cbca182a84c0e504708d8a079eec0%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637435792867090126%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=THAJlYGLSOx3bKQYH62TLKH50By7Wnsu0z92snfNY84%3D&amp;reserved=0
> > 
> > [2] https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fwww.amd.com%2Fen%2Fprocessors%2Famd-secure-encrypted-virtualization&amp;data=04%7C01%7Cashish.kalra%40amd.com%7C1d1cbca182a84c0e504708d8a079eec0%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637435792867090126%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=M3jmYCWaEvmAzIy%2F4z5XstsPf812SbEkuNX5PVVr0HY%3D&amp;reserved=0
> > 
> > Bug:
> > OOB memory write.
> > dma_unmap_single -> swiotlb_tbl_unmap_single is invoked with dma_addr
> > and length parameters that are under control of the device.
> > This happens e.g. in virtio_ring:
> > https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Felixir.bootlin.com%2Flinux%2Fv5.10-rc7%2Fsource%2Fdrivers%2Fvirtio%2Fvirtio_ring.c%23L378&amp;data=04%7C01%7Cashish.kalra%40amd.com%7C1d1cbca182a84c0e504708d8a079eec0%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637435792867090126%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=j0CIi%2F8hBkVx45XGBtT4Ri52uWIOdOts%2BSbJ0kCB5B0%3D&amp;reserved=0
> 
> Heya!
> 
> Thank you for pointing this out! I've a couple of questions and hope you can
> help me out with them.
> 
> Also CC-ing AMD / TDX folks.
> > 

Adding more relevant folks in AMD.

Needless to say, the swiotlb code needs to validate this external untrusted input dma_addr and length parameters.

Thanks,
Ashish

> > This raises two issues:
> > 1) swiotlb_tlb_unmap_single fails to check whether the index generated
> > from the dma_addr is in range of the io_tlb_orig_addr array.
> 
> That is fairly simple to implement I would think. That is it can check
> that the dma_addr is from the PA in the io_tlb pool when SWIOTLB=force
> is used.
> 
> > 2) when swiotlb_bounce is called the device controls the length of the
> > memory copied to the cpu address.
> 
> So.. this sounds very similar to the Intel Thunder.. something issue
> where this exact issue was fixed by handing the DMA off to the SWIOTLB
> bounce code.
> 
> But if that is broken, then that CVE is still not fixed?
> 
> So the issue here is that swiotlb_tbl_unmap_single(..,mapping_size,) is
> under the attacker control. Ugh.
> 
> One way could be to have a io_tlb_orig_addr-ish array with the length
> of mappings to double check?
> 
> Couple more questions:
>  - Did you have already some PoC fixes for this? 
>  - Is there a CVE associated with this?
>  - Is there a paper on this you all are working on?
> 
> Thank you!
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
