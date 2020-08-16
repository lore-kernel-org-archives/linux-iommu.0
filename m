Return-Path: <SRS0=Ai5c=B2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55A04C433E1
	for <iommu@archiver.kernel.org>; Sun, 16 Aug 2020 19:23:55 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE3072067C
	for <iommu@archiver.kernel.org>; Sun, 16 Aug 2020 19:23:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=yawk.at header.i=@yawk.at header.b="CTaZN98o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE3072067C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=yawk.at
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id B171E87D53;
	Sun, 16 Aug 2020 19:23:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ky67Xw10Cf7W; Sun, 16 Aug 2020 19:23:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 6B14687D45;
	Sun, 16 Aug 2020 19:23:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5336CC07FF;
	Sun, 16 Aug 2020 19:23:53 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D1B69C0051
 for <iommu@lists.linux-foundation.org>; Sun, 16 Aug 2020 19:23:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id CEA798523B
 for <iommu@lists.linux-foundation.org>; Sun, 16 Aug 2020 19:23:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yyYwCF7gfTBi for <iommu@lists.linux-foundation.org>;
 Sun, 16 Aug 2020 19:23:48 +0000 (UTC)
X-Greylist: delayed 00:06:07 by SQLgrey-1.7.6
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de
 [81.169.146.160])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 43E038525D
 for <iommu@lists.linux-foundation.org>; Sun, 16 Aug 2020 19:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1597605826;
 s=strato-dkim-0002; d=yawk.at;
 h=Date:Message-ID:To:Subject:From:X-RZG-CLASS-ID:X-RZG-AUTH:From:
 Subject:Sender;
 bh=3CdT6L4EznZTTequ5C5/Hf6rvlx3I1zmc+7d9xPwcXw=;
 b=CTaZN98or6n6NnKenCfJazPZT4PhqvJ3a4z1ZfNFjXHgiPqR9QmRfCyDPCvKoEOcPq
 TkmmE4xZP0G1DyecCU6Sbf52eEasYNgDP6DZwwBeAQlNAIIqvtCKwoWqLburPBjcivPv
 zoSgqTVSSkKAWlj0wk7bknvaDGeiD9GMv7YpohPzlLf+ZCPyrwAbDyKRSztlyJmrD/2C
 Rky05Z1mhCfg4Hh93LTBCCFWjU0uBLzBMHLIv6QLz52l1p5hww3E5hwlFU89RyhJ1IDC
 ejmhUi8WivnBEXNPDn70Hwh2DYtiMeXXs12ZF3rYSeLJi0X+k0pMqJkDEpUzF+h+ULZc
 fcgQ==
X-RZG-AUTH: ":IWkkbEG/cLHwlIKW3zNbwqm86mlYSO5Y9qOoDWTXRGYAbfOm2GyptNbqSeQ="
X-RZG-CLASS-ID: mo00
Received: from [192.168.1.18] by smtp.strato.de (RZmta 46.10.5 AUTH)
 with ESMTPSA id z064b9w7GJHdtAI
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
 (Client did not present a certificate)
 for <iommu@lists.linux-foundation.org>;
 Sun, 16 Aug 2020 21:17:39 +0200 (CEST)
From: Jonas Konrad <me@yawk.at>
Subject: VT-d large page quirk on Haswell
To: iommu@lists.linux-foundation.org
Message-ID: <03b47c34-ba4b-e91a-21a9-086dffdf8dce@yawk.at>
Date: Sun, 16 Aug 2020 21:17:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
Content-Language: en-US
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Hi,

I hope this is the right list for this kind of issue, if not please 
point me to the right contact :)

I have a 4790K here and am trying to use the VT-d large page feature. 
This is leading to translation faults and I suspect this is due to the 
CPU wrongly reporting large page support even though it is not actually 
available. (see important note on kernel cmdline below)

To reproduce this issue I wrote a kernel module that allocates one large 
page of DMA memory and then try to access that page. The kernel module 
is as follows:

---
#include <linux/module.h>     /* Needed by all modules */
#include <linux/kernel.h>     /* Needed for KERN_INFO */
#include <linux/init.h>       /* Needed for the macros */
#include <linux/pci.h>
#include <linux/dma-mapping.h>

MODULE_LICENSE("Dual MIT/GPL");

MODULE_AUTHOR("yawkat");

MODULE_DESCRIPTION("Large page test kmod");

MODULE_VERSION("0.1");

