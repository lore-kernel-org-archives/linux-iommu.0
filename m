From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 1/5 V5] Add a function(ioremap_encrypted) for kdump when
 AMD sme enabled
Date: Thu, 23 Aug 2018 17:21:02 +0200
Message-ID: <20180823152102.GF21323@nazgul.tnic>
References: <e7357038-08bd-7ba8-5357-7c91d21d10fe@redhat.com>
 <20180709092901.GA22182@nazgul.tnic>
 <fc6a47ca-1b16-eba5-d15e-ca294e01af93@redhat.com>
 <20180713170857.GB17896@nazgul.tnic>
 <33453712-9b0b-e8b9-08a6-de09e0806dd6@redhat.com>
 <20180720052304.GA9146@dhcp-128-65.nay.redhat.com>
 <20180720073245.GA26926@nazgul.tnic>
 <562d8611-750d-3624-1a1b-df21f39812d6@redhat.com>
 <54D39850-F883-4EC6-B160-0CD88D47A997@alien8.de>
 <53536964-2b57-4630-de91-3d4da2b643a8@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <53536964-2b57-4630-de91-3d4da2b643a8@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: lijiang <lijiang@redhat.com>
Cc: Dave Young <dyoung@redhat.com>, bhe@redhat.com, linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com, ebiederm@xmission.com, joro@8bytes.org, thomas.lendacky@amd.com, kexec@lists.infradead.org, iommu@lists.linux-foundation.org
List-Id: iommu@lists.linux-foundation.org

On Thu, Aug 16, 2018 at 01:35:28PM +0800, lijiang wrote:
> I personally prefer solution A, which is presented in posted patches.
> What do you think, Boris? And other reviewers?

Ok, thanks for taking the time and effort in explaning this in detail.

Solution B really turns out to be too complex after all. So as long as
that @encrypted argument does not need to propagate any further than a
couple of helpers - as it does now - I guess we can do solution A.

BUT! Wait until next week before sending your patches again because the
merge window isn't over yet.

Thx.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
