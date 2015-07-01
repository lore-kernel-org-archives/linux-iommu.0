From: George Wang <xuw2015-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: dma_ops_domain_alloc causes kernel 4.1.0-next-20150626+ panic
Date: Wed, 1 Jul 2015 13:20:59 +0800
Message-ID: <CAPBX1x+OK8EMwDsripY71jF44d73Qv0jBxyM+jJgPMzNVPTyaw@mail.gmail.com>
References: <CAPBX1x+zagVVYebbXU0M7VkEaDkzvqBGnkt6PW_N42fRQRQ9Gg@mail.gmail.com>
	<20150629193402.GM18569@8bytes.org>
	<CAPBX1xLA_GDeoi9wq-9A7njwzL3NBqJYYT_PqhwEzBAg=9=8kA@mail.gmail.com>
	<20150630074454.GO18569@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20150630074454.GO18569-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Tue, Jun 30, 2015 at 3:44 PM, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org> wrote:
> On Tue, Jun 30, 2015 at 11:55:24AM +0800, George Wang wrote:
>> [   11.734774] Call Trace:
>> [   11.735635]  [<ffffffff8168fde1>] __mutex_lock_slowpath+0x91/0x120
>> [   11.737676]  [<ffffffff81318798>] ? ida_simple_get+0x98/0x100
>> [   11.739682]  [<ffffffff8168fe93>] mutex_lock+0x23/0x37
>> [   11.741407]  [<ffffffff8143513a>] amd_iommu_map+0x4a/0x1b0
>> [   11.743293]  [<ffffffff8143081a>] iommu_map+0xfa/0x200
>> [   11.745025]  [<ffffffff81431587>] iommu_group_add_device+0x327/0x390
>> [   11.747184]  [<ffffffff814316fb>] iommu_group_get_forv+0x10b/0x1f0
>> [   11.849564]  [<ffffffff81436ac6>] amd_iommu_add_device+0x1b6/0x580
>
> Ah, your AMD IOMMU system probably has unity mappings defined in its
> ACPI table. I don't have systems with unity mappings defined, so I
> couldn't test this. On what system you are running this test (system or
> mainboard vendor and type)

I am not clear about the unity-mappings, I will do some learning for it.
I run lspic and dmidecode to get some infos about my machine. I am not
sure whether it is useful to you.
If you want to get information, please let me know.

[root@hp-dl385pg8-09 linux-next]# lspci
00:00.0 Host bridge: Advanced Micro Devices, Inc. [AMD/ATI] RD890
Northbridge only dual slot (2x16) PCI-e GFX Hydra part (rev 02)
00:00.2 IOMMU: Advanced Micro Devices, Inc. [AMD/ATI] RD990 I/O Memory
Management Unit (IOMMU)
00:02.0 PCI bridge: Advanced Micro Devices, Inc. [AMD/ATI] RD890 PCI
to PCI bridge (PCI express gpp port B)
00:0a.0 PCI bridge: Advanced Micro Devices, Inc. [AMD/ATI] RD890 PCI
to PCI bridge (external gfx1 port A)
00:0c.0 PCI bridge: Advanced Micro Devices, Inc. [AMD/ATI] RD890S PCI
Express bridge for GPP2 port 1
00:11.0 SATA controller: Advanced Micro Devices, Inc. [AMD/ATI]
SB7x0/SB8x0/SB9x0 SATA Controller [IDE mode]
00:12.0 USB controller: Advanced Micro Devices, Inc. [AMD/ATI]
SB7x0/SB8x0/SB9x0 USB OHCI0 Controller
--snip--

[root@hp-dl385pg8-09 linux-next]# dmidecode|grep -A16 "System Information"
System Information
    Manufacturer: HP
    Product Name: ProLiant DL385p Gen8
    Version: Not Specified
    Serial Number: 6CU428FNLL
    UUID: 32333536-3330-4336-5534-3238464E4C4C
    Wake-up Type: Power Switch
    SKU Number: 653203-B21
    Family: ProLiant

>
> Anyway, here is a patch that should fix this issue for you, can you
> please test it?

Thanks for you work. Apply this patch, and it works good for me.

Thanks,

George
