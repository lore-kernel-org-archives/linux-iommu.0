From: Joerg Roedel <joerg.roedel@amd.com>
Subject: Re: warn_slowpath_common in drivers/pci/search.c:44 on linux-3.4.0
Date: Tue, 29 May 2012 10:35:53 +0200
Message-ID: <20120529083552.GN2604@amd.com>
References: <20120526082551.GA2723@ritirata.org>
 <CAErSpo553_-AivRa7VbjHrFraHaO4NYoYR7A9Am5fkDP-CMvSA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pci-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAErSpo553_-AivRa7VbjHrFraHaO4NYoYR7A9Am5fkDP-CMvSA@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Antonio Quartulli <ordex@autistici.org>, linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org
List-Id: iommu@lists.linux-foundation.org

Hi Antonio,

On Sat, May 26, 2012 at 09:09:52AM -0600, Bjorn Helgaas wrote:
> On Sat, May 26, 2012 at 2:25 AM, Antonio Quartulli <ordex@autistici.o=
rg> wrote:
> > [ =A0 =A01.054279] WARNING: at drivers/pci/search.c:44 pci_find_ups=
tream_pcie_bridge+0x5e/0x70()
> > [ =A0 =A01.054385] Hardware name: Latitude E5420
> > [ =A0 =A01.054457] Modules linked in:
> > [ =A0 =A01.054568] Pid: 1, comm: swapper/0 Not tainted 3.4.0ordex+ =
#3
> > [ =A0 =A01.054643] Call Trace:
> > [ =A0 =A01.054716] =A0[<ffffffff81033d4a>] warn_slowpath_common+0x7=
a/0xb0
> > [ =A0 =A01.054793] =A0[<ffffffff81033d95>] warn_slowpath_null+0x15/=
0x20
> > [ =A0 =A01.054869] =A0[<ffffffff8123899e>] pci_find_upstream_pcie_b=
ridge+0x5e/0x70
> > [ =A0 =A01.054949] =A0[<ffffffff813babe7>] intel_iommu_device_group=
+0x77/0x100
> > [ =A0 =A01.055027] =A0[<ffffffff813b52d5>] add_iommu_group+0x35/0x6=
0
> > [ =A0 =A01.055113] =A0[<ffffffff813b52a0>] ? bus_set_iommu+0x50/0x5=
0
> > [ =A0 =A01.055191] =A0[<ffffffff8132c586>] bus_for_each_dev+0x56/0x=
90
> > [ =A0 =A01.055267] =A0[<ffffffff813b528b>] bus_set_iommu+0x3b/0x50
> > [ =A0 =A01.055344] =A0[<ffffffff818c4920>] intel_iommu_init+0xab0/0=
xb3f
> > [ =A0 =A01.055421] =A0[<ffffffff81120b26>] ? sys_mkdirat+0x76/0xd0
> > [ =A0 =A01.055499] =A0[<ffffffff8189b0db>] ? memblock_find_dma_rese=
rve+0x13d/0x13d
> > [ =A0 =A01.055578] =A0[<ffffffff8189b0ee>] pci_iommu_init+0x13/0x3e
> > [ =A0 =A01.055655] =A0[<ffffffff810001ca>] do_one_initcall+0x3a/0x1=
70
> > [ =A0 =A01.055732] =A0[<ffffffff81897c35>] kernel_init+0x148/0x1cc
> > [ =A0 =A01.055807] =A0[<ffffffff81897588>] ? do_early_param+0x86/0x=
86
> > [ =A0 =A01.055884] =A0[<ffffffff814fc914>] kernel_thread_helper+0x4=
/0x10
> > [ =A0 =A01.055963] =A0[<ffffffff8105de60>] ? finish_task_switch+0x8=
0/0x110
> > [ =A0 =A01.056040] =A0[<ffffffff814fafdd>] ? retint_restore_args+0x=
e/0xe
> > [ =A0 =A01.056126] =A0[<ffffffff81897aed>] ? start_kernel+0x30b/0x3=
0b
> > [ =A0 =A01.056203] =A0[<ffffffff814fc910>] ? gs_change+0xb/0xb

Hmm, this looks like pci_find_upstream_pcie_bridge() found a PCIe devic=
e
in the chain which is not a bridge. Can you please post the output of
'lspci -vvv' and 'lspci -t'?

Thanks,

	Joerg

--=20
AMD Operating System Research Center

Advanced Micro Devices GmbH Einsteinring 24 85609 Dornach
General Managers: Alberto Bozzo
Registration: Dornach, Landkr. Muenchen; Registerger. Muenchen, HRB Nr.=
 43632