static int __init hello_start(void)
{
	printk("hi\n");
	struct pci_dev *dev = pci_get_device(0x10ee, 0x0666, NULL);
	printk("dev %p\n", dev);
	if (dev == NULL) return 1;
	dma_addr_t dma_handle;
	size_t size = 2 * 1024 * 1024;
	u8 *cpu_addr = (u8 *) dma_alloc_coherent(&dev->dev, size, &dma_handle, 
GFP_KERNEL);
	printk("Allocated DMA buffer cpu=%p dma=%llx\n", cpu_addr, dma_handle);
	size_t i;
	for (i = 0; i < size; i++) {
		cpu_addr[i] = (u8) i;
	}
	asm volatile ("wbinvd");
	return 0;
}

module_init(hello_start);
---

After loading this module with insmod I try to access the memory 
reported in `dmesg` as the DMA address using PCILeech. I get the 
following DMA faults:

---
[   14.804104] hi
[   14.804109] dev 0000000057434c75
[   14.804366] Allocated DMA buffer cpu=0000000011604672 dma=ffe00000
[   39.143153] DMAR: DRHD: handling fault status reg 3
[   39.143226] DMAR: [DMA Read] Request device [05:00.0] PASID ffffffff 
fault addr ffe00000 [fault reason 12] non-zero reserved fields in PTE
[   39.169018] DMAR: DRHD: handling fault status reg 3
[   39.169071] DMAR: [DMA Read] Request device [05:00.0] PASID ffffffff 
fault addr ffe00000 [fault reason 12] non-zero reserved fields in PTE
---

To debug this issue further I wrote a small utility that walks the IOMMU 
paging structures:

---
#include <inttypes.h>
#include <stdlib.h>
#include <fcntl.h>
#include <stdio.h>
#include <sys/mman.h>
#include <unistd.h>

typedef unsigned __int128 uint128_t;

const off_t unit = 0xfed91000;
const uint8_t bus = 0x5;
const uint8_t devfn = 0x0;
const off_t req_addr = 0xffe00000;

static int fd;

static void *region(off_t addr) {
     printf("Loading %llx\n", addr);
     void *memory = mmap(NULL, 4096, PROT_READ, MAP_SHARED, fd, addr);
     if (memory == MAP_FAILED) {
         perror("mmap");
         fprintf(stderr, "on: %p\n", addr);
         exit(2);
     }
     return memory;
}

int main() {
     fd = open("/dev/mem", O_RDONLY);
     if (fd == -1) {
         perror("open");
         return 1;
     }
     uint8_t *hardware_unit = region(unit);
     uint64_t *rtaddr = (uint64_t *) (hardware_unit + 0x20);
     printf("rtaddr: %016lx\n", *rtaddr);
     uint128_t *root_table = region(*rtaddr & 0xfffffffffffff000u);
     uint128_t root_entry = root_table[bus];
     printf("root entry: %016lx %016lx\n", (uint64_t) (root_entry >> 
64u), (uint64_t) root_entry);
     uint128_t *context_table = region((uint64_t) (root_entry & 
0xfffffffffffff000u));
     uint128_t context_entry = context_table[devfn];
     printf("context entry: %016lx %016lx\n", (uint64_t) (context_entry 
 >> 64u), (uint64_t) context_entry);

     const char *pt_names[4] = { "pml4", "pdp", "pd", "pt" };

     off_t ptr = (uint64_t) (context_entry & 0xfffffffffffff000u);
     uint8_t shift = 39;
     for (uint8_t level = 0; level < 4; level++) {
         uint64_t *pt = region(ptr);
         uint64_t pte = pt[(req_addr >> shift) % 512];
         printf("%se:\t%016lx\n", pt_names[level], pte);
         ptr = pte & 0xffffffffffff000u;
         if ((pte & 0x80u) != 0) {
             break;
         }
         shift -= 9;
     }
     return 0;
}
---

The output of this tool is:

---
Loading fed91000
rtaddr: 000000021228b000
Loading 21228b000
root entry: 0000000000000000 0000000211e0f001
Loading 211e0f000
context entry: 0000000000000e02 0000000211dee001
Loading 211dee000
pml4e:	00000002128e9003
Loading 2128e9000
pdpe:	0000000212695003
Loading 212695000
pde:	0000000207c00083
---

As you can see the PD entry has bit 0x80 set which is the large page 
bit. This is most likely the bit causing the fault.

