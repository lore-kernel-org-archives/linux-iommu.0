From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH] iommu/amd: Fix schedule-while-atomic BUG in
 initialization code
Date: Wed, 26 Jul 2017 15:41:35 +0200
Message-ID: <20170726134135.GA21502@8bytes.org>
References: <20170725135618.hev4vj7w24gm3a5q@shodan.usersys.redhat.com>
 <alpine.DEB.2.20.1707261241220.2186@nanos>
 <20170726122614.GP15833@8bytes.org>
 <20170726132505.cw4xmstcrbmuduyz@shodan.usersys.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170726132505.cw4xmstcrbmuduyz@shodan.usersys.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Artem Savkov <asavkov@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, iommu@lists.linux-foundation.org, x86@kernel.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Wed, Jul 26, 2017 at 03:25:05PM +0200, Artem Savkov wrote:
> On Wed, Jul 26, 2017 at 02:26:14PM +0200, Joerg Roedel wrote:
> > Yes, that should fix it, but I think its better to just move the
> > register_syscore_ops() call to a later initialization step, like in the
> > patch below. I tested it an will queue it to my iommu/fixes branch.
> 
> Checked it as well just in case, didn't see any issues. Thank you.
> 
> Reported-and-tested-by: Artem Savkov <asavkov@redhat.com>

Thanks for testing it! I added your's and Thomas' tags and applied the
patch to my tree. It should go upstream this week.


	Joerg
