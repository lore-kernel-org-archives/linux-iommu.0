From: lijiang <lijiang@redhat.com>
Subject: Re: [PATCH 1/5 V5] Add a function(ioremap_encrypted) for kdump when
 AMD sme enabled
Date: Thu, 16 Aug 2018 13:35:28 +0800
Message-ID: <53536964-2b57-4630-de91-3d4da2b643a8@redhat.com>
References: <4ae1cfb5-0a4b-2aac-2575-024e2c74826f@redhat.com>
 <895db996-febd-d50c-91af-4f1ef3d27bd8@redhat.com>
 <20180703111428.GB5748@zn.tnic>
 <4fbb843b-9597-a48b-8b6f-00e354b91950@redhat.com>
 <e7357038-08bd-7ba8-5357-7c91d21d10fe@redhat.com>
 <20180709092901.GA22182@nazgul.tnic>
 <fc6a47ca-1b16-eba5-d15e-ca294e01af93@redhat.com>
 <20180713170857.GB17896@nazgul.tnic>
 <33453712-9b0b-e8b9-08a6-de09e0806dd6@redhat.com>
 <20180720052304.GA9146@dhcp-128-65.nay.redhat.com>
 <20180720073245.GA26926@nazgul.tnic>
 <562d8611-750d-3624-1a1b-df21f39812d6@redhat.com>
 <54D39850-F883-4EC6-B160-0CD88D47A997@alien8.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <54D39850-F883-4EC6-B160-0CD88D47A997@alien8.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Boris Petkov <bp@alien8.de>
Cc: Dave Young <dyoung@redhat.com>, bhe@redhat.com, linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com, ebiederm@xmission.com, joro@8bytes.org, thomas.lendacky@amd.com, kexec@lists.infradead.org, iommu@lists.linux-foundation.org
List-Id: iommu@lists.linux-foundation.org

在 2018年07月20日 18:08, Boris Petkov 写道:
> On July 20, 2018 12:55:04 PM GMT+03:00, lijiang <lijiang@redhat.com> wrote:>
>> Thanks for your advice, I will rewrite the log and send them again.
> 
> Do not send them again - explain the problem properly first!
> 
I have compared two solutions to handle the encrypted memory, the solution A is mine, the solution B is Boris's.
Here we only talk about the case that SME is active in the first kernel, and only care it's active too in kdump
kernel. For solution A and solution B, these four cases are same.
a. dump vmcore
   It is encrypted in the first kernel, and needs be read out in kdump kernel.
b. crash notes
   When dumping vmcore, the people usually need to read the useful information from notes, and the notes
   is also encrypted.
c. iommu device table
   It is allocated by kernel, need fill its pointer into mmio of amd iommu. It's encrypted in the first kernel,
   need read the old content to analyze and get useful information.
d. mmio of amd iommu
   Register reported by amd firmware, it's not RAM, we don't encrypt in both the first kernel and kdump kernel.

Solution A:
   1. add a new bool parameter "encrypted" to __ioremap_caller()
      It is a low level function, and check the newly added parameter, if it's true and in kdump kernel, will
      remap the memory with sme mask.
   2. add a new function ioremap_encrypted() to explicitly passed in a "true" value for "encrypted". For above
      a, b, c, we will call ioremap_encrypted();
   3. adjust all existed ioremap wrapper functions, passed in "false" for encrypted to make them an before.

      ioremap_encrypted()\
      ioremap_cache()     |
      ioremap_prot()      |
      ioremap_wt()        |->__ioremap_caller()
      ioremap_wc()        |
      ioremap_uc()        |
      ioremap_nocache()  /    

Solution B(Boris suggested):
   1. no need to add a new function(ioremap_encrypted), check whether the old memory is encrypted by comparing the address.
   2. add new functions to check whether the old memory is encrypted for all cases.
      a. dump vmcore
         bool addr_is_old_memory(unsignd long addr)
      b. crash notes
         bool addr_is_crash_notes(unsigned long addr)
      c. iommu device table
         bool addr_is_iommu_device_table(unsigned long addr)
   3. when remapping the memory, it will call all new functions, and check whether the memory is encrypted in __ioremap_caller().
      __ioremap_caller()->__ioremap_compute_prot()-> /-> addr_is_crash_notes()
                                                     |-> addr_is_iommu_device_table()
                                                     |-> addr_is_old_memory()
                                                     \ ......
   For solution B, i made draft patch for demonstration, just pasted them at bottom.


