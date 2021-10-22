Return-Path: <SRS0=cgap=PK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 613B5C433EF
	for <iommu@archiver.kernel.org>; Fri, 22 Oct 2021 17:34:15 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 011A061108
	for <iommu@archiver.kernel.org>; Fri, 22 Oct 2021 17:34:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 011A061108
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B94EC80C18;
	Fri, 22 Oct 2021 17:34:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tPOjiIJDeqlR; Fri, 22 Oct 2021 17:34:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 4A0BB80C0D;
	Fri, 22 Oct 2021 17:34:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 23157C001F;
	Fri, 22 Oct 2021 17:34:13 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 74381C001E
 for <iommu@lists.linux-foundation.org>; Fri, 22 Oct 2021 17:34:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5513E400F6
 for <iommu@lists.linux-foundation.org>; Fri, 22 Oct 2021 17:34:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RnjBdfS_6xqd for <iommu@lists.linux-foundation.org>;
 Fri, 22 Oct 2021 17:34:10 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DA2654011A
 for <iommu@lists.linux-foundation.org>; Fri, 22 Oct 2021 17:34:09 +0000 (UTC)
Received: by mail-oi1-x235.google.com with SMTP id u69so5955549oie.3
 for <iommu@lists.linux-foundation.org>; Fri, 22 Oct 2021 10:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=O/T8JT2zelvn/zbCB5W0fkYXIuA+ozhU4d8Jex1kzRg=;
 b=XOnlx/Yy3xKYACo8edXxd62IVvXb7ZusuX7SodOvqqI0nNJXrGtMffG1CH3Cv+VEyI
 I+mwnzdxYquAXkUMMevibNWVV4hikhi9ayEMrS5ctqbyIonLDyeSy5YTcQS8xy/zLNCK
 oTAjmJO4pZrVyxwrEIUrY9y0bTiDXeMhG15blnIQtFaRIyJyq2i162VCzCojozntsHOz
 G0EpduFmRHL2lcjhAPs9tMn/rHssmTFpcj4MdlrZgEGbhhrScUr88m3NIaNEobG4ynjJ
 fjC1x+mc+nGCDEj6GCKCNXYRMcTipu98VbxMPQRLJSoKQHfoYSCSwhLkCXGVcfro2AbO
 0CIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=O/T8JT2zelvn/zbCB5W0fkYXIuA+ozhU4d8Jex1kzRg=;
 b=sXAWZ6cvCPr52OOdgEB6rHwqefwIufbuUx2qQXc9nN9VyzYX2I5lZgrTtf+Og4EIjJ
 cvnjjwAR8RfRAjej3wPQkUad3WaHyfsQUAsLg3Z8sc4M40yUZHeJI18U5qfp1NTIywA3
 NsypjDZF7W+K3SxGaHB5O44gjZopJtGQXt5xqzVwyeBngtc0ZnhtMSsORyd20xXEqGsB
 OQrPkNZQ9S61WtEhzAmJEqPq3T+t6XMtHvc28vcQ148IrZXXeOOEniYMTJuCYxHh0481
 kZK1t78DeQvoBFlBwzVI5nvUqNj4Km+UFN/C8eVrXeGjsa7i3/DB/f/6YUPp0HPoYJ1B
 hcmQ==
X-Gm-Message-State: AOAM5331xc0G8+9AAgW9+K/EGKQVZQDEkXxIT+cv6Ak6YWuwQfOaQ8dm
 REbcHtSRUHr9Du3ROcYI1L7F9M2uqsMxjq+zlCWMiSgFzX0DOg==
X-Google-Smtp-Source: ABdhPJwtbkveb24tN1nTAsqTjkU/7ntm56Uko6XnTYEXnPVStYt7ktMRB6/iJ3dhja2VYav74mM420W++o7HSXT9Fi8=
X-Received: by 2002:a05:6808:1388:: with SMTP id
 c8mr796795oiw.91.1634924048459; 
 Fri, 22 Oct 2021 10:34:08 -0700 (PDT)
MIME-Version: 1.0
References: <20211012135653.3852-1-ajaygargnsit@gmail.com>
In-Reply-To: <20211012135653.3852-1-ajaygargnsit@gmail.com>
From: Ajay Garg <ajaygargnsit@gmail.com>
Date: Fri, 22 Oct 2021 23:03:56 +0530
Message-ID: <CAHP4M8VGwyOA1kTHVFkEkWchnGgUDoxeLnmWK-FOO206XRdHVA@mail.gmail.com>
Subject: Re: [PATCH v2] iommu: intel: do deep dma-unmapping,
 to avoid kernel-flooding.
To: iommu@lists.linux-foundation.org
Cc: Alex Williamson <alex.williamson@redhat.com>
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

Ping ..

Any updates please on this?

It will be great to have the fix upstreamed (properly of course).

Right now, the patch contains the change as suggested, of
explicitly/properly clearing out dma-mappings when unmap is called.
Please let me know in whatever way I can help, including
testing/debugging for other approaches if required.


Many thanks to Alex and Lu for their continued support on the issue.



P.S. :

I might have missed mentioning the information about the device that
causes flooding.
Please find it below :

######################################
sudo lspci -vvv

