From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 00/10] vt-d irq_remap_ops patchset
Date: Sat, 31 Mar 2012 10:14:07 +0200
Message-ID: <20120331081407.GC15958@gmail.com>
References: <1333133228-3134-1-git-send-email-suresh.b.siddha@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1333133228-3134-1-git-send-email-suresh.b.siddha@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Suresh Siddha <suresh.b.siddha@intel.com>
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, Joerg Roedel <joerg.roedel@amd.com>, David Woodhouse <dwmw2@infradead.org>, Alex Williamson <alex.williamson@redhat.com>, Yinghai Lu <yinghai@kernel.org>
List-Id: iommu@lists.linux-foundation.org


* Suresh Siddha <suresh.b.siddha@intel.com> wrote:

> Ingo,
> 
> Here is the Joerg's irq_remap_ops patchset updated for the latest -tip.
> Simplified some of the naming conventions to follow the irq_remapping
> terminology. There are still some "if (irq_remapping_enabled)" checks in
> io_apic.c that I would like to roll into the new io_apic_ops. I will
> look into that shortly.

Just wondering, has this been tested on affected hardware, on 
top of latest -tip or so? I realize that most of these are 
clean-ups so they should not break anything, but checking would 
be worth it nevertheless.

Thanks,

	Ingo
