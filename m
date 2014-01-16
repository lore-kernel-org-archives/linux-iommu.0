From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: Problem: dmar: DRHD: handling fault status reg 3 on Red Hat 6.5
Date: Wed, 15 Jan 2014 20:58:08 -0700
Message-ID: <1389844688.8705.43.camel@bling.home>
References: <05480ADF32EBAC4D92944581B85B69422BE3ACB3@FMSMSX103.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <05480ADF32EBAC4D92944581B85B69422BE3ACB3-AtyAts71sc9Qxe9IK+vIArfspsVTdybXVpNB7YpNyf8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "Dominguez, Caesar" <caesar.dominguez-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Thu, 2014-01-16 at 01:11 +0000, Dominguez, Caesar wrote:
> When attempting to boot a fresh Red hat 6.5 installation, kernel
> constantly show the following message.

Please report RHEL issues to the RH bugzilla,
https://bugzilla.redhat.com/

Include the full console log or dmesg.  Thanks,

Alex

> If user uses 6.4, none of this issue is seen.
> 
>  
> 
> 06] PTE Read access is not set
> 
> dmar: DRHD: handling fault status reg 3
> 
> dmar: DMAR:[DMA Read] Request device [00:02.0] fault addr 7f800000 
> 
>  
> 
> This only is seeing on Red Hat 6.5, same system configuration using
> Red Hat 6.4, do not cause this issu
> 
> Current workaournd is to disable iommu
> 
> Using both options resolve the issue
> 
> Intel_iommu=igfx_off
> 
> Or
> 
> Intel_iommu=off
> 
>  
> 
> I suspect of Kernel modules: i915, is there a Red Hat 6.5 bugzilla
> reporting this or should I look for a i915 module?
> 
> Since same module is used on Red hat 6.4. 
> 
>  
> 
> Details device [00:02.0]
> 
> 00:02.0 VGA compatible controller: Intel Corporation Xeon E3-1200 v3
> Processor Integrated Graphics Controller (rev 06) (prog-if 00 [VGA
> controller])
> 
>      Subsystem: Intel Corporation Device 2212
> 
>      Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B- DisINTx-
> 
>      Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
> 
>      Interrupt: pin A routed to IRQ 16
> 
>      Region 0: Memory at c0000000 (64-bit, non-prefetchable) [size=4M]
> 
>      Region 2: Memory at b0000000 (64-bit, prefetchable) [size=256M]
> 
>      Region 4: I/O ports at 6000 [size=64]
> 
>      Expansion ROM at <unassigned> [disabled]
> 
>      Capabilities: [90] MSI: Enable- Count=1/1 Maskable- 64bit-
> 
>            Address: 00000000  Data: 0000
> 
>      Capabilities: [d0] Power Management version 2
> 
>            Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
> 
>           Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
> 
>      Capabilities: [a4] PCI Advanced Features
> 
>            AFCap: TP+ FLR+
> 
>            AFCtrl: FLR-
> 
>            AFStatus: TP-
> 
>      Kernel modules: i915
> 
>  
> 
>  
> 
>  
> 
> 
> _______________________________________________
> iommu mailing list
> iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
