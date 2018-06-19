From: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 4/4 V3] Help to dump the old memory encrypted into vmcore
	file
Date: Tue, 19 Jun 2018 11:16:53 +0800
Message-ID: <20180619031653.GA7101@dhcp-128-65.nay.redhat.com>
References: <20180616082714.32035-1-lijiang@redhat.com>
	<20180616082714.32035-5-lijiang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20180616082714.32035-5-lijiang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Lianbo Jiang <lijiang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: thomas.lendacky-5C7GfCeVMHo@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, kexec-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 06/16/18 at 04:27pm, Lianbo Jiang wrote:
> In kdump mode, we need to dump the old memory into vmcore file,
> if SME is enabled in the first kernel, we must remap the old
> memory in encrypted manner, which will be automatically decrypted
> when we read from DRAM. It helps to parse the vmcore for some tools.
> 
> Signed-off-by: Lianbo Jiang <lijiang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> ---
> Some changes:
> 1. add a new file and modify Makefile.
> 2. remove some code in sev_active().
> 
>  arch/x86/kernel/Makefile             |  1 +
>  arch/x86/kernel/crash_dump_encrypt.c | 53 ++++++++++++++++++++++++++++++++++++
>  fs/proc/vmcore.c                     | 20 ++++++++++----
>  include/linux/crash_dump.h           | 11 ++++++++
>  4 files changed, 79 insertions(+), 6 deletions(-)
>  create mode 100644 arch/x86/kernel/crash_dump_encrypt.c
> 
> diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
> index 02d6f5c..afb5bad 100644
> --- a/arch/x86/kernel/Makefile
> +++ b/arch/x86/kernel/Makefile
> @@ -96,6 +96,7 @@ obj-$(CONFIG_KEXEC_CORE)	+= machine_kexec_$(BITS).o
>  obj-$(CONFIG_KEXEC_CORE)	+= relocate_kernel_$(BITS).o crash.o
>  obj-$(CONFIG_KEXEC_FILE)	+= kexec-bzimage64.o
>  obj-$(CONFIG_CRASH_DUMP)	+= crash_dump_$(BITS).o
> +obj-$(CONFIG_AMD_MEM_ENCRYPT)	+= crash_dump_encrypt.o
>  obj-y				+= kprobes/
>  obj-$(CONFIG_MODULES)		+= module.o
>  obj-$(CONFIG_DOUBLEFAULT)	+= doublefault.o
> diff --git a/arch/x86/kernel/crash_dump_encrypt.c b/arch/x86/kernel/crash_dump_encrypt.c
> new file mode 100644
> index 0000000..e44ef33
> --- /dev/null
> +++ b/arch/x86/kernel/crash_dump_encrypt.c
> @@ -0,0 +1,53 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + *	Memory preserving reboot related code.
> + *
> + *	Created by: Lianbo Jiang (lijiang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org)
> + *	Copyright (C) RedHat Corporation, 2018. All rights reserved
> + */
> +
> +#include <linux/errno.h>
> +#include <linux/crash_dump.h>
> +#include <linux/uaccess.h>
> +#include <linux/io.h>
> +
> +/**
> + * copy_oldmem_page_encrypted - copy one page from "oldmem encrypted"
> + * @pfn: page frame number to be copied
> + * @buf: target memory address for the copy; this can be in kernel address
> + *	space or user address space (see @userbuf)
> + * @csize: number of bytes to copy
> + * @offset: offset in bytes into the page (based on pfn) to begin the copy
> + * @userbuf: if set, @buf is in user address space, use copy_to_user(),
> + *	otherwise @buf is in kernel address space, use memcpy().
> + *
> + * Copy a page from "oldmem encrypted". For this page, there is no pte
> + * mapped in the current kernel. We stitch up a pte, similar to
> + * kmap_atomic.
> + */
> +
> +ssize_t copy_oldmem_page_encrypted(unsigned long pfn, char *buf,
> +		size_t csize, unsigned long offset, int userbuf)
> +{
> +	void  *vaddr;
> +
> +	if (!csize)
> +		return 0;
> +
> +	vaddr = (__force void *)ioremap_encrypted(pfn << PAGE_SHIFT,
> +						  PAGE_SIZE);
> +	if (!vaddr)
> +		return -ENOMEM;
> +
> +	if (userbuf) {
> +		if (copy_to_user((void __user *)buf, vaddr + offset, csize)) {
> +			iounmap((void __iomem *)vaddr);
> +			return -EFAULT;
> +		}
> +	} else
> +		memcpy(buf, vaddr + offset, csize);
> +
> +	set_iounmap_nonlazy();
> +	iounmap((void __iomem *)vaddr);
> +	return csize;
> +}
> diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
> index a45f0af..5200266 100644
> --- a/fs/proc/vmcore.c
> +++ b/fs/proc/vmcore.c
> @@ -25,6 +25,8 @@
>  #include <linux/uaccess.h>
>  #include <asm/io.h>
>  #include "internal.h"
> +#include <linux/mem_encrypt.h>
> +#include <asm/pgtable.h>
>  
>  /* List representing chunks of contiguous memory areas and their offsets in
>   * vmcore file.
> @@ -86,7 +88,8 @@ static int pfn_is_ram(unsigned long pfn)
>  
>  /* Reads a page from the oldmem device from given offset. */
>  static ssize_t read_from_oldmem(char *buf, size_t count,
> -				u64 *ppos, int userbuf)
> +				u64 *ppos, int userbuf,
> +				bool encrypted)
>  {
>  	unsigned long pfn, offset;
>  	size_t nr_bytes;
> @@ -108,8 +111,11 @@ static ssize_t read_from_oldmem(char *buf, size_t count,
>  		if (pfn_is_ram(pfn) == 0)
>  			memset(buf, 0, nr_bytes);
>  		else {
> -			tmp = copy_oldmem_page(pfn, buf, nr_bytes,
> -						offset, userbuf);
> +			tmp = encrypted ? copy_oldmem_page_encrypted(pfn,
> +					    buf, nr_bytes, offset, userbuf)
> +					: copy_oldmem_page(pfn, buf, nr_bytes,
> +							   offset, userbuf);
> +
>  			if (tmp < 0)
>  				return tmp;
>  		}
> @@ -143,7 +149,7 @@ void __weak elfcorehdr_free(unsigned long long addr)
>   */
>  ssize_t __weak elfcorehdr_read(char *buf, size_t count, u64 *ppos)
>  {
> -	return read_from_oldmem(buf, count, ppos, 0);
> +	return read_from_oldmem(buf, count, ppos, 0, false);

The elf header actually stays in kdump kernel reserved memory so it is
not "oldmem", the original function is misleading and doing unnecessary
things.  But as for your patch maybe using it as is is good for the time
being and add a code comment why the encrypted is "false".

	/* elfcorehdr stays in kdump kernel memory and it is not encrypted. */
	return read_from_oldmem(buf, count, ppos, 0, false);


I'm thinking to move the function to something like below, still not sure
memremap works on every arches or not, still need more test

diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index cfb6674331fd..40c01cc42b38 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -136,6 +136,24 @@ static ssize_t read_from_oldmem(char *buf, size_t count,
 	return read;
 }
 
+static ssize_t read_from_mem(char *buf, size_t count, u64 *ppos)
+{
+	resource_size_t offset = (resource_size_t)*ppos;
+	char *kbuf;
+
+	if (!count)
+		return 0;
+
+	kbuf = memremap(offset, count, MEMREMAP_WB);
+	if (!kbuf)
+		return 0;
+
+	memcpy(buf, kbuf, count);
+	memunmap(kbuf);
+
+	return count;
+}
+
 /*
  * Architectures may override this function to allocate ELF header in 2nd kernel
  */
@@ -155,7 +173,7 @@ void __weak elfcorehdr_free(unsigned long long addr)
  */
 ssize_t __weak elfcorehdr_read(char *buf, size_t count, u64 *ppos)
 {
-	return read_from_oldmem(buf, count, ppos, 0);
+	return read_from_mem(buf, count, ppos);
 }
 
 /*
 

>  }
>  
>  /*
> @@ -151,7 +157,7 @@ ssize_t __weak elfcorehdr_read(char *buf, size_t count, u64 *ppos)
>   */
>  ssize_t __weak elfcorehdr_read_notes(char *buf, size_t count, u64 *ppos)
>  {
> -	return read_from_oldmem(buf, count, ppos, 0);
> +	return read_from_oldmem(buf, count, ppos, 0, sme_active());
>  }
>  
>  /*
> @@ -161,6 +167,7 @@ int __weak remap_oldmem_pfn_range(struct vm_area_struct *vma,
>  				  unsigned long from, unsigned long pfn,
>  				  unsigned long size, pgprot_t prot)
>  {
> +	prot = pgprot_encrypted(prot);
>  	return remap_pfn_range(vma, from, pfn, size, prot);
>  }
>  
> @@ -235,7 +242,8 @@ static ssize_t __read_vmcore(char *buffer, size_t buflen, loff_t *fpos,
>  					    m->offset + m->size - *fpos,
>  					    buflen);
>  			start = m->paddr + *fpos - m->offset;
> -			tmp = read_from_oldmem(buffer, tsz, &start, userbuf);
> +			tmp = read_from_oldmem(buffer, tsz, &start, userbuf,
> +						sme_active());
>  			if (tmp < 0)
>  				return tmp;
>  			buflen -= tsz;
> diff --git a/include/linux/crash_dump.h b/include/linux/crash_dump.h
> index f7ac2aa..f3414ff 100644
> --- a/include/linux/crash_dump.h
> +++ b/include/linux/crash_dump.h
> @@ -25,6 +25,17 @@ extern int remap_oldmem_pfn_range(struct vm_area_struct *vma,
>  
>  extern ssize_t copy_oldmem_page(unsigned long, char *, size_t,
>  						unsigned long, int);
> +#ifdef CONFIG_AMD_MEM_ENCRYPT
> +extern ssize_t copy_oldmem_page_encrypted(unsigned long pfn, char *buf,
> +					   size_t csize, unsigned long offset,
> +					   int userbuf);
> +#else
> +static inline ssize_t copy_oldmem_page_encrypted(unsigned long pfn, char *buf,
> +					size_t csize, unsigned long offset,
> +					int userbuf) {

Personally I prefer below because it is too long:

static inline
ssize_t copy_oldmem_page_encrypted(unsigned long pfn, char *buf, size_t csize,
				   unsigned long offset, int userbuf)
{
	return 0;
}
			

> +	return csize;

As above it should be return 0;

> +}
> +#endif
>  void vmcore_cleanup(void);
>  
>  /* Architecture code defines this if there are other possible ELF
> -- 
> 2.9.5
> 
> 
> _______________________________________________
> kexec mailing list
> kexec-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
> http://lists.infradead.org/mailman/listinfo/kexec

Thanks
Dave
