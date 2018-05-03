From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCHv4 1/2] iommu/vt-d: Ratelimit each dmar fault printing
Date: Thu, 3 May 2018 14:40:10 +0200
Message-ID: <20180503124010.n73opdv2k7qrpfoo@8bytes.org>
References: <20180331003312.6390-1-dima@arista.com>
 <1525227744.14025.6.camel@arista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1525227744.14025.6.camel@arista.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Safonov <dima@arista.com>
Cc: linux-kernel@vger.kernel.org, 0x7f454c46@gmail.com, Alex Williamson <alex.williamson@redhat.com>, David Woodhouse <dwmw2@infradead.org>, Ingo Molnar <mingo@kernel.org>, Lu Baolu <baolu.lu@linux.intel.com>, iommu@lists.linux-foundation.org
List-Id: iommu@lists.linux-foundation.org

On Wed, May 02, 2018 at 03:22:24AM +0100, Dmitry Safonov wrote:
> Hi Joerg,
> 
> is there anything I may do about those two patches?
> In 2/2 I've limited loop cnt as discussed in v3.
> This one solves softlockup for us, might be useful.

Applied the first patch, thanks. Please re-work the second one according
to the comments.


Thanks,

	Joerg
