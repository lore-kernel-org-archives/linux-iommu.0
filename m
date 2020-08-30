Return-Path: <SRS0=f6HJ=CI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0AB2C433E6
	for <iommu@archiver.kernel.org>; Sun, 30 Aug 2020 16:16:23 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9BF620714
	for <iommu@archiver.kernel.org>; Sun, 30 Aug 2020 16:16:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9BF620714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 7C5F2844C1;
	Sun, 30 Aug 2020 16:16:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OruTtzdh7aQT; Sun, 30 Aug 2020 16:16:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 6FED5835C4;
	Sun, 30 Aug 2020 16:16:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 404CCC0052;
	Sun, 30 Aug 2020 16:16:22 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9C309C0051
 for <iommu@lists.linux-foundation.org>; Sun, 30 Aug 2020 09:14:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 789FC203F2
 for <iommu@lists.linux-foundation.org>; Sun, 30 Aug 2020 09:14:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jwMF4j3MHnOR for <iommu@lists.linux-foundation.org>;
 Sun, 30 Aug 2020 09:14:15 +0000 (UTC)
X-Greylist: delayed 00:09:48 by SQLgrey-1.7.6
Received: from smtpout1.mo529.mail-out.ovh.net
 (smtpout1.mo529.mail-out.ovh.net [178.32.125.2])
 by silver.osuosl.org (Postfix) with ESMTPS id 47F6D203EF
 for <iommu@lists.linux-foundation.org>; Sun, 30 Aug 2020 09:14:15 +0000 (UTC)
Received: from mxplan5.mail.ovh.net (unknown [10.108.20.2])
 by mo529.mail-out.ovh.net (Postfix) with ESMTPS id F3603557382C;
 Sun, 30 Aug 2020 11:04:22 +0200 (CEST)
Received: from kaod.org (37.59.142.96) by DAG4EX1.mxp5.local (172.16.2.31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2044.4; Sun, 30 Aug
 2020 11:04:21 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-96R0016ce9946f-44e8-4705-a814-a851a51eb937,
 A61985F152D94A1A5BA9A2811F8297B44BAD0564) smtp.auth=clg@kaod.org
Subject: Re: [PATCH 5/5] powerpc: use the generic dma_ops_bypass mode
To: Christoph Hellwig <hch@lst.de>, <iommu@lists.linux-foundation.org>, Alexey
 Kardashevskiy <aik@ozlabs.ru>
References: <20200708152449.316476-1-hch@lst.de>
 <20200708152449.316476-6-hch@lst.de>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <505bcc1d-01a7-9655-88e1-ebddd0b94d56@kaod.org>
Date: Sun, 30 Aug 2020 11:04:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200708152449.316476-6-hch@lst.de>
Content-Language: en-US
X-Originating-IP: [37.59.142.96]
X-ClientProxiedBy: DAG1EX1.mxp5.local (172.16.2.1) To DAG4EX1.mxp5.local
 (172.16.2.31)
X-Ovh-Tracer-GUID: e391a1c1-ee29-474b-bb7b-57b64649e998
X-Ovh-Tracer-Id: 7752383811902344065
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduiedrudeffedgudefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepuffvfhfhkffffgggjggtgfhisehtjeertddtfeejnecuhfhrohhmpeevrogurhhitggpnfgvpgfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepgedvieejfedvhfduhfffueevheeludffhfdvkeehleegtddttdfhieegveeghfffnecukfhppedtrddtrddtrddtpdefjedrheelrddugedvrdelieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehmgihplhgrnhehrdhmrghilhdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtohephhgthheslhhsthdruggv
X-Mailman-Approved-At: Sun, 30 Aug 2020 16:16:20 +0000
Cc: linuxppc-dev@lists.ozlabs.org, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <brouer@redhat.com>, linux-kernel@vger.kernel.org,
 Oliver O'Halloran <oohall@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, aacraid@microsemi.com,
 Robin Murphy <robin.murphy@arm.com>
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

Hello,

