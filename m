From: "joro@8bytes.org" <joro@8bytes.org>
Subject: Re: [PATCH 1/6] mmput: use notifier chain to call subsystem exit
 handler.
Date: Mon, 7 Jul 2014 12:11:59 +0200
Message-ID: <20140707101158.GD1958@8bytes.org>
References: <20140630183556.GB3280@gmail.com>
 <20140701091535.GF26537@8bytes.org>
 <019CCE693E457142B37B791721487FD91806DD8B@storexdag01.amd.com>
 <20140701110018.GH26537@8bytes.org>
 <20140701193343.GB3322@gmail.com>
 <20140701210620.GL26537@8bytes.org>
 <20140701213208.GC3322@gmail.com>
 <20140703183024.GA3306@gmail.com>
 <20140703231541.GR26537@8bytes.org>
 <019CCE693E457142B37B791721487FD918085329@storexdag01.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-mm@kvack.org>
Content-Disposition: inline
In-Reply-To: <019CCE693E457142B37B791721487FD918085329@storexdag01.amd.com>
Sender: owner-linux-mm@kvack.org
To: "Gabbay, Oded" <Oded.Gabbay@amd.com>
Cc: "dpoole@nvidia.com" <dpoole@nvidia.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "peterz@infradead.org" <peterz@infradead.org>, "jweiner@redhat.com" <jweiner@redhat.com>, "mhairgrove@nvidia.com" <mhairgrove@nvidia.com>, "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "j.glisse@gmail.com" <j.glisse@gmail.com>, "Bridgman, John" <John.Bridgman@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Lewycky, Andrew" <Andrew.Lewycky@amd.com>, "sgutti@nvidia.com" <sgutti@nvidia.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "hpa@zytor.com" <hpa@zytor.com>, "aarcange@redhat.com" <aarcange@redhat.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "riel@redhat.com" <riel@redhat.com>, "arvindg@nvidia.com" <arvindg@nvidia.com>, SCheung@nvidia.com
List-Id: iommu@lists.linux-foundation.org

On Sun, Jul 06, 2014 at 07:25:18PM +0000, Gabbay, Oded wrote:
> Once we can agree on that, than I think we can agree that kfd and hmm
> can and should be bounded to mm struct and not file descriptors.

The file descriptor concept is the way it works in the rest of the
kernel. It works for numerous drivers and subsystems (KVM, VFIO, UIO,
...), when you close a file descriptor handed out from any of those
drivers (already in the kernel) all related resources will be freed. I
don't see a reason why HSA drivers should break these expectations and
be different.


	Joerg


--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
