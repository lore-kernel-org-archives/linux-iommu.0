From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 1/5 V5] Add a function(ioremap_encrypted) for kdump when
 AMD sme enabled
Date: Tue, 3 Jul 2018 13:14:28 +0200
Message-ID: <20180703111428.GB5748@zn.tnic>
References: <20180702072639.10110-1-lijiang@redhat.com>
 <20180702072639.10110-2-lijiang@redhat.com>
 <20180702101451.GB28730@zn.tnic>
 <4ae1cfb5-0a4b-2aac-2575-024e2c74826f@redhat.com>
 <895db996-febd-d50c-91af-4f1ef3d27bd8@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <895db996-febd-d50c-91af-4f1ef3d27bd8@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: lijiang <lijiang@redhat.com>
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com, ebiederm@xmission.com, joro@8bytes.org, thomas.lendacky@amd.com, dyoung@redhat.com, kexec@lists.infradead.org, iommu@lists.linux-foundation.org, bhe@redhat.com
List-Id: iommu@lists.linux-foundation.org

On Tue, Jul 03, 2018 at 06:58:14PM +0800, lijiang wrote:
> For kdump, the elf header finally use the crash kernel reserved memory, it is not an old memory.

Lamme repeat my suggestion:

So beef up the logic in __ioremap_caller() to figure out based on the
address whether to access the memory encrypted or not. In general, you
can deduce, based on the region you're mapping, whether you need to map
in encrypted or decrypted.

For example:

        addr = elfcorehdr_addr;

        /* Read Elf header */
        rc = elfcorehdr_read((char *)&ehdr, sizeof(Elf64_Ehdr), &addr);
        if (rc < 0)
                return rc;

elfcorehdr_addr has that elfcorehdr address. So you can check which address
you're mapping and do:

__ioremap_caller:

...
	prot = __ioremap_compute_prot(...);

and that __ioremap_compute_prot() function which you will add will have
all that logic to determine encrypted or not by comparing addresses etc.

Does that make more sense?

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
