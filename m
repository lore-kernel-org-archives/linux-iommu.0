Return-Path: <SRS0=xQF/=WQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6254CC3A589
	for <iommu@archiver.kernel.org>; Tue, 20 Aug 2019 21:32:52 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2C4A206DD
	for <iommu@archiver.kernel.org>; Tue, 20 Aug 2019 21:32:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2C4A206DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id C2030D73;
	Tue, 20 Aug 2019 21:32:51 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 02CBBD13
	for <iommu@lists.linux-foundation.org>;
	Tue, 20 Aug 2019 21:27:59 +0000 (UTC)
X-Greylist: delayed 00:06:32 by SQLgrey-1.7.6
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 0338D12E
	for <iommu@lists.linux-foundation.org>;
	Tue, 20 Aug 2019 21:27:58 +0000 (UTC)
Received: from [141.14.220.194] (unknown [141.14.220.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested) (Authenticated sender: buczek)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 084AA201A3C3E;
	Tue, 20 Aug 2019 23:21:24 +0200 (CEST)
From: Donald Buczek <buczek@molgen.mpg.de>
Subject: /proc/vmcore and wrong PAGE_OFFSET
To: iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org,
	x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
	Paul Menzel <pmenzel@molgen.mpg.de>
Message-ID: <c42060b0-12ae-d170-9ad4-03d85919948c@molgen.mpg.de>
Date: Tue, 20 Aug 2019 23:21:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.8.0
MIME-Version: 1.0
Content-Language: en-US
X-Mailman-Approved-At: Tue, 20 Aug 2019 21:32:51 +0000
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

Dear Linux folks,

I'm investigating a problem, that the crash utility fails to work with our crash dumps:

     buczek@kreios:/mnt$ crash vmlinux crash.vmcore
     
     crash 7.2.6
     Copyright (C) 2002-2019  Red Hat, Inc.
     Copyright (C) 2004, 2005, 2006, 2010  IBM Corporation
     Copyright (C) 1999-2006  Hewlett-Packard Co
     Copyright (C) 2005, 2006, 2011, 2012  Fujitsu Limited
     Copyright (C) 2006, 2007  VA Linux Systems Japan K.K.
     Copyright (C) 2005, 2011  NEC Corporation
     Copyright (C) 1999, 2002, 2007  Silicon Graphics, Inc.
     Copyright (C) 1999, 2000, 2001, 2002  Mission Critical Linux, Inc.
     This program is free software, covered by the GNU General Public License,
     and you are welcome to change it and/or distribute copies of it under
     certain conditions.  Enter "help copying" to see the conditions.
     This program has absolutely no warranty.  Enter "help warranty" for details.
      
     GNU gdb (GDB) 7.6
     Copyright (C) 2013 Free Software Foundation, Inc.
     License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
     This is free software: you are free to change and redistribute it.
     There is NO WARRANTY, to the extent permitted by law.  Type "show copying"
     and "show warranty" for details.
     This GDB was configured as "x86_64-unknown-linux-gnu"...
     
     crash: read error: kernel virtual address: ffff89807ff77000  type: "memory section root table"

The crash file is a copy of /dev/vmcore taken by a crashkernel after a sysctl-forced panic.

It looks to me, that  0xffff89807ff77000 is not readable, because the virtual addresses stored in the elf header of the dump file are off by 0x0000008000000000:

     buczek@kreios:/mnt$ readelf -a crash.vmcore | grep LOAD | perl -lane 'printf "%s (%016x)\n",$_,hex($F[2])-hex($F[3])'
       LOAD           0x000000000000d000 0xffffffff81000000 0x000001007d000000 (fffffeff04000000)
       LOAD           0x0000000001c33000 0xffff880000001000 0x0000000000001000 (ffff880000000000)
       LOAD           0x0000000001cc1000 0xffff880000090000 0x0000000000090000 (ffff880000000000)
       LOAD           0x0000000001cd1000 0xffff880000100000 0x0000000000100000 (ffff880000000000)
       LOAD           0x0000000001cd2070 0xffff880000100070 0x0000000000100070 (ffff880000000000)
       LOAD           0x0000000019bd2000 0xffff880038000000 0x0000000038000000 (ffff880000000000)
       LOAD           0x000000004e6a1000 0xffff88006ffff000 0x000000006ffff000 (ffff880000000000)
       LOAD           0x000000004e6a2000 0xffff880100000000 0x0000000100000000 (ffff880000000000)
       LOAD           0x0000001fcda22000 0xffff882080000000 0x0000002080000000 (ffff880000000000)
       LOAD           0x0000003fcd9a2000 0xffff884080000000 0x0000004080000000 (ffff880000000000)
       LOAD           0x0000005fcd922000 0xffff886080000000 0x0000006080000000 (ffff880000000000)
       LOAD           0x0000007fcd8a2000 0xffff888080000000 0x0000008080000000 (ffff880000000000)
       LOAD           0x0000009fcd822000 0xffff88a080000000 0x000000a080000000 (ffff880000000000)
       LOAD           0x000000bfcd7a2000 0xffff88c080000000 0x000000c080000000 (ffff880000000000)
       LOAD           0x000000dfcd722000 0xffff88e080000000 0x000000e080000000 (ffff880000000000)
       LOAD           0x000000fc4d722000 0xffff88fe00000000 0x000000fe00000000 (ffff880000000000)

(Columns are File offset, Virtual Address, Physical Address and computed offset).

I would expect the offset between the virtual and the physical address to be PAGE_OFFSET, which is 0xffff88800000000 on x86_64, not 0xffff880000000000. Unlike /proc/vmcore, /proc/kcore shows the same physical memory (of the last memory section above) with a correct offset:

     buczek@kreios:/mnt$ sudo readelf -a /proc/kcore | grep 0x000000fe00000000 | perl -lane 'printf "%s (%016x)\n",$_,hex($F[2])-hex($F[3])'
       LOAD           0x0000097e00004000 0xffff897e00000000 0x000000fe00000000 (ffff888000000000)

The failing address 0xffff89807ff77000 happens to be at the end of the last memory section. It is the mem_section array, which crash wants to load and which is visible in the running system:

     buczek@kreios:/mnt$ sudo gdb vmlinux /proc/kcore
     [...]
     (gdb) print mem_section
     $1 = (struct mem_section **) 0xffff89807ff77000
     (gdb) print *mem_section
     $2 = (struct mem_section *) 0xffff88a07f37b000
     (gdb) print **mem_section
     $3 = {section_mem_map = 18446719884453740551, pageblock_flags = 0xffff88a07f36f040}

I can read the same information from the crash dump, if I account for the 0x0000008000000000 error:

     buczek@kreios:/mnt$ gdb vmlinux crash.vmcore
     [...]
     (gdb) print mem_section
     $1 = (struct mem_section **) 0xffff89807ff77000
     (gdb) print *mem_section
     Cannot access memory at address 0xffff89807ff77000
     (gdb) set $t=(struct mem_section **) ((char *)mem_section - 0x0000008000000000)
     (gdb) print *$t
     $2 = (struct mem_section *) 0xffff88a07f37b000
     (gdb) set $s=(struct mem_section *)((char *)*$t - 0x0000008000000000 )
     (gdb) print *$s
     $3 = {section_mem_map = 18446719884453740551, pageblock_flags = 0xffff88a07f36f040}

In the above example, the running kernel, the crashed kernel and the crashkernel are all the same 4.19.57 compilation. But I've tried with several other versions ( crashkernel 4.4, running kernel from 4.0 to linux master) with the same result.

The machine in the above example has several numa nodes (this is why there are so many LOAD headers). But I've tried this with a small kvm virtual machine and got the same result.

     buczek@kreios:/mnt/linux-4.19.57-286.x86_64/build$ grep RANDOMIZE_BASE .config
     # CONFIG_RANDOMIZE_BASE is not set
     buczek@kreios:/mnt/linux-4.19.57-286.x86_64/build$ grep SPARSEMEM .config
     CONFIG_ARCH_SPARSEMEM_ENABLE=y
     CONFIG_ARCH_SPARSEMEM_DEFAULT=y
     CONFIG_SPARSEMEM_MANUAL=y
     CONFIG_SPARSEMEM=y
     CONFIG_SPARSEMEM_EXTREME=y
     CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y
     CONFIG_SPARSEMEM_VMEMMAP=y
     buczek@kreios:/mnt/linux-4.19.57-286.x86_64/build$ grep PAGE_TABLE_ISOLATION .config
     CONFIG_PAGE_TABLE_ISOLATION=y

Any ideas?

Donald
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