0a:00.0 SD Host controller: O2 Micro, Inc. OZ600FJ0/OZ900FJ0/OZ600FJS
SD/MMC Card Reader Controller (rev 05) (prog-if 01)
    Subsystem: Dell OZ600FJ0/OZ900FJ0/OZ600FJS SD/MMC Card Reader Controller
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0, Cache Line Size: 64 bytes
    Interrupt: pin A routed to IRQ 17
    IOMMU group: 14
    Region 0: Memory at e2c20000 (32-bit, non-prefetchable) [size=512]
    Capabilities: [a0] Power Management version 3
        Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
        Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
    Capabilities: [48] MSI: Enable- Count=1/1 Maskable+ 64bit+
        Address: 0000000000000000  Data: 0000
        Masking: 00000000  Pending: 00000000
    Capabilities: [80] Express (v1) Endpoint, MSI 00
        DevCap:    MaxPayload 128 bytes, PhantFunc 0, Latency L0s <4us, L1 <64us
            ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
SlotPowerLimit 10.000W
        DevCtl:    CorrErr- NonFatalErr- FatalErr- UnsupReq-
            RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
            MaxPayload 128 bytes, MaxReadReq 512 bytes
        DevSta:    CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr- TransPend-
        LnkCap:    Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit
Latency L0s <512ns, L1 <64us
            ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp-
        LnkCtl:    ASPM L0s Enabled; RCB 64 bytes, Disabled- CommClk-
            ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
        LnkSta:    Speed 2.5GT/s (ok), Width x1 (ok)
            TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-
    Capabilities: [100 v1] Virtual Channel
        Caps:    LPEVC=0 RefClk=100ns PATEntryBits=1
        Arb:    Fixed- WRR32- WRR64- WRR128-
        Ctrl:    ArbSelect=Fixed
        Status:    InProgress-
        VC0:    Caps:    PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
            Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
            Ctrl:    Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
            Status:    NegoPending- InProgress-
    Capabilities: [200 v1] Advanced Error Reporting
        UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
        UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
        UESvrt:    DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt-
RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
        CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr-
        CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
        AERCap:    First Error Pointer: 00, ECRCGenCap- ECRCGenEn-
ECRCChkCap- ECRCChkEn-
            MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
        HeaderLog: 00000000 00000000 00000000 00000000
    Kernel driver in use: sdhci-pci
    Kernel modules: sdhci_pci
######################################



Thanks and Regards,
Ajay

On Tue, Oct 12, 2021 at 7:27 PM Ajay Garg <ajaygargnsit@gmail.com> wrote:
>
> Origins at :
> https://lists.linuxfoundation.org/pipermail/iommu/2021-October/thread.html
>
> === Changes from v1 => v2 ===
>
> a)
> Improved patch-description.
>
> b)
> A more root-level fix, as suggested by
>
>         1.
>         Alex Williamson <alex.williamson@redhat.com>
>
>         2.
>         Lu Baolu <baolu.lu@linux.intel.com>
>
>
>
> === Issue ===
>
> Kernel-flooding is seen, when an x86_64 L1 guest (Ubuntu-21) is booted in qemu/kvm
> on a x86_64 host (Ubuntu-21), with a host-pci-device attached.
>
> Following kind of logs, along with the stacktraces, cause the flood :
>
> ......
>  DMAR: ERROR: DMA PTE for vPFN 0x428ec already set (to 3f6ec003 not 3f6ec003)
>  DMAR: ERROR: DMA PTE for vPFN 0x428ed already set (to 3f6ed003 not 3f6ed003)
>  DMAR: ERROR: DMA PTE for vPFN 0x428ee already set (to 3f6ee003 not 3f6ee003)
>  DMAR: ERROR: DMA PTE for vPFN 0x428ef already set (to 3f6ef003 not 3f6ef003)
>  DMAR: ERROR: DMA PTE for vPFN 0x428f0 already set (to 3f6f0003 not 3f6f0003)
> ......
>
>
>
> === Current Behaviour, leading to the issue ===
>
> Currently, when we do a dma-unmapping, we unmap/unlink the mappings, but
> the pte-entries are not cleared.
>
> Thus, following sequencing would flood the kernel-logs :
>
> i)
> A dma-unmapping makes the real/leaf-level pte-slot invalid, but the
> pte-content itself is not cleared.
>
> ii)
> Now, during some later dma-mapping procedure, as the pte-slot is about
> to hold a new pte-value, the intel-iommu checks if a prior
> pte-entry exists in the pte-slot. If it exists, it logs a kernel-error,
> along with a corresponding stacktrace.
>
> iii)
> Step ii) runs in abundance, and the kernel-logs run insane.
>
>
>
> === Fix ===
>
> We ensure that as part of a dma-unmapping, each (unmapped) pte-slot
> is also cleared of its value/content (at the leaf-level, where the
> real mapping from a iova => pfn mapping is stored).
>
> This completes a "deep" dma-unmapping.
>
>
>
> Signed-off-by: Ajay Garg <ajaygargnsit@gmail.com>
> ---
>  drivers/iommu/intel/iommu.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index d75f59ae28e6..485a8ea71394 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -5090,6 +5090,8 @@ static size_t intel_iommu_unmap(struct iommu_domain *domain,
>         gather->freelist = domain_unmap(dmar_domain, start_pfn,
>                                         last_pfn, gather->freelist);
>
> +       dma_pte_clear_range(dmar_domain, start_pfn, last_pfn);
> +
>         if (dmar_domain->max_addr == iova + size)
>                 dmar_domain->max_addr = iova;
>
> --
> 2.30.2
>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