Conclusion:

  Solution A:
      advantages:
                  1). It's very simple and very clean, less code change;
                  2). It's easier to understand.
      disadvantages:
                  1). Need change the interface of __ioremap_caller() and adjust its wrapper functions;
                  2). Need call ioremap_encrypted() explicitly for vmcore/crash notes/dev table reading.

  Solution B:
      advantages:
                 1). No need to touch interface;
                 2). Automatically detect and do inside __ioremap_caller().
      disadvantages:
                 1). Need add each function for each kind of encrypted old memory reading;
                 2). In the future, need add these kinds of functions too for intel MKTME;
                 3). It's more complicated and more code changes.

I personally prefer solution A, which is presented in posted patches.
What do you think, Boris? And other reviewers?

Thanks,
Lianbo




The solution B will be described by pseudo-code, for example:

   modified file: drivers/iommu/amd_iommu_init.c
   inline bool addr_is_iommu_device_table(unsigned long addr) {
        struct amd_iommu *iommu;

        /* search the addr */
        for_each_iommu(iommu) {
            lo = readl(iommu->mmio_base + MMIO_DEV_TABLE_OFFSET);
            hi = readl(iommu->mmio_base + MMIO_DEV_TABLE_OFFSET + 4);
            entry = (((u64) hi) << 32) + lo;
            /* check whether it is an iommu device table address */
            if (addr == entry) {
                return true;
            }
        }
        return false;
   }

   modified file: fs/proc/vmcore.c
   inline bool addr_is_crash_notes(unsigned long addr) {
       Elf64_Ehdr ehdr;
       
       /* code */

       rc = elfcorehdr_read((char*)&ehdr, sizeof(ELF64_Ehdr), &elfcorehdr_addr);
       elfcorebuf_sz_orig = sizeof(Elf64_Ehdr) + ehdr.e_phnum*sizeof(Elf64_Phdr);
       rc = elfcorehdr_read(elfcorebuf, elfcorebuf_sz_orig, &elfcorehdr_addr);
       ehdr_ptr = (Elf64_Ehdr*)(elfcorebuf + 1);

       /* search the addr */
       for (i = 0; i < ehdr_ptr->e_phnum; i++, phdr_ptr++) {
           offset = phdr_ptr->p_offset;
           /* if found it, break the loop */
           if (offset == addr)
               return true;
       }
       return false;
   }

   modified file: fs/proc/vmcore.c
   inline bool addr_is_old_memory(unsignd long addr) {
      struct vmcore *m;

      /* code */

      /*search the addr*/
      list_for_each_entry(m, &vmcore_list, list) {
          /* code */
          
          sz = min_t(unsigned long long, m->offset + m->size - *pos, size);
          start = m->paddr + *pos - m->offset;
          
          do {
             /* if found it, break the loop */ 
             if (addr == start)
                  return true;

              offset = (unsigned long)(*start % PAGE_SIZE);
              bytes = PAGE_SIZE - offset;
              start += bytes;
              sz -= bytes;

              /* code */

          } while (sz);
      }
      return false;
   }

   modified file: arch/x86/mm/ioremap.c
   static void __ioremap_compute_prot(resource_size_t addr, unsigned long size,
                                   pgprot_t *prot)
   {
        bool encrypted_prot = false;

        /* code */

        if (!is_kdump_kernel())
            return;

        if (addr_is_iommu_device_table(addr))
            encrypted_prot = true;

        if (addr_is_crash_notes(addr))
            encrypted_prot = true;

        if (addr_is_old_memory(addr))
            encrypted_prot = true;

        /* code */
        
        *prot = encrypted_prot ? pgprot_encrypted(*prot)
                               : pgprot_decrypted(*prot);
   }

   modified file: arch/x86/mm/ioremap.c
   static void __iomem *__ioremap_caller(resource_size_t phys_addr,
                unsigned long size, enum page_cache_mode pcm, void *caller)
   {
        /* code */

         prot = PAGE_KERNEL_IO;
         if (sev_active() && mem_flags.desc_other)
                prot = pgprot_encrypted(prot);
       
        /* check whether the memory is encrypted */  
        __ioremap_compute_prot(phys_addr, size, &prot);

        switch (pcm) {
        case _PAGE_CACHE_MODE_UC:
        default:

        /* code */
   }
