From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCHv2 4/6] iommu/intel: Handle DMAR faults on workqueue
Date: Tue, 13 Feb 2018 17:35:42 +0100
Message-ID: <20180213163542.tdqhazwfjgqk3zuu@8bytes.org>
References: <20180212164825.22421-1-dima@arista.com>
 <20180212164825.22421-5-dima@arista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180212164825.22421-5-dima@arista.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Safonov <dima@arista.com>
Cc: linux-kernel@vger.kernel.org, 0x7f454c46@gmail.com, Alex Williamson <alex.williamson@redhat.com>, David Woodhouse <dwmw2@infradead.org>, Ingo Molnar <mingo@kernel.org>, Lu Baolu <baolu.lu@linux.intel.com>, iommu@lists.linux-foundation.org
List-Id: iommu@lists.linux-foundation.org

On Mon, Feb 12, 2018 at 04:48:23PM +0000, Dmitry Safonov wrote:
> dmar_fault() reports/handles/cleans DMAR faults in a cycle one-by-one.
> The nuisance is that it's set as a irq handler and runs with disabled
> interrupts - which works OK if you have only a couple of DMAR faults,
> but becomes a problem if your intel iommu has a plenty of mappings.

I don't think that a work-queue is the right solution here, it adds a
long delay until the log is processed. During that delay, and with high
fault rates the error log will overflow during that delay.

Here is what I think you should do instead to fix the soft-lockups:

First, unmask the fault reporting irq so that you will get subsequent
irqs. Then:

	* For Primary Fault Reporting just cycle once through all
	  supported fault recording registers.

	* For Advanced Fault Reporting, read start and end pointer of
	  the log and process all entries.

After that return from the fault handler and let the next irq handle
additional faults that might have been recorded while the previous
handler was running.

And of course, ratelimiting the fault printouts is always a good idea.


Regards,

	Joerg