On 7/8/20 5:24 PM, Christoph Hellwig wrote:
> Use the DMA API bypass mechanism for direct window mappings.  This uses
> common code and speed up the direct mapping case by avoiding indirect
> calls just when not using dma ops at all.  It also fixes a problem where
> the sync_* methods were using the bypass check for DMA allocations, but
> those are part of the streaming ops.
> 
> Note that this patch loses the DMA_ATTR_WEAK_ORDERING override, which
> has never been well defined, as is only used by a few drivers, which
> IIRC never showed up in the typical Cell blade setups that are affected
> by the ordering workaround.
> 
> Fixes: efd176a04bef ("powerpc/pseries/dma: Allow SWIOTLB")
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/powerpc/Kconfig              |  1 +
>  arch/powerpc/include/asm/device.h |  5 --
>  arch/powerpc/kernel/dma-iommu.c   | 90 ++++---------------------------
>  3 files changed, 10 insertions(+), 86 deletions(-)

I am seeing corruptions on a couple of POWER9 systems (boston) when
stressed with IO. stress-ng gives some results but I have first seen
it when compiling the kernel in a guest and this is still the best way
to raise the issue.

These systems have of a SAS Adaptec controller :

  0003:01:00.0 Serial Attached SCSI controller: Adaptec Series 8 12G SAS/PCIe 3 (rev 01)

When the failure occurs, the POWERPC EEH interrupt fires and dumps
lowlevel PHB4 registers among which :
					  
  [ 2179.251069490,3] PHB#0003[0:3]:           phbErrorStatus = 0000028000000000
  [ 2179.251117476,3] PHB#0003[0:3]:      phbFirstErrorStatus = 0000020000000000

The bits raised identify a PPC 'TCE' error, which means it is related
to DMAs. See below for more details.


Reverting this patch "fixes" the issue but it is probably else where,
in some other layers or in the aacraid driver. How should I proceed 
to get more information ?

Thanks,

C.


