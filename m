From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [GIT PULL] iommu/arm-smmu: Updates for 4.20
Date: Mon, 1 Oct 2018 17:32:07 +0200
Message-ID: <20181001153207.GA27372@8bytes.org>
References: <20181001142706.GB9716@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20181001142706.GB9716@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Will Deacon <will.deacon@arm.com>
Cc: iommu@lists.linux-foundation.org, robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org
List-Id: iommu@lists.linux-foundation.org

Hi Will,

On Mon, Oct 01, 2018 at 03:27:06PM +0100, Will Deacon wrote:
> Please pull these Arm SMMU updates for 4.20. The big thing here is the
> long-awaited "lazy" invalidation mode, using the generic timer-based
> infrastructure for moving TLB invalidation out of the fast-path. Thanks
> to Zhen Lei for the initial work here, and to Robin for getting it into
> shape for upstream.

I am glad to see this used on ARM now too :)

> The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:
> 
>   Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git for-joerg/arm-smmu/updates

Pulled, thanks.


Regards,

	Joerg