The kernel config I am using is the arch linux config ( 
https://github.com/archlinux/svntogit-packages/blob/packages/linux/trunk/config 
) with some slight modifications:

---
10930,10931c10930,10931
< CONFIG_STRICT_DEVMEM=y
< CONFIG_IO_STRICT_DEVMEM=y
---
 > CONFIG_STRICT_DEVMEM=n
 > CONFIG_IO_STRICT_DEVMEM=n
10943a10944
 > CONFIG_IOMMU_DEBUG=y
---

The kernel source is the same as the 5.8.1.arch1 kernel from arch linux 
and should match the 5.8.1 stable.

My cmdline is `nokaslr root=UUID=... rw nopat iomem=relaxed 
intel-iommu=on,igfx_off`. The nopat/relaxed stuff is for the iommu walk 
utility and shouldn't affect the bug, but the igfx_off is important. 
Right now, the kernel intel iommu implementation will pick the greatest 
common denominator of all available IOMMUs when it comes to large page 
support. On the CPU in question, the igfx iommu unit does *not* report 
supporting large pages, but the normal iommu does. When igfx_off is 
passed, the kernel ignores the first unit and thus can enable large 
pages for the other unit.

To be specific, the first 24 bytes of the two units are:

1000000000000000620466200000c0001a10f00000000000 (SLLPS = 0000)
1000000000000000620466208c00d200da10f00000000000 (SLLPS = 0011)

When igfx_off is not passed, the bug does not appear and my iommuwalk 
utility reports a full page table without large pages (I don't have a 
dump of this on hand, but could get one if necessary).

For completeness, here is my cpuid:

---
Architecture:                    x86_64
CPU op-mode(s):                  32-bit, 64-bit
Byte Order:                      Little Endian
Address sizes:                   39 bits physical, 48 bits virtual
CPU(s):                          8
On-line CPU(s) list:             0-7
Thread(s) per core:              2
Core(s) per socket:              4
Socket(s):                       1
NUMA node(s):                    1
Vendor ID:                       GenuineIntel
CPU family:                      6
Model:                           60
Model name:                      Intel(R) Core(TM) i7-4790K CPU @ 4.00GHz
Stepping:                        3
CPU MHz:                         1481.876
CPU max MHz:                     4400.0000
CPU min MHz:                     800.0000
BogoMIPS:                        8003.84
Virtualization:                  VT-x
L1d cache:                       128 KiB
L1i cache:                       128 KiB
L2 cache:                        1 MiB
L3 cache:                        8 MiB
NUMA node0 CPU(s):               0-7
Vulnerability Itlb multihit:     KVM: Mitigation: Split huge pages
Vulnerability L1tf:              Mitigation; PTE Inversion; VMX 
conditional cache flushes, SMT vulnerable
Vulnerability Mds:               Mitigation; Clear CPU buffers; SMT 
vulnerable
Vulnerability Meltdown:          Mitigation; PTI
Vulnerability Spec store bypass: Mitigation; Speculative Store Bypass 
disabled via prctl and seccomp
Vulnerability Spectre v1:        Mitigation; usercopy/swapgs barriers 
and __user pointer sanitization
Vulnerability Spectre v2:        Mitigation; Full generic retpoline, 
IBPB conditional, IBRS_FW, STIBP conditional, RSB filling
Vulnerability Srbds:             Mitigation; Microcode
Vulnerability Tsx async abort:   Not affected
Flags:                           fpu vme de pse tsc msr pae mce cx8 apic 
sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht 
tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts 
rep_good nopl xtopology nonstop_tsc cpuid aperfmperf pni pclmulqdq 
dtes64 monitor ds_cpl vmx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid 
sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c 
rdrand lahf_lm abm cpuid_fault invpcid_single pti ssbd ibrs ibpb stibp 
tpr_shadow vnmi flexpriority ept vpid ept_ad fsgsbase tsc_adjust bmi1 
avx2 smep bmi2 erms invpcid xsaveopt dtherm ida arat pln pts md_clear 
flush_l1d
---

With all this information I am pretty sure that the bug lies in the CPU 
reporting SLLPS 0b0011 when it clearly does not support large pages. My 
proposed solution would be adding a quirk that disables the large page 
support on this CPU (or is this issue too obscure?). Since this is the 
only Haswell CPU I can test on I'm not sure how wide-spread this issue 
is and whether it affects any other CPUs.

Is this a known issue and if so across which products? Could a quirk be 
added?

Thanks,
- Jonas Konrad
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