[ 2054.970339] EEH: Frozen PE#1fd on PHB#3 detected
[ 2054.970375] EEH: PE location: UOPWR.BOS0019-Node0-Onboard SAS, PHB location: N/A
[ 2179.249415973,3] PHB#0003[0:3]:                  brdgCtl = 00000002
[ 2179.249515795,3] PHB#0003[0:3]:             deviceStatus = 00060040
[ 2179.249596452,3] PHB#0003[0:3]:               slotStatus = 00402000
[ 2179.249633728,3] PHB#0003[0:3]:               linkStatus = a0830008
[ 2179.249674807,3] PHB#0003[0:3]:             devCmdStatus = 00100107
[ 2179.249725974,3] PHB#0003[0:3]:             devSecStatus = 00100107
[ 2179.249773550,3] PHB#0003[0:3]:          rootErrorStatus = 00000000
[ 2179.249809823,3] PHB#0003[0:3]:          corrErrorStatus = 00000000
[ 2179.249850439,3] PHB#0003[0:3]:        uncorrErrorStatus = 00000000
[ 2179.249887411,3] PHB#0003[0:3]:                   devctl = 00000040
[ 2179.249928677,3] PHB#0003[0:3]:                  devStat = 00000006
[ 2179.249967150,3] PHB#0003[0:3]:                  tlpHdr1 = 00000000
[ 2179.250054987,3] PHB#0003[0:3]:                  tlpHdr2 = 00000000
[ 2179.250146600,3] PHB#0003[0:3]:                  tlpHdr3 = 00000000
[ 2179.250262780,3] PHB#0003[0:3]:                  tlpHdr4 = 00000000
[ 2179.250343101,3] PHB#0003[0:3]:                 sourceId = 00000000
[ 2179.250514264,3] PHB#0003[0:3]:                     nFir = 0000000000000000
[ 2179.250717971,3] PHB#0003[0:3]:                 nFirMask = 0030001c00000000
[ 2179.250791474,3] PHB#0003[0:3]:                  nFirWOF = 0000000000000000
[ 2179.250842054,3] PHB#0003[0:3]:                 phbPlssr = 0000001c00000000
[ 2179.250886003,3] PHB#0003[0:3]:                   phbCsr = 0000001c00000000
[ 2179.250929859,3] PHB#0003[0:3]:                   lemFir = 0000000100000080
[ 2179.250973720,3] PHB#0003[0:3]:             lemErrorMask = 0000000000000000
[ 2179.251018622,3] PHB#0003[0:3]:                   lemWOF = 0000000000000080
[ 2179.251069490,3] PHB#0003[0:3]:           phbErrorStatus = 0000028000000000
[ 2179.251117476,3] PHB#0003[0:3]:      phbFirstErrorStatus = 0000020000000000
[ 2179.251162218,3] PHB#0003[0:3]:             phbErrorLog0 = 2148000098000240
[ 2179.251206251,3] PHB#0003[0:3]:             phbErrorLog1 = a008400000000000
[ 2179.251253096,3] PHB#0003[0:3]:        phbTxeErrorStatus = 0000000000000000
[ 2179.265087656,3] PHB#0003[0:3]:   phbTxeFirstErrorStatus = 0000000000000000
[ 2179.265142247,3] PHB#0003[0:3]:          phbTxeErrorLog0 = 0000000000000000
[ 2179.265189734,3] PHB#0003[0:3]:          phbTxeErrorLog1 = 0000000000000000
[ 2179.266335296,3] PHB#0003[0:3]:     phbRxeArbErrorStatus = 0000000000000000
[ 2179.266380366,3] PHB#0003[0:3]: phbRxeArbFrstErrorStatus = 0000000000000000
[ 2179.266426523,3] PHB#0003[0:3]:       phbRxeArbErrorLog0 = 0000000000000000
[ 2179.267537283,3] PHB#0003[0:3]:       phbRxeArbErrorLog1 = 0000000000000000
[ 2179.267581708,3] PHB#0003[0:3]:     phbRxeMrgErrorStatus = 0000000000000000
[ 2179.267628324,3] PHB#0003[0:3]: phbRxeMrgFrstErrorStatus = 0000000000000000
[ 2179.268748771,3] PHB#0003[0:3]:       phbRxeMrgErrorLog0 = 0000000000000000
[ 2179.268794753,3] PHB#0003[0:3]:       phbRxeMrgErrorLog1 = 0000000000000000
[ 2179.268841144,3] PHB#0003[0:3]:     phbRxeTceErrorStatus = 6000000000000000
[ 2179.269945557,3] PHB#0003[0:3]: phbRxeTceFrstErrorStatus = 2000000000000000
[ 2179.269997896,3] PHB#0003[0:3]:       phbRxeTceErrorLog0 = c0000000000001fd
[ 2179.270094740,3] PHB#0003[0:3]:       phbRxeTceErrorLog1 = 0000000000000000
[ 2179.270144030,3] PHB#0003[0:3]:        phbPblErrorStatus = 0000000000020000
[ 2179.281523166,3] PHB#0003[0:3]:   phbPblFirstErrorStatus = 0000000000020000
[ 2179.281575378,3] PHB#0003[0:3]:          phbPblErrorLog0 = 0000000000000000
[ 2179.281627897,3] PHB#0003[0:3]:          phbPblErrorLog1 = 0000000000000000
[ 2179.282710177,3] PHB#0003[0:3]:      phbPcieDlpErrorLog1 = 0000000000000000
[ 2179.282761495,3] PHB#0003[0:3]:      phbPcieDlpErrorLog2 = 0000000000000000
[ 2179.282813999,3] PHB#0003[0:3]:    phbPcieDlpErrorStatus = 0000000000000000
[ 2179.283926192,3] PHB#0003[0:3]:       phbRegbErrorStatus = 0000004000000000
[ 2179.283978457,3] PHB#0003[0:3]:  phbRegbFirstErrorStatus = 0000004000000000
[ 2179.284033525,3] PHB#0003[0:3]:         phbRegbErrorLog0 = 8800005800000000
[ 2179.285123005,3] PHB#0003[0:3]:         phbRegbErrorLog1 = 0000000007011000
[ 2179.285178505,3] PHB#0003[0:3]:                PEST[1fd] = 8300b03800000000 8000000000000000
[ 2055.043233] EEH: Recovering PHB#3-PE#1fd
[ 2055.043274] EEH: PE location: UOPWR.BOS0019-Node0-Onboard SAS, PHB location: N/A
[ 2055.043423] aacraid 0003:01:00.0: aacraid: PCI error detected 2
[ 2055.099306] blk_update_request: I/O error, dev sda, sector 510949048 op 0x1:(WRITE) flags 0xc800 phys_seg 4 prio class 0
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
