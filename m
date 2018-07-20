From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 1/5 V5] Add a function(ioremap_encrypted) for kdump when
 AMD sme enabled
Date: Fri, 20 Jul 2018 09:32:45 +0200
Message-ID: <20180720073245.GA26926@nazgul.tnic>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180720052304.GA9146@dhcp-128-65.nay.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dave Young <dyoung@redhat.com>, lijiang <lijiang@redhat.com>
Cc: bhe@redhat.com, linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com, ebiederm@xmission.com, joro@8bytes.org, thomas.lendacky@amd.com, kexec@lists.infradead.org, iommu@lists.linux-foundation.org
List-Id: iommu@lists.linux-foundation.org

On Fri, Jul 20, 2018 at 01:23:04PM +0800, Dave Young wrote:
> > Here, it doesn't need to dump MMIO space of the previous kernel, when the
> > kdump kernel boot, the MMIO address will be remapped in decryption manners,
> > but the MMIO address don't belong to the range of the crash reserved memory,
> > for the kdump kernel, the MMIO space(address) and IOMMU device table(address)
> > are outside address, whereas, the IOMMU device table is encrypted in the first
> > kernel, the kdump kernel will need to copy the content of IOMMU device table
> > from the first kernel when the kdump kernel boot, so the IOMMU device table will
> > be remapped in encryption manners.

-ENOFCKINGPARSE

I believe you're the only one who understands that humongous sentence.
How about using a fullstop from time to time. And WTF is "encryption
manners"?

> > So some of them require to be remapped in encryption manners, and some(address)
> > require to be remapped in decryption manners.

> There could be some misunderstanding here.

Hell yeah there's a misunderstanding!

Can you folks first relax, sit down and explain the whole problem in
*plain* English using *simple* sentences. *Not* like the unparseable
mess above. Use simple, declaratory sentences and don't even try to
sound fancy:

"The first kernel boots. It's memory is encrypted... Now, the second
kernel boots. It must do A because of B. In order to do A, it needs to
do C. Because D..."

And so on. Explain what the problem is first. Then explain the proposed
solution. Explain *why* it needs to be done this way.

When you've written your explanation, try to read it as someone who
doesn't know kdump and *think* hard whether your explanation makes
sense. If it doesn't, fix it and read it again. Rinse and repeat. Until
it is clear to unenlightened readers too.

It is about time this hurried throwing of half-baked patches at
maintainers and seeing what sticks, stops!

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
