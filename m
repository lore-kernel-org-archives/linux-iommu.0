From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: warn_slowpath_common in drivers/pci/search.c:44 on linux-3.4.0
Date: Sat, 26 May 2012 09:09:52 -0600
Message-ID: <CAErSpo553_-AivRa7VbjHrFraHaO4NYoYR7A9Am5fkDP-CMvSA@mail.gmail.com>
References: <20120526082551.GA2723@ritirata.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <20120526082551.GA2723@ritirata.org>
Sender: linux-pci-owner@vger.kernel.org
To: Antonio Quartulli <ordex@autistici.org>
Cc: linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org
List-Id: iommu@lists.linux-foundation.org

On Sat, May 26, 2012 at 2:25 AM, Antonio Quartulli <ordex@autistici.org=
> wrote:
> Hello,
>
> I'm getting this warning with linux-3.4.0. My laptop is a DELL E5420.
> Please tell me if you need further testing/debug.

Hi Antonio,

Thanks for the report.  Is this a regression?  If so, what's the most
recent kernel that works correctly?  Can you collect a complete dmesg
log and the output of "lspci -vv"?

> [ =A0 =A01.054279] WARNING: at drivers/pci/search.c:44 pci_find_upstr=
eam_pcie_bridge+0x5e/0x70()
> [ =A0 =A01.054385] Hardware name: Latitude E5420
> [ =A0 =A01.054457] Modules linked in:
> [ =A0 =A01.054568] Pid: 1, comm: swapper/0 Not tainted 3.4.0ordex+ #3
> [ =A0 =A01.054643] Call Trace:
> [ =A0 =A01.054716] =A0[<ffffffff81033d4a>] warn_slowpath_common+0x7a/=
0xb0
> [ =A0 =A01.054793] =A0[<ffffffff81033d95>] warn_slowpath_null+0x15/0x=
20
> [ =A0 =A01.054869] =A0[<ffffffff8123899e>] pci_find_upstream_pcie_bri=
dge+0x5e/0x70
> [ =A0 =A01.054949] =A0[<ffffffff813babe7>] intel_iommu_device_group+0=
x77/0x100
> [ =A0 =A01.055027] =A0[<ffffffff813b52d5>] add_iommu_group+0x35/0x60
> [ =A0 =A01.055113] =A0[<ffffffff813b52a0>] ? bus_set_iommu+0x50/0x50
> [ =A0 =A01.055191] =A0[<ffffffff8132c586>] bus_for_each_dev+0x56/0x90
> [ =A0 =A01.055267] =A0[<ffffffff813b528b>] bus_set_iommu+0x3b/0x50
> [ =A0 =A01.055344] =A0[<ffffffff818c4920>] intel_iommu_init+0xab0/0xb=
3f
> [ =A0 =A01.055421] =A0[<ffffffff81120b26>] ? sys_mkdirat+0x76/0xd0
> [ =A0 =A01.055499] =A0[<ffffffff8189b0db>] ? memblock_find_dma_reserv=
e+0x13d/0x13d
> [ =A0 =A01.055578] =A0[<ffffffff8189b0ee>] pci_iommu_init+0x13/0x3e
> [ =A0 =A01.055655] =A0[<ffffffff810001ca>] do_one_initcall+0x3a/0x170
> [ =A0 =A01.055732] =A0[<ffffffff81897c35>] kernel_init+0x148/0x1cc
> [ =A0 =A01.055807] =A0[<ffffffff81897588>] ? do_early_param+0x86/0x86
> [ =A0 =A01.055884] =A0[<ffffffff814fc914>] kernel_thread_helper+0x4/0=
x10
> [ =A0 =A01.055963] =A0[<ffffffff8105de60>] ? finish_task_switch+0x80/=
0x110
> [ =A0 =A01.056040] =A0[<ffffffff814fafdd>] ? retint_restore_args+0xe/=
0xe
> [ =A0 =A01.056126] =A0[<ffffffff81897aed>] ? start_kernel+0x30b/0x30b
> [ =A0 =A01.056203] =A0[<ffffffff814fc910>] ? gs_change+0xb/0xb
>
>
>
> --
> Antonio Quartulli
>
> ..each of us alone is worth nothing..
> Ernesto "Che" Guevara
