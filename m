From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] iommu/amd: Fix schedule-while-atomic BUG in initialization
 code
Date: Wed, 26 Jul 2017 15:23:37 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1707261523120.2186@nanos>
References: <20170725135618.hev4vj7w24gm3a5q@shodan.usersys.redhat.com> <alpine.DEB.2.20.1707261241220.2186@nanos> <20170726122614.GP15833@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170726122614.GP15833@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: Artem Savkov <asavkov@redhat.com>, iommu@lists.linux-foundation.org, x86@kernel.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Wed, 26 Jul 2017, Joerg Roedel wrote:
> Yes, that should fix it, but I think its better to just move the
> register_syscore_ops() call to a later initialization step, like in the
> patch below. I tested it an will queue it to my iommu/fixes branch.

Fair enough. Acked-by-me.
